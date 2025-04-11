
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<title>Pending Admission List</title>
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
	%>
		var nPageNo = 1;
	var $j = jQuery.noConflict();

	$j(document).ready(function() {
		getAdmissionPendingList('ALL');

	});

	function getAdmissionPendingList(MODE) {
		//alert("inside getReferredList");
		var cmdId = 0;
		var patient_name = $j('#patient_name').val();
		var service_no = $j('#service_no').val();

		if (patient_name === undefined) {
			patient_name = "";
		}
		if (service_no === undefined) {
			service_no = "";
		}

		if (MODE == 'ALL') {
			var data = {"hospital_id" :<%=hospitalId%>,"service_no" : "","patient_name" : "",	"pageNo" : nPageNo}

		} else {
			var data = {"hospital_id" :<%=hospitalId%>,"service_no" : service_no,"patient_name" : patient_name,	"pageNo" : nPageNo}

		};

		var bClickable = true;
		var url = "getAdmissionPendingList";
		GetJsonData('tblListofObesity', data, url, bClickable);
	}

	function search() {
		
		var service_no = $j('#service_no').val();
		var patient_name = $j('#patient_name').val();
		if ((service_no == undefined || service_no == '')
				&& (patient_name == undefined || patient_name == '')) {
			alert("Atleast one of the search option must be entered");
			return;
		}
		getAdmissionPendingList('Filter');
		//ResetForm();
	}

	function rowClickable(data) {
		var data = 'discharge_table';
		$j("#" + data + " tr[id!='0']").hover(function() {
			$j(this).css("background-color", "#EDF4DA");

			$j(this).css("cursor", "pointer");

		}, function() {

			$j(this).css("background-color", "");
		}).click(function() {
			rowClick($j(this).attr("id"), data);
		});
	}

	function makeTable(jsonData) {
		var htmlTable = "";
		var data = jsonData.count;

		var pageSize = 5;
		var dataList = jsonData.admissionPendingList;
		console.log("dataList "+dataList);
		for (i = 0; i < dataList.length; i++) {

			htmlTable = htmlTable + "<tr id='"+dataList[i].id+"' >";
			htmlTable = htmlTable + "<td style='width: 150px;'>"
					+ dataList[i].service_no + "</td>";
			htmlTable = htmlTable + "<td style='width: 150px;'>"
					+ dataList[i].patient_name + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>"
					+ dataList[i].age + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>"
					+ dataList[i].gender + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>"
					+ dataList[i].rank + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>"
					+ dataList[i].mobile_no + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>"
					+ dataList[i].name + "</td>";
					htmlTable = htmlTable + "<td style='width: 100px;'>"
					+ dataList[i].relation + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>"
					+ dataList[i].hospital_name + "</td>";

			htmlTable = htmlTable + "</tr>";

		}

		if (dataList.length == 0) {
			htmlTable = htmlTable
					+ "<tr ><td colspan='9'><h6>No Record Found !!</h6></td></tr>";
		}

		$j("#tblListofObesity").html(htmlTable);

	}

	function executeClickEvent(Id) {
		window.location = "admission?id=" + Id + "";

	}

	/*  function rowClick(Id){
	 window.location = "admissionAndDischarge?id="+Id+"";
	 } */
	function ResetForm() {
		$j('#service_no').val('');
		$j('#patient_name').val('');
	}
	function newAdmission() {
		window.location = "newAdmission";
	}

	function showResultPage(pageNo) {

		nPageNo = pageNo;
		getAdmissionPendingList('FILTER');

	}
	
	 function showAll()
	 {
	 	ResetForm();
	 	nPageNo = 1;	
	 	getAdmissionPendingList('ALL');	 	
	 }
	 
	 function ResetForm()
	 {	
		 $j('#service_no').val('');
		 $j('#patient_name').val('');
	 }
</script>
<body>
 <!-- Begin page -->
    <div id="wrapper">

	<div class="content-page">
		<!-- Start content -->
		<div class="">
			<div class="container-fluid">
				<div class="internal_Htext">Pending Admission List</div>
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">

								<form>
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-4 col-form-label">Service No.</label>
												<div class="col-sm-7">
													<input class="form-control  form-control-sm"
														id="service_no"> </input>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Patient Name</label>
												<div class="col-sm-7">
													<input class="form-control form-control-sm" type="text"
														placeholder="" id="patient_name">
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
										
										<!-- <div class="col-md-1">
											<div class="form-group">
												
												
													 <div class="btn-right-all obesityWait-search">
														<button type="button" class="btn btn-primary mn-t-2" onclick="showAll('ALL');">Show All</button>
														</div>
												
											</div>
										</div>	
										
										<div class="col-md-2">
											<div class="form-group">

											    <div class="btn-right-all">
													<button type="button" class="btn btn-primary" onclick="newAdmission()">New Admission</button>
												</div>
												
											</div>
										</div> -->
										
										<div class="col-md-3">
											<div class="form-group clearfix">
											
											    <div class="btn-right-all">
													<button type="button" class="btn btn-primary" onclick="newAdmission()">New Admission</button>
												</div>
												
												<div class="btn-right-all obesityWait-search m-r-10">
													<button type="button" class="btn btn-primary" onclick="showAll('ALL');">Show All</button>
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
													<th id="th1">Service No.</th>
													<th id="th2">Patient Name</th>
													<th id="th3">Age</th>
													<th id="th4">Gender</th>
													<th id="th5">Rank</th>
													<th id="th6">Mobile No.</th>
													<th id="th6">Emp Name</th>
													<th id="th6">Relation</th>
													<th id="th7">Hospital Name</th>
												</tr>
											</thead>
											<tbody id="tblListofObesity">
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