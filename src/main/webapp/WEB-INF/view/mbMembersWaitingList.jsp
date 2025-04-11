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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/medicalBoard.js"></script>

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
<script type="text/javascript" language="javascript">
var nPageNo=1;
var Status;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{	
			getCommandList('ALL');
		});
		
function getCommandList(MODE)
{
	
	var searchService = $j('#serviceNo').val();
		 
	 if(MODE == 'ALL'){
			var data = {"pageNo":nPageNo,'employeeId' : <%=userId%>, 'hospitalId':""+<%=hospitalId%>,'flagForList':'a'};			
		}
	else
		{
			var data =  {"pageNo":nPageNo, "serviceNo":searchService,"patientName":searchPatient,"employeeId":<%=userId%>, "hospitalId":""+<%=hospitalId%>,'flagForList':'a'}; 
		} 
	var url = "getMBPreAssesWaitingList";
		
	var bClickable = true;
	GetJsonData('tblListOfCommand',data,url,bClickable);
}
function makeTable(jsonData)
{	 
	var htmlTable = "";	
	var data = jsonData.count;
	
	
	var pageSize = 5;

	
	var dataList = jsonData.data;
	var count;
	var ssnCountValue=$('#ssnValue').val();
	if(ssnCountValue=="" || ssnCountValue==null){
		count=1;
	}
	else{
		count=ssnCountValue;
	}
	
	if(dataList!=null && dataList.length >= 0)
	for(i=0;i<dataList.length;i++)
		{		
		
			htmlTable = htmlTable+"<tr id='"+dataList[i].visitId+"' >";	
		 
			htmlTable = htmlTable +"<td style='display:none;'>"+dataList[i].patientId+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+count+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].patientName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].age+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].gender+"</td>";			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].rankName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].meTypeName+"</td>";
			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].status+"</td>";
			
			htmlTable = htmlTable +"<td style='width: 100px;'>High</td>";
			
			/* htmlTable = htmlTable + '<td><input type="checkBox"  name="validateCheckbox" id="validateCheckbox'+i+'" value="1"';
			htmlTable = htmlTable + 'tabindex="1"></td>'; */
			
			htmlTable = htmlTable+"</tr>";
			count++;
		}
	if(dataList==null || dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='9'><h6>No Record Found</h6></td></tr>";
		}			
	$('#ssnValue').val(count);
	$j("#tblListOfCommand").html(htmlTable);	
}
var visitId;
var patientId;
var patinetname;
var status;
var rankName;
var age;
var gender;
var meTypeName;
var departmentId;
function executeClickEvent(visitId,data)
{
	 
	for(j=0;j<data.data.length;j++){
		if(visitId == data.data[j].visitId){
			
			visitId = data.data[j].visitId;
			
			patientId = data.data[j].patientId;
			patinetname = data.data[j].patinetname;
			age = data.data[j].age;
			gender = data.data[j].gender;
			rankName = data.data[j].rankName;
			meTypeName = data.data[j].meTypeName;
			status = data.data[j].status;
			departmentId = data.data[j].departmentId;
		}
	}
	rowClick(visitId,patientId,patinetname,age,gender,rankName,meTypeName,status,departmentId);
}



function rowClick(visitId,patientId,patinetname,age,gender,rankName,meTypeName,status,departmentId){
		$("#visitId").val(visitId);
		$("#departmentId").val(departmentId);
		$("#patientId").val(patientId);
		var countCheckBox=0;
		
	/* 	$('#tblListOfCommand tr').each(function(i, el) {
			var id = $(this).find("td:eq(9)").find("input:eq(0)").attr("id")
			if (document.getElementById(id).checked == true) {
				countCheckBox+=1;
			}
		});
		 
	 if(countCheckBox>='2'){
		 alert("Please checked only one to validate the patient.");
		 $('#countcheckBoxValue').val(countCheckBox);
		 return false;
	 }
	 
	if(countCheckBox=='1'){
		return true;
	}
	else{
 */	 window.location.href = "mbMembersAFMSForm?visitId="+visitId+"&age="+age;
	//}
}

</script>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">

		<input type="hidden" id="ssnValue" name="ssnValue" value=""/>
		<div class="content-page">
			<!-- Start content -->
			<div class="">
		
				<div class="container-fluid">
					<div class="internal_Htext">Medical Board Members Waiting List</div>
					 <form:form name="submitMedicalExamByMo" id="submitMedicalExamByMo" method="post"
									action="${pageContext.request.contextPath}/medicalexam/submitMedicalExamByMo" autocomplete="off">
							  <input type="hidden" value="1" name="checkForForm" id="checkForForm"/>
							  <input type="hidden" name="visitId" id="visitId" value="${visitId}"/>
							<input type="hidden" name="patientId" id="patientId" value=""/>
							<input type="hidden" name="hospitalId" id="hospitalId" value="<%=hospitalId%>"/>
							<input type="hidden" name="userId" id="userId" value="<%=userId%>"/>	
							<input type="hidden" name="departmentId" id="departmentId" value=""/>
							<input type="hidden" name="countcheckBoxValue" id="countcheckBoxValue" value=""/>	
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
										<div class="row">
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Service No.</label>
													</div>
													<div class="col-md-7">
														<input type="text" class="form-control"/>
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-12">
														<button class="btn btn-primary">Search</button>
													</div>
												</div>
											</div>
											

										</div>
										
								<div style="float: left">

									<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatus" style="font-size: 15px;"
												align="left">Search Results</td>
											<td>
												<!-- <div id=resultnavigation></div> -->
											</td>
										</tr>
									</table>
								</div>		
										
								<div style="float: right">
									<div id="resultnavigation"></div>
								</div>
								
								<div class="clearfix"></div>
									
									
									<table class="table table-hover table-striped table-bordered m-t-10">
										<thead class="bg-primary">
											<tr>
												<th>S.No.</th>
												<th>Name</th>
												<th>Age</th>
												<th>Gender</th>
												<th>Rank</th>
												<th>MB Type</th>
												<th>Status</th>
												<th>Priority</th>
											<!-- 	<th>Validation</th> -->
												
											</tr>
										</thead>
										<tbody id="tblListOfCommand">
										
										</tbody>
									</table>
									
										<!-- <div class="row m-t-10">
											<div class="col-md-12 text-right">
												<button type="submit" class="btn btn-primary" onclick="return submitFormByMO('1');">Validate</button>
											</div>
										</div> -->
								
									
									</div>

								</div>
							</div>
						</div>
						</form:form>
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