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
  <title>Pending For Indent Approval (Doctor)</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <!--  <link href="//resources/css/icons1.css" rel="stylesheet" type="text/css" /> -->
   
</head>
<%
String departmentId = HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim();
String departmentName="";
String mmuId = "0";
if (session.getAttribute("mmuId") != null) {
	mmuId = session.getAttribute("mmuId") + "";
}

String levelOfUser = "1";
if (session.getAttribute("levelOfUser") != null) {
	levelOfUser = session.getAttribute("levelOfUser") + "";
}


String userId = "0";
if (session.getAttribute("userId") != null) {
	userId = session.getAttribute("userId") + "";
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
				<div class="internal_Htext">Pending For Indent Approval (Doctor)</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
					
								<!-- <div class="row">
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">MMU</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="mmuId" onchange="getIndentList(this)">
												<option value="">Select</option>
												</select>
											</div>
										</div>
									</div>
								</div>	 -->
										
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
                                    
					
		
									<div class="table-responsive">
                                    <table class="table table-hover table-striped table-bordered">
                                        <thead class="bg-success" style="color:#fff;">
												<tr>
													<th id="th1">Indent Date</th>
													<th id="th2">Indent No</th>
													<th id="th3">MMU Name</th>
													<th id="th10">Created By</th>

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
	 //getMMUList();
	//if department not in session
	 if(<%= departmentId %>==0){
			alert("Select the department");
			return false;
		}
	 GetListOfIndent('ALL');
	 
		});
 
 function getIndentList(item){
	 
	 
	 params = {
			 'mmuId':"<%= mmuId %>",
			 "PN":nPageNo,
			 'flag':'Y'
		}
	 
	 var url = "getPendingListForAuditor";
		
		var bClickable = true;
		GetJsonData('tblListOfIndent',params,url,bClickable);
	 
 }
		
function GetListOfIndent(MODE)
{
	/* var serviceNo=$j('#serviceNo').val();
	var fromDate = $j('#fromDate').val();
	  var toDate = $j('#toDate').val(); */
	  var mmuId = "<%= mmuId %>";
	 if(MODE == 'ALL'){
		 var data = {"PN":nPageNo,"flag":"Y","mmuId":mmuId};		
		}
	else
		{
		var data = {"PN":nPageNo,"flag":"Y","mmuId":mmuId};
		} 
	var url = "getPendingListForAuditor";
		
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
			   htmlTable = htmlTable + "<tr id='"+dataList[item].indentId+"' >";	
			  htmlTable = htmlTable + "<td >" + dataList[item].indentdate + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].indentNo + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].mmuName + "</td>";
	    	  //htmlTable = htmlTable + "<td >" + dataList[item].toDept + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].createdBy +" ("+dataList[item].createdByDsg+")"+ "</td>";
	    	 // htmlTable = htmlTable + "<td >" + dataList[item].status + "</td>";
	    	  htmlTable = htmlTable + "</tr>";
	    
	      }
	if(jsonData.count == 0 || typeof jsonData.count == 'undefined')
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblListOfIndent").html(htmlTable);	
	
	
}

function getMMUList(){
		  
		  /* params = {
			}
			
			$.ajax({
				type : "POST",
				contentType : "application/json",
				url : 'getMMUList',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(data) {
					if(data.status == true){
						var list = data.list;
						var mmuDrop = '';
						$j('#mmuId').find('option').not(':first').remove();
						for(i=0;i<list.length;i++){
							mmuDrop += '<option value='+list[i].mmuId+'>'+list[i].mmuName+'</option>';
						}
						$j('#mmuId').append(mmuDrop);
					}
				},
				error : function(data) {
					alert("An error has occurred while contacting the server");
				}
			});  */
		  
		  
		  var params = {
					"levelOfUser":'<%=levelOfUser%>',
					"userId": <%=userId%>
			}
			
			$.ajax({
				type : "POST",
				contentType : "application/json",
				url : '${pageContext.request.contextPath}/master/getMMUHierarchicalList',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(result) {
					   var mmuDrop = '';
					   var data=result.mmuListdata;
					   
					   if(data.mmuList.length =='1'){
						   $('#mmuId').attr('disabled', true);
						   for(i=0;i<data.mmuList.length;i++){
								mmuDrop += '<option value='+data.mmuList[i].mmu_id+'selected>'+data.mmuList[i].mmu_name+'</option>';
								
							}
							$j('#mmuId').append(mmuDrop);
						  <%--  document.getElementById('mmuId').value = <%=mmuId%>;  --%>
					   }
					   else{
						for(i=0;i<data.mmuList.length;i++){
							mmuDrop += '<option value='+data.mmuList[i].mmu_id+'>'+data.mmuList[i].mmu_name+'</option>';
							
						}
						$j('#mmuId').append(mmuDrop);
					  }
				},
				error : function(data) {
					alert("An error has occurred while contacting the server");
				}
			}); 
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
	 window.location.href = "getIndentDetailsApprovalForAuditor?indentId="+indentId+"&indentStatus="+statusId;
	
}
</script>

</html>