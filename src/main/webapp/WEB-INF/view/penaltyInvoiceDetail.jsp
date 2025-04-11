<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<title></title>

</head>

<body>
 <!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">Penalty Invoice Details</div>

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
												<label class="col-form-label">Vendor</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="" class="form-control" disabled/>
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="" class="form-control" disabled/>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
											<div class="col-md-4">
												<div class="form-group row  autocomplete">

													<label class="col-md-5 col-form-label">MMU</label>
													<div class="col-md-7">
															<select name="diagnosisId" multiple="4" value="" size="5"
																tabindex="1" id="diagnosisId" class="listBig width-full disablecopypaste" disabled>
															</select>
													</div>

												</div>
											</div>	
											<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">Month and Year</label>
													</div>
													<div class="col-md-7">
														<input type="text" id="" class="form-control" disabled/>
													</div>
													
												</div>
											</div>
											<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<label class="col-form-label col-md-1">/</label>
													<div class="col-md-7">
														<input type="text" id="" class="form-control" disabled/>
													</div>
												</div>
											</div>						
								</div>
								<div class="row m-t-10">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Invoice No</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="" class="form-control" disabled/>
											</div>
											
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Invoice No</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" id="" class="form-control" disabled/>
												</div>
											</div>
										</div>
									</div>
								</div>
								
								<div class="row m-t-10">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Invoice Amount</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="" class="form-control" disabled/>
											</div>
											
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Upload Bill</label>
											</div>
											<div class="col-md-7">
												<button class="btn btn-primary" data-toggle="modal" data-target="#billModal" data-background="static">View Bill</button>
											</div>
										</div>
									</div>
								</div>
								
								<div>
									<h6 class="font-weight-bold text-theme text-underline">Penalty Details</h6>
									
									<div class="table-responsive">
										<table
											class="table table-striped table-hover table-bordered " id="campTable">
											<thead class="bg-success" style="color: #fff;">
												<tr>
													<th>MMU Name</th>
													<th>Penalty Amount</th>
													<th>Action</th>
												</tr>
											</thead>
											<tbody id="">
												<tr>
													<td>MMU 1</td>
													<td>10000</td>
													<td><button class="btn btn-primary" data-toggle="modal" data-target="#penaltyModal" data-background="static">View</button></td>									
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								
								<div class="row">
                                	<div class="col-12 m-t-10 text-right">
                               			<button class="btn btn-primary">Close</button>
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

<div class="modal" id="billModal" tabindex="-1" role="dialog" aria-labelledby="billModal">
	  <div class="modal-dialog modal-lg" role="document">
	  <input type="hidden" id="" name="" value="">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title font-weight-bold">View Bill</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">	      		
						
	      </div>
	       
	    </div>
	  </div>
</div>

<div class="modal" id="penaltyModal" tabindex="-1" role="dialog" aria-labelledby="penaltyModal">
	  <div class="modal-dialog modal-lg" role="document">
	  <input type="hidden" id="" name="" value="">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title font-weight-bold">Penalty Details</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body"> 
	      	<div class="row">
				<div class="col-md-3">
					<label class="col-form-label">MMU  Name</label>
				</div>
				<div class="col-md-9">
					<label class="col-form-label">: MMU  1</label>
				</div>
	      	</div>
	      	<div class="table-responsive m-t-10">
				<table
					class="table table-striped table-hover table-bordered " id="campTable">
					<thead class="bg-success" style="color: #fff;">
						<tr>
							<th>Incident Date</th>
							<th>Incident Description</th>
							<th>Penalty Amount</th>
						</tr>
					</thead>
					<tbody id="">
						<tr>
							<td>
								<div class="dateHolder width120">
									<input type="text" name="" id="" class="input_date form-control" value="" placeholder="DD/MM/YYYY" />
								</div>
							</td>
							<td><textarea class="form-control" rows="2" cols=""></textarea></td>
							<td>10000</td>								
						</tr>
					</tbody>
				</table>
			</div>
	      	<div class="row">
            	<div class="col-12 m-t-10 text-right">
           			<button class="btn btn-primary"  data-dismiss="modal" aria-label="Close" >Close</button>
           		</div>
      		</div>
	      </div>
	       
	    </div>
	  </div>
</div>

	
</body>

</html>


<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>




