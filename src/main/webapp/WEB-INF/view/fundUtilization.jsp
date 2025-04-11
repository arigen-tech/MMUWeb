<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
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
  <title>Fund Utilization</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <!--  <link href="//resources/css/icons1.css" rel="stylesheet" type="text/css" /> -->
   
</head>
<%			
	String hospitalId = "0";
	if (session.getAttribute("hospital_id") !=null)
	{
		hospitalId = session.getAttribute("hospital_id")+"";
	}
	String user_id = "0";
	if (session.getAttribute("user_id") != null) {
		user_id = session.getAttribute("user_id") + "";
	}

	String departmentId  = "0";
	if (session.getAttribute("department_id") != null) {
		departmentId  = session.getAttribute("department_id") + "";
	}
	
	
%>
<body>
<p align="center" id="messageId" style="color:green; font-weight: bold;" >${message}</p>
	<!-- Begin page -->
	<div id="wrapper">


		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">Fund Utilization</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
							      <form:form name="submitFundUtilization" id="submitFundUtilization" method="post"
										action="${pageContext.request.contextPath}/lpprocess/submitFundUtilization" autocomplete="off">
									
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Year<span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<select id="finYear" name="finYear"
														 class="form-control">
														<option value="0" selected="selected">Select</option>
													</select>
												</div>
											</div>
										</div>

										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Authority No<span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="authorityNo" name="authorityNo"  maxlength="25" />
												</div>
											</div>
										</div>

										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Allotment Date<span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<div class="dateHolder">
														<input type="text"
															class="form-control noFuture_date2"
															name="allotmentDate" id="allotmentDate" placeholder="DD/MM/YYYY"
															validate="From Date,string,yes" value="" maxlength="10"  />
													</div>
												</div>
											</div>
										</div>

										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Amount Allotted<span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="amtAlloted" maxlength="8" onkeypress="if(isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" name="amtAlloted"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Refunded Amount</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" maxlength="8" id="refundedAmt" onkeypress="if(isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" name="refundedAmt" />
													</div>
											</div>
										</div>
										
									</div>
									
									
  									
  									<div class="row">
										<div class="col-md-12 text-right">
											<input type="submit" class="btn btn-primary "
														name="submit" value="Submit" id="saveForm1" onclick="return submitForm();" />
											<button type="reset" id="reset" class="btn  btn-danger"> Reset </button>

										</div>
									</div>
									</form:form>
									 
									 <div class="m-t-10">
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
                                    
					
									</div>

                                    <table class="table table-hover table-striped table-bordered">
                                        <thead class="bg-success" style="color:#fff;">
												<tr>
													<th>Year</th>
													<th>Authority No</th>
													<th>Amount Allotted</th>
													<th>Refunded Amount</th>
													<th>Amount Available</th>
													<th>Action</th>
												
												</tr>
											</thead>
											<tbody id="tblListFundUtilization">
											</tbody>
										</table>
									</div>

								</div>
							</div>
						</div>
					</div>

				</div>
				<!-- container -->

			</div>
			<!-- content -->

		</div>

		<!-- ============================================================== -->
		<!-- End Right content here -->
		<!-- ============================================================== -->

	
<!-- END wrapper -->

 <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title font-weight-bold"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="text-center text-theme text-sm">Loading <i class="fa fa-spin fa-spinner"></i>
        </div>
      </div> 
    </div>
  </div>
</div>
</body>
<script>

var nPageNo=1;
var Status;
var $j = jQuery.noConflict();
$j('#refundedAmt').val(0);
$j(document).ready(function(){
	if(<%=departmentId%>!=0){
		$j("#submitFundUtilization :input").attr("disabled", false);
		 var financialYearList = "";
	     var financialYearListDict = ${financialYearList}
	     for(year in financialYearListDict) {

	    	 financialYearList += '<option  value=' + year + '>' + financialYearListDict[year] + '</option>';
	     } 
	     $j('#finYear').append(financialYearList);
	     getFundUtilization('ALL');
	}else{
		alert("Select the department");
		$j("#submitFundUtilization :input").attr("disabled", true);
		return false;
	}
});
	
function getFundUtilization(MODE)
{

 if(MODE == 'ALL'){
	 var data = {"PN":nPageNo};		
	}
else
	{
	var data = {"PN":nPageNo};
	} 
var url = "getFundUtilizationList";
	
var bClickable = true;
GetJsonData('tblListFundUtilization',data,url,bClickable);
} 

function makeTable(jsonData)
{	
var htmlTable = "";	
var data = jsonData.count;
var i=1;

var pageSize = 5;


var dataList = jsonData.data;

 for(item in dataList){
		  // htmlTable += '<tr id="'+dataList[item].Id+'" onclick="hello('+dataList+')">';
		   htmlTable = htmlTable + "<tr id='"+dataList[item].id+"' >";	
		  htmlTable = htmlTable + "<td >" + dataList[item].year + "</td>";
    	  htmlTable = htmlTable + "<td >" + dataList[item].authorityNo + "</td>";
    	  htmlTable = htmlTable + "<td >" + dataList[item].amountAlloted + "</td>";
    	  htmlTable = htmlTable + "<td >" + dataList[item].refundedAmount + "</td>";
    	  htmlTable = htmlTable + "<td >" + dataList[item].amountAvailable + "</td>";
    	  htmlTable = htmlTable + "<td >"
    	  htmlTable = htmlTable + "&nbsp<input type='button' value='view' tabindex='1' class='btn btn-primary' data-toggle='modal' data-target='#exampleModal'  onclick='viewDetails("+dataList[item].finYearId+");'></td>";
    	  htmlTable = htmlTable + "</tr>";
   
      }
if(jsonData.count == 0 || typeof jsonData.count == 'undefined')
	{
	htmlTable = htmlTable+"<tr ><td colspan='6'><h6>No Record Found</h6></td></tr>";
	   //alert('No Record Found');
	}			

$j("#tblListFundUtilization").html(htmlTable);	


}


function showResultPage(pageNo)
{
nPageNo = pageNo;	
getFundUtilization('FILTER');

}

function submitForm() {
	var finYear=$j('#finYear').val();
	var authorityNo=$j('#authorityNo').val();
	var amtAlloted=$j('#amtAlloted').val();
	var refundedAmt=$j('#refundedAmt').val();
	
	  if (finYear == null || finYear == "" || finYear == 0) {
          alert("Please select Year");
          return false;
      }
	  if (authorityNo == null || authorityNo == "") {
          alert("Please enter authority Number");
          return false;
      }
	  if(document.getElementById('allotmentDate').value == "" || document.getElementById('allotmentDate') == null){
			 alert("Please select allotment Date");
			 return false;
		 }
	  if (amtAlloted == null || amtAlloted == "") {
          alert("Please enter amount allotted");
          return false;
      }
	  if (refundedAmt == null || refundedAmt == "") {
		  $j('#refundedAmt').val(0);
      }
	
		$("#submitFundUtilization").submit();
		 setTimeout(function(){ 			 
			 $("#saveForm1").attr("disabled", "disabled");
			   
		 }, 50);
		
	
}


var status;
var id;
function executeClickEvent(id,jsonData)
{
	var dataList = jsonData.data;
	 for(item in dataList){
		if(id == dataList[item].id){
			id = dataList[item].id;
			
		}
	}
	 //rowClick(status,lpcId);
}


function rowClick(status,lpcId){	
	 window.location.href = "inactivatectmCommittee?lpcId="+lpcId+"&status="+status;
	
}


function viewDetails(yearId) {
	$('#exampleModal .modal-body').load("showFundUtilizationInShownYear?yearId="+yearId);
    $('#exampleModal .modal-title').text('Show Fund Utilization');

}
</script>
</html>