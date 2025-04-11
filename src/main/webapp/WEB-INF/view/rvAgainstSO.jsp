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
<%
	String hospitalId = "1";
	if (session.getAttribute("mmuId") != null) {
		hospitalId = session.getAttribute("mmuId") + "";
	}
	String userId = "1";
	if (session.getAttribute("userId") != null) {
		userId = session.getAttribute("userId") + "";
	}
	String userName="";
	if (session.getAttribute("firstName") != null) {
		userName = session.getAttribute("firstName") + "";
	}
	String districtId = "";
	if (session.getAttribute("distIdUsers") != null) {
		districtId = session.getAttribute("distIdUsers") + "";
		districtId = districtId.replace(",","");
	}
	
%>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Indian Coast Guard</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<%@include file="..//view/commonJavaScript.jsp"%>
<script src="${pageContext.request.contextPath}/resources/js/stores.js"></script> 


</head>


<script >

$j(document).ready(function() {
	var data = ${jsonResponse};
	var poMData = data.storePoMData;
	for(var count=0;count<poMData.length;count++){
	$j('#poMId').val(poMData[count].poMId);
	$j('#supplyOrderNo').val(poMData[count].supplyOrderNo);
	$j('#soDate').val(poMData[count].soDate);
	$j('#deliveryDate').val(poMData[count].deliveryDate);
	$j('#vendorName').val(poMData[count].vendorName);
	$j('#vendorNameId').val(poMData[count].vendorNameId);
	$j('#rvNotes').html(poMData[count].rvNotes);
	
	$j('#lpTypeFlag').val(poMData[count].lpTypeFlag);
	var lpTypeFlagValue=poMData[count].lpTypeFlag;
}
	var htmlTable = "";
	$('#tblRvAgainstSo').empty();
	var poTData = data.storePoTData;
	var manufacturerData = data.manufacturerList.list;
	var manufacturerHtml = '';
	for(var m=0;m<manufacturerData.length;m++){
		manufacturerHtml = manufacturerHtml + '<option value='+manufacturerData[m].id+'>'+manufacturerData[m].name+'</option>';
	}
	var tempData= data.tempData;
	for(var count=0;count<poTData.length;count++){
		
		htmlTable = htmlTable + "<tr id='" + poTData[count].poTId + "'>";
    	htmlTable = htmlTable + "<td style='display:none'><input type='hidden' id='poTId"+count+"' name='poTId' value='"+poTData[count].poTId +"'/></td>";
    	htmlTable = htmlTable + "<td style='display:none'><input type='hidden' id='itemId"+count+"' name='itemId' value='"+poTData[count].itemId +"'/></td>";
    	
    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width100' id='pvmsNumber"+count+"' name='pvmsNumber' value='"+poTData[count].pvmsNumber +"'/></td>";
    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width300' id='nomenclature"+count+"' name='nomenclature' value='"+poTData[count].nomenclature +"'/></td>";
    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width100' id='au"+count+"' name='au' value='"+poTData[count].au +"'/></td>";
    	
    	if(lpTypeFlagValue!='' && lpTypeFlagValue=='B' && tempData[count].itemId==poTData[count].itemId){
    		htmlTable = htmlTable + "<td ><input  type='text' readonly class='form-control width100' id='batchNo"+count+"' name='batchNo' value='"+tempData[count].batchNo +"'/></td>";
        	htmlTable = htmlTable + "<td ><div class='dateHolder width100'><input  readonly type='text' class='form-control ' id='dom"+count+"' name='dom' value='"+tempData[count].dom +"'/></div></td>";
        	htmlTable = htmlTable + "<td ><div class='dateHolder width100'><input  readonly type='text' class='form-control ' id='doe"+count+"' name='doe' value='"+tempData[count].doe +"'/></div></td>";
    	}else{
    		htmlTable = htmlTable + "<td ><input  type='text' class='form-control width100' id='batchNo"+count+"' name='batchNo' value=''/></td>";
        	htmlTable = htmlTable + "<td ><div class='dateHolder width100'><input  readonly type='text' class='form-control noFuture_dateStore' id='dom"+count+"' name='dom' value=''/></div></td>";
        	htmlTable = htmlTable + "<td ><div class='dateHolder width100'><input  readonly type='text' class='form-control comapre_date' id='doe"+count+"' name='doe' value=''/></div></td>";
    	}
    	
    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width100' id='soQty"+count+"' name='soQty' value='"+poTData[count].qtyRequired +"'/></td>";
    	
    	htmlTable = htmlTable + "<td ><input  type='text' class='form-control width100' id='suppliedQty"+count+"' name='suppliedQty' value=''/></td>";
    	htmlTable = htmlTable + "<td ><input  type='text' class='form-control width100' id='quantityId"+count+"' name='receivedQty' value=''  onblur='calShortOrOverQty("+count+")'/></td>";
    	
    	htmlTable = htmlTable + "<td ><input  readonly type='text' class='form-control width100' id='preRecQuantityId"+count+"' name='preRecQuantityId' value='"+poTData[count].preReceivedQty +"' /></td>";
    	
    	htmlTable = htmlTable + "<td ><input  readonly type='text' class='form-control width100' id='short"+count+"' name='short' value=''/></td>";
    	htmlTable = htmlTable + "<td ><input  readonly type='text' class='form-control width100' id='over"+count+"' name='over' value=''/></td>";
    	
    	htmlTable = htmlTable + "<td ><input readonly type='text' class='form-control width100' id='unitRateId"+count+"' name='unitRate' value='"+poTData[count].unitRate +"'/></td>";
    	
    	htmlTable = htmlTable + "<td ><input  readonly type='text' class='form-control width100' id='amountId"+count+"' name='totalAmt' value=''/></td>";
    	htmlTable = htmlTable + '<td><div class="autocomplete forTableResp width150"><select class="form-control vendorClass" id="manufacturerNameId'+count+'" name="manufacturerNameId" onchange="setManufacturerId(this)"><option value="">Select</option>'+manufacturerHtml+'</select></div></td>';
    	htmlTable = htmlTable + '<td style="display:none"><input readonly type="hidden" class="form-control width100" id="manufacturerId'+count+'" name="manufacturerId" value=""/></td>';
    /* 	htmlTable = htmlTable + "<td ><input  type='text' class='form-control width100' id='amtAfterTax"+count+"' name='amtAfterTax' value=''/></td>";
    	htmlTable = htmlTable + "<td ><input  type='text' class='form-control width100' id='taxableValue"+count+"' name='taxableValue' value=''/></td>"; */
    	
    	/* htmlTable = htmlTable + "<td ><input  type='text' class='form-control width100' id='cgstPercent"+count+"' name='cgstPercent' value='' onblur='calTaxPercent("+count+")'/></td>";
    	htmlTable = htmlTable + "<td ><input  readonly type='text' class='form-control width100' id='cgstAmt"+count+"' name='cgstAmt' value=''/></td>";
    	
    	htmlTable = htmlTable + "<td ><input  type='text' class='form-control width100' id='sgstPercent"+count+"' name='sgstPercent' value='' onblur='calTaxPercent("+count+")'/></td>";
    	htmlTable = htmlTable + "<td ><input  readonly type='text' class='form-control width100' id='sgstAmt"+count+"' name='sgstAmt' value=''/></td>";
    	htmlTable = htmlTable + "<td ><input  readonly type='text' class='form-control width100' id='totalValue"+count+"' name='totalValue' value=''/></td>";
    	htmlTable = htmlTable + "<td ><input  type='text' class='form-control width100' id='chemicalCompo"+count+"' name='chemicalCompo' value=''/></td>"; */
    	if(lpTypeFlagValue!='' && lpTypeFlagValue=='B'){
    		htmlTable = htmlTable + "<td ><button disabled type='button' class='btn btn-primary noMinWidth' button-type='add' onclick='addNomenclatureRow(this);'></button</td>";
        	htmlTable = htmlTable + "<td ><button disabled type='button' class='btn btn-danger noMinWidth' button-type='delete'  style='display:none;' onclick='removeGridRow(this)'></button</td>"; 
    	}else{
    		htmlTable = htmlTable + "<td ><button type='button' class='btn btn-primary noMinWidth' button-type='add' onclick='addNomenclatureRow(this);'></button</td>";
        	htmlTable = htmlTable + "<td ><button type='button' class='btn btn-danger noMinWidth' button-type='delete'  style='display:none;' onclick='removeGridRow(this)'></button</td>"; 	
    	}
    	
    	
    /* htmlTable = htmlTable + "<td ><input  type='text' class='form-control width150' id='detailsRemark"+count+"' name='detailsRemark' value=''/></td>"; */
	}
	$j("#tblRvAgainstSo").html(htmlTable);
	
	checkRowForReadOnly();
	
	var valRowId = new Array();
		$("#tblRvAgainstSupplyOrder tr[id !='th']").each(function(j)
		{				
			valRowId[j] = $j(this).attr("id");
		});
	$j("#hiddenValueCharge").val(valRowId);
	
});

function setManufacturerId(item){
	$(item).closest('tr').find('td').eq(17).find(":input").val(item.value);
}

function compareDate(){
	// This need to here with no definition 
}


function checkRowForReadOnly(){
	
	var valRowId = new Array();
	$("#tblRvAgainstSupplyOrder tr[id !='th']").each(function(j)
	{				
		valRowId[j] = $j(this).attr("id");
	});
	var num =valRowId.length;
	
	for(var count=0;count<num;count++){
		var checkQtyReceive=parseInt($('#preRecQuantityId'+count).val());
		var checkSoQty=parseInt($('#soQty'+count).val());
		
		if(checkQtyReceive>=checkSoQty){
			$('#suppliedQty'+count).attr('readonly', 'readonly');
			$('#quantityId'+count).attr('readonly', 'readonly');
		}else{
			$('#suppliedQty'+count).removeAttr("readonly");
			$('#quantityId'+count).removeAttr("readonly");
		}
	}
	
}

function submitRVAgainstSO(type){
	if(!checkRVDate()){
		return;
	}
	var flag=0;
	 $('#tblRvAgainstSo tr').each(function(i, el) {
	    	var $tds = $(this).find('td')
	    var batchNo = $tds.eq(5).find(":input").val();
	    	var suppliedQty = $tds.eq(9).find(":input").val();
	    	var receivedQty = $tds.eq(10).find(":input").val();
	   
	      // alert(id);
	         if(batchNo!=""){
	        	 if(suppliedQty==""){
	        		 flag++;
		        	 alert("Please enter Supplied Qty"); 
		        	 return false; 
	        	 }
	        	 if(receivedQty==""){
	        		 flag++;
		        	 alert("Please enter Received Qty"); 
		        	 return false; 
	        	 }
	        	
	         }
	       
 
	 });
	if(flag==0)
	{	
	var value=validateFields("formRvAgainstSo");
	if(value==true){
		if(flag == 'p'){
 			$('#btnSubmitP').attr("disabled", true);
 		}else{
 			$('#btnSubmitF').attr("disabled", true);
 		}
		$j('#requestType').val(type);
		document.formRvAgainstSo.action="submitRVAgainstSO";
		document.formRvAgainstSo.method="POST";
		document.formRvAgainstSo.submit();  
	}else{
		if(flag == 'p'){
 			$('#btnSubmitP').attr("disabled", false);
 		}else{
 			$('#btnSubmitF').attr("disabled", false);
 		}
		if(value!=true)
		alert(value.split('\n')[0]);
		
	}
  }
}

// currentlly below code is not using
function checkGridRow(type) {
	if ($('#tblRvAgainstSupplyOrder tr[id!="th"]').length > 1) {
		return true;
	}else{
		if(type=='p' || type=='P'){
			alert("Can not do partially receive.Do full receiving.");
			return false;
		}else{
			return true;
		}
	}
} 


function calShortOrOverQty(counter){
	for(var i=0;i<=counter;i++){
		var qtyReceive=0;
		var currentItemIdValue=$j('#itemId'+i).val();
		$('#tblRvAgainstSo tr').each(function(i, el) {
			var $tdc = $(this).find('td');
			var itemIdValue = $tdc.eq(1).find(":input").val();
			if(currentItemIdValue==itemIdValue){
				qtyReceive=parseInt(qtyReceive)+parseInt($j('#quantityId'+i).val());
			}
		 }); 
		
	}
	var qtyRequired=$j('#soQty'+counter).val();
	var preReceivedQty=$j('#preRecQuantityId'+counter).val();
	var difference=0;
	if(preReceivedQty){
		preReceivedQty=preReceivedQty
		difference=parseInt(qtyRequired)-(parseInt(preReceivedQty)+parseInt(qtyReceive));
	}else{
		preReceivedQty=0;
		difference=parseInt(qtyRequired)-parseInt(qtyReceive);
	}
	
	if(difference>0){
		$('#short'+counter).val(difference);
		$('#over'+counter).val('');
	}else if(difference<0){
		$('#short'+counter).val('');
		$('#over'+counter).val((parseInt(preReceivedQty)+parseInt(qtyReceive))-parseInt(qtyRequired));
	}else{
		$('#short'+counter).val('');
		$('#over'+counter).val('');
	}
	calculateAmount(counter);
}

function calTaxPercent(count){
	var tax="";
	var amount = parseFloat($('#amountId'+count).val()); 
	if($('#cgstPercent'+count).val()){
		tax = parseFloat($('#cgstPercent'+count).val());
		
		 var perc="";
		    if(isNaN(amount) || isNaN(tax)){
		        perc="";
		       }else{
		       perc = ((amount/100) * tax).toFixed(2);
		       }
		
		    var cgstAmt=0;
		    if($('#cgstPercent'+count).val()){
		    	$('#cgstAmt'+count).val(perc);
		    	cgstAmt = perc;
			}
		
	}
	
	if($('#sgstPercent'+count).val()){
		tax = parseFloat($('#sgstPercent'+count).val());
		
		 var perc="";
		    if(isNaN(amount) || isNaN(tax)){
		        perc="";
		       }else{
		       perc = ((amount/100) * tax).toFixed(2);
		       }
		   
		    var sgstAmt=0;
		    if($('#sgstPercent'+count).val()){
		    	$('#sgstAmt'+count).val(perc);
		    	sgstAmt = perc;
				
			}
	}
   
    var totalAmt="";
    if(isNaN(cgstAmt) || isNaN(sgstAmt)){
    	totalAmt="";
       }else{
    	   totalAmt = (parseFloat(amount)+parseFloat(sgstAmt)+parseFloat(cgstAmt)).toFixed(2);
    	   //totalAmt = (parseFloat(amount)).toFixed(2);
    	   $('#totalValue'+count).val(totalAmt);
       }
}


function addNomenclatureRow(item) {
	var row = $(item).closest('tr');
	var aClone = $('#'+row[0].id+'').clone().attr("id",'rowId');
	aClone.find('img.ui-datepicker-trigger').remove();
	var valRowId = new Array();
	$("#tblRvAgainstSupplyOrder tr[id !='th']").each(function(j)
	{				
		valRowId[j] = $j(this).attr("id");
	});
	var count=valRowId.length;

	aClone.find("td:eq(0)").find(":input")
	.prop('id', 'poTId' + count + '')
	.prop('name', 'poTId');
	
	aClone.find("td:eq(1)").find(":input")
		.prop('id', 'itemId' + count + '')
		.prop('name', 'itemId');
	
	aClone.find("td:eq(5)").find(":input")
	.prop('id', 'batchNo' + count + '')
	.prop('name', 'batchNo').val('');
	
	 aClone.find("td:eq(6)").find("input:eq(0)").removeClass('input_date hasDatepicker').addClass('noFuture_date form-control')
	.prop('id', 'dom' + count + '')
	.prop('name', 'dom').val('');
	
	aClone.find("td:eq(7)").find("input:eq(0)").removeClass('input_date hasDatepicker').addClass('noFuture_date form-control')
	.prop('id', 'doe' + count + '')
	.prop('name', 'doe').val('');
	
	
	aClone.find("td:eq(8)").find(":input")
	.prop('id', 'soQty' + count + '')
	.prop('name', 'soQty');
	
	aClone.find("td:eq(9)").find(":input")
	.prop('id', 'suppliedQty' + count + '')
	.prop('name', 'suppliedQty').val('');
	
	aClone.find("td:eq(10)").find("input:eq(0)").removeAttr('onblur').attr('onblur','calShortOrOverQty('+count+')')
	.prop('id', 'quantityId' + count + '')
	.prop('name', 'receivedQty').val('');
	
	aClone.find("td:eq(11)").find(":input")
	.prop('id', 'preRecQuantityId' + count + '')
	.prop('name', 'preRecQuantityId');
	
	aClone.find("td:eq(12)").find("input:eq(0)")
	.prop('id', 'short' + count + '')
	.prop('name', 'short').val('');
	
	aClone.find("td:eq(13)").find("input:eq(0)")
	.prop('id', 'over' + count + '')
	.prop('name', 'over').val('');
	
	
	aClone.find("td:eq(14)").find(":input")
	.prop('id', 'unitRateId' + count + '')
	.prop('name', 'unitRate');
	
	aClone.find("td:eq(15)").find(":input")
	.prop('id', 'amountId' + count + '')
	.prop('name', 'totalAmt');
	
	aClone.find("td:eq(16)").find("input:eq(0)").removeAttr('onblur').attr('onblur','calTaxPercent('+count+')')
	.prop('id', 'cgstPercent' + count + '')
	.prop('name', 'cgstPercent').val('');
	
	aClone.find("td:eq(17)").find(":input")
	.prop('id', 'cgstAmt' + count + '')
	.prop('name', 'cgstAmt').val('');
	
	aClone.find("td:eq(18)").find("input:eq(0)").removeAttr('onblur').attr('onblur','calTaxPercent('+count+')')
	.prop('id', 'sgstPercent' + count + '')
	.prop('name', 'sgstPercent').val('');
	
	aClone.find("td:eq(19)").find(":input")
	.prop('id', 'sgstAmt' + count + '')
	.prop('name', 'sgstAmt').val('');
	
	aClone.find("td:eq(20)").find(":input")
	.prop('id', 'totalValue' + count + '')
	.prop('name', 'totalValue').val('');
	
	aClone.find("td:eq(21)").find(":input")
	.prop('id', 'chemicalCompo' + count + '')
	.prop('name', 'chemicalCompo').val('');
	
	
	aClone.find("td:eq(17)").find("button:eq(0)").removeAttr("style");
	aClone.clone(true).appendTo('#tblRvAgainstSo');
	
	callRowCount();
}

function removeGridRow(val) {
	if ($('#tblRvAgainstSupplyOrder tr[id!="th"]').length > 1) {
		$(val).closest('tr').remove();
		callRowCount();
	}else{
		alert("Can not delete all rows");
	}
}

function callRowCount(){
	var valRowId = new Array();
	$("#tblRvAgainstSupplyOrder tr[id !='th']").each(function(j)
	{				
		valRowId[j] = $j(this).attr("id");
	});
	$j("#hiddenValueCharge").val(valRowId);
}

function checkDate(item){
	 var doeDateId=$(item).closest('tr').find("td:eq(7)").find("input:eq(0)").attr("id");
	 var domDateId=$(item).closest('tr').find("td:eq(6)").find("input:eq(0)").attr("id");

	 var doeDate = $('#'+doeDateId).val();
	  var domDate = $('#'+domDateId).val();
	  
	 if(process(doeDate) < process(domDate)){
			alert("Expiry Date should not be earlier than Manufacturing Date");
			$('#'+doeDateId).val("");
			return;
	 }
	 return true;
	
}

function checkRVDate(){
		var currentDate=currentDateInddmmyyyy();
		var rvDate=$('#rvDate').val();
		var poDate = $('#soDate').val();
		if(rvDate == ''){
			alert("Please select RV Date");
			return;
		}
			
		 if(process(rvDate) > process(currentDate)){
				alert("RV Date should not be later than today's Date");
				return false;
		 }else if(process(rvDate) < process(poDate)){
				alert("RV Date should not be earlier than PO Date");
				return false;
		 }else{
			 return true;
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
					<div class="internal_Htext">Create RV Against PO</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<form id="formRvAgainstSo" name="formRvAgainstSo">
									<div class="row">
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">PO No.<span class="text-red">*</span></label>
												</div>
												<div class="col-md-7">
													<input readonly class="form-control" type="text" id="supplyOrderNo" name="supplyOrderNo" validate="PO No.,string,yes"/> 
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">PO Date<span class="text-red">*</span></label>
												</div>
												<div class="col-md-7">
													<input readonly class="form-control" type="text" id="soDate"  name="soDate" validate="PO Date,date,yes"/> 
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Vendor Name<span class="text-red">*</span></label>
												</div>
												<div class="col-md-7">
													<input readonly class="form-control" type="text" id="vendorName" name="vendorName" validate="Vendor Name,string,yes"/> 
													<input  class="form-control" type="hidden" id="vendorNameId" name="vendorNameId"/> 
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">RV Date<span class="text-red">*</span></label>
												</div>
												<div class="col-md-7">
													<div class="dateHolder">
														<input  type="text" readonly class="calDate datePickerInput form-control minwidth120 noFuture_date"
														placeholder="DD/MM/YYYY" value="" maxlength="10" id="rvDate" name="rvDate" validate="RV Date,date,yes"/>
													</div>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">RV Notes</label>
													</div>
													<div class="col-md-7">
														<textarea name="rvNotes" tabindex="2"
															id="rvNotes" placeholder="" class="form-control" readonly></textarea>
													</div>
											</div>
										</div>
										<div class="w-100"></div>
										
										<!-- <div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Invoice Date<span class="text-red">*</span></label>
												</div>
												<div class="col-md-7">
													<div class="dateHolder">
														<input  type="text" class="noFuture_date datePickerInput form-control minwidth120"
														placeholder="DD/MM/YYYY" value="" maxlength="10" id="invDate" name="invDate" onchange="checkRVDate('I')" validate="Invoice Date,date,yes"/>
													</div>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Invoice No.<span class="text-red">*</span></label>
												</div>
												<div class="col-md-7">
													<input class="form-control" type="text" id="invNo" name="invNo" validate="Invoice No,string,yes"/> 
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Invoice Amount<span class="text-red">*</span></label>
												</div>
												<div class="col-md-7">
													<input class="form-control" type="text" id="invAmt" name="invAmt" onkeypress="return isNumberKey(event)" validate="Invoice Amount,number,yes"/> 
												</div>
											</div>
										</div> -->
									</div>
									
									<div class="table-responsive">
									<table class="table table-hover table-striped table-bordered m-t-10" id="tblRvAgainstSupplyOrder">
										<thead class="bg-primary">
											<tr id='th'>
												<th>Drug Code</th>
												<th>Drug Name</th>
												<th>A/U</th>
												<th>Batch No</th>
												<th>DOM</th>
												<th>DOE</th>
												<th>PO Qty</th>
												<th>Supplied Qty</th>
												<th>Received Qty</th>
												<th>Previous Received Qty</th>
												<th>Short</th>
												<th>Over</th>
												<th>Unit Rate</th>
												<th>Total Amount</th>
												<th>Manufacturer</th>
												<th>Add</th>
                                				<th>Delete</th>
												
											</tr>
										</thead> 
										<tbody id="tblRvAgainstSo">
										</tbody>
									</table>
									</div>
									
										<div class="col-md-4">
										 <input type="hidden"  name="userIdval" value=<%=userId%> id="userIdval" />
																	
										<input type="hidden" class="form-control" id="hospitalId"
											   name="hospitalId"  value=<%=hospitalId%>>
											   
										<input type="hidden" class="form-control" id="departmentId"
											   name="departmentId"  value="<%=session.getAttribute("department_id")%>">
											   
										<input  type="hidden" class="form-control" id="requestType" name="requestType" value=""/>	   
										
										<input  type="hidden" class="form-control" id=poMId name="poMId" value=""/>	 
										
										<input  type="hidden" class="form-control" id=lpTypeFlag name="lpTypeFlag" value=""/>	  
									    
									     <input type="hidden"  name="hiddenValueCharge" id="hiddenValueCharge" value=""/>
									     
									     <input type="hidden" class="form-control" id="districtId"
											   name="districtId"  value="<%= districtId %>">
							        </div>
									
									
									<div class="row m-t-10">
										<div class="col-12 text-right">
										<input type="button" class="btn btn-primary" id="btnSubmitP"
													value="Partially Receive" onclick="submitRVAgainstSO('p')" />
										<input type="button" class="btn btn-primary" id="btnSubmitF"
													value="Fully Receive" onclick="submitRVAgainstSO('f')" />
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


</body>

</html>