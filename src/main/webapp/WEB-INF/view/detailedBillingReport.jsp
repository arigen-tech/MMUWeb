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

				<div class="internal_Htext">Detailed Billing Report </div>

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
												<label class="col-form-label">Financial Year</label>
											</div>
											<div class="col-md-7">
												<select class="form-control"></select>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Society</label>
											</div>
											<div class="col-md-7">
												<select class="form-control"></select>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-7">
												<select class="form-control"></select>
											</div>
										</div>
									</div>
									
									<div class="w-100"></div>
									
									<div class="col-md-2 m-t-10">											
										<div class="form-check form-check-inline cusRadio">
											<input class="form-check-input" type="radio" name="Check" id="radiobtn1" value="1"> 
											<span class="cus-radiobtn"></span> 
											<label class="form-check-label" for="radiobtn1">Summary</label>
										</div>										
									</div>									
									<div class="col-md-2 m-t-10">										
										<div class="form-check form-check-inline cusRadio">
											<input class="form-check-input" type="radio" name="Check" id="radiobtn2" value="2"> 
											<span class="cus-radiobtn"></span> 
											<label class="form-check-label" for="radiobtn2">Detailed</label>
										</div>
									</div>
									
									
									<!-- <div class="col-lg-4 col-sm-6">
										<button type="button" class="btn btn-primary" onclick="">Search</button>
									</div> -->
								</div>
								
							<div class="row m-t-20">
								<div class="col-12">
                               		<h6 class="font-weight-bold text-theme text-underline">Summary</h6>
                               	</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Financial Year</label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" disabled>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Society</label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" disabled>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">City</label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" disabled>
										</div>
									</div>
								</div>
								
								<div class="col-12">
									<table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th>S.No.</th>
                                                <th>Vendor</th>
                                                <th>Amount Paid</th>
                                            </tr>
                                        </thead>
	                                        
	                                     <tbody>
											 <tr>
											 	<td>1</td>
											 	<td>Vendor 1</td>
											 	<td>20,000</td>											 	
											 </tr>
	                     				 </tbody>
	                                    </table>
								</div>
							</div>
							
							<div class="row m-t-20">
								<div class="col-12">
                               		<h6 class="font-weight-bold text-theme text-underline">Detailed</h6>
                               	</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Financial Year</label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" disabled>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Society</label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" disabled>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">City</label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" disabled>
										</div>
									</div>
								</div>
								
								<div class="col-12">
									<table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th>S.No.</th>
                                                <th>Vendor</th>
                                                <th>Invoice No.</th>
                                                <th>Invoice Date</th>
                                                <th>Invoice Amount</th>
                                                <th>Date of Payment</th>
                                                <th>Amount Paid</th>
                                            </tr>
                                        </thead>
	                                        
	                                     <tbody>
											 <tr>
											 	<td>1</td>
											 	<td>Vendor 1</td>
											 	<td>1111</td>
											 	<td>22/11/2021</td>
											 	<td>20,000</td>
											 	<td>20/12/2021</td>
											 	<td>20,000</td>											 	
											 </tr>
	                     				 </tbody>
	                                    </table>
								</div>
							</div>	
								
							<div class="row"> 
                               <div class="col-md-12 text-right">														 
									<input type="button"  id="" type="button" class="btn  btn-primary " onclick="" value="Export To PDF" />
									<input type="button"  id="" type="button" class="btn  btn-primary " onclick="" value="Export To Excel" />
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



