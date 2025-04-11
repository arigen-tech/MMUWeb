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

				<div class="internal_Htext">Vendor Invoice Approval Page (Approving Authority)</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Vendor</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" disabled="disabled"/>
											</div>
										</div>
									</div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" disabled="disabled"/>
											</div>
										</div>
									</div>
									<div class="w-100"></div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">MMU</label>
											</div>
											<div class="col-md-7">
												<textarea class="form-control" rows="3" disabled="disabled"></textarea>
											</div>
										</div>
									</div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Year/Month</label>
											</div>
											<div class="col-md-3">
												<input type="text" class="form-control" disabled="disabled"/>
											</div>
											<div class="col-md-1" style="font-size:20px;">/</div>
											<div class="col-md-3">
												<input type="text" class="form-control" disabled="disabled"/>
											</div>
											
										</div>
									</div>
									
									<div class="w-100"></div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Invoice No.</label>
											</div>
											<div class="col-md-7">											
												<input type="text" class="form-control" disabled="disabled"/>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Invoice Date</label>
											</div>
											<div class="col-md-7">											
												<input type="text" class="form-control" disabled="disabled"/>
											</div>
										</div>
									</div>
									
									<div class="w-100"></div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Invoice Amount</label>
											</div>
											<div class="col-md-7">											
												<input type="text" class="form-control" disabled="disabled"/>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												
											</div>
											<div class="col-md-7">
												<button type="button" class="btn btn-primary">Download Bill</button>
											</div>
										</div>
										
									</div>
								</div>
								
								<div class="row m-t-20">
	                               	<div class="col-12">
	                               		<h6 class="font-weight-bold text-theme text-underline">Auditor's Details</h6>
	                               	</div>
	                               	<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Date</label>
											</div>
											<div class="col-md-7">											
												<input type="text" class="form-control" disabled="disabled"/>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Name</label>
											</div>
											<div class="col-md-7">											
												<input type="text" class="form-control" disabled="disabled"/>
											</div>
										</div>
									</div>
                               	</div>
								
								<div class="row m-t-20">
	                               	<div class="col-12">
	                               		<h6 class="font-weight-bold text-theme text-underline">Penalty Details</h6>
	                               	</div>
                               	
	                               	<div class="col-12">
	                               		<div class="table-responsive">
	                               			<table class="table table-striped table-hover table-bordered ">
	                                        <thead class="bg-success" style="color:#fff;">
	                                            <tr>
	                                                <th>MMU Name</th>
	                                                <th>Incident Date</th>
	                                                <th>Incident Description</th>
	                                                <th>Penalty Amount</th>
	                                                <th>Auditor's Remark</th>
	                                                <th>Remove Penalty</th>
	                                                <th>CO Remark</th>
	                                            </tr>
	                                        </thead>
	                                        
	                                     <tbody id="">
											 <tr>
											 	<td>MMU 1</td>
											 	<td>22/12/2021</td>
											 	<td>Equipment Check</td>
											 	<td>2000</td>
											 	<td>
													<textarea rows="2" class="form-control" disabled></textarea>
												</td>
												<td class="width150 text-center">
											  		<div class="form-check form-check-inline cusCheck m-t-7">
															<input class="form-check-input" id="" name="" type="checkbox" disabled >
														<span class="cus-checkbtn"></span>
													</div>
											  	</td>
												<td>
													<textarea rows="2" class="form-control" disabled></textarea>
												</td>
											 </tr>
	                     				 </tbody>
	                                    </table>
	                               		</div>                               	
	                               	</div>
                               </div>
							
							<div class="row">
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Audit Report</label>
										</div>
										<div class="col-md-7">
											<a class="m-t-5 btn btn-link" href="javascript:void(0);">View File</a>
										</div>
									</div>
								</div>
							</div>
							
							<div class="row m-t-20">
	                               	<div class="col-12">
	                               		<h6 class="font-weight-bold text-theme text-underline">Approving Authority</h6>
	                               	</div>
	                               	<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Action</label>
											</div>
											<div class="col-md-7">											
												<select class="form-control">
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Remarks</label>
											</div>
											<div class="col-md-7">											
												<textarea class="form-control" rows="3"></textarea>
											</div>
										</div>
									</div>
                               	</div>
                               	
							<div class="row"> 
                               <div class="col-md-12 text-right">														 
									<input type="button"  id="" type="button" class="btn  btn-primary " onclick="" value="Submit" />
									<input type="button"  id="" type="button" class="btn  btn-primary " onclick="" value="Close" />
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


</body>

</html>



