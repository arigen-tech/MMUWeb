<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
 <%@page import="com.mmu.web.utils.HMSUtil"%>
<%@include file="..//view/leftMenu.jsp" %>
<%@include file="..//view/commonJavaScript.jsp" %>


    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Indian Coast Guard</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
<%
	String hospitalId = "1";
	if (session.getAttribute("hospital_id") != null) {
		hospitalId = session.getAttribute("hospital_id") + "";
	}
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	
%>
<%long valueRegistrationTypeId = Long.parseLong(HMSUtil.getProperties("js_messages_en.properties", "REGISTRATION_TYPE_ICG_ID")); %>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/uploaddig.js"></script>

<script type="text/javascript">
var hsId=<%=hospitalId%>;
$(document).ready(
		function() { 
			openExamSubType('0');
		});
	
	</script>
</head>

<body>

    <!-- Begin page -->
    <div id="wrapper">
        
        <div class="content-page">
            <!-- Start content -->
            <div class="">
                <div class="container-fluid">
                	<div class="internal_Htext">Medical Board New Entry</div>
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">                                	
                                <form:form name="newEntryMEMEBFormId" id="newEntryMEMEBFormId" method="post"
									action="${pageContext.request.contextPath}/medicalBoard/newEntryMEMEBForm" autocomplete="on">
									<input type="hidden" id="patientId" name="patientId"/>
									<input type="hidden" id="uhidNo" name="uhidNo"/>
									<input type="hidden" id="serviceNo1" name="serviceNo1"/>
									<input type="hidden" id="relationId" name="relationId"/>
									<input type="hidden" id="registrationTypeId" name="registrationTypeId" value="<%=valueRegistrationTypeId%>"/>
									<input type="hidden" id="empName" name="empName"/>
									<input type="hidden" id="employeeId" name="employeeId"/>
									<input type="hidden" id="empRankId" name="empRankId"/>
									<input type="hidden" id="empTradeId" name="empTradeId"/>
									<input type="hidden" id="empUnitId" name="empUnitId"/>
									<input type="hidden" id="empMaritalStatusId" name="empMaritalStatusId"/>
									<input type="hidden" id="empRecordOfficeId" name="empRecordOfficeId"/>
									<input type="hidden" id="empServiceJoinDate" name="empServiceJoinDate"/>
									<input type="hidden" id="name" name="name"/>
									<input type="hidden" id="dateOfBirth" name="dateOfBirth"/>
									<input type="hidden" id="genderId" name="genderId"/>
									<input type="hidden" id="age" name="age"/>
									<input type="hidden" id="visitId" name="visitId"/>
	                               		<div class="row">
	                               			<div class="col-md-4">
	                                			<div class="form-group row">
	                                				<div class="col-md-5">
	                                					<label class="col-form-label" >Service No.</label>
	                                				</div>
	                                				<div class="col-md-7">
	                                					<input type="text" class="form-control" name="serviceNo" id="serviceNo" onBlur="return getPatientListForUp();"/>
	                                				</div>
	                                			</div>
	                                		</div>
	                                		<div class="col-md-4">
	                                			<div class="form-group row">
	                                				<div class="col-md-5">
	                                					<label class="col-form-label" >Employee Name</label>
	                                				</div>
	                                				<div class="col-md-7">
	                                					<input type="text" class="form-control" name="employeeName" id="employeeName" value=""  readonly/>  
	                                					<!-- <select class="form-control" id="employeeName" name="employeeName" disabled> -->
	                                					<!-- </select> -->
	                                				</div>
	                                			</div>
	                                		</div>
	                               			<!-- <div class="col-md-4">
	                                			<div class="form-group row">
	                                				<div class="col-md-5">
	                                					<label class="col-form-label" >Document Type</label>
	                                				</div>
	                                				<div class="col-md-7">
														<select class="form-control" id="documentType" name="documentType" onblur="changeOptionValue(this.value)">
															<option value="0">Select</option>
															<option value="ME">Medical Exam</option>
															<option value="MB">Medical Board</option>
															<option value="Others">Others</option>
														</select>
														
	                                				</div>
	                                			</div>
	                                		</div>
	                                		<div class="col-md-4">
	                                			<div class="form-group row">
	                                				<div class="col-md-5">
	                                					<label class="col-form-label">Document Category</label>
	                                				</div>
	                                				<div class="col-md-7">
													<select class="form-control" id="examTypeId"
														name="examTypeId">
														<option value="">Select</option>
													</select>
	                                				
	                                				</div>
	                                			</div>
	                                		</div> -->
 	                                		<!-- </div>
	                               		<div class="row"> -->
	                               		
	                                		
	                                		<input type="button" id="newEntry"
														class="btn btn-primary m-t-5"
														onClick="return newMbEntryForm('newEntryMEMEBForm');" value="New Entry" />
	                                		
	                                		
	                                	</div>
	                                	</form:form>
	                                	
	                                	
	                               		
                                </div>
                            </div>
                        </div>
                    </div>
           
                </div>
                <!-- container -->

            </div>
            <!-- content -->

        </div>

        <!-- ============================================================== -->
        <!-- End Right content here -->
        <!-- ============================================================== -->

    </div>
    <!-- END wrapper -->

    <!-- jQuery  -->
<script>

 $(function(){
	$(document).on('click','.calDate',function(){
		
		$j(this).datepicker({ showOn: "button",
			buttonImage: "../resources/images/calendar.gif",		
			buttonImageOnly: true,
			buttonText: 'Select Date',
			yearRange: '1900:2090',selectWeek:false,closeOnSelect:true,  changeMonth: true, changeYear: true,clickInput:false});
		
		
	});
}) 

function checkDate(count){
	 var doeDate = $('#doeDate'+count).val();
	 var domDate = $('#domDate'+count).val();
	 
	 if(process(doeDate) < process(domDate)){
			alert("Expiry Date should not be earlier than Manufacturing Date");
			$('#doeDate'+count).val("");
			return;
	 }
 }
 
 
 function openExamSubType(appTypeId){
	
		var pathname = window.location.pathname;
	     var accessGroup = "MMUWeb";
		 var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/registration/getExamSubType";

	 var params = {
						"appTypeId":appTypeId,
						"onlineOffline":'off'
					 } 	
						$j.ajax({
							type : "POST",
							contentType : "application/json",
							url :  url,
							data : JSON.stringify(params),
							dataType : "json",
							cache : false,
							success : function(response) {
								if(response.status=="1"){
									var  subTypeList = response.masExamList;
									var  appType = response.appTypeId;
									var examValues=''; 
									for(exam in subTypeList){
										 examValues += '<option value='+subTypeList[exam].examId+'@@'+subTypeList[exam].medicalExamCode+'@@'+subTypeList[exam].apponmentTypeId+'>'
														+ subTypeList[exam].examName
														+ '</option>';
									 }
										$j('#examTypeId').append(examValues); 
								} 
						},
							error : function(msg) {
								alert("An error has occurred while contacting the server");
							}
					}); 
	}
 
 function changeOptionValue(val)
 {
	 var optionVal=val;
	 if(optionVal=="Others")
	 {
		 document.getElementById("examTypeId").disabled = true; 
	 }
	 else
	{
		 document.getElementById("examTypeId").disabled = false;  
	} 
 }
 
 function newMbEntryForm(){
	 var age=$('#empMaritalStatusId').val();
	 var examTypeId=$('#examTypeId').val();
	 /*if(examTypeId!="" && examTypeId!="0"){
		 var examTypeIds=examTypeId.spilt("")
	 }*/
   	 var serviceNo=$j('#serviceNo').val();
     
	 if(serviceNo=="" ){
		 alert("Please enter service Number.");
		 return false;
	 }
 
	 
	 
	 
	 
	 var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";

     var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/saveOpdEmergency";
     
     var dataJSON = {
    		 'serviceNo':$('#serviceNo1').val(),
             'uhidNo': $('#uhidNo').val(),
             'relationId':$('#relationId').val(),
             'registrationTypeId':$('#registrationTypeId').val(),
             'departmentId':'3',
             'visitFlag':'R',
             'priorityId':'1',
             'empName':$('#empName').val(),
             'employeeId':$('#employeeId').val(),
             'empRankId':$('#empRankId').val(),
             'empTradeId':$('#empTradeId').val(),
             'empUnitId':$('#empUnitId').val(),
             'empMaritalStatusId':$('#empMaritalStatusId').val(),
             'empRecordOfficeId':$('#empRecordOfficeId').val(),
             'empServiceJoinDate':$('#empServiceJoinDate').val(),
             'name':$('#name').val(),
             'dateOfBirth':$('#dateOfBirth').val(),
             'genderId':$('#genderId').val(),
             'hospitalId':hsId,
             'examTypeId':'5',
             'documentType':'MB'
     }
	 //$("#clicked").attr("disabled", true);
     $("#newEntry").attr("disabled", true);
     $.ajax({
         type: "POST",
         contentType: "application/json",
         url: url,
         data: JSON.stringify(dataJSON),
         dataType: 'json',
         success: function(data) {
        	 var dataList=data.data;
         	console.log(dataList)
         	var visitId = dataList.visitId;
            if (visitId!=null && visitId!="")
             {
            	//alert("visitId "+visitId)
            		 
            		 var newEntryStatus='yes';
            	 window.location.href = "newMbAFMSForm?visitId="+visitId+"&age="+age+"&examTypeId="+'5@@MB15@@undefined'+"&viewOrEditFlag=yes"+"&newEntryStatus="+newEntryStatus;
            	
            	 //$("#newEntryMEMEBFormId").submit();
            	//	$('#newEntry').attr('diasable',true);
             } 
             else if(dataList.status == 0)
             {
              $("#newEntry").attr("disabled", false);		 
              alert(dataList.msg)	
             }	
             else
             {
            	 $("#newEntry").attr("disabled", false);
                 alert("Please enter the valid data")
             }
         	
         },
         error: function(jqXHR, exception) {
         	$("#clicked").attr("disabled", false);
             var msg = '';
             if (jqXHR.status === 0) {
            	 $("#newEntry").attr("disabled", false);
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
             alert("Response msg is "+msg);
         }
     });

 }

</script>
</body>

</html>