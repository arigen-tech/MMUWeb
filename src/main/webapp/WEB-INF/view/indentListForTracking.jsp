<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.mmu.web.utils.HMSUtil"%>
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
  <title>Indent Tracking List</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
     <!-- <link href="//resources/css/icons1.css" rel="stylesheet" type="text/css" /> -->
   
</head>
<%
	String departmentId = HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim();
/* 	if (session.getAttribute("department_id") != null) {
		departmentId = session.getAttribute("department_id") + "";
	 } */
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
				<div class="internal_Htext">Indent Tracking List</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								

									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-md-4 col-form-label"> From Date</label>
												<div class="col-md-7">
													<!-- <input type="date" class="form-control custom_date" name="fromDate" id="fromDate"> 
													<input  type="text" class="form-control custom_date calDate"  name="fromDate" id="fromDate" placeholder="DD/MM/YYYY" validate="To Date,string,yes"/> -->
																	<div class="dateHolder"> 
																			<input  type="text" class="calDate custom_date datePickerInput form-control"  name="fromDate" id="fromDate" placeholder="DD/MM/YYYY" validate="From Date,string,yes" value=""  maxlength="10" />
                                                                   </div>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-md-4 col-form-label">To Date</label>
												<div class="col-md-7">
												<!-- 	<input type="date" class="form-control custom_date" name="toDate" id="toDate"> 
												<input  type="text" class="form-control custom_date calDate" name="toDate" id="toDate" placeholder="DD/MM/YYYY" validate="To Date,string,yes"/> -->
																	<div class="dateHolder"> 
																			<input  type="text" class="calDate custom_date datePickerInput form-control"  name="toDate" id="toDate" placeholder="DD/MM/YYYY" validate="From Date,string,yes" value=""  maxlength="10" />
                                                                   </div>
												</div>
											</div>
										</div>
										<div class="col-md-1">
											<button class="btn btn-primary" id="searhAppointment"
												type="button" onclick="searchAppointment()">Search</button>
												

										</div>

	                                   <div class="col-md-3">
											  <div class="btn-right-all">                                      
                                                     <button type="button" class="btn  btn-primary " onclick="showAll();">Show All</button>
                                                    
                                        </div> 

										</div>
										 

									</div>

									<input type="hidden" id="serviceNo" name="serviceNo"
										value="${serviceNo}">


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
													<th id="th1">Indent Date</th>
													<th id="th2">Indent No</th>
													<th id="th4">Created By</th>
													<th id="th10">Approved By</th>
													<th id="th5">Status </th>
													
												</tr>
											</thead>
											<tbody id="tblListOfIndent">
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

 $j(document).ready(function()
		{	
			 GetListOfIndent('ALL');
	 
		});
		
function GetListOfIndent(MODE)
{
	var fromDate = $j('#fromDate').val();
	  var toDate = $j('#toDate').val();
	 if(MODE == 'ALL'){
		 var data = {"PN":nPageNo,"flag":"T"};		
		}
	else
		{
		var data = {"PN":nPageNo,"fromDate":fromDate,"toDate":toDate,"flag":"T"};
		} 
	var url = "getIndentListForTracking";
		
	var bClickable = true;
	GetJsonData('tblListOfIndent',data,url,bClickable);
} 

function makeTable(jsonData)
{	
	var htmlTable = "";	
	var data = jsonData.count;
	
	
	var pageSize = 5;

	
	var dataList = jsonData.data;

	 for(item in dataList){
			
			  // htmlTable += '<tr id="'+dataList[item].Id+'" onclick="hello('+dataList+')">';
			  htmlTable = htmlTable + "<tr id='"+dataList[item].indentId+"'>";
			  htmlTable = htmlTable + "<td >" + dataList[item].indentdate+ "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].indentNo+ "</td>";
	    	 // htmlTable = htmlTable + "<td >" + dataList[item].toDept + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].createdBy + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].approvedBy + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].status + "</td>";
	    	 htmlTable = htmlTable + "</tr>";
	    
	      }
	if(jsonData.count == 0 || typeof jsonData.count == 'undefined')
		{
		htmlTable = htmlTable+"<tr ><td colspan='5'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblListOfIndent").html(htmlTable);	
	
	
}


function showResultPage(pageNo)
{
	
	
	nPageNo = pageNo;	
	GetListOfIndent('FILTER');
	
}


function showAll()
{
	 $j('#fromDate').val("");
	$j('#toDate').val(""); 
	nPageNo = 1;	
	GetListOfIndent('ALL');
	
}

function searchAppointment() {
	if(document.getElementById('fromDate').value == "" || document.getElementById('fromDate') == null){
		 alert("Please select From Date");
		 return false;
	 }
	if(document.getElementById('toDate').value == "" || document.getElementById('toDate') == null){
		 alert("Please select To Date");
		 return false;
	 }
	
	  var fromDate = $j('#fromDate').val();
	  var toDate = $j('#toDate').val();
      
		var fd = fromDate.split("/");
		var fDate= new Date(fd[2], fd[1] - 1, fd[0])
		
		var td = toDate.split("/");
		var tDate= new Date(td[2], td[1] - 1, td[0])
 	 if(tDate < fDate) {
 	alert("To Date cannot be earlier than the From Date");
 	return false;
 	} 
 	nPageNo=1;
 	GetListOfIndent('FILTER');
}

var indentId;
var indentNo;
var indentdate;
var toDept;
var createdBy;
var approvedBy;
var status;
var statusId;
function executeClickEvent(indentId,jsonData)
{
	var dataList = jsonData.data;
	 for(item in dataList){
		if(indentId == dataList[item].indentId){
			
			indentId = dataList[item].indentId;
			
			indentNo = dataList[item].indentNo;
			indentdate = dataList[item].indentdate;
			toDept = dataList[item].toDept;
			createdBy =dataList[item].createdBy;
			approvedBy =dataList[item].approvedBy;
			status = dataList[item].status;
			statusId = dataList[item].statusId;
			
		}
	}
	rowClick(indentId,indentNo,indentdate,toDept,createdBy,approvedBy,status,statusId);
}


function rowClick(indentId,indentNo,indentdate,toDept,createdBy,approvedBy,status,statusId){	
	 window.location.href = "getIndentDetailsForTracking?indentId="+indentId+"&indentStatus="+statusId;
	
}
</script>

</html>