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
<title>Indian Coast Guard</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>

<script type="text/javascript">

	var $j = jQuery.noConflict();
	
</script>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">MMSSY Arrival Time Report</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Date</label>
											</div>
											<div class="dateHolder">
												<input type="text" name="" id="" class="calDate form-control" value="" placeholder="DD/MM/YYYY" >
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-7">
												<select class="form-control">
												
												</select>
											</div>
										</div>
									</div>

									<div class="col-lg-4 col-sm-6">
										
										<button type="button" class="btn btn-primary m-t-3" onclick="">Search</button>
										
									</div>
								</div>

								<div class="m-t-10">
									<div class="clearfix">
										<div style="float: left">
											<table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0">
												<tr>
													<td class="SearchStatus" style="font-size: 15px;"
														align="left">Search Results</td>
													<td></td>
												</tr>
											</table>											
										</div>

										<div style="float: right">
											<div id="resultnavigation"></div>
										</div>
										<div class="table-responsive" id="table_div">
											<table
												class="table table-striped table-hover table-bordered " id="">
												<thead class="bg-success" style="color: #fff;">
													<tr>
														<th class="text-center" colspan="2">S.No</th>
														<th class="text-center" colspan="7">Indent No</th>
													</tr>
													<tr>
														<th>S.No</th>
														<th>Nigam Name</th>
														<th>MMU Number- Report</th>
														<th>APM Name</th>
														<th>Present/Absent/Camp Off</th>
														<th>MMU Arrival at Location</th>
														<th>Doctor Arrived At</th>
														<th>Labour Dept. Came At</th>
														<th>Nistha Status - all 5 staff nistha complete</th>
													</tr>
												</thead>
												<tbody id="">
													<tr>
														<td rowspan="2">1</td>
														<td rowspan="2">Raipur</td>
														<td>MMU 1</td>	
														<td>Amar</td>	
														<td>Camp Off</td>
														<td class="text-center" colspan="4">Camp Off</td>													
													</tr>
													<tr>
														<td>MMU 2</td>	
														<td>Amar</td>	
														<td>Present</td>
														<td>8:00 AM</td>
														<td>8:20 AM</td>
														<td>Present</td>
														<td>All Staff nistha completed</td>													
													</tr>
													<tr>
														<td>1</td>
														<td>Dhamtari</td>
														<td>MMU 3</td>	
														<td>Amar</td>	
														<td>Present</td>
														<td>8:00 AM</td>
														<td>8:20 AM</td>
														<td>Present</td>
														<td>All Staff nistha completed</td>													
													</tr>
													
												</tbody>
											</table>
										</div>
									</div>
								</div>
								
								<div class="row m-t-10">
									<div class="col-12 text-right">
										<button type="button" class="btn btn-primary">Generate Report</button>
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
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
