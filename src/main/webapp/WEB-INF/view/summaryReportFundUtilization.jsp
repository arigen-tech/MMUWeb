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

				<div class="internal_Htext">Generate Report for Fund Allocation</div>

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
									
									<div class="w-100"></div>
									
									<div class="col-md-2 m-t-5 ">											
										<div class="form-check form-check-inline cusRadio">
											<input class="form-check-input" type="radio" name="Check" id="radiobtn1" value="1"> 
											<span class="cus-radiobtn"></span> 
											<label class="form-check-label" for="radiobtn1">Society Wise</label>
										</div>										
									</div>									
									<div class="col-md-2 m-t-5">										
										<div class="form-check form-check-inline cusRadio">
											<input class="form-check-input" type="radio" name="Check" id="radiobtn2" value="2"> 
											<span class="cus-radiobtn"></span> 
											<label class="form-check-label" for="radiobtn2">City Wise</label>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Society Wise</label>
											</div>
											<div class="col-md-7">
												<select class="form-control"></select>
											</div>
										</div>
									</div>
									
									
									<div class="col-lg-4 col-sm-6">
										<button type="button" class="btn btn-primary" onclick="">Search</button>
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
                                                <th>Society</th>
                                                <th>Total Fund Allocated</th>
                                                <th>Total Issued Amount</th>
                                                <th>Total Fund Utilized</th>
                                                <th>Available Balance</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody id="">
										 <tr>
										 	<td rowspan="2">Society 1</td>
										 	<td rowspan="2">5,00,000</td>
										 	<td rowspan="2">4,00,000</td>										 	
						 					<td>City 1</td>
						 					<td>12</td>
						 					<td>2,30,000</td>
						 					<td>20,000</td>
										 </tr>
										  <tr>
						 					<td>City 2</td>
						 					<td>1</td>
						 					<td>2,00,000</td>
						 					<td>12,000</td>
										 </tr>
										  <tr>
										 	<td>Society 2</td>
										 	<td>5,00,000</td>
										 	<td>4,00,000</td>										 	
						 					<td>City 3</td>
						 					<td>12</td>
						 					<td>2,30,000</td>
						 					<td>20,000</td>
										 </tr>
                     				 </tbody>
                                    </table>
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



