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
long takingMHeaderId=0;
String msg="";
	Map<String, Object> map = new HashMap<String, Object>();
	if (request.getAttribute("map") != null) {
		map = (Map<String, Object>) request.getAttribute("map");
		System.out.println(map);
	}
	
	if (map.get("takingMId") != null) {
		takingMHeaderId=(Long)map.get("takingMId");
	}
	
	if (map.get("message") != null) {
		msg=(String)map.get("message");
	}
	
%>


<script type="text/javascript">

function GoToBackPage(){
	var mId ="<% out.print(takingMHeaderId);%>";
	if(mId!=0){
		window.location="${pageContext.request.contextPath}/store/stockTakingWatingList";
	}else{
		window.location="${pageContext.request.contextPath}/store/showPhysicalStockTaking";
	}
		
}

function printStockTakingReport(){
	var id =<%out.print(takingMHeaderId);%>
	var url="${pageContext.request.contextPath}/report/printStockTakingReport?takingMHeaderId="+id;
	openPdfModel(url);
	
	/* document.frm.action="${pageContext.request.contextPath}/report/printStockTakingReport";
	document.frm.method="POST";
	document.frm.submit();  */
}
</script>
<body>
<div id="wrapper">
	<div class="content-page">
		<div class="">
			<div class="container-fluid">
				<div class="internal_Htext">Physical Stock Taking </div>
								<div class="row">
									<div class="col-12">
										<div class="card">
											<div class="card-body">
											<p align="Left" id="message"
													style="color: green; font-weight: bold;"><%=msg %></p>
									<form name="frm">
										<div class="row">
											<div class="col-md-12 text-right" >
											<%if(takingMHeaderId!=0){ %>
											<%-- <input type="hidden" id="takingMHeaderId" name="takingMHeaderId" value="<%out.print(takingMHeaderId);%>"> --%>
											<button class="btn btn-primary" type="button" name="btnReport" id="printReportButton"  onClick="printStockTakingReport()">Print Report</button>
											<%}%>
											<button class="btn btn-primary" type="button" name="backBtn"  id="backBtn" onClick="GoToBackPage()">Back</button>
											</div>
										<input type="hidden" id="urlForReport" name="urlForReport" value="">
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