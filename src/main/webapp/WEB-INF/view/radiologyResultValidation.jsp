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

<title>Result Validation</title>
<%@include file="..//view/commonJavaScript.jsp"%>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/wysiwyg.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/wysiwyg-color.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/wysiwyg-settings.js"></script>  --%>
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
var nPageNo=1;
var $j = jQuery.noConflict();
//WYSIWYG.attach('result_entry', full);
$j(document).ready(function()
		{			
			var data = ${data};
			$j('#result_date').val(data.resultValidationData[0].resultDate);
			$j('#entered_by').val(data.resultValidationData[0].enteredByRank +' '+data.resultValidationData[0].enteredBy);
			$j('#service_no').val(data.resultValidationData[0].serviceNo);
			$j('#patient_name').val(data.resultValidationData[0].patientName);
			$j('#relation').val(data.resultValidationData[0].relation);
			$j('#employee_name').val(data.resultValidationData[0].empName);
			$j('#age').val(data.resultValidationData[0].age);
			$j('#gender').val(data.resultValidationData[0].gender);
			$j('#remarks').val(data.resultValidationData[0].remarks);
			$('#editor').jqteVal(data.resultEntry);	
			$j('#result_dt_id').val(data.resultValidationData[0].resultDtId);
			$j('#result_hd_id').val(data.resultValidationData[0].resultHdId);
			$j('#validation_date').val(currentDateInddmmyyyy());
			$j('#dId').val(data.dId);
			$j('#docName').val(data.docName);
			$j('#dFormat').val(data.dFormat);	
			$j('#validated_by').val(data.resultValidationData[0].virifiedByRank +' '+ data.resultValidationData[0].verifiedBy);	
			$j('#modality').val(data.resultValidationData[0].modality);	
			$j('#investigation').val(data.resultValidationData[0].investigationName);	
			$j('#ridcId').val(data.resultValidationData[0].ridcId);
		});
		
		$(function(){
			
			$("#editor").jqte();
			
		})

 	function saveResult(){
 		var resultHdId = $j('#result_hd_id').val();
 		var resultDtId = $j('#result_dt_id').val();
 		var validationDate = $j('#validation_date').val();
 		var remarks = $j('#remarks').val(); 		
 		var resultEntry = $('#editor').val();
 		if(resultEntry == undefined || resultEntry == ''){
			alert("Please enter the result");
			return;
		}
 		var params = {
 				"hospitalId":<%= hospitalId %>,
 				"validationDate":validationDate,
 				"userId":<%= user_id %>,
 				"remarks":remarks,
 				"resultHdId":resultHdId,
 				"resultDtId":resultDtId,
 				"resultEntry":resultEntry
 		}
 		$j('#submit_btn').attr("disabled", true);
		$j.ajax({
			type : "POST",
			contentType : "application/json",
			url : 'validateRadiologyResult',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(data) {		
				if(data.result == 'success'){ 
					var dtId = data.dtId;
					window.location = "radiologySubmit?dtId="+ dtId +"&flag='validation'";					
				}else{					
					alert("Error occured");
					$j('#submit_btn').attr("disabled", false);
				}				
			},
			error : function(data) {
				alert("An error has occurred while contacting the server");
				$('#submit_btn').attr("disabled", false);
			}
		});
 	}
 	
 	function back(){
 		window.location = "getResultValidationWaitingList";
 	}
 	
 	function downloadDoc(){
 		var ridcId = $j('#ridcId').val();	
		if(ridcId == ''){
			alert("No Document Found");
			return;
		}
 		var dId = $j('#dId').val();
 		var docName = $j('#docName').val();
 		var dFormat = $j('#dFormat').val();
 		window.location = "../downloadDocumentFromRIDC?dId="+dId+"&"+"docName="+docName+"&"+"dFormat="+dFormat+"";
 		//window.location = "${pageContext.request.contextPath}/utility/downloadDocumentFromRIDC";
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
				<div class="internal_Htext">Result Validation</div>
				<!-- end row -->
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<form>									
									
							 <div class="row">
							 			<div class="col-md-4">					 
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Result Date</label>
												<div class="col-sm-7">
												<input class="form-control form-control-sm" type="text"
														placeholder="" id="result_date" readonly>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Result Entered By</label>
												<div class="col-sm-7">
													<input class="form-control form-control-sm" type="text"
														placeholder="" id="entered_by" readonly>
												</div>
											</div>
										</div>								 										
								</div>
								 
							<div class="row">
								<div class="col-12">
									<h6 class="text-theme text-underline font-weight-bold">Patient Details</h6>
								</div>
							 			<div class="col-md-4">					 
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Service No.</label>
												<div class="col-sm-7">
													<input class="form-control form-control-sm" type="text"
														placeholder="" id="service_no" readonly>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Patient Name</label>
												<div class="col-sm-7">
													<input class="form-control form-control-sm" type="text"
														placeholder="" id="patient_name" readonly>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Relation</label>
												<div class="col-sm-7">
													<input class="form-control form-control-sm" type="text"
														placeholder="" id="relation" readonly>
												</div>
											</div>
										</div>	
										
									 	
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Employee Name</label>
												<div class="col-sm-7">
													<input class="form-control form-control-sm" type="text"
														placeholder="" id="employee_name" readonly>
												</div>
											</div>
										</div>	
												
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Age</label>
												<div class="col-sm-7">
													<input class="form-control form-control-sm" type="text"
														placeholder="" id="age" readonly>
												</div>
											</div>
										</div>	
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Gender</label>
												<div class="col-sm-7">
													<input class="form-control form-control-sm" type="text"
														placeholder="" id="gender" readonly>
												</div>
											</div>
										</div>														 										
								</div> 
								<!-- <div class="row">
									
								</div> -->
							<div class="row">
								<div class="col-12">
									<h6 class="text-theme text-underline font-weight-bold">Result Validation Details</h6>
								</div>
							 			<div class="col-md-4">					 
											<div class="form-group row">
												<label class="col-sm-5 col-form-label"> Validation Date</label>
												<div class="col-sm-7">
												<input class="form-control form-control-sm" type="text"
														placeholder="" id="validation_date" readonly>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Validated By<span class="mandate"><sup class="star_m">&#42;</sup></span></label>
												<div class="col-sm-7">
													<input class="form-control form-control-sm" type="text"
														placeholder="" id="validated_by" readonly>
												</div>
											</div>
										</div>	
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Modality</label>
												<div class="col-sm-7">
													<input class="form-control form-control-sm" type="text"
														placeholder="" id="modality" readonly>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Investigation</label>
												<div class="col-sm-7">
													<input class="form-control form-control-sm" type="text"
														placeholder="" id="investigation" readonly>
												</div>
											</div>
										</div>								 													 										
									</div>							 								
								
							                  <div class="row">
                                                <!-- <div class="col-md-4">
                                                    <div class="form-group row">
                                                        <label class="col-sm-5 col-form-label">Result</label>
                                                        <div class="col-sm-7">
                                                            <input type="file"  multiple="" name="uploadFile" class="file" id="fileUploadId">
                                                        </div>
                                                    </div>
                                                </div> -->
                                               <!--  <div class="col-md-4">
                                                    <div class="form-group row">
                                                        <div class="col-sm-7">
                                                            <button type="button" class="btn btn-primary" onclick="downloadDoc()">Download/View Document</button>
                                                        </div>
                                                    </div>
                                                </div> -->
                                                <div class="col-md-4">                                                  
                                                </div>  
                                                
                                              </div>													

                                                 <br>
                                                	
                                                 <div class="row m-b-5">
												 	<div class="col-12">
														<div class="form-control" id="editor" name="editor" style="width:700px;height:200px"></div> 
													</div>
												</div>
												
												 <div class="row">
                                                     <div class="col-md-4">
                                                         <div class="form-group row">
                                                             <label class="col-sm-5 col-form-label">Remarks</label>
                                                             <div class="col-sm-7">
                                                             <!-- <div id="res" style="width:200px;height:100px"></div> -->
                                                               <textarea class="form-control" id="remarks"></textarea>
                                                             </div>
                                                         </div>
                                                     </div>
                                                 </div>		

                                                 <input type="hidden" id="result_dt_id">						
												 <input type="hidden" id="result_hd_id">
												 <input type="hidden" id="dId" name=""dId"">
												 <input type="hidden" id="docName" name="docName">
												 <input type="hidden" id="dFormat" name="dFormat">
												 <input type="hidden" id="ridcId" name="ridcId">								 				
								 <div class="row"> 
								      <div class="col-md-12">
											<div class="btn-left-all"> 
											</div> 
											<div class="btn-right-all">
											 <button type="button" class="btn btn-primary" onclick="downloadDoc()">Download/View Document</button>
											<button class="btn btn-primary" type="button" id="submit_btn" onclick="saveResult()">Validate</button>											
											<button class="btn btn-primary" type="button" onclick="back()">Back</button>																		
											<button class="btn btn-danger" type="button" onclick="resetFields()">Reset</button>
											
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