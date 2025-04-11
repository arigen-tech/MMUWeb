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
<title>Mobile Medical Unit- MMSSY</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>


<script type="text/javascript">

<%

String userId = "1";
if (session.getAttribute("user_id") != null) {
	userId = session.getAttribute("user_id") + "";
}

%>

nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{
			getSavedEmployeeList('ALL');
		});
	
	
function searchSavedEmployeeList()
{
		
	var nPageNo=1;	
	 var mobile_no = $j('#mobile_no').val();
	 	var emp_name = $j('#emp_name').val();
	if((mobile_no == undefined || mobile_no == '') && (emp_name == undefined || emp_name == '')){	
		alert("At least one option must be entered");
		return;
	}
	getSavedEmployeeList('FILTER');
	ResetForm();
} 

function getSavedEmployeeList(MODE) { 	
 	
	     var mobile_no = $j('#mobile_no').val();
	 	var emp_name = $j('#emp_name').val();
    var cmdId=0;
	 if(MODE == 'ALL'){
		 var data = {"pageNo":nPageNo,"mobileNo":"","empName":"","recordStatus":"saved","calledFor":"upssApproval","userId":"<%= userId %>"};
		}
	   else if(mobile_no!=""||emp_name!="")
		{
		nPageNo = 1;
		var data = {"pageNo":nPageNo,"mobileNo":mobile_no,"empName":emp_name,"recordStatus":"saved","calledFor":"upssApproval","userId":"<%= userId %>"};
		} 
	   else
		{
		var data = {"pageNo":nPageNo,"mobileNo":mobile_no,"empName":emp_name,"recordStatus":"saved","calledFor":"upssApproval","userId":"<%= userId %>"};
		} 
	 
	var url = "savedEmpList";		
	var bClickable = true;
	GetOpdJsonData('tblListofEmp',data,url,bClickable);
}
 
 
 function makeTable(jsonData)
 {	
 	var htmlTable = "";	
 	var data = jsonData.count;
 	
 	var dataList = jsonData.data;
 	if(dataList!=undefined && dataList!="" && dataList.length >= 0)	
 	{	
 	for(i=0;i<dataList.length;i++)
 		{	 		
 		
 			htmlTable = htmlTable+"<tr  id='"+dataList[i].empId+"' >";
 			htmlTable = htmlTable +"<td  style='width: 200px;' >"+dataList[i].empName+"</td>";
 			htmlTable = htmlTable +"<td  style='width: 200px;'>"+dataList[i].gender+"</td>";
 			htmlTable = htmlTable +"<td style='width: 200px;'>"+dataList[i].age+"</td>";
 			htmlTable = htmlTable +"<td style='width: 200px;'>"+dataList[i].mobileNo+"</td>";
 			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].empType+"</td>"; 
 			if (dataList[i].chmoName != null) {
 	 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].chmoName+"</td>";
 	 			}
 	 			else{
 	 				htmlTable = htmlTable +"<td style='width: 100px;'></td>";
 	 			 }
 	 			if (dataList[i].chmoAction != null) {
 	 				if(dataList[i].chmoAction=='A'){
 	 					chmoAction = 'Approved';
 	 				}else{
 	 					chmoAction = 'Rejected';
 	 				}
 	 			htmlTable = htmlTable +"<td style='width: 100px;'>"+chmoAction+"</td>";	
 	 			}
 	 			else{
 	 				htmlTable = htmlTable +"<td style='width: 100px;'></td>";
 	 			 }
 			
 			htmlTable = htmlTable+"</tr>";
 			
 		}	
 		}
 	   if(jsonData.status == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='12'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
 	
 	$j("#tblListofEmp").html(htmlTable);	
 	
 	
 }
 
 function executeClickEvent(Id)
 {
	 window.location="getEmployeeRecordForUPSS?empRecId="+Id+"";
	
 }
 
 function showResultPage(pageNo) 	
 {
 	
 	nPageNo = pageNo;	
 	getSavedEmployeeList('FILTER');
 	
 }
 
 function ResetForm()
 {	
 	 $j('#mobile_no').val('');
 	 $j('#emp_name').val('');
 }
 
 function showAll()
 {
	 ResetForm();
 	nPageNo = 1;	
 	getSavedEmployeeList('ALL');
 	
 }


 
</script>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">Pending Approval List of Registration Request (UPSS)</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
								
								<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Mobile Number</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="mobile_no" placeholder="Mobile number"/>
											</div>
										</div>
									</div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Employee Name</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="emp_name" placeholder="Employee name"/>
											</div>
										</div>
									</div>
									
									<div class="col-md-2">
										<button type="button" class="btn btn-primary" onclick="searchSavedEmployeeList()">Search</button>
									</div>
									<div class="col-md-2 text-right">
										<button type="button" class="btn btn-primary" onclick="showAll('ALL');">Show All</button>
									</div>
								</div>

								<div class="m-t-10">
									<div class="clearfix">
										<div style="float: left">
											<table class="tblSearchActions" cellspacing="0"
												cellpadding="0" border="0">
												<tr>
													<td class="SearchStatus" style="font-size: 15px;"
														align="left">Search Results</td>
													<td></td>
												</tr>
											</table>
											
										</div>

										<div style="float: right">
											<div id="resultnavigation"></div>
										</div>
										<div class="table-responsive scrollableDiv" id="table_div">
											<table
												class="table table-striped table-hover table-bordered " id="campTable">
												<thead class="bg-success" style="color: #fff;">
													<tr>
														<th>Employee Name</th>														
														<th>Gender</th>
														<th>Age</th>
														<th>Mobile No.</th>
														<th>Type of Employee</th>
														<th>CHMO Name</th>
														<th>CHMO Action</th>
													</tr>
												</thead>
												<tbody id="tblListofEmp">
												</tbody>
											</table>
										</div>
									</div>
								</div>

							</div>
						</div>
						<!-- end card -->
					</div>
					<!-- end col -->
				</div>
				<!-- end row -->

			</div>
			<!-- container -->
			<!-- content -->
		</div>
	</div>
	<!-- END wrapper -->

	<!-- jQuery  -->


</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
