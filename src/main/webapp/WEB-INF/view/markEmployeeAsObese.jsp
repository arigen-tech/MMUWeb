<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>
<%-- <%@page import="com.asha.icgweb.utils.HMSUtil"%> --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>New Entry for Obesity/ Overweight</title>
<%@include file="..//view/commonJavaScript.jsp"%>
<%-- <%long valueRegistrationTypeId = Long.parseLong(HMSUtil.getProperties("js_messages_en.properties", "REGISTRATION_TYPE_ICG_ID")); %> --%>
</head>
<script type="text/javascript" language="javascript">
	
	<%			
		String hospitalId = "1";
		if (session.getAttribute("hospital_id") !=null)
		{
			hospitalId = session.getAttribute("hospital_id")+"";
		}
		String userId = "1";
		if (session.getAttribute("user_id") != null) {
			userId = session.getAttribute("user_id") + "";
		}
		String stationId="1";
		if (session.getAttribute("stationId") != null) {
		stationId = session.getAttribute("stationId") + "";
		}
	%>
	var $j = jQuery.noConflict();
	$j(document).ready(function() {
		getGenderList();
		getAllRankList();
		getAllUnitList();
		$j('#loadingSearch').hide();
		
	});
	var result = '';
	function getPatientList(){
	
		var params = {
				"service_no": $j('#service_no').val()
		}
		 $j.ajax({
				type:"POST",
				contentType : "application/json",
				url: 'getServiceWisePatientList',
				data : JSON.stringify(params),
				dataType: "json",			
				cache: false,
				success: function(data)
				{  
					result = data;
					var data_length = data.patient_list.length;
					if(data_length == 0){
						alert("Service No. does not exist");
						return;
					}
					$j('#patient_list').empty();
					var make_patient_List_combo = '<option value="">Select</option>';
					for(var i=0;i<data_length;i++){
						make_patient_List_combo += '<option value="'+data.patient_list[i].patient_id+'">'+data.patient_list[i].patient_name+'</option>'
					}
					$j('#patient_list').append(make_patient_List_combo);
					
				},
				
				error: function(data)
				{					
					
					alert("An error has occurred while contacting the server");
					
				}
		}); 
	}
	
	function getPatientListFromEmployeeDependent(){
		$j('#loadingSearch').show();
		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/opd/patientListForEmployeeAndDependent";
		
		$('.loaderimg').show();
		var serviceNo = $j('#serviceNo').val();
		$j('#patientId').val("");
		if(serviceNo){
			var params = {
					"serviceNo":serviceNo
			}
			$j.ajax({
				
				type : "POST",
				contentType : "application/json",
				url : url,
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(response) {
					$j('#loadingSearch').hide();
					if(response.status=='1'){
						var patientValue = "";
						 patientList = response.data;
						 var checkPatientFlag = false;
						 for(count in patientList){
							 var relation = patientList[count].relation;
							 console.log(relation);
							 if(relation == 'Self'){
								 checkPatientFlag = true;
								var patientId = patientList[count].patientId+'~~'+patientList[count].Id;
								changePatientName(patientId);
							 }
						 }
						if(!checkPatientFlag){
							alert("No Record found");
							return;
						}
					}else if(response.status=='0'){
						alert(response.msg);
						return;
					}
					
					$('.loaderimg').hide();
				}
			});
		}else{
			alert("Service No. can not be blank.");
			$('#loadingSearch').hide();
			return false;
		}
		
	}
	
	function changePatientName(patientSelectValue){
		var splitValue=patientSelectValue.split("~~");
		var patientId = splitValue[0];
		var rowId = parseInt(splitValue[1]);
		
		
		for(count in patientList){
		if(patientList[count].relation == 'Self'){
			$j('#patientId').val(patientList[count].patientId);
			$j('#uhidNo').val(patientList[count].uhidNo);
			$j('#relation').val(patientList[count].relation).prop("readonly", true);
			$j('#patientDOB').val(patientList[count].dateOfBirth);
			$j('#relationId').val(patientList[count].relationId);
			$j('#serviceNo2').val(patientList[count].serviceNo);
			$j('#rankId').val(patientList[count].empRankId);
			$j('#unit').val(patientList[count].empUnitId);
			$j('#gender').val(patientList[count].genderId);
			$j('#emp_name').val(patientList[count].empName).prop("readonly", true);
			$j('#age').val(patientList[count].age);
			$j('#empServiceJoinDate').val(patientList[count].empServiceJoinDate);
			$j('#empRecordOfficeId').val(patientList[count].empRecordOfficeId);
			$j('#empMaritalStatusId').val(patientList[count].empMaritalStatusId);
			$j('#employeeCategoryId').val(patientList[count].employeeCategoryId);
			$j('#patientName').val(patientList[count].name);
			}
		}
		
	}
	
	function getAllUnitList(){
		var unitData=${unitList};
		$('#unit').html("");
		var combo = "<option value=''>Select</option>" ;	
		var response = unitData.data;
		
		for(var i in response) {
		    if (response.hasOwnProperty(i)) {
		        /* console.log('Key is: ' + i + '. Value is: ' + response[i]); */
		        combo += '<option value='+response[i]+'>' +i+ '</option>';
		    }
		}
		$('#unit').append(combo);
     }
	
	function getAllRankList(){			
		$('#rankId').html("");
		var rankData=${rankList};
		var combo = "<option value=''>Select</option>" ;	    	
		 for(var i=0;i<rankData.data.length;i++){
				 combo += '<option value='+rankData.data[i].rankId+'>' +rankData.data[i].rankName+ '</option>';
		    	} 
	        $('#rankId').append(combo);
	}
	
	function getGenderList(){
		
		$('#gender').html("");
		var genderData=${genderList};
		var combo = "<option value=''>Select</option>" ;	    	
		 for(var i=0;i<genderData.data.length;i++){
				 combo += '<option value='+genderData.data[i].administrativeSexId+'>' +genderData.data[i].administrativeSexName+ '</option>';
		    } 
	      $('#gender').append(combo);
	}
	
    function calculateAge() {
   		var Bdate = $j('#patientDOB').val()
   		var newdate = Bdate.split("/").reverse().join("-");
   		var Bday = new Date(newdate);
   		var age = parseFloat(((Date.now() - Bday) / (31557600000)), 10)
   				.toFixed(3);
   		if (age > 0 && age <= 100) {
   			showAge();
   		} else {
   			alert("Age can not be less then 0 or greater then 100");
   			$j('#patientDOB').val("");
   			$j('#age').val("");
   		}

   	}

   	function showAge() {
   		var newdate = $j('#patientDOB').val().toString();
   		var mdate = newdate.split("/").reverse().join("-");
   		var yearThen = parseInt(mdate.substring(0, 4), 10);
   		var monthThen = parseInt(mdate.substring(5, 7), 10);
   		var dayThen = parseInt(mdate.substring(8, 10), 10);

   		var today = new Date();
   		var birthday = new Date(yearThen, monthThen - 1, dayThen);

   		var differenceInMilisecond = today.valueOf() - birthday.valueOf();

   		var year_age = Math.floor(differenceInMilisecond / 31536000000);
   		var day_age = Math
   				.floor((differenceInMilisecond % 31536000000) / 86400000);

   		if ((today.getMonth() == birthday.getMonth())
   				&& (today.getDate() == birthday.getDate())) {
   			//  alert("Happy B'day!!");
   		}

   		var month_age = Math.floor(day_age / 30);

   		day_age = day_age % 30;

   		if (isNaN(year_age) || isNaN(month_age) || isNaN(day_age)) {
			$("#age").val("Invalid date - Please try again");
		}else if (year_age == 0 && month_age == 0 && day_age == 0) {
			alert("Age can not be less then 0 or greater then 100");
			$j('#patientDOB').val("");
			$j('#age').val("");
			return false;
		}else{
			$("#age").val(year_age + " years, " + month_age + " months, " + day_age + " days");
		}
   	}
	  	   
    
    function saveObesityDetail(){
    	
		var serviceNo=$("#serviceNo2").val();
		var name=$("#emp_name").val();
		var patientName=$("#patientName").val();
		var rankId=$("#rankId option:selected").val();
		var relationId = $('#relationId').val();
		var patientDOB=$("#patientDOB").val();
		var unitId=$('#unit').find('option:selected').val();
	    var patientId=$("#patientId").val();
		var genderId=$("#gender option:selected").val();
		var uhidNo = $('#uhidNo').val();
		var employeeCategoryId = $('#employeeCategoryId').val();
		var empMaritalStatusId = $('#empMaritalStatusId').val();
		var empRecordOfficeId = $('#empRecordOfficeId').val();
		var empServiceJoinDate = $('#empServiceJoinDate').val();	
		var registrationTypeId = $('#registrationTypeId').val();
		if(serviceNo=='' ){
			alert("Please Enter Service no");
			return false;
		}

		if(patientId=='' ){
			alert("Please Select Patient Name");
			return false;
		}

		if(rankId=='' ){
			alert("Please Select Rank");
			return false;
		}
		if(unitId=='' || unitId===undefined){
			alert("Please Select Unit");
			return false;
		}

		if(genderId=='' ){
			alert("Please Select Gender");
			return false;
		}
	
		if(patientDOB=='' ){
			alert("Please Select DOB");
			return false;
		}
		
		var height = $('#height').val();
		var idealWeight = $('#ideal_weight').val();
		var weight = $('#weight').val();
		var weight = $('#weight').val();
		var variation = $('#variant_in_weight').val();
		var bmi = $('#bmi').val();
		if(height == ''){
			alert("Please enter height");
			return
		}
		if(weight == ''){
			alert("Please enter weight");
			return
		}
		if(($('#obsistyCheck').is(':checked') == false) && ($('#overCheck').is(':checked') == false)){
			alert("Please mark obesity or overweight");
			return;
		}
		var overweightFlag = $('#overCheck').is(':checked');
		var overweightValue = '';
		if(overweightFlag){
			overweightValue = 'Y';	
		}else{
			overweightValue = 'N';
		}
		var params = {
				
			 	"serviceNo": serviceNo,
			    "rankId" : rankId,
			    "relationId" : relationId,
			    "patientDOB"	: patientDOB,
			    "genderId" : genderId,
			    "patientId" : patientId,
			    "userId" : <%=userId%>,
			    "stationId":<%=stationId%>,
			    "rankId" :rankId,
			    "unitId" : unitId,
			     "uhidNo":uhidNo,
				 "employeeCategoryId":employeeCategoryId,
				 "empMaritalStatusId":empMaritalStatusId,
				 "empRecordOfficeId":empRecordOfficeId,
				 "empServiceJoinDate":empServiceJoinDate,
				 "registrationTypeId":registrationTypeId,	
			     "employeeName" : name,
			     "patientName" : patientName,
			     "hospital_id": <%= hospitalId %>,
				"height":height,
				"weight":weight,
				"idealWeight":idealWeight,
				"variation":variation,
				"bmi":bmi,
				"overweightFlag":overweightValue
				
		}
		console.log("params are ::: "+JSON.stringify(params));
		$j('#submit_btn').attr("disabled", true);
		 $j.ajax({
				type:"POST",
				contentType : "application/json",
				url: 'saveObesityEntry',
				data : JSON.stringify(params),
				dataType: "json",			
				cache: false,
				success: function(data)
				{  
					$j('#submit_btn').attr("disabled", false);
					if(data.status == '1'){
						var msg = data.msg;
						alert(data.msg+'S');
						document.addEventListener('click',function(e){
	   					    if(e.target && e.target.id== 'closeBtn'){
	   	   	   				 	window.location="obesityWaitingJsp";
	   					     }
	   					 });
					}else{
						alert(data.msg);
					}
					
				},
				
				error: function(data)
				{					
					alert("An error has occurred while contacting the server");
					$j('#submit_btn').attr("disabled", false);
				}
		}); 
    }
    
    function resetDetail(){
    	$j('#height').val('');
    	$j('#weight').val('');
    	$j('#ideal_weight').val('');
    	$j('#variant_in_weight').val('');
    	$j('#bmi').val('');
    }
    
    function closeScreen(){
    	window.location = 'obesityWaitingJsp';
    }
    
	function isNumber(evt) {
	    evt = (evt) ? evt : window.event;
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
	        return false;
	    }
	    return true;
	}
	
	function checkVaration()  {

    	var a = document.getElementById("ideal_weight").value;
		var b = document.getElementById("weight").value;
      if(a!=null && b!=null && a!="" && b!="")
       {	  
		if (parseFloat(a) > parseFloat(b)) {
			var sub = a - b;
			var cal = sub * 100 / a
			var n = cal.toFixed(2);
			$('#variant_in_weight').val("-" + n);

		} else {
			var eadd = b - a;
			var cal1 = eadd * 100 / a
			var n1 = cal1.toFixed(2);
			$('#variant_in_weight').val("+" +n1);
		}
		var obsistyCheckAlready=$('#obsistyCheckAlready').val();
		if(obsistyCheckAlready!="exits")
		{	
		var varationWightVal = document.getElementById("variant_in_weight").value;
		 var varationWightActual='10';
		 if(document.getElementById("overCheck").checked == true){
		 if(document.getElementById('variant_in_weight').value != "" && parseFloat(varationWightActual) > parseFloat(varationWightVal))
			{	
				alert("Overweight Cannot be selected as variation in weight is less than 10  ")
				document.getElementById("overCheck").checked=false;
				obsistyOverWeight = "";
				$('#overWeightDropDown').hide();
				return false;
			}
		 }
		 if(document.getElementById("obsistyCheck").checked == true){
    		 if(document.getElementById('variant_in_weight').value != "" && parseFloat(varationWightActual) > parseFloat(varationWightVal))
    			{	
    				alert("Obesity Cannot be selected as variation in weight is less than 10  ")
    				document.getElementById("obsistyCheck").checked=false;
    				obsistyOverWeight = "";
    				return false;
    			}
    		 }
       }
     }	
}
	
	function checkBMI() {
		var a = document.getElementById("weight").value;
		var b = document.getElementById("height").value;
		if(a != "" && b != ""){
			var c=b/100;
			var d=c*c;
			var sub = a/d;
			$('#bmi').val(parseFloat(Math.round(sub * 100) / 100).toFixed(2));
		}
	}
	
	function checkObsistyMark() {
		
		if(document.getElementById('variant_in_weight').value== '' && document.getElementById('variant_in_weight').value== undefined)
		{
			alert("Please enter Height and Varation and Weight");
			return false;
		}
	
	}
	
	function idealWeight() {
		var serviceNo = $('#serviceNo').val();
		if(serviceNo == ''){
			alert("Service No. can not be blank.");
			$('#height').val('');
			return;
		}
		var genderId = $('#gender').val();
		var age = $('#age').val();  
		var ageNumber = 0;
		if(genderId == '' || genderId == undefined){
			alert("Please select gender.");
			return;
		}
		if(age == '' || age == undefined || age =='0'){
			alert("Please select date of birth.");
			return;
		}else{
			age = age.split(" ");
			ageNumber = age[0];  
			if(isNaN(ageNumber)){
				alert("Please select valid date of birth");
				return;
			}
		}
		  
		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";

		var url = window.location.protocol + "//"
				+ window.location.host + "/" + accessGroup
				+ "/opd/getIdealWeight";
	   
		var dataJSON={
				 
				  'height':$('#height').val(),
	      		  'age':ageNumber,
				  'genderId':$('#gender').val(),
				
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
				$('#ideal_weight').val(data.data[0].idealWeight);
				$('#ideal_weight').attr("disabled","disabled");
	           
				
			    }
			   	   	   else
			   	   		   {
			   	   		   	alert("Ideal Weight Not Configured")
			   	   		   	$('#ideal_weight').val('');
							$('#ideal_weight').removeAttr("disabled");
			   	   		   }
				
				

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
	
	var obsistyOverWeight='';
	function overWeight(radioValue)
	{
		 var varationWightVal = document.getElementById("variant_in_weight").value;
		 var varationWightActual='10';
		 //var text = document.getElementById("text");
		 if(document.getElementById("obsistyCheck").checked == true){
			 obsistyOverWeight = radioValue; 
			 $('#overWeightDropDown').hide();
		  }
		 if(document.getElementById("overCheck").checked == true){
			if(document.getElementById('variant_in_weight').value == "")
		 	{	
				$('#overWeightDropDown').hide();
		 	alert("Overweight Cannot be selected as variation in weight is less than 10")
		 	document.getElementById("overCheck").checked=false;
		 	return false;
		 	}
				
			else if(document.getElementById('variant_in_weight').value != "" && parseFloat(varationWightActual) > parseFloat(varationWightVal))
			{	
				$('#overWeightDropDown').hide();
				alert("Overweight Cannot be selected as variation in weight is less than 10")
				document.getElementById("overCheck").checked=false;
				return false;
			}
			
			else
			{	
			 obsistyOverWeight = radioValue; 
			 $('#overWeightDropDown').show();
			 var a = document.getElementById("variant_in_weight").value;
			 var b='20';
			 if(parseFloat(b) > parseFloat(a))
			 {
				
				 document.getElementById("under20").selected=true;	 
			 }
			 else
			 {
				 document.getElementById("above20").selected=true;	 
			 } 
			}
		  }
		
		 if(document.getElementById("obsistyCheck").checked == true){
				if(document.getElementById('variant_in_weight').value == "")
		 		{	
					$('#overWeightDropDown').hide();
		 		alert("Obesity Cannot be selected as variation in weight is less than 10  ")
		 		document.getElementById("obsistyCheck").checked=false;
		 		return false;
		 		}
				
				else if(document.getElementById('variant_in_weight').value != "" && parseFloat(varationWightActual) > parseFloat(varationWightVal))
				{	
					$('#overWeightDropDown').hide();
					alert("Obesity Cannot be selected as variation in weight is less than 10  ")
			 		document.getElementById("obsistyCheck").checked=false;
			 		return false;
				}
			  }
			
	}
</script>

<body>
 <!-- Begin page -->
    <div id="wrapper">

	<div class="content-page">
		<div class="">
			<div class="container-fluid">
				<div class="internal_Htext">New Entry for Obesity/ Overweight</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">


								<div class="row">
									<div class="col-md-12">
										<form id="newAdmission" name="newAdmission">
										<div class="row">
										<h4  class="service_htext">Patient Details</h4>
										</div>
											<div class="row">

												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class=" col-form-label  ">Service No. </label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="serviceNo"
																name="serviceNo" onblur="getPatientListFromEmployeeDependent();">
														</div>
													</div>
												</div>
												<div class="col-md-1">
														<span id="loadingSearch">
																<img class="m-r-10 " src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
														</span>
												</div>
												</div>
												<div class="row">
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Service No.</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="serviceNo2" value="" readonly>
														</div>
													</div>
												</div>

												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class=" col-form-label  ">Patient Name </label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="patientName" value="" readonly>
														</div>
													</div>
												</div>
												<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">DOB <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>											
													<div class="col-md-7">
													<div class="dateHolder">
														<input type="text" class="calDate datePickerInput form-control" name="patientDOB" id="patientDOB" 
															onchange="calculateAge()" placeholder="DD/MM/YYYY" maxlength="10" />
														</div>
													</div>
												</div>
											</div>
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Age</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="age"
																name="age" readonly>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Gender</label>
														</div>
														<div class="col-sm-7">
															<select name="gender" id="gender" class="form-control selectTextWarp"></select>
														</div>
													</div>
												</div>
											<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Name</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="emp_name" readonly>
														</div>
													</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">Unit <span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<select name="unit" id="unit" class="form-control selectTextWarp"></select>
													</div>
												</div>
											</div>
											<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class=" col-form-label  ">Rank </label>
														</div>
														<div class="col-sm-7">
															<select id="rankId" name="rankId" class="form-control selectTextWarp"></select>
														</div>
													</div>
												</div>

												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class=" col-form-label  ">Relation</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="relation" readonly>
														</div>
													</div>
												</div>
												</div>
<!-- 												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Date of Admission</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="instructions">
														</div>
													</div>
												</div> -->
												<div class="row">
													<h4  class="service_htext">Vital Details</h4>
												</div>
												<div class="row">
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Height</label>
														</div>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="height" onblur="idealWeight();checkBMI();">
													</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<label class="col-md-5 col-form-label">Ideal Weight
														</label>
														<div class="col-md-7">
															<div class="input-group mb-2 mr-sm-2">
																<input name="ideal_weight" id="ideal_weight" maxlength="5" onblur="checkVaration()" type="text"
																class="form-control border-input" disabled
																placeholder="Ideal Weight" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" />
															    <div class="input-group-append">
															      <div class="input-group-text">kg</div>
															    </div>
															    
															  </div>
														</div>
													</div>
												</div>

											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-md-4 col-form-label">Weight</label>
													<div class="col-md-8">
														<div class="input-group mb-2 mr-sm-2">
															<input name="Weight" id="weight" type="text"
															class="form-control border-input" maxlength="5" onblur="checkVaration();checkBMI();" placeholder="Weight" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" />
														    <div class="input-group-append">
														      <div class="input-group-text">kg</div>
														    </div>
														    
														  </div>
													</div>
												</div>
											</div>


												
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Variation in weight(%)</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="variant_in_weight" readonly>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
													
													<div class="col-sm-5">
															<label class="col-form-label  ">BMI</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="bmi" readonly>
														</div>
													
													</div>
												</div>
												
												</div>
												
												<div class="row m-t-5">
												
													<div class="col-md-2">
												
														<div class="form-check form-check-inline cusRadio m-t-5">
															<input type="radio" value="N" class="form-check-input radioCheckCol2"
															name="ObesityCheck" id="obsistyCheck" onchange="overWeight(this.value)" />
															<span class="cus-radiobtn"></span> 
															<label class="form-check-label" for="obsistyCheck">Obesity</label>
														</div>
														
													</div>
												<div class="col-md-2">
												<div class="form-check form-check-inline cusRadio m-t-5">
													<input type="radio" value="Y" class="form-check-input radioCheckCol2"
															name="ObesityCheck" id="overCheck" onchange="overWeight(this.value)" />
															<span class="cus-radiobtn"></span>
													<label class="form-check-label" for="overCheck">Overweight</label>
													</div>
												</div>
												<div class="col-md-2 makeDisabled">
														<div style="display: none" id="overWeightDropDown">
														<select name="overWeightDivId"  class="form-control p-l-5" id="overWeightSelect"  tabindex="1">
																<option id="under20" value="S">10-20</option>
																<option id="above20" value="H">>20</option>
															</select>
														</div>
															
													</div>

												<div class="form-row">
													<input type="hidden" id="header_id" value="">
													<input	type="hidden" id="relationId" value="">
													<input	type="hidden" id="patient_id" value="">
													<input type="hidden" id="admission_id" value="">
													<input type="hidden" name="userId" id="userId" value="<%=userId%>"/>
													<input type="hidden" name="patientId" id="patientId" />
													<input type="hidden"  name="uhidNo" value=""  id="uhidNo"  />
													<input type="hidden"  name="dateOfBirth" value="" id="dateOfBirth"/>
													<input type="hidden"  name="empServiceJoinDate" value="" id="empServiceJoinDate"/>										
													<input type="hidden"  name="empRecordOfficeId" value="" id="empRecordOfficeId"/>
													<input type="hidden"  name="empMaritalStatusId" value="" id="empMaritalStatusId"/>
													<input type="hidden"  name="employeeCategoryId" value="" id="employeeCategoryId"/>
													<%-- <input type="hidden"  name="registrationTypeId" value="<%=valueRegistrationTypeId%>" id="registrationTypeId"/> --%>
												</div>



												<div class="col-md-12 text-right">
												
														<button type="button" id="submit_btn" class="btn btn-primary" onclick="saveObesityDetail()">Submit</button>
													
														<button type="button" class="btn btn-danger" onclick="resetDetail()">Reset</button>
													 	
														<button type="button" class="btn btn-primary" onclick="closeScreen()">Close</button>
													
												</div>
												
														

											</div>
										</form>
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
</body>
</html>