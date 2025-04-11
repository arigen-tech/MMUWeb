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

				<div class="internal_Htext">Capture Vendor Bill Detail</div>

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
												<select class="form-control">
												</select>
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-7">
												<select class="form-control">
												</select>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
											<div class="col-md-4">
												<div class="form-group row  autocomplete">

													<label class="col-md-5 col-form-label">MMU</label>
													<div class="col-md-7">
															<div class="autocomplete forTableResp">
															<input type="text" autocomplete="never" class="form-control border-input" name="" id=""/>
															<div id="divPvms1" class="autocomplete-itemsNew"></div>
													</div>

												</div>
											</div>
											</div>

											<div class="col-md-4">
												<select name="diagnosisId" multiple="4" value="" size="5"
													tabindex="1" id="diagnosisId" class="listBig width-full disablecopypaste">
												</select>
											</div>
											<div class="col-md-4">
												<button type="button" class="buttonDel btn  btn-danger"
													value="" onclick="deleteDgItems();"
													align="right" />
												Delete
												</button>
												
											</div>
								
								</div>
								<div class="row m-t-10">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Month and Year</label>
											</div>
											<div class="col-md-7">
												<select class="form-control">
												</select>
											</div>
											
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<label class="col-form-label col-md-1">/</label>
											<div class="col-md-7">
												<select class="form-control">
												</select>
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
												<input type="text" id="" class="form-control"/>
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
													<input type="text" name="" id="" class="calDate form-control" value="" placeholder="DD/MM/YYYY" />
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
												<input type="text" id="" class="form-control"/>
											</div>
											
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Upload Bill</label>
											</div>
											<div class="col-md-7">
												<div class="fileUploadDiv">
												  	<input type="file" class="inputUpload">
												  	<label class="inputUploadlabel">Choose File</label>
													<span id="" class="inputUploadFileName">No File Chosen</span>													
											  	</div>
											</div>
										</div>
									</div>
								</div>
								
								<div class="row">
                                	<div class="col-12 m-t-10 text-right">
                               			<button type="submit" class="btn btn-primary">Submit</button>
                               			<button type="submit" class="btn btn-primary">Close</button>
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
<script>


</script>

</html>


<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>




