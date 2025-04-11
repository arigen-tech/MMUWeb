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
                            <title>Medical Board Submit</title>
                      <!--   <link href="/AshaWeb/resources/css/stylecommon.css" rel="stylesheet" type="text/css" /> -->
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

<div class="content-page">
                                <!-- Start content -->
 <div class="">
  <div class="container-fluid">
	  <input type="hidden" id="visit_id" name="visit_id" value=""/>
	  <div class="internal_Htext">Medical Board Reports </div>
	  

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                <p class="submitMsg">Medical Board Submitted Successfully</p>  
                                <input type="hidden" name="moDetails" id="moDetails" value=""/>  
                                <div id="opd_submit">  
                                     <div class="row">
										<div class="col-md-8"> 
												<!-- <button class=" btn btn-primary opd_submit_btn" onclick="printReport('C');">Case Sheet</button>  -->
										
												 <button class="btn btn-primary opd_submit_btn" id="printReportButtonAmsf"  onclick="printReport('ME');">Investigation Slip</button> 
										
												<!--  <button class="btn btn-primary opd_submit_btn" onclick="printReport('P');">Prescription Slip</button>  -->
										
												<!--  <button class="btn btn-primary opd_submit_btn" onclick="printReport('R');">Referral Letter</button>  -->
										</div> 
											 
													<div class="col-md-4 text-right">
														<button class="btn btn-primary opd_submit_btn"
															type="button" onclick="return backListReport('1');"
															id="clicked">Back to List</button>
													</div>

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
                    var moDetails=localStorage.moDetails;
            	    document.getElementById('moDetails').value = moDetails;    
            });
  </script>              

 

<script type="text/javascript" language="javascript">
            function backListReport(flag) {
            	            var moValidate=$('#moDetails').val();
            				if(flag=="1" && moValidate!=='moDetails'){
                          	 window.location.href ="piMBWaitingList";
            				}
            				else
            				{
            					 window.location.href ="piMBWaitingListMO";	
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


	var visitIdValue=$('#visit_id').val();
	//alert("flag : "+flag)
	if(flag=='ME')
	{	
	var amsfUrl="${pageContext.request.contextPath}/report/validateMedicalExamReport?visit_id="+visitIdValue;
	openPdfModel(amsfUrl);
	}
	if(flag=='I')
	{	
	document.frm.action="${pageContext.request.contextPath}/report/printInvestigationSlip";
	}
	if(flag=='P')
	{	
	document.frm.action="${pageContext.request.contextPath}/report/printPrescriptionSlip";
	}
	if(flag=='R')
	{
		document.frm.action="${pageContext.request.contextPath}/report/referReportSlip";
	}
	
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

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>