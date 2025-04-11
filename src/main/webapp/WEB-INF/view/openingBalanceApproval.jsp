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

</head>
<% 
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

%>
<body>
	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">Approve Opening Balance</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">

									<!---------------------  Entry Details start here ------------------->
					
									<div class="adviceDivMain" id="button1" onclick="showhide(this.id)">
									<input type="hidden"  name="invoiceNo" value="" id="invoiceNo" />
										<div class="titleBg" style="width: 520px; float: left;">
											<span>Entry Details </span>
										</div>
										<input class="buttonPlusMinus" tabindex="1" name="" id="relatedbutton1" value="-" onclick="showhide(this.id)" type="button">
									</div>

									<div class="hisDivHide p-10" style="display:block;" id="newpost1">

										<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Balance Entry Number</label>
													</div>
													<div class="col-md-7">
														<input type="text" readonly class="form-control" id="BEnumberId" name="BEnumber"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Balance Entry Date</label>
													</div>
													<div class="col-md-7">
														<input type="text" readonly class="form-control" id="BEDateId" name="BEDate"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Entered By</label>
													</div>
													<div class="col-md-7">
														<input type="text" readonly class="form-control" id="enterbyId" name="enterby"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Department</label>
													</div>
													<div class="col-md-7">
														<input type="text" readonly class="form-control" id="department" name="department"/>
													</div>
												</div>
											</div>
											 <div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label"></label>
											</div>
											<div class="col-md-7">
												<!-- <button class="btn btn-primary" id="downloadBill" href="javascript:void(0)">Download Vendor Bill</button> -->
												<button name="data" class="btn btn-primary" type="button" id="downloadBill" onclick="getDownloadData()">Download Invoice</button>
											</div>
										</div>
									</div>


										</div>

									</div>

									<!---------------------- Entry Details end here ---------------------->
									
									<!---------------------  Opening Balance start here ------------------->
									
					<form id="openingBalanceEntryApproval" name="openingBalanceEntryApproval">

									<!---------------------- Opening Balance end here ---------------------->
									<div class="table-responsive">
									<table class="table table-hover table-striped table-bordered" id="tblOpeningBalanceApproval">
										<thead class="bg-primary">
											<tr id='th'>
												<th>S.No.</th>
												<th>Drug Code</th>
												<th>Drug Name</th>
												<th>Unit</th>
												<th>Batch No./ Serial No.</th>
												<th>DOM</th>
												<th>DOE</th>
												<th>Qty</th>
												<th>Unit Rate</th>
												<th>Amount</th>
												<th>Medicine Source</th>
												<th>Manufacturer</th>
												<th>Add</th>
                                				<th>Delete</th>
											</tr>
										</thead>
										 <tbody  id="tblopBalanceWatingList">
										</tbody>
									</table>
									</div>
									
										<div class="p-10">
											<div class="row">
												<div class="col-md-4">
													<div class="form-group row">
														<div class="col-md-5">
															<label for="service" class="col-form-label">Action<span class="text-red">*</span></label>
														</div>
														<div class="col-md-7">
															<select class="form-control" id="actionId" name="actionId"  validate="Action,string,yes">
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
															<label for="service" class="col-form-label">Remarks</label>
														</div>
														<div class="col-md-8 m-l-10">
															<textarea class="form-control" rows="2" id="remarkId" name="remarkId" validate="Remark,string,yes"></textarea>
														</div>
													</div>
												</div>
											</div>
											
									<div class="col-md-4">
										<input type="hidden" class="form-control" id="userId"
											   name="userId"  value="<%=session.getAttribute("user_id")%>">
																	
										<input type="hidden" class="form-control" id="mmuId"
											   name="mmuId"  value="<%= mmuId %>">
											   
										<input type="hidden" class="form-control" id="cityId"
											   name="cityId"  value="<%= cityId %>">
											   
										<input type="hidden" class="form-control" id="districtId"
											   name="districtId"  value="<%= districtId %>">
											   
										<input type="hidden"  class="form-control" id="departmentId" name="departmentId"/>
											   
										<input type="hidden" class="form-control" id="balanceMId"
											   name="balanceMId" >
											   
									    <input type="hidden"  name="hiddenValueCharge" id="hiddenValueCharge" value=""/>
									    <input type="hidden"  name="rowCount" id="rowCount" value=""/>
									    
							        </div>

											<div class="row">
												<div class="col-md-12 text-right">
												<input type="button" class="btn btn-primary" id="btnSubmit" value="Submit" onclick="submitStoreDataForApproval()" />
												<button type="reset" name="btnReset" id="btnReset"  class="btn btn-danger" accesskey="r" onclick="resetData()">Reset</button>
												</div>
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

	<!-- jQuery  -->
<script>

$j(document).ready(function() {
	var respData = ${jsonResponse};
	getVendorTypeList();
	getVendorNameList();
	var group = respData.storeItemData.groupList;
	var groupValues="";
	for (i = 0; i < group.length; i++) {
		
		groupId = group[i].storeGroupId;
		groupName = group[i].storeGroupName;
		
		groupValues += '<option value='+ groupId+'>'+ groupName + '</option>';
		
	}
	 $j('#itemGroupId').append(groupValues);
	

	var itemTypeValue = "";
	var itemType=respData.storeItemData.itemTypeList;
	for (i = 0; i < itemType.length; i++) {
		itemTypeId = itemType[i].itemTypeId;
		itemTypeName = itemType[i].itemTypeName;
		
		itemTypeValue += '<option value='+ itemTypeId+'>'+ itemTypeName + '</option>';
	}
	 $j('#itemTypeId').append(itemTypeValue);
	 
	 
	
	var itemClassValue = "";
	var itemClass=respData.storeItemData.itemClassList;
	for (i = 0; i < itemClass.length; i++) {
		
		itemClassId = itemClass[i].itemClassId;
		itemClassName = itemClass[i].itemClassName ;
		
		itemClassValue += '<option value='+ itemClassId+'>'+ itemClassName + '</option>';
	}
	
	 $j('#itemClassId').append(itemClassValue);
	
	
	var sectionValue = "";
	var section=respData.storeItemData.sectionList;
	for (i = 0; i < section.length; i++) {
		sectionId = section[i].sectionId;
		sectionName = section[i].sectionName ;
		
		sectionValue += '<option value='+ sectionId+'>'+ sectionName + '</option>';
	}
	
	$j('#itemSectionId').append(sectionValue);
	
	var storeBalanceM = respData.storeBalanceMData;
	for (i = 0; i < storeBalanceM.length; i++) {
	$j('#BEnumberId').val(storeBalanceM[i].balanceNo);
	$j('#BEDateId').val(storeBalanceM[i].balanceDate);
	$j('#enterbyId').val(storeBalanceM[i].submitBy);
	$j('#department').val(storeBalanceM[i].departmentName);
	$j('#departmentId').val(storeBalanceM[i].departmentId);
	$j('#balanceMId').val(storeBalanceM[i].Id);
	$('#downloadBill').attr('data-name', storeBalanceM[i].fileName);
	//$j('#fileName').val(storeBalanceM[i].fileName);
	$j('#invoiceNo').val(storeBalanceM[i].invoiceNumber);
	}
	
	var htmlTable = "";
	var storeBalanceT = respData.storeBalanceTData;
	for (item = 0; item < storeBalanceT.length; item++) {
		  $('#rowCount').val(storeBalanceT[item].Id)
		 	counter =parseInt(item)+1;
	    	htmlTable = htmlTable + "<tr id='" + storeBalanceT[item].Id + "'>";
	    	htmlTable = htmlTable + "<td>"+counter+"</td>";
	    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width100' name='pvmsNumber' value='"+storeBalanceT[item].pvmsNumber +"'/></td>";
	    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width220' name='nomenclature' value='"+storeBalanceT[item].nomenclature +"'/></td>";
	    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width80'  name='unitId' value='"+storeBalanceT[item].unitName +"'/></td>";
	    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width100' id='batchNumberId"+storeBalanceT[item].Id+"' name='batchNumber' value='"+storeBalanceT[item].batchNumber +"'/></td>";
	    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width110' id='domDate"+storeBalanceT[item].Id+"' name='dom' value='"+storeBalanceT[item].dom +"'/></td>";
	    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width110' id='doeDate"+storeBalanceT[item].Id+"' name='doe' value='"+storeBalanceT[item].doe +"'/></td>";
	    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width60'  name='qty' value='"+storeBalanceT[item].qty +"'/></td>";
	    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width60'  name='unitRate' value='"+storeBalanceT[item].unitRate +"'/></td>";
	    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width80'  name='totalAmount' value='"+storeBalanceT[item].totalAmount +"'/></td>";
	    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width80'  name='suppTypeId' value='"+storeBalanceT[item].vendorTypeName +"'/></td>";
	    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width80'  name='suppId' value='"+storeBalanceT[item].vendorName +"'/></td>";
	    	htmlTable = htmlTable + "<td ><button type='button' class='btn btn-primary noMinWidth' button-type='add' onclick='addRow()'></button</td>";
	    	htmlTable = htmlTable + "<td ><button type='button' class='btn btn-danger noMinWidth' button-type='delete' onclick='deleteRow(this)'></button</td>";
	    	htmlTable = htmlTable + "<td style='display:none'><input type='hidden' id='itemId"+storeBalanceT[item].itemId+"' name='itemId' value='"+storeBalanceT[item].itemId +"'/></td>";
	    	htmlTable = htmlTable + "<td style='display:none'><input type='hidden' name='supplierId' value='"+storeBalanceT[item].vendorId +"'/></td>";
	    	htmlTable = htmlTable + "<td style='display:none'><input type='hidden' name='supplierTypeId' value='"+storeBalanceT[item].vendorTypeId +"'/></td>";
	    }
	  $j("#tblopBalanceWatingList").html(htmlTable);
	  
  		var valRowId = new Array();
  			$("#tblOpeningBalanceApproval tr[id !='th']").each(function(j)
				{				
					valRowId[j] = $j(this).attr("id");
				});
			$j("#hiddenValueCharge").val(valRowId);
});

function getDownloadData()
{
	var namVal=$('#downloadBill').data('name');
	window.open("${pageContext.servletContext.contextPath}/store/download?name="+namVal+"&type=Dispensary&keys="+$('#invoiceNo').val(), '_blank').focus();	
}

function makeRemarksMendatory(){
	if($('#actionId').val()=="R"){
		var value = $('#remarkId').val();
		if(value==undefined || value==""){
			alert("Please fill the remark");
			return false;
		}else{
			return true;
		}
	}else{
		return true;
	}
}

function resetData(){
	$('#actionId').val(0);
	$('#remarkId').val("");
}

    function showhide(buttonId)
     {
		 if(buttonId=="button1"){
					test('related'+buttonId,"newpost1");					
		 }else if(buttonId=="button2"){
					test('related'+buttonId,"newpost2");
		 }
	 }
    
	function test(buttonId,newpost){
		 var x = document.getElementById(newpost);
			if (x.style.display != "block") {
				x.style.display = "block";
				document.getElementById(buttonId).value="-";
			}else {
				x.style.display = "none";
				document.getElementById(buttonId).value="+";
			}	 
	}
	
	function submitStoreDataForApproval(){
		var value=validateFields("openingBalanceEntryApproval");
		if(value==true){
			if(makeRemarksMendatory()){
				document.openingBalanceEntryApproval.action="submitOpeningBalanceDataForApproval";
				document.openingBalanceEntryApproval.method="POST";
				document.openingBalanceEntryApproval.submit();
			}
		}else{
			alert(value.split('\n')[0]);
		}
		
	}
	
	function fillSelectedValue(fieldId,value){
		/* var index1 = value.lastIndexOf("[");
		var index2 = value.lastIndexOf("]");
		index1++;
		var id = value.substring(index1, index2);
		$('#'+fieldId).val(id);
		
		
		var valRowId = new Array();
		$("#tblOpeningBalanceApproval tr[id !='th']").each(function(j)
		{				
			valRowId[j] = $j(this).attr("id");
		});
		
		var cnt = valRowId.length;
		getStoreItemList(cnt); */
		
	}
	
	function addRow(){
		
		var tbl = document.getElementById('tblOpeningBalanceApproval');
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
			
			//getStoreItemList(iteration);

			var newdivpsvn = document.createElement('div');
			newdivpsvn.className = "autocomplete forTableResp width100";

			var newdivPvmsSub = document.createElement('div');
			newdivPvmsSub.id='divPvms'+ (iteration);
			newdivPvmsSub.className = "autocomplete-itemsNew";
			
			var cell1 = row.insertCell(1);
			var e1 = document.createElement('input');
			e1.type = 'text';
			e1.className='form-control border-input';
			e1.name = 'pvmsNumber';
			e1.id = 'pvmsNumberId' + (iteration);
			e1.size = '10';
			e1.setAttribute('validate','Drug Code,string,yes');
			e1.autocomplete = 'off';
			e1.onkeyup = function() {
				getNomenClatureList(this,'fillItemAndValues','store','getStoreItemList','store_pvms')
			};
			
			cell1.appendChild(e1);
			newdivpsvn.appendChild(e1);
			newdivpsvn.appendChild(newdivPvmsSub);
			cell1.appendChild(newdivpsvn);
			
			

			var newdivnomen = document.createElement('div');
			newdivnomen.className = "autocomplete forTableResp width220";
			
			var newdivnomenSub = document.createElement('div');
			newdivnomenSub.id='divNomen'+ (iteration);
			newdivnomenSub.className = "autocomplete-itemsNew";
			
			var cell2 = row.insertCell(2);
			var e2 = document.createElement('input');
			e2.type = 'text';
			e2.className='form-control border-input';
			e2.name = 'nomenclature';
			e2.id = 'nomenclturId' + (iteration);
			e2.setAttribute('validate','Drug Name,string,yes');
			e2.tabIndex = "1";
			e2.size = '30';
			e2.autocomplete = 'off';
			e2.onkeyup = function() {
				getNomenClatureList(this,'fillItemAndValues','store','getStoreItemList','store_nomen')
			};

			cell2.appendChild(e2);
			newdivnomen.appendChild(e2);
			newdivnomen.appendChild(newdivnomenSub);
			cell2.appendChild(newdivnomen);

			

			var cell3 = row.insertCell(3);
			var e3 = document.createElement('input');
			e3.type = 'text';
			e3.readOnly=true;
			e3.className='form-control border-input width80'
			e3.name = 'unitId';
			e3.id = 'unitId' + (iteration);
			e3.tabIndex = "1";
			e3.size = '30';
			e3.autocomplete = 'off';
			cell3.appendChild(e3);

			
			var cell4 = row.insertCell(4);
			var e4 = document.createElement('input');
			e4.type = 'text';
			e4.className='form-control border-input width100'
			e4.name = 'batchNumber';
			e4.id = 'batchNumberId' + (iteration);
			e4.setAttribute('validate','Batch No.,string,yes');
			e4.setAttribute('maxlength','30');
			e4.tabIndex = "1";
			e4.size = '30';
			e4.onblur = function() {
				checkDuplicatePVMS(this,'tblopBalanceWatingList');
			};
			e4.autocomplete = 'off';
			cell4.appendChild(e4);

			
			
			
			var newdivdom = document.createElement('div');
			newdivdom.className = "dateHolder width110";
			var cell5 = row.insertCell(5);
			var e5 = document.createElement('input');
			e5.type = 'text';
			e5.readOnly=true;
			e5.className='noFuture_dateStore form-control';
			e5.name = 'dom';
			e5.id = 'domDate' + (iteration);
			e5.tabIndex = "1";
			e5.size = '30';
			e5.autocomplete = 'off';
			e5.setAttribute('placeholder','DD/MM/YYYY');
			cell5.appendChild(e5);
			newdivdom.appendChild(e5)
			cell5.appendChild(newdivdom);
			
			
			
			var newdivdoe = document.createElement('div');
			newdivdoe.className = "dateHolder width110";
			var cell6 = row.insertCell(6);
			var e6 = document.createElement('input');
			e6.type = 'text';
			e6.className='comapre_date form-control';
			e6.readOnly=true;
			e6.name = 'doe';
			e6.id = 'doeDate' + (iteration);
			e6.setAttribute('validate','Date of expiry,date,yes');
			e6.tabIndex = "1";
			e6.size = '30';
			e6.autocomplete = 'off';
			e6.setAttribute('placeholder','DD/MM/YYYY');
			cell6.appendChild(e6);
			newdivdoe.appendChild(e6)
			cell6.appendChild(newdivdoe);
			
			
			var cell7 = row.insertCell(7);
			var e7 = document.createElement('input');
			e7.type = 'text';
			e7.className='form-control border-input width60'
			e7.name = 'qty';
			e7.id = 'quantityId' + (iteration);
			//e7.setAttribute('validate','Quantity,number,yes');
			e7.onkeypress = function(){
				if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;
			}
			e7.onkeydown = function(){
				if(event.key==='.'){event.preventDefault();}
			}
			e7.oninput = function(){
				event.target.value = event.target.value.replace(/[^0-9]*/g,'');
			}
			e7.tabIndex = "1";
			e7.size = '30';
			e7.autocomplete = 'off';
			e7.onblur = function() {
				calculateAmount(iteration);
			};
			cell7.appendChild(e7);
			
			
			var cell8 = row.insertCell(8);
			var e8 = document.createElement('input');
			e8.type = 'text';
			e8.className='form-control border-input width60'
			e8.name = 'unitRate';
			e8.id = 'unitRateId' + (iteration);
			e8.setAttribute('validate','Unit Rate,number,no');
			e8.tabIndex = "1";
			e8.size = '30';
			e8.onblur = function() {
				calculateAmount(iteration);
			};
			e8.autocomplete = 'off';
			cell8.appendChild(e8);
			
			
			var cell9 = row.insertCell(9);
			var e9 = document.createElement('input');
			e9.type = 'text';
			e9.readOnly=true;
			e9.className='form-control border-input width80'
			e9.name = 'totalAmount';
			e9.id = 'amountId' + (iteration);
			e9.setAttribute('validate','Amount,number,no');
			e9.tabIndex = "1";
			e9.size = '30';
			e9.autocomplete = 'off';
			cell9.appendChild(e9);
			
			var cell10 = row.insertCell(10);
			var e10 = document.createElement('select');
			e10.className='form-control vendorTypeClass'
			e10.name = 'vendorTypeId';
			e10.id = 'vendorTypeId' + (iteration);
			e10.options[0] = new Option('Select', '');
			e10.tabIndex = "1";
			//e10.setAttribute('validate','Vendor Type,String,yes');
			e10.onclick=function(){setVendorType(this.id)};
			e10.onchange=function(){setVendorTypeId(this)};
			cell10.appendChild(e10);
			
			var cell11 = row.insertCell(11);
			var e11 = document.createElement('select');
			e11.className='form-control vendorClass'
			e11.name = 'vendorNameId';
			e11.id = 'vendorNameId' + (iteration);
			//e11.setAttribute('validate','Vendor Type,String,yes');
			e11.options[0] = new Option('Select', '');
			e11.tabIndex = "1";
			e11.onclick=function(){setVendorName(this.id)};
			e11.onchange=function(){setVendorNameId(this)};
			cell11.appendChild(e11);
			
			var cell12 = row.insertCell(12);
			var e12 = document.createElement('button');
			e12.type = 'button';
			e12.className='btn btn-primary noMinWidth';
			e12.setAttribute('button-type','add');
			e12.setAttribute('onclick','addRow()');
			cell12.appendChild(e12);
			
			
			var cell13 = row.insertCell(13);
			var e13 = document.createElement('button');
			e13.type = 'button';
			e13.className='btn btn-danger noMinWidth';
			e13.setAttribute('button-type','delete');
			e13.setAttribute('onclick',"deleteRow(this)");
			cell13.appendChild(e13);
			
			
			var cell14 = row.insertCell(14);
			cell14.style.display = 'none';
			var e14 = document.createElement('input');
			e14.type = 'hidden';
			e14.name = 'itemId';
			e14.id = 'itemId' + (iteration);
			cell14.appendChild(e14);
			
			var cell15 = row.insertCell(15);
			cell15.style.display = 'none';
			var e15 = document.createElement('input');
			e15.type = 'hidden';
			e15.name = 'supplierId';
			e15.id = 'supplierId' + (iteration);
			cell15.appendChild(e15);
			
			var cell16 = row.insertCell(16);
			cell16.style.display = 'none';
			var e16 = document.createElement('input');
			e16.type = 'hidden';
			e16.name = 'supplierTypeId';
			e16.id = 'supplierTypeId' + (iteration);
			cell16.appendChild(e16);
			
			var valRowId = new Array();
  			$("#tblOpeningBalanceApproval tr[id !='th']").each(function(j)
				{				
					valRowId[j] = $j(this).attr("id");
				});
			$j("#hiddenValueCharge").val(valRowId);

		}
	
	function deleteRow(val) {
		if ($('#tblOpeningBalanceApproval tr[id!="th"]').length > 1) {
			
			var trId = $(val).closest('tr').attr("id");
			var headerMId=$('#balanceMId').val();
			 
			var params = {
				"headerMId":headerMId,
				"headerTId":trId,
				"dataFlag":"openingBalanceEntryApproval"
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
		  			$("#tblOpeningBalanceApproval tr[id !='th']").each(function(j)
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
	

	function compareDate(){
		var valRowId = new Array();
		$("#tblOpeningBalanceApproval tr[id !='th']").each(function(j)
		{				
			valRowId[j] = $j(this).attr("id");
		});
		
		var cnt = valRowId.length;
		
		for(var i=0;i<=cnt-1;i++){
			var fromDate = $('#domDate'+valRowId[i]).val();
			 var toDate = $('#doeDate'+valRowId[i]).val();
			 
			 if(process(toDate) < process(fromDate)){
					alert("Expiry Date should not be earlier than Manufacturing Date");
					$('#domDate'+valRowId[i]).val("");
					return;
			 }
		}
		 
	}
	
	var vendorTypeGlobal='';
	function getVendorTypeList(){
		 $.ajax({
				type : "POST",
				contentType : "application/json",
				url : "getMasSupplierTypeList",
				data :JSON.stringify({}),
				dataType : 'json',
				timeout : 100000,
				success : function(res) {
					if(res.status == true){					
						var list = res.list;
						vendorTypeGlobal = list;
						var typeDropDown = '';
						for(i=0;i<list.length;i++){
							typeDropDown += '<option value='+list[i].id+'>'+list[i].name+'</option>';
						}
						
						if(typeDropDown != ''){
							$('.vendorTypeClass').append(typeDropDown);
						}
					}
				},
				error : function(jqXHR, exception) {
					alert("Error occured while contacting the server");
					$(item).attr("disabled", false);	
				}
			});
	}
	var vendorNameGlobal='';
	function getVendorNameList(){
		 $.ajax({
				type : "POST",
				contentType : "application/json",
				url : "getMasSupplierList",
				data :JSON.stringify({}),
				dataType : 'json',
				timeout : 100000,
				success : function(res) {
					if(res.status == true){					
						var list = res.list;
						vendorNameGlobal = list;
						var typeDropDown = '';
						for(i=0;i<list.length;i++){
							typeDropDown += '<option value='+list[i].id+'>'+list[i].name+'</option>';
						}
						
						if(typeDropDown != ''){
							$('.vendorClass').append(typeDropDown);
						}	
					}
				},
				error : function(jqXHR, exception) {
					alert("Error occured while contacting the server");
					$(item).attr("disabled", false);	
				}
			});
	}

	function setVendorType(itemId){
		var typeDropDown = '';
		var leng = $('#'+itemId+' option').length
		if(leng >1){
			return;
		}
		$('#'+itemId+' option:not(:first)').remove();
		for(i=0;i<vendorTypeGlobal.length;i++){
			typeDropDown += '<option value='+vendorTypeGlobal[i].id+'>'+vendorTypeGlobal[i].name+'</option>';
		}
		
		if(typeDropDown != ''){
			$('#'+itemId).append(typeDropDown);
		}
	}

	function setVendorName(itemId){
		var typeDropDown = '';
		var leng = $('#'+itemId+' option').length
		if(leng >1){
			return;
		}
		$('#'+itemId+' option:not(:first)').remove();
		//$('#'+itemId).empty();
		for(i=0;i<vendorNameGlobal.length;i++){
			typeDropDown += '<option value='+vendorNameGlobal[i].id+'>'+vendorNameGlobal[i].name+'</option>';
		}

		if(typeDropDown != ''){
			$('#'+itemId).append(typeDropDown);
		}
		
	}
	
	function setVendorTypeId(item){
		$(item).closest('tr').find('td').eq(16).find(':input').val(item.value);
	}
	
	function setVendorNameId(item){
		$(item).closest('tr').find('td').eq(15).find(':input').val(item.value);
	}
  </script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
</body>

</html>