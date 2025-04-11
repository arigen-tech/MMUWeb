<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@include file="..//view/leftMenu.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Registration &amp; Appointment of Patient</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/simplepeer.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/socket.io.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/p5.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/p5.sound.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/p5livemedia.js"></script>
	
	<!--  <script type="text/javascript" src="https://p5livemedia.itp.io/simplepeer.min.js"></script>
	<script type="text/javascript" src="https://p5livemedia.itp.io/socket.io.js"></script>    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/1.1.9/p5.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/1.1.9/addons/p5.sound.min.js"></script>	
    <script type="text/javascript" src="https://p5livemedia.itp.io/p5livemedia.js"></script> -->
     
<script type="text/javascript">
<%			String mmuId = "0";
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
				campLocation = campLocation.replaceAll("[\\n\\t ]", " ");
			}
			
			String campOrOff = "";
			if (session.getAttribute("campOrOff") != null) {
				campOrOff = session.getAttribute("campOrOff") + "";
			}
			
			%>
var arrListOfImg = new Array();
nPageNo=1;
var $j = jQuery.noConflict();
var myvar ="";
var signAndSymptomsGlobalArray = [];
$j(document).ready(function()
		{
			$("#deleteBtnDiagnosis").attr("disabled", true);
			getFrequentlyUsedSymptomsList();
			var campOrOff = "<%= campOrOff %>";
			//alert(campOrOff)
			if(campOrOff != 'Camp'){
				alert("Camp is not configured");
				return;
			}		
			getGenderList();
						
			var departmentId = "<%= departmentId %>";
			var departmentName = "<%= departmentName %>";
			var departmentDrop = "<option value="+departmentId+" selected>"+departmentName+"</option>";
			$('#departmentId').append(departmentDrop);
			$('#patientName').focus();
			var cityLocation = "<%= cityName %>";
			var campLocation = "<%= campLocation %>";
			var campLoation = cityLocation +" - "+campLocation;
			if(campLoation.trim() != "-"){
				$('#camp_location').val(cityLocation +" - "+campLocation);
			}
			$("#registrationhistory").hide();
			$('#checkbox_div').hide();
			
		});
var checkboxCount = '';
function getFrequentlyUsedSymptomsList(){
	var params = {}
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : 'getFrequentlyUsedSymptomsList',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(data) {
			if(data.status == true){
				var list = data.list;
				checkboxCount = list.length;
				//checkboxCount = '10';
				//var checkboxHTML = '<h6 class="font-weight-bold text-theme text-underline">Signs &amp; Symptoms</h6>';
				var checkboxHTML='';
				checkboxHTML += '<div class="row multiCheck">';
				for(i=0;i<list.length;i++){
					checkboxHTML += '<div class="col-md-2">';
					checkboxHTML += '<div class="form-check form-check-inline cusCheck m-r-10">';
					var cText = list[i].name+'['+list[i].id+']';
					
					checkboxHTML += "<input class='form-check-input' id='check"+i+"' name='signs' type='checkbox' value='"+cText+"'>";
					checkboxHTML += '<span class="cus-checkbtn"></span>';
					checkboxHTML += '<label class="col-form-label" for="check'+i+'">'+list[i].name+'</label>';
					checkboxHTML += '</div>';
					checkboxHTML += '</div>';
				}
				checkboxHTML += '</div>';
				$j('#checkbox_div').html(checkboxHTML);
				$j('#checkbox_div').show();
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
		
function getCityList(item){
		var params = {
				"districtId":item.value
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
 	
function getReligionList(){
	var params = {}
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : 'getReligionList',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(data) {
			if(data.status == true){
				var list = data.list;
				var cityDrop = '<option value="">Select</option>';
				for(i=0;i<list.length;i++){
					cityDrop += '<option value='+list[i].religionId+'>'+list[i].religionName+'</option>';
				}
				$j('#religionId').append(cityDrop);
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
	var url =  "../opd/getGenderList";
	
	
	
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


function getDepartmentList(){
	var params = {
			"mmuId":"<%= mmuId %>"
	}
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : 'getMMUDepartment',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(data) {
			if(data.status == true){
				var list = data.list;
				var dropDrop = '<option value="">Select</option>';
				for(i=0;i<list.length;i++){
					if(i == 0){
						dropDrop += '<option value='+list[i].departmentId+' selected>'+list[i].departmentName+'</option>';
					}else{
						dropDrop += '<option value='+list[i].departmentId+'>'+list[i].departmentName+'</option>';
					}
					
				}
				//$j('#departmentId').append(dropDrop);
			}
		},
		error : function(data) {
			alert("An error has occurred while contacting the server");
		}
	}); 
}

function savePatientAndCreateAppointment(item){
	var patientName = $('#patientName').val();
	var mobileNo = $('#mobileNo').val();
	var genderId = $('#genderId').val();
	var age = $('#age').val();
	var patientImage = $('#patientImage').val();
	var empTypeId = $('#empTypeId').val();
	var departmentId = $('#departmentId').val();
	var base64ForProfileStr = $('#base64ForProfile').val();
	var base64ForIdStr =  $('#base64ForId').val();
	var idMimeType =  $('#idMimeType').val();
	var demo1 ="";
	if(!lettersNumbersCheck(patientName)){
		return false;
	}
	if(patientName == ''){
		alert("Please enter Patient Name");
		return;
	}
	if(mobileNo == ''){
		alert("Please enter Mobile No.");
		return;
	}else if(mobileNo.trim().length < 10){
		alert("Please enter valid Mobile No.");
		return;
	}
	else if(mobileNo=="0000000000"){
		alert("Please enter valid Mobile No.");
		return;
	}
	else if(mobileNo=="1234567890"){
		alert("Please enter valid Mobile No.");
		return;
	}
	if(genderId == ''){
		alert("Please select gender");
		return;
	}
	if(age == '' || age=='0'){
		if(age=='0'){
			alert("0 is not allowed in age");
		}else
		alert("Please enter age");
		return;
	}
	var ageFlag = $('#ageId').val();
	if(departmentId == ''){
		alert("Please select department");
		return;
	}
	
	
	var height = $('#height').val();
	if(height == ''){
		alert("Please enter height");
		return;
	}
	var weight = $('#weight').val();
	if(weight == ''){
		alert("Please enter weight");
		return;
	}
	var temp = $('#tempature').val();
	if(temp == ''){
		alert("Please enter temperature");
		return;
	}
	
	if(age >12 && ageFlag == 'Y'){
		
		var	bp = $('#bp').val();
		if(bp == ''){
			alert("Please enter bp");
			return;
		}
		
		var bp1 = $('#bp1').val();
		if(bp1 == ''){
			alert("Please enter bp");
			return;
		}
	}

	/* if(patientImage == ''){
		alert("Please take patient photo");
		return;			
	}  */
	
	var pulse = $('#pulse').val();
	if(pulse == ''){
		alert("Please enter pulse");
		return;
	}
	
	
	 var icdArryVal = [];
	    var diagonsisText=[];			    	
 	$("#diagnosisId").find('span').each(function() {
			
			var id = this.id;
			var value = $(this).html();
			diagonsisText.push(value+"["+id+"]");
			var diagonsisValue=id;
			var param = {
						'symptomsId' : diagonsisValue
   	                 };
			
			 icdArryVal.push(param)
			 
	});	
 	
 	for(var p=0;p<checkboxCount;p++){
 		var checkboxId = 'check'+p+'';
 		var checkSelectedCheckbox = $('#' + checkboxId).is(":checked");
 		console.log("checkSelectedCheckbox "+checkSelectedCheckbox);
 		if(checkSelectedCheckbox){
 			var symptomsText = document.getElementById(checkboxId).value;
 	 		diagonsisText.push(symptomsText);
 	 		
 	 		var index1 = symptomsText.lastIndexOf("[");
 			var index2 = symptomsText.lastIndexOf("]");
 			index1++;
 			var symptomsId = symptomsText.substring(index1, index2);
 			console.log("symptoms id is "+symptomsId);
 			var param = {
 					'symptomsId' : symptomsId
 	                };
 			icdArryVal.push(param);
 		}
 		
 	}
	
	/* var typeOfPatient = $('input[name="patientType"]:checked').val();
	var isLabourRegistered = $('input[name="reg_labour"]:checked').val();
	var isFormSubmitted = $('input[name="non_reg_labour_form"]:checked').val();
	var registrationNo = $('#regNo').val();
	var typeOfLabour = $('#labourId').val();
	var identificationTpe = $('#identificationTypeId').val();
	var identificationNo = $('#identificationNo').val();
	var religionId = $('#religionId').val();
	var districtId = $('#districtId').val();
	var cityId = $('#cityId').val();
	var address = $('#address').val();
	var pincode = $('#pincode').val();
	var bloodGroupId = $('#bloodGroupId').val(); 
	var departmentId = $('#departmentId').val();*/
	
	var params = {
			"mmuId":"<%= mmuId %>",
			"patientName":patientName,
			"mobileNo":mobileNo,
			"genderId":genderId,
			"age":age,
			"patientImage":patientImage,
			"departmentId":departmentId,
			"userId":"<%= userId %>",
			"campId":<%= campId %>,
  			'height':$('#height').val(),
  			'weight':$('#weight').val(),
  			'temperature':$('#tempature').val(),
  			'bp':$('#bp').val(),
  			'bp1':$('#bp1').val(),
  			'pulse':$('#pulse').val(),
  			'spo2':$('#spo2').val(),
  			'bmi':$('#bmi').val(),
  			'rr':$('#rr').val(),
  			'symptoms' : diagonsisText,
  			'symptomsId':icdArryVal,
  			'ageFlag':ageFlag,
  			'demo1': $('#demo').val()
  		
			
	}

	
	//$(item).attr('disabled','disabled');
	console.log("params:: "+JSON.stringify(params));
	$j(item).attr("disabled", true);
	 
	 
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : "createPatientAndMakeAppointment",
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(data) {
			//$('#tokenNo').val(data.token);
			if(data.status){
				
				alert(data.msg+'S');
			
				document.addEventListener('click',function(e){
					    if(e.target && e.target.id== 'closeBtn'){
	   	   				 	window.location.reload();
					     }
				 });	
				$j(item).attr("disabled", false);
			}else{
				
				arrListOfImg=data.listImg;
				myvar = data.match;
				$("#registrationhistory").show();
				//console.log("Test:"+arrListOfImg);
				//document.getElementById("duplicate").value = data.listImg;
				/* alert(data.msg); */
				//confirm(data.msg);
				var text = data.msg;
				
				  if (confirm(text) == true) {
					    text = "You pressed OK";
					   // alert(text);
					    document.getElementById("demo").value = text;
					    savePatientAndCreateAppointment(item);
					
					  } else {
					    text = "You canceled";
					   // alert(text);
					  }
				 
				$j(item).attr("disabled", false);
			}
			
		},
		error : function(data) {
			$j(item).attr("disabled", false);
			alert("An error has occurred while contacting the server");
		}
	}); 
}

function hideLabourDiv(){
	$('#occupationDiv').show();
	$('#labourDiv').hide();
	
}

function hideCitizenDiv(){
	$('#occupationDiv').hide();
	$('#labourDiv').show();
}



function validateImage() {
	if (document.getElementById('patientImage').value != '') {
		var allowedExtension = [ 'jpeg', 'jpg' ];
		var fileExtension = document.getElementById('patientImage').value
				.split('.').pop().toLowerCase();
		var isValidFile = false;

		for ( var index in allowedExtension) {

			if (fileExtension === allowedExtension[index]) {
				isValidFile = true;
				break;
			}
		}

		if (!isValidFile) {
			alert('Allowed Extensions are : *. '
					+ allowedExtension.join(', *.'));
			$('#patientImage').attr('value', '');

			$('.fileUploadDiv.hasFile').children('.inputUpload').val('');
			$('.fileUploadDiv.hasFile').children('.inputUploadFileName')
					.html('No File Chosen');
			$('.fileUploadDiv.hasFile').children('.inputUploadlabel').text(
					'Choose File');
			$('.fileUploadDiv.hasFile').removeClass('hasFile');

			return false;
		} else
			return true;
	}
}


function getBase64StringForIDandProfile(fileInput, idtoStore, mimeTypeId) {

	var fileInput = document.getElementById(fileInput);
	if (fileInput != null && fileInput != '') {
		var reader = new FileReader();
		if (fileInput.files[0]) {
			reader.readAsDataURL(fileInput.files[0]);
		}

		reader.onload = function() {
			imageString = reader.result;
			document.getElementById(idtoStore).value = reader.result;
			var parts = imageString.split(",");
			document.getElementById(idtoStore).value = parts[1];
			mimeType = parts[0].substring(parts[0].indexOf('/') + 1,
					parts[0].indexOf(';base64'));
			document.getElementById(mimeTypeId).value = mimeType;
			if (idtoStore == 'base64ForProfile') {
				profileImage.setAttribute('src', "data:image/" + mimeType
						+ ";base64," + parts[1]);
			}
		}
	}
}

function checkIfPatientIsAlreadyRegistered(){
	var patientName = $('#patientName').val();
	var mobileNo = $('#mobileNo').val();
	var genderId = $('#genderId').val();
	var age = $('#age').val();
	
	if(patientName.trim() == '' || mobileNo.trim() == '' || genderId == '' || age.trim() == ''){
		return;
	}
	var data = {
			"genderId":genderId,
			"patientName":patientName,
			"age":age,
			"mobileNo":mobileNo
	}
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : "checkIfPatientIsAlreadyRegistered",
		data : JSON.stringify(data),
		dataType : "json",
		cache : false,
		success : function(res) {
	     var status=res.status;
	     if(status == false){
	    	 alert(res.msg);
	    	 if(res.msg == 'Patient is already registered'){
	    		 $('#sbt_btn').attr("disabled", true);
	    	 }
	     }else{
	    	 $('#sbt_btn').attr("disabled", false);
	     }
		}
	});
}

//ADD VITAL CODE

	function checkBMI() {
		var a = document.getElementById("weight").value;
		var b = document.getElementById("height").value;
		if(a === '' || b == ''){
			return;
		}
		var c=b/100;
		var d=c*c;
		var sub = a/d;
		$('#bmi').val(parseFloat(Math.round(sub * 100) / 100).toFixed(2));
		
	}
	
    var total_icd_value = '';
    var digaoReferal='';   
    var icdValue = '';
      function populateSignAndSymptoms(val) {
      	  
          if (val == "") {
              return;
          } else {
              obj = document.getElementById('diagnosisId');
              total_icd_value += val+",";
             
              obj.length = document.getElementById('diagnosisId').length;
              var b = "false";
              for(var i=0;i<signAndSymptomsGlobalArray.length;i++){
           		  
           		  var name = signAndSymptomsGlobalArray[i].name;
           		 
           		  if(name == val){
           			icdValue = signAndSymptomsGlobalArray[i].id;
           			$("#deleteBtnDiagnosis").attr("disabled", false);
           			 $("#diagnosisId span").each(function()
                        		{
           							var text=$(this).text();
				 					var valueOrg=text.split('[')
				 					var idVal=valueOrg[0];
				 					
                        		    if(idVal == name){
                        		    alert("Signs and Symptoms is already added");
                        		    document.getElementById('icd').value = ""
                        		    b=true;
                        		    }
                        		});
           		  }
           	  }
              if (b == "false") {
              	
                  $('#diagnosisId').append('<span id=' + icdValue + '>' + val + '</span>');
                  document.getElementById('icd').value = ""

              }
          }
      }

      
      function deleteDgItems() {
      	var deleteDiagnosis = document.getElementById('diagnosisId');
         if (deleteDiagnosis.selectedIndex == -1)
      	   {
      	       alert("Please select atleast one signs and symptoms");
      	       return false;
      	   }
      	   else
      		   {
          		   if (confirm(resourceJSON.opdIcdDeleteMsg)) {

                         if (document.getElementById('diagnosisId').options[document.getElementById('diagnosisId').selectedIndex].value != null)
                             document.getElementById('diagnosisId').remove(document.getElementById('diagnosisId').selectedIndex)

                     }
      		   }
      	
          
      }
      
      $('#age').live('keypress', function(event){preventDot(event)});
      
      function preventDot(event)
      {
          alert(event.charCode)
          //var test = document.getElementById("#age");
          var key = event.charCode ? event.charCode : event.keyCode;  
          $("#age").innerHTML = key;
          if (key == 46)
          {
              event.preventDefault();
              return false;
          }    
      }
      
      function deletePatientSympotonsItems() {
    	  
    		
    	  $('#diagnosisId').find('span').each(function() { 
    		    var id = this.id;
    		    var value = $(this).html();
    		   //var classAttr = $("#patientSympotnsId > span").attr("class");
    		    // do whatever...
    		});
    	  	var deletepatient = document.getElementById('diagnosisId');
        	
           if (deletepatient.selectedIndex == -1)
        	   {
        	       alert("Please select atleast one Signs and Symptoms")
        	       return false;
        	   }
        	   else
        		   {
        		     //var psId=document.getElementById('patientSympotnsId').options[document.getElementById('patientSympotnsId').selectedIndex].value;
        		     var format = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]+/;
        		      var psIdSSCheck = $('#diagnosisId .active').attr('id');
        		      if(psIdSSCheck==undefined){
        		    	  alert("Please select atleast one Signs and Symptoms")
               	       return false;  
        		      }
        		    	  
        		     if(psIdSSCheck!=''&&psIdSSCheck!=undefined)
        		     {  
            		   if (confirm(resourceJSON.opdIcdDeleteMsg)) {
            			  // $("#multiDiv").find(".active").remove();
            			   var psId = $('#diagnosisId .active').attr('id');
            			   var value=$('span.active');
                          if (!format.test(psId) )
                        	   {
                        	  		$('span.active').remove();
                        	  			
                        	   }

    		        		   /* else
    		        			  {
    		        			 
    		        			   var pathname = window.location.pathname;
    		        				var accessGroup = "MMUWeb";
    		        				var urldeleteGridRow = window.location.protocol + "//"+ window.location.host + "/" + accessGroup+ "/opd/deletePatientSymptom";
    		
    		        				var data = {
    		        					"visitId" : $('#visitId').val(),
    		        					"symptomId" : psId
    		        				};
    		        				$.ajax({
    		        					type : "POST",
    		        					contentType : "application/json",
    		        					url : urldeleteGridRow,
    		        					data : JSON.stringify(data),
    		        					dataType : "json",
    		        					cache : false,
    		        					success : function(res) {
    		        				     var datass=res.msg;
    		        				     if(datass=="recordsDeleted")
    		        				    	{
    		        				    	 $('span.active').remove();
    		        				    	} 
    		        					}
    		        				});
    		
    		        			  }  */
            		   }
        		    }
        		    if($('#diagnosisId').length==0)
         	  		{
         	  			$("#deleteBtnDiagnosis").attr("disabled", true);
         	  		}
        		   }
            
        }

      
      function lettersNumbersCheck(name)
      {
      var regEx = /^[0-9]+$/;
      if(name.match(regEx))
      {
      alert("Please enter letters and numbers only.");
      return false;
      }
      else
      {
       
      return true;
      }
      }  
      
      function showPatientPopUp(){
    	  
				    
    				   var photVal='';
    				 //  var prevPic='';
    				   var countNo = 1;
    				   for (var i = 0; i < arrListOfImg.length; i++) {
    						 //  prevPic.setAttribute('src', "data:image/png;base64,"+arrListOfImg[i].patientImage);
    						   photVal += '<tr>';
    						
    						   photVal += '<td>' + countNo + '</td>';
    						
    						
    						   photVal += '</td>';
    						photVal += '<td>';
    						photVal += '<span>' + arrListOfImg[i].patientName + '</span>';
    						//photVal += '<input type="text"  name="itemId" value="' + arrListOfImg[i].patientName + '" id="nomenclatureId" readonly="true" />';
    						photVal += '</td>';
    						
    						photVal += '<td class="width90">';
    						/* photVal += '  <img src="/MMUWeb/resources/images/photo_icon.png" id="prevPic" alt=""  />'; */
    						// photVal += '<img src="data:image/png;base64,"' +arrListOfImg[i].patientImage + '" alt="" />';
    						 photVal += '<img src="'+arrListOfImg[i].patientImage +'" class="profileImg"  width="80%"/>';
    						photVal += '</td>';
    						photVal += '<td>';
    						photVal += '<span>' + arrListOfImg[i].regDate + '</span>';
    						
    						//photVal += '<input type="text"  name="itemId" value="' +arrListOfImg[i].regDate + '" id="nomenclatureId" readonly="true" />';
    						photVal += '</td>';
    					//	photVal += '<td><input type="checkBox" name="repeatCheck" id="repeatCheck'+arrListOfImg[i].regDate+'" value="1"';
    						photVal += 'tabindex="1"></td>';
    					
    						photVal += '</tr>';
    						countNo++;
    					}
    				
    				$("#modelForPatientGrid").html(photVal);
    				$("#modelForPatient").show();
    				$(".modal-backdrop").show();
    			
    		
    	}

      function closeDoctorRemarks(){
      //	$('#modelForPatientGrid').hide();
      //	$('.modal-backdrop').hide();
      	$("#modelForPatient").hide();
		$(".modal-backdrop").hide();
      	document.getElementById("additionalNote").focus();
      	}


      function showPhoto(profileImg1,inTimeImg,outTimeImg){
    		 if(profileImg1 != '' && profileImg1.length > 100){
    		  profileImage.setAttribute('src', "data:image/jpg;base64," +profileImg1);
    		 }
    		 if(inTimeImg != ''){
    		 inTimeImage.setAttribute('src', "data:image/jpg;base64," +inTimeImg);
    		 }
    		 if(outTimeImg != ''){
    		 outTimeImage.setAttribute('src', "data:image/jpg;base64," +outTimeImg);
    		 }
    		 
    	 }
</script>

    <style type="text/css">

canvas {
  display: block;
}
    
    </style>
    
     <style>
    /* CSS comes here */
    #video {
        width: 196px;
        height: 150px;
        border: solid 5px #fff;
    }

    #photo {
        width: 196px;
        height: 150px;
        border: solid 5px #fff;
    	box-shadow: 0px 0px 5px rgb(0 0 0 / 40%);
    }

    #canvas {
        display: none;
    }

    .camera {
        width: 196px;
        display: inline-block;
    }

    .output {
        width: 200px;
        display: inline-block;
    }

    #startbutton {
        margin-left:10px;
    }
    .contentarea {
        margin-top: -150px;
    }
    </style>
</head>


<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">Registration &amp; Appointment of
					Patient</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<h6 class="font-weight-bold text-theme text-underline">Patient
									Details</h6>
								<div class="row">
								
									<div class="col-lg-4 col-sm-6">
										<div class="row">
											<div class="col-12">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Patient Name</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="patientName" onblur="checkIfPatientIsAlreadyRegistered()"   class="form-control" />
											<input type="hidden" id="demo" value=""/>
											</div>
										</div>
									</div>

									<div class="col-12">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Mobile No.</label>
											</div>
											<div class="col-md-7">
												<input name="mobileNo" id="mobileNo" type="text" maxlength="10"
															class="form-control border-input" onblur="checkIfPatientIsAlreadyRegistered()"
															placeholder="" value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" required>
											</div>
										</div>
									</div>

									<div class="col-12">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Gender</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="genderId" onchange="checkIfPatientIsAlreadyRegistered()">

												</select>
											</div>
										</div>
									</div>
									
									<div class="col-12">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Age</label>
											</div>
											<div class="col-md-3">
												<input type="text" id="age" maxlength="2" class="form-control" onblur="checkIfPatientIsAlreadyRegistered()" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" onkeydown="if(event.key==='.'){event.preventDefault();}"  oninput="event.target.value = event.target.value.replace(/[^0-9]*/g,'');">
												
											</div>
											<div class="col-md-4">
												<select class="form-control" id="ageId">
													<option value="Y">Yrs</option>
													<option value="M">Mths</option>
													<option value="D">Days</option>
												</select>
											</div>
										</div>
									</div>
										</div>
									</div>
									
									
									<div class="col-sm-4">
										<div class="row">
											<div class="form-group row">
											<div class="col-sm-11 offset-sm-1">
												<!-- <img src="/MMUWeb/resources/images/photo_icon.png" class="profileImg" alt="" width="80%" id="profileImage" /> -->
												<div class="output">
										            <img id="photo" alt="The screen capture will appear in this box.">
										              <input type="hidden" id="patientImage" name="patientImage"></input>
										        </div>
										        <div class="contentarea">    
										        <div class="camera" id="videoCont">
											           <video id="video" >Video stream not available.</video> 
											           
											        </div>
											    
											    <div class="row">
											    	<div class="col-sm-12">
												    	<label class="col-form-label">Profile Image<span class="mandate"><sup>&#9733;</sup></span></label>
												    </div>
												    <div class="col-sm1-2">
												    	<button class="btn btn-primary" id="startbutton">Take photo</button>												   
												    	<button class="btn btn-primary" id="clearbutton">Clear photo</button>
												    	 
												    </div>
												    
											    </div>
											    
											    
											     
											    <canvas id="canvas"></canvas>
											      
											        <!--  <div><button id="clearbutton">clear photo</button></div> -->
											        
											       <!--  <div class="output">
											            <img id="photo" alt="The screen capture will appear in this box.">
											        </div> -->
											    </div>
											</div>
									
							        	</div>
										
										</div>
									</div>
									 

							<div class="col-lg-3 col-sm-4 offset-sm-4 offset-lg-0 m-t-sm-10">
								
					
  
							</div>

									

                              

								</div>
								<hr>

								<h6 class="font-weight-bold text-theme text-underline">Camp
									Details</h6>
								<div class="row">
									<div class="col-lg-5 col-sm-6">
										<div class="form-group row">
											<div class="col-md-4">
												<label class="col-form-label">Camp Location</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="camp_location" readonly />
											</div>
										</div>
									</div>

									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Department</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="departmentId">
												</select>
											</div>
										</div>
									</div>
								</div>
								<hr>

								<div class="row disablecopypasteDiv">
									<div class="col-12">
										<h6 class="font-weight-bold text-theme text-underline">Vital Details</h6>
									</div>
									
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">

											<label class="col-md-5 col-form-label">Patient Height<span class="mandate"><sup>&#9733;</sup></span></label>

											<div class="col-md-7">
												<!--  <input name="height" id="height" onblur="idealWeight();checkBMI();" maxlength="3"
											type="text" class="form-control border-input" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
											placeholder="Height" value="" required /> -->

												<div class="input-group mb-2 mr-sm-2">
													<input name="height" id="height" onblur="checkBMI();"
														maxlength="3" type="text"
														class="form-control border-input"
														onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
														placeholder="Height" value="" required />
													<div class="input-group-append">
														<div class="input-group-text">cm</div>
													</div>

												</div>
											</div>

										</div>
									</div>

									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">

											<label class="col-lg-5 col-sm-4 col-form-label">Weight<span class="mandate"><sup>&#9733;</sup></span></label>

											<div class="col-lg-7 col-sm-8">
												<!--  <input name="Weight" id="weight" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
											type="text" class="form-control border-input" onblur="checkVaration();checkBMI();" maxlength="3"
											placeholder="Weight" /> -->
												<div class="input-group mb-2 mr-sm-2">
													<input name="Weight" id="weight"
														onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
														type="text" class="form-control border-input"
														onblur="checkBMI();" maxlength="5" placeholder="Weight" />
													<div class="input-group-append">
														<div class="input-group-text">kg</div>
													</div>

												</div>
											</div>
										</div>
									</div>

									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">

											<label class="col-md-5 col-form-label">Temperature<span class="mandate"><sup>&#9733;</sup></span></label>

											<div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input name="tempature" id="tempature" type="text" maxlength="8"
															class="form-control border-input"
															placeholder="Temperature" value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" required>
														    <div class="input-group-append">
														      <div class="input-group-text">&deg;F</div>
														    </div>
														    
														  </div>
													</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">

											<label class="col-md-3 col-form-label">BP<span class="mandate"><sup>&#9733;</sup></span></label>

											<!-- <div class="col-md-3">
	                                                                                    <input name="bp" id="bp" type="text" maxlength="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																								class="form-control border-input" placeholder="Systolic" value=""
																								required> 
	                                                                                </div>
	                                                                                 
	                                                                                <div class="col-md-1">  
	                                                                                /
                                                                                    </div>
	                                                                                
		                                                                              <div class="col-md-3">
	                                                                                    <input name="bp1" id="bp1" type="text" maxlength="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																								class="form-control border-input" placeholder="Diastolic" value=""
																								required>
																								  
	                                                                                  </div> -->

											<div class="col-md-3 offset-md-1">

												<input name="bp" id="bp" type="text" maxlength="3"
													onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
													class="form-control bpSlash border-input"
													placeholder="Systolic" value="" required> <span></span>
												<!-- slash for bp -->

											</div>
											<div class="col-md-5">
												<div class="input-group mb-2 mr-sm-2">
													<input name="bp1" id="bp1" type="text" maxlength="3"
														onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
														class="form-control border-input bmiInput"
														placeholder="Diastolic" value="" required>
													<div class="input-group-append">
														<div class="input-group-text">mmHg</div>
													</div>
												</div>
											</div>











										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">

											<label class="col-md-5 col-form-label">Pulse<span class="mandate"><sup>&#9733;</sup></span></label>

											<div class="col-md-7">
												<!-- <input name="pulse" id="pulse"
											type="text" class="form-control border-input" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
											placeholder="Pulse" value="" maxlength="8" /> -->

												<div class="input-group mb-2 mr-sm-2">
													<input name="pulse" id="pulse" type="text"
														class="form-control border-input"
														onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
														placeholder="Pulse" value="" maxlength="8" />
													<div class="input-group-append">
														<div class="input-group-text">/min</div>
													</div>

												</div>
											</div>
										</div>
									</div>





									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">

											<label class="col-lg-5 col-sm-4 col-form-label">SpO2</label>

											<div class="col-lg-7 col-sm-8">
												<!-- <input name="spo2" id="spo2" type="text"
											class="form-control border-input" placeholder="SpO2" value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
											maxlength="30"> -->
												<div class="input-group mb-2 mr-sm-2">
													<input name="spo2" id="spo2" type="text"
														class="form-control border-input" placeholder="SpO2"
														value=""
														onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
														maxlength="30">
													<div class="input-group-append">
														<div class="input-group-text">%</div>
													</div>

												</div>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">

											<label class="col-md-5 col-form-label">BMI</label>

											<div class="col-md-7">
												<!-- <input name="bmi" id="bmi" type="text"
											class="form-control border-input" placeholder="BMI" value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
											readonly > -->
												<div class="input-group mb-2 mr-sm-2">
													<input name="bmi" id="bmi" type="text"
														class="form-control border-input" placeholder="BMI"
														value=""
														onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
														readonly>
													<div class="input-group-append">
														<div class="input-group-text">kg/m2</div>
													</div>

												</div>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">

											<label class="col-lg-5 col-sm-4 col-form-label">RR</label>

											<div class="col-lg-7 col-sm-8">
												<!--  <input name="rr" id="rr" type="text"
											class="form-control border-input" placeholder="RR" value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
											maxlength="3"> -->

												<div class="input-group mb-2 mr-sm-2">
													<input name="rr" id="rr" type="text"
														class="form-control border-input" placeholder="RR"
														value=""
														onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
														maxlength="3">
													<div class="input-group-append">
														<div class="input-group-text">/min</div>
													</div>

												</div>
											</div>
										</div>
									</div>



									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">



											<div class="col-md-6">
												<input type="hidden" id="patientId" name="PatientID12"
													value="">
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">


											<div class="col-md-5">
												<input type="hidden" id="visitId" name="VisitID" value="">
											</div>
											<div class="col-md-7">
												<input type="hidden" id="genderId" name="genderId" value="">
											</div>
										</div>
									</div>



									<!-- <div class="col-md-12 text-right">
                                                                            
                                                                            
                                                                            <button type="button" id="saveBtn" class="btn btn-primary"
																				  onclick="saveAddvitalDetails()">Submit</button>
																			 
                                                                           
																			<button type="button" class="btn btn-primary m-l-10"
																				  onclick="goBack()">Close</button>
                                                                              
                                                                        </div> -->




								</div>
								 
								<hr>
								
								<h6 class="font-weight-bold text-theme text-underline">Sign and Symptoms</h6>
								<div id="checkbox_div"> 
								
								</div>
								
								
									
			 <div class="m-t-20" id="newpost7"  style="display:block;"">
									      
									      	<div class="row">
											<div class="col-lg-4 col-sm-6">
												<div class="form-group row  autocomplete">

													<label class="col-md-5 col-form-label">Patient signs & symptoms</label>
													<div class="col-md-7">
															<div class="autocomplete forTableResp">
															<input type="text" autocomplete="never" class="form-control border-input" name="pvmsNumber" id="icd" onKeyUp="getNomenClatureList(this,'populateSignAndSymptoms','registration','getAllSymptoms','signAndSymptoms');"/>
															<div id="divPvms1" class="autocomplete-itemsNew"></div>
													</div>

												</div>
											</div>
											</div>

											<div class="col-lg-4 col-sm-6">
												<!-- <select name="diagnosisId" multiple="4" value="" size="5"
													tabindex="1" id="diagnosisId" class="listBig width-full disablecopypaste"
													validate="ICD Daignosis,string,yes">
												</select> -->
												
												<div class="multiDiv" id="diagnosisId">
												</div>
											</div>
											<div class="col-md-4">
												<button type="button" class="buttonDel btn  btn-danger"
													value="" id="deleteBtnDiagnosis" onclick="deletePatientSympotonsItems();"
													align="right" />
												Delete
												</button>
												
											</div>

										</div>
									      
												 
										</div>
									
								</form>
										
								<div class="row m-t-10">
									<div class="col-12 text-right">
										<button type="button" class="btn btn-primary" id="sbt_btn"
											onclick="savePatientAndCreateAppointment(this)">Submit</button>
										<!-- <button type="button" class="btn btn-primary" id="closeBtn">Close</button> -->
									</div>
									 
								</div>
								
								 <%-- <c:if test = "${myvar.equals('Match')}">  --%>
									<!-- <div class="row m-t-8">
									<div class="col-12 text-right">
															  <a href="javascript:void(0)" class="btn btn-primary"  onclick="showPatientPopUp();" id="registrationhistory">Registration History</a></li>
													          <input type="hidden" id="duplicate" value="" >																
												
													</div></div> -->
										<%-- </c:if>	 --%>
								
												
								<div>  
 
							</div>
						</div>


					</div>
				</div>

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
<div class="modal" id="modelForPatient"  role="dialog">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext">Registration History</span>

					<button type="button" onClick="closeDoctorRemarks();" class="close"
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
											<td class="SearchStatusForUnitAdminCurrentMedication" style="font-size: 15px;"
												align="left"></td>
											<td>
											</td>
										</tr>
									</table>
						
								</div>
							<!-- <div style="float: right">
									<div id="resultnavigationForDoctorRemarks"></div>
								</div>	 -->		
								
						
						<div class="table-responsive">
						<div class="scrollableDiv m-b-10">
							<table class="table table-bordered m-t-10" align="center"
								cellpadding="0" cellspacing="0">
								<tr>
								<th>SNo.</th>
								<th>Patient Name</th>
								<th>Photo</th>
								<th>Registration Date</th>

								</tr>
								<tbody id="modelForPatientGrid">
								</tbody>
							</table>
						</div>
                       </div>



					</div>
				</div>
				<div class="modal-footer">
					
					<button class="btn btn-primary" data-dismiss="modal"
						onClick="closeDoctorRemarks();" aria-hidden="true">Close</button>
				</div>
			</div>
		</div>
	</div>
	<!-- jQuery  -->

  <script>
    /* JS comes here */
    (function() {

        var width = 200; // We will scale the photo width to this
        var height = 150; // This will be computed based on the input stream

        var streaming = false;

        var video = null;
        var canvas = null;
        var photo = null;
        var startbutton = null;

        function startup() {
            video = document.getElementById('video');
            canvas = document.getElementById('canvas');
            photo = document.getElementById('photo');
            startbutton = document.getElementById('startbutton');

            navigator.mediaDevices.getUserMedia({
                    video: true,
                    audio: false
                })
                .then(function(stream) {
                    video.srcObject = stream;
                    video.play();
                })
                .catch(function(err) {
                    console.log("An error occurred: " + err);
                });

            video.addEventListener('canplay', function(ev) {
                if (!streaming) {
                    //height = video.videoHeight / (video.videoWidth / width);

                    if (isNaN(height)) {
                        height = width / (4 / 3);
                    }

                    video.setAttribute('width', width);
                    video.setAttribute('height', height);
                    canvas.setAttribute('width', width);
                    canvas.setAttribute('height', height);
                    streaming = true;
                }
            }, false);

            startbutton.addEventListener('click', function(ev) {
                takepicture();
                ev.preventDefault();
                //clearbutton.disabled = false;
            }, false);

            clearphoto();
        }


        function clearphoto() {
        	clearbutton = document.getElementById('clearbutton');
        	var videoCont = document.getElementById("videoCont");
            videoCont.style.visibility = "visible";
            var context = canvas.getContext('2d');
            context.fillStyle = "#AAA";
            context.fillRect(0, 0, canvas.width, canvas.height);

            var data = canvas.toDataURL('image/png');
            photo.setAttribute('src', data);
            clearbutton.addEventListener('click', function(ev) {
            	clearphoto();
                ev.preventDefault();
            }, false);
            //document.getElementById("clearbutton").onclick = function() {
                //disable
               // this.disabled = true;
          //  }
           // document.getElementById("patientImage").value = data;
            console.log('clean: '+data);
        }

        function takepicture() {
            var context = canvas.getContext('2d');
            var videoCont = document.getElementById("videoCont");
            videoCont.style.visibility = "hidden";
            if (width && height) {
                canvas.width = width;
                canvas.height = height;
                context.drawImage(video, 0, 0, width, height);

                var data = canvas.toDataURL('image/png');
                console.log('Take photo : '+data);
                document.getElementById("patientImage").value = data;
                photo.setAttribute('src', data);
            
            } else {
                clearphoto();
            }
        }

        window.addEventListener('load', startup, false);
    })();
    </script>
    
    
<!-- JavaScript to provide the "Show/Close" functionality -->  
<script type="text/JavaScript">  
(function() {    
    var dialog = document.getElementById('myFirstDialog');    
    document.getElementById('show').onclick = function() {    
        dialog.show();    
    };    
    document.getElementById('hide').onclick = function() {    
        dialog.close();    
    };    
})();   
</script>  

<script>
	function showDuplicateImage() {
        
		var patientIds = new Array();
		var Patient = new Array();
		 patientIds= $('#duplicate').val();
		  let valuesArray = Object.values($('#duplicate').val());
		 // alert(valuesArray);
		 Patient =$('#duplicate').val();
		/*  const person = {
    firstName: 'John',
    lastName: 'Doe'
}; */
const person = {
	    firstName: 'John',
	    lastName: 'Doe'
	};
		for(var i=0;i<arrListOfImg.length;i++){
		  
		  var patientImage = arrListOfImg[i].patientImage;
		 
		  }
		 const propertyNames = Object.keys(valuesArray);
		 const propertyValues = Object.values(valuesArray);
		//const sampleArray =$('#duplicate').val();
		//alert( JSON.stringify(($('#duplicate').val())));
		var peson = JSON.stringify(($('#duplicate').val()));
		/* let txt = "";
		for (var key in peson) {
			  //console.log(key);
			  //alert(key[8]);
			  txt += peson[key] + " ";
			//  alert(txt);
			}
		document.getElementById("demo").innerHTML = txt; */
	//	console.log(demo);
		//alert(propertyNames);
		//alert(propertyValues);
		/* const array =$('#duplicate').val();
		console.log("log:"+array);
		for(var key in array){
		    //if(states.hasOwnProperty(key)){
		    	console.log("log1:"+array[key].patientName);
		       // citiesMiles.push(new CityMiles(key, states[key]));
		  //  } 
		} */
		//document.getElementById("patientIds").value = array;
		//alert(array);
		if(patientIds == ""){
           alert("No Match Found");
           return;
			}
		else{
					var popup;
		 popup = window.open("showDuplicateHistory?propertyNames="+propertyNames+"&propertyValues="+propertyValues+"", "popUpWindow", "height=500,width=800,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
                popup.focus();
		}
		
		  
			 
}


	$(document).on('click','#exampleModal button[data-dismiss="modal"],#exampleModal input[data-dismiss="modal"]',function(){
		closeModal();
	});

	function closeModal(){
		 $('#exampleModal').hide();
		 var loaderDiv = '<div class="text-center text-theme text-sm"> Loading <i class="fa fa-spin fa-spinner"></i> </div>';
		 $('#exampleModal .modal-body').html(loaderDiv);
		 $('.modal-backdrop').hide();
	}
		
	</script>
</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
