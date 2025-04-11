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
    <title>MMSY</title>
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
		
	 /* String departmentId = "";
		if (session.getAttribute("department_id") != null) {
			departmentId = session.getAttribute("department_id") + "";
		}  */
%>
    
<%@include file="..//view/commonJavaScript.jsp" %>


</head>

<body>
 <!-- Begin page -->
    <div id="wrapper">
		<div class="content-page">
			<div class="">
				<div class="container-fluid">
				<div class="internal_Htext">Pending For Result Entry and Validation</div>
				<input type="hidden" name="hospitalId" id="hospitalId" value="<%=hospitalId %>" />
				<input type="hidden" name="userId" id="userId" value="<%=userId %>" />
				
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
						<%-- <form id="pendingForSampleCollectionForm" name="pendingForSampleCollectionForm" action="" method="POST"> --%>
									<!------------------ Adding search part in between ---------->
				<div class="col-md-6"></div>

					<div id="patientDetailsOthersDiv">
							<!-- <h4 class="service_htext">PATIENT SEARCH</h4> -->
									<div class="row">
										
										
										<div class="col-md-3">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">
												<spring:message code="lbl_patient_name"/>
												</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="patientName"
														name="patientName" placeholder="Enterable" maxLength="50">
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
														onblur="return validateLenght('mobilenumber',10, 'Mobile Number');" onkeypress="checkNumberFormat('mobilenumber');">
												</div>
											</div>
										</div>
									
									
											<!-- <div class="col-md-1">
												<div id="loadingDiv" style="display: none;">
													<img src="/AshaWeb/resources/images/ajax-loader.gif">
												</div>
											</div> -->
										
									   
									   <div class="col-md-3">
											<div class="form-group row">
												<div class="col-sm-12">
												
													 <div class="btn-right-all obesityWait-search">
													 
													 
													 	<button class="btn btn-primary" type="button"
								           onclick="searchResultEntryWaitingList();">Search</button>
								           
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
									<div id="tblWaitingResultEntryDetails" 	class="right_col" role="main"  >
												<div class="clearfix"></div>
												<!-- <h5 style="font-weight:600;">List of Patient Details</h5> -->
												<table class="table table-striped table-hover  table-bordered  ">
													<thead>
														<tr>
															
															<th id="th1">Sample ID</th>
															<!-- <th id="th3">Sample Validated Date</th>
															<th id="th3">Sample Validation Time</th> -->														
															<th id="th4">Patient Name</th>
															<th id="th4">Age</th>
															<th id="th5">Gender</th>	
															<th id="th5">Mobile No</th>	
															<th id="th5">Sample Collected/Validated By</th>	
																													
															
															
														</tr>
													</thead>
													<tbody id="tblListOfWaitingResultEntryList">
													</tbody>
												</table>
											</div> 		
							</div>
			<%-- </form> --%>
							</div>
						</div>
					</div>
				</div>
			</div>
			</div>
		</div>
	
	</div>
	
	<script type="text/javascript">
	//onload grid
	var nPageNo = 1;
	$j(document).ready(function()
			{
		GetResultEntryWaitingList('ALL');
					
			});
	function GetResultEntryWaitingList(MODE){
		
		var patientName = $j('#patientName').val();
		var mobileNumber = $j('#mobilenumber').val();
		
		
		if(patientName === undefined){
			patientName = "";
		}
		if(mobileNumber === undefined){
			mobileNumber = "";
		}
		
		if (MODE == 'ALL') {
			var data = {"hospitalId" :<%=hospitalId%>,"patientName":"", "mobileNumber":"", "pageNo" : nPageNo}

		} else {
			var data = {"hospitalId" :<%=hospitalId%>,"patientName":patientName, "mobileNumber":mobileNumber, "pageNo" : nPageNo}

		};
		var url = "getResultEntryWaitingListGrid";		
		var bClickable = true;
		GetJsonData('tblListOfWaitingResultEntryList',data,url,bClickable);	 
	}
	
	function searchResultEntryWaitingList(){
		
		
		var mobileNumber = $j('#mobilenumber').val()
		var patientName = $j('#patientName').val()	
		var userId = $j('#userId').val()
		
		if((mobileNumber == undefined || mobileNumber == '') && (patientName == undefined || patientName == '')){	
			alert("At least one option must be entered");
			return false;
			$j('#loadingDiv').hide();
		}
		GetResultEntryWaitingList('Filter');
		/* else{
			getResultEntryList(serviceNo,mobileNumber,patientName);
			resetText();		
		} */
	}
	
	function makeTable(jsonData) {
		
		 var htmlTable = "";
	     if(jsonData.status==1){
	    var data = jsonData.count;
	    var dataList = jsonData.data;
	    
	    for(i=0;i<dataList.length;i++){	
			    	htmlTable = htmlTable+"<tr id='"+dataList[i].sampleCollectionHdId+"@"+dataList[i].subchargeCodeId+"@"+dataList[i].investigationType+"' >";			
			    
			    	htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].diagNo+"</td>";
			    	htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].patientName+"</td>";
					htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].age+"</td>";
					/* htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].collectedTime+"</td>"; */
				
					htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].gender+"</td>";					
					htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].mobileNo+"</td>";
					htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].CollectedBy+"</td>";
					
					htmlTable = htmlTable+"</tr>";
		    	  
		      }
			  //$j('#message').html('');
		      $j("#tblListOfWaitingResultEntryList").html(htmlTable);
			  
			  
		}else{
			
			 
			 $j("#tblListOfWaitingResultEntryList").empty();
			 //$j('#message').html(jsonData.msg);
			 $j('#loadingDiv').hide();
		}
		
			
		
	    
	  }

	<%-- function getResultEntryList(serviceNo,mobileNumber,patientName){
		
		$j('#loadingDiv').show();
		if(serviceNo!=null && serviceNo!=''){
			var params = {"serviceNo": serviceNo, "hospitalId":<%=hospitalId%>, "userId":<%=userId%>}
	        var data = params;					
	        var url = "getResultEntryWaitingList";
	        var bClickable = true;
	          GetJsonData('tblListOfWaitingResultEntryList', data, url, bClickable); 
		}
		
		if (patientName!=null && patientName!= ''){
			var params = {"patientName":patientName, "userId":<%=userId%>, "hospitalId":<%=hospitalId%>}
	        var data = params;				
	        var url = "getResultEntryWaitingList";
	        var bClickable = true;
	          GetJsonData('tblListOfWaitingResultEntryList', data, url, bClickable); 
		}
		
		if (mobileNumber!=null && mobileNumber!=''){
			var params = {"mobileNo":mobileNumber, "userId":<%=userId%>, "hospitalId":<%=hospitalId%>}
	        var data = params;				
	        var url = "getResultEntryWaitingList";
	        var bClickable = true;
	          GetJsonData('tblListOfWaitingResultEntryList', data, url, bClickable); 
		}
	} --%>
	
	function executeClickEvent(id) {
		
		var fields = id.split('@');
		var sampleCollectionHdId = fields[0];
		var subchargeCodeId = fields[1];
		var investigationType = fields[2];
		//alert("sampleCollectionHdId :: "+sampleCollectionHdId+ "subchargeCodeId :: "+subchargeCodeId + "investigationType :: "+investigationType);
		window.location="getResultEntryDetails?sampleCollectionHdId="+sampleCollectionHdId;
	}
	
	function resetText(){
		//$j('#serviceNo').
		$(document).ready(function() {
			$j('#serviceNo').val('');
			$j('#patientName').val('');
			$j('#mobilenumber').val('');
		});
	}
	
	function showResultPage(pageNo) {
		nPageNo = pageNo;
		GetResultEntryWaitingList('FILTER');

	}
	
	 function showAll()
	 {
	 	ResetForm();
	 	nPageNo = 1;	
	 	GetResultEntryWaitingList('ALL');	 	
	 }
	 
		function ResetForm() {
			$j('#serviceNo').val('');	
			$j('#patientName').val('');
			$j('#mobileNo').val('');
		}
	</script>

</body>

                