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
		$j('#specialityCode').attr('readonly', false);
		GetAllSpeciality('ALL');
	});

	function GetAllSpeciality(MODE) {

		var specialityName = jQuery("#searchSpeciality").attr(
				"checked", true).val().toUpperCase();
		var specialityId = 0;
		if (MODE == 'ALL') {
			var data = {
				"PN" : nPageNo,
				"specialityName" : ""
			};
		} else {
			var data = {
				"PN" : nPageNo,
				"specialityName" : specialityName
			};
		}
		var url = "getAllSpeciality";
		var bClickable = true;
		GetJsonData('tblListOfSpeciality', data, url, bClickable);
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
					+ "<tr id='"+dataList[i].specialityId+"' >";
			htmlTable = htmlTable + "<td style='width: 150px;'>"
					+ dataList[i].specialityCode + "</td>";
			htmlTable = htmlTable + "<td style='width: 150px;'>"
					+ dataList[i].specialityName + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>" + Status
					+ "</td>";
			htmlTable = htmlTable + "</tr>";

		}
		if (dataList.length == 0) {
			htmlTable = htmlTable
					+ "<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";

		}

		$j("#tblListOfSpeciality").html(htmlTable);

	}

	var sId;
	var sCode;
	var sName;
	var sStatus;

	function executeClickEvent(specialityId, data) {

		for (j = 0; j < data.data.length; j++) {
			if (specialityId == data.data[j].specialityId) {
				sId = data.data[j].specialityId;
				sCode = data.data[j].specialityCode;
				sName = data.data[j].specialityName;
				sStatus = data.data[j].status;

			}
		}
		rowClick(sId, sCode, sName, sStatus);
	}

	function rowClick(sId,sCode,sName,sStatus) {

		document.getElementById("specialityCode").value = sCode;
		document.getElementById("specialityName").value = sName;

		if (sStatus == 'Y' || sStatus == 'y') {
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAdd').hide();
			$j('#specialityCode').attr('readonly', true);
			
		}
		if (sStatus == 'N' || sStatus == 'n') {
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAdd').hide();
			$j('#specialityCode').attr('readonly', true);
			
		}

		

	}

	function searchSpecialityList() {
		if (document.getElementById('searchSpeciality').value == ""
				|| document.getElementById('searchSpeciality') == null) {
			alert("Plese Enter Speciality Name");
			return false;
		}

		var specialityName = jQuery("#searchSpeciality").attr(
				"checked", true).val().toUpperCase();

		var nPageNo = 1;
		var url = "getAllSpeciality";
		var data = {
			"PN" : nPageNo,
			"specialityName" : specialityName
		};
		var bClickable = true;
		GetJsonData('tblListOfSpeciality', data, url, bClickable);
	}
	var success;
	var error;
	function addSpecialityDetails() {
		
		if (document.getElementById('specialityCode').value == null
				|| document.getElementById('specialityCode').value == "") {
			alert("Please Enter Speciality Code");
			return false;
		}
		if (document.getElementById('specialityName').value == null
				|| document.getElementById('specialityName').value == "") {
			alert("Please Enter Speciality Name");
			return false;
		}
		$('#btnAdd').prop("disabled",true);
		var userId = $j('#userId').val();
		var params = {
			'specialityCode' : jQuery('#specialityCode').val(),
			'specialityName' : jQuery('#specialityName').val(),
			'userId' : userId

		}

		var url = "addSpeciality";
		SendJsonData(url, params);
		GetAllSpeciality('FILTER');
	}

	function updateSpeciality() {
		if (document.getElementById('specialityCode').value == null
				|| document.getElementById('specialityCode').value == "") {
			alert("Please Enter Speciality Code");
			return false;
		}
		if (document.getElementById('specialityName').value == null
				|| document.getElementById('specialityName').value == "") {
			alert("Please Enter Speciality Name");
			return false;
		}

		var userId = $j('#userId').val();
		var params = {
			'specialityId' : sId,
			'specialityCode' : jQuery('#specialityCode').val(),
			'specialityName' : jQuery('#specialityName').val(),
			'userId' : userId

		}

		var url = "updateSpecialityDetails";
		SendJsonData(url, params);

		$j("#btnInActive").hide();
		$j("#btnActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddSpeciality').show();
		GetAllSpeciality('FILTER');
		Reset();

	}

	function updateSpecialityStatus() {
		if (document.getElementById('specialityCode').value == null
				|| document.getElementById('specialityCode').value == "") {
			alert("Please Enter Speciality Code");
			return false;
		}
		if (document.getElementById('specialityName').value == null
				|| document.getElementById('specialityName').value == "") {
			alert("Please Enter Speciality Name");
			return false;
		}
		var userId = $j('#userId').val();
		var params = {
			'specialityId' : sId,
			'specialityCode' : sCode,
			'status' : sStatus,
			'userId' : userId

		}
		var url = "updateSpecialityStatus";
		SendJsonData(url, params);
		$j("#btnInActive").hide();
		$j("#btnActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAdd').show();
		ResetForm();

	}

	function Reset() {
		document.getElementById("addSpecialityForm").reset();
		document.getElementById("searchSpecialityForm").reset();
		document.getElementById('searchSpeciality').value = "";

		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAdd').show();
		document.getElementById("messageId").innerHTML = "";
		$("#messageId").css("color", "black");
		$j('#specialityCode').attr('readonly', false);
		showAll();
	}

	function ResetForm() {
		$j('#specialityCode').val('');
		$j('#specialityName').val('');
		$j('#searchSpeciality').val('');
		$j('#specialityCode').attr('readonly', false);

	}
	
	function showAll() {
		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAdd').show();
		ResetForm();
		nPageNo = 1;
		GetAllSpeciality('ALL');
		

	}

	function showResultPage(pageNo) {
		nPageNo = pageNo;
		GetAllSpeciality('FILTER');

	}

	function search() {
		if (document.getElementById('searchSpeciality').value == "") {
			alert("Please Enter Speciality Name");
			return false;
		}
		nPageNo = 1;
		GetAllSpeciality('Filter');
	}

	 function generateReport() {
		 var url="${pageContext.request.contextPath}/report/generateSpecialityReport";
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
					<div class="internal_Htext">Speciality Master</div>

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
												id="searchSpecialityForm"
												name="searchSpecialityForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Speciality Name<span
														class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchSpeciality"
															id="searchSpeciality" class="form-control"
															id="inlineFormInputGroup" placeholder="Speciality Name">

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
												<th id="th2" class="inner_md_htext">Speciality Code</th>
												<th id="th3" class="inner_md_htext">Speciality Name</th>
												<th id="th5" class="inner_md_htext">Status</th>
											</tr>
										</thead>
										<tbody class="clickableRow" id="tblListOfSpeciality">

										</tbody>
									</table>

									<div class="row">
										<div class="col-md-12">
											<form id="addSpecialityForm"
												name="addSpecialityForm" method="">
												<div class="row">
													<div class="col-md-4">
														<div class="form-group row">
															<div class="col-sm-5">
																<label for="Speciality Code"
																	class=" col-form-label inner_md_htext">Speciality
																	Code <span class="mandate"><sup>&#9733;</sup></span>
																</label>
															</div>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="specialityCode" name="specialityCode"
																	placeholder="Speciality Code"
																	onkeypress=" return validateText('specialityCode',10, 'Speciality Code');">
															</div>
														</div>
													</div>
													<div class="col-md-4">
														<div class="form-group row">
															<div class="col-sm-5">
																<label for="service"
																	class="col-form-label inner_md_htext">Speciality
																	Name <span class="mandate"><sup>&#9733;</sup></span>
																</label>
															</div>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="specialityName" name="specialityName"
																	placeholder="Speciality Name"
																	onkeypress="return validateText('specialityName',250,'Speciality Name');">
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
													onclick="addSpecialityDetails();">Add</button>
												<button type="button" id="updateBtn"
													class="btn  btn-primary "
													onclick="updateSpeciality();">Update</button>
												<button id="btnActive" type="button"
													class="btn  btn-primary "
													onclick="updateSpecialityStatus();">Activate</button>
												<button id="btnInActive" type="button"
													class="btn btn-primary  "
													onclick="updateSpecialityStatus();">Deactivate</button>
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
