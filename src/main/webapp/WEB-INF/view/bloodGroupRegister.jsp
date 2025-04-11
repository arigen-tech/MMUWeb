<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<head>
<%
	String hospitalId = "1";
	if (session.getAttribute("hospital_id") != null) {
		hospitalId = session.getAttribute("hospital_id") + "";
	}
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
		
	
%>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<title>Asha Application</title>
<!--   <link href="/AshaWeb/resources/css/stylecommon.css" rel="stylesheet" type="text/css" /> -->



</head>

<%
	int i = 1;
%>

<body>
<div id="wrapper">
	<div class="content-page">
		<!-- Start content -->

		<div class="container-fluid">
			<div class="internal_Htext">Blood Group Register</div>
			<form name="frm">			
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-body">	
								
							<div class="row">								
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Blood Group</label>
										</div>
										<div class="col-md-7">
											<select class="form-control" id="bloodGroup" name="bloodGroup">
												<option value="0">All</option>
											</select>
										</div>
									</div>															
								</div>
								
								<div class="col-md-4">
							                            <div class="form-group row">							                                
							                                <label class="col-md-5 col-form-label">Unit</label>
							                                <div class="col-md-7">
							                                    <select class="form-control" id="unitId" name="unitId">
							                                    <option value="0">Select</option>
							                                    </select>
							                                </div>
							                            </div>
							                        </div>
							                        
							                        <div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Service Number</label>
										</div>
										<div class="col-md-7">
											<input type="text" id="serviceNo" name="serviceNo" class="form-control " />
											
										</div>
									</div>															
								</div>
								
								<div class="col-md-4">
							                            <div class="form-group row">							                                
							                                <label class="col-md-5 col-form-label"> Emp Name</label>
							                                <div class="col-md-7">
							                                    <input type="text" id="empName" name="empName" class="form-control " />
											
							                                </div>
							                            </div>
							                        </div>
								
								
								<div class="col-md-1">
									<button class="btn btn-primary" id="searhAppointment" type="button" onclick="searchRequest()">Search</button>													
								  
								</div>
								<div class="col-md-3 text-right">
									<button id='printBtn1' type='button' class='btn btn-primary' onclick='showAll();'>Show All</button>
									<button id="printReportButton" type="button" class="btn btn-primary" onclick="makeUrl()">Report</button>
									<a class="btn btn-primary" role="button" href="${pageContext.request.contextPath}/miAdmin/createBloodGroupRegister">New Entry</a>
																						
								</div>
										
								</div>						
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
														<th>S.No</th>												
														<th>Name</th>
														<th>Service No</th>
														<th>Unit</th>
														<th>Rank</th>												
														<!-- <th>Relation</th> -->
														<th>Age</th>
														<th>Gender</th>
														<th>Blood group</th>
														<th>Contact No</th>
														<th>Address</th>
												</tr>
											</thead>
											<tbody id="tblListOfBudgetary">
											</tbody>
										</table>							
													
							</div>
								
								
						</div>
					</div>
				</div>
				</form>
			</div>
		</div>

	</div>
</div>

</body>
<script>
	var nPageNo=1;
	var Status;
	var $j = jQuery.noConflict();
	
 	$j(document).ready(function()
	{
	 	 //blood group list
		  var bloodGroupValues = "";
	     var bloodGroupDict = ${bloodGroupList}
	     var bloodGroupData = bloodGroupDict.data;
	    
	     for (category in bloodGroupData) {

	    	 bloodGroupValues += '<option  value=' + bloodGroupData[category]  + '>' + category + '</option>';
	     }
	     $j('#bloodGroup').append(bloodGroupValues);
	     
	     //get unit list
	     
	     var unitListValues = "";
	     var unitListDict = ${unitList};
	     var unitListData = unitListDict.data;
	    
	     for (category in unitListData) {

	    	 unitListValues += '<option  value=' +unitListData[category]   + '>' +category + '</option>';
	     }
	     $j('#unitId').append(unitListValues);
	     GetBloodGroupRegister('ALL');
	});
		
function GetBloodGroupRegister(MODE)
{
	
	var unit = $j('#unitId').val();
	var bloodGroup = $j('#bloodGroup').val();
	var serviceNo = $j('#serviceNo').val();
	var empName = $j('#empName').val();
	 if(MODE == 'ALL'){
		 var data = {"PN":nPageNo,"unit":unit,"bloodGroup":bloodGroup,"serviceNo":serviceNo,"empName":empName};		
		}
	else
		{
		var data = {"PN":nPageNo,"unit":unit,"bloodGroup":bloodGroup,"serviceNo":serviceNo,"empName":empName};
		} 
	var url = "getBloodGroupRegister";
		
	var bClickable = false;
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
			  htmlTable = htmlTable + "<tr id='"+dataList[item].name+"' >";	
			  htmlTable = htmlTable + "<td >" +i+ "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].name + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].serviceNo + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].unit + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].rank + "</td>";
	    	  /* htmlTable = htmlTable + "<td >" + dataList[item].relation + "</td>"; */
	    	  htmlTable = htmlTable + "<td >" + dataList[item].age + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].gender + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].blood + "</td>";
		    	 
	    	  htmlTable = htmlTable + "<td >" + dataList[item].contactNo + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].address + "</td>";
	    	 
	    	  htmlTable = htmlTable + "</tr>";
	    i++;
	      }
	if(jsonData.count == 0 || typeof jsonData.count == 'undefined')
		{
		htmlTable = htmlTable+"<tr ><td colspan='10'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblListOfBudgetary").html(htmlTable);	
	
	
}


function showResultPage(pageNo)
{	
	nPageNo = pageNo;	
	GetBloodGroupRegister('FILTER');
	
}


function showAll()
{
	$j('#unitId').val(0);
	$j('#bloodGroup').val(0);
	$j('#serviceNo').val("");
    $j('#empName').val("");
	nPageNo = 1;	
	GetBloodGroupRegister('ALL');
	
}

function searchRequest() {
	nPageNo=1;
 	GetBloodGroupRegister('FILTER');
}

function makeUrl(){
	var unit = $j('#unitId').val();
	var bloodGroup = $j('#bloodGroup').val();
	var serviceNo = $j('#serviceNo').val();
	var empName = $j('#empName').val();
	
	var url="${pageContext.request.contextPath}/report/printBloodGroupReport?bloodGroup="+bloodGroup+"&serviceNo="+serviceNo+"&unitId="+unit+"&empName="+empName;
	openPdfModel(url);
	
}
</script>
</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>