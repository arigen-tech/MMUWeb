<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title></title>
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
		GetCityList();
		});
		
	
function GetCityList(){
	 jQuery('#citySearch').empty();
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "getAllCity",
		    data: JSON.stringify({"PN" : "0"}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	var combo = "<option value=\"\">Select</option>" ;
		    	
		    	for(var i=0;i<result.data.length;i++){
		    		combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
		    		
		    	}
		    	
		    	jQuery('#citySearch').append(combo);
		    	
		    }
		    
		});
	}	
	
function saveOrUpdateLgacyDataFunction() {
	
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";

	var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/master/saveOrUpdateLgacyData";
	var cityId=$('#citySearch').val();
	if(cityId=="")
	{
		alert("Please select city")
		 $("#saveBtn").attr("disabled", false);
		return false;
	}	
	  
	
	var dataJSON={
			     
  			'cityId':$('#citySearch').val(),
  			'noOfCamp':$('#noOfCamp').val(), 
  			'totalPatient':$('#totalPatient').val(),
  			'averagePatientCount':$('#averagePatientCount').val(),
  			'countOfPatientLabTest':$('#countOfPatientLabTest').val(),
  			'countOPatientMdicineGiven':$('#countOPatientMdicineGiven').val(),
  			'countOPatientLabourDepartment':$('#countOPatientLabourDepartment').val(),
  			'countOPatientLabourRegistration':$('#countOPatientLabourRegistration').val(),
  			
  			'countOfMMUCamp':$('#countOfMMUCamp').val(),
  			'totalNoOfPatient':$('#totalNoOfPatient').val(),
  			'averagePatientMMU':$('#averagePatientMMU').val(),
  			'noOfPatientLabTest':$('#noOfPatientLabTest').val(),
  			'noOfPatientMedicineDispensed':$('#noOfPatientMedicineDispensed').val(),
  			'noOfPatientLabourDepartment':$('#noOfPatientLabourDepartment').val(),
  			'noOfPatientLabourRegistration':$('#noOfPatientLabourRegistration').val(),
  			
  			'noOfLabourMale':$('#noOfLabourMale').val(),
  			'noOfLabourFemale':$('#noOfLabourFemale').val(),
  			'noOfLabourChild':$('#noOfLabourChild').val(),
  			'noOfLabourTransgender':$('#noOfLabourTransgender').val(),
  			//'totalBeneficiary':$('#totalBeneficiary').val(),
  			'noOfPatientAppliedLabourBoc':$('#noOfPatientAppliedLabourBoc').val(),
  			'noOfPatientAppliedLabour':$('#noOfPatientAppliedLabour').val(),
  			'noOfPatientAppliedBoc':$('#noOfPatientAppliedBoc').val(),
  			'noOfPatientAppliedOthers':$('#noOfPatientAppliedOthers').val(),
  			'noOfUnrgistredWorkersTeated':$('#noOfUnrgistredWorkersTeated').val(),
  			'noOfUnrgistredWorkers':$('#noOfUnrgistredWorkers').val(),
  			'noOfNonLabourGeneral':$('#noOfNonLabourGeneral').val(),
  			
  		}
	$("#saveBtn").attr("disabled", true);
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : url,
		data: JSON.stringify(dataJSON),
		dataType : 'json',
		timeout : 100000,
		success : function(msg)
		{
		  if (msg.status == 1)
		   	   {
        		   alert("Legacy data details inserted successfully"+'S');
        		   //show_msg({'msg':' Vitals Details Insert successfully ','status':'1'});
        		   $("#saveBtn").attr("disabled", false);
        		   document.addEventListener('click',function(e){
   					    if(e.target && e.target.id== 'closeBtn'){
   	   	   				 	window.location="legacyDataMaster";
   					     }
   					 });
        		   
        		  /*  setTimeout(function(){ 
        			   location.reload();
	        		   window.location.href = "preOpdWaitingList"
        		   }, 3000); */
        		   
        	   }
        		
        	  else
        	  {
        		  $("#saveBtn").attr("disabled", false);
        		  alert(msg.status)
        	   }
           },
           error: function (jqXHR, exception) {
               var msg = '';
               if (jqXHR.status === 0) {
                   msg = 'Not connect.\n Verify Network.';
               } else if (jqXHR.status == 404) {
                   msg = 'Requested page not found. [404]';
               } else if (jqXHR.status == 500) {
                   msg = 'Internal Server Error [500].';
               } else if (exception === 'parsererror') {
                   msg = 'Requested JSON parse failed.';
               } else if (exception === 'timeout') {
                   msg = 'Time out error.';
               } else if (exception === 'abort') {
                   msg = 'Ajax request aborted.';
               } else {
                   msg = 'Uncaught Error.\n' + jqXHR.responseText;
               }
               alert(msg);
           }
	});

}

function getLegacyCityMasterData() {
	
	var j=1;
    
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/master/getLegacyCityMasterData";
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'cityId' : $('#citySearch').val()
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
					var datas = response.data[0];
					var msg=response.msg;
					if(msg=="No Record Found")
					{
						$("#saveBtn").attr("disabled", false);
						document.getElementById('noOfCamp').value ='';
						document.getElementById('totalPatient').value ='';
						document.getElementById('averagePatientCount').value ='';
						document.getElementById('countOfPatientLabTest').value ='';
						document.getElementById('countOPatientMdicineGiven').value ='';
						document.getElementById('countOPatientLabourDepartment').value ='';
						document.getElementById('countOPatientLabourRegistration').value ='';
						
						document.getElementById('countOfMMUCamp').value ='';
						document.getElementById('totalNoOfPatient').value ='';
						document.getElementById('averagePatientMMU').value ='';
						document.getElementById('noOfPatientLabTest').value ='';
						document.getElementById('noOfPatientMedicineDispensed').value ='';
						document.getElementById('noOfPatientLabourDepartment').value ='';
						document.getElementById('noOfPatientLabourRegistration').value ='';
						
						document.getElementById('noOfLabourMale').value ='';
						document.getElementById('noOfLabourFemale').value ='';
						document.getElementById('noOfLabourChild').value ='';
						document.getElementById('noOfLabourTransgender').value ='';
						//document.getElementById('totalBeneficiary').value ='';
						document.getElementById('noOfPatientAppliedLabourBoc').value ='';
						document.getElementById('noOfPatientAppliedLabour').value ='';
						document.getElementById('noOfPatientAppliedBoc').value ='';
						document.getElementById('noOfPatientAppliedOthers').value ='';
						document.getElementById('noOfUnrgistredWorkersTeated').value ='';
						document.getElementById('noOfUnrgistredWorkers').value ='';
						document.getElementById('noOfNonLabourGeneral').value ='';
						//alert("No Record Found")
						//window.location="legacyDataMaster";
					}	
					else
					{	
						if(datas.noOfCamp!=null)
						{	
						document.getElementById('noOfCamp').value =datas.noOfCamp;
						}
						else
						{
							document.getElementById('noOfCamp').value ='';
						}	
						if(datas.totalPatient!=null)
						{
						document.getElementById('totalPatient').value =datas.totalPatient;
						}
						else
						{
							document.getElementById('totalPatient').value ='';	
						}	
						if(datas.averagePatientCount!=null)
						{
						document.getElementById('averagePatientCount').value =datas.averagePatientCount;
						}
						else
						{
							document.getElementById('averagePatientCount').value ='';	
						}	
						if(datas.countOfPatientLabTest!=null)
						{
						document.getElementById('countOfPatientLabTest').value =datas.countOfPatientLabTest;
						}
						else
						{
							document.getElementById('countOfPatientLabTest').value ='';	
						}	
						if(datas.countOPatientMdicineGiven!=null)
						{
						document.getElementById('countOPatientMdicineGiven').value =datas.countOPatientMdicineGiven;
						}
						else
						{
							document.getElementById('countOPatientMdicineGiven').value ='';	
						}	
						if(datas.countOPatientLabourDepartment!=null)
						{
						document.getElementById('countOPatientLabourDepartment').value =datas.countOPatientLabourDepartment;
						}
						else
						{
							document.getElementById('countOPatientLabourDepartment').value ='';	
						}	
						if(datas.countOPatientLabourRegistration!=null)
						{
						document.getElementById('countOPatientLabourRegistration').value =datas.countOPatientLabourRegistration;
						}
						else
						{
							document.getElementById('countOPatientLabourRegistration').value ='';	
						}	
						if(datas.countOfMMUCamp!=null)
						{
						document.getElementById('countOfMMUCamp').value =datas.countOfMMUCamp;
						}
						else
						{
							document.getElementById('countOfMMUCamp').value ='';	
						}	
						if(datas.totalNoOfPatient!=null)
						{
						document.getElementById('totalNoOfPatient').value =datas.totalNoOfPatient;
						}
						else
						{
							document.getElementById('totalNoOfPatient').value ='';	
						}	
						if(datas.averagePatientMMU!=null)
						{
						document.getElementById('averagePatientMMU').value =datas.averagePatientMMU;
						}
						else
						{
							document.getElementById('averagePatientMMU').value ='';	
						}	
						if(datas.noOfPatientLabTest!=null)
						{
						document.getElementById('noOfPatientLabTest').value =datas.noOfPatientLabTest;
						}
						else
						{
							document.getElementById('noOfPatientLabTest').value ='';	
						}	
						if(datas.noOfPatientMedicineDispensed!=null)
						{
						document.getElementById('noOfPatientMedicineDispensed').value =datas.noOfPatientMedicineDispensed;
						}
						else
						{
							document.getElementById('noOfPatientMedicineDispensed').value ='';	
						}	
						if(datas.noOfPatientLabourDepartment!=null)
						{
						document.getElementById('noOfPatientLabourDepartment').value =datas.noOfPatientLabourDepartment;
						}
						else
						{
							document.getElementById('noOfPatientLabourDepartment').value ='';	
						}	
						if(datas.noOfPatientLabourRegistration!=null)
						{
						document.getElementById('noOfPatientLabourRegistration').value =datas.noOfPatientLabourRegistration;
						}
						else
						{
							document.getElementById('noOfPatientLabourRegistration').value ='';	
						}	
						if(datas.noOfLabourMale!=null)
						{
						document.getElementById('noOfLabourMale').value =datas.noOfLabourMale;
						}
						else
						{
							document.getElementById('noOfLabourMale').value ='';	
						}	
						if(datas.noOfLabourFemale!=null)
						{
						document.getElementById('noOfLabourFemale').value =datas.noOfLabourFemale;
						}
						else
						{
							document.getElementById('noOfLabourFemale').value ='';	
						}	
						if(datas.noOfLabourChild!=null)
						{
						document.getElementById('noOfLabourChild').value =datas.noOfLabourChild;
						}
						else
						{
							document.getElementById('noOfLabourChild').value ='';	
						}	
						if(datas.noOfLabourTransgender!=null)
						{
						document.getElementById('noOfLabourTransgender').value =datas.noOfLabourTransgender;
						}
						else
						{
							document.getElementById('noOfLabourTransgender').value ='';	
						}	
						/* if(datas.totalBeneficiary!=null)
						{
						document.getElementById('totalBeneficiary').value =datas.totalBeneficiary;
						}
						else
						{
							document.getElementById('totalBeneficiary').value ='';
						} */	
						if(datas.noOfPatientAppliedLabourBoc!=null)
						{
						document.getElementById('noOfPatientAppliedLabourBoc').value =datas.noOfPatientAppliedLabourBoc;
						}
						else
						{
							document.getElementById('noOfPatientAppliedLabourBoc').value ='';
						}	
						if(datas.noOfPatientAppliedLabour!=null)
						{
						document.getElementById('noOfPatientAppliedLabour').value =datas.noOfPatientAppliedLabour;
						}
						else
						{
							document.getElementById('noOfPatientAppliedLabour').value ='';	
						}	
						if(datas.noOfPatientAppliedBoc!=null)
						{
						document.getElementById('noOfPatientAppliedBoc').value =datas.noOfPatientAppliedBoc;
						}
						else
						{
							document.getElementById('noOfPatientAppliedBoc').value ='';
						}	
						if(datas.noOfPatientAppliedOthers!=null)
						{
						document.getElementById('noOfPatientAppliedOthers').value =datas.noOfPatientAppliedOthers;
						}
						else
						{
							document.getElementById('noOfPatientAppliedOthers').value ='';
						}	
						if(datas.noOfUnrgistredWorkersTeated!=null)
						{
						document.getElementById('noOfUnrgistredWorkersTeated').value =datas.noOfUnrgistredWorkersTeated;
						}
						else
						{
							document.getElementById('noOfUnrgistredWorkersTeated').value ='';	
						}	
						if(datas.noOfUnrgistredWorkers!=null)
						{
						document.getElementById('noOfUnrgistredWorkers').value =datas.noOfUnrgistredWorkers;
						}
						else
						{
							document.getElementById('noOfUnrgistredWorkers').value ='';	
						}	
						if(datas.noOfNonLabourGeneral!=null)
						{
						document.getElementById('noOfNonLabourGeneral').value =datas.noOfNonLabourGeneral;
						}
						else
						{
							document.getElementById('noOfNonLabourGeneral').value ='';	
						}	
						
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
	
</script>
	

</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">Legacy Data Entry</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-6">
												<select class="form-control disablecopypaste" onchange="getLegacyCityMasterData()" id="citySearch">
												
												</select>
											</div>
										</div>
									</div>

									<div class="col-lg-3 col-sm-6">										
										<button type="button" class="btn btn-primary m-t-3" onclick="">Search</button>										
									</div>
								</div>
								
								<div class="row m-t-20">
									<div class="col-12">
	                               		<h6 class="font-weight-bold text-theme text-underline">Dai Didi Clinic Register</h6>
	                               	</div>
	                               	
	                               <!-- 	<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-6">
												<select class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="cityId">
												
												</select>
											</div>
										</div>
									</div> -->
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">No. of Camp</label>
											</div>
											<div class="col-md-6">
												<input type="text" id="noOfCamp" name="noOfCamp" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" >
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Total Patients</label>
											</div>
											<div class="col-md-6">
												<input type="text" id="totalPatient" name="totalPatient" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" >
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Average Patient Count</label>
											</div>
											<div class="col-md-6">
												<input type="text" id="averagePatientCount" name="averagePatientCount" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" >
											</div>
										</div>
									</div>
									
									<div class="w-100"></div>
									
									<div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">Count of patient against which lab test is done</label>
											</div>
											<div class="col-md-4">
												<input type="text" id="countOfPatientLabTest" name="countOfPatientLabTest" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" >
											</div>
										</div>
									</div>
									
									<div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">Count of patient whom medicine is given</label>
											</div>
											<div class="col-md-4">
												<input type="text" id="countOPatientMdicineGiven" name="countOPatientMdicineGiven" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" >
											</div>
										</div>
									</div>
									
									<div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">Count of patient in labour department</label>
											</div>
											<div class="col-md-4">
												<input type="text" id="countOPatientLabourDepartment" name="countOPatientLabourDepartment" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" >
											</div>
										</div>
									</div>
									
									<div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">Count of patient who has submitted form for labour registration</label>
											</div>
											<div class="col-md-4">
												<input type="text" id="countOPatientLabourRegistration" name="countOPatientLabourRegistration" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" >
											</div>
										</div>
									</div>
									
								</div>
								
								
								
								
								
								<div class="row m-t-20">
									<div class="col-12">
	                               		<h6 class="font-weight-bold text-theme text-underline">MMSSY Information Register</h6>
	                               	</div>
	                               	
	                               <!-- 	<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">District</label>
											</div>
											<div class="col-md-6">
												<select class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="districtId" name="districtId">
												
												</select>
											</div>
										</div>
									</div> -->
									
									<!-- <div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">ULB Name</label>
											</div>
											<div class="col-md-6">
												<select class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="ulbName" name="ulbName" >
												
												</select>
											</div>
										</div>
									</div> -->
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Count of MMU Camp</label>
											</div>
											<div class="col-md-6">
												<input type="text" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="countOfMMUCamp" name="countOfMMUCamp" >
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Total No. Patient</label>
											</div>
											<div class="col-md-6">
												<input type="text" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="totalNoOfPatient" name="totalNoOfPatient" >
											</div>
										</div>
									</div>
									
									<div class="w-100"></div>
									
									<div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">Average no. of patients per MMU</label>
											</div>
											<div class="col-md-4">
												<input type="text" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="averagePatientMMU" name="averagePatientMMU" >
											</div>
										</div>
									</div>
									
									<div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">No. of patients who got lab test</label>
											</div>
											<div class="col-md-4">
												<input type="text" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="noOfPatientLabTest" name="noOfPatientLabTest" >
											</div>
										</div>
									</div>
									
									<div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">No. of patients to whom medicine dispensed</label>
											</div>
											<div class="col-md-4">
												<input type="text" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="noOfPatientMedicineDispensed" name="noOfPatientMedicineDispensed" >
											</div>
										</div>
									</div>
									
									<div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">No. of patient registered in labour department</label>
											</div>
											<div class="col-md-4">
												<input type="text" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="noOfPatientLabourDepartment" name="noOfPatientLabourDepartment" >
											</div>
										</div>
									</div>
									
									<div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">No. of patient who has applied for labour registration</label>
											</div>
											<div class="col-md-4">
												<input type="text" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="noOfPatientLabourRegistration" name="noOfPatientLabourRegistration" >
											</div>
										</div>
									</div>
									
								</div>
								
								
								
								
								<div class="row m-t-20">
									<div class="col-12">
	                               		<h6 class="font-weight-bold text-theme text-underline">MMSSY Labour Information Register</h6>
	                               	</div>
	                               	
	                               <!-- 	<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-6">
												<select class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="cityOne" name="cityOne" >
												
												</select>
											</div>
										</div>
									</div>	 -->								
																		
									<div class="w-100"></div>
									
									<div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">No. of labour beneficiary - Male</label>
											</div>
											<div class="col-md-4">
												<input type="text" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="noOfLabourMale" name="noOfLabourMale" >
											</div>
										</div>
									</div>
									<div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">No. of labour beneficiary - Female</label>
											</div>
											<div class="col-md-4">
												<input type="text" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="noOfLabourFemale" name="totalFemale" >
											</div>
										</div>
									</div>
									<div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">No. of labour beneficiary - Child</label>
											</div>
											<div class="col-md-4">
												<input type="text" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="noOfLabourChild" name="noOfLabourChild" >
											</div>
										</div>
									</div>
									<div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">No. of labour beneficiary - Transgender</label>
											</div>
											<div class="col-md-4">
												<input type="text" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="noOfLabourTransgender" name="noOfLabourTransgender" >
											</div>
										</div>
									</div>
									
									<!-- <div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">Total no. of labour beneficiary</label>
											</div>
											<div class="col-md-4">
												<input type="text" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="totalBeneficiary" name="totalBeneficiary" >
											</div>
										</div>
									</div> -->
									
									<div class="w-100"></div>									
									
									
									<div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">No. of patient registered in labour department - BOC</label>
											</div>
											<div class="col-md-4">
												<input type="text" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="noOfPatientAppliedLabourBoc" name="noOfPatientAppliedLabourBoc" >
											</div>
										</div>
									</div>
									<div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">No. of patient registered in labour department - Others</label>
											</div>
											<div class="col-md-4">
												<input type="text" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="noOfPatientAppliedLabour" name="noOfPatientAppliedLabour" >
											</div>
										</div>
									</div>
									
									<div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">No. of patient who has applied for registration - BOC</label>
											</div>
											<div class="col-md-4">
												<input type="text" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="noOfPatientAppliedBoc" name="noOfPatientAppliedBoc" >
											</div>
										</div>
									</div>
									<div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">No. of patient who has applied for registration - Others</label>
											</div>
											<div class="col-md-4">
												<input type="text" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="noOfPatientAppliedOthers" name="noOfPatientAppliedOthers">
											</div>
										</div>
									</div>
									
									<div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">No. of unregistered workers treated in the past who has applied for labour registration - BOC</label>
											</div>
											<div class="col-md-4">
												<input type="text" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="noOfUnrgistredWorkersTeated" name="noOfUnrgistredWorkersTreated">
											</div>
										</div>
									</div>
									
									<div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">No. of unregistered workers treated in the past who has applied for labour registration - Others</label>
											</div>
											<div class="col-md-4">
												<input type="text" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="noOfUnrgistredWorkers" name="noOfUnrgistredWorkers" >
											</div>
										</div>
									</div>
									
									<div class="col-lg-6 col-sm-6">
										<div class="form-group row">
											<div class="col-md-8">
												<label class="col-form-label">No. of non-labour who has been treated - General Citizen</label>
											</div>
											<div class="col-md-4">
												<input type="text" class="form-control disablecopypaste" onkeypress="return checkValidate(event);" id="noOfNonLabourGeneral" name="noOfNonLabourGeneral">
											</div>
										</div>
									</div>
									
								</div>
								<div class="row">
										<div class="col-md-12 clearfix">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
												<input type="submit" id="saveBtn"
													class="btn btn-primary" value="Update"
													onclick="saveOrUpdateLgacyDataFunction()" />
												<!-- <button id="reset" class="btn  btn-danger" accesskey="r"/> Reset </button> -->
												

											</div>
										</div>
									</div>
								
							<!-- 	<div class="row">
									<div class="col-12">										
										<button type="button" class="btn-right-all" id="saveBtn" onclick="saveOrUpdateLgacyDataFunction()">Update</button>	
										<button type="button" class="btn btn-primary m-t-3" onclick="">Reset</button>										
									</div>
								</div>		 -->						
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
