<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="..//view/leftMenu.jsp"%>
<%@include file="..//view/commonJavaScript.jsp"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Message</title>
</head>
<%

HttpSession sessionJsp = request.getSession(false);// don't create if it doesn't exist

	if(sessionJsp == null || sessionJsp.isNew()) {
			return;
		}

	Map<String, Object> map = new HashMap<String, Object>();
	if (request.getAttribute("map") != null) {
		map = (Map<String, Object>) request.getAttribute("map");
	}
	
	String visit_id="";
	if (map.get("visitId") != null) {
		 visit_id=(String)map.get("visitId");
	}
	
	String msg="";
	if (map.get("resultMsg") != null) {
		msg=(String)map.get("resultMsg");
	}



String flag="ICG";
if(request.getParameter("flag") !=null){
	flag="Others";
}
%>
<script type="text/javascript">

function GoToHomePage()
{
	var flag="<% out.print(flag);%>";
	if(flag=='ICG'){
		window.location="${pageContext.request.contextPath}/registration/showemployeeanddependent";
	}else if(flag=='Others'){
		window.location="${pageContext.request.contextPath}/registration/registrationandappointmentothers";
	}
}


function makeUrl(){
	var id =<%out.print(visit_id);%>
	var url="${pageContext.request.contextPath}/report/printVisitTokenReportforOthers?visit_id="+id;
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
													style="color: green; font-weight: bold;"><%=msg %></p>
									<form name="frm">
										<div class="row">
											<div class="col-md-12 text-right">
											<%-- <input type="hidden" id="visit_id" name="visit_id" value="<%out.print(visit_id);%>"> --%>
											<!-- <input type="hidden" id="urlForReport" name="urlForReport" value=""> -->
											<button id="printReportButton" type="button" class="btn btn-primary"  onclick="makeUrl()">Print Report</button>
											<button class="btn btn-primary" type="button" name="backBtn" id="backBtn" onClick="GoToHomePage()">Back</button>
											<input type="hidden" id="reportType" name="reportType" value="">
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
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>