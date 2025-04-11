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
<%@page import="org.json.JSONObject"%>
</head>

<%

String rspData = "";
JSONObject responseData = null;
	if (request.getAttribute("jsonResponse") != null) {
		rspData = (String) request.getAttribute("jsonResponse");
		responseData = new JSONObject(rspData);
	}

	String poMStatus = "";
	if (responseData != null) {
		poMStatus = responseData.getString("poMStatus");
	}
	
String statusFlag = "";
if(request.getParameter("flag") !=null){
	statusFlag=request.getParameter("flag");
}
%>

<script >

$j(document).ready(function() {
	var data = ${jsonResponse};
	var poMData = data.storePoMData;
	for(count in poMData){
	$j('#poMId').val(poMData[count].poMId);
	$j('#balanceHeaderId').val(poMData[count].poMId);
	$j('#sanctionNo').val(poMData[count].sanctionNo);
	$j('#rfpNo').val(poMData[count].rfpNo);
	$j('#supplyOrderNo').val(poMData[count].supplyOrderNo);
	$j('#year').val(poMData[count].year);
	$j('#soDate').val(poMData[count].soDate);
	$j('#deliveryDate').val(poMData[count].deliveryDate);
	$j('#quotationNo').val(poMData[count].quotationNo);
	$j('#vendorName').val(poMData[count].vendorName);
	$j('#stockistId').val(poMData[count].stockist);
	$j('#taxDetails').val(poMData[count].taxDetails);
	$j('#deliverySchedule').val(poMData[count].deliverySchedule);
	$j('#paymentTerm').val(poMData[count].paymentTerm);

}
	var htmlTable = "";
	var poTData = data.storePoTData;
	for(count in poTData){
		counter = parseInt(count)+1;
		htmlTable = htmlTable + "<tr id='" + poTData[count].poTId + "'>";
    	htmlTable = htmlTable + "<td>"+counter+" </td>";
    	htmlTable = htmlTable + "<td style='display:none'><input type='hidden' name='poTId' value='"+poTData[count].poTId +"'/></td>";
    	htmlTable = htmlTable + "<td >"+poTData[count].pvmsNumber +"</td>";
    	htmlTable = htmlTable + "<td >"+poTData[count].nomenclature +"</td>";
    	htmlTable = htmlTable + "<td >"+poTData[count].au +"</td>";
    	htmlTable = htmlTable + "<td >"+poTData[count].qtyRequired +"</td>";
    	htmlTable = htmlTable + "<td >"+poTData[count].unitRate +"</td>";
    	htmlTable = htmlTable + "<td >"+poTData[count].amtValue +"</td>";
    	htmlTable = htmlTable + "<td style='display:none'><input type='hidden' name='itemId' value='"+poTData[count].itemId +"'/></td>";
	}
	$j("#supplyOrderApproval").html(htmlTable);
	
});


function submitSupplyOrderForApproval(type){
	var value=validateFields("formSupplyOrder");
	if(value==true){
		$j('#requestType').val(type);
		document.formSupplyOrder.action="saveOrSubmitSODetailForApproval";
		document.formSupplyOrder.method="POST";
		document.formSupplyOrder.submit(); 
	}else{
		alert(value.split('\n')[0]);
	}
}

function GoToBackPage(){
	window.location="${pageContext.request.contextPath}/store/showSupplyOrderList";
}

function printReport(){
	var id= $('#balanceHeaderId').val();
	var url="${pageContext.request.contextPath}/report/printSupplyOrderReport?balanceHeaderId="+id;
	openPdfModel(url);
	
	/* document.formSupplyOrder.action="${pageContext.request.contextPath}/report/printSupplyOrderReport";
	document.formSupplyOrder.method="POST";
	document.formSupplyOrder.submit();   */
}
</script>


<body>
	<!-- Begin page -->
	<div id="wrapper">

		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
						<%if(poMStatus.equalsIgnoreCase("e")){%>
								<div class="internal_Htext">View/update Supply Order</div>
						<%}else{ %>
								<div class="internal_Htext">Supply Order Approval</div>
						<%} %>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<form id="formSupplyOrder" name="formSupplyOrder">
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Sanction No.</label>
												</div>
												<div class="col-md-7">
													<input readonly type="text" class="form-control" id="sanctionNo" name="sanctionNo"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">RFP No.</label>
												</div>
												<div class="col-md-7">
													<input readonly type="text" class="form-control" id="rfpNo" name="rfpNo"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">SO No.</label>
												</div>
												<div class="col-md-7">
													<input readonly type="text" class="form-control" id="supplyOrderNo" name="supplyOrderNo"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Year</label>
												</div>
												<div class="col-md-7">
													<input readonly type="text" class="form-control"  id="year" name="year"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">SO Date*</label>
												</div>
												<div class="col-md-7">
													<input readonly type="text" class="form-control" id="soDate" name="soDate"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Delivery Date*</label>
												</div>
												<div class="col-md-7">
													<input readonly type="text" class="form-control" id="deliveryDate" name="deliveryDate"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Quotation No.</label>
												</div>
												<div class="col-md-7">
													<input readonly type="text" class="form-control" id="quotationNo" name="quotationNo"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Vendor Name</label>
												</div>
												<div class="col-md-7">
													<input readonly type="text" class="form-control" id="vendorName" name="vendorName"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Stockist Distributor</label>
												</div>
												<div class="col-md-7">
													<input readonly type="text" class="form-control" id="stockistId" name="stockistId"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Tax Details<span class="text-red">*</span></label>
												</div>
												<div class="col-md-7">
													<textarea  class="form-control" rows="2" id="taxDetails" name="taxDetails" validate="Tax Details,string,yes"></textarea>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Delivery Schedule<span class="text-red">*</span></label>
												</div>
												<div class="col-md-7">
													<textarea  class="form-control" rows="2" id="deliverySchedule" name="deliverySchedule" validate="Delivery Schedule,string,yes"></textarea>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Payment Terms<span class="text-red">*</span></label>
												</div>
												<div class="col-md-7">
													<textarea  class="form-control" rows="2" id="paymentTerm" name="paymentTerm" validate="Payment Term,string,yes"></textarea>
												</div>
											</div>
										</div>
										
										
									
									</div>
									
									<table class="table table-hover table-striped table-bordered m-t-10">
										<thead class="bg-primary">
											<tr>
												<th>S.No.</th>
												<th>PVMS No/NIV No</th>
												<th>Nomenclature</th>
												<th>A/U</th>
												<th>Qty Required</th>
												<th>Unit Rate</th>
												<th>Value</th>
											</tr>
										</thead>
										<tbody id="supplyOrderApproval">
										</tbody>
									</table>
									
									<div class="p-10">
									<%if(statusFlag.equalsIgnoreCase("A")){%>
									<div id="actionDiv">
											<div class="row">
												<div class="col-md-4">
													<div class="form-group row" >
														<div class="col-md-5">
															<label for="service" class="col-form-label">Action<span class="text-red">*</span></label>
														</div>
														<div class="col-md-7" >
															<select class="form-control" id="actionId" name="actionId"  validate="Action,string,yes">
																<option value="0" selected="selected">Select</option>
																<option value="A">Approved</option>
																<option value="R">Rejected</option>
															</select>
														</div>
													</div>
												</div>
												<div class="col-md-6">
													<div class="form-group row">
														<div class="col-md-3">
															<label for="service" class="col-form-label">Remarks <span class="text-red">*</span></label>
														</div>
														<div class="col-md-8 m-l-10">
															<textarea class="form-control" rows="2" id="remarkId" name="remarkId" validate="Remarks,string,yes"></textarea>
														</div>
													</div>
												</div>
												</div>
											</div>
												<div class="row">
											<div class="col-md-12 text-right">
												<span id="submitDiv">
													<input type="button" class="btn btn-primary" id="btnSubmit"
													value="Submit" onclick="submitSupplyOrderForApproval('s')" />
												</span>
											</div>
											
										</div>
									<%}else{ if(poMStatus.equalsIgnoreCase("e")){%>
									<div class="row">
											<div class="col-md-12 text-right">
												<span  id="saveDiv">
												<input type="button" class="btn btn-primary" id="btnSubmit"
													value="Save" onclick="submitSupplyOrderForApproval('e')" />
												</span>
												<span id="submitDiv">
													<input type="button" class="btn btn-primary" id="btnSubmit"
													value="Submit" onclick="submitSupplyOrderForApproval('s')" />
												</span>
											</div>
										</div>
											
										
									<%}else{ %>
									<div class="row">
											<div class="col-md-12 text-right">
											<span id="backDiv">
											<%if(poMStatus.equalsIgnoreCase("a")){ %>
											<input type="button" class="btn btn-primary" id="btnBack" 
													value="Print" onclick="printReport()" />
											<%} %>		
											<input type="button" class="btn btn-primary" id="btnBack"
													value="Back" onclick="GoToBackPage()" />
											
											</span>
											</div>
										</div>
									<%}}%>
									<div class="col-md-4">
										<input type="hidden" class="form-control" id="userId"
											   name="userId"  value="<%=session.getAttribute("user_id")%>">
										<input type="hidden" class="form-control" id="hospitalId"
											   name="hospitalId"  value="<%=session.getAttribute("hospital_id")%>">
										<input  type="hidden" class="form-control" id="requestType" name="requestType" value=""/>	   
										<input  type="hidden" class="form-control" id=poMId name="poMId" value=""/>	 
										<input type="hidden" id="balanceHeaderId" name="balanceHeaderId" value="">  
							      	</div>
										</div>
									</form>
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

	
	<!-- END wrapper -->
</body>
</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>