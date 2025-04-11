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
		$j('#dietCode').attr('readonly', false);
		GetAllDiet('ALL');
	});

	function GetAllDiet(MODE) {

		var dietName = jQuery("#searchDiet").attr(
				"checked", true).val().toUpperCase();
		var dietId = 0;
		if (MODE == 'ALL') {
			var data = {
				"PN" : nPageNo,
				"dietName" : ""
			};
		} else {
			var data = {
				"PN" : nPageNo,
				"dietName" : dietName
			};
		}
		var url = "getAllDiet";
		var bClickable = true;
		GetJsonData('tblListOfDiet', data, url, bClickable);
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
					+ "<tr id='"+dataList[i].dietId+"' >";
			htmlTable = htmlTable + "<td style='width: 150px;'>"
					+ dataList[i].dietCode + "</td>";
			htmlTable = htmlTable + "<td style='width: 150px;'>"
					+ dataList[i].dietName + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>" + Status
					+ "</td>";
			htmlTable = htmlTable + "</tr>";

		}
		if (dataList.length == 0) {
			htmlTable = htmlTable
					+ "<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";

		}

		$j("#tblListOfDiet").html(htmlTable);

	}

	var dtId;
	var dtCode;
	var dtName;
	var dtStatus;

	function executeClickEvent(dietId, data) {

		for (j = 0; j < data.data.length; j++) {
			if (dietId == data.data[j].dietId) {
				dtId = data.data[j].dietId;
				dtCode = data.data[j].dietCode;
				dtName = data.data[j].dietName;
				dtStatus = data.data[j].status;

			}
		}
		rowClick(dtId, dtCode, dtName, dtStatus);
	}

	function rowClick(dtId,dtCode,dtName,dtStatus) {

		document.getElementById("dietCode").value = dtCode;
		document.getElementById("dietName").value = dtName;

		if (dtStatus == 'Y' || dtStatus == 'y') {
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAdd').hide();
			$j('#dietCode').attr('readonly', true);
			
		}
		if (dtStatus == 'N' || dtStatus == 'n') {
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAdd').hide();
			$j('#dietCode').attr('readonly', true);
			
		}

		

	}

	function searchDietList() {
		if (document.getElementById('searchDiet').value == ""
				|| document.getElementById('searchDiet') == null) {
			alert("Plese Enter Diet Name");
			return false;
		}

		var dietName = jQuery("#searchDiet").attr(
				"checked", true).val().toUpperCase();

		var nPageNo = 1;
		var url = "getAllDiet";
		var data = {
			"PN" : nPageNo,
			"dietName" : dietName
		};
		var bClickable = true;
		GetJsonData('tblListOfDiet', data, url, bClickable);
	}
	var success;
	var error;
	function addDietDetails() {
		
		if (document.getElementById('dietCode').value == null
				|| document.getElementById('dietCode').value == "") {
			alert("Please Enter Diet Code");
			return false;
		}
		if (document.getElementById('dietName').value == null
				|| document.getElementById('dietName').value == "") {
			alert("Please Enter Diet Name");
			return false;
		}
		$('#btnAdd').prop("disabled",true);
		var userId = $j('#userId').val();
		var params = {
			'dietCode' : jQuery('#dietCode').val(),
			'dietName' : jQuery('#dietName').val(),
			'userId' : userId

		}

		var url = "addDiet";
		SendJsonData(url, params);
		GetAllDiet('FILTER');
	}

	function updateDiet() {
		if (document.getElementById('dietCode').value == null
				|| document.getElementById('dietCode').value == "") {
			alert("Please Enter Diet Code");
			return false;
		}
		if (document.getElementById('dietName').value == null
				|| document.getElementById('dietName').value == "") {
			alert("Please Enter Diet Name");
			return false;
		}

		var userId = $j('#userId').val();
		var params = {
			'dietId' : dtId,
			'dietCode' : jQuery('#dietCode').val(),
			'dietName' : jQuery('#dietName').val(),
			'userId' : userId

		}

		var url = "updateDietDetails";
		SendJsonData(url, params);

		$j("#btnInActive").hide();
		$j("#btnActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddDiet').show();
		GetAllDiet('FILTER');
		ResetForm();

	}

	function updateDietStatus() {
		if (document.getElementById('dietCode').value == null
				|| document.getElementById('dietCode').value == "") {
			alert("Please Enter Diet Code");
			return false;
		}
		if (document.getElementById('dietName').value == null
				|| document.getElementById('dietName').value == "") {
			alert("Please Enter Diet Name");
			return false;
		}
		var userId = $j('#userId').val();
		var params = {
			'dietId' : dtId,
			'dietCode' : dtCode,
			'status' : dtStatus,
			'userId' : userId

		}
		var url = "updateDietStatus";
		SendJsonData(url, params);
		$j("#btnInActive").hide();
		$j("#btnActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAdd').show();
		ResetForm();

	}

	function Reset() {
		document.getElementById("addDietForm").reset();
		document.getElementById("searchDietForm").reset();
		document.getElementById('searchDiet').value = "";

		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAdd').show();
		document.getElementById("messageId").innerHTML = "";
		$("#messageId").css("color", "black");
		$j('#dietCode').attr('readonly', false);
		showAll();
	}

	function ResetForm() {
		$j('#dietCode').val('');
		$j('#dietName').val('');
		$j('#searchDiet').val('');
		$j('#dietCode').attr('readonly', false);

	}
	
	function showAll() {
		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAdd').show();
		ResetForm();
		nPageNo = 1;
		GetAllDiet('ALL');
		

	}

	function showResultPage(pageNo) {
		nPageNo = pageNo;
		GetAllDiet('FILTER');

	}

	function search() {
		if (document.getElementById('searchDiet').value == "") {
			alert("Please Enter Diet Name");
			return false;
		}
		nPageNo = 1;
		GetAllDiet('Filter');
	}

	 function generateReport() {
		 var url="${pageContext.request.contextPath}/report/generateDietReport";
		 openPdfModel(url);
		/* document.searchDietForm.action = "${pageContext.request.contextPath}/report/generateDietReport";
		document.searchDietForm.method = "POST";
		document.searchDietForm.submit();
 */
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
					<div class="internal_Htext">Diet Master</div>

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
												id="searchDietForm"
												name="searchDietForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Diet Name<span
														class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchDiet"
															id="searchDiet" class="form-control"
															id="inlineFormInputGroup" placeholder="Diet Name">

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
												<th id="th2" class="inner_md_htext">Diet Code</th>
												<th id="th3" class="inner_md_htext">Diet Name</th>
												<th id="th5" class="inner_md_htext">Status</th>
											</tr>
										</thead>
										<tbody class="clickableRow" id="tblListOfDiet">

										</tbody>
									</table>

									<div class="row">
										<div class="col-md-12">
											<form id="addDietForm"
												name="addDietForm" method="">
												<div class="row">
													<div class="col-md-4">
														<div class="form-group row">
															<div class="col-sm-5">
																<label for="Diet Code"
																	class=" col-form-label inner_md_htext">Diet
																	Code <span class="mandate"><sup>&#9733;</sup></span>
																</label>
															</div>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="dietCode" name="dietCode"
																	placeholder="Diet Code"
																	onkeypress=" return validateText('dietCode',8, 'Diet Code');">
															</div>
														</div>
													</div>
													<div class="col-md-4">
														<div class="form-group row">
															<div class="col-sm-5">
																<label for="service"
																	class="col-form-label inner_md_htext">Diet
																	Name <span class="mandate"><sup>&#9733;</sup></span>
																</label>
															</div>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="dietName" name="dietName"
																	placeholder="Diet Name"
																	onkeypress="return validateText('dietName',30,'Diet Name');">
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

												<button type="button" id="btnAdd"
													class="btn  btn-primary "
													onclick="addDietDetails();">Add</button>
												<button type="button" id="updateBtn"
													class="btn  btn-primary "
													onclick="updateDiet();">Update</button>
												<button id="btnActive" type="button"
													class="btn  btn-primary "
													onclick="updateDietStatus();">Activate</button>
												<button id="btnInActive" type="button"
													class="btn btn-primary  "
													onclick="updateDietStatus();">Deactivate</button>
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