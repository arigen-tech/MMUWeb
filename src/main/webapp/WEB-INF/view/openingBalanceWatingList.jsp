<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.mmu.web.utils.HMSUtil"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@include file="..//view/leftMenu.jsp" %>
<%@include file="..//view/commonJavaScript.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Indian Coast Guard</title>

<script src="${pageContext.request.contextPath}/resources/js/stores.js"></script> 


</head>

<%
String departmentId = HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim();

/*   if (session.getAttribute("departmentId") != null) {
   departmentId = Long.parseLong(session.getAttribute("departmentId").toString());
  } */

	  
  String mmuId = "0";
	if (session.getAttribute("mmuId") != null) {
		mmuId = session.getAttribute("mmuId") + "";
	}
	
	String cityId = "0";
	if (session.getAttribute("cityIdUsers") != null) {
		cityId = session.getAttribute("cityIdUsers").toString();
		cityId = cityId.replace(",","");
	}
	
  	String districtId = "0";
	if (session.getAttribute("distIdUsers") != null) {
		districtId = session.getAttribute("distIdUsers").toString();
		districtId = districtId.replace(",","");
	}
  
  SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); 

	Calendar c = Calendar.getInstance(); 
	Date startDate = c.getTime();
	String currentDate=formatter.format(startDate); 
%>
 
<script type="text/javascript" language="javascript">

var nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function(){
	if(<%=departmentId%>!=0){
		$("#btnSearch").attr("disabled", false);
		$("#btnShowAll").attr("disabled", false);
			getOpeningBalanceWatingList('ALL');
	}else{
		alert("Select the department");
		return false;
	}
	
		});
		
		
 function search(){
	var nPageNo=1;	
	var fromDate = $j('#fromDate').val();
	var toDate = $j('#ToDate').val();
	if((fromDate == undefined || fromDate == '') && (toDate == undefined || toDate == '')){	
		alert("At least one option must be entered");
		return;
	}
	
	getOpeningBalanceWatingList('FILTER');
	
} 

 function getOpeningBalanceWatingList(MODE) { 	
	 var fromDate=$j('#fromDate').val();
	 var toDate= $j('#ToDate').val();
	 var departmentId = $j('#departmentId').val();
		 if(MODE == 'ALL'){
			 var data = {"mmuId": "<%= mmuId %>","cityId": "<%= cityId %>","districtId": "<%= districtId %>", "departmentId":"<%=departmentId%>","fromDate":fromDate,"toDate":toDate, "pageNo":nPageNo};				
			}
		else
			{
			var data = {"mmuId": "<%= mmuId %>","cityId": "<%= cityId %>","districtId": "<%= districtId %>","departmentId":"<%=departmentId%>","fromDate":fromDate,"toDate":toDate, "pageNo":nPageNo};
			} 
		 
		var url = "getOpeningBalanceWatingList";		
		var bClickable = true;
		GetJsonData('tblopBalanceWatingList',data,url,bClickable);
 }
 
 function makeTable(jsonData)
 {
	  var htmlTable = "";
	    if(jsonData.status==1){
	    var data = jsonData.count;
	    var dataList = jsonData.waitingDataList;
	    var watingStatus='';
	    for(i=0;i<dataList.length;i++){
	    	if(dataList[i].opBalanceStatus!='undefine' && (dataList[i].opBalanceStatus=='o' || dataList[i].opBalanceStatus=='O')){
	    		watingStatus="Pending for Approval";
	    	}
	    	htmlTable = htmlTable + "<tr id='" + dataList[i].Id + "'>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[i].balanceNo + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[i].balanceDate + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[i].departmentName + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + watingStatus + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[i].submitBy + "</td>";
	    }
	    	$j("#tblopBalanceWatingList").html(htmlTable);
	  }else{
			htmlTable = htmlTable
				+ "<tr ><td colspan='9'><h6>No Record Found !!</h6></td></tr>";
		   $j("#tblopBalanceWatingList").html(htmlTable);
	  }
 	
 }
 
 
 function executeClickEvent(Id)
 {
	 window.location="openingBalanceApproval?headerId="+Id+"";
 }
 
 function showResultPage(pageNo) 	
 {
 	
 	nPageNo = pageNo;	
 	getOpeningBalanceWatingList('FILTER');
 	
 }
 
 function ResetForm()
 {	
	 $('#fromDate').val("");
	 $('#ToDate').val(""); 
 }
 
 
 function showAll()
 {
	ResetForm();
 	nPageNo = 1;	
 	getOpeningBalanceWatingList('ALL');
 	
 }
 
 function compareDate(){
	 var fromDate = $('#fromDate').val();
	 var toDate = $('#ToDate').val();
	 
	 if(process(toDate) < process(fromDate)){
			alert("To Date should not be earlier than from Date");
			$('#ToDate').val("");
			return;
	 }
}

</script>
 <body>
  <!-- Begin page -->
    <div id="wrapper">
 
 <div class="content-page">
                                <!-- Start content -->
 <div class="">
  <div class="container-fluid">
	 
	  <div class="internal_Htext">Opening Balance Approval List</div>
	 
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">

                                     <div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">From Date</label>
												<div class="col-sm-7">
												<div class="dateHolder">
													<input  type="text"  class="noFuture_dateStore form-control" id="fromDate"
														 name="fromDate" placeholder="DD/MM/YYYY"   value="<%=currentDate %>" maxlength="10"></div> 
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">To Date</label>
												<div class="col-sm-7">
												<div class="dateHolder">
													<input type="text"   class="noFuture_dateStore form-control" id="ToDate"
														 name="ToDate" placeholder="DD/MM/YYYY"  value="<%=currentDate %>" maxlength="10"></div>
												</div>
											</div>
										</div>
										<input  type="hidden" class="form-control" id="departmentId" name="departmentId" value="<%=departmentId %>"/>
										<div class="col-md-1">
											<div class="form-group row">
												
												<div class="col-sm-10">
													<button disabled type="button" id="btnSearch" class="btn btn-primary" onclick="search()">Search</button>
												</div>
											</div>
										</div>
										
										
										<div class="col-md-3">
										<div class="btn-right-all">
												<button disabled type="button" class="btn  btn-primary" id="btnShowAll"
													onclick="showAll('ALL');">Show All</button>
												</div>
											 
										</div>
										<div class="col-md-3">
										</div>
                                    </div>
								<div style="float: left">

									<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatus" style="font-size: 15px;"
												align="left">Search Results</td>
											<td>
												
											</td>
										</tr>
									</table>
								</div>
								<div style="float: right">
									<div id="resultnavigation"></div>
								</div>


								<table class="table table-hover table-bordered">
                                        <thead class="bg-primary" style="color:#fff;">
                                            <tr>
                                                <th id="th1">Balance No.</th>
                                                <th id="th2">Opening Balance Date </th>
                                                <th id="th3">Department</th>
                                                <th id="th4">Status</th>
                                                <th id="th5">Submitted By</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tblopBalanceWatingList">
                                        </tbody>
                                    </table>
						
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
</html>