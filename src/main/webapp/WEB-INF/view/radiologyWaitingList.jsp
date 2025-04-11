
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<title>Radiology Waiting List</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>

</head>
<script type="text/javascript" language="javascript">
	
	<%			
	String hospitalId = "1";
	if (session.getAttribute("hospital_id") !=null)
	{
		hospitalId = session.getAttribute("hospital_id")+"";
	}
	String user_id = "0";
	if (session.getAttribute("user_id") != null) {
		user_id = session.getAttribute("user_id") + "";
	}

	String departmentId = "1402";
	if (session.getAttribute("department_id") != null) {
		departmentId = session.getAttribute("department_id") + "";
	}
	%>
		var nPageNo = 1;
	var $j = jQuery.noConflict();

	$j(document).ready(function() {
		getRadiologyWaitingList('ALL');

	});

	function getRadiologyWaitingList(MODE) {
		//alert("inside getReferredList");
		var cmdId = 0;
		var service_no = $j('#service_no').val();
		var patientName = $j('#patient_name').val();
		var mobileNo = $j('#mobile_no').val();
		
		if (service_no === undefined) {
			service_no = "";
		}
		if(patientName === undefined){
			patientName = "";
		}
		if(mobileNo === undefined){
			mobileNo = "";
		}

		if (MODE == 'ALL') {
			var data = {"hospitalId" :<%=hospitalId%>,"serviceNo" : "", "patientName":"", "mobileNo":"", "pageNo" : nPageNo}

		} else {
			var data = {"hospitalId" :<%=hospitalId%>,"serviceNo" : service_no, "patientName":patientName, "mobileNo":mobileNo, "pageNo" : nPageNo}

		};

		var bClickable = true;
		var url = "getradiologyWaitingList";
		GetJsonData('tblListofRadiology', data, url, bClickable);
	}

	function search() {
		
		var service_no = $j('#service_no').val();
		var patientName = $j('#patient_name').val();
		var mobileNo = $j('#mobile_no').val();
		if ((service_no == undefined || service_no == '')
				&& (patientName == undefined || patientName == '')
				&& (mobileNo == undefined || mobileNo == '')) {
			alert("Atleast one of the search option must be entered");
			return;
		}
		getRadiologyWaitingList('Filter');
	}

	function makeTable(jsonData) {
		var htmlTable = "";
		var data = jsonData.count;

		var pageSize = 5;
		var dataList = jsonData.radiologyList;
		console.log("dataList "+dataList);
		for (i = 0; i < dataList.length; i++) {

			htmlTable = htmlTable + "<tr id='"+dataList[i].dgId+"'>";
			htmlTable = htmlTable + "<td style='width: 100px;'>"
					+ dataList[i].date + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>"
					+ dataList[i].serviceNo + "</td>";
			htmlTable = htmlTable + "<td style='width: 150px;'>"
					+ dataList[i].name + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>"
					+ dataList[i].age + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>"
					+ dataList[i].sex + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>"
					+ dataList[i].relation + "</td>";
			htmlTable = htmlTable + "<td style='width: 200px;'>"
					+ dataList[i].investigationName + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>"
					+ dataList[i].modality + "</td>";
		
			htmlTable = htmlTable + "</tr>";
			//style="display: none"
		}

		if (dataList.length == 0) {
			htmlTable = htmlTable
					+ "<tr ><td colspan='9'><h6>No Record Found !!</h6></td></tr>";
		}

		$j("#tblListofRadiology").html(htmlTable);

	}

	function executeClickEvent(Id) {	
		
		window.location="radiologyResultEntry?id="+Id+"&userId="+<%= user_id %>+"";		
		
	}	

	function ResetForm() {
		$j('#service_no').val('');
		$j('#patient_name').val('');
		$j('#mobile_no').val('');
	}

	function showResultPage(pageNo) {

		nPageNo = pageNo;
		getRadiologyWaitingList('FILTER');

	}
	
	 function showAll()
	 {
	 	ResetForm();
	 	nPageNo = 1;	
	 	getRadiologyWaitingList('ALL');	 	
	 }

</script>
<body>
 <!-- Begin page -->
    <div id="wrapper">

	<div class="content-page">
		<!-- Start content -->
		<div class="">
			<div class="container-fluid">
				<div class="internal_Htext">Radiology Waiting List</div>
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">

								<form>
									<div class="row">
										<div class="col-md-3">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Service No.</label>
												<div class="col-sm-7">
													<input class="form-control  form-control-sm"
														id="service_no"> </input>
												</div>
											</div>
										</div>		
										<div class="col-md-3">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Patient Name</label>
												<div class="col-sm-7">
													<input class="form-control  form-control-sm"
														id="patient_name"> </input>
												</div>
											</div>
										</div>
										<div class="col-md-3">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Mobile No.</label>
												<div class="col-sm-7">
													<input class="form-control  form-control-sm"
														id="mobile_no"> </input>
												</div>
											</div>
										</div>								 

										<div class="col-md-1">
											<div class="form-group row">
												<div class="col-sm-12">
													<button type="button" class="btn btn-primary"
														onclick="search()">Search</button>
												</div>
											</div>
										</div>
										<div class="col-md-2">
											<div class="form-group row">
												<div class="col-sm-12">
												
													 <div class="btn-right-all obesityWait-search">
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
										<table class="table table-bordered  table-striped table-hover">
											<thead bgcolor="00FFFF">
												<tr>
													<th id="th1">Date</th>
													<th id="th2">Service No.</th>
													<th id="th3">Name</th>
													<th id="th4">Age</th>
													<th id="th5">Gender</th>
													<th id="th6">Relation</th>
													<th id="th6">Investigation</th>
													<th id="th6">Modality</th>
												</tr>
											</thead>
											<tbody id="tblListofRadiology">
											</tbody>
										</table>									

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