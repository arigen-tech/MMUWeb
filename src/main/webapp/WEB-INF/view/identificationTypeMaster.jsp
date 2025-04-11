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

				<div class="internal_Htext">Add/View Fund Allocation</div>

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
												<input type="text" class="form-control" disabled="disabled"/>
											</div>
										</div>
									</div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Scheme</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" disabled="disabled"/>
											</div>
										</div>
									</div>
									
									<!-- <div class="col-lg-4 col-sm-6">
										<button type="button" class="btn btn-primary" onclick="">Search</button>
									</div> -->
									<!-- <div class="col-lg-4 col-sm-6 text-right">
										<button type="button" class="btn btn-primary" onclick="">Show All</button>
									</div> -->
								</div>
								
								
								<div class="row m-t-20">
	                               	<div class="col-12">
	                               		<h6 class="font-weight-bold text-theme text-underline">Fund Allocation Details </h6>
	                               	</div>
	                               	
	                               	<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Date</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" name="" id="" class="calDate form-control" placeholder="DD/MM/YYYY">
												</div>
											</div>
										</div>
									</div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Total Allocated Amount</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" />
											</div>
										</div>
									</div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Letter No.</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control"/>
											</div>
										</div>
									</div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Choose File</label>
											</div>
											<div class="col-md-7">
												<div class="fileUploadDiv">
														<input type="file" class="inputUpload" name="" id="" value="">
														<label class="inputUploadlabel">Choose File</label> 
														<span class="inputUploadFileName">No File Chosen</span>
														
													</div>
											</div>
										</div>
									</div>
                               	</div>
                               	
                               	
								<div>
								<div style="float:left">               
                                   <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >   
                                   <tr>
	                                   <td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
	                                  <td></td>
						           </tr>
						         </table>
                                </div>  
                                
                                <div style="float:right">
                                  <div id="resultnavigation">
                                  </div> 
                                </div> 

                                    <table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th>UPSS</th>
                                                <th>Head Type</th>
                                                <th>Allocated Amount</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody id="">
										 <tr>
										 	<td>
										 		<select class="form-control">
										 			<option></option>
										 		</select>
										 	</td>
										 	<td>
										 		<select class="form-control">
										 			<option></option>
										 		</select>
										 	</td>
										 	<td>
										 		<input type="text" class="form-control">
									 		</td>
										 	<td>
												<button type="button" type="button"
													class="btn btn-primary buttonAdd noMinWidth" value=""
													button-type="add"></button>
												<button type="button" name="delete" value="" id="deleteMC"
													class="buttonDel btn btn-danger noMinWidth"
													button-type="delete"></button>
											</td>
										 </tr>
                     				 </tbody>
                                    </table>
								</div>
								
							<div class="row"> 
                               <div class="col-md-12 text-right">														 
									<input type="button"  id="" type="button" class="btn  btn-primary " onclick="" value="Submit" />
									<input type="button"  id="" type="button" class="btn  btn-primary " onclick="" value="Save" />
									<input type="button"  id="" type="button" class="btn  btn-primary " onclick="" value="Close" />
								</div>
                               </div>
                               
                               
                               <div class="row m-t-20">
                               	<div class="col-12">
                               		<h6 class="font-weight-bold text-theme text-underline">Fund Allocation History </h6>
                               	</div>
                               	
                               	<div class="col-12">
                               		<div class="table-responsive">
                               			<table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th>Date</th>
                                                <th>Total Amount</th>
                                                <th>UPSS</th>
                                                <th>Head Type</th>
                                                <th>Allocated Fund</th>
                                                <th>Letter Number</th>
                                                <th>View File</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody id="">
										 <tr>
										 	<td>22/05/2022</td>
										 	<td>50,000</td>
										 	<td>data</td>
										 	<td>data</td>
										 	<td>data</td>
										 	<td>data</td>
										 	<td><a href='#' class='btn btn-primary'><i class='fa fa-file-alt'></i> View </a></td>
										 </tr>
                     				 </tbody>
                                    </table>
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


</body>

</html>






