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
  <title>Sanction Order List</title>
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
				<div class="internal_Htext">
				Sanction Order Tracking List
				
				
				</div>

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
													<th id="th1">S.No.</th>
													<th id="th2">Requirement No</th>
													<th id="th6">Sanction Number</th>
													<th id="th3">LP Type</th>
													<th id="th4">LP Cost</th>
													<th id="th10">Quotation Approved By</th>
													<th id="th11">Quotation Approved On</th>
													<th id="th5">Sanction Created By </th>
													<th id="th7">Sanction Created On</th>
													<th id="th8">Sanction Approved By </th>
													<th id="th12">Sanction Approved On</th>
													<th id="th9">Status</th>
													
												</tr>
											</thead>
											<tbody id="tblListOfSanctionOrder">
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
	 GetListOfQuotation('ALL');
	 
		});
		
function GetListOfQuotation(MODE)
{
	 if(MODE == 'ALL'){
		 var data = {"PN":nPageNo,"flag":"ALL"};		
		}
	else
		{
		var data = {"PN":nPageNo,"flag":"ALL"};
		} 
	var url = "getSanctionList";
		
	var bClickable = true;
	GetJsonData('tblListOfSanctionOrder',data,url,bClickable);
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
			   htmlTable = htmlTable + "<tr id='"+dataList[item].storeSoMId+"' >";	
			  htmlTable = htmlTable + "<td >" +i+ "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].reqNo + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].sanctionNumber + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].lpType + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].leastCost + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].quotationBy + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].quotationOn + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].sanctionOrderCreatedBy + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].orderDate + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].sanctionApprovedBy + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].sanctionApprovedOn + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].status + "</td>";
	    	  htmlTable = htmlTable + "</tr>";
	    i++;
	      }
	if(jsonData.count == 0 || typeof jsonData.count == 'undefined')
		{
		htmlTable = htmlTable+"<tr ><td colspan='12'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblListOfSanctionOrder").html(htmlTable);	
	
	
}


function showResultPage(pageNo)
{
	
	
	nPageNo = pageNo;	
	GetListOfQuotation('FILTER');
	
}


function showAll()
{
	nPageNo = 1;	
	GetListOfQuotation('ALL');
	
}

var storeQMId;
var quotationBy;
var reqNo;
var leastCost;
var budgetaryMId;
var quotationDate
function executeClickEvent(storeSoMId,jsonData)
{
	var dataList = jsonData.data;
	 for(item in dataList){
		if(storeSoMId == dataList[item].storeSoMId){
			
			
			reqNo = dataList[item].reqNo;
			leastCost = dataList[item].leastCost;
			storeSoMId= dataList[item].storeSoMId;
		}
	}
	rowClick(reqNo,leastCost,storeSoMId);
}


function rowClick(reqNo,leastCost,storeSoMId){	
	window.location.href = "approveSanctionOrderDetails?storeSoMId="+storeSoMId+"&flag=list";
	
}

</script>

</html>