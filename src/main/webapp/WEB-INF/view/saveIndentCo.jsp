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
<title>create indent</title>

</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">Indent Report</div>

					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<p align="left" 
										style="color: green; font-weight: bold;">${message}</p>
									<div class="clearfix"></div>
									<br>
									<div class="row">
										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
												<form name="frm">
													<div class="button-list">
														<button id="printReportButton" type="button" class="btn btn-primary"  onclick="makeUrl(${indentMId})"> Print Indent</button>
										
													<c:if test="${flag=='save'}">
														<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/dispencery/getIndentApprovalListForCO">Back</a>
														</c:if>
														<c:if test="${flag=='update'}">
														<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/dispencery/getIndentApprovalListForCO">Back</a>
														</c:if>
														<c:if test="${flag=='approve'}">
														<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/dispencery/getIndentApprovalListForCO">Back</a> 
														<%-- <a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/approve/approveProcess">Back</a> --%>
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
function makeUrl(indentId){
	var url="${pageContext.request.contextPath}/report/printIndentReportCo?indent_id="+indentId;
	openPdfModel(url);
	
}
</script>
</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>