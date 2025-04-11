<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Indian Coast Guard</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>
</head>

<%
long departmentId = 0;
if (session.getAttribute("department_id") != null) {
 departmentId = Long.parseLong(session.getAttribute("department_id").toString());
}
%>
<script>
var nPageNo=1;
$j(document).ready(function() {
	if(<%=departmentId%>!=0){
		$j("#rvAgainstSoForm :input").attr("disabled", false);
		searchRvAgainstSoList('ALL');
	}else{
		$j("#rvAgainstSoForm :input").attr("disabled", true);
		alert("Select the department");
		return false;
	}
	
});

function search(){
	var nPageNo=1;			
 	var fromDate = $j('#fromDate').val();
 	var toDate = $j('#toDate').val();
 	var vendorId = $('#vendorId').val();
 	var soNo= $('#soNo').val();
	if((fromDate == undefined || fromDate == '') && (toDate == undefined || toDate == '') 
			&& (vendorId == undefined || vendorId == '0' ) && (soNo == undefined || soNo == '0' )){	
		alert("Fill atleast one field");
		return;
	}else{
		searchRvAgainstSoList('FILTER');
	}
}

function searchRvAgainstSoList(MODE){
	$j('#tblRvAgainstSo').empty();
	var hospitalId = $('#hospitalId').val();
	var departmentId = $('#departmentId').val();
	var vendorId = $('#vendorId').val();
	var fromDate= $('#fromDate').val();
	var toDate= $('#toDate').val();
	var soNo= $('#soNo').val();
	
		 if(MODE == 'ALL'){
			 var data = {"hospitalId": hospitalId,"departmentId":departmentId, "pageNo":nPageNo};				
			}
		else
			{
			var data = {"hospitalId": hospitalId,"departmentId":departmentId,"vendorId":vendorId,"fromDate":fromDate,"toDate":toDate,"soNo":soNo,"pageNo":nPageNo};
			} 
		 
		var url = "getRVWaitingListSo";		
		var bClickable = true;
		GetJsonData('tblRvAgainstSo',data,url,bClickable);
	
}

function makeTable(response){
	var supplierValue='';
	document.getElementById("vendorId").options.length = 1
	for(count in response.supplierData){
		supplierValue += '<option value='+response.supplierData[count].supplierId+'>'
		+ response.supplierData[count].supplierName
		+ '</option>';
	}
	$j('#vendorId').append(supplierValue);
	
	
	var poNumberValue='';
	document.getElementById("soNo").options.length = 1
	for(count in response.poNumberData){
		poNumberValue += '<option value='+response.poNumberData[count].poNumber+'>'
		+ response.poNumberData[count].poNumber
		+ '</option>';
	}
	$j('#soNo').append(poNumberValue);
	
	var tData=response.storePoMData;
	var htmlTable = "";
	for(counter in tData){
		count = parseInt(counter)+1;
		
		if(tData[counter].receivedStatus!='undefine' && (tData[counter].receivedStatus=='p' || tData[counter].status=='P')){
			receivedStatus="Partially Received";
    	}else{
    		receivedStatus="New";
    	}
		
    	htmlTable = htmlTable + "<tr id='" + tData[counter].poMId + "'>";
    	htmlTable = htmlTable + "<td style='width: 100px;'>"+count+"</td>";
    	htmlTable = htmlTable + "<td style='width: 150px;'>" + tData[counter].soNo + "</td>";
    	htmlTable = htmlTable + "<td style='width: 150px;'>" + tData[counter].soDate + "</td>";
    	htmlTable = htmlTable + "<td style='width: 150px;'>" + tData[counter].supplierName + "</td>";
    	htmlTable = htmlTable + "<td style='width: 150px;'>" + tData[counter].deliveryDate + "</td>";
    	htmlTable = htmlTable + "<td style='width: 150px;'>" + tData[counter].approvedBy + "</td>";
    	htmlTable = htmlTable + "<td style='width: 150px;'>" + receivedStatus + "</td>";
    	
    }
	  $j("#tblRvAgainstSo").html(htmlTable);
}

function executeClickEvent(Id)
{
	 window.location="rvDetailsAgainstSo?headerId="+Id+"";
}

function showResultPage(pageNo) 	
{
	nPageNo = pageNo;	
	searchRvAgainstSoList('FILTER');
	
}

</script>

<body>
	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">RV Waiting List Against SO</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<form id="rvAgainstSoForm">
									<div class="row">
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">From Date</label>
												</div>
												<div class="col-md-7">
													<div class="dateHolder">
														<input type="text" class="calDate datePickerInput form-control minwidth120"
														placeholder="DD/MM/YYYY" value="" maxlength="10" id="fromDate" name="fromDate"/>
													</div>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">To Date</label>
												</div>
												<div class="col-md-7">
													<div class="dateHolder">
														<input type="text" class="calDate datePickerInput form-control minwidth120"
														placeholder="DD/MM/YYYY" value="" maxlength="10" id="toDate" name="toDate"/>
													</div>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">SO No.</label>
												</div>
												<div class="col-md-7">
													<select class="form-control" id="soNo" name="soNO">
														<option value="0" selected="selected">Select</option>
													</select>
												</div>
											</div>
										</div>
										
										<div class="col-md-5">
											<div class="form-group row">
												<div class="col-md-4">
													<label class="col-form-label">Vendor Name</label>
												</div>
												<div class="col-md-8">
													<select class="form-control" id="vendorId" name="vendorId">
														<option value="0" selected="selected">Select</option>
													</select>
												</div>
											</div>
										</div>
										
										<div class="col-7 text-right">
											<button type="button" class="btn btn-primary" onclick="search()">Search</button>
											<button type="button" class="btn  btn-primary " onclick="searchRvAgainstSoList('ALL');">Show All</button>
										</div>
										
										<input type="hidden" class="form-control" id="hospitalId" name="hospitalId"  value="<%=session.getAttribute("hospital_id")%>">
									    <input type="hidden" class="form-control" id="departmentId" name="departmentId" value="<%=departmentId %>" /> 
									</div>
									
									<div style="float: left">
										<table class="tblSearchActions" >
											<tr>
											<td class="SearchStatus" style="font-size: 15px;"
												align="left">Search Results</td>
											<td></td>
											</tr>
									</table>
								</div>
								<div style="float: right">
									<div id="resultnavigation"></div>
								</div>
									<table class="table table-hover table-striped table-bordered m-t-10">
										<thead class="bg-primary">
											<tr>
												<th>S.No.</th>
												<th>SO No</th>
												<th>SO Date</th>
												<th>Vendor Name</th>
												<th>Delivery Date</th>
												<th>Approved By</th>
												<th>Status</th>
											</tr>
										</thead>
										<tbody id="tblRvAgainstSo">
										</tbody>
									</table>
									</form>
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

	<script type="text/javascript">
	
	$(function(){
		
		$('.longLabel').on('click',function(){
			var $this = $(this);
			
			if ($this.hasClass('clicked')){
				console.log('class removed');
				$this.removeClass('clicked');
			}
			else{
				$this.addClass('clicked');
			}
		});

		
	});
	
		  

	</script>
</body>

</html>