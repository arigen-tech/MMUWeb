 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<title>Referral Patient Detail</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%> 
</head>
<script type="text/javascript" language="javascript">
<%	

String hospitalId = "1";

if (session.getAttribute("hospital_id") !=null)
{
	hospitalId = session.getAttribute("hospital_id")+"";
}
%>
var $j = jQuery.noConflict();
var rowcount=0;
var relationFlag = false;
$j(document).ready(function()
		{
				var data = ${data};
				var i = 0;
				var j = 0;
				for(item in data){
					i++;
					
					if(i == 1){						
						for(subitem in data[item]){
							
							$j('#service_no').val(data[item][subitem].service_no);
							$j('#patient_name').val(data[item][subitem].patient_name);
							$j('#age').val(data[item][subitem].age);
							$j('#gender').val(data[item][subitem].gender);
							$j('#rank').val(data[item][subitem].rank);
							$j('#mobile_no').val(data[item][subitem].mobile_no);
							$j('#header_id').val(data[item][subitem].id);
							$j('#patient_id').val(data[item][subitem].patient_id);
							var relation = data[item][subitem].relation;
							console.log("relation "+relation);
							var relationName = 'Self';
							if(relation.trim().toLowerCase() === relationName.trim().toLowerCase()){
								relationFlag = true;
							}
							console.log("relationFlag "+relationFlag);
						}
					}else if(i == 2){						
						var html = '';						
						for(subitem in data[item]){
							var id = data[item][subitem].id;
							var disease = data[item][subitem].notifiable_desease;
							var mark_mb = data[item][subitem].mark_mb;
							var mark_admitted = data[item][subitem].mark_admitted;
							var close = data[item][subitem].close;
							var final_note = data[item][subitem].final_note;
							var flag = false;
							if((disease == 'Y') || (mark_mb == 'Y') || (mark_admitted == 'Y') || (close == 'Y')){
								flag = true;
							}
							if(disease == 'N'){
								if(flag){
									var disease_checkbox = '<div class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input" type="checkbox" id="notifiable_disease'+rowcount+'" value="N" disabled><span class="cus-checkbtn"></span></div>';
								}else{
									var disease_checkbox = '<div class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input" type="checkbox" id="notifiable_disease'+rowcount+'" value="N"><span class="cus-checkbtn"></span></div>';
								}
								
							}else if(disease == 'Y'){
								if(flag){
									var disease_checkbox = '<div class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input" type="checkbox" id="notifiable_disease'+rowcount+'" value="Y" checked disabled><span class="cus-checkbtn"></span></div>';
								}else{
									var disease_checkbox = '<div class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input" type="checkbox" id="notifiable_disease'+rowcount+'" value="Y" checked><span class="cus-checkbtn"></span></div>';
								}
								
							}
							
							if(mark_mb == 'N'){
								if(flag){
									var mark_mb_checkbox = '<div class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input markMB" type="checkbox" id="mark_mb'+rowcount+'" value="N" disabled><span class="cus-checkbtn"></span></div>';
								}else{
									var mark_mb_checkbox = '<div class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input markMB" type="checkbox" id="mark_mb'+rowcount+'" value="N" onclick="disableAdmitCheckbox(this)"><span class="cus-checkbtn"></span></div>';
								}
								
							}else if(mark_mb == 'Y'){
								if(flag){
									var mark_mb_checkbox = '<div class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input markMB" type="checkbox" id="mark_mb'+rowcount+'" value="Y" checked disabled><span class="cus-checkbtn"></span></div>';
								}else{
									var mark_mb_checkbox = '<div class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input markMB" type="checkbox" id="mark_mb'+rowcount+'" value="Y" onclick="disableAdmitCheckbox(this)" checked><span class="cus-checkbtn"></span></div>';
								}
								
							}
							
							if(mark_admitted == 'N'){
								if(flag){
									var mark_admitted_checkbox = '<div class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input" type="checkbox" id="mark_admitted'+rowcount+'" value="N" disabled><span class="cus-checkbtn"></span></div>';
								}else{
									var mark_admitted_checkbox = '<div class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input" type="checkbox" id="mark_admitted'+rowcount+'" value="N" onclick="disableMbCheckbox(this);"><span class="cus-checkbtn"></span></div>';
								}
								
							}else if(mark_admitted == 'Y'){
								if(flag){
									var mark_admitted_checkbox = '<div class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input" type="checkbox" id="mark_admitted'+rowcount+'" value="Y" checked disabled><span class="cus-checkbtn"></span></div>';
								}else{
									var mark_admitted_checkbox = '<div class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input" type="checkbox" id="mark_admitted'+rowcount+'" value="Y" onclick="disableMbCheckbox(this);" checked><span class="cus-checkbtn"></span></div>';
								}
								
							}
							
							if(close == 'N'){
								if(flag){
									var close_checkbox = '<div class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input" type="checkbox" id="close'+rowcount+'" value="N" disabled><span class="cus-checkbtn"></span></div>';
								}else{
									var close_checkbox = '<div class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input" type="checkbox" id="close'+rowcount+'" value="N"><span class="cus-checkbtn"></span></div>';
								}
								
							}else if(close == 'Y'){
								if(flag){
									var close_checkbox = '<div class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input" type="checkbox" id="close'+rowcount+'" value="Y" checked disabled><span class="cus-checkbtn"></span></div>';
								}else{
									var close_checkbox = '<div class="form-check form-check-inline cusCheck m-l-10"><input class="form-check-input" type="checkbox" id="close'+rowcount+'" value="Y" checked><span class="cus-checkbtn"></span></div>';
								}
								
							}
							if(final_note == undefined){
								final_note ='';
							}
							var referral_date = data[item][subitem].referral_date;
							var department = data[item][subitem].department_name;
							var instruction= data[item][subitem].instructions;
							if(referral_date == undefined){
								referral_date = '';
							}
							if(department == undefined){
								department = '';
							}
							if(instruction == undefined){
								instruction ='';
							}
							if(flag){
								html += '<tr><input type="hidden" id="rowid'+rowcount+'" value="'+id+'"><td><div><input class="form-control" id="referral_date" type="text" value="'+referral_date+'" readonly></div></td><td><div><input class="form-control" id="hospital_name" type="text" value="'+data[item][subitem].hospital_name+'" readonly></div></td><td><div><input class="form-control" id="speciality" type="text" value="'+department+'" readonly></div></td><td><div><textarea class="form-control rounded-0" id="diagnosis" readonly>'+data[item][subitem].diagnosis_name+'</textarea></div></td><td class="text-center">'+disease_checkbox+'</td><td><div><input class="form-control" id="instructions'+rowcount+'" type="text" value="'+instruction+'" readonly></div></td><td class="text-center">'+mark_mb_checkbox+'</td><td class="text-center">'+mark_admitted_checkbox+'</td><td>'+close_checkbox+'</td><td><div><input class="form-control" id="final_note'+rowcount+'" type="text" value="'+final_note+'" disabled><input class="form-control" id="final_hidden'+rowcount+'" type="hidden" value="'+final_note+'"></div></td></tr>';
							}else{
								html += '<tr><input type="hidden" id="rowid'+rowcount+'" value="'+id+'"><td><div><input class="form-control" id="referral_date" type="text" value="'+referral_date+'" readonly></div></td><td><div><input class="form-control" id="hospital_name" type="text" value="'+data[item][subitem].hospital_name+'" readonly></div></td><td><div><input class="form-control" id="speciality" type="text" value="'+department+'" readonly></div></td><td><div><textarea class="form-control rounded-0" id="diagnosis" readonly>'+data[item][subitem].diagnosis_name+'</textarea></div></td><td class="text-center">'+disease_checkbox+'</td><td><div><input class="form-control" id="instructions'+rowcount+'" type="text" value="'+instruction+'" readonly></div></td><td class="text-center">'+mark_mb_checkbox+'</td><td class="text-center">'+mark_admitted_checkbox+'</td><td>'+close_checkbox+'</td><td><div><input class="form-control" id="final_note'+rowcount+'" type="text" value="'+final_note+'"><input class="form-control" id="final_hidden'+rowcount+'" type="hidden" value="'+final_note+'"></div></td></tr>';
							}
							
							rowcount++;
						}
						$j('#tableId').append(html);
						if(relationFlag){
							$j('.markMB').attr("disabled", false);
						}
					}				
				
				}
			
		});
		

	function saveReferralDetail() {
		/* var form_validation = validateReferralDetail();
		if(form_validation == false){
			alert("Please Select one option atleast");
			return;
		}  */
		var validateForm = validateDetail();
		if(validateForm){
			alert("Please select atleast one option");
			return;
		}
		var row_array = [];
		for (var i = 0; i < rowcount; i++) {			
			var header_id = $j('#header_id').val();
			var id = $j('#rowid'+i+'').val();
			var final_note = $j('#final_note'+i+'').val();
			var notifiable_disease = '';
			var mark_mb = '';
			var mark_admitted = '';
			var close = '';
			var instructions = '';
			var notifiable_check = document.getElementById('notifiable_disease'+ i).checked;
			var mb_check = document.getElementById('mark_mb' + i).checked;
			var admitted_check = document.getElementById('mark_admitted' + i).checked;
			var close_check = document.getElementById('close' + i).checked;
			if (notifiable_check == true) {
				notifiable_disease = 'Y';
			} else {
				notifiable_disease = 'N';
			}

			if (mb_check == true) {
				mark_mb = 'Y';
			} else {
				mark_mb = 'N';
			}
			if (admitted_check == true) {
				mark_admitted = 'Y';
			} else {
				mark_admitted = 'N';
			}
			if (close_check == true) {				
				close = 'Y';
				if(final_note == '' || final_note == 'undefined'){
					return alert("Final Note is Required");
				}
			} else {
				if(final_note != '' && final_note != 'undefined'){
					return alert("Please select close");
				}else{
					close = 'N';	
				}
				//close = 'N';
			}
			
			var params = {
					'id':id,
					'final_note':final_note,
					'notifiable_disease':notifiable_disease,
					'mark_mb':mark_mb,
					'mark_admitted':mark_admitted,
					'close':close					
			}
			row_array.push(params);
			
		}
		var patient_id = $j('#patient_id').val();
		var data = {
				"detail_list":row_array,
				"header_id": header_id,
				"patient_id": patient_id,
				"hospital_id": "<%= hospitalId %>"
		}
		
		 $j.ajax({
				type:"POST",
				contentType : "application/json",
				url: 'updateReferralDetail',
				data : JSON.stringify(data),
				dataType: "json",			
				cache: false,
				success: function(msg)
				{  
					 alert(msg.msg+'S'); 
					 
					 document.addEventListener('click',function(e){
	   					    if(e.target && e.target.id== 'closeBtn'){
	   					    	window.location.href="referralWaitingList";
	   					     }
	   					 });
				},
				
				error: function(msg)
				{					
					
					alert("An error has occurred while contacting the server");
					
				}
		});
	}
	
	function validateReferralDetail(){
		var flag = true;
		for(var i=0;i<rowcount;i++){
			var row1before = '';
			//var notifiable_before = document.getElementById('notifiable_disease'+i+'').value;
			var mb_before = document.getElementById('mark_mb'+i+'').value;
			var admitted_before = document.getElementById('mark_admitted'+i+'').value;
			var close_before = document.getElementById('close'+i+'').value;
			//var hidden_note = $j('#final_hidden'+i+'').val();
			var old_row_data = mb_before+admitted_before+close_before;
			
			//var notifiable_after = document.getElementById('notifiable_disease'+i+'').checked;
			var mb_after = document.getElementById('mark_mb'+i+'').checked;
			var admitted_after = document.getElementById('mark_admitted'+i+'').checked;
			var close_after = document.getElementById('close'+i+'').checked;
			
			if(mb_after == true){
				mb_after = 'Y';
			}else{
				mb_after = 'N';
			}
			if(admitted_after == true){
				admitted_after = 'Y';
			}else{
				admitted_after = 'N'
			}
			if(close_after == true){
				close_after = 'Y';
			}else{
				close_after = 'N';
			}
			var new_row_data = mb_after+admitted_after+close_after;
			if(old_row_data === new_row_data){
				flag =  false;
				break;
			}
			
		}
		return flag;
	}
	
function backToReferralWaitingList(){
	window.location.href="referralWaitingList";
}

$j("#myForm :input").change(function() {
	alert("changed");
	   $j("#myForm").data("changed",true);
});

function validateDetail(){
	var flag = true;
	for(var i=0;i<rowcount;i++){
		var disease = document.getElementById('notifiable_disease'+i+'').checked;
		var admission = document.getElementById('mark_admitted'+i+'').checked;
		var mb = document.getElementById('mark_mb'+i+'').checked;
		var close = document.getElementById('close'+i+'').checked;
		if(disease || admission || mb || close){
			flag = false;
			break;
		}
	}
	return flag;
}

function disableAdmitCheckbox(item){
	var checkFlag = $(item).closest('tr').find('td').eq(6).find('div').find('input:checkbox').is(':checked');
	console.log("checkFlag "+checkFlag);
	if(checkFlag){
		$(item).closest('tr').find('td').eq(7).find('div').find('input:checkbox').attr('disabled',true);
	}else{
		$(item).closest('tr').find('td').eq(7).find('div').find('input:checkbox').attr('disabled',false);
	}
	
}

function disableMbCheckbox(item){
	var checkFlag = $(item).closest('tr').find('td').eq(7).find('div').find('input:checkbox').is(':checked');
	console.log("check ok "+checkFlag);
	if(checkFlag){
		$(item).closest('tr').find('td').eq(6).find('div').find('input:checkbox').attr('disabled',true);
	}else{
		$(item).closest('tr').find('td').eq(6).find('div').find('input:checkbox').attr('disabled',false);
	}
}

</script>
<body>

<div id="wrapper">
    <div class="content-page">
		<!-- Start content -->
		<div class="">
			<div class="container-fluid">

				<div class="internal_Htext"> Referral Patient Detail</div>
				<!-- end row -->

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">

								<form name="myForm" id="myForm">
								 
									<div class="row"> 
									        <div class="col-12">
												<h6 class="text-theme text-underline font-weight-bold">
												Patient Details</h6>
											</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Service No.</label>
												<div class="col-sm-7">
													<input class="form-control  form-control-sm"  id="service_no" readonly>
													</input>
												</div>
											</div>
										</div> 
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Patient Name</label>
												<div class="col-sm-7">
													<input class="form-control form-control-sm" type="text"
														placeholder=""  id="patient_name" readonly>
												</div>
											</div>
										</div> 
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Age</label>
												<div class="col-sm-7">
													<input class="form-control form-control-sm" type="text"
														placeholder=""   id="age" readonly>
												</div>
											</div>
										</div> 
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Gender</label>
												<div class="col-sm-7">
													<input class="form-control  form-control-sm"  id="gender" readonly>	
													</input>
												</div>
											</div>
										</div> 										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Rank </label>
												<div class="col-sm-7">
													<input class="form-control form-control-sm" type="text"
														placeholder="" id="rank" readonly>
												</div>
											</div>
										</div> 
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Mobile No.</label>
												<div class="col-sm-7">
													<input class="form-control form-control-sm" type="text"
														placeholder=""   id="mobile_no" readonly>
												</div>
											</div>
										</div> 
								</div>
										
										
							     <div style="float: left">

								</div>
								<!-- <h4  class="service_htext"> Referral Details</h4> -->
								            
												<h6 class="text-theme text-underline font-weight-bold">
												Referral Details</h6>
									       
								<div style="float: right">
									<div id="resultnavigation"></div>
								</div>
												<table class="table  table-hover table-striped table-bordered" >
													<thead>
														<tr>
															<th>Referral Date</th>
															<th>Hospital Name</th>
															<th>Speciality</th>
															<th>Diagnosis</th>
															<th>Mark as Notifiable Disease</th>
															<th>Instruction</th>
															<th>Mark MB</th>
															<th>Mark as Admitted</th>
															<th>Close</th>
															<th>Final Note</th>
														</tr>
													</thead>
													<tbody id="tableId">
													</tbody>
												</table>	
												<!-- <table class="table table-bordered table-responsive" id="tableId"> </table>  -->
										 
									    <div class="form-group row"> 
										      
											<div class="col-md-12 text-right"> 
														<button type="button" class="btn btn-primary" onclick="saveReferralDetail()"> Submit</button>  
											
														<button type="button" class="btn btn-primary" onclick="backToReferralWaitingList()"> Back</button> 
											</div>  
										</div>		
										
										<div class="row">
										<input type="hidden" class="form-control" id="header_id" value="">
											<input type="hidden" class="form-control" id="patient_id" value="">
											
											<input type="hidden" id="header_id">
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
</body>
</html>