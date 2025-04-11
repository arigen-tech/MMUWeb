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
<title>MMSY</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%
			String hospitalId = null;
			if (session.getAttribute("mmuId") != null) {
				hospitalId = session.getAttribute("mmuId") + "";
			 
			}
			String userId = null;
			if (session.getAttribute("userId") != null) {
				userId = session.getAttribute("userId") + "";
			}
			
			String userName = null;
			if (session.getAttribute("userName") != null) {
				userName = session.getAttribute("userName") + "";
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
					<div class="internal_Htext">Pending For Result Entry and Validation Details</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
							<form id="resultEntryDetailsForm" name="resultEntryDetailsForm" action="">
						
								
								 <input type="hidden" id="orderHdId" name="orderHdId"/>
								<!-- <input type="hidden" id="unitsIdArray" name="unitsIdArray"/> -->
								<!-- <input type="hidden" id="normalRangesArray" name="normalRangesArray"/> -->
								<!-- <input type="hidden" id="remarksArray" name="remarksArray"/> -->
								<!-- <input type="hidden" id="hiddenSampleCollDtIdArray" name="hiddenSampleCollDtIdArray"/>
								<input type="hidden" id="hiddenSampleCollHdIdArray" name="hiddenSampleCollHdIdArray"/> -->
								
							<input type="hidden" id="resultValTemplate" name="resultValTemplate"/>
							<input type="hidden" id="patientId" name="patientId"/>
							<input type="hidden" id="departmentId" name="departmentId"/>
							<input type="hidden" id="dateOfBirth" name="dateOfBirth"/>
							<input type="hidden" id="genderId" name="genderId"/>
							<input type="hidden" id="relationId" name="relationId"/>
							<input type="hidden" id ="mainChargeCodeId" name="mainChargeCodeId"/>
							<input type="hidden" id ="subChargeCodeId" name="subChargeCodeId"/>
							<input type="hidden" id ="pInvestType" name="pInvestType"/>
							<input type="hidden" id="hospitalIdd" name="hospitalIdd" value="<%=hospitalId%>"/>
							<%-- <input type="text"  name="campName" value="<%=session.getAttribute("campLocation")%>" id="campName" /> --%>
							<input type="hidden" id="userId" name="userId"  value="<%out.print(userId);%>"/> 
							<input type="hidden" id = "orderdtId" name="orderdtId"/>
							
							<input type="hidden" id="resultValTemplateArray" name="resultValTemplateArray"/>
							
								<div class="card-body">
								
									<div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Collection Date</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control" id="collectionDate" name="collectionDate" readonly="readonly"/>
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
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Mobile No</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control" id="mobileNo" name="mobileNo" readonly="readonly"/>
													</div>
												</div>
											</div>
										
										</div>

									</div>


									<!---------------------- Patient Details end here ---------------------->
									
									<!---------------------  Result Details start here ------------------->

									<div class="adviceDivMain m-b-10" id="button2" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Result Entry and Validation Detail </span>
										</div>
										<input class="buttonPlusMinus" tabindex="1" name="" id="relatedbutton2" value="-" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10" style="display:block;" id="newpost2">

										<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Date</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control" id="date" name="date" readonly="readonly" />
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Time</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control" id="time" name="time" readonly="readonly" />
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Entered/Validated By *</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control" id="enteredBy" name="enteredBy" readonly="readonly"/>
													</div>
												</div>
											</div>
																						
										</div>
										
										<table class="table table-hover table-striped table-bordered m-t-10">
											<thead class="bg-primary">
												<tr>
													<!-- <th>S.No.</th> -->
													<th>Sample ID</th>
													<th>Investigation</th>
													<th>Sample</th>
													<th>Result</th>
													<th>Units</th>
													<th>Normal Range</th>
													<th>Remarks</th>
												</tr>
											</thead>
											<tbody id="tblListOfResultEntryInvestigationDetails">
												
											</tbody>
										</table>
										
										
									</div>
									<div class="clearfix"></div>

								
									<!---------------------- Result Details end here ---------------------->
									
										<div class="row">
											<div class="col-md-12 text-right">
											
											<input type="button" id="submitbtnId" class="btn btn-primary" onclick="return submitResultEntryDetails();"
															value="Submit"/>
												<!-- <button class="" id ="submitbtnId" onclick="submitResultEntryDetails();">Submit</button> -->
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
		<!-- for template Entry -->
		 <div class="modal fade" id="showForResultEnterId" tabindex="-1" role="dialog" aria-hidden="true">
			  <div class="modal-dialog modal-xl" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title font-weight-bold">Result Entry</h5>
			        
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      
			      <div class="modal-body">
			      <div class="row">
						<div class="col-12">
							<div id="editorOfResult" name="templateResultEntry"></div>
							</div>
						</div>
			        <div class="row">
			        	<div class="col-12 text-right">
			        		<button class="btn btn-primary" id="submitTemplate" name="submitTemplate" onclick="saveResultInText();">Ok</button>
			        		<button class="btn btn-primary" data-dismiss="modal"> Close</button>
			        	</div>
			        </div>
			      </div>
			      			       
			    </div>
			  </div>
		</div>

	</div>
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
	      
	
	//var htmlTable = "";	
	//var	htmlTable1="";
	var $j = jQuery.noConflict();
	var rowcount=0;
	var sampleCollectionDtId='';
	var diagNo='';
	var parentInvestigationName='';
	var genderr='';
	
	
	var dgorderdtidArray=[];
	var pInvestType1='';
	
	var dataDetailsObj="";
	var dataSubInvestigationList="";
	var dataFixedValuesList="";
	var dataMapFixedValueList="";
	var dataTemplateParameterList="";
	var dataNormalValList="";
	var dataSingleParameterList="";
	var dgFixedValues="";
	
	$j(document).ready(function(){
		
		var globaldata = ${data};
		var data1 = globaldata.globalList;
		for(k=0; k<data1.length;k++){
			 dataDetailsObj = data1[k].data;
			 dataSubInvestigationList = data1[k].subInvestigationList;
			 dataFixedValuesList = data1[k].fixedValues;
			 dataMapFixedValueList = data1[k].mapFixedValue;
			 dataTemplateParameterList = data1[k].dataTemplateParameter;
			 dataNormalValList = data1[k].norValList;
			 dataSingleParameterList = data1[k].dataSingleParameter;
			 dgFixedValuedropdown = data1[k]["subInvestigationList"];
			 
			 for(kk=0;kk<dgFixedValuedropdown.length;kk++){
				dgFixedValues =dgFixedValuedropdown[kk].dgFixedValue;
				console.log(dgFixedValues);
			 }
			 
		}
		
		//patient details Information.
	    var dataList = dataDetailsObj;
	    for(i=0;i<dataList.length;i++){
	    	sampleCollectionDtId = dataList[i].sampleCollectionDtId;
	    	diagNo = dataList[i].diagNo;
	    	parentInvestigationName = dataList[i].parentInvestigationName;
	    	
					$j('#collectionDate').val(dataList[i].collectionDate);
					
					/*PATIENT DETAILS*/
					$j('#mobileNo').val(dataList[i].mobileNo);
					$j('#patientName').val(dataList[i].patientName);
					$j('#relationName').val(dataList[i].relationName);
					$j('#designation').val(dataList[i].rankName);
					$j('#employeeName').val(dataList[i].employeeName);
					$j('#age').val(dataList[i].age);
					$j('#gender').val(dataList[i].gender);
					
					/*SAMPLE DETAILS*/
					$j('#date').val(dataList[i].currentDate);
					$j('#time').val(dataList[i].currentTime);
					$j('#enteredBy').val("<%out.print(userName);%>");
					
					//$j('#diagnosticNo').val(dataList[i].orderhdId);
					
					$('#patientId').val(dataList[i].patientId);
					$('#departmentId').val(dataList[i].departmentId);
					$('#dateOfBirth').val(dataList[i].dateOfBirth);
					$('#genderId').val(dataList[i].genderId);
					$('#relationId').val(dataList[i].relationId);
					$('#mainChargeCodeId').val(dataList[i].mainChargeCodeId);
					$('#subChargeCodeId').val(dataList[i].subChargeCodeId);
					$('#orderHdId').val(dataList[i].orderHdId);
					$('#pInvestType').val(dataList[i].pInvestigationType);
					$('#hospitalId').val(dataList[i].hospitalId);
					$('#userId').val(dataList[i].userId);
					
					$('#orderdtId').val(dataList[i].orderdtId);
					pInvestType1 = $('#pInvestType').val();
					
					
		}
	    
	    var sampleCollectionDtId='';
	    var sampleCollectionHdId='';
	    var parentInvName='';
	    var dgorderdtId = '';
	    
	    
	  //for multiparameter paramenter
	     var dataObj = dataDetailsObj;
	    var normVal = dataNormalValList;
	    var normalValue='';
	    var subInvestigationId='';
	    var range='';
	    
	    //from DG_FIXED_VALUE
	    var keys = [];
			
	    //	subInvestigtion Details based on Investigations  
	    
	  
	    var dataList2 = dataSubInvestigationList;
	    var investigationType='';
	    var investigationId='';
	    var resultType='';
	    var comparisonType='';
	    var uomName='';
	    
	    var htmlTable2="";
	    var pInvestType ='';
	    
	    
//main loop
var countNN=1;
var countForMuktiple=0;
var count=1;
var globalData="";
	for(var i=0;i<dataObj.length;i++){
		countNN=1;
			sampleCollectionDtId = dataObj[i].sampleCollectionDtId
	    	sampleCollectionHdId = dataObj[i].sampleCollectionHdId
	    	parentInvName = dataObj[i].parentInvestigationName
	    	parentInvId = dataObj[i].parentInvestigationId;
	    	pInvestType = dataObj[i].pInvestigationType;
	    	dgorderdtId = dataObj[i].orderdtId
	    	var htmlTable=""
			    	
//child loop

	var counter1=1;
	var counter =1;
	 
	if(pInvestType == 'm' || pInvestType == 'M'){
		counter+=count-1;
		for(j=0; j<dataList2.length; j++){
	    	 investigationType = dataList2[j].investigationType;
	    	 investigationId = dataList2[j].investigationId;
	    	 resultType = dataList2[j].resultType;
	    	 comparisonType = dataList2[j].comparisonType;
	    	 uomName = dataList2[j].uomName;
	    	 var fields = uomName.split('/');
	    	 var result1 = fields[0];
	 		 var result2 = fields[1];
	 		
	 		//subinvestigation fixed value
	 		var dgFixedValues =dataList2[j].dgFixedValue;
	 		var htmlTableaa='<td>';
			htmlTableaa+='<select class="form-control" name="result" id="resultId">';
			htmlTableaa+='<option value="00">Select</option>';
		    for(var key in dgFixedValues){
		    	
				 var keyValue=dgFixedValues[key];
		    	 var keyValueS=keyValue.split('@@');
		    	 htmlTableaa +="<option value='"+keyValueS[0]+"@@"+keyValueS[1]+"'>"+keyValueS[1]+"</option> ";
				}
		    
		    htmlTableaa+='</select>';
		    htmlTableaa+='</td>';
	 		 
	 		 //start table header
	 		 if(parentInvId==investigationId && countNN==1){
	 			var htmlTable1=""
	 			var htmlTable1= htmlTable1+"<tr id='"+sampleCollectionDtId+"' >";
			    /* htmlTable1 = htmlTable1 +"<td style='width: 150px;'>"+counter+"</td>"; */
			    htmlTable1 = htmlTable1 +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='diagNo' id='diagNo' value='"+diagNo+"' readOnly='readOnly'/></td>";
				htmlTable1 = htmlTable1 +"<td style='width: 150px;'>"+parentInvName+"<input  class='form-control border-input' type='hidden' name='parentInvId' id='parentInvId' value='"+parentInvId+"' readOnly='readOnly'/></td>";
				 htmlTable1 = htmlTable1 +"<td style='width: 150px;'></td>";
				 htmlTable1 = htmlTable1 +"<td style='width: 150px; display:none'></td>";
				 htmlTable1 = htmlTable1 +"<td style='width: 150px;'><input class='form-control' type='hidden' id='hdresult' name='hdresult' value='0' autocomplete='off'/></td>";
				 htmlTable1 = htmlTable1 +"<td style='width: 150px;'></td>";
				 htmlTable1 = htmlTable1 +"<td style='width: 150px;'></td>";
				 htmlTable1 = htmlTable1 +"<td style='width: 150px; display:none'></td>";
				 htmlTable1 = htmlTable1 +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='investigationType' id='investigationType' value='"+investigationType+"'/></td>";
				 htmlTable1 = htmlTable1 +"<td style='width: 150px; display:none'></td>";
				 htmlTable1 = htmlTable1 +"<td style='width: 150px; display:none'></td>";
				 htmlTable1 = htmlTable1 +"<td style='width: 150px; display:none'></td>";
				 htmlTable1 = htmlTable1 +"<td style='width: 150px; display:none'></td>";
				 htmlTable1 = htmlTable1 +"<td style='width: 150px; display:none'></td>";
				 htmlTable1 = htmlTable1 +"<td style='width: 150px; display:none'></td>";
				 htmlTable1 = htmlTable1 +"<td style='width: 150px; display:none'></td>";
				 htmlTable1 = htmlTable1+"</tr>";
				 
	 		 	}
	 		//end table header
	 		
	 		if(parentInvId==investigationId){
	 		
		    	htmlTable = htmlTable+"<tr id='"+sampleCollectionDtId+"' >";	    		
	    		/* htmlTable = htmlTable +"<td style='width: 150px;'>"+counter+"."+counter1+""+")"+"</td>"; */
				htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='diagNo' value='---' readOnly='readOnly'/></td>";
				htmlTable = htmlTable +"<td style='width: 150px;'><textarea class='form-control' name='subInvestigationNames' readOnly='readOnly'>"+dataList2[j].subInvestigationName+"</textarea><input  class='form-control border-input' type='hidden' name='subInvestigationIds' value='"+dataList2[j].subInvestigationId+"##"+pInvestType+"' readOnly='readOnly'/></td>";
				htmlTable = htmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='InvestigationIdValueParent' id='InvestigationIdValueParent' value='"+parentInvId+"##"+pInvestType+"' readOnly='readOnly'/></td>";
				htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='sampleDescriptions' value='"+dataList2[j].sampleDescription+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' name='sampleIds' value='"+dataList2[j].sampleId+"'/></td>";
				if(comparisonType == 'f'){
					//htmlTable+=htmlTablea;
					htmlTable+=htmlTableaa;
					htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='fixedValues' id='"+dataList2[j].uomId+"'  value='"+dataList2[j].uomName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' name='uomIds' value='"+dataList2[j].uomId+"'/></td>";
					htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='normalRange' id='normalRange' value='' readOnly='readOnly'/></td>";
				}else if(comparisonType == 'v'){
					if(normVal.length!='0'){
					 for(var ii=0;ii<normVal.length;ii++){
						 if(dataList2[j].subInvestigationId == normVal[ii].subInvestigationId){
							 normalValue = normVal[ii].normalValue;
						    	subInvestigationId = normVal[ii].subInvestigationId;
						    	range = normVal[ii].range;
						    	
						    		var cTypehtmlTable="";
						    		cTypehtmlTable+="<td style='width: 150px;'><input class='form-control type='text' id='result"+counter+"' name='result' value='' autocomplete='off'/></td>";
						    		cTypehtmlTable+="<td style='width: 150px;'><input  class='form-control border-input' type='text' name='normalValues' id='"+dataList2[j].uomId+"' value='"+dataList2[j].uomName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' name='uomIds' value='"+dataList2[j].uomId+"' readOnly='readOnly'/></td>";
						    		cTypehtmlTable+="<td style='width: 150px;'><input  class='form-control border-input' type='text' name='normalRange' id='"+normVal[ii].normalId+"'  value='"+range+"' readOnly='readOnly'/></td>";
						 }
					   }
					}else{
						
						htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='result' id='result"+counter+"' value='' autocomplete='off'/></td>";
						htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' id='"+dataList2[j].uomId+"' name='units' value='"+dataList2[j].uomName+"' readOnly='readOnly'/></td>";
						htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='normalRange' value='"+range+"' readOnly='readOnly'/></td>";
					}
					 htmlTable+=cTypehtmlTable;
				}else if(comparisonType=='n'){
					
					htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='result' id='result"+counter+"' value='' autocomplete='off'/></td>";
					htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' id='"+dataList2[j].uomId+"' name='units' value='"+dataList2[j].uomName+"' readOnly='readOnly'/></td>";
					htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='normalRange' value='' readOnly='readOnly'/></td>";
				}
				
				else{
					htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='result' id='result"+counter+"' value='' autocomplete='off'/></td>";
					htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='normalRange' value='"+range+"' readOnly='readOnly'/></td>";
					//htmlTable+=htmlTablea;
					//htmlTable+=htmlTable +"<td></td>";
					//htmlTable+=htmlTable +"<td></td>";
					htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='units' id='"+dataList2[j].uomId+"'  value='"+dataList2[j].uomName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' name='uomIds' value='"+dataList2[j].uomId+"'/></td>";
					
				}
				
				htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='remarks' id='remarks' value='' autocomplete='off'/></td>";
				htmlTable = htmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='investigationType' id='investigationType' value='"+investigationType+"'/></td>";
				htmlTable = htmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='sampleCollectionHdId' id='sampleCollectionHdId' value='"+sampleCollectionHdId+"##"+pInvestType+"'/></td>";
				htmlTable = htmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='sampleCollectionDtId' id='sampleCollectionDtId' value='"+sampleCollectionDtId+"##"+pInvestType+"'/></td>";
				htmlTable = htmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='dgOrderdtIdNew' id='dgOrderdtIdNew' value='"+dgorderdtId+"##"+pInvestType+"##"+parentInvId+"'/></td>";
				htmlTable = htmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='subchargeCodeId' id='subchargeCodeId' value='"+dataList2[j].subChargeCode+"'/></td>";
				htmlTable = htmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='mainchargecodeId' id='mainchargecodeId' value='"+dataList2[j].mainChargeCode+"'/></td>";
				htmlTable = htmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='mInvestTypes' id='mInvestTypes' value='"+pInvestType+"'/></td>";
				htmlTable = htmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='hospitalIdd' id='hospitalIdd' value='"+<%=hospitalId%>+"'/></td>";
				htmlTable = htmlTable +"<td style='width: 150px; display:none'></td>";
				htmlTable = htmlTable+"</tr>";
				
				counter1++;
				
	 		}
	 		
	    }
	}
	
	else if(pInvestType == 's' || pInvestType == 'S'){
		 count=1;
		 
		var singleParameter = dataSingleParameterList;
		var singleParaHtmlTable="";
	    for(var s=0; s<singleParameter.length; s++){
	    	
	    	singleParaHtmlTable= singleParaHtmlTable +"<tr id='"+singleParameter[s].sampleCollectionDtId+"' >";
    		/* singleParaHtmlTable = singleParaHtmlTable +"<td style='width: 150px;'>"+count+"</td>"; */
    		singleParaHtmlTable = singleParaHtmlTable +"<td style='width: 150px;'><input class='form-control border-input' type='text' name='diagNo' id='diagNo' value='"+singleParameter[s].diagNo+"' readOnly='readOnly'/></td>";
		    singleParaHtmlTable = singleParaHtmlTable +"<td style='width: 150px;'><input class='form-control border-input' type='text' name='subInvestigationNames' id='subInvestigationNames' value='"+singleParameter[s].investigationName+"' readOnly='readOnly'/><input class='form-control border-input' type='hidden' name='subInvestigationIds' id='' value='"+singleParameter[s].investigationId+"##"+singleParameter[s].investigationType+"' readOnly='readOnly'/></td>";
		    singleParaHtmlTable = singleParaHtmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='InvestigationIdValueParent' id='InvestigationIdValueParent' value='"+singleParameter[s].investigationId+"##"+singleParameter[s].investigationType+"' readOnly='readOnly'/></td>"; 
		    singleParaHtmlTable = singleParaHtmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='parentInvId' id='parentInvId' value='"+singleParameter[s].investigationId+"' readOnly='readOnly'/></td>";
			singleParaHtmlTable = singleParaHtmlTable +"<td style='width: 150px;'><input class='form-control border-input' type='text' name='sampleDescription' id='"+singleParameter[s].sampleId+"' value='"+singleParameter[s].sampleDescription+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' name='sampleIds' value='"+singleParameter[s].sampleId+"'/></td>";
			singleParaHtmlTable = singleParaHtmlTable +"<td style='width: 150px;'><input class='form-control border-input' type='text' name='result' id='result' value='' autocomplete='off'/></td>";
			singleParaHtmlTable = singleParaHtmlTable +"<td style='width: 150px;'><input class='form-control border-input' type='text' name='units' id='"+singleParameter[s].uomId+"' value='"+singleParameter[s].uomName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' name='uomIds' value='"+singleParameter[s].uomId+"'/></td>";
			singleParaHtmlTable = singleParaHtmlTable +"<td style='width: 150px;'><input class='form-control border-input' type='text' name='normalRange' id='normalRange' value='"+singleParameter[s].normalRange+"' readOnly='readOnly'/></td>";
			singleParaHtmlTable = singleParaHtmlTable +"<td style='width: 150px; display:none'><input class='form-control border-input' type='hidden' name='normalIds' value='"+singleParameter[s].normalRange+"'/></td>";
			singleParaHtmlTable = singleParaHtmlTable +"<td style='width: 150px;'><input class='form-control border-input' type='text' name='remarks' id='remarks' value='' autocomplete='off'/></td>"; 
			singleParaHtmlTable = singleParaHtmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='sampleCollectionHdId' id='sampleCollectionHdId' value='"+singleParameter[s].sampleCollectionHdId+"##"+singleParameter[s].investigationType+"'/></td>";
			singleParaHtmlTable = singleParaHtmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='sampleCollectionDtId' id='sampleCollectionDtId' value='"+singleParameter[s].sampleCollectionDtId+"##"+singleParameter[s].investigationType+"'/></td>";
			singleParaHtmlTable = singleParaHtmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='dgOrderdtIdNew' id='dgOrderdtIdNew' value='"+singleParameter[s].orderdtId+"##"+singleParameter[s].investigationType+"##"+singleParameter[s].investigationId+"'/></td>";
			singleParaHtmlTable = singleParaHtmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='investigationType' id='investigationType' value='"+singleParameter[s].investigationType+"'/></td>";
			singleParaHtmlTable = singleParaHtmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='sInvestTypes' id='sInvestTypes' value='"+singleParameter[s].investigationType+"'/></td>";
			singleParaHtmlTable = singleParaHtmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='subchargeCodeId' id='subchargeCodeId' value='"+singleParameter[s].subChargeCodeId+"'/></td>";
			singleParaHtmlTable = singleParaHtmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='hospitalIdd' id='hospitalIdd' value='"+<%=hospitalId%>+"'/></td>";
			singleParaHtmlTable = singleParaHtmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='mainchargecodeId' id='mainchargecodeId' value='"+singleParameter[s].mainchargeCodeId+"'/></td>";
			singleParaHtmlTable = singleParaHtmlTable +"</tr>";
			count++;
	    	
	   }
	}
	else if(pInvestType == 't' || pInvestType == 'T'){
		 count=1;
		 var templateParameter = dataTemplateParameterList;
		 var templateParaHtmlTable="";
		 
			 
		 for(var loop=0; loop<templateParameter.length; loop++){
			 
			 templateParaHtmlTable= templateParaHtmlTable+"<tr id='"+templateParameter[loop].sampleCollectionDtId+"' >";
	    		/* templateParaHtmlTable = templateParaHtmlTable +"<td style='width: 150px;'>"+count+"</td>"; */
	    		templateParaHtmlTable = templateParaHtmlTable +"<td style='width: 150px;'><input class='form-control border-input' type='text' name='diagNo' id='diagNo' value='"+templateParameter[loop].diagNo+"' readOnly='readOnly'/></td>";
	    		templateParaHtmlTable = templateParaHtmlTable +"<td style='width: 150px;'><textarea class='form-control' name='subInvestigationNames' id='subInvestigationNames' readOnly='readOnly'>"+templateParameter[loop].investigationName+"</textarea><input class='form-control border-input' type='hidden' name='subInvestigationIds' id='' value='"+templateParameter[loop].investigationId+"##"+templateParameter[loop].investigationType+"' readOnly='readOnly'/></td>";
			    templateParaHtmlTable = templateParaHtmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='InvestigationIdValueParent' id='InvestigationIdValueParent' value='"+templateParameter[loop].investigationId+"##"+templateParameter[loop].investigationType+"' readOnly='readOnly'/></td>"; 
			    templateParaHtmlTable = templateParaHtmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='parentInvId' id='parentInvId' value='"+templateParameter[loop].investigationId+"' readOnly='readOnly'/></td>";
			    templateParaHtmlTable = templateParaHtmlTable +"<td style='width: 150px;'><input class='form-control border-input' type='text' name='sampleDescription' id='"+templateParameter[loop].sampleId+"' value='"+templateParameter[loop].sampleDescription+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' name='sampleIds' value='"+templateParameter[loop].sampleId+"'/></td>";
			    if(templateParameter[loop].normalRange==''){
			    	templateParaHtmlTable= templateParaHtmlTable +'<td><textarea name="result" id="resultLab'+loop+'"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;"></textarea>';
			    	
			    	templateParaHtmlTable = templateParaHtmlTable +"<a style='width: 150px;' class='btn btn-primary text-white' data-toggle='modal' data-target='#showForResultEnterId' id='tempResultEnterId"+loop+"' onclick='openResultModel(this);' disabled='disabled'>Fill Result </a></td>";
			    }else{
			    	templateParaHtmlTable = templateParaHtmlTable +"<td style='width: 150px;'><input class='form-control border-input' type='text' name='result' id='result' value='' /></td>";
			    }
				
				templateParaHtmlTable = templateParaHtmlTable +"<td style='width: 150px;'><input class='form-control border-input' type='text' name='units' id='"+templateParameter[loop].uomId+"' value='"+templateParameter[loop].uomName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' name='uomIds' value='"+templateParameter[loop].uomId+"'/></td>";
			    templateParaHtmlTable = templateParaHtmlTable +"<td style='width: 150px;'><input class='form-control border-input' type='text' name='normalRange' id='normalRange' value='"+templateParameter[loop].normalRange+"' readOnly='readOnly'/></td>";
				templateParaHtmlTable = templateParaHtmlTable +"<td style='width: 150px; display:none'><input class='form-control border-input' type='hidden' name='normalIds' value='"+templateParameter[loop].normalRange+"'/></td>";
				templateParaHtmlTable = templateParaHtmlTable +"<td style='width: 150px;'><input class='form-control border-input' type='text' name='remarks' id='remarks' value='' autocomplete='off'/></td>"; 
				templateParaHtmlTable = templateParaHtmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='sampleCollectionHdId' id='sampleCollectionHdId' value='"+templateParameter[loop].sampleCollectionHdId+"##"+templateParameter[loop].investigationType+"'/></td>";
				templateParaHtmlTable = templateParaHtmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='sampleCollectionDtId' id='sampleCollectionDtId' value='"+templateParameter[loop].sampleCollectionDtId+"##"+templateParameter[loop].investigationType+"'/></td>";
				templateParaHtmlTable = templateParaHtmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='dgOrderdtIdNew' id='dgOrderdtIdNew' value='"+templateParameter[loop].orderDtId+"##"+templateParameter[loop].investigationType+"##"+templateParameter[loop].investigationId+"'/></td>";
				templateParaHtmlTable = templateParaHtmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='investigationType' id='investigationType' value='"+templateParameter[loop].investigationType+"'/></td>";
				templateParaHtmlTable = templateParaHtmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='tInvestTypes' id='tInvestTypes' value='"+templateParameter[loop].investigationType+"'/></td>";
				templateParaHtmlTable = templateParaHtmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='subchargeCodeId' id='subchargeCodeId' value='"+templateParameter[loop].subChargeCode+"'/></td>";
				templateParaHtmlTable = templateParaHtmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='hospitalIdd' id='hospitalIdd' value='"+<%=hospitalId%>+"'/></td>";
				templateParaHtmlTable = templateParaHtmlTable +"<td style='width: 150px; display:none'><input  class='form-control border-input' type='hidden' name='mainchargecodeId' id='mainchargecodeId' value='"+templateParameter[loop].mainChargeCode+"'/></td>";
				templateParaHtmlTable = templateParaHtmlTable+"</tr>";
				count++;
			 
		 }
	}
	//else if
	//else if
	countNN++;
	    //counter++;
	     if(htmlTable!=""){
	    	htmlTable1+=htmlTable;
	 	   //htmlTable2+=htmlTable1;
	    	globalData+=htmlTable1;
	    } 
	   
	}
	 if(singleParaHtmlTable!="" && singleParaHtmlTable!=undefined){
	 	    htmlTable2+=singleParaHtmlTable;
	  }
	 
	 if(htmlTable2== undefined || (templateParaHtmlTable!="" && templateParaHtmlTable!=undefined)){
	 	    htmlTable2+=templateParaHtmlTable;
	  }
 	  if(htmlTable1!="" && htmlTable1!=undefined){
	    	//htmlTable1+=htmlTable;
 		 htmlTable2+=globalData;
	    } 
 	    /* if(dataList2.length == 0 && singleParameter.length == 0 && templateParameter.length == 0){
				htmlTable2 = htmlTable2+"<tr ><td colspan='8'><h6>No Record Found</h6></td></tr>";
		   } */
		if(htmlTable2!=undefined)   
	    $j("#tblListOfResultEntryInvestigationDetails").html(htmlTable2);
	     
	    
	});
	  
	
	//end grid
	
	
	

	$(function() {
		$("#editorOfResult").jqte();
	})
	
	 function openResultModel(item){
		
		var resultIdIm= $(item).closest('tr').find("td:eq(6)").find("textarea:eq(0)").attr("id");
		 	var resultView = $('#'+resultIdIm).val();
		 	$('#editorOfResult').jqteVal(resultView);
		 	
			$('#resultValTemplate').val(resultIdIm);
			
			
	 }
		
	
	
	 	
	 
		 function saveResultInText(){
			// var idOfResult=$('#resultValTemplate').val();
			var idOfResult=$('#resultValTemplate').val();
			 var jqetResultValue=$('#editorOfResult').val();
			 $('#'+idOfResult).val(jqetResultValue);
			 /* $('#'+idOfResult).val(jqetResultValue); */
			// $('#resultValTemplate').val(jqetResultValue);
			 $('.modal').hide();
			$('.modal-backdrop ').hide();
				 
		 }
	 
		 //resultValTemplateArray.push(resultValTemplate);
			
		/* //var tempResult = $('#editor').val();
		function submitTemplateResult(){
			 $('#templetResult').jqteVal(myContent);
			 $('.modal').hide();
			$('.modal-backdrop ').hide();
				 
		 } */
		
	 	
		
	
	
	function resultEnterScreen(){
		
	}
	
		 function submitResultEntryDetails(){
			 $('#submitbtnId').prop("disabled", true);
					  var oderHdId=$('#orderHdId').val();
					   	document.resultEntryDetailsForm.action="${pageContext.request.contextPath}/lab/submitResultEntryDetails?oderHdId="+oderHdId+"";
						document.resultEntryDetailsForm.method='POST'
						document.resultEntryDetailsForm.submit();
				  
			  }	 
		 
		 
	/* function submitResultEntryDetails(){
		//$('#submitbtnId').prop("disabled", true);
		  if(validateEnteredResult()==true){
			  var oderHdId=$('#orderHdId').val();
			  	document.resultEntryDetailsForm.action="${pageContext.request.contextPath}/lab/submitResultEntryDetails?oderHdId="+oderHdId+"";
				document.resultEntryDetailsForm.method='POST'
				document.resultEntryDetailsForm.submit();
		  }else{
			  return false;
		  }
	  } */
		  
	
	var digNo='';
	var subInvestigationIds='';
	var samplesId='';
	var resultsId='';
	var unitsId='';
	var normalRanges='';
	var remarks='';
	var hiddenSampleCollDtId = '';
	var hiddenSampleCollHdId = '';
	
	var diagNoArray=[];
	var InvestigationIdArray=[];
	var samplesIdArray=[];
	var resultsIdArray=[];
	var unitsIdArray=[];
	var normalRangesArray=[];
	var remarksArray=[];
	var hiddenSampleCollDtIdArray=[];
	var hiddenSampleCollHdIdArray=[];
	
	/*validate the result entry details of each row*/
	function validateEnteredResult(){
		var countForResult=0;
		$('#tblListOfResultEntryInvestigationDetails tr').each(function(i, el) {
			//var rowCount = $('#tblListOfResultEntryInvestigationDetails tr').length;
			
				var countCheck=i;
				var resultId = "";
				var resultIdType = $(this).find("td:eq(9)").find("input:eq(0)").val();
				
				//var resultIdType_t = $(this).find("td:eq(13)").find("input:eq(0)").val();
			if(resultIdType!="" && resultIdType=="m"){
				 resultId = $(this).find("td:eq(5)").find("input:eq(0)").val();
				 //alert(resultId);
				 if(resultId==undefined){
					 resultId =  $(this).find("td:eq(5)").find('option:selected').val();
				 }
			console.log(resultId);
			if(resultId==undefined || resultId=="" || resultId == '00'){
				
				countForResult++;
			}
			}
			if(resultIdType!="" &&  resultIdType!="m"){
				 resultId = $(this).find("td:eq(6)").find("input:eq(0)").val();
				if(resultId==undefined || resultId=="" ){
					countForResult++;
				}
				}
			/* if(resultIdType_t!="" &&  resultIdType_t=="t"){
				 resultId = $(this).find("td:eq(6)").find("input:eq(0)").attr("id");
				if(resultId==undefined || resultId=="" ){
					countForResult++;
				}
				} */
		});
		if(countForResult>0){
			alert("Please Enter the Result");
			return false;
		}
		
		return true;
	}
	
	function backToWaitingList(){
		window.location = "pendingResultEntry";
	}
	
	
  </script>
  							
			

</body>

</html>