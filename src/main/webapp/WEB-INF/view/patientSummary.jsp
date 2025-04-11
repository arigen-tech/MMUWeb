<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<title>Patient Summary</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>


<style>
.side-menu,.topbar{
	display:none;
}
.content-page{
	margin-left:0;
}
.content-page .content{
	margin-top:0;
}
</style>
</head>
<script type="text/javascript" language="javascript">

function generateReport()
{
	//document.frm.action="${pageContext.request.contextPath}/report/generateEHRReport";
	//document.frm.method="POST";
	//document.frm.submit(); 
	var patientIdVal=$('#patientIdVal').val();
	var uhidNo=$('#Registration_No').val();
	var userIdVal=$('#userIdVal').val();
	var generateEHRReport="${pageContext.request.contextPath}/report/generateEHRReport?patientId="+patientIdVal+"&userId="+userIdVal;
	openPdfModel(generateEHRReport);
	//downloadEhrDocumentFormRMS(uhidNo,patientIdVal);
	
}

function generateCompleteReport()
{
	//document.frm.action="${pageContext.request.contextPath}/report/generateEHRReport";
	//document.frm.method="POST";
	//document.frm.submit(); 
	
	var patientIdVal=$('#patientIdVal').val();
	var uhidNo=$('#Registration_No').val();
	var userIdVal=$('#userIdVal').val();
	//var generateEHRReport="${pageContext.request.contextPath}/report/generateEHRReport?patientId="+patientIdVal+"&userId="+userIdVal;
	//openPdfModel(generateEHRReport);
	$('#fullEhr').addClass('loading-bar').text('Downloading...');
	downloadEhrDocumentFormRMS(uhidNo,patientIdVal);
	
}

<%

	String patientId = request.getParameter("patientId");
	String userId = request.getParameter("userId");
%>
	var $j = jQuery.noConflict(); 
	var rowcount=0;
	$j(document).ready(function()
		{				
			getPatientSummary();
			var ehrFlag = 'ehrFlag';
			//getVisitSummary();
			
		});
var global_visit_index = 0;
var global_visit_array = [];
var encounter_index = 0;
 function getPatientSummary(){
 	 var params = {
			"patient_id": "<%=patientId%>",
			"user_id" : "<%=userId%>"
	}
  	<%-- var params = {
			"patient_id": "<%=patientId%>",
			"user_id" : "1"
	}   --%>
	$j.ajax({
		type : "POST",
		contentType : "application/json",
		url : 'patientSummaryDetail',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(data) {
				
			mapPatientSummary(data);
			},
		error : function() {
			alert("An error has occurred while contacting the server");
		}
	});
} 
 
/* $j(window).scroll(function() {
				
	    if($(window).scrollTop() > ($(document).height() - $(window).height()-20)) {
	    	
	           // ajax call get data from server and append to the div
	        if(global_visit_index < global_visit_array.length){
	        	getVisitSummary();
		    	global_visit_index++;
	        }	    	   
	    }
}); */

function getVisitSummary(){
	var visitId = global_visit_array[global_visit_index];
  	 var params = {
			"patient_id": "<%=patientId%>",
			"visit_id": visitId
	}  
   	/* var params = {
			"patient_id": "2375",
			"visit_id": "4101" 
	} */ 
	
	$j.ajax({
		type : "POST",
		contentType : "application/json",
		url : 'visitSummary',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(data) {		
			//alert("data is "+data);
			mapVisitSummary(data,global_visit_index)
			global_visit_index++; 
			if(global_visit_index < global_visit_array.length){
				getVisitSummary();		
			}				
		},
		error : function() {
			alert("An error has occurred while contacting the server");
		}
	});
}

function mapPatientSummary(data){
	
	
	console.log("ref _cur3 "+data.patient_summary.ref_cur3);
	$j('#implant_div').hide();
	$j('#vital_sign_div').hide();	
	$j('#current_medications_div').hide();	
	$j('#most_recent_imaging_results_div').hide();	
	$j('#most_recent_lab_results_div').hide();	
	$j('#current_medical_problem_div').hide();
	$j('#immunization_div').hide();		
	if(data.patient_summary.ref_cur1 == undefined){
		return;
	}
	
	var patient_summary = data.patient_summary.ref_cur1[0];
	var current_medication_length = data.patient_summary.ref_cursor10.length;
	var most_recent_imaging_results_length = data.patient_summary.ref_cursor8.length;
	var most_recent_lab_results_length = data.patient_summary.ref_cur3.length;
	var implantLength = data.patient_summary.ref_cursor6.length;
	var most_recent_vital_signs_length = data.patient_summary.ref_cursor7.length;
	var current_medical_problem_length = data.patient_summary.ref_cursor9.length;
	var immunization_history_length = data.patient_summary.ref_cursor11.length;
	$j('#Document_ID').val(patient_summary.doocument_id);
	$j('#Generated_Date').val(patient_summary.generated_date);
	$j('#generated_time').val(patient_summary.generated_time);
	$j('#REFERRING_Location').val(patient_summary.location);
	$j('#Provider_Name').val(patient_summary.user_name);
	$j('#user_mobile').val(patient_summary.user_mobile_no);
	$j('#user_rank').val(patient_summary.user_rank_name);
	$j('#Employee_Name').val(data.patient_summary.ref_cur1[0].employee_name);
	$j('#Service_Number').val(patient_summary.service_no);
	$j('#Patient_Name').val(patient_summary.patient_name);
	$j('#Registration_No').val(patient_summary.uhid_no);
	$j('#Relation').val(patient_summary.relation_name);
	$j('#Service_Type').val(patient_summary.service_type);
	$j('#gender').val(patient_summary.gender);
	
	$j('#Branch_Trade').val(patient_summary.trade);
	$j('#DOB').val(patient_summary.dob);
	$j('#Age').val(patient_summary.age);
	$j('#Marital_Status').val(patient_summary.marital_status);	
	if(relegion=patient_summary.religion=='NA'){ 
	$j('#Religion').val('');
	}
	else{
		$j('#Religion').val(patient_summary.religion);
		}
	$j('#Email_Address').val(patient_summary.email_id);
	$j('#Address').val(patient_summary.address);
	$j('#Phone_Number').val(patient_summary.mobile_number);
	$j('#Name').val(patient_summary.nok1_name);
	$j('#contact_Relation').val(patient_summary.nok1_relation);

	$j('#contact_Address').val(patient_summary.nok1_address);
	$j('#Contact_Number').val(patient_summary.nok1_mobile_no);
	$j('#Blood_Group').val(patient_summary.blood_group);
	$j('#Allergy_Alerts').val(patient_summary.allergy_alerts);
	$j('#Past_Surgeries').val(patient_summary.past_surgeries);
	
	if(immunization_history_length > 0){
		$j('#immunization_div').show();
		var immunization_div = '';
		for(var i=0;i<immunization_history_length;i++){
			immunization_div += '<tr><td>'+(i+1)+'</td>';
			immunization_div += '<td>'+data.patient_summary.ref_cursor11[i].immunization_name+'</td>';
			immunization_div += '<td>'+data.patient_summary.ref_cursor11[i].prescription_date+'</td>';
			immunization_div += '<td>'+data.patient_summary.ref_cursor11[i].immunization_date+'</td>';
			immunization_div += '<td>'+data.patient_summary.ref_cursor11[i].duration+'</td>';
			immunization_div += '<td>'+data.patient_summary.ref_cursor11[i].next_due_date+'</td></tr>';
		}
		$j('#tblListOfImmunizationHistory').append(immunization_div);
		
	}else{
		$j('#immunization_div').show();
		var immuneHtml = "<tr ><td colspan='6'><h6>No Record Found !!</h6></td></tr>";
		$j('#tblListOfImmunizationHistory').append(immuneHtml);
	}
	if(implantLength > 0){
		$j('#implant_div').show();
		var implant_div = '';
		for(var i=0;i<implantLength;i++){
			implant_div += '<tr><td>'+(i+1)+'</td>';
			implant_div += '<td>'+data.patient_summary.ref_cursor6[i].device_id+'</td>';
			implant_div += '<td>'+data.patient_summary.ref_cursor6[i].device_name+'</td>';
			implant_div += '<td>'+data.patient_summary.ref_cursor6[i].date_of_impant+'</td>';
			implant_div += '<td>'+data.patient_summary.ref_cursor6[i].remarks+'</td></tr>';
		}
		$j('#tblListOfImplantHistory').append(implant_div);
		
	}else{
		$j('#implant_div').show();
		var implantHtml = "<tr ><td colspan='5'><h6>No Record Found !!</h6></td></tr>";
		$j('#tblListOfImplantHistory').append(implantHtml);
	}
	if(false){
		$j('#Most_Recent_vital_signs').val(patient_summary.most_recent_vital_signs);
	}
	if(most_recent_vital_signs_length > 0){
		$j('#vital_sign_div').show();
		var vital_table_body = '';
		var vital_detail_array = data.patient_summary.ref_cursor7;
		for(var i=0;i<most_recent_vital_signs_length;i++){
			vital_table_body += '<tr>';
			vital_table_body += '<td>'+ (i+1) +'</td>';
			vital_table_body += '<td>'+data.patient_summary.ref_cursor7[i].opd_date+'</td>';
			vital_table_body += '<td>'+data.patient_summary.ref_cursor7[i].temperature+'</td>';
			vital_table_body += '<td>'+data.patient_summary.ref_cursor7[i].pulse+'</td>';
			vital_table_body += '<td>'+data.patient_summary.ref_cursor7[i].bp+'</td>';
			vital_table_body += '<td>'+data.patient_summary.ref_cursor7[i].rr+'</td>';
			vital_table_body += '<td>'+data.patient_summary.ref_cursor7[i].spo2+'</td>';
			vital_table_body += '<td>'+data.patient_summary.ref_cursor7[i].height+'</td>';
			vital_table_body += '<td>'+data.patient_summary.ref_cursor7[i].weight+'</td>';
			vital_table_body += '<td>'+data.patient_summary.ref_cursor7[i].bmi+'</td>';
			vital_table_body += '</tr>';
		}
		$j('#tblListOfRecentVitalSign').append(vital_table_body);
	}else{
		$j('#vital_sign_div').show();
		var vitalHtml = "<tr ><td colspan='10'><h6>No Record Found !!</h6></td></tr>";
		$j('#tblListOfRecentVitalSign').append(vitalHtml);
	}
    var recentLabFlag = false;
	if(most_recent_lab_results_length > 0){
		recentLabFlag = true;
		$j('#most_recent_lab_results_div').show();
		var lab_results_div = '';
		for(var i=0;i<most_recent_lab_results_length;i++){
			var ridcId = data.patient_summary.ref_cur3[i].ridc_id;
			lab_results_div += '<tr id='+data.patient_summary.ref_cur3[i].ridc_id+'><td>'+(i+1)+'</td>';
			lab_results_div += '<td>'+data.patient_summary.ref_cur3[i].investigation_date+'</td>';
			lab_results_div += '<td>'+data.patient_summary.ref_cur3[i].investigation_name+'</td>';
			lab_results_div += '<td>'+data.patient_summary.ref_cur3[i].uom_name+'</td>';
			lab_results_div += '<td>'+data.patient_summary.ref_cur3[i].result+'</td>';
			if(ridcId.trim() != ''){
				lab_results_div += "<td><button class='btn btn-primary' type='button' name='btnReport' id='btnReport'  onClick='printInvestigationSlip(this)'>View</button></td></tr>";
			}else{
				lab_results_div += '<td></td>';
			}
			
		}
		$j('#most_recent_lab_results').append(lab_results_div);
		
	}

	if(most_recent_imaging_results_length >0){
		//var imaging_result_detail = data.patient_summary.ref_cur3
		var radio_flag = false;
		var lab_flag = false;
		var imaging_data = '';
		var lab_data = '';
		var m = 0;
		var n = 0;
		for(var j=0;j<most_recent_imaging_results_length;j++){
			
			if(data.patient_summary.ref_cursor8[j].investigation_type == 'Radio'){
				m++
				radio_flag = true;
				var ridcId = data.patient_summary.ref_cursor8[j].ridc_id;
				imaging_data += '<tr id='+data.patient_summary.ref_cursor8[j].ridc_id+'>';
				imaging_data += '<td>'+ (m) +'</td>';
				imaging_data += '<td>'+ data.patient_summary.ref_cursor8[j].order_id +'</td>';
				imaging_data += '<td>'+ data.patient_summary.ref_cursor8[j].investigation_date +'</td>';
				imaging_data += '<td>'+ data.patient_summary.ref_cursor8[j].investigation_name +'</td>';
				imaging_data += '<td><div class="p-10">'+ data.patient_summary.ref_cursor8[j].result +'</div></td>';
				if(ridcId.trim() != ''){
					imaging_data += "<td><button class='btn btn-primary' type='button' name='btnReport' id='btnReport'  onClick='printInvestigationSlip(this)'>View</button></td>";
				}else{
					imaging_data += '<td></td>';
				}
				imaging_data += '</tr>';
			}
			if(data.patient_summary.ref_cursor8[j].investigation_type == 'Lab'){
				n++;
				lab_flag = true;
				var ridcId = data.patient_summary.ref_cursor8[j].ridc_id;
				lab_data += '<tr id='+data.patient_summary.ref_cursor8[j].ridc_id+'>';
				lab_data += '<td>'+ (n) +'</td>';
				lab_data += '<td>'+ data.patient_summary.ref_cursor8[j].order_id +'</td>';
				lab_data += '<td>'+ data.patient_summary.ref_cursor8[j].investigation_date +'</td>';
				lab_data += '<td>'+ data.patient_summary.ref_cursor8[j].investigation_name +'</td>';
				lab_data += '<td>'+ data.patient_summary.ref_cursor8[j].result +'</td>';
				if(ridcId.trim() != ''){
					lab_data += "<td><button class='btn btn-primary' type='button' name='btnReport' id='btnReport'  onClick='printInvestigationSlip(this)'>View</button></td>";	
				}else{
					lab_data += '<td></td>';
				}
				
				lab_data += '</tr>';
			}
		}
		if(radio_flag){
			$j('#most_recent_imaging_results_div').show();	
			$j('#most_recent_imaging_results').append(imaging_data);	
		}else{
			$j('#most_recent_imaging_results_div').show();	
			var imgHtml = "<tr ><td colspan='5'><h6>No Record Found !!</h6></td></tr>";
			$j('#most_recent_imaging_results').append(imgHtml);	
		}
		if(lab_flag){
			$j('#most_recent_lab_results_div').show();	
			$j('#most_recent_lab_results').append(lab_data);	
		}else{
			if(!recentLabFlag){
				$j('#most_recent_lab_results_div').show();	
				var labHtml = "<tr ><td colspan='5'><h6>No Record Found !!</h6></td></tr>";
				$j('#most_recent_lab_results').append(labHtml);	
			}
		}
	}else{
		$j('#most_recent_imaging_results_div').show();	
		var imgHtml = "<tr ><td colspan='5'><h6>No Record Found !!</h6></td></tr>";
		$j('#most_recent_imaging_results').append(imgHtml);	
		
		if(!recentLabFlag){
			$j('#most_recent_lab_results_div').show();	
			var labHtml = "<tr ><td colspan='5'><h6>No Record Found !!</h6></td></tr>";
			$j('#most_recent_lab_results').append(labHtml);	
		}
	}

	if(current_medical_problem_length > 0){
		$j('#current_medical_problem_div').show();
		var medical_problem_div = '';
		for(var i=0;i<current_medical_problem_length;i++){
			medical_problem_div += '<tr><td>'+(i+1)+'</td>';
			medical_problem_div += '<td>'+data.patient_summary.ref_cursor9[i].visit_date+'</td>';
			medical_problem_div += '<td>'+data.patient_summary.ref_cursor9[i].icd_name+'</td>';
			
		}
		$j('#current_medical_problem').append(medical_problem_div);
		
	}else{
		$j('#current_medical_problem_div').show();
		var medicalHtml = "<tr ><td colspan='3'><h6>No Record Found !!</h6></td></tr>";
		$j('#current_medical_problem').append(medicalHtml);	
	}
 	
	if(current_medication_length > 0){
		$j('#current_medications_div').show();
		var medication_table_body = '';
		var medication_detail_array = data.patient_summary.ref_cursor10;
		for(var i=0;i<current_medication_length;i++){
			medication_table_body += '<tr>';
			medication_table_body += '<td>'+ (i+1) +'</td>';
			medication_table_body += '<td>'+data.patient_summary.ref_cursor10[i].item_name+'</td>';
			medication_table_body += '<td>'+data.patient_summary.ref_cursor10[i].dosage+'</td>';
			medication_table_body += '<td>'+data.patient_summary.ref_cursor10[i].frequency+'</td>';
			medication_table_body += '<td>'+data.patient_summary.ref_cursor10[i].no_of_days+'</td>';
			medication_table_body += '<td>'+data.patient_summary.ref_cursor10[i].status+'</td>';
			medication_table_body += '</tr>';
		}
		$j('#current_medications').append(medication_table_body);
	}else{
		$j('#current_medications_div').show();
		var medicationsHtml = "<tr ><td colspan='6'><h6>No Record Found !!</h6></td></tr>";
		$j('#current_medications').append(medicationsHtml);	 
	}
	
	global_visit_array = data.visit_array;
	getVisitSummary();
	//iterateVisitArray(global_visit_array);
	/* for(var m=0;m<global_visit_array.length;m++){
		getVisitSummary(encounter_index);
		global_visit_index++;
		encounter_index++;
	} */
	
	/* $j('#Most_Recent_lab_results').val(patient_summary.most_recent_lab_results);
	$j('#Most_Recent_imaging_results').val(patient_summary.most_recent_imaging_results);	
	$j('#Current_medical_problems').val(patient_summary.current_medical_problems); */

}
/* var m = 0;
function iterateVisitArray(global_visit_array){
	setTimeout(function () {  
		  getVisitSummary(encounter_index);
		  global_visit_index++;
		  encounter_index++;  
	      m++;                   
	      if (m < global_visit_array.length) {          
	    	  iterateVisitArray(global_visit_array); 
	      }                      
	   }, 300)
} */

//main_div

	function mapVisitSummary(data, index1) {
		//alert("data");
		var icd_diagnosis = '';
		
 		var total_encounter_data = '';
		if(data.visit_summary == undefined){
			return;
		}
		var encounter_detail = data.visit_summary.encounter_details;
		var current_medication = data.visit_summary.current_medication;
		var recommended_advice = data.visit_summary.recommended_advice;
		var nursing_care = data.visit_summary.nursing_care;
		var plan_details = data.visit_summary.plan_details;
		var implant_history = data.visit_summary.implant_history;
		var immunization_history = data.visit_summary.immunization_history;
		var disposal = data.visit_summary.disposal;
		for(var i=0;i<encounter_detail.length;i++){
			//console.log("encounter_index "+index1);
			icd_diagnosis = encounter_detail[i].icd_diagnosis;
			icd_diagnosis=icd_diagnosis.replace(/^\[([\s\S]*)]$/,'$1');
			var icd_diagnosis_length=icd_diagnosis.length;
			var en_detail_timeline ='<div class="enTimeline-item"><div class="enTimeline-panel"> <div class="enTimeline-box">'+
            '<span class="arrow"></span><span class="enTimeline-icon"><i class="fa fa-dot-circle"></i></span>'+
            '<h4 class="enTimeline-head">Encounter No: '+encounter_detail[i].encounter_no+'</h4><div class="row"><div class="col-md-3"><div class="form-group row">'+
			'<label class="col-sm-6 col-form-label">Encounter Type:</label>'+
			'<label class="col-sm-6 col-form-label">'+encounter_detail[i].encounter_type+'</label></div></div>'+
			'<div class="col-md-3"><div class="form-group row"><label class="col-sm-6 col-form-label">Encounter Date:</label>'+
			'<label class="col-sm-6 col-form-label">'+encounter_detail[i].encounter_date+'</label></div></div>'+
			'<div class="col-md-3"><div class="form-group row"><label class="col-sm-6 col-form-label">Encounter Time:</label>'+
			'<label class="col-sm-6 col-form-label" id="Encounter_Date">'+encounter_detail[i].encounter_time+'</label></div></div>'+
			'<div class="col-md-3 text-right"><a class="btn btn-sm btn-primary" data-toggle="modal" data-backdrop="static" data-target="#exampleModal" onclick="getViewDetail(this)" id="'+index1+'">View Detail</a>'+
			'</div>';
			
			if(icd_diagnosis_length > 0){
				 	
				 en_detail_timeline +='<div class="col-md-9"><div class="form-group row"><label class="col-sm-2 col-form-label">Diagnosis:</label>';
				 en_detail_timeline +='<label class="col-sm-10 col-form-label">'+icd_diagnosis+'</label></div></div>';
			}
			en_detail_timeline +='</div></div><div id="encounter_div'+index1+'" style="display:none;"></div></div>';
			$j('.timeline').append(en_detail_timeline);
		var phoneNo= encounter_detail[i].user_mobile_no == undefined ? '' : encounter_detail[i].user_mobile_no;	
		var en_detail ='<div class="opdMain_detail_area">'+
		'<h4 class="service_htext" data-encounter="'+encounter_detail[i].encounter_no+'">ENCOUNTER DETAILS</h4><div class="row">'+
		'<div class="col-md-4">'+
		'<div class="form-group row">'+
		'<label class="col-sm-6 col-form-label">Encounter Number:</label> <label class="col-sm-6 col-form-label" '+
		'id="Encounter_Number">'+encounter_detail[i].encounter_no+'</label>'+
		'</div>'+
		'</div>'+
		'<div class="col-md-4">'+
		'<div class="form-group row">'+
		'<label class="col-sm-6 col-form-label">Encounter '+
		'Type:</label> <label class="col-sm-6 col-form-label" '+
		'id="Encounter_Type">'+encounter_detail[i].encounter_type+'</label> '+
		'</div> '+
		'</div> '+
		'<div class="col-md-4"> '+
		'<div class="form-group row"> '+
		'<label class="col-sm-6 col-form-label">Encounter '+	
		'Date:</label> <label class="col-sm-6 col-form-label" '+
		'id="Encounter_Date">'+encounter_detail[i].encounter_date+'</label> '+
		'</div> '+
		'</div><div class="col-md-4"><div class="form-group row"> '+
		'<label class="col-sm-6 col-form-label">Encounter '+
		'Time:</label> <label class="col-sm-6 col-form-label" '+
		'id="Encounter_Time">'+encounter_detail[i].encounter_time+'</label></div></div>'+
		'</div></div><div class="opdMain_detail_area"> '+
		'<h4 class="service_htext">ATTENDING PROVIDER DETAILS</h4> '+
		'<div class="row"><div class="col-md-4"><div class="form-group row">'+
		'<label class="col-sm-6 col-form-label">Provider '+
		'Name:</label> <label class="col-sm-6 col-form-label" id="Provider_Name">'+encounter_detail[i].provider_name+'</label>'+
		'</div></div><div class="col-md-4">'+
		'<div class="form-group row">'+
		'<label class="col-sm-6 col-form-label">Location:</label> <label'+
		'class="col-sm-6 col-form-label" id="ATTENDING_Location">'+encounter_detail[i].provider_location+'</label>'+
		'</div></div>'+
		'<div class="col-md-4"><div class="form-group row">'+
		'<label class="col-sm-6 col-form-label">Phone '+
		'Number:</label> <label class="col-sm-6 col-form-label" id="Provider_Name">'+phoneNo+'</label>'+
		'</div></div></div></div>';
		
		//start of subjective block
		if(true){
			var implant_history_div="";
	        if(implant_history.length > 0){
					
					var p = 0;
					var table_row = '';
					
					for(var k=0;k<implant_history.length;k++){					
							p++;
							table_row += '<tr><td>'+(p)+'</td><td>'+implant_history[k].device_id+'</td><td>'+implant_history[k].device_name+'</td><td>'+implant_history[k].date_of_impant+'</td><td>'+implant_history[k].remarks+'</td></tr>';
							
					}
					implant_history_div = '<div id="implant_history_table_div"> '+
					'<div class=""> '+
					'<h6 class="font-weight-bold text-theme">'+
					'Implant History <label class="col-sm-6 col-form-label"'+
					'id="implant_history"></label>'+
					'</h6>'+
					'<table class="table table-hover table-striped table-bordered">'+
					'<thead>'+
					'<tr>'+
					'<th>S.No.</th>'+
					'<th>Device ID</th>'+
					'<th>Device Name</th>'+
					'<th>Date of Implant</th>'+
					'<th>Remarks</th>'+
					'</tr>'+
					'</thead>'+
					'<tbody id="implant_history_table">'+ table_row + '</tbody>'+
					'</table>'+
					'</div>'+
					'</div>';
									
				}

	        var immunization_history_div="";
	        if(immunization_history.length > 0){
					
					var p = 0;
					var table_row = '';
					
					for(var k=0;k<immunization_history.length;k++){					
							p++;
							table_row += '<tr><td>'+(p)+'</td><td>'+immunization_history[k].immunization_name+'</td><td>'+immunization_history[k].prescription_date+'</td><td>'+immunization_history[k].immunization_date+'</td><td>'+immunization_history[k].duration+'</td><td>'+immunization_history[k].next_due_date+'</td></tr>';
							
					}
					immunization_history_div = '<div id="immunization_history_div"> '+
					'<div class=""> '+
					'<h6 class="font-weight-bold text-theme">'+
					'Immunization History <label class="col-sm-6 col-form-label"'+
					'id="immunization_history"></label>'+
					'</h6>'+
					'<table class="table table-hover table-striped table-bordered">'+
					'<thead>'+
					'<tr>'+
					'<th>S.No.</th>'+
					'<th>Immunization Name</th>'+
					'<th>Immunization prescribed on</th>'+
					'<th>Immunization Date</th>'+
					'<th>Duration(Years)</th>'+
					'<th>Next Due Date</th>'+
					'</tr>'+
					'</thead>'+
					'<tbody id="immunization_history_table">'+ table_row + '</tbody>'+
					'</table>'+
					'</div>'+
					'</div>';
									
				}
			en_detail = en_detail +
			'<div class="opdMain_detail_area">'+                                  
			'<h4 class="service_htext">Subjective</h4>'+
			'<div class="row"><div class="col-md-12">'+
			'<div class="form-group row"><div class="col-sm-2">';
			if(encounter_detail[i].encounter_type == 'OPD'){
				en_detail = en_detail + '<label class="col-form-label"><strong>Chief Complaint  </strong></label>';
			}else if(encounter_detail[i].encounter_type == 'ME'){
				en_detail = en_detail + '<label class="col-form-label width300"><strong>Chief Complaint: (Medical Examination) </strong></label>';
			}else if(encounter_detail[i].encounter_type == 'MB'){
				en_detail = en_detail + '<label class="col-form-label width300"><strong>Chief Complaint: (Medical Board) </strong></label>';
			}
			en_detail = en_detail + '</div><div class="col-sm-10">'+
			'<textarea type="text" class="form-control-plaintext" id="chief_complaint" '+	
			'name="chief_complaint" readonly>'+encounter_detail[i].chief_complain+'</textarea></div></div>';
             if(encounter_detail[i].casenote.length > 0){
              en_detail +='<div class="form-group row"><div class="col-sm-2">';
              en_detail +='<label class="col-form-label"><strong>History of Present Illness</strong></label>';
              en_detail +='</div><div class="col-sm-10">';
              en_detail +='<textarea type="text" class="form-control-plaintext" id="present_illness_history"  name="present_illness_history" readonly>'+encounter_detail[i].casenote+'</textarea>';
              en_detail +='</div></div>';
             }
             if(encounter_detail[i].past_medical_history.length > 0){
              en_detail +='<div class="form-group row"><div class="col-sm-2">';
              en_detail +='<label class="col-form-label"><strong>Past Medical History  </strong></label>';
              en_detail +='</div><div class="col-sm-10">';
              en_detail +='<textarea type="text" class="form-control-plaintext" id="past_medical_history"  name="past_medical_history" readonly>'+encounter_detail[i].past_medical_history+'</textarea>';
              en_detail +='</div></div>';
             }
             if(encounter_detail[i].past_surgical_history.length > 0){
              en_detail +='<div class="form-group row"><div class="col-sm-2">';
              en_detail +='<label class="col-form-label"><strong>Past Surgeries  </strong></label>';
              en_detail +='</div><div class="col-sm-10">';
              en_detail +='<textarea type="text" class="form-control-plaintext" id="past_surgeries"  name="past_surgeries" readonly>'+encounter_detail[i].past_surgical_history+'</textarea>';
              en_detail +='</div></div>';
		    }			
			if(encounter_detail[i].medication_history.length > 0){
			 en_detail +='<div class="form-group row"><div class="col-sm-2">';
			 en_detail +='<label class="col-form-label"><strong>Medication History  </strong></label>';
			 en_detail +='</div><div class="col-sm-10">';
			 en_detail +='<textarea type="text" class="form-control-plaintext" id="medical_history"  name="medical_history" readonly>'+encounter_detail[i].medication_history+'</textarea>';
			 en_detail +='</div></div>';
			}
			if(encounter_detail[i].social_history.length > 0){
			 en_detail +='<div class="form-group row"><div class="col-sm-2">';
			 en_detail +='<label class="col-form-label"><strong>Personal & Social History  </strong></label>';
			 en_detail +='</div><div class="col-sm-10">';
			 en_detail +='<textarea type="text" class="form-control-plaintext" id="social_history"  name="social_history" readonly>'+encounter_detail[i].social_history+'</textarea>';
			 en_detail +='</div></div>';
			}
			if(encounter_detail[i].family_history.length > 0){
			 en_detail +='<div class="form-group row"><div class="col-sm-2">';
			 en_detail +='<label class="col-form-label"><strong>Family History  </strong></label></div>';
			 en_detail +='<div class="col-sm-10">';
			 en_detail +='<textarea type="text" class="form-control-plaintext" id="family_history"  name="family_history" readonly>'+encounter_detail[i].family_history+'</textarea>';
			 en_detail +='</div></div>';
			}
			if(encounter_detail[i].allergy_history.length > 0){
			 en_detail +='<div class="form-group row"><div class="col-sm-2">';
			 en_detail +='<label class="col-form-label"><strong>Allergy History  </strong></label>';
			 en_detail +='</div><div class="col-sm-10">';
			 en_detail +='<textarea type="text" class="form-control-plaintext" id="allergy_history"  name="allergy_history" readonly>'+encounter_detail[i].allergy_history+'</textarea>';
			 en_detail +='</div></div>';
			}
			en_detail +=implant_history_div;			
			en_detail +=immunization_history_div;			
			en_detail +='</div></div></div></div>';

			
		}
		//end of subjective block
		//start of OBJECTIVE block
		if(true){
		
			var temp = encounter_detail[i].temperature.trim();
			var pulse = encounter_detail[i].pulse.trim();
			var bp = encounter_detail[i].blood_pressure.trim();
			var rr = encounter_detail[i].respiratary_rate.trim();
			var spo2 = encounter_detail[i].spo2.trim();
			var height = encounter_detail[i].height.trim();
			var weight = encounter_detail[i].weight.trim();
			var bmi = encounter_detail[i].bmi.trim();
			
			if(temp != '' && pulse != '' && bp != '/' && bp != ''  && rr != '' && spo2 != '' && height != '' && weight != '' && bmi != ''){
				
				en_detail = en_detail +
				'<div class="opdMain_detail_area">'+                                      
				'<h4 class="service_htext">Objective </h4>'+
				'<div class="row">'+
				'<div class="col-md-4">'+
				'<div class="form-group row">'+
				'<div class="col-sm-6">'+
				'<label class="col-form-label"><strong>Temperature(F)</strong></label>'+
				'</div>'+
				'<div class="col-sm-6">'+
				'<input type="text" class="form-control-plaintext" id="temperature"	name="temperature" value="'+encounter_detail[i].temperature+'" readonly>'+
				'</div>'+
				'</div>'+
				'</div>'+
				'<div class="col-md-4">'+
				'<div class="form-group row">'+
				'<div class="col-sm-6">'+
				'<label class="col-form-label"><strong>Pulse(/min)</strong></label>'+
				'</div>'+
				'<div class="col-sm-6">'+
				'<input type="text" class="form-control-plaintext" id="pulse"	name="pulse" value="'+encounter_detail[i].pulse+'" readonly>'+
				'</div>'+
				'</div>'+
				'</div>'+
				'<div class="col-md-4">'+
				'<div class="form-group row">'+
				'<div class="col-sm-6">'+
				'<label class=" col-form-label"><strong>BP(mmHg)</strong></label>'+
				'</div>'+
				'<div class="col-sm-6">'+								
				'<input type="text" class="form-control-plaintext" id="bp" name="bp" value="'+encounter_detail[i].blood_pressure+'" readonly>'+
				'</div>'+
				'</div>'+
				'</div>'+  
				'<div class="col-md-4">'+
				'<div class="form-group row">'+
				'<div class="col-sm-6">'+
				'<label class=" col-form-label"><strong>RR(/min)</strong></label>'+
				'</div>'+
				'<div class="col-sm-6">'+								
				'<input type="text" class="form-control-plaintext" id="rr_min" name="rr_min" value="'+encounter_detail[i].respiratary_rate+'" readonly>'+
				'</div>'+
				'</div>'+
				'</div>'+
				'<div class="col-md-4">'+
				'<div class="form-group row">'+
				'<div class="col-sm-6">'+
				'<label class="col-form-label"><strong>SpO2(%)</strong></label>'+
				'</div>'+
				'<div class="col-sm-6">'+
				'<input type="text" class="form-control-plaintext" id="spo2" name="sop2" value="'+encounter_detail[i].spo2+'" readonly>'+
				'</div>'+
				'</div>'+
				'</div>'+
				'<div class="col-md-4">'+
				'<div class="form-group row">'+
				'<div class="col-sm-6">'+
				'<label class="col-form-label"><strong>Height(cm)</strong></label>'+
				'</div>'+
				'<div class="col-sm-6">'+
				'<input type="text" class="form-control-plaintext" id="height"	name="height" value="'+encounter_detail[i].height+'" readonly>'+
				'</div>'+
				'</div>'+
				'</div>'+
				'<div class="col-md-4">'+
				'<div class="form-group row">'+
				'<div class="col-sm-6">'+
				'<label class="col-form-label"><strong>Weight(kg)</strong></label>'+
				'</div>'+
				'<div class="col-sm-6">'+
				'<input type="text" class="form-control-plaintext" id="weight"	name="weight" value="'+encounter_detail[i].weight+'" readonly>'+
				'</div>'+
				'</div>'+
				'</div>'+
				'<div class="col-md-4">'+
				'<div class="form-group row">'+
				'<div class="col-sm-6">'+
				'<label class="col-form-label"><strong>BMI(kg/m2)</strong></label>'+
				'</div>'+
				'<div class="col-sm-6">'+
				'<input type="text" class="form-control-plaintext" id="bmi"	name="bmi" value="'+encounter_detail[i].bmi+'" readonly>'+
				'</div>'+
				'</div>'+
				'</div>'+				
				'</div>'+
				'</div>';
			}
		}
		if(encounter_detail[i].ge_pollor != '' || encounter_detail[i].ge_edema != '' || encounter_detail[i].ge_cyanosis != '' || encounter_detail[i].ge_hair_nail != '' ||
				encounter_detail[i].ge_jauindice != '' || encounter_detail[i].ge_lymph_node != '' || encounter_detail[i].ge_clubbing != '' || 
				encounter_detail[i].ge_thyroid != '' || encounter_detail[i].ge_tremors != '' || encounter_detail[i].ge_general_other != '' ||
				encounter_detail[i].se_cns != '' || encounter_detail[i].se_chest_resp != '' || encounter_detail[i].se_musculoskeletal != '' || encounter_detail[i].se_cvs != '' ||
				encounter_detail[i].se_skin != '' || encounter_detail[i].se_gi != '' || encounter_detail[i].se_genito_urinary != '' || encounter_detail[i].se_system_other != '' ||
				encounter_detail[i].se_musculoskeletal != '' || encounter_detail[i].se_musculoskeletal != ''){
			en_detail = en_detail +
			'<div class="opdMain_detail_area">'+                                      
			'<h4 class="service_htext">Patient Examination</h4>';
			//start general examination block
			if(encounter_detail[i].ge_pollor != '' || encounter_detail[i].ge_edema != '' || encounter_detail[i].ge_cyanosis != '' || encounter_detail[i].ge_hair_nail != '' ||
					encounter_detail[i].ge_jauindice != '' || encounter_detail[i].ge_lymph_node != '' || encounter_detail[i].ge_clubbing != '' || 
					encounter_detail[i].ge_thyroid != '' || encounter_detail[i].ge_tremors != '' || encounter_detail[i].ge_general_other != ''){
				en_detail = en_detail +
				'<h6 class="font-weight-bold text-theme"> General Examination</h6>';
				//'<div class="row">'+								
				//'<div class="col-md-12">';
                if(encounter_detail[i].ge_pollor !=''){
                	en_detail = en_detail +'<div class="form-group row">'+
				'<div class="col-sm-2">'+
				'<label class="col-form-label"><strong>Pallor  </strong></label>'+
				'</div>'+
				'<div class="col-sm-10">'+
				'<textarea class="form-control-plaintext" id="pallor" name="pallor"  value="" readonly>'+encounter_detail[i].ge_pollor+'</textarea>'+
				'</div>'+
				'</div>';
                }
				if(encounter_detail[i].ge_edema !=''){
					en_detail = en_detail +'<div class="form-group row">'+
				'<div class="col-sm-2">'+
				'<label class="col-form-label"><strong>Edema</strong></label>'+
				'</div>'+
				'<div class="col-sm-10">'+
				'<textarea class="form-control-plaintext" id="edema" name="edema" value="" readonly>'+encounter_detail[i].ge_edema +'</textarea>'+
				'</div>'+
				'</div>';
				}
				if(encounter_detail[i].ge_cyanosis !=''){
					en_detail = en_detail +'<div class="form-group row">'+
				'<div class="col-sm-2">'+
				'<label class="col-form-label"><strong>Cyanosis </strong></label>'+
				'</div>'+
				'<div class="col-sm-10">'+
				'<textarea class="form-control-plaintext" id="cyanosis" name="cyanosis" value="" readonly>'+encounter_detail[i].ge_cyanosis +'</textarea>'+
				'</div>'+
				'</div>';
				}
				if(encounter_detail[i].ge_hair_nail !=''){
					en_detail = en_detail +'<div class="form-group row">'+
				'<div class="col-sm-2">'+
				'<label class="col-form-label"><strong>Hair/Nail  </strong></label>'+
				'</div>'+
				'<div class="col-sm-10">'+
				'<textarea  class="form-control-plaintext" id="hair" value="" name="hair" readonly>'+encounter_detail[i].ge_hair_nail +'</textarea>'+
				'</div>'+
				'</div>';
				}
				if(encounter_detail[i].ge_jauindice !=''){
					en_detail = en_detail +'<div class="form-group row">'+
				'<div class="col-sm-2">'+
				'<label class="col-form-label"><strong>Icterus  </strong></label>'+
				'</div>'+
				'<div class="col-sm-10">'+
				'<textarea class="form-control-plaintext" id="icterus"	name="icterus" value="" readonly>'+encounter_detail[i].ge_jauindice+'</textarea>'+
				'</div>'+
				'</div>';
				}
				if(encounter_detail[i].ge_lymph_node !=''){
					en_detail = en_detail +'<div class="form-group row">'+
				'<div class="col-sm-2">'+
				'<label class="col-form-label"><strong>Lymph Node </strong></label>'+
				'</div>'+
				'<div class="col-sm-10">'+
				'<textarea class="form-control-plaintext" id="lymph_node" name="lymph_node" value="" readonly>'+encounter_detail[i].ge_lymph_node+'</textarea>'+
				'</div>'+
				'</div>';
				}
				if(encounter_detail[i].ge_clubbing !=''){
					en_detail = en_detail +'<div class="form-group row">'+
				'<div class="col-sm-2">'+
				'<label class="col-form-label"><strong>Clubbing  </strong></label>'+
				'</div>'+
				'<div class="col-sm-10">'+
				'<textarea class="form-control-plaintext" id="clubbing"	name="clubbing" value="" readonly>'+encounter_detail[i].ge_clubbing+'</textarea>'+
				'</div>'+
				'</div>';
				}
				if(encounter_detail[i].ge_thyroid !=''){
					en_detail = en_detail +'<div class="form-group row">'+
				'<div class="col-sm-2">'+
				'<label class="col-form-label"><strong>GCS </strong></label>'+
				'</div>'+
				'<div class="col-sm-10">'+
				'<textarea class="form-control-plaintext" id="gcs"	name="gcs" value="" readonly>'+encounter_detail[i].ge_thyroid+'</textarea>'+
				'</div>'+
				'</div>';
				}
				if(encounter_detail[i].ge_tremors !=''){
					en_detail = en_detail +'<div class="form-group row">'+
				'<div class="col-sm-2">'+
				'<label class="col-form-label"><strong>Tremors  </strong></label>'+
				'</div>'+
				'<div class="col-sm-10">'+
				'<textarea class="form-control-plaintext" id="tremors"	name="tremors" value="" readonly>'+encounter_detail[i].ge_tremors+'</textarea>'+
				'</div>'+
				'</div> ';
				}
				if(encounter_detail[i].ge_general_other !=''){
					en_detail = en_detail +'<div class="form-group row">'+
				'<div class="col-sm-2">'+
				'<label class="col-form-label"><strong>Other  </strong></label>'+
				'</div>'+
				'<div class="col-sm-10">'+
				'<textarea class="form-control-plaintext" id="other"	name="other" value="" readonly>'+encounter_detail[i].ge_general_other +'</textarea>'+
				'</div>'+
				'</div>';
				}
				
			 	
			}
			//end general examination block
			//start patient examination block
			if(encounter_detail[i].se_cns != '' || encounter_detail[i].se_chest_resp != '' || encounter_detail[i].se_musculoskeletal != '' || encounter_detail[i].se_cvs != '' ||
					encounter_detail[i].se_skin != '' || encounter_detail[i].se_gi != '' || encounter_detail[i].se_genito_urinary != '' || encounter_detail[i].se_system_other != '' ||
					encounter_detail[i].se_musculoskeletal != '' || encounter_detail[i].se_musculoskeletal != ''){
				en_detail = en_detail +
				'<h6 class="font-weight-bold text-theme">System Examination</h6>';
				if(encounter_detail[i].se_cns !=''){
				 en_detail = en_detail +'<div class="row">'+								
				'<div class="col-md-12">'+
				'<div class="form-group row">'+
				'<div class="col-sm-2">'+
				'<label class="col-form-label"><strong>CNS  </strong></label>'+
				'</div>'+
				'<div class="col-sm-10">'+
				'<textarea class="form-control-plaintext" id="cns" name="cns"  value=""  readonly>'+encounter_detail[i].se_cns+'</textarea>'+
				'</div>'+
				'</div>';
				}
				if(encounter_detail[i].se_chest_resp !=''){
				  en_detail = en_detail +'<div class="form-group row">'+
				'<div class="col-sm-2">'+
				'<label class="col-form-label"><strong>Chest/Resp</strong></label>'+
				'</div>'+
				'<div class="col-sm-10">'+
				'<textarea class="form-control-plaintext" id="chest_resrp"	name="chest_resrp" value="" readonly>'+encounter_detail[i].se_chest_resp+'</textarea>'+
				'</div>'+
				'</div>';
				}
				if(encounter_detail[i].se_musculoskeletal !=''){
				  en_detail = en_detail +'<div class="form-group row">'+
				'<div class="col-sm-2">'+
				'<label class="col-form-label"><strong>Musculoskeletal </strong></label>'+
				'</div>'+
				'<div class="col-sm-10">'+
				'<textarea class="form-control-plaintext" id="Musculoskeletal"	name="Musculoskeletal" value="" readonly>'+encounter_detail[i].se_musculoskeletal+'</textarea>'+
				'</div>'+
				'</div>';
				}
				if(encounter_detail[i].se_cvs !=''){
					en_detail = en_detail +'<div class="form-group row">'+
				'<div class="col-sm-2">'+
				'<label class="col-form-label"><strong>CVS  </strong></label>'+
				'</div>'+
				'<div class="col-sm-10">'+
				'<textarea class="form-control-plaintext" id="cvs"	name="cvs" value="" readonly>'+encounter_detail[i].se_cvs+'</textarea>'+
				'</div>'+
				'</div>';
				}
				if(encounter_detail[i].se_skin !=''){
					en_detail = en_detail +'<div class="form-group row">'+
				'<div class="col-sm-2">'+
				'<label class="col-form-label"><strong>Skin  </strong></label>'+
				'</div>'+
				'<div class="col-sm-10">'+
				'<textarea class="form-control-plaintext" id="skin"	name="skin" value="" readonly>'+encounter_detail[i].se_skin +'</textarea>'+
				'</div>'+
				'</div>';
				}
				if(encounter_detail[i].se_gi !=''){
					en_detail = en_detail +'<div class="form-group row">'+
				'<div class="col-sm-2">'+
				'<label class="col-form-label"><strong>GI</strong></label>'+
				'</div>'+
				'<div class="col-sm-10">'+
				'<textarea class="form-control-plaintext" id="gi"	name="gi" value="" readonly>'+encounter_detail[i].se_gi+'</textarea>'+
				'</div>'+
				'</div>';
				}
				if(encounter_detail[i].se_genito_urinary !=''){
					en_detail = en_detail +'<div class="form-group row">'+
				'<div class="col-sm-2">'+
				'<label class="col-form-label"><strong>Genito urinary  </strong></label>'+
				'</div>'+
				'<div class="col-sm-10">'+
				'<textarea class="form-control-plaintext" id="genito" name="genito" value="" readonly>'+encounter_detail[i].se_genito_urinary+'</textarea>'+
				'</div>'+
				'</div>';
				}
				if(encounter_detail[i].se_system_other !=''){
					en_detail = en_detail +'<div class="form-group row">'+
				'<div class="col-sm-2">'+
				'<label class="col-form-label"><strong>Other </strong></label>'+
				'</div>'+
				'<div class="col-sm-10">'+
				'<textarea class="form-control-plaintext" id="other" name="other" value="" readonly>'+encounter_detail[i].se_system_other+'</textarea>'+
				'</div>'+
				'</div>';
				}				
				en_detail +='</div></div></div>';
			}
			//end patient examination block
			en_detail = en_detail +'</div></div>';
		}
		
		//start of assessment block
		if(true){
			var icd_diagnosis = '';
			var icd_diagnosis = encounter_detail[i].icd_diagnosis;
			var icd_diagnosis_text = icd_diagnosis.replace(/^\[([\s\S]*)]$/,'$1');
			en_detail = en_detail +
			'<div class="opdMain_detail_area">'+                         
			'<h4 class="service_htext"> Assessment</h4>';
            if(encounter_detail[i].working_diagnosis.length > 0){ 
            	en_detail +='<div class="row">';				
            	en_detail +='<div class="col-md-12">';
            	en_detail +='<div class="form-group row">';
            	en_detail +='<div class="col-sm-3">';
            	en_detail +='<label class="col-form-label"><strong>Provisional Diagnosis</strong></label>';
            	en_detail +='</div>';
            	en_detail +='<div class="col-sm-9">';
            	en_detail +='<textarea class="form-control-plaintext" id="Workingd_diagnosis" name="Workingd_diagnosis" value="" readonly>'+encounter_detail[i].working_diagnosis +'</textarea>';
            	en_detail +='</div>';
            	en_detail +='</div>';
            }
            if(encounter_detail[i].snomed_diagnosis.length > 0){
            	en_detail +='<div class="form-group row">';
            	en_detail +='<div class="col-sm-3">';
            	en_detail +='<label class="col-form-label"><strong> SNOMED Diagnosis</strong></label>';
            	en_detail +='</div>';
            	en_detail +='<div class="col-sm-9">';
            	en_detail +='<textarea class="form-control-plaintext" id="snomed_diagnosis"	name="snomed_diagnosis" value="" readonly>'+encounter_detail[i].snomed_diagnosis+'</textarea>';
            	en_detail +='</div>';
            	en_detail +='</div>';
            }
            if(icd_diagnosis_text.length > 0){
            	en_detail +='<div class="form-group row">';
            	en_detail +='<div class="col-sm-3">';
            	en_detail +='<label class="col-form-label"><strong>ICD Diagnosis</strong></label>';
            	en_detail +='</div>';
            	en_detail +='<div class="col-sm-9">';
            	en_detail +='<textarea style="resize: both;" type="text" class="form-control-plaintext" id="icd_diagnosis" name="icd_diagnosis" readonly>'+icd_diagnosis_text+'</textarea>';
            	en_detail +='</div>';
            	en_detail +='</div>';
            }
            en_detail +='</div>';								
            en_detail +='</div>';
            en_detail +='</div>';
		}
		
		total_encounter_data += en_detail;
		//start of system examination 
		//$j('#container').append(en_detail);
		
		var visit_id = encounter_detail[i].visit_id;
		//return false;
		if(plan_details.length > 0){
				var plan_div =	'<div id="plan_info">'+
				'<div class="opdMain_detail_area">'+
				'<h4 class="service_htext">PLAN</h4>'+
				'<h6 class="font-weight-bold text-theme">Investigation advised</h6>';
				
				
			var p = 0;
			var p1 = 0;
			var table_row = '';
			var table_row1 = '';
			var flag1 = false;
			var labFlag = false;
			var imgFlag = false;
			var type='';
			
			for(var j=0;j<plan_details.length;j++){
				
				var v_id = plan_details[j].visit_id;
				if(visit_id == v_id){	
						flag1 = true;
						type=plan_details[j].investigation_type;
						if(plan_details[j].investigation_type=='Lab' ){
							labFlag = true;
							p++;	
						var ridcId = plan_details[j].ridc_id;
						table_row += '<tr id='+plan_details[j].ridc_id+'><td>'+(p)+'</td><td>'+plan_details[j].investigation_name+'</td><td>'+plan_details[j].investigation_date+'</td><td>'+plan_details[j].result+'</td>';
						if(ridcId.trim() != ''){
							table_row += "<td><button class='btn btn-primary' type='button' name='btnReport' id='btnReport'  onClick='printInvestigationSlip(this)'>View</button></td></tr>";	
						}else{
								table_row += '<td></td>';
							}
						}	
						
						if(plan_details[j].investigation_type=='Radio'){
							imgFlag = true;
							p1++;
							var ridcId = plan_details[j].ridc_id;
							table_row1 += '<tr id='+plan_details[j].ridc_id+'><td>'+(p1)+'</td><td>'+plan_details[j].investigation_name+'</td><td>'+plan_details[j].investigation_date+'</td><td>'+plan_details[j].result+'</td>';
							if(ridcId.trim() != ''){
								table_row1 +=  "<td><button class='btn btn-primary' type='button' name='btnReport' id='btnReport'  onClick='printInvestigationSlip(this)'>View</button></td></tr>";
							}else{
								table_row1 += '<td></td>';
							}
							
						}
							        
												
				}
			}

			if(labFlag){
				plan_div = plan_div +	
				'<div id="investigation_table_div" id="lab">'+	
				'<h6 class="font-weight-bold text-theme">Laboratory</h6>'+		
				'<table class="table table-hover table-striped table-bordered">'+
				'<thead>'+
				'<tr>'+
				'<th>S.No.</th>'+
				/* '<th>Investigation Type</th>'+ */					
				'<th>Investigation Name</th>'+
				'<th>Investigation Date</th>'+
				'<th>Result</th>'+
				'<th>Report</th>'+
				'</tr>'+
				'</thead>'+
				'<tbody id="investigation_table">'+
				'</tbody>'+ table_row +
				'</table></div>';
			    }	
                if(imgFlag){
				plan_div = plan_div +	
				'<div id="investigation_table_div" id="imaging">'+	
				'<h6 class="font-weight-bold text-theme">Imaging</h6>'+			
				'<table class="table table-hover table-striped table-bordered">'+
				'<thead>'+
				'<tr>'+
				'<th>S.No.</th>'+
				/* '<th>Investigation Type</th>'+ */					
				'<th>Investigation Name</th>'+
				'<th>Investigation Date</th>'+
				'<th>Result</th>'+
				'<th>Report</th>'+
				'</tr>'+
				'</thead>'+
				'<tbody id="investigation_table">'+
				'</tbody>'+ table_row1 +
				'</table></div>';
                }
                
				if(flag1){
					total_encounter_data += plan_div;
					//$j('#container').append(plan_div);
					//$j('#container').append(plan_table);
				}
					
			
		}
		
		if(current_medication.length > 0){
			var p = 0;
			var table_row = '';
			var flag2 = false;
			for(var k=0;k<current_medication.length;k++){					
				var v_id = current_medication[k].visit_id;
				if(visit_id == v_id){
					flag2 = true;
					p++;
					table_row += '<tr><td>'+(p)+'</td><td>'+current_medication[k].item_name+'</td><td>'+current_medication[k].dosage+'</td><td>'+current_medication[k].frequency+'</td><td>'+current_medication[k].no_of_days+'</td></tr>'
				}
			}
			var cur_medication = '<div id="current_medication_table_div"> '+
			'<div class=""> '+
			'<h6 class="font-weight-bold text-theme">'+
			'Current Medication <label class="col-sm-6 col-form-label"'+
			'id="Current_Medication"></label>'+
			'</h6>'+
			'<table class="table table-hover table-striped table-bordered">'+
			'<thead>'+
			'<tr>'+
			'<th>S.No.</th>'+
			'<th>Item name</th>'+
			'<th>Dosage</th>'+
			'<th>Frequency</th>'+
			'<th>No of days</th>'+
			'</tr>'+
			'</thead>'+
			'<tbody id="current_medication_table">'+ table_row + '</tbody>'+
			'</table>'+
			'</div>'+
			'</div>';
			if(flag2){
				total_encounter_data += cur_medication;
				//$j('#container').append(cur_medication);	
			}
				
		}

		
			if(nursing_care.length > 0){
			var nursing_table = '';
			var physio_table = '';
			var surgery_table = '';
			var injection_table = '';
			var n = 0;
			var p = 0;
			var s = 0;
			var i = 0; 
				for(l=0;l<nursing_care.length;l++){					
				var v_id = nursing_care[l].visit_id;
				if(visit_id == v_id){		
					if(nursing_care[l].nursing_flag == 'N'){
						n++;
						nursing_table = nursing_table + '<tr><td>'+n+'</td><td>'+nursing_care[l].name+'</td><td>'+nursing_care[l].frequency+'</td><td>'+nursing_care[l].no_of_days+'</td><td>'+nursing_care[l].remarks+'</td></tr>';
					}
					
					if(nursing_care[l].nursing_flag == 'I'){
						i++;
						injection_table = injection_table + '<tr><td>'+i+'</td><td>'+nursing_care[l].name+'</td><td>'+nursing_care[l].dosage+'</td><td>'+nursing_care[l].route+'</td><td>'+nursing_care[l].frequency+'</td><td>'+nursing_care[l].no_of_days+'</td><td>'+nursing_care[l].remarks+'</td></tr>';
					}
					
					if(nursing_care[l].nursing_flag == 'P'){
						p++;
						physio_table = physio_table + '<tr><td>'+p+'</td><td>'+nursing_care[l].name+'</td><td>'+nursing_care[l].start_date+'</td><td>'+nursing_care[l].frequency+'</td><td>'+nursing_care[l].no_of_days+'</td><td>'+nursing_care[l].remarks+'</td></tr>';
					}
					
					if(nursing_care[l].nursing_flag == 'M'){
						s++;
						surgery_table = surgery_table + '<tr><td>'+s+'</td><td>'+nursing_care[l].name+'</td><td>'+nursing_care[l].typeof_anest+'</td><td>'+nursing_care[l].remarks+'</td></tr>';
					}
					
					}						
					
				} 
				if(nursing_table != ''){
				var nurs_care =  '<div id="nursing_care_table_div">'+
				'<div class="">'+
				'<h6 class="font-weight-bold text-theme">Nursing Care <label class="col-sm-6 col-form-label"'+
				'id="Nursing_Care"></label></h6>'+
				'<table class="table table-hover table-striped table-bordered">'+
				'<thead><tr><th>S.No.</th><th>Nursing care name</th>'+
				'<th>Frequency</th>'+
				'<th>No of days</th>'+
				'<th>Remarks</th></tr></thead>'+
				'<tbody id="nursing_care_table">'+nursing_table+'</tbody>'+
				'</table></div>';
				total_encounter_data += nurs_care;
				//$j('#container').append(nurs_care);			
			}
								
			if(injection_table != ''){
				var injection_detail =	'<div id="injection_table_div "><div class="">'+
				'<table class="table table-hover table-striped table-bordered">'+
				'<thead><tr><th>S.No.</th>'+
				'<th>Nursing care Injection name</th>'+
				'<th>Dosage(ml)</th><th>Route</th>'+
				'<th>Frequency</th><th>No of days</th>'+
				'<th>Remarks</th></tr></thead>'+
				'<tbody"injection_table">'+injection_table+'</tbody>'+
				'</table></div></div>';	
				
				total_encounter_data += injection_detail;
				//$j('#container').append(injection_detail);
			}
								
			if(physio_table != ''){
				var physio_detail = '<div id="physiotherapy_table_div">'+
				'<div class="">'+
				'<h6 class="font-weight-bold text-theme">'+
				'Physiotherapy Details <label class="col-sm-6 col-form-label"'+
				'id="Physiotherapy_Details"></label>'+
				'</h6><table class="table table-hover table-striped table-bordered">'+
				'<thead><tr>'+
				'<th>S.No.</th>'+
				'<th>Physiotherapy name</th>'+
				'<th>Physiotherapy date</th>'+
				'<th>Frequency</th>'+
				'<th>No of days</th>'+
				'<th>Remarks</th>'+
				'</tr>'+
				'</thead>'+
				'<tbody id="physiotherapy_table">' + physio_table + '</tbody>'+
				'</table>'+
				'</div>'+
				'</div></div>';
				
				total_encounter_data += physio_detail;
				//$j('#container').append(physio_detail);
			}
								
			if(surgery_table != ''){
				var surgery_detail = '<div id="surgery_table_div">'+
				'<div class="">'+
				'<h6 class="font-weight-bold text-theme">'+
				'Minor Surgery Details <label class="col-sm-6 col-form-label"'+
				'id="Minor_Surgery_Details"></label>'+
				'</h6>'+
				'<table class="table table-hover table-striped table-bordered">'+
				'<thead><tr>'+
				'<th>S.No.</th>'+
				'<th>Minor Surgery name</th>'+
				'<th>Type of anesthesia</th>'+
				'<th>Remarks</th>'+
				'</tr></thead>'+
				'<tbody id="surgery_table">'+
				''+surgery_table+''+
				'</tbody></table>'+
				'</div></div>';
				
				total_encounter_data += surgery_detail;
				//$j('#container').append(surgery_detail);
			
			}   
		}
								 	
		if(recommended_advice.length > 0){
			var referingDetail = '';
			for(var m=0;m<recommended_advice.length;m++){
				var v_id = recommended_advice[m].visit_id;
				if(visit_id == v_id){
					referingDetail += '<tr>';
					referingDetail += '<td>'+ (m+1) +'</td>';
					referingDetail += '<td>'+ recommended_advice[m].hospital_name +'</td>';
					referingDetail += '<td>'+ recommended_advice[m].speciality +'</td>';
					referingDetail += '<td>'+ recommended_advice[m].diagonsys +'</td>';
					referingDetail += '<td>'+ recommended_advice[m].instruction +'</td>';
					referingDetail += '</tr>';
					
				}
			}
			


			if(current_medication.length > 0){
				var recommended_medical_advice_div='';
				var recommended_medical_advice = '';
				for(var k=0;k<current_medication.length;k++){					
					var v_id = current_medication[k].visit_id;
					if(visit_id == v_id){
						recommended_medical_advice = current_medication[k].other_treatment;
						
					}
				}
			recommended_medical_advice_div = '<div id="recommended_medical_advice_div"> '+
			'<div class="form-group row"><div class="col-sm-2">'+
			'<h6 class="font-weight-bold text-theme">Recommended Medical Advice</h6>'+
			'</div><div class="col-sm-10">'+
			'<textarea type="text" class="form-control-plaintext" id="medical_advice"  name="medical_advice" readonly>'+recommended_medical_advice+'</textarea>'+
			'</div></div>'
				total_encounter_data += recommended_medical_advice_div;
				
					
			}
            
			
			var ref_Detail = '<div id="referral_table_div">'+
			'<div class="row"> <div class="col-12">'+
			'<h6 class="font-weight-bold text-theme">Referral Details</h6>'+
			'<table class="table table-hover table-striped table-bordered">'+
			'<thead><tr><th>S.No.</th><th>Hospital Name</th>'+
			'<th>Department/Speciality</th>'+
			'<th>Diagnosis</th>'+
			'<th>Instruction</th>'+
			'</tr></thead>'+
			'<tbody id="referral_table">'+ referingDetail +
			'</tbody></table></div></div>'+
			'</div>';
			
			total_encounter_data += ref_Detail;

			
			//$j('#container').append(rec_advice);
			
		}

		var disposalDiv='';	
		if(disposal.length > 0){
						
						for(var m=0;m<disposal.length;m++){
							disposalDiv += '<tr>';
							disposalDiv += '<td>'+ (m+1) +'</td>';
							disposalDiv += '<td>'+ disposal[m].disposal_name +'</td>';
							disposalDiv += '<td>'+ disposal[m].disposal_days +'</td>';					
							disposalDiv += '</tr>';
							
		 }
						var disposal_Detail = '<div id="disposal_table_div">'+
						'<div class="row"> <div class="col-12">'+
						'<h6 class="font-weight-bold text-theme">Disposal</h6>'+
						'<table class="table table-hover table-striped table-bordered">'+
						'<thead><tr><th>S.No.</th>'+
						'<th>Disposal</th>'+
						'<th>No. of Days/Hours</th>'+
						'</tr></thead>'+
						'<tbody id="disposal_table">'+ disposalDiv +
						'</tbody></table></div></div>'+
						'</div>';
						
						total_encounter_data += disposal_Detail;			 	
		}
		
		$j('#encounter_div'+index1+'').empty();
		$j('#encounter_div'+index1+'').append(total_encounter_data);
		//console.log("encounter wise data "+total_encounter_data);
		total_encounter_data = '';
		//$j('#container').append(data);
		//console.log("encounter_data "+)
		}
		
		/* var current_medication = data.visit_summary.current_medication;
		var encounter_details = data.visit_summary.encounter_details;
		var recommended_advice = data.visit_summary.recommended_advice;
		var nursing_care = data.visit_summary.nursing_care;
		var plan_details = data.visit_summary.plan_details;
		for (var i = 0; i < 1; i++) {
			var visit_id = encounter_details[i].visit_id;
			//for plan_detail

			$j('#plan_info').hide();
			var plan_detail_flag = true;
			for (var j = 0; j < plan_details.length; j++) {
				var v_id = plan_details[j].visit_id;
				var table_row = '';
				if (visit_id == v_id) {
					$j('#plan_info').show();
					plan_detail_flag = false;
					table_row = '<tr><td>' + (j + 1) + '</td><td>'
							+ plan_details[j].investigation_type + '</td><td>'
							+ plan_details[j].investigation_date + '</td><td>'
							+ plan_details[j].investigation_name + '</td></tr>';
					$j('#investigation_table').append(table_row);
				}

			}
			if (plan_detail_flag == true) {
				$j('#investigation_table_div').hide();
			}
			var current_medication_flag = true;
			for (var k = 0; k < current_medication.length; k++) {
				var v_id = current_medication[k].visit_id;
				var table_row = '';
				if (visit_id == v_id) {
					$j('#plan_info').show();
					current_medication_flag = false;
					table_row = '<tr><td>' + (k + 1) + '</td><td>'
							+ current_medication[k].item_name + '</td><td>'
							+ current_medication[k].dosage + '</td><td>'
							+ current_medication[k].frequency + '</td><td>'
							+ current_medication[k].no_of_days + '</td></tr>';
					$j('#current_medication_table').append(table_row);
				}
			}
			if (current_medication_flag == true) {
				$j('#current_medication_table_div').hide();
			}
		} */		
		
			//$.scrollTo($('h4[data-encounter]:last-of-type').offset().top - 100);
	}
	
	function getViewDetail(item){
		var btn_id = item.id;
		$j('#container').empty();
		encounter_data = $j('#encounter_div'+btn_id+'').html();
		//console.log("encounter_data "+encounter_data);
		$j('#container').append(encounter_data);
		var encounter_data = '';
	}
	
	function printInvestigationSlip(item){
		var ridcId = $(item).closest('tr').attr('id');
		if(ridcId.trim() == ''){
			alert("No Document Found");
			return;
		}
		viewDocumentForDigi(ridcId);
	}
</script>
<body>
 <!-- Begin page -->
    <div id="wrapper">
			<div class="content-page">
				<!-- Start content -->
						<div class="">
							<div class="container-fluid">
				
								<div class="internal_Htext" align="center">Electronic Health
									Record</div>
								<!-- end row -->
				
								<div class="row">
								<input type="hidden" name="ehrFlag" id="ehrFlag" value="ehrFlag"/>
									<div class="col-12">
										<div class="card">
											<div class="card-body">
												
												
											<%-- 	<form name="frm"> --%>
												<div class="opdMain_detail_area">                                       
	                                     			<h4 class="service_htext"> Patient Summary</h4>
													<div class="row">
														<div class="col-md-4"></div>
														<div class="col-md-4">
			
															<div class="form-group row">
																<div class="col-sm-12 text-center">
																	<img src="/AshaWeb/resources/images/photo_icon.png" alt=""
																		class="rounded-circle" height="100%">
																</div>
			
															</div>
			
														</div>
			
														<div class="col-md-4">
															<div class="form-group row">
																<div class="col-sm-12 text-right">
																<button class="btn btn-success" onclick="generateReport()"> Download EHR</button>
																
																<!-- <button class="btn btn-success" id="fullEhr" onclick="generateCompleteReport()"> Download Complete EHR</button> -->
																</div>
			
															</div>
														</div>
														
														<div class="ehr_photo"></div>
														<div class="col-md-4">
															<div class="form-group row">
																<div class="col-sm-6">
																	<label class="col-form-label"><strong>Document
																			ID</strong></label>
																</div>
																<!-- <label class="col-sm-6 col-form-label" id="Document_ID"></label> -->
																<div class="col-sm-6">
																	<input type="text" class="  form-control-plaintext" id="Document_ID" value=""	name="Document_ID" readonly>
																</div>
															</div>
														</div>
			
														<div class="col-md-4">
															<div class="form-group row">
																<div class="col-sm-6">
																	<label class="col-form-label"><strong>Generated
																			Date</strong></label>
																</div>
																<div class="col-sm-6">
																	<input type="text" class="form-control-plaintext" id="Generated_Date"	name="Generated_Date" readonly>
																</div>
															</div>
														</div>
														<div class="col-md-4">
															<div class="form-group row">
																<div class="col-sm-6">
																	<label class="col-form-label"><strong>Generated
																			Time</strong></label>
																</div>
																<div class="col-sm-6">
																	<input type="text" class="form-control-plaintext"
																		id="generated_time" name="generated_time" readonly>
																</div>
															</div>
														</div>
			
														<div class="col-md-4">
															<!-- <div class="form-group  text-right">
																			<button type="button" class="btn  btn-primary "
																				onclick="generateReport()">Download EHR</button></label>
																		</div> -->
														</div>
			
													</div>
													</div>

													<div class="opdMain_detail_area">
														<h4 class="service_htext">
															Referring Provider Details</strong>
														</h4>
														<div class="row">
															
															<div class="col-md-4">
																<div class="form-group row">
																	<div class="col-sm-6">
																		<label class="col-form-label"><strong>Provider
																				Name</strong></label>
																	</div>
																	<div class="col-sm-6">
																		<input type="text" class="form-control-plaintext"
																			id="Provider_Name" name="Provider_Name" readonly>
																	</div>
																</div>
															</div>
			
															<div class="col-md-4">
																<div class="form-group row">
																	<div class="col-sm-6">
																		<label class="col-form-label"><strong>Location</strong></label>
																	</div>
																	<div class="col-sm-6">
																		<input type="text" class="form-control-plaintext" id="REFERRING_Location"	name="REFERRING_Location" readonly>
																	</div>
																	<input type="hidden" id="patientIdVal" name="patientId" value="<%out.print(patientId);%>" />
																	<input type="hidden" id="userIdVal" name="userId" value="<%out.print(userId);%>" />
																</div>
															</div>
															
															<div class="col-md-4">
																<div class="form-group row">
																	<div class="col-sm-6">
																		<label class="col-form-label"><strong>Phone
																				Number</strong></label>
																	</div>
																	<div class="col-sm-6">
																		<input type="text" class="form-control-plaintext"
																			id="user_mobile" name="Provider_Name" readonly>
																	</div>
																</div>
															</div>
															
															<div class="col-md-4">
																<div class="form-group row">
																	<div class="col-sm-6">
																		<label class="col-form-label"><strong>Rank
																				</strong></label>
																	</div>
																	<div class="col-sm-6">
																		<input type="text" class="form-control-plaintext"
																			id="user_rank" name="Provider_Name" readonly>
																	</div>
																</div>
															</div>
			
															<div class="col-md-4">
																<div class="form-group row"></div>
															</div>
														</div>
													</div>

										<!-- ----- Referring End  Here -->
				
													<!-- ----- Patient Details Start  Here -->
				
													<div class="opdMain_detail_area">                                       
		                                     <h4 class="service_htext"> Patient Details</h4>
											    <div class="row">
											
												<!-- <div class="col-12">
											        <h6 class="text-theme text-underline font-weight-bold">
													Patient Details</h6>
												</div>	 -->										
											   <div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-6">
															<label class="col-form-label"><strong>Employee Name</strong></label>
														</div>
														<div class="col-sm-6">
															<input type="text" class="form-control-plaintext" id="Employee_Name"	name="Employee_Name" readonly>
														</div>
													</div>
												</div>
											
											
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-6">
															<label class=" col-form-label"><strong>Service number</strong> </label>
														</div>
														<div class="col-sm-6">
															    <input type="text" class="form-control-plaintext" id="Service_Number"  name="Service_Number"   readonly>
																
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-6">
															<label class="col-form-label"><strong>Patient Name</strong></label>
														</div>
														<div class="col-sm-6">
															<input type="text" class="form-control-plaintext" id="Patient_Name"	name="Patient_Name"  readonly>
														</div>
													</div>
												</div>
												
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-6">
															<label class="col-form-label"><strong>Registration No./UHID</strong></label>
														</div>
														<div class="col-sm-6">
															<input type="text" class="form-control-plaintext" id="Registration_No"	name="Registration_No" readonly>
														</div>
													</div>
												</div>
												
												
												
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-6">
															<label class=" col-form-label"><strong>Relation</strong></label>
														</div>
														<div class="col-sm-6">									
															  <input type="text" class="form-control-plaintext" id="Relation" name="Relation"  readonly>
														</div>
													</div>
												</div>
												
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-6">
															<label class="col-form-label"><strong>Service Type</strong></label>
														</div>
														<div class="col-sm-6">
															<input type="text" class="form-control-plaintext" id="Service_Type"	 name="Service_Type"  readonly>
														</div>
													</div>
												</div>
												
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-6">
															<label class=" col-form-label"><strong>Gender</strong> </label>
														</div>
														<div class="col-sm-6">
															<input type="text" class="form-control-plaintext" id="gender" name="gender" readonly>
														</div>
													</div>
												</div>
												
												
												
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-6">
															<label class=" col-form-label"><strong>Branch/Trade</strong> </label>
														</div>
														<div class="col-sm-6">
															<input type="text" class="form-control-plaintext" id="Branch_Trade" name="Branch_Trade" readonly>
														</div>
													</div>
												</div>
												
												
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-6">
															<label class="col-form-label"><strong>DOB</strong></label>
														</div>
														<div class="col-sm-6">
															<input type="text" class="form-control-plaintext" id="DOB"	name="DOB" readonly>
														</div>
													</div>
												</div>
												
												
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-6">
															<label class="col-form-label"><strong>Age</strong></label>
														</div>
														<div class="col-sm-6">
															<input type="text" class="form-control-plaintext" id="Age"	name="Age" readonly>
														</div>
													</div>
												</div>
												
												
												
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-6">
															<label class="col-form-label"><strong>Marital Status</strong></label>
														</div>
														<div class="col-sm-6">
															<input type="text" class="form-control-plaintext" id="Marital_Status"	name="Marital_Status" readonly>
														</div>
													</div>
												</div>


												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-6">
															<label class="col-form-label"><strong>Religion</strong></label>
														</div>
														<div class="col-sm-6">
															<input type="text" class="form-control-plaintext" id="Religion"	name="Religion" readonly>
														</div>
													</div>
												</div>
												
												
											<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-6">
															<label class="col-form-label"><strong>Email Address</strong></label>
														</div>
														<div class="col-sm-6">
															<input type="text" class="form-control-plaintext" id="Email_Address"	name="Email_Address" readonly>
														</div>
													</div>
												</div>
												
												
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-6">
															<label class="col-form-label"><strong>Address</strong></label>
														</div>
														<div class="col-sm-6">
															<textarea style="resize: both;" type="text" class="form-control-plaintext" id="Address"	name="Address" readonly></textarea>
														</div>
													</div>
												</div>
												
												
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-6">
															<label class="col-form-label"><strong>Phone Number</strong></label>
														</div>
														<div class="col-sm-6">
															<input type="text" class="form-control-plaintext" id="Phone_Number"	name="Phone_Number" readonly>
														</div>
													</div>
												</div>											
											</div>
										</div>
				
													<div class="opdMain_detail_area">                                       
		                                     <h4 class="service_htext">Emergency Contact / NOK </h4>
											    <div class="row">
											
												 
											
												<!-- <div class="col-12">
											        <h6 class="text-theme text-underline font-weight-bold">
													Emergency Contact / NOK</h6>
												</div> -->											
											   <div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-6">
															<label class="col-form-label"><strong>Name</strong></label>
														</div>
														<div class="col-sm-6">
															<input type="text" class="form-control-plaintext" id="Name"	name="Name" readonly>
														</div>
													</div>
												</div>
												
												
												
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-6">
															<label class=" col-form-label"><strong>Relation</strong></label>
														</div>
														<div class="col-sm-6">									
															  <input type="text" class="form-control-plaintext" id="contact_Relation" name="contact_Relation"  readonly>
														</div>
													</div>
												</div>
												
											 					
											<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-6">
															<label class="col-form-label"><strong>Address</strong></label>
														</div>
														<div class="col-sm-6">
														<textarea style="resize: both;" class="form-control-plaintext" id="contact_Address"	name="contact_Address" readonly></textarea>
														</div>
													</div>
												</div>
			
																		
												
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-6">
															<label class="col-form-label"><strong>Contact Number</strong></label>
														</div>
														<div class="col-sm-6">
															<input type="text" class="form-control-plaintext" id="Contact_Number"	name="Contact_Number" readonly>
														</div>
													</div>
												</div>											
											</div>
											</div>
				
										<div class="opdMain_detail_area">                                       
		                                     <h4 class="service_htext"> Medical Information</h4>
											    <div class="row">			 
													 <div class="col-4">
														  <h6 class="service_htext_2"><strong>Blood Group</strong></h6>
													 </div>
													  <div class="col-8">
														<input type="text" class="form-control-plaintext" id="Blood_Group"	name="Blood_Group" readonly>
													  </div>
												</div>	
																						 
											  <div class="row">
													  <div class="col-4">
													 <h6 class="service_htext_2"><strong>Allergy/Alerts</strong></h6>
													 </div>
													  <div class="col-8">
													 <textarea style="resize: both;" class="form-control-plaintext" id="Allergy_Alerts"	
																name="Allergy_Alerts" readonly></textarea>
													 </div>
											  </div>
													 
													 
													 
											<div class="row">
													 <div class="col-4">
													 <h6 class="service_htext_2"><strong>Past Surgeries</strong></h6>
													 </div>
													  <div class="col-8">
													 <textarea style="resize: both;" class="form-control-plaintext" id="Past_Surgeries"	
																name="Past_Surgeries" readonly></textarea>
													 </div>
											 </div>
											 
											 <div class="row" id="implant_div">
													<div class="col-4">
													 <h6 class="service_htext_2"><strong>Implant History</strong></h6>
													 </div>
													  <div class="col-8">
													 <h6 class="service_htext_2"></h6>
													 </div>											 
										          
												  	 <div class="col-12">											 
															<table class="table table-striped  table-hover table-bordered">
						                                        <thead class="bg-success" style="color:#fff;">
						                                            <tr>
						                                                <th>S.No.</th>
						                                                <th>Device ID</th>
						                                                <th>Device Name </th>
						                                                <th>Date of Implant</th>
						                                                <th>Remarks</th>                                                 
						                                            </tr>
						                                        </thead>
		                                         
					                                     <tbody id="tblListOfImplantHistory">
					                                        			                                     
					                                      </tbody>
					                                    </table>															
													</div>
												 </div>
											
											<div class="row" id="immunization_div">	
													<div class="col-4">
													    <h6 class="service_htext_2"><strong>Immunization</strong></h6>
													 </div>
													 <div class="col-8">
													    <h6 class="service_htext_2"></h6>
													 </div>													
													<div class="col-12">											 
															<table class="table table-striped  table-hover table-bordered">
						                                        <thead class="bg-success" style="color:#fff;">
						                                            <tr>
						                                                <th>S.No.</th>
						                                                <th>Immunization Name</th>
						                                                <th>Immunization prescribed on</th>
						                                                <th>Immunization Date </th>
						                                                <th>Duration(Years)</th>
						                                                <th>Next Due Date</th>                                               
						                                            </tr>
						                                        </thead>
		                                         
							                                     <tbody id="tblListOfImmunizationHistory">
							                                      
							                                      </tbody>
						                                    </table>															
													</div>
												</div>
												
														 
											<div class="row" id="vital_sign_div">
													<div class="col-4">
													    <h6 class="service_htext_2"><strong>Most Recent Vital Signs</strong></h6>
													 </div>
													 <div class="col-8">
													    <h6 class="service_htext_2"></h6>
													 </div>													
													<div class="col-12">											 
															<table class="table table-striped  table-hover table-bordered">
						                                        <thead class="bg-success" style="color:#fff;">
						                                            <tr>
						                                                <th>S.No.</th>
						                                                <th>Date</th>
						                                                <th>Temperature </th>
						                                                <th>Pulse</th>
						                                                <th>BP</th>						                                                 
						                                                <th>RR</th>
						                                                <th>SpO2</th>
						                                                <th>Height</th>
						                                                <th>Weight</th>
						                                                <th>BMI</th>                    
						                                                 
						                                            </tr>
						                                        </thead>
		                                         
					                                       <tbody id="tblListOfRecentVitalSign">
					                                       
					                                        </tbody>
					                                    </table>															
													</div>
												</div>
												
												
												<div class="row" id="most_recent_lab_results_div">	
													<div class="col-4">
													    <h6 class="service_htext_2"><strong>Most Recent Lab Results</strong></h6>
													 </div>
													 <div class="col-8">
													    <h6 class="service_htext_2"></h6>
													 </div>													
													<div class="col-12">											 
															<table class="table table-striped  table-hover table-bordered">
						                                        <thead class="bg-success" style="color:#fff;">
						                                            <tr>
						                                                <th>S.No.</th>
						                                                <th>Investigation Date </th>
						                                                <th>Investigation Name</th>
						                                                 <th>Units</th>
						                                                <th>Result</th>           
						                                                <th>Report</th>                                               
						                                            </tr>
						                                        </thead>
		                                         
							                                     <tbody id="most_recent_lab_results">
							                                      
							                                      </tbody>
						                                    </table>															
													</div>
												</div>		
												
												
												 <div class="row" id="most_recent_imaging_results_div">	
													<div class="col-4">
													    <h6 class="service_htext_2"><strong>Most Recent Imaging Results</strong></h6>
													 </div>
													 <div class="col-8">
													    <h6 class="service_htext_2"></h6>
													 </div>													
													<div class="col-12">											 
															<table class="table table-striped  table-hover table-bordered">
						                                        <thead class="bg-success" style="color:#fff;">
						                                            <tr>
						                                                <th>S.No.</th>
						                                                <th>Order ID</th>
						                                                <th>Investigation Date </th>
						                                                <th>Investigation Name</th>
						                                                <th>Result</th>  
						                                                <th>Report</th>                                               
						                                            </tr>
						                                        </thead>
		                                         
					                                     <tbody id="most_recent_imaging_results">
					                                         
					                                        
					                                        </tbody>
					                                    </table>															
													</div>
												</div>
												
												<div class="row" id="current_medical_problem_div">	
													<div class="col-4">
													    <h6 class="service_htext_2"><strong>Current Medical Problems</strong></h6>
													 </div>
													 <div class="col-8">
													    <h6 class="service_htext_2"></h6>
													 </div>													
													<div class="col-12">											 
															<table class="table table-striped  table-hover table-bordered">
						                                        <thead class="bg-success" style="color:#fff;">
						                                            <tr>
						                                                <th>S.No.</th>
						                                                <th>Visit Date </th>
						                                                <th>Diagnosis</th>
						                                            </tr>
						                                        </thead>
		                                         
							                                     <tbody id="current_medical_problem">
							                                      
							                                      </tbody>
						                                    </table>															
													</div>
												</div>
												
											
												<div class="row" id="current_medications_div">		
													<div class="col-4">
													    <h6 class="service_htext_2"><strong>Current Medications</strong></h6>
													 </div>
													 <div class="col-8">
													    <h6 class="service_htext_2"></h6>
													 </div>													
													<div class="col-12">											 
															<table class="table table-striped  table-hover table-bordered">
						                                        <thead class="bg-success" style="color:#fff;">
						                                            <tr>
						                                                <th>S.No.</th>
						                                                <th>Item Name</th>
						                                                <th>Dosage </th>
						                                                <th>Frequency</th>
						                                                <th>No. of Days</th>    
						                                                <th>Status</th>                                           
						                                            </tr>
						                                        </thead>
		                                         
					                                      <tbody id="current_medications">
					                                      
					                                        
					                                        </tbody>
					                                    </table>															
													</div>													
												</div>
													
											
												
											</div>
											
										<div class="m-t-20">                                       
		                                    <h5 class="service_htext_noBorder">Encounters</h5>
		                                    <div class="timeline timeline-left">
												
	                                            	
											</div>		                                     
	                                    </div>
											
											<div class="row">
												<div class="col-12">
													
												</div>
											</div>
																		
											<%-- </form> --%>
				
										</div>
				
									</div>
								</div>
							</div>
				
						</div>
				
					</div>
			
			</div>
			
 <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
	  <div class="modal-dialog modal-xl" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title font-weight-bold">Encounter Details</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<div id="container">
													
			</div>
	        
	        <div class="text-right">
	        	<button class="btn btn-primary" data-dismiss="modal">Close</button>
	        </div>
	      </div> 
	       <!-- <div class="text-center text-primary text-xsm">
	         loading <i class="fa fa-spin fa-spinner"></i>
	        </div> -->
	    </div>
	  </div>
</div>

<div class="modal-backdrop show" style="display:none;"></div>
			
	</div>
</body>
</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>