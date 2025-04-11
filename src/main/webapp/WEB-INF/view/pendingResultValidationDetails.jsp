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


<%
	String hospitalId = "";
	if (session.getAttribute("hospital_id") != null) {
		hospitalId = session.getAttribute("hospital_id") + "";
	}
	String userId = "";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	%>
	
<%@include file="..//view/commonJavaScript.jsp"%>

</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">


		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">Pending For Result Validation</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
							<form id="resultValidationForm" name="resultValidationForm" action="" method="">
									
									<input type="hidden" id="orderHdId" name="orderHdId"/>
									<input type="hidden" id ="checkedChkBoxArray" name="checkedChkBoxArray"/>     
									<input type="hidden" id ="SampleIdArray" name="SampleIdArray"/>
									<input type="hidden" id ="resultsArray" name="resultsArray"/>
									<input type="hidden" id ="uomIdsArray" name="uomIdsArray"/>
									<input type="hidden" id ="remarksArray" name="remarksArray"/>
									<input type="hidden" id ="normalIdsArray" name="normalIdsArray"/>
									<input type="hidden" id ="subInvestigationIdsArray" name="subInvestigationIdsArray"/>
									<input type="hidden" id ="rangeStatusArray" name="rangeStatusArray"/>
									
									<input type="hidden" id ="parentInvIdsArray" name="parentInvIdsArray"/>
									<input type="hidden" id ="resultDtIdsArray" name="resultDtIdsArray"/>
									<input type="hidden" id ="resultHdIdsArray" name="resultHdIdsArray"/>
									
									<input type="hidden" id="hospitalIdd" name="hospitalIdd" value="<%=hospitalId%>"/>
									<input type="hidden" id="userId" name="userId" value="<%=userId%>"/> 
									
							
								<div class="card-body">
									
									<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Result Date</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control" id="resultDate" name="resultDate" readonly="readonly"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Time</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control" id="resultTime" name="resultTime" readonly="readonly"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Result Entered By</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control" id="resultEnteredBy" name="resultEnteredBy" readonly="readonly"/>
													</div>
												</div>
											</div>
										</div>
                                    
									
									<!---------------------  Patient Details start here ------------------->

									<div class="adviceDivMain" id="button1" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Patient Detail </span>
										</div>
										<input class="buttonPlusMinus" tabindex="1" name="" id="relatedbutton1" value="-" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10" style="display:block;" id="newpost1">

										<div class="row  m-t-10">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Service No.</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control" id="serviceNo" name="serviceNo" readonly="readonly"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Patient Name</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control" id="patientName" name="patientName" readonly="readonly"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Relation</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control" id="relation" name="relation" readonly="readonly"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Employee Name</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control" id="employeeName" name="employeeName" readonly="readonly"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Age</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control" id="age" name="age" readonly="readonly"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Gender</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control" id="gender" name="gender" readonly="readonly"/>
													</div>
												</div>
											</div>
										
										</div>

									</div>


									<!---------------------- Patient Details end here ---------------------->
									
									<!---------------------  Result Details start here ------------------->

									<div class="adviceDivMain m-b-10" id="button2" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Result Validation Detail </span>
										</div>
										<input class="buttonPlusMinus" tabindex="1" name="" id="relatedbutton2" value="-" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10" style="display:block;" id="newpost2">

										<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Validation Date</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control" id="validatedDate" name="validatedDate" readonly="readonly"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Time</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control" id="validatedTime" name="validatedTime" readonly="readonly"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Validated By *</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control" id="validateBy" name="validateBy" readonly="readonly"/>
													</div>
												</div>
											</div>
																						
										</div>
										
										<table class="table table-hover table-striped table-bordered m-t-10">
											<thead class="bg-primary">
												<tr>
													<th>S.No.</th>
													<th>Investigation</th>
													<th>Sample</th>
													<th>Result</th>
													<th>Units</th>
													<th>Normal Range</th>
													<th>Remarks</th>
												    <th><div class="form-check form-check-inline cusCheck m-l-10"><input type="checkbox" id="validatebox" multiple="multiple" name="validatebox" class="dependCheck form-check-input" checked="checked"><span class="cus-checkbtn"></span><label class="form-check-label"> Validate</label></div></th>
												
												</tr>
											</thead>
											<tbody id="tblResultValInvDetails">
												
											</tbody>
										</table>
										
										
									</div>
									<div class="clearfix"></div>

									<!---------------------- Result Details end here ---------------------->
									
										<div class="row">
											<div class="col-md-12 text-right">
										<input type="button" value="Validate" class="btn btn-primary" id = "submitbtnId" onclick="submitResultValidationDetails();"/>	
												<!-- <button class="btn btn-primary" onclick="submitResultValidationDetails();">Submit</button> -->
												<!-- <button class="btn btn-danger">Reset</button> -->
												<input type="button" class="btn btn-primary opd_submit_btn" id ="backId" value="Back" onclick="backToWaitingList();">
											</div>
										</div>
																			
										
									</div>
								</form>
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

	<!-- jQuery  -->
<script>
    function showhide(buttonId)
     {
		 if(buttonId=="button1"){
					test('related'+buttonId,"newpost1");					
		 }else if(buttonId=="button2"){
					test('related'+buttonId,"newpost2");
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
	
	var htmlTable = "";	
	var $j = jQuery.noConflict();
	var rowcount=0;
	
	
	var dataSubInvestigationList="";
	var dataDetailsObj="";
	var dataFixedValuesList="";
	var dataSingleParaList="";
	var dataParentInvestigationList="";
	var dataTemplateList="";
	var dataNormalValList="";
	var subinvestigations="";
	
	$j(document).ready(function(){
		
		 var globaldata = ${data};
			var data = globaldata.globalListResultValidation;
			for(k=0; k<data.length;k++){
				 
				 
				 dataDetailsObj = data[k].data;
				 dataFixedValuesList = data[k].fixedValues;
				 dataSingleParaList = data[k].singleParameter;
				 dataSubInvestigationList = data[k].subInvestigationList;
				 dataParentInvestigationList = data[k].parentInvestigationList;
				 dataTemplateList = data[k].templateParameter;
				 dataNormalValList = data[k].norValList;
				 
				 console.log(dataParentInvestigationList);
				 console.log(dataSingleParaList);
				 console.log(dataTemplateList);
				 console.log(dataSubInvestigationList);
				 
				
			}
		
	    var dataList=dataDetailsObj;
	    
	    for(i=0;i<dataList.length;i++){
	    	$j('#resultDate').val(dataList[i].resultDate);
	    	$j('#resultTime').val(dataList[i].resultTime);
	    	$j('#resultEnteredBy').val(dataList[i].resultEnteredBy);
			/*PATIENT DETAILS*/
			$j('#serviceNo').val(dataList[i].serviceNo);
			$j('#patientName').val(dataList[i].patientName);
			$j('#relation').val(dataList[i].relationName);
			$j('#rank').val(dataList[i].designation);
			$j('#employeeName').val(dataList[i].employeeName);
			$j('#age').val(dataList[i].age);
			$j('#gender').val(dataList[i].gender);
			/*SAMPLE DETAILS*/
			$j('#validatedDate').val(dataList[i].currentDate);
			$j('#validatedTime').val(dataList[i].currentTime);
			$j('#validateBy').val(dataList[i].validatedBy);
			
			//$j('#diagnosticNo').val(dataList[i].orderhdId);
			$('#patientId').val(dataList[i].patientId);
			$('#departmentId').val(dataList[i].departmentId);
			$('#departmentName').val(dataList[i].departmentName);
			$('#orderHdId').val(dataList[i].orderHdId);
			
	    }
	    
	  var countNN=1;
	  var counter1=1;
	  var parentInvName='';
	  var counter =1;
	    var parentIdcount=1;
	    var htmlTable1="";
	    var resultType ="";
	    var htmlTable="";
	    
	   
	    /*@ Start Single Parametere Grid*/
	     for(j=0; j<dataSingleParaList.length; j++){
	    	
				htmlTable1+="<tr id='"+dataSingleParaList[j].investigationId+"' >";
				htmlTable1+="<td style='width: 150px;'>"+parentIdcount+"</td>"
				htmlTable1+= "<td style='width: 150px;'><input class='form-control border-input' type='text' name='investigationName' value='"+dataSingleParaList[j].investigationName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' name='investigationId' id='"+dataSingleParaList[j].investigationId+"' value='"+dataSingleParaList[j].investigationId+"' readOnly='readOnly'/></td>";
				htmlTable1+= "<td style='width: 150px;'><input class='form-control border-input' type='text' name='sampleDescription' id='sampleId"+dataSingleParaList[j].sampleId+"'  value='"+dataSingleParaList[j].sampleDescription+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' name='sampleId' id='"+dataSingleParaList[j].sampleId+"'  value='"+dataSingleParaList[j].sampleId+"' readOnly='readOnly'/></td>";
				if(dataSingleParaList[j].rangeStatus == 'OR'){
					htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' style='color: red ; font-weight: bold' name='result' id='"+dataSingleParaList[j].result+"' value='"+dataSingleParaList[j].result+"' autocomplete='off'/></td>";
				}
				if(dataSingleParaList[j].rangeStatus == 'IR'){
					htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='result' id='"+dataSingleParaList[j].result+"' value='"+dataSingleParaList[j].result+"' autocomplete='off'/></td>";
				}
				if(dataSingleParaList[j].rangeStatus== "" || dataSingleParaList[j].rangeStatus == "null"){
					htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='result' id='"+dataSingleParaList[j].result+"' value='"+dataSingleParaList[j].result+"' autocomplete='off'/></td>";
				}
				if(dataSingleParaList[j].rangeStatus== "" || dataSingleParaList[j].rangeStatus == "null"){
					htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='uomId' id='"+dataSingleParaList[j].uomId+"' value='"+dataSingleParaList[j].uomName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' id='"+dataSingleParaList[j].uomId+"'/></td>";	
				}else{
					htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='uomId' id='"+dataSingleParaList[j].uomId+"' value='"+dataSingleParaList[j].uomName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' id='"+dataSingleParaList[j].uomId+"'/></td>";
				}
				
				htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='normalRange' id='normalRange'  value='"+dataSingleParaList[j].rangeValue+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' name='normalIds' id='"+dataSingleParaList[j].normalId+"'  value='"+dataSingleParaList[j].normalId+"' readOnly='readOnly'/></td>";
				htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='remarks' id='remarks"+parentIdcount+"' value='"+dataSingleParaList[j].remarks+"' autocomplete='off'/></td>";
				htmlTable1+="<td style='width: 150px;'><div class='form-check form-check-inline cusCheck m-l-10'><input type='checkbox' class='dependCheck' id='validateCheckBoxes"+parentIdcount+"' name='validateCheckBoxes' checked='checked' onclick=''/><span class='cus-checkbtn'></span></td>"; /* multiselectValidateCheckBox(this); checkForAccept(this); */
				htmlTable1+="<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='resulEntHdId' id='"+dataSingleParaList[j].resultEntryHdId+"' value='"+dataSingleParaList[j].resultEntryHdId+"'/></td>";
				htmlTable1+="<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='resulEntDtId' id='"+dataSingleParaList[j].resultEntryDtId+"' value='"+dataSingleParaList[j].resultEntryDtId+"'/></td>";
				htmlTable1+="<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='rangestatus' id=''  value='"+dataSingleParaList[j].rangeStatus+"'/></td>";
				htmlTable1+="<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='parentInvestigationId' id=''  value='"+dataSingleParaList[j].investigationId+"'/></td>";
				htmlTable1+="</tr>"	
				
				parentIdcount++;	
			
			
	    }
	     /*End Single Parametere Grid*/
	    
	     /*@ Template Parametere Grid*/
	     for(j=0; j<dataTemplateList.length; j++){
	    	 htmlTable1+="<tr id='"+dataTemplateList[j].investigationId+"' >";
				htmlTable1+="<td style='width: 150px;'>"+parentIdcount+"</td>"
				htmlTable1+= "<td style='width: 150px;'><input class='form-control border-input' type='text' name='investigationName' value='"+dataTemplateList[j].investigationName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' name='investigationId' id='"+dataTemplateList[j].investigationId+"' value='"+dataTemplateList[j].investigationId+"' readOnly='readOnly'/></td></td>";
				htmlTable1+= "<td style='width: 150px;'><input class='form-control border-input' type='text' name='sampleDescription' id='sampleId"+dataTemplateList[j].sampleId+"'  value='"+dataTemplateList[j].sampleDescription+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' name='sampleId' id='"+dataTemplateList[j].sampleId+"'  value='"+dataTemplateList[j].sampleId+"' readOnly='readOnly'/></td>";
				htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='result' id='"+dataTemplateList[j].result+"' value='"+dataTemplateList[j].result+"'/></td>";
				
				if(dataTemplateList[j].rangeStatus == 'OR'){
					htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' style='color: red ; font-weight: bold' name='result' id='"+dataTemplateList[j].result+"' value='"+dataTemplateList[j].result+"'/></td>";
				}
				else if(dataTemplateList[j].rangeStatus == 'IR'){
					htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='result' id='"+dataTemplateList[j].result+"' value='"+dataTemplateList[j].result+"'/></td>";
				}
				else{
					htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='result' id='"+dataTemplateList[j].result+"' value='"+dataTemplateList[j].result+"'/></td>";
				}
				if(dataTemplateList[j].rangeStatus== "" || dataTemplateList[j].rangeStatus == "null"){
					htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='result' id='"+dataTemplateList[j].result+"' value='"+dataTemplateList[j].result+"'/></td>";
				}
				if(dataTemplateList[j].rangeStatus== "" || dataTemplateList[j].rangeStatus == "null"){
					htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='uomId' id='"+dataTemplateList[j].uomId+"' value='"+dataTemplateList[j].uomName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' id='"+dataTemplateList[j].uomId+"'/></td>";	
				}else{
					htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='uomId' id='"+dataTemplateList[j].uomId+"' value='"+dataTemplateList[j].uomName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' id='"+dataTemplateList[j].uomId+"'/></td>";
				}
				
				
				htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='normalRange' id='normalRange'  value='"+dataTemplateList[j].rangeValue+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' name='normalIds' id='"+dataTemplateList[j].normalId+"'  value='"+dataTemplateList[j].normalId+"' readOnly='readOnly'/></td>";
				htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='remarks' id='remarks"+counter+"' value='"+dataTemplateList[j].remarks+"' autocomplete='off'/></td>";
				htmlTable1+="<td style='width: 150px;'><div class='form-check form-check-inline cusCheck m-l-10'><input type='checkbox' class='dependCheck' id='valchkbox"+counter+"' name='validatebox' checked='checked' onclick=''/><span class='cus-checkbtn'></span></td>"; /* multiselectValidateCheckBox(this); checkForAccept(this); */
				htmlTable1+="<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='resulEntHdId' id='"+dataTemplateList[j].resultEntryHdId+"' value='"+dataTemplateList[j].resultEntryHdId+"'/></td>";
				htmlTable1+="<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='resulEntDtId' id='"+dataTemplateList[j].resultEntryDtId+"' value='"+dataTemplateList[j].resultEntryDtId+"'/></td>";
				htmlTable1+="<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='rangestatus' id=''  value='"+dataTemplateList[j].rangeStatus+"'/></td>";
				htmlTable1+="<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='parentInvestigationId' id=''  value='"+dataTemplateList[j].investigationId+"'/></td>";
				htmlTable1+="</tr>"
				
					parentIdcount++;
	     }
	     /*End Parametere Grid*/
	     
	    /*@ Multi Parametere Grid*/	
	    
	    for(k=0; k<dataParentInvestigationList.length;k++){
	    	if(dataParentInvestigationList[k].investigtionType=="m"){
	    		
	    		htmlTable1+="<tr id='"+dataParentInvestigationList[k].investigtionId+"' >";
 				htmlTable1+="<td style='width: 150px;'>"+parentIdcount+"</td>"
 				htmlTable1+="<td style='width: 150px;'><input  class='form-control border-input' type='text' name='investigationName' value='"+dataParentInvestigationList[k].investigtionName+"' readOnly='readOnly'/></td>";
 				htmlTable1+="<td style='width: 150px;'></td>"
 				htmlTable1+="<td style='width: 150px;'><input class='form-control' type='hidden' id='hdresult' name='hdresult' value='0' autocomplete='off'/></td>"
 				htmlTable1+="<td style='width: 150px;'></td>"
 				htmlTable1+="<td style='width: 150px;'></td>"
 				htmlTable1+="<td style='width: 150px;'></td>"
 				htmlTable1+="<td style='width: 150px; display:none><input type='checkbox' id='chkbox' name='chkbox'/></td>"
 				htmlTable1+="<td style='width: 150px; display:none'></td>"
 				htmlTable1+="<td style='width: 150px; display:none'></td>"
 				htmlTable1+="<td style='width: 150px; display:none'></td>"
 				htmlTable1+="</tr>"
 				
 				var count=1;
	    		for(var sm=0; sm<dataSubInvestigationList.length; sm++){
	    			
	    			if(dataSubInvestigationList[sm].investigatonId == dataParentInvestigationList[k].investigtionId){
	    				
	   	    		 htmlTable1+="<tr id='"+dataSubInvestigationList[sm].subInvestigationId+"' >";
	   					htmlTable1+="<td style='width: 150px;'>"+parentIdcount+"."+count+"</td>"
	   					htmlTable1+= "<td style='width: 150px;'><input class='form-control border-input' type='text' name='subInvestigationName' value='"+dataSubInvestigationList[sm].subInvestigationName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' name='subInvestigationId' id='"+dataSubInvestigationList[sm].subInvestigationId+"' value='"+dataSubInvestigationList[sm].subInvestigationId+"' readOnly='readOnly'/></td></td>";
	   					htmlTable1+= "<td style='width: 150px;'><input class='form-control border-input' type='text' name='sampleDescription' id='sampleId"+dataSubInvestigationList[sm].sampleId+"'  value='"+dataSubInvestigationList[sm].sampleDescription+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' name='sampleId' id='"+dataSubInvestigationList[sm].sampleId+"'  value='"+dataSubInvestigationList[sm].sampleId+"' readOnly='readOnly'/></td>";
	   					if(dataSubInvestigationList[sm].rangeStatus == 'OR'){
	   						htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' style='color: red ; font-weight: bold' name='result' id='"+dataSubInvestigationList[sm].result+"' value='"+dataSubInvestigationList[sm].result+"' autocomplete='off'/></td>";
	   						htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='uomId' id='"+dataSubInvestigationList[sm].uomId+"' value='"+dataSubInvestigationList[sm].uomName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' id='"+dataSubInvestigationList[sm].uomId+"'/></td>";
	   					}
	   					if(dataSubInvestigationList[sm].rangeStatus == 'IR'){
	   						htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='result' id='"+dataSubInvestigationList[sm].result+"' value='"+dataSubInvestigationList[sm].result+"' autocomplete='off'/></td>";
	   						htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='uomId' id='"+dataSubInvestigationList[sm].uomId+"' value='"+dataSubInvestigationList[sm].uomName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' id='"+dataSubInvestigationList[sm].uomId+"'/></td>";
	   					}
	   					if(dataSubInvestigationList[sm].rangeStatus== "" ||  dataSubInvestigationList[sm].rangeStatus == "null"){
	   						htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='result' id='"+dataSubInvestigationList[sm].result+"' value='"+dataSubInvestigationList[sm].result+"' autocomplete='off'/></td>";
	   						htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='uomId' id='"+dataSubInvestigationList[sm].uomId+"' value='"+dataSubInvestigationList[sm].uomName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' id='"+dataSubInvestigationList[sm].uomId+"'/></td>";
	   					}
	   					
	   					/* if(dataSubInvestigationList[sm].rangeStatus== "" ||  dataSubInvestigationList[sm].rangeStatus == "null"){
	   						htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='uomId' id='"+dataSubInvestigationList[sm].uomId+"' value='"+dataSubInvestigationList[sm].uomName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' id='"+dataSubInvestigationList[sm].uomId+"'/></td>";	
	   					}else{
	   						htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='uomId' id='"+dataSubInvestigationList[sm].uomId+"' value='"+dataSubInvestigationList[sm].uomName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' id='"+dataSubInvestigationList[sm].uomId+"'/></td>";
	   					} */
	   					
	   					htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='normalRange' id='normalRange'  value='"+dataSubInvestigationList[sm].rangeValue+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' name='normalIds' id='"+dataSubInvestigationList[sm].normalId+"'  value='"+dataSubInvestigationList[sm].normalId+"' readOnly='readOnly'/></td>";
	   					htmlTable1+="<td style='width: 150px;'><input class='form-control border-input' type='text' name='remarks' id='remarks"+counter+"' value='"+dataSubInvestigationList[sm].remarks+"' autocomplete='off'/></td>";
	   					htmlTable1+="<td style='width: 150px;'><div class='form-check form-check-inline cusCheck m-l-10'><input type='checkbox' class='dependCheck' id='valchkbox"+parentIdcount+"' name='validatebox' checked='checked' onclick=''/><span class='cus-checkbtn'></span></td>"; /* multiselectValidateCheckBox(this); checkForAccept(this); */
	   					htmlTable1+="<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='resulEntHdId' id='"+dataSubInvestigationList[sm].resultEntryHdId+"' value='"+dataSubInvestigationList[sm].resultEntryHdId+"'/></td>";
	   					htmlTable1+="<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='resulEntDtId' id='"+dataSubInvestigationList[sm].resultEntryDtId+"' value='"+dataSubInvestigationList[sm].resultEntryDtId+"'/></td>";
	   					htmlTable1+="<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='rangestatus' id=''  value='"+dataSubInvestigationList[sm].rangeStatus+"'/></td>";
	   					htmlTable1+="<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='parentInvestigationId' id=''  value='"+dataParentInvestigationList[k].investigtionId+"'/></td>";
	   					htmlTable1+="</tr>"
	   						
	   					count++;
	   						
	    			}
	    			
	    		}	
 				
	    	}
	    	
	    	parentIdcount++;
	    	
	    }
	    /*End Multi Parametere Grid*/		
	    
	    if(dataSingleParaList.length==0 && dataSubInvestigationList.length==0 && dataTemplateList.length==0)
		{
			htmlTable = htmlTable+"<tr ><td colspan='8'><h6>No Record Found</h6></td></tr>";
		}
	    
	   		htmlTable+= htmlTable1; 
	    $j("#tblResultValInvDetails").html(htmlTable); 
	    
	    
	    //multiple checkboxes group checked-unchecked
	    $('#validatebox').change(function(){			    	
	    	console.log('checkbox clicked');			    	
	    	if(this.checked){
	    		$('.dependCheck').prop('checked',true);
	    		$('.dependCheck').attr("disabled",false);
	    	}
	    	else{
	    		$('.dependCheck').prop('checked',false);
	    		
	    		
	    	}			    	
	    });
		
	});
	 //end grid
		
		
		
	function submitResultValidationDetails(){
		var flagg = checkedAcceptedAndRejected();
		if(flagg == false){
			return false;
		}else{
			$('#submitbtnId').prop("disabled", true);
				var orderHdId=$('#orderHdId').val();
				document.resultValidationForm.action="${pageContext.request.contextPath}/lab/submitResultValidationDetails?orderHdId="+orderHdId+"";
				document.resultValidationForm.method='POST'
				document.resultValidationForm.submit();
			}
			
		}
	
	
	
	var subInvestigationId='';
	var sampleIds='';
	var results='';
	var normalIds='';
	var remarks='';
	var checkedChkBoxArray=[];
	var subInvestigationIdsArray=[];
	var sampleIdsArray=[];
	var resultArray=[];
	var normalIdsArray=[];
	var remarksArray=[];		
	var resultDtIds ='';
	var resultHdIds = '';
	var rangeStatus='';
	var parentInvIds='';
	var uomIds='';
	var rangeStatusArray=[];
	var resultHdIdsArray = [];
	var resultDtIdsArray=[];
	var parentInvIdsArray=[];
	var uomIdsArray=[];
	
	function checkedAcceptedAndRejected(){
		var flag = true;
		$('#tblResultValInvDetails tr').each(function(i, el) {
			var id = $(this).find("td:eq(7)").find("input:eq(0)").attr("id")
			 if (document.getElementById(id).checked == true) {
				 var checkedChkBox = 'y';
				 
					 	subInvestigationId = $(this).find("td:eq(1)").find("input:eq(1)").attr("id");
						sampleIds = $(this).find("td:eq(2)").find("input:eq(1)").attr("id");
						results = $(this).find("td:eq(3)").find("input:eq(0)").val();
						uomIds = $(this).find("td:eq(4)").find("input:eq(1)").attr("id");
						normalIds = $(this).find("td:eq(5)").find("input:eq(0)").val();
						remarks = $(this).find("td:eq(6)").find("input:eq(0)").val();
						ressultHdIds =  $(this).find("td:eq(8)").find("input:eq(0)").val();
						ressultDtIds =  $(this).find("td:eq(9)").find("input:eq(0)").val();
						rangeStatus =  $(this).find("td:eq(10)").find("input:eq(0)").val();
						parentInvIds =  $(this).find("td:eq(11)").find("input:eq(0)").val();
						
						var resFlag = validateCheckedEnteredResult(results);
						if(resFlag==true){
							checkedChkBoxArray.push(checkedChkBox);
							subInvestigationIdsArray.push(subInvestigationId);
							sampleIdsArray.push(sampleIds);
							resultArray.push(results);
							uomIdsArray.push(uomIds);
							normalIdsArray.push(normalIds);
							remarksArray.push(remarks);
							resultHdIdsArray.push(ressultHdIds);
							resultDtIdsArray.push(ressultDtIds);
							rangeStatusArray.push(rangeStatus);
							parentInvIdsArray.push(parentInvIds);
						
							flag = false;
						}else{
							return false;
						}
						
			 }
			 
			
		});
		//console.log("flag "+flag);
		if(flag){
			alert("Please Select at least one Investigation");
			return false;
		 }
		
		$('#checkedChkBoxArray').val(checkedChkBoxArray);
		$('#SampleIdArray').val(sampleIdsArray);
		$('#resultsArray').val(resultArray);
		$('#uomIdsArray').val(uomIdsArray);
		$('#remarksArray').val(remarksArray);
		$('#normalIdsArray').val(normalIdsArray); 
		$('#subInvestigationIdsArray').val(subInvestigationIdsArray);
		$('#rangeStatusArray').val(rangeStatusArray);
		
		$('#parentInvIdsArray').val(parentInvIdsArray);
		$('#resultDtIdsArray').val(resultDtIdsArray);
		$('#resultHdIdsArray').val(resultHdIdsArray);
		 return true;
		
	}

	//validate checked result
	function validateCheckedEnteredResult(resultValue){
		var value = resultValue;
			if(value!="" ){
				return true
				}else{
					alert("Please Enter the Result");
					return false;
				}
		
		
	}
	
	//function validate only result
	function validateEnteredResult(){
		var countForResult=0;
		$('#tblResultValInvDetails tr').each(function(i, el) {
			var countCheck=i;
			var resultId = "";
			 resultId = $(this).find("td:eq(3)").find("input:eq(0)").val();
			if(resultId==undefined || resultId=="" ){
					countForResult++;
				}
		});
		if(countForResult>0){
			alert("Please Enter the Result");
			return false;
		}
		return true;
	}
	
	
	/*  var globalAcep=0;
	 var globalRej=0;
	 function multiselectAcceptCheckBox(source){
	  	var count = $('#tblResultValInvDetails tr').length;
	 	var countForss=0;
	 	var countuncheck=0;
	 	var totalCheck=0;
	 	  for(var j=1;j<=count;j++){
	 		if(document.getElementById("validateCheckBoxes"+j).checked == true){
	 			countForss++;
	 			totalCheck++;
	 			globalAcep++;
	 		}
	 		else{
	 			
	 			countuncheck++;
	 		}
	 	} 
	 	  if(countuncheck>0){
	 		  $('#validateCheckBoxes').prop('checked', false);  
	 	  }
	 	  if(totalCheck==count){
	 		  $('#validateCheckBoxes').prop('checked', true);
	 		  $('.dependCheck').attr('disabled',false);
	 		  
	 	  }
	 } */ 
	 
	function backToWaitingList(){
		window.location = "pendingResultValidation";
	}
	
  </script>

</body>

</html>