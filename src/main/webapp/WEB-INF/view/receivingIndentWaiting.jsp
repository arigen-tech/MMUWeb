<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
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
<title></title>
</head>

<%
String mmuId = "0";
if (session.getAttribute("mmuId") != null) {
	mmuId = session.getAttribute("mmuId") + "";
}
String userId = "0";
if (session.getAttribute("userId") != null) {
	userId = session.getAttribute("userId") + "";
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

		getReceivingIndentWaitingList('ALL');
			
	});
		
		
 function search(){
	var nPageNo=1;	
	var indentNo=$j('#indentNo').val();
	var fromDate = $j('#fromDate').val();
	var toDate = $j('#toDate').val();
	if(( indentNo==undefined || indentNo == '') && ((fromDate == undefined || fromDate == '') && (toDate == undefined || toDate == ''))){	
		alert("At least one option must be entered");
		return;
	}
	getReceivingIndentWaitingList('FILTER');
	ResetForm();
} 

 function getReceivingIndentWaitingList(MODE) {
	 
		 if(MODE == 'ALL'){
			 var data = {"mmuId":"<%= mmuId %>","pageNo":nPageNo};				
			}
		else
			{
			var data = {"mmuId":"<%= mmuId %>","pageNo":nPageNo}; 
			} 
		var url = "getReceivingIndentWaitingList";		
		var bClickable = true;
		GetJsonData('tblReceiveWatingList',data,url,bClickable);
 }
 
 function makeTable(jsonData)
 {
	  var htmlTable = "";
	    if(jsonData.status==1){
	    var data = jsonData.count;
	    var dataList = jsonData.waitingListData;
	    var watingStatus='';
	    for(item=0;item<dataList.length;item++){
	     	htmlTable = htmlTable + "<tr id='" + dataList[item].Id + "&"+dataList[item].storeIssueMId+"'>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].indentNo + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].indentDate + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].issueNo + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].issueDate + "</td>";
	    }
	    $j("#tblReceiveWatingList").html(htmlTable);
	  }else{
		  $j("#tblReceiveWatingList").html("");
	  }
 	
 }
 
 function executeClickEvent(Id)
 {
	 var idArr = Id.split("&");
	 window.location="receivingIndentInInventory?id="+idArr[0]+"&storeIssueMId="+idArr[1]+"";
 }
 
 function showResultPage(pageNo) 	
 {
 	
 	nPageNo = pageNo;	
 	getReceivingIndentWaitingList('FILTER');
 	
 }
 
 function ResetForm()
 {	
 	
 }
 
 
 function showAll()
 {
	ResetForm();
 	nPageNo = 1;	
 	getReceivingIndentWaitingList('ALL');
 	
 }
 
</script>
 <body>
  <!-- Begin page -->
    <div id="wrapper">
	 <div class="content-page">
                                <!-- Start content -->
 <div class="">
  <div class="container-fluid">
	 
	  <div class="internal_Htext">Indent Receiving</div>
	 
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">

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
                                                <th id="th1">Indent No.</th>
                                                <th id="th2">Indent Date </th>
                                                <th id="th3">Issue No.</th>
                                                <th id="th4">Issue Date</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tblReceiveWatingList">
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