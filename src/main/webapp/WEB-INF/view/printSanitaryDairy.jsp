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
<title>ASHA APPLICATION</title>

</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
				<c:if test="${flag=='sanitary' }">
					<div class="internal_Htext">Sanitary Diary</div>
				</c:if>
				<c:if test="${flag=='injury'}">
					<div class="internal_Htext">Injury Report Register</div>
				</c:if>
				
				<c:if test="${flag=='hospitalRegister'}">
					<div class="internal_Htext">Hospital Visit Register</div>
				</c:if>
				<c:if test="${flag=='hivRegister'}">
					<div class="internal_Htext">Hiv/Std Register</div>
				</c:if>
				<c:if test="${flag=='milkTesting'}">
					<div class="internal_Htext">Milk Testing For free chlorine</div>
				</c:if>
				<c:if test="${flag=='waterTesting'}">
					<div class="internal_Htext">Water Testing For free chlorine</div>
				</c:if>
				
				<c:if test="${flag=='bloodGroupRegister'}">
					<div class="internal_Htext">Blood Group Entry Register</div>
				</c:if>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<p class="submitMsg">${message}</p>
									<div class="clearfix"></div>
									<br>
									<div class="row">
										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
												<form name="frm">
													<div class="button-list">
													
													<c:if test="${flag=='sanitary'}">
														<a class="btn btn-primary" role="button"
														 href="${pageContext.request.contextPath}/miAdmin/sanitoryDiaryReport">Back</a>
														</c:if>
														<c:if test="${flag=='injury'}">
														<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/miAdmin/injuryRegisterReport">Back</a>
														</c:if>
														<c:if test="${flag=='hospitalRegister'}">
														<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/miAdmin/hospitalVisitReport">Back</a>
														</c:if>
														<c:if test="${flag=='hivRegister'}">
														<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/miAdmin/hivStdReport">Back</a>
														</c:if>
														<c:if test="${flag=='milkTesting'}">
														<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/miAdmin/milkTestingReport">Back</a>
														</c:if>
														<c:if test="${flag=='waterTesting'}">
														<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/miAdmin/waterTestingReport">Back</a>
														</c:if>
														<c:if test="${flag=='bloodGroupRegister'}">
														<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/miAdmin/bloodGroupReport">Back</a>
														</c:if>
				
													</div>
												</form>
											</div>
										</div>
									</div>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
function printSanitaryReport(sanitaryId) {
	//window.location.href="PrintToken?visitId="+visitId;
	document.frm.action="${pageContext.request.contextPath}/report/printBudgetaryReport?budgetary_id="+budgetaryId;
	document.frm.method="POST";
	document.frm.submit(); 

}

</script>

</html>