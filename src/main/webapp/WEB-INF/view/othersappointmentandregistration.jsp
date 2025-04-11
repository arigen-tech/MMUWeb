<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="com.mmu.web.utils.HMSUtil"%>
<%@include file="..//view/leftMenu.jsp"%>
<%@include file="..//view/commonJavaScript.jsp"%>
<%@page import="org.json.JSONObject"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Jekyll v3.8.5">
    <title>Indian Coast Guard</title>
<style>
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }
        
        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }
</style>

<%
		HttpSession sessionJsp = request.getSession(false);// don't create if it doesn't exist
		if(sessionJsp == null || sessionJsp.isNew()) {
		return;
		}
		
	String rspData = "";
	JSONObject responseData = null;
	if (request.getAttribute("data") != null) {
		rspData = (String) request.getAttribute("data");
		responseData = new JSONObject(rspData);
	}

	long APPOINTMENTTYPE_OPD = 0;
	if (responseData != null) {
		APPOINTMENTTYPE_OPD = responseData.getLong("appointmentTypeIdOPD");
	}
%>
    <% int REGISTRATION_TYPE_OTHER_CIVIL_ID = Integer.parseInt(HMSUtil.getProperties("js_messages_en.properties", "REGISTRATION_TYPE_OTHER_CIVIL_ID")); %>
    <% int REGISTRATION_TYPE_OTHER_DEFENCE_ID = Integer.parseInt(HMSUtil.getProperties("js_messages_en.properties", "REGISTRATION_TYPE_OTHER_DEFENCE_ID")); %>
    <% String REGISTRATION_TYPE_NAME = HMSUtil.getProperties("js_messages_en.properties", "REGISTRATION_TYPE_NAME_ICG"); %>
    <% String visitFlagForReception =HMSUtil.getProperties("js_messages_en.properties", "VISIT_FLAG_FOR_RECEPTION"); %>
    <% String registrationTypeFlagOther =HMSUtil.getProperties("js_messages_en.properties", "REGISTRATION_TYPE_FLAG_OTHER"); %>

<script src="${pageContext.request.contextPath}/resources/js/reception.js"></script> 
</head>

<body>
 <!-- Begin page -->
    <div id="wrapper">
		<div class="content-page">
			<div class="">
				<div class="container-fluid">
				<div class="internal_Htext">Registration &amp; Appointment  Of Other</div>
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<!--  below commented area will open after updaload image will work -->
								<!-- <div class="row">
							<div class="col-md-9"></div>
							<div class="col-md-3">
								<div class="form-group">
								 <div class="row" style="padding-bottom: 10px;">
										<div class="col-md-3"></div>
										<div class="col-md-6">
											<div class="main-img-preview"
												style="width: 60%; height: 60%;">
												 <img class="img-responsive thumbnail img-preview" src="images/user.png" title="Preview Logo">
											</div>
										</div>
										<div class="col-md-3"></div>

									</div>  
									<div class="row">
										<div class="col-md-1"></div>
										<div class="col-md-10">

											<div class="input-group">
												<input id="fakeUploadLogo" class="form-control fake-shadow"
													placeholder="Choose File" disabled="disabled">
												<div class="input-group-btn">
													<div class="fileUpload btn btn-danger fake-shadow">
														<span><i class="glyphicon glyphicon-upload"></i>Upload Image</span>
															 <input id="logo-id" name="logo" type="file"	class="attachment_upload">
													</div>
												</div>
											</div>
										</div>
										<div class="col-md-1"></div>
									</div>
								</div>
							</div>
						</div>   -->
								<!--  Above commented area will open after updaload image will work -->

						<form id="patientDetailsFormOthers" name="patientDetailsFormOthers"
						action="" method="POST">
								<div class="row">
									<div class="col-md-6">
										<div class="form-check form-check-inline cusRadio">
											<input class="form-check-input" type="radio" name="radiobtn" id="radiobtn1" value="NEW">
												<span class="cus-radiobtn"></span> 
												 <label class="form-check-label" for="radiobtn1">New Registration</label>
										</div>
										<div class="form-check form-check-inline cusRadio">
											<input class="form-check-input" type="radio" name="radiobtn"
												id="radiobtn2" value="ALREADY">
												<span class="cus-radiobtn"></span>
												 <label
												class="form-check-label" for="radiobtn2">Already
												Registered</label>
										</div>
									</div>
									 <div class="col-md-6">
								    </div>
							</div><br>

									 
									<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<label  id="lblregistrationType" name="lblregistrationType" class="col-md-5 col-form-label">Registration
														Type</label>
														<div class="col-md-7">
															<select class="form-control" id="registrationTypeId"
																name="registrationType" onchange="changeFields();">
															</select>
														</div>
												</div>
											
											   </div>
											   	<div class="col-md-4">
														<div class="form-group row">
															<label id="lblService" class="col-md-5 col-form-label">Service No.<span class="mandate"><sup>&#9733;</sup></span></label>
															<div class="col-md-7">
																<input type="text" class="form-control" id="serviceNo"
																	name="serviceNo" placeholder="Enterable" maxLength="20">
															</div>
														</div>
													</div> 
											   <div class="col-md-4">														 
													</div> 
									</div>
									<!------------------ Adding search part in between ---------->

									<div class="opdMain_detail_area" id="searchDiv"
										style="display: none">
										<h4 class="service_htext">Search Patient</h4>
										<div class="row">
											<div class="col-md-12">
												<div class="row">
													<div class="col-md-4">
														<div class="form-group row">
															<label id="lbluhino" class="col-md-5 col-form-label">UHID
																NO.</label>
															<div class="col-md-7">
																<input type="text" class="form-control" id="UhidNoId"
																	name="UhidNo" placeholder="Enterable">
															</div>
														</div>
													</div>

													<div class="col-md-4">
														<div class="form-group row">
															<label id="lblName" class="col-md-5 col-form-label">Name</label>
															<div class="col-md-7">
																<input type="text" class="form-control" id="patientName"
																	name="patientName" placeholder="Enterable">
															</div>
														</div>
													</div>

													<div class="col-md-4">
														<div class="form-group row">
															<label id="searchlblService"
																class="col-md-5 col-form-label">Service No.</label>
															<div class="col-md-7">
																<input type="text" class="form-control"
																	id="searchServiceNo" name="searchServiceNo"
																	placeholder="Enterable">
															</div>
														</div>
													</div>
													<div class="col-md-4">
														<div class="form-group row">
															<label id="mobileNo" class="col-md-5 col-form-label">Mobile
																Number</label>
															<div class="col-md-7">
																<input type="text" class="form-control"
																	id="searchMobileNo" name="searchMobileNo"
																	placeholder="Enterable" maxLength="10"  onkeypress="checkNumberFormat('searchMobileNo');">
															</div>
														</div>
													</div>
													

													<div class="col-md-4">

														<button class="button btn btn-primary" type="button"
															onClick="searchPatientDetail()">Search</button>
													
														<span align="center" id="message" class="m-l-10"
															style="color: green; font-weight: bold;"></span>

													</div>
												</div>
											</div>
										</div>
									</div>

									<div id="tblPatientList" style="display: none">
										<table class="table table-striped table-bordered  ">
											<thead>
												<tr>
													<th id="th1">UHID No</th>
													<th id="th2">Service No</th>
													<th id="th3">Name</th>
													<th id="th4">Age</th>
													<th id="th5">Gender</th>
													<th id="th6">Mobile No</th>
													<th id="th7">Category</th>
												</tr>
											</thead>
											<tbody id="tblPatientDetails">
											</tbody>
										</table>
									</div>


									<!------------------ Adding search part in between ---------->

									<div class="col-md-6"></div>
	
									<div class="col-md-6">
										<input type="hidden" class="form-control" id="visitFlag"
											name="visitFlag" value="<%=visitFlagForReception%>">
										
										<input type="hidden" class="form-control" id="flagOther"
											name="flagOther" value="<%=registrationTypeFlagOther%>">	
											
											
										<input type="hidden" class="form-control" id="userId"
											name="userId"  value="<%=session.getAttribute("user_id")%>">
																	
										<input type="hidden" class="form-control" id="hospitalId"
											 name="hospitalId"  value="<%=session.getAttribute("hospital_id")%>">
											
									</div>
									<!-- </div> -->
									<br>

									<!-- Below code need to put into div -->

									<input type="hidden" class="form-control" id="uhidNoPatient"
										name="uhidNoPatient" value="">
									<!-- Above code need to put into div -->
									
					<div class="opdMain_detail_area" id="patientDetailsOthersDiv">
									<h4 class="service_htext">Patient Details</h4>
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Name<span class="mandate"><sup>&#9733;</sup></span></label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="firstname"
														name="firstname" placeholder="Enterable" maxLength="99">
												</div>
											</div>
										</div>

										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label"> Gender<span class="mandate"><sup>&#9733;</sup></span></label>
												<div class="col-sm-7">
													<select class="form-control" id="genderId" name="gender">
														<option value="0" selected="selected">Select</option>
													</select>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label"> DOB<span class="mandate"><sup>&#9733;</sup></span></label>
												<div class="col-sm-7">
													<div class="dateHolder">
													<input type="text" class="calDate datePickerInput form-control" id="dataOfBirthId"
														 name="dataOfBirth" placeholder="DD/MM/YYYY" 
														 onkeyup="mask(this.value,this,'2,5','/')" onblur="validateExpDate(this,'dataOfBirthId');" maxlength="10"
														 onchange="calculateAge()"></div> 
														
											<!-- <input type="date" class="form-control" id="dataOfBirthId" name="dataOfBirth" placeholder="DOB"
														onblur="calculateAge()"> -->
									 			
												</div>

											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label"> Age<span class="mandate"><sup>&#9733;</sup></span></label>
												<div class="col-sm-7">
													<input readonly type="text" class="form-control" id="age"
														name="age" placeholder="E/A">
												</div>
											</div>
										</div>

										<div class="col-md-4">
											<div class="form-group row">
												<label id="lblServiceType" class="col-sm-5 col-form-label"> Type of
													Service<span class="mandate"><sup>&#9733;</sup></span></label>
												<div class="col-sm-7">
													<select id="serviceTypeId" name="serviceTypeId"
														class="form-control">
														<option value="0" selected="selected">Select</option>
													</select>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label id="lblRank" class="col-sm-5 col-form-label">Rank<span class="mandate"><sup>&#9733;</sup></span></label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="rankId"
														name="rank" maxLength="20" placeholder="Enterable">
												</div>

											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Mobile Number<span class="mandate"><sup>&#9733;</sup></span></label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="mobilenumber"
														name="mobilenumber" placeholder="Enterable" maxLength="10"
														onblur="return validateLenght('mobilenumber',10, 'Mobile Number');" onkeypress="checkNumberFormat('mobilenumber');">
												</div>
											</div>
										</div>

										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label"> ID Type</label>
												<div class="col-sm-7">
													<select class="form-control" id="identificationId"
														name="identification"  onchange="resetIDnumber()">
														<option value="0" selected="selected">Select</option>
													</select>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">ID Number</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="idnumber"
														name="idnumber" placeholder="Enterable" maxlength="10" onblur=" return checkIDType()" >
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<label id="lblEmpName" class="col-sm-5 col-form-label">Employee Name</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="empName"
														name="empName" placeholder="Enterable" maxlength="18" >
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<label id="lblRelation" class="col-sm-5 col-form-label">Relation</label>
												<div class="col-sm-7">
													<select class="form-control" id="relationId"
														name="relationId"  onchange="resetRelation()">
														<option value="0" selected="selected">Select</option>
													</select>
												</div>
											</div>
										</div>
										
										<div class="col-md-4"></div>

									</div>
					</div>
                                      
                                <div class="opdMain_detail_area" id="visitDetailsDiv">
									<h4 class="service_htext">Visit Details</h4>

									<div class="row">
										<div class="col-md-12">
											<div class="row">
												<div class="col-md-4">
													<div class="form-group row">
														<label class="col-sm-5 col-form-label">Department</label>
														<div class="col-sm-7">
															<select class="form-control" id="departmentId"
																name="department" onchange="getAppointmentType()">
																<option value="0" selected="selected">Select</option>
															</select>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<label class="col-sm-5 col-form-label">Priority</label>
														<div class="col-sm-7">
															<select id="priority" name="priority"
																class="form-control">
																<option value="1">High</option>
																<option value="2">Medium</option>
																<option value="3" selected="selected">Low</option>
															</select>
														</div>
													</div>
												</div>
												<div class="col-md-4"></div>
											</div>
											</div>
											
											<div class="col-md-12">
												<div class="showOPDRow p-t-10" style="display:none;">
													<div class="row">
														<div class="col-4">
														
															<div class="row">
																<div class="col-md-5">
																	<table border="0" cellspacing="0" cellpadding="0" id="appTypeTable" width="100%" class="m-l-5"></table>
																</div>
																<div class="col-sm-7">
																		<div id="displayToken"  class="form-group"></div>
																</div>
															</div>
														</div>
														
													</div>
																								
												</div>
											</div>
											
											
												<div class="col-sm-12">
													<button style="display:none" class="button btn btn-primary" type="button"
														onClick="validateDivToken()">Show Token</button>
												</div>
												
											
										</div>
								</div>
 
									
							<div class="clearfix"></div>
									<br>
					            <div class="row"  id="submitDiv"> 
								      <div class="col-md-12">
											<div class="btn-left-all"> 
											</div> 
											<div class="btn-right-all">
											<button class="btn btn-primary" id='submitbtn' type="button"
								           onclick="submitFormData()">Submit</button>
											</div> 
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
	
	
 <script>

 $j(document).ready(function() {
 	
     $j(function() {
         var $radios = $j('input:radio[name=radiobtn]');
         if($radios.is(':checked') === false) {
             $radios.filter('[value=NEW]').prop('checked', true);
         }
     });
     
     
     $j('input[type="radio"]').click(function(){
     	 $j('#tblPatientList').hide();
     	 $j('#tblPatientDetails').empty();
     	 resetGrid();
         var inputValue = $j(this).attr("value");
         
         if(inputValue=="ALREADY"){
         	$j('#searchDiv').show();
         	$j('#serviceNo').hide();
         	$j('#lblService').hide();
         	
         	$j('#registrationTypeId').val("<%=REGISTRATION_TYPE_OTHER_DEFENCE_ID%>");
         	$j('#searchlblService').show();
         	$j('#searchServiceNo').show();
         	
         	// Added new code
         	 $j('#patientDetailsOthersDiv').hide();
         	 $j('#visitDetailsDiv').hide();
         	 $j('#submitDiv').hide();
        	
         }else{
         	$j('#searchDiv').hide();
         	 $j('#patientDetailsOthersDiv').show();
        		 $j('#visitDetailsDiv').show();
        		 $j('#submitDiv').show();
        		 $j('#departmentId').val('0');
        		 $j('#appTypeTable').empty();
     		 $j('#displayToken').empty();
     		 
         	if($j('#registrationTypeId').val()=="<%=REGISTRATION_TYPE_OTHER_DEFENCE_ID%>"){
         		$j('#lblService').show();
             	$j('#serviceNo').show();
             	
             	$j('#lblServiceType').show();
         		$j('#serviceTypeId').show();
         		$j('#lblRank').show();
         		$j('#rankId').show();
         		
         		$j('#lblEmpName').show();
         		$j('#empName').show();
         		$j('#lblRelation').show();
         		$j('#relationId').show();
             	//111111
         	}else{
         		$j('#lblService').hide();
             	$j('#serviceNo').hide();
             	$j('#lblServiceType').hide();
         		$j('#serviceTypeId').hide();
         		$j('#lblRank').hide();
         		$j('#rankId').hide();
         		
         		$j('#lblEmpName').hide();
         		$j('#empName').hide();
         		$j('#lblRelation').hide();
         		$j('#relationId').hide();
         		//222222
         	}
         // Added new code
         }
     });   
     
     getRegistrationAndAppointmentOthers("<%=REGISTRATION_TYPE_NAME %>");
     
 });
</script>

<script>

function getAppointmentType(){
	var deptId = $j('#departmentId').find('option:selected').val();
	var hospitalId = $j('#hospitalId').val();
	if(deptId!=0){
		var params = {
				"deptId":deptId,
				"hospitalId":hospitalId
		}
		$j.ajax({
			type : "POST",
			contentType : "application/json",
			url : '${pageContext.request.contextPath}/appointment/getLocationWiseAppointmentType',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(data) {
				if (data.status == '1') {
					var checkboxorder = [];
					var labelId = [];
					var idandType = [];
					var checkboxLength = data.appointmentTypeList.length;
					for(var a = 0;a< checkboxLength;a++){
						checkboxorder[a] = data.appointmentTypeList[a].appointmentTypeName;
						labelId[a] = data.appointmentTypeList[a].appointmentTypeId;
						idandType[a] = checkboxorder[a]+'@'+ labelId[a];
						
					}
					var tablebody = '<tr>';
					var tokenDisplay = '';
					$j('#appTypeTable').empty();
					$j('#displayToken').empty();
					x=0;
					for(var z=0;z<checkboxLength;z++){
						var checkBoxIdandValue = idandType[z].split("@");
						if(checkBoxIdandValue[1]==APPOINTMENTTYPE_OPD){
						//tablebody += '<input type="checkbox" checked id ="td'+checkBoxIdandValue[0]+'" name="checkDiv" value="'+checkBoxIdandValue[1]+'"><span id="td'+z+'">'+checkBoxIdandValue[0]+'</span></br>';
						tablebody += '<td>';
						tablebody += '<div class="form-check form-check-inline cusCheck"><input type="checkbox" class="form-check-input"  id ="tdOPD" name="checkDiv" value="'+checkBoxIdandValue[1]+'" onclick="checkClickEvent()"><span class="cus-checkbtn"></span><span id="td'+z+'">'+checkBoxIdandValue[0]+'</span></div></br>';
						break;
						}else{
							if(x==checkboxLength-1){
								alert("Appointment Type OPD is not available");
								return;
							}
							x++;
						}
					}
					$j('#appTypeTable').append(tablebody);	
					$j('.showOPDRow').show();
				}else{
					alert("Appointment Type is not available.");
					$j('#appTypeTable').empty();	
					$j('.showOPDRow').show();
				}
			},
			error : function(msg) {
				alert("An error has occurred while contacting the server");
			}
		});
	}else{
		$j('#appTypeTable').empty();
		$j('#displayToken').empty();
	}
}


function changeFields(){
	 $j('#tblPatientList').hide();
	 $j('#tblPatientDetails').empty();
	 resetGrid();
	var radioValue = $j("input[name='radiobtn']:checked").val();
	if(radioValue=="ALREADY"){
		if($j('#registrationTypeId').val()==<%=REGISTRATION_TYPE_OTHER_CIVIL_ID%> ){
			$j('#lblService').hide();
 		$j('#serviceNo').hide();
			$j('#searchlblService').hide();
 		$j('#searchServiceNo').hide();
 		
 		
 		$j('#lblServiceType').hide();
 		$j('#serviceTypeId').hide();
 		$j('#lblRank').hide();
 		$j('#rankId').hide();
 		
 		$j('#lblEmpName').hide();
 		$j('#empName').hide();
 		$j('#lblRelation').hide();
 		$j('#relationId').hide();
 		
 		//2222222
 		
 		 $j('#patientDetailsOthersDiv').hide();
    		 $j('#visitDetailsDiv').hide();
    		 $j('#submitDiv').hide();
 		
		}else{
			$j('#searchlblService').show();
 		$j('#searchServiceNo').show();
		}
	}else{
		//Condition for new registration 
		if($j('#registrationTypeId').val()==<%=REGISTRATION_TYPE_OTHER_CIVIL_ID%> ){
			
			$j('#lblService').hide();
 		$j('#serviceNo').hide();
			$j('#searchlblService').hide();
 		$j('#searchServiceNo').hide();
 		
 		
 		$j('#lblServiceType').hide();
 		$j('#serviceTypeId').hide();
 		$j('#lblRank').hide();
 		$j('#rankId').hide();
 		
 		$j('#lblEmpName').hide();
 		$j('#empName').hide();
 		$j('#lblRelation').hide();
 		$j('#relationId').hide();
 		
 		//2222222
		}else{
			$j('#lblService').show();
 		$j('#serviceNo').show();
 		$j('#lblServiceType').show();
 		$j('#serviceTypeId').show();
 		$j('#lblRank').show();
 		$j('#rankId').show();
 		
 		$j('#lblEmpName').show();
 		$j('#empName').show();
 		$j('#lblRelation').show();
 		$j('#relationId').show();
 		
 		//111111
		}
		
	}
}


function checkClickEvent() {
		if ($("#tdOPD").prop('checked') == false) {
			$j('#displayToken').empty();
		}
		validateDivToken();
	}

function validateDivToken(){
	if(validateDeptAndAppointment()){
	 var deptId = $j('#departmentId').find('option:selected').val();
	 var appointmentTypeId =$j("input[name='checkDiv']:checked").val();
	 var hospitalId =  $j('#hospitalId').val(); //Hospiatl id will fetch from session
	 var visitFlag=$j('#visitFlag').val(); // It is fetching from hidden field
	 var visitDate="";
		var params = {
			"deptId":deptId,
			"appointmentTypeId":appointmentTypeId,
			"hospitalId" : hospitalId,
			"visitFlag" : visitFlag,
			"visitDate" : visitDate
		}
	$j.ajax({
			type : "POST",
			contentType : "application/json",
			url : 'tokenNoOfDepartmentForOthers',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(msg) {
				if(isNaN(msg.tokenMsg)){
					var displayToken = '';
   					//displayToken +='<div class="tokenMsgDisplay"><input readonly class="border_none token_digitValue_other_manage" style="color:green;font-weight:600;top: 0px; width:100%" type="text" name="tokenNo" id="tokenNoId" value="'+msg.tokenMsg+'"></div>';
   					  displayToken +='<div class="col-form-label tokenDisplay"><a href="#" onclick="openDoctorRosterTab()"><span name="tokenNo" id="tokenNoId"  data-value="'+msg.tokenMsg+'">'+msg.tokenMsg+'</span></a> </div>';
   					$j('#displayToken').html(displayToken);
				}else{
					var displayToken = '';
   					//displayToken += '<div class="tokenDisplay">Token No.'+'<input readonly class="border_none token_digitValue_other_manage" style="color:green;  width:100%" type="text" name="tokenNo" id="tokenNoId" value="'+msg.tokenMsg+'"> </div>';
   					  displayToken += '<div class="col-form-label tokenDisplay">Token No. <span name="tokenNo" id="tokenNoId"  data-value="'+msg.tokenMsg+'">'+msg.tokenMsg+'</span> </div>';
   					$j('#displayToken').html(displayToken);
				}
				
			}, 
			error : function(msg) {
				alert("An error has occurred while contacting the server");
			}
		});
} 
}

function validateDeptAndAppointment(){
	var deptId = document.getElementById("departmentId").value;
	if(deptId == 0){
		alert("Please select Department");
	}else{
		if(!$j("input[name='checkDiv']:checked").is(':checked')){
			alert("Please select Appointment Type");
			return false;
		}
		return true;
	}
}    

function submitFormData(){
	var tokenValue="";
	var value =validateformData();
	if(value){
	 tokenValue =checkTokenValue();
	}
	
	if(value==true && tokenValue){
		$("#submitbtn").attr("disabled", true);
		 var params = {
				 "tokenNo":$j('#tokenNoId').attr('data-value'),
				 "patientDetailsFormOthers":$j('#patientDetailsFormOthers').serializeObject() 
				}
	 
  $j.ajax({
	  type : "POST",
		  contentType : "application/json",
		  url : 'submitPatientDetailsForOthers',
		  data : JSON.stringify(params),
		  dataType : "json",
		  cache : false,
     success : function(response) {
     	if(response.status=="1"){
     		var flag=$('#flagOther').val();
     		var visitId = response.visitId;
         	window.location.href="showVisitTokenForOthers?visitId="+visitId+"&flag="+flag+""; 
     	}else{
     		$("#submitbtn").attr("disabled", false);
     		alert(response.msg);
     		return false;
     	}
     	
     },
     error: function(msg){					
			alert("An error has occurred while contacting the server");
		}
  });
	}else{
		$("#submitbtn").attr("disabled", false);
		return false;
	}

} 

$j.fn.serializeObject = function()
{
 var o = {};
 var a = this.serializeArray();
 $j.each(a, function() {
     if (o[this.name] !== undefined) {
         if (!o[this.name].push) {
             o[this.name] = [o[this.name]];
         }
         o[this.name].push(this.value || '');
     } else {
         o[this.name] = this.value || '';
     }
 });
 return o;
};


function validateformData(){
	
	var registrationTypeId = $j('#registrationTypeId').find('option:selected').val();
	if(registrationTypeId==<%=REGISTRATION_TYPE_OTHER_DEFENCE_ID%>){
		if($j('#serviceNo').val()==""){
			alert("Please Enter the Service No");
			return false;
		}
		else if($j('#serviceTypeId').val()==0){
			alert("Please Select the Service Type");
			return false;
		}else if($j('#rankId').val()==""){
			alert("Please Enter the Rank");
			return false;
		}
	}
	
	if($j('#firstname').val()==""){
		alert("Please Enter the Name");
		return false;
	}
	else if($j('#lastname').val()==""){
		alert("Please Enter the Last Name");
		return false;
	}
	
	else if($j('#genderId').val()=="0"){
		alert("Please Select the Gender");
		return false;
	}
	else if($j('#dataOfBirthId').val()==""){
		alert("Please Select the DOB");
		return false;
	}
	else if($j('#age').val()==""){
		alert("Age can not be blank");
		return false;
	}
	else if($j('#mobilenumber').val()==""){
		alert("Mobile Number should be 10 digit");
		return false;
	}
	
	else if($j('#identificationId').val()!=0){
		if( $j('#idnumber').val()==""){
			alert("Please enter ID number");
			return false;
		}else{
			return true;
		}			
	}
	
	
	var b=validateDeptAndAppointment();
	
	if(b==true){
		return true;
	}else{
		return false;
	}
}


function checkTokenValue(){
	var tokenIdValue = $j('#tokenNoId').attr('data-value');
	if(tokenIdValue){
		if(isNaN(tokenIdValue)){
			alert(tokenIdValue);
 		return false;
 	}else{
 		return true;
 	}
	}else{
		alert("Please select appointment type");
		return false;
	}
}

function calculateAge(){
var Bdate= $j('#dataOfBirthId').val()
var newdate = Bdate.split("/").reverse().join("-");
var Bday = new Date(newdate);
var age =  parseFloat(((Date.now() - Bday) / (31557600000)),10).toFixed(3);
if(age>0 && age<=100){
	  showAge();
}else{
	  alert("Age can not be less than 0 or greater than 100");
	  $j('#dataOfBirthId').val("");  
	  $j('#age').val(""); 
}

}




function showAge(){
var newdate = $j('#dataOfBirthId').val().toString();
var mdate = newdate.split("/").reverse().join("-");
var yearThen = parseInt(mdate.substring(0,4), 10);
var monthThen = parseInt(mdate.substring(5,7), 10);
var dayThen = parseInt(mdate.substring(8,10), 10);

var today = new Date();
var birthday = new Date(yearThen, monthThen-1, dayThen);

var differenceInMilisecond = today.valueOf() - birthday.valueOf();

var year_age = Math.floor(differenceInMilisecond / 31536000000);
var day_age = Math.floor((differenceInMilisecond % 31536000000) / 86400000);

if ((today.getMonth() == birthday.getMonth()) && (today.getDate() == birthday.getDate())) {
  //  alert("Happy B'day!!!");
}

var month_age = Math.floor(day_age/30);

day_age = day_age % 30;

/* if (isNaN(year_age) || isNaN(month_age) || isNaN(day_age)) {
    $("#age").val("Invalid date - Please try again!");
}else if(year_age==0 && month_age==0 && day_age!=0){
	   $("#age").val(day_age + " days");
}else if(year_age==0 && month_age!=0 ){
	   $("#age").val(month_age + " months");
}
else if(year_age!=0){
    $("#age").val(year_age + " years ");
}
else if(year_age==0 && month_age==0 && day_age==0){
	   alert("Age can not be less then 0 or greater then 100");
	  $j('#dataOfBirthId').val("");  
	  $j('#age').val("");
    return false;
} */
if (isNaN(year_age) || isNaN(month_age) || isNaN(day_age)) {
		$("#age").val("Invalid date - Please try again!");
	}else if (year_age == 0 && month_age == 0 && day_age == 0) {
		alert("Age can not be less then 0 or greater then 100");
		$j('#patientDOB').val("");
		$j('#age').val("");
		return false;
	}else{
		$("#age").val(year_age + " years, " + month_age + " months, " + day_age + " days");
	}
}



function searchPatientDetail(){
$j('#message').html("");
	  	var  UhidNoId=$j('#UhidNoId').val();
		var patientName=$j('#patientName').val();
		var searchServiceNo=$j('#searchServiceNo').val();
		var searchMobileNo=$j('#searchMobileNo').val();
		var registrationTypeId=$j('#registrationTypeId').val();
		if(validateSearchFields(UhidNoId,patientName,searchServiceNo,searchMobileNo)){
	   			var params = {
	   				"UhidNoId":UhidNoId,
	   			 	"patientName":patientName,
	   			    "searchServiceNo":searchServiceNo,
	   			    "searchMobileNo":searchMobileNo,
	   			    "registrationTypeId":registrationTypeId
	   			}
            var data = params;
            var url = 'searchOthersRegisteredPatient';
            var bClickable = true;
              GetJsonData('tblPatientDetails', data, url, bClickable);
          }

} 
function makeTable(jsonData) {
  var htmlTable = "";
  if(jsonData.status==1){
 var data = jsonData.count;
 var dataList = jsonData.data;
		 for(item in dataList){
	    	  htmlTable = htmlTable + "<tr id='" + dataList[item].Id + "'>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].uhinNo + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].serviceNo + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].name + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].age + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].gender + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].mobileNumber + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].registrationTypeName + "</td>";
	    	  
	      }
		  $j('#message').html("");
	      $j("#tblPatientDetails").html(htmlTable);
		  $j('#tblPatientList').show();
	}else{
		 $j('#message').html("");
		 $j('#message').html(jsonData.msg);
     /*  $j('#message').fadeOut(3000); */
		 $j('#tblPatientList').hide();
		 $j("#tblPatientDetails").empty();
		
     
	}
}

function executeClickEvent(rowId,jsonData) {
var dataList=jsonData.data;
	 for(item in dataList){
		 if(dataList[item].Id===parseInt(rowId)){
			 
			 $j('#patientDetailsOthersDiv').show();
    		 $j('#visitDetailsDiv').show();
    		 $j('#submitDiv').show();
			 
			 
			 
			 $j('#uhidNoPatient').val(dataList[item].uhinNo); 
			 if(dataList[item].registrationTypeId==<%=REGISTRATION_TYPE_OTHER_DEFENCE_ID%>){
				 $j('#lblService').show();
				 $j('#serviceNo').show();
				 $j('#serviceNo').val(dataList[item].serviceNo);
				 
				 $j('#lblServiceType').show();
				 $j('#serviceTypeId').show();
				 $j('#serviceTypeId').val(dataList[item].serviceTypeId);
				 
				 $j('#lblEmpName').show();
      		 $j('#empName').show();
      		 $j('#empName').val(dataList[item].empName);
      		 
      		 $j('#lblRelation').show();
      		 $j('#relationId').show();
      		 $j('#relationId').val(dataList[item].relationId);
      		 
				//1111111
				 
				 $j('#lblRank').show();
				 $j('#rankId').show();
				 $j('#rankId').val(dataList[item].rank);
								
					
			 }else{
				 $j('#lblService').hide();
				 $j('#serviceNo').hide();
				 $j('#serviceNo').val(dataList[item].serviceNo);
				 
				 $j('#lblServiceType').hide();
				 $j('#serviceTypeId').hide();
				 $j('#serviceTypeId').val(dataList[item].serviceTypeId);
				 
				 $j('#lblEmpName').hide();
	        	 $j('#empName').hide();
	        	 $j('#empName').val(dataList[item].empName);
	        	 $j('#lblRelation').hide();
	        	 $j('#relationId').hide();
	        	 $j('#relationId').val(dataList[item].relationId);
	        		
				 //222222
				 
				 $j('#lblRank').hide();
				 $j('#rankId').hide();
				 $j('#rankId').val(dataList[item].rank);
			 }
			 $j('#firstname').val(dataList[item].name);
			 $j('#genderId').val(dataList[item].genderId);
			 $j('#dataOfBirthId').val(dataList[item].dateOfBirth);
			 $j('#age').val(dataList[item].age);
			 $j('#mobilenumber').val(dataList[item].mobileNumber);
			 $j('#identificationId').val(dataList[item].identificationTypeId);
			 $j('#idnumber').val(dataList[item].idNumber);
		 }
	 }
}

function validateSearchFields(UhidNoId,patientName,searchServiceNo,searchMobileNo){
if(UhidNoId=="" && patientName=="" && searchServiceNo=="" &&  searchMobileNo==""){
	  alert("Please fill atleast one criteria for search record");
	  return false;
}else{
	  return true;
}
}


function resetGrid(){
	$j('#UhidNoId').val("");
	$j('#patientName').val("");
	$j('#searchServiceNo').val("");
	$j('#searchMobileNo').val("");
	
	// New Added 
	
	$j('#uhidNoPatient').val("");
	$j('#serviceNo').val("");
	$j('#firstname').val("");
	$j('#genderId').val("0");
	$j('#dataOfBirthId').val("");
	$j('#age').val("");
	$j('#serviceTypeId').val("0");
	$j('#rankId').val("");
	$j('#mobilenumber').val("");
	$j('#identificationId').val("0");
	$j('#idnumber').val("");
	
	$j('#empName').val("");
	$j('#relationId').val("0");
	//3333333
	
}


function validateLenght(id, length, data){
	if($j("#"+id).val().length!=length){
		 alert(data+" should be "+length+" digit. ");	
		 var str=  $j("#"+id).val();
		 str=str.substring(0,length).trim();
		 $j("#"+id).val(str);
		 $j('#age').focus();
		 return false;
	 }
	
}


function checkIDType(){
var IdValue = $j('#identificationId').val();
if(IdValue!=0){
	  return true;
}else{
	  $j('#idnumber').val("");
	  alert("Please select ID Type");
	  return false;
}
}

function openDoctorRosterTab(){
$j('#tdOPD').prop('checked', false);
$j('#displayToken').empty();
window.open('${pageContext.request.contextPath}/admin/doctorRoaster',"_blank");
}

function resetIDnumber(){
$j('#idnumber').val("");
}
</script>
    
</body>
</html>