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
		$j('#bedStatusCode').attr('readonly', false);
		GetAllBedStatus('ALL');
	});

	function GetAllBedStatus(MODE) {

		var bedStatusName = jQuery("#searchBedStatus").attr(
				"checked", true).val().toUpperCase();
		var bedStatusId = 0;
		if (MODE == 'ALL') {
			var data = {
				"PN" : nPageNo,
				"bedStatusName" : ""
			};
		} else {
			var data = {
				"PN" : nPageNo,
				"bedStatusName" : bedStatusName
			};
		}
		var url = "getAllBedStatus";
		var bClickable = true;
		GetJsonData('tblListOfBedStatus', data, url, bClickable);
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
					+ "<tr id='"+dataList[i].bedStatusId+"' >";
			htmlTable = htmlTable + "<td style='width: 150px;'>"
					+ dataList[i].bedStatusCode + "</td>";
			htmlTable = htmlTable + "<td style='width: 150px;'>"
					+ dataList[i].bedStatusName + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>" + Status
					+ "</td>";
			htmlTable = htmlTable + "</tr>";

		}
		if (dataList.length == 0) {
			htmlTable = htmlTable
					+ "<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";

		}

		$j("#tblListOfBedStatus").html(htmlTable);

	}

	var bsId;
	var bsCode;
	var bsName;
	var bsStatus;

	function executeClickEvent(bedStatusId, data) {

		for (j = 0; j < data.data.length; j++) {
			if (bedStatusId == data.data[j].bedStatusId) {
				bsId = data.data[j].bedStatusId;
				bsCode = data.data[j].bedStatusCode;
				bsName = data.data[j].bedStatusName;
				bsStatus = data.data[j].status;

			}
		}
		rowClick(bsId, bsCode, bsName, bsStatus);
	}

	function rowClick(bsId,bsCode,bsName,bsStatus) {

		document.getElementById("bedStatusCode").value = bsCode;
		document.getElementById("bedStatusName").value = bsName;

		if (bsStatus == 'Y' || bsStatus == 'y') {
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddBedStatus').hide();
			$j('#bedStatusCode').attr('readonly', true);
			
		}
		if (bsStatus == 'N' || bsStatus == 'n') {
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddBedStatus').hide();
			$j('#bedStatusCode').attr('readonly', true);
			
		}

		

	}

	function searchBedStatusList() {
		if (document.getElementById('searchBedStatus').value == ""
				|| document.getElementById('searchBedStatus') == null) {
			alert("Plese Enter Bed Status Name");
			return false;
		}

		var bedStatusName = jQuery("#searchBedStatus").attr(
				"checked", true).val().toUpperCase();

		var nPageNo = 1;
		var url = "getAllBedStatus";
		var data = {
			"PN" : nPageNo,
			"bedStatusName" : bedStatusName
		};
		var bClickable = true;
		GetJsonData('tblListOfBedStatus', data, url, bClickable);
	}
	var success;
	var error;
	function addBedStatusDetails() {
		
		if (document.getElementById('bedStatusCode').value == null
				|| document.getElementById('bedStatusCode').value == "") {
			alert("Please Enter Bed Status Code");
			return false;
		}
		if (document.getElementById('bedStatusName').value == null
				|| document.getElementById('bedStatusName').value == "") {
			alert("Please Enter Bed Status Name");
			return false;
		}

		var userId = $j('#userId').val();
		var params = {
			'bedStatusCode' : jQuery('#bedStatusCode').val(),
			'bedStatusName' : jQuery('#bedStatusName').val(),
			'userId' : userId

		}

		var url = "addBedStatus";
		SendJsonData(url, params);

	}

	function updateBedStatus() {
		if (document.getElementById('bedStatusCode').value == null
				|| document.getElementById('bedStatusCode').value == "") {
			alert("Please Enter Bed Status Code");
			return false;
		}
		if (document.getElementById('bedStatusName').value == null
				|| document.getElementById('bedStatusName').value == "") {
			alert("Please Enter Bed Status Name");
			return false;
		}
		$('#btnAddBedStatus').prop("disabled",true);
		var userId = $j('#userId').val();
		var params = {
			'bedStatusId' : bsId,
			'bedStatusCode' : jQuery('#bedStatusCode').val(),
			'bedStatusName' : jQuery('#bedStatusName').val(),
			'userId' : userId

		}

		var url = "updateBedStatusDetails";
		SendJsonData(url, params);

		$j("#btnInActive").hide();
		$j("#btnActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddBedStatus').show();
		ResetForm();

	}

	function updateBedStatusStatus() {
		if (document.getElementById('bedStatusCode').value == null
				|| document.getElementById('bedStatusCode').value == "") {
			alert("Please Enter Bed Status Code");
			return false;
		}
		if (document.getElementById('bedStatusName').value == null
				|| document.getElementById('bedStatusName').value == "") {
			alert("Please Enter Bed Status Name");
			return false;
		}
		var userId = $j('#userId').val();
		var params = {
			'bedStatusId' : bsId,
			'bedStatusCode' : bsCode,
			'status' : bsStatus,
			'userId' : userId

		}
		var url = "updateBedStatusStatus";
		SendJsonData(url, params);
		$j("#btnInActive").hide();
		$j("#btnActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddBedStatus').show();
		ResetForm();

	}

	function Reset() {
		document.getElementById("addBedStatusForm").reset();
		document.getElementById("searchBedStatusForm").reset();
		document.getElementById('searchBedStatus').value = "";

		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddBedStatus').show();
		document.getElementById("messageId").innerHTML = "";
		$("#messageId").css("color", "black");
		$j('#bedStatusCode').attr('readonly', false);
		showAll();
	}

	function ResetForm() {
		$j('#bedStatusCode').val('');
		$j('#bedStatusName').val('');
		$j('#searchBedStatus').val('');
		$j('#bedStatusCode').attr('readonly', false);

	}
	
	function showAll() {
		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddBedStatus').show();
		ResetForm();
		nPageNo = 1;
		GetAllBedStatus('ALL');
		

	}

	function showResultPage(pageNo) {
		nPageNo = pageNo;
		GetAllBedStatus('FILTER');

	}

	function search() {
		if (document.getElementById('searchBedStatus').value == "") {
			alert("Please Enter Bed Status Name");
			return false;
		}
		nPageNo = 1;
		GetAllBedStatus('Filter');
	}

	 function generateReport() {
		 var url="${pageContext.request.contextPath}/report/generateBedStatusMasterReport";
		 openPdfModel(url);

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
					<div class="internal_Htext">Bed Status Master</div>

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
												id="searchBedStatusForm"
												name="searchBedStatusForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Bed Status Name<span
														class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchBedStatus"
															id="searchBedStatus" class="form-control"
															id="inlineFormInputGroup" placeholder="Bed Status Name">

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
												<th id="th2" class="inner_md_htext">Bed Status Code</th>
												<th id="th3" class="inner_md_htext">Bed Status Name</th>
												<th id="th5" class="inner_md_htext">Status</th>
											</tr>
										</thead>
										<!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
										<tbody class="clickableRow" id="tblListOfBedStatus">

										</tbody>
									</table>

									<div class="row">
										<div class="col-md-12">
											<form id="addBedStatusForm"
												name="addBedStatusForm" method="">
												<div class="row">
													<div class="col-md-4">
														<div class="form-group row">
															<div class="col-sm-5">
																<label for="Bed Status Code"
																	class=" col-form-label inner_md_htext">Bed Status
																	Code <span class="mandate"><sup>&#9733;</sup></span>
																</label>
															</div>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="bedStatusCode" name="bedStatusCode"
																	placeholder="Bed Status Code"
																	onkeypress=" return validateTextGen('bedStatusCode',7, 'Bed Status Code');">
															</div>
														</div>
													</div>
													<div class="col-md-4">
														<div class="form-group row">
															<div class="col-sm-5">
																<label for="service"
																	class="col-form-label inner_md_htext">Bed Status
																	Name <span class="mandate"><sup>&#9733;</sup></span>
																</label>
															</div>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="bedStatusName" name="bedStatusName"
																	placeholder="Bed Status Name"
																	onkeypress="return validateTextField('bedStatusName',30,'Bed Status Name');">
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

												<button type="button" id="btnAddBedStatus"
													class="btn  btn-primary "
													onclick="addBedStatusDetails();">Add</button>
												<button type="button" id="updateBtn"
													class="btn  btn-primary "
													onclick="updateBedStatus();">Update</button>
												<button id="btnActive" type="button"
													class="btn  btn-primary "
													onclick="updateBedStatusStatus();">Activate</button>
												<button id="btnInActive" type="button"
													class="btn btn-primary  "
													onclick="updateBedStatusStatus();">Deactivate</button>
												<button type="button" class="btn btn-danger "
													onclick="Reset();">Reset</button>

											</div>
										</div>
									</div>

									<%-- <div class="row">
                                        <div class="col-md-7">
                                        </div>
                                        <div class="col-md-5">
                                            <form>
                                                <div class="button-list">

                                                    <button type="button" id="btnAddAdministrativeSex" class="btn btn-primary btn-rounded w-md waves-effect waves-light" onclick="addAdministrativeSexDetails();">Add</button>
                                                    <button type="button" id ="updateBtn" class="btn btn-primary btn-rounded w-md waves-effect waves-light" onclick="updateAdministrativeSex();">Update</button>
                                                    <button id="btnActive" type="button" class="btn btn-primary btn-rounded w-md waves-effect waves-light" onclick="updateAdministrativeSexStatus();">Activate</button>
                                      				<button id="btnInActive" type="button" class="btn btn-primary btn-rounded w-md waves-effect waves-light" onclick="updateAdministrativeSexStatus();">Deactivate</button>
                                                    <button type="button" class="btn btn-danger btn-rounded w-md waves-effect waves-light" onclick="Reset();">Reset</button>

                                                </div>
                                            </form>
                                        </div>

                                    </div> --%>

									<!-- end row -->

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