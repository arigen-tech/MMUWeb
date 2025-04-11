<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Indian Coast Guard</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/leftMenu.jsp"%>
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
<%@include file="..//view/commonJavaScript.jsp"%>

 <%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newOpd.js"></script> --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/medicalexam.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opd.js"></script>
<script type="text/javascript">
var labRadioValue=resourceJSON.mainchargeCodeLab;
var imagRadioValue=resourceJSON.mainchargeCodeRadio;
</script>
<script type="text/javascript">
var uId=<%=userId%>;
$j(document).ready(function(){
	$j('#lab_radio').val(labRadioValue);
	$j('#imag_radio').val(imagRadioValue);
	$j('#labImaginId').val(labRadioValue);
});

</script>


</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">


		<div class="content-page">
				
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">Medical Exam Validate</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
								<form:form name="submitMedicalExamByMo" id="submitMedicalExamByMo" method="post"
									action="${pageContext.request.contextPath}/medicalexam/submitMedicalExamByMoInves" autocomplete="on">
								 <input type="hidden" name="visitId" id="visitId" value="${visitId}"/>
							<input type="hidden" name="patientId" id="patientId" value=""/>
			
							<input type="hidden" name="hospitalId" id="hospitalId" value="<%=hospitalId%>"/>
							<input type="hidden" name="userId" id="userId" value="<%=userId%>"/>		
								<input type="hidden" name="departmentId" id="departmentId" value=""/>	
								<input type="hidden" name="valiCheckValue" id="valiCheckValue" value=""/>	
								<input type="hidden" value="2" name="checkForForm" id="checkForForm">
								<input type="hidden" name="countcheckBoxValue" id="countcheckBoxValue" value="0"/>
								<input type="hidden" name="ageForPatient" id="ageForPatient" value="${age}"/>	
								<input type="hidden" name="ugentCheckValue" id="ugentCheckValue" value=""/>	
								<input type="hidden" name="saveStatus" id="saveStatus" value="v"/>
								 <input  name="labImaginId" id="labImaginId" type="hidden" value="" />	
								 <input type="hidden" name="genderId" id="genderId" value="" />
								 <input type="hidden" name="meAge" id="meAge" value="${meAge}" />
								<input type="hidden" name="drivenValueCheck" id="drivenValueCheck" value="" />
								<input type="hidden" name="drivenDeleteInvestigation" id="drivenDeleteInvestigation" value="" />
								<input type="hidden" name="markAsDivenVal" id="markAsDivenVal" value="" />
										<div class="opdMain_detail_area" id="patientDetailsOthersDiv">
											<h4 class="service_htext">Patient Details</h4>
											<div class="row m-b-10">
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-md-5">
															<label for="service" class="col-form-label">Service No.</label>
														</div>
														<div class="col-md-7">
															<input type="text" name="serviceNo"  id="serviceNo" readonly class="form-control"/>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-md-5">
															<label for="service" class="col-form-label">Patient Name</label>
														</div>
														<div class="col-md-7">
															<input type="text" name="patientName" id="patientName" readonly class="form-control"/>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-md-5">
															<label for="service" class="col-form-label">Age</label>
														</div>
														<div class="col-md-7">
															<input type="text" name="age" id="age" readonly class="form-control"/>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-md-5">
															<label for="service" class="col-form-label">Gender</label>
														</div>
														<div class="col-md-7">
															<input type="text" name="gender" id="gender" readonly class="form-control"/>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-md-5">
															<label for="service" class="col-form-label">Rank</label>
														</div>
														<div class="col-md-7">
															<input type="text" name="rank" id="rank" readonly class="form-control"/>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-md-5">
															<label for="service" class="col-form-label">ME Type</label>
														</div>
														<div class="col-md-7">
															<input type="text" name="meType"  id="meType" readonly class="form-control"/>
														</div>
													</div>
												</div>
											
											<div class="col-md-4">
													<div class="form-group row">
														<div class="col-md-5">
															<label for="service" class="col-form-label">Medical Category</label>
														</div>
														<div class="col-md-7">
															<input type="text" name="medCategory" readonly id="medCategory" class="form-control"/>
														</div>
													</div>
												</div>
											
											</div>
										</div>
										
										<div class="row m-t-20">
											<div class="col-md-4">
												<div class="form-group row">
													<!-- <div class="col-md-5">
														<label for="service" class="col-form-label font-weight-bold">Authority Letter No.</label>
													</div> -->
													<!-- <div class="col-md-7">
														<input type="text" name="authorityLetter" id="authorityLetter" class="form-control"/>
													</div> -->
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<!-- <div class="col-md-12">
														<label for="service" class="col-form-label">
															<a href="#" class="font-weight-bold text-theme text-underline">View Document</a>
														</label>
													</div> -->
													
												</div>
											</div>
										</div>
										
									<!-- 	<div class="row">
											<div class="col-12">
												<h6 class="font-weight-bold">View Document</h6>
											</div>
											<div class="col-sm-12">
												<table class="table table-hover table-striped table-bordered">
													<thead class="bg-primary">
														<tr>
															<th>S.No.</th>
															<th>Document</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td>1</td>
															<td><a href="#" class="font-weight-bold text-theme text-underline">View</a></td>								
														</tr>
													</tbody>
												</table>
											</div>
										</div> -->
										<div class="adviceDivMain" id="button2"
												onclick="showhide(this.id)">
												<div class="titleBg" style="width: 520px; float: left;">
													<span>Physical Capacity</span>
												</div>
												<input class="buttonPlusMinus" tabindex="2" name=""
													id="relatedbutton2" value="-" onclick="showhide(this.id)"
													type="button">
											</div>


											<div class="hisDivHide p-10 m-t-10" id="newpost2" style="display:block;">
												<div class="row">
													<div class="col-md-4">
														<div class="form-group row">
															<div class="col-md-5">
																<label for="service" class="col-form-label">Height
																	<!-- <span class="mandate"><sup>&#9733;</sup></span> -->
																</label>
															</div>
															<div class="col-md-7">
																<div class="input-group mb-2 mr-sm-2">
																	<input type="text" name="height" id="height"
																		class="form-control" maxlength="3"
																		onblur="return idealWeight2();checkBMI();"
																		onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;">
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
																<label for="service" class="col-form-label">Weight
																	Actual <!-- <span class="mandate"><sup>&#9733;</sup></span> -->
																</label>
															</div>
															<div class="col-md-7">
																<div class="input-group mb-2 mr-sm-2">
																	<input type="text" name="weight" id="weight"
																		class="form-control"
																		onblur="checkVaration();checkBMI();"
																		onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;">
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
																<label for="service" class="col-form-label">Ideal
																	Wt <!-- <span class="mandate"><sup>&#9733;</sup></span> -->
																</label>
															</div>
															<div class="col-md-7">
																<div class="input-group mb-2 mr-sm-2">
																	<input type="text" name="idealWeight" id="idealWeight"
																		class="form-control" onblur="checkVaration()"
																		onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;">
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
																<label for="service" class="col-form-label">Over
																	Weight <!-- <span class="mandate"><sup>&#9733;</sup></span> -->
																</label>
															</div>
															<div class="col-md-7">
																<div class="input-group mb-2 mr-sm-2">
																	<input type="text" name="overWeight" maxlength="10"
																		id="overWeight"
																		onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
																		class="form-control" readonly>
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
																<label for="service" class="col-form-label">Waist
																	<!-- <span class="mandate"><sup>&#9733;</sup></span> -->
																</label>
															</div>
															<div class="col-md-7">
																<div class="input-group mb-2 mr-sm-2">
																	<input type="text" name="waist" id="waist"
																		onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
																		class="form-control">
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
																<label for="service" class="col-form-label">Chest
																	Full Expiration <!-- <span class="mandate"><sup>&#9733;</sup></span> -->
																</label>
															</div>
															<div class="col-md-7">
																<div class="input-group mb-2 mr-sm-2">
																	<input type="text" name="chestFullExpansion"
																		id="chestFullExpansion"
																		onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
																		class="form-control">
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
																<label for="service" class="col-form-label">Range
																	of Expansion <!-- <span class="mandate"><sup>&#9733;</sup></span> -->
																</label>
															</div>
															<div class="col-md-7">
																<div class="input-group mb-2 mr-sm-2">
																	<input type="text" name="rangeOfExpansion"
																		id="rangeOfExpansion"
																		onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
																		class="form-control">
																	<div class="input-group-append">
																		<div class="input-group-text">cm</div>
																	</div>

																</div>
															</div>
														</div>
													</div>

                                                    <!--  //////////////////////////////////////////////////////////////////// -->
                                                    <div class="opdMain_detail_area">
															<div class="row">
																
																<div class="col-md-12">
																	<div class="form-group ">
																		<div class="form-check form-check-inline cusCheck">
																		  <input class="form-check-input" type="checkbox" name="markAsDiver" id="markAsDiver" onclick="return getMarkAsDiver(this);">
																		  <span class="cus-checkbtn"></span>
																		  <label class="col-form-label" for="fitInChk">Mark as Diver</label>
																		</div>
																	</div>
																</div>
															</div>
		
														</div>
                                                     <!-- ////////////////////////////////////////////////////////////////////////// -->



												</div>
											</div>
						
											<div class="clearfix"></div>
										
										
											<div class="col-12">
												<h6 class="font-weight-bold text-theme text-underline">Investigation Details</h6>
											</div>
											
											<div class="col-12">
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
															onclick="showCreateInvestigationTemplate222();">
														
														<input name="updateTemplate" tabindex="1"
																	type="button" value="Update Template" data-toggle="modal" data-target="#exampleModal" class="btn btn-primary"
																	onclick="opdUpdateInvestigationTemplate222()" />
																	
															<input name="investigation" tabindex="1"
																	type="button" value="Import New" class="btn btn-primary"
																	onclick="getTemplateDetail222('1')" />
													
												</div>

											</div>
											</div>
										
											<div class="col-12  m-b-10">
											<div class="form-check form-check-inline cusRadio m-l-5">
                                                   <input class="form-check-input" type="radio" name="labradiologyCheck" checked="checked"
												  onchange="changeRadio(this.value)" value="" id="lab_radio" />
                                               <span class="cus-radiobtn"></span> 
                                               <label class="form-check-label m-l-5" for="lab_radio">Laboratory</label>
                                              </div>
                                             <div class="form-check form-check-inline cusRadio">
                                                <input type="radio" value="" id="imag_radio" class="radioCheckCol2 form-check-input "  name="labradiologyCheck" onchange="changeRadio(this.value)" />
                                                <span class="cus-radiobtn"></span> 
                                                <label class="form-check-label m-l-5" for="imag_radio">Imaging</label>
                                             </div>
											</div>
											<div class="col-sm-12">
												<table class="table table-hover table-striped table-bordered">
													<thead class="bg-primary">
														<tr>
															<th style="display:none;">S.No.</th>
															<th>Investigation Name</th>
															<th>Outside AF Lab</th>
															 <th style="display: none">Urgent</th> 
															  <th>Investigation Remarks</th> 
															<th>Add</th>
															<th>Delete</th>
														</tr>
													</thead>
													<tbody id="dgInvetigationGrid">
														<tr>
															<td style="display:none;">1</td>
																<td>
																	<div class="autocomplete forTableResp">
																		
																		<!-- <input type="text" autocomplete="off"  value="" id="investigationName1"
																			class="form-control border-input"
																			name="investigationName" size="44" onKeyPress="autoCompleteCommonMe(this,1);"
																			 onKeyUp="autoCompleteCommonMe(this,1);" onblur="populateChargeCode(this.value,'1',this);" />
																	 	 -->
																	 	  <input type="text" autocomplete="never" value="" id="chargeCodeName"
																			class="form-control border-input"
																			name="chargeCodeName" onKeyUp="getNomenClatureList(this,'populateChargeCode','medicalexam','getInvestigationListUOM','investigationMe');"   size="44"/>
																		
																	 	 
																	 		 <input type="hidden" tabindex="1" id="investigationIdValue"
																			name="investigationIdValue" size="10" readonly /> <input
																			type="hidden" name="examTypeId" value=""
																			id="examTypeId" /> <input type="hidden"
																			name="appointmentId" value=""
																			id="appointmentId1" />
																			 <input type="hidden"  name="dgOrderDtIdValue" value="" id="dgOrderDtIdValue"/>
																 				<input type="hidden"  name="dgOrderHdId" value="" id="dgOrderHdId"/>
																		
																		<div id="investigationDivMe" class="autocomplete-itemsNew"></div>	
																	</div>
																</td>
															
															<td>
																<div class="form-check form-check-inline cusCheck m-l-10">
																  <input class="form-check-input position-static" type="checkbox" checked id="checkboxId1">
																	<span class="cus-checkbtn"></span> 
																</div>
															</td>
															<td style="display: none"><input type="checkbox" name="urgent"
																	id="uCheck" tabindex="1" class="radioAuto" value="1" />
																</td>
																
														<td>
														 	<textarea class="form-control"  name="investigationRemarks" id="investigationRemarks" rows="2" maxlength="500"></textarea>
														 </td>
															
															<td><button name="Button" type="button"  class="buttonAdd btn btn-primary noMinWidth" button-type="add" value=""  
												 				onclick="addNewRowForInvestigation();" 
												 				tabindex="1" ></button></td> 
															
															<td>
																	<button type="button" name="delete" value="" id="newIdInv"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" onclick="removeRowInvestigationMe(this, investigationGrid,0);"></button>
																</td>						
														</tr>
												
												
													</tbody>
												</table>
											</div>
										
										<div class="col-12">
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
													 
												 
                                                                 <div class="form-group row">
                                                                     <label class="col-md-5 col-form-label"> Date of Investigation   </label>
                                                                     <div class="col-md-7">
                                                                     	<div class="dateHolder">
                                                                         <input type="text" class="form-control noFuture_date2" name="dateOfInvestigation" id="dateOfInvestigation" placeholder="DD/MM/YYYY" />
                                                                         </div>
                                                                     </div>
                                                                 </div>
                                               
												</div>
											</div> 
										</div>
										
										<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->	
									<div  id="markDiverInvestigation" style="display:none;">
									<div class="col-12  m-b-10">
                                             <div class="form-check form-check-inline">
                                                <label class="form-check-label m-l-5" for="imag_radio">Diver's Investigation</label>
                                             </div>
											</div>
										<div   class="col-sm-12" >
										<table class="table table-hover table-striped table-bordered">
													<thead class="bg-primary">
														<tr>
															<th>Investigation Name</th>
															<th>Last Done On</th>
															<th>Done On</th>
															 <th>Duration (in years)</th> 
															 <th>Next Due On</th> 
															<th>Action</th>
															 
														</tr>
													</thead>
													<tbody id="markDiverInvestigationGrid">
													</tbody>
												</table>
										
										
										</div>
										</div>
							<!-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->			
										
										
										
										
										
										<div class="col-12">
										<div class="row m-t-10">
											<div class="col-md-12 text-right">
												
												<input type="button" id="submitByMo" class="btn btn-primary" onclick="return submitFormByMO('2');"
															value="Validate"/>
															
												<!-- <button type="submit" class="btn btn-primary">Validate</button> -->
											</div>
										</div>
										</div>
								</form:form>
									
									</div>

								</div>
							</div>
						</div>
					</div>

				</div>
				<!-- container -->

			</div>
			<!-- content -->
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


<div class="modal" id="messageForInvestigationOutside" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<span class="Message_htext"><spring:message
								code="outsideLab" /></span>

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
						<button class="btn btn-primary" data-dismiss="modal"
							onClick="submitMOValidateFormByModel();" id="submitMOValidateFormByModelId"aria-hidden="true">
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

</div>

		<!-- ============================================================== -->
		<!-- End Right content here -->
		<!-- ============================================================== -->

	<!-- END wrapper -->

<div class="modal-backdrop show" style="display:none;"></div>
	<script type="text/javascript">
	var arryInvestigation = new Array();
	 var investigationForUom="";
	function showhide(buttonId) {
		if (buttonId == "button1") {
			test('related' + buttonId, "newpost1");
		} else if (buttonId == "button2") {
			test('related' + buttonId, "newpost2");
		} else if (buttonId == "button3") {
			test('related' + buttonId, "newpost3");
		} else if (buttonId == "button4") {
			test('related' + buttonId, "newpost4");
		} else if (buttonId == "button5") {
			test('related' + buttonId, "newpost5");
		} else if (buttonId == "button6") {
			test('related' + buttonId, "newpost6");
		} else if (buttonId == "button7") {
			test('related' + buttonId, "newpost7");
		} else if (buttonId == "button8") {
			test('related' + buttonId, "newpost8");
		} else if (buttonId == "button9") {
			test('related' + buttonId, "newpost9");
		} else if (buttonId == "button10") {
			test('related' + buttonId, "newpost10");
		} else if (buttonId == "button11") {
			test('related' + buttonId, "newpost11");
		} else if (buttonId == "button12") {
			test('related' + buttonId, "newpost12");
		} else if (buttonId == "button13") {
			test('related' + buttonId, "newpost13");
		} else if (buttonId == "button14") {
			test('related' + buttonId, "newpost14");
		} else if (buttonId == "button15") {
			test('related' + buttonId, "newpost15");
		}

	}

	function test(buttonId, newpost) {
		var x = document.getElementById(newpost);
		if (x.style.display != "block") {
			x.style.display = "block";
			document.getElementById(buttonId).value = "-";
		} else {
			x.style.display = "none";
			document.getElementById(buttonId).value = "+";
		}
	}
	
	
	// $(document).ready(
	 		function getInvestigationListsss() {
	 			var radioValue = labRadioValue; 
	 			invesRadio=radioValue;
	 	var pathname = window.location.pathname;
	 	var accessGroup = "MMUWeb";

	 	var url = window.location.protocol + "//"
	 			+ window.location.host + "/" + accessGroup
	 			+ "/opd/getIinvestigationList";
	 	$.ajax({
	 		type : "POST",
	 		contentType : "application/json",
	 		url : 'getInvestigationListUOM',
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
	 }
	        
                       
            $(document).ready(function() {
            	getPatientDetailToValidate();
            	getTemplateDetail222('2');
            	getcurrentDate();
            });
            
          
            var charge_code_array = [];
	        var ChargeCode='';
	        var multipleChargeCode = new Array();
	     function populateChargeCode(val,count,item) 
	 	{
	        	
	        //	if(validateMetaCharacters(val)){

	        	if(val != "")
	        		{
	        			
	        		    var index1 = val.lastIndexOf("[");
	        		    var indexForChargeCode=index1;
	        		    var index2 = val.lastIndexOf("]");
	        		    index1++;
	        		    ChargeCode = val.substring(index1,index2);
	        		    
	        		    var indexForChargeCode=indexForChargeCode--;
	        		if(ChargeCode == "")
	        		{
	        		return;
	        		}
	        		else{
	        			var uomName = '';
 		    		     	  for(var i=0;i<investigationForUom.length;i++){
 		    		     		 // var pvmsNo1 = data[i].pvmsNo;
 		    		     		 var masInvestigationValues= investigationForUom[i];
 		    		     		 var chargeCodeUom=masInvestigationValues[0];
 		    		     		
 		    		     	if(ChargeCode == chargeCodeUom){
 		    		     			  
 		    		     		  if(masInvestigationValues[3]!=null && masInvestigationValues[3]!="")
 		    		     			uomName = masInvestigationValues[3];//UOM Name;
	        		
	        			var checkCurrentRowIddd=$(item).closest('tr').find("td:eq(1)").find("input:eq(1)").attr("id");
	        			var checkCurrentRow=$(item).closest('tr').find("td:eq(1)").find("input:eq(1)").val();
	   			         var count=0;   			
	   			        $('#dgInvetigationGrid tr').each(function(i, el) {
	        			    var $tds = $(this).find('td');
	        			    var chargeCodeId=  $($tds).closest('tr').find("td:eq(1)").find("input:eq(1)").attr("id");
	       			        var chargeCodeIdValue=$('#'+chargeCodeId).val();
	       			        var idddd =$(item).closest('tr').find("td:eq(1)").find("input:eq(1)").attr("id");
	       			        var currentidddd=$(item).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
	       			    	  if(chargeCodeId!=checkCurrentRowIddd && ChargeCode==chargeCodeIdValue)
	       			          {
	       			    		  	if(ChargeCode==chargeCodeIdValue){
	       			       			alert("Investigation is already added");
	       			        		$('#'+idddd).val("");
	       			        		$('#'+currentidddd).val("");
	       			        		$('#'+chargeCodeIdValue).val("");
	       			        		return false;
	       			           }
	       			            }
	       			            else
	       			        	{
	       			            	$(item).closest('tr').find("td:eq(1)").find("input:eq(1)").val(ChargeCode);
	       			            	//$(item).closest('tr').find("td:eq(2)").find("input:eq(0)").val(uomName);
	       			            	
	       			        	
	       			        	}
	   			     	}); 
	 			    }
	        	}
	        		  }
	        		
	        		
	      		}
	      	  }
	        
      		 
      		 
      		 
      		 
      		 
      		 var lastRow;
      	     var i=0;
      	      function addNewRowForInvestigation(){
      	     	  var tbl = document.getElementById('dgInvetigationGrid');
      	        	lastRow = tbl.rows.length;
      	        	i =lastRow;
      	        	i++;
      	     	  var aClone = $('#dgInvetigationGrid>tr:last').clone(true)
      	     		aClone.find(":input").val("");
      	    		aClone.find("td:eq(0)").html(i);
      	    		
      	     		aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'investigationName'+i+'');
      	     		aClone.find("td:eq(1)").find("input:eq(1)").prop('id', 'investigationIdValue'+i+'');
      	     		aClone.find("td:eq(1)").find("input:eq(2)").prop('id', 'examTypeId'+i+'');
      	     		aClone.find("td:eq(1)").find("input:eq(3)").prop('id', 'appointmentId'+i+'');
      	     		aClone.find("td:eq(1)").find("div").find("div").prop('id', 'investigationDivMe' + i + '');
      	     		
      	     		aClone.find("td:eq(1)").find("input:eq(4)").prop('id', 'dgOrderDtIdValue'+i+'');
      	     		aClone.find("td:eq(1)").find("input:eq(5)").prop('id', 'dgOrderHdId'+i+'');
      	     		
      	     		aClone.find('input[type="checkbox"]').prop('id','checkBoxForValidate'+i+''); 
      	     		aClone.find('input[type="checkbox"]').prop('id','uCheck'+i+''); 
      	     		aClone.find("td:eq(1)").find("input:eq(0)").removeAttr("readonly");
      	     		
      	     		aClone.find("td:eq(2)").find('input[type="checkbox"]').prop('checked', true);
      	     		aClone.find("td:eq(4)").find("textarea:eq(0)").prop('id', 'investigationRemarks'+i+'');
      	     	var	investigationData ='';//Changes "newIdInv" is used when delete the investigation
					investigationData +='<button type="button" name="delete" value="" id="newIdInv"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" onclick="removeRowInvestigation(this);"></button>';
      	     		aClone.find("td:eq(6)").html(investigationData);
      	     		aClone.clone(true).appendTo('#dgInvetigationGrid');
      	     } 
      	      
      	      
      	    function idealWeight2() {
    			var pathname = window.location.pathname;
    			var accessGroup = "MMUWeb";

    			var url = window.location.protocol + "//" + window.location.host
    					+ "/" + accessGroup + "/opd/getIdealWeight";

    			var dataJSON = {

    				'height' : $('#height').val(),
    				'age' : $('#ageForPatient').val(),
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
    					//console.log("SUCCESS: ", data);

    					if (data.status == 1) {
    						//var data = data;
    						//alert("value is "+data.data[0].idealWeight);
    						$('#idealWeight').val(data.data[0].idealWeight);
    						$('#idealWeight').attr("readonly",true);

    					} else {
    						alert("Ideal Weight Not Configured")
    						$('#idealWeight').val();
    						$('#idealWeight').removeAttr("readonly");
    					}

    				},
    				error : function(e) {
    				},
    				done : function(e) {
    					alert("success");
    					var datas = e.data;
    				}
    			});

    		}

    		function checkBMI() {
    			var a = document.getElementById("weight").value;
    			var b = document.getElementById("height").value;
    			var c = b / 100;
    			var d = c * c;
    			var sub = a / d;
    			$('#bmi').val(parseFloat(Math.round(sub * 100) / 100).toFixed(2));

    		}

    		function checkVaration() {

    			var a = document.getElementById("idealWeight").value;
    			var b = document.getElementById("weight").value;
    			if (a != null && b != null && a != "" && b != "") {
    				if (parseFloat(a) > parseFloat(b)) {
    					var sub = a - b;
    					var cal = sub * 100 / a
    					var n = cal.toFixed(2);
    					$('#overWeight').val("-" + n);

    				} else {
    					var eadd = b - a;
    					var cal1 = eadd * 100 / a
    					var n1 = cal1.toFixed(2);
    					$('#overWeight').val("+" + n1);
    				}
    			}
    		}
    		
    		function showCreateInvestigationTemplate222() {
    			var pathname = window.location.pathname;
    			var accessGroup = "MMUWeb";
    			var urlCreate = window.location.protocol + "//"
    			+ window.location.host + "/" + accessGroup
    			+ "/opd/showCreateInvestigationTemplate";
    		    $('#exampleModal .modal-body').load(urlCreate+"?employeeId="+<%= userId %>);
    		    $('#exampleModal .modal-title').text('Investgation Template');
    		}


    		function opdUpdateInvestigationTemplate222() {
    			var pathname = window.location.pathname;
    			var accessGroup = "MMUWeb";
    			var urlUpdate = window.location.protocol + "//"
    			+ window.location.host + "/" + accessGroup
    			+ "/opd/opdUpdateInvestigationTemplate";
    			
    			$('#exampleModal .modal-body').load(urlUpdate+"?employeeId="+<%= userId %>);
    		    $('#exampleModal .modal-title').text('Update Investigation Template');
    		}
    		
    		function getTemplateDetail222(flag) {

    				var pathname = window.location.pathname;
    				var accessGroup = "MMUWeb";
    				var url = window.location.protocol + "//"
    				+ window.location.host + "/" + accessGroup
    				+ "/opd/getTemplateName";
    				
    				$.ajax({
    							url : url,
    							dataType : "json",
    							data : JSON.stringify({
    								'employeeId' : '1',
    								'templateType' : 'I',
    								'doctorId':$('#userId').val()
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
									if(flag=='1')
    								alert("Template Imported Successfully."+"S");
									try{
									$('#dgInvestigationTemplateId11').html(trHTML);	
    								}
    								catch(e){}
    								
    								try{$('#updateInvestigationTemplateId').html(trHTML);}
    								catch(e){}
    								
    								try{$('#dgInvestigationTemplateIdInvest').html(trHTML);}
    								catch(e){}
    								
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
    				
    				$.ajax({
    							url : url,
    							dataType : "json",
    							data : JSON.stringify({
    								'employeeId' : '1',
    								'templateId':$('#dgInvestigationTemplateId11').val()
    							}),
    							contentType : "application/json",
    							type : "POST",
    							success : function(response) {
    								console.log(response);
    							   if (response.status == 1) {
    								//$("#dgInvetigationGridRow tr").remove(); 
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
    			                  var countSno=0;
    			                  var func1='populateChargeCode';
    			                  var url1='medicalexam';
    			                  var url2='getInvestigationListUOM';
    			                  var flaga='investigationMe';
    			                  var investigationGrid='investigationGrid';
    								$.each(datas, function(i, item) {
    											var investigationValue=item.investigationName;
    												var investigationId=item.templateInvestgationId;
    												var investExist=0;
    												$('#dgInvetigationGrid tr').each(function(i, el) {

    													var invesVal = $(this).find("td:eq(1)").find("input:eq(1)").val();
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
    										trHTML += '<tr>';	
    										trHTML += '<td style="display:none;">'+countins+'</td>';
    										
    										
    										trHTML += '<td><div   class="autocomplete forTableResp">';
    									/* 	trHTML += '<input type="text"  readonly value="'
    												+ investigationValue + '['
    												+ investigationId
    												+ ']" id="chargeCodeName' + count + '"';
    										trHTML += ' class="form-control border-input" '+disableFlag+' name="chargeCodeName" autocomplete="off" onKeyPress="autoCompleteCommonMe(this,1);" onblur="populateChargeCode(this.value,'+ countins +',this);" />';
    									 */	
    									 
    										trHTML += '<input type="text"  readonly value="'
												+ investigationValue + '['
												+ investigationId
												+ ']" id="chargeCodeName' + count + '"';
											trHTML += ' class="form-control border-input" '+disableFlag+' name="chargeCodeName" autocomplete="off"   onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
    									 
    										trHTML += '<input type="hidden"  name="investigationIdValue" value="'
    											+ investigationId +'"  id="investigationIdValue' + investigationId + '"/>';
    									
    										trHTML += '<input type="hidden"  name="examTypeId" value=""  id="examTypeId"/>';
    							
    										trHTML += '<input type="hidden"  name="appointmentId" value=" "  id="appointmentId'+count+'"/>';
    										trHTML +='<input type="hidden"  name="dgOrderDtIdValue" value="" id="dgOrderDtIdValue'+count+'"/>';
        									trHTML +='<input type="hidden"  name="dgOrderHdId" value="" id="dgOrderHdId'+count+'"/>';

        									trHTML += '<div id="investigationTemplateMe" class="autocomplete-itemsNew"></div> ';
        									trHTML += ' </div></td>';
    										
    										var chechedValue="checked";
    										trHTML +='<td>';
    										trHTML +='<div class="form-check form-check-inline cusCheck  m-l-10">';
    										trHTML +=' <input checked=checked class="form-check-input position-static" type="checkbox"  name="checkBoxForValidate" id="checkBoxForValidate'+count+'"><span class="cus-checkbtn"></span>';
    										trHTML +='</div>';
    										trHTML +='</td>';
    						
    										
    										trHTML +='	<td style="display: none"><input type="checkbox"   name="urgent"';
    										trHTML +='	id="uCheck'+count+'" tabindex="1" class="radioAuto" value="1" />';
    										trHTML +='</td>';
    										
    										trHTML +='<td>';
    										trHTML +='	<textarea class="form-control"  name="investigationRemarks" id="investigationRemarks'+count+'" rows="2" maxlength="500"></textarea>';
    										trHTML +=' </td>';
    										
    										
    										trHTML += '<td><button name="Button" type="button"  id="newIdInv"  class="buttonAdd btn btn-primary noMinWidth" button-type="add" value="" ';
    										trHTML += 'onclick="addNewRowForInvestigation();"';
    										trHTML += '	tabindex="1" ></button></td>';
    				 					
    										
    										
    										trHTML +='<td>';
    										trHTML +='<button type="button"  name="delete" value="" id="newIdInv"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" onclick="removeRowInvestigationMe(this,\'' + investigationGrid + '\',0);"></button>';
    										 
    										trHTML +='</td>';
    										
    										trHTML += ' </tr> ';
    										count++;
    										countins++;
    										}
    										//i++;
    												
    																
    								});
    								
    								$('#dgInvetigationGrid').append(trHTML);
    								// $('#investigationGrid').html(trHTML);

    							}
    							   else
    								{
    								   $("#dgInvetigationGrid tr").remove(); 
    								   var trHTML='';
    								   trHTML +='<tr>';
    								   trHTML +='<td style="display:none">1</td>';
    								   trHTML +='<td>';
    								   trHTML +='<div class="autocomplete forTableResp">';

    								   /* trHTML +='<input type="text" autocomplete="off"  value="" id="investigationName1"';
    								   trHTML +='class="form-control border-input"';
    								   trHTML +='name="investigationName" size="44" onKeyPress="autoCompleteCommonMe(this,1);"';
    								   trHTML +='onKeyUp="autoCompleteCommonMe(this,1);" onblur="populateChargeCode(this.value,1,this);" />';
    								    */
    								    
    								   trHTML +='<input type="text" autocomplete="off"  value="" id="investigationName1"';
      								   trHTML +='class="form-control border-input"';
      								   trHTML +='name="investigationName" size="44" ';
      								   trHTML +='onKeyUp="getNomenClatureList(this,"populateChargeCode","medicalexam","getInvestigationListUOM","investigationMe");" />';

    								    
    								   trHTML +='<input type="hidden" tabindex="1" id="investigationIdValue"';
    								   trHTML +='name="investigationIdValue" size="10" readonly />'; 
    								   trHTML +='<input type="hidden" name="examTypeId" value=""';
    								   trHTML +='id="examTypeId" />'; 
    								   trHTML +='<input type="hidden" name="appointmentId" value="" id="appointmentId1" />';
    								   
    								   trHTML +='<input type="hidden"  name="dgOrderDtIdValue" value="" id="dgOrderDtIdValue"/>';
   										trHTML +='<input type="hidden"  name="dgOrderHdId" value="" id="dgOrderHdId"/>';
   										
   										trHTML += '<div id="investigationTemplateMe" class="autocomplete-itemsNew"></div> ';
   										
   										trHTML +='</div>';
    								   trHTML +=' </td>';
										
    								   trHTML +='<td>';
    								   trHTML +='<div class="form-check form-check-inline cusCheck m-l-10">';
    								   trHTML +='<input class="form-check-input position-static" type="checkbox" checked id="checkboxId1">';
    								 	trHTML +='<span class="cus-checkbtn"></span>'; 
    								 	  trHTML +='</div>';
    								 	  trHTML +='</td>';
    								 	  trHTML +='<td style="display: none"><input type="checkbox" name="urgent"';
    								 	 trHTML +='	id="uCheck" tabindex="1" class="radioAuto" value="1" />';
    								 		trHTML +='</td>';
											
    								 		trHTML +='<td>';
    								 		trHTML +='<textarea class="form-control"  name="investigationRemarks" id="investigationRemarks" rows="2" maxlength="500"></textarea>';
    								 		trHTML +='</td>';
    								 		trHTML +='<td><button name="Button" type="button"  class="buttonAdd btn btn-primary noMinWidth" button-type="add" value=""';  
    								 			trHTML +='onclick="addNewRowForInvestigation();" ';
    								 			trHTML +='tabindex="1" ></button></td>'; 
    								 				trHTML +='<td>';
    								 				trHTML +=' <button type="button" name="delete" value="" id="newIdInv"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" onclick="removeRowInvestigationMe(this,investigationGrid,0);"></button>';
    								 				trHTML +='</td>';						
    								 				trHTML +='</tr>';
    								   
    								 			$('#dgInvetigationGrid').append(trHTML);
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
    			function removeRowInvestigationMe(val, investigationGrid, investigationData) {
    				 var tbl = document.getElementById('dgInvetigationGrid');
    				 var 	lastRow = tbl.rows.length;
    				if(lastRow>1){
    					$(val).closest('tr').remove();	
    				}
    				
    				
    			}
    			function getcurrentDate(){
    				var todayDate="";
        	    	//$(document).ready(function() {
        	    		todayDate = new Date();
        	    	var dd = String(todayDate.getDate()).padStart(2, '0');
        	    	var mm = String(todayDate.getMonth() + 1).padStart(2, '0');
        	    	var yyyy = todayDate.getFullYear();

        	    	//today =  yyyy + '-' + mm + '-' +dd;

        	    	todayDate = dd + '/' + mm + '/' + yyyy;
        	    	//document.write(today);
        	    	$('#dateOfInvestigation').val(todayDate);
    			//}
    			}
    			localStorage.removeItem('divenSectionValue');
    	        localStorage.clear();
            </script>
</body>

</html>