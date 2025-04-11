<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Indian Coast Guard</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/medicalexam.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newOpd.js"></script> --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/uploaddig.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/commonformodal.js"></script>
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

<script type="text/javascript">
var labRadioValue=resourceJSON.mainchargeCodeLab;
var imagRadioValue=resourceJSON.mainchargeCodeRadio;
</script>
<script type="text/javascript">
$j(document).ready(function(){
	$j('#lab_radio').val(labRadioValue);
	$j('#imag_radio').val(imagRadioValue);
	$j('#labImaginId').val(labRadioValue);
});

</script>
<style>
.hisDivHide{
	display:block ;
}
</style>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">


		<div class="content-page noSideMen">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">Medical Exam Approval</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
							<form:form name="submitMedicalExamByMAForm18" id="submitMedicalExamByMAForm18" method="post"  enctype='multipart/form-data'
									action="${pageContext.request.contextPath}/medicalexam/submitMedicalExamByMAForm18" autocomplete="on">
								<div class="card-body">
									<input type="hidden" name="hospitalId" id="hospitalId" value="<%=hospitalId%>"/>
									<input type="hidden" name="userId" id="userId" value="<%=userId%>"/>
									 <input type="hidden" name="visitId" id="visitId" value="${visitId}"/>
									 <input type="hidden" name="patientId" id="patientId" value=""/>	
									 <input type="hidden" name="disabilityBeforeJoiningIdValue" id="disabilityBeforeJoiningIdValue" value=""/>	
									 <input type="hidden" name="witnessOfEmployee" id="witnessOfEmployee" value=""/>	
									  <input type="hidden" name="signatureOfIndividualId" id="signatureOfIndividualId" value=""/>
									  <input type="hidden" name="ageForPatient" id="ageForPatient"
										value="${age}" />
									  <input type="hidden" name="age" id="age" value=""/>
									   <input type="hidden" name="meAgeForOn" id="meAgeForOn" value=""/>
									<input type="hidden" name="saveInDraft" id="saveInDraft" value="draftRMo18"/>
									<input type="hidden" name="opdPatientDetailId"
										id="opdPatientDetailId" value="" />
									<input type="hidden" name="referTo" id="referTo" value="E" />
									<input type="hidden" name="genderId" id="genderId" value="" />
									<input type="hidden" name="designationIdValue" id="designationIdValue" value=""/>	
									<input type="hidden"  value='${approvalFlag}' name="approvalFlag" id="approvalFlag"/>
									<input type="hidden"  value='${menustatus}' name="menustatus" id="menustatus"/>
									
									<input type="hidden" name="radioInvAndImaValue"id="radioInvAndImaValue" value="Lab" />
										<input type="hidden" name="totalLengthDigiFile"
										id="totalLengthDigiFile" value="0" />
									<input type="hidden" name="totalLengthDigiFileRefer"
										id="totalLengthDigiFileRefer" value="0" />
									
									<input  name="obsistyMark" id="obsistyMark" type="hidden" value="" />
									<input  name="labImaginId" id="labImaginId" type="hidden" value="" />	
										<input  name="countForCategory" id="countForCategory" type="hidden" value="1" />
										<input type="hidden" name="resultIdSpecialistOpinion" id="resultIdSpecialistOpinion" />
										<input type="hidden" name="fitFlagCheckValue" id="fitFlagCheckValue" />
										<input type="hidden" name="currentObjectForResultOffLineDate" id="currentObjectForResultOffLineDate" value=""/>
										<input type="hidden" name="currentObjectForResultOffLinenumber" id="currentObjectForResultOffLinenumber" value=""/>
										<input  name="obsistyCheckAlready" id="obsistyCheckAlready" type="hidden" value="" />
									<input type="hidden"  name="rankId" value="" id="rankId" />
									 <input type="hidden"  name="unitIdOn" value="" id="unitIdOn" />
									 <input type="hidden"  name="branchOrTradeIdOn" value="" id="branchOrTradeIdOn" />
									
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
									<div class="row m-b-10">
									<div class="col-md-3" id="originalDoc" style="display:none; ">
											<!-- <a href="javascript:void(0)" onClick="return showImmunizationTemplateMe('aa');"  class="btn btn-primary btn-block">View Original Document</a> -->
										</div>
									</div>
									<br/>
								<div class="row">
										<div class="row col-12">
											
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
															<input type="text"  name="dateOfReport" id="dateOfReport"class="calDate form-control" value="" placeholder="DD/MM/YYYY" maxlength="10">
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
															<input type="text"  name="dateOfRelease" id="dateOfRelease" class="calDate form-control" placeholder="DD/MM/YYYY" maxlength="10">
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
														<input type="text" class="form-control" name="employeeName" id="employeeName" readonly/>
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
														<input type="text" name="unitOrSlip" id="unitOrSlip"  class="form-control" readonly/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-6">
														<label for="service" class="col-form-label">Service</label>
													</div>
													<div class="col-md-6">
														<select class="form-control" id="serviceOfEmployee" name="serviceOfEmployee">
															<!-- <option>Select</option>
															<option>Army</option>
															<option>Navy</option>
															<option>Air Force</option> -->
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
														<textarea class="form-control" name="identificationMarks1" id="identificationMarks1" maxlength="200"></textarea>
													</div>
												</div>
												<div class="form-group row">
													<div class="col-md-3 text-right">
														<label for="service" class="col-form-label">2.</label>
													</div>
													<div class="col-md-9">
														<textarea class="form-control" name="identificationMarks2" id="identificationMarks2" maxlength="200"></textarea>
													</div>
												</div>
											</div>
										</div>
										
										
										
										
										
										
									<!---------------------- Service Details ---------------------->
									
									<div class="adviceDivMain" id="button12" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Service Details</span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton12" value="-" onclick="showhide(this.id)" type="button">
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
													<th>Place/Ship</th>
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
															<input type="text" name="serviceDetailFrom" id="serviceDetailFrom"class="input_date  form-control" placeholder="DD/MM/YYYY" maxlength="10" >
															<input type="hidden"  name="serviceDetailId" id="serviceDetailId" value=""/>
														</div>
													</td>
													<td>
														<div class="dateHolder">
															<input type="text"  name="serviceDetailTo" id="serviceDetailTo" class="input_date  form-control" placeholder="DD/MM/YYYY" maxlength="10">
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
						
														<button class="btn btn-danger noMinWidth" name="delete" value="" id="deleteServiceDetail" button-type="delete"  onclick="removeRowInvestigation(this);"  ></button>
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
														<textarea class="form-control" rows="2"  name="particularsOfPreviousService" id="particularsOfPreviousService" maxlength="200"></textarea>
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
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton13" value="-" onclick="showhide(this.id)" type="button">
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
														
 										 			<div class="autocomplete forTableResp">
								 						<!-- <input autocomplete="off" type="text" class="form-control" name="IllnessWoundInjury" id="IllnessWoundInjury" onblur="fillDiagnosisComboF18(this.value,this);" onKeyPress="autoCompleteCommonMe(this,5);" onKeyUp="autoCompleteCommonMe(this,5);"placeholder="Diagnosis" value="" /> -->
								 						<input autocomplete="off" type="text" class="form-control" name="IllnessWoundInjury" id="IllnessWoundInjury" onKeyUp="getNomenClatureList(this,'fillDiagnosisComboF18','opd','getIcdListByName','diagnosisMe18');" placeholder="Diagnosis" value="" />
								 						<input type="hidden" id="icdDiagnaosis" name="icdDiagnaosis" value=""/>
								 						<input type="hidden" id="patientDiagnosisId" name="patientDiagnosisId" value=""/>
								 						<div id="diseaseWoundInjuryDetailsGridDiv" class="autocomplete-itemsNew"></div>
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
															<input type="text"  name="approximatePeriodsTreatedFrom" placeholder="DD/MM/YYYY"  id="approximatePeriodsTreatedFrom" class="input_date  form-control">
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
															<input type="hidden" id="armedForcesPatientDiagnosisId" name="armedForcesPatientDiagnosisId" value=""/>
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
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton14" value="-" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost14">
										
										<div class="row m-b-10">
											<div class="col-md-12">
												<label for="service" class="col-form-label">I certify that I have answered as fully as possible all the questions about my service and personal history and that the information given is to the best of my knowledge.</label>
											</div>
											
											
											<div class="w-100"></div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Service No.</label>
													</div>
													<div class="col-md-7">
														<input type="text" name="serviceNoForEmployee" id="serviceNoForEmployee" class="form-control" readonly/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Rank</label>
													</div>
													<div class="col-md-7">
														<input type="text" name="rankForEmployee" id="rankForEmployee" class="form-control" readonly/>
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
														<input type="text" name="dateOfWitness" id="dateOfWitness" class="calDate form-control" value="" placeholder="DD/MM/YYYY" />
														</div>
														
													</div>
												</div>
											</div>
											
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Signature of Witness</label>
													</div>
													<div class="col-md-7">
														<input type="text" name="signatureOfWitness" id="signatureOfWitness"class="form-control" readonly/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Signature of Individual</label>
													</div>
													<div class="col-md-7">
														<input type="text" name="signatureOfIndividual" id="signatureOfIndividual" class="form-control" readonly />
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
										<input class="buttonPlusMinus" tabindex="1" name="" id="relatedbutton1" value="-" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost1">
										<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Total No. of Teeth <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text"  name="totalNoOfTeath" id="totalNoOfTeath"  maxlength="4" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Total No. of Defective Teeth <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" name="totalNoOfDefective" id="totalNoOfDefective" onblur="calculateDentalPointAndDefectiveTeeth();" maxlength="4" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"class="form-control" />
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Total No. of Dental Points <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" name="totalNoOfDentalPoints" id="totalNoOfDentalPoints"  onblur="calculateDentalPointAndDefectiveTeeth();" maxlength="4" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control" />
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
																<div class="form-check form-check-inline  cusCheck">
																  <input class="form-check-input" type="checkbox" name="urMChecked" id="urMChecked8" value="8" onClick="return countMissingAndUnsavableValue(this);"/>
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="8" name="urInput8" id="urInput8" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="7" name="urMChecked" id="urMChecked7" onClick="return countMissingAndUnsavableValue(this);"/>
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="7" name="urInput7" id="urInput7" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="6" name="urMChecked" id="urMChecked6" onClick="return countMissingAndUnsavableValue(this);"/>
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="6" name="urInput6" id="urInput6" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="5" name="urMChecked" id="urMChecked5" onClick="return countMissingAndUnsavableValue(this);"/>
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="5" name="urInput5" id="urInput5"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="4" name="urMChecked" id="urMChecked4" onClick="return countMissingAndUnsavableValue(this);"/>
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="4" name="urInput4" id="urInput4" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="3" name="urMChecked" id="urMChecked3" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="3" name="urInput3" id="urInput3"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="2" name="urMChecked" id="urMChecked2" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="2" name="urInput2" id="urInput2" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="1"  name="urMChecked" id="urMChecked1" onClick="return countMissingAndUnsavableValue(this);">
																 <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="1" name="urInput1" id="urInput1" readonly>
																</div>
															</td>
														</tr>
														<tr id="ulRow">
															<td>UL</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox"  value="8"  name="ulMChecked" id="ulMChecked8" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="8" name="ulInput8" id="ulInput8" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="7"  name="ulMChecked" id="ulMChecked7" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="7" name="ulInput7" id="ulInput7" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="6" name="ulMChecked" id="ulMChecked6" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="6" name="ulInput6" id="ulInput6"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="5" name="ulMChecked" id="ulMChecked5" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="5" name="ulInput5" id="ulInput5" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="4" name="ulMChecked" id="ulMChecked4" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="4" name="ulInput4" id="ulInput4" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="3" name="ulMChecked" id="ulMChecked3" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="3" name="ulInput3" id="ulInput3"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="2" name="ulMChecked" id="ulMChecked2" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="2" name="ulInput2" id="ulInput2"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="1" name="ulMChecked" id="ulMChecked1" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="1" name="ulInput1" id="ulInput1"  readonly>
																</div>
															</td>
														</tr>
														<tr>
															<td>LL</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="8" name="llMChecked" id="llMChecked8" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="8" name="llInput8" id="llInput8"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="7" name="llMChecked" id="llMChecked7" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="7" name="llInput7" id="llInput7"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="6" name="llMChecked" id="llMChecked6" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="6" name="llInput6" id="llInput6" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="5" name="llMChecked" id="llMChecked5" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="5" name="llInput5" id="llInput5"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="4" name="llMChecked" id="llMChecked4" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="4" name="llInput4" id="llInput4"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="3" name="llMChecked" id="llMChecked3" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="3" name="llInput3" id="llInput3"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="2" name="llMChecked" id="llMChecked2" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="2" name="llInput2" id="llInput2" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="1" name="llMChecked" id="llMChecked1" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="1" name="llInput1" id="llInput1"  readonly>
																</div>
															</td>
														</tr>
														<tr>
															<td>LR</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="8" name="lrMChecked" id="lrMChecked8" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="8"  name="lrInput8" id="lrInput8"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="7" name="lrMChecked" id="lrMChecked7" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="7"  name="lrInput7" id="lrInput7"   readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="6" name="lrMChecked" id="lrMChecked6" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="6" name="lrInput6" id="lrInput6"   readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="5" name="lrMChecked" id="lrMChecked5" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="5" name="lrInput5" id="lrInput5"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="4"  name="lrMChecked" id="lrMChecked4" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="4" name="lrInput4" id="lrInput4" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="3" name="lrMChecked" id="lrMChecked3" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="3" name="lrInput3" id="lrInput3" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="2" name="lrMChecked" id="lrMChecked2" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="2"  name="lrInput2" id="lrInput2" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="1" name="lrMChecked" id="lrMChecked1" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
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
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="8" name="unUrChecked" id="unurChecked8" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="8" name="unurInput8" id="unurInput8" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="7" name="unUrChecked" id="unurChecked7" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="7" name="unurInput7" id="unurInput7" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="6" name="unUrChecked" id="unurChecked6" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="6" name="unurInput6" id="unurInput6" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="5" name="unUrChecked" id="unurChecked5" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="5" name="unurInput5" id="unurInput5" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="4" name="unUrChecked" id="unurChecked4" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="4" name="unurInput4" id="unurInput4" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="3" name="unUrChecked" id="unurChecked3" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="3" name="unurInput3" id="unurInput3" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="2" name="unUrChecked" id="unurChecked2" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="2" name="unurInput2" id="unurInput2"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="1" name="unUrChecked" id="unurChecked1" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="1" name="unurInput1" id="unurInput1" readonly>
																</div>
															</td>
														</tr>
														<tr>
															<td>UL</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="8" name="unUlChecked" id="unulChecked8" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 																 
																  <input class="form-control width50" type="text" value="8" name="unulInput1" id="unulInput1" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="7" name="unUlChecked" id="unulChecked7" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="7" name="unulInput7" id="unulInput7" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="6" name="unUlChecked" id="unulChecked6" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="6" name="unulInput6" id="unulInput6" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="5" name="unUlChecked" id="unulChecked5" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="5" name="unulInput5" id="unulInput5" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="4" name="unUlChecked" id="unulChecked4" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="4" name="unulInput4" id="unulInput4" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="3" name="unUlChecked" id="unulChecked3" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="3" name="unulInput3" id="unulInput3"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="2" name="unUlChecked" id="unulChecked2" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="2" name="unulInput2" id="unulInput2" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="1" name="unUlChecked" id="unulChecked1" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="1"  name="unulInput1" id="unulInput1" readonly>
																</div>
															</td>
														</tr>
														<tr>
															<td>LL</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="8" name="unLlChecked" id="unllChecked8" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="8"  name="unllInput8" id="unllInput8"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="7" name="unLlChecked" id="unllChecked7" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="7" name="unllInput7" id="unllInput7" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="6" name="unLlChecked" id="unllChecked6" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="6"  name="unllInput6" id="unllInput6"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="5" name="unLlChecked" id="unllChecked5" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="5" name="unllInput5" id="unllInput5" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="4" name="unLlChecked" id="unllChecked4" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="4"  name="unllInput4" id="unllInput4" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="3" name="unLlChecked" id="unllChecked3" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="3"  name="unllInput3" id="unllInput3" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="2" name="unLlChecked" id="unllChecked2" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="2" name="unllInput2" id="unllInput2" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="1" name="unLlChecked" id="unllChecked1" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="1" name="unllInput1" id="unllInput1" readonly>
																</div>
															</td>
														</tr>
														<tr>
															<td>LR</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="8" name="unLrChecked" id="unlrChecked8" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="8" name="unlrInput8" id="unlrInput8" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="7" name="unLrChecked" id="unlrChecked7" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="7" name="unlrInput7" id="unlrInput7" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="6" name="unLrChecked" id="unlrChecked6" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="6" name="unlrInput6" id="unlrInput6"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="5" name="unLrChecked" id="unlrChecked5" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="5" name="unlrInput5" id="unlrInput5"  readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="4"  name="unLrChecked" id="unlrChecked4" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="4" name="unlrInput4" id="unlrInput4" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="3" name="unLrChecked" id="unlrChecked3" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="3" name="unlrInput3" id="unlrInput3" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="2" name="unLrChecked" id="unlrChecked2" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="2" name="unlrInput2" id="unlrInput2" readonly>
																</div>
															</td>
															<td>
																<div class="form-check form-check-inline cusCheck">
																  <input class="form-check-input" type="checkbox" value="1" name="unLrChecked" id="unlrChecked1" onClick="return countMissingAndUnsavableValue(this);">
																  <span class="cus-checkbtn"></span> 
																  <input class="form-control width50" type="text" value="1" name="unlrInput1" id="unlrInput1" readonly>
																</div>
															</td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
										
										<div class="opdMain_detail_area1">
						
																<h4 class="service_htext">Medical Exam Dental File Upload</h4>
																<div class="row">
																<div class="col-md-6">
																			<div class="form-group row">
																				<label class="col-md-4 col-form-label">Upload File
																				</label>
																				<div class="col-md-6" id="uploadFileMedicalExam">
																					<div class="fileUploadDiv">
																						<input type="file" name="medicalExamFileUpload"
																							id="medicalExamFileUpload" class="inputUpload" /> <label
																							class="inputUploadlabel">Choose File</label> <span
																							class="inputUploadFileName">No File Chosen</span>
																					</div>
																				</div>
																				<div style="display: none" class="col-md-7"
																					id="viewUploadedFile"></div>
																			</div>
																		</div>
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
										
										
										<!-- <div class="col-12  m-b-10">
											<div class="form-check form-check-inline cusRadio">
                                                   <input class="form-check-input" type="radio" name="labradiologyCheck" checked="checked"
												  onchange="changeRadio(this.value)" value="" id="lab_radio" />
                                               <span class="cus-radiobtn"></span> 
                                               <label class="form-check-label m-l-5" for="inlineRadio1">Laboratory</label>
                                              </div>
                                             <div class="form-check form-check-inline cusRadio">
                                                <input type="radio" value="" id="imag_radio" class="radioCheckCol2 form-check-input"  name="labradiologyCheck" onchange="changeRadio(this.value)" />
                                                <span class="cus-radiobtn"></span>
                                                <label class="form-check-label m-l-5" for="inlineRadio2">Imaging</label>
                                             </div>
											</div> -->
										
										<!-- <table class="table table-hover table-striped table-bordered">
											<thead class="bg-primary">
												<tr>
													<th>Investigation</th>
													<th>Result</th>
													<th>UOM</th>
													<th style="display: none">File Upload</th>
													<th>Add</th>
													<th>Delete</th>
												</tr>
											</thead>
											<tbody id="dgInvetigationGrid">
												
												<tr>
													<td>
														<input type="text" class="form-control">
														<div   class="autocomplete">
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
																			<input type="hidden"  name="dgResultHdId" value="" id="dgResultHdId"/>
																			<input type="hidden"  name="dgResultDtId" value="" id="dgResultDtId"/>
																			</div>
													</td>
													<td>
														<input type="text" name="resultInvs" id="resultInvs"class="form-control">
													</td>
													<td>
														<input type="text" name="UOM" id="UOM"class="form-control" readonly>
													</td>
													<td style="display: none"><a class="btn-link" href="#">View Document</a></td>
													 <td>
														<button name="Button" type="button" class="buttonAdd btn btn-primary noMinWidth" button-type="add" value=""  onclick="addRowForInvestigationFunME();" tabindex="1"></button>
													</td>
													<td>
														<button type="button"   name="delete" value="" id="deleteInves1"  class="buttonDel btn btn-danger noMinWidth" button-type="delete"onclick="removeRowInvestigation(this);"></button>
													</td> 
											 
													
												</tr>
												
											</tbody>
										</table> -->
										
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
										
										<div class="col-md-12 m-t-5">  									
											   
												<div class="form-check form-check-inline cusRadio">													
													<input class="form-check-input" type="radio" checked value="investigation" onChange="return changeRadioForUploa(this.value),openGeneralDocAndInvForDigi('Lab');" id="lab_radio" name="btnradio">
													<span class="cus-radiobtn"></span> 
													<label class="form-check-label" for="lab_radio">Laboratory</label>
												</div>
											
												<div class="form-check form-check-inline cusRadio">													
													<input class="form-check-input" type="radio" value="imaging"
													onChange="return changeRadioForUploa(this.value), openGeneralDocAndInvForDigi('Radio');"
													id="imag_radio" name="btnradio">
													<span class="cus-radiobtn"></span> 
													<label class="form-check-label" for="imag_radio">Imaging &nbsp &nbsp </label>
												</div>
												
										</div>
										<div class=" m-t-10" id="investgationDetail">
												 

												<table
													class="table table-hover table-striped table-bordered">
													<thead class="bg-primary">
														<tr>
															<th ></th>
															<th>Investigation</th>
															<th id="uomId">UOM</th>
															<th>Result</th>
															<th>Range</th>
															<th>Investigation Remarks</th>
															<th>View Document</th>
															<th>Add</th>
															<th>Delete</th>
														</tr>
													</thead>
													<tbody id="dgInvetigationGrid">

														<tr>
															<td >
																<div class="form-check">
																	<input class="form-check-input position-static"
																		type="checkbox" name="checkBoxForUpload"
																		id="checkBoxForUpload" onClick="return getInvestionCheckData(this);" >
																</div>
															</td>

															<td>
																<!-- <input type="text" class="form-control"> -->
																<div class="autocomplete forTableResp">
																	<!-- <input type="text" autocomplete="off" value=""
																		id="chargeCodeName" class="form-control border-input"
																		name="chargeCodeName"
																		onKeyPress="autoCompleteCommonUp(this,1);" size="44"
																		onblur="populateChargeCode(this.value,'1',this);" /> 
																	 -->	
																	 <input type="text" autocomplete="off" value=""
																		id="chargeCodeName" class="form-control border-input"
																		name="chargeCodeName"
																		onKeyUp="getNomenClatureList(this,'populateChargeCode','medicalexam','getInvestigationListUOM','investigationMe');"  />
																	
																		<input type="hidden" id="qty" tabindex="1" name="qty1"
																		size="10" maxlength="6" validate="Qty,num,no" /> <input
																		type="hidden" tabindex="1" id="chargeCodeCode"
																		name="chargeCodeCode" size="10" readonly /> <input
																		type="hidden" name="investigationIdValue" value=""
																		id="investigationIdValue" /> <input type="hidden"
																		name="dgOrderDtIdValue" value="" id="dgOrderDtIdValue" />
																	<input type="hidden" name="dgOrderHdId" value=""
																		id="dgOrderHdId" /> <input type="hidden"
																		name="dgResultHdId" value="" id="dgResultHdId" /> <input
																		type="hidden" name="dgResultDtId" value=""
																		id="dgResultDtId" />
																		
																			<input type="hidden" name="investigationType" value="" id="investigationType" />
			 								<input type="hidden" name="subChargecodeIdForInv" value="" id="subChargecodeIdForInv" />
			 	    						<input type="hidden" name="mainChargecodeIdValForInv" value="" id="mainChargecodeIdValForInv"/>
				
																		
																		<div id="investigationDivMe" class="autocomplete-itemsNew"></div>	
																</div>
															</td>
															<td id="uomIds"><input type="text" name="UOM"
																id="UOM" class="form-control" readonly></td>
															<td id="resultdiv"></td>
															<td><input type="text" name="range" value=""
																id="range" class="form-control"></td>
														 	<td> 
							 									<textarea class="form-control"  name="investigationRemarks" id="investigationRemarks" rows="2" maxlength="500"></textarea>
							 								 </td>
								
															<td></td>
															<td>
																<button name="Button" type="button"
																	class="buttonAdd btn btn-primary noMinWidth"
																	button-type="add" value=""
																	onclick="addRowForInvestigationFunUpMe();" tabindex="1"></button>
															</td>
															<td>
																<button type="button" name="delete" value=""
																	id="deleteInves1"
																	class="buttonDel btn btn-danger noMinWidth"
																	button-type="delete"
																	onclick="removeRowInvestigationUp(this);"></button>
															</td>
														</tr>
													</tbody>
												</table>
											</div>
										<div id="fileUploadDynamic">
											<input type="hidden" name="dynamicUploadInvesId" id="dynamicUploadInvesId"/>
											<input type="hidden" name="dynamicUploadInvesIdAndfile" id="dynamicUploadInvesIdAndfile"/>
											<input type="hidden" name="dynamicFileUploadId" id="dynamicFileUploadId" value="investUploadDynamic"/>
											<input type="hidden" name="uploadNewBuutonId" id="uploadNewBuutonId" value="uploadNewFile"/>
											<input type="hidden" name="fileNameId" id="fileNameId" value="fileInvUploadDyna"/>
											<input type="hidden" name="radioCheckId" id="radioCheckId" value="radioFileUpload"/>
											<input type="hidden" name="countFileUploadVal" id="countFileUploadVal" value="1"/>
											 <input type="hidden" name="checkForRemove" id="checkForRemove" value="1"/>
											 <input type="hidden" name="mainChargeCodeForFile" id="mainChargeCodeForFile" value=""/>
											   <input type="hidden" name="mainChargeCodeForFileWithChargeCode" id="mainChargeCodeForFileWithChargeCode" value=""/>
											<table
													class="table table-hover table-striped table-bordered">
													<thead class="bg-primary">
														<tr>
															<th>Mark</th>
															<th>Investigation Name</th>
															<th>File Upload <span class="mandate">(File name should not contain any special characters and should be jpg,pdf,jpeg,gif,png only!)</span></th>
															<th>Upload New File</th>
															<th>Action</th>
														</tr>
													</thead>
													<tbody id="fileUploadforInvesDynamic">
														<tr>
															 <td>
																<div class="form-check form-check-inline cusRadio m-l-5">													
																	<input class="form-check-input" type="radio" id="radioFileUpload" name="radioFileUpload" onClick="return updateNewIdWhenRadioCheck(this);">
																	<span class="cus-radiobtn"></span>
																</div>
															</td> 
															<td>
																
																<textarea class="form-control" id="investUploadDynamic"></textarea>
																
															</td>

											  				<td>
											  				<div class="fileUploadDiv">
											  					<input type="file" name="fileInvUploadDyna" class="inputUpload" 
																id="fileInvUploadDyna" value="" onchange="return getFileUploadData(this);"  disabled>
																<label class="inputUploadlabel">Choose File</label>
																<span class="inputUploadFileName">No File Chosen</span>
															</div>
															</td>
											  				<td>
																<button type="button" name="uploadNewFile"  id="uploadNewFile" value="uploadNewFile"
																	class="buttonAdd btn btn-primary noMinWidth"
																	button-type="add" onClick="return getNewUploadFile(this);"></button>
															</td>
															
											  				<td>
																<button type="button" name="deleteRowForFile" value=""
																	id="deleteRowForFile"
																	class="buttonDel btn btn-danger noMinWidth"
																	button-type="delete"
																	onclick="removeFile(this);"></button>
															</td>
											  			</tr>
													</tbody>
												</table>
											</div>
										 
											<div class="row">
												 <div class="col-md-6">
													<div class="form-group row">
														<label class="col-md-4 col-form-label" style="  padding-left: 10px;"> Other Investigation </label>
														<div class="col-md-7">
															<textarea name="otherInvestigation" id="otherInvestigation" cols="0" rows="0"
													        	maxlength="500" tabindex="1"   class="auto form-control"></textarea>													 
													    </div>
												    </div>
												  </div>  
												<div class="col-md-6">
													 
												
												</div>
											</div> 
										
									</div>
									
									<!---------------------- Investigation ends here ---------------------->
									<!---------------------- Physical Capacity ---------------------->
									
									<div class="adviceDivMain" id="button2" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Physical Capacity</span>
										</div>
										<input class="buttonPlusMinus" tabindex="2" name="" id="relatedbutton2" value="-" onclick="showhide(this.id)" type="button">
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
															<input type="text" name="height" id="height" class="form-control" maxlength="3" onblur="return idealWeight2();checkBMI();" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;">
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
															<input type="text" name="weight" id="weight" class="form-control" onblur="checkVaration();checkBMI();" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;">
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
															<input type="text" name="idealWeight" id="idealWeight" class="form-control" onblur="checkVaration()" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;">
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
															<input type="text" name="overWeight"  maxlength="10" id="overWeight" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"class="form-control" readonly>
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
															<input type="text" name="waist" id="waist"   onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"class="form-control">
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
															<input type="text" name="bmi" id="bmi" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"class="form-control">
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
														
															<input type="text" name="bodyFat" id="bodyFat" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"class="form-control">
														
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
															<input type="text" name="hip" id="hip" onblur="calculateWHR();" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"class="form-control">
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
														
															<input type="text" name="whr" id="whr" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"class="form-control" readonly/>
														 
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
															<input type="text" name="skinFoldExpansion" id="skinFoldExpansion" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"class="form-control">
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
														<label for="service" class="col-form-label">Chest Full Expiration <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input type="text"  name="chestFullExpansion" id="chestFullExpansion" maxlength="100"  onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"class="form-control">
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
															<input type="text" name="rangeOfExpansion" id="rangeOfExpansion" maxlength="100"  onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"class="form-control">
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
														<label for="service" class="col-form-label">Skin</label>
													</div>
													<div class="col-md-7">
															<input type="text" id="skin"
																name="skin" class="form-control"
																value="NAD" maxlength="100" >
													</div>
												</div>
											</div> -->
											
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
											
											
													<!----------------------//////////////////////////////////////////////////////////////////////////////////////////////////---------------------->
											
												 <div class="col-md-5"  style="display:none" id="markObesityId">
												<div class="form-group row">
													<!--<label class="col-md-5 col-form-label">Mark Obesity
													</label>
													<div class="col-md-7 ">
													<div class="form-check form-check-inline cusCheck m-t-7 m-l-10">
														<input class="form-check-input" type="checkbox" id="obsistyMark"  onclick="obsistyFunction()">
													<span class="cus-checkbtn"></span> 
													</div>
													</div>
												</div> -->
												
												<div class="col-md-9 makeDisabled">
													<div class="form-check form-check-inline cusRadio m-t-5">
															<input type="radio" value="N" class="form-check-input radioCheckCol2"
																name="ObesityCheck" id="obsistyCheck" onchange="overWeightOb(this.value)" />
															<span class="cus-radiobtn"></span> 
															<label class="form-check-label" for="obsistyCheck"><span id="ObesityId">Obesity</span></label>
														</div>
														
													<div class="form-check form-check-inline cusRadio">
															<input type="radio" value="Y" class="form-check-input radioCheckCol2"
																name="ObesityCheck" id="overCheck"
																onchange="overWeightOb(this.value)" />
															<span class="cus-radiobtn"></span> 
															<label class="form-check-label" for="overCheck"><span id="OverweightId">Overweight</span></label>
															
														</div>
													<div class="form-check form-check-inline cusRadio">
															<input type="radio" value="none" class="form-check-input radioCheckCol2"
																name="ObesityCheck" id="noneCheck"
																onchange="overWeightOb(this.value)" />
															<span class="cus-radiobtn"></span> 
															<label class="form-check-label" for="noneCheck"><span id="NoneId">None</span></label>
															
														</div>	
												</div>
												<div class="col-md-3 makeDisabled">
														<div style="display: none" id="overWeightDropDown">
														<select name="overWeightDivId"  class="form-control p-l-5" id="overWeightSelect"  tabindex="1">
																<option id="under20" value="S">10-20</option>
																<option id="above20" value="H">>20</option>
															</select>
														</div>
															
													</div>
													<!-- <div class="form-group">
													
														
													</div> -->
												
												<div class="col-md-8">
													<div class="form-group row"></div>
												</div>
											</div>
											
										</div>
										<!----------------------	///////////////////////////////////////////////////////////////////////////////////////////////////	---------------------->		
											
											
											
											
											
										</div>
									
									</div>
									
									
									<!---------------------- Physical Capacity ends here---------------------->
									
									<!---------------------- Skin ---------------------->
									
									<div class="adviceDivMain" id="button20" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Skin</span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton20" value="-" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost20">
										
										<div class="row">
											<div class="col-md-12">
												<div class="form-group row">
													<div class="col-md-3">
														<label for="service" class="col-form-label">Skin</label>
													</div>
													<div class="col-md-9">
															<input type="text" id="skin"
																name="skin" class="form-control"
																value="NAD" maxlength="100">
													</div>
												</div>
											</div>
										</div>
										
										
									</div>
									
									
									<!---------------------- Skin ends here ---------------------->
									
									<!---------------------- Cardio Vascular System ---------------------->
									
									
									<div class="adviceDivMain" id="button6" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Cardio Vascular System</span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton6" value="-" onclick="showhide(this.id)" type="button">
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
															<input type="text" id="pulse" name="pulse" maxlength="20"   onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"class="form-control">
														    <div class="input-group-append">
														      <div class="input-group-text">/m</div>
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
															<input type="text" id="bp" name="bp" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"class="form-control">
														    <div class="input-group-append">
														      <div class="input-group-text">cm</div>
														    </div>
														  </div>
													</div> -->
													
													<div class="col-md-3 offset-md-2">
														
															<input name="bp" id="bp" type="text"
															class="form-control border-input bpSlash" placeholder="SBP" maxlength="3" 
															value="" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"/>
															<span></span> <!-- slash for bp -->
														  
													</div>
													<div class="col-md-4">
														<div class="input-group mb-2 mr-sm-2">
															<input name="bp1" id="bp1" type="text"
															class="form-control border-input bmiInput" placeholder="DBP" maxlength="3" 
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
													<div class="col-md-5">
														<label for="service" class="col-form-label">Peripheral Pulsations <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="peripheralPulsations" name="peripheralPulsations"  maxlength="20" class="form-control" value="NAD">
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Heart Size <span style="color: red"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="heartSize" name="heartSize"  class="form-control" value="NAD" maxlength="10">
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Sounds <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="sounds" name="sounds"  class="form-control" value="NAD" maxlength="10">
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Rhythm <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="rhythm" name="rhythm" class="form-control" value="NAD" maxlength="10">
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
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton7" value="-" onclick="showhide(this.id)" type="button">
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
											<span>Gastro Intestinal System</span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton8" value="-" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost8">
										
										<div class="row">
											<div class="col-md-12">
												<div class="form-group row">
													<div class="col-md-3">
														<label for="service" class="col-form-label">Liver Palpable <span class="mandate"><sup></sup></span></label>
													</div>
													<div class="col-md-2">
														<select class="form-control" onclick="showLiverPalpableValue(this)" name="liverPalpable" id="liverPalpable">
															<option value="No">No</option>
															<option value="Yes">Yes</option>
															
														</select>
													</div>
													<!-- <div class="col-md-6">
														<input type="text" id="liver" name="liver"  class="form-control" >
													</div> -->
													<div class="col-md-2" style="display:none;" id="liverPalpableInput">
														<div class="input-group mb-2 mr-sm-2">
															<input type="text" id="liver" name="liver" maxlength="10" class="form-control" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;">
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
														<label for="service" class="col-form-label">Spleen Palpable <span class="mandate"><sup></sup></span></label>
													</div>
													<div class="col-md-2">
														<select class="form-control" onclick="showLiverPalpableValue1(this)" name="spleenPalpable" id="spleenPalpable">
														<option value="No">No</option>	
															<option value="Yes">Yes</option>
															
														</select>
													</div>
													<!-- <div class="col-md-9">
														<input type="text" id="spleen" name="spleen" class="form-control" >
													</div> -->
													<div class="col-md-2" style="display:none;" id="spleenPalpableInput">
														<div class="input-group mb-2 mr-sm-2">
															<input type="text" id="spleen" name="spleen" class="form-control" maxlength="10" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;">
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
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton9" value="-" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost9">
										
										<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Higher Mental Function <span class="mandate"><sup></sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="higherMentalFunction" name="higherMentalFunction" class="form-control" value="NAD" maxlength="10">
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Speech <span class="mandate"><sup></sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="speech" name="speech" class="form-control" value="NAD" maxlength="100">
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Reflexes <span class="mandate"><sup></sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="reflexes" name="reflexes" class="form-control" value="NAD" maxlength="100">
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Tremors <span class="mandate"><sup></sup></span></label>
													</div>
													<div class="col-md-7">
														<select class="form-control" id="tremors" name="tremors">
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
														<label for="service" class="col-form-label">Self Balancing Test <span class="mandate"><sup></sup></span></label>
													</div>
													<div class="col-md-7">
														<select class="form-control" id="selfBalancingTest" name="selfBalancingTest">
															<option value="fairly steady">Fairly steady</option>
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
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton10" value="-" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost10">
										
										<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Locomotor System <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="locomotorSystem" name="locomotorSystem" class="form-control" value="NAD" maxlength="100"s>
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Spine <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="spine" name="spine" class="form-control" value="NAD" maxlength="100">
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Hernia <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="hernia" name="hernia"  class="form-control" value="NAD" maxLength="100">
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Hydrocele <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="hydrocele" name="hydrocele"   class="form-control" value="NAD" maxLength="100">
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Haemorrhoids <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="haemorrhoids" name="haemorrhoids"  class="form-control" value="NAD" maxLength="100">
													</div>
												</div>
											</div>
											
											<div id="brestId" class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Breast <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text"  id="breast" name="breast" class="form-control" value="NAD" maxLength="100">
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
										<input class="buttonPlusMinus" tabindex="3" name="" id="relatedbutton3" value="-" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost3">
										
										<table class="table table-hover table-striped table-bordered">
											<thead class="bg-primary">
												<tr>
													<th>Distant Vision <span class="mandate"><sup></sup></span></th>
													<th>R</th>
													<th>L</th>
													<th>Near Vision <span class="mandate"><sup></sup></span></th>
													<th>R</th>
													<th>L</th>
													<th>CP <span class="mandate"><sup></sup></span></th>
													
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>Without Glasses</td>
													<td>
														<select class="form-control" name="distantWithoutGlasses" id="distantWithoutGlasses">
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
															<option value="NA" >NA</option>
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
															 <option value="NA" >NA</option>
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
															 <option value="NA" >NA</option>
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
															<option value="NA" >NA</option>
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
										<input class="buttonPlusMinus" tabindex="4" name="" id="relatedbutton4" value="-" onclick="showhide(this.id)" type="button">
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
													<td class="width330">FW <span class="mandate"><sup></sup></span></td>
													<td>
														<div class="form-row from-inline m-l-0">
															<input type="text" name="fwR" id="fwR" maxlength="10" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"class="form-control width100" value="610">
															<input type="text" name="fwr" id="fwr"  value="Cms"class="form-control width50" readonly/>
														</div>
													</td>
													<td>
														<div class="form-row from-inline m-l-0">
															<input type="text" name="fwL" id="fwL" maxlength="10" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control width100" value="610">
															<input type="text" name="fwl" id="fwl" class="form-control width50" value="Cms" readonly/>
														</div>
													</td>
													<td>
														<div class="form-row from-inline m-l-0">
															<input type="text" name="fwBoth" id="fwBoth" maxlength="10" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"class="form-control width100" value="610">
															<input type="text" name="fwboth" id="fwboth" class="form-control width50" value="Cms" readonly/>
														</div>
													</td>
												</tr>
												
												<tr>
													<td class="width330">CV <span class="mandate"><sup></sup></span></td>
													<td>
														<div class="form-row from-inline m-l-0">
															<input type="text" name="cvR" id="cvR" maxlength="10" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control width100" value="610">
															<input type="text" name="cvr" id="cvr" class="form-control width50" value="Cms" readonly/>
														</div>
													</td>
													<td>
														<div class="form-row from-inline m-l-0">
															<input type="text" name="cvL" id="cvL" maxlength="10" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control width100" value="610">
															<input type="text" name="cvl" id="cvl" class="form-control width50" value="Cms" readonly/>
														</div>
													</td>
													<td>
														<div class="form-row from-inline m-l-0">
															<input type="text" name="cvBoth" id="cvBoth" maxlength="10" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control width100" value="610">
															<input type="text" name="cvboth" id="cvboth" class="form-control width50" value="Cms" readonly/>
														</div>
													</td>
												</tr>
												
												<tr>
													<td class="width330">Tympanic Membrance Intact <span class="mandate"><sup></sup></span></td>
													<td>
														<select class="form-control width150" id="tmR" name="tmR">
														<option value="Yes">Yes</option>
														<option value="No">No</option>
														</select>
													</td>
													<td>
														<select class="form-control width150" id="tmL" name="tmL">
														<option value="Yes">Yes</option>
														<option value="No">No</option>
														</select>
													</td>
													<td>
														
													</td>
												</tr>
												<tr>
													<td class="width330">Mobility Valsalva <span class="mandate"><sup></sup></span></td>
													<td>
														<select class="form-control width150" id="mobilityR" name="mobilityR">
														<option value="+ve">+ve</option>
														<option value="-ve">-ve</option>
														</select>
													</td>
													
													<td>
														<select class="form-control width150" id="mobilityL" name="mobilityL">
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
														<label class="col-form-label">Nose, Throat &amp; Sinuses <span class="mandate"><sup></sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" type="text" id="noseThroatSinuses" name="noseThroatSinuses"  maxLength="100"  class="form-control" value="NAD">
													</div>
												</div>
											</div>
											<div class="w-100"></div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">Audiometry Record <span class="mandate"><sup></sup></span></label>
													</div>
													<div class="col-md-7">
														<select class="form-control" id="audiometryRecord" name="audiometryRecord" onChange="return displayTextArea(this);">
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
														<textarea class="form-control" id="audiometryRecordForOther" name="audiometryRecordForOther" maxLength="200"></textarea>
													</div>
												</div>
											</div>
										</div>
									</div>
									
									<!---------------------- Hearing ends here ---------------------->
									
									
									
									
									<!---------------------- Gynaecological Exam ---------------------->
									<div id="gynaecologicalExam" style="display:none;  width:100%;">
									<div class="adviceDivMain" id="button17" onclick="showhide(this.id)" >
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Gynaecological Exam </span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton17" value="-" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost17">
										
										<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Menstural History <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="mensturalHistory" name="mensturalHistory" class="form-control" maxlength="30">
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
														<input type="text" id="nosOfPregnancies" name="nosOfPregnancies" maxlength="3"  class="form-control" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;">
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Nos of Abortions <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="nosOfAbortions" name="nosOfAbortions" maxlength="3"  class="form-control" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;">
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Nos of Children <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="nosOfChildren" name="nosOfChildren" maxlength="3"  class="form-control" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;">
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
														<input type="text" id="childDateOfLastConfinement" name="childDateOfLastConfinement" maxlength="10" class="form-control noFuture_date2" placeholder="DD/MM/YYYY" >
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
														<input type="text" id="vaginalDischarge" name="vaginalDischarge" class="form-control" value="NAD" maxlength="50">
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
														<input type="text" id="usgAbdomen" name="usgAbdomen" class="form-control" value="NAD" maxlength="10">
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Prolapse <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<input type="text" id="prolapse" name="prolapse" class="form-control" value="NAD" maxlength="10">
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
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton15" value="-" onclick="showhide(this.id)" type="button">
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
											<span>Certification of Commutation of Pension</span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton15" value="-" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost15">
										<div class="row">
											<div class="col-md-12">
											<label class="col-form-label"> I have carefully examined</label>
											</div>
											
											<div class="col-md-3">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Service No.</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="serviceNoOfCertificate" name="serviceNoOfCertificate" class="form-control" readonly/>
													</div>
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Rank</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="rankOfCertificate" name="rankOfCertificate" class="form-control" readonly/>
													</div>
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Name</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="nameOfCertificate" name="nameOfCertificate" class="form-control" readonly/>
													</div>
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Unit</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="unitCertificate" name="unitCertificate" class="form-control" readonly/>
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
									
									
									
									
									
									
									
									
									
										<!---------------------- Final Observation Factors ---------------------->

											<div class="adviceDivMain" id="button16"
												onclick="showhide(this.id)">
												<div class="titleBg" style="width: 520px; float: left;">
													<span>Final Observation</span>
												</div>
												<input class="buttonPlusMinus" tabindex="5" name=""
													id="relatedbutton16" value="-" onclick="showhide(this.id)"
													type="button">
											</div>

											<div class="hisDivHide p-10" style="display: block"
												id="newpost16">
												<div class="row m-t-20">

													<div class="col-md-4" style="display: none">
														<div class="form-group row">
															<div class="col-md-5">
																<label for="service" class="col-form-label">PET</label>
															</div>
															<div class="col-md-7">
																<select class="form-control" id="pet" name="pet">
																	<option value="0">Select</option>
																	<option value="NA">NA</option>
																	<option value="Sat">Sat</option>
																	<option value="Good">Good</option>
																	<option value="Very good">Very good</option>
																	<option value="Excellent">Excellent</option>
																</select>

															</div>
														</div>
													</div>

													<!-- <div class="col-md-4">
														<div class="form-group row">
															<div class="col-md-5">
																<label for="service" class="col-form-label">Fit
																	In</label>
															</div>
															<div class="col-md-7">
																<input type="text" class="form-control"
																	name="fitInMedicalCategory" id="fitInMedicalCategory"
																	readonly />

															</div>
														</div>
													</div> -->

													<!-- <div id="petDate" class="col-md-4" style="display: none;">
														<div class="form-group row">
															<div class="col-md-5">
																<label for="service" class="col-form-label">Date</label>
															</div>
															<div class="col-md-7">
																<div class="dateHolder">
																	<input name="medicalExamDate" id="medicalExamDate"
																		class="noFuture_date form-control">
																</div>
															</div>
														</div>
													</div> -->


												<div id="petDate" class="col-md-4" style="display: none">
														<div class="form-group row">
															<div class="col-md-5">
																<label for="service" class="col-form-label">Date</label>
															</div>
															<div class="col-md-7">
																<div class="dateHolder">
																	<input name="petDateValue" id="petDateValue"
																		class="noFuture_date2 form-control" placeholder="DD/MM/YYYY" >
																</div>
															</div>
														</div>
													</div> 
													<div class="w-100"></div>
													<div style="display:none;">
												  <div class="col-12">
														<h6 class="font-weight-bold text-theme text-underline">FIT for release in</h6>
													</div>
												

												<div class="col-12">
														<h6 class="font-weight-bold">Present Medical Category (Composite) (Enter if LMC)</h6>
													</div>
													<div class="col-12">
														<table class="table table-hover table-striped table-bordered">
															<thead class="bg-success" style="color: #fff;">
																<tr>
																	<th id="th1">Medical Category <span class="mandate"><sup></sup></span></th>
																	<th id="th2">Date of Category <span class="mandate"><sup></sup></span></th>
			
																</tr>
															</thead>
															<tbody>
																<tr>
			
																	<td>
																		<div class="autocomplete forTableResp">
																			 
																			  <input type="text" autocomplete="off" name="medicalCompositeName" id="medicalCompositeName"   onKeyUp="getNomenClatureList(this,'fillMedicalCategoryData','medicalBoard','getMedicalBoardAutocomplete','compositeCategoryForDetail');"
                                                     	  						class="form-control">
																			 
																				<input type="hidden"
																				id="medicalCompositeNameValue"
																				name="medicalCompositeNameValue" value="" />
																			<div id="compositeCategoryDiv" class="autocomplete-itemsNew"></div>	
																		</div>
			
																	</td>
			
			
																	<td>
			
																		<div class="dateHolder">
																			<input type="text" id="medicalCompositeDate"
																				name="medicalCompositeDate"
																				class="noFuture_date5 form-control"
																				placeholder="DD/MM/YYYY" value="" maxlength="10" />
																		</div>
			
																	</td>
			
																</tr>
			
															</tbody>
														</table>
													</div>
													 </div>
			
													<div style="display:none;">
													  <div class="col-12">
														<h6 class="font-weight-bold">List of Medical Category (Enter if LMC)</h6>
													</div>
													<div class="col-12">
														<table class="table table-hover table-striped table-bordered">
															<thead class="bg-success" style="color: #fff;">
																<tr>
																	<th id="th2" style="width: 275px;">Diagnosis</th>
																	<th id="th4">Medical Category</th>
																	<th id="th3" style="width: 80px;">System</th>
																	<th id="th5">Type of Category</th>
																	<th id="th7" style="width: 80px;">Duration<br/> (P&#8594;Month) <br/> (T&#8594;Week) </th>
																	<th id="th7" style="width: 80px;">Duration</th>
																	<th id="th6">Category Date</th>
																	<th id="th8">Next Category Date</th>
																	<th id="th8">Add</th>
			                                                        <th id="th8">Delete</th>
													</tr>
															</thead>
													<tbody id="medicalCategory">
                                                       <tr>
                                                            <td>
                                                                <div class="autocomplete forTableResp">
                                                                <input type="text" autocomplete="off" class="form-control" name="diagnosisId" id="diagnosisId" onblur="fillDiagnosisCombo(this.value,this);" onKeyPress="autoCompleteCommonMe(this,5);" onKeyUp="autoCompleteCommonMe(this,5);"placeholder="Diagnosis" />
                                                                <input type="text" autocomplete="off" class="form-control" name="diagnosisId" id="diagnosisId" onKeyUp="getNomenClatureList(this,'fillDiagnosisComboMedCatMe','opd','getIcdListByName','diagnosisMe');"  placeholder="Diagnosis" />
                                                                <div id="diagnosisMeDiv" class="autocomplete-itemsNew"></div>
                                                                </div>
                                                             </td>
                                                               <td>
                                                                  <div class="autocomplete forTableResp">
                                                                   <input type="text" autocomplete="off" id="medicalCategoryId" onblur="fillMedicalCategoryData(this.value,this);" onKeyPress="autoCompleteCommonMe(this,6);"  onKeyUp="autoCompleteCommonMe(this,6);" class="form-control">
                                                                  <input type="text" autocomplete="off" id="medicalCategoryId" onKeyUp="getNomenClatureList(this,'fillMedicalCategoryDataMe','medicalBoard','getMedicalBoardAutocomplete','compositeCategory');" class="form-control">
                                                                   <input type="hidden" id="diagnosisiIdMC" name="diagnosisiIdMC" value=""/>
                                                                  	<input type="hidden" id="medicalCategoryValueId" name="medicalCategoryValueId" value=""/>
                                                                  	<input type="hidden" id="patientMedicalCatId" name="patientMedicalCatId" value=""/>
                                                                  	<input type="hidden" name="dateOfOrigin" id="dateOfOrigin" class="form-control" value=""/>
																	<input type="hidden" name="placeOfOrigin" id="placeOfOrigin" class="form-control" value=""/>
                                                                  	<div id="compositeCategoryForDetailDiv" class="autocomplete-itemsNew"></div>
                                                                 </div> 
                                                               </td>
                                                                <td>
                                                                  <input type="text" name="system" maxlength="1" id="system"class="form-control" value=""/> 
                                                                <select class="form-control" name=system id="system" onChange="generateNextDate(this);">
                                                                <option value="0">Select</option>
																		<option value="S">S</option>
																		<option value="H">H</option>
																		<option value="A">A</option>
																		<option value="P">P</option>
																		<option value="E">E</option>
                                                                </select>
                                                               </td>
                                                                 <td>
                                                                      <select class="form-control width120" name=typeOfCategory id="typeOfCategory" onChange="getdurationByType(this);generateNextDate(this);">
																		<option value="0">Select</option>
																		<option value="T">Temporary(Week)</option>
																		<option value="P">Permanent(Month)</option>
																		</select>
						                                           </td>
                                                                   <td>
                                                                     <input type="text" name="duration" id="duration" onblur="return generateNextDate(this);" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control">  
                                                                 	</td>
                                                                                 
                                                                      <td>
		                                                                <div class="dateHolder">
														                    <input type="text" id="categoryDate" 
														                     name="categoryDate" class="noFuture_date5 form-control" 
														                     placeholder="DD/MM/YYYY" value="" maxlength="10" />
													                    </div>
		                                                              </td>
                                                                       <td>
                                                                        	<div class="dateHolder">
													                    	<input type="text" id="nextcategoryDate" name="nextcategoryDate" class="noFuture_date10 form-control" placeholder="DD/MM/YYYY" value="" maxlength="10" />
													                    	</div>
                                                              			</td>
																		<td>
                                                                          <button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForMedicalCategory();"></button>
                                                                         </td>
												                  <td>
													                 <button type="button" name="delete" value=""  class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"  onclick="removeRowMedicalCategory(this)"></button>
												                 </td>	
								  						</tr>	
												  												  
												</tbody>
														</table>
													</div> 
			
												</div>

												</div>
												
												
									<div class="opdMain_detail_area" >
										<h4 class="service_htext">Upload Old Medical Exam</h4>
										<div class="row">
										<div class="col-md-6">
													<div class="form-group row">
														<label class="col-md-4 col-form-label">Upload File
														</label>
														<div class="col-md-6" id="uploadFileMedicalExamOldDocument">
															<div class="fileUploadDiv">
																<input type="file" name="medicalExamFileUploadOldDocument"
																	id="medicalExamFileUploadOldDocument" class="inputUpload" /> <label
																	class="inputUploadlabel">Choose File</label> <span
																	class="inputUploadFileName">No File Chosen</span>
															</div>
														</div>
														<div style="display: none" class="col-md-7"
															id="viewUploadedFileOldDoc"></div>
													</div>
												</div>
											</div>
										</div>
												
												
												<div class="clearfix"></div>
												<div class="opdMain_detail_area">
															<h4 class="service_htext">Fit Category</h4>
		
															<div class="row">
																
																<div class="col-md-12">
																	<div class="form-group ">
																		<div class="form-check form-check-inline cusCheck">
																		  <input class="form-check-input" type="checkbox" id="fitInChk" onclick="return masMedicalCategoryListForMe(this);">
																		  <span class="cus-checkbtn"></span>
																		  <label class="col-form-label" for="fitInChk">Fit Category</label>
																		</div>
																	</div>
																</div>
															</div>
		
														</div>
												<!-- <div class="opdMain_detail_area1">
						
																<h4 class="service_htext">Medical Exam File Upload</h4>
																<div class="row">
																<div class="col-md-6">
																			<div class="form-group row">
																				<label class="col-md-4 col-form-label">Upload File
																				</label>
																				<div class="col-md-6" id="uploadFileMedicalExam">
																					<div class="fileUploadDiv">
																						<input type="file" name="medicalExamFileUpload"
																							id="medicalExamFileUpload" class="inputUpload" /> <label
																							class="inputUploadlabel">Choose File</label> <span
																							class="inputUploadFileName">No File Chosen</span>
																					</div>
																				</div>
																				<div style="display: none" class="col-md-7"
																					id="viewUploadedFile"></div>
																			</div>
																		</div>
																</div>
															</div> -->
												<!-- <div class="opdMain_detail_area" >
													<h4 class="service_htext">Action</h4>
												<div class="row">

													<div class="col-md-4">
														<div class="form-group row">
															<div class="col-md-5">
																<label for="service" class="col-form-label">Action</label>
															</div>
															<div class="col-md-7">
																<select class="form-control" id="actionMe"
																	name="actionMe" onChange="return changeAction(this);">
																	<option value="0">Select</option>
															<option   value="approveAndClose">Approve and Close</option>
															<option   value="approveAndForward">Recommended and forward</option>
															<option   value="referred">Referred</option>
															<option   value="reject">Reject</option>
															<option   value="pending">Pending</option>
																</select>

															</div>
														</div>
													</div>

													<div class="col-md-4">
														<div class="form-group row" style="display: none;"
															id="forwardStatus">
															<div class="col-md-5">
																<label for="service" class="col-form-label">Forward
																	To</label>
															</div>
															<div class="col-md-7" id="forwardTo">
																<select class="form-control">
															<option value="0">Select</option>
															
														</select>

															</div>
														</div>
													</div>


													<div class="col-md-4">
														<div class="form-group row" style="display: none;"
															id="designationMeId">
															<div class="col-md-5">
																<label for="service" class="col-form-label">Designation
																</label>
															</div>
															<div class="col-md-7" id="designationForMe">
																<select class="form-control">
																	<option value="0">Select</option>

																</select>

															</div>
														</div>
													</div>



												</div>
												</div> -->


												<!---------------------- Referred Section ---------------------->

												<div class="opdMain_detail_area" style="display: none;"
													id="referredMe">
													<h4 class="service_htext">Referred</h4>

													<table
														class="table table-hover table-striped table-bordered m-t-10 m-b-10">
														<thead class="bg-primary">
															<tr>
																<th>S.No.</th>
																<th>Hospital Name</th>
																<th>Department</th>
																<th>Diganosis</th>
																<th>Instruction</th>
																<th>Specialist Opinion</th>
																<th>Add</th>
																<th>Delete</th>
															</tr>
														</thead>
														<tbody id="medicalReferal">
															<tr>
																<td>1</td>
																<!-- <td>
															<select class="form-control" id="masEmpanelME" name="masEmpanelME" class="medium"></select>
														</td> -->
																<td id="masEmpanelME"></td>
																<td><input type="text"
																	class="form-control departmentListClass"
																	id="departmentValue" name="departmentValue" value="" />

																	<input type="hidden" id="diagonsisId1"
																	name="diagonsisId" value="" /> <input type="hidden"
																	name="masEmpanalHospitalId" value=""
																	id="masEmpanalHospitalId" /> <input type="hidden"
																	name="masDepatId" value="" id="masDepatId" /> <input
																	type="hidden" name="referalPatientDt" value=""
																	id="referalPatientDt" /> <input type="hidden"
																	name="referalPatientHd" value="" id="referalPatientHd" />

																</td>
																<td>
																	<div class="autocomplete">
																		<!-- <div  class="autocomplete"><textarea class="form-control" type="text" id="diagonsisText" name="diagonsisText" onKeyPress="autoCompleteCommonMe(this,5);" onblur="fillDiagnosisCombo(this);fillReferalDiagnosisVal(this)"></textarea></div> -->
																		<input autocomplete="off" name="icddiagnosis" id="icddiagnosis"
																			type="text" class="form-control border-input"
																			placeholder=" " value=""
																			onKeyPress="autoCompleteCommonMe(this,'5');"
																			onKeyUp="autoCompleteCommonMe(this,'5');"
																			onblur="fillDiagnosisCombo(this.value,this);" />

																	</div>
																</td>
																<td><input type="text"
																	class="form-control departmentListClass"
																	id="instruction" name="instruction" value="" /></td>
																	
																	<td>
																
																 <textarea name="specialistOpinion" id="specialistOpinion" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;"></textarea>
																 <a class="btn-link" href="javascript:void(0)"  onclick="openResultModelSpecialist(this);">View/Enter Result</a>
		
																	</td>

																<td><button type="Button" name="add"
																		class="buttonAdd btn btn-primary noMinWidth"
																		id="referalMedicalDtIdAdd" button-type="add" value=""
																		tabindex="1"
																		onclick="addRowForReferalPatientMedicalExam();">
																	</button></td>
																<td><button type="button" name="delete" value=""
																		id="referalDtMedicalIdDel"
																		class="buttonDel btn btn-danger noMinWidth"
																		button-type="delete" tabindex="1"
																		onclick="removeRowInvestigationReferal(this,'medicalExam','');"></button></td>
															</tr>
														</tbody>
													</table>

													<br />
													<div class="row">

														<!-- <div class="col-md-2">
											
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" checked name="referredRadio" id="radiobtn1"> 
														<label class="form-check-label" for="radiobtn1">Enter Here</label>
													</div>
													
												</div> -->

														<!-- <div class="col-md-2">
													
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="referredRadio" id="radiobtn2" onClick=" return goToOpdMain();"> 
														<label class="form-check-label" for="radiobtn2">Enter Via Case Sheet</label>
													</div>
												</div> -->
													</div>

													<div class="row m-t-10">
														<div class="col-md-6">
															<div class="form-group row">
																<div class="col-md-3">
																	<label for="service" class="col-form-label">Chief
																		Complaint</label>
																</div>
																<div class="col-md-9">
																	<textarea class="form-control" id="chiefComplaint"
																		name="chiefComplaint" rows="2"></textarea>
																</div>
															</div>
														</div>

														<!-- <div class="col-md-6">
													 <div class="form-group row">
														<div class="col-md-3">
															<label for="service" class="col-form-label">General Examination</label>
														</div>
														<div class="col-md-9">
															<textarea class="form-control" rows="2"></textarea>
														</div>
													</div> 
												</div> -->

														<div class="col-md-12">
															<div class="row">
																<div class="col-md-3">
																	<label for="service" class="col-form-label">General
																		Examination</label>
																</div>
															</div>
															<div class="row">
																<div class="col-md-4">
																	<div class="form-group row">
																		<label class="col-md-5 col-form-label">Pallor
																		</label>
																		<div class="col-md-7">
																			<!-- <input name="Pollar" id="pollar" type="text"
																	class="form-control border-input" placeholder="Pallor" maxlength="500" value="" /> -->
																			<textarea name="Pollar" id="pollar"
																				class="form-control" placeholder="Pallor"
																				maxlength="500"></textarea>
																		</div>
																	</div>
																</div>
																<div class="col-md-4">
																	<div class="form-group row">
																		<label class="col-md-5 col-form-label">Edema </label>

																		<div class="col-md-7">
																			<!-- <input name="Ordema" id="ordema" type="text"
																	class="form-control border-input" placeholder="Edema" maxlength="500" /> -->
																			<textarea name="Ordema" id="ordema"
																				class="form-control" placeholder="Edema"
																				maxlength="500"></textarea>
																		</div>
																	</div>
																</div>
																<div class="col-md-4">
																	<div class="form-group row">
																		<label class="col-md-5 col-form-label">Cyanosis
																		</label>
																		<div class="col-md-7">
																			<!-- <input name="cyanosis" id="cyanosis" type="text"
																	class="form-control border-input" placeholder="Cyanosis" maxlength="500" /> -->
																			<textarea name="cyanosis" id="cyanosis"
																				class="form-control" placeholder="Cyanosis"
																				maxlength="500"></textarea>
																		</div>
																	</div>
																</div>
																<div class="col-md-4">
																	<div class="form-group row">
																		<label class="col-md-5 col-form-label">Hair/
																			Nail </label>
																		<div class="col-md-7">
																			<!-- <input name="hairNail" id="hairnail" type="text"
																	class="form-control border-input" placeholder="" value="" maxlength="500" /> -->
																			<textarea name="hairNail" id="hairnail"
																				class="form-control" placeholder="Hair/ Nail"
																				maxlength="500"></textarea>
																		</div>
																	</div>
																</div>
																<div class="col-md-4">
																	<div class="form-group row">
																		<label class="col-md-5 col-form-label">Icterus
																		</label>
																		<div class="col-md-7">
																			<!-- <input name="Jaundice" id="jaundice" type="text"
																	class="form-control border-input" placeholder=" " value="" maxlength="500"/> -->
																			<textarea name="Icterus" id="icterus"
																				class="form-control" placeholder="Icterus"
																				maxlength="500"></textarea>
																		</div>
																	</div>
																</div>
																<div class="col-md-4">
																	<div class="form-group row">
																		<label class="col-md-5 col-form-label">Lymph
																			node </label>
																		<div class="col-md-7">
																			<!-- <input name="lymphNode" id="lymphNode" type="text"
																	class="form-control border-input" placeholder=" " value="" maxlength="500"/> -->
																			<textarea name="lymphNode" id="lymphNode"
																				class="form-control" placeholder="Lymph node"
																				maxlength="500"></textarea>
																		</div>
																	</div>
																</div>
																<div class="col-md-4">
																	<div class="form-group row">
																		<label class="col-md-5 col-form-label">Clubbing
																		</label>
																		<div class="col-md-7">
																			<!-- <input name="Clubbing" id="clubbing" type="text"
																	class="form-control border-input" placeholder=" " value="" maxlength="500"/> -->
																			<textarea name="Clubbing" id="clubbing"
																				class="form-control" placeholder="Clubbing"
																				maxlength="500"></textarea>
																		</div>
																	</div>
																</div>
																<div class="col-md-4">
																	<div class="form-group row">
																		<label class="col-md-5 col-form-label">GCS </label>
																		<div class="col-md-7">
																			<!-- <input name="Thyroid" id="thyroid" type="text"
																	class="form-control border-input" placeholder=" " value="" maxlength="500"/> -->
																			<textarea name="GCS" id="gcs" class="form-control"
																				placeholder="GCS" maxlength="500"></textarea>
																		</div>
																	</div>
																</div>
																<div class="col-md-4">
																	<div class="form-group row">
																		<label class="col-md-5 col-form-label">Tremors
																		</label>
																		<div class="col-md-7">
																			<!-- <input name="Tremors" id="tremors" type="text"
																	class="form-control border-input" placeholder=" " value="" maxlength="500"/> -->
																			<textarea name="Tremors" id="Tremors"
																				class="form-control" placeholder="Tremors"
																				maxlength="500"></textarea>
																		</div>
																	</div>
																</div>

																<div class="col-md-4">
																	<div class="form-group row">
																		<label class="col-md-5 col-form-label">Others
																		</label>
																		<div class="col-md-7">
																			<!-- <input name="Others" id="others" type="text"
																	class="form-control border-input" placeholder=" " value="" maxlength="500"/> -->
																			<textarea name="Others" id="others"
																				class="form-control" placeholder="Others"
																				maxlength="500"></textarea>
																		</div>
																	</div>
																</div>

															</div>

														</div>
														
													</div>




													<div class="col-md-6">
														<div class="form-group row">
															<div class="col-md-3">
																<label for="service" class="col-form-label">Final
																	Observation</label>
															</div>
															<div class="col-md-9">
																<textarea class="form-control" id="remarksForReferal"
																	name="remarksForReferal" rows="2" maxlength="100"></textarea>
															</div>
														</div>
													</div>
												</div>


												<!---------------------- Approved Section ---------------------->

												<!---------------------- Pending Section ---------------------->

												<div class="opdMain_detail_area" Id="pendingMedicalExam"
													style="display: none;">
													<h4 class="service_htext">Pending</h4>

													<div class="row">
														<div class="col-md-4">
															<div class="form-group row">
																<div class="col-md-5">
																	<label for="service" class="col-form-label">Next
																		Appointment Date</label>
																</div>
																<div class="col-md-7">
																	<div class="dateHolder">
																		<input id="nextAppointmentDate"
																			name="nextAppointmentDate"
																			class="form-control noBack_date2" placeholder="DD/MM/YYYY" >
																	</div>
																</div>
															</div>
														</div>

														<div class="col-md-8">
															<div class="form-group row">
																<div class="col-md-2">
																	<label for="service" class="col-form-label">Final
																		Observation</label>
																</div>
																<div class="col-md-10">
																	<textarea class="form-control" id="remarksPending"
																		name="remarksPending" rows="2" maxlength="100"></textarea>
																</div>
															</div>
														</div>
													</div>

												</div>

												<!---------------------- Reject Section ---------------------->

												

											
										<!--  -->


										<div class="opdMain_detail_area uneditableEditor">
											
											<h4  class="service_htext">Final Observation And Medical Category By MO</h4>
											
											<div class="row">
											<div class="col-md-8">
												<div class="form-group row">
													<div class="col-md-3">
														<label for="service" class="col-form-label">Final Observation</label>
													</div>
													<div class="col-md-9">
														<!-- <input type="text" name="finalObservationMo" id="finalObservationMo"class="form-control" disabled /> -->
														<!-- <textarea name="finalObservationMo" id="finalObservationMo"class="form-control" disabled></textarea> -->
														
														 <div id="finalObservationMoJ">
														</div>
													 <input type="hidden" name="finalObservationMo" id="finalObservationMo" value=""/>  
														
													</div>
												</div>
											</div>
											
											<!-- <div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Medical Category</label>
													</div>
													<div class="col-md-7">
														<input type="text" name="medicalCategoryMo" id="medicalCategoryMo" class="form-control" disabled />
													</div>
												</div>
											</div>
											 -->
											<div class="col-md-8">
												<div class="form-group row">
													<div class="col-md-3">
														<label for="service" class="col-form-label">Signed By</label>
													</div>
													<div class="col-md-9">
														<input type="text" name="signedByMo" id="signedByMo"class="form-control" disabled/>
													</div>
												</div>
											</div>
											</div>
										</div>
										
										<div class="opdMain_detail_area" >
													<h4 class="service_htext">Action</h4>
												<div class="row">

													<div class="col-md-4">
														<div class="form-group row">
															<div class="col-md-5">
																<label for="service" class="col-form-label">Action</label>
															</div>
															<div class="col-md-7">
																<select class="form-control" id="actionMe"
																	name="actionMe" onChange="return changeAction(this);">
																	<option value="0">Select</option>
															<option   value="approveAndClose">Approve and Close</option>
															<option   value="approveAndForward">Recommended and forward</option>
															<!-- <option   value="referred">Referred</option> -->
															<option   value="reject">Reject</option>
															<!-- <option   value="pending">Pending</option> -->
																</select>

															</div>
														</div>
													</div>

													<div class="col-md-4">
														<div class="form-group row" style="display: none;"
															id="forwardStatus">
															<div class="col-md-5">
																<label for="service" class="col-form-label">Forward
																	To</label>
															</div>
															<div class="col-md-7" id="forwardTo">
																<!-- <select class="form-control">
															<option value="0">Select</option>
															
														</select> -->

															</div>
														</div>
													</div>


													<div class="col-md-4">
														<div class="form-group row" style="display: none;"
															id="designationMeId">
															<div class="col-md-5">
																<label for="service" class="col-form-label">Designation
																</label>
															</div>
															<div class="col-md-7" id="designationForMe">
																<select class="form-control">
																	<option value="0">Select</option>

																</select>

															</div>
														</div>
													</div>



												</div>
												</div>
										
										
										
										<div class="opdMain_detail_area" Id="rejectMedicalExam"
													style="display: none;">
													<h4 class="service_htext">Reject</h4>

													<div class="row">
														<div class="col-md-12">
															<div class="form-group row">
																<div class="col-md-2">
																	<label for="service" class="col-form-label">Reason
																		for Rejection</label>
																</div>
																<div class="col-md-10">
																	<textarea class="form-control" id="remarksReject"
																		name="remarksReject" rows="2" maxlength="100"></textarea>
																</div>
															</div>
														</div>
													</div>

												</div>
										
										<div class="opdMain_detail_area uneditableEditorView">
											
											<!-- <h4 class="service_htext">Final Observation By Approving Authority</h4> -->
											<h4 class="service_htext">Final Observation By OC Unit/Ship</h4>
											<div class="row">
											<div class="col-md-8">
												<div class="form-group row">
													<div class="col-md-3">
														<label for="service" class="col-form-label">Final Observation</label>
													</div>
													<div class="col-md-9">
														<!-- <input type="text" name="finalObservationRmo" id="finalObservationRmo" class="form-control"/> -->
														<!-- <textarea name="finalObservationRmo" id="finalObservationRmo" class="form-control"></textarea> -->
														<div id="finalObservationRmoJ">
														</div>
													 <input type="hidden" name="finalObservationRmo" id="finalObservationRmo" value=""/>  
													
													</div>
												</div>
											</div>
											
											<!-- <div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Remarks</label>
													</div>
													<div class="col-md-7">
														<input type="text" name="remarksRmo" id="remarksRmo" class="form-control"/>
													</div>
												</div>
											</div>
											 -->
											<div class="col-md-8">
												<div class="form-group row">
													<div class="col-md-3">
														<label for="service" class="col-form-label">Signed By</label>
													</div>
													<div class="col-md-9">
														<input type="text" name="signedByRMo" id="signedByRMo" class="form-control" disabled />
													</div>
												</div>
											</div>
											</div>
										</div>
									
										</div>
										
										</div>

										<c:choose>
											<c:when test="${approvalFlag =='n'}">
												<div class="row m-t-10 clearfix">
													<div class="col-md-12 text-right">

														<input type="button" id="submitMAForma18"
															class="btn btn-primary"
															onclick="return submitMAForm18('draftRMo18');" value="Submit" />
														<input type="button" id="reset" class="btn btn-danger"
															onClick="document.location.reload(true);" value="Reset" />
												 
													</div>
												</div>
											</c:when>
											
								<c:when test="${approvalFlag =='y'}">
									<div class="row m-t-10">
											<div class="col-md-12 text-right">
											
											<input type="button" id="closebtn" class="btn btn-primary" onclick="return returnApproval('${menustatus}')"
															value="Close"/>					
											</div>
											
										</div>
									</c:when>
											<c:otherwise>

											</c:otherwise>
										</c:choose>


									</div>
									
										
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


<div class="modal" id="messageForDesignation" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<span class="Message_htext"><spring:message
								code="lblMessageForDesignation" /></span>

						<button type="button" onClick="closeMessage();" class="close"
							data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>

					</div>
					<div class="modal-body">
						<div class="control-group">

							<div class="col-md-12">
								<div class="form-group ">
									<span><spring:message code="msgDesignation" /></span><span
										id="designationName"></span>. <br />
									<spring:message code="msgDesignation2" />
									&#63;


								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" id="submitMOFormByModel18Diaglog" data-dismiss="modal"
							onClick="submitMOFormByModel18();" aria-hidden="true">
							<spring:message code="btnOK" />
						</button>
						<button class="btn btn-primary" data-dismiss="modal"
							onClick="closeMessage();" aria-hidden="true">
							<spring:message code="btnClsoe" />
						</button>
					</div>
					
					
					
				</div>
			</div>
		</div>

<div class="modal" id="messageForResult" role="dialog">
		<div class="modal-dialog  modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message
							code="lblResult" /></span>

					<button type="button" onClick="closeMessage();" class="close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div class="modal-body">
					<div class="control-group">
						<input type="hidden" name="resultIdImagin" id="resultIdImagin" />
						<div class='divErrorMsg form-group row' id='errordiv'></div>
						<div class="form-group row" id="messageForAuthenticateMessae"></div>

						<div class="row">
								 
								<div class="col-md-5">
									<div class="form-group row">
										<label class="col-sm-5 col-form-label">Date Of Entry</label>
										<div class="col-sm-7">
											<div class="dateHolder dateRightPosition">
												<input class="noFuture_datePos form-control" type="text"
													 id="dateResult" name="dateResult" value="" placeholder="DD/MM/YYYY" >
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-5">
									<div class="form-group row">
										<label class="col-sm-5 col-form-label">Entered By</label>
										<div class="col-sm-7">
											<input class="form-control form-control-sm" type="text"
												placeholder="" id="entered_by" value="<%=session.getAttribute("firstName")%>" name="entered_by" readonly>
										</div>
									</div>
								</div>

								<div class="col-md-5">
									<div class="form-group row">
										<label class="col-sm-5 col-form-label">Result Date</label>
										<div class="col-sm-7">
											<div class="dateHolder dateRightPosition">
												<input class="noFuture_date_ResultDate  form-control" type="text"
													placeholder="DD/MM/YYYY"  id="investigationResultDateTemp" name="investigationResultDateTemp" value="">
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-5">
									<div class="form-group row">
										<label class="col-sm-5 col-form-label">Result No.</label>
										<div class="col-sm-7">
											<input class="form-control form-control-sm" type="text"
												placeholder="" id="resultNumberTemp" value="" name="resultNumberTemp" onblur="return setResultNumber(this);">
										</div>
									</div>
								</div>	
											

								<div class="col-12">
									<div class="form-group row">
										<label class="col-md-5 col-form-label">Result </label>
										<div class="col-12">
										
										<div id="editorOfResult"></div>
										
										</div>
									</div>
								</div>

						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" 
						onClick="saveResultInText();" aria-hidden="true">
						<spring:message code="btnOK" />
					</button>
					<button class="btn btn-primary" data-dismiss="modal"
						onClick="closeMessage();" aria-hidden="true">
						<spring:message code="btnClsoe" />
					</button>
				</div>
			</div>
		</div>
	</div>		
	<div class="modal" id="messageForResult" role="dialog">
		<div class="modal-dialog  modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message
							code="lblIndianCoastGuard" /></span>

					<button type="button" onClick="closeMessage();" class="close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div class="modal-body">
					<div class="control-group">
						<input type="hidden" name="resultIdImagin" id="resultIdImagin" />
						<div class='divErrorMsg form-group row' id='errordiv'></div>
						<div class="form-group row" id="messageForAuthenticateMessae"></div>

						<div class="row">
								 
								<div class="col-md-5">
									<div class="form-group row">
										<label class="col-sm-5 col-form-label">Date</label>
										<div class="col-sm-7">
											<div class="dateHolder">
												<input class="noFuture_date2 form-control" type="text"
													placeholder="" id="dateResult" name="dateResult" value="" placeholder="DD/MM/YYYY" >
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-5">
									<div class="form-group row">
										<label class="col-sm-5 col-form-label">Entered By</label>
										<div class="col-sm-7">
											<input class="form-control form-control-sm" type="text"
												placeholder="" id="entered_by" value="<%=session.getAttribute("firstName")%>" name="entered_by" readonly>
										</div>
									</div>
								</div>

								<div class="col-12">
									<div class="form-group row">
										<label class="col-md-5 col-form-label">Result </label>
										<div class="col-12">
										
										<div id="editorOfResult"></div>
										
										</div>
									</div>
								</div>

						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" data-dismiss="modal"
						onClick="saveResultInText();" aria-hidden="true">
						<spring:message code="btnOK" />
					</button>
					<button class="btn btn-primary" data-dismiss="modal"
						onClick="closeMessage();" aria-hidden="true">
						<spring:message code="btnClsoe" />
					</button>
				</div>
			</div>
		</div>
	</div>	
	
	<div class="modal" id="messageForResultSpeccilaist" role="dialog">
		<div class="modal-dialog  modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message
							code="lblSpecialistOpinion" /></span>

					<button type="button" onClick="closeMessage();" class="close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div class="modal-body">
					<div class="control-group">
						<div class='divErrorMsg form-group row' id='errordiv'></div>
						<div class="form-group row" id="messageForAuthenticateMessae"></div>

						<div class="row">
								 
								

								<div class="col-12">
									<div class="form-group row">
										<label class="col-md-5 col-form-label">Specialist Opinion </label>
										<div class="col-12">
										
										<div id="editorOfSpecialistOpinion"></div>
										
										</div>
									</div>
								</div>

						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary"
						onClick="saveSpecialistOpinionInTextMe();" aria-hidden="true">
						<spring:message code="btnOK" />
					</button>
					<button class="btn btn-primary" onClick="closeSubModal();"
						aria-hidden="true">
						<spring:message code="btnClsoe" />
					</button>
				</div>
			</div>
		</div>
	</div>

</div>
<div class="modal-backdrop show" style="display:none;"></div>
		<!-- ============================================================== -->
		<!-- End Right content here -->
		<!-- ============================================================== -->

	<!-- END wrapper -->
	
	<script>
	$(function(){
		if('${approvalFlag}'=='y'){ 
    	   	$j('.topbar,.side-menu').css('display','none');
    		$j('.noSideMen').addClass('backToLeft');
    	}
	});
	</script>
	<script type="text/javascript">
	
	var obsistyOverWeight='';
	$(function() {
		$("#editorOfResult").jqte();
		$("#editorOfSpecialistOpinion").jqte();
		
		$('.hisDivHide').each(function(){
			$(this).css({'display':'block'});
		});
	});
	
	function openResultModelSpecialist(item){
		$('.modal-backdrop ').show();
		var resultIdIm= $(item).closest('tr').find("td:eq(5)").find("textarea:eq(0)").attr("id");
		var resultView = $('#'+resultIdIm).val();
		
		if(resultView.includes("@@@###")){
			resultView=resultView.replace("@@@###","");
		}
		resultView=decodeHtml(resultView);
	 	$('#editorOfSpecialistOpinion').jqteVal(resultView);
	 	$('#messageForResultSpeccilaist').show();
		$('#resultIdSpecialistOpinion').val(resultIdIm);
	 	$('#messageForResultSpeccilaist').show();
	}
	
	
	function closeSubModal(){
		$('.modal-backdrop ').hide();
		$('#messageForResultSpeccilaist').hide();
	}
	
	  $(document).ready(function() {
        
        var data = ${ data };
        var listMasServiceType = data.listMasServiceType;	 
        
        $('#serviceNo').val(data.data[0].serviceNo);
		$('#employeeName').val(data.data[0].patientName);
		$('#age').val(data.data[0].age+"/"+data.data[0].gender);
		$('#meAgeForOn').val(data.data[0].meAgeNew+"/"+data.data[0].gender);
		$('#rank').val(data.data[0].rankName);
		$('#meType').val(data.data[0].meTypeName);
		$('#gender').val(data.data[0].gender);
		$('#patientId').val(data.data[0].patientId);
		$('#departmentId').val(data.data[0].departmentId);
		$('#dob').val(data.data[0].dateOfBirth);
		
		$('#totalService').val(data.data[0].totalService);
		$('#unitOrSlip').val(data.data[0].unit);
		$('#armCorpsBranchTrade').val(data.data[0].tradeBranch);
		$('#dateOfExam').val(data.data[0].dateOfExam);
		$('#opdPatientDetailId').val(data.data[0].opdPatientDetailId);
		$('#medCategory').val(data.data[0].medicalCategory);
		$('#doeORDoc').val(data.data[0].serviceJoinDate);
		
		/* if(data.data[0].medicalCategory!="" && data.data[0].medicalCategory!=null && data.data[0].medicalCategory!=undefined && data.data[0].fitFlag!='F')
			$('#medicalCompositeName').val(data.data[0].medicalCategory);
			if(data.data[0].medicalCategoryDate!="" && data.data[0].medicalCategoryDate!=null && data.data[0].medicalCategoryDate!=undefined && data.data[0].fitFlag!='F')
			$('#medicalCompositeDate').val(data.data[0].medicalCategoryDate);
			if(data.data[0].medicalCompositeNameValue!=null && data.data[0].medicalCompositeNameValue!="" && data.data[0].medicalCompositeNameValue!=undefined && data.data[0].fitFlag!='F')
				$('#medicalCompositeNameValue').val(data.data[0].medicalCompositeNameValue);
 */

		
		$('#authority').val(data.data[0].authority);
		 $('#place').val(data.data[0].place);
		// $('#dateAME').val(data.data[0].dateAME);
		 $('#genderId').val(data.data[0].genderId);
        $('#checkupDate').val(today);
        
        $('#identificationMarks1').val(data.data[0].identificationMarks1);
		 $('#identificationMarks2').val(data.data[0].identificationMarks2);
		 $('#disabilityBeforeJoiningIdValue').val(data.data[0].disabilityBeforeJoining);
		 setSelectedValue("disabilityBeforeJoining",data.data[0].disabilityBeforeJoining);
		
		 
		 $('#authorityForBoard').val(data.data[0].authority);
		 $('#dateOfReport').val(data.data[0].dateOfReport);
		 $('#dateOfRelease').val(data.data[0].dateOfRelease);
		 $('#dateOfWitness').val(data.data[0].dateOfWitness);
		 
		 
		 
		 var serviceType=data.data[0].serviceType;
        if(listMasServiceType!=null && listMasServiceType.length>0){
			var masServiceTypeVal="";
       	 masServiceTypeVal += '<select class="form-control" id="serviceOfEmployee" name="serviceOfEmployee"';
        	masServiceTypeVal += 'class="medium">';
        	masServiceTypeVal += '<option value="0"><strong>Select</strong></option>';
        	for(var i=0;i< listMasServiceType.length ;i++){
        		var selectedV='';
        	
        		if(serviceType==listMasServiceType[i].serviceTypeId){
        			selectedV= "selected";
        		}
        		 else{
        			selectedV='';
        		} 
        		masServiceTypeVal += '<option   '+selectedV+'  value="' + listMasServiceType[i].serviceTypeId+ '"  >'
											+ listMasServiceType[i].serviceTypeName
											+ '</option>';
        		}
        	masServiceTypeVal += '</select>';
        	}
        	$('#serviceOfEmployee').html(masServiceTypeVal);
        	
        	$('#maritalStatus').val(data.data[0].marritalStatus);
        	$('#permanentAddress').val(data.data[0].address);
        	$('#particularsOfPreviousService').val(data.data[0].particularsOfPreviousService);
        	
        	var selectedValue="";
        	if(data.data[0].disabilityPensionRecieved!=null && (data.data[0].disabilityPensionRecieved=='Y' || data.data[0].disabilityPensionRecieved=='y')){
        		selectedValue="Yes";
        	}
        	else{
        		selectedValue="No";
        	}
        	setSelectedValue("disabilityPensionRecieved",selectedValue);
        	setSelectedValue("claimAnyDisability",data.data[0].claimAnyDisability);
        	
        	$('#serviceNoForEmployee').val(data.data[0].serviceNoEmployee);
        	$('#anyOtherInformation').val(data.data[0].anyOtherInformation);
        	
        	$('#signatureOfWitness').val(data.data[0].signatureOfWitness);
        	
			$('#witnessOfEmployee').val(data.data[0].witnessId);
        	
        	$('#signatureOfIndividualId').val(data.data[0].signatureOfIndividualId);
        	
        	$('#signatureOfIndividual').val(data.data[0].signatureOfIndividual);
        	
        	$('#rankForEmployee').val(data.data[0].rankOfEmployee);
        	
         	$('#serviceNoOfCertificate').val(data.data[0].carefullyExaminedServiceNo);
     		$('#rankOfCertificate').val(data.data[0].carefullyExaminedRank);
     		$('#nameOfCertificate').val(data.data[0].carefullyExaminedEmployeeName);
     		$('#unitCertificate').val(data.data[0].carefullyUnitName);
        
     		if(data.data[0].gender!=null && (data.data[0].gender=='MALE' || data.data[0].gender=='Male')){
     	        	$('#brestId').hide();
     	        	$('#gynaecologicalExam').hide();
     	        }
     	        else{
     	        	$('#brestId').show();
     	        	$('#gynaecologicalExam').show();
     	        }
        	
     		 		
				$('#fitInMedicalCategory').val(data.data[0].medicalCategory);
				// $('#medicalCategoryMo').val(data.data[0].medicalCategory);
				 $('#designationIdValue').val(data.data[0].forwardedDesignationId);
				
				 
			        
			    
			     if(data.data[0].fitFlag=='F'){
			         	$("#fitInChk").prop("checked", true);
			         	masMedicalCategoryListForMe();
			         }
			     
			     if(data.data[0].ridcId!="" && data.data[0].ridcId!=null){
						$('#uploadFileMedicalExam').hide();
			        	$('#viewUploadedFile').show();
			        	var viewUploadedFile="";
			        	viewUploadedFile += '<a class="btn-link" href="#" onclick="viewDocumentForDigi('+data.data[0].ridcId+');" >View Document</a>'
			    		$('#viewUploadedFile').html(viewUploadedFile);	
			        	
			        }
					else{
						$('#uploadFileMedicalExam').show();
					}
			     
			 	if(data.data[0].meRidcId!="" && data.data[0].meRidcId!=null){
					$('#uploadFileMedicalExamOldDocument').hide();
		        	$('#viewUploadedFileOldDoc').show();
		        	var viewUploadedFile="";
		        	viewUploadedFile += '<a class="btn-link" href="#" onclick="viewDocumentForDigi('+data.data[0].meRidcId+');" >View Document</a>'
		        	//viewUploadedFile+="<button id ='printBtn' type='button'  class='btn btn-primary' onclick='viewDocumentForDigi("+data.data[0].ridcId+");'>View Document</button>";
		    		$('#viewUploadedFileOldDoc').html(viewUploadedFile);	
		        	
		        }
				else{
					$('#uploadFileMedicalExamOldDocument').show();
				}   	
	        	
	        	if(data.data[0].meRidcIdForVisit!="" && data.data[0].meRidcIdForVisit!=null){
		        	var viewUploadedFile="";
		        	viewUploadedFile += '<a   href="#"  onclick="viewDocumentForDigi('+data.data[0].meRidcIdForVisit+');" class="btn btn-primary btn-block" >View Original Document</a>'
		    		$('#originalDoc').html(viewUploadedFile);	
		        	$('#originalDoc').show();
		        }
				else{
					$('#originalDoc').hide();
				}
			     
			     
			     if(data.data[0].rankId!="" && data.data[0].rankId!=null && data.data[0].rankId!=undefined)
			     $('#rankId').val(data.data[0].rankId);
			       if(data.data[0].unitIdOn!="" && data.data[0].unitIdOn!=null && data.data[0].unitIdOn!=undefined)
						$('#unitIdOn').val(data.data[0].unitIdOn);
					if(data.data[0].branchOrTradeIdOn!="" && data.data[0].branchOrTradeIdOn!=null && data.data[0].branchOrTradeIdOn!=undefined)
						$('#branchOrTradeIdOn').val(data.data[0].branchOrTradeIdOn);	

					 if (obsistyOverWeight!=null && obsistyOverWeight!="")
						{
				        	obsistyMark=obsistyOverWeight;
						}
				        
					 if (data.data[0].obsistyCloseDate == "" ) {
				    	   
				           if(data.data[0].obesityOverWeightFlag == "Y")
				        	{
				        	   document.getElementById('obsistyCheckAlready').value ="exits";
				        	   $("#overCheck").prop("checked", true);
				        	 	$("#overWeightDropDown").show();
								$('#obsistyMark').val("Y");
								
								$('.makeDisabled input,.makeDisabled select').prop("disabled", true);
								//overWeight("Y");	
				        	}	
				        	else
				        	{
				        		document.getElementById('obsistyCheckAlready').value ="exits";
				        		$("#obsistyCheck").prop("checked", true);
								$("#overWeightDropDown").hide();
								$('#obsistyMark').val("N");
								$('.makeDisabled input,.makeDisabled select').prop("disabled", true);
								//overWeight("N");
				        	}	
				          }   
					 if(data.data[0].relation!=null && data.data[0].relation==resourceJSON.relationName){
				       	 $('#markObesityId').show();
				       }
				       else{
				      
				       $('#markObesityId').hide();
				       } 
					
					
					
		//getDiagnosisValue();
		//masMedicalCategoryList();
		getServiceDetail();
		getDiseaseWoundInjuryDetails();
		//getPatientReferalDetailME();
		//if(data.data[0].fitFlag!='F'){
		//getMBPreAssesDetailsData();
		//}
		openGeneralDocAndInvForDigi('Lab');
		getAFMSF3BInvestigationForMOOrMA();
		getAFMSF3BForMOOrMA18();
		getUnitDetail();
	  });
    
	 
	
	</script>
<script>


$('#finalObservationMoJ').jqte();
$('#finalObservationRmoJ').jqte();
$('.uneditableEditor .jqte_editor').attr('contenteditable','false');
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
	 }else if(buttonId=="button16"){
			test('related'+buttonId,"newpost16");
	 }
	 else if(buttonId=="button17"){
			test('related'+buttonId,"newpost17");
	 }
	 else if (buttonId == "button20") {
			test('related' + buttonId, "newpost20");
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
	 var investigationForUom = "";
	 
	 				function getInveeeeeeeeMMMMMMMMMM18() {
	 					var radioValue = labRadioValue;
	 					invesRadio = radioValue;
	 					var pathname = window.location.pathname;
	 					var accessGroup = "MMUWeb";

	 					var url = window.location.protocol + "//"
	 							+ window.location.host + "/" + accessGroup
	 							+ "/medicalexam/getInvestigationListUOM";
	 						$.ajax({
	 								type : "POST",
	 								contentType : "application/json",
	 								url : url,
	 								data : JSON.stringify({
	 									'employeeId' : <%=userId%>,
	 									'mainChargeCode' : radioValue,
	 								}),
	 								dataType : 'json',
	 								timeout : 100000,
	 								success : function(res) {

	 									var data = res.InvestigationList;
	 									investigationForUom = res.InvestigationList;
	 									if (data != null && data.length > 0)
	 										for (var i = 0; i < data.length; i++) {
	 											var investigationNewUpdate = data[i];
	 											var investigationId = investigationNewUpdate[0];
	 											var investigationName = investigationNewUpdate[1];
	 											if (investigationNewUpdate[3] != null)
	 												var uomName = investigationNewUpdate[3];
	 											var inves = investigationName
	 													+ "["
	 													+ investigationId
	 													+ "]"
	 											arryInvestigation
	 													.push(inves);

	 										}
	 								},
	 								error : function(jqXHR, exception) {
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
	 										msg = 'Uncaught Error.\n'
	 												+ jqXHR.responseText;
	 									}
	 									alert(msg);
	 								}
	 							});
	 				}

	
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
					$('#idealWeight').attr("readonly",true);
		           
					
				    }
				   	   	   else
				   	   		   {
				   	   		   	alert("Ideal Weight Not Configured")
				   	   		   	$('#idealWeight').val();
								$('#idealWeight').removeAttr("readonly");
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
			var a = document.getElementById("idealWeight").value;
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
		 			var cal1 = eadd * 100 / a
		 			var n1 = cal1.toFixed(2);
		 			$('#overWeight').val("+" +n1);
		 		}
		        }
			}
		
		 var charge_code_array = [];
		 var ChargeCode = '';
		 var multipleChargeCode = new Array();
		 function populateChargeCode(val, count, item) {

		 	//	if(validateMetaCharacters(val)){

		 	if (val != "") {

		 		var index1 = val.lastIndexOf("[");
		 		var indexForChargeCode = index1;
		 		var index2 = val.lastIndexOf("]");
		 		index1++;
		 		ChargeCode = val.substring(index1, index2);

		 		var indexForChargeCode = indexForChargeCode--;
		 		if (ChargeCode == "") {
		 			return;
		 		} else {
		 			var uomName = '';
		 			var minNormalValue = "";
		 			var maxNormalValue = "";
		 			var investigationType="";
					var mainChargeCodeIds="";
					var subChargeCodeIds="";
				
		 			for (var i = 0; i < investigationForUom.length; i++) {
		 				// var pvmsNo1 = data[i].pvmsNo;
		 				var masInvestigationValues = investigationForUom[i];
		 				var chargeCodeUom = masInvestigationValues[0];

		 				if (ChargeCode == chargeCodeUom) {

		 					if (masInvestigationValues[2] != null
									&& masInvestigationValues[2] != "")
								investigationType = masInvestigationValues[2];//UOM Name;
		 					
		 					
		 					if (masInvestigationValues[3] != null
		 							&& masInvestigationValues[3] != "")
		 						uomName = masInvestigationValues[3];//UOM Name;

		 					if (masInvestigationValues[5] != null
		 							&& masInvestigationValues[5] != "")
		 						minNormalValue = masInvestigationValues[5];//minNormalValue;

		 					if (masInvestigationValues[6] != null
		 							&& masInvestigationValues[6] != "")
		 						maxNormalValue = masInvestigationValues[6];//minNormalValue;
		 					var minMaxValue = minNormalValue + "-"
		 							+ maxNormalValue;

		 					
		 					
		 					if (masInvestigationValues[7] != null
									&& masInvestigationValues[7] != "")
								subChargeCodeIds = masInvestigationValues[7];// subCharge Code Id
						
								
								if (masInvestigationValues[8] != null
										&& masInvestigationValues[8] != "")
									mainChargeCodeIds = masInvestigationValues[8];//Main charge code id

		 					
		 					
		 					var checkCurrentRowIddd = $(item).closest('tr')
		 							.find("td:eq(1)").find("input:eq(3)").attr("id");
		 					var checkCurrentRow = $(item).closest('tr').find("td:eq(1)").find("input:eq(3)").val();
		 					var count = 0;
		 					var checkForDuplicate=0;
		 					$('#dgInvetigationGrid tr').each(
		 									function(i, el) {
		 										var $tds = $(this).find('td');
		 										var chargeCodeId = $($tds).closest('tr').find("td:eq(1)").find("input:eq(3)").attr("id");
		 										var chargeCodeIdValue = $('#' + chargeCodeId).val();
		 										var idddd = $(item).closest('tr').find("td:eq(1)").find("input:eq(3)").attr("id");
		 										var currentidddd = $(item).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
		 										/*if (chargeCodeId != checkCurrentRowIddd
		 												&& ChargeCode == chargeCodeIdValue) {
		 											if (ChargeCode == chargeCodeIdValue) {
		 												checkForDuplicate++;
		 												alert("Investigation is already added");
		 												$('#' + idddd).val("");
		 												$('#' + currentidddd).val("");
		 												$('#'+ chargeCodeIdValue).val("");
		 												return false;
		 											}
		 										} else {*/
		 											$(item).closest('tr').find("td:eq(1)").find("input:eq(3)").val(ChargeCode);
		 											$(item).closest('tr').find("td:eq(2)").find("input:eq(0)").val(uomName);
		 											$(item).closest('tr').find("td:eq(4)").find("input:eq(0)").val(minMaxValue);

		 											
		 											$(item).closest('tr').find("td:eq(1)").find("input:eq(8)").val(investigationType);
													$(item).closest('tr').find("td:eq(1)").find("input:eq(9)").val(subChargeCodeIds);
													$(item).closest('tr').find("td:eq(1)").find("input:eq(10)").val(mainChargeCodeIds);
		
		 										//}
		 									});
		 					
	 						if(investigationType!="" &&  checkForDuplicate==0 &&( investigationType=='s' ||investigationType=='t') ){
	 							var idResult= $(item).closest('tr').find("td:eq(3)").find("input:eq(1)").attr("id");
	 							 $('#'+idResult).val("@@@###");
	 							}
	 							if(investigationType!="" &&  checkForDuplicate==0 && investigationType=='m' && ChargeCode!="")
	 								getSubInvestigationHtmlForMe(ChargeCode,item);
	
		 					
		 				}
		 			}
		 		}

		 	}
		 }
		
		 var approvalFlag=$('#approvalFlag').val();
		 
			if(approvalFlag=='y'){
			   diasableFormField(menustatus);	
			}
			
			
			var todayDate="";
	    	$(document).ready(function() {
	    		todayDate = new Date();
	    	var dd = String(todayDate.getDate()).padStart(2, '0');
	    	var mm = String(todayDate.getMonth() + 1).padStart(2, '0');
	    	var yyyy = todayDate.getFullYear();

	    	//today =  yyyy + '-' + mm + '-' +dd;

	    	todayDate = dd + '/' + mm + '/' + yyyy;
	    	//document.write(today);
	    	$('#dateResult').val(todayDate);
	    });  
	      		
			
  </script>
</body>

</html>