<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Indian Coast Guard</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	

<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/pendingSampleValidate.js"></script> --%>
 <%
	String hospitalId = "";
	if (session.getAttribute("hospital_id") != null) {
		hospitalId = session.getAttribute("hospital_id") + "";
	}
	String userId = "";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	
	 String departmentId = "";
	if (session.getAttribute("department_id") != null) {
		departmentId = session.getAttribute("department_id") + "";
	} 
	
%>


<%@include file="..//view/commonJavaScript.jsp"%>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">


		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">Pending For Sample Validation</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<%-- <form class="form-horizontal" id="pendingSampleValidationForm"	name="pendingSampleValidationForm" method="" role="form"> --%>
									<%-- <input type="hidden" class="form-control" id="departmentId" name="departmentId"  value="<%=departmentId %>"/> --%>
									<%-- <input type="hidden" name="hospitalId" id="hospitalId" value="<%=hospitalId %>" />
									<input type="hidden" name="userId" id="userId" value="<%=userId %>" /> --%>
										
										<div>
											<div class="row">
											<!-- <div class="col-md-12">
												<h4 class="service_htext">Patient Search</h4>
											</div> -->
											 
									
											
											<div class="col-md-3">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Service No.</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="serviceNo" name="serviceNo" class="form-control" placeholder="Enterable" autocomplete="off" />
													</div>
												</div>
											</div>
											
											<div class="col-md-3">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Patient Name</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="patientName" name="patientName" class="form-control" placeholder="Enterable" autocomplete="off"/>
													</div>
												</div>
											</div>
											
											<div class="col-md-3">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Mobile No.</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="mobileNo" name="mobileNo" class="form-control" placeholder="Enterable" autocomplete="off" onkeypress="return validateMobileNo('mobileNo', 10, 'Mobile Number');"/>
													</div>
												</div>
											</div>
											
											<!-- <div class="col-md-1">
												<div id="loadingDiv" style="display: none;">
													<img src="/AshaWeb/resources/images/ajax-loader.gif">
												</div>
											</div> -->
											
											
										<div class="col-md-3">
											<div class="form-group row">
												<div class="col-sm-12">
												
													 <div class="btn-right-all obesityWait-search">
													 	<button type="button" class="btn btn-primary"
														onclick="searchPendingSampleValidationList()">Search</button>
														
														<button type="button" class="btn  btn-primary "
													onclick="showAll('ALL');">Show All</button>
														</div>
												</div>
											</div>
										</div>
											
									</div>
											
											<div style="float: left">
											<table class="tblSearchActions" cellspacing="0"
												cellpadding="0" border="0">
												<tr>
													<td class="SearchStatus" style="font-size: 15px;"
														align="left">Search Results</td>
												</tr>
											</table>
										</div>
										<div style="float: right">
											<div id="resultnavigation"></div>
										</div>
										<!-- <div class="col-md-12"><p align="Left" id="message"	style="color: green; font-weight: bold;"></p></div> -->
									<%-- </form> --%>
									<div id="tblpendingSampleValidationDetails" style="display:none" >
									<!-- <h5 style="font-weight:600;">List of Patient Details</h5> -->
									<table class="table table-hover table-striped table-bordered m-t-10">
										<thead class="bg-primary">
											<tr>
												<th>S.No</th>
												<th>Sample Date/Time</th>
												<th>Order No.</th>
												<th>Service No.</th>
												<th>Emp Name</th>
												<th>Patient Name</th>
												<th>Relation</th>
												<th>Age</th>
												<th>Gender</th>
												<th>Department</th>
												<th>Modality</th>
											</tr>
										</thead>
										<tbody id="tblPendingSampleValidationList">
											
										</tbody>
									</table>
								</div>
								</div>
								<%-- </form>	 --%>
									</div>

								</div>
							</div>
						</div>
					</div>

				</div>
				<!-- container -->

			</div>
			<!-- content -->

		</div>

		<!-- ============================================================== -->
		<!-- End Right content here -->
		<!-- ============================================================== -->

	<!-- END wrapper -->

</body>
<script type="text/javascript">

//getPendingSampleValidateListGrid onload
	var nPageNo = 1;
	$j(document).ready(function()
			{
			GetSampleValidationWaitingList('ALL');
					
			});
	function GetSampleValidationWaitingList(MODE){
		var serviceNo = $j('#serviceNo').val();	
		var patientName = $j('#patientName').val();
		var mobileNumber = $j('#mobileNo').val();
		
		if (serviceNo === undefined) {
			serviceNo = "";
		}
		if(patientName === undefined){
			patientName = "";
		}
		if(mobileNumber === undefined){
			mobileNumber = "";
		}
		
		if (MODE == 'ALL') {
			var data = {"hospitalId" :<%=hospitalId%>,"serviceNo" : "", "patientName":"", "mobileNumber":"", "pageNo" : nPageNo}

		} else {
			var data = {"hospitalId" :<%=hospitalId%>,"serviceNo" : serviceNo, "patientName":patientName, "mobileNumber":mobileNumber, "pageNo" : nPageNo}

		};
		
		var url = "getPendingSampleValidateListGrid";		
		var bClickable = true;
		GetJsonData('tblPendingSampleValidationList',data,url,bClickable);	 
	}

function searchPendingSampleValidationList(){
	var serviceNo = $j('#serviceNo').val();	
	var patientName = $j('#patientName').val();
	var mobileNumber = $j('#mobileNo').val();
	
	if((serviceNo == undefined || serviceNo == '') && (mobileNumber == undefined || mobileNumber == '') && (patientName == undefined || patientName == '')){	
		alert("At least one option must be entered");
		return false;
		$j('#loadingDiv').hide();
	}
	GetSampleValidationWaitingList('Filter');
	
}

<%-- function getSampleValidationList(serviceNo,patientName,mobileNumber){
	
	$j('#loadingDiv').show();
	if(serviceNo!=null && serviceNo!=''){
		var params = {"serviceNo": serviceNo, "hospitalId":<%=hospitalId%>, "userId":<%=userId%>}
        var data = params;					
        var url = "getPendingSampleValidate";
        var bClickable = true;
          GetJsonData('tblPendingSampleValidationList', data, url, bClickable); 
	}
	
	if (patientName!=null && patientName!= ''){
		var params = {"patientName":patientName, "userId":<%=userId%>, "hospitalId":<%=hospitalId%>}
        var data = params;				
        var url = "getPendingSampleValidate";
        var bClickable = true;
          GetJsonData('tblPendingSampleValidationList', data, url, bClickable); 
	}
	
	if (mobileNumber!=null && mobileNumber!=''){
		var params = {"mobileNo":mobileNumber, "userId":<%=userId%>, "hospitalId":<%=hospitalId%>}
        var data = params;				
        var url = "getPendingSampleValidate";
        var bClickable = true;
          GetJsonData('tblPendingSampleValidationList', data, url, bClickable); 
	}
} --%>


function makeTable(jsonData) {
	
	 var htmlTable = "";
    if(jsonData.status==1){
	   var data = jsonData.count;
	   var dataList = jsonData.data;
	    var counter = 1;
	   var subchargeCodeId='';
	   for(i=0;i<dataList.length;i++){
		  
		  // alert(dataList[i].investigationType);
		  subchargeCodeId = dataList[i].subchargeCodeId;
		    	htmlTable = htmlTable+"<tr id='"+dataList[i].sampleCollectionHeaderId+"@"+dataList[i].subchargeCodeId+"' >";
		    	htmlTable = htmlTable +"<td style='width: 150px;'>"+counter+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].sampleDateTime+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].orderNumber+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].serviceNo+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].employeeName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].patientName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].relation+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].age+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].gender+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].departmentName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].subchargeCodeName+"</td>";
				htmlTable = htmlTable +"<td style='display:none;'>"+dataList[i].subchargeCodeId+"</td>";
				htmlTable = htmlTable +"<td style='display:none;'>"+dataList[i].investigationType+"</td>";
				htmlTable = htmlTable+"</tr>";
				counter++;
	      }
	   
		  $j('#message').html('');
	      $j("#tblPendingSampleValidationList").html(htmlTable);
		  $j('#tblpendingSampleValidationDetails').show();
		  $j('#loadingDiv').hide();
	}else{    	
		 $j('#tblpendingSampleValidationDetails').hide();
		 $j("#tblPendingSampleValidationList").empty();
		 $j('#message').html(jsonData.msg);
		 $j('#loadingDiv').hide();
	}
    
}

function resetText(){
	//$j('#serviceNo').
	$(document).ready(function() {
		$j('#serviceNo').val('');
		$j('#patientName').val('');
		$j('#mobileNo').val('');
	});
}

function executeClickEvent(id) {
	
	var fields = id.split('@');

	var sampleCollectionHeaderId = fields[0];
	var subchargeCodeId = fields[1];
	var investigationType = fields[2];
	
	//alert("sampleCollectionHeaderId :: "+sampleCollectionHeaderId +"subchargeCodeId :: "+subchargeCodeId +"investigationType :: "+investigationType);
	window.location="pendingSampleValidateDetails?sampleCollectionHeaderId="+sampleCollectionHeaderId+"&subchargeCodeId="+subchargeCodeId+"";
}


$(function() {
    // setTimeout() function will be fired after page is loaded
    // it will wait for 5 sec. and then will fire
    // $("#successMessage").hide() function
    setTimeout(function() {
        $("#successMessage").hide('blind', {}, 500)
    }, 5000);
});

	function validateMobileNo(id,length,data){	
		if($j("#"+id).val().length >= length){
			 alert("Length of "+data+" should not be greater than "+length);
			 
			 var str=  $j("#"+id).val();
			 str=str.substring(0,length).trim();
			 
			 $j("#"+id).val(str);
			 return false;
		 }
	}
	
	function showResultPage(pageNo) {

		nPageNo = pageNo;
		GetSampleValidationWaitingList('FILTER');

	}
	
	 function showAll()
	 {
	 	ResetForm();
	 	nPageNo = 1;	
	 	GetSampleValidationWaitingList('ALL');	 	
	 }
	 
		function ResetForm() {
			$j('#serviceNo').val('');	
			$j('#patientName').val('');
			$j('#mobileNo').val('');
		}

	
</script>
</html>