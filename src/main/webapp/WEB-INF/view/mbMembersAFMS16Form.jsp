<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Indian Coast Guard</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/medicalexam.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newOpd.js"></script>

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
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">


		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">AFMSF - 16</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
							<%-- <form:form name="submitMedicalExamByMAForm18" id="submitMedicalExamByMAForm18" method="post"
									action="${pageContext.request.contextPath}/medicalexam/submitMedicalExamByMAForm18" autocomplete="off"> --%>
								<div class="card-body">
									<input type="hidden" name="hospitalId" id="hospitalId" value="<%=hospitalId%>"/>
									<input type="hidden" name="userId" id="userId" value="<%=userId%>"/>
									 <input type="hidden" name="visitId" id="visitId" value=""/>
									 <input type="hidden" name="patientId" id="patientId" value=""/>		
									<!-- <div class="row m-b-30">
										<div class="col-md-3">
											<a href="#" class="btn btn-primary btn-block">EHR</a>
										</div>
										<div class="col-md-3">
											<a href="#" class="btn btn-primary btn-block">Previous Medical Exams</a>
										</div>
										<div class="col-md-3">
											<a href="#" class="btn btn-primary btn-block">Previous Medical Boards</a>
										</div>
										<div class="col-md-3">
											<a href="#" class="btn btn-primary btn-block">Immunizations</a>
										</div>
									</div>
									
									<br/> -->
								
										<div class="row">
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-6">
														<label for="service" class="col-form-label">Authority for Board</label>
													</div>
													<div class="col-md-6">
														<input type="text" name="authorityForBoard" id="authorityForBoard" class="form-control" readonly/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-6">
														<label for="service" class="col-form-label">Place</label>
													</div>
													<div class="col-md-6">
														<input type="text"  name="placeOfExam" value="<%=session.getAttribute("hospital_Name")%>" id="placeOfExam" class="form-control" readonly/>
													</div>
												</div>
											</div>
											<!-- <div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-6">
														<label for="service" class="col-form-label">Station Medicare Center AFND</label>
													</div>
													<div class="col-md-6">
														<input type="text" class="form-control" disabled/>
													</div>
												</div>
											</div> -->
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-6">
														<label for="service" class="col-form-label">Date</label>
													</div>
													<div class="col-md-6">
														<div class="dateHolder">
															<input type="text"  name="dateOfPatient" id="dateOfPatient"class="calDate form-control" placeholder="DD/MM/YYYY" >
														</div>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-6">
														<label for="service" class="col-form-label">Date of Release</label>
													</div>
													<div class="col-md-6">
														<div class="dateHolder">
															<input type="text"  name="dateOfRelease" id="dateOfRelease" class="calDate form-control" placeholder="DD/MM/YYYY" >
														</div>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-6">
														<label for="service" class="col-form-label">Name</label>
													</div>
													<div class="col-md-6">
														<input type="text" class="form-control" name="empName" id="empName" readonly/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-6">
														<label for="service" class="col-form-label">Service No.</label>
													</div>
													<div class="col-md-6">
														<input type="text" name="serviceNo" id="serviceNo"class="form-control" readonly/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-6">
														<label for="service" class="col-form-label">Rank</label>
													</div>
													<div class="col-md-6">
														<input type="text" name="rank" id="rank"class="form-control" readonly/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-6">
														<label for="service" class="col-form-label">DOB</label>
													</div>
													<div class="col-md-6">
														<input type="text"  name="dob" id="dob"  class="form-control" readonly/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-6">
														<label for="service" class="col-form-label">Unit/Ship</label>
													</div>
													<div class="col-md-6">
														<input type="text" name="unitOrSlip" id="unitOrSlip"  class="form-control" disabled/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-6">
														<label for="service" class="col-form-label">Service</label>
													</div>
													<div class="col-md-6">
														<select class="form-control">
															<option>Select</option>
															<option>Army</option>
															<option>Navy</option>
															<option>Air Force</option>
														</select>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-6">
														<label for="service" class="col-form-label">Arm/Corps/Branch/Trade</label>
													</div>
													<div class="col-md-6">
														<input type="text" name="armCorpsBranchTrade" id="armCorpsBranchTrade"class="form-control" readonly/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-6">
														<label for="service" class="col-form-label">Total Service</label>
													</div>
													<div class="col-md-6">
														<input type="text" class="form-control"  name="totalService" id="totalService" readonly/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-6">
														<label for="service" class="col-form-label">Marital Status</label>
													</div>
													<div class="col-md-6">
														<input type="text" name="maritalStatus" id="maritalStatus" class="form-control" readonly/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-6">
														<label for="service" class="col-form-label">Permanent Address</label>
													</div>
													<div class="col-md-6">
														<textarea class="form-control" name="permanentAddress" id="permanentAddress"rows="2" readonly></textarea>
													</div>
												</div>
											</div>
											<!-- <div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-6">
														<label for="service" class="col-form-label">Past Medical History</label>
													</div>
													<div class="col-md-6">
														<textarea class="form-control" rows="2" disabled></textarea>
													</div>
												</div>
											</div> -->
											<div class="col-md-8">
												<div class="form-group row">
													<div class="col-md-3">
														<label for="service" class="col-form-label">Identification Marks </label>
														<span class="pull-right m-t-8">1.</span> 
													</div>
													<div class="col-md-9">
														<textarea class="form-control" name="identificationMarks1" id="identificationMarks1"></textarea>
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-3 text-right">
														<label for="service" class="col-form-label">2.</label>
													</div>
													<div class="col-md-9">
														<textarea class="form-control" name="identificationMarks2" id="identificationMarks2"></textarea>
													</div>
												</div>
											</div>
										</div>
										
										
										
										
										
										
									<!---------------------- Service Details ---------------------->
									
									<div class="adviceDivMain" id="button12" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Service Details</span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton12" value="+" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost12">
										<div class="row">
										<div class="col-md-12">
										<table class="table table-hover table-striped table-bordered">
											<thead class="bg-primary">
												<tr>
													<th>S.No.</th>
													<th>From</th>
													<th>To</th>
													<th>Place</th>
													<th>P/F</th>
													<th>Add</th>
													<th>Delete</th>												
												</tr>
											</thead>
											<tbody id ="serviceDetailsIdGrid">												
												<tr>
													<td>1</td>
													<td>
														<div class="dateHolder">
															<input type="text" name="serviceDetailFrom" id="serviceDetailFrom"class="input_date  form-control" placeholder="DD/MM/YYYY" >
														</div>
													</td>
													<td>
														<div class="dateHolder">
															<input type="text"  name="serviceDetailTo" id="serviceDetailTo" class="input_date  form-control" placeholder="DD/MM/YYYY" >
														</div>
													</td>
													<td>
														<input type="text"  name="serviceDetailPlace" id="serviceDetailPlace" class="form-control">
													</td>
													<td>
														<select class="form-control" name="serviceDetailPf" id="serviceDetailPf">
															<option value="0">Select</option>
															<option value="Peace">Peace</option>
															<option value="Field">Field</option>
														</select>
													</td>
													<td>
														<button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth" button-type="add"   onclick="addRowForServiceDetails();" ></button>
													</td>
													<td>
						
														<button class="btn btn-danger noMinWidth" name="delete" value="" id="deleteServiceDetail" button-type="delete"  onclick="removeRowInvestigation(this);" disabled></button>
													</td>
												</tr>
												
											</tbody>
										</table>
										</div>
										
										
										</div>
										<div class="row">
											<div class="col-12 m-t-10">
												<h6 class="font-weight-bold"> Any Previous Service in Army / Navy / Air Force</h6>
											</div>
										</div>
										<div class="row m-t-10">
											<div class="col-md-8">
												<div class="form-group row">
													<div class="col-md-3">
														<label for="service" class="col-form-label">Particulars of Previous Service</label>
													</div>
													<div class="col-md-9">
														<textarea class="form-control" rows="2"  name="particularsOfPreviousService" id="particularsOfPreviousService"></textarea>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Disability Pension Recieved</label>
													</div>
													<div class="col-md-7">
														<select class="form-control" id="disabilityPensionRecieved" name="disabilityPensionRecieved">
															<option value="0">Select</option>
															<option value="Yes">Yes</option>
															<option value="No">No</option>
														</select>
													</div>
												</div>
											</div>
										</div>
										
										
									</div>
									
									<!---------------------- Service Details ends here ---------------------->
									
									<!---------------------- Disease Details ---------------------->
									
									<div class="adviceDivMain" id="button13" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Disease,Wound Or Injury Details</span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton13" value="+" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost13">
										
										<table class="table table-hover table-striped table-bordered">
											<thead class="bg-primary">
												<tr>
													<th rowspan="2">Illness/ Wound/ Injury</th>
													<th class="text-center" colspan="2">First Started</th>
													
													<th rowspan="2">Where Treated</th>
													<th class="text-center" colspan="2">Approximate Dates &amp; Periods Treated</th>
													
													<th rowspan="2">Add</th>
													<th rowspan="2">Delete</th>
												</tr>
												<tr>
													
													<th>Date</th>
													<th>Place</th>
													<th>From</th>
													<th>To</th>
												</tr>
											</thead>
											<tbody id="diseaseWoundInjuryDetailsGrid">
												
												<tr>
													<td>
														
 										 			<div class="autocomplete">
								 						<input type="text" class="form-control" name="IllnessWoundInjury" id="IllnessWoundInjury" onblur="fillDiagnosisComboF18(this.value,this);" onKeyPress="autoCompleteCommonMe(this,5);" onKeyUp="autoCompleteCommonMe(this,5);"placeholder="Diagnosis" value="" />
								 						<input type="hidden" id="icdDiagnaosis" name="icdDiagnaosis" value=""/>
								 					</div>
													</td>
													<td>
														<div class="dateHolder">
															<input type="text" name="firstStartedDate" id="firstStartedDate" class="input_date  form-control" placeholder="DD/MM/YYYY" >
														</div>
													</td>
													<td>
														<input type="text" name="firstStartedPlace" id="firstStartedPlace" class="form-control">
														
													</td>
													<td>
														<input type="text" name="whereTreated" id="whereTreated" class="form-control">
													</td>
													
													<td>
														<div class="dateHolder">
															<input type="text"  name="approximatePeriodsTreatedFrom" id="approximatePeriodsTreatedFrom" class="input_date  form-control" placeholder="DD/MM/YYYY" >
														</div>
													</td>
													<td>
														<div class="dateHolder">
															<input type="text" name="approximatePeriodsTreatedTo" id="approximatePeriodsTreatedTo" class="input_date  form-control" placeholder="DD/MM/YYYY" >
														</div>
													</td>
													<td>
													<button name="Button" type="button"   class="btn btn-primary noMinWidth" button-type="add"   onclick="addRowForDiseaseWoundInjury();" ></button>
													 
													</td>
													<td>
													<button class="btn btn-danger noMinWidth" name="delete" value="" id="deleteDiseaseWoundInjury" button-type="delete"  onclick="removeRowInvestigation(this);" disabled></button>

													</td>
													
												</tr>
												
											</tbody>
										</table>
										
										
										<div class="row m-t-10">
											<div class="col-md-12">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">
														Did you suffer from any disability before joining the Armed Forces
														</label>
													</div>
													<div class="col-md-2">
														<select class="form-control" name="disabilityBeforeJoining" id="disabilityBeforeJoining" onChange="return getDisabilityBeforeJoining(this);">
															<option value="0">Select</option>
															<option value="Yes">Yes</option>
															<option value="No">No</option>
														</select>
													</div>
												</div>
												
											<div id="diseaseWoundInjuryArmedForcesTable" style="display:none">	
											<table class="table table-hover table-striped table-bordered">
											<thead class="bg-primary">
												
												<tr>
													<th>From Date</th>
													<th>To Date</th>
													<th>Details</th>
													<th>Add</th>
													<th>Delete</th>
												</tr>
											</thead>
											<tbody id="diseaseWoundInjuryArmedForces">
												
												<tr>
													<td class="width150">
														<div class="dateHolder">
															<input type="text" name="armedForcesFrom"  id="armedForcesFrom" class="input_date form-control" placeholder="DD/MM/YYYY" >
														</div>
													</td>
													
													<td class="width150">
														<div class="dateHolder">
															<input type="text" name="armedForcesTo"  id="armedForcesTo" class="input_date form-control" placeholder="DD/MM/YYYY" >
														</div>
													</td>
													<td>
														<textarea name="armedForcesDetails"  id="armedForcesDetails"  class="form-control"></textarea>
													</td>
													
													<td class="width60">
													<button name="Button" type="button"   class="btn btn-primary noMinWidth" button-type="add"   onclick="addRowForDiseaseWoundInjuryArmedForces();" ></button>
													 
													</td>
													<td class="width60">
													<button class="btn btn-danger noMinWidth" name="delete" value="" id="deleteArmedForces" button-type="delete"  onclick="removeRowInvestigation(this);" disabled></button>

													</td>
												</tr>
												
											</tbody>
										</table>
										</div>
											</div>
											
											<div class="col-md-12">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">
														Do you claim any disability due to service
														</label>
													</div>
													<div class="col-md-2">
														<select class="form-control" name="claimAnyDisability" id="claimAnyDisability">
															
															<option>Select</option>
															<option>Yes</option>
															<option>No</option>
														</select>
													</div>
												</div>
											</div>
											<div class="col-md-12">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">
														Any other information you wish to give about your health
														</label>
													</div>
													<div class="col-md-3">
														<textarea class="form-control" name="anyOtherInformation" id="anyOtherInformation" rows="3"></textarea>
													</div>
												</div>
											</div>
										</div>
										
										
									</div>
									
									
									<!---------------------- Disease Details ends here ---------------------->
									
									
									<!---------------------- Witness Details ---------------------->
										
									<div class="adviceDivMain" id="button14" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Witness</span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton14" value="+" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost14">
										
										<div class="row m-b-10">
											<div class="col-md-12">
												<label for="service" class="col-form-label">I certify that I have answered as fully as possible all the questions about my service and personal history and that the information given is to the best of my knowledge.</label>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Signature of Witness</label>
													</div>
													<div class="col-md-7">
														<input type="text" name="signatureOfWitness" id="signatureOfWitness"class="form-control" />
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Signature of Individual</label>
													</div>
													<div class="col-md-7">
														<input type="text" name="signatureOfIndividual" id="signatureOfIndividual" class="form-control" />
													</div>
												</div>
											</div>
											<div class="w-100"></div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Service No.</label>
													</div>
													<div class="col-md-7">
														<input type="text" name="serviceNo" id="serviceNo" class="form-control" />
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Rank</label>
													</div>
													<div class="col-md-7">
														<input type="text" name="rank" id="rank" class="form-control" />
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Date</label>
													</div>
													<div class="col-md-7">
														<div class="dateHolder">
														<input type="text" name="date" id="date" class="calDate form-control" placeholder="DD/MM/YYYY"  />
														</div>
														
													</div>
												</div>
											</div>
										</div>
										
									</div>
									<!---------------------- Witness ends here ---------------------->
									
											
										
										
										
									
									<!---------------------- Dental ---------------------->
									
									<div class="adviceDivMain" id="button1" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Dental</span>
										</div>
										<input class="buttonPlusMinus" tabindex="1" name="" id="relatedbutton1" value="+" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost1">
										<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Total No. of Teeth <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text"  name="totalNoOfTeath" id="totalNoOfTeath"  maxlength="4" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" class="form-control"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Total No. of Defective Teeth <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" name="totalNoOfDefective" id="totalNoOfDefective" onblur="calculateDentalPointAndDefectiveTeeth();" maxlength="4" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"class="form-control" />
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Total No. of Dental Points <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" name="totalNoOfDentalPoints" id="totalNoOfDentalPoints"  onblur="calculateDentalPointAndDefectiveTeeth();" maxlength="4" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" class="form-control" />
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Missing <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" name="missing" id="missing" class="form-control" readonly/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Unsavable <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" name="unSavable" id="unSavable" class="form-control" readonly/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Condition of Gums <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" name="conditionOfGums" id="conditionOfGums" maxlength="100" value="Healthy/ NAD" class="form-control"/>
													</div>
												</div>
											</div>
										</div>
										
										<div class="row">
											
											<div class="col-12 m-t-10">
												<table class="table no-border table-striped">
													<thead  class="bg-primary">
														<tr>
															<th colspan="9">Missing Teeth <span class="mandate"><sup>&#9733;</sup></span></th>
														</tr>
													</thead>
													<tbody>
														<tr id="urRow">
															<td>UR</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" name="urMChecked" id="urMChecked8" value="8" onClick="return countMissingAndUnsavableValue(this);"/>
																  <input class="form-control width50" type="text" value="8" name="urInput8" id="urInput8" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="7" name="urMChecked" id="urMChecked7" onClick="return countMissingAndUnsavableValue(this);"/>
																  <input class="form-control width50" type="text" value="7" name="urInput7" id="urInput7" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="6" name="urMChecked" id="urMChecked6" onClick="return countMissingAndUnsavableValue(this);"/>
																  <input class="form-control width50" type="text" value="6" name="urInput6" id="urInput6" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="5" name="urMChecked" id="urMChecked5" onClick="return countMissingAndUnsavableValue(this);"/>
																  <input class="form-control width50" type="text" value="5" name="urInput5" id="urInput5"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="4" name="urMChecked" id="urMChecked4" onClick="return countMissingAndUnsavableValue(this);"/>
																  <input class="form-control width50" type="text" value="4" name="urInput4" id="urInput4" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="3" name="urMChecked" id="urMChecked3" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="3" name="urInput3" id="urInput3"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="2" name="urMChecked" id="urMChecked2" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="2" name="urInput2" id="urInput2" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="1"  name="urMChecked" id="urMChecked1" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="1" name="urInput1" id="urInput1" readonly>
																</div>
															</td>
														</tr>
														<tr id="ulRow">
															<td>UL</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox"  value="8"  name="ulMChecked" id="ulMChecked8" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="8" name="ulInput8" id="ulInput8" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="7"  name="ulMChecked" id="ulMChecked7" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="7" name="ulInput7" id="ulInput7" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="6" name="ulMChecked" id="ulMChecked6" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="6" name="ulInput6" id="ulInput6"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="5" name="ulMChecked" id="ulMChecked5" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="5" name="ulInput5" id="ulInput5" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="4" name="ulMChecked" id="ulMChecked4" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="4" name="ulInput4" id="ulInput4" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="3" name="ulMChecked" id="ulMChecked3" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="3" name="ulInput3" id="ulInput3"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="2" name="ulMChecked" id="ulMChecked2" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="2" name="ulInput2" id="ulInput2"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="1" name="ulMChecked" id="ulMChecked1" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="1" name="ulInput1" id="ulInput1"  readonly>
																</div>
															</td>
														</tr>
														<tr>
															<td>LL</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="8" name="llMChecked" id="llMChecked8" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="8" name="llInput8" id="llInput8"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="7" name="llMChecked" id="llMChecked7" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="7" name="llInput7" id="llInput7"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="6" name="llMChecked" id="llMChecked6" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="6" name="llInput6" id="llInput6" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="5" name="llMChecked" id="llMChecked5" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="5" name="llInput5" id="llInput5"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="4" name="llMChecked" id="llMChecked4" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="4" name="llInput4" id="llInput4"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="3" name="llMChecked" id="llMChecked3" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="3" name="llInput3" id="llInput3"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="2" name="llMChecked" id="llMChecked2" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="2" name="llInput2" id="llInput2" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="1" name="llMChecked" id="llMChecked1" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="1" name="llInput1" id="llInput1"  readonly>
																</div>
															</td>
														</tr>
														<tr>
															<td>LR</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="8" name="lrMChecked" id="lrMChecked8" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="8"  name="lrInput8" id="lrInput8"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="7" name="lrMChecked" id="lrMChecked7" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="7"  name="lrInput7" id="lrInput7"   readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="6" name="lrMChecked" id="lrMChecked6" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="6" name="lrInput6" id="lrInput6"   readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="5" name="lrMChecked" id="lrMChecked5" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="5" name="lrInput5" id="lrInput5"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="4"  name="lrMChecked" id="lrMChecked4" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="4" name="lrInput4" id="lrInput4" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="3" name="lrMChecked" id="lrMChecked3" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="3" name="lrInput3" id="lrInput3" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="2" name="lrMChecked" id="lrMChecked2" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="2"  name="lrInput2" id="lrInput2" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="1" name="lrMChecked" id="lrMChecked1" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="1"  name="lrInput1" id="lrInput1" readonly>
																</div>
															</td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
										
										
										<div class="row">
											
											<div class="col-12 m-t-10">
												<table class="table no-border  table-striped">
													<thead  class="bg-primary">
														<tr>
															<th colspan="9">Unsavable Teeth <span class="mandate"><sup>&#9733;</sup></span></th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td>UR</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="8" name="unUrChecked" id="unurChecked8" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="8" name="unurInput8" id="unurInput8" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="7" name="unUrChecked" id="unurChecked7" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="7" name="unurInput7" id="unurInput7" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="6" name="unUrChecked" id="unurChecked6" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="6" name="unurInput6" id="unurInput6" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="5" name="unUrChecked" id="unurChecked5" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="5" name="unurInput5" id="unurInput5" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="4" name="unUrChecked" id="unurChecked4" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="4" name="unurInput4" id="unurInput4" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="3" name="unUrChecked" id="unurChecked3" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="3" name="unurInput3" id="unurInput3" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="2" name="unUrChecked" id="unurChecked2" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="2" name="unurInput2" id="unurInput2"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="1" name="unUrChecked" id="unurChecked1" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="1" name="unurInput1" id="unurInput1" readonly>
																</div>
															</td>
														</tr>
														<tr>
															<td>UL</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="8" name="unUlChecked" id="unulChecked8" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="8" name="unulInput1" id="unulInput1" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="7" name="unUlChecked" id="unulChecked7" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="7" name="unulInput7" id="unulInput7" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="6" name="unUlChecked" id="unulChecked6" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="6" name="unulInput6" id="unulInput6" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="5" name="unUlChecked" id="unulChecked5" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="5" name="unulInput5" id="unulInput5" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="4" name="unUlChecked" id="unulChecked4" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="4" name="unulInput4" id="unulInput4" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="3" name="unUlChecked" id="unulChecked3" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="3" name="unulInput3" id="unulInput3"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="2" name="unUlChecked" id="unulChecked2" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="2" name="unulInput2" id="unulInput2" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="1" name="unUlChecked" id="unulChecked1" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="1"  name="unulInput1" id="unulInput1" readonly>
																</div>
															</td>
														</tr>
														<tr>
															<td>LL</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="8" name="unLlChecked" id="unllChecked8" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="8"  name="unllInput8" id="unllInput8"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="7" name="unLlChecked" id="unllChecked7" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="7" name="unllInput7" id="unllInput7" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="6" name="unLlChecked" id="unllChecked6" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="6"  name="unllInput6" id="unllInput6"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="5" name="unLlChecked" id="unllChecked5" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="5" name="unllInput5" id="unllInput5" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="4" name="unLlChecked" id="unllChecked4" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="4"  name="unllInput4" id="unllInput4" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="3" name="unLlChecked" id="unllChecked3" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="3"  name="unllInput3" id="unllInput3" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="2" name="unLlChecked" id="unllChecked2" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="2" name="unllInput2" id="unllInput2" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="1" name="unLlChecked" id="unllChecked1" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="1" name="unllInput1" id="unllInput1" readonly>
																</div>
															</td>
														</tr>
														<tr>
															<td>LR</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="8" name="unLrChecked" id="unlrChecked8" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="8" name="unlrInput8" id="unlrInput8" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="7" name="unLrChecked" id="unlrChecked7" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="7" name="unlrInput7" id="unlrInput7" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="6" name="unLrChecked" id="unlrChecked6" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="6" name="unlrInput6" id="unlrInput6"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="5" name="unLrChecked" id="unlrChecked5" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="5" name="unlrInput5" id="unlrInput5"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="4"  name="unLrChecked" id="unlrChecked4" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="4" name="unlrInput4" id="unlrInput4" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="3" name="unLrChecked" id="unlrChecked3" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="3" name="unlrInput3" id="unlrInput3" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="2" name="unLrChecked" id="unlrChecked2" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="2" name="unlrInput2" id="unlrInput2" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline">
																  <input class="form-check-input" type="checkbox" value="1" name="unLrChecked" id="unlrChecked1" onClick="return countMissingAndUnsavableValue(this);">
																  <input class="form-control width50" type="text" value="1" name="unlrInput1" id="unlrInput1" readonly>
																</div>
															</td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
										
										<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Dental Officer <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" name="dentalOffier" id="dentalOffier"  class="form-control"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Checkup Date <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<div class="dateHolder">
															<input type="text" name="checkupDate" id="checkupDate" class="noFuture_date2 form-control" placeholder="DD/MM/YYYY" >
														</div>
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Remarks <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<textarea name="remarks" id="remarks" class="form-control"  maxlength=200 rows="2">Dentally fit</textarea>
													</div>
												</div>
											</div>
										</div>
									</div>
									
									<!---------------------- Dental end here ---------------------->
									
									<!---------------------- Investigation ---------------------->
									
									<div class="adviceDivMain" id="button5" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Investigation</span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton5" value="-" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost5" style="display:block;">
										
										
										<div class="col-12  m-b-10">
											<div class="form-check form-check-inline">
                                                   <input class="form-check-input" type="radio" name="labradiologyCheck" checked="checked"
												  onchange="changeRadio(this.value)" value="2" />
                                               <label class="form-check-label m-l-5" for="inlineRadio1">Laboratory</label>
                                              </div>
                                             <div class="form-check form-check-inline">
                                                <input type="radio" value="1" class="radioCheckCol2"  name="labradiologyCheck" onchange="changeRadio(this.value)" />
                                                 <label class="form-check-label m-l-5" for="inlineRadio2">Radiology</label>
                                             </div>
											</div>
										
										<table class="table table-hover table-striped table-bordered">
											<thead class="bg-primary">
												<tr>
													<th>Investigation</th>
													<th>Result</th>
													<th>File Upload</th>
													<th></th>
													<th></th>
												</tr>
											</thead>
											<tbody id="dgInvetigationGrid">
												
												<tr>
													<td>
														<!-- <input type="text" class="form-control"> -->
														
														<input type="text" autocomplete="off" value="" id="chargeCodeName"
																			class="form-control border-input"
																			name="chargeCodeName" onKeyPress="autoCompleteCommonMe(this,1);" size="44"
																			onblur="populateChargeCode(this.value,'1',this);"/>
																		<input type="hidden" id="qty" tabindex="1" name="qty1"
																			size="10" maxlength="6" validate="Qty,num,no" /> <input
																			type="hidden" tabindex="1" id="chargeCodeCode"
																			name="chargeCodeCode" size="10" readonly /> <input
																			type="hidden" name="investigationIdValue" value=""
																			id="investigationIdValue" /> <input type="hidden"
																			name="dgOrderDtIdValue" value=""
																			id="dgOrderDtIdValue" /> <input type="hidden"
																			name="dgOrderHdId" value="" id="dgOrderHdId " /> 
													</td>
													<td>
														<input type="text" name="resultInvs" id="resultInvs"class="form-control">
													</td>
													<td>
													<div class="fileUploadDiv">
														<input type="file" class="inputUpload">
														<label class="inputUploadlabel">Choose File</label>
														<span class="inputUploadFileName">No File Chosen</span>
													</div>													
													</td>
													 <td>
														<button name="Button" type="button" class="buttonAdd btn btn-primary noMinWidth" button-type="add" value=""  onclick="addNewRowForInvestigation();" tabindex="1"></button>
													</td>
													<td>
														<button type="button"   name="delete" value="" id="deleteInves1"  class="buttonDel btn btn-danger noMinWidth" button-type="delete"onclick="removeRowInvestigation(this);"></button>
													</td> 
											 
													
												</tr>
												
											</tbody>
										</table>
										
										<!-- <div class="row">
											<div class="col-md-12">
												<div class="form-group row">
													<div class="col-md-3">
														<label for="service" class="col-form-label">Clinical Notes</label>
													</div>
													<div class="col-md-9">
														<input type="text" id="clinicalNotes" name="clinicalNotes" class="form-control" >
													</div>
												</div>
											</div>
										</div> -->
									</div>
									
									<!---------------------- Investigation ends here ---------------------->
									<!---------------------- Physical Capacity ---------------------->
									
									<div class="adviceDivMain" id="button2" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Physical Capacity</span>
										</div>
										<input class="buttonPlusMinus" tabindex="2" name="" id="relatedbutton2" value="+" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost2">
										<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Height <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input type="text" name="height" id="height" class="form-control" maxlength="3" onblur="idealWeight();checkBMI();" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;">
														    <div class="input-group-append" >
														      <div class="input-group-text">cm</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											
											
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Weight Actual <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input type="text" name="weight" id="weight" class="form-control" onblur="checkVaration();checkBMI();" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;">
														    <div class="input-group-append">
														      <div class="input-group-text">kg</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											
												<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Ideal Wt <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input type="text" name="idealWeight" id="idealWeight" class="form-control" onblur="checkVaration()" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;">
														    <div class="input-group-append">
														      <div class="input-group-text">kg</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											
											<div class="w-100"></div>
											
										
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Over Weight <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input type="text" name="overWeight"  maxlength="10" id="overWeight" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"class="form-control" readonly>
														    <div class="input-group-append">
														      <div class="input-group-text">%</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Waist <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input type="text" name="waist" id="waist"   onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"class="form-control">
														    <div class="input-group-append">
														      <div class="input-group-text">cm</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											
											<!-- <div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">BMI</label>
													</div>
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input type="text" name="bmi" id="bmi" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"class="form-control">
														    <div class="input-group-append">
														      <div class="input-group-text">kg/m2</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div> -->
											
											<!-- <div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Body Fat</label>
													</div>
													<div class="col-md-7">
														
															<input type="text" name="bodyFat" id="bodyFat" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"class="form-control">
														
													</div>
												</div>
											</div> -->
											
											
											
											<!-- <div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">HIP</label>
													</div>
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input type="text" name="hip" id="hip" onblur="calculateWHR();" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"class="form-control">
														    <div class="input-group-append">
														      <div class="input-group-text">cm</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">WHR</label>
													</div>
													<div class="col-md-7">
														
															<input type="text" name="whr" id="whr" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"class="form-control" readonly/>
														 
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Skin Fold Expansion</label>
													</div>
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input type="text" name="skinFoldExpansion" id="skinFoldExpansion" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"class="form-control">
														    <div class="input-group-append">
														      <div class="input-group-text">cm</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div> -->
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Chest Full Expansion <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input type="text"  name="chestFullExpansion" id="chestFullExpansion" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"class="form-control">
														    <div class="input-group-append">
														      <div class="input-group-text">cm</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Range of Expansion <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input type="text" name="rangeOfExpansion" id="rangeOfExpansion" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"class="form-control">
														    <div class="input-group-append">
														      <div class="input-group-text">cm</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											
											<!-- <div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Sportsman</label>
													</div>
													<div class="col-md-7">
														<select class="form-control" name="sportsman" id="sportsman">
															<option value="0">Select</option>
															<option value="y">Yes</option>
															<option value="n">No</option>
														</select>
													</div>
												</div>
											</div> -->
											
										</div>
									
									</div>
									
									<!---------------------- Physical Capacity ends here---------------------->
									
									<!---------------------- Cardio Vascular System ---------------------->
									
									<div class="adviceDivMain" id="button6" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Cardio Vascular System</span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton6" value="+" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost6">
										
										<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Pulse <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input type="text" id="pulse" name="pulse" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"class="form-control">
														    <div class="input-group-append">
														      <div class="input-group-text">/min</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-3">
														<label for="service" class="col-form-label">BP <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<!-- <div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input type="text" id="bp" name="bp" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"class="form-control">
														    <div class="input-group-append">
														      <div class="input-group-text">cm</div>
														    </div>
														  </div>
													</div> -->
													
													<div class="col-md-3 offset-md-2">
														
															<input name="bp" id="bp" type="text"
															class="form-control border-input bpSlash" placeholder="SBP"
															value="" onkeypress="if (isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"/>
															<span></span> <!-- slash for bp -->
														  
													</div>
													<div class="col-md-4">
														<div class="input-group mb-2 mr-sm-2">
															<input name="bp1" id="bp1" type="text"
															class="form-control border-input bmiInput" placeholder="DBP"
															value="" onkeypress="if (isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"/>
														    <div class="input-group-append">
														      <div class="input-group-text">mm/Hg</div>
														    </div>
														  </div>
													</div>
													
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Peripheral Pulsations <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="peripheralPulsations" name="peripheralPulsations"   class="form-control" value="NAD">
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Heart Size <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="heartSize" name="heartSize"  class="form-control" value="NAD">
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Sounds <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="sounds" name="sounds"  class="form-control" value="NAD">
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Rhythm <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="rhythm" name="rhythm" class="form-control" value="NAD">
													</div>
												</div>
											</div>
										</div>
										
										
									</div>
									
									<!---------------------- Cardio Vascular System ends here ---------------------->
									
									<!---------------------- Respiratory System ---------------------->
									
									<div class="adviceDivMain" id="button7" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Respiratory System</span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton7" value="+" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost7">
										
										<div class="row">
											<div class="col-md-12">
												<div class="form-group row">
													<div class="col-md-3">
														<label for="service" class="col-form-label">Respiratory System <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-9">
														<input type="text" id="respiratorySystem" name="respiratorySystem" value="NAD" class="form-control" maxlength="500">
													</div>
												</div>
											</div>
										</div>
										
										
									</div>
									
									<!---------------------- Respiratory System ends here ---------------------->
									
									<!---------------------- Gastro Intestinal System ---------------------->
									
									<div class="adviceDivMain" id="button8" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Gastro Intestional System</span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton8" value="+" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost8">
										
										<div class="row">
											<div class="col-md-12">
												<div class="form-group row">
													<div class="col-md-3">
														<label for="service" class="col-form-label">Liver Palpable <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-3">
														<select class="form-control" onclick="showLiverPalpableValue(this)" name="liverPalpable" id="liverPalpable">
															<option value="0">Select</option>
															<option value="Yes">Yes</option>
															<option value="No">No</option>
														</select>
													</div>
													<!-- <div class="col-md-6">
														<input type="text" id="liver" name="liver"  class="form-control" >
													</div> -->
													<div class="col-md-6" style="display:none;" id="liverPalpableInput">
														<div class="input-group mb-2 mr-sm-2">
															<input type="text" id="liver" name="liver" class="form-control">
														    <div class="input-group-append" >
														      <div class="input-group-text">cm</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											
											<div class="col-md-12">
												<div class="form-group row">
													<div class="col-md-3">
														<label for="service" class="col-form-label">Spleen Palpable <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-3">
														<select class="form-control" onclick="showLiverPalpableValue1(this)" name="spleenPalpable" id="spleenPalpable">
															<option value="0">Select</option>
															<option value="Yes">Yes</option>
															<option value="No">No</option>
														</select>
													</div>
													<!-- <div class="col-md-9">
														<input type="text" id="spleen" name="spleen" class="form-control" >
													</div> -->
													<div class="col-md-6" style="display:none;" id="spleenPalpableInput">
														<div class="input-group mb-2 mr-sm-2">
															<input type="text" id="spleen" name="spleen" class="form-control">
														    <div class="input-group-append" >
														      <div class="input-group-text">cm</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
										</div>
										
										
									</div>
									
									<!---------------------- Gastro Intestinal System ends here ---------------------->
									
									<!---------------------- Central Nervous System ---------------------->
									
									<div class="adviceDivMain" id="button9" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Central Nervous System</span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton9" value="+" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost9">
										
										<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Higher Mental Function <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="higherMentalFunction" name="higherMentalFunction" class="form-control" value="NAD">
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Speech <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="speech" name="speech" class="form-control" value="NAD">
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Reflexes <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="reflexes" name="reflexes" class="form-control" value="NAD">
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Termors <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<select class="form-control" id="tremors" name="tremors">
															<option value="0">Select</option>
															<option value="nil">Nil</option>
															<option value="fine">Fine</option>
															<option value="coarse">Coarse</option>
														</select>
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Self Balancing Test <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<select class="form-control" id="selfBalancingTest" name="selfBalancingTest">
															<option value="0">Select</option>
															<option value="fairly steady">Fairly steady</option>
														<!-- 	<option value="steady">Steady</option> -->
															<option value="unsteady">Unsteady</option>
														
														</select>
													</div>
												</div>
											</div>
											
										</div>
										
										
									</div>
									
									<!---------------------- Central Nervous System ends here ---------------------->
									
									<!---------------------- Other ---------------------->
									
									<div class="adviceDivMain" id="button10" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Other </span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton10" value="+" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost10">
										
										<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Locomotor System <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="locomotorSystem" name="locomotorSystem" class="form-control" value="NAD">
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Spine <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="spine" name="spine" class="form-control" value="NAD">
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Hemia <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="hernia" name="hernia"  class="form-control" value="NAD">
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Hydrocele <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="hydrocele" name="hydrocele"   class="form-control" value="NAD" >
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Haemorrhoids <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="haemorrhoids" name="haemorrhoids"  class="form-control" value="NAD">
													</div>
												</div>
											</div>
											
											<div id="brestId" class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Breast <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text"  id="breast" name="breast" class="form-control" value="NAD">
													</div>
												</div>
											</div>
											
											
										</div>
										
										
									</div>
									
									<!---------------------- Other ends here ---------------------->
									
									<!---------------------- Vision ---------------------->
									
									<div class="adviceDivMain" id="button3" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Vision</span>
										</div>
										<input class="buttonPlusMinus" tabindex="3" name="" id="relatedbutton3" value="+" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost3">
										
										<table class="table table-hover table-striped table-bordered">
											<thead class="bg-primary">
												<tr>
													<th>Distant Vision <span class="mandate"><sup>&#9733;</sup></span></th>
													<th>R</th>
													<th>L</th>
													<th>Near Vision <span class="mandate"><sup>&#9733;</sup></span></th>
													<th>R</th>
													<th>L</th>
													<th>CP <span class="mandate"><sup>&#9733;</sup></span></th>
													
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>Without Glasses</td>
													<td>
														<select class="form-control" name="distantWithoutGlasses" id="distantWithoutGlasses">
															<option value="0">Select</option>
															<option value="6/6">6/6</option>
														    <option value="6/9">6/9</option>
														    <option value="6/12" >6/12</option>
														    <option value="6/18" >6/18</option>
														    <option value="6/24" >6/24</option>
														    <option value="6/36" >6/36</option>
														    <option value="6/60" >6/60</option>
														</select>
													</td>
													<td>
													<select class="form-control" name="distantWithoutGlassesL" id="distantWithoutGlassesL">
															<option value="0">Select</option>
															<option value="6/6">6/6</option>
														    <option value="6/9">6/9</option>
														    <option value="6/12" >6/12</option>
														    <option value="6/18" >6/18</option>
														    <option value="6/24" >6/24</option>
														    <option value="6/36" >6/36</option>
														    <option value="6/60" >6/60</option>
														</select>
														</td>
														
														<td>Without Glasses</td>
													<td>
														<select class="form-control" name="nearWithoutGlasses" id="nearWithoutGlasses">
															<option value="0">Select</option>
															<option value="N6">N6 </option>
														    <option value="N9">N9</option>
														    <option value="N12">N12</option>
														    <option value="N18">N18</option>
														    <option value="N24">N24</option>
														    <option value="N36" >N36</option>
														</select>
													</td>
													
													
													<td>
														<select class="form-control" name="nearWithoutGlassesL" id="nearWithoutGlassesL">
															<option value="0">Select</option>
															<option value="N6">N6 </option>
														    <option value="N9">N9</option>
														    <option value="N12">N12</option>
														    <option value="N18">N18</option>
														    <option value="N24">N24</option>
														    <option value="N36" >N36</option>
														</select>
													</td>
													
													<td rowspan="2">
														<select class="form-control" name="cpWithoutGlasses" id="cpWithoutGlasses">
															<option value="0">Select</option>
															 <option value="CP II" >CP II</option>
														    <option value="CP III" >CP III</option>
														    <option value="CP IV" >CP IV</option>
														</select>
													</td>
												</tr>
												
												
												
												<tr>
													<td>With Glasses</td>
													<td>
														<select class="form-control" name="distantWithGlasses" id="distantWithGlasses">
															<option value="0">Select</option>
															 <option value="na" >NA</option>
															 <option value="6/6" >6/6</option>
														    <option value="6/9" >6/9</option>
														    <option value="6/12" >6/12</option>
														    <option value="6/18" >6/18</option>
														    <option value="6/24" >6/24</option>
														    <option value="6/36" >6/36</option>
														    <option value="6/60" >6/60</option>
														</select>
													</td>
													<td>
														<select class="form-control" name="distantWithGlassesL" id="distantWithGlassesL">
															<option value="0">Select</option>
															 <option value="na" >NA</option>
															 <option value="6/6" >6/6</option>
														    <option value="6/9" >6/9</option>
														    <option value="6/12" >6/12</option>
														    <option value="6/18" >6/18</option>
														    <option value="6/24" >6/24</option>
														    <option value="6/36" >6/36</option>
														    <option value="6/60" >6/60</option>
														</select>
													</td>
													<td>With Glasses</td>
													<td>
														<select class="form-control"  name="nearWithGlasses" id="nearWithGlasses">
															<option value="0">Select</option>
															 <option value="na" >NA</option>
															 <option value="N6" >N6</option>
														    <option value="N9" >N9</option>
														    <option value="N12" >N12</option>
														    <option value="N18" >N18</option>
														    <option value="N24" >N24</option>
														    <option value="N36" >N36</option>
														</select>
													</td>
													
														<td>
														<select class="form-control"  name="nearWithGlassesL" id="nearWithGlassesL">
															<option value="0">Select</option>
															 <option value="na" >NA</option>
															 <option value="N6" >N6</option>
														    <option value="N9" >N9</option>
														    <option value="N12" >N12</option>
														    <option value="N18" >N18</option>
														    <option value="N24" >N24</option>
														    <option value="N36" >N36</option>
														</select>
													</td>
													
												</tr>
											</tbody>
										</table>
									</div>
									
									<!---------------------- Vision ends here ---------------------->
									
									
									<!---------------------- Hearing ---------------------->
									
									<div class="adviceDivMain" id="button4" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Hearing</span>
										</div>
										<input class="buttonPlusMinus" tabindex="4" name="" id="relatedbutton4" value="+" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost4">
										
										<table class="table table-hover table-striped table-bordered">
											<thead class="bg-primary">
												<tr>
													<th></th>
													<th>R</th>
													<th>L</th>
													<th>Both</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td class="width330">FW <span class="mandate"><sup>&#9733;</sup></span></td>
													<td>
														<div class="form-row from-inline m-l-0">
															<input type="text" name="fwR" id="fwR" onkeypress="if (isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"class="form-control width100">
															<input type="text" name="fwr" id="fwr"  value="Cms"class="form-control width50" readonly/>
														</div>
													</td>
													<td>
														<div class="form-row from-inline m-l-0">
															<input type="text" name="fwL" id="fwL" onkeypress="if (isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" class="form-control width100">
															<input type="text" name="fwl" id="fwl" class="form-control width50" value="Cms" readonly/>
														</div>
													</td>
													<td>
														<div class="form-row from-inline m-l-0">
															<input type="text" name="fwBoth" id="fwBoth" onkeypress="if (isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"class="form-control width100">
															<input type="text" name="fwboth" id="fwboth" class="form-control width50" value="Cms" readonly/>
														</div>
													</td>
												</tr>
												
												<tr>
													<td class="width330">CV <span class="mandate"><sup>&#9733;</sup></span></td>
													<td>
														<div class="form-row from-inline m-l-0">
															<input type="text" name="cvR" id="cvR" onkeypress="if (isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" class="form-control width100">
															<input type="text" name="cvr" id="cvr" class="form-control width50" value="Cms" readonly/>
														</div>
													</td>
													<td>
														<div class="form-row from-inline m-l-0">
															<input type="text" name="cvL" id="cvL" onkeypress="if (isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" class="form-control width100">
															<input type="text" name="cvl" id="cvl" class="form-control width50" value="Cms" readonly/>
														</div>
													</td>
													<td>
														<div class="form-row from-inline m-l-0">
															<input type="text" name="cvBoth" id="cvBoth" onkeypress="if (isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" class="form-control width100">
															<input type="text" name="cvboth" id="cvboth" class="form-control width50" value="Cms" readonly/>
														</div>
													</td>
												</tr>
												
												<tr>
													<td class="width330">Tympanic Membrance Intact <span class="mandate"><sup>&#9733;</sup></span></td>
													<td>
														<select class="form-control width150" id="tmR" name="tmR">
															<option value="0">Select</option>
															<option value="Intact">Yes</option>
															<option value="Not Intact">No</option>
														</select>
													</td>
													<td>
														<select class="form-control width150" id="tmL" name="tmL">
															<option value="0">Select</option>
															<option value="Intact">Yes</option>
															<option value="Not Intact">No</option>
														</select>
													</td>
													<td>
														
													</td>
												</tr>
												<tr>
													<td class="width330">Mobility Valsalva <span class="mandate"><sup>&#9733;</sup></span></td>
													<td>
														<select class="form-control" id="mobilityR" name="mobilityR">
														<option>Select</option>
														<option value="+ve">+ve</option>
														<option value="-ve">-ve</option>
														</select>
													</td>
													
													<td>
														<select class="form-control" id="mobilityL" name="mobilityL">
														<option>Select</option>
														<option value="+ve">+ve</option>
														<option value="-ve">-ve</option>
														</select>
													</td>
													
													<!-- <td>
														<input type="text" id="mobilityL" name="mobilityL" class="form-control width150">
													</td> -->
													<td>
														
													</td>
												</tr>
												
											</tbody>
										</table>
										
										<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">Nose, Throat &amp; Sinuses <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" type="text" id="noseThroatSinuses" name="noseThroatSinuses"  class="form-control" value="NAD">
													</div>
												</div>
											</div>
											<div class="w-100"></div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">Audiometry Record <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<select class="form-control" id="audiometryRecord" name="audiometryRecord" onChange="return displayTextArea(this);">
														<option value="0">Select</option>
														<option value="NA">NA</option>
														<option value="NAD">NAD</option>
														<option value="Others">Others</option>
														
														</select>
													</div>
												</div>
											</div>
											<div class="col-md-4" style="display:none;" id="audiometryRecordForDisplay">
												<div class="form-group row">
													
													<div class="col-12">
														<textarea class="form-control" id="audiometryRecordForOther" name="audiometryRecordForOther"></textarea>
													</div>
												</div>
											</div>
										</div>
									</div>
									
									<!---------------------- Hearing ends here ---------------------->
									
									
									
									
									<!---------------------- Gynaecological Exam ---------------------->
									<div id="gynaecologicalExam" style="display:none;">
									<div class="adviceDivMain" id="button14" onclick="showhide(this.id)" >
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Gynaecological Exam </span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton14" value="+" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost14">
										
										<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Menstural History <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="mensturalHistory" name="mensturalHistory" class="form-control" >
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">LMP <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<select class="form-control" id="lmpSelect" name="lmpSelect">
														<option value="Exact Date">Exact Date</option>
														<option value="approximate Date">approximate Date</option>
														</select>
													</div>
													
													
												</div>
											</div>
											
											<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
														<div class="dateHolder">
														<input type="text" id="lMP" name="lMP" class="form-control noFuture_date2" placeholder="DD/MM/YYYY" >
														</div>
													</div>
											</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Nos of Pregnancies <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="nosOfPregnancies" name="nosOfPregnancies" class="form-control" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;">
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Nos of Abortions <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="nosOfAbortions" name="nosOfAbortions" class="form-control" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;">
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Nos of Children <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="nosOfChildren" name="nosOfChildren" class="form-control" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;">
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Date of Last Confinement <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<div class="dateHolder">
														<input type="text" id="childDateOfLastConfinement" name="childDateOfLastConfinement" class="form-control calDate" placeholder="DD/MM/YYYY"  >
														</div>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Vaginal Discharge <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="vaginalDischarge" name="vaginalDischarge" class="form-control" value="NAD">
													</div>
												</div>
											</div>
											<!-- <div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Date of Last Confinement</label>
													</div>
													<div class="col-md-7">
														<div class="dateHolder">
														<input type="text" id="vaginalDateOfLastConfinement" name="vaginalDateOfLastConfinement" class="form-control calDate" >
														</div>
													</div>
												</div>
											</div> -->
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">USG Abdomen <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="usgAbdomen" name="usgAbdomen" class="form-control" value="NAD">
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Prolapse <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="prolapse" name="prolapse" class="form-control" value="NAD">
													</div>
												</div>
											</div>
										</div>
										
									</div>
									</div>
									<!---------------------- Gynaecological ends here ---------------------->
									
									<!---------------------- Immunisation Exam ---------------------->
									
									<!-- <div class="adviceDivMain" id="button15" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Immunization Status</span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton15" value="+" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost15">
										
										<table class="table table-striped table-bordered table-hover">
											<thead>
												<tr>
													<th>Immunization Name</th>
													<th>Immunization Date</th>
													<th>Add</th>
													<th>Delete</th>
												</tr>
											</thead>
											<tbody  id="immunisationStatusGrid">
												<tr>
													<td>
													<input type="text" class="form-control" name="tt" id="tt" value="TT" readonly="readonly"/>
													</td>
													<td>
														<div class="dateHolder">
															<input class="form-control noFuture_date" name="immunisationDateTT" id="immunisationDateTT"/>
														</div>
													</td>
													<td><button name="Button" type="button" class="buttonAdd btn btn-primary noMinWidth" button-type="add"> </button></td>
													<td><button name="Button" type="button" class="buttonAdd btn btn-danger noMinWidth" button-type="delete"> </button></td>
												</tr>
												<tr>
													<td>
													<input type="text" class="form-control" name="tab" id="tab"value="TAB" readonly="readonly"/>
													</td>
													<td>
														<div class="dateHolder">
															<input class="form-control noFuture_date " id="immunisationDateTab" name="immunisationDateTab"/>
														</div>
													</td>
													<td><button name="Button" type="button" class="buttonAdd btn btn-primary noMinWidth" button-type="add" onClick="return addImmunisationStatus();"> </button></td>
													<td><button name="Button" type="button" class="buttonAdd btn btn-danger noMinWidth" button-type="delete" readonly> </button></td>
												</tr>
											</tbody>
										</table>
										
									</div> -->
									
									<!---------------------- Immunisation ends here ---------------------->
									
									<!---------------------- Immunisation Exam ---------------------->
									
									<div class="adviceDivMain" id="button15" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Certificate For Commutation of Pension</span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton15" value="+" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost15">
										<div class="row">
											<div class="col-md-12">
											<label class="col-form-label"> I have carefully examined</label>
											</div>
											
											<div class="col-md-3">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">No</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="mensturalHistory" name="mensturalHistory" class="form-control" >
													</div>
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Rank</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="mensturalHistory" name="mensturalHistory" class="form-control" >
													</div>
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Name</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="mensturalHistory" name="mensturalHistory" class="form-control" >
													</div>
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Unit</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="mensturalHistory" name="mensturalHistory" class="form-control" >
													</div>
												</div>
											</div>
											<div class="col-md-12">
											<label class="col-form-label"> and I am of the opinion that the individual is in good bodily health and has the prospect an average duration of life. Commutation of pension in his/her case is therefore, recommended for acceptance</label>
											</div>
										</div>
										
									</div>
									
									<!---------------------- Immunisation ends here ---------------------->
									
									<!--  -->
									<div class="clearfix"></div>
									
									<div class="row m-t-20">
										<div class="col-12 text-right">
											
											<input type="submit" id="clicked" class="btn btn-primary"  value="Save"/>
											<input type="button" id="reset" class="btn btn-danger" onClick="" value="Reset"/>		
										 
										</div>
									</div>
										
									<div class="clearfix"></div>

								</div>
								<%-- </form:form> --%>
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

	<!-- END wrapper -->
	
	
	<script type="text/javascript">
	  $(document).ready(function() {
        
        var data = ${
            data
        };
		 
        
        $('#serviceNo').val(data.data[0].serviceNo);
		$('#employeeName').val(data.data[0].patientName);
		$('#age').val(data.data[0].age+"/"+data.data[0].gender);

		$('#rank').val(data.data[0].rankName);
		$('#meType').val(data.data[0].meTypeName);
		$('#gender').val(data.data[0].gender);
		$('#patientId').val(data.data[0].patientId);
		$('#departmentId').val(data.data[0].departmentId);
		$('#dob').val(data.data[0].dateOfBirth);
		
		$('#totalService').val(data.data[0].totalService);
		$('#unitOrSlip').val(data.data[0].unit);
		$('#branchOrTrade').val(data.data[0].tradeBranch);
		$('#dateOfExam').val(data.data[0].dateOfExam);
		$('#opdPatientDetailId').val(data.data[0].opdPatientDetailId);
		$('#medCategory').val(data.data[0].medicalCategory);
		$('#doeORDoc').val(data.data[0].serviceJoinDate);
		
		$('#medicalCompositeName').val(data.data[0].medicalCategory);
		$('#medicalCompositeDate').val(data.data[0].medicalCategoryDate);
		$('#medicalCompositeNameValue').val(data.data[0].medicalCompositeNameValue);
		 $('#authority').val(data.data[0].authority);
		 $('#place').val(data.data[0].place);
		 $('#dateAME').val(data.data[0].dateAME);
		 $('#genderId').val(data.data[0].genderId);
        $('#checkupDate').val(today);
        
		getDiagnosisValue();
		masMedicalCategoryList();
    });
    
	 
	
	</script>
<script>
function showhide(buttonId)
{
	 if(buttonId=="button1"){
				test('related'+buttonId,"newpost1");					
	 }else if(buttonId=="button2"){
				test('related'+buttonId,"newpost2");
	 }else if(buttonId=="button3"){
				test('related'+buttonId,"newpost3");
	 }else if(buttonId=="button4"){
				test('related'+buttonId,"newpost4");
	 }else if(buttonId=="button5"){
				test('related'+buttonId,"newpost5");
	 }else if(buttonId=="button6"){
				test('related'+buttonId,"newpost6");
	 }else if(buttonId=="button7"){
				test('related'+buttonId,"newpost7");
	 }else if(buttonId=="button8"){
				test('related'+buttonId,"newpost8");
	 }else if(buttonId=="button9"){
				test('related'+buttonId,"newpost9");
	 }else if(buttonId=="button10"){
				test('related'+buttonId,"newpost10");
	 }else if(buttonId=="button11"){
				test('related'+buttonId,"newpost11");
	 }else if(buttonId=="button12"){
				test('related'+buttonId,"newpost12");
	 }else if(buttonId=="button13"){
				test('related'+buttonId,"newpost13");
	 }else if(buttonId=="button14"){
			test('related'+buttonId,"newpost14");
	 }else if(buttonId=="button15"){
			test('related'+buttonId,"newpost15");
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
	var arryInvestigation = new Array();
	$(document).ready(
    		function() {
    			var radioValue = 2; 
    			invesRadio=radioValue;
    	var pathname = window.location.pathname;
    	var accessGroup = "MMUWeb";

    	var url = window.location.protocol + "//"
    			+ window.location.host + "/" + accessGroup
    			+ "/opd/getIinvestigationList";
    	$.ajax({
    		type : "POST",
    		contentType : "application/json",
    		url : url,
    		data : JSON.stringify({
    			'employeeId' : <%= userId %>,
    			'mainChargeCode':radioValue,
    		}),
    		dataType : 'json',
    		timeout : 100000,
    		success : function(res)
    		{
    			var data = res.InvestigationList;
    			for(var i=0;i<data.length;i++){
    				var investigationId= data[i].investigationId;
    				var investigationName = data[i].investigationName;
    				var a=investigationName+"["+investigationId +"]"
    				 arryInvestigation.push(a);
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
    	});
    }); 
        
	$(document).ready(function() {
	    /* if (typeof element !== "undefined" && element.value == '') {
	    } */
	    var data = ${
	        data
	    };
	    if (data.data[0].serviceNo != null) {
	        document.getElementById('serviceNo').value = data.data[0].serviceNo;
	    }
	    if (data.data[0].visitId != null) {
	        document.getElementById('visitId').value = data.data[0].visitId;
	    }
	    if (data.data[0].patientId != null) {
	        document.getElementById('patientId').value = data.data[0].patientId;
	    }
	    if (data.data[0].empName != null) {
	        document.getElementById('empName').value = data.data[0].empName;
	    }
	    if (data.data[0].age != null) {
	        document.getElementById('age').value = data.data[0].age;
	    }
	    if (data.data[0].rank != null) {
	        document.getElementById('rank').value = data.data[0].rank;
	    }
	    if (data.data[0].tradeBranch != null) {
	        document.getElementById('branchTrade').value = data.data[0].tradeBranch;
	    }
	    if (data.data[0].totalService != null) {
	        document.getElementById('totalService').value = data.data[0].totalService;
	    }
	    if (data.data[0].unit != null) {
	        document.getElementById('unit').value = data.data[0].unit;
	    }
	    if (data.data[0].dob != null) {
	        document.getElementById('dob').value = data.data[0].dob;
	    }
	  
	  
	    //getMBPreAssesDetailsData();
	    //getMBPreAssesDetailsInvestigationData();
	});
	
	
	$('#clicked').click(function() {
        var pathname = window.location.pathname;
        var accessGroup = "MMUWeb";

        var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/saveTranscriptionData";
          
       //////////////Disease,Wound Or Injury Details JSON ///////////////////
    	var tableDataInvResult = [];  
    	var dataInvDeatils='';
    	var idforTreat='';
   	 	$('#diseaseWoundInjuryDetailsGrid tr').each(function(i, el) {
		idforTreat= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
		if(document.getElementById(idforTreat).value!= '' && document.getElementById(idforTreat).value != undefined)
   		{
   			var $tds = $(this).find('td')
  			var icdIdWillness = $(this).find("td:eq(0)").find("input:eq(1)").val();
   			var stDate = $(this).find("td:eq(1)").find("input:eq(0)").val();
   			var stPlace = $(this).find("td:eq(2)").find("input:eq(0)").val();
   			var treatedPlace = $(this).find("td:eq(3)").find("input:eq(0)").val();
   			var fromDate = $(this).find("td:eq(4)").find("input:eq(0)").val();
   			var toDate = $(this).find("td:eq(5)").find("input:eq(0)").val();
   		
			dataInvDeatils={
			'icdIdWillness' : icdIdWillness,
			'stDate':stDate,
			'stPlace' : stPlace,
			'treatedPlace' : treatedPlace,
			'fromDate' : fromDate,
			'toDate' : toDate,
			
			} 
			tableDataInvResult.push(dataInvDeatils);
    	}
	 });	
   	 	
   	 //////////////Service Details JSON ///////////////////
    	var tableDataService = [];  
    	var dataInvSerDeatils='';
    	var idforSDetails='';
   	 	$('#serviceDetailsIdGrid tr').each(function(i, el) {
   	 	idforSDetails= $(this).find("td:eq(1)").find("input:eq(0)").attr("id") 
		if(document.getElementById(idforSDetails).value!= '' && document.getElementById(idforSDetails).value != undefined)
   		{
			var $tds = $(this).find('td')
  			var fromDate = $tds.eq(1).find(":input").val();
   			var toDate =  $tds.eq(2).find(":input").val();
   			var place = $tds.eq(3).find(":input").val();
   			var pf =  $tds.eq(4).find(":input").val();
   			dataInvSerDeatils={
			'fromDate' : fromDate,
			'toDate':toDate,
			'place' : place,
			'pf' : pf,
			
			} 
			tableDataService.push(dataInvSerDeatils);
    	}
	 });
   	 	
        var dataJSON = {

            'visitId': $('#visitId').val(),
            'patientId': $('#patientId').val(),
            'totalTeeth': $('#totalNoOfTeath').val(),
            'totalDefectiveTeeth': $('#totalNoOfDefective').val(),
            'totalNoDentalPoint': $('#totalNoOfDentalPoints').val(),
            'missingTeeth': $('#missing').val(),
            'unsaveableTeeth' :$('#unSavable').val(),
            'conditionofgums': $('#conditionOfGums').val(),
            'dentalOfficer': $('#dentalOffier').val(),
            'dentalCheckupDate': $('#checkupDate').val(),
            'remarks': $('#remarks').val(),
            'height': $('#height').val(),
            'idealweight': $('#idealWeight').val(),
            'weight': $('#weight').val(),
            'variationinWeight': $('#overWeight').val(),
            'bmi': $('#bmi').val(),
            'bodyfat': $('#bodyFat').val(),
            'waist': $('#height').val(),
            'hips': $('#hip').val(),
            'whr': $('#whr').val(),
            'skin': $('#skinFoldExpansion').val(),
            'chestfullexpansion': $('#chestFullExpansion').val(),
            'rangeofexpansion': $('#rangeOfExpansion').val(),
            'sportman': $('#sportsman').val(),
            'withoutGlassesLDistant': $('#distantWithoutGlasses').val(),
            'withoutGlassesLNearvision': $('#nearWithoutGlasses').val(),
            'withGlassesLDistant': $('#distantWithGlasses').val(),
            'withGlassesLNearvision': $('#nearWithGlasses').val(),
            //'withGlassesLNearvision': $('#height').val(),
            'earHearingRfw': $('#fwR').val(),
            'earHearingLfw': $('#fwL').val(),
            'earHearingBothFw': $('#fwBoth').val(),
            'hearingRcv': $('#cvR').val(),
            'hearingLcv': $('#cvL').val(),
            'hearingBothCv': $('#cvBoth').val(),
            'tympanicr': $('#tmR').val(),
            'tympanicl': $('#tmL').val(),
            'mobilityl': $('#mobilityL').val(),
            'mobilityr': $('#mobilityR').val(),
            'noseThroatSinuses': $('#noseThroatSinuses').val(),
            'audiometryRecord': $('#audiometryRecord').val(),
            'pulseRates': $('#pulse').val(),
            'bpSystolic': $('#bp').val(),
            'bpDiastolic': $('#bp1').val(),
            'peripheralPulsations': $('#peripheralPulsations').val(),
            'heartSize': $('#heartSize').val(),
            'sounds': $('#sounds').val(),
            'rhythm': $('#rhythm').val(),
            'respiratorySystem': $('#respiratorySystem').val(),
            'liver': $('#liver').val(),
            'spleen': $('#spleen').val(),
            'higherMentalFunction': $('#higherMentalFunction').val(),
            'speech': $('#speech').val(),
            'reflexes': $('#reflexes').val(),
            'tremors': $('#tremors').val(),
            'selfBalancingTest': $('#selfBalancingTest').val(),
            'locomoterSystem': $('#locomotorSystem').val(),
            'spine': $('#spine').val(),
            'herniaMusic': $('#hernia').val(),
            'hydrocele': $('#hydrocele').val(),
            'hemorrhoids': $('#haemorrhoids').val(),
            'breasts': $('#breast').val(),
            'listOfIllnessInjury':tableDataInvResult,
            'serviceDetails':tableDataService,
            'hospitalId':<%=hospitalId%>,
  			 'userId':<%= userId %>,
           
        }
        $("#clicked").attr("disabled", true);
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: url,
            data: JSON.stringify(dataJSON),
            dataType: 'json',
            success: function(msg) {
            	console.log(msg)
                if (msg.status == 1)
                {
                   var Id= $('#visitId').val()
                   window.location.href ="mbTranscriptionSubmit16?visitId="+Id+"";
                } 
                else if(msg.status == 0)
                {
                 $("#clicked").attr("disabled", false);	
                 alert(msg.msg)	
                }	
                else
                {
                	$("#clicked").attr("disabled", false);
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

    });
	
	 $(document).ready(function() {
         $('#weight').change(
             function() {

                 var a = document.getElementById("idealWeight").value;
                 var b = document.getElementById("weight").value;

                 if (a > b) {
                     var sub = a - b;
                     var cal = sub * 100 / a
                     var n = cal.toFixed(2);
                     $('#overWeight').val(n);

                 } else {
                     var eadd = b - a;
                     var cal1 = eadd * 100 / b
                     var n1 = cal1.toFixed(2);
                     $('#overWeight').val("-" + n1);
                 }

             });
     });
	 
	 function idealWeight2() {
			var pathname = window.location.pathname;
			var accessGroup = "MMUWeb";

			var url = window.location.protocol + "//"
					+ window.location.host + "/" + accessGroup
					+ "/opd/getIdealWeight";
			var dataJSON={
					  'height':$('#height').val(),
		      		  'age':$('#ageForPatient').val(),
					  'genderId':$('#genderId').val(),
			}
			$.ajax({
				type : "POST",
				contentType : "application/json",
				url : url,
				data : JSON.stringify(dataJSON),
				dataType : 'json',
				timeout : 100000,
				success : function(data) {
					//console.log("SUCCESS: ", data);
					
				   	   	   if (data.status == 1) {
					//var data = data;
					//alert("value is "+data.data[0].idealWeight);
					$('#idealWeight').val(data.data[0].idealWeight);
					$('#idealWeight').attr("disabled","disabled");
		           
					
				    }
				   	   	   else
				   	   		   {
				   	   		   	alert("Ideal Weight Not Configured")
				   	   		   	$('#idealWeight').val();
								$('#idealWeight').removeAttr("disabled");
				   	   		   }
					
					

				},
				error : function(e) {

					//console.log("ERROR: ", e);

				},
				done : function(e) {
					//console.log("DONE");
					alert("success");
					var datas = e.data;
				}
			});

		 }
		
		function checkBMI() {
			var a = document.getElementById("weight").value;
			var b = document.getElementById("height").value;
			var c=b/100;
			var d=c*c;
			var sub = a/d;
			$('#bmi').val(parseFloat(Math.round(sub * 100) / 100).toFixed(2));
			
		}
	 
		 function checkVaration()  {

		     	var a = document.getElementById("idealWeight").value;
		 		var b = document.getElementById("weight").value;
		       if(a!=null && b!=null && a!="" && b!="")
		        {	  
		 		if (parseFloat(a) > parseFloat(b)) {
		 			var sub = a - b;
		 			var cal = sub * 100 / a
		 			var n = cal.toFixed(2);
		 			$('#overWeight').val("-" + n);

		 		} else {
		 			var eadd = b - a;
		 			var cal1 = eadd * 100 / b
		 			var n1 = cal1.toFixed(2);
		 			$('#overWeight').val("+" +n1);
		 		}
		        }
			}
		getAFMSF3BInvestigationForMOOrMA();
	    getMBPreAssesDetailsData();
		getImmunisationHistory();
		
		
  </script>
</body>

</html>