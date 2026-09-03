<%--
  Reusable progress dialog for long report downloads.

  WHY
    A plain navigation download gives the browser nothing to show. The MIS
    registers and the wider Jasper reports run for minutes -- asp_labour_register
    alone spends ~91s in the database re-aggregating every visit since 2023-03-11
    -- so the screen looks frozen, and users press the button again and start a
    second query on top of the first.

  USE
    1. Include once, immediately before </body>:
         <%@include file="..//view/reportProgressDialog.jsp"%>
    2. Call it from the button handler instead of setting window.location.href:

         ReportProgress.start({
             url:     '${pageContext.request.contextPath}/mis/exportExcelMMSSYInfo'
                        + '?campDate=' + campDate + '&districtId=' + districtId,
             title:   'Generating MMSSY Information Register',
             details: [ { label: 'Camp date', value: campDate } ],
             hint:    'Reading data (this step takes about 1.5 minutes)'
         });

    The server side needs one thing: read the runId parameter and register it.
    For the MIS exports MISExportSupport.tracked() already does that, so wiring a
    new export up is a call here and a call there.

  OPTIONS
    url       required, without runId -- it is appended, with ? or & as needed
    title     dialog heading
    details   [{label, value}] rows describing what was asked for
    hint      wording for the long stage; defaults to a generic message
    prefix    runId prefix, for readable log lines (default 'rpt')
    filename  when set, saves via an <a download> instead of navigating. Use for
              responses served inline (PDF); omit when the server already sends
              Content-Disposition: attachment, as the Excel views do.
    cancelable  offer a Cancel button. Only set this where the server can really
              abort the query: the Jasper path holds the Statement in MMUWeb, and
              the MIS exports are forwarded to MMUServices' ExportRunRegistry,
              which holds theirs. Never set it where cancelling would only hide
              the dialog -- a button that lies is worse than no button.

  Requires jQuery and .cus-backdrop from modelWindowForReportsMultiple.jsp.
--%>
<div id="rptProgressDialog" style="display:none; position:fixed; z-index:1060; top:50%; left:50%;
     transform:translate(-50%,-50%); width:min(90%,520px); background:#fff; border-radius:6px;
     box-shadow:0 6px 28px rgba(0,0,0,.3); padding:22px 24px;">

  <h4 id="rptProgressTitle" style="margin:0 0 4px 0;">Generating report</h4>
  <p style="margin:0 0 16px 0; color:#666; font-size:13px;">
     Please keep this tab open. The file will download automatically when it is ready.
  </p>

  <table id="rptProgressDetails" style="width:100%; font-size:13px; margin-bottom:14px;"></table>

  <table style="width:100%; font-size:13px; background:#f6f8fa; border-radius:4px; padding:8px;">
    <tr><td style="padding:3px 6px; color:#666; width:42%;">Status</td>
        <td><strong id="rptProgressStage">Starting</strong></td></tr>
    <tr><td style="padding:3px 6px; color:#666;">Rows read</td>
        <td id="rptProgressRows">-</td></tr>
    <tr><td style="padding:3px 6px; color:#666;">Elapsed</td>
        <td id="rptProgressElapsed">0s</td></tr>
  </table>

  <p id="rptProgressNote" style="margin:12px 0 0 0; font-size:12px; color:#a15c00;"></p>

  <div style="margin-top:18px; text-align:right;">
    <button type="button" id="rptProgressButton" class="btn btn-primary" disabled>Please wait...</button>
  </div>
</div>

<script type="text/javascript">
var ReportProgress = (function () {
	var $q = jQuery;
	var ctx = '${pageContext.request.contextPath}';

	var runId = null;
	var timer = null;
	var opts = {};

	function newRunId(prefix) {
		return (prefix || 'rpt') + '-' + Date.now() + '-' + Math.floor(Math.random() * 1000000);
	}

	function esc(text) {
		return $q('<div/>').text(text === undefined || text === null ? '' : text).html();
	}

	function start(options) {
		opts = options || {};
		if (!opts.url) {
			return false;
		}
		runId = newRunId(opts.prefix);

		render();

		// The response IS the file and cannot carry a handle back, so the runId
		// goes out on the URL and the server registers it under that key.
		var url = opts.url + (opts.url.indexOf('?') === -1 ? '?' : '&')
				+ 'runId=' + encodeURIComponent(runId);

		// Always an anchor, never window.location.href. Assigning to location is a
		// navigation, so the browser fires the beforeunload guard below and asks
		// "Leave site?" before it has any idea the response is an attachment --
		// which stopped the MIS Excel exports from being requested at all. An
		// <a download> click is not a navigation, so nothing prompts.
		//
		// download also forces save-as on a same-origin URL whatever the server's
		// Content-Disposition says, and unlike opening it in a viewer a very large
		// file will not freeze the tab. Left empty when no filename is given, so
		// the browser takes the name from Content-Disposition as before.
		var link = document.createElement('a');
		link.href = url;
		link.download = opts.filename || '';
		link.style.display = 'none';
		document.body.appendChild(link);
		link.click();
		document.body.removeChild(link);

		startPolling();
		return true;
	}

	function render() {
		$q('#rptProgressTitle').text(opts.title || 'Generating report');

		var rows = '';
		var details = opts.details || [];
		for (var i = 0; i < details.length; i++) {
			rows += '<tr><td style="padding:3px 0; color:#666; width:42%;">'
					+ esc(details[i].label) + '</td><td>' + esc(details[i].value) + '</td></tr>';
		}
		$q('#rptProgressDetails').html(rows);

		$q('#rptProgressStage').text('Starting');
		$q('#rptProgressRows').text('-');
		$q('#rptProgressElapsed').text('0s');
		$q('#rptProgressNote').text('');

		if (opts.cancelable) {
			$q('#rptProgressButton').prop('disabled', false).text('Cancel report')
				.removeClass('btn-primary').addClass('btn-danger')
				.off('click').on('click', cancel);
		} else {
			$q('#rptProgressButton').prop('disabled', true).text('Please wait...')
				.removeClass('btn-danger').addClass('btn-primary')
				.off('click');
		}

		$q('#rptProgressDialog').show();
		$q('.cus-backdrop').show();
	}

	function hide() {
		stopPolling();
		runId = null;
		$q('#rptProgressDialog').hide();
		$q('.cus-backdrop').hide();
	}

	function startPolling() {
		stopPolling();
		timer = setInterval(poll, 2000);
	}

	function stopPolling() {
		if (timer !== null) {
			clearInterval(timer);
			timer = null;
		}
	}

	function asCloseButton() {
		$q('#rptProgressButton').prop('disabled', false).text('Close')
			.removeClass('btn-danger').addClass('btn-primary')
			.off('click').on('click', hide);
	}

	function poll() {
		if (runId === null) {
			stopPolling();
			return;
		}
		$q.ajax({
			url: ctx + '/report/reportRunStatus',
			data: { runId: runId },
			dataType: 'json',
			cache: false,
			success: function (s) {
				if (!s || s.found !== true) {
					// Left the registry: finished, cancelled, or the browser is
					// still taking bytes. Nothing more to report either way, so stop
					// polling but leave the dialog for the user to dismiss -- the
					// download continues on its own.
					stopPolling();
					$q('#rptProgressStage').text('Finishing');
					$q('#rptProgressNote').text('The report has finished generating. '
							+ 'If the download has not started yet, it will begin shortly.');
					asCloseButton();
					return;
				}
				$q('#rptProgressStage').text(stageLabel(s.stage));
				// -1 means not counted yet: the MIS exports cannot know the row
				// count until the whole response is back.
				$q('#rptProgressRows').text(s.rows < 0 ? '-' : Number(s.rows).toLocaleString());
				$q('#rptProgressElapsed').text(Math.round(s.elapsedMs / 1000) + 's');
				if (s.cancelRequested) {
					$q('#rptProgressNote').text('Cancelling...');
				}
			},
			error: function () {
				// A failed poll is not a failed report; keep the dialog and retry.
			}
		});
	}

	function stageLabel(stage) {
		switch (stage) {
			case 'STARTING': return 'Starting';
			case 'LOAD':     return 'Loading report template';
			// The MIS exports spend nearly all their time in one aggregate
			// query, which reports no rows until it completes.
			case 'QUERY':    return 'Running the database query';
			case 'FILL':     return opts.hint || 'Reading data and building the file';
			case 'EXPORT':   return 'Writing the file';
			case 'DONE':     return 'Finishing';
			default:         return stage || 'Working';
		}
	}

	function cancel() {
		if (runId === null) {
			hide();
			return;
		}
		$q('#rptProgressButton').prop('disabled', true).text('Cancelling...');
		$q('#rptProgressNote').text('Asking the database to stop the query...');
		$q.ajax({
			url: ctx + '/report/cancelReportRun',
			type: 'POST',
			data: { runId: runId },
			dataType: 'json',
			complete: function () {
				stopPolling();
				runId = null;
				try {
					window.stop();   // not supported everywhere; the server's 204 covers it
				} catch (e) {
				}
				$q('#rptProgressStage').text('Report cancelled by user');
				$q('#rptProgressNote').text('No file has been downloaded. '
						+ 'You can narrow the filters and generate again.');
				asCloseButton();
			}
		});
	}

	// Leaving the page does not stop the report -- it runs to completion on the
	// server -- but the file is then lost, so warn before that happens. Most
	// browsers ignore custom text and show their own wording; returning a value is
	// what triggers the prompt at all.
	//
	// Deliberately NOT wired to visibilitychange: a user switching tabs during a
	// five minute wait must not be nagged, or worse, have the run cancelled.
	$q(window).on('beforeunload', function () {
		if (runId !== null) {
			return 'A report is still being generated. Leaving this page will not '
				+ 'stop it. Use Cancel report first if you no longer need it.';
		}
	});

	return { start: start, hide: hide, isRunning: function () { return runId !== null; } };
})();
</script>