<%@page import="java.util.HashMap"%>
    <%@page import="java.util.Map"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

          
          <%@include file="..//view/leftMenu.jsp" %>

                <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                    <html>

                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
                        <%@include file="..//view/commonJavaScript.jsp" %>
                            <title>Mb Pre Assessment</title>
                      <!--   <link href="/AshaWeb/resources/css/stylecommon.css" rel="stylesheet" type="text/css" /> -->
                    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newOpd.js"></script>
                    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opd.js"></script>
                   	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opdpatientrecall.js"></script>
                    </head>

                    <%
	int i = 1;
%>






<style>
.block {
  display: block;
  width: 100%;
  border: none;
  background-color: #4CAF50;
  color: white;
  padding: 14px 28px;
  font-size: 16px;
  cursor: pointer;
  text-align: center;
}

.block:hover {
  background-color: #ddd;
  color: black;
}
</style>

<body>

 <!-- Begin page -->
    <div id="wrapper">
<form name="frm">

<div class="content-page">
                                <!-- Start content -->
 <div class="">
  <div class="container-fluid">
	 
	  <div class="internal_Htext">MB Pre Assessment</div>
	  

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                <p class="submitMsg">MB Pre Assessment Details Submitted Successfully</p>    
                                <div id="opd_submit">  
                                     <div class="row">
										<div class="col-md-8"> 
												<!-- <button class=" btn btn-primary opd_submit_btn" onclick="printReport('C');">Case Sheet</button>  -->
										
												 <!-- <button class="btn btn-primary opd_submit_btn" onclick="printReport('I');">Investigation Slip</button> 
										
												 <button class="btn btn-primary opd_submit_btn" onclick="printReport('P');">Prescription Slip</button> 
										
												 <button class="btn btn-primary opd_submit_btn" onclick="printReport('R');">Referral Letter</button> --> 
										</div> 
										
										<!-- <div class="col-md-2"> 
												<button class="btn btn-primary opd_submit_btn"   type="button" onclick="return backListReport('1');" id="clicked">Back to List</button>  
										</div> -->

											<c:choose>
												<c:when test="${redirectValue =='opdRecall'}">
													<div class="col-md-4 text-right">
														<button class="btn btn-primary opd_submit_btn"
															type="button" onclick="return backListReport('2');"
															id="clicked">Back to List</button>
													</div>
												</c:when>

												<c:otherwise>
													<div class="col-md-4 text-right">
														<button class="btn btn-primary opd_submit_btn"
															type="button" onclick="return backListReport('1');"
															id="clicked">Back to List</button>
													</div>
												</c:otherwise>
											</c:choose>


										</div>
                               </div>  
                                </div>
                            </div>
                            <!-- end card -->
                        </div>
                        <!-- end col -->
                    </div>
                    <!-- end row -->
                    <!-- end row -->

                </div>
                <!-- container -->
                 </div>
                  </div>


 



<!---header text ends--->

											<div class="col-md-4">
											<div class="form-group">
												<input type="text" id="visit_id" name="visit_id"
													value=""/>
											</div>
										</div>


  
</form>

</div>
  
  
  
  <script type="text/javascript">
            $(document).ready(function() {
                /* if (typeof element !== "undefined" && element.value == '') {
                } */
                var data = ${
                    data
                };
               // alert(data.data[0].visitId);
                    if (data.data[0].visitId != null) {
                    document.getElementById('visit_id').value = data.data[0].visitId;
                }
            });
  </script>              

 

<script type="text/javascript" language="javascript">
            function backListReport(flag) {
            				if(flag=="1"){
                          	 window.location.href ="mbPreAssesmentWaitingList";
            				}
            				if(flag=="2"){
                             	 window.location.href ="opdPatientRecall";
               				}
            }
            
            
            
 </script>           
<script type="text/javascript" language="javascript">

function executeClickEvent()
{
	 //alert(Id)
	 var visitIdValue=$('#visit_id').val();
	 window.location="getCaseSheet?visitId="+visitIdValue+"";
	
}

function printReport(flag) {

	
	//alert("flag : "+flag)
	if(flag=='C')
	document.frm.action="${pageContext.request.contextPath}/report/printCaseSheet";
	if(flag=='I')
	document.frm.action="${pageContext.request.contextPath}/report/printInvestigationSlip";
	if(flag=='P')
	document.frm.action="${pageContext.request.contextPath}/report/printPrescriptionSlip";
	if(flag=='R'){
		document.frm.action="${pageContext.request.contextPath}/report/referReportSlip";
	}
	document.frm.method="POST";
	document.frm.submit(); 
	
 	/* var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
    var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/v0.1/opd/getCaseSheet";
	$.ajax({
		type : "GET",
		contentType : "application/json",
		url : url,
		data : JSON.stringify({
			'visitId' : visitIdValue
		}),
		dataType : 'json',
		timeout : 100000,
		
		success : function(res)
		
		{
			data = res.data;
			
			for(var i=0;i<data.length;i++){
				  
				console.log('dataLenth :',data);
				
				
				
			}

 		
            },
            error: function (jqXHR, exception) {
                var msg = '';
                if (jqXHR.status === 0) {
                    msg = 'Not connect.\n Verify Network.';
                } else if (jqXHR.status == 404) {
                    msg = 'Requested page not found. [404]';
                } else if (jqXHR.status == 500) {
                    msg = 'Internal Server Error [500].';
                } else if (exception === 'parsererror') {
                    msg = 'Requested JSON parse failed.';
                } else if (exception === 'timeout') {
                    msg = 'Time out error.';
                } else if (exception === 'abort') {
                    msg = 'Ajax request aborted.';
                } else {
                    msg = 'Uncaught Error.\n' + jqXHR.responseText;
                }
                alert(msg);
            }
 	}); */
 }

</script>
<%-- <script>
var visitId=${visitId};
$('#visitId').val(visitId);
function func1() {
  	$("#messageSubmit").show();
}
window.onload=func1;
          
 </script>

	<div class="modal hide z-index5000" id="messageSubmit" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
		data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
				<button type="button" class="close btnclose" data-dismiss="modal" aria-hidden="true"  id="btncross">X</button> 
					<h3 class="Message_htext">Indian Coast Guard</h3>
				</div>
				<div class="modal-body">
					<div class="control-group">
						<div class="">
							<!-- <spring:message code="lblWarningMessageJSI"/> -->
							<h4  class="message_text">${msgRecall}</h4>
						</div>
					</div>
				</div>
				<div  class="modal-footer">
					<button class="btn btn-primary" data-dismiss="modal"
						onClick="closeSubmit();" aria-hidden="true">Close</button>
				</div>
			</div>
		</div>
	</div> --%>
</body>
<script>
var data = ${data};
if(data!=null && data!=""){
var visit_id = data.visitId;
	document.getElementById('visit_id').value =visit_id;
}
</script>
</html>