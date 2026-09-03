package com.mmu.web.config;

import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.MultipartException;

/**
 * Answers failed file uploads with JSON, and logs them.
 *
 * <p><b>Why this exists.</b> Multipart parsing happens in
 * {@code DispatcherServlet.checkMultipart()}, which runs <i>before</i> handler
 * mapping. When it throws, no handler is ever resolved, so
 * {@link RequestLoggingInterceptor} never runs and the request produces no
 * {@code event=http_request} line. Spring's own logging is a no-op in this
 * application (log4j-api without log4j-core, slf4j-api without a binding), so
 * the exception was not recorded anywhere either. The net effect was a bare 500
 * with an empty log — an upload that was too large failed completely silently,
 * and the browser's only clue was jQuery's error handler.
 *
 * <p>A plain {@code @ControllerAdvice} with no selectors is deliberate: Spring
 * only consults advice beans whose type predicate accepts a {@code null}
 * handler type, and that is exactly the case here, because there is no handler.
 * Narrowing this with {@code basePackages} would stop it being applied.
 *
 * <p>Note this covers the application's own limit only. A reverse proxy that
 * enforces its own body size answers before the request reaches Tomcat, so
 * those rejections cannot be logged here — the client sees the proxy's 413.
 */
@ControllerAdvice
public class MultipartExceptionHandler {

	/** Same logger as the request log, so upload failures land beside the requests they belong to. */
	private static final Logger LOG = Logger.getLogger("com.mmu.request");

	@ExceptionHandler(MultipartException.class)
	public ResponseEntity<String> handleMultipartException(MultipartException ex, HttpServletRequest request) {

		boolean tooLarge = ex instanceof MaxUploadSizeExceededException;
		HttpStatus status = tooLarge ? HttpStatus.PAYLOAD_TOO_LARGE : HttpStatus.BAD_REQUEST;

		long limit = tooLarge ? ((MaxUploadSizeExceededException) ex).getMaxUploadSize() : -1L;
		long sent = request.getContentLengthLong();

		String message;
		if (tooLarge) {
			message = "The upload is too large"
					+ (sent > 0 ? " (" + mb(sent) + ")" : "")
					+ (limit > 0 ? ". The maximum accepted for one save is " + mb(limit) : "")
					+ ". Save with fewer files at a time.";
		} else {
			message = "The uploaded file could not be read. Please try again.";
		}

		StringBuilder sb = new StringBuilder(200);
		sb.append("event=upload_failed");
		append(sb, "app", "MMUWeb");
		append(sb, "req_id", request.getHeader(RequestLoggingInterceptor.HEADER_REQUEST_ID));
		append(sb, "method", request.getMethod());
		append(sb, "path", request.getRequestURI());
		append(sb, "status", String.valueOf(status.value()));
		append(sb, "content_length", String.valueOf(sent));
		append(sb, "max_upload_size", limit > 0 ? String.valueOf(limit) : null);
		append(sb, "user", currentUser(request));
		append(sb, "client", clientIp(request));
		append(sb, "error", ex.getClass().getSimpleName());
		append(sb, "error_msg", ex.getMessage());
		LOG.log(Level.SEVERE, sb.toString());

		// Shape matches what the browser helpers already read off an error response.
		JSONObject body = new JSONObject();
		body.put("status", 0);
		body.put("err_mssg", message);

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		return new ResponseEntity<String>(body.toString(), headers, status);
	}

	private static String mb(long bytes) {
		return String.format("%.1f MB", bytes / (1024.0 * 1024.0));
	}

	/** Never creates a session: an upload that failed this early must not allocate one. */
	private static String currentUser(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session == null) {
			return null;
		}
		Object userId = session.getAttribute("userId");
		if (userId == null) {
			userId = session.getAttribute("user_id");
		}
		return userId == null ? null : userId.toString();
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
		boolean needsQuote = value.indexOf(' ') >= 0 || value.indexOf('"') >= 0;
		if (!needsQuote) {
			sb.append(value);
			return;
		}
		sb.append('"').append(value.replace("\\", "\\\\").replace("\"", "\\\"")).append('"');
	}
}