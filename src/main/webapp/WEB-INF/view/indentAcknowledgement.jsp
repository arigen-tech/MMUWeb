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

<%
long mmuId = 0;
if (session.getAttribute("mmuId") != null) {
	mmuId = Long.parseLong(session.getAttribute("mmuId").toString());
}

String storeIssueMId = request.getParameter("storeIssueMId").toString();
%>

<body>
	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">Indent Acknowledgement</div>
					<form id="indentAcknowledgement" name="indentAcknowledgement">
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
										<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Indent No.</label>
													</div>
													<div class="col-md-7">
														<input readonly type="text" class="form-control" id="indentNo" name="indentNo"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Indent Date</label>
													</div>
													<div class="col-md-7">
														<div class="dateHolder">
															<input readonly type="text" class="calDate datePickerInput form-control minwidth120"
															name="indentDate" id="indentDate" placeholder="DD/MM/YYYY" value="" maxlength="10" />
														</div>
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Issue Date</label>
													</div>
													<div class="col-md-7">
														<input readonly type="text" class="form-control" id="issueDate" name="issueDate"/>
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Issue No</label>
													</div>
													<div class="col-md-7">
														<input readonly  type="text" class="form-control" id="issueNo" name="issueNo"/>
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Receiving Date</label>
													</div>
													<div class="col-md-7">
														<input readonly type="text" class="form-control" id="currentDate" name="currentDate"/>
													</div>
												</div>
											</div>
										</div>
										<div class="table-responsive">
									<table class="table table-hover table-striped table-bordered m-t-10">
										<thead class="bg-primary">
											<tr>
												<th>S.No.</th>
												<th>Drug Code</th>
												<th>Drug Name</th>
												<th>A/U</th>
												<th>Batch No.</th>
												<th>DOM</th>
												<th>DOE</th>
												<th>Qty Demanded</th>
												<th>Qty Issued</th>
												<th>Qty Recieved</th>
												<th>Previous Recieved Qty</th>
											</tr>
										</thead>
										<tbody id="receivingIndentIssuedList">
										</tbody>
									</table>
									</div>
										<div class="row">
											<div class="col-md-12 text-right">
												<input type="button" id="addToStockId" name="addToStockId" class="btn btn-primary" value="Add To Stock" onclick="addToStock()"/>
												<input type="button" class="btn btn-primary" value="Back" onclick="GoToBackPage()"/>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<input   type="hidden" class="form-control" id="indentMId" name="indentMId"/>
						<input   type="hidden" class="form-control" id="mmuId" name="mmuId" value="<%= mmuId %>"/>
						<input   type="hidden" class="form-control" id="storeIssueMId" name="storeIssueMId" value="<%= storeIssueMId %>"/>
						<input   type="hidden" class="form-control" id="userId" name="userId" value="<%=session.getAttribute("user_id")%>"/>
				</form>
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
	
	
	
<script>

$j(document).ready(function() {
	$('#addToStockId').attr('disabled', false);
	var jsonResponse = ${jsonResponse};
	var internalIndentM = jsonResponse.storeInternalIndentMData;
	
	for(countM=0;countM<internalIndentM.length;countM++){
		$('#indentMId').val(internalIndentM[countM].indentMId);
		$('#indentNo').val(internalIndentM[countM].indentNo);
		$('#indentDate').val(internalIndentM[countM].indentDate);
		//$('#department').val(internalIndentM[countM].toDepartmentName);
		$('#approvedBy').val(internalIndentM[countM].approvedByName);
		$('#issueNo').val(internalIndentM[countM].issueNo);
		$('#issueDate').val(internalIndentM[countM].issueDate);
		$('#currentDate').val(currentDateInddmmyyyy());
	}
	
	var htmlTable = "";
	var storeIssueT = jsonResponse.storeInternalIndentTData;
	  for(countT=0; countT<storeIssueT.length;countT++){
		  
		  var count = parseInt(countT);
	    	count = count+1;
	    	
	    	htmlTable = htmlTable + "<tr id='" + storeIssueT[countT].Id + "'>";
	    	htmlTable = htmlTable + "<td style='width: 50px;'>" + count + "</td>";
	    	htmlTable = htmlTable + "<td style='display:none'><input type='hidden' name='itemId' value='"+storeIssueT[countT].itemId +"'/></td>";
	    	htmlTable = htmlTable + "<td style='display:none'><input type='hidden' name='issueTId' value='"+storeIssueT[countT].issueTId +"'/></td>";
	    	htmlTable = htmlTable + "<td style='display:none'><input type='hidden' name='indentTId' value='"+storeIssueT[countT].indentTId +"'/></td>";
	    	htmlTable = htmlTable + "<td style='display:none'><input type='hidden' name='stockId' value='"+storeIssueT[countT].stockId +"'/></td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'><input readonly type='text' class='form-control width100' name='pvmsNumber' value='"+storeIssueT[countT].pvsmNo +"'/></td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'><input readonly type='text' class='form-control width250' name='nomenclature' value='"+storeIssueT[countT].nomenclature +"'/></td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'><input readonly type='text' class='form-control width80' name='unitId' value='"+storeIssueT[countT].au +"'/></td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'><input readonly type='text' class='form-control width80' name='batchNumber' value='"+storeIssueT[countT].batchNo +"'/></td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'><input readonly type='text' class='form-control width90' name='dom' value='"+storeIssueT[countT].dom +"'/></td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'><input readonly type='text' class='form-control width90' name='doe' value='"+storeIssueT[countT].doe +"'/></td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'><input readonly type='text' class='form-control width80' name='qtyDemand' value='"+storeIssueT[countT].qtyDemand +"'/></td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'><input readonly type='text' class='form-control width80' id='qtyIssued"+countT+"' name='qtyIssued' value='"+storeIssueT[countT].qtyIssued +"'/></td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'><input          type='text' class='form-control width80' id='qtyReceived"+countT+"' name='qtyReceived' value='"+storeIssueT[countT].qtyReceived +"' onblur='checkQty("+countT+")' validate=Receive Qty,number,yes'/></td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'><input readonly type='text' class='form-control width80' id='QtyPreReceived"+countT+"' name='QtyPreReceived' value='"+storeIssueT[countT].previousReceivedQty +"'/></td>"
	    }
	  $j("#receivingIndentIssuedList").html(htmlTable);
	
});

function addToStock(){
	
 	console.log("clicked");
	var value=validateFields("indentAcknowledgement");
    var flageForRec=0; 
	 
		
	$('#receivingIndentIssuedList tr').each(function(i, el) {
    			   var tds = $(this).find('td')
 			      
    			  var issueValue=$(tds).closest('tr').find("td:eq(12)").find("input:eq(0)").val(); 
    			var receivedValue=$(tds).closest('tr').find("td:eq(13)").find("input:eq(0)").val(); 
 
	 
	if(receivedValue > issueValue){
		flageForRec=1;	
		value=false;
		return false;
	}	 
	
	});
	if(flageForRec==1){
		value=false;		
		alert("Qty received should not be greater than Qty issued.");
		return false;
	}
	
	if(value==true){
		 $('#addToStockId').attr('disabled', true);
		document.indentAcknowledgement.action="addToStockIssuedIndent";
	    document.indentAcknowledgement.method="POST";
	    document.indentAcknowledgement.submit();
	}else{
		alert(value.split('\n')[0]);
		$('#addToStockId').attr('disabled', false);
	}
}

function GoToBackPage(){
	window.location="${pageContext.request.contextPath}/store/showReceiveIndentWatingList";
}

function checkQty(count){
	 var issuedQty=0;
	 var recQty =0;
	 if($('#qtyIssued'+count).val()!==""){
		 issuedQty = $('#qtyIssued'+count).val();
	 }
	 if($('#qtyReceived1'+count).val()!==""){
		 recQty = $('#qtyReceived1'+count).val();
	 }
	 var diff = parseInt(recQty)-parseInt(issuedQty);
	 if(diff>0){
		 alert("Receive Qty can not be greater then issued Qty.")
		 $('#qtyReceived1'+count).val("");
	 }
}


</script>
	
</body>
</html>

