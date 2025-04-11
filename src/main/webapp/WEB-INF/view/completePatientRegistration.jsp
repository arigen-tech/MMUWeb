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
<title>Complete Registration</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<style>
#tableId tr:hover {
	cursor: pointer;
}
</style>
<script type="text/javascript">

nPageNo=1;
var $j = jQuery.noConflict();

<%
	String mmuId = "0";
	if (session.getAttribute("mmuId") != null) {
		mmuId = session.getAttribute("mmuId") + "";
	}
	String userId = "0";
	if (session.getAttribute("userId") != null) {
		userId = session.getAttribute("userId") + "";
	}
	
	String departmentId = "0";
	if (session.getAttribute("departmentId") != null) {
		departmentId = session.getAttribute("departmentId") + "";
	}
	
	String departmentName = "";
	if (session.getAttribute("departmentName") != null) {
		departmentName = session.getAttribute("departmentName") + "";
	}
	
	String campId = "0";
	if (session.getAttribute("campId") != null) {
		campId = session.getAttribute("campId") + "";
	}
	
	String cityName = "";
	if (session.getAttribute("cityName") != null) {
		cityName = session.getAttribute("cityName") + "";
	}
	String campLocation = "";
	if (session.getAttribute("campLocation") != null) {
		campLocation = session.getAttribute("campLocation") + "";
	}
%>
var patientId = '';
$j(document).ready(function()
		{
			var response = ${response};
			var list = response.list;
			$('#patientName2').val(list[0].name)
			$('#mobileNo2').val(list[0].mobileNo);
			$('#age').val(list[0].age);
			$('#gender').val(list[0].gender);
			patientId = list[0].id;
			
			
			getDistrictList();
			getBloodGroupList();
			//getReligionList();
			getGenderList();
			getIdentificationTypeList()
			getLabourTypeList();
			getWardList();
			getCityList();
			getRelationList();
			$('#registration_div').hide();
		});
		
var selectedPatientId = '';
function setPatientDetails(item){
	//$('#formId').trigger("reset");	
	var patientId = item.id;
	for(i=0;i<globalPatientListInfo.length;i++){
		var patientIdd = globalPatientListInfo[i].patientId;
		if(patientId == patientIdd){
			selectedPatientId = patientIdd;
			$('#patientName2').val(globalPatientListInfo[i].patientName);
			$('#mobileNo2').val(globalPatientListInfo[i].mobileNo);
			$('#genderId').val(globalPatientListInfo[i].genderId);
			$('#age').val(globalPatientListInfo[i].age);
			if(globalPatientListInfo[i].patientType != ''){
				$("input[name=patientType][value=" + globalPatientListInfo[i].patientType + "]").prop('checked', true);
			}
			
			if(globalPatientListInfo[i].patientType == 'G'){
				$('#occupation').val(globalPatientListInfo[i].occupation);
				hideLabourDiv();
			}else{
				//$("input[name=patientType][value=" + globalPatientListInfo[i].patientType + "]").prop('checked', true);
				hideCitizenDiv();
			}
			if(globalPatientListInfo[i].isLabourRegistered != ''){
				$("input[name=reg_labour][value=" + globalPatientListInfo[i].isLabourRegistered + "]").prop('checked', true);
				if(globalPatientListInfo[i].isLabourRegistered == 'Y'){
					hideIsFormSubmitted();
				}else{
					showIsFormSubmitted();
				}
			}
			if(globalPatientListInfo[i].isFormSubmitted != ''){
				$("input[name=non_reg_labour_form][value=" + globalPatientListInfo[i].isFormSubmitted + "]").prop('checked', true);
			}
			
			$('#regNo').val(globalPatientListInfo[i].registrationNo);
			$('#labourId').val(globalPatientListInfo[i].labourTypeId);
			$('#identificationTypeId').val(globalPatientListInfo[i].identificationTypeId);
			
			$('#identificationNo').val(globalPatientListInfo[i].identificationNo);
			$('#wardId').val(globalPatientListInfo[i].wardId);
			$('#castId').val(globalPatientListInfo[i].castId);
			
			$('#districtId').val(globalPatientListInfo[i].districtId);
			  
			//getCityList();
			$('#address').val(globalPatientListInfo[i].address);
			
			$('#pincode').val(globalPatientListInfo[i].pincode);
			$('#bloodGroupId').val(globalPatientListInfo[i].bloodGroupId);
			
			//$('#departmentId').val(globalPatientListInfo[i].departmentId);
			if(globalPatientListInfo[i].cityId != ''){
				var cityDrop = '<option value ='+globalPatientListInfo[i].cityId+' selected>'+globalPatientListInfo[i].cityName+'</option>';
				$('#cityId').append(cityDrop);
			}
			
		}
	}
}		
		
function getDistrictList(){
	
	var params = {
			"stateId":1
	}
	
	$j.ajax({
		type : "POST",
		contentType : "application/json",
		url : 'getDistrictList',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(data) {
			if(data.status == true){
				var list = data.list;
				var districtDrop = '<option value="">Select</option>';
				for(i=0;i<list.length;i++){
					districtDrop += '<option value='+list[i].districtId+'>'+list[i].districtName+'</option>';
				}
				$('#districtId').append(districtDrop);
			}
		},
		error : function(data) {
			alert("An error has occurred while contacting the server");
			$('#submit_btn').attr("disabled", false);
		}
	}); 
	}
	
/*  	$j('#districtId').change(function(){
		alert("dfss");​
}); */

function getRelationList(){

	var params = {
	}
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : 'getRelationList',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(data) {
			if(data.status == true){
				$j('#relationId').empty();
				var list = data.list;
				var relationDD = '<option value="">Select</option>';
				for(i=0;i<list.length;i++){
					relationDD += '<option value='+list[i].relationId+'>'+list[i].relationName+'</option>';
				}
				$j('#relationId').append(relationDD);
			}
		},
		error : function(data) {
			alert("An error has occurred while contacting the server");
		}
	}); 
	}
	
function getCityList(){

	var params = {
	}
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : 'getCityList',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(data) {
			if(data.status == true){
				$j('#cityId').empty();
				var list = data.list;
				var cityDrop = '<option value="">Select</option>';
				for(i=0;i<list.length;i++){
					cityDrop += '<option value='+list[i].cityId+'>'+list[i].cityName+'</option>';
				}
				$j('#cityId').append(cityDrop);
			}
		},
		error : function(data) {
			alert("An error has occurred while contacting the server");
		}
	}); 
	}


function getBloodGroupList(item){
	var params = {}

	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : 'getBloodGroupList',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(data) {
			if(data.status == true){
				var list = data.list;
				var bloodGroupDrop = '<option value="">Select</option>';
				for(i=0;i<list.length;i++){
					bloodGroupDrop += '<option value='+list[i].bloodGroupId+'>'+list[i].bloodGroupName+'</option>';
				}
				$j('#bloodGroupId').append(bloodGroupDrop);
			}
		},
		error : function(data) {
			alert("An error has occurred while contacting the server");
		}
	});
	}

	function getGenderList(){
	var params = {}

	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getGenderList";

	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : url,
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(data) {
			if(data.status == true){
				var list = data.data;
				var dropDrop = '<option value="">Select</option>';
				for(i=0;i<list.length;i++){
					dropDrop += '<option value='+list[i].administrativeSexId+'>'+list[i].administrativeSexName+'</option>';
				}
				$j('#genderId').append(dropDrop);
			}
		},
		error : function(data) {
			alert("An error has occurred while contacting the server");
		}
	}); 
	}

	function getLabourTypeList(){
	var params = {}

	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : "getLabourTyeList",
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(data) {
			if(data.status == true){
				var list = data.list;
				var dropDrop = '<option value="">Select</option>';
				for(i=0;i<list.length;i++){
					dropDrop += '<option value='+list[i].labourTypeId+'>'+list[i].labourTypeName+'</option>';
				}
				$j('#labourId').append(dropDrop);
			}
		},
		error : function(data) {
			alert("An error has occurred while contacting the server");
		}
	}); 
	}

	function getIdentificationTypeList(){
	var params = {}

	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : "getIdentificationTypeList",
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(data) {
			if(data.status == true){
				var list = data.list;
				var dropDrop = '<option value="">Select</option>';
				for(i=0;i<list.length;i++){
					dropDrop += '<option value='+list[i].identificationTypeId+'>'+list[i].identificationTypeName+'</option>';
				}
				$j('#identificationTypeId').append(dropDrop);
			}
		},
		error : function(data) {
			alert("An error has occurred while contacting the server");
		}
	}); 
	}

	function hideLabourDiv(){
		$('#occupationDiv').show();
		$('#labourDiv').hide();
		$('#relationId').val('');
		
	}

	function hideCitizenDiv(){
		$('#occupationDiv').hide();
		$('#labourDiv').show();
	}
	
	function hideIsFormSubmitted(){
		$('#form_div').hide();
		$('#registration_div').show();
		$('#relationId').val('');
	}

	function showIsFormSubmitted(){
		$('#form_div').show();
		$('#registration_div').hide();
	}
	
/* 	function resetSearchDetail(){
		$('#tableId').empty();
		$('#formId').trigger("reset");

		var htmlTable = "<tr ><td colspan='7'><h6>No Record Found !!</h6></td></tr>";
		$('#tableId').append(htmlTable);
		
	} */
	
	var globalWardList = '';
	function getWardList(){

		var params = {
		}
		
		$j.ajax({
			type : "POST",
			contentType : "application/json",
			url : 'getWardListWithoutCity',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(data) {
				if(data.status == true){
					var list = data.list;
					globalWardList = list; 
					var dropDown = '';
					for(i=0;i<list.length;i++){
						dropDown += '<option value='+list[i].wardId+'>'+list[i].wardNameWithCode+'</option>';
					}
					globalWardListDropDown = dropDown;
					$('#wardId').append(dropDown);
				}
			},
			error : function(data) {
				alert("An error has occurred while contacting the server");
			}
		}); 
		}
		
		function setCityAndDistrict(){
			var wardId = $('#wardId').val();
			for(i=0;i<globalWardList.length;i++){
				var getWardId = globalWardList[i].wardId;
				if(wardId == getWardId){
					$('#districtId').val(globalWardList[i].districtId);
					$('#cityId').val(globalWardList[i].cityId);
				}
			}
		}
	
	function updateRegistrationDetail(item){
		
		/* var typeOfPatient = $('input[name="patientType"]:checked').val();
		var isLabourRegistered = $('input[name="reg_labour"]:checked').val();
		var isFormSubmitted = $('input[name="non_reg_labour_form"]:checked').val();
		var registrationNo = $('#regNo').val();
		var typeOfLabour = $('#labourId').val();
		var occupation = $('#occupation').val();
		var identificationTpe = $('#identificationTypeId').val();
		var identificationNo = $('#identificationNo').val();
		var bloodGroupId = $('#bloodGroupId').val();
		var patientCatagory = $('#castId').val();
		
		var wardId = $('#wardId').val();
		var districtId = $('#districtId').val();
		var cityId = $('#cityId').val();
		var address = $('#address').val();
		var pincode = $('#pincode').val(); */
		
		var typeOfPatient = $('input[name="patientType"]:checked').val(); 
		if(typeOfPatient == undefined){
			alert("Please select Type of Patient");
			return;
		}
		var occupation = '';
		if(typeOfPatient == 'G'){
			occupation = $('#occupation').val();
			if(occupation == ''){
				alert("Please specify occupation detail");
				return;
			} 
		}
		var registrationNo = '';
		var isLabourRegistered = '';
		var typeOfLabour = '';
		var isFormSubmitted = '';
		var relationId = '';
		if(typeOfPatient == 'L'){
			var isLabourRegistered = $('input[name="reg_labour"]:checked').val();
			if(isLabourRegistered == undefined){
				alert("Please select Is Labour registered");
				return;
			}
			
			if(isLabourRegistered == 'Y'){
				registrationNo = $('#regNo').val();
				if(registrationNo == ''){
					alert("Please enter Registration Number");
					return;
				}
				relationId = $('#relationId').val();
			}
			
			if(isLabourRegistered == 'N'){
				isFormSubmitted = $('input[name="non_reg_labour_form"]:checked').val();
				if(isFormSubmitted == undefined || isFormSubmitted == ''){
					alert("Please select is Form Submitted.");
					return;
				}
			}
			
			var typeOfLabour = $('#labourId').val();
			if(typeOfLabour == ''){
				alert("Please select type of labour");
				return;
			}
		}
		
		
		
		var identificationTpe = $('#identificationTypeId').val();
		/* if(identificationTpe == ''){
			alert("Please Identification Type");
			return;
		} */
		var identificationNo = $('#identificationNo').val();
		if(identificationTpe != ''){
			if(identificationNo == ''){
				alert("Please enter Identification No.");
				return;
			}
		}
		
		var castId = $('#castId').val();
		/* if(castId == ''){
			alert("Please select Patient Catagory");
			return;
		} */
		var bloodGroupId = $('#bloodGroupId').val(); 
		
		var wardId = $('#wardId').val();
		if(wardId == ''){
			alert("Please select ward");
			return;
		}
		var districtId = $('#districtId').val();
		if(districtId == ''){
			alert("Please select district");
			return;
		}
		var cityId = $('#cityId').val();
		if(cityId == ''){
			alert("Please select city");
			return;
		}
		var address = $('#address').val();
		/* if(address == ''){
			alert("Please enter address");
			return;
		} */
		var pincode = $('#pincode').val();
		/* if(pincode == ''){
			alert("Please enter Pincode");
			return;
		} */
		if(pincode != '' && pincode.trim().length <6){
			alert("Please enter valid pincode");
			return;
		}
		
		
		var params = {
				"patientId":patientId,
				"typeOfPatient":typeOfPatient,
				"occupation":occupation,
				"isLabourRegistered":isLabourRegistered,
				"relationId":relationId,
				"isFormSubmitted":isFormSubmitted,
				"registrationNo":registrationNo,
				"typeOfLabour":typeOfLabour,
				"identificationTypeId":identificationTpe,
				"identificationNo":identificationNo,
				"wardId":wardId,
				"districtId":districtId,
				"cityId":cityId,
				"address":address,
				"pincode":pincode,
				"bloodGroupId":bloodGroupId,
				"castId":castId
		}
		//$(item).attr('disabled','disabled');
		
		console.log("params:: "+JSON.stringify(params));
		$j(item).attr("disabled", true);
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "updateRegistrationDetail",
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(data) {
				alert(data.msg+'S');
				document.addEventListener('click',function(e){
					    if(e.target && e.target.id== 'closeBtn'){
					    	window.location.href ="pendingPrescriptionJSP";
					    	if(item.id == 'btn1'){
					    		window.location.href ="pendingPrescriptionJSP";
					    	}else if(item.id == 'btn2'){
					    		window.location.href ="partialRegisteredPatient";
					    	}
					     }
				 });	
				$j(item).attr("disabled", false);
				$j('#formId2').trigger("reset");
			},
			error : function(data) {
				$j(item).attr("disabled", true);
				alert("An error has occurred while contacting the server");
			}
		}); 
		
	}
	
	function goBack(){
		window.location.href ="pendingPrescriptionJSP";
	}
		
</script>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">Complete Registration</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>
								<%-- <form id="formId"> --%>
			

								<h6 class="font-weight-bold text-theme text-underline">Patient
									Details</h6>
								<div class="row">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Patient Name</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="patientName2" class="form-control"
													disabled />
											</div>
										</div>
									</div>
									<input type="hidden" name ="patientId" value="">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Mobile No.</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="mobileNo2" class="form-control"
													disabled />
											</div>
										</div>
									</div>

									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Gender</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="gender" class="form-control"
													disabled />
											</div>
										</div>
									</div>

									<!-- <div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Date of birth</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" name="" id="dob"
														class="calDate form-control" value=""
														placeholder="DD/MM/YYYY">
												</div>
											</div>
										</div>
									</div> -->

									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Age</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="age" class="form-control" disabled />
											</div>
										</div>
									</div>
								</div>

								<!-- type of patient -->
								<form id="formId2">
								<div class="row m-t-10">
									<div class="col-lg-2 col-sm-3">
										<label class="col-form-label">Type of Patient</label>
									</div>
									<div class="col-md-6 m-t-5 m-l-n-21">
										<div class="form-check form-check-inline cusRadio m-r-20 ">
											<input class="form-check-input" type="radio" id="patient_gen"
												name="patientType" value="G" onclick="hideLabourDiv()">
											<span class="cus-radiobtn"></span> <label
												class="form-check-label" for="patient_gen">General
												Citizen</label>
										</div>

										<div class="form-check form-check-inline cusRadio">
											<input class="form-check-input" type="radio"
												id="patient_labour" name="patientType" value="L"
												onclick="hideCitizenDiv()"> <span
												class="cus-radiobtn"></span> <label class="form-check-label"
												for="patient_gen">Labour</label>
										</div>
									</div>
								</div>

								<!-- if general citizen -->
								<div class="row m-t-10" id="occupationDiv">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Occupation</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="occupation" class="form-control" />
											</div>
										</div>
									</div>
								</div>

								<div class="m-t-10" id="labourDiv">
									<div class="row">
										<div class="col-lg-2 col-sm-3">
											<label class="col-form-label">Is labour registered in
												labour department</label>
										</div>
										<div class="col-md-6 m-t-10 m-l-n-21">
											<div class="form-check form-check-inline cusRadio m-r-20 ">
												<input class="form-check-input" type="radio"
													id="reg_labour_yes" name="reg_labour"
													onclick="hideIsFormSubmitted()" value="Y"> <span
													class="cus-radiobtn"></span> <label
													class="form-check-label" for="reg_labour_yes">Yes</label>
											</div>

											<div class="form-check form-check-inline cusRadio">
												<input class="form-check-input" type="radio"
													id="reg_labour_no" name="reg_labour"
													onclick="showIsFormSubmitted()" value="N"> <span
													class="cus-radiobtn"></span> <label
													class="form-check-label" for="reg_labour_no">No</label>
											</div>
										</div>
									</div>
									<div class="row" id="registration_div">
										<div class="col-lg-4 col-sm-6">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Registration No.</label>
												</div>
												<div class="col-md-7">
													<input type="text" id="regNo" class="form-control" />
												</div>
											</div>
										</div>
										
										<div class="col-lg-4 col-sm-6">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Relation with Labour</label>
												</div>
												<div class="col-md-7">
													<select class="form-control" id="relationId">
													<option value="">Select</option>
													</select>
												</div>
											</div>
										</div>
									</div>

									<div class="row" id="form_div">
										<div class="col-lg-2 col-sm-3">
											<label class="col-form-label">Is form submitted in
												labour department</label>
										</div>
										<div class="col-md-6 m-t-10 m-l-n-21">
											<div class="form-check form-check-inline cusRadio m-r-20 ">
												<input class="form-check-input" type="radio"
													id="non_reg_labour_yes" name="non_reg_labour_form"
													value="Y"> <span class="cus-radiobtn"></span> <label
													class="form-check-label" for="non_reg_labour_yes">Yes</label>
											</div>

											<div class="form-check form-check-inline cusRadio">
												<input class="form-check-input" type="radio"
													id="non_reg_labour_no" name="non_reg_labour_form" value="N">
												<span class="cus-radiobtn"></span> <label
													class="form-check-label" for="non_reg_labour_no">No</label>
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-lg-4 col-sm-6">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Grade of Labour</label>
												</div>
												<div class="col-md-7">
													<select class="form-control" id="labourId">
													</select>
												</div>
											</div>
										</div>
									</div>
								</div>


								<div class="row m-t-10">
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Identification Type</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="identificationTypeId">
												</select>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Identification No.</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="identificationNo"
													class="form-control" />
											</div>
										</div>
									</div>
									<div class="w-100"></div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Patient Catagory</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="castId">
													<option value="">Select</option>
													<option value="1">General</option>
													<option value="2">OBC</option>
													<option value="3">ST</option>
													<option value="4">SC</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Blood Group</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="bloodGroupId">
												</select>
											</div>
										</div>
									</div>

								</div>
								<hr>

								<h6 class="font-weight-bold text-theme text-underline">Address
									Details</h6>
								<div class="row">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Ward</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="wardId"
													onclick="setCityAndDistrict()">
													<option value="">Select</option>
												</select>
											</div>
										</div>
									</div>

									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">District</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="districtId"
													onchange="getCityList(this)" disabled>

												</select>
											</div>
										</div>
									</div>

									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="cityId" disabled>
													<option value="">Select</option>
												</select>
											</div>
										</div>
									</div>

									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Address</label>
											</div>
											<div class="col-md-7">
												<textarea class="form-control" rows='3' id="address"></textarea>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Pincode</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="pincode" maxlength="6" class="form-control border-input"
												placeholder="" value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"/>
											</div>
										</div>
									</div>
									
								</div>
								</form>
								<div class="row m-t-20">
									<div class="col-12 text-right">
									<button type="button" class="btn btn-primary" id="btn1"
											onclick="updateRegistrationDetail(this)">Submit and back to Prescription List</button>
										<button type="button" class="btn btn-primary" id="btn2"
											onclick="updateRegistrationDetail(this)">Submit and back to Pending registration List</button>
									</div>
								</div>
								<%-- </form> --%>

							</div>
						</div>
						<!-- end card -->
					</div>
					<!-- end col -->
				</div>
				<!-- end row -->

			</div>
			<!-- container -->
			<!-- content -->
		</div>
	</div>
	<!-- END wrapper -->

	<!-- jQuery  -->


</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
