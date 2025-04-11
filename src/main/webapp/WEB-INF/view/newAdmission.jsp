<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>
<%@page import="com.mmu.web.utils.HMSUtil"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>New Admission</title>
<%@include file="..//view/commonJavaScript.jsp"%>
<%long valueRegistrationTypeId = Long.parseLong(HMSUtil.getProperties("js_messages_en.properties", "REGISTRATION_TYPE_ICG_ID")); %>
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
		
		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/opd/patientListForEmployeeAndDependent";
		
		$('.loaderimg').show();
		var serviceNo = $j('#serviceNo').val();
		$j('#patientId').val("");
		document.getElementById("selPatientName").options.length = 1;
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
					if(response.status=='1'){
						var patientValue = "";
						 patientList = response.data;
						 for(count in patientList){
							 patientValue += '<option value='+patientList[count].patientId+'~~'+patientList[count].Id+'>'
											+ patientList[count].name
											+ '</option>';
						 }
						 $j('#selPatientName').append(patientValue); 	  	
						
					}else{
						$j('#patientId').val("");
						document.getElementById("selPatientName").options.length = 1;
						alert(response.msg);
					}
					
					$('.loaderimg').hide();
				}
			});
		}else{
			alert("Service No. can not be blank.");
			$('#loadingDiv').hide();
			return false;
		}
		
	}
	
	function changePatientName(){
		var patientSelectValue = $j('#selPatientName').find('option:selected').val();
		var splitValue=patientSelectValue.split("~~");
		var patientId = splitValue[0];
		var rowId = parseInt(splitValue[1]);
		
		
		for(count in patientList){
		if(rowId==patientList[count].Id){
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
		        combo += '<option value='+response[i].unitId+'>' +response[i].unitName+ '</option>';
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
	  	   
    
    function saveAdmissionDetail(){
    	
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
    	
    	var admission_date = $j('#admission_date').val();
    	var ward = $j('#ward').val();
    	var admission_no = $j('#admission_no').val();
    	if($j('#selPatientName').find('option:selected').text() == '' || $j('#selPatientName').find('option:selected').text() == undefined || $j('#selPatientName').find('option:selected').text() == 'Select'){
    		window.alert("Patient must be selected");
    		return;
    	}else if(admission_date == '' || admission_date == undefined){
    		alert("Admission Date must be selected");
    		return;
    	}else if(process(admission_date) > process(currentDateInddmmyyyy())){
    		alert("Admission Date cannot be future Date");
    		return;
    	}else if(ward == '' || ward == undefined){
    		alert("Please enter Ward Name");
    		return;
    	} 	
    	
		var params = {
				
			 	"serviceNo": serviceNo,
			    "rankId" : rankId,
			    "relationId" : relationId,
			    "patientDOB"	: patientDOB,
			    "genderId" : genderId,
			    "patientId" : patientId,
			    "patient_id":patientId,
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
				"admission_date":$j('#admission_date').val(),
				"ward":$j('#ward').val(),
				"admission_no":$j('#admission_no').val(),
				"remarks":$j('#remark').val(),
				"hospital_id": <%= hospitalId %>
		}
		console.log("params are ::: "+JSON.stringify(params));
		 $j.ajax({
				type:"POST",
				contentType : "application/json",
				url: 'saveNewAdmission',
				data : JSON.stringify(params),
				dataType: "json",			
				cache: false,
				success: function(data)
				{  
					var text = data.msg;
					if(text != 'Patient already admitted'){
						alert(data.msg+'S');
						document.addEventListener('click',function(e){
	   					    if(e.target && e.target.id== 'closeBtn'){
	   	   	   				 	window.location="admissionPending";
	   					     }
	   					 });
					}else{
						alert(data.msg);
					}
					
					
				},
				
				error: function(data)
				{					
					
					alert("An error has occurred while contacting the server");
					
				}
		}); 
    }
    
    function resetDetail(){
    	$j('#admission_date').val('');
    	$j('#ward').val('');
    	$j('#remark').val('');
    	$j('#admission_no').val('');
    	$j('#discharge_date').val('');
    }
    
    function closeScreen(){
    	window.location = 'admissionPending';
    }
    
	function isNumber(evt) {
	    evt = (evt) ? evt : window.event;
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
	        return false;
	    }
	    return true;
	}
</script>

<body>
 <!-- Begin page -->
    <div id="wrapper">

	<div class="content-page">
		<div class="">
			<div class="container-fluid">
				<div class="internal_Htext">New Admission</div>

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
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Patient List</label>
														</div>
														<div class="col-sm-7">
															<select id="selPatientName" class="form-control" onchange="changePatientName();">
																<option value="" selected="selected">Select</option>
															</select>
															<img class="loaderimg" src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
														</div>
													</div>
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
													<h4  class="service_htext">Admission Details</h4>
												</div>
												<div class="row">
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Date of Admission</label>
														</div>
														<!-- <div class="col-sm-7">
															<input type="date" class="form-control"
																id="admission_date" name="admission_date">
														</div> -->
													<div class="col-sm-7">
														<div class="dateHolder ">
															<input type="text"  class="calDate datePickerInput form-control" id="admission_date" placeholder="DD/MM/YYYY"
															name="date"  onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10">
														</div>
													</div>
													</div>
												</div>





												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class=" col-form-label  ">Ward Name</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="ward">
														</div>
													</div>
												</div>
												<!-- <div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Date of Discharge</label>
														</div>
														<div class="col-sm-7">
															<input type="date" class="form-control"
																id="discharge_date">
														</div>
													</div>
												</div> -->
												<!-- <div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Disposal</label>
														</div>
														<div class="col-sm-7">
															<select class="form-control" id="disposal_combo">
															</select>
														</div>
													</div>
												</div> -->



												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class=" col-form-label  ">Remark</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="remark">
														</div>
													</div>
												</div>
												
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Admission No.</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="admission_no">
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row"></div>
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
													<input type="hidden"  name="registrationTypeId" value="<%=valueRegistrationTypeId%>" id="registrationTypeId"/>
												</div>



												<div class="col-md-12 text-right">
													 
														<button type="button" class="btn btn-primary" onclick="saveAdmissionDetail()">Submit</button>
													
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