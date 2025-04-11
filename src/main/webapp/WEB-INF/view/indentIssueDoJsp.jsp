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

			String departmentId = "0";
			if (session.getAttribute("department_id") != null) {
				departmentId = session.getAttribute("department_id") + "";
			}
			
			
			String id = request.getParameter("id");
			
			String districtId = "0";
			if (session.getAttribute("distIdUsers") != null) {
				districtId  = session.getAttribute("distIdUsers") + "";
				districtId = districtId.replace(",","");
			}
%>
	var nPageNo=1;
	var $j = jQuery.noConflict();
	
	$j(document).ready(function(){
		getIndentIssue();
	});
	var global_json;
	var data = '';
	var item3 = '';
	var x = '';
	function getIndentIssue() {
		var response = ${response};
		$('#indent_no').val(response.headerList[0].indent_no);
		$('#indent_date').val(response.headerList[0].indent_date);
		$('#requested_by').val(response.headerList[0].requested_by);
		$('#issue_date').val(currentDateInddmmyyyy());
		$('#hd_id').val(response.headerList[0].header_id);
		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "getIndentIssueDetailsDo",
			data : JSON.stringify({
				'id' : <%= id %>,
				'districtId' : <%=districtId%>
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
					var nomenclature = detailList[i].nomenclature + '['+ detailList[i].pvsm_no + ']';
					var itemId = detailList[i].item_id;
					var comboList = detailList[i].batchList;
					var combo = '';
					var doe = '';
					var batch_stock = '';
					var dom = '';
					var balance_after_issue = 0;
					var lengthOfCombo = comboList.length;
					if (comboList.length > 0) {
						//combo += '<option value="">Select</option>';
						combo += '';
						for (var j = 0; j < comboList.length; j++) {
							if (j == 0) {
								combo += '<option value="'+comboList[j].stock_id+'" selected>'
										+ comboList[j].batch_no + '</option>';
								doe = comboList[j].expiry_date;
								batch_stock = comboList[j].batch_stock;
								dom = comboList[j].date_of_manufacturing;
								if(parseInt(detailList[i].qty_requested) <= parseInt(batch_stock)){
									balance_after_issue = batch_stock - detailList[i].qty_requested;
								}else{
									balance_after_issue = 0;
								}
								
							} else {
								combo += '<option value="'+comboList[j].stock_id+'">'
										+ comboList[j].batch_no + '</option>';
							}
		
						}
					}
					var qtyRequested = detailList[i].qty_requested;
					html += '<tr id="rowId'+i+'" value="'+detailList[i].detail_id+'">';
					html += '<td><div class="autocomplete forTableResp"><input type="text" class="form-control width330" onkeypress="commonForAutoPopulate(this)" onblur="populatePVMS(this.value,1,this);" value="'+ nomenclature + '" readonly/></div></td>';
					html += '<td><input type="text" class="form-control width80" value="'+detailList[i].au+'" readonly/></td>';
					html += '<td><select class="form-control width100" id="batchNo'+i+'" onchange="setValue(this);calculateBalance(this);updateBalance(this)">'+combo+'</select></td>';
					html += '<td><input type="text" class="form-control width90" id="date_of_manufacturing'+i+'" value="'+dom+'" readonly/></td>';
					html += '<td><input type="text" class="form-control width90" id="date_of_expiry'+i+'" value="'+doe+'" readonly/></td>';	
					html += '<td><input type="text" class="form-control width60" value="'+qtyRequested+'" readonly/></td>';
					if(lengthOfCombo != 0){
						
						if(parseInt(qtyRequested) > parseInt(batch_stock)){
							html += '<td><input type="text" class="form-control width60" onkeypress="return isNumber(event);" onblur="updateBalance(this)" value="'+batch_stock+'"/></td>';
						}else{
							html += '<td><input type="text" class="form-control width60" onkeypress="return isNumber(event);" onblur="updateBalance(this)" value="'+qtyRequested+'"/></td>';
						}
						
					}else{
						html += '<td><input type="text" class="form-control width60" onkeypress="return isNumber(event);" onblur="updateBalance(this)" value="0"/></td>';
					}					
					html += '<td><input type="text" class="form-control width60" value="'+balance_after_issue+'" readonly/></td>';
					if(lengthOfCombo != 0){
						html += '<td><input type="text" class="form-control width60" id="batch_stock'+i+'" value="'+batch_stock+'" readonly/></td>';
					}else{						
						html += '<td><input type="text" class="form-control width60" id="batch_stock'+i+'" value="0" readonly/></td>';
					}					
					html += '<td><input type="text" class="form-control width60" value="'+detailList[i].disp_stock+'" readonly></td>';
					console.log("previous qty "+detailList[i].previousQtyissued);
					html += '<td><input type="text" class="form-control width60" value="'+detailList[i].previousQtyissued+'" readonly/></td>';
					html += '<td><button type="button" class="btn btn-primary noMinWidth" id="add_row" button-type="add" onclick="addNomenclatureRow(this);"></button></td>';
					html += '<td><button type="button" class="btn btn-danger noMinWidth" id="delete_row" button-type="delete"  style="display:none;" onclick="removeGridRow(this)"></button></td>';
					html += '<td style="display: none";><input type="hidden" value="'+detailList[i].item_id+'" tabindex="1" id="pvsm_no" size="77"	name="pvsmNo" /></td>';
					html += '<td style="display: none"><input type="hidden" value="'+detailList[i].detail_id+'" id="detail_id"></td>';
					html += '</tr>';
				}
			$('#indent_table').append(html);
			if(<%= departmentId %> == '0'){
				//$("#indent_table").find("input,button,textarea,select").attr("disabled", "disabled");
			}
		},
		error : function(jqXHR, exception) {
			alert("Error occured while contacting the server");
		}
	});
	}
	var rowId = '';	

	var i = 0;
	function addNomenclatureRow(item) {
		//$(item).closest('tr').find("td:eq(8)").find('#selectionChamp option:selected').next().val();
		//return ;
		var b_stock = parseInt($(item).closest('tr').find("td:eq(8)").find(":input").val());
		var d_stock = parseInt($(item).closest('tr').find("td:eq(9)").find(":input").val());
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
		var demanded_qty = $(item).closest('tr').find("td:eq(5)").find(":input").val();
		var issued_qty = $(item).closest('tr').find("td:eq(6)").find(":input").val();
		var itemId = $(item).closest('tr').find("td:eq(13)").find(":input").val();
		var remaining_qt = demanded_qty - issued_qty;
		var selectedBatchValue = $(item).closest('tr').find("td:eq(2)").find(":input").val();
		var optionList = '';
		var exp_date = '';
		var batchSt = '';
		var batchList = "";
		var stk_id = "";
		var mfg_date = "";
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
						exp_date = batchList[b].expiry_date;
						mfg_date = batchList[b].date_of_manufacturing;
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
		aClone.find("td:eq(5)").find(":input").val(remaining_qt);
		aClone.find("td:eq(6)").find(":input").val(iss_qty);
		var balanceAfterIssue = parseInt(batchSt) - remaining_qt;
		if(parseInt(balanceAfterIssue) < 1){
			balanceAfterIssue = 0;
		}
		aClone.find("td:eq(7)").find(":input").val(balanceAfterIssue);
		aClone.find("td:eq(2)").find(":input").text("");
		aClone.find("td:eq(2)").find('select').append(optionList);
		aClone.find("td:eq(3)").find(":input").val(mfg_date);
		aClone.find("td:eq(4)").find(":input").val(exp_date);
		aClone.find("td:eq(8)").find(":input").val(batchSt);
		//aClone.find("td:eq(13)").find(":input").val('');

		aClone.find('input[type="text"]').prop('id', 'nomenclature' + i + '');
		//aClone.find("option[selected]").removeAttr("selected");
		aClone.find("td:eq(11)").find("button:eq(0)").removeAttr("style");
		aClone.find("td:eq(2)").find(":input").prop('id', 'stockId' + i + '');
		aClone.clone(true).appendTo('#indent_table'); 	
		$('#indent_table>tr:last').find("td:eq(11)").find('button:eq(0)').attr("id","newIdNew");
	}

	function calculateBalance(item){
		var demandedQty = $(item).closest('tr').find("td:eq(5)").find(":input").val();
		var issuedQty = $(item).closest('tr').find("td:eq(6)").find(":input").val();
		var bStock = $(item).closest('tr').find("td:eq(8)").find(":input").val();
		var balanceAfterIssued = parseInt(bStock) - parseInt(issuedQty);
		$(item).closest('tr').find("td:eq(7)").find(":input").val(balanceAfterIssued);
	}
	
	function updateBalance(item){
		var itemId = $(item).closest('tr').find("td:eq(13)").find(':input').val();
		var batchNo = $(item).closest('tr').find("td:eq(2)").find(':selected').text();
		var issuedQty = $(item).closest('tr').find("td:eq(6)").find(':input').val();
		var currentBalance = $(item).closest('tr').find("td:eq(8)").find(':input').val();
		if(issuedQty == ''){
			$(item).closest('tr').find("td:eq(7)").find(':input').val(currentBalance);
			return;
		}
		var totalIssuedQty = 0;
		$('#indent_table tr').each(function(i, e) {
			var $tds = $(this).find('td');	     		
    		var itemId2 = $tds.eq(13).find(":input").val();
    		var issQty = $tds.eq(6).find(":input").val();
    		var batchNo2 = $tds.eq(2).find(":selected").text();    		
			if (batchNo == batchNo2) {
				if (parseInt(itemId) == parseInt(itemId2)) {
					totalIssuedQty = totalIssuedQty + parseInt(issQty);
				}
			}
		});		
		var batchStock = $(item).closest('tr').find("td:eq(8)").find(':input').val();
		var updatedValue = parseInt(batchStock) - parseInt(totalIssuedQty);
		$(item).closest('tr').find("td:eq(7)").find(':input').val(updatedValue);

	}

	function removeGridRow(val) {

		if ($('#indent_table tr').length > 1) {
			$(val).closest('tr').remove();
		}
	}

	var arryNomenclature = new Array();
	/* var val = $('#indent_table').children('tr:first')
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
						$('#indent_table tr')
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
													alert("Drug name is already added");
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
	
	function populateDateInRow(item){
		
	}


 	function getBatchList(item) {
		$(item).closest('tr').find("td:eq(14)").find(":input").val(itemIds);
		$(item).closest('tr').find("td:eq(15)").find(":input").val('0');
		$(item).closest('tr').find("td:eq(16)").find(":input").val($j('#hd_id').val());
		//$(item).closest('tr').find("td:eq(7)").find(":input").text('');
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
				$(item).closest('tr').find("td:eq(7)").find(":input").append(html);
				$(item).closest('tr').find("td:eq(8)").find(":input").val(batchList[0].expiry_date);
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
		$(item).closest('tr').find("td:eq(3)").find(":input").val('');
		$(item).closest('tr').find("td:eq(4)").find(":input").val('');
		$(item).closest('tr').find("td:eq(8)").find(":input").val('');
		$('#indent_table tr').each(function(i, el) {
			//var stockId= $(this).find("td:eq(13)").find("button:eq(0)").attr("id");
			var	stockId = item.id;
			if(stockId!="" && stockId.includes("stockId")){				
				var item2 = global_json;				
				for (var k = 0; k < item2.length; k++) {
					var bList = item2[k].batchList;
					for (var m = 0; m < bList.length; m++) {
						if (item.value == bList[m].stock_id) {
							$(item).closest('tr').find("td:eq(3)").find(":input").val(bList[m].date_of_manufacturing);
							$(item).closest('tr').find("td:eq(4)").find(":input").val(bList[m].expiry_date);
							$(item).closest('tr').find("td:eq(8)").find(":input").val(bList[m].batch_stock);							
						}
					}
				}
			}else{
				var item2 = global_json;				
				for (var k = 0; k < item2.length; k++) {
					var bList = item2[k].batchList;
					for (var m = 0; m < bList.length; m++) {
						if (item.value == bList[m].stock_id) {											
							$(item).closest('tr').find("td:eq(3)").find(":input").val(bList[m].date_of_manufacturing);
							$(item).closest('tr').find("td:eq(4)").find(":input").val(bList[m].expiry_date);
							$(item).closest('tr').find("td:eq(8)").find(":input").val(bList[m].batch_stock);
						}
					}
				}
			}
		});
		
	}

	function goBack() {
		window.location = "pendingIndentIssueWaitingListDo";
	}
	
	function issueMedicine(flag){
		//$('#submit_btn').attr("disabled", true);
		var paramArray = new Array();
		var checkflag =  false;
		var row_length = document.getElementById("indent_table").rows.length;
		var batchFlag = true;
		$('#indent_table tr').each(function(i, el) {
			
	    	var $tds = $(this).find('td');
	    	var item = $tds.eq(0).find(":input").val();	
	    	var batchId = $tds.eq(2).find(":selected").val();
	    	/* if(batchId == undefined || batchId == ''){	    		    	
	    		alert("Please select Batch No. for item "+item+"");
	    		checkflag = true;
	    		return false;    		
	    	} */
	    	if(batchId != undefined && batchId != ''){
	    		batchFlag = false;
	    	}
	    	
	    	var pres_qty = parseInt($tds.eq(5).find(":input").val());
	    	var issue_qty = parseInt($tds.eq(6).find(":input").val());
	    	var balanceAfterIssue = parseInt($tds.eq(7).find(":input").val());
	    	var currentBacthStock = parseInt($tds.eq(8).find(":input").val());
	    	if(currentBacthStock >0){	    		
	    		var is_qt = parseInt($tds.eq(6).find(":input").val());
	    		if(is_qt === '' ||  isNaN(is_qt)){
	    			alert("Please enter issue quantity for item "+item);
	    			checkflag = true;
    				return false;
	    		}
	    	}
	    	var it_id_first= $tds.eq(13).find(":input").val();
	    	var iss_qt = 0;
	    	var pr_qt = 0;
	    	var itemIssueCount = 0;
	    	var subloopFlag = false;
	    	if(issue_qty == undefined || issue_qty == ''){
	    		issue_qty = 0;
			 }
 	     	$('#indent_table tr').each(function(j, e2){
	     		var $tds1 = $(this).find('td');	     		
	    		var it_id_second = $tds1.eq(13).find(":input").val();
	    		var batchValue = $tds1.eq(2).find(":selected").val();
	    		if(it_id_first == it_id_second && batchId == batchValue){	    			
	    			itemIssueCount++;
	    			if(itemIssueCount == 2){	    				
	    				subloopFlag = true;	  
	    				return false;
	    			}
	    		}
	    		if(it_id_first == it_id_second){
	    			iss_qt = iss_qt + parseInt($tds1.eq(6).find(":input").val());		
	    			}
				});      	
	    		if(subloopFlag){
	    			alert("Duplicate batch cannot be issued");
	    			checkflag = true;
	    			return false;
	    		}
 		    	if(iss_qt < pres_qty){
		    		var itemId = $tds.eq(13).find(":input").val();
		    		
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
							/* if(total_items > iss_qt && batchCount > 1){
								alert("Please issue the remaining quantity from another batch for the item "+item+"");
								checkflag = true;
								return false;
							} */
						}
		    		}
		    	} 
 		    
 		     		    	

	    	
	    	pres_qty = parseInt(pres_qty);
	    	issue_qty = parseInt(issue_qty);
	    	var dispens_stock = parseInt($tds.eq(9).find(":input").val());
	    	var batch_stock = parseInt($tds.eq(8).find(":input").val());
	    	/* if(issue_qty < pres_qty && pres_qty < batch_stock){
	    		alert("Please issue medicine equal to the Requested quantity while enough stock is available");
	    		checkflag = true;
	    		return false;
	    	} */
	    	
	    	/* if(issue_qty > pres_qty){
	    		alert("Issue quantity should not be greater than the Requested quantity");
	    		checkflag = true;
	    		return false;
	    	} */
	    	if(pres_qty > batch_stock && issue_qty > batch_stock){
	    		alert("Issued quantity shouldn't be greater than batch stock quantity for item "+item+"");
	    		checkflag = true;
	    		return false;
	    	}
		}); 
		
		if(checkflag){
			return ;
		}
		
		if(batchFlag){
			alert("Please select batch no.");
			return;
		}
		
		var batchFlag = false;
		var x = 0;
		var y = 0;
		$('#indent_table tr').each(function(i, el) {
			
			var $tds = $(this).find('td');
				x++ ;
				var pre_qty = $tds.eq(5).find(":input").val();
				var it_id = $tds.eq(13).find(":input").val();
				var stockId = $tds.eq(2).find(":selected").val();
				var m = 0;
				$('#indent_table tr').each(function(j, eventL) {					
					if(j <= i){
						return;
					}
					var $tdc = $(this).find('td');
					var it_id2 = $tdc.eq(13).find(":input").val();
					if(it_id == it_id2){
						m++;
					}					
				});
				
				if(m>0){
					pre_qty = $tds.eq(6).find(":input").val();
				}
				
				batchFlag = false;
				 var qtyIssued = $tds.eq(6).find(":input").val();
				 if(qtyIssued == undefined || qtyIssued == ''){
					 qtyIssued = 0;
				 }
				 //var storeStock = $tds.eq(10).find(":input").val();
				 /* if(storeStock == undefined || storeStock == ''){
					 storeStock = 0;
				 } */
				 var detailId = $tds.eq(14).find(":input").val();
				 if(detailId == undefined || detailId == ''){
					 detailId = 0;
				 }
		 		var rowData = { 
				  "qty_demanded": pre_qty,			  
				  "qty_issued": qtyIssued,	
				  "balance_after_issue": $tds.eq(7).find(":input").val(),
				  "stock_id": $tds.eq(2).find(":selected").val(),
				  "batch_no": $tds.eq(2).find(":selected").text(),
				  "date_of_manufacturing": $tds.eq(3).find(":input").val(),
				  "date_of_expiry": $tds.eq(4).find(":input").val(),
				  "batch_stock": $tds.eq(8).find(":input").val(),
				  "disp_stock": $tds.eq(9).find(":input").val(),
				  "item_id": $tds.eq(13).find(":input").val(),
				  "detail_id": detailId
		 		 }		    	
		    	paramArray.push(rowData);	 		
		 		
		}); 
		
		/* if(x == y && batchFlag == true){
			alert("No Stock available");
			return;
		} */
		console.log(JSON.stringify(paramArray));
		
		var params = {
			"dtData": paramArray,
			"districtId": <%= districtId %>,
			"user_id": <%= user_id %>,
			"header_id": $('#hd_id').val(),
			"flag":flag
		}
		var input = JSON.stringify(params);
 		console.log("input is "+input);
 		if(flag == 'p'){
 			$('#submit_btn').attr("disabled", true);
 		}else{
 			$('#btnSumbit').attr("disabled", true);
 		}
 		
 		/* $('#submit_btn').attr("disabled", true); */
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "indentIssueDo",
			data :input,
			dataType : 'json',
			timeout : 100000,
			success : function(res) {
				
				if(res.msg == 'success'){					
					var headerId = $('#hd_id').val();
					window.location = "indentSubmitDo?id="+headerId+"";
				}else{
					alert(res.msg);	
					if(flag == 'p'){
			 			$('#submit_btn').attr("disabled", false);
			 		}else{
			 			$('#btnSumbit').attr("disabled", false);
			 		}
				}
				
			},
			error : function(jqXHR, exception) {
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
					<div class="internal_Htext">Indent Issue (DO)</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<form id="indent_form" name="indent_form">
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Indent No.</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="indent_no"
														readonly />
												</div>
											</div>
										</div>

										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Indent
														Date</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="indent_date"
														readonly />
												</div>
											</div>
										</div>

										<!-- <div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">From Department</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="from_dept"
														readonly />
												</div>
											</div>
										</div> -->

										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Requested By</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="requested_by"
														readonly />
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Issue Date</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="issue_date" readonly />
												</div>
											</div>
										</div>
									</div>

									<div class="table-responsive">
										<table
											class="table table-hover table-striped table-bordered table-compressed m-t-10">
											<thead class="bg-primary">
												<tr>
													<th>Drug Name/Drug Code</th>
													<th>A/U</th>													
													<th>Batch No.</th>
													<th>DOM</th>
													<th>DOE</th>
													<th>Qty Demanded</th>
													<th>Qty Issued</th>
													<th>Balance After Issue</th>
													<th>Batch Stock</th>
													<th>Available Stock</th>		
													<th>Previous Issued Qty</th>																			
													<th>Add</th>
													<th>Delete</th>
												</tr>
											</thead>
											<tbody id="indent_table"></tbody>
										</table>
									</div>

									<div class="row">
										<div class="col-md-12 m-t-10 text-right">
											<!-- <button type="button" id="submit_btn" class="btn btn-primary" onclick="issueMedicine()">Submit</button> -->
										
										<div class="col-12 text-right">
											<input type="button" class="btn btn-primary" id="submit_btn"
														value="Partially Issue" onclick="issueMedicine('p')" />
											<input type="button" class="btn btn-primary" id="btnSumbit"
														value="Fully Issue" onclick="issueMedicine('f')" />
											<button type="button" class="btn btn-primary"
												onclick="goBack()">Back</button>
										</div>
											
										</div>
									</div>
									</form>
									<input type="hidden" id="hd_id" value="">
									<input type="hidden" id="from_dept_id" value="">
									<input type="hidden" id="fwcHospitalId" name="fwcHospitalId" value="">									

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