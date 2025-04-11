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
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>

</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
	
		<div class="content-page">
		<!-- Start content -->
		
		<div class="container-fluid">
			<div class="internal_Htext">User Manual</div> 
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-body">
							
							<div class="row">
								<div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/UserManual_ReceptionandRegistration.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"> <i class="fa fa-user-plus icbase"></i> <i class="fa fa-download ichover"></i></div>
										Reception
									</a>
								</div>
								
								<div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/UserManual_OPD.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"> <i class="fa fa-user-md icbase"></i> <i class="fa fa-download ichover"></i></div>
										OPD
									</a>
								</div>
								
								<div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/UserManual_Dispensary.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"><i class="fa fa-first-aid icbase"></i> <i class="fa fa-download ichover"></i></div>
										Dispensary
									</a>
								</div>
								
								<div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/UserManual_Laboratory.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"><i class="fa fa-flask icbase"></i> <i class="fa fa-download ichover"></i></div>
										Laboratory
									</a>
								</div>
								
								<div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/UserManual_Admin.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"><i class="fa fa-user-shield icbase"></i> <i class="fa fa-download ichover"></i></div>
										Admin
									</a>
								</div>
								
								<%-- <div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"><i class="fa fa-file-alt icbase"></i> <i class="fa fa-download ichover"></i></div>
										Audit
									</a>
								</div> --%>
								
								<div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/UserManual_MIS.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"><i class="fa fa-file-medical icbase"></i> <i class="fa fa-download ichover"></i></div>
										MIS Report
									</a>
								</div>
								
								<div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/UserManual_Dashboard.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"> <i class="fa fa-columns icbase"></i> <i class="fa fa-download ichover"></i></div>
										Dashboard
									</a>
								</div>
								
								<div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/UserManual_UserManagement.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"> <i class="fa fa-users-cog icbase"></i> <i class="fa fa-download ichover"></i></div>
										User Management
									</a>
								</div>
								
								<div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/UserManual_MasterManagement.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"> <i class="fa fa-server icbase"></i> <i class="fa fa-download ichover"></i></div>
										Master Management
									</a>
								</div>								
								
								<%-- <div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/MedicalExam_UserManual.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"><i class="fa fa-notes-medical icbase"></i> <i class="fa fa-download ichover"></i></div>
										Medical Exam
									</a>
								</div>
								
								<div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/MedicalBoard_UserManual.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"><i class="fa fa-file-medical icbase"></i> <i class="fa fa-download ichover"></i></div>
										Medical Board
									</a>
								</div>
								
								<div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/Stores_UserManual.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"><i class="fa fa-building icbase"></i> <i class="fa fa-download ichover"></i></div>
										Medical Store
									</a>
								</div>
								
								<div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/Radiology_UserManual.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"><i class="fa fa-dna icbase"></i> <i class="fa fa-download ichover"></i></div>
										Radiology
									</a>
								</div>
								
								<div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/SHO_UserManual.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"><i class="fa fa-ambulance icbase"></i> <i class="fa fa-download ichover"></i></div>
										SHO
									</a>
								</div>
								
								<div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/MIAdmin_UserManual.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"><i class="fa fa-door-open icbase"></i> <i class="fa fa-download ichover"></i></div>
										MI Admin Room
									</a>
								</div>
								
								<div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/FWC_UserManual.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"><i class="fa fa-users icbase"></i> <i class="fa fa-download ichover"></i></div>
										FWC
									</a>
								</div>
								
								<div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/UserManagement_UserManual.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"> <i class="fa fa-user-cog icbase"></i> <i class="fa fa-download ichover"></i></div>
										User Management
									</a>
								</div>							
								
								
								<div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/Ward_UserManual.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"><i class="fa fa-bed icbase"></i> <i class="fa fa-download ichover"></i></div>
										Ward Management
									</a>
								</div>
								
								<div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/Utility_UserManual.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"><i class="fa fa-wrench icbase"></i> <i class="fa fa-download ichover"></i></div>
										Utility
									</a>
								</div>
								
								<div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/SystemAdmin.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"> <i class="fa fa-book icbase"></i> <i class="fa fa-download ichover"></i></div>
										System Administration
									</a>
								</div> --%>
								
								
								
								<%-- <div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/Patientwebportal.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"> <i class="fa fa-book icbase"></i> <i class="fa fa-download ichover"></i></div>
										Patient Appointment Web Portal
									</a>
								</div>
								
								<div class="col-md-3">
									<a href="${pageContext.request.contextPath}/resources/userManual/Patientmobileapp.pdf" target="_blank" class="helpBox" title="Download User Manual">
										<div class="helpBoxIcon"> <i class="fa fa-book icbase"></i> <i class="fa fa-download ichover"></i></div>
										Patient Appointment Mobile Portal
									</a>
								</div> --%>
								
								
							
							</div>
						
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- container -->
		</div>
			<!-- content -->

	</div>

		<!-- ============================================================== -->
		<!-- End Right content here -->
		<!-- ============================================================== -->

	

</body>

</html>