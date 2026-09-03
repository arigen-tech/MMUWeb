package com.mmu.web.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.net.URL;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.time.YearMonth;
import java.time.ZoneId;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
import java.util.Enumeration;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.WriteListener;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import org.json.JSONObject;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.context.request.RequestAttributes;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperPrintManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.fill.JRSwapFileVirtualizer;
import net.sf.jasperreports.engine.query.JRJdbcQueryExecuterFactory;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.engine.util.JRProperties;
import net.sf.jasperreports.engine.util.JRSwapFile;



public class HMSUtil extends ServletRequestUtils {
	
 public static int calculateAgeNoOfYear(Date dob ) {
		 
		 Calendar lCal = Calendar.getInstance();
		    lCal.setTime(dob);
		    int yr=lCal.get(Calendar.YEAR);
		    int mn=lCal.get(Calendar.MONTH) + 1;
		    int dt=lCal.get(Calendar.DATE);
		    LocalDate today = LocalDate.now();
		    
		//System.out.println("today"+today);//Today's date
		LocalDate birthday = LocalDate.of(yr,mn,dt) ; //Birth date
		//System.out.println("birthday"+birthday);
		Period p = Period.between(birthday, today);
		//System.out.println("Period : "+p);
		return p.getYears();
	 }
 
 
 public static String getProperties(String fileName, String propName){
		String propertyValue = null;
		try{
			URL resourcePath = Thread.currentThread().getContextClassLoader()
					.getResource(fileName);
			Properties properties= new Properties();
			properties.load(resourcePath.openStream());
			propertyValue = properties.getProperty(propName);
		}catch(Exception e){e.printStackTrace();}
		return propertyValue;
	}
 

	public static Box getBox(HttpServletRequest request) {
		Box box = new Box("requestbox");
		Enumeration e = request.getParameterNames();
		while (e.hasMoreElements()) {
			String key = (String) e.nextElement();
			box.put(key, request.getParameterValues(key));
		}
		return box;
	}
 public synchronized static void generateReport(String jasper_filename, String actualFileName, Map parameters,
			Connection conn, HttpServletResponse response,
			ServletContext context) {
		byte bytes[] = null;
		try {
			bytes = JasperRunManager.runReportToPdf(getCompiledReport(context,
					jasper_filename), parameters, conn);
			
			    
			if(!conn.isClosed())
			conn.close();
		} catch (JRException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		response.setHeader("Content-Disposition", "attachment; filename="
				+ actualFileName + ".pdf");
		response.setContentLength(bytes.length);
		ServletOutputStream ouputStream;
		try {
			ouputStream = response.getOutputStream();
			ouputStream.write(bytes, 0, bytes.length);
			ouputStream.flush();
			ouputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
 public static JasperReport getCompiledReport(ServletContext context,
			String fileName) throws JRException {
		File reportFile = new File(context.getRealPath("/reports/" + fileName
				+ ".jasper"));
		JasperReport jasperReport = (JasperReport) JRLoader.loadObject(reportFile.getPath());
		return jasperReport;
	}
 
 
 public static Date dateFormatteryyyymmdd(String stringDate) throws Exception {
		SimpleDateFormat dateFormatterYYYYMMDD = new SimpleDateFormat("yyyy-MM-dd");
		try {
			return (dateFormatterYYYYMMDD.parse(stringDate));
		} catch (ParseException e) {
			e.printStackTrace();
			throw e;			
		}
		
	}
 
 public static Date convertStringTypeDateToDateType(String date) {
		Date orderDateTime = null;

		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		if (date != null) {
			try {
				orderDateTime = df.parse(date);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}

		return orderDateTime;
	}
 
 public static void generateReportDirectPrint(String jasper_filename, Map parameters,
			Connection conn, HttpServletResponse response,
			ServletContext context) {
		byte bytes[] = null;
		try {
		/*	bytes = JasperRunManager.runReportToPdf(getCompiledReport(context,
					jasper_filename), parameters, conn);*/
			
			    JasperPrint jp = JasperFillManager.fillReport(getCompiledReport(context,
						jasper_filename), parameters, conn);
			    JasperPrintManager.printReport(jp,false);
			    /*JasperViewer.viewReport(jp, false);*/
			    
			if(!conn.isClosed())
			conn.close();
		} catch (JRException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		/*response.setHeader("Content-Disposition", "attachment; filename="
				+ jasper_filename + ".pdf");
		response.setContentLength(bytes.length);
		ServletOutputStream ouputStream;*/
	/*	try {
			ouputStream = response.getOutputStream();
			ouputStream.write(bytes, 0, bytes.length);
			ouputStream.flush();
			ouputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
*/
	}
	
	public static JasperPrint generateReportDirectPrintClientSide(String jasper_filename, Map parameters,
			Connection conn, HttpServletResponse response,
			ServletContext context) {
		byte bytes[] = null;
		JasperPrint jp = new JasperPrint();
		try {
		/*	bytes = JasperRunManager.runReportToPdf(getCompiledReport(context,
					jasper_filename), parameters, conn);*/
			
			    jp = JasperFillManager.fillReport(getCompiledReport(context,
						jasper_filename), parameters, conn);
			   /* JasperPrintManager.printReport(jp,false);*/
			    /*JasperViewer.viewReport(jp, false);*/
			    
			if(!conn.isClosed())
			conn.close();
		} catch (JRException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		/*response.setHeader("Content-Disposition", "attachment; filename="
				+ jasper_filename + ".pdf");
		response.setContentLength(bytes.length);
		ServletOutputStream ouputStream;*/
	/*	try {
			ouputStream = response.getOutputStream();
			ouputStream.write(bytes, 0, bytes.length);
			ouputStream.flush();
			ouputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
*/
		return jp;
	}
 
 
	
	public static String calculateAgeYearOrMonthOrDays(Date birthDate) {
		 // get todays date
		 Calendar now = Calendar.getInstance();
		 // get a calendar representing their birth date

		 Calendar cal = Calendar.getInstance();
		 cal.setTime(birthDate);

		 // calculate age as the difference in years.
		 @SuppressWarnings("unused")
		 int calculatedDays, calculatedMonth, calculatedYear;
		 int currentDays = now.get(Calendar.DATE);
		 int birthDays = cal.get(Calendar.DATE);
		 int currentMonth = now.get(Calendar.MONTH);
		 int birthMonth = cal.get(Calendar.MONTH);
		 int currentYear = now.get(Calendar.YEAR);
		 int birthYear = cal.get(Calendar.YEAR);
		 

		 if (currentDays < birthDays) {
		  currentDays = currentDays + 30;
		  calculatedDays = currentDays - birthDays;
		  currentMonth = currentMonth - 1;
		 } else {
		  calculatedDays = currentDays - birthDays;
		 }

		 if (currentMonth < birthMonth) {
		  currentMonth = currentMonth + 12;
		  calculatedMonth = currentMonth - birthMonth;
		  currentYear = currentYear - 1;
		 } else {
		  calculatedMonth = currentMonth - birthMonth;
		 }

		 int age = currentYear - birthYear;
		 String patientAge = "";

		 if (age == 0 && calculatedMonth != 0 && calculatedDays != 0) {
		  patientAge = calculatedMonth + " Months ";
		 } else if (age == 0 && calculatedMonth == 0 && calculatedDays != 0) {
		  patientAge = calculatedDays + "  Days";
		 } 
		 else if (age == 0 && calculatedMonth != 0 && calculatedDays == 0) {
		  patientAge = calculatedMonth + " Months ";
		 }
		 else if (age == 0 && calculatedMonth == 0 && calculatedDays == 0) {
		  patientAge = "1 Days";
		 }
		 else {
		  patientAge = age + " Years ";
		 }
		 return patientAge;
		}
	
	
public static String calculateAge(Date birthDate) {
		
		int years = 0;
	    int months = 0;
	    int days = 0;

	    //create calendar object for birth day
	    Calendar birthDay = Calendar.getInstance();
	    birthDay.setTimeInMillis(birthDate.getTime());

	    //create calendar object for current day
	    long currentTime = System.currentTimeMillis();
	    Calendar now = Calendar.getInstance();
	    now.setTimeInMillis(currentTime);

	    //Get difference between years
	    years = now.get(Calendar.YEAR) - birthDay.get(Calendar.YEAR);
	    int currMonth = now.get(Calendar.MONTH) + 1;
	    int birthMonth = birthDay.get(Calendar.MONTH) + 1;

	    //Get difference between months
	    months = currMonth - birthMonth;

	    //if month difference is in negative then reduce years by one 
	    //and calculate the number of months.
	    if (months < 0)
	    {
	       years--;
	       months = 12 - birthMonth + currMonth;
	       if (now.get(Calendar.DATE) < birthDay.get(Calendar.DATE))
	          months--;
	    } else if (months == 0 && now.get(Calendar.DATE) < birthDay.get(Calendar.DATE))
	    {
	       years--;
	       months = 11;
	    }

	    //Calculate the days
	    if (now.get(Calendar.DATE) > birthDay.get(Calendar.DATE))
	       days = now.get(Calendar.DATE) - birthDay.get(Calendar.DATE);
	    else if (now.get(Calendar.DATE) < birthDay.get(Calendar.DATE))
	    {
	       int today = now.get(Calendar.DAY_OF_MONTH);
	       now.add(Calendar.MONTH, -1);
	       days = now.getActualMaximum(Calendar.DAY_OF_MONTH) - birthDay.get(Calendar.DAY_OF_MONTH) + today;
	    } 
	    else
	    {
	       days = 0;
	       if (months == 12)
	       {
	          years++;
	          months = 0;
	       }
	    }
	    return years + " Years, " + months + " Months, " + days + " Days";
	}

	public static String convertNullToEmptyString(Object obj) {
		return (obj == null) ? "" : obj.toString();
	}
	
	 public static String convertDateToStringFormat(Date date, String format){
	     String dateFormat="";
	     SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
	     if(date != null) {
	    	 dateFormat=simpleDateFormat.format(date);    
	     }    
	     return dateFormat;	

	}
	
	 public static String getReplaceString(String replaceValue) {
			
		 String stringReplace=replaceValue.replaceAll("[\\[\\]]", "");
		 return  stringReplace.replaceAll("^\"|\"$", "");
			
		}
	 
	 public static String textToHtml(HttpServletRequest request, String data) {
		 	
		 	JSONObject input = new JSONObject(data);
		   	Box box = HMSUtil.getBox(request);
		   	JSONObject json = new JSONObject(box);
		   	String templateData = input.getString("resultEntry");
			InputStream fis1 = null;
			try {
				fis1 = new FileInputStream(request.getServletContext()
						.getRealPath("resources/html/appendingHtml.html"));
			} catch (FileNotFoundException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			File temprory2 = new File(request.getServletContext().getRealPath(
					"resources/html/appendingHtml.html"));

			byte[] b1 = new byte[(int) temprory2.length()];
			int offset1 = 0;
			int numRead1 = 0;
			try {
				while ((offset1 < b1.length)
						&& ((numRead1 = fis1.read(b1, offset1, b1.length
								- offset1)) >= 0)) {

					offset1 += numRead1;

				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				fis1.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String appendedHtml = new String(b1);
			String finalFile = appendedHtml + templateData + "</body></html>";
		 return finalFile;
	 }	
	
	 public static String changeDateToddMMyyyy(Date dbDate) {
		 String strDate = dbDate.toString();
		 String strNewDate = "", year = "", dt = "", month = "";
		 year = strDate.substring(0, 4);
		 month = strDate.substring(5, 7);
		 dt = strDate.substring(8, 10);
		 strNewDate = (dt + "/" + month + "/" + year);
		 return strNewDate;
		}
	 
	 /**
	  * Fills a Jasper report and streams it to the response as PDF.
	  *
	  * <p>This used to be {@code JasperRunManager.runReportToPdf}, which kept three
	  * full copies of the report in heap at once and took the whole Tomcat down with
	  * an OutOfMemoryError on any large date range:
	  *
	  * <ol>
	  * <li>the entire JDBC ResultSet, because pgjdbc buffers every row client-side
	  *     unless autoCommit is off <em>and</em> a fetch size is set — neither was
	  *     true, since the pooled connection arrives with autoCommit on and Jasper
	  *     created the statement itself;</li>
	  * <li>the entire {@code JasperPrint}, every page and cell as live objects;</li>
	  * <li>the finished PDF as a single {@code byte[]} — briefly twice over, since
	  *     the exporter assembles it in a ByteArrayOutputStream first.</li>
	  * </ol>
	  *
	  * <p>All three are now bounded: a server-side cursor, an LRU virtualizer that
	  * spills pages to the servlet temp dir, and a direct export to the response
	  * stream. Memory is a function of FETCH_SIZE and VIRTUALIZER_MAX_PAGES rather
	  * than of how much data the user asked for.
	  *
	  * <p>Still {@code synchronized}, so report generation remains serialized
	  * application-wide — a long report blocks every other one. That is a separate
	  * problem from the memory one and is deliberately left alone here.
	  */
	 public synchronized static void generateReportInPopUp(String jasper_filename, String actualFileName, Map parameters,
				Connection conn, HttpServletResponse response,
				ServletContext context) {

			// Bounded work-in-progress, independent of result size.
			final int FETCH_SIZE = 5000;
			final int VIRTUALIZER_MAX_PAGES = 300;

			final String reqId = safeRequestId();
			final long tStart = System.nanoTime();
			final long[] rowCount = new long[] { -1L };   // -1 = not counted
			String stage = "INIT";

			// Only registered when the browser supplied a runId, i.e. only for the
			// screens wired up to the wait dialog. Everything else behaves as before.
			final String runId = currentRunId();
			final ReportRun run = (runId == null) ? null
					: new ReportRun(jasper_filename, currentUser(), rowCount);
			if (run != null) {
				ACTIVE_RUNS.put(runId, run);
			}

			JRSwapFileVirtualizer virtualizer = null;
			boolean autoCommitChanged = false;
			try {
				reportLog(Level.INFO, "report_start", jasper_filename, reqId,
						" output=" + quote(actualFileName)
						+ " params=" + quote(describeParameters(parameters))
						+ " heap_used_mb=" + heapUsedMb() + " heap_max_mb=" + heapMaxMb());

				// (1) Server-side cursor. pgjdbc needs BOTH of these or it silently
				// materialises the whole ResultSet in the client.
				try {
					if (conn.getAutoCommit()) {
						conn.setAutoCommit(false);
						autoCommitChanged = true;
					}
				} catch (SQLException e) {
					// Not fatal: without the cursor the report is memory-hungry but
					// still correct. Worth a loud line, since it is the difference
					// between a bounded fill and the old behaviour.
					System.err.println("[" + jasper_filename
							+ "] could not disable autoCommit, report will buffer the full ResultSet: " + e);
				}
				// NOT parameters.put(...) — JRJdbcQueryExecuter reads this with
				// JRProperties.getIntegerProperty(dataset, key, 0), i.e. from the report's
				// own <property> elements falling back to the global JRProperties table.
				// It never looks at the parameters map, so setting it there is silently
				// ignored and the cursor is never enabled. Global is what we want anyway:
				// it covers every report without recompiling ~190 .jasper files.
				JRProperties.setProperty(JRJdbcQueryExecuterFactory.PROPERTY_JDBC_FETCH_SIZE,
						String.valueOf(FETCH_SIZE));

				// (2) Page virtualizer. Uses the container's temp dir rather than
				// getRealPath(), which returns null when the WAR is served unexploded.
				File tempDir = (File) context.getAttribute(ServletContext.TEMPDIR);
				if (tempDir != null) {
					JRSwapFile swapFile = new JRSwapFile(tempDir.getAbsolutePath(), 4096, 200);
					virtualizer = new JRSwapFileVirtualizer(VIRTUALIZER_MAX_PAGES, swapFile, true);
					parameters.put(JRParameter.REPORT_VIRTUALIZER, virtualizer);
				}

				stage = "LOAD";
				if (run != null) { run.stage = stage; }
				JasperReport compiled = getCompiledReport(context, jasper_filename);
				if (compiled.getMainDataset() != null && compiled.getMainDataset().getQuery() != null) {
					reportLog(Level.INFO, "report_sql", jasper_filename, reqId,
							" sql=" + quote(collapse(compiled.getMainDataset().getQuery().getText(), SQL_LOG_MAX)));
				}

				// Counts rows as JasperReports consumes them, by observing ResultSet.next().
				// Returns the connection untouched if wrapping fails for any reason -- a
				// diagnostic must never be the thing that breaks a report.
				Connection fillConn = countingConnection(conn, rowCount, run, jasper_filename, reqId);

				stage = "FILL";
				if (run != null) { run.stage = stage; }
				long tFill = System.nanoTime();
				reportLog(Level.INFO, "report_fill", jasper_filename, reqId,
						" stage=begin fetch_size=" + FETCH_SIZE
						+ " virtualizer=" + (virtualizer != null)
						+ " heap_used_mb=" + heapUsedMb());

				JasperPrint jasperPrint = JasperFillManager.fillReport(compiled, parameters, fillConn);

				int pages = jasperPrint.getPages() == null ? -1 : jasperPrint.getPages().size();
				reportLog(Level.INFO, "report_fill", jasper_filename, reqId,
						" stage=done rows=" + rowCount[0] + " pages=" + pages
						+ " duration_ms=" + millisSince(tFill)
						+ " heap_used_mb=" + heapUsedMb());

				// (3) Straight to the socket. No Content-Length: the size is not known
				// until the export finishes, and buffering the PDF to find out is the
				// allocation this method exists to avoid. Tomcat falls back to chunked.
				response.setContentType("application/pdf");
				response.setHeader("Content-Disposition", "inline; filename=\"" + actualFileName + ".pdf\"");

				stage = "EXPORT";
				if (run != null) { run.stage = stage; }
				long tExport = System.nanoTime();
				reportLog(Level.INFO, "report_export", jasper_filename, reqId,
						" stage=begin pages=" + pages + " heap_used_mb=" + heapUsedMb());

				// Counting wrapper so the log can report the PDF size even though
				// Content-Length is deliberately not set on a streamed response.
				ServletOutputStream outputStream = response.getOutputStream();
				CountingOutputStream counted = new CountingOutputStream(outputStream);
				JasperExportManager.exportReportToPdfStream(jasperPrint, counted);
				counted.flush();

				reportLog(Level.INFO, "report_export", jasper_filename, reqId,
						" stage=done bytes=" + counted.count()
						+ " duration_ms=" + millisSince(tExport)
						+ " heap_used_mb=" + heapUsedMb());

				stage = "DONE";
				if (run != null) { run.stage = stage; }
				reportLog(Level.INFO, "report_done", jasper_filename, reqId,
						" rows=" + rowCount[0] + " pages=" + pages + " bytes=" + counted.count()
						+ " total_ms=" + millisSince(tStart)
						+ " heap_used_mb=" + heapUsedMb());

			} catch (Exception e) {
				// A cancelled run is a normal outcome, not a fault. Logging it as
				// SEVERE would make deliberate user action look like an incident, and
				// sending a 500 page would be pointless -- nobody is waiting for it.
				boolean cancelled = (run != null && run.isCancelRequested());
				if (cancelled) {
					reportLog(Level.INFO, "report_cancelled", jasper_filename, reqId,
							" stage=" + stage + " rows=" + rowCount[0]
							+ " total_ms=" + millisSince(tStart)
							+ " heap_used_mb=" + heapUsedMb());

					// Returning without touching the response leaves it at the default
					// 200 with an empty body, and the download link saves that as a
					// 0 KB PDF. 204 means "done, nothing to deliver" -- exactly true
					// after a cancel -- and produces no file.
					//
					// setStatus, not sendError: sendError writes a Tomcat HTML error
					// page, and a download link will happily save that page under the
					// .pdf name, which is worse than an empty file.
					//
					// If the response is already committed the cancel landed during
					// export, part of the PDF is on the wire and the status is fixed.
					if (!response.isCommitted()) {
						response.reset();
						response.setStatus(HttpServletResponse.SC_NO_CONTENT);
					}
					return;
				}

				reportLog(Level.SEVERE, "report_failed", jasper_filename, reqId,
						" stage=" + stage + " rows=" + rowCount[0]
						+ " total_ms=" + millisSince(tStart)
						+ " heap_used_mb=" + heapUsedMb() + " heap_max_mb=" + heapMaxMb()
						+ " error=" + e.getClass().getSimpleName()
						+ " error_msg=" + quote(e.getMessage()));

				// Deliberately Exception, not (JRException | IOException): most
				// fill-time failures arrive as JRRuntimeException, which extends
				// RuntimeException and would otherwise sail past this handler and reach
				// the user as a raw Tomcat 500 stack trace.
				//
				// Error is NOT caught. An OutOfMemoryError leaves the JVM in a state
				// where pretending to serve an error page is dishonest, and swallowing
				// it would hide the very failure this method was rewritten to prevent.
				//
				// Not rethrown: the signature stays checked-exception-free so none of
				// the ~190 call sites in ReportWebController / StoresWebController need
				// to change.
				e.printStackTrace();
				try {
					if (!response.isCommitted()) {
						response.reset();
						response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
								"Report generation failed for " + actualFileName);
					}
				} catch (IOException ioe) {
					// Client already gone, or the response died mid-stream. Nothing
					// left to report to; the stack trace above is the record.
					ioe.printStackTrace();
				}
			} finally {
				// Must be unconditional: a registry entry left behind pins the
				// Statement and Connection and leaks on every run.
				if (runId != null) {
					ACTIVE_RUNS.remove(runId);
				}
				// The transaction opened for the cursor must be ended before the
				// connection goes back to the pool, or it sits there idle-in-transaction
				// holding locks and blocking VACUUM.
				try {
					if (conn != null && !conn.isClosed()) {
						if (autoCommitChanged) {
							conn.rollback();
							conn.setAutoCommit(true);
						}
						conn.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				// Deletes the swap file. Skipping this leaks disk on every report.
				if (virtualizer != null) {
					virtualizer.cleanup();
				}
			}
		}
	 

	// ------------------------------------------------------------------
	// Report instrumentation
	//
	// java.util.logging deliberately, matching RequestLoggingInterceptor: MMUWeb
	// ships log4j-api with no log4j-core and slf4j-api with no binding, so both
	// are silent no-ops. JUL is always present and Tomcat's JULI routes it.
	// Format is logfmt (key=value), same as event=http_request, so a report run
	// and the request that triggered it join on req_id.
	//
	// Turn the whole thing down without a rebuild:
	//     com.mmu.report.level = WARNING      in conf/logging.properties
	// Or disable just the two expensive pieces via CATALINA_OPTS:
	//     -Dmmu.report.logSql=false           (stops logging the query text)
	//     -Dmmu.report.countRows=false        (stops the ResultSet row counter)
	// ------------------------------------------------------------------

	private static final Logger REPORT_LOG = Logger.getLogger("com.mmu.report");

	// ------------------------------------------------------------------
	// Live run registry — powers the wait dialog's progress and its Cancel button.
	//
	// Keyed by a runId the BROWSER generates and puts on the report URL, read here
	// from the current request. Deliberately not a method parameter: adding one
	// would touch all ~190 call sites in ReportWebController / StoresWebController
	// for a feature only the OPD Register screen uses.
	//
	// Cancellation is Statement.cancel() only. pgjdbc sends a real CancelRequest on
	// a side connection, Postgres kills the backend query, the ResultSet iteration
	// fails and the fill unwinds. That covers the query and row-reading phase, which
	// was 261s of the measured 317s run. It does NOT cover the export phase -- but
	// export writes to the socket, so a vanished client is detected there anyway.
	//
	// This avoids swapping JasperFillManager.fillReport for JRFiller.createFiller +
	// filler.cancelFill(), which would change the fill mechanism for every report in
	// both controllers. Same practical result, far smaller blast radius.
	// ------------------------------------------------------------------

	private static final ConcurrentMap<String, ReportRun> ACTIVE_RUNS =
			new ConcurrentHashMap<String, ReportRun>();

	/** One in-flight report. Fields written by the worker, read by status/cancel requests. */
	public static final class ReportRun {
		private final String report;
		private final String user;
		private final long startedNanos;
		private final long[] rows;
		private volatile String stage = "STARTING";
		private volatile Statement statement;
		private volatile boolean cancelRequested;

		ReportRun(String report, String user, long[] rows) {
			this.report = report;
			this.user = user;
			this.rows = rows;
			this.startedNanos = System.nanoTime();
		}

		boolean isCancelRequested() {
			return cancelRequested;
		}

		/** logfmt-ish JSON for the browser's poll. Never throws. */
		public String toJson() {
			return "{\"found\":true,\"stage\":\"" + stage + "\",\"rows\":" + rows[0]
					+ ",\"elapsedMs\":" + ((System.nanoTime() - startedNanos) / 1_000_000L)
					+ ",\"cancelRequested\":" + cancelRequested + "}";
		}
	}

	/** The runId the browser put on the report URL, or null when it did not send one. */
	private static String currentRunId() {
		try {
			org.springframework.web.context.request.RequestAttributes attrs =
					org.springframework.web.context.request.RequestContextHolder.getRequestAttributes();
			if (!(attrs instanceof org.springframework.web.context.request.ServletRequestAttributes)) {
				return null;
			}
			String runId = ((org.springframework.web.context.request.ServletRequestAttributes) attrs)
					.getRequest().getParameter("runId");
			return (runId == null || runId.trim().isEmpty()) ? null : runId.trim();
		} catch (Exception e) {
			return null;   // progress reporting is never worth failing a report over
		}
	}

	/** Session user, matching RequestLoggingInterceptor, so a run can only be cancelled by its owner. */
	private static String currentUser() {
		try {
			org.springframework.web.context.request.RequestAttributes attrs =
					org.springframework.web.context.request.RequestContextHolder.getRequestAttributes();
			if (attrs == null) {
				return "-";
			}
			Object userId = attrs.getAttribute("userId", RequestAttributes.SCOPE_SESSION);
			if (userId == null) {
				userId = attrs.getAttribute("user_id", RequestAttributes.SCOPE_SESSION);
			}
			return userId == null ? "-" : userId.toString();
		} catch (Exception e) {
			return "-";
		}
	}

	/**
	 * Progress for the wait dialog. Returns {@code {"found":false}} once the run has
	 * finished, been cancelled, or never existed -- the browser treats all three the
	 * same way: stop polling.
	 */
	public static String reportRunStatus(String runId, String user) {
		ReportRun run = runId == null ? null : ACTIVE_RUNS.get(runId);
		if (run == null || !run.user.equals(user)) {
			return "{\"found\":false}";
		}
		return run.toJson();
	}

	/**
	 * Asks the database to abort the running query. Only the user who started the run
	 * may cancel it, otherwise this endpoint would let anyone kill anyone's report.
	 *
	 * @return true when a cancel was actually issued
	 */
	public static boolean cancelReportRun(String runId, String user) {
		ReportRun run = runId == null ? null : ACTIVE_RUNS.get(runId);
		if (run == null || !run.user.equals(user)) {
			return false;
		}
		run.cancelRequested = true;
		Statement statement = run.statement;
		if (statement == null) {
			// The query has not started yet, or has already finished and we are in
			// export. The flag is still set, so the reader aborts at the next row.
			reportLog(Level.INFO, "report_cancel_requested", run.report, runId, " stage=" + run.stage);
			return true;
		}
		try {
			statement.cancel();
			reportLog(Level.INFO, "report_cancel_requested", run.report, runId,
					" stage=" + run.stage + " rows_so_far=" + run.rows[0]);
			return true;
		} catch (Throwable t) {
			// Racing with normal completion is expected and harmless.
			reportLog(Level.WARNING, "report_cancel_failed", run.report, runId,
					" reason=" + quote(String.valueOf(t)));
			return false;
		}
	}

	/** The full OPD Register query is ~4KB; enough to read, capped so logs stay usable. */
	private static final int SQL_LOG_MAX = 4000;

	private static void reportLog(Level level, String event, String report, String reqId, String rest) {
		if (!REPORT_LOG.isLoggable(level)) {
			return;
		}
		REPORT_LOG.log(level, "event=" + event + " app=MMUWeb report=" + report
				+ (reqId == null ? "" : " req_id=" + reqId) + rest);
	}

	/** Correlation id of the request being served, or null outside one. Never throws. */
	private static String safeRequestId() {
		try {
			return com.mmu.web.config.RequestLoggingInterceptor.currentRequestId();
		} catch (Throwable t) {
			return null;
		}
	}

	private static long millisSince(long startNanos) {
		return (System.nanoTime() - startNanos) / 1_000_000L;
	}

	private static long heapUsedMb() {
		Runtime rt = Runtime.getRuntime();
		return (rt.totalMemory() - rt.freeMemory()) / (1024L * 1024L);
	}

	private static long heapMaxMb() {
		return Runtime.getRuntime().maxMemory() / (1024L * 1024L);
	}

	/** logfmt values need quoting once they contain spaces, which SQL always does. */
	private static String quote(String value) {
		if (value == null) {
			return "\"\"";
		}
		return "\"" + value.replace("\\", "\\\\").replace("\"", "\\\"") + "\"";
	}

	/** Collapses newlines and runs of whitespace so a query stays one log line. */
	private static String collapse(String text, int max) {
		if (text == null) {
			return "";
		}
		String flat = text.replaceAll("\\s+", " ").trim();
		return flat.length() <= max ? flat : flat.substring(0, max) + "...[truncated]";
	}

	/**
	 * Renders the report parameters for the log.
	 *
	 * <p>This method is shared by ~190 report endpoints, and some of them pass
	 * patient identifiers. This system holds patient records and logs are retained
	 * longer and read more widely than the database, so values whose key looks
	 * patient-identifying are replaced with their length rather than printed.
	 * Jasper's own internals (REPORT_*, SUBREPORT_DIR, the logo path) are dropped
	 * entirely -- they are noise and one of them is a live virtualizer instance.
	 */
	private static String describeParameters(Map parameters) {
		if (parameters == null || parameters.isEmpty()) {
			return "{}";
		}
		StringBuilder sb = new StringBuilder(200);
		sb.append('{');
		boolean first = true;
		for (Object entry : parameters.entrySet()) {
			Map.Entry e = (Map.Entry) entry;
			String key = String.valueOf(e.getKey());
			if (key.startsWith("REPORT_") || key.startsWith("JASPER_")
					|| key.equals("SUBREPORT_DIR") || key.equals("path")) {
				continue;
			}
			if (!first) {
				sb.append(", ");
			}
			first = false;
			sb.append(key).append('=');
			Object value = e.getValue();
			if (isSensitiveKey(key)) {
				sb.append("<redacted:").append(value == null ? 0 : String.valueOf(value).length()).append("ch>");
			} else {
				String text = String.valueOf(value);
				sb.append(text.length() > 80 ? text.substring(0, 80) + "..." : text);
			}
		}
		return sb.append('}').toString();
	}

	private static boolean isSensitiveKey(String key) {
		String k = key.toLowerCase();
		return k.contains("patient") || k.contains("uhid") || k.contains("mobile")
				|| k.contains("aadhaar") || k.contains("aadhar") || k.contains("name")
				|| k.contains("phone") || k.contains("address");
	}

	/**
	 * Wraps the connection so every {@code ResultSet.next()} that returns true is
	 * counted, giving the exact number of rows JasperReports consumed -- which
	 * JasperReports 3.7.0 does not expose any other way.
	 *
	 * <p>Purely a dynamic-proxy pass-through: every call is forwarded unchanged and
	 * only the return value is inspected, so the JDBC semantics Jasper sees are
	 * identical. If the proxy cannot be created the raw connection is returned and
	 * the row count simply stays -1; a diagnostic must never break a report.
	 */
	private static Connection countingConnection(final Connection target, final long[] counter,
			final ReportRun run, String report, String reqId) {
		if (!Boolean.parseBoolean(System.getProperty("mmu.report.countRows", "true"))) {
			return target;
		}
		try {
			counter[0] = 0L;
			return (Connection) proxy(target, Connection.class, counter, run);
		} catch (Throwable t) {
			counter[0] = -1L;
			reportLog(Level.WARNING, "report_rowcount_unavailable", report, reqId,
					" reason=" + quote(String.valueOf(t)));
			return target;
		}
	}

	/**
	 * Proxies one JDBC interface, re-wrapping any Statement or ResultSet handed back
	 * so the chain Connection -> Statement -> ResultSet stays observed.
	 */
	private static Object proxy(final Object target, Class<?> iface, final long[] counter,
			final ReportRun run) {
		return Proxy.newProxyInstance(HMSUtil.class.getClassLoader(), new Class<?>[] { iface },
				new InvocationHandler() {
					@Override
					public Object invoke(Object p, Method method, Object[] args) throws Throwable {
						Object result;
						try {
							result = method.invoke(target, args);
						} catch (InvocationTargetException ite) {
							// Unwrap, or callers see UndeclaredThrowableException instead of
							// the SQLException they are written to handle.
							throw ite.getCause() == null ? ite : ite.getCause();
						}
						if (result instanceof ResultSet) {
							return proxy(result, ResultSet.class, counter, run);
						}
						if (result instanceof CallableStatement) {
							return proxy(result, CallableStatement.class, counter, run);
						}
						if (result instanceof PreparedStatement) {
							return proxy(result, PreparedStatement.class, counter, run);
						}
						if (result instanceof Statement) {
							// Publish it so a cancel request from another thread has
							// something to call cancel() on. This is the only handle on
							// the running query that exists anywhere.
							if (run != null) {
								run.statement = (Statement) result;
							}
							return proxy(result, Statement.class, counter, run);
						}
						if (target instanceof ResultSet && "next".equals(method.getName())
								&& Boolean.TRUE.equals(result)) {
							counter[0]++;
							// Second line of defence. Statement.cancel() normally breaks the
							// read directly, but if it raced with a fetch, or was requested
							// before the statement existed, stop here instead of reading
							// another two million rows nobody is waiting for.
							if (run != null && run.isCancelRequested()) {
								throw new SQLException("Report cancelled by user after "
										+ counter[0] + " rows");
							}
						}
						return result;
					}
				});
	}

	/** Counts bytes written so the log can report PDF size on a chunked response. */
	private static final class CountingOutputStream extends ServletOutputStream {

		private final ServletOutputStream delegate;
		private long count;

		CountingOutputStream(ServletOutputStream delegate) {
			this.delegate = delegate;
		}

		long count() {
			return count;
		}

		@Override
		public void write(int b) throws IOException {
			delegate.write(b);
			count++;
		}

		@Override
		public void write(byte[] b, int off, int len) throws IOException {
			delegate.write(b, off, len);
			count += len;
		}

		@Override
		public void flush() throws IOException {
			delegate.flush();
		}

		// Servlet 3.1 async-IO contract. Delegated rather than stubbed so this
		// wrapper stays transparent; the export path itself is blocking.
		@Override
		public boolean isReady() {
			return delegate.isReady();
		}

		@Override
		public void setWriteListener(WriteListener listener) {
			delegate.setWriteListener(listener);
		}
	}

 public static Date getStartDate(int year, int month) {
	 //Date orderDateTime = null;
	 LocalDate date = LocalDate.of(year, month, 1);
    return Date.from(date.atStartOfDay(ZoneId.systemDefault()).toInstant());
 }

 public static Date getEndDate(int year, int month) {
     YearMonth yearMonth = YearMonth.of(year, month);
	 LocalDate date = yearMonth.atEndOfMonth();
	    // Convert LocalDate to java.util.Date
	    return Date.from(date.atStartOfDay(ZoneId.systemDefault()).toInstant());
 }
	 
	
}
