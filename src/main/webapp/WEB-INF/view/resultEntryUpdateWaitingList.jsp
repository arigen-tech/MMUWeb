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

<%
	String hospitalId = null;
	if (session.getAttribute("mmuId") != null) {
		hospitalId = session.getAttribute("mmuId") + "";
	}
	String userId = null;
	if (session.getAttribute("userId") != null) {
		userId = session.getAttribute("userId") + "";
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
					<div class="internal_Htext">Result Updation Waiting List</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
							<div class="card-body">
								<div>
										<div class="row">
											<!-- <div class="col-md-12">
												<h6 class="service_htext">Patient Search</h6>
											</div> -->
											
											<!-- <div class="col-md-3">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Bar Code Search</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control"/>
													</div>
												</div>
											</div> -->
											
											<div class="w-100"></div>
											
											<div class="col-md-3">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Mobile No.</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control" id="mobilenumber" name="mobilenumber" placeholder="Enterable"/>
													</div>
												</div>
											</div>
											
											<div class="col-md-3">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Patient Name</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control" id="patientName" name="patientName" placeholder="Enterable"/>
													</div>
												</div>
											</div>
											
										
											
											<div class="col-md-1">
											<div class="form-group row">
												<div class="col-sm-12">
													<button type="button" class="btn btn-primary"
														onclick="searchResultEntryUpdateWaitingList()">Search</button>
												</div>
											</div>
										</div>
										<div class="col-md-2">
											<div class="form-group row">
												<div class="col-sm-12">
												
													 
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
									<div id="tblWaitingResultValidationDetails" style="display:none "
												class="right_col" role="main" style="padding:0.5% 1.8%;" >
												<div class="clearfix"></div>
												<!-- <h5 style="font-weight:600;">List of Patient Details</h5> -->
									<table class="table table-hover table-striped table-bordered m-t-10">
										<thead class="bg-primary">
											<tr>
												<th>Diag No.</th>
												<th>Result Date</th>
												<th>Result Time</th>
												<th>Patient Name</th>
												<th>Mobile No</th>
												
												<th>Department Name</th>
												<th>Modality</th>
											</tr>
										</thead>
										<tbody id="tblListOfResultEntryUpdateWaitingList">
											
										</tbody>
									</table>
									</div>
									</div>
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
var mobileNumber ="";
$j(document).ready(function()
		{
		  mobileNumber = ${mobileNumber} 
		if(mobileNumber!=null && mobileNumber!=undefined && mobileNumber!="0"){
		$j('#mobilenumber').val(mobileNumber);
			GetResultEntryUpdateWaitingList('Filter');
		}	
		});
	
function searchResultEntryUpdateWaitingList(){
	
	
	var mobileNumber = $j('#mobilenumber').val()
	var patientName = $j('#patientName').val()	
	
	if((mobileNumber == undefined || mobileNumber == '') && (patientName == undefined || patientName == '')){	
		alert("At least one option must be entered");
		$j('#loadingDiv').hide();	
		return false;
	}
	GetResultEntryUpdateWaitingList('Filter');
}

function GetResultEntryUpdateWaitingList(MODE){
	
	
	var mobileNumber = $j('#mobilenumber').val()
	var patientName = $j('#patientName').val()	
	
	//alert(mobileNumber)
	
	
	if(patientName === undefined){
		patientName = "";
	}
	if(mobileNumber === undefined){
		mobileNumber = "";
	}
	
	if (MODE == 'ALL') {
		var data = {"hospitalId" :<%=hospitalId%>, "patientName":"", "mobileNumber":"", "pageNo" : nPageNo}

	} else {
		var data = {"hospitalId" :<%=hospitalId%>,"patientName":patientName, "mobileNumber":mobileNumber, "pageNo" : nPageNo}

	};

	var url = "getResultUpdateWaitingList";		
	var bClickable = true;
	GetJsonData('tblListOfResultEntryUpdateWaitingList',data,url,bClickable);	 
}

function makeTable(jsonData) {
	
	 var htmlTable = "";
    if(jsonData.status==1){
   var data = jsonData.count;
   
   var dataList = jsonData.data;
   
   for(i=0;i<dataList.length;i++){	
		    	htmlTable = htmlTable+"<tr id='"+dataList[i].resultEntHdId+"' >";			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].diagNo+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].resultDate+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].resulttime+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].patientName+"</td>";
				
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].mobileNumber+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].departmentName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].subChargecodeName+"</td>";	
				htmlTable = htmlTable+"</tr>";
	    	  
	      }
		  $j('#message').html('');
	      $j("#tblListOfResultEntryUpdateWaitingList").html(htmlTable);
		  $j('#tblWaitingResultValidationDetails').show();
		  $j('#loadingDiv').hide();
	}else{
		
		 $j('#tblWaitingResultValidationDetails').hide();
		 $j("#tblListOfResultEntryUpdateWaitingList").empty();
		 $j('#message').html(jsonData.msg);
		 $j('#loadingDiv').hide();
	}
	
}

function executeClickEvent(resultEntHdId) {
		//alert(resultEntHdId);
		window.location="getResultUpdateDetails?resultEntryHdId="+resultEntHdId+"";
		
	}

function ResetForm() {
	$j('#serviceNo').val('');
	$j('#patientName').val('');
	$j('#mobilenumber').val('');
	
}

function showResultPage(pageNo) {

	nPageNo = pageNo;
	GetResultEntryUpdateWaitingList('FILTER');

}

 function showAll()
 {
 	ResetForm();
 	nPageNo = 1;	
 	GetResultEntryUpdateWaitingList('ALL');	 	
 }
</script>
</html>