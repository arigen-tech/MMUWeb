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
<title>create budgetary</title>

</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
				<c:if test="${flag=='update' || flag=='save' || flag=='coApproval'}">
					<div class="internal_Htext">Budgetary Report</div>
				</c:if>
				
				<c:if test="${flag=='qApprove' || flag=='submitQutotation' }">
					<div class="internal_Htext">Budgetary Quotation Report</div>
				</c:if>
				
				<c:if test="${flag=='sanctionApprove' || flag=='submitSanction'}">
					<div class="internal_Htext">Budgetary Sanction Report</div>
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
													<c:if test="${flag=='save'}">
													<button id='printReportButton' type='button'
															class='btn btn-primary' 
															onclick='printBudgetaryReport(${budgetaryId});'>Print</button>
														<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/lpprocess/createRequirementForBudgetry">Back</a>
														</c:if>
														<c:if test="${flag=='update'}">
														<button id='printReportButton' type='button'
															class='btn btn-primary' 
															onclick='printBudgetaryReport(${budgetaryId});'>Print</button>
														<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/lpprocess/budgetaryApprovalList">Back</a>
														</c:if>
														<c:if test="${flag=='coApproval'}">
														<button id='printReportButton' type='button'
															class='btn btn-primary' 
															onclick='printBudgetaryReport(${budgetaryId});'>Print</button>
														<%-- <a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/dispencery/getIndentForApproval">Back</a> --%>
														<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/lpprocess/budgetaryApprovalListForCO">Back</a>
														</c:if>
														
														<c:if test="${flag=='qApprove'}">
														<button id='printReportButton' type='button'
															class='btn btn-primary' 
															onclick='printApproveQuotationReport(${quotationMId});'>Print</button>
														<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/lpprocess/quotationApprovalListlpc">Back</a>
														</c:if>


													<c:if test="${flag=='submitQutotation'}">
															<c:if test="${quotationMId!='-1'}">
																<button id='printReportButton' type='button' class='btn btn-primary' 
																	onclick='printQuotationReport(${quotationMId});'>Print</button>
															</c:if>
														<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/lpprocess/budgetaryApprovalListSALogistic">Back</a>
														</c:if>
														
														<c:if test="${flag=='sanctionApprove'}">
														<button id='printReportButton' type='button'
															class='btn btn-primary' 
															onclick='printSanctionReport(${storeSoMId});'>Print</button>
														<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/lpprocess/pendingListForSanctionApproval">Back</a>
														</c:if>
														<c:if test="${flag=='submitSanction'}">
														<button id='printReportButton' type='button'
															class='btn btn-primary' 
															onclick='printSanctionReport(${storeSoMId});'>Print</button>
														<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/lpprocess/pendingListForSanctionOrder">Back</a>
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
function printBudgetaryReport(budgetaryId) {
	//window.location.href="PrintToken?visitId="+visitId;
	/* document.frm.action="${pageContext.request.contextPath}/report/printBudgetaryReport?budgetary_id="+budgetaryId;
	document.frm.method="POST";
	document.frm.submit(); */
	var url="${pageContext.request.contextPath}/report/printBudgetaryReport?budgetary_id="+budgetaryId;
	openPdfModel(url);

}

function printQuotationReport(quotationMId) {
	//window.location.href="PrintToken?visitId="+visitId;
	/* document.frm.action="${pageContext.request.contextPath}/report/printQuotationReport?quotation_id="+quotationMId;
	document.frm.method="POST";
	document.frm.submit(); */ 
	var url="${pageContext.request.contextPath}/report/printQuotationReport?quotation_id="+quotationMId;
	openPdfModel(url);
	

}

function printApproveQuotationReport(quotationMId) {
	//window.location.href="PrintToken?visitId="+visitId;
	/* document.frm.action="${pageContext.request.contextPath}/report/printApproveQuotationReport?quotation_id="+quotationMId;
	document.frm.method="POST";
	document.frm.submit();  */
	var url="${pageContext.request.contextPath}/report/printApproveQuotationReport?quotation_id="+quotationMId;
	openPdfModel(url);
	

}
function printSanctionReport(soMId) {
	//window.location.href="PrintToken?visitId="+visitId;
	/* document.frm.action="${pageContext.request.contextPath}/report/printSanctionReport?sanction_id="+soMId;
	document.frm.method="POST";
	document.frm.submit();  */
	var url="${pageContext.request.contextPath}/report/printSanctionReport?sanction_id="+soMId;
	openPdfModel(url);

}
</script>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>