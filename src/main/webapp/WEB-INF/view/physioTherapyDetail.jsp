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
<%	String hospitalId = "1";
%>

var $j = jQuery.noConflict();

$j(document).ready(function()
		{
			getPhysioTherapyDetail();
		});
	function getPhysioTherapyDetail(){
		var data = ${data};
		$j('#patient_name').val(data.patient_detail.patientName);
		$j('#age').val(data.patient_detail.age);
		$j('#gender').val(data.patient_detail.gender);
		$j('#header_id').val(data.patient_detail.header_id);
		$j('#working_diagnosis').val(data.patient_detail.working_diagnosis);
		$j('#icd_diagnosis').val(data.patient_detail.icd_diagnosis);	
		
		
		//$j('#diagnosis').val(data.patient_detail.diagnosis);
		
		var html= '<tr>';
		for(var i=0;i<data.physioDetailList.length;i++){
			var final_status = '';
			if(data.physioDetailList[i].finalStatus == 'Y'){
				final_status = 'Completed';
			}else {
				final_status = 'Pending';
			}
			html += '<tr><input type="hidden" id="rowid" value="'+data.physioDetailList[i].id+'">';
			html += '<td><div><input class="form-control" id="physiotherapy_name" type="text" value="'+data.physioDetailList[i].physiotherapy_name+'" readonly></div></td>';
			html += '<td><div><input class="form-control" id="start_date" type="text" value="'+data.physioDetailList[i].start_date+'" readonly></div></td>';
			html += '<td><div><input class="form-control" id="frequency" type="text" value="'+data.physioDetailList[i].frequency+'" readonly></div></td>';
			html += '<td><div><input class="form-control" id="no_of_days" type="text" value="'+data.physioDetailList[i].noOfDays+'" readonly></div></td>';
			html += '<td><div><input class="form-control" id="op_remarks" type="text" value="'+data.physioDetailList[i].op_remarks+'" readonly></div></td>';
			html += '<td><div><input class="form-control" id="final_status" type="text" value="'+final_status+'" readonly></div></td>';
			html += '<td><button type="button" class="btn btn-primary" value="'+data.physioDetailList[i].procedure_id+'" onclick="viewProcedureDetail(this.value)">View &amp; Submit</button></td>';
			html += '</tr>';
		}
		
			$j('#tblListofPhysio').append(html);
	}
		var popup;
		function viewProcedureDetail(val){
				
				var header_id = $j('#header_id').val();
				popup = window.open("getSpecificTherapyDetail?id="+header_id+"."+val+"", "popUpWindow", "height=500,width=1000,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
                popup.focus();
		}
		
		function backToWaitingList(){
			window.location = "physioTherapyWaitingJSP";		
		}
</script>

<body>
 <!-- Begin page -->
    <div id="wrapper">

	<div class="content-page">
		<!-- Start content -->
		<div class="">
			<div class="container-fluid">

				<div class="internal_Htext">Physiotherapy</div>
				<!-- end row -->

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">

								<form>
									<div class="">
										<!-- <h4 class="service_htext">Patient Details</h4> -->
										
										
									<div class="row"> 	
									 <div class="col-12">
												<h6 class="text-theme text-underline font-weight-bold">
												Patient Details</h6>
											</div>
									
									
										<div class="col-md-4">
											<div class="form-group row">
												<label for="staticEmail" class="col-sm-5 col-form-label">Patient
													Name</label>
												<div class="col-sm-7">
													<input type="text" class="form-control  form-control-sm"
														id="patient_name" name="patient_name" readonly>
												</div>
											</div>
										</div>

										<div class="col-md-4">
										<div class="form-group row">
											<label for="staticEmail" class="col-sm-5 col-form-label">Age</label>
											<div class="col-sm-7">
												<input type="text" class="form-control  form-control-sm"
													id="age" name="age" readonly>
											</div>
										</div>
										</div>

										<div class="col-md-4">
										<div class="form-group row">
											<label for="staticEmail" class="col-sm-5 col-form-label">Gender</label>
											<div class="col-sm-7">
												<input type="text" class="form-control  form-control-sm"
													id="gender" name="gender" readonly>
											</div>
										</div>
										</div>

										<div class="col-md-4">
										<div class="form-group row">
											<label for="staticEmail" class="col-sm-5 col-form-label">ICD
												Diagnosis</label>
											<div class="col-sm-7">
												<!-- <input type="text" class="form-control  form-control-sm"
													id="icd_diagnosis" name="diagnosis"> -->
													<textarea class="form-control" rows="2" id="icd_diagnosis" readonly></textarea>
											</div>
										</div>
										</div>

										<div class="col-md-4">
										<div class="form-group row">
											<label for="staticEmail" class="col-sm-5 col-form-label">Working
												Diagnosis</label>
											<div class="col-sm-7">
											<!-- 	<input type="text" class="form-control  form-control-sm"
													id="working_diagnosis" name="diagnosis" readonly> -->
												<textarea class="form-control" rows="1" id="working_diagnosis" readonly></textarea>
											</div>
										</div>
										</div>
									
									</div>
									
									</div>

									<input type="hidden" id="header_id">
                                     
                                     <h6 class="text-theme text-underline font-weight-bold">
												Physiotherapy List</h6>
                                     
                                     
									<!-- <h4 class="service_htext">Physiotherapy List</h4> -->
									<table class="table table-bordered">
										<tr>
											<th>Physiotherapy Name</th>
											<th>Physiotherapy Start Date</th>
											<th>Frequency</th>
											<th>No.Of Days</th>
											<th>OP Remarks</th>
											<th>Final Status</th>
											<th style="width:13%">Action</th>
										</tr>
										<tbody id="tblListofPhysio">

										</tbody>
									</table>
									<div class="row">		 
										 <div class="col-md-12">
												<div class="btn-left-all">																 
												</div> 
												<div class="btn-right-all">
												<button type="button" class="btn btn-primary"
							         			 onclick="backToWaitingList()">Back</button>															
												</div> 
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


</body>
</html>