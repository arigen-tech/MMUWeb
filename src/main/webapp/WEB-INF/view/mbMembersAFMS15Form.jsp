<%@page import="java.util.HashMap"%>
    <%@page import="java.util.Map"%>
        <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

            <%@include file="..//view/leftMenu.jsp" %>
                <%@include file="..//view/commonJavaScript.jsp"%>
                <%@include file="..//view/commonModal.jsp"%>
                    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
                            <!DOCTYPE html>
                            <html lang="en">

                            <head>
                                <meta charset="utf-8">
                                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                <title>AFMSF-15</title>
                                <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
                                <meta content="Coderthemes" name="author" />
                                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                                <!-- <link href="//resources/css/icons1.css" rel="stylesheet" type="text/css" /> -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/medicalexam.js"></script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autoPopulate.js"></script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/commonformodal.js"></script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/uploaddig.js"></script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
  <meta http-equiv="cache-control" content="no-cache, must-revalidate, post-check=0, pre-check=0" />
  <meta http-equiv="cache-control" content="max-age=0" />
  <meta http-equiv="expires" content="0" />
  <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
  <meta http-equiv="pragma" content="no-cache" />
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

<%
response.addHeader("Access-Control-Allow-Origin", "http://localhost:8082");
%>
<script type="text/javascript">
$j(document).ready(function(){
	 getMBPreAssesDetailsData();
	 getMBPreAssesDetailsDataForNewGrid();
	
      
});

</script>
 </head>

                            <body>
                                <div id="wrapper">

                                   <form:form name="amsfForm15Data" id="amsfForm15Data" method="post" enctype='multipart/form-data'
											action="#" autocomplete="on">
										<div class="content-page">
                                            <!-- Start content -->
                                            <div class="col-md-4">
                                                <div id="successmsg" style="color:green; align:center;">
                                                    ${message}
                                                </div>
                                            </div>
                                            <div class="">

                                                <div class="container-fluid">
                                                    <div class="internal_Htext">AFMSF-15(MEDICAL BOARD PROCEEDINGES RE-CATEGORISATION/CATEGORISATION/SICK-LEAVE)</div>

                                                    <div class="row">
                                                        <div class="col-12">
                                                            <div class="card">
                                                                <div class="card-body">
                                                                	<h5 class="text-theme font-weight-bold text-center">CONFIDENTIAL</h5>
                                                                    <div class="row">
                                                                        <div class="col-md-1">
                                                                            <button type="button" onClick="return showEHRRecords();" class="btn btn-primary btn-block">EHR</button>
                                                                        </div>

                                                                        <div class="col-md-3">
                                                                            <button type="button" onClick="return getCompleteMedicalExamMEOrMB('ALL','SearchStatusForUnitAdmin','me');"  class="btn btn-primary btn-block">PREVIOUS MEDICAL EXAMS</button>
                                                                        </div>

                                                                        <div class="col-md-3">
                                                                            <button type="button" onClick="return getCompleteMedicalExamMEOrMB('ALL','SearchStatusForUnitAdmin','mb');" class="btn btn-primary btn-block">PREVIOUS MEDICAL BOARDS</button>
                                                                        </div>

                                                                        <div class="col-md-2">
                                                                            <button type="button" onClick="return showImmunizationTemplateMe('aa');" class="btn btn-primary btn-block">IMMUNIZATIONS</button>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <button type="button" id="specialistOpinion" onclick="getSpecialistOpinionOpen()" abindex="1" class="btn btn-primary"
																               data-toggle="modal" data-backdrop="static" data-target="#exampleModal">SPECIALIST OPINION</button>
                                                                        </div>
                                                                    </div>
                                                                   
								    <input type="hidden" name="visitId" id="visitId" value=""/>
									<input type="hidden" name="hospitalId" id="hospitalId" value="<%=hospitalId%>"/>
									<input type="hidden" name="userId" id="userId" value="<%=userId%>"/>
									<input type="hidden" name="patientId" id="patientId" value=""/>	
									<input type="hidden" name="genderId" id="genderId" value=""/>	
									<input type="hidden" name="saveInDraft" id="saveInDraft" value="draftMo"/>		
									<input type="hidden" name="opdPatientDetailId" id="opdPatientDetailId" value=""/>	
									<input type="hidden" name="referTo" id="referTo" value="E"/>  
									
									<input type="hidden"  name="checkForAuthenticationValue" value="" id="checkForAuthenticationValue" />	
									<input type="hidden"  name="uhidNumberValue" value="" id="uhidNumberValue" />
									<input type="hidden"  name="membType" value="" id="membType" />
									<input type="hidden" name="branchTradDigi" id="branchTradDigi" value="" />	
									<input type="hidden" name="resultIdMedicalDocs" id="resultIdMedicalDocs" />
									<input type="hidden" name="totalLengthDigiFileSupportDoc" id="totalLengthDigiFileSupportDoc" value="0" />	
								
									
                                                                    <div class="row">
                                                                        <h4 class="service_htext" style="border:none;"></h4>
                                                                        
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">Place for board</label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="place">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4"></div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">Authority for Board</label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="authority">
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        
																		<div class="w-100"></div>							
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">1. Name</label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="empName" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">2. Service No.</label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="serviceNo" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">3. Rank</label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="rank" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">4. Unit</label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="unit" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">5. Service </label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="service" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">6. Branch/Trade </label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="branchTrade" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">7. Date Of Birth </label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="dob" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">Age </label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="age" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">8. Sex (M/F) </label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="gender" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                         <!--  <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">Total Service </label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="totalService" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div> -->
                                                                        <div class="col-md-4">
																			<div class="form-group row">
																				<label class="col-md-5 col-form-label">Height</label>
																				<!-- <div class="col-md-7">
																					<input name="height" id="height" type="text" maxlength="3"
																						class="form-control border-input" onblur="idealWeight();checkBMI();" placeholder="Height"
																						value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  />
																				</div> -->
																				<div class="col-md-7">
																					<div class="input-group mb-2 mr-sm-2">
																						<input name="height" id="height" type="text" maxlength="3"
																						class="form-control border-input" placeholder="Height"
																						value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  />
																					    <div class="input-group-append">
																					      <div class="input-group-text">cm</div>
																					    </div>
																					    
																					  </div>
																				</div>
																			</div>
																		</div>
																		<div class="col-md-4">
																			<div class="form-group row">
																				<label class="col-md-5 col-form-label">Weight
																				</label>
																				<!-- <div class="col-md-7">
																					<input name="ideal_weight" id="ideal_weight" maxlength="3" onblur="checkVaration()" type="text"
																						class="form-control border-input"
																						placeholder="Ideal Weight" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" />
																				</div> -->
																				<div class="col-md-7">
																					<div class="input-group mb-2 mr-sm-2">
																						<input name="weight" id="weight" maxlength="5" onblur="checkVaration()" type="text"
																						class="form-control border-input" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" />
																					    <div class="input-group-append">
																					      <div class="input-group-text">kg</div>
																					    </div>
																					    
																					  </div>
																				</div>
																			</div>
																		</div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">9. Address on Leave, if applicable </label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="address_on_leave">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">10. <span id="doe" style="display: none";>Date of Enrollment</span> <span id="doc" style="display: none";>Date of Commission</span> </label>
                                                                                <div class="col-md-7">
                                                                                	<div class="dateHolder">
                                                                                    <input type="text" class="form-control calDate" name="fromDate" id="doe_doc" placeholder="DD/MM/YYYY" />
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">11. Records Office with Address</label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" name="fromDate" id="reccord_office">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">12. Ceased Duty On </label>
                                                                                <div class="col-md-7">
                                                                                	<div class="dateHolder">
                                                                                    <input type="text" class="form-control calDate" name="fromDate" id="ceased" placeholder="DD/MM/YYYY" />
                                                                                    </div>
                                                                                </div>
                                                                                 
                                                                            </div>
                                                                        </div>
                                                                      
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">13. Past Medical History </label>
                                                                                <div class="col-md-7">
                                                                                    <input type="text" class="form-control" value="As Per Column 15" name="fromDate" id=" past_medical_history" readonly/>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">Type Of Commission </label>
                                                                                <div class="col-md-7">
                                                                                   <select class="form-control" id="typeOfCommission" name="typeOfCommission">
																				  <option value="">Select</option>
																				  <option value="SSC">SSC</option>
										   										  <option value="PC">PC</option>
																			     </select>
                                                                                </div>
                                                                            </div>
                                                                        </div> 
                                                                    </div>
																	
																	<div class="row">
																		<div class="col-12 m-t-10">
																			<h6 class="font-weight-bold text-theme text-underline">14. Present Medical Category (Composite)</h6>
																		</div>
																	</div>
                                                                    
                                                                    <table class="table table-hover table-striped table-bordered">
                                                                        <thead class="bg-success" style="color: #fff;">
												<tr>
													<th id="th1">Medical Category</th>
													<th id="th2">Date of Category</th>

												</tr>
											</thead>
											<tbody>
												  <tr>
												    <td>
												    <div class="autocomplete">
												    <input id="medicalCompositeName" type="text" class="form-control" onblur="fillMedicalComposite(this.value,this)" />
												    </div>
												    </td>
													<td>
														<div class="dateHolder">
															<input type="text" id="medicalCompositeDate"
																name="medicalCompositeDate"
																class="input_date form-control" placeholder="DD/MM/YYYY"
																value="" maxlength="10" />
														</div>
													</td>
													<td style="display: none";><input type="hidden"
														value="" tabindex="1" id="medicalCompositVal" size="77"
														name="medicalCompositVal" /></td>

												</tr>											 
												 
												</tbody>
										</table>
																	
																	<div class="row">
																		<div class="col-12 ">
																			<h6 class="font-weight-bold text-theme text-underline">15. Details of Present and Previous Disabilities</h6>
																		</div>
																	</div>
                                                                   
                                                                    <div class="table-responsive">
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
                                       
                                       
                                    <div class="table-responsive">
									    <table class="table table-hover table-striped table-bordered">
                                                <thead class="bg-success" style="color:#fff;">
													<tr>
													    <th id="th1">Diagnosis Name</th>
                                                        <th id="th2">Date Of Origin</th>
                                                        <th id="th2">Place Of Origin</th>
														<!-- <th id="th8">Add</th>
														<th id="th8">Delete</th> -->
													</tr>
												</thead>
												<tbody id="medicalCategoryOrigin">
												
												</tbody>											
											</table>
		                            </div>
									<!-- ------ New Added Fields  ------ -->	
									
									<div class="row m-t-10">
										 <div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-12 col-form-label">16. Specialist Opinion: Attach the clinic summary sheet containing a brief history and present condition, after page 2 without any folds. No part of sheet should protude out of form Opinion att.</label>
                                                 
                                             </div>
                                         </div>
									</div>
															
									<div class="row m-t-10">
										 <div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">17. Is the disability Attributable to service? (Y/N)</label>
                                                 <!-- <div class="col-md-2">
                                                     <select class="form-control" name="disablityAttrService" id="disablityAttrService">
                                                     	<option value="0">Select</option>
                                                     	<option value="Yes">Yes</option>
                                                     	<option value="No">No</option>
                                                     </select>
                                                 </div> -->
                                                 <div class="col-md-3" id="setDisablityAttrServiceRemark">
                                                 	<textarea class="form-control" rows="3" name="disablityAttrServiceRemark" id="disablityAttrServiceRemark" ></textarea>
                                                 </div>
                                             </div>
                                         </div>
									</div>
									
									<div class="row m-t-10">
										 <div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">18. If not directly attributable to service, was it aggravated by service? (Y/N)</label>
                                               <!--   <div class="col-md-2">
                                                     <select class="form-control" name="directlyAttrService" id="directlyAttrService">
                                                     	<option value="0">Select</option>
                                                     	<option value="Yes">Yes</option>
                                                     	<option value="No">No</option>
                                                     </select>
                                                 </div> -->
                                                 <div class="col-md-3" id="setDirectlyAttrServiceRemark">
                                                 	<textarea class="form-control" rows="3" name="directlyAttrServiceRemark" id="directlyAttrServiceRemark"></textarea>
                                                 </div>
                                             </div>
                                         </div>
									</div>
									
									<div class="row m-t-10">
										 <div class="col-md-12">
                                             <div class="form-group row">
                                             	<label class="col-12 col-form-label">Note:</label>
                                                <label class="col-12 col-form-label">1. Injury Report (for injury cases)/14 days Charter of Duties (for IHD cases)/any other relevant Document required, is to be attached and endorsement made in column 17-18.</label> 
                                                 <label class="col-12 col-form-label">2. Column 17-18 should be completed only if they are not completed in initial/earlier board</label>                                                 
                                             </div>
                                         </div>
									</div>
									
                                    <div class="row">
										<div class="col-12 ">
											<h6 class="font-weight-bold text-theme text-underline">19. Medical Category Now Recommended With Duration</h6>
										</div>
									</div>                           
									<div class="table-responsive">
									    <table class="table table-hover table-striped table-bordered">
                                                <thead class="bg-success" style="color:#fff;">
													<tr>
													   <th id="th1">Mark(Fit)</th>
                                                        <th id="th2" style="    width: 275px;">Diagnosis</th>
                                                        <th id="th3">Medical Category</th>
                                                        <th id="th4" style="width:80px;">System</th>
                                                        <th id="th5">Type of Category</th>
                                                        <th id="th7" style="width: 80px;">Duration</th>
                                                        <th id="th6">Category Date</th>
                                                        <th id="th8">Next Category Date </th>
														<th id="th8">Add</th>
														<th id="th8">Delete</th>
													</tr>
												</thead>
												<tbody id="medicalCategoryNew">
                                                    
												  												  
												</tbody>											
											</table>
		                            </div>
		                               <div class="row">
		                            	<div class="col-12">
		                            		<h6 class="font-weight-bold text-theme text-underline">Recommended Medical Category (Composite)</h6>
                                            <table class="table table-hover table-striped table-bordered">
											<thead class="bg-success" style="color:#fff;">
													<tr>
														<th id="th1">Recommended Medical Category</th>
														<th id="th2">Date of Category</th>
														 
													</tr>
												</thead>
												<tbody>
												  <tr>
												    <td>
												    <div class="autocomplete forTableResp">
												    	<input id="recommedicalCompositeName" type="text" class="form-control" onblur="recomfillMedicalComposite(this.value,this)" />
												    	<input id="recommedicalCompositeNamePId" type="hidden" class="form-control"  />
												    </div>
												    </td>
													<td>
														<div class="dateHolder">
															<input type="text" id="recommedicalCompositeDate"
																name="recommedicalCompositeDate"
																class="input_date form-control" placeholder="DD/MM/YYYY"
																value="" maxlength="10" />
														</div>
													</td>
													<td style="display: none";><input type="hidden"
														value="" tabindex="1" id="recommedicalCompositVal" size="77"
														name="recommedicalCompositVal" /></td>
                                                   
												</tr>											 
												 
												</tbody>
										</table>
		                            	</div>
		                            </div>
		                            <div class="row m-t-10">
										 <div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-5 col-form-label">20. Percentage of disability (only for permanent LMC)</label>                                                 
                                             </div>
                                         </div>
                                         <div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">(a) Previous Disablement %</label>
                                                 
                                                 <div class="col-md-3">
                                                 	<input type="text" class="form-control" name="previousDisablement" id="previousDisablement" maxlength="50" maxlength="50"/>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">(b) Present Disablement %</label>
                                                 
                                                 <div class="col-md-3">
                                                 	<input type="text" class="form-control" name="presentDisablement" id="presentDisablement" maxlength="50" maxlength="50"/>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">(c) Reasons for various if any</label>
                                                 
                                                 <div class="col-md-3">
                                                 	<textarea class="form-control" rows="3" name="reasonForVarious" id="reasonForVarious" maxlength="100"></textarea>
                                                 </div>
                                             </div>
                                         </div>
									</div>
									
									<div class="row m-t-10">
										<div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">21. Any specific restriction regarding employment</label>
                                                 
                                                 <div class="col-md-3">
                                                 	<input type="text" class="form-control" name="restrictionRegardingEmp" id="restrictionRegardingEmp" maxlength="100" />
                                                 </div>
                                             </div>
                                         </div>
									</div>
									
									<div class="row m-t-10">
										<div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">22. Instructions given to the individual by the president of the board</label>
                                                 
                                                 <div class="col-md-6">
                                                 	<textarea class="form-control" rows="3" name="instructionRemark" id="instructionRemark" maxlength="2000"></textarea>
                                                 </div>
                                             </div>
                                         </div>
									</div>
									
									<div class="row m-t-10">
										<div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">Note:</label>
                                                 
                                                 <div class="col-md-6">
                                                 	<textarea class="form-control" rows="3" name="instructionNote" id="instructionNote" maxlength="2000"></textarea>
                                                 </div>
                                             </div>
                                         </div>
									</div>
									
									<div class="row m-t-10">
										<div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">Date</label>
                                                 
                                                 <div class="col-md-3">
                                                 	<div class="dateHolder">
                                                 		<input type="text" class="form-control calDate" name="signDate" id="signDate" placeholder="DD/MM/YYYY" />
                                                 	</div>
                                                 </div>
                                             </div>
                                         </div>
                                       <!--   <div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">Signature of Individual</label>
                                                 
                                                 <div class="col-md-3">
                                               		<input type="text" class="form-control" name="signatureIndividual" id="signatureIndividual" />
                                                 </div>
                                             </div>
                                         </div> -->
									</div>
									
									<div class="row m-t-10">
										<div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3"></label>
                                                 
                                                 <div class="col-md-3">
                                               		Name
                                                 </div>
                                                 <div class="col-md-3">
                                               		Rank
                                                 </div>
                                             </div>
                                         </div>                                         
									</div>
									<div class="row m-t-10">
										<div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">Member 1</label>
                                                 
                                                 <div class="col-md-3">
                                               		<input type="text" class="form-control" name="member1Name" id="member1Name" maxlength="50"/>
                                                 </div>
                                                 <div class="col-md-3">
                                               		<input type="text" class="form-control" name="mem1Rank" id="mem1Rank" maxlength="50"/>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">Member 2</label>
                                                 
                                                 <div class="col-md-3">
                                               		<input type="text" class="form-control" name="member2Name" id="member2Name" maxlength="50"/>
                                                 </div>
                                                 <div class="col-md-3">
                                               		<input type="text" class="form-control" name="mem2Rank" id="mem2Rank" maxlength="50"/>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">President</label>
                                                 
                                                 <div class="col-md-3">
                                               		<input type="text" class="form-control" name="member3Name" id="member3Name" maxlength="50"/>
                                                 </div>
                                                 <div class="col-md-3">
                                               		<input type="text" class="form-control" name="mem3Rank" id="mem3Rank" maxlength="50"/>
                                                 </div>
                                             </div>
                                         </div>
                                         
                                         
                                        <div class="row col-12">
										<div class="col-12">
										<h6 class="text-theme text-underline font-weight-bold">Approving Authority</h6>
										</div>
										
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Name</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="aaName" name="aaName" maxlength="50"/>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Rank &amp; Designation</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="aaRank" name="aaRank" maxlength="50"/>
												</div>
											</div>
										</div>
										<div class="w-100"></div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Place</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="aaPlace" name="aaPlace" maxlength="50"/>
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
													<input type="text" class="form-control calDate" id="aaDate" name="aaDate" placeholder="DD/MM/YYYY" />
													</div>
												</div>
											</div>
										</div>
										
									</div>
									
									<div class="row col-12">
										<div class="col-12">
										<h6 class="text-theme text-underline font-weight-bold">Perusing Authority</h6>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Name</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="paName" name="paName" maxlength="50"/>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Rank &amp; Designation</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="paRank" name="paRank" maxlength="50"/>
												</div>
											</div>
										</div>
										<div class="w-100"></div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Place</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="paPlace" name="paPlace" maxlength="50"/>
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
													<input type="text" class="form-control calDate" id="paDate" name="paDate" placeholder="DD/MM/YYYY" />
													</div>
												</div>
											</div>
										</div>
										
									</div>
                                         
											<div class="col-12">
												<h6 class="text-theme text-underline font-weight-bold">Medical Board File Upload<span class="mandate">(File name should not contain any special characters and should be jpg,pdf,jpeg,gif,png,mp4 only!)</span></h6>
											</div>

											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-5 col-form-label">Upload File</label>
													<div class="col-md-7" id="uploadFileMedicalExam">
														<div class="fileUploadDiv">
														<input type="file" name="medicalBoardFileUpload"
															id="medicalBoardFileUpload" class="inputUpload" />
															<label class="inputUploadlabel">Choose File</label>
															<span class="inputUploadFileName">No File Chosen</span>
														</div>
													</div>
													
												</div>
											</div>
											<div class="col-md-3">														
									<div style="display: none" class="col-md-7" id="viewUploadedFile"></div>
									</div>	
										</div>
									<div class="row m-t-10">
														<div class="col-12">
														<h6 class="text-theme text-underline font-weight-bold">Medical Board (Supporting Document)</h6>
														</div>
														
														<div class="col-12">
															<table class="table table-hover table-striped table-bordered">
																<thead>
																	<tr>
																		<th>Document Type</th>
																		<th>View/Enter Result</th>
																		<th>Upload File<span class="mandate">(File name should not contain any special characters and should be jpg,pdf,jpeg,gif,png,mp4 only!)</span></th>
																		<th>Add</th>
																		<th>Delete</th>
																	</tr>
																</thead>
																
																<tbody id="medicalBoardDocs">
																	<tr>
																		<td class="width200">
																			<select class="form-control" id="docId" name="docId">
																				       <option value="0">Select Doc</option>
																						
																			</select>
																			<input type="hidden" name="patientDocumentId" name="patientDocumentId" value=""/>
																			
																		</td>																		
																		<td class="width200">
																		    <textarea name="medicalDocs" id="medicalDocs" class="form-control" id="medicalDocumentsDetails" style="visibility:hidden; height:0px; margin:0;padding:0;"></textarea>
																			<a class="btn-link" href="Javascript:Void(0)" onclick="openResultModelMedicalDocs(this);" data-toggle="modal" data-target="fileUploadModalMb" >View/Enter Result</a>
																		</td>
																		<td>																		
																			<div class="fileUploadDiv">
																				<input type="file" name="medicalBoardDocsUpload" value="" id="medicalBoardDocsUpload" class="inputUpload">
																				<label class="inputUploadlabel">Choose File</label>
																				<span class="inputUploadFileName">No File Chosen</span>
																			</div>
																		</td>
																		<td>
                                                                            <button type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowMBDocs()"></button>
                                                                        </td>
                                                                         <td>
                                                                               <button type="button" class="btn btn-danger buttonAdd noMinWidth"  name="deleteForSupportDocNew" value=""    id="deleteForSupportDocNew"  button-type="delete" tabindex="1" onclick="deleteInvestAndReferalValueRow(this,15,'')"></button>
                                                                        </td>
																	</tr>
																</tbody>
															</table>
														</div>
													</div>
									<div class="row" id="reasonPending" style="display:none;">
												<div class="col-md-12">
													<div class="form-group row">
														<div class="col-md-3">
															<label for="service" class="col-form-label">Reason for Pending</label>
														</div>
														<div class="col-md-6">
															<textarea class="form-control" id="pendingRemarks" name="remarksPending" maxlength="500" rows="2" readonly></textarea>
														</div>
													</div>
												</div>
									</div>
									
									
									
									
									<div class="row m-t-20">
										<div class="col-12 text-right">
											
											<!-- <input type="button" id="saveAsDraft" class="btn btn-primary" onclick="return submitMAForm('draftMa');"
															value="Save"/> -->
											<input type="button" value="Employability Restrictions CheckList" tabindex="1" class="btn btn-primary"
																data-toggle="modal" data-target="#exampleModal" data-backdrop="static"
															onclick="checkListOpen();">			
											<input type="button" id="clicked" class="btn btn-primary"
															value="Submit"/>				
											<!-- <input type="button" id="reset" class="btn btn-danger" onclick=""
															value="Reset"/>	 -->	
										 
										</div>
									</div>
									
								
									
								</div>
								
 								
								</div>
							</div>
						</div>
					 
					</div>

				</div>
				<!-- container -->

			</div>
			<!-- content -->
			
			<div class="modal " id="messageDelete"  role="dialog" >
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message code="lblIndianCoastGuard" /></span>

					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div class="modal-body">
					<div class="control-group">
						<div class="">
							<p class="message_text">Please add first another
								Investigation.</p>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" data-dismiss="modal"
						onClick="closeDelete();" aria-hidden="true">Close</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	<div class="modal" id="exampleModal" tabindex="-1" role="dialog"aria-labelledby="exampleModalLabel" aria-hidden="true" >
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
</form:form>		
		</div>
<div class="modal" id="fileUploadModalMb" role="dialog">
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
						<div class='divErrorMsg form-group row' id='errordiv'></div>
						<div class="form-group row" id="messageForAuthenticateMessaeKK"></div>

						<div class="row">
								 
								

								<div class="col-12">
									<div class="form-group row">
										<label class="col-md-5 col-form-label">Medical Board Documents</label>
										<div class="col-12">
										
										<div id="editorOfUploadMb"></div>
										
										</div>
									</div>
								</div>

						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary"
						onClick="saveMedicalBoardInTextMb();"  aria-hidden="true">
						<spring:message code="btnOK" />
					</button>
					<button class="btn btn-primary" onclick="closeMessage();" data-dismiss="modal"
						aria-hidden="true">
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

					<button type="button" onClick="closeSubModalNew();" class="close"
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
												placeholder="" id="resultNumberTemp" value="" name="resultNumberTemp" onblur="return setResultNumber(this);" readonly>
										</div>
									</div>
								</div>	
											

								<div class="col-12">
									<div class="form-group row">
										<label class="col-md-5 col-form-label">Result </label>
										<div class="col-12">
										
										<div id="editorOfResult" ></div>
										
										</div>
									</div>
								</div>

						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" 
						onClick="saveResultInTextMB();" aria-hidden="true">
						<spring:message code="btnOK" />
					</button>
					<button class="btn btn-primary" data-dismiss="modal"
						onClick="closeSubModalNew();" aria-hidden="true">
						<spring:message code="btnClsoe" />
					</button>
				</div>
			</div>
		</div>
	</div>

<div class="modal" id="messageForResultSpeccilaistNew" role="dialog">
		<div class="modal-dialog  modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message
							code="lblIndianCoastGuard" /></span>

					<button type="button" onClick="closeSubModalNew();" class="close"
						 aria-label="Close">
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
										
										<div id="editorOfSpecialistOpinionNew"></div>
										
										</div>
									</div>
								</div>

						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary"
						onClick="saveSpecialistOpinionInTextNew();" aria-hidden="true">
						<spring:message code="btnOK" />
					</button>
					<button class="btn btn-primary" onClick="closeSubModalNew();"
						aria-hidden="true">
						<spring:message code="btnClsoe" />
					</button>
				</div>
			</div>
		</div>
	</div>
	
<!-- <div class="modal-backdrop show" style="display: none;"></div>	  -->
		<!-- ============================================================== -->
		<!-- End Right content here -->
		<!-- ============================================================== -->

	<!-- END wrapper -->
	
<script>
$(function(){
	
	$("#editorOfUploadMb").jqte();
	
})
</script>	
<script>
$(document).ready(function() {
    /* if (typeof element !== "undefined" && element.value == '') {
    } */
    
    $j('#exampleModal').on('hidden.bs.modal', function (event) {
        var loaderHtml ='<div class="text-center text-theme text-sm">Loading <i class="fa fa-spin fa-spinner"></i> </div>';
    	$j('#exampleModal .modal-body').html(loaderHtml);
    });
    
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
    if (data.data[0].patientName != null) {
        document.getElementById('empName').value = data.data[0].patientName;
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
   /*  if (data.data[0].totalService != null) {
        document.getElementById('totalService').value = data.data[0].totalService;
    } */
    if (data.data[0].unit != null) {
        document.getElementById('unit').value = data.data[0].unit;
    }
    if (data.data[0].dob != null) {
        document.getElementById('dob').value = data.data[0].dob;
    }
    if (data.data[0].tradeBranch != null) {
        document.getElementById('branchTrade').value = data.data[0].tradeBranch;
    }
    if (data.data[0].gender != null) {
        document.getElementById('gender').value = data.data[0].gender;
    }
    if (data.data[0].medicalCategogyName != null && data.data[0].fitFlag != "F") {
        document.getElementById('medicalCompositeName').value = data.data[0].medicalCategogyName;
    }
    if (data.data[0].medicalCategogyDate != null && data.data[0].fitFlag != "F") {
        document.getElementById('medicalCompositeDate').value = data.data[0].medicalCategogyDate;
    } 
    if(data.data[0].visitStatusV =='R')
    {
    	$('#reasonPending').show();	
    }	
    if(data.data[0].masEmployeeCategory=="OFFICERS")
    {
      $('#doc').show();
      $('#doe').hide();
    }
    else
    {
    	 $('#doc').hide();
         $('#doe').show();
    }
    if (data.data[0].serviceJoinDate != null) {
        document.getElementById('doe_doc').value = data.data[0].serviceJoinDate;
    }
    if (data.data[0].totalService != null) {
        document.getElementById('service').value = "COAST GUARD";
    }
    
    masMedicalCategoryList();
    //getMBPreAssesDetailsInvestigationData();
    getMbAMSF15DetailsforValidate();
    getDocumentListMb();
    getMedicalCategoryListDropDown();
    
});
   
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
	
	function checkListOpen()
    {
		 var Id= $('#visitId').val();
		//window.location.href ="mbCheckListAMSFForm15?visitId="+Id+"";
		 $('#exampleModal .modal-body').load("mbCheckListAMSFForm15?visitId="+Id+"");
         $('#exampleModal .modal-title').text('Employability Restrictions');
	}
	function getSpecialistOpinionOpen()
    {
		 var Id= $('#visitId').val();
		//window.location.href ="mbCheckListAMSFForm15?visitId="+Id+"";
		 $('#exampleModal .modal-body').load("mbGetSpecialistOpinionDetails?visitId="+Id+"");
         $('#exampleModal .modal-title').text('Specialist Doctor for Opinion and Medical Board');
	}
	
	 $('#clicked').click(function() {

		////////////////Document Upload File Extension Validation/////////////////
		 var count=0;
		 $('#medicalBoardDocs tr').each(function(ij, el) {
			  
		 		var fileNameValueIDd= $(this).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id"); 
		 			
		 		var fileNameValue=$('#'+fileNameValueIDd).val();
		 		if(fileNameValue!="" && fileNameValue!=undefined)
				var filenameWithExtension=getFilenameAndReplcePath(fileNameValue);
				if(filenameWithExtension!="" && filenameWithExtension!=null && validateFileExtension(filenameWithExtension, "valid_msg", "Only pdf/images/mp4 files are allowed ",
					      new Array("jpg","pdf","jpeg","gif","png","PNG","JPEG","JPG","GIF","mp4","MP4")) == false)
					      {
							count++;
					 		return false;
					      }
		 	
				});
		 
		       var medicalBoardDocs=document.getElementById('medicalBoardFileUpload').value;
		       var filenameWithExtensionMbDocument=getFilenameAndReplcePath(medicalBoardDocs);
		       if(filenameWithExtensionMbDocument!="" && filenameWithExtensionMbDocument!=null && validateFileExtension(filenameWithExtensionMbDocument, "valid_msg", "Only pdf/image/mp4 files are allowed ",
					      new Array("jpg","pdf","jpeg","gif","png","PNG","JPEG","JPG","GIF","mp4","MP4")) == false)
					      {
							count++;
					 		return false;
					      }
		 	 
		 	if(count>0){
		 		alert("Please upload valid file.");
		 	}
		 
		 var formMbDate=document.getElementById('signDate').value;
		 if(formMbDate=="")
		 {
			 alert("Please enter the date of medical board");
			 document.getElementById('signDate').focus();
			 return false;	
		 }	 
         var pathname = window.location.pathname;
         var accessGroup = "MMUWeb";

         var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/saveAmsfForm15Details";
         
        
         
         /////////////////////// Medical Cateogry validation part ////////////////////////////
 		 
      	var  idformedicalCategory1='';
      	$('#medicalCategoryNew tr').each(function(i, el) {
      		idformedicalCategory1= $(this).find("td:eq(1)").find("input:eq(0)").attr("id"); 
	 			var $tds = $(this).find('td')
 	    		var medicalSystem = $tds.eq(2).find(":input").val();
 	   			var medicalCategory = $tds.eq(3).find(":input").val();
 	  			var typeCategory = $tds.eq(4).find(":input").val();
 	  			var categoryDate = $tds.eq(6).find(":input").val();
 	  		    var duration = $tds.eq(5).find(":input").val();
 	  		    var nextCategoryDate = $tds.eq(7).find(":input").val();
 	  		    var diagnosisVal = $tds.eq(8).find(":input").val();
 	  		    var patientFitFlag=$tds.eq(14).find(":input").val();   
 	  		    
	    		if(diagnosisVal!= '' && diagnosisVal!= null)
			    {
	 			if(medicalSystem== "")
	   			 {
   				alert("Please Enter System under Medical Category");
   				medicalSystem.focus();
   				return false;	    	
				  }
 			if(medicalCategory== "")
    			{
					alert("Please select medical Category");
					medicalCategory.focus();
					return false;      	
				 }
 			if(typeCategory== "" && patientFitFlag!='F')
	   			{
 				alert("Please select Category Type under Medical Category");
 				typeCategory.focus();
					return false;       	
				}
				if(categoryDate== "")
	    		{
 				alert("Please Select Date of Category under Medical Category");
 				frequency.focus();
					return false;       	
				}
				if((duration== "" || duration==0) && patientFitFlag!='F')
	    		{
 				alert("Duration should be greater than 0 under Medical Category");
 				totalNip.focus(); 
				    return false;       	
				}
 
			    }
	 			
	 			
  		 });
      	 var tableDataMedicalCategory1 = [];
      	var listOfOrigin = [];
     	var dataOrigin='';
     	var placeOfOrigin='';
      	 ///////////////////////////////////////Place Of Origin /////////////////////////////////////////
 	   $('#medicalCategoryOrigin tr').each(function(i, el) {
 		  var $tds = $(this).find('td')
 		   var dateOfOrigin = $tds.eq(1).find(":input").val();
 		  	var placeOfOrigin = $tds.eq(2).find(":input").val();
 		  	var patientCategoryId = $tds.eq(4).find(":input").val();
 		  	if(dateOfOrigin=="")
 		  	{
 		  		alert("please enter date of origin");
 		  		dateOfOrigin.focus();
 		  		return false;
 		  	}
 		  	if(placeOfOrigin=="")
 		  	{
 		  		alert("please enter place of origin");
 		  		placeOfOrigin.focus();
 		  		return false;
 		  	}
 		  	dataOrigin={
 					'dateOfOrigin' : dateOfOrigin,
 					'placeOfOrigin' : placeOfOrigin,
 					}
 		  	placeOfOrigin={
 					'dateOfOrigin' : dateOfOrigin,
 					'placeOfOrigin' : placeOfOrigin,
 					'patientCategoryId':patientCategoryId,
 		  	}
 			tableDataMedicalCategory1.push(dataOrigin)
 			listOfOrigin.push(placeOfOrigin)
 				   
 	   });  
      ////////////////////////////////////Medical Categories Screen JSON/////////////////////////
	      
	    	var idforMedicalCategory255='';
	    	var tableDataMedicalCategory2 = [];
	    $('#medicalCategoryNew tr').each(function(i, el) {
	    	idforMedicalCategory255= $(this).find("td:eq(1)").find("textarea:eq(0)").attr("id");
	    	
	    if(idforMedicalCategory255!= "" && idforMedicalCategory255!= undefined)
	    {
		var $tds = $(this).find('td')
		/* var mCheck='';
		if ($tds.eq(0).find(":input").is(":checked")) 
		{
				var yMcheck='Y';
				mCheck=yMcheck;
		}
		else
		{
	      		var nMcheck='N';
	      		mCheck=nMcheck;
		 } */
		var diagnosisId = $tds.eq(8).find(":input").val();
	  	var system = $tds.eq(3).find(":input").val();
		var medicalCategory = $tds.eq(2).find(":input").val();
		//var splitMedicalCategory=medicalCategory.split("@");
		//var medicalCategory=splitMedicalCategory[0]
		if(medicalCategory==undefined)
		{
			medicalCategory='';
		}	
		var categoryType = $tds.eq(4).find(":input").val();
		var duration = $tds.eq(5).find(":input").val();
		var categoryDate = $tds.eq(6).find(":input").val();
		var nextCategoryDate = $tds.eq(7).find(":input").val();
		var patientCategoryId=$tds.eq(10).find(":input").val();
		var patientCategoryFId=$tds.eq(13).find(":input").val();
		var patientFitFlag=$tds.eq(14).find(":input").val();
		var dateOfOriginNew=$tds.eq(15).find(":input").val();
		var placeOfOriginNew=$tds.eq(16).find(":input").val();
		dataMedicalCategory={
				'diagnosisId' : diagnosisId,
				'system' : system,
				//'medicalCatCheck' : mCheck,
				'medicalCategory' : medicalCategory,
				'categoryType' : categoryType,
				'duration' : duration,
				'categoryDate' : categoryDate,
				'nextCategoryDate' : nextCategoryDate,
				'patientCategoryId' :patientCategoryId,
				'patientCategoryFId' :patientCategoryFId,
				'patientFitFlag':patientFitFlag,
				'dateOfOrigin' :dateOfOriginNew,
				'placeOfOrigin':placeOfOriginNew,
			}
		tableDataMedicalCategory2.push(dataMedicalCategory)
	    }
	});
	    var tableDataMedicalCategory = []; 
	    for(var m =0;m<tableDataMedicalCategory2.length;m++){
	    	//	var jsonObject = tableDataMedicalCategory1[m].concat(tableDataMedicalCategory2[m]);
	    	$.extend(tableDataMedicalCategory1[m],tableDataMedicalCategory2[m]);
	    	tableDataMedicalCategory.push(tableDataMedicalCategory1[m])
	    }
	    
     ///////////////////////////////Diagnosis Value and Name for opd patientDetais and DischargeICD /////////////////
        var idforMasDiagnosisi='';
    	var tableDiagnosisData = [];
    	var arryDiagnisisName=[];
    	var dataDiagnosis='';
    	$('#medicalCategoryNew tr').each(function(i, el) {
    		idforMasDiagnosisi= $(this).find("td:eq(1)").find("textarea:eq(0)").attr("id")
		if(document.getElementById(idforMasDiagnosisi).value!= "" && document.getElementById(idforMasDiagnosisi).value!= undefined)
	    {
			var $tds = $(this).find('td')
			var diagnosisId = $tds.eq(8).find(":input").val();
			var diagnosisName=$tds.eq(1).find(":input").val();
			dataDiagnosis={
					'diagnosisId' : diagnosisId,
					'diagnosisName' : diagnosisName,
						}
			tableDiagnosisData.push(dataDiagnosis)
			arryDiagnisisName.push(diagnosisName)
			
	    }	
    	});
	    
		////////////////////////////////////Document Info JSON/////////////////////////
			    
				var idformedicalBoardDocs='';
				var tablemedicalBoardDocs = [];
				var datamedicalBoardDocs='';
			$('#medicalBoardDocs tr').each(function(i, el) {
				idformedicalBoardDocs= $(this).find("td:eq(1)").find("textarea:eq(0)").attr("id")
			if(document.getElementById(idformedicalBoardDocs).value!= "" && document.getElementById(idformedicalBoardDocs).value!= undefined)
			{
			var $tds = $(this).find('td')	
			var documentId = $tds.eq(0).find(":input").val();
			var patientDocsId = $tds.eq(2).find(":input").val();
			var documentRemarks = $tds.eq(1).find(":input").val();
			var splitDocumentId=documentId.split("@");
			datamedicalBoardDocs={
					'documentId' : splitDocumentId[0],
					'documentRemarks' : documentRemarks,
					'meidcalDocsId':patientDocsId,
								
				}
			tablemedicalBoardDocs.push(datamedicalBoardDocs)
			
			}	
			});
         
	  
         var dataJSON = {

        		 'visitId': $('#visitId').val(),
                 'patientId': $('#patientId').val(),
                 'authorityforBoard':$('#authority').val(),
                 'place':$('#place').val(),
                 'height':$('#height').val(),
                 'weight':$('#weight').val(),
                 'addressOnLeave':$('#address_on_leave').val(),
                 'dateOfEnrollment':$('#doe_doc').val(),
                 'ceasedDutyOn':$('#ceased').val(),
                 'recordOfficeAddress':$('#reccord_office').val(),
                 'disablityAttrServiceRemark': $('#disablityAttrServiceRemark').val(),
                 'directlyAttrServiceRemark': $('#directlyAttrServiceRemark').val(),
                 'previousDisablement': $('#previousDisablement').val(),
                 'presentDisablement' :$('#presentDisablement').val(),
                 'reasonForVarious': $('#reasonForVarious').val(),
                 'restrictionRegardingEmp': $('#restrictionRegardingEmp').val(),
                 'instructionRemark': $('#instructionRemark').val(),
                 'instructionNote': $('#instructionNote').val(),
                 'signDate': $('#signDate').val(),
                 'member1Name': $('#member1Name').val(),
                 'member2Name': $('#member2Name').val(),
                 'member3Name': $('#member3Name').val(),
                 'mem1Rank': $('#mem1Rank').val(),
                 'mem2Rank': $('#mem2Rank').val(),
                 'mem3Rank': $('#mem3Rank').val(),
                 'aaName': $('#aaName').val(),
                 'aaRank': $('#aaRank').val(),
                 'aaPlace': $('#aaPlace').val(),
                 'aaDate': $('#aaDate').val(),
                 'paName': $('#paName').val(),
                 'paRank': $('#paRank').val(),
                 'paPlace': $('#paPlace').val(),
                 'paDate': $('#paDate').val(),
                 "listOfMedicalCategory":tableDataMedicalCategory2,
                 //"listOfMedicalCategory":tableDataMedicalCategory,
                 "listOfOrigin":listOfOrigin,
                 'hospitalId':<%=hospitalId%>,
   			 	 'userId':<%= userId %>,
   			 	 'actionMe' : '',
  			 	 'forwardTo' : '',
  			 	 'designationForMe' : '',
  			 	 'pendingRemarks' : '',
  			 	 'medicalCompositeName':$('#medicalCompositVal').val(),
      			 'categoryCompositeDate':$('#medicalCompositeDate').val(),
      			 'uploadOthersDocument':tablemedicalBoardDocs,
      			 'recommedicalCompositeName':$('#recommedicalCompositVal').val(),
	      		 'recomcategoryCompositeDate':$('#recommedicalCompositeDate').val(),
	      		 'recommedicalCompositeNamePId':$('#recommedicalCompositeNamePId').val(),
	      		 'typeOfCommission':$('#typeOfCommission').val(),
	      		'diagnosisName':arryDiagnisisName,
	      		'diagnosisData':tableDiagnosisData,
            
         }
         
         var amsfFormData1 = $('#amsfForm15Data')[0];
       	 var formData = new FormData(amsfFormData1);
       	 var countFile=1;
       	
    		formData.append('uploadFilePath', "uploads");
    		formData.append('uploadRealPath', 1);
    		formData.append('amsfForm15Data',JSON.stringify(dataJSON));
    		var dateCheck1=$('#signDate').val();
     	    var yyyy = dateCheck1.split("/")[2];
	    	formData.append('year',yyyy);
			formData.append('type',1);
			formData.append('serviceNo',$('#serviceNo').val());
			
         $("#clicked").attr("disabled", true);
         $.ajax({
        	 type: 'POST',
  		     url : url,
             enctype: 'multipart/form-data',
             data: formData,
             processData: false,
             contentType: false,
             cache: false,
             dataType : "json",
             timeout : 100000,
             success: function(msg) {
             	console.log(msg)
                 if (msg.status == 1)
                 {
                    var Id= $('#visitId').val()
                    window.location.href ="mbTranscriptionSubmit?visitId="+Id+"";
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
	 
	 function getMBPreAssesDetailsInvestigationData() {
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
						url : 'getRefferedOpinionDetails',
						data : JSON.stringify(data),
						dataType : "json",
						// cache: false,

						success : function(response) {
						$("#dgInvetigationGrid tr").remove();	
						var datas = response.listObject;	
						var trHTML = '';
						var i=0;
						console.log(datas);
						$.each(datas, function(i, item) {
							   
							    var investigationName=item.investigationName;
							    var result=item.result;
								
								if(investigationName!=null && investigationName!=undefined)
								{
								trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationName+'" id="chargeCodeName" autocomplete="_off" class="form-control border-input" name="chargeCodeName"  size="44" onblur="populateChargeCode(this.value,1,this);" /> <input type="hidden" id="qty" tabindex="1" name="qty1" size="10" maxlength="6" validate="Qty,num,no" /> <input type="hidden" tabindex="1" id="chargeCodeCode" name="chargeCodeCode" size="10" readonly /></div></td><td><div class="form-group row"><div class="col-md-7"><input type="text" class="form-control" value="'+result+'" id="result"></div><div class="col-md-5"><div class="view_result"><a href="#">View Result</a></div></div></div></td></tr>';	
								//trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationValue+''+'['+investigationId+']'+'" id="chargeCodeName1'+i+'" class="form-control border-input" name="chargeCodeName1" onblur="populateChargeCode(this.value,1,this);" /> </div></td><td><div class="dateHolder"> <input type="text" id="investigationDate1Temp'+i+'" name="investigationDatess" class="input_date form-control" placeholder="DD/MM/YYYY" value='+today+' maxlength="10" /></div></td><td><input type="checkbox" name="urgent" id="otherAfLabCheck" tabindex="1" class="radioAuto" value="I" checked/></td><td><input type="checkbox" name="urgent" id="uCheck" tabindex="1" class="radioAuto" value="1" /><td style="display:none";><input type="hidden" value="'+investigationId+'" tabindex="1" id="inestigationIdval2'+i+'" size="77" name="inestigationIdval" /></td> </td><td><button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForInvestigation();"></button></td><td><button type="button" name="delete" value="" class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" onclick="removeRowInvestigation(this)"></button></td></tr>';
								i++;
								}
								
												
				});
						$('#dgInvetigationGrid').append(trHTML);
					}
		    });
		 }
	 var mbFlag = 0;
	 placeOfOriginFlag=0;
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
						var trHTMLNew = '';
						var trHTMLOrigin = '';
						var appnedOrigin='';
						var i=0;
						var min=100;
						var selectedCount='';
						var totalCount='';
						var sNo=1;
						console.log(datas);
						$.each(datas, function(i, item) {
							   
							var investigationName=item.inveName;
							var icdName=item.icdName;
							var diagnosisId=item.diagnosisId;
							var system=item.system;
							var medicalCategory=item.medicalCategory;
							var medicalCategoryId=item.medicalCategoryId;
							var categoryType='';
							var	categoryTypeVal=item.categoryType;
							var mbStatus=item.mbStatus;
							var patientMedicalCategoryId=item.patientMedicalCategoryId;
							var dateOfOrigin='';
							var placeOfOrigin='';
							if(item.dateOfOrigin!=undefined)
							{	
							    dateOfOrigin=item.dateOfOrigin;
							}
							if(item.placeOfOrigin!=undefined)
							{	
							  placeOfOrigin=item.placeOfOrigin;
							}
							var recommendStatus=item.recommendStatus;
							var fitFlag=item.fitFlag;
							var fitCatId=item.fitCatId;
							var medicalCategoryFit=item.medicalCategoryFit;
							var fitCatDate=item.fitCatDate;
							if(mbStatus == 'A' ||mbStatus == 'C'){
								mbFlag ++;
							}
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
							var checkValue = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1" disabled="true"><span class="cus-checkbtn"></span> ';
							var tr='<tr><td><div class="form-check form-check-inline cusCheck">';
							
							var checkValue1 = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1" disabled="true"><span class="cus-checkbtn"></span> ';
							var tr1='<tr><td><div class="form-check form-check-inline cusCheck">';
							if(selectCheck=='Y')
							{
								 checkValue1 = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1" checked disabled="true"><span class="cus-checkbtn"></span> ';
								 tr1='<tr style="background-color: #84e08f"><td><div class="form-check form-check-inline cusCheck">';
																 
							}
							if(fitCatId!=undefined && recommendStatus == 'Y' && fitFlag==undefined){
								 document.getElementById('recommedicalCompositeName').value = medicalCategoryFit;
							     document.getElementById('recommedicalCompositVal').value = fitCatId;
							     document.getElementById('recommedicalCompositeDate').value = fitCatDate;
							     document.getElementById('recommedicalCompositeNamePId').value = patientMedicalCategoryId;
							}
							if(selectCheck=='Y')
							{
								
								if(mbStatus!='A' && mbFlag == 0)
								{
									 func1='fillDiagnosisComboRecomm';
						    		 url1='opd';
						    		 url2='getIcdListByName';
						    		 flaga='diagnosisMe';
						    		 
									 trHTMLNew+='<tr>';
									 trHTMLNew+='<td><div class="form-check form-check-inline cusCheck"><input class="form-check-input" type="checkbox" id="fitInChk'+i+'" onclick="return masMedicalCategoryforFitCat(this);" value="option1'+i+'"/><span class="cus-checkbtn"></span></div></td>';
									// trHTMLNew+='<td><div class="autocomplete forTableResp"><textarea class="form-control" id="diagnosisId" value=" " onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" onblur="fillDiagnosisCombo(this.value,this);" placeholder="Diagnosis">'+icdName+'</textarea></div></td>';
									 trHTMLNew+='<td><div class="autocomplete forTableResp"><textarea class="form-control" value="'+icdName+'" id="diagnosisIdNew'+i+'" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" placeholder="Diagnosis">'+icdName+'</textarea><div id="diagnosisMeDiv" class="autocomplete-itemsNew"></div></div></td>';
									 trHTMLNew+='<td><select name="medicalCategoryIdNewchecked" id="medicalCategoryIdNewchecked'+i+'" class="form-control" tabindex="36"><option value="">Select</option>'+medicalCategoryListValue+'</select></td>';
									 //trHTMLNew+='<td><div class="autocomplete forTableResp "><input type="text" id="medicalCategoryIdNew'+i+'" onblur="fillMedicalCategoryDataNewCheckkkkk(this.value,this)" class="form-control width120"> </div>  </td>';
									 trHTMLNew+='<td><select class="form-control" name=system id="system" ><option value="0">Select</option><option value="S">S</option><option value="H">H</option><option value="A">A</option><option value="P">P</option><option value="E">E</option></select></td>';
									 trHTMLNew+='<td><select class="form-control width120" name="typeOfCategory'+i+'" id="typeOfCategory'+i+'" onChange="getdurationByType(this);"><option value="0">Select</option><option value="T">Temporary(Week)</option><option value="P">Permanent(Month)</option></select></td>';
									 trHTMLNew+='<td><input type="text" name="durationss" id="durationssssss'+i+'" onblur="return generateNextDateNew(this);" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control"></td>';
									 trHTMLNew+='<td><div class="dateHolder width100"><input type="text" id="diagnosisDatessss'+i+'" name="diagnosisDatesssss" class="noFuture_date501 form-control" placeholder="DD/MM/YYYY" value="" maxlength="10" /></div></td>';
									 trHTMLNew+='<td><div class="dateHolder width100"><input type="text" id="nextDiagnosisDatessss'+diagnosisId+'" name="nextDiagnosisDatess" class="input_date form-control " placeholder="DD/MM/YYYY" value="" maxlength="10" /></div></td>';
									 trHTMLNew+='<td style="display: none";><input type="hidden" value="'+diagnosisId+'" tabindex="1" id="diagnosisIdval'+i+'" size="77" name="diagnosisIdval" /></td>';
									 trHTMLNew+='<td style="display: none";><input type="hidden" value="" tabindex="1" id="medicalCategoryIdval'+i+'" size="77"name="medicalCategoryIdval" /></td>';
									 trHTMLNew+='<td style="display: none";><input type="hidden" value="" tabindex="1" id="patientCategoryId'+i+'" size="77"name="patientCategoryId" /></td>';
									 trHTMLNew+='<td><button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForMedicalCategoryNewDiagnosis();"></button></td>';
									 trHTMLNew+='<td><button type="button" name="delete" value=""  class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"  onclick="removeRowMedicalCategoryNew(this)" disabled></button></td>';
									 trHTMLNew+='<td style="display: none";><input type="hidden" value="'+patientMedicalCategoryId+'" tabindex="1" id="patientCategoryFId'+i+'" size="77"name=" patientCategoryFId" /></td>';
									 trHTMLNew+='<td style="display: none";><input type="hidden" value="" tabindex="1" id="fitFlag'+i+'" size="77" name="fitFlag" /></td>';
									 trHTMLNew+='<td style="display: none";><input type="hidden" value="'+dateOfOrigin+'" tabindex="1" id="dateOfOrigin'+i+'" size="77" name=" dateOfOrigin" /></td>';
									 trHTMLNew+='<td style="display: none";><input type="hidden" value="'+placeOfOrigin+'" tabindex="1" id="placeOfOrigin'+i+'" size="77" name="placeOfOrigin" /></td>';
									 trHTMLNew+='</tr>';
									
								}
							/* 	else if(mbStatus=='A')
								{
									 func1='fillDiagnosisComboRecomm';
						    		 url1='opd';
						    		 url2='getIcdListByName';
						    		 flaga='diagnosisMe';
									 var systemArrary = ["S","H","A","P","E"];  
									 var tr2='<tr style="background-color: #84b6e0"><td><div class="form-check form-check-inline cusCheck">';
									 var appnedNew='';
									 appnedNew+=tr2+checkValue1+'</div></td><td><div class="autocomplete forTableResp"><textarea class="form-control" value="'+icdName+'" id="diagnosisIdNew'+min+'" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"  onblur="fillDiagnosisCombo(this.value,this);" placeholder="Diagnosis">'+icdName+'</textarea><div id="diagnosisMeDiv" class="autocomplete-itemsNew"></div></div></td>';
									 appnedNew+='<td><select name="medicalCategoryIdNewchecked" id="medicalCategoryIdNewchecked" class="form-control" tabindex="36" readonly>';
									 appnedNew+='<option value="0"><strong>Please select Category</strong></option>';
									 var selectCategory= "";
									 if(masmedicalCategoryList!=null && masmedicalCategoryList.length!=0)
										 for (var j = 0; j < masmedicalCategoryList.length; j++) {
											 if (medicalCategoryId == masmedicalCategoryList[j].medicalCategoryId) {
												 selectCategory = 'selected';
												} else {
													selectCategory = "";
												}
											 appnedNew += '<option ' + selectCategory + ' value="' +masmedicalCategoryList[j].medicalCategoryId + '@'
												+ masmedicalCategoryList[j].medicalCategoryCode + '" >' + masmedicalCategoryList[j].medicalCategoryName
												+ '</option>';
											}
									    appnedNew += '</select>';
									    appnedNew  += '</td>';
									  
								     appnedNew+='<td><input type="text" value="'+system+'" id="system'+min+'" class="form-control" /> </td>';
								     appnedNew+=' <td>';
									 appnedNew+='<select class="form-control" name=typeOfCategory id="typeOfCategory'+min+'" onchange="getdurationByType(this);">';
										
										appnedNew+='<option value="0">Select</option>';
										if(categoryType!=null || categoryType!=""){
											var cateValue;
											var catetypeVal;
											for(var k=0;k<2;k++){
											var selectValue=""
											if(categoryTypeVal=='T'){
												selectValue='selected';
												cateValue='Temporary(Week)';
												catetypeVal='T';
												categoryType='';
												
											}
											else if(categoryTypeVal=='P'){
												selectValue='selected';
												cateValue='Permanent(Month)';
												catetypeVal='P';
												categoryType='';
											}
											else{
												var count=0;
												if(cateValue=='Temporary(Week)' && count=='0'){
													cateValue='Permanent(Month)';
													catetypeVal='P';
													count++;
												} 
												if(cateValue=='Permanent(Month)' && count=='0'){
													cateValue='Temporary(Week)';
													catetypeVal='T';
													count++;
												}
												selectValue='';
											}
											appnedNew+='<option '+selectValue+' value='+catetypeVal+'>'+cateValue+'</option>';
										}
										}
										else{
											
											appnedNew+='<option value="T">Temporary(Week)</option>';
											appnedNew+='<option value="P">Permanent(Month)</option>';
										}	
										appnedNew+='</select>';
										appnedNew+='</td>';
								     
								     //<td><input type="text" value="'+categoryType+'" id="categoryType'+i+'" class="form-control"></td>';
									 appnedNew+='<td><input type="text" value="'+duration+'" id="duration'+min+'" class="form-control"> </td><td><div class="dateHolder"><input type="text" value="'+categoryDate+'" id="diagnosisDate'+min+'" name="diagnosisDatesssss" class="input_date form-control" placeholder="DD/MM/YYYY" maxlength="10" /></div></td>';
									 appnedNew+='<td><div class="dateHolder"><input type="text" value="'+nextCategoryDate+'" id="nextDiagnosisDate'+min+'" name="nextDiagnosisDatess" class="input_date form-control" placeholder="DD/MM/YYYY" maxlength="10" /></div></td>';
									 appnedNew+='<td style="display: none";><input type="hidden" value="'+diagnosisId+'" tabindex="1" id="diagnosisIdval'+min+'" size="77" name="diagnosisIdval" /></td>';
									 appnedNew+='<td style="display: none";><input type="hidden" tabindex="1" id="medicalCategoryIdval'+min+'" value="'+medicalCategoryId+'" size="77"name="medicalCategoryIdval" /></td><td style="display: none";><input type="hidden" tabindex="1" id="categoryIdval" size="77" value="'+patientMedicalCategoryId+'" name="categoryIdval" /></td>';
									 appnedNew+='<td style="display: none";><input type="hidden" tabindex="1" id="patientCategoryId'+min+'" value="" size="77"name="medicalCategoryIdval" /></td>';
									 appnedNew+='<td><button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForMedicalCategoryNew();"></button></td>';
									 appnedNew+='<td><button type="button" name="delete" value="'+patientMedicalCategoryId+'"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"  onclick="removeRowMedicalCategoryNew(this)"></button></td>';
									 appnedNew+='</tr>';
									 //$("#medicalCategoryNew tr").remove();
									 $('#medicalCategoryNew').append(appnedNew);
									 min++;
									 
									 
									 
								} */	
							}	
							
							if(icdName!=null && icdName!=undefined && mbStatus=='P' )
							{
							trHTML+=tr1+checkValue1+'</div></td><td><textarea class="form-control" value="'+icdName+'" id="diagnosisId'+i+'" onblur="fillDiagnosisCombo(this.value,this);" placeholder="Diagnosis" readonly>'+icdName+'</textarea></td><td><input type="text" value="'+medicalCategory+'" id="medicalCategory'+i+'" class="form-control" readonly></td><td><input type="text" value="'+system+'" id="system'+i+'" class="form-control" readonly /> </td><td><input type="text" value="'+categoryType+'" id="categoryType'+i+'" class="form-control" readonly> </td><td><input type="text" value="'+duration+'" id="duration'+i+'" class="form-control" readonly> </td><td><div class="dateHolder"><input type="text" value="'+categoryDate+'" id="diagnosisDate'+i+'" name="diagnosisDatesssss" class="input_date form-control" placeholder="DD/MM/YYYY" maxlength="10" readonly /></div></td><td><div class="dateHolder"><input type="text" value="'+nextCategoryDate+'" id="nextDiagnosisDate'+i+'" name="nextDiagnosisDatess" class="input_date form-control" placeholder="DD/MM/YYYY" maxlength="10" /></div></td><td style="display: none";><input type="hidden" value="" tabindex="1" id="diagnosisIdval" size="77" name="diagnosisIdval" readonly /></td></tr>';	
							//trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationValue+''+'['+investigationId+']'+'" id="chargeCodeName1'+i+'" class="form-control border-input" name="chargeCodeName1" onblur="populateChargeCode(this.value,1,this);" /> </div></td><td><div class="dateHolder"> <input type="text" id="investigationDate1Temp'+i+'" name="investigationDatess" class="input_date form-control" placeholder="DD/MM/YYYY" value='+today+' maxlength="10" /></div></td><td><input type="checkbox" name="urgent" id="otherAfLabCheck" tabindex="1" class="radioAuto" value="I" checked/></td><td><input type="checkbox" name="urgent" id="uCheck" tabindex="1" class="radioAuto" value="1" /><td style="display:none";><input type="hidden" value="'+investigationId+'" tabindex="1" id="inestigationIdval2'+i+'" size="77" name="inestigationIdval" /></td> </td><td><button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForInvestigation();"></button></td><td><button type="button" name="delete" value="" class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" onclick="removeRowInvestigation(this)"></button></td></tr>';
							        if(placeOfOrigin!="" && dateOfOrigin!="")
							        {	
							       	 appnedOrigin+='<tr>';
									 appnedOrigin+='<td><div class="autocomplete forTableResp"><textarea class="form-control" id="diagnosisId" value=" " onblur="fillDiagnosisCombo(this.value,this);" placeholder="Diagnosis" readonly>'+icdName+'</textarea></div></td>';
									 appnedOrigin+='<td ><div class="dateHolder width100"><input type="text" id="dateOfOrigin'+i+'" name="dateOfOrigin" class="noFuture_date501 form-control" placeholder="DD/MM/YYYY" value="'+dateOfOrigin+'" maxlength="10" readonly/></div></td>';
									 appnedOrigin+='<td><input type="text" value="'+placeOfOrigin+'" class="form-control" tabindex="1" id="placeOfOrigin'+i+'" name="placeOfOrigin" readonly/></td>';
									 appnedOrigin+='<td style="display: none";><input type="hidden" value="'+diagnosisId+'" tabindex="1" id="diagnosisIdval'+i+'" size="77" name="diagnosisIdval" /></td>';
									 appnedOrigin+='<td style="display: none";><input type="hidden" value="'+patientMedicalCategoryId+'" tabindex="1" id="patie'+i+'" size="77" name="patie" /></td>';
									 appnedOrigin+='</tr>';
									 placeOfOriginFlag++;
									
									}
							        else
							        {
							        	 trHTMLOrigin+='<tr>';
										 trHTMLOrigin+='<td><div class="autocomplete forTableResp"><textarea class="form-control" id="diagnosisId" value=" " onblur="fillDiagnosisCombo(this.value,this);" placeholder="Diagnosis">'+icdName+'</textarea></div></td>';
										 trHTMLOrigin+='<td><div class="dateHolder width100"><input type="text" id="dateOfOrigin'+i+'" name="dateOfOrigin" onChange="return getDateOfOrigin(this);" class="noFuture_date501 form-control" placeholder="DD/MM/YYYY" value="" maxlength="10" /></div></td>';
										 trHTMLOrigin+='<td ><input type="text" class="form-control" value="" tabindex="1" id="placeOfOrigin'+i+'" onblur="getPlaceOfOrigin(this);" name="placeOfOrigin" /></td>';
										 trHTMLOrigin+='<td style="display: none";><input type="hidden" value="'+diagnosisId+'" tabindex="1" id="diagnosisIdval'+i+'" size="77" name="diagnosisIdval" /></td>';
										 trHTMLOrigin+='<td style="display: none";><input type="hidden" value="'+patientMedicalCategoryId+'" tabindex="1" id="patie'+i+'" size="77" name="patie" /></td>';
										 trHTMLOrigin+='</tr>';
										
							        }	
							if(selectCheck=='Y')
							{
								 selectedCount+='Dis-'+sNo+':';
								 selectedCount+='\n';
								 selectedCount+='\n';
								 
							}
							else
							{
								selectedCount+='Dis-'+sNo+'-Not Due ';
								selectedCount+='\n';
								selectedCount+='\n';
							}	
							i++;
							sNo++;
							}
					   });
						 $('#medicalCategory').append(trHTML);
						 if(placeOfOriginFlag != 0)
                         {
						 $('#medicalCategoryOrigin').append(appnedOrigin);
                         }
						 else
						 {
							 $('#medicalCategoryOrigin').append(trHTMLOrigin); 
						 } 
						if($('#disablityAttrServiceRemark').val()=="")
						{
								
							$('#setDisablityAttrServiceRemark').append($('#disablityAttrServiceRemark').val(selectedCount));
								
						}	
						
						if($('#directlyAttrServiceRemark').val()=="")
						{
							$('#setDirectlyAttrServiceRemark').append($('#directlyAttrServiceRemark').val(selectedCount));
						}
						
                         if(mbFlag == 0)
                         {	 
                          $('#medicalCategoryNew').append(trHTMLNew);
						// var val = $('#medicalCategoryNew>tr').find("td:eq(2)").find(":input")[0];
						 //var valLast = $('#medicalCategoryNew>tr:last').find("td:eq(2)").find(":input")[0];
						 //oldautocomplete(val, MeidcalCategoryArry);
						 //oldautocomplete(valLast, MeidcalCategoryArry);
                         }
						
					}
		    });
			}
	      
	 function addRowForMedicalCategoryNewDiagnosis(){
			 
		 var tbl = document.getElementById('medicalCategoryNew');
	  	 lastRow = tbl.rows.length;
	  	 i =lastRow;
   	     i++;
       	    var aClone = $('#medicalCategoryNew>tr:last').clone(true);
       	    aClone.find('img.ui-datepicker-trigger').remove();
       		aClone.find(":input").val("");
       	    //aClone.find("td:eq(0)").find(":input").prop('id', 'inlineCheckbox1');
       	    aClone.find("td:eq(1)").find("textarea:eq(0)").prop('id','diagnosisIdNew' + i + '');
       	    aClone.find("td:eq(0)").find(":input").prop('checked', false);
       		aClone.find("td:eq(8)").find(":input").prop('id', 'diagnosisIdval'+i+'');
       		aClone.find("td:eq(3)").find("select:eq(0)").prop('id', 'system'+i+'');
       		aClone.find("td:eq(4)").find("select:eq(0)").prop('id', 'typeOfCategory'+i+'');
    		aClone.find("td:eq(5)").find("input:eq(0)").prop('id', 'duration'+i+'');
    	    aClone.find("td:eq(4)").find("select:eq(0)").find("option[selected]").removeAttr('selected');
    	   aClone.find("td:eq(3)").find("select:eq(0)").find("option[selected]").removeAttr('selected');
    	   aClone.find("td:eq(6)").find("input:eq(0)").prop('id', 'categoryDate'+i+'').removeClass('noFuture_date hasDatepicker').addClass('noFuture_date');
    	   aClone.find("td:eq(7)").find("input:eq(0)").prop('id', 'nextcategoryDate'+i+'').removeClass('noFuture_date hasDatepicker').addClass('noFuture_date');
    	   aClone.find("td:eq(1)").find("textarea:eq(0)").removeAttr('readonly');
    	   aClone.find('input[type="text"]').removeAttr('readonly');
    	   aClone.find("td:eq(2)").find("select:eq(0)").removeAttr('disabled');
    		aClone.find("td:eq(3)").find("select:eq(0)").removeAttr('disabled');
    		aClone.find("td:eq(4)").find("select:eq(0)").removeAttr('disabled');
    	   var	medicalCategoryAdd ='';
	    	medicalCategoryAdd +='<button type="button" name="delete" value="" id="deleteMC'+i+'"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" onclick="removeRowMedicalCategory(this);"></button>';
	    	aClone.find("td:eq(12)").html(medicalCategoryAdd);
    	   aClone.clone(true).appendTo('#medicalCategoryNew');
         }
	 
     function generateNextDate(item) {
    	 
      	  var carrentDateIdValue=$(item).closest('tr').find("td:eq(6)").find("input:eq(0)").val();
      	  var durationValue=$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").val();
      	  var nextCategoryDateId=$(item).closest('tr').find("td:eq(7)").find("input:eq(0)").attr("id");
      	 var fitValue=$(item).closest('tr').find("td:eq(14)").find("input:eq(0)").val();
        if(carrentDateIdValue==null || carrentDateIdValue==""){
      		  //alert("Please enter  current Date.");
      			return false;
      	  	}
      	var currentDateVal=carrentDateIdValue.split("/");
      	var date=currentDateVal[0];
      	var month=currentDateVal[1];
      	var year=currentDateVal[2];
      	if(durationValue==null || durationValue=="" && fitValue!="F"){
      		alert("Please enter  duration");
      		return false;
      	}
      	
      	 var typeOfCategoryValueId=$(item).closest('tr').find("td:eq(4)").find("select:eq(0)").attr("id");
      	 var typeOfCategoryValue=$("#"+typeOfCategoryValueId+" option:selected" ).val();
      	
      	 
      	 if(typeOfCategoryValue=="0" && fitValue!="F"){
      			alert("Please select  Type of Category.");
      			 var categoryDateForCheck=$(item).closest('tr').find("td:eq(6)").find("input:eq(0)").attr("id");
      			  $("#"+categoryDateForCheck).val('');
      			return false;
      		}	 
      	 
      var monthNew ="";	
      if(typeOfCategoryValue!=""&& typeOfCategoryValue!="0" && typeOfCategoryValue=='T'){
      	var newDays=(parseInt(date)+(parseInt(durationValue)*7));
      	if(newDays>=30){
      		  var remDayNew= parseInt(newDays)%30;
      		  var  coMonthNew= parseInt(newDays)/30;
      		 
      		     coMonthNew=  Math.floor(parseInt(coMonthNew));
      		     monthNew=parseInt(month)+parseInt(coMonthNew);
      		     date=remDayNew;
      		     
      	}
      	else{
      		date=newDays;
      		monthNew= month;
      	}
      }
      else{
      	  monthNew =parseInt(month)+parseInt(durationValue);	
      }
       
      var dateNext="";
      var yearNew;
      var remMonthNew;
      var  coYearNew;
      	if(monthNew>12){
      	   var remMonthNew= parseInt(monthNew)%12;
      	  var  coYearNew= parseInt(monthNew)/12;
      	 
      	   coYearNew=  Math.floor(parseInt(coYearNew));
      	   year=parseInt(year)+parseInt(coYearNew);
      	   if(date!=null && date!="" && date.toString().length==1)
      	     {
      	    	 date="0"+date;
      	     }
      	     if(remMonthNew!=null && remMonthNew!="" && remMonthNew.toString().length==1){
      	    	 remMonthNew="0"+remMonthNew;
      	     }
      	   dateNext=date+"/"+remMonthNew+"/"+year;
      	}
      	else{
      		
      		 if(date!=null && date!="" && date.toString().length==1)
      	     {
      	    	 date="0"+date;
      	     }
      	     if(monthNew!=null && monthNew!="" && monthNew.toString().length==1){
      	    	 monthNew="0"+monthNew;
      	     }
      	  
      		 dateNext=date+"/"+monthNew+"/"+year;
      	}
      	if(fitValue!="F")
      	{	
       			$('#'+nextCategoryDateId).val(dateNext);
       			//$('#'+nextCategoryDateId).attr('readonly', true);
      	}
      	else
      	{
      		$('#'+nextCategoryDateId).val("");
   			//$('#'+nextCategoryDateId).attr('readonly', true);
      	}	
      	}
      
	 
	 $j('body').on("focus",".noFuture_date501", function() {
	  	 $j(this).datepicker({ showOn: "button",
	  		buttonImage: "../resources/images/calendar.gif",		
			buttonImageOnly: true,
			dateFormat: 'dd/mm/yy',
			buttonText: 'Select Date',
			selectWeek:false,
			closeOnSelect:true,  
			changeMonth: true, 
			changeYear: true,
			clickInput:false,
			maxDate: new Date(),
			onSelect: function(dateText) {
		      display(this);
		      $(this).change();
		    }
	  	 }).on("change", function() {
		    display("Change event");  
	  	 });
	  	function display(ides) {
	  		generateNextDate(ides);  
	  	}
	  });
	  
	function getdurationByType(item){
		 var medCateDurationId=$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
		 var typeOfCategoryValueId=$(item).closest('tr').find("td:eq(4)").find("select:eq(0)").attr("id");
		 var typeOfCategoryValue=$("#"+typeOfCategoryValueId+" option:selected" ).val();
		 if(typeOfCategoryValue!=""&& typeOfCategoryValue!="0" && typeOfCategoryValue=='P'){
			 var durationValue='24';
			 
			 $('#'+medCateDurationId).val(durationValue);
			 $('#'+medCateDurationId).attr('readonly','readonly');
		 }
		 else{
			 $('#'+medCateDurationId).attr('readonly',false);
			 $('#'+medCateDurationId).val('');
			
		 }
	}
	   
	 var total_mc_value = '';
	 var idMcNoNew='';
	 function fillMedicalCategoryDataNewCheckkkkk(val,item) {
       	  
           var index1 = val.lastIndexOf("[");
           var index2 = val.lastIndexOf("]");
           index1++;
           idMcNoNew = val.substring(index1, index2);
           if (idMcNoNew == "") {
               return;
           } else {
                 total_mc_value += val+",";
                var b = "false";
               for(var i=0;i<autoMedicalCategoryDataNew.length;i++){
            		  
            		  var mcDataVal = mcDataNew[i].medicalCategoryCode;
            		 
            		  if(mcDataVal == idMcNoNew){
            			var mCategoryValue = mcDataNew[i].medicalCategoryId;
            			$(item).closest('tr').find("td:eq(9)").find(":input").val(mCategoryValue);
            		  }
            	  }
               if (b == "false") {
               	
                   $('#medicalCategoryIdNew').append('<option value=' + mCategoryValue + '>' + val + '</option>');
                   //document.getElementById('medicalCategoryId').value = ""

               }
           }
       } 
     
     function getMbAMSF15DetailsforValidate() {
		 var visitId = $('#visitId').val();
         var patientId=$('#patientId').val();
         var userId=$('#userId').val();
		 var data = {
			"visitId" : visitId,
			"patientId":patientId,
			"userId":userId
		};
		$
				.ajax({
					type : "POST",
					contentType : "application/json",
					url : 'getDataValidateAMSF15form',
					data : JSON.stringify(data),
					dataType : "json",
					// cache: false,

					success : function(response) {
					var datas = response.data;	
					console.log(datas);
					$.each(datas, function(i, item) {
						   
						    var authority=item.authorityforBoard;
						    if (authority != null && authority !="") {
						        document.getElementById('authority').value =authority;
						    }
						    
						    var place=item.placeOfBoard;
						    if (place != null && place !="") {
						        document.getElementById('place').value =place;
						    }
						    
						    var height=item.height;
						    if (height != null && height !="") {
						        document.getElementById('height').value =height;
						    }
						    
						    var weight=item.weight;
						    if (weight != null && weight !="") {
						        document.getElementById('weight').value =weight;
						    }
						    
						    var addressOnLeave=item.addressOnLeave;
						    if (addressOnLeave != null && addressOnLeave !="") {
						        document.getElementById('address_on_leave').value =addressOnLeave;
						    }
						    
						    var dateOfEnrolment=item.dateOfEnrolment;
						    if (dateOfEnrolment != null && dateOfEnrolment !="") {
						    	if(document.getElementById('doe_doc').value=="")
						    	{	
						    	 document.getElementById('doe_doc').value =dateOfEnrolment;
						    	}
						    }
						    
						    var recordOfficeAddress=item.recordOfficeAddress;
						    if (recordOfficeAddress != null && recordOfficeAddress !="") {
						        document.getElementById('reccord_office').value =recordOfficeAddress;
						    }
						    
						    var ceased=item.ceasedDutyOn;
						    if (ceased != null && ceased !="") {
						        document.getElementById('ceased').value =ceased;
						    }
						    
						    var disablityAttrService=item.disablityAttrService;
						    if (disablityAttrService != null && disablityAttrService !="") {
						        document.getElementById('disablityAttrService').value =disablityAttrService;
						    }
						    
						    var disablityAttrServiceRemark= item.disablityAttrServiceRemark;
						    if(disablityAttrServiceRemark!=null && disablityAttrServiceRemark!="")
						    {	
				            document.getElementById('disablityAttrServiceRemark').value =disablityAttrServiceRemark;
						    }
						    
				            var directlyAttrService= item.directlyAttrService;
				            if(directlyAttrService!=null && directlyAttrService!="")
				            {	
				            document.getElementById('directlyAttrService').value =directlyAttrService;
				            }
				            
				            var directlyAttrServiceRemark= item.directlyAttrServiceRemark;
				            if (directlyAttrServiceRemark != null && directlyAttrServiceRemark !="") {
						        document.getElementById('directlyAttrServiceRemark').value =directlyAttrServiceRemark;
						    }
				            
				            var previousDisablement= item.previousDisablement;
				            if (previousDisablement != null && previousDisablement !="") {
						        document.getElementById('previousDisablement').value =previousDisablement;
						    }
				            
				            var presentDisablement= item.presentDisablement;
				            if (presentDisablement != null && presentDisablement !="") {
						        document.getElementById('presentDisablement').value =presentDisablement;
						    }
				            
				            var reasonForVarious= item.reasonForVarious;
				            document.getElementById('reasonForVarious').value =reasonForVarious;
				            
				            var restrictionRegardingEmp= item.restrictionRegardingEmp;
				            if (restrictionRegardingEmp != null && restrictionRegardingEmp !="") {
						        document.getElementById('restrictionRegardingEmp').value =restrictionRegardingEmp;
						    }
				            

				            var instructionRemark= item.instructionRemark;
				            if(instructionRemark!= null && instructionRemark!="")
				            {	
				            document.getElementById('instructionRemark').value =instructionRemark;
				            }
				            
				            var instructionNote= item.instructionNote;
				            if(instructionNote!=null && instructionNote!="")
				            {	
				            document.getElementById('instructionNote').value =instructionNote; 
				            }
				            
				            var dateOfEnrolment= item.dateOfEnrolment;
				            if(dateOfEnrolment!=null && dateOfEnrolment!="")
				            {	
				            document.getElementById('signDate').value =dateOfEnrolment;
				            }
				            
				            var member1Name= item. member1Name;
				            if(member1Name!=null && member1Name!="")
				            {	
				            document.getElementById('member1Name').value =member1Name;
				            }
				            
				            var mem1Rank= item.mem1Rank;
				            if(mem1Rank!=null && mem1Rank!="")
				            {	
				            document.getElementById('mem1Rank').value =mem1Rank;
				            }
				            
				            var member2Name= item.member2Name;
				            if(member2Name!=null && member2Name!="")
				            {	
				            document.getElementById('member2Name').value =member2Name;
				            }
				            
				            var mem2Rank= item.mem2Rank;
				            if(mem2Rank!=null && mem2Rank!="")
				            {
				            document.getElementById('mem2Rank').value =mem2Rank;
				            }
				            
				            var member3Name= item.member3Name;
				            if(member3Name!=null && member3Name!="")
				            {	
				            document.getElementById('member3Name').value =member3Name;
				            }
				            
				            var mem3Rank= item.mem3Rank;
				            if(mem3Rank!=null && mem3Rank!="")
				            {	
				            document.getElementById('mem3Rank').value =mem3Rank;
				            }
				            
				            var pendingRemarks= item.pendingRemarks;
				            document.getElementById('pendingRemarks').value =pendingRemarks;
				            
				            var ridcId= item.ridcId;
				            if(ridcId!=null && ridcId!="")
				            {	
				            	$('#uploadFileMedicalExam').show();
				            	$('#viewUploadedFile').show();
				            	var viewUploadedFile="";
				            	viewUploadedFile += '<a class="btn btn-link" href="#" onclick="viewDocumentForDigi('+ridcId+');" >View Document</a>'
				            	//<a class="btn-link" href="#" onclick="viewDocumentForDigi('+ridcId+');" >View Document</a>
				            	//viewUploadedFile+="<button id ='printBtn' type='button'  class='btn btn-primary' onclick='viewDocumentForDigi("+data.data[0].ridcId+");'>View Document</button>";
				        		$('#viewUploadedFile').html(viewUploadedFile);	
				            }
				            
				            var aaName= item.aaName;
				            if(aaName!=null && aaName!="")
				            {	
				            document.getElementById('aaName').value =aaName;
				            }
				            var aaRank= item.aaRank;
				            if(aaRank!=null && aaRank!="")
				            {	
				            document.getElementById('aaRank').value =aaRank;
				            }
				            var aaPlace= item.aaPlace;
				            if(aaPlace!=null && aaPlace!="")
				            {	
				            document.getElementById('aaPlace').value =aaPlace;
				            }
				            var aaDate= item.aaDate;
				            if(aaDate!=null && aaDate!="")
				            {	
				            document.getElementById('aaDate').value =aaDate;
				            }
				            var paName= item.paName;
				            if(paName!=null && paName!="")
				            {	
				            document.getElementById('paName').value =paName;
				            }
				            var paRank= item.paRank;
				            if(paRank!=null && paRank!="")
				            {	
				            document.getElementById('paRank').value =paRank;
				            }
				            var paPlace= item.paPlace;
				            if(paPlace!=null && paPlace!="")
				            {	
				            document.getElementById('paPlace').value =paPlace;
				            }
				            var paDate= item.paDate;
				            if(aaDate!=null && aaDate!="")
				            {	
				            document.getElementById('paDate').value =paDate;
				            }
				            var typeOfCommission= item.typeOfCommission;
				            if(typeOfCommission!=null && typeOfCommission!="")
				            {	
				            document.getElementById('typeOfCommission').value =typeOfCommission;
				            }
				          				            
				           });
					
				}
	    });
 }
     //oldautocomplete(document.getElementById("medicalCompositeName"), MeidcalCategoryArry);  
     
     var total_mc_Com_value = '';
     function fillMedicalComposite(val,item) {
       	  
           var index1 = val.lastIndexOf("[");
           var index2 = val.lastIndexOf("]");
           index1++;
           idMcNo = val.substring(index1, index2);
           if (idMcNo == "") {
               return;
           } else {
               obj = document.getElementById('medicalCategoryId');
               total_mc_Com_value += val+",";
              
               var b = "false";
               for(var i=0;i<autoMedicalCategoryData.length;i++){
            		  
            		  var mcDataVal = mcData[i].medicalCategoryCode;
            		 
            		  if(mcDataVal == idMcNo){
            			var mCategoryValue = mcData[i].medicalCategoryId;
            		    document.getElementById('medicalCompositVal').value =mCategoryValue;
            		  }
            	  }
               if (b == "false") {
               	
                   $('#medicalCategoryId').append('<option value=' + mCategoryValue + '>' + val + '</option>');
                   //document.getElementById('medicalCategoryId').value = ""

               }
           }
       }  
     
     function do_resize(textbox) {

    	 var maxrows=5; 
    	  var txt=textbox.value;
    	  var cols=textbox.cols;

    	 var arraytxt=txt.split('\n');
    	  var rows=arraytxt.length; 

    	 for (i=0;i<arraytxt.length;i++) 
    	  rows+=parseInt(arraytxt[i].length/cols);

    	 if (rows>maxrows) textbox.rows=maxrows;
    	  else textbox.rows=rows;
    	 }
     
     var meidcalCategoryArryNew = new Array();
     var autoMedicalCategoryDataNew='';
     var mcDataNew='';
     function masMedicalCategoryListNew() {
     	
         var pathname = window.location.pathname;
         var accessGroup = "MMUWeb";

         var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/getMedicalBoardAutocomplete";

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
            	 mcDataNew = res.masMedicalCategoryList;
            	 autoMedicalCategoryDataNew=res.masMedicalCategoryList;
                 for (var i = 0; i < mcDataNew.length; i++) {
                     var mcId1 = mcDataNew[i].medicalCategoryId;
                     var mcCode1 = mcDataNew[i].medicalCategoryCode;
                     var mcName1 = mcDataNew[i].medicalCategoryName;
                   //  var a = icdName + "[" + icdCode + "]"

                     var medicalCategoryDataNew = mcName1 + "[" + mcCode1 + "]"
                    
                     meidcalCategoryArryNew.push(medicalCategoryDataNew);
                    // console.log('data :', MeidcalCategoryArry);
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

     var medicalCategoryListHtml='';
 	var masmedicalCategoryList='';
 	var medicalCategoryListChecked='';
 	var medicalCategoryListValue='';
 	function getMedicalCategoryListDropDown() {
 		
 		var j=1;
 	    
 		var pathname = window.location.pathname;
 		var accessGroup = "MMUWeb";
 		var url = window.location.protocol + "//"
 		+ window.location.host + "/" + accessGroup
 		+ "/medicalBoard/getMedicalBoardAutocomplete";
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
 						masmedicalCategoryList = response.masMedicalCategoryList;
 						$.each(masmedicalCategoryList, function(i, item) {
 							medicalCategoryListHtml += '<option value="' + item.medicalCategoryId+'" >' + item.medicalCategoryName
 									+ '</option>';
 							//$('.referSpecialistList').html(specialistHtml);
 						});
 						//console.log("medicalCategoryListHtml "+medicalCategoryListHtml);
 						//$('#medicalCategoryIdNewchecked').html(medicalCategoryListHtml);
 						medicalCategoryListValue=medicalCategoryListHtml;
 						
 					  
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
 
 	var rowId=0;
	 function addRowMBDocs() {
			var tbl = document.getElementById('medicalBoardDocs');
			lastRow = tbl.rows.length;
			rowId = lastRow;
			rowId++;
			var val = parseInt($('#medicalBoardDocs>tr:last').find("td:eq(0)").text());
			var aClone = $('#medicalBoardDocs>tr:last').clone(true)
			aClone.find(":input").val("");
			
			aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'patientDocumentId'+rowId+'');
			aClone.find("td:eq(1)").find("textarea:eq(0)").prop('id', 'medicalDocs'+rowId+'');
			
			aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'medicalBoardDocsUpload'+rowId+'');
			aClone.find("td:eq(2)").find("input:eq(0)").prop('name', 'medicalBoardDocsUpload'+rowId+'');
			
			aClone.find("option[selected]").removeAttr("selected")
			
			var patientDetailDocFile='<div class="fileUploadDiv"><input type="file" name="medicalBoardDocsUpload'+rowId+'" id="medicalBoardDocsUpload'+rowId+'" value="" class="inputUpload"><label class="inputUploadlabel">Choose File</label><span class="inputUploadFileName">No File Chosen</span></div>';
			aClone.find("td:eq(2)").html(patientDetailDocFile);
	 
			aClone.find('button[button-type="delete"]').removeAttr('disabled');
			
			aClone.clone(true).appendTo('#medicalBoardDocs');
			var val = $('#medicalBoardDocs>tr:last').find("td:eq(3)").find(":input")[0];
			rowId++;

		}	
	 
	 
	 function removeRowMBDocs(val){
			
			if($('#medicalBoardDocs tr').length > 1) {
				   $(val).closest('tr').remove()
				 }

		}
	 
	 function openResultModelMedicalDocs(item){
			
		
		 var resultIdIm= $(item).closest('tr').find("td:eq(1)").find("textarea:eq(0)").attr("id");
			/* if(resultIdIm=="" || resultIdIm==undefined)
			 resultIdIm= $(item).closest('tr').find("td:eq(3)").find("textarea:eq(0)").attr("id"); */
			var resultView = $('#'+resultIdIm).val();
			if(resultView.includes("@@@###")){
				resultView=resultView.replace("@@@###","");
			}
			resultView = decodeHtml(resultView)
		 	$('#editorOfUploadMb').jqteVal(resultView);
		 	$('#fileUploadModalMb').show();
		 	$('.modal-backdrop ').show();
			$('#resultIdMedicalDocs').val(resultIdIm);
		}


		function saveMedicalBoardInTextMb(){
			var idOfResult=$('#resultIdMedicalDocs').val();
			 var jqetResultValue=$('#editorOfUploadMb').val();
			 
			 if(jqetResultValue!=""){
				 jqetResultValue=jqetResultValue.trim();
				 jqetResultValue="@@@###"+jqetResultValue;
			 }
			 
			 $('#'+idOfResult).val(jqetResultValue);
			 $('.modal').hide();
			 $('.modal-backdrop ').hide();
			
		}
    
		var documentListHtml='';
		var masDocumentList='';
		var masDocumentListVal='';
		var patientDocumentDetailList='';
function getDocumentListMb() {
			
			var j=1;
		    
			var pathname = window.location.pathname;
			var accessGroup = "MMUWeb";
			var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/medicalBoard/getDocumentList";
			$
					.ajax({
						url : url,
						dataType : "json",
						data : JSON.stringify({
							'employeeId' : '1',
							'visitId':$('#visitId').val()
						}),
						contentType : "application/json",
						type : "POST",
						success : function(response) {
							console.log(response);
							masDocumentList = response.MasDocumentList;
							patientDocumentDetailList=response.listPatientDocumentDetail;
							var docHtml = '<option value=""><strong>Select Document...</strong></option>';
							$.each(masDocumentList, function(i, item) {
								docHtml += '<option value="' + item.documentId + '@'
										+ item.documentCode + '" >' + item.documentName
										+ '</option>';
								//$('.referSpecialistList').html(specialistHtml);
							});
							console.log("docHtml "+docHtml);
							$('#docId').html(docHtml);
							masDocumentListVal=docHtml;
							getPatientDocumentDetailHtml();
						  
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
oldautocomplete(document.getElementById("recommedicalCompositeName"), MeidcalCategoryArry);		
function recomfillMedicalComposite(val,item) {
	  
    var index1 = val.lastIndexOf("[");
    var index2 = val.lastIndexOf("]");
    index1++;
    idMcNo = val.substring(index1, index2);
    if (idMcNo == "") {
        return;
    } else {
        obj = document.getElementById('recommedicalCompositeName');
        total_mc_Com_value += val+",";
       
        obj.length = document.getElementById('recommedicalCompositeName').length;
        var b = "false";
        for(var i=0;i<autoMedicalCategoryData.length;i++){
     		  
     		  var mcDataVal = mcData[i].medicalCategoryCode;
     		 
     		  if(mcDataVal == idMcNo){
     			var mCategoryValue = mcData[i].medicalCategoryId;
     		    document.getElementById('recommedicalCompositVal').value =mCategoryValue;
     		  }
     	  }
        if (b == "false") {
        	
            $('#medicalCategoryId').append('<option value=' + mCategoryValue + '>' + val + '</option>');
            //document.getElementById('medicalCategoryId').value = ""

        }
    }
}

var autoIcdCode = '';
var icdData= '';	 
 var idIcdNo = '';
 var icdValue = '';
function fillDiagnosisComboRecomm(val,item) {
	  
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
   			var checkCurrentRowIddd = $(item).closest('tr').find("td:eq(8)").find("input:eq(0)").attr("id");
		     var checkCurrentRow = $(item).closest('tr').find("td:eq(8)").find("input:eq(0)").val();
   			  $('#medicalCategoryNew tr').each(function(i, el) {
   				//alert("icdNo1"+icdNo1)
   				//alert("icdValue "+icdValue)
   				  var $tds = $(this).find('td');
					var chargeCodeId = $($tds).closest('tr').find("td:eq(8)").find("input:eq(0)").attr("id");
					var chargeCodeIdValue = $('#' + chargeCodeId).val();
					var idddd = $(item).closest('tr').find("td:eq(8)").find("input:eq(0)").attr("id");
					var currentidddd = $(item).closest('tr').find("td:eq(1)").find("textarea:eq(0)").attr("id");
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
	               			  $(item).closest('tr').find("td:eq(8)").find("input:eq(0)").val(icdValue);
	               			
					}  
		}); 
   		}
   	  }
    }
}
   
function getMBPreAssesDetailsDataForNewGrid() {
	var saveDraftVal=$('#saveInDraft').val();
	investigationGridValue = "investigationGrid";
	var visitId = $('#visitId').val();
	var patientId=$('#patientId').val();
	var pathname = window.location.pathname;
 var accessGroup = "MMUWeb";
	 var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/getMBMedicalCategory";
	
	var data = {
		"visitId" : visitId,
		"patientId":patientId,
		"flagForDigi":"No"
	};
	$.ajax({
				type : "POST",
				contentType : "application/json",
				url : url,
				data : JSON.stringify(data),
				dataType : "json",
				// cache: false,
				success : function(response) {
				var datas = response.data;
				var trHTML = '';
				var i=0;
				var min=100;
				var categoryType="";	
				var diasableValue="disabled";
				 var approvalFlag=$('#approvalFlag').val();
				 var approvalFlagDiasable="";
				 if(approvalFlag!="" && approvalFlag!=undefined && approvalFlag!=null && approvalFlag=='y'|| (saveDraftVal!="" && (saveDraftVal=='ea'||saveDraftVal=='ej'))){
					 approvalFlagDiasable='disabled';
				 }
				 else{
					 approvalFlagDiasable="";
				 }
		      var countForSystem=0;
				 
				if(datas!=undefined && datas.length>=1 ){
					
				$.each(datas, function(i, item) {
					var recommendStatus=item.recommendStatus;
					var fitFlag=item.fitFlag;
					var fitCatId=item.fitCatId;
					var medicalCategoryFit=item.medicalCategoryFit;
					var fitCatDate=item.fitCatDate;
					var mbStatus=item.mbStatus;
					
					if(item.system!=null && item.system!=null && item.fitFlag!="F" && mbStatus=="A"){
						countForSystem++;
					var duration="";
					var investigationName="";
						/*if(item.inveName!=undefined && item.inveName!="" && item.inveName!=null){
							 investigationName=item.inveName;	
						}*/
						var icdName="";
						if(item.icdName!=undefined && item.icdName!=null && item.icdName!=""){
					    	icdName=item.icdName
					    }
						
						var system="";
						if(item.system!=undefined && item.system!=null && item.system!=""){
							system=item.system;
						}
						var medicalCategory="";
						if(item.medicalCategory!=undefined && item.medicalCategory!=null && item.medicalCategory!="")
							medicalCategory=item.medicalCategory;
						 
						if(item.categoryType!=undefined && item.categoryType!=null && item.categoryType!="")
							categoryType=item.categoryType;
						var categoryDate="";
						if(item.categoryDate!=undefined && item.categoryDate!=null && item.categoryDate!=""){
							categoryDate=item.categoryDate;
						}
						if(item.duration!=undefined && item.duration!=""&& item.duration!=null){
							  duration=item.duration;	
						}
						
						var nextCategoryDate="";
						if(item.nextCategoryDate!=undefined && item.nextCategoryDate!=null && item.nextCategoryDate!=""){
							 nextCategoryDate=item.nextCategoryDate;	
						}
						var patientMedicalCategoryId="";
						if(item.patientMedicalCategoryId!=undefined && item.patientMedicalCategoryId!=null && item.patientMedicalCategoryId!=""){
							patientMedicalCategoryId=item.patientMedicalCategoryId;
						}
						var diagnosisId="";
						if(item.diagnosisId!=undefined && item.diagnosisId!=null && item.diagnosisId!=""){
							diagnosisId=item.diagnosisId;
						}
						var medicalCategoryId="";
						if(item.medicalCategoryId!=undefined && item.medicalCategoryId!=null && item.medicalCategoryId!=""){
							medicalCategoryId=item.medicalCategoryId;
						}
						
						if(icdName!=""){
							msgOfICDDiagnosis=icdName;
						}
						if(medicalCategory!=""){
							msgOfMedicalCatName=medicalCategory;
						}
						
						if(system!=undefined && system!="")
							msgOfSystem=system;
						if(categoryType!=undefined && categoryType!=""){
						if(categoryType=='T'){
							msgOfTypeOfMedCat+=" "+"T" ;
						}else{
							msgOfTypeOfMedCat+=" "+"Pmt" ;
						}
				
						if(duration!="" && duration!=undefined){
							durationF=duration;
						}
						else{
							durationF="";
						}
						if(categoryDate!="" && categoryDate!=undefined){
							msgOfCatdate=categoryDate;
						}
						
						if(nextCategoryDate!=""){
							msgOfNextCategoryDate=nextCategoryDate;
						}
						var  msgOfFinalObservationValue=resourceJSON.msgOfFinalObservation;
						var updateMsgOfFinalObservationValue="";
						
						if(msgOfFinalObservationValue!="" ){
							updateMsgOfFinalObservationValue = msgOfFinalObservationValue.replace("<< Medical cat name>>", "<b>"+msgOfMedicalCatName+"</b>");
							updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<system>>", "<b>("+msgOfSystem+")</b>");
							updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<type of med cat>>", "<b>"+msgOfTypeOfMedCat+"</b>");
							updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<duration>>",  "<b>"+durationF+"</b>");
							updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<ICD Diagnosis>>", "<b>"+msgOfICDDiagnosis+"</b>");
							updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<cat date>>", "<b>"+msgOfCatdate+"</b>" );
							updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<Next category date>>", "<b>"+msgOfNextCategoryDate+"</b>" );
							finalObersationDetail+=	"<br>"+updateMsgOfFinalObservationValue;
						}
						
						}
						if(icdName!=undefined && icdName!="" && mbStatus=='A')
						msgOfICDDiagnosis+=" "+icdName;
						if(categoryDate!=undefined && categoryDate!="")
						msgOfCatdate+=" "+categoryDate;
						if(nextCategoryDate!=undefined && nextCategoryDate!="")
							msgOfNextCategoryDate+=" "+nextCategoryDate;
						
						var dateOfOrigin=item.dateOfOrigin;
						var placeOfOrigin=item.placeOfOrigin;
						var selectCheck=item.applyFor;
						
						
						if(selectCheck=='Y')
						{
							 checkValue1 = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1'+min+'" onclick="return masMedicalCategoryforFitCat(this);"><span class="cus-checkbtn"></span> ';
							 tr1='<tr style="background-color: #84e08f"><td><div class="form-check form-check-inline cusCheck">';
															 
						}
						if(icdName!=null && icdName!=undefined && mbStatus=='A')
						{
							var tr2='<tr style="background-color: #84b6e0"><td><div class="form-check form-check-inline cusCheck">';
							trHTML+=tr2+checkValue1;
							trHTML+=' <td>';
							func1='fillDiagnosisComboRecomm';
				    		 url1='opd';
				    		 url2='getIcdListByName';
				    		 flaga='diagnosisMe';
						
				    		 trHTML+='<div class="autocomplete forTableResp"><textarea class="form-control" value="'+icdName+'" id="diagnosisIdNew'+min+'" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"  onblur="fillDiagnosisCombo(this.value,this);" placeholder="Diagnosis">'+icdName+'</textarea><div id="diagnosisMeDiv" class="autocomplete-itemsNew"></div></div></td>';
					    		
							/* trHTML+=' <div class="autocomplete forTableResp">';
							//trHTML+='<input type="text" class="form-control" '+approvalFlagDiasable+' name="diagnosisId" id="diagnosisId'+i+'" onblur="fillDiagnosisCombo(this.value,this);" onKeyPress="autoCompleteCommonMe(this,5);" onKeyUp="autoCompleteCommonMe(this,5);"placeholder="Diagnosis" value="'+icdName+'" />';
							trHTML+='<input type="text" class="form-control" '+approvalFlagDiasable+' name="diagnosisId" id="diagnosisId'+i+'"  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" placeholder="Diagnosis" value="'+icdName+'" />';
							trHTML+='<div id="diagnosisMeDiv'+i+'" class="autocomplete-itemsNew"></div>';
							trHTML+='</div>';
							trHTML+=' </td>	'; */
							
							func1='fillMedicalCategoryData';
				    		 url1='medicalBoard';
				    		 url2='getMedicalBoardAutocomplete';
				    		 flaga='compositeCategory';
							 trHTML+='<td><select name="medicalCategoryIdNewchecked" id="medicalCategoryIdNewchecked" class="form-control" tabindex="36" readonly>';
				    		 trHTML+='<option value="0"><strong>Please select Category</strong></option>';
							 var selectCategory= "";
							 if(masmedicalCategoryList!=null && masmedicalCategoryList.length!=0)
								 for (var j = 0; j < masmedicalCategoryList.length; j++) {
									 if (medicalCategoryId == masmedicalCategoryList[j].medicalCategoryId) {
										 selectCategory = 'selected';
										} else {
											selectCategory = "";
										}
									 trHTML += '<option ' + selectCategory + ' value="' +masmedicalCategoryList[j].medicalCategoryId +'" >' + masmedicalCategoryList[j].medicalCategoryName
										+ '</option>';
									}
							 trHTML += '</select>';
							 trHTML  += '</td>';
				    		 /* trHTML+='  <td>';
							trHTML+=' <div class="autocomplete forTableResp">';
							//trHTML+='<input type="text" id="medicalCategoryId" onblur="fillMedicalCategoryData(this.value,this);" '+approvalFlagDiasable+' value="'+medicalCategory+'" onKeyPress="autoCompleteCommonMe(this,6);"  onKeyUp="autoCompleteCommonMe(this,6);" class="form-control">';
							trHTML+='<input type="text" id="medicalCategoryId"   '+approvalFlagDiasable+' value="'+medicalCategory+'"onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"  class="form-control">';
							trHTML+='<input type="hidden" id="diagnosisiIdMC'+i+'" name="diagnosisiIdMC" value="'+diagnosisId+'"/>';
							trHTML+='<input type="hidden" id="medicalCategoryValueId'+i+'" name="medicalCategoryValueId" value="'+medicalCategoryId+'"/>';
							trHTML+='<input type="hidden" id="patientMedicalCatId'+i+'" name="patientMedicalCatId" value="'+patientMedicalCategoryId+'"/>';
							trHTML+='<div id="compositeCategoryForDetailDiv'+i+'" class="autocomplete-itemsNew"></div>';
							trHTML+='</div> ';
							trHTML+='</td>'; */
							var systemArrary = ["S","H","A","P","E"]; 
							trHTML+=' <td>';
							trHTML+='<select class="form-control" name=system id="system'+min+'" '+approvalFlagDiasable+'>';
							trHTML+='<option value="0">Select</option>';
							for(var j=0;j<systemArrary.length;j++){
								var systemSelectedVal="";
								if(systemArrary[j]==system){
									systemSelectedVal='selected';
								}
								else{
									systemSelectedVal="";
								}
								trHTML+='<option '+systemSelectedVal+' value='+systemArrary[j]+'>'+systemArrary[j]+'</option>';
							}
							trHTML+='</select>';
							trHTML+='</td>';
							
							
							
							trHTML+=' <td>';
							trHTML+='<select class="form-control" name=typeOfCategory id="typeOfCategory'+min+'" onchange="getdurationByType(this);" '+approvalFlagDiasable+'>';
							
							trHTML+='<option value="0">Select</option>';
							if(categoryType!=null && categoryType!="" && categoryType!=undefined){
								var cateValue;
								var catetypeVal;
								for(var k=0;k<2;k++){
								var selectValue=""
								if(categoryType=='T'){
									selectValue='selected';
									cateValue='Temporary(Week)';
									catetypeVal='T';
									categoryType='';
									
								}
								else if(categoryType=='P'){
									selectValue='selected';
									cateValue='Permanent(Month)';
									catetypeVal='P';
									categoryType='';
								}
								else{
									var count=0;
									if(cateValue=='Temporary(Week)' && count=='0'){
										cateValue='Permanent(Month)';
										catetypeVal='P';
										count++;
									} 
									if(cateValue=='Permanent(Month)' && count=='0'){
										cateValue='Temporary(Week)';
										catetypeVal='T';
										count++;
									}
									selectValue='';
								}
								trHTML+='<option '+selectValue+' value='+catetypeVal+'>'+cateValue+'</option>';
							}
							}
							else{
								
								trHTML+='<option value="T">Temporary(Week)</option>';
								trHTML+='<option value="P">Permanent(Month)</option>';
							}	
							trHTML+='</select>';
							trHTML+='</td>';
							
							trHTML+='<td>';
							trHTML+='<input type="text" '+approvalFlagDiasable+' name="duration" id="duration'+min+'" value="'+duration+'" onblur="return generateNextDate(this);" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control"> </td>';
							trHTML+='</td>';
							
							trHTML+='<td>';
							trHTML+='<div class="dateHolder">';
							trHTML+=' <input type="text" '+approvalFlagDiasable+' id="categoryDate'+min+'" ';
							trHTML+=' name="categoryDate" class="noFuture_date5 form-control" ';
							trHTML+=' placeholder="DD/MM/YYYY" value="'+categoryDate+'" maxlength="10" />';
							trHTML+='  </div>';
							trHTML+='  </td>';
							
							trHTML+='<td>';
							trHTML+='   <div class="dateHolder">';
							trHTML+=' <input type="text" '+approvalFlagDiasable+' id="nextcategoryDate'+min+'" name="nextcategoryDate" class="form-control" placeholder="DD/MM/YYYY" value="'+nextCategoryDate+'" maxlength="10" />';
							trHTML+=' </div>';
							trHTML+='  </td>';
							trHTML+='<td style="display: none";><input type="hidden" value="'+diagnosisId+'" tabindex="1" id="diagnosisIdval'+min+'" size="77" name="diagnosisIdval" /></td>';
							trHTML+='<td style="display: none";><input type="hidden" tabindex="1" id="medicalCategoryIdval'+min+'" value="'+medicalCategoryId+'" size="77"name="medicalCategoryIdval" /></td>';
							trHTML+='<td style="display: none";><input type="hidden" tabindex="1" id="categoryIdval" size="77" value="'+patientMedicalCategoryId+'" name="categoryIdval" /></td>';
							trHTML+='<td><button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForMedicalCategoryNewDiagnosis();"></button></td>';
							trHTML+='<td><button type="button" name="delete" value=""  class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"  onclick="removeRowMedicalCategoryNew(this)" disabled></button></td>';
							trHTML+='<td style="display: none";><input type="hidden" value="" tabindex="1" id="patientCategoryFId'+i+'" size="77"name=" patientCategoryFId" /></td>';
							trHTML+='<td style="display: none";><input type="hidden" value="'+fitFlag+'" tabindex="1" id="fitFlag'+i+'" size="77" name="fitFlag" /></td></tr>';
						
							/* trHTML+=' <td>';
							trHTML+='<button type="button" '+approvalFlagDiasable+' type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForMedicalCategory();"></button>';
							trHTML+=' </td>';
							trHTML+=' <td>';
							trHTML+=' <button type="button" name="delete" value="" '+diasableValue+' class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"  onclick="removeRowMedicalCategory(this)"></button>';
							trHTML+=' </td>';	 */
						  min++;
						 }
			    	   }
					
					if(item.fitFlag=="F" && mbStatus=="C"){
						countForSystem++;
					var duration="";
					var investigationName="";
						/*if(item.inveName!=undefined && item.inveName!="" && item.inveName!=null){
							 investigationName=item.inveName;	
						}*/
						var icdName="";
						if(item.icdName!=undefined && item.icdName!=null && item.icdName!=""){
					    	icdName=item.icdName
					    }
						
						var system="";
						if(item.system!=undefined && item.system!=null && item.system!=""){
							system=item.system;
						}
						var medicalCategory="";
						if(item.fitCatId!=undefined && item.fitCatId!=null && item.fitCatId!="")
							fitCatId=item.fitCatId;
						 var newcategoryType="";
						if(item.categoryType!=undefined && item.categoryType!=null && item.categoryType!="")
							newcategoryType=item.categoryType;
						var categoryDate="";
						if(item.categoryDate!=undefined && item.categoryDate!=null && item.categoryDate!=""){
							categoryDate=item.categoryDate;
						}
						if(item.duration!=undefined && item.duration!=""&& item.duration!=null){
							  duration=item.duration;	
						}
						
						var nextCategoryDate="";
						if(item.nextCategoryDate!=undefined && item.nextCategoryDate!=null && item.nextCategoryDate!=""){
							 nextCategoryDate=item.nextCategoryDate;	
						}
						var patientMedicalCategoryId="";
						if(item.patientMedicalCategoryId!=undefined && item.patientMedicalCategoryId!=null && item.patientMedicalCategoryId!=""){
							patientMedicalCategoryId=item.patientMedicalCategoryId;
						}
						var diagnosisId="";
						if(item.diagnosisId!=undefined && item.diagnosisId!=null && item.diagnosisId!=""){
							diagnosisId=item.diagnosisId;
						}
						var medicalCategoryId="";
						if(item.medicalCategoryId!=undefined && item.medicalCategoryId!=null && item.medicalCategoryId!=""){
							medicalCategoryId=item.medicalCategoryId;
						}
						
						if(icdName!=""){
							msgOfICDDiagnosis=icdName;
						}
						if(medicalCategory!=""){
							msgOfMedicalCatName=medicalCategory;
						}
						
						if(system!=undefined && system!="")
							msgOfSystem=system;
						if(categoryType!=undefined && categoryType!=""){
						if(categoryType=='T'){
							msgOfTypeOfMedCat+=" "+"T" ;
						}else{
							msgOfTypeOfMedCat+=" "+"Pmt" ;
						}
				
						if(duration!="" && duration!=undefined){
							durationF=duration;
						}
						else{
							durationF="";
						}
						if(categoryDate!="" && categoryDate!=undefined){
							msgOfCatdate=categoryDate;
						}
						
						if(nextCategoryDate!=""){
							msgOfNextCategoryDate=nextCategoryDate;
						}
						var  msgOfFinalObservationValue=resourceJSON.msgOfFinalObservation;
						var updateMsgOfFinalObservationValue="";
						
						if(msgOfFinalObservationValue!="" ){
							updateMsgOfFinalObservationValue = msgOfFinalObservationValue.replace("<< Medical cat name>>", "<b>"+msgOfMedicalCatName+"</b>");
							updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<system>>", "<b>("+msgOfSystem+")</b>");
							updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<type of med cat>>", "<b>"+msgOfTypeOfMedCat+"</b>");
							updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<duration>>",  "<b>"+durationF+"</b>");
							updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<ICD Diagnosis>>", "<b>"+msgOfICDDiagnosis+"</b>");
							updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<cat date>>", "<b>"+msgOfCatdate+"</b>" );
							updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<Next category date>>", "<b>"+msgOfNextCategoryDate+"</b>" );
							finalObersationDetail+=	"<br>"+updateMsgOfFinalObservationValue;
						}
						
						}
						if(icdName!=undefined && icdName!="" )
						msgOfICDDiagnosis+=" "+icdName;
						if(categoryDate!=undefined && categoryDate!="")
						msgOfCatdate+=" "+categoryDate;
						if(nextCategoryDate!=undefined && nextCategoryDate!="")
							msgOfNextCategoryDate+=" "+nextCategoryDate;
						
						var mbStatus=item.mbStatus;
						var dateOfOrigin=item.dateOfOrigin;
						var placeOfOrigin=item.placeOfOrigin;
						var selectCheck=item.applyFor;
						
						
						if(item.fitFlag=="F")
						{
							 checkValue1 = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1" checked disabled ="true"><span class="cus-checkbtn"></span> ';
							 tr1='<tr style="background-color: #84e08f"><td><div class="form-check form-check-inline cusCheck">';
															 
						}
						if(icdName!=null && icdName!=undefined)
						{
							var tr2='<tr style="background-color: #84b6e0"><td><div class="form-check form-check-inline cusCheck">';
							trHTML+=tr2+checkValue1;
							trHTML+=' <td>';
							func1='fillDiagnosisComboRecomm';
				    		 url1='opd';
				    		 url2='getIcdListByName';
				    		 flaga='diagnosisMe';
						
				    		 trHTML+='<div class="autocomplete forTableResp"><textarea class="form-control width180" value="'+icdName+'" id="diagnosisIdNew'+min+'" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"  onblur="fillDiagnosisCombo(this.value,this);" placeholder="Diagnosis" readonly>'+icdName+'</textarea><div id="diagnosisMeDiv" class="autocomplete-itemsNew"></div></div></td>';
					    		
							/* trHTML+=' <div class="autocomplete forTableResp">';
							//trHTML+='<input type="text" class="form-control" '+approvalFlagDiasable+' name="diagnosisId" id="diagnosisId'+i+'" onblur="fillDiagnosisCombo(this.value,this);" onKeyPress="autoCompleteCommonMe(this,5);" onKeyUp="autoCompleteCommonMe(this,5);"placeholder="Diagnosis" value="'+icdName+'" />';
							trHTML+='<input type="text" class="form-control" '+approvalFlagDiasable+' name="diagnosisId" id="diagnosisId'+i+'"  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" placeholder="Diagnosis" value="'+icdName+'" />';
							trHTML+='<div id="diagnosisMeDiv'+i+'" class="autocomplete-itemsNew"></div>';
							trHTML+='</div>';
							trHTML+=' </td>	'; */
							
							func1='fillMedicalCategoryData';
				    		 url1='medicalBoard';
				    		 url2='getMedicalBoardAutocomplete';
				    		 flaga='compositeCategory';
							 trHTML+='<td><select name="medicalCategoryIdNewchecked" id="medicalCategoryIdNewchecked" class="form-control width100" tabindex="36" disabled ="true">';
				    		 trHTML+='<option value="0"><strong>Please select Category</strong></option>';
							 var selectCategory= "";
							 if(masmedicalCategoryList!=null && masmedicalCategoryList.length!=0)
								 for (var j = 0; j < masmedicalCategoryList.length; j++) {
									 if (fitCatId == masmedicalCategoryList[j].medicalCategoryId) {
										 selectCategory = 'selected';
										} else {
											selectCategory = "";
										}
									 trHTML += '<option ' + selectCategory + ' value="' +masmedicalCategoryList[j].medicalCategoryId + '" >' + masmedicalCategoryList[j].medicalCategoryName
										+ '</option>';
									}
							 trHTML += '</select>';
							 trHTML  += '</td>';
				    		 /* trHTML+='  <td>';
							trHTML+=' <div class="autocomplete forTableResp">';
							//trHTML+='<input type="text" id="medicalCategoryId" onblur="fillMedicalCategoryData(this.value,this);" '+approvalFlagDiasable+' value="'+medicalCategory+'" onKeyPress="autoCompleteCommonMe(this,6);"  onKeyUp="autoCompleteCommonMe(this,6);" class="form-control">';
							trHTML+='<input type="text" id="medicalCategoryId"   '+approvalFlagDiasable+' value="'+medicalCategory+'"onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"  class="form-control">';
							trHTML+='<input type="hidden" id="diagnosisiIdMC'+i+'" name="diagnosisiIdMC" value="'+diagnosisId+'"/>';
							trHTML+='<input type="hidden" id="medicalCategoryValueId'+i+'" name="medicalCategoryValueId" value="'+medicalCategoryId+'"/>';
							trHTML+='<input type="hidden" id="patientMedicalCatId'+i+'" name="patientMedicalCatId" value="'+patientMedicalCategoryId+'"/>';
							trHTML+='<div id="compositeCategoryForDetailDiv'+i+'" class="autocomplete-itemsNew"></div>';
							trHTML+='</div> ';
							trHTML+='</td>'; */
							var systemArrary = ["S","H","A","P","E"]; 
							trHTML+=' <td>';
							trHTML+='<select class="form-control width100" name=system id="system'+min+'" '+approvalFlagDiasable+' disabled ="true">';
							trHTML+='<option value="0">Select</option>';
							for(var j=0;j<systemArrary.length;j++){
								var systemSelectedVal="";
								if(systemArrary[j]==system){
									systemSelectedVal='selected';
								}
								else{
									systemSelectedVal="";
								}
								trHTML+='<option '+systemSelectedVal+' value='+systemArrary[j]+'>'+systemArrary[j]+'</option>';
							}
							trHTML+='</select>';
							trHTML+='</td>';
							
							
							
							trHTML+=' <td>';
							trHTML+='<select class="form-control" name=typeOfCategory id="typeOfCategory'+min+'" onchange="getdurationByType(this);" '+approvalFlagDiasable+' disabled ="true">';
							
							trHTML+='<option value="0">Select</option>';
							if(newcategoryType!=null && newcategoryType!="" && newcategoryType!=undefined){
								var cateValue;
								var catetypeVal;
								for(var k=0;k<2;k++){
								var selectValue=""
								if(newcategoryType=='T'){
									selectValue='selected';
									cateValue='Temporary(Week)';
									catetypeVal='T';
									categoryType='';
									
								}
								else if(newcategoryType=='P'){
									selectValue='selected';
									cateValue='Permanent(Month)';
									catetypeVal='P';
									categoryType='';
								}
								else{
									var count=0;
									if(cateValue=='Temporary(Week)' && count=='0'){
										cateValue='Permanent(Month)';
										catetypeVal='P';
										count++;
									} 
									if(cateValue=='Permanent(Month)' && count=='0'){
										cateValue='Temporary(Week)';
										catetypeVal='T';
										count++;
									}
									selectValue='';
								}
								trHTML+='<option '+selectValue+' value='+catetypeVal+'>'+cateValue+'</option>';
							}
							}
							else{
								trHTML+='<option value="T">Temporary(Week)</option>';
								trHTML+='<option value="P">Permanent(Month)</option>';
							}	
							trHTML+='</select>';
							trHTML+='</td>';
							
							trHTML+='<td>';
							trHTML+='<input type="text" '+approvalFlagDiasable+' name="duration" id="duration'+min+'" value="'+duration+'" onblur="return generateNextDate(this);" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control" readonly> </td>';
							trHTML+='</td>';
							
							trHTML+='<td>';
							trHTML+='<div class="dateHolder">';
							trHTML+=' <input type="text" '+approvalFlagDiasable+' id="categoryDate'+min+'" ';
							trHTML+=' name="categoryDate" class="noFuture_date5 form-control" ';
							trHTML+=' placeholder="DD/MM/YYYY" value="'+fitCatDate+'" maxlength="10" readonly/>';
							trHTML+='  </div>';
							trHTML+='  </td>';
							
							trHTML+='<td>';
							trHTML+='   <div class="dateHolder">';
							trHTML+=' <input type="text" '+approvalFlagDiasable+' id="nextcategoryDate'+min+'" name="nextcategoryDate" class="form-control" placeholder="DD/MM/YYYY" value="'+nextCategoryDate+'" maxlength="10"/>';
							trHTML+=' </div>';
							trHTML+='  </td>';
							trHTML+='<td style="display: none";><input type="hidden" value="'+diagnosisId+'" tabindex="1" id="diagnosisIdval'+min+'" size="77" name="diagnosisIdval" /></td>';
							trHTML+='<td style="display: none";><input type="hidden" tabindex="1" id="medicalCategoryIdval'+min+'" value="'+medicalCategoryId+'" size="77"name="medicalCategoryIdval" /></td>';
							trHTML+='<td style="display: none";><input type="hidden" tabindex="1" id="categoryIdval" size="77" value="'+patientMedicalCategoryId+'" name="categoryIdval" /></td>';
							trHTML+='<td><button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForMedicalCategoryNewDiagnosis();"></button></td>';
							trHTML+='<td><button type="button" name="delete" value=""  class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"  onclick="removeRowMedicalCategoryNew(this)" disabled></button></td>';
							trHTML+='<td style="display: none";><input type="hidden" value="" tabindex="1" id="patientCategoryFId'+i+'" size="77"name=" patientCategoryFId" /></td>';
							trHTML+='<td style="display: none";><input type="hidden" value="'+fitFlag+'" tabindex="1" id="fitFlag'+i+'" size="77" name="fitFlag" /></td></tr>';
							/* trHTML+=' <td>';
							trHTML+='<button type="button" '+approvalFlagDiasable+' type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForMedicalCategory();"></button>';
							trHTML+=' </td>';
							trHTML+=' <td>';
							trHTML+=' <button type="button" name="delete" value="" '+diasableValue+' class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"  onclick="removeRowMedicalCategory(this)"></button>';
							trHTML+=' </td>';	 */
						min++;
						}
			    	   }
					});
				}
				 
				if(trHTML!="" && trHTML!=null && countForSystem!=0){
					$("#medicalCategoryNew tr").remove();
					$('#medicalCategoryNew').append(trHTML);
				}
			
			 	
				}
    });
	}
	
function masMedicalCategoryforFitCat(item) {
 	
    var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";

    var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/getMedicalBoardAutocomplete";
    var countMedCat=0;
    var fitCheckId=idforTreat= $(item).closest('tr').find("td:eq(0)").find(":input").attr("id");
    var fitCheckVal=idforTreat= $(item).closest('tr').find("td:eq(0)").find(":input").val();
    var fitCheckValue=idforTreat= $(item).closest('tr').find("td:eq(14)").find(":input").val();
    var ischecked= $(fitCheckVal).is(':checked');
     
   if ($(item).closest('tr').find("td:eq(0)").find(":input").is(":checked")) {
   	 var medicalCopositeName=$('#medicalCompositeName').val();
   	 
   	 $('#medicalCategoryNew tr').each(function(i, el) {
			var $tds = $(this).find('td')	

			 var icdName = $tds.eq(1).find(":input").val();
			 if(icdName!=""){
				countMedCat=+1; 
			 }
   	 });
   	
    }
   else
    {
	   var clearValue='';
	   $(item).closest('tr').find("td:eq(14)").find(":input").val(clearValue);
	  
	 } 
     
    if ($(item).closest('tr').find("td:eq(0)").find(":input").is(":checked")) {
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: url,
        data: JSON.stringify({
            'employeeId': '1'
        }),
        dataType: 'json',
        //timeout: 100000,

        success: function(res)

        {
           var mcDataList = res.masMedicalCategoryList;
       	var  msgForFit=resourceJSON.msgForFitIn;
        	if(mcData!=null && mcDataList.length!=0)
            for (var i = 0; i < mcDataList.length; i++) {
                var mcId = mcDataList[i].medicalCategoryId;
                var mcCode = mcDataList[i].medicalCategoryCode;
                var mcName = mcDataList[i].medicalCategoryName;
                var mcFitFlag = mcDataList[i].fitFlag;
                
               if(mcFitFlag=='F'){
					var finalObservationForCategory='';
					if(mcName!=""){
						 /* var selectCategory= "";
						 if(masmedicalCategoryList!=null && masmedicalCategoryList.length!=0)
							 for (var j = 0; j < masmedicalCategoryList.length; j++) {
								 if (mcId == masmedicalCategoryList[j].medicalCategoryId) {
									 selectCategory = 'selected';
									 $(item).closest('tr').find("td:eq(2)").find("select:eq(0)").val(mcId);
									} 
								
								} */
						
					finalObservationForCategory+=msgForFit+" "+" Med Cat " +mcName ;
					$(item).closest('tr').find("td:eq(2)").find(":selected").text(mcName).val(mcId);
					$(item).closest('tr').find("td:eq(9)").find(":input").val(mcId);
					$(item).closest('tr').find("td:eq(14)").find(":input").val('F');
					
					$(item).closest('tr').find("td:eq(1)").find("textarea:eq(0)").attr("readonly","true");
					$(item).closest('tr').find("td:eq(2)").find("select:eq(0)").attr("disabled","true");
					$(item).closest('tr').find("td:eq(3)").find("select:eq(0)").attr("disabled","true");
					$(item).closest('tr').find("td:eq(4)").find("select:eq(0)").attr("disabled","true");
					$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("readonly","true");
					$(item).closest('tr').find("td:eq(7)").find("input:eq(0)").attr("readonly","true");
					
					
					}
               }
               
            }
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
    else
    {
	   var clearValue='';
	   $(item).closest('tr').find("td:eq(14)").find(":input").val(clearValue);
	   $(item).closest('tr').find("td:eq(1)").find("textarea:eq(0)").removeAttr("readonly");
		$(item).closest('tr').find("td:eq(2)").find("select:eq(0)").removeAttr("disabled");
		$(item).closest('tr').find("td:eq(3)").find("select:eq(0)").removeAttr("disabled");
		$(item).closest('tr').find("td:eq(4)").find("select:eq(0)").removeAttr("disabled");
		$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").removeAttr("readonly");
		$(item).closest('tr').find("td:eq(7)").find("input:eq(0)").removeAttr("readonly");
	 }
   
}

function getDateOfOrigin(item){
	 var dateOfOrigin=$(item).closest('tr').find("td:eq(1)").find("input:eq(0)").val();
	 var diagnosisVal=$(item).closest('tr').find("td:eq(3)").find("input:eq(0)").val();
	 $('#medicalCategoryNew tr').each(function(i, el) {
			var $tds = $(this).find('td')	
			 var icdNameVal = $tds.eq(8).find(":input").val();
			if(diagnosisVal==icdNameVal)
			{
	
				$tds.eq(15).find(":input").val(dateOfOrigin);
			}
	 });
}

function getPlaceOfOrigin(item){
	 var placeOfOrigin=$(item).closest('tr').find("td:eq(2)").find("input:eq(0)").val();
	 var diagnosisVal=$(item).closest('tr').find("td:eq(3)").find("input:eq(0)").val();
	
	 $('#medicalCategoryNew tr').each(function(i, el) {
			var $tds = $(this).find('td')	
			 var icdNameVal = $tds.eq(8).find(":input").val();
			if(diagnosisVal==icdNameVal)
			{
	
				$tds.eq(16).find(":input").val(placeOfOrigin);
			}
	 });
}
   
  </script>
</body>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
</html>
