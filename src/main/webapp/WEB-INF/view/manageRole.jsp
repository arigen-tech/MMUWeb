<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Indian Coast Guard</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>

</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">

		
		<!-- ========== Left Sidebar Start ========== -->

		<!-- Left Sidebar End -->

		<!-- ============================================================== -->
		<!-- Start right Content here -->
		<!-- ============================================================== -->
		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="row">
						<div class="col-12">
							<div class="page-title-box">
								<h4 class="page-title float-left">Manage Role</h4>

								<ol class="breadcrumb float-right">
									<li class="breadcrumb-item active"><a href="#">Home</a></li>
									<li class="breadcrumb-item  active"><a href="#">User</a></li>
									<li class="breadcrumb-item active">Manage Role</li>
								</ol>

								<div class="clearfix"></div>
							</div>
						</div>
					</div>
					<!-- end row -->

					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<p align="center" id="messageId"
										style="color: green; font-weight: bold;"></p>
									<br>
									<div class="row">

										<div class="col-md-8">
											<form class="form-horizontal" id="searchTemplateForm"
												name="searchTemplateForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label inner_md_htext">Role
														Name<span style="color: red">*</span>
													</label>
													<div class="col-5">
														<div class="col-auto">

															<div class="input-group mb-2">

																<input type="text" name="searchRoleName"
																	id="searchRoleName" class="form-control"
																	id="inlineFormInputGroup"
																	placeholder="Role Name">
															</div>
														</div>
													</div>
													<div class="col-2">
														<button id="searchBtn" type="button"
															class="btn  btn-primary"
															onclick="searchRoleList();">Search</button>
													</div>
												</div>
											</form>

										</div>




										<div class="col-md-4">
											<form>
												<div class="button-list">
													<button type="button"
														class="btn  btn-primary btn-rounded w-md waves-effect waves-light"
														onclick="showAll('ALL');">Show All</button>

												</div>
											</form>
										</div>

									</div>
									 
									<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatus" style="font-size: 15px;"
												align="left">Search Results</td>
											<td>
												<div id=resultnavigation></div>

											</td>
										</tr>
									</table>

									<table class="table table-hover table-bordered">
										<thead class="bg-success" style="color: #fff;">
											<tr>
												<th id="th2" class="inner_md_htext">Role Code</th>
												<th id="th3" class="inner_md_htext">Role Name</th>
												<th id="th4" class="inner_md_htext">Status</th>
											</tr>
										</thead>
										<tbody id="tblListOfRole">

										</tbody>
									</table>

									<div class="row">
										<div class="col-md-12">
											<form id="addRoleForm" name="addRoleForm"
												action="" method="POST">
												<div class="row">
													<div class="col-md-4">
														<div class="form-group row">
															<div class="col-sm-5">
																<label for=""
																	class=" col-form-label inner_md_htext">Role 
																	Code</label>
															</div>
															<div class="col-sm-7">
																<input type="text" name="roleCode"
																	id="roleCode" class="form-control"
																	placeholder="Role Code"
																	onkeypress="return validateText('roleCode', 7);">
															</div>
														</div>
													</div>
													<div class="col-md-4">
														<div class="form-group row">
															<div class="col-sm-3">
																<label for="service"
																	class="col-form-label inner_md_htext">Role Name</label>
															</div>
															<div class="col-sm-9">
																<input type="text" name="roleName"
																	id="roleName" class="form-control"
																	placeholder="Role Name"
																	onkeypress="return validateTextField('roleName', 30)">
															</div>
														</div>
													</div>

												</div>
											</form>
										</div>

									</div>
									<br>
									<div class="row">
										<div class="col-md-7"></div>
										<div class="col-md-5">
											<form>
												<div class="button-list">

													<button id="btnAddTemplate" type="button"
														class="btn btn-primary btn-rounded w-md waves-effect waves-light"
														onclick="addRole();">Add</button>
													<button id="updateBtn" type="button"
														class="btn btn-primary btn-rounded w-md waves-effect waves-light"
														onclick="updateRole('update');">Update</button>
													<button id="btnActive" type="button"
														class="btn btn-primary btn-rounded w-md waves-effect waves-light"
														onclick="updateRole('active');">Active</button>
													<button id="btnInActive" type="button"
														class="btn btn-primary btn-rounded w-md waves-effect waves-light"
														onclick="updateRole('inactive');">De-Active</button>
													<button type="button"
														class="btn btn-danger btn-rounded w-md waves-effect waves-light"
														onclick="Reset();">Reset</button>

												</div>
											</form>
										</div>

									</div>

									<!-- end row -->

								</div>
							</div>
							<!-- end card -->
						</div>
						<!-- end col -->
					</div>
					<!-- end row -->
					<!-- end row -->

				</div>
				<!-- container -->

			</div>
			<!-- content -->

			<footer class="footer"> Manage Role </footer>

		</div>

		<!-- ============================================================== -->
		<!-- End Right content here -->
		<!-- ============================================================== -->

	</div>
	<!-- END wrapper -->

	<!-- jQuery  -->


</body>

</html>