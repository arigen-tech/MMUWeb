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

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/approvalprocess.js"></script>

  <%
	String hospitalId = "1";
	if (session.getAttribute("hospital_id") != null) {
		hospitalId = session.getAttribute("hospital_id") + "";
	}
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	String desiName="";
	if (session.getAttribute("designationName") != null) {
		desiName = session.getAttribute("designationName") + "";
	}
%>
<script type="text/javascript" language="javascript">
var $j = jQuery.noConflict();

$j(document).ready(function()
		{	
	getApprovalProcessForCommon('ALL','SearchStatus');
		});
		


<%-- var nPageNo=1;
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
			var data = {"pageNo":nPageNo,"serviceNo":"",'employeeId' : <%=userId%>, 'hospitalId':""+<%=hospitalId%>,'flagForList':'e'};			
		}
	else
		{
			var data =  {"pageNo":nPageNo, "serviceNo":searchService,"employeeId":<%=userId%>, "hospitalId":""+<%=hospitalId%>,'flagForList':'e'}; 
		} 
	var url = "getMEApprovalWaitingGrid";
		
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
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].serviceNo+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].patientName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].rankName+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].age+"</td>";			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].gender+"</td>";
			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].mediceExamDate+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].medicalCategory+"</td>";			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].meTypeName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].approvedBy+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].status+"</td>";
			
			htmlTable = htmlTable+"</tr>";
			count++;
		}
	if(dataList==null || dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='10'><h6>No Record Found</h6></td></tr>";
		}			
	$('#ssnValue').val(count);
	$j("#tblListOfCommand").html(htmlTable);	
}

 --%>
var visitId;
var patientId;
var patinetname;
var status;
var rankName;
var age;
var gender;
var meTypeName;
var departmentId;
var serviceNo;
var mediceExamDate;
var medicalCategory;
var approvedBy;
var meTypeCode;
function executeClickEventCommon(visitId,data)
{
	for(j=0;j<data.data.length;j++){
		if(visitId == data.data[j].visitId){
			
			visitId = data.data[j].visitId;
			
			patientId = data.data[j].patientId;
			serviceNo = data.data[j].serviceNo;
			patinetname = data.data[j].patinetname;
			rankName = data.data[j].rankName;
			age = data.data[j].age;
			gender = data.data[j].gender;
			mediceExamDate=data.data[j].mediceExamDate;
			medicalCategory=data.data[j].medicalCategory;
			meTypeName = data.data[j].meTypeName;
			approvedBy= data.data[j].approvedBy;
			status = data.data[j].approvedBy;
			departmentId = data.data[j].departmentId;
			meTypeCode = data.data[j].meTypeCode;
			
		}
	}
	rowClickCommon(visitId,patientId,patinetname,rankName,age,gender,mediceExamDate,medicalCategory,meTypeName,approvedBy, status,departmentId,meTypeCode);
}



function rowClickCommon(visitId,patientId,patinetname,rankName,age,gender,mediceExamDate,medicalCategory,meTypeName,approvedBy, status,departmentId,meTypeCode){
		$("#visitId").val(visitId);
		$("#departmentId").val(departmentId);
		$("#patientId").val(patientId);
		var approvalFlg=$('#approvalFlg').val();
		var countCheckBox=0;
		
		var desiName=$('#desiName').val();
		
 		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/medicalBoard/";
		
		if((meTypeCode=="MB15" && (desiName=="MO"||desiName=="mo"||desiName=="Mo")))
	    {	
             window.location.href = ""+url+"mbValidateDetailsForm15?visitId="+visitId+"&age="+age;
	    }
		else if((meTypeCode=="MB15" && (desiName=="RMO"||desiName=="rmo"||desiName=="Rmo")))
	    {	
             window.location.href = ""+url+"mbValidateDetailsForm15ForRMO?visitId="+visitId+"&age="+age;
	    }
		else if((meTypeCode=="MB15" && (desiName=="PDMS"||desiName=="pdms"||desiName=="Pdms")))
	    {	
             window.location.href = ""+url+"mbValidateDetailsForm15ForPDMS?visitId="+visitId+"&age="+age;
	    }
		
		else if(meTypeCode=="MB15" && approvedBy=="MO" )
	    {	
             window.location.href = ""+url+"mbValidateDetailsForm15ForRMO?visitId="+visitId+"&age="+age;
	    }
		else if(meTypeCode=="MB15" && approvedBy=="RMO" )
	    {	
             window.location.href = ""+url+"mbValidateDetailsForm15ForPDMS?visitId="+visitId+"&age="+age;
	    }
		else if(meTypeCode=="MB15" && approvedBy=="PRMO" )
	    {	
             window.location.href = ""+url+"mbValidateDetailsForm15ForPDMS?visitId="+visitId+"&age="+age;
	    }
	    else if(meTypeCode=="MB16")
	    {
	    	window.location.href = ""+url+"mbValidateDetailsForm16ForRMO?visitId="+visitId+"&age="+age;	
	    }
	    else
	    {
	    	window.location.href = "mbTranscriptionDetailsForm15?visitId="+visitId+"&age="+age;
	    }
	 	 
   
 }





function searchValidateList()
{
		

	var searchService = $j('#serviceNo').val();
	 
	 if((searchService == undefined || searchService == '')){	
			alert("Please entered  Service No.");
			return;
		}	
	 getApprovalProcessForCommon('FILTER',"SearchStatus");
	//ResetForm();
} 
function ShowAllList(pageNo)
{	 
	 nPageNo=pageNo;
	 resetForm();
	 getApprovalProcessForCommon('ALL',"SearchStatus");
}

function resetForm()
{	
	 $j('#serviceNo').val('');
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
					<div class="internal_Htext">Medical Board Waiting List</div>
					<input type="hidden" id="approvalFlg" name="approvalFlg" value=""/>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									
								<form:form name="submitMedicalExamByMo" id="submitMedicalExamByMo" method="post"
									action=" " autocomplete="off">
							  <input type="hidden" value="1" name="checkForForm" id="checkForForm"/>
							  <input type="hidden" name="visitId" id="visitId" value="${visitId}"/>
							<input type="hidden" name="patientId" id="patientId" value=""/>
							<input type="hidden" name="hospitalId" id="hospitalId" value="<%=hospitalId%>"/>
							<input type="hidden" name="userId" id="userId" value="<%=userId%>"/>
							<input type="hidden" name="desiName" id="desiName" value="<%=desiName%>"/>	
							<input type="hidden" name="departmentId" id="departmentId" value=""/>
							<input type="hidden" name="countcheckBoxValue" id="countcheckBoxValue" value=""/>	
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
												<th>Service No.</th>
												<th>Emp Name</th>
												<th>Rank</th>
												<th>Age</th>
												<th>Gender</th>
												<th>Date of MB</th>
												<th>Med. Category</th>
												<th>Medical Board</th>
												<th>MO</th>
												<th>RMO</th>
												<th>Status</th>
											</tr>
										</thead>
										<tbody id="tblListOfME">
										</tbody>
									</table>
									</form:form>
									
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