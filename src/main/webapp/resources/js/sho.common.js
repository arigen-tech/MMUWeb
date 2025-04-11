/**
 * 
 * @param url
 * @param params
 * @returns
 * @Description : Mortality Family Details
 */


function validateTextValLength(id, length, data){

	 
	if($j("#"+id).val().length >= length){
		 alert("Length of "+data+" should be less than or equal to "+length);	
		 
		var str=  $j("#"+id).val();
		 str=str.substring(0,length).trim();
		 
		 $j("#"+id).val(str);
		 return false;
	 }
	
}


function submitJSONData(url,params){
	var successIcon = '<i class="fa fa-check-circle m-r-5"></i>';
	var errorIcon = '<i class="fa fa-times-circle m-r-5"></i>';
	
	 jQuery.ajax({
		 crossOrigin: true,
		    method: "POST",
		    url: url,
		    data: JSON.stringify(params),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	//alert(result);
		    	if(result.status == 1){
			    	  document.getElementById("messageId").innerHTML = successIcon + result.msg;
			    		$("#messageId").css("color", "#0abb87");
			    		$("#messageId").css("background", "rgba(29, 201, 183, 0.1");
			    		/*$j("#messageId").slideDown(500);*/
			    		$j("#messageId").animate({height: "34px"},500);
			    		setTimeout(function() {
			    			$j("#messageId").animate({height: "0px"},500);
					    },3000);
			      }else if(result.status==0)
			    	{
			        	if(result.msg != undefined)
			        		{
				        		document.getElementById("messageId").innerHTML = errorIcon + result.msg;
				        		$("#messageId").css("color", "#de5e6a");
				        		$("#messageId").css("background", "rgba(222, 94, 106, 0.1");
				        		/*$j("#messageId").slideDown(500);*/
				        		$j("#messageId").animate({height: "34px"},500);
				        		setTimeout(function() {
				        			$j("#messageId").animate({height: "0px"},500);
							    },3000);
			        		}
			        	if(result.err_mssg != undefined)
		        		{
			        		document.getElementById("messageId").innerHTML = errorIcon + result.err_mssg;
			        		$("#messageId").css("color", "#de5e6a");
			        		$("#messageId").css("background", "rgba(222, 94, 106, 0.1");
			        		$j("#messageId").animate({height: "34px"},500);
			        		setTimeout(function() {
			        			$j("#messageId").animate({height: "0px"},500);
					
						    },3000);
		        		}
			        }
		    }
	 });
	 	
}

/*****/
var comboArray = [];
function getPatientList(){
	$('#selPatientName').html("");	
	$('#submitbtnId').prop("disabled", false);
	var serviceNo = $('#serviceNo').val();
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getPatientList",
	    data: JSON.stringify({"serviceNo":serviceNo}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	console.log(result);
	    	
	    	if(result.status!=0){
	    		 var combo = "<option value=\"\">Select</option>" ;	    	
			    	for(var i=0;i<result.data.length;i++){	
			    		comboArray[i] = result.data[i].patientName;
			    			combo += '<option value='+result.data[i].patientId+'>' +result.data[i].patientName+ '</option>';
	    	} 
			    $('#selPatientName').append(combo);
			    
	    }else{
	    	alert(result.msg);
	    	$('#submitbtnId').prop("disabled", true);
	    	//alert("Patient does not Exist on this Service No.");
	    }	
	  }
	});
	
}

var patientId='';
function getPatientDetailsForAlchlolic(){
	var serviceNo = $('#serviceNo').val();
	 patientId = $('#selPatientName').find('option:selected').val();
	$('#submitbtnId').prop("disabled", false);
	//alert(patientId);
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getPatientDetails",
	    data: JSON.stringify({"patientId":patientId}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	console.log(result);
	    	var dataList = result.data;
	    	 for(var i=0;i<result.data.length;i++){
	    		
	    		 $('#patientName').val(result.data[i].patientName);
	    		 $('#age').val(result.data[i].age);
	    		 $('#name').val(result.data[i].name);
	    		 $('#rank').val(result.data[i].rank);
	    		// $('#relation').val(result.data[i].relation);
	    		 //$('#gender').val(result.data[i].gender);
	    		 $('#trade').val(result.data[i].trade);
	    		 $('#unit').val(result.data[i].unit);
	    		
	    		 $('#diagnosis').val(result.data[i].icdName);
	    		//hidden data
	    		 $('#unitId').val(result.data[i].unitId);
	    		 $('#rankId').val(result.data[i].rankId);
	    		// $('#relationId').val(result.data[i].relationId);
	    		 $('#patientId').val(patientId);
	    		 $('#tradeId').val(result.data[i].tradeId);
	    		 $('#genderId').val(result.data[i].genderId);
	    		 $('#diagnosisId').val(result.data[i].icdId);
	    	} 
	    }	    
	});
}

function viewMortalityDetails(value){
	if(value=='N'){
		$("#savebtnId").hide();
		$("#submitbtnId").hide();
		$("#resetBtn").hide();
		
		$(function () {
	         $('input[type="text"],textarea').prop("readonly",true);
	    });
		
	}
	if(value=='S'){
		var status = value;
		$("#savebtnId").show();
		$("#submitbtnId").show();
		$("#resetBtn").show();
		$('#messageId').hide();
		
		$(function () {				
	         $('input[type="text"],textarea').prop("readonly",false);
	    });
		
}
}

function enabledDisabledButton(value){
	if(value=='N'){
		$("#savebtnId").hide();
		$("#submitbtnId").hide();
		$("#resetBtn").hide();
		
		$(function () {
	         $('input[type="text"]').prop("readonly",true);
	    });
		
	}
	if(value=='S'){
		var status = value;
		$("#savebtnId").show();
		$("#submitbtnId").show();
		$("#resetBtn").show();
		$('#messageId').hide();
		
		$(function () {				
	         $('input[type="text"]').prop("readonly",false);
	    });
		
}
}


function getPatientDetailsForNewEntry(){
	var serviceNo = $('#serviceNo').val();
	 patientId = $('#selPatientName').find('option:selected').val();
	$('#submitbtnId').prop("disabled", false);
	//alert(patientId);
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getPatientDetails",
	    data: JSON.stringify({"patientId":patientId}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	console.log(result);
	    	var dataList = result.data;
	    	 for(var i=0;i<result.data.length;i++){
	    		 		 
	    			 $('#serviceNo').val(result.data[i].serviceNo);
		    		 $('#patientName').val(result.data[i].patientName);
		    		 $('#age').val(result.data[i].age).prop("readonly",true);
		    		 $('#name').val(result.data[i].name).prop("readonly",true);
		    		 $('#rank').val(result.data[i].rank).prop("readonly",true);
		    		 $('#relation').val(result.data[i].relation).prop("readonly",true);
		    		 $('#gender').val(result.data[i].gender).prop("readonly",true);
		    		 $('#trade').val(result.data[i].trade).prop("readonly",true);
		    		 $('#unit').val(result.data[i].unit).prop("readonly",true);
		    		 $('#dateOfDeath').val(result.data[i].dateOfDeath).prop("readonly",true);
		    		 $('#diagnosis').val(result.data[i].icdName).prop("readonly",true);
		    		 $('#placeOfDeath').val(result.data[i].placeOfDeath);
		    		 $('#causeOfDeath').val(result.data[i].causeOfDeath);
		    		//hidden data
		    		 $('#unitId').val(result.data[i].unitId);
		    		 $('#rankId').val(result.data[i].rankId);
		    		 $('#relationId').val(result.data[i].relationId);
		    		 $('#patientId').val(patientId);
		    		 $('#tradeId').val(result.data[i].tradeId);
		    		 $('#genderId').val(result.data[i].genderId);
		    		 $('#diagnosisId').val(result.data[i].icdId);
		    		 $('#mstatus').val(result.data[i].status);
		    		 
	    		 
	    		
	    	} 
	    }	    
	});

}

function getPatientDetailsForMortality(patientId){
	var serviceNo = $('#serviceNo').val();
	 //patientId = $('#selPatientName').find('option:selected').val();
	$('#submitbtnId').prop("disabled", false);
	//alert(patientId);
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getMortalPatientDetails",
	    data: JSON.stringify({"patientId":patientId}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	console.log(result);
	    	var dataList = result.data;
	    	 for(var i=0;i<result.data.length;i++){
	    		
	    		 if(result.data[i].status=='N'){
	    			 //readonly
	    			 $('#serviceNo').val(result.data[i].serviceNo).prop("readonly",true);
		    		 $('#patientName').val(result.data[i].patientName);
		    		 $('#age').val(result.data[i].age);
		    		 $('#name').val(result.data[i].name);
		    		 $('#rank').val(result.data[i].rank);
		    		 $('#relation').val(result.data[i].relation);
		    		 $('#gender').val(result.data[i].gender);
		    		 $('#trade').val(result.data[i].trade);
		    		 $('#unit').val(result.data[i].unit);
		    		 $('#dateOfDeath').val(result.data[i].dateOfDeath);
		    		 $('#diagnosis').val(result.data[i].icdName);
		    		 $('#placeOfDeath').val(result.data[i].placeOfDeath);
		    		 $('#causeOfDeath').val(result.data[i].causeOfDeath);
		    		//hidden data
		    		 $('#unitId').val(result.data[i].unitId);
		    		 $('#rankId').val(result.data[i].rankId);
		    		 $('#relationId').val(result.data[i].relationId);
		    		 $('#patientId').val(patientId);
		    		 $('#tradeId').val(result.data[i].tradeId);
		    		 $('#genderId').val(result.data[i].genderId);
		    		 $('#diagnosisId').val(result.data[i].icdId);
		    		 $('#mstatus').val(result.data[i].status);
		    		 
	    		 }
	    		 if(result.data[i].status=='S'){
	    			 //edit 
	    			 $('#serviceNo').val(result.data[i].serviceNo);
		    		 $('#patientName').val(result.data[i].patientName);
		    		 $('#age').val(result.data[i].age);
		    		 $('#name').val(result.data[i].name);
		    		 $('#rank').val(result.data[i].rank);
		    		 $('#relation').val(result.data[i].relation);
		    		 $('#gender').val(result.data[i].gender);
		    		 $('#trade').val(result.data[i].trade);
		    		 $('#unit').val(result.data[i].unit);
		    		 $('#dateOfDeath').val(result.data[i].dateOfDeath).prop("readonly",true);
		    		 $('#diagnosis').val(result.data[i].icdName);
		    		 $('#placeOfDeath').val(result.data[i].placeOfDeath);
		    		 $('#causeOfDeath').val(result.data[i].causeOfDeath);
		    		//hidden data
		    		 $('#unitId').val(result.data[i].unitId);
		    		 $('#rankId').val(result.data[i].rankId);
		    		 $('#relationId').val(result.data[i].relationId);
		    		 $('#patientId').val(patientId);
		    		 $('#tradeId').val(result.data[i].tradeId);
		    		 $('#genderId').val(result.data[i].genderId);
		    		 $('#diagnosisId').val(result.data[i].icdId);
		    		 $('#mstatus').val(result.data[i].status);
	    		 }
	    		 
	    	} 
	    }	    
	});
}

/**
 * @Description: save/update the mortality Family Details.
 * @param url
 * @param params
 * @returns
 */
function saveOrUpdateMortalityDetails(url,params){

	var successIcon = '<i class="fa fa-check-circle m-r-5"></i>';
	var errorIcon = '<i class="fa fa-times-circle m-r-5"></i>';
	
	 jQuery.ajax({
		 crossOrigin: true,
		    method: "POST",
		    url: url,
		    data: JSON.stringify(params),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	//alert(result);
		    	if(result.status == 1){
		    		$('#messageId').show();
			    	  document.getElementById("messageId").innerHTML = successIcon + result.msg;
			    		$("#messageId").css("color", "#0abb87");
			    		$("#messageId").css("background", "rgba(29, 201, 183, 0.1");
			    		/*$j("#messageId").slideDown(500);*/
			    		$j("#messageId").animate({height: "34px"},500);
			    		setTimeout(function() {
			    			$j("#messageId").animate({height: "0px"},500);
					    },3000);
			      }else if(result.status==0)
			    	{
			        	if(result.msg != undefined)
			        		{
			        		$('#messageId').show();
				        		document.getElementById("messageId").innerHTML = errorIcon + result.msg;
				        		$("#messageId").css("color", "#de5e6a");
				        		$("#messageId").css("background", "rgba(222, 94, 106, 0.1");
				        		/*$j("#messageId").slideDown(500);*/
				        		$j("#messageId").animate({height: "34px"},500);
				        		setTimeout(function() {
				        			$j("#messageId").animate({height: "0px"},500);
							    },3000);
			        		}
			        	if(result.err_mssg != undefined)
		        		{
			        		document.getElementById("messageId").innerHTML = errorIcon + result.err_mssg;
			        		$("#messageId").css("color", "#de5e6a");
			        		$("#messageId").css("background", "rgba(222, 94, 106, 0.1");
			        		$j("#messageId").animate({height: "34px"},500);
			        		setTimeout(function() {
			        			$j("#messageId").animate({height: "0px"},500);
					
						    },3000);
		        		}
			        }
		    }
	 });
	 	

}


function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
    	alert("only Numeric value")
        return false;
    }
    //validateTextValLength('officerCataract',8, 'Officiers Cataract Cannot Enter more than 8');
    
    return true;
} 

function saveOrUpdateDetails(url,params){

	var successIcon = '<i class="fa fa-check-circle m-r-5"></i>';
	var errorIcon = '<i class="fa fa-times-circle m-r-5"></i>';
	
	 jQuery.ajax({
		 crossOrigin: true,
		    method: "POST",
		    url: url,
		    data: JSON.stringify(params),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	if(result.status == 1){
		    		$('#messageId').show();
			    	  document.getElementById("messageId").innerHTML = successIcon + result.msg;
			    		$("#messageId").css("color", "#0abb87");
			    		$("#messageId").css("background", "rgba(29, 201, 183, 0.1");
			    		/*$j("#messageId").slideDown(500);*/
			    		$j("#messageId").animate({height: "34px"},500);
			    		setTimeout(function() {
			    			$j("#messageId").animate({height: "0px"},500);
					    },3000);
			      }else if(result.status == 2){
				    		$('#messageId').show();
					    	  document.getElementById("messageId").innerHTML = successIcon + result.msg;
					    		$("#messageId").css("color", "#0abb87");
					    		$("#messageId").css("background", "rgba(29, 201, 183, 0.1");
					    		/*$j("#messageId").slideDown(500);*/
					    		$j("#messageId").animate({height: "34px"},500);
					    		setTimeout(function() {
					    			$j("#messageId").animate({height: "0px"},500);
							    },3000);
			      }else if(result.status==0){
			        	if(result.msg != undefined)
			        		{
			        		$('#messageId').show();
				        		document.getElementById("messageId").innerHTML = errorIcon + result.msg;
				        		$("#messageId").css("color", "#de5e6a");
				        		$("#messageId").css("background", "rgba(222, 94, 106, 0.1");
				        		/*$j("#messageId").slideDown(500);*/
				        		$j("#messageId").animate({height: "34px"},500);
				        		setTimeout(function() {
				        			$j("#messageId").animate({height: "0px"},500);
							    },3000);
			        		}
			        	if(result.err_mssg != undefined)
		        		{
			        		document.getElementById("messageId").innerHTML = errorIcon + result.err_mssg;
			        		$("#messageId").css("color", "#de5e6a");
			        		$("#messageId").css("background", "rgba(222, 94, 106, 0.1");
			        		$j("#messageId").animate({height: "34px"},500);
			        		setTimeout(function() {
			        			$j("#messageId").animate({height: "0px"},500);
					
						    },3000);
		        		}
			        }
		    }
	 });
	 	

}
var selectYearVal='';
var years=""
	function getyears(){
		var min = new Date().getFullYear()-3;
	    max = min + 10;
	    select = document.getElementById('selectYear');

	for (var i = min; i<=max; i++){
	    var opt = document.createElement('option');
	    opt.value = i;
	    opt.innerHTML = i;
	    select.appendChild(opt);
	}

	select.value = new Date().getFullYear();
	selectYearVal = select.value;
	}

var hospitalId='';
function getOperationDetails(operationId){
	$('#submitbtnId').prop("disabled", false);
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: 'getViewOperationDetails',
	    data: JSON.stringify({'operationId':operationId}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	console.log(result);
	    	var dataList = result.data;
	    	 for(var i=0;i<result.data.length;i++){
	    		 if(result.data[i].status=='S'){
	    			 //edit 
	    			 hospitalId = result.data[i].hospitalId;
	    			 var currentYear = $('#selectYear').find('option:selected').val();
	    			 $('#selectYear').val(result.data[i].currentYear)
	    			 $('#officerCataract').val(result.data[i].officerCataract);
	    			 $('#officerGlaucoma').val(result.data[i].officerGlaucoma);
		    		 $('#operationDate').val(result.data[i].operationDate);
		    		 $('#lastChgDate').val(result.data[i].lastChgDate);
		    		 $('#epCataract').val(result.data[i].epCataract);
		    		 $('#epGlaucoma').val(result.data[i].epGlaucoma);
		    		 $('#personnelCataract').val(result.data[i].personnalCataract);
		    		 $('#personnelGlaucoma').val(result.data[i].personnalGlaucoma);
		    		 $('#exServmenCataract').val(result.data[i].exservicemenCataract);
		    		 $('#exServmenGlaucoma').val(result.data[i].exservicemenGlaucoma);
		    		 $('#noMultiBacillary').val(result.data[i].multiBacillaryLeprosy);
		    		 $('#noViralHepatitis').val(result.data[i].viralHepatities);
		    		 $('#noAllOthrViral').val(result.data[i].allOtherViral);
		    		 $('#noOfDogBiteTreated').val(result.data[i].dogBiteTreatedAnitRabid);
		    		 $('#totalVaccine').val(result.data[i].totalVaccine);
		    		 $('#selectUnit').val(result.data[i].hospitalId);
		    		 $('#status').val(result.data[i].status);
		    		 $('#noPauciBacillary').val(result.data[i].pauciBacillaryLeprosy);
		    		 $('#operationId').val(result.data[i].operationId)
	    		 }
	    		 if(result.data[i].status=='N'){
	    			 hospitalId = result.data[i].hospitalId;
	    			 var currentYear = $('#selectYear').find('option:selected').val();
	    			 $('#selectYear').val(result.data[i].currentYear).prop("disabled", true);
	    			 $('#officerCataract').val(result.data[i].officerCataract);
	    			 $('#officerGlaucoma').val(result.data[i].officerGlaucoma);
		    		 $('#operationDate').val(result.data[i].operationDate);
		    		 $('#lastChgDate').val(result.data[i].lastChgDate);
		    		 $('#epCataract').val(result.data[i].epCataract);
		    		 $('#epGlaucoma').val(result.data[i].epGlaucoma);
		    		 $('#personnelCataract').val(result.data[i].personnalCataract);
		    		 $('#personnelGlaucoma').val(result.data[i].personnalGlaucoma);
		    		 $('#exServmenCataract').val(result.data[i].exservicemenCataract);
		    		 $('#exServmenGlaucoma').val(result.data[i].exservicemenGlaucoma);
		    		 $('#noMultiBacillary').val(result.data[i].multiBacillaryLeprosy);
		    		 $('#noViralHepatitis').val(result.data[i].viralHepatities);
		    		 $('#noAllOthrViral').val(result.data[i].allOtherViral);
		    		 $('#noOfDogBiteTreated').val(result.data[i].dogBiteTreatedAnitRabid);
		    		 $('#totalVaccine').val(result.data[i].totalVaccine);
		    		 $('#selectUnit').val(result.data[i].hospitalId).prop("disabled", true);;
		    		 $('#status').val(result.data[i].status);
		    		 $('#noPauciBacillary').val(result.data[i].pauciBacillaryLeprosy);
		    		 $('#operationId').val(result.data[i].operationId)
	    		 }
	    	} 
	    }	    
	});
 }

function resetTextBox(){
	$(':input:text').each(function() {
        $(this).val('');
     });
	
	$('select').each(function() {
        $(this).val('');
     });
	
	
}

function resetForm(){
	resetTextBox();
}


//view health promotion details
	function getHelathPromotionDetails(healthPromotionId){

		$('#submitbtnId').prop("disabled", false);
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: 'getViewHealthPromotionDetails',
		    data: JSON.stringify({'healthPromotionId':healthPromotionId}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	console.log(result);
		    	var dataList = result.data;
		    	 for(var i=0;i<result.data.length;i++){
		    		 if(result.data[i].status=='S'){
		    			 //edit 
		    			 hospitalId = result.data[i].hospitalId;
		    			 $('#date').val(result.data[i].healthPromotionDate).prop('readonly', true);
		    			 $('#sType').val(result.data[i].healthPromotionTopic);
		    			 $('#subject').val(result.data[i].subject);
		    			 $('#rankCategory').val(result.data[i].rankCategory);
		    			 $('#place').val(result.data[i].healthPromotionPlace);
		    			 $('#noOfAttended').val(result.data[i].healthPromotionAttended);
		    			 $('#remarks').val(result.data[i].healthPromotionRemark);
		    			 $('#subStatus').val(result.data[i].status);
		    			 
		    		 }
		    		 if(result.data[i].status=='N'){
		    			 hospitalId = result.data[i].hospitalId;
		    			 $('#date').val(result.data[i].healthPromotionDate)
		    			 $('#sType').val(result.data[i].healthPromotionTopic).prop('disabled',true);;
		    			 $('#subject').val(result.data[i].subject);
		    			 $('#rankCategory').val(result.data[i].rankCategory).prop('disabled',true);;
		    			 $('#place').val(result.data[i].healthPromotionPlace);
		    			 $('#noOfAttended').val(result.data[i].healthPromotionAttended);
		    			 $('#remarks').val(result.data[i].healthPromotionRemark);
		    			 $('#subStatus').val(result.data[i].status);
		    			
		    		 }
		    	} 
		    }	    
		});
	 
	}

	function enabledDisabledBtn(value){
		if(value=='N'){
			$("#savebtnId").hide();
			$("#submitbtnId").hide();
			$("#resetBtn").hide();
			
			$(function () {
		         $('input[type="text"]').prop("readonly",true);
		    });
			
		}
		if(value=='S'){
			var status = value;
			$("#savebtnId").show();
			$("#submitbtnId").show();
			$("#resetBtn").show();
			$('#messageId').hide();
			
			$(function () {				
		         $('input[type="text"]').prop("readonly",false);
		    });
			
		}
	}