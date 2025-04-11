<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="com.mmu.web.utils.HMSUtil"%>
<%@include file="..//view/leftMenu.jsp"%>
<%@include file="..//view/commonJavaScript.jsp"%>
<%@page import="org.json.JSONObject"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%
	String rspData = "";
	JSONObject responseData = null;
	if (request.getAttribute("data") != null) {
		rspData = (String) request.getAttribute("data");
		responseData = new JSONObject(rspData);
	}

	long APPOINTMENTTYPE_OPD = 0;
	long APPOINTMENTTYPE_ME = 0;
	long APPOINTMENTTYPE_MB = 0;
	long selfRelationId=0;
	if (responseData != null) {

		APPOINTMENTTYPE_OPD = responseData.getLong("appointmentTypeIdOPD");
		APPOINTMENTTYPE_ME = responseData.getLong("appointmentTypeIdME");
		APPOINTMENTTYPE_MB = responseData.getLong("appointmentTypeIdMB");
		selfRelationId = responseData.getLong("selfRelationId");
	}
	
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
<% String visitFlagForReception =HMSUtil.getProperties("js_messages_en.properties", "VISIT_FLAG_FOR_RECEPTION"); %>
<% int REGISTRATION_TYPE_OTHER_CIVIL_ID = Integer.parseInt(HMSUtil.getProperties("js_messages_en.properties", "REGISTRATION_TYPE_OTHER_CIVIL_ID")); %>
<% int REGISTRATION_TYPE_OTHER_DEFENCE_ID = Integer.parseInt(HMSUtil.getProperties("js_messages_en.properties", "REGISTRATION_TYPE_OTHER_DEFENCE_ID")); %>
<% String REGISTRATION_TYPE_NAME = HMSUtil.getProperties("js_messages_en.properties", "REGISTRATION_TYPE_NAME_ICG"); %>
<% String registrationTypeFlagOther =HMSUtil.getProperties("js_messages_en.properties", "REGISTRATION_TYPE_FLAG_OTHER"); %>
<script src="${pageContext.request.contextPath}/resources/js/reception.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>PATIENT DETAILS LIST</title>

</head>
<body>
  <div id="wrapper">
		 
		 <div class="content-page">
				<div class="">
					<div class="container-fluid">
		        <div class="internal_Htext">OPD Emergency</div>
						<div class="row">
							<div class="col-lg-12">
								<div class="card">
								
									<%-- <div id="loadingDiv">
										<img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
									</div> --%>
									
									<div class="card-body">
			<!-- Start tab coding  -->

									<ul class="nav nav-tabs" role="tablist">
										<li class="nav-item"><a class="nav-link active"
											data-toggle="tab" href="#empTab">Employee Details</a></li>
										<li class="nav-item"><a class="nav-link"
											data-toggle="tab" href="#otherPatientTab">Others Patients</a></li>
									</ul>
									
									<div class="tab-content">
										<div id="empTab" class="tab-pane active">
											<div class="clearfix"></div>
											
											<form id="visitEmployee" name="visitEmployee" action="">
											<div class="row">
											
											<div class="col-md-4">
													<div class="form-group row">
														<label class="col-md-5 col-form-label">Service No.<span class="mandate"><sup>&#9733;</sup></span></label> 
														<div class="col-md-7">																			
															    <input	id="serviceNoId" class="auto  form-control" size="8" type="text"
																			name="serviceNo" value="" title="Enter Service No"
																			validate="Service No,string,yes" maxlength="10" />															
															
														</div>
													</div>
										   </div>
															 	
											
											<div class="col-md-1">
													<div class="form-group row">
														 <button type="button" class="btn  btn-primary" onclick="findEmployeeAndDependent()">Search</button>
													</div>
										   </div>
											
											<div class="col-md-2">
												<div id="loadingDiv">
													<img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
												</div>
											</div>
											
                                         </div>
                                            <div class="row">
											<div class="col-md-12"><p align="Left" id="message"	style="color: green; font-weight: bold;"></p></div>
											</div>
                                             
											</form>
											

											<!-- Data Grid -->

											<div id="tblEmpAndDetails" style="display: none"
												class="right_col" role="main" style="padding:0.5% 1.8%;" >
												<div class="clearfix"></div>
												<h5 style="font-weight:600;">List of Details</h5>
												<table class="table table-striped table-hover  table-bordered  ">
													<thead>
														<tr>
														    <th id="th0" style="display:none;">Id</th>
															<th id="th1">Name</th>
															<th id="th2">DOB</th>
															<th id="th3">Age</th>
															<th id="th4">Gender</th>
															<th id="th5">Relation</th>
															<th id="th6" style="display:none;">UhidNo.</th>
															<th id="th7" style="display:none;">ServiceNo.</th>
															<th id="th8" style="display:none;">EmpId</th>
															<th id="th9" style="display:none;">RelationId</th>
															<th id="th9" style="display:none;">registrationTypeId</th>
														</tr>
													</thead>
													<tbody id="tblListOfEmployeeAndDepenent">
													</tbody>
												</table>
											</div>
										</div>

										<div id="otherPatientTab" class="tab-pane fade">
									
				<div class="internal_Htext">Registration &amp; Appointment  Of Other</div>
				
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
														name="idnumber" placeholder="Enterable" maxlength="18" onblur=" return checkIDType()" >
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
					<!----------------------  end here --------------------------->											
												
												 
								

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			

	<form id="visitListForm" name="visitListForm">
		<input type="hidden" class="form-control" id="visitIdOPD" name="visitIdOPD" value="">
		<input type="hidden" class="form-control" id="visitIdME" name="visitIdME" value=""> 
		<input type="hidden" class="form-control" id="visitIdMB" name="visitIdMB" value="">
		<input type="hidden" class="form-control" id="rspMsg" name="rspMsg" value="">
	</form>

	<script type="text/javascript" language="javascript">


 function findEmployeeAndDependent() {
	 $j('#tblEmpAndDetails').hide();
	 $j("#tblListOfEmployeeAndDepenent").empty();
	 $j('#message').html("");
	 $("#loadingDiv").show();
	 var serviceNo =$j('#serviceNoId').val();
         if (serviceNo) {
             var params = {
                "serviceNo": serviceNo
                   }
               var data = params;
             
             var pathname = window.location.pathname;
         	var accessGroup = "MMUWeb";
         	var accessurl = window.location.protocol + "//"
         	+ window.location.host + "/" + accessGroup
         	+ "/registration/getEmployeeAndDependentlist";
         	
               var url = accessurl;
               var bClickable = true;
                 GetJsonData('tblListOfEmployeeAndDepenent', data, url, bClickable);
                 }else{
                 alert("Please enter the service number");
                 $j('#loadingDiv').hide();
                  return false;
                  }
                 }

 function makeTable(jsonData) {
    var htmlTable = "";
    $("#loadingDiv").hide();
    if(jsonData.status==1){
    	var registrationTypeId=1;
    var data = jsonData.count;
    var dataList = jsonData.data;
		 for(item in dataList){
	    	  htmlTable = htmlTable + "<tr id='" + dataList[item].Id + "'>";
	    	  htmlTable = htmlTable + "<td style='display:none;'>" + dataList[item].Id + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].name + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].dateOfBirth + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].age + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].gender + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].relation + "</td>";
	    	  htmlTable = htmlTable + "<td style='display:none;'>" + dataList[item].uhidNo + "</td>";
	    	  htmlTable = htmlTable + "<td style='display:none;'>" + dataList[item].serviceNo + "</td>";
	    	  htmlTable = htmlTable + "<td style='display:none;'>" + dataList[item].employeeId + "</td>";
	    	  htmlTable = htmlTable + "<td style='display:none;'>" + dataList[item].relationId + "</td>";
	    	  htmlTable = htmlTable + "<td style='display:none;'>" + dataList[item].registrationTypeId + "</td>";
	    	 
	    	  
	      }
		  $j('#message').html('');
	      $j("#tblListOfEmployeeAndDepenent").html(htmlTable);
		  $j('#tblEmpAndDetails').show();
	}else{
		
		 $j('#tblEmpAndDetails').hide();
		 $j("#tblListOfEmployeeAndDepenent").empty();
		 $j('#message').html(jsonData.msg);
        
	}
  }
 
 function executeClickEvent(rowId,jsonData,item)
 {
	
	 var uhidNo='';
     var relationId='';
     var serviceNo='';
     var registrationTypeId='';
     var empName='';
     var employeeId='';
     var empRankId='';
     var empTradeId='';
     var empUnitId='';
     var examTypeId='';
     var empMaritalStatusId='';
     var empRecordOfficeId='';
     var empServiceJoinDate='';
     var name='';
     var dateOfBirth='';
     var genderId='';
    
	 var dataList=jsonData.data;
	 for(item in dataList){
		 if(dataList[item].Id===parseInt(rowId)){
			 uhidNo=dataList[item].uhidNo; 
			 relationId=dataList[item].relationId;
			 serviceNo=dataList[item].serviceNo;
			 registrationTypeId="1";
			 empName=dataList[item].empName;
			 employeeId=dataList[item].employeeId;
			 empRankId=dataList[item].empRankId;
			 empTradeId=dataList[item].empTradeId;
			 empUnitId=dataList[item].empUnitId;
			 empMaritalStatusId=dataList[item].empMaritalStatusId;
			 empRecordOfficeId=dataList[item].empRecordOfficeId;
			 empServiceJoinDate=dataList[item].empServiceJoinDate;
			 name=dataList[item].empName;
			 dateOfBirth=dataList[item].dateOfBirth;
			 genderId=dataList[item].genderId;
		 }
	 } 
	
	 var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";

     var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/saveOpdEmergency";
	 
     var dataJSON = {
    		 'serviceNo':serviceNo,
             'uhidNo': uhidNo,
             'relationId':relationId,
             'registrationTypeId':registrationTypeId,
             'departmentId':'2',
             'visitFlag':'E',
             'priorityId':'1',
             'empName':empName,
             'employeeId':employeeId,
             'empRankId':empRankId,
             'empTradeId':empTradeId,
             'empUnitId':empUnitId,
             'empMaritalStatusId':empMaritalStatusId,
             'empRecordOfficeId':empRecordOfficeId,
             'empServiceJoinDate':empServiceJoinDate,
             'examTypeId':'',
             'documentType':'',
             'name':name,
             'dateOfBirth':dateOfBirth,
             'genderId':genderId,
             'hospitalId':<%=hospitalId%>
	 }
	 //$("#clicked").attr("disabled", true);
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
              //window.location.href ="getOpdPatientModel?visitId="+visitId+"";
             } 
             else if(dataList.status == 0)
             {
              alert(dataList.msg)	
             }	
             else
             {
                 alert("Please enter the valid data")
             }
         	
         },
         error: function(jqXHR, exception) {
         	$("#clicked").attr("disabled", false);
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
             alert("Response msg is "+msg);
         }
     });
  
	
 }
 
 function activaTab(tabId){
	 var otherPatientUrl="${pageContext.request.contextPath}/registration/registrationandappointmentothers";
	// $('#content').load(otherPatientUrl);
	// window.location="${pageContext.request.contextPath}/registration/registrationandappointmentothers";
	 document.getElementById('otherPatientTab').innerHTML = otherPatientUrl;//'othersappointmentandregistration.jsp';
	 
 } 
	</script>
<!-- ----------------Accordian  start here---------- -->

<script>
    function showhide(buttonId)
     {
		 if(buttonId=="button1"){
					test('realted'+buttonId,"newpost1");					
		 }else if(buttonId=="button2"){
					test('realted'+buttonId,"newpost2");
		 }else if(buttonId=="button3"){
					test('realted'+buttonId,"newpost3");
		 }else if(buttonId=="button4"){
					test('realted'+buttonId,"newpost4");
		 }else if(buttonId=="button5"){
					test('realted'+buttonId,"newpost5");
		 }else if(buttonId=="button6"){
					test('realted'+buttonId,"newpost6");
		 }else if(buttonId=="button7"){
					test('realted'+buttonId,"newpost7");
		 }else if(buttonId=="button8"){
					test('realted'+buttonId,"newpost8");
		 }else if(buttonId=="button9"){
					test('realted'+buttonId,"newpost9");
		 }else if(buttonId=="button10"){
					test('realted'+buttonId,"newpost10");
		 }else if(buttonId=="button11"){
					test('realted'+buttonId,"newpost11");
		 }else if(buttonId=="button12"){
					test('realted'+buttonId,"newpost12");
		 } 
	 }
    
	function test(buttonId,newpost){
			 var x = document.getElementById(newpost);
				if (x.style.display != "block") {
					x.style.display = "block";
					document.getElementById(buttonId).value="-";
				}else {
					x.style.display = "none";
					document.getElementById(buttonId).value="+";
				}	 
	}
	
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
                 	
             	}else{
             		$j('#lblService').hide();
                 	$j('#serviceNo').hide();
                 	$j('#lblServiceType').hide();
             		$j('#serviceTypeId').hide();
             		$j('#lblRank').hide();
             		$j('#rankId').hide();
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
							tablebody += '<td>';
							var checkBoxIdandValue = idandType[z].split("@");
							if(checkBoxIdandValue[1]==APPOINTMENTTYPE_OPD){
							//tablebody += '<input type="checkbox" checked id ="td'+checkBoxIdandValue[0]+'" name="checkDiv" value="'+checkBoxIdandValue[1]+'"><span id="td'+z+'">'+checkBoxIdandValue[0]+'</span></br>';
							tablebody += '<div class="form-check form-check-inline cusCheck"><input type="checkbox" class="form-check-input"  id ="tdOPD" name="checkDiv" value="'+checkBoxIdandValue[1]+'" onclick="checkClickEvent()"><span class="cus-checkbtn"></span><span id="td'+z+'">'+checkBoxIdandValue[0]+'</span></div></br>';
							}else{
								//alert("Appointment Type OPD is not available.");
								//return;
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
			 var pathname = window.location.pathname;
	        var accessGroup = "MMUWeb";
		    var tokenNoOfDepartmentForOthers = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/registration/tokenNoOfDepartmentForOthers";
		$j.ajax({
				type : "POST",
				contentType : "application/json",
				url : tokenNoOfDepartmentForOthers,
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(msg) {
					if(isNaN(msg.tokenMsg)){
						var displayToken = '';
	   					//displayToken +='<div class="tokenMsgDisplay"><input readonly class="border_none token_digitValue_other_manage" style="color:green;font-weight:600;top: 0px; width:100%" type="text" name="tokenNo" id="tokenNoId" value="'+msg.tokenMsg+'"></div>';
	   					  displayToken +='<div class="col-form-label tokenDisplay"><span name="tokenNo" id="tokenNoId"  data-value="'+msg.tokenMsg+'">'+msg.tokenMsg+'</span> </div>';
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
 		 var pathname = window.location.pathname;
         var accessGroup = "MMUWeb";
 	    var submitPatientDetailsForOthers = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/registration/submitPatientDetailsForOthers";
      $j.ajax({
    	  type : "POST",
 		  contentType : "application/json",
 		  url : submitPatientDetailsForOthers,
 		  data : JSON.stringify(params),
 		  dataType : "json",
 		  cache : false,
         success : function(response) {
         	if(response.status=="1"){
         		var flag=$('#flagOther').val();
         		var visitId = response.visitId;
             	//window.location.href="getOpdPatientModel?visitId="+visitId+"";
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
 		alert("Please check the token number");
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
		  alert("Age can not be less then 0 or greater then 100");
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
		   			var pathname = window.location.pathname;
		         	var accessGroup = "MMUWeb";
		         	var searchOthersRegisteredPatient = window.location.protocol + "//"
		         	+ window.location.host + "/" + accessGroup
		         	+ "/registration/searchOthersRegisteredPatient";
		         	
	               var data = params;
	               var url = searchOthersRegisteredPatient;
	               var bClickable = true;
	                 GetJsonData('tblPatientDetails', data, url, bClickable);
	             }
	
} 
function makeTable1(jsonData) {
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

function executeClickEventOthers(rowId,jsonData) {
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

function resetIDnumber(){
	  $j('#idnumber').val("");
}
	      
  </script>

<!-- ----------------Accordian  end here---------- -->
</body>
</html>
