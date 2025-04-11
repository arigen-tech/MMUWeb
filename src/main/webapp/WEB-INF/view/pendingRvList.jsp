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
  <title>Pending For RV</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <!--  <link href="//resources/css/icons1.css" rel="stylesheet" type="text/css" /> -->
   
</head>
<%
String departmentId = HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim();
String departmentName="";

String districtId = "0";
if (session.getAttribute("distIdUsers") != null) {
	districtId = session.getAttribute("distIdUsers") + "";
	districtId = districtId.replace(",", "");
}
	  
%>
<body>
 <div id="wrapper">

<form name="frm">
	<div class="content-page">
		<!-- Start content -->
		 
		<div class="">
		
			<div class="container-fluid">
				<div class="internal_Htext">Pending For RV</div>

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
													<th id="th1">PO No</th>
													<th id="th2">PO Date</th>
													<th id="th3">Vendor Type</th>
													<th id="th4">Vendor Name</th>
													<th id="th4">Type of PO</th>
													<th id="th4">Status</th>
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
	 		GetListOfRV('ALL');
	 
		});
 
 function GetListOfRV(item){
	 params = {
			 "pageNo":nPageNo,
			 "districtId":"<%= districtId %>"
		}
	 
	 var url = "getRvWaitingList";
		
		var bClickable = true;
		GetJsonData('tblListOfIndent',params,url,bClickable);
	 
 }
		
function GetListOfIndent(MODE)
{
	
	var data = {"pageNo":nPageNo,"districtId":"<%= districtId %>"};	
	var url = "getRvWaitingList";
		
	var bClickable = true;
	GetJsonData('tblListOfIndent',data,url,bClickable);
} 

function makeTable(jsonData)
{	
	var htmlTable = "";	
	var data = jsonData.count;
	
	
	var pageSize = 5;

	
	var dataList = jsonData.list;
	if(dataList!=null && dataList!=undefined && dataList.length>0)
	 for(item=0; item<dataList.length;item++){
			
			  htmlTable = htmlTable + "<tr id='"+dataList[item].id+"'>";	
			  htmlTable = htmlTable + "<td >" + dataList[item].poNo + "</td>";
			  htmlTable = htmlTable + "<td >" + dataList[item].poDate + "</td>";
			  htmlTable = htmlTable + "<td >" + dataList[item].vendorType + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].vendorName + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].typeOfPo + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].status + "</td>";
	    	  htmlTable = htmlTable + "</tr>";
	    
	      }
	if(jsonData.count == 0 || typeof jsonData.count == 'undefined')
		{
		htmlTable = htmlTable+"<tr ><td colspan='6'><h6>No Record Found</h6></td></tr>";
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
	nPageNo = 1;	
	GetListOfIndent('ALL');
	
}

function executeClickEvent(id)
{
	window.location.href = "rvDetailsAgainstSo?id="+id;
}

</script>

</html>