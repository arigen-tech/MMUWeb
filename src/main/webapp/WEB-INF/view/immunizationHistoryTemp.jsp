<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>

  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<script type="text/javascript">
					 $(document).ready(
								function() {
									getPatientImmunizationHistory('ALL','SearchStatusForMassDesignation');
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

	<form:form name="patientImmunizzationHistorySubmit" id="patientImmunizzationHistorySubmit" method="post" 
									action="${pageContext.request.contextPath}/medicalexam/submitPatientImmunizationHistory" autocomplete="on">
				
				<input type="hidden" name="visitId" id="visitId" value='${visitId}'/>
				<input type="hidden" name="patientId" id="patientId" value='${patientId}'/>
				<input type="hidden" name="userId" id="userId" value='<%=userId%>'/>
		<div class="clear" style="margin-top: 8px;"></div>

		<div class="clear"></div>
		<div class="paddingTop15"></div>
								<div style="float: left">

									<table class="tblSearchActions" align="center" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatusForMassDesignation" style="font-size: 15px;"
												align="left"></td>
										</tr>
									</table>
								</div>
								<div style="float: right">
									<div id="resultnavigationMasDesignation"></div>
				</div>
		
		<div id="testDiv">
			
			<table class="table table-striped table-hover table-bordered " align="center"
				cellpadding="0" cellspacing="0">
				<tbody style="border: 1px solid #dee2e6;" id="grid">
					 <thead class="bg-primary">
											<tr>
												<th>Immunization Name</th>
												<th>Immunization Date</th>
												<th>Duration(Years)</th>
												<th>Next Due Date</th>
												<th>Prescription Date</th>
												<th>Add</th>
												<th>Delete</th>
											</tr>
					</thead>
				<tbody id="immunizationHistoryGrid">

				</tbody>

			</table>
			<div class="Clear"></div>
		</div>


		<div class="Clear"></div>
		<div class="division"></div>
		<div style="float: right;">
			 <input type="button" id="saveImmunizationHistoryForCommon" class="btn btn-primary" onClick="return saveImmunizationHistory();" value="Save"/> 
				<%-- <input type="button" id="close" class="btn btn-danger" onClick="return closeModal();" value='<spring:message code="btnClose"/>'/> --%>		
				<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
				
		</div>

		<div class="Clear"></div>
		<div class="division"></div>
</form:form>

<script type="text/javascript">
var autoVsPvmsNo = '';
var pvmsNo = '';


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
