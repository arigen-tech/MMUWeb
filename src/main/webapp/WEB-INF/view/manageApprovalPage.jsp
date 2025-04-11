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

				<div class="internal_Htext">Manage Approval Flow (Society Wise)</div>

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
												<label class="col-form-label">Society Name</label>
											</div>
											<div class="col-md-7">
												<select class="form-control"></select>
											</div>
										</div>
									</div>
									
									
									
									<div class="col-lg-4 col-sm-6">
										<button type="button" class="btn btn-primary" onclick="">Search</button>
									</div>
									<div class="col-lg-4 col-sm-6 text-right">
										<button type="button" class="btn btn-primary" onclick="">Show All</button>
									</div>
								</div>
								
								<div class="table-responsive">
									<table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th>Society Name</th>
                                                <th>Authority Name</th>
                                                <th>Sequence</th>
                                                <th>Permit Action</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        
	                                     <tbody class="" id="">
											 <tr>
											 	<td>Society 1</td>
											 	<td>Authority 1</td>
											 	<td>1</td>
											 	<td>Yes</td>
											 	<td>Active</td>
											 </tr>
	                     				 </tbody>
                                    </table>
								</div>
								
								<div class="row">
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Society Name</label>
											</div>
											<div class="col-md-7">
												<select class="form-control"></select>
											</div>
										</div>
									</div>
									
									<div class="col-12">
										<div class="table-responsive">
									<table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>                                              
                                                <th>Authority</th>
                                                <th>Sequence</th>
                                                <th>Permit Action</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        
	                                     <tbody class="" id="">
											 <tr>
											 	<td>
											 		<select class="form-control"></select>
											 	</td>
											 	<td>
													<select class="form-control"></select>
												</td>
											 	<td class="width150 text-center">
											  		<div class="form-check form-check-inline cusCheck m-t-7">
															<input class="form-check-input" id="" name="" type="checkbox">
														<span class="cus-checkbtn"></span>
													</div>
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
									</div>
								</div>
								
								
								<div class="row"> 
                               <div class="col-md-12 text-right">														 
									<input type="button"  id="btnActiveUnitAdmin" type="button" class="btn  btn-primary " onclick="" value="Add" /> 
									<input type="button"  id="btnActiveUnitAdmin" type="button" class="btn  btn-primary " onclick="" value="Reset" />
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






