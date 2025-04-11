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
                            
                             <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autoPopulate.js"></script>
                             <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/medicalBoard.js"></script>
                             <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
                             <script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
                             <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/commonformodal.js"></script>
                              <%@include file="..//view/commonModal.jsp"%>
                                <meta charset="utf-8">
                                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                <title>Preliminary Investigation MB(MO)</title>
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
<script type="text/javascript">
	window.history.forward();
	var labRadioValue=resourceJSON.mainchargeCodeLab;
	var imagRadioValue=resourceJSON.mainchargeCodeRadio;
	
</script> 
<script>
var hsId=<%=hospitalId%>;
var uId=<%=userId%>;
var $j = jQuery.noConflict();
$j(document).ready(function(){
	$j('#lab_radio').val(labRadioValue);
	$j('#imag_radio').val(imagRadioValue);
});
</script>	
                          
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
                                                    <div class="internal_Htext">Preliminary Investigation MB(MO)</div>

                                                    <div class="row">
                                                        <div class="col-12">
                                                            <div class="card">
                                                                <div class="card-body">

                                                                    <div class="row">
                                                                      <input type="hidden" name="statussss" id="statussss" value=""/>
                                                                      <input  name="checkForInve" id="checkForInve" type="hidden" value="1" />
                                                                      <input type="hidden" name="userId" id="userId" value="<%=userId%>"/>
									                            		<div class="col-md-12">
                                                                        <h6 class="font-weight-bold text-theme text-underline">Patient Details</h6>
                                                                        </div>
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

                                                                        <!--  <div class="col-md-4">
											<div class="form-group row">
												<label class="col-md-4 col-form-label">To Date</label>
												<div class="col-md-7">
													<input type="date" class="form-control custom_date" name="toDate" id="toDate"> 
												<input  type="text" class="form-control custom_date calDate" name="toDate" id="toDate" placeholder="DD/MM/YYYY" validate="To Date,string,yes"/>
																	<div class="dateHolder"> 
																			<input  type="text" class="calDate custom_date datePickerInput form-control"  name="toDate" id="toDate" placeholder="DD/MM/YYYY" validate="From Date,string,yes" value=""  maxlength="10" />
                                                                   </div>
												</div>
											</div>
										</div>
										<div class="col-md-1">
											<button class="btn btn-primary" id="searhAppointment"
												type="button" onclick="searchAppointment()">Search</button> 
										</div>

	                                    <div class="col-md-3">
											  <div class="btn-right-all">                                      
                                                     <button type="button" class="btn  btn-primary " onclick="showAll();">Show All</button>                                                    
                                             </div>
										</div> -->

                                                                    </div>

                                            <h6 class="font-weight-bold text-theme text-underline">Present Medical Category (Composite)</h6>
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

                                                                    <div class="tablediv ">
                                                                        <h6 class="font-weight-bold text-theme text-underline">List of Medical Category</h6>
                                                                      		 <table class="table table-hover table-striped table-bordered">
	                                        <thead class="bg-success" style="color:#fff;">
													<tr>
													    <th id="th1">Select</th>
														<th id="th2" style="width: 275px;">Diagnosis</th>
														<th id="th4">Medical Category</th>
														<th id="th3" style="width: 80px;">System</th>
														<th id="th5">Type of Category</th>
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
                                                          <div class="form-check form-check-inline cusCheck m-l-5">
                                                          <input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1">
                                                          <span class="cus-checkbtn"></span> 
                                                          </div>
                                                          </td>
                                                            <td>
                                                               <!--  <div class="autocomplete">
                                                                <input type="text" autocomplete="off" class="form-control" name="diagnosisId" id="diagnosisId" onblur="fillDiagnosisCombo(this.value,this);" onKeyPress="autoCompleteCommonMe(this,5);" onKeyUp="autoCompleteCommonMe(this,5);"placeholder="Diagnosis" />
                                                                --> 
                                                                <div class="autocomplete forTableResp">
                                                                   <input type="text" autocomplete="off" class="form-control" name="diagnosisId" id="diagnosisId" onKeyUp="getNomenClatureList(this,'fillDiagnosisCombo','opd','getIcdListByName','diagnosisMe');"  placeholder="Diagnosis" />
                                                                <div id="diagnosisMeDiv" class="autocomplete-itemsNew"></div>
                                                                </div>
                                                             </td>
                                                               <td>
                                                                  <div class="autocomplete">
                                                                   <input type="text" autocomplete="off" id="medicalCategoryId" onblur="fillMedicalCategoryData(this.value,this);" onKeyPress="autoCompleteCommonMe(this,6);"  onKeyUp="autoCompleteCommonMe(this,6);" class="form-control">
                                                                   <input type="hidden" id="diagnosisiIdMC" name="diagnosisiIdMC" value=""/>
                                                                  	<input type="hidden" id="medicalCategoryValueId" name="medicalCategoryValueId" value=""/>
                                                                  	<input type="hidden" id="patientMedicalCatId" name="patientMedicalCatId" value=""/>
                                                                 </div> 
                                                               </td>
                                                                <td>
                                                                  <!-- <input type="text" name="system" maxlength="1" id="system"class="form-control" value=""/> --> 
                                                                <select class="form-control" name=system id="system" >
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
																		<option value="T">Temporary(week)</option>
																		<option value="P">Permanent(month)</option>
																		</select>
						                                           </td>
                                                                   <td>
                                                                     <input type="text" name="duration" id="duration" onChange="return generateNextDate(this);" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control">  
                                                                 	</td>
                                                                                 
                                                                      <td>
		                                                                <div class="dateHolder">
														                    <input type="text" id="categoryDate" 
														                     name="categoryDate" class="noFuture_date5 form-control" 
														                     placeholder="DD/MM/YYYY" value="" onChange="return generateNextDate(this);" maxlength="10" />
													                    </div>
		                                                              </td>
                                                                       <td>
                                                                        	<div class="dateHolder">
													                    	<input type="text" id="nextcategoryDate" name="nextcategoryDate" class="form-control" placeholder="DD/MM/YYYY" value="" maxlength="10" />
													                    	</div>
                                                              			</td>
																		<td>
                                                                          <button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForMedicalCategory();"></button>
                                                                         </td>
												                  <td>
													                 <button type="button" name="delete" value=""  class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"  onclick="removeRowMedicalCategory(this)"></button>
												                 </td>	
												                 	<td style="display: none";>
																	<input type="hidden" id="diagnosisiIdMCaaa" name="diagnosisiIdMC" value=""/>
																	</td>
																	<td style="display: none";>
															<input type="hidden" id="medicalCategoryValueIdaaa" name="medicalCategoryValueId" value=""/>
																</td>
																<td style="display: none";>
															<input type="hidden" id="patientMedicalCatIdaaa" name="patientMedicalCatId" value=""/>
															 </td>
								  						</tr>	
												  												  
										                 		</tbody>											
									                            </table>
                                                                    </div>

                                                                    <h6 class="font-weight-bold text-theme text-underline">Investigation</h6>
                                                                  <div class="Block">
											<div class="row">

												<div class="col-md-4">
													<div class="form-group row">
														<label class="col-md-5 col-form-label no-bold" style="padding-left: 10px;"> Template </label>
														<div class="col-md-7">
															<div id="investigationDiv">
																<select name="investigationTemplateId"  class="form-control" 
																	id="dgInvestigationTemplateId11" tabindex="1">
																</select>
															</div>
														</div>
													</div>
												</div>

												<div class="col-md-8">
													
														
															<input type="button" value="Create Template" tabindex="1" class="btn btn-primary"
																data-toggle="modal" data-target="#exampleModal" 
															onclick="showCreateInvestigationTemplate111();">
															
															<input name="updateTemplate" tabindex="1"
																	type="button" value="Update Template" data-toggle="modal" data-target="#exampleModal" class="btn btn-primary"
																	onclick="opdUpdateInvestigationTemplate111()" />
																	
															 <input name="investigation" tabindex="1"
																	type="button" value="Import New" class="btn btn-primary"
																	onclick="getTemplateDetail111();templateUpdate()" />
																	
															<!--<input name="updateTemplate" tabindex="1"
																	type="button" value="Update Template" data-toggle="modal" data-target="#smallModal" class="btn btn-primary"
																	onclick="opdUpdateInvestigationTemplate()" /> -->
													
												</div>

												<!-- <div class="col-md-2">
													<div class="form-group row">
														<div class="col-md-12">
															<div>
																<input name="createupdateTemplate" tabindex="1"
																	type="button" value="Update Template" class="buttonBig"
																	onclick="showUpdateOpdTempate('I');" />
															</div>
														</div>
													</div>
												</div> -->

												


												<!--       <div class="col-md-2">
                                                                    <div class="form-group row">
                                                                          <label class="col-md-5 col-form-label"> Urgent  </label>
                                                                        <div class="col-md-7">
                                                                            <input type="checkbox" name="urgent" tabindex="1" class="radioAuto" value="1" />  
                                                                        </div>
                                                                    </div>
                                                                </div> -->


										
                                              
													
														
															
															
															<!-- <input name="investigation" tabindex="1"
																	type="button" value="Import New" class="btn btn-primary"
																	onclick="showInvestiDataTemplate()" />
																	
															<input name="updateTemplate" tabindex="1"
																	type="button" value="Update Template" data-toggle="modal" data-target="#smallModal" class="btn btn-primary"
																	onclick="opdUpdateInvestigationTemplate()" /> -->
													
												</div>
											     
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
                                                                    
                                                                    
                                                                   	<table class="table table-hover table-striped table-bordered m-t-10" border="0"
														align="center" cellpadding="0" cellspacing="0"
														id="investigationGrid">
														<thead>
															<tr class="table-primary">
																<th>Investigation</th>
																<th>Date</th>
																<!-- <th style="display: none";>Mark as Other AF Lab</th> -->
																<th>Mark as Outside AF Lab</th>
																<th>UOM</th>
																<th>Investigation Remarks</th>
																<th>Add</th>
																<th>Delete</th>
															</tr>
														</thead>

														<tbody id="dgInvetigationGrid">
															<tr>

																<td>
																	<div class="autocomplete">
																		<input type="text" value="" id="chargeCodeName" autocomplete="_off"
																			class="form-control border-input"
																			name="chargeCodeName"  size="44" onKeyPrss="autoCompleteCommonMe(this,1);" onKeyUp="autoCompleteCommonMe(this,1);"
																			onblur="populateChargeCode(this.value,1,this);" />
																		<input type="hidden" id="qty" tabindex="1" name="qty1"
																			size="10" maxlength="6" validate="Qty,num,no" /> <input
																			type="hidden" tabindex="1" id="chargeCodeCode"
																			name="chargeCodeCode" size="10" readonly />
																	</div>
																</td>

																<%-- <td><input type="checkbox" name="referToMh<%=inc %>" tabindex="1" id="referToMhId
                                                                                <%=inc%>" value="y" class="radio" validate="Refer to MH,string,no" /></td> --%>
																<td>
																  <!-- <input type="date" id="investigationDate1" 
																	name="investigationDatess" class="form-control" 
																	placeholder="DD/MM/YYYY" value="" maxlength="10" /> -->
																	<div class="dateHolder">
																	<input type="text" id="investigationDate1" 
																	name="investigationDatess" class="input_date form-control" 
																	placeholder="DD/MM/YYYY" value="" maxlength="10" />
																	</div>
																</td>
																<!-- <td style="display: none";>
																	<div class="labRadiologyDivfixed"></div> <input
																	type="radio" value="I" id="othAfLab10"
																	class="radioCheckCol2" style="margin-right: 15px;"
																	name="labradiologyCheck1" />
																</td> -->
																<td class="text-center">
																	<!-- <div class="labRadiologyDivfixed"></div> <input
																	type="radio" value="O" id="othAfLab10"
																	class="radioCheckCol2" style="margin-right: 15px;"
																	name="labradiologyCheck1" " /> -->
																	<div class="form-check form-check-inline cusCheck">
																	<input type="checkbox" name="urgent"
																	id="otherAfLabCheck" tabindex="1" class="radioAuto form-check-input" checked value="I" />
																	<span class="cus-checkbtn"></span> 
																	</div>
																</td>
																<td style="display: none";>
																<div class="form-check form-check-inline cusCheck">
																<input type="checkbox" name="urgent"
																	id="uCheck" tabindex="1" class="radioAuto form-check-input" value="1" />
																	<span class="cus-checkbtn"></span> 
																	</div>
																</td>
																<td style="display: none";><input type="hidden"
																	value="" tabindex="1" id="inestigationIdval" size="77"
																	name="inestigationIdval" /></td>

																 <td>
													            	<input type="text" name="UOM" id="UOM"class="form-control" readonly>
													             </td>
													             <td>
													            	 <textarea class="form-control" id="investigationRemarks" value=" " placeholder="investigationRemarks"></textarea>
                                                                 </td>
													             <td>
                                                                  <button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForInvestigationFunUp();"></button>
                                                                  </td>
																<td>
																	<button type="button" name="delete" value=""
																		class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"
																		onclick="removeRowInvestigation11(this)">
																		</button>
																</td>

															</tr>
														</tbody>
														
													</table>
													
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

                                                                  <!--   <div class="row">
                                                                        <div class="col-md-12 m-t-10 clearfix">
                                                                            <div class="btn-right-all">
                                                                                <button class=" btn btn-primary opd_submit_btn">Add</button>
                                                                                <button class="btn btn-danger opd_submit_btn">Delete</button>
                                                                            </div>
                                                                        </div>
                                                                    </div> -->

                                                                    <div class="row">
                                                                        <div class="col-md-12 m-t-10 clearfix">
                                                                            <div class="btn-right-all">
                                                                                 <input type="submit" class="btn btn-primary" value="Validate"  id="clicked" tabindex="1" onclick="saveInvestigationDetails(this.value);"/>
                                                                             </div>
                                                                        </div>
                                                                    </div>
                                                                  <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                
                                                                                   <div class="col-md-6">
                                                                                    <input type="hidden" id="patientId" name="PatientID12" value="">
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
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
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

 <div class="modal" id="messageForInvestigationOutsideMO" role="dialog">
			<div class="modal-dialog">
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

							<div class="col-md-12">
								<div class="form-group ">
									<span><spring:message code="msgForInves" /></span> <br />
									<spring:message code="msgDesignation2" />
									&#63;


								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" id="submitMOValidateFormByModelIdss"  data-dismiss="modal"
							onClick="submitMOValidateFormByModel1();" aria-hidden="true">
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
      <div class="modal" id="messageForWithoutInvestigation" role="dialog">
			<div class="modal-dialog">
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

							<div class="col-md-12">
								<div class="form-group ">
									<span><spring:message code="msgForWithoutInves" /></span> <br />
									<spring:message code="msgDesignation2" />
									&#63;


								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" id="submitWithoutInvestigation"  data-dismiss="modal"
							onClick="submitWithoutInvestigationModel();" aria-hidden="true">
							<spring:message code="btnOK" />
						</button>
						<button class="btn btn-primary" data-dismiss="modal"
							onClick="closeMessageWithoutInv();" aria-hidden="true">
							<spring:message code="btnClsoe" />
						</button>
					</div>
					
					
					
				</div>
			</div>
		</div>                                      

<div class="modal-backdrop show" style="display:none;"></div>

<script>                                
var lastRow;
var i=100;
function addRowForInvestigation(){
	 // var newIndex = $('.autocomplete').length;
	     var tbl = document.getElementById('dgInvetigationGrid');
   	    lastRow = tbl.rows.length;
   	    i =lastRow;
   	    i++;
	    var aClone = $('#dgInvetigationGrid>tr:last').clone(true);
	    aClone.find('img.ui-datepicker-trigger').remove();
		aClone.find(":input").val("");
	    aClone.find('input[type="text"]').prop('id', 'chargeCodeName'+i+'');
	    //aClone.find('input[type="text"]').prop('id', 'investigationDatess'+i+'');
	    aClone.find("option[selected]").removeAttr("selected")
	    aClone.find("td:eq(2)").find(":checkbox").prop('id', 'otherAfLabCheck'+i+'').prop('checked', true);
		/*aClone.find('input[type="radio"]').prop('name', 'labradiologyCheck1'+i+'');
		aClone.find('input[type="radio"]').prop('id', 'othAfLab1'+i+'');*/
		aClone.find("td:eq(4)").find(":input").prop('id', 'inestigationIdval'+i+'');
		aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'investigationDate1'+i+'').val(today).removeClass('input_date hasDatepicker').addClass('input_date');
		aClone.clone(true).appendTo('#dgInvetigationGrid');
		var valInvestigation = $('#dgInvetigationGrid>tr:last').find("td:eq(0)").find(":input")[0];
		
		if(arryInvestigation!=null && arryInvestigation!="" )
		{
		arrayData=[];	
		oldautocomplete(valInvestigation, arryInvestigation);
		}
		else
		{
		arryInvestigation=[];	
		oldautocomplete(valInvestigation, arrayData);
		}
		
		
		    		    		
		  var tbl = document.getElementById('dgInvetigationGrid');
   	  lastRow = tbl.rows.length;
   
}

var arryInvestigation = new Array();
var investigationForUom="";
$(document).ready(
		function() {
			var radioValue = labRadioValue; 
			invesRadio=radioValue;
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
			'employeeId' : <%= userId %>,
			'mainChargeCode':radioValue,
		}),
		dataType : 'json',
		timeout : 100000,
		success : function(res)
 		{

 			
 			var data = res.InvestigationList;
 			investigationForUom=res.InvestigationList;
 			for(var i=0;i<data.length;i++){
 				var investigationNewUpdate=data[i];
 				var investigationId= investigationNewUpdate[0];
 				var investigationName = investigationNewUpdate[1];
 				if(investigationNewUpdate[3]!=null)
 				var uomName = investigationNewUpdate[3];
 				var inves=investigationName+"["+investigationId +"]"
 				 arryInvestigation.push(inves);
 				
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
 
function nextCategoryDate()
{ 
	var durationCheck = $('#duration').val();
	if (durationCheck!= null || durationCheck!= "") {
	
		    var categogryDate = $('#diagnosisDate').val();
		    //alert("categogryDate "+categogryDate);
			
		    var arr = categogryDate.split("/");
		    var dd=arr[0];
		    var mm=arr[1];
		    var yyyy=arr[2];
		
		    var addMonths=mm+durationCheck;
			//alert("months" +addMonths)
			//document.write(today);
			$('#investigationDate1').val(today); 
		
	}	
}


	var today = "";
	var dateCheck = $('#investigationDate1').val();
	if (dateCheck == null || dateCheck == "") {
		$(document).ready(function() {
			today = new Date();
			var dd = String(today.getDate()).padStart(2, '0');
			var mm = String(today.getMonth() + 1).padStart(2, '0');
			var yyyy = today.getFullYear();

			//today =  yyyy + '-' + mm + '-' +dd;

			today = dd + '/' + mm + '/' + yyyy;
			//document.write(today);
			$('#investigationDate1').val(today);
		});
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
	 			for (var i = 0; i < investigationForUom.length; i++) {
	 				// var pvmsNo1 = data[i].pvmsNo;
	 				var masInvestigationValues = investigationForUom[i];
	 				var chargeCodeUom = masInvestigationValues[0];

	 				if (ChargeCode == chargeCodeUom) {

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

	 					var checkCurrentRowIddd = $(item).closest('tr')
	 							.find("td:eq(0)").find("input:eq(3)").attr("id");
	 					var checkCurrentRow = $(item).closest('tr').find("td:eq(0)").find("input:eq(3)").val();
	 					var count = 0;
	 					$('#dgInvetigationGrid tr').each(
	 									function(i, el) {
	 										var $tds = $(this).find('td');
	 										var chargeCodeId = $($tds).closest('tr').find("td:eq(0)").find("input:eq(3)").attr("id");
	 										var chargeCodeIdValue = $('#' + chargeCodeId).val();
	 										var idddd = $(item).closest('tr').find("td:eq(0)").find("input:eq(3)").attr("id");
	 										var currentidddd = $(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
	 										if (chargeCodeId != checkCurrentRowIddd
	 												&& ChargeCode == chargeCodeIdValue) {
	 											if (ChargeCode == chargeCodeIdValue) {
	 												alert("Investigation is already added");
	 												$('#' + idddd).val("");
	 												$('#' + currentidddd).val("");
	 												$('#'+ chargeCodeIdValue).val("");
	 												return false;
	 											}
	 										} else {
	 											$(item).closest('tr').find("td:eq(0)").find("input:eq(3)").val(ChargeCode);
	 											$(item).closest('tr').find("td:eq(4)").find("input:eq(0)").val(ChargeCode);
	 											$(item).closest('tr').find("td:eq(3)").find("input:eq(0)").val(uomName);
	 										
	 										}
	 									});
	 				}
	 			}
	 		}

	 	}
	 }


  function autoCompleteCommonMe(val,flag){
		if(flag=='1')
			oldautocomplete(val, arryInvestigation);
		
	 }
</script>

<script type="text/javascript">
            $(document).ready(function() {
            	//masIcdList();
            	masMedicalCategoryList();
            });
</script>            

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
                if (data.data[0].age != null) {
                    document.getElementById('age').value = data.data[0].age;
                }
                if (data.data[0].gender != null) {
                    document.getElementById('gender').value = data.data[0].gender;
                }
                if (data.data[0].rank != null) {
                    document.getElementById('rank').value = data.data[0].rank;
                }
                if (data.data[0].medicalCategogyName != null && data.data[0].fitFlag != "F") {
                    document.getElementById('medicalCompositeName').value = data.data[0].medicalCategogyName;
                }
                if (data.data[0].medicalCategogyDate != null && data.data[0].fitFlag != "F") {
                    document.getElementById('medicalCompositeDate').value = data.data[0].medicalCategogyDate;
                }
                var vstatussss=localStorage.status;
                document.getElementById('statussss').value = vstatussss;
                getMedicalCategoryData();
                //getMBPreAssesDetailsInvResultData();
                getAFMSFInvestigation();
                getTemplateDetail111();
                
            });
            
   
            function addRowForMedicalCategory(){
            	 var tbl = document.getElementById('medicalCategory');
            	 var 	lastRow = tbl.rows.length;
             	 i =lastRow;
               	 i++;
           	    var aClone = $('#medicalCategory>tr:last').clone(true);
           	    aClone.find('img.ui-datepicker-trigger').remove();
           		aClone.find(":input").val("");
           	    aClone.find("td:eq(0)").find(":input").prop('id', 'inlineCheckbox1');
           		aClone.find('input[type="text"]').prop('id', 'diagnosisId'+i+'');
           	    //aClone.find('input[type="text"]').prop('id', 'investigationDatess'+i+'');
           	    aClone.find("td:eq(0)").find(":input").prop('checked', false);
           	    aClone.find("td:eq(1)").find("div").find("div").prop('id', 'diagnosisMeDiv' + i + '');
           	    aClone.find("td:eq(3)").find("select:eq(0)").prop('id', 'system'+i+'');
     		    aClone.find("td:eq(4)").find("select:eq(0)").prop('id', 'typeOfCategory'+i+'');
     		    aClone.find("td:eq(5)").find("input:eq(0)").prop('id', 'duration'+i+'');
     		    aClone.find("td:eq(6)").find("input:eq(0)").prop('id', 'nextcategoryDate'+i+'');
           		aClone.find("td:eq(10)").find(":input").prop('id', 'diagnosisiIdMCaaa'+i+'');
           		aClone.find("td:eq(6)").find("input:eq(0)").prop('id', 'categoryDate'+i+'').removeClass('noFuture_date hasDatepicker').addClass('noFuture_date');
           		aClone.find("td:eq(7)").find("input:eq(0)").prop('id', 'nextDiagnosisDate'+i+'').removeClass('input_date hasDatepicker').addClass('input_date');
           		var	medicalCategoryAdd ='';
           	   	medicalCategoryAdd +='<button type="button" name="delete" value="" id="deleteMC'+i+'"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" onclick="removeRowMedicalCategory(this);"></button>';
           	   	aClone.find("td:eq(9)").html(medicalCategoryAdd);
           	   	aClone.clone(true).appendTo('#medicalCategory');
           		var medicalCategoryVal = $('#medicalCategory>tr:last').find("td:eq(2)").find(":input")[0];
           		oldautocomplete(medicalCategoryVal, MeidcalCategoryArry);
           		
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
               			var checkCurrentRowIddd = $(item).closest('tr').find("td:eq(10)").find("input:eq(0)").attr("id");
					     var checkCurrentRow = $(item).closest('tr').find("td:eq(10)").find("input:eq(0)").val();
              			  $('#medicalCategory tr').each(function(i, el) {
              				//alert("icdNo1"+icdNo1)
              				//alert("icdValue "+icdValue)
              				  var $tds = $(this).find('td');
								var chargeCodeId = $($tds).closest('tr').find("td:eq(10)").find("input:eq(0)").attr("id");
								var chargeCodeIdValue = $('#' + chargeCodeId).val();
								var idddd = $(item).closest('tr').find("td:eq(10)").find("input:eq(0)").attr("id");
								var currentidddd = $(item).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
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
				               			  $(item).closest('tr').find("td:eq(1)").find("input:eq(1)").val(icdValue);
				               			  $(item).closest('tr').find("td:eq(10)").find("input:eq(0)").val(icdValue);
				               			  $(item).closest('tr').find("td:eq(2)").find("input:eq(1)").val(icdValue);
								}  
					}); 
              		}
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
                   			$(item).closest('tr').find("td:eq(1)").find("input:eq(2)").val(mCategoryValue);
                   			$(item).closest('tr').find("td:eq(11)").find("input:eq(0)").val(mCategoryValue);
                   			$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val(mCategoryValue);
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
            
     function saveInvestigationDetails(val) {
    	        var checkVal=val;
			    var pathname = window.location.pathname;
    			var accessGroup = "MMUWeb";

    			var url = window.location.protocol + "//"
    					+ window.location.host + "/" + accessGroup
    					+ "/medicalBoard/saveInvestigationMBdetails";
    			
              
    			 /* if(document.getElementById('diagnosisId0').value=="") {
                 	alert("Please enter diagnosis under Medical Category");
                 	document.getElementById('diagnosisId').focus();
                     return false;
                   }*/
    			  
    			/* var selectCat = document.getElementById("inlineCheckbox1");
    			 if(selectCat.checked == false) {
                  	alert("Please Select at least one Medical Category");
                    return false;
                 } */
                var count=0;			
    			 $('#medicalCategory tr').each(function(i, el) {
              		   var $tds = $(this).find('td')
              		    var diagnosisValCheck = $tds.eq(10).find(":input").val();
      	 			   var selectCat= $tds.eq(0).find(":input").is(":checked");
      	 			     if(selectCat== true) {
                            count++;
                            }
      	 			  if(count!=0 && count!="" && diagnosisValCheck=="")
        			    {
        			    	alert("Please enter at least one diagnosis");
    	                    return false;	
        			    }   
      	 		               
    			     }); 
    			    if(count==0 && count=="")
	 		        {
	 		        	alert("Please select at least one Medical Category");
	                    return false;
	 		        } 
           /////////////////////// Medical Cateogry validation part ////////////////////////////
	    	 		 
             	var  idformedicalCategory='';
             	$('#medicalCategory tr').each(function(i, el) {
             		idformedicalCategory= $(this).find("td:eq(1)").find("input:eq(0)").attr("id"); 
     	 			    var $tds = $(this).find('td')
        	    		var medicalSystem = $tds.eq(3).find(":input").val();
        	   			var medicalCategory = $tds.eq(2).find(":input").val();
        	  			var typeCategory = $tds.eq(4).find(":input").val();
        	  			 var duration = $tds.eq(5).find(":input").val();
        	  		    var categoryDate = $tds.eq(6).find(":input").val();
        	  		     var nextCategoryDate = $tds.eq(7).find(":input").val();
        	  		    var diagnosisVal = $tds.eq(10).find(":input").val();
        	  			    
        	  		    
 		    		if(diagnosisVal!= '' && diagnosisVal!= null && !medicalCategory.startsWith("S1A1"))
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
        			if(typeCategory== "")
    	   			{
        				alert("Please select Category Type under Medical Category");
        				typeCategory.focus();
      					return false;       	
    				}
     				if(categoryDate== "")
    	    		{
        				alert("Please Select Date of Category under Medical Category");
        				categoryDate.focus();
      					return false;       	
    				}
     				if(duration== "" || duration==0)
    	    		{
        				alert("Duration should be greater than 0 under Medical Category");
        				duration.focus(); 
      				    return false;       	
    				}
        
 				    }
     	 			
     	 			
         		 });
    			 
             	var diagnosisName='';
    			//////////////////////////////investigation validation part ////////////////	
               var  idforInvestigation='';
    			var valnomenclatureGrid='';	
    			if($('#dgInvetigationGrid tr').length > 0)
    			{
    	 		 $('#dgInvetigationGrid tr').each(function(i, el) {
    	 			idforInvestigation= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
		    		 var $tds = $(this).find('td')
		           	    var itemIdCheckVal = $tds.eq(4).find(":input").val();
    	 			    diagnosisName   = $tds.eq(0).find(":input").val();
					      // alert(id);
					         if(itemIdCheckVal=="" && diagnosisName!=""){
					        	 alert("Please enter valid Investigation name under Investigation"); 
					        	 itemIdCheckVal.focus();
					      		 return false; 
					        	
					         }
					       
				    
    	 		 }); 
    			} 
    			var tableDataInvestigation = [];  
		    	var dataInvestigation='';
		    	var dataInvestigationHD='';
		    	var labMarkValue = ''; 
		    	var investigationRemarks='';
		    	var labInvestgationId=[];
				var urgent='';
				  var id='';
				  var idotherlab='';
				  var idforInv=''	
					  var countForInves=0;
				$('#dgInvetigationGrid tr').each(function(i, el){
				     idforInv= $(this).find("td:eq(1)").find("input:eq(0)").attr("id"); 
				     diagnosisName= $(this).find("td:eq(0)").find(":input").val();
		   			 if(document.getElementById(idforInv).value!= '' && document.getElementById(idforInv).value != undefined && diagnosisName!="")
	    			  {  
		   				 var $tds = $(this).find('td')
		   				 //id= $(this).find("td:eq(2)").find("input:eq(0)").attr("id")
		   				 if($tds.eq(2).find(":input").is(":checked")){
				         var iinLab='O';
				         labMarkValue=iinLab;
				         countForInves++;
				         
				        }
				        else
				         {
				         var outLab='I';
				         labMarkValue=outLab;
				         }
				             
				        labInvestgationId.push(labMarkValue);
	    	          }
				    });
				         
				var checkForVal=$('#checkForInve').val();
				  if(countForInves>0 && checkForVal==1){
					  $('#checkForInve').val(1);
					  $('#messageForInvestigationOutsideMO').show();
						$('.modal-backdrop').show();
						
						return false;
				  }     
		    	
				  if(countForInves==0 && checkForVal==1 && diagnosisName==""){
					  $('#checkForInve').val(1);
					  $('#messageForWithoutInvestigation').show();
						$('.modal-backdrop').show();
						
						return false;
				    }
		    	    var count=0;
		    		$('#dgInvetigationGrid tr').each(function(i, el) {
		    		idforInv= $(this).find("td:eq(0)").find("input:eq(0)").attr("id")  
			   		if(document.getElementById(idforInv).value!= '' && document.getElementById(idforInv).value != undefined)
		    		{ 	
				    var $tds = $(this).find('td')
				  		
					var itemIdInvestigation = $tds.eq(4).find(":input").val();
				    var investigationRemarksVal=$tds.eq(5).find(":input").val();
					var investigationDate = $tds.eq(1).find(":input").val();
					var dgOrderHdIdss=$tds.eq(9).find(":input").val();
					var dgOrderfDtIdss=$tds.eq(8).find(":input").val();
					if ($tds.eq(3).find(":input").is(":checked")) 
					{
						var yurgent='Y';
						urgent=yurgent;
					}
					else
					{
					    var nUrgent='N';
					    urgent=nUrgent;
					 }
					var labinvastigation="";
					 for (var i = count; i <labInvestgationId.length; i++) {
						 if(i==count){
							 labinvastigation=labInvestgationId[i];
							 break;
						 }
						 
					 }
					 count++;
					dataInvestigation={
		    				'investigationId' : itemIdInvestigation,
		    				'orderDate' : investigationDate,
		    				'labMark' : labinvastigation,
		    				'urgent' : urgent,
		    				
					}
					dataInvestigationHD={'orderDate' : investigationDate,
							             'otherInvestigation':$('#otherInvestigation').val(), 
            							 'listofInvestigationDT':[{ 'investigationId' : itemIdInvestigation,
            				    				'orderDate' : investigationDate,
            				    				 'mbStatus':$('#statussss').val(),
            				    				'labMark' : labinvastigation,
            				    				'urgent' : urgent,
            				    				'dgOrderHdIdss':dgOrderHdIdss,
            				    				'dgOrderfDtIdss':dgOrderfDtIdss,
            				    				'investigationRemarks':investigationRemarksVal,}]
            		                   }
					tableDataInvestigation.push(dataInvestigationHD);
		    		}	
		    	});
		    	console.log(tableDataInvestigation)	    			
    			////////////////////////////////////Medical Categories Screen JSON/////////////////////////
    				       var tableDataMedicalCategory2244 = [];  
					    	var dataMedicalCategory6666='';
					    	var idforMedicalCategory1123='';
					    $('#medicalCategory tr').each(function(i, el) {
					    	idforMedicalCategory1123= $(this).find("td:eq(1)").find("input:eq(0)").attr("id")
					    if(idforMedicalCategory1123!= "" && idforMedicalCategory1123!= undefined)
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
			    		var diagnosisId = $tds.eq(10).find(":input").val();
	    			  	var system = $tds.eq(3).find(":input").val();
	    				var medicalCategory = $tds.eq(11).find(":input").val();
	    				var categoryType = $tds.eq(4).find(":input").val();
	    				var duration = $tds.eq(5).find(":input").val();
	    				var categoryDate = $tds.eq(6).find(":input").val();
	    				var nextCategoryDate = $tds.eq(7).find(":input").val();
	    				var patientMedicalCatId = $tds.eq(12).find(":input").val();
	    				var dateOfOrigin = $tds.eq(13).find(":input").val();
	    				var placeOfOrigin = $tds.eq(14).find(":input").val();
	    				dataMedicalCategory6666={
	    	    				'diagnosisId' : diagnosisId,
	    	    				'system' : system,
	    	    				'mbStatus':$('#statussss').val(),
	    	    				'medicalCatCheck' : mCheck,
	    	    				'medicalCategory' : medicalCategory,
	    	    				'categoryType' : categoryType,
	    	    				'duration' : duration,
	    	    				'categoryDate' : categoryDate,
	    	    				'nextCategoryDate' : nextCategoryDate,
	    	    				'patientMedicalCatId':patientMedicalCatId,
	    	    				'dateOfOrigin':dateOfOrigin,
	    	    				'placeOfOrigin':placeOfOrigin,
	    	    				}
	    				tableDataMedicalCategory2244.push(dataMedicalCategory6666)
					    }
			    	});
		    		
		    		
		    		
		    	var dataJSON={
    	  			     
    	      			'visitId':$('#visitId').val(),
    	      			'patientId':$('#patientId').val(), 
    	      			'departmentId':'1',
    	      			'hospitalId' : <%=hospitalId%>,
    	      			'userId':<%= userId %>,
    	      			'saveEnable':checkVal,
        	      		'medicalCompositeName':$('#medicalCompositVal').val(),
    	      			'categoryCompositeDate':$('#medicalCompositeDate').val(),
    	      			'compositeCategoryIdVal':'',
    	      			"listofInvestigation" : tableDataInvestigation,
    	      		    "listOfMedicalCategory":tableDataMedicalCategory2244,
    	      		}
		    	$("#clicked").attr("disabled", true);
    			$.ajax({
    				type : "POST",
    				contentType : "application/json",
    				url : url,
    				data: JSON.stringify(dataJSON),
    				dataType : 'json',
    				timeout : 100000,
    				success : function(msg)
    				{
    				  if (msg.status == 1)
    				   	   {
    					        var moDetails='moDetails';
    					        localStorage.moDetails=moDetails;
    		        		    var Id= $('#visitId').val();
    							window.location.href ="preliminaryMBSubmit?visitId="+Id+"";
    		        		   
    		        	   }
    		        		
    		        	  else
    		        	  {
    		        		  $("#clicked").attr("disabled", false);
    		        		  alert(msg.status)
    		        	   }
    		           },
    		           error: function (jqXHR, exception) {
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
     
     function generateNextDate(item) {
    	 
   	  var carrentDateIdValue=$(item).closest('tr').find("td:eq(6)").find("input:eq(0)").val();
   	  var durationValue=$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").val();
   	  var nextCategoryDateId=$(item).closest('tr').find("td:eq(7)").find("input:eq(0)").attr("id");
   	  if(carrentDateIdValue==null || carrentDateIdValue==""){
   		  //alert("Please enter  current Date.");
   			return false;
   	  	}
   	var currentDateVal=carrentDateIdValue.split("/");
   	var date=currentDateVal[0];
   	var month=currentDateVal[1];
   	var year=currentDateVal[2];
   	if(durationValue==null || durationValue==""){
   		alert("Please enter  duration");
   		return false;
   	}
   	
   	 var typeOfCategoryValueId=$(item).closest('tr').find("td:eq(4)").find("select:eq(0)").attr("id");
   	 var typeOfCategoryValue=$("#"+typeOfCategoryValueId+" option:selected" ).val();
   	
   	 
   	 if(typeOfCategoryValue=="0"){
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
    $('#'+nextCategoryDateId).val(dateNext);
   // $('#'+nextCategoryDateId).attr('readonly', true); 
   	}
   
        
</script>

<script type="text/javascript">

//var inIcdVal=$('#medicalCategory').children('tr:first').children('td:eq(1)').find(':input')[0]
//oldautocomplete(inIcdVal, arry);

var inMedicalCategoryVal=$('#medicalCategory').children('tr:first').children('td:eq(2)').find(':input')[0]
oldautocomplete(inMedicalCategoryVal, MeidcalCategoryArry);


oldautocomplete(document.getElementById("medicalCompositeName"), MeidcalCategoryArry); 

function removeRowMedicalCategory(val){
	
	if($('#medicalCategory tr').length > 1) {
		   $(val).closest('tr').remove()
		 }
	
}

function removeRowInvestigation11(val){
	
	if($('#dgInvetigationGrid tr').length > 1) {
		   $(val).closest('tr').remove()
		 }
	else
	{
	  alert("At least one row must be there")
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

var investigationGridValue = "investigationGrid";
var investigationData = '';
var finalObersationDetail="";	
//USed for FinalObservation
var msgOfMedicalCatName="";
var msgOfSystem="";
var msgOfTypeOfMedCat="";
var msgOfICDDiagnosis="";
var msgOfCatdate="";
var msgOfNextCategoryDate="";
var durationF="";
var  msgForFitIn="";
function getMedicalCategoryData() {
	var saveDraftVal=$('#saveInDraft').val();
	investigationGridValue = "investigationGrid";
	var visitId = $('#visitId').val();
	var patientId=$('#patientId').val();
	var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";
	 var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/getMBMedicalCategory";
		var dataJson='';
		var statussss=$('#statussss').val();
		if(statussss=="Saved")
		{
			dataJson={"visitId" : visitId,
			"patientId":patientId,
			"flagForDigi":"No",};	
		}
		else
		{
			dataJson={"visitId" : visitId,
					"patientId":patientId,
					 };	
		}
	$.ajax({
				type : "POST",
				contentType : "application/json",
				url : url,
				data : JSON.stringify(dataJson),
				dataType : "json",
				// cache: false,
				success : function(response) {
				var datas = response.data;
				var trHTML = '';
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
				$.each(datas, function(i, item) {
	
					
					    var investigationName=item.inveName;
						var icdName=item.icdName;
						var system=item.system;
						var medicalCategory=item.medicalCategory;
						  categoryType=item.categoryType;
						var categoryDate=item.categoryDate;
						var duration=item.duration;
						var nextCategoryDate=item.nextCategoryDate;
						var patientMedicalCategoryId=item.patientMedicalCategoryId;
						var diagnosisId=item.diagnosisId;
						var medicalCategoryId=item.medicalCategoryId;
						var selectCheck=item.applyFor;
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
						if(icdName!=undefined && icdName!="" )
						msgOfICDDiagnosis+=" "+icdName;
						if(categoryDate!=undefined && categoryDate!="")
						msgOfCatdate+=" "+categoryDate;
						if(nextCategoryDate!=undefined && nextCategoryDate!="")
							msgOfNextCategoryDate+=" "+nextCategoryDate;
						var checkValue = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1"><span class="cus-checkbtn"></span></div>';
						var tr='<tr><td><div class="form-check form-check-inline cusCheck">';
						if(selectCheck=='Y')
						{
							 checkValue = '<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1" checked><span class="cus-checkbtn"></span></div> ';
							 tr='<tr><td><div class="form-check form-check-inline cusCheck">';
						}
						if(diagnosisId!=null && diagnosisId!=undefined && mbStatus=='P')
						{
							func1='fillDiagnosisCombo';
				    		 url1='opd';
				    		 url2='getIcdListByName';
				    		 flaga='diagnosisMe';
				    		 
							trHTML+=tr+checkValue+' <td>';
							trHTML+=' <div class="autocomplete forTableResp">';
							trHTML+='<input type="text" class="form-control" '+approvalFlagDiasable+' name="diagnosisId" id="diagnosisId'+i+'" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" placeholder="Diagnosis" value="'+icdName+'" />';
							trHTML+='<div id="diagnosisMeDiv'+i+'" class="autocomplete-itemsNew"></div>';
							trHTML+='</div>';
							trHTML+=' </td>	';
							
							func2='fillMedicalCategoryData';
				    		 url2='medicalBoard';
				    		 url3='getMedicalBoardAutocomplete';
				    		 flagb='compositeCategory';
				    		 
							trHTML+='  <td>';
							trHTML+=' <div class="autocomplete forTableResp">';
							trHTML+='<input type="text" id="medicalCategoryId" onblur="fillMedicalCategoryData(this.value,this);" '+approvalFlagDiasable+' value="'+medicalCategory+'" onKeyUp="getNomenClatureList(this,\''+func2+'\',\''+url2+'\',\''+url3+'\',\''+flagb+'\');"  class="form-control">';
							trHTML+='<input type="hidden" id="diagnosisiIdMC" name="diagnosisiIdMC" value="'+diagnosisId+'"/>';
							trHTML+='<input type="hidden" id="medicalCategoryValueId" name="medicalCategoryValueId" value="'+medicalCategoryId+'"/>';
							trHTML+='<input type="hidden" id="patientMedicalCatId" name="patientMedicalCatId" value="'+patientMedicalCategoryId+'"/>';
							trHTML+='<div id="compositeCategoryForDetailDiv'+i+'" class="autocomplete-itemsNew"></div>';
							trHTML+='</div> ';
							trHTML+='</td>';
							var systemArrary = ["S","H","A","P","E"]; 
							trHTML+=' <td>';
							trHTML+='<select class="form-control" name=system id="system'+i+'" '+approvalFlagDiasable+'>';
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
							trHTML+='<select class="form-control" name=typeOfCategory id="typeOfCategory'+i+'" onchange="getdurationByType(this);" '+approvalFlagDiasable+'>';
							
							trHTML+='<option value="0">Select</option>';
							if(categoryType!=null && categoryType!="" && categoryType!='0'){
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
								
								trHTML+='<option value="T">Temporary(Week)</option>';
								trHTML+='<option value="P">Permanent(Month)</option>';
							}	
							trHTML+='</select>';
							trHTML+='</td>';
							
							trHTML+='<td>';
							trHTML+='<input type="text" '+approvalFlagDiasable+' name="duration" id="duration'+i+'" value="'+duration+'" onChange="return generateNextDate(this);" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control"> </td>';
							trHTML+='</td>';
							
							trHTML+='<td>';
							trHTML+='<div class="dateHolder">';
							trHTML+=' <input type="text" '+approvalFlagDiasable+' id="categoryDate'+i+'" ';
							trHTML+=' name="categoryDate" class="noFuture_date5 form-control" ';
							trHTML+=' placeholder="DD/MM/YYYY" onChange="return generateNextDate(this);" value="'+categoryDate+'" maxlength="10" />';
							trHTML+='  </div>';
							trHTML+='  </td>';
							
							trHTML+='<td>';
							trHTML+='   <div class="dateHolder">';
							trHTML+=' <input type="text" '+approvalFlagDiasable+' id="nextcategoryDate'+i+'" name="nextcategoryDate" class="input_date form-control" placeholder="DD/MM/YYYY" value="'+nextCategoryDate+'" maxlength="10"/>';
							trHTML+=' </div>';
							trHTML+='  </td>';
							
							trHTML+=' <td>';
							trHTML+='<button type="button" '+approvalFlagDiasable+' type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForMedicalCategory();"></button>';
							trHTML+=' </td>';
							trHTML+=' <td>';
							trHTML+=' <button type="button" name="delete"  class="hideElement" button-type="delete" tabindex="1"  onclick="removeRowMedicalCategory(this)"></button>';
							trHTML+=' </td>';	
							trHTML+=' <td style="display: none";>';
							trHTML+='<input type="hidden" id="diagnosisiIdMCaaa'+i+'" name="diagnosisiIdMC" value="'+diagnosisId+'"/>';
							trHTML+=' </td>';
							trHTML+=' <td style="display: none";>';
							trHTML+='<input type="hidden" id="medicalCategoryValueIdaaa'+i+'" name="medicalCategoryValueId" value="'+medicalCategoryId+'"/>';
							trHTML+=' </td>';
							trHTML+=' <td style="display: none";>';
							trHTML+='<input type="hidden" id="patientMedicalCatIdaaa'+i+'" name="patientMedicalCatId" value="'+patientMedicalCategoryId+'"/>';
							trHTML+=' </td>';
							trHTML+=' <td style="display: none";>';
							trHTML+='<input type="hidden" id="dateOfOrigin'+i+'" name="dateOfOrigin" value="'+dateOfOrigin+'"/>';
							trHTML+=' </td>';
							trHTML+=' <td style="display: none";>';
							trHTML+='<input type="hidden" id="placeOfOrigin'+i+'" name="patientMedicalCatId" value="'+placeOfOrigin+'"/>';
							trHTML+=' </td>';
							i++;
						}
				   });
				}
				$('#medicalCategory').append(trHTML);
				
		
				}
    });
	}
	
function getAFMSFInvestigation() {
	 var saveInDraft=$('#saveInDraft').val();
	 	var disableFlag="";
	 	if(saveInDraft=='ea'|| saveInDraft=='ej'){
	 		disableFlag='disabled';
	 	}
	 	else{
	 		disableFlag="";
	 	}
	var investigationGridValue = "investigationGrid";
	var investigationData="";
	var visitId = $('#visitId').val();
	var opdPatientDetailId=$('#opdPatientDetailId').val();
	var patientId=$('#patientId').val();
	var investigationGridValidate="investigationGrid";
	var data = {
		"mbFlag" : "Y",
		"vstatus":$('#statussss').val(),
		"visitId":visitId,
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
				url:'getRefferedOpinionDetails',
				data : JSON.stringify(data),
				dataType : "json",
				success : function(res) {
					data = res.listObject;
					 
					var count = 1;
					var countins = 1;
					var investigationfinalValue = "";
					var diasableValue="disabled";
					var diasableValueCheck=" ";
					var checkedVal="";
					if (data != null && data.length > 0) {
						$('#totalLengthDigiFile').val(data.length);
						for (var i = 0; i < data.length; i++) {
							investigationData += '<tr>';
							if(data[i].ridcId!=null)
								{
								 diasableValueCheck="disabled";
								checkedVal="checked";
								}
							else{
								diasableValueCheck="";
								checkedVal="";
							}
									
							investigationData += '<td><div   class="autocomplete">';
							investigationData += '<input type="text"  readonly value="'
									+ data[i].investigationName + '['
									+ data[i].investigationId
									+ ']" id="chargeCodeName' + count + '"';
							investigationData += ' class="form-control border-input" '+disableFlag+' name="chargeCodeName" autocomplete="off" onKeyPress="autoCompleteCommonMe(this,1);" onblur="populateChargeCode(this.value,'+ countins +',this);" />';
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
							investigationData += ' </div></td>';
							
							investigationData+='<td><div class="dateHolder"><input type="text" id="investigationDate1" value="'+today+'" name="investigationDatess" class="input_date form-control" placeholder="DD/MM/YYYY" value="" maxlength="10" /></div></td>';
							if(data[i].labMark=="I")
							{
								investigationData+='<td class="text-center"><div class="form-check form-check-inline cusCheck"><input type="checkbox" name="urgent" id="otherAfLabCheck" tabindex="1" class="radioAuto form-check-input" value="O" /><span class="cus-checkbtn"></span></div></td>';		
							}
							else
							{	
							investigationData+='<td class="text-center"><div class="form-check form-check-inline cusCheck"><input type="checkbox" name="urgent" id="otherAfLabCheck" tabindex="1" class="radioAuto form-check-input" checked value="I" /><span class="cus-checkbtn"></span></div></td>';
							}
							investigationData += '	<td>';
							investigationData += '	<input type="text" name="UOM" '+disableFlag+' id="UOM'+count+'" value="'+data[i].uomName+'" class="form-control"  readonly>';
							investigationData += '	</td>';
							investigationData+='<td style="display: none";><input type="hidden" value="'
								+ data[i].investigationId
								+ '"  id="investigationIdValue'
								+ data[i].investigationId + '" tabindex="1" id="inestigationIdval" size="77" name="inestigationIdval" /></td>';

							investigationData+='<td><textarea class="form-control" id="investigationRemarks" value=" " placeholder="investigationRemarks">'+data[i].investagationRemarks+'</textarea></td>';
							
							
							//investigationData += "<td><button id ='printBtn' type='button'  class='btn btn-primary' onclick='viewDocumentForDigi("+data[i].ridcId+");'>View Document</button></td>";
							
							investigationData += '<td><button name="Button" type="button"  class="buttonAdd btn btn-primary noMinWidth"  button-type="add" value="" '+disableFlag+'';
							investigationData += 'onclick="addRowForInvestigationFunUp();"  ';
							investigationData += '	tabindex="1" > </button></td>';

							investigationData += '<td><button type="button" name="delete" value="" '+disableFlag+'  button-type="delete" id="deleteInves"';
							investigationData += 'class="buttonDel btn btn-danger noMinWidth"';
							investigationData += 'onclick="removeRowInvestigationMe(this,\'' + investigationGridValidate + '\',\''+ data[i].dgOrderDtId + '\');"></button></td>';
							investigationData += '<td style="display: none";><input type="hidden"  name="dgOrderDtIdValue" value='
								+ data[i].dgOrderDtId
								+ ' id="dgOrderDtIdValue'
								+ data[i].dgOrderDtId + '"/></td>';
						   investigationData += '<td style="display: none";><input type="hidden"  name="dgOrderHdId" value='
								+ data[i].orderHdId
								+ ' id="dgOrderHdId'
								+ data[i].orderHdId + '"/></td>';
							investigationData += ' </tr> ';
							$("#otherInvestigation").val(data[i].otherInvestigation);
							count++;
						}
						$("#dgInvetigationGrid").html(investigationData);
					}
				}
			});

	return false;
}

function addRowForInvestigationFunUp(){
	 var radioInvAndImaValue='Lab';
	 var tbl = document.getElementById('dgInvetigationGrid');
  	lastRow = tbl.rows.length;
  	i =lastRow;
  	i++;
	    var aClone = $('#dgInvetigationGrid>tr:last').clone(true)
	    aClone.find('img.ui-datepicker-trigger').remove();
		aClone.find(":input").val("");
		aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'chargeCodeName'+i+'');
		aClone.find("td:eq(0)").find("input:eq(3)").prop('id', 'investigationIdValue'+i+'');
		
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
			
			aClone.find("td:eq(0)").find("input:eq(0)").removeAttr("readonly");
			aClone.find("td:eq(2)").find(":checkbox").prop('id', 'otherAfLabCheck'+i+'').prop('checked', true);
			aClone.find('input[type="checkbox"]').removeAttr("disabled");
			aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'investigationDate1'+i+'').val(today).removeClass('input_date hasDatepicker').addClass('input_date');
			aClone.clone(true).appendTo('#dgInvetigationGrid');
			
} 

	
function getMBPreAssesDetailsInvResultData() {
	var visitId = $('#visitId').val();
	var patientId=$('#patientId').val();
	var data = {
		"mbFlag" : "Y",
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
				if(datas!=null &&  datas.length > 0)
				{	
				var trHTML = '';
				var m=200;
				console.log(datas);
				for (var i = 0; i < datas.length; i++) {	   
					    var dgOderHdId=datas[i].orderHdId;
					    var dgOderDtId=datas[i].dgOrderDtId;
					    var investigationName=datas[i].investigationName;
					    var result=datas[i].result;
					    var resultDtId=datas[i].dgResultDt;
					    var uomName=datas[i].uomName;
						
						if(investigationName!=null && investigationName!=undefined)
						{
							
						trHTML+='<td><div class="autocomplete"><input type="text" value="'+investigationName+'" id="chargeCodeName'+m+'" autocomplete="_off" class="form-control border-input" name="chargeCodeName"  size="44" onKeyPrss="autoCompleteCommonMe(this,1);" onKeyUp="autoCompleteCommonMe(this,1);" onblur="populateChargeCode(this.value,1,this);" /><input type="hidden" id="qty" tabindex="1" name="qty1" size="10" maxlength="6" validate="Qty,num,no" /> <input type="hidden" tabindex="1" id="chargeCodeCode" 	name="chargeCodeCode" size="10" readonly /></div></td>';
						trHTML+='<td><div class="dateHolder"><input type="text" id="investigationDate1'+m+'" name="investigationDatess" class="input_date form-control" placeholder="DD/MM/YYYY" value="" maxlength="10" /></div></td>';
						trHTML+='<td class="text-center"><div class="form-check form-check-inline cusCheck"><input type="checkbox" name="urgent" id="otherAfLabCheck'+m+'" tabindex="1" class="radioAuto form-check-input" checked value="I" /><span class="cus-checkbtn"></span></div></td>';
						trHTML+='<td style="display: none";><div class="form-check form-check-inline cusCheck"><input type="checkbox" name="urgent" id="uCheck'+m+'" tabindex="1" class="radioAuto form-check-input" value="1" /><span class="cus-checkbtn"></span> </div></td>';
						trHTML+='<td style="display: none";><input type="hidden" value="" tabindex="1" id="inestigationIdval'+m+'" size="77" name="inestigationIdval" /></td>';
						trHTML+='<td><input type="text" value="'+uomName+'" name="UOM" id="UOM'+m+'" class="form-control" readonly></td>';
						trHTML+='<td><textarea class="form-control" id="investigationRemarks'+m+'" value=" " placeholder="investigationRemarks"></textarea></td>';
						trHTML+='<td><button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForInvestigationFunUp();"></button></td>';
						trHTML+='<td><button type="button" name="delete" value="" class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" onclick="removeRowInvestigation11(this)"></button></td>';
						trHTML+='</tr>';
						i++;
						}
								
				}
				$('#dgInvetigationGrid').append(trHTML);	
			  }	
			}
    });
	}
	
var popup;

function getTemplateDetail111() {

	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getTemplateName";
	
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'doctorId' : <%= userId %>,
					'templateType' : 'I'
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
					var datas = response.template;
					var trHTML = '<option value=""><strong>Select...</strong></option>';
					//var count=0;
					$.each(datas, function(i, item) {
						trHTML += '<option value="' + item.templateId + '" >'
								+ item.templateName + '</option>';
					
					});

					$('#dgInvestigationTemplateId11').html(trHTML);
					$('#updateInvestigationTemplateId').html(trHTML);
					$('#dgInvestigationTemplateIdInvest').html(trHTML);
					
					return true;
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

$(document).delegate("#dgInvestigationTemplateId11","change",
		function() {


	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getTemplateInvestigation";
	
	// var url =
	// "http://localhost:8181/AshaServices/v0.1/opdmaster/getTemplateInvestData";
	
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'employeeId' : <%= userId %>,
					'templateId':$('#dgInvestigationTemplateId11').val()
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
				   if (response.status == 1) {
					//$("#dgInvetigationGrid tr").remove(); 
					var datas = response.data;
					var trHTML = '';
					var i=50;
					var count = 50;
					var countins = 1;
					var investigationfinalValue = "";
					var diasableValue="disabled";
					var diasableValueCheck=" ";
					var checkedVal="";
                  var disableFlag="";
					$.each(datas, function(i, item) {
								var investigationValue=item.investigationName;
									var investigationId=item.templateInvestgationId;
									var investExist=0;
									$('#dgInvetigationGrid tr').each(function(i, el) {

										var invesVal = $(this).find("td:eq(4)").find("input:eq(0)").val();
									if(invesVal==""){
										$(this).closest('tr').remove();
										}
									if(invesVal!="" &&(invesVal==investigationId)){
										investExist=1;
									return false;
									}
									else{
										investExist=0;
									}
									});
										
							if(investExist==0){		
									//trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationValue+''+'['+investigationId+']'+'" id="chargeCodeName1'+i+'" class="form-control border-input" name="chargeCodeName1" onblur="populateChargeCode(this.value,1,this);" /> </div></td><td><div class="dateHolder"> <input type="text" id="investigationDate1Temp'+i+'" name="investigationDatess" class="input_date form-control" placeholder="DD/MM/YYYY" value='+today+' maxlength="10" /></div></td><td><input type="checkbox" name="urgent" id="otherAfLabCheck" tabindex="1" class="radioAuto" value="I" checked/></td><td><input type="checkbox" name="urgent" id="uCheck" tabindex="1" class="radioAuto" value="1" /><td style="display:none";><input type="hidden" value="'+investigationId+'" tabindex="1" id="inestigationIdval2'+i+'" size="77" name="inestigationIdval" /></td> </td><td><button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForInvestigation();"></button></td><td><button type="button" name="delete" value="" class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" onclick="removeRowInvestigation11(this)"></button></td></tr>';
							
							trHTML += '<tr>';		
							trHTML += '<td><div   class="autocomplete">';
							trHTML += '<input type="text"  readonly value="'
									+ investigationValue + '['
									+ investigationId
									+ ']" id="chargeCodeName' + count + '"';
							trHTML += ' class="form-control border-input" '+disableFlag+' name="chargeCodeName" autocomplete="off" onKeyPress="autoCompleteCommonMe(this,1);" onblur="populateChargeCode(this.value,'+ countins +',this);" />';
							trHTML += '<input type="hidden" id="qty" tabindex="1" name="qty1"  maxlength="6"/>';
							trHTML += '<input type="hidden" tabindex="1" id="chargeCodeCode"';
							trHTML += 'name="chargeCodeCode"   readonly />';
							trHTML += '<input type="hidden"  name="investigationIdValue" id="investigationIdValue'+ count + '" value="'+investigationId+'"/>';

							trHTML += '<input type="hidden"  name="dgOrderDtIdValue" value=""/>';
							trHTML += '<input type="hidden"  name="dgOrderHdId" value=""/>';
							trHTML += '<input type="hidden"  name="dgResultHdId" value="" id="dgResultHdId"/>';
							
							trHTML += '<input type="hidden"  name="dgResultDtId" value="" id="dgResultDtId"/>';
							trHTML += ' </div></td>';
							
							trHTML+='<td><div class="dateHolder"><input type="text" id="investigationDate1" value="'+today+'" name="investigationDatess" class="input_date form-control" placeholder="DD/MM/YYYY" value="" maxlength="10" /></div></td>';
							trHTML+='<td class="text-center"><div class="form-check form-check-inline cusCheck"><input type="checkbox" name="urgent" id="otherAfLabCheck" tabindex="1" class="radioAuto form-check-input" checked value="I" /><span class="cus-checkbtn"></span></div></td>';
							
							trHTML += '	<td>';
							trHTML += '	<input type="text" name="UOM" '+disableFlag+' id="UOM'+count+'" value="" class="form-control"  readonly>';
							trHTML += '	</td>';
							trHTML+='<td style="display: none";><input type="hidden" value="'+investigationId+ '"  id="investigationIdValue" tabindex="1" id="inestigationIdval" size="77" name="inestigationIdval" /></td>';

							trHTML+='<td><textarea class="form-control" id="investigationRemarks" value=" " placeholder="investigationRemarks"></textarea></td>';
							
							
							//investigationData += "<td><button id ='printBtn' type='button'  class='btn btn-primary' onclick='viewDocumentForDigi("+data[i].ridcId+");'>View Document</button></td>";
							
							trHTML += '<td><button name="Button" type="button"  class="buttonAdd btn btn-primary noMinWidth"  button-type="add" value="" '+disableFlag+'';
							trHTML += 'onclick="addRowForInvestigationFunUp();"  ';
							trHTML += '	tabindex="1" > </button></td>';

							trHTML += '<td><button type="button" name="delete" value="" '+disableFlag+'  button-type="delete" id="deleteInves"';
							trHTML += 'class="buttonDel btn btn-danger noMinWidth"';
							trHTML += 'onclick="removeRowInvestigation11(this);"></button></td>';
							trHTML += ' </tr> ';
							count++;
							//i++;
							}			
													
					});
					
					$('#dgInvetigationGrid').append(trHTML);
					// $('#investigationGrid').html(trHTML);

				}
				   else
					{
					   $("#dgInvetigationGrid tr").remove(); 
					   var trHTMLBlank='';
					   trHTMLBlank='<tr><td><div class="autocomplete"><input type="text" value=" " id="chargeCodeName'+i+'" class="form-control border-input" name="chargeCodeName" onblur="populateChargeCode(this.value,1,this);" /> <input type="hidden" id="qty" tabindex="1" name="qty1" size="10" maxlength="6" validate="Qty,num,no" /> <input type="hidden" tabindex="1" id="chargeCodeCode"	name="chargeCodeCode" size="10" readonly /> </div></td><td><div class="dateHolder"><input type="text" id="investigationDate1" name="investigationDatess" class="input_date form-control" placeholder="DD/MM/YYYY" value="" maxlength="10" /></div></td><td><input type="checkbox" name="urgent" id="otherAfLabCheck" tabindex="1" class="radioAuto" value="I" checked /></td><td><input type="checkbox" name="urgent" id="uCheck" tabindex="1" class="radioAuto" value="1" /><td style="display:none";><input type="hidden" value="" tabindex="1" id="inestigationIdval" size="77" name="inestigationIdval" /></td> </td><td><button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForInvestigationFunUp();"></button></td><td><button type="button" name="delete" value="" class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" onclick="removeRowInvestigation11(this)"></button></td></tr>';
					   $('#dgInvetigationGrid').append(trHTMLBlank);
					   var inVal=$('#dgInvetigationGrid').children('tr:first').children('td:eq(0)').find(':input')[0]
			           autocomplete(inVal, arryInvestigation);
					  
					}
				}
			   ,
				error : function(e) {

					console.log("ERROR: ", e);

				},
				done : function(e) {
					console.log("DONE");
					alert("success");
					var datas = e.data;

				}
			});

});

function templateUpdate()
{
	alert("Template imported successfully");
}

var arrayData = [];
var i = "";
var invesRadio="";
var investigationForUom="";
function changeRadioForUploa(radioValue){
	invesRadio=radioValue;
	i++;
	
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
			'employeeId' : '1',
			'mainChargeCode':radioValue,
		}),
		dataType : 'json',
		timeout : 100000,
		
		success : function(res)
		
		{
			arryInvestigation=[];
			arrayData=[];
			var data = res.InvestigationList;
			investigationForUom=res.InvestigationList;
			for(var i=0;i<data.length;i++){
				//var investigationId= data[i].investigationId;
				//var investigationName = data[i].investigationName;
				var investigationNewUpdate=data[i];
				var investigationId= investigationNewUpdate[0];
				var investigationName = investigationNewUpdate[1];
				
				var aaaa=investigationName+"["+investigationId +"]"
				
				arryInvestigation.push(aaaa); 
				     			      
			   //   var inChangeValFirst=$('#dgInvetigationGrid').children('tr:last').children('td:eq(0)').find(':input')[0]
			     // var inChangeValLast=$('#dgInvetigationGrid').children('tr:last').children('td:eq(0)').find(':input')[0]
			    //   autocomplete(inChangeValFirst, arrayData);
			      //autocomplete(inChangeValLast, arrayData);
			 
			}
		
           },
           error: function (jqXHR, exception) {
               var msg = '';
               if (jqXHR.status == 0) {
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
function submitMOValidateFormByModel1(){
	
	$('#checkForInve').val(0);
	$('#submitMOValidateFormByModelIdss').attr('disabled',true);
	var valueSave='Save';
	saveInvestigationDetails(valueSave);
	 
}

function submitWithoutInvestigationModel(){
	
	$('#checkForInve').val(0);
	$('#submitWithoutInvestigation').attr('disabled',true);
	var valueSave='Save';
	saveInvestigationDetails(valueSave);
	 
}

function submitMOValidateFormByModel1(){
	
	$('#checkForInve').val(0);
	$('#submitMOValidateFormByModelIdss').attr('disabled',true);
	var valueSave='Save';
	saveInvestigationDetails(valueSave);
	 
}

function showCreateInvestigationTemplate111() {
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var urlCreate = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/showCreateInvestigationTemplate";
    $('#exampleModal .modal-body').load(urlCreate+"?employeeId="+<%= userId %>);
    $('#exampleModal .modal-title').text('Investgation Template');
}


function opdUpdateInvestigationTemplate111() {
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var urlUpdate = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/opdUpdateInvestigationTemplate";
	
	$('#exampleModal .modal-body').load(urlUpdate+"?employeeId="+<%= userId %>);
    $('#exampleModal .modal-title').text('Update Investigation Template');
}

function closeMessageWithoutInv(){
	$('#messageForWithoutInvestigation').hide();
	$('.modal-backdrop').hide();
}


</script>

</body>

</html>