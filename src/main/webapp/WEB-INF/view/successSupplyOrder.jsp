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
long balanceHeaderId=0;
String msg="";
String requestType="";
String actionFlag="";
	Map<String, Object> map = new HashMap<String, Object>();
	if (request.getAttribute("map") != null) {
		map = (Map<String,Object>) request.getAttribute("map");
	}
	
	if (map.get("balanceHeaderId") != null) {
		balanceHeaderId=(Long)map.get("balanceHeaderId");
	}
	
	if (map.get("message") != null) {
		msg=(String)map.get("message");
	}
	
	if (map.get("requestType") != null) {
		requestType=(String)map.get("requestType");
	}
	
	if (map.get("actionFlag") != null) {
		actionFlag=(String)map.get("actionFlag");
	}
%>


<script type="text/javascript">

function GoToBackPage(){
	var flag="<% out.print(requestType);%>";
	var actionFlag = "<% out.print(actionFlag);%>";
	if(flag=='save' || flag=='SAVE'){
		window.location="${pageContext.request.contextPath}/store/showCreateSupplyOrder";
	}else{
		if(actionFlag=='A' || actionFlag=='a'){
			window.location="${pageContext.request.contextPath}/store/showSupplyOrderPendingApprovalList";
		}else{
			window.location="${pageContext.request.contextPath}/store/showSupplyOrderList";
		}
		
	}
		
}

function printReport(){
	var id= <%out.print(balanceHeaderId);%>
	var url="${pageContext.request.contextPath}/report/printSupplyOrderReport?balanceHeaderId="+id;
	openPdfModel(url);
	/* document.frm.action="${pageContext.request.contextPath}/report/printSupplyOrderReport";
	document.frm.method="POST";
	document.frm.submit();   */
}
</script>
<body>
<div id="wrapper">
	<div class="content-page">
		<div class="">
			<div class="container-fluid">
				<div class="internal_Htext">Supply Order </div>
								<div class="row">
									<div class="col-12">
										<div class="card">
											<div class="card-body">
											<p align="Left" id="message"
													style="color: green; font-weight: bold;"><%=msg %></p>
									<form name="frm">
										<div class="row">
											<div class="col-md-12 text-right" >
											<%if(balanceHeaderId!=0 && actionFlag.equalsIgnoreCase("A")){ %>
											<input type="hidden" id="balanceHeaderId" name="balanceHeaderId" value="<%out.print(balanceHeaderId);%>">
											<button class="btn btn-primary" type="button" name="btnReport" id="btnReport"  onClick="printReport()">Print Report</button>
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
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>