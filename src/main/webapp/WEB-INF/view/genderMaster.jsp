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
		$j('#administrativeSexCode').attr('readonly', false);
		GetAllAdministrativeSex('ALL');
	});

	function GetAllAdministrativeSex(MODE) {

		var administrativeSexName = jQuery("#searchAdministrativeSex").attr(
				"checked", true).val().toUpperCase();
		var administrativeSexId = 0;
		if (MODE == 'ALL') {
			var data = {
				"PN" : nPageNo,
				"administrativeSexName" : ""
			};
		} else {
			var data = {
				"PN" : nPageNo,
				"administrativeSexName" : administrativeSexName
			};
		}
		var url = "getAllAdministrativeSex";
		var bClickable = true;
		GetJsonData('tblListOfAdministrativeSex', data, url, bClickable);
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
					+ "<tr id='"+dataList[i].administrativeSexId+"' >";
			htmlTable = htmlTable + "<td style='width: 150px;'>"
					+ dataList[i].administrativeSexCode + "</td>";
			htmlTable = htmlTable + "<td style='width: 150px;'>"
					+ dataList[i].administrativeSexName + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>" + Status
					+ "</td>";
			htmlTable = htmlTable + "</tr>";

		}
		if (dataList.length == 0) {
			htmlTable = htmlTable
					+ "<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";

		}

		$j("#tblListOfAdministrativeSex").html(htmlTable);

	}

	var adSexId;
	var adSexCode;
	var adSexName;
	var adSexStatus;

	function executeClickEvent(administrativeSexId, data) {

		for (j = 0; j < data.data.length; j++) {
			if (administrativeSexId == data.data[j].administrativeSexId) {
				adSexId = data.data[j].administrativeSexId;
				adSexCode = data.data[j].administrativeSexCode;
				adSexName = data.data[j].administrativeSexName;
				adSexStatus = data.data[j].status;

			}
		}
		rowClick(adSexId, adSexCode, adSexName, adSexStatus);
	}

	function rowClick(adSexId, adSexCode, adSexName, adSexStatus) {

		document.getElementById("administrativeSexCode").value = adSexCode;
		document.getElementById("administrativeSexName").value = adSexName;

		if (adSexStatus == 'Y' || adSexStatus == 'y') {
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddAdministrativeSex').hide();
			$j('#administrativeSexCode').attr('readonly', true);
			
		}
		if (adSexStatus == 'N' || adSexStatus == 'n') {
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddAdministrativeSex').hide();
			$j('#administrativeSexCode').attr('readonly', true);
			
		}

		

	}

	function searchAdministrativeSexList() {
		if (document.getElementById('searchAdministrativeSex').value == ""
				|| document.getElementById('searchAdministrativeSex') == null) {
			alert("Plese Enter Gender Name");
			return false;
		}

		var administrativeSexName = jQuery("#searchAdministrativeSex").attr(
				"checked", true).val().toUpperCase();

		var nPageNo = 1;
		var url = "getAllAdministrativeSex";
		var data = {
			"PN" : nPageNo,
			"administrativeSexName" : administrativeSexName
		};
		var bClickable = true;
		GetJsonData('tblListOfAdministrativeSex', data, url, bClickable);
	}
	var success;
	var error;
	function addAdministrativeSexDetails() {
		if (document.getElementById('administrativeSexCode').value == null
				|| document.getElementById('administrativeSexCode').value == "") {
			alert("Please Enter Gender Code");
			return false;
		}
		if (document.getElementById('administrativeSexName').value == null
				|| document.getElementById('administrativeSexName').value == "") {
			alert("Please Enter Gender Name");
			return false;
		}

		var userId = $j('#userId').val();
		var params = {
			'administrativeSexCode' : jQuery('#administrativeSexCode').val(),
			'administrativeSexName' : jQuery('#administrativeSexName').val(),
			'userId' : userId

		}

		var url = "addAdministrativeSex";
		SendJsonData(url, params);

	}

	function updateAdministrativeSex() {
		if (document.getElementById('administrativeSexCode').value == null
				|| document.getElementById('administrativeSexCode').value == "") {
			alert("Please Enter Gender Code");
			return false;
		}
		if (document.getElementById('administrativeSexName').value == null
				|| document.getElementById('administrativeSexName').value == "") {
			alert("Please Enter Gender Name");
			return false;
		}

		var userId = $j('#userId').val();
		var params = {
			'administrativeSexId' : adSexId,
			'administrativeSexCode' : jQuery('#administrativeSexCode').val(),
			'administrativeSexName' : jQuery('#administrativeSexName').val(),
			'userId' : userId

		}

		var url = "updateAdministrativeSexDetails";
		SendJsonData(url, params);

		$j("#btnInActive").hide();
		$j("#btnActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddAdministrativeSex').show();
		ResetForm();

	}

	function updateAdministrativeSexStatus() {
		if (document.getElementById('administrativeSexCode').value == null
				|| document.getElementById('administrativeSexCode').value == "") {
			alert("Please Enter Gender Code");
			return false;
		}
		if (document.getElementById('administrativeSexName').value == null
				|| document.getElementById('administrativeSexName').value == "") {
			alert("Please Enter Gender Name");
			return false;
		}
		var userId = $j('#userId').val();
		var params = {
			'administrativeSexId' : adSexId,
			'administrativeSexCode' : adSexCode,
			'status' : adSexStatus,
			'userId' : userId

		}
		var url = "updateAdministrativeSexStatus";
		SendJsonData(url, params);
		$j("#btnInActive").hide();
		$j("#btnActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddAdministrativeSex').show();
		ResetForm();

	}

	function Reset() {
		document.getElementById("addAdministrativeSexForm").reset();
		document.getElementById("searchAdministrativeSexForm").reset();
		document.getElementById('searchAdministrativeSex').value = "";

		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddAdministrativeSex').show();
		document.getElementById("messageId").innerHTML = "";
		$("#messageId").css("color", "black");
		$j('#administrativeSexCode').attr('readonly', false);
		showAll();
	}

	function ResetForm() {
		$j('#administrativeSexCode').val('');
		$j('#administrativeSexName').val('');
		$j('#searchAdministrativeSex').val('');
		$j('#administrativeSexCode').attr('readonly', false);

	}

	function showAll() {
		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddAdministrativeSex').show();
		ResetForm();
		nPageNo = 1;
		GetAllAdministrativeSex('ALL');
		

	}

	function showResultPage(pageNo) {
		nPageNo = pageNo;
		GetAllAdministrativeSex('FILTER');

	}

	function search() {
		if (document.getElementById('searchAdministrativeSex').value == "") {
			alert("Please Enter Gender Name");
			return false;
		}
		nPageNo = 1;
		GetAllAdministrativeSex('Filter');
	}

	function generateReport() {
		var url="${pageContext.request.contextPath}/report/generateGenderReport";
		openPdfModel(url);
		/* document.searchAdministrativeSexForm.action = "${pageContext.request.contextPath}/report/generateGenderReport";
		document.searchAdministrativeSexForm.method = "POST";
		document.searchAdministrativeSexForm.submit(); */

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
					<div class="internal_Htext">Gender Master</div>

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
												id="searchAdministrativeSexForm"
												name="searchAdministrativeSexForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Gender Name<span
														class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchAdministrativeSex"
															id="searchAdministrativeSex" class="form-control"
															id="inlineFormInputGroup" placeholder="Gender Name">

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
									<%-- <div class="row">
                                                                     
                                        <div class="col-md-8">
                                            <form class="form-horizontal" id="searchAdministrativeSexForm" name="searchAdministrativeSexForm" method="" role="form">
                                                <div class="form-group row">
                                                    <label class="col-3 col-form-label inner_md_htext">Gender Name <span style="color:red">*</span> </label>
                                                    <div class="col-5">
                                                        <div class="col-auto">
                                                            <label class="sr-only" for="inlineFormInputGroup">Gender Name</label>
                                                            <div class="input-group mb-2">
                                                                <!-- <div class="input-group-prepend">
                                                                    <div class="input-group-text">&#128269;</div>
                                                                </div> -->
                                                                <input type="text" name="searchAdministrativeSex" id="searchAdministrativeSex" class="form-control" id="inlineFormInputGroup" placeholder="Gender Name">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-2">
                                                        <button type="button" class="btn  btn-primary" onclick="GetAllAdministrativeSex('FILTER');">Search</button>
                                                    </div>
                                                </div>
                                            </form>

                                        </div>
                                        
                                        
                                        
                                        
                                        <div class="col-md-4">
                                            <form>
                                                <div class="button-list">
                                                    <button type="button" class="btn  btn-primary btn-rounded w-md waves-effect waves-light" onclick="showAll('ALL');">Show All</button>
                                                    <button type="button" class="btn  btn-primary btn-rounded w-md waves-effect waves-light">Reports</button>

                                                </div>
                                            </form>
                                        </div>

                                    </div> --%>


									<!-- <table class="table table-striped table-hover jambo_table"> -->
									<!-- <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >			<tr>
				<td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
				<td>
				<div id=resultnavigation></div>
				
				</td>
				</tr>
		</table> -->

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
												<th id="th2" class="inner_md_htext">Gender Code</th>
												<th id="th3" class="inner_md_htext">Gender Name</th>
												<th id="th5" class="inner_md_htext">Status</th>
											</tr>
										</thead>
										<!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
										<tbody class="clickableRow" id="tblListOfAdministrativeSex">

										</tbody>
									</table>

								<%-- 	<div class="row">
										<div class="col-md-12">
											<form id="addAdministrativeSexForm"
												name="addAdministrativeSexForm" method="">
												<div class="row">
													<div class="col-md-4">
														<div class="form-group row">
															<div class="col-sm-5">
																<label for="Administrative Sex Code"
																	class=" col-form-label inner_md_htext">Gender
																	Code <span class="mandate"><sup>&#9733;</sup></span>
																</label>
															</div>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="administrativeSexCode" name="administrativeSexCode"
																	placeholder="Gender Code"
																	onkeypress=" return validateTextGen('administrativeSexCode',1, 'Gender Code');">
															</div>
														</div>
													</div>
													<div class="col-md-4">
														<div class="form-group row">
															<div class="col-sm-5">
																<label for="service"
																	class="col-form-label inner_md_htext">Gender
																	Name <span class="mandate"><sup>&#9733;</sup></span>
																</label>
															</div>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="administrativeSexName" name="administrativeSexName"
																	placeholder="Gender Name"
																	onkeypress="return validateTextField('administrativeSexName',30,'Gender Name');">
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

									</div> --%>

									<br>
									<!-- div class="row">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">

												<button type="button" id="btnAddAdministrativeSex"
													class="btn  btn-primary "
													onclick="addAdministrativeSexDetails();">Add</button>
												<button type="button" id="updateBtn"
													class="btn  btn-primary "
													onclick="updateAdministrativeSex();">Update</button>
												<button id="btnActiv " type="button"
													class="btn  btn-primary "
													onclick="updateAdministrativeSexStatus();">Activate</button>
												<button id="btnInActive" type="button"
													class="btn btn-primary  "
													onclick="updateAdministrativeSexStatus();">Deactivate</button>
												<button type="button" class="btn btn-danger "
													onclick="Reset();">Reset</button>

											</div>
										</div>
									</div> -->

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