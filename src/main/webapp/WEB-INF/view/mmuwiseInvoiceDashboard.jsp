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

				<div class="internal_Htext">MMU Wise Invoice Dashboard</div>

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
												<label class="col-form-label">UPSS</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" disabled value="Name 1"> 
											</div>
										</div>
									</div>
									
									
								</div>
								
								
								
								<div class="row">
									
									
									<div class="col-12">
										<div class="table-responsive">
									<table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>    
                                                <th>S. No.</th>
                                                <th>Vendor</th>
                                                <th>MMU</th>
                                                <th>Invoice Date</th>
                                                <th>Invoice No.</th>
                                                <th>Uncleared Amount</th>
                                                <th>View File</th>
                                                <th>Track</th>
                                            </tr>
                                        </thead>                                        
	                                     <tbody class="" id="">
											 <tr>
											 	<td>1.</td>
											 	<td>Vendor 1</td>
											 	<td>MMU 1</td>
											 	<td>20/01/2022</td>
											 	<td>111</td>
											 	<td>10000</td>
											 	<td><a href="#" class="btn btn-link">File 1</a></td>
											 	<td><a href="#" class="btn btn-link">Track</a></td>
											 </tr>
	                     				 </tbody>
                                    </table>
								</div>
									</div>
								</div>
								
								
								<div class="row"> 
	                               <div class="col-md-12 text-right">														 
										<input type="button"  id="" type="button" class="btn  btn-primary " onclick="" value="Print" />
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






