<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Indian Coast Guard</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>

<script type="text/javascript">

	var $j = jQuery.noConflict();
	
	$j(document).ready(function()
			{
		GetDistrictList();
		$j("#campDate").val(currentDate());
			});
	
	
	function GetDistrictList(){
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "${pageContext.servletContext.contextPath}/master/getAllDistrict",
		    data: JSON.stringify({"PN" : "0"}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	var combo = "" ;
		    	
		    	for(var i=0;i<result.data.length;i++){
		    		combo += '<option value='+result.data[i].districtId+'>' +result.data[i].districtName+ '</option>';
		    		
		    	}
		    	
		    	jQuery('#district').append(combo);
		    	jQuery('#districtDropDown').append(combo);
		    	
		    }
		    
		});
	}	
	
	 function currentDate(){
		 
		    var currentDate="";
			var now = new Date();
		   	now.setDate(now.getDate());
		   	var day = ("0" + now.getDate()).slice(-2);
		   	var month = ("0" + (now.getMonth() + 1)).slice(-2);
		   	var today = (day)+"/"+(month)+"/"+now.getFullYear();
		   	currentDate=today;
		   	return currentDate;
		 
	 }
	 
	 
	 function exportExcel(){
     	
		 var campDate = $j("#campDate").val();
		 var districtId = $j("#district").val();
		 if(campDate ==''){
			 alert("Please select Camp Date");
			 return false;
		 }
		 
		
	    window.location.href =  "${pageContext.request.contextPath}/mis/exportExcelLabourBeneficiary?campDate="
				+ campDate
				+ "&districtId="
				+ districtId;	
      
      }
	 
	 function exportExcel2(){
	     	
		 var fromDate = $j("#fromDate").val();
		 var toDate = $j("#toDate").val();
		 var districtId = $j("#districtDropDown").val();
		 if(fromDate ==''){
			 alert("Please select from Date");
			 return false;
		 }
		 if(toDate ==''){
			 alert("Please select to Date");
			 return false;
		 }
		 var countDate=getDateComapareValue(fromDate,toDate);
	 	 if(countDate!=0){
	 		 alert("To Date should not be earlier than from Date.");
	 		 return false;
	 	 }	
		
	    window.location.href =  "${pageContext.request.contextPath}/mis/exportExcelLabourBeneficiary2?fromDate="
			+ fromDate
			+ "&toDate="
			+toDate
			+ "&districtId="
			+ districtId;	
      
      }
	 
</script>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">MMSSY Labour Beneficiary Register</div>

				<div class="row">
					<div class="col-12">
						<div class="card"> 
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
									<div class="col-12">
	                               		<h6 class="font-weight-bold text-theme text-underline">Generate Report As On Date</h6>
	                               	</div>
									<div class="col-lg-3 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Camp Date</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" name="" id="campDate" class="noBack_dateReport form-control" value="" placeholder="DD/MM/YYYY" >
												</div>
											</div>
										</div>
									</div>
									
									<div class="col-lg-3 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">District</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="district">
												<option value="0">All</option>
												</select>
											</div>
										</div>
									</div>

									<div class="col-lg-3 col-sm-6">
										
										<button type="button" class="btn btn-primary m-t-3" onclick="exportExcel();">Export Excel</button>
										
									</div>
								</div>
								
								<div class="row">
									<div class="col-12">
	                               		<h6 class="font-weight-bold text-theme text-underline">Generate Report Against Date Range</h6>
	                               	</div>
									<div class="col-lg-3 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">From Date</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text"  name="fromDate" id="fromDate"  class="noBack_dateReport form-control" value="" placeholder="DD/MM/YYYY" >
												</div>
											</div>
										</div>
									</div>
									
									<div class="col-lg-3 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">To Date</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" name="toDate" id="toDate"  class="calDate form-control" value="" placeholder="DD/MM/YYYY" >
												</div>
											</div>
										</div>
									</div>
									
									<div class="col-lg-3 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">District</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="districtDropDown">
												<option value="0">All</option>
												</select>
											</div>
										</div>
									</div>

									<div class="col-lg-3 col-sm-6">
										
										<button type="button" class="btn btn-primary m-t-3" onclick="exportExcel2();">Export Excel</button>
										
									</div>
								</div>
									
				           </div>
						</div>
						<!-- end card -->
					</div>
					<!-- end col -->
				</div>
				<!-- end row -->

			</div>
			<!-- container -->
			<!-- content -->
		</div>
	</div>
	<!-- END wrapper -->

	<!-- jQuery  -->


</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
