package com.mmu.web.utils;

import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

/**
 * Small helpers shared by the MIS register exports.
 *
 * <p>These endpoints POST to MMUServices and hand the JSON that comes back to a
 * POI view which indexes the expected key straight away. When the upstream call
 * fails, {@link RestUtils} returns an error envelope
 * ({@code {"status":0,"status_cd":"EXP102","err_mssg":"..."}}) rather than the
 * report, so that indexing raises {@code JSONObject["x_data"] not found} and the
 * user is shown a 500 naming a JSON key -- which says nothing about the read
 * timeout that actually happened. Checking the shape first turns that into a
 * sentence describing the real problem.
 */
public final class MISExportSupport {

	private static final Logger LOG = Logger.getLogger(MISExportSupport.class.getName());

	private MISExportSupport() {
	}

	/** Empty 204 response, used when the user cancelled the export. */
	private static final View NO_CONTENT = new View() {
		public String getContentType() {
			return null;
		}

		public void render(java.util.Map<String, ?> model, javax.servlet.http.HttpServletRequest request,
				javax.servlet.http.HttpServletResponse response) throws Exception {
			response.setStatus(javax.servlet.http.HttpServletResponse.SC_NO_CONTENT);
		}
	};

	/** Fetches the report payload from MMUServices. */
	public interface DataFetch {
		String fetch();
	}

	// ------------------------------------------------------------------
	// Cross-process progress.
	//
	// The query for these exports runs in MMUServices, so this process cannot see
	// the row count and holds no Statement to cancel. MMUServices tracks both
	// under the same runId (ExportRunRegistry there); these entries record which
	// runs have a counterpart to ask, so /report/reportRunStatus and
	// /report/cancelReportRun can forward. Ownership is still checked here, by
	// HMSUtil, before anything is forwarded.
	// ------------------------------------------------------------------

	private static final java.util.concurrent.ConcurrentMap<String, String> REMOTE_RUNS =
			new java.util.concurrent.ConcurrentHashMap<String, String>();

	private static final String BASE_URL = HMSUtil.getProperties("urlextension.properties", "OSB_IP_AND_PORT");

	/** Live status from MMUServices, or null when this run has no counterpart there. */
	public static String remoteStatus(String runId) {
		String base = runId == null ? null : REMOTE_RUNS.get(runId.trim());
		if (base == null) {
			return null;
		}
		try {
			// Deliberately the short default timeout: a status poll that hangs
			// would be worse than one that misses a tick.
			return RestUtils.getWithHeaders(
					base.trim() + "/MMUServices/mis/exportRunStatus?runId="
							+ java.net.URLEncoder.encode(runId.trim(), "UTF-8"),
					new org.springframework.util.LinkedMultiValueMap<String, String>());
		} catch (Exception e) {
			return null;   // a failed poll is not a failed export
		}
	}

	/** Asks MMUServices to abort the query. False when there is nothing to forward to. */
	public static boolean remoteCancel(String runId) {
		String base = runId == null ? null : REMOTE_RUNS.get(runId.trim());
		if (base == null) {
			return false;
		}
		try {
			String body = RestUtils.postWithHeaders(
					base.trim() + "/MMUServices/mis/cancelExportRun?runId="
							+ java.net.URLEncoder.encode(runId.trim(), "UTF-8"),
					new org.springframework.util.LinkedMultiValueMap<String, String>(), "{}");
			return body != null && body.contains("\"cancelled\":true");
		} catch (Exception e) {
			LOG.log(Level.WARNING, "event=export_remote_cancel_failed app=MMUWeb run_id=" + runId, e);
			return false;
		}
	}

	/**
	 * Runs an export with progress reporting, so the browser's dialog has
	 * something to poll, and with a readable failure when the upstream call does
	 * not return report data.
	 *
	 * <p>Adding this to another export is one call:
	 *
	 * <pre>
	 * return MISExportSupport.tracked(request, "MMSSY Information register", "mmssyInfo_data",
	 *         new ExportExcelMMSSYInfo(),
	 *         () -&gt; RestUtils.postWithHeadersForExport(url, headers, payload.toString()));
	 * </pre>
	 *
	 * paired with {@code ReportProgress.start({...})} on the page. The runId comes
	 * off the request, so an export called without one simply tracks nothing and
	 * behaves exactly as before.
	 *
	 * @param dataKey    the key the POI view will index, e.g. {@code labourBeneficiary_data}
	 * @param reportName human-readable name, used in the message the user sees
	 */
	public static ModelAndView tracked(HttpServletRequest request, String reportName, String dataKey,
			View view, DataFetch fetch) {
		String runId = request.getParameter("runId");
		long[] rows = new long[] { -1L };
		HMSUtil.ReportRun run = HMSUtil.beginExportRun(runId, reportName, rows);
		if (runId != null && !runId.trim().isEmpty()) {
			REMOTE_RUNS.put(runId.trim(), BASE_URL);
		}
		try {
			HMSUtil.exportRunStage(run, "FILL");
			String data = fetch.fetch();

			// A cancel aborts the query in MMUServices, so what comes back here is
			// an error envelope. That is the expected outcome of pressing Cancel,
			// not a failure: answer 204 and write nothing. Without this the browser
			// saves the 500 error page under the .xlsx name it was promised.
			if (run != null && run.isCancelRequested()) {
				LOG.info("event=export_cancelled app=MMUWeb report=" + reportName + " run_id=" + runId);
				return new ModelAndView(NO_CONTENT);
			}

			// Only knowable once the response is here, so the dialog shows "-"
			// until this point and a real number afterwards.
			rows[0] = countRows(data, dataKey);
			HMSUtil.exportRunStage(run, "EXPORT");

			failIfNotReportData(data, dataKey, reportName);
			return new ModelAndView(view, "data", data);
		} finally {
			// Before the workbook is written, deliberately: the dialog reads the
			// resulting {"found":false} as "generating finished, download starting",
			// which is exactly where we are.
			HMSUtil.endExportRun(runId);
			if (runId != null && !runId.trim().isEmpty()) {
				REMOTE_RUNS.remove(runId.trim());
			}
		}
	}

	/**
	 * Rows in the report payload, or -1 when the response is not a report at all.
	 * Used only to show progress, so every failure here is silent: a wrong number
	 * in a dialog must never be the reason an export does not run.
	 */
	public static long countRows(String data, String key) {
		try {
			JSONObject outer = new JSONObject(data);
			if (!outer.has(key)) {
				return -1L;
			}
			JSONObject inner = outer.getJSONObject(key);
			if (!inner.has(key)) {
				return 0L;
			}
			JSONArray rows = inner.getJSONArray(key);
			return rows.length();
		} catch (Exception e) {
			return -1L;
		}
	}

	/**
	 * Throws with the upstream's own error text when the response is an error
	 * envelope instead of report data.
	 *
	 * @param reportName human-readable name, used in the message the user sees
	 * @throws IllegalStateException when {@code data} carries no report payload
	 */
	public static void failIfNotReportData(String data, String key, String reportName) {
		if (data == null || data.trim().isEmpty()) {
			LOG.log(Level.SEVERE, "event=export_no_response app=MMUWeb report=" + reportName);
			throw new IllegalStateException(reportName
					+ " could not be generated: no response from the reporting service."
					+ " Please try again, or narrow the date range.");
		}

		String detail = null;
		try {
			JSONObject outer = new JSONObject(data);
			if (outer.has(key)) {
				return;   // the expected payload, whatever else it may contain
			}
			if (outer.has("err_mssg")) {
				detail = outer.optString("status_cd", "") + " " + outer.optString("err_mssg", "");
			}
		} catch (Exception e) {
			// Not JSON at all -- an HTML error page, say. Fall through to the
			// generic message rather than reporting a parse failure at the user.
			detail = null;
		}

		LOG.log(Level.SEVERE, "event=export_upstream_error app=MMUWeb report=" + reportName
				+ " expected_key=" + key
				+ " detail=\"" + String.valueOf(detail).replace('"', '\'') + "\"");

		throw new IllegalStateException(reportName
				+ " could not be generated. The reporting service did not return the data"
				+ " -- this is usually a timeout on a very large range."
				+ (detail == null ? "" : " (" + detail.trim() + ")")
				+ " Please try again, or narrow the date range.");
	}
}