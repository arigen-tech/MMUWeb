<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
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
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/newOpd.js"></script>
</head>
<script type="text/javascript" language="javascript">
	
<%String hospitalId = "1";
			if (session.getAttribute("hospital_id") != null) {
				hospitalId = session.getAttribute("hospital_id") + "";

			}

			String user_id = "0";
			if (session.getAttribute("user_id") != null) {
				user_id = session.getAttribute("user_id") + "";
			}

			String departmentId = "1402";
			if (session.getAttribute("department_id") != null) {
				departmentId = session.getAttribute("department_id") + "";
			}
			
			String id = request.getParameter("id");
%>
	var nPageNo=1;
	var $j = jQuery.noConflict();
	
	$j(document).ready(function()
			{
				getPatientPrescription();
				
			});
	var global_json;
	var data = '';
	var item3 = '';
	function getPatientPrescription() {
		var response = ${response};
		$('#service_no').val(response.headerInfo.service_no);
		$('#patient_name').val(response.headerInfo.patient_name);
		$('#relation').val(response.headerInfo.relation);
		$('#employee_name').val(response.headerInfo.employee_name);
		$('#age').val(response.headerInfo.age);
		$('#gender').val(response.headerInfo.gender);
		$('#doctor_name').val(response.headerInfo.doctor);
		$('#prescription_date').val(response.headerInfo.prescription_date);
		$('#issue_date').val(currentDateInddmmyyyy());
		$('#hd_id').val(response.headerInfo.header_id);
		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "getPartialIssueDetails",
			data : JSON.stringify({
				'id' : <%= id %>,
				'hospital_id' : <%=hospitalId%>,
				'department_id' :<%=departmentId%>
				}),
			dataType : 'json',
			timeout : 100000,
			success : function(res) {
				data = res;
			
		var detailList = data.detailList;
		global_json = detailList;
		var html = '';
		x = 0;		
		for (var i = 0; i < detailList.length; i++) {
			var nomenclature = detailList[i].nomenclature + ' ['
					+ detailList[i].pvsm_no + ']';
			var itemId = detailList[i].item_id;
			var comboList = detailList[i].batchList;
			var combo = '';
			var doe = '';
			var batch_stock = '';
			var lengthOfCombo = comboList.length;
			if (comboList.length > 0) {
				//combo += '<option value="">Select</option>';
				combo += '';
				for (var j = 0; j < comboList.length; j++) {
					if (j == 0) {
						combo += '<option value="'+comboList[j].stock_id+'" selected>'
								+ comboList[j].batch_no + '</option>';
						doe = comboList[j].date_of_expiry;
						batch_stock = comboList[j].batch_stock;
					} else {
						combo += '<option value="'+comboList[j].stock_id+'">'
								+ comboList[j].batch_no + '</option>';
					}

				}
			}

			html += '<tr id="rowId'+i+'" value="'+detailList[i].detail_id+'">';
			html += '<td><div class="autocomplete forTableResp"><input type="text" class="form-control width150" onkeypress="commonForAutoPopulate(this)" onblur="populatePVMS(this.value,1,this);getBatchList(this);" value="'
					+ nomenclature + '" readonly/></div></td>';
			html += '<td><input type="text" class="form-control width80" value="'+detailList[i].au+'" readonly/></td>';
			html += '<td><input type="text" class="form-control width40" value="'+detailList[i].dosage+'" readonly/></td>';
			html += '<td><input type="text" class="form-control width80" value="'+detailList[i].frequency+'" readonly/></td>';
			html += '<td><input type="text" class="form-control width40" value="'+detailList[i].no_of_days+'" readonly/></td>';
			/* html += '<td><select class="form-control width100" id="batchNo'+i+'" onchange="setValue(this.value,'+i+')";>'+combo+'</select></td>'; */
			html += '<td><select class="form-control width100" id="batchNo'+i+'" onchange="setValue(this)";>'+combo+'</select></td>';
			html += '<td><input type="text" class="form-control width90" id="date_of_expiry'+i+'" value="'+doe+'" readonly/></td>';
			html += '<td><input type="text" class="form-control width50" value="'+detailList[i].qty_prescribed+'" readonly/></td>';
			if(lengthOfCombo != 0){				
				if(parseInt(detailList[i].qty_prescribed) > parseInt(batch_stock)){
					html += '<td><input type="text" class="form-control width50" onkeypress="return isNumber(event)" value="'+batch_stock+'"/></td>';
				}else{
					html += '<td><input type="text" class="form-control width50" onkeypress="return isNumber(event)" value="'+detailList[i].qty_prescribed+'"/></td>';
				}				
			}else{
				html += '<td><input type="text" class="form-control width50" onkeypress="return isNumber(event)" value="0"/></td>';
			}
			if(lengthOfCombo != 0){
				html += '<td><input type="text" class="form-control width60" id="batch_stock'+i+'" value="'+batch_stock+'" readonly/></td>';
			}else{
				html += '<td><input type="text" class="form-control width60" id="batch_stock'+i+'" value="0" readonly/></td>';
			}	
			if(detailList[i].disp_stock == ''){
				html += '<td><input type="text" class="form-control width60" value="0" readonly></td>';
			}else{
				html += '<td><input type="text" class="form-control width60" value="'+detailList[i].disp_stock+'" readonly></td>';
			}
			
			html += '<td><input type="text" class="form-control width60" value="'+detailList[i].store_stock+'" readonly/></td>';
			//html += '<td><input type="text" class="form-control width100" value="'+detailList[i].doctor+'"/></td>';
			html += '<td><button type="submit" class="btn btn-primary noMinWidth" id="add_row" button-type="add" onclick="addNomenclatureRow(this)"></button></td>';
			html += '<td><button type="submit" class="btn btn-danger noMinWidth" id="delete_row" button-type="delete"  style="display:none;" onclick="removeGridRow(this)"></button></td>';
			html += '<td style="display: none";><input type="hidden" value="'+detailList[i].item_id+'" tabindex="1" id="pvsm_no" size="77"	name="pvsmNo" /></td>';
			html += '<td style="display: none"><input type="hidden" value="'+detailList[i].detail_id+'" id="detail_id"></td>';
			html += '<td style="display: none"><input type="hidden" value="'+detailList[i].header_id+'" id="header_id"></td>';
			html += '<td style="display: none"><input type="hidden" value="'+detailList[i].freq_id+'" id="frequency_id"></td>';
			html += '<td style="display: none"><input type="hidden" value="'+detailList[i].itemTypeId+'" id="itemTypeId"></td>';
			html += '</tr>';
		}
		$('#prescription_table').append(html);
		},
		error : function(jqXHR, exception) {
			alert("Error occured while contacting the server");
		}
	});
	}

	var i = 0;
	function addNomenclatureRow(item) {
		var b_stock = parseInt($(item).closest('tr').find("td:eq(9)").find(":input").val());
		var d_stock = parseInt($(item).closest('tr').find("td:eq(10)").find(":input").val());
		if(b_stock == undefined || b_stock == ''){
			b_stock = 0;
		}
		if(d_stock == undefined || d_stock == ''){
			d_stock = 0;
		}
		if(d_stock <= b_stock){
			alert("You are not authorized to add medicine");
			return;
		}
		i++;
		var pres_qt = $(item).closest('tr').find("td:eq(7)").find(":input").val();
		var iss_qt = $(item).closest('tr').find("td:eq(8)").find(":input").val();
		var itemId = $(item).closest('tr').find("td:eq(14)").find(":input").val();
		
				
		var optionId = $(item).closest('tr').find("td:eq(5)").find('select').attr("id");
		var length = $('#'+optionId).children('option').length;
		var totalItemlength = 0;
		var loopFlag = false;
		$('#prescription_table tr').each(function(i, el) {
				var $tds = $(this).find('td')
				var itemId2 = $tds.eq(14).find(":input").val();	
				if(parseInt(itemId) == parseInt(itemId2))	{
					totalItemlength++;
				}
				if(length == totalItemlength){
					alert("You are not authorized to add medicine");
					loopFlag = true;
					return false;
				}
		});
		if(loopFlag){
			return;
		}
		
		
		var remaining_qt = pres_qt - iss_qt;
		var selectedBatchValue = $(item).closest('tr').find("td:eq(5)").find(":input").val();
		var optionList = '';
		var exp_date = '';
		var batchSt = '';
		var batchList = "";
		var stk_id = "";
		var global_json_length = global_json.length;
		for(var g=0;g<global_json_length;g++){
			var global_item_id = global_json[g].item_id;
			if(parseInt(global_item_id) == parseInt(itemId)){
				batchList = global_json[g].batchList;
				var get_count = 0;
				for(var b=0;b<batchList.length;b++){
					var stockId = batchList[b].stock_id;
					var flag = false;
					if(parseInt(selectedBatchValue) == parseInt(stockId)){						
						flag = true;
						get_count = b+1;
					}
					if(get_count == b){
						optionList += '<option value="'+stockId+'" selected>'+batchList[b].batch_no+'</option>';
						batchSt = batchList[b].batch_stock;
						exp_date = batchList[b].date_of_expiry;
					}else{
						optionList += '<option value="'+stockId+'">'+batchList[b].batch_no+'</option>';
					}
					
				}
			}
		}
		var iss_qty = remaining_qt;
		if(parseInt(iss_qty) < parseInt(batchSt)){
			iss_qty = remaining_qt;
		}else{
			iss_qty = parseInt(batchSt);
		}
		var row = $(item).closest('tr');	
		var aClone = $('#'+row[0].id+'').clone().attr("id",'rowId'+x+'');
		aClone.find("td:eq(7)").find(":input").val(remaining_qt);
		aClone.find("td:eq(8)").find(":input").val(iss_qty);
		aClone.find("td:eq(5)").find(":input").text("");
		aClone.find("td:eq(5)").find('select').append(optionList);
		aClone.find("td:eq(6)").find(":input").val(exp_date);
		aClone.find("td:eq(9)").find(":input").val(batchSt);
		aClone.find("td:eq(15)").find(":input").val('');
		
		//aClone.find("td:eq(7)").find('select').append(optionList);
		//var aClone = $('#'+row[0].id+'').clone().attr("id",'rowId'+x+'').appendTo('#prescription_table');		
		//var aClone = $('#prescription_table>tr:last').clone(true);
		//aClone.find(":input").val("");			
		
		aClone.find('input[type="text"]').prop('id', 'nomenclature' + i + '');
		//aClone.find("td:eq(15)").find(":input").prop('id', 'pvsm_no' + i + '');
		//aClone.find("option[selected]").removeAttr("selected");
		aClone.find("td:eq(13)").find("button:eq(0)").removeAttr("style");
		aClone.find("td:eq(5)").find(":input").prop('id', 'stockId' + i + '');
		aClone.clone(true).appendTo('#prescription_table'); 
		$('#prescription_table>tr:last').find("td:eq(13)").find('button:eq(0)').attr("id","newIdNew");
	}

	function deleteRow() {

	}

	function removeGridRow(val) {

		if ($('#prescription_table tr').length > 1) {
			$(val).closest('tr').remove();
		}
	}

	var arryNomenclature = new Array();
	/* var val = $('#prescription_table').children('tr:first')
			.children('td:eq(0)').find(':input')[0]
	autocomplete(val, arryNomenclature); */
</script>

<script type="text/javascript">
	var autoVsPvmsNo = '';
	var data = '';
	var itemIds = '';
	$(document).ready(
			function getMastStoreItem() {
				var pathname = window.location.pathname;
				var accessGroup = "MMUWeb";

				var url = window.location.protocol + "//"
						+ window.location.host + "/" + accessGroup
						+ "/opd/getMasStoreItemList";
				$.ajax({
					type : "POST",
					contentType : "application/json",
					url : url,
					data : JSON.stringify({
						'employeeId' :<%=user_id%>,
					}),
					dataType : 'json',
					timeout : 100000,

					success : function(res)

					{
						data = res.MasStoreItemList;
						autoVsPvmsNo = res.MasStoreItemList;
						var autoList = [];
						for (var i = 0; i < data.length; i++) {

							var masItemIdValue = data[i];

							var masItemId = masItemIdValue[0];
							var masPvmsNo = masItemIdValue[1];
							var masDispUnit = masItemIdValue[3];
							var masNomenclature = masItemIdValue[2];

							var aNom = masNomenclature + "[" + masPvmsNo + "]";
							autoList[i] = aNom;
							//alert("a "+a);
							arryNomenclature.push(aNom);

						}

					},
					error : function(jqXHR, exception) {
						var msg = '';
						if (jqXHR.status === 0) {
							msg = 'Not connect.\n Verify Network.';
						} else if (jqXHR.status == 404) {
							msg = 'Requested page not found. [404]';
						} else if (jqXHR.status == 500) {
							msg = 'Internal Server Error [500].';
						} else if (exception === 'parsererror') {
							msg = 'Requested JSON parse failed.';
						} else if (exception === 'timeout') {
							msg = 'Time out error.';
						} else if (exception === 'abort') {
							msg = 'Ajax request aborted.';
						} else {
							msg = 'Uncaught Error.\n' + jqXHR.responseText;
						}
						alert(msg);
					}
				});

			});

	var pvmsNo = '';
	function populatePVMS(val, inc, item) {
		if (val != "") {
			//alert("val"+ val)
			var index1 = val.lastIndexOf("[");
			var indexForBrandName = index1;
			var index2 = val.lastIndexOf("]");
			index1++;
			pvmsNo = val.substring(index1, index2);
			var indexForBrandName = indexForBrandName--;
			var brandName = val.substring(0, indexForBrandName);
			// alert("pvms no--"+pvmsNo)

			if (pvmsNo == "") {

				return false;
			} else {
				//document.getElementById('pvmsNo' + inc).value = pvmsNo;
				//alert(pvmsNo)
				var pvmsValue = '';
				for (var i = 0; i < autoVsPvmsNo.length; i++) {
					// var pvmsNo1 = data[i].pvmsNo;
					var masItemIdValue = autoVsPvmsNo[i];
					var pvmsNo1 = masItemIdValue[1];

					if (pvmsNo1 == pvmsNo) {
						pvmsValue = masItemIdValue[3];//data[i].dispUnit;
						itemIdPrescription = masItemIdValue[0]; //data[i].itemId;
						itemIds = itemIdPrescription;
						
						var checkCurrentNomRowId = $(item).closest('tr').find(
								"td:eq(15)").find("input:eq(0)").attr("id");
						var checkCurrentNomRowVal = $(item).closest('tr').find(
								"td:eq(15)").find("input:eq(0)").val();
						$('#prescription_table tr')
								.each(
										function(i, el) {
											var $tds = $(this).find('td')
											var itemIdCheck = $($tds).closest(
													'tr').find("td:eq(15)")
													.find("input:eq(0)").attr(
															"id");
											var itemIdValue = $(
													'#' + itemIdCheck).val();
											var idddd = $(item).closest('tr')
													.find("td:eq(15)").find(
															"input:eq(0)")
													.attr("id");
											var currentidddd = $(item).closest(
													'tr').find("td:eq(0)")
													.find("input:eq(0)").attr(
															"id");
											//if(itemIds!="" &&  itemIdValue!="" && itemIdValue!="undefined" )
											if (itemIdCheck != checkCurrentNomRowId
													&& itemIds == itemIdValue) {
												if (itemIds == itemIdValue) {
													$('#' + idddd).val("");
													$('#' + currentidddd).val(
															"");
													alert("Nomenclature is already added");
													return false;

												}
											} else {
												$(item).closest('tr').find(
														"td:eq(1)").find(
														":input")
														.val(pvmsValue)
												$(item).closest('tr').find(
														"td:eq(15)").find(
														":input").val(itemIds)
											}

										});
					}
				}
				
				return true;

			}
			
		} else {
			return false;
		}
		
	}


	function getBatchList(item) {
		$(item).closest('tr').find("td:eq(14)").find(":input").val(itemIds);
		$(item).closest('tr').find("td:eq(15)").find(":input").val('0');
		$(item).closest('tr').find("td:eq(16)").find(":input").val($j('#hd_id').val());
		//$(item).closest('tr').find("td:eq(5)").find(":input").text('');
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "getBatchDetails",
			data : JSON.stringify({
				'item_id' : itemIds,
				'hospital_id':<%= hospitalId %>,
				'department_id': <%= departmentId %>
			}),
			dataType : 'json',
			timeout : 100000,
			success : function(res) {
				var batchData = res.batchData;
				var batchList = batchData.batch_list;
				item3 = batchList;
				var html = '';
				if(batchList.length == 0){
					return;
				}
				//html = '<option value="">Select</option>';
				html = '';
				for (var i = 0; i < batchList.length; i++) {
					html += '<option value="'+batchList[i].id+'">'
							+ batchList[i].batch_no + '</option>';
				
				}			       	   

				//if(stockId!="" && stockId.includes("newIdNew")){
				$(item).closest('tr').find("td:eq(5)").find(":input").append(html);
				$(item).closest('tr').find("td:eq(6)").find(":input").val(batchList[0].expiry_date);
				$(item).closest('tr').find("td:eq(9)").find(":input").val(batchList[0].batch_stock);				
				$(item).closest('tr').find("td:eq(10)").find(":input").val(batchData.disp_stock);
				$(item).closest('tr').find("td:eq(11)").find(":input").val(batchData.store_stock); 
				
				
			},
			error : function(jqXHR, exception) {
				alert("Error occured while contacting the server");
			}
		});
	}


	function setValue(item) {
		$(item).closest('tr').find("td:eq(6)").find(":input").val('');
		$(item).closest('tr').find("td:eq(9)").find(":input").val('');
		$('#prescription_table tr').each(function(i, el) {
			//var stockId= $(this).find("td:eq(13)").find("button:eq(0)").attr("id");
			var	stockId = item.id;
			if(stockId!="" && stockId.includes("stockId")){				
				var item2 = global_json;				
				for (var k = 0; k < item2.length; k++) {
					var bList = item2[k].batchList;
					for (var m = 0; m < bList.length; m++) {
						if (item.value == bList[m].stock_id) {
											
							$(item).closest('tr').find("td:eq(6)").find(":input").val(bList[m].date_of_expiry);
							$(item).closest('tr').find("td:eq(9)").find(":input").val(bList[m].batch_stock);
						}
					}
				}
			}else{
				var item2 = global_json;				
				for (var k = 0; k < item2.length; k++) {
					var bList = item2[k].batchList;
					for (var m = 0; m < bList.length; m++) {
						if (item.value == bList[m].stock_id) {
											
							$(item).closest('tr').find("td:eq(6)").find(":input").val(bList[m].date_of_expiry);
							$(item).closest('tr').find("td:eq(9)").find(":input").val(bList[m].batch_stock);
						}
					}
				}
			}
		});
		
	}

	function goBack() {
		window.location = "partialIssueWaitingJSP";
	}
	
	function issueMedicine(){
		var paramArray = new Array();
		var checkflag =  false;
		$('#prescription_table tr').each(function(i, el) {
			
	    	var $tds = $(this).find('td');
	    	var item = $tds.eq(0).find(":input").val();	
	    	var batchId = $tds.eq(5).find(":selected").val();
	    	var pres_qty = parseInt($tds.eq(7).find(":input").val());
	    	var issue_qty = parseInt($tds.eq(8).find(":input").val());	    	
	    	var it_id_first= $tds.eq(14).find(":input").val();
	    	
	    	var currentBacthStock = parseInt($tds.eq(9).find(":input").val());
	    	if(currentBacthStock >0){	    		
	    		var is_qt = parseInt($tds.eq(8).find(":input").val());	    		
	    		if(is_qt == '' || is_qt == 0 || isNaN(is_qt)){
	    			alert("Please enter issue quantity for item "+item);
	    			checkflag = true;
    				return false;
	    		}
	    	}
	    	var iss_qt = 0;
	    	var pr_qt = 0;
	    	var itemIssueCount = 0;
	    	var subloopFlag = false;
 	     	$('#prescription_table tr').each(function(j, e2){
	     		var $tds1 = $(this).find('td');	     		
	    		var it_id_second = $tds1.eq(14).find(":input").val();
	    		var batchValue = $tds1.eq(5).find(":selected").val();
	    		if(it_id_first == it_id_second && batchId == batchValue){	    			
	    			itemIssueCount++;
	    			if(itemIssueCount == 2){	    				
	    				subloopFlag = true;	  
	    				return false;;
	    			}
	    		}
	    		if(it_id_first == it_id_second){
	    			iss_qt = iss_qt + parseInt($tds1.eq(8).find(":input").val());		
	    			}
				});      	
	    		if(subloopFlag){
	    			alert("Duplicate medicine can not be issued");
	    			checkflag = true;
	    			return false;
	    		}
	    		
	    		if(iss_qt < pres_qty){
		    		var itemId = $tds.eq(14).find(":input").val();
		    		
		    		for(var m=0;m<global_json.length;m++){
						var item_id = global_json[m].item_id;
						if(item_id == itemId){ 
							var batchList = global_json[m].batchList;
							var total_items = 0;
							var batchCount = 0 ;
							for(var n=0;n<batchList.length;n++){
								total_items = total_items + parseInt(batchList[n].batch_stock);
								batchCount ++;
							}
							if(total_items > iss_qt && batchCount > 1){
								alert("Please issue the remaining quantity from another batch for the item "+item+"");
								checkflag = true;
								return false;
							}
						}
		    		}
		    	} 
	    	if(issue_qty == undefined || issue_qty == ''){
	    		issue_qty = 0;
			 }
	    	pres_qty = parseInt(pres_qty);
	    	issue_qty = parseInt(issue_qty);
	    	var dispens_stock = parseInt($tds.eq(10).find(":input").val());
	      	var batch_stock = parseInt($tds.eq(9).find(":input").val());
	    	/* if(issue_qty < pres_qty && pres_qty < batch_stock){
	    		alert("Please issue the prescribed quantity while enough stock is available");
	    		checkflag = true;
	    		return false;
	    	} */
	    	if(issue_qty > pres_qty){
	    		alert("Item quantity should not be greater than the prescribed quantity");
	    		checkflag = true;
	    		return false;
	    	}
	    	if(pres_qty > batch_stock && issue_qty > batch_stock){
	    		alert("No enough stock available for the selected batch for item "+item+"");
	    		checkflag = true;
	    		return false;
	    	}
		}); 
		if(checkflag){
			return ;
		}
		var batchFlag = false;
		var x = 0;
		var y = 0;
		$('#prescription_table tr').each(function(i, el) {
			
			var $tds = $(this).find('td');
				x++ ;
				var stockId = $tds.eq(5).find(":selected").val();
				
				var pre_qty = $tds.eq(7).find(":input").val();
				var it_id = $tds.eq(14).find(":input").val();	
				var itemTypeId = $tds.eq(18).find(":input").val();
				var m = 0;
				var checkDuplicateId = 0;
				var nisFlag = 'N';
				$('#prescription_table tr').each(function(j, eventL) {
					var $tdc = $(this).find('td');
					var nextItemId = $tdc.eq(14).find(":input").val();
					if(it_id == nextItemId){
						checkDuplicateId++;
					}
					if(checkDuplicateId == 1){
						var disp_stock = parseInt($tdc.eq(10).find(":input").val());
						 var p_qt = parseInt($tdc.eq(7).find(":input").val());
						 var s_stock = parseInt($tds.eq(11).find(":input").val());
						 if(disp_stock < p_qt && s_stock == 0){
							 if(parseInt(itemTypeId) == 1 || parseInt(itemTypeId) == 01){
									nisFlag = 'Y';
								}
						 }
						 checkDuplicateId++;
					}
					if(j <= i){
						return;
					}					
					var it_id2 = $tdc.eq(14).find(":input").val();
					if(it_id == it_id2){
						m++;
					}					
				});
				
				if(m>0){
					pre_qty = $tds.eq(8).find(":input").val();
				}
				
				if(stockId == undefined || stockId == ''){					
					batchFlag = true;
					y++;
				}
				batchFlag = false;
				 var qtyIssued = $tds.eq(8).find(":input").val();
				 if(qtyIssued == undefined || qtyIssued == ''){
					 qtyIssued = 0;
				 }
				 var storeStock = $tds.eq(11).find(":input").val();
				 if(storeStock == undefined || storeStock == ''){
					 storeStock = 0;
				 }
				 var detailId = $tds.eq(15).find(":input").val();
				 if(detailId == undefined || detailId == ''){
					 detailId = 0;
				 }
		 		var rowData = { 
				  "qty_prescribed": pre_qty,
				  "dosage": $tds.eq(2).find(":input").val(),
				  "frequency": $tds.eq(3).find(":input").val(),
				  "no_of_days": $tds.eq(4).find(":input").val(),				  
				  "qty_issued": qtyIssued,			 
				  "stock_id": $tds.eq(5).find(":selected").val(),
				  "batch_no": $tds.eq(5).find(":selected").text(),
				  "date_of_expiry": $tds.eq(6).find(":input").val(),
				  "batch_stock": $tds.eq(9).find(":input").val(),
				  "disp_stock": $tds.eq(10).find(":input").val(),
				  "store_stock": storeStock,
				  "item_id": $tds.eq(14).find(":input").val(),
				  "detail_id": detailId,
				  "header_id": $tds.eq(16).find(":input").val(),
				  "frequency_id": $tds.eq(17).find(":input").val(),
				  "nisFlag":nisFlag
		 		 }		    	
		    	paramArray.push(rowData);	 		
		 		
		}); 
		
		if(x == y && batchFlag == true){
			alert("No Stock available");
			return;
		}
		console.log(JSON.stringify(paramArray));
		
		var params = {
			"dtData": paramArray,
			"hospital_id": <%= hospitalId %>,
			"department_id": <%= departmentId %>,
			"user_id": <%= user_id %>,
			"header_id": $('#hd_id').val()
		}
		var input = JSON.stringify(params);
 		console.log("input is "+input);
 		$('#submit_btn').attr("disabled", true);
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "partialIssueMedicineFromDispensary",
			data :input,
			dataType : 'json',
			timeout : 100000,
			success : function(res) {
				if(res.msg == 'success'){					
					var headerId = $('#hd_id').val();
					window.location = "partialIssueSubmit?id="+headerId+"";
				}else{
					alert(res.msg);	
					$('#submit_btn').attr("disabled", false);	
				}
			},
			error : function(jqXHR, exception) {
				$('#submit_btn').attr("disabled", true);
				alert("Error occured while contacting the server");
			}
		});
		
	}
	 function commonForAutoPopulate(val){
		autocomplete(val, arryNomenclature);
	} 
</script>


<body>
	<!-- Begin page -->
	<div id="wrapper">


		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">Partial Issue</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">


									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Service
														No.</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="service_no"
														readonly />
												</div>
											</div>
										</div>

										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Patient
														Name</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="patient_name"
														readonly />
												</div>
											</div>
										</div>

										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Relation</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="relation"
														readonly />
												</div>
											</div>
										</div>

										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Employee
														Name</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="employee_name"
														readonly />
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Age</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="age" readonly />
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Gender</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="gender"
														readonly />
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Doctor</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="doctor_name"
														readonly />
												</div>
											</div>
										</div>										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Prescription
														Date</label>
												</div>
												<div class="col-md-7">
													<div class="dateHolder">
														<!-- <input type="text"
															class="calDate datePickerInput form-control"
															placeholder="DD/MM/YYYY" value="" maxlength="10" id="prescription_date"/> -->
														<input type="text" class="form-control"
															id="prescription_date" readonly />
													</div>
												</div>
											</div>
										</div>

										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Issue
														Date</label>
												</div>
												<div class="col-md-7">
													<div class="dateHolder">
															<input type="text" class="form-control"
															id="issue_date" readonly />
													</div>
												</div>
											</div>
										</div>
									</div>


									<div class="table-responsive">
										<table
											class="table table-hover table-striped table-bordered table-compressed m-t-10">
											<thead class="bg-primary">
												<tr>

													<th>Nomenclature/PVMS No.</th>
													<th>A/U</th>													
													<th>Dosage</th>
													<th>Frequency</th>
													<th>No. of Days</th>													
													<th>Batch No.</th>
													<th>DOE</th>
													<th>Qty Prescribed</th>
													<th>Qty Issued</th>
													<th>Batch Stock</th>
													<th>Stock in Dispensary</th>
													<th>Stock in Med Store</th>													
													<th>Add</th>
													<th>Delete</th>
												</tr>
											</thead>
											<tbody id="prescription_table">

											</tbody>
										</table>
									</div>

									<div class="row">
										<div class="col-md-12 m-t-10 text-right">
											<button type="submit" id="submit_btn" class="btn btn-primary" onclick="issueMedicine()">Submit</button>
										
											<button type="submit" class="btn btn-primary"
												onclick="goBack()">Back</button>
										</div>
									</div>
									<input type="hidden" id="hd_id" value="">


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

	</div>
	<!-- END wrapper -->

</body>

</html>