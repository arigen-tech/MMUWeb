package com.mmu.web.utils;

import java.util.logging.Level;
import java.util.logging.Logger;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

import com.mmu.web.config.RequestLoggingInterceptor;

public class RestUtils {

	private static final Logger LOG = Logger.getLogger("com.mmu.upstream");


	/**
	 * Builds the RestTemplate used for the MMUWeb -> MMUServices hop, with
	 * timeouts.
	 *
	 * <p>A plain {@code new RestTemplate()} has <b>no read timeout at all</b>, so a
	 * call that never gets a reply blocks its Tomcat thread forever. That is not
	 * hypothetical: both applications share one Tomcat, so every browser request
	 * occupies two threads — one for MMUWeb and one for MMUServices. Once MMUWeb
	 * holds all {@code maxThreads} (200 by default), no thread is left to serve the
	 * MMUServices side, every waiting thread waits on a reply that can never be
	 * produced, and the JVM deadlocks with 0% CPU and nothing in the log. A stress
	 * run reproduced exactly that: 200 of 200 workers parked in
	 * {@code postWithHeaders}, zero serving MMUServices, no recovery without a
	 * restart.
	 *
	 * <p>A timeout does not prevent thread starvation — only removing the HTTP hop
	 * does that (see docs/phase1-war-merge-checklist.md). What it does is make the
	 * condition <b>survivable</b>: threads are released instead of parked forever,
	 * so the application degrades and recovers rather than hanging.
	 *
	 * <p>On timeout Spring raises {@code ResourceAccessException}, which the
	 * existing {@code catch (Exception e)} in each method below already converts to
	 * the standard {@code EXP102} error body. Callers therefore see a response shape
	 * they already handle — this introduces no new failure mode.
	 *
	 * <p>Defaults: 120s read, 10s connect. Measured against 37,184 successful
	 * internal calls, the slowest was 50.7s (getResultUpdateWaitingList, under
	 * stress) and none exceeded 60s, so 120s leaves better than 2x headroom over
	 * the worst legitimate case. Override with
	 * {@code -Dmmu.rest.readTimeoutMillis=...} / {@code -Dmmu.rest.connectTimeoutMillis=...}
	 * if a slower environment needs it.
	 */
	private static RestTemplate newRestTemplate() {
		return newRestTemplate(intProp("mmu.rest.readTimeoutMillis", 120000));
	}

	/**
	 * Read timeout for the MIS register exports, which are the one family of calls
	 * the 120s default is genuinely too short for. {@code asp_labour_register}
	 * aggregates every visit since 2023-03-11 on each run and was measured at 91s
	 * in the database alone, before JSON assembly, transfer and the Excel build --
	 * so the default gave it under 30s of headroom and a Labour Beneficiary export
	 * died on {@code SocketTimeoutException} at 120.2s.
	 *
	 * <p>Deliberately a separate knob rather than a raise of the global default:
	 * every other endpoint is a user-facing screen where 120s already means
	 * something is wrong, and the timeout is what keeps a stuck upstream from
	 * parking Tomcat threads. Only the exports, which the user starts knowingly
	 * and watches through the progress dialog, get the longer leash.
	 */
	private static final String EXPORT_READ_TIMEOUT_KEY = "mmu.rest.exportReadTimeoutMillis";

	private static RestTemplate newRestTemplate(int readTimeoutMillis) {
		SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
		factory.setConnectTimeout(intProp("mmu.rest.connectTimeoutMillis", 10000));
		factory.setReadTimeout(readTimeoutMillis);
		return new RestTemplate(factory);
	}

	private static int intProp(String key, int fallback) {
		try {
			String value = System.getProperty(key);
			return (value == null || value.trim().isEmpty()) ? fallback : Integer.parseInt(value.trim());
		} catch (Exception e) {
			return fallback;
		}
	}

	/**
	 * Forwards the current request id to MMUServices so one user action appears as
	 * a single traceable request rather than two unrelated ones. Applied only to
	 * these internal calls; MMUServices' own RestUtils talks to third parties and
	 * deliberately does not propagate internal correlation ids outside the estate.
	 *
	 * <p>No-op outside a request (scheduled jobs), and never overwrites an id a
	 * caller has already set.
	 */
	private static void addRequestId(MultiValueMap<String, String> headers) {
		try {
			if (headers == null || headers.containsKey(RequestLoggingInterceptor.HEADER_REQUEST_ID)) {
				return;
			}
			String requestId = RequestLoggingInterceptor.currentRequestId();
			if (requestId != null && !requestId.isEmpty()) {
				headers.add(RequestLoggingInterceptor.HEADER_REQUEST_ID, requestId);
			}
		} catch (Exception e) {
			// tracing must never break the call it is tracing
		}
	}

	public static String getWithHeaders(String url, MultiValueMap<String, String> headers) {
		try {
			addRequestId(headers);
			RestTemplate restTemplate = newRestTemplate();
			restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
			HttpEntity<?> request = new HttpEntity<>(headers);
			ResponseEntity<String> responseEntity = (ResponseEntity<String>) restTemplate.exchange(url, HttpMethod.GET,
					request, String.class, HttpStatus.OK);
			if (responseEntity.getStatusCode() == HttpStatus.OK) {
				String reSponse = responseEntity.getBody();
				return reSponse;
			}
		} catch (HttpStatusCodeException exception) {
			int statusCode = exception.getStatusCode().value();
			String getMssg = exception.getMessage();
			String getStatustext = exception.getStatusText();
			// logger.info("Exception in hitToWalletApi Api:" + statusCode + "|" + getMssg +
			// "|" + getStatustext);
			return ProjectUtils.getErrorMssg(0, "EXP101", getMssg);
		} catch (Exception e) {
			e.printStackTrace();
			// logger.info("Exception in calling hitToWalletApi api.."+e.toString());
			return ProjectUtils.getErrorMssg(0, "EXP102", "Error in processing request !");
		}
		return "";
	}

	public static String postWithHeaders(String url, MultiValueMap<String, String> requestHeaders,
			String requestPayload) {
		return postWithHeaders(url, requestHeaders, requestPayload,
				intProp("mmu.rest.readTimeoutMillis", 120000));
	}

	/**
	 * Same call with the read timeout raised for the MIS register exports.
	 * See {@link #EXPORT_READ_TIMEOUT_KEY}.
	 */
	public static String postWithHeadersForExport(String url, MultiValueMap<String, String> requestHeaders,
			String requestPayload) {
		return postWithHeaders(url, requestHeaders, requestPayload,
				intProp(EXPORT_READ_TIMEOUT_KEY, 600000));
	}

	public static String postWithHeaders(String url, MultiValueMap<String, String> requestHeaders,
			String requestPayload, int readTimeoutMillis) {
		try {
			addRequestId(requestHeaders);

			RestTemplate restTemplate = newRestTemplate(readTimeoutMillis);
			restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
			requestHeaders.add("Content-Type", MediaType.APPLICATION_JSON_VALUE);
			HttpEntity<?> request = new HttpEntity<>(requestPayload.toString(), requestHeaders);
			String response = restTemplate.postForObject(url, request, String.class);
			ResponseEntity<String> responseEntity = new ResponseEntity<>(response, HttpStatus.OK);
			if (responseEntity.getStatusCode() == HttpStatus.OK) {
				String reSponse = responseEntity.getBody();
				return reSponse;
			}
		} catch (HttpStatusCodeException exception) {
			int statusCode = exception.getStatusCode().value();
			String getMssg = exception.getMessage();
			String getStatustext = exception.getStatusText();
			logUpstreamFailure(url, exception, readTimeoutMillis);
			return ProjectUtils.getErrorMssg(0, "EXP101", getMssg);
		} catch (Exception e) {
			// The returned envelope says only "Error in processing request !", which
			// tells a caller nothing -- and callers that index the expected key then
			// report a missing-key error for what was really a read timeout. The
			// swallow stays (every proxy endpoint depends on it) but the real cause
			// is now on the record.
			logUpstreamFailure(url, e, readTimeoutMillis);
			return ProjectUtils.getErrorMssg(0, "EXP102", "Error in processing request !");
		}
		return "";
	}

	/**
	 * One structured line naming the endpoint and the actual failure, so a timeout
	 * is identifiable without reading a stack trace. Matches the logfmt used by
	 * RequestLoggingInterceptor, and joins to it on req_id.
	 */
	private static void logUpstreamFailure(String url, Exception e) {
		logUpstreamFailure(url, e, intProp("mmu.rest.readTimeoutMillis", 120000));
	}

	/**
	 * @param readTimeoutMillis the timeout this particular call actually ran with,
	 *        so a call using the longer export leash does not report the default
	 *        and send the next reader chasing the wrong number.
	 */
	private static void logUpstreamFailure(String url, Exception e, int readTimeoutMillis) {
		Throwable root = e;
		while (root.getCause() != null && root.getCause() != root) {
			root = root.getCause();
		}
		boolean timedOut = root instanceof java.net.SocketTimeoutException;
		String reqId = RequestLoggingInterceptor.currentRequestId();
		LOG.log(Level.SEVERE, "event=upstream_call_failed app=MMUWeb"
				+ (reqId == null ? "" : " req_id=" + reqId)
				+ " url=" + url
				+ " timed_out=" + timedOut
				+ (timedOut ? " read_timeout_ms=" + readTimeoutMillis : "")
				+ " error=" + root.getClass().getSimpleName()
				+ " error_msg=\"" + String.valueOf(root.getMessage()).replace('"', '\'') + "\"");
		e.printStackTrace();
	}

	public static String puttWithHeaders(String url, MultiValueMap<String, String> requestHeaders,
			String requestPayload) {
		try {
			addRequestId(requestHeaders);
			RestTemplate restTemplate = newRestTemplate();
			restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
			requestHeaders.add("Content-Type", MediaType.APPLICATION_JSON_VALUE);
			HttpEntity<?> request = new HttpEntity<>(requestPayload.toString(), requestHeaders);
			ResponseEntity<String> responseEntity = restTemplate.exchange(url, HttpMethod.PUT, request, String.class);
			// ResponseEntity<String> responseEntity = new ResponseEntity<>(response,
			// HttpStatus.OK);
			if (responseEntity.getStatusCode() == HttpStatus.OK) {
				String reSponse = responseEntity.getBody();
				return reSponse;
			}
		} catch (HttpStatusCodeException exception) {
			int statusCode = exception.getStatusCode().value();
			String getMssg = exception.getMessage();
			String getStatustext = exception.getStatusText();
			// logger.info("Exception in hitToWalletApi Api:" + statusCode + "|" + getMssg +
			// "|" + getStatustext);
			return ProjectUtils.getErrorMssg(0, "EXP101", getMssg);
		} catch (Exception e) {
			e.printStackTrace();
			// logger.info("Exception in calling hitToWalletApi api.."+e.toString());
			return ProjectUtils.getErrorMssg(0, "EXP102", "Error in processing request !");
		}
		return "";
	}

	private static JSONObject processFailData(int statusCod, String msg) {
		try {
			String status_cd = "0";
			int statusCode = statusCod;
			String mssg = msg;
			return new JSONObject().put("status_cd", status_cd).put("status", statusCode).put("err_mssg", mssg);
		} catch (Exception e) {
		}
		return null;

	}

	private static JSONObject resPonseSuccessData(JSONObject responseEntity) {
		try {
			String status_cd = responseEntity.optString("status_cd");
			String data = responseEntity.optString("data");
			String rek = responseEntity.optString("rek");
			String hmac = responseEntity.optString("hmac");
			return new JSONObject().put("status_cd", status_cd).put("data", data).put("rek", rek).put("hmac", hmac);
		} catch (Exception e) {
		}
		return null;
	}

	public static void main(String[] args) throws JSONException {
		String json = "{\n" + "  \"status_cd\": \"1\",\n"
				+ "  \"data\": \"eyJzdGpDZCI6IiIsImR0eSI6IlJlZ3VsYXIiLCJsZ25tIjoiU1VHQUwgQU5EIERBTUFOSSBVVElMSVRZIFNFUlZJQ0VTIFBSSVZBVEUgTElNSVRFRCIsImFkYWRyIjpbXSwiY3hkdCI6IiIsImdzdGluIjoiMDNBQUlDUzIyNzRCMVpTIiwibmJhIjpbIlNlcnZpY2UgUHJvdmlzaW9uIl0sImxzdHVwZHQiOiIxOC8wNC8yMDE4IiwiY3RiIjoiUHJpdmF0ZSBMaW1pdGVkIENvbXBhbnkiLCJyZ2R0IjoiMDEvMDcvMjAxNyIsInByYWRyIjp7ImFkZHIiOnsiYm5tIjoiIiwibG9jIjoiQ0xPQ0sgVE9XRVIgTFVESElBTkEiLCJzdCI6IlNBTlQgREFTUyBTVFJFRVQiLCJibm8iOiIxNTU1IiwiZHN0IjoiIiwic3RjZCI6IlB1bmphYiIsImNpdHkiOiIiLCJmbG5vIjoiMk5EIEZMT09SIiwibHQiOiIiLCJwbmNkIjoiMTQxMDA4IiwibGciOiIifSwibnRyIjoiU2VydmljZSBQcm92aXNpb24ifSwic3RzIjoiQWN0aXZlIiwiY3RqQ2QiOiJaRDAyMDEiLCJ0cmFkZU5hbSI6IlNVR0FMIEFORCBEQU1JTkkgVVRJTElUWSBTRVJWSUNFUyBQUklWQVRFIExJTUlURUQiLCJjdGoiOiJSQU5HRS1JIn0=\",\n"
				+ "  \"rek\": \"\",\n" + "  \"hmac\": \"\"\n" + "}";
		JSONObject response = new JSONObject(json);
		System.out.println(response.optString("status_cd"));
	}

}
