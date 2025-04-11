<%@page import="java.util.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
     <%@include file="..//view/leftMenu.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Result Entry</title>
<%@include file="..//view/commonJavaScript.jsp"%>

</head>
<script type="text/javascript" language="javascript">
<%			
		String hospitalId = "1";
		if (session.getAttribute("hospital_id") != null) {
			hospitalId = session.getAttribute("hospital_id") + "";
		
		}
		
		String user_id = "0";
		if (session.getAttribute("user_id") != null) {
			user_id = session.getAttribute("user_id") + "";
		}
%>
var $j = jQuery.noConflict();

var nPageNo=1;

$j(document).ready(function()
		{
			
			var data = ${data};
			$j('#order_date').val(data.detailList[0].orderDate);
			$j('#department').val(data.detailList[0].deptName);
			$j('#doctor').val(data.detailList[0].doctorRank +' '+data.detailList[0].doctorName);
			$j('#service_no').val(data.detailList[0].serviceNo);
			$j('#patient_name').val(data.detailList[0].patientName);
			$j('#relation').val(data.detailList[0].relation);
			$j('#rank').val(data.detailList[0].rank);
			$j('#employee_name').val(data.detailList[0].empName);
			$j('#age').val(data.detailList[0].age);
			$j('#gender').val(data.detailList[0].gender);
			
			$j('#dgOrderHdId').val(data.detailList[0].dgOrderHdId);
			$j('#dgOrderDtId').val(data.detailList[0].dgOrderDtId);
			$j('#mainChargeCodeId').val(data.detailList[0].mainChargeCodeId);
			$j('#mainSubChargeCodeId').val(data.detailList[0].mainSubChargeCodeId);
			$j('#investigationId').val(data.detailList[0].investigationId);
			$j('#date').val(currentDateInddmmyyyy());
			$j('#entered_by').val(data.detailList[0].enteredByRank +' '+ data.detailList[0].enteredBy);
			$j('#patientId').val(data.detailList[0].patientId);
			$j('#modality').val(data.detailList[0].modality);
			$j('#investigation').val(data.detailList[0].investigationName);
			
			//resultEntry
			//var text = " <p><b>findings: </b>patient is ok.</p><p><br></p><p><b>Recommendation:</b> none</p>";
			//$('#editor').jqteVal("<font face=\"Impact\">RBCs SHOW SEVERE ANISOPOIKILOCYTOSIS WITH MICROCYTIC HYPOCHROMIC CELLS,ELLIPTOCYTES,TARGET CELLS AND TEAR DROP CELLS.<br>WBCs ARE NORMAL IN NUMBER &amp; DISTRIBUTION &nbsp;<br>N51% L47% E2%<br>PLATELETS ARE ADEQUATE<br>HEMOPARASITES ARE NOT SEEN<br><br><b>IMPRESSION:- </b>SEVERE MICROCYTIC HYPOCHROMIC ANAEMIA </font><br>");
			
	
		});
		
/* 		(function($) {
		    $(document).ready(function() {
		      $("#resultEntry").val('this is a test content.');
		    });
		})(jQuery); */

 	function saveResult(){
		/* if (document.getElementById('fileUploadId').value == ""){
			alert('Please select a file to Upload');
			return;
		} */
		var resultEntry = $('#editor').val();
		if(resultEntry == undefined || resultEntry == ''){
			alert("Please enter the result");
			return;
		}
		var fileData = $j('#frm')[0]; 
        var data = new FormData(fileData);
 		
 		$j('#submit_btn').attr("disabled", true);
		$.ajax({
			type: 'POST',
            enctype: 'multipart/form-data',
            url: 'saveRadiologyResult',
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
			success : function(data) {
				var response = JSON.parse(data);				
				if(response.result == 'success'){ 
					var dtId = response.dtId;
					window.location = "radiologySubmit?dtId="+ dtId +"&flag='resultEntry'";
				}else{
					
					alert("Error occured");					
					$j('#submit_btn').attr("disabled", false);
				}
			},
			error : function(data) {
				alert("An error has occurred while contacting the server");
				$j('#submit_btn').attr("disabled", false);
			}
		}); 
 	}
 	
 	function back(){
 		window.location = "getRadiologyWaitingData";
 	}
 	
 	function uploadDoc(){
 		
 	}
 	
 	function resetFields(){
 		$j('#remarks').val('');
 		$('#editor').jqteVal('');
 	}
 
</script>
<body>
<div id="wrapper">
	<div class="content-page">
		<div class="">
			<div class="container-fluid">
				<div class="internal_Htext"> Result Entry</div>
				<!-- end row -->
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								  <form name="frm" id="frm"> 
										<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">Order Date</label>
													<div class="col-sm-7">
														<input class="form-control form-control-sm" type="text"
															placeholder="" id="order_date" name="order_date" readonly>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">Department</label>
													<div class="col-sm-7">
														<input class="form-control form-control-sm" type="text"
															placeholder="" id="department" name="department" readonly>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">Doctor</label>
													<div class="col-sm-7">
														<input class="form-control form-control-sm" type="text"
															placeholder="" id="doctor" name="doctor" readonly>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-12">
												<h6 class="text-theme text-underline font-weight-bold">
												Patient Details</h6>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">Service No.</label>
													<div class="col-sm-7">
														<input class="form-control form-control-sm" type="text"
															placeholder="" id="service_no" name="service_no" readonly>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">Patient Name</label>
													<div class="col-sm-7">
														<input class="form-control form-control-sm" type="text"
															placeholder="" id="patient_name" name="patient_name" readonly>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">Relation</label>
													<div class="col-sm-7">
														<input class="form-control form-control-sm" type="text"
															placeholder="" id="relation" name="relation" readonly>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
												<div class="col-md-4">
													<div class="form-group row">
														<label class="col-sm-5 col-form-label">Rank</label>
														<div class="col-sm-7">
															<input class="form-control form-control-sm" type="text"
																placeholder="" id="rank" name="rank" readonly>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<label class="col-sm-5 col-form-label">Employee
															Name</label>
														<div class="col-sm-7">
															<input class="form-control form-control-sm" type="text"
																placeholder="" id="employee_name" name="employee_name" readonly>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<label class="col-sm-5 col-form-label">Age</label>
														<div class="col-sm-7">
															<input class="form-control form-control-sm" type="text"
																placeholder="" id="age" name="age" readonly>
														</div>
													</div>
												</div>
												</div>
											<div class="row">
												<div class="col-md-4">
													<div class="form-group row">
														<label class="col-sm-5 col-form-label">Gender</label>
														<div class="col-sm-7">
															<input class="form-control form-control-sm" type="text"
																placeholder="" id="gender" name="gender" readonly>
														</div>
													</div>
												</div>
											</div>
										<div class="form-row">
											<input type="hidden" id="dgOrderHdId" name="dgOrderHdId" value=""> <input
												type="hidden" id="dgOrderDtId" name="dgOrderDtId" value=""> <input
												type="hidden" id="mainChargeCodeId" name="mainChargeCodeId" value=""> <input
												type="hidden" id="mainSubChargeCodeId" name="mainSubChargeCodeId" value=""> <input
												type="hidden" id="investigationId" name="investigationId" value="">
												<input type="hidden" id="hospitalId" name="hospitalId" value="<%= hospitalId %>">
												<input type="hidden" id="userId" name="userId" value="<%= user_id %>">	
												<input type="hidden" id="patientId" name="patientId" value="">	
																							
										</div>
										<div class="row">
											<div class="col-12">
												<h6 class="text-theme text-underline font-weight-bold">
												Result Entry Details</h6>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">Date</label>
													<div class="col-sm-7">
														<input class="form-control form-control-sm" type="text" placeholder="" id="date" name="date" value="" readonly>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">Entered By</label>
													<div class="col-sm-7">
														<input class="form-control form-control-sm" type="text"
															placeholder="" id="entered_by" name="entered_by" readonly>
													</div>
												</div>
											</div>
																							<div class="col-md-4">
													<div class="form-group row">
														<label class="col-sm-5 col-form-label">Modality</label>
														<div class="col-sm-7">
															<input class="form-control form-control-sm" type="text"
																placeholder="" id="modality" name="modality" readonly>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group row">
														<label class="col-sm-5 col-form-label">Investigation</label>
														<div class="col-sm-7">
															<input class="form-control form-control-sm" type="text"
																placeholder="" id="investigation" name="investigation" readonly>
														</div>
													</div>
												</div>
										</div>										
      									
      										<div class="row m-t-5">										
      											<div class="col-md-4">
														<div class="form-group row">
															<label class="col-sm-5 col-form-label">Result</label>
															<div class="col-sm-7">
																<div class="fileUploadDiv">
																	<input type="file" multiple name="fileName" class="file inputUpload" id="fileUploadId"></td>
																	<label class="inputUploadlabel">Choose File</label>
																	<span class="inputUploadFileName">No File Chosen</span>
																</div>
															</div>
														</div>
												</div>											
											</div>
								
								<div class="row">
									<div class="col-12">
										<div id="editor" name="resultEntry"></div>
									</div>
								</div>
								
								<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">Remarks</label>
													<div class="col-sm-7">
														<textarea class="form-control" id="remarks" name="remarks"></textarea>
													</div>
												</div>
											</div>
										</div>
								
									<div class="row">
										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
												<!-- <button type="button" class="btn btn-primary"
													id="submit_btn" onclick="saveResult()">Save</button> -->
												<input type="button" class="btn btn-primary opd_submit_btn" id="submit_btn" value="Save" onclick="saveResult();">												 
												<input type="button" class="btn btn-primary opd_submit_btn" value="Close" onclick="back();">
												<input type="button" class="btn btn-danger opd_submit_btn" value="Reset" onclick="resetFields();">
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

<script>
$(function(){
	
	$("#editor").jqte();
	
})

</script>
</body>
</html>