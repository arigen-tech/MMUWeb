<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Obesity Overweight Register</title>

<%@include file="..//view/leftMenu.jsp"%>
<%@include file="..//view/commonJavaScript.jsp"%>
</head>

<%			
	String hospitalId = "0";
	if (session.getAttribute("hospital_id") !=null)
	{
		hospitalId = session.getAttribute("hospital_id")+"";
	}
	String user_id = "0";
	if (session.getAttribute("user_id") != null) {
		user_id = session.getAttribute("user_id") + "";
	}

	String departmentId  = "0";
	if (session.getAttribute("department_id") != null) {
		departmentId  = session.getAttribute("department_id") + "";
	}
%>

<script type="text/javascript" language="javascript">

<%-- $j(document).ready(function(){
	if(<%=departmentId%>!=0){
		$("#printReportButton").attr("disabled", false);
	}else{
		alert("Select the department");
		return false;
	}
});
 --%>

 var $j = jQuery.noConflict();
 $j(document).ready(function() {   	
 	GetHospitalList();        	
 	$("#uid").hide();
 });
 
function compareDate(){
	 var fromDate = $('#fromDate').val();
	 var toDate = $('#toDate').val();
	 
	 if(process(toDate) < process(fromDate)){
			alert("To Date should not be earlier than from Date");
			$('#toDate').val("");
			return;
	 }
}

 function search(){
	 	var nPageNo=1;			
	 	var fromDate = $j('#fromDate').val();
	 	 var toDate = $j('#toDate').val();
	 	 var hospitalId=$('#unitId option:selected').val();
		if((fromDate == undefined || fromDate == '') || (toDate == undefined || toDate == '') || (hospitalId == undefined || hospitalId == '')){	
			alert("Fill mandatory fields");
			return;
		}
	  //getNISData('Filter');
		printReportDateWise();
 }
 
 function searchPatient(){
	 	var nPageNo=1;			
	 	var serviceNo = $j('#serviceNo').val();
		if((serviceNo == undefined || serviceNo == '')){	
			alert("Fill mandatory fields");
			return;
		}
	  //getNISData('Filter');
		printReportPatientWise();
}
 
 function ResetForm()
 {	
	 $j('#fromDate').val('');
 	 $j('#toDate').val('');
 }
 
 
 function printReportDateWise(){
	 var hospitalId="";
	 if($('#unitId').find("option").length > 2){
		 hospitalId= $('#unitId option:selected').val(); 
		 
	  }
	 else{
		 
	  hospitalId= <%out.print(hospitalId);%>
	
	  }
	 var fromDate=$j('#fromDate').val();
	 var toDate= $j('#toDate').val();
	 var url="${pageContext.request.contextPath}/report/printObesityOverweightRegister?hospitalId="+hospitalId+"&fromDate="+fromDate+"&toDate="+toDate;
	 //var url="${pageContext.request.contextPath}/report/printObesityOverweightRegister?from_date="+from_date+"&to_date="+to_date;
	 openPdfModel(url);
 }
 
 function printReportPatientWise(){
	  
	 var serviceNo=$j('#serviceNo').val();
	 var patientId=$j('#patientId').val();
	 var url="${pageContext.request.contextPath}/report/printObesityOverweightReports?patientId="+patientId+"&serviceNo="+serviceNo;
	 openPdfModel(url);
 }
 
 
 

 function getEmployeeDetails(){

		var serviceNo = $('#serviceNo').val();
		var relationId = $('#relationId').val();
		
		if(serviceNo !=''){				
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "getPatientByServiceNo",
		    data: JSON.stringify({"serviceNo":serviceNo,"relationId":12}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	if(result.status==1){
		    		$("#relationId").val(result.relationId);
		    		$("#patientId").val(result.patientId);
                $("#patientName").val(result.patientName);
			    	}
		    	else if(result.status==0){
			    	alert("Service No. does not exists");
		    		$('#serviceNo').val("");
		    		$('#relationId').val("");
		    		$('#patientId').val("");
		    		$("#patientName").val("");
		       }
		    }
		     });
	       }	
	      }

 var unitName = "";
	function GetHospitalList() {
		jQuery.ajax({
			crossOrigin : true,
			method : "POST",
			crossDomain : true,
			url : "${pageContext.request.contextPath}/master/getAllHospital",
			data : JSON.stringify({
				"PN" : "0",
				"hospitalId" : <%=hospitalId%>}),
     	    contentType: "application/json; charset=utf-8",
     	    dataType: "json",
     	    success: function(result){
     	    	//alert("success "+result.data.length);
     	    	var combo = "";
     	    	
     	    	for(var i=0;i<result.data.length;i++){
     	    		//comboArray[i] = result.data[i].departmentName;
     	    		combo += '<option  value='+result.data[i].unitId+'>' +result.data[i].unitName+ '</option>';
     	    		//alert("combo :: "+comboArray[i]);
     	    		unitName=result.data[i].unitName;
     	    		
     	    	}
     	    	jQuery('#unitId').append(combo);
     	    	
     	    	if($('#unitId').find("option").length > 2){
     	    		
     	    		$('#unitId').show(); 
     	    		$('#uid').hide();
         	    	
         	    }

     	    	else{
     	    		$('#unitId').hide(); 
     	    		$('#uid').show();
     	    		$('#uid').val(unitName).attr('readonly','readonly');
     	    		document.getElementById('unitId').value = <%=hospitalId%>; 
         	    	}
         	  
     	    	
     	    	
     	    }
     	
     	});
    
      }
 
</script>
<body>
	<!-- Begin page -->
	<div id="wrapper">
		<form name="frm">
			<div class="content-page">
				<!-- Start content -->
				<div class="">
					<div class="container-fluid">

						<div class="internal_Htext">Obesity/ Overweight Register</div>

						<!-- end row -->

						<div class="row">
							<div class="col-12">
								<div class="card">
									<div class="card-body">
									<h6 class="text-underline font-weight-bold text-theme">Date wise Register</h6>  
                              <!--  <div><label class="col-sm-5 col-form-label">Date wise Register :</label> </div> -->
										<div class="row">
										<div class="col-md-3">
                                                     <div class="form-group row" id="unitDiv">
                                                         <label class="col-md-5 col-form-label">Unit:<span class="mandate"><sup>&#9733;</sup></span></label>
                                                         <div class="col-md-7">
                                                             <select class="form-control" id="unitId" name="unitId">
                                                             </select>
                                                            <input type="text" class="auto  form-control" size="8"  name="uid" id ="uid"/>
                                                         </div>
                                                     </div>
                                                 </div>
											<div class="col-md-3">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">From Date<span class="text-red">*</span></label>
													<div class="col-sm-7">
														<div class="dateHolder ">
															<input type="text" 
																class="calDate datePickerInput form-control"
																id="fromDate" placeholder="DD/MM/YYYY" name="fromDate"
																onkeyup="mask(this.value,this,'2,5','/');"
																onblur="validateExpDate(this,'dateId')" maxlength="10" onchange="compareDate()">
														</div>
													</div>
												</div>
											</div>

											<div class="col-md-3">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">To Date<span class="text-red">*</span></label>
													<div class="col-sm-7">
														<div class="dateHolder ">
															<input type="text" 
																class="calDate datePickerInput form-control"
																id="toDate" placeholder="DD/MM/YYYY" name="toDate"
																onkeyup="mask(this.value,this,'2,5','/');"
																onblur="validateExpDate(this,'dateId')" maxlength="10" onchange="compareDate()">
														</div>
													</div>
												</div>
											</div>

											<div class="col-md-1">
												<div class="form-group row">

													<div class="col-sm-10">
													
														<button type="button" class="btn btn-primary  nis-search" id="printReportButtonS"  onclick="search();">Print&nbsp;Report</button>
													</div>
												</div>
											</div>

										</div>
										
										<hr class="m-t-30 m-b-30"/>
								<!-- ---------End Date Wise------- -->
								<div class="m-t-20">
									<h6 class="text-underline font-weight-bold text-theme">Patient wise Register :</h6>   
							    </div>
								<!--  <div><label class="col-sm-5 col-form-label">Patient wise Register :</label> </div> -->
										<div class="row m-b-20">
										
											<div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5 col-form-label">Service No. </label>
                                                            <div class="col-sm-7">
                                                                <input name="serviceNo" id="serviceNo" type="text" class="form-control border-input" placeholder="Service No." value="" onblur="getEmployeeDetails()" />
                                                            </div>
                                                        </div>
                                          </div>

											<div class="col-md-3">
											<div class="form-group row">
                                                 <label class="col-sm-5 col-form-label">Patient Name </label>
                                                 <div class="col-sm-7">
                                                 <input type="text" class="form-control" readonly id="patientName" />
                                                     <!-- <select name="patient_name" id="patientName" type="text" class="form-control border-input" placeholder="Employee No." value=""></select> -->
                                                 </div>
                                             </div>
                                             <input type="hidden"  name="relationId" value="" id="relationId"/>
										</div>
                                        <input type="hidden" class="form-control" readonly id="patientId" />
											<div class="col-md-1">
												<div class="form-group row">

													<div class="col-sm-10">
														<button type="button" class="btn btn-primary  nis-search" id="printReportButtonP" 
															onclick="searchPatient();">Print&nbsp;Report</button>
													</div>
												</div>
											</div>

										</div>		
									<div class="col-md-3">
										<input type="hidden" class="form-control" name="departmentId" id="departmentId"
														 value="<%=departmentId%>" />
										<input type="hidden" class="form-control" id="userId"
											   name="userId"  value="<%=user_id%>">
											   
										<input type="hidden" class="form-control" id="hospitalId"
											   name="hospitalId"  value="<%=hospitalId%>">
											   
									  <!--  <input type="hidden" id="urlForReport" name="urlForReport" value=""> -->
									   
							         </div>
								
									</div>
								</div>
								<!-- end card -->
							</div>
							<!-- end col -->
						</div>
						<!-- end row -->
						<!-- end row -->

					</div>
					<!-- container -->
				</div>
			</div>
		</form>
	</div>

</body>
</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
