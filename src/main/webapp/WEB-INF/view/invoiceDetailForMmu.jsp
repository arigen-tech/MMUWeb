<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>

  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<script type="text/javascript">

var nPageNo=1;
var $j = jQuery.noConflict();

					 $(document).ready(
								function() {
									getInvoiceAllDetail('ALL','SearchStatusForInvoiceMMU');
					});	 
					</script>
</head>
<body style="background: #ffff;">

	<%
	String hospitalId = "1";
	if (session.getAttribute("hospital_id") != null) {
		hospitalId = session.getAttribute("hospital_id") + "";
	}
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	
%>

<div class="Clear"></div>
<script type="text/javascript" language="javascript">

function submitWindow()
{
var code=document.getElementById('code').value;
var flag =true;
if(validateMetaCharacters(code)){

}

}

function closeWindow()
{
  window.close();
}
 
</script>

	<form:form name="invoiceDetailHistory" id="invoiceDetailHistory" method="post" 
									action="${pageContext.request.contextPath}/dashboard/submitPatientImmunizationHistory" autocomplete="on">
				
				<input type="hidden" name="mmuId" id="mmuId" value='${mmuId}'/>
				<input type="hidden" name="fromDate" id="fromDate" value='${fromDate}'/>
				<input type="hidden" name="toDate" id="toDate" value='${toDate}'/>
				<input type="hidden" name="userId" id="userId" value='<%=userId%>'/>
		<div class="clear" style="margin-top: 8px;"></div>

		<div class="clear"></div>
		<div class="paddingTop15"></div>
							<div style="float: left">

									<table class="tblSearchActions" align="center" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatusForInvoiceMMU" style="font-size: 15px;"
												align="left"></td>
										</tr>
									</table>
								</div>
								<div style="float: right">
									<div id="resultnavigation"></div>
				</div>
 		
		<div id="testDiv">
			
			<table class="table table-striped table-hover table-bordered " align="center"
				cellpadding="0" cellspacing="0">
				<tbody style="border: 1px solid #dee2e6;" id="grid">
					 <thead class="bg-primary">
											<tr>
												<th>S.No</th>
												<th>Indent Date</th>
												<th>Medicine Name</th>
												<th>Requested Qty</th>
								               	<th>Received Qty</th>
												<th>Total Cost</th> 
											</tr>
					</thead>
				<tbody id="invoiceMMUHistoryGrid">

				</tbody>

			</table>
			<div class="Clear"></div>
		</div>


		<div class="Clear"></div>
		<div class="division"></div>
	 
		<div class="Clear"></div>
		<div class="division"></div>
</form:form>

<script type="text/javascript">
 
$(document).on('click','#exampleModal button[data-dismiss="modal"]',function(){
 	closeModal();
 });

 function closeModal(){
 	 $('#exampleModal').hide();
 	 $('.modal-backdrop').hide();
 	 $('#exampleModal .modal-body').empty();
 }
   
</script>
</body>
</html>
