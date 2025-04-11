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
		//$j('#conditionCode').attr('readonly', false);
		GetAllCondition('ALL');
	});

	function GetAllCondition(MODE) {

		var conditionName = jQuery("#searchCondition").attr(
				"checked", true).val().toUpperCase();
		var conditionId = 0;
		if (MODE == 'ALL') {
			var data = {
				"PN" : nPageNo,
				"conditionName" : ""
			};
		} else {
			var data = {
				"PN" : nPageNo,
				"conditionName" : conditionName
			};
		}
		var url = "getAllCondition";
		var bClickable = true;
		GetJsonData('tblListOfCondition', data, url, bClickable);
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
					+ "<tr id='"+dataList[i].conditionId+"' >";
			/* htmlTable = htmlTable + "<td style='width: 150px;'>"
					+ dataList[i].conditionCode + "</td>"; */
			htmlTable = htmlTable + "<td style='width: 150px;'>"
					+ dataList[i].conditionName + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>" + Status
					+ "</td>";
			htmlTable = htmlTable + "</tr>";

		}
		if (dataList.length == 0) {
			htmlTable = htmlTable
					+ "<tr ><td colspan='2'><h6>No Record Found</h6></td></tr>";

		}

		$j("#tblListOfCondition").html(htmlTable);

	}

	var cId;
	//var cCode;
	var cName;
	var cStatus;

	function executeClickEvent(conditionId, data) {

		for (j = 0; j < data.data.length; j++) {
			if (conditionId == data.data[j].conditionId) {
				cId = data.data[j].conditionId;
				//cCode = data.data[j].conditionCode;
				cName = data.data[j].conditionName;
				cStatus = data.data[j].status;

			}
		}
		rowClick(cId, cName, cStatus);
	}

	function rowClick(cId,cName,cStatus) {

		//document.getElementById("conditionCode").value = cCode;
		document.getElementById("conditionName").value = cName;

		if (cStatus == 'Y' || cStatus == 'y') {
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAdd').hide();
			//$j('#conditionCode').attr('readonly', true);
			
		}
		if (cStatus == 'N' || cStatus == 'n') {
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAdd').hide();
			//$j('#conditionCode').attr('readonly', true);
			
		}

		

	}

	function searchConditionList() {
		if (document.getElementById('searchCondition').value == ""
				|| document.getElementById('searchCondition') == null) {
			alert("Plese Enter Condition Name");
			return false;
		}

		var conditionName = jQuery("#searchCondition").attr(
				"checked", true).val().toUpperCase();

		var nPageNo = 1;
		var url = "getAllCondition";
		var data = {
			"PN" : nPageNo,
			"conditionName" : conditionName
		};
		var bClickable = true;
		GetJsonData('tblListOfCondition', data, url, bClickable);
	}
	var success;
	var error;
	function addConditionDetails() {
		
		/* if (document.getElementById('conditionCode').value == null
				|| document.getElementById('conditionCode').value == "") {
			alert("Please Enter Condition Code");
			return false;
		} */
		if (document.getElementById('conditionName').value == null
				|| document.getElementById('conditionName').value == "") {
			alert("Please Enter Condition Name");
			return false;
		}
		$('#btnAdd').prop("disabled",true);
		var userId = $j('#userId').val();
		var params = {
			//'conditionCode' : jQuery('#conditionCode').val(),
			'conditionName' : jQuery('#conditionName').val(),
			'userId' : userId

		}

		var url = "addCondition";
		SendJsonData(url, params);

	}

	function updateCondition() {
		/* if (document.getElementById('conditionCode').value == null
				|| document.getElementById('conditionCode').value == "") {
			alert("Please Enter Condition Code");
			return false;
		} */
		if (document.getElementById('conditionName').value == null
				|| document.getElementById('conditionName').value == "") {
			alert("Please Enter Condition Name");
			return false;
		}

		var userId = $j('#userId').val();
		var params = {
			'conditionId' : cId,
			//'conditionCode' : jQuery('#conditionCode').val(),
			'conditionName' : jQuery('#conditionName').val(),
			'userId' : userId

		}

		var url = "updateConditionDetails";
		SendJsonData(url, params);

		$j("#btnInActive").hide();
		$j("#btnActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAdd').show();
		ResetForm();

	}

	function updateConditionStatus() {
		/* if (document.getElementById('conditionCode').value == null
				|| document.getElementById('conditionCode').value == "") {
			alert("Please Enter Condition Code");
			return false;
		} */
		if (document.getElementById('conditionName').value == null
				|| document.getElementById('conditionName').value == "") {
			alert("Please Enter Condition Name");
			return false;
		}
		var userId = $j('#userId').val();
		var params = {
			'conditionId' : cId,
			//'conditionCode' : cCode,
			'status' : cStatus,
			'userId' : userId

		}
		var url = "updateConditionStatus";
		SendJsonData(url, params);
		$j("#btnInActive").hide();
		$j("#btnActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAdd').show();
		ResetForm();

	}

	function Reset() {
		document.getElementById("addConditionForm").reset();
		document.getElementById("searchConditionForm").reset();
		document.getElementById('searchCondition').value = "";

		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAdd').show();
		document.getElementById("messageId").innerHTML = "";
		$("#messageId").css("color", "black");
		//$j('#conditionCode').attr('readonly', false);
		showAll();
	}

	function ResetForm() {
		//$j('#conditionCode').val('');
		$j('#conditionName').val('');
		$j('#searchCondition').val('');
		$j('#conditionCode').attr('readonly', false);

	}
	
	function showAll() {
		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAdd').show();
		ResetForm();
		nPageNo = 1;
		GetAllCondition('ALL');
		

	}

	function showResultPage(pageNo) {
		nPageNo = pageNo;
		GetAllCondition('FILTER');

	}

	function search() {
		if (document.getElementById('searchCondition').value == "") {
			alert("Please Enter Condition Name");
			return false;
		}
		nPageNo = 1;
		GetAllCondition('Filter');
	}

	function generateReport() {
		var url="${pageContext.request.contextPath}/report/generatePatientConditionReport";
		openPdfModel(url);
		/* document.searchConditionForm.action = "${pageContext.request.contextPath}/report/generatePatientConditionReport";
		document.searchConditionForm.method = "POST";
		document.searchConditionForm.submit(); */

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
					<div class="internal_Htext">Patient Condition Master</div>

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
												id="searchConditionForm"
												name="searchConditionForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Condition Name<span
														class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchCondition"
															id="searchCondition" class="form-control"
															id="inlineFormInputGroup" placeholder="Condition Name">

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
												<!-- <th id="th2" class="inner_md_htext">Condition Code</th> -->
												<th id="th3" class="inner_md_htext">Condition Name</th>
												<th id="th5" class="inner_md_htext">Status</th>
											</tr>
										</thead>
										<!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
										<tbody class="clickableRow" id="tblListOfCondition">

										</tbody>
									</table>

									<div class="row">
										<div class="col-md-12">
											<form id="addConditionForm"
												name="addConditionForm" method="">
												<div class="row">
													<!-- <div class="col-md-4">
														<div class="form-group row">
															<div class="col-sm-5">
																<label for="Condition Code"
																	class=" col-form-label inner_md_htext">Condition
																	Code <span class="mandate"><sup>&#9733;</sup></span>
																</label>
															</div>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="conditionCode" name="conditionCode"
																	placeholder="Condition Code"
																	onkeypress=" return validateTextGen('conditionCode',7, 'Condition Code');">
															</div>
														</div>
													</div> -->
													<div class="col-md-4">
														<div class="form-group row">
															<div class="col-sm-5">
																<label for="service"
																	class="col-form-label inner_md_htext">Condition
																	Name <span class="mandate"><sup>&#9733;</sup></span>
																</label>
															</div>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="conditionName" name="conditionName"
																	placeholder="condition Name"
																	onkeypress="return validateText('conditionName',30,'Condition Name');">
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
													onclick="addConditionDetails();">Add</button>
												<button type="button" id="updateBtn"
													class="btn  btn-primary "
													onclick="updateCondition();">Update</button>
												<button id="btnActive" type="button"
													class="btn  btn-primary "
													onclick="updateConditionStatus();">Activate</button>
												<button id="btnInActive" type="button"
													class="btn btn-primary  "
													onclick="updateConditionStatus();">Deactivate</button>
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