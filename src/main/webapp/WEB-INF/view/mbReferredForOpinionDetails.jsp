<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
  <%@include file="..//view/commonJavaScript.jsp"%> 
  
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Refer for Opinion and Medical Board </title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
     <!-- <link href="//resources/css/icons1.css" rel="stylesheet" type="text/css" /> -->
     <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/uploaddig.js"></script>
     <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autoPopulate.js"></script>
      <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/commonformodal.js"></script>
     <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/medicalBoard.js"></script>
      <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
     <script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
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
	getRefferalDetailsMedicalCat();
      
});

</script> 
</head>
<body>
 <div id="wrapper">

	<form:form name="mbReferforOpinionDeatils" id="mbReferforOpinionDeatils" method="post" enctype='multipart/form-data'
											action="#" autocomplete="on">
											
		<input type="hidden" name="radioInvAndImaValue"id="radioInvAndImaValue" value="Lab" />
										<input  name="labImaginId" id="labImaginId" type="hidden" value="" />
									<input type="hidden" name="totalLengthDigiFile" id="totalLengthDigiFile" value="0" />
									<input type="hidden" name="totalLengthDigiFileRefer" id="totalLengthDigiFileRefer" value="0" />
									<input  name="obsistyCheckAlready" id="obsistyCheckAlready" type="hidden" value="" />
									<input type="hidden" name="currentObjectForResultOffLineDate" id="currentObjectForResultOffLineDate" value=""/>
									<input type="hidden" name="currentObjectForResultOffLinenumber" id="currentObjectForResultOffLinenumber" value=""/>
									<input type="hidden" name="saveInDraft" id="saveInDraft" value="draftMo"/>
									<input type="hidden" name="actionMe" id="actionMe" value="approveAndClose"/>
									<input type="hidden" name="dateOfExam" id="dateOfExam" value=""/>
	<div class="content-page">
		<!-- Start content -->
		  <div class="col-md-4">
					<div id="successmsg" style="color:green; align:center;">
										${message}
					</div>
		  </div>
		<div class="">
		
			<div class="container-fluid">
				<div class="internal_Htext">Refer for Opinion and Medical Board</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">								
									
									<!---------------------- Patient Details ---------------------->
									<div class="adviceDivMain" id="button1" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Patient Details</span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton1" value="-" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost1" style="display:block;">  
										<div class="row">
										 <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-4 col-form-label">Service No.</label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control custom_date" name="fromDate" id="service_no" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-4 col-form-label">Name</label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control custom_date" name="fromDate" id="name" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-4 col-form-label">Age</label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control custom_date" name="fromDate" id="age" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-4 col-form-label">Gender</label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control custom_date" name="fromDate" id="gender" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-4 col-form-label">Rank</label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control custom_date" name="fromDate" id="rank" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-4 col-form-label">MB Type</label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control custom_date" name="fromDate" id="mb_type" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-5">
                                                                                   <input type="hidden" id="visitId" name="visitId" value="">
                                                                                </div>
                                                                                <div class="col-md-7">
                                                                                   <input type="hidden" id="genderId" name="genderId" value="">
                                                                                </div>
                                                                                
                                                                                   <div class="col-md-6">
                                                                                    <input type="hidden" id="patientId" name="patientId" value="">
                                                                                    <input type="hidden" id="ageNumber" name="ageNumber" value=""/>
                                                                                </div>
                                                                                 <div class="col-md-6">
                                                                                    <input type="hidden" id="hospitalId" name="hospitalId" value="<%=hospitalId%>"/>
                                                                                </div>
                                                                                 <div class="col-md-6">
                                                                                    <input type="hidden" id="userId" name="userId" value="<%=userId%>"/>
                                                                                </div>
										</div>
									</div>
										
									<!---------------------- Present Medical Category Details ---------------------->
									
									<div class="adviceDivMain" id="button2" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Present Medical Category (Composite)</span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton2" value="-" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost2">
										<table class="table table-hover table-striped table-bordered">
	                                        <thead class="bg-success" style="color:#fff;">
													<tr>
														<th id="th1">Medical Category</th>
														<th id="th2">Date of Category</th>
														 
													</tr>
												</thead>
												<tbody>
												  <tr>
												    <td><input id="medicalCompositeName" type="text" class="form-control" readonly /></td>
													<td><input id="medicalCompositeDate" type="text" class="form-control" readonly /></td>
												    								  
												  </tr>											 
												 
												</tbody>											
											</table>
										
									</div>
									
									
									<!---------------------- List of Medical Category Details ---------------------->
									
									<div class="adviceDivMain" id="button3" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>List of Medical Category</span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton3" value="-" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost3">
									
										 <table class="table table-hover table-striped table-bordered">
	                                        <thead class="bg-success" style="color:#fff;">
													<tr>
													    <th id="th1">Select</th>
                                                        <th id="th2" style="    width: 275px;">Diagnosis</th>
                                                        <th id="th3">Medical Category</th>
                                                        <th id="th4" style="width:80px;">System</th>
                                                        <th id="th5">Type of Category</th>
                                                        <th id="th7" style="width: 80px;">Duration</th>
                                                        <th id="th6">Category Date</th>
                                                        <th id="th8">Next Category Date </th>
                                                                                
													</tr>
												</thead>
												<tbody id="medicalCategory">
                                                                     
												  												  
												</tbody>											
											</table>
									
									</div>	
										
								 
									<!---------------------- Vitals Details ---------------------->
									
									<div class="adviceDivMain" id="button4" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Vital Details</span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton4" value="-" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10 m-t-10"  id="newpost4">
										<div class="row">
										<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Height</label>
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
																<input name="height" id="height"
																	onblur="idealWeight();checkBMI();" maxlength="3"
																	type="text" class="form-control border-input"
																	onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																	placeholder="Height" value="" required />
																<div class="input-group-append">
														      <div class="input-group-text">cm </div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Ideal Weight </label>
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
																<input name="ideal_weight" id="ideal_weight" type="text"
																	onblur="checkVaration()"
																	onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																	class="form-control border-input"
																	placeholder="Ideal Weight" maxlength="5" />
																<div class="input-group-append">
														      <div class="input-group-text">kg </div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-4 col-form-label">Weight </label>
													<div class="col-md-8">
														<div class="input-group mb-2 mr-sm-2">
																<input name="Weight" id="weight"
																	onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																	type="text" class="form-control border-input"
																	onblur="checkVaration();checkBMI();" maxlength="5"
																	placeholder="Weight" />
																<div class="input-group-append">
														      <div class="input-group-text">kg </div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Variation in weight </label>
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
																<input name="Variation in Weight" id="variant_in_weight"
																	type="text" class="form-control border-input"
																	onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																	placeholder="Variation in Weight" value="" readonly />
																<div class="input-group-append">
														      <div class="input-group-text">% </div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Temperature </label>
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
																<input name="tempature" maxlength="8" id="tempature"
																	type="text" class="form-control border-input"
																	onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																	placeholder="Temperature" value="" required>
																<div class="input-group-append">
														      <div class="input-group-text">&deg;F </div>
														    </div>																			    
														  </div>
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-4 col-form-label">Pulses </label>
													<div class="col-md-8">
														<div class="input-group mb-2 mr-sm-2">
																<input name="pulse" id="pulse" type="text"
																	class="form-control border-input"
																	onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																	placeholder="Pulse" value="" maxlength="8" />
																<div class="input-group-append">
														      <div class="input-group-text">/min </div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">SpO2 </label>
													<div class="col-md-7">
															
														<div class="input-group mb-2 mr-sm-2">
																<input name="spo2" id="spo2" type="text"
																class="form-control border-input" placeholder="SpO2"
																value=""
																onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																maxlength="30" />
																<div class="input-group-append">
														      <div class="input-group-text">%</div>
														    </div>
														    
														  </div>			
													</div>
													 
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">BMI </label>
													<div class="col-md-7">
															
															<div class="input-group mb-2 mr-sm-2">
																<input name="bmi" id="bmi" type="text"
																class="form-control border-input" placeholder="BMI"
																value=""
																onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																readonly />
																<div class="input-group-append">
														      <div class="input-group-text">kg/m2</div>
														    </div>
														    
														  </div>
														</div>
													 
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-3 col-form-label">BP</label>
													
													<div class="col-md-3 offset-md-1">
														
															<input name="bp" id="bp" type="text" class="form-control border-input bpSlash" placeholder="SBP" value="" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;">
															<span></span> <!-- slash for bp -->
														  
													</div>
													<div class="col-md-5">
														<div class="input-group mb-2 mr-sm-2">
															<input name="bp1" id="bp1" type="text" maxlength="3"
																onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																class="form-control border-input bpSlash" placeholder="DBP"
																value="" required> 
														    <div class="input-group-append">
														      <div class="input-group-text p-rl-5">mmHg</div>
														    </div>
														  </div>
													</div>
													
													
												</div>
											</div>
											
											
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">RR </label>
													<div class="col-md-7">
															
																
															<div class="input-group mb-2 mr-sm-2">
																<input name="rr" id="rr" type="text"
																class="form-control border-input" placeholder="RR"
																value=""
																onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																maxlength="3" />
																<div class="input-group-append">
														      <div class="input-group-text">/min</div>
														    </div>
														    
														  </div>
														</div>
													 
												</div>
											</div> 
											
											<!-- <div class="col-md-4">
												<div class="form-group row">
													
														<label for="service" class="col-md-3  col-form-label">BP</label>
													
													<div class="col-md-3 offset-md-1">

															<input name="bp" id="bp" type="text" maxlength="3"
																onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																class="form-control border-input bpSlash" placeholder="SBP"
																value="" required> 
													<span></span> slash for bp
														  
													</div>
													<div class="col-md-5">
														<div class="input-group mb-2 mr-sm-2">
																<input name="bp1" id="bp1" type="text" maxlength="3"
																	onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																	class="form-control border-input bmiInput"
																	placeholder="DBP" value="" required>
																<div class="input-group-append">
														      <div class="input-group-text p-rl-5">mm/Hg</div>
														    </div>
														  </div>
													</div>
												</div>
											</div> -->
											<div class="col-md-5">
												<div class="form-group row">
													<div class="col-md-9 makeDisabled">
													<div class="form-check form-check-inline cusRadio m-t-5">
															<input type="radio" value="N" class="form-check-input radioCheckCol2"
																name="ObesityCheck" id="obsistyCheck" onchange="overWeight(this.value)" />
															<span class="cus-radiobtn"></span> 
															<label id="obsistyCheckText" class="form-check-label" for="obsistyCheck">Obesity</label>
														</div>
														
													<div class="form-check form-check-inline cusRadio">
															<input type="radio" value="Y" class="form-check-input radioCheckCol2"
																name="ObesityCheck" id="overCheck"
																onchange="overWeight(this.value)" />
															<span class="cus-radiobtn"></span> 
															<label id="overCheckText" class="form-check-label" for="overCheck">Overweight</label>
															
														</div>
													<div class="form-check form-check-inline cusRadio">
															<input type="radio" value="none" class="form-check-input radioCheckCol2"
																name="ObesityCheck" id="noneCheck"
																onchange="overWeight(this.value)" />
															<span class="cus-radiobtn"></span> 
															<label id="noneText" class="form-check-label" for="noneCheck">None</label>
															
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
										</div>
									</div>
									</div>
									</div>
											
									<!---------------------- Investigation Details ---------------------->
										
									<div class="adviceDivMain" id="button5" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Investigation</span>
										</div>
										<input class="buttonPlusMinus" tabindex="5" name="" id="relatedbutton5" value="-" onclick="showhide(this.id)" type="button">
									</div>
									
									<div class="hisDivHide p-10 m-t-10"  id="newpost5">
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
													<label class="form-check-label" for="imag_radio">Imaging &nbsp/Others </label>
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
																<!-- 	<input type="text" autocomplete="off" value=""
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
																	onclick="addRowForInvestigationFunUpMb();" tabindex="1"></button>
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
															<th>File Upload <span class="mandate">(File name should not contain any special characters and should be jpg,pdf,jpeg,gif,png,mp4 only!)</span></th>
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
																id="fileInvUploadDyna" value="" onchange="return getFileUploadData(this);" disabled>
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
											<div class="row ">
										  <div class="col-12">
											<!-- <h4 class="service_htext" style="">Other Details</h4> -->
                                             <h6 class="text-theme text-underline font-weight-bold">
												Other Details</h6>	
                                             
											<!-- <div class="col-md-12">

												<div class="form-check form-check-inline">
													<input class="form-check-input" type="radio"
														name="inlineRadioOptions" id="inlineRadio1"
														value="option1"> <label class="form-check-label"
														for="inlineRadio1">Enter Here</label>
												</div>
												<div class="form-check form-check-inline">
													<input class="form-check-input" type="radio"
														name="inlineRadioOptions" id="inlineRadio2"
														value="option2"> <label class="form-check-label"
														for="inlineRadio2">Enter Via case sheet</label>
												</div>
											</div> -->


											<div class="row m-t-10">
														<div class="col-md-6">
															<div class="form-group row">
																<div class="col-md-3">
																	<label for="service" class="col-form-label">Clinical Notes</label>
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
												</div>
														<div class="">
															<div class="row">
																<div class="col-12">
																	<h6 class="text-theme font-weight-bold"> General Examination</h6>
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
																				maxlength="500">No</textarea>
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
																				maxlength="500">No</textarea>
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
																				maxlength="500">No</textarea>
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
																				maxlength="500">NAD</textarea>
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
																				maxlength="500">No</textarea>
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
																				maxlength="500">NAD</textarea>
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
																				maxlength="500">No</textarea>
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
																				placeholder="GCS" maxlength="500">15/15</textarea>
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
																				maxlength="500">Nil</textarea>
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
												<div class="row">
													<div class="col-md-12">
														<h6 class="text-theme font-weight-bold"> System Examination</h6>
													</div>
												</div>
                                                <div class="row">
													<div class="col-md-4">
														<div class="form-group row">
															<label class="col-md-5 col-form-label">CNS </label>
															<div class="col-md-7">
																<!-- <input name="CNS" id="cns" type="text" maxlength="25"
																	class="form-control border-input" placeholder="CNS" value="" /> -->
																	<textarea id="cns" class="form-control"  placeholder="CNS"  maxlength="500">NAD</textarea>
															</div>
														</div>
													</div>
													<div class="col-md-4">
														<div class="form-group row">
															<label class="col-md-5 col-form-label">Chest/
																Resp </label>
															<div class="col-md-7">
																<!-- <input name="Chest" id="chest" type="text" maxlength="25"
																	class="form-control border-input" placeholder="Chest/ Resp" /> -->
																	<textarea id="chest" class="form-control"  placeholder="Chest/ Resp"  maxlength="500">AEBE/NVBS</textarea>
															</div>
														</div>
													</div>
													<div class="col-md-4">
														<div class="form-group row">
															<label class="col-md-5 col-form-label">Musculoskeletal
															</label>
															<div class="col-md-7">
																<!-- <input name="Musculoskeletal" id="musculoskeletal" maxlength="25"
																	type="text" class="form-control border-input" placeholder="Musculoskeletal" /> -->
																	<textarea id="musculoskeletal" class="form-control"  placeholder="Musculoskeletal"  maxlength="500">NAD</textarea>
															</div>
														</div>
													</div>

													<div class="col-md-4">
														<div class="form-group row">
															<label class="col-md-5 col-form-label">CVS </label>
															<div class="col-md-7">
																<!-- <input name="CVS" id="cvs" type="text" maxlength="25"
																	class="form-control border-input" placeholder="CVS" value="" /> -->
																	<textarea id="cvs" class="form-control"  placeholder="CVS"  maxlength="500">S1,S2 normally heard</textarea>
															</div>
														</div>
													</div>

													<div class="col-md-4">
														<div class="form-group row">
															<label class="col-md-5 col-form-label">Skin </label>
															<div class="col-md-7">
																<!-- <input name="Skin" id="skin" type="text" maxlength="25"
																	class="form-control border-input" placeholder="Skin" value="" required> -->
																	<textarea id="skin" class="form-control"  placeholder="Skin"  maxlength="500">NAD</textarea>
															</div>
														</div>
													</div>

													<div class="col-md-4">
														<div class="form-group row">
															<label class="col-md-5 col-form-label">GI </label>
															<div class="col-md-7">
																<!-- <input name="GI" id="gi" type="text" maxlength="25"
																	class="form-control border-input" placeholder="GI" value="" required> -->
																	<textarea id="gi" class="form-control"  placeholder="GI"  maxlength="500">P/A-soft,non tender,no palpable organomegaly</textarea>
															</div>
														</div>
													</div>

													<div class="col-md-4">
														<div class="form-group row">
															<label class="col-md-5 col-form-label">Genito
																Urinary</label>
															<div class="col-md-7">
																<!-- <input name="geneticurinary" id="geneticurinary" maxlength="25"
																	type="text" class="form-control border-input" placeholder="Geneto Urinary" value="" /> -->
																	<textarea id="geneticurinary" class="form-control"  placeholder="Genito Urinary"  maxlength="500">NAD</textarea>
															</div>
														</div>
													</div>
                                      
													<div class="col-md-4">
														<div class="form-group row">
															<label class="col-md-5 col-form-label">Others </label>
															<div class="col-md-7">
																<!-- <input name="Others" id="others1" type="text" maxlength="25"
																	class="form-control border-input" placeholder="Others" value="" required> -->
																	<textarea id="others1" class="form-control"  placeholder="Others"  maxlength="500"></textarea>
															</div>
														</div>
													</div>

												</div>
                                              
											



												<div>										
											
											<!-- <h4 class="service_htext" style="">Final Observation</h4> -->
                                               <h6 class="text-theme text-underline font-weight-bold">
												Final Observation</h6>	
										
											<div class="tablediv" style="width:100%;">
												<h6 style="color: #000;">For Referral</h6>
												<table
													class="table table-hover table-striped table-bordered">
													<thead class="bg-success" style="color: #fff;">
														<tr>
															<th id="th2">Hospital Name</th>
															<th id="th3">Speciality</th>
															<th id="th4">Diagnosis</th>
															<th id="th5">Instruction</th>
															<th id="th7">Add</th>
															<th id="th8">Delete</th>
														</tr>
													</thead>
													<tbody id="referalGrid">
														<tr>
															<td><select name="hospitalName" id="hospitalName"   class="form-control" 
																tabindex="36">
																	<option value="">Select</option>

															</select>
															</td>
															<td><select name="specialityName" id="specialityName"   class="form-control" 
																tabindex="36">
																	<option value="">Select</option>

															</select>
															</td>
															<td>
																<div class="autocomplete">
																	<textarea class="form-control"
																		id="diagnosisId" value=""
																		onblur="fillDiagnosisCombo(this.value,this);"
																		placeholder="Diagnosis"></textarea>
																</div>
															</td>
															<td style="display: none";>
																<input type="hidden" id="diagnosisIdValue" value="" class="form-control"/>
															</td>
															<td>
																<input type="text" id="instructionName" value="N/A" class="form-control">
															</td>
															
															<td>
															<button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForFinalObservation();"></button>
                                                            </td>
															<td>
																<button type="button" name="delete" value=""
																	class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"
																	onclick="removeRowInvestigation(this)">
																</button>
															</td>
														</tr>

													</tbody>
												</table>
											</div>


										</div>







										<div class="row">
										
										    <div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Referral Remarks</label>
													<div class="col-md-7">
														<textarea id="refferalRemarks" maxlength="500" class="form-control">N/A</textarea>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<!-- <div class="form-group row">
													<label class="col-md-5 col-form-label">Final Observation</label>
													<div class="col-md-7">
														<textarea class="form-control" id="finalObservation"></textarea>
													</div>
												</div> -->
											</div>
											
											<div class="col-md-4">

												<!-- <div class="form-group row">
													<label class="col-md-5 col-form-label">MB</label>
													<div class="col-md-7 ">
														<select class="form-control">
															<option>Select</option>
														</select>
													</div>
												</div> -->

											</div>
										</div>
										
										
										<div class="row">
										<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Final Observation</label>
													<div class="col-md-7">
														<textarea class="form-control" maxlength="500" id="finalObservation">N/A</textarea>
													</div>
												</div>
											</div>
										
										    <div class="col-md-4">
												<!-- <div class="form-group row">
													<label class="col-md-5 col-form-label">Remarks</label>
													<div class="col-md-7">
														<textarea class="form-control"></textarea>
													</div>
												</div> -->
											</div>
											
											
											<div class="col-md-4">

												<!-- <div class="form-group row">
													<label class="col-md-5 col-form-label">MB</label>
													<div class="col-md-7 ">
														<select class="form-control">
															<option>Select</option>
														</select>
													</div>
												</div> -->

											</div>
										</div>
										
										
										
										

										<div class="row">
											<div class="col-md-12 m-t-10 clearfix">
												<div class="btn-right-all">
													<button type="button" class="btn btn-primary" value="" id="clicked" tabindex="1" onclick="saveRefferalOpinionDetails();">Submit</button>
													<!-- <button type="reset" accesskey="r" class=" btn btn-danger">Reset</button> -->
												</div>
											</div>

											<div class="col-md-6">
												<input type="hidden" id="patientId" name="PatientID12"
													value="">
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">


											<div class="col-md-5">
												<input type="hidden" id="visitId" name="VisitID" value="">
											</div>
											<div class="col-md-7">
												<input type="hidden" id="genderId" name="genderId" value="">
											</div>
										</div>

									</div>

								</div>
						</div>
					</div>
				</div>
			</div>
		</div>		 

</div>
</div>
</form:form>
	
										
</div>

<!-- END wrapper -->
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

								<div class="col-md-5">
									<div class="form-group row">
										<label class="col-sm-5 col-form-label">Result Date</label>
										<div class="col-sm-7">
											<div class="dateHolder">
												<input class="noFuture_date_ResultDate  form-control" type="text"
													placeholder="" id="investigationResultDateTemp" name="investigationResultDateTemp" value="" placeholder="DD/MM/YYYY" >
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
<%-- 	<div class="modal" id="messageForResult" role="dialog">
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
												<!-- <input class="noFuture_date form-control" type="text"
													placeholder="" id="dateResult" name="dateResult" value=""> -->
													<input type="text" class="noFuture_date2 form-control" id="dateResult" name="dateResult" readonly
								                     placeholder="DD/MM/YYYY"  maxlength="10" />
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
										<div class="col-md-5"><h6 class="text-theme text-underline font-weight-bold">Result </h6></div>
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
	</div> --%>

<script type="text/javascript">
            $(document).ready(function() {
                /* if (typeof element !== "undefined" && element.value == '') {
                } */
                var data = ${
                    data
                };
                if (data.data[0].serviceNo != null) {
                    document.getElementById('service_no').value = data.data[0].serviceNo;
                }
                if (data.data[0].visitId != null) {
                    document.getElementById('visitId').value = data.data[0].visitId;
                }
                if (data.data[0].patientId != null) {
                    document.getElementById('patientId').value = data.data[0].patientId;
                }
                if (data.data[0].mbType != null) {
                    document.getElementById('mb_type').value = data.data[0].mbType;
                }
                if (data.data[0].patientName != null) {
                    document.getElementById('name').value = data.data[0].patientName;
                }
                if (data.data[0].genderId != null) {
                    document.getElementById('genderId').value = data.data[0].genderId;
                }
                if (data.data[0].age != null) {
                    document.getElementById('age').value = data.data[0].age;
                    document.getElementById('ageNumber').value = data.data[0].ageValue;
                }
                if (data.data[0].gender != null) {
                    document.getElementById('gender').value = data.data[0].gender;
                }
                if (data.data[0].rank != null) {
                    document.getElementById('rank').value = data.data[0].rank;
                }
                if (data.data[0].height != null) {
                    document.getElementById('height').value = data.data[0].height;
                }
                if (data.data[0].idealWeight != null) {
                    document.getElementById('ideal_weight').value = data.data[0].idealWeight;
                }
                if (data.data[0].weight != null) {
                    document.getElementById('weight').value = data.data[0].weight;
                }
                if (data.data[0].varation != null) {
                    document.getElementById('variant_in_weight').value = data.data[0].varation;
                }
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
                if (data.data[0].bmi != null) {
                    document.getElementById('bmi').value = data.data[0].bmi;
                }
                if (data.data[0].rr != null) {
                    document.getElementById('rr').value = data.data[0].rr;
                }
                if (data.data[0].medicalCategogyName != null && data.data[0].fitFlag != "F") {
                    document.getElementById('medicalCompositeName').value = data.data[0].medicalCategogyName;
                }
                if (data.data[0].medicalCategogyDate != null && data.data[0].fitFlag != "F") {
                    document.getElementById('medicalCompositeDate').value = data.data[0].medicalCategogyDate;
                }
                /* if(data.data[0].overweightFlag!=null && data.data[0].overweightFlag!=""){
                	var overweightFlag= data.data[0].overweightFlag;
					if(overweightFlag!="" && overweightFlag=='Y'){
						$("#overCheck").prop("checked", true);
						$("#overWeightDropDown").show();
						$('#obsistyMark').val("Y");
						overWeight("Y");
					}
					if(overweightFlag!="" && overweightFlag=='N'){
						$("#obsistyCheck").prop("checked", true);
						$("#overWeightDropDown").hide();
						$('#obsistyMark').val("N");
						overWeight("N");
					}
					if(overweightFlag!="" && overweightFlag=='A'){
						$("#noneCheck").prop("checked", true);
						$("#overWeightDropDown").hide();
						$('#obsistyMark').val("A");
						overWeight("A");
					}
				 } */
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
                
				    getMBPreAssesDetailsData();
	                getAFMSF15InvestigationForMOOrMA();
	                getEmpanelledHospital();
	                getSpecialistList();
	                changeRadioForUploa(labRadioValue);
	                masIcdList();
                
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
	 
	$(function() {
		$("#editorOfResult").jqte();
		
		$('.hisDivHide').each(function(){
			$(this).css({'display':'block'});
		});
	});

	
	var investigationGridValue = "investigationGrid";
	var investigationData = '';
	function getMBPreAssesDetailsData() {
		investigationGridValue = "investigationGrid";
		var visitId = $('#visitId').val();
		var patientId=$('#patientId').val();
		var data = {
			"visitId" : visitId,
			"patientId":patientId
		};
		$
				.ajax({
					type : "POST",
					contentType : "application/json",
					url : 'getMBPreAssesDetails',
					data : JSON.stringify(data),
					dataType : "json",
					// cache: false,

					success : function(response) {
					$("#medicalCategory tr").remove();	
					var datas = response.data;	
					var trHTML = '';
					var i=0;
					console.log(datas);
					$.each(datas, function(i, item) {
						   
						    var investigationName=item.inveName;
							var icdName=item.icdName;
							var system=item.system;
							var medicalCategory=item.medicalCategory;
							var categoryType='';
							var mbStatus=item.mbStatus;
							var	categoryTypeVal=item.categoryType;
							if(categoryTypeVal=='P')
							{
							  categoryType='Permanent(Month)';	
							}
							if(categoryTypeVal=='T')
							{
							   categoryType='Temporary(Week)';
							}	
							var categoryDate=item.categoryDate;
							var duration=item.duration;
							var nextCategoryDate=item.nextCategoryDate;
							var selectCheck=item.applyFor;
							var checkValue = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1" disabled="true"><span class="cus-checkbtn"></span></div>';
							var tr='<tr><td><div class="form-check form-check-inline cusCheck">';
							if(selectCheck=='Y')
							{
								 checkValue = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1" checked disabled="true"><span class="cus-checkbtn"></span></div> ';
								 tr='<tr style="background-color: #84e08f"><td><div class="form-check form-check-inline cusCheck">';
							}	
							
							if(icdName!=null && icdName!=undefined && (mbStatus=='P' || mbStatus=='C'))
							{
							trHTML+=tr+checkValue+'</div></td><td><textarea class="form-control" value="'+icdName+'" id="diagnosisId'+i+'" onblur="fillDiagnosisCombo(this.value,this);" placeholder="Diagnosis" readonly>'+icdName+'</textarea></td><td><input type="text" value="'+medicalCategory+'" id="medicalCategory'+i+'" class="form-control" readonly></td><td><input type="text" value="'+system+'" id="system'+i+'" class="form-control" readonly /> </td><td><input type="text" value="'+categoryType+'" id="categoryType'+i+'" class="form-control" readonly> </td><td><input type="text" value="'+duration+'" id="duration'+i+'" class="form-control" readonly> </td><td><div class="dateHolder"><input type="text" value="'+categoryDate+'" id="diagnosisDate'+i+'" name="diagnosisDatesssss" class="input_date form-control" placeholder="DD/MM/YYYY" maxlength="10" readonly /></div></td><td><div class="dateHolder"><input type="text" value="'+nextCategoryDate+'" id="nextDiagnosisDate'+i+'" name="nextDiagnosisDatess" class="input_date form-control" placeholder="DD/MM/YYYY" maxlength="10" readonly /></div></td><td style="display: none";><input type="hidden" value="" tabindex="1" id="diagnosisIdval" size="77" name="diagnosisIdval" readonly /></td></tr>';	
							//trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationValue+''+'['+investigationId+']'+'" id="chargeCodeName1'+i+'" class="form-control border-input" name="chargeCodeName1" onblur="populateChargeCode(this.value,1,this);" /> </div></td><td><div class="dateHolder"> <input type="text" id="investigationDate1Temp'+i+'" name="investigationDatess" class="input_date form-control" placeholder="DD/MM/YYYY" value='+today+' maxlength="10" /></div></td><td><input type="checkbox" name="urgent" id="otherAfLabCheck" tabindex="1" class="radioAuto" value="I" checked/></td><td><input type="checkbox" name="urgent" id="uCheck" tabindex="1" class="radioAuto" value="1" /><td style="display:none";><input type="hidden" value="'+investigationId+'" tabindex="1" id="inestigationIdval2'+i+'" size="77" name="inestigationIdval" /></td> </td><td><button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForInvestigation();"></button></td><td><button type="button" name="delete" value="" class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" onclick="removeRowInvestigation(this)"></button></td></tr>';
							i++;
							}
							
											
			});
					$('#medicalCategory').append(trHTML);
				}
	    });
		}
	
	
	/* function getMBPreAssesDetailsInvestigationData() {
		var visitId = $('#visitId').val();
		var patientId=$('#patientId').val();
		var data = {
			"visitId" : visitId,
			"patientId":patientId
		};
		$
				.ajax({
					type : "POST",
					contentType : "application/json",
					url : 'getMBPreAssesDetails',
					data : JSON.stringify(data),
					dataType : "json",
					// cache: false,

					success : function(response) {
					$("#dgInvetigationGrid tr").remove();	
					var datas = response.data;	
					var trHTML = '';
					var i=0;
					console.log(datas);
					$.each(datas, function(i, item) {
						   
						    var dgOderHdId=item.orderHdId;
						    var dgOderDtId=item.orderDtId;
						    var investigationName=item.inveName;
							var inveId=item.inveId;
							
							if(investigationName!=null && investigationName!=undefined)
							{
							trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationName+'" id="chargeCodeName" autocomplete="_off" class="form-control border-input" name="chargeCodeName"  size="44" onblur="populateChargeCode(this.value,1,this);" /> <input type="hidden" id="qty" tabindex="1" name="qty1" size="10" maxlength="6" validate="Qty,num,no" /><input type="hidden" value="'+inveId+'" tabindex="1" id="chargeCodeCode" name="chargeCodeCode" size="10" readonly /></div></td><td><div class="form-group row"><div class="col-md-7"><input type="text" class="form-control custom_date" name="fromDate" id=""></div><div class="col-md-5"><input name="btnAdd" id="btnAdd" type="button" class="btn  btn-primary" value="Browse" onclick="uploadDocument();"></div></div></td><td style="display: none";><input type="hidden" value="'+dgOderHdId+'" tabindex="1" id="dgOderHdId" name="dgOderHdId" size="10" readonly /></div></td><td style="display: none";><input type="hidden" value="'+dgOderDtId+'" tabindex="1" id="dgOderDtId" name="dgOderDtId" size="10" readonly /></div></td></tr>';	
							//trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationValue+''+'['+investigationId+']'+'" id="chargeCodeName1'+i+'" class="form-control border-input" name="chargeCodeName1" onblur="populateChargeCode(this.value,1,this);" /> </div></td><td><div class="dateHolder"> <input type="text" id="investigationDate1Temp'+i+'" name="investigationDatess" class="input_date form-control" placeholder="DD/MM/YYYY" value='+today+' maxlength="10" /></div></td><td><input type="checkbox" name="urgent" id="otherAfLabCheck" tabindex="1" class="radioAuto" value="I" checked/></td><td><input type="checkbox" name="urgent" id="uCheck" tabindex="1" class="radioAuto" value="1" /><td style="display:none";><input type="hidden" value="'+investigationId+'" tabindex="1" id="inestigationIdval2'+i+'" size="77" name="inestigationIdval" /></td> </td><td><button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForInvestigation();"></button></td><td><button type="button" name="delete" value="" class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" onclick="removeRowInvestigation(this)"></button></td></tr>';
							i++;
							}
										
			         });
					$('#dgInvetigationGrid').append(trHTML);
				}
	    });
		} */
	
	
	
		function addRowForInvestigationFunUpMb(){
			 var radioInvAndImaValue=$('#radioInvAndImaValue').val();
			 var tbl = document.getElementById('dgInvetigationGrid');
		   	lastRow = tbl.rows.length;
		   	i =lastRow;
		   	i++;
			    var aClone = $('#dgInvetigationGrid>tr:last').clone(true)
			     aClone.removeAttr('data-id');
			    aClone.find('img.ui-datepicker-trigger').remove();
				aClone.find(":input").val("");
				
				aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'checkBoxForUpload'+i+'');
				aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'chargeCodeName'+i+'');
				aClone.find("td:eq(1)").find("input:eq(3)").prop('id', 'investigationIdValue'+i+'');
				aClone.find("td:eq(1)").find("div").find("div").prop('id', 'investigationDivMe' + i + '');
				
				aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'UOM'+i+'');
				
				var resultHtml="";
				 if(radioInvAndImaValue=='Lab'){
					 	//aClone.find("td:eq(3)").find("input:eq(0)").prop('id', 'resultInvs'+i+'');
				
					 	resultHtml='<input type="text" name="resultInvs" id="resultInvs'+i+'" value="" class="form-control">';
						aClone.find("td:eq(3)").html(resultHtml);
				 }
				 if(radioInvAndImaValue=='Radio'){
						aClone.find("td:eq(3)").find("textarea:eq(0)").prop('id', 'resultInvs'+i+'');

						resultHtml = '<textarea name="resultInvs" id="resultInvs'+i+'"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">   </textarea>';
						resultHtml += '	<a class="btn-link" href="javascript:void(0)"  data-toggle="modal" data-target="#messageForResult" data-backdrop="static" onclick="openResultModel(this);">View/Enter Result</a>';
						aClone.find("td:eq(3)").html(resultHtml);
				 }
					aClone.find("td:eq(4)").find("input:eq(0)").prop('id', 'range'+i+'');
					aClone.find("td:eq(5)").find("input:eq(0)").prop('id', 'investigationRemarks'+i+'');
					var viewDoc='<td style="display:none"> </td>';
					aClone.find("td:eq(6)").html(viewDoc);
					
					var investigationData="";
					 func1='populateChargeCode';
		 		   url1='medicalexam';
		 		   url2='getInvestigationListUOM';
		 		   flaga='investigationMeDg';
					 investigationData += '<td> ';
					investigationData += '<div class="form-check form-check-inline cusCheck m-l-10">';
					investigationData += ' 	<input   class="form-check-input position-static" type="checkbox"  name="checkBoxForUpload" id="checkBoxForUpload'+i+'" onClick="return getInvestionCheckData(this);"><span class="cus-checkbtn"></span> ';
					investigationData += '</div> ';
					investigationData += ' </td> ';
					investigationData += '<td><div   class="autocomplete forTableResp">';
					investigationData += '<input type="text"  readonly value="" id="chargeCodeName' + i + '"';
					//investigationData += ' class="form-control border-input" name="chargeCodeName" autocomplete="off" onKeyPress="autoCompleteCommonUp(this,1);" onblur="populateChargeCode(this.value,'+ countins +',this);"/>';
					investigationData += ' class="form-control border-input" name="chargeCodeName"    onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
					investigationData += '<input type="hidden" id="qty" tabindex="1" name="qty1"  maxlength="6"/>';
					investigationData += '<input type="hidden" tabindex="1" id="chargeCodeCode'+i+'"';
					investigationData += 'name="chargeCodeCode"   readonly />';
					investigationData += '<input type="hidden"  name="investigationIdValue" value=""  id="investigationIdValue'+i+'"/>';

					investigationData += '<input type="hidden"  name="dgOrderDtIdValue" value="" id="dgOrderDtIdValue'+i+'"/>';
					investigationData += '<input type="hidden"  name="dgOrderHdId" value="" id="dgOrderHdId'+i+'"/>';
					 
					investigationData += '<input type="hidden"  name="dgResultHdId" value="" id="dgResultHdId'+i+'"/>';
					
					investigationData += '<input type="hidden"  name="dgResultDtId" value="" id="dgResultDtId'+i+'"/>';
					investigationData += '	 <input type="hidden" name="investigationType" value=""';
					investigationData += 'id="investigationType'+i+'" />';
					
					investigationData += '<input type="hidden" name="subChargecodeIdForInv" value=""';
					investigationData += '	id="subChargecodeIdForInv'+i+'" />';
					investigationData += '<input type="hidden" name="mainChargecodeIdValForInv" value=""';
					investigationData += '	id="mainChargecodeIdValForInv'+i+'" />';
					investigationData += '<div id="investigationDivMeDg'+i+'" class="autocomplete-itemsNew"></div>';	
					investigationData += ' </div></td>';
					investigationData += '	<td>';
					investigationData += '	<input type="text" name="UOM" id="UOM'+i+'" value="" class="form-control"   readonly>';
					investigationData += '	</td>';
					
					if(radioInvAndImaValue=='Lab'){	
						investigationData += '	<td>';
						 investigationData+='<input type="text" name="resultInvsTemp" id="resultInvsTemp'+i+'" value="" class="form-control"  onBlur="setLabResultInFieldDigi(this);" >';
						investigationData += '	<input type="hidden" name="resultInvs" id="resultInvs'+radioInvAndImaValue+i+'" value="@@@###" class="form-control">';
						investigationData += '	</td>';
						}
						else{
							investigationData += '	<td>';
								investigationData += '<textarea name="resultInvs" id="resultInvs'+radioInvAndImaValue+i+'"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###</textarea>';
								investigationData += '	<a class="btn-link" href="javascript:void(0)"  data-toggle="modal" data-target="#messageForResult" data-backdrop="static" onclick="openResultModel(this);">View/Enter Result</a>';
								investigationData += '	</td>';
						}
					
					investigationData += '<td>';
					investigationData += '<input type="text" name="range" id="range'+i+'" value="" class="form-control">';
					investigationData += '	<input type="hidden" name="investigationResultDate" id="investigationResultDate'+i+'" value="" class="form-control">';
					investigationData += '	<input type="hidden" name="resultNumber" id="resultNumber'+i+'" value="" class="form-control">';
					investigationData += '</td>';
					investigationData += '<td>';
						investigationData += '<textarea class="form-control"  name="investigationRemarks" id="investigationRemarks'+i+'" rows="2" maxlength="500"></textarea>';
						investigationData += ' </td>';
					//investigationData += '	<td style="display:none"><input type="file" name="fileInvUpload'+i+'" id="fileInvUpload'+i+'"></td>';
					investigationData += '<td> </td>'
					 
					investigationData += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth"   button-type="add" value="" ';
					investigationData += 'onclick="addRowForInvestigationFunUpMb();" ';
					investigationData += '	tabindex="1" > </button></td>';

					investigationData += '<td><button type="button" name="delete" value=""   button-type="delete" id="newInvestigationId"';
					investigationData += 'class="buttonDel btn btn-danger noMinWidth"';
					investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,0);" ></button></td>';										 
				 
					aClone.html(investigationData);	
					
					aClone.find("td:eq(3)").find("div").find("div").find("div").find("div").prop('id', 'investigationResultDateTemp' + i + '');
		 			aClone.find("td:eq(3)").find("div").find("div").find("div").find("div").prop('id', 'resultNumberTemp' + i + '');
		 			
					
		 			aClone.find("td:eq(1)").find("input:eq(0)").removeAttr("readonly");
					aClone.find('input[type="checkbox"]').prop("checked", false);
					aClone.find('input[type="checkbox"]').removeAttr("disabled");
					aClone.find("td:eq(9)").find("button:eq(0)").removeAttr("disabled",false);
					aClone.find("td:eq(9)").find("button:eq(0)").removeAttr("id").attr("id", "newInvestigationId");
					aClone.clone(true).appendTo('#dgInvetigationGrid');
			
		 
			
		 } 
		 var arryInvestigation = new Array();
		function autoCompleteCommonMe(val,flag){
			if(flag=='1')
			oldautocomplete(val, arryInvestigation);
			if(flag=='5'){
				oldautocomplete(val, arry);
			}
			if(flag=='6'){
				oldautocomplete(val, MeidcalCategoryArry);
			}
			
			if(flag=='7'){
				oldautocomplete(val, arryNomenclature);
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
			 										if (chargeCodeId != checkCurrentRowIddd
			 												&& ChargeCode == chargeCodeIdValue) {
			 											if (ChargeCode == chargeCodeIdValue) {
			 												alert("Investigation is already added");
			 												checkForDuplicate++;
			 												$('#' + idddd).val("");
			 												$('#' + currentidddd).val("");
			 												$('#'+ chargeCodeIdValue).val("");
			 												return false;
			 											}
			 										} else {
			 											$(item).closest('tr').find("td:eq(1)").find("input:eq(3)").val(ChargeCode);
			 											$(item).closest('tr').find("td:eq(2)").find("input:eq(0)").val(uomName);
			 											$(item).closest('tr').find("td:eq(4)").find("input:eq(0)").val(minMaxValue);

			 											
			 											$(item).closest('tr').find("td:eq(1)").find("input:eq(8)").val(investigationType);
														$(item).closest('tr').find("td:eq(1)").find("input:eq(9)").val(subChargeCodeIds);
														$(item).closest('tr').find("td:eq(1)").find("input:eq(10)").val(mainChargeCodeIds);
			
			 										}
			 									});
			 					
	 							
	 							if(investigationType!="" &&  checkForDuplicate==0 &&( investigationType=='s' ||investigationType=='t') ){
		 							var idResult= $(item).closest('tr').find("td:eq(3)").find("input:eq(1)").attr("id");
		 							 $('#'+idResult).val("@@@###");
		 							}
		 							if(investigationType!="" &&  checkForDuplicate==0 && investigationType=='m' && ChargeCode!="")
		 								getSubInvestigationHtmlForMb(ChargeCode,item);
	
		
			 					
			 				}
			 			}
			 		}

			 	}
			 }
		
	function idealWeight() {
		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";

		var url = window.location.protocol + "//" + window.location.host + "/"
				+ accessGroup + "/opd/getIdealWeight";
		var dataJSON = {
			'height' : $('#height').val(),
			'age' : $('#ageNumber').val(),
			'genderId' : $('#genderId').val(),
		}
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : url,
			data : JSON.stringify(dataJSON),
			dataType : 'json',
			timeout : 100000,
			success : function(data) {
				console.log("SUCCESS: ", data);

				if (data.status == 1) {
					//var data = data;
					//alert("value is "+data.data[0].idealWeight);
					$('#ideal_weight').val(data.data[0].idealWeight);
					$('#ideal_weight').attr("disabled", "disabled");
				} else {
					alert("Ideal Weight Not Configured")
					$('#ideal_weight').val();
					$('#ideal_weight').removeAttr("disabled");
				}
			},
			error : function(e) {
				console.log("ERROR: ", e);
			},
			done : function(e) {
				console.log("DONE");
				alert("success");
				var datas = e.data;
			}
		});
	}
	
	 function checkVaration()  {

     	var a = document.getElementById("ideal_weight").value;
 		var b = document.getElementById("weight").value;
       if(a!=null && b!=null && a!="" && b!="")
        {	  
 		if (parseFloat(a) > parseFloat(b)) {
 			var sub = a - b;
 			var cal = sub * 100 / a
 			var n = cal.toFixed(2);
 			$('#variant_in_weight').val("-" + n);

 		} else {
 			var eadd = b - a;
 			var cal1 = eadd * 100 / a
 			var n1 = cal1.toFixed(2);
 			$('#variant_in_weight').val("+" +n1);
 		}
 		var obsistyCheckAlready=$('#obsistyCheckAlready').val();
 		if(obsistyCheckAlready!="exits")
 		{	
 		var varationWightVal = document.getElementById("variant_in_weight").value;
 		 var varationWightActual='10';
 		 if(document.getElementById("overCheck").checked == true){
 		 if(document.getElementById('variant_in_weight').value != "" && parseFloat(varationWightActual) > parseFloat(varationWightVal))
 			{	
 				alert("Overweight Cannot be selected as variation in weight is less than 10  ")
 				document.getElementById("overCheck").checked=false;
 				obsistyOverWeight = "";
 				$('#overWeightDropDown').hide();
 				return false;
 			}
 		 }
 		 if(document.getElementById("obsistyCheck").checked == true){
     		 if(document.getElementById('variant_in_weight').value != "" && parseFloat(varationWightActual) > parseFloat(varationWightVal))
     			{	
     				alert("Obesity Cannot be selected as variation in weight is less than 10  ")
     				document.getElementById("obsistyCheck").checked=false;
     				obsistyOverWeight = "";
     				return false;
     			}
     		 }
        }
      }	
	}
	
	function checkBMI() {
		var a = document.getElementById("weight").value;
		var b = document.getElementById("height").value;
		var c=b/100;
		var d=c*c;
		var sub = a/d;
		$('#bmi').val(parseFloat(Math.round(sub * 100) / 100).toFixed(2));
		
	}
	
	var obsistyOverWeight='';
	function overWeight(radioValue)
	{
		 var varationWightVal = document.getElementById("variant_in_weight").value;
		 var varationWightActual='10';
		 //var text = document.getElementById("text");
		
		 if(document.getElementById("obsistyCheck").checked == true){
			 document.getElementById("obsistyCheckText").style.font = "italic bold 20px arial,serif";
			 document.getElementById("overCheckText").style.fontSize ="inherit";
			 document.getElementById("noneText").style.fontSize ="inherit";
			 obsistyOverWeight = radioValue; 
			 $('#overWeightDropDown').hide();
		  }
		 if(document.getElementById("noneCheck").checked == true){
			 document.getElementById("noneText").style.font = "italic bold 20px arial,serif"; 
			 document.getElementById("overCheckText").style.fontSize ="inherit";
			 document.getElementById("obsistyCheckText").style.fontSize ="inherit";
			 obsistyOverWeight = radioValue; 
			 $('#overWeightDropDown').hide();
		  }
		 if(document.getElementById("overCheck").checked == true){
			 document.getElementById("overCheckText").style.font = "italic bold 20px arial,serif"; 
			 document.getElementById("noneText").style.font = "inherit"; 
			 document.getElementById("obsistyCheckText").style.fontSize ="inherit";
			if(document.getElementById('variant_in_weight').value == "")
		 	{	
				$('#overWeightDropDown').hide();
		 	alert("Overweight Cannot be selected as variation in weight is less than 10")
		 	document.getElementById("overCheck").checked=false;
		 	document.getElementById("overCheckText").style.fontSize ="inherit";
		 	return false;
		 	}
				
			else if(document.getElementById('variant_in_weight').value != "" && parseFloat(varationWightActual) > parseFloat(varationWightVal))
			{	
				$('#overWeightDropDown').hide();
				alert("Overweight Cannot be selected as variation in weight is less than 10")
				document.getElementById("overCheck").checked=false;
				document.getElementById("overCheckText").style.fontSize ="inherit";
				return false;
			}
			
			else
			{	
			 obsistyOverWeight = radioValue; 
			 $('#overWeightDropDown').show();
			 var a = document.getElementById("variant_in_weight").value;
			 var b='20';
			 if(parseFloat(b) > parseFloat(a))
			 {
				
				 document.getElementById("under20").selected=true;	 
			 }
			 else
			 {
				 document.getElementById("above20").selected=true;	 
			 } 
			}
		  }
		
		 if(document.getElementById("obsistyCheck").checked == true){
				if(document.getElementById('variant_in_weight').value == "")
		 		{	
					$('#overWeightDropDown').hide();
		 		alert("Obesity Cannot be selected as variation in weight is less than 10  ")
		 		document.getElementById("obsistyCheck").checked=false;
		 		document.getElementById("obsistyCheckText").style.fontSize ="inherit";
		 		return false;
		 		}
				
				else if(document.getElementById('variant_in_weight').value != "" && parseFloat(varationWightActual) > parseFloat(varationWightVal))
				{	
					$('#overWeightDropDown').hide();
					alert("Obesity Cannot be selected as variation in weight is less than 10  ")
			 		document.getElementById("obsistyCheck").checked=false;
					document.getElementById("obsistyCheckText").style.fontSize ="inherit";
			 		return false;
				}
			  }
			
	}
	
	var countResult=0;
	function saveRefferalOpinionDetails() {
		
		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";

		var url = window.location.protocol + "//"
				+ window.location.host + "/" + accessGroup
				+ "/medicalBoard/saveRefferedOpinionMBdetails";
		
		/////////////////// referral Validation ///////////////////////////////   
        $('#referalGrid tr').each(function(i, el) {
      	    var $tds = $(this).find('td')
      	    var extHospitalId = $tds.eq(0).find(":input").val();
      	    var extDepartId = $tds.eq(1).find(":input").val();
      	    var diagnosisId = $tds.eq(3).find(":input").val();
      	
      	 if(extHospitalId== "")
    	    {
        		alert("Please select at least one hospital for referral");
        		extHospitalId.focus();
        		return false;    	
    		}
      	 if(extHospitalId!= "")
      	 {
      		if(diagnosisId== "")
      		{
      			alert("Please Enter Diagnosis Name under Referral");
      			extHospitalId.focus();
        		return false; 
      		}
      		if(extDepartId== "")
      		{
      			alert("Please select speciality under referral");
      			extHospitalId.focus();
        		return false; 
      		}
      		 
      	 }	 
      	 
        });
		
        /////////////////// onsisty mark validation ////////////////////////////  
        var obsistyMark='';
    	
		if(obsistyOverWeight!='none')
		{	
		if (obsistyOverWeight!=null && obsistyOverWeight!="")
		{
		    obsistyMark=obsistyOverWeight;
		    
		}
    	if(obsistyOverWeight!=null && obsistyOverWeight!="")
    	{
    		if(document.getElementById('height').value == "")
    		{	
    		alert("please enter height")
    		return false;
    		}
    		if(document.getElementById('weight').value == "")
    		{	
    		alert("please enter weight")
    		document.getElementById('weight').focus();
    		return false;
    		}
    	 }
		}
		
        //////////////Investigation Result JSON ///////////////////
    	var tableDataInvResult = [];  
    	var dataInvDeatils='';
    	var idforTreat='';
   	 	$('#dgInvetigationGrid tr').each(function(i, el) {
		idforTreat= $(this).find("td:eq(1)").find("input:eq(0)").attr("id") 
		if(document.getElementById(idforTreat).value!= '' && document.getElementById(idforTreat).value != undefined)
   		{
   			var $tds = $(this).find('td')
  			var investigationId = $(this).find("td:eq(0)").find("input:eq(2)").val();
   			var result = $(this).find("td:eq(1)").find("input:eq(0)").val();
   			var orderDtId = $(this).find("td:eq(3)").find("input:eq(0)").val();
   			var dgResultId = $(this).find("td:eq(4)").find("input:eq(0)").val();
   		
			dataInvDeatils={
			'investigationId' : investigationId,
			'dgResultId':dgResultId,
			'orderDtId' : orderDtId,
			'result' : result,
			} 
			tableDataInvResult.push(dataInvDeatils);
    	   }
	   });
		
	///////////////// Referral Json ////////////////////	
    	var listofReferallHD =[];
    	var listofReferalDT =[];
    	var dataReferalHD='';
    	$('#referalGrid tr').each(function(i, el) {
    	    var $tds = $(this).find('td')
    	    var extHospitalId = $tds.eq(0).find(":input").val();
    	  	var splitHospital=extHospitalId.split("@");
    		var speciality = $tds.eq(1).find(" option:selected" ).text();
    		var diagonsisId = $tds.eq(3).find(":input").val();
    		var instruction = $tds.eq(4).find(":input").val();
    		var refferalRemarks= document.getElementById('refferalRemarks').value;
    		            	
    		
    		dataReferalHD={
    				'extHospitalId' : splitHospital[0],
    				'patientId' : $('#patientId').val(),
    				'hospitalId' : <%=hospitalId%>,
    				'referralNote' : refferalRemarks,
    				'listofReferalDT':[{ 'diagnosisId' : diagonsisId,
    				      				'extDepartment' : speciality,
    				      				'instruction' : instruction,}]
    		}
    		listofReferallHD.push(dataReferalHD);
    	});
    
    	
    	var dataJSON={
  	   			'visitId':$('#visitId').val(),
      			'patientId':$('#patientId').val(), 
      			'idealWeight' : $('#ideal_weight').val(),
    			'height' : $('#height').val(),
    			'weight' : $('#weight').val(),
    			'varation' : $('#variant_in_weight').val(),
    			'temperature' : $('#tempature').val(),
    			'bp' : $('#bp').val(),
    			'bp1' : $('#bp1').val(),
    			'pulse' : $('#pulse').val(),
    			'spo2' : $('#spo2').val(),
    			'bmi' : $('#bmi').val(),
    			'rr' : $('#rr').val(),
      			'departmentId':'1',
      			'hospitalId' : <%=hospitalId%>,
      			'userId':<%= userId %>,
      			'chiefComplain': $('#chiefComplaint').val(), 
      			'pallar': $('#pollar').val(),
                'edema': $('#ordema').val(),
                'cyanosis': $('#cyanosis').val(),
                'icterus': $('#icterus').val(),
                'hairnail' :$('#hairnail').val(),
                'lymphNode': $('#lymphNode').val(),
                'clubbing': $('#clubbing').val(),
                'gcs': $('#gcs').val(),
                'tremors': $('#Tremors').val(),
                'generalOther': $('#others').val(),
                'cns': $('#cns').val(),
                'chestresp': $('#chest').val(),
                'musculoskeletal': $('#musculoskeletal').val(),
                'cvs': $('#cvs').val(),
                'skin': $('#skin').val(),
                'gi': $('#gi').val(),
                'systemother': $('#others1').val(),
      			'specialistOpninion':'',
      			'finalobservation':$('#finalObservation').val(),
               	"listofReferallHD" : listofReferallHD,
      			"listofResultDetails" : tableDataInvResult,
      			'obsistyMark':obsistyMark,
      			'obsistyCheckAlready':$('#obsistyCheckAlready').val(),
      			'geneticurinary':$('#geneticurinary').val(),
				}
    	
    	var formData1 = $('#mbReferforOpinionDeatils')[0];
	   	 var formData = new FormData(formData1);
	   	 var countFile=1;
	   	 $('#fileUploadforInvesDynamic tr').each(function(ij, el) {
				var fileUploadid = $(this).find("td:eq(2)").find("input:eq(0)").attr("id");
				var investigationValue = $(this).find("td:eq(1)").find("input:eq(3)").val();
				//if($("#"+fileUploadid).prop("files")!=null || $("#"+fileUploadid).prop("files")!="")
				//formData.append('file'+ countFile, $("#"+fileUploadid).prop("files")[0]);
				//fileSize = document.getElementById("#"+fileUploadid).files[0].size;
				//var filenameValue = document.getElementById(""+fileUploadid).value;
			 //var fileUploadid = $(this).find("td:eq(2)").find("input:eq(0)").attr("id");
			 var filenameValue = $('#'+fileUploadid).val();
			 if(filenameValue!="" && filenameValue!=undefined)
			 if(validateFileExtension(filenameValue, "valid_msg", "Only pdf/image/mp4 files are allowed ",
				      new Array("jpg","pdf","jpeg","gif","png","mp4","MP4")) == false)
				      {
				 		return false;
				      }
			 
				var result = $(this).find("td:eq(3)").find("input:eq(0)").val();
				if(result=="" || result==null){
					countResult+=1;
				}
			});
	   	    var yyyy=new Date().getFullYear();
	   	  	formData.append('uploadFilePath', "uploads");
			formData.append('uploadRealPath', 1);
			formData.append('jsondata',JSON.stringify(dataJSON));
			formData.append('year',yyyy);
			formData.append('type',1);
			formData.append('serviceNo',$('#service_no').val());
    	
    $("#clicked").attr("disabled", true);
	$.ajax({
		type : "POST",
		url : url,
		 enctype: 'multipart/form-data',
         data: formData,
         processData: false,
         contentType: false,
         cache: false,
         dataType : "json",
         timeout : 100000,
		success : function(msg) {
			if (msg.status == 1) {
				var Id= $('#visitId').val()
				window.location.href ="mbRefferedOpinionSubmit?visitId="+Id+"";
			}

			else {
				 $("#clicked").attr("disabled", false);
				alert(msg.status)
			}
		},
		error : function(jqXHR, exception) {
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
			alert(msg);
		}
	});

}
	
	var empanelledHospital = '';
	function getEmpanelledHospital() {

		var j = 1;

		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//" + window.location.host + "/"
				+ accessGroup + "/opd/getEmpanelledHospital";
		$
				.ajax({
					url : url,
					dataType : "json",
					data : JSON.stringify({
						'employeeId' : '1',
						'hospitalId' :<%=hospitalId%>
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
					var datas = response.masEmpanelledHospital;
					var trHTML = '<option value=""><strong>Select Hospital...</strong></option>';
					$.each(datas, function(i, item) {
						trHTML += '<option value="' + item.empanelledHospitalId + '@'
								+ item.empanelledHospitalCode + '" >' + item.empanelledHospitalName
								+ '</option>';
						
					});
					console.log("trHTML "+trHTML);
					$('#hospitalName').html(trHTML);
					empanelledHospital=trHTML;
									  
				},
				error : function(e) {

					console.log("ERROR: ", e);

				},
				done : function(e) {
					console.log("DONE");
					alert("success");
					var datas = e.data;

				}
			});
	

}
	
	var specialistHtml='';
	var masSpecialistList='';
	var specialistDeptList='';
	function getSpecialistList() {
		
		var j=1;
	    
		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/opd/getSpecialistList";
		$
				.ajax({
					url : url,
					dataType : "json",
					data : JSON.stringify({
						'employeeId' : '1'
					}),
					contentType : "application/json",
					type : "POST",
					success : function(response) {
						console.log(response);
						masSpecialistList = response.MasSpecialistList;
						var specialistHtml = '<option value=""><strong>Select Speciality...</strong></option>';
						$.each(masSpecialistList, function(i, item) {
							specialistHtml += '<option value="' + item.specialityId + '@'
									+ item.specialityCode + '" >' + item.specialityName
									+ '</option>';
							//$('.referSpecialistList').html(specialistHtml);
						});
						console.log("specialistHtml "+specialistHtml);
						$('#specialityName').html(specialistHtml);
						specialistDeptList=specialistHtml;
						
					  
					},
					error : function(e) {

						console.log("ERROR: ", e);

					},
					done : function(e) {
						console.log("DONE");
						alert("success");
						var datas = e.data;

					}
				});
		

	}
	
	function addRowForFinalObservation(){
		 var tbl = document.getElementById('referalGrid');
		 var 	lastRow = tbl.rows.length;
	 	 i =lastRow;
	   	 i++;	
	  	 // var newIndex = $('.autocomplete').length;
		var val = parseInt($('#referalGrid>tr:last').find("td:eq(0)").text());
		var aClone = $('#referalGrid>tr:last').clone(true)
		aClone.find("td:eq(2)").find("textarea:eq(0)").prop('id','diagonsisId' + i + '');
		aClone.find("td:eq(3)").find("input:eq(0)").prop('id','diagnosisIdValue' + i + '');
		//aClone.find('input[type="textarea"]').prop('id', 'diagnosisId'+i+'');
		//aClone.find("td:eq(0)").text(++val);
		aClone.find(":input").val("");
		aClone.find("option[selected]").removeAttr("selected")
		aClone.clone(true).appendTo('#referalGrid'); 
		var val = $('#referalGrid>tr:last').find("td:eq(2)").find(":input")[0];
		oldautocomplete(val, arry);
	  		
	  		
	  }
	
	var autoIcdCode = '';
	var icdData= '';	 
	 var idIcdNo = '';
	 var icdValue = '';
	function fillDiagnosisCombo(val,item) {
		  
	    var index1 = val.lastIndexOf("[");
	    var index2 = val.lastIndexOf("]");
	    index1++;
	    idIcdNo = val.substring(index1, index2);
	    if (idIcdNo == "") {
	        return;
	    } else {
	       
	        for(var i=0;i<autoIcdCode.length;i++){
	   		  var icdNo1 = icdData[i].icdCode;
	   		  icdValue = icdData[i].icdId;
	   		  if(icdNo1 == idIcdNo){
	   			var checkCurrentRowIddd = $(item).closest('tr').find("td:eq(3)").find("input:eq(0)").attr("id");
			     var checkCurrentRow = $(item).closest('tr').find("td:eq(3)").find("input:eq(0)").val();
	   			  $('#referalGrid tr').each(function(i, el) {
	   				//alert("icdNo1"+icdNo1)
	   				//alert("icdValue "+icdValue)
	   				  var $tds = $(this).find('td');
						var chargeCodeId = $($tds).closest('tr').find("td:eq(3)").find("input:eq(0)").attr("id");
						var chargeCodeIdValue = $('#' + chargeCodeId).val();
						var idddd = $(item).closest('tr').find("td:eq(3)").find("input:eq(0)").attr("id");
						var currentidddd = $(item).closest('tr').find("td:eq(2)").find("textarea:eq(0)").attr("id");
						//alert("chargeCodeIdValue "+chargeCodeIdValue)
						if (chargeCodeId != checkCurrentRowIddd && icdValue == chargeCodeIdValue) {
							if (icdValue == chargeCodeIdValue) {
								alert("Diagnosis is already added");
								$('#' + idddd).val("");
								$('#' + currentidddd).val("");
								$('#'+ chargeCodeIdValue).val("");
								return false;
							}
						} 
						else {
		               			  $(item).closest('tr').find("td:eq(3)").find("input:eq(0)").val(icdValue);
		               			 
						}  
			}); 
	   		}
	   	  }
	    }
	}
	
	var refferalDdata='';
	 var masEmpanelledList='';
	 function getRefferalDetailsMedicalCat() {
	     var pathname = window.location.pathname;
	     var accessGroup = "MMUWeb";
	     var visitId = $('#visitId').val();
	  	 var patientId=$('#patientId').val();
	     //var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/getMBPreAssesDetails";
	     $.ajax({
	         type: "POST",
	         contentType: "application/json",
	         url: "getMBPreAssesDetails",
	         data: JSON.stringify({
	             'visitId':visitId,
	             'patientId':patientId
	         }),
	         dataType: 'json',
	         timeout: 100000,

	         success : function(response) {
					$("#referalGrid tr").remove();	
					var datas = response.data;	
					var trHTML = '';
					var i=0;
					console.log(datas);
					$.each(datas, function(i, item) {
	                var investigationName=item.inveName;
					var icdName=item.icdName;
					var icdId=item.diagnosisId;
					var selectCheck=item.applyFor;
	                var i=0;
	 				var trHTML='';
	 				var selectFre="";
	 				if(selectCheck=='Y')
					{
	 				    trHTML += '<tr>';	
	 					trHTML +=' <td><select name="hospitalName1" id="hospitalName1"   class="form-control" tabindex="36">'+empanelledHospital+'</select></td>';
	 					trHTML +='<td><select name="specialistDeptList1" id="specialistDeptList1'+i+'"   class="form-control" tabindex="36">'+specialistDeptList+'</select></td>';
	 					trHTML +='<td><div class="autocomplete"><textarea class="form-control" id="diagnosisId'+i+'" value="" onblur="fillDiagnosisCombo(this.value,this);" placeholder="Diagnosis">'+icdName+'</textarea></div></td>														';
	 					trHTML +='<td style="display: none";><input type="hidden" id="diagnosisIdValue'+i+'" value="'+icdId+'" class="form-control"/></td>';
	 					trHTML +='<td><input type="text" id="instructionName" value="" class="form-control"></td>';
	 					trHTML +='<td><button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForFinalObservation();"></button></td>';
	 					trHTML +='<td><button type="button" name="delete" value="" class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" onclick="removeRowInvestigation(this)"></button></td>';
	 					trHTML +='</tr>';
	 					i++;
	 						
					}	
	 					 $('#referalGrid').append(trHTML);
	 					       
	         	  });
	         	  
	         	 
	             //putIcdIdValue(autoIcdList, icdData);

	         },
	         error: function(jqXHR, exception) {
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
	  }
	 
	 function masIcdList() {
			
		    var pathname = window.location.pathname;
		    var accessGroup = "MMUWeb";

		    var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/getIcdList";

		    $.ajax({
		        type: "POST",
		        contentType: "application/json",
		        url: url,
		        data: JSON.stringify({
		            'employeeId': '1'
		        }),
		        dataType: 'json',
		        timeout: 100000,

		        success: function(res)

		        {
		        	icdData = res.ICDList;
		        	autoIcdCode=res.ICDList;
		            //alert(data.length);
		            //console.log('data :',data);
		            var autoIcdList = [];
		            for (var i = 0; i < icdData.length; i++) {
		                var icdId = icdData[i].icdId;
		                var icdCode = icdData[i].icdCode;
		                var icdName = icdData[i].icdName;
		                var a = icdName + "[" + icdCode + "]"

		                var icdId = icdName + "[" + icdId + "]"
		                autoIcdList[i] = a;
		                    //alert("a "+a);
		                arry.push(a);
		                icdArry.push(icdId);
		                //console.log('data :', a, icdId);
		            }
		           
		            //putIcdIdValue(autoIcdList, icdData);

		        },
		        error: function(jqXHR, exception) {
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
	$('#dateOfExam').val(todayDate);
});
	
	 var arry = new Array();
	 var icdArry = new Array();
	 var inIcdVal=$('#referalGrid').children('tr:first').children('td:eq(2)').find(':input')[0]
	 oldautocomplete(inIcdVal, arry);
	
</script>
</body>
 

</html>