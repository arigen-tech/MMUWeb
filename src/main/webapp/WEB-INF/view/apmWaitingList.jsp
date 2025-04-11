<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
     <%@include file="..//view/leftMenu.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>


<%
	
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	
%>
<%@include file="..//view/commonJavaScript.jsp" %>
</head>
<body>
  <!-- Begin page -->
    <div id="wrapper">
 
 <div class="content-page">
                                <!-- Start content -->
 <div class="">
  <div class="container-fluid">
	 
	  <div class="internal_Htext">Pending approval list of new registration (APM)</div>
	 
                     <input type="hidden"  name="mmuId" value=<%= session.getAttribute("mmuId") %> id="mmuId" />
									<input type="hidden"  name="userId" value=<%= session.getAttribute("userId") %> id="userId" />
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">

                                     <div class="row">
		                              
										<div class="col-md-4">
											<div class="form-group row">
											    	
												<label class="col-sm-5 col-form-label">Mobile No.</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="mobile_no" maxlength="10" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" placeholder="Mobile Number">
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Employee Name</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="emp_name" placeholder="Employee name">
												</div>
											</div>
										</div>
										<div class="col-md-2">
													<button type="button" class="btn btn-primary" onclick="searchSavedEmployeeList()">Search</button>
												
										</div>
										<div class="col-md-2 text-right">
												<button type="button" class="btn  btn-primary " onclick="showAll('ALL');">Show All</button>
										</div>
                                      

                                    </div>

                                     <div classs="row">
                                     
                                     <div class="col-md-4">
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

								<div class="table-responsive">
								<table class="table table-hover table-bordered">
                                        <thead class="bg-primary" style="color:#fff;">
                                            <tr>
											<th>Employee Name</th>
											<th>Gender</th>
											<th>Age</th>
											<th>Mobile Number</th>
											<th>Type Of Employee</th>
											<th>Auditor Name</th>
											<th>Auditor Action</th>
										</tr>
                                        </thead>
                                         
                                        <tbody id="tblListofEmp">
                                       <!--  <tbody id="tblListofOpdP"> -->
												
                                        </tbody>
                                    </table>
                                    </div>
                                    
						
                                    <!-- end row -->

                                </div>
                            </div>
                            <!-- end card -->
                        </div>
                        <!-- end col -->
                    </div>
                    <!-- end row -->
                    <!-- end row -->

                </div>
                <!-- container -->
                 </div>
                  </div>

</div>


</body>
<script type="text/javascript">
	window.history.forward();
	function preventBack() {
		window.history.forward(1);
	}
</script>
 
<script type="text/javascript" language="javascript">

var nPageNo=1;
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
		 var data = {"pageNo":nPageNo,"mobileNo":"","empName":"","recordStatus":"saved","calledFor":"apmApproval","userId":"<%= userId %>"};
		}
	   else if(mobile_no!=""||emp_name!="")
		{
		nPageNo = 1;
		var data = {"pageNo":nPageNo,"mobileNo":mobile_no,"empName":emp_name,"recordStatus":"saved","calledFor":"apmApproval","userId":"<%= userId %>"};
		} 
	   else
		{
		var data = {"pageNo":nPageNo,"mobileNo":mobile_no,"empName":emp_name,"recordStatus":"saved","calledFor":"apmApproval","userId":"<%= userId %>"};
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
 			 if (dataList[i].auditorName != null) {
 				htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].auditorName+"</td>";
 			 } else{
 				htmlTable = htmlTable +"<td style='width: 100px;'></td>";
 			 }
 			if (dataList[i].auditorAction != null) {
 				
 				if(dataList[i].auditorAction=='A'){
 					auditorAction = 'Approved';
 				}else{
 					auditorAction = 'Rejected';
 				}
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+auditorAction+"</td>";
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
	 //alert(Id)
	 window.location="getEmployeeRecordForAPM?empRecId="+Id+"";
	
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

 
</html>