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
                                <title>AFMSM-15</title>
                                <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
                                <meta content="Coderthemes" name="author" />
                                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                                <!-- <link href="//resources/css/icons1.css" rel="stylesheet" type="text/css" /> -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/medicalBoard.js"></script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autoPopulate.js"></script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/commonformodal.js"></script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/uploaddig.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/commonformodal.js"></script>
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
                     </head>

                            <body>
                                <div id="wrapper">

                                        <div class="content-page">
                                            <!-- Start content -->
                                            <div class="col-md-4">
                                                <div id="successmsg" style="color:green; align:center;">
                                                    ${message}
                                                </div>
                                            </div>
                                            <div class="">

                                                <div class="container-fluid">
                                                <form:form name="amsfForm15Data" id="amsfForm15Data" method="post" enctype='multipart/form-data'
											action="#" autocomplete="on">
                                                    <div class="internal_Htext">AFMSM-15 (Data Upload)</div>
										<input type="hidden" name="rankForDigi" id="rankForDigi" value="" />
									<input type="hidden" name="unitshipDigi" id="unitshipDigi" value="" />
									<input type="hidden" name="branchTradDigi" id="branchTradDigi" value="" />	
									<input type="hidden" name="resultIdMedicalDocs" id="resultIdMedicalDocs" />
									<input type="hidden" name="totalLengthDigiFileSupportDoc" id="totalLengthDigiFileSupportDoc" value="0" />	
									<input type="hidden" name="hospitalIdForDigi" id="hospitalIdForDigi" value="" />
									<input type="hidden" name="hospitalForDigi" id="hospitalForDigi" value="<%=hospitalId%>" />
                                                    <div class="row">
                                                        <div class="col-12">
                                                            <div class="card">
                                                                <div class="card-body">
                                                                 <div class="row m-b-30">
													<div class="col-md-3">
														<a href="#" onClick="return showEHRRecords();" class="btn btn-primary btn-block">EHR</a>
													</div>
													<div class="col-md-3">
														<a href="javascript:void(0)"  onClick="return getCompleteMedicalExamMEOrMB('ALL','SearchStatusForUnitAdmin','me');" class="btn btn-primary btn-block">Previous Medical Exams</a>
													</div>
													<div class="col-md-3">
														<a href="javascript:void(0)"   onClick="return getCompleteMedicalExamMEOrMB('ALL','SearchStatusForUnitAdmin','mb');"  class="btn btn-primary btn-block">Previous Medical Boards</a>
													</div>
													<div class="col-md-3">
														<a href="javascript:void(0)" onClick="return showImmunizationTemplateMe('aa');"  class="btn btn-primary btn-block">Immunizations</a>
													</div>
												</div>
                                                                   
								    <input type="hidden" name="visitId" id="visitId" value=""/>
									<input type="hidden" name="hospitalId" id="hospitalId" value="<%=hospitalId%>"/>
									<input type="hidden" name="userId" id="userId" value="<%=userId%>"/>
									<input type="hidden" name="patientId" id="patientId" value=""/>	
									<input type="hidden" name="genderId" id="genderId" value=""/>	
									<input type="hidden" name="opdPatientDetailId" id="opdPatientDetailId" value=""/>	
									<input type="hidden" name="referTo" id="referTo" value="E"/>  
									<input type="hidden" name="saveInDraft" id="saveInDraft" value=""/>
									<input type="hidden"  name="checkForAuthenticationValue" value="" id="checkForAuthenticationValue" />	
									<input type="hidden"  name="uhidNumberValue" value="" id="uhidNumberValue" />
									<input type="hidden"  name="membType" value="" id="membType" />
								<!-- 	<input type="hidden" name="mainChargeCodeForFile" id="mainChargeCodeForFile" value=""/>
								    <input type="hidden" name="mainChargeCodeForFileWithChargeCode" id="mainChargeCodeForFileWithChargeCode" value=""/>
								 -->
									
                                                                   <div class="row">
                                                                        <h4 class="service_htext" style="border:none;"></h4>
                                                                        
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-5 col-form-label">Place</label>
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
																		<h6 class="font-weight-bold text-theme text-underline">14.Present Medical Category (Composite)</h6>
                                                                    <table class="table table-hover table-striped table-bordered">
											<thead class="bg-success" style="color:#fff;">
													<tr>
														<th id="th1">Medical Category</th>
														<th id="th2">Date of Category</th>
														 
													</tr>
												</thead>
												<tbody>
												  <tr>
												    <td>
												    <div class="autocomplete forTableResp">
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
																
                                                                    <div class="tablediv ">
                                                                        <h6 class="font-weight-bold text-theme text-underline">15. Details of Present and Previous Disabilities</h6>
                                                                        <div class="table-responsive">
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
                                                                                    <th id="th2">Date Of Origin</th>
                                                                                    <th id="th2">Place Of Origin</th>
                                                                                    <th id="th8">Add</th>
                                                                                    <th id="th8">Delete</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody id="medicalCategory">
                                                                                <tr>
                                                                                  <td>
                                                                                        <div class="form-check form-check-inline cusCheck m-l-5">
                                                                                            <input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1" checked>
                                                                                            <span class="cus-checkbtn"></span> 
                                                                                         </div>
                                                                                    </td>
                                                                                    <td>
                                                                                       <!--  <div class="autocomplete forTableResp">
                                                                                        <textarea class="form-control width150" id="diagnosisId" value=" " onblur="fillDiagnosisCombo(this.value,this);" placeholder="Diagnosis"></textarea> -->
                                                                                           <div class="autocomplete forTableResp">
                                                                  							 <textarea class="form-control width150" id="diagnosisId" value=" " onKeyUp="getNomenClatureList(this,'fillDiagnosisComboMb','opd','getIcdListByName','diagnosisMe');" placeholder="Diagnosis"></textarea>
                                                                  							<div id="diagnosisMeDiv" class="autocomplete-itemsNew"></div>
                                                                                          </div>
                                                                                         </td>
                                                                                        <td>
                                                                                     <div class="autocomplete forTableResp">
                                                                                        <input type="text" id="medicalCategoryId" onKeyUp="getNomenClatureList(this,'fillMedicalCategoryData','medicalBoard','getMedicalBoardAutocomplete','compositeCategory');" class="form-control width120">
                                                                                      <div id="medicalBoardMbDiv" class="autocomplete-itemsNew"></div>
                                                                                      </div>  
                                                                                    </td>
                                                                                    <td>
                                                                					<select class="form-control width80" name=system id="system" >
                                                               							 <option value="0">Select</option>
																						 <option value="S">S</option>
																						<option value="H">H</option>
																						<option value="A">A</option>
																						<option value="P">P</option>
																						<option value="E">E</option>
                                                                                  </select>
                                                               						</td>
                                                                                    
                                                                                    <td>
                                                                                       <select class="form-control width120" name=typeOfCategory id="typeOfCategory" onChange="getdurationByType(this);">
																							<option value="0">Select</option>
																							<option value="T">Temporary</option>
																							<option value="P">Permanent</option>
																				    	</select>
                                                                                     
                                                                                    </td>
                                                                                     <td>
                                                                                        <input type="text" name="duration" id="duration" onblur="return generateNextDate(this);" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control">
                                                                                     </td>
                                                                                    <td>
                                                                                       <div class="dateHolder width100">
																	                    <input type="text" id="diagnosisDate" 
																	                     name="diagnosisDatesssss" class="noFuture_date5 form-control " 
																	                     placeholder="DD/MM/YYYY" value="" maxlength="10" />
																	                    </div>
                                                                                    </td>
                                                                                   
                                                                                    <td>
                                                                                         <div class="dateHolder width110">
																	                    <input type="text" id="nextDiagnosisDate" name="nextDiagnosisDatess" class="input_date form-control " placeholder="DD/MM/YYYY" value="" maxlength="10" />
																	                    </div>
                                                                                       </td>
                                                                                      <td style="display: none";><input type="hidden"
																						value="" tabindex="1" id="diagnosisIdval" size="77"
																						name="diagnosisIdval" />
																					</td>
																					 <td style="display: none";><input type="hidden"
																						value="" tabindex="1" id="medicalCategoryIdval" size="77"
																						name="medicalCategoryIdval" />
																					</td> 
																					 <td>
                                                                                         <div class="dateHolder width110">
																	                    <input type="text" id="dateOfOriginnn" name="dateOfOrigin" onChange="return getDateOfOrigin(this);" class="input_date form-control " placeholder="DD/MM/YYYY" value="" maxlength="10" />
																	                    </div>
                                                                                       </td>
                                                                                    
                                                                                      <td>
                                                                                        <input type="text" class="form-control width100" name="placeOfOrigin" onblur="getPlaceOfOrigin(this);" id="placeOfOrigin"  class="form-control">
                                                                                       </td>
                                                                                    <td>
                                                                                   <button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForMedicalCategory();"></button>
                                                                                     </td>
																                  <td>
																	                 <button type="button" name="delete" value=""  class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"  onclick="removeRowMedicalCategory(this)"></button>
																                 </td>
																                 <td style="display: none";><input type="hidden" id="diagnosisiIdMCaaa" name="diagnosisiIdMC" value=" "/>
	 						                                                     </td> 
	 							                                                <td style="display: none";><input type="hidden" value="" tabindex="1" id="patientMedicalCategoryId" size="77" name="patientMedicalCategoryId" readonly />
	 						                                                   </td>
	 							                                                <td> <input type="hidden" value="" tabindex="1" id="fitFlag" size="77" name="fitFlag" readonly />
	 							                    						   </td> 
                                                                                </tr>
                                                                 
                                                                            </tbody>
                                                                        </table>
                                                                        </div>
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
                                                
                                                 <div class="col-md-3">
                                                 	<textarea class="form-control" rows="3" name="disablityAttrServiceRemark" id="disablityAttrServiceRemark" ></textarea>
                                                 </div>
                                             </div>
                                         </div>
									</div>
									
									<div class="row m-t-10">
										 <div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">18. If not directly attributable to service, was it aggravated by service? (Y/N)</label>
                                                
                                                 <div class="col-md-3">
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
                                                                                    <th id="th7" style="width: 80px;">Duration<br/> (P&#8594;Month) <br/> (T&#8594;Week) </th>
                                                                                    <th id="th6">Category Date</th>
                                                                                    <th id="th8">Next Category Date </th>
                                                                                    <th id="th8">Add</th>
                                                                                    <th id="th8">Delete</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody id="medicalCategoryNew">
                                                                                <tr>
                                                                                  <td>
                                                                                        <div class="form-check form-check-inline cusCheck m-l-5">
                                                                                            <input class="form-check-input" type="checkbox" id="fitInChk" onclick="return masMedicalCategoryforFitCatNew(this);" value="option1"/>
                                                                                            <span class="cus-checkbtn"></span> 
                                                                                         </div>
                                                                                    </td>
                                                                                    <td>
                                                                                       <!--  <div class="autocomplete forTableResp">
                                                                                        <textarea class="form-control" id="diagnosisIdNew" value=" " onblur="fillDiagnosisCombo(this.value,this);" placeholder="Diagnosis"></textarea>
                                                                                        </div> -->
                                                                                        <div class="autocomplete forTableResp">
                                                                  							 <textarea class="form-control" id="diagnosisIdNew" value=" " onKeyUp="getNomenClatureList(this,'fillDiagnosisComboMb','opd','getIcdListByName','diagnosisMe');" placeholder="Diagnosis"></textarea>
                                                                  							<div id="diagnosisMeDiv" class="autocomplete-itemsNew"></div>
                                                                                          </div>
                                                                                         </td>
                                                                                        <td>
                                                                                     <div class="autocomplete  forTableResp">
                                                                                        <input type="text" id="medicalCategoryIdNew" onKeyUp="getNomenClatureList(this,'fillMedicalCategoryDataNew','medicalBoard','getMedicalBoardAutocomplete','compositeCategory');" class="form-control width120">
                                                                                      <div id="medicalBoardMbDivNew" class="autocomplete-itemsNew"></div>
                                                                                      </div>  
                                                                                    </td>
                                                                                    <td>
                                                                  <!-- <input type="text" name="system" maxlength="1" id="system"class="form-control" value=""/> --> 
                                                                					<select class="form-control" name=system id="systemNew" >
                                                               							 <option value="0">Select</option>
																						 <option value="S">S</option>
																						<option value="H">H</option>
																						<option value="A">A</option>
																						<option value="P">P</option>
																						<option value="E">E</option>
                                                                                  </select>
                                                               						</td>
                                                                                    
                                                                                    <td>
                                                                                       <select class="form-control width120" name="typeOfCategoryNew" id="typeOfCategoryNew" onChange="getdurationByType(this);">
																							<option value="0">Select</option>
																							<option value="T">Temporary</option>
																							<option value="P">Permanent</option>
																				    	</select>
                                                                                     
                                                                                    </td>
                                                                                     <td>
                                                                                        <input type="text" name="durationNew" id="durationNew" onblur="return generateNextDate(this);" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control">
                                                                                     </td>
                                                                                    <td>
                                                                                       <div class="dateHolder width100">
																	                    <input type="text" id="diagnosisDateNew" 
																	                     name="diagnosisDatesssss" class="noFuture_date5New form-control" 
																	                     placeholder="DD/MM/YYYY" value="" maxlength="10" />
																	                    </div>
                                                                                    </td>
                                                                                   
                                                                                    <td>
                                                                                         <div class="dateHolder width100">
																	                    <input type="text" id="nextDiagnosisDateNew" name="nextDiagnosisDatessNew" class="input_date form-control " placeholder="DD/MM/YYYY" value="" maxlength="10" />
																	                    </div>
                                                                                       </td>
                                                                                      <td style="display: none";><input type="hidden"
																						value="" tabindex="1" id="diagnosisIdval" size="77"
																						name="diagnosisIdval" />
																					</td>
																					 <td style="display: none";><input type="hidden"
																						value="" tabindex="1" id="medicalCategoryIdvalNew" size="77"
																						name="medicalCategoryIdval" />
																					</td> 
																				     <td style="display: none";>
                                                                                        <input type="hidden" id="newDateOfOrigin" name="newDateOfOrigin" class="input_date form-control " value="" maxlength="10" />
																	                 </td>
                                                                                    
                                                                                      <td style="display: none";>
                                                                                        <input type="hidden" class="form-control width100" name="newPlaceOfOrigin"  id="newPlaceOfOrigin"  class="form-control">
                                                                                       </td>
                                                                                    <td>
                                                                                   <button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForMedicalCategoryNew();"></button>
                                                                                     </td>
																                  <td>
																	                 <button type="button" name="delete" value=""  class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"  onclick="removeRowMedicalCategoryNew(this)"></button>
																                 </td>
																                  <td style="display: none";><input type="hidden" id="diagnosisiIdMCaaa" name="diagnosisiIdMC" value=" "/>
	 						                                                     </td> 
	 							                                                <td style="display: none";><input type="hidden" value="" tabindex="1" id="patientMedicalCategoryId" size="77" name="patientMedicalCategoryId" readonly />
	 						                                                   </td>
																                 <td style="display: none";>
									                                              <input type="hidden" value="" tabindex="1" id="fitFlag" size="77" name="fitFlag" readonly />
									                                              </td>
									
                                                                                </tr>
                                                                 
                                                                            </tbody>
                                                                        </table>
                                                            <!--  <div class="opdMain_detail_area" >
															<h4 class="service_htext">Fit Category</h4>
		
															<div class="row">
																
																<div class="col-md-12">
																	<div class="form-group ">
																		<div class="form-check form-check-inline cusCheck">
																		  <input class="form-check-input" type="checkbox" id="fitInChk" onclick="return masMedicalCategoryListForDigi(this);">
																		  <span class="cus-checkbtn"></span>
																		  <label class="col-form-label" for="fitInChk">Fit Category</label>
																		</div>
																	</div>
																</div>
																<div class="col-md-4">
																	<div class="form-group row">
																		<div class="col-md-6">
																			<label class="col-form-label">Diagnosis Name</label>
																		</div>
																		<div class="col-md-6">
																				<textarea class="form-control" id="diagnosisIdFitCat" value=" " placeholder="Diagnosis"></textarea>
																		</div>
																	</div>
																</div>
															<div class="col-md-4">
																	<div class="form-group row">
																		<div class="col-md-6">
																			<label class="col-form-label">Date</label>
																		</div>
																		<div class="col-md-6">
																			<div class="dateHolder">
																				<input type="text" name="apporvingDate" id="apporvingDate" class="form-control calDate"/>
																			</div>
																			
																		</div>
																	</div>
																</div>	
															</div>
		
														</div>   -->         
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
												    	<input id="recommedicalCompositeName" type="text" class="form-control" onKeyUp="getNomenClatureList(this,'recomfillMedicalComposite','medicalBoard','getMedicalBoardAutocomplete','compositeCategory');" class="form-control width120">
                                                          <div id="medicalBoardMbDivRecommended" class="autocomplete-itemsNew"></div>
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
                                                 	<input type="text" class="form-control" name="previousDisablement" id="previousDisablement" value="N/A" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"/>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">(b) Present Disablement %</label>
                                                 
                                                 <div class="col-md-3">
                                                 	<input type="text" class="form-control" name="presentDisablement" id="presentDisablement" value="N/A" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"/>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">(c) Reasons for various if any</label>
                                                 
                                                 <div class="col-md-3">
                                                 	<textarea class="form-control" rows="3" name="reasonForVarious"  id="reasonForVarious">N/A</textarea>
                                                 </div>
                                             </div>
                                         </div>
									</div>
									
									<div class="row m-t-10">
										<div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">21.Any specific restriction regarding employment</label>
                                                 
                                                 <div class="col-md-3">
                                                 	<input type="text" class="form-control" name="restrictionRegardingEmp" id="restrictionRegardingEmp" />
                                                 </div>
                                             </div>
                                         </div>
									</div>
									
									<div class="row m-t-10">
										<div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">22.Instructions given to the individual by the president of the board</label>
                                                 
                                                 <div class="col-md-6">
                                                 	<textarea class="form-control" rows="3" name="instructionRemark" id="instructionRemark"></textarea>
                                                 </div>
                                             </div>
                                         </div>
									</div>
									
									<div class="row m-t-10">
										<div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">Note:</label>
                                                 
                                                 <div class="col-md-6">
                                                 	<textarea class="form-control" rows="3" name="instructionNote" id="instructionNote"></textarea>
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
                                               		<input type="text" class="form-control" name="member1Name" id="member1Name"/>
                                                 </div>
                                                 <div class="col-md-3">
                                               		<input type="text" class="form-control" name="mem1Rank" id="mem1Rank"/>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">Member 2</label>
                                                 
                                                 <div class="col-md-3">
                                               		<input type="text" class="form-control" name="member2Name" id="member2Name"/>
                                                 </div>
                                                 <div class="col-md-3">
                                               		<input type="text" class="form-control" name="mem2Rank" id="mem2Rank"/>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-md-12">
                                             <div class="form-group row">
                                                 <label class="col-md-3 col-form-label">President</label>
                                                 
                                                 <div class="col-md-3">
                                               		<input type="text" class="form-control" name="member3Name" id="member3Name"/>
                                                 </div>
                                                 <div class="col-md-3">
                                               		<input type="text" class="form-control" name="mem3Rank" id="mem3Rank"/>
                                                 </div>
                                             </div>
                                         </div>                                         
									</div>
									<div class="row m-t-10">
										<div class="col-12">
										<h6 class="text-theme text-underline font-weight-bold">Approving Authority</h6>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Name</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="aaName" name="aaName"/>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Rank &amp; Designation</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="aaRank" name="aaRank"/>
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
													<input type="text" class="form-control" id="aaPlace" name="aaPlace"/>
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
									
									<div class="row m-t-10">
										<div class="col-12">
										<h6 class="text-theme text-underline font-weight-bold">Perusing Authority</h6>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Name</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="paName" name="paName"/>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Rank &amp; Designation</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="paRank" name="paRank"/>
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
													<input type="text" class="form-control" id="paPlace" name="paPlace"/>
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
									<!-- <div class="row" id="reasonPending" style="display:none;">
												<div class="col-md-12">
													<div class="form-group row">
														<div class="col-md-3">
															<label for="service" class="col-form-label">Reason for Pending</label>
														</div>
														<div class="col-md-6">
															<textarea class="form-control" id="pendingRemarks" name="remarksPending" rows="2" readonly></textarea>
														</div>
													</div>
												</div>
									</div> -->
									
										<div class="w-100"></div>
														
														<div class="row m-t-10">
														<div class="col-12">
														<h6 class="text-theme text-underline font-weight-bold">Medical Board File Upload<span class="mandate">(File name should not contain any special characters and should be jpg,pdf,jpeg,gif,png only!)</span></h6>
														</div>
														
														<div class="col-md-6">
															<div class="form-group row">
																<label class="col-md-6 col-form-label">Upload File </label>
																<div class="col-md-6" id="uploadFileMedicalExam">
																<div class="fileUploadDiv">
																	<input type="file" name="medicalBoardFileUpload" id="medicalBoardFileUpload"class="inputUpload" />
																	<label class="inputUploadlabel">Choose File</label>
																	<span class="inputUploadFileName">No File Chosen</span>
																</div>
																</div>																
															</div>
														     
														</div>
														<div class="col-md-3">														
														<div style="display: none" class="col-md-7" id="viewUploadedFile"></div>
														</div>
														
														<div class="w-100"></div>
														<div class="col-md-4" style="display: none" id="actionForVerified">
														<div class="form-group row">
															<div class="col-md-5">
																<label for="service" class="col-form-label">Action</label>
															</div>
															<div class="col-md-7">
																<select class="form-control" name="actionDigiFile" id="actionDigiFile"
																	name="actionMe" >
																	<option value="0">Select</option>
																	<option   value="ev">Approve</option>
																	<option   value="vr">Reject</option>
																</select>

															</div>
														</div>
													
														</div>

													<div class="col-md-4" style="display: none"  id="actionDigiForApproved">
														<div class="form-group row">
															<div class="col-md-5">
																<label for="service" class="col-form-label">Action</label>
															</div>
															<div class="col-md-7">
																<select class="form-control" name="actionDigiFileApproved" id="actionDigiFileApproved"
																	name="actionMe" >
																	<option value="0">Select</option>
																	<option   value="ea">Approve</option>
																	<option   value="ar">Reject</option>
																</select>

															</div>
														</div>
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
																		<th>Upload/View File<span class="mandate">(File name should not contain any special characters and should be jpg,pdf,jpeg,gif,png only!)</span></th>
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
																			<a class="btn-link" href="Javascript:Void(0)" onclick="openResultModelMedicalDocs(this);">View/Enter Result</a>
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
													
													
									<div class="opdMain_detail_area"  style="display:none" id="finalObservationDigiMo">
											
											<h4  class="service_htext">Final Observation And Remark Of Verifier</h4>
											
											<div class="row">
											<div class="col-md-8">
												<div class="form-group row">
													<div class="col-md-3">
														<label for="service" class="col-form-label">Final Observation</label>
													</div>
													<div class="col-md-9">
														<textarea  name="finalObservationMo" id="finalObservationMo" class="form-control"  ></textarea> 
														<!--  <div id="finalObservationMoJ">
														</div>
													 <input type="hidden" name="finalObservationMo" id="finalObservationMo" value=""/>  
														 -->
														
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-6">
														<label for="service" class="col-form-label">Signed By</label>
													</div>
													<div class="col-md-6">
														<input type="text" name="signedByMo" id="signedByMo"class="form-control" disabled/>
													</div>
												</div>
											</div>
											</div>
										</div>
									
									
										<div class="opdMain_detail_area"  style="display:none" id="finalObservationDigiRMo">
											
											<h4  class="service_htext">Final Observation And Remark Of Approval</h4>
											
											<div class="row">
											<div class="col-md-8">
												<div class="form-group row">
													<div class="col-md-3">
														<label for="service" class="col-form-label">Final Observation</label>
													</div>
													<div class="col-md-9">
														<textarea  name="finalObservationRMo" id="finalObservationRMo" class="form-control"></textarea> 
														<!--  <div id="finalObservationMoJ">
														</div>
													 <input type="hidden" name="finalObservationRMo" id="finalObservationMo" value=""/>  
														 -->
														
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-6">
														<label for="service" class="col-form-label">Signed By</label>
													</div>
													<div class="col-md-6">
														<input type="text" name="signedByRMo" id="signedByRMo"class="form-control" disabled/>
													</div>
												</div>
											</div>
											</div>
										</div>		
										
										
										
										
										<!-- <div class="col-12 text-right">
											
											 <input type="button" id="saveEntryForma" class="btn btn-primary" onClick="return saveEntryForm15('es');" value="Save"/> 
											<input type="button" value="Employability Restrictions CheckList" tabindex="1" class="btn btn-primary"
																data-toggle="modal" data-target="#exampleModal" data-backdrop="static"
															onclick="checkListOpen();">			
											<input type="button" id="clicked" class="btn btn-primary"
															value="Submit"/>				
											<input type="button" id="reset" class="btn btn-danger" onclick=""
															value="Reset"/>		
										 
										</div> -->
										
										<div class="col-12 text-right m-t-10">
												<input type="button" value="Employability Restrictions CheckList" class="btn btn-primary"
																	data-toggle="modal" data-target="#exampleModal" data-backdrop="static"
																onclick="checkListOpen();">
												<input type="button" value="Enter Specialist Opinion" class="btn btn-primary" onclick="specialistOpinionOpen()">	
											</div>
										<div class="row m-t-20" id="saveOfSubmitDigiFile">
											
											<div class="w-100"></div>
											<div class="col-12 text-right">
												<!-- <input type="button" id="saveEntryForma" class="btn btn-primary" onClick="return saveEntryForm15('et');" value="Save"/> -->
												<input type="button" id="submitEntryForma" class="btn btn-primary" onClick="return saveEntryForm15('es');" value="Submit"/>
												<!-- <input type="button" id="reset" class="btn btn-danger" onClick="document.location.reload(true);" value="Reset"/> -->		
											 
											</div>
										</div>
									
									<div class="row m-t-20" style="display: none" id="verifiedButton">
										
										<div class="col-12 text-right">
											
											<input type="button" id="submitEntryForma" class="btn btn-primary" onClick="return saveEntryForm15('ev');" value="Submit"/>
											<input type="button" id="reset" class="btn btn-danger" onClick="document.location.reload(true);" value="Reset"/>		
										 
										</div>
									</div>
									
								<div class="row m-t-20" style="display: none" id="approvedButton">
										<div class="col-12 text-right">
											
											<input type="button" id="submitEntryForma" class="btn btn-primary" onClick="return saveEntryForm15('ea');" value="Submit"/>
											<input type="button" id="reset" class="btn btn-danger" onClick="document.location.reload(true);" value="Reset"/>		
										 
										</div>
									</div>
									
								</div>
								
 								
								</div>
							</div>
						</div>
					 
					</div>

				</div>
				<!-- container -->
             </form:form>
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

<div class="modal" id="fileUploadModal" role="dialog">
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
						<div class="form-group row" id="messageForAuthenticateMessae"></div>

						<div class="row">
								 
								

								<div class="col-12">
									<div class="form-group row">
										<label class="col-md-5 col-form-label">Medical Board Documents</label>
										<div class="col-12">
										<div class="scrollDiv400">
										<div id="editorOfUpload"></div>
										</div>
										</div>
									</div>
								</div>

						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary"
						onClick="saveMedicalBoardInText();"  aria-hidden="true">
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
 

<!-- <div class="modal-backdrop show" style="display: none;"></div>	 -->		
		</div>

		<!-- ============================================================== -->
		<!-- End Right content here -->
		<!-- ============================================================== -->

	<!-- END wrapper -->
	<script>
$(function(){
	
	$("#editorOfUpload").jqte();
	
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
    if (data.data[0].medicalCategogyName != null) {
        document.getElementById('medicalCompositeName').value = data.data[0].medicalCategogyName;
    }
    if (data.data[0].medicalCategogyDate != null) {
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
        document.getElementById('service').value = data.data[0].totalService;
    }
    
    getMbAMSF15DetailsforValidate();
    masMedicalCategoryList();
    getMBPreAssesDetailsData();
    //getMBPreAssesDetailsInvestigationData();
    getDocumentListMb();
    getSpecialistList();
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
		var pathname = window.location.pathname;
	     var accessGroup = "MMUWeb";
		 var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/newMbCheckListAMSFForm15";
		 
		 var Id= $('#visitId').val();
		//window.location.href ="mbCheckListAMSFForm15?visitId="+Id+"";
		 $('#exampleModal .modal-body').load(""+url+"?visitId="+Id+"");
         $('#exampleModal .modal-title').text('Employability Restrictions Upload');
	}
	function getSpecialistOpinionOpen()
    {
	    var Id= $('#visitId').val();
		//window.location.href ="mbCheckListAMSFForm15?visitId="+Id+"";
		var pathname = window.location.pathname;
        var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/digifileupload/mbSpecialistOpinionDetails?visitId="+Id+"";
		 $('#exampleModal .modal-body').load(url);
         $('#exampleModal .modal-title').text('Specialist Doctor for Opinion and Medical Board');
	}
	
	function saveEntryForm15(flagforSubmit)
	{
        ////////////////Document Upload File Extension Validation/////////////////
		 var count=0;
		 $('#medicalBoardDocs tr').each(function(ij, el) {
		 		var fileNameValueIDd= $(this).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id"); 
				 	 
		 		var fileNameValue=$('#'+fileNameValueIDd).val();
		 		if(fileNameValue!="" && fileNameValue!=undefined)
				var filenameWithExtension=getFilenameAndReplcePath(fileNameValue);
				if(filenameWithExtension!="" && filenameWithExtension!=null && validateFileExtension(filenameWithExtension, "valid_msg", "Only pdf/image files are allowed ",
					      new Array("jpg","pdf","jpeg","gif","png","PNG","JPEG","JPG","GIF")) == false)
					      {
							count++;
					 		return false;
					      }
		 		
				});
		 
		       var medicalBoardDocs=document.getElementById('medicalBoardFileUpload').value;
		       var filenameWithExtensionMbDocument=getFilenameAndReplcePath(medicalBoardDocs);
		       if(filenameWithExtensionMbDocument!="" && filenameWithExtensionMbDocument!=null && validateFileExtension(filenameWithExtensionMbDocument, "valid_msg", "Only pdf/image files are allowed ",
					      new Array("jpg","pdf","jpeg","gif","png","PNG","JPEG","JPG","GIF")) == false)
					      {
							count++;
					 		return false;
					      }
		 	 
		 	if(count>0){
		 		alert("Please upload valid file.");
		 	}
		 	
	   var pathname = window.location.pathname;
         var accessGroup = "MMUWeb";

         var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/saveAmsfForm15Details";
         
         if(document.getElementById('signDate').value == "")
 		{
 			alert("Please enter medical board date");
             document.getElementById('signDate').focus(); 
             return false;
 		}
         /////////////////Mandatory Filed ///////////////////////////
         if( $('#disablityAttrService').val()==0)
         {
        	 alert("Please Select Is the disability Attributable to service");
        	 return false;
         }	 
         
         if( $('#directlyAttrService').val()==0)
         {
        	 alert("Please Select If not directly attributable to service, was it aggravated by service");
        	 return false;
         }
         
         if( $('#actionDigiFileApproved').val()==0)
        {
        	 
        } 
         
         //////////////////////////Medical Docs Validation Part ////////////////////////////////
       	var  idformedicalDoc='';
      	$('#medicalBoardDocs tr').each(function(i, el) {
      	 idformedicalDoc= $(this).find("td:eq(0)").find("input:eq(0)").attr("id"); 
	 			var $tds = $(this).find('td')
 	    		var medicalDType= $tds.eq(0).find(":input").val();
 	   			var medicalDValue = $tds.eq(1).find(":input").val();
 	   		   var medicalDUpload = $tds.eq(2).find(":input").val();
 	   		   var medicalDUploadValue = $tds.eq(5).find(":input").val();
 	   		if(medicalDType!= '' && medicalDType!= undefined)
		    {
 	   		   if(medicalDType== "" && medicalDType=="0" )
    			{
					alert("Please select medical type under medical board(supporting document)");
					return false;      	
				 }
 			  if(medicalDValue== "")
  			  {
					alert("Please enter value under medical board(supporting document)");
					return false;      	
			  }
 			 if(medicalDUpload== "" && medicalDUploadValue=="")
 			  {
					alert("Please upload document under medical board(supporting document)");
					return false;      	
			  }
		    }
	 			
  		 });
         
         /////////////////////// Medical Cateogry validation part ////////////////////////////
 		 
      	var  idformedicalCategory11='';
      	$('#medicalCategory tr').each(function(i, el) {
      		idformedicalCategory11= $(this).find("td:eq(1)").find("input:eq(0)").attr("id"); 
	 			var $tds = $(this).find('td')
 	    		var medicalSystem = $tds.eq(2).find(":input").val();
 	   			var medicalCategory = $tds.eq(3).find(":input").val();
 	  			var typeCategory = $tds.eq(4).find(":input").val();
 	  		    var categoryDate = $tds.eq(6).find(":input").val();
 	  		    var duration = $tds.eq(5).find(":input").val();
 	  		    var nextCategoryDate = $tds.eq(7).find(":input").val();
 	  		    var diagnosisVal = $tds.eq(8).find(":input").val();
 	  		    var fitValue = $tds.eq(16).find(":input").val();
 	  		       
 	  		    
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
					alert("Please fill Medical Category");
					medicalCategory.focus();
					return false;      	
				 }
 			if(typeCategory== "" && fitValue!="F")
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
				if(duration== "" && fitValue!="F" || duration==0 && fitValue!="F")
	    		{
 				alert("Duration should be greater than 0 under Medical Category");
 				totalNip.focus(); 
				    return false;       	
				}
 
			    }
	 			
	 			
  		 });
      	
      	 /////////////////////// Medical Cateogry New validation part ////////////////////////////
		 
      	var  idformedicalCategory33='';
      	$('#medicalCategoryNew tr').each(function(i, el) {
      		idformedicalCategory33= $(this).find("td:eq(1)").find("input:eq(0)").attr("id"); 
	 			var $tds = $(this).find('td')
 	    		var medicalSystem = $tds.eq(2).find(":input").val();
 	   			var medicalCategory = $tds.eq(9).find(":input").val();
 	  			var typeCategory = $tds.eq(4).find(":input").val();
 	  		    var categoryDate = $tds.eq(6).find(":input").val();
 	  		    var duration = $tds.eq(5).find(":input").val();
 	  		    var nextCategoryDate = $tds.eq(7).find(":input").val();
 	  		    var diagnosisVal = $tds.eq(8).find(":input").val();
 	  		    var patientFitFlag=$tds.eq(16).find(":input").val();    
 	  		    
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
					alert("Please fill Medical Category");
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
				if(duration== "" && patientFitFlag!='F' || duration==0 && patientFitFlag!='F')
	    		{
 				alert("Duration should be greater than 0 under Medical Category");
 				totalNip.focus(); 
				    return false;       	
				}
 
			    }
	 			
	 			
  		 });
        
      ////////////////////////////////////Medical Categories Screen JSON/////////////////////////
	      
	    	var idforMedicalCategoryOld='';
	    	var tableDataMedicalCategory = [];
	    	var dataMedicalCategoryJson='';
	    $('#medicalCategory tr').each(function(i, el) {
	    	idforMedicalCategoryOld= $(this).find("td:eq(1)").find("textarea:eq(0)").attr("id")
		if(document.getElementById(idforMedicalCategoryOld).value!= "" && document.getElementById(idforMedicalCategoryOld).value!= undefined)
	    {
		var $tds = $(this).find('td')
		var mCheck='';
		if ($tds.eq(0).find(":input").is(":checked")) 
		{
				var yMcheck='Y';
				mCheck=yMcheck;
		}
		else
		{
	      		var nMcheck='N';
	      		mCheck=nMcheck;
		 }
		var diagnosisId = $tds.eq(8).find(":input").val();
	  	var system = $tds.eq(3).find(":input").val();
		var medicalCategory = $tds.eq(9).find(":input").val();
		var categoryType = $tds.eq(4).find(":input").val();
		var duration = $tds.eq(5).find(":input").val();
		var categoryDate = $tds.eq(6).find(":input").val();
		var nextCategoryDate = $tds.eq(7).find(":input").val();
		var dateOfOrigin = $tds.eq(10).find(":input").val();
		var placeOfOrigin = $tds.eq(11).find(":input").val();
		var patientCategoryId=$tds.eq(15).find(":input").val();
		dataMedicalCategoryJson={
				'diagnosisId' : diagnosisId,
				'system' : system,
				'medicalCatCheck' : mCheck,
				'medicalCategory' : medicalCategory,
				'categoryType' : categoryType,
				'duration' : duration,
				'categoryDate' : categoryDate,
				'nextCategoryDate' : nextCategoryDate,
				'dateOfOrigin' :dateOfOrigin,
				'placeOfOrigin' :placeOfOrigin,
				'patientCategoryId':patientCategoryId,
			}
		tableDataMedicalCategory.push(dataMedicalCategoryJson)
	   
	   }	
	});
	    
////////////////////////////////////Medical Categories New Screen JSON/////////////////////////
	      
    	var idforMedicalCategory1='';
    	var tableDataMedicalCategory1 = [];
    	var dataMedicalCategory1='';
    $('#medicalCategoryNew tr').each(function(i, el) {
    	idforMedicalCategory1= $(this).find("td:eq(1)").find("textarea:eq(0)").attr("id")
    	var idforMedicalCategoryFit= $(this).find("td:eq(2)").find("input:eq(0)").attr("id")
	if(document.getElementById(idforMedicalCategory1).value!= "" && document.getElementById(idforMedicalCategory1).value!= undefined||document.getElementById(idforMedicalCategoryFit).value!= "" && document.getElementById(idforMedicalCategoryFit).value!= undefined)
    {
	var $tds = $(this).find('td')
	var mCheck='';
	if ($tds.eq(0).find(":input").is(":checked")) 
	{
			var yMcheck='Y';
			mCheck=yMcheck;
	}
	else
	{
      		var nMcheck='N';
      		mCheck=nMcheck;
	 }
	var diagnosisId = $tds.eq(8).find(":input").val();
  	var system = $tds.eq(3).find(":input").val();
	var medicalCategory = $tds.eq(9).find(":input").val();
	var categoryType = $tds.eq(4).find(":input").val();
	var duration = $tds.eq(5).find(":input").val();
	var categoryDate = $tds.eq(6).find(":input").val();
	var nextCategoryDate = $tds.eq(7).find(":input").val();
	var dateOfOrigin = $tds.eq(10).find(":input").val();
	var placeOfOrigin = $tds.eq(11).find(":input").val();
	var patientFitFlag=$tds.eq(16).find(":input").val();
		
	dataMedicalCategory1={
			'diagnosisId' : diagnosisId,
			'system' : system,
			'medicalCatCheck' : mCheck,
			'medicalCategory' : medicalCategory,
			'categoryType' : categoryType,
			'duration' : duration,
			'categoryDate' : categoryDate,
			'nextCategoryDate' : nextCategoryDate,
			'dateOfOrigin' :dateOfOrigin,
			'placeOfOrigin' :placeOfOrigin,
			'patientFitFlag':patientFitFlag,
			'patientCategoryFId':'',
			'patientCategoryId':'',
			
		}
	tableDataMedicalCategory1.push(dataMedicalCategory1)
   
   }	
});
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
			var diagnosisId = $tds.eq(12).find(":input").val();
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
                 'medicalCompositeName':$('#medicalCompositVal').val(),
	      		 'categoryCompositeDate':$('#medicalCompositeDate').val(),
                  "listOfMedicalCategory15":tableDataMedicalCategory,
                  "listOfMedicalCategory":tableDataMedicalCategory1,
                 'hospitalId':<%= hospitalId %>,
   			 	 'userId':<%= userId %>,
   			     'saveInDraft':flagforSubmit,
   			     'actionDigiFile':$('#actionDigiFile').val(),
                 'actionDigiForApproved':$('#actionDigiForApproved').val(),
                 'actionDigiFileApproved':$('#actionDigiFileApproved').val(),
			     'finalObservationMo':$('#finalObservationMo').val(),
			     'finalObservationRMo':$('#finalObservationRMo').val(),
			     'uploadOthersDocument':tablemedicalBoardDocs,
			     'recommedicalCompositeName':$('#recommedicalCompositVal').val(),
	      		 'recomcategoryCompositeDate':$('#recommedicalCompositeDate').val(),
	      		 'recommedicalCompositeNamePId':$('#recommedicalCompositeNamePId').val(),
	      		 'diagnosisName':arryDiagnisisName,
	      		 'diagnosisData':tableDiagnosisData,
	      		 'typeOfCommission':$('#typeOfCommission').val(),
	      		 "listOfOrigin":"[]",
	      		 'actionMe' : '',
 			 	 'forwardTo' : '',
 			 	 'designationForMe' : '',
 			 	 'pendingRemarks' : '',
			     
         }
	     
	   
	     var dateCheck=$('#signDate').val();
	     var yyyy = dateCheck.split("/")[2];
	 
         var amsfFormData1 = $('#amsfForm15Data')[0];
       	 var formData = new FormData(amsfFormData1);
       	 var countFile=1;
       	
    		formData.append('uploadFilePath', "uploads");
    		formData.append('year',yyyy);
    		formData.append('type',1);
    		formData.append('serviceNo',$('#serviceNo').val());
    		formData.append('uploadRealPath', 1);
    		formData.append('amsfForm15Data',JSON.stringify(dataJSON));
         
    		
         $("#clicked").attr("disabled", true);
         $("#submitEntryForma").attr("disabled", true); 
         $("#saveEntryForma").attr("disabled", true);
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
                  $("#submitEntryForma").attr("disabled", false); 
                  $("#saveEntryForma").attr("disabled", false);
                  alert(msg.msg)	
                 }	
                 else
                 {
                 	$("#clicked").attr("disabled", false);
                 	$("#submitEntryForma").attr("disabled", false); 
                 	$("#saveEntryForma").attr("disabled", false);
                     alert("Please enter the valid data")
                 }
             },
             error: function(jqXHR, exception) {
             	$("#clicked").attr("disabled", false);
             	$("#submitEntryForma").attr("disabled", false);
             	$("#saveEntryForma").attr("disabled", false);
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
	
	
	 function addRowForMedicalCategory(){
       	 // var newIndex = $('.autocomplete').length;
       	    var tbl = document.getElementById('medicalCategory');
		  	 lastRow = tbl.rows.length;
		  	 i =lastRow;
       	     i++;
       	    var aClone = $('#medicalCategory>tr:last').clone(true);
       	    aClone.find('img.ui-datepicker-trigger').remove();
       		aClone.find(":input").val("");
       	    aClone.find("td:eq(0)").find(":input").prop('id', 'inlineCheckbox1');
       		aClone.find('input[type="textarea"]').prop('id', 'diagnosisId'+i+'');
       	    //aClone.find('input[type="text"]').prop('id', 'investigationDatess'+i+'');
       	    aClone.find("td:eq(0)").find(":input").prop('checked', false);
       	    aClone.find("td:eq(3)").find("select:eq(0)").prop('id', 'system'+i+'');
 		    aClone.find("td:eq(4)").find("select:eq(0)").prop('id', 'typeOfCategory'+i+'');
 		    aClone.find("td:eq(5)").find("input:eq(0)").prop('id', 'duration'+i+'');
 		    aClone.find("td:eq(6)").find("input:eq(0)").prop('id', 'nextcategoryDate'+i+'');
       		aClone.find("td:eq(8)").find(":input").prop('id', 'diagnosisIdval'+i+'');
       		aClone.find("td:eq(6)").find("input:eq(0)").prop('id', 'categoryDate'+i+'').removeClass('noFuture_date hasDatepicker').addClass('noFuture_date');
       		aClone.find("td:eq(7)").find("input:eq(0)").prop('id', 'nextDiagnosisDate'+i+'').removeClass('input_date hasDatepicker').addClass('input_date');
       		aClone.find("td:eq(10)").find("input:eq(0)").prop('id', 'dateOfOrigin'+i+'').removeClass('input_date hasDatepicker').addClass('input_date');
       		aClone.clone(true).appendTo('#medicalCategory');
       		
       		addRowForMedicalCategoryNew();
       }
	 
	 function addRowForMedicalCategoryNew(){
       	 	 var tbl = document.getElementById('medicalCategoryNew');
		  	 lastRow = tbl.rows.length;
		  	 i =lastRow;
       	     i++;
       	    var aClone = $('#medicalCategoryNew>tr:last').clone(true);
       	    aClone.find('img.ui-datepicker-trigger').remove();
       		aClone.find(":input").val("");
       	    aClone.find("td:eq(0)").find(":input").prop('id', 'inlineCheckbox1');
       		aClone.find('input[type="textarea"]').prop('id', 'diagnosisIdNew'+i+'');
       	    //aClone.find('input[type="text"]').prop('id', 'investigationDatess'+i+'');
       	    aClone.find("td:eq(0)").find(":input").prop('checked', false);
       	    aClone.find("td:eq(3)").find("select:eq(0)").prop('id', 'systemNew'+i+'');
       	    aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'medicalCategoryIdNew'+i+'');
 		    aClone.find("td:eq(4)").find("select:eq(0)").prop('id', 'typeOfCategoryNew'+i+'');
 		    aClone.find("td:eq(5)").find("input:eq(0)").prop('id', 'durationNew'+i+'');
 		    aClone.find("td:eq(6)").find("input:eq(0)").prop('id', 'categoryDateNew'+i+'');
 		    aClone.find("td:eq(7)").find("input:eq(0)").prop('id', 'nextcategoryDateNew'+i+'');
       		aClone.find("td:eq(8)").find(":input").prop('id', 'diagnosisIdvalNew'+i+'');
       		aClone.find("td:eq(6)").find("input:eq(0)").prop('id', 'categoryDateNew'+i+'').removeClass('noFuture_date hasDatepicker').addClass('noFuture_date');
       		aClone.find("td:eq(7)").find("input:eq(0)").prop('id', 'nextDiagnosisDateNew'+i+'').removeClass('input_date hasDatepicker').addClass('input_date');
       		aClone.find("td:eq(10)").find("input:eq(0)").prop('id', 'newDateOfOrigin'+i+'').removeClass('input_date hasDatepicker').addClass('input_date');
       		aClone.find('input[type="text"]').removeAttr('readonly');
       		aClone.find("td:eq(1)").find("textarea:eq(0)").removeAttr('readonly');
       		aClone.find("td:eq(3)").find("select:eq(0)").removeAttr('disabled');
    		aClone.find("td:eq(4)").find("select:eq(0)").removeAttr('disabled');
       		aClone.clone(true).appendTo('#medicalCategoryNew');
       		
       		
       }
	 
	 var total_icd_value = '';
     var digaoReferal='';   
       function fillDiagnosisComboMb(val,item) {
       	  
           var index1 = val.lastIndexOf("[");
           var index2 = val.lastIndexOf("]");
           index1++;
           idIcdNo = val.substring(index1, index2);
           if (idIcdNo == "") {
               return;
           } else {
               //obj = document.getElementById('diagnosisId');
               total_icd_value += val+",";
              
               //obj.length = document.getElementById('diagnosisId').length;
               var b = "false";
               for(var i=0;i<autoIcdCode.length;i++){
            		  
            		  var icdNo1 = icdData[i].icdCode;
            		 
            		  if(icdNo1 == idIcdNo){
            			icdValue = icdData[i].icdId;
            		  $(item).closest('tr').find("td:eq(8)").find(":input").val(icdValue);
            		  $(item).closest('tr').find("td:eq(12)").find(":input").val(icdValue);
            		 
            		  $('#medicalCategoryNew tr').each(function(i, el) {
            				var $tds = $(this).find('td')	
            				 var icdNameVal = $tds.eq(8).find(":input").val();
            				if(icdNameVal=="")
            				{
            		
            					$tds.eq(8).find(":input").val(icdValue);
            					$tds.eq(1).find(":input").val(val);
            				}
            		 });
            		  
            		  }
            	  }
               if (b == "false") {
               	
                   $('#diagnosisId').append('<option value=' + icdValue + '>' + val + '</option>');
                  // document.getElementById('icd').value = ""

               }
           }
       } 
       
       var total_mc_value = '';
       function fillMedicalCategoryData(val,item) {
         	  
             var index1 = val.lastIndexOf("[");
             var index2 = val.lastIndexOf("]");
             index1++;
             idMcNo = val.substring(index1, index2);
             if (idMcNo == "") {
                 return;
             } else {
                 obj = document.getElementById('medicalCategoryId');
                 total_mc_value += val+",";
                
                 obj.length = document.getElementById('medicalCategoryId').length;
                 var b = "false";
                 for(var i=0;i<autoMedicalCategoryData.length;i++){
              		  
              		  var mcDataVal = mcData[i].medicalCategoryCode;
              		 
              		  if(mcDataVal == idMcNo){
              			var mCategoryValue = mcData[i].medicalCategoryId;
              		   $(item).closest('tr').find("td:eq(9)").find(":input").val(mCategoryValue);
              		 	if(val.startsWith("S1N1"))
                     	{
              		 		$(item).closest('tr').find("td:eq(16)").find(":input").val('F');
                    	  	$(item).closest('tr').find("td:eq(3)").find("select:eq(0)").attr("disabled","true");
							$(item).closest('tr').find("td:eq(4)").find("select:eq(0)").attr("disabled","true");
							$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("readonly","true");
							$(item).closest('tr').find("td:eq(7)").find("input:eq(0)").attr("readonly","true");
                     	}
              	    }
              	  }
                 if (b == "false") {
                 	
                     $('#medicalCategoryId').append('<option value=' + mCategoryValue + '>' + val + '</option>');
                      
                  }
             }
         } 
       
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
                
                 obj.length = document.getElementById('medicalCategoryId').length;
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
	 
     function generateNextDate(item) {
    	 
      	  var carrentDateIdValue=$(item).closest('tr').find("td:eq(6)").find("input:eq(0)").val();
      	  var durationValue=$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").val();
      	  var nextCategoryDateId=$(item).closest('tr').find("td:eq(7)").find("input:eq(0)").attr("id");
      	  var status=$(item).closest('tr').find("td:eq(16)").find("input:eq(0)").val();
      	  if(carrentDateIdValue==null || carrentDateIdValue==""){
      		  //alert("Please enter  current Date.");
      			return false;
      	  	}
      	var currentDateVal=carrentDateIdValue.split("/");
      	var date=currentDateVal[0];
      	var month=currentDateVal[1];
      	var year=currentDateVal[2];
      	if(durationValue==null || durationValue=="" && status!="F"){
      		alert("Please enter  duration");
      		return false;
      	}
      	
      	 var typeOfCategoryValueId=$(item).closest('tr').find("td:eq(4)").find("select:eq(0)").attr("id");
      	 var typeOfCategoryValue=$("#"+typeOfCategoryValueId+" option:selected" ).val();
      	
      	 
      	 if(typeOfCategoryValue=="0" && status!="F"){
      			alert("Please select  Type of Category.");
      			 var categoryDateForCheck=$(item).closest('tr').find("td:eq(6)").find("input:eq(0)").attr("id");
      			  $("#"+categoryDateForCheck).val('');
      			return false;
      		}	 
      	 
      var monthNew ="";	
      if(typeOfCategoryValue!=""&& typeOfCategoryValue!="0" && typeOfCategoryValue=='T' && status!="F"){
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
      	//  monthNew =parseInt(month)+parseInt(durationValue);	
    	  monthNew =parseInt(durationValue);	
      }
       
      var dateNext="";
      var yearNew;
      var remMonthNew;
      var  coYearNew;
      	if(monthNew>12){
      		 var remMonthNew="";
     		if(typeOfCategoryValue!=""&& typeOfCategoryValue!="0" && typeOfCategoryValue=='T' && status!="F"){
     	     remMonthNew= parseInt(monthNew)%12;
     		}
     		else{
     			remMonthNew= 	month;
     		}
      	   
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
      if(status!="F")
      { 
       $('#'+nextCategoryDateId).val(dateNext);
       $('#'+nextCategoryDateId).attr('readonly', true); 
      } 
    }
    
    
   /*   var inMedicalCategoryVal=$('#medicalCategory').children('tr:first').children('td:eq(2)').find(':input')[0]
     oldautocomplete(inMedicalCategoryVal, MeidcalCategoryArry);


     oldautocomplete(document.getElementById("medicalCompositeName"), MeidcalCategoryArry);
     oldautocomplete(document.getElementById("recommedicalCompositeName"), MeidcalCategoryArry);
     
     
   
     var inMedicalCategoryVal=$('#medicalCategoryNew').children('tr:first').children('td:eq(2)').find(':input')[0]
     oldautocomplete(inMedicalCategoryVal, MeidcalCategoryArry); */

     function removeRowMedicalCategory(val){
     	
     	if($('#medicalCategory tr').length > 1) {
     		   $(val).closest('tr').remove()
     		 }
     	
     }
     
     function removeRowMedicalCategoryNew(val){
      	
      	if($('#medicalCategoryNew tr').length > 1) {
      		   $(val).closest('tr').remove()
      		 }
      	
      }

     
     $j('body').on("focus",".noFuture_date5", function() {
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
    		yearRange: '1900:2090',
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
     
     $j('body').on("focus",".noFuture_date5New", function() {
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
    		yearRange: '1900:2090',
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
	 var autoMedicalCategoryData='';
     function fillMedicalCategoryDataNew(val,item) {
       	  
           var index1 = val.lastIndexOf("[");
           var index2 = val.lastIndexOf("]");
           index1++;
           idMcNo = val.substring(index1, index2);
           if (idMcNo == "") {
               return;
           } else {
                 total_mc_value += val+",";
                var b = "false";
               for(var i=0;i<autoMedicalCategoryData.length;i++){
            		  
            		  var mcDataVal = mcData[i].medicalCategoryCode;
            		 
            		  if(mcDataVal == idMcNo){
            			var mCategoryValue = mcData[i].medicalCategoryId;
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
    	 
    	 var pathname = window.location.pathname;
         var accessGroup = "MMUWeb";

         var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/getDataValidateAMSF15form";
       
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
					url : url,
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
						        document.getElementById('doe_doc').value =dateOfEnrolment;
						    }
						    
						    var recordOfficeAddress=item.recordOfficeAddress;
						    if (recordOfficeAddress != null && recordOfficeAddress !="") {
						        document.getElementById('reccord_office').value =recordOfficeAddress;
						    }
						    
						    var ceased=item.ceasedDutyOn;
						    if (ceased != null && ceased !="") {
						        document.getElementById('ceased').value =ceased;
						    }
						    
						 					    
						    var disablityAttrServiceRemark= item.disablityAttrServiceRemark;
						    if(disablityAttrServiceRemark!=null && disablityAttrServiceRemark!="")
						    {	
				            document.getElementById('disablityAttrServiceRemark').value =disablityAttrServiceRemark;
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
				            if (reasonForVarious != null && reasonForVarious !="") {
				            document.getElementById('reasonForVarious').value =reasonForVarious;
				            }
				            
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
				            
				            var signDate= item.signDate;
				            if(signDate!=null && signDate!="")
				            {	
				            document.getElementById('signDate').value =signDate;
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
				            
				            var ridcId= item.ridcId;
				            if(ridcId!=null && ridcId!="")
				            {	
				            	$('#uploadFileMedicalExam').show();
				            	$('#viewUploadedFile').show();
				            	var viewUploadedFile="";
				            	viewUploadedFile += '<a class="btn btn-link" href="#" onclick="viewDocumentForDigi('+ridcId+');" >View Document</a>'
				            	//viewUploadedFile+="<button id ='printBtn' type='button'  class='btn btn-primary' onclick='viewDocumentForDigi("+data.data[0].ridcId+");'>View Document</button>";
				        		$('#viewUploadedFile').html(viewUploadedFile);	
				            }
				            else{
				            	$('#uploadFileMedicalExam').show();
				            	$('#viewUploadedFile').hide();
				            	
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
				           
				           });
					
				}
	    });
			
 }
   
     function specialistOpinionOpen()
     {
    		if(document.getElementById('signDate').value == "")
    		{
    			alert("Please enter medical baord date");
                document.getElementById('signDate').focus();
                return false;
    		}
    		
    		else
    		{	
		 		 var Id= $('#visitId').val();
		 		$j('#exampleModal').modal({backdrop: 'static'},'show');
		 		var pathname = window.location.pathname;
		        var accessGroup = "MMUWeb";
				var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/digifileupload/mbSpecialistOpinionDetails?visitId="+Id+"";
		 		 $('#exampleModal .modal-body').load(url);
		          $('#exampleModal .modal-title').text('Specialist Doctor for Opinion and Medical Board');
    		}
 	}    
     
    /*  var mbFlag = 0;
	 function getMBPreAssesDetailsData() {
		 
		 var pathname = window.location.pathname;
			var accessGroup = "MMUWeb";

			var url = window.location.protocol + "//"
					+ window.location.host + "/" + accessGroup
					+ "/medicalBoard/getMBPreAssesDetails";
			
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
						url : url,
						data : JSON.stringify(data),
						dataType : "json",
						// cache: false,

						success : function(response) {
							
						var datas = response.data;	
						var trHTML = '';
						var trHTMLNew = '';
						var trHTMLOrigin = '';
						var i=0;
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
							var dateOfOrigin=item.dateOfOrigin;
							var placeOfOrigin=item.placeOfOrigin;
							var recommendStatus=item.recommendStatus;
							
							if(recommendStatus == 'Y'){
								mbFlag ++;
							}
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
							var checkValue = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1" disabled="true"><span class="cus-checkbtn"></span> ';
							var tr='<tr><td><div class="form-check form-check-inline cusCheck">';
							
							var checkValue1 = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1" disabled="true"><span class="cus-checkbtn"></span> ';
							var tr1='<tr><td><div class="form-check form-check-inline cusCheck">';
							if(selectCheck=='Y')
							{
								 checkValue1 = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1" checked disabled="true"><span class="cus-checkbtn"></span> ';
								 tr1='<tr style="background-color: #84e08f"><td><div class="form-check form-check-inline cusCheck">';
							}
							
							if(selectCheck=='Y')
							{
								
								if(recommendStatus!='Y' && mbFlag == 0)
								{
									 trHTMLNew+='<tr>';
									 trHTMLNew+='<td><div class="form-check form-check-inline cusCheck"><input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1" checked><span class="cus-checkbtn"></span></div></td>';
									 trHTMLNew+='<td><div class="autocomplete forTableResp"><textarea class="form-control" id="diagnosisId" value=" " onblur="fillDiagnosisCombo(this.value,this);" placeholder="Diagnosis" readonly>'+icdName+'</textarea></div></td>';
									 trHTMLNew+='<td><div class="autocomplete forTableResp "><input type="text" id="medicalCategoryIdNew'+i+'" onblur="fillMedicalCategoryDataNew(this.value,this)" class="form-control width120"> </div>  </td>';
									 trHTMLNew+='<td><select class="form-control" name=system id="system" ><option value="0">Select</option><option value="S">S</option><option value="H">H</option><option value="A">A</option><option value="P">P</option><option value="E">E</option></select></td>';
									 trHTMLNew+='<td><select class="form-control width120" name="typeOfCategory'+i+'" id="typeOfCategory'+i+'" onChange="getdurationByType(this);"><option value="0">Select</option><option value="T">Temporary</option><option value="P">Permanent</option></select></td>';
									 trHTMLNew+='<td><input type="text" name="durationss" id="durationssssss'+i+'" onblur="return generateNextDateNew(this);" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control"></td>';
									 trHTMLNew+='<td><div class="dateHolder width100"><input type="text" id="diagnosisDatessss'+i+'" name="diagnosisDatesssss" class="noFuture_date501 form-control" placeholder="DD/MM/YYYY" value="" maxlength="10" /></div></td>';
									 trHTMLNew+='<td><div class="dateHolder width100"><input type="text" id="nextDiagnosisDatessss'+i+'" name="nextDiagnosisDatess" class="input_date form-control " placeholder="DD/MM/YYYY" value="" maxlength="10" /></div></td>';
									 trHTMLNew+='<td style="display: none";><input type="hidden" value="" tabindex="1" id="diagnosisIdval'+i+'" size="77" name="diagnosisIdval" /></td>';
									 trHTMLNew+='<td style="display: none";><input type="hidden" value="" tabindex="1" id="medicalCategoryIdvalNew'+i+'" size="77" name="medicalCategoryIdvalNew" /></td>'; 
									 trHTMLNew+='<td><div class="dateHolder width100"><input type="text" id="dateOfOrigin'+i+'" name="nextDiagnosisDatess" class="input_date form-control " placeholder="DD/MM/YYYY" value="" maxlength="10" /></div></td>';
									 trHTMLNew+='<td> <input type="text" class="form-control width100" name="placeOfOrigin" id="placeOfOrigin'+i+'"  class="form-control"></td>';
									 trHTMLNew+='<td style="display: none";><input type="hidden" value="'+diagnosisId+'" tabindex="1" id="diagnosisIdval'+i+'" size="77" name="diagnosisIdval" /></td>';
									 trHTMLNew+='</tr>';
							
								}
								else if(recommendStatus=='Y')
								{
								 func1='fillDiagnosisCombo';
    				    		 url1='opd';
    				    		 url2='getIcdListByName';
    				    		 flaga='diagnosisMe';
									 var systemArrary = ["S","H","A","P","E"];  
									 var tr2='<tr style="background-color: #84b6e0"><td><div class="form-check form-check-inline cusCheck">';
									 var appnedNew='';
									 appnedNew+=tr2+checkValue1+'</div></td><td><div class="autocomplete forTableResp"><textarea class="form-control" value="'+icdName+'" id="diagnosisId" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" placeholder="Diagnosis">'+icdName+'</textarea><div id="diagnosisMeDiv" class="autocomplete-itemsNew"></div></div></td>';
									 appnedNew+='<td><div class="autocomplete"><input type="text" value="'+medicalCategory+'" id="medicalCategory" class="form-control"></div></td>';
									 appnedNew+='<td><input type="text" value="'+system+'" id="system" class="form-control" readonly /> </td><td><input type="text" value="'+categoryType+'" id="categoryType'+i+'" class="form-control"></td>';
									 appnedNew+='<td><input type="text" value="'+duration+'" id="duration" class="form-control" readonly> </td><td><div class="dateHolder"><input type="text" value="'+categoryDate+'" id="diagnosisDate'+i+'" name="diagnosisDatesssss" class="input_date form-control" placeholder="DD/MM/YYYY" maxlength="10" /></div></td>';
									 appnedNew+='<td><div class="dateHolder"><input type="text" value="'+nextCategoryDate+'" id="nextDiagnosisDate" name="nextDiagnosisDatess" class="input_date form-control" placeholder="DD/MM/YYYY" maxlength="10" /></div></td>';
									 appnedNew+='<td style="display: none";><input type="hidden" value="" tabindex="1" id="diagnosisIdval" size="77" name="diagnosisIdval" /></td>';
									 appnedNew+='<td style="display: none";><input type="hidden" value="" tabindex="1" id="medicalCategoryIdvalNew" size="77" name="medicalCategoryIdvalNew" /></td>'; 
									 appnedNew+='<td><button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForMedicalCategoryNew();"></button></td>';
									 appnedNew+='<td><button type="button" name="delete" value="'+patientMedicalCategoryId+'"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"  onclick="removeRowMedicalCategoryNew(this)"></button></td>';
								 	
									 appnedNew+='<td style="display: none";><input type="hidden" value="'+diagnosisId+'" tabindex="1" id="diagnosisIdval" size="77" name="diagnosisIdval" readonly /></td>';
									 appnedNew+='<td style="display: none";><input type="hidden" tabindex="1" id="medicalCategoryIdval" value="'+medicalCategoryId+'" size="77"name="medicalCategoryIdval" /></td><td style="display: none";><input type="hidden" tabindex="1" id="categoryIdval" size="77" value="'+patientMedicalCategoryId+'" name="categoryIdval" readonly /></td><td style="display: none";><input type="hidden" value="'+mbStatus+'" tabindex="1" id="mbStatus" size="77" name="mbStatus" readonly /></td></tr>';
									
									 $("#medicalCategoryNew tr").remove();
									 $('#medicalCategoryNew').append(appnedNew);
								
									 
								}	
							}	
							
							if(icdName!=null && icdName!=undefined && (mbStatus=='P' || mbStatus=='C') && recommendStatus!='Y')
							{
							$("#medicalCategory tr").remove();	
							trHTML+=tr1+checkValue1+'</div></td><td><textarea class="form-control width180" value="'+icdName+'" id="diagnosisId'+i+'" onblur="fillDiagnosisCombo(this.value,this);" placeholder="Diagnosis" readonly>'+icdName+'</textarea></td><td><input type="text" value="'+medicalCategory+'" id="medicalCategory'+i+'" class="form-control width120" readonly></td><td><input type="text" value="'+system+'" id="system'+i+'" class="form-control" readonly /> </td><td><input type="text" value="'+categoryType+'" id="categoryType'+i+'" class="form-control width120" readonly> </td><td><input type="text" value="'+duration+'" id="duration'+i+'" class="form-control width100" readonly> </td><td><div class="dateHolder"><input type="text" value="'+categoryDate+'" id="diagnosisDate'+i+'" name="diagnosisDatesssss" class="input_date form-control width120" placeholder="DD/MM/YYYY" maxlength="10" readonly /></div></td><td><div class="dateHolder width120"><input type="text" value="'+nextCategoryDate+'" id="nextDiagnosisDate'+i+'" name="nextDiagnosisDatess" class="input_date form-control" placeholder="DD/MM/YYYY" maxlength="10" readonly /></div></td><td style="display: none";><input type="hidden" value="" tabindex="1" id="diagnosisIdval" size="77" name="diagnosisIdval" /></td><td style="display: none";><input type="hidden" value="" tabindex="1" id="medicalCategoryIdval" size="77" name="medicalCategoryIdval" /></td><td><div class="dateHolder width100"><input type="text" id="dateOfOrigin'+i+'" name="nextDiagnosisDatess" class="input_date form-control " placeholder="DD/MM/YYYY" value="'+dateOfOrigin+'" maxlength="10" /></div></td><td> <input type="text" value="'+placeOfOrigin+'" class="form-control width100" name="placeOfOrigin" id="placeOfOrigin'+i+'"  class="form-control"></td><td><button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForMedicalCategory();"></button></td><td><button type="button" name="delete" value="'+patientMedicalCategoryId+'"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"  onclick="removeRowMedicalCategory(this)"></button></td><td style="display: none";><input type="hidden" value="'+diagnosisId+'" tabindex="1" id="diagnosisIdval" size="77" name="diagnosisIdval" readonly /></td><td style="display: none";><input type="hidden" value="'+patientMedicalCategoryId+'" tabindex="1" id="patientMedicalCategoryId" size="77" name="patientMedicalCategoryId" readonly /></td><td style="display: none";><input type="hidden" value="'+mbStatus+'" tabindex="1" id="mbStatus" size="77" name="mbStatus" readonly /></td></tr>';	
							//trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationValue+''+'['+investigationId+']'+'" id="chargeCodeName1'+i+'" class="form-control border-input" name="chargeCodeName1" onblur="populateChargeCode(this.value,1,this);" /> </div></td><td><div class="dateHolder"> <input type="text" id="investigationDate1Temp'+i+'" name="investigationDatess" class="input_date form-control" placeholder="DD/MM/YYYY" value='+today+' maxlength="10" /></div></td><td><input type="checkbox" name="urgent" id="otherAfLabCheck" tabindex="1" class="radioAuto" value="I" checked/></td><td><input type="checkbox" name="urgent" id="uCheck" tabindex="1" class="radioAuto" value="1" /><td style="display:none";><input type="hidden" value="'+investigationId+'" tabindex="1" id="inestigationIdval2'+i+'" size="77" name="inestigationIdval" /></td> </td><td><button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForInvestigation();"></button></td><td><button type="button" name="delete" value="" class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" onclick="removeRowInvestigation(this)"></button></td></tr>';
							i++;
							}
					   });
						$('#medicalCategory').append(trHTML);
                         if(mbFlag == 0)
                         {	 
                       $('#medicalCategoryNew').append(trHTMLNew);
						 var val = $('#medicalCategoryNew>tr').find("td:eq(2)").find(":input")[0];
						 var valLast = $('#medicalCategoryNew>tr:last').find("td:eq(2)").find(":input")[0];
						 oldautocomplete(val, MeidcalCategoryArry);
						 oldautocomplete(valLast, MeidcalCategoryArry);
                         }
						
					}
		    });
			}   */
			var mbFlag = 0;
			 var finalObersationDetail="";
			 var msgOfMedicalCatName="";
			 var msgOfSystem="";
			 var msgOfTypeOfMedCat="";
			 var msgOfICDDiagnosis="";
			 var msgOfCatdate="";
			 var msgOfNextCategoryDate="";
			 var durationF="";
			 var  msgForFitIn="";
			 function getMBPreAssesDetailsData() {
			 	var saveDraftVal=$('#saveInDraft').val();
			 	investigationGridValue = "investigationGrid";
			 	var visitId = $('#visitId').val();
			 	var patientId=$('#patientId').val();
			 	var pathname = window.location.pathname;
			     var accessGroup = "MMUWeb";
			 	 var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/getMBMedicalCategory";
			 	
			 	var data = {
			 		"visitId" : visitId,
			 		"patientId":patientId
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
							var trHTMLNew = '';
							var trHTMLOrigin = '';
							var trHtml19;
 							var i=0;
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
			 				
			 				if(datas!=undefined){
			 				$("#medicalCategory tr").remove();
			 				$("#medicalCategoryNew tr").remove();
			 				$.each(datas, function(i, item) {
			 	
			 					 
			 					    var investigationName=item.inveName;
			 						var icdName=item.icdName;
			 						var system=item.system;
			 						var medicalCategory=item.medicalCategory;
			 						if(item.categoryType!=undefined) 
			 						categoryType=item.categoryType;
			 						 
			 						var categoryDate=item.categoryDate;
			 						var duration=item.duration;
			 						var nextCategoryDate=item.nextCategoryDate;
			 						var patientMedicalCategoryId=item.patientMedicalCategoryId;
			 						var diagnosisId=item.diagnosisId;
			 						var medicalCategoryId=item.medicalCategoryId;
			 						var selectCheck=item.applyFor;
			 						var	categoryTypeVal=item.categoryType;
			 						var mbStatus=item.mbStatus;
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
									/* var getDischargeIcdCode=item.getDischargeIcdCode;
									alert("getDischargeIcdCode "+getDischargeIcdCode) */
									/* if(categoryTypeVal=='P')
									{
									  categoryType='Permanent';	
									}
									if(categoryTypeVal=='T')
									{
									   categoryType='Temporary';
									}	 */
									var categoryDate=item.categoryDate;
									var duration=item.duration;
									var nextCategoryDate=item.nextCategoryDate;
									var selectCheck=item.applyFor;
									var checkValue = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1"><span class="cus-checkbtn"></span> ';
									var tr='<tr><td><div class="form-check form-check-inline cusCheck">';
									
									var checkValue1 = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1"><span class="cus-checkbtn"></span> ';
									var tr1='<tr><td><div class="form-check form-check-inline cusCheck">';
									
									if(recommendStatus == 'Y'){
										mbFlag ++;
									}
									if(recommendStatus == 'C'){
										 document.getElementById('recommedicalCompositeName').value = medicalCategoryFit;
									     document.getElementById('recommedicalCompositeDate').value = fitCatDate;
									     document.getElementById('recommedicalCompositeNamePId').value = patientMedicalCategoryId;
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
			 				
			 						if(duration!=""){
			 							durationF=duration;
			 						}	
			 						if(categoryDate!=""){
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
			 						if(icdName!=null && icdName!=undefined)
			 						msgOfICDDiagnosis+=" "+icdName;
			 						if(categoryDate!=undefined && categoryDate!="")
			 						msgOfCatdate+=" "+categoryDate;
			 						if(nextCategoryDate!=undefined && nextCategoryDate!="")
			 							msgOfNextCategoryDate+=" "+nextCategoryDate;
			 						var checkValue = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1" disabled="true"><span class="cus-checkbtn"></span></div>';
			 						var tr='<tr><td><div class="form-check form-check-inline cusCheck">';
			 						if(selectCheck=='Y')
			 						{
			 							 checkValue = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1" checked><span class="cus-checkbtn"></span></div> ';
			 							 tr='<tr style="background-color: #84e08f"><td><div class="form-check form-check-inline cusCheck">';
			 						}
			 						if(icdName!=null && icdName!=undefined && mbStatus=='P')
			 						{
			 							func1='fillDiagnosisComboMb';
			 				    		 url1='opd';
			 				    		 url2='getIcdListByName';
			 				    		 flaga='diagnosisMe';
			 				    		 
			 							trHTML+=tr+checkValue+' <td>';
			 							trHTML+=' <div class="autocomplete forTableResp width150">';
			 							trHTML+=' <textarea class="form-control" value="'+icdName+'" id="diagnosisId'+i+'" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" placeholder="Diagnosis">'+icdName+'</textarea><div id="diagnosisMeDiv" class="autocomplete-itemsNew"></div>';
			 							//trHTML+='<input type="textarea" class="form-control" '+approvalFlagDiasable+' name="diagnosisId" id="diagnosisId'+i+'" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" placeholder="Diagnosis" value="'+icdName+'" />';
			 							trHTML+='</div>';
			 							trHTML+=' </td>	';
			 									func2='fillMedicalCategoryData';
		    									url2='medicalBoard';
		    		 							url22='getMedicalBoardAutocomplete';
		    		 							flaga2='compositeCategory';
			 							trHTML+='  <td>';
			 							trHTML+=' <div class="autocomplete forTableResp">';
			 							trHTML+='<input type="text" id="medicalCategoryId" onblur="fillMedicalCategoryData(this.value,this);" '+approvalFlagDiasable+' value="'+medicalCategory+'" onKeyUp="getNomenClatureList(this,\''+func2+'\',\''+url2+'\',\''+url22+'\',\''+flaga2+'\');"  class="form-control width120"><div id="medicalBoardMbDiv" class="autocomplete-itemsNew"></div>';
			 							trHTML+='<input type="hidden" id="diagnosisiIdMC" name="diagnosisiIdMC" value="'+diagnosisId+'"/>';
			 							trHTML+='<input type="hidden" id="medicalCategoryValueId" name="medicalCategoryValueId" value="'+medicalCategoryId+'"/>';
			 							trHTML+='<input type="hidden" id="patientMedicalCatId" name="patientMedicalCatId" value="'+patientMedicalCategoryId+'"/>';
			 							trHTML+='</div> ';
			 							trHTML+='</td>';
			 							var systemArrary = ["S","H","A","P","E"]; 
			 							trHTML+=' <td>';
			 							trHTML+='<select class="form-control width80" name=system id="system'+i+'" '+approvalFlagDiasable+'>';
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
			 							trHTML+='<select class="form-control width120" name=typeOfCategory id="typeOfCategory'+i+'" onchange="getdurationByType(this);" '+approvalFlagDiasable+'>';
			 							
			 							trHTML+='<option value="0">Select</option>';
			 							if(categoryType!=null || categoryType!=""){
			 								var cateValue;
			 								var catetypeVal;
			 								for(var k=0;k<2;k++){
			 								var selectValue=""
			 								if(categoryType=='T'){
			 									selectValue='selected';
			 									cateValue='Temporary';
			 									catetypeVal='T';
			 									categoryType='';
			 									
			 								}
			 								else if(categoryType=='P'){
			 									selectValue='selected';
			 									cateValue='Permanent';
			 									catetypeVal='P';
			 									categoryType='';
			 								}
			 								else{
			 									var count=0;
			 									if(cateValue=='Temporary' && count=='0'){
			 										cateValue='Permanent';
			 										catetypeVal='P';
			 										count++;
			 									} 
			 									if(cateValue=='Permanent' && count=='0'){
			 										cateValue='Temporary';
			 										catetypeVal='T';
			 										count++;
			 									}
			 									selectValue='';
			 								}
			 								trHTML+='<option '+selectValue+' value='+catetypeVal+'>'+cateValue+'</option>';
			 							}
			 							}
			 							else{
			 								
			 								trHTML+='<option value="T">Temporary</option>';
			 								trHTML+='<option value="P">Permanent</option>';
			 							}	
			 							trHTML+='</select>';
			 							trHTML+='</td>';
			 							
			 							trHTML+='<td>';
			 							trHTML+='<input type="text" '+approvalFlagDiasable+' name="duration" id="duration'+i+'" value="'+duration+'" onblur="return generateNextDate(this);" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control"> </td>';
			 							trHTML+='</td>';
			 							
			 							trHTML+='<td>';
			 							trHTML+='<div class="dateHolder width110">';
			 							trHTML+=' <input type="text" '+approvalFlagDiasable+' id="categoryDate'+i+'" ';
			 							trHTML+=' name="categoryDate" class="noFuture_date5 form-control" ';
			 							trHTML+=' placeholder="DD/MM/YYYY" value="'+categoryDate+'" maxlength="10" />';
			 							trHTML+='  </div>';
			 							trHTML+='  </td>';
			 							
			 							trHTML+='<td>';
			 							trHTML+='   <div class="dateHolder width110">';
			 							trHTML+=' <input type="text" '+approvalFlagDiasable+' id="nextcategoryDate'+i+'" name="nextcategoryDate" class="form-control" placeholder="DD/MM/YYYY" value="'+nextCategoryDate+'" maxlength="10" readonly/>';
			 							trHTML+=' </div>';
			 							trHTML+='  </td>';
			 							
			 							trHTML+=' <td style="display: none";><input type="hidden" tabindex="1" id="diagnosisIdval'+i+'" size="77" name="diagnosisIdval" value="'+diagnosisId+'" /></td>';
			 							trHTML+=' <td style="display: none";><input type="hidden"  tabindex="1" id="medicalCategoryIdval'+i+'" size="77" name="medicalCategoryIdval" value="'+medicalCategoryId+'" /></td>';
			 							trHTML+='<td><div class="dateHolder width100"><input type="text" onChange="return getDateOfOrigin(this);" id="dateOfOrigin'+i+'" name="nextDiagnosisDatess" class="input_date form-control " placeholder="DD/MM/YYYY" value="'+dateOfOrigin+'" maxlength="10" /></div></td><td> <input type="text" value="'+placeOfOrigin+'" class="form-control width100" onblur="getPlaceOfOrigin(this);" name="placeOfOrigin" id="placeOfOrigin'+i+'"  class="form-control"></td>';
			 							trHTML+=' <td>';
			 							trHTML+='<button type="button" '+approvalFlagDiasable+' type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForMedicalCategory();"></button>';
			 							trHTML+=' </td>';
			 							trHTML+=' <td>';
			 							trHTML+=' <button type="button" name="delete"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"  onclick="removeRowMedicalCategory(this)"></button>';
			 							trHTML+=' </td>';	
			 							trHTML+=' <td style="display: none";>';
			 							trHTML+='<input type="hidden" id="diagnosisiIdMCaaa'+i+'" name="diagnosisiIdMC" value="'+diagnosisId+'"/>';
			 							trHTML+=' </td>';
			 							trHTML+=' <td style="display: none";>';
			 							trHTML+='<input type="hidden" value="'+patientMedicalCategoryId+'" tabindex="1" id="patientMedicalCategoryId" size="77" name="patientMedicalCategoryId" readonly />';
			 							trHTML+=' </td>';
			 							trHTML+=' <td style="display: none";>';
			 							trHTML+='<input type="hidden" value="" tabindex="1" id="fitFlag" size="77" name="fitFlag" readonly />';
			 							
			 							trHTML+=' </td>';
			 							trHTML+=' </tr>';
			 							i++;
			 						}
			 					
			 						if(icdName!=null && icdName!=undefined && mbStatus=='P' && selectCheck=='Y')
			 						{
			 							func1='fillDiagnosisComboMb';
			 				    		 url1='opd';
			 				    		 url2='getIcdListByName';
			 				    		 flaga='diagnosisMe';
			 				    		//var checkValue1 = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1" checked disabled ="true"><span class="cus-checkbtn"></span> ';
			 				    		var checkValue1 = '<div class="form-check form-check-inline cusCheck"><input class="form-check-input" type="checkbox" id="fitInChk'+i+'" onclick="return masMedicalCategoryforFitCatNew(this);" value="option1'+i+'"/><span class="cus-checkbtn"></span></div>';
			 				    		var tr2='<tr style="background-color: #84b6e0"><td><div class="form-check form-check-inline cusCheck">';
										trHtml19+=tr2+checkValue1+' <td>';
			 				    		trHtml19+=' <div class="autocomplete forTableResp width150">';
			 				    		trHtml19+=' <textarea class="form-control" value="'+icdName+'" id="diagnosisId'+i+'" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" placeholder="Diagnosis">'+icdName+'</textarea><div id="diagnosisMeDiv" class="autocomplete-itemsNew"></div>';
			 							//trHTML+='<input type="textarea" class="form-control" '+approvalFlagDiasable+' name="diagnosisId" id="diagnosisId'+i+'" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" placeholder="Diagnosis" value="'+icdName+'" />';
			 							trHtml19+='</div>';
			 							trHtml19+=' </td>	';
			 												func2='fillMedicalCategoryDataNew';
							    							url2='medicalBoard';
							    		 					url22='getMedicalBoardAutocomplete';
							    		 					flaga2='compositeCategory';
			 							trHtml19+='  <td>';
			 							trHtml19+=' <div class="autocomplete forTableResp">';
			 							trHtml19+='<input type="text" id="medicalCategoryId" value="'+medicalCategory+'" onKeyUp="getNomenClatureList(this,\''+func2+'\',\''+url2+'\',\''+url22+'\',\''+flaga2+'\');"  class="form-control width120"><div id="medicalBoardMbDiv" class="autocomplete-itemsNew"></div>';
			 							trHtml19+='<input type="hidden" id="diagnosisiIdMC" name="diagnosisiIdMC" value="'+diagnosisId+'"/>';
			 							trHtml19+='<input type="hidden" id="medicalCategoryValueId" name="medicalCategoryValueId" value="'+medicalCategoryId+'"/>';
			 							trHtml19+='<input type="hidden" id="patientMedicalCatId" name="patientMedicalCatId" value="'+patientMedicalCategoryId+'"/>';
			 							trHtml19+='</div> ';
			 							trHtml19+='</td>';
			 							var systemArrary = ["S","H","A","P","E"]; 
			 							trHtml19+=' <td>';
			 							trHtml19+='<select class="form-control width80" name=system id="system'+i+'" '+approvalFlagDiasable+'>';
			 							trHtml19+='<option value="0">Select</option>';
			 							for(var j=0;j<systemArrary.length;j++){
			 								var systemSelectedVal="";
			 								if(systemArrary[j]==system){
			 									systemSelectedVal='selected';
			 								}
			 								else{
			 									systemSelectedVal="";
			 								}
			 								trHtml19+='<option '+systemSelectedVal+' value='+systemArrary[j]+'>'+systemArrary[j]+'</option>';
			 							}
			 							trHtml19+='</select>';
			 							trHtml19+='</td>';
			 							
			 							
			 							
			 							trHtml19+=' <td>';
			 							trHtml19+='<select class="form-control width120" name=typeOfCategory id="typeOfCategory'+i+'" onchange="getdurationByType(this);" '+approvalFlagDiasable+'>';
			 							
			 							trHtml19+='<option value="0">Select</option>';
			 							if(categoryType!=null || categoryType!=""){
			 								var cateValue;
			 								var catetypeVal;
			 								for(var k=0;k<2;k++){
			 								var selectValue=""
			 								if(categoryType=='T'){
			 									selectValue='selected';
			 									cateValue='Temporary';
			 									catetypeVal='T';
			 									categoryType='';
			 									
			 								}
			 								else if(categoryType=='P'){
			 									selectValue='selected';
			 									cateValue='Permanent';
			 									catetypeVal='P';
			 									categoryType='';
			 								}
			 								else{
			 									var count=0;
			 									if(cateValue=='Temporary' && count=='0'){
			 										cateValue='Permanent';
			 										catetypeVal='P';
			 										count++;
			 									} 
			 									if(cateValue=='Permanent' && count=='0'){
			 										cateValue='Temporary';
			 										catetypeVal='T';
			 										count++;
			 									}
			 									selectValue='';
			 								}
			 								trHtml19+='<option '+selectValue+' value='+catetypeVal+'>'+cateValue+'</option>';
			 							}
			 							}
			 							else{
			 								
			 								trHtml19+='<option value="T">Temporary</option>';
			 								trHtml19+='<option value="P">Permanent</option>';
			 							}	
			 							trHtml19+='</select>';
			 							trHtml19+='</td>';
			 							
			 							trHtml19+='<td>';
			 							trHtml19+='<input type="text" '+approvalFlagDiasable+' name="duration" id="duration'+i+'" value="'+duration+'" onblur="return generateNextDate(this);" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control"> </td>';
			 							trHtml19+='</td>';
			 							
			 							trHtml19+='<td>';
			 							trHtml19+='<div class="dateHolder width110">';
			 							trHtml19+=' <input type="text" '+approvalFlagDiasable+' id="categoryDate'+i+'" ';
			 							trHtml19+=' name="categoryDate" class="noFuture_date5 form-control" ';
			 							trHtml19+=' placeholder="DD/MM/YYYY" value="'+categoryDate+'" maxlength="10" />';
			 							trHtml19+='  </div>';
			 							trHtml19+='  </td>';
			 							
			 							trHtml19+='<td>';
			 							trHtml19+='   <div class="dateHolder width110">';
			 							trHtml19+=' <input type="text" '+approvalFlagDiasable+' id="nextcategoryDate'+i+'" name="nextcategoryDate" class="form-control" placeholder="DD/MM/YYYY" value="'+nextCategoryDate+'" maxlength="10" readonly/>';
			 							trHtml19+=' </div>';
			 							trHtml19+='  </td>';
			 							
			 							trHtml19+=' <td style="display: none";><input type="hidden" tabindex="1" id="diagnosisIdval'+i+'" size="77" name="diagnosisIdval" value="'+diagnosisId+'" /></td>';
			 							trHtml19+=' <td style="display: none";><input type="hidden"  tabindex="1" id="medicalCategoryIdval'+i+'" size="77" name="medicalCategoryIdval" value="'+medicalCategoryId+'" /></td>';
			 							trHtml19+='<td style="display: none";><input type="hidden" id="dateOfOrigin'+i+'" name="dateOfOrigin" svalue="'+dateOfOrigin+'" maxlength="10" /></div></td><td style="display: none";><input type="hidden" value="'+placeOfOrigin+'" class="form-control width100" name="placeOfOrigin" id="placeOfOrigin'+i+'"  class="form-control"></td>';
			 							trHtml19+=' <td>';
			 							trHtml19+='<button type="button" '+approvalFlagDiasable+' type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForMedicalCategoryNew();"></button>';
			 							trHtml19+=' </td>';
			 							trHtml19+=' <td>';
			 							trHtml19+=' <button type="button" name="delete"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"  onclick="removeRowMedicalCategory(this)"></button>';
			 							trHtml19+=' </td>';	
			 							trHtml19+=' <td style="display: none";>';
			 							trHtml19+='<input type="hidden" id="diagnosisiIdMCaaa'+i+'" name="diagnosisiIdMC" value="'+diagnosisId+'"/>';
			 							trHtml19+=' </td>';
			 							trHtml19+=' <td style="display: none";>';
			 							trHtml19+='<input type="hidden" value="'+patientMedicalCategoryId+'" tabindex="1" id="patientMedicalCategoryId" size="77" name="patientMedicalCategoryId" readonly />';
			 							trHtml19+=' </td>';
			 							trHtml19+=' <td style="display: none";>';
			 							trHtml19+='<input type="hidden" tabindex="1" id="fitFlag" size="77" name="fitFlag" readonly />';
			 							
			 							trHtml19+=' </td>';
			 							trHtml19+=' </tr>';
			 							i++;
			 						}
			 				   });
			 				   $('#medicalCategory').append(trHTML);
			 			       $('#medicalCategoryNew').append(trHtml19);
			 			
			 				}
			 				
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
			$('#medicalBoardDocs>tr:last').find("td:eq(4)").find("button:eq(0)").attr("id", "newSupportDoc");
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
		 	$('#editorOfUpload').jqteVal(resultView);
		 	$('#fileUploadModal').show();
		 	$('.modal-backdrop ').show();
			$('#resultIdMedicalDocs').val(resultIdIm);
		}


	 
		function saveMedicalBoardInText(){
			var idOfResult=$('#resultIdMedicalDocs').val();
			 var jqetResultValue=$('#editorOfUpload').val();
			 
			 if(jqetResultValue!=""){
				 jqetResultValue=jqetResultValue.trim();
				 jqetResultValue="@@@###"+jqetResultValue;
			 }
			 
			 $('#'+idOfResult).val(jqetResultValue);
			 $('#fileUploadModal').hide();
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

		
		 function diasableFormField(){
			 
			 $('input').attr('disabled','disabled');
			 $('select').attr('disabled','disabled');
			 $('textarea').attr('disabled','disabled');
			 $('button').attr('disabled','disabled');
			 $('#closebtn').removeAttr('disabled');
			$('.uneditableEditorView .jqte_editor').attr('contenteditable','false');
			$('.modal input, .modal button').removeAttr('disabled');
		 }
		 
		 function getHospitalListDigiMb(){
			 var hospitalIdForDigi=$('#hospitalIdForDigi').val();
			 var pathname = window.location.pathname;
		 	var accessGroup = "MMUWeb";
			 var url1 = window.location.protocol + "//"
				+ window.location.host + "/" + accessGroup
				+ "/master/getHospitalListByRegion";
				$.ajax({
				 	crossOrigin: true,
				    method: "POST",			    
				    crossDomain:true,
				    url: url1,
				    data: JSON.stringify({}),
				    contentType: "application/json; charset=utf-8",
				    dataType: "json",
				    success: function(result){
				    	//alert("success "+result.data.length);
				    	var combo = "<option value='0'>Select</option>" ;

				    	for(var i=0;i<result.data.length;i++){
				    		var selectedHospital="";
				    		 if(hospitalIdForDigi==result.data[i].hospitalId){
				    			 selectedHospital="selected";
							 }
							 else{
								 selectedHospital=''; 
							 }
				    		combo += '<option '+selectedHospital+' value='+result.data[i].hospitalId+'>' +result.data[i].hospitalName+ '</option>';
				    	}
				    	$j('#hospitalForDigi').append(combo);
				    }
				    
				});
			}	
		 
		 function getDateOfOrigin(item){
			 var dateOfOrigin=$(item).closest('tr').find("td:eq(10)").find("input:eq(0)").val();
			 var diagnosisVal=$(item).closest('tr').find("td:eq(8)").find("input:eq(0)").val();
			 $('#medicalCategoryNew tr').each(function(i, el) {
					var $tds = $(this).find('td')	
					 var icdNameVal = $tds.eq(8).find(":input").val();
					if(diagnosisVal==icdNameVal)
					{
			
						$tds.eq(10).find(":input").val(dateOfOrigin);
					}
			 });
		}

		function getPlaceOfOrigin(item){
			 var placeOfOrigin=$(item).closest('tr').find("td:eq(11)").find("input:eq(0)").val();
			 var diagnosisVal=$(item).closest('tr').find("td:eq(8)").find("input:eq(0)").val();
			
			 $('#medicalCategoryNew tr').each(function(i, el) {
					var $tds = $(this).find('td')	
					 var icdNameVal = $tds.eq(8).find(":input").val();
					if(diagnosisVal==icdNameVal)
					{
			
						$tds.eq(11).find(":input").val(placeOfOrigin);
					}
			 });
		}
		

	function masMedicalCategoryforFitCatNew(item) {
		 	
		    var pathname = window.location.pathname;
		    var accessGroup = "MMUWeb";

		    var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/getMedicalBoardAutocomplete";
		    var countMedCat=0;
		    var fitCheckId=idforTreat= $(item).closest('tr').find("td:eq(0)").find(":input").attr("id");
		    var fitCheckVal=idforTreat= $(item).closest('tr').find("td:eq(0)").find(":input").val();
		    var fitCheckValue=idforTreat= $(item).closest('tr').find("td:eq(16)").find(":input").val();
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
			   $(item).closest('tr').find("td:eq(16)").find(":input").val(clearValue);
			  
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
							$(item).closest('tr').find("td:eq(2)").find("input:eq(0)").val(finalObservationForCategory);
							$(item).closest('tr').find("td:eq(9)").find(":input").val(mcId);
							$(item).closest('tr').find("td:eq(16)").find(":input").val('F');
							
							$(item).closest('tr').find("td:eq(1)").find("textarea:eq(0)").attr("readonly","true");
							$(item).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("readonly","true");
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
			   $(item).closest('tr').find("td:eq(16)").find(":input").val(clearValue);
			   $(item).closest('tr').find("td:eq(1)").find("textarea:eq(0)").removeAttr("readonly");
				$(item).closest('tr').find("td:eq(2)").find("input:eq(0)").removeAttr("readonly");
				$(item).closest('tr').find("td:eq(3)").find("select:eq(0)").removeAttr("disabled");
				$(item).closest('tr').find("td:eq(4)").find("select:eq(0)").removeAttr("disabled");
				$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").removeAttr("readonly");
				$(item).closest('tr').find("td:eq(7)").find("input:eq(0)").removeAttr("readonly");
			 }
		   
		}	
  </script>
</body>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
</html>