/**

 * 
 */

var func1='';
var url1='';
var url2='';
var flaga='';
function  openGeneralDocAndInv(flagDoc){ 
	var tbl = document.getElementById('dgInvetigationGrid');
   	lastRow = tbl.rows.length;
   	$('#radioInvAndImaValueandPre').val(flagDoc);
	if(flagDoc=='gen'){
		$('#genDoc').show();
		$('#resultDoc').show();
		$('#investgationDetail').hide();
		$('#invAndRadio').hide();
		$('#orderNumberIdInv').hide();
		$('#lonicDetail').hide();
		$('#supportingDocIDMAin').hide();
		 
		 
	}
	
	if(flagDoc=='otherSup'){
		$('#genDoc').hide();
		$('#resultDoc').hide();
		$('#investgationDetail').hide();
		$('#invAndRadio').show();
		$('#orderNumberIdInv').hide();
		$('#lonicDetail').hide();
		$('#precriAndNivAndFileUp').hide();
		$('#fileUploadDynamic').hide();
		$('#supportingDocIDMAin').show();
	}
	if(flagDoc=='Lab'){
		$('#radioInvAndImaValue').val("Lab");
		$('#genDoc').hide();
		$('#resultDoc').hide();
		$('#investgationDetail').show();
		$('#invAndRadio').show();
		$('#fileUploadDynamic').show();
		//$('#uomId').show();
		//$('#uomIds').show();
		$('#orderNumberIdInv').show();
		var resultVal="";
		if(lastRow==1){
			
			resultVal+='<input type="text" name="resultInvsTemp" id="resultInvsTemp"class="form-control" onBlur="setLabResultInField(this);">';
			resultVal+='<input type="hidden" name="resultInvs" id="resultInvs" value="@@@###" class="form-control">';
			$('#resultdiv').html(resultVal);	
		}
		$('#lonicDetail').hide();
		$('#precriAndNivAndFileUp').hide();
		$('#supportingDocIDMAin').hide();
	}
	
	
	if(flagDoc=='Radio'){
		$('#genDoc').hide();
		$('#resultDoc').hide();
		$('#investgationDetail').show();
		//$('#uomId').hide();
		//$('#uomIds').hide()
		$('#invAndRadio').show();
		$('#orderNumberIdInv').show();
		$('#fileUploadDynamic').show();
		var resultVal="";
		if(lastRow==1){
		resultVal+='<textarea name="resultInvs" id="resultInvs"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###</textarea>';
		resultVal+='<a class="btn-link" href="javascript:void(0)"  onclick="openResultModel(this);">View/Enter Result</a>';
		$('#resultdiv').html(resultVal);
		}
		
		$('#precriAndNivAndFileUp').hide();
		$('#supportingDocIDMAin').hide();
	}
	if(flagDoc=='pre'){
		$('#genDoc').hide();
		$('#resultDoc').hide();
		$('#investgationDetail').hide();
		$('#fileUploadDynamic').hide();
		$('#invAndRadio').show();
		$('#orderNumberIdInv').hide();
		$('#lonicDetail').hide();
		$('#precriAndNivAndFileUp').show();
		$('#supportingDocIDMAin').hide();
	}
	
	var countR=0;
 	if(flagDoc=='Lab'|| flagDoc=='Radio'){
 		 $('#dgInvetigationGrid tr').each(function(ij, el) {
 			var dgResultHdVal= $(this).find("td:eq(1)").find("input:eq(0)").val();
 		 if(dgResultHdVal!="" && dgResultHdVal!=0){
 			 countR++;
 		 }
 		 });
 		if(countR==0){
 		//if(lastRow==1){
 		$("#dgInvetigationGrid tr").remove();
 		var disFlage="";
		getInvestigationHtml(disFlage);
			 
 		}
 		//}
 		}
	return;
}



var arrayData = [];
var i = "";
var invesRadio="";
var investigationForUom="";



function changeRadioForUploa(radioValue){
	invesRadio=radioValue;
	$('#labImaginId').val(radioValue);
	$('#radioInvAndImaValue').val(radioValue);
	var orderNumberValue="";
	try{
		orderNumberValue=$('#orderNumber').val();	
	}
	catch(e){
		
	}
	
	if(orderNumberValue!="" && orderNumberValue!="0" && orderNumberValue!=undefined){
		getInvestigationEmptyResultByOrderNo();
		
	}
		
}

function changeRadioForUploa222222(radioValue){
	$('#radioInvAndImaValue').val(radioValue);
	invesRadio=radioValue;
	i++;
	
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";

	var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/medicalexam/getInvestigationListUOM";
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : url,
		data : JSON.stringify({
			'employeeId' : '1',
			'mainChargeCode':radioValue,
		}),
		dataType : 'json',
		timeout : 100000,
		success : function(res)
		{
			arryInvestigation=[];
			arrayData=[];
			var data = res.InvestigationList;
			investigationForUom=res.InvestigationList;
			if(data!=null && data.length!=0)
			for(var i=0;i<data.length;i++){

				var investigationNewUpdate=data[i];
				var investigationId= investigationNewUpdate[0];
				var investigationName = investigationNewUpdate[1];
				if(investigationNewUpdate[3]!=null)
				var uomName = investigationNewUpdate[3];
					
				var aaaa=investigationName+"["+investigationId +"]"
				arryInvestigation.push(aaaa); 
			}
			
		
           },
           error: function (jqXHR, exception) {
               var msg = '';
               if (jqXHR.status == 0) {
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
}






function getOrderNumberOnPatient(orderList){
	var orderValue = "";
	orderValue='<select id="orderNumber" name="orderNumber"';
	 orderValue +='class="form-control" onchange="return getInvestigationEmptyResultByOrderNo();">';
	 orderValue +='<option value="0" selected="selected">Select</option>';
	
	  for(var i=0;i<orderList.length;i++){	
		  var invListValue= orderList[i];
		  if(invListValue[2]!=null && invListValue[2]!=""){
		 orderValue += '<option value='+ invListValue[0]+'>'
						+ invListValue[0] +' (' +getDateInDDMMYYYMe(invListValue[2]) +') ' + '</option>';
		  }
	  	}
	  orderValue +='</select>';
	 $j('#orderNumber').html(orderValue); 	
}

function getDateInDDMMYYYMe(dateCheck){
	 var dateFormat="";
	 var today1="";
	 if(dateCheck!=null && dateCheck!=""){
	   today1 = new Date(dateCheck);
	 var dd = String(today1.getDate()).padStart(2, '0');
	 var mm = String(today1.getMonth() + 1).padStart(2, '0'); 
	 var yyyy = today1.getFullYear();
	 dateFormat =  dd + '/' + mm + '/' +yyyy;
	 } 
	 return dateFormat;
}
 

function getInvestigationEmptyResultByOrderNo() {
	$('#loadingDiv2').show();
	 
	
	var count=0;
	var investigationGridValue = "investigationGrid";
	var investigationData="";
	var orderNumberValue=$('#orderNumber').val();
	 var radioInvAndImaValue=$('#radioInvAndImaValue').val();
	 var genderId=$('#genderId1').val();
	 if(radioInvAndImaValue==""){
		 alert("Please select Investigation Type.");
		 count++;
		 $('#orderNumber').val("");
		 getOrderNumberOnPatient(orderList);
		 return false;
	 }
	if(orderNumberValue=="" || orderNumberValue=='0'){
		alert("Please select Order Number.");
		 count++;
		 return false;
	}
	if(count==0){
	var pathname = window.location.pathname;
 	var accessGroup = "MMUWeb";
 	var url = window.location.protocol + "//"
 			+ window.location.host + "/" + accessGroup
 			+ "/registration/getInvestigationEmptyResultByOrderNo";
 
	$.ajax({
				type : "POST",
				contentType : "application/json",
				url:url,
				data : JSON.stringify({
		 			'employeeId' : '1',
		 			'orderNumberValue':orderNumberValue,
		 			'radioInvAndImaValue':radioInvAndImaValue,
		 			'genderId':genderId
		 			
		 		}),
				dataType : "json",
				success : function(res) {
					
					var data = res.listObject;
			var  subListData = res.subInvestigationData;
					var count = 1;
					var countins = 1;
					var investigationfinalValue = "";
					var diasableValue="disabled";
					var countForSub=0;
					var readonlyOnlyForInvestigation="";
					if (data != null && data.length > 0) {
						
						
						 func1='populateChargeCode';
			    		   url1='medicalexam';
			    		   url2='getInvestigationListUOM';
			    		   flaga='investigationMeDg';
						for (var i = 0; i < data.length; i++) {
							
							if(data[i].investigationType!="" && data[i].investigationType=='m'){
							
								readonlyOnlyForInvestigation="readonly";
							}
							else{
								readonlyOnlyForInvestigation="";
							}
							
							investigationData += '<tr>';
							investigationData += '<td> ';
 							investigationData += '<div class="form-check form-check-inline cusCheck m-l-10">';
 							investigationData += ' 	<input   class="form-check-input position-static" type="checkbox"  name="checkBoxForUpload" id="checkBoxForUpload'+count+'" onClick="return getInvestionCheckData(this);"><span class="cus-checkbtn"></span> ';
 							investigationData += '</div> ';
 							investigationData += ' </td> ';
							investigationData += '<td><div   class="autocomplete forTableResp">';
							investigationData += '<input type="text"  readonly value="'
									+ data[i].investigationName + '['
									+ data[i].investigationId
									+ ']" id="chargeCodeName' + count + '"';
							//investigationData += ' class="form-control border-input" name="chargeCodeName" autocomplete="off" onKeyPress="autoCompleteCommonUp(this,1);" onblur="populateChargeCode(this.value,'+ countins +',this);"/>';
							investigationData += ' class="form-control border-input" name="chargeCodeName"    onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
							investigationData += '<input type="hidden" id="qty" tabindex="1" name="qty1"  maxlength="6"/>';
							investigationData += '<input type="hidden" tabindex="1" id="chargeCodeCode"';
							investigationData += 'name="chargeCodeCode"   readonly />';
							investigationData += '<input type="hidden"  name="investigationIdValue" value="'
									+ data[i].investigationId
									+ '"  id="investigationIdValue'
									+ data[i].investigationId + '"/>';

							investigationData += '<input type="hidden"  name="dgOrderDtIdValue" value='
									+ data[i].dgOrderDtId
									+ ' id="dgOrderDtIdValue'
									+ data[i].dgOrderDtId + '"/>';
							investigationData += '<input type="hidden"  name="dgOrderHdId" value='
									+ data[i].orderHdId
									+ ' id="dgOrderHdId'
									+ data[i].orderHdId + '"/>';
						var resultHdId=0;
							if(data[i].dgResultHd!=null && data[i].dgResultHd!=undefined){
								resultHdId=data[i].dgResultHd;
							}
							else{
								resultHdId=0;
							}
							var resultdtId=0;
							if(data[i].dgResultDt!=null && data[i].dgResultDt!=undefined){
								resultdtId=data[i].dgResultDt;
							}
							else{
								resultdtId=0;
							}
							
							
							investigationData += '<input type="hidden"  name="dgResultHdId" value='+resultHdId+' id="dgResultHdId'
								+ resultHdId + '"/>';
							
							investigationData += '<input type="hidden"  name="dgResultDtId" value='+resultdtId+ ' id="dgResultDtId'
								+ resultdtId + '"/>';
							var investigationTypeForInves="";
							if(data[i].investigationType!=null){
								investigationTypeForInves=data[i].investigationType;
							}
							else{
								investigationTypeForInves="";
							}
							
							var subChargeCodeIdForInves="";
							if(data[i].subChargeCodeIdForInv!=null){
								subChargeCodeIdForInves=data[i].subChargeCodeIdForInv;
							}
							else{
								subChargeCodeIdForInves="";
							}
							
							var mainChargeCodeIdForInves="";
							if(data[i].mainChargeCodeForInv!=null){
								mainChargeCodeIdForInves=data[i].mainChargeCodeForInv;
							}
							else{
								mainChargeCodeIdForInves="";
							}
							
							
							var resultInvessss="";
							if(data[i].result!=null){
								resultInvessss=data[i].result;
							}
							else{
								resultInvessss="";
							}
							
							investigationData += '	 <input type="hidden" name="investigationType" value="'+investigationTypeForInves+'"';
							investigationData += 'id="investigationType'+i+'" />';
							
							
							
							investigationData += '<input type="hidden" name="subChargecodeIdForInv" value="'+subChargeCodeIdForInves+'"';
							investigationData += '	id="subChargecodeIdForInv'+count+'" />';
						
							
							investigationData += '<input type="hidden" name="mainChargecodeIdValForInv" value="'+mainChargeCodeIdForInves+'"';
							investigationData += '	id="mainChargecodeIdValForInv'+count+'" />';
				
							
						 	
							investigationData += '<div id="investigationDivMeDg'+count+'" class="autocomplete-itemsNew"></div>';	
							investigationData += ' </div></td>';
							
							investigationData += '	<td>';
							investigationData += '	<input type="text" name="UOM" id="UOM'+count+'" value="'+data[i].uomName+'" class="form-control"   readonly>';
							investigationData += '	</td>';
							
							if(radioInvAndImaValue=='Lab'){	
						
							investigationData += '	<td>';
							investigationData += '	<input type="text" name="resultInvsTemp" id="resultInvsTemp'+ data[i].investigationId+radioInvAndImaValue+'" value="'+resultInvessss+'" class="form-control" '+readonlyOnlyForInvestigation+' onBlur="setLabResultInFieldDigi(this);">';
							investigationData+=' <input type="hidden" name="resultInvs" id="resultInvs'+data[i].investigationId+radioInvAndImaValue+'" value="@@@###'+resultInvessss+'" class="form-control">';
							investigationData += '	</td>';
							}
							else{
	 								/*investigationData += '<td style="display:none"></td>';*/
								investigationData += '	<td>';
	 								investigationData += '<textarea name="resultInvs" id="resultInvs'+ +data[i].investigationId+radioInvAndImaValue+'"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###' +resultInvessss+' </textarea>';
	 								investigationData += '	<a class="btn-link" href="javascript:void(0)"  onclick="openResultModel(this);">View/Enter Result</a>';
	 								investigationData += '	</td>';
							}
							
							investigationData += '<td>';
							investigationData += '<input type="text" name="range" id="range'+count+'" value="'+data[i].minNormalValue+'-'+data[i].maxNormalValue+'" class="form-control" '+readonlyOnlyForInvestigation+'>';
							investigationData += '	<input type="hidden" name="investigationResultDate" id="investigationResultDate'+count+'" value="" class="form-control">';
							investigationData += '	<input type="hidden" name="resultNumber" id="resultNumber'+count+'" value="" class="form-control">';
							
							investigationData += '</td>';
							investigationData += '	<td style="display:none"><input type="file" name="fileInvUpload'+count+'" id="fileInvUpload'+count+'"></td>';
							//investigationData += '	<td><a class="btn-link" href="#">View Document</a></td>'
							 
							investigationData += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth"   button-type="add" value=""   ';
							investigationData += 'onclick="addRowForInvestigationFunUp();" ';
							investigationData += '	tabindex="1" '+diasableValue+'> </button></td>';

							investigationData += '<td><button type="button" name="delete" value=""   button-type="delete" id="deleteInves"';
							investigationData += 'class="buttonDel btn btn-danger noMinWidth"';
							investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,\''
								+ data[i].ridcId + '\');" '+diasableValue+'></button></td>';
							investigationData += ' </tr> ';
							
							if(data[i].investigationType!="" && data[i].investigationType=='m'){
								
							if (subListData != null && subListData.length > 0) {
								
								 
								for (var j = 0; j < subListData.length; j++) {
									
									countForSub++;
										if(data[i].investigationId==subListData[j].investigationIdSub){
											 
										var dgSubMasInvestigationId=subListData[j].subInvestigationId;
										//alert("coming"+dgSubMasInvestigationId);
											var subInvestigationName="";
											if(subListData[j]. subInvestigationName!="" && subListData[j]. subInvestigationName!=undefined)
											subInvestigationName=subListData[j]. subInvestigationName;
											var subInvestigationCode="";
											if(subListData[j].subInvestigationCadeForSub!="" && subListData[j].subInvestigationCadeForSub!=undefined)
												subInvestigationCode=subListData[j].subInvestigationCadeForSub;
											
											var uOMName="";
											if(subListData[j].umoNameSub!="" && subListData[j].umoNameSub!=undefined)
											uOMName=subListData[j].umoNameSub;
											
											var investigationIdVal="";
											if(subListData[j].investigationIdSub!="" && subListData[j].investigationIdSub!=undefined)
											investigationIdVal=subListData[j].investigationIdSub;
											
											var investigationType="";
											if(subListData[j].investigationTypeSub!="" && subListData[j].investigationTypeSub!=undefined)
											investigationType=subListData[j].investigationTypeSub;
											
											var rangeValSub="";
											if(subListData[j].rangeSub!="" && subListData[j].rangeSub!=undefined)
											rangeValSub=subListData[j].rangeSub;
											
											var mainChargeCodeName=""
												if(subListData[j].mainChargeCodeNameForSub!="" && subListData[j].mainChargeCodeNameForSub!=undefined)
											mainChargeCodeName=subListData[j].mainChargeCodeNameForSub;
											var count=countForSub;
											
											var orderDtIdForSub="";
											if(subListData[j].orderDtIdForSub!="" && subListData[j].orderDtIdForSub!=undefined)
											orderDtIdForSub=subListData[j].orderDtIdForSub;
											
											var orderHdIdForSub="";
											if(subListData[j].orderHdIdForSub!="" && subListData[j].orderHdIdForSub!=undefined)
											orderHdIdForSub=subListData[j].orderHdIdForSub;
											
											var resultEntryDtidForSub="";
											if(subListData[j].resultEntryDtidForSub!="" && subListData[j].resultEntryDtidForSub!=undefined)
											resultEntryDtidForSub=subListData[j].resultEntryDtidForSub;
											
											var resultEntryHdidForSub="";
											if(subListData[j].resultEntryHdidForSub!="" && subListData[j].resultEntryHdidForSub!=undefined)
											resultEntryHdidForSub=subListData[j].resultEntryHdidForSub;
											
											
											var mainChargeCodeIdForSub="";
											if(subListData[j].mainChargeCodeIdForSub!="" && subListData[j].mainChargeCodeIdForSub!=undefined)
												mainChargeCodeIdForSub=subListData[j].mainChargeCodeIdForSub;
											
											var subMainChargeCodeIdForSub="";
											if(subListData[j].subMainChargeCodeIdForSub!="" && subListData[j].subMainChargeCodeIdForSub!=undefined)
												subMainChargeCodeIdForSub=subListData[j].subMainChargeCodeIdForSub;
										
											
											
											
											var subInvestigationHtml=getSubInvestionByValues(dgSubMasInvestigationId,subInvestigationName,subInvestigationCode,uOMName,investigationIdVal,investigationType,
													 rangeValSub,mainChargeCodeName,count,orderDtIdForSub,orderHdIdForSub,resultEntryDtidForSub,resultEntryHdidForSub,mainChargeCodeIdForSub,subMainChargeCodeIdForSub);
											
											investigationData+=subInvestigationHtml;
											
										}
									
									}
								}
							}
							count++;
						}
						$("#dgInvetigationGrid").html(investigationData);
						$('#loadingDiv2').hide();
					}
					
					if (data != null && data.length == 0) {
						alert("No Record of this Order Number.");
						var disFlage="disabled";
						getInvestigationHtml(disFlage);
						
						$('#loadingDiv2').hide();
					}
				}
			});
	}
	/*else{
		return false;
	}*/
	}

function autoCompleteCommonUp(val,flag){
	if(flag=='1')
	oldautocomplete(val, arryInvestigation);
	
	if(flag=='6'){
		oldautocomplete(val, MeidcalCategoryArry);
	}
	
	if(flag=='7'){
		oldautocomplete(val, arryNomenclature);
	}
 }
var lastRow;
var i=0;
function removeRowInvestigationUp(val){
	 var tbl = document.getElementById('dgInvetigationGrid');
	   	lastRow = tbl.rows.length;
	if(lastRow>1){
		$(val).closest('tr').remove();
	}
	}


 function addRowForInvestigationFunUp(){
	 var radioInvAndImaValue=$('#radioInvAndImaValue').val();
	 
	 var tbl = document.getElementById('dgInvetigationGrid');
   	lastRow = tbl.rows.length;
   	i =lastRow;
   	i++;
	    var aClone = $('#dgInvetigationGrid>tr:last').clone(true);
	    aClone.removeAttr('data-id');
	    aClone.find('img.ui-datepicker-trigger').remove();
		aClone.find(":input").val("");
		aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'checkBoxForUpload'+i+'');
		aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'chargeCodeName'+i+'');
		aClone.find("td:eq(1)").find("input:eq(3)").prop('id', 'investigationIdValue'+i+'');
		aClone.find("td:eq(1)").find("div").find("div").prop('id', 'investigationDivMeDg' + i + '');
		aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'UOM'+i+'');
		
		var resultHtml="";
		 if(radioInvAndImaValue=='Lab'){
			 	//aClone.find("td:eq(3)").find("input:eq(0)").prop('id', 'resultInvs'+i+'');
			
			 	resultHtml='<input type="text" name="resultInvsTemp" id="resultInvsTemp'+i+'" value="" class="form-control"  onBlur="setLabResultInField(this);" >';
			 	 resultHtml+='<input type="hidden" name="resultInvs" id="resultInvs'+i+'" value="" class="form-control">';
				aClone.find("td:eq(3)").html(resultHtml);
		 }
		 if(radioInvAndImaValue=='Radio'){
				aClone.find("td:eq(3)").find("textarea:eq(0)").prop('id', 'resultInvs'+i+'');

				resultHtml = '<textarea name="resultInvs" id="resultInvs'+i+'"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;"></textarea>';
				resultHtml += '	<a class="btn-link" href="javascript:void(0)"  onclick="openResultModel(this);">View/Enter Result</a>';
				aClone.find("td:eq(3)").html(resultHtml);
		 }
			aClone.find("td:eq(4)").find("input:eq(0)").prop('id', 'range'+i+'');
			aClone.find("td:eq(4)").find("input:eq(1)").prop('id', 'investigationResultDate'+i+'');
			aClone.find("td:eq(4)").find("input:eq(2)").prop('id', 'resultNumber'+i+'');
			var viewDoc='<td style="display:none"> </td>';
			aClone.find("td:eq(5)").html(viewDoc);
			
			
 				
									var investigationData="";
											 func1='populateChargeCode';
								  		   url1='medicalexam';
								  		   url2='getInvestigationListUOM';
								  		   flaga='investigationMeDg';
											 investigationData += '<td> ';
				 							investigationData += '<div class="form-check form-check-inline cusCheck m-l-10">';
				 							investigationData += ' 	<input   class="form-check-input position-static" type="checkbox"  name="checkBoxForUpload" id="checkBoxForUpload'+i+'" onClick="return getInvestionCheckData(this);"><span class="cus-checkbtn"></span> ';
				 							investigationData += '</div> ';
				 							investigationData += ' </td> ';
											investigationData += '<td><div   class="autocomplete forTableResp">';
											investigationData += '<input type="text"  readonly value="" id="chargeCodeName' + i + '"';
											//investigationData += ' class="form-control border-input" name="chargeCodeName" autocomplete="off" onKeyPress="autoCompleteCommonUp(this,1);" onblur="populateChargeCode(this.value,'+ countins +',this);"/>';
											investigationData += ' class="form-control border-input" name="chargeCodeName"    onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
											investigationData += '<input type="hidden" id="qty" tabindex="1" name="qty1"  maxlength="6"/>';
											investigationData += '<input type="hidden" tabindex="1" id="chargeCodeCode'+i+'"';
											investigationData += 'name="chargeCodeCode"   readonly />';
											investigationData += '<input type="hidden"  name="investigationIdValue" value=""  id="investigationIdValue'+i+'"/>';

											investigationData += '<input type="hidden"  name="dgOrderDtIdValue" value="" id="dgOrderDtIdValue'+i+'"/>';
											investigationData += '<input type="hidden"  name="dgOrderHdId" value="" id="dgOrderHdId'+i+'"/>';
											 
											investigationData += '<input type="hidden"  name="dgResultHdId" value="" id="dgResultHdId'+i+'"/>';
											
											investigationData += '<input type="hidden"  name="dgResultDtId" value="" id="dgResultDtId'+i+'"/>';
											investigationData += '	 <input type="hidden" name="investigationType" value=""';
											investigationData += 'id="investigationType'+i+'" />';
											
											investigationData += '<input type="hidden" name="subChargecodeIdForInv" value=""';
											investigationData += '	id="subChargecodeIdForInv'+i+'" />';
										
											
											investigationData += '<input type="hidden" name="mainChargecodeIdValForInv" value=""';
											investigationData += '	id="mainChargecodeIdValForInv'+i+'" />';
				 							
				 							
				 							
											investigationData += '<div id="investigationDivMeDg'+i+'" class="autocomplete-itemsNew"></div>';	
											investigationData += ' </div></td>';
											investigationData += '	<td>';
											investigationData += '	<input type="text" name="UOM" id="UOM'+i+'" value="" class="form-control"   readonly>';
											investigationData += '	</td>';
											/*if(radioInvAndImaValue=='Lab'){	
										
											investigationData += '	<td>';
											investigationData+='<input type="text" name="resultInvsTemp" id="resultInvsTemp'+i+'" value="" class="form-control"  onBlur="setLabResultInField(this);" >';
											investigationData += '	<input type="hidden" name="resultInvs" id="resultInvs'+i+'" value="" class="form-control">';
											investigationData += '	</td>';
											}
											else{
											investigationData += '	<td>';
			 								investigationData += '<textarea name="resultInvs" id="resultInvs'+i+'"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;"></textarea>';
			 								investigationData += '	<a class="btn-link" href="javascript:void(0)"   onclick="openResultModel(this);">View/Enter Result</a>';
			 								investigationData += '	</td>';
											}*/
											if(radioInvAndImaValue=='Lab'){	
												investigationData += '	<td>';
												 investigationData+='<input type="text" name="resultInvsTemp" id="resultInvsTemp'+i+'" value="" class="form-control"  onBlur="setLabResultInFieldDigi(this);" >';
												investigationData += '	<input type="hidden" name="resultInvs" id="resultInvs'+radioInvAndImaValue+i+'" value="@@@###" class="form-control">';
												investigationData += '	</td>';
												}
												else{
													investigationData += '	<td>';
														investigationData += '<textarea name="resultInvs" id="resultInvs'+radioInvAndImaValue+i+'"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###</textarea>';
														investigationData += '	<a class="btn-link" href="javascript:void(0)"   onclick="openResultModel(this);">View/Enter Result</a>';
														investigationData += '	</td>';
												}
											
											/*if(radioInvAndImaValue=='Lab'){
					 							
												investigationData += '	<td>';
												investigationData+='<input type="text" name="resultInvsTemp" id="resultInvsTemp'+i+'"class="form-control" onBlur="setLabResultInField(this);">';
					 							investigationData += '	<input type="hidden" name="resultSubInv"  id="resultSubInv'+i+'" value="@@@###" class="form-control" >';
					 							investigationData += '	</td>';

											}	
											
											if(radioInvAndImaValue=='Radio'){
												investigationData += '	<td>';
												investigationData+='<textarea name="resultSubInvs" id="resultSubInvs'+i+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###</textarea>';
												investigationData+='<a class="btn-link" href="javascript:void(0)"  data-toggle="modal" data-target="#messageForResult" data-backdrop="static" onclick="openResultModel(this);">View/Enter Result</a>';
												investigationData += '	</td>';
											}*/
											
											
											investigationData += '<td>';
											investigationData += '<input type="text" name="range" id="range'+i+'" value="" class="form-control">';
											investigationData += '	<input type="hidden" name="investigationResultDate" id="investigationResultDate'+i+'" value="" class="form-control">';
											investigationData += '	<input type="hidden" name="resultNumber" id="resultNumber'+i+'" value="" class="form-control">';
											
											investigationData += '</td>';
											investigationData += '	<td style="display:none"><input type="file" name="fileInvUpload'+i+'" id="fileInvUpload'+i+'"></td>';
											 
											investigationData += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth"   button-type="add" value="" ';
											investigationData += 'onclick="addRowForInvestigationFunUp();" ';
											investigationData += '	tabindex="1" > </button></td>';

											investigationData += '<td><button type="button" name="delete" value=""   button-type="delete" id="newInvestigationId"';
											investigationData += 'class="buttonDel btn btn-danger noMinWidth"';
											investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,0);" ></button></td>';										 
										 
											aClone.html(investigationData);	
											aClone.find("td:eq(1)").find("input:eq(0)").removeAttr("readonly");
											aClone.find('input[type="checkbox"]').prop("checked", false);
											aClone.find('input[type="checkbox"]').removeAttr("disabled");
											aClone.find("td:eq(8)").find("button:eq(0)").removeAttr("readonly");
											aClone.find("td:eq(8)").find("button:eq(0)").removeAttr("id").attr("id", "newInvestigationId");
											aClone.clone(true).appendTo('#dgInvetigationGrid');
			
 						} 
 
 
 function addRowForInvestigationFunUpMe(){
	 var radioInvAndImaValue=$('#radioInvAndImaValue').val();
	 var tbl = document.getElementById('dgInvetigationGrid');
   	lastRow = tbl.rows.length;
   	i =lastRow;
   	i++;
	    var aClone = $('#dgInvetigationGrid>tr:last').clone(true)
	     aClone.removeAttr('data-id');
	    aClone.find('img.ui-datepicker-trigger').remove();
		aClone.find(":input").val("");
		
		aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'checkBoxForUpload'+i+'');
		aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'chargeCodeName'+i+'');
		aClone.find("td:eq(1)").find("input:eq(3)").prop('id', 'investigationIdValue'+i+'');
		aClone.find("td:eq(1)").find("div").find("div").prop('id', 'investigationDivMe' + i + '');
		
		aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'UOM'+i+'');
		
		var resultHtml="";
		 if(radioInvAndImaValue=='Lab'){
			 	//aClone.find("td:eq(3)").find("input:eq(0)").prop('id', 'resultInvs'+i+'');
		
			 	resultHtml='<input type="text" name="resultInvs" id="resultInvs'+i+'" value="" class="form-control">';
				aClone.find("td:eq(3)").html(resultHtml);
		 }
		 if(radioInvAndImaValue=='Radio'){
				aClone.find("td:eq(3)").find("textarea:eq(0)").prop('id', 'resultInvs'+i+'');

				resultHtml = '<textarea name="resultInvs" id="resultInvs'+i+'"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">   </textarea>';
				resultHtml += '	<a class="btn-link" href="javascript:void(0)"   onclick="openResultModel(this);">View/Enter Result</a>';
				aClone.find("td:eq(3)").html(resultHtml);
		 }
		 
			aClone.find("td:eq(4)").find("input:eq(0)").prop('id', 'range'+i+'');
			aClone.find("td:eq(5)").find("input:eq(0)").prop('id', 'investigationRemarks'+i+'');
			var viewDoc='<td style="display:none"> </td>';
			aClone.find("td:eq(6)").html(viewDoc);
			
			var investigationData="";
			 func1='populateChargeCode';
 		   url1='medicalexam';
 		   url2='getInvestigationListUOM';
 		   flaga='investigationMeDg';
			 investigationData += '<td> ';
			investigationData += '<div class="form-check form-check-inline cusCheck m-l-10">';
			investigationData += ' 	<input   class="form-check-input position-static" type="checkbox"  name="checkBoxForUpload" id="checkBoxForUpload'+i+'" onClick="return getInvestionCheckData(this);"><span class="cus-checkbtn"></span> ';
			investigationData += '</div> ';
			investigationData += ' </td> ';
			investigationData += '<td><div   class="autocomplete forTableResp">';
			investigationData += '<input type="text"  readonly value="" id="chargeCodeName' + i + '"';
			//investigationData += ' class="form-control border-input" name="chargeCodeName" autocomplete="off" onKeyPress="autoCompleteCommonUp(this,1);" onblur="populateChargeCode(this.value,'+ countins +',this);"/>';
			investigationData += ' class="form-control border-input" name="chargeCodeName"    onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
			investigationData += '<input type="hidden" id="qty" tabindex="1" name="qty1"  maxlength="6"/>';
			investigationData += '<input type="hidden" tabindex="1" id="chargeCodeCode'+i+'"';
			investigationData += 'name="chargeCodeCode"   readonly />';
			investigationData += '<input type="hidden"  name="investigationIdValue" value=""  id="investigationIdValue'+i+'"/>';

			investigationData += '<input type="hidden"  name="dgOrderDtIdValue" value="" id="dgOrderDtIdValue'+i+'"/>';
			investigationData += '<input type="hidden"  name="dgOrderHdId" value="" id="dgOrderHdId'+i+'"/>';
			 
			investigationData += '<input type="hidden"  name="dgResultHdId" value="" id="dgResultHdId'+i+'"/>';
			
			investigationData += '<input type="hidden"  name="dgResultDtId" value="" id="dgResultDtId'+i+'"/>';
			investigationData += '	 <input type="hidden" name="investigationType" value=""';
			investigationData += 'id="investigationType'+i+'" />';
			
			investigationData += '<input type="hidden" name="subChargecodeIdForInv" value=""';
			investigationData += '	id="subChargecodeIdForInv'+i+'" />';
			investigationData += '<input type="hidden" name="mainChargecodeIdValForInv" value=""';
			investigationData += '	id="mainChargecodeIdValForInv'+i+'" />';
			investigationData += '<div id="investigationDivMeDg'+i+'" class="autocomplete-itemsNew"></div>';	
			investigationData += ' </div></td>';
			investigationData += '	<td>';
			investigationData += '	<input type="text" name="UOM" id="UOM'+i+'" value="" class="form-control"   readonly>';
			investigationData += '	</td>';
			
			/*if(radioInvAndImaValue=='Lab'){	
			investigationData += '	<td>';
			investigationData += '	<input type="text" name="resultInvs" id="resultInvs'+i+'" value="" class="form-control">';
			investigationData += '	</td>';
			}
			else{
				investigationData += '	<td>';
					investigationData += '<textarea name="resultInvs" id="resultInvs'+i+'"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">  </textarea>';
					investigationData += '	<a class="btn-link" href="javascript:void(0)"  data-toggle="modal" data-target="#messageForResult" data-backdrop="static" onclick="openResultModel(this);">View/Enter Result</a>';
					investigationData += '	</td>';
			}
			*/
			
			
			
			if(radioInvAndImaValue=='Lab'){	
				investigationData += '	<td>';
				 investigationData+='<input type="text" name="resultInvsTemp" id="resultInvsTemp'+i+'" value="" class="form-control"  onBlur="setLabResultInFieldDigi(this);" >';
				investigationData += '	<input type="hidden" name="resultInvs" id="resultInvs'+radioInvAndImaValue+i+'" value="@@@###" class="form-control">';
				investigationData += '	</td>';
				}
				else{
					investigationData += '	<td>';
						investigationData += '<textarea name="resultInvs" id="resultInvs'+radioInvAndImaValue+i+'"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###</textarea>';
						investigationData += '	<a class="btn-link" href="javascript:void(0)"   onclick="openResultModel(this);">View/Enter Result</a>';
						investigationData += '	</td>';
				}
			
			
			
			investigationData += '<td>';
			investigationData += '<input type="text" name="range" id="range'+i+'" value="" class="form-control">';
			investigationData += '	<input type="hidden" name="investigationResultDate" id="investigationResultDate'+i+'" value="" class="form-control">';
			investigationData += '	<input type="hidden" name="resultNumber" id="resultNumber'+i+'" value="" class="form-control">';
			investigationData += '</td>';
			
			investigationData += '<td>';
				investigationData += '<textarea class="form-control"  name="investigationRemarks" id="investigationRemarks'+i+'" rows="2" maxlength="500"></textarea>';
				investigationData += ' </td>';
			//investigationData += '	<td style="display:none"><input type="file" name="fileInvUpload'+i+'" id="fileInvUpload'+i+'"></td>';
			investigationData += '<td> </td>'
			 
			investigationData += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth"   button-type="add" value="" ';
			investigationData += 'onclick="addRowForInvestigationFunUpMe();" ';
			investigationData += '	tabindex="1" > </button></td>';

			investigationData += '<td><button type="button" name="delete" value=""   button-type="delete" id="newInvestigationId"';
			investigationData += 'class="buttonDel btn btn-danger noMinWidth"';
			investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,0);" ></button></td>';										 
		 
			aClone.html(investigationData);	
			
			
 			aClone.find("td:eq(1)").find("input:eq(0)").removeAttr("readonly");
			aClone.find('input[type="checkbox"]').prop("checked", false);
			aClone.find('input[type="checkbox"]').removeAttr("disabled");
			aClone.find("td:eq(9)").find("button:eq(0)").removeAttr("disabled",false);
			aClone.find("td:eq(9)").find("button:eq(0)").removeAttr("id").attr("id", "newInvestigationId");
			aClone.clone(true).appendTo('#dgInvetigationGrid');
	
 } 
 
 
 
 
 
 function uploadDynamicFiles() {
	 var fileSize=0;
	 var countResult=0;
	 var formData1 = $('#submitInvesUp')[0];
	 var formData = new FormData(formData1);
	 var radioInvAndImaValue=$('#radioInvAndImaValue').val();
	 var countFile=1;
	 var countForNotResult =0;
	 var countForResultExist=0;
	 var checkForMultiple=0;
	 $('#dgInvetigationGrid tr').each(function(ij, el) {
			//var fileUploadid = $(this).find("td:eq(5)").find("input:eq(0)").attr("id");
			//var investigationValue = $(this).find("td:eq(1)").find("input:eq(3)").val();
			//if($("#"+fileUploadid).prop("files")!=null || $("#"+fileUploadid).prop("files")!="")
			//formData.append('file'+ countFile, $("#"+fileUploadid).prop("files")[0]);
			//fileSize = document.getElementById("#"+fileUploadid).files[0].size;
			//var filenameValue = document.getElementById(""+fileUploadid).value;
		
		 var investigationValP= $(this).closest('tr').find("td:eq(1)").find("input:eq(3)").val();
	 	 	var investigationType= $(this).closest('tr').find("td:eq(1)").find("input:eq(8)").val();
	 	 	countForResultExist=0
	 	 	
	 	 	if(investigationType=='m'){
	 	 		checkForMultiple++;
	 	 	$('tr[data-id="'+investigationValP+'"]').each(function(index) {
	 	 		var result =$(this).find("td:eq(3) ").find("input:eq(0)").val();
	 	 		 
	 	 		console.log('Result: '+result);
	 	 		if(countForResultExist==0 && (result=="" || result==null)){
	 	 			countResult+=1;
				}
	 	 		if(result!="" && result!=null){
	 	 			countForResultExist=countForResultExist+1;
	 	 			countResult=0;
				}
	 	 		/*if((result=="" || result==null &&(countForResultExist==0))){
	 	 			countResult+=1;
				}
	 	 		if(result!="" && result!=null){
	 	 			countForResultExist=countForResultExist+1;
	 	 			countResult=0;
				}*/
	 	 		
	 	 	 
	 	 	});
	 	 	}
	 	 	else{
	 	 		if(investigationType=='t'|| investigationType=='s'){
			 	var result = $(this).find("td:eq(3)").find("input:eq(0)").val();
			 	if(result=="" || result==null || result==undefined){
			 		  result = $(this).find("td:eq(3)").find("textarea:eq(0)").val();
			 		  
	 	 		}
	 	 	
			 	if(result=="" || result==null){
			 		countResult+=1;
				}
	 	 		}
	 	 	}
		  
		});
		formData.append('uploadFilePath', "uploads");
		formData.append('uploadRealPath', 1);
		 
		
		if(countResult>0 ){
			 alert("Please enter result");
			 
			 return false;
		 }
		/*if((countResult>0 ||(checkForMultiple>0 && countForResultExist==0))){
			 alert("Please enter result");
			 
			 return false;
		 }	
		*/
		
		var checkFileName=0;
	 	 $('#fileUploadforInvesDynamic tr').each(function(ij, el) {
	 		var fileNameValueIDd= $(this).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id"); 
			 	 
	 		var fileNameValue=$('#'+fileNameValueIDd).val();
			var filenameWithExtension=getFilenameAndReplcePath(fileNameValue);
			if(filenameWithExtension!="" && filenameWithExtension!=null && validateFileExtension(filenameWithExtension, "valid_msg", "Only pdf/image files are allowed !",
				      new Array("jpg","pdf","jpeg","gif","png","PNG","JPEG","JPG","GIF","mp4","MP4")) == false)
				      {
				 		return false;
				      }
			if(filenameWithExtension!="" && filenameWithExtension!=undefined && filenameWithExtension!=null)
			if(checkForFileCondition(filenameWithExtension)){
				checkFileName++;
			}
	 		
			});
	 	 
		
	 	if(checkFileName>0){
	 		alert("File contain special character.Please upload valid file.");
	 		countResult++;
	 		 return false;
	 	 }
		
		
		if(countResult==0){
		var fileNameTmpValue = "";
		var pathname = window.location.pathname;
	 	var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/registration/submitInvestigationUp";
		$.ajax({
			url : url,
			data : formData,
			processData: false,
	        contentType: false,
			async : true,
			type : 'POST',
			dataType : "json",
			success : function(response) {
				var dataVal=response.message;
				if(dataVal!="" && dataVal!=undefined){
				var responseData=dataVal.split("##");
				if(responseData[0]=='1'){
					$("#submitInvess").attr("disabled","disabled");
					// $('.savingLoader').hide();
					alert(responseData[1]+'S');	
					var checkRadioVal=	$("input[name='btnradio']:checked").val();
					openGeneralDocAndInv(checkRadioVal);
					
					document.getElementById("closeBtn").addEventListener("click", function(){location.reload();});
					
					return true;
				}
				if(responseData[0]=='0'){
					alert(responseData[1]);
					$("#submitInvess").removeAttr("disabled");
					return false;
				}
				 
				}
				return true;
			},
			error : function(err) {
			}
		});
		}
	}
 
 
 function submitInves(flagForSubmit) {
	 $("#submitInvess").prop("disabled",true);
	 	var serviceNo = $('#serviceNo_uhid').val();
	 	$('#serviceNoIn').val(serviceNo);
	 	$('#serviceNo').val(serviceNo);
	 	var patientId =$('#patientId').val();
	 	$('#patientIdIn').val(patientId);
		var orderNumber =$('#orderNumber').val();
		$('#orderNumberInv').val(orderNumber);
		var count=0;
		if(serviceNo==""){
			 alert("Please enter service no./ UHID no.");
			 count++;
			 $("#submitInvess").removeAttr("disabled");
			 return false;
		 }
		if(patientId==""){
			 alert("Please select patient.");
			 count++;
			 $("#submitInvess").removeAttr("disabled");
			 return false;
		 }
		
		var radioInvAndImaValueandPre	=$('#radioInvAndImaValueandPre').val();
		
 if(radioInvAndImaValueandPre!="" && radioInvAndImaValueandPre!=undefined && (radioInvAndImaValueandPre=='otherSup')){
			 
			 $('#medicalBoardDocs tr').each(function(i, el) {
				 var docSelect = $(this).find("td:eq(0)").find("select:eq(0)").val();
					var medicalDocs= $(this).find("td:eq(1)").find("textarea:eq(0)").val();
					var dateOfDoc= $(this).find("td:eq(2)").find("input:eq(0)").val();
				 if(docSelect=="" ||docSelect==undefined || docSelect=='0'){
					 alert("Please select Document type.");
					 count++;
					 $("#submitInvess").removeAttr("disabled");
					 return false;
				 }
				 if(medicalDocs=="" ||medicalDocs==undefined || medicalDocs=='0'){
					 alert("Please enter document result");
					 count++;
					 $("#submitInvess").removeAttr("disabled");
					 return false;
				 }
				 if(dateOfDoc=="" ||dateOfDoc==undefined || dateOfDoc=='0'){
					 alert("Please select document date");
					 count++;
					 $("#submitInvess").removeAttr("disabled");
					 return false;
				 }
			 });
		 }
		
		
		 if(radioInvAndImaValueandPre!="" && radioInvAndImaValueandPre!=undefined && (radioInvAndImaValueandPre=='Lab' || radioInvAndImaValueandPre=='Radio')){
			 
			 $('#dgInvetigationGrid tr').each(function(i, el) {
				 var investigationIdVal= $(this).closest('tr').find("td:eq(1)").find("input:eq(3)").val();
				 if(investigationIdVal=="" ||investigationIdVal==undefined){
					 alert("Please enter Investigation.");
					 count++;
					 $("#submitInvess").removeAttr("disabled");
					 return false;
				 }
				 
			 });
		 }
		
		
		 
	
		/* if(radioInvAndImaValueandPre!="" && radioInvAndImaValueandPre!=undefined && radioInvAndImaValueandPre=='pre'){
			 var extNomenclatureFlag=true;
				var  idforTreat='';
 			var valnomenclatureGrid='';	
 			var precriptionIdValue1=0;
 			var precriptionIdValue2=0;
 	 		 $('#nomenclatureGrid tr').each(function(i, el) {
 	 			idforTreat= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
 	 			var $tds = $(this).find('td')
    	    		var treatmentName = $tds.eq(0).find(":input").val();
    	    		var dosage = $tds.eq(2).find(":input").val();
    	   			var frequency = $tds.eq(3).find(":input").val();
    	   		    var splitFrequency=frequency.split("@");
    	  			var days = $tds.eq(4).find(":input").val();
    	   			var instruction = $tds.eq(6).find(":input").val();
    	   		    var totalNom = $tds.eq(5).find(":input").val();
    	            var treatmentItemId=$tds.eq(10).find(":input").val(); 
    	            
    	         	if(frequency!= "" || dosage!= "" || days!= "")
	 				{	
 	          	if(treatmentName== "")
	   			 	{
   				alert("Please Enter Nomenclature Name");
   				treatmentName.focus();
   				 
   				return false;	    	
				  	}
	 			   }
    	   		       	 			
		    		if(document.getElementById(idforTreat).value!= '' && document.getElementById(idforTreat).value != undefined)
				    {
 	 			
    				if(dosage== "" ||dosage==0)
	    			{
   					alert("Dosage should be greater than 0 under nomenclature");
   					dosage.focus();
   					 
  					return false;      	
					 }
    				if(frequency== "")
	   				 {
    					alert("Please select frequency against entered nomenclature");
    					frequency.focus();
    					precriptionIdValue1++;
  					return false;       	
					 }
 				if(days== "" && splitFrequency[1]!=13)
	    			{
    					alert("Please Enter No. of Days against entered nomenclature");
    					frequency.focus();
    					 
  					return false;       	
				    }
 				
 				if(totalNom== "" ||totalNom==0)
	    			{
    					alert("Total should be greater than 0 under nomenclature");
    					frequency.focus();
    					
  					return false;       	
				    }
    
				    }
		    		 
		    		if(idforTreat!="" && idforTreat!=null && idforTreat!=undefined){
		    			precriptionIdValue1++;
		    		}
		    		
		    		
     		 });
    	 		 
 	 		 var  idforTreatNip='';
 	     	var  idforNewNip=''; 
 				var valNipGrid='';
 				if(){
 		 		 $('#nipGrid tr').each(function(i, el) {
 		 			idforTreatNip= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
 		 			idforNewNip=$(this).find("td:eq(1)").find("input:eq(0)").attr("id")
 		 			var $tds = $(this).find('td')
 		    		var nipOldName = $tds.eq(0).find(":input").val();
 		 			var nipNewName = $tds.eq(1).find(":input").val();
 		 			var nipClass = $tds.eq(2).find(":input").val();
 		 			var nipAu = $tds.eq(3).find(":input").val();
 		    		var nipDosage = $tds.eq(5).find(":input").val();
 		   			var nipFrequency = $tds.eq(6).find(":input").val();
 		  			var nipDays = $tds.eq(7).find(":input").val();
 		  		    var totalNip = $tds.eq(8).find(":input").val();
 		  		    var itemNipGridIdCheck = $tds.eq(10).find(":input").val();
 		  		    
 		  		     if(nipOldName!="" && itemNipGridIdCheck=="" ){
 		        	
 		        	    alert("Please enter valid NIV Row"); 
 		        	    treatmentName.focus();
 		        	    count++;
 		        	    return false; 
 			           
 		             }
 		  		    
 		  			if(nipFrequency!= "" || nipDosage!= "" || nipDays!= "" || nipAu!="" || nipClass!="")
 					{	
 	       		if(nipOldName== "" && nipNewName=="")
 				 		{
 						alert("Please Enter NIV Name");
 						treatmentName.focus();
 						count++;
 						return false;	    	
 				  		}
 				   	}
 		  		    
 		    		if(document.getElementById(idforTreatNip).value!= '' && document.getElementById(idforTreatNip).value != undefined)
 				    {
 		 			//var instruction = $tds.eq(6).find(":input").val();
 		 			if(nipOldName== "")
 		   			 {
 	  				alert("Please Enter NIV Presciption Name");
 	  				treatmentName.focus();
 	  				count++;
 	  				return false;	    	
 					  }
 					if(nipDosage== "" || nipDosage==0)
 	   			{
 						alert("Dosage should be greater than 0 under NIV");
 						dosage.focus();
 						return false;      	
 					 }
 					if(nipFrequency== "")
 	   				 {
 						alert("Please select frequency against entered NIV");
 						frequency.focus();
 						count++;
 						return false;       	
 					 }
 					if(nipDays== "" && splitFrequency[1]!=13)
 	    			{
 						alert("Please Enter No. of Days. against entered NIV");
 						frequency.focus();
 						count++;
 						return false;       	
 				    }
 					if(totalNip== "" || totalNip==0)
 	    			{
 						alert("Total should be greater than 0 under NIV");
 						totalNip.focus();
 						count++;
 						return false;       	
 				    }

 				    }
 		 			if(document.getElementById(idforNewNip).value!= '' && document.getElementById(idforNewNip).value != undefined)
 				    {
 		 				//var instruction = $tds.eq(6).find(":input").val();
 		 				if(nipClass== "")
 	  	   			 {
 	      				alert("Please enter class against entered NIV");
 	      				nipClass.focus();
 	      				count++;
 	      				return false;	    	
 	  				  }
 		 				if(nipAu== "")
 	 	   			 {
 	     				alert("Please enter A/U against entered NIV");
 	     				nipAu.focus();
 	     				count++;
 	     				return false;	    	
 	 				  }
 	    	 			
 	    				if(nipDosage== "" ||nipDosage==0)
 		    			{
 	   					alert("Dosage should be greater than 0 under NIV");
 	   					nipDosage.focus();
 	   					count++;
 	  					return false;      	
 						 }
 	    				if(nipFrequency== "")
 		   				 {
 	    					alert("Please select frequency against entered NIV");
 	    					nipFrequency.focus();
 	    					count++;
 	  					return false;       	
 						 }
 	 				if(nipDays== "")
 		    			{
 	    					alert("Please enter No. of Days against entered NIV");
 	    					frequency.focus();
 	    					count++;
 	  					return false;       	
 					    }
 	 				if(totalNip== "" || totalNip==0)
 		    			{
 	    					alert("Total should be greater than 0 under NIV");
 	    					totalNip.focus(); 
 	    					count++;
 	  					return false;       	
 					    }
 				    }
 		 			
 	 		 });
 			 
 	 		 
		 }*/
		
		
		 
		if(count==0){
			var status=uploadDynamicFiles();
			if(status==false){
				$("#submitInvess").removeAttr("disabled");
			}
			else{
			$("#submitInvess").attr("disabled","disabled");
			}
		}
		}   
 
 
 function closeMessage(){
	 try{
		 $('#saveEntryForma').attr('disabled',false);
		$('#submitEntryForma').attr('disabled',false);
	 }
	 catch(e){}
	 $('#errordiv').empty("");
	$('#messageForUploadInv').hide();
	$('.modal-backdrop ').hide();
	$('.modal-backdrop2').hide();
	$('.modal').hide();
	
}
 
 
 function openResultModel(item){
	 var resultOfflineDateId= $(item).closest('tr').find("td:eq(4)").find("input:eq(1)").attr("id");
	 $('#currentObjectForResultOffLineDate').val(resultOfflineDateId);
	 var resultOfflineNumberId= $(item).closest('tr').find("td:eq(4)").find("input:eq(2)").attr("id");
	 $('#currentObjectForResultOffLinenumber').val(resultOfflineNumberId); 
		$('#messageForResult').show();
		$('.modal-backdrop2').show();
 
		var resultIdIm= $(item).closest('tr').find("td:eq(3)").find("input:eq(0)").attr("id");
		if(resultIdIm=="" || resultIdIm==undefined)
		 resultIdIm= $(item).closest('tr').find("td:eq(3)").find("textarea:eq(0)").attr("id");
		
		var resultView = $('#'+resultIdIm).val();
		
		if(resultView.includes("@@@###")){
			resultView=resultView.replace("@@@###","");
		}
		
		//resultView = resultView.replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&quot;/g,"'").replace(/&amp;/g,"&");
		resultView=decodeHtml(resultView);
	 	$('#editorOfResult').jqteVal(resultView) ;
		$('#resultIdImagin').val(resultIdIm);
		
		
		$('#investigationResultDateTemp').val("") ;
		var resultOfflineDate = $j('#'+resultOfflineDateId).val();
		$('#investigationResultDateTemp').val(resultOfflineDate);
		
		$('#resultNumberTemp').val("") ;
		var resultOfflineNumberVal = $j('#'+resultOfflineNumberId).val();
		$('#resultNumberTemp').val(resultOfflineNumberVal) ;
		
 }

 
 
 
 function openResultModelMe(item){
	
		/*$('#messageForResult').show();
		$('.modal-backdrop ').show();*/
 
		var resultIdIm= $(item).closest('tr').find("td:eq(3)").find("input:eq(0)").attr("id");
		if(resultIdIm=="" || resultIdIm==undefined)
		 resultIdIm= $(item).closest('tr').find("td:eq(3)").find("textarea:eq(0)").attr("id");
		
		var resultView = $('#'+resultIdIm).val();
		if(resultView.includes("@@@###")){
			resultView=resultView.replace("@@@###","");
		}
		//resultView = resultView.replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&quot;/g,"'").replace(/&amp;/g,"&");
		resultView=decodeHtml(resultView);
		$('#editorOfResult').jqteVal(resultView);
		$('#resultIdImagin').val(resultIdIm);
 }
 

 
 function saveResultInTextMe(){
	 var idOfResult=$('#resultIdImagin').val();
	 var jqetResultValue=$('#editorOfResult').val();
	 if(jqetResultValue!=""){
		 jqetResultValue=jqetResultValue.trim();
		// jqetResultValue= jqetResultValue.escapeHTML();
		 jqetResultValue="@@@###"+jqetResultValue;
	 }
	 $('#'+idOfResult).val(jqetResultValue);
	 $('.modal').hide();
	$('.modal-backdrop ').hide();
	$('#messageForResult').hide();
	$('.modal-backdrop2').hide();
		 
 }
 
 
 function saveResultInText(){
	 var idOfResult=$('#resultIdImagin').val();
	 var jqetResultValue=$('#editorOfResult').val();
	 if(jqetResultValue==""){
		 alert("Please enter result.");
	 }
	 if(jqetResultValue!=""){
		 jqetResultValue=jqetResultValue.trim();
		// jqetResultValue= jqetResultValue.escapeHTML();
		 jqetResultValue="@@@###"+jqetResultValue;
	
	  
	 $('#'+idOfResult).val(jqetResultValue);
	 /*$('.modal').hide();
	 $('.modal-backdrop ').hide();*/
	 $j('.modal').modal('hide');
	 $('#errordiv').empty("");
	 $('#errordiv').hide();
	 $('#messageForResult').hide();
	 $('.modal-backdrop2').hide();
	 }
		 
 }
 

 function getInvestigationHtml(disFlage) {
 	var investigationGridValue = "investigationGrid";
 	var investigationData="";
  					 
 					var count = 1;
 					var countins = 1;
 					var investigationfinalValue = "";
 					var diasableValue="disabled";
 					 func1='populateChargeCode';
		    		   url1='medicalexam';
		    		   url2='getInvestigationListUOM';
		    		   flaga='investigationMeDg';
  							investigationData += '<tr>';
 							investigationData += '<td> ';
 							investigationData += '<div class="form-check form-check-inline cusCheck m-l-10">';
 							investigationData += ' 	<input   class="form-check-input position-static" type="checkbox"  name="checkBoxForUpload" id="checkBoxForUpload" onClick="return getInvestionCheckData(this);"><span class="cus-checkbtn"></span> ';
 							investigationData += '</div> ';
 							investigationData += ' </td> ';
 							investigationData += '<td><div class="autocomplete forTableResp">';
 							investigationData += '<input type="text"   value="" id="chargeCodeName"';
 							//investigationData += ' class="form-control border-input" name="chargeCodeName" autocomplete="off" onKeyPress="autoCompleteCommonUp(this,1);" onblur="populateChargeCode(this.value,'+ countins +',this);"/>';
 							investigationData += ' class="form-control border-input" name="chargeCodeName" '+disFlage+'   onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
 							investigationData += '<input type="hidden" id="qty" tabindex="1" name="qty1"  maxlength="6"/>';
 							investigationData += '<input type="hidden" tabindex="1" id="chargeCodeCode"';
 							investigationData += 'name="chargeCodeCode"   readonly />';
 							investigationData += '<input type="hidden"  name="investigationIdValue" value=""  id="investigationIdValue"/>';

 							investigationData += '<input type="hidden"  name="dgOrderDtIdValue" value="" id="dgOrderDtIdValue"/>';
 							investigationData += '<input type="hidden"  name="dgOrderHdId" value="" id="dgOrderHdId"/>';
 							 
 							investigationData += '<input type="hidden"  name="dgResultHdId" value="" id="dgResultHdId"/>';
 							
 							investigationData += '<input type="hidden"  name="dgResultDtId" value="" id="dgResultDtId"/>';
 							investigationData += '<input type="hidden" name="investigationType" value=""';
 							investigationData += '	id="investigationType" />';
 							
 							
 							investigationData += '<input type="hidden" name="subChargecodeIdForInv" value=""';
							investigationData += '	id="subChargecodeIdForInv" />';
						
							
							investigationData += '<input type="hidden" name="mainChargecodeIdValForInv" value=""';
							investigationData += '	id="mainChargecodeIdValForInv" />';
				
 							
 							investigationData += '<div id="investigationDivMeDg" class="autocomplete-itemsNew"></div>';	
 							investigationData += ' </div></td>';

 							var radioInvAndImaValue=$('#radioInvAndImaValue').val();
 							if(radioInvAndImaValue=='Lab'){
 							investigationData += '	<td>';
 							investigationData += '	<input type="text" name="UOM" id="UOM" value=" " class="form-control"   readonly>';
 							investigationData += '	</td>';
 							}
 							else{
 								investigationData += '<td ><input type="text" name="UOM" id="UOM" value=" " class="form-control"   readonly></td>';
 							}

 							investigationData += '	<td>';
 							 if(radioInvAndImaValue=='Lab'){
 								 investigationData+='<input type="text" name="resultInvsTemp" id="resultInvsTemp" value="" class="form-control"  onBlur="setLabResultInField(this);" '+disFlage+' >';
 								investigationData += '	<input type="hidden" name="resultInvs" id="resultInvs" value="" class="form-control">';
 	 							
 							 }
 							
 							 if(radioInvAndImaValue=='Radio'){
 								investigationData += '<textarea name="resultInvs" id="resultInvs"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;"></textarea>';
 								investigationData += '	<a class="btn-link" href="javascript:void(0)"   onclick="openResultModel(this);">View/Enter Result</a>';
 							 }
 							
 							investigationData += '	</td>';
 							investigationData += '<td>';
 							investigationData += '<input type="text" name="range" id="range" value="" class="form-control "'+disFlage+'>';
 							investigationData += '	<input type="hidden" name="investigationResultDate" id="investigationResultDate'+i+'" value="" class="form-control">';
 							investigationData += '	<input type="hidden" name="resultNumber" id="resultNumber'+i+'" value="" class="form-control">';
 							investigationData += '</td>';
 							investigationData += '	<td style="display:none"> </td>';
 							investigationData += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth"   button-type="add" value="" ';
 							investigationData += 'onclick="addRowForInvestigationFunUp();" ';
 							investigationData += '	tabindex="1" > </button></td>';

 							investigationData += '<td><button type="button" name="delete" value=""   button-type="delete" id="newInvestigationId"';
 							investigationData += 'class="buttonDel btn btn-danger noMinWidth"';
 							investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,0);"';
 							investigationData += '	tabindex="1" ></button></td>';
 							investigationData += ' </tr> ';
 						$("#dgInvetigationGrid").html(investigationData);
   
  
 }
 

 
 
 
 function getInvestigationHtmlForDigi() {
	 
	 
	 	var investigationGridValue = "investigationGrid";
	 	var investigationData="";
	  					 
	 					var count = 1;
	 					var countins = 1;
	 					var investigationfinalValue = "";
	 					 func1='populateChargeCode';
			    		   url1='medicalexam';
			    		   url2='getInvestigationListUOM';
			    		   flaga='investigationMeDg';
	 					var diasableValue="disabled";
	  							investigationData += '<tr>';
	 							investigationData += '<td> ';
	 							investigationData += '<div class="form-check form-check-inline cusCheck m-l-10">';
	 							investigationData += ' 	<input   class="form-check-input position-static" type="checkbox"  name="checkBoxForUpload" id="checkBoxForUpload" onClick="return getInvestionCheckData(this);"><span class="cus-checkbtn"></span> ';
	 							investigationData += '</div> ';
	 							investigationData += ' </td> ';
	 							investigationData += '<td><div class="autocomplete forTableResp">';
	 							investigationData += '<input type="text"   value="" id="chargeCodeName"';
	 							//investigationData += ' class="form-control border-input" name="chargeCodeName" autocomplete="off" onKeyPress="autoCompleteCommonUp(this,1);" onblur="populateChargeCode(this.value,'+ countins +',this);"/>';
	 							investigationData += ' class="form-control border-input" name="chargeCodeName"    onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
	 							investigationData += '<input type="hidden" id="qty" tabindex="1" name="qty1"  maxlength="6"/>';
	 							investigationData += '<input type="hidden" tabindex="1" id="chargeCodeCode"';
	 							investigationData += 'name="chargeCodeCode"   readonly />';
	 							investigationData += '<input type="hidden"  name="investigationIdValue" value=""  id="investigationIdValue"/>';

	 							investigationData += '<input type="hidden"  name="dgOrderDtIdValue" value="" id="dgOrderDtIdValue"/>';
	 							investigationData += '<input type="hidden"  name="dgOrderHdId" value="" id="dgOrderHdId"/>';
	 							 
	 							investigationData += '<input type="hidden"  name="dgResultHdId" value="" id="dgResultHdId"/>';
	 							
	 							investigationData += '<input type="hidden"  name="dgResultDtId" value="" id="dgResultDtId"/>';
	 							
	 							investigationData += '<input type="hidden" name="investigationType" value=""';
	 							investigationData += '	id="investigationType" />';
	 							investigationData += '<input type="hidden" name="subChargecodeIdForInv" value=""';
								investigationData += '	id="subChargecodeIdForInv" />';
								investigationData += '<input type="hidden" name="mainChargecodeIdValForInv" value=""';
								investigationData += '	id="mainChargecodeIdValForInv" />';
	 							
	 							investigationData += '<div id="investigationDivMeDg" class="autocomplete-itemsNew"></div>';	
	 							investigationData += ' </div></td>';

	 							var radioInvAndImaValue=$('#radioInvAndImaValue').val();
	 							if(radioInvAndImaValue=='Lab'){
	 							investigationData += '	<td>';
	 							investigationData += '	<input type="text" name="UOM" id="UOM" value=" " class="form-control"   readonly>';
	 							investigationData += '	</td>';
	 							}
	 							else{
	 								investigationData += '<td><input type="text" name="UOM" id="UOM" value=" " class="form-control"   readonly></td>';
	 							}

	 							investigationData += '	<td>';
	 							 if(radioInvAndImaValue=='Lab'){
	 	 						
	 								 investigationData+='<input type="text" name="resultInvsTemp" id="resultInvsTemp" value="" class="form-control"  onBlur="setLabResultInFieldDigi(this);" >';
	 								 investigationData += '	<input type="hidden" name="resultInvs" id="resultInvs" value="" class="form-control">';
	 							 
	 							 }
	 							
	 							 if(radioInvAndImaValue=='Radio'){
	 								investigationData += '<textarea name="resultInvs" id="resultInvs"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;"></textarea>';
	 								investigationData += '	<a class="btn-link" href="javascript:void(0)" onclick="openResultModel(this);">View/Enter Result</a>';
	 							 }
	 							
	 							investigationData += '	</td>';
	 							
	 							investigationData += '<td>';
	 							investigationData += '<input type="text" name="range" id="range" value="" class="form-control">';
	 							investigationData += '	<input type="hidden" name="investigationResultDate" id="investigationResultDate" value="" class="form-control">';
	 							investigationData += '	<input type="hidden" name="resultNumber" id="resultNumber" value="" class="form-control">';
	 							
	 							investigationData += '</td>';
	 							investigationData += '	<td > </td>';
	 							 
	 							investigationData += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth"   button-type="add" value="" ';
	 							investigationData += 'onclick="addRowForInvestigationFunUpMeDigi( );" ';
	 							investigationData += '	tabindex="1" > </button></td>';

	 							investigationData += '<td><button type="button" name="delete" value=""   button-type="delete" id="newInvestigationId"';
	 							investigationData += 'class="buttonDel btn btn-danger noMinWidth"';
	 							investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,0);"';
	 							investigationData += '	tabindex="1" ></button></td>';
	 							investigationData += ' </tr> ';
	 						$("#dgInvetigationGrid").html(investigationData);
	   
	  
	 }
	 
 

 
 
 function getInvestionCheckData(itemId){
		var investigationName= $(itemId).closest('tr').find("td:eq(1)").find("input:eq(0)").val();
		var investigationId= $(itemId).closest('tr').find("td:eq(1)").find("input:eq(3)").val();
		var checkBoxValue= $(itemId).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
		var mainChargeCodeVal= $(itemId).closest('tr').find("td:eq(1)").find("input:eq(10)").val();
	
		
		var tbl = document.getElementById('fileUploadforInvesDynamic');
		   var 	lastRow = tbl.rows.length;
		
		if(investigationName==undefined || investigationName==""){
				alert("Please add investigation.");
				return false;
			}
		
		var checkForRemove =$('#checkForRemove').val();
		if(checkForRemove!=undefined && checkForRemove!="" && checkForRemove=='0' && lastRow>1){
		var radioCheckId=$('#radioCheckId').val();
		var radioValue =$('#'+radioCheckId).is(':checked')
		if(!radioValue){
			alert("Please select file.");
			return false;
		}
		}
		if (document.getElementById(checkBoxValue).checked == true) {
			
			var idForDynamicInvestigation="";
		 var countForWhenRadio=0;
		 var checkWhenRationChecked=0;
		 $('#fileUploadforInvesDynamic tr').each(function(j, el) {
			 if(lastRow==1){
				 idForDynamicInvestigation=$(this).find("td:eq(1)").find("textarea:eq(0)").attr("id");
			 }
			 else{
				 radioCheckId=$(this).find("td:eq(0)").find("input:eq(0)").attr("id");
				 var radioValue =$('#'+radioCheckId).is(':checked')
					if(radioValue){
						checkWhenRationChecked++;
						return false;
					}
				
			 }
				
		 });
			
		 if(checkWhenRationChecked==0 && lastRow>1){
			 alert("Please select file.");
			 countForWhenRadio++;
			 return false; 
			 }
		 
		 /*if(countForWhenRadio>0){
			 return false;
		 }*/
		 if(countForWhenRadio==0){
			var getValueInvesUpload=$('#dynamicUploadInvesId').val();
			 getValueInvesUpload+=""+investigationId+",";
			 $('#dynamicUploadInvesId').val(getValueInvesUpload);
			 
			 var mainChargeCodeValUpdate=$('#mainChargeCodeForFile').val();
			 mainChargeCodeValUpdate+=""+mainChargeCodeVal+",";
			 $('#mainChargeCodeForFile').val(mainChargeCodeValUpdate);
			
			 
			 
			 if(lastRow!=1){
			   idForDynamicInvestigation= $('#dynamicFileUploadId').val();
			 }
			 var dynainvestigationName=$('#'+idForDynamicInvestigation).val();
			 dynainvestigationName+=""+investigationName+",";
			 $('#'+idForDynamicInvestigation).val(dynainvestigationName);
			
			 var fileUploadIdd= $('#fileNameId').val();
			 var fileUploadIddVal= $('#'+fileUploadIdd).val();	
			 var filenameWithExtension ="";
			if(fileUploadIddVal!=undefined && fileUploadIddVal!="" && fileUploadIddVal!=null){
			   filenameWithExtension = getFilenameAndReplcePath(fileUploadIddVal);
			}
			 if(filenameWithExtension!="" && filenameWithExtension!=undefined){
				 var neUpdateVal=$('#dynamicUploadInvesIdAndfile').val(); 
				 neUpdateVal+=""+investigationId+"##"+filenameWithExtension+",";
				 $('#dynamicUploadInvesIdAndfile').val(neUpdateVal);
			 }
			 	
				var fileNameValForId=  $('#fileNameId').val();
				$('#'+fileNameValForId).attr("disabled",false);
		 }
		}
		else{
			var radioCheckId=$('#radioCheckId').val();
			var radioValue =$('#'+radioCheckId).is(':checked')
			/*if(!radioValue){
				alert("Please mark the group of file which has remove the investigation.");
				return false;
			}*/
			
		
			
		//	if(radioValue){
				// var dynainvestigationNameId=$('#dynamicFileUploadId').val();
				// var dynainvestigationNameVal=$('#'+dynainvestigationNameId).val();
				 var countWhenNotMatch=0;	
				 
					$('#fileUploadforInvesDynamic tr').each(function(j, el) {
						var dynainvestigationNameId=$(this).find("td:eq(1)").find("textarea:eq(0)").attr("id");
						var dynainvestigationNameVal = $(this).find("td:eq(1)").find("textarea:eq(0)").val();
				 
				 if(dynainvestigationNameVal.includes(investigationName)){
						
						dynainvestigationNameVal=dynainvestigationNameVal.replace(investigationName,"");
						 $('#'+dynainvestigationNameId).val(dynainvestigationNameVal);
						 
						var invDynValu=$('#dynamicUploadInvesId').val();			
						if(invDynValu!=""){
							if(invDynValu.includes(investigationId)){
								invDynValu=invDynValu.replace(investigationId,"");
								$('#dynamicUploadInvesId').val(invDynValu);
							}
						} 
						
						
						var mainChargeCodeForFileDyn=$('#mainChargeCodeForFile').val();			
						if(mainChargeCodeForFileDyn!=""){
							if(mainChargeCodeForFileDyn.includes(mainChargeCodeVal)){
								mainChargeCodeForFileDyn=mainChargeCodeForFileDyn.replace(mainChargeCodeVal,"");
								$('#mainChargeCodeForFile').val(mainChargeCodeForFileDyn);
							}
						} 
						
						
						
						 var dynamicUploadInvesIdAndfileaaa=$('#dynamicUploadInvesIdAndfile').val();
						 if(dynamicUploadInvesIdAndfileaaa!="")
						 if(dynamicUploadInvesIdAndfileaaa.includes(investigationId)){
							 dynamicUploadInvesIdAndfileaaa=dynamicUploadInvesIdAndfileaaa.replace(investigationId,0);
						 $('#dynamicUploadInvesIdAndfile').val(dynamicUploadInvesIdAndfileaaa);
						 }
						 countWhenNotMatch++;
						 return true;
					}
					});
				 
				 if(countWhenNotMatch==0){
					 alert("Investigation is not associate with File.Please Mark file which is assoicate with investigation.");
				 return false;
				 }
			//}
		}
		
		
		}
 

 function getFileUploadData(itemId){
	 try{
	        var radionButtonCheckId= $(itemId).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
	         var radioValue =$('#'+radionButtonCheckId).is(':checked');
	         	 updateNewIdWhenRadioCheck(itemId);
	       }
	       catch(e){}
	 
	 var countForRemove=0;
		var investigationValue= $(itemId).closest('tr').find("td:eq(1)").find("textarea:eq(0)").val();
	 if(investigationValue=="" || investigationValue==undefined){
			alert("Please add investigation before uploading file.");
			countForRemove++;
			//return false;
		}
		var fileNameValue= $(itemId).closest('tr').find("td:eq(2)").find("input:eq(0)").val();
		var fileNameValueIDd= $(itemId).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id");
		
		var filenameWithExtension=getFilenameAndReplcePath(fileNameValue);
		if(validateFileExtension(filenameWithExtension, "valid_msg", "Only pdf/image files are allowed !",
			      new Array("jpg","pdf","jpeg","gif","png","PNG","mp4","MP4")) == false)
			      {
			 		return false;
			      }
		
		 if(filenameWithExtension!="" && filenameWithExtension!=undefined ){
			 var getValueInvesUpload=$('#dynamicUploadInvesId').val();
			 var getValueWhenSet=getValueInvesUpload.split(",");
			 var uploadInvandFile="";
			 var neUpdateVal=$('#dynamicUploadInvesIdAndfile').val();
			 for(var i=0;i<getValueWhenSet.length-1;i++){
				 if(getValueWhenSet[i]!=""){
					if(neUpdateVal!=""){
						 neUpdateVal=getOldUpdatedValue(neUpdateVal,getValueWhenSet[i]);//neUpdateVal.replace(getValueWhenSet[i],0);
					}
					 uploadInvandFile+=""+getValueWhenSet[i]+"##"+filenameWithExtension+",";
					 
					/* $('#dgInvetigationGrid tr').each(function(j, el) {
							var investigationValueForDiasable = $(this).find("td:eq(1)").find("input:eq(3)").attr("id");
							if(investigationValueForDiasable==getValueWhenSet[i]){
								  $(this).find("td:eq(0)").find("input:eq(0)").attr('disabled','disabled');
							}
						});*/
					 
				 	}
				 }
			 
			 ///////////////////////////////Used for ChargeCode////////////////////////////////////////
			 var newmainChargeCodeForFile=$('#mainChargeCodeForFile').val();
			 var newmainChargeCodeForFileWhenSet=newmainChargeCodeForFile.split(",");
			 var neUpdateMainchargeAndFileName=$('#mainChargeCodeForFileWithChargeCode').val();
			 var mainChargeCodeUpdateVal="";
			 for(var i=0;i<newmainChargeCodeForFileWhenSet.length-1;i++){
				 if(newmainChargeCodeForFileWhenSet[i]!=""){
					/*if(neUpdateMainchargeAndFileName.includes(newmainChargeCodeForFileWhenSet[i])){
						neUpdateMainchargeAndFileName=neUpdateMainchargeAndFileName.replace(newmainChargeCodeForFileWhenSet[i],0);
					}*/
					mainChargeCodeUpdateVal+=""+newmainChargeCodeForFileWhenSet[i]+"##"+filenameWithExtension+",";
					 
					 
				 	}
				 }
			 
			 $('#mainChargeCodeForFileWithChargeCode').val(neUpdateMainchargeAndFileName);
			 
			 var neUpdateneUpdateMainchargeAndFileName=$('#mainChargeCodeForFileWithChargeCode').val();
			 neUpdateneUpdateMainchargeAndFileName+=""+mainChargeCodeUpdateVal+",";
			 $('#mainChargeCodeForFileWithChargeCode').val(neUpdateneUpdateMainchargeAndFileName);
			
			 
			 //////////////////////////////////////////////////////////////////////////
			 
			 $('#dynamicUploadInvesIdAndfile').val(neUpdateVal);
			 
			 var neUpdateVal=$('#dynamicUploadInvesIdAndfile').val();
			 neUpdateVal+=""+uploadInvandFile+",";
			 $('#dynamicUploadInvesIdAndfile').val(neUpdateVal);
			 
		 }
		 
		 if(countForRemove>0){
				var investigationValueId= $(itemId).closest('tr').find("td:eq(2)").find("file:eq(0)").attr("id");
				$('#'+investigationValueId).val("");
		 }
  }
 
  function getOldUpdatedValue(neUpdateVal,checkForVal){
	  var nowFinalValue="";
	  if(neUpdateVal!="" && neUpdateVal!=null && neUpdateVal!=undefined){
		 var neUpdateValNew=neUpdateVal.split(",");
		 for(var i=0;i<neUpdateValNew.length-1;i++){
			 if(neUpdateValNew[i]!=null && neUpdateValNew[i]!=""&& neUpdateValNew[i]!=undefined){
				 var afterSplit=neUpdateValNew[i].trim().split("##");
				 if(afterSplit[0]!=""&& afterSplit[0]!=undefined && checkForVal!="" && checkForVal!=undefined && checkForVal.trim()==afterSplit[0].trim()){
					 neUpdateVal=neUpdateVal.replace(checkForVal,0);
					  
				 }
				 
			 }
			 
		 }
	  }
	  return neUpdateVal;
  }
 
 function getNewUploadFile(){
	
	 
	var tbl = document.getElementById('fileUploadforInvesDynamic');
   	lastRow = tbl.rows.length;
   	i =lastRow;
   	i=$('#countFileUploadVal').val();
   	i++;
	    var aClone = $('#fileUploadforInvesDynamic>tr:last').clone(true)
	    aClone.find('img.ui-datepicker-trigger').remove();
		aClone.find(":input").val("");
		aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'radioFileUpload'+i+'');
		aClone.find("td:eq(1)").find("textarea:eq(0)").prop('id', 'investUploadDynamic'+i+'');
		aClone.find("td:eq(2)").find(".fileUploadDiv ").removeClass('hasFile');
		aClone.find("td:eq(2)").find('.inputUploadlabel').text('Choose File');	
		aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'fileInvUploadDyna'+i+'');
		aClone.find("td:eq(2)").find("input:eq(0)").prop('name', 'fileInvUploadDyna'+i+'');
		aClone.find("td:eq(2)").find(".inputUploadFileName").text('No File Chosen');
		aClone.find("td:eq(3)").find("input:eq(0)").prop('id', 'uploadNewFile'+i+'');
		aClone.find("td:eq(4)").find("input:eq(0)").prop('id', 'deleteRowForFile'+i+'');

		aClone.find('input[type="radio"]').prop("checked", true);
		
		aClone.find("td:eq(2)").find("input:eq(0)").attr('disabled','disabled');
		
		 var idForDynamicInvestigation= $('#dynamicFileUploadId').val();
		 var dynainvestigationName=$('#'+idForDynamicInvestigation).val();
		 var fileNameId= $('#fileNameId').val();
		 var fileNameIdVal=$('#'+fileNameId).val();
		 
		if(dynainvestigationName!="" && fileNameIdVal!=""){
			aClone.clone(true).appendTo('#fileUploadforInvesDynamic');
		
		var idValueOfText="investUploadDynamic"+i;
		 $('#dynamicFileUploadId').val(idValueOfText);
		 $('#uploadNewBuutonId').val('uploadNewBuutonId'+i);
		 $('#fileNameId').val('fileInvUploadDyna'+i);
		 $('#dynamicUploadInvesId').val("");
		 $('#countFileUploadVal').val(i);
		 $('#mainChargeCodeForFile').val("");
		}
		else{
			alert("Please upload file associate with  investigations.");
		}
		$('#checkForRemove').val('1');
	} 
 
 function updateNewIdWhenRadioCheck(itemId){
	 var fileNameValueIDd= $(itemId).closest('tr').find("td:eq(1)").find("textarea:eq(0)").attr("id");
	 var uploadedFileId= $(itemId).closest('tr').find("td:eq(3)").find("button:eq(0)").attr("id");	
	 var fileNameIdd= $(itemId).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id");
	 var radioButtonId= $(itemId).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
	 
	 $('#dynamicFileUploadId').val(fileNameValueIDd);
	 $('#uploadNewBuutonId').val(uploadedFileId);
	 $('#fileNameId').val(fileNameIdd);
	 $('#radioCheckId').val(radioButtonId);
	 
	 var textAreaValue=$('#'+fileNameValueIDd).val();
	 var newInvestigationIdVal="";
	 if(textAreaValue!="" && textAreaValue!=undefined && textAreaValue!=null){
		 var arrayTest=textAreaValue.split(",");
		 for(var i=0;i<arrayTest.length-1;i++){
			 var idTextVal=arrayTest[i];
			 var index1 = idTextVal.lastIndexOf("[");
 			var index2 = idTextVal.lastIndexOf("]");
 			index1++;
 			var valueInvetigationId = idTextVal.substring(index1, index2);
 			newInvestigationIdVal+=valueInvetigationId+",";
		 }
	 }
	 $('#dynamicUploadInvesId').val(newInvestigationIdVal);
	 
	 return true;
 }
 
 function removeFile(itemId){
	 var tb3 = document.getElementById('fileUploadforInvesDynamic');
		var lastRow3 = tb3.rows.length;
		if(lastRow3>1){
	 var fileNameValue= $(itemId).closest('tr').find("td:eq(2)").find("input:eq(0)").val();
		var fileNameValueIDd= $(itemId).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id");
		var filenameWithExtension = fileNameValue.replace(/^.*[\\\/]/, '');
		 var dynamicUploadInvesIdAndfile= $('#dynamicUploadInvesIdAndfile').val();
		 var investigationValue= $(itemId).closest('tr').find("td:eq(1)").find("textarea:eq(0)").val();
			var investigationValues=investigationValue.split(",");
			var mainChargeCodeForFileWithChargeCodeUpdatForDelete=$('#mainChargeCodeForFileWithChargeCode').val();
			
	for(var i=0;i<investigationValues.length-1;i++){
				 
		if(investigationValues[i]!="" && investigationValues[i]!=null)				
		 if(dynamicUploadInvesIdAndfile.includes(filenameWithExtension)){
			 dynamicUploadInvesIdAndfile=dynamicUploadInvesIdAndfile.replace(filenameWithExtension,"0");
		 }
		 if(mainChargeCodeForFileWithChargeCodeUpdatForDelete.includes(filenameWithExtension)){
			 mainChargeCodeForFileWithChargeCodeUpdatForDelete=mainChargeCodeForFileWithChargeCodeUpdatForDelete.replace(filenameWithExtension,"0");
			 
		 }
		$('#dgInvetigationGrid tr').each(function(j, el) {
			var checkedBoxId = $(this).find("td:eq(0)").find("input:eq(0)").attr("id");
			var investigationVal = $(this).find("td:eq(1)").find("input:eq(0)").val();
			if(investigationVal==investigationValues[i]){
				$("#"+checkedBoxId).prop("checked", false);
			}
			
		});
		}
	$('#fileUploadforInvesDynamic tr').each(function(j, el) {
		var radioCheck = $(this).find("td:eq(0)").find("input:eq(0)").attr("id");
		$("#"+radioCheck).prop("checked", false);
	});
	
		 $('#dynamicUploadInvesIdAndfile').val( dynamicUploadInvesIdAndfile);
		 $('#mainChargeCodeForFileWithChargeCode').val(mainChargeCodeForFileWithChargeCodeUpdatForDelete);
			$(itemId).closest('tr').remove();
			}
		
		$('#checkForRemove').val('0');
			}
 
 
 function newEntryForm(flag){
	 window.location.href = "dataEntryForm"	 
 }
 
 
 
 function getPatientListForUp(){
		
		var params = {
				"serviceNo": $j('#serviceNo').val(),
				"flagForDigi":"digi"
		}
		
		var pathname = window.location.pathname;
	 	var accessGroup = "MMUWeb";

	 	var url = window.location.protocol + "//"
	 			+ window.location.host + "/" + accessGroup
	 			+ "/registration/getEmployeeAndDependentlist";
		 $j.ajax({
				type:"POST",
				contentType : "application/json",
				url:url,
				data : JSON.stringify(params),
				dataType: "json",			
				cache: false,
				success: function(res)
				{  
					var data = res.count;
				    var dataList = res.data;
					console.log("dataList "+dataList)
					if(dataList == 0 || dataList==undefined){
						alert("Service No. does not exist");
						$('#employeeName').val("");
						return;
					}
					$j('#employeeName').empty();
				//	var make_patient_List_combo = '<option value="">Select</option>';
					 for(i in dataList){
						
						 if(dataList[i].relation!="" && (dataList[i].relation=='SELF'|| dataList[i].relation=='Self')){
							//make_patient_List_combo += '<option selected value="'+data.patient_list[i].patient_id+'">'+data.patient_list[i].patient_name+'</option>'
							$j('#employeeName').val(dataList[i].empName);
							$j('#uhidNo').val(dataList[i].uhidNo);
							$j('#relationId').val(dataList[i].relationId);
							$j('#serviceNo1').val(dataList[i].serviceNo);
							$j('#empName').val(dataList[i].empName);
							$j('#employeeId').val(dataList[i].employeeId);
							$j('#empRankId').val(dataList[i].empRankId);
							$j('#empTradeId').val(dataList[i].empTradeId);
							$j('#empUnitId').val(dataList[i].empUnitId);
							$j('#empMaritalStatusId').val(dataList[i].empMaritalStatusId);
							$j('#empRecordOfficeId').val(dataList[i].empRecordOfficeId);
							$j('#empServiceJoinDate').val(dataList[i].empServiceJoinDate);
							$j('#name').val(dataList[i].empName);
							$j('#dateOfBirth').val(dataList[i].dateOfBirth);
							$j('#genderId').val(dataList[i].genderId);
							$j('#visitId').val(dataList[i].genderId);
							$j('#age').val(dataList[i].age);
						
							//$("#patientId").val(dataList.patient_id);
							try{
								$j("#newEntry").attr("disabled", false);
							}
							catch(e){}
						}
						
					}
					
					//$j('#employeeName').append(make_patient_List_combo);
					
				},
				
				error: function(data)
				{					
					
					alert("An error has occurred while contacting the server");
					
				}
		}); 
	}
 
 
 
 function newEntryMEMEBForm(){
	 var age=$('#empMaritalStatusId').val();
	 var examTypeId=$('#examTypeId').val();
	 /*if(examTypeId!="" && examTypeId!="0"){
		 var examTypeIds=examTypeId.spilt("")
	 }*/
   	 var serviceNo=$j('#serviceNo').val();
     
	 if(serviceNo=="" ){
		 alert("Please enter service Number.");
		 return false;
	 }
 	 var documentType=$j('#documentType').val();
	 if(documentType=="" || documentType=='0'){
		 alert("Please select  document type.");
		 return false;
	 }
	 var examTypeId='';
	 if(documentType!="Others")
	{	 
	  examTypeId=$j('#examTypeId').val();
	 if(examTypeId=="" || examTypeId=='0'){
		 alert("Please select  document category.");
		 return false;
	 }
	} 

	 
	 var documentType=$('#documentType').val();
	 
	 
	 
	 
	 var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";

     var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/saveOpdEmergency";
     
     var dataJSON = {
    		 'serviceNo':$('#serviceNo1').val(),
             'uhidNo': $('#uhidNo').val(),
             'relationId':$('#relationId').val(),
             'registrationTypeId':$('#registrationTypeId').val(),
             'departmentId':'3',
             'visitFlag':'E',
             'priorityId':'1',
             'empName':$('#empName').val(),
             'employeeId':$('#employeeId').val(),
             'empRankId':$('#empRankId').val(),
             'empTradeId':$('#empTradeId').val(),
             'empUnitId':$('#empUnitId').val(),
             'empMaritalStatusId':$('#empMaritalStatusId').val(),
             'empRecordOfficeId':$('#empRecordOfficeId').val(),
             'empServiceJoinDate':$('#empServiceJoinDate').val(),
             'name':$('#name').val(),
             'dateOfBirth':$('#dateOfBirth').val(),
             'genderId':$('#genderId').val(),
             'hospitalId':hsId,
             'examTypeId':$('#examTypeId').val(),
             'documentType':$('#documentType').val()
     }
	 //$("#clicked").attr("disabled", true);
     $("#newEntry").attr("disabled", true);
     $.ajax({
         type: "POST",
         contentType: "application/json",
         url: url,
         data: JSON.stringify(dataJSON),
         dataType: 'json',
         success: function(data) {
        	 var dataList=data.data;
         	//console.log(dataList)
         	if(dataList==null || dataList==undefined){
         		$("#newEntry").attr("disabled", false);
                alert("Due to service number there is some problem.")
                return false;
         	}
         	var visitId = dataList.visitId;
            if (visitId!=null && visitId!="")
             {
            	//alert("visitId "+visitId)
            	 if(examTypeId!=null && examTypeId!="")
            	 {	 
            		 var newEntryStatus='yes';
            	 window.location.href = "mbMembersAFMSForm?visitId="+visitId+"&age="+age+"&examTypeId="+examTypeId+"&viewOrEditFlag=yes"+"&newEntryStatus="+newEntryStatus+"&documentType="+documentType;
            	 }
            	 else
            	 {
            		 window.location.href = "mbMembersOtherDocument?visitId="+visitId+""; 
            	 } 
            	 //$("#newEntryMEMEBFormId").submit();
            	//	$('#newEntry').attr('diasable',true);
             } 
             else if(dataList.status == 0)
             {
              $("#newEntry").attr("disabled", false);		 
              alert(dataList.msg)	
             }	
             else
             {
            	 $("#newEntry").attr("disabled", false);
                 alert("Please enter the valid data")
             }
         	
         },
         error: function(jqXHR, exception) {
         	$("#clicked").attr("disabled", false);
             var msg = '';
             if (jqXHR.status === 0) {
            	 $("#newEntry").attr("disabled", false);
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
             alert("Response msg is "+msg);
         }
     });

 }
 var flagForForm="";
  var flagForSubmit="";
 function saveEntryForm(flagForSubmit) {
	 flagForSubmit=flagForSubmit;
	 
	   flagForForm=$('#flagForForm').val();
	 $('#saveInDraft').val(flagForSubmit);
	 
		 var finalObservationDigiVal=$('#finalObservationDigi').val();
			$('#finalObservationMoDigi').val("");
			$('#finalObservationMoDigi').val(finalObservationDigiVal);
			if(flagForForm=='form2a'){
			 var finalObservationDigiVal2=$('#finalObservationDigi2').val();
				$('#finalObservationMoDigi2').val("");
				$('#finalObservationMoDigi2').val(finalObservationDigiVal2);
			}
	 
	 
	 	
	 	var count=0;
	 	var countForRelease=0;
	 	
	 		
	 	if(flagForForm!='form18'){
	 		var dateOfExamVal=$('#dateOfExam').val()
	 		if(dateOfExamVal==null || dateOfExamVal==""){
	 			count++;
	 		}
	 	}
	 	else{
	 		var dateOfRelease=$('#dateOfRelease').val();
	 		if(dateOfRelease==null || dateOfRelease==""){
	 			countForRelease++;
	 		}
	 	}
	 	
	 	
	 	
	 	
		if(count>0){
	 		alert("Please enter  Date Of Exam");
	 		$('#dateOfExam').focus();
	 		return false;
	 	}
	 	
		if(countForRelease>0){
			count++;
	 		alert("Please enter  Release Date");
	 		$('#dateOfRelease').focus();
	 		return false;
	 	}
	 	
	 	var checkFileName=0;
	 	 $('#fileUploadforInvesDynamic tr').each(function(ij, el) {
	 		var fileNameValueIDd= $(this).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id"); 
			 	 
	 		var fileNameValue=$('#'+fileNameValueIDd).val();
			var filenameWithExtension=getFilenameAndReplcePath(fileNameValue);
			if(filenameWithExtension!="" && filenameWithExtension!=null && validateFileExtension(filenameWithExtension, "valid_msg", "Only pdf/image files are allowed !",
				      new Array("jpg","pdf","jpeg","gif","png","PNG","JPEG","JPG","GIF")) == false)
				      {
						count++;
				 		return false;
				      }
			if(filenameWithExtension!="" && filenameWithExtension!=undefined && filenameWithExtension!=null)
			if(checkForFileCondition(filenameWithExtension)){
				checkFileName++;
				count++;
			}
	 		
			});
	 	if(checkFileName>0){
	 		alert("File contain special character.Please upload valid file.");
	 	 }
	 	
	 	if(count>0){
	 		alert("Please upload valid file.");
	 	}
	 	
	 	 
	 	
	 var countForResultExist=0;
	 var countForNotResult=0;
	  /*$('#dgInvetigationGrid tr').each(function(ij, el) {
	 	 	var investigationValP= $(this).closest('tr').find("td:eq(1)").find("input:eq(3)").val();
	 	 	var investigationType= $(this).closest('tr').find("td:eq(1)").find("input:eq(8)").val();
	 	 	
	 	 	if(investigationType=='m'){
	 	 	$('tr[data-id="'+investigationValP+'"]').each(function( index ) {
	 	 		var result =$(this).find("td:eq(3) ").find("input:eq(0)").val();
	 	 		console.log('Result: '+result);
	 	 		if(result=="" || result==null){
	 	 			countForNotResult+=1;
				}
	 	 		if(result!="" && result!=null){
	 	 			countForResultExist=countForResultExist+1;
	 	 			countForNotResult=0;
				}
	 	 	});
	 	 	}
	 	 	else{
	 	 		
	 	 		if(investigationType=='t'|| investigationType=='s'){
			 	var result = $(this).find("td:eq(3)").find("input:eq(0)").val();
			 	if(result=="" || result==null){
			 		  result = $(this).find("td:eq(3)").find("textarea:eq(0)").val();
			 		  
	 	 		}
	 	 	
			 	if(result=="" || result==null){
					count+=1;
				}
	 	 		}
	 	 	}
			});
	 	if(countForResultExist==0){
	 		alert("Please enter result.");
	 		count++;
	 		return false
	 	}*/
	 	 
	 	if(flagForSubmit=='ev'){
	 		var actionDigiFile=$('#actionDigiFile').val();
	 		if(actionDigiFile=='0'){
	 		count++;
	 		}
	 	}
	 	if(flagForSubmit=='ea'){
	 		var actionDigiFileApproved=$('#actionDigiFileApproved').val();
	 		if(actionDigiFileApproved=='0'){
	 		count++;
	 		}
	 	}
	 	if(count>0){
	 		alert("Please select Action.")
	 		return false;
	 	}
	 	var actionVal=$('#actionDigiFile').val();
	 	if(actionVal!="" && (actionVal=='vr'||actionVal=='ar' )){
	 		if(actionVal=='vr'){
	 			var finalObservationVal=$('#finalObservationMo').val().trim();
	 		if(finalObservationVal==""){
	 			alert("Please enter Remarks.")
	 			count++;
		 		return false;
	 		}
	 		}
	 		
	 		if(actionVal=='ar'){
	 			var finalObservationRMo=$('#finalObservationRMo').val().trim();
	 		if(finalObservationRMo==""){
	 			alert("Please enter Remarks.");
	 			count++;
		 		return false;
	 		}
	 		}
	 	}
	 	var countForSupp=0;
	 	$('#medicalBoardDocs tr').each(function(ij, el) {
			var documentTypeVal = $(this).find("td:eq(0)").find("select:eq(0)").val();
			var resultVal= $(this).find("td:eq(1)").find("textarea:eq(0)").val();
			var medicalDUpload= $(this).find("td:eq(2)").find("input:eq(0)").val();
			//alert("resultVal"+resultVal);
			if(documentTypeVal!="" && documentTypeVal!='0'){
				if(resultVal==""){
					countForSupp=countForSupp+1;
				}
				if(medicalDUpload==""){
					countForSupp=countForSupp+1;
				}
			}
		});
	 	 
	 /*	if(countForSupp>0){
	 		alert("Please enter value under medical board(supporting document)");
	 		count=countForSupp;
			return false;  
	 		 
	 	}
	*/ 	var liverPalpable=$('#liverPalpable').val();
	 	if(liverPalpable!=null && liverPalpable!="" && liverPalpable=='Yes'){
	 		var liver=$('#liver').val();
	 		if(liver==""){
	 			alert("Please enter Liver Palpable.");
	 			count=count+1;
	 		}
	 	}
	 	
		var spleenPalpable=$('#spleenPalpable').val();
		if(spleenPalpable!=null && spleenPalpable!="" && spleenPalpable=='Yes'){
			var spleen=$('#spleen').val();
	 		if(spleen==""){
	 			alert("Please enter Spleen Palpable.");
	 			count=count+1;
	 		}
	 	}
	 	
		var countImmunizationDate=0;
		var countImmunizationName=0;
		var countDuration=0;
		var countNextDueDate=0;
		if(flagForForm!='form2a'){
		$('#immunisationStatusGrid tr').each(function(ij, el) {
			var deleteButtonId= $(this).find("td:eq(5)").find("button:eq(0)").attr("id");
			if(deleteButtonId!="" && deleteButtonId.includes("newImmunizationDelete")){
				var immunizationName= $(this).find("td:eq(0)").find("input:eq(0)").val();
				var immunizationDate= $(this).find("td:eq(1)").find("input:eq(0)").val();
				var duration= $(this).find("td:eq(2)").find("input:eq(0)").val();
				var nextDueDate= $(this).find("td:eq(2)").find("input:eq(0)").val();
				if(immunizationName==""){
					countImmunizationName++;
					count++;
				}
				if(immunizationDate==""){
					countImmunizationDate=countImmunizationDate+1;
					count++;
				}
				
				/*if(duration==""){
					countDuration++;
					count++;
				}*/
				/*if(nextDueDate==""){
					countNextDueDate=countNextDueDate+1;
					count++;
				}*/
				
			}
		});
	 	
	 	
	 	if(countImmunizationName>0){
			 alert("Please enter Immunization");
		}
		if(countImmunizationDate>0){
			alert("Please enter Immunization Date");
		}
		
		if(countDuration>0){
			alert("Please enter duration");
		}
		if(countNextDueDate>0){
			alert("Please enter Next Due Date");
		}
		}
	 	////////////////////////////////////////////////
		var countDepatmentVal=0;
		var countDiagnosisVal=0;
		var countSpecilistOpening=0;
		var counthospitalValue=0;
		if(flagForForm!='form2a'){
	 	$('#medicalReferal tr').each(function(ij, el) {
			var hospitalValue= $(this).find("td:eq(1)").find("select:eq(0)").val();
			 
			if(hospitalValue!="" && hospitalValue!="0"){
				var depatmentVal= $(this).find("td:eq(2)").find("select:eq(0)").val();
				var diagnosisVal= $(this).find("td:eq(3)").find("input:eq(0)").val();
				var specilistOpening= $(this).find("td:eq(5)").find("textarea:eq(0)").val();
				if(depatmentVal==""){
					countDepatmentVal++;
					count++;
				}
				if(diagnosisVal==""){
					countDiagnosisVal=countDiagnosisVal+1;
					count++;
				}
				
				if(specilistOpening==""){
					countSpecilistOpening++;
					//count++;
				}
				 
				
			}
		});
	 	/*
	 	if(counthospitalValue>0){
	 		alert("Please select Hospital Name");
	 	}*/
	 	if(countDepatmentVal>0){
			 alert("Please select Deparment");
		}
		if(countDiagnosisVal>0){
			alert("Please enter Diganosis");
		}
		}
		
		/*if(countSpecilistOpening>0){
			alert("Please enter Specialist Opinion");
		}
	 	*/
	 	var hospitalForDigi=$('#hospitalForDigi').val();
	 	if(hospitalForDigi=="" || hospitalForDigi=="0"){
	 		alert("Please select hospital.");
	 		count++;
	 		return false;
	 	}
		
		
		
	 	///////////////////////////////////////////////
		
	 	if(flagForForm!='form2a'){
	 	if(count==0){
	 		checkBoxFitInCat();
	 	}
	 }
	 	
	 	if(count==0){
	 		if(flagForForm!='form2a' && flagForSubmit!="" && (flagForSubmit=='et'|| flagForSubmit=='es')){
	 		//	$('#saveEntryForma').attr('disabled',true);
	 			//$('#submitEntryForma').attr('disabled',true);
	 			submitOfDigiForModal();
	 		}
	 		
	 		else{
	 			$("#newEntryForm3B").submit();
	 		}
	 		 
	 		if(flagForSubmit!="" && flagForSubmit=='et'){
	 			$('#saveEntryForma').attr('disabled',true);
	 			$('#submitEntryForma').attr('disabled',true);
	 		}
	 		if(flagForSubmit!="" && flagForSubmit=='es'){
	 			$('#saveEntryForma').attr('disabled',true);
		 		$('#submitEntryForma').attr('disabled',true);
	 		}
	 		if(flagForSubmit!="" && flagForSubmit=='ev')
		 		$('#submitEntryFormaV').attr('disabled',true);
	 		if(flagForSubmit!="" && flagForSubmit=='ea')
		 		$('#submitEntryFormaA').attr('disabled',true);
	 		}
	 	}
 
 
 
 
 function submitOfDigiForModal(){
	 var countForDigi=0;
	 $('#medicalCategory tr').each(function(i, el) {
			var $tds = $(this).find('td')	

			 var icdName = $tds.eq(0).find(":input").val();
			var deleteIdd=$(this).closest('tr').find("td:eq(8)").find("button:eq(0)").attr("id");
			 if(icdName!="" && deleteIdd!="" && deleteIdd!=undefined && deleteIdd.includes("deleteMC")){
				 countForDigi=+1; 
			 }
 	 });
	 if(countForDigi!=0){
		 $('#messageForDigitization').show();
		 $('.modal-backdrop').show();
	 }
	 else{
		 $("#newEntryForm3B").submit();
		 if(flagForSubmit!="" && flagForSubmit=='et'){
		 		$('#saveEntryForma').attr('disabled',true);
		 		$('#submitEntryForma').attr('disabled',true);
		 }
		 		if(flagForSubmit!="" && flagForSubmit=='es'){
		 			$('#saveEntryForma').attr('disabled',true);
		 			$('#submitEntryForma').attr('disabled',true);
		 		}
	 }
	 return ;
 }
 
 

 
 function submitOfDigi(){
		 $("#newEntryForm3B").submit();
		 $('#submitModalOfDigi').attr('disabled',true);
		 $('#closeButtonIdForDigi').attr('disabled',true);
		 
		 if(flagForSubmit!="" && flagForSubmit=='et'){
		 		$('#saveEntryForma').attr('disabled',true);
		 		$('#submitEntryForma').attr('disabled',true);
		 	}
		 		if(flagForSubmit!="" && flagForSubmit=='es')
			 		$('#submitEntryForma').attr('disabled',true);
		 		
			return ;
	 
 }
 
 
 var fitInArray = [];
 var fitflagVal ="";
 function checkBoxFitInCat() {
	
 		if (document.getElementById("fitInChk").checked == true) {
 			  fitflagVal = 'Yes';
 			var fitInFlagVal = fitflagVal;

 		} else {
 			  fitflagVal = 'No';
 			var fitInFlagVal = fitflagVal;
 		}

 		fitInArray.push(fitInFlagVal);
 		$('#fitFlagCheckValue').val(fitInFlagVal);
 }
 
 
 function addRowForReferalForDigiFileUpload(){
	 var sNO=0;
		var tbl = document.getElementById('medicalReferal');
		var lastRow = tbl.rows.length;
		k = lastRow;
		sNO=lastRow;
		k++;
		sNO++;
		var aClone = $('#medicalReferal>tr:last').clone(true)
		aClone.find("td:eq(0)").html(sNO);
		//aClone.find('select').prop('id', 'medicalExamReferalHos' + k + '');
		aClone.find("td:eq(1)").find("select:eq(0)").prop('id','medicalExamReferalHos' + k + '');
		aClone.find("td:eq(2)").find("select:eq(0)").prop('id','departmentValue' + k + '');
		//aClone.find("td:eq(2)").find("input:eq(0)").prop('id','departmentValue' + k + '');
		aClone.find("td:eq(2)").find("input:eq(0)").prop('id','diagonsisId' + k + '');
		aClone.find("td:eq(2)").find("input:eq(1)").prop('id','masEmpanalHospitalId' + k + '');
		aClone.find("td:eq(2)").find("input:eq(2)").prop('id','masDepatId' + k + '');
		aClone.find("td:eq(2)").find("input:eq(3)").prop('id','referalPatientDt' + k + '');
		aClone.find("td:eq(2)").find("input:eq(4)").prop('id','referalPatientHd' + k + '');
		
		aClone.find("td:eq(3)").find("input:eq(0)").prop('id','icddiagnosis' + k + '');
		aClone.find("td:eq(4)").find("input:eq(0)").prop('id','instruction' + k + '');
		aClone.find("td:eq(5)").find("textarea:eq(0)").prop('id','specialistOpinion' + k + '');
	 	var referalFileHtml='<div class="fileUploadDiv"><input type="file" name="referalFileUpload'+k+'" id="referalFileUpload'+k+'" value="" class="inputUpload"><label class="inputUploadlabel">Choose File</label><span class="inputUploadFileName">No File Chosen</span></div>';
		aClone.find("td:eq(6)").html(referalFileHtml);
 
		
		//aClone.find("td:eq(5)").find("input:eq(0)").prop('id', 'referalFileUpload'+k+'');
		//aClone.find("td:eq(5)").find("input:eq(0)").prop('name', 'referalFileUpload'+k+'');
		aClone.find(":input").val("");
		aClone.find("option[selected]").removeAttr("selected")
		aClone.clone(true).appendTo('#medicalReferal');
		$('#medicalReferal>tr:last').find("td:eq(8)").find("button:eq(0)").attr("id", "referalDtMedicalIdDelNew");
 }
 
 function getDetailListRankUnitService(){
	 var params = {
				"service_no": $j('#serviceNo').val(),
				"hospitalId":$j('#hospitalId').val(),
				"flagFoDigi":'digi'
		}
		
		var pathname = window.location.pathname;
	 	var accessGroup = "MMUWeb";

	 	var url = window.location.protocol + "//"
	 			+ window.location.host + "/" + accessGroup
	 			+ "/registration/getDepartmentBloodGroupAndMedicalCategory";
		 $.ajax({
				type:"POST",
				contentType : "application/json",
				url:url,
				data : JSON.stringify(params),
				dataType: "json",			
				cache: false,
				success: function(data)
				{  
					 var dictionary =data;
					// var deptList=dictionary.departmentList;
					// var bloodGroupList=dictionary.bloodGroupList;
					 //var medicalCategoryList=dictionary.medicalCategoryList;
					// var masRelationList=dictionary.masRelationList;
					// var masStateList=dictionary.masStateList;
					 //var masDistrictList=dictionary.masDistrictList;
					 var rankList=dictionary.rankList;
					 var tradeList=dictionary.tradeList;
					 var unitList=dictionary.unitList;
					// var commandList=dictionary.commandList;
					// var maritalStatusList=dictionary.maritalStatusList;
					// var recordOfficeAddressList=dictionary.recordOfficeAddressList;
					 
					 
					 
					 var rankValues = "";
					 var rankList=dictionary.rankList;
					 var rankForDigi=$('#rankForDigi').val();
					 var selectedRank="";
					 rankValues = '<select class="form-control" name="rank"';
					 rankValues += 'id="rank">';
					 rankValues += '<option value="0"><strong>Select</strong></option>';
					 for(rankCount in rankList){
						
						 if(rankForDigi==rankList[rankCount].rankId){
							 selectedRank="selected";
						 }
						 else{
							 selectedRank=""; 
						 }
						 if(rankList[rankCount].rankId!="" && rankList[rankCount].rankId!=undefined && rankList[rankCount].rankId!=null){
						 rankValues += '<option '+selectedRank+' value='+rankList[rankCount].rankId+'>'
										+ rankList[rankCount].rankName
										+ '</option>';
						 }
					 }
					 rankValues += '</select>';
					 //$j('#rank').html(rankValues); 
					 
					 	 var tradeValues = "";
					 	var branchTradDigi=$('#branchTradDigi').val();
					 	 var tradeList=dictionary.tradeList;
					 	 var selectedTrade="";
					 	 
					 	tradeValues = '<select class="form-control" name="branchOrTrade"';
					 	tradeValues += 'id="branchOrTrade">';
						 tradeValues += '<option value="0"><strong>Select</strong></option>';
						 
					 for(tradeCount in tradeList){
						 if(branchTradDigi==tradeList[tradeCount].tradeId){
							 selectedTrade="selected";
						 }
						 else{
							 selectedTrade=''; 
						 }
						 if(tradeList[tradeCount].tradeId!="" && tradeList[tradeCount].tradeId!=undefined && tradeList[tradeCount].tradeId!=null){
						 tradeValues += '<option '+selectedTrade+' value='+tradeList[tradeCount].tradeId+'>'
										+ tradeList[tradeCount].tradeName
										+ '</option>';
						 }
					 }
					 tradeValues += '</select>';
					 //$j('#branchOrTrade').html(tradeValues); 
					 
					 
					  var unitValues = "";
					  var unitshipDigi=$('#unitshipDigi').val();
					 var unitList=dictionary.unitList;
					 var selectedUnit="";
					 
					 unitValues = '<select class="form-control" name="unitOrSlip"';
					 unitValues += 'id="unitOrSlip">';
					 unitValues += '<option value="0"><strong>Select</strong></option>';
					 for(unitCount in unitList){
						 if(unitshipDigi==unitList[unitCount].unitId){
							 selectedUnit="selected";
						 }
						 else{
							 selectedUnit=''; 
						 }
						 if(unitList[unitCount].unitId!="" && unitList[unitCount].unitId!=undefined && unitList[unitCount].unitId!=null){
						 unitValues += '<option '+selectedUnit+' value='+unitList[unitCount].unitId+'>'
										+ unitList[unitCount].unitName
										+ '</option>';
						 }
					 }
					 unitValues += '</select>';
					// $j('#unitOrSlip').html(unitValues); 
					
					 
					 
					  var genderValues = "";
					  var genderId=$('#genderId').val();
					  var genderList=dictionary.genderList;
					 var selectedGender="";
					 genderValues = '<select class="form-control" name="gender"';
					 genderValues += 'id="gender">';
					 genderValues += '<option value="0"><strong>Select</strong></option>';
					 for(gend in genderList){
						 if(genderId==genderList[gend].genderId){
							 selectedGender="selected";
						 }
						 else{
							 selectedGender=''; 
						 }
						 if(genderList[gend].genderId!="" && genderList[gend].genderId!=undefined && genderList[gend].genderId!=null){
						 genderValues += '<option '+selectedGender+' value='+genderList[gend].genderId+'>'
										+ genderList[gend].genderName
										+ '</option>';
						 }
					 }
					 genderValues += '</select>';
					 $j('#gender').html(genderValues); 
					 
					 
					 
					 var maritalStatusValues = "";
					  var maritalStatusId=$('#maritalStatusId').val();
					  var maritalStatusList=dictionary.maritalStatusList; 
					 var selectedMarital="";
					 maritalStatusValues = '<select class="form-control" name="maritalStatus"';
					 maritalStatusValues += 'id="maritalStatus">';
					 maritalStatusValues += '<option value="0"><strong>Select</strong></option>';
					 for(mari in maritalStatusList){
						 if(maritalStatusId==maritalStatusList[mari].mStatusId){
							 selectedMarital="selected";
						 }
						 else{
							 selectedMarital=''; 
						 }
						 if(maritalStatusList[mari].mStatusId!="" && maritalStatusList[mari].mStatusId!=undefined && maritalStatusList[mari].mStatusName!="" && maritalStatusList[mari].mStatusName!=undefined){
						 maritalStatusValues += '<option '+selectedMarital+' value='+maritalStatusList[mari].mStatusId+'>'
										+ maritalStatusList[mari].mStatusName
										+ '</option>';
						 }
						 }
					 maritalStatusValues += '</select>';
					 $j('#maritalStatus').html(maritalStatusValues); 
					 
					 
				},
				
				error: function(data)
				{					
					
					alert("An error has occurred while contacting the server");
					
				}
		}); 
	}
 
 
 
 function removeRowInvestigationReferal(val){
	 var tbl = document.getElementById('medicalReferal');
	   	lastRow = tbl.rows.length;
	if(lastRow>1){
		$(val).closest('tr').remove();
	}
	}
 
 
 
 
 function  openGeneralDocAndInvForDigi(flagDoc){
	 var tbl = "";
	 try{
		 var tbl = document.getElementById('dgInvetigationGrid');
		   	lastRow = tbl.rows.length;
		 
	 }
	 catch(e){}
		   	
		if(flagDoc=='gen'){
			$('#genDoc').show();
			$('#resultDoc').show();
			$('#investgationDetail').hide();
			$('#invAndRadio').hide();
			$('#orderNumberIdInv').hide();
		}
		if(flagDoc=='Lab'){
			$('#radioInvAndImaValue').val("Lab");
			$('#genDoc').hide();
			$('#resultDoc').hide();
			$('#investgationDetail').show();
			$('#invAndRadio').show();
			//$('#uomId').show();
			//$('#uomIds').show();
			$('#orderNumberIdInv').show();
			if(lastRow==1){
			var resultVal="";
		
			resultVal+='<input type="text" name="resultInvsTemp" id="resultInvsTemp"class="form-control" onBlur="setLabResultInFieldDigi(this);">';
			resultVal+='<input type="hidden" name="resultInvs" id="resultInvs"  value="@@@###" class="form-control">';
			$('#resultdiv').html(resultVal);	
			
		 	}
		}
		
		
		if(flagDoc=='Radio'){
			$('#genDoc').hide();
			$('#resultDoc').hide();
			$('#investgationDetail').show();
			//$('#uomId').hide();
			//$('#uomIds').hide()
			$('#invAndRadio').show();
			$('#orderNumberIdInv').show();
			var resultVal="";
			if(lastRow==1){
			resultVal+='<textarea name="resultInvs" id="resultInvs"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###</textarea>';
			resultVal+='<a class="btn-link" href="javascript:void(0)"   onclick="openResultModel(this);">View/Enter Result</a>';
			$('#resultdiv').html(resultVal);
			}
			}
		var countR=0;
	 	if(flagDoc=='Lab'|| flagDoc=='Radio'){
	 		 $('#dgInvetigationGrid tr').each(function(ij, el) {
	 			var dgResultHdVal= $(this).find("td:eq(1)").find("input:eq(0)").val();
	 		 if(dgResultHdVal!="" && dgResultHdVal!=0){
	 			 countR++;
	 		 }
	 		 });
	 		if(countR==0){
	 	 		$("#dgInvetigationGrid tr").remove();
	 	 		getInvestigationHtmlForDigi();	 
	 	 		}

	 	}
		
	}

 
/* function viewDocumentForDigi(ridcId)
 {
	
	        var pathname = window.location.pathname;
        	var accessGroup = "MMUWeb";

        	var url = window.location.protocol + "//"
        			+ window.location.host + "/" + accessGroup
        			+ "/opd/getRidcDocmentInfo";

        	//var data = $('employeeId').val();
           // alert("radioValue" +radioValue);
        	$.ajax({
        		type : "POST",
        		contentType : "application/json",
        		url : url,
        		data : JSON.stringify({
        			'ridcId' : ridcId,
        			
        		}),
        		dataType : 'json',
        		timeout : 100000,
        		
        		success : function(res)
        		
        		{
        			data = res.ridcInfoList;
    				
        			for(var i=0;i<data.length;i++){
    					
						var ridcInfo= data[i];
    					
    					var documentId=ridcInfo[0];
    					var documentName = ridcInfo[1];
    					var documentInfo = ridcInfo[2];
    				   	window.location = "../downloadDocumentFromRIDC?dId="+documentId+"&"+"docName="+documentName+"&"+"dFormat="+documentInfo+"";
        			}

        		
                   },
                   error: function (jqXHR, exception) {
                       var msg = '';
                       if (jqXHR.status == 0) {
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

 }*/
 
  
  function removeWhenDeleteFromInvestigation(ids){		
	 var investigationValueCurrent= $(ids).closest('tr').find("td:eq(1)").find("input:eq(0)").val();

 	 $('#fileUploadforInvesDynamic tr').each(function(ij, el) {
 		var investTextAreaVal= $(this).find("td:eq(1)").find("textarea:eq(0)").val();
 		var investTextAreaId= $(this).find("td:eq(1)").find("textarea:eq(0)").attr("id");
 		
 		if(investTextAreaVal.includes(investigationValueCurrent)){
 			var newUpdatedInvesVal=investTextAreaVal.replace(investigationValueCurrent,"");
 			$('#'+investTextAreaId).val(newUpdatedInvesVal)
 		}
 	 });
 	var investigationValP= $(ids).closest('tr').find("td:eq(1)").find("input:eq(3)").val();
 	  
 	$('tr[data-id="'+investigationValP+'"]').each(function( index ) {
 		 $(this).remove();
 	 
 	});
 	

 }
 
 
 function deleteInvestAndReferalValueRow(item,flage,valueForDelete) {
	 var lastRow=0;
	 if(confirm(resourceJSON.msgDelete)){
		 var idGrid="";
		 if(flage !=15 ){
			
			 idGrid= item.id; 
			 if(idGrid!=null && idGrid.includes("referalDtMedicalIdDelNew")){ 
				 var tbl = document.getElementById('medicalReferal');
				   	lastRow = tbl.rows.length;
				if(lastRow>1){
				 $(item).closest('tr').remove();
				 return true;
				}
			 }
			 
			 if(idGrid!=null && idGrid.includes("newIdTre")){ 
				 var tbl = document.getElementById('nomenclatureGrid');
				   	lastRow = tbl.rows.length;
				if(lastRow>1){
				 $(item).closest('tr').remove();
				 return true;
				}
			 }
			
			 if(idGrid!=null && idGrid.includes("newNivId")){ 
				 var tbl = document.getElementById('nipGrid');
				   	lastRow = tbl.rows.length;
				if(lastRow>1){
				 $(item).closest('tr').remove();
				 return true;
				}
			 }
			 
			 
			 
		try{	 
			if (idGrid == "newInvestigationId" ) {
			//var tbl = document.getElementById('dgInvetigationGrid');
		    	lastRow = 0;//tbl.rows.length;
			 
		   	$('#dgInvetigationGrid tr').each(function(j, el) {
				var investigationValueForDiasable = $(this).find("td:eq(1)").find("input:eq(3)").attr("id");
				if(investigationValueForDiasable!=null && !investigationValueForDiasable.includes("sub")){
				var investigationValueForDiasablevvv = $("#"+investigationValueForDiasable).val();
				if(investigationValueForDiasablevvv!="" && investigationValueForDiasablevvv!=null && investigationValueForDiasablevvv!=undefined){
					lastRow=parseInt(lastRow)+1;  
				}
				}
			});
			 
		}
		}
		catch(e){
			
		}
		 if(lastRow==1){
			 return false;
		 }
		 }
		 
		 if(flage ==15 ){
			 var tbl = document.getElementById('medicalBoardDocs');
			   	lastRow = tbl.rows.length;
			   idGrid= item.id;
			 if(lastRow==1){
				 return false;
			 }
			 if(idGrid!=null && idGrid.includes("deleteForSupportDocNew")){
				 $(item).closest('tr').remove();
			 }
		 }
		 if (idGrid == "newInvestigationId" ) {
			 removeWhenDeleteFromInvestigation(item);
			 $(item).closest('tr').remove();
			 
			 var tbl = document.getElementById('dgInvetigationGrid');
			 var lastRow = tbl.rows.length;
			 if(lastRow==0){
				 var disFlage="";
					getInvestigationHtml(disFlage);
			 }
				return false;
			}
		 
		 if (idGrid == "newSupportDoc" ) {
			 $(item).closest('tr').remove();
				return false;
			}
		if(idGrid=="referalDtMedicalIdDelNew"){
			
			 var tbl = document.getElementById('medicalReferal');
			   	lastRow = tbl.rows.length;
			if(lastRow==1){
				getPatientReferalDetailForDigiFileUpload();
			}
			$(item).closest('tr').remove();
			 
		}
		 
		 if(valueForDelete!="" && valueForDelete!=null && valueForDelete!=undefined  && valueForDelete!='0' ){
	   var pathname = window.location.pathname;
    	var accessGroup = "MMUWeb";

    	var url = window.location.protocol + "//"
    			+ window.location.host + "/" + accessGroup
    			+ "/opd/getRidcDocmentInfo";

    	$.ajax({
    		type : "POST",
    		contentType : "application/json",
    		url : url,
    		data : JSON.stringify({
    			'ridcId' : valueForDelete,
    			
    		}),
    		dataType : 'json',
    		timeout : 100000,
			success : function(res) {
				
				data = res.ridcInfoList;
				var ridcInfo="";
				var documentId="";
				var documentName ="";
				var documentInfo = "";
				var encryptedName ="";
				if(data!=null && data.length>0)
    			for(var i=0;i<data.length;i++){
					
					  ridcInfo= data[i];
					
					  documentId=ridcInfo[0];
					  documentName = ridcInfo[1];
					  documentInfo = ridcInfo[2];
					  encryptedName = ridcInfo[3];
    			}
					var url = window.location.protocol + "//"
	    			+ window.location.host + "/" + accessGroup
	    			+ "/digifileupload/deleteRmsFile";

	    	$.ajax({
	    		type : "POST",
	    		contentType : "application/json",
	    		url : url,
	    		data : JSON.stringify({
	    			'documentId' : documentId,
	    			'documentName' : documentName,
	    			'documentInfo' : documentInfo,
	    			'encryptedName':encryptedName,
	    		}),
	    		dataType : 'json',
	    		timeout : 100000,
				success : function(res) {
				var	data = res.deleteStatus;
					if(data=='success'){
						
						 var url1 = window.location.protocol + "//"
							+ window.location.host + "/" + accessGroup
							+ "/opd/deleteGridRow";
						 var visitId=$('#visitId').val();
						 var opdPatientDetailId=$('#opdPatientDetailId').val();
						 var patientId=$('#patientId').val();
							var data = {
								"valueForDelete" : valueForDelete,
								"flag" : flage,
								"visitId" : visitId,
								"opdPatientDetailId" : opdPatientDetailId,
								"patientId" : patientId
							};
							
							$.ajax({
								type : "POST",
								contentType : "application/json",
								url : url1,
								data : JSON.stringify(data),
								dataType : "json",
								cache : false,
								success : function(res) {
									if (flage == "10") {
										 $(item).closest('tr').remove();
										getAFMSF3BInvestigationForDigiFileUpload();
										//location.reload();
									}
									if (flage == "11") {
										 $(item).closest('tr').remove();
										getPatientReferalDetailForDigiFileUpload();
										//location.reload();
									}
									if (flage == "15") {
										 $(item).closest('tr').remove();
										 getDocumentList();
										 getPatientDocumentDetailHtml();
										 //location.reload();
									}
								}
							});
					}
					else{
						alert("Something is wrong with file");
					}
				}
				});
		 
			}
    	
    
    	
		});
    	
	 }
	 }
	}
 function getInvestigationHtmlForDigiMe() {
	 
	 
	 	var investigationGridValue = "investigationGrid";
	 	var investigationData="";
	  					 
	 					var count = 1;
	 					var countins = 1;
	 					var investigationfinalValue = "";
	 					var diasableValue="disabled";
	 					 func1='populateChargeCode';
			    		   url1='medicalexam';
			    		   url2='getInvestigationListUOM';
			    		   flaga='investigationMeDg';
	  							investigationData += '<tr>';
	 							investigationData += '<td> ';
	 							investigationData += '<div class="form-check form-check-inline cusCheck m-l-10">';
	 							investigationData += ' 	<input   class="form-check-input position-static" type="checkbox"  name="checkBoxForUpload" id="checkBoxForUpload" onClick="return getInvestionCheckData(this);"><span class="cus-checkbtn"></span> ';
	 							investigationData += '</div> ';
	 							investigationData += ' </td> ';
	 							investigationData += '<td><div class="autocomplete forTableResp">';
	 							investigationData += '<input type="text"   value="" id="chargeCodeName"';
	 							//investigationData += ' class="form-control border-input" name="chargeCodeName" autocomplete="off" onKeyPress="autoCompleteCommonUp(this,1);" onblur="populateChargeCode(this.value,'+ countins +',this);"/>';
	 							investigationData += ' class="form-control border-input" name="chargeCodeName"    onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
	 							
	 							investigationData += '<input type="hidden" id="qty" tabindex="1" name="qty1"  maxlength="6"/>';
	 							investigationData += '<input type="hidden" tabindex="1" id="chargeCodeCode"';
	 							investigationData += 'name="chargeCodeCode"   readonly />';
	 							investigationData += '<input type="hidden"  name="investigationIdValue" value=""  id="investigationIdValue"/>';

	 							investigationData += '<input type="hidden"  name="dgOrderDtIdValue" value="" id="dgOrderDtIdValue"/>';
	 							investigationData += '<input type="hidden"  name="dgOrderHdId" value="" id="dgOrderHdId"/>';
	 							 
	 							investigationData += '<input type="hidden"  name="dgResultHdId" value="" id="dgResultHdId"/>';
	 							
	 							investigationData += '<input type="hidden"  name="dgResultDtId" value="" id="dgResultDtId"/>';
	 							investigationData += '<input type="hidden" name="investigationType" value=""';
	 							investigationData += '	id="investigationType" />';
	 							investigationData += '<div id="investigationDivMeDg" class="autocomplete-itemsNew"></div>';	
	 							investigationData += ' </div></td>';

	 							var radioInvAndImaValue=$('#radioInvAndImaValue').val();
	 							if(radioInvAndImaValue=='Lab'){
	 							investigationData += '	<td>';
	 							investigationData += '	<input type="text" name="UOM" id="UOM" value=" " class="form-control"   readonly>';
	 							investigationData += '	</td>';
	 							}
	 							else{
	 								investigationData += '<td><input type="text" name="UOM" id="UOM" value=" " class="form-control"   readonly></td>';
	 							}

	 							investigationData += '	<td>';
	 							 if(radioInvAndImaValue=='Lab'){
	 	 							investigationData += '	<input type="text" name="resultInvs" id="resultInvs" value="" class="form-control">';
	 							 }
	 							
	 							 if(radioInvAndImaValue=='Radio'){
	 								investigationData += '<textarea name="resultInvs" id="resultInvs"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">   </textarea>';
	 								investigationData += '	<a class="btn-link" href="javascript:void(0)"   onclick="openResultModel(this);">View/Enter Result</a>';
	 							 }
	 							
	 							investigationData += '	</td>';
	 							investigationData += '<td>';
	 							investigationData += '<input type="text" name="range" id="range" value="" class="form-control">';
	 							investigationData += '</td>';
	 							
	 							investigationData += '<td>';
	 							investigationData += '<textarea class="form-control"  name="investigationRemarks" id="investigationRemarks" rows="2" maxlength="500"></textarea>';
	 							investigationData += ' </td>';
	 							investigationData += '	<td> </td>';
	 							investigationData += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth"   button-type="add" value="" ';
	 							investigationData += 'onclick="addRowForInvestigationFunUpMe();" ';
	 							investigationData += '	tabindex="1" > </button></td>';

	 							investigationData += '<td><button type="button" name="delete" value=""   button-type="delete" id="newInvestigationId"';
	 							investigationData += 'class="buttonDel btn btn-danger noMinWidth"';
	 							investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,0);"';
	 							investigationData += '	tabindex="1" ></button></td>';
	 							investigationData += ' </tr> ';
	 						$("#dgInvetigationGrid").html(investigationData);
	   
	  
	 }
	 
 function getHospitalListDigi(){
	 var hospitalIdForDigi=$('#hospitalIdForDigi').val();
	 var pathname = window.location.pathname;
 	var accessGroup = "MMUWeb";
	 var url1 = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/master/getHospitalListByRegion";
		$.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: url1,
		    data: JSON.stringify({}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	//alert("success "+result.data.length);
		    	var combo = "<option value='0'>Select</option>" ;

		    	for(var i=0;i<result.data.length;i++){
		    		var selectedHospital="";
		    		 if(hospitalIdForDigi==result.data[i].hospitalId){
		    			 selectedHospital="selected";
					 }
					 else{
						 selectedHospital=''; 
					 }
		    		combo += '<option '+selectedHospital+' value='+result.data[i].hospitalId+'>' +result.data[i].hospitalName+ '</option>';
		    	}
		    	$j('#hospitalForDigi').append(combo);
		    }
		    
		});
	}
 
  
 
 function getPatientDocumentDetailHtml() {
	 	var patientDocDetailData="";
	  					 
	 				var count = 1;
	 				var countins = 1;
	 				 var totalCountForPatientDoc=0;
	 					
	 					if (patientDocumentDetailList != null && patientDocumentDetailList.length > 0) {
							for (var i = 0; i < patientDocumentDetailList.length; i++) {
								if(patientDocumentDetailList[i].ridcId!=null){
									totalCountForPatientDoc++;
	 								}
								patientDocDetailData+='<tr>';
	
								var documentId=patientDocumentDetailList[i].documentId;
								patientDocDetailData += '<td><select class="form-control" id="docId'
 									+ i + '" name="docId"';
								patientDocDetailData += 'class="medium">';
 							patientDocDetailData += '<option value="0"><strong>Please select Document</strong></option>';
 							var selectPatientDocDetail = "";
 						
 						if(masDocumentList!=null && masDocumentList.length!=0)
 							for (var j = 0; j < masDocumentList.length; j++) {
 												if (documentId == masDocumentList[j].documentId) {
 													selectPatientDocDetail = 'selected';
 												} else {
 													selectPatientDocDetail = "";
 												}
 												patientDocDetailData += '<option ' + selectPatientDocDetail + ' value="' +masDocumentList[j].documentId + '@'
 												+ masDocumentList[j].documentCode + '" >' + masDocumentList[j].documentName
 												+ '</option>';
 											}
 								patientDocDetailData += '</select>';
 								patientDocDetailData += '<input type="hidden" id="patientDocumentId'+patientDocumentDetailList[i].patientDocumentId+'" name="patientDocumentId" value="'+patientDocumentDetailList[i].patientDocumentId+'"/>';
 								patientDocDetailData  += '</td>';
								
								patientDocDetailData+='<td class="width200">';
								patientDocDetailData+='   <textarea name="medicalDocs" id="medicalDocs'+i+'" class="form-control" id="medicalDocumentsDetails" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###'+escapeHtml(patientDocumentDetailList[i].documentRemarks)+'</textarea>';
								patientDocDetailData+='	<a class="btn-link" href="Javascript:Void(0)" onclick="openResultModelMedicalDocs(this);"  >View/Enter Result</a>';
								patientDocDetailData+='</td>';
								var displayFileAndDco="";
								if(patientDocumentDetailList[i].ridcId!=null){
									
								patientDocDetailData += '	<td><a class="btn-link" href="JavaScript:Void(0);" onclick="viewDocumentForDigi('+patientDocumentDetailList[i].ridcId+');" >View Document</a></td>'
								}
								else{
									patientDocDetailData+='<td>';																		
									patientDocDetailData+='<div class="fileUploadDiv">';
									patientDocDetailData+='<input type="file" name="medicalBoardDocsUpload" value="" id="medicalBoardDocsUpload" class="inputUpload">';
									patientDocDetailData+='<label class="inputUploadlabel">Choose File</label>';
									patientDocDetailData+='<span class="inputUploadFileName">No File Chosen</span>';
									patientDocDetailData+='</div>';
									patientDocDetailData+='</td>';
								}
								
								patientDocDetailData+='<td>';
								patientDocDetailData+='  <button type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowMBDocs()"></button>';
								patientDocDetailData+='</td>';
								//patientDocDetailData+='  <td>';
								//patientDocDetailData+='    <button type="button" disabled class="btn btn-danger buttonAdd noMinWidth" value="" button-type="delete" tabindex="1" onclick="removeRowMBDocs(this)"></button>';
								
								patientDocDetailData += '<td><button type="button"     name="deleteForSupportDoc" value=""    id="deleteForSupportDoc"  class="buttonDel btn btn-danger noMinWidth" button-type="delete"  tabindex="1" onclick="deleteInvestAndReferalValueRow(this,15,\''
									+ patientDocumentDetailList[i].ridcId + '\');" ></button></td>';
								patientDocDetailData += '<td style="display: none";><input type="text" name="docType" name="docType" value="16"/></td>';
								//patientDocDetailData+='   </td>';
								patientDocDetailData+='	</tr>';
							}
							$("#medicalBoardDocs").html(patientDocDetailData);
	 						$('#totalLengthDigiFileSupportDoc').val(totalCountForPatientDoc);
	 					}
	 						
	 						
	   
	  
	 }
	 
 
 
 
 function deleteInvestAndReferalValueRowGenDoc(item,flag,valueForDelete,fileId) {
	 if(confirm(resourceJSON.msgDelete)){
		 var tbl = document.getElementById('resultUploadDocTable');
		   	lastRow = tbl.rows.length;
		 var idGrid= item.id;
		 if(lastRow==1){
			// below is commented because only row can also be delete.
			// return false;  
		 }
		
		 
		 if(valueForDelete!="" && valueForDelete!=null && valueForDelete!=undefined  && valueForDelete!='0' ){
	   var pathname = window.location.pathname;
    	var accessGroup = "MMUWeb";

    	var url = window.location.protocol + "//"
    			+ window.location.host + "/" + accessGroup
    			+ "/opd/getRidcDocmentInfo";

    	$.ajax({
    		type : "POST",
    		contentType : "application/json",
    		url : url,
    		data : JSON.stringify({
    			'ridcId' : valueForDelete,
    			
    		}),
    		dataType : 'json',
    		timeout : 100000,
			success : function(res) {
				
				data = res.ridcInfoList;
				var ridcInfo="";
				var documentId="";
				var documentName ="";
				var documentInfo = "";
				var encryptedName ="";
				if(data!=null && data.length>0)
    			for(var i=0;i<data.length;i++){
					
					  ridcInfo= data[i];
					
					  documentId=ridcInfo[0];
					  documentName = ridcInfo[1];
					  documentInfo = ridcInfo[2];
					  encryptedName = ridcInfo[3];
    			}
					var url = window.location.protocol + "//"
	    			+ window.location.host + "/" + accessGroup
	    			+ "/digifileupload/deleteRmsFile";

	    	$.ajax({
	    		type : "POST",
	    		contentType : "application/json",
	    		url : url,
	    		data : JSON.stringify({
	    			'documentId' : documentId,
	    			'documentName' : documentName,
	    			'documentInfo' : documentInfo,
	    			'encryptedName':encryptedName,
	    		}),
	    		dataType : 'json',
	    		timeout : 100000,
				success : function(res) {
				var	data = res.deleteStatus;
					if(data=='success'){
						deleteFile(fileId);
					}
					else{
						alert("Something is wrong with file");
					}
				}
				});
		 
			}
    	
    
    	
		});
    	
	 }
	 }
	}
 
 function getSubInvestigationHtml(investiongationId,item){
	 
	 
	var investigationType=$(item).closest('tr').find("td:eq(1)").find("input:eq(8)").val();
	if(investigationType!="" && investigationType=='m'){
		var investigationName=$(item).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
	   $('#'+investigationName).attr("readonly", true);
	   var resultId=$(item).closest('tr').find("td:eq(3)").find("input:eq(0)").attr("id");
	   var rangeId=$(item).closest('tr').find("td:eq(4)").find("input:eq(0)").attr("id");
	   var idResult= $(item).closest('tr').find("td:eq(3)").find("input:eq(1)").attr("id");
	   $('#'+idResult).val("@@@###,");
	   $('#'+resultId).attr("readonly", true);
	   $('#'+rangeId).attr("readonly", true);
	} 
	 var pathname = window.location.pathname;
	 var genderId=$('#genderId1').val();
 	var accessGroup = "MMUWeb";
	 var url1 = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/digifileupload/getSubInvestigationHtml";
	 
		$.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: url1,
		    data: JSON.stringify({ 
		    	"investiongationId":investiongationId,
				 "employeeId":"1",
				 "genderId":genderId,
		    }),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	var	subInvestigationData = result.subInvestigationData;
		    	var investigationData="";
		    	var dgInvestigationAlreadyVal=$("#dgInvetigationGrid").val();
		    	var count=0;
		    	var approvalFlagDiasable='disabled';
		    	if(subInvestigationData!=null && subInvestigationData.length>0)
	    			for(var i=0;i<subInvestigationData.length;i++){
						
	    				
	    				var dgSubMasInvestigationId=subInvestigationData[i].dgSubMasInvestigationId;
	    				var subInvestigationName=subInvestigationData[i].subInvestigationName;
	    				var subInvestigationCode=subInvestigationData[i].subInvestigationCode;
	    				
	    				var uOMName=subInvestigationData[i].uOMName;
	    				var investigationIdVal=subInvestigationData[i].investigationIdInsub;
	    				var investigationType=subInvestigationData[i].investigationType;
	    				
	    				var rangeValSub=subInvestigationData[i].rangeValSub;
	    				var mainChargeCodeName =subInvestigationData[i].mainChargeCodeName;
	    				
	    				var subChargeCodeIdd=subInvestigationData[i].subChargeCodeIdVal;
	    				var mainChargeCodeIdd=subInvestigationData[i].mainChargeCodeIdSubVal;
	    				investigationData += '<tr data-id="'+investigationIdVal+'">';
	    				
						investigationData +='<td style="width: 150px;"></td>';
						investigationData += '<td><div class="form-group autocomplete forTableResp">';
						investigationData += '<input type="text" readonly autocomplete="never" value="'+subInvestigationName + '[' + dgSubMasInvestigationId + ']"';
						
						investigationData += ' class="form-control border-input" name="subInvestigationName" id="subInvestigationName'+count+'"  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
						investigationData += '<input type="hidden"  name="subInvestigationNameIdAndInv" value="'
								+ dgSubMasInvestigationId +"@@"+investigationIdVal+'"  id="subInvestigationNameIdAndInv' + dgSubMasInvestigationId + '"/>';
						
						investigationData += '<input type="hidden"  name="investigationSubType" value="'
							+ investigationType +'"  id="investigationSubType' +investigationType+ '"/>';
				
						//investigationData += '<input type="hidden"  name="appointmentIdSubInves" value=""  id="appointmentIdSubInves"/>';
						 investigationData += '<input type="hidden"  name="subInvestigationNameIdTemp" value="'+dgSubMasInvestigationId+'"  id="subInvestigationNameIdTemp'+count+'"/>';
						investigationData += '<input type="hidden"  name="dgOrderDtIdValueSubInves" value="" id="dgOrderDtIdValueSubInves"/>';
						investigationData += '<input type="hidden"  name="dgOrderHdIdSubInves" value="" id="dgOrderHdIdSubInves"/>';
						
							investigationData += '<input type="hidden" name="subChargecodeIdForSub" value="'+subChargeCodeIdd+'"';
							investigationData += '	id="subChargecodeIdForSub'+count+'" />';
							
								
							investigationData += '<input type="hidden" name="mainChargecodeIdValForSub" value="'+mainChargeCodeIdd+'"';
							investigationData += '	id="mainChargecodeIdValForSub'+count+'" />';
							
							
						investigationData += '<div id="investigationDivMe" class="autocomplete-itemsNew"></div>';
						investigationData += '</div></td>';

						investigationData += '	<td>';
						investigationData += '	<input type="text" name="UOMSub" id="UOMSub'+count+'" value="'+uOMName+'" class="form-control" redonly  >';
						investigationData += '	</td>';
						
						
						 
						
						/*if(mainChargeCodeName=='Lab'){
 							
								investigationData += '	<td>';
								
	 							
	 							investigationData+='<input type="text" name="resultSubInvTemp" id="resultSubInvTemp'+dgSubMasInvestigationId+'"class="form-control" onBlur="setLabResultInField(this);">';
	 							investigationData += '	<input type="hidden" name="resultSubInv"  id="resultSubInv'+dgSubMasInvestigationId+'" value="" class="form-control" >';
	 							investigationData += '	</td>';

							}	
							
							if(mainChargeCodeName=='Radio'){
								investigationData += '	<td>';
								investigationData+='<textarea name="resultSubInvs" id="resultSubInvs'+dgSubMasInvestigationId+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;"></textarea>';
								investigationData+='<a class="btn-link" href="javascript:void(0)"  onclick="openResultModel(this);">View/Enter Result</a>';
								investigationData += '	</td>';
							}*/

						if(mainChargeCodeName=='Lab'){
 							
							investigationData += '	<td>';
							investigationData+='<input type="text" name="resultInvsTemp" id="resultInvsTemp'+dgSubMasInvestigationId+'"class="form-control" onBlur="setLabResultInFieldDigi(this);">';
 							investigationData += '	<input type="hidden" name="resultSubInv"  id="resultSubInv'+dgSubMasInvestigationId+'" value="@@@###" class="form-control" >';
 							investigationData += '	</td>';

						}	
						
						if(mainChargeCodeName=='Radio'){
							investigationData += '	<td>';
							investigationData+='<textarea name="resultSubInvs" id="resultSubInvs'+dgSubMasInvestigationId+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###</textarea>';
							investigationData+='<a class="btn-link" href="javascript:void(0)"  data-toggle="modal" data-target="#messageForResult" data-backdrop="static" onclick="openResultModel(this);">View/Enter Result</a>';
							investigationData += '	</td>';
						}
						
						investigationData += '<td><input type="text" name="rangeSubInves" value="'+rangeValSub+'"';
						investigationData += '	id="rangeSubInves'+count+'" class="form-control"></td>';
						
						var deleteButtonFlag="";
							var ridcIdVal=0;
						
						
						investigationData += '<td></td>';

						investigationData += '<td></td>';
						investigationData += ' </tr> ';
						count+=1;
						 
	    			}
		    	$(dgInvetigationGrid).append(investigationData);
		    	 
		    }
		    
		});
 }

 
 function getSubInvestionByValues(dgSubMasInvestigationId,subInvestigationName,subInvestigationCode,uOMName,investigationIdVal,investigationType,
		 rangeValSub,mainChargeCodeName,count,orderDtIdForSub,orderHdIdForSub,resultEntryDtidForSub,resultEntryHdidForSub,mainChargeCodeIdForSub,subMainChargeCodeIdForSub){
	 func1='populateChargeCode';
	    url1='medicalexam';
	   url2='getInvestigationListUOM';
	   flaga='investigationMeDg';
		 
		var investigationData = '<tr   data-id="'+investigationIdVal+'">';
		investigationData +='<td style="width: 150px;"></td>';
		investigationData += '<td><div class="form-group autocomplete forTableResp">';
		investigationData += '<input type="text" readonly autocomplete="never" value="'+subInvestigationName + '[' + dgSubMasInvestigationId + ']"';
		
		investigationData += ' class="form-control border-input" name="subInvestigationName" id="subInvestigationName'+count+'"  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
		investigationData += '<input type="hidden"  name="subInvestigationNameIdAndInv" value="'
				+ dgSubMasInvestigationId +"@@"+investigationIdVal+'"  id="subInvestigationNameIdAndInv' + dgSubMasInvestigationId + '"/>';
		
		investigationData += '<input type="hidden"  name="investigationSubType" value="'
			+ investigationType +'"  id="investigationSubType' +investigationType+ '"/>';

		//investigationData += '<input type="hidden"  name="appointmentIdSubInves" value=""  id="appointmentIdSubInves'+count+'"/>';
		 investigationData += '<input type="hidden"  name="subInvestigationNameIdTemp" value="'+dgSubMasInvestigationId+'"  id="subInvestigationNameIdTemp'+count+'"/>';
		investigationData += '<input type="hidden"  name="dgOrderDtIdValueSubInves" value="'+orderDtIdForSub+'" id="dgOrderDtIdValueSubInves'+count+'"/>';
		investigationData += '<input type="hidden"  name="dgOrderHdIdSubInves" value="'+orderHdIdForSub+'" id="dgOrderHdIdSubInves'+count+'"/>';
		
		investigationData += '<input type="hidden"  name="dgResultDtIdValueSubInves" value="'+resultEntryDtidForSub+'" id="dgOrderDtIdValueSubInves'+count+'"/>';
		investigationData += '<input type="hidden"  name="dgResultHdIdSubInves" value="'+resultEntryHdidForSub+'" id="dgOrderHdIdSubInves'+count+'"/>';
		
		investigationData += '<input type="hidden" name="subChargecodeIdForSub" value="'+subMainChargeCodeIdForSub+'"';
		investigationData += '	id="subChargecodeIdForSub'+count+'" />';
		
			
		investigationData += '<input type="hidden" name="mainChargecodeIdValForSub" value="'+mainChargeCodeIdForSub+'"';
		investigationData += '	id="mainChargecodeIdValForSub'+count+'" />';
		
		investigationData += '<div id="investigationDivMe" class="autocomplete-itemsNew"></div>';
		investigationData += '</div></td>';

		investigationData += '	<td>';
		investigationData += '	<input type="text" name="UOMSub" id="UOMSub'+count+'" value="'+uOMName+'" class="form-control" redonly  >';
		investigationData += '	</td>';
		
		
		 
		if(mainChargeCodeName=='Lab'){
				
				investigationData += '	<td>';
				
				investigationData += '	<input type="text" name="resultSubInvTemp" id="resultSubInvTemp'+dgSubMasInvestigationId+'" value="" class="form-control"  onBlur="setLabResultInField(this);">';
				investigationData+='<input type="hidden" name="resultSubInv" id="resultSubInv'+dgSubMasInvestigationId+'" value="" class="form-control">';

				
					//investigationData += '	<input type="text" name="resultSubInv"  id="resultSubInv'+count+'" value="" class="form-control" >';
					investigationData += '	</td>';

			}	
			
			if(mainChargeCodeName=='Radio'){
				investigationData += '	<td>';
				investigationData+='<textarea name="resultSubInvs" id="resultSubInvs'+dgSubMasInvestigationId+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;"></textarea>';
				investigationData+='<a class="btn-link" href="javascript:void(0)"  onclick="openResultModel(this);">View/Enter Result</a>';
				investigationData += '	</td>';
			}

		
		
		investigationData += '<td><input type="text" name="rangeSubInves" value="'+rangeValSub+'"';
		investigationData += 'id="rangeSubInves'+count+'" class="form-control"></td>';
		 
		
		var deleteButtonFlag="";
			var ridcIdVal=0;
		
		
		investigationData += '<td></td>';

		investigationData += '<td></td>';
		investigationData += ' </tr> ';
		count+=1;
	 return investigationData;
 }
 
 function addRowForInvestigationFunUpMe(flagFordig){
	 var radioInvAndImaValue=$('#radioInvAndImaValue').val();
	 var tbl = document.getElementById('dgInvetigationGrid');
   	lastRow = tbl.rows.length;
   	i =lastRow;
   	i++;
	    var aClone = $('#dgInvetigationGrid>tr:last').clone(true)
	     aClone.removeAttr('data-id');
	    aClone.find('img.ui-datepicker-trigger').remove();
		aClone.find(":input").val("");
		/*aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'checkBoxForUpload'+i+'');
		aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'chargeCodeName'+i+'');
		aClone.find("td:eq(1)").find("input:eq(3)").prop('id', 'investigationIdValue'+i+'');
		aClone.find("td:eq(1)").find("div").find("div").prop('id', 'investigationDivMe' + i + '');
		
		aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'UOM'+i+'');
		
		var resultHtml="";
		 if(radioInvAndImaValue=='Lab'){
			 	//aClone.find("td:eq(3)").find("input:eq(0)").prop('id', 'resultInvs'+i+'');
		
			 	resultHtml='<input type="text" name="resultInvs" id="resultInvs'+i+'" value="" class="form-control">';
				aClone.find("td:eq(3)").html(resultHtml);
		 }
		 if(radioInvAndImaValue=='Radio'){
				aClone.find("td:eq(3)").find("textarea:eq(0)").prop('id', 'resultInvs'+i+'');

				resultHtml = '<textarea name="resultInvs" id="resultInvs'+i+'"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">   </textarea>';
				resultHtml += '	<a class="btn-link" href="javascript:void(0)"  data-toggle="modal" data-target="#messageForResult" data-backdrop="static" onclick="openResultModel(this);">View/Enter Result</a>';
				aClone.find("td:eq(3)").html(resultHtml);
		 }
			aClone.find("td:eq(4)").find("input:eq(0)").prop('id', 'range'+i+'');
			aClone.find("td:eq(5)").find("input:eq(0)").prop('id', 'investigationRemarks'+i+'');
			var viewDoc='<td style="display:none"> </td>';
			aClone.find("td:eq(6)").html(viewDoc);
			
			*/
			
			var investigationData="";
			 func1='populateChargeCode';
 		   url1='medicalexam';
 		   url2='getInvestigationListUOM';
 		   flaga='investigationMeDg';
			 investigationData += '<td> ';
			investigationData += '<div class="form-check form-check-inline cusCheck m-l-10">';
			investigationData += ' 	<input   class="form-check-input position-static" type="checkbox"  name="checkBoxForUpload" id="checkBoxForUpload'+i+'" onClick="return getInvestionCheckData(this);"><span class="cus-checkbtn"></span> ';
			investigationData += '</div> ';
			investigationData += ' </td> ';
			investigationData += '<td><div   class="autocomplete forTableResp">';
			investigationData += '<input type="text"  readonly value="" id="chargeCodeName' + i + '"';
			//investigationData += ' class="form-control border-input" name="chargeCodeName" autocomplete="off" onKeyPress="autoCompleteCommonUp(this,1);" onblur="populateChargeCode(this.value,'+ countins +',this);"/>';
			investigationData += ' class="form-control border-input" name="chargeCodeName"    onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
			investigationData += '<input type="hidden" id="qty" tabindex="1" name="qty1"  maxlength="6"/>';
			investigationData += '<input type="hidden" tabindex="1" id="chargeCodeCode'+i+'"';
			investigationData += 'name="chargeCodeCode"   readonly />';
			investigationData += '<input type="hidden"  name="investigationIdValue" value=""  id="investigationIdValue'+i+'"/>';

			investigationData += '<input type="hidden"  name="dgOrderDtIdValue" value="" id="dgOrderDtIdValue'+i+'"/>';
			investigationData += '<input type="hidden"  name="dgOrderHdId" value="" id="dgOrderHdId'+i+'"/>';
			 
			investigationData += '<input type="hidden"  name="dgResultHdId" value="" id="dgResultHdId'+i+'"/>';
			
			investigationData += '<input type="hidden"  name="dgResultDtId" value="" id="dgResultDtId'+i+'"/>';
			investigationData += '	 <input type="hidden" name="investigationType" value=""';
			investigationData += 'id="investigationType'+i+'" />';
			
			investigationData += '<input type="hidden" name="subChargecodeIdForInv" value=""';
			investigationData += '	id="subChargecodeIdForInv'+i+'" />';
			investigationData += '<input type="hidden" name="mainChargecodeIdValForInv" value=""';
			investigationData += '	id="mainChargecodeIdValForInv'+i+'" />';
			investigationData += '<div id="investigationDivMeDg'+i+'" class="autocomplete-itemsNew"></div>';	
			investigationData += ' </div></td>';
			investigationData += '	<td>';
			investigationData += '	<input type="text" name="UOM" id="UOM'+i+'" value="" class="form-control"   readonly>';
			investigationData += '	</td>';
			
			
			if(radioInvAndImaValue=='Lab'){	
				investigationData += '	<td>';
				 investigationData+='<input type="text" name="resultInvsTemp" id="resultInvsTemp'+i+'" value="" class="form-control"  onBlur="setLabResultInFieldDigi(this);" >';
				investigationData += '	<input type="hidden" name="resultInvs" id="resultInvs'+radioInvAndImaValue+i+'" value="@@@###" class="form-control">';
				investigationData += '	</td>';
				}
				else{
					investigationData += '	<td>';
						investigationData += '<textarea name="resultInvs" id="resultInvs'+radioInvAndImaValue+i+'"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###</textarea>';
						investigationData += '	<a class="btn-link" href="javascript:void(0)"  onclick="openResultModel(this);">View/Enter Result</a>';
						investigationData += '	</td>';
				}
			
			
		 
			investigationData += '<td>';
			investigationData += '<input type="text" name="range" id="range'+i+'" value="" class="form-control">';
			investigationData += '	<input type="hidden" name="investigationResultDate" id="investigationResultDate'+i+'" value="" class="form-control">';
			investigationData += '	<input type="hidden" name="resultNumber" id="resultNumber'+i+'" value="" class="form-control">';
			
			investigationData += '</td>';
			 
			investigationData += '<td>';
				investigationData += '<textarea class="form-control"  name="investigationRemarks" id="investigationRemarks'+i+'" rows="2" maxlength="500"></textarea>';
				investigationData += ' </td>';
			 
				//investigationData += '	<td style="display:none"><input type="file" name="fileInvUpload'+i+'" id="fileInvUpload'+i+'"></td>';
			investigationData += '<td> </td>'
			 
			investigationData += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth"   button-type="add" value="" ';
			investigationData += 'onclick="addRowForInvestigationFunUpMe();" ';
			investigationData += '	tabindex="1" > </button></td>';

			investigationData += '<td><button type="button" name="delete" value=""   button-type="delete" id="newInvestigationId"';
			investigationData += 'class="buttonDel btn btn-danger noMinWidth"';
			investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,0);" ></button></td>';										 
		 
			aClone.html(investigationData);	
			
			
 			aClone.find("td:eq(1)").find("input:eq(0)").removeAttr("readonly");
 			
 			aClone.find("td:eq(3)").find("div").find("div").find("div").find("div").prop('id', 'investigationResultDateTemp' + i + '');
 			aClone.find("td:eq(3)").find("div").find("div").find("div").find("div").prop('id', 'resultNumberTemp' + i + '');

 			
			aClone.find('input[type="checkbox"]').prop("checked", false);
			aClone.find('input[type="checkbox"]').removeAttr("disabled");
			aClone.find("td:eq(9)").find("button:eq(0)").removeAttr("disabled",false);
			aClone.find("td:eq(9)").find("button:eq(0)").removeAttr("id").attr("id", "newInvestigationId");
			aClone.clone(true).appendTo('#dgInvetigationGrid');
	
 } 
 
 
 
 function addRowForInvestigationFunUpMeDigi( ){
	 var radioInvAndImaValue=$('#radioInvAndImaValue').val();
	 var tbl = document.getElementById('dgInvetigationGrid');
   	lastRow = tbl.rows.length;
   	i =lastRow;
   	i++;
	    var aClone = $('#dgInvetigationGrid>tr:last').clone(true)
	     aClone.removeAttr('data-id');
	    aClone.find('img.ui-datepicker-trigger').remove();
		aClone.find(":input").val("");
		aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'checkBoxForUpload'+i+'');
		aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'chargeCodeName'+i+'');
		aClone.find("td:eq(1)").find("input:eq(3)").prop('id', 'investigationIdValue'+i+'');
		aClone.find("td:eq(1)").find("div").find("div").prop('id', 'investigationDivMe' + i + '');
		
		aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'UOM'+i+'');
		
		var resultHtml="";
		 if(radioInvAndImaValue=='Lab'){
			 	//aClone.find("td:eq(3)").find("input:eq(0)").prop('id', 'resultInvs'+i+'');
		
			 	resultHtml='<input type="text" name="resultInvs" id="resultInvs'+radioInvAndImaValue+i+'" value="" class="form-control">';
				aClone.find("td:eq(3)").html(resultHtml);
		 }
		 if(radioInvAndImaValue=='Radio'){
				aClone.find("td:eq(3)").find("textarea:eq(0)").prop('id', 'resultInvs'+i+'');

				resultHtml = '<textarea name="resultInvs" id="resultInvs'+radioInvAndImaValue+i+'"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">   </textarea>';
				resultHtml += '	<a class="btn-link" href="javascript:void(0)"  onclick="openResultModel(this);">View/Enter Result</a>';
				aClone.find("td:eq(3)").html(resultHtml);
		 }
			aClone.find("td:eq(4)").find("input:eq(0)").prop('id', 'range'+i+'');
			aClone.find("td:eq(5)").find("input:eq(0)").prop('id', 'investigationRemarks'+i+'');
			var viewDoc='<td style="display:none"> </td>';
			aClone.find("td:eq(6)").html(viewDoc);
			
			
			var investigationData="";
			 func1='populateChargeCode';
 		   url1='medicalexam';
 		   url2='getInvestigationListUOM';
 		   flaga='investigationMeDg';
			 investigationData += '<td> ';
			investigationData += '<div class="form-check form-check-inline cusCheck m-l-10">';
			investigationData += ' 	<input   class="form-check-input position-static" type="checkbox"  name="checkBoxForUpload" id="checkBoxForUpload'+i+'" onClick="return getInvestionCheckData(this);"><span class="cus-checkbtn"></span> ';
			investigationData += '</div> ';
			investigationData += ' </td> ';
			investigationData += '<td><div   class="autocomplete forTableResp">';
			investigationData += '<input type="text"  readonly value="" id="chargeCodeName' + i + '"';
			//investigationData += ' class="form-control border-input" name="chargeCodeName" autocomplete="off" onKeyPress="autoCompleteCommonUp(this,1);" onblur="populateChargeCode(this.value,'+ countins +',this);"/>';
			investigationData += ' class="form-control border-input" name="chargeCodeName"    onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
			investigationData += '<input type="hidden" id="qty" tabindex="1" name="qty1"  maxlength="6"/>';
			investigationData += '<input type="hidden" tabindex="1" id="chargeCodeCode'+i+'"';
			investigationData += 'name="chargeCodeCode"   readonly />';
			investigationData += '<input type="hidden"  name="investigationIdValue" value=""  id="investigationIdValue'+i+'"/>';

			investigationData += '<input type="hidden"  name="dgOrderDtIdValue" value="" id="dgOrderDtIdValue'+i+'"/>';
			investigationData += '<input type="hidden"  name="dgOrderHdId" value="" id="dgOrderHdId'+i+'"/>';
			 
			investigationData += '<input type="hidden"  name="dgResultHdId" value="" id="dgResultHdId'+i+'"/>';
			
			investigationData += '<input type="hidden"  name="dgResultDtId" value="" id="dgResultDtId'+i+'"/>';
			investigationData += '	 <input type="hidden" name="investigationType" value=""';
			investigationData += 'id="investigationType'+i+'" />';
			
			investigationData += '<input type="hidden" name="subChargecodeIdForInv" value=""';
			investigationData += '	id="subChargecodeIdForInv'+i+'" />';
			investigationData += '<input type="hidden" name="mainChargecodeIdValForInv" value=""';
			investigationData += '	id="mainChargecodeIdValForInv'+i+'" />';
			investigationData += '<div id="investigationDivMeDg'+i+'" class="autocomplete-itemsNew"></div>';	
			investigationData += ' </div></td>';
			
			investigationData += '	<td>';
			investigationData += '	<input type="text" name="UOM" id="UOM'+i+'" value="" class="form-control"   readonly>';
			investigationData += '	</td>';
			
			if(radioInvAndImaValue=='Lab'){	
			investigationData += '	<td>';
			 investigationData+='<input type="text" name="resultInvsTemp" id="resultInvsTemp'+i+'" value="" class="form-control"  onBlur="setLabResultInFieldDigi(this);" >';
			investigationData += '	<input type="hidden" name="resultInvs" id="resultInvs'+radioInvAndImaValue+i+'" value="@@@###" class="form-control">';
			investigationData += '	</td>';
			}
			else{
				investigationData += '	<td>';
					investigationData += '<textarea name="resultInvs" id="resultInvs'+radioInvAndImaValue+i+'"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###</textarea>';
					investigationData += '	<a class="btn-link" href="javascript:void(0)"  onclick="openResultModel(this);">View/Enter Result</a>';
					investigationData += '	</td>';
			}
			investigationData += '<td>';
			investigationData += '<input type="text" name="range" id="range'+i+'" value="" class="form-control">';
			investigationData += '	<input type="hidden" name="investigationResultDate" id="investigationResultDate'+i+'" value="" class="form-control">';
			investigationData += '	<input type="hidden" name="resultNumber" id="resultNumber'+i+'" value="" class="form-control">';
			investigationData += '</td>';
			
			investigationData += '<td> </td>';
			 
			investigationData += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth"   button-type="add" value="" ';
			investigationData += 'onclick="addRowForInvestigationFunUpMeDigi();" ';
			investigationData += '	tabindex="1" > </button></td>';

			investigationData += '<td><button type="button" name="delete" value=""   button-type="delete" id="newInvestigationId"';
			investigationData += 'class="buttonDel btn btn-danger noMinWidth"';
			investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,0);" ></button></td>';										 
		 
			aClone.html(investigationData);	
			
			
 			aClone.find("td:eq(1)").find("input:eq(0)").removeAttr("readonly");
			aClone.find('input[type="checkbox"]').prop("checked", false);
			aClone.find('input[type="checkbox"]').removeAttr("disabled");
			aClone.find("td:eq(9)").find("button:eq(0)").removeAttr("disabled",false);
			aClone.find("td:eq(9)").find("button:eq(0)").removeAttr("id").attr("id", "newInvestigationId");
			aClone.clone(true).appendTo('#dgInvetigationGrid');
	
 } 
 
 
 function setLabResultInField(ids){
	 var investigationValP= $(ids).closest('tr').find("td:eq(3)").find("input:eq(0)").val();
	var idResult= $(ids).closest('tr').find("td:eq(3)").find("input:eq(1)").attr("id");
	
	 var tbl = document.getElementById('dgInvetigationGrid');
	   var	lastRow = tbl.rows.length;
 	   $('#'+idResult).val("@@@###"+investigationValP);
 }

 
 function setLabResultInFieldDigi(ids){
	 var investigationValP= $(ids).closest('tr').find("td:eq(3)").find("input:eq(0)").val();
	var idResult= $(ids).closest('tr').find("td:eq(3)").find("input:eq(1)").attr("id");
	 var tbl = document.getElementById('dgInvetigationGrid');
	   var	lastRow = tbl.rows.length;
 	   $('#'+idResult).val("@@@###"+investigationValP);
 }
 
 function setLabResultInFieldMe(ids){
	 var investigationValP= $(ids).closest('tr').find("td:eq(3)").find("input:eq(0)").val();
		var idResult= $(ids).closest('tr').find("td:eq(3)").find("input:eq(1)").attr("id");
		 var tbl = document.getElementById('dgInvetigationGrid');
		   var	lastRow = tbl.rows.length;
	 	   $('#'+idResult).val("@@@###"+investigationValP);
 }
 
 
 function getTemplateDetail222ForDigi() {

		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/opd/getTemplateName";
		
		$.ajax({
					url : url,
					dataType : "json",
					data : JSON.stringify({
						'employeeId' : '1',
						'templateType' : 'I',
						'doctorId':$('#userId').val()
					}),
					contentType : "application/json",
					type : "POST",
					success : function(response) {
						console.log(response);
						var datas = response.template;
						var trHTML = '<option value=""><strong>Select...</strong></option>';
						//var count=0;
						$.each(datas, function(i, item) {
							trHTML += '<option value="' + item.templateId + '" >'
									+ item.templateName + '</option>';
						
						});
						try{
							$('#dgInvestigationTemplateId11ForDigi').html(trHTML);
							}catch(e){
								
							}
						try{
							$('#dgInvestigationTemplateId11').html(trHTML);
						}
						catch(e){
							
						}
						
						
						
						return true;
					},
					error : function(e) {

						console.log("ERROR: ", e);

					},
					done : function(e) {
						console.log("DONE");
						alert("success");
						var datas = e.data;

					}
				});

	}

	$(document).delegate("#dgInvestigationTemplateId11ForDigi","change",
			function() {

var genderId=$('#gender').val();
		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/digifileupload/getInvestigationAndSubInvesForTemplate";
		
		$.ajax({
					url : url,
					dataType : "json",
					data : JSON.stringify({
						'employeeId' : '1',
						'templateId':$('#dgInvestigationTemplateId11ForDigi').val(),
						'genderId':genderId
					}),
					contentType : "application/json",
					type : "POST",
					success : function(response) {
						console.log(response);
						
					   if (response.status == 1) {
						   
						//var datas = response.data;
						 // var listOfObject = response.listOfObject;
						var listOfObject = response.listObject;
						 var  subListData = response.subInvestigationData; 
						 
						var trHTML = '';
						
						var tbl = document.getElementById('dgInvetigationGrid');
					   	lastRow = tbl.rows.length;
					   	
						var i=50+parseInt(lastRow);
						var count = 50+parseInt(lastRow);
						var countins = 1;
						var investigationfinalValue = "";
						var diasableValue="disabled";
						var diasableValueCheck=" ";
						var checkedVal="";
	                  var disableFlag="";
	                  var countSno=0;
	                  var func1='populateChargeCode';
	                  var url1='medicalexam';
	                  var url2='getInvestigationListUOM';
	                  var flaga='investigationMe';
	                  var countForSub=0;
	                  var readonlyOnlyForInvestigation="";
	                  
						$.each(listOfObject, function(i, item) {
							
									var investigationValue=item.investigationName;
									var investigationId=item.templateInvestgationId;
									var uomName=item.uomName;
									var mainChargeCodeId=item.mainChargeCodeId;
									var subChargeCodeId=item.subChargeCodeId;
									var investigationType=item.investigationType;
									var minNormalValue=item.minNormalValue;
									var maxNormalValue=item.maxNormalValue;
									var mainChargeCodeNameVal=item.mainChargeCodeNameVal;
									
										var investExist=0;
										$('#dgInvetigationGrid tr').each(function(i, el) {
											var invesVal = $(this).find("td:eq(1)").find("input:eq(3)").val();
											if(invesVal==""){
												$(this).closest('tr').remove();
												}
											if(invesVal!="" &&(invesVal==investigationId)){
												investExist=1;
											return false;
											}
											else{
												investExist=0;
											}
										});
								
										
								if(investExist==0){	
									
									if(investigationType!="" && investigationType=='m'){
										
										readonlyOnlyForInvestigation="readonly";
									}
									else{
										readonlyOnlyForInvestigation="";
									}
									
								/////////////////////////////////////////////////////////////////////////////////////////
								trHTML += '<tr>';
								trHTML += '<td> ';
	  							trHTML += '<div class="form-check form-check-inline cusCheck m-l-10">';
	  							trHTML += ' <input class="form-check-input position-static"   type="checkbox"   name="checkBoxForUpload" id="checkBoxForUpload'+investigationId+'" onClick="return getInvestionCheckData(this);">';
	  							trHTML += '<span class="cus-checkbtn"></span> </div> ';
	  							trHTML += '</td> ';
	 							
	 							trHTML += '<td><div class="autocomplete forTableResp">';
	 							trHTML += '<input type="text"  readonly value="'
	 									+ investigationValue + '['
	 									+ investigationId
	 									+ ']" id="chargeCodeName' + count + '"';
	 							trHTML += ' class="form-control border-input" name="chargeCodeName" autocomplete="off"   onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" />';
	 							
	 							trHTML += '<input type="hidden" id="qty" tabindex="1" name="qty1"  maxlength="6"/>';
	 							trHTML += '<input type="hidden" tabindex="1" id="chargeCodeCode"';
	 							trHTML += 'name="chargeCodeCode"   readonly />';
	 							trHTML += '<input type="hidden"  name="investigationIdValue" value="'
	 									+ investigationId
	 									+ '"  id="investigationIdValue'
	 									+ investigationId + '"/>';

	 							trHTML += '<input type="hidden"  name="dgOrderDtIdValue" value="" id="dgOrderDtIdValue'
	 									+ count + '"/>';
	 							trHTML += '<input type="hidden"  name="dgOrderHdId" value="" id="dgOrderHdId'
	 									+ count + '"/>';
	 						 
	 							trHTML += '<input type="hidden"  name="dgResultHdId" value="" id="dgResultHdId'
	 								+ count + '"/>';
	 							
	 							trHTML += '<input type="hidden"  name="dgResultDtId" value="" id="dgResultDtId'
	 								+ count + '"/>';
	 							
								
								trHTML += '	 <input type="hidden" name="investigationType" value="'+investigationType+'"';
								trHTML += 'id="investigationType'+count+'" />';
								
								
								
								trHTML += '<input type="hidden" name="subChargecodeIdForInv" value="'+subChargeCodeId+'"';
								trHTML += '	id="subChargecodeIdForInv'+count+'" />';
							
								
								trHTML += '<input type="hidden" name="mainChargecodeIdValForInv" value="'+mainChargeCodeId+'"';
								trHTML += '	id="mainChargecodeIdValForInv'+count+'" />';
					
	 							
	 							trHTML += '<div id="investigationDivMeDg'+count+'" class="autocomplete-itemsNew"></div>';
	 							trHTML += '</div></td>';
	 							
	 							
	 							trHTML += '<td>';
	 							trHTML += '<input type="text" name="UOM" id="UOM'+count+'" value="'+uomName+'" class="form-control"  readonly>';
	 							trHTML += '</td>';
	 							
	 						 	
	 							if(mainChargeCodeNameVal=='Lab'){
	 	 							
	  							/*	trHTML += '<td>';
	  								trHTML+= '<input type="text" name="resultInvsTemp"  id="resultInvsTemp'+investigationId+'" value="" class="form-control"  onBlur="setLabResultInFieldMe(this);" '+readonlyOnlyForInvestigation+'>';
	 								trHTML += '<input type="hidden" name="resultInvs" id="resultInvs'+investigationId+'" value="@@@###" class="form-control" '+readonlyOnlyForInvestigation+'>';
	  								trHTML += '</td>';*/
	 								
	 								trHTML += '	<td>';
	 								trHTML+='<input type="text" name="resultInvsTemp" id="resultInvsTemp'+investigationId+'" value="" class="form-control"  onBlur="setLabResultInFieldDigi(this);" '+readonlyOnlyForInvestigation+' >';
	 								trHTML += '	<input type="hidden" name="resultInvs" id="resultInvs'+investigationId+'" value="@@@###" class="form-control" '+readonlyOnlyForInvestigation+'>';
	 								trHTML += '	</td>';

	  							}	
	  							
	  							if(mainChargeCodeNameVal=='Radio'){
	  								/*trHTML += '	<td>';
	  								trHTML+='<textarea name="resultInvs" id="resultInvs'+investigationId+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###</textarea>';
	  								trHTML+='<a class="btn-link" href="javascript:void(0)"  data-toggle="modal" data-target="#messageForResult" data-backdrop="static" onclick="openResultModel(this);">View/Enter Result</a>';
	  								trHTML += '	</td>';*/
	  								
	  								trHTML += '	<td>';
	  								trHTML += '<textarea name="resultInvs" id="resultInvs'+investigationId+'"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###</textarea>';
	  								trHTML += '	<a class="btn-link" href="javascript:void(0)"  onclick="openResultModel(this);">View/Enter Result</a>';
	  								trHTML += '	</td>';
	  							}
	  							var rangeForInves="";	
	  							
	  							
	  							 
	 							if(minNormalValue!=null && minNormalValue!=undefined && minNormalValue!=""){
	 								rangeForInves=minNormalValue;
	 							}
	 							if(maxNormalValue!=null && maxNormalValue!=undefined && maxNormalValue!=""){
	 								rangeForInves+="-"+maxNormalValue;
	 							}
	 							else{
	 								
	 								if(rangeForInves=="")
	 									rangeForInves="";
	 								}
	  							 
	 							trHTML += '<td><input type="text" name="range" value="'+rangeForInves+'"';
	 							trHTML += '	id="range'+investigationId+'" class="form-control" '+readonlyOnlyForInvestigation+'>';
	 							trHTML += '	<input type="hidden" name="investigationResultDate" id="investigationResultDate'+investigationId+'" value="" class="form-control">';
	 							trHTML += '	<input type="hidden" name="resultNumber" id="resultNumber'+investigationId+'" value="" class="form-control">';
	 							trHTML += '</td>';
	 							trHTML += '	<td></td>';
	 							trHTML += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth"  button-type="add" value=""';
	 							trHTML += 'onclick="addRowForInvestigationFunUpMeDigi();"';
	 							trHTML += '	tabindex="1" > </button></td>';

	 							trHTML += '<td><button type="button" name="delete" value=""  button-type="delete" id="newInvestigationId" ';
	 							trHTML += ' class="buttonDel btn btn-danger noMinWidth"';
	 							trHTML += 'onclick="deleteInvestAndReferalValueRow(this,10,0);" ></button></td>';
	 							trHTML += ' </tr> ';
	 							 
	 							var deleteButtonFlag=""; 
	 							//var subListData=""
	 							if(investigationType!="" && investigationType=='m'){	
	 							//for(var k in listOfObject){ 
	 								//if(investigationId==k){
	 									//subListData=listOfObject[k];
	 									for(var j=0;j<subListData.length;j++){
	 										//console.log("subInvestigationName "+subListData[j].subInvestigationName);
	 										if(item.templateInvestgationId==subListData[j].investigationIdInsub){
	 										var dgSubMasInvestigationId=subListData[j].dgSubMasInvestigationId;
												var subInvestigationName="";
												if(subListData[j]. subInvestigationName!="" && subListData[j]. subInvestigationName!=undefined)
												subInvestigationName=subListData[j]. subInvestigationName;
												var subInvestigationCode="";
												if(subListData[j].subInvestigationCadeForSub!="" && subListData[j].subInvestigationCadeForSub!=undefined)
													subInvestigationCode=subListData[j].subInvestigationCadeForSub;
												
												var uOMName="";
												if(subListData[j].umoNameSub!="" && subListData[j].umoNameSub!=undefined)
												uOMName=subListData[j].umoNameSub;
												
												var investigationIdVal="";
												if(subListData[j].investigationIdInsub!="" && subListData[j].investigationIdInsub!=undefined)
												investigationIdVal=subListData[j].investigationIdInsub;
												var investigationType="";
												if(subListData[j].investigationTypeSub!="" && subListData[j].investigationTypeSub!=undefined)
												investigationType=subListData[j].investigationTypeSub;
												
												var rangeValSub="";
												if(subListData[j].rangeSub!="" && subListData[j].rangeSub!=undefined)
												rangeValSub=subListData[j].rangeSub;
												
												var mainChargeCodeName=""
													if(subListData[j].mainChargeCodeNameForSub!="" && subListData[j].mainChargeCodeNameForSub!=undefined)
												mainChargeCodeName=subListData[j].mainChargeCodeNameForSub;
												var count=countForSub;
												
												var orderDtIdForSub="";
												if(subListData[j].orderDtIdForSub!="" && subListData[j].orderDtIdForSub!=undefined)
												orderDtIdForSub=subListData[j].orderDtIdForSub;
												
												var orderHdIdForSub="";
												if(subListData[j].orderHdIdForSub!="" && subListData[j].orderHdIdForSub!=undefined)
												orderHdIdForSub=subListData[j].orderHdIdForSub;
												
												var resultEntryDtidForSub="";
												if(subListData[j].resultEntryDtidForSub!="" && subListData[j].resultEntryDtidForSub!=undefined)
												resultEntryDtidForSub=subListData[j].resultEntryDtidForSub;
												
												var resultEntryHdidForSub="";
												if(subListData[j].resultEntryHdidForSub!="" && subListData[j].resultEntryHdidForSub!=undefined)
												resultEntryHdidForSub=subListData[j].resultEntryHdidForSub;
												
												
												var mainChargeCodeIdForSub="";
												if(subListData[j].mainChargeCodeIdForSub!="" && subListData[j].mainChargeCodeIdForSub!=undefined)
													mainChargeCodeIdForSub=subListData[j].mainChargeCodeIdForSub;
												
												var subMainChargeCodeIdForSub="";
												if(subListData[j].subMainChargeCodeIdForSub!="" && subListData[j].subMainChargeCodeIdForSub!=undefined)
													subMainChargeCodeIdForSub=subListData[j].subMainChargeCodeIdForSub;
											
												
												var resultForSub="";
												if(subListData[j].resultForSub!="" && subListData[j].resultForSub!=undefined)
													resultForSub=subListData[j].resultForSub;
											
												
												
												count=countForSub;
												var subInvestigationHtml=getSubInvestionByValuesForDigi(dgSubMasInvestigationId,subInvestigationName,subInvestigationCode,uOMName,investigationIdVal,investigationType,
														 rangeValSub,mainChargeCodeName,count,orderDtIdForSub,orderHdIdForSub,resultEntryDtidForSub,
														 resultEntryHdidForSub,mainChargeCodeIdForSub,subMainChargeCodeIdForSub,resultForSub,disableFlag,deleteButtonFlag);
												 
												trHTML+=subInvestigationHtml;
												
	 										}
	 										
	 									//}
	 								//}
	 								
	 							}
	 						}
	 							 
								///////////////////////////////////////////////////////////////////////////////////////////////
								count++;
								countins++;
								
							}
										
														
						});
						$('#dgInvetigationGrid').append(trHTML);
					}
					}
				   ,
					error : function(e) {

						console.log("ERROR: ", e);

					},
					done : function(e) {
						console.log("DONE");
						alert("success");
						var datas = e.data;

					}
				});

	});
 
 
 
 
 
	 function setHealthDigi(ids){
		 var healthText= $(ids).closest('tr').find("td:eq(2)").find("input:eq(0)").val();
		var idResult= $(ids).closest('tr').find("td:eq(2)").find("input:eq(1)").attr("id");
		 var tbl = document.getElementById('familyHistoryGrid');
		   var	lastRow = tbl.rows.length;
	 	   $('#'+idResult).val("@@@###"+healthText);
	 }
	 
 
	 function setCauseOfDeathDigi(ids){
		 var healthText= $(ids).closest('tr').find("td:eq(3)").find("input:eq(0)").val();
		var idResult= $(ids).closest('tr').find("td:eq(3)").find("input:eq(1)").attr("id");
		 var tbl = document.getElementById('familyHistoryGrid');
		   var	lastRow = tbl.rows.length;
	 	   $('#'+idResult).val("@@@###"+healthText);
	 }
	 
 
 
 
	 $j('body').on("focus",".noFuture_date_ResultDate", function() {
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
			beforeShow: function()  {
				if($(this).closest('.dateRightPosition').length>0){
					$('#ui-datepicker-div').addClass('dateRightModal2');
				}
			},
			onClose:function(){
				$('#ui-datepicker-div').removeClass('dateRightModal2');
			},
			yearRange: '-40:+0',
			maxDate: new Date(),
			onSelect: function(dateText) {
		      display(this);
		      $(this).change();
		    }
	   	 }).on("change", function() {
	 	    display("Change event");  
	   	 });
	   	function display(ides) {
	   		setDateIntoResultDate(ides);
	   	}
	   });
	 
	 function setDateIntoResultDate(item) {
		  var dateValue= item.value;
		  var currentObjecttResultOffLineDate=$('#currentObjectForResultOffLineDate').val();
		  if(dateValue!=undefined && dateValue!="" && dateValue!=null)
		  	$('#'+currentObjecttResultOffLineDate).val(dateValue);
	 }
 
	 function setResultNumber(item) {
		  var resultNumber=item.value;
		  var currentObjectForResultOffLineNumber=$('#currentObjectForResultOffLinenumber').val();
		  if(resultNumber!=undefined && resultNumber!="" && resultNumber!=null)
		  $('#'+currentObjectForResultOffLineNumber).val(resultNumber);
	 }

function checkForCategoryDetail(item){
	var checkForLengthSize=0;
	 $('#medicalCategory tr').each(function(ij, el) {
			var diagnosisValue= $(this).find("td:eq(0)").find("input:eq(0)").val();
		 if(diagnosisValue!="" && diagnosisValue!=0){
			 checkForLengthSize++;
		 }
		 });
	if(checkForLengthSize>=2){
		return true;
	}
	else{
		 
		$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").val("");
		$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val("");
		return false;
	}
}

function newMbEntryForm(flag){
	 window.location.href = "mbNewEntryForm"	 
}




function getApprovalForPresAndInves() {
	var tractStatus=$('#tractStatus').val();
	var disablePre="";
	if(tractStatus!="" && tractStatus=='y'){
		disablePre="readonly";
	}
	else{
		disablePre="";
	}
	
	 var approvalFlag=$('#approvalFlag').val();
	 var approvalFlagDiasable="";
	 if(approvalFlag!="" && approvalFlag!=undefined && approvalFlag!=null && approvalFlag=='y'){
		 approvalFlagDiasable='disabled';
	 }
	 else{
		 approvalFlagDiasable="";
	 }
	 var genderId="";
	try{
		genderId=$('#genderId').val();
	}
	catch(e){
		
	}
	 
	var investigationGridValue = "investigationGrid";
	var investigationData="";
	var visitId = $('#visitId').val();
	var patientId=$('#patientId').val();
	var totalRidcUploadVal=0;
	var data = {
		"visitId" : visitId,
		"opdPatientDetailId":1,
		"patientId":patientId,
		"flagForModule":"me",
		"genderId":genderId
	};
	 var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";
     var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalexam/getInvestigationAndResult";
	$.ajax({
				type : "POST",
				contentType : "application/json",
				//url : '/AshaWeb/opd/getInvestigationDetail',
				url:url,
				data : JSON.stringify(data),
				dataType : "json",
				success : function(res) {
					//data = res.listObject;
					  data = res.listObject;
					var  subListData = res.subInvestigationData; 
					
					var count = 1;
					var countins = 1;
					var investigationfinalValue = "";
					var diasableValue="disabled";
					var checkedVal="";
					var diasableValueCheck="";
					var otherInvergation="";
					var countForSub=0;
					 func1='populateChargeCode';
		    		   url1='medicalexam';
		    		   url2='getInvestigationListUOM';
		    		   flaga='investigationMe';
					if (data != null && data.length > 0) {
						otherInvergation=data[0].otherInvestigation;
						
						for (var i = 0; i < data.length; i++) {
							
							if(data[i].investigationType!="" && data[i].investigationType=='m'){
								
								readonlyOnlyForInvestigation="readonly";
							}
							else{
								readonlyOnlyForInvestigation="";
							}
					
					
							
							investigationData += '<tr>';
					
							
							var ridcIdVal=0;
							if (subListData != null && subListData.length > 0) {
								for (var j = 0; j < subListData.length; j++) {
										if(data[i].investigationId==subListData[j].investigationIdSub){
											ridcIdVal=subListData[j].ridcIdSub
											break;
										}
										else{
											ridcIdVal=0;
										}
								}
							}
					if(data[i].investigationType!="" && (data[i].investigationType=='s'||data[i].investigationType=='t')){
						
							if (data != null && data[i].ridcIdInvVal) {
								ridcIdVal= data[i].ridcIdInvVal;
							}
							else{
								ridcIdVal=0;
							}
							}
							
						if(ridcIdVal!=null && ridcIdVal!=0)
							{
							 diasableValueCheck="disabled";
							checkedVal="checked";
							}
						else{
							diasableValueCheck="";
							checkedVal="";
						}
							
							investigationData += '<td> ';
 							investigationData += '<div class="form-check form-check-inline cusCheck">';
 							investigationData += ' 	<input class="form-check-input position-static"   type="checkbox" '+checkedVal+' '+diasableValueCheck+' name="checkBoxForUpload" id="checkBoxForUpload'+data[i].investigationId+'" onClick="return getInvestionCheckData(this);">';
 							investigationData += '<span class="cus-checkbtn"></span> </div> ';
 							investigationData += ' </td> ';
							
							investigationData += '<td><div   class="autocomplete forTableResp">';
							investigationData += '<input type="text"  readonly value="'
									+ data[i].investigationName + '['
									+ data[i].investigationId
									+ ']" id="chargeCodeName' + count + '"';
							//investigationData += ' class="form-control border-input" name="chargeCodeName" autocomplete="off" onKeyPress="autoCompleteCommonMe(this,1);" onblur="populateChargeCode(this.value,'+ countins +',this);" '+approvalFlagDiasable+'/>';
							investigationData += ' class="form-control border-input" name="chargeCodeName" autocomplete="off"   onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" '+approvalFlagDiasable+''+disablePre+'/>';
							
							investigationData += '<input type="hidden" id="qty" tabindex="1" name="qty1"  maxlength="6"/>';
							investigationData += '<input type="hidden" tabindex="1" id="chargeCodeCode"';
							investigationData += 'name="chargeCodeCode"   readonly />';
							investigationData += '<input type="hidden"  name="investigationIdValue" value="'
									+ data[i].investigationId
									+ '"  id="investigationIdValue'
									+ data[i].investigationId + '"/>';

							investigationData += '<input type="hidden"  name="dgOrderDtIdValue" value='
									+ data[i].dgOrderDtId
									+ ' id="dgOrderDtIdValue'
									+ data[i].dgOrderDtId + '"/>';
							investigationData += '<input type="hidden"  name="dgOrderHdId" value='
									+ data[i].orderHdId
									+ ' id="dgOrderHdId'
									+ data[i].orderHdId + '"/>';
						var resultHdId=0;
							if(data[i].dgResultHd!=null && data[i].dgResultHd!=undefined){
								resultHdId=data[i].dgResultHd;
							}
							else{
								resultHdId=0;
							}
							var resultdtId=0;
							if(data[i].dgResultDt!=null && data[i].dgResultDt!=undefined){
								resultdtId=data[i].dgResultDt;
							}
							else{
								resultdtId=0;
							}
							investigationData += '<input type="hidden"  name="dgResultHdId" value='+resultHdId+' id="dgResultHdId'
								+ resultHdId + '"/>';
							
							investigationData += '<input type="hidden"  name="dgResultDtId" value='+resultdtId+ ' id="dgResultDtId'
								+ resultdtId + '"/>';
							
								
							var investigationTypeForInves="";
							if(data[i].investigationType!=null){
								investigationTypeForInves=data[i].investigationType;
							}
							else{
								investigationTypeForInves="";
							}
							
							var subChargeCodeIdForInves="";
							if(data[i].subChargeCodeIdForInv!=null){
								subChargeCodeIdForInves=data[i].subChargeCodeIdForInv;
							}
							else{
								subChargeCodeIdForInves="";
							}
							
							var mainChargeCodeIdForInves="";
							if(data[i].mainChargeCodeForInv!=null){
								mainChargeCodeIdForInves=data[i].mainChargeCodeForInv;
							}
							else{
								mainChargeCodeIdForInves="";
							}
							
							
							investigationData += '	 <input type="hidden" name="investigationType" value="'+investigationTypeForInves+'"';
							investigationData += 'id="investigationType'+i+'" />';
							
							
							
							investigationData += '<input type="hidden" name="subChargecodeIdForInv" value="'+subChargeCodeIdForInves+'"';
							investigationData += '	id="subChargecodeIdForInv'+count+'" />';
						
							
							investigationData += '<input type="hidden" name="mainChargecodeIdValForInv" value="'+mainChargeCodeIdForInves+'"';
							investigationData += '	id="mainChargecodeIdValForInv'+count+'" />';
				
							
							investigationData += '<div id="investigationDivMe'+count+'" class="autocomplete-itemsNew"></div>';


							investigationData += ' </div></td>';
								var saveInDraft=$('#saveInDraft').val();
							
							
							
							investigationData += '	<td>';
							investigationData += '	<input type="text" name="UOM" id="UOM'+count+'" value="'+data[i].uomName+'" class="form-control" '+approvalFlagDiasable+' readonly>';
							investigationData += '	</td>';
							
						 	
							if(data[i].mainChargeCodeNameForInve=='Lab'){
	 							
 								investigationData += '	<td>';
 	 							//investigationData += '	<input type="text" name="resultInvs" '+approvalFlagDiasable+' id="resultInvs'+count+'" value="'+data[i].result+'" class="form-control" '+readonlyOnlyForInvestigation+' >';
 								investigationData+='<input type="text" name="resultInvsTemp" '+approvalFlagDiasable+' id="resultInvsTemp'+data[i].investigationId+'" value="'+escapeHtml(data[i].result)+'" class="form-control"  onBlur="setLabResultInFieldMe(this);" '+readonlyOnlyForInvestigation+' '+disablePre+' >';
								investigationData += '	<input type="hidden" name="resultInvs" id="resultInvs'+data[i].investigationId+'" value="@@@###'+escapeHtml(data[i].result)+'" class="form-control">';
 								investigationData += '	</td>';

 							}	
 							
 							if(data[i].mainChargeCodeNameForInve=='Radio'){
 								investigationData += '	<td>';
 								investigationData+='<textarea name="resultInvs" id="resultInvs'+data[i].investigationId+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###'+escapeHtml(data[i].result)+'</textarea>';
 								investigationData+='<a class="btn-link" href="javascript:void(0)"  onclick="openResultModel(this);">View/Enter Result</a>';
 								investigationData += '	</td>';
 							}
 							var rangeForInves="";	
 							
 							
 							if(data[i].rangeValue){
 								rangeForInves=data[i].rangeValue;
 							}
 							else{
							if(data[i].minNormalValue!=null && data[i].minNormalValue!=undefined && data[i].minNormalValue!=""){
								rangeForInves=data[i].minNormalValue;
							}
							if(data[i].maxNormalValue!=null && data[i].maxNormalValue!=undefined && data[i].maxNormalValue!=""){
								rangeForInves+="-"+data[i].maxNormalValue;
							}
							else{
								
								if(rangeForInves=="")
									rangeForInves="";
								}
 							}
 							var reultOfflineNumber="";
 							if(data[i].reultOfflineNumber!="")
 							reultOfflineNumber=data[i].reultOfflineNumber;
 							
 							var reultOfflineDate="";
 							if(data[i].resultOffLineDate!="")
 								reultOfflineDate=data[i].resultOffLineDate;
 							
							investigationData += '<td><input type="text" name="range" value="'+rangeForInves+'" id="range'+data[i].investigationId+'" class="form-control" '+readonlyOnlyForInvestigation+' '+disablePre+' />';
							
							investigationData += '	<input type="hidden" name="investigationResultDate"   value="'+reultOfflineDate+'"   id="investigationResultDate'+data[i].investigationId+'"  class="form-control"/>';
							investigationData += '	<input type="hidden"  name="resultNumber"    value="'+reultOfflineNumber+'" id="resultNumber'+data[i].investigationId+'"  class="form-control"/>';
						
							investigationData += '</td>';
							
						 
							var investigationRemarks="";	
							if(data[i].investigationRemarks!=null && data[i].investigationRemarks!=undefined){
								investigationRemarks=data[i].investigationRemarks;
							}
							else{
								investigationRemarks="";
								}
						/*	investigationData += '	<td>';
							investigationData += '	<textarea class="form-control"  name="investigationRemarks" id="investigationRemarks'+count+'" rows="2" maxlength="500" '+readonlyOnlyForInvestigation+'>'+investigationRemarks+'</textarea>';
							investigationData += '	 </td>';*/
							var deleteButtonFlag="";
 							if(ridcIdVal!=null && ridcIdVal!=0){		
	 							investigationData += '	<td><a class="btn-link" href="JavaScript:Void(0);"  onclick="viewDocumentForDigi('+ridcIdVal+');" >View Document</a></td>'
	 							totalRidcUploadVal++;
	 							ridcIdVal=ridcIdVal;
	 							deleteButtonFlag='';
	 							}
	 							else{
	 								investigationData += '	<td></td>';
	 								ridcIdVal=0;
	 								deleteButtonFlag='disabled';
	 							}
							
							
							
							investigationData += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth" id="addInves"'+diasableValue+' '+disablePre+' button-type="add" value=""';
							investigationData += 'onclick="addRowForInvestigationFunUpMe();"';
							investigationData += '	tabindex="1" > </button></td>';

							investigationData += '<td><button type="button" name="delete" value=""  button-type="delete" id="deleteInves" '+diasableValue+''+disablePre+'';
							investigationData += ' class="buttonDel btn btn-danger noMinWidth"';
							investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,\''
									+ ridcIdVal + '\');" ></button></td>';
							investigationData += ' </tr> ';
							

							if(data[i].investigationType!="" && data[i].investigationType=='m'){
								
							if (subListData != null && subListData.length > 0) {
								
								 
								for (var j = 0; j < subListData.length; j++) {
									
									countForSub++;
										if(data[i].investigationId==subListData[j].investigationIdSub){
											 
										var dgSubMasInvestigationId=subListData[j].subInvestigationId;
											var subInvestigationName="";
											if(subListData[j]. subInvestigationName!="" && subListData[j]. subInvestigationName!=undefined)
											subInvestigationName=subListData[j]. subInvestigationName;
											var subInvestigationCode="";
											if(subListData[j].subInvestigationCadeForSub!="" && subListData[j].subInvestigationCadeForSub!=undefined)
												subInvestigationCode=subListData[j].subInvestigationCadeForSub;
											
											var uOMName="";
											if(subListData[j].umoNameSub!="" && subListData[j].umoNameSub!=undefined)
											uOMName=subListData[j].umoNameSub;
											
											var investigationIdVal="";
											if(subListData[j].investigationIdSub!="" && subListData[j].investigationIdSub!=undefined)
											investigationIdVal=subListData[j].investigationIdSub;
											
											var investigationType="";
											if(subListData[j].investigationTypeSub!="" && subListData[j].investigationTypeSub!=undefined)
											investigationType=subListData[j].investigationTypeSub;
											
											var rangeValSub="";
											if(subListData[j].rangeSub!="" && subListData[j].rangeSub!=undefined)
											rangeValSub=subListData[j].rangeSub;
											
											var mainChargeCodeName=""
												if(subListData[j].mainChargeCodeNameForSub!="" && subListData[j].mainChargeCodeNameForSub!=undefined)
											mainChargeCodeName=subListData[j].mainChargeCodeNameForSub;
											var count=countForSub;
											
											var orderDtIdForSub="";
											if(subListData[j].orderDtIdForSub!="" && subListData[j].orderDtIdForSub!=undefined)
											orderDtIdForSub=subListData[j].orderDtIdForSub;
											
											var orderHdIdForSub="";
											if(subListData[j].orderHdIdForSub!="" && subListData[j].orderHdIdForSub!=undefined)
											orderHdIdForSub=subListData[j].orderHdIdForSub;
											
											var resultEntryDtidForSub="";
											if(subListData[j].resultEntryDtidForSub!="" && subListData[j].resultEntryDtidForSub!=undefined)
											resultEntryDtidForSub=subListData[j].resultEntryDtidForSub;
											
											var resultEntryHdidForSub="";
											if(subListData[j].resultEntryHdidForSub!="" && subListData[j].resultEntryHdidForSub!=undefined)
											resultEntryHdidForSub=subListData[j].resultEntryHdidForSub;
											
											
											var mainChargeCodeIdForSub="";
											if(subListData[j].mainChargeCodeIdForSub!="" && subListData[j].mainChargeCodeIdForSub!=undefined)
												mainChargeCodeIdForSub=subListData[j].mainChargeCodeIdForSub;
											
											var subMainChargeCodeIdForSub="";
											if(subListData[j].subMainChargeCodeIdForSub!="" && subListData[j].subMainChargeCodeIdForSub!=undefined)
												subMainChargeCodeIdForSub=subListData[j].subMainChargeCodeIdForSub;
										
											
											var resultForSub="";
											if(subListData[j].resultForSub!="" && subListData[j].resultForSub!=undefined)
												resultForSub=subListData[j].resultForSub;
										
											var investigationRemarksForSub="";
											if(subListData[j].investigationRemarksForSub!="" && subListData[j].investigationRemarksForSub!=undefined)
												investigationRemarksForSub=subListData[j].investigationRemarksForSub;
										
											
											
											var subInvestigationHtml=getSubInvestionByValuesForPres(dgSubMasInvestigationId,subInvestigationName,subInvestigationCode,uOMName,investigationIdVal,investigationType,
													 rangeValSub,mainChargeCodeName,count,orderDtIdForSub,orderHdIdForSub,resultEntryDtidForSub,
													 resultEntryHdidForSub,mainChargeCodeIdForSub,subMainChargeCodeIdForSub,resultForSub,diasableValue,approvalFlagDiasable,investigationRemarksForSub,disablePre);
											
											investigationData+=subInvestigationHtml;
											
										}
									
									}
								}
							}
							
							
							count++;
						}
						if (data != null && data.length > 0) {
							$('#investgationDetail').show();
							$('#precriptionAndNiv').hide();
							$("#dgInvetigationGrid").html(investigationData);
						}
					}
					 
				}
			});

	return false;
}



function getSubInvestionByValuesForPres(dgSubMasInvestigationId,subInvestigationName,subInvestigationCode,uOMName,investigationIdVal,investigationType,
		 rangeValSub,mainChargeCodeName,count,orderDtIdForSub,orderHdIdForSub,resultEntryDtidForSub,resultEntryHdidForSub,mainChargeCodeIdForSub,subMainChargeCodeIdForSub,resultForSub,
		 disableFlag,deleteButtonFlag,investigationRemarksForSub,disablePre){
	 func1='populateChargeCode';
	    url1='medicalexam';
	   url2='getInvestigationListUOM';
	   flaga='investigationMeDg';
		 
		var investigationData = '<tr data-id="'+investigationIdVal+'">';
		investigationData +='<td></td>';
		investigationData += '<td><div class="form-group autocomplete forTableResp">';
		investigationData += '<input type="text" readonly autocomplete="never" value="'+subInvestigationName + '[' + dgSubMasInvestigationId + ']"';
		
		investigationData += ' class="form-control border-input" name="subInvestigationName" id="subInvestigationName'+count+'"  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"'+disablePre+'/>';
		investigationData += '<input type="hidden"  name="subInvestigationNameIdAndInv" value="'
				+ dgSubMasInvestigationId +"@@"+investigationIdVal+'"  id="subInvestigationNameIdAndInv' + dgSubMasInvestigationId + '"/>';
		
		investigationData += '<input type="hidden"  name="investigationSubType" value="'
			+ investigationType +'"  id="investigationSubType' +investigationType+ '"/>';

		//investigationData += '<input type="hidden"  name="appointmentIdSubInves" value=""  id="appointmentIdSubInves'+count+'"/>';
		investigationData += '<input type="hidden"  name="subInvestigationNameIdTemp" value="'+dgSubMasInvestigationId+'"  id="subInvestigationNameIdTemp'+count+'"/>';
		investigationData += '<input type="hidden"  name="dgOrderDtIdValueSubInves" value="'+orderDtIdForSub+'" id="dgOrderDtIdValueSubInves'+count+'"/>';
		investigationData += '<input type="hidden"  name="dgOrderHdIdSubInves" value="'+orderHdIdForSub+'" id="dgOrderHdIdSubInves'+count+'"/>';

		investigationData += '<input type="hidden" name="subChargecodeIdForSub" value="'+subMainChargeCodeIdForSub+'"';
		investigationData += '	id="subChargecodeIdForSub'+count+'" />';
		
			
		investigationData += '<input type="hidden" name="mainChargecodeIdValForSub" value="'+mainChargeCodeIdForSub+'"';
		investigationData += '	id="mainChargecodeIdValForSub'+count+'" />';
		
		investigationData += '<input type="hidden"  name="dgResultDtIdValueSubInves" value="'+resultEntryDtidForSub+'" id="dgOrderDtIdValueSubInves'+count+'"/>';
		investigationData += '<input type="hidden"  name="dgResultHdIdSubInves" value="'+resultEntryHdidForSub+'" id="dgOrderHdIdSubInves'+count+'"/>';
	
		
		
		investigationData += '<div id="investigationDivMe" class="autocomplete-itemsNew"></div>';
		investigationData += '</div></td>';

		investigationData += '	<td>';
		investigationData += '	<input type="text" name="UOMSub" id="UOMSub'+count+'" value="'+uOMName+'" class="form-control" redonly  >';
		investigationData += '	</td>';
		
		
		 
		if(mainChargeCodeName=='Lab'){
				
				investigationData += '	<td>';
					//investigationData += '	<input type="text" name="resultSubInv"  id="resultSubInv'+count+'" value="'+resultForSub+'" class="form-control" >';
				 
				investigationData+='<input type="text" name="resultInvsTemp" id="resultInvsTemp'+dgSubMasInvestigationId+'" value="'+escapeHtml(resultForSub)+'"class="form-control" onBlur="setLabResultInFieldDigi(this);">';
				investigationData += '	<input type="hidden" name="resultSubInv"  id="resultSubInv'+dgSubMasInvestigationId+'" value="@@@###'+escapeHtml(resultForSub)+'" class="form-control" >';
		
				investigationData += '	</td>';

			}	
			
			if(mainChargeCodeName=='Radio'){
				investigationData += '	<td>';
				investigationData+='<textarea name="resultSubInvs" id="resultSubInvs'+dgSubMasInvestigationId+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###'+escapeHtml(resultForSub)+'</textarea>';
				investigationData+='<a class="btn-link" href="javascript:void(0)"   onclick="openResultModel(this);">View/Enter Result</a>';
				investigationData += '	</td>';
			}

		
		
		investigationData += '<td><input type="text" name="rangeSubInves" value="'+rangeValSub+'"'+disablePre+'';
		investigationData += 'id="rangeSubInves'+count+'" class="form-control">';
		investigationData += '</td>';
		 

			/*investigationData += '	<td>';
			investigationData += '	<textarea class="form-control"  name="investigationRemarksForSub" id="investigationRemarksForSub'+count+'" rows="2" maxlength="500">'+investigationRemarksForSub+'</textarea>';
			investigationData += '	 </td>';
		*/
		
		
		investigationData += '	<td></td>';
		 
		var ridcIdVal=0;
		investigationData += '<td><button name="Button" type="button"   class="hideElement"   id="addInvestigation"  value="" '+disableFlag+''+disablePre+' onclick="addRowForInvestigationFunUpMe();" ';
		investigationData += '	tabindex="1" > </button></td>';

		investigationData += '<td><button type="button" name="delete" value=""    id="deleteInves"  '+deleteButtonFlag+''+disablePre+'';
		investigationData += ' class="hideElement"';
		investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,\''
				+ ridcIdVal + '\');" ></button></td>';
		investigationData += ' </tr> ';
		count+=1;
	 return investigationData;
}




var count = 1;
function patientTreatementDetailForPres() {
	var tractStatus=$('#tractStatus').val();
	var disablePre="";
	if(tractStatus!="" && tractStatus=='y'){
		disablePre="readonly";
	}
	else{
		disablePre="";
	}
	
	var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";
	var urlgetTreatmentPatientDetail = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/getTreatmentPatientDetail?patientId=";
	
	var visitId = $('#visitId').val();
	var opdPatientDetailId =  "0";
	var data = {
		"visitId" : visitId,
		"opdPatientDetailId":"0",
	};
	$.ajax({

				type : "POST",
				contentType : "application/json",
				url : urlgetTreatmentPatientDetail,

				data : JSON.stringify(data),
				dataType : "json",
				// cache: false,
				success : function(res) {

					data = res.listObject;
					 var itemTypeIdPvms=res.itemTypeIdPvms;
					var frequencyList = res.MasFrequencyList;
					var treatementData = '';

					var pvmsTreatementData="";
					var nivTreatementData="";
					var countForPvms=0;
					var countForNiv=0;
					var stopedByUser="";
					var itemStopStatus="";
					
					treatementData += '<div class="autocomplete forTableResp">';
					nivTreatementData += '<div class="autocomplete forTableResp">';
					var countNo = 1;
					var ridcId="";
					if (data == null || data.length == 0) {
						return false;
					}
					investigationGridValue = "nomenclatureGrid";
					var disableFlagVal=""
						var disableForDeletButton="";
					for (var i = 0; i < data.length; i++) {
						
						ridcId=data[i].ridcId;
						var orderStustus=data[i].status;
						itemStopStatus=data[i].itemStopStatus;
						
							if(orderStustus!="" && orderStustus=='C'||orderStustus=='c' || itemStopStatus==1){
								disableFlagVal="readonly";
								disableForDeletButton="disabled";
							}
							else{
								disableFlagVal="readonly";
								disableForDeletButton="disabled";
							}
						
						
						if(data[i].itemTypeId==itemTypeIdPvms){
						
							stopedByUser=data[i].itemStopByUserName;
							
							
							
								func1='populatePVMSTreatment';
							   url1='opd';
							   url2='getMasStoreItemList';
							   flaga='numenclature';
							
						treatementData += '<tr>';
						treatementData += '<td>';
						treatementData += '<div class="autocomplete forTableResp">';
						treatementData += '<input type="text" autocomplete="never" tabindex="1" size="77" value="'
								+ data[i].nomenclature
								+ '['
								+ data[i].PVMSno
								+ ']" ';
						treatementData += 'id="nomenclature' + countForPvms
								+ '"  name="nomenclature1"';
						treatementData += 'class="form-control border-input"';
						treatementData += '  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" '+disablePre+'/>';
						treatementData += '<input type="hidden"  name="itemId" value="'
								+ data[i].itemId
								+ '" id="nomenclatureId'
								+ data[i].itemId + '"/>';
						treatementData += '<input type="hidden"  name="prescriptionHdId" value="'
								+ data[i].precryptionHdId
								+ '" id="prescriptionHdId'
								+ countNo + '"/>';
						treatementData += '<input type="hidden"  name="prescriptionDtId" value="'
								+ data[i].precriptionDtId
								+ '" id="precriptionDtId'
								+ countNo + '"/>';
						treatementData += '	<input type="hidden" name="statusOfPvsms" id="statusOfPvsms'+countForPvms+'" value="'+data[i].status+'"/>';
						treatementData += '<div id="nomenclatureIdPvs'+countForPvms+'" class="autocomplete-itemsNew"></div>';
						treatementData += '</div>';
						
						treatementData += '</td>';

						treatementData += '<td><input type="text" value="'
								+ data[i].dispStock
								+ '" name="dispensingUnit1" ';
						treatementData += ' id="dispensingUnit1" size="6"';
						treatementData += 'validate="AU,string,no"   class="form-control" '+disableFlagVal+' '+disablePre+'/>';
						treatementData += '</td>';
						var doasageVal="";
						if(data[i].dosage!=null && data[i].dosage!=undefined && data[i].dosage!="")
						  doasageVal=data[i].dosage;	
						treatementData += '<td><input type="text" class="form-control" size="5" name="dosage1" tabindex="1" value='+doasageVal+'';
						treatementData +=  ' id="dosage1'+i+'"  maxlength="5" '+disableFlagVal+'/>';
						treatementData += '</td>';

						treatementData += '<td ><select name="frequencyTre" class="form-control" id="frequencyTre'
								+ i + '"';
						treatementData += 'class="medium" '+disableFlagVal+'>';

						var frequencyIdValue = data[i].frequencyId;
						treatementData += '<option value=""><strong>Select</strong></option>';

						var selectFre = "";
						$.each(frequencyList, function(ij, item) {

							if (frequencyIdValue == item.frequencyId) {
								selectFre = "selected";
							} else {
								selectFre = "";
							}
							treatementData += '<option ' + selectFre
									+ ' value="' + item.frequencyId + '">'
									+ item.frequencyName + '</option>';
						});
						treatementData += '</select>';
						treatementData += '</td>';
                        if(data[i].noOfDays!=undefined && data[i].noOfDays!="")
                        {	
						treatementData += '	<td><input type="text" class="form-control" value="'
								+ data[i].noOfDays
								+ '" name="noOfDays1" tabindex="1"';
						treatementData += '	id="noOfDays1'+i+'" onblur="fillValueNomenclature('
								+ count + ')" size="5"';
						treatementData += '	maxlength="3" validate="No of Days,num,no"  '+disableFlagVal+'/></td>';
                        }
                        else
                        {
                        treatementData += '	<td><input type="text" class="form-control" value="" name="noOfDays1" tabindex="1"';
						treatementData += '	id="noOfDays1'+i+'" onblur="fillValueNomenclature('
								+ count + ')" size="5"';
						treatementData += '	maxlength="3" validate="No of Days,num,no" '+disableFlagVal+'/></td>';	
                        }	
                        var tatalVal="";
                        if(data[i].total!="" && data[i].total!=undefined && data[i].total!=null){
                        	tatalVal=data[i].total;
                        }
						treatementData += '<td><input type="text" class="form-control" value="'
								+ tatalVal + '" name="total1" tabindex="1"';
						treatementData += 'id="total1'+i+'" size="5" validate="total,num,no"';
						treatementData += 'onblur="treatmentTotalAlert(this.value,1)" '+disableFlagVal+'/></td>';

						treatementData += '<td><input type="text" class="form-control" tabindex="1" value="'
								+ data[i].instruction + '" name="remarks1" ';
						treatementData += 'id="remarks1'+i+'" size="10" maxlength="15" '+disableFlagVal+'/>';
						treatementData += '</td>';

						/*treatementData += '	<td><input type="text" class="form-control" name="closingStock1" tabindex="1"  value="'
								+ data[i].storeStoke + '"';
						treatementData += 'id="closingStock1" size="3"';
						treatementData += 'validate="closingStock,string,no" '+disableFlagVal+'/></td>';
*/
						 /*var insFlagCheck="";
						 var immunizationflagCheck="";
						if(data[i].nisFlag!="" && data[i].nisFlag!=null && data[i].nisFlag=='y'){
							insFlagCheck="checked=checked";
						}
						else{
							insFlagCheck="";
						}
						if(data[i].immunizationFlag!="" && data[i].immunizationFlag!=null && data[i].immunizationFlag=='y'){
							immunizationflagCheck="checked=checked";
						}
						else{
							immunizationflagCheck="";
						}*/
						
						/*treatementData +='<td><div class="form-check form-check-inline cusCheck"><input type="checkbox" class="form-check-input" '+insFlagCheck+' name="nis" id="nisCheck'+countNo+'" tabindex="1" class="radioAuto" value="1" '+disableFlagVal+'/><span class="cus-checkbtn"></span></div></td>';
						
						treatementData +='<td><div class="form-check form-check-inline cusCheck"><input type="checkbox" class="form-check-input"  '+immunizationflagCheck+' name="immunization" id="immCheck'+countNo+'" tabindex="1" class="radioAuto" value="1" '+disableFlagVal+'/><span class="cus-checkbtn"></span></div></td>';
						
					*/	
						treatementData += '<td style="display:none"><input  type="hidden" value="" tabindex="1"';
						treatementData += '	id="itemIdNom" size="77" name="itemIdNom" /></td>';

						
						if(itemStopStatus!=""&& itemStopStatus!=null && itemStopStatus!=undefined && itemStopStatus==1){
							treatementData += "<td style='width: 150px;'>"
								+ stopedByUser+ "</td>";
							treatementData += "<td></td>"
						}
						else{
						treatementData += '<td><button name="Button" type="button"';
						treatementData += '	class="buttonAdd btn btn-primary noMinWidth" value="" button-type="add" onclick="addNomenclatureRowRecall();"';
						treatementData += '	tabindex="1" '+disableForDeletButton+'> </button></td>';

						treatementData += '<td><button type="button" name="delete" id="treatementId" button-type="delete" value=""';
						treatementData += 'class="buttonDel btn btn-danger noMinWidth"';
						treatementData += '	onclick="removeRowInvestigation(this,\''
								+ investigationGridValue
								+ '\','
								+ data[i].precriptionDtId + ');"';
						treatementData += '	tabindex="1" '+disableForDeletButton+'></button></td>';
						}
						treatementData += '<td style="display: none;"><input type="hidden" name="pvmsNo1" tabindex="1"';
						treatementData += '	id="pvmsNo1" size="10" readonly="readonly" />';
						treatementData += '</td>';
						
						treatementData += '</tr>';
						countForPvms+=1;
						
						}
						else{
							
							func1='populatePVMSforNipRecall';
							   url1='opd';
							   url2='getMasStoreItemNip';
							   flaga='newNib';
							
							nivTreatementData += '<tr>';
							nivTreatementData += '<td>';
							nivTreatementData += '<div class="autocomplete forTableResp">';
							nivTreatementData += '<input type="text" autocomplete="never" tabindex="1" size="77" value="'
									+ data[i].nomenclature
									+ '['
									+ data[i].PVMSno
									+ ']" ';
							nivTreatementData += 'id="oldnip1' + countForNiv
									+ '"  name="oldnip1"';
							nivTreatementData += 'class="form-control border-input width330"';
							//nivTreatementData += '  onKeyPress="autoCompleteCommon(this,4);" onblur="populatePVMSforNipRecall(this.value,'+count+',this);" />';
							
							nivTreatementData += '   onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"  '+disablePre+'/>';
							
							nivTreatementData += '<input type="hidden"  name="nivItemsVal" value="'
									+ data[i].itemId
									+ '" id="nivItemsVal'
									+ data[i].itemId + '"/>';
							nivTreatementData += '<input type="hidden"  name="prescriptionNivHdId" value="'
									+ data[i].precryptionHdId
									+ '" id="prescriptionNivHdId'
									+ countNo + '"/>';
							nivTreatementData += '<input type="hidden"  name="prescriptionNivDtId" value="'
									+ data[i].precriptionDtId
									+ '" id="prescriptionNivDtId'
									+ countNo + '"/>';
							nivTreatementData += '<input type="hidden" name="statusOfNiv" id="statusOfNiv'+countForNiv+'" value="'+data[i].status+'"/>';
							nivTreatementData += '<div id="newNibForPVMS'+countForNiv+'" class="autocomplete-itemsNew"></div>';
							nivTreatementData += '</div>';
							nivTreatementData += '</td>';

							nivTreatementData += '<td><input type="text" value="" name="newNip1" ';
							nivTreatementData += ' id="newNip1'+countForNiv+'" onBlur="diasableNIV(this);"  size="77" ';
							nivTreatementData += 'validate="AU,string,no"   class="form-control border-input width200" readonly/>';
							nivTreatementData += '<input type="hidden" name="statusOfNewNiv" id="statusOfNewNiv" value="'+data[i].status+'"/>';
							nivTreatementData += '</td>';

							 
							
							nivTreatementData += '<td><select name="class1" class="form-control width100" id="class1'
								+ countNo + '"';
							nivTreatementData += 'class="medium" '+disableFlagVal+'>';

						var itemClassId = data[i].itemClassId;
						nivTreatementData += '<option value=""><strong>Select</strong></option>';

						var selectItemClass = "";
						$.each(masItemClassList, function(iji, item1) {

							if (itemClassId == item1.itemClassId) {
								selectItemClass = "selected";
							} else {
								selectItemClass = "";
							}
							nivTreatementData += '<option ' + selectItemClass
									+ ' value="' + item1.itemClassId + '">'
									+ item1.itemClassName + '</option>';
						});
						
						
						nivTreatementData += '</select>';
						nivTreatementData += '</td>';
					 	
						
						nivTreatementData += '<td><select name="au1" readonly="readonly"  class="form-control width80" id="au1'
							+ countNo + '"';
						nivTreatementData += 'class="medium" '+disableFlagVal+'>';

					var dispUnitId = data[i].dispUnitId;
					nivTreatementData += '<option value=""><strong>Select</strong></option>';

					var selectItemClass = "";
					$.each(masDispUnitList, function(ijk, item) {

						if (dispUnitId == item.storeUnitId) {
							selectItemClass = "selected";
						} else {
							selectItemClass = "";
						}
						nivTreatementData += '<option ' + selectItemClass
								+ ' value="' + item.storeUnitId + '">'
								+ item.storeUnitName + '</option>';
					});
						nivTreatementData += '</select>';
						nivTreatementData += '</td>';
						nivTreatementData += '<td style="display:none;"><input type="text" name="dispensingUnitNip1" tabindex="1"';
						nivTreatementData += 'value='+data[i].dispStock+' id="dispensingUnitNip1'+countNo+'"  size="5" maxlength="3" onkeypress="if(isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  class="form-control width50" '+disableFlagVal+'/></td>';

							nivTreatementData += '<td><input type="text" name="dosageNip1" tabindex="1"';
							nivTreatementData += 'value='+data[i].dosage+' id="dosageNip1'+countNo+'" onblur="fillValueNip()" size="5" maxlength="3" onkeypress="if(isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  class="form-control width50" '+disableFlagVal+'/></td>';

						 	
							nivTreatementData += '<td><select name="nipfrequency1" class="form-control width80" onchange="fillValueNip()" id="nipfrequency1'
								+ countNo + '"';
							nivTreatementData += 'class="medium" '+disableFlagVal+'>';

						var frequencyIdValue = data[i].frequencyId;
						nivTreatementData += '<option value=""><strong>Select</strong></option>';

						var selectFre = "";
						$.each(frequencyList, function(ij, item) {

							if (frequencyIdValue == item.frequencyId) {
								selectFre = "selected";
							} else {
								selectFre = "";
							}
							nivTreatementData += '<option ' + selectFre
									+ ' value="' + item.frequencyId + '">'
									+ item.frequencyName + '</option>';
						});
							nivTreatementData += '</select>';
							nivTreatementData += '</td>';
							
							nivTreatementData += '<td><input type="text" name="noOfDaysNip1" tabindex="1"';
							nivTreatementData += '	id="noOfDaysNip1" onblur="fillValueNip()" value='+data[i].noOfDays+'';
							nivTreatementData += '	size="5" maxlength="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"   class="form-control width50" '+disableFlagVal+'/></td>';

							nivTreatementData += '<td><input type="text" name="totalNip1" tabindex="1" value='+data[i].total+'';
							nivTreatementData += '		id="totalNip1" size="5" validate="total,num,no"';
							nivTreatementData += '		onblur="treatmentTotalAlert(this.value,1)"  class="form-control width50"  '+disableFlagVal+'/></td>';
							var instructionVal="";
							if(data[i].instruction!=null && data[i].instruction!=""){
								instructionVal=data[i].instruction;
							}
							else{
								instructionVal="";
							}
							nivTreatementData += '<td><input type="text" name="remarksNip1"   tabindex="1" ';
							nivTreatementData += '	id="remarksNip1'+countNo+'" size="10" value="'+instructionVal+'"  maxlength="10" class="form-control width100"  '+disableFlagVal+'/>';
							nivTreatementData += '	</td>';

							nivTreatementData += ' <td style="display: none;"><input type="hidden" name="itemIdNomNip"';
							nivTreatementData += ' value="'+data[i].itemId+'" tabindex="1" id="itemIdNomNip" size="77" '+disableFlagVal+''+disablePre+'';
							nivTreatementData += '/></td>';
							
							nivTreatementData += '	<td>';
							nivTreatementData += ' 	<button type="button" class="btn btn-primary buttonAdd noMinWidth"';
							nivTreatementData += ' name="button" button-type="add" value=""';
							nivTreatementData += ' onclick="return addNipRowRecall();" tabindex="1" '+disableForDeletButton+'></button>';
							nivTreatementData += ' 	</td>';
							
							nivTreatementData += '<td>';
							nivTreatementData += '<button type="button" class="buttonDel  btn btn-danger noMinWidth"';
							nivTreatementData += 'name="button" id="deleteNomenclature" button-type="delete" value=""';
							nivTreatementData += 'onclick="return removeRowNip(this);"';
							nivTreatementData += 'tabindex="1" '+disableForDeletButton+'></button>';
							nivTreatementData += '</td>';
							
							nivTreatementData += ' <td style="display: none;"><input type="hidden"';
							nivTreatementData += ' 	name="nippvmsNo1" tabindex="1" id="nippvmsNo1" size="10"';
							nivTreatementData += ' 	readonly="readonly" /></td>';

							nivTreatementData += '</tr>';
							countForNiv+=1;
						}
						countNo++;
					}
					treatementData += '</div">';
					nivTreatementData+= '</div">';
		     		if(countForPvms>0){
		     			$('#investgationDetail').hide();
						$('#precriptionAndNiv').show();
		     			$("#nomenclatureGrid").html(treatementData);
		     		}
					if(countForNiv>0){
						$('#investgationDetail').hide();
						$('#precriptionAndNiv').show();
						$("#nipGrid").html(nivTreatementData);
					}
					if(ridcId!="" && ridcId!=null){
						$('#uploadFilePresAndInvesDetail').show();
						$('#uploadFilePresAndInves').hide();
			        	$('#viewUploadedFile').show();
			        	var viewUploadedFile="";
			        	viewUploadedFile += '<a class="btn-link" href="#" onclick="viewDocumentForDigi('+ridcId+');" >View Document</a>'
			    		$('#viewUploadedFile').html(viewUploadedFile);	
			        	
			        }
					else{
						$('#uploadFilePresAndInvesDetail').hide();
					}
				}
			});

	return false;
}

function approvedInvesAndPres(flagForStatus){
	var count=0;
	$('#flagForStatus').val(flagForStatus);
	if(flagForStatus!='rejectWithNoAction'){
	 var actionDigiForApprovedPre=$("#actionDigiFileApprovedPres").val();
	 if(actionDigiForApprovedPre=="" || actionDigiForApprovedPre=="0"){
		 count++;
		 alert("Please select action");
	 }
	  
	 
	 else if(actionDigiForApprovedPre=='reject'){
		 var remarksFroReject="";
		 remarksFroReject =$("#remarksForReject").val();
		 if(remarksFroReject==""){
			 alert("Please enter remarks.");
			 count++;
			 return false
		 }
		
	 }
	 else{
		 count=0; 
	 }
	 $('#flagForStatus').val(actionDigiForApprovedPre);
	}
	 if(count==0){
	 $("#approvalForPresAndInves").prop("disabled",true);
	 $("#approvalForPresAndInvesReject").prop("disabled",true);
	 var formData1 = $('#appravalInvesAndPresId')[0];
	 var formData = new FormData(formData1);
	var pathname = window.location.pathname;
 	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/registration/approvedInvesAndPres";
	$.ajax({
		url : url,
		data : formData,
		processData: false,
        contentType: false,
		async : true,
		type : 'POST',
		dataType : "json",
		timeout: 100000,
		success : function(response) {
			var dataVal=response.message;
			if(dataVal!="" && dataVal!=undefined){
			var responseData=dataVal.split("##");
			if(responseData[0]=='1'){
				try{
					$("#approvalForPresAndInves").attr("disabled","disabled");	
				}
				catch(e){}
				alert(responseData[1]+'S');	
				document.getElementById("closeBtn").addEventListener("click", function(){
					flagForStatus=$('#flagForStatus').val();
					if(flagForStatus=='rejectWithNoAction'){
						window.location.href =window.location.protocol + "//"
						+ window.location.host + "/" + accessGroup
						 + "/registration/rejectPrecriptAndInves";
					}
					else{
						window.location.href =window.location.protocol + "//"
						+ window.location.host + "/" + accessGroup
						 + "/registration/approvalPrecriptAndInves";	
					}
				});
				
				return true;
			}
			if(responseData[0]=='0'){
				alert(responseData[1]);
				$("#approvalForPresAndInves").removeAttr("disabled");
				return true;
			}
			}
			return true;
		},
		error : function(err) {
		}
	});
}
 	return true; 	
}
var dataMeMb="";
function getPatientDetailsData(){
	//alert("coming 2002"+vissIdd);
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";

	var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/digifileupload/getMbMePatientDetail";
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : url,
		data : JSON.stringify({
			'visitId' : vissIdd,
			'userId' : uId,
			'hospitalId' : hId,
			'newEntryStatus':'newEntryStatus'
		}),
		dataType : 'json',
		timeout : 100000,
		success : function(res)
		{
			dataMeMb=res.data;
			 listMasServiceType =res.listMasServiceType;	
		
           },
           error: function (jqXHR, exception) {
               var msg = '';
               if (jqXHR.status == 0) {
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
}

function putDataOnPursing(ids){
	var approvingData=$(ids).val();
	$('#persuingName').val(approvingData);
}
function putDataOnRank(ids){
	var persuingRank=$(ids).val();
	$('#persuingRank').val(persuingRank);
}
function putDataOnPlace(ids){
	var persuingPlace=$(ids).val();
	$('#persuingPlace').val(persuingPlace);
}
function putDataOnDate(ids){
	var persuingDate=$(ids).val();
	$('#persuingDate').val(persuingDate);
}


function isNumberKey(txt, evt) {
		
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    if (charCode == 46) {
	        //Check if the text already contains the . character
	        if (txt.value.indexOf('.') === -1) {
	            return true;
	        } else {
	            return false;
	        }
	    } else {
	        if (charCode > 31
	             && (charCode < 48 || charCode > 57))
	            return false;
	    }
	    return true;
	}

function isNumberKey1(txt, evt) {
	
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode == 46) {
        //Check if the text already contains the . character
        if (txt.value.indexOf('.') === -1) {
            return false;
        } else {
            return false;
        }
    } else {
        if (charCode > 31
             && (charCode < 48 || charCode > 57))
            return false;
    }
    return true;
}

function checkDateValidate(obj){
	var dateVal=obj.value;
	var ids="";
	ids=obj.id;
	if(dateVal!="" && dateVal!=null && dateVal!=undefined){
		var dateArray=dateVal.split("/");
		if(dateArray.length!=3){
			alert("Please enter valid Date format(DD/MM/YYYY)!");
			
			try{$("#"+ids).val("");}
			catch(e){}
			$("#"+ids).val("");
			return false;
		}
		if(dateArray.length==3){
			if(dateArray[2].trim().length!=4){
				alert("Please enter valid year!(YYYY)");
				try{$("#"+ids).val("");}
				catch(e){}
				return false;
				
			}
			else{
				return true;
			}
		}
		else{
			return false;
		}
	}
	return true;
}


var total_hospital_value = '';
var autoHospitalData='';
  function fillHospitalAutocomplete(val,item) {
        var index1 = val.lastIndexOf("[");
        var index2 = val.lastIndexOf("]");
        var mHospitalValue='';
        index1++;
        idMcNo = val.substring(index1, index2);
       
        var divIdGen=$(item).siblings("div.autocomplete-itemsNew").attr("id");
       
        if (idMcNo == "") {
            return;
        } else {
            obj = document.getElementById('hospitalAutoComplete');
            total_hospital_value += val+",";
           
            obj.length = document.getElementById('hospitalAutoComplete').length;
            var b = "false";
            for(var i=0;i<autoHospitalData.length;i++){
         		  
         		  var mcDataVal = autoHospitalData[i];
         		 
         		  if(mcDataVal[0] == idMcNo){
         			mHospitalValue = mcDataVal[0];
         			//document.getElementById('hospitalAutoCompleteValue').value = mHospitalValue;
         			
         		     $('#'+divIdGen).siblings('input[type="hidden"]').val(mHospitalValue);
         			//$('#'+divIdGen).val(mHospitalValue);
         			b=true;
         		  }
         	  }
            if (b == "false") {
            	
                //$('#hospitalAutoComplete').append('<option value=' + mHospitalValue + '>' + val + '</option>');
                document.getElementById('hospitalAutoComplete').value = "";
             
            }
        } 
    }
  
  var total_rank_value = '';
	 var autoRankData='';
	   function fillRankAutocomplete(val,item) {
	         var index1 = val.lastIndexOf("[");
	         var index2 = val.lastIndexOf("]");
	         var mRankValue='';
	         index1++;
	         idMcNo = val.substring(index1, index2);
	         var divIdGen=$(item).siblings("div.autocomplete-itemsNew").attr("id");
	         if (idMcNo == "") {
	             return;
	         } else {
	             obj = document.getElementById('rankAutoComplete');
	             total_rank_value += val+",";
	            
	             obj.length = document.getElementById('rankAutoComplete').length;
	             var b = "false";
	             for(var i=0;i<autoRankData.length;i++){
	          		  
	          		  var mcDataVal = autoRankData[i];
	          		 
	          		  if(mcDataVal[0] == idMcNo){
	          			mRankValue = mcDataVal[0];
	          			
	         		     $('#'+divIdGen).siblings('input[type="hidden"]').val(mRankValue);
	          			//document.getElementById('rankAutoCompleteValue').value = mRankValue;
	          			b=true;
	          		  }
	          	  }
	             if (b == "false") {
	             	
	                 //$('#hospitalAutoComplete').append('<option value=' + mHospitalValue + '>' + val + '</option>');
	                 document.getElementById('hospitalAutoComplete').value = "";
	             }
	         } 
	     }
	   
	   var total_unit_value = '';
		 var autoUnitData='';
		   function fillUnitAutocomplete(val,item) {
		         var index1 = val.lastIndexOf("[");
		         var index2 = val.lastIndexOf("]");
		         var mUnitValue='';
		         index1++;
		         idMcNo = val.substring(index1, index2);
		         var divIdGen=$(item).siblings("div.autocomplete-itemsNew").attr("id");
		         if (idMcNo == "") {
		             return;
		         } else {
		             obj = document.getElementById('unitAutoComplete');
		             total_unit_value += val+",";
		            
		             obj.length = document.getElementById('unitAutoComplete').length;
		             var b = "false";
		             for(var i=0;i<autoUnitData.length;i++){
		          		  
		          		  var mcDataVal = autoUnitData[i];
		          		 
		          		  if(mcDataVal[0] == idMcNo){
		          			mUnitValue = mcDataVal[0];
		          			//document.getElementById('unitAutoCompleteValue').value = mUnitValue;
		          			
		         		     $('#'+divIdGen).siblings('input[type="hidden"]').val(mUnitValue);
		          			b=true;
		          		  }
		          	  }
		             if (b == "false") {
		             	
		                 //$('#hospitalAutoComplete').append('<option value=' + mHospitalValue + '>' + val + '</option>');
		                 document.getElementById('unitAutoCompleteValue').value = "";
		             }
		         } 
		     }
		   
		   var total_branch_value = '';
			 var autoBranchData='';
			   function fillBranchAutocomplete(val,item) {
			         var index1 = val.lastIndexOf("[");
			         var index2 = val.lastIndexOf("]");
			         var mBranchValue='';
			         index1++;
			         idMcNo = val.substring(index1, index2);
			         var divIdGen=$(item).siblings("div.autocomplete-itemsNew").attr("id");
			         if (idMcNo == "") {
			             return;
			         } else {
			             obj = document.getElementById('branchTradeAutoComplete');
			             total_branch_value += val+",";
			            
			             obj.length = document.getElementById('branchTradeAutoComplete').length;
			             var b = "false";
			             for(var i=0;i<autoBranchData.length;i++){
			          		  
			          		  var mcDataVal = autoBranchData[i];
			          		 
			          		  if(mcDataVal[0] == idMcNo){
			          			mBranchValue = mcDataVal[0];
			          			//document.getElementById('branchAutoCompleteValue').value = mBranchValue;
			          			
			         		     $('#'+divIdGen).siblings('input[type="hidden"]').val(mBranchValue);
			          			b=true;
			          		  }
			          	  }
			             if (b == "false") {
			             	
			                 //$('#hospitalAutoComplete').append('<option value=' + mHospitalValue + '>' + val + '</option>');
			                 document.getElementById('branchAutoCompleteValue').value = "";
			             }
			         } 
   }


			   function validateFileExtension(component,msg_id,msg,extns)
				{
				   var flag=0;
				   with(component)
				   {
				      var ext=component.substring(component.lastIndexOf('.')+1);
				      for(i=0;i<extns.length;i++)
				      {
				         if(ext==extns[i])
				         {
				            flag=0;
				            break;
				         }
				         else
				         {
				            flag=1;
				         }
				      }
				      if(flag!=0)
				      {
				         alert(msg);
				         component.value="";
				         component.style.backgroundColor="#eab1b1";
				         component.style.border="thin solid #000000";
				         component.focus();
				         return false;
				      }
				      else
				      {
				         return true;
				      }
				   }
				}		   
			   