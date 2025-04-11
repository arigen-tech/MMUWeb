<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
  <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>  
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Indian Coast Guard</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    
     <%
     
     
    String hospitalId = null;
		if (session.getAttribute("mmuId") != null) {
			hospitalId = session.getAttribute("mmuId") + "";
		}
		String userId = null;
		if (session.getAttribute("userId") != null) {
			userId = session.getAttribute("userId") + "";
		}
		
	
	
%>
    
<%@include file="..//view/commonJavaScript.jsp" %>


</head>

<body>
 <!-- Begin page -->
    <div id="wrapper">
		<div class="content-page">
			<div class="">
				<div class="container-fluid">
				<div class="internal_Htext">Pending For Sample Collection and Validation</div>
				
				
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
						        <form id="pendingForSampleCollectionForm" name="pendingForSampleCollectionForm" action="" method="POST">
									<!------------------ Adding search part in between ---------->
									<input type="hidden" name="mmuId" id="hospitalId" value="<%=hospitalId %>" />
									<input type="hidden" name="userId" id="userId" value="<%=userId %>" />
									<%-- <input type="hidden" name="departmentId" id="departmentId" value="<%= departmentId %>" /> --%>
									
				<div class="col-md-6"></div>

					<div class="" id="patientDetailsOthersDiv">
							<!-- <h4 class="service_htext">PATIENT SEARCH</h4> -->
									<div class="row">
									
										
										<div class="col-md-3">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">
												<spring:message code="lbl_patient_name"/>
												</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="patientName"
														name="patientName" placeholder="Enterable" maxLength="50" autocomplete="off">
												</div>
											</div>
										</div>
										
										<div class="col-md-3">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">
												<spring:message code="lbl_mobile_no"/>
												</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="mobilenumber"
														name="mobilenumber" placeholder="Enterable" maxLength="10"
														onblur="return validateLenght('mobilenumber',10, 'Mobile Number');" onkeypress="checkNumberFormat('mobilenumber');" autocomplete="off">
												</div>
											</div>
										</div>										
											
										<!-- <div class="col-md-1 text-right">
											<div id="loadingDiv" style="display: none;">
												<img src="/AshaWeb/resources/images/ajax-loader.gif">
											</div>
										</div>
									    -->
										<div class="col-md-3">
											<div class="form-group row">
												<div class="col-sm-12">												
													 <div class="btn-right-all obesityWait-search">
													 	<button type="button" class="btn btn-primary"
														onclick="searchPendingSampleCollectionList()">Search</button>
														<button type="button" class="btn  btn-primary "
													onclick="showAll('ALL');">Show All</button>
														</div>
												</div>
											</div>
										</div>										
									   </div>
									   
									   <div class="m-t-10">
									   <div style="float: left">
											<table class="tblSearchActions" cellspacing="0"
												cellpadding="0" border="0">
												<tr>
													<td class="SearchStatus" style="font-size: 15px;"
														align="left">Search Results</td>
												</tr>
											</table>
										</div>
										<div style="float: right">
											<div id="resultnavigation"></div>
										</div>
										</div>
										
										<div class="col-md-12"><p align="Left" id="message"	style="color: green; font-weight: bold;"></p></div>
									</div>
									<div id="tblpendingSampleCollectionDetails"
												class="right_col" role="main">
												<div class="clearfix"></div>
												<!-- <h5 style="font-weight:600;">List of Patient Details</h5> -->
												<table class="table table-striped table-hover  table-bordered  ">
													<thead>
														<tr>
															<th id="th1">Order Date</th>
															
															<th id="th3">Patient Name</th>
															
															<th id="th3">Mobile No</th>
																														
															
															
															<th id="th6">Age</th>
															<th id="th7">Gender</th>
															
															<th id="th9">Department</th>
															
														</tr>
													</thead>
													<tbody id="tblListOfPendingSampleCollection">
													</tbody>
												</table>
											</div> 		
							</div>
			</form>
							</div>
						</div>
					</div>
				</div>
			</div>
			</div>
		</div>
	
	</div>
	
	<script type="text/javascript">
	var hospitalId='';
	var userId='';
	function searchPendingSampleCollectionList(){
		
	
		//var serviceNo = $j('#serviceNo').val()
		userId = $j('#userId').val()
		
	
		var patientName = $j('#patientName').val()
		var mobileNumber = $j('#mobilenumber').val()
		hospitalId = $j('#hospitalId').val()
		
		if((mobileNumber == undefined || mobileNumber == '') && (patientName == undefined || patientName == '')){	
			alert("At least one option must be entered");
			/* $j('#loadingDiv').hide(); */
			return false;
		}
		GetSampleCollectionWaitingList('Filter');
	}
		
	
	$j(document).ready(function()
			{
		GetSampleCollectionWaitingList('ALL');
					
			});
	
	function GetSampleCollectionWaitingList(MODE){
		
		var mobileNumber = $j('#mobilenumber').val()
		var patientName = $j('#patientName').val()	
		
		var hospitalId= "<%=hospitalId%>";
		
		
		if(patientName === undefined){
			patientName = "";
		}
		if(mobileNumber === undefined){
			mobileNumber = "";
		}
		
		if (MODE == 'ALL') {
			var data = {"hospitalId" :<%=hospitalId%>, "patientName":"", "mobileNumber":"", "pageNo" : nPageNo}

		} else {
			var data = {"hospitalId" :<%=hospitalId%>,"patientName":patientName, "mobileNumber":mobileNumber, "pageNo" : nPageNo}

		}
		
		
		
		
		var url = "getPendingSampleCollectionWaitingListGrid";		
		var bClickable = true;
		GetJsonData('tblListOfPendingSampleCollection',data,url,bClickable);	 
	}
	
	function makeTable(jsonData)
	{	
		var htmlTable = "";	
		var data = jsonData.count; 
		if(jsonData.data != undefined){
		var dataList = jsonData.data;
		
		for(i=0;i<dataList.length;i++)
			{		
				htmlTable = htmlTable+"<tr id='"+dataList[i].headerId+"@"+hospitalId+"' >";			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].orderdate+"</td>";
				
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].patientname+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].mobileNumber+"</td>";
				
			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].age+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].gender+"</td>";
				
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].departmentName+"</td>";
				//htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].userName+"</td>";
				htmlTable = htmlTable+"</tr>";
				
			}
		}
		if(jsonData.data == undefined)
			{
			htmlTable = htmlTable+"<tr ><td colspan='9'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		$j("#tblListOfPendingSampleCollection").html(htmlTable); 	
		
	}
	var hospId = $j('#hospitalId').val();
	
	function executeClickEvent(id) {
		var fields = id.split('@');
		var headerId = fields[0];
		var hospId = fields[1];
		var userId = fields[2];
		//alert("headerId :: "+headerId +"hospitalId :: "+hospId);
		window.location="pendingSampleCollectionDetails?orderhdId="+headerId+"";
	}
	
	function showResultPage(pageNo) {

		nPageNo = pageNo;
		GetSampleCollectionWaitingList('FILTER');

	}
	
	 function showAll()
	 {
	 	ResetForm();
	 	nPageNo = 1;	
	 	GetSampleCollectionWaitingList('ALL');	 	
	 }
	 
		function ResetForm() {
			$j('#serviceNo').val('');
			$j('#patientName').val('');
			$j('#mobilenumber').val('');
		}
	</script>

</body>

                