package com.mmu.web.config;

import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.core.env.Environment;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * Emits one structured line per request: which endpoint was called, by whom,
 * how long it took and how it ended.
 *
 * <p><b>Why java.util.logging.</b> Neither application has a working logging
 * framework — MMUServices ships commons-logging alongside spring-jcl (they
 * provide the same classes), and MMUWeb ships log4j-api without log4j-core and
 * slf4j-api without a binding, both of which are no-ops. JUL is always present,
 * Tomcat's JULI routes it correctly, and it needs no new dependency and no
 * resolution of that binding mess first. Levels and destinations stay
 * configurable through Tomcat's {@code logging.properties} without code changes.
 *
 * <p><b>Format.</b> logfmt (key=value), which Loki and Grafana parse natively.
 *
 * <p><b>What is deliberately not logged.</b> Request bodies are never logged,
 * and query strings only when {@code logging.request.includeQuery=true}. This
 * system holds patient records: URLs and payloads routinely carry mobile
 * numbers, UHIDs and patient identifiers, and access logs are typically
 * retained longer and read more widely than the database itself.
 */
public class RequestLoggingInterceptor extends HandlerInterceptorAdapter {

	private static final Logger LOG = Logger.getLogger("com.mmu.request");

	private static final String ATTR_START = RequestLoggingInterceptor.class.getName() + ".start";
	private static final String ATTR_REQUEST_ID = RequestLoggingInterceptor.class.getName() + ".rid";

	/** Propagated so a request can be followed across the MMUWeb -> MMUServices hop. */
	public static final String HEADER_REQUEST_ID = "X-Request-Id";

	private final String appName;
	private final boolean enabled;
	private final boolean includeQuery;
	private final long slowMillis;

	RequestLoggingInterceptor(String appName, Environment env) {
		this.appName = appName;
		this.enabled = Boolean.parseBoolean(env.getProperty("logging.request.enabled", "true").trim());
		this.includeQuery = Boolean.parseBoolean(env.getProperty("logging.request.includeQuery", "false").trim());
		this.slowMillis = Long.parseLong(env.getProperty("logging.request.slowMillis", "2000").trim());
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
		if (!enabled) {
			return true;
		}
		request.setAttribute(ATTR_START, System.nanoTime());

		// Reuse an inbound id when there is one, so a call that arrives from the
		// other application keeps the same identifier end to end.
		String requestId = request.getHeader(HEADER_REQUEST_ID);
		if (requestId == null || requestId.trim().isEmpty()) {
			requestId = UUID.randomUUID().toString().substring(0, 12);
		}
		request.setAttribute(ATTR_REQUEST_ID, requestId);
		response.setHeader(HEADER_REQUEST_ID, requestId);
		return true;
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {
		if (!enabled) {
			return;
		}
		Object start = request.getAttribute(ATTR_START);
		long durationMs = (start instanceof Long) ? (System.nanoTime() - (Long) start) / 1_000_000L : -1L;

		// When an exception is still propagating, the container has not yet set the
		// error status — response.getStatus() still reads 200 even though the client
		// will receive 500. Reporting that verbatim would make every failed request
		// look successful to anything alerting on status.
		int status = response.getStatus();
		if (ex != null && status < 400) {
			status = 500;
		}
		Level level = Level.INFO;
		if (ex != null || status >= 500) {
			level = Level.SEVERE;
		} else if (status >= 400 || (slowMillis > 0 && durationMs >= slowMillis)) {
			level = Level.WARNING;
		}
		if (!LOG.isLoggable(level)) {
			return;
		}

		StringBuilder sb = new StringBuilder(220);
		sb.append("event=http_request");
		append(sb, "app", appName);
		append(sb, "req_id", str(request.getAttribute(ATTR_REQUEST_ID)));
		append(sb, "method", request.getMethod());
		append(sb, "path", request.getRequestURI());
		if (includeQuery && request.getQueryString() != null) {
			append(sb, "query", request.getQueryString());
		}
		append(sb, "handler", describe(handler));
		append(sb, "status", String.valueOf(status));
		append(sb, "duration_ms", String.valueOf(durationMs));
		append(sb, "user", currentUser(request));
		append(sb, "client", clientIp(request));
		if (slowMillis > 0 && durationMs >= slowMillis) {
			append(sb, "slow", "true");
		}
		if (ex != null) {
			append(sb, "error", ex.getClass().getSimpleName());
			append(sb, "error_msg", ex.getMessage());
		}
		LOG.log(level, sb.toString());
	}

	/**
	 * The id of the request being served on this thread, or {@code null} outside a
	 * request (scheduled jobs, startup). Lets outbound calls forward the same id so
	 * one user action is traceable across both applications instead of appearing as
	 * two unrelated requests.
	 */
	public static String currentRequestId() {
		try {
			RequestAttributes attrs = RequestContextHolder.getRequestAttributes();
			if (attrs == null) {
				return null;
			}
			Object rid = attrs.getAttribute(ATTR_REQUEST_ID, RequestAttributes.SCOPE_REQUEST);
			return rid == null ? null : rid.toString();
		} catch (Exception e) {
			return null;   // correlation is never worth failing a request over
		}
	}

	/** Controller and method, which is far more useful than the path when routes overlap. */
	private static String describe(Object handler) {
		if (handler instanceof HandlerMethod) {
			HandlerMethod hm = (HandlerMethod) handler;
			return hm.getBeanType().getSimpleName() + "." + hm.getMethod().getName();
		}
		return handler == null ? "-" : handler.getClass().getSimpleName();
	}

	/**
	 * Never creates a session — calling getSession() here would allocate one for
	 * every anonymous request and quietly change session behaviour.
	 */
	private static String currentUser(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session == null) {
			return "-";
		}
		Object userId = session.getAttribute("userId");
		if (userId == null) {
			userId = session.getAttribute("user_id");
		}
		return userId == null ? "-" : userId.toString();
	}

	private static String clientIp(HttpServletRequest request) {
		String fwd = request.getHeader("X-Forwarded-For");
		if (fwd != null && !fwd.trim().isEmpty()) {
			int comma = fwd.indexOf(',');           // left-most entry is the originating client
			return (comma > 0 ? fwd.substring(0, comma) : fwd).trim();
		}
		return request.getRemoteAddr();
	}

	private static void append(StringBuilder sb, String key, String value) {
		sb.append(' ').append(key).append('=');
		if (value == null || value.isEmpty()) {
			sb.append('-');
			return;
		}
		// Quote only when needed; logfmt parsers split on unquoted spaces.
		boolean needsQuote = value.indexOf(' ') >= 0 || value.indexOf('"') >= 0;
		if (!needsQuote) {
			sb.append(value);
			return;
		}
		sb.append('"').append(value.replace("\\", "\\\\").replace("\"", "\\\"")).append('"');
	}

	private static String str(Object o) {
		return o == null ? null : o.toString();
	}
}