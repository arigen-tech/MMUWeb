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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<title></title>
<script type="text/javascript">

$j(document).ready(function()
		{
	
	getMMUList('');
	});


function getMMUList(item){
	  var params;
	  if(item != ''){
		  var cityId = item.value;
		  params = {
					"cityId":cityId
			}
	  }else{
		  params = { };
	  }
	 
		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : '${pageContext.servletContext.contextPath}/registration/getMMUList',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(data) {
				if(data.status == true){
					var list = data.list;
					var mmuDrop = '';
					$j('#mmuId').find('option').not(':first').remove();
					for(i=0;i<list.length;i++){
						mmuDrop += '<option id='+list[i].mmuId+' value='+list[i].mmuId+'>'+list[i].mmuName+'</option>';
					}
					$j('#mmuId').append(mmuDrop);
				}
			},
			error : function(data) {
				alert("An error has occurred while contacting the server");
			}
		}); 
	}
	
function exportExcel(){
 	
	 var fromDate = $j("#fromDate").val();
	 var toDate = $j("#toDate").val();
	 var mmuId = $j("#mmuId").val();
	 var e = document.getElementById("mmuId");
	 var mmuName = e.options[e.selectedIndex].text;
	 if(mmuId==''||mmuId==0)
		{
			 alert("Please select MMU");
			 return false;	 
		} 
	 if(fromDate ==''){
		 alert("Please select from Date");
		 return false;
	 }
	 if(toDate ==''){
		 alert("Please select to Date");
		 return false;
	 }
	 
	 		
   window.location.href =  "${pageContext.request.contextPath}/mis/exportExcelAiReport?fromDate="
			+ fromDate
			+ "&toDate="
			+toDate
			+ "&mmuId="
			+ mmuId
			+ "&mmuName="
			+ mmuName;	
 
 }
 
function compareDate(){
	
	
	var fdate = $('#fromDate').val();
	var tdate = $('#toDate').val();
	//alert(fdate);
	if(fdate != '' && tdate != ''){
	var fromDate = new Date(fdate.substring(6), (fdate
			.substring(3, 5) - 1), fdate.substring(0, 2))
	var toDate = new Date(tdate.substring(6), (tdate
			.substring(3, 5) - 1), tdate.substring(0, 2))
	
	if (toDate < fromDate  ) {
		alert("To date should not be earlier than the From date");
		$j('#toDate').val('');
		$j('#fromDate').val('');
		return false;
	}
	}
}	

function compareToDate(){
	
	
	var fdate = $('#fromDate').val();
	var tdate = $('#toDate').val();
	//alert(fdate);
	if(fdate != '' && tdate != ''){
	var fromDate = new Date(fdate.substring(6), (fdate
			.substring(3, 5) - 1), fdate.substring(0, 2))
	var toDate = new Date(tdate.substring(6), (tdate
			.substring(3, 5) - 1), tdate.substring(0, 2))
	
	if (fromDate > toDate) {
		alert("From Date should not be greater than To Date");
		$j('#fromDate').val('');
		$j('#toDate').val('');
		return false;
	}
	}
}	

</script>
</head>

<body>
 <!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">AI Audit Report </div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
									
	                               	<div class="col-lg-3 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">MMU</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="mmuId">
												<option value="0">Select</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-lg-3 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">From Date</label>
											</div>
											<div class="col-md-7">
											<div class="dateHolder">
												<input type="text" name="fromDate" id="fromDate" onchange="compareToDate();" class="calDate form-control" value="" placeholder="DD/MM/YYYY" >
											</div>
											</div>
										</div>
									</div>
									<div class="col-lg-3 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">To Date</label>
											</div>
											<div class="col-md-7">
											<div class="dateHolder">
												<input type="text" name="toDate" id="toDate" onchange="compareDate();"  class="calDate form-control" value="" placeholder="DD/MM/YYYY" >
											</div>
											</div>
										</div>
									</div>
									

									<div class="col-lg-3 col-sm-6">
										
										<button type="button" class="btn btn-primary m-t-3" onclick="exportExcel()">Generate Report</button>
										
									</div>
								</div>
								
							
							
							<!-- <div class="m-t-20">
								
								
								<div class="table-responsive">
									<table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th rowspan="2">Patient Name</th>
                                                <th rowspan="2">Age</th>
                                                <th rowspan="2">Gender</th>
                                                <th rowspan="2">Mobile No.</th>
                                                <th rowspan="2">OPD Date</th>
                                                <th rowspan="2">Doctor Name</th>
                                                <th rowspan="2">Signs &amp; Symptoms</th>
                                                <th rowspan="2">Diagnosis</th>
                                                <th rowspan="2">Treatment</th>
                                                <th rowspan="2">Investigation</th>
                                                <th colspan="3" class="text-center">AI based Action</th>
                                                <th rowspan="2">Final Observation</th>
                                            </tr>
                                            <tr>
                                                <th>Diagnosis</th>
                                                <th>Treatment</th>
                                                <th>Investigation</th>
                                            </tr>
                                        </thead>
	                                        
	                                     <tbody>
											 <tr>
											 	<td>Name 1</td>
											 	<td>22</td>
											 	<td>Male</td>
											 	<td>9874563210</td>
											 	<td>1/7/2022</td>
											 	<td>Aman</td>
											 	<td>Sign 1,Sign 2</td>
											 	<td>D1, D2</td>
											 	<td>T1, T2</td>
											 	<td>I1, I2</td>
											 	<td>Exception</td>
											 	<td>Accept</td>
											 	<td>Accept</td>
											 	<td>Accept</td>										 	
											 </tr>
											 <tr>
											 	<td>Name 1</td>
											 	<td>22</td>
											 	<td>Male</td>
											 	<td>9874563210</td>
											 	<td>1/7/2022</td>
											 	<td>Vivek</td>
											 	<td>Sign 1,Sign 2</td>
											 	<td>D1, D2</td>
											 	<td>T1, T2</td>
											 	<td>I1, I2</td>
											 	<td>Exception</td>
											 	<td>Accept</td>
											 	<td>Accept</td>
											 	<td>Accept</td>										 	
											 </tr>
	                     				 </tbody>
	                                    </table>
								</div>
							</div>	 -->
								
						
                             
							</div>
						</div>
						
						
						<!-- end card -->
					</div>
					<!-- end col -->
				</div>
				<!-- end row -->

			</div>
			<!-- container -->
			<!-- content -->
		</div>
	</div>
	<!-- END wrapper -->


</body>

</html>



