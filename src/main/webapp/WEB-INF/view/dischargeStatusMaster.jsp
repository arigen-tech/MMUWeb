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
<title>Mobile Medical Unit- MMSSY</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>

<script type="text/javascript">
	nPageNo = 1;
	var $j = jQuery.noConflict();

	$j(document).ready(function() {
		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#dischargeStatusCode').attr('readonly', false);
		GetAllDischargeStatus('ALL');
	});

	function GetAllDischargeStatus(MODE) {

		var dischargeStatusName = jQuery("#searchDischargeStatus").attr(
				"checked", true).val().toUpperCase();
		var dischargeStatusId = 0;
		if (MODE == 'ALL') {
			var data = {
				"PN" : nPageNo,
				"dischargeStatusName" : ""
			};
		} else {
			var data = {
				"PN" : nPageNo,
				"dischargeStatusName" : dischargeStatusName
			};
		}
		var url = "getAllDischargeStatus";
		var bClickable = true;
		GetJsonData('tblListOfDischargeStatus', data, url, bClickable);
	}

	function makeTable(jsonData) {
		var htmlTable = "";
		var data = jsonData.count;

		var pageSize = 5;
		var dataList = jsonData.data;

		for (i = 0; i < dataList.length; i++) {

			if (dataList[i].status == 'Y' || dataList[i].status == 'y') {
				var Status = 'Active'
			} else {
				var Status = 'Inactive'
			}

			htmlTable = htmlTable
					+ "<tr id='"+dataList[i].dischargeStatusId+"' >";
			htmlTable = htmlTable + "<td style='width: 150px;'>"
					+ dataList[i].dischargeStatusCode + "</td>";
			htmlTable = htmlTable + "<td style='width: 150px;'>"
					+ dataList[i].dischargeStatusName + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>" + Status
					+ "</td>";
			htmlTable = htmlTable + "</tr>";

		}
		if (dataList.length == 0) {
			htmlTable = htmlTable
					+ "<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";

		}

		$j("#tblListOfDischargeStatus").html(htmlTable);

	}

	var dsId;
	var dsCode;
	var dsName;
	var dsStatus;

	function executeClickEvent(dischargeStatusId, data) {

		for (j = 0; j < data.data.length; j++) {
			if (dischargeStatusId == data.data[j].dischargeStatusId) {
				dsId = data.data[j].dischargeStatusId;
				dsCode = data.data[j].dischargeStatusCode;
				dsName = data.data[j].dischargeStatusName;
				dsStatus = data.data[j].status;

			}
		}
		rowClick(dsId, dsCode, dsName, dsStatus);
	}

	function rowClick(dsId,dsCode,dsName,dsStatus) {

		document.getElementById("dischargeStatusCode").value = dsCode;
		document.getElementById("dischargeStatusName").value = dsName;

		if (dsStatus == 'Y' || dsStatus == 'y') {
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddDischargeStatus').hide();
			$j('#dischargeStatusCode').attr('readonly', true);
			
		}
		if (dsStatus == 'N' || dsStatus == 'n') {
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddDischargeStatus').hide();
			$j('#dischargeStatusCode').attr('readonly', true);
			
		}

		

	}

	function searchDischargeStatusList() {
		if (document.getElementById('searchDischargeStatus').value == ""
				|| document.getElementById('searchDischargeStatus') == null) {
			alert("Plese Enter Discharge Status Name");
			return false;
		}

		var dischargeStatusName = jQuery("#searchDischargeStatus").attr(
				"checked", true).val().toUpperCase();

		var nPageNo = 1;
		var url = "getAllDischargeStatus";
		var data = {
			"PN" : nPageNo,
			"dischargeStatusName" : dischargeStatusName
		};
		var bClickable = true;
		GetJsonData('tblListOfDischargeStatus', data, url, bClickable);
	}
	var success;
	var error;
	function addDischargeStatusDetails() {
		
		if (document.getElementById('dischargeStatusCode').value == null
				|| document.getElementById('dischargeStatusCode').value == "") {
			alert("Please Enter Discharge Status Code");
			return false;
		}
		if (document.getElementById('dischargeStatusName').value == null
				|| document.getElementById('dischargeStatusName').value == "") {
			alert("Please Enter Discharge Status Name");
			return false;
		}
		$('#btnAddDischargeStatus').prop("disabled",true);
		var userId = $j('#userId').val();
		var params = {
			'dischargeStatusCode' : jQuery('#dischargeStatusCode').val(),
			'dischargeStatusName' : jQuery('#dischargeStatusName').val(),
			'userId' : userId

		}

		var url = "addDischargeStatus";
		SendJsonData(url, params);

	}

	function updateDischargeStatus() {
		if (document.getElementById('dischargeStatusCode').value == null
				|| document.getElementById('dischargeStatusCode').value == "") {
			alert("Please Enter Discharge Status Code");
			return false;
		}
		if (document.getElementById('dischargeStatusName').value == null
				|| document.getElementById('dischargeStatusName').value == "") {
			alert("Please Enter Discharge Status Name");
			return false;
		}

		var userId = $j('#userId').val();
		var params = {
			'dischargeStatusId' : dsId,
			'dischargeStatusCode' : jQuery('#dischargeStatusCode').val(),
			'dischargeStatusName' : jQuery('#dischargeStatusName').val(),
			'userId' : userId

		}

		var url = "updateDischargeStatusDetails";
		SendJsonData(url, params);

		$j("#btnInActive").hide();
		$j("#btnActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddDischargeStatus').show();
		ResetForm();

	}

	function updateDischargeStatusStatus() {
		if (document.getElementById('dischargeStatusCode').value == null
				|| document.getElementById('dischargeStatusCode').value == "") {
			alert("Please Enter Discharge Status Code");
			return false;
		}
		if (document.getElementById('dischargeStatusName').value == null
				|| document.getElementById('dischargeStatusName').value == "") {
			alert("Please Enter Discharge Status Name");
			return false;
		}
		var userId = $j('#userId').val();
		var params = {
			'dischargeStatusId' : dsId,
			'dischargeStatusCode' : dsCode,
			'status' : dsStatus,
			'userId' : userId

		}
		var url = "updateDischargeStatusStatus";
		SendJsonData(url, params);
		$j("#btnInActive").hide();
		$j("#btnActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddDischargeStatus').show();
		ResetForm();

	}

	function Reset() {
		document.getElementById("addDischargeStatusForm").reset();
		document.getElementById("searchDischargeStatusForm").reset();
		document.getElementById('searchDischargeStatus').value = "";

		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddDischargeStatus').show();
		document.getElementById("messageId").innerHTML = "";
		$("#messageId").css("color", "black");
		$j('#dischargeStatusCode').attr('readonly', false);
		showAll();
	}

	function ResetForm() {
		$j('#dischargeStatusCode').val('');
		$j('#dischargeStatusName').val('');
		$j('#searchDischargeStatus').val('');
		$j('#dischargeStatusCode').attr('readonly', false);

	}
	
	function showAll() {
		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddDischargeStatus').show();
		ResetForm();
		nPageNo = 1;
		GetAllDischargeStatus('ALL');
		

	}

	function showResultPage(pageNo) {
		nPageNo = pageNo;
		GetAllDischargeStatus('FILTER');

	}

	function search() {
		if (document.getElementById('searchDischargeStatus').value == "") {
			alert("Please Enter Discharge Status Name");
			return false;
		}
		nPageNo = 1;
		GetAllDischargeStatus('Filter');
	}

	 function generateReport() {

		 var url="${pageContext.request.contextPath}/report/generateDischargeStatusMasterReport";
		 openPdfModel(url);
		/* document.searchDischargeStatusForm.action = "${pageContext.request.contextPath}/report/generateDischargeStatusMasterReport";
		document.searchDischargeStatusForm.method = "POST";
		document.searchDischargeStatusForm.submit(); */

	} 
</script>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">

		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">Discharge Status Master</div>

					<!-- end row -->

					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<p align="center" id="messageId"
										style="color: green; font-weight: bold;"></p>

									<div class="row">
										<div class="col-md-8">
											<form class="form-horizontal"
												id="searchDischargeStatusForm"
												name="searchDischargeStatusForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Discharge Status Name<span
														class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchDischargeStatus"
															id="searchDischargeStatus" class="form-control"
															id="inlineFormInputGroup" placeholder="Discharge Status Name">

													</div>
													<div class="form-group row">

														<div class="col-md-12">
															<button type="button" class="btn  btn-primary "
																onclick="search()">Search</button>
														</div>
													</div>
												</div>
											</form>

										</div>
										<div class="col-md-4">
											<div class="btn-right-all">
												<button type="button" class="btn  btn-primary "
													onclick="showAll('ALL');">Show All</button>
												<button type="button" class="btn  btn-primary "
												id="printReportButton" 
													onclick="generateReport()">Reports</button>
											</div>
										</div>
									</div>

									<div style="float: left">

										<table class="tblSearchActions" cellspacing="0"
											cellpadding="0" border="0">
											<tr>
												<td class="SearchStatus" style="font-size: 15px;"
													align="left">Search Results</td>
												<td>
													<!-- <div id=resultnavigation></div> -->

												</td>
											</tr>
										</table>
									</div>
									<div style="float: right">
										<div id="resultnavigation"></div>
									</div>

									<table class="table table-striped table-hover table-bordered ">
										<thead class="bg-success" style="color: #fff;">
											<tr>
												<th id="th2" class="inner_md_htext">Discharge Status Code</th>
												<th id="th3" class="inner_md_htext">Discharge Status Name</th>
												<th id="th5" class="inner_md_htext">Status</th>
											</tr>
										</thead>
										<!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
										<tbody class="clickableRow" id="tblListOfDischargeStatus">

										</tbody>
									</table>

									<div class="row">
										<div class="col-md-12">
											<form id="addDischargeStatusForm"
												name="addDischargeStatusForm" method="">
												<div class="row">
													<div class="col-md-4">
														<div class="form-group row">
															<div class="col-sm-5">
																<label for="Discharge Status Code"
																	class=" col-form-label inner_md_htext">Discharge Status
																	Code <span class="mandate"><sup>&#9733;</sup></span>
																</label>
															</div>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="dischargeStatusCode" name="dischargeStatusCode"
																	placeholder="Discharge Status Code"
																	onkeypress=" return validateTextGen('dischargeStatusCode',7, 'Discharge Status Code');">
															</div>
														</div>
													</div>
													<div class="col-md-4">
														<div class="form-group row">
															<div class="col-sm-5">
																<label for="service"
																	class="col-form-label inner_md_htext">Discharge Status
																	Name <span class="mandate"><sup>&#9733;</sup></span>
																</label>
															</div>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="dischargeStatusName" name="dischargeStatusName"
																	placeholder="Discharge Status Name"
																	onkeypress="return validateTextField('dischargeStatusName',30,'Discharge Status Name');">
															</div>
														</div>
													</div>

													<div class="col-md-4">
														<input type="hidden" id="rowId" name="rowId"> <input
															type="hidden" class="form-control" id="userId"
															name="userId"
															value="<%=session.getAttribute("user_id")%>">
													</div>

												</div>
											</form>
										</div>

									</div>

									<br>
									<div class="row">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">

												<button type="button" id="btnAddDischargeStatus"
													class="btn  btn-primary "
													onclick="addDischargeStatusDetails();">Add</button>
												<button type="button" id="updateBtn"
													class="btn  btn-primary "
													onclick="updateDischargeStatus();">Update</button>
												<button id="btnActive" type="button"
													class="btn  btn-primary "
													onclick="updateDischargeStatusStatus();">Activate</button>
												<button id="btnInActive" type="button"
													class="btn btn-primary  "
													onclick="updateDischargeStatusStatus();">Deactivate</button>
												<button type="button" class="btn btn-danger "
													onclick="Reset();">Reset</button>

											</div>
										</div>
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
			<!-- content -->


		</div>

		<!-- ============================================================== -->
		<!-- End Right content here -->
		<!-- ============================================================== -->

	</div>
	<!-- END wrapper -->

	<!-- jQuery  -->


</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>

