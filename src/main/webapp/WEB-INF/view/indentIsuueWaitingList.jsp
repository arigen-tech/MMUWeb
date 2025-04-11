<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
     <%@include file="..//view/leftMenu.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Indent Issue List</title>

<%@include file="..//view/commonJavaScript.jsp" %>
</head>
 
<script type="text/javascript" language="javascript">
<%			
	
	String user_id = "0";
	if (session.getAttribute("user_id") != null) {
		user_id = session.getAttribute("user_id") + "";
	}
	String departmentId = "0";
	if (session.getAttribute("department_id") != null) {
		departmentId  = session.getAttribute("department_id") + "";
		System.out.println("department_id "+departmentId );
	}
	String cityId = "0";
	if (session.getAttribute("cityIdUsers") != null) {
		cityId  = session.getAttribute("cityIdUsers") + "";
	}
	System.out.println("cityId ***********************************  "+cityId);
%>

var nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{
			getIndentIssueList('ALL');
			
		});

 function getIndentIssueList(MODE) { 	
 	
 	var cmdId=0; 	
 	var cityId = "<%= cityId %>";
 	cityId = cityId.replace(",","");
 	var data = {"cityId": cityId, "pageNo":nPageNo};	
 	var bClickable = true;
 	var url = "indentIssueWaitingList";
 	GetJsonData('tblListofIndentIssue',data,url,bClickable);
 }
 
 
 function makeTable(jsonData)
 {	
 	var htmlTable = "";	
 	var data = jsonData.count;
 	var pageSize = 5;
 	var dataList = jsonData.data;
 		
 	for(i=0;i<dataList.length;i++)
 		{	 		
 				
 			htmlTable = htmlTable+"<tr id='"+dataList[i].indentId+"' >";		
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].mmuName+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].indentNo+"</td>";
 			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].indentDate+"</td>";
 			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].status+"</td>";
 			htmlTable = htmlTable+"</tr>";
 			
 		}
 	if(dataList.length == 0)
 		{
 		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
 		   //alert('No Record Found');
 		}			
 	console.log("htmltable "+htmlTable);
 	//alert("tblListOfCommand ::" +htmlTable)
 	$j("#tblListofIndentIssue").html(htmlTable);	
 	
 	
 }
 
 
 function executeClickEvent(Id)
 {
	 window.location="getIndentIssueDetailJSP?Id="+Id+"";
	 
 }
 
 function showResultPage(pageNo) 	
 {
 	
 	nPageNo = pageNo;	
 	getIndentIssueList('FILTER');
 	
 }
 
 function showAll()
 {
 	ResetForm();
 	nPageNo = 1;	
 	getIndentIssueList('ALL');
 	
 }

 function search()
 {
	 	var nPageNo=1;			
		var service_no = $j('#service_no').val();
		var patient_name = $j('#patient_name').val();
		if((service_no == undefined || service_no == '') && (patient_name == undefined || patient_name == '')){	
			alert("Atleast one option must be entered");
			return;
		}
		getIndentIssueList('Filter');
		//ResetForm();
 }
 
 function ResetForm()
 {	
	 $j('#service_no').val('');
	 $j('#patient_name').val('');
 }
</script>
 <body>
  <!-- Begin page -->
    <div id="wrapper">
 <div class="content-page">
                                <!-- Start content -->
 <div class="">
  <div class="container-fluid">
	 
	  <div class="internal_Htext">Indent Issue List</div>
	 
                    <!-- end row -->

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">			

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


								<table class="table table-hover table-striped table-bordered">
                                        <thead class="bg-primary" style="color:#fff;">
                                            <tr>
                                            	<th id="th1">MMU Name</th>
                                                <th id="th2">Indent No.</th>
                                                <th id="th3">Indent Date</th>
                                                <th id="th4"> status</th>
                                            </tr>
                                        </thead>
                                         
                                        <tbody id="tblListofIndentIssue">

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