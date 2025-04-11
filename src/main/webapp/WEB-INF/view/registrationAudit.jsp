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

nPageNo=1;
var $j = jQuery.noConflict();

 
</script>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">Audit Page for Registration</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>
								
								<div class="row ">
									<div class="col-md-12">
										<h6 class="font-weight-bold text-theme text-underline">Attendance Details</h6>
									</div>
								</div>
								<div class="table-responsive">
									<table
										class="table table-striped table-hover table-bordered " id="">
										<thead class="bg-success" style="color: #fff;">
											<tr>
												<th>Date</th>
												<th>Day</th>
												<th>Attendance</th>
												<th>Action</th>
											</tr>
										</thead>
										<tbody id="">
											<tr>
												<td> <input type="text" id="" class="form-control" disabled></td>
												<td> <input type="text" id="" class="form-control" disabled></td>
												<td> <input type="text" id="" class="form-control" disabled></td>
												<td>
													<div class="form-check form-check-inline cusRadio m-l-10">
														<input class="form-check-input" id="r1" name="same" type="radio">
														<span class="cus-radiobtn"></span>
														<label for="r1" class="col-form-label">Absent</label>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								
								<div class="row ">
									<div class="col-md-12">
										<h6 class="font-weight-bold text-theme text-underline">Attendance Details</h6>
									</div>
								</div>
								<div class="table-responsive" id="">
									<table
										class="table table-striped table-hover table-bordered" >
										<thead class="bg-success" style="color: #fff;">
											<tr>
												<th></th>
												<th>Date</th>
												<th>Name</th>
												<th>Action</th>
												<th>Remarks</th>
											</tr>
										</thead>
										<tbody id="">
											<tr>
												<td>APM</td>
												<td> <input type="text" id="" class="form-control" disabled></td>
												<td> <input type="text" id="" class="form-control" disabled></td>
												<td> <input type="text" id="" class="form-control" disabled></td>
												<td> <textarea type="text" rows="2" class="form-control" disabled></textarea></td>
											</tr>
											<tr>
												<td>Auditor</td>
												<td> <input type="text" id="" class="form-control" disabled></td>
												<td> <input type="text" id="" class="form-control" disabled></td>
												<td> <input type="text" id="" class="form-control" disabled></td>
												<td> <textarea type="text" rows="2" class="form-control" disabled></textarea></td>
											</tr>
											<tr>
												<td>CHMO</td>
												<td> <input type="text" id="" class="form-control" disabled></td>
												<td> <input type="text" id="" class="form-control" disabled></td>
												<td> <input type="text" id="" class="form-control" disabled></td>
												<td> <textarea type="text" rows="2" class="form-control" disabled></textarea></td>
											</tr>
											<tr>
												<td>UPSS</td>
												<td> <input type="text" id="" class="form-control" disabled></td>
												<td> <input type="text" id="" class="form-control" disabled></td>
												<td> <input type="text" id="" class="form-control" disabled></td>
												<td> <textarea type="text" rows="2" class="form-control" disabled></textarea></td>
											</tr>
										</tbody>
									</table>
								</div>
								
								<div class="row ">
									<div class="col-md-12">
										<h6 class="font-weight-bold text-theme text-underline">Action Against APM/Auditor</h6>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Warning To</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" multiple>
													<option>Select</option>
													<option>APM</option>
													<option>Auditor</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Remarks</label>
											</div>
											<div class="col-md-7">
												<textarea type="text" rows="3" class="form-control"></textarea>
											</div>
										</div>
									</div>
								</div>
								
								<div class="col-12 text-right">
									<button type="button" class="btn  btn-primary">Submit</button>
									<button type="button" class="btn  btn-primary">Close</button>
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
