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
		$j("#asondate").val(currentDate());
		$j("#asonDate2").val(currentDate());
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
		    	jQuery('#clusterDropDown2').append(combo);
		    }
		    
		});
	}
	
	 function GetCityList(){
			jQuery.ajax({
			 	crossOrigin: true,
			    method: "POST",			    
			    crossDomain:true,
			    url: "${pageContext.servletContext.contextPath}/master/getAllCity",
			    data: JSON.stringify({"PN" : "0"}),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	var combo = "" ;
			    	combo += "<option value=\"0\">All</option>" ;
			    	for(var i=0;i<result.data.length;i++){
			    		combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
			    		
			    	}
			    	
			    	jQuery('#cityId').append(combo);
			    	jQuery('#cityIdDropDown').append(combo);
			    	
			    }
			    
			});
		}
	
	 function getMMUList(item){
		  var params;
		  if(item != ''){
			  var cityId = item.value;
			  params = {
						"cityId":cityId
				}
		  }else{
			  params = { };
		  }
		 
			
			$.ajax({
				type : "POST",
				contentType : "application/json",
				url : '${pageContext.servletContext.contextPath}/registration/getMMUList',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(data) {
					if(data.status == true){
						var list = data.list;
						var mmuDrop = '';
						$j('#mmuId').find('option').not(':first').remove();
						for(i=0;i<list.length;i++){
							mmuDrop += '<option value='+list[i].mmuId+'>'+list[i].mmuName+'</option>';
						}
						$j('#mmuId').append(mmuDrop);
					}
				},
				error : function(data) {
					alert("An error has occurred while contacting the server");
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
     	    
	    var mmuId= $j("#mmuId").val();
     	var clusterId= $j("#clusterDropDown").val();
     	var cityId= $j("#cityIdDropDown").val();
		 var campDate = currentDate()//$j("#asondate").val()
		/* if(clusterId ==''){
			 alert("Please select Cluster");
			 return false;
		 }
		 if(cityId ==''){
			 alert("Please select city");
			 return false;
		 }
		 if(mmuId =='' || mmuId =="0"){
			 alert("Please select MMU");
			 return false;
		 }*/
		 /* if(campDate ==''){
			 alert("Please select Camp Date");
			 return false;
		 } */
		 
		 window.location.href = "${pageContext.request.contextPath}/mis/exportEdlReports?asondate="
		+ campDate
		+ "&mmuId="
		+ mmuId
		+ "&clusterId="
		+ clusterId
		+ "&cityId="
		+ cityId;
      
      }
	 
	 function exportExcel2(){
  	    
		    var mmuId= 0;
	     	var clusterId= $j("#clusterDropDown2").val();
	     	var cityId= $j("#cityId2").val();
			 var campDate =currentDate() //$j("#asonDate2").val()
			 /*if(clusterId ==''){
				 alert("Please select Cluster");
				 return false;
			 }
			 if(cityId ==''){
				 alert("Please select city");
				 return false;
			 }*/
			 /* if(campDate ==''){
				 alert("Please select Camp Date");
				 return false;
			 } */
			 
			 window.location.href = "${pageContext.request.contextPath}/mis/exportEdlReportsCityWise?asondate="
			+ campDate
			+ "&mmuId="
			+ mmuId
			+ "&clusterId="
			+ clusterId
			+ "&cityId="
			+ cityId;
	      
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
			    	jQuery('#clusterDropDown2').append(combo);
			    	//jQuery('#selectClusterName').append(combo);
			    	
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
			    	if(result.data!=null && result.data.length!=undefined)
			    	for(var i=0;i<result.data.length;i++){
			    		
			    		combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
			    		
			    	}
			    	$j("#cityIdDropDown").append('<option value=0>All</option>');
			    	jQuery('#cityIdDropDown').append(combo);
			    	$j("#mmuId").append('<option value=0>All</option>');
			    }
			    
			});
		}
	 function GetCityByCluster2(){
			$j("#cityId2").empty();
			var districtId=$j("#clusterDropDown2 option:selected").val();
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
			    	if(result.data!=null && result.data.length!=undefined)
			    	for(var i=0;i<result.data.length;i++){
			    		
			    		combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
			    		
			    	}
			    	$j("#cityId2").append('<option value=0>All</option>');
			    	jQuery('#cityId2').append(combo);
			    	
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
			    	if(result!=null && result.data!=null && result.data.length>0){
			    	for(var i=0;i<result.data.length;i++){
			    		
			    		combo += '<option value='+result.data[i].mmuId+'>' +result.data[i].mmuName+ '</option>';
			    		
			    	}
			    	$j("#mmuId").append('<option value=0>All</option>');
			    	jQuery('#mmuId').append(combo);
			    	}
			    	else{
			    		$j("#mmuId").append('<option value=0>All</option>');
			    	}
			    }
			    
			});
		}
	 
	 function generateReport(){
     	 var mmuId= $j("#mmuId").val();
     	var clusterId= $j("#clusterDropDown").val();
     	var cityId= $j("#cityIdDropDown").val();
     	var campDate ="";
	//	 var campDate = $j("#asondate").val()
		/*  if(clusterId ==''){
			 alert("Please select Cluster");
			 return false;
		 }
		 if(cityId ==''){
			 alert("Please select city");
			 return false;
		 }
		 if(mmuId =='' || mmuId =="0"){
			 alert("Please select MMU");
			 return false;
		 } */
	/* 	 if(campDate ==''){
			 alert("Please select Camp Date");
			 return false;
		 } */
		 
        var url = "${pageContext.request.contextPath}/report/printEdlReport?campDate="
		+ campDate
		+ "&mmuId="
		+ mmuId
		+ "&clusterId="
		+ clusterId
		+ "&cityId="
		+ cityId;
         openPdfModel(url)

      }
	 
	 function generateReport2(){
     	 var mmuId= 0;
     	var clusterId= $j("#clusterDropDown2").val();
     	var cityId= $j("#cityId2").val();
     	var campDate = "";
		 //var campDate = $j("#asonDate2").val()
		
		 /* if(campDate ==''){
			 alert("Please select Camp Date");
			 return false;
		 }
		  */
        var url = "${pageContext.request.contextPath}/report/printEdlReportCityWise?campDate="
		+ campDate
		+ "&mmuId="
		+ mmuId
		+ "&clusterId="
		+ clusterId
		+ "&cityId="
		+ cityId;
         openPdfModel(url)

      }
	 
</script>


</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">EDL Report</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
									<div class="col-12">
	                               		<h6 class="font-weight-bold text-theme text-underline">MMU Wise</h6>
	                               	</div>
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
									
									<!-- <div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Date<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
											<div class="dateHolder">
												<input type="text" name="" id="asondate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" >
											</div>
											</div>
										</div>
									</div>
									 -->
									

									<div class="col-12 text-right">
										
										<button type="button" class="btn btn-primary m-t-3" onclick="exportExcel()">Generate Excel</button>
										<button type="button" class="btn btn-primary m-t-3" onclick="generateReport()">Generate PDF</button>
										
									</div>
								</div>
								
								<div class="row">
									<div class="col-12">
	                               		<h6 class="font-weight-bold text-theme text-underline">City Wise</h6>
	                               	</div>
	                               		<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">District</label>
											</div>
											<div class="col-md-6">
												<select class="form-control" id="clusterDropDown2" onchange="GetCityByCluster2()">
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
												<select class="form-control" id="cityId2">
												<option value="0">All</option>
												</select>
											</div>
										</div>
									</div>
																		
									<!-- <div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Date<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
											<div class="dateHolder">
												<input type="text" name="" id="asonDate2" class="calDate form-control" value="" placeholder="DD/MM/YYYY" >
											</div>
											</div>
										</div>
									</div>
									 --><div class="col-12 text-right">
										
										<button type="button" class="btn btn-primary m-t-3" onclick="exportExcel2()">Generate Excel</button>
										<button type="button" class="btn btn-primary m-t-3" onclick="generateReport2()">Generate PDF</button>
										
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
