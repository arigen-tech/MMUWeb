<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Admission</title>
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
	var admission_date_global = '';
	$j(document)
			.ready(
					function() {
						var data = ${data};
						$j('#service_no').val(data.referralList[0].service_no);
						$j('#patient_name').val(data.referralList[0].patient_name);
						$j('#age').val(data.referralList[0].age);
						$j('#gender').val(data.referralList[0].gender);
						$j('#rank').val(data.referralList[0].rank);
						$j('#mobile_no').val(data.referralList[0].mobile_no);
						$j('#referral_date').val(data.referralList[0].referral_date);
						$j('#hospital_name').val(data.referralList[0].hospital_name);
						$j('#speciality').val(data.referralList[0].speciality);
						$j('#diagnosis').val(data.referralList[0].diagnosis);
						$j('#instructions').val(data.referralList[0].instructions);
						$j('#header_id').val(data.referralList[0].header_id);
						$j('#patient_id').val(data.referralList[0].patient_id);
						$j('#admission_id').val(data.referralList[0].admission_id);
						/* var date = data.referralList[0].admission_date;
						admission_date_global = date;
						var date_of_admission = '';
						if (date != '' && date != undefined) {
							date_of_admission = dateFormat(date);
						}

						$j('#admission_date').val(date_of_admission); */
						$j('#ward').val(data.referralList[0].ward);
						
						$j('#remark').val(data.referralList[0].remarks);
						$j('#admission_no').val(data.referralList[0].admission_no);
						/* var comboList = '';
						var disposalId = data.referralList[0].disposalId;
						for (var j = 0; j < data.disposalList.length; j++) {
							if (disposalId != '' && disposalId != undefined) {
								if (disposalId == data.disposalList[j].id) {
									comboList += '<option value="'+data.disposalList[j].id+'" selected>'
											+ data.disposalList[j].disposal_name
											+ '</option>';
								}
							}
							comboList += '<option value="'+data.disposalList[j].id+'">'
									+ data.disposalList[j].disposal_name
									+ '</option>';
						}
						//alert("comboList "+comboList);
						$j('#disposal_combo').append(comboList); */

					});

	function saveAdmissionDetail() {
		var admission_date = $j('#admission_date').val();		
		var ward = $j('#ward').val();		
		var admission_no = $j('#admission_no').val();
		var referral_date = $j('#referral_date').val();
		if (admission_date == '' || admission_date == undefined) {
			alert("Admission date must be selected");
			return;
		}else if(process(admission_date) < process(referral_date)){
			alert("Admission Date should not be earlier than Referral Date");
			return;
		}
		else if (ward == '' || ward == undefined) {
			alert("Please enter Ward Name");
			return;
		}
		/* else if (admission_no == '' || admission_no == undefined) {
			alert("Admission No. must be entered");
			return;
		} */

		var params = {
			"header_id" : $j('#header_id').val(),
			"patient_id" : $j('#patient_id').val(),
			"admission_date" : $j('#admission_date').val(),
			"ward" : $j('#ward').val(),
			"admission_remark" : $j('#remark').val(),
			"admission_no" : $j('#admission_no').val(),
			"admission_id" : $j('#admission_id').val(),
			"discharge_date" : $j('#discharge_date').val(),
			"hospital_id" : <%=hospitalId%>
	}

		$j.ajax({
			type : "POST",
			contentType : "application/json",
			url : 'savePatientAdmission',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(data) {

				var msg = data.msg;
				alert(msg+'S');			
				document.addEventListener('click',function(e){
					    if(e.target && e.target.id== 'closeBtn'){
					    	window.location = "admissionPending";
					     }
					 });
				
			},

			error : function(data) {

				alert("An error has occurred while contacting the server");

			}
		});
	}

	function dateFormat(inputdate) {

		var daynmonth = inputdate.split("/");
		var formated_date = daynmonth[2] + '-' + daynmonth[1] + '-'
				+ daynmonth[0];
		return formated_date;
	}

	function closeScreen() {		
			window.location = "admissionPending";		
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
				<div class="internal_Htext">Admission</div>
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">


								<div class="row">
									<div class="col-md-12">
										<form>
										
										<div>
											<div class="">
												<h6 class="service_htext">Patient Details</h6>
											</div>
											<div class="row">
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class=" col-form-label  ">Service No. </label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="service_no"
																name="commandCode" readonly>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Patient Name</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="patient_name"
																name="patient_name" readonly>
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
															<label class=" col-form-label  ">Gender </label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="gender" readonly>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Rank</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="rank"
																name="patient_name" readonly>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Mobile No.</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="mobile_no"
																name="age" readonly>
														</div>
													</div>
												</div>


												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class=" col-form-label  ">Referral Date </label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control"
																id="referral_date" readonly>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Hospital Name</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control"
																id="hospital_name" readonly>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Department/Speciality</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="speciality" readonly>
														</div>
													</div>
												</div>


												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class=" col-form-label  ">Diagnosis</label>
														</div>
														<div class="col-sm-7">										
															 <textarea class="form-control" id="diagnosis" readonly></textarea>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Instructions</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="instructions" readonly>
														</div>
													</div>
												</div>
											</div>
											
											</div>
											
											<div>
											<div class="">
												<h6 class="service_htext">Admission Detail</h6>
											</div>
											<div class="row">
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Date of Admission</label>
														</div>
														<!-- <div class="col-sm-7">
															<input type="date" class="form-control"
																id="admission_date">
														</div> -->
														<div class="col-sm-7">
															<div class="dateHolder">
																<input type="text" class="calDate datePickerInput form-control" id="admission_date" placeholder="DD/MM/YYYY"
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
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Remark</label>
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
												<div class="form-row">
													<input type="hidden" id="header_id" value=""> <input
														type="hidden" id="patient_id" value=""> <input
														type="hidden" id="admission_id" value="">
												</div>
												
												
											</div>
											
											</div>
										
										<div class="row">
										
											<div class="col-md-12 text-right">
													

													<button type="button" class="btn btn-primary"  onclick="saveAdmissionDetail()">Submit</button>


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