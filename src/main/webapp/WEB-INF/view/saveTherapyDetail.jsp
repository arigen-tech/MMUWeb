 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%-- <%@include file="..//view/leftMenu.jsp"%> --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">
<head>
<title>Save Procedure Detail</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<style>

#wrapper{
display:none;
}
.footer{
	left:0px;
}
</style>
</head>
<script type="text/javascript" language="javascript">
<%	String hospitalId = "1";
%>

var $j = jQuery.noConflict();
var total_required_procedure = 0;
var total_given_procedure = 0;
var final_status = '';
var today_total_procedure = 0;
var global_feq=0;
$j(document).ready(function()
		{
			$j('#tblListofNursing').empty();
			//getSpecificPhysioDetail();
			getSpecificPhysioDetail();
		});
		
	function getSpecificPhysioDetail(){
		var data = ${data};
		total_required_procedure = data.detailInfo.no_of_days * data.detailInfo.feq;
		global_feq = data.detailInfo.feq;
		$j('#procedure_name').val(data.detailInfo.procedure_name);
		$j('#frequency').val(data.detailInfo.frequency);
		$j('#no_of_days').val(data.detailInfo.no_of_days);
		$j('#frequency_id').val(data.detailInfo.frequency_id);
		$j('#procedure_id').val(data.detailInfo.procedure_id);
		$j('#header_id').val(data.detailInfo.header_id);		
		$j('#op_remarks').val(data.detailInfo.op_remarks);	
		
		var table_data = data.detailList;
		var html = '';
		var html2 = '';
		var total_records = 0;
		var m = 0;
		for(var i=0;i<table_data.length;i++){
			m++;
			var apt_date = dateFormat(table_data[i].appointment_date);
			var d2 = new Date().toISOString().slice(0,10);
			today_total_procedure++;
			//if(apt_date == d2){
			if(m > global_feq){
				today_total_procedure = 0;
				m = 0;
				today_total_procedure++;
				m++;	
			}
			total_records ++;
			var action = table_data[i].status;
			var status = '';
			if(total_records > total_required_procedure){
				break;
			}
			if(total_records == total_required_procedure){
				final_status = 'Y';
			}
			if(action == 'Y'){
				status = 'Completed';
				total_given_procedure++;
			}else{
				var crnt_date = currentDateInddmmyyyy();
				status = 'Not Completed';
				html2 += '<tr>';
				html2 += '<td><div><input class="form-control" id="appoint_date" type="text" value="'+table_data[i].appointment_date+'" readonly></div></td>';
				html2 += '<td><div><input class="form-control" id="procedure_date" type="text" value="'+crnt_date+'" readonly></div></td>';
				//html2 += "<td><div class='dateHolder'><input type=\"text\" readonly class=\"input_date datePickerInput form-control\" id=\"procedure_date\" placeholder=\"DD/MM/YYYY\" name=\"date_56\"   maxlength=\"10\" onblur=\"validateExpDate(this,'discharge_date_667');\" onkeyup=\"mask(this.value,this,'2,5','/');\"></td></div>";
				html2 += '<td><div><input class="form-control" id="nursing_remarks" type="text" value="'+table_data[i].nursing_remarks+'"></div></td>';
				html2 += '<td><div><input class="form-control" type="text" value="'+status+'" readonly></div></td>';
				if(status != 'Completed'){
					
					var date1 = table_data[i].appointment_date;
					var todayDate = new Date().toISOString().slice(0,10);
					
					if(process(date1) <= new Date(todayDate)){
						html2 += '<td><div><button type="button" class="btn btn-primary" value="'+table_data[i].id+'" id="save_bt" onclick="saveProcedureDetail(this.value)">Save</button></div></td>';
					}else{
						html2 += '<td><div><button type="button" class="btn btn-primary" value="'+table_data[i].id+'" onclick="saveProcedureDetail(this.value)" disabled>Save</button></div></td>';
					}
					
				}
				html2 += '</tr>';
			}
			if(action == 'Y'){
				html += '<tr>';
				html += '<td><div><input class="form-control" type="text" value="'+table_data[i].appointment_date+'" readonly></div></td>';
				html += '<td><div><input class="form-control" type="text" value="'+table_data[i].procedure_date+'" readonly></div></td>';
				html += '<td><div><input class="form-control" type="text" value="'+table_data[i].nursing_remarks+'" readonly></div></td>';
				html += '<td><div><input class="form-control" type="text" value="'+status+'" readonly></div></td>';
				html += '<td></td>';
				html += '</tr>';
			}
		}
		$j('#tblListofNursing').append(html);
		$j('#tblListofNursing').append(html2);
		
	}
		
	function saveProcedureDetail(id){
		
	
		var procedure_date = $j('#procedure_date').val();
		var nursing_remarks = $j('#nursing_remarks').val();	
		var app_select_date = $j('#appointment_date').val();
		var app_date = $j('#appointment_date').val();
		//appoint_date
		if (app_date == '' || app_date == undefined) {
			app_date = $j('#appoint_date').val();
		}
		var op_remarks = $j('#op_remarks').val();
		var current_date = new Date();
		if(procedure_date == '' || procedure_date == undefined){
			alert("Physiotherapy Date must be selected");
			return;
		}
		if(nursing_remarks == '' || nursing_remarks == undefined){
			alert("Physiotherapy Remarks must be entered");
			return;
		}
		
		
	if (total_given_procedure < (total_required_procedure - 1)) {
			if (today_total_procedure == global_feq) {
				if (app_select_date == '' || app_select_date == undefined) {
					alert("Please select next appointment date");
					return;
				}
			}
		}
		//var d1 = Date.parse(app_date);
		var d2 = new Date().toISOString().slice(0, 10);
		d3 = new Date(d2);
		d3.setHours(00,00,00);
	if (app_select_date != '' || app_select_date != undefined) {
			if (process(app_select_date) <= d3) {
				alert("Next Appointment Date should be future Date");
				return;
			}
		}
	
		var params = {
			"procedure_date" : procedure_date,
			"nursing_remarks" : nursing_remarks,
			"id" : id,
			"appointment_date" : app_date,
			"procedure_id" : $j('#procedure_id').val(),
			"frequency_id" : $j('#frequency_id').val(),
			"header_id" : $j('#header_id').val(),
			"no_of_days" : $j('#no_of_days').val(),
			"final_status" : final_status,
			"op_remarks" : op_remarks
		}
		
		$j("#save_bt").attr("disabled", true); 
		$j.ajax({
			type : "POST",
			contentType : "application/json",
			url : 'saveProcedureDetail',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(data) {
				var msg = data.result;
				alert(msg);
				location.reload();
			},

			error : function(data) {

				alert("An error has occurred while contacting the server");

			}
		});

	}
	function closeScreen() {
		window.close();
		window.opener.location.reload();
	}
</script>

<body>

 <!-- Begin page -->
    <div>

       
	
		<!-- Start content -->
		<div class="">			

				<div class="internal_Htext">Physiotherapy Details</div>
				<!-- end row -->

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<form>
								<div class="row">									
									<div class="col-md-4">
											<div class="form-group row">
											<label class="col-sm-4 col-form-label">Physiotherapy
												Name</label>
											<div class="col-sm-7">
												<input type="text" class="form-control  form-control-sm" id="procedure_name" name="procedure_name" readonly>
											</div>
										</div>
									</div>
									<div class="col-md-4">
											<div class="form-group row">
											<label for="staticEmail" class="col-sm-4 col-form-label">Frequency</label>
											<div class="col-sm-7">
												<input type="text" class="form-control  form-control-sm" id="frequency" name="frequency" readonly>
											</div>
										</div>
									</div>
									<div class="col-md-4">
											<div class="form-group row">
											<label for="staticEmail" class="col-sm-4 col-form-label">No.Of
												Days</label>
											<div class="col-sm-7">
												<input type="text" class="form-control  form-control-sm" id="no_of_days" name="no_of_days" readonly>
											</div>
										</div>
									</div>
									<div class="col-md-4">
											<div class="form-group row">
											<label for="staticEmail" class="col-sm-4 col-form-label">OP
												Remarks</label>
											<div class="col-sm-7">
												<input type="text" class="form-control  form-control-sm" id="op_remarks" name="op_remarks" readonly>
											</div>
										</div>
									</div>
									<div class="col-md-4">
											<div class="form-group row">
											<label for="staticEmail" class="col-sm-4 col-form-label">Appointment
												Date</label>
											<div class="col-sm-7">
												<!-- <input type="date" class="form-control" id="appointment_date" name="op_remarks"> -->
												<div class="dateHolder ">
													<input type="text" readonly class="calDate datePickerInput form-control" id="appointment_date" placeholder="DD/MM/YYYY"
														name="date"  onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10">
												</div>
											</div>
											</div>
										</div>
									</div>
									
											<table class="table table-bordered table-striped table-hover">
												<tr>
													<th>Appointment Date</th>
													<th>Physiotherapy Date</th>
													<th>Nursing Remarks</th>
													<th>Status</th>
													<th>Action</th>
												</tr>
												<tbody id="tblListofNursing">

												</tbody>
											</table>
										
									<div class="row">		 
										 <div class="col-md-12">
															<div class="btn-left-all">																 
															</div> 
															<div class="btn-right-all">
															<button type="button" class="btn btn-primary"
										         			 onclick="closeScreen()">Close</button>															
															</div> 
											 </div> 
										</div>
								</form>


							</div>

						</div>
					</div>

			</div>

		

	<input type="hidden" id="procedure_id" value="">
	<input type="hidden" id="frequency_id" value="">
	<input type="hidden" id="header_id" value="">
	
	</div>
 </div>
</body>
</html>