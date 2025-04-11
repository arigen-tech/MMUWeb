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

				<div class="internal_Htext">Society - City Mapping</div>

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
												<select class="form-control" id="" onchange="">
												<option value="">Select</option>
												</select>
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6">
										<button type="button" class="btn btn-primary" onclick="">Search</button>
									</div>
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
                                                <th>MMU</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody id="">
										 <tr>
										 	<td>Society 1</td>
										 	<td>City 1, City 2, City 3</td>
										 	<td>Active</td>
										 </tr>
                     				 </tbody>
                                    </table>
								</div>
								
								<div class="row">
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label">Society Name</label>
											</div>
											<div class="col-md-6">
												<select class="form-control" id="" onchange="">
												<option value="">Select</option>
												</select>
											</div>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-md-2">
										<label class="col-form-label">City</label>
									</div>
									<div class="col-lg-10">
										<div class="row">
											<div class="col-sm-4 col-md-4 ">
								             	 <label><strong><spring:message code="lblallDesignation"/></strong></label> 
								             	<select multiple class="form-control height110" id="" name="">
				            			            
						                   		 </select>
						                   	</div>
													
											<div class="col-sm-1 col-md-1 text-center selectorImgDiv"> 
												
												<!-- <button id="addkey" class="btn btn-primary btn-sm btn-block m-t-10"><i class="fa fa-chevron-right"></i></button>
												<button id="removeKey" class="btn btn-primary btn-sm btn-block"><i class="fa fa-chevron-left"></i></button>
											 -->	
											  <div class="span2"> <span id="addkey" class="cursor-pointer"><img alt="" src="${pageContext.request.contextPath}/resources/images/rightarrow.jpg" width="30px"> </span></div>
												<div class="span2"> <span id="removeKey" class="cursor-pointer"><img alt="" src="${pageContext.request.contextPath}/resources/images/leftarrow.jpg" width="30px"> </span></div> 
											</div>
												
											<div class="col-sm-4 col-md-4 ">
											 	<label><strong><spring:message code="lblSelectedDesignation"/></strong></label> 
							                      <select multiple class="form-control height110" id="" name="">
							                      </select>
				               				</div>
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






