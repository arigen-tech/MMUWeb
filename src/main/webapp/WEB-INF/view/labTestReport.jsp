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
	
	//GetCityList();
	//GetClusterList();
	GetDistrictList();
	//$j("#asondate").val(currentDate());
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
	    	jQuery('#clusterDropDown').append(combo);
	    
	    }
	    
	});
}
	
function GetClusterList(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.request.contextPath}/master/getAllCluster",
	    data: JSON.stringify({"PN" : "0","comboVal":"Y"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		combo += '<option value='+result.data[i].clusterId+'>' +result.data[i].clusterName+ '</option>';
	    		
	    	}
	    	
	    	jQuery('#clusterDropDown').append(combo);
	    	
	    	
	    }
	    
	});
}

function GetCityByCluster(){
	$j("#cityIdDropDown").empty();
	$j("#mmuId").empty();
	var districtId=$j("#clusterDropDown option:selected").val();
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getCityByCluster",
	    data: JSON.stringify({"PN" : "0","districtId": districtId}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "" ;
	    	if(result.data!=null && result.data.length!=undefined){
	    	for(var i=0;i<result.data.length;i++){
	    		
	    		combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
	    		
	    	}
	    	$j("#cityIdDropDown").append('<option value=0>All</option>');
	    	jQuery('#cityIdDropDown').append(combo);
	    	$j("#mmuId").append('<option value=0>All</option>');
	    	}else{
	    		$j("#cityIdDropDown").append('<option value=0>All</option>');
	    		$j("#mmuId").append('<option value=0>All</option>');
	    	}
	    	
	    }
	    
	});
}

function GetMMUCityByCluster(){
	$j("#mmuId").empty();
	var cityId=$j("#cityIdDropDown option:selected").val();
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getMMUByCityCluster",
	    data: JSON.stringify({"PN" : "0","cityId": cityId}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		
	    		combo += '<option value='+result.data[i].mmuId+'>' +result.data[i].mmuName+ '</option>';
	    		
	    	}
	    	$j("#mmuId").append('<option value=0>All</option>');
	    	jQuery('#mmuId').append(combo);
	    	
	    }
	    
	});
}

function generateReport(){
	 var mmuId= $j("#mmuId").val();
	var clusterId= $j("#clusterDropDown").val();
	var cityId= $j("#cityIdDropDown").val();
	 var fromDate = $j("#fromDate").val();
	 var toDate = $j("#toDate").val()
	/*  if(clusterId ==''){
		 alert("Please select Cluster");
		 return false;
	 }
	 if(cityId =='' || cityId =="0"){
		 alert("Please select city");
		 return false;
	 }
	 if(mmuId =='' || mmuId =="0"){
		 alert("Please select MMU");
		 return false;
	 } */
	 if(fromDate ==''){
		 alert("Please select From Date");
		 return false;
	 }
	 if(toDate ==''){
		 alert("Please select To Date");
		 return false;
	 }
	 
	var countDate=getDateComapareValue(fromDate,toDate);
	 if(countDate!=0){
		 alert("To Date should not be earlier than from Date.");
		 return false;
	 }
	 
   var url = "${pageContext.request.contextPath}/report/printLabReport?fromDate="
	+ fromDate
	+ "&toDate="
	+ toDate
	+ "&mmuId="
	+ mmuId
	+ "&clusterId="
	+ clusterId
	+ "&cityId="
	+ cityId;
    openPdfModel(url)

 }
 
function exportExcel(){
	    
    var mmuId= $j("#mmuId").val();
 	var clusterId= $j("#clusterDropDown").val();
 	var cityId= $j("#cityIdDropDown").val();
 	var fromDate = $j("#fromDate").val();
	 var toDate = $j("#toDate").val()
/* 	 if(clusterId ==''){
		 alert("Please select Cluster");
		 return false;
	 }
	 if(cityId =='' || cityId =="0"){
		 alert("Please select city");
		 return false;
	 }
	 if(mmuId =='' || mmuId =="0"){
		 alert("Please select MMU");
		 return false;
	 }
 */	 if(fromDate ==''){
		 alert("Please select From Date");
		 return false;
	 }
	 if(toDate ==''){
		 alert("Please select To Date");
		 return false;
	 }
	 var countDate=getDateComapareValue(fromDate,toDate);
	 if(countDate!=0){
		 alert("To Date should not be earlier than from Date.");
		 return false;
	 }
	
	 
	 window.location.href = "${pageContext.request.contextPath}/mis/exportLabReports?fromDate="
	+ fromDate
	+ "&toDate="
	+ toDate
	+ "&mmuId="
	+ mmuId
	+ "&clusterId="
	+ clusterId
	+ "&cityId="
	+ cityId;
  
  }
  

/* function getDateComapareValue(fromDate,toDate){
	 var countDateV=0;
	 
	 var fCurrentDateVal=fromDate.split("/");
		var fddate=fCurrentDateVal[0];
		var fmonth=fCurrentDateVal[1];
		var fyear=fCurrentDateVal[2];
		var fUpdateDate=fCurrentDateVal[1]+"/"+fCurrentDateVal[0]+"/"+fCurrentDateVal[2];
		
		 var tCurrentDateVal=toDate.split("/");
			var tddate=tCurrentDateVal[0];
			var tmonth=tCurrentDateVal[1];
			var tyear=tCurrentDateVal[2];
		
			var tUpdateDate=tCurrentDateVal[1]+"/"+tCurrentDateVal[0]+"/"+tCurrentDateVal[2];	
	 var g1 = new Date(fUpdateDate); 
	    var g2 = new Date(tUpdateDate); 
	    if (g1.getTime() > g2.getTime()){
	    	 
	    	countDateV+=1;
	    	return countDateV;
	    }
	    if (g2.getTime() < g1.getTime()){
	    	 
	    	countDateV+=1;
	    	return countDateV;
	    }
	    return countDateV;
}
 */
  
 
</script>

</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">Lab Test Report</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
	                               	 	<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">District</label>
											</div>
											<div class="col-md-6">
												<select class="form-control" id="clusterDropDown" onchange="GetCityByCluster()">
												<option value="0">All</option>
												</select>
											</div>
										</div>
									</div>
	                               	<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">City<!-- <span class="mandate"><sup>&#9733;</sup></span> --></label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="cityIdDropDown" onchange="GetMMUCityByCluster(this)">
												<option value="0">All</option>
												</select>
											</div>
										</div>
									</div>
									<div class="w-100"></div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">MMU</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="mmuId">
												<option value="0">All</option>
												</select>
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">From Date<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
											<div class="dateHolder">
												<input type="text" name="fromDate" id="fromDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" >
											</div>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">To Date<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
											<div class="dateHolder">
												<input type="text" name="toDate" id="toDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" >
											</div>
											</div>
										</div>
									</div>
									
									

									<div class="col-12 text-right">
										
										<button type="button" class="btn btn-primary m-t-3" onclick="exportExcel()">Generate Excel</button>
										<button type="button" class="btn btn-primary m-t-3" onclick="generateReport()">Generate PDF</button>
										
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
