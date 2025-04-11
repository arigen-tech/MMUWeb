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
		var data = ${data};
		$j('#patient_name').val(data.patient_detail.patientName);
		$j('#age').val(data.patient_detail.age);
		$j('#gender').val(data.patient_detail.gender);
		$j('#header_id').val(data.patient_detail.header_id);
		$j('#icd_diagnosis').val(data.patient_detail.icd_diagnosis);
		$j('#working_diagnosis').val(data.patient_detail.working_diagnosis);
		
		var html= '<tr>';
		for(var i=0;i<data.nursingDetailList.length;i++){
			var final_status_value = '';
			if(data.nursingDetailList[i].finalStatus == 'Y'){
				final_status_value = 'Completed';
			}else{
				final_status_value = 'Pending';
			}
			html += '<tr><input type="hidden" id="rowid" value="'+data.nursingDetailList[i].id+'">';
			html += '<td><div><input class="form-control" id="procedure_name" type="text" value="'+data.nursingDetailList[i].procedureName+'" readonly></div></td>';
			html += '<td><div><input class="form-control" id="frequency" type="text" value="'+data.nursingDetailList[i].frequency+'" readonly></div></td>';
			html += '<td><div><input class="form-control" id="no_of_days" type="text" value="'+data.nursingDetailList[i].noOfDays+'" readonly></div></td>';
			html += '<td><div><input class="form-control" id="final_status" type="text" value="'+final_status_value+'" readonly></div></td>';
			html += '<td><div><button type="button" class="btn btn-primary" value="'+data.nursingDetailList[i].procedure_id+'" onclick="viewProcedureDetail(this.value)">View &amp; Submit</button></div></td>';
			html += '</tr>';
		}
		
			$j('#tblListofObesity').append(html);
		});
		var popup;
		function viewProcedureDetail(val){
				
				var header_id = $j('#header_id').val();
				popup = window.open("getSpecificProcedureDetail?id="+header_id+"."+val+"", "popUpWindow", "height=500,width=1000,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
                popup.focus();
		}
		function backToWaitingList(){
			window.location = "nursingCareWaitingJSP";		
		}
</script>

<body>

 <!-- Begin page -->
    <div id="wrapper">
	<div class="content-page">
		<!-- Start content -->
		<div class="">
			<div class="container-fluid">

				<div class="internal_Htext">Nursing Care</div>
				<!-- end row -->

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">

								<form>										
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
														id="icd_diagnosis" name="diagnosis" readonly> -->
													<textarea class="form-control" rows="2" id="icd_diagnosis" readonly></textarea>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label for="staticEmail" class="col-sm-5 col-form-label">Working Diagnosis</label>
												<div class="col-sm-7">
													<!-- <input type="text" class="form-control  form-control-sm"
														id="working_diagnosis" name="diagnosis" readonly> -->
														<textarea class="form-control" rows="1" id="working_diagnosis" readonly></textarea>
												</div>
											</div>
										</div>									
								 </div>
									 
									
									<h6 class="text-theme text-underline font-weight-bold">Nursing Care List</h6>								
									<input type="hidden" id="header_id">									
										<div class="tablediv">
											<table class="table table-bordered ">
												<tr>
													<th>Nursing Care Name</th>
													<th>Frequency</th>
													<th>No.Of Days</th>
													<th>Final Status</th>
													<th></th>
												</tr>
												<tbody id="tblListofObesity">

												</tbody>
											</table>
										</div>
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