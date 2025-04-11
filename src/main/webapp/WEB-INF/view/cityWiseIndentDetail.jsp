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
	<%String mmuId = "0";
	if (session.getAttribute("mmuId") != null) {
		mmuId = session.getAttribute("mmuId") + "";
	
	}
	
	String userId = "0";
	if (session.getAttribute("userId") != null) {
		userId = session.getAttribute("userId") + "";
	}
	
	String cityId = "0";
	if (session.getAttribute("cityId") != null) {
		cityId = session.getAttribute("cityId") + "";
	}

	%>

	var $j = jQuery.noConflict();
	
	 $j(document).ready(function()
	{	
		var data = ${response};
		console.log("data is "+data);
		createTable(data);
			 
	});
	 
	 function createTable(jsonData){
		 	var htmlTable = "";
			var dataList = jsonData.list;
			console.log("dataList.length "+dataList.length);
			for (i = 0; i < dataList.length; i++) {
				
				/* htmlTable = htmlTable + "<tr>";
				htmlTable = htmlTable + '<td><div class="form-check form-check-inline cusCheck m-l-10">';
				htmlTable = htmlTable + '<input class="form-check-input" type="checkbox" id="zdiagcheckbox">';
				htmlTable = htmlTable + '<span class="cus-checkbtn"></span>';
				htmlTable = htmlTable + '<label class="form-check-label" for="zdiagcheckbox">'+dataList[i].nomenclature+'</label></div></td>'; */
				htmlTable = htmlTable + "<tr>";
				htmlTable = htmlTable + "<td style='width: 100px;'>"
						+ dataList[i].cityName + "</td>";
				htmlTable = htmlTable + "<td style='width: 100px;'>"
						+ dataList[i].requiredQty + "</td>";
				htmlTable = htmlTable + "<td style='width: 100px;'>"
						+ dataList[i].availableQty + "</td>";
				htmlTable = htmlTable + "<td style='width: 100px;'>"
						+ dataList[i].approvedQty + "</td>";
				//htmlTable += '<td style="display: none"><input type="hidden" value="'+dataList[i].itemId+'" id="itemId"></td>';

				htmlTable = htmlTable + "</tr>";
			}
			$('#nomenclature').val(dataList[0].nomenclature);
			if (dataList.length == 0) {
				htmlTable = htmlTable
						+ "<tr ><td colspan='4'><h6>No Record Found !!</h6></td></tr>";
			}
			console.log("htmlTable "+htmlTable);
			$j("#displayItemTable").html(htmlTable);

	 }
	 
	 function goBack(){
		window.location = "displayItemListDO";
	 }
	
</script>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">City Wise Indent Detail</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								
								<div class="">
									<div class="clearfix">
										<!-- <div style="float: left">
											<table class="tblSearchActions" cellspacing="0"
												cellpadding="0" border="0">
												<tr>
													<td class="SearchStatus" style="font-size: 15px;"
														align="left">Search Results</td>
													<td></td>
												</tr>
											</table>											
										</div>

										<div style="float: right">
											<div id="resultnavigation"></div>
										</div> -->
										<div class="row">
										<div class="col-md-8">
										<div class="form-group row">
											<div class="col-md-2">
												<label class="col-form-label">Drug Name</label>
											</div>
											<div class="col-md-8 col-md-8">
												<input type="text" id="nomenclature" class="form-control" />
											</div>
										</div>
										</div>
									</div>
										
										<div class="table-responsive " id="">
											<table
												class="table table-striped table-hover table-bordered " id="campTable">
												<thead class="bg-success" style="color: #fff;">
													<tr>
														<th>City Name</th>
														<th>Required Quantity</th>
														<th>Available Quantity</th>
														<th>Approved Quantity</th>
													</tr>
												</thead>
												<tbody id="displayItemTable">
													<!-- <tr>
														<td>
															<div class="form-check form-check-inline cusCheck m-l-10">
																<input class="form-check-input" type="checkbox" id="zdiagcheckbox">
																<span class="cus-checkbtn"></span> 
																<label class="form-check-label" for="zdiagcheckbox">Nomenclature 1</label>
															</div>
														</td>
														<td class="width180">No</td>
														<td class="width180">100</td>
														<td class="width180">3000</td>
														<td class="width180">3000</td>														
													</tr> -->
												</tbody>
											</table>
										</div>
										
										<div class="row">
											<div class="col-md-12 m-t-10 text-right">
												<button type="button" id="submit_btn" class="btn btn-primary" onclick="goBack()">Close</button>
											
											</div>
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

			</div>
			<!-- container -->
			<!-- content -->
		</div>
	</div>
	<!-- END wrapper -->

	<!-- jQuery  -->


</body>

</html>