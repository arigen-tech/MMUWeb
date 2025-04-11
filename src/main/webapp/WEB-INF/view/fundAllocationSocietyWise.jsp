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

				<div class="internal_Htext">Fund Allocation (Society Wise)</div>

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
												<select class="form-control" id="" onchange="">
													<option value="">Select</option>
												</select>
											</div>
										</div>
									</div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Society</label>
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
												<label class="col-form-label">Total Allocated Fund</label>
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
												<label class="col-form-label">Previously Issued Fund</label>
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
												<label class="col-form-label">Available Balance</label>
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
                                                <th>Society</th>
                                                <th>Previously Allocated Fund</th>
                                                <th>Available Balance</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody id="">
										 <tr>
										 	<td>
										 		<select class="form-control" id="" onchange="">
													<option value="">Select</option>
												</select>
										 	</td>
										 	<td><input type="text" class="form-control" disabled="disabled"/></td>
										 	<td><input type="text" class="form-control" disabled="disabled"/></td>
										 	<td><button type="button" class="btn btn-primary">Add/View</button></td>
										 </tr>
                     				 </tbody>
                                    </table>
								</div>
								
							<div class="row"> 
                               <div class="col-md-12 text-right">														 
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






