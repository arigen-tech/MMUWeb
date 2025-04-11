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
                       <title>Medical Transcription Submitted</title>
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

<div class="content-page">
                                <!-- Start content -->
 <div class="">
  <div class="container-fluid">
	 
	  <div class="internal_Htext">Medical Transcription</div>
	  

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                <p class="submitMsg">Medical Transcription Details Submitted Successfully </p>    
                                <div id="opd_submit">  
                               
                                <input type="hidden" id="visit_id" name="visit_id" value=""/>
                                     <div class="row">
										<div class="col-md-8"> 
										        <button class=" btn btn-primary opd_submit_btn" id="printReportButtonAmsf"  onclick="printReport('C');">AMSF-15</button> 
									            <button class="btn btn-primary opd_submit_btn" id="printReportButtonChecklist"  onclick="printReport('R');">AMSF-15 CheckList</button>
										
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
                          	 window.location.href ="transcriptionWaitingList";
            				}
            				if(flag=="2"){
                             	 //window.location.href ="opdPatientRecall";
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
	if(flag=='C')
	{		var amsfUrl="${pageContext.request.contextPath}/report/mbAmsf15Report?visit_id="+visitIdValue;
		openPdfModel(amsfUrl);
	}
	if(flag=='R')
	{	
		var checkListUrl="${pageContext.request.contextPath}/report/mbAmsf15ReportCheckList?visit_id="+visitIdValue;
		openPdfModel(checkListUrl);
	}
	if(flag=='P')
	{
	   //document.frm.action="${pageContext.request.contextPath}/report/printPrescriptionSlip";
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