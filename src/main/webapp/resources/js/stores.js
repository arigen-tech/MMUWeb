function calculateAmount(rowVal) {
	
	if(isNaN(document.getElementById('quantityId'+ rowVal).value)){
		alert("Quantity must be numeric");
		$('#quantityId'+ rowVal).val('');
		return;
	}else{
		var quantity = parseFloat(document.getElementById('quantityId'
				+ rowVal).value);
	}
	if(isNaN(document.getElementById('unitRateId'+ rowVal).value)){
		alert("Unit Rate must be a numeric");
		$('#unitRateId'+ rowVal).val('');
		return;
	}else{
		var unitRate = parseFloat(document.getElementById('unitRateId'
				+ rowVal).value)
	}

	var amount= quantity * unitRate;
	if(isNaN(amount)){
		document.getElementById('amountId' + rowVal).value="";
	}else{
		document.getElementById('amountId' + rowVal).value = parseFloat(amount).toFixed(2) ;
	}
	
}

/*Below code is used for getting all item list for inventory */

/*var nomenclatureArry = new Array();
var pvmsNumberArry = new Array();
var itemDataList = '';

function getStoreItemList(rowCount) {
	
	pvmsNumberArry=[];
	nomenclatureArry=[];
	
	var hospitalId = $j('#hospitalId').val();
	var itemGroupId = $j('#itemGroupId').val();
	var itemTypeId = $j('#itemTypeId').val();
	var itemSectionId= $j('#itemSectionId').val();
	var itemClassId=$j('#itemClassId').val();
	
	var params = {
		"hospitalId" : hospitalId,
		"itemGroupId" : itemGroupId,
		"itemTypeId" : itemTypeId,
		"itemSectionId" : itemSectionId,
		"itemClassId" : itemClassId
	}
	$j.ajax({
		type : "POST",
		contentType : "application/json",
		url : 'getStoreItemList',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(res) {
			if (res.status == "1") {
				pvmsNumberArry=[];
				nomenclatureArry=[];
				itemDataList = res.storeItemList;
				for (i = 0; i < itemDataList.length; i++) {
					itemId = itemDataList[i].itemId;
					nomenclatureList = itemDataList[i].nomenclature;
					nomenclatureName = nomenclatureList + "[" + itemId
							+ "]";
					nomenclatureArry.push(nomenclatureName);

					pvmsNumberList = itemDataList[i].pvmsNumber;
					pvmsNumberArry.push(pvmsNumberList);

				}
				

			} else {
				
			}

		},
		error : function(msg) {
			alert("An error has occurred while contacting the server");
		}
	});

}*/


function fillItemAndValues(item, psvn_nomen) {
	var count = item.substring(12); // this code commonly use for pvmsNumberId/nomenclturId input 
	var index1 = psvn_nomen.lastIndexOf("[");
	var index2 = psvn_nomen.lastIndexOf("]");
	index1++;
	var itemId = psvn_nomen.substring(index1, index2);
	
	for (var i = 0; i < itemDataList.length; i++) {
		if (psvn_nomen == itemDataList[i].pvmsNumber) {
			$('#itemId' + count).val(itemDataList[i].itemId);
			$('#pvmsNumberId' + count).val(itemDataList[i].pvmsNumber);
			$('#nomenclturId' + count).val(itemDataList[i].nomenclature);
			$('#unitId' + count).val(itemDataList[i].unitName);
			$('#itemUnitId' + count).val(itemDataList[i].unitId);
			

		} else if (itemId == itemDataList[i].itemId) {
			$('#itemId' + count).val(itemDataList[i].itemId);
			$('#pvmsNumberId' + count).val(itemDataList[i].pvmsNumber);
			$('#nomenclturId' + count).val(itemDataList[i].nomenclature);
			$('#unitId' + count).val(itemDataList[i].unitName);
			$('#itemUnitId' + count).val(itemDataList[i].unitId);
		}
	}

}

/*Below code is used for comparing From and To Dates */

$j('body').on("focus",".comapre_date", function() {
  	 $j(this).datepicker({ showOn: "button",
  		buttonImage: "../resources/images/calendar.gif",		
		buttonImageOnly: true,
		dateFormat: 'dd/mm/yy',
		buttonText: 'Select Date',
		selectWeek:false,
		closeOnSelect:true,  
		changeMonth: true, 
		changeYear: true,
		clickInput:false,
		onSelect: function(dateText) {
	      display(this);
	      $(this).change();
	    }
  	 }).on("change", function() {
	    display("Change event");  
  	 });
  	function display(ides) {
  		checkDate(ides);  
  	}
  });


function checkDate(item){
	  var doeDateId=$(item).closest('tr').find("td:eq(6)").find("input:eq(0)").attr("id");
	  var domDateId=$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
	  
	  var doeDate = $('#'+doeDateId).val();
	  var domDate = $('#'+domDateId).val();
	  
	 if(process(doeDate) < process(domDate)){
			alert("Expiry Date should not be earlier than Manufacturing Date");
			$('#'+doeDateId).val("");
			return;
	 }
	 return true;
}


/*Below code is used for hiding  future date in calendar */

$j('body').on("focus",".noFuture_dateStore", function() {
	 $j(this).datepicker({ showOn: "button",
		buttonImage: "../resources/images/calendar.gif",		
		buttonImageOnly: true,
		dateFormat: 'dd/mm/yy',
		buttonText: 'Select Date',
		selectWeek:false,
		closeOnSelect:true,  
		changeMonth: true, 
		changeYear: true,
		clickInput:false,
		maxDate: new Date(),
		onSelect: function(dateText) {
	      display(this);
	      $(this).change();
	    }
	 }).on("change", function() {
	    display("Change event");  
	 });
	function display(ides) {
		compareDate();  
	}
});


/*Below code is used for getting all item list for inventory on key press event, using in physical stock taking*/

/*var nomenclatureArry = new Array();
var pvmsNumberArry = new Array();
var itemDataList = '';

	function getAutoPopulate(count){
	 nomenclatureArry=[];
	 pvmsNumberArry=[];
	 var hospitalId = $('#hospitalId').val();
	 var pvmsNo = $('#pvmsNumberId'+count).val();
	 var nomenclturId = $('#nomenclturId'+count).val();
	 var itemId='';
	 var params = {
				"hospitalId" : hospitalId,
				"pvmsNo" : pvmsNo,
				"nomenclturId" : nomenclturId,
				"itemId":itemId
			}
			$.ajax({
				type : "POST",
				contentType : "application/json",
				url : 'getItemListForAutoComplete',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				async: true,
				success : function(response) {
					if (response.status == "1") {
						nomenclatureArry=[];
						pvmsNumberArry=[];
						itemDataList = response.respStoreItemList;
						for(i in itemDataList){
							itemId = itemDataList[i].itemId;
							
							nomenclatureList = itemDataList[i].nomenclature;
							nomenclatureName = nomenclatureList + "[" + itemId
									+ "]";
							nomenclatureArry.push(nomenclatureName);

							pvmsNumberList = itemDataList[i].pvmsNo;
							pvmsNumberArry.push(pvmsNumberList);

						}
						
						
					} 
					else{
						
					}
				},
				error : function(msg) {
					alert("An error has occurred while contacting the server");
				}
			});
	 }
 */

/*Below code is used for to fill data on key press auto complete and provide the stock list available in inventory*/	
 var batchList='';
 var batchData = '';
 function fillItemAndValuesFromAutoComplete(item, psvn_nomen) {
	 var itemId='';
	 var pvmsNo='';
	 var nomenclturId='';
	 var count = item.substring(12); // this code commonly use for pvmsNumberId/nomenclturId input 
		 if(psvn_nomen!=""){
			var index1 = psvn_nomen.lastIndexOf("[");
			var index2 = psvn_nomen.lastIndexOf("]");
			index1++;
		 
			if(item.includes('pvmsNumberId')){
				pvmsNo=psvn_nomen;
			}else if(item.includes('nomenclturId')){
				itemId = psvn_nomen.substring(index1, index2);
			}
			
			var mmuId = $('#mmuId').val();
			var departmentId = $('#departmentId').val();
			if(itemId!="" || pvmsNo!=""){
				var params = {
						"itemId" : itemId,
						"pvmsNo" : pvmsNo,
						"mmuId" : mmuId,
						"nomenclturId" : nomenclturId
						
					}
				$.ajax({
					type : "POST",
					contentType : "application/json",
					url : 'getItemListForAutoComplete',
					data : JSON.stringify(params),
					dataType : "json",
					cache : false,
					success : function(response) {
						if (response.status == "1") {
							var itemValueList = response.storeItemList;
							var itemIdNew ='';
							for (i = 0; i < itemValueList.length; i++) {
									itemIdNew= itemValueList[i].itemId;
									 $('#itemId' + count).val(itemValueList[i].itemId);
									 $('#nomenclturId' + count).val(itemValueList[i].nomenclature + "[" + itemIdNew + "]");
									 $('#pvmsNumberId' + count).val(itemValueList[i].pvmsNumber);
									 
								}
							
							var paramsNew = {
									"mmuId" : mmuId,
									"department_id" : departmentId,
									"item_id" : itemIdNew,
									"stockAdjustFlag": "p"
								}
							$.ajax({
								type : "POST",
								contentType : "application/json",
								url : 'getItemStockDetailsFromStore',
								data : JSON.stringify(paramsNew),
								dataType : "json",
								cache : false,
								success : function(response) {
									
									document.getElementById("batchNumberId"+count).options.length = 1;
									document.getElementById("doeDate"+count).value = '';
									document.getElementById("computedStock"+count).value = '';
									document.getElementById("physicalStock"+count).value ='';
									document.getElementById("surplus"+count).value ='';
									document.getElementById("deficient"+count).value ='';
									document.getElementById("remark"+count).value ='';
									
									var html='';
									batchList = response.batchData.batch_list; 
									if (batchList.length>0) {
										for (i = 0; i < batchList.length; i++) {
											html += '<option value="'+batchList[i].id+'">'
											+ batchList[i].batch_no + '</option>';	
										}
										$('#batchNumberId'+count).append(html);
									}else{
										alert("Item is not available in stock.");
										document.getElementById("nomenclturId"+count).value = '';
										document.getElementById("pvmsNumberId"+count).value = '';
										document.getElementById("itemId"+count).value = '';
									}
									
									
								},
								error : function(msg) {
									alert("An error has occurred while contacting the server");
								}
							});
						} 
					},
					error : function(msg) {
						alert("An error has occurred while contacting the server");
					}
				});
			}
	}else{
		// psvn_nomen is blank
		document.getElementById("nomenclturId"+count).value = '';
		document.getElementById("pvmsNumberId"+count).value = '';
		document.getElementById("itemId"+count).value = '';
		document.getElementById("batchNumberId"+count).options.length = 1;
		document.getElementById("doeDate"+count).value = '';
		document.getElementById("computedStock"+count).value = '';
		document.getElementById("physicalStock"+count).value ='';
		document.getElementById("surplus"+count).value ='';
		document.getElementById("deficient"+count).value ='';
		document.getElementById("remark"+count).value ='';
	}
}

 /*Below code is used for filling the details of selected batchNo. */
 function setValue(stockId,counter){
	 	document.getElementById("doeDate"+counter).value = '';
	 	document.getElementById("computedStock"+counter).value = '';
		document.getElementById("physicalStock"+counter).value ='';
		document.getElementById("surplus"+counter).value ='';
		document.getElementById("deficient"+counter).value ='';
		document.getElementById("remark"+counter).value ='';
	 
	 if(batchList.length>0){
		 for (i = 0; i < batchList.length; i++) {
			if(stockId==batchList[i].id){
				$('#doeDate'+counter).val(batchList[i].expiry_date);
				$('#computedStock'+counter).val(batchList[i].batch_stock);
				$('#stockId'+counter).val(batchList[i].id);
				$('#batchNumber'+counter).val(batchList[i].batch_no);
			}
			
		}
	 }
 }
 
/*Below code is used for calculating surplus and deficient, using in physical stock taking*/ 
function calculateDiff(counter){
	var computeStock=$('#computedStock'+counter).val();
	var physicalStock=$('#physicalStock'+counter).val();
	var difference=parseInt(computeStock)-parseInt(physicalStock);
	
	if(difference>0){
		$('#deficient'+counter).val(difference);
		$('#surplus'+counter).val('');
	}else if(difference<0){
		$('#deficient'+counter).val('');
		$('#surplus'+counter).val(physicalStock-computeStock);
	}else{
		$('#deficient'+counter).val('');
		$('#surplus'+counter).val('');
	}
 }	

function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

function checkDuplicatePVMS(item,tbody){
	 var currentRowItemId=$(item).closest('tr').find("td:eq(12)").find("input:eq(0)").attr("id");
	 var currentRowItemIdValue=$(item).closest('tr').find("td:eq(12)").find("input:eq(0)").val();
	 var currentRowBatchNoId=$(item).closest('tr').find("td:eq(4)").find("input:eq(0)").attr("id");
	 var currentRowBatchNo=$(item).closest('tr').find("td:eq(4)").find("input:eq(0)").val();
	 
	 var currentPVMS=$(item).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
	 var currentNomen=$(item).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id");
	 var currentAccUnit=$(item).closest('tr').find("td:eq(3)").find("input:eq(0)").attr("id");
	 
	 $('#'+tbody+' tr').each(function(i, el) {
		 var $tds = $(this).find('td');
		 var rowItemId=  $($tds).closest('tr').find("td:eq(12)").find("input:eq(0)").attr("id");
		 var itemIdValue=$('#'+rowItemId).val();
		 var batchNoCounter=$($tds).closest('tr').find("td:eq(4)").find("input:eq(0)").attr("id");
		 var batchNoValue=$('#'+batchNoCounter).val();
		 
		 if(currentRowItemId!=rowItemId && currentRowItemIdValue==itemIdValue){
			 if(currentRowBatchNo==batchNoValue){
				 alert("Drug code/Drug name is already added");
				 $('#'+currentRowBatchNoId).val("");
				 $('#'+currentRowItemId).val("");
				 $('#'+currentPVMS).val("");
				 $('#'+currentNomen).val("");
				 $('#'+currentAccUnit).val("");
			        return false;
			 }
		 }
		 
	 }); 
}



var nipPvmsNo = '';
function populateNomenforNiv(val,inc,item) {
	//alert("called");
	if (val != "") {
		var index1 = val.lastIndexOf("[");
		var indexForBrandName = index1;
		var index2 = val.lastIndexOf("]");
		index1++;
		nipPvmsNo = val.substring(index1, index2);
		var indexForBrandName = indexForBrandName--;
		var brandName = val.substring(0, indexForBrandName);

		if (nipPvmsNo == "") {
			return false;
		} else {
			 var itemIdNipPrescription= '';
			  var nipPvmsValue = '';
				  for(var i=0;i<nipDataforItem.length;i++){
					var nipItemIdValue= nipDataforItem[i].itemId;
					var auNipId= nipDataforItem[i].itemUnitId;
					  if(nipItemIdValue == nipPvmsNo){
						
						  itemIdNipPrescription =nipItemIdValue //data[i].itemId;
						  var checkCurrentNomRowIdNip=$(item).closest('tr').find("td:eq(7)").find("input:eq(0)").attr("id");
              			  var checkCurrentNomRowValNip=$(item).closest('tr').find("td:eq(7)").find("input:eq(0)").val();  
              			 $('#nipGrid tr').each(function(i, el) {
      	     			   var $tds = $(this).find('td')
      	  			       var itemIdCheckNip=  $($tds).closest('tr').find("td:eq(7)").find("input:eq(0)").attr("id");
      	     			   var itemIdValueNip=$('#'+itemIdCheckNip).val();
      	     			   var iddddNip =$(item).closest('tr').find("td:eq(7)").find("input:eq(0)").attr("id");
      	     			   var currentiddddNip=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
      	     			 
      	     			   if(itemIdCheckNip!=checkCurrentNomRowIdNip && itemIdNipPrescription==itemIdValueNip)	   
        			        {
      	     				 
      	     				 if(itemIdNipPrescription==itemIdValueNip){
      	      			        $('#'+iddddNip).val("");
      	      			        $('#'+currentiddddNip).val("");
      	      			        alert("NIP is already added");
      	      			        return false;
      	     				   
        			           }
        			           }
      	     			   else
      	     			   {
      	     			 
      	     				   $(item).closest('tr').find("td:eq(7)").find(":input").val(itemIdNipPrescription)
      	     				 
      	     				   var newNip=$(item).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
      	     				   document.getElementById(newNip).disabled = true;
      	     				   
      	     				 var auNip=$(item).closest('tr').find("td:eq(2)").find("select:eq(0)").attr("id");
         	 				 $('#'+auNip).val(auNipId) 
      	 				 
      	     			   }	   
      	     				
      	     			}); 
      	     		  }
      	     	  }	
      	     	
               return true;
		}
		}

	 else
	 {
		return false;
	}
}


function disableNipForPVMS(item)
{
	 $('#nipGrid tr').each(function(i, el){
	var $tds = $(this).find('td')
	var firstFiledNip=$($tds).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
	var secondFiledNip=$($tds).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
	if(document.getElementById(secondFiledNip).value!='' && document.getElementById(secondFiledNip).value!=undefined){
		document.getElementById(firstFiledNip).disabled = true;
	}else{
		document.getElementById(firstFiledNip).disabled = false;
	}
	
	}); 
}


var n=1;
function addNipRow() {
    n++;
   	var aClone = $('#nipGrid>tr:last').clone(true);
   	aClone.attr('id',''+n+'' );
   	aClone.find('img.ui-datepicker-trigger').remove();
	aClone.find(":input").val("");
	aClone.find('input[type="text"]').prop('id', 'newNip'+n+'');
	aClone.find("td:eq(0)").find(":input").prop('id', 'oldnip'+n+'');
	aClone.find("td:eq(2)").find("select:eq(0)").prop('id', 'auNip'+n+''); 
	aClone.find("td:eq(3)").find("input:eq(0)").prop('id', 'nipBatchNumberId'+n+'');
	aClone.find('input[type="text"]').removeAttr('disabled');
	aClone.find("td:eq(2)").find("select:eq(0)").removeAttr('disabled');
	aClone.find("td:eq(4)").find(":input").prop('id', 'nipDomDateId'+n+'').removeClass('noFuture_dateStore hasDatepicker').addClass('noFuture_dateStore');
	aClone.find("td:eq(5)").find(":input").prop('id', 'nipDoeDateId'+n+'').removeClass('comapre_date hasDatepicker').addClass('comapre_date');
	aClone.find("td:eq(6)").find(":input").prop('id', 'nipQuantityId'+n+'');
	aClone.find("td:eq(7)").find(":input").prop('id', 'nipItemId'+n+'');
	aClone.find("option[selected]").removeAttr("disabled")
	aClone.clone(true).appendTo('#nipGrid');
	var valNip = $('#nipGrid>tr:last').find("td:eq(0)").find(":input")[0];
	
}

function removeRowNip(val){
	if($('#nipGrid tr').length > 1) {
		   $(val).closest('tr').remove()
		 }
	else{
		alert("Can not delete all rows");
	}

}