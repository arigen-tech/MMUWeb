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
                            <title>Medical Exam Submit</title>
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
<form name="frm">

<div class="content-page">
                                <!-- Start content -->
 <div class="">
  <div class="container-fluid">
	 <c:choose>
		<c:when test="${redirectValue =='InvestigationReport'}">
			<div class="internal_Htext">Investigation Reports </div>
	 	 </c:when>
	 		 <c:otherwise>
					<div class="internal_Htext">Medical Exam Status</div>
			</c:otherwise>
	 	 </c:choose>

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                <c:choose>
									<c:when test="${redirectValue =='InvestigationReport'}">
										<p  class="submitMsg">${msgStatus}</p> 
										
								  </c:when>
								  
								  <c:when test="${status =='1'}">
								 		  <p  class="submitMsg">${msgMedicalExam}</p>    
								 	</c:when>
								  
								    <c:when test="${errorCode =='500'}">
								 		  <p><b>JAVA service is down or Internal Server Error</b> </p>    
								 	</c:when>
								  
								  
								 	<c:otherwise>
								 	 <p  class="submitMsg">${msgMedicalExam}</p>  
								 </c:otherwise>
								 </c:choose>		 
                                
                                <div id="opd_submit">  
                                     <div class="row">
										<div class="col-md-8"> 
												<!-- <button class=" btn btn-primary opd_submit_btn" onclick="printReport('C');">Case Sheet</button>  -->
										
										<c:choose>
												<c:when test="${redirectValue =='InvestigationReport' && saveStatus=='v' }">
													 <button id ='investigationSlipReportME' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('ME');">Investigation Slip</button> 
											 	 </c:when>
											 		
											 		 <c:when test="${redirectValue =='MeReport' && countInvesResultEmptystatus eq '0' && msgForPatient != 'rf'}">
											 		 
															 <button id ='medicalExamForCommonReportME' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('MEReport');">Medical Exam Report</button>
													</c:when>
													
													 <c:when test="${redirectValue =='MeReport' && countInvesResultEmptystatus!=null && countInvesResultEmptystatus != '0' && msgForPatient != 'rf'}">
											 		 
															 <button id ='investigationSlipReportEmpty' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('MEResultEmpty');">Investigation Slip</button> 
															 
															  <button id ='medicalExamForCommonReport' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('MEReport');">Medical Exam Report</button>
													</c:when>
													
													<c:when test="${redirectValue =='MeReport' && countInvesResultEmptystatus!=null && countInvesResultEmptystatus != '0' && msgForPatient == 'rf'}">
											 		 
															 <button id ='investigationSlipReportEmpty' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('MEResultEmpty');">Investigation Slip</button> 
															 
															  <button id ='medicalExamForCommonReportME' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('MEReport');">Medical Exam Report</button>
															  
															   <button id ='referalLetterForReport' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('referal');">Referral Report</button>
													</c:when>
													
													<c:when test="${redirectValue =='MeReport' && countInvesResultEmptystatus!=null && countInvesResultEmptystatus == '0' && msgForPatient == 'rf'}">
											 		 
															 <!-- <button class="btn btn-primary opd_submit_btn" onclick="printReport('MEResultEmpty');">Investigation Slip</button>  -->
															 
															  <button id ='medicalExamForCommonReportME' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('MEReport');">Medical Exam Report</button>
															  
															   <button id ='referalLetterForReport' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('referal');">Referral Report</button>
													</c:when>
													
													
													
													 <c:when test="${redirectValue =='MeReportF18' && countInvesResultEmptystatus eq '0' && msgForPatient != 'rf'}">
											 		 
															 <button id ='medicalExamForCommonReport' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('MEReportF18');">Medical Exam Report</button>
													</c:when>
													
													 <c:when test="${redirectValue =='MeReportF18' && countInvesResultEmptystatus!=null && countInvesResultEmptystatus != '0' && msgForPatient != 'rf'}">
											 		 
															 <button id ='investigationSlipReportEmpty' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('MEResultEmpty');">Investigation Slip</button> 
															 
															  <button id ='medicalExamForCommonReportF18' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('MEReportF18');">Medical Exam Report</button>
													</c:when>
													
													
													<c:when test="${redirectValue =='MeReportF18' && countInvesResultEmptystatus!=null && countInvesResultEmptystatus != '0' && msgForPatient == 'rf'}">
											 		 
															 <button id ='investigationSlipReportEmpty' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('MEResultEmpty');">Investigation Slip</button> 
															 
															  <button id ='medicalExamForCommonReportME' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('MEReport');">Medical Exam Report</button>
															  
															   <button id ='referalLetterForReport' type='button'  class='btn btn-primary opd_submit_btn'   onclick="printReport('referal');">Referral Report</button>
													</c:when>
													
													<c:when test="${redirectValue =='MeReportF18' && countInvesResultEmptystatus!=null && countInvesResultEmptystatus == '0' && msgForPatient == 'rf'}">
											 		 
															  <button id ='medicalExamForCommonReportF18' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('MeReportF18');">Medical Exam Report</button>
															  
															   <button id ='referalLetterForReport' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('referal');">Referral Report</button>
													</c:when>
													
													
													<c:when test="${redirectValue =='MeReportF3A' && countInvesResultEmptystatus eq '0' && msgForPatient != 'rf'}">
											 		 
															 <button id ='medicalExamForCommonReport3A' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('MEReportF3A');">Medical Exam Report</button>
													</c:when>
													
													 <c:when test="${redirectValue =='MeReportF3A' && countInvesResultEmptystatus!=null && countInvesResultEmptystatus != '0' && msgForPatient != 'rf'}">
											 		 
															 <button id ='investigationSlipReportEmpty' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('MEResultEmpty');">Investigation Slip</button> 
															 
															  <button id ='medicalExamForCommonReport3A' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('MEReportF3A');">Medical Exam Report</button>
													</c:when>
													
													
													<c:when test="${redirectValue =='MeReportF3A' && countInvesResultEmptystatus!=null && countInvesResultEmptystatus != '0' && msgForPatient == 'rf'}">
											 		 
															 <button id ='investigationSlipReportEmpty' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('MEResultEmpty');">Investigation Slip</button> 
															 
															  <button id ='medicalExamForCommonReport3A' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('MEReportF3A');">Medical Exam Report</button>
															  
															   <button id ='referalLetterForReport' type='button'  class='btn btn-primary opd_submit_btn'   onclick="printReport('referal');">Referral Report</button>
													</c:when>
													
													 
													
										</c:choose>
												
										
												<!--    -->
										
												<!--  <button class="btn btn-primary opd_submit_btn" onclick="printReport('R');">Referral Letter</button>  -->
										</div> 
											 
											 
											 
													
													
													
												<c:choose>
												<c:when test="${saveInDraft =='draftMa' || saveInDraft =='draftMa18' ||  saveInDraft =='draftMa3A'}">
													<div class="col-md-4 text-right">
														<button class="btn btn-primary opd_submit_btn"
															type="button" onclick="return backListReport('1');"
															id="clicked">Back to List</button>
													</div>
											 	 </c:when>
											 		
											 		<c:when test="${saveInDraft =='draftMo' || saveInDraft =='draftMo18' ||  saveInDraft =='draftMo3A'}">
															<div class="col-md-4 text-right">
														<button class="btn btn-primary opd_submit_btn"
															type="button" onclick="return backListReport('2');"
															id="clicked">Back to List</button>
													</div>
													</c:when>
													
													
													<c:when test="${saveInDraft =='draftRMo' || saveInDraft =='draftRMo18' ||  saveInDraft =='draftRMo3A'}">
															<div class="col-md-4 text-right">
														<button class="btn btn-primary opd_submit_btn"
															type="button" onclick="return backListReport('3');"
															id="clicked">Back to List</button>
													</div>
													</c:when>
													
													
													<c:when test="${saveInDraft =='draftPRMo' || saveInDraft =='draftPRMo18' ||  saveInDraft =='draftPRMo3A'}">
															<div class="col-md-4 text-right">
														<button class="btn btn-primary opd_submit_btn"
															type="button" onclick="return backListReport('4');"
															id="clicked">Back to List</button>
													</div>
													</c:when>
													<c:when test="${redirectValue =='InvestigationReport' && saveStatus=='s'}">
										 
															<div class="col-md-4 text-right">
														<button class="btn btn-primary opd_submit_btn"
															type="button" onclick="return backListReport('5');"
															id="clicked">Back to List</button>
													</div>
								  </c:when>
								  	<c:when test="${redirectValue =='InvestigationReport' && saveStatus=='v'}">
										 
															<div class="col-md-4 text-right">
														<button class="btn btn-primary opd_submit_btn"
															type="button" onclick="return backListReport('6');"
															id="clicked">Back to List</button>
													</div>
								  				</c:when>
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
												<input type="hidden" id="visit_id" name="visit_id"
													value=""/>
												<c:choose>
												<c:when test="${(redirectValue =='MeReport' || redirectValue =='MeReportF18') && ((countInvesResultEmptystatus!=null && countInvesResultEmptystatus != '0')|| msgForPatient =='rf')}">
												<input type="hidden" id="visitIdforInvestigationEmpty" name="visitIdforInvestigationEmpty"
													value="${visitIdForInvestEmpty}"/>
												</c:when>
											 
												
											 
												</c:choose>
											
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
                    if (data.data[0]!=null && data.data[0].visitId != null) {
                    document.getElementById('visit_id').value = data.data[0].visitId;
                }
            });
  </script>              

 

<script type="text/javascript" language="javascript">
            function backListReport(flag) {
            				if(flag=="1"){
                          	 window.location.href ="validateMAWaiting";
            				}
            				if(flag=="2"){
                             	 window.location.href ="validateMOWaiting";
               				}
            				if(flag=="3"){
                            	 window.location.href ="approvalWaitingList";
              				}
            				if(flag=="4"){
                           	 window.location.href ="approvalPerusingWaitingList";
             				}
            				
            				if(flag=="5"){
                             	 window.location.href ="validateMEWaitingForMa";
               				}
              				
           				if(flag=="6"){
                            	 window.location.href ="validateMEWaiting";
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

	var visitId=$('#visit_id').val();
	//alert("flag : "+flag)
	if(flag=='ME'){
		//document.frm.action="${pageContext.request.contextPath}/report/validateMedicalExamReport";
		var urlForReport="${pageContext.request.contextPath}/report/validateMedicalExamReport?visit_id="+visitId;
		openPdfModel(urlForReport) ;
	}
	
	if(flag=='I'){
		//document.frm.action="${pageContext.request.contextPath}/report/printInvestigationSlip";
		var urlForReport="${pageContext.request.contextPath}/report/printInvestigationSlip?visit_id="+visitId;
		 openPdfModel(urlForReport) ;
	}
	
	if(flag=='P'){
		//document.frm.action="${pageContext.request.contextPath}/report/printPrescriptionSlip";
		var urlForReport="${pageContext.request.contextPath}/report/printPrescriptionSlip?visit_id="+visitId;
		 openPdfModel(urlForReport) ;
	}
	
	if(flag=='R'){
		//document.frm.action="${pageContext.request.contextPath}/report/printPrescriptionSlip";
		var urlForReport="${pageContext.request.contextPath}/report/printPrescriptionSlip?visit_id="+visitId;
		 openPdfModel(urlForReport) ;
	}
	if(flag=='MEReport'){
		//document.frm.action="${pageContext.request.contextPath}/report/medicalExamReportReport";
		var urlForReport="${pageContext.request.contextPath}/report/medicalExamReportReport?visit_id="+visitId;
		 openPdfModel(urlForReport) ;
	}
	
	if(flag=='MEResultEmpty'){
		//document.frm.action="${pageContext.request.contextPath}/report/printInvestigationSlipResultEmpty";
		var visitIdforInvestigationEmpty=$('#visitIdforInvestigationEmpty').val();
		var urlForReport="${pageContext.request.contextPath}/report/printInvestigationSlipResultEmpty?visit_id="+visitId+"&visitIdforInvestigationEmpty="+visitIdforInvestigationEmpty;
		 openPdfModel(urlForReport) ;
	}
	
	if(flag=='MEReportF18'){
		//document.frm.action="${pageContext.request.contextPath}/report/medicalExamReportReportF18";
		var urlForReport="${pageContext.request.contextPath}/report/medicalExamReportReportF18?visit_id="+visitId;
		 openPdfModel(urlForReport) ;
	}
	if(flag=='referal'){
		//document.frm.action="${pageContext.request.contextPath}/report/referReportSlipMe";
		var visitIdforInvestigationEmpty=$('#visitIdforInvestigationEmpty').val();
		var urlForReport="${pageContext.request.contextPath}/report/referReportSlipMe?visit_id="+visitId+"&visitIdforInvestigationEmpty="+visitIdforInvestigationEmpty;
		 openPdfModel(urlForReport) ;
	}
	
	if(flag=='MEReportF3A'){
		//document.frm.action="${pageContext.request.contextPath}/report/medicalExamReportReportF3A";
		var urlForReport="${pageContext.request.contextPath}/report/medicalExamReportReportF3A?visit_id="+visitId;
		 openPdfModel(urlForReport) ;
	}
	
	//document.frm.method="POST";
	//document.frm.submit(); 
	
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
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
</html>