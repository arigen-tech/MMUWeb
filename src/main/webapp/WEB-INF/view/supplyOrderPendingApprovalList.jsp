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
		$j("#supplyOrderpendApprovalList :input").attr("disabled", false);
		searchSupplyOrderList('ALL');
	}else{
		$j("#supplyOrderpendApprovalList :input").attr("disabled", true);
		alert("Please select the department.");
		return;
	}
	
});

function search(){
	var vendorId = $('#vendorId').val();
	if(vendorId!=0){
		searchSupplyOrderList('MODE');
	}else{
		alert("Please select vendor name.");
		return ;
	}
}

function searchSupplyOrderList(MODE) { 
	$j("#tblSupplyOrderList").empty();
	var nPageNo=1;
	var hospitalId = $('#hospitalId').val();
	var departmentId = $('#departmentId').val();
	var vendorId = $('#vendorId').val();
	
		 if(MODE == 'ALL'){
			 var data = {"hospitalId": hospitalId,"departmentId":departmentId, "pageNo":nPageNo};				
			}
		else
			{
				var data = {"hospitalId": hospitalId,"departmentId":departmentId,"vendorId":vendorId,"pageNo":nPageNo};
			}
		 
		var url = "getSupplyOrderWaitingListForPendingApproval";		
		var bClickable = true;
		GetJsonData('tblSupplyOrderList',data,url,bClickable);
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
	
	var tData=response.storePoMData;
	var htmlTable = "";
	var watingStatus='';
	if(response.status=1){
		for(counter in tData){
			count = parseInt(counter)+1;
			if(tData[counter].status!='undefine' && (tData[counter].status=='s' || tData[counter].status=='S')){
	    		watingStatus="Pending for Approval";
	    	}
			 var currentYear = new Date().getFullYear();
			 
	    	htmlTable = htmlTable + "<tr id='" + tData[counter].poMId + "'>";
	    	htmlTable = htmlTable + "<td>"+count+"</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + tData[counter].soNo + "</td>";
	    	/* htmlTable = htmlTable + "<td style='width: 150px;'>" + tData[counter].year + "</td>"; */
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + currentYear + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + tData[counter].soDate + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + tData[counter].quotationNo + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + tData[counter].supplierName + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + tData[counter].preparedBy + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + watingStatus + "</td>";
	    	
	    }
		  $j("#tblSupplyOrderList").html(htmlTable);
	}else{
		 $j("#tblSupplyOrderList").html("");
	}
	
	
}

function executeClickEvent(Id){
	var flag='A'
	 window.location="supplyOrderApproval?headerId="+Id+"&flag="+flag+"";
}
</script>
<body>

	<!-- Begin page -->
	<div id="wrapper">


		<div class="content-page">
			<!-- Start content -->
			<div id="supplyOrderpendApprovalList" class="">
				<div class="container-fluid">
					<div class="internal_Htext">Supply order pending list for approval</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									
									<div class="row">
										<div class="col-md-5">
											<div class="form-group row">
												<div class="col-md-4">
													<label class="col-form-label">Vendor Name</label>
												</div>
												<div class="col-md-7">
													<select class="form-control" id="vendorId" name="vendorId">
														<option value="0" selected="selected">Select</option>
													</select>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-12">
													<button class="btn btn-primary" onclick="search()">Search</button>
													<button type="button" class="btn  btn-primary " onclick="searchSupplyOrderList('ALL');">Show All</button>
												</div>
											</div>
										</div>
										<input type="hidden" class="form-control" id="hospitalId" name="hospitalId"  value="<%=session.getAttribute("hospital_id")%>">
									    <input type="hidden" class="form-control" id="departmentId" name="departmentId" value="<%=departmentId %>" /> 
									</div>
									<div style="float: left">
									<table class="tblSearchActions" >
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
									<table class="table table-hover table-striped table-bordered m-b-20">
										<thead class="bg-primary">
											<tr>
												<th>S.No.</th>
												<th>Supply Order No.</th>
												<th>Year</th>
												<th>SO Date</th>
												<th>Quotation No.</th>
												<th>Vendor Name</th>
												<th>Prepared By</th>
												<th>Status</th>
											</tr>
										</thead>
										<tbody id="tblSupplyOrderList">
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

</body>

</html>