<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Appointment of Patient</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/simplepeer.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/socket.io.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/p5.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/p5.sound.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/p5livemedia.js"></script>
	
<style>
#tableId tr:hover {
	cursor: pointer;
}
</style>
<script type="text/javascript">

var nPageNo=1;
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
		campLocation = campLocation.replaceAll("[\\n\\t ]", " ");
	}
	
	String campOrOff = "";
	if (session.getAttribute("campOrOff") != null) {
		campOrOff = session.getAttribute("campOrOff") + "";
	}
%>

nPageNo=1;
var signAndSymptomsGlobalArray = [];
var $j = jQuery.noConflict();
var globalWardId = '';
var globalLocation = '';
var wardGlobalJson = '';
var myvar ='';
var arrListOfImg = new Array();
	$j(document).ready(function()
	{
		$("#deleteBtnDiagnosis").attr("disabled", true);
		var campOrOff = "<%= campOrOff %>";
		if(campOrOff != 'Camp'){
			alert("Camp is not configured");
			return;
		}
		var cityLocation = "<%= cityName %>";
		var campLocation = "<%= campLocation %>";
		var campLoation = cityLocation +" - "+campLocation;
		if(campLoation.trim() != "-"){
			$('#camp_location').val(cityLocation +" - "+campLocation);
			globalLocation = cityLocation +" - "+campLocation;
		}
		
		getDistrictList();
		getBloodGroupList();
		//getReligionList();
		getGenderList();
		getIdentificationTypeList();
		getLabourTypeList();
		getDepartmentList();
		getWardList();
		$('#mobileNo').focus();
		getCityList();
		getRelationList();
		getFrequentlyUsedSymptomsList();

		$('#checkbox_div').hide();
		//$('#table_div').hide();
		var htmlTable = htmlTable + "<tr ><td colspan='7'><h6>No Record Found !!</h6></td></tr>";
		$('#tableId').html(htmlTable);
		//$('#department_div').hide();
		var departmentId = "<%=departmentId%>";
		var departmentName = "<%=departmentName%>";
		var departmentDrop = "<option value="+departmentId+" selected>"+departmentName+"</option>";
		$('#departmentId').append(departmentDrop);
	
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
						checkboxHTML += "<label class='col-form-label' for='check"+i+"'>"+list[i].name+"</label>";
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
	
	var globalPatientListInfo = '';
	var appointradioGlo="";
	function searchPatient(){
		  appointradioGlo = $("input[name='appointradio']:checked").val()
		
		var mobileNo = $('#mobileNo').val();
		var patientName = $('#patientName').val();
		var uhidNo = $('#uhidNo').val();
		var appointmentDate = $('#from_date').val();
		if(mobileNo!="")
		mobileNoGol=mobileNo;
		if(patientName!="")
		patientNameGlo=patientName;
		if(uhidNo!="")
		uhidGlo=uhidNo;
		if(appointmentDate!="")
		appoinmentDateGlo=appointmentDate;

		$('#formId').trigger("reset");
	
		getUpdateRadio();
	if(mobileNoGol!="")
		mobileNo=mobileNoGol;
		if(patientNameGlo!="")
		patientName=patientNameGlo;
		if(uhidGlo!="")
		uhidNo=uhidGlo;
		if(appoinmentDateGlo!="")
		appointmentDate=appoinmentDateGlo;

		
		if(mobileNo!="")
			$('#mobileNo').val(mobileNo);
			if(patientName!="")
			$('#patientName').val(patientName);
			if(uhidNo!="")
			$('#uhidNo').val(uhidNo);
			if(appointmentDate!="")
			$('#from_date').val(appointmentDate);
			
		
		if(mobileNo == '' && patientName == '' && uhidNo == '' && appointmentDate == ''){
			alert("Please enter search detail");
			return;
		}
		var params = {
				"mobileNo":mobileNo,
				"patientName":patientName,
				"uhidNo":uhidNo,
				"appointmentDate":appointmentDate,
				"pageNo":nPageNo
		}
		
		//var data = {"pageNo":nPageNo}
		var bClickable = true;
	 	var url = "getPatientList";
	 	GetJsonData('tableId',params,url,bClickable);
	 	
	}
	
	function getUpdateRadio(){
		if(appointradioGlo=='update'){
			$("#info_update").prop("checked", true);
		}
		else{
			$("#appoint").prop("checked", true);
		}
		

	}
	
	function makeTable(data)
	{
				$('#tableId').empty();
					globalPatientListInfo = data.list;
					var dataList = data.list;
					globalPatientListInfoImg = data.ServerImageUrl;
					console.log("IMG URL:"+globalPatientListInfoImg);
					var htmlTable = '';
						for (i = 0; i < dataList.length; i++) {
							var count = i+1;
							htmlTable = htmlTable + "<tr id='"+dataList[i].patientId+"'>";
							//htmlTable = htmlTable + "<td style='width: 100px;'>"+ count + "</td>";
							htmlTable = htmlTable + "<td style='width: 100px;'>"+ dataList[i].patientName + "</td>";
							htmlTable = htmlTable + "<td style='width: 100px;'>"+ dataList[i].mobileNo + "</td>";
							htmlTable = htmlTable + "<td style='width: 150px;'>"+ dataList[i].uhidNo + "</td>";
							htmlTable = htmlTable + "<td style='width: 100px;'>"+ dataList[i].age + "</td>";
							htmlTable = htmlTable + "<td style='width: 100px;'>"+ dataList[i].genderName + "</td>";
							
							if(dataList[i].patientType == 'L'){
								htmlTable = htmlTable + "<td style='width: 100px;'>Labour</td>";
							}else if(dataList[i].patientType == 'G'){
								htmlTable = htmlTable + "<td style='width: 100px;'>General Citizen</td>";
							}else{
								htmlTable = htmlTable + "<td style='width: 100px;'></td>";
							}
							
						
							htmlTable = htmlTable + "</tr>";
						}

						if (dataList.length == 0) {
							htmlTable = htmlTable
									+ "<tr ><td colspan='6'><h6>No Record Found !!</h6></td></tr>";
						}

					$('#tableId').append(htmlTable);
		}
	
	var selectedPatientId = '';
 var mobileNoGol="";
 var patientNameGlo="";
 var uhidGlo="";
 var appoinmentDateGlo="";
	
	function executeClickEvent(Id) {	
	
	var updateOrAppointFlag = $('input[name="appointradio"]:checked').val();
	
	mobileNoGol=$('#mobileNo').val();
	patientNameGlo=$('#patientName').val();
	uhidGlo=$('#uhidNo').val();
	appoinmentDateGlo=$('#from_date').val();
	
	$('#formId').trigger("reset");	
	getUpdateRadio();
	$('#mobileNo').val(mobileNoGol);
	$('#patientName').val(patientNameGlo);
	$('#uhidNo').val(uhidGlo);
	$('#from_date').val(appoinmentDateGlo);
	
	$("input[name=appointradio][value=" + updateOrAppointFlag + "]").prop('checked', true);
	$('#camp_location').val(globalLocation);
	var patientId = Id;
	for(i=0;i<globalPatientListInfo.length;i++){
		var patientIdd = globalPatientListInfo[i].patientId;
		if(patientId == patientIdd){
			selectedPatientId = patientIdd;
			$('#patientName2').val(globalPatientListInfo[i].patientName);
			$('#mobileNo2').val(globalPatientListInfo[i].mobileNo);
			$('#genderId').val(globalPatientListInfo[i].genderId);
			$('#patientIdNew').val(Id);
			//Rohit
			//$('#patientImage').val(globalPatientListInfo[i].patientImage);
			console.log("json "+JSON.stringify(globalPatientListInfo[i].patientImage));
			  if (globalPatientListInfo[i].patientImage != null ) {
				 prevPic.setAttribute('src', "data:image/png;base64,"+globalPatientListInfo[i].patientImage);
				 $('#patientImage').val(globalPatientListInfo[i].patientImage);
             }  else {
            	 prevPic.setAttribute('src', "/MMUWeb/resources/images/no-photo.jpg");
            	 $('#patientImage').val(globalPatientListInfo[i].patientImage);
             }  
			var ageVal = globalPatientListInfo[i].age.split(" ");
			$('#age').val(ageVal[0]);
			$('#ageId').val(ageVal[1]);
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
			globalWardIdd = globalPatientListInfo[i].wardId;
			$('#wardId').val(globalPatientListInfo[i].wardName);
			
			$('#castId').val(globalPatientListInfo[i].castId);
			$('#relationId').val(globalPatientListInfo[i].relationId);
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

function showResultPage(pageNo) {

	
	
	if(mobileNoGol!="")
	$('#mobileNo').val(mobileNoGol);
	if(patientNameGlo!="")
	$('#patientName').val(patientNameGlo);
	if(uhidGlo!="")
	$('#uhidNo').val(uhidGlo);
	if(appoinmentDateGlo!="")
	$('#from_date').val(appoinmentDateGlo);
	nPageNo = pageNo;
	searchPatient();

}

function setPatientDetails(item){
	
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
		alert("dfss");â
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
	
/* function getReligionList(){
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
} */

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
$("#registrationhistory").hide();
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


function getDepartmentList(){
var params = {
		"mmuId":"<%=mmuId%>"
		}

		$
				.ajax({
					type : "POST",
					contentType : "application/json",
					url : 'getMMUDepartment',
					data : JSON.stringify(params),
					dataType : "json",
					cache : false,
					success : function(data) {
						if (data.status == true) {
							var list = data.list;
							var dropDrop = '<option value="">Select</option>';
							for (i = 0; i < list.length; i++) {
								if (i == 0) {
									dropDrop += '<option value='+list[i].departmentId+'>'
											+ list[i].departmentName
											+ '</option>';
								} else {
									dropDrop += '<option value='+list[i].departmentId+'>'
											+ list[i].departmentName
											+ '</option>';
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
	
function hideLabourDiv(){
	$('#occupationDiv').show();
	$('#labourDiv').hide();
	$('#relationId').val('');
	
	
}

function hideCitizenDiv(){
	$('#occupationDiv').hide();
	$('#labourDiv').show();
	$('#relationId').val('');
}

function updatePatientDetailAndMakeAppoint(item){
	var updateOrAppointFlag = $('input[name="appointradio"]:checked').val();
	if(updateOrAppointFlag == undefined){
		alert("Please select Update Information or Appointment")
		return
	}
	if(selectedPatientId == ''){
		alert("Please select patient");
		return; 
	}
	var demo1 ="";
	var patientName2 = $('#patientName2').val();
	var gender = $('#genderId').val();
	var age = $('#age').val();
	var ageId = $('#ageId').val();
	//var patientImage = globalPatientListInfo[0].patientImage;
	var patientImage = $('#patientImage').val();
	console.log("new img"+patientImage);
	var mobieNo2 =  $('#mobileNo2').val();
 	/*  if(patientImage == ""){
		alert("Please take patient photo");
		return;
	}   */
	if(gender == ''){
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
	
		var typeOfPatient = $('input[name="patientType"]:checked').val(); 
		if(typeOfPatient == undefined){
			typeOfPatient = '';
		}
		var occupation = '';
		if(typeOfPatient == 'G'){
			occupation = $('#occupation').val();
			/* if(occupation == ''){
				alert("Please enter occupation");
				return;
			} */
		}
		var registrationNo = '';
		var isLabourRegistered = '';
		var typeOfLabour = '';
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
			}
			
			var typeOfLabour = $('#labourId').val();
			/* if(typeOfLabour == ''){
				alert("Please select type of labour");
				return;
			} */
		}
		var isFormSubmitted = '';
		if(isLabourRegistered == 'N'){
			isFormSubmitted = $('input[name="non_reg_labour_form"]:checked').val();
			if(isFormSubmitted == undefined || isFormSubmitted == ''){
				isFormSubmitted = '';
			}
		}
		
		var identificationTpe = $('#identificationTypeId').val();
		if(identificationTpe == ''){
			identificationTpe = '';
		}
		var identificationNo = $('#identificationNo').val();
		/* if(identificationNo == ''){
			alert("Please enter Identification No.");
			return;
		} */
		var wardId = globalWardIdd;
		var districtId = $('#districtId').val();
		/* if(districtId == ''){
			alert("Please select district");
			return;
		} */
		var cityId = $('#cityId').val();
		/* if(cityId == ''){
			alert("Please select city");
			return;
		} */
		var address = $('#address').val();
		/* if(address == ''){
			alert("Please enter address");
			return;
		} */
		var pincode = $('#pincode').val();
		if(pincode != '' && pincode.trim().length <6){
			alert("Please enter valid pincode");
			return;
		}
		var bloodGroupId = $('#bloodGroupId').val(); 
		var departmentId = $('#departmentId').val();
		var castId = $('#castId').val();
		var relationId = $('#relationId').val();
		if(updateOrAppointFlag == 'appointment'){
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
			
			var agee = $('#age').val();
			var ageFlag = $('#ageId').val();
			
			if(agee >12 && ageFlag == 'Yrs'){
				
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
			
			var pulse = $('#pulse').val();
			if(pulse == ''){
				alert("Please enter pulse");
				return;
			}
			
		}
		
		 var icdArryVal = [];
		    var diagonsisText=[];			    	
	 	$("#diagnosisId").find('span').each(
			function() {
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

	
	var params = {
			"patientName":patientName2,
			"age":age,
			"ageId":ageId,
			"gender":gender,
			"patientImage":patientImage,
			"mobieNo":mobieNo2,
			"patientType":typeOfPatient,
			"occupation":occupation,
			"isLabourRegistered":isLabourRegistered,
			"isFormSubmitted":isFormSubmitted,
			"registrationNo":registrationNo,
			"relationId":relationId,
			"labourId":typeOfLabour,
			"identificationTypeId":identificationTpe,
			"identificationNo":identificationNo,
			"wardId":wardId,
			"castId":castId,
			"districtId":districtId,
			"cityId":cityId,
			"address":address,
			"pincode":pincode,
			"bloodGroupId":bloodGroupId,
			"departmentId":departmentId,
			"patientId":selectedPatientId,
			"updateOrAppointFlag":updateOrAppointFlag,
			"campId":<%=campId%>,
			"mmuId":<%=mmuId%>,
			"userId": <%=userId%>,
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
  			'demo1': $('#demo').val()
	}
	$j(item).attr("disabled", true);
	console.log("json "+JSON.stringify(params));
	 $.ajax({
		type : "POST",
		contentType : "application/json",
		url : "updatePatientInformationOrMakeAppointment",
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(data) {
			if(data.status == true){
				alert(data.msg+'S');
				document.addEventListener('click',function(e){
					    if(e.target && e.target.id== 'closeBtn'){
	   	   				 	window.location.reload();
					     }
				 });	
				$('#from_date').val('');
				$j(item).attr("disabled", false);
				//$j('formId').trigger("reset");
				$('input,textarea').attr('autocomplete', 'off');
			}else{
				arrListOfImg=data.listImg;
				myvar = data.match;
				$("#registrationhistory").show();
			//	alert(data.msg);
                 var text = data.msg;
				
				  if (confirm(text) == true) {
					    text = "You pressed OK";
					   // alert(text);
					    document.getElementById("demo").value = text;
					    updatePatientDetailAndMakeAppoint(item);
					
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

function hideDepartment(){
	$('#department_div').hide();
	$('#vital_div').hide();
	$('#updatePic').show();
	$('#appPic').hide();	
}

function showDepartment(){
	$('#department_div').show();
	$('#vital_div').show();
	$('#updatePic').hide();
	$('#appPic').show();
	
}

function hideIsFormSubmitted(){
	$('#form_div').hide();
	$('#registration_div').show();
	$('#relationId').val('');
}

function showIsFormSubmitted(){
	$('#form_div').show();
	$('#registration_div').hide();
	$('#relationId').val('');
}

function resetSearchDetail(){
	  mobileNoGol="";
	   patientNameGlo="";
	   uhidGlo="";
	   appoinmentDateGlo="";

	$('#tableId').empty();
	$('#formId').trigger("reset");
	/* $('#mobileNo').val('');
	$('#patientName').val('');
	$('#uhidNo').val('');
	$('#tableId').empty(); */
	$('#camp_location').val(globalLocation);
	var htmlTable = "<tr ><td colspan='7'><h6>No Record Found !!</h6></td></tr>";
	$('#tableId').append(htmlTable);
//$('#table_div').show();
	
}

function checkBMI() {
	var a = document.getElementById("weight").value;
	var b = document.getElementById("height").value;
	var c=b/100;
	var d=c*c;
	var sub = a/d;
	$('#bmi').val(parseFloat(Math.round(sub * 100) / 100).toFixed(2));
	
}

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
				//globalWardListDropDown = dropDown;
				//$('#wardId').append(dropDown);
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
            		   }
        		    }
        		   }
            
        }

      
      function deleteDgItems() {
      	var deleteDiagnosis = document.getElementById('diagnosisId');
         if (deleteDiagnosis.selectedIndex == -1)
      	   {
      	       alert("Please select atleast one signs and symptoms")
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
      globalWardIdd = '';
      function populateWardDetails(val){
  		for(i=0;i<wardGlobalJson.length;i++){
  			var getWardName = wardGlobalJson[i].wardNameWithCode;
  			if(val == getWardName){
  				globalWardIdd = wardGlobalJson[i].wardId;
  				for(var j=0;j<globalWardList.length;j++){
  					if(globalWardList[j].wardId == globalWardIdd){
  						$('#districtId').val(wardGlobalJson[i].districtId);
  	  	  				$('#cityId').val(wardGlobalJson[i].cityId);
  					}
  				}
  	  				
  			}  			
  		}
      }
</script>
<script>
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

    #photo,#prevPic {
        width: 196px;
        height: 150px;
        border: solid 5px #fff;
    	box-shadow: 0px 0px 5px rgb(0 0 0 / 40%);
    }
     #photo,#prevPic1 {
        width: 200px;
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

				<div class="internal_Htext">Appointment of Patient</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>
								<form id="formId">
			
								<div class="row m-t-10">
                                 <input type="hidden"  name="cityIdSessionValue" value=<%= session.getAttribute("cityId") %> id="cityIdSessionValue" />
									<div class="col-md-6">
										<div class="form-check form-check-inline cusRadio m-r-20 ">
											<input class="form-check-input" type="radio" id="info_update"
												name="appointradio" value="update"
												onclick="hideDepartment()"> <span
												class="cus-radiobtn"></span> <label class="form-check-label"
												for="info_update">Update Information</label>
										</div>

										<div class="form-check form-check-inline cusRadio">
											<input class="form-check-input" type="radio" id="appoint"
												name="appointradio" value="appointment"
												onclick="showDepartment()" checked> <span
												class="cus-radiobtn"></span> <label class="form-check-label"
												for="appoint">Appointment</label>
										</div>
									</div>
								</div>

								<div class="row m-t-20">
									<div class="col-md-3">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Mobile No.</label>
											</div>
											<div class="col-md-7">
												<input name="mobileNo" id="mobileNo" type="text" maxlength="10"
															class="form-control border-input"
															placeholder="" value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;">
											</div>

										</div>
									</div>
									<div class="col-md-1 text-center">
										<label class="col-form-label">-OR-</label>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Patient Name</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="patientName" class="form-control" />
												<input type="hidden" id="demo" value=""/>
											</div>
										</div>
									</div>
									<div class="col-md-1  text-center">
										<label class="col-form-label">-OR-</label>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">UHID No.</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="uhidNo" class="form-control" />
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-3">
										<div class="form-group row">
											<label class="col-sm-5 col-form-label">Appointment Date</label>
											<!-- <div class="col-sm-7">
												<div class="dateHolder">
													
													<input type ="date" id ="from_date" class="border form-control">
													</div>
												</div> -->
											<div class="col-sm-7">
												<div class="dateHolder ">
													<input type="text"
														class="calDate datePickerInput form-control"
														id="from_date" placeholder="DD/MM/YYYY" name="date"
														onkeyup="mask(this.value,this,'2,5','/');"
														onblur="validateExpDate(this,'dateId')" maxlength="10">
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12 text-right">
										<button type="button" class="btn btn-primary m-r-10"
											onclick="searchPatient()">Search</button>
										<button type="button" class="btn btn-primary"
											onclick="resetSearchDetail()">Reset</button>
									</div>

								</div>


								<div class="m-t-10">
									<div class="clearfix">
										<!-- <div style="float: left">
											<table class="tblSearchActions" cellspacing="0"
												cellpadding="0" border="0">
												<tr>
													<td class="SearchStatus" style="font-size: 15px;"
														align="left">Search Results</td>
													<td></td>
												</tr>
											</table>
										</div>

										<div style="float: right">
											<div id="resultnavigation"></div>
										</div> -->
										<div style="float: left">
											<table class="tblSearchActions" cellspacing="0"
												cellpadding="0" border="0">
												<tr>
													<td class="SearchStatus" style="font-size: 15px;"
														align="left">Search Results</td>
												</tr>
											</table>
										</div>
										<div style="float: right">
											<div id="resultnavigation"></div>
										</div>
										<div class="table-responsive" id="table_div">
											<table
												class="table table-striped table-hover table-bordered ">
												<thead>
													<tr>
														<th>Patient Name</th>
														<th>Mobile No.</th>
														<th>UHID No.</th>
														<th>Age</th>
														<th>Gender</th>
														<th>Type of Patient</th>
													</tr>
												</thead>
												<tbody id="tableId">

												</tbody>
											</table>
										</div>
									</div>
								</div>

								<h6 class="font-weight-bold text-theme text-underline">Patient
									Details</h6>
								<div class="row">
									<div class="col-md-4">
										<div class="row">
									<div class="col-md-12">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Patient Name</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="patientName2" class="form-control"/>
											</div>
										</div>
									</div>

									<div class="col-md-12">
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

									<div class="col-md-12">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Gender</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="genderId">

												</select>
											</div>
										</div>
									</div>

									<div class="col-md-12">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Age</label>
											</div>
											<div class="col-md-3">
												<input type="text" maxlength="2" id="age" class="form-control"/>
											</div>
											<div class="col-md-4">
												<select class="form-control" id="ageId">
													<option value="Yrs">Yrs</option>
													<option value="Mths">Mths</option>
													<option value="Days">Days</option>
												</select>
											</div>
										</div>
									</div>
								</div>
									</div>	
									
									
									 <!-- <div class="col-md-4 offset-md-1" id="appPic">
										<img src="/MMUWeb/resources/images/photo_icon.png" id="prevPic" alt=""  /> 
										 <img src="D:\picphoto_icon.png" id="prevPic" alt=""  id="profileImage"/>
										<input type="hidden" id="patientImage" value="">
										<div class="row">
									    	<div class="col-sm-12">
										    	<label class="col-form-label">Profile Image</label><span class="mandate"><sup>&#9733;</sup></span>
										    </div>
									    </div>
									 </div>	 -->
									 <!-- id="updatePic" -->		
									 
									 <div class="col-sm-5  offset-md-1" >
										<div class="">
											<div class="form-group row">
											<div class="col-sm-6">
												<!-- <img src="/MMUWeb/resources/images/photo_icon.png" class="profileImg" alt="" width="80%" id="profileImage" /> -->
												   <img src="/MMUWeb/resources/images/photo_icon.png" id="prevPic" alt=""  />
												   <!-- <div class="col-md-12 m-t-10">
															  <a href="javascript:void(0)" class="btn btn-primary"  onclick="showDuplicateImage();"> Duplicate History </a></li>
													          <input type="hidden" id="duplicate" value="" >
												    </div> -->
												   <div class="col-sm-12">
												    	<label class="col-form-label">Profile Image<span class="mandate"><sup>&#9733;</sup></span></label>
												    </div>
												    <div class="col-sm-12">
												    	<button class="btn btn-primary" type="button" id="updPic" onclick="hideShowCapture();">Update photo</button>
												   
												    </div>
												    
												    <div class="col-md-12 m-t-10">
															  <a href="javascript:void(0)" class="btn btn-primary"  onclick="showPreveiousVisit();"> Patient History </a></li>
													          <input type="hidden" id="patientIdNew" value="" >																
													</div>
											</div>
											<div class="col-sm-6" id="capturePic"> 
												<div class="output">
										            <img id="photo" alt="The screen capture will appear in this box.">
										              <input type="hidden" id="patientImage" name="patientImage"></input>
										            
										        </div>
										        <div class="contentarea">    
										        <div class="camera" id="videoCont">
											           <video id="video" >Video stream not available.</video> 
											        </div>
											    
											    <div class="row">
											    	<div class="col-sm-12 m-t-10">
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
									
													<!-- <div class="col-md-11 offset-sm-1"> 
													<div class="fileUploadDiv m-b-10">
													  	<input type="file" class="inputUpload" name="empProfileImage" id="empProfileImage" onblur="if(validateImage()){getBase64StringForIDandProfile(this.id,'base64ForProfile','profileMimeType');}">
													  	
													  	<label class="inputUploadlabel">Choose File</label>
													
														<span id="spanInputUploadFileName" class="inputUploadFileName">No File Chosen</span>
														<textarea id="base64ForProfile" style="display: none;" ></script></textarea>
														<input type="hidden" id="profileMimeType" name="profileMimeType" class="form-control"  />
														<script src="sketch.js">
												  	</div> 
									  				 
												  	
												</div>-->
											</div>
										
										</div>
									</div>
													
								</div>

								<!-- type of patient -->
								<div class="row m-t-10">
									<div class="col-md-2">
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
									<div class="col-md-4">
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
										<div class="col-md-2">
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
										<div class="col-md-4">
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
										<div class="col-md-2">
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
										<div class="col-md-4">
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
									<div class="col-md-4">
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
									<div class="col-md-4">
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
									<div class="col-md-4">
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
									<div class="col-md-4">
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
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Ward</label>
											</div>
											<div class="col-md-7">
												<!-- <select class="form-control" id="wardId"
													onKeyUp="getNomenClatureList(this,'populateWardDetails','registration','getWardListWithoutCity','wardCityAndDistrict');">
													<div id="divPvms1" class="autocomplete-itemsNew"></div> 
													<option value="">Select</option>
													</select> -->
													<div class="autocomplete forTableResp">
													<input type="text" autocomplete="never"
																class="form-control border-input" name="wardName"
																id="wardId"
																onKeyUp="getNomenClatureList(this,'populateWardDetails','registration','getWardListWithoutCity','wardCityAndDistrict');">
																<div id="divPvms1" class="autocomplete-itemsNew"></div>
											</div>
											</div>
										</div>
									</div>

									<div class="col-md-4">
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

									<div class="col-md-4">
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

									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Address</label>
											</div>
											<div class="col-md-7">
												<textarea class="form-control" rows='3' id="address"></textarea>
											</div>
										</div>
									</div>
									<div class="col-md-4">
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

								<hr>


								<div class="row" id="department_div">
									<div class="col-12">
										<h6 class="font-weight-bold text-theme text-underline">Camp
											Details</h6>
									</div>
									<div class="col-md-5">
										<div class="form-group row">
											<div class="col-md-4">
												<label class="col-form-label">Camp Location</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="camp_location" readonly />
											</div>
										</div>
									</div>
									<div class="col-md-4">
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
									<div class="col-12">
										<hr>
									</div>
								</div>

								<div id="vital_div">
									<h6 class="font-weight-bold text-theme text-underline">Vitals
										Details</h6>
									<div class="row disablecopypasteDiv">
										<div class="col-md-4">
											<div class="form-group row">

												<label class="col-md-5 col-form-label">Patient Height<span class="mandate"><sup>&#9733;</sup></span></label>

												<div class="col-md-7">

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



										<div class="col-md-4">
											<div class="form-group row">

												<label class="col-md-5 col-form-label">Weight<span class="mandate"><sup>&#9733;</sup></span></label>

												<div class="col-md-7">
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

										<div class="col-md-4">
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
										<div class="col-md-4">
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

												<div class="col-md-3 offset-md-2">

													<input name="bp" id="bp" type="text" maxlength="3"
														onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
														class="form-control bpSlash border-input"
														placeholder="Systolic" value="" required> <span></span>
													<!-- slash for bp -->

												</div>
												<div class="col-md-4">
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
										<div class="col-md-4">
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





										<div class="col-md-4">
											<div class="form-group row">

												<label class="col-md-5 col-form-label">SpO2</label>

												<div class="col-md-7">
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
										<div class="col-md-4">
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
										<div class="col-md-4">
											<div class="form-group row">

												<label class="col-md-5 col-form-label">RR</label>

												<div class="col-md-7">
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



										<div class="col-md-4">
											<div class="form-group row">



												<div class="col-md-6">
													<input type="hidden" id="patientId" name="PatientID12"
														value="">
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



										<!-- <div class="col-md-12 text-right">
                                                                            
                                                                            
                                                                            <button type="button" id="saveBtn" class="btn btn-primary"
																				  onclick="saveAddvitalDetails()">Submit</button>
																			 
                                                                           
																			<button type="button" class="btn btn-primary m-l-10"
																				  onclick="goBack()">Close</button>
                                                                              
                                                                        </div> -->




									</div>
									<hr>
									<h6 class="font-weight-bold text-theme text-underline">Signs
										&amp; Symptoms</h6>
									<div class=" p-10" id="newpost7"
										style="display: block;"">
										
										<div id="checkbox_div"> 
								
										</div>
										
										<div class="row m-t-20">
											<div class="col-md-4">
												<div class="form-group row  autocomplete">

													<label class="col-md-5 col-form-label">Patient
														signs & symptoms</label>
													<div class="col-md-7">
														<div class="autocomplete forTableResp">
															<input type="text" autocomplete="never"
																class="form-control border-input" name="pvmsNumber"
																id="icd"
																onKeyUp="getNomenClatureList(this,'populateSignAndSymptoms','registration','getAllSymptoms','signAndSymptoms');" />
															<div id="divPvms2" class="autocomplete-itemsNew"></div>
														</div>

													</div>
												</div>
											</div>

											<div class="col-md-4">
												<!-- <select name="diagnosisId" multiple="4" value="" size="5"
													tabindex="1" id="diagnosisId"
													class="listBig width-full disablecopypaste"
													validate="ICD Daignosis,string,yes">
												</select> -->
												
												<div class="multiDiv" id="diagnosisId">
												</div>
											</div>
											<div class="col-md-4">
												<button type="button" class="buttonDel btn  btn-danger"
													value="" id="deleteBtnDiagnosis" onclick="deletePatientSympotonsItems();" align="right" />
												Delete
												</button>

											</div>

										</div>


									</div>
								</div>

								<div class="row m-t-20">
									<div class="col-12 text-right">
									
									<!-- <button type="button" class="btn btn-primary" onclick="showPatientPopUp();" id="registrationhistory">Registration History</button> -->
											 <input type="hidden" id="duplicate" value="" >	
										<button type="button" class="btn btn-primary"
											onclick="updatePatientDetailAndMakeAppoint(this)">Submit</button>
									</div>
								</div>
								<%--   <c:if test = "${myvar.equals('Match')}">  --%>
									<!-- <div class="row m-t-8">
									<div class="col-12 text-right">
															  <a href="javascript:void(0)" class="btn btn-primary"  onclick="showPatientPopUp();" id="registrationhistory" >Registration History</a></li>
													          <input type="hidden" id="duplicate" value="" >																
													
													</div></div> -->
										<%--  </c:if> --%>	
								</form>

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
					<!-- <button type="button" class="btn btn-primary" data-dismiss="modal"
						  aria-hidden="true" onClick="submitDoctorRemarks();">Submit</button> -->
					
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
        var clearbutton = null;
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
                    //alert("An error has occurred while contacting the server");
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
                clearbutton.disabled = false;
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
            document.getElementById("clearbutton").onclick = function() {
                //disable
                this.disabled = true;
            }
            console.log('clean: '+data);
      //      document.getElementById("patientImage").value = data;
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
	<script>
	
	var capPic=0;
	
	function hideShowCapture(){
		
		if(capPic==0){
			$('#capturePic').css('display','block');
			$('#updPic').text('Cancel');
			capPic=1;
		}else{
			$('#capturePic').css('display','none');
			$('#updPic').text('Update Photo');
			capPic=0;
		}
	}
	
	</script>
	<script>
	$(function(){
		
		$('#capturePic').hide();
		
		
	})
	</script>
	<script>
	function showPreveiousVisit() {
	
		var patientIds= $('#patientIdNew').val();
		if(patientIds == ""){
           alert("Record not selected");
           return;
			}
		else{
					var popup;
		 popup = window.open("showPatientHistory?patientId="+$('#patientIdNew').val()+"", "popUpWindow", "height=500,width=800,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
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
	<script>
	function showDuplicateImage() {
	
		var patientIds= $('#duplicate').val();
		//alert(patientIds);
		if(patientIds == ""){
           alert("No Match Found");
           return;
			}
		else{
					var popup;
		 popup = window.open("showDuplicateHistory?patientId="+$('#duplicate').val()+"", "popUpWindow", "height=500,width=800,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
                popup.focus();
		}
		
		  
			 
}

		
	</script>
</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
