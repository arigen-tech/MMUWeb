<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="com.mmu.web.utils.HMSUtil"%>
<%@include file="..//view/leftMenu.jsp"%>
<%@include file="..//view/commonJavaScript.jsp"%>
<%@page import="org.json.JSONObject"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="${pageContext.request.contextPath}/resources/js/reception.js"></script> 
<%
     HttpSession sessionJsp = request.getSession(false);// don't create if it doesn't exist

	if(sessionJsp == null || sessionJsp.isNew()) {
			return;
		}
     
	String rspData = "";
	JSONObject responseData = null;

%>

<%long valueRegistrationTypeId = Long.parseLong(HMSUtil.getProperties("js_messages_en.properties", "REGISTRATION_TYPE_ICG_ID")); %>
<% String visitFlagForReception =HMSUtil.getProperties("js_messages_en.properties", "VISIT_FLAG_FOR_RECEPTION"); %>


<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>PATIENT DETAILS LIST</title>

</head>
<body>
  <div id="wrapper">
		 
		 <div class="content-page">
				<div class="">
					<div class="container-fluid">
		        <div class="internal_Htext">Appointment of ICG Employee and	Dependent</div>
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
											data-toggle="tab" href="#patientTab">Patient Detail</a></li>
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
															<th id="th1">Name</th>
															<th id="th2">DOB</th>
															<th id="th3">Age</th>
															<th id="th4">Gender</th>
															<th id="th5">Relation</th>
														</tr>
													</thead>
													<tbody id="tblListOfEmployeeAndDepenent">
													</tbody>
												</table>
											</div>
										</div>

										<div id="patientTab" class="tab-pane fade">
		<!-- Start  form patient   -->
											
				<!-- panel-group -->
	
				<form id="patientDetailsForm" name="patientDetailsForm" action="" method="POST">										
												
				<!-- -----  Service Detail  start here --------- -->	
				
						  <div class="adviceDivMain" id="button1" onclick="showhide(this.id)">
								<div class="titleBg" style="width: 520px; float: left;">
									<span>Service Detail  </span>
								</div>
								<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton1" value="+" onclick="showhide(this.id)" type="button">
							</div> 
						
						      <div class="hisDivHide p-10" id="newpost1">
			 		 
												<div class="row">
													<div class="col-md-4">
														<div class="form-group row">
															<label for="service" class="col-md-5 col-form-label">Service
																No.<span class="mandate"><sup>&#9733;</sup></span></label>
															<div class="col-md-7">
																<input type="text" class="form-control" id="empService"
																	name="empService"  validate="Service No,string,yes">
																	
																<input type="hidden" class="form-control" id="uhidNo"
																	name="uhidNo" value="">
																	
																<input type="hidden" class="form-control" id="empCategoryId"
																	name="empCategoryId" value="">
																	
																<input type="hidden" class="form-control" id="patientId"
																	name="patientId">
																	
																<input type="hidden" class="form-control" id="registrationTypeId"
																	name="registrationTypeId"  value="<%=valueRegistrationTypeId%>">
																	
																<input type="hidden" class="form-control" id="visitFlag"
																	name="visitFlag"  value="<%=visitFlagForReception%>">
																	
																<input type="hidden" class="form-control" id="userId"
																	name="userId"  value="<%=session.getAttribute("user_id")%>">
																	
																<input type="hidden" class="form-control" id="hospitalId"
																	name="hospitalId"  value="<%=session.getAttribute("hospital_id")%>">
																
																<input type="hidden" class="form-control" id="visitDate"
																	name="visitDate"  value="">	
																	
																<input type="hidden" class="form-control" id="existingVisitIdME"
																	name="existingVisitIdME"  value="0">
																
																<input type="hidden" class="form-control" id="existingVisitIdMB"
																	name="existingVisitIdMB"  value="0">	
																	
															</div>
														</div>
														</div>
														
                                                     <div class="col-md-4">
														<div class="form-group row">
															<label for="EmpName" class="col-md-5 col-form-label">Name<span class="mandate"><sup>&#9733;</sup></span></label>
															<div class="col-md-7">
																<input type="text" class="form-control" id="empName"
																	name="empName" validate="Emp Name,string,yes">
																<input type="hidden" class="form-control" id="empId"
																	name="empId">
															</div>
														</div>
                                                      </div>

												<div class="col-md-4">
														<div class="form-group row">
															<label for="rank" class="col-md-5 col-form-label">Rank</label>
															<div class="col-md-7">
																<!-- <input type="text" class="form-control" id="rank"
																	name="rank" validate="Rank,string,no">  -->
															<select id="rankId" name="rankId" validate="Rank,int,yes"  class="form-control selectTextWarp">
																		<option value="0" selected="selected">Select</option>
																	</select>		
															
																<!-- <input	type="hidden" class="form-control" id="rankId"
																	name="rankId"> -->
															</div>
														</div>
													</div>
													
													
													<div class="col-md-4">
														<div class="form-group row">
															<label for="trade_branch" class="col-md-5 col-form-label">Trade/Branch</label>
															<div class="col-md-7">
																<!-- <input type="text" class="form-control" id="trade"
																	name="trade" validate="Trade/Branch,string,no"> -->
															
															 <select id="tradeId" name="tradeId" validate="Trade,int,no"  class="form-control selectTextWarp">
																		<option value="0" selected="selected">Select</option>
																	</select>
																	
																<!-- <input type="hidden" class="form-control" id="tradeId"
																	name="tradeId"> -->
															</div>
														</div>
                                                     </div>

                                                    <div class="col-md-4">
														<div class="form-group row">
															<label for="unit" class="col-md-5 col-form-label">Unit<span class="mandate"><sup>&#9733;</sup></span></label>
															<div class="col-md-7">
																<!-- <input type="text" class="form-control" id="unit"
																	name="unit" validate="Unit,string,yes">  -->
															  
															   <select id="unitId" name="unitId" validate="Unit,int,yes"  class="form-control selectTextWarp"  onchange="getRegionFromStation()">
																		<option value="0" selected="selected">Select</option>
																	</select>
																	
															 <!--  <input type="hidden" class="form-control" id="unitId"
																	name="unitId"> -->
															</div>
														</div> 
													</div>		

                                                    <div class="col-md-4">
														<div class="form-group row">
															<label for="region" class="col-md-5 col-form-label">Region/Command</label>
															<div class="col-md-7">
																<!-- <input type="text" class="form-control" id="region" name="region" validate="Region/Command,string,yes"> -->
																 <select id="regionId" name="regionId" validate="Region/Command,int,no"  class="form-control selectTextWarp">
																		<option value="0" selected="selected">Select</option>
																	</select>
																<!-- <input type="hidden" class="form-control" id="regionId"
																	name="regionId"> -->
															</div>
														</div>														
												    </div>


								
							
							     <div class="col-md-4">
														<div class="form-group row">
															<label for="marital status"
																class="col-md-5 col-form-label">Marital Status</label>
															<div class="col-md-7">
																<!-- <input type="text" class="form-control"
																	id="maritalstarus" name="maritalstarus"
																	validate="Marital Status,string,no">  -->
																
																<select id="maritalstarusId" name="maritalstarusId" validate="Marital Status,int,no"  class="form-control">
																		<option value="0" selected="selected">Select</option>
																	</select>	
															<!-- <input type="hidden" class="form-control" id="maritalstarusId"
																	name="maritalstarusId"> -->
															</div>
														</div> 
														
													</div>
														
                                                    <div class="col-md-4">
														<div class="form-group row">
															<label for="recordoffice" class="col-md-5 col-form-label">Record
																Office<span class="mandate"><sup>&#9733;</sup></span></label>
															<div class="col-md-7">
																<!-- <input type="text" class="form-control"
																	id="recordoffice" name="recordoffice"
																	validate="Record Office,string,yes">  -->
																	
															<select id="recordofficeId" name="recordofficeId" validate="Record Office,int,yes"  class="form-control">
																		<option value="0" selected="selected">Select</option>
																	</select>	
																	
															<!-- <input type="hidden" class="form-control" id="recordofficeId"
																	name="recordofficeId"> -->
															</div>
														</div> 
													</div>
																		
                                                    
                                                    <div class="col-md-4">
														<div class="form-group row">
															<label for="service" class="col-md-5 col-form-label">Total
																Service</label>
															<div class="col-md-7">
																<input type="text" class="form-control"
																	id="totalservice" name="totalservice"
																	validate="Total Service,string,no"> 
																	
															<input type="hidden" class="form-control"
																	id="empServiceJoinDate" name="empServiceJoinDate">
															</div>
														</div>														
													</div>
                                                  
												</div>
										 
					 </div>
					 
					 
					 <!---------------------- Service Details end here --------------------------->
					 
					 
					 
					 
					<!---------------------- Patient Details start here --------------------------->
					
					  <div class="adviceDivMain" id="button2" onclick="showhide(this.id)">
						<div class="titleBg" style="width: 520px; float: left;">
							<span>Patient Detail  </span>
						</div>
						<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton2" value="-" onclick="showhide(this.id)" type="button">
					</div>	
				
				
				      <div class="hisDivHide p-10" id="newpost2"  style="display:block;">
					
								<div class="row">
													<div class="col-md-4">
														<div class="form-group row">
															<label for="Name" class="col-md-5 col-form-label">Name<span class="text-red">*</span></label>
															<div class="col-md-7">
																<input type="text" class="form-control" id="patientname"
																	name="patientname" validate="Patient Name,string,yes">
															</div>
														</div>														
												     </div>		
                                                     <div class="col-md-4">
														<div class="form-group row">
															<label for="DOB" class="col-md-5 col-form-label">DOB<span class="text-red">*</span></label>
															<div class="col-md-7">
																<div class="dateHolder">
																<input type="text" class="calDate datePickerInput form-control" id="patientDOB"
																	 name="patientDOB" placeholder="DD/MM/YYYY" 
																	 onkeyup="mask(this.value,this,'2,5','/')" onblur="validateExpDate(this,'patientDOB');" maxlength="10"
																	 onchange="calculateAge()"  validate="Patient DOB,string,yes">
														 		</div> 
														 
																<!-- <input type="text" class="form-control" id="patientDOB"
																	name="patientDOB"  validate="Patient Name,string,yes"> -->
														</div>
														</div>
												      </div>

 											<div class="col-md-4">
														<div class="form-group row">
															<label for="service" class="col-md-5 col-form-label">Age<span class="text-red">*</span></label>
															<div class="col-md-7">
																<input type="text" class="form-control" id="patientAge"
																	name="patientAge" validate="Patient Age ,string,yes">
															</div>
														</div>
													</div>
													
													
													<div class="col-md-4">

														<div class="form-group row">
															<label class="col-md-5 col-form-label">Gender<span class="text-red">*</span></label>
															<div class="col-md-7">
																<!-- <input type="text" class="form-control" id="gender"
																	name="gender" validate="Gender ,string,yes">  -->
															<select id="genderId" name="genderId" validate="Gender,int,yes"  class="form-control">
																		<option value="0" selected="selected">Select</option>
																	</select>		
														<!-- <input type="hidden" class="form-control" id="genderId" name="genderId"> -->
															</div>
														</div>

                                                      </div>
													<div class="col-md-4">
														<div class="form-group row">
															<label for="service" class="col-md-5 col-form-label">Relation<span class="text-red">*</span></label>
															<div class="col-md-7">
																<input type="text" class="form-control"
																	id="patientRelation" name="patientRelation" validate="Patient Relation ,string,yes"> 
																
																<!-- <select id="patientRelationId" name="patientRelationId" validate="Patient Relation,int,yes"  class="form-control">
																		<option value="0" selected="selected">Select</option>
																	</select> -->	
																<input type="hidden" class="form-control" id="patientRelationId" name="patientRelationId">
															</div>
														</div>
													</div>
													
													<!-- Religion part is uncomment  -->
	                                                 <div class="col-md-4">
															<div class="form-group row">
																<label for="religion" class="col-md-5 col-form-label">Religion</label>
																<div class="col-md-7">
																<select id="religionId" name="religionId" validate="Religion,int,no"  class="form-control">
																			<option value="0" selected="selected">Select</option>
																		</select>
																	<!-- <input type="text" class="form-control" id="religion"
																		name="religion" validate="Religion,string,yes">
																	<input type="hidden" class="form-control"
																		id="religionId" name="religionId"> -->
																</div>
															</div> 
														</div>
													<!-- Religion part is uncomment  -->
                                                    
                                                     <div class="col-md-4">
														<div class="form-group row">
															<label for="unit" class="col-md-5 col-form-label">Mobile
																Number</label>
															<div class="col-md-7">
																<input type="text" class="form-control"
																	id="patientMoblienumber" name="patientMoblienumber" validate="Patient Mobile No ,int,no"  maxlength="10" onkeypress="checkNumberFormat('patientMoblienumber');" onblur="return validateLenght('patientMoblienumber',10, 'Patient Mobile Number');">
															</div>
														</div>
													</div>
													
													 <div class="col-md-4">
														<div class="form-group row">
															<label for="region" class="col-md-5 col-form-label">Email
																Address</label>
															<div class="col-md-7">
																<input type="text" class="form-control"
																	id="patientEmail" name="patientEmail">
															</div>
														</div>
													</div>
											</div>		
											<!-- Address start from here -->
											<div class=" row m-t-20">
												<div class="col-md-12">
													<h6 class="font-weight-bold text-theme text-underline">Address Detail </h6>
												</div>
											</div>	
											
											<div class="row">	
													   <div class="col-md-4">
														<div class="form-group row">
															<label for="recordoffice" class="col-md-5 col-form-label">Address Line 1 </label>
															<div class="col-md-7">
																<input type="text" class="form-control" placeholder="House No./Bldg No./ Name/ Stair well/ lift no."
																	id="patientAddressLine1" name="patientAddressLine1" maxlength="100" validate="Address Line1,string,no">
															</div>
														</div>
													 </div>
													 
                                                      <div class="col-md-4">
														<div class="form-group row">
															<label for="recordoffice" class="col-md-5 col-form-label">Address Line 2</label>
															<div class="col-md-7">
																<input type="text" class="form-control" placeholder="Sub locality-1- Block Name/ Street Number/ Mohalla/ Sector number, Sub locality-2- Landmark" 
																	id="patientAddressLine2" name="patientAddressLine2" maxlength="100" validate="Address Line 2,string,no">
															</div>
														</div>
													</div> 
													
													
                                                     <div class="col-md-4">
														<div class="form-group row">
															<label for="marital status"
																class="col-md-5 col-form-label">Address Line 3</label>
															<div class="col-md-7">
																<input type="text" class="form-control" id="patientAddressLine3"
																	name="patientAddressLine3" maxlength="100" placeholder="Locality like Area number/ name, Suburb">
															</div>
														</div>
													</div>

                                                  <div class="col-md-4">
														<div class="form-group row">
															<label for="marital status"
																class="col-md-5 col-form-label">Address Line 4</label>
															<div class="col-md-7">
																<input type="text" class="form-control" id="patientAddressLine4"
																	 placeholder="Town name (Urban land region) / village name (Rural land region)"  name="patientAddressLine4" maxlength="100">
															</div>
														</div>
													</div>
													
													
													<div class="col-md-4">
														<div class="form-group row">
															<label for="marital status"
																class="col-md-5 col-form-label">Pin code</label>
															<div class="col-md-7">
																<input type="text" class="form-control" id="patientPincode" placeholder="Pin code"
																	name="patientPincode" maxLength="6" onkeypress="checkNumberFormat('patientPincode');">
															</div>
														</div>
													</div> 
                                                  
													
													 <div class="col-md-4">
														<div class="form-group row">
															<label for="marital status"
																class="col-md-5 col-form-label">District</label>
															<div class="col-md-7">
															<select id="patientDistrictId" name="patientDistrictId"
																	class="form-control"  onchange="getStateFromDistrict(this.value,'p')">
																	<option value="0" selected="selected">Select</option>
															</select>
															</div>
														</div>
													</div>	
														
                                                     <div class="col-md-4">
														<div class="form-group row">
															<label for="marital status"
																class="col-md-5 col-form-label">State</label>
															<div class="col-md-7">
															<select id="patientStateId" name="patientStateId"
																	class="form-control" >
																	<option value="0" selected="selected">Select</option>
															</select>
															</div>
														</div>
													</div>
												
												<div class="col-md-4">
														<div class="form-group row">
															<label for="marital status"
																class="col-md-5 col-form-label">Country</label>
															<div class="col-md-7">
															<input type="text"  readonly class="form-control" id="patientCountry"
																	name="patientCountry"  Value="India">
															<input type="hidden"  readonly class="form-control" id="patientCountryId"
																	name="patientCountryId"  Value="1">
															</div>
														</div>
													</div>	 
												 
											
										</div>
										<!-- Address End from here -->	
					</div>
					<!---------------------- Patient Details end here --------------------------->
					
					
					
					<!----------------------   start here --------------------------->
					
					<div class="adviceDivMain" id="button3" onclick="showhide(this.id)">
						<div class="titleBg" style="width: 520px; float: left;">
							<span>NOK Detail 1 </span>
						</div>
						<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton3" value="+" onclick="showhide(this.id)" type="button">
					</div>	
				
				
				      <div class="hisDivHide p-10" id="newpost3">
					
						       <div class="row">
													<div class="col-md-4">
														<div class="form-group row">
															<label for="First Name" class="col-md-5 col-form-label">Name</label>
															<div class="col-md-7">
																<input type="text" class="form-control"
																	id="nok1Firstname" name="nok1Firstname">
															</div>
														</div>														
												   </div>
                                                        
                                                <div class="col-md-4">
													<div class="form-group row">
														<label for="service" class="col-md-5 col-form-label">Relation</label>
														<div class="col-md-7">
															<select id="nok1RelationId" name="nok1RelationId"
																	class="form-control">
																	<option value="0" selected="selected">Select</option>
															</select>
													   </div>
														</div>
													</div>
                                                  
                                                       <div class="col-md-4">                                                       
														<div class="form-group row">
															<label for="unit" class="col-md-5 col-form-label">Mobile
																Number</label>
															<div class="col-md-7">
																<input type="text" class="form-control" id="nok1Moblienumber" name="nok1Moblienumber" 
																	maxlength="10" onkeypress="checkNumberFormat('nok1Moblienumber');" onblur="return validateLenght('nok1Moblienumber',10, 'NOK1 Mobile Number');">
															</div>
														</div>
													</div>
												
												
												<div class="col-md-4">
														<div class="form-group row">
															<label for="region" class="col-md-5 col-form-label">Email
																Address</label>
															<div class="col-md-7">
																<input type="text" class="form-control" id="nok1Email"
																	name="nok1Email">
															</div>
														</div>
													</div>
													
												   <div class="col-md-4">

														<div class="form-group row">
															<label for="contactnumber"
																class="col-md-5 col-form-label">Contact Number</label>
															<div class="col-md-7">
																<input type="text" class="form-control"
																	id="nok1Contactnumber" name="nok1Contactnumber" maxlength="8" onkeypress="checkNumberFormat('nok1Contactnumber');">
															</div>
														</div>
													</div>
													
													
													<div class="col-md-4">
														<div class="form-group row">
															<label for="policestation"
																class="col-md-5 col-form-label">Police Station</label>
															<div class="col-md-7">
																<input type="text" class="form-control"
																	id="nok1Policestation" name="nok1Policestation">
															</div>
														</div>
										  			</div>
													
												</div>
													
										<!-- Address start from here -->
											<div class=" row m-t-20">
												<div class="col-md-12">
													<h6 class="font-weight-bold text-theme text-underline">Address Detail </h6>
												</div>
											</div>	
											
											<div class="row">	
													   <div class="col-md-4">
														<div class="form-group row">
															<label for="recordoffice" class="col-md-5 col-form-label">Address Line 1 </label>
															<div class="col-md-7">
																<input type="text" class="form-control"
																	id="nok1AddressLine1" name="nok1AddressLine1" validate="Address Line1,string,no" 
																	 placeholder="House No./Bldg No./ Name/ Stair well/ lift no."  maxlength="60">
															</div>
														</div>
													 </div>
													 
                                                      <div class="col-md-4">
														<div class="form-group row">
															<label for="recordoffice" class="col-md-5 col-form-label">Address Line 2</label>
															<div class="col-md-7">
																<input type="text" class="form-control"
																	id="nok1AddressLine2" name="nok1AddressLine2" validate="Address Line 2,string,no"
																	placeholder="Sub locality-1- Block Name/ Street Number/ Mohalla/ Sector number, Sub locality-2- Landmark" maxlength="60">
															</div>
														</div>
													</div> 
													
													
                                                     <div class="col-md-4">
														<div class="form-group row">
															<label for="marital status"
																class="col-md-5 col-form-label">Address Line 3</label>
															<div class="col-md-7">
																<input type="text" class="form-control" id="nok1AddressLine3"
																	name="nok1AddressLine3"  placeholder="Locality like Area number/ name, Suburb"  maxlength="60">
															</div>
														</div>
													</div>

                                                  <div class="col-md-4">
														<div class="form-group row">
															<label for="marital status"
																class="col-md-5 col-form-label">Address Line 4</label>
															<div class="col-md-7">
																<input type="text" class="form-control" id="nok1AddressLine4"
																	name="nok1AddressLine4" placeholder="Town name (Urban land region) / village name (Rural land region)"  maxlength="20">
															</div>
														</div>
													</div>
													
												 <div class="col-md-4">
														<div class="form-group row">
															<label for="marital status"
																class="col-md-5 col-form-label">Pin code</label>
															<div class="col-md-7">
																<input type="text" class="form-control" id="nok1pincode"
																	name="nok1pincode" placeholder="Pin code" maxLength="6" onkeypress="checkNumberFormat('nok1pincode');">
															</div>
														</div>
													</div> 
													
													
													 <div class="col-md-4">
														<div class="form-group row">
															<label for="marital status"
																class="col-md-5 col-form-label">District</label>
															<div class="col-md-7">
															
															<select id="nok1DistrictId" name="nok1DistrictId"
																	class="form-control" onchange="getStateFromDistrict(this.value,'p1')">
																	<option value="0" selected="selected">Select</option>
															</select>
															</div>
														</div>
													</div>	
														
                                                     <div class="col-md-4">
														<div class="form-group row">
															<label for="marital status"
																class="col-md-5 col-form-label">State</label>
															<div class="col-md-7">
															<select id="nok1StateId" name="nok1StateId"
																	class="form-control">
																	<option value="0" selected="selected">Select</option>
															</select>
															</div>
														</div>
													</div>
													 <div class="col-md-4">
														<div class="form-group row">
															<label for="marital status"
																class="col-md-5 col-form-label">Country</label>
															<div class="col-md-7">
															<select id="nok1Country" name="nok1Country"
																	class="form-control">
																	<option value="1" selected="selected">India</option>
															</select>
															</div>
														</div>
													</div> 
											
										</div>
										<!-- Address End from here -->	
					</div>										
												
					<!----------------------  end here --------------------------->					
												
					 <!----------------------   start here --------------------------->
					
				 <div class="adviceDivMain" id="button4" onclick="showhide(this.id)">
						<div class="titleBg" style="width: 520px; float: left;">
							<span> NOK Detail 2 </span>
					</div>
						<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton4" value="+" onclick="showhide(this.id)" type="button">
					  	
				</div>	
				
				      <div class="hisDivHide p-10" id="newpost4">
									
									<div class="row">
												
													<div class="col-md-4">
														<div class="form-group row">
															<label for="First Name" class="col-md-5 col-form-label">Name</label>
															<div class="col-md-7">
																<input type="text" class="form-control"
																	id="nok2Firstname" name="nok2Firstname">
															</div>
														</div>
													</div>
													
														<div class="col-md-4">
														<div class="form-group row">
															<label for="service" class="col-md-5 col-form-label">Relation</label>
															<div class="col-md-7">
																<select id="nok2RelationId" name="nok2Relation"
																	class="form-control">
																	<option value="0" selected="selected">Select</option>
																</select>
															</div>
														</div>
													</div>
													
													<div class="col-md-4">
														<div class="form-group row">
															<label for="unit" class="col-md-5 col-form-label">Mobile
																Number</label>
															<div class="col-md-7">
																<input type="text" class="form-control"
																	id="nok2Moblienumber" name="nok2Moblienumber" 
																	 maxLength="10" onkeypress="checkNumberFormat('nok2Moblienumber');"  
																	 onblur="return validateLenght('nok2Moblienumber',10, 'NOK2 Mobile Number');">
															</div>
														</div>
													</div>
													
													<div class="col-md-4">
														<div class="form-group row">
															<label for="region" class="col-md-5 col-form-label">Email
																Address</label>
															<div class="col-md-7">
																<input type="text" class="form-control" id="nok2Email"
																	name="nok2Email" onblur="checkEmail(this.value)">
															</div>
														</div>
													</div>
												
												
													<div class="col-md-4">

														<div class="form-group row">
															<label for="contactnumber"
																class="col-md-5 col-form-label">Contact Number</label>
															<div class="col-md-7">
																<input type="text" class="form-control"
																	id="nok2Contactnumber" name="nok2Contactnumber"  maxLength="8"  onkeypress="checkNumberFormat('nok2Contactnumber');">
															</div>
														</div>

													</div>
												
													<div class="col-md-4">
														<div class="form-group row">
															<label for="policestation"
																class="col-md-5 col-form-label">Police Station</label>
															<div class="col-md-7">
																<input type="text" class="form-control"
																	id="nok2Policestation" name="nok2Policestation">
															</div>
														</div>
													</div>
												</div>	
													
													
													<!-- Address start from here -->
											<div class=" row m-t-20">
												<div class="col-md-12">
													<h6 class="font-weight-bold text-theme text-underline">Address Detail </h6>
												</div>
											</div>	
											
											<div class="row">	
													   <div class="col-md-4">
														<div class="form-group row">
															<label for="recordoffice" class="col-md-5 col-form-label">Address Line 1 </label>
															<div class="col-md-7">
																<input type="text" class="form-control"
																	id="nok2AddressLine1" name="nok2AddressLine1" validate="Address Line1,string,no" 
																	 placeholder="House No./Bldg No./ Name/ Stair well/ lift no." maxlength="60">
															</div>
														</div>
													 </div>
													 
                                                      <div class="col-md-4">
														<div class="form-group row">
															<label for="recordoffice" class="col-md-5 col-form-label">Address Line 2</label>
															<div class="col-md-7">
																<input type="text" class="form-control"
																	id="nok2AddressLine2" name="nok2AddressLine2" validate="Address Line 2,string,no"
																	placeholder="Sub locality-1- Block Name/ Street Number/ Mohalla/ Sector number, Sub locality-2- Landmark"  maxlength="60">
															</div>
														</div>
													</div> 
													
													
                                                     <div class="col-md-4">
														<div class="form-group row">
															<label for="marital status"
																class="col-md-5 col-form-label">Address Line 3</label>
															<div class="col-md-7">
																<input type="text" class="form-control" id="nok2AddressLine3"
																	name="nok2AddressLine3"  placeholder="Locality like Area number/ name, Suburb"  maxlength="60">
															</div>
														</div>
													</div>

                                                  <div class="col-md-4">
														<div class="form-group row">
															<label for="marital status"
																class="col-md-5 col-form-label">Address Line 4</label>
															<div class="col-md-7">
																<input type="text" class="form-control" id="nok2AddressLine4"
																	name="nok2AddressLine4" placeholder="Town name (Urban land region) / village name (Rural land region)"  maxlength="20">
															</div>
														</div>
													</div>
													
												 <div class="col-md-4">
														<div class="form-group row">
															<label for="marital status"
																class="col-md-5 col-form-label">Pin code</label>
															<div class="col-md-7">
																<input type="text" class="form-control" id="nok2pincode"
																	name="nok2pincode" placeholder="Pin code" maxLength="6" onkeypress="checkNumberFormat('nok2pincode');">
															</div>
														</div>
													</div> 
													
													
													 <div class="col-md-4">
														<div class="form-group row">
															<label for="marital status"
																class="col-md-5 col-form-label">District</label>
															<div class="col-md-7">
															<select id="nok2DistrictId" name="nok2DistrictId"
																	class="form-control" onchange="getStateFromDistrict(this.value,'p2')">
																	<option value="0" selected="selected">Select</option>
																</select>
															</div>
														</div>
													</div>	
														
                                                     <div class="col-md-4">
														<div class="form-group row">
															<label for="marital status"
																class="col-md-5 col-form-label">State</label>
															<div class="col-md-7">
															<select id="nok2StateId" name="nok2StateId"
																	class="form-control">
																	<option value="0" selected="selected">Select</option>
																</select>
															</div>
														</div>
													</div>
													 <div class="col-md-4">
														<div class="form-group row">
															<label for="marital status"
																class="col-md-5 col-form-label">Country</label>
															<div class="col-md-7">
															<select id="nok2Country" name="nok2Country"
																	class="form-control">
																	<option value="1" selected="selected">India</option>
																</select>
																
															</div>
														</div>
													</div> 
											
										
										<!-- Address End from here -->	
													
								</div>
					
					</div>										
												
					<!----------------------  end here --------------------------->		
					
					
						<!----------------------   start here --------------------------->
					
					<div class="adviceDivMain" id="button5" onclick="showhide(this.id)">
						<div class="titleBg" style="width: 520px; float: left;">
							<span> Medical Detail</span> 
						</div>
						<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton5" value="+" onclick="showhide(this.id)" type="button">
					</div>		
				
				      <div class="hisDivHide p-10" id="newpost5">
										<div class="row">
													<div class="col-md-4">

														<div class="form-group row">
															<label for="Blood Group" class="col-md-5 col-form-label">Blood
																Group</label>
															<div class="col-md-7">
																<select id="bloodGroupId" name="bloodGroup"
																	class="form-control">
																	<option value="0" selected="selected">Select</option>
																</select>
															</div>
														</div>

													</div>
													<div class="col-md-4">

														<div class="form-group row">
															<label for="medicalCategory" id="lblmedicalCategory" class="col-md-5 col-form-label">Present
																Medical Category </label>
															<div class="col-md-7">
															<textarea readonly type="text" class="form-control" id="medicalCategoryId"  name="medicalCategory"></textarea>
																<!-- <select id="medicalCategoryId" name="medicalCategory"
																	class="form-control">
																	<option value="0" selected="selected">Select</option>
																</select> -->
															</div>
														</div>

													</div>
													
													<!-- <div class="col-md-4">
														<div class="form-group row">
															<label for="date" id="lbldate" class="col-md-5 col-form-label">Date of Medical category</label>
															<div class="col-md-7">
															
															 <div class="dateHolder" id="calDateDiv">
																<input type="text" readonly class="calDate datePickerInput form-control" id="dateId" placeholder="DD/MM/YYYY"
																	name="date"  onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10">
															</div> 
															
															<input type="date" class="form-control" id="dateId"  name="date">
															</div>
														</div>
													</div>
													
													<div class="col-md-4">
														<div class="form-group row">
															<label for="duration" id="lblduration" class="col-md-5 col-form-label">Duration of Medical category</label>
															<div class="col-md-7">
																<select class="form-control" id="durationId"
																	name="duration">
																	<option value="0" selected="selected">Select</option>
																	<option value="1">Year</option>
																	<option value="2">Month</option>
																</select>
															</div>
														</div>

													</div> -->
													
												</div>
					
					</div>										
												
					<!----------------------  end here --------------------------->			
					
					 <!----------------------  start here --------------------------->
					
					<div class="adviceDivMain" id="button6" onclick="showhide(this.id)">
						<div class="titleBg" style="width: 520px; float: left;">
							<span> Visit Detail</span>   
					    </div>
						<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton6" value="-" onclick="showhide(this.id)" type="button">
					</div>	
				
				
				      <div class="hisDivHide p-10" id="newpost6"  style="display:block;">						
					
							<div id="departmentNSessionList">
													<div id="div">
														<!-- Visit details div start with department -->
														
														<div class="row">
														<div class="col-md-4">
															<div class="form-group row">
																<label for="department" class="col-md-5 col-form-label">Department
																</label>
																<div class="col-md-7">
																	<select id="departmentId" name="department" validate="Department,int,yes"
																		onchange="getAppointmentType(); checkDoctorMapping();" class="form-control">
																		<option value="0" selected="selected">Select</option>
																	</select>
																</div>
															</div>
														</div>
														
														
													<div class="col-md-1">
															<div id="loadingDivNew" style="display:none;">
																<img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
														</div>
													 </div>
														
														
														<div id="docDiv" class="col-md-4" style="display:none;">
																	<div class="form-group row">
																		<label for="department"
																			class="col-md-5 col-form-label">Doctor </label>
																		<div class="col-md-7">
																			<select class="form-control" id="doctorMappingId" name="doctorMappingId">
																				<option value="0" selected="selected">Select</option>
																			</select>
																		</div>
																	</div>
																</div>
														
														<div class="col-md-4">
															<div class="form-group row">
																<label for="Priority" class="col-md-5 col-form-label">Priority</label>
																<div class="col-md-7">
																	<select name="priority" id="priorityId"
																		class="form-control">
																		<option value="1">High</option>
																		<option value="2">Medium</option>
																		<option value="3" selected="selected">Low</option>
																	</select>
																</div>
															</div>
														</div>
														<div class="w-100"></div>
														<!-- 
														<div class="col-md-2 ">
															<table class="table" border="0" cellspacing="0" cellpadding="5"
																width="100%" id="appTypeTable"></table>
														</div> 
														-->
														
														<div class="col-md-3">
															<div id="displayToken"  class="form-group row  token_value_manage"></div>
															<input type="hidden" class="form-control-plaintext" id="tokenCountValue" name="tokenCountValue">
														</div>
													</div>
														
													 <div>	
														<div id="showforOpd" class="row" style="display:none">
															<div class="col-md-4">
													           <div class="form-group row">
													            <div id="forOpdCheck" class="col-md-5 col-form-label">
													            </div>
													           </div>
													          </div>
													          <div class="col-md-3 offset-md-5">
													          	<div id="showOpdToken">
													             
													            </div>
													          </div>
														</div>	
														
														<div id="showforME" class="row" style="display:none">
															
															<div class="col-md-1">
													           <div class="form-group row">
													            <div  id="forMECheck" class="col-md-5 col-form-label">
													         </div>
													           </div>
													          </div>
													          
													        <div class="col-md-4">
																<div class="form-group row"  id="examDiv"  style="display:none">
																	<label for="examType" class="col-md-5 col-form-label">Exam Type
																	</label>
																	<div class="col-md-7">
																		<select class="form-control" id="examTypeId" name="examTypeId" onchange="resetTokenDataValue('E')" >
																			<option value="0" selected="selected">Select</option>
																		</select>
																	</div>
																</div>
															</div>
															
													           <div class="col-md-4">
													           <div  id="examAgeDiv" style="display:none;">
													           <input type="hidden" class="form-control-plaintext" id="lastMEAgeId" name="lastMEAgeId">
													            <input type="hidden" class="form-control-plaintext" id="ridcId" name="ridcId">
																	<div class="form-group row">																		
																		<div class="col-md-6">
																			<select class="form-control" id="meAgeId" name="meAgeId"  onchange="validateLastME()">
																				<option value="0" selected="selected">Select Age</option>
																			</select>
																		</div>
																		<div class="col-md-6">
																			<label for="examType" class="col-form-label"> Last AME Year :</label>
																			 <span id="lastYearSpan" class="font-weight-bold"></span>
																		</div>
																	 <input type="hidden" class="form-control-plaintext" id="ageListForME" name="ageListForME">	
																	 <input type="hidden" class="form-control-plaintext" id="ageFlagME" name="ageFlagME">		
																	</div>
																	<div class="form-group row">																		
																		<div class="col-md-10">
																			<div class="fileUploadDiv" id="fileUploadDivId" style="display:none;">
					   														  	<input type="file" multiple  class="file inputUpload" name="fileUpload" id="fileUpload">
					   														  	<label class="inputUploadlabel">Choose File</label>
																				<span id="spanInputUploadFileName" class="inputUploadFileName">No File Chosen</span>
				   														  	</div>
																		</div>
																		
																	</div>
																	</div>
																</div>
													          
													          
															
															<div class="col-md-3">
																<div id="showMEToken">
													            
													            </div>
															</div>
															
														
														</div>	
														
														<div id="showforMB" class="row" style="display:none">
															
															  <div class="col-md-1">
													           <div class="form-group row">
													            <div  id="forMBCheck" class="col-md-5 col-form-label">
													            
													            </div>
													            
													           </div>
													          </div>
													          
													          <div class="col-md-4" >
															<div class="form-group row"  id="boardDiv" style="display:none">
																<label for="boardType" class="col-md-5 col-form-label">Board Type</label>
																<div class="col-md-7">
																	<select class="form-control" id="boardTypeId" name="boardTypeId" onchange="resetTokenDataValue('B')" >
																		<option value="0" selected="selected">Select</option>
																	</select>
																</div>
															</div>
														</div>
														
														<div class="col-md-3 offset-md-4">
															<div id="showMBToken">
															
													           </div>
														</div>
														
														</div>	
													</div>	

													</div>
													<!-- Visit details div  with department -->
												</div>
					
					              </div>										
									
											<div class="clearfix"></div>
											
									            <div class="row m-t-10"> 
												      <div class="col-md-12">
															<div class="btn-left-all"> 
															</div> 
															<div class="btn-right-all">
																<button style="display: none;" class="btn btn-primary" type="button" name="Print"
																	onClick="validateDivToken()">Show Token</button>
																<button class="btn btn-primary"  id='submitbtn' type="button"
																	onclick="submitFormdata();">Submit</button>
															</div> 
													   </div>
												  </div>
									
												
					<!----------------------  end here --------------------------->											
												
												 
												
												
											</form>
											
											 
												 
												 
		<!-- End form patient   -->
										</div>
									</div> 


		<!-- End Tab Coding   -->
									</div>
								</div>
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
		<input type="hidden" class="form-control" id="rspMsgME" name="rspMsgME" value="">
		<input type="hidden" class="form-control" id="rspMsgMB" name="rspMsgMB" value="">
	</form>

	<script type="text/javascript" language="javascript">

$j(document).ready(function(){
	getDepartmentBloodGroupAndMedicalCategory();
	
		//activaTab('empTab');
		
	 	 $j('#serviceNoId').val(""); 
	 	 
	 	// making age flag N default 
	 	   $j('#ageFlagME').val("N");
	 	
	 	  $("#patientTab :input").attr("disabled", true);
	 	 
	 	 
	});



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
               var url = 'getEmployeeAndDependentlist';
               var bClickable = true;
                 GetJsonData('tblListOfEmployeeAndDepenent', data, url, bClickable);
                 }else{
                 alert("Please enter the service number");
                 $j('#loadingDiv').hide();
                 $("#patientTab :input").attr("disabled", true);
                  return false;
                  }
                 }

 function makeTable(jsonData) {
    var htmlTable = "";
    $("#loadingDiv").hide();
    if(jsonData.status==1){
    var data = jsonData.count;
    var dataList = jsonData.data;
		 for(i in dataList){
	    	  htmlTable = htmlTable + "<tr id='" + dataList[i].Id + "'>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[i].name + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[i].dateOfBirth + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[i].age + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[i].gender + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[i].relation + "</td>";
	    	  
	      }
		  //$j('#message').html('');
	      $j("#tblListOfEmployeeAndDepenent").html(htmlTable);
		  $j('#tblEmpAndDetails').show();
	}else{
		
		 $j('#tblEmpAndDetails').hide();
		 $j("#tblListOfEmployeeAndDepenent").empty();
		 alert(jsonData.msg);
		 //$j('#message').html(jsonData.msg);
        
	}
  }
 
 

function executeClickEvent(rowId,jsonData) {
	$("#submitbtn").attr("disabled", false);
	$("#loadingDivNew").hide();
	$j('#forOpdCheck').empty();
	$j('#forMECheck').empty();
	$j('#forMBCheck').empty();
	$j('#showOpdToken').empty();
	$j('#showMBToken').empty();
	$j('#showMEToken').empty();	
	
	$j('#showforOpd').hide();
	$j('#showforMB').hide();
	$j('#showforME').hide();
	$j('#examDiv').hide();
	$j('#boardDiv').hide();
	$j('#examAgeDiv').hide();
	$j('#docDiv').hide();
	
	
	var dataList=jsonData.data;
	 for(i in dataList){
		if(dataList[i].Id===parseInt(rowId)){
		if(dataList[i].patientStatus=='' || dataList[i].patientStatus=='o' || dataList[i].patientStatus=='O' ){
		$j('#medicalCategoryId').val(""); 
		$j('#dateId').val(""); 
		$j('#durationId').val("0"); 
		$j('#departmentId').val("0"); 
		$j('#appTypeTable').empty();
		$j('#displayToken').empty();
		
		$j('#tokenCountValue').val("");  // new added
		
		 $j('#uhidNo').val(dataList[i].uhidNo); 
		
		if(dataList[i].uhidNo!=""){
			$j("#patientId").val(dataList[i].patientId)
		}else{
			$j("#patientId").val("0")
		}
		
		 $j('#empId').val(dataList[i].employeeId);
		 $j('#empService').val(dataList[i].serviceNo); 
	   //$j('#rank').val(dataList[item].empRank); 
		 $j('#rankId').val(dataList[i].empRankId); 
	   //$j('#trade').val(dataList[item].empTradeName); 
		 $j('#tradeId').val(dataList[i].empTradeId); 
		 $j('#empName').val(dataList[i].empName); 
		 $j('#totalservice').val(dataList[i].empTotalService); 
		 $j('#empServiceJoinDate').val(dataList[i].empServiceJoinDate); 
	   //$j('#unit').val(dataList[item].empUnitName); 
		 $j('#unitId').val(dataList[i].empUnitId); 
	   //$j('#region').val(dataList[item].empCommandName); 
		 $j('#regionId').val(dataList[i].empCommandId);
	   //$j('#recordoffice').val(dataList[item].empRecordOfficeName); 
		 $j('#recordofficeId').val(dataList[i].empRecordOfficeId); 
	   //$j('#maritalstarus').val(dataList[item].empMaritalStatusName); 
		 $j('#maritalstarusId').val(dataList[i].empMaritalStatusId); 
	   //$j('#religion').val(dataList[i].empReligion); 
		 $j('#religionId').val(dataList[i].empReligionId); 
		 $j('#empCategoryId').val(dataList[i].empCategoryId); 
		 
		 $j('#patientname').val(dataList[i].name);
	     $j('#patientRelation').val(dataList[i].relation); 
		 $j('#patientRelationId').val(dataList[i].relationId); 
		 $j('#patientAge').val(dataList[i].age); 
	   //$j('#gender').val(dataList[i].gender);
		 $j('#genderId').val(dataList[i].genderId);
		 $j('#patientMoblienumber').val(dataList[i].mobileNumber); 
		 $j('#patientDOB').val(dataList[i].dateOfBirth); 
		 $j('#patientEmail').val(dataList[i].patientEmailId); 
		 
		 $j('#patientAddressLine1').val(dataList[i].patientAddressL1); 
		 $j('#patientAddressLine2').val(dataList[i].patientAddressL2); 
		 $j('#patientAddressLine3').val(dataList[i].patientAddressL3); 
		 $j('#patientAddressLine4').val(dataList[i].patientAddressL4); 
		 
		 $j('#patientDistrictId').val(dataList[i].patientDistrictId!=null?dataList[i].patientDistrictId:0); 
		 $j('#patientStateId').val(dataList[i].patientStateId!=null?dataList[i].patientStateId:0);
		 
		 if(dataList[i].patientPincode!=0){
			 $j('#patientPincode').val(dataList[i].patientPincode);
		 }

		 $j('#nok1Firstname').val(dataList[i].nok1Name); 
		 
		 $j('#nok1AddressLine1').val(dataList[i].nok1AddressL1); 
		 $j('#nok1AddressLine2').val(dataList[i].nok1AddressL2); 
		 $j('#nok1AddressLine3').val(dataList[i].nok1AddressL3); 
		 $j('#nok1AddressLine4').val(dataList[i].nok1AddressL4); 
		 
		 $j('#nok1DistrictId').val(dataList[i].nok1DistrictId!=null?dataList[i].nok1DistrictId:0); 
		 $j('#nok1StateId').val(dataList[i].nok1StateId!=null?dataList[i].nok1StateId:0); 
		 
		 $j('#nok1Moblienumber').val(dataList[i].nok1MobileNo); 
		
		 $j('#nok1RelationId').val((dataList[i].nok1RelationId!=null?dataList[i].nok1RelationId:0));
		 $j('#nok1Policestation').val(dataList[i].nok1PoliceStation); 
		 $j('#nok1Email').val(dataList[i].nok1EamilId);
		 
		 if(dataList[i].nok1Pincode!=0){
			 $j('#nok1pincode').val(dataList[i].nok1Pincode); 
		 }
		
		 $j('#nok1Contactnumber').val(dataList[i].nok1ContactNo); 
		 
		 
		 $j('#nok2Firstname').val(dataList[i].nok2Name); 
		 $j('#nok2AddressLine1').val(dataList[i].nok2AddressL1); 
		 $j('#nok2AddressLine2').val(dataList[i].nok2AddressL2); 
		 $j('#nok2AddressLine3').val(dataList[i].nok2AddressL3); 
		 $j('#nok2AddressLine4').val(dataList[i].nok2AddressL4); 

		 $j('#nok2DistrictId').val(dataList[i].nok2DistrictId!=null?dataList[i].nok2DistrictId:0); 
		 $j('#nok2StateId').val(dataList[i].nok2StateId!=null?dataList[i].nok2StateId:0); 
		 
		 $j('#nok2Moblienumber').val(dataList[i].nok2MobileNo);
		 
		 if(dataList[i].nok2RelationId){
			 $j('#nok2RelationId').val((dataList[i].nok2RelationId!=0?dataList[i].nok2RelationId:0)); 
			 $j('#nok2Relation').val((dataList[i].nok2Relation!=null?dataList[i].nok2Relation:""));  
		 }else{
			 $j('#nok2RelationId').val("0");
			 $j('#nok2Relation').val("");
		 }
		
		 $j('#nok2Policestation').val(dataList[i].nok2PoliceStation); 
		 $j('#nok2Email').val(dataList[i].nok2EamilId); 
		 
		 if(dataList[i].nok2Pincode!=0){
			 $j('#nok2pincode').val(dataList[i].nok2Pincode);  
		 }
		
		 $j('#nok2Contactnumber').val(dataList[i].nok2ContactNo); 
		 
		 
		 
		  $j('[name=bloodGroup] option').filter(function() { 
			    return ($j(this).text()==dataList[i].patientBloodGroup); 
			}).prop('selected', true); 
		
		
		 if(dataList[i].relationId==selfRelationId){
			 $j("#lblmedicalCategory").show();
			 $j("#medicalCategoryId").show();
			 $j("#lbldate").show();
			 $j("#dateId").show();
			 $j("#lblduration").show();
			 $j("#durationId").show();
			
			 /* $j('[name=medicalCategory] option').filter(function() { 
				    return ($j(this).text()==dataList[i].empMedicalCategory); 
				}).prop('selected', true); 
			  */
			 $j("#medicalCategoryId").val(dataList[i].empMedicalCategory);
			 $j('#dateId').val(dataList[i].dateME);  
			 $j("#calDateDiv").show();
		 }else{
			// $j("#medicalCategoryId").val($j("#medicalCategoryId option:first").val());
			 $j("#medicalCategoryId").val("");
			 $j("#lblmedicalCategory").hide();
			 $j("#medicalCategoryId").hide();
			 $j("#lbldate").hide();
			 $j("#dateId").hide();
			 $j("#lblduration").hide();
			 $j("#durationId").hide();
			 $j("#calDateDiv").hide();
			 
		 }
		 makeFieldsReadonly();	 
		 activaTab('patientTab');
		 
		 }
		else{
			if(dataList[i].patientStatus=='I' || dataList[i].patientStatus=='i'){
				alert("This patient is already admitted.");
				return;
			}
			if(dataList[i].patientStatus=='D' || dataList[i].patientStatus=='d'){
				alert("This patient is dead.");
				return;
			}
		}
		}
	}
	 
	 $j('.selectTextWarp').each(function(){	
		 var firstLoadId = $(this).attr('id');
		 wrapSelectText(firstLoadId);
	 });
 }
 
 
  function activaTab(tabId){
	 $j("#patientTab :input").attr("disabled", false);
	 $j('.nav-tabs a[href="#' + tabId + '"]').tab('show');
	 
 } 
  
  
  
 function makeFieldsReadonly(){
	 	 $j("#empService").prop("readonly", true); 
		 $j('#empService').prop("readonly", true);
		 $j('#rank').prop("readonly", true);
		 $j('#trade').prop("readonly", true);
		 $j('#empName').prop("readonly", true);
		 $j('#totalservice').prop("readonly", true);
		 $j('#unit').prop("readonly", true);
		 $j('#region').prop("readonly", true);
		 $j('#recordoffice').prop("readonly", true);
		 $j('#maritalstarus').prop("readonly", true);
		 $j('#religion').prop("readonly", true);
		 
		 $j('#patientname').prop("readonly", true);
		 $j('#patientRelation').prop("readonly", true);
		 $j('#patientAge').prop("readonly", true);
		 $j('#gender').prop("readonly", true); 
		 $j('#patientMoblienumber').prop("readonly", false);
		 $j('#patientDOB').prop("readonly", false);
		 $j('#patientEmail').prop("readonly", true);
		 
		 
		 $j('#addressLine1').prop("readonly", true); 
		 $j('#addressLine2').prop("readonly", true); 
		 $j('#addressLine3').prop("readonly", true); 
		 $j('#addressPost').prop("readonly", true); 
		 $j('#districtId').prop("readonly", true); 
		 $j('#district').prop("readonly", true);
		 $j('#state').prop("readonly", true);
		 $j('#stateId').prop("readonly", true);
		 $j('#pincode').prop("readonly", true);
		
 }
 
 function getRegionFromStation(){
	 var unitId = $j('#unitId').find('option:selected').val();
	 if(unitId!=0){
			var params = {
					"unitId":unitId
			}
			$j.ajax({
				type : "POST",
				contentType : "application/json",
				url : 'getRegionFromStation',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(response) {
					if (response.status == '1') {
						var commandList='';
						document.getElementById("regionId").options.length = 1;  
						var commandFromStation = response.commandFromStation;
						for(var i = 0;i< commandFromStation.length;i++){
							commandList += '<option value='+commandFromStation[i].commandId+'>'
											+ commandFromStation[i].commandName
											+ '</option>';
						 }
							$j('#regionId').append(commandList); 	
							$('#regionId').prop('selectedIndex',1);
					}else{
						document.getElementById("regionId").options.length = 1;
						alert("This unit has no region/command.");
					}
				},
				error : function(msg) {
					alert("An error has occurred while contacting the server");
				}
			});
		}
	
 }
 
 function getAppointmentType(){
 $("#submitbtn").attr("disabled", false);
 $("#loadingDivNew").show();
		$j('#appTypeTable').empty();
		$j('#displayToken').empty();
		 
		$j('#forOpdCheck').empty();
		$j('#forMECheck').empty();
		$j('#forMBCheck').empty();
		$j('#showOpdToken').empty();
		$j('#showMBToken').empty();
		$j('#showMEToken').empty();	
		$j('#showforOpd').hide();
		$j('#showforMB').hide();
		$j('#showforME').hide();
		
		 $j('#tokenCountValue').val("");
		 $j('#examDiv').hide();
		 $j('#boardDiv').hide();
		 
		var deptId = $j('#departmentId').find('option:selected').val();
		var selectedText = $j("#genderId option:selected").html();
		if(deptId!=0 && deptId==DEPARTMENT_TYPE_ID_MATERNITY && (selectedText=='MALE' || selectedText=='Male' || selectedText=='male')){
			alert("Maternity OPD is not for MALE patient.");
			 $("#loadingDivNew").hide();
			return ;
		}else{
			var hospitalId = $j('#hospitalId').val();
			var relationId=$j('#patientRelationId').val();
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
						$("#loadingDivNew").hide();
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
							var tablebody = '';
							var tokenDisplay = '';
							$j('#appTypeTable').empty();
							$j('#displayToken').empty();
							$j('#tokenCountValue').val("");
							
							for(var z=0;z<checkboxLength;z++){
								var checkBoxIdandValue = idandType[z].split("@");
								if(relationId==selfRelationId){
								<%-- 	if(checkBoxIdandValue[1]=="<%=APPOINTMENTTYPE_OPD%>"){ --%>
								if(checkBoxIdandValue[1]== APPOINTMENTTYPE_OPD){
										tablebody = '';
										$j('#showforOpd').show();
										tablebody += '<div class="form-check form-check-inline cusCheck"><input type="checkbox"  class="form-check-input m-r-10" id ="tdOPD" name="checkDiv" value="'+checkBoxIdandValue[1]+'"  onclick="checkClickEvent()" /><span class="cus-checkbtn"></span> <span id="td'+z+'">'+checkBoxIdandValue[0]+'</span></div>';
										$j('#forOpdCheck').append(tablebody);
									}else if(checkBoxIdandValue[1]==APPOINTMENTTYPE_ME){
										tablebody = '';
										$j('#showforME').show();
										tablebody += '<div class="form-check form-check-inline cusCheck"><input type="checkbox" class="form-check-input m-r-10"  id ="tdME" name="checkDiv" value="'+checkBoxIdandValue[1]+'"  onclick="openExamSubType('+checkBoxIdandValue[1]+')" /><span class="cus-checkbtn"></span> <span id="td'+z+'">'+checkBoxIdandValue[0]+'</span></div>';
										$j('#forMECheck').append(tablebody);
									} else if(checkBoxIdandValue[1]==APPOINTMENTTYPE_MB){
										tablebody = '';
										$j('#showforMB').show();
										tablebody += '<div class="form-check form-check-inline cusCheck"><input type="checkbox" class="form-check-input m-r-10"  id ="tdMB" name="checkDiv" value="'+checkBoxIdandValue[1]+'"  onclick="openBoardSubType('+checkBoxIdandValue[1]+')" /><span class="cus-checkbtn"></span> <span id="td'+z+'">'+checkBoxIdandValue[0]+'</span></div>';
										$j('#forMBCheck').append(tablebody);
									}
								}else{
									if(checkBoxIdandValue[1]==APPOINTMENTTYPE_OPD){
										tablebody = '';
										$j('#showforOpd').show();
										tablebody += '<div class="form-check form-check-inline cusCheck"><input type="checkbox"  class="form-check-input m-r-10" id ="tdOPD" name="checkDiv" value="'+checkBoxIdandValue[1]+'" onclick="checkClickEvent()" /><span class="cus-checkbtn"></span> <span id="td'+z+'">'+checkBoxIdandValue[0]+'</span></div>';	
										$j('#forOpdCheck').append(tablebody);
										break;
									}else{
										alert("Appointment Type OPD is not available.")
										break;
									}
								}
							}
						}else{
							alert("Appointment Type is not available");
							$j('#appTypeTable').empty();	
						}
					},
					error : function(msg) {
						$("#loadingDivNew").hide();
						alert("An error has occurred while contacting the server");
					}
				});
			}else{
				$("#loadingDivNew").hide();
				$j('#appTypeTable').empty();
				$j('#displayToken').empty();
				$j('#tokenCountValue').val("");
				
			}
		}
	}
 
 function checkDoctorMapping(){
	 document.getElementById("doctorMappingId").options.length = 1;
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
				url : '${pageContext.request.contextPath}/appointment/getDoctorListFromMapping',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(response) {
					if (response.status == '1') {
						$j('#docDiv').show();
						var  doctorList = response.doctorDeptMappingList;
						var doctorValues='';
						for(i in doctorList){
							doctorValues += '<option value='+doctorList[i].doctorId+'>'
											+ doctorList[i].doctorName
											+ '</option>';
						 }
							$j('#doctorMappingId').append(doctorValues); 	
					}else{
						$j('#docDiv').hide();
					}
				},
				error : function(msg) {
					alert("An error has occurred while contacting the server");
				}
			});
		}else{
			$j('#docDiv').hide();
		}
 }
 
 
 function openExamSubType(appTypeId){
	 document.getElementById("examTypeId").options.length = 1;
	 if($("#tdME").prop('checked') == true){
		 var params = {
					"appTypeId":appTypeId
				 } 	
					$j.ajax({
						type : "POST",
						contentType : "application/json",
						url : 'getExamSubType',
						data : JSON.stringify(params),
						dataType : "json",
						cache : false,
						success : function(response) {
							if(response.status=="1"){
								validateDivToken();
								var  subTypeList = response.masExamList;
								var  appType = response.appTypeId;
								var examValues='';
								for(exam in subTypeList){
									 examValues += '<option value='+subTypeList[exam].examId+'>'
													+ subTypeList[exam].examName
													+ '</option>';
								 }
									$j('#examTypeId').append(examValues); 
							}else{
								alert("No ME type available.")
								$("#tdME").prop("checked", false);
							}
					},
						error : function(msg) {
							alert("An error has occurred while contacting the server");
						}
				    
				}); 
		}else{
			document.getElementById("examTypeId").options.length = 1;
			$j('#showMEToken').empty();	
			$j('#examDiv').hide();
			$j('#examAgeDiv').hide();
			$j('#fileUploadDivId').hide();
			$j('#ageFlagME').val("N");
			validateDivToken();
			
			
	 }
				
 }
 
 
 function openBoardSubType(appTypeId){
	 document.getElementById("boardTypeId").options.length = 1;
	 if($("#tdMB").prop('checked') == true){
		 var params = {
					"appTypeId":appTypeId
				 } 	
					$j.ajax({
						type : "POST",
						contentType : "application/json",
						url : 'getExamSubType',
						data : JSON.stringify(params),
						dataType : "json",
						cache : false,
						success : function(response) {
							if(response.status=="1"){
								validateDivToken();
								var  subTypeList = response.masExamList;
								var  appType = response.appTypeId;
								var boardValues='';
								for(board in subTypeList){
									boardValues += '<option value='+subTypeList[board].examId+'>'
													+ subTypeList[board].examName
													+ '</option>';
								 }
									$j('#boardTypeId').append(boardValues);
							}else{
								alert("No MB type available.")
								$("#tdMB").prop("checked", false);
							}
					},
						error : function(msg) {
							alert("An error has occurred while contacting the server");
						}
				    
				});	
	 }else{
		 document.getElementById("boardTypeId").options.length = 1;
		 $j('#showMBToken').empty();
		 $j('#boardDiv').hide();
		 validateDivToken();
	 }
			
 }
 
 var mEFlag=false;
 var mBFlag=false;
 function validateDivToken(){
	 	$j('#showOpdToken').empty();
		$j('#showMBToken').empty();
		$j('#showMEToken').empty();	
	
	<%-- openExamSubType(<%=APPOINTMENTTYPE_ME%>); --%>
	
	if($j('#examTypeId').val()=='0' && $j('#meAgeId').val()=='0'){
		document.getElementById("meAgeId").options.length=1;
	}
	
	$j("#submitbtn").attr("disabled", true);
	
	 if(validateDeptAndAppointment()){
		 var arrParam=[];
		 var deptId = $j('#departmentId').find('option:selected').val();
		 var hospitalId = $j('#hospitalId').val(); //Hospiatl id will fetch from session
		 var visitFlag=$j('#visitFlag').val(); // It is fetching from hidden field
		 var patientId=$j('#patientId').val();
		 var visitDate="";
		 var appointmentTypeId=[];
		 $j.each($j("input[name=checkDiv]:checked"), function(){  
			  appointmentTypeId.push($j(this).val());
         });
		
	var params = {
					"deptId" : deptId,
					"appointmentTypeId" : appointmentTypeId,
					"hospitalId" : hospitalId,
					"visitFlag" : visitFlag,
					"visitDate" : visitDate,
					"patientId" : patientId
			}
			arrParam.push(params);
	
	// The uper code will comes with in loop if we will go for multi specility 
	
	 var resuestData ={
			"arrParam":arrParam
			}
	 
			$j.ajax({
				type : "POST",
				contentType : "application/json",
				url : 'tokenNoForDepartmentMultiVisit',
				data : JSON.stringify(resuestData),
				dataType : "json",
				cache : false,
				success : function(msg) {
					var displayToken = '';
					var tokenCount = '';
					$j('#tokenCountValue').val("");
					$j('#showOpdToken').empty();
					$j('#showMBToken').empty();
					$j('#showMEToken').empty();	
					$j("#submitbtn").attr("disabled", false);
					for(count in msg.jsonList){
						if( msg.jsonList[count].status=='1'){
							if(isNaN(msg.jsonList[count].tokenMsg)){
								if(msg.jsonList[count].appointmentTypeId==APPOINTMENTTYPE_ME){
									$j('#showforME').show();
									if(msg.jsonList[count].tokenMsg=="I"){
										displayToken = ''
										$j('#examTypeId').prop("disabled",false);
										$j('#examDiv').show();
										$j('#examAgeDiv').show();
										ageDropdown(msg.jsonList[count].lastAgeME);
										$j('#ageFlagME').val("V");
										$j('#lastYearSpan').html(msg.jsonList[count].MEYear);
										$j('#lastMEAgeId').val(msg.jsonList[count].lastAgeME);
										displayToken +='<span  style="display:none;" name="tokenNo" id="tokenNoId'+count +'" data-value="0"  ></span>';
										$j('#showMEToken').append(displayToken);
									}else if(msg.jsonList[count].tokenMsg=="AI"){
										displayToken = ''
										$j('#examDiv').hide();
										mEFlag=true;
										displayToken +='<div class="col-form-label tokenMsgDisplay"><span  name="tokenNo" id="tokenNoId'+count +'" data-value="ME already initiated for '+msg.jsonList[count].examType+'. Please uncheck ME."  data-count='+count+'>ME already initiated for '+msg.jsonList[count].examType+'</span> </div>';
										tokenCount=count;
										$j('#showMEToken').append(displayToken);
									}else if(msg.jsonList[count].tokenMsg=="T"){ 
										displayToken = ''
										$j('#examDiv').hide();
										mEFlag=true;
										displayToken +='<div class="col-form-label tokenMsgDisplay"><span  name="tokenNo" id="tokenNoId'+count +'" data-value="Appointment already booked for '+msg.jsonList[count].examType+'. Please uncheck ME." data-count='+count+'>Appointment already booked for '+msg.jsonList[count].examType+'</span> </div>';
										tokenCount=count;
										$j('#showMEToken').append(displayToken);
									}else if(msg.jsonList[count].tokenMsg=="C"){
										displayToken = ''
										if(msg.jsonList[count].examType=="ME18"){
											mEFlag=true;
											$j('#examDiv').hide();
											displayToken +='<div class="col-form-label tokenMsgDisplay"><span  name="tokenNo" id="tokenNoId'+count +'"  data-value="Medical Exam is completed this year for '+msg.jsonList[count].examType+'" data-count='+count+'>Medical Exam is completed this year for '+msg.jsonList[count].examType+'</span> </div>';
										}else{
											$j('#examTypeId').prop("disabled",false);
											$j('#examDiv').show();
											displayToken +='<div class="col-form-label tokenMsgDisplay"><span  name="tokenNo" id="tokenNoId'+count +'"  data-value="0" data-count='+count+'>Medical Exam is completed this year for '+msg.jsonList[count].examType+'</span> </div>';
										}
										
										tokenCount=count;
										$j('#showMEToken').append(displayToken);
									}
									// Details filled in portal
									else if(msg.jsonList[count].tokenMsg=="PE"){
										displayToken = ''
										$j('#examDiv').hide();
										mEFlag=true;
										displayToken +='<div style="display:none" class="col-form-label tokenMsgDisplay"><span  name="tokenNo" id="tokenNoId'+count +'" data-value="Please fill details for release and discharge on web portal before proceeding for appointment.">Please fill details for release and discharge on web portal before proceeding for appointment.</span></div>';
										tokenCount=count;
										$j('#showMEToken').append(displayToken); 
										alert("Please fill details for release and discharge on web portal before proceeding for appointment.");
										
									}else{ // check this condition will comes when doctor roster or app set up is not done
										displayToken = ''
										$j('#examDiv').hide();
										mEFlag=true;
										if(msg.jsonList[count].APPTYPE=="ROSTER"){
											displayToken +='<div class="col-form-label tokenMsgDisplay"><a href="#" onclick="openDoctorRosterTab(tdME,showMEToken)"><span  name="tokenNo" id="tokenNoId'+count +'" data-value="'+msg.jsonList[count].tokenMsg+'" data-count='+count+'>'+msg.jsonList[count].tokenMsg+'</span></a> </div>';
										}else{
											displayToken +='<div class="col-form-label tokenMsgDisplay"><a href="#" onclick="openAppSetupTab(tdME,showMEToken)"><span  name="tokenNo" id="tokenNoId'+count +'" data-value="'+msg.jsonList[count].tokenMsg+'" data-count='+count+'>'+msg.jsonList[count].tokenMsg+'</span></a> </div>';
										}
										tokenCount=count;
										$j('#showMEToken').append(displayToken);
									}
								}else if(msg.jsonList[count].appointmentTypeId==APPOINTMENTTYPE_MB){
									$j('#showforMB').show();
									if(msg.jsonList[count].tokenMsg=="I"){
										displayToken = '';
										$j('#boardTypeId').prop("disabled",false);
										$j('#boardDiv').show();
										displayToken +='<span  style="display:none;" name="tokenNo" id="tokenNoId'+count +'" data-value="0"></span>';
										tokenCount=count;
										$j('#showMBToken').append(displayToken);
									}else if(msg.jsonList[count].tokenMsg=="AI"){
										displayToken = '';
										$j('#boardDiv').hide();
										mBFlag=true;
										displayToken +='<div class="col-form-label tokenMsgDisplay"><span name="tokenNo" id="tokenNoId'+count +'" data-value="MB already initiated for '+msg.jsonList[count].examType+'. Please uncheck MB." data-count='+count+' >MB already initiated for '+msg.jsonList[count].examType+'</span> </div>';
										tokenCount=count;
										$j('#showMBToken').append(displayToken);
									}else if(msg.jsonList[count].tokenMsg=="T"){ 
										displayToken = '';
										$j('#boardDiv').hide();
										mBFlag=true;	
										displayToken +='<div class="col-form-label tokenMsgDisplay"><span name="tokenNo" id="tokenNoId'+count +'" data-value="Appointment already booked for'+msg.jsonList[count].examType+'. Please uncheck MB." data-count='+count+'>Appointment already booked for '+msg.jsonList[count].examType+'</span> </div>';
										tokenCount=count;
										$j('#showMBToken').append(displayToken);
									}else if(msg.jsonList[count].tokenMsg=="C"){
										displayToken = ''
										if(msg.jsonList[count].examType=="MB15"){
											$j('#boardTypeId').prop("disabled",false);
											$j('#boardDiv').show();
											displayToken +='<div class="col-form-label tokenMsgDisplay"><span name="tokenNo" id="tokenNoId'+count +'" data-value="0" data-count='+count+'>Medical Board for '+msg.jsonList[count].examType+' is done in previous.</span> </div>';
										}else{
											$j('#boardDiv').hide();
											mBFlag=true;
											displayToken +='<div class="col-form-label tokenMsgDisplay"><span name="tokenNo" id="tokenNoId'+count +'" data-value="Medical Board for '+msg.jsonList[count].examType+' is completed." data-count='+count+'>Medical Board for '+msg.jsonList[count].examType+' is completed.</span> </div>';
										}
										tokenCount=count;
										$j('#showMBToken').append(displayToken);
									}
									// Details filled in portal
									else if(msg.jsonList[count].tokenMsg=="PE"){
										displayToken = ''
										$j('#boardDiv').hide();
										mBFlag=true;
										displayToken +='<div style="display:none" class="col-form-label tokenMsgDisplay"><span  name="tokenNo" id="tokenNoId'+count +'" data-value="Please fill details for release and discharge on web portal before proceeding for appointment.">Please fill details for release and discharge on web portal before proceeding for appointment.</span> </div>';
										tokenCount=count;
										$j('#showMBToken').append(displayToken); 
										alert("Please fill details for release and discharge on web portal before proceeding for appointment.");
										
									}else{ // check this condition will comes when doctor roster or app set up is not done
										displayToken = ''
										$j('#boardDiv').hide();
										mBFlag=true;
										if(msg.jsonList[count].APPTYPE=="ROSTER"){
											displayToken +='<div class="col-form-label tokenMsgDisplay"><a href="#" onclick="openDoctorRosterTab(tdMB,showMBToken)"><span name="tokenNo" id="tokenNoId'+count +'" data-value="'+msg.jsonList[count].tokenMsg+'" data-count='+count+'>'+msg.jsonList[count].tokenMsg+'</span></a></div>';
										}else{
											displayToken +='<div class="col-form-label tokenMsgDisplay"><a href="#" onclick="openAppSetupTab(tdMB,showMBToken)"><span name="tokenNo" id="tokenNoId'+count +'" data-value="'+msg.jsonList[count].tokenMsg+'" data-count='+count+'>'+msg.jsonList[count].tokenMsg+'</span></a></div>';
										}
										tokenCount=count;
										$j('#showMBToken').append(displayToken);
									}
								}else{
									displayToken = ''
									$j('#showforOpd').show();
									if(msg.jsonList[count].APPTYPE=="ROSTER"){
										displayToken += '<div class="col-form-label tokenMsgDisplay"><a href="#" onclick="openDoctorRosterTab(tdOPD,showOpdToken)"><span name="tokenNo" id="tokenNoId'+count +'" data-value="'+msg.jsonList[count].tokenMsg+'">' +msg.jsonList[count].tokenMsg+ '</span></a> </div>';
									}else{
										displayToken += '<div class="col-form-label tokenMsgDisplay"><a href="#" onclick="openAppSetupTab(tdOPD,showOpdToken)"><span name="tokenNo" id="tokenNoId'+count +'" data-value="'+msg.jsonList[count].tokenMsg+'">' +msg.jsonList[count].tokenMsg+ '</span></a> </div>';
									}
									tokenCount=count;
									$j('#showOpdToken').append(displayToken);
								}
							}else{ // when token message is number
								if(msg.jsonList[count].appointmentTypeId==APPOINTMENTTYPE_MB){
									displayToken = ''
									$j('#boardDiv').show();
									$j('#boardTypeId').val(msg.jsonList[count].medExBrdId);
									$j('#boardTypeId').prop("disabled",true);
									$j('#existingVisitIdMB').val(msg.jsonList[count].visitId);
									displayToken += '<div class="col-form-label tokenDisplay">Token No. <span name="tokenNo" id="tokenNoId'+count +'"  data-value="'+msg.jsonList[count].tokenMsg+'">' +msg.jsonList[count].tokenMsg+ '</span> </div>';
									tokenCount=count;
									$j('#showMBToken').append(displayToken);
									
								}else if(msg.jsonList[count].appointmentTypeId==APPOINTMENTTYPE_ME){
									displayToken = ''
									$j('#examDiv').show();
									$j('#examTypeId').val(msg.jsonList[count].medExBrdId);
									$j('#examTypeId').prop("disabled",true);
									$j('#existingVisitIdME').val(msg.jsonList[count].visitId);
									displayToken += '<div class="col-form-label tokenDisplay">Token No. <span name="tokenNo" id="tokenNoId'+count +'"  data-value="'+msg.jsonList[count].tokenMsg+'">'+msg.jsonList[count].tokenMsg+'</span> </div>';
									tokenCount=count;
									$j('#showMEToken').append(displayToken);
									//$j('#examTypeId').prop("disabled",false);
								}else{
									displayToken = ''
									displayToken += '<div class="col-form-label tokenDisplay">Token No. <span name="tokenNo" id="tokenNoId'+count +'"  data-value="'+msg.jsonList[count].tokenMsg+'">'+msg.jsonList[count].tokenMsg+'</span> </div>';
									tokenCount=count;
									$j('#showOpdToken').append(displayToken);
								}
							}
							
						}else{
							$j('#showMBToken').html('<div class="col-form-label tokenMsgDisplay">'+msg.jsonList[count].tokenMsg+'</div>');
							return;
						}
					}
					displayToken = '';
					$j('#tokenCountValue').val(tokenCount);
					$j('#displayToken').html(displayToken);
					$j("#submitbtn").attr("disabled", false);
					
				},
				error : function(msg) {
					alert("An error has occurred while contacting the server");
				}
			}); 
	 }
 }
 
function ageDropdown(lastAge){
	if(lastAge==''){
		intCount=16;
	}else{
		intCount=parseInt(lastAge)+1;
	}
	var select = '';
	for (i=intCount;i<=60;i++){
	    select += '<option value=' + i + '>' + i + '</option>';
	}
	$('#meAgeId').append(select);
}
 
function openDoctorRosterTab(checkbox,tokenlbl){
	  if(checkbox.id=="tdOPD"){
		  $j('#tdOPD').prop('checked', false);
		  $j('#showOpdToken').empty();
	  }
	  if(checkbox.id=="tdME"){
		  $j('#tdME').prop('checked', false);
		  $j('#showMEToken').empty();	
	  }
	  
	  if(checkbox.id=="tdMB"){
		  $j('#tdMB').prop('checked', false);
		  $j('#showMBToken').empty();	
	  }
	 window.open('${pageContext.request.contextPath}/admin/doctorRoaster',"_blank");
	}
	
	
function openAppSetupTab(checkbox,tokenlbl){
	 if(checkbox.id=="tdOPD"){
		  $j('#tdOPD').prop('checked', false);
		  $j('#showOpdToken').empty();
	  }
	  if(checkbox.id=="tdME"){
		  $j('#tdME').prop('checked', false);
		  $j('#showMEToken').empty();	
	  }
	  
	  if(checkbox.id=="tdMB"){
		  $j('#tdMB').prop('checked', false);
		  $j('#showMBToken').empty();	
	  }
	 window.open('${pageContext.request.contextPath}/appointment/showappointmentsetup',"_blank");
}


function validateLastME(){
	var ageListForME=[];
	var lastYearMEDOneAge='0';
	var selectedMEAge=$j('#meAgeId').val();
	var patientAge=$j('#patientAge').val();
	
	if(selectedMEAge<=patientAge){

		if($j('#lastMEAgeId').val()!=''){
			lastYearMEDOneAge=$j('#lastMEAgeId').val();
		}
		
		var differenceInAge=parseInt(selectedMEAge)-parseInt(lastYearMEDOneAge);
		if(differenceInAge==1 || lastYearMEDOneAge=='0'){
				ageListForME.push(selectedMEAge);
				$j('#ageFlagME').val("N");
				$j('#fileUploadDivId').hide();
		}else{
			for(i=parseInt(lastYearMEDOneAge)+1;i<=parseInt(selectedMEAge);i++){
				ageListForME.push(i);
				}
			$j('#ageFlagME').val("V");
			$j('#fileUploadDivId').show();
			
		}
		$j('#ageListForME').val(ageListForME);
	}else{
		alert("ME age can not greater than patient age");
		$j('#meAgeId').val('0')
		return;
	}
}
 


function submitFormdata(){
	
	var value=validateFields('patientDetailsForm');
	
	var departmentId = $j('#departmentId').find('option:selected').val();
	if(departmentId == 0){
		alert("Please select Department");
		return ;
	}
	
	if(!$j("input[name='checkDiv']:checked").is(':checked')){
		alert("Please select Appointment Type");
		return ;
	}else{
		var appointmentTypeId=[];
		 $j.each($j("input[name=checkDiv]:checked"), function(){  
			  appointmentTypeId.push($j(this).val());
	   	 });	
	}
	
	if(value==true && checkTokenValue() && validateExamTypeField() ){
		$("#submitbtn").attr("disabled", true);
		
	  	var tokenIds=[];
		$j("span[name='tokenNo']").each(function() {
			 tokenIds.push($j(this).attr('data-value'));
		});
		
		var hospitalId=$j('#hospitalId').val();  
		var priorityId = $j('#priorityId').val();
		

		var ageFlag=$j('#ageFlagME').val();  
		 if(ageFlag=='V'){
			 if($j('#meAgeId').val()=='0'){
			 		alert('Please select age for ME.');
					$("#submitbtn").attr("disabled", false);
				return; 
				 }
			if($j('#fileUpload').val()==''){
					alert('Please upload authority letter.');
					$("#submitbtn").attr("disabled", false);
				return;
				}
			 uploadAuthorityLetterInVisit(departmentId,priorityId,appointmentTypeId,tokenIds,hospitalId); 
		 }else{
			 submitPatientData(departmentId,priorityId,appointmentTypeId,tokenIds,hospitalId);
		 }
	}else{
		if(value!=true)
		alert(value.split('\n')[0]);
	}
}


function submitPatientData(departmentId,priorityId,appointmentTypeId,tokenIds,hospitalId){
	$j('#examTypeId').prop("disabled",false);
	$j('#boardTypeId').prop("disabled",false);
		 var params = {
					 "departmentId":departmentId,
					 "priorityId":priorityId,
					 "appointmentTypeId":appointmentTypeId,
					 "tokenIds":tokenIds,
					 "hospitalId":hospitalId,
					 "ridcId":$j('#ridcId').val(),
					 "patientDetailsForm":$j('#patientDetailsForm').serializeObject() 
					} 
	     $j.ajax({
	   	      type : "POST",
	   		  contentType : "application/json",
			  url : 'submitPatientDetails',
			  data : JSON.stringify(params),
			  dataType : "json",
			  cache : false,
	        success : function(response) {
	        	if(response.status=="1"){
	        		var opdVisitId="";
	        		var mEVisitId="";
	        		var mBVisitId="";
	        		var flag=false;
	        		var opdFlag=false;
	        		var responseList = response.responseMap.visitList;
	        		for(count in responseList ){
	        			if(responseList[count].appType==APPOINTMENTTYPE_OPD && responseList[count].tokenNo!=""){
	        				$j('#visitIdOPD').val(responseList[count].visitId);
	        				$j('#rspMsg').val(responseList[count].msg);
	        				
	        			 }else if(responseList[count].appType==APPOINTMENTTYPE_OPD && responseList[count].tokenNo=="" ){ 
	        					$("#submitbtn").attr("disabled", false);
	        					if(response.listSize==1){
	        						if(responseList[count].visitId==0){
	        							alert(responseList[count].msg);
			        					opdFlag=true;
		        						flag = true;
			        					return false;
	        						}
	        						
	        					}else{
	        						if(responseList[count].visitId==0){
	        							alert(responseList[count].msg);
			        					opdFlag=true;
	        						}
	        					}
	        				}
	        			
						if(responseList[count].appType==APPOINTMENTTYPE_ME && responseList[count].tokenNo!=""){
							$j('#visitIdME').val(responseList[count].visitId);	
							$j('#rspMsg').val(responseList[count].msg);
						}else if(responseList[count].appType==APPOINTMENTTYPE_ME && responseList[count].tokenNo==""){
        					$("#submitbtn").attr("disabled", false);
        					if(response.listSize==1){
        						if(responseList[count].visitId==0){
        							$j('#examTypeId').prop("disabled",true);
            						alert(responseList[count].msg);
            						opdFlag=true;
            						flag = true;
    	        					return false;
        						}else{
        							$j('#rspMsgME').val(responseList[count].msg)
        							$j('#examTypeId').prop("disabled",true);
            						alert(responseList[count].msg);
            						opdFlag=true;
        						}
        						
        					}else{
        						if(response.listSize>1){
        							if(responseList[count].visitId==0){
        								$j('#examTypeId').prop("disabled",true);
                						alert(responseList[count].msg);
                						opdFlag=true;
        							}else{
        								// Nothing here.
        								$j('#rspMsg').val(responseList[count].msg);
        							}
            						
            						
            					}
        					}
						}
						
						if(responseList[count].appType==APPOINTMENTTYPE_MB && responseList[count].tokenNo!=""){
							$j('#visitIdMB').val(responseList[count].visitId);
							$j('#rspMsg').val(responseList[count].msg);
						}else if(responseList[count].appType==APPOINTMENTTYPE_MB && responseList[count].tokenNo==""){

        					$("#submitbtn").attr("disabled", false);
        					if(response.listSize==1){
        						if(responseList[count].visitId==0){
        							$j('#boardTypeId').prop("disabled",true);
            						alert(responseList[count].msg);
            						opdFlag=true;
            						flag = true;
    	        					return false;
        						}else{
        							$j('#rspMsgMB').val(responseList[count].msg)
        							$j('#boardTypeId').prop("disabled",true);
            						alert(responseList[count].msg);
            						opdFlag=true;
        						}
        						
        					}else{
        						if(response.listSize>1){
        							if(responseList[count].visitId==0){
        								$j('#boardTypeId').prop("disabled",true);
                						alert(responseList[count].msg);
                						opdFlag=true;
        							}else{
        								// Nothing here.
        								$j('#rspMsg').val(responseList[count].msg);
        							}
            						
            						
            					}
        					}
						}
						
	        		}
	        		if(!flag){
	        			if(opdFlag){
	        				document.addEventListener('click',function(e){
	       					    if(e.target && e.target.id== 'closeBtn'){
	       					    	document.visitListForm.action="showVisitTokenList";
	       			        		document.visitListForm.method="POST";
	       			        		document.visitListForm.submit();
	       					     }
	       					 });
	        			}else{
	        				document.visitListForm.action="showVisitTokenList";
			        		document.visitListForm.method="POST";
			        		document.visitListForm.submit();
	        			}
	        			
	        		}
	        		
	        	}else if(response.status=="0"){
	        		$("#submitbtn").attr("disabled", false);
	        		alert(response.responseMap.visitList[0].msg);
	        		return false;
	        	}else{
	        		alert(response.errorMessage);
	        	}
	        	
	        },
	     error: function(msg){					
				alert("An error has occurred while contacting the server");
			}
	     }); 
	
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

	function uploadAuthorityLetterInVisit(departmentId,priorityId,appointmentTypeId,tokenIds,hospitalId){
		        var form = $('#patientDetailsForm')[0];
		        var data = new FormData(form);
		        $.ajax({
		            type: 'POST',
		            enctype: 'multipart/form-data',
		            url: 'uploadAuthorityLetter',
		            data: data,
		            processData: false,
		            contentType: false,
		            cache: false,
		            async: true,
		            success: function (data) {
		            	if (!$j.trim(data)){  
		            		$("#submitbtn").attr("disabled", false);
		            		alert("Somthing went wrong while uploading authority letter.")
			            	return false;	
		            	}
		            	else{   
		            		$j('#ridcId').val(data);	
			            	submitPatientData(departmentId,priorityId,appointmentTypeId,tokenIds,hospitalId);
		            	}
		            },
		            error: function (e) {
		                alert(e.responseText);

		            }
		        });
	}


var nanFlag;
function checkTokenValue(){
	var appointmentTypeId=[];
	 $j.each($j("input[name=checkDiv]:checked"), function(){  
		  appointmentTypeId.push($j(this).val());
    });
    var flag=false;
    nanFlag = false;
    var count =appointmentTypeId.length-1;
    for(var i=0;i<=count;i++){
    	var tokenIdValue = $j('#tokenNoId'+i).attr('data-value');
    	if(tokenIdValue){
    		if(isNaN(tokenIdValue)){
        		alert(tokenIdValue);
        		flag=true;
        		nanFlag = true;
        	}else{
        		flag=true;
        		continue;
        		
        	}
    	}else{
		if ($("#tdOPD").prop('checked') == true && (tokenIdValue=="" || tokenIdValue==undefined )) {
						alert("Please check the token number/click on show token");
						flag = false;
						return;
					} else if (($("#tdME").prop('checked') == true)) {
						if ($("#examTypeId").val() == 0) {
							alert("Please select Exam Type");
							flag = false;
							return;
						} else {
							//alert("Please check the token number");
						}
					} else if (($("#tdMB").prop('checked') == true)) {
						if ($("#boardTypeId").val() == 0) {
							alert("Please select Board Type");
							flag = false;
							return;
						} else {
							//alert("Please check the token number");
						}
					}

					flag = true;
				}
			}
			return flag;
		}

		function validateExamTypeField() {
			
			var type = false;
			if ($("#tdME").prop('checked') == true) {
				if ($("#examTypeId").val() != 0) {
					type = true;
				} else if(nanFlag){
					type = false;
					return;
				}else{
					if(!mEFlag){
						alert("Please select Exam Type");
						type = false;
						return;
					}else{
						type = true;
					}
					
				}
			}
			if ($("#tdMB").prop('checked') == true) {
				if ($("#boardTypeId").val() != 0) {
					type = true;
				} else if(nanFlag){
					type = false;
					return;
				}else{
					if(!mBFlag){
						alert("Please select Board Type");
						type = false;
						return;
					}else{
						type = true;
					}
					
				}
			}
			if ($("#tdOPD").prop('checked') == true) {
				type = true;
			}
			return type;

		}

		function validateDeptAndAppointment() {
			var deptId = document.getElementById("departmentId").value;
			if (deptId == 0) {
				alert("Please select Department");
			} else {
				if (!$j("input[name='checkDiv']:checked").is(':checked')) {
					alert("Please select Appointment Type");
					return false;
				}
				return true;
			}
		}

		function resetTokenDataValue(flg){
			<%-- var checkArray=[];
			 $j.each($j("input[name=checkDiv]:checked"), function(){  
				 checkArray.push($j(this).val())
			 });
			 
			 if(checkArray.includes(""+<%=APPOINTMENTTYPE_ME %>) && flg=='E'){
				 $j("span[name='tokenNo']").each(function() {
					 var count =$j(this).attr('data-count');
					if (typeof count === "undefined") {
	   					// nothing to do 
						}else{
							$j(this).attr('data-value',"0");
							$j('#tokenNoId'+count).attr('data-value');
							
						}
				  });
			 }
			if(checkArray.includes(""+<%=APPOINTMENTTYPE_MB %>) && flg =='B'){
				 $j("span[name='tokenNo']").each(function() {
					 var count =$j(this).attr('data-count');
					if (typeof count === "undefined") {
	   					// nothing to do 
						}else{
							$j(this).attr('data-value',"0");
							$j('#tokenNoId'+count).attr('data-value');
							
						}
				  });
			}  --%>
		}
		
		
		function checkClickEvent() {
			if ($("#tdOPD").prop('checked') == false) {
				$j('#showOpdToken').empty();
			}
			validateDivToken();
		}

		$j('#serviceNoId').keypress(function(e) {
			var key = e.which;
			if (key == 13) // the enter key code
			{
				findEmployeeAndDependent();
				return false;
			}
		});

		function checkEmail(sEmail) {
			if ($.trim(sEmail).length == 0) {
				alert('Invalid Email Address');
				return false;
			}
			if (validateEmail(sEmail)) {
				return true;
			} else {
				alert('Invalid Email Address');

				return false;
			}
		}

		function validateLenght(id, length, data) {
			if ($j("#" + id).val().length != length) {
				alert(data + " should be " + length + " digit. ");
				var str = $j("#" + id).val();
				str = str.substring(0, length).trim();
				$j("#" + id).val(str);
				return false;
			}

		}

		function calculateAge() {
			var Bdate = $j('#patientDOB').val()
			var newdate = Bdate.split("/").reverse().join("-");
			var Bday = new Date(newdate);
			var age = parseFloat(((Date.now() - Bday) / (31557600000)), 10)
					.toFixed(3);
			if (age > 0 && age <= 100) {
				showAge();
			} else {
				alert("Age can not be less then 0 or greater then 100");
				$j('#patientDOB').val("");
				$j('#patientAge').val("");
			}

		}

		function showAge() {
			var newdate = $j('#patientDOB').val().toString();
			var mdate = newdate.split("/").reverse().join("-");
			var yearThen = parseInt(mdate.substring(0, 4), 10);
			var monthThen = parseInt(mdate.substring(5, 7), 10);
			var dayThen = parseInt(mdate.substring(8, 10), 10);

			var today = new Date();
			var birthday = new Date(yearThen, monthThen - 1, dayThen);

			var differenceInMilisecond = today.valueOf() - birthday.valueOf();

			var year_age = Math.floor(differenceInMilisecond / 31536000000);
			var day_age = Math
					.floor((differenceInMilisecond % 31536000000) / 86400000);

			if ((today.getMonth() == birthday.getMonth())
					&& (today.getDate() == birthday.getDate())) {
				//  alert("Happy B'day!!");
			}

			var month_age = Math.floor(day_age / 30);

			day_age = day_age % 30;

			/* if (isNaN(year_age) || isNaN(month_age) || isNaN(day_age)) {
				$("#patientAge").val("Invalid date - Please try again");
			} else if (year_age == 0 && month_age == 0 && day_age != 0) {
				$("#patientAge").val(day_age + " days");
			} else if (year_age == 0 && month_age != 0) {
				$("#patientAge").val(month_age + " months");
			} else if (year_age != 0) {
				$("#patientAge").val(year_age + " years ");
			} else if (year_age == 0 && month_age == 0 && day_age == 0) {
				alert("Age can not be less then 0 or greater then 100");
				$j('#patientDOB').val("");
				$j('#patientAge').val("");
				return false;
			} */
			
			if (isNaN(year_age) || isNaN(month_age) || isNaN(day_age)) {
				$("#patientAge").val("Invalid date - Please try again");
			}else if (year_age == 0 && month_age == 0 && day_age == 0) {
				alert("Age can not be less then 0 or greater then 100");
				$j('#patientDOB').val("");
				$j('#patientAge').val("");
				return false;
			}else{
				$("#patientAge").val(year_age + " years, " + month_age + " months, " + day_age + " days");
			}
		}
		
		
		
		function getStateFromDistrict(districtId,flag){
			if(districtId!=0){
				 var params = {
							"districtId":districtId
						 } 	
							$j.ajax({
								type : "POST",
								contentType : "application/json",
								url : 'getStateFromDistrict',
								data : JSON.stringify(params),
								dataType : "json",
								cache : false,
								success : function(response) {
									if(response.status=="1"){
										var stateValuesNew = "";
										if(flag=='p'){
											$j('#patientStateId').empty()
											.append('<option selected="selected" value="0">Select</option>'); 
										}else if(flag=='p1'){
											$j('#nok1StateId').empty()
											.append('<option selected="selected" value="0">Select</option>'); 
										}else if(flag=='p2'){
											$j('#nok2StateId').empty()
											.append('<option selected="selected" value="0">Select</option>'); 
										}
										
										var masStateList = response.stateList;
										 for(state in masStateList){
											 stateValuesNew += '<option value='+masStateList[state].stateId+'>'
															+ masStateList[state].stateName
															+ '</option>';
										 }
										 if(flag=='p'){
											 $j('#patientStateId').append(stateValuesNew);
										 }else if(flag=='p1'){
											 $j('#nok1StateId').append(stateValuesNew);
										 }else if(flag=='p2'){
											 $j('#nok2StateId').append(stateValuesNew);
										 }
										 
									}else{
										
									}
							},
								error : function(msg) {
									alert("An error has occurred while contacting the server");
								}
						    
						}); 
			}
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
	      
  </script>
  <script>
	//increase size of select box based on character to accomodate multiple lines of selected option * additional code in CSS - Paras Ravindran
  function wrapSelectText(a){
	  
	  var selectedElem = a;
	  var selectedOptionText = $('#'+selectedElem).find('option:selected').text();
	  
	  if(selectedElem == 'regionId'){
		  
		  if (selectedOptionText.length>18)
		  {
			  $('#'+selectedElem).css('height','48px');
		  	
		  	if (selectedOptionText.length>33)
			  {
		  		$('#'+selectedElem).css('height','68px');
			  }		  	
		  }		  
		  else
		  {
			  $('#'+selectedElem).css('height','28px');
		  }
	  }
	  
	  else{
		  if (selectedOptionText.length>22)
		  {
			  $('#'+selectedElem).css('height','48px');
		  	
		  	if (selectedOptionText.length>37)
			  {
		  		$('#'+selectedElem).css('height','68px');
			  }		  	
		  }		  
		  else
		  {
			  $('#'+selectedElem).css('height','28px');
		  }
	  }
  }
  
  $(function(){	 	  
	  $('.selectTextWarp').change(function(){		  
		  var changeLoadId = $(this).attr('id');
		  wrapSelectText(changeLoadId);		  
	  });	    
  });
  </script>

<!-- ----------------Accordian  end here---------- -->
</body>
</html>
