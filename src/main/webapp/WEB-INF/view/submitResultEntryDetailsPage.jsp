<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@include file="..//view/leftMenu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MMSSY</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title></title>
 
  <%@include file="..//view/commonJavaScript.jsp" %>
  
  <%
  String orderId = request.getParameter("oderHdId");
  %>
  <script>
  
  
  function viewResultEntry(){
	  alert("result entry details");
	  window.open("")
	  
  }
  var msg1 = "";
  var orderHdId='';
  $j(document).ready(function()
			{
	  			var data = ${data};
	  			if(data.status == '0'){
	  				msg1 = "Error Occured, Result not submitted";
	  			}else{
	  				msg1 = "Result Entered and Validated Successfully";
	  			}
	  			$j('#message').text(msg1);
	  			$j('#message').show();
	  			
			});
  
  orderHdId=<%=orderId%>;
  
  function backToWaitingList(){
	   window.location = "pendingResultEntry";
  }
 
  function generateReport()
  {
  	document.submitResultEntryDetailsPageForm.action="${pageContext.request.contextPath}/report/generateResultEntryReport?oderHdId="+orderHdId+"";
  	document.submitResultEntryDetailsPageForm.method="POST";
  	document.submitResultEntryDetailsPageForm.submit(); 
  	
  }

  function makeUrl(){
		var url="${pageContext.request.contextPath}/report/generateResultEntryReport?oderHdId="+orderHdId;
		openPdfModel(url);
	}

  </script>
  
</head>
<body>
 <!-- Begin page -->
    <div id="wrapper">
		<div class="content-page">
				<div class="container-fluid">
					<div class="internal_Htext"></div>
					
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									
									<p align="Left" id="message" style="color: green; font-weight: bold;"></p>
									<form name="submitResultEntryDetailsPageForm" id="submitResultEntryDetailsPageForm" method="">
									
								<div class="row">
								<div class="col-6">
									<!-- <button type="button" class="btn  btn-primary "	onclick="generateReport()">View Report</button> -->
									<button id="printReportButton" type="button" class="btn btn-primary noMinWidth"  onclick="makeUrl()">View Report</button>
								</div>
								<div class="col-6 text-right">
					                <input type="button" class=" btn btn-primary opd_submit_btn" onclick="backToWaitingList();" value="Back to List"/>
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
</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>