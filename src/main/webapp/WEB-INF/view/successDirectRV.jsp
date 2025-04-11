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
long grnMId=0;
String msg="";
	Map<String, Object> map = new HashMap<String, Object>();
	if (request.getAttribute("map") != null) {
		map = (Map<String, Object>) request.getAttribute("map");
	}
	
	if (map.get("grnMId") != null) {
		grnMId=(long)map.get("grnMId");
	}
	
	if (map.get("message") != null) {
		msg=(String)map.get("message");
	}
	
%>


<script>

function GoToBackPage(){
		window.location="${pageContext.request.contextPath}/store/showDirectReceivingSO";
}

function printReport(){
	// Report not required 
	/* document.frm.action="${pageContext.request.contextPath}/report/printDirectReceivingSOReport";
	document.frm.method="POST";
	document.frm.submit();  */
}
</script>
<body>
<div id="wrapper">
	<div class="content-page">
		<div class="">
			<div class="container-fluid">
				<div class="internal_Htext">Direct receiving </div>
								<div class="row">
									<div class="col-12">
										<div class="card">
											<div class="card-body">
											<p align="Left" id="message"
													style="color: green; font-weight: bold;"><%=msg %></p>
									<form name="frm">
										<div class="row">
											<div class="col-md-12 text-right" >
											<%if(grnMId!=0){ %>
											<input type="hidden" id="balanceHeaderId" name="balanceHeaderId" value="<%out.print(grnMId);%>">
											<!-- <button class="btn btn-primary" type="button" name="btnReport" id="btnReport" onClick="printReport()">Print Report</button> -->
											<%}%>
											<button class="btn btn-primary" type="button" name="backBtn"  id="backBtn" onClick="GoToBackPage()">Back</button>
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