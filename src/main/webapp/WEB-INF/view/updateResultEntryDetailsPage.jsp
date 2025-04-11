<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@include file="..//view/leftMenu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Indian Coast Guard</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>submitSampleCollectedPage</title>
 
  <%@include file="..//view/commonJavaScript.jsp" %>
  <%
  	String orderId = request.getParameter("orderHdId");
  %>
</head>
 <script type="text/javascript">
           function backToWaitingList(){
        	   window.location = "getResultEntryUpdateWaitingList";
           }
           
           var orderHdId='';           
           orderHdId=<%=orderId%>;
           
         /*   function generateReport()
           {
           	document.updatedResultEntryForm.action="${pageContext.request.contextPath}/report/generateLabHistoryReport?orderHdId="+orderHdId+"";
           	document.updatedResultEntryForm.method="POST";
           	document.updatedResultEntryForm.submit(); 
           	
           } */

           function makeUrl(){
        		
       		var url="${pageContext.request.contextPath}/report/generateLabHistoryReport?oderHdId="+orderHdId+"";
       		
       		openPdfModel(url);
       		
       	}
  </script>    
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
									<h5 style="color:green; font-weight: bold;">Result Updated</h5> 
									<%-- <p align="center" id="messageId" style="color:green; font-weight: bold;" value="${msg}"></p> --%>
						
					<form name="updatedResultEntryForm" id="updatedResultEntryForm" method="">
						<div class="row">
							<div class="col-md-12 text-right">
							<button type="button" class="btn  btn-primary "	onclick="makeUrl()">View Report</button>
					        <input type="button" class=" btn btn-primary opd_submit_btn" onclick="backToWaitingList();" value="Back to List"/>
					        </div>  
					    </div>     
					</form>	
									
									<!--  <div class="row">
								<div class="col-md-12 text-right">
					                <button class=" btn btn-primary opd_submit_btn" onclick="backToWaitingList();">Back</button>
					             </div>  
					     </div>      -->
								</div>
							</div>
							
							
						</div>
						 
					</div>
					
					
					      
					
					
				</div>
			</div>
	</div>
</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>