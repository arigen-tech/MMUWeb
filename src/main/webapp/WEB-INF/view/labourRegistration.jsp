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
<title>Mobile Medical Unit- MMSSY</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>


<script type="text/javascript">

nPageNo=1;
var $j = jQuery.noConflict();
<% 
String userId = "1";
if (session.getAttribute("user_id") != null) {
	userId = session.getAttribute("user_id") + "";
}
%>
$j(document).ready(function()
		{
	
			getGenderList();
			$j("#printBtn").hide();
			getDistrictList();
			getRelationList();
			//getBloodGroupList();
			//getReligionList();
			//getIdentificationTypeList();
			//getLabourTypeList();
			//getDepartmentList();
			//getWardList();
			//getCityList();
			//getRelationList();
			$j("#rationCardDiv").hide();
			$j("#aadharCardDiv").hide();
			$j("#bankNameDiv").hide();
			$j("#accountNoDiv").hide();
			$j("#branchNameDiv").hide();
			$j("#ifscCodeDiv").hide();
			$j("#unNoDiv").hide();
			$j("#tinNoDiv").hide();
			$j("#schemeNoDiv").hide();
			$j("#jobCardNoDiv").hide();
			

		});
		
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
				$j('#relationWithHOF').append(relationDD);
			}
		},
		error : function(data) {
			alert("An error has occurred while contacting the server");
		}
	}); 
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
				$('#districtId2').append(districtDrop);
			}
		},
		error : function(data) {
			alert("An error has occurred while contacting the server");
			//$('#submit_btn').attr("disabled", false);
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
				var dropDrop = '';
				for(i=0;i<list.length;i++){
					dropDrop += '<option value='+list[i].administrativeSexId+'>'+list[i].administrativeSexName+'</option>';
				}
				$j('#genderId').append(dropDrop);
				$j('#hofGender').append(dropDrop);
			}
		},
		error : function(data) {
			alert("An error has occurred while contacting the server");
		}
	}); 
	}
		
		
	function saveLabourRegistration(item){
		var rationCardCheck = $('#rationCard').val();
		var rationNo = $('#rationNo').val();
		var aadharCardCheck = $('#aadharCard').val();
		var aadharNo = $('#aadharNo').val();
		var workerName = $('#workerName').val();
		var workerNameENG = $('#workerNameENG').val();
		var workerNameHIN = $('#workerNameHIN').val();
		var fatherOrHusband = $('#fatherOrHusband').val();
		var fatherOrHusbandName = $('#fatherOrHusbandHIN').val();
		var motherName = $('#motherNameHIN').val();
		var dob = $('#dob').val();
		var genderId = $('#genderId').val();
		var cast = $('#castId').val();
		var subcast = $('#subcast').val();
		var mobileNo = $('#mobileNo').val();
		var marritalStatus = $('#marritalStatus option:selected').val();
		var districtId = $('#districtId').val();
		var ruralOrUrban = $('input[name="ruralOrUrban"]:checked').val();
		var assembly = $('#assembly').val();
		var block = $('#block').val();
		var panchayat = $('#panchayat').val();
		var gram = $('#gram').val();
		var street = $('#street').val();
		var houseNo = $('#houseNo').val();
		var pin = $('#pin').val();
		var districtId2 = $('#districtId2').val();
		var ruralOrUrban2 = $('input[name="ruralOrUrban2"]:checked').val();
		var assembly2 = $('#assembly2').val();
		var block2 = $('#block2').val();
		var panchayat2 = $('#panchayat2').val();
		var gram2 = $('#gram2').val();
		var street2 = $('#street2').val();
		var houseNo2 = $('#houseNo2').val();
		var pin2 = $('#pin2').val();
		var bankAccountCheck = $('#bankAccountCheck').val();
		var bankName = $('#bankName').val();
		var branchName = $('#branchName').val();
		var accountNo = $('#accountNo').val();
		var ifscCode = $('#ifscCode').val();
		var unNoCheck = $('#unNoCheck').val();
		var unNo = $('#unNo').val();
		var healthStatus = $('#healthStatus').val();
		var typeOfHandicapped = $('#typeOfHandicapped').val();
		var typeOfIllness = $('#typeOfIllness').val();
		var literacy = $('#literacy').val();
		var literacySchoolCheck = $('#literacySchoolCheck').val();
		var typeOfEducation = $('#typeOfEducation').val();
		var formalEducation = $('#formalEducation').val();
		var levelOfEducation = $('#levelOfEducation').val();
		var educationTraining = $('#educationTraining').val();
		var otherEducation = $('#otherEducation').val();
		var typeOfSchool = $('#typeOfSchool').val();
		var meansOfTransport = $('#meansOfTransport').val();
		var scholorshipAvailed = $('#scholorshipAvailed').val();
		var scholorshipDepartment = $('#scholorshipDepartment').val();
		var scholorshipScheme = $('#scholorshipScheme').val();
		var giveReason = $('#giveReason').val();
		var familyHeadCheck = $('#familyHeadCheck').val();
		var hofGender = $('#hofGender').val();
		var relationWithHOF = $('#relationWithHOF').val();
		var tinNoCheck = $('#tinNoCheck').val();
		var tinNo = $('#tinNo').val();
		var registeredCheck = $('#registeredCheck').val();
		var schemeNo = $('#schemeNo').val();
		var jobCardCheck = $('#jobCardCheck').val();
		var jobCardNo = $('#jobCardNo').val();
		var surveyId = $('#surveyId').val();
		
		if(rationCardCheck == ''){
			alert("Please select Does your family have ration card");
			return;
		}
		
		if(rationCardCheck == 'Yes'){
			if(rationNo == ''){
				alert("Please enter Ration Card No");
				return;
			}
		}
		
		
		if(aadharCardCheck == ''){
			alert("Please select Do your have aadhar card");
			return;
		}
		
		if(aadharCardCheck == 'Yes'){
			if(aadharNo == ''){
				alert("Please enter aadhar No");
				return;
			}
		}
		
		
		if(workerName == ''){
			alert("Please enter worker Name");
			return;
		}
		
		
		if(workerNameENG == ''){
			alert("Please enter worker Name in English");
			return;
		}
		
		
		if(workerNameHIN == ''){
			alert("Please enter worker Name in Hindi");
			return;
		}
		
		
		if(fatherOrHusband == ''){
			alert("Please select Father/Husband");
			return;
		}
		
		
		if(fatherOrHusbandName == ''){
			alert("Please enter Father/Husband name in Hindi");
			return;
		}
		
		
		if(dob == ''){
			alert("Please enter date of birth");
			return;
		}
		
		
		if(genderId == ''){
			alert("Please select gender");
			return;
		}
		
		
		if(cast == ''){
			alert("Please select caste");
			return;
		}
				
		if(mobileNo == ''){
			alert("Please enter mobile No.");
			return;
		}
		
		
		if(marritalStatus == ''){
			alert("Please select Marital Status.");
			return;
		}
		
		
		if(districtId == ''){
			alert("Please select District");
			return;
		}
		
		
		if(ruralOrUrban == undefined){
			alert("Please select Rural or Urban")
			return
		}
		
		if(assembly == ''){
			alert("Please enter Assembly Constituencies");
			return;
		}
		
		if(block == ''){
			alert("Please enter Block/Municipal Body");
			return;
		}
		
		if(panchayat == ''){
			alert("Please enter Panchayat");
			return;
		}
		
		
		if(gram == ''){
			alert("Please enter gram");
			return;
		}
		
		if(houseNo == ''){
			alert("Please enter houseNo");
			return;
		}
		
		if(pin == ''){
			alert("Please enter pin");
			return;
		}
		
		
		if(districtId2 == ''){
			alert("Please select District");
			return;
		}
		
		
		if(ruralOrUrban2 == undefined){
			alert("Please select Rural or Urban")
			return
		}
		
		if(assembly2 == ''){
			alert("Please enter Assembly Constituencies");
			return;
		}
		
		if(block2 == ''){
			alert("Please enter Block/Municipal Body");
			return;
		}
		
		if(panchayat2 == ''){
			alert("Please enter Panchayat");
			return;
		}
		
		
		if(gram2 == ''){
			alert("Please enter gram");
			return;
		}
		
		/* if(street2 == ''){
			alert("Please enter street");
			return;
		} */
		
		if(houseNo2 == ''){
			alert("Please enter House No");
			return;
		}
		
		if(pin2 == ''){
			alert("Please enter pin");
			return;
		}
		
		
		if(bankAccountCheck == ''){
			alert("Please select Do you have a bank account");
			return;
		}
		
		
		if(bankName == '' && bankAccountCheck=='Yes'){
			alert("Please enter Bank Name");
			return;
		}
		
		
		if(branchName == '' && bankAccountCheck=='Yes'){
			alert("Please enter Branch Name");
			return;
		}
		
		
		if(accountNo == '' && bankAccountCheck=='Yes'){
			alert("Please enter Account No.");
			return;
		}
		
		
		if(ifscCode == '' && bankAccountCheck=='Yes'){
			alert("Please enter IFSC No.");
			return;
		}
		
		
		if(unNoCheck == ''){
			alert("Please select Do you have U.N. Number");
			return;
		}
		
		
		if(unNo == '' && unNoCheck == 'Yes'){
			alert("Please enter U.N. Number");
			return;
		}
		
		
		if(healthStatus == ''){
			alert("Please enter health status");
			return;
		}
		
		
		if(typeOfHandicapped == ''){
			alert("Please enter type of handicapped");
			return;
		}
		
		
		if(typeOfIllness == ''){
			alert("Please enter type of illness");
			return;
		}
		
		/*
		if(literacy == ''){
			alert("Please enter literacy");
			return;
		}
		
		
		if(literacySchoolCheck == ''){
			alert("Please select Do you want to take admission in adult literacy school");
			return;
		}
		
		
		if(typeOfEducation == ''){
			alert("Please enter Type of Education");
			return;
		}
		
		
		if(formalEducation == ''){
			alert("Please enter status of formal education");
			return;
		}
		
		
		if(levelOfEducation == ''){
			alert("Please enter Level of Education");
			return;
		}
		
		
		if(educationTraining == ''){
			alert("Please enter School/ Undergraduate/ Post Graduate/ Diploma/ Vocational Training");
			return;
		}
		
		
		if(otherEducation == ''){
			alert("Please enter others");
			return;
		}
		
		
		if(typeOfSchool == ''){
			alert("Please enter Type of School");
			return;
		}
		
		
		
		if(meansOfTransport == ''){
			alert("Please enter means of transport");
			return;
		}
		
		
		if(scholorshipAvailed == ''){
			alert("Please select Scholarship Availed");
			return;
		}
		
		
		if(scholorshipDepartment == ''){
			alert("Please enter Name of department awarding the scholarship");
			return;
		}
		
		
		if(scholorshipScheme == ''){
			alert("Please enter Scholarship scheme");
			return;
		}
		
		
		if(giveReason == ''){
			alert("Please enter Give reason");
			return;
		}
		
		*/
		
		if(familyHeadCheck == ''){
			alert("Please select Are you the head of the family (HOF)");
			return;
		}
		
		
		if(hofGender == ''){
			alert("Please select HOF gender");
			return;
		}
		
		
		if(relationWithHOF == ''){
			alert("Please select Your relationship with HOF");
			return;
		}
		
		
		
		if(tinNoCheck == ''){
			alert("Please select Do youn have a SECC ATH TIN number");
			return;
		}
		
		
		if(tinNo == '' && tinNoCheck == 'Yes'){
			alert("Please enter SECC ATH TIN number");
			return;
		}
		
		
		if(registeredCheck == ''){
			alert("Please enter Are you registered under Ayushman Bharat/ Khub Chand Baghel Scheme/ Do you have any health card");
			return;
		}
		
		
		if(schemeNo == '' && registeredCheck == 'Yes'){
			alert("Please enter schemeNo");
			return;
		}
		
		
		if(jobCardCheck == ''){
			alert("Please select Does your family have a MGNREGA job card");
			return;
		}
		
		
		if(jobCardNo == '' && jobCardCheck == 'Yes'){
			alert("Please enter MGNREGA job card number");
			return;
		}
		
		
		
		if(surveyId == ''){
			alert("Survey ID/ Worker ID");
			return;
		}
		
//last
//var workerName = $('#aadharNo').val();
		
		var params = {
				'userId' :<%=userId%>,
				'rationCardCheck':rationCardCheck,
				'rationCardNo':rationNo,
				'aadharCardCheck':aadharCardCheck,
				'aadharCardNo':aadharNo,
				'workerNameENG':workerNameENG,
				'workerNameHIN':workerNameHIN,
				'fatherOrHusband':fatherOrHusband,
				'fatherOrHusbandName':fatherOrHusbandName,
				'motherName':motherName,
				'dob':dob,
				'genderId':genderId,
				'castId':cast,
				'subcast':subcast,
				'mobileNo':mobileNo,
				'marritalStatus':marritalStatus,
				'districtId':districtId,
				'ruralOrUrban':ruralOrUrban,
				'assembly':assembly,
				'block':block,
				'panchayat':panchayat,
				'gram':gram,
				'street':street,
				'houseNo':houseNo,
				'pin':pin,
				'districtId2':districtId2,
				'ruralOrUrban2':ruralOrUrban2,
				'assembly2':assembly2,
				'block2':block2,
				'panchayat2':panchayat2,
				'gram2':gram2,
				'street2':street2,
				'houseNo2':houseNo2,
				'pin2':pin2,
				'bankAccountCheck':bankAccountCheck,
				'bankName':bankName,
				'branchName':branchName,
				'accountNo':accountNo,
				'ifscCode':ifscCode,
				'unNoCheck':unNoCheck,
				'unNo':unNo,
				'healthStatus':healthStatus,
				'typeOfHandicapped':typeOfHandicapped,
				'typeOfIllness':typeOfIllness,
				'literacy':literacy,
				'literacySchoolCheck':literacySchoolCheck,
				'typeOfEducation':typeOfEducation,
				'formalEducation':formalEducation,
				'levelOfEducation':levelOfEducation,
				'educationTraining':educationTraining,
				'otherEducation':otherEducation,
				'typeOfSchool':typeOfSchool,
				'meansOfTransport':meansOfTransport,
				'scholorshipAvailed':scholorshipAvailed,
				'scholorshipDepartment':scholorshipDepartment,
				'scholorshipScheme':scholorshipScheme,
				'giveReason':giveReason,
				'familyHeadCheck':familyHeadCheck,
				'hofGender':hofGender,
				'relationWithHOF':relationWithHOF,
				'tinNoCheck':tinNoCheck,
				'tinNo':tinNo,
				'registeredCheck':registeredCheck,
				'schemeNo':schemeNo,
				'jobCardCheck':jobCardCheck,
				'jobCardNo':jobCardNo,
				'surveyId':surveyId
				
		}
				 
				//params
				
		$j(item).attr("disabled", true);
		console.log("json "+JSON.stringify(params));
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "saveLabourRegistration",
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(data) {
				if(data.status == true){
					
					alert(data.msg+'S');
					$j("#labourId").val(data.labourId);
					$j('input[type="text"]').val('');
					$j('select').val('');
					$j("#printBtn").show();
					
					$('#from_date').val('');
					$j(item).attr("disabled", false);
					//$j('formId').trigger("reset");
				}else{
					alert(data.msg);
					$j(item).attr("disabled", false);
				}
			},
			error : function(data) {
				$j(item).attr("disabled", false);
			}
		}); 
				
	}
	
	function showRationCardDiv(){
		
		var rationStatus=$j("#rationCard").val();
		
		if(rationStatus=='Yes'){
			$j("#rationCardDiv").show();
		}
		else{
			$j("#rationCardDiv").hide();
		}
		
	}
	
    function showAadharCardDiv(){
		
    var aadharStatus=$j("#aadharCard").val();
		
		if(aadharStatus=='Yes'){
			$j("#aadharCardDiv").show();
		}
		else{
			$j("#aadharCardDiv").hide();
		}
		
	}
    
    
    function showBankDetailsDiv(){
		
        var bankStatus=$j("#bankAccountCheck").val();
    		
    		if(bankStatus=='Yes'){
    			$j("#bankNameDiv").show();
    			$j("#branchNameDiv").show();
    			$j("#accountNoDiv").show();
    			$j("#ifscCodeDiv").show();
    		
    		}
    		else{
    			$j("#bankNameDiv").hide();
    			$j("#branchNameDiv").hide();
    			$j("#accountNoDiv").hide();
    			$j("#ifscCodeDiv").hide();
    		}
    		
    	}
	
    
    function showUnNO(){
		
        var unNoStatus=$j("#unNoCheck").val();
    		
    		if(unNoStatus=='Yes'){
    			$j("#unNoDiv").show();
    		}
    		else{
    			$j("#unNoDiv").hide();
    		}
    		
    	}
    
    
	function showTinNoDiv(){
		
        var tinNoStatus=$j("#tinNoCheck").val();
    		
    		if(tinNoStatus=='Yes'){
    			$j("#tinNoDiv").show();
    		}
    		else{
    			$j("#tinNoDiv").hide();
    		}
    		
    	}
	
	
	function setHOFGender(){
		
        var familyHeadCheck=$j("#familyHeadCheck").val();
    	var genderId=$j("#genderId").val();
    		if(familyHeadCheck=='Yes'){
    			$j("#hofGender").val(genderId);
    			$j("#relationWithHOF").val('1');
    		}
    		
    		else{
    			$j("#hofGender").val("");
    			$j("#relationWithHOF").val("");
    		}
    	}
	
	
	function showSchemeNoDiv(){
		
        var schemeNoStatus=$j("#registeredCheck").val();
    		
    		if(schemeNoStatus=='Yes'){
    			$j("#schemeNoDiv").show();
    		}
    		else{
    			$j("#schemeNoDiv").hide();
    		}
    		
    	}
	
		function showJobCardNoDiv(){
		
        var jobCardNoStatus=$j("#checkjobCardNo").val();
    		
    		if(jobCardNoStatus=='Yes'){
    			$j("#jobCardNoDiv").show();
    		}
    		else{
    			$j("#jobCardNoDiv").hide();
    		}
    		
    	}
    
	   function fillPresentAddress(){
	    
		   var checkBox= document.getElementById('check1');
		   
		   var districtId=$j("#districtId option:selected").val();
		   var ruralOrUrban=$j("input[type='radio']:checked").val();
		   var assembly=$j("#assembly").val();
		   var block=$j("#block").val();
		   var panchayat=$j("#panchayat").val();
		   var gram=$j("#gram").val();
		   var street=$j("#street").val();
		   var houseNo=$j("#houseNo").val();
		   var pin=$j("#pin").val();
		   
		   if (checkBox.checked == true)
	        {
			  
			   $j("#districtId2").val(districtId);
			   if(ruralOrUrban=='Rural'){
			   $j("#radio3").prop("checked", true);
			   }
			   else{
				   $j("#radio4").prop("checked", true);  
			   }
			   $j("#assembly2").val(assembly);
			   $j("#block2").val(block);
			   $j("#panchayat2").val(panchayat);
			   $j("#gram2").val(gram);
			   $j("#street2").val(street);
			   $j("#houseNo2").val(houseNo);
			   $j("#pin2").val(pin);
			   
	        }
		   else{
			   
			   $j("#districtId2").val("");
			   $j("#ruralOrUrban2").val("");
			   $j("#assembly2").val("");
			   $j("#block2").val("");
			   $j("#panchayat2").val("");
			   $j("#gram2").val("");
			   $j("#street2").val("");
			   $j("#houseNo2").val("");
			   $j("#pin2").val("");
			   
		   }
		   
	    }
 
	   function generateReport(){
	     	var labourId=$j("#labourId").val();
			
	        var url = "${pageContext.request.contextPath}/report/printLabourRegistration?labourId="+labourId;
			
	         openPdfModel(url);

	      }
	   
</script>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">New Labour Registration Form</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>
								
								<div class="row ">
									<div class="col-md-12">
										<h6 class="font-weight-bold text-theme text-underline">Personal Identification</h6>
									</div>
								</div>
								<div class="row ">
									<div class="col-lg-8 col-sm-6">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Does your family have ration card<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<select class="form-control" id="rationCard" onchange="showRationCardDiv()">
													<option value="">Select</option>
													<option value="Yes">Yes</option>
													<option value="No">No</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6" id="rationCardDiv">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Ration Card No<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input class="form-control" type="text" id="rationNo" maxlength="20">
											</div>
										</div>
									</div>
									
									<div class="col-lg-8 col-sm-6" > 
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Do you have aadhaar card<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<select class="form-control" id="aadharCard" onchange="showAadharCardDiv()">
													<option value="">Select</option>
													<option value="Yes">Yes</option>
													<option value="No">No</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6" id="aadharCardDiv">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Aadhaar No<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input class="form-control" type="text" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" id="aadharNo" maxlength="12">
											</div>
										</div>
									</div>
									
									<div class="col-lg-8 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Name of the worker(as per aadhaar in english)<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<input class="form-control" type="text" id="workerNameENG" maxlength="200">
											</div>
										</div>
									</div>
									<div class="col-lg-8 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Name of the worker(as per aadhaar in hindi)<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<input class="form-control" type="text" id="workerNameHIN" maxlength="200">
											</div>
										</div>
									</div>
									
									
									<div class="col-lg-8 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Name of the Father/Husband (in hindi))<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-2">
												<select class="form-control" id="fatherOrHusband">
													<option value="">Select</option>
													<option value="Father">Father</option>
													<option value="Husband">Husband</option>
												</select>
											</div>
											<div class="col-md-4">
												<input class="form-control" type="text" id="fatherOrHusbandHIN" maxlength="200">
											</div>
										</div>
									</div>
									<div class="col-lg-8 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Labour's mothers name (in hindi)</label>
											</div>
											<div class="col-md-6">
												<input class="form-control" type="text" id="motherNameHIN" maxlength="200">
											</div>
										</div>
									</div>
									
									<div class="w-100 m-t-10"></div> 
									
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Date of Birth<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" name="" id="dob" class="noFuture_datePos form-control" placeholder="DD/MM/YYYY" >
												</div>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Gender<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="genderId">
													<option value="" selected>Select</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Caste<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="castId">
													<option value="">Select</option>
													<option value="General">General</option>
													<option value="OBC">OBC</option>
													<option value="ST">ST</option>
													<option value="SC">SC</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Sub Caste</label>
											</div>
											<div class="col-md-7">
												<input class="form-control" type="text" id="subcast">
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Mobile No.<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input class="form-control" type="text" id="mobileNo" maxlength="10" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;">
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Marital Status<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												 <select class="form-control" id="marritalStatus">
													<option value="">Select</option>
													<option value="married">Married</option>
													<option value="Single">Single</option>
													<option value="Widow">Widow</option>
													<option value="destitute">Destitute</option>
													<option value="divided">Divided</option>
													<option value="divorced">Divorced</option>
													<option value="Vidur">Vidur</option>
												</select>
											</div>
										</div>
									</div>
									
								</div>
								
								<hr>
								
								<!-- Address (Permanent)  -->
								<div class="row m-t-20">
									<div class="col-md-12">
										<h6 class="font-weight-bold text-theme text-underline">Address (Permanent)</h6>
									</div>
								</div>
								<div class="row ">
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">District<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="districtId">
													
												</select>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Rural/Urban<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<div class="form-check form-check-inline cusRadio m-t-7">
													<input type="radio" class="form-check-input radioCheckCol2" id="radio1" name="ruralOrUrban" value="Rural" checked="checked" />
													<span class="cus-radiobtn"></span> 
													<label class="form-check-label" for="radio1">Rural</label>
												</div>
												<div class="form-check form-check-inline cusRadio">
													<input type="radio" class="form-check-input radioCheckCol2" id="radio2" name="ruralOrUrban" value="Urban"/>
													<span class="cus-radiobtn"></span> 
													<label class="form-check-label" for="radio2">Urban</label>
												</div>
											</div>
										</div>
									</div>
									
									<div class="w-100"></div> 
									
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Assembly Constituencies<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="assembly" maxlength="100">
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Block / Municipal Body <span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="block" maxlength="100">
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Panchayat<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="panchayat" maxlength="100">
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Gram/Ward<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
													<input type="text" class="form-control" id="gram" maxlength="100">
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Street</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="street" maxlength="100">
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">House Number<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="houseNo" maxlength="100">
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Pin Number<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="pin" maxlength="6" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;">
											</div>
										</div>
									</div>
									
								</div>
								
								<hr>
								
								<!-- Address (Current) -->
								<div class="row m-t-20">
									<div class="col-md-12">
										<h6 class="font-weight-bold text-theme text-underline">Address (Current)</h6>
									</div>
								</div>
								<div class="row ">
									<div class="col-12 m-b-20"> 
										<div class="form-check form-check-inline cusCheck m-t-7">
											<input type="checkbox" class="form-check-input" id="check1" name="ifpremanent" onclick="fillPresentAddress()" />
											<span class="cus-checkbtn"></span> 
											<label class="form-check-label" for="check1">Is the present address same as permanent address</label>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">District<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="districtId2">
												</select>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Rural/Urban<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<div class="form-check form-check-inline cusRadio m-t-7">
													<input type="radio" class="form-check-input radioCheckCol2" id="radio3" name="ruralOrUrban2" value="Rural"/>
													<span class="cus-radiobtn"></span> 
													<label class="form-check-label" for="radio1">Rural</label>
												</div>
												<div class="form-check form-check-inline cusRadio">
													<input type="radio" class="form-check-input radioCheckCol2" id="radio4" name="ruralOrUrban2" value="Urban"/>
													<span class="cus-radiobtn"></span> 
													<label class="form-check-label" for="radio2">Urban</label>
												</div>
											</div>
										</div>
									</div>
									
									<div class="w-100"></div> 
									
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Assembly Constituencies<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="assembly2" maxlength="100">
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Block / Municipal Body <span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="block2" maxlength="100">
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Panchayat<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="panchayat2" maxlength="100">
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Gram/Ward<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="gram2" maxlength="100">
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Street</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="street2" maxlength="100">
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">House Number<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="houseNo2" maxlength="100">
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6"">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Pin Number<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="pin2" maxlength="6" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;">
											</div>
										</div>
									</div>
									
								</div>
								
								<!-- <hr> -->
								
								<div class="row">
									<div class="col-lg-8 col-sm-6">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Do you have a bank account<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<select class="form-control" id="bankAccountCheck" onchange="showBankDetailsDiv()">
													<option value="" selected>Select</option>
													<option value="Yes">Yes</option>
													<option value="No">No</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-lg-8 col-sm-6" id="bankNameDiv">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Bank Name<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<input type="text" class="form-control" id="bankName" maxlength="100">
											</div>
										</div>
									</div>
									<div class="col-lg-8 col-sm-6" id="branchNameDiv">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Branch Name<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<input type="text" class="form-control" id="branchName" maxlength="100">
											</div>
										</div>
									</div>
									<div class="col-lg-8 col-sm-6" id="accountNoDiv">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Account Number<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<input type="text" class="form-control" maxlength="100" id="accountNo" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;">
											</div>
										</div>
									</div>
									<div class="col-lg-8 col-sm-6" id="ifscCodeDiv">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">IFSC Number<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<input type="text" class="form-control" id="ifscCode" maxlength="50">
											</div>
										</div>
									</div>
									<div class="col-lg-8 col-sm-6">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Do you have a U.N. number<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<select class="form-control" id="unNoCheck" onchange="showUnNO()">
													<option value="" selected>Select</option>
													<option value="Yes">Yes</option>
													<option value="No">No</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-lg-8 col-sm-6" id="unNoDiv">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">UN number (EPF account number)<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<input type="text" class="form-control" id="unNo" maxlength="100">
											</div>
										</div>
									</div>
									<div class="w-100 m-t-10"></div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Your health status<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="healthStatus" maxlength="100">
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Type of handicapped<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<input type="text" class="form-control" id="typeOfHandicapped" maxlength="100">
											</div>
										</div>
									</div> 
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Type of illness<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="typeOfIllness" maxlength="100">
											</div>
										</div>
									</div>
								</div>
								
								<hr>
								
								<!-- Education -->
								<div class="row m-t-20">
									<div class="col-md-12">
										<h6 class="font-weight-bold text-theme text-underline">Education</h6>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Literacy</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="literacy">
													<option value="" selected>Select</option>
													<option value="Educated">Educated</option>
													<option value="illiterate">illiterate</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-lg-8 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">Do you want to take admission in adult literacy school</label>
											</div>
											<div class="col-md-4">
												<select class="form-control" id="">
													<option value="" selected>Select</option>
													<option value="Yes">Yes</option>
													<option value="No">No</option>
												</select>
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Type of education</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="typeOfEducation" maxlength="">
											</div>
										</div>
									</div>
									
									<div class="col-lg-8 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">Status of formal education</label>
											</div>
											<div class="col-md-4">
											<input type="text" class="form-control" id="formalEducation">
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Level of education</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="levelOfEducation">
											</div>
										</div>
									</div>
									
									<div class="col-lg-8 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">School/ Undergraduate/ Post Graduate/ Diploma/ Vocational Training</label>
											</div>
											<div class="col-md-4">
												<input type="text" class="form-control" id="educationTraining">
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Other</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="otherEducation" maxlength="100">
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Type of school</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="typeOfSchool" maxlength="100">
											</div>
										</div>
									</div>
									<div class="w-100"></div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Means of transport</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="meansOfTransport" maxlength="100">
											</div>
										</div>
									</div>
									<div class="w-100"></div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Scholarship Availed</label>
											</div>
											<div class="col-md-7"> 
												<input type="text" class="form-control" id="scholorshipAvailed" maxlength="100">
											</div>
										</div>
									</div>
																		
									<div class="col-lg-8 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">Name of department awarding the scholarship</label>
											</div>
											<div class="col-md-4">
												<input type="text" class="form-control" id="scholorshipDepartment" maxlength="100">
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Scholarship scheme</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="scholorshipScheme" maxlength="100">
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Give reason</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="giveReason" maxlength="100">
											</div>
										</div>
									</div>
								</div>
								
								<hr>
								
								<!-- Personal Identification -->
								<div class="row m-t-20">
									<div class="col-md-12">
										<h6 class="font-weight-bold text-theme text-underline">Personal Identification</h6>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-8 col-sm-6">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Are you the head of the family (HOF)<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<select class="form-control" id="familyHeadCheck" onchange="setHOFGender()">
													<option value="" selected>Select</option>
													<option value="Yes">Yes</option>
													<option value="No">No</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">HOF Gender<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="hofGender">
													<option value="" selected>Select</option>
												</select>
											</div>
										</div> 
									</div>
									<div class="col-lg-8 col-sm-6">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Your relationship with HOF<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<select class="form-control" id="relationWithHOF">
												</select>
											</div>
										</div>
									</div>
								</div>
								
								<hr>
								
								<!-- Family Identity -->
								<div class="row m-t-20">
									<div class="col-md-12">
										<h6 class="font-weight-bold text-theme text-underline">Family Identity</h6>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-8 col-sm-6">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Do youn have a SECC ATH TIN number<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<select class="form-control" id="tinNoCheck" onchange="showTinNoDiv()">
													<option value="" selected>Select</option>
													<option value="Yes">Yes</option>
													<option value="No">No</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-lg-8 col-sm-6" id="tinNoDiv">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">SECC ATH TIN number<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<input type="text" class="form-control" id="tinNo" maxlength="10">
											</div>
										</div>
									</div>
									
									<div class="col-lg-8 col-sm-6">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Are you registered under Ayushman Bharat/ Khub Chand Baghel Scheme/ Do you have any health card<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<select class="form-control" id="registeredCheck" onchange="showSchemeNoDiv()">
													<option value="" selected>Select</option>
													<option value="Yes">Yes</option>
													<option value="No">No</option>
												</select>
											</div>
										</div>
									</div>
									
									<div class="col-lg-8 col-sm-6" id="schemeNoDiv">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Ayushman Bharat/ Khub Chand Baghel Scheme number<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<input type="text" class="form-control" id="schemeNo" maxlength="100">
											</div>
										</div>
									</div>
									
									<div class="col-lg-8 col-sm-6">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Does your family have a MGNREGA job card<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<select class="form-control" id="checkjobCardNo" onchange="showJobCardNoDiv()">
													<option value="" selected>Select</option>
													<option value="Yes">Yes</option>
													<option value="No">No</option>
												</select>
											</div>
										</div>
									</div>
									
									<div class="col-lg-8 col-sm-6" id="jobCardNoDiv">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">MGNREGA job card number<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<input type="text" class="form-control" id="jobCardNo" maxlength="100">
											</div>
										</div>
									</div>
									
								</div>
								
								<hr>
								<!-- Other Details -->
								<div class="row m-t-20">
									<div class="col-md-12">
										<h6 class="font-weight-bold text-theme text-underline">Other Details</h6>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Survey ID/ Worker ID<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-6">
												<input type="text" class="form-control" id="surveyId" maxlength="100">
											</div>
										</div>
									</div>
								</div>
								
								<div class="col-12 text-right">
									<button type="button" class="btn  btn-primary" onclick="saveLabourRegistration(this)">Submit</button>
									<button type="button" class="btn  btn-primary" id="printBtn" onclick="generateReport();">Print Report</button>
								</div>
                               <input type="hidden"  id="labourId" name="labourId" value="0">
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
