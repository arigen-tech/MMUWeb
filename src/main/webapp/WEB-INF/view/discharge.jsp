<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Discharge</title>
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
	var relation = '';
	var relationFlag = false;
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
						$j('#relation').val(data.referralList[0].relation);
						var relationName = 'Self';
						var relation = data.referralList[0].relation;
						if(relation.trim().toLowerCase() === relationName.trim().toLowerCase()){
							relationFlag = true;
							$j('#tsbx1').attr('disabled',false);
						}else{
							$j('#tsbx1').attr("disabled", true);
						}
						var date_of_admission = data.referralList[0].admission_date;
						relation = data.referralList[0].relation;
						$j('#admission_date').val(date_of_admission);
						$j('#ward').val(data.referralList[0].ward);
						$j('#no_of_days').val(data.referralList[0].no_of_days);
						$j('#admission_remark').val(data.referralList[0].remarks);
						$j('#admission_no').val(data.referralList[0].admission_no);
						$j('#disposal_combo').val(data.referralList[0].disposal);
						var comboList = '<option value="">Select</option>';
						var disposalId = data.referralList[0].disposalId;
						for (var j = 0; j < data.disposalList.length; j++) {
							if (disposalId != '' && disposalId != undefined) {
								if (disposalId == data.disposalList[j].id) {
									comboList += '<option value="'+data.disposalList[j].id+'" selected>'
											+ data.disposalList[j].disposal_name
											+ '</option>';
								}
							}
							var disposalCode = data.disposalList[j].disposal_code;
							if(relation!="" && (relation=='Self') && disposalCode != 008){
								comboList += '<option value="'+data.disposalList[j].id+'">'
								+ data.disposalList[j].disposal_name
								+ '</option>';
							}else if((relation!="" && (disposalCode==007 || disposalCode==008 || disposalCode==009) && (relation!='Self'))){
								comboList += '<option value="'+data.disposalList[j].id+'">'
								+ data.disposalList[j].disposal_name
								+ '</option>';
							}else if(relation == ''){
								$j('#disposal_combo').prop('disabled',true);
								$j('#no_of_days').prop('disabled',true);
							}
							
						}
						//alert("comboList "+comboList);
						$j('#disposal_combo').append(comboList);

					});

	function saveAdmissionDetail() {
		var admission_date = $j('#admission_date').val();
		var ward = $j('#ward').val();
		var no_of_days = $j('#no_of_days').val();
		var admission_no = $j('#admission_no').val();
		var discharge_date = $j('#discharge_date').val();
		var mbCheck = $('#tsbx1').is(":checked");
		var checkRelation = $j('#relation').val();
		
		if (admission_no == '' || admission_no == undefined) {
			alert("Admission No. must be entered");
			return;
		}else if (discharge_date == '' || discharge_date == undefined) {
			alert("Discharge date must be selected");
			return;			
		}else if(process(discharge_date) < process(admission_date)){
			alert("Discharge Date can't be earlier than Admission Date");
			return;
		}else if(process(discharge_date) > new Date()){
			alert("Date of Discharge should not be later than the System Date");
			return;
		}else if($j('#disposal_combo').find('option:selected').val() == '' || $j('#disposal_combo').find('option:selected').val() == undefined){
			if(checkRelation != ''){
				alert("Please select Disposal Type");
				return;
			}
		}else if(no_of_days == '' || no_of_days == undefined) {
			if(checkRelation != ''){
				alert("No. of Days must be entered");
				return;
			}
		}
		var params = {
			"header_id" : $j('#header_id').val(),
			"patient_id" : $j('#patient_id').val(),
			"admission_date" : $j('#admission_date').val(),
			"ward" : $j('#ward').val(),
			"disposal" : $j('#disposal_combo').find('option:selected').val(),
			"no_of_days" : $j('#no_of_days').val(),
			"admission_remark" : $j('#admission_remark').val(),
			"admission_no" : $j('#admission_no').val(),
			"admission_id" : $j('#admission_id').val(),
			"discharge_date" : $j('#discharge_date').val(),
			"discharge_remark":$j('#discharge_remark').val(),
			"hospital_id" : <%=hospitalId%>,
			"mbCheck":mbCheck
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
	   	   				 	window.location="dischargePending";
					     }
				 });
				
			},

			error : function(data) {

				alert("An error has occurred while contacting the server");

			}
		});
	}

	function dateFormat(inputdate) {

		var daynmonth = inputdate.split("-");
		var formated_date = daynmonth[2] + '-' + daynmonth[1] + '-'
				+ daynmonth[0];
		return formated_date;
	}

	function closeScreen() {
		//var discharge_date = $j('#discharge_date').val();		
		window.location = "dischargePending";		
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
				<div class="internal_Htext">Discharge</div>
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">


								<div class="row">
									<div class="col-md-12">
										<form>
										
										<div class="">
											<div class="">
												<h4  class="service_htext">Patient Details</h4>
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
															  <textarea class="form-control rounded-0" id="diagnosis" readonly></textarea>
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
											
										</div>
											
										<div class="">
											<div class="">
												<h4  class="service_htext">Discharge Detail</h4>
											</div>
											<div class="row">
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
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Date of Admission</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="noFuture_date form-control" placeholder="DD/MM/YYYY" maxlength="10" id="admission_date">
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class=" col-form-label  ">Ward Name</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="ward" readonly>
														</div>
													</div>
												</div>	
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label">Admission Remark</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="admission_remark" readonly>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Date of Discharge</label>
														</div>
														<!-- <div class="col-sm-7">
															<input type="date" class="form-control"
																id="discharge_date">
														</div> -->
														<div class="col-sm-7">
														<div class="dateHolder ">
															<input type="text"  class="calDate datePickerInput form-control" id="discharge_date" placeholder="DD/MM/YYYY"
															name="date"  onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10">
														</div>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label  ">Disposal Type</label>
														</div>
														<div class="col-sm-7">
															<select class="form-control" id="disposal_combo" >
															</select>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class=" col-form-label  ">No. of Days</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="no_of_days" onkeypress="return isNumber(event)">
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-sm-5">
															<label class="col-form-label">Discharge Remark</label>
														</div>
														<div class="col-sm-7">
															<input type="text" class="form-control" id="discharge_remark">
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">													
														<div class="col-sm-7">															
															<div class="form-check form-check-inline cusCheck m-t-5">
																<input type="checkbox" class="form-check-input" id="tsbx1"/>
																<span class="cus-checkbtn"></span> 
																<label class="form-check-label" for="tsbx1">Mark as MB</label>
															</div>															
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
													<button type="button" class="btn btn-primary" onclick="saveAdmissionDetail()">Submit</button>
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