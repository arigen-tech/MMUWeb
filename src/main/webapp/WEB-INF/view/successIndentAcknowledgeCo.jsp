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
long indentMId=0;
String msg="";
	Map<String, Object> map = new HashMap<String, Object>();
	if (request.getAttribute("map") != null) {
		map = (Map<String, Object>) request.getAttribute("map");
		System.out.println(map);
	}
	
	if (map.get("indentMId") != null) {
		indentMId=(Long)map.get("indentMId");
	}
	
	if (map.get("message") != null) {
		msg=(String)map.get("message");
	}
	
%>


<script type="text/javascript">

function GoToBackPage(){
		window.location="${pageContext.request.contextPath}/store/showReceiveIndentWatingListCo";
}

function printIndentMIdReport(){
	var id =<%out.print(indentMId);%>
	var url="${pageContext.request.contextPath}/report/printIndentMIdReportCo?indentMId="+id;
	openPdfModel(url);
}
</script>
<body>
<div id="wrapper">
	<div class="content-page">
		<div class="">
			<div class="container-fluid">
				<div class="internal_Htext">Indent Acknowledgement </div>
								<div class="row">
									<div class="col-12">
										<div class="card">
											<div class="card-body">
											<p align="Left" id="message"
													style="color: green; font-weight: bold;"><%=msg %></p>
									<form name="frm">
										<div class="row">
											<div class="col-md-12 text-right" >
											<%if(indentMId!=0){ %>
											<input type="hidden" id="indentMId" name="indentMId" value="<%out.print(indentMId);%>">
											<button class="btn btn-primary" type="button" name="btnReport" id="printReportButton"  onClick="printIndentMIdReport()">Print Report</button>
											<%}%>
											<button class="btn btn-primary" type="button" name="backBtn"  id="backBtn" onClick="GoToBackPage()">Back</button>
											</div>
											<!-- <input type="hidden" id="urlForReport" name="urlForReport" value=""> -->
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