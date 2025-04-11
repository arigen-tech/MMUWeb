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
	Map<String, Object> map = new HashMap<String, Object>();
	if (request.getAttribute("map") != null) {
		map = (Map<String, Object>) request.getAttribute("map");
		System.out.println(map);
	}
	
	if (map.get("balanceMId") != null) {
		balanceHeaderId=(Long)map.get("balanceMId");
	}
	
	if (map.get("message") != null) {
		msg=(String)map.get("message");
	}
	
%>


<script type="text/javascript">

function GoToBackPage(){
	var mId ="<% out.print(balanceHeaderId);%>";
	if(mId!=0){
		window.location="${pageContext.request.contextPath}/store/openingBalanceWatingList";
	}else{
		window.location="${pageContext.request.contextPath}/store/showopeningBalance";
	}
}

function printOpeningBalanceReport(){
	var id =<%out.print(balanceHeaderId);%>
	var url="${pageContext.request.contextPath}/report/printOpeningBalanceReport?balanceHeaderId="+id;
	openPdfModel(url);
}
</script>
<body>
<div id="wrapper">
	<div class="content-page">
		<div class="">
			<div class="container-fluid">
				<div class="internal_Htext">Opening Balance</div>
								<div class="row">
									<div class="col-12">
										<div class="card">
											<div class="card-body">
											<p align="Left" id="message"
													style="color: green; font-weight: bold;"><%=msg %></p>
									<form name="frm">
										<div class="row">
											<div class="col-md-12 text-right" >
											<%if(balanceHeaderId!=0){ %>
											<input type="hidden" id="balanceHeaderId" name="balanceHeaderId" value="<%out.print(balanceHeaderId);%>">
											<button class="btn btn-primary" type="button" name="btnReport" id="btnReport" onClick="printOpeningBalanceReport()">Print Report</button>
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