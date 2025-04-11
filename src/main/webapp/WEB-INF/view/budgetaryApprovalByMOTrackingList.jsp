<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
  <%@include file="..//view/commonJavaScript.jsp"%> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>PENDING FOR BUDGETARY APPROVAL</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <!--  <link href="//resources/css/icons1.css" rel="stylesheet" type="text/css" /> -->
   
</head>
<%
long departmentId = 0;
String departmentName="";
	  if (session.getAttribute("department_id") != null) {
	   departmentId = Long.parseLong(session.getAttribute("department_id").toString());
	  }
	  
	  %>
<body>
 <div id="wrapper">

<form name="frm">
	<div class="content-page">
		<!-- Start content -->
		  <div class="col-md-4">
					<div id="successmsg" style="color:green; align:center;">
										${message}
					</div>
		  </div>
		<div class="">
		
			<div class="container-fluid">
				<div class="internal_Htext">Budgetary Approval Tracking List(MO) </div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
														  <div style="float:left">					           
		                                    <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >	
		                                    
		                             		<tr>
												<td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
												<td>
												 <!-- <div id=resultnavigation></div> -->
												
												</td>
												</tr>
										</table>
		                                 </div>     
		                                    <div style="float:right">
				                                    <div id="resultnavigation">
				                                    </div> 
		                                    </div> 
                                    
					
		

                                    <table class="table table-hover table-striped table-bordered">
                                        <thead class="bg-success" style="color:#fff;">
												<tr>
													<th id="th1">SI NO.</th>
													<th id="th2">Date</th>
													<th id="th3">Requirement No</th>
													<th id="th4">Created By</th>
													<th id="th10">Approx Cost</th>
													<th id="th5">MO Approval Date</th>
													<th id="th6">LP Type</th>
													<th id="th7">Status</th>
													
												</tr>
											</thead>
											<tbody id="tblListOfBudgetary">
											</tbody>
										</table>
									</div>




								

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

</form>
</div>
</body>
<script>
	var nPageNo=1;
	var Status;
	var $j = jQuery.noConflict();
	//var i=1;
	 $j(document).ready(function()
		{	
		//if department not in session
		   	if(<%= departmentId %>==0){
				
					alert("Select the department");
					return false;
				}
			 GetListOfIndent('ALL');
	 
		});
		
function GetListOfIndent(MODE)
{
	/* var serviceNo=$j('#serviceNo').val();
	var fromDate = $j('#fromDate').val();
	  var toDate = $j('#toDate').val(); */
	 if(MODE == 'ALL'){
		 var data = {"PN":nPageNo,"flag":"WL"};		
		}
	else
		{
		var data = {"PN":nPageNo,"flag":"WL"};
		} 
	var url = "getBudgetaryApprovalList";
		
	var bClickable = true;
	GetJsonData('tblListOfBudgetary',data,url,bClickable);
} 

function makeTable(jsonData)
{	
	var htmlTable = "";	
	var data = jsonData.count;
	var pageSize = 5;
	var i=1+pageSize*(nPageNo-1);
	
	var dataList = jsonData.data;

	 for(item in dataList){
			
			  // htmlTable += '<tr id="'+dataList[item].Id+'" onclick="hello('+dataList+')">';
			   htmlTable = htmlTable + "<tr id='"+dataList[item].budgetaryMId+"' >";	
			  htmlTable = htmlTable + "<td >" +i+ "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].reqDate + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].reqNo + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].createdBy + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].approxCost + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].moApproveDate + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].lpType + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].status + "</td>";
	    	  htmlTable = htmlTable + "</tr>";
	    i++;
	      }
	if(jsonData.count == 0 || typeof jsonData.count == 'undefined')
		{
		htmlTable = htmlTable+"<tr ><td colspan='8'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblListOfBudgetary").html(htmlTable);	
	
	
}


function showResultPage(pageNo)
{
	
	
	nPageNo = pageNo;	
	GetListOfIndent('FILTER');
	
}


function showAll()
{
	nPageNo = 1;	
	GetListOfIndent('ALL');
	
}

var reqDate;
var createdBy;
var reqNo;
var approxCost;
var budgetaryMId;
var statusId
function executeClickEvent(budgetaryMId,jsonData)
{
	var dataList = jsonData.data;
	 for(item in dataList){
		if(budgetaryMId == dataList[item].budgetaryMId){
			
			budgetaryMId = dataList[item].budgetaryMId;
			reqDate = dataList[item].reqDate;
			reqNo = dataList[item].reqNo;
			approxCost = dataList[item].approxCost;
			createdBy =dataList[item].createdBy;
			statusId =dataList[item].statusId;
			
		}
	}
	rowClick(budgetaryMId,reqDate,reqNo,approxCost,createdBy,statusId);
}


function rowClick(budgetaryMId,reqDate,reqNo,approxCost,createdBy,statusId){	
	 window.location.href = "getBudgetaryDetailsForMOTracking?budgetaryId="+budgetaryMId+"&budgetaryStatus="+statusId;
	
}
</script>

</html>