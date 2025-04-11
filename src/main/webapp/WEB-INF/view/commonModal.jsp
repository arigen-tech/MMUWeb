<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%-- <div class="modal" id="messageForAuthenticate" role="dialog" >
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message code="lblUHIDNumber" /></span>

					<button type="button" onClick="closeMessage();" class="close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div class="modal-body">
					<div class="control-group">
						
							<div class='divErrorMsg form-group row' id='errordiv' ></div>
					<div class="form-group row" id="messageForAuthenticateMessae"></div>
					
						<div class="col-md-12">
								<div class="form-group row">
									<label class="col-md-5 col-form-label"><spring:message code="lblUHIDNumber"/> 
									</label>
									<div class="col-md-7">
										<input name="uhidNumber" id="uhidNumber" type="text"
											class="form-control border-input"
											placeholder="" value="" />
									</div>
								</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" id="okButtonOfAuthenticate" 
						onClick="callToAutheniticate();" aria-hidden="true"><spring:message code="btnOK"/></button>
					<button class="btn btn-primary" data-dismiss="modal"
						onClick="closeMessage();" aria-hidden="true"><spring:message code="btnClsoe"/></button>
				</div>
			</div>
		</div>
	</div> --%>
	
	
	 <%-- <div class="modal" id="previousMedicalExamModelId"  role="dialog">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<div id="Message_htext_ME" style="display:none"><span class="Message_htext"><spring:message code="previousME" /></span></div>
					<div id="Message_htext_MB" style="display:none"><span class="Message_htext"><spring:message code="previousMB" /></span></div>

					<button type="button" onClick="closeMe();" class="close"
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
											<td class="SearchStatusForUnitAdmin" style="font-size: 15px;"
												align="left"></td>
											<td>
												<!-- <div id=resultnavigation></div> -->
											</td>
										</tr>
									</table>
								</div>
								<div style="float: right">
									<div id="resultnavigationForMEMBReport"></div>
								</div>
						
						<div class="table-responsive">
						
							<table class="table table-hover table-striped table-bordered m-t-10">
										<thead class="bg-primary">
											<tr>
											<!-- All these changed by Neetu -->
												<!-- <th>Token No.</th> -->
												<!-- <th>Service No.</th> -->
												<!-- <th>Emp Name</th> -->
												<th>Rank</th>
												<!-- <th>Age</th> -->
												<!-- <th>Gender</th> -->
												<th>Medical Cat</th>
												<th><span id="medExam1">Medical Exam</span> <span id="medBoard1">Medical Board</span> </th>
												<th><span id="dateOfExam1">Date of Exam</span><span id="dateOfBoard1">Date of Board</span></th>												
												<!-- <th>Status</th> -->
												<th>Action </th>
											</tr>
										</thead>
										<tbody id="previouseMedicalExamGrid">
										</tbody>
									</table>
						</div>

					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						  aria-hidden="true" onClick="submitCurrentMedication();"><spring:message code="btnSubmit"/></button>
					
					<button class="btn btn-primary" data-dismiss="modal"
						onClick="closeMe();" aria-hidden="true"><spring:message code="btnClose"/></button>	
				</div>
			</div>
		</div>
		
				<div id="medicalEXamReportId">
										  <form  name="medicalExamReportReportId" id="medicalExamReportReportId" method="post" 
											action="${pageContext.request.contextPath}/report/medicalExamReportReport" autocomplete="on">
												<input type="hidden" name="visit_id" id="visit_id" value=""/>   
										</form>	  
										
										
										 <form  name="medicalExamReportReportId" id="medicalExamReportReportId" method="post" 
											action="${pageContext.request.contextPath}/report/medicalExamReportReport" autocomplete="on">
												<input type="hidden" name="visit_id" id="visit_id3b" value=""/>   
											</form>	  
											
											<form  name="medicalExamReportReportId18" id="medicalExamReportReportId18" method="post" 
											action="${pageContext.request.contextPath}/report/medicalExamReportReportF18" autocomplete="on">
												<input type="hidden" name="visit_id" id="visit_id18" value=""/>   
											</form>	

											<form  name="medicalExamReportReportId3A" id="medicalExamReportReportId3A" method="post" 
											action="${pageContext.request.contextPath}/report/medicalExamReportReportF3A" autocomplete="on">
												<input type="hidden" name="visit_id" id="visit_id3a" value=""/>   
											</form>	
											

											<form  name="medicalExamReportReportId2A" id="medicalExamReportReportId2A" method="post" 
											action="${pageContext.request.contextPath}/report/medicalExamReportReportId2A" autocomplete="on">
												<input type="hidden" name="visit_id" id="visit_id2a" value=""/>   
											</form>	
											
											<form  name="medicalExamReportReportId15" id="medicalExamReportReportId15" method="post" 
											action="${pageContext.request.contextPath}/report/mbAmsf15Report" autocomplete="on">
												<input type="hidden" name="visit_id" id="visit_id15" value=""/>   
											</form>	
										
			</div>
			<div id="medicalBoardReportId">
				  <form  name="medicalBoardReportReportId" id="medicalBoardReportReportId" method="post" 
					action="${pageContext.request.contextPath}/report/mbAmsf15Report" autocomplete="on">
						<input type="hidden" name="visit_id" id="visit_id" value=""/>   
				</form>	  
			</div>
	</div>  --%>
	
	
	
	<%-- <div class="modal" id="ImmunizationHistoryModal"  role="dialog">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message code="immunizationHistory" /></span>

					<button type="button" onClick="closeMeImmH();" class="close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				
			<form:form name="patientImmunizzationHistorySubmit" id="patientImmunizzationHistorySubmit" method="post" 
									action="${pageContext.request.contextPath}/medicalexam/submitPatientImmunizationHistory" autocomplete="on">
				<div class="modal-body">
				 	<div class="control-group">
						
					<div class='divErrorMsg form-group row' id='errordiv' ></div>
					<div class="form-group row" id="messageForCurrentMedication"></div>
						
						<div style="float: left">

									<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatusForMassDesignation" style="font-size: 15px;"
												align="left"></td>
										</tr>
									</table>
								</div>
								<div style="float: right">
									<div id="resultnavigationMasDesignation"></div>
								</div>
						
						<div class="table-responsive">
						
							<table class="table table-hover table-striped table-bordered m-t-10">
										<thead class="bg-primary">
											<tr>
												<th>Immunization Name</th>
												<th>Prescription Date</th>
												<th>Immunization Date</th>
												<th>Duration(Years)</th>
												<th>Next Due Date</th>
												<th>Add</th>
												<th>Delete</th>
											</tr>
										</thead>
										<tbody id="immunizationHistoryGrid">
										
										 
										</tbody>
									</table>
						</div>

					</div>
					<div class="text-right">
						 <input type="button" id="saveImmunizationHistoryForCommon" class="btn btn-primary" onClick="return saveImmunizationHistory();" value="Save"/> 
						<input type="button" id="close" class="btn btn-danger" onClick="return closeMeImmH();" value='<spring:message code="btnClose"/>'/>		
					</div>
				</div>
				
				</form:form>
				
			</div>
		</div>
		 
		
	</div>  --%>
	
	<%-- 
	<div class="modal" id="messageForCommonAutoComplete" role="dialog" >
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message code="lblAddItem" /></span>

					<button type="button" onClick="closeMessage();" class="close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div class="modal-body">
					<div class="control-group">
					
						<div class="col-md-12">
						<input name="currentObjectId" id="currentObjectId" type="hidden"
											class="form-control border-input"
											placeholder="" value="" />
									
									<input name="flagForItem" id="flagForItem" type="hidden"
											class="form-control border-input"
											placeholder="" value="" />
									<input name="userNameCommon" id="userNameCommon" type="hidden"
											class="form-control border-input"
											placeholder="" value="" />
								<div class="form-group row">
									<label class="col-md-5 col-form-label"><spring:message code="lblForAddItem"/> 
									</label>
									<div class="col-md-7">
										<input name="addItem" id="addItem" type="text"
											class="form-control border-input"
											placeholder="" value="" />
									</div>
								</div>
								
								<div class="form-group row">
									<label class="col-md-5 col-form-label"><spring:message code="lblForAddItemCode"/> 
									</label>
									<div class="col-md-7">
											<input name="addItemCode" id="addItemCode" type="text"
											class="form-control border-input"
											placeholder="" value="" />
									</div>
								</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" id="saveItemCommonId"
						onClick="saveItemCommon();" aria-hidden="true"><spring:message code="btnSave"/></button>
					<button class="btn btn-primary" data-dismiss="modal"
						onClick="closeMessage();" aria-hidden="true"><spring:message code="btnClsoe"/></button>
				</div>
			</div>
		</div>
	</div>--%>
	
	
	
	 <div class="modal-backdrop show" style="display:none;"></div>
	 
	  <div class="modal-backdrop2" style="display: none;"></div> 
	
	