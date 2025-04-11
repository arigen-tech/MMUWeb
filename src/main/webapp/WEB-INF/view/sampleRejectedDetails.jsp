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
					<div class="internal_Htext">Sample Rejected Details</div>
					<div class="row">
						<div class="col-12">
						<form:form id = "sampleRejectedDetailsForm" name="sampleRejectedDetailsForm" action="" method="POST">
							<input type="hidden" id="sampleCollectionHdId" name="sampleCollectionHdId" value=""/>
							<input type="hidden" id="departmentId" name="departmentId" value=""/>
							<input type="hidden" id="patientId" name="patientId" value=""/>
							<input type="hidden" name="userId" id="userId" value="<%=userId %>" />
							<input type="hidden" name="hospitalId" id="hospitalId" value="<%=hospitalId %>" />
							
							<input type="hidden" id="investigationsArray" name="investigationsArray" value=''/>							
							<input type="hidden" id="sampleCollectionsArray" name="sampleCollectionsArray" value=''/>
							<input type="hidden" id="acceptedCheckBox" name="acceptedCheckBox" value=''/>
							<input type="hidden" id="rejectedCheckBox" name="rejectedCheckBox" value=''/>							
							<input type="hidden" id="remarksArray" name="remarksArray" value=''/>
							<input type="hidden" id = "collectedCheckBox" name="collectedCheckBox" value=''/>
							
							<input type="hidden" id = "dateAndTimeArray" name="dateAndTimeArray" value=''/>
							<input type="hidden" id = "r_dateAndTimeArray" name="r_dateAndTimeArray" value=''/>
							
							<input type="hidden" id = "reasonsArray" name="reasonsArray" value=''/>
							<input type="hidden" id = "r_reasonsArray" name="r_reasonsArray" value=''/>
							
							<input type="hidden" id = "additionalRemarksArray" name="additionalRemarksArray" value=''/>
							<input type="hidden" id = "r_additionalRemarksArray" name="r_additionalRemarksArray" value=''/>
							
							
							<input type="hidden" id="r_investigationsArray" name="r_investigationsArray" value=''/>							
							<input type="hidden" id="r_sampleCollectionsArray" name="r_sampleCollectionsArray" value=''/>
							
							<input type="hidden" id="subchargeCodeIdArray" name="subchargeCodeIdArray" value=''/>
							<input type="hidden" id=r_subchargeCodeIdArray name="r_subchargeCodeIdArray" value=''/>
							
							
							<div class="card">
								<div class="card-body">
									<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Order Date</label>
													</div>
													<div class="col-md-7">
														<input type="text"  id ="orderDate" name="orderDate" value="" class="form-control" readonly="readonly"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Order Time</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="orderTime" name="orderTime" value="" class="form-control" readonly="readonly"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Sample ID</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="orderNumber" name="orderNumber" value="" class="form-control" readonly="readonly"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Department</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="departmentName" name="departmentName" value="" class="form-control" readonly="readonly"/>
													</div>
												</div>
											</div>
										</div>
                                     
                                     
                                    <!---------------------  Service Details start here ------------------->

									<div class="adviceDivMain" id="button3" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Service Detail </span>
										</div>
										<input class="buttonPlusMinus" tabindex="1" name="" id="relatedbutton3" value="+" onclick="showhide(this.id)" type="button">
									</div>
									
									<div class="hisDivHide p-10" style="display:" id="newpost3">

										<div class="row m-t-10">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Service No.</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="serviceNo" name="serviceNo" value="" class="form-control" readonly="readonly"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Employee Name</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="employeeName" name="employeeName" value="" class="form-control" readonly="readonly"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Rank</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="rank" name="rank" value="" class="form-control" readonly="readonly"/>
													</div>
												</div>
											</div>
											
										</div>

									</div>
									<!---------------------- Service Details end here ---------------------->
									
									<!---------------------  Patient Details start here ------------------->

									<div class="adviceDivMain" id="button1" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Patient Detail </span>
										</div>
										<input class="buttonPlusMinus" tabindex="1" name="" id="relatedbutton1" value="+" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10" style="display:" id="newpost1">

										<div class="row  m-t-10">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">UHID No.</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="registrationNo" name="registrationNo" value="" class="form-control" readonly="readonly"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Patient Name</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="patientName" name="patientName" value="" class="form-control" readonly="readonly"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Gender</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="gender" name="gender" value="" class="form-control" readonly="readonly"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Relation</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="relation" name="relation" value="" class="form-control" readonly="readonly"/>
													</div>
												</div>
											</div>
										
										</div>

									</div>


									<!---------------------- Patient Details end here ---------------------->
									
									<!---------------------  Sample Details start here ------------------->

									<div class="adviceDivMain m-b-10" id="button2" onclick="showhide(this.id)">
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Sample Detail </span>
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
														<input type="text" id="date" name="date" value="" class="form-control" readonly="readonly" />
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Time</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="time" name="time" value="" class="form-control" readonly="readonly" />
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Validated By *</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="validatedBy" name="validatedBy" value="" class="form-control" readonly="readonly" />
													</div>
												</div>
											</div>
																						
										</div>
										
										<table class="table table-hover table-striped table-bordered m-t-10" id="tblId">
											<thead class="bg-primary">
												<tr>
													<th>S.No.</th>
													<th>Sample ID</th>												
													<th>Test Name</th>
													<th>Sample</th>
													<th>Date</th>
													<th><div class="form-check form-check-inline cusCheck m-l-10"><input type="checkbox" id="acceptedChkbox" name="acceptedChkbox" class="dependCheck form-check-input" checked="checked" multiple="multiple"  /><span class="cus-checkbtn"></span> <label class="form-check-label">Validated</label></div></th>
													<!-- <th><div class="form-check form-check-inline cusCheck m-l-10"><input type="checkbox" id="rejectedChkbox" name="rejectedChkbox" class="rejDependCheck form-check-input" multiple="multiple" /><span class="cus-checkbtn"></span> <label class="form-check-label">Rejected</label></div></th> -->
													<th>Reason</th>
													<th>Additional Remarks</th>
												</tr>
											</thead>
											<tbody id="tblListOfSampleValidatedList">
												
											</tbody>
										</table>
										
										
									</div>
									<div class="clearfix"></div>

									<!---------------------- Sample Details end here ---------------------->
									
										<div class="row">
											<div class="col-md-12 text-right">
											<!-- <input type="button" class="btn btn-primary opd_submit_btn" id ="submitbtnId" value="Submit" onclick="submitSampleValidationDetails();"> -->
											
											<input type="submit" class="btn btn-primary opd_submit_btn" id ="submitbtnId" value="Submit" onclick="submitSampleValidationDetails();"/>
												<input type ="button" class="btn btn-danger" onclick="Reset();" value="Reset"/>
												<input type="button" class="btn btn-primary opd_submit_btn" id ="backId" value="Back" onclick="backToWaitingList();">
											</div>
										</div>
																			
										
									</div>
									
								</div>
								</form:form>
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
		 }else if(buttonId=="button3"){
					test('related'+buttonId,"newpost3");
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
	    
	
	///dataTable:-
	
	var htmlTable = "";	
var $j = jQuery.noConflict();
var rowcount=0;

var orderDate='';

$j(document).ready(function()
		{
				var data = ${data};
			    var dataList = data.data;
			    
			    for(i=0;i<dataList.length;i++){
			    	/*ORDER DETAILS*/
							$j('#orderDate').val(dataList[i].orderDate);
							$j('#orderTime').val(dataList[i].orderTime);
							$j('#orderNumber').val(dataList[i].orderNumber);
							$j('#departmentName').val(dataList[i].departmentName);
							
							/*PATIENT DETAILS*/
							$j('#serviceNo').val(dataList[i].serviceNo);
							$j('#patientName').val(dataList[i].patientName);
							$j('#relation').val(dataList[i].relationName);
							$j('#rank').val(dataList[i].rankName);
							$j('#employeeName').val(dataList[i].employeeName);
							$j('#age').val(dataList[i].age);
							$j('#gender').val(dataList[i].gender);
							$j('#registrationNo').val(dataList[i].regNo);
							
							/*SAMPLE DETAILS*/
							$j('#date').val(dataList[i].currentDate);
							$j('#time').val(dataList[i].currentTime);
							$j('#validatedBy').val(dataList[i].validatedBy);
							$j('#diagnosticNo').val(dataList[i].orderhdId);
							
							$('#patientId').val(dataList[i].patientId);
							$('#departmentId').val(dataList[i].departmentId);
							$('#orderStatus').val(dataList[i].orderStatus);
							$('#orderhdId').val(dataList[i].orderhdId);
							
							$('#sampleCollectionHdId').val(dataList[i].sampleCollectionHdId);
							
							$('#subchargeCodeId').val(dataList[i].subchargeCodeId)
							$('#subchargeCodeName').val(dataList[i].subchargeCodeName)
							
							
							
				}
			    
			    var dataList1 = data.data1;
			   
			    var counter =1;
			    for(i=0;i<dataList1.length;i++){
			    	//alert(dataList1[i].subchargeCodeId);
			    	htmlTable = htmlTable+"<tr id='"+dataList1[i].sampleCollectionDtId+"' >";			
					htmlTable = htmlTable +"<td style='width: 150px;'>"+counter+"</td>";
					htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='diagNo' value='"+dataList1[i].digNo+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' id='"+dataList1[i].digNo+"'/></td>";					
					htmlTable = htmlTable +"<td style='width: 150px;'><textarea  class='form-control' name='investigationId' value='"+dataList1[i].investigationName+"' readOnly='readOnly'>"+dataList1[i].investigationName+"</textarea><input  class='form-control border-input' type='hidden' name='investID' value='"+dataList1[i].investigationId+"' id='"+dataList1[i].investigationId+"'/></td>";
					htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='sampleId' value='"+dataList1[i].sampleDesc+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' id='"+dataList1[i].sampleId+"'/></td>";
					htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='sampleCollDate' id='"+dataList1[i].sampleCollDate+"' value='"+dataList1[i].sampleCollDate+"' readOnly='readOnly'/></td>";
					htmlTable = htmlTable +"<td style='width: 150px;'><div class='form-check form-check-inline cusCheck m-l-10'><input type='checkbox' class='dependCheck form-check-input' id='acceptedChkbox"+counter+"' name='acceptedChkbox' class='dependCheck'checked='checked' onclick='multiselectAcceptCheckBox(this);checkForAccept(this)'/> <span class='cus-checkbtn'></span></td>";
					//htmlTable = htmlTable +"<td style='width: 150px;'><div class='form-check form-check-inline cusCheck m-l-10'><input type='checkbox' class='rejDependCheck form-check-input' id='rejectedChkbox"+counter+"' name='rejectedChkbox' class='rejDependCheck' onclick='multiselectRejectedCheckBox(this);checkForReject(this)'/><span class='cus-checkbtn'></span> </td>";
				if(dataList1[i].reason == undefined){
					htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='reason' id='reason"+counter+"'value='' autocomplete='off'/></td>";
				}else{
					htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='reason' id='reason"+counter+"'value='"+dataList1[i].reason+"' autocomplete='off'/></td>";
				}	
					
					htmlTable = htmlTable +"<td style='width: 150px;'><textarea class='form-control' name='additionalRemarks' id='additionalRemarks"+counter+"' autocomplete='off'></textarea></td>";
					htmlTable = htmlTable +"<td style='width: 150px; display:none'><input class='form-control border-input' type='hidden' id='"+dataList1[i].subchargeCodeId+"'  value='"+dataList1[i].subchargeCodeName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' id='"+dataList1[i].subchargeCodeId+"'/></td>";
					 		
					htmlTable = htmlTable+"</tr>";
					counter++;
			    }
			    
			    if(dataList1.length == 0)
				{
				htmlTable = htmlTable+"<tr ><td colspan='9'><h6>No Record Found</h6></td></tr>";
				   
				}
			    $j("#tblListOfSampleValidatedList").html(htmlTable); 	
			    
			  //multiple checkboxes group checked-unchecked
			    $('#acceptedChkbox').change(function(){			    	
			    	console.log('checkbox clicked');			    	
			    	if(this.checked){
			    		$('.dependCheck').prop('checked',true);
			    		$('.dependCheck').attr("disabled",false);
			    		$('.rejDependCheck').prop('checked',false);
			    		$('.rejDependCheck').attr("disabled",true);
			    		enableAndDisable();
			    	}
			    	else{
			    		$('.dependCheck').prop('checked',false);
			    		$('.rejDependCheck').attr("disabled",false);
			    		enableAndDisable();
			    	}			    	
			    });  
			  
 			   /*  $('#rejectedChkbox').change(function(){			    	
			    	console.log('checkbox clicked');			    	
			    	if(this.checked){
			    		$('.rejDependCheck').prop('checked',true);
			    		$('.rejDependCheck').attr("disabled",false);
			    		$('.dependCheck').prop('checked',false);
			    		$('.dependCheck').attr("disabled",true)
			    		enableAndDisable();
			    	}
			    	else{
			    		$('.rejDependCheck').prop('checked',false);
			    		$('.dependCheck').attr("disabled",false);
			    		enableAndDisable();
			    	}			    	
			    }); */
 			    
 			  // $('.rejDependCheck').attr("disabled",true);
			    
		});


 var globalAcep=0;
var globalRej=0;
function multiselectAcceptCheckBox(source){
 	var count = $('#tblListOfSampleValidatedList tr').length;
	var countForss=0;
	var countuncheck=0;
	var totalCheck=0;
	  for(var j=1;j<=count;j++){
		if(document.getElementById("acceptedChkbox"+j).checked == true){
			countForss++;
		/* 	$('#reason'+j).attr('readonly', false);
			$('#additionalRemarks'+j).attr('readonly', false); */
			totalCheck++;
			globalAcep++;
		}
		else{
			/* $('#reason'+j).attr('readonly', true);
			$('#additionalRemarks'+j).attr('readonly', true);
			$('#reason'+j).val('');
			$('#additionalRemarks'+j).val(''); */
			countuncheck++;
		}
	} 
	  if(countuncheck>0){
		  $('#acceptedChkbox').prop('checked', false);  
	  }
	  if(totalCheck==count){
		  $('#acceptedChkbox').prop('checked', true);  
		  $('.dependCheck').attr('disabled',false);
		  $('.rejDependCheck').attr('disabled',true);
		  
	  }
} 



/*  function multiselectRejectedCheckBox(source){
 	var count = $('#tblListOfSampleValidatedList tr').length;
	var countForss=0;
	var countuncheck=0;
	var totalCheck=0;
	  for(var j=1;j<=count;j++){
		if(document.getElementById("rejectedChkbox"+j).checked == true){
			countForss++;
			/* $('#reason'+j).attr('readonly', false);
			$('#additionalRemarks'+j).attr('readonly', false); */
			//totalCheck++;
			//globalRej++;
		//}
		//else{
			/* $('#reason'+j).attr('readonly', true);
			$('#additionalRemarks'+j).attr('readonly', true);
			$('#reason'+j).val('');
			$('#additionalRemarks'+j).val(''); */
			//countuncheck++;
		//}
	//} 
	  //if(countuncheck>0){
		//  $('#rejectedChkbox').prop('checked', false);  
	  //}
	  //if(totalCheck==count){
		/*   $('#rejectedChkbox').prop('checked', true);
		  $('.rejDependCheck').attr('disabled',false);
		  $('.dependCheck').attr('disabled',true)
	  }
 */		 
//}  



	
    function enableAndDisable(){
    	var count = $('#tblListOfSampleValidatedList tr').length;
		  for(var j=1;j<=count;j++){
				if(document.getElementById("acceptedChkbox"+j).checked == true){
					//$('#reason'+j).attr('readonly', false);
					$('#additionalRemarks'+j).attr('readonly', false);
					/* $('#reason'+j).val('');
					$('#additionalRemarks'+j).val(''); */
				}
				else{
					//$('#reason'+j).attr('readonly', true);
					$('#additionalRemarks'+j).attr('readonly', true);
					//$('#reason'+j).val('');
					$('#additionalRemarks'+j).val('');
				}
			} 
		  
    }

 function checkForAccept(val){
	  
	   var acceptId= $(val).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
		//var rejectId= $(val).closest('tr').find("td:eq(6)").find("input:eq(0)").attr("id");
		//console.log(acceptId +" "+rejectId);
		if(document.getElementById(acceptId).checked){
			//$('#'+rejectId).attr('disabled', true);
			$('#acceptedChkbox').attr('disabled', false);
			$('#submitbtnId').prop("disabled", false);
			enableAndDisable();
		}else{
			//$('#'+rejectId).attr('disabled', false);
			$('#submitbtnId').prop("disabled", false);
			$('#'+acceptId).attr('disabled', false);
			enableAndDisable();
		}
} 
 
 /* function checkForReject(val){
	  
	   var acceptId= $(val).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
		var rejectId= $(val).closest('tr').find("td:eq(6)").find("input:eq(0)").attr("id");
		console.log(acceptId +" "+rejectId);
		if(document.getElementById(rejectId).checked){
			$('#'+acceptId).attr("disabled", true);
			$('#rejectedChkbox').attr('disabled', false);
			enableAndDisable();
		}else{
			$('#'+rejectId).attr("disabled", false);
			$('#'+acceptId).attr("disabled", false);
			enableAndDisable();
		}
}  */
	
	
	
	function submitSampleValidationDetails(){
		$('#submitbtnId').prop("disabled", true);
		var flagg = checkedAcceptedAndRejected();
		//alert(flagg);
		if(flagg == false && flagg==undefine){
			return false;
		}else{
			document.sampleRejectedDetailsForm.action='${pageContext.request.contextPath}/lab/submitSampleRejectedDetails';
			document.sampleRejectedDetailsForm.method='POST'
			document.sampleRejectedDetailsForm.submit();
		}
		
	}
	
	var checkedChkBox='';
	var InvestigationValue="";
	var aInvestigationid="";
	var rInvestigationid="";
	var SampleValue="";
	var Sampleid="";
	var digNo="";
	var dateTime="";
	var reason="";
	var additionalRemarks="";
	
	var r_reason="";
	var r_additionalRemarks="";
	var subchargeCodeId="";
	var r_subchargeCodeId="";
	
	var investigationArray = [];
	var sampleCollectionArray = [];
	var collectedArray = [];
	var remarkArray = [];
	var collectedCheckedArray = [];	
	var reasonArray =[];
	var additionalRemarksArray = [];
	var dateAndTimeArray = [];
	var subchargeCodeIdArray = [];
	
	var r_investigationArray = [];
	var r_sampleCollectionArray = [];
	var r_collectedArray = [];
	var r_remarkArray = [];
	var r_collectedCheckedArray = [];
	var rejCollectedCheckedArray = [];
	var r_reasonArray =[];
	var r_additionalRemarksArray = [];
	var r_dateAndTimeArray = [];
	var r_subchargeCodeIdArray = [];
	
	function checkedAcceptedAndRejected(){
		var flag = true;
		$('#tblListOfSampleValidatedList tr').each(function(i, el) {
			var id = $(this).find("td:eq(5)").find("input:eq(0)").attr("id")
			//alert("id :: "+id);
			 if (document.getElementById(id).checked == true) {
				 checkedChkBox = 'y';
				 digNo =  $(this).find("td:eq(1)").find("input:eq(1)").attr("id")
				 aInvestigationid = $(this).find("td:eq(2)").find("input:eq(0)").attr("id")
				 Sampleid = $(this).find("td:eq(3)").find("input:eq(1)").attr("id")
				 dateTime = $(this).find("td:eq(4)").find("input:eq(0)").attr("id")
				 reason = $(this).find("td:eq(7)").find("input:eq(0)").attr("id")
				 additionalRemarks = $(this).find("td:eq(8)").find("input:eq(0)").attr("id")
				 subchargeCodeId = $(this).find("td:eq(8)").find("input:eq(0)").attr("id")
				 
					investigationArray.push(aInvestigationid);
					sampleCollectionArray.push(Sampleid);
					collectedArray.push(id);
					reasonArray.push(reason);
					additionalRemarksArray.push(additionalRemarks);
					dateAndTimeArray.push(dateTime);
					reasonArray.push(reason);
					collectedCheckedArray.push(checkedChkBox);
					subchargeCodeIdArray.push(subchargeCodeId);
					flag = false;
			 }
			 
			
		});
		console.log("flag "+flag);
		if(flag){
			alert("Please Select at least one Investigation");
			return false;
		 }
		
		
		
		$('#investigationsArray').val(investigationArray);
		$('#sampleCollectionsArray').val(sampleCollectionArray);
		$('#acceptedCheckBox').val(collectedCheckedArray);
		$('#dateAndTimeArray').val(dateAndTimeArray);
		$('#dateAndTimeArray').val(dateAndTimeArray);
		$('#reasonsArray').val(reasonArray);
		$('#additionalRemarksArray').val(additionalRemarksArray);
		$('#subchargeCodeIdArray').val(subchargeCodeIdArray);
		return true;
		
	}
	function checkedRejected(){
		$('#tblListOfSampleValidatedList tr').each(function(i, el) {
			var id = $(this).find("td:eq(6)").find("input:eq(0)").attr("id")
			//alert(id);
			 if (document.getElementById(id).checked == true) {
				 rejCheckedChkBox = 'y';
				 digNo =  $(this).find("td:eq(1)").find("input:eq(1)").attr("id")
				 
				 rInvestigationid = $(this).find("td:eq(2)").find("input:eq(0)").attr("id")
					//alert("rInvestigationid : "+rInvestigationid);
				 Sampleid = $(this).find("td:eq(3)").find("input:eq(1)").attr("id")
				 
				 dateTime = $(this).find("td:eq(4)").find("input:eq(0)").attr("id")
				 
				 r_reason = $(this).find("td:eq(7)").find("input:eq(0)").attr("id")
				 
				 r_additionalRemarks = $(this).find("td:eq(8)").find("input:eq(0)").attr("id")
				 r_subchargeCodeId = $(this).find("td:eq(9)").find("input:eq(0)").attr("id")
				 
					r_investigationArray.push(rInvestigationid);
				    r_sampleCollectionArray.push(Sampleid);
				    r_collectedArray.push(id);
				    r_reasonArray.push(reason);
				    r_additionalRemarksArray.push(r_additionalRemarks);
					r_dateAndTimeArray.push(dateTime);
					r_reasonArray.push(r_reason);
					rejCollectedCheckedArray.push(rejCheckedChkBox);
					r_subchargeCodeIdArray.push(r_subchargeCodeId);
					//alert(r_subchargeCodeIdArray);
			 
			 }else{
				 //rejCheckedChkBox = 'n'; 
			 }
			 //rejCollectedCheckedArray.push(rejCheckedChkBox);
			
		});
				
		$('#r_investigationsArray').val(r_investigationArray);
		$('#r_sampleCollectionsArray').val(r_sampleCollectionArray);
		$('#rejectedCheckBox').val(rejCollectedCheckedArray);
		$('#r_dateAndTimeArray').val(r_dateAndTimeArray);
		$('#r_reasonArray').val(r_reasonArray);
		$('#r_additionalRemarksArray').val(r_additionalRemarksArray);
		$('#r_subchargeCodeIdArray').val(r_subchargeCodeIdArray);
		
		
		
	}
	
	function Reset(){
		var count = $('#tblListOfSampleValidatedList tr').length;
		for(var i=1;i<=count;i++){
			$('#reason'+i).val('');
			$('#additionalRemarks'+i).val('');
		}
		
	}
	
	function disableCheckBox(obj){
		if($(obj).is(":checked")){
			var checkBoxId = obj.id;
			if(checkBoxId.includes("acceptedChkbox")){
				$('.rejDependCheck').prop("disabled", true);
				$('.dependCheck').prop("disabled", false);
			}else{
				$('.dependCheck').prop("disabled", true);
				$('.rejDependCheck').prop("disabled", false);
				 var count = $('#tblListOfSampleValidatedList tr').length;
				  for(var j=1;j<=count;j++){
					if(document.getElementById("acceptedChkbox"+j).checked == true){
						 $('#acceptedChkbox').prop('checked', false);
						 $('#acceptedChkbox'+j).prop('checked', false);
				  }
				  }  
			}
		    
		  }else{
			  var checkBoxId = obj.id;
			  if(checkBoxId.includes("acceptedChkbox")){
					$('.rejDependCheck').prop("disabled", false);
					$('.dependCheck').prop("disabled", false);
				}else{
					$('.dependCheck').prop("disabled", false);
					$('.rejDependCheck').prop("disabled", false);
				}
		  }
	}
	
	function backToWaitingList(){
		window.location = "pendingSampleValidate";
	}
	  
  </script>

</body>

</html>