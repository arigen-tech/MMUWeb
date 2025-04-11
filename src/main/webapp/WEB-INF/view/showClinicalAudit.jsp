
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>
<jsp:include page="..//view/commonModal.jsp" /> 

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Clinical Audit</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/showTreatmentAudit.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/commonformodal.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/treatmentOpdData.js"></script>
<%@include file="..//view/commonJavaScript.jsp"%>

 <%
						String hospitalId = "1";
						if (session.getAttribute("mmuId") != null) {
							hospitalId = session.getAttribute("mmuId") + "";
						}
						String userId = "1";
						if (session.getAttribute("userId") != null) {
							userId = session.getAttribute("userId") + "";
						}
						String cityId = "1";
						if (session.getAttribute("cityId") != null) {
							cityId = session.getAttribute("cityId") + "";
						}
						
						String userName="";
						if (session.getAttribute("firstName") != null) {
							userName = session.getAttribute("firstName") + "";
						}
						
%>

<script type="text/javascript">

nPageNo=1;
var $j = jQuery.noConflict();

 
</script>
</head>

<body>

<!-- Begin page -->
<div id="wrapper">
	<div class="content-page">
	<!-- Start content -->	
	<div class="container-fluid">
	
		<div class="internal_Htext">Show Prescription Audit Details</div>
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-body">
						<input type="hidden" name="opdPatientDetailId" value=""
										id="opdPatientDetailId" />
									<input type="hidden" id="ageNumber" name="ageNumber" value=""/>
									<input type="hidden" name="patientId" value="" id="patientId" />
									<input type="hidden"  name="marksAsLabValue" value="" id="marksAsLabValue" />
									<input type="hidden"  name="urgentValue" value="" id="urgentValue" />
									
									<input type="hidden"  name="obsitymarkvalue" value="" id="obsitymarkvalue" />
									<input type="hidden"  name="icdIdValue" value="" id="icdIdValue" />
									<input type="hidden"  name="patientSympotnsValue" value="abc" id="patientSympotnsValue" />
									
									<input type="hidden"  name="hospitalId" value=<%=hospitalId%> id="hospitalId" />
									<input type="hidden"  name="userId" value=<%=userId%> id="userId" />
									<input type="hidden"  name="userIdVal" value=<%=userId%> id="userIdVal" />
									<input type="hidden"  name="cityIdVal" value=<%=cityId%> id="cityIdVal" />
									
									<input type="hidden"  name="mmuName" value="<%= session.getAttribute("mmuName") %>" id="mmuName" />
								  <input type="hidden"  name="campName" value="<%= session.getAttribute("campLocation") %>" id="campName" />
									
									<input type="hidden"  name="noOfDaysPro" value="" id="noOfDaysPro" />
									<input type="hidden"  name="freProcedure" value="" id="freProcedure" />
									<input type="hidden"  name="uhidNumberValue" value="" id="uhidNumberValue" />
									<input type="hidden"  name="checkForAuthenticationValue" value="" id="checkForAuthenticationValue" />
									<input type="hidden" name="countValueCurrentMedi" id="countValueCurrentMedi" value=""/>
									<input type="hidden"  name="nisValue" value="" id="nisValue" />
									<input type="hidden"  name="immunizationValue" value="" id="immunizationValue" />
									 <input  name="departmentId" id="departmentId" type="hidden" value="" />
									 <input  name="serviceNo" id="serviceNo" type="hidden" value="" />
									 <input  name="obsistyMark" id="obsistyMark" type="hidden" value="" />
									 <input  name="labImaginId" id="labImaginId" type="hidden" value="" />
									 <input  name="defaultProcedureValue" id="defaultProcedureValue" type="hidden" value="N" />
									 <input  name="obsistyCheckAlready" id="obsistyCheckAlready" type="hidden" value="" />
									 <input  name="wardDepartmentIdTemp" id="wardDepartmentIdTemp" type="hidden" value="" />
									 <input type="hidden" id="usersCounts" name="usersCounts" value=""/>
									 <input type="hidden" name="empCategory" id="empCategory" value=""/>
									  <input type="hidden" name="siqValue" id="siqValue" value=""/>
									 	<input type ="hidden" name="precriptionDtValue" id="precriptionDtValue" value=""/>
									 	<input type="hidden"  name="userName" value='<%=userName%>' id="userName" />
									  	<input type="hidden" name="formFlag" id="formFlag"value="recall"/>
									 	<input type="hidden" name="icdDiagnosisValeText" id="icdDiagnosisValeText" value=""/>
									 	 <input type="hidden" name="registrationTypeCode" id="registrationTypeCode" value=""/>
									 	 <input  name="markAsMlcFlag" id="markAsMlcFlag" type="hidden" value="" />
									 	 <input  name="followUpFlagValRecall" id="followUpFlagValRecall" type="hidden" value="" />
									 	 <input type="hidden" name="patientSymptonsValeText" id="patientSymptonsValeText" value=""/>
									 	 <input type="hidden"  name="markInfectionRecall" value="" id="markInfectionRecallValue" />
									 	 <input type="hidden"  name="markDiseaseRecall" value="" id="markDiseaseRecallValue" />
									 	 <input type="hidden"  name="labImaginId" value="" id="labImaginId" />
									 	 <input type="hidden" name="patientSymAuditId" id="patientSymAuditId" value=""/>
									 	 
						<!-- Patient Detail start -->
						<div class="adviceDivMain" id="button1" onclick="showhide(this.id)">
							<div class="titleBg" style="width: 520px; float: left;">
								<span>Patient Detail  </span>
							</div>
							<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton1" value="-" onclick="showhide(this.id)" type="button">
						</div>
						
					    <div class="hisDivHide p-10" id="newpost1" style="display:block;">
					    
					    	<div class="row">
					    	
					    	<div class="col-md-8">
					    		<div class="row">
					    		<div class="col-md-6">
									<div class="form-group row">
										<label class="col-md-5 col-form-label">Name </label>
										<div class="col-md-7">
											<input name="empname" id="empname" type="text"
												class="form-control border-input" value="" readonly />
										</div>
									</div>
								</div>

								
								<div class="col-md-6">
									<div class="form-group row">
										<label class="col-md-5 col-form-label"> Gender </label>
										<div class="col-md-7">
											<input name="Gender" id="gender" type="text"
												class="form-control border-input" value="" readonly>
										</div>
									</div>
								</div>
								
								<div class="col-md-6">
									<div class="form-group row">
										<label class="col-md-5 col-form-label"> Age </label>
										<div class="col-md-7">
											<input name="Age" id="age" type="text"
												class="form-control border-input" value="" readonly>
										</div>
									</div>
								</div>
						
								<div class="col-md-6">
									<div class="form-group row">
										<label class="col-md-5 col-form-label">Mobile No. </label>
										<div class="col-md-7">
											<input name="Mobile No" id="mobileno" type="text"
												class="form-control border-input" value="" readonly>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group row">
										<label class="col-md-5 col-form-label">Type Of Patient  </label>
										<div class="col-md-7">
											<input name="ptientType" id="ptientType" type="text"
												class="form-control border-input" value="" readonly>
										</div>
									</div>
								</div>
								
										
					    	
					    	</div>
					    	
					    	</div>
					    	
					    	
					    	<div class="col-md-3 offset-md-1">
								<div class="row">
									<div class="col-12">
															
										   <img src="/MMUWeb/resources/images/photo_icon.png" class="opdPrevPic" id="prevPic" alt=""  />
										   
										   <div class="col-sm-12">
										    	<label class="col-form-label">Profile Image<span class="mandate"><sup>&#9733;</sup></span></label>
										    </div>
									</div>
								</div>
							</div>
					    	
					    	</div>
					    	
					    	
					    </div>
					    <!-- Patient Detail End -->
					    
						  <!-- ----- Previous visits & Chief		Complaint start here --------- -->		

    <div class="adviceDivMain" id="button3" onclick="showhide(this.id)">
		<div class="titleBg" style="width: 520px; float: left;">
			<span>Clinical History</span>
		</div>
		<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton3" value="-" onclick="showhide(this.id)" type="button">
	</div>	


      <div class="hisDivHide p-10" id="newpost3"  style="display:block;">
      
      
      <div class="row">
											<div class="col-md-4">
												<div class="arrowlistmenu">
													<ul class="categoryitems">
														<!-- <li><a href="#" class="text-danger">Allergy</a></li> -->
														<li><a href="javascript:void(0)"  onclick="showPreveiousVisit()"> Previous Visits </a></li>
														<!-- <li><a href="#" onclick=" ">Previous
																Hospitalization </a></li> -->
														<li><a href="javascript:void(0)"   onclick="showPreveiousVital()">Previous Vitals</a></li>
														<li><a href="javascript:void(0)" id="prevLabClinicHistory" onclick="showPreveiousLabInvestigation()">Previous Lab
																Investigation </a></li>
														<li><a href="javascript:void(0)" id="prevRadioHistory" onclick="showPreveiousRadioInvestigation()">Previous ECG
																Investigation </a></li>
														
														<!-- <li><a href="#" onclick="showEHRRecords()">EHR</a></li> -->
													
														<!-- <li><a href="#" data-toggle="modal" data-target="#exampleModal" onclick="growthChart()"> Child Growth Chart </a></li> -->
														
														
														
														
													</ul>
												</div>
											</div>

											<div class="col-md-8">

												<div class="opdArea">
													<div id=hospidataId style="display: none">
														<label>Hospital Name</label> <input type="text"
															name="hospName" tabindex="1" size="100" value=""
															maxlength="150" /> <input type="text" name="hospName"
															tabindex="1" size="100" value="" maxlength="150" /> <label
															class="auto">DOA</label> <input type="text" name="doa"
															class="date" id="doa" MAXLENGTH="30"
															validate="Pick a from date,date,no" value=""
															readonly="readonly"
															onblur="checkDate1(this.value,this.id)" /> <input
															type="text" name="doa" class="date" id="doa"
															MAXLENGTH="30" validate="Pick a from date,date,no"
															value="" readonly="readonly"
															onblur="checkDate1(this.value,this.id)" /> <img
															src="${pageContext.request.contextPath}/resources/images/cal.gif"
															width="16" height="16" border="0"
															onclick="javascript:setdate('doa',document.opdMain.doa, event)"
															validate="Pick a date" /> <label class="auto">DOD</label>
														<input type="text" name="dod" value="" class="date"
															id="dod" MAXLENGTH="30"
															validate="Pick a from date,date,no" readonly="readonly" />
														<input type="text" name="dod" value="" class="date"
															id="dod" MAXLENGTH="30"
															validate="Pick a from date,date,no" readonly="readonly"
															onblur="checkDate1(this.value,this.id)" /> <img
															src="${pageContext.request.contextPath}/resources/images/cal.gif"
															width="16" height="16" border="0"
															onclick="javascript:setdate('dod',document.opdMain.dod, event)"
															validate="Pick a date"
															onblur="checkDate1(this.value,this.id)" />
														<div class="clear"></div>
														<label>Diagnosis</label> <input type="text" class="auto"
															size="48" id="pastDiagnosis" tabindex="1" value=""
															name="pastDiagnosis" maxlength="100" />
														<div class="clear"></div>
														<label>Advise on Discharge</label>

														<textarea name="adviceOnDischarge" cols="0" rows="0"
															maxlength="300" value="" tabindex="1"
															></textarea>

														<textarea name="adviceOnDischarge" cols="0" rows="0"
															maxlength="300" value="" tabindex="1"
															></textarea>

													</div>
													<!-- CLinical Information start -->
						
					   <div class="hisDivHide p-10" id="newpost2" style="display:block;">
					    	<div class="row">
					    		<div class="col-md-6">
									<div class="form-group row">
										<label class="col-md-4 col-form-label">Patient Signs and Symptoms </label>
										<div class="col-md-8">
										<div name="patientSympotnsIdDiv" id="patientSympotnsIdDiv"></div>
											<!-- <select name="patientSympotnsId" multiple="2" value="" size="5"
													tabindex="1" id="patientSympotnsId" class="listBig width-full disablecopypaste"
													validate="ICD Daignosis,string,yes">
												</select> -->
										</div>
									</div>
								</div>
								
								<div class="col-md-6">
									<div class="form-group row">
										<label class="col-md-4 col-form-label">Clinical Examination</label>
										<div class="col-md-8">
											<textarea class="form-control" id="pastMedicalHistory" name="pastMedicalHistory" rows="3"></textarea>
										</div>
									</div>
								</div>
					    	
					    	</div>
					    </div>
					    <!-- CLinical Information End -->

												

													</div>

												</div>
											</div>

      
      
			
	</div>


<!-- ----- Previous visits & Chief	Complaint end here --------- -->	
					    
					    
					    <!-- Vital Detail start -->
						<div class="adviceDivMain" id="button4" onclick="showhide(this.id)">
							<div class="titleBg" style="width: 520px; float: left;">
								<span>Vital Detail  </span>
							</div>
							<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton4" value="+" onclick="showhide(this.id)" type="button">
						</div>
						
					    <div class="hisDivHide p-10" id="newpost4">
					    	<div class="row">

									<div class="col-md-4">
										<div class="form-group row">
											<label class="col-md-4 col-form-label">Height</label>
											<!-- <div class="col-md-7">
												<input name="height" id="height" type="text" maxlength="10"
													class="form-control border-input" onblur="idealWeight();checkBMI();" placeholder="Height"
													value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" />
											</div> -->
											<div class="col-md-8">
												<div class="input-group mb-2 mr-sm-2">
													<input name="height" id="height" type="text" maxlength="10"
													class="form-control border-input disablecopypaste" onblur="idealWeight();checkBMI();"  placeholder="Height"
													value="" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" />
												    <div class="input-group-append">
												      <div class="input-group-text">cm</div>
												    </div>
												    
												  </div>
											</div>
										</div>
									</div>
									<!-- <div class="col-md-4">
										<div class="form-group row">
											<label class="col-md-5 col-form-label">Ideal Weight
											</label>
											
											<div class="col-md-7">
												<div class="input-group mb-2 mr-sm-2">
													<input name="ideal_weight" id="ideal_weight" maxlength="10" onblur="checkVaration()" type="text"
													class="form-control border-input disablecopypaste"
													placeholder="Ideal Weight" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" />
												    <div class="input-group-append">
												      <div class="input-group-text">kg</div>
												    </div>
												    
												  </div>
											</div>
										</div>
									</div> -->

									<div class="col-md-4">
										<div class="form-group row">
											<label class="col-md-5 col-form-label">Weight</label>
											<!-- <div class="col-md-7">
												<input name="Weight" id="weight" type="text"
													class="form-control border-input" maxlength="10" onblur="checkVaration();checkBMI();" placeholder="Weight" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" />
											</div> -->
											<div class="col-md-7">
												<div class="input-group mb-2 mr-sm-2">
													<input name="Weight" id="weight" type="text"
													class="form-control border-input disablecopypaste" maxlength="10" onblur="checkVaration();checkBMI();" placeholder="Weight" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" />
												    <div class="input-group-append">
												      <div class="input-group-text">kg</div>
												    </div>
												    
												  </div>
											</div>
										</div>
									</div>

									<!-- <div class="col-md-4">
										<div class="form-group row">
											<label class="col-md-5 col-form-label">Variation in
												Weight</label>
										
											<div class="col-md-7">
												<div class="input-group mb-2 mr-sm-2">
													<input name="variant_in_weight" maxlength="10" id="variant_in_weight"
													type="text" class="form-control border-input disablecopypaste"
													placeholder="Variation in Weight" value=""  readonly />
												    <div class="input-group-append">
												      <div class="input-group-text">%</div>
												    </div>
												    
												  </div>
											</div>
										</div>
									</div> -->

									<div class="col-md-4">
										<div class="form-group row">
											<label class="col-md-5 col-form-label">Temperature</label>
											<!-- <div class="col-md-7">
												<input name="tempature" id="tempature" type="text" maxlength="12"
													class="form-control border-input"
													placeholder="Temperature" value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" />
											</div> -->
											<div class="col-md-7">
												<div class="input-group mb-2 mr-sm-2">
													<input name="tempature" id="tempature" type="text" maxlength="12"
													class="form-control border-input disablecopypaste"
													placeholder="Temperature" value="" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" />
												    <div class="input-group-append">
												      <div class="input-group-text">°F</div>
												    </div>
												    
												  </div>
											</div>
										</div>
									</div>
								<div class="col-md-4">
										<div class="form-group row">
											<label class="col-md-3 col-form-label">BP</label>
											<!-- <div class="col-md-3">
												<input name="bp" id="bp" type="text"
													class="form-control border-input" placeholder="Systolic"
													value="" onkeypress="if (isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"/>
												 
											</div>
											
											
											<div class="col-md-1">
												/
												 
											</div>
											
											<div class="col-md-3">
												<input name="bp1" id="bp1" type="text"
													class="form-control border-input" placeholder="Diastolic"
													value="" onkeypress="if (isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"/>
												 
											</div> -->
											<div class="col-md-3 offset-md-1">
												
													<input name="bp" id="bp" type="text"
													class="form-control border-input bpSlash disablecopypaste" placeholder="Systolic"
													value="" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"/>
													<span></span> <!-- slash for bp -->
												  
											</div>
											<div class="col-md-5">
												<div class="input-group mb-2 mr-sm-2">
													<input name="bp1" id="bp1" type="text"
													class="form-control border-input bmiInput disablecopypaste" placeholder="Diastolic"
													value="" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"/>
												    <div class="input-group-append">
												      <div class="input-group-text">mmHg</div>
												    </div>
												  </div>
											</div>
											
											
										</div>
									</div>

									<div class="col-md-4">
										<div class="form-group row">
											<label class="col-md-5 col-form-label">Pulse</label>
											<!-- <div class="col-md-7">
												<input name="pulse" id="pulse" type="text" maxlength="10"
													class="form-control border-input" placeholder="Pulse"
													value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" />
											</div> -->
											<div class="col-md-7">
												<div class="input-group mb-2 mr-sm-2">
													<input name="pulse" id="pulse" type="text" maxlength="10"
													class="form-control border-input disablecopypaste" placeholder="Pulse"
													value="" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" />
												    <div class="input-group-append">
												      <div class="input-group-text">/min</div>
												    </div>
												    
												  </div>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<label class="col-md-5 col-form-label">SpO2</label>
											<!-- <div class="col-md-7">
												<input name="spo2" id="spo2" type="text" maxlength="25"
													class="form-control border-input" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" placeholder="SpO2"
													value=""/>
											</div> -->
											<div class="col-md-7">
												<div class="input-group mb-2 mr-sm-2">
													<input name="spo2" id="spo2" type="text" maxlength="25"
													class="form-control border-input disablecopypaste" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" placeholder="SpO2"
													value=""/>
												    <div class="input-group-append">
												      <div class="input-group-text">%</div>
												    </div>
												    
												  </div>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<label class="col-md-4 col-form-label">BMI</label>
											<!-- <div class="col-md-7">
												<input name="bmi" id="bmi" type="text" 
													class="form-control border-input" placeholder="BMI"
													value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" readonly>
											</div> -->
											<div class="col-md-8">
												<div class="input-group mb-2 mr-sm-2">
													<input name="bmi" id="bmi" type="text" 
													class="form-control border-input disablecopypaste" placeholder="BMI"
													value="" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" readonly>
												    <div class="input-group-append">
												      <div class="input-group-text">kg/m2</div>
												    </div>
												    
												  </div>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<label class="col-md-5 col-form-label">RR</label>
											<!-- <div class="col-md-7">
												<input name="rr" id="rr" type="text" maxlength="3"
													class="form-control border-input" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" placeholder="RR"
													value=""/>
											</div> -->
											<div class="col-md-7">
												<div class="input-group mb-2 mr-sm-2">
													<input name="rr" id="rr" type="text" maxlength="3"
													class="form-control border-input disablecopypaste" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" placeholder="RR"
													value=""/>
												    <div class="input-group-append">
												      <div class="input-group-text">/min</div>
												    </div>
												    
												  </div>
											</div>
										</div>
									</div>
									
											 <div class="col-md-4" id="markMLCId">
												<div class="form-group row">														
													<div class="col-md-9 makeDisabled mn-t-10">
														<div class="form-check form-check-inline cusCheck m-t-7">
																<input class="form-check-input" type="checkbox" id="markMLC" name="markMLC" onclick="marksAsMLCRecall()"  value="">
															<span class="cus-checkbtn"></span>
															<div class="form-check form-check-inline cusRadio">
																	<label class="col-md-12 col-form-label">Mark as MLC Case</label> 
															</div>
														</div>									
													</div>
												</div>
											</div>
								<div id="markMLCSection" style="display:none">
					      		<div  class="row noRow" >
					      		<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-4">
											<label class="col-form-label">Date</label>
										</div>
										<div class="col-md-8">
											<div class="dateHolder">
												<input type="text" name="" id="mlcDate" class="calDate form-control" placeholder="DD/MM/YYYY" readonly>
											</div>
										</div>
									</div>
								</div>
								
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Place</label>
										</div>
										<div class="col-md-7">
											<input type="text" name="" id="mlcPlace" class="form-control" readonly>
										</div>
									</div>
								</div> 
								<div class="w-100"></div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-4">
											<label class="col-form-label">Police Station</label>
										</div>
										<div class="col-md-8">
											<textarea class="form-control" id="mlcPloiceStation" name="mlcPloiceStation" rows="2"></textarea>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Treated As</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" id="mlcTreatedAs" name="mlcTreatedAs" rows="2"></textarea>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Name of Institution</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" id="mlcNameOfInstatuition" rows="2" readonly="readonly"></textarea>
										</div>
									</div>
								</div>
								
								<div class="w-100"></div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Name Of Policeman</label>
										</div>
										<div class="col-md-8">
											<textarea class="form-control" id="mlcPloiceName" name="mlcPloiceName" rows="2"  maxlength="100"></textarea>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Designation</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" id="mlcDesignation" name="mlcDesignation" rows="2"  maxlength="100"></textarea>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">ID Number</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" id="mlcIdNumber" name="mlcIdNumber" rows="2" maxlength="100"></textarea>
										</div>
									</div>
								</div> 
								</div>
					      	</div>
									
									<!-- mark as mlc fields -->
									
									<div class="col-md-4" style="display:none;">
										<div class="form-group row">
											<input type="hidden" id="visitId" name="VisitID" value="">
										</div>
									</div>
									<div class="col-md-4" style="display:none;">
										<div class="form-group row">
											<input type="hidden" id="genderId" name="genderId" value="">
										</div>
									</div>
									
							</div>
				    </div>
				    <!-- Vital Detail End -->
					    
				    <!-- ----- Mlc  start here --------- -->
					<!-- <div style="display:none">	
					 <div class="adviceDivMain" id="button4" onclick="showhide(this.id)">
						<div class="titleBg" style="width: 520px; float: left;">
							<span> MLC Case </span>
					     </div>		
						<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton4" value="-" onclick="showhide(this.id)" type="button">
					</div>	
				
				    <div class="hisDivHide p-10" id="newpost4"  >
				      	<div class="row">
				      	
				      		<div class="col-md-4">
								<div class="form-group row">
									<div class="col-md-5">
										<label class="col-form-label">Date</label>
									</div>
									<div class="col-md-7">
										<div class="dateHolder">
											<input type="text" name="" id="" class="calDate form-control" placeholder="DD/MM/YYYY" >
										</div>
									</div>
								</div>
							</div>
							
							<div class="col-md-4">
								<div class="form-group row">
									<div class="col-md-5">
										<label class="col-form-label">Place</label>
									</div>
									<div class="col-md-7">
										<input type="text" name="" id="" class="form-control">
									</div>
								</div>
							</div> 
							<div class="w-100"></div>
							<div class="col-md-4">
								<div class="form-group row">
									<div class="col-md-5">
										<label class="col-form-label">Police Station</label>
									</div>
									<div class="col-md-7">
										<textarea class="form-control" rows="2"></textarea>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group row">
									<div class="col-md-5">
										<label class="col-form-label">Treated As</label>
									</div>
									<div class="col-md-7">
										<textarea class="form-control" rows="2"></textarea>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group row">
									<div class="col-md-5">
										<label class="col-form-label">Name of Institution</label>
									</div>
									<div class="col-md-7">
										<textarea class="form-control" rows="2"></textarea>
									</div>
								</div>
							</div>
							 
							
				      	</div>
					</div>
				</div> -->
				<!-- -----Mlc   end here --------- -->
					
					    
				    <!-- Diagnosis start -->
					<div class="adviceDivMain" id="button5" onclick="showhide(this.id)">
						<div class="titleBg" style="width: 520px; float: left;">
							<span>Diagnosis </span>
						</div>
						<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton5" value="-" onclick="showhide(this.id)" type="button">
					</div>
					
				    <div class="hisDivHide p-10" id="newpost5" style="display:block;">
				    	<div class="row">
				    		<div class="col-12">
							    <div class="table-responsive">
							    <h6><a class="text-theme font-weight-bold text-underline" onClick="showAllAuditRecommendedDiagnosis('ALL','SearchStatusForUnitAdminCurrentMedication');"href="javascript:void(0)">Show Recommended Diagnosis</a></h6> 
                                <input type="hidden" name="countValueRecommendedDiagnosis" id="countValueRecommendedDiagnosis" value=""/>
							      		
						      		<table class="table table-bordered" border="0" cellpadding="0" cellspacing="0">
										<thead>
											<tr>
												<th>Diagnosis</th>
												<th class="text-center">Mark as Communicable Disease</th>
												<th class="text-center">Mark as Infectious Disease</th> 
												<th>Action</th>
												<th>Recommended Diagnosis</th>
												<th>Remarks</th> 
											</tr>
										</thead>
	
										<tbody id="diagnosisGridRecall">
											<tr>
												<td class="">
													<input type="text" name="" id="" class="form-control width160">
												</td>
												<td class="text-center">
													<div class="form-check form-check-inline cusCheck m-t-7">
															<input class="form-check-input" type="checkbox">
														<span class="cus-checkbtn"></span>
													</div>
												</td>
												<td class="text-center width110">
													<div class="form-check form-check-inline cusCheck m-t-7">
															<input class="form-check-input" type="checkbox">
														<span class="cus-checkbtn"></span>
													</div>
												</td>
												<td class="">
													<select class="form-control width160">
														<option>Select</option>
														<option value="A">Approved</option>
														<option value="P">Pending</option>
													</select>
												</td>
												<td class="">
													<div class="width400 clearfix">
														<div class="autocomplete forTableResp pull-left width180">
																<input name="icddiagnosis" id="icd" type="text"
																class="form-control border-input disablecopypaste  m-b-5"
																placeholder=" " value=""  onKeyUp="getNomenClatureList(this,'fillDiagnosisCombo','opd','getIcdListByName','dignosis');"  />
																<div class="autocomplete-itemsNew" id="icdDiagnosisUpdatea" ></div>
														</div>
														<select name="diagnosisId" multiple="4" value="" size="5"
															tabindex="1" id="diagnosisId" class="listBig disablecopypaste width200 pull-right"
															validate="ICD Daignosis,string,yes">
														</select>
														<button type="button" class="buttonDel btn  btn-danger m-l-20" value="" onclick="deleteDgItems();" /> Delete </button>
													</div>
												</td>
												<td class="">
													<textarea class="form-control width200" rows="2"></textarea>
												</td>
											</tr>
										</tbody>
						      		</table>
					      		</div>
					      	</div>	
				    	
				    	</div>
				    </div>
				    <!-- Diagnosis End -->
				    
				    
				    <!-- Investigation start -->
					<div class="adviceDivMain" id="button6" onclick="showhide(this.id)">
						<div class="titleBg" style="width: 520px; float: left;">
							<span>Investigation </span>
						</div>
						<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton6" value="-" onclick="showhide(this.id)" type="button">
					</div>
					
				    <div class="hisDivHide p-10" id="newpost6" style="display:block;">
				    	<div class="row">
				    		<div class="col-12">
							    <div class="table-responsive">
							     <h6><a class="text-theme font-weight-bold text-underline" onClick="showAllAuditRecommendedInvestigation('ALL','SearchStatusForUnitAdminCurrentMedication');"href="javascript:void(0)">Show Recommended Investigation</a></h6> 
                                 <input type="hidden" name="countValueRecommendedInvestigation" id="countValueRecommendedInvestigation" value=""/>
								<table class="table table-bordered" border="0" cellpadding="0" cellspacing="0">
										<thead>
											<tr>
												<th>Investigation</th>
												<th>Action</th>
												<th>Recommended Investigation</th>
												<th>Remarks</th> 
											</tr>
										</thead>
	
										<tbody id="dgInvetigationGrid">
											<tr>
												<td class="">
													<input type="text" name="" id="" class="form-control width160">
												</td>
												<td class="">
													<select class="form-control width160">
														<option>Select</option>
													</select>
												</td>
												<td class="">
													<div class="width400 clearfix">
														<div class="autocomplete forTableResp pull-left width180">
																<input name="icdInvestigation" id="investigation" type="text"
																class="form-control border-input disablecopypaste  m-b-5"
																placeholder=" " value=""  onKeyUp="getNomenClatureList(this,'populateChargeCode','opd','getIinvestigationList','investigation');"  />
																<div class="autocomplete-itemsNew" id="icdInvestigationUpdatea" ></div>
														</div>
														<select name="investigationIdSelect" multiple="4" value="" size="5"
															tabindex="1" id="investigationIdSelect" class="listBig disablecopypaste width200 pull-right"
															validate="ICD Daignosis,string,yes">
														</select>
														<button type="button" class="buttonDel btn  btn-danger m-l-20" value="" onclick="deleteDgItems();" /> Delete </button>
													</div>
												</td>
												<td class="">
													<textarea class="form-control width200" rows="2"></textarea>
												</td>
											</tr>
										</tbody>
						      		</table>
					      		</div>
					      	</div>	
					      	<div class="row">		
											<div class="col-12">
												<h6 class="text-theme text-underline font-weight-bold">ECG File Upload</h6>
											</div>

											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Upload File</label>
													<div class="col-md-7" id="ecgFileUpload">
														<!-- <div class="fileUploadDiv">
															<input type="file" name="ecgFileUploadVal"
															id="ecgFileUploadVal" class="inputUpload" />
															<label class="inputUploadlabel">Choose File</label>
															<span class="inputUploadFileName">No File Chosen</span>
														</div> -->
														<div class="fileUploadDiv">
														  	<input type="file" class="inputUpload" name="ecgFileUploadVal" id="ecgFileUploadVal">
														  	<label class="inputUploadlabel">Choose File</label>
															<span id="spanInputUploadFileName" class="inputUploadFileName">No File Chosen</span>
													  	</div>
													</div>
													
												</div>
												
											</div>
											<div class="col-md-1">
													<div id="viewEcgDocs" >
															<input name="viewEcgDocumentId" type="button"
																value="View ECG" tabindex="1" class="btn btn-primary "
																onclick="viewEcgDocumnt();" />
														</div>
												</div>
											<div class="col-md-4">
												<div class="form-group row">
														<label class="col-md-5 col-form-label text-right">ECG Result</label>
														<div class="col-md-7">
														<textarea name="ecgRemarks" id="ecgRemarks" cols="50" rows="0"
														maxlength="500" tabindex="1"
														onkeyup="return ismaxlength(this)" class="form-control"></textarea>
														</div>
												</div>
											</div>
											</div>
					     
				    	</div>
				    </div>
				    <!-- Investigation End -->
				    
				     <!-- Treatment start -->
					<div class="adviceDivMain" id="button7" onclick="showhide(this.id)">
						<div class="titleBg" style="width: 520px; float: left;">
							<span>Treatment </span>
						</div>
						<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton7" value="-" onclick="showhide(this.id)" type="button">
					</div>
					
				    <div class="hisDivHide p-10" id="newpost7" style="display:block;">
				    	<div class="row">
				    		<div class="col-12">
							    <div class="table-responsive">
							   <h6><a class="text-theme font-weight-bold text-underline" onClick="showAllAuditRecommendedTreatment('ALL','SearchStatusForUnitAdminCurrentMedication');"href="javascript:void(0)">Show Recommended Treatment</a></h6> 
                               <input type="hidden" name="countValueRecommendedTreatment" id="countValueRecommendedTreatment" value=""/>
								<table class="table table-bordered" border="0" cellpadding="0" cellspacing="0">
										<thead>
											<tr>
												<th>Drug Name</th>
												<th>Disp Unit</th>
												<!-- <th>Dosage</th>
												<th>Frequency</th>
												<th>Days</th>
												<th>Total</th>
												<th>Instruction</th> -->
												<th>Action</th>
												<th>Recommended Treatment</th>
												<th>Remarks</th> 
											</tr>
										</thead>
	
										<tbody id="nomenclatureGrid">
													<tr>

														<td>
															<div class="autocomplete forTableResp">
														
																<input type="text" autocomplete="never" value="" tabindex="1"
																	id="nomenclature1" size="77" name="nomenclature1"
																	class="form-control border-input width330" onKeyUp="getNomenClatureList(this,'populatePVMSTreatment','opd','getMasStoreItemList','numenclature');"/>
																	
																<input type="hidden" name="itemId" value=""
																	id="nomenclatureId" /> <input type="hidden"
																	name="prescriptionHdId" value="" id="prescriptionHdId" />
																<input type="hidden" name="prescriptionDtId" value=""
																	id="precriptionDtId" />
															<input type="hidden" name="statusOfPvsms" id="statusOfPvsms" value=""/>
																	<div id="nomenclatureIdPvs" class="autocomplete-itemsNew"></div>
															</div>
														</td>

													

															<td>
                                                    <select name="dispensingUnit1" id="dispensingUnit1" class="medium form-control width100" ></select>
                                                    </td>				
												<td class="">
													<select class="form-control width160">
														<option value="na">Select</option>
														<option value="approved">Approved</option>
														<option value="pending">Pending</option>
													</select>
												</td>
												<td class="">
													<div class="width400 clearfix">														
														<div class="autocomplete forTableResp pull-left width180">
																<input name="icdTreatment" id="treatment" type="text"
																class="form-control border-input disablecopypaste  m-b-5"
																placeholder=" " value=""  onKeyUp="getNomenClatureList(this,'fillDiagnosisCombo','opd','getIcdListByName','dignosis');"  />
																<div class="autocomplete-itemsNew" id="icdTreatmentUpdatea" ></div>
														</div>
														<select name="treatmentIdSelect" multiple="4" value="" size="5"
															tabindex="1" id="treatmentIdSelect" class="listBig disablecopypaste width200 pull-right"
															validate="ICD Daignosis,string,yes">
														</select>
														<button type="button" class="buttonDel btn  btn-danger pull-left" value="" onclick="deleteDgItems();" > Delete </button>
													</div>
												</td>
												<td class="">
													<textarea class="form-control width200" rows="2"></textarea>
												</td>
											</tr>
										</tbody>
						      		</table>
					      		</div>
					      	</div>	
					      
				    	</div>
				    </div>
				    <!-- Investigation End -->
				    
				    
				    <!-- Minor Procedure start -->
					<div class="adviceDivMain" id="button8" onclick="showhide(this.id)">
						<div class="titleBg" style="width: 520px; float: left;">
							<span>Minor Procedure  </span>
						</div>
						<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton8" value="+" onclick="showhide(this.id)" type="button">
					</div>
					
				    <div class="hisDivHide p-10" id="newpost8" >
				    	<div class="row">
				    		<div class="col-12"> 

								<div class="row m-b-10">


									<div class="col-md-3">
										<div class="form-group">
											<!-- <div class="col-md-1">
												<input class="m-t-5" value="N" type="radio"
													checked="checked" name="procedureRadioName"
													id="procedureRadio"
													onchange="changeProcedureRadio(this.value)">
											</div>
											<label class="col-md-5 col-form-label">Nursing
												Care</label> -->
								

										</div>
									</div>

									<!-- <div class="col-md-3 text-right">
									<input type="button" id="createPrcocedure" value="Create Procedure" tabindex="1" class="btn btn-primary" data-toggle="modal" data-target="#smallModal" onclick="createProcedureMaster();">
									</div> -->

								</div>

								<div id="divTemplet">

									<table class="table table-bordered" align="center"
										cellpadding="0" cellspacing="0">
										<tr>
											<th>Name</th>
											<th>Remarks</th>
										
											<!-- <th>Alert Me</th> -->
										</tr>
										<tbody id="gridNursing">
											<tr>
												<td class="width300">
													<div class=" autocomplete forTableResp">
															<input type="text" autocomplete="never" class="form-control disablecopypaste "
															value="" id="procedureNameNursing" size="42"
															name="procedureNameNursing" onKeyUp="getNomenClatureList(this,'populateNursing','opd','getMasNursingCare','procedureNursing');" />
													<div id="procedureNursing" class="autocomplete-itemsNew"></div>
													</div>
												</td>
											
												<td><textarea name="remark_nursing" id="remark_nursing"  rows="1"
										        	maxlength="500"  tabindex="5" class="form-control" maxlength="100"></textarea>
										        </td>
												<td style="display: none;"><input type="hidden"
													value="" id="procedureNameNursingId"
													name="procedureNameNursingId" /></td>
												<td style="display: none;"><input type="hidden"
													class="form-control border-input" value=""
													id="procedureNameNursing" size="55"
													name="procedureNameNursing" />
												<td style="display: none;"><input type="hidden"
													class="form-control border-input" value=""
													id="procedureNameNursingCare" size="55"
													name="procedureNameNursingCare" /></td>
												
												<td style="display: none;"><input type="hidden"
													id="procedureHeaderId" name="procedureHeaderId" value="" />
												</td>
												<td style="display: none;"><input type="hidden"
													name="nursinghdb" value="" id="nursinghdb" /></td>
											</tr>
										</tbody>
									</table>
									<!-- <label>Additional Advice</label>
									<textarea name="additionalNote"
										validate="referralNote,string,no" id="additionalNote"
										cols="0" rows="0" maxlength="500" tabindex="5"
										onkeyup="return checkLength(this)" style="width: 477px;"></textarea> -->
                                               
                                             	 <div class="clearfix"></div>
								 <br>
								</div> 
 							</div>
				    	
				    	</div>
				    </div>
				    <!-- Minor Procedure End -->
				    
				    
				    
				    <!-- Referral start -->
					<div class="adviceDivMain" id="button9" onclick="showhide(this.id)">
						<div class="titleBg" style="width: 520px; float: left;">
							<span>Referral</span>
						</div>
						<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton9" value="+" onclick="showhide(this.id)" type="button">
					</div>
					
				    <div class="hisDivHide p-10" id="newpost9" >
				    	<div id="referalDiv">
												
						<div class="row">
							<div class="col-md-4">
								<div class="form-group row ">

									<label class="col-md-4 col-form-label">Referral</label>

									<div class="col-md-8">
										<select id="referral" name="referral" class="midium form-control">
											<option  id="option1" value="0">No</option>
										    <option id="option2" value="1">Yes</option>
										</select>


									</div>

								</div>

							</div>


						</div>

						<!-- <label>Referral </label>
					 <select  style=" width: 10%;" id="referral" name="referral" class="midium">
						<option value="0">No</option>
						<option value="1">Yes</option>
					</select>
                                           <br><br><br> -->
						<!-- <div id="referDiv" class="col collaps"
							style="display: block;">
							<label>Refer To</label> <label class="autoSpace">
								<input type="radio" class="radioCheckCol2" name="referTo"
								id="referExternal" value="E"
								onclick="checkReferTO('referExternal');"
								style="margin: 1px 5px 0px 0px;" checked="checked">External
							</label> <label class="autoSpace"> <input type="radio"
								class="radioCheckCol2" name="referTo" id="referInternal"
								value="I" onclick="checkReferTO('referInternal');"
								style="margin: 1px 5px 0px 0px;">Internal
							</label> -->





                           <div id="referDiv" style="display: block;">
							
							<div class="row" >
					           
					           <div class="col-md-6 m-t-5" style="display:none">
								<label>Refer To</label> 
								<label class="autoSpace">
								
									<input type="radio" class="radioCheckCol2" name="referTo"
									id="referExternal" value="E" onchange="getEmpanelled()"
									onclick="checkReferTO('referExternal');"
									style="margin: 1px 5px 0px 85px;" checked="checked">External(Other Than ICG)
								</label> 
								
								<label class="autoSpace"> 
									<input type="radio"
									class="radioCheckCol2" onchange="getInternalRefferal()" name="referTo" id="referInternal"
									value="I" onclick="checkReferTO('referInternal');"
									style="margin: 1px 5px 0px 32px;">Internal
								</label>

								</div> 
							



							<!-- <label>Referral Date: </label> <input type="Date"
								name="referVisitDate" id="referVisitDate"
								placeholder="DD/MM/YYYY" value=""> -->
								
													
						</div>
								
								
							<!-- onblur="checkAdmte()" -->
							<!-- <label id="priorityLabelId" style="display: block;">Current Proirity No.</label>
						 <select id="priorityId" name="priorityName" tabindex="1" style="display: block;">
							<option value="3">3</option>
							<option value="2">2</option>
							<option value="1">1</option>
						</select> -->
							<!-- <div class="clear"></div> -->
							<div id="referDepartmentDiv" style="display: block;">
								<table id="referalGridNew" class="table table-bordered">
									<thead>
										<tr>
											<th>S.No.</th>
											<th>Hospital</th>
											<th>Department</th>
											
										</tr>
									</thead>
									<tbody id="referalGrid">

									</tbody>
								</table>

								<input type="hidden" value="1" name="hiddenValueRefer"
									id="hiddenValueRefer">
							</div>
							<label id="referhospitalLabel" style="display: none;">Hospital
								<span>*</span>
							</label> <select id="referhospital" name="referhospital"
								onchange="fnGetHospitalDepartment(this.value);"
								style="display: none;" validate="">
								<option value="0">Select</option>

								<option value=""></option>

							</select> <label id="referdayslLabel" style="display: none;">No.
								of Days</label> <input id="referdays" name="referdays"
								type="text" maxlength="2" style="display: none;">

							<label style="display: none">Patient Advise</label>
							<textarea name="patientAdvise"
								validate="patientAdvise,string,no" id="patientAdvise"
								cols="0" rows="0" maxlength="500" tabindex="5"
								style="display: none"></textarea>
							<!-- <input type="button" class="buttonAuto-buttn" value="+"
			onclick="" /> -->
							<label id="referral_treatment_type_label"
								style="display: none">Treatment Type <span>*</span></label>
							<select id="referral_treatment_type"
								name="referral_treatment_type" style="display: none">
								<option value="1" selected="true">OPD</option>
								<option value="2">Admission</option>
							</select> <label id="referredForLabel" style="display: none">Referred
								For<span>*</span>
							</label> <input id="referredFor" name="referredFor" type="text"
								maxlength="300" validate="" style="display: none">
							
							
							<div class="row">
					 <div class="col-md-6">
						<div class="form-group row">
							<label class="col-md-4 col-form-label" style="  padding-left: 10px;"> Referral Notes</label>
							<div class="col-md-7">
								 <textarea name="referralNote" class="form-control" validate="referralNote,string,no" id="referralNote" cols="0" rows="0" maxlength="500" tabindex="5" ></textarea> 
							</div>
						</div>
					</div>
					
					<div class="col-md-6">													 
					</div>
				</div>  
							
						<div class="row">
					 <div class="col-md-6">
						<div class="form-group row">
							<label class="col-md-4 col-form-label" style="  padding-left: 10px;">Others</label>
							<div class="col-md-7">
								 <textarea name="doctorRemarks" class="form-control" validate="doctorRemarks,string,no" id="doctorRemarks" cols="0" rows="0" maxlength="500" tabindex="5" ></textarea> 
							</div>
						</div>
					</div>
					
					<div class="col-md-6">													 
					</div>
				</div>  
							<!-- <input type="button" class="buttonAuto-buttn" value="+"
			onclick="" /> -->
						</div>

					</div>

							<div class="clearfix"></div>
				    </div>
				    <!-- Referral End -->
				    <!-- -----Follow Up   start here --------- -->
  <div  id="followUp" >
	 <div class="adviceDivMain" id="button12" onclick="showhide(this.id)">
		<div class="titleBg"style="width: 520px; float: left;">
			<span>  Follow Up </span>
	   </div>
		<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton12" value="+" onclick="showhide(this.id)" type="button">
	</div>	


      <div class="hisDivHide p-10" id="newpost12">
      
      
      <div class="row">
      
      <div class="col-md-3 ">
													<div class="form-check form-check-inline cusCheck m-l-10">
														<input class="form-check-input" type="checkbox" id="followUpChecked" name="followUpChecked" onClick="followUpFlagRecall(this)" value="Y">
														
													<span class="cus-checkbtn"></span>
													<div class="form-check form-check-inline cusRadio">
															<label class="col-md-12 col-form-label">Follow Up</label> 
													</div>
													</div>
												</div>
												
								<div class="col-md-4">
								<div class="form-group row">
									<label class="col-md-5 col-form-label">Number of Days</label>
									<div class="col-md-7">
										<select id="noOfDays" name="noOfDaysFollowUp" class="form-control" onchange="nextFolloUpDateRecall(this.value)" >
											<option value="">Select</option>
											<option value="1">After 1 Day</option>
											<option value="2">After 2 Day</option>
											<option value="3">After 3 Day</option>
											<option value="4">After 4 Day</option>
											<option value="5">After 5 Day</option>
											<option value="6">After 6 Day</option>
											<option value="7">After 7 Day</option>
											<option value="8">After 8 Day</option>
											<option value="9">After 9 Day</option>
											<option value="10">After 10 Day</option>
											<option value="11">After 11 Day</option>
											<option value="12">After 12 Day</option>
											<option value="13">After 13 Day</option>
											<option value="14">After 14 Day</option>
											<option value="15">After 15 Day</option>
											<option value="16">Review SOS</option>
											<option value="17">Others</option>											
											</select>
									</div>
								</div>
							</div>
							
							<div class="col-md-5">
								<div class="form-group row">
									<label class="col-md-4 col-form-label">Next Date</label>
									<div class="col-md-7">
										<div class="dateHolder">
											<input type="text" class="form-control noBack_date2" id="nextFollowUpDate" name="nextFollowUpDate" placeholder="DD/MM/YYYY" />
										</div>					
									</div>	
								</div>
							</div>
							
							
													
	 </div>
													
													
												
	</div>
	</div>
	
	<!-- ----- Follow Up  end here --------- -->
				    
				    <!-- Doctor Remark start -->
					<div class="adviceDivMain" id="button10" onclick="showhide(this.id)">
						<div class="titleBg" style="width: 520px; float: left;">
							<span>Doctor Remark</span>
						</div>
						<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton10" value="+" onclick="showhide(this.id)" type="button">
					</div>
					
				    <div class="hisDivHide p-10" id="newpost10">
				    	<div class="row">
				    		 <div class="col-md-6">
								<div class="form-group row">
									<label class="col-md-4 col-form-label" style="  padding-left: 10px;">Doctor's Remark</label>
									<div class="col-md-7">
										 <textarea name="additionalNote"   class="form-control"
											validate="referralNote,string,no" id="additionalNote" rows="3" maxlength="500"></textarea>
									</div>
								</div>
							</div>
				    	
				    	</div>
				    </div>
				    <!-- Doctor Remark End -->
				    
				    
				    
				     <!-- Auditor Feedback start -->
					<div class="adviceDivMain" id="button11" onclick="showhide(this.id)">
						<div class="titleBg" style="width: 520px; float: left;">
							<span>Auditor Feedback  </span>
						</div>
						<input class="buttonPlusMinus" tabindex="1" name="" id="realtedbutton11" value="-" onclick="showhide(this.id)" type="button">
					</div>
					
					
					
				    <div class="hisDivHide p-10" id="newpost11" style="display:block;">
				    	<div class="row">
				    	<div class="col-md-6">
							<div class="form-group row">
								<label class="col-md-4 col-form-label">Exception</label>
								<div class="col-md-7">
								<input type="text" class="form-control" id="AuditExceptionName" name="AuditExceptionName" value="" readonly="readonly">
								</div>
							</div>
						</div>
							<div class="w-100"></div>
				    		 <div class="col-md-6">
								<div class="form-group row">
									<label class="col-md-4 col-form-label" style="  padding-left: 10px;">Remarks</label>
									<div class="col-md-7">
										 <textarea name="" class="form-control" id="auditorRemrks" name="auditorRemrks" rows="3"></textarea>
									</div>
								</div>
							</div>
							
							<div class="col-md-4">
								<div class="form-group row ">

									<label class="col-md-4 col-form-label">Final Remarks</label>

									<div class="col-md-8">
									<input type="radio"  id="finalRemarksObservation" name="finalRemarks" value="A">
				  					<label for="observation" class="greenText">Observation</label>
				  					<br><input type="radio" id="finalRemarksSuggstion" name="finalRemarks" value="R">
				  					<label for="newSuggestion" class="redText" >New Suggestion</label>
										<!-- <select id="finalRemarks" name="finalRemarks" class="midium form-control">
											<option value="A">Validate</option>
											<option value="R">New Suggestion</option>
										</select> -->


									</div>

								</div>

							</div>
				    	
				    	</div>
				    </div>
				    <!-- Auditor Feedback End -->
					    
					    
					    <div class="row clearfix">		 
							 <div class="col-md-12 text-right m-t-20"> 
								<!-- <input type="submit" id="btnSubmit" class="btn btn-primary m-r-10 notDisable" value="Submit" onclick="treatmentAuditSubmit()"/> -->
								<button type="button" onclick="redirectWaitingList()" class="btn btn-primary notDisable" >Close</button>	
								
								</div> 
						   </div> 
						</div>
					    
					</div>
				</div>
			</div>
		</div>
		
	</div>
	<!-- container -->
	<!-- content -->
	</div>
<div class="modal" id="modelForRecommendedDiagnosis"  role="dialog">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message code="lblIndianCoastGuard" /></span>

					<button type="button" onClick="closeRecommendedDiagnosis();" class="close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div class="modal-body">
					<div class="control-group">
						
					<div class='divErrorMsg form-group row' id='errordiv' ></div>
					<div class="form-group row" id="messageForCurrentMedication"></div>

						
						
						<div style="float: left">

												<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatusForUnitAdminCurrentMedication" style="font-size: 15px;"
												align="left"></td>
											<td>
											</td>
										</tr>
									</table>
						
								</div>
							<div style="float: right">
									<div id="resultnavigationForRecommendedDiagnosis"></div>
								</div>			
								
						
						<div class="table-responsive">
						
							<table class="table table-bordered m-t-10" align="center"
								cellpadding="0" cellspacing="0">
								<tr>
								<th>SNo.</th>
								<th scope="col">Recommended Diagnosis</th>
								</tr>
								<tbody id="recommendedDiagnosis">
								</tbody>
							</table>
						</div>




					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" data-dismiss="modal" id="closeRecommendedDiagnosisId"
						onClick="closeRecommendedDiagnosis();" aria-hidden="true"><spring:message code="btnClose"/></button>	
				</div>
			</div>
		</div>
	</div>
	
<div class="modal" id="modelForRecommendedInvestgation"  role="dialog">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message code="lblIndianCoastGuard" /></span>

					<button type="button" onClick="closeRecommendedInvestgation();" class="close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div class="modal-body">
					<div class="control-group">
						
					<div class='divErrorMsg form-group row' id='errordiv' ></div>
					<div class="form-group row" id="messageForCurrentMedication"></div>

						
						
						<div style="float: left">

												<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatusForUnitAdminCurrentMedication" style="font-size: 15px;"
												align="left"></td>
											<td>
											</td>
										</tr>
									</table>
						
								</div>
							<div style="float: right">
									<div id="resultnavigationForRecommendedDiagnosis"></div>
								</div>			
								
						
						<div class="table-responsive">
						
							<table class="table table-bordered m-t-10" align="center"
								cellpadding="0" cellspacing="0">
								<tr>
								<th>SNo.</th>
								<th scope="col">Recommended Investgation</th>
								</tr>
								<tbody id="recommendedInvestgation">
								</tbody>
							</table>
						</div>




					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" data-dismiss="modal" id="closeRecommendedInvestgationId"
						onClick="closeRecommendedInvestgation();" aria-hidden="true"><spring:message code="btnClose"/></button>	
				</div>
			</div>
		</div>
	</div>	
<div class="modal" id="modelForRecommendedTreatment"  role="dialog">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message code="lblIndianCoastGuard" /></span>

					<button type="button" onClick="closeRecommendedTreatment();" class="close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div class="modal-body">
					<div class="control-group">
						
					<div class='divErrorMsg form-group row' id='errordiv' ></div>
					<div class="form-group row" id="messageForCurrentMedication"></div>

						
						
						<div style="float: left">

												<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatusForUnitAdminCurrentMedication" style="font-size: 15px;"
												align="left"></td>
											<td>
											</td>
										</tr>
									</table>
						
								</div>
							<div style="float: right">
									<div id="resultnavigationForRecommendedDiagnosis"></div>
								</div>			
								
						
						<div class="table-responsive">
						
							<table class="table table-bordered m-t-10" align="center"
								cellpadding="0" cellspacing="0">
								<tr>
								<th>SNo.</th>
								<th scope="col">Recommended Treatment</th>
								</tr>
								<tbody id="recommendedTreatment">
								</tbody>
							</table>
						</div>




					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" data-dismiss="modal" id="closeRecommendedTreatmentId"
						onClick="closeRecommendedTreatment();" aria-hidden="true"><spring:message code="btnClose"/></button>	
				</div>
			</div>
		</div>
	</div>	
<div class="modal" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title font-weight-bold"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="text-center text-theme text-sm">
         Loading <i class="fa fa-spin fa-spinner"></i>
        </div>
      </div> 
       <!-- <div class="text-center text-primary text-xsm">
         loading <i class="fa fa-spin fa-spinner"></i>
        </div> -->
    </div>
  </div>
</div>
<!-- END wrapper -->



<script type="text/javascript">
            $(document).ready(function() {
                /* if (typeof element !== "undefined" && element.value == '') {
                } */
                
                
                var data = ${
                    data
                };
                                        
                if (data.data[0].visitId != null) {
                    document.getElementById('visitId').value = data.data[0].visitId;
                }
                if (data.data[0].patientId != null) {
                    document.getElementById('patientId').value = data.data[0].patientId;
                }
                            
                if (data.data[0].patientName != null) {
                    document.getElementById('empname').value = data.data[0].patientName;
                }
               
                if (data.data[0].ageFull != null) {
                    document.getElementById('age').value = data.data[0].ageFull;
                    document.getElementById('ageNumber').value = data.data[0].age;
                }
                if(data.data[0].gender!=null){
               	 document.getElementById('gender').value=data.data[0].gender;
               } 
                if (data.data[0].patientImage != null ) {
 	 				console.log(data.data[0].patientImage);
 	 				prevPic.setAttribute('src', "data:image/png;base64,"+data.data[0].patientImage);
 					
 	             } else {
 	            	prevPic.setAttribute('src', "/MMUWeb/resources/images/no-photo.jpg");
 	             } 
	        
	           if (data.data[0].genderId != null) {
	               document.getElementById('genderId').value = data.data[0].genderId;
	           	}
                if (data.data[0].mobileno != null) {
                    document.getElementById('mobileno').value = data.data[0].mobileno;
                }
                
                if(data.data[0].patientType=="G"){	
               	 document.getElementById('ptientType').value ='General Citizen';
    	 			}
    	 		 else if(data.data[0].patientType=="L"){
    	 			document.getElementById('ptientType').value = 'Labour';
    	 			}
               
                if (data.data[0].height != null) {
                    document.getElementById('height').value = data.data[0].height;
                    
                }
               /*  if (data.data[0].idealWeight != null) {
                    document.getElementById('ideal_weight').value = data.data[0].idealWeight;
                } */
                if (data.data[0].weight != null) {
                    document.getElementById('weight').value = data.data[0].weight;
                }
               /*  if (data.data[0].varation != null) {
                		document.getElementById('variant_in_weight').value =data.data[0].varation;
                	 
                } */
                if (data.data[0].tempature != null) {
                    document.getElementById('tempature').value = data.data[0].tempature;
                }
                if (data.data[0].bp != null) {
                    document.getElementById('bp').value = data.data[0].bp;
                }
                if (data.data[0].bp1 != null) {
                    document.getElementById('bp1').value = data.data[0].bp1;
                }
                if (data.data[0].pulse != null) {
                    document.getElementById('pulse').value = data.data[0].pulse;
                }
                if (data.data[0].spo2 != null) {
                    document.getElementById('spo2').value = data.data[0].spo2;
                }
                if (data.data[0].bmi != null && data.data[0].bmi != undefined && data.data[0].bmi != "" && data.data[0].bmi != "NaN") {
                    document.getElementById('bmi').value = data.data[0].bmi;
                }
                if (data.data[0].rr != null) {
                    document.getElementById('rr').value = data.data[0].rr;
                }
                if (data.data[0].patientPastMedicalHistory!= null) {
                    document.getElementById('pastMedicalHistory').value = data.data[0].patientPastMedicalHistory;
                } 
                if (data.data[0].AuditExceptionName!= null) {
                	console.log("new:"+data.data[0].AuditExceptionName);
                    document.getElementById('AuditExceptionName').value = data.data[0].AuditExceptionName;
                }
                getPatientSympotonsRecall();
                if (data.data[0].followUpFlag != null && data.data[0].followUpFlag =="Y") {
                	$('#followUpChecked').attr('checked', true); 
                	document.getElementById("noOfDays").selectedIndex = data.data[0].followUpDays;
                	if(data.data[0].followUpDays!=17)
                	{	
                		document.getElementById("nextFollowUpDate").value = data.data[0].followUpDate;
                		$('#'+"nextFollowUpDate").attr('readonly', true);
                	}
                	else
                	{
                		document.getElementById("nextFollowUpDate").value = data.data[0].followUpDate;
                		
                	}
                	//nextFolloUpDate(data.data[0].followUpDays);
                	//document.getElementById("followUpChecked").checked == true;
                }
                
                if (data.data[0].mlcFlag != null && data.data[0].mlcFlag =="Y") {
                	$('#markMLC').attr('checked', true); 
                	 marksAsMLCRecall();
                	document.getElementById("mlcPloiceStation").value = data.data[0].policeStation;
                	document.getElementById("mlcTreatedAs").value = data.data[0].treatedAs;
                	document.getElementById("mlcPloiceName").value = data.data[0].mlcPloiceName;
                	document.getElementById("mlcDesignation").value = data.data[0].mlcDesignation;
                	document.getElementById("mlcIdNumber").value = data.data[0].mlcIdNumber;
                	
                }
                if (data.data[0].doctorAdditionalNote != null && data.data[0].doctorAdditionalNote!="") {
                	document.getElementById("additionalNote").value = data.data[0].doctorAdditionalNote;
                }
                if (data.data[0].ecgRemarks != null && data.data[0].ecgRemarks!="") {
                	document.getElementById("ecgRemarks").value = data.data[0].ecgRemarks;
                }
                if(data.data[0].masEmployeeCategory!=null)
                {
                	 document.getElementById('empCategory').value = data.data[0].masEmployeeCategory;
                }
                if(data.data[0].visitId!=null){ 
                  	 document.getElementById('visitId').value=data.data[0].visitId;
                  }
                   
                   if(data.data[0].opdPatientDetailId!=null){
                     	 document.getElementById('opdPatientDetailId').value=data.data[0].opdPatientDetailId;
                     }
                   if(data.data[0].patientId!=null){
                    	 document.getElementById('patientId').value=data.data[0].patientId;
                    }
                   if(data.data[0].duration!=null){
                  	 document.getElementById('duration').value=data.data[0].duration;
                  }
                
                if (data.data[0].departmentId != null) {
                    document.getElementById('departmentId').value = data.data[0].departmentId;
                }
                
                if (data.data[0]!=null && data.data[0].recommendedMedicalAdvice != null  && data.data[0].recommendedMedicalAdvice!="") {
                	$("#recommendedMedicalAdvice").val(data.data[0].recommendedMedicalAdvice);  
                }
                else{
                	$("#recommendedMedicalAdvice").val('Review SOS');
                }
               /*  if (data.data[0].otherInvestigation != null  ) {
                	$("#otherInvestigation").val(data.data[0].otherInvestigation);  
                	
                } */
                if (data.data[0].registrationTypeCode != null) {
                    document.getElementById('registrationTypeCode').value = data.data[0].registrationTypeCode;
                }
                
                if (data.data[0].auditorRemarks != null) {
                    document.getElementById('auditorRemrks').value = data.data[0].auditorRemarks;
                }
                if (data.data[0].audtiorFinalFlag != null) {
                	if(data.data[0].audtiorFinalFlag=="A")
                	{	
                	$("#finalRemarksObservation").prop("checked", true);
                	}
                	if(data.data[0].audtiorFinalFlag=="R")
                	{
                		$("#finalRemarksSuggstion").prop("checked", true);	
                	}	
                	
                }
                    var labRadioValue=resourceJSON.mainchargeCodeLab;
                    $j('#labImaginId').val(labRadioValue);
                 	getFrequencyDetailTre();
                   	getDispUnitDetail();
                   	geTreatmentInstructionData();
                    getSpecialistList();
                    //patientHistoryData(); 
                	//checkForAuthenticateUser();
                	getPatientDiagnosisDetailAuditDetails();
   					//patientExaminationDignosisData();
   				   	patientInvestigationData();
                    patientTreatementDetail();
                   	getPatientReferalDetail();
                  	getPocedureDetailData();
					// getUsersAuth();
					//getMastStoreItemNipRecall();
					//patientObstetricsData();
					
					disableAllInput();
					
            });
        </script>


<script>
	
	function disableAllInput(){
		$('input').attr('disabled','disabled');
		$('textarea').attr('disabled','disabled');
		$('select').attr('disabled','disabled');
		$('button').attr('disabled','disabled');
		$('.notDisable').removeAttr('disabled');
		
		$('#closeRecommendedDiagnosisId').attr('disabled',false);
		$('#closeRecommendedInvestgationId').attr('disabled',false);
		$('#closeRecommendedTreatmentId').attr('disabled',false);
		$('.close').attr('disabled',false);
		$('#viewEcgDocumentId').attr('disabled',false);
		
		
	}
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
		 }else if(buttonId=="button13"){
				test('realted'+buttonId,"newpost13");
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
	
	var uhidNumberValue="";
	 var checkForAuthen="";
	 function showPreveiousVisit() {
		 var pathname = window.location.pathname;
        var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/showPreveiousVisit?patientId=";
			 $('#exampleModal').show();
			 $('.modal-backdrop').show();
		     $('#exampleModal .modal-body').load(url+$('#patientId').val());
            $('#exampleModal .modal-title').text('Previous Visit');
				
	 }
	 
	 function showPreveiousVital() {
		
		 var pathname = window.location.pathname;
        var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/showPreveiousVital?patientId=";
			 $('#exampleModal').show();
			 $('.modal-backdrop').show();
		     $('#exampleModal .modal-body').load(url+$('#patientId').val());
            $('#exampleModal .modal-title').text('Previous Vitals');
		    /*  popup = window.open("showPreveiousVital?patientId="+$('#patientId').val()+"", "popUpWindow", "height=500,width=800,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
		     popup.focus(); */
			
	 }
	 
	 function showPreveiousLabInvestigation() {
		 var pathname = window.location.pathname;
        var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/showPreveiousLab?patientId=";
			 $('#exampleModal').show();		
		     $('#exampleModal .modal-body').load(url+$('#patientId').val());
            $('#exampleModal .modal-title').text('Previous Lab Investigation');
		     
			
	 }
	 
  function showPreveiousRadioInvestigation() {
	   var pathname = window.location.pathname;
      var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/showPreveiousRadio?patientId=";
			 $('#exampleModal').show();
			 $('.modal-backdrop').show();
		     $('#exampleModal .modal-body').load(url+$('#patientId').val());
            $('#exampleModal .modal-title').text('Previous ECG Investigation');
		 
	 }
	 
	      
  </script>
</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
