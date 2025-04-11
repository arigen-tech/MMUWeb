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

<script src="${pageContext.request.contextPath}/resources/js/stores.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
</head>
<%

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

%>
<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">Physical Stock Taking Approval List</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
								<form id="stockTakingApproval" name="stockTakingApproval">
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Stock Taking Date</label>
												</div>
												<div class="col-md-7">
													<input type="text" readonly class="form-control" id="stockTakingDate" name="stockTakingDate"/>
												</div>
											</div>
										</div>

										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Stock Taking No.</label>
												</div>
												<div class="col-md-7">
													<input type="text" readonly class="form-control" id="stockTakingNo" name="stockTakingNo"/>
												</div>
											</div>
										</div>

										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Submitted By</label>
												</div>
												<div class="col-md-7">
													<input type="text" readonly class="form-control" id="enterby" name="enterby"/>
												</div>
											</div>
										</div>

										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Reason for Stock Taking<span class="text-red">*</span></label>
												</div>
												<div class="col-md-7">
													<textarea class="form-control" rows="2" id="reasonStockTaking" name="reasonStockTaking" validate="Reason,string,yes"></textarea>
												</div>
											</div>
										</div>

									</div>


									<div class="table-responsive">
									<table
										class="table table-hover table-striped table-bordered m-t-10" id="tblstockTakingApproval">
										<thead class="bg-primary">
											<tr id='th'>
												<th>S.No.</th>
												<th>Drug Code</th>
												<th>Drug Name</th>
												<th>Batch No.</th>
												<th>DOE</th>
												<th>Computed Stock</th>
												<th>Physical Stock</th>
												<th>Surplus</th>
												<th>Deficient</th>
												<th>Remarks</th>
												<th>Add</th>
												<th>Delete</th>
												
											</tr>
										</thead>
										<tbody id="tblstockTakingWatingList">
										</tbody>
									</table>
									</div>
									
									<div class="row m-t-20 ">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Action<span class="text-red">*</span></label>
													</div>
													<div class="col-md-7">
														<select class="form-control" id="actionId" name="actionId" validate="Action,string,yes">
																<option value="0" selected="selected">Select</option>
																<option value="A">Approved</option>
																<option value="R">Rejected</option>
														</select>
													</div>
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-group row">
													<div class="col-md-3">
														<label for="service" class="col-form-label">Remarks<span class="text-red">*</span></label>
													</div>
													<div class="col-md-8 m-l-10">
														<textarea class="form-control" rows="2" id="finalRemarks" name="finalRemarks" validate="Remarks,string,yes"></textarea>
													</div>
												</div>
											</div>									
										</div>
										
										<div class="col-md-4">
										<input type="hidden" class="form-control" id="userId"  name="userId"  value="<%=session.getAttribute("user_id")%>">
										<input type="hidden" class="form-control" id="mmuId" name="mmuId"  value="<%=session.getAttribute("mmuId")%>">
										<input type="hidden" class="form-control" id="cityId" name="cityId"  value="<%= cityId %>">
										<input type="hidden" class="form-control" id="districtId" name="districtId"  value="<%= districtId %>">
										<input type="hidden" class="form-control" id="takingMId" name="takingMId" >
									    <input type="hidden" class="form-control" id="departmentId" name="departmentId" /> 
										<input type="hidden" name="hiddenValueCharge" id="hiddenValueCharge" />
										<input type="hidden"  name="rowCount" id="rowCount" value=""/>
										</div>
										
									<div class="row">
										<div class="col-md-12 text-right">
											<input type="button" class="btn btn-primary" id="btnSubmit"
														value="Submit" onclick="submitStockTakingDataForApproval()" />
										</div>
									</div>

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
	
	
	
<script >
$j(document).ready(function() {
	var jsonResponse = ${jsonResponse};
	var stockTakingM = jsonResponse.stockTakingMData;
	for (count = 0; count < stockTakingM.length; count++) {
		
	$j('#stockTakingNo').val(stockTakingM[count].stockTakingNo);
	$j('#stockTakingDate').val(stockTakingM[count].stockTakingDate);
	$j('#enterby').val(stockTakingM[count].submitBy);
	$j('#department').val(stockTakingM[count].departmentName);
	$j('#departmentId').val(stockTakingM[count].departmentId);
	$j('#reasonStockTaking').val(stockTakingM[count].reasonStockTaking)
	$j('#takingMId').val(stockTakingM[count].Id);
	
	}
	
	
	var htmlTable = "";
	var stockTakingT = jsonResponse.stockTakingTData;
	for (item = 0; item < stockTakingT.length; item++) {
		  	counter =parseInt(item)+1;
		 	$('#rowCount').val(stockTakingT[item].Id)
	    	htmlTable = htmlTable + "<tr id='" + stockTakingT[item].Id + "'>";
	    	htmlTable = htmlTable + "<td>"+counter+"</td>";
	    	htmlTable = htmlTable + "<td style='display:none'><input type='hidden' name='itemId' value='"+stockTakingT[item].itemId +"'/></td>";
	    	htmlTable = htmlTable + "<td style='display:none'><input type='hidden' name='stockTakingTId' value='"+stockTakingT[item].Id +"'/></td>";
	    	htmlTable = htmlTable + "<td style='display:none'><input type='hidden' name='stockId' value='"+stockTakingT[item].stockId +"'/></td>";
	    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width100' name='pvmsNumber' value='"+stockTakingT[item].pvmsNumber +"'/></td>";
	    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width330' name='nomenclature' value='"+stockTakingT[item].nomenclature +"'/></td>";
	    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width100' name='batchNumber' value='"+stockTakingT[item].batchNumber +"'/></td>";
	    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width90'  name='doe' value='"+stockTakingT[item].doe +"'/></td>";
	    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width70'  name='computedStock' value='"+stockTakingT[item].computedStock +"'/></td>";
	    	htmlTable = htmlTable + '<td ><input 		  type="text" class="form-control width70"  name="physicalStock" value="'+stockTakingT[item].physicalStock +'"  onchange="calculateDiff('+stockTakingT[item].Id+')"/></td>';
	    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width60'  name='surplus' value='"+stockTakingT[item].surplus +"'/></td>";
	    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width60'  name='deficient' value='"+stockTakingT[item].deficient +"'/></td>";
	    	htmlTable = htmlTable + "<td ><input 	      type='text' class='form-control width100'  name='remarks' value='"+stockTakingT[item].remarks +"'/></td>";
	    	htmlTable = htmlTable + "<td ><button type='button' class='btn btn-primary noMinWidth' button-type='add' onclick='addRow()'></button</td>";
	    	htmlTable = htmlTable + "<td ><button type='button' class='btn btn-danger noMinWidth' button-type='delete' onclick='deleteRow(this)'></button</td>";
	    }
	  $j("#tblstockTakingWatingList").html(htmlTable);
	  
  		var valRowId = new Array();
  			$("#tblstockTakingApproval tr[id !='th']").each(function(j)
				{				
					valRowId[j] = $j(this).attr("id");
				});
			$j("#hiddenValueCharge").val(valRowId);
});	
	
	
function submitStockTakingDataForApproval(){
	
	 $('table > tbody  > tr').each(function(index, tr) { 
		  var stockQty = $(tr).find('td').eq(9).find(":input").val();
		  console.log("qty **************** "+stockQty);
		  if(stockQty == ''){
			  alert("Please enter physical stock qty");
			  return;
		  }
		});
	 
	 
	 var value=validateFields("stockTakingApproval");
		if(value==true){
			document.stockTakingApproval.action="submitStockTakingDataForApproval";
			document.stockTakingApproval.method="POST";
			document.stockTakingApproval.submit();
		}else{
			alert(value.split('\n')[0]);
		}
}
	
	
function addRow(){
	
	var tbl = document.getElementById('tblstockTakingApproval');
		var lastRow = tbl.rows.length;
		var iteration = lastRow;
		var row = tbl.insertRow(lastRow);
		
		var hdb = document.getElementById('rowCount');
		var prevCnt = hdb.value;
		var iteration = parseInt(hdb.value) + 1;
		hdb.value = iteration; 
		
		row.id=iteration;
		row.name=iteration;

		var cell0 = row.insertCell(0);
		var e0 = document.createElement('span');
		e0.textContent = (lastRow);
		cell0.appendChild(e0);
		
		var newdivpsvn = document.createElement('div');
		newdivpsvn.className = "autocomplete forTableResp  width100";
		
		var newdivPvmsSub = document.createElement('div');
		newdivPvmsSub.id='divPvms'+ (iteration);
		newdivPvmsSub.className = "autocomplete-itemsNew";
		
		var cell1 = row.insertCell(1);
		var e1 = document.createElement('input');
		e1.type = 'text';
		e1.className=' form-control border-input';
		e1.name = 'pvmsNumber';
		e1.id = 'pvmsNumberId' + (iteration);
		e1.setAttribute('validate','Drug Code,string,yes');
		e1.size = '10';
		e1.autocomplete = 'off';
		e1.onkeyup = function() {
			getNomenClatureList(this,'fillItemAndValuesFromAutoComplete','store','getItemListForAutoComplete','store_adj_pvms')
		};
		
		cell1.appendChild(e1);
		newdivpsvn.appendChild(e1);
		newdivpsvn.appendChild(newdivPvmsSub);
		cell1.appendChild(newdivpsvn);
		
		

		var newdivnomen = document.createElement('div');
		newdivnomen.className = "autocomplete  forTableResp width330";
		
		var newdivnomenSub = document.createElement('div');
		newdivnomenSub.id='divNomen'+ (iteration);
		newdivnomenSub.className = "autocomplete-itemsNew";
		
		var cell2 = row.insertCell(2);
		var e2 = document.createElement('input');
		e2.type = 'text';
		e2.className=' form-control border-input';
		e2.name = 'nomenclature';
		e2.id = 'nomenclturId' + (iteration);
		e2.setAttribute('validate','Drug Name,string,yes');
		e2.tabIndex = "1";
		e2.size = '30';
		e2.autocomplete = 'off';
		e2.onkeyup = function() {
			getNomenClatureList(this,'fillItemAndValuesFromAutoComplete','store','getItemListForAutoComplete','store_adj_nomen')
		};

		cell2.appendChild(e2);
		newdivnomen.appendChild(e2)
		newdivnomen.appendChild(newdivnomenSub);
		cell2.appendChild(newdivnomen);


		var cell3 = row.insertCell(3);
		var e3 = document.createElement('select');
		e3.className='form-control border-input width100'
		e3.name = 'batchNumberId';
		e3.id = 'batchNumberId' + (iteration);
		e3.setAttribute('validate','Batch No.,string,yes');
		e3.options[0] = new Option('Select', '0');
		e3.tabIndex = "1";
		e3.onchange=function(){setValue(this.value,iteration)};
		cell3.appendChild(e3);

		
		var cell4 = row.insertCell(4);
		var e4 = document.createElement('input');
		e4.type = 'text';
		e4.readOnly=true;
		e4.className='form-control border-input width90'
		e4.name = 'doe';
		e4.id = 'doeDate' + (iteration);
		e4.tabIndex = "1";
		e4.size = '30';
		e4.autocomplete = 'off';
		cell4.appendChild(e4);

		
		var cell5 = row.insertCell(5);
		var e5 = document.createElement('input');
		e5.type = 'text';
		e5.readOnly=true;
		e5.className='form-control border-input width70';
		e5.name = 'computedStock';
		e5.id = 'computedStock' + (iteration);
		e5.setAttribute('validate','Computed stock,string,yes');
		e5.tabIndex = "1";
		e5.size = '30';
		cell5.appendChild(e5);
		
		
		
		var cell6 = row.insertCell(6);
		var e6 = document.createElement('input');
		e6.type = 'text';
		e6.className='form-control border-input width70';
		e6.name = 'physicalStock';
		e6.id = 'physicalStock' + (iteration);
		e6.setAttribute('validate','Physical Stock,string,yes');
		e6.tabIndex = "1";
		e6.size = '30';
		e6.onchange=function(){calculateDiff(iteration)};
		cell6.appendChild(e6);
		
		
		
		var cell7 = row.insertCell(7);
		var e7 = document.createElement('input');
		e7.type = 'text';
		e7.readOnly=true;
		e7.className='form-control border-input width60'
		e7.name = 'surplus';
		e7.id = 'surplus' + (iteration);
		e7.tabIndex = "1";
		e7.size = '30';
		e7.autocomplete = 'off';
		cell7.appendChild(e7);
		
		
		var cell8 = row.insertCell(8);
		var e8 = document.createElement('input');
		e8.type = 'text';
		e8.readOnly=true;
		e8.className='form-control border-input width60'
		e8.name = 'deficient';
		e8.id = 'deficient' + (iteration);
		e8.tabIndex = "1";
		e8.size = '30';
		e8.autocomplete = 'off';
		cell8.appendChild(e8);
		
		
		var cell9 = row.insertCell(9);
		var e9 = document.createElement('input');
		e9.type = 'text';
		e9.className='form-control border-input width100'
		e9.name = 'remarks';
		e9.id = 'remark' + (iteration);
		e9.tabIndex = "1";
		e9.size = '30';
		e9.autocomplete = 'off';
		cell9.appendChild(e9);
		
		
		var cell10 = row.insertCell(10);
		var e10 = document.createElement('button');
		e10.type = 'button';
		e10.className='btn btn-primary noMinWidth';
		e10.setAttribute('button-type','add');
		e10.setAttribute('onclick','addRow()');
		cell10.appendChild(e10);
		
		
		var cell11 = row.insertCell(11);
		var e11 = document.createElement('button');
		e11.type = 'button';
		e11.className='btn btn-danger noMinWidth';
		e11.setAttribute('button-type','delete');
		e11.setAttribute('onclick',"deleteRow(this)");
		cell11.appendChild(e11);
		
		
		var cell12 = row.insertCell(12);
		cell12.style.display = 'none';
		var e12 = document.createElement('input');
		e12.type = 'hidden';
		e12.name = 'itemId';
		e12.id = 'itemId' + (iteration);
		cell12.appendChild(e12);
		
		
		var cell13 = row.insertCell(13);
		cell13.style.display = 'none';
		var e13 = document.createElement('input');
		e13.type = 'hidden';
		e13.name = 'stockId';
		e13.id = 'stockId' + (iteration);
		cell13.appendChild(e13);
		
		var cell14 = row.insertCell(14);
		cell14.style.display = 'none';
		var e14 = document.createElement('input');
		e14.type = 'hidden';
		e14.name = 'batchNumber';
		e14.id = 'batchNumber' + (iteration);
		cell14.appendChild(e14);
		
		var valRowId = new Array();
			$("#tblstockTakingApproval tr[id !='th']").each(function(j)
			{				
				valRowId[j] = $j(this).attr("id");
			});
		$j("#hiddenValueCharge").val(valRowId);

	}
	
	
	
function deleteRow(val) {
	if ($('#tblstockTakingApproval tr[id!="th"]').length > 1) {
		
		var trId = $(val).closest('tr').attr("id");
		var headerMId=$('#takingMId').val();
		 
		var params = {
			"headerMId":headerMId,
			"headerTId":trId,
			"dataFlag":"stockTakingApproval"
		 } 	
			$j.ajax({
				type : "POST",
				contentType : "application/json",
				url : 'deleteRowFromDataBase',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(response) {
				if(response.status==1){
					// Record removed in database and also remove from grid.
					$(val).closest('tr').remove();
				}else{
					// Record not in database,remove from grid only.
					$(val).closest('tr').remove();
				}
				var valRowId = new Array();
				$("#tblstockTakingApproval tr[id !='th']").each(function(j)
				{				
					valRowId[j] = $j(this).attr("id");
				});
				$j("#hiddenValueCharge").val(valRowId);
			},
				error : function(msg) {
					alert("An error has occurred while contacting the server");
				}
		});	
	}else{
		alert("Can not delete all rows");
	} 
} 
	
</script>
</body>

</html>