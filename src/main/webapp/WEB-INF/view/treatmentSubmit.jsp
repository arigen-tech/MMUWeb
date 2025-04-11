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
                            <title>OPD Main</title>
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
	 
	  <div class="internal_Htext">Prescription Audit</div>
	  

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                <input type="hidden" name="empCategory" id="empCategory" value=""/>
                                <input type="hidden" name="siqValue" id="siqValue" value=""/>
                                <input type="hidden" name="flagForFwc" id="flagForFwc" value=""/>
                                <c:choose>
                                <c:when test="${msgRecall !=''}">
                                <p><span class="submitMsg">Prescription audit submitted successfully</span> </p>   
                                </c:when> 
                                <c:otherwise>
                                	<p><span class="submitMsg">Prescription audit submitted successfully</span> </p>
                                </c:otherwise>
                                </c:choose>
                                
                                
                                
                                <div id="opd_submit">  
                                     <div class="row">
										<div class="col-md-12 text-right"> 
												<!-- <button id ='caseSheetReportForOpdSubReport' type='button'  class='btn btn-primary opd_submit_btn'    onclick="printReport('C');">OPD Slip</button> 
										
												  <button id ='prescriptionSlipReport' type='button'  class='btn btn-primary opd_submit_btn' onclick="printReport('P');">MLC Slip</button> 
										
												 <button id ='referalLetterForReport' type='button'  class='btn btn-primary opd_submit_btn'  onclick="printReport('R');">Referral Letter</button>
												  
												 <button style="display:none;"  type='button'  class='btn btn-primary opd_submit_btn'  id="siqReport" onclick="printReport('D');">SIQ</button>  -->
										
												<c:choose>
												<c:when test="${redirectValue =='opdRecall'}">
													
														<button class="btn btn-primary opd_submit_btn"
															type="button" onclick="return backListReport('2');"
															id="clicked">Back to List</button>
													
												</c:when>

												<c:otherwise>
													
														<button class="btn btn-primary opd_submit_btn"
															type="button" onclick="return backListReport('1');"
															id="clicked">Back to List</button>
													
												</c:otherwise>
											</c:choose>
										
										</div> 
										
										<!-- <div class="col-md-2"> 
												<button class="btn btn-primary opd_submit_btn"   type="button" onclick="return backListReport('1');" id="clicked">Back to List</button>  
										</div> -->

											


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


</div>
  
  
  
  <script type="text/javascript">
            var flagForFwc='';
            $(document).ready(function() {
                /* if (typeof element !== "undefined" && element.value == '') {
                } */
                var empCatRank=localStorage.empCatRank;
           	    document.getElementById('empCategory').value = empCatRank;
           	    var siqValue=localStorage.siqValue;
        	    document.getElementById('siqValue').value = siqValue;
        	    
        	    flagForFwc=localStorage.flagForFwc;
        	    document.getElementById('flagForFwc').value = flagForFwc;
        	    
        	     
           	   if(((empCatRank!="" && empCatRank=="OFFICERS" && siqValue!="" && siqValue=="Y")||( '${empCategory}'=='OFFICERS'  && '${siqValue}'=='Y')))
           	   {
           		$('#siqReport').show(); 
           	   }
           	   else
           	   {
           		$('#siqReport').hide();  
           	   } 
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
                          	 window.location.href ="auditWaitingList";
            				}
            				if(flag=="2"){
                             	 window.location.href ="auditWaitingList";
               				}
            }
            
            
            
 </script>           
<script type="text/javascript" language="javascript">
var visitIdValue="";
function executeClickEvent()
{
	 //alert(Id)
	 var visitIdValue=$('#visit_id').val();
	 window.location="getCaseSheet?visitId="+visitIdValue+"";
	
}

function printReport(flag) {
	var visitId=$('#visit_id').val();
	//alert("flag : "+flag)
	/* if((flag=='C' && '${flagForFwc}'=='fwc')||(flag=='C' && flagForFwc=='fwc'))
	{	
	  // document.frm.action="${pageContext.request.contextPath}/report/fwcPrintCaseSheet";
		
		var fwcPrintCaseSheet="${pageContext.request.contextPath}/report/fwcPrintCaseSheet?visit_id="+visitId;
		openPdfModel(fwcPrintCaseSheet); 
	} */
	if(flag=='C')
	{
		// && '${flagForFwc}'!='fwc')||(flag=='C' && flagForFwc!='fwc') 
		//document.frm.action="${pageContext.request.contextPath}/report/printCaseSheet";
		var printCaseSheet="${pageContext.request.contextPath}/report/printCaseSheet?visit_id="+visitId;
		openPdfModel(printCaseSheet); 
	}	
	
	
	else if(flag=='P'){
		//document.frm.action="${pageContext.request.contextPath}/report/printPrescriptionSlip";
		var printPrescriptionSlip="${pageContext.request.contextPath}/report/mlcSlip?visit_id="+visitId;
		openPdfModel(printPrescriptionSlip); 
	}
	
	else if(flag=='R'){
		//document.frm.action="${pageContext.request.contextPath}/report/referReportSlip";
		var referReportSlip="${pageContext.request.contextPath}/report/referReportSlip?visit_id="+visitId;
		openPdfModel(referReportSlip); 
	}
	else if(flag=='D'){
		//document.frm.action="${pageContext.request.contextPath}/report/siqReportSlip";
		var siqReportSlip="${pageContext.request.contextPath}/report/siqReportSlip?visit_id="+visitId;
		 openPdfModel(siqReportSlip); 
		
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
<script>
var data = ${data};
if(data!=null && data!=""){
var visit_id = data.visitId;
	document.getElementById('visit_id').value =visit_id;
}
</script>
</html>
 <%@include file="..//view/modelWindowForReportsMultiple.jsp"%>