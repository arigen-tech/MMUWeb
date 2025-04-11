<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%-- <%@include file="..//view/leftMenu.jsp" %> --%>
 <%--  <%@include file="..//view/commonJavaScript.jsp"%>  --%>
      
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Specialist Doctor</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
     <!-- <link href="//resources/css/icons1.css" rel="stylesheet" type="text/css" /> -->
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
 <div>
		<!-- Start content -->
		  <div class="col-md-4">
					<div id="successmsg" style="color:green; align:center;">
										${message}
					</div>
		  </div>
		
		
			<div class="container-fluid">
				<input type="hidden" name="currentObjectForResultOffLineDate" id="currentObjectForResultOffLineDate" value=""/>
		        <input type="hidden" name="currentObjectForResultOffLinenumber" id="currentObjectForResultOffLinenumber" value=""/>

				<div class="row">
					<div class="col-12">					

										<div class="row">											
												
											 <div class="col-12">
												<h6 class="text-theme text-underline font-weight-bold">
												Patient Details</h6>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-4 col-form-label">Service No.</label>
													<div class="col-md-7">
														<input type="text" class="form-control custom_date"
															name="fromDate" id="service_no" readonly>
													</div>
												</div>
											</div>

											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-4 col-form-label">Name</label>
													<div class="col-md-7">
														<input type="text" class="form-control custom_date"
															name="fromDate" id="name1" readonly>
													</div>
												</div>
											</div>

											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-4 col-form-label">Age</label>
													<div class="col-md-7">
														<input type="text" class="form-control custom_date"
															name="fromDate" id="age1" readonly>
													</div>
												</div>
											</div>

											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-4 col-form-label">Gender</label>
													<div class="col-md-7">
														<input type="text" class="form-control custom_date"
															name="fromDate" id="gender1" readonly>
													</div>
												</div>
											</div>

											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-4 col-form-label">Rank</label>
													<div class="col-md-7">
														<input type="text" class="form-control custom_date"
															name="fromDate" id="rank1" readonly>
													</div>
												</div>
											</div>

											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-4 col-form-label">MB Type</label>
													<div class="col-md-7">
														<input type="text" class="form-control custom_date"
															name="fromDate" id="mb_type1" readonly>
													</div>
												</div>
											</div>


										</div>

										<div class="row">
										<div class="col-12">
										<h6 class="text-theme text-underline font-weight-bold">Present
											Medical Category (Composite)</h6>
										
										<table class="table table-hover table-striped table-bordered">
											<thead class="bg-success" style="color: #fff;">
												<tr>
													<th id="th1">Medical Category</th>
													<th id="th2">Date of Category</th>

												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input id="medicalCompositeName1" type="text" class="form-control" readonly></td>
													<td><input id="medicalCompositeDate1" type="text" class="form-control" readonly></td>

												</tr>

											</tbody>
										</table>
										
										</div>
										</div>

										<div class="tablediv">
											<h6 class="text-theme text-underline font-weight-bold">List of
												Medical Category</h6>
											<table class="table table-hover table-striped table-bordered">
	                                        <thead class="bg-success" style="color:#fff;">
													<tr>
													   <th id="th1">Select</th>
                                                        <th id="th2" style="    width: 275px;">Diagnosis</th>
                                                        <th id="th3">Medical Category</th>
                                                        <th id="th4" style="width:80px;">System</th>
                                                        <th id="th5">Type of Category</th>
                                                        <th id="th7" style="width: 80px;">Duration<br/> (P&#8594;Month) <br/> (T&#8594;Week) </th>
                                                        <th id="th6">Category Date</th>
                                                        <th id="th8">Next Category Date </th>
													</tr>
												</thead>
												<tbody id="medicalCategoryShow">
                                                                                <!-- <tr>
                                                                                    <td>
                                                                                        <div class="form-check form-check-inline">
                                                                                            <input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="">
                                                                                         </div>
                                                                                    </td> 
                                                                                    <td>
                                                                                        <div class="autocomplete">
                                                                                        <input type="text" class="form-control" id="diagnosisIdMedical" onblur="fillDiagnosisComboMedical(this.value,this);" placeholder="Diagnosis" />
                                                                                        </div>
                                                                                         </td>
                                                                                        
                                                                                    <td>
                                                                                        <input type="text" class="form-control"> </td>
                                                                                    <td>
                                                                                        <input type="text" class="form-control">
                                                                                    </td>
                                                                                    <td>
                                                                                        <input type="text" class="form-control"> </td>
                                                                                    <td>
                                                                                       <div class="dateHolder">
																	                    <input type="text" id="diagnosisDate" 
																	                     name="diagnosisDatesssss" class="input_date form-control" 
																	                     placeholder="DD/MM/YYYY" value="" maxlength="10" />
																	                    </div>
                                                                                    </td>
                                                                                    <td>
                                                                                        <input type="text" class="form-control"> </td>
                                                                                    <td>
                                                                                         <div class="dateHolder">
																	                    <input type="text" id="nextDiagnosisDate" name="nextDiagnosisDatess" class="input_date form-control" placeholder="DD/MM/YYYY" value="" maxlength="10" />
																	                    </div>
                                                                                       </td>
                                                                                      <td style="display: none";><input type="hidden"
																						value="" tabindex="1" id="diagnosisIdval" size="77"
																						name="diagnosisIdval" />
																					</td>										  
												  </tr>	 -->
												  												  
												</tbody>											
											</table>
										</div>
 

										<div class="row">
										<div class="col-md-12">
											<h6 class="text-theme text-underline font-weight-bold">Vitals</h6>
										</div>
										<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Height</label>
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
																<input name="height" id="height1"
																	maxlength="3"
																	type="text" class="form-control border-input"
																	onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																	placeholder="Height" value="" readonly />
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
																	onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																	class="form-control border-input"
																	placeholder="Ideal Weight" maxlength="5" readonly/>
																<div class="input-group-append">
														      <div class="input-group-text">kg </div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Weight </label>
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
																<input name="Weight" id="weight1"
																	onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																	type="text" class="form-control border-input"
																	maxlength="5"
																	placeholder="Weight" readonly/>
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
																	placeholder="Temperature" value="" readonly />
																<div class="input-group-append">
														      <div class="input-group-text">F </div>
														    </div>																			    
														  </div>
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Pulses </label>
													<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
																<input name="pulse" id="pulse" type="text"
																	class="form-control border-input"
																	onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																	placeholder="Pulse" value="" maxlength="8" readonly />
																<div class="input-group-append">
														      <div class="input-group-text">min </div>
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
																maxlength="30" readonly/>
																<div class="input-group-append">
														      <div class="input-group-text">% </div>
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
														      <div class="input-group-text">kg/m2 </div>
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
																maxlength="3" readonly/>
																<div class="input-group-append">
														      <div class="input-group-text">/min </div>
														    </div>
														    
														  </div>
														</div>
													 
												</div>
											</div> 
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-3">
														<label for="service" class="col-form-label">BP</label>
													</div>
													<div class="col-md-3 offset-md-2">

															<input name="bp" id="bp" type="text" maxlength="3"
																onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																class="form-control border-input bpSlash" placeholder="SBP"
																value="" readonly> 
													<span></span> <!-- slash for bp -->
														  
													</div>
													<div class="col-md-4">
														<div class="input-group mb-2 mr-sm-2">
																<input name="bp1" id="bp1" type="text" maxlength="3"
																	onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																	class="form-control border-input bmiInput"
																	placeholder="DBP" value="" readonly>
																<div class="input-group-append">
														      <div class="input-group-text">mmHg</div>
														    </div>
														  </div>
													</div>
												</div>
											</div>
											
											
										
									</div>

 


                                 <div class="row">
									<div class="col-12">
										<h6 class="text-theme text-underline font-weight-bold">Investigation</h6>
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
														</tr>
													</thead>
													<tbody id="dgInvetigationGrid">

														<tr>
															<td >
																<div class="form-check form-check-inline cusCheck">
																	<input class="form-check-input position-static"
																		type="checkbox" name="checkBoxForUpload"
																		id="checkBoxForUpload" onClick="return getInvestionCheckData(this);" >
																		<span class="cus-checkbtn"></span>
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
										</div>
									 
											
										<div class="row">
										<div class="col-12">
											          <h6 class="text-theme text-underline font-weight-bold">Other Details</h6>
							          	</div>
														<div class="col-md-6">
															<div class="form-group row">
																<div class="col-md-3">
																	<label for="service" class="col-form-label">Chief	Complaint</label>
																</div>
																<div class="col-md-9">
																	<textarea class="form-control" id="chiefComplaint"
																		name="chiefComplaint" rows="2" readonly></textarea>
																</div>
															</div>
														</div>


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
																				maxlength="500" readonly></textarea>
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
																				maxlength="500" readonly></textarea>
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
																				maxlength="500" readonly></textarea>
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
																				maxlength="500" readonly></textarea>
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
																				maxlength="500" readonly></textarea>
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
																				maxlength="500" readonly></textarea>
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
																				maxlength="500" readonly></textarea>
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
																				placeholder="GCS" maxlength="500" readonly></textarea>
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
																				maxlength="500" readonly></textarea>
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
																				maxlength="500" readonly></textarea>
																		</div>
																	</div>
																</div>
											
										</div>
										</div>
										
										</div>

                                        <div class="row">
													<div class="titleBg" style="width: 520px; float: left;">
														<span> System Examination</span>
													</div>
												</div>
                                                <div class="row">
													<div class="col-md-4">
														<div class="form-group row">
															<label class="col-md-5 col-form-label">CNS </label>
															<div class="col-md-7">
																<!-- <input name="CNS" id="cns" type="text" maxlength="25"
																	class="form-control border-input" placeholder="CNS" value="" /> -->
																	<textarea id="cns" class="form-control"  placeholder="CNS"  maxlength="500" readonly>NAD</textarea>
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
																	<textarea id="chest" class="form-control"  placeholder="Chest/ Resp"  maxlength="500" readonly>AEBE/NVBS</textarea>
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
																	<textarea id="musculoskeletal" class="form-control"  placeholder="Musculoskeletal"  maxlength="500" readonly>NAD</textarea>
															</div>
														</div>
													</div>

													<div class="col-md-4">
														<div class="form-group row">
															<label class="col-md-5 col-form-label">CVS </label>
															<div class="col-md-7">
																<!-- <input name="CVS" id="cvs" type="text" maxlength="25"
																	class="form-control border-input" placeholder="CVS" value="" /> -->
																	<textarea id="cvs" class="form-control"  placeholder="CVS"  maxlength="500" readonly>S1,S2 normally heard</textarea>
															</div>
														</div>
													</div>

													<div class="col-md-4">
														<div class="form-group row">
															<label class="col-md-5 col-form-label">Skin </label>
															<div class="col-md-7">
																<!-- <input name="Skin" id="skin" type="text" maxlength="25"
																	class="form-control border-input" placeholder="Skin" value="" required> -->
																	<textarea id="skin" class="form-control"  placeholder="Skin"  maxlength="500" readonly>NAD</textarea>
															</div>
														</div>
													</div>

													<div class="col-md-4">
														<div class="form-group row">
															<label class="col-md-5 col-form-label">GI </label>
															<div class="col-md-7">
																<!-- <input name="GI" id="gi" type="text" maxlength="25"
																	class="form-control border-input" placeholder="GI" value="" required> -->
																	<textarea id="gi" class="form-control"  placeholder="GI"  maxlength="500" readonly>P/A-soft,non tender,no palpable</textarea>
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
																	<textarea id="geneticurinary" class="form-control"  placeholder="Genito Urinary"  maxlength="500" readonly>NAD</textarea>
															</div>
														</div>
													</div>
                                      
													<div class="col-md-4">
														<div class="form-group row">
															<label class="col-md-5 col-form-label">Others </label>
															<div class="col-md-7">
																<!-- <input name="Others" id="others1" type="text" maxlength="25"
																	class="form-control border-input" placeholder="Others" value="" required> -->
																	<textarea id="others1" class="form-control"  placeholder="Others"  maxlength="500" readonly></textarea>
															</div>
														</div>
													</div>

												</div>


										<div class="row">
										<div class="col-12">
											<h6 class="text-theme text-underline font-weight-bold">Final Observation</h6>
										</div>
										
											<div class="tablediv col-12">
												<h6 >For Referral</h6>
												<table
													class="table table-hover table-striped table-bordered">
													<thead class="bg-success" style="color: #fff;">
														<tr>
															<th id="th2">Hospital Name</th>
															<th id="th3">Speciality</th>
															<th id="th4">Diagnosis</th>
															<th id="th5">Instruction</th>
															<th id="th7">Specialist Opinion</th>
															<th id="th8">View Document</th>
														</tr>
													</thead>
													<tbody id="referalGrid">
														<tr style="display:none;">
															<td><select name="hospitalName" id="hospitalName"   class="form-control" 
																tabindex="36" readonly>
																	<option value="">Select</option>

															</select>
															</td>
															<td><input type="text" id="specialityName" value="" class="form-control" readonly>
															</td>
															<td>
																<div class="autocomplete">
																	<input type="text" class="form-control"
																		id="diagnosisId"
																		onblur="fillDiagnosisCombo(this.value,this);"
																		placeholder="Diagnosis" readonly/>
																</div>
															</td>
															<td style="display: none";>
																<input type="hidden" id="diagnosisIdValue" value="" class="form-control" readonly/>
															</td>
															<td>
																<input type="text" id="instructionName" value="" class="form-control">
															</td>
															
															<!-- <td>
															<button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForFinalObservation();"></button>
                                                            </td>
															<td>
																<button type="button" name="delete" value=""
																	class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"
																	onclick="removeRowInvestigation(this)">
																</button>
															</td> -->
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
														<textarea id="refferalRemarks" class="form-control" readonly></textarea>
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
														<textarea class="form-control" id="finalObservation" readonly></textarea>
													</div>
												</div>
											</div>
											
											<!-- <div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Specialist Opinion</label>
													<div class="col-md-7">
														<textarea class="form-control" id="specialistOpinion"></textarea>
													</div>
												</div>
											</div> -->
										
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
													<!-- <button type="button" class="btn btn-primary" value=""  tabindex="1" id="clicked" onclick="saveSpecialistOpinionDetails();">Submit</button> -->
													<button class=" btn btn-danger" data-dismiss="modal">Close</button>
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
										<div class="col-md-5">
												<input type="hidden" id="opdPatientDetailsId" name="opdPatientDetailsId" value="">
										</div>	
										</div>

									</div>

								</div>
						 
					</div>
				
		</div>		 


		
<script type="text/javascript">
             var visitId='';
             var patientId='';
             var opdPatientDetailsId='';
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
                    visitId=document.getElementById('visitId').value;
                }
                if (data.data[0].opdPatientDetailsId != null) {
                    document.getElementById('opdPatientDetailsId').value = data.data[0].opdPatientDetailsId;
                    opdPatientDetailsId=document.getElementById('opdPatientDetailsId').value;
                }
                if (data.data[0].patientId != null) {
                    document.getElementById('patientId').value = data.data[0].patientId;
                    patientId= document.getElementById('patientId').value;
                }
                if (data.data[0].mbType != null) {
                    document.getElementById('mb_type1').value = data.data[0].mbType;
                 }
                if (data.data[0].patientName != null) {
                    document.getElementById('name1').value = data.data[0].patientName;
                }
                if (data.data[0].age != null) {
                    document.getElementById('age1').value = data.data[0].age;
                }
                if (data.data[0].gender != null) {
                    document.getElementById('gender1').value = data.data[0].gender;
                }
                if (data.data[0].rank != null) {
                    document.getElementById('rank1').value = data.data[0].rank;
                }
                if (data.data[0].height != null) {
                    document.getElementById('height1').value = data.data[0].height;
                }
                if (data.data[0].idealWeight != null) {
                    document.getElementById('ideal_weight').value = data.data[0].idealWeight;
                }
                if (data.data[0].weight != null) {
                    document.getElementById('weight1').value = data.data[0].weight;
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
                if (data.data[0].cheifComplaint != null) {
                    document.getElementById('chiefComplaint').value = data.data[0].cheifComplaint;
                }
                if (data.data[0].pollar != null) {
                    document.getElementById('pollar').value = data.data[0].pollar;
                }
                if (data.data[0].edema != null) {
                    document.getElementById('ordema').value = data.data[0].edema;
                }
                if (data.data[0].cyanosis != null) {
                    document.getElementById('cyanosis').value = data.data[0].cyanosis;
                }
                if (data.data[0].hairnail != null) {
                    document.getElementById('hairnail').value = data.data[0].hairnail;
                }
                if (data.data[0].icterus != null) {
                    document.getElementById('icterus').value = data.data[0].icterus;
                }
                if (data.data[0].lymphNode != null) {
                    document.getElementById('lymphNode').value = data.data[0].lymphNode;
                }
                if (data.data[0].clubbing != null) {
                    document.getElementById('clubbing').value = data.data[0].clubbing;
                }
                if (data.data[0].gcs != null) {
                    document.getElementById('gcs').value = data.data[0].gcs;
                }
                if (data.data[0].Tremors != null) {
                    document.getElementById('Tremors').value = data.data[0].Tremors;
                }
                if (data.data[0].gcs != null) {
                    document.getElementById('others').value = data.data[0].others;
                }
                if (data.data[0].cns != null) {
                    document.getElementById('cns').value = data.data[0].cns;
                }
                if (data.data[0].chestResp != null) {
                    document.getElementById('chest').value = data.data[0].chestResp;
                }
                if (data.data[0].musculoskeletal != null) {
                    document.getElementById('musculoskeletal').value = data.data[0].musculoskeletal;
                }
                if (data.data[0].cvs != null) {
                    document.getElementById('cvs').value = data.data[0].cvs;
                }
                if (data.data[0].skin != null) {
                    document.getElementById('skin').value = data.data[0].skin;
                }
                if (data.data[0].gi != null) {
                    document.getElementById('gi').value = data.data[0].gi;
                }
                if (data.data[0].geneticurinary != null) {
                    document.getElementById('geneticurinary').value = data.data[0].geneticurinary;
                }
                if (data.data[0].systemOthers != null) {
                    document.getElementById('others1').value = data.data[0].systemOthers;
                }
                if (data.data[0].finalObservation != null) {
                    document.getElementById('finalObservation').value = data.data[0].finalObservation;
                }
                if (data.data[0].medicalCategogyName != null) {
                    document.getElementById('medicalCompositeName1').value = data.data[0].medicalCategogyName;
                }
                if (data.data[0].medicalCategogyDate != null) {
                    document.getElementById('medicalCompositeDate1').value = data.data[0].medicalCategogyDate;
                }
                
                getMBPreAssesDetailsData();
                getMBPreAssesDetailsInvResultData();
                getEmpanelledHospital();
                getSpeiclaistDetails();
                
            });
 </script>           

<script type="text/javascript">
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
					var	categoryTypeVal=item.categoryType;
					var mbStatus=item.mbStatus;
					if(categoryTypeVal=='P')
					{
					  categoryType='Permanent';	
					}
					if(categoryTypeVal=='T')
					{
					   categoryType='Temporary';
					}	
					var categoryDate=item.categoryDate;
					var duration=item.duration;
					var nextCategoryDate=item.nextCategoryDate;
					var selectCheck=item.applyFor;
					var checkValue = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1" disabled="true"> <span class="cus-checkbtn"></span>';
					var tr='<tr><td><div class="form-check form-check-inline cusCheck">';
					if(selectCheck=='Y')
					{
						 checkValue = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1" checked disabled="true"> <span class="cus-checkbtn"></span>';
						 tr='<tr style="background-color: #53e551"><td><div class="form-check form-check-inline cusCheck">';
					}	
					
					if(icdName!=null && icdName!=undefined && mbStatus=='P')
					{
					trHTML+=tr+checkValue+'</div></td><td><textarea class="form-control" value="'+icdName+'" id="diagnosisId'+i+'" onblur="fillDiagnosisCombo(this.value,this);" placeholder="Diagnosis" readonly>'+icdName+'</textarea></td><td><input type="text" value="'+medicalCategory+'" id="medicalCategory'+i+'" class="form-control" readonly></td><td><input type="text" value="'+system+'" id="system'+i+'" class="form-control" readonly /> </td><td><input type="text" value="'+categoryType+'" id="categoryType'+i+'" class="form-control" readonly> </td><td><input type="text" value="'+duration+'" id="duration'+i+'" class="form-control" readonly> </td><td><div class="dateHolder"><input type="text" value="'+categoryDate+'" id="diagnosisDate'+i+'" name="diagnosisDatesssss" class="input_date form-control" placeholder="DD/MM/YYYY" maxlength="10" readonly /></div></td><td><div class="dateHolder"><input type="text" value="'+nextCategoryDate+'" id="nextDiagnosisDate'+i+'" name="nextDiagnosisDatess" class="input_date form-control" placeholder="DD/MM/YYYY" maxlength="10" readonly /></div></td><td style="display: none";><input type="hidden" value="" tabindex="1" id="diagnosisIdval" size="77" name="diagnosisIdval" readonly /></td></tr>';	
					//trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationValue+''+'['+investigationId+']'+'" id="chargeCodeName1'+i+'" class="form-control border-input" name="chargeCodeName1" onblur="populateChargeCode(this.value,1,this);" /> </div></td><td><div class="dateHolder"> <input type="text" id="investigationDate1Temp'+i+'" name="investigationDatess" class="input_date form-control" placeholder="DD/MM/YYYY" value='+today+' maxlength="10" /></div></td><td><input type="checkbox" name="urgent" id="otherAfLabCheck" tabindex="1" class="radioAuto" value="I" checked/></td><td><input type="checkbox" name="urgent" id="uCheck" tabindex="1" class="radioAuto" value="1" /><td style="display:none";><input type="hidden" value="'+investigationId+'" tabindex="1" id="inestigationIdval2'+i+'" size="77" name="inestigationIdval" /></td> </td><td><button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForInvestigation();"></button></td><td><button type="button" name="delete" value="" class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" onclick="removeRowInvestigation(this)"></button></td></tr>';
					i++;
					}
					
									
	        });
			$('#medicalCategoryShow').append(trHTML);
		}
      });
	}
	
function getMBPreAssesDetailsInvResultData() {
 	
	var approvalFlag=$('#approvalFlag').val();
	 var approvalFlagDiasable="";
	 if(approvalFlag!="" && approvalFlag!=undefined && approvalFlag!=null && approvalFlag=='y'){
		 approvalFlagDiasable='disabled';
	 }
	 else{
		 approvalFlagDiasable="";
	 }
	
	var investigationGridValue = "investigationGrid";
	var investigationData="";
	var visitId = $('#visitId').val();
	var opdPatientDetailId=$('#opdPatientDetailId').val();
	var patientId=$('#patientId').val();
	var totalRidcUploadVal=0;
	var data = {
		"visitId" : visitId,
		"opdPatientDetailId":1,
		"patientId":patientId,
		"flagForModule":"me"
	};
	 var pathname = window.location.pathname;
   var accessGroup = "MMUWeb";
   var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalexam/getInvestigationAndResult";
	$.ajax({
				type : "POST",
				contentType : "application/json",
				//url : '/AshaWeb/opd/getInvestigationDetail',
				url:url,
				data : JSON.stringify(data),
				dataType : "json",
				success : function(res) {
					//data = res.listObject;
					  data = res.listObject;
					var  subListData = res.subInvestigationData; 
					
					var count = 1;
					var countins = 1;
					var investigationfinalValue = "";
					var diasableValue="disabled";
					var checkedVal="";
					var diasableValueCheck="";
					var otherInvergation="";
					var countForSub=0;
					 func1='populateChargeCode';
		    		   url1='medicalexam';
		    		   url2='getInvestigationListUOM';
		    		   flaga='investigationMe';
					if (data != null && data.length > 0) {
						otherInvergation=data[0].otherInvestigation;
						
						for (var i = 0; i < data.length; i++) {
							
							if(data[i].investigationType!="" && data[i].investigationType=='m'){
								
								readonlyOnlyForInvestigation="readonly";
							}
							else{
								readonlyOnlyForInvestigation="";
							}
					
					
							
							investigationData += '<tr>';
					
							
							var ridcIdVal=0;
							if (subListData != null && subListData.length > 0) {
								for (var j = 0; j < subListData.length; j++) {
										if(data[i].investigationId==subListData[j].investigationIdSub){
											ridcIdVal=subListData[j].ridcIdSub
											break;
										}
										else{
											ridcIdVal=0;
										}
								}
							}
					if(data[i].investigationType!="" && (data[i].investigationType=='s'||data[i].investigationType=='t')){
						
							if (data != null && data[i].ridcIdInvVal) {
								ridcIdVal= data[i].ridcIdInvVal;
							}
							else{
								ridcIdVal=0;
							}
							}
							
						if(ridcIdVal!=null && ridcIdVal!=0)
							{
							 diasableValueCheck="disabled";
							checkedVal="checked";
							}
						else{
							diasableValueCheck="";
							checkedVal="";
						}
							
							investigationData += '<td> ';
							investigationData += '<div class="form-check form-check-inline cusCheck">';
							investigationData += ' 	<input class="form-check-input position-static"   type="checkbox" '+checkedVal+' '+diasableValueCheck+' name="checkBoxForUpload" id="checkBoxForUpload'+data[i].investigationId+'" onClick="return getInvestionCheckData(this);">';
							investigationData += '<span class="cus-checkbtn"></span> </div> ';
							investigationData += ' </td> ';
							
							investigationData += '<td><div   class="autocomplete forTableResp">';
							investigationData += '<input type="text"  readonly value="'
									+ data[i].investigationName + '['
									+ data[i].investigationId
									+ ']" id="chargeCodeName' + count + '"';
							//investigationData += ' class="form-control border-input" name="chargeCodeName" autocomplete="off" onKeyPress="autoCompleteCommonMe(this,1);" onblur="populateChargeCode(this.value,'+ countins +',this);" '+approvalFlagDiasable+'/>';
							investigationData += ' class="form-control border-input" name="chargeCodeName" autocomplete="off"   onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" '+approvalFlagDiasable+'/>';
							
							investigationData += '<input type="hidden" id="qty" tabindex="1" name="qty1"  maxlength="6"/>';
							investigationData += '<input type="hidden" tabindex="1" id="chargeCodeCode"';
							investigationData += 'name="chargeCodeCode"   readonly />';
							investigationData += '<input type="hidden"  name="investigationIdValue" value="'
									+ data[i].investigationId
									+ '"  id="investigationIdValue'
									+ data[i].investigationId + '"/>';

							investigationData += '<input type="hidden"  name="dgOrderDtIdValue" value='
									+ data[i].dgOrderDtId
									+ ' id="dgOrderDtIdValue'
									+ data[i].dgOrderDtId + '"/>';
							investigationData += '<input type="hidden"  name="dgOrderHdId" value='
									+ data[i].orderHdId
									+ ' id="dgOrderHdId'
									+ data[i].orderHdId + '"/>';
						var resultHdId=0;
							if(data[i].dgResultHd!=null && data[i].dgResultHd!=undefined){
								resultHdId=data[i].dgResultHd;
							}
							else{
								resultHdId=0;
							}
							var resultdtId=0;
							if(data[i].dgResultDt!=null && data[i].dgResultDt!=undefined){
								resultdtId=data[i].dgResultDt;
							}
							else{
								resultdtId=0;
							}
							investigationData += '<input type="hidden"  name="dgResultHdId" value='+resultHdId+' id="dgResultHdId'
								+ resultHdId + '"/>';
							
							investigationData += '<input type="hidden"  name="dgResultDtId" value='+resultdtId+ ' id="dgResultDtId'
								+ resultdtId + '"/>';
							
								
							var investigationTypeForInves="";
							if(data[i].investigationType!=null){
								investigationTypeForInves=data[i].investigationType;
							}
							else{
								investigationTypeForInves="";
							}
							
							var subChargeCodeIdForInves="";
							if(data[i].subChargeCodeIdForInv!=null){
								subChargeCodeIdForInves=data[i].subChargeCodeIdForInv;
							}
							else{
								subChargeCodeIdForInves="";
							}
							
							var mainChargeCodeIdForInves="";
							if(data[i].mainChargeCodeForInv!=null){
								mainChargeCodeIdForInves=data[i].mainChargeCodeForInv;
							}
							else{
								mainChargeCodeIdForInves="";
							}
							
							
							investigationData += '	 <input type="hidden" name="investigationType" value="'+investigationTypeForInves+'"';
							investigationData += 'id="investigationType'+i+'" />';
							
							
							
							investigationData += '<input type="hidden" name="subChargecodeIdForInv" value="'+subChargeCodeIdForInves+'"';
							investigationData += '	id="subChargecodeIdForInv'+count+'" />';
						
							
							investigationData += '<input type="hidden" name="mainChargecodeIdValForInv" value="'+mainChargeCodeIdForInves+'"';
							investigationData += '	id="mainChargecodeIdValForInv'+count+'" />';
				
							
							investigationData += '<div id="investigationDivMe'+count+'" class="autocomplete-itemsNew"></div>';


							investigationData += ' </div></td>';
								var saveInDraft=$('#saveInDraft').val();
							
							
							
							investigationData += '	<td>';
							investigationData += '	<input type="text" name="UOM" id="UOM'+count+'" value="'+data[i].uomName+'" class="form-control" '+approvalFlagDiasable+' readonly>';
							investigationData += '	</td>';
							
						 	
							if(data[i].mainChargeCodeNameForInve=='Lab'){
	 							
								investigationData += '	<td>';
	 							//investigationData += '	<input type="text" name="resultInvs" '+approvalFlagDiasable+' id="resultInvs'+count+'" value="'+data[i].result+'" class="form-control" '+readonlyOnlyForInvestigation+' >';
								investigationData+='<input type="text" readonly name="resultInvsTemp" '+approvalFlagDiasable+' id="resultInvsTemp'+data[i].investigationId+'" value="'+escapeHtml(data[i].result)+'" class="form-control"  onBlur="setLabResultInFieldMe(this);" '+readonlyOnlyForInvestigation+'  >';
								investigationData += '	<input type="hidden" name="resultInvs" id="resultInvs'+data[i].investigationId+'" value="@@@###'+escapeHtml(data[i].result)+'" class="form-control">';
	 							
								
								investigationData += '	</td>';

							}	
							
							if(data[i].mainChargeCodeNameForInve=='Radio'){
								investigationData += '	<td>';
								investigationData+='<textarea name="resultInvs" id="resultInvs'+data[i].investigationId+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###'+escapeHtml(data[i].result)+'</textarea>';
								investigationData+='<a class="btn-link" href="javascript:void(0)" readonly  data-toggle="modal" data-target="#messageForResult" data-backdrop="static" onclick="openResultModelNew(this);">View/Enter Result</a>';
								investigationData += '	</td>';
							}
							var rangeForInves="";	
							
							
							if(data[i].rangeValue){
								rangeForInves=data[i].rangeValue;
							}
							else{
							if(data[i].minNormalValue!=null && data[i].minNormalValue!=undefined && data[i].minNormalValue!=""){
								rangeForInves=data[i].minNormalValue;
							}
							if(data[i].maxNormalValue!=null && data[i].maxNormalValue!=undefined && data[i].maxNormalValue!=""){
								rangeForInves+="-"+data[i].maxNormalValue;
							}
							else{
								
								if(rangeForInves=="")
									rangeForInves="";
								}
							}
							var reultOfflineNumber="";
                          if(data[i].reultOfflineNumber!="")
                          reultOfflineNumber=data[i].reultOfflineNumber;
                         
                          var reultOfflineDate="";
                          if(data[i].resultOffLineDate!="")
                              reultOfflineDate=data[i].resultOffLineDate;
							investigationData += '<td><input type="text" name="range" value="'+rangeForInves+'"';
							investigationData += '	id="range'+count+'" class="form-control" '+readonlyOnlyForInvestigation+' readonly>';
							investigationData += '	<input type="hidden" name="investigationResultDate"   value="'+reultOfflineDate+'"   id="investigationResultDate'+data[i].investigationId+'"  class="form-control" readonly/>';
							investigationData += '	<input type="hidden"  name="resultNumber"    value="'+reultOfflineNumber+'" id="resultNumber'+data[i].investigationId+'"  class="form-control" readonly/></td>';
							
						 
							var investigationRemarks="";	
							if(data[i].investigationRemarks!=null && data[i].investigationRemarks!=undefined){
								investigationRemarks=data[i].investigationRemarks;
							}
							else{
								investigationRemarks="";
								}
							investigationData += '	<td>';
							investigationData += '	<textarea class="form-control"  name="investigationRemarks" id="investigationRemarks'+count+'" rows="2" maxlength="500" '+readonlyOnlyForInvestigation+' readonly>'+investigationRemarks+'</textarea>';
							investigationData += '	 </td>';
							var deleteButtonFlag="";
							if(ridcIdVal!=null && ridcIdVal!=0){		
	 							investigationData += '	<td><a class="btn-link" href="JavaScript:Void(0);"  onclick="viewDocumentForDigi('+ridcIdVal+');" >View Document</a></td>'
	 							totalRidcUploadVal++;
	 							ridcIdVal=ridcIdVal;
	 							deleteButtonFlag='';
	 							}
	 							else{
	 								investigationData += '	<td></td>';
	 								ridcIdVal=0;
	 								deleteButtonFlag='disabled';
	 							}
							
							
														
							investigationData += ' </tr> ';
							

							if(data[i].investigationType!="" && data[i].investigationType=='m'){
								
							if (subListData != null && subListData.length > 0) {
								
								 
								for (var j = 0; j < subListData.length; j++) {
									
									countForSub++;
										if(data[i].investigationId==subListData[j].investigationIdSub){
											 
										var dgSubMasInvestigationId=subListData[j].subInvestigationId;
											var subInvestigationName="";
											if(subListData[j]. subInvestigationName!="" && subListData[j]. subInvestigationName!=undefined)
											subInvestigationName=subListData[j]. subInvestigationName;
											var subInvestigationCode="";
											if(subListData[j].subInvestigationCadeForSub!="" && subListData[j].subInvestigationCadeForSub!=undefined)
												subInvestigationCode=subListData[j].subInvestigationCadeForSub;
											
											var uOMName="";
											if(subListData[j].umoNameSub!="" && subListData[j].umoNameSub!=undefined)
											uOMName=subListData[j].umoNameSub;
											
											var investigationIdVal="";
											if(subListData[j].investigationIdSub!="" && subListData[j].investigationIdSub!=undefined)
											investigationIdVal=subListData[j].investigationIdSub;
											
											var investigationType="";
											if(subListData[j].investigationTypeSub!="" && subListData[j].investigationTypeSub!=undefined)
											investigationType=subListData[j].investigationTypeSub;
											
											var rangeValSub="";
											if(subListData[j].rangeSub!="" && subListData[j].rangeSub!=undefined)
											rangeValSub=subListData[j].rangeSub;
											
											var mainChargeCodeName=""
												if(subListData[j].mainChargeCodeNameForSub!="" && subListData[j].mainChargeCodeNameForSub!=undefined)
											mainChargeCodeName=subListData[j].mainChargeCodeNameForSub;
											var count=countForSub;
											
											var orderDtIdForSub="";
											if(subListData[j].orderDtIdForSub!="" && subListData[j].orderDtIdForSub!=undefined)
											orderDtIdForSub=subListData[j].orderDtIdForSub;
											
											var orderHdIdForSub="";
											if(subListData[j].orderHdIdForSub!="" && subListData[j].orderHdIdForSub!=undefined)
											orderHdIdForSub=subListData[j].orderHdIdForSub;
											
											var resultEntryDtidForSub="";
											if(subListData[j].resultEntryDtidForSub!="" && subListData[j].resultEntryDtidForSub!=undefined)
											resultEntryDtidForSub=subListData[j].resultEntryDtidForSub;
											
											var resultEntryHdidForSub="";
											if(subListData[j].resultEntryHdidForSub!="" && subListData[j].resultEntryHdidForSub!=undefined)
											resultEntryHdidForSub=subListData[j].resultEntryHdidForSub;
											
											
											var mainChargeCodeIdForSub="";
											if(subListData[j].mainChargeCodeIdForSub!="" && subListData[j].mainChargeCodeIdForSub!=undefined)
												mainChargeCodeIdForSub=subListData[j].mainChargeCodeIdForSub;
											
											var subMainChargeCodeIdForSub="";
											if(subListData[j].subMainChargeCodeIdForSub!="" && subListData[j].subMainChargeCodeIdForSub!=undefined)
												subMainChargeCodeIdForSub=subListData[j].subMainChargeCodeIdForSub;
										
											
											var resultForSub="";
											if(subListData[j].resultForSub!="" && subListData[j].resultForSub!=undefined)
												resultForSub=subListData[j].resultForSub;
										
											var investigationRemarksForSub="";
											if(subListData[j].investigationRemarksForSub!="" && subListData[j].investigationRemarksForSub!=undefined)
												investigationRemarksForSub=subListData[j].investigationRemarksForSub;
										
											
											
											var subInvestigationHtml=getSubInvestionByValuesForMb(dgSubMasInvestigationId,subInvestigationName,subInvestigationCode,uOMName,investigationIdVal,investigationType,
													 rangeValSub,mainChargeCodeName,count,orderDtIdForSub,orderHdIdForSub,resultEntryDtidForSub,
													 resultEntryHdidForSub,mainChargeCodeIdForSub,subMainChargeCodeIdForSub,resultForSub,diasableValue,approvalFlagDiasable,investigationRemarksForSub);
											
											investigationData+=subInvestigationHtml;
											
										}
									
									}
								}
							}
							
							
							count++;
						}
						$('#otherInvestigation').val(otherInvergation);
						$("#dgInvetigationGrid").html(investigationData);
						$('#totalLengthDigiFile').val(totalRidcUploadVal);
						
					}
					if(data.length==0){
						$('#totalLengthDigiFile').val("0");
						getInvestigationHtmlForDigiMe();
					}
				}
			});

	return false;
}


function getSubInvestionByValuesForMb(dgSubMasInvestigationId,subInvestigationName,subInvestigationCode,uOMName,investigationIdVal,investigationType,
		 rangeValSub,mainChargeCodeName,count,orderDtIdForSub,orderHdIdForSub,resultEntryDtidForSub,resultEntryHdidForSub,mainChargeCodeIdForSub,subMainChargeCodeIdForSub,resultForSub,
		 disableFlag,deleteButtonFlag,investigationRemarksForSub){
	 func1='populateChargeCode';
	    url1='medicalexam';
	   url2='getInvestigationListUOM';
	   flaga='investigationMeDg';
		 
		var investigationData = '<tr data-id="'+investigationIdVal+'">';
		investigationData +='<td></td>';
		investigationData += '<td><div class="form-group autocomplete forTableResp">';
		investigationData += '<input type="text" readonly autocomplete="never" value="'+subInvestigationName + '[' + dgSubMasInvestigationId + ']"';
		
		investigationData += ' class="form-control border-input" name="subInvestigationName" id="subInvestigationName'+count+'"  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
		investigationData += '<input type="hidden"  name="subInvestigationNameIdAndInv" value="'
				+ dgSubMasInvestigationId +"@@"+investigationIdVal+'"  id="subInvestigationNameIdAndInv' + dgSubMasInvestigationId + '"/>';
		
		investigationData += '<input type="hidden"  name="investigationSubType" value="'
			+ investigationType +'"  id="investigationSubType' +investigationType+ '"/>';

		investigationData += '<input type="hidden"  name="appointmentIdSubInves" value=""  id="appointmentIdSubInves'+count+'"/>';
		investigationData += '<input type="hidden"  name="dgOrderDtIdValueSubInves" value="'+orderDtIdForSub+'" id="dgOrderDtIdValueSubInves'+count+'"/>';
		investigationData += '<input type="hidden"  name="dgOrderHdIdSubInves" value="'+orderHdIdForSub+'" id="dgOrderHdIdSubInves'+count+'"/>';

		investigationData += '<input type="hidden" name="subChargecodeIdForSub" value="'+subMainChargeCodeIdForSub+'"';
		investigationData += '	id="subChargecodeIdForSub'+count+'" />';
		
			
		investigationData += '<input type="hidden" name="mainChargecodeIdValForSub" value="'+mainChargeCodeIdForSub+'"';
		investigationData += '	id="mainChargecodeIdValForSub'+count+'" />';
		
		investigationData += '<input type="hidden"  name="dgResultDtIdValueSubInves" value="'+resultEntryDtidForSub+'" id="dgOrderDtIdValueSubInves'+count+'"/>';
		investigationData += '<input type="hidden"  name="dgResultHdIdSubInves" value="'+resultEntryHdidForSub+'" id="dgOrderHdIdSubInves'+count+'"/>';
	
		
		
		investigationData += '<div id="investigationDivMe" class="autocomplete-itemsNew"></div>';
		investigationData += '</div></td>';

		investigationData += '	<td>';
		investigationData += '	<input type="text" name="UOMSub" id="UOMSub'+count+'" value="'+uOMName+'" class="form-control" redonly  >';
		investigationData += '	</td>';
		
		
		 
		if(mainChargeCodeName=='Lab'){
				
				investigationData += '	<td>';
					//investigationData += '	<input type="text" name="resultSubInv"  id="resultSubInv'+count+'" value="'+resultForSub+'" class="form-control" >';
				 
				investigationData+='<input type="text" name="resultInvsTemp" id="resultInvsTemp'+dgSubMasInvestigationId+'" value="'+escapeHtml(resultForSub)+'"class="form-control" onBlur="setLabResultInFieldDigi(this);" readonly>';
				investigationData += '	<input type="hidden" name="resultSubInv"  id="resultSubInv'+dgSubMasInvestigationId+'" value="@@@###'+escapeHtml(resultForSub)+'" class="form-control" >';
		
				investigationData += '	</td>';

			}	
			
			if(mainChargeCodeName=='Radio'){
				investigationData += '	<td>';
				investigationData+='<textarea name="resultSubInvs" id="resultSubInvs'+dgSubMasInvestigationId+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###'+escapeHtml(resultForSub)+'readonly</textarea>';
				investigationData+='<a class="btn-link" href="javascript:void(0)"  data-toggle="modal" data-target="#messageForResult" data-backdrop="static" onclick="openResultModel(this);">View/Enter Result</a>';
				investigationData += '	</td>';
			}

		
		
		investigationData += '<td><input type="text" name="rangeSubInves" value="'+rangeValSub+'"';
		investigationData += 'id="rangeSubInves'+count+'" class="form-control" readonly></td>';
		 

			investigationData += '	<td>';
			investigationData += '	<textarea class="form-control"  name="investigationRemarksForSub" id="investigationRemarksForSub'+count+'" rows="2" maxlength="500" readonly>'+investigationRemarksForSub+'</textarea>';
			investigationData += '	 </td>';
		
		
		
		investigationData += '	<td></td>';
		 
		var ridcIdVal=0;
		
		investigationData += ' </tr> ';
		count+=1;
	 return investigationData;
}
	
function getEmpanelledHospital() {
	
	var j=1;
    
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getEmpanelledHospital";
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
					var datas = response.masEmpanelledHospital;
					var trHTML = '<option value=""><strong>Select Hospital...</strong></option>';
					$.each(datas, function(i, item) {
						trHTML += '<option value="' + item.empanelledHospitalId + '@'
								+ item.empanelledHospitalCode + '" >' + item.empanelledHospitalName
								+ '</option>';
						
					});
					$('#hospitalName').html(trHTML);
					
				  
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



var i=0;
function addRowForFinalObservation(){
			
  	 // var newIndex = $('.autocomplete').length;
	var val = parseInt($('#referalGrid>tr:last').find("td:eq(0)").text());
	var aClone = $('#referalGrid>tr:last').clone(true)
	//aClone.find("td:eq(0)").text(++val);
	aClone.find(":input").val("");
	aClone.find("option[selected]").removeAttr("selected")
	aClone.clone(true).appendTo('#referalGrid'); 
	var val = $('#referalGrid>tr:last').find("td:eq(2)").find(":input")[0];
	autocomplete(val, arry);
  		
  		
  }


	var total_icd_value = '';
	var digaoReferal = '';
	function fillDiagnosisCombo(val, item) {

		var index1 = val.lastIndexOf("[");
		var index2 = val.lastIndexOf("]");
		index1++;
		idIcdNo = val.substring(index1, index2);
		if (idIcdNo == "") {
			return;
		} else {
			obj = document.getElementById('diagnosisId');
			total_icd_value += val + ",";

			obj.length = document.getElementById('diagnosisId').length;
			var b = "false";
			for (var i = 0; i < autoIcdCode.length; i++) {

				var icdNo1 = icdData[i].icdCode;

				if (icdNo1 == idIcdNo) {
					icdValue = icdData[i].icdId;
					$(item).closest('tr').find("td:eq(3)").find(":input").val(icdValue);
				}
			}
			if (b == "false") {

				$('#diagnosisId').append(
						'<option value=' + icdValue + '>' + val + '</option>');
				document.getElementById('icd').value = ""

			}
		}
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
	 function saveSpecialistOpinionDetails() {
			
			var pathname = window.location.pathname;
			var accessGroup = "MMUWeb";

			var url = window.location.protocol + "//"
					+ window.location.host + "/" + accessGroup
					+ "/medicalBoard/updateSpecialistOpiniondetails";
			
			   ///////////////// Referral Json ////////////////////	
	    	var listofReferallHD =[];
        	var listofReferalDT =[];
        	var dataReferalHD='';
        	$('#referalGrid tr').each(function(i, el) {
        	    var $tds = $(this).find('td')
        	   	var specialistOpinion= $tds.eq(5).find(":input").val();
        		var dgRferralDtId = $tds.eq(6).find(":input").val();
        		        		
        		dataReferalHD={
        			                        'dgRferralDtId' : dgRferralDtId,
        				      				'specialistOpinion': specialistOpinion,
        				      		
        		}
        		listofReferallHD.push(dataReferalHD);
        	});
        
        	
	    	var dataJSON={
	  	   			'visitId':$('#visitId').val(),
	      			'patientId':$('#patientId').val(), 
	      			'departmentId':'1',
	      			'hospitalId' : <%=hospitalId%>,
	      			'userId':<%= userId %>,
	      			"listofRefferalDetails" : listofReferallHD,
					}
	   $("#clicked").attr("disabled", true);    
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : url,
			data : JSON.stringify(dataJSON),
			dataType : 'json',
			timeout : 100000,
			success : function(msg) {
				if (msg.status == 1) {
					var Id= $('#visitId').val()
					window.location.href ="mbSpecialistOpinionSubmit?visitId="+Id+"";
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
	 
	 var refferalDdata='';
	 var masEmpanelledList='';
	 function getSpeiclaistDetails() {
		 var ref=0;
	     var pathname = window.location.pathname;
	     var accessGroup = "MMUWeb";

	     var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/getPatientReferalDetail";
	     $.ajax({
	         type: "POST",
	         contentType: "application/json",
	         url: url,
	         data: JSON.stringify({
	             'opdPatientDetailId':opdPatientDetailsId,
	             'visitId':visitId,
	             'patientId':patientId
	         }),
	         dataType: 'json',
	         timeout: 100000,

	         success: function(res)

	         {
	         	$("#referalGrid tr").remove(); 
	         	   refferalDdata = res.listReferralPatientDt;
	         	   masEmpanelledList=res.masEmpanelledHospitalList;
	         	  $.each(refferalDdata, function(i, item) {
	                 var diagonisId = refferalDdata[i].diagonisId;
	                 var referalNotes = refferalDdata[i].referalNotes;
	                 var referalDate = refferalDdata[i].referalDate;
	                 var referalPatientDt = refferalDdata[i].referalPatientDt;
	                 var massDeptName = refferalDdata[i].massDeptName;
	                 var instruction = refferalDdata[i].instruction;
	                 var daiganosisName = refferalDdata[i].daiganosisName;
	                 var masEmpanalId = refferalDdata[i].masEmpanalId;
	                 var referalPatientHd = refferalDdata[i].referalPatientHd;
	                 var masEmpanalName = refferalDdata[i].masEmpanalName;
	                 var masCode = refferalDdata[i].masCode;
	                 var exDepartmentValue = refferalDdata[i].exDepartmentValue;
	                 var referalNotes=refferalDdata[i].referalNotes;
	                 var speicalistNotes=refferalDdata[i].speicalistNotes;
	                 var ridcId=refferalDdata[i].ridcId;
	                 var referrDtData = '';
	 				var i=0;
	 				var trHTML='';
	 				var selectFre="";
	 				    trHTML += '<tr>';	
	 					trHTML +='<td><select name="hospitalName" id="hospitalName'+i+'" class="medium form-control"';
	 					trHTML +='class="medium" disabled="true">';
	 					trHTML +='<option value=""><strong>Select...</strong></option>';
	 					$.each(masEmpanelledList, function(ij, item) {	
	 					    
	 																
	 						if(masEmpanalId == item.empanelledHospitalId){
	 							selectFre="selected";
	 						}
	 						else{
	 							selectFre="";
	 						}
	 					trHTML += '<option ' + selectFre + ' value="' + item.empanelledHospitalId
	 						+ '@'
	 						+ item.empanelledHospitalCode
	 						+ '" >'
	 						+ item.empanelledHospitalName
	 						+ '</option>';
	 					});
	 					trHTML +='</select>';
	 					trHTML +='</td>';
	 					trHTML +='<td><input type="text" id="specialityName'+ref+'" value="'+exDepartmentValue+'" class="form-control" readonly></td>';
	 					trHTML +='<td><textarea class="form-control" id="diagnosisId'+ref+'" onblur="fillDiagnosisCombo(this.value,this);" placeholder="Diagnosis" rows="2" readonly>'+daiganosisName+'</textarea></td>';
	 					/*trHTML +='<td><input type="text" class="form-control" id="diagnosisId" value="'+daiganosisName+'" onblur="fillDiagnosisCombo(this.value,this);" placeholder="Diagnosis" /></td>';*/
	 					trHTML +='<td style="display: none";><input type="hidden" id="diagnosisIdValue'+ref+'" value="" class="form-control"/></td>';
	 					trHTML +='<td><input type="text" id="instructionName" value="'+instruction+'" class="form-control" readonly></td>';
	 					//trHTML +='<td><textarea class="form-control" rows="2" readonly>'+speicalistNotes+'</textarea></td>';
	 					trHTML += ' <td>';
	 					trHTML += '<textarea name="specialistOpinion" id="specialistOpinion'+ref+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">'+speicalistNotes+'</textarea>';
	 					trHTML += ' <a class="btn-link" href="javascript:void(0)"  onclick="openResultModelSpecialistNew(this);">View/Enter Result</a>';
	 					trHTML += '</td>';
	 					trHTML +='<td style="display: none";><input type="hidden" id="referralDetailIdValue" value="'+referalPatientDt+'" class="form-control" readonly/></td>';
	 					trHTML += '<td><a class="btn-link" href="#" onclick="viewDocumentForDigi('+ridcId+');" >View Document</a></td>'
	 					/*trHTML +='<td><button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForFinalObservation();"></button></td>';
	 					trHTML +='<td><button type="button" name="delete" value="" class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" onclick="removeRowInvestigation(this)"></button></td>';*/
	 					trHTML +='</tr>';
	 					i++;
	 					ref++;
	 					 $('#referalGrid').append(trHTML);
	 					 document.getElementById('refferalRemarks').value=referalNotes;            
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
	 
	 $(function(){
			
			$("#editorOfSpecialistOpinionNew").jqte();
			$("#editorOfResult").jqte();
			
		})
		function openResultModelSpecialistNew(item){
			
			var resultIdIm= $(item).closest('tr').find("td:eq(5)").find("textarea:eq(0)").attr("id");
			var resultView = $('#'+resultIdIm).val();

			if(resultView.includes("@@@###")){
				resultView=resultView.replace("@@@###","");
			}
			resultView = decodeHtml(resultView)
			$('#editorOfSpecialistOpinionNew').jqteVal(resultView);
		 	$('#messageForResultSpeccilaistNew').show();
		 	
			$('#resultIdSpecialistOpinion').val(resultIdIm);
		 	//$('#messageForResultSpeccilaist').show();
		}


		function saveSpecialistOpinionInTextNew(){
			
		 
			 var idOfResult=$('#resultIdSpecialistOpinion').val();
			 var jqetResultValue=$('#editorOfSpecialistOpinionNew').val();
			 
			 if(jqetResultValue!=""){
				 jqetResultValue=jqetResultValue.trim();
				 jqetResultValue="@@@###"+jqetResultValue;
			 }
			 
			 $('#'+idOfResult).val(jqetResultValue);
			 $('#messageForResultSpeccilaistNew').hide();
			
		}
	
		function closeSubModalNew(){
			
			$('#messageForResultSpeccilaistNew').hide();
			$('#messageForResult').hide();
		}
		
		function saveResultInTextMB(){
			 var idOfResult=$('#resultIdImagin').val();
			 var jqetResultValue1=$('#editorOfResult').val();
			 
			 if(jqetResultValue1!=""){
				 jqetResultValue1=jqetResultValue1.trim();
				 jqetResultValue1="@@@###"+jqetResultValue1;
			 }
			 
			 $('#'+idOfResult).val(jqetResultValue1);
			 $('#messageForResult').hide();
				 
		}
	
		function openResultModelNew(item){
			var resultOfflineDateId= $(item).closest('tr').find("td:eq(4)").find("input:eq(1)").attr("id");
			 $('#currentObjectForResultOffLineDate').val(resultOfflineDateId);
			 var resultOfflineNumberId= $(item).closest('tr').find("td:eq(4)").find("input:eq(2)").attr("id");
			 $('#currentObjectForResultOffLinenumber').val(resultOfflineNumberId); 
				/*$('#messageForResult').show();
				$('.modal-backdrop ').show();*/

				var resultIdIm= $(item).closest('tr').find("td:eq(3)").find("input:eq(0)").attr("id");
				if(resultIdIm=="" || resultIdIm==undefined)
				 resultIdIm= $(item).closest('tr').find("td:eq(3)").find("textarea:eq(0)").attr("id");
				
				var resultView = $('#'+resultIdIm).val();
				
				if(resultView.includes("@@@###")){
					resultView=resultView.replace("@@@###","");
				}
				
				//resultView = resultView.replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&quot;/g,"'").replace(/&amp;/g,"&");
				resultView=decodeHtml(resultView);
			 	$('#editorOfResult').jqteVal(resultView) ;
				$('#resultIdImagin').val(resultIdIm);
				 $('#messageForResult').show();
				
				$('#investigationResultDateTemp').val("") ;
				var resultOfflineDate = $j('#'+resultOfflineDateId).val();
				$('#investigationResultDateTemp').val(resultOfflineDate);
				
				$('#resultNumberTemp').val("") ;
				var resultOfflineNumberVal = $j('#'+resultOfflineNumberId).val();
				$('#resultNumberTemp').val(resultOfflineNumberVal) ;
			
		}		
	
</script>


</body>
 

</html>