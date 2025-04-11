<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<title>Pending List of pre-consultation (Online)</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>

</head>
<script type="text/javascript" language="javascript">
	
	<%			
	String mmuId = "0";
	if (session.getAttribute("mmuId") != null) {
		mmuId = session.getAttribute("mmuId") + "";
	}
	String userId = "1";
	if (session.getAttribute("userId") != null) {
		userId = session.getAttribute("userId") + "";
	}
	
	String departmentId = "2";
	if (session.getAttribute("departmentId") != null) {
		departmentId = session.getAttribute("departmentId") + "";
	}
	
	String departmentName = "";
	if (session.getAttribute("departmentName") != null) {
		departmentName = session.getAttribute("departmentName") + "";
	}
	
	String campId = "33";
	if (session.getAttribute("campId") != null) {
		campId = session.getAttribute("campId") + "";
	}
	
	String cityName = "";
	if (session.getAttribute("cityName") != null) {
		cityName = session.getAttribute("cityName") + "";
	}
	
	%>
		var nPageNo = 1;
	var $j = jQuery.noConflict();

	$j(document).ready(function() {
		getPreConsultationWaitingListOnline('ALL');
		$j('#patientName').focus();
		
		var cityLocation = "<%= cityName %>";
		var departmentName = "<%= departmentName %>";
		var campLoation = cityLocation +" - "+departmentName;
		if(campLoation.trim() != "-"){
			$('#camp_location').val(cityLocation +" - "+departmentName);
		}

	});

	function getPreConsultationWaitingListOnline(MODE) {
		//alert("inside getReferredList");
		var cmdId = 0;
		var patientName = $j('#patientName').val();
		var mobileNo = $j('#mobileNo').val();
		
		if(patientName === undefined){
			patientName = "";
		}
		if(mobileNo === undefined){
			mobileNo = "";
		}

		if (MODE == 'ALL') {
			var data = {"patientName" :"","mmuId":"<%= mmuId %>","mobileNo":"", "pageNo" : nPageNo}

		} else {
			var data = {"patientName" :patientName,"mmuId":"<%= mmuId %>","mobileNo":mobileNo, "pageNo" : nPageNo}

		};

		var bClickable = true;
		var url = "getOnlinePatientList";
		GetJsonData('tblListofPatient', data, url, bClickable);
	}

	function search() {
		
		var patientName = $j('#patientName').val();
		var mobileNo = $j('#mobileNo').val();
		if ((patientName == undefined || patientName == '')
				&& (mobileNo == undefined || mobileNo == '')) {
			alert("Atleast one of the search option must be entered");
			return;
		}
		getPreConsultationWaitingListOnline('Filter');
	}

	function makeTable(jsonData) {
		var htmlTable = "";
		var data = jsonData.count;

		var pageSize = 5;
		var dataList = jsonData.list;
		console.log("dataList "+dataList);
		for (i = 0; i < dataList.length; i++) {

			htmlTable = htmlTable + "<tr id='"+dataList[i].visitId+"'>";
			htmlTable = htmlTable + "<td style='width: 100px;'>"
					+ dataList[i].patientName + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>"
					+ dataList[i].mobileNo + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>"
					+ dataList[i].age + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>"
					+ dataList[i].gender + "</td>";
		
			htmlTable = htmlTable + "</tr>";
		}

		if (dataList.length == 0) {
			htmlTable = htmlTable
					+ "<tr ><td colspan='4'><h6>No Record Found !!</h6></td></tr>";
		}

		$j("#tblListofPatient").html(htmlTable);

	}

	function executeClickEvent(Id) {	
		
		window.location="getPatientDataBasedOnVisit?visitId="+Id+"";		
		
	}	

	function ResetForm() {
		$j('#patientName').val('');
		$j('#mobileNo').val('');
	}

	function showResultPage(pageNo) {

		nPageNo = pageNo;
		getPreConsultationWaitingListOnline('FILTER');

	}
	
	 function showAll()
	 {
	 	ResetForm();
	 	nPageNo = 1;	
	 	getPreConsultationWaitingListOnline('ALL');	 	
	 }

</script>
<body>
 <!-- Begin page -->
    <div id="wrapper">

	<div class="content-page">
		<!-- Start content -->
		<div class="">
			<div class="container-fluid">
				<div class="internal_Htext">Pending List of pre-consultation (Online)</div>
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">

								<form>
									<div class="row">
										<div class="col-md-3">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Patient Name</label>
												<div class="col-sm-7">
													<input class="form-control  form-control-sm"
														id="patientName"> </input>
												</div>
											</div>
										</div>		
										<div class="col-md-3">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Mobile No</label>
												<div class="col-sm-7">
													<input class="form-control  form-control-sm"
														id="mobileNo"> </input>
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
													<th id="th1">Patient Name</th>
													<th id="th2">Mobile No.</th>
													<th id="th3">Age</th>
													<th id="th4">Gender</th>
												</tr>
											</thead>
											<tbody id="tblListofPatient">
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