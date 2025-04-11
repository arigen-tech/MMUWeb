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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/medicalexam.js"></script>
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
			var data = {"pageNo":nPageNo, "serviceNo":"",'employeeId' : <%=userId%>,'userId' : <%=userId%>,  'hospitalId':""+<%=hospitalId%>,'flagForList':'c'};			
		}
	 
	 else if(MODE == 'FILTER'){
		 
			var data =  {"pageNo":nPageNo, "serviceNo":searchService,"employeeId":<%=userId%>,'userId' : <%=userId%>,  "hospitalId":""+<%=hospitalId%>,'flagForList':'c'};
		}
	 else if(searchService!=""){
			nPageNo = 1;
			var data =  {"pageNo":nPageNo, "serviceNo":searchService,"employeeId":<%=userId%>,'userId' : <%=userId%>,  "hospitalId":""+<%=hospitalId%>,'flagForList':'c'};
		}
	else
		{
			var data =  {"pageNo":nPageNo, "serviceNo":searchService,"employeeId":<%=userId%>,'userId' : <%=userId%>,  "hospitalId":""+<%=hospitalId%>,'flagForList':'c'}; 
		} 
	//var url = "getMEApprovalWaitingGrid";
	var url = "getMEWaitingGrid";	
	var bClickable = true;
	GetJsonData('tblListOfCommand',data,url,bClickable);
}
function makeTable(jsonData)
{	 
	var htmlTable = "";	
	var data = jsonData.count;
	var pageSize = 5;

	
	var dataList = jsonData.data;
	
	if(dataList!=null && dataList.length >= 0)
	for(i=0;i<dataList.length;i++)
		{		
		
			htmlTable = htmlTable+"<tr id='"+dataList[i].visitId+"' >";	
		 
			htmlTable = htmlTable +"<td style='display:none;'>"+dataList[i].patientId+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].tokenNo+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].serviceNo+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].patientName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].rankName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].meAgeNew+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].gender+"</td>";			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].meTypeName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].status+"</td>";
			htmlTable = htmlTable+"</tr>";
		}
	if(dataList==null || dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='9'><h6>No Record Found</h6></td></tr>";
		}			
	//$('#ssnValue').val(count);
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
var meTypeCode;
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
			meTypeCode = data.data[j].meTypeCode;
		}
	}
	rowClick(visitId,patientId,patinetname,age,gender,rankName,meTypeName,status,departmentId,meTypeCode);
}

function rowClick(visitId,patientId,patinetname,age,gender,rankName,meTypeName,status,departmentId,meTypeCode){
		$("#visitId").val(visitId);
		$("#departmentId").val(departmentId);
		$("#patientId").val(patientId);
		var countCheckBox=0;
	 	 
		if(meTypeCode!=null && meTypeCode!="" && meTypeCode.trim() === resourceJSON.meForm18){
			 window.location.href = "validateMAWaitingDetailMOAFMSF18?visitId="+visitId+"&age="+age+"&approvalFlag=n"+"&userId="+<%=userId%>+"&patientId="+patientId;	
		}
		else if(meTypeCode!=null && meTypeCode!="" && meTypeCode.trim() == resourceJSON.meForm3A){
			window.location.href = "validateMAWaitingDetailMOAFMS3A?visitId="+visitId+"&age="+age+"&approvalFlag=n"+"&userId="+<%=userId%>+"&patientId="+patientId;
		}
		else{
			window.location.href = "validateMAWaitingDetailMO?visitId="+visitId+"&age="+age+"&approvalFlag=n"+"&userId="+<%=userId%>+"&patientId="+patientId;	
		}
		
}


function searchValidateList()
{
		

	var searchService = $j('#serviceNo').val();
	 
	 if((searchService == undefined || searchService == '')){	
			alert("Please enter  Service No.");
			return;
		}	
	 getCommandList('Search');
	//ResetForm();
} 
function ShowAllList(pageNo)
{	 
	 nPageNo=pageNo;
	 resetForm();
	 getCommandList('ALL');
}

function resetForm()
{	
	 $j('#serviceNo').val('');
}
function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	getCommandList('FILTER');
	
}

</script>

</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">


		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">Medical Exam Waiting List (MO)</div>
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
														<input type="text"  name="serviceNo" id="serviceNo" class="form-control"/>
													</div>
												</div>
											</div>
											
										<div class="col-md-1">
											 <button type="button" class="btn btn-primary" onclick=" return searchValidateList()">Search</button>
										</div>
										<div class="col-md-3 offset-md-4 text-right">
											
											<button type="button" class="btn btn-primary" onclick="ShowAllList('1')">Show All</button>
												
										</div>
										</div>
									 
									<div style="float: right">
										<div id="resultnavigation"></div>
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
								
								<div class="clearfix"></div>
									
									<table class="table table-hover table-striped table-bordered m-t-10">
										<thead class="bg-primary">
											<tr>
												<th>Token No.</th>
												<th>Service No.</th>
												<th>Emp Name</th>
												<th>Rank</th>
												<th>Age</th>
												<th>Gender</th>
												<th>Medical Exam</th>
												<th>Status</th>
											</tr>
										</thead>
										<tbody id="tblListOfCommand">
										</tbody>
									</table>
									
										
								
									
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