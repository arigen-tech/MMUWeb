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
$j(document).ready(function() {
	var deptId="<% out.print(departmentId);%>";
	if(deptId!=0){
		$j("#formSupplyOrder :input").attr("disabled", false);
		var SanctionValues = "";
		var data = ${jsonResponse};
		if(data.status=="1"){
			 for(count in data.storeSoMData){
				 SanctionValues += '<option value='+data.storeSoMData[count].soMId+'>'
								+ data.storeSoMData[count].soMSanctionNo
								+ '</option>';
			 }
			 $j('#sanctionId').append(SanctionValues); 	  
		  
		}else{
			alert("No Sanction List is pending.");
			return ;
		}
		
		stockistValue='';
		for(count in data.supplierTypeData){
			stockistValue += '<option value='+data.supplierTypeData[count].supplierTypeId+'>'
			+ data.supplierTypeData[count].supplierTypeName
			+ '</option>';
		}
		 $j('#stockistId').append(stockistValue);
		
		 
		 yearValue='';
		 for(count in data.financialYearData){
				yearValue += '<option value='+data.financialYearData[count].id+'>'
				+ data.financialYearData[count].name
				+ '</option>';
			}
			 $j('#yearId').append(yearValue);
		 
		 
		 
		var date = currentDateInddmmyyyy();
		$('#soDate').val(date);
		$('#deliveryDate').val(date);	
	}else{
		$j("#formSupplyOrder :input").attr("disabled", true);
		alert("Please select the department.");
		return;
	}

	
});


function setSoValues(soMId){
	$j("#tblSoItem").empty();
	$j('#tableSoItemDiv').hide();
	$j('#btnDiv').hide();
	if(soMId!=0){
	 var params={
				"soMId":soMId
			   }
	 $j.ajax({
			type : "POST",
			contentType : "application/json",
			url : 'getSupplyOrderSanctionData',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(response) {
				var mData=response.stockSoMData;
				var tData=response.stockSoTData;
				for(count in mData){
					$j('#rfp_no').val(mData[count].rfpNo);
					$j('#quotationNo').val(mData[count].quotationNo);
					$j('#quotationMId').val(mData[count].quotationMId);
					$j('#vendorName').val(mData[count].vendor);
					$j('#vendorId').val(mData[count].vendorId);
					$j('#stockistId').val(mData[count].stockistId);
					$j('#storeSoMId').val(mData[count].soMId);
				}
				
				var htmlTable = "";
				for(counter in tData){
					count = parseInt(counter)+1;
			    	htmlTable = htmlTable + "<tr id='" + tData[counter].soTId + "'>";
			    	htmlTable = htmlTable + "<td>"+count+"</td>";
			    	htmlTable = htmlTable + "<td style='display:none'><input type='hidden' name='stockSoT' value='"+tData[counter].soTId +"'/></td>";
			    	htmlTable = htmlTable + "<td style='display:none'><input type='hidden' name='itemId' value='"+tData[counter].itemId +"'/></td>";
			    	htmlTable = htmlTable + "<td style='display:none'><input type='hidden' name='quotationTId' value='"+tData[counter].quotationTId +"'/></td>";
			    	htmlTable = htmlTable + "<td >"+tData[counter].pvmsNumber +"</td>";
			    	htmlTable = htmlTable + "<td >"+tData[counter].nomenclature +"</td>";
			    	htmlTable = htmlTable + "<td >"+tData[counter].au +"</td>";
			    	htmlTable = htmlTable + "<td ><input readonly type='text' class='noStyleInput width50' name='qty' value='"+tData[counter].qtyRequired +"'/></td>";
			    	htmlTable = htmlTable + "<td ><input readonly type='text' class='noStyleInput width50' name='unitRate' value='"+tData[counter].unitRate +"'/></td>";
			    	htmlTable = htmlTable + "<td ><input readonly type='text' class='noStyleInput width50' name='amtValue' value='"+tData[counter].amtValue +"'/></td>";
			    }
			  $j("#tblSoItem").html(htmlTable);
			  $j('#tableSoItemDiv').show();
			  $j('#btnDiv').show();

			},
			error : function(msg) {
				alert("An error has occurred while contacting the server");
			}
		});
	}
}

function saveSODetails(submitType){
	var value=validateFields("formSupplyOrder");
	if(value==true){
		$j('#requestType').val(submitType);
		document.formSupplyOrder.action="saveSODetails";
		document.formSupplyOrder.method="POST";
		document.formSupplyOrder.submit(); 
	}else{
		alert(value.split('\n')[0]);
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
					<div class="internal_Htext">Create Supply Order</div>
					<div class="row">
						<div class="col-12">
							<div class="card"> 
							<form id="formSupplyOrder" name="formSupplyOrder">
								<div class="card-body">
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Sanction No.<span class="text-red">*</span></label>
												</div>
												<div class="col-md-6">
													<select class="form-control" id="sanctionId" name="sanctionId" onchange="setSoValues(this.value)" validate="Sanction No.,string,yes">
														<option value="0" selected="selected">Select</option>
													</select>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">RFP No.<span class="text-red">*</span></label>
												</div>
												<div class="col-md-6">
													<input readonly type="text" class="form-control" id="rfp_no" name="rfp_no" validate="RFP No.,string,yes"/>
												</div>
											</div>
										</div>
										
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Year<span class="text-red">*</span></label>
												</div>
												<div class="col-md-6">
													<select class="form-control" id="yearId" name="yearId"  validate="year,string,yes">
														<option value="0" selected="selected">Select</option>
													</select>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">SO Date<span class="text-red">*</span></label>
												</div>
												<div class="col-md-6">
													<div class="dateHolder">
														<input  type="text" id="soDate" name="soDate" class="calDate datePickerInput form-control minwidth120"
														placeholder="DD/MM/YYYY" value="" maxlength="10" />
													</div>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Delivery Date<span class="text-red">*</span></label>
												</div>
												<div class="col-md-6">
													<div class="dateHolder">
														<input  type="text" id="deliveryDate" name="deliveryDate" class="calDate datePickerInput form-control minwidth120"
														placeholder="DD/MM/YYYY" value="" maxlength="10" />
													</div>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Quotation No.</label>
												</div>
												<div class="col-md-6">
													<input readonly type="text" class="form-control" id="quotationNo" name="quotationNo"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Vendor Name</label>
												</div>
												<div class="col-md-6">
													<input readonly type="text" class="form-control" id="vendorName" name="vendorName"/>
													<input type="hidden" class="form-control" id="vendorId" name="vendorId"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Stockist Distributor</label>
												</div>
												<div class="col-md-6">
													<select class="form-control" id="stockistId" name="stockistId">
														<option value="0" selected="selected">Select</option>
													</select>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Tax Details<span class="text-red">*</span></label>
												</div>
												<div class="col-md-6">
													<textarea class="form-control" rows="2" id="taxDetails" name="taxDetails" validate="Tax Details,string,yes"></textarea>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Delivery Schedule<span class="text-red">*</span></label>
												</div>
												<div class="col-md-6">
													<textarea class="form-control" rows="2" id="deliverySchedule" name="deliverySchedule"  validate="Delivery Schedule,string,yes"></textarea>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Payment Terms<span class="text-red">*</span></label>
												</div>
												<div class="col-md-6">
													<textarea class="form-control" rows="2" id="paymentTerm" name="paymentTerm" validate="Payment Term,string,yes"></textarea>
												</div>
											</div>
										</div>
									</div>
									
									<div id="tableSoItemDiv" style="display: none">
									<table class="table table-hover table-striped table-bordered m-t-10" >
										<thead class="bg-primary">
											<tr>
												<th>S.No.</th>
												<th>PVMS No/NIV No</th>
												<th>Nomenclature</th>
												<th>A/U</th>
												<th>Qty Required</th>
												<th>Unit Rate</th>
												<th>Value</th>
											</tr>
										</thead>
										<tbody id="tblSoItem">
										</tbody>
									</table>
									</div>
									<div class="row m-t-10" id="btnDiv"  style="display: none">
										<div class="col-12 text-right">
											<input type="button" class="btn btn-primary" id="btnSubmit"
														value="Save" onclick="saveSODetails('e')" />
											<input type="button" class="btn btn-primary" id="btnSubmit"
														value="Submit" onclick="saveSODetails('s')" />
										</div>
										<input  type="hidden" class="form-control" id="requestType" name="requestType" value=""/>
										<input type="hidden" class="form-control" id="userId"  name="userId"  value="<%=session.getAttribute("user_id")%>">
										<input type="hidden" class="form-control" id="hospitalId" name="hospitalId"  value="<%=session.getAttribute("hospital_id")%>">
									    <input type="hidden" class="form-control" id="departmentId" name="departmentId" value="<%=departmentId %>" /> 
									    <input type="hidden" class="form-control" id="storeSoMId" name="storeSoMId" />
									    <input type="hidden" class="form-control" id="quotationMId" name="quotationMId" />
									    
									</div>
									</div>
						</form>
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