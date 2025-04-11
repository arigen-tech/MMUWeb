<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@include file="..//view/leftMenu.jsp"%>
<%@include file="..//view/commonJavaScript.jsp"%>
<%@page import="java.util.*"%>
<%@page import="com.mmu.web.utils.HMSUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Message</title>

</head>

<script type="text/javascript">

<%

HttpSession sessionJsp = request.getSession(false);// don't create if it doesn't exist

	if(sessionJsp == null || sessionJsp.isNew()) {
			return;
		}

long visitIdOpd=0;
long visitIdMB=0;
long visitIdME=0;
String message="";
String messageME="";
String messageMB="";
String rspMsgMEMB="";

String APPOINTMENTTYPE_OPD =HMSUtil.getProperties("js_messages_en.properties", "APPOINTMENT_TYPE_CODE_OPD").trim(); 
String APPOINTMENTTYPE_ME =HMSUtil.getProperties("js_messages_en.properties", "APPOINTMENT_TYPE_CODE_ME").trim();
String APPOINTMENTTYPE_MB =HMSUtil.getProperties("js_messages_en.properties", "APPOINTMENT_TYPE_CODE_MB").trim();

Map<String, Object> map = new HashMap<String, Object>();
			if (request.getAttribute("map") != null) {
				map = (Map<String, Object>) request.getAttribute("map");
			}
			
			if (map.get("message") != null) {
				message=(String)map.get("message");
				
			}
			
			if (map.get("messageME") != null) {
				messageME=(String)map.get("messageME");
				
			}
			
			if (map.get("messageMB") != null) {
				messageMB=(String)map.get("messageMB");
				
			}
			
			if (map.get("rspMsgMEMB") != null) {
				messageMB=(String)map.get("rspMsgMEMB");
				
			}
			
			
			if (map.get("visitIdOPD") != null) {
				visitIdOpd=(long)map.get("visitIdOPD");
			}
			if (map.get("visitIdME") != null) {
				visitIdME=(long)map.get("visitIdME");
			}
			if (map.get("visitIdMB") != null) {
				visitIdMB=(long)map.get("visitIdMB");
			}
			
%>


function GoToHomePage(){
		window.location="${pageContext.request.contextPath}/registration/showemployeeanddependent";
}


function printTokenReport(type,id){
	/* $j('#reportType').val(type);
	document.frm.action="${pageContext.request.contextPath}/report/printVisitTokenReport";
	document.frm.method="POST";
	document.frm.submit();  */
	var url="${pageContext.request.contextPath}/report/printVisitTokenReport?visit_id="+id+"&reportType="+type;
	openPdfModel(url);
}

function printTokenReportTest(type,id){
	var url="${pageContext.request.contextPath}/report/printVisitTokenReportTest?visit_id="+id+"&reportType="+type;
	openPdfModel(url);
}

</script>
<body>
<div id="wrapper">
	<div class="content-page">
		<div class="">
			<div class="container-fluid">
				<div class="internal_Htext">Token Card </div>

								<div class="row">
									<div class="col-12">
										<div class="card">
											<div class="card-body">
											<p align="Left" id="message"
													style="color: green; font-weight: bold;"><%=message %></p>
											<p align="Left" id="messageME"
													style="color: green; font-weight: bold;"><%=messageME %></p>
											<p align="Left" id="messageMB"
													style="color: green; font-weight: bold;"><%=messageMB %></p>
											<p align="Left" id="messageMB"
													style="color: green; font-weight: bold;"><%=rspMsgMEMB %></p>
				                     
				                     <form name="frm">
										<div class="row">
											<div class="col-md-12 text-right">
											<%if(visitIdOpd!=0){ %>
											<input type="hidden" id="visit_id_OPD" name="visit_id_OPD" value="<%out.print(visitIdOpd);%>">
											<%-- <button class="btn btn-primary" type="button" name="btnOPD"  
													id="printReportButton" onClick="printTokenReport('<%=APPOINTMENTTYPE_OPD%>',<%out.print(visitIdOpd);%>)">Print OPD Token Old</button> --%>
													
											<button class="btn btn-primary" type="button" name="btnOPDTest"  
													id="printReportButtonTest" onClick="printTokenReportTest('<%=APPOINTMENTTYPE_OPD%>',<%out.print(visitIdOpd);%>)">Print OPD Token</button>
											<%}%>
											<%if(visitIdME!=0){ %>
											<input type="hidden" id="visit_id_ME" name="visit_id_ME" value="<%out.print(visitIdME);%>">
											<button class="btn btn-primary" type="button" name="btnME"  
													id="printReportButton" onClick="printTokenReportTest('<%=APPOINTMENTTYPE_ME%>',<%out.print(visitIdME);%>)">Print ME Token</button>
											<%} %>
											
											<%if(visitIdMB!=0){ %>
											<input type="hidden" id="visit_id_MB" name="visit_id_MB" value="<%out.print(visitIdMB);%>">
											<button class="btn btn-primary" type="button" name="btnMB" 
													id="printReportButton" onClick="printTokenReportTest('<%=APPOINTMENTTYPE_MB%>',<%out.print(visitIdMB);%>)">Print MB Token</button>
											<%} %>
												<button class="btn btn-primary" type="button" name="backBtn"
													id="backBtn" onClick="GoToHomePage()">Back</button>
													
											<input type="hidden" id="reportType" name="reportType" value="">
											
											<!-- <input type="hidden" id="urlForReport" name="urlForReport" value=""> -->
											
											</div>
											
										
										</div>
				                     </form>
									</div>
								</div>
							</div>
						</div>
		
	         </div>
	
	     </div>
	  </div>
	</div>

</body>
</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>s