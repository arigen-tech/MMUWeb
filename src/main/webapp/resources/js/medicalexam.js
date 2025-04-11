/**
 * 
 */
var func1='';
var url1='';
var url2='';
var flaga='';
function getPatientDetailToValidate() {
	
	var visitId = $('#visitId').val();
	var age = $('#ageForPatient').val();
	var meAge = $('#meAge').val();
	var data = {
		"visitId" : visitId,
		"flagForForm" :"f1",
		"age":age,
		"meAge":meAge
	};
	$.ajax({

		type : "POST",
		contentType : "application/json",
		url : 'getPatientDetailToValidate',
		data : JSON.stringify(data),
		dataType : "json",
		// cache: false,

		success : function(res) {
			
			 data = res.listVisit;
			 var masDesigationList=res.listDgMasInvestigation
			if (data != undefined && data != null) {
				$('#serviceNo').val(data[0].serviceNo);
				$('#patientName').val(data[0].patientName);
				$('#age').val(data[0].meAgeNew);

				$('#rank').val(data[0].rankName);
				$('#meType').val(data[0].meTypeName);
				$('#gender').val(data[0].gender);
				$('#genderId').val(data[0].genderId);
				$('#patientId').val(data[0].patientId);
				$('#departmentId').val(data[0].departmentId);
				$('#opdPatientDetailId').val(data[0].opdPatientDetailId);
				$('#medCategory').val(data[0].medicalCategory);
				$('#doeORDoc').val(data[0].serviceJoinDate);
				
				$('#medicalCompositeName').val(data[0].medicalCategory);
				
				$('#medicalCategoryMo').val(data[0].medicalCategory);
				$('#medicalCompositeDate').val(data[0].medicalCategoryDate);
				
			
				$('#height').val(data[0].pcHeight);
				$('#weight').val(data[0].pcWeight);
				$('#idealWeight').val(data[0].pcIdealWeight);
				$('#overWeight').val(data[0].pcOverWeight);
				$('#waist').val(data[0].waist);
				$('#chestFullExpansion').val(data[0].pcChestFullExpansion);
				if(data[0].pcRangeOfExpansion!=null && data[0].pcRangeOfExpansion!="" && data[0].pcRangeOfExpansion!=undefined)
					$('#rangeOfExpansion').val(data[0].pcRangeOfExpansion);
				
				if(data[0].divenFlag!=null && data[0].divenFlag!=""){
					$("#markAsDiver").prop("checked", true);
					getMarkAsDiver(this);
				}
			 
			
			}
			
			 var countins = 1;
			 var countSno=1;
			 var otherInvergation="";
				if (masDesigationList != null && masDesigationList.length > 0) {
					otherInvergation=masDesigationList[0].otherInvestigation;
					var investigationData="";
					var diasableValue="disabled";
					 var approvalFlag=$('#approvalFlag').val();
					 var approvalFlagDiasable="";
					 if(approvalFlag!="" && approvalFlag!=undefined && approvalFlag!=null && approvalFlag=='y'){
						 approvalFlagDiasable='disabled';
					 }
					 else{
						 approvalFlagDiasable="";
					 }
					 
					 func1='populateChargeCode';
		    		   url1='medicalexam';
		    		   url2='getInvestigationListUOM';
		    		   flaga='investigationMe';
		    		   var investigationGridValidate="investigationGrid";
		    		   var deleteId="";
					for (var i = 0; i < masDesigationList.length; i++) {
						var dgOrderDtIdTemp="";
						
						investigationData += '<tr>';
						investigationData +='<td style="width: 150px;display:none;">'+countSno+'</td>';
						investigationData += '<td><div class="form-group autocomplete forTableResp">';
						investigationData += '<input type="text" readonly autocomplete="never" value="'+masDesigationList[i].investigationName + '[' + masDesigationList[i].investigationId + ']"';
					//	investigationData += ' class="form-control border-input" name="investigationName" id="investigationName'+countSno+'"  onKeyPrss="autoCompleteCommonMe(this,1);"  onKeyUp="autoCompleteCommonMe(this,1);"  onKeyDown="autoCompleteCommonMe(this,1);"    onblur="populateChargeCode(this.value,1,this);" />';
						
						investigationData += ' class="form-control border-input" name="investigationName" id="investigationName'+countSno+'"  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
						investigationData += '<input type="hidden"  name="investigationIdValue" value="'
								+ masDesigationList[i].investigationId +'"  id="investigationIdValue' + masDesigationList[i].investigationId + '"/>';
						
						investigationData += '<input type="hidden"  name="examTypeId" value="'
							+ masDesigationList[i].examTypeId +'"  id="examTypeId' + masDesigationList[i].examTypeId + '"/>';
				
						investigationData += '<input type="hidden"  name="appointmentId" value="'
							+ masDesigationList[i].appointmentId +'"  id="appointmentId' + masDesigationList[i].appointmentId + '"/>';
						investigationData += '<input type="hidden"  name="dgOrderDtIdValue" value="'+masDesigationList[i].dgOrderdt+'" id="dgOrderDtIdValue'
							+ masDesigationList[i].dgOrderdt + '"/>';
						investigationData += '<input type="hidden"  name="dgOrderHdId" value="'+ masDesigationList[i].dgOrderHdId+'" id="dgOrderHdId'
							+ masDesigationList[i].dgOrderHdId + '"/>';
						investigationData += '<div id="investigationDivMe" class="autocomplete-itemsNew"></div>';
						investigationData += '</div></td>';
						if(masDesigationList[i].dgOrderdt!=null  && masDesigationList[i].dgOrderdt!=""){
						dgOrderDtIdTemp=masDesigationList[i].dgOrderdt ;
							deleteId="deleteInves";
						}
						else{
							dgOrderDtIdTemp=0;	
							deleteId="newIdInv";
						}
						var urgentValue = "";
						var chechedValue="checked";
						if (masDesigationList[i].labMark == "O") {
							chechedValue = 'checked';
						} else if(masDesigationList[i].labMark == "I"){
							chechedValue = '';
						}
						else if(masDesigationList[i].labMark == ""){
							chechedValue = 'checked';
						}

						
						investigationData +='<td>';
						investigationData +='<div class="form-check form-check-inline cusCheck m-l-10">';
						investigationData +=' <input '+chechedValue+' class="form-check-input position-static" type="checkbox"  name="checkBoxForValidate" id="checkBoxForValidate'+i+'"> <span class="cus-checkbtn"></span> ';
						investigationData +='</div>';
						investigationData +='</td>';
						
						/*var urgentValue = "";
						if (data[i].urgent == "Y") {
							checked = 'checked';
							urgentValue = "Y";
						} else {
							checked = '';
							urgentValue = "N";
						}*/
						investigationData +='	<td style="display: none"><input type="checkbox"   name="urgent"';
						investigationData +='	id="uCheck'+i+'" tabindex="1" class="radioAuto" value="1" />';
						investigationData +='</td>';
						var investigationMarks="";
						if(masDesigationList[i].investigationRemarks!="" && masDesigationList[i].investigationRemarks!=null){
							investigationMarks=masDesigationList[i].investigationRemarks;
						}
						else{
							investigationMarks="";
						}
						investigationData +='<td>';
						investigationData +='	<textarea class="form-control"  name="investigationRemarks" id="investigationRemarks'+i+'" rows="2" maxlength="500">'+investigationMarks+'</textarea>';
						investigationData +=' </td>';
						
						investigationData += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth" button-type="add" value="" ';
						investigationData += 'onclick="addNewRowForInvestigation();"';
						investigationData += '	tabindex="1" ></button></td>';
 					
						
						
						investigationData +='<td>';
						investigationData +='<button type="button"  name="delete" value="" id='+deleteId+'  class="buttonDel btn btn-danger noMinWidth" button-type="delete" onclick="removeRowInvestigationMe(this,\'' + investigationGridValidate + '\',\''+ dgOrderDtIdTemp + '\');"></button>';
						 
						investigationData +='</td>';
						
						investigationData +='</tr>';
						countSno+=1;
					}}
				$('#otherInvestigation').val(otherInvergation);
				$("#dgInvetigationGrid").html(investigationData);
		}
	});

	return false;
}
var valiCheckValue = [];
var urgentCheckValue = [];
function checkValidate() {
	$('#dgInvetigationGrid tr').each(function(i, el) {

		var id = $(this).find("td:eq(2)").find("input:eq(0)").attr("id");
		var urgentId = $(this).find("td:eq(3)").find("input:eq(0)").attr("id")
		
		if (document.getElementById(id).checked == true) {
			var validateCheck = 'O';
			labMarkValue = validateCheck;
		} else {
			validateCheck = 'I';
			labMarkValue = validateCheck;
		}
		var validateUrgentCheck;
		if (document.getElementById(urgentId).checked == true) {
			var validateUrgentCheck = 'Y';
		} else {
			validateUrgentCheck = 'N';
		}
		
		
		valiCheckValue.push(labMarkValue);
		urgentCheckValue.push(validateUrgentCheck);
	});
	
	$('#valiCheckValue').val(valiCheckValue);
	$('#ugentCheckValue').val(urgentCheckValue);
}

function fileValidate(){
	var checkFileName=0;
	var count=0;
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
	 		return false;
	 	 }
	 	if(count>0){
	 		alert("Please upload valid file.");
	 		return false;
	 	}
	 	else{
	 		return true;
	 	}
}


function submitFormByMO(checkForform) {
	var submitForm='0';
	var countInve=0;
	var countForCheck=0;
	var investigationstatus=$('#saveStatus').val();
	//Diver section working
	if(document.getElementById("markAsDiver").checked == true){
		var counter=0;
		 var countlastDoneOnDate=0;
		 var countdoneOnDate=0;
		 var countduration=0;
		 var countnextDueOnDate=0;
		$('#markDiverInvestigationGrid tr').each(function(i, el) {
			 var checkedboxId=$(this).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
			 var lastDoneOnDate = $(this).find("td:eq(1)").find("input:eq(0)").val(); 
			 var doneOnDate = $(this).find("td:eq(2)").find("input:eq(0)").val();
			 var duration = $(this).find("td:eq(3)").find("select:eq(0)").val();
			 var nextDueOnDate = $(this).find("td:eq(4)").find("input:eq(0)").val();
			 
			 if (document.getElementById(checkedboxId).checked == true) {
				 counter++; 
			
			 if(lastDoneOnDate==null || lastDoneOnDate=="" || lastDoneOnDate==undefined){
				// alert("Please enter Last Done on Date.");
				 //return false;
				 countlastDoneOnDate++;
			 }
			 else{
				 countlastDoneOnDate=0;
			 }
			 if(doneOnDate==null || doneOnDate=="" || doneOnDate==undefined){
					// alert("Please enter Last Done on Date.");
					 //return false;
					 countdoneOnDate++;
				 }
			 else{
				 countdoneOnDate=0;
			 }
			 if(duration==null || duration=="" || duration==undefined){
					// alert("Please enter Last Done on Date.");
					 //return false;
				 countduration++;
				 }
			 else{
				 countduration=0;
			 }
			 
			 if(nextDueOnDate==null || nextDueOnDate=="" || nextDueOnDate==undefined){
					// alert("Please enter Last Done on Date.");
					 //return false;
				 countnextDueOnDate++;
				 }
			 else{
				 countnextDueOnDate=0;
			 }
			 
			 }
			 
			
			 
		});
		
		/*if(counter==0){
			alert("Please check action at list one.");
			return false;
		}*/
		if(countlastDoneOnDate>0){
			alert("Please enter Last Done on Date.");
			 return false;
		}
		
		if(countdoneOnDate>0){
			alert("Please enter   Done on Date.");
			 return false;
		}
		if(countduration>0){
			alert("Please enter   duration.");
			 return false;
		}
		if(countnextDueOnDate>0){
			alert("Please enter  Next Due on Date.");
			 return false;
		}
	}
 
	
	
	$('#dgInvetigationGrid tr').each(function(i, el) {

		var investigationVal = $(this).find("td:eq(1)").find("input:eq(0)").val();
		if(investigationVal==null || investigationVal==''){
			countInve+=1;
		}
		var checkValues = $(this).find("td:eq(2)").find("input:eq(0)").attr("id");
		 
			if (document.getElementById(''+checkValues).checked == true && investigationVal!="" && investigationstatus!="s"){
				countForCheck++;
				}	
	});
	if(countInve>0){
		alert("Please add Investigation.");
		submitForm=1;
		return false;
	}
	
		if(checkForform=='2'){
			checkValidate() ;
		}
		if(checkForform=='1'){
			var countcheckBoxValue=$("#countcheckBoxValue").val();
			if(countcheckBoxValue>=2){
				submitForm=countcheckBoxValue;
				return false;
			}
		}
		
		
		if(submitForm=='0'){
			
			if(countForCheck>0 ){
				$('#messageForInvestigationOutside').show();
				$('.modal-backdrop').show();
			}
			if(countForCheck==0){
				
				$("#submitMedicalExamByMo").submit();
				$("#submitByMo").attr("disabled","disabled");
				
				return true; 
			}
			else{
			return false;
			}
			}
		}


var fitInArray = [];
function checkBoxFitInCatMe() {
	var fitflagVal="";
	if(document.getElementById("fitInChk")!=null){
		if (document.getElementById("fitInChk").checked == true) {
			  fitflagVal = 'Yes';
			var fitInFlagVal = fitflagVal;

		} else {
			  fitflagVal = 'No';
			var fitInFlagVal = fitflagVal;
		}

		fitInArray.push(fitInFlagVal);
		$('#fitFlagCheckValue').val(fitflagVal);
	}
}


function submitMOValidateFormByModel(){
	$("#submitMedicalExamByMo").submit();
	$('#submitMOValidateFormByModelId').attr("disabled","disabled");
	return true; 
}



function removeRowInvestigation(val){
	var serviceDetailId=val.id;
	var count=0;
	try{
		if(serviceDetailId!=null && serviceDetailId.includes('dgInvetigationGrid')){
		 var tbl = document.getElementById('dgInvetigationGrid');
			var lastRow = tbl.rows.length;
			if(lastRow==1){
	  			count++;
	  			return false;
	  		}
		}
		if(serviceDetailId!=null && serviceDetailId.includes('deleteServiceDetail')){
			var tbl = document.getElementById('serviceDetailsIdGrid');
	  		lastRow = tbl.rows.length;
	  		if(lastRow==1){
	  			count++;
	  			return false;
	  		}
		}
		if(serviceDetailId!=null && serviceDetailId.includes('deleteDiseaseWoundInjury')){
			var tbl = document.getElementById('diseaseWoundInjuryDetailsGrid');
	  		lastRow = tbl.rows.length;
	  		if(lastRow==1){
	  			count++;
	  			return false;
	  		}
		}
		
		if(serviceDetailId!=null && serviceDetailId.includes('ArmedForces')){
			var tbl = document.getElementById('diseaseWoundInjuryArmedForces');
	  		lastRow = tbl.rows.length;
	  		if(lastRow==1){
	  			count++;
	  			return false;
	  		}
		}
		}catch(e){
			
		}
		if(count==0)
			$(val).closest('tr').remove();
	 
	}

 
function countMissingAndUnsavableValue(val1){
	var countMissing=0;
	var countunSavable=0;
	var errorMissing=0;
	var errorUnSavable=0;
	for(var i=1;i<=8;i++){
		
		
		if (document.getElementById('urMChecked'+i).checked == true){
			var urMCheckedValue=document.getElementById('urMChecked'+i).value;
			var unurCheckedValue;
			if (document.getElementById('unurChecked'+i).checked == true){
				  unurCheckedValue=document.getElementById('urMChecked'+i).value;
			}
			if(unurCheckedValue== urMCheckedValue){
				errorMissing+=1;
			}
			countMissing+=1;
		}
		if (document.getElementById('ulMChecked'+i).checked == true){
			var ulMCheckedValue=document.getElementById('ulMChecked'+i).value;
			var unulCheckedValue ;
			if (document.getElementById('unulChecked'+i).checked == true){
				unulCheckedValue=document.getElementById('unulChecked'+i).value;
			}
			if(ulMCheckedValue== unulCheckedValue){
				errorMissing+=1;
			}
			countMissing+=1;
		} 
		if (document.getElementById('llMChecked'+i).checked == true){
			
			var llMCheckedValue=document.getElementById('llMChecked'+i).value;
			var unllCheckedValue ;
			if (document.getElementById('unllChecked'+i).checked == true){
				unllCheckedValue=document.getElementById('unllChecked'+i).value;
			}
			if(llMCheckedValue== unllCheckedValue){
				errorMissing+=1;
			}
			countMissing+=1;
		}
		
		
		
		if (document.getElementById('lrMChecked'+i).checked == true){
			
			var lrMCheckedValue=document.getElementById('lrMChecked'+i).value;
			var unlrCheckedValue ;
			if (document.getElementById('unlrChecked'+i).checked == true){
				unlrCheckedValue=document.getElementById('unlrChecked'+i).value;
			}
			if(lrMCheckedValue== unlrCheckedValue){
				errorMissing+=1;
			}
			countMissing+=1;
		}
		
		
		
		
		if (document.getElementById('unurChecked'+i).checked == true){
			
			var unurCheckedValue=document.getElementById('unurChecked'+i).value;
			var urMCheckedValue;
			if (document.getElementById('urMChecked'+i).checked == true){
				urMCheckedValue=document.getElementById('urMChecked'+i).value;
			}
			if(unurCheckedValue== urMCheckedValue){
				errorUnSavable+=1;
			}
			countunSavable+=1;
		}
		
		//unllChecked7
		if (document.getElementById('unulChecked'+i).checked == true){
			var unulCheckedValue=document.getElementById('unulChecked'+i).value;
			 
			var ulMCheckedValue;
			if (document.getElementById('ulMChecked'+i).checked == true){
				ulMCheckedValue=document.getElementById('ulMChecked'+i).value;
			}
			if(unulCheckedValue== ulMCheckedValue){
				errorUnSavable+=1;
			}
			countunSavable+=1;
			
		}
		
		if (document.getElementById('unllChecked'+i).checked == true){
			var unllCheckedValue=document.getElementById('unllChecked'+i).value;
			
			var llMCheckedValue;
			if (document.getElementById('llMChecked'+i).checked == true){
				llMCheckedValue=document.getElementById('llMChecked'+i).value;
			}
			if(unllCheckedValue == llMCheckedValue){
				
				errorUnSavable+=1;
			}
			countunSavable+=1;
		}
		
		
		if (document.getElementById('unlrChecked'+i).checked == true){
			var unlrCheckedValue=document.getElementById('unlrChecked'+i).value;
			var lrMCheckedValue;
			if (document.getElementById('lrMChecked'+i).checked == true){
				lrMCheckedValue=document.getElementById('lrMChecked'+i).value;
			}
			if(unlrCheckedValue== lrMCheckedValue){
				errorUnSavable+=1;
			}
			countunSavable+=1;
		}
	}
	if(errorUnSavable!=0 || errorMissing!=0){
		alert(""+resourceJSON.msgForMissingAndUnsavable);
		return false
		}
	$('#missing').val(countMissing);
	$('#unSavable').val(countunSavable);
	return true;
}
function validateForm(){
	var countResultEmpty=0;
	$('#dgInvetigationGrid tr').each(function(i, el) {

		var resultId = $(this).find("td:eq(1)").find("input:eq(0)").attr("id");
		var resultValue=$('#'+resultId).val();
		if(resultValue==null || resultValue==''){
			countResultEmpty+=1;
		}
		
 	});
	
return countResultEmpty;	
}

function submitMAForm(flagForSubmit) {
	 $('#obsistyMark').val(obsistyOverWeight);
	 var count=0;
	if(!fileValidate()){
		count++;
		return false;
	}
	//if(validateMedicalExamForm()){
	if(count==0){
		$('#saveInDraft').val(flagForSubmit);
		$("#submitMedicalExamByMA").submit();
		$("#submitMAForma").attr("disabled", true);
			return true;
		}
			//}
}
var globalDataMasstoreItem="";
var finalObservationOfMo="";
var finalObservationOfRMo="";
var finalObservationOfPRMo="";
function getAFMSF3BForMOOrMA() {
	var visitId = $('#visitId').val();
	var age = $('#ageForPatient').val();
	var userId=$('#userId').val();
	var approvalFlagCheckStatus=$('#approvalFlag').val();
	var pathname = window.location.pathname;
 	var accessGroup = "MMUWeb";

 	var url = window.location.protocol + "//"
 			+ window.location.host + "/" + accessGroup
 			+ "/medicalexam/getAFMSF3BForMOOrMA";
	var data = {
			"visitId" : visitId,
			"flagForForm" :"f3",
			"age":age,
			"userId":userId
		};
		$.ajax({

			type : "POST",
			contentType : "application/json",
			url : url,

			data : JSON.stringify(data),
			dataType : "json",
			// cache: false,

			success : function(res) {
				 data = res.listOfResponse;
				 var listMasServiceType = res.listMasServiceType;
				 var    serviceType="";
				 if (data != undefined && data != null) {
						$('#totalNoOfTeath').val(data[0].totalNoOfTeath);
						$('#totalNoOfDefective').val(data[0].totalNoOfDefective);
						$('#totalNoOfDentalPoints').val(data[0].totalNoOfDentalPoints);

						$('#missing').val(data[0].missing);
						$('#unSavable').val(data[0].unSavable);
						if(data[0].conditionOfGums!=null && data[0].conditionOfGums!="")
						$('#conditionOfGums').val(data[0].conditionOfGums);
						
						var glopbalVarForAll;
						 var missingTeethUr=data[0].missingTeethUr;
						 if(missingTeethUr!="" && missingTeethUr!=null){
							 glopbalVarForAll=missingTeethUr.split(",");
							 checkForTeeth("urMChecked",glopbalVarForAll);
						 }
						 
						 var missingTeethUl=data[0].missingTeethUl;
						 if(missingTeethUl!="" && missingTeethUl!=null){
							 glopbalVarForAll=missingTeethUl.split(",");
							 checkForTeeth("ulMChecked",glopbalVarForAll);
						 }
						 var missingTeethLL=data[0].missingTeethLL;
						 
						 if(missingTeethLL!="" && missingTeethLL!=null){
							 glopbalVarForAll=missingTeethLL.split(",");
							 checkForTeeth("llMChecked",glopbalVarForAll);
						 }
						 
						 var missingTeethLR=data[0].missingTeethLR;
						 
						 if(missingTeethLR!="" && missingTeethLR!=null){
							 glopbalVarForAll=missingTeethLR.split(",");
							 checkForTeeth("lrMChecked",glopbalVarForAll);
						 }
						 
						 var unsavableTeethUr=data[0].unsavableTeethUr;
						 if(unsavableTeethUr!="" && unsavableTeethUr!=null){
							 glopbalVarForAll=unsavableTeethUr.split(",");
							 checkForTeeth("unurChecked",glopbalVarForAll);
						 }
						 var unsavableTeethUl=data[0].unsavableTeethUl;
						 if(unsavableTeethUl!="" && unsavableTeethUl!=null){
							 glopbalVarForAll=unsavableTeethUl.split(",");
							 checkForTeeth("unulChecked",glopbalVarForAll);
						 }
						 
						 var unsavableTeethLl=data[0].unsavableTeethLl;
						 if(unsavableTeethLl!="" && unsavableTeethLl!=null){
							 glopbalVarForAll=unsavableTeethLl.split(",");
							 checkForTeeth("unllChecked",glopbalVarForAll);
						 }
						 
						 var unsavableTeethLr=data[0].unsavableTeethLr;
						 if(unsavableTeethLr!="" && unsavableTeethLr!=null){
							 glopbalVarForAll=unsavableTeethLr.split(",");
							 checkForTeeth("unlrChecked",glopbalVarForAll);
						 }
						 $('#dentalOffier').val(data[0].dentalOffier);
						  
						 if(data[0].remarks!=null && data[0].remarks!="")
						 $('#remarks').val(data[0].remarks);
						 $('#remarkAdvice').val(data[0].remarkAdvice);
						 
						 var pcHeight=data[0].pcHeight;
						 $('#height').val(pcHeight);
						 
						 var pcWeight=data[0].pcWeight;
						 $('#weight').val(pcWeight);
						 
						 var pcIdealWeight=data[0].pcIdealWeight;
						 $('#idealWeight').val(pcIdealWeight);
						 
						 var pcOverWeight=data[0].pcOverWeight;
						 $('#overWeight').val(pcOverWeight);
						 
						 var pcBmi=data[0].pcBmi;
						 $('#bmi').val(pcBmi);
						 
						 var pcBodyFat=data[0].pcBodyFat;
						 $('#bodyFat').val(pcBodyFat);
						 
						 var pcWaist=data[0].pcWaist;
						 $('#waist').val(pcWaist);
						 
						 /*var pcHip=data[0].pcHip;
						 $('#hip').val(pcHip);*/
						 
						 
						/* var pcWhr=data[0].pcWhr;
						 $('#whr').val(pcWhr);*/
						 
						 var pcSkinFoldExpansion=data[0].pcSkinFoldExpansion;
						 $('#skinFoldExpansion').val(pcSkinFoldExpansion);
						 
						 var pcChestFullExpansion=data[0].pcChestFullExpansion;
						 $('#chestFullExpansion').val(pcChestFullExpansion);
						 
						 var pcRangeOfExpansion=data[0].pcRangeOfExpansion;
						 if(data[0].pcRangeOfExpansion!=null && data[0].pcRangeOfExpansion!="" && data[0].pcRangeOfExpansion!=undefined)
						 $('#rangeOfExpansion').val(pcRangeOfExpansion);
						 
						 var pcSportsman=data[0].pcSportsman;
						 setSelectedValue("sportsman",pcSportsman);
						  //Vision start
							
							 var distantWithoutGlasses=data[0].distantWithoutGlasses;
							 setSelectedValue("distantWithoutGlasses",distantWithoutGlasses);
						 
							 var distantWithoutGlassesL=data[0].distantWithoutGlassesL;
							 setSelectedValue("distantWithoutGlassesL",distantWithoutGlassesL);	
							 
							 var nearWithoutGlasses=data[0].nearWithoutGlasses;
							 setSelectedValue("nearWithoutGlasses",nearWithoutGlasses);
							 
							 var nearWithoutGlassesL=data[0].nearWithoutGlassesL;
							 setSelectedValue("nearWithoutGlassesL",nearWithoutGlassesL);
							
							 
							 var cpWithoutGlasses=data[0].cpWithoutGlasses;
							 setSelectedValue("cpWithoutGlasses",cpWithoutGlasses);
						 
							 
							 var distantWithGlasses=data[0].distantWithGlasses;
							 setSelectedValue("distantWithGlasses",distantWithGlasses);
							 
							 var distantWithGlassesL=data[0].distantWithGlassesL;
							 setSelectedValue("distantWithGlassesL",distantWithGlassesL);
							 
							 
							 var nearWithGlasses=data[0].nearWithGlasses;
							 setSelectedValue("nearWithGlasses",nearWithGlasses);
						
							 
							 var nearWithGlassesL=data[0].nearWithGlassesL;
							 setSelectedValue("nearWithGlassesL",nearWithGlassesL);
							 
						//Hearing
						 var fwR=data[0].fwR;
						 if(fwR!=null && fwR!="")
						 $('#fwR').val(fwR);
						 
						 var fwL=data[0].fwL;
						 if(fwL!=null && fwL!="")
						 $('#fwL').val(fwL);
						 
						 var fwBoth=data[0].fwBoth;
						 if(fwBoth!=null && fwBoth!="")
						 $('#fwBoth').val(fwBoth);
						 
						 var cvR=data[0].cvR;
						 if(cvR!=null && cvR!="")
						 $('#cvR').val(cvR);
						 
						 var cvL=data[0].cvL;
						 if(cvL!=null && cvL!="")
						 $('#cvL').val(cvL);
						 
						 var cvBoth=data[0].cvBoth;
						 if(cvBoth!=null && cvBoth!="")
						 $('#cvBoth').val(cvBoth);
						 
						 var tmR=data[0].tmR;
						 if(tmR!=null && tmR!="")
						 setSelectedValue("tmR",tmR);
						 
						 var tmL=data[0].tmL;
						 if(tmL!=null && tmL!="")
						 setSelectedValue("tmL",tmL);
						 
						 var mobilityR=data[0].mobilityR;
						 //$('#mobilityR').val(mobilityR);
						 if(mobilityR!=null && mobilityR!="")
						 setSelectedValue("mobilityR",mobilityR);
						 
						 var mobilityL=data[0].mobilityL;
						 //$('#mobilityL').val(mobilityL);
						 if(mobilityL!=null && mobilityL!="")
						 setSelectedValue("mobilityL",mobilityL);
						 
						 var noiseThroatSinuses=data[0].noiseThroatSinuses;
						 if(noiseThroatSinuses!=null && noiseThroatSinuses!="")
						 $('#noseThroatSinuses').val(noiseThroatSinuses);
						 
						 var audiometryRecord=data[0].audiometryRecord;
						 
						 //$('#audiometryRecord').val(audiometryRecord);
						 if(audiometryRecord!=null && audiometryRecord!="")
						 setSelectedValue("audiometryRecord",audiometryRecord);
						 if(audiometryRecord!=null && audiometryRecord=='Others'){
						 var audiometryRecordOthers=data[0].audiometryRecordForOther;
						 if(audiometryRecordOthers!=null && audiometryRecordOthers!="")
						 $('#audiometryRecordForOther').val(audiometryRecordOthers);
						 $('#audiometryRecordForDisplay').show();
						 }
						 else{
							 $('#audiometryRecordForDisplay').hide();
						 }
						 var clinicalNotes=data[0].clinicalNotes;
						 if(clinicalNotes!=null && clinicalNotes!="")
						 $('#clinicalNotes').val(clinicalNotes);
						 
						 var pluse=data[0].pluse;
						 if(pluse!=null && pluse!="")
						 $('#pulse').val(pluse);
						 
						 var bp=data[0].bp;
						 if(bp!=null && bp!="")
						 $('#bp').val(bp);
						 
						 var bp1=data[0].bp1;
						 if(bp1!=null && bp1!="")
						 $('#bp1').val(bp1);
						 
						 var heartSize=data[0].heartSize;
						 if(heartSize!=null && heartSize!="")
						 $('#heartSize').val(heartSize);
						 
						 var sounds=data[0].sounds;
						 if(sounds!=null && sounds!="")
						 $('#sounds').val(sounds);
						 
						 var rhythm=data[0].rhythm;
						 if(rhythm!=null && rhythm!="")
						 $('#rhythm').val(rhythm);
						 
						 var respiratorySystem=data[0].respiratorySystem;
						 if(respiratorySystem!=null && respiratorySystem!="")
						 $('#respiratorySystem').val(respiratorySystem);
						 
						 var liver=data[0].liver;
						 if(liver!="" && liver!=undefined){
							 setSelectedValue("liverPalpable",'Yes');
							 $('#liver').val(liver);
							 $('#liverPalpableInput').show();
						 }
						 else{
							 setSelectedValue("liverPalpable",'No'); 
							 $('#liverPalpableInput').hide();
						 }
						 
						 
						 var spleen=data[0].spleen;
						 if(spleen!=""  && spleen!=undefined){
							 setSelectedValue("spleenPalpable",'Yes');
							 $('#spleen').val(spleen);
							 $('#spleenPalpableInput').show();
							 
						 }
						 
						 else{
							 setSelectedValue("spleenPalpable",'No'); 
							 $('#spleenPalpableInput').hide();
						 }
						 var higherMentalFunction=data[0].higherMentalFunction;
						 if(higherMentalFunction!="" && higherMentalFunction!=undefined)
						 $('#higherMentalFunction').val(higherMentalFunction);
						 
						 
						 var speech=data[0].speech;
						 if(speech!="" && speech!=undefined)
						 $('#speech').val(speech);
						 
						 var reflexes=data[0].reflexes;
						 if(reflexes!="" && reflexes!=undefined)
						 $('#reflexes').val(reflexes);
						 
						 var tremors=data[0].tremors;
						 if(tremors!="" && tremors!=undefined)
						 setSelectedValue("tremors",tremors);
						 
						 var selfBalancingTest=data[0].selfBalancingTest;
						 if(selfBalancingTest!="" && selfBalancingTest!=undefined)
						 setSelectedValue("selfBalancingTest",selfBalancingTest);
						 
						 var locomotorSystem=data[0].locomotorSystem;
						 if(locomotorSystem!="" && locomotorSystem!=undefined)
						 $('#locomotorSystem').val(locomotorSystem);
						 
						 var spine=data[0].spine;
						 if(spine!="" && spine!=undefined)
						 $('#spine').val(spine);
						 
						 var hernia=data[0].hernia;
						 if(hernia!="" && hernia!=undefined)
						 $('#hernia').val(hernia);
						 
						 var hydrocele=data[0].hydrocele;
						 if(hydrocele!="" && hydrocele!=undefined)
						 $('#hydrocele').val(hydrocele);
						 
						 var breast=data[0].breast;
						 if(breast!="" && breast!=undefined)
						 $('#breast').val(breast);
						 
						/* var coronaryRiskFactors=data[0].coronaryRiskFactors;
						 $('#coronaryRiskFactors').val(coronaryRiskFactors);
						 
						 var familyHistory=data[0].familyHistory;
						 setSelectedValue("familyHistory",familyHistory);
						 
						 var smokerCheckedLt10=data[0].smokerCheckedLt10;
						 
						 if(smokerCheckedLt10!=""&& smokerCheckedLt10=='9'){
							 document.getElementById('smokerCheckedLt10').checked=true;
						 }
						 if(smokerCheckedLt10!=""&& smokerCheckedLt10=='10'){
							 document.getElementById('smokerCheckedGt10').checked=true;
						 }
						 
						 var alcohol=data[0].alcohol;
						 setSelectedValue("alcohol",alcohol);
						 
						 var allergy=data[0].allergy;
						 $('#allergy').val(allergy);
						 
						 var remarkAdvice=data[0].remarkAdvice;
						 $('#remarkAdvice').val(remarkAdvice);*/
						 
					/*	var pcHip=data[0].pcHip;
						 $('#hip').val(pcHip);*/
						 
						 var pcChestFullExpansion=data[0].pcChestFullExpansion;
						 if(pcChestFullExpansion!="" && pcChestFullExpansion!=undefined)
						 $('#chestFullExpansion').val(pcChestFullExpansion);
						 
						 var opdPatientDetailId=data[0].opdPatientDetailId;
						 if(opdPatientDetailId!="" && opdPatientDetailId!=undefined)
						 $('#opdPatientDetailId').val(opdPatientDetailId);
						 
					var saveInDraft=$('#saveInDraft').val( );
					var status= data[0].status;
						 if(saveInDraft!="" && saveInDraft=='draftMo'){
						 	$('#chiefComplaint').val( data[0].chiefComplaint);
						 
						 	$('#pollar').val( data[0].pollar);
						 	
						 	$('#ordema').val( data[0].ordema);
						 	
						 	$('#cyanosis').val( data[0].cyanosis);
							
							 
						 	$('#hairnail').val( data[0].hairnail);
						 	
						 	$('#icterus').val( data[0].icterus);
						 	
						 	$('#cyanosis').val( data[0].cyanosis);
							 
						 	$('#lymphNode').val( data[0].lymphNode);
						 	
						 	$('#clubbing').val( data[0].clubbing);
							 
						 	$('#gcs').val( data[0].gcs);
							
						 	$('#Tremors').val(data[0].geTremors);
						 	
						 	$('#others').val( data[0].others);
							
						 	$('#remarksForReferal').val( data[0].remarksForReferal);
							$('#remarksReject').val( data[0].remarksReject);
							//$('#finalObservationMo').val( data[0].finalObservationMo);
							finalObservationOfMo=data[0].finalObservationMo;
							$('#remarksPending').val( data[0].remarksPending);
							$('#nextAppointmentDate').val( data[0].nextAppointmentDate);
							
							$('#remarksReject').val( data[0].remarksReject);
							// actionSelected(status);
							 if(approvalFlagCheckStatus=='y' || status=='rj'){
								 actionSelected(status);
							 }
							 var petStatus=data[0].petStatus;
							 
							 setSelectedValue("pet",petStatus);
							 //if(petStatus=='y'){
								 var petDate=data[0].petDate;
								 $('#petDateValue').val(petDate);
								// $('#petDate').show();
							 //}
							  
							
						 }
						 
						 if(saveInDraft!="" && saveInDraft=='draftRMo'){
							 
							 finalObservationOfMo=data[0].finalObservationMo;
							 finalObservationOfRMo=data[0].finalObservationRmo;
								$('#finalObservationMoJ').jqteVal( data[0].finalObservationMo);
							 
								//$('#finalObservationRmo').val( data[0].finalObservationRmo);
							
								
								//$('#remarksRmo').val( data[0].remarksRmo);
								$('#remarksForReferal').val( data[0].remarksForReferal);
								
								$('#remarksReject').val( data[0].remarksReject);
								$('#remarksForApproval').val( data[0].remarksForApproval);
								//actionSelected(status);
								 if(approvalFlagCheckStatus=='y' || status=='rj'){
									 actionSelected(status);
								 }
								var petStatus=data[0].petStatus;
								 setSelectedValue("pet",petStatus);

								 var petDate=data[0].petDate;
								  $('#petDateValue').val(petDate);
								/* if(petStatus=='y'){
									 var petDate=data[0].petDate;
									  $('#petDateValue').val(petDate);
									 $('#petDate').show();
								 }
								 else{
									 $('#petDate').hide();
								 }*/
						 }
						
						 
						 if(saveInDraft!="" && saveInDraft=='draftPRMo'){
							 
							 $('#finalObservationMoJ').jqteVal( data[0].finalObservationMo);
								$('#finalObservationRmoJ').jqteVal( data[0].finalObservationRmo);
								finalObservationOfMo=data[0].finalObservationMo;
								finalObservationOfRMo=data[0].finalObservationRmo;
								finalObservationOfPRMo=data[0].paFinalobservation;
								//$('#remarksRmo').val( data[0].remarksRmo);
								$('#remarksForReferal').val( data[0].remarksForReferal);
								
								$('#remarksReject').val( data[0].remarksReject);
								$('#remarksForApproval').val( data[0].remarksForApproval);
								//$('#finalObservationPRmo').val( data[0].paFinalobservation);
								//$('#remarksPRmo').val( data[0].remarksPRmo);
								//actionSelected(status);
								 if(approvalFlagCheckStatus=='y' || status=='rj'){
									 actionSelected(status);
								 }
								var petStatus=data[0].petStatus;
								 
								 setSelectedValue("pet",petStatus);

								 var petDate=data[0].petDate;
								  $('#petDateValue').val(petDate);
								/* if(petStatus=='y'){
									 var petDate=data[0].petDate;
									 $('#medicalExamDate').val(petDate);
									 $('#petDate').show();
								 }
								 else{
									 $('#petDate').hide();
								 }*/
						 }
						 if(data[0].peripheralPulsations!=null && data[0].peripheralPulsations!="")
							 $('#peripheralPulsations').val(data[0].peripheralPulsations);
						 
						 /*var regularExercise=data[0].regularExercise;
						 if(regularExercise!="" && regularExercise=='y'){
							 document.getElementById('adviceToReduceWeight').checked=true;
						 }*/
						 if(data[0].checkupDate!=null && data[0].checkupDate!=""){
							 $('#checkupDate').val(data[0].checkupDate);
						 }
						 if(data[0].haemorrhoids!=null && data[0].haemorrhoids!="")
						 $('#haemorrhoids').val(data[0].haemorrhoids);
						 $('#signedByMo').val(data[0].moUser);
						 $('#signedByRMo').val(data[0].rMoUser);
						 $('#signedByPRMo').val(data[0].pRMoUser);

						 if((data[0].hospitalIdFoward!=null && data[0].hospitalIdFoward!="" && saveInDraft!='draftPRMo' && saveInDraft!='draftRMo')|| approvalFlagCheckStatus=='y'){
							//$('#forwardStatus').show();
							var forwardedId=data[0].hospitalIdFoward;
							if(status!="" && status!='rj' && forwardedId!=undefined && forwardedId!="" && forwardedId!=null)
							getSelectedUnitData(forwardedId);
						 
						 }
						// $('#dateAME').val(data[0].dateAME);
					/*	 var approvalFlagValue=$('#approvalFlagValue').val();
						var approvedBy= data[0].approvedBy;
						 if(approvalFlagValue=='y'){
							 if(approvedBy=='MO'){
								 $('#finalObervationMoApproval').show();
								 $('#finalObervationRMoApproval').hide();
								 $('#finalObervationPRMoApproval').hide();
								 actionSelected(status);
								 $('#saveInDraft').val('draftMo');
								 
							 }
							 if(approvedBy=='RMO'){
								 $('#finalObervationMoApproval').show();
								 $('#finalObervationRMoApproval').show();
								 $('#finalObervationPRMoApproval').hide();
								 actionSelected(status);
								 $('#saveInDraft').val('draftRMo');
							 }
							 if(approvedBy=='PRMo'){
								 $('#finalObervationMoApproval').show();
								 $('#finalObervationRMoApproval').show();
								 $('#finalObervationPRMoApproval').show();
								 actionSelected(status);
								 $('#saveInDraft').val('draftPRMo');
							 }
						 }*/
						 
						 

						 $('#mensturalHistory').val(data[0].mensturalHistory);
						 var lmpselectValue=data[0].lmpSelect;
						 setSelectedValue("lmpSelect",lmpselectValue);
						 $('#lMP').val(data[0].lMP);
						 $('#nosOfPregnancies').val(data[0].nosOfPregnancies);
						 $('#nosOfAbortions').val(data[0].nosOfAbortions);

						 
						 $('#nosOfChildren').val(data[0].nosOfChildren);
						 $('#childDateOfLastConfinement').val(data[0].childDateOfLastConfinement);
						 $('#vaginalDischarge').val(data[0].vaginalDischarge);
						 
						
						 $('#usgAbdomen').val(data[0].usgAbdomen);
						 $('#prolapse').val(data[0].prolapse);
						
						 
						 if(data[0].obsistyCloseDate==null || data[0].obsistyCloseDate==""){
							 if(data[0].overweightFlag!=null  ){
								
								var overweightFlag=data[0].overweightFlag;
								 
								if(overweightFlag!="" && overweightFlag=='Y'){
									$("#overCheck").prop("checked", true);
									$("#overWeightDropDown").show();
									$('#obsistyMark').val("Y");
									 
									overWeightOb("Y");
								}
								if(overweightFlag!="" && overweightFlag=='N'){
									$("#obsistyCheck").prop("checked", true);
									$("#overWeightDropDown").hide();
									$('#obsistyMark').val("N");
									overWeightOb("N");
								}
								if(overweightFlag!="" && overweightFlag=='A'){
									$("#noneCheck").prop("checked", true);
									$("#overWeightDropDown").hide();
									$('#obsistyMark').val("A");
									overWeightOb("A");
								}
							 }
						 }
						 serviceType =  data[0].serviceType;
						 
					}
				 var approvalFlag=$('#approvalFlag').val();
				 if(approvalFlag!="" && approvalFlag!=undefined && approvalFlag=='y'){
					if (listMasServiceType != null
							&& listMasServiceType.length > 0) {
						var masServiceTypeVal = "";
						masServiceTypeVal += '<select class="form-control" id="serviceOfEmployee" name="serviceOfEmployee"';
							masServiceTypeVal += 'class="medium">';
						masServiceTypeVal += '<option value="0"><strong>Select</strong></option>';
						for (var i = 0; i < listMasServiceType.length; i++) {
							var selectedV = '';

							if (serviceType == listMasServiceType[i].serviceTypeId) {
								selectedV = "selected";
							} else {
								selectedV = '';
							}
							masServiceTypeVal += '<option   '+selectedV+'  value="' + listMasServiceType[i].serviceTypeId+ '"  >'
									+ listMasServiceType[i].serviceTypeName
									+ '</option>';
						}
						masServiceTypeVal += '</select>';
					}
					$('#serviceOfEmployee').html(masServiceTypeVal);
				 }
			}
		});
}

function setSelectedValue(idSelect, valueToSet) {
	var selectObj = document.getElementById(""+idSelect.trim());
	if(selectObj!=null && selectObj!="" && selectObj.options!=undefined){
    for (var i = 0; i < selectObj.options.length; i++) {
    	if (selectObj.options[i].value== valueToSet) {
    		selectObj.options[i].selected = true;
            return;
        }
    }
	}
}



function checkForTeeth(idCheckedValue,legthForCheckValue){
	for(var j=0;j<legthForCheckValue.length;j++){
	 for(var i=1;i<=8;i++){
		 if(legthForCheckValue[j].trim()==i){
			 document.getElementById(idCheckedValue+legthForCheckValue[j].trim()).checked=true;
		 }
		}
	 
	}
}
function getDateForChange(){
	var selectObj = document.getElementById("pet");
	if(selectObj!=null && selectObj!=""){
    for (var i = 0; i < selectObj.options.length; i++) {
        if (selectObj.options[selectObj.selectedIndex].value=='y') {
        	$('#petDate').show();
        	}
        else{
        	$('#petDate').hide();
        }
        }
	}
}
function getValidateForAction(){
	var selectedValue=$( "#actionMe option:selected" ).text();
	if(selectedValue=='Select'){
		alert(""+resourceJSON.msgAction);
		return false;
	}
		return true;
}


function submitMOForm(flagForSubmit) {
	
	$('#obsistyMark').val(""+obsistyOverWeight);
	var count=0;
	if(!fileValidate()){
		count=1;
	}
	$('#saveInDraft').val(flagForSubmit);
	   
	var selectObj="";
	if(flagForSubmit!="" && flagForSubmit!='draftMa'){
	var jqetFinedValue=$('#finalObservationMoJ').val();
	$('#finalObservationMo').val("");
	$('#finalObservationMo').val(jqetFinedValue);
	 var jqetFinedValue1=$('#finalObservationRmoJ').val();
	$('#finalObservationRmo').val("");
	$('#finalObservationRmo').val(jqetFinedValue1);
	
	 var  jqetFinedValue2=$('#finalObservationPRmoJ').val();
	$('#finalObservationPRmo').val("");
	$('#finalObservationPRmo').val(jqetFinedValue2);
	
	}
	if(getValidateForAction()){
		
		//if(flagForSubmit!="" && flagForSubmit=='draftMo'){
			var resultCountValue=validateForm();
			var selectObj = document.getElementById("actionMe");
			if(resultCountValue>0){
				if(selectObj!=null && selectObj!=""){
			        if (selectObj.options[selectObj.selectedIndex].value=='approveAndClose' 
			        	|| selectObj.options[selectObj.selectedIndex].value=='approveAndForward' || selectObj.options[selectObj.selectedIndex].value=='referred') {
			        alert(""+resourceJSON.msgActionNotCompleted);
			        count+=1;
			        return false;
			        }
				}
			}
			 if (selectObj.options[selectObj.selectedIndex].value=='approveAndForward') {
			var selectedValue=$( "#forwardTo option:selected" ).text();
			if(count==0 && selectedValue!=null && selectedValue!=""){
				if (selectedValue=='Select') {
						alert(""+resourceJSON.msgHopital);
						count+=1;
				        return false;
				}
				}
			var selectedValueDesi=$( "#designationForMe option:selected" ).text();
			if(count==0 && selectedValueDesi!=null && selectedValueDesi!=""){
				if (selectedValueDesi=='Select') {
					alert("Please select Designation.");
					count+=1;
			        return false;
		
				}
			}
	        }
			 
			 if(count==0){
				 checkBoxFitInCatMe();
			} 
			
			 if(flagForSubmit!='draftMa'){
				 var medicalCategoryIDVal=0;
				 var tbl = document.getElementById('medicalCategory');
				 var 	lastRow = tbl.rows.length;
				 
				 if(document.getElementById('fitInChk').value!=null && document.getElementById('fitInChk').checked==false){
					
					 $('#medicalCategory tr').each(function(i, el) {
	      				  var $tds = $(this).find('td');
						  var diagnosisValue = $($tds).closest('tr').find("td:eq(0)").find("input:eq(0)").val();
						if(diagnosisValue==null || diagnosisValue=="" || diagnosisValue==undefined){
							medicalCategoryIDVal++;
						}
					 });
				 }
				 if(medicalCategoryIDVal!=0){
					 alert("Please provide any Category.");
					 count++;	 
				 }
				 
				 
				/* $('#fileUploadforInvesDynamic tr').each(function(ij, el) {
				 		var fileNameValueIDd= $(this).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id"); 
						 	 
				 		var fileNameValue=$('#'+fileNameValueIDd).val();
						var filenameWithExtension=getFilenameAndReplcePath(fileNameValue);
						if(filenameWithExtension!="" && filenameWithExtension!=null && validateFileExtension(filenameWithExtension, "valid_msg", "Only pdf/image files are allowed !",
							      new Array("jpg","pdf","jpeg","gif","png","PNG","JPEG","JPG","GIF")) == false)
							      {
									count++;
							 		return false;
							      }
				 		
						});*/
				 
					var fileNameValue1=$('#medicalExamFileUpload').val();
					var filenameWithExtension=getFilenameAndReplcePath(fileNameValue1);
					if(filenameWithExtension!="" && filenameWithExtension!=null && validateFileExtension(filenameWithExtension, "valid_msg", "Only pdf/image files are allowed !",
						      new Array("jpg","pdf","jpeg","gif","png","PNG","JPEG","JPG","GIF")) == false)
						      {
								count++;
						 		return false;
						      }
					
					var checkFileName=0;
					if(filenameWithExtension!="" && filenameWithExtension!=undefined && filenameWithExtension!=null)
						if(checkForFileCondition(filenameWithExtension)){
							checkFileName++;
							count++;
						}
					if(checkFileName>0){
				 		alert("File contain special character.Please upload valid file.");
				 		return false;
				 	 }
			 		}
			 
			 
		if(count==0){
		if(selectObj.options[selectObj.selectedIndex].value!='pending' && selectObj.options[selectObj.selectedIndex].value!='referred'
			&& selectObj.options[selectObj.selectedIndex].value!='reject'){
			if(validateMedicalExamForm()){
			if(flagForSubmit!='draftMa' && selectObj.options[selectObj.selectedIndex].value=='approveAndForward'){
				
				var designationNameVal=$( "#designationForMe option:selected" ).text();
				$('#designationName').text(designationNameVal);
				$('#messageForDesignation').show();
				$('.modal-backdrop').show();
			}
			else{
			$("#submitMedicalExamByMo").submit();
			$("#submitByMo").attr("disabled", "disabled");
			
			}
			}
			}
		else{
			if(flagForSubmit!='draftMa' && selectObj.options[selectObj.selectedIndex].value=='approveAndForward'){
				var designationNameVal=$( "#designationForMe option:selected" ).text();
				$('#designationName').text(designationNameVal);
				$('#messageForDesignation').show();
				$('.modal-backdrop').show();
			}
			else{
			$("#submitMedicalExamByMo").submit();
			$("#submitByMo").attr("disabled", "disabled");
			
			}
			}
		}
			
	}
	return true;
}

function submitMOFormByModel(){
	$("#submitMedicalExamByMo").submit();
	$("#submitByMo").attr("disabled","disabled");
	$("#modal3BFormSubmit").attr("disabled","disabled");
	
}






var lastRow;
var i=0;
 function addRowForInvestigationFunME(){
	  var tbl = document.getElementById('dgInvetigationGrid');
   	lastRow = tbl.rows.length;
   	i =lastRow;
   	i++;
	    var aClone = $('#dgInvetigationGrid>tr:last').clone(true)
	    aClone.find('img.ui-datepicker-trigger').remove();
		aClone.find(":input").val("");
		aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'chargeCodeName'+i+'');
		aClone.find("td:eq(0)").find("input:eq(3)").prop('id', 'investigationIdValue'+i+'');
		
		aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'resultInvs'+i+'');
		
		aClone.find("td:eq(0)").find("input:eq(0)").removeAttr("readonly");
		var	investigationNew ='';
		investigationNew +='<button type="button" name="delete" value="" id="deleteInves'+i+'"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" onclick="removeRowInvestigationMe(this);"></button>';

		aClone.find("td:eq(5)").html(investigationNew);
		
		aClone.clone(true).appendTo('#dgInvetigationGrid');
    	$('#dgInvetigationGrid>tr:last').find("td:eq(3)").find("button:eq(0)").attr("id","newIdInv");
	} 
 
 
 /*function removeRowInvestigationMe(val, investigationGrid, investigationData) {
	if(investigationGrid == "investigationGrid"){	
	 var tbl = document.getElementById('dgInvetigationGrid');
		var lastRow = tbl.rows.length;
	}
	if(investigationGrid == "immunisationStatusGrid"){	
		 var tbl = document.getElementById('immunisationStatusGrid');
			var lastRow = tbl.rows.length;
		}
		var msg=resourceJSON.msgDelete;
		
		if (confirm(msg)) {
			if (investigationGrid == "investigationGrid" && lastRow == '1') {
				$("#messageDelete").show();
				return false;
			}
			if (investigationGrid == "immunisationStatusGrid" && lastRow == '1') {
				$("#messageDelete").show();
				return false;
			}
			$(val).closest('tr').remove();
			var flag = 0;
			if ((val.id != "newIdInv" && investigationGrid == "investigationGrid")) {
				if (investigationGrid == "investigationGrid"
						&& investigationData != "") {
					flag = 1;
					deleteInvestigatRow(flag, investigationData, "", "", "");
				}
			}
			if ((val.id != "newIdImmunization" && investigationGrid == "immunisationStatusGrid")) {
				if (investigationGrid == "immunisationStatusGrid"
						&& investigationData != "") {
					flag = 'Im1005';
					deleteInvestigatRow(flag, investigationData, "", "", "");
				}
			}
			
		}
	}
 */
 
 
 
 var globalDataForReferal = "";
 var globalReferalDatHtml = "";
 function getPatientReferalDetailME() {
 	var opdPatientDetailId = $('#opdPatientDetailId').val();
 	var patientId = $('#patientId').val();
 	var visitId = $('#visitId').val();
 	var hospitalId=$('#hospitalId').val();
 	var masIcdList = "";
 	var data = {
 		"opdPatientDetailId" : opdPatientDetailId,
 		"patientId" : patientId,
 		"visitId" : visitId,
 		"flagForRefer":"me",
 		"hospitalId":hospitalId
 	};
 	 var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";
     var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalexam/getPatientReferalDetailMe";
 	$.ajax({type : "POST",
 				contentType : "application/json",
 				url : url,
 				data : JSON.stringify(data),
 				dataType : "json",
 				// cache: false,
 				success : function(res) {
 					data = res.listReferralPatientDt;
 					
 					var masEmpanaledList = res.masEmpanelledHospitalList;
 					
 					var	masIcdList = res.listMasIcd;
 				
 					//var masDepartment=res.departmentList;
 					masSpecialistList=res.departmentList;
 					var referrDtData = "";
 					var count = 1;
 					investigationGridValue = "referrDtData";
 					var diagnosisValue = "";
 					var diagonisisIdValue = "";
 					var referalPatientDtIds = "";
 					var referalNotes = "";
 					var referVisitDates = "";
 					var hospitalIdValue="";
 					func1='fillDiagnosisComboForRefered';
		    		 url1='opd';
		    		 url2='getIcdListByName';
		    		 flaga='diagnosisMe'; 					
 					var totalLengthDigiFileReferVal=0;
 					
 					if (data != undefined && data.length != 0) {
 						for (var i = 0; i < data.length; i++) {
 							if(data[i].referalNotes!=null && data[i].referalNotes!="")
 								referalNotes=data[i].referalNotes;
 							
 							referrDtData += '<tr ">';
 							
 							referrDtData += '<td>' + count + '</td>';
 							
 							referrDtData += '<td><select class="form-control" id="medicalExamReferalHos'
 									+ i + '" name="medicalExamReferalHos"';
 							referrDtData += 'class="medium">';
 							var masEmpanalId = data[i].masEmpanalId;
 							referrDtData += '<option value="0"><strong>Please select hospital</strong></option>';
 							var selectMasEmpalHos = "";
 						
 							hospitalIdValue=masEmpanalId;
 							$.each(masEmpanaledList,function(ij, empanal) {
 												if (masEmpanalId == empanal.empanelledHospitalId) {
 													selectMasEmpalHos = 'selected';
 												} else {
 													selectMasEmpalHos = "";
 												}
 												referrDtData += '<option ' + selectMasEmpalHos + ' value="' + empanal.empanelledHospitalId
 														+ '@'
 														+ empanal.empanelledHospitalCode
 														+ '" >'
 														+ empanal.empanelledHospitalName
 														+ '</option>';
 											});
 							referrDtData += '</select>';
 							referrDtData += '</td>';
 							
 							referrDtData += '<td>';
 							
 							
 							var exDepartmentValue = data[i].exDepartmentValue;
							
							referrDtData += '<select class="form-control" id="departmentValue'
								+ i + '" name="departmentValue"';
							referrDtData += 'class="medium">';
							  referrDtData += '<option value=""><strong>Select Department...</strong></option>';
							var selectDepart="";
							
		 					$.each(masSpecialistList, function(i, item) {
		 						
		 						if (exDepartmentValue == item.specialityName) {
									selectDepart = 'selected';
								} else {
									selectDepart = "";
								}
		 						referrDtData += '<option '+selectDepart+' value="'+ item.specialityName + '" >' + item.specialityName
		 								+ '</option>';
		 					});
		 					
							referrDtData += '</select>';
 							
 							
 							
 							/*referrDtData += '<input type="text" class="form-control departmentListClass" id="departmentValue'
 									+ i
 									+ '" name="departmentValue" value="'
 									+ data[i].exDepartmentValue + '" />';*/
 							
 							referrDtData += '<input type="hidden" id="diagonsisId'+ i+ '" name="diagonsisId" value="'
 									+ data[i].diagonisId + '"/>';
 							referrDtData += '<input type="hidden"  name="masEmpanalHospitalId" value="'
 									+ hospitalIdValue
 									+ '" id="masEmpanalHospitalId'+hospitalIdValue+'"/>';
 							referrDtData += '<input type="hidden"  name="masDepatId" value="'
 									+ data[i].masDepatId
 									+ '" id="masDepatId'+data[i].masDepatId+'"/>';

 							referrDtData += '<input type="hidden"  name="referalPatientDt" value="'
 									+ data[i].referalPatientDt
 									+ '" id="referalPatientDt'+data[i].referalPatientDt+'"/>';
 							referrDtData += '<input type="hidden"  name="referalPatientHd" value="'
 									+ data[i].referalPatientHd
 									+ '" id="referalPatientHd'+data[i].referalPatientHd+'"/>';

 							referrDtData += '</td>';
 							
 							
 							referrDtData += '<td><div class="autocomplete forTableResp">';
 							
 							referrDtData +=' <input name="icddiagnosis" id="icddiagnosis" type="text"';
 							referrDtData +='class="form-control border-input"';
 							referrDtData +='placeholder=" " value="'+ data[i].daiganosisName + '['+ data[i].masCode + ']' + '"  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"';
 							referrDtData +='  />';
 							referrDtData+='<div id="diagnosisMeDiv'+i+'" class="autocomplete-itemsNew"></div>';
 			 				
 							referrDtData += '<div></td>';
 							
 							referrDtData += '<td><input type="text" class="form-control" id="instruction'+i+'" name="instruction" value="'
 									+ data[i].instruction + '" /></td>';
 							
 							//referrDtData += '<td><textarea name="specialistOpinion" id="specialistOpinion'+i+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;"></textarea><a class="btn-link" href="javascript:void(0)"  onclick="openResultModelSpecialist(this);">View/Enter Result</a></td>';
 							referrDtData += '<td><textarea name="specialistOpinion" id="specialistOpinion'+i+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###'+escapeHtml(data[i].finalNotes)+'</textarea><a class="btn-link" href="javascript:void(0)"  onclick="openResultModelSpecialist(this);">View/Enter Result</a></td>';

 							
 							
 							var deleteButtonFlag="";
 							var ridcIdVal=0;
 							if(data[i].ridcId!=null){
 								totalLengthDigiFileReferVal++;
 								ridcIdVal=data[i].ridcId;
 								}
 							else{
 								deleteButtonFlag='';
 								deleteButtonFlag='disabled';
 								ridcIdVal=0;
 							}
 							
 							if(ridcIdVal>0){
	 							referrDtData += '	<td><a class="btn-link" href="JavaScript:Void(0);" onclick="viewDocumentForDigi('+data[i].ridcId+');" >View Document</a></td>'
	 							}
	 							else{
	 								referrDtData += '	<td>';
	 								referrDtData += '	<div class="fileUploadDiv">';
	 								referrDtData += '		<input type="file" name="referalFileUpload" id="referalFileUpload'+count+'" class="inputUpload" />';
	 								referrDtData += '		<label class="inputUploadlabel">Choose File</label>';
	 								referrDtData += '		<span class="inputUploadFileName">No File Chosen</span>';
	 								referrDtData += '	</div>';
	 								referrDtData += '	</td>';
	 							}
 							referrDtData += '<td><button type="Button" name="add" class="buttonAdd btn btn-primary noMinWidth" id="referalMedicalDtIdAdd" button-type="add" value="" tabindex="1" onclick="addRowForReferalPatientMedicalExam();"> </button></td>';
 							referrDtData += '<td><button type="button" name="delete" value="" id="referalDtMedicalIdDel"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" onclick="removeRowInvestigationReferal(this,\''
 									+ investigationGridValue
 									+ '\','
 									+ data[i].referalPatientDt
 									+ ');" ></button></td>';
 							referrDtData += '</tr>';
 							count++;
 						}
 						$('#totalLengthDigiFileRefer').val(totalLengthDigiFileReferVal);
 						$("#medicalReferal").html(referrDtData);
 						if(referalNotes!="" && referalNotes!=null && referalNotes!=undefined)
 							$('#referralNote').val(referalNotes);
 					} 
 					else{
 						var masHospital="";
 					
 						masHospital += '<select class="form-control" id="medicalExamReferalHos1" name="medicalExamReferalHos"';
 						masHospital += 'class="medium">';
					 
						masHospital += '<option value=""><strong>Please select hospital</strong></option>';
						var selectMasEmpalHos = "";
						$.each(masEmpanaledList,function(ij, empanal) {
							masHospital += '<option ' + selectMasEmpalHos + ' value="' + empanal.empanelledHospitalId
													+ '@'
													+ empanal.empanelledHospitalCode
													+ '" >'
													+ empanal.empanelledHospitalName
													+ '</option>';
										});
						masHospital += '</select>';
						masHospital += ' ';
						$("#masEmpanelME").html(masHospital);	
						
						
						var departmentList="";
						departmentList += '<select class="form-control" id="departmentValue" name="departmentValue"';
						departmentList += 'class="medium">';
						departmentList += '<option value=""><strong>Select Department...</strong></option>';
						var selectDepart="";
						
	 					$.each(masSpecialistList, function(i, item) {
	 						
	 						if (exDepartmentValue == item.specialityName) {
								selectDepart = 'selected';
							} else {
								selectDepart = "";
							}
	 						departmentList += '<option '+selectDepart+' value="'+ item.specialityName + '" >' + item.specialityName
	 								+ '</option>';
	 					});
	 					
	 					departmentList += '</select>';
	 					
	 					$("#departmentValue").html(departmentList);	
						
	 					$('#totalLengthDigiFileRefer').val("0");
 					}
 					
 				}
 			});

 	return false;
 }
 
 
 /*function goToOpdMain(){
	 var popup;
	 var visitID=$('#visitId').val();
	 	 	popup = window.open("/AshaWeb/opd/getOpdPatientModel?visitId="+visitID+"", "popUpWindow",
	 	 			"height=500,width=800,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
	 	 	
	 	}*/
	 function actionSelected(statusValue){
		 
			var selectObj = document.getElementById("actionMe");
			if(selectObj!=null && selectObj!=""){
		    for (var i = 0; i < selectObj.options.length; i++) {
		    	if(statusValue=='ac'){
		    		if (selectObj.options[i].value== "approveAndClose") {
		                selectObj.options[i].selected = true;
		                $('#approvedMedicalExam').show();
		                return;
		            }
		    	}
		    	
		    	if(statusValue=='af'){
		    		if (selectObj.options[i].value== "approveAndForward") {
		                selectObj.options[i].selected = true;
		                $('#approvedMedicalExam').show();
		                //$('#forwardStatus').show();
		                return;
		            }
		    	}
		    	
		    	
		    	if(statusValue=='rf'){
		    		if (selectObj.options[i].value== "referred") {
		                selectObj.options[i].selected = true;
		                $('#referredMe').show();    
		                return;
		            }
		    	}
		    	if(statusValue=='rj'){
		    		if (selectObj.options[i].value== "reject") {
		                selectObj.options[i].selected = true;
		                $('#rejectMedicalExam').show();  
		                return;
		            }
		    	}
		    	
		    	if(statusValue=='pe'){
		    		if (selectObj.options[i].value== "pending") {
		                selectObj.options[i].selected = true;
		                $('#pendingMedicalExam').show();  
		                return;
		            }
		    	}
		    }
		   }
		 
	 }
	 
 function changeAction(val){
	 var saveInDraft=$('#saveInDraft').val();
	 //	if(saveInDraft=='draftMo'){
		var selectObj = document.getElementById("actionMe");
		if(selectObj!=null && selectObj!=""){
	    for (var i = 0; i < selectObj.options.length; i++) {
	    	
	        if (selectObj.options[selectObj.selectedIndex].value=='approveAndClose') {
	        	$('#approvedMedicalExam').show();
	        	$('#referredMe').hide();
	        	$('#rejectMedicalExam').hide();
	        	$('#pendingMedicalExam').hide();
	        	$('#forwardStatus').hide();
	        	$('#remarksForApproval').val("");
	        	$('#designationMeId').hide();
	        }
	        
	        if (selectObj.options[selectObj.selectedIndex].value=='referred') {
	        	$('#referredMe').show();    
	        	
	        	$('#approvedMedicalExam').hide();
	        	$('#rejectMedicalExam').hide();
	        	$('#pendingMedicalExam').hide();
	        	$('#forwardStatus').hide();
	        	$('#designationMeId').hide();
	        }
	        if (selectObj.options[selectObj.selectedIndex].value=='reject') {
	        	$('#rejectMedicalExam').show();  
	        	
	        	$('#approvedMedicalExam').hide();
	        	$('#referredMe').hide();
	        	$('#pendingMedicalExam').hide();
	        	$('#forwardStatus').hide();
	        	$('#designationMeId').hide();
	        	$('#remarksReject').removeAttr('readonly');	 
	        }
	        if (selectObj.options[selectObj.selectedIndex].value=='pending') {
	        	$('#pendingMedicalExam').show();  
	        	
	        	$('#approvedMedicalExam').hide();
	        	$('#referredMe').hide();
	        	$('#rejectMedicalExam').hide();
	        	$('#forwardStatus').hide();
	        	$('#designationMeId').hide();
	        }
	        if (selectObj.options[selectObj.selectedIndex].value=='approveAndForward') {
	        	$('#approvedMedicalExam').show();
	        	$('#referredMe').hide();
	        	$('#rejectMedicalExam').hide();
	        	$('#pendingMedicalExam').hide();
	        	$('#forwardStatus').show(); 
	        	
	        }
	        if (selectObj.options[selectObj.selectedIndex].value=='0') {
				$('#approvedMedicalExam').hide();
	        	$('#referredMe').hide();
	        	$('#rejectMedicalExam').hide();
	        	$('#pendingMedicalExam').hide();
	        	$('#forwardStatus').hide();
	        	$('#designationMeId').hide();
				
			}
	         
	    }
	}
		
 }
 
 
 function addRowForReferalPatientMedicalExam() {
		
		var sNO=0;
		var tbl = document.getElementById('medicalReferal');
		var lastRow = tbl.rows.length;
		k = lastRow+1;
		sNO=lastRow;
		k++;
		sNO++;
		var aClone = $('#medicalReferal>tr:last').clone(true)
		aClone.find("td:eq(0)").html(sNO);
		//aClone.find('select').prop('id', 'medicalExamReferalHos' + k + '');
		aClone.find("td:eq(1)").find("select:eq(0)").prop('id','medicalExamReferalHos' + k + '');
		aClone.find("td:eq(2)").find("select:eq(0)").prop('id','departmentValue' + k + '');
		aClone.find("td:eq(2)").find("input:eq(0)").prop('id','diagonsisId' + k + '');
		aClone.find("td:eq(2)").find("input:eq(1)").prop('id','masEmpanalHospitalId' + k + '');
		aClone.find("td:eq(2)").find("input:eq(2)").prop('id','masDepatId' + k + '');
		aClone.find("td:eq(2)").find("input:eq(3)").prop('id','referalPatientDt' + k + '');
		aClone.find("td:eq(2)").find("input:eq(4)").prop('id','referalPatientHd' + k + '');
		
		
		
		aClone.find("td:eq(3)").find("input:eq(0)").prop('id','icddiagnosis' + k + '');
		  aClone.find("td:eq(3)").find("div").find("div").prop('id', 'diagnosisDivMe' + k + '');

		aClone.find("td:eq(4)").find("input:eq(0)").prop('id','instruction' + k + '');
		aClone.find("td:eq(5)").find("textarea:eq(0)").prop('id','specialistOpinion' + k + '');
		
		var referalFileHtml='<div class="fileUploadDiv"><input type="file" name="referalFileUpload'+k+'" id="referalFileUpload'+k+'" value="" class="inputUpload"><label class="inputUploadlabel">Choose File</label><span class="inputUploadFileName">No File Chosen</span></div>';
		aClone.find("td:eq(6)").html(referalFileHtml);
		aClone.find(":input").val("");
		aClone.find("option[selected]").removeAttr("selected")
		aClone.clone(true).appendTo('#medicalReferal');
		$('#medicalReferal>tr:last').find("td:eq(6)").find("button:eq(0)").attr("id", "newIdRef");
	}
 
 
 var arrayData = [];
 var i = "";
 var invesRadio="";
 var investigationForUom="";
 
 function changeRadio(radioValue){
 	invesRadio=radioValue;
 	$('#labImaginId').val(radioValue);
 }
 
 
 
 function changeRadio222(radioValue){
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
 			for(var i=0;i<data.length;i++){
 				//var investigationId= data[i].investigationId;
 				//var investigationName = data[i].investigationName;
 				var investigationNewUpdate=data[i];
 				var investigationId= investigationNewUpdate[0];
 				var investigationName = investigationNewUpdate[1];
 				
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

  
 
 var arry = new Array();
 var icdArry = new Array();
 
         function getDiagnosisValue() {
         	var userId=$('#userId').val();
             var pathname = window.location.pathname;
             var accessGroup = "MMUWeb";

             var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/getIcdList";
             $.ajax({
                 type: "POST",
                 contentType: "application/json",
                 url: url,
                 data: JSON.stringify({
                     'employeeId': userId 
                 }),
                 dataType: 'json',
                 timeout: 100000,

                 success: function(res)

                 {
                 	icdData = res.ICDList;
                 	autoIcdCode=res.ICDList;
                     //alert(data.length);
                     //console.log('data :',data);
                     var autoIcdList = [];
                     for (var i = 0; i < icdData.length; i++) {
                         var icdId = icdData[i].icdId;
                         var icdCode = icdData[i].icdCode;
                         var icdName = icdData[i].icdName;
                         var a = icdName + "[" + icdCode + "]"

                         var icdId = icdName + "[" + icdId + "]"
                         autoIcdList[i] = a;
                             //alert("a "+a);
                         arry.push(a);
                         icdArry.push(icdId);
                         //console.log('data :', a, icdId);
                     }
                    
                    // putIcdIdValue(autoIcdList, icdData);

                 },
                 error: function(jqXHR, exception) {
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

         }
 
 
 var autoIcdCode = '';
 var icdData= '';	 
  var idIcdNo = '';
  var icdValue = '';
  
  
  function fillDiagnosisCombo(val,item) {
	  
	     var index1 = val.lastIndexOf("[");
	     var index2 = val.lastIndexOf("]");
	     index1++;
	     idIcdNo = val.substring(index1, index2);
	     if (idIcdNo == "") {
	         return;
	     } else {
	        
	         for(var i=0;i<autoIcdCode.length;i++){
	    		  var icdNo1 = icdData[i].icdCode;
	    		  icdValue = icdData[i].icdId;
	    		  if(icdNo1 == idIcdNo){
	    			  $(item).closest('tr').find("td:eq(1)").find("input:eq(1)").val(icdValue);
	    			  $(item).closest('tr').find("td:eq(2)").find("input:eq(1)").val(icdValue);
	    			  $(item).closest('tr').find("td:eq(2)").find("input:eq(0)").val(icdValue);
	    		  }
	    	  }
	     }
	 }
	 
  
  
 function fillDiagnosisComboMedCat(val,item) {
	  
     var index1 = val.lastIndexOf("[");
     var index2 = val.lastIndexOf("]");
     index1++;
     idIcdNo = val.substring(index1, index2);
     if (idIcdNo == "") {
         return;
     } else {
        
         for(var i=0;i<autoIcdCode.length;i++){
    		  var icdNo1 = icdData[i].icdCode;
    		  icdValue = icdData[i].icdId;
    		  if(icdNo1 == idIcdNo){
         			var checkCurrentRowIddd = $(item).closest('tr').find("td:eq(1)").find("input:eq(1)").attr("id");
				     var checkCurrentRow = $(item).closest('tr').find("td:eq(1)").find("input:eq(1)").val();
				     $('#medicalCategory tr').each(function(i, el) {
         				//alert("icdNo1"+icdNo1)
         				//alert("icdValue "+icdValue)
         				  var $tds = $(this).find('td');
							var chargeCodeId = $($tds).closest('tr').find("td:eq(1)").find("input:eq(1)").attr("id");
							var chargeCodeIdValue = $('#' + chargeCodeId).val();
							var idddd = $(item).closest('tr').find("td:eq(1)").find("input:eq(1)").attr("id");
							var currentidddd = $(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
							//alert("chargeCodeIdValue "+chargeCodeIdValue)
							if (chargeCodeId != checkCurrentRowIddd && icdValue == chargeCodeIdValue) {
								if (icdValue == chargeCodeIdValue) {
									alert("Diagnosis is already added");
									$('#' + idddd).val("");
									$('#' + currentidddd).val("");
									$('#'+ chargeCodeIdValue).val("");
									return false;
								}
							}
					else
					{	
    		 
    			  $(item).closest('tr').find("td:eq(1)").find("input:eq(1)").val(icdValue);
    			  $(item).closest('tr').find("td:eq(2)").find("input:eq(1)").val(icdValue);
    			  $(item).closest('tr').find("td:eq(2)").find("input:eq(0)").val(icdValue);
    			  
    			  /*var countForDigi=0;
    				 $('#medicalCategory tr').each(function(i, el) {
    						var $tds = $(this).find('td')	

    						 var icdName = $tds.eq(0).find(":input").val();
    						var deleteIdd=$(this).closest('tr').find("td:eq(8)").find("button:eq(0)").attr("id");
    						 if(icdName!="" && deleteIdd!="" && deleteIdd!=undefined && deleteIdd.includes("deleteMC")){
    							 countForDigi=+1; 
    						 }
    			 	 });*/
    				 //if(countForDigi!=0)
    					 getMedicalCategoryFinalObserb(item);
    		  }
         			 }); 
    		  }
    	  }
     }
 }
 
 function fillDiagnosisComboMedCatMe(val,item) {
	  
     var index1 = val.lastIndexOf("[");
     var index2 = val.lastIndexOf("]");
     index1++;
     idIcdNo = val.substring(index1, index2);
     if (idIcdNo == "") {
         return;
     } else {
        
         for(var i=0;i<autoIcdCode.length;i++){
    		  var icdNo1 = icdData[i].icdCode;
    		  icdValue = icdData[i].icdId;
    		  if(icdNo1 == idIcdNo){
         			var checkCurrentRowIddd = $(item).closest('tr').find("td:eq(1)").find("input:eq(1)").attr("id");
				     var checkCurrentRow = $(item).closest('tr').find("td:eq(1)").find("input:eq(1)").val();
				     $('#medicalCategory tr').each(function(i, el) {
         				//alert("icdNo1"+icdNo1)
         				//alert("icdValue "+icdValue)
         				  var $tds = $(this).find('td');
							var chargeCodeId = $($tds).closest('tr').find("td:eq(1)").find("input:eq(1)").attr("id");
							var chargeCodeIdValue = $('#' + chargeCodeId).val();
							var idddd = $(item).closest('tr').find("td:eq(1)").find("input:eq(1)").attr("id");
							var currentidddd = $(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
							//alert("chargeCodeIdValue "+chargeCodeIdValue)
							if (chargeCodeId != checkCurrentRowIddd && icdValue == chargeCodeIdValue) {
								if (icdValue == chargeCodeIdValue) {
									alert("Diagnosis is already added");
									$('#' + idddd).val("");
									$('#' + currentidddd).val("");
									$('#'+ chargeCodeIdValue).val("");
									return false;
								}
							}
					else
					{	
    		 
    			  $(item).closest('tr').find("td:eq(1)").find("input:eq(1)").val(icdValue);
    			  $(item).closest('tr').find("td:eq(2)").find("input:eq(1)").val(icdValue);
    			  $(item).closest('tr').find("td:eq(2)").find("input:eq(0)").val(icdValue);
    			  
    			  var countForDigi=0;
    				 $('#medicalCategory tr').each(function(i, el) {
    						var $tds = $(this).find('td')	

    						 var icdName = $tds.eq(0).find(":input").val();
    						var deleteIdd=$(this).closest('tr').find("td:eq(8)").find("button:eq(0)").attr("id");
    						 if(icdName!="" && deleteIdd!="" && deleteIdd!=undefined && deleteIdd.includes("deleteMC")){
    							 countForDigi=+1; 
    						 }
    			 	 });
    				 if(countForDigi!=0)
    					 getMedicalCategoryFinalObserb(item);
    		  }
         			 }); 
    		  }
    	  }
     }
 }
 
 var total_mc_value = '';
 function fillMedicalCategoryDataMe(val,item) {
   	  
       var index1 = val.lastIndexOf("[");
       var index2 = val.lastIndexOf("]");
       index1++;
       idMcNo = val.substring(index1, index2);
       if (idMcNo == "") {
           return;
       } else {
           obj = document.getElementById('medicalCategoryId');
           total_mc_value += val+",";
          
           obj.length = document.getElementById('medicalCategoryId').length;
           var b = "false";
           for(var i=0;i<autoMedicalCategoryData.length;i++){
        		  
        		  var mcDataVal = mcData[i].medicalCategoryCode;
        		 
        		  if(mcDataVal == idMcNo){
        			var mCategoryValue = mcData[i].medicalCategoryId;
        			$(item).closest('tr').find("td:eq(1)").find("input:eq(2)").val(mCategoryValue);
        			$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val(mCategoryValue);
        			
        			 var countForDigi=0;
        			 $('#medicalCategory tr').each(function(i, el) {
        					var $tds = $(this).find('td')	

        					 var icdName = $tds.eq(0).find(":input").val();
        					var deleteIdd=$(this).closest('tr').find("td:eq(8)").find("button:eq(0)").attr("id");
        					 if(icdName!="" && deleteIdd!="" && deleteIdd!=undefined && deleteIdd.includes("deleteMC")){
        						 countForDigi=+1; 
        					 }
        		 	 });
        			 if(countForDigi!=0)
        				 getMedicalCategoryFinalObserb(item);
        		  }
        	  }
           if (b == "false") {
               $('#medicalCategoryId').append('<option value=' + mCategoryValue + '>' + val + '</option>');

           }
       }
   }        

 
 function fillDiagnosisComboForRefered(val,item) {
	  
     var index1 = val.lastIndexOf("[");
     var index2 = val.lastIndexOf("]");
     index1++;
     idIcdNo = val.substring(index1, index2);
     if (idIcdNo == "") {
         return;
     } else {
        
         for(var i=0;i<autoIcdCode.length;i++){
    		  var icdNo1 = icdData[i].icdCode;
    		  icdValue = icdData[i].icdId;
    		  if(icdNo1 == idIcdNo){
         			var checkCurrentRowIddd = $(item).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id");
				     var checkCurrentRow = $(item).closest('tr').find("td:eq(2)").find("input:eq(0)").val();
				     $('#medicalReferal tr').each(function(i, el) {
         				//alert("icdNo1"+icdNo1)
         				//alert("icdValue "+icdValue)
         				  var $tds = $(this).find('td');
							var chargeCodeId = $($tds).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id");
							var chargeCodeIdValue = $('#' + chargeCodeId).val();
							var idddd = $(item).closest('tr').find("td:eq(1)").find("input:eq(1)").attr("id");
							var currentidddd = $(item).closest('tr').find("td:eq(3)").find("input:eq(0)").attr("id");
							//alert("chargeCodeIdValue "+chargeCodeIdValue)
							if (chargeCodeId != checkCurrentRowIddd && icdValue == chargeCodeIdValue) {
								if (icdValue == chargeCodeIdValue) {
									alert("Diagnosis is already added");
									$('#' + idddd).val("");
									$('#' + currentidddd).val("");
									$('#'+ chargeCodeIdValue).val("");
									return false;
								}
							}
					else
					{	
    		 
    			 // $(item).closest('tr').find("td:eq(1)").find("input:eq(1)").val(icdValue);
    			  $(item).closest('tr').find("td:eq(2)").find("input:eq(1)").val(icdValue);
    			  $(item).closest('tr').find("td:eq(2)").find("input:eq(0)").val(icdValue);
    			 
    		  }
         			 }); 
    		  }
    	  }
     }
 }
 
 
 var total_mc_value = '';
 function fillMedicalCategoryData(val,item) {
   	  
       var index1 = val.lastIndexOf("[");
       var index2 = val.lastIndexOf("]");
       index1++;
       idMcNo = val.substring(index1, index2);
       if (idMcNo == "") {
           return;
       } else {
           obj = document.getElementById('medicalCategoryId');
           total_mc_value += val+",";
          
           obj.length = document.getElementById('medicalCategoryId').length;
           var b = "false";
           for(var i=0;i<autoMedicalCategoryData.length;i++){
        		  
        		  var mcDataVal = mcData[i].medicalCategoryCode;
        		 
        		  if(mcDataVal == idMcNo){
        			var mCategoryValue = mcData[i].medicalCategoryId;
        			$(item).closest('tr').find("td:eq(1)").find("input:eq(2)").val(mCategoryValue);
        			$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val(mCategoryValue);
        			
        			 //var countForDigi=0;
        			 /*$('#medicalCategory tr').each(function(i, el) {
        					var $tds = $(this).find('td')	

        					 var icdName = $tds.eq(0).find(":input").val();
        					var deleteIdd=$(this).closest('tr').find("td:eq(8)").find("button:eq(0)").attr("id");
        					 if(icdName!="" && deleteIdd!="" && deleteIdd!=undefined && deleteIdd.includes("deleteMC")){
        						 countForDigi=+1; 
        					 }
        		 	 });
        			 if(countForDigi!=0)*/
        				 getMedicalCategoryFinalObserb(item);
        		  }
        	  }
           if (b == "false") {
               $('#medicalCategoryId').append('<option value=' + mCategoryValue + '>' + val + '</option>');

           }
       }
   }        

 
 
 
 var MeidcalCategoryArry = new Array();
 var autoMedicalCategoryData='';
 var mcData='';
 function masMedicalCategoryList() {
 	
     var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";

     var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/getMedicalBoardAutocomplete";

     $.ajax({
         type: "POST",
         contentType: "application/json",
         url: url,
         data: JSON.stringify({
             'employeeId': '1'
         }),
         dataType: 'json',
         //timeout: 100000,

         success: function(res)

         {
             mcData = res.masMedicalCategoryList;
         	autoMedicalCategoryData=res.masMedicalCategoryList;
         	if(mcData!=null && mcData.length!=0)
             for (var i = 0; i < mcData.length; i++) {
                 var mcId = mcData[i].medicalCategoryId;
                 var mcCode = mcData[i].medicalCategoryCode;
                 var mcName = mcData[i].medicalCategoryName;
               //  var a = icdName + "[" + icdCode + "]"

                 var medicalCategoryData = mcName + "[" + mcCode + "]"
                
                 MeidcalCategoryArry.push(medicalCategoryData);
                // console.log('data :', MeidcalCategoryArry);
             }
            
             //putIcdIdValue(autoIcdList, icdData);

         },
         error: function(jqXHR, exception) {
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
 }
 
 function autoCompleteCommonMe(val,flag){
		if(flag=='1')
		autocomplete(val, arryInvestigation);
		if(flag=='5'){
			autocomplete(val, arry);
		}
		if(flag=='6'){
			autocomplete(val, MeidcalCategoryArry);
		}
		
		if(flag=='7'){
			autocomplete(val, arryNomenclature);
		}
	 }

	var today = "";
	var dateCheck = $('#investigationDate1').val();
	if (dateCheck == null || dateCheck == "") {
		$(document).ready(function() {
			today = new Date();
			var dd = String(today.getDate()).padStart(2, '0');
			var mm = String(today.getMonth() + 1).padStart(2, '0');
			var yyyy = today.getFullYear();

			//today =  yyyy + '-' + mm + '-' +dd;

			today = dd + '/' + mm + '/' + yyyy;
			//document.write(today);
			$('#investigationDate1').val(today);
		});
	}
 
 function addRowForMedicalCategory(){
	 var tbl = document.getElementById('medicalCategory');
	 var 	lastRow = tbl.rows.length;
 		i =lastRow;
   	    i++
   	    var aClone = $('#medicalCategory>tr:last').clone(true);
   	    aClone.find('img.ui-datepicker-trigger').remove();
   		aClone.find(":input").val("");
   	    aClone.find('input[type="text"]').prop('id', 'diagnosisId'+i+'');
   	    aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'medicalCategoryId'+i+'');
		aClone.find("td:eq(1)").find("input:eq(1)").prop('id', 'diagnosisiIdMC'+i+'');
		
		  aClone.find("td:eq(0)").find("div").find("div").prop('id', 'diagnosisMeDiv' + i + '');
		  aClone.find("td:eq(1)").find("div").find("div").prop('id', 'compositeCategoryForDetailDiv' + i + '');
		
		
		aClone.find("td:eq(1)").find("input:eq(2)").prop('id', 'medicalCategoryValueId'+i+'');
		aClone.find("td:eq(2)").find("select:eq(0)").prop('id', 'system'+i+'');
		aClone.find("td:eq(3)").find("select:eq(0)").prop('id', 'typeOfCategory'+i+'');
		
	 	
		aClone.find("td:eq(4)").find("input:eq(0)").prop('id', 'duration'+i+'');
	//	aClone.find("td:eq(6)").find("input:eq(0)").prop('id', 'nextcategoryDate'+i+'');
		
		aClone.find("td:eq(6)").find("input:eq(0)").prop('readonly', false);
		aClone.find("td:eq(2)").find("select:eq(0)").find("option[selected]").removeAttr('selected');
		aClone.find("td:eq(3)").find("select:eq(0)").find("option[selected]").removeAttr('selected');
   	    //aClone.find("option[selected]").removeAttr("selected")
   		aClone.find("td:eq(5)").find("input:eq(0)").prop('id', 'categoryDate'+i+'').removeClass('noFuture_date hasDatepicker').addClass('noFuture_date');
   		aClone.find("td:eq(6)").find("input:eq(0)").prop('id', 'nextcategoryDate'+i+'').removeClass('noFuture_date hasDatepicker').addClass('noFuture_date');
   		
   	 var	medicalCategoryAdd ='';
   	medicalCategoryAdd +='<button type="button" name="delete" value="" id="deleteMC'+i+'"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" onclick="removeRowMedicalCategory(this);"></button>';
   	aClone.find("td:eq(8)").html(medicalCategoryAdd);
   	aClone.clone(true).appendTo('#medicalCategory');
   	 
   	var countForCategory=$('#countForCategory').val();
   	countForCategory++;
   	$('#countForCategory').val(countForCategory);
   }
 
 function removeRowMedicalCategory(val){
	 var tbl = document.getElementById('medicalCategory');
		var lastRow = tbl.rows.length;
	 if(lastRow>1){
		$(val).closest('tr').remove();
	 }
	}
 
 
 var investigationGridValue = "investigationGrid";
	var investigationData = '';
	var finalObersationDetail="";	
	//USed for FinalObservation
	var msgOfMedicalCatName="";
	var msgOfSystem="";
	var msgOfTypeOfMedCat="";
	var msgOfICDDiagnosis="";
	var msgOfCatdate="";
	var msgOfNextCategoryDate="";
	var durationF="";
	var  msgForFitIn="";
	function getMBPreAssesDetailsData() {
		var saveDraftVal=$('#saveInDraft').val();
		investigationGridValue = "investigationGrid";
		var visitId = $('#visitId').val();
		var patientId=$('#patientId').val();
		var pathname = window.location.pathname;
        var accessGroup = "MMUWeb";
		 var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/getMBMedicalCategory";
		
		var data = {
			"visitId" : visitId,
			"patientId":patientId,
			"flagForMe":"me"
		};
		$.ajax({
					type : "POST",
					contentType : "application/json",
					url : url,
					data : JSON.stringify(data),
					dataType : "json",
					// cache: false,
					success : function(response) {
					var datas = response.data;
					var trHTML = '';
					var i=0;
					var categoryType="";	
					var diasableValue="disabled";
					var disableForAddButton="";
					 var approvalFlag=$('#approvalFlag').val();
					 var approvalFlagDiasable="";
					 if(approvalFlag!="" && approvalFlag!=undefined && approvalFlag!=null && approvalFlag=='y'|| (saveDraftVal!="" && (saveDraftVal=='ea'||saveDraftVal=='ej')
							 || (saveDraftVal=='draftRMo' || saveDraftVal=='draftPRMo')
				 			 ||(saveDraftVal=='draftRMo18' || saveDraftVal=='draftPRMo18')||(saveDraftVal=='draftRMo3A' || saveDraftVal=='draftPRMo3A'))){
						 approvalFlagDiasable='readonly';
						 disableForAddButton="disabled";
					 }
					 else{
						 approvalFlagDiasable="";
						 disableForAddButton="";
					 }
					var countForSystem=0;
				if(datas!=undefined && datas.length>=1 ){
						
					var medicalCategoryCount=datas.length;
					$.each(datas, function(i, item) {
		
						if(item.system!=null && item.system!=""){
							countForSystem++;
						    //var investigationName=item.inveName;
							var icdName="";
							if(item.icdName!="")
							icdName=item.icdName;
							
							var system="";
							if(item.system!="")
							system=item.system;
							
							var medicalCategory="";
							if(item.medicalCategory!="")
							medicalCategory=item.medicalCategory;
							if(item.categoryType!="")
							  categoryType=item.categoryType;
							var categoryDate="";
							if(item.categoryDate!="")
							 categoryDate=item.categoryDate;
							
							var duration=""; 
							if(item.duration!="")
							duration=item.duration;
							
							var nextCategoryDate="";
							if(item.nextCategoryDate!="")
							nextCategoryDate=item.nextCategoryDate;
						
							var patientMedicalCategoryId=""; 
							if(item.patientMedicalCategoryId!="")
							patientMedicalCategoryId=item.patientMedicalCategoryId;
						
							var diagnosisId="";
							if(item.diagnosisId!="")
							diagnosisId=item.diagnosisId;
							
							 var medicalCategoryId="";
							 if(item.medicalCategoryId!="")
							medicalCategoryId=item.medicalCategoryId;
							
							if(icdName!=""){
								msgOfICDDiagnosis=icdName;
							}
							if(medicalCategory!=""){
								msgOfMedicalCatName=medicalCategory;
							}
							
							if(system!=undefined && system!="")
								msgOfSystem=system;
							
							var dateOfOrigin="";
							var placeOfOrigin="";
							if(item.dateOfOrigin!=null && item.dateOfOrigin!=null && item.dateOfOrigin!=undefined){
								dateOfOrigin=item.dateOfOrigin;
							}
							if(item.placeOfOrigin!=null && item.placeOfOrigin!=null && item.placeOfOrigin!=undefined){
								placeOfOrigin=item.placeOfOrigin;
							}
							
							
							if(categoryType!=undefined && categoryType!=""){
							if(categoryType=='T'){
								msgOfTypeOfMedCat=" "+"T" ;
							}else{
								msgOfTypeOfMedCat=" "+"Pmt" ;
							}
					
							if(duration!=""){
								durationF=duration;
							}	
							if(categoryDate!=""){
								msgOfCatdate=categoryDate;
							}
							
							if(nextCategoryDate!=""){
								msgOfNextCategoryDate=nextCategoryDate;
							}
							var  msgOfFinalObservationValue=resourceJSON.msgOfFinalObservation;
							var updateMsgOfFinalObservationValue="";
							
							if(msgOfFinalObservationValue!="" ){
								updateMsgOfFinalObservationValue = msgOfFinalObservationValue.replace("<< Medical cat name>>", "<b>"+msgOfMedicalCatName+"</b>");
								updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<system>>", "<b>("+msgOfSystem+")</b>");
								updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<type of med cat>>", "<b>"+msgOfTypeOfMedCat+"</b>");
								updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<duration>>",  "<b>"+durationF+"</b>");
								updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<ICD Diagnosis>>", "<b>"+msgOfICDDiagnosis+"</b>");
								updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<cat date>>", "<b>"+msgOfCatdate+"</b>" );
								updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<Next category date>>", "<b>"+msgOfNextCategoryDate+"</b>" );
								finalObersationDetail+=	"<br>"+updateMsgOfFinalObservationValue;
							}
							
							}
							if(icdName!=undefined && icdName!="" )
							msgOfICDDiagnosis+=" "+icdName;
							if(categoryDate!=undefined && categoryDate!="")
							msgOfCatdate+=" "+categoryDate;
							if(nextCategoryDate!=undefined && nextCategoryDate!="")
								msgOfNextCategoryDate+=" "+nextCategoryDate;
							if(icdName!=null && icdName!=undefined)
							{
								
								trHTML+='<tr>';
								trHTML+=' <td>';
								func1='fillDiagnosisComboMedCatMe';
					    		 url1='opd';
					    		 url2='getIcdListByName';
					    		 flaga='diagnosisMe';
							
								trHTML+=' <div class="autocomplete forTableResp">';
								//trHTML+='<input type="text" class="form-control" '+approvalFlagDiasable+' name="diagnosisId" id="diagnosisId'+i+'" onblur="fillDiagnosisCombo(this.value,this);" onKeyPress="autoCompleteCommonMe(this,5);" onKeyUp="autoCompleteCommonMe(this,5);"placeholder="Diagnosis" value="'+icdName+'" />';
								trHTML+='<input type="text" class="form-control" '+approvalFlagDiasable+' name="diagnosisId" id="diagnosisId'+i+'"  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" placeholder="Diagnosis" value="'+icdName+'" />';
								trHTML+='<div id="diagnosisMeDiv'+i+'" class="autocomplete-itemsNew"></div>';
								trHTML+='</div>';
								trHTML+=' </td>	';
								
								func1='fillMedicalCategoryDataMe';
					    		 url1='medicalBoard';
					    		 url2='getMedicalBoardAutocomplete';
					    		 flaga='compositeCategory';
							
								trHTML+='  <td>';
								trHTML+=' <div class="autocomplete forTableResp">';
								//trHTML+='<input type="text" id="medicalCategoryId" onblur="fillMedicalCategoryData(this.value,this);" '+approvalFlagDiasable+' value="'+medicalCategory+'" onKeyPress="autoCompleteCommonMe(this,6);"  onKeyUp="autoCompleteCommonMe(this,6);" class="form-control">';
								trHTML+='<input type="text" id="medicalCategoryId"   '+approvalFlagDiasable+' value="'+medicalCategory+'"onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"  class="form-control">';
								trHTML+='<input type="hidden" id="diagnosisiIdMC" name="diagnosisiIdMC" value="'+diagnosisId+'"/>';
								trHTML+='<input type="hidden" id="medicalCategoryValueId" name="medicalCategoryValueId" value="'+medicalCategoryId+'"/>';
								trHTML+='<input type="hidden" id="patientMedicalCatId" name="patientMedicalCatId" value="'+patientMedicalCategoryId+'"/>';
								trHTML+='<input type="hidden" name="dateOfOrigin" id="dateOfOrigin'+i+'" class="form-control" value="'+dateOfOrigin+'"/>';
								trHTML+='<input type="hidden" name="placeOfOrigin" id="placeOfOrigin'+i+'" class="form-control" value="'+placeOfOrigin+'"/>';
								trHTML+='<div id="compositeCategoryForDetailDiv'+i+'" class="autocomplete-itemsNew"></div>';
								trHTML+='</div> ';
								trHTML+='</td>';
								var systemArrary = ["S","H","A","P","E"]; 
								trHTML+=' <td>';
								trHTML+='<select class="form-control" name=system id="system'+i+'" '+approvalFlagDiasable+'>';
								trHTML+='<option value="0">Select</option>';
								for(var j=0;j<systemArrary.length;j++){
									var systemSelectedVal="";
									if(systemArrary[j]==system){
										systemSelectedVal='selected';
									}
									else{
										systemSelectedVal="";
									}
									trHTML+='<option '+systemSelectedVal+' value='+systemArrary[j]+'>'+systemArrary[j]+'</option>';
								}
								trHTML+='</select>';
								trHTML+='</td>';
								
								
								
								trHTML+=' <td>';
								trHTML+='<select class="form-control" name=typeOfCategory id="typeOfCategory'+i+'" onchange="getdurationByType(this);" '+approvalFlagDiasable+'>';
								
								trHTML+='<option value="0">Select</option>';
								if(categoryType!=null || categoryType!=""){
									var cateValue;
									var catetypeVal;
									for(var k=0;k<2;k++){
									var selectValue=""
									if(categoryType=='T'){
										selectValue='selected';
										cateValue='Temporary(Week)';
										catetypeVal='T';
										categoryType='';
										
									}
									else if(categoryType=='P'){
										selectValue='selected';
										cateValue='Permanent(Month)';
										catetypeVal='P';
										categoryType='';
									}
									else{
										var count=0;
										if(cateValue=='Temporary(Week)' && count=='0'){
											cateValue='Permanent(Month)';
											catetypeVal='P';
											count++;
										} 
										if(cateValue=='Permanent(Month)' && count=='0'){
											cateValue='Temporary(Week)';
											catetypeVal='T';
											count++;
										}
										selectValue='';
									}
									trHTML+='<option '+selectValue+' value='+catetypeVal+'>'+cateValue+'</option>';
								}
								}
								else{
									
									trHTML+='<option value="T">Temporary(Week)</option>';
									trHTML+='<option value="P">Permanent(Month)</option>';
								}	
								trHTML+='</select>';
								trHTML+='</td>';
								
								trHTML+='<td>';
								trHTML+='<input type="text" '+approvalFlagDiasable+' name="duration" id="duration'+i+'" value="'+duration+'" onblur="return generateNextDate(this);" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control"> </td>';
								trHTML+='</td>';
								
								trHTML+='<td>';
								trHTML+='<div class="dateHolder">';
								trHTML+=' <input type="text" '+approvalFlagDiasable+' id="categoryDate'+i+'" ';
								trHTML+=' name="categoryDate" class="noFuture_date5 form-control" ';
								trHTML+=' placeholder="DD/MM/YYYY" value="'+categoryDate+'" maxlength="10" />';
								trHTML+='  </div>';
								trHTML+='  </td>';
								
								trHTML+='<td>';
								trHTML+='   <div class="dateHolder">';
								trHTML+=' <input type="text" '+approvalFlagDiasable+' id="nextcategoryDate'+i+'" name="nextcategoryDate" class="form-control" placeholder="DD/MM/YYYY" value="'+nextCategoryDate+'" maxlength="10" readonly/>';
								trHTML+=' </div>';
								trHTML+='  </td>';
								
								trHTML+=' <td>';
								trHTML+='<button type="button"  name="addCategorywww" id="addCategorywww'+i+'" '+disableForAddButton+' class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForMedicalCategory();"></button>';
								trHTML+=' </td>';
								trHTML+=' <td>';
								trHTML+=' <button type="button" name="delete" value="" id="deleteMedCat'+i+'" '+diasableValue+' class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"  onclick="removeRowMedicalCategory(this)"></button>';
								trHTML+=' </td>';	
							i++;
							}
						}
						
						
						});
					}
				 
					if(trHTML!="" && trHTML!=null &&  countForSystem!=0){
						$("#medicalCategory tr").remove();
						$('#medicalCategory').append(trHTML);
					}
					
					var saveInDraft=$('#saveInDraft').val();
					   msgForFitIn=resourceJSON.msgForFitIn;
					
						//if(document.getElementById('fitInChk').checked=true){
							
							var countForCategory=$('#countForCategory').val();
							var medicalCompositeName=$('#medicalCompositeName').val();
						 
							if(countForCategory>='2'|| medicalCategoryCount>='2'){
								var  msgForFit=resourceJSON.msgForFitIn;
								var finalObservationForCategory='';
								if(medicalCompositeName!=""){
								var medicalCompositeDate=$('#medicalCompositeDate').val();
								finalObersationDetail =  medicalCompositeName+"  "+medicalCompositeDate;
							 	}
								}
							/*}
							else{
								alert("Patient is already in Fit Category.");
							}*/
						
					   
					if(saveInDraft=='draftMo' || saveInDraft=='draftMo18' ||  saveInDraft=='draftMo3A'){
						msgForFitIn+=finalObersationDetail;
						$('#finalObservationMoJ').jqteVal(msgForFitIn);
					 	
						if(finalObservationOfMo!="" && finalObservationOfMo!=null){
						$('#finalObservationMoJ').jqteVal(finalObservationOfMo);
						}
					 
					}
					
					if(saveInDraft=='draftRMo' || saveInDraft=='draftRMo18' || saveInDraft=='draftRMo3A'){
						msgForFitIn+=finalObersationDetail;
						$('#finalObservationRmoJ').jqteVal(msgForFitIn);
						
						if(finalObservationOfMo!="" && finalObservationOfMo!=null){
							$('#finalObservationMoJ').jqteVal(finalObservationOfMo);
						}
					 	if(finalObservationOfRMo!="" && finalObservationOfRMo!=null){
							$('#finalObservationRmoJ').jqteVal(finalObservationOfRMo);
						}
					 	
						}
					if(saveInDraft=='draftPRMo' || saveInDraft=='draftPRMo18' || saveInDraft=='draftPRMo3A'){
						msgForFitIn+=finalObersationDetail;
						$('#finalObservationPRmoJ').jqteVal(msgForFitIn);
						
						if(finalObservationOfMo!="" && finalObservationOfMo!=null){
							$('#finalObservationMoJ').jqteVal(finalObservationOfMo);
						}
					 	
						if(finalObservationOfRMo!="" && finalObservationOfRMo!=null){
							$('#finalObservationRmoJ').jqteVal(finalObservationOfRMo);
						}
					 	if(finalObservationOfPRMo!="" && finalObservationOfPRMo!=null){
					 		$('#finalObservationPRmoJ').jqteVal(finalObservationOfPRMo);
						}
					 	
						}
					if(approvalFlag!="" && approvalFlag!=undefined && approvalFlag!=null && approvalFlag=='y'){
					$("#finalObservationMoJ").find(".jqte_editor").attr("contenteditable","false");
					 
					$("#finalObservationRmoJ").find(".jqte_editor").attr("contenteditable","false");
					$("#finalObservationPRmoJ").find(".jqte_editor").attr("contenteditable","false");
					}
					
					}
	    });
		}
	var unitDetailData='';
	var unitGloblaData='';
 function getUnitDetail(){
	 
	 var approvalFlag=$('#approvalFlag').val();
	 var approvalFlagDiasable="";
	 if(approvalFlag!="" && approvalFlag!=undefined && approvalFlag!=null && approvalFlag=='y'){
		 approvalFlagDiasable='disabled';
	 }
	 else{
		 approvalFlagDiasable="";
	 }
	 var  hospitalId=$('#hospitalId').val();
	 var visitId=$('#visitId').val();
	 var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";
	 var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalexam/getUnitDetail";
	 
	 var data = {
				"visitId" : visitId,
				"hospitalId":hospitalId
			};
	 $.ajax({
			type : "POST",
			contentType : "application/json",
			url : url,
			data : JSON.stringify(data),
			dataType : "json",
			// cache: false,

			success : function(response) {
			var data = response.dataMasHospital;
			unitGloblaData=data;
	 
		unitDetailData += '<select name="forwardTo" class="form-control" id="forwardTo" class="medium" onChange="return getMasDesignationMappingByUnitId()  ;" '+approvalFlagDiasable+'>';
	unitDetailData += '<option value="0"><strong>Select</strong></option>';
	if (data != undefined && data.length != 0) {
			for (var i = 0; i < data.length; i++) {	
	unitDetailData += '<option   value="' + data[i].hospitalId + '">'
				+ data[i].hospitalName + '</option>';
			}
	}
	unitDetailData += '</select>';
	 $('#forwardTo').html(unitDetailData);
			}
	 });
	 
 }
 

 function generateNextDate(item) {
	 
	  var carrentDateIdValue=$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").val();
	  var durationValue=$(item).closest('tr').find("td:eq(4)").find("input:eq(0)").val();
	  var nextCategoryDateId=$(item).closest('tr').find("td:eq(6)").find("input:eq(0)").attr("id");
	  if(carrentDateIdValue==null || carrentDateIdValue==""){
		  //alert("Please enter  current Date.");
			return false;
	  	}
	var currentDateVal=carrentDateIdValue.split("/");
	var date=currentDateVal[0];
	var month=currentDateVal[1];
	var year=currentDateVal[2];
	if(durationValue==null || durationValue==""){
		alert("Please enter  duration");
		return false;
	}
	
	 var typeOfCategoryValueId=$(item).closest('tr').find("td:eq(3)").find("select:eq(0)").attr("id");
	 var typeOfCategoryValue=$("#"+typeOfCategoryValueId+" option:selected" ).val();
	
	 
	 if(typeOfCategoryValue=="0"){
			alert("Please select  Type of Category.");
			 var categoryDateForCheck=$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
			  $("#"+categoryDateForCheck).val('');
			return false;
		}	 
	 
var monthNew ="";	
if(typeOfCategoryValue!=""&& typeOfCategoryValue!="0" && typeOfCategoryValue=='T'){
	var newDays=(parseInt(date)+(parseInt(durationValue)*7));
	if(newDays>=30){
		  var remDayNew= parseInt(newDays)%30;
		  var  coMonthNew= parseInt(newDays)/30;
		 
		     coMonthNew=  Math.floor(parseInt(coMonthNew));
		     monthNew=parseInt(month)+parseInt(coMonthNew);
		     date=remDayNew;
		     
	}
	else{
		date=newDays;
		monthNew= month;
	}
}
else{
	  //monthNew =parseInt(month)+parseInt(durationValue);	
	monthNew =parseInt(durationValue);	
}
 
var dateNext="";
var yearNew;
var remMonthNew;
var  coYearNew;
	if(monthNew>12){
		 var remMonthNew="";
		if(typeOfCategoryValue!=""&& typeOfCategoryValue!="0" && typeOfCategoryValue=='T'){
	     remMonthNew= parseInt(monthNew)%12;
		}
		else{
			remMonthNew= 	month;
		}
	  var  coYearNew= parseInt(monthNew)/12;
	 
	   coYearNew=  Math.floor(parseInt(coYearNew));
	   year=parseInt(year)+parseInt(coYearNew);
	   if(date!=null && date!="" && date.toString().length==1)
	     {
	    	 date="0"+date;
	     }
	     if(remMonthNew!=null && remMonthNew!="" && remMonthNew.toString().length==1){
	    	 remMonthNew="0"+remMonthNew;
	     }
	   dateNext=date+"/"+remMonthNew+"/"+year;
	}
	else{
		
		 if(date!=null && date!="" && date.toString().length==1)
	     {
	    	 date="0"+date;
	     }
	     if(monthNew!=null && monthNew!="" && monthNew.toString().length==1){
	    	 monthNew="0"+monthNew;
	     }
	  
		 dateNext=date+"/"+monthNew+"/"+year;
	}
 $('#'+nextCategoryDateId).val(dateNext);
 //$('#'+nextCategoryDateId).attr('readonly', true); 
	}
 
 
 
 function getSelectedUnitData(hospitalIdVal){
	 
	 var approvalFlag=$('#approvalFlag').val();
	 var approvalFlagDiasable="";
	 if(approvalFlag!="" && approvalFlag!=undefined && approvalFlag!=null && approvalFlag=='y'){
		 approvalFlagDiasable='disabled';
	 }
	 else{
		 approvalFlagDiasable="";
	 }
	 var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";
	 var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalexam/getUnitDetail";
	 var unitDetailData='';
	 var  hospitalId=$('#hospitalId').val();
	 var visitId=$('#visitId').val();
	 var data = {
				"visitId" : visitId,
				"hospitalId":hospitalId
			};
	 $.ajax({
			type : "POST",
			contentType : "application/json",
			url : 'getUnitDetail',
			data : JSON.stringify(data),
			dataType : "json",
			// cache: false,

			success : function(response) {
			var unitGloblaData = response.dataMasHospital;
			 unitDetailData += '<select name="forwardTo" class="form-control" id="forwardTo" class="medium" onChange="return getMasDesignationMappingByUnitId();" '+approvalFlagDiasable+'>';
				unitDetailData += '<option value="0"><strong>Select</strong></option>';
				if (unitGloblaData != undefined && unitGloblaData.length != 0) {
					var selectedUnit='';	
					for (var i = 0; i < unitGloblaData.length; i++) {	
							
							if(unitGloblaData[i].hospitalId==hospitalIdVal){
								selectedUnit='selected';
							}
							else{
								selectedUnit='';
							}
							
				unitDetailData += '<option  '+selectedUnit+' value="' + unitGloblaData[i].hospitalId + '">'
							+ unitGloblaData[i].hospitalName + '</option>';
						}
				}
				unitDetailData += '</select>';
				 $('#forwardTo').html(unitDetailData);
				 $('#forwardStatus').show()	
			
			}
	 });
	 getMasDesignationMappingByUnitIdByHospitalIdAndDesig(hospitalIdVal);	 
 }
	 
 
 function calculateWHR(){
	 var waist=0
	 var hip=0;
	 if($('#waist').val()!=null)
	 waist=$('#waist').val();
	 if($('#hip').val()!=null && $('#hip').val()!='')
	  hip=$('#hip').val();
	 var finalValue=(parseInt(waist)+parseInt(hip))/2;
	 $('#whr').val(finalValue);
 }
 
 
 function calculateDentalPointAndDefectiveTeeth(){
	  var totalNoOfTeath=$('#totalNoOfTeath').val();
	  var totalNoOfDefective=$('#totalNoOfDefective').val();
	  var totalNoOfDentalPoints=$('#totalNoOfDentalPoints').val();
	  if( parseInt(totalNoOfDefective) >  parseInt(totalNoOfTeath)){
		  alert("Total No. of Defective Teeth should not greater than Total No. of Teeth.");
		  $('#totalNoOfDefective').val('');
		  return false;
	  }
	  if( parseInt(totalNoOfDentalPoints) >  parseInt(totalNoOfTeath)){
		  alert("Total No. of Dental Points  should not greater then Total No. of Teeth");
		  $('#totalNoOfDentalPoints').val('');
	  return false;
	  }
	  return true;
 }
 
 
 
 
 
 
 function addImmunisationStatus(){
	 var tbl = document.getElementById('immunisationStatusGrid');
  	lastRow = tbl.rows.length;
  	i =lastRow;
  	i++;
  
	    var aClone = $('#immunisationStatusGrid>tr:last').clone(true);
	    aClone.find('img.ui-datepicker-trigger').remove();
		aClone.find("td:eq(0)").find("input:eq(0)").removeAttr("readonly");
		aClone.find(":input").val("");
		aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'immunisatioName'+i+'');
		aClone.find("td:eq(0)").find("input:eq(0)").prop('name', 'immunisatioName');
		aClone.find("td:eq(0)").find("input:eq(1)").prop('id', 'immunisationId'+i+'');
		aClone.find("td:eq(0)").find("input:eq(2)").prop('id', 'pvmsNumber'+i+'');
		aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'durationImmu'+i+'');
		aClone.find("td:eq(0)").find("div").find("div").prop('id', 'immunizationDiv' + i + '');
		aClone.find("td:eq(2)").find("input:eq(0)").prop('readonly', false);
		
		aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'immnunizationDate'+i+'').removeClass('noFuture_date hasDatepicker').addClass('noFuture_date');
		aClone.find("td:eq(3)").find("input:eq(0)").prop('id', 'nextDueImmu'+i+'').removeClass('noFuture_date6 hasDatepicker').addClass('noFuture_date');
	//	aClone.find("td:eq(1)").find("input:eq(0)").prop('name', 'immnunizationDate').addClass('form-control noFuture_date hasDatepicker');
		var immunizationRemoveButton="";
		immunizationRemoveButton +='<button type="button" name="delete" value="" id="newImmunizationDelete'+i+'"  class="buttonDel btn btn-danger noMinWidth" button-type="delete"  onclick="removeRowImmunization(this);"></button>';
	   	aClone.find("td:eq(5)").html(immunizationRemoveButton);
		aClone.clone(true).appendTo('#immunisationStatusGrid');
		$('#immunisationStatusGrid>tr:last').find("td:eq(5)").find("button:eq(0)").attr("id","newIdImmunization");
		
	} 
 
 function showLiverPalpableValue(idSelect){
	 var selectObj = idSelect.id;
	 var selectedValue=$( "#"+selectObj+" option:selected" ).text();
	 if(selectedValue!=null && selectedValue!=""){
			if (selectedValue=='Yes') {
					$('#liverPalpableInput').show();
			}
				else{
					$('#liverPalpableInput').hide();
				}
				 
		}
 }
 
 function showLiverPalpableValue1(idSelect){
	 var selectObj = idSelect.id;
	 var selectedValue=$( "#"+selectObj+" option:selected" ).text();
	 if(selectedValue!=null && selectedValue!=""){
			if (selectedValue=='Yes') {
					$('#spleenPalpableInput').show();
			}
				else{
					$('#spleenPalpableInput').hide();
					 
				}
				 
			}
 }
 
 
 
 function displayTextArea(idSelect){
	 var selectObj = idSelect.id;
	 var selectedValue=$( "#"+selectObj+" option:selected" ).text();
	 if(selectedValue!=null && selectedValue!=""){
			if (selectedValue=='Others') {
					$('#audiometryRecordForDisplay').show();
			}
				else{
					$('#audiometryRecordForDisplay').hide();
					 
				}
				 
			}
 }
 
 
 function validateMedicalExamForm(){
	//Present Medical Category 
	/*var medicalCompositeName =$('#medicalCompositeName').val();
	var medicalCompositeDate =$('#medicalCompositeDate').val();
	if(medicalCompositeName==''){
		alert("Please enter Medical Category.");
		showhide('button12');
		$('#medicalCompositeName').focus();
		
		return false;
	} 
	if(medicalCompositeDate==''){
		alert("Please enter Medical Category Date.");
		showhide('button12');
		$('#medicalCompositeDate').focus();
		return false;
	}*/ 
	
	//Dental Validation
	var totalNoOfTeath=$('#totalNoOfTeath').val();
	if(totalNoOfTeath==''){
		alert("Please enter Total No. of Teeth.");
		//showhide('button1');
		$('#totalNoOfTeath').focus();
		
		return false;
	}
	
	/*var totalNoOfDefective=$('#totalNoOfDefective').val();
	if(totalNoOfDefective==''){
		alert("Please enter Total No. of Defective Teeth.");
		showhide('button1');
		$('#totalNoOfDefective').focus();
		return false;
	}
	*/
/*	var totalNoOfDentalPoints=$('#totalNoOfDentalPoints').val();
	if(totalNoOfDentalPoints==''){
		alert("Please enter Total No. of Dental Points.");
		showhide('button1');
		$('#totalNoOfDentalPoints').focus();
		return false;
	}
	*/
	
	var conditionOfGums=$('#conditionOfGums').val();
	if(conditionOfGums==''){
		alert("Please enter Condition of Gums.");
		//showhide('button1');
		$('#conditionOfGums').focus();
		return false;
	}
	
	
/*	var missing=$('#missing').val();
	if(missing=='' || missing==0){
		alert("Please enter Missing.");
		showhide('button1');
		$('#missing').focus();
		return false;
	}*/
	
	
	/*var unSavable=$('#unSavable').val();
	if(unSavable=='' || unSavable==0){
		alert("Please enter UnSavable.");
		showhide('button1');
		$('#unSavable').focus();
		return false;
	}*/
	
	var dentalOffier=$('#dentalOffier').val();
	if(dentalOffier==''){
		alert("Please enter Dental Officer.");
		//showhide('button1');
		$('#dentalOffier').focus();
		return false;
	}
	
 
	var checkupDate=$('#checkupDate').val();
	if(checkupDate==''){
		alert("Please enter Checkup Date.");
		//showhide('button1');
		$('#checkupDate').focus();
		return false;
	}
	var remarks=$('#remarks').val();
	if(remarks==''){
		alert("Please enter remarks.");
		//showhide('button1');
		$('#remarks').focus();
		return false;
	}
	//Physical Capacity
	
	var height=$('#height').val();
	if(height==''){
		alert("Please enter Height.");
		//showhide('button2');
		$('#height').focus();
		return false;
	}
	
	
	var weight=$('#weight').val();
	if(weight==''){
		alert("Please enter Weight Actual.");
		//showhide('button2');
		$('#weight').focus();
		return false;
	}
	
	
	
	
	var idealWeight=$('#idealWeight').val();
	if(idealWeight==''){
		alert("Please enter Ideal Wt.");
		//showhide('button2');
		$('#idealWeight').focus();
		return false;
	}
	
	var waist=$('#waist').val();
	if(waist==''){
		alert("Please enter Waist.");
		//showhide('button2');
		$('#waist').focus();
		return false;
	}
	
	var chestFullExpansion=$('#chestFullExpansion').val();
	if(chestFullExpansion==''){
		alert("Please enter Chest Full Expansion.");
		//showhide('button2');
		$('#chestFullExpansion').focus();
		return false;
	}
	
	var rangeOfExpansion=$('#rangeOfExpansion').val();
	if(rangeOfExpansion==''){
		alert("Please enter Range of Expansion.");
		//showhide('button2');
		$('#rangeOfExpansion').focus();
		return false;
	}
	
	var pulse=$('#pulse').val();
	if(pulse==''){
		alert("Please enter Pulse.");
		//showhide('button6');
		$('#pulse').focus();
		
		return false;
	}
	
	var bp=$('#bp').val();
	if(bp==''){
		alert("Please enter BP.");
		//showhide('button6');
		$('#bp').focus();
		return false;
	}
	
	var bp1=$('#bp1').val();
	if(bp1==''){
		alert("Please enter DBP.");
		//showhide('button6');
		$('#bp1').focus();
		return false;
	}
	
	var peripheralPulsations=$('#peripheralPulsations').val();
	if(peripheralPulsations==''){
		alert("Please enter Peripheral Pulsations.");
		//showhide('button6');
		$('#peripheralPulsations').focus();
		return false;
	}
	
	var heartSize=$('#heartSize').val();
	if(heartSize==''){
		alert("Please enter Heart Size.");
		//showhide('button6');
		$('#heartSize').focus();
		return false;
	}
	
	var sounds=$('#sounds').val();
	if(sounds==''){
		alert("Please enter Sounds.");
		//showhide('button6');
		$('#sounds').focus();
		return false;
	}
	var rhythm=$('#rhythm').val();
	if(rhythm==''){
		alert("Please enter Rhythm.");
		//showhide('button6');
		$('#rhythm').focus();
		return false;
	}
	//Respiratory System
	var respiratorySystem=$('#respiratorySystem').val();
	if(respiratorySystem==''){
		alert("Please enter Respiratory System.");
		//showhide('button7');
		$('#respiratorySystem').focus();
		
		return false;
	}
	
	var respiratorySystem=$('#respiratorySystem').val();
	if(respiratorySystem==''){
		alert("Please enter Respiratory System.");
		//showhide('button8');
		$('#respiratorySystem').focus();
		return false;
	}
	
	 var selectedValue=$("#liverPalpable option:selected" ).text();
	 
	 if(selectedValue=='Select'){
		alert("Please Select Liver Palpable.");
		//showhide('button8');
		$('#liverPalpable').focus();
		return false;
	 }
		if(selectedValue=='Yes'){
		if($('#liver').val()==''){
			alert("Please enter Liver Palpable.");
			//showhide('button8');
			$('#liver').focus();
			return false;
		}
		
	 }
	
	 
	 
	 var selectedValueSpleenPalpable=$("#spleenPalpable  option:selected" ).text();
	 if(selectedValueSpleenPalpable=='Select'){
		 alert("Please Select Spleen Palpable.");
		 //showhide('button8');
			$('#spleenPalpable').focus();
		 return false;
	 }
	 if(selectedValueSpleenPalpable=='Yes'){
	if($('#spleen').val()==''){
		alert("Please enter Spleen Palpable.");
		//showhide('button8');
		$('#spleen').focus();
		return false;
	}
}
	 //Central Nervous System
	 
	 var higherMentalFunction=$('#higherMentalFunction').val();
		if(higherMentalFunction==''){
			alert("Please enter Higher Mental Function.");
			//showhide('button9');
			$('#higherMentalFunction').focus();
			
			return false;
		} 
		var speech=$('#speech').val();
		if(speech==''){
			alert("Please enter Speech.");
			//showhide('button9');
			$('#speech').focus();
			return false;
		} 
	 
		var reflexes=$('#reflexes').val();
		if(reflexes==''){
			alert("Please enter Reflexes.");
			//showhide('button9');
			$('#reflexes').focus();
			return false;
		} 
		
		
	 
		
		 var tremors=$("#tremors  option:selected" ).text();
		 if(tremors=='Select'){
			alert("Please Select Termors.");
			//showhide('button9');
			$('#tremors').focus();
			return false;
		 }
		
		

		 var selfBalancingTest=$("#selfBalancingTest  option:selected" ).text();
		 if(selfBalancingTest=='Select'){
			alert("Please Select Self Balancing Test.");
			//showhide('button9');
			$('#selfBalancingTest').focus();
			return false;
		 }
		//Other
		 
			var locomotorSystem=$('#locomotorSystem').val();
			if(locomotorSystem==''){
				alert("Please enter Locomotor System.");
				//showhide('button10');
				$('#locomotorSystem').focus();
				return false;
			} 
			
			var spine=$('#spine').val();
			if(spine==''){
				alert("Please enter Spine.");
				//showhide('button10');
				$('#spine').focus();
				return false;
			} 
		 

			var hernia=$('#hernia').val();
			if(hernia==''){
				alert("Please enter Hernia.");
				//showhide('button10');
				$('#hernia').focus();
				return false;
			} 
		 
			
			var hydrocele=$('#hydrocele').val();
			if(hydrocele==''){
				alert("Please enter Hydrocele.");
				//showhide('button10');
				$('#hydrocele').focus();
				return false;
			} 
			
			
			var haemorrhoids=$('#haemorrhoids').val();
			if(haemorrhoids==''){
				alert("Please enter Haemorrhoids.");
				//showhide('button10');
				$('#haemorrhoids').focus();
				return false;
			} 
			
			
			//Vision
			
			
			
			 var distantWithoutGlasses=$("#distantWithoutGlasses  option:selected" ).text();
			 if(distantWithoutGlasses=='Select'){
				alert("Please Select Distant Vision of without right glasses.");
				//showhide('button3');
				$('#distantWithoutGlasses').focus();
				return false;
			 }
			 
			 var distantWithoutGlassesL=$("#distantWithoutGlassesL  option:selected" ).text();
			 if(distantWithoutGlassesL=='Select'){
				alert("Please Select Distant Vision of without left glasses.");
				//showhide('button3');
				$('#distantWithoutGlassesL').focus();
				return false;
			 }
			 
			 
			 var nearWithoutGlasses=$("#nearWithoutGlasses  option:selected" ).text();
			 if(nearWithoutGlasses=='Select'){
				alert("Please Select Near Vision of without right glasses.");
				//showhide('button3');
				$('#nearWithoutGlasses').focus();
				return false;
			 }
			
			 var nearWithoutGlassesL=$("#nearWithoutGlassesL  option:selected" ).text();
			 if(nearWithoutGlassesL=='Select'){
				alert("Please Select Near Vision of without left glasses.");
				//showhide('button3');
				$('#nearWithoutGlassesL').focus();
				return false;
			 }
			 
			 
			 var distantWithGlasses=$("#distantWithGlasses  option:selected" ).text();
			 if(distantWithGlasses=='Select'){
				alert("Please Select Distant Vision of with  right glasses.");
				//showhide('button3');
				$('#distantWithGlasses').focus();
				return false;
			 }
		
			 var distantWithGlassesL=$("#distantWithGlassesL  option:selected" ).text();
			 if(distantWithGlassesL=='Select'){
				alert("Please Select Distant Vision of with left glasses.");
				//showhide('button3');
				$('#distantWithGlassesL').focus();
				return false;
			 }
			 
			 
			 var nearWithGlasses=$("#nearWithGlasses  option:selected" ).text();
			 if(nearWithGlasses=='Select'){
				alert("Please Select Near Vision of with right glasses.");
				//showhide('button3');
				$('#nearWithGlasses').focus();
				return false;
			 }
			 
			 var nearWithGlassesL=$("#nearWithGlassesL  option:selected" ).text();
			 if(nearWithGlassesL=='Select'){
				alert("Please Select Near Vision of with left glasses.");
				//showhide('button3');
				$('#nearWithGlassesL').focus();
				return false;
			 }
			 
			 
			 var cpWithoutGlasses=$("#cpWithoutGlasses  option:selected" ).text();
			 if(cpWithoutGlasses=='Select'){
				alert("Please Select CP.");
				//showhide('button3');
				$('#cpWithoutGlasses').focus();
				return false;
			 }
			 
			 //Hearing
			 
				var fwR=$('#fwR').val();
				if(fwR==''){
					alert("Please enter Hearing of  FW of Right.");
					//showhide('button4');
					$('#fwR').focus();
					return false;
				} 
				

				var fwL=$('#fwL').val();
				if(fwL==''){
					alert("Please enter Hearing of FW of Left.");
					//showhide('button4');
					$('#fwL').focus();
					return false;
				} 
			 
				var fwBoth=$('#fwBoth').val();
				if(fwBoth==''){
					alert("Please enter Hearing of FW of Both.");
					//showhide('button4');
					$('#fwBoth').focus();
					return false;
				} 
			 
				var cvR=$('#cvR').val();
				if(cvR==''){
					alert("Please enter Hearing of CV of Right.");
					//showhide('button4');
					$('#cvR').focus();
					return false;
				} 
				
				var cvL=$('#cvL').val();
				if(cvL==''){
					alert("Please enter Hearing of CV of Left.");
					//showhide('button4');
					$('#cvL').focus();
					return false;
				} 
				
				var cvBoth=$('#cvBoth').val();
				if(cvBoth==''){
					alert("Please enter Hearing of CV of Both.");
					//showhide('button4');
					$('#cvBoth').focus();
					return false;
				}
				
				 var tmR=$("#tmR  option:selected" ).text();
				 if(tmR=='Select'){
					alert("Please Select Tympanic Membrance Intact for Right.");
					//showhide('button4');
					$('#tmR').focus();
					return false;
				 }
				 
				 var tmL=$("#tmL  option:selected" ).text();
				 if(tmL=='Select'){
					alert("Please Select Tympanic Membrance Intact for Left.");
					//showhide('button4');
					$('#tmL').focus();
					return false;
				 }
				
				 var mobilityR=$("#mobilityR  option:selected" ).text();
				 if(mobilityR=='Select'){
					alert("Please Select Mobility Valsalva for Right.");
					//showhide('button4');
					$('#mobilityR').focus();
					return false;
				 }
				 
				 var mobilityL=$("#mobilityL  option:selected" ).text();
				 if(mobilityL=='Select'){
					alert("Please Select Mobility Valsalva for Left.");
					//showhide('button4');
					$('#mobilityL').focus();
					return false;
				 }
				
				
			 var noseThroatSinuses=$('#noseThroatSinuses').val();
				if(noseThroatSinuses==''){
					alert("Please enter Nose, Throat & Sinuses.");
					//showhide('button4');
					$('#noseThroatSinuses').focus();
					return false;
				}
				
				 var audiometryRecord=$("#audiometryRecord  option:selected" ).text();
				 if(audiometryRecord=='Select'){
					alert("Please Select Audiometry Record.");
					//showhide('button4');
					$('#audiometryRecord').focus();
					return false;
				 }
				 
				 var ageValue=$('#age').val();
				 var ageGender="";
				 if(ageValue!=""){
					 ageGender=ageValue.split("/");
				 }
				 if(ageGender[1]!=null && (ageGender[1]=='FEMALE'|| ageGender[1]=='Female') ){
				 var mensturalHistory=$('#mensturalHistory').val();
					if(mensturalHistory==''){
						alert("Please enter Menstural History.");
						//showhide('button14');
						$('#mensturalHistory').focus();
						return false;
					}
				 
				 
				 
				 var lMP=$('#lMP').val();
					if(lMP==''){
						alert("Please enter LMP.");
						//showhide('button14');
						$('#lMP').focus();
						return false;
					}
					 
					 var nosOfPregnancies=$('#nosOfPregnancies').val();
						if(nosOfPregnancies==''){
							alert("Please enter Nos of Pregnancies.");
							return false;
						}
				 
				 
					 var nosOfAbortions=$('#nosOfAbortions').val();
						if(nosOfAbortions==''){
							alert("Please enter Nos of Abortions.");
							return false;
						}	
								
								
					 var nosOfChildren=$('#nosOfChildren').val();
						if(nosOfChildren==''){
							alert("Please enter Nos of Children.");
							return false;
						}	
					
								
				 var dateOfLastConfinement=$('#dateOfLastConfinement').val();
					if(dateOfLastConfinement==''){
						alert("Please enter Date of Last Confinement.");
						//showhide('button14');
						$('#dateOfLastConfinement').focus();
						return false;
					}	
								
					 var vaginalDischarge=$('#vaginalDischarge').val();
						if(vaginalDischarge==''){
							alert("Please enter Vaginal Discharge.");
							//showhide('button14');
							$('#vaginalDischarge').focus();
							return false;
						}	
								
					 var dateOfLastConfinement=$('#dateOfLastConfinement').val();
						if(dateOfLastConfinement==''){
							alert("Please enter Date of Last Confinement.");
							//showhide('button14');
							$('#dateOfLastConfinement').focus();
							return false;
						}	
								

					 var usgAbdomen=$('#usgAbdomen').val();
						if(usgAbdomen==''){
							alert("Please enter USG Abdomen.");
							//showhide('button14');
							$('#usgAbdomen').focus();
							return false;
						}		
													
					 var prolapse=$('#prolapse').val();
						if(prolapse==''){
							alert("Please enter Prolapse.");
							//showhide('button14');
							$('#prolapse').focus();
							return false;
						}		
				 }
					var dreftSaveValue=$('#saveInDraft').val();
					
				 if(dreftSaveValue!='draftMa18'){
					 var countDgInves=0;
					  $('#immunisationStatusGrid tr').each(function(i, el) {
				    	    var $tds = $(this).find('td')
				    	    var immunizationText = $tds.eq(0).find(":input").val();
				    	    var immmunizationdate = $tds.eq(1).find(":input").val();
				    	    var duration = $tds.eq(2).find(":input").val();
				    	    var nextDueDate = $tds.eq(3).find(":input").val();
				    	 if(immunizationText== "")
				  	    {
				      		alert("Please enter Immunization Name.");
				      		countDgInves+=1;
				      		return false;
				  		}
				    	 
				    	 if(immmunizationdate== "")
					  	    {
					      		alert("Please enter Immunization Date.");
					      		countDgInves+=1;
					      		return false;
					      		    	
					  		}
				    	 
				    	 if(duration== "")
					  	    {
					      		alert("Please enter Duration.");
					      		countDgInves+=1;
					      		return false;
					      		    	
					  		}
				    	 if(nextDueDate== "")
					  	    {
					      		alert("Please enter Next Due Date.");
					      		countDgInves+=1;
					      		return false;
					      		    	
					  		}
				    	 
				        });
					  if(countDgInves>0){
						  return false;
					  }
				 }
						
						var selectObj = document.getElementById("actionMe");
						if(dreftSaveValue!='draftMa' && dreftSaveValue!='draftMa18'){
							if(selectObj.options[selectObj.selectedIndex].value=='referred' ){
							var countDgInves=0;
						  $('#medicalReferal tr').each(function(i, el) {
					    	    var $tds = $(this).find('td')
					    	    var extHospitalId = $tds.eq(1).find(":input").val();
					    	    var department = $tds.eq(2).find(":input").val();
					    	    var diagnosisValue = $tds.eq(3).find(":input").val();
					    	    var instruction = $tds.eq(4).find(":input").val();
					    	 if(extHospitalId== "" || extHospitalId=='0')
					  	    {
					      		alert("Please select hospital for referral");
					      		countDgInves+=1;
					      		return false;
					      		    	
					  		}
					    	 
					    	 if(department== "")
						  	    {
						      		alert("Please enter department.");
						      		countDgInves+=1;
						      		return false;
						      		    	
						  		}
					    	 
					    	 if(diagnosisValue== "")
						  	    {
						      		alert("Please enter Diganosis.");
						      		countDgInves+=1;
						      		return false;
						      		    	
						  		}
					    	 if(instruction== "")
						  	    {
						      		alert("Please enter Instruction.");
						      		countDgInves+=1;
						      		return false;
						      		    	
						  		}
					    	 
					        });

						  if(countDgInves>0){
							  return false;
						  }
						  
							} 
						}
						return true;				
 }
 
 

 function getImmunisationHistory() {
	 var draftRMo=$('#saveInDraft').val();
	 var approvalFlag=$('#approvalFlag').val();
	 var approvalFlagDiasable="";
	 if((approvalFlag!="" && approvalFlag!=undefined && approvalFlag!=null && approvalFlag=='y') || (draftRMo=='draftRMo' || draftRMo=='draftPRMo')
		 ||(draftRMo=='draftRMo18' || draftRMo=='draftPRMo18')||(draftRMo=='draftRMo3A' || draftRMo=='draftPRMo3A')){
		 approvalFlagDiasable='readonly';
	 }
	 else{
		 approvalFlagDiasable="";
	 }
	 var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";
	 var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalexam/getImmunisationHistory";
	 
	 var visitId = $('#visitId').val();
		var patientId=$('#patientId').val();
		var data = {
			"visitId" : visitId,
			"patientId":patientId,
			"flagForForm":'f'
		};
			$.ajax({
					type : "POST",
					contentType : "application/json",
					url : url,
					data : JSON.stringify(data),
					dataType : "json",
					// cache: false,

					success : function(response) {
						
					var globalDataMasstoreItem = response.listMasStoreItem;	
					 var immmunisationHtml="";
					 var diasableValue="disabled";
					 func1='populateMasStoreItem';
		    		   url1='opd';
		    		   url2='getMasStoreItemList';
		    		   flaga='immunizationFlag';
					 if(globalDataMasstoreItem!=null && globalDataMasstoreItem.length>0)
					 for (var i = 0; i < globalDataMasstoreItem.length; i++) {
						 immmunisationHtml += '<tr>';
						 immmunisationHtml+='<td> <div class="form-group autocomplete forTableResp">';
						// immmunisationHtml+='<input type="text" autocomplete="never" class="form-control border-input" name="immunisatioName" id="immunisatioName" value="'+globalDataMasstoreItem[i].itemCode+ '[' + globalDataMasstoreItem[i].pvmsNo + ']'+'"  onKeyPrss="autoCompleteCommonMe(this,7);"  onKeydown="autoCompleteCommonMe(this,7);" onKeyUp="autoCompleteCommonMe(this,7);"  readonly="readonly" onblur="populateMasStoreItem(this.value,1,this);" '+approvalFlagDiasable+'/>';
						 
						 immmunisationHtml+='<input type="text" autocomplete="never" class="form-control border-input" readonly="readonly" name="immunisatioName" id="immunisatioName" value="'+globalDataMasstoreItem[i].itemCode+ '[' + globalDataMasstoreItem[i].pvmsNo + ']'+'"    onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"    '+approvalFlagDiasable+'/>';
						 
						 immmunisationHtml += '<input type="hidden"  name="immunisationId" value="'
								+ globalDataMasstoreItem[i].itemId  +'"  id="immunisationId' + globalDataMasstoreItem[i].itemId + '"/>';

						 immmunisationHtml += '<input type="hidden"  name="pvmsNumber" value="'
								+ globalDataMasstoreItem[i].pvmsNo  +'"  id="pvmsNumber' + globalDataMasstoreItem[i].pvmsNo + '"/>';

						 immmunisationHtml += '<div id="immunizationDiv'+i+'" class="autocomplete-itemsNew"></div>';

						 immmunisationHtml+='</div></td>';
						 var immunisationName="";
						 var durationImmu="";
						 if(globalDataMasstoreItem[i].itemCode!="" && (globalDataMasstoreItem[i].itemCode.includes('Tetanus')|| globalDataMasstoreItem[i].itemCode.includes('Tetanus'))){
							 immunisationName='immunisationDateTab';
							 if(globalDataMasstoreItem[i].duration!=null && globalDataMasstoreItem[i].duration!="")
								 {
								 durationImmu=globalDataMasstoreItem[i].duration;
								 if(globalDataMasstoreItem[i].itemCode.includes('Tetanus')|| globalDataMasstoreItem[i].itemCode.includes('Tetanus')){
									 diasableValue="disabled";
								 }
								 else{
									 diasableValue=""; 
								 }
								 }
							 else{
								 if(globalDataMasstoreItem[i].itemCode.includes('Tetanus')|| globalDataMasstoreItem[i].itemCode.includes('Tetanus')){
									 durationImmu='5';
								 diasableValue="disabled";
								 }
								 else{
									 durationImmu="";
									 diasableValue="";
								 }
							 }
							 }
						 else{
							 immunisationName='immunisationDateTT';
							 if(globalDataMasstoreItem[i].duration!=null && globalDataMasstoreItem[i].duration!="")
							 {
							 durationImmu=globalDataMasstoreItem[i].duration;
							 if(globalDataMasstoreItem[i].itemCode.includes('Injectable Typhoid Vaccine')|| globalDataMasstoreItem[i].itemCode.includes('Injectable Typhoid Vaccine')){
								 diasableValue="disabled";
							 }
							 else{
								 diasableValue=""; 
							 }
							 }
						 else{
							 if(globalDataMasstoreItem[i].itemCode.includes('Injectable Typhoid Vaccine')|| globalDataMasstoreItem[i].itemCode.includes('Injectable Typhoid Vaccine')){
								 durationImmu='3';
								 diasableValue="disabled";
							 }
							 else{
								 durationImmu="";
								 diasableValue="";
							 }
						 	}
						 }
						 
						 
						 var immunizationDateValue="";
						 if(globalDataMasstoreItem[i].immunizationDate!=""){
							 immunizationDateValue= globalDataMasstoreItem[i].immunizationDate
						 }
						 else{
							 immunizationDateValue="";
						 }
						 immmunisationHtml+='<td>';
						 immmunisationHtml+='<div class="dateHolder">';
						 immmunisationHtml+='<input class="form-control noFuture_date6" name="immnunizationDate" id="immnunizationDate'+i+'"  '+approvalFlagDiasable+'  value="'+immunizationDateValue+'" />';
						 immmunisationHtml+='</div>';
						 immmunisationHtml+='</td>';
						
						 immmunisationHtml+='<td>';
						 immmunisationHtml+=' <input type="text" name="durationImmu"  id="durationImmu'+i+'" value="'+durationImmu+'" onblur="return generateNextDateForImmun(this);" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control" readonly/> ';
						 immmunisationHtml+='</td>';
                          
						 var immunizationNextDueImmuDateValue="";
						 if(globalDataMasstoreItem[i].immunizationDate!=""){
							 immunizationNextDueImmuDateValue= globalDataMasstoreItem[i].immunizationNextDateValue
						 }
						 else{
							 immunizationNextDueImmuDateValue="";
						 }
						 
						 immmunisationHtml+='<td>';
						 immmunisationHtml+='   <div class="dateHolder">';
						 immmunisationHtml+=' <input type="text" id="nextDueImmu'+i+'"  name="nextDueImmu" class="form-control" placeholder="DD/MM/YYYY" value="'+immunizationNextDueImmuDateValue+'" maxlength="10" readonly />';
						 immmunisationHtml+=' </div>';
						 immmunisationHtml+='  </td>';
						 
						 
						 immmunisationHtml+=' <td><button name="Button" '+approvalFlagDiasable+' type="button" class="buttonAdd btn btn-primary noMinWidth" button-type="add" onClick="return addImmunisationStatus();"> </button></td>';
						var immunizationId="";
							if(globalDataMasstoreItem[i].immunizationId!="" &&  globalDataMasstoreItem[i].immunizationId!=undefined && globalDataMasstoreItem[i].immunizationId!=null){
								immunizationId=globalDataMasstoreItem[i].immunizationId;
							}
							var immunisationStatusGrid='immunisationStatusGrid';
							
						 immmunisationHtml+='	<td><button name="Button" type="button" class="buttonAdd btn btn-danger noMinWidth" id="immunizationDelete" button-type="delete" '+diasableValue+' onClick="return removeRowInvestigationMe(this,\'' + immunisationStatusGrid + '\',\''+ immunizationId + '\');"> </button></td>';
						 immmunisationHtml += '</tr>';
					 }				
			 
					 $("#immunisationStatusGrid").html(immmunisationHtml); 
				}
			});
		}
 
 
 function removeRowImmunization(val){
		$(val).closest('tr').remove();
	}
 
 
 var lastRow;
 var i=0;
  function addRowForServiceDetails(){
 	  var tbl = document.getElementById('serviceDetailsIdGrid');
 		var sNO=0;
    	lastRow = tbl.rows.length;
    	i =lastRow;
    	sNO=lastRow;
    	i++;
    	sNO++;
    	var lastId=$("#serviceDetailsIdGrid tr:last").find("td:first").html();
    	i=parseInt(lastId)+parseInt(1);
    	sNO=i;
    	
 	    var aClone = $('#serviceDetailsIdGrid>tr:last').clone(true)
 	    aClone.find('img.ui-datepicker-trigger').remove();
 		aClone.find(":input").val("");
 		aClone.find("td:eq(0)").html(sNO);
 		aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'serviceDetailFrom'+i+'').removeClass('noFuture_date  hasDatepicker').addClass('noFuture_date  ');
 		aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'serviceDetailTo'+i+'').removeClass('noFuture_date  hasDatepicker').addClass('noFuture_date  ');
 		
 		aClone.find("td:eq(3)").find("input:eq(0)").prop('id', 'serviceDetailPlace'+i+'');
 		aClone.find("td:eq(4)").find("input:eq(0)").prop('id', 'serviceDetailPf'+i+'');
 		aClone.find("option[selected]").removeAttr("selected");
 		var	serviceDetailDelete ='';
 		serviceDetailDelete +='<button type="button" name="newdeleteServiceDetail" value="" id="newdeleteServiceDetail'+i+'"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" onclick="removeRowInvestigation(this);"></button>';
 		aClone.find("td:eq(6)").html(serviceDetailDelete);
 		aClone.clone(true).appendTo('#serviceDetailsIdGrid');
 	} 
  
  var count=1;
  function addRowForDiseaseWoundInjury(){
 	  var tbl = document.getElementById('diseaseWoundInjuryDetailsGrid');
 		var sNO=0;
    	lastRow = tbl.rows.length;
    	i =lastRow;
    	i++;
    	count=parseInt(count)+parseInt(i);
      	i=count;
 	    var aClone = $('#diseaseWoundInjuryDetailsGrid>tr:last').clone(true)
 	    aClone.find('img.ui-datepicker-trigger').remove();
 		aClone.find(":input").val("");
 		aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'IllnessWoundInjury'+i+'');
 		aClone.find("td:eq(0)").find("input:eq(1)").prop('id', 'icdDiagnaosis'+i+'');
 		aClone.find("td:eq(0)").find("input:eq(2)").prop('id', 'patientDiagnosisId'+i+'');
 		aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'firstStartedDate'+i+'').removeClass('noFuture_date hasDatepicker').addClass('noFuture_date ');
 		aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'firstStartedPlace'+i+'');
 		
 		aClone.find("td:eq(3)").find("input:eq(0)").prop('id', 'whereTreated'+i+'');
 		aClone.find("td:eq(4)").find("input:eq(0)").prop('id', 'approximatePeriodsTreatedFrom'+i+'').removeClass('noFuture_date hasDatepicker').addClass('noFuture_date ');
 		
 		aClone.find("td:eq(5)").find("input:eq(0)").prop('id', 'approximatePeriodsTreatedTo'+i+'').removeClass('noFuture_date hasDatepicker').addClass('noFuture_date ');
	var	diseaseWoundInjuryDelete ='';
 		
		diseaseWoundInjuryDelete +='<button type="button" name="newdiseaseWoundInjury" value="" id="newdiseaseWoundInjury'+i+'"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" onclick="removeRowInvestigation(this);"></button>';
 		aClone.find("td:eq(7)").html(diseaseWoundInjuryDelete);
 		aClone.clone(true).appendTo('#diseaseWoundInjuryDetailsGrid');
 	} 
  
 
  var count2=1;
  function addRowForDiseaseWoundInjuryArmedForces(){
 	  var tbl = document.getElementById('diseaseWoundInjuryArmedForces');
 		var sNO=0;
    	lastRow = tbl.rows.length;
    	i =lastRow;
    	i++;
    	count2=parseInt(count2)+parseInt(i);
      	i=count2;
 	    var aClone = $('#diseaseWoundInjuryArmedForces>tr:last').clone(true)
 	    aClone.find('img.ui-datepicker-trigger').remove();
 		aClone.find(":input").val("");
 		aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'armedForcesFrom'+i+'').removeClass('noFuture_date hasDatepicker').addClass('noFuture_date ');
 		aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'armedForcesTo'+i+'').removeClass('noFuture_date hasDatepicker').addClass('noFuture_date ');
 	
 		aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'armedForcesDetails'+i+'');
 		aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'armedForcesFrom'+i+'');
 		aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'armedForcesTo'+i+'');
 		 
 		var	armedForcesDelete ='';
 		
 		armedForcesDelete +='<button type="button" name="newarmedForces" value="" id="newarmedForces'+i+'"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" onclick="removeRowInvestigation(this);"></button>';
 	 	aClone.find("td:eq(4)").html(armedForcesDelete);
 		aClone.clone(true).appendTo('#diseaseWoundInjuryArmedForces');
 	} 
  
 
 
 

 function getDisabilityBeforeJoining(idSelect) {
	var selectObj = idSelect.id;
	var selectedValue = $("#" + selectObj + " option:selected").text();
	if (selectedValue != null && selectedValue != "") {
		if (selectedValue == 'Yes') {
			$('#diseaseWoundInjuryArmedForcesTable').show();
		} else {
			$('#diseaseWoundInjuryArmedForcesTable').hide();

		}
	}

}
 
 
 var autoIcdCode = '';
 var icdData= '';	 
  var idIcdNo = '';
  var icdValue = '';
  var multiIcdValue=[];
 
 var total_icd_value = '';
 var digaoReferal='';   
 function fillDiagnosisComboF18(val,item) {
 	  
	   var index1 = val.lastIndexOf("[");
	     var index2 = val.lastIndexOf("]");
	     index1++;
	     idIcdNo = val.substring(index1, index2);
	     if (idIcdNo == "") {
	         return;
	     } else {
	        
	         for(var i=0;i<autoIcdCode.length;i++){
	    		  var icdNo1 = icdData[i].icdCode;
	    		  icdValue = icdData[i].icdId;
	    		  if(icdNo1 == idIcdNo){
	    			  //$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val(icdValue);
	    		  
	    			  var checkCurrentRowIddd = $(item).closest('tr').find("td:eq(0)").find("input:eq(1)").attr("id");
					     var checkCurrentRow = $(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val();
					     $('#diseaseWoundInjuryDetailsGrid tr').each(function(i, el) {
	         				//alert("icdNo1"+icdNo1)
	         				//alert("icdValue "+icdValue)
	         				  var $tds = $(this).find('td');
								var chargeCodeId = $($tds).closest('tr').find("td:eq(0)").find("input:eq(1)").attr("id");
								var chargeCodeIdValue = $('#' + chargeCodeId).val();
								var idddd = $(item).closest('tr').find("td:eq(0)").find("input:eq(1)").attr("id");
								var currentidddd = $(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
								//alert("chargeCodeIdValue "+chargeCodeIdValue)
								if (chargeCodeId != checkCurrentRowIddd && icdValue == chargeCodeIdValue) {
									if (icdValue == chargeCodeIdValue) {
										alert("Diagnosis is already added");
										$('#' + idddd).val("");
										$('#' + currentidddd).val("");
										$('#'+ chargeCodeIdValue).val("");
										return false;
									}
								}
						else
						{	
	    		 
	    			 $(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val(icdValue);
	    				  
							}
	         			 }); 
	    		  }
	    	  }
	     }
         
 }
 
 
 function getServiceDetail(){
		
	 	var draftRMo=$('#saveInDraft').val();
		var visitId = $('#visitId').val();
		var age = $('#ageForPatient').val();
		var patientId=$('#patientId').val();
		var data = {
			"visitId" : visitId,
			"flagForForm" :"f8",
			"age":age,
			"patientId":patientId
		};
		var pathname = window.location.pathname;
        var accessGroup = "MMUWeb";
		 var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalexam/getServiceDetails";
		 
		$.ajax({

			type : "POST",
			contentType : "application/json",
			url : url,
			data : JSON.stringify(data),
			dataType : "json",
			// cache: false,

			success : function(res) {
				 var listPatientServicesDetail=res.listPatientServicesDetail;
				 var countins = 1;
				 var countSno=1;
				 var serviceDetailData="";
					if (listPatientServicesDetail != null && listPatientServicesDetail.length > 0) {
						var serviceDetailData="";
						var diasableValue="disabled";
						 var approvalFlag=$('#approvalFlag').val();
						 var approvalFlagDiasable="";
						 if(((approvalFlag!="" && approvalFlag!=undefined && approvalFlag!=null && approvalFlag=='y') || draftRMo=='draftRMo18' || draftRMo=='draftPRMo18')){
							 approvalFlagDiasable='readonly';
						 }
						 else{
							 approvalFlagDiasable="";
						 }
						
						for (var i = 0; i < listPatientServicesDetail.length; i++) {
							serviceDetailData += '<tr>';
							serviceDetailData +='<td style="width: 150px;">'+countSno+'</td>';
							serviceDetailData += '<td><div class="dateHolder">';
							serviceDetailData += '<input class="form-control input_date" name="serviceDetailFrom" id="serviceDetailFrom'+i+'" value="'+listPatientServicesDetail[i].fromDate+'" '+approvalFlagDiasable+'/>';
							serviceDetailData += '<input type="hidden"  name="serviceDetailId" value="'
								+ listPatientServicesDetail[i].serviceDetailsId +'"  id="serviceDetailId' + listPatientServicesDetail[i].serviceDetailsId + '"/>';
							serviceDetailData += '</div></td>';
							
							
							serviceDetailData +='<td>';
							serviceDetailData +='<div class="dateHolder">';
							serviceDetailData +=' <input type="text"  name="serviceDetailTo" id="serviceDetailTo'+ listPatientServicesDetail[i].serviceDetailsId +'" value="'+listPatientServicesDetail[i].toDate+'" class="input_date  form-control" '+approvalFlagDiasable+'>';
							serviceDetailData +='</div>';
							serviceDetailData +='</td>';
							
						 
							serviceDetailData +='<td>';
							serviceDetailData +='<input type="text"  name="serviceDetailPlace" id="serviceDetailPlace" value="'+listPatientServicesDetail[i].place+'" class="form-control" '+approvalFlagDiasable+'>';
							serviceDetailData +='</td>';
							
							var categoryType=listPatientServicesDetail[i].pf;
							serviceDetailData +='<td>';
							serviceDetailData+='<select class="form-control" name=serviceDetailPf id="serviceDetailPf'+countSno+'" '+approvalFlagDiasable+'>';
							
							serviceDetailData+='<option value="0">Select</option>';
							if(listPatientServicesDetail[i].pf!=null && listPatientServicesDetail[i].pf!="" && listPatientServicesDetail[i].pf!=undefined && listPatientServicesDetail[i].pf!='0'){
								var cateValue;
								var catetypeVal;
								for(var j=0;j<2;j++){
								var selectValue=""
								if(categoryType=='Peace'){
									selectValue='selected';
									cateValue='Peace';
									catetypeVal='Peace';
									categoryType='';
									
								}
								else if(categoryType=='Field'){
									selectValue='selected';
									cateValue='Field';
									catetypeVal='Field';
									categoryType='';
								}
								else{
									var count=0;
									if(cateValue=='Peace' && count=='0'){
										cateValue='Field';
										catetypeVal='Field';
										count++;
									} 
									if(cateValue=='Field' && count=='0'){
										cateValue='Peace';
										catetypeVal='Peace';
										count++;
									}
									selectValue='';
								}
								serviceDetailData+='<option '+selectValue+' value='+catetypeVal+'>'+cateValue+'</option>';
							}
							}
							else{
								
								serviceDetailData+='<option value="Peace">Peace</option>';
								serviceDetailData+='<option value="Field">Field</option>';
							}	
							serviceDetailData+='</select>';
							
							serviceDetailData+='</td>';
							
							serviceDetailData += '<td><button name="Button" type="button"  class="buttonAdd btn btn-primary noMinWidth" button-type="add" value="" '+approvalFlagDiasable+'';
							serviceDetailData += 'onclick="addRowForServiceDetails();"';
							serviceDetailData += '	tabindex="1" ></button></td>';
	 					
							var investigationGridValidate='serviceDetailsIdGrid';
							var dgOrderDtIdTemp=0;
							if(listPatientServicesDetail[i].serviceDetailsId!=null && listPatientServicesDetail[i].serviceDetailsId!=undefined)
							  dgOrderDtIdTemp=listPatientServicesDetail[i].serviceDetailsId;
							serviceDetailData +='<td>';
							serviceDetailData +='<button  name="Button" type="button"  name="delete" value="" id="deleteInves'+i+'"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" onclick="removeRowInvestigationMe(this,\'' + investigationGridValidate + '\',\''+ dgOrderDtIdTemp + '\');"></button>';
							 
							serviceDetailData +='</td>';
							
							serviceDetailData +='</tr>';
							countSno+=1;
						}
					}
					if(countSno >1)
					$("#serviceDetailsIdGrid").html(serviceDetailData);
			}
		});

		return false;
 }
 
 
 function getDiseaseWoundInjuryDetails(){
	 var draftRMo=$('#saveInDraft').val();
		var visitId = $('#visitId').val();
		var age = $('#ageForPatient').val();
		var patientId=$('#patientId').val();
		var data = {
			"visitId" : visitId,
			"flagForForm" :"f8",
			"age":age,
			"patientId":patientId
		};
		var pathname = window.location.pathname;
        var accessGroup = "MMUWeb";
		 var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalexam/getPatientDiseaseWoundInjuryDetail";
		
		$.ajax({

			type : "POST",
			contentType : "application/json",
			url : url,
			data : JSON.stringify(data),
			dataType : "json",
			// cache: false,

			success : function(res) {
				 var listPatientDiseaseInfo=res.listPatientDiseaseInfo;
				 var countins = 1;
				 var countSno=1;
				 var patientDiagnosisData="";
				 var beforeJoiningArmedForces="";
					if (listPatientDiseaseInfo != null && listPatientDiseaseInfo.length > 0) {
						var diasableValue="disabled";
						
						 var approvalFlag=$('#approvalFlag').val();
						 var approvalFlagDiasable="";
						 if(((approvalFlag!="" && approvalFlag!=undefined && approvalFlag!=null && approvalFlag=='y') || draftRMo=='draftRMo18' || draftRMo=='draftPRMo18')){
							 approvalFlagDiasable='readonly';
						 }
						 else{
							 approvalFlagDiasable="";
						 }
						 func1='fillDiagnosisComboF18';
			    		   url1='opd';
			    		   url2='getIcdListByName';
			    		   flaga='diagnosisMe18';
						for (var i = 0; i < listPatientDiseaseInfo.length; i++) {
							
							if(listPatientDiseaseInfo[i].beforeFlag=='N' || listPatientDiseaseInfo[i].beforeFlag=='n'){
							patientDiagnosisData += '<tr>';
							patientDiagnosisData += '	<td>';
							patientDiagnosisData += ' <div class="autocomplete forTableResp">';
							
							//patientDiagnosisData += ' <input type="text" class="form-control" name="IllnessWoundInjury" id="IllnessWoundInjury" onblur="fillDiagnosisComboF18(this.value,this);" onKeyPress="autoCompleteCommonMe(this,5);" onKeyUp="autoCompleteCommonMe(this,5);"placeholder="Diagnosis" value="'+listPatientDiseaseInfo[i].icdDiagonosisName + '[' + listPatientDiseaseInfo[i].icdCode + ']" '+approvalFlagDiasable+'/>';
							
							patientDiagnosisData += ' <input type="text" class="form-control" name="IllnessWoundInjury" id="IllnessWoundInjury"  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" placeholder="Diagnosis" value="'+listPatientDiseaseInfo[i].icdDiagonosisName + '[' + listPatientDiseaseInfo[i].icdCode + ']" '+approvalFlagDiasable+'/>';
							patientDiagnosisData += ' <input type="hidden" id="icdDiagnaosis" name="icdDiagnaosis" value="'+listPatientDiseaseInfo[i].icdId+'"/>';
							patientDiagnosisData += '<input type="hidden" id="patientDiagnosisId'+i+'" name="patientDiagnosisId" value="'+listPatientDiseaseInfo[i].diseaseInfoId+'"/>';
							patientDiagnosisData += '  <div id="diseaseWoundInjuryDetailsGridDiv'+i+'" class="autocomplete-itemsNew"></div>';
							patientDiagnosisData += ' </div>';
							patientDiagnosisData += ' </td>';
							
							patientDiagnosisData += '<td><div class="dateHolder">';
							patientDiagnosisData += '<input class="form-control input_date" name="firstStartedDate" id="firstStartedDate'+countSno+'" value="'+listPatientDiseaseInfo[i].firstStartDate+'" '+approvalFlagDiasable+'/>';
							patientDiagnosisData += '</div></td>';
							
							patientDiagnosisData += '<td>';
							patientDiagnosisData += '<input type="text" name="firstStartedPlace" id="firstStartedPlace'+countSno+'" class="form-control" value="'+listPatientDiseaseInfo[i].firstStartPlace+'" '+approvalFlagDiasable+'>';
							patientDiagnosisData += '</td>';
							
							patientDiagnosisData += '<td>';
							patientDiagnosisData += '<input type="text" name="whereTreated" id="whereTreated" class="form-control" value="'+listPatientDiseaseInfo[i].treatedPlace+'" '+approvalFlagDiasable+'>';
							patientDiagnosisData += '</td>'
							
							patientDiagnosisData +='<td>';
							patientDiagnosisData +='<div class="dateHolder">';
							patientDiagnosisData +=' <input type="text"  name="approximatePeriodsTreatedFrom" id="approximatePeriodsTreatedFrom'+countSno+'" value="'+listPatientDiseaseInfo[i].approximateFromDate+'" class="input_date  form-control" '+approvalFlagDiasable+'>';
							patientDiagnosisData +='</div>';
							patientDiagnosisData +='</td>';
							
							patientDiagnosisData +='<td>';
							patientDiagnosisData +='<div class="dateHolder">';
							patientDiagnosisData +=' <input type="text"  name="approximatePeriodsTreatedTo" id="approximatePeriodsTreatedTo'+countSno+'" value="'+listPatientDiseaseInfo[i].approximatetoDate+'" class="input_date  form-control" '+approvalFlagDiasable+'>';
							patientDiagnosisData +='</div>';
							patientDiagnosisData +='</td>';
							
						 
							
							patientDiagnosisData += '<td><button name="Button" type="button"    class="buttonAdd btn btn-primary noMinWidth" button-type="add" value="" '+approvalFlagDiasable+'';
							patientDiagnosisData += 'onclick="addRowForDiseaseWoundInjury();"';
							patientDiagnosisData += '	tabindex="1" ></button></td>';
							var dgOrderDtIdTemp="";
							if(listPatientDiseaseInfo[i].diseaseInfoId!=null && listPatientDiseaseInfo[i].diseaseInfoId!=undefined && listPatientDiseaseInfo[i].diseaseInfoId!="")
								dgOrderDtIdTemp=listPatientDiseaseInfo[i].diseaseInfoId;
							var investigationGridValidate='diseaseWoundInjuryDetailsGrid';
							patientDiagnosisData +='<td>';
							patientDiagnosisData +='<button  name="Button" type="button"  name="delete" value="" id="deleteInves'+i+'"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" onclick="removeRowInvestigationMe(this,\'' + investigationGridValidate + '\',\''+ dgOrderDtIdTemp + '\');"></button>';
							 
							patientDiagnosisData +='</td>';
							
							patientDiagnosisData +='</tr>';
							countSno+=1;
							}
							
							if(listPatientDiseaseInfo[i].beforeFlag=='Y' || listPatientDiseaseInfo[i].beforeFlag=='y'){
								beforeJoiningArmedForces += '<tr>';
							 
								beforeJoiningArmedForces += '<td><div class="dateHolder">';
								beforeJoiningArmedForces += '<input class="form-control input_date" name="armedForcesFrom" id="armedForcesFrom'+countins+'" value="'+listPatientDiseaseInfo[i].approximateFromDate+'" '+approvalFlagDiasable+'/>';
								beforeJoiningArmedForces += '<input type="hidden" id="armedForcesPatientDiagnosisId'+countins+'" name="armedForcesPatientDiagnosisId" value="'+listPatientDiseaseInfo[i].diseaseInfoId+'"/>';
								
								beforeJoiningArmedForces += '</div></td>';
								
								beforeJoiningArmedForces +='<td>';
								beforeJoiningArmedForces +='<div class="dateHolder">';
								beforeJoiningArmedForces +=' <input type="text"  name="armedForcesTo" id="armedForcesTo'+countins+'" value="'+listPatientDiseaseInfo[i].approximatetoDate+'" class="input_date  form-control" '+approvalFlagDiasable+'>';
								beforeJoiningArmedForces +='</div>';
								beforeJoiningArmedForces +='</td>';
								
								beforeJoiningArmedForces += '<td>';
								beforeJoiningArmedForces += '<input type="text" name="armedForcesDetails" id="armedForcesDetails'+countins+'" class="form-control" value="'+listPatientDiseaseInfo[i].remarks+'" '+approvalFlagDiasable+'>';
								beforeJoiningArmedForces += '</td>'
							
								
								beforeJoiningArmedForces += '<td><button name="Button" type="button"    class="buttonAdd btn btn-primary noMinWidth" button-type="add" value="" '+approvalFlagDiasable+'';
								beforeJoiningArmedForces += 'onclick="addRowForDiseaseWoundInjuryArmedForces();"';
								beforeJoiningArmedForces += '	tabindex="1" ></button></td>';
		 					
								var dgOrderDtIdTemp="";
								if(listPatientDiseaseInfo[i].diseaseInfoId!=null && listPatientDiseaseInfo[i].diseaseInfoId!=undefined && listPatientDiseaseInfo[i].diseaseInfoId!="")
									dgOrderDtIdTemp=listPatientDiseaseInfo[i].diseaseInfoId;
								var investigationGridValidate='diseaseWoundInjuryArmedForces';
								beforeJoiningArmedForces +='<td>';
								beforeJoiningArmedForces +='<button  name="Button" type="button"  name="delete" value="" id="deleteInves'+countins+'"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" onclick="removeRowInvestigationMe(this,\'' + investigationGridValidate + '\',\''+ dgOrderDtIdTemp + '\');"></button>';
								 
								beforeJoiningArmedForces +='</td>';
								
								beforeJoiningArmedForces +='</tr>';
								countins++;
							}
						}
					}
					if(countSno >1){
						$("#diseaseWoundInjuryDetailsGrid").html(patientDiagnosisData);
					}
					if (countins > 1) {
						var disabilityBeforeJoiningIdValue = $('#disabilityBeforeJoiningIdValue').val();
						if (disabilityBeforeJoiningIdValue == 'Yes'
								|| disabilityBeforeJoiningIdValue == 'yes') {
							$("#diseaseWoundInjuryArmedForces").html(beforeJoiningArmedForces);
							$("#diseaseWoundInjuryArmedForcesTable").show();
						}
						else{
							$("#diseaseWoundInjuryArmedForcesTable").hide();
						}
					}
					
					}
		});

		return false;
}
 
 
 
 
 
 function getMasEmployeeDetailForService(){
		var serviceNo=$('#serviceNoForEmployee').val();
		var serviceNoForIndivisual=$('#serviceNo').val();
		var userId=$('#userId').val();
		if(serviceNo=="" || serviceNo=='0' || serviceNo==null){
			return false;
		}
		var pathname = window.location.pathname;
        var accessGroup = "MMUWeb";
		 var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalexam/getMasEmployeeDetailForService";
 		$.ajax({
					url : url,
					dataType : "json",
					data : JSON.stringify({
						'serviceNo' : serviceNo,
						'userId':userId,
						'serviceNoForIndivisual':serviceNoForIndivisual
					}),
					contentType : "application/json",
					type : "POST",
					success : function(response) {
						console.log(response);
						var dataList = response.masEmployeeList;
						var htmlTable = "";	
						
						if(dataList!=null && dataList.length > 0)
							{
							 $('#signatureOfIndividual').val(dataList[0].userName);
							 $('#signatureOfWitness').val(dataList[0].emplyeeName);
							 $('#rankForEmployee').val(dataList[0].rank);
							 $('#witnessOfEmployee').val(dataList[0].emplyeeId);
							}
						else{
							alert("Service Number is not valid.");
							$('#serviceNoForEmployee').val("");
						//	$('#rankForEmployee').focus();
						}
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

 
 
 
 
 
 function validateForm18(){
	 
		//Dental Validation
		var totalNoOfTeath=$('#totalNoOfTeath').val();
		if(totalNoOfTeath==''){
			alert("Please enter Total No. of Teeth.");
			showhide('button1');
			$('#totalNoOfTeath').focus();
			
			return false;
		}
		
		 
		
		var conditionOfGums=$('#conditionOfGums').val();
		if(conditionOfGums==''){
			alert("Please enter Condition of Gums.");
			showhide('button1');
			$('#conditionOfGums').focus();
			return false;
		}
		
		var dentalOffier=$('#dentalOffier').val();
		if(dentalOffier==''){
			alert("Please enter Dental Officer.");
			showhide('button1');
			$('#dentalOffier').focus();
			return false;
		}
		
	 
		var checkupDate=$('#checkupDate').val();
		if(checkupDate==''){
			alert("Please enter Checkup Date.");
			showhide('button1');
			$('#checkupDate').focus();
			return false;
		}
		var remarks=$('#remarks').val();
		if(remarks==''){
			alert("Please enter remarks.");
			showhide('button1');
			$('#remarks').focus();
			return false;
		}
		//Physical Capacity
		
		var height=$('#height').val();
		if(height==''){
			alert("Please enter Height.");
			showhide('button2');
			$('#height').focus();
			return false;
		}
		
		
		var weight=$('#weight').val();
		if(weight==''){
			alert("Please enter Weight Actual.");
			showhide('button2');
			$('#weight').focus();
			return false;
		}
		
		
		
		
		var idealWeight=$('#idealWeight').val();
		if(idealWeight==''){
			alert("Please enter Ideal Wt.");
			showhide('button2');
			$('#idealWeight').focus();
			return false;
		}
		
		var waist=$('#waist').val();
		if(waist==''){
			alert("Please enter Waist.");
			showhide('button2');
			$('#waist').focus();
			return false;
		}
		
		var chestFullExpansion=$('#chestFullExpansion').val();
		if(chestFullExpansion==''){
			alert("Please enter Chest Full Expansion.");
			showhide('button2');
			$('#chestFullExpansion').focus();
			return false;
		}
		
		var rangeOfExpansion=$('#rangeOfExpansion').val();
		if(rangeOfExpansion==''){
			alert("Please enter Range of Expansion.");
			showhide('button2');
			$('#rangeOfExpansion').focus();
			return false;
		}
		
		var pulse=$('#pulse').val();
		if(pulse==''){
			alert("Please enter Pulse.");
			showhide('button6');
			$('#pulse').focus();
			
			return false;
		}
		
		var bp=$('#bp').val();
		if(bp==''){
			alert("Please enter BP.");
			showhide('button6');
			$('#bp').focus();
			return false;
		}
		
		var bp1=$('#bp1').val();
		if(bp1==''){
			alert("Please enter DBP.");
			showhide('button6');
			$('#bp1').focus();
			return false;
		}
		
		var peripheralPulsations=$('#peripheralPulsations').val();
		if(peripheralPulsations==''){
			alert("Please enter Peripheral Pulsations.");
			showhide('button6');
			$('#peripheralPulsations').focus();
			return false;
		}
		
		var heartSize=$('#heartSize').val();
		if(heartSize==''){
			alert("Please enter Heart Size.");
			showhide('button6');
			$('#heartSize').focus();
			return false;
		}
		
		var sounds=$('#sounds').val();
		if(sounds==''){
			alert("Please enter Sounds.");
			showhide('button6');
			$('#sounds').focus();
			return false;
		}
		var rhythm=$('#rhythm').val();
		if(rhythm==''){
			alert("Please enter Rhythm.");
			showhide('button6');
			$('#rhythm').focus();
			return false;
		}
		//Respiratory System
		var respiratorySystem=$('#respiratorySystem').val();
		if(respiratorySystem==''){
			alert("Please enter Respiratory System.");
			showhide('button7');
			$('#respiratorySystem').focus();
			
			return false;
		}
		
		var respiratorySystem=$('#respiratorySystem').val();
		if(respiratorySystem==''){
			alert("Please enter Respiratory System.");
			showhide('button8');
			$('#respiratorySystem').focus();
			return false;
		}
		
		 var selectedValue=$("#liverPalpable option:selected" ).text();
		 
		 if(selectedValue=='Select'){
			alert("Please Select Liver Palpable.");
			showhide('button8');
			$('#liverPalpable').focus();
			return false;
		 }
			if(selectedValue=='Yes'){
			if($('#liver').val()==''){
				alert("Please enter Liver Palpable.");
				showhide('button8');
				$('#liver').focus();
				return false;
			}
			
		 }
		
		 
		 
		 var selectedValueSpleenPalpable=$("#spleenPalpable  option:selected" ).text();
		 if(selectedValue=='Select'){
			 alert("Please Select Spleen Palpable.");
			 showhide('button8');
				$('#spleenPalpable').focus();
			 return false;
		 }
		 if(selectedValueSpleenPalpable=='Yes'){
		if($('#spleen').val()==''){
			alert("Please enter Spleen Palpable.");
			showhide('button8');
			$('#spleen').focus();
			return false;
		}
	}
		 //Central Nervous System
		 
		 var higherMentalFunction=$('#higherMentalFunction').val();
			if(higherMentalFunction==''){
				alert("Please enter Higher Mental Function.");
				showhide('button9');
				$('#higherMentalFunction').focus();
				
				return false;
			} 
			var speech=$('#speech').val();
			if(speech==''){
				alert("Please enter Speech.");
				showhide('button9');
				$('#speech').focus();
				return false;
			} 
		 
			var reflexes=$('#reflexes').val();
			if(reflexes==''){
				alert("Please enter Reflexes.");
				showhide('button9');
				$('#reflexes').focus();
				return false;
			} 
			 var tremors=$("#tremors  option:selected" ).text();
			 if(tremors=='Select'){
				alert("Please Select Termors.");
				showhide('button9');
				$('#tremors').focus();
				return false;
			 }
			
			

			 var selfBalancingTest=$("#selfBalancingTest  option:selected" ).text();
			 if(selfBalancingTest=='Select'){
				alert("Please Select Self Balancing Test.");
				showhide('button9');
				$('#selfBalancingTest').focus();
				return false;
			 }
			//Other
			 
				var locomotorSystem=$('#locomotorSystem').val();
				if(locomotorSystem==''){
					alert("Please enter Locomotor System.");
					showhide('button10');
					$('#locomotorSystem').focus();
					return false;
				} 
				
				var spine=$('#spine').val();
				if(spine==''){
					alert("Please enter Spine.");
					showhide('button10');
					$('#spine').focus();
					return false;
				} 
			 

				var hernia=$('#hernia').val();
				if(hernia==''){
					alert("Please enter Hernia.");
					showhide('button10');
					$('#hernia').focus();
					return false;
				} 
			 
				
				var hydrocele=$('#hydrocele').val();
				if(hydrocele==''){
					alert("Please enter Hydrocele.");
					showhide('button10');
					$('#hydrocele').focus();
					return false;
				} 
				
				
				var haemorrhoids=$('#haemorrhoids').val();
				if(haemorrhoids==''){
					alert("Please enter Haemorrhoids.");
					showhide('button10');
					$('#haemorrhoids').focus();
					return false;
				} 
				//Vision
				 var distantWithoutGlasses=$("#distantWithoutGlasses  option:selected" ).text();
				 if(distantWithoutGlasses=='Select'){
					alert("Please Select Distant Vision of Without Glasses.");
					showhide('button3');
					$('#distantWithoutGlasses').focus();
					return false;
				 }
				 
				 var nearWithoutGlasses=$("#nearWithoutGlasses  option:selected" ).text();
				 if(nearWithoutGlasses=='Select'){
					alert("Please Select Near Vision of Without Glasses.");
					showhide('button3');
					$('#nearWithoutGlasses').focus();
					return false;
				 }
				
				 var distantWithGlasses=$("#distantWithGlasses  option:selected" ).text();
				 if(distantWithGlasses=='Select'){
					alert("Please Select Distant Vision of With Glasses.");
					showhide('button3');
					$('#distantWithGlasses').focus();
					return false;
				 }
			
				 
				 var nearWithGlasses=$("#nearWithGlasses  option:selected" ).text();
				 if(nearWithGlasses=='Select'){
					alert("Please Select Near Vision of With Glasses.");
					showhide('button3');
					$('#nearWithGlasses').focus();
					return false;
				 }
				 
				 
				 var cpWithoutGlasses=$("#cpWithoutGlasses  option:selected" ).text();
				 if(cpWithoutGlasses=='Select'){
					alert("Please Select CP.");
					showhide('button3');
					$('#cpWithoutGlasses').focus();
					return false;
				 }
				 
				 //Hearing
				 
					var fwR=$('#fwR').val();
					if(fwR==''){
						alert("Please enter Hearing of  FW of Right.");
						showhide('button4');
						$('#fwR').focus();
						return false;
					} 
					

					var fwL=$('#fwL').val();
					if(fwL==''){
						alert("Please enter Hearing of FW of Left.");
						showhide('button4');
						$('#fwL').focus();
						return false;
					} 
				 
					var fwBoth=$('#fwBoth').val();
					if(fwBoth==''){
						alert("Please enter Hearing of FW of Both.");
						showhide('button4');
						$('#fwBoth').focus();
						return false;
					} 
				 
					var cvR=$('#cvR').val();
					if(cvR==''){
						alert("Please enter Hearing of CV of Right.");
						showhide('button4');
						$('#cvR').focus();
						return false;
					} 
					
					var cvL=$('#cvL').val();
					if(cvL==''){
						alert("Please enter Hearing of CV of Left.");
						showhide('button4');
						$('#cvL').focus();
						return false;
					} 
					
					var cvBoth=$('#cvBoth').val();
					if(cvBoth==''){
						alert("Please enter Hearing of CV of Both.");
						showhide('button4');
						$('#cvBoth').focus();
						return false;
					}
					
					 var tmR=$("#tmR  option:selected" ).text();
					 if(tmR=='Select'){
						alert("Please Select Tympanic Membrance Intact for Right.");
						showhide('button4');
						$('#tmR').focus();
						return false;
					 }
					 
					 var tmL=$("#tmL  option:selected" ).text();
					 if(tmL=='Select'){
						alert("Please Select Tympanic Membrance Intact for Left.");
						showhide('button4');
						$('#tmL').focus();
						return false;
					 }
					
					 var mobilityR=$("#mobilityR  option:selected" ).text();
					 if(mobilityR=='Select'){
						alert("Please Select Mobility Valsalva for Right.");
						showhide('button4');
						$('#mobilityR').focus();
						return false;
					 }
					 
					 var mobilityL=$("#mobilityL  option:selected" ).text();
					 if(mobilityL=='Select'){
						alert("Please Select Mobility Valsalva for Left.");
						showhide('button4');
						$('#mobilityL').focus();
						return false;
					 }
					
					
				 var noseThroatSinuses=$('#noseThroatSinuses').val();
					if(noseThroatSinuses==''){
						alert("Please enter Nose, Throat & Sinuses.");
						showhide('button4');
						$('#noseThroatSinuses').focus();
						return false;
					}
					
					 var audiometryRecord=$("#audiometryRecord  option:selected" ).text();
					 if(audiometryRecord=='Select'){
						alert("Please Select Audiometry Record.");
						showhide('button4');
						$('#audiometryRecord').focus();
						return false;
					 }
					 
					 var ageValue=$('#age').val();
					 var ageGender="";
					 if(ageValue!=""){
						 ageGender=ageValue.split("/");
					 }
					 if(ageGender[1]!=null && (ageGender[1]=='FEMALE'|| ageGender[1]=='Female') ){
					 var mensturalHistory=$('#mensturalHistory').val();
						if(mensturalHistory==''){
							alert("Please enter Menstural History.");
							showhide('button14');
							$('#mensturalHistory').focus();
							return false;
						}
					 
					 
					 
					 var lMP=$('#lMP').val();
						if(lMP==''){
							alert("Please enter lMP.");
							showhide('button14');
							$('#lMP').focus();
							return false;
						}
						 
						 var nosOfPregnancies=$('#nosOfPregnancies').val();
							if(nosOfPregnancies==''){
								alert("Please enter Nos of Pregnancies.");
								return false;
							}
					 
					 
						 var nosOfAbortions=$('#nosOfAbortions').val();
							if(nosOfAbortions==''){
								alert("Please enter Nos of Abortions.");
								return false;
							}	
									
									
						 var nosOfChildren=$('#nosOfChildren').val();
							if(nosOfChildren==''){
								alert("Please enter Nos of Children.");
								return false;
							}	
						
									
					 var dateOfLastConfinement=$('#childDateOfLastConfinement').val();
						if(dateOfLastConfinement==''){
							alert("Please enter Date of Last Confinement.");
							showhide('button14');
							$('#dateOfLastConfinement').focus();
							return false;
						}
									
						 var vaginalDischarge=$('#vaginalDischarge').val();
							if(vaginalDischarge==''){
								alert("Please enter Vaginal Discharge.");
								showhide('button14');
								$('#vaginalDischarge').focus();
								return false;
							}	
									
						/* var dateOfLastConfinement=$('#childDateOfLastConfinement').val();
							if(dateOfLastConfinement==''){
								alert("Please enter Date of Last Confinement.");
								showhide('button14');
								$('#dateOfLastConfinement').focus();
								return false;
							}	*/
									

						 var usgAbdomen=$('#usgAbdomen').val();
							if(usgAbdomen==''){
								alert("Please enter USG Abdomen.");
								showhide('button14');
								$('#usgAbdomen').focus();
								return false;
							}		
														
						 var prolapse=$('#prolapse').val();
							if(prolapse==''){
								alert("Please enter Prolapse.");
								showhide('button14');
								$('#prolapse').focus();
								return false;
							}		
					 }
					 
				return true;				
 }
 
 
 function getMasDesignationMappingByUnitId(){
	 

	 var approvalFlag=$('#approvalFlag').val();
	 var approvalFlagDiasable="";
	 if(approvalFlag!="" && approvalFlag!=undefined && approvalFlag!=null && approvalFlag=='y'){
		 approvalFlagDiasable='disabled';
	 }
	 else{
		 approvalFlagDiasable="";
	 }
	 
	 var forwardedUnitId=$( "#forwardTo option:selected" ).val();
	 
	 if(forwardedUnitId=='0'){
		 return false;
	 }
	 var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";
	 var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalexam/getMasDesignationMappingByUnitId";
	 $.ajax({
			url : url,
			dataType : "json",
			data : JSON.stringify({
				'forwardedUnitId' : forwardedUnitId
			}),
			contentType : "application/json",
			type : "POST",
			success : function(response) {
				var dataDesignationObjList=response.dataDesignationList;
				var masDesignationSelectedValue="";
				masDesignationSelectedValue+='<select class="form-control" name=designationForMe id="designationForMe" '+approvalFlagDiasable+'>';
				masDesignationSelectedValue+='<option value="0">Select</option>';
				if(dataDesignationObjList!=null && dataDesignationObjList!=undefined && dataDesignationObjList.length!=0)
				for(var i=0;i<dataDesignationObjList.length;i++){
					
					var desinationIdArray=dataDesignationObjList[i].designationId.split(",");
					var desinationNameArray=dataDesignationObjList[i].designamtionName.split(",")
					//user for remove designation
				
					for(var j=0;j<desinationIdArray.length;j++){
							masDesignationSelectedValue +='<option value="' 
									+  desinationIdArray[j] + '" >' +  desinationNameArray[j]
								+ '</option>'; 
					}
					masDesignationSelectedValue+='</select >';
				}
			if(dataDesignationObjList!=null && dataDesignationObjList!=undefined && dataDesignationObjList!="" &&  dataDesignationObjList.length!=0){
				$('#designationForMe').html(masDesignationSelectedValue);
				$('#designationMeId').show();
			}
			else{
				$('#designationForMe').html(masDesignationSelectedValue);
				$('#designationMeId').show();
			}
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
 
 
 
 function getMasDesignationMappingByUnitIdByHospitalIdAndDesig(hospitalId){
	 var designationId=$('#designationIdValue').val();
	 var forwardedUnitId= hospitalId;
	 if(forwardedUnitId=='Select'){
		 return false;
	 }
	 var approvalFlag=$('#approvalFlag').val();
	 var approvalFlagDiasable="";
	 if(approvalFlag!="" && approvalFlag!=undefined && approvalFlag!=null && approvalFlag=='y'){
		 approvalFlagDiasable='disabled';
	 }
	 else{
		 approvalFlagDiasable="";
	 }
	 
	 
	 $.ajax({
			url : "getMasDesignationMappingByUnitId",
			dataType : "json",
			data : JSON.stringify({
				'forwardedUnitId' : forwardedUnitId
			}),
			contentType : "application/json",
			type : "POST",
			success : function(response) {
				var dataDesignationObjList=response.dataDesignationList;
				var masDesignationSelectedValue="";
				masDesignationSelectedValue+='<select class="form-control" name="designationForMe" id="designationForMe" '+approvalFlagDiasable+'>';
				masDesignationSelectedValue+='<option value="0">Select</option>';
				
				if(dataDesignationObjList!=null && dataDesignationObjList!=undefined && dataDesignationObjList.length!=0)
				for(var i=0;i<dataDesignationObjList.length;i++){
					
					var desinationIdArray=dataDesignationObjList[i].designationId.split(",");
					var desinationNameArray=dataDesignationObjList[i].designamtionName.split(",")
					//user for remove designation
					
					var selectedDesi='';	
					for(var j=0;j<desinationIdArray.length;j++){
						
						if(desinationIdArray[j]==designationId){
							selectedDesi='selected';
						}
						else{
							selectedDesi='';
						}
							masDesignationSelectedValue +='<option '+selectedDesi+' value="' 
									+  desinationIdArray[j] + '" >' +  desinationNameArray[j]
								+ '</option>'; 
					}
					masDesignationSelectedValue += '</select>';
				}
			if(dataDesignationObjList!=null && dataDesignationObjList!=undefined && dataDesignationObjList!="" &&  dataDesignationObjList.length!=0){
				$('#designationForMe').html(masDesignationSelectedValue);
				$('#designationMeId').show();
			}
			else{
				$('#designationForMe').html(masDesignationSelectedValue);
				$('#designationMeId').show();
				
			}
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
 
 
 
 
/* function closeMessageForm(){
	$('#messageForDesignation')..hide();
	$('.modal-backdrop').hide();
}*/
 
 function returnApproval(flag){
	 var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";
	 var urlmeApprove = window.location.protocol + "//" + window.location.host + "/" + accessGroup ;
	 if(flag=='approved'){
		 
	 window.location.href =urlmeApprove + "/approve/meApproved";
	 }
	 if(flag=='reject'){
		 window.location.href =urlmeApprove + "/approve/meReject";
 }
	 if(flag=='getMeMbHis'){
		// window.location.href =urlmeApprove + "/medicalexam/getHistory";
		 window.close();
	 }
 }
 
 function diasableFormField(){
	 var draftRMo=$('#saveInDraft').val();
	 $('input').attr('readonly','readonly');
	 $('select').attr('readonly','readonly');
	 $('textarea').attr('readonly','readonly');
	 $('button').attr('readonly','readonly');
	 if((draftRMo=='draftRMo' || draftRMo=='draftPRMo')||(draftRMo=='draftRMo18' || draftRMo=='draftPRMo18')||(draftRMo=='draftRMo3A' || draftRMo=='draftPRMo3A')){
		 $('#submitByMo').removeAttr('readonly');
		 $('#actionMe').removeAttr('readonly');
	 }
	
	 $('#closebtn').removeAttr('readonly');
	$('.uneditableEditorView .jqte_editor').attr('contenteditable','false');
	/*try{
		$('.uneditableEditor .jqte_editor').attr('contenteditable','false');
		$('.uneditableEditorResult .jqte_editor').attr('contenteditable','false');
		
	}
catch(e){} */
$('.modal input, .modal button').removeAttr('readonly');

 }

 
 function getDateComapare(fromDate,toDate){
	 var countDateV=0;
	 
	 var fCurrentDateVal=fromDate.split("/");
		var fddate=fCurrentDateVal[0];
		var fmonth=fCurrentDateVal[1];
		var fyear=fCurrentDateVal[2];
		var fUpdateDate=fCurrentDateVal[1]+"/"+fCurrentDateVal[0]+"/"+fCurrentDateVal[2];
		
		 var tCurrentDateVal=toDate.split("/");
			var tddate=tCurrentDateVal[0];
			var tmonth=tCurrentDateVal[1];
			var tyear=tCurrentDateVal[2];
		
			var tUpdateDate=tCurrentDateVal[1]+"/"+tCurrentDateVal[0]+"/"+tCurrentDateVal[2];	
	 var g1 = new Date(fUpdateDate); 
	    var g2 = new Date(tUpdateDate); 
	    if (g1.getTime() > g2.getTime()){
	    	 
	    	countDateV+=1;
	    	return countDateV;
	    }
	    return countDateV;
 }
 
 function validatePortalForm18(){
	 
	 
	 var dateOfRelease=$('#dateOfRelease').val();
	 if(dateOfRelease==""){
		 alert("Please enter Release Date.");
		 return false;
	 }
	 var authorityForBoard=$('#authorityForBoard').val();
	 if(authorityForBoard==""){
		 alert("Please enter Authority for Board.");
		 return false;
	 }
	 
	 
	 
		var countServiceDetail=0;
		var countDate=0;
		  $('#serviceDetailsIdGrid tr').each(function(i, el) {
	    	    var $tds = $(this).find('td')
	    	    var fromDate = $tds.eq(1).find(":input").val();
	    	    var toDate = $tds.eq(2).find(":input").val();
	    	    var place  = $tds.eq(3).find(":input").val();
	    	    var pf = $tds.eq(4).find(":input").val();
	    	 if(fromDate.trim()== "" || toDate.trim()=="" || (place.trim()=="" || place.trim() =='0') ||pf.trim()=="")
	  	    {
	    		 countServiceDetail+=1;
	      		return false;
	      		    	
	  		}
	    	 
	    	 countDate=getDateComapare(fromDate,toDate);
	    	 if(countDate!=0){
	    		 return false;
	    	 }
	    	  
		  });

		  if(countServiceDetail>0){
			  alert("Please fill all Service Details Data.");
			  return false;
		  }
		  
			var countDiseasWound=0;
			var countDiseasWoundDate=0;
			  $('#diseaseWoundInjuryDetailsGrid tr').each(function(i, el) {
		    	    var $tds = $(this).find('td')
		    	    var icdDia = $tds.eq(0).find(":input").val();
		    	    var fDate = $tds.eq(1).find(":input").val();
		    	    var fPlace  = $tds.eq(2).find(":input").val();
		    	    var wTreated = $tds.eq(3).find(":input").val();
		    	    var aFrom  = $tds.eq(4).find(":input").val();
		    	    var aTo = $tds.eq(5).find(":input").val();
		    	 
		    	 if(icdDia.trim()== "" || fDate.trim()=="" || fPlace.trim()=="" ||wTreated.trim()=="" ||aFrom.trim()=="" ||aTo.trim()=="")
		  	    {
		    		 countDiseasWound+=1;
		      		return false;
		      		    	
		  		}
		   if(aFrom!=null && aFrom!="" && aTo!=null && aTo!=""){ 	 
		     countDiseasWoundDate = getDateComapare(aFrom,aTo);
		    	 if(countDiseasWoundDate!=0){
		    		 return false;
		    	 }
		    	}
		    	 });

			  if(countDiseasWound>0){
				  alert("Please fill all Disease Details Data.");
				  return false;
			  }
			  
			  	  
			  	var claimAnyDisabilityDate=0;
			var claimAnyDisability=  $( "#disabilityBeforeJoining option:selected" ).text();
				var countDiseasWoundArmed=0;
				if(claimAnyDisability=='Yes'){
				  $('#diseaseWoundInjuryArmedForces tr').each(function(i, el) {
			    	    var $tds = $(this).find('td')
			    	    var fDate = $tds.eq(0).find(":input").val();
			    	    var tDate = $tds.eq(1).find(":input").val();
			    	    var fPlace  = $tds.eq(2).find(":input").val();
			    	     
			    	 if(fDate.trim()== "" || tDate.trim()=="" || fPlace.trim()=="")
			  	    {
			    		 countDiseasWoundArmed+=1;
			      		return false;
			      		    	
			  		}
			    	 if(fDate!="" && tDate!=""){
			    		 
			    		claimAnyDisabilityDate = getDateComapare(fDate,tDate);
			     	 if(claimAnyDisabilityDate!=0){
			    		 return false;
			    	 }
			    	 }
			    	 
			    	 
			    	 
			    	 });
				}
				  if(countDiseasWoundArmed>0){
					  alert("Please fill all Armed Disease Details Data.");
				  return false;
				  }

				  if(countDate> 0 || countDiseasWoundDate>0 || claimAnyDisabilityDate>0){
					  alert("To date should not be earlier than the From date.");
					  return false;
				  }
				  
				  var serviceNoForEmployee=$('#serviceNoForEmployee').val();
					 if(serviceNoForEmployee==""){
						 alert("Please enter service number of witness.");
						 return false;
					 }
					 
				  return true;
 }
 
 
 
 function submitPortalForm18(flagForSubmit) {
	 var count=0;
	 if(!fileValidate()){
		 count=1;
			return false;
		}
	 
	  if(validatePortalForm18() && count==0){
			$('#saveInDraft').val(flagForSubmit);
			$("#submitMedicalExamByMAForm18").submit();
			$("#submitMAForma18").attr("disabled", true);
				return true;
	}
 }
 
 function submitMAForm18P(flagForSubmit) {
	 try{
	 $('#obsistyMark').val(obsistyOverWeight);
 }
 catch(e){}
 var count=0;
 var countServiceDetail=0;
	var countDate=0;
	
		var tbl = document.getElementById('serviceDetailsIdGrid');
		var lastRow = tbl.rows.length;
   	if(lastRow>1){
   		
	  $('#serviceDetailsIdGrid tr').each(function(i, el) {
 	    var $tds = $(this).find('td')
 	    var fromDate = $tds.eq(1).find(":input").val();
 	    var toDate = $tds.eq(2).find(":input").val();
 	    var place  = $tds.eq(3).find(":input").val();
 	    var pf = $tds.eq(4).find(":input").val();
 	 if(fromDate== "" || toDate=="" || (place=="" || place =='0') ||pf=="")
	    {
 		 countServiceDetail+=1;
 		count++;
   		return false;
   		    	
		}
 	 
 	 countDate=getDateComapare(fromDate,toDate);
 	 if(countDate!=0){
 		 return false;
 	 }
 	  
	  });
   	}
   	
	  if(countServiceDetail>0){
		  count++;
		  alert("Please fill all Service Details Data.");
		  return false;
	  }
	  
	  
	  
	  var countDiseasWound=0;
		var countDiseasWoundDate=0;
		var tbl = document.getElementById('diseaseWoundInjuryDetailsGrid');
		var lastRow = tbl.rows.length;
   	if(lastRow>1){
   		
		  $('#diseaseWoundInjuryDetailsGrid tr').each(function(i, el) {
	    	    var $tds = $(this).find('td')
	    	    var icdDia = $tds.eq(0).find(":input").val();
	    	    var fDate = $tds.eq(1).find(":input").val();
	    	    var fPlace  = $tds.eq(2).find(":input").val();
	    	    var wTreated = $tds.eq(3).find(":input").val();
	    	    var aFrom  = $tds.eq(4).find(":input").val();
	    	    var aTo = $tds.eq(5).find(":input").val();
	    	 
	    	 if(icdDia.trim()== "" || fDate.trim()=="" || fPlace.trim()=="" ||wTreated.trim()=="" ||aFrom.trim()=="" ||aTo.trim()=="")
	  	    {
	    		 count++;
	    		 countDiseasWound+=1;
	      		return false;
	      		    	
	  		}
	   if(aFrom!=null && aFrom!="" && aTo!=null && aTo!=""){  	 
	     countDiseasWoundDate = getDateComapare(aFrom,aTo);
	    	 if(countDiseasWoundDate!=0){
	    		 return false;
	    	 }
	    	  
	    	}
	   });
   	}

		  if(countDiseasWound>0){
			  count++;
			  alert("Please fill all Disease Details Data.");
			  return false;
		  }
 
		 	var claimAnyDisabilityDate=0;
			var claimAnyDisability=  $( "#disabilityBeforeJoining option:selected" ).text();
				var countDiseasWoundArmed=0;
				if(claimAnyDisability=='Yes'){
				  $('#diseaseWoundInjuryArmedForces tr').each(function(i, el) {
			    	    var $tds = $(this).find('td')
			    	    var fDate = $tds.eq(0).find(":input").val();
			    	    var tDate = $tds.eq(1).find(":input").val();
			    	    var fPlace  = $tds.eq(2).find(":input").val();
			    	     
			    	 if(fDate.trim()== "" || tDate.trim()=="" || fPlace.trim()=="")
			  	    {	count++;
			    		 countDiseasWoundArmed+=1;
			      		return false;
			      		    	
			  		}
			    	 if(fDate!="" && tDate!=""){
			    		 
			    		claimAnyDisabilityDate = getDateComapare(fDate,tDate);
			     	 if(claimAnyDisabilityDate!=0){
			    		 return false;
			    	 }
			    	 }
			    	 });
				}
				  if(countDiseasWoundArmed>0){
					  count++;
					  alert("Please fill all disability before joining the Armed Forces data.");
					  return false;
				  }
		  
				  if(countDate> 0 || countDiseasWoundDate>0 || claimAnyDisabilityDate>0){
					  count++;
					  alert("To date should not be earlier than the From date.");
					  return false;
				  }
 if(count==0){
	 $('#saveInDraft').val(flagForSubmit);
			$("#submitMedicalExamByMAForm18").submit();
			$("#submitMAForma18").attr("disabled", true);
				return true;
 }
}
 
 function submitMAForm18(flagForSubmit) {
	 try{
		 $('#obsistyMark').val(obsistyOverWeight);
	 }
	 catch(e){}
	 var count=0;
	 if(!fileValidate()){
		 count=1;
		 return false;
		}
		$('#saveInDraft').val(flagForSubmit);
		
		var selectObj="";
		
		
		if(flagForSubmit!="" && flagForSubmit!='draftMa18'){
			var jqetFinedValue=$('#finalObservationMoJ').val();
			$('#finalObservationMo').val("");
			$('#finalObservationMo').val(jqetFinedValue);
			 var jqetFinedValue1=$('#finalObservationRmoJ').val();
			$('#finalObservationRmo').val("");
			$('#finalObservationRmo').val(jqetFinedValue1);
			
			 var  jqetFinedValue2=$('#finalObservationPRmoJ').val();
			$('#finalObservationPRmo').val("");
			$('#finalObservationPRmo').val(jqetFinedValue2);
			
			}
		
		if(getValidateForAction() && validatePortalForm18()){ 
			
			if(flagForSubmit!="" && flagForSubmit!='draftMa18'){
				var resultCountValue=validateForm();
				var selectObj = document.getElementById("actionMe");
				if(resultCountValue>0){
					if(selectObj!=null && selectObj!=""){
				        if (selectObj.options[selectObj.selectedIndex].value=='approveAndClose' 
				        	|| selectObj.options[selectObj.selectedIndex].value=='approveAndForward' || selectObj.options[selectObj.selectedIndex].value=='referred') {
				        alert(""+resourceJSON.msgActionNotCompleted);
				        count+=1;
				        return false;
				        }
					}
				}
				 if (selectObj!="" && selectObj.options[selectObj.selectedIndex].value=='approveAndForward') {
				var selectedValue=$( "#forwardTo option:selected" ).text();
				if(count==0 && selectedValue!=null && selectedValue!=""){
					if (selectedValue=='Select') {
							alert(""+resourceJSON.msgHopital);
							count+=1;
					        return false;
					}
					}
				var selectedValueDesi=$( "#designationForMe option:selected" ).text();
				if(count==0 && selectedValueDesi!=null && selectedValueDesi!=""){
					if (selectedValueDesi=='Select') {
						alert("Please select Designation.");
						count+=1;
				        return false;
			
					}
				}
		        }
			}
			if(count==0){
				checkBoxFitInCatMe();
			}
			
			
			 if(flagForSubmit!='draftMa18'){
				 var medicalCategoryIDVal=0;
				 var tbl = document.getElementById('medicalCategory');
				 var 	lastRow = tbl.rows.length;
				 
				 if(document.getElementById('fitInChk').value!=null && document.getElementById('fitInChk').checked==false){
					
					 $('#medicalCategory tr').each(function(i, el) {
	      				  var $tds = $(this).find('td');
						  var diagnosisValue = $($tds).closest('tr').find("td:eq(0)").find("input:eq(0)").val();
						if(diagnosisValue==null || diagnosisValue=="" || diagnosisValue==undefined){
							medicalCategoryIDVal++;
						}
					 });
				 }
				 if(medicalCategoryIDVal!=0){
					 alert("Please provide any Category.");
					 count++;	 
				 }
				 
				/* $('#fileUploadforInvesDynamic tr').each(function(ij, el) {
				 		var fileNameValueIDd= $(this).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id"); 
						 	 
				 		var fileNameValue=$('#'+fileNameValueIDd).val();
						var filenameWithExtension=getFilenameAndReplcePath(fileNameValue);
						if(filenameWithExtension!="" && filenameWithExtension!=null && validateFileExtension(filenameWithExtension, "valid_msg", "Only pdf/image files are allowed !",
							      new Array("jpg","pdf","jpeg","gif","png","PNG","JPEG","JPG","GIF")) == false)
							      {
									count++;
							 		return false;
							      }
				 		
						});*/
				 
					var fileNameValue1=$('#medicalExamFileUpload').val();
					var filenameWithExtension=getFilenameAndReplcePath(fileNameValue1);
					if(filenameWithExtension!="" && filenameWithExtension!=null && validateFileExtension(filenameWithExtension, "valid_msg", "Only pdf/image files are allowed !",
						      new Array("jpg","pdf","jpeg","gif","png","PNG","JPEG","JPG","GIF")) == false)
						      {
								count++;
						 		return false;
						      }
					var checkFileName=0;
					if(filenameWithExtension!="" && filenameWithExtension!=undefined && filenameWithExtension!=null)
						if(checkForFileCondition(filenameWithExtension)){
							checkFileName++;
							count++;
						}
					if(checkFileName>0){
				 		alert("File contain special character.Please upload valid file.");
				 		return false;
				 	 }
				 
			 }
			
			if(count==0){
				if(selectObj.options[selectObj.selectedIndex].value!='pending' && selectObj.options[selectObj.selectedIndex].value!='referred'
					&&  selectObj.options[selectObj.selectedIndex].value!='reject'){	
			if(validateMedicalExamForm()){
				if(flagForSubmit!='draftMa18'){
					if(selectObj.options[selectObj.selectedIndex].value=='approveAndForward'){
					var designationNameVal=$( "#designationForMe option:selected" ).text();
					$('#designationName').text(designationNameVal);
					$('#messageForDesignation').show();
					$('.modal-backdrop').show();
					}
					else{
						$("#submitMedicalExamByMAForm18").submit();
						$("#submitMAForma18").attr("disabled", true);
					}
				}
				else{
					$("#submitMedicalExamByMAForm18").submit();
					$("#submitMAForma18").attr("disabled", true);
				
				}
				}
			
			}else{
				if(flagForSubmit!='draftMa18' && selectObj.options[selectObj.selectedIndex].value=='approveAndForward'){
					var designationNameVal=$( "#designationForMe option:selected" ).text();
					$('#designationName').text(designationNameVal);
					$('#messageForDesignation').show();
					$('.modal-backdrop').show();
				}
				else{
				$("#submitMedicalExamByMAForm18").submit();
				$("#submitMAForma18").attr("disabled", "disabled");
				
				}
				}
				
				
			}
				
		}
		return true;
	}
 function submitMOFormByModel18(){
	 $("#submitMedicalExamByMAForm18").submit();
		$("#submitMAForma18").attr("disabled", true);
		$("#submitMOFormByModel18Diaglog").attr("disabled", "disabled");
	}

 
 
 
 
 
 function getAFMSF3BForMOOrMA18() {
		var visitId = $('#visitId').val();
		var age = $('#ageForPatient').val();
		var userId=$('#userId').val();
		var patientId=$('#patientId').val();
		 var approvalFlagCheckStatus=$('#approvalFlag').val();
		 
		
		
		var data = {
				"visitId" : visitId,
				"flagForForm" :"f3",
				"age":age,
				"userId":userId,
				"patientId":patientId
			};
		var pathname = window.location.pathname;
	     var accessGroup = "MMUWeb";
		 var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalexam/getAFMSF3BForMOOrMA";
		
			$.ajax({

				type : "POST",
				contentType : "application/json",
				url : url,

				data : JSON.stringify(data),
				dataType : "json",
				// cache: false,

				success : function(res) {
					 data = res.listOfResponse;
					 var listMasServiceType = res.listMasServiceType;
					    var serviceType="";
					 if (data != undefined && data != null) {
						 if(data[0].totalNoOfTeath!=null && data[0].totalNoOfTeath!="")
							$('#totalNoOfTeath').val(data[0].totalNoOfTeath);
						 if(data[0].totalNoOfDefective!=null && data[0].totalNoOfDefective!="")
							$('#totalNoOfDefective').val(data[0].totalNoOfDefective);
						 if(data[0].totalNoOfDentalPoints!=null && data[0].totalNoOfDentalPoints!="")
							$('#totalNoOfDentalPoints').val(data[0].totalNoOfDentalPoints);
						 if(data[0].missing!=null && data[0].missing!="")
							$('#missing').val(data[0].missing);
						 if(data[0].unSavable!=null && data[0].unSavable!="")
							$('#unSavable').val(data[0].unSavable);
						 if(data[0].conditionOfGums!=null && data[0].conditionOfGums!="")
							$('#conditionOfGums').val(data[0].conditionOfGums);
							
							var glopbalVarForAll;
							 var missingTeethUr=data[0].missingTeethUr;
							 if(missingTeethUr!="" && missingTeethUr!=null){
								 glopbalVarForAll=missingTeethUr.split(",");
								 checkForTeeth("urMChecked",glopbalVarForAll);
							 }
							 
							 var missingTeethUl=data[0].missingTeethUl;
							 if(missingTeethUl!="" && missingTeethUl!=null){
								 glopbalVarForAll=missingTeethUl.split(",");
								 checkForTeeth("ulMChecked",glopbalVarForAll);
							 }
							 var missingTeethLL=data[0].missingTeethLL;
							 
							 if(missingTeethLL!="" && missingTeethLL!=null){
								 glopbalVarForAll=missingTeethLL.split(",");
								 checkForTeeth("llMChecked",glopbalVarForAll);
							 }
							 
							 var missingTeethLR=data[0].missingTeethLR;
							 
							 if(missingTeethLR!="" && missingTeethLR!=null){
								 glopbalVarForAll=missingTeethLR.split(",");
								 checkForTeeth("lrMChecked",glopbalVarForAll);
							 }
							 
							 var unsavableTeethUr=data[0].unsavableTeethUr;
							 if(unsavableTeethUr!="" && unsavableTeethUr!=null){
								 glopbalVarForAll=unsavableTeethUr.split(",");
								 checkForTeeth("unurChecked",glopbalVarForAll);
							 }
							 var unsavableTeethUl=data[0].unsavableTeethUl;
							 if(unsavableTeethUl!="" && unsavableTeethUl!=null){
								 glopbalVarForAll=unsavableTeethUl.split(",");
								 checkForTeeth("unulChecked",glopbalVarForAll);
							 }
							 
							 var unsavableTeethLl=data[0].unsavableTeethLl;
							 if(unsavableTeethLl!="" && unsavableTeethLl!=null){
								 glopbalVarForAll=unsavableTeethLl.split(",");
								 checkForTeeth("unllChecked",glopbalVarForAll);
							 }
							 
							 var unsavableTeethLr=data[0].unsavableTeethLr;
							 if(unsavableTeethLr!="" && unsavableTeethLr!=null){
								 glopbalVarForAll=unsavableTeethLr.split(",");
								 checkForTeeth("unlrChecked",glopbalVarForAll);
							 }
							 if(data[0].dentalOffier!=null && data[0].dentalOffier!="")
							 $('#dentalOffier').val(data[0].dentalOffier);
							 if(data[0].remarks!=null && data[0].remarks!=""){
								 $('#remarks').val(data[0].remarks);
							 }
							 if(data[0].remarkAdvice!=null && data[0].remarkAdvice!="")
							 $('#remarkAdvice').val(data[0].remarkAdvice);
							 
							 var pcHeight=data[0].pcHeight;
							 if(pcHeight!=null && pcHeight!="")
							 $('#height').val(pcHeight);
							 
							 var pcWeight=data[0].pcWeight;
							 if(pcWeight!=null && pcWeight!="")
							 $('#weight').val(pcWeight);
							 
							 var pcIdealWeight=data[0].pcIdealWeight;
							 if(pcIdealWeight!=null && pcIdealWeight!="")
							 $('#idealWeight').val(pcIdealWeight);
							 
							 var pcOverWeight=data[0].pcOverWeight;
							 if(pcOverWeight!=null && pcOverWeight!="")
							 $('#overWeight').val(pcOverWeight);
							 
							 var pcBmi=data[0].pcBmi;
							 if(pcBmi!=null && pcBmi!="")
							 $('#bmi').val(pcBmi);
							 
							 var pcBodyFat=data[0].pcBodyFat;
							 if(pcBodyFat!=null && pcBodyFat!="")
							 $('#bodyFat').val(pcBodyFat);
							 
							 var pcWaist=data[0].pcWaist;
							 if(pcWaist!=null && pcWaist!="")
							 $('#waist').val(pcWaist);
							 
							 /*var pcHip=data[0].pcHip;
							 $('#hip').val(pcHip);*/
							 
							 
							/* var pcWhr=data[0].pcWhr;
							 $('#whr').val(pcWhr);*/
							 
							 var pcSkinFoldExpansion=data[0].pcSkinFoldExpansion;
							 if(pcSkinFoldExpansion!=null && pcSkinFoldExpansion!="")
							 $('#skinFoldExpansion').val(pcSkinFoldExpansion);
							 
							 var pcChestFullExpansion=data[0].pcChestFullExpansion;
							 if(pcChestFullExpansion!=null && pcChestFullExpansion!="")
							 $('#chestFullExpansion').val(pcChestFullExpansion);
							 
							 var pcRangeOfExpansion=data[0].pcRangeOfExpansion;
							 if(data[0].pcRangeOfExpansion!=null && data[0].pcRangeOfExpansion!="" && data[0].pcRangeOfExpansion!=undefined)
							 $('#rangeOfExpansion').val(pcRangeOfExpansion);
							 
							 var skin=data[0].skin;
							 if(skin!=null && skin!="")
							 $('#skin').val(skin);
							 
							 
							 var pcSportsman=data[0].pcSportsman;
							 if(pcSportsman!=null && pcSportsman!="")
							 setSelectedValue("sportsman",pcSportsman);
							  //Vision start
								
								 var distantWithoutGlasses=data[0].distantWithoutGlasses;
								 if(distantWithoutGlasses!=null && distantWithoutGlasses!="")
								 setSelectedValue("distantWithoutGlasses",distantWithoutGlasses);
							 
								 var distantWithoutGlassesL=data[0].distantWithoutGlassesL;
								 if(distantWithoutGlassesL!=null && distantWithoutGlassesL!="")
								 setSelectedValue("distantWithoutGlassesL",distantWithoutGlassesL);	
								 
								 var nearWithoutGlasses=data[0].nearWithoutGlasses;
								 if(nearWithoutGlasses!=null && nearWithoutGlasses!="")
								 setSelectedValue("nearWithoutGlasses",nearWithoutGlasses);
								 
								 var nearWithoutGlassesL=data[0].nearWithoutGlassesL;
								 if(nearWithoutGlassesL!=null && nearWithoutGlassesL!="")
								 setSelectedValue("nearWithoutGlassesL",nearWithoutGlassesL);
								
								 
								 var cpWithoutGlasses=data[0].cpWithoutGlasses;
								 if(cpWithoutGlasses!=null && cpWithoutGlasses!="")
								 setSelectedValue("cpWithoutGlasses",cpWithoutGlasses);
							 
								 
								 var distantWithGlasses=data[0].distantWithGlasses;
								 if(distantWithGlasses!=null && distantWithGlasses!="")
								 setSelectedValue("distantWithGlasses",distantWithGlasses);
								 
								 var distantWithGlassesL=data[0].distantWithGlassesL;
								 if(distantWithGlassesL!=null && distantWithGlassesL!="")
								 setSelectedValue("distantWithGlassesL",distantWithGlassesL);
								 
								 
								 var nearWithGlasses=data[0].nearWithGlasses;
								 if(nearWithGlasses!=null && nearWithGlasses!="")
								 setSelectedValue("nearWithGlasses",nearWithGlasses);
							
								 
								 var nearWithGlassesL=data[0].nearWithGlassesL;
								 if(nearWithGlassesL!=null && nearWithGlassesL!="")
								 setSelectedValue("nearWithGlassesL",nearWithGlassesL);
								 
							//Hearing
								 
							 var fwR=data[0].fwR;
							 if(fwR!=null && fwR!="")
							 $('#fwR').val(fwR);
							 
							 var fwL=data[0].fwL;
							 if(fwL!=null && fwL!="")
							 $('#fwL').val(fwL);
							 
							 var fwBoth=data[0].fwBoth;
							 if(fwBoth!=null && fwBoth!="")
							 $('#fwBoth').val(fwBoth);
							 
							 var cvR=data[0].cvR;
							 if(cvR!=null && cvR!="")
							 $('#cvR').val(cvR);
							 
							 var cvL=data[0].cvL;
							 if(cvL!=null && cvL!="")
							 $('#cvL').val(cvL);
							 
							 var cvBoth=data[0].cvBoth;
							 if(cvBoth!=null && cvBoth!="")
							 $('#cvBoth').val(cvBoth);
							 
							 var tmR=data[0].tmR;
							 if(tmR!=null && tmR!="")
							 setSelectedValue("tmR",tmR);
							 
							 var tmL=data[0].tmL;
							 if(tmL!=null && tmL!="")
							 setSelectedValue("tmL",tmL);
							 
							 var mobilityR=data[0].mobilityR;
							 //$('#mobilityR').val(mobilityR);
							 if(mobilityR!=null && mobilityR!="")
							 setSelectedValue("mobilityR",mobilityR);
							 
							 var mobilityL=data[0].mobilityL;
							 //$('#mobilityL').val(mobilityL);
							 if(mobilityL!=null && mobilityL!="")
							 setSelectedValue("mobilityL",mobilityL);
							 
							 var noiseThroatSinuses=data[0].noiseThroatSinuses;
							 if(noiseThroatSinuses!=null && noiseThroatSinuses!="")
							 $('#noseThroatSinuses').val(noiseThroatSinuses);
							 
							 var audiometryRecord=data[0].audiometryRecord;
							 
							 //$('#audiometryRecord').val(audiometryRecord);
							 if(audiometryRecord!=null && audiometryRecord!="")
							 setSelectedValue("audiometryRecord",audiometryRecord);
							 if(audiometryRecord!=null && audiometryRecord=='Others'){
							 var audiometryRecordOthers=data[0].audiometryRecordForOther;
							 $('#audiometryRecordForOther').val(audiometryRecordOthers);
							 $('#audiometryRecordForDisplay').show();
							 }
							 else{
								 $('#audiometryRecordForDisplay').hide();
							 }
							 var clinicalNotes=data[0].clinicalNotes;
							 if(clinicalNotes!=null && clinicalNotes!="")
							 $('#clinicalNotes').val(clinicalNotes);
							 
							 var pluse=data[0].pluse;
							 if(pluse!=null && pluse!="")
							 $('#pulse').val(pluse);
							 
							 var bp=data[0].bp;
							 if(bp!=null && bp!="")
							 $('#bp').val(bp);
							 
							 var bp1=data[0].bp1;
							 if(bp1!=null && bp1!="")
							 $('#bp1').val(bp1);
							 
							 var heartSize=data[0].heartSize;
							 if(heartSize!=null && heartSize!="")
							 $('#heartSize').val(heartSize);
							 
							 var sounds=data[0].sounds;
							 if(sounds!=null && sounds!="")
							 $('#sounds').val(sounds);
							 
							 var rhythm=data[0].rhythm;
							 if(rhythm!=null && rhythm!="")
							 $('#rhythm').val(rhythm);
							 
							 var respiratorySystem=data[0].respiratorySystem;
							 if(respiratorySystem!=null && respiratorySystem!="")
							 $('#respiratorySystem').val(respiratorySystem);
							 
							 var liver=data[0].liver;
							 if(liver!="" && liver!=undefined){
								 setSelectedValue("liverPalpable",'Yes');
								 $('#liver').val(liver);
								 $('#liverPalpableInput').show();
							 }
							 else{
								 setSelectedValue("liverPalpable",'No'); 
								 $('#liverPalpableInput').hide();
							 }
							 
							 
							 var spleen=data[0].spleen;
							 if(spleen!=""  && spleen!=undefined){
								 setSelectedValue("spleenPalpable",'Yes');
								 $('#spleen').val(spleen);
								 $('#spleenPalpableInput').show();
								 
							 }
							 
							 else{
								 setSelectedValue("spleenPalpable",'No'); 
								 $('#spleenPalpableInput').hide();
							 }
							 var higherMentalFunction=data[0].higherMentalFunction;
							 if(higherMentalFunction!=null && higherMentalFunction!="")
							 $('#higherMentalFunction').val(higherMentalFunction);
							 
							 
							 var speech=data[0].speech;
							 if(speech!=null && speech!="")
							 $('#speech').val(speech);
							 
							 var reflexes=data[0].reflexes;
							 if(reflexes!=null && reflexes!="")
							 $('#reflexes').val(reflexes);
							 
							 var tremors=data[0].tremors;
							 if(tremors!=null && tremors!="")
							 setSelectedValue("tremors",tremors);
							 
							 var selfBalancingTest=data[0].selfBalancingTest;
							 if(selfBalancingTest!=null && selfBalancingTest!="")
							 setSelectedValue("selfBalancingTest",selfBalancingTest);
							 
							 var locomotorSystem=data[0].locomotorSystem;
							 if(locomotorSystem!=null && locomotorSystem!="")
							 $('#locomotorSystem').val(locomotorSystem);
							 
							 var spine=data[0].spine;
							 if(spine!=null && spine!="")
							 $('#spine').val(spine);
							 
							 var hernia=data[0].hernia;
							 if(hernia!=null && hernia!="")
							 $('#hernia').val(hernia);
							 
							 var hydrocele=data[0].hydrocele;
							 if(hydrocele!=null && hydrocele!="")
							 $('#hydrocele').val(hydrocele);
							 
							 var breast=data[0].breast;
							 if(breast!=null && breast!="")
							 $('#breast').val(breast);
							 
							 
							 var pcChestFullExpansion=data[0].pcChestFullExpansion;
							 if(pcChestFullExpansion!=null && pcChestFullExpansion!="")
							 $('#chestFullExpansion').val(pcChestFullExpansion);
							 
							 var opdPatientDetailId=data[0].opdPatientDetailId
							 if(opdPatientDetailId!=null && opdPatientDetailId!="")
							 $('#opdPatientDetailId').val(opdPatientDetailId);
							 
						var saveInDraft=$('#saveInDraft').val( );
						var status= data[0].status;
							 if(saveInDraft!="" && saveInDraft=='draftMo18'){
							 	$('#chiefComplaint').val( data[0].chiefComplaint);
							 
							 	$('#pollar').val( data[0].pollar);
							 	
							 	$('#ordema').val( data[0].ordema);
							 	
							 	$('#cyanosis').val( data[0].cyanosis);
								
								 
							 	$('#hairnail').val( data[0].hairnail);
							 	
							 	$('#icterus').val( data[0].icterus);
							 	
							 	$('#cyanosis').val( data[0].cyanosis);
								 
							 	$('#lymphNode').val( data[0].lymphNode);
							 	
							 	$('#clubbing').val( data[0].clubbing);
								 
							 	$('#gcs').val( data[0].gcs);
								
							 	$('#Tremors').val(data[0].geTremors);
							 	
							 	$('#others').val( data[0].others);
								
							 	$('#remarksForReferal').val( data[0].remarksForReferal);
								$('#remarksReject').val( data[0].remarksReject);
								//$('#finalObservationMo').val( data[0].finalObservationMo);
								finalObservationOfMo=data[0].finalObservationMo;
								$('#remarksPending').val( data[0].remarksPending);
								$('#nextAppointmentDate').val( data[0].nextAppointmentDate);
								
								$('#remarksReject').val( data[0].remarksReject);
								 if(approvalFlagCheckStatus=='y' || status=='rj'){
									 actionSelected(status);
								 }
								
								
								 var petStatus=data[0].petStatus;
								 
								 setSelectedValue("pet",petStatus);
								 var petDate=data[0].petDate;
								 $('#petDateValue').val(petDate);
								
								 /* if(petStatus=='y'){
									 var petDate=data[0].petDate;
									 $('#medicalExamDate').val(petDate);
									 $('#petDate').show();
								 }
								 else{
									 $('#petDate').hide();
								 }*/
								
							 }
							 
							 if(saveInDraft!="" && saveInDraft=='draftRMo18'){
								 finalObservationOfMo=data[0].finalObservationMo;
								 finalObservationOfRMo=data[0].finalObservationRmo;
									$('#finalObservationMoJ').jqteVal( data[0].finalObservationMo);
								
								 //$('#finalObservationMo').val( data[0].finalObservationMo);
									//$('#finalObservationRmo').val( data[0].finalObservationRmo);
								
									
								//	$('#remarksRmo').val( data[0].remarksRmo);
									$('#remarksForReferal').val( data[0].remarksForReferal);
									
									$('#remarksReject').val( data[0].remarksReject);
									$('#remarksForApproval').val( data[0].remarksForApproval);
									//actionSelected(status);
									 if(approvalFlagCheckStatus=='y' || status=='rj'){
										 actionSelected(status);
									 }
									var petStatus=data[0].petStatus;
									 setSelectedValue("pet",petStatus);
									 var petDate=data[0].petDate;
									 $('#petDateValue').val(petDate);
									
									/* if(petStatus=='y'){
										 var petDate=data[0].petDate;
										 $('#medicalExamDate').val(petDate);
										 $('#petDate').show();
									 }
									 else{
										 $('#petDate').hide();
									 }*/
							 }
							
							 
							 if(saveInDraft!="" && saveInDraft=='draftPRMo18'){
								// $('#finalObservationMo').val( data[0].finalObservationMo);
									//$('#finalObservationRmo').val( data[0].finalObservationRmo);
									
								 $('#finalObservationMoJ').jqteVal( data[0].finalObservationMo);
									$('#finalObservationRmoJ').jqteVal( data[0].finalObservationRmo);
									
									finalObservationOfMo=data[0].finalObservationMo;
									finalObservationOfRMo=data[0].finalObservationRmo;
									finalObservationOfPRMo=data[0].paFinalobservation;
																 
								 
									$('#remarksForReferal').val( data[0].remarksForReferal);
									
									$('#remarksReject').val( data[0].remarksReject);
									$('#remarksForApproval').val( data[0].remarksForApproval);
									//$('#finalObservationPRmo').val( data[0].paFinalobservation);
								
									
									
									//$('#remarksPRmo').val( data[0].remarksPRmo);
									//actionSelected(status);
									 if(approvalFlagCheckStatus=='y' || status=='rj'){
										 actionSelected(status);
									 }
									var petStatus=data[0].petStatus;
									 
									 setSelectedValue("pet",petStatus);
									 var petDate=data[0].petDate;
									 $('#petDateValue').val(petDate);
									
									 /* if(petStatus=='y'){
										 var petDate=data[0].petDate;
										 $('#medicalExamDate').val(petDate);
										 $('#petDate').show();
									 }
									 else{
										 $('#petDate').hide();
									 }*/
							 }
							 if(data[0].peripheralPulsations!=null && data[0].peripheralPulsations!="")
							 $('#peripheralPulsations').val(data[0].peripheralPulsations);
							 
							 /*var regularExercise=data[0].regularExercise;
							 if(regularExercise!="" && regularExercise=='y'){
								 document.getElementById('adviceToReduceWeight').checked=true;
							 }*/
							 if(data[0].checkupDate!=null && data[0].checkupDate!="")
							 $('#checkupDate').val(data[0].checkupDate);
							 if(data[0].haemorrhoids!=null && data[0].haemorrhoids!="")
							 $('#haemorrhoids').val(data[0].haemorrhoids);
							 if(data[0].moUser!=null && data[0].moUser!="")
							 $('#signedByMo').val(data[0].moUser);
							 if(data[0].rMoUser!=null && data[0].rMoUser!="")
							 $('#signedByRMo').val(data[0].rMoUser);
							 if(data[0].pRMoUser!=null && data[0].pRMoUser!="")
							 $('#signedByPRMo').val(data[0].pRMoUser);

							 if((data[0].hospitalIdFoward!=null && data[0].hospitalIdFoward!="" && saveInDraft!='draftPRMo18' && saveInDraft!='draftRMo18') || approvalFlagCheckStatus=='y'){
							 
								//$('#forwardStatus').show();
								var forwardedId=data[0].hospitalIdFoward;
								if(status!="" && status!='rj' && forwardedId!=undefined && forwardedId!="" && forwardedId!=null)
								getSelectedUnitData(forwardedId);
							 
							 }
							 
							 if(data[0].mensturalHistory!=null && data[0].mensturalHistory!="")
							 $('#mensturalHistory').val(data[0].mensturalHistory);
							 var lmpselectValue=data[0].lmpSelect;
							 if(lmpselectValue!=null && lmpselectValue!="")
							 setSelectedValue("lmpSelect",lmpselectValue);
							 if(data[0].lMP!=null && data[0].lMP!="")
							 $('#lMP').val(data[0].lMP);
							 //if(data[0].nosOfPregnancies!=null && data[0].nosOfPregnancies!="")
							 $('#nosOfPregnancies').val(data[0].nosOfPregnancies);
							 //alert(data[0].nosOfPregnancies);
							// if(data[0].nosOfAbortions!=null && data[0].nosOfAbortions!="")
							 $('#nosOfAbortions').val(data[0].nosOfAbortions);
							 

							 //if(data[0].nosOfChildren!=null && data[0].nosOfChildren!="")
							 $('#nosOfChildren').val(data[0].nosOfChildren);
							 if(data[0].childDateOfLastConfinement!=null && data[0].childDateOfLastConfinement!="")
							 $('#childDateOfLastConfinement').val(data[0].childDateOfLastConfinement);
							 if(data[0].vaginalDischarge!=null && data[0].vaginalDischarge!="")
							 $('#vaginalDischarge').val(data[0].vaginalDischarge);
							 
							 if(data[0].usgAbdomen!=null && data[0].usgAbdomen!="")
							 $('#usgAbdomen').val(data[0].usgAbdomen);
							 if(data[0].prolapse!=null && data[0].prolapse!="")
							 $('#prolapse').val(data[0].prolapse);
							 
							 if(data[0].obsistyCloseDate==null || data[0].obsistyCloseDate==""){ 
							 if(data[0].overweightFlag!=null){
									var overweightFlag= data[0].overweightFlag;
									if(overweightFlag!="" && overweightFlag=='Y'){
										$("#overCheck").prop("checked", true);
										$("#overWeightDropDown").show();
										$('#obsistyMark').val("Y");
										overWeightOb("Y");
									}
									if(overweightFlag!="" && overweightFlag=='N'){
										$("#obsistyCheck").prop("checked", true);
										$("#overWeightDropDown").hide();
										$('#obsistyMark').val("N");
										overWeightOb("N");
									}
									if(overweightFlag!="" && overweightFlag=='A'){
										$("#noneCheck").prop("checked", true);
										$("#overWeightDropDown").hide();
										$('#obsistyMark').val("A");
										overWeightOb("A");
									}
								 }
							 }
							 serviceType =  data[0].serviceType;
						}
					 
					 var approvalFlag=$('#approvalFlag').val();
					 if(approvalFlag!="" && approvalFlag!=undefined && approvalFlag=='y'){
					 if (listMasServiceType != null
								&& listMasServiceType.length > 0) {
							var masServiceTypeVal = "";
							masServiceTypeVal += '<select class="form-control" id="serviceOfEmployee" name="serviceOfEmployee"';
								masServiceTypeVal += 'class="medium">';
							masServiceTypeVal += '<option value="0"><strong>Select</strong></option>';
							for (var i = 0; i < listMasServiceType.length; i++) {
								var selectedV = '';

								if (serviceType == listMasServiceType[i].serviceTypeId) {
									selectedV = "selected";
								} else {
									selectedV = '';
								}
								masServiceTypeVal += '<option   '+selectedV+'  value="' + listMasServiceType[i].serviceTypeId+ '"  >'
										+ listMasServiceType[i].serviceTypeName
										+ '</option>';
							}
							masServiceTypeVal += '</select>';
						}
						$('#serviceOfEmployee').html(masServiceTypeVal);
					 }
				}
			});
	}

 function getdurationByType(item){
	 
	 var medCateDurationId=$(item).closest('tr').find("td:eq(4)").find("input:eq(0)").attr("id");
	 var typeOfCategoryValueId=$(item).closest('tr').find("td:eq(3)").find("select:eq(0)").attr("id");
	 var typeOfCategoryValue=$("#"+typeOfCategoryValueId+" option:selected" ).val();
	 if(typeOfCategoryValue!=""&& typeOfCategoryValue!="0" && typeOfCategoryValue=='P'){
		 var durationValue='24';
		 
		 $('#'+medCateDurationId).val(durationValue);
		 $('#'+medCateDurationId).attr('readonly','readonly');
	 }
	 else{
		 $('#'+medCateDurationId).attr('readonly',false);
		 $('#'+medCateDurationId).val('');
		
	 }
 }
  
 function generateNextDateForImmun(item) {
	 
	  var carrentDateIdValue=$(item).closest('tr').find("td:eq(1)").find("input:eq(0)").val();
	  var durationValue=$(item).closest('tr').find("td:eq(2)").find("input:eq(0)").val();
	  var nextCategoryDateId=$(item).closest('tr').find("td:eq(3)").find("input:eq(0)").attr("id");
	  if(carrentDateIdValue==null || carrentDateIdValue==""){
			return false;
	  	}
	 
	var currentDateVal=carrentDateIdValue.split("/");
	var date=currentDateVal[0];
	var month=currentDateVal[1];
	var year=currentDateVal[2];
	if(durationValue==null || durationValue==""){
		alert("Please enter  duration");
		return false;
	}
	
	var monthNew ="";	
	 
//monthNew =parseInt(month)+parseInt(durationValue);
	var yearNew ="";	
var durationarray="";
var durationValueTemp="";
var monthFromDura="";
	if(durationValue.includes(".")){
		durationarray=durationValue.split(".");
		durationValueTemp=durationarray[0];
		monthFromDura=durationarray[1];
	}
	else{
		durationValueTemp=durationValue;
	}
	year =parseInt(year)+parseInt(durationValueTemp);
	var dateNext="";
var yearNew;
var remMonthNew;
var  coYearNew;
/*if(monthNew>12){
	   var remMonthNew= parseInt(monthNew)%12;
	  var  coYearNew= parseInt(monthNew)/12;
	   coYearNew=  Math.floor(parseInt(coYearNew));
	   year=parseInt(year)+parseInt(coYearNew);
	   
	   if(date!=null && date!="" && date.toString().length==1)
	     {
	    	 date="0"+date;
	     }
	     if(remMonthNew!=null && remMonthNew!="" && remMonthNew.toString().length==1){
	    	 remMonthNew="0"+remMonthNew;
	     }
	   
	   
	   dateNext=date+"/"+remMonthNew+"/"+year;
	}
	else{
		
		 if(date!=null && date!="" && date.toString().length==1)
	     {
	    	 date="0"+date;
	     }
	     if(monthNew!=null && monthNew!="" && monthNew.toString().length==1){
	    	 monthNew="0"+monthNew;
	     }
	   
		 dateNext=date+"/"+monthNew+"/"+year;
	}*/
	 if(date!=null && date!="" && date.toString().length==1)
     {
    	 date="0"+date;
     }
     if(month!=null && month!="" && month.toString().length==1){
    	 month="0"+month;
     }
   if(monthFromDura!=""){
	  var monthNew=parseInt(monthFromDura)+parseInt(month);
	  if(monthNew>12){
	   var  coYearNew= parseInt(monthNew)/12;
	   year=parseInt(year)+parseInt(coYearNew);
	   var remMonthNew= parseInt(monthNew)%12;
	   month=parseInt(remMonthNew);
	   if(month!=null && month!="" && month.toString().length==1){
	    	 month="0"+month;
	     }
	    
	  }
	  else{
		  month=parseInt(monthNew);  
		  if(month!=null && month!="" && month.toString().length==1){
		    	 month="0"+month;
		     }
	  }
	   
   }
	 dateNext=date+"/"+month+"/"+year;
	
	/*
	 * used for Date Comparision next due date
	 *  var currentItemId= $(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val();
	  var countForImmunization=0;
		$('#immunisationStatusGrid tr').each(function(i, el) {

			var itemIdVals = $(this).find("td:eq(0)").find("input:eq(1)").val();
			var oldNextDueDate=$(this).closest('tr').find("td:eq(3)").find("input:eq(0)").val();
			if(currentItemId==itemIdVals){
					var countDateVal=getDateComapareImmu(oldNextDueDate,dateNext)
					if(countDateVal>0){
						countForImmunization=+1; 
					}
			}
	 	});
	  
		if(countForImmunization>0){
			alert("Immunization is already given.");
			return false
		}*/
		
	 
	$('#'+nextCategoryDateId).val(dateNext);
	$('#'+nextCategoryDateId).attr('readonly', true); 
	}

 $j('body').on("focus",".noFuture_date5", function() {
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
   		generateNextDate(ides);  
   		getMedicalCategoryFinalObserb(ides);
   	}
   });
 
 
 function getDateComapareImmu(fromDate,toDate){
	 var countDateV=0;
	 
	 var fCurrentDateVal=fromDate.split("/");
		var fddate=fCurrentDateVal[0];
		var fmonth=fCurrentDateVal[1];
		var fyear=fCurrentDateVal[2];
		var fUpdateDate=fCurrentDateVal[1]+"/"+fCurrentDateVal[0]+"/"+fCurrentDateVal[2];
		
		 var tCurrentDateVal=toDate.split("/");
			var tddate=tCurrentDateVal[0];
			var tmonth=tCurrentDateVal[1];
			var tyear=tCurrentDateVal[2];
		
			var tUpdateDate=tCurrentDateVal[1]+"/"+tCurrentDateVal[0]+"/"+tCurrentDateVal[2];	
	 var g1 = new Date(fUpdateDate); 
	    var g2 = new Date(tUpdateDate); 
	    if (g1.getTime() > g2.getTime()){
	    	 
	    	countDateV+=1;
	    	return countDateV;
	    }
	    if (g1.getTime() == g2.getTime()){
	    	 
	    	countDateV+=1;
	    	return countDateV;
	    }
	    return countDateV;
 }
 
 $j('body').on("focus",".noFuture_date6", function() {
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
   		generateNextDateForImmun(ides);  
   	}
   });
 
 
 

 
 
 function submitMAForm3A(){
	 $('#obsistyMark').val(obsistyOverWeight);
	 var count=0;
		if(!fileValidate()){
			count++;
			return false;
		}
	if(count==0){
	 $("#submitMedicalExamByMA3A").submit();
		$("#submitMAFormId3A").attr("disabled", true);
		}
	}
 
 
 function getAFMSF3BForMOOrMAFor3A() {
		var visitId = $('#visitId').val();
		var age = $('#ageForPatient').val();
		var userId=$('#userId').val();
		var patientId=$('#patientId').val();
		var pathname = window.location.pathname;
		var approvalFlagCheckStatus=$('#approvalFlag').val();
	     var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/medicalexam/getAFMSF3BForMOOrMA";
		
		var data = {
				"visitId" : visitId,
				"flagForForm" :"f3",
				"age":age,
				"userId":userId,
				"patientId":patientId
			};
			$.ajax({

				type : "POST",
				contentType : "application/json",
				url : url,
				data : JSON.stringify(data),
				dataType : "json",
				// cache: false,

				success : function(res) {
					 data = res.listOfResponse;
					 var listMasServiceType = res.listMasServiceType;
					 var serviceType="";
					 if (data != undefined && data != null) {
							$('#totalNoOfTeath').val(data[0].totalNoOfTeath);
							$('#totalNoOfDefective').val(data[0].totalNoOfDefective);
							$('#totalNoOfDentalPoints').val(data[0].totalNoOfDentalPoints);

							$('#missing').val(data[0].missing);
							$('#unSavable').val(data[0].unSavable);
							if(data[0].conditionOfGums!="" && data[0].conditionOfGums!=null && data[0].conditionOfGums!=undefined)
								$('#conditionOfGums').val(data[0].conditionOfGums);
							
							var glopbalVarForAll;
							 var missingTeethUr=data[0].missingTeethUr;
							 if(missingTeethUr!="" && missingTeethUr!=null){
								 glopbalVarForAll=missingTeethUr.split(",");
								 checkForTeeth("urMChecked",glopbalVarForAll);
							 }
							 
							 var missingTeethUl=data[0].missingTeethUl;
							 if(missingTeethUl!="" && missingTeethUl!=null){
								 glopbalVarForAll=missingTeethUl.split(",");
								 checkForTeeth("ulMChecked",glopbalVarForAll);
							 }
							 var missingTeethLL=data[0].missingTeethLL;
							 
							 if(missingTeethLL!="" && missingTeethLL!=null){
								 glopbalVarForAll=missingTeethLL.split(",");
								 checkForTeeth("llMChecked",glopbalVarForAll);
							 }
							 
							 var missingTeethLR=data[0].missingTeethLR;
							 
							 if(missingTeethLR!="" && missingTeethLR!=null){
								 glopbalVarForAll=missingTeethLR.split(",");
								 checkForTeeth("lrMChecked",glopbalVarForAll);
							 }
							 
							 var unsavableTeethUr=data[0].unsavableTeethUr;
							 if(unsavableTeethUr!="" && unsavableTeethUr!=null){
								 glopbalVarForAll=unsavableTeethUr.split(",");
								 checkForTeeth("unurChecked",glopbalVarForAll);
							 }
							 var unsavableTeethUl=data[0].unsavableTeethUl;
							 if(unsavableTeethUl!="" && unsavableTeethUl!=null){
								 glopbalVarForAll=unsavableTeethUl.split(",");
								 checkForTeeth("unulChecked",glopbalVarForAll);
							 }
							 
							 var unsavableTeethLl=data[0].unsavableTeethLl;
							 if(unsavableTeethLl!="" && unsavableTeethLl!=null){
								 glopbalVarForAll=unsavableTeethLl.split(",");
								 checkForTeeth("unllChecked",glopbalVarForAll);
							 }
							 
							 var unsavableTeethLr=data[0].unsavableTeethLr;
							 if(unsavableTeethLr!="" && unsavableTeethLr!=null){
								 glopbalVarForAll=unsavableTeethLr.split(",");
								 checkForTeeth("unlrChecked",glopbalVarForAll);
							 }
							 if(data[0].dentalOffier!="")
							 $('#dentalOffier').val(data[0].dentalOffier);
							 
							 if(data[0].remarks!="" && data[0].remarks!=undefined && data[0].remarks!=null)
								 $('#remarks').val(data[0].remarks);
							 $('#remarkAdvice').val(data[0].remarkAdvice);
							 
							 var pcHeight=data[0].pcHeight;
							 if(pcHeight!="")
							 $('#height').val(pcHeight);
							 
							 var pcWeight=data[0].pcWeight;
							 if(pcWeight!="" && pcWeight!=undefined && pcWeight!=null)
							 $('#weight').val(pcWeight);
							 
							 var pcIdealWeight=data[0].pcIdealWeight;
							 if(pcIdealWeight!="" && pcIdealWeight!=undefined && pcIdealWeight!=null)
							 $('#idealWeight').val(pcIdealWeight);
							 
							 var pcOverWeight=data[0].pcOverWeight;
							 
						if(pcOverWeight!="" && pcOverWeight!=undefined && pcOverWeight!=null)
							 $('#overWeight').val(pcOverWeight);
							 
							 var pcBmi=data[0].pcBmi;
							 if(pcBmi!="" && pcBmi!=undefined && pcBmi!=null)
							 $('#bmi').val(pcBmi);
							 
							 var pcBodyFat=data[0].pcBodyFat;
							 if(pcBodyFat!="" && pcBodyFat!=undefined && pcBodyFat!=null)
							 $('#bodyFat').val(pcBodyFat);
							 
							 var pcWaist=data[0].pcWaist;
							 if(pcWaist!=""  && pcWaist!=undefined && pcWaist!=null)
							 $('#waist').val(pcWaist);
							 var pcSkinFoldExpansion=data[0].pcSkinFoldExpansion;
							 if(pcSkinFoldExpansion!=""  && pcSkinFoldExpansion!=undefined && pcSkinFoldExpansion!=null)
							 $('#skinFoldExpansion').val(pcSkinFoldExpansion);
							 
							 var pcChestFullExpansion=data[0].pcChestFullExpansion;
							 if(pcChestFullExpansion!=""  && pcChestFullExpansion!=undefined && pcChestFullExpansion!=null)
							 $('#chestFullExpansion').val(pcChestFullExpansion);
							 
							 var pcRangeOfExpansion=data[0].pcRangeOfExpansion;
							 if(pcRangeOfExpansion!=""  && pcRangeOfExpansion!=undefined && pcRangeOfExpansion!=null)
							 $('#rangeOfExpansion').val(pcRangeOfExpansion);
							 
							 
							 var pcSportsman=data[0].pcSportsman;
							 setSelectedValue("sportsman",pcSportsman);
							  //Vision start
								
								 var distantWithoutGlasses=data[0].distantWithoutGlasses;
								 setSelectedValue("distantWithoutGlasses",distantWithoutGlasses);
							 
								 var distantWithoutGlassesL=data[0].distantWithoutGlassesL;
								 setSelectedValue("distantWithoutGlassesL",distantWithoutGlassesL);	
								 
								 var nearWithoutGlasses=data[0].nearWithoutGlasses;
								 setSelectedValue("nearWithoutGlasses",nearWithoutGlasses);
								 
								 var nearWithoutGlassesL=data[0].nearWithoutGlassesL;
								 setSelectedValue("nearWithoutGlassesL",nearWithoutGlassesL);
								
								 
								 var cpWithoutGlasses=data[0].cpWithoutGlasses;
								 setSelectedValue("cpWithoutGlasses",cpWithoutGlasses);
							 
								 
								 var distantWithGlasses=data[0].distantWithGlasses;
								 setSelectedValue("distantWithGlasses",distantWithGlasses);
								 
								 var distantWithGlassesL=data[0].distantWithGlassesL;
								 setSelectedValue("distantWithGlassesL",distantWithGlassesL);
								 
								 
								 var nearWithGlasses=data[0].nearWithGlasses;
								 setSelectedValue("nearWithGlasses",nearWithGlasses);
							
								 
								 var nearWithGlassesL=data[0].nearWithGlassesL;
								 setSelectedValue("nearWithGlassesL",nearWithGlassesL);
								 
							//Hearing
							 var fwR=data[0].fwR;
							 if(fwR!="" && fwR!=null &&  fwR!=undefined)
							 $('#fwR').val(fwR);
							 
							 var fwL=data[0].fwL;
							 if(fwL!=""  && fwL!=null &&   fwL!=undefined)
							 $('#fwL').val(fwL);
							 
							 var fwBoth=data[0].fwBoth;
							 if(fwBoth!="" && fwBoth!=undefined && fwBoth!=null)
							 $('#fwBoth').val(fwBoth);
							 
							 var cvR=data[0].cvR;
							 if(cvR!="" && cvR!=undefined && cvR!=null)
							 $('#cvR').val(cvR);
							 
							 var cvL=data[0].cvL;
							 if(cvL!="" && cvL!=null &&   cvL!=undefined)
							 $('#cvL').val(cvL);
							 
							 var cvBoth=data[0].cvBoth;
							 if(cvBoth!="" && cvBoth!=null &&   cvBoth!=undefined)
							 $('#cvBoth').val(cvBoth);
							 
							 var tmR=data[0].tmR;
							 setSelectedValue("tmR",tmR);
							 
							 var tmL=data[0].tmL;
							 setSelectedValue("tmL",tmL);
							 
							 //var mobilityR=data[0].mobilityR;
							 //setSelectedValue("mobilityR",mobilityR);
							 
							// var mobilityL=data[0].mobilityL;
							 //setSelectedValue("mobilityL",mobilityL);
							 
							/* var noiseThroatSinuses=data[0].noiseThroatSinuses;
							 if(noiseThroatSinuses!="")
							 $('#noseThroatSinuses').val(noiseThroatSinuses);*/
							 
							 var audiometryRecord=data[0].audiometryRecord;
							 
							 setSelectedValue("audiometryRecord",audiometryRecord);
							 if(audiometryRecord!=null && audiometryRecord=='Others'){
							 var audiometryRecordOthers=data[0].audiometryRecordForOther;
							 $('#audiometryRecordForOther').val(audiometryRecordOthers);
							 $('#audiometryRecordForDisplay').show();
							 }
							 else{
								 $('#audiometryRecordForDisplay').hide();
							 }
							 var clinicalNotes=data[0].clinicalNotes;
							 if(clinicalNotes!="" && clinicalNotes!=undefined && clinicalNotes!=null)
							 $('#clinicalNotes').val(clinicalNotes);
							 
							 var pluse=data[0].pluse;
							 if(pluse!="" && pluse!=undefined && pluse!=null)
							 $('#pulse').val(pluse);
							 
							 var bp=data[0].bp;
							 if(bp!=""  && bp!=undefined && bp!=null)
							 $('#bp').val(bp);
							 
							 var bp1=data[0].bp1;
							 if(bp1!="" && bp1!=undefined && bp1!=null)
							 $('#bp1').val(bp1);
							 
							 var heartSize=data[0].heartSize;
							 if(heartSize!="" && heartSize!=undefined && heartSize!=null)
							 $('#heartSize').val(heartSize);
							 
							 var sounds=data[0].sounds;
							 if(sounds!=""  && sounds!=undefined && sounds!=null)
							 $('#sounds').val(sounds);
							 
							 var rhythm=data[0].rhythm;
							 if(rhythm!=""   && rhythm!=undefined && rhythm!=null)
							 $('#rhythm').val(rhythm);
							 
							 var respiratorySystem=data[0].respiratorySystem;
							 if(respiratorySystem!="" && respiratorySystem!=undefined && respiratorySystem!=null)
							 $('#respiratorySystem').val(respiratorySystem);
							 
							 var liver=data[0].liver;
							 if(liver!="" && liver!=undefined && liver!=null){
								 setSelectedValue("liverPalpable",'Yes');
								 $('#liver').val(liver);
								 $('#liverPalpableInput').show();
							 }
							 else{
								 setSelectedValue("liverPalpable",'No'); 
								 $('#liverPalpableInput').hide();
							 }
							 
							 
							 var spleen=data[0].spleen;
							 if(spleen!=""  && spleen!=undefined && spleen!=null){
								 setSelectedValue("spleenPalpable",'Yes');
								 $('#spleen').val(spleen);
								 $('#spleenPalpableInput').show();
							 }
							 else{
								 setSelectedValue("spleenPalpable",'No'); 
								 $('#spleenPalpableInput').hide();
							 }
							 var higherMentalFunction=data[0].higherMentalFunction;
							 if(higherMentalFunction!="" && higherMentalFunction!=null && higherMentalFunction!=undefined)
							 $('#higherMentalFunction').val(higherMentalFunction);
							 
							 
							 var speech=data[0].speech;
							 if(speech!="" && speech!=null && speech!=undefined)
							 $('#speech').val(speech);
							 
							 var reflexes=data[0].reflexes;
							 if(reflexes!="" && reflexes!=null && reflexes!=undefined)
							 $('#reflexes').val(reflexes);
							 
							 var tremors=data[0].tremors;
							 setSelectedValue("tremors",tremors);
							 
							 var selfBalancingTest=data[0].selfBalancingTest;
							 setSelectedValue("selfBalancingTest",selfBalancingTest);
							 
							 var locomotorSystem=data[0].locomotorSystem;
							 if(locomotorSystem!=""  && locomotorSystem!=null && locomotorSystem!=undefined)
							 $('#locomotorSystem').val(locomotorSystem);
							 
							 var spine=data[0].spine;
							 if(spine!="" && spine!=null && spine!=undefined)
							 $('#spine').val(spine);
							 
							 var hernia=data[0].hernia;
							 if(hernia!="" && hernia!=null && hernia!=undefined)
							 $('#hernia').val(hernia);
							 
							 var hydrocele=data[0].hydrocele;
							 if(hydrocele!="" && hydrocele!=null && hydrocele!=undefined)
							 $('#hydrocele').val(hydrocele);
							 
							 var breast=data[0].breast;
							 if(breast!=""  && breast!=null && breast!=undefined)
							 $('#breast').val(breast);
							 
							 
							 var pcChestFullExpansion=data[0].pcChestFullExpansion;
							 if(pcChestFullExpansion!="" && pcChestFullExpansion!=null && pcChestFullExpansion!=undefined)
							 $('#chestFullExpansion').val(pcChestFullExpansion);
							 
							 var opdPatientDetailId=data[0].opdPatientDetailId
							 if(opdPatientDetailId!="" && opdPatientDetailId!=null && opdPatientDetailId!=undefined)
							 $('#opdPatientDetailId').val(opdPatientDetailId);
							 
						var saveInDraft=$('#saveInDraft').val( );
						var status= data[0].status;
						 if(saveInDraft!="" && saveInDraft=='draftMo3A'){
							 if(data[0].chiefComplaint!="" && data[0].chiefComplaint!=null && data[0].chiefComplaint!=undefined)		 	
						$('#chiefComplaint').val( data[0].chiefComplaint);
							 if( data[0].pollar!="" &&  data[0].pollar!=null &&  data[0].pollar!=undefined)	
							 	$('#pollar').val( data[0].pollar);
							 if( data[0].ordema!="" &&  data[0].ordema!=null &&  data[0].ordema!=undefined)	
							 	$('#ordema').val( data[0].ordema);
							 if(data[0].cyanosis!="" && data[0].cyanosis!=null &&  data[0].cyanosis!=undefined)	
							 	$('#cyanosis').val( data[0].cyanosis);
								
							 if(data[0].hairnail!="" && data[0].hairnail!=null && data[0].hairnail!=undefined)		 
							 	$('#hairnail').val( data[0].hairnail);
							 if(data[0].icterus!="" && data[0].icterus!=null && data[0].icterus!=undefined)
							 	$('#icterus').val( data[0].icterus);
							 if(data[0].cyanosis!="" && data[0].cyanosis!=null && data[0].cyanosis!=undefined)
							 	$('#cyanosis').val( data[0].cyanosis);
							 if(data[0].lymphNode!="" && data[0].lymphNode!=null && data[0].lymphNode!=undefined)
							 	$('#lymphNode').val( data[0].lymphNode);
							 	
							 	$('#clubbing').val( data[0].clubbing);
								 
							 	$('#gcs').val( data[0].gcs);
								
							 	$('#Tremors').val(data[0].geTremors);
							 	
							 	$('#others').val( data[0].others);
								
							 	$('#remarksForReferal').val( data[0].remarksForReferal);
								$('#remarksReject').val( data[0].remarksReject);
								finalObservationOfMo=data[0].finalObservationMo;
								$('#remarksPending').val( data[0].remarksPending);
								$('#nextAppointmentDate').val( data[0].nextAppointmentDate);
								
								$('#remarksReject').val( data[0].remarksReject);
								// actionSelected(status);
								if(approvalFlagCheckStatus=='y' || status=='rj'){
									 actionSelected(status);
								 }
								 var petStatus=data[0].petStatus;
								 
								 setSelectedValue("pet",petStatus);
									 var petDate=data[0].petDate;
									 $('#petDateValue').val(petDate);
								  
						 } 
						
						 
						 if(saveInDraft!="" && saveInDraft=='draftRMo3A'){
								$('#finalObservationMo').val( data[0].finalObservationMo);
							 
								$('#finalObservationRmo').val( data[0].finalObservationRmo);
							
								$('#finalObservationMoJ').jqteVal( data[0].finalObservationMo);
							//	$('#remarksRmo').val( data[0].remarksRmo);
								$('#remarksForReferal').val( data[0].remarksForReferal);
								
								$('#remarksReject').val( data[0].remarksReject);
								$('#remarksForApproval').val( data[0].remarksForApproval);
								if(approvalFlagCheckStatus=='y' || status=='rj'){
									 actionSelected(status);
								 }
								//actionSelected(status);
								/*var petStatus=data[0].petStatus;
								 setSelectedValue("pet",petStatus);

								 var petDate=data[0].petDate;
								  $('#petDateValue').val(petDate);
*/								/* if(petStatus=='y'){
									 var petDate=data[0].petDate;
									  $('#petDateValue').val(petDate);
									 $('#petDate').show();
								 }
								 else{
									 $('#petDate').hide();
								 }*/
						 }
						
						 
						 if(saveInDraft!="" && saveInDraft=='draftPRMo3A'){
							 
							 $('#finalObservationMoJ').jqteVal( data[0].finalObservationMo);
								$('#finalObservationRmoJ').jqteVal( data[0].finalObservationRmo);
								
							 $('#finalObservationMo').val( data[0].finalObservationMo);
								$('#finalObservationRmo').val( data[0].finalObservationRmo);
							//	$('#remarksRmo').val( data[0].remarksRmo);
								$('#remarksForReferal').val( data[0].remarksForReferal);
								
								$('#remarksReject').val( data[0].remarksReject);
								$('#remarksForApproval').val( data[0].remarksForApproval);
								$('#finalObservationPRmo').val( data[0].paFinalobservation);
								//$('#remarksPRmo').val( data[0].remarksPRmo);
							//	actionSelected(status);
								if(approvalFlagCheckStatus=='y' || status=='rj'){
									 actionSelected(status);
								 }
								var petStatus=data[0].petStatus;
								 
								 setSelectedValue("pet",petStatus);

								 var petDate=data[0].petDate;
								  $('#petDateValue').val(petDate);
							 
						 }
						 if(data[0].peripheralPulsations!="" && data[0].peripheralPulsations!=undefined && data[0].peripheralPulsations!=null)
						 $('#peripheralPulsations').val(data[0].peripheralPulsations);
					
						 
						 if(data[0].checkupDate!="" && data[0].checkupDate!=undefined && data[0].checkupDate!=null)	
							 $('#checkupDate').val(data[0].checkupDate);
						 if(data[0].haemorrhoids!=""  && data[0].haemorrhoids!=undefined && data[0].haemorrhoids!=null)
							 $('#haemorrhoids').val(data[0].haemorrhoids);
						 if(data[0].moUser!="" && data[0].moUser!=undefined && data[0].moUser!=null)
							 $('#signedByMo').val(data[0].moUser);
						 if(data[0].rMoUser!="" && data[0].rMoUser!=undefined && data[0].rMoUser!=null)
							 $('#signedByRMo').val(data[0].rMoUser);
						 if(data[0].pRMoUser!=""  && data[0].pRMoUser!=undefined && data[0].pRMoUser!=null)
							 $('#signedByPRMo').val(data[0].pRMoUser);
						 if(data[0].mensturalHistory!="" && data[0].mensturalHistory!=undefined && data[0].mensturalHistory!=null)
							 $('#mensturalHistory').val(data[0].mensturalHistory);
							 var lmpselectValue=data[0].lmpSelect;
							 setSelectedValue("lmpSelect",lmpselectValue);
							 $('#lMP').val(data[0].lMP);
							 $('#nosOfPregnancies').val(data[0].nosOfPregnancies);
							 $('#nosOfAbortions').val(data[0].nosOfAbortions);

							 
							 $('#nosOfChildren').val(data[0].nosOfChildren);
							 $('#childDateOfLastConfinement').val(data[0].childDateOfLastConfinement);
							 $('#vaginalDischarge').val(data[0].vaginalDischarge);
							 
							if(data[0].usgAbdomen!="" && data[0].usgAbdomen!=undefined && data[0].usgAbdomen!=null)
							 $('#usgAbdomen').val(data[0].usgAbdomen);
							 if(data[0].prolapse!="" && data[0].prolapse!=undefined && data[0].prolapse!=null)
							 $('#prolapse').val(data[0].prolapse);
							
							 
							 

						 		/*$('#ecgRDMT').val( data[0].ecgRDMT);
								$('#ecgDated').val( data[0].ecgDated);
								$('#ecgReport').val( data[0].ecgReport);
								$('#ecgAMT').val( data[0].ecgAMT);
								$('#ecgAmtDated').val( data[0].ecgAmtDated);
								$('#ecgAmtReport').val( data[0].ecgAmtReport);
								
								
								 $('#xRayChestPANos').val( data[0].xRayChestPANos);
								$('#xRayChestPANosDated').val( data[0].xRayChestPANosDated);
								$('#xRayChestPANosReport').val( data[0].xRayChestPANosReport);
								*/
							 if(data[0].remarksOfLab!="" && data[0].remarksOfLab!=undefined && data[0].remarksOfLab!=null)
								$('#remarksOfLab').val( data[0].remarksOfLab);
							 if(data[0].dateOfLab!=""  && data[0].dateOfLab!=undefined && data[0].dateOfLab!=null)
								$('#dateOfLab').val( data[0].dateOfLab);
							 if(data[0].signatureOfEyeSpecialist!="" && data[0].signatureOfEyeSpecialist!=undefined && data[0].signatureOfEyeSpecialist!=null)
								$('#signatureOfEyeSpecialist').val( data[0].signatureOfEyeSpecialist);
								
								
							 if(data[0].remarksOfSurgery!="" && data[0].remarksOfSurgery!=undefined && data[0].remarksOfSurgery!=null)
								 $('#remarksOfSurgery').val( data[0].remarksOfSurgery);
							 if(data[0].dateOfSurgery!="" && data[0].dateOfSurgery!=undefined && data[0].dateOfSurgery!=null)
								$('#dateOfSurgery').val( data[0].dateOfSurgery);
							 if(data[0].signatureOfSurgicalSpecialist!="" && data[0].signatureOfSurgicalSpecialist!=undefined && data[0].signatureOfSurgicalSpecialist!=null)
								$('#signatureOfSurgicalSpecialist').val( data[0].signatureOfSurgicalSpecialist);
							 if(data[0].remarksOfDental!="" && data[0].remarksOfDental!=undefined && data[0].remarksOfDental!=null)
								$('#remarksOfDental').val( data[0].remarksOfDental);
							 if(data[0].dateOfDental!="" && data[0].dateOfDental!=undefined && data[0].dateOfDental!=null)
								$('#dateOfDental').val( data[0].dateOfDental);
							 if(data[0].signatureOfDentalOfficer!="" && data[0].signatureOfDentalOfficer!=undefined && data[0].signatureOfDentalOfficer!=null)
								$('#signatureOfDentalOfficer').val( data[0].signatureOfDentalOfficer);
								
								
							 if(data[0].evidenceOfTrachoma!="" && data[0].evidenceOfTrachoma!=undefined && data[0].evidenceOfTrachoma!=null)	
								$('#evidenceOfTrachoma').val( data[0].evidenceOfTrachoma);
							 if(data[0].binocularVisionGrade!="" && data[0].binocularVisionGrade!=undefined && data[0].binocularVisionGrade!=null)	
								$('#binocularVisionGrade').val( data[0].binocularVisionGrade);
							 if(data[0].manifestHypermetropiaMyopia!="" && data[0].manifestHypermetropiaMyopia!=undefined && data[0].manifestHypermetropiaMyopia!=null)
								$('#manifestHypermetropiaMyopia').val( data[0].manifestHypermetropiaMyopia);
							 if(data[0].coverTest!="" && data[0].coverTest!=undefined && data[0].coverTest!=null)
								$('#coverTest').val( data[0].coverTest);
							 if(data[0].diaphragmTest!=""  && data[0].diaphragmTest!=undefined && data[0].diaphragmTest!=null)
								$('#diaphragmTest').val( data[0].diaphragmTest);
							 if(data[0].fundiMedia!="" && data[0].fundiMedia!=undefined && data[0].fundiMedia!=null)
								$('#fundiMedia').val( data[0].fundiMedia);
								//////////////////
							 if(data[0].fieldsSpecial!="" && data[0].fieldsSpecial!=undefined && data[0].fieldsSpecial!=null)
								$('#fieldSpecial').val( data[0].fieldsSpecial);
							 if(data[0].nightVisualCapacity!="" && data[0].nightVisualCapacity!=undefined && data[0].nightVisualCapacity!=null)
								$('#nightVisualCapacity').val( data[0].nightVisualCapacity);
							 if(data[0].convergenceC!=""  && data[0].convergenceC!=undefined && data[0].convergenceC!=null)
								$('#convergenceC').val(data[0].convergenceC);
							 if(data[0].convergenceSC!="" && data[0].convergenceSC!=undefined && data[0].convergenceSC!=null)
								$('#convergenceSC').val( data[0].convergenceSC);
							 if(data[0].accomodationR!="" && data[0].accomodationR!=undefined && data[0].accomodationR!=null)
								$('#accomodationR').val( data[0].accomodationR);
							 if(data[0].accomodationL!="" && data[0].accomodationL!=undefined && data[0].accomodationL!=null)
								$('#accomodationL').val( data[0].accomodationL);
							 if(data[0].manifestHypeMyopiaRemarks!="" && data[0].manifestHypeMyopiaRemarks!=undefined && data[0].manifestHypeMyopiaRemarks!=null)
								$('#manifestHypermetropiaMyopiaRemarks').val( data[0].manifestHypeMyopiaRemarks);
							 if(data[0].manifestHypeMyopiaDate!="" && data[0].manifestHypeMyopiaDate!=undefined && data[0].manifestHypeMyopiaDate!=null)
								$('#manifestHypermetropiaMyopiaDate').val( data[0].manifestHypeMyopiaDate);
							 if(data[0].noseThroatSinusesRemarks!="" && data[0].noseThroatSinusesRemarks!=undefined && data[0].noseThroatSinusesRemarks!=null)
								$('#noseThroatSinusesRemarks').val( data[0].noseThroatSinusesRemarks);
							 if(data[0].noseThroatSinusesDate!="" && data[0].noseThroatSinusesDate!=undefined && data[0].noseThroatSinusesDate!=null)
								$('#noseThroatSinusesDate').val( data[0].noseThroatSinusesDate);
							 if(data[0].remarksOfGynaecology!=""  && data[0].remarksOfGynaecology!=undefined && data[0].remarksOfGynaecology!=null)
								$('#remarksOfGynaecology').val( data[0].remarksOfGynaecology);
							 if(data[0].dateOfGynaecology!=""  && data[0].dateOfGynaecology!=undefined && data[0].dateOfGynaecology!=null)
								$('#dateOfGynaecology').val( data[0].dateOfGynaecology);
							 if(data[0].signatureOfGynaecologist!=""  && data[0].signatureOfGynaecologist!=undefined && data[0].signatureOfGynaecologist!=null)
								$('#signatureOfGynaecologist').val( data[0].signatureOfGynaecologist);
							
								
								if(data[0].signatureOfMedicalSpecialist!=""  && data[0].signatureOfMedicalSpecialist!=undefined && data[0].signatureOfMedicalSpecialist!=null)
								$('#signatureOfMedicalSpecialist').val( data[0].signatureOfMedicalSpecialist);
								if(data[0].externalEarR!="" && data[0].externalEarR!=undefined && data[0].externalEarR!=null)
								$('#externalEarR').val( data[0].externalEarR);
								if(data[0].externalEarL!="" && data[0].externalEarL!=undefined && data[0].externalEarL!=null)
								$('#externalEarL').val( data[0].externalEarL);
								if(data[0].middleEarR!="" && data[0].middleEarR!=undefined && data[0].middleEarR!=null)
								$('#middleEarR').val( data[0].middleEarR);
								if(data[0].middleEarL!="" && data[0].middleEarL!=undefined && data[0].middleEarL!=null)
								$('#middleEarL').val( data[0].middleEarL);
								if(data[0].innerEarR!="" && data[0].innerEarR!=undefined && data[0].innerEarR!=null)
								$('#innerEarR').val( data[0].innerEarR);
								if(data[0].innerEarL!="" && data[0].innerEarL!=undefined && data[0].innerEarL!=null)
								$('#innerEarL').val( data[0].innerEarL);
								if(data[0].signatureOfENTSpecialist!="" && data[0].signatureOfENTSpecialist!=undefined && data[0].signatureOfENTSpecialist!=null)
								$('#signatureOfENTSpecialist').val( data[0].signatureOfENTSpecialist);
							
								if(data[0].noseSinuses!=""  && data[0].noseSinuses!=undefined && data[0].noseSinuses!=null)
									$('#noseSinuses').val( data[0].noseSinuses);
									if(data[0].throatSinuses!="")
									$('#throatSinuses').val( data[0].throatSinuses);
								
								
									 if((data[0].hospitalIdFoward!=null && data[0].hospitalIdFoward!="" && saveInDraft!='draftPRMo3A'  && saveInDraft!='draftRMo3A')|| approvalFlagCheckStatus=='y'){
											//$('#forwardStatus').show();
											var forwardedId=data[0].hospitalIdFoward;
											if(status!="" && status!='rj' && forwardedId!=undefined && forwardedId!="" && forwardedId!=null)
											getSelectedUnitData(forwardedId);
										 
										 }
									 
									 
									 if(data[0].obsistyCloseDate==null || data[0].obsistyCloseDate==""){
										 if(data[0].overweightFlag!=null  ){
											var overweightFlag=data[0].overweightFlag;
											if(overweightFlag!="" && overweightFlag=='Y'){
												$("#overCheck").prop("checked", true);
												$("#overWeightDropDown").show();
												$('#obsistyMark').val("Y");
												overWeightOb("Y");
											}
											if(overweightFlag!="" && overweightFlag=='N'){
												$("#obsistyCheck").prop("checked", true);
												$("#overWeightDropDown").hide();
												$('#obsistyMark').val("N");
												overWeightOb("N");
											}
											if(overweightFlag!="" && overweightFlag=='A'){
												$("#noneCheck").prop("checked", true);
												$("#overWeightDropDown").hide();
												$('#obsistyMark').val("A");
												overWeightOb("A");
											}
										 }
									 }
									 
									 if(data[0].memberPlace!="")
											$('#memberPlace').val( data[0].memberPlace);
											if(data[0].memberDate!="")
											$('#memberDate').val( data[0].memberDate);
											if(data[0].rankDesiMember1!="")
											$('#rankDesiMember1').val( data[0].rankDesiMember1);
											if(data[0].nameMember1!="")
											$('#nameMember1').val( data[0].nameMember1);
											if(data[0].rankDesiMember2!="")
											$('#rankDesiMember2').val( data[0].rankDesiMember2);
											if(data[0].nameMember2!="")
											$('#nameMember2').val( data[0].nameMember2);
											if(data[0].rankDesiPresident!="")
											$('#rankDesiPresident').val( data[0].rankDesiPresident);
											if(data[0].namePresident!="")
											$('#namePresident').val( data[0].namePresident);
									 
								
							 	finalObservationOfMo=data[0].finalObservationMo;
								finalObservationOfRMo=data[0].finalObservationRmo;
								finalObservationOfPRMo=data[0].paFinalobservation;
								 serviceType =  data[0].serviceType;
						}
					 var approvalFlag=$('#approvalFlag').val();
					 if(approvalFlag!="" && approvalFlag!=undefined && approvalFlag=='y'){
					 if (listMasServiceType != null
								&& listMasServiceType.length > 0) {
							var masServiceTypeVal = "";
							masServiceTypeVal += '<select class="form-control" id="serviceOfEmployee" name="serviceOfEmployee"';
								masServiceTypeVal += 'class="medium">';
							masServiceTypeVal += '<option value="0"><strong>Select</strong></option>';
							for (var i = 0; i < listMasServiceType.length; i++) {
								var selectedV = '';

								if (serviceType == listMasServiceType[i].serviceTypeId) {
									selectedV = "selected";
								} else {
									selectedV = '';
								}
								masServiceTypeVal += '<option   '+selectedV+'  value="' + listMasServiceType[i].serviceTypeId+ '"  >'
										+ listMasServiceType[i].serviceTypeName
										+ '</option>';
							}
							masServiceTypeVal += '</select>';
						}
						$('#serviceOfEmployee').html(masServiceTypeVal);
					 }
				}
			});
	}
 
 
 
 function submitMOForm3A(flagForSubmit) {
	 $('#obsistyMark').val(obsistyOverWeight);
		$('#saveInDraft').val(flagForSubmit);
		var count=0;
		
		if(!fileValidate()){
			count++;
		}
		var selectObj="";
		
		if(flagForSubmit!="" && flagForSubmit!='draftMa3A'){
			var jqetFinedValue=$('#finalObservationMoJ').val();
			$('#finalObservationMo').val("");
			$('#finalObservationMo').val(jqetFinedValue);
			 var jqetFinedValue1=$('#finalObservationRmoJ').val();
			$('#finalObservationRmo').val("");
			$('#finalObservationRmo').val(jqetFinedValue1);
			
			 var  jqetFinedValue2=$('#finalObservationPRmoJ').val();
			$('#finalObservationPRmo').val("");
			$('#finalObservationPRmo').val(jqetFinedValue2);
			
			}
		
		
		
		if(getValidateForAction()){
			
			//if(flagForSubmit!="" && flagForSubmit=='draftMo'){
				var resultCountValue=validateForm();
				var selectObj = document.getElementById("actionMe");
				if(resultCountValue>0){
					if(selectObj!=null && selectObj!=""){
				        if (selectObj.options[selectObj.selectedIndex].value=='approveAndClose' 
				        	|| selectObj.options[selectObj.selectedIndex].value=='approveAndForward' || selectObj.options[selectObj.selectedIndex].value=='referred') {
				        alert(""+resourceJSON.msgActionNotCompleted);
				        count+=1;
				        return false;
				        }
					}
				}
				 if (selectObj.options[selectObj.selectedIndex].value=='approveAndForward') {
				var selectedValue=$( "#forwardTo option:selected" ).text();
				if(count==0 && selectedValue!=null && selectedValue!=""){
					if (selectedValue=='Select') {
							alert(""+resourceJSON.msgHopital);
							count+=1;
					        return false;
					}
					}
				var selectedValueDesi=$( "#designationForMe option:selected" ).text();
				if(count==0 && selectedValueDesi!=null && selectedValueDesi!=""){
					if (selectedValueDesi=='Select') {
						alert("Please select Designation.");
						count+=1;
				        return false;
			
					}
				}
		        }
				 
				 if(count==0){
					 checkBoxFitInCatMe();
				}		 
				 
				 
				 if(flagForSubmit!='draftMa3A'){
					 var medicalCategoryIDVal=0;
					 var tbl = document.getElementById('medicalCategory');
					 var 	lastRow = tbl.rows.length;
					 
					 if(document.getElementById('fitInChk').value!=null && document.getElementById('fitInChk').checked==false){
						
						 $('#medicalCategory tr').each(function(i, el) {
		      				  var $tds = $(this).find('td');
							  var diagnosisValue = $($tds).closest('tr').find("td:eq(0)").find("input:eq(0)").val();
							if(diagnosisValue==null || diagnosisValue=="" || diagnosisValue==undefined){
								medicalCategoryIDVal++;
							}
						 });
					 }
					 if(medicalCategoryIDVal!=0){
						 alert("Please provide any Category.");
						 count++;	 
					 }
					 
					 
					 
					/* $('#fileUploadforInvesDynamic tr').each(function(ij, el) {
					 		var fileNameValueIDd= $(this).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id"); 
							 	 
					 		var fileNameValue=$('#'+fileNameValueIDd).val();
							var filenameWithExtension=getFilenameAndReplcePath(fileNameValue);
							if(filenameWithExtension!="" && filenameWithExtension!=null && validateFileExtension(filenameWithExtension, "valid_msg", "Only pdf/image files are allowed !",
								      new Array("jpg","pdf","jpeg","gif","png","PNG","JPEG","JPG","GIF")) == false)
								      {
										count++;
								 		return false;
								      }
					 		
							});
					 */
						var fileNameValue1=$('#medicalExamFileUpload').val();
						var filenameWithExtension=getFilenameAndReplcePath(fileNameValue1);
						if(filenameWithExtension!="" && filenameWithExtension!=null && validateFileExtension(filenameWithExtension, "valid_msg", "Only pdf/image files are allowed !",
							      new Array("jpg","pdf","jpeg","gif","png","PNG","JPEG","JPG","GIF")) == false)
							      {
									count++;
							 		return false;
							      }
						var checkFileName=0;
						if(filenameWithExtension!="" && filenameWithExtension!=undefined && filenameWithExtension!=null)
							if(checkForFileCondition(filenameWithExtension)){
								checkFileName++;
								count++;
							}
						if(checkFileName>0){
					 		alert("File contain special character.Please upload valid file.");
					 		return false;
					 	 }
				 }
				 
			//}
			if(count==0){
				if(selectObj.options[selectObj.selectedIndex].value!='pending' && selectObj.options[selectObj.selectedIndex].value!='referred'
					&& selectObj.options[selectObj.selectedIndex].value!='reject'){
					if(validateMedicalExamForm()){
				if(flagForSubmit!='draftMa3A' && selectObj.options[selectObj.selectedIndex].value=='approveAndForward'){
					
					var designationNameVal=$( "#designationForMe option:selected" ).text();
					$('#designationName').text(designationNameVal);
					$('#messageForDesignation').show();
					$('.modal-backdrop').show();
				}
				else{
				$("#submitMedicalExamByMA3A").submit();
				$("#sumbitByMo3A").attr("disabled","disabled");
				}
				}
				}
				else{
					if(flagForSubmit!='draftMa3A' && selectObj.options[selectObj.selectedIndex].value=='approveAndForward'){
						var designationNameVal=$( "#designationForMe option:selected" ).text();
						$('#designationName').text(designationNameVal);
						$('#messageForDesignation').show();
						$('.modal-backdrop').show();
					}
					else{
					$("#submitMedicalExamByMA3A").submit();
					$("#sumbitByMo3A").attr("disabled","disabled");
					
					}
					}
			
			}
				
		}
		return true;
	}
 function submitMOFormByModel3A(){
		$("#submitMedicalExamByMA3A").submit();
		$("#sumbitByMo3A").attr("disabled","disabled");
		$("#modal3AFormSubmit").attr("disabled","disabled");
		 
	}
 
 
 function getMedicalCategoryFinalObserb(item){
	 var  msgForFitInGlobal="";
	 /* icdName=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").val();
	    medicalCategory=$(item).closest('tr').find("td:eq(1)").find("input:eq(0)").val();
	    
	    system=$(item).closest('tr').find("td:eq(2)").find("select:eq(0)").val();
	    categoryType=$(item).closest('tr').find("td:eq(3)").find("select:eq(0)").val();
	    
	    duration=$(item).closest('tr').find("td:eq(4)").find("input:eq(0)").val();
	    categoryDate=$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").val();
	    nextCategoryDate=$(item).closest('tr').find("td:eq(6)").find("input:eq(0)").val();*/
	 var finalObersationDetail="";
	 var databaseUpdateFinalObser="";
	 var saveInDraft="";
	 var countForCheck=0;
	 
		$('#medicalCategory tr').each(function(i, el) {
			countForCheck++;
			var $tds = $(this).find('td')	

			 icdName = $tds.eq(0).find(":input").val();
			var medicalCategoryTemp = $tds.eq(1).find(":input").val();
			try{
			if(medicalCategoryTemp!="" && medicalCategoryTemp!=null){	
			var index1 = medicalCategoryTemp.split("[");
	 		//var indexForChargeCode = index1;
	 	//	var index2 = medicalCategoryTemp.lastIndexOf("]");
	 			medicalCategory = index1[0];
				}
			}
			catch(e){}
			
			system  = $tds.eq(2).find(":input").val();
			
			categoryType = $tds.eq(3).find(":input").val();
			duration  = $tds.eq(4).find(":input").val();
			categoryDate = $tds.eq(5).find(":input") .val();
			nextCategoryDate = $tds.eq(6).find(":input").val();
			
			if(icdName!=""){
				msgOfICDDiagnosis=icdName;
			}
			if(medicalCategory!=""){
				msgOfMedicalCatName=medicalCategory;
			}
			
			if(system!=undefined && system!="")
				msgOfSystem=system;
			if(categoryType!=undefined && categoryType!=""){
			if(categoryType=='T'){
				msgOfTypeOfMedCat=" "+"T" ;
			}else{
				msgOfTypeOfMedCat=" "+"Pmt" ;
			}
			}
			if(duration!=""){
				durationF=duration;
			}	
			if(categoryDate!=""){
				msgOfCatdate=categoryDate;
			}
			
			if(nextCategoryDate!=""){
				msgOfNextCategoryDate=nextCategoryDate;
			}
			
			  saveInDraft=$('#saveInDraft').val();
			
			if((saveInDraft=='draftMo' || saveInDraft=='draftMo18' || saveInDraft=='draftMo3A' || getSubmitDraftStatus(saveInDraft)) && finalObservationOfMo!="" && finalObservationOfMo!=undefined){
				
				databaseUpdateFinalObser=finalObservationOfMo;
			}
			else if((saveInDraft=='draftRMo' || saveInDraft=='draftRMo18' || saveInDraft=='draftRMo3A' || getSubmitDraftStatus(saveInDraft)) && finalObservationOfRMo!="" && finalObservationOfRMo!=undefined){
				databaseUpdateFinalObser=finalObservationOfRMo;
			
			}
			else if((saveInDraft=='draftPRMo' || saveInDraft=='draftPRMo18' || saveInDraft=='draftPRMo3A' || getSubmitDraftStatus(saveInDraft)) && finalObservationOfPRMo!="" && finalObservationOfPRMo!=undefined){
				databaseUpdateFinalObser=finalObservationOfPRMo;
			}
			 
				var  msgOfFinalObservationValue=resourceJSON.msgOfFinalObservation;
			 
			
			
			var updateMsgOfFinalObservationValue="";
			
			if(msgOfFinalObservationValue!="" ){
				if(msgOfMedicalCatName!="")
				updateMsgOfFinalObservationValue = msgOfFinalObservationValue.replace("<< Medical cat name>>","<b>"+msgOfMedicalCatName+"</b>");
				if(msgOfSystem!="")
				updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<system>>", "<b>("+msgOfSystem+")</b>");
				if(msgOfTypeOfMedCat!="")
				updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<type of med cat>>","<b>"+ msgOfTypeOfMedCat+"</b>");
				if(durationF!="")
				updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<duration>>","<b>"+ durationF+"</b>");
				if(msgOfICDDiagnosis!="")
				updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<ICD Diagnosis>>", "<b>"+msgOfICDDiagnosis +"</b>");
				if(msgOfCatdate!="")
				updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<cat date>>","<b>"+msgOfCatdate+"</b>");
				if(msgOfNextCategoryDate!="")
				updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<Next category date>>", "<b>"+msgOfNextCategoryDate+"</b>");
				finalObersationDetail+=	"<br>"+updateMsgOfFinalObservationValue;
			}
		});
			
			
			if(msgForFitInGlobal!=""&& msgForFitInGlobal!=undefined){
			 msgForFitIn= msgForFitInGlobal;
			}
			
			else if(msgForFitIn!=null && msgForFitIn!=""){
				msgForFitIn=finalObersationDetail;
			}
			else if(databaseUpdateFinalObser!="" && databaseUpdateFinalObser!=undefined ){
				msgForFitIn=databaseUpdateFinalObser+""+finalObersationDetail;
			}
			else{
			msgForFitIn=resourceJSON.msgForFitIn;
			msgForFitIn+=finalObersationDetail;
 			}
			var saveInDraft=$('#saveInDraft').val();
			
			
			if(countForCheck>0){
				if(document.getElementById('fitInChk').value!=null && document.getElementById('fitInChk').checked==true){
					$("#fitInChk").prop("checked", false);
					$("#fitInChk").attr("disabled", true);
					$('#fitFlagCheckValue').val("No");
				}
				else{
					$("#fitInChk").attr("disabled", false);
				}
			}
			
			if(getSubmitDraftStatus(saveInDraft)){
				 
				//if(document.getElementById('fitInChk').value!=null && document.getElementById('fitInChk').checked!=true){
				
				
				
		    	 if(msgForFitIn!=null && !msgForFitIn.includes("FIT in")){
		    		 msgForFitIn= "FIT in"+"<br>" + msgForFitIn ; 
		    	 }
				$('#finalObservationDigi').jqteVal(msgForFitIn);
				$('#finalObservationMoDigi').val(msgForFitIn);
				
				var countForCategory=$('#countForCategory').val();
				var medicalCompositeName=$('#medicalCompositeName').val();
				
				try{
					if(medicalCompositeName!="" && medicalCompositeName!=null){	
					var index1 = medicalCompositeName.split("[");
					medicalCompositeName = index1[0];
						}
					}
					catch(e){}
					
				
				if(countForCheck>='2'){
					var  msgForFit=resourceJSON.msgForFitIn;
					var finalObservationForCategory='';
					if(medicalCompositeName!=""){
					var medicalCompositeDate=$('#medicalCompositeDate').val();
					finalObservationForCategory+= medicalCompositeName+"  "+medicalCompositeDate;
					if(finalObservationForCategory!="" &&  !finalObservationForCategory.includes("FIT in")){
						finalObservationForCategory= "FIT in"+"<br>" + finalObservationForCategory ; 
					}
					
					$('#finalObservationDigi').jqteVal(finalObservationForCategory);
					$('#finalObservationMoDigi').val(finalObservationForCategory);
					//According to modify
					finalObersationDetail=finalObservationForCategory;
					}
					}
				/*}
				else{
					alert("Patient is already in Fit Category.Please uncheck the Fit Category checkbox.");
					return false;
				}*/
				
			}
			
			if(!getSubmitDraftStatus(saveInDraft)){
				 
				//if(document.getElementById('fitInChk').value!=null && document.getElementById('fitInChk').checked!=true){
				var countForCategory=$('#countForCategory').val();
				var medicalCompositeName=$('#medicalCompositeName').val();
				try{
					if(medicalCompositeName!="" && medicalCompositeName!=null){	
					var index1 = medicalCompositeName.split("[");
					medicalCompositeName = index1[0];
						}
					}
					catch(e){}
					
				
				
				if(countForCategory>='2'){
					
					var  msgForFit=resourceJSON.msgForFitIn;
					var finalObservationForCategory='';
					if(medicalCompositeName!=""){
					var medicalCompositeDate=$('#medicalCompositeDate').val();
					finalObservationForCategory+= medicalCompositeName+"  "+medicalCompositeDate;
					//According to modify
					finalObersationDetail=finalObservationForCategory;
						msgForFitIn=finalObersationDetail;
					}
					}
				/*}
				else{
					alert("Patient is already in Fit Category.");
					msgForFitIn="";
					return false;
				}*/
				
			}
			if(msgForFitIn!=null && !msgForFitIn.includes("FIT in")){
	    		 msgForFitIn= "FIT in"+"<br>" + msgForFitIn ; 
	    	 }
			
			
			
			if(saveInDraft=='draftMo' || saveInDraft=='draftMo18' || saveInDraft=='draftMo3A'){
				$('#finalObservationMoJ').jqteVal(msgForFitIn);
			}
			if(saveInDraft=='draftRMo' || saveInDraft=='draftRMo18' || saveInDraft=='draftRMo3A'){
				$('#finalObservationRmoJ').jqteVal(msgForFitIn);
			}
			if(saveInDraft=='draftPRMo'|| saveInDraft=='draftPRMo18' || saveInDraft=='draftPRMo3A'){
				$('#finalObservationPRmoJ').jqteVal(msgForFitIn);
			}
			
			
			 msgForFitInGlobal=msgForFitIn;
		
	}		
	  
 function getSubmitDraftStatus(saveInDraft){
	 if(saveInDraft=='et' || saveInDraft=='es' || saveInDraft=='ev' || saveInDraft=='ea'){
		 return true;
	 }
	 else{
		 return false
	 }
	 return true;
 }
 
 
 function getDigiFileUploadForAllData() {
		var visitId = $('#visitId').val();
		var age = $('#ageForPatient').val();
		var userId=$('#userId').val();
		var pathname = window.location.pathname;
	 	var accessGroup = "MMUWeb";

	 	var url = window.location.protocol + "//"
	 			+ window.location.host + "/" + accessGroup
	 			+ "/medicalexam/getAFMSF3BForMOOrMA";
		var data = {
				"visitId" : visitId,
				"flagForForm" :"f3",
				"age":age,
				"userId":userId
			};
			$.ajax({

				type : "POST",
				contentType : "application/json",
				url : url,

				data : JSON.stringify(data),
				dataType : "json",
				// cache: false,

				success : function(res) {
					 data = res.listOfResponse;
					 var listMasServiceType = res.listMasServiceType;	
					 var serviceType="";
					 if (data != undefined && data != null && data!="") {
							$('#totalNoOfTeath').val(data[0].totalNoOfTeath);
							$('#totalNoOfDefective').val(data[0].totalNoOfDefective);
							$('#totalNoOfDentalPoints').val(data[0].totalNoOfDentalPoints);

							$('#missing').val(data[0].missing);
							$('#unSavable').val(data[0].unSavable);
							$('#conditionOfGums').val(data[0].conditionOfGums);
							
							var glopbalVarForAll;
							 var missingTeethUr=data[0].missingTeethUr;
							 if(missingTeethUr!="" && missingTeethUr!=null){
								 glopbalVarForAll=missingTeethUr.split(",");
								 checkForTeeth("urMChecked",glopbalVarForAll);
							 }
							 
							 var missingTeethUl=data[0].missingTeethUl;
							 if(missingTeethUl!="" && missingTeethUl!=null){
								 glopbalVarForAll=missingTeethUl.split(",");
								 checkForTeeth("ulMChecked",glopbalVarForAll);
							 }
							 var missingTeethLL=data[0].missingTeethLL;
							 
							 if(missingTeethLL!="" && missingTeethLL!=null){
								 glopbalVarForAll=missingTeethLL.split(",");
								 checkForTeeth("llMChecked",glopbalVarForAll);
							 }
							 
							 var missingTeethLR=data[0].missingTeethLR;
							 
							 if(missingTeethLR!="" && missingTeethLR!=null){
								 glopbalVarForAll=missingTeethLR.split(",");
								 checkForTeeth("lrMChecked",glopbalVarForAll);
							 }
							 
							 var unsavableTeethUr=data[0].unsavableTeethUr;
							 if(unsavableTeethUr!="" && unsavableTeethUr!=null){
								 glopbalVarForAll=unsavableTeethUr.split(",");
								 checkForTeeth("unurChecked",glopbalVarForAll);
							 }
							 var unsavableTeethUl=data[0].unsavableTeethUl;
							 if(unsavableTeethUl!="" && unsavableTeethUl!=null){
								 glopbalVarForAll=unsavableTeethUl.split(",");
								 checkForTeeth("unulChecked",glopbalVarForAll);
							 }
							 
							 var unsavableTeethLl=data[0].unsavableTeethLl;
							 if(unsavableTeethLl!="" && unsavableTeethLl!=null){
								 glopbalVarForAll=unsavableTeethLl.split(",");
								 checkForTeeth("unllChecked",glopbalVarForAll);
							 }
							 
							 var unsavableTeethLr=data[0].unsavableTeethLr;
							 if(unsavableTeethLr!="" && unsavableTeethLr!=null){
								 glopbalVarForAll=unsavableTeethLr.split(",");
								 checkForTeeth("unlrChecked",glopbalVarForAll);
							 }
							 $('#dentalOffier').val(data[0].dentalOffier);
							 $('#remarks').val(data[0].remarks);
							 $('#remarkAdvice').val(data[0].remarkAdvice);
							 
							 var pcHeight=data[0].pcHeight;
							 if(pcHeight!="" && pcHeight!=null && pcHeight!=undefined)
							 $('#height').val(pcHeight);
							 
							 var pcWeight=data[0].pcWeight;
							 $('#weight').val(pcWeight);
							 
							 var pcIdealWeight=data[0].pcIdealWeight;
							 $('#idealWeight').val(pcIdealWeight);
							 
							 var pcOverWeight=data[0].pcOverWeight;
							 $('#overWeight').val(pcOverWeight);
							 
							 var pcBmi=data[0].pcBmi;
							 $('#bmi').val(pcBmi);
							 
							 var pcBodyFat=data[0].pcBodyFat;
							 $('#bodyFat').val(pcBodyFat);
							 
							 var pcWaist=data[0].pcWaist;
							 $('#waist').val(pcWaist);
 							 
							 var pcSkinFoldExpansion=data[0].pcSkinFoldExpansion;
							 $('#skinFoldExpansion').val(pcSkinFoldExpansion);
							 
							 var pcChestFullExpansion=data[0].pcChestFullExpansion;
							 $('#chestFullExpansion').val(pcChestFullExpansion);
							 
							 var pcRangeOfExpansion=data[0].pcRangeOfExpansion;
							 if(data[0].pcRangeOfExpansion!=null && data[0].pcRangeOfExpansion!="" && data[0].pcRangeOfExpansion!=undefined)
							 $('#rangeOfExpansion').val(pcRangeOfExpansion);
							 
							 var pcSportsman=data[0].pcSportsman;
							 setSelectedValue("sportsman",pcSportsman);
							  //Vision start
								
								 var distantWithoutGlasses=data[0].distantWithoutGlasses;
								 setSelectedValue("distantWithoutGlasses",distantWithoutGlasses);
							 
								 var distantWithoutGlassesL=data[0].distantWithoutGlassesL;
								 setSelectedValue("distantWithoutGlassesL",distantWithoutGlassesL);	
								 
								 var nearWithoutGlasses=data[0].nearWithoutGlasses;
								 setSelectedValue("nearWithoutGlasses",nearWithoutGlasses);
								 
								 var nearWithoutGlassesL=data[0].nearWithoutGlassesL;
								 setSelectedValue("nearWithoutGlassesL",nearWithoutGlassesL);
								
								 
								 var cpWithoutGlasses=data[0].cpWithoutGlasses;
								 setSelectedValue("cpWithoutGlasses",cpWithoutGlasses);
							 
								 
								 var distantWithGlasses=data[0].distantWithGlasses;
								 setSelectedValue("distantWithGlasses",distantWithGlasses);
								 
								 var distantWithGlassesL=data[0].distantWithGlassesL;
								 setSelectedValue("distantWithGlassesL",distantWithGlassesL);
								 
								 
								 var nearWithGlasses=data[0].nearWithGlasses;
								 setSelectedValue("nearWithGlasses",nearWithGlasses);
							
								 
								 var nearWithGlassesL=data[0].nearWithGlassesL;
								 setSelectedValue("nearWithGlassesL",nearWithGlassesL);
								 
							//Hearing
							 var fwR=data[0].fwR;
							 if(fwR!="" && fwR!=null)
							 $('#fwR').val(fwR);
							 
							 var fwL=data[0].fwL;
							 if(fwL!="" && fwL!=null)
							 $('#fwL').val(fwL);
							 
							 var fwBoth=data[0].fwBoth;
							 if(fwBoth!="" && fwBoth!=null)
							 $('#fwBoth').val(fwBoth);
							 
							 var cvR=data[0].cvR;
							 if(cvR!="" && cvR!=null)
							 $('#cvR').val(cvR);
							 
							 var cvL=data[0].cvL;
							 if(cvL!="" && cvL!=null)
							 $('#cvL').val(cvL);
							 
							 var cvBoth=data[0].cvBoth;
							 if(cvBoth!="" && cvBoth!=null)
							 $('#cvBoth').val(cvBoth);
							 
							 var tmR=data[0].tmR;
							 if(tmR!="" && tmR!=null)
							 setSelectedValue("tmR",tmR);
							 
							 var tmL=data[0].tmL;
							 if(tmL!="" && tmL!=null)
							 setSelectedValue("tmL",tmL);
							 
							 var mobilityR=data[0].mobilityR;
							 //$('#mobilityR').val(mobilityR);
							 setSelectedValue("mobilityR",mobilityR);
							 
							 var mobilityL=data[0].mobilityL;
							 //$('#mobilityL').val(mobilityL);
							 setSelectedValue("mobilityL",mobilityL);
							 
							 var noiseThroatSinuses=data[0].noiseThroatSinuses;
							 if(noiseThroatSinuses!=null && noiseThroatSinuses!="")
							 $('#noseThroatSinuses').val(noiseThroatSinuses);
							 
							 var audiometryRecord=data[0].audiometryRecord;
							 
							 setSelectedValue("audiometryRecord",audiometryRecord);
							 if(audiometryRecord!=null && audiometryRecord=='Others'){
							 var audiometryRecordOthers=data[0].audiometryRecordForOther;
							 $('#audiometryRecordForOther').val(audiometryRecordOthers);
							 $('#audiometryRecordForDisplay').show();
							 }
							 else{
								 $('#audiometryRecordForDisplay').hide();
							 }
							 var clinicalNotes=data[0].clinicalNotes;
							 $('#clinicalNotes').val(clinicalNotes);
							 
							 var pluse=data[0].pluse;
							 $('#pulse').val(pluse);
							 
							 var bp=data[0].bp;
							 $('#bp').val(bp);
							 
							 var bp1=data[0].bp1;
							 $('#bp1').val(bp1);
							 
							 var heartSize=data[0].heartSize;
							 $('#heartSize').val(heartSize);
							 
							 var sounds=data[0].sounds;
							 $('#sounds').val(sounds);
							 
							 var rhythm=data[0].rhythm;
							 $('#rhythm').val(rhythm);
							 
							 var respiratorySystem=data[0].respiratorySystem;
							 $('#respiratorySystem').val(respiratorySystem);
							 
							 var liver=data[0].liver;
							 if(liver!="" && liver!=undefined){
								 setSelectedValue("liverPalpable",'Yes');
								 $('#liver').val(liver);
								 $('#liverPalpableInput').show();
							 }
							 else{
								 setSelectedValue("liverPalpable",'No'); 
								 $('#liverPalpableInput').hide();
							 }
							 
							 
							 var spleen=data[0].spleen;
							 if(spleen!=""  && spleen!=undefined){
								 setSelectedValue("spleenPalpable",'Yes');
								 $('#spleen').val(spleen);
								 $('#spleenPalpableInput').show();
								 
							 }
							 
							 else{
								 setSelectedValue("spleenPalpable",'No'); 
								 $('#spleenPalpableInput').hide();
							 }
							 var higherMentalFunction=data[0].higherMentalFunction;
							 $('#higherMentalFunction').val(higherMentalFunction);
							 
							 
							 var speech=data[0].speech;
							 $('#speech').val(speech);
							 
							 var reflexes=data[0].reflexes;
							 $('#reflexes').val(reflexes);
							 
							 var tremors=data[0].tremors;
							 setSelectedValue("tremors",tremors);
							 
							 var selfBalancingTest=data[0].selfBalancingTest;
							 setSelectedValue("selfBalancingTest",selfBalancingTest);
							 
							 var locomotorSystem=data[0].locomotorSystem;
							 $('#locomotorSystem').val(locomotorSystem);
							 
							 var spine=data[0].spine;
							 $('#spine').val(spine);
							 
							 var hernia=data[0].hernia;
							 $('#hernia').val(hernia);
							 
							 var hydrocele=data[0].hydrocele;
							 $('#hydrocele').val(hydrocele);
							 
							 var breast=data[0].breast;
							 $('#breast').val(breast);
							 
 							 
							 var pcChestFullExpansion=data[0].pcChestFullExpansion;
							 $('#chestFullExpansion').val(pcChestFullExpansion);
							 
							 var opdPatientDetailId=data[0].opdPatientDetailId
							 $('#opdPatientDetailId').val(opdPatientDetailId);
							 
						var saveInDraft=$('#saveInDraft').val( );
						var status= data[0].status;
							 	$('#chiefComplaint').val( data[0].chiefComplaint);
							 
							 	$('#pollar').val( data[0].pollar);
							 	
							 	$('#ordema').val( data[0].ordema);
							 	
							 	$('#cyanosis').val( data[0].cyanosis);
								
								 
							 	$('#hairnail').val( data[0].hairnail);
							 	
							 	$('#icterus').val( data[0].icterus);
							 	
							 	$('#cyanosis').val( data[0].cyanosis);
								 
							 	$('#lymphNode').val( data[0].lymphNode);
							 	
							 	$('#clubbing').val( data[0].clubbing);
								 
							 	$('#gcs').val( data[0].gcs);
								
							 	$('#Tremors').val(data[0].geTremors);
							 	
							 	$('#others').val( data[0].others);
								
							 	$('#remarksForReferal').val( data[0].remarksForReferal);
								$('#remarksReject').val( data[0].remarksReject);
								//$('#finalObservationMo').val( data[0].finalObservationMo);
								finalObservationOfMo=data[0].finalObservationMo;
								$('#remarksPending').val( data[0].remarksPending);
								$('#nextAppointmentDate').val( data[0].nextAppointmentDate);
								
								$('#remarksReject').val( data[0].remarksReject);
								 actionSelected(status);
								
								 var petStatus=data[0].petStatus;
								 
								 setSelectedValue("pet",petStatus);
									 var petDate=data[0].petDate;
									 $('#petDateValue').val(petDate);
 							 
 							 $('#peripheralPulsations').val(data[0].peripheralPulsations);
							 
 							  
							 $('#checkupDate').val(data[0].checkupDate);
							 $('#haemorrhoids').val(data[0].haemorrhoids);
							 /*$('#signedByMo').val(data[0].moUser);
							 $('#signedByRMo').val(data[0].rMoUser);
							 $('#signedByPRMo').val(data[0].pRMoUser);*/

 							 $('#mensturalHistory').val(data[0].mensturalHistory);
							 var lmpselectValue=data[0].lmpSelect;
							 setSelectedValue("lmpSelect",lmpselectValue);
							 $('#lMP').val(data[0].lMP);
							 $('#nosOfPregnancies').val(data[0].nosOfPregnancies);
							 $('#nosOfAbortions').val(data[0].nosOfAbortions);

							 
							 $('#nosOfChildren').val(data[0].nosOfChildren);
							 $('#childDateOfLastConfinement').val(data[0].childDateOfLastConfinement);
							 $('#vaginalDischarge').val(data[0].vaginalDischarge);
							 
							
							 $('#usgAbdomen').val(data[0].usgAbdomen);
							 $('#prolapse').val(data[0].prolapse);
							
							 	finalObservationOfMo=data[0].finalObservationMo;
								finalObservationOfRMo=data[0].finalObservationRmo;
								finalObservationOfPRMo=data[0].paFinalobservation;
								
								
					
								 
			   serviceType =  data[0].serviceType;
			if (listMasServiceType != null
					&& listMasServiceType.length > 0) {
				var masServiceTypeVal = "";
				masServiceTypeVal += '<select class="form-control" id="serviceOfEmployee" name="serviceOfEmployee"';
					masServiceTypeVal += 'class="medium">';
				masServiceTypeVal += '<option value="0"><strong>Select</strong></option>';
				for (var i = 0; i < listMasServiceType.length; i++) {
					var selectedV = '';

					if (serviceType == listMasServiceType[i].serviceTypeId) {
						selectedV = "selected";
					} else {
						selectedV = '';
					}
					masServiceTypeVal += '<option   '+selectedV+'  value="' + listMasServiceType[i].serviceTypeId+ '"  >'
							+ listMasServiceType[i].serviceTypeName
							+ '</option>';
				}
				masServiceTypeVal += '</select>';
			}
			$('#serviceOfEmployee').html(masServiceTypeVal);
			
			
			$('#signedByMo').val(data[0].moUser);
        	$('#signedByRMo').val(data[0].rMoUser);
			
						}
					 else{
						  
							if (listMasServiceType != null
									&& listMasServiceType.length > 0) {
								var masServiceTypeVal = "";
								masServiceTypeVal += '<select class="form-control" id="serviceOfEmployee" name="serviceOfEmployee"';
									masServiceTypeVal += 'class="medium">';
								masServiceTypeVal += '<option value="0"><strong>Select</strong></option>';
								for (var i = 0; i < listMasServiceType.length; i++) {
									var selectedV = '';

									if (serviceType == listMasServiceType[i].serviceTypeId) {
										selectedV = "selected";
									} else {
										selectedV = '';
									}
									masServiceTypeVal += '<option   '+selectedV+'  value="' + listMasServiceType[i].serviceTypeId+ '"  >'
											+ listMasServiceType[i].serviceTypeName
											+ '</option>';
								}
								masServiceTypeVal += '</select>';
							}
							$('#serviceOfEmployee').html(masServiceTypeVal);
					 }
				}
			});
	}

 
 function getPatientReferalDetailForDigiFileUpload() {
	 	var saveInDraft=$('#saveInDraft').val();
	 	var disableFlag="";
	 	if(saveInDraft=='ea'|| saveInDraft=='ej'){
	 		disableFlag='disabled';
	 	}
	 	else{
	 		disableFlag="";
	 	}
	 	
	 	var opdPatientDetailId = $('#opdPatientDetailId').val();
	 	var patientId = $('#patientId').val();
	 	var visitId = $('#visitId').val();
	 	var hospitalId=$('#hospitalId').val();
	 	var masIcdList = "";
	 	var data = {
	 		"opdPatientDetailId" : opdPatientDetailId,
	 		"patientId" : patientId,
	 		"visitId" : visitId,
	 		"flagForRefer":"me",
	 		"hospitalId":hospitalId
	 	};
	 	 var pathname = window.location.pathname;
	     var accessGroup = "MMUWeb";
	     var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalexam/getPatientReferalDetailMe";
	 	$.ajax({type : "POST",
	 				contentType : "application/json",
	 				url : url,
	 				data : JSON.stringify(data),
	 				dataType : "json",
	 				// cache: false,
	 				success : function(res) {
	 					data = res.listReferralPatientDt;
	 					
	 					var masEmpanaledList = res.masEmpanelledHospitalList;
	 					
	 					var	masIcdList = res.listMasIcd;
	 				
	 					//var masDepartment=res.departmentList;
	 					masSpecialistList=res.departmentList;
	 					var referrDtData = "";
	 					var count = 1;
	 					investigationGridValue = "referrDtData";
	 					var diagnosisValue = "";
	 					var diagonisisIdValue = "";
	 					var referalPatientDtIds = "";
	 					var referalNotes = "";
	 					var referVisitDates = "";
	 					var hospitalIdValue="";
	 					var totalLengthDigiFileReferVal=0;
	 					var finalNotes="";
	 					func1='fillDiagnosisComboForRefered';
			    		   url1='opd';
			    		   url2='getIcdListByName';
			    		   flaga='diagnosisMe';
	 					
	 					if (data != undefined && data.length != 0) {
	 						
	 						for (var i = 0; i < data.length; i++) {
	 							if(data[i].referalNotes!=null && data[i].referalNotes!="")
	 								referalNotes=data[i].referalNotes;
	 							
	 							
	 							referrDtData += '<tr ">';
	 							
	 							referrDtData += '<td>' + count + '</td>';
	 							
	 							referrDtData += '<td><select class="form-control" '+disableFlag+' id="medicalExamReferalHos'
	 									+ i + '" name="medicalExamReferalHos"';
	 							referrDtData += 'class="medium">';
	 							var masEmpanalId = data[i].masEmpanalId;
	 							referrDtData += '<option value="0"><strong>Please select hospital</strong></option>';
	 							var selectMasEmpalHos = "";
	 						
	 							hospitalIdValue=masEmpanalId;
	 							$.each(masEmpanaledList,function(ij, empanal) {
	 												if (masEmpanalId == empanal.empanelledHospitalId) {
	 													selectMasEmpalHos = 'selected';
	 												} else {
	 													selectMasEmpalHos = "";
	 												}
	 												referrDtData += '<option ' + selectMasEmpalHos + ' value="' + empanal.empanelledHospitalId
	 														+ '@'
	 														+ empanal.empanelledHospitalCode
	 														+ '" >'
	 														+ empanal.empanelledHospitalName
	 														+ '</option>';
	 											});
	 							referrDtData += '</select>';
	 							referrDtData += '</td>';
	 							
	 							referrDtData += '<td>';
	 							
	 							var exDepartmentValue = data[i].exDepartmentValue;
								
								referrDtData += '<select class="form-control" id="departmentValue'
									+ i + '" name="departmentValue"';
								referrDtData += 'class="medium">';
								  referrDtData += '<option value=""><strong>Select Department...</strong></option>';
								var selectDepart="";
								
			 					$.each(masSpecialistList, function(i, item) {
			 						
			 						if (exDepartmentValue == item.specialityName) {
										selectDepart = 'selected';
									} else {
										selectDepart = "";
									}
			 						referrDtData += '<option '+selectDepart+' value="'+ item.specialityName + '" >' + item.specialityName
			 								+ '</option>';
			 					});
			 					
								referrDtData += '</select>';
	 							
	 							
	 							/*referrDtData += '<input type="text" '+disableFlag+' class="form-control departmentListClass" id="departmentValue'
	 									+ i
	 									+ '" name="departmentValue" value="'
	 									+ data[i].exDepartmentValue + '" />';*/
	 							
	 							
	 							
	 							
	 							referrDtData += '<input type="hidden" id="diagonsisId'+ i+ '" name="diagonsisId" value="'
	 									+ data[i].diagonisId + '"/>';
	 							referrDtData += '<input type="hidden"  name="masEmpanalHospitalId" value="'
	 									+ hospitalIdValue
	 									+ '" id="masEmpanalHospitalId'+hospitalIdValue+'"/>';
	 							referrDtData += '<input type="hidden"  name="masDepatId" value="'
	 									+ data[i].masDepatId
	 									+ '" id="masDepatId"/>';

	 							referrDtData += '<input type="hidden"  name="referalPatientDt" value="'
	 									+ data[i].referalPatientDt
	 									+ '" id="referalPatientDt'+data[i].referalPatientDt+'"/>';
	 							referrDtData += '<input type="hidden"  name="referalPatientHd" value="'
	 									+ data[i].referalPatientHd
	 									+ '" id="referalPatientHd'+data[i].referalPatientHd+'"/>';

	 							referrDtData += '</td>';
	 							
	 							
	 							referrDtData += '<td><div class="autocomplete forTableResp">';
	 							
	 							referrDtData +=' <input name="icddiagnosis" id="icddiagnosis" '+disableFlag+' type="text"';
	 							referrDtData +='class="form-control border-input"';
	 							
	 							/*referrDtData +='placeholder=" " value="'+ data[i].daiganosisName + '['+ data[i].masCode + ']' + '"  onKeyPress="autoCompleteCommonMe(this,5);"  onKeyUp="autoCompleteCommonMe(this,5);"';
	 							referrDtData +='onblur="fillDiagnosisCombo(this.value,this);" />';
	 							*/
	 							referrDtData +='placeholder=" " value="'+ data[i].daiganosisName + '['+ data[i].masCode + ']' + '"    onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" ';
	 							referrDtData +=' />';
	 							referrDtData += '<div id="diagnosisDivMe" class="autocomplete-itemsNew"></div>';
	 							referrDtData += '<div></td>';
	 							
	 							referrDtData += '<td><input type="text" class="form-control" '+disableFlag+' id="instruction" name="instruction" value="'
	 									+ data[i].instruction + '" /></td>';
	 							
	 							referrDtData += '<td><textarea name="specialistOpinion" id="specialistOpinion'+data[i].diagonisId+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###'+escapeHtml(data[i].finalNotes)+'</textarea><a class="btn-link" href="javascript:void(0)"  onclick="openResultModelSpecialist(this);">View/Enter Result</a></td>';

	 							//referrDtData += "<td><button id ='printBtn' type='button'  class='btn btn-primary' onclick='viewDocumentForDigi("+data[i].ridcId+");'>View Document</button></td>";
	 							var deleteButtonFlag="";
	 							var ridcIdVal=0;
	 							if(data[i].ridcId!=null){
	 								totalLengthDigiFileReferVal++;
	 								ridcIdVal=data[i].ridcId;
	 								}
	 							else{
	 								deleteButtonFlag='';
	 								deleteButtonFlag='disabled';
	 								ridcIdVal=0;
	 							}
	 							if(ridcIdVal>0){
	 							referrDtData += '	<td><a class="btn-link" href="JavaScript:Void(0);" onclick="viewDocumentForDigi('+data[i].ridcId+');" >View Document</a></td>'
	 							}
	 							else{
	 								referrDtData += '	<td>';
	 								referrDtData += '	<div class="fileUploadDiv">';
	 								referrDtData += '		<input type="file" name="referalFileUpload" id="referalFileUpload'+count+'" class="inputUpload" />';
	 								referrDtData += '		<label class="inputUploadlabel">Choose File</label>';
	 								referrDtData += '		<span class="inputUploadFileName">No File Chosen</span>';
	 								referrDtData += '	</div>';
	 								referrDtData += '	</td>';
	 							}
	 							//referrDtData += '<td><a class="btn-link" href="#" '+disableFlag+'>View Document</a></td>';

	 							referrDtData += '<td><button type="Button" name="add" class="buttonAdd btn btn-primary noMinWidth" id="referalMedicalDtIdAdd" button-type="add" value="" tabindex="1" onclick="addRowForReferalForDigiFileUpload();"> </button></td>';
	 							referrDtData += '<td><button type="button" name="delete" value=""    id="referalDtMedicalIdDel"  class="buttonDel btn btn-danger noMinWidth" button-type="delete"  tabindex="1" onclick="deleteInvestAndReferalValueRow(this,11,\''
	 									+ ridcIdVal + '\');" ></button></td>';
	 							referrDtData += '</tr>';
	 							count++;
	 						}
	 						$('#totalLengthDigiFileRefer').val(totalLengthDigiFileReferVal);
	 						$("#medicalReferal").html(referrDtData);
	 						if(referalNotes!="" && referalNotes!=null && referalNotes!=undefined)
	 							$('#referralNote').val(referalNotes);
	 					} 
	 					else{
	 						
	 						/*var masHospital="";
	 					
	 						masHospital += '<select class="form-control" id="medicalExamReferalHos1" name="medicalExamReferalHos"';
	 						masHospital += 'class="medium">';
						 
							masHospital += '<option value=""><strong>Please select hospital</strong></option>';
							var selectMasEmpalHos = "";
							$.each(masEmpanaledList,function(ij, empanal) {
								masHospital += '<option ' + selectMasEmpalHos + ' value="' + empanal.empanelledHospitalId
														+ '@'
														+ empanal.empanelledHospitalCode
														+ '" >'
														+ empanal.empanelledHospitalName
														+ '</option>';
											});
							masHospital += '</select>';
							masHospital += ' ';*/
							$('#totalLengthDigiFileRefer').val("0");
							//if(flagForm=='u'){
								getReferalOneGrid(masEmpanaledList,masSpecialistList);
							//}
							/*else
							$("#masEmpanelME").html(masHospital);	*/
	 					}
	 					
	 				}
	 			});

	 	return false;
	 }
	 

 
 function getAFMSF3BForForm18DigiFileUpload() {
		var visitId = $('#visitId').val();
		var age = $('#ageForPatient').val();
		var userId=$('#userId').val();
		var data = {
				"visitId" : visitId,
				"flagForForm" :"f3",
				"age":age,
				"userId":userId
			};
		var pathname = window.location.pathname;
	     var accessGroup = "MMUWeb";
		 var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalexam/getAFMSF3BForMOOrMA";
		
			$.ajax({

				type : "POST",
				contentType : "application/json",
				url : url,

				data : JSON.stringify(data),
				dataType : "json",
				// cache: false,

				success : function(res) {
					 data = res.listOfResponse;
					 var listMasServiceType = res.listMasServiceType;
					 var serviceType="";
					 if (data != undefined && data != null && data!="") {
						 if(data[0].totalNoOfTeath!=null && data[0].totalNoOfTeath!="")
							$('#totalNoOfTeath').val(data[0].totalNoOfTeath);
						 if(data[0].totalNoOfDefective!=null && data[0].totalNoOfDefective!="")
							$('#totalNoOfDefective').val(data[0].totalNoOfDefective);
						 if(data[0].totalNoOfDentalPoints!=null && data[0].totalNoOfDentalPoints!="")
							$('#totalNoOfDentalPoints').val(data[0].totalNoOfDentalPoints);
						 if(data[0].missing!=null && data[0].missing!="")
							$('#missing').val(data[0].missing);
						 if(data[0].unSavable!=null && data[0].unSavable!="")
							$('#unSavable').val(data[0].unSavable);
						 if(data[0].conditionOfGums!=null && data[0].conditionOfGums!="")
							$('#conditionOfGums').val(data[0].conditionOfGums);
							
							var glopbalVarForAll;
							 var missingTeethUr=data[0].missingTeethUr;
							 if(missingTeethUr!="" && missingTeethUr!=null){
								 glopbalVarForAll=missingTeethUr.split(",");
								 checkForTeeth("urMChecked",glopbalVarForAll);
							 }
							 
							 var missingTeethUl=data[0].missingTeethUl;
							 if(missingTeethUl!="" && missingTeethUl!=null){
								 glopbalVarForAll=missingTeethUl.split(",");
								 checkForTeeth("ulMChecked",glopbalVarForAll);
							 }
							 var missingTeethLL=data[0].missingTeethLL;
							 
							 if(missingTeethLL!="" && missingTeethLL!=null){
								 glopbalVarForAll=missingTeethLL.split(",");
								 checkForTeeth("llMChecked",glopbalVarForAll);
							 }
							 
							 var missingTeethLR=data[0].missingTeethLR;
							 
							 if(missingTeethLR!="" && missingTeethLR!=null){
								 glopbalVarForAll=missingTeethLR.split(",");
								 checkForTeeth("lrMChecked",glopbalVarForAll);
							 }
							 
							 var unsavableTeethUr=data[0].unsavableTeethUr;
							 if(unsavableTeethUr!="" && unsavableTeethUr!=null){
								 glopbalVarForAll=unsavableTeethUr.split(",");
								 checkForTeeth("unurChecked",glopbalVarForAll);
							 }
							 var unsavableTeethUl=data[0].unsavableTeethUl;
							 if(unsavableTeethUl!="" && unsavableTeethUl!=null){
								 glopbalVarForAll=unsavableTeethUl.split(",");
								 checkForTeeth("unulChecked",glopbalVarForAll);
							 }
							 
							 var unsavableTeethLl=data[0].unsavableTeethLl;
							 if(unsavableTeethLl!="" && unsavableTeethLl!=null){
								 glopbalVarForAll=unsavableTeethLl.split(",");
								 checkForTeeth("unllChecked",glopbalVarForAll);
							 }
							 
							 var unsavableTeethLr=data[0].unsavableTeethLr;
							 if(unsavableTeethLr!="" && unsavableTeethLr!=null){
								 glopbalVarForAll=unsavableTeethLr.split(",");
								 checkForTeeth("unlrChecked",glopbalVarForAll);
							 }
							 if(data[0].dentalOffier!=null && data[0].dentalOffier!="")
							 $('#dentalOffier').val(data[0].dentalOffier);
							 if(data[0].remarks!=null && data[0].remarks!="")
							 $('#remarks').val(data[0].remarks);
							 if(data[0].remarkAdvice!=null && data[0].remarkAdvice!="")
							 $('#remarkAdvice').val(data[0].remarkAdvice);
							 
							 var pcHeight=data[0].pcHeight;
							 if(pcHeight!=null && pcHeight!="")
							 $('#height').val(pcHeight);
							 
							 var pcWeight=data[0].pcWeight;
							 if(pcWeight!=null && pcWeight!="")
							 $('#weight').val(pcWeight);
							 
							 var pcIdealWeight=data[0].pcIdealWeight;
							 if(pcIdealWeight!=null && pcIdealWeight!="")
							 $('#idealWeight').val(pcIdealWeight);
							 
							 var pcOverWeight=data[0].pcOverWeight;
							 if(pcOverWeight!=null && pcOverWeight!="")
							 $('#overWeight').val(pcOverWeight);
							 
							 var pcBmi=data[0].pcBmi;
							 if(pcBmi!=null && pcBmi!="")
							 $('#bmi').val(pcBmi);
							 
							 var pcBodyFat=data[0].pcBodyFat;
							 if(pcBodyFat!=null && pcBodyFat!="")
							 $('#bodyFat').val(pcBodyFat);
							 
							 var pcWaist=data[0].pcWaist;
							 if(pcWaist!=null && pcWaist!="")
							 $('#waist').val(pcWaist);
 							 
							 var pcSkinFoldExpansion=data[0].pcSkinFoldExpansion;
							 if(pcSkinFoldExpansion!=null && pcSkinFoldExpansion!="")
							 $('#skinFoldExpansion').val(pcSkinFoldExpansion);
							 
							 var pcChestFullExpansion=data[0].pcChestFullExpansion;
							 if(pcChestFullExpansion!=null && pcChestFullExpansion!="")
							 $('#chestFullExpansion').val(pcChestFullExpansion);
							 
							 var pcRangeOfExpansion=data[0].pcRangeOfExpansion;
							 if(pcRangeOfExpansion!=null && pcRangeOfExpansion!="")
							 $('#rangeOfExpansion').val(pcRangeOfExpansion);
							 
							 var skin=data[0].skin;
							 if(skin!=null && skin!="")
							 $('#skin').val(skin);
							 
							 var pcSportsman=data[0].pcSportsman;
							 if(pcSportsman!=null && pcSportsman!="")
							 setSelectedValue("sportsman",pcSportsman);
							  //Vision start
								
								 var distantWithoutGlasses=data[0].distantWithoutGlasses;
								 if(distantWithoutGlasses!=null && distantWithoutGlasses!="")
								 setSelectedValue("distantWithoutGlasses",distantWithoutGlasses);
							 
								 var distantWithoutGlassesL=data[0].distantWithoutGlassesL;
								 if(distantWithoutGlassesL!=null && distantWithoutGlassesL!="")
								 setSelectedValue("distantWithoutGlassesL",distantWithoutGlassesL);	
								 
								 var nearWithoutGlasses=data[0].nearWithoutGlasses;
								 if(nearWithoutGlasses!=null && nearWithoutGlasses!="")
								 setSelectedValue("nearWithoutGlasses",nearWithoutGlasses);
								 
								 var nearWithoutGlassesL=data[0].nearWithoutGlassesL;
								 if(nearWithoutGlassesL!=null && nearWithoutGlassesL!="")
								 setSelectedValue("nearWithoutGlassesL",nearWithoutGlassesL);
								
								 
								 var cpWithoutGlasses=data[0].cpWithoutGlasses;
								 if(cpWithoutGlasses!=null && cpWithoutGlasses!="")
								 setSelectedValue("cpWithoutGlasses",cpWithoutGlasses);
							 
								 
								 var distantWithGlasses=data[0].distantWithGlasses;
								 if(distantWithGlasses!=null && distantWithGlasses!="")
								 setSelectedValue("distantWithGlasses",distantWithGlasses);
								 
								 var distantWithGlassesL=data[0].distantWithGlassesL;
								 if(distantWithGlassesL!=null && distantWithGlassesL!="")
								 setSelectedValue("distantWithGlassesL",distantWithGlassesL);
								 
								 
								 var nearWithGlasses=data[0].nearWithGlasses;
								 if(nearWithGlasses!=null && nearWithGlasses!="")
								 setSelectedValue("nearWithGlasses",nearWithGlasses);
							
								 
								 var nearWithGlassesL=data[0].nearWithGlassesL;
								 if(nearWithGlassesL!=null && nearWithGlassesL!="")
								 setSelectedValue("nearWithGlassesL",nearWithGlassesL);
								 
							//Hearing
							 var fwR=data[0].fwR;
							 if(fwR!=null && fwR!="")
							 $('#fwR').val(fwR);
							 
							 var fwL=data[0].fwL;
							 if(fwL!=null && fwL!="")
							 $('#fwL').val(fwL);
							 
							 var fwBoth=data[0].fwBoth;
							 if(fwBoth!=null && fwBoth!="")
							 $('#fwBoth').val(fwBoth);
							 
							 var cvR=data[0].cvR;
							 if(cvR!=null && cvR!="")
							 $('#cvR').val(cvR);
							 
							 var cvL=data[0].cvL;
							 if(cvL!=null && cvL!="")
							 $('#cvL').val(cvL);
							 
							 var cvBoth=data[0].cvBoth;
							 if(cvBoth!=null && cvBoth!="")
							 $('#cvBoth').val(cvBoth);
							 
							 var tmR=data[0].tmR;
							 if(tmR!=null && tmR!="")
							 setSelectedValue("tmR",tmR);
							 
							 var tmL=data[0].tmL;
							 if(tmL!=null && tmL!="")
							 setSelectedValue("tmL",tmL);
							 
							 var mobilityR=data[0].mobilityR;
							 //$('#mobilityR').val(mobilityR);
							 if(mobilityR!=null && mobilityR!="")
							 setSelectedValue("mobilityR",mobilityR);
							 
							 var mobilityL=data[0].mobilityL;
							 //$('#mobilityL').val(mobilityL);
							 if(mobilityL!=null && mobilityL!="")
							 setSelectedValue("mobilityL",mobilityL);
							 
							 var noiseThroatSinuses=data[0].noiseThroatSinuses;
							 if(noiseThroatSinuses!=null && noiseThroatSinuses!="")
							 $('#noseThroatSinuses').val(noiseThroatSinuses);
							 
							 var audiometryRecord=data[0].audiometryRecord;
							 
							 if(audiometryRecord!=null && audiometryRecord!="")
							 setSelectedValue("audiometryRecord",audiometryRecord);
							 if(audiometryRecord!=null && audiometryRecord=='Others'){
							 var audiometryRecordOthers=data[0].audiometryRecordForOther;
							 $('#audiometryRecordForOther').val(audiometryRecordOthers);
							 $('#audiometryRecordForDisplay').show();
							 }
							 else{
								 $('#audiometryRecordForDisplay').hide();
							 }
							 var clinicalNotes=data[0].clinicalNotes;
							 if(clinicalNotes!=null && clinicalNotes!="")
							 $('#clinicalNotes').val(clinicalNotes);
							 
							 var pluse=data[0].pluse;
							 if(pluse!=null && pluse!="")
							 $('#pulse').val(pluse);
							 
							 var bp=data[0].bp;
							 if(bp!=null && bp!="")
							 $('#bp').val(bp);
							 
							 var bp1=data[0].bp1;
							 if(bp1!=null && bp1!="")
							 $('#bp1').val(bp1);
							 
							 var heartSize=data[0].heartSize;
							 if(heartSize!=null && heartSize!="")
							 $('#heartSize').val(heartSize);
							 
							 var sounds=data[0].sounds;
							 if(sounds!=null && sounds!="")
							 $('#sounds').val(sounds);
							 
							 var rhythm=data[0].rhythm;
							 if(rhythm!=null && rhythm!="")
							 $('#rhythm').val(rhythm);
							 
							 var respiratorySystem=data[0].respiratorySystem;
							 if(respiratorySystem!=null && respiratorySystem!="")
							 $('#respiratorySystem').val(respiratorySystem);
							 
							 var liver=data[0].liver;
							 if(liver!="" && liver!=undefined){
								 setSelectedValue("liverPalpable",'Yes');
								 $('#liver').val(liver);
								 $('#liverPalpableInput').show();
							 }
							 else{
								 setSelectedValue("liverPalpable",'No'); 
								 $('#liverPalpableInput').hide();
							 }
							 
							 
							 var spleen=data[0].spleen;
							 if(spleen!=""  && spleen!=undefined){
								 setSelectedValue("spleenPalpable",'Yes');
								 $('#spleen').val(spleen);
								 $('#spleenPalpableInput').show();
								 
							 }
							 
							 else{
								 setSelectedValue("spleenPalpable",'No'); 
								 $('#spleenPalpableInput').hide();
							 }
							 var higherMentalFunction=data[0].higherMentalFunction;
							 if(higherMentalFunction!=null && higherMentalFunction!="")
							 $('#higherMentalFunction').val(higherMentalFunction);
							 
							 
							 var speech=data[0].speech;
							 if(speech!=null && speech!="")
							 $('#speech').val(speech);
							 
							 var reflexes=data[0].reflexes;
							 if(reflexes!=null && reflexes!="")
							 $('#reflexes').val(reflexes);
							 
							 var tremors=data[0].tremors;
							 if(tremors!=null && tremors!="")
							 setSelectedValue("tremors",tremors);
							 
							 var selfBalancingTest=data[0].selfBalancingTest;
							 if(selfBalancingTest!=null && selfBalancingTest!="")
							 setSelectedValue("selfBalancingTest",selfBalancingTest);
							 
							 var locomotorSystem=data[0].locomotorSystem;
							 if(locomotorSystem!=null && locomotorSystem!="")
							 $('#locomotorSystem').val(locomotorSystem);
							 
							 var spine=data[0].spine;
							 if(spine!=null && spine!="")
							 $('#spine').val(spine);
							 
							 var hernia=data[0].hernia;
							 if(hernia!=null && hernia!="")
							 $('#hernia').val(hernia);
							 
							 var hydrocele=data[0].hydrocele;
							 if(hydrocele!=null && hydrocele!="")
							 $('#hydrocele').val(hydrocele);
							 
							 var breast=data[0].breast;
							 if(breast!=null && breast!="")
							 $('#breast').val(breast);
							 
 							 
							 var pcChestFullExpansion=data[0].pcChestFullExpansion;
							 if(pcChestFullExpansion!=null && pcChestFullExpansion!="")
							 $('#chestFullExpansion').val(pcChestFullExpansion);
							 
							 var opdPatientDetailId=data[0].opdPatientDetailId
							 if(opdPatientDetailId!=null && opdPatientDetailId!="")
							 $('#opdPatientDetailId').val(opdPatientDetailId);
							 
						var saveInDraft=$('#saveInDraft').val( );
						var status= data[0].status;
							 	$('#chiefComplaint').val( data[0].chiefComplaint);
							 
							 	$('#pollar').val( data[0].pollar);
							 	
							 	$('#ordema').val( data[0].ordema);
							 	
							 	$('#cyanosis').val( data[0].cyanosis);
								
								 
							 	$('#hairnail').val( data[0].hairnail);
							 	
							 	$('#icterus').val( data[0].icterus);
							 	
							 	$('#cyanosis').val( data[0].cyanosis);
								 
							 	$('#lymphNode').val( data[0].lymphNode);
							 	
							 	$('#clubbing').val( data[0].clubbing);
								 
							 	$('#gcs').val( data[0].gcs);
								
							 	$('#Tremors').val(data[0].geTremors);
							 	
							 	$('#others').val( data[0].others);
								
							 	$('#remarksForReferal').val( data[0].remarksForReferal);
								$('#remarksReject').val( data[0].remarksReject);
								//$('#finalObservationMo').val( data[0].finalObservationMo);
								finalObservationOfMo=data[0].finalObservationMo;
								$('#remarksPending').val( data[0].remarksPending);
								$('#nextAppointmentDate').val( data[0].nextAppointmentDate);
								
								$('#remarksReject').val( data[0].remarksReject);
								 actionSelected(status);
								
								 var petStatus=data[0].petStatus;
								 
								 setSelectedValue("pet",petStatus);
								 var petDate=data[0].petDate;
								 $('#petDateValue').val(petDate);
								
 							
							 
							 if(data[0].peripheralPulsations!=null && data[0].peripheralPulsations!="")
							 $('#peripheralPulsations').val(data[0].peripheralPulsations);
							 
							  
							 if(data[0].checkupDate!=null && data[0].checkupDate!="")
							 $('#checkupDate').val(data[0].checkupDate);
							 if(data[0].haemorrhoids!=null && data[0].haemorrhoids!="")
							 $('#haemorrhoids').val(data[0].haemorrhoids);
							  							  
							 if(data[0].mensturalHistory!=null && data[0].mensturalHistory!="")
							 $('#mensturalHistory').val(data[0].mensturalHistory);
							 var lmpselectValue=data[0].lmpSelect;
							 if(lmpselectValue!=null && lmpselectValue!="")
							 setSelectedValue("lmpSelect",lmpselectValue);
							 if(data[0].lMP!=null && data[0].lMP!="")
							 $('#lMP').val(data[0].lMP);
							// if(data[0].nosOfPregnancies!=null && data[0].nosOfPregnancies!="")
							 $('#nosOfPregnancies').val(data[0].nosOfPregnancies);
							 //if(data[0].nosOfAbortions!=null && data[0].nosOfAbortions!="")
							 $('#nosOfAbortions').val(data[0].nosOfAbortions);

							// if(data[0].nosOfChildren!=null && data[0].nosOfChildren!="")
							 $('#nosOfChildren').val(data[0].nosOfChildren);
							 if(data[0].childDateOfLastConfinement!=null && data[0].childDateOfLastConfinement!="")
							 $('#childDateOfLastConfinement').val(data[0].childDateOfLastConfinement);
							 if(data[0].vaginalDischarge!=null && data[0].vaginalDischarge!="")
							 $('#vaginalDischarge').val(data[0].vaginalDischarge);
							 
							 if(data[0].usgAbdomen!=null && data[0].usgAbdomen!="")
							 $('#usgAbdomen').val(data[0].usgAbdomen);
							 if(data[0].prolapse!=null && data[0].prolapse!="")
							 $('#prolapse').val(data[0].prolapse);
							 
							 finalObservationOfMo=data[0].finalObservationMo;
								finalObservationOfRMo=data[0].finalObservationRmo;
								finalObservationOfPRMo=data[0].paFinalobservation;
							
								
								   serviceType =  data[0].serviceType;
									if (listMasServiceType != null
											&& listMasServiceType.length > 0) {
										var masServiceTypeVal = "";
										masServiceTypeVal += '<select class="form-control" id="serviceOfEmployee" name="serviceOfEmployee"';
											masServiceTypeVal += 'class="medium">';
										masServiceTypeVal += '<option value="0"><strong>Select</strong></option>';
										for (var i = 0; i < listMasServiceType.length; i++) {
											var selectedV = '';

											if (serviceType == listMasServiceType[i].serviceTypeId) {
												selectedV = "selected";
											} else {
												selectedV = '';
											}
											masServiceTypeVal += '<option   '+selectedV+'  value="' + listMasServiceType[i].serviceTypeId+ '"  >'
													+ listMasServiceType[i].serviceTypeName
													+ '</option>';
										}
										masServiceTypeVal += '</select>';
									}
									$('#serviceOfEmployee').html(masServiceTypeVal);
									
									
									$('#signedByMo').val(data[0].moUser);
						        	$('#signedByRMo').val(data[0].rMoUser);
						}
					 else{
						 
						 if (listMasServiceType != null
									&& listMasServiceType.length > 0) {
								var masServiceTypeVal = "";
								masServiceTypeVal += '<select class="form-control" id="serviceOfEmployee" name="serviceOfEmployee"';
									masServiceTypeVal += 'class="medium">';
								masServiceTypeVal += '<option value="0"><strong>Select</strong></option>';
								for (var i = 0; i < listMasServiceType.length; i++) {
									var selectedV = '';

									if (serviceType == listMasServiceType[i].serviceTypeId) {
										selectedV = "selected";
									} else {
										selectedV = '';
									}
									masServiceTypeVal += '<option   '+selectedV+'  value="' + listMasServiceType[i].serviceTypeId+ '"  >'
											+ listMasServiceType[i].serviceTypeName
											+ '</option>';
								}
								masServiceTypeVal += '</select>';
							}
							$('#serviceOfEmployee').html(masServiceTypeVal);
					 }
					 
				}
			});
	}

 function getReferalOneGrid(masEmpanaledList,masSpecialistList){
	 var count=1;
	 var referrDtData="";
	 	referrDtData += '<tr ">';
		
		referrDtData += '<td>' + count + '</td>';
		
		referrDtData += '<td><select class="form-control"  id="medicalExamReferalHos'
				+ count + '" name="medicalExamReferalHos"';
		referrDtData += 'class="medium">';
		referrDtData += '<option value="0"><strong>Please select hospital</strong></option>';
		var selectMasEmpalHos = "";
	
		$.each(masEmpanaledList,function(ij, empanal) {
							 
							referrDtData += '<option  value="' + empanal.empanelledHospitalId
									+ '@'
									+ empanal.empanelledHospitalCode
									+ '" >'
									+ empanal.empanelledHospitalName
									+ '</option>';
						});
		referrDtData += '</select>';
		referrDtData += '</td>';
		
		referrDtData += '<td>';
		
		referrDtData += '<select class="form-control" id="departmentValue'+count+''
			+ i + '" name="departmentValue"';
		referrDtData += 'class="medium">';
		  referrDtData += '<option value=""><strong>Select Department...</strong></option>';
		var selectDepart="";
			$.each(masSpecialistList, function(i, item) {
				referrDtData += '<option   value="'+ item.specialityName + '" >' + item.specialityName
						+ '</option>';
			});
			
		referrDtData += '</select>';
		
		
		referrDtData += '<input type="hidden" id="diagonsisId'+ count+ '" name="diagonsisId" value=""/>';
		referrDtData += '<input type="hidden"  name="masEmpanalHospitalId" value="" id="masEmpanalHospitalId"/>';
		referrDtData += '<input type="hidden"  name="masDepatId" value="" id="masDepatId"/>';

		referrDtData += '<input type="hidden"  name="referalPatientDt" value="" id="referalPatientDt"/>';
		referrDtData += '<input type="hidden"  name="referalPatientHd" value="" id="referalPatientHd"/>';

		referrDtData += '</td>';
		
		
		referrDtData += '<td><div class="autocomplete forTableResp">';
		
		/*referrDtData +=' <input name="icddiagnosis" id="icddiagnosis"  type="text"';
		referrDtData +='class="form-control border-input"';
		referrDtData +='placeholder=" " value=""  onKeyPress="autoCompleteCommonMe(this,5);"  onKeyUp="autoCompleteCommonMe(this,5);"';
		referrDtData +='onblur="fillDiagnosisCombo(this.value,this);" />';
		*/
		func1='fillDiagnosisComboForRefered';
		referrDtData +=' <input name="icddiagnosis" id="icddiagnosis"  type="text"';
		referrDtData +='class="form-control border-input"';
		referrDtData +='placeholder=" " value=""   onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" ';
		referrDtData +='  />';
		referrDtData += '<div id="diagnosisDivMe" class="autocomplete-itemsNew"></div>';
		
		referrDtData += '<div></td>';
		
		referrDtData += '<td><input type="text" class="form-control"   id="instruction" name="instruction" value=" " /></td>';
		referrDtData += '<td> <textarea name="specialistOpinion" id="specialistOpinion" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;"></textarea> <a class="btn-link" href="javascript:void(0)"  onclick="openResultModelSpecialist(this);">View/Enter Result</a></td>	';
		referrDtData += '<td><div class="fileUploadDiv"><input type="file" name="referalFileUpload" id="referalFileUpload"class="inputUpload" /><label class="inputUploadlabel">Choose File</label><span class="inputUploadFileName">No File Chosen</span></div></td>';

		referrDtData += '<td><button type="Button" name="add" class="buttonAdd btn btn-primary noMinWidth" id="referalMedicalDtIdAdd" button-type="add" value="" tabindex="1" onclick="addRowForReferalForDigiFileUpload();"> </button></td>';
		referrDtData += '<td><button type="button" name="delete" value=""    id="referalDtMedicalIdDelNew"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" onclick="deleteInvestAndReferalValueRow(this,11,0);" ></button></td>';
		referrDtData += '</tr>';
		$("#medicalReferal").html(referrDtData);
 }
 var specialistHtml='';
 var masSpecialistList=''; 
 function getSpecialistList() {
  
 	var j=1;
     
 	var pathname = window.location.pathname;
 	var accessGroup = "MMUWeb";
 	var url = window.location.protocol + "//"
 	+ window.location.host + "/" + accessGroup
 	+ "/opd/getSpecialistList";
 	$
 			.ajax({
 				url : url,
 				dataType : "json",
 				data : JSON.stringify({
 					'employeeId' : '1'
 				}),
 				contentType : "application/json",
 				type : "POST",
 				success : function(response) {
 					console.log(response);
 					masSpecialistList = response.MasSpecialistList;
 					var specialistHtml = '<option value=""><strong>Select Department...</strong></option>';
 					$.each(masSpecialistList, function(i, item) {
 						specialistHtml += '<option value="' + item.specialityId + '@'
 								+ item.specialityCode + '" >' + item.specialityName
 								+ '</option>';
 						
 					});
 					
 					$('#departmentValue').html(specialistHtml);
 				  
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
  
 
 function closeMessage(){
	 try{
		 $('#saveEntryForma').attr('disabled',false);
		$('#submitEntryForma').attr('disabled',false);
	 }
	 catch(e){}
	 $('#errordiv').empty("");
	$('#messageForUploadInv').hide();
	$('#messageForInvestigationOutside').hide();
	$('.modal-backdrop ').hide();
	$('.modal-backdrop2 ').hide();
	$('.modal').hide();
	
}
 
 
 
 
 
 
 
 
 function overWeightOb(radioValue)
 {
	 
	 if(radioValue=='N'){
		 //$('#ObesityId').addClass('font-bold');
		 document.getElementById("ObesityId").style.font = "bold 15px Arial, serif";
 		 document.getElementById("OverweightId").style.fontSize ="inherit";
 		 document.getElementById("NoneId").style.fontSize ="inherit";
		 
		 $('#obsistyCheck').removeAttr('disabled');
		 
		 
	 }

	 if(radioValue=='Y'){
		// $('#OverweightId').addClass('font-bold');
		 //$('#overCheck').removeAttr('disabled');
	 
		 document.getElementById("OverweightId").style.font = "bold 15px Arial, serif"; 
 		 document.getElementById("NoneId").style.font = "inherit"; 
 		 document.getElementById("ObesityId").style.fontSize ="inherit";
 		$('#overCheck').removeAttr('disabled');
	 }
	 
	 if(radioValue=='A'){
		// $('#NoneId').addClass('font-bold');
		 document.getElementById("NoneId").style.font = "bold 15px Arial, serif"; 
 		 document.getElementById("OverweightId").style.fontSize ="inherit";
 		 document.getElementById("ObesityId").style.fontSize ="inherit";
		 
		 $('#noneCheck').removeAttr('disabled');
		 $('#overWeightDropDown').removeAttr('disabled');
	 }
	 
	 
	 var varationWightVal = document.getElementById("overWeight").value;
	 var varationWightActual='10';
	 //var text = document.getElementById("text");
	 if(document.getElementById("obsistyCheck").checked == true){
		 obsistyOverWeight = radioValue; 
		 $('#overWeightDropDown').hide();
	  }
	 if(document.getElementById("noneCheck").checked == true){
		 obsistyOverWeight = radioValue; 
		 $('#overWeightDropDown').hide();
	  }
	 if(document.getElementById("overCheck").checked == true){
		if(document.getElementById('overWeight').value == "")
	 	{	
	 	alert("Overweight Cannot be selected as variation in weight is less than 10")
	 	document.getElementById("overCheck").checked=false;
	 	obsistyOverWeight="";
	 	return false;
	 	}
			
		else if(document.getElementById('overWeight').value != "" && parseFloat(varationWightActual) > parseFloat(varationWightVal))
		{	
			alert("Overweight Cannot be selected as variation in weight is less than 10")
			document.getElementById("overCheck").checked=false;
			obsistyOverWeight="";
			return false;
		}
		
		else
		{	
		 obsistyOverWeight = radioValue; 
		 $('#overWeightDropDown').show();
		 var a = document.getElementById("overWeight").value;
		 var b='20';
		 if(parseFloat(b) > parseFloat(a))
		 {
			
			 document.getElementById("under20").selected=true;	 
		 }
		 else
		 {
			 document.getElementById("above20").selected=true;	 
		 } 
		}
	  }
	
	 if(document.getElementById("obsistyCheck").checked == true){
			if(document.getElementById('overWeight').value == "")
	 		{	
	 		alert("Obesity Cannot be selected as variation in weight is less than 10")
	 		document.getElementById("obsistyCheck").checked=false;
	 		obsistyOverWeight="";
	 		return false;
	 		}
			
			else if(document.getElementById('overWeight').value != "" && parseFloat(varationWightActual) > parseFloat(varationWightVal))
			{	
				alert("Obesity Cannot be selected as variation in weight is less than 10")
		 		document.getElementById("obsistyCheck").checked=false;
				obsistyOverWeight="";
		 		return false;
			}
		  }
 		
 }

 
 
 function getMBPreAssesDetailsDataForDigi() {
		var saveDraftVal=$('#saveInDraft').val();
		investigationGridValue = "investigationGrid";
		var visitId = $('#visitId').val();
		var patientId=$('#patientId').val();
		var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";
		 var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/getMBMedicalCategory";
		
		var data = {
			"visitId" : visitId,
			"patientId":patientId,
			"flagForDigi":"No"
		};
		$.ajax({
					type : "POST",
					contentType : "application/json",
					url : url,
					data : JSON.stringify(data),
					dataType : "json",
					// cache: false,
					success : function(response) {
					var datas = response.data;
					var trHTML = '';
					var i=0;
					var categoryType="";	
					var diasableValue="disabled";
					 var approvalFlag=$('#approvalFlag').val();
					 var approvalFlagDiasable="";
					 if(approvalFlag!="" && approvalFlag!=undefined && approvalFlag!=null && approvalFlag=='y'|| (saveDraftVal!="" && (saveDraftVal=='ea'||saveDraftVal=='ej'))){
						 approvalFlagDiasable='disabled';
					 }
					 else{
						 approvalFlagDiasable="";
					 }
			      var countForSystem=0;
					 
					if(datas!=undefined && datas.length>=1 ){
						
					$.each(datas, function(i, item) {
		
						if(item.system!=null && item.system!=""){
							countForSystem++;
						var duration="";
						var investigationName="";
							/*if(item.inveName!=undefined && item.inveName!="" && item.inveName!=null){
								 investigationName=item.inveName;	
							}*/
							var icdName="";
							if(item.icdName!=undefined && item.icdName!=null && item.icdName!=""){
						    	icdName=item.icdName
						    }
							
							var system="";
							if(item.system!=undefined && item.system!=null && item.system!=""){
								system=item.system;
							}
							var medicalCategory="";
							if(item.medicalCategory!=undefined && item.medicalCategory!=null && item.medicalCategory!="")
								medicalCategory=item.medicalCategory;
							 
							if(item.categoryType!=undefined && item.categoryType!=null && item.categoryType!="")
								categoryType=item.categoryType;
							var categoryDate="";
							if(item.categoryDate!=undefined && item.categoryDate!=null && item.categoryDate!=""){
								categoryDate=item.categoryDate;
							}
							if(item.duration!=undefined && item.duration!=""&& item.duration!=null){
								  duration=item.duration;	
							}
							
							var nextCategoryDate="";
							if(item.nextCategoryDate!=undefined && item.nextCategoryDate!=null && item.nextCategoryDate!=""){
								 nextCategoryDate=item.nextCategoryDate;	
							}
							var patientMedicalCategoryId="";
							if(item.patientMedicalCategoryId!=undefined && item.patientMedicalCategoryId!=null && item.patientMedicalCategoryId!=""){
								patientMedicalCategoryId=item.patientMedicalCategoryId;
							}
							var diagnosisId="";
							if(item.diagnosisId!=undefined && item.diagnosisId!=null && item.diagnosisId!=""){
								diagnosisId=item.diagnosisId;
							}
							var medicalCategoryId="";
							if(item.medicalCategoryId!=undefined && item.medicalCategoryId!=null && item.medicalCategoryId!=""){
								medicalCategoryId=item.medicalCategoryId;
							}
							
							if(icdName!=""){
								msgOfICDDiagnosis=icdName;
							}
							if(medicalCategory!=""){
								msgOfMedicalCatName=medicalCategory;
							}
							
							if(system!=undefined && system!="")
								msgOfSystem=system;
							if(categoryType!=undefined && categoryType!=""){
							if(categoryType=='T'){
								msgOfTypeOfMedCat=" "+"T" ;
							}else{
								msgOfTypeOfMedCat=" "+"Pmt" ;
							}
					
							if(duration!="" && duration!=undefined){
								durationF=duration;
							}
							else{
								durationF="";
							}
							if(categoryDate!="" && categoryDate!=undefined){
								msgOfCatdate=categoryDate;
							}
							
							if(nextCategoryDate!=""){
								msgOfNextCategoryDate=nextCategoryDate;
							}
							var  msgOfFinalObservationValue=resourceJSON.msgOfFinalObservation;
							var updateMsgOfFinalObservationValue="";
							
							if(msgOfFinalObservationValue!="" ){
								updateMsgOfFinalObservationValue = msgOfFinalObservationValue.replace("<< Medical cat name>>", "<b>"+msgOfMedicalCatName+"</b>");
								updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<system>>", "<b>("+msgOfSystem+")</b>");
								updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<type of med cat>>", "<b>"+msgOfTypeOfMedCat+"</b>");
								updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<duration>>",  "<b>"+durationF+"</b>");
								updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<ICD Diagnosis>>", "<b>"+msgOfICDDiagnosis+"</b>");
								updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<cat date>>", "<b>"+msgOfCatdate+"</b>" );
								updateMsgOfFinalObservationValue = updateMsgOfFinalObservationValue.replace("<<Next category date>>", "<b>"+msgOfNextCategoryDate+"</b>" );
								finalObersationDetail+=	"<br>"+updateMsgOfFinalObservationValue;
							}
							
							}
							if(icdName!=undefined && icdName!="" )
							msgOfICDDiagnosis+=" "+icdName;
							if(categoryDate!=undefined && categoryDate!="")
							msgOfCatdate+=" "+categoryDate;
							if(nextCategoryDate!=undefined && nextCategoryDate!="")
								msgOfNextCategoryDate+=" "+nextCategoryDate;
							if(icdName!=null && icdName!=undefined)
							{
								
								trHTML+='<tr>';
								trHTML+=' <td>';
								func1='fillDiagnosisComboMedCat';
					    		 url1='opd';
					    		 url2='getIcdListByName';
					    		 flaga='diagnosisMe';
							
								trHTML+=' <div class="autocomplete forTableResp">';
								//trHTML+='<input type="text" class="form-control" '+approvalFlagDiasable+' name="diagnosisId" id="diagnosisId'+i+'" onblur="fillDiagnosisCombo(this.value,this);" onKeyPress="autoCompleteCommonMe(this,5);" onKeyUp="autoCompleteCommonMe(this,5);"placeholder="Diagnosis" value="'+icdName+'" />';
								trHTML+='<input type="text" class="form-control" '+approvalFlagDiasable+' name="diagnosisId" id="diagnosisId'+i+'"  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" placeholder="Diagnosis" value="'+icdName+'" />';
								trHTML+='<div id="diagnosisMeDiv'+i+'" class="autocomplete-itemsNew"></div>';
								trHTML+='</div>';
								trHTML+=' </td>	';
								
								func1='fillMedicalCategoryData';
					    		 url1='medicalBoard';
					    		 url2='getMedicalBoardAutocomplete';
					    		 flaga='compositeCategory';
							
								trHTML+='  <td>';
								trHTML+=' <div class="autocomplete forTableResp">';
								//trHTML+='<input type="text" id="medicalCategoryId" onblur="fillMedicalCategoryData(this.value,this);" '+approvalFlagDiasable+' value="'+medicalCategory+'" onKeyPress="autoCompleteCommonMe(this,6);"  onKeyUp="autoCompleteCommonMe(this,6);" class="form-control">';
								trHTML+='<input type="text" id="medicalCategoryId"   '+approvalFlagDiasable+' value="'+medicalCategory+'"onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"  class="form-control">';
								trHTML+='<input type="hidden" id="diagnosisiIdMC'+i+'" name="diagnosisiIdMC" value="'+diagnosisId+'"/>';
								trHTML+='<input type="hidden" id="medicalCategoryValueId'+i+'" name="medicalCategoryValueId" value="'+medicalCategoryId+'"/>';
								trHTML+='<input type="hidden" id="patientMedicalCatId'+i+'" name="patientMedicalCatId" value="'+patientMedicalCategoryId+'"/>';
								
								trHTML+='<input type="hidden" name="dateOfOrigin" id="dateOfOrigin'+i+'" class="form-control" value=""/>';
								trHTML+='<input type="hidden" name="placeOfOrigin" id="placeOfOrigin'+i+'" class="form-control" value=""/>';
								
								trHTML+='<div id="compositeCategoryForDetailDiv'+i+'" class="autocomplete-itemsNew"></div>';
								trHTML+='</div> ';
								trHTML+='</td>';
								var systemArrary = ["S","H","A","P","E"]; 
								trHTML+=' <td>';
								trHTML+='<select class="form-control" name=system id="system'+i+'" '+approvalFlagDiasable+'  onChange="return getMedicalCategoryFinalObserb(this);">';
								trHTML+='<option value="0">Select</option>';
								for(var j=0;j<systemArrary.length;j++){
									var systemSelectedVal="";
									if(systemArrary[j]==system){
										systemSelectedVal='selected';
									}
									else{
										systemSelectedVal="";
									}
									trHTML+='<option '+systemSelectedVal+' value='+systemArrary[j]+'>'+systemArrary[j]+'</option>';
								}
								trHTML+='</select>';
								trHTML+='</td>';
								
								
								
								trHTML+=' <td>';
								trHTML+='<select class="form-control" name=typeOfCategory id="typeOfCategory'+i+'" onchange="getdurationByType(this);  getMedicalCategoryFinalObserb(this);" '+approvalFlagDiasable+'>';
								
								trHTML+='<option value="0">Select</option>';
								if(categoryType!=null && categoryType!="" && categoryType!=undefined){
									var cateValue;
									var catetypeVal;
									for(var k=0;k<2;k++){
									var selectValue=""
									if(categoryType=='T'){
										selectValue='selected';
										cateValue='Temporary(Week)';
										catetypeVal='T';
										categoryType='';
										
									}
									else if(categoryType=='P'){
										selectValue='selected';
										cateValue='Permanent(Month)';
										catetypeVal='P';
										categoryType='';
									}
									else{
										var count=0;
										if(cateValue=='Temporary(Week)' && count=='0'){
											cateValue='Permanent(Month)';
											catetypeVal='P';
											count++;
										} 
										if(cateValue=='Permanent(Month)' && count=='0'){
											cateValue='Temporary(Week)';
											catetypeVal='T';
											count++;
										}
										selectValue='';
									}
									trHTML+='<option '+selectValue+' value='+catetypeVal+'>'+cateValue+'</option>';
								}
								}
								else{
									
									trHTML+='<option value="T">Temporary(Week)</option>';
									trHTML+='<option value="P">Permanent(Month)</option>';
								}	
								trHTML+='</select>';
								trHTML+='</td>';
								
								trHTML+='<td>';
								trHTML+='<input type="text" '+approvalFlagDiasable+' name="duration" id="duration'+i+'" value="'+duration+'" onblur="return generateNextDate(this);" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control"> </td>';
								trHTML+='</td>';
								
								trHTML+='<td>';
								trHTML+='<div class="dateHolder">';
								trHTML+=' <input type="text" '+approvalFlagDiasable+' id="categoryDate'+i+'" ';
								trHTML+=' name="categoryDate" class="noFuture_date5 form-control" ';
								trHTML+=' placeholder="DD/MM/YYYY" value="'+categoryDate+'" maxlength="10" />';
								trHTML+='  </div>';
								trHTML+='  </td>';
								
								trHTML+='<td>';
								trHTML+='   <div class="dateHolder">';
								trHTML+=' <input type="text" '+approvalFlagDiasable+' id="nextcategoryDate'+i+'" name="nextcategoryDate" class="form-control" placeholder="DD/MM/YYYY" value="'+nextCategoryDate+'" maxlength="10" readonly/>';
								trHTML+=' </div>';
								trHTML+='  </td>';
								
								trHTML+=' <td>';
								trHTML+='<button type="button" '+approvalFlagDiasable+' type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForMedicalCategory();"></button>';
								trHTML+=' </td>';
								trHTML+=' <td>';
								trHTML+=' <button type="button" name="delete" value="" id="deleteForDigi'+i+'"'+diasableValue+' class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1"  onclick="removeRowMedicalCategory(this)"></button>';
								trHTML+=' </td>';	
							i++;
							}
						}
						});
					}
					 
					if(trHTML!="" && trHTML!=null && countForSystem!=0){
						$("#medicalCategory tr").remove();
						$('#medicalCategory').append(trHTML);
					}
					 
					var saveInDraft=$('#saveInDraft').val();
					
					msgForFitIn+=finalObersationDetail;
					if(msgForFitIn!="" && msgForFitIn!=undefined)
					$('#finalObservationDigi').jqteVal(msgForFitIn);
				 	
					if(finalObservationOfMo!="" && finalObservationOfMo!=null){
						if(finalObservationOfMo!=null && !finalObservationOfMo.includes("FIT in")){
							finalObservationOfMo= "FIT in"+"<br>" + finalObservationOfMo ; 
				    	 }
						
						$('#finalObservationDigi').jqteVal(finalObservationOfMo);
					}
					if(finalObservationOfRMo!="" && finalObservationOfRMo!=null){
						if(finalObservationOfRMo!=null && !finalObservationOfRMo.includes("FIT in")){
							finalObservationOfRMo= "FIT in"+"<br>" + finalObservationOfRMo ; 
				    	 }
						$('#finalObservationDigi').jqteVal(finalObservationOfRMo);
					}
				 	if(finalObservationOfPRMo!="" && finalObservationOfPRMo!=null){
				 		 
				 		if(finalObservationOfPRMo!=null && !finalObservationOfPRMo.includes("FIT in")){
				 			finalObservationOfPRMo= "FIT in"+"<br>" + finalObservationOfPRMo ; 
				    	 }
				 		$('#finalObservationDigi').jqteVal(finalObservationOfPRMo);
					}
				 	
					   
					/*if(saveInDraft=='draftMo' || saveInDraft=='draftMo18'){
						msgForFitIn+=finalObersationDetail;
						$('#finalObservationMoJ').jqteVal(msgForFitIn);
					 	
						if(finalObservationOfMo!="" && finalObservationOfMo!=null){
						$('#finalObservationMoJ').jqteVal(finalObservationOfMo);
						}
					 
					}
					
					if(saveInDraft=='draftRMo' || saveInDraft=='draftRMo18'){
						msgForFitIn+=finalObersationDetail;
						$('#finalObservationRmoJ').jqteVal(msgForFitIn);
						
						if(finalObservationOfMo!="" && finalObservationOfMo!=null){
							$('#finalObservationMoJ').jqteVal(finalObservationOfMo);
						}
					 	if(finalObservationOfRMo!="" && finalObservationOfRMo!=null){
							$('#finalObservationRmoJ').jqteVal(finalObservationOfRMo);
						}
					 	
						}
					if(saveInDraft=='draftPRMo' || saveInDraft=='draftPRMo18'){
						msgForFitIn+=finalObersationDetail;
						$('#finalObservationPRmoJ').jqteVal(msgForFitIn);
						
						if(finalObservationOfMo!="" && finalObservationOfMo!=null){
							$('#finalObservationMoJ').jqteVal(finalObservationOfMo);
						}
					 	
						if(finalObservationOfRMo!="" && finalObservationOfRMo!=null){
							$('#finalObservationRmoJ').jqteVal(finalObservationOfRMo);
						}
					 	if(finalObservationOfPRMo!="" && finalObservationOfPRMo!=null){
					 		$('#finalObservationPRmoJ').jqteVal(finalObservationOfPRMo);
						}
					 	
						}*/
					}
	    });
		}
 
 
 function masMedicalCategoryListForDigi() {
	 	
     var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";

     var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/getMedicalBoardAutocomplete";
var countMedCat=0;
if (document.getElementById('fitInChk').checked == true) {
    	 var medicalCopositeName=$('#medicalCompositeName').val();
    	 
    	 $('#medicalCategory tr').each(function(i, el) {
 			var $tds = $(this).find('td')	

 			 var icdName = $tds.eq(0).find(":input").val();
 			 if(icdName!=""){
 				countMedCat=+1; 
 			 }
    	 });
    	 
    	 if(medicalCopositeName!="" || countMedCat>0){
    		 alert("Fit Category can not be checked as the patient is associated with medical category(s).");
    		 return false;
    	 }
    	 
     }
     
     if (document.getElementById('fitInChk').checked == true) {
     $.ajax({
         type: "POST",
         contentType: "application/json",
         url: url,
         data: JSON.stringify({
             'employeeId': '1'
         }),
         dataType: 'json',
         //timeout: 100000,

         success: function(res)

         {
            var mcDataList = res.masMedicalCategoryList;
        	var  msgForFit=resourceJSON.msgForFitIn;
         	if(mcData!=null && mcDataList.length!=0)
             for (var i = 0; i < mcDataList.length; i++) {
                 var mcId = mcDataList[i].medicalCategoryId;
                 var mcCode = mcDataList[i].medicalCategoryCode;
                 var mcName = mcDataList[i].medicalCategoryName;
                 var mcFitFlag = mcDataList[i].fitFlag;
                 
                if(mcFitFlag=='F'){
					var finalObservationForCategory='';
					if(mcName!=""){
					 
					finalObservationForCategory+=msgForFit+" "+" Med Cat " +mcName ;
					var finalObservationNew="";
					finalObservationNew=$('#finalObservationMoDigi').val();
					if(finalObservationNew=="" || finalObservationNew==null || finalObservationNew==undefined){
					$('#finalObservationDigi').jqteVal(finalObservationForCategory);
					$('#finalObservationMoDigi').val(finalObservationForCategory);
					}
					}
                }
                
             }
         },
         error: function(jqXHR, exception) {
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
     
     }
     else{
    	 $('#finalObservationDigi').jqteVal('');
    	 $('#finalObservationMoDigi').val('');
     }
     
 }
 
 function backToDigiList(){
	   window.location = "digiApproved";
}
 function closeWindowDigi(){
	 window.close();

} 
 
 function masMedicalCategoryListForMe() {
	 	
     var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";

     var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/getMedicalBoardAutocomplete";
var countMedCat=0;
if (document.getElementById('fitInChk').checked == true) {
    	 var medicalCopositeName=$('#medicalCompositeName').val();
    	 
    	 $('#medicalCategory tr').each(function(i, el) {
 			var $tds = $(this).find('td')	

 			 var icdName = $tds.eq(0).find(":input").val();
 			 if(icdName!=""){
 				countMedCat=+1; 
 			 }
    	 });
    	 
    	 if(medicalCopositeName!="" || countMedCat>0){
    		 alert("Fit Category can not be checked as the patient is associated with medical category(s).");
    		 return false;
    	 }
    	 
     }
     
     if (document.getElementById('fitInChk').checked == true) {
     $.ajax({
         type: "POST",
         contentType: "application/json",
         url: url,
         data: JSON.stringify({
             'employeeId': '1'
         }),
         dataType: 'json',
         //timeout: 100000,

         success: function(res)

         {
            var mcDataList = res.masMedicalCategoryList;
        	var  msgForFit=resourceJSON.msgForFitIn;
         	if(mcData!=null && mcDataList.length!=0)
             for (var i = 0; i < mcDataList.length; i++) {
                 var mcId = mcDataList[i].medicalCategoryId;
                 var mcCode = mcDataList[i].medicalCategoryCode;
                 var mcName = mcDataList[i].medicalCategoryName;
                 var mcFitFlag = mcDataList[i].fitFlag;
                 
                if(mcFitFlag=='F'){
					var finalObservationForCategory='';
					var saveInDraft=$('#saveInDraft').val();
					if(mcName!=""){
					 if(finalObservationForCategory!="" && !finalObservationForCategory.include("FIT In"))
						 finalObservationForCategory+= "FIT In" ;
					 if(finalObservationForCategory=="")
						 finalObservationForCategory+= "FIT In" ;
					 
					 if(saveInDraft=='draftMo18' ||  saveInDraft=='draftRMo18' || saveInDraft=='draftPRMo18'){
						 finalObservationForCategory= "FIT for release in " ;
					 }
					 
					 if(saveInDraft!='draftMo18' &&   saveInDraft!='draftRMo18' && !saveInDraft=='draftPRMo18'){
						 finalObservationForCategory+=  " Med Cat " +mcName ;
					 }
					 else{
						 finalObservationForCategory+=  " Medical Category " +mcName ;
					 }
					finalObersationDetail=finalObservationForCategory;
					msgForFitIn =finalObersationDetail;
					
			    	 if(saveInDraft=='draftMo' || saveInDraft=='draftMo18' || saveInDraft=='draftMo3A'){
			    		  
						$('#finalObservationMoJ').jqteVal(msgForFitIn);
					 	
						if(finalObservationOfMo!="" && finalObservationOfMo!=null){
						$('#finalObservationMoJ').jqteVal(finalObservationOfMo);
						}
					 
					}
			    	
					if(saveInDraft=='draftRMo' || saveInDraft=='draftRMo18' || saveInDraft=='draftRMo3A'){
						 
						$('#finalObservationRmoJ').jqteVal(msgForFitIn);
						
						if(finalObservationOfMo!="" && finalObservationOfMo!=null){
							$('#finalObservationMoJ').jqteVal(finalObservationOfMo);
						}
					 	if(finalObservationOfRMo!="" && finalObservationOfRMo!=null){
							$('#finalObservationRmoJ').jqteVal(finalObservationOfRMo);
						}
					 	
						}
					if(saveInDraft=='draftPRMo' || saveInDraft=='draftPRMo18' || saveInDraft=='draftPRMo3A'){
						
						$('#finalObservationPRmoJ').jqteVal(msgForFitIn);
						
						if(finalObservationOfMo!="" && finalObservationOfMo!=null){
							$('#finalObservationMoJ').jqteVal(finalObservationOfMo);
						}
					 	
						if(finalObservationOfRMo!="" && finalObservationOfRMo!=null){
							$('#finalObservationRmoJ').jqteVal(finalObservationOfRMo);
						}
					 	if(finalObservationOfPRMo!="" && finalObservationOfPRMo!=null){
					 		$('#finalObservationPRmoJ').jqteVal(finalObservationOfPRMo);
						}
					 	
						}
					
					}
                }
                
             }
         },
         error: function(jqXHR, exception) {
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
     
     }
     else{
    	 var saveInDraft=$('#saveInDraft').val();
    	 if(saveInDraft=='draftMo' || saveInDraft=='draftMo18' || saveInDraft=='draftMo3A'){
    		 msgForFitIn ="";
			$('#finalObservationMoJ').jqteVal(msgForFitIn);
		 	
			if(finalObservationOfMo!="" && finalObservationOfMo!=null){
			$('#finalObservationMoJ').jqteVal(finalObservationOfMo);
			}
		 
		}
    	
		if(saveInDraft=='draftRMo' || saveInDraft=='draftRMo18' || saveInDraft=='draftRMo3A'){
			msgForFitIn ="";
			$('#finalObservationRmoJ').jqteVal(msgForFitIn);
			
			if(finalObservationOfMo!="" && finalObservationOfMo!=null){
				$('#finalObservationMoJ').jqteVal(finalObservationOfMo);
			}
		 	if(finalObservationOfRMo!="" && finalObservationOfRMo!=null){
				$('#finalObservationRmoJ').jqteVal(finalObservationOfRMo);
			}
		 	
			}
		if(saveInDraft=='draftPRMo' || saveInDraft=='draftPRMo18' || saveInDraft=='draftPRMo3A'){
			msgForFitIn ="";
			$('#finalObservationPRmoJ').jqteVal(msgForFitIn);
			
			if(finalObservationOfMo!="" && finalObservationOfMo!=null){
				$('#finalObservationMoJ').jqteVal(finalObservationOfMo);
			}
		 	
			if(finalObservationOfRMo!="" && finalObservationOfRMo!=null){
				$('#finalObservationRmoJ').jqteVal(finalObservationOfRMo);
			}
		 	if(finalObservationOfPRMo!="" && finalObservationOfPRMo!=null){
		 		$('#finalObservationPRmoJ').jqteVal(finalObservationOfPRMo);
			}
		 	
			}
     }
     
 }
 
 
 
 
 
 
 function getSubInvestigationHtmlForDigi(investiongationId,item){
	 
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
		 var genderId=$('#gender').val();
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
		    				
							investigationData +='<td></td>';
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
								
								investigationData += '<input type="hidden"  name="dgResultDtIdValueSubInves" value="" id="dgOrderDtIdValueSubInves'+count+'"/>';
								investigationData += '<input type="hidden"  name="dgResultHdIdSubInves" value="" id="dgOrderHdIdSubInves'+count+'"/>';
													
							investigationData += '<div id="investigationDivMe" class="autocomplete-itemsNew"></div>';
							investigationData += '</div></td>';

							investigationData += '	<td>';
							investigationData += '	<input type="text" name="UOMSub" id="UOMSub'+count+'" value="'+uOMName+'" class="form-control" redonly  >';
							investigationData += '	</td>';
							
							
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
							investigationData += '	id="rangeSubInves'+count+'" class="form-control">';
							investigationData += '</td>';
							
							var deleteButtonFlag="";
							var ridcIdVal=0;
							investigationData += '<td></td>';
							investigationData += '<td></td>';
							investigationData += '<td></td>';
							/*investigationData += '<td><button name="Button" type="button"   class=" hideElement " '+approvalFlagDiasable+'   value="" onclick="addRowForInvestigationFunUpMe();"';
							investigationData += '	tabindex="1" > </button></td>';

							investigationData += '<td><button type="button" name="delete" value=""    id="deleteInves" '+approvalFlagDiasable+'';
							investigationData += ' class=" hideElement "';
							investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,\''
								+ ridcIdVal + '\');" ></button></td>';*/	
							investigationData += ' </tr> ';
							count+=1;
							 
		    			}
			    	$('#dgInvetigationGrid').append(investigationData);
			    	 
			    }
			    
			});
	 }

 
 
 
 function getAFMSF3BInvestigationForDigiFileUpload() {
	 var saveInDraft=$('#saveInDraft').val();
	 	var disableFlag="";
	 	if(saveInDraft=='ea'|| saveInDraft=='ej'){
	 		disableFlag='disabled';
	 	}
	 	else{
	 		disableFlag="";
	 	}
 	var investigationGridValue = "investigationGrid";
 	var investigationData="";
 	var visitId = $('#visitId').val();
 	var opdPatientDetailId=$('#opdPatientDetailId').val();
 	var patientId=$('#patientId').val();
 	var data = {
 		"visitId" : visitId,
 		"opdPatientDetailId":1,
 		"patientId":patientId,
 		"flagForModule":"me"
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
 					 
 					var data = res.listObject;
 					var  subListData = res.subInvestigationData; 
 					var count = 100;
 					var countins = 200;
 					var investigationfinalValue = "";
 					var diasableValue="disabled";
 					var diasableValueCheck=" ";
 					var checkedVal="";
 					var totalRidcUploadVal=0;
 					var countForSub=300;
 					if (data != null && data.length > 0) {
 						 func1='populateChargeCode';
 			    		   url1='medicalexam';
 			    		   url2='getInvestigationListUOM';
 			    		   flaga='investigationMe';
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
 							investigationData += '<div class="form-check form-check-inline cusCheck m-l-10">';
 							investigationData += ' 	<input   class="form-check-input position-static" type="checkbox" '+checkedVal+' '+diasableValueCheck+' name="checkBoxForUpload" id="checkBoxForUpload'+data[i].investigationId+'" onClick="return getInvestionCheckData(this);"><span class="cus-checkbtn"></span> ';
 							investigationData += '</div> ';
 							investigationData += ' </td> ';
							investigationData += '<td><div   class="autocomplete forTableResp">';
							investigationData += '<input type="text"  readonly value="'
									+ data[i].investigationName + '['
									+ data[i].investigationId
									+ ']" id="chargeCodeName' + count + '"';
							investigationData += ' class="form-control border-input" name="chargeCodeName"    onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
							investigationData += '<input type="hidden" id="qty" tabindex="1" name="qty1"  maxlength="6"/>';
							investigationData += '<input type="hidden" tabindex="1" id="chargeCodeCode'+count+'"';
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
							investigationData += 'id="investigationType'+count+'" />';
							
							
							
							investigationData += '<input type="hidden" name="subChargecodeIdForInv" value="'+subChargeCodeIdForInves+'"';
							investigationData += '	id="subChargecodeIdForInv'+count+'" />';
						
							
							investigationData += '<input type="hidden" name="mainChargecodeIdValForInv" value="'+mainChargeCodeIdForInves+'"';
							investigationData += '	id="mainChargecodeIdValForInv'+count+'" />';
				
							
						 	
							investigationData += '<div id="investigationDivMeDg'+count+'" class="autocomplete-itemsNew"></div>';	
							investigationData += ' </div></td>';
							
							investigationData += '	<td>';
							investigationData += '	<input type="text" name="UOM" id="UOM'+count+'" value="'+data[i].uomName+'" class="form-control"   readonly>';
							investigationData += '	</td>';
							
							if(data[i].mainChargeCodeNameForInve=='Lab'){
	 							
 								investigationData += '	<td>';
 								investigationData+='<input type="text" name="resultInvsTemp" id="resultInvsTemp'+data[i].investigationId+'" value="'+escapeHtml(data[i].result)+'"class="form-control" onBlur="setLabResultInFieldDigi(this);"'+readonlyOnlyForInvestigation+'>';
 								investigationData += '	<input type="hidden" name="resultInvs"   id="resultInvs'+data[i].investigationId+'" value="@@@###'+escapeHtml(data[i].result)+'" class="form-control" '+readonlyOnlyForInvestigation+' >';

 	 							investigationData += '	</td>';

 							}	
 							 
 							if(data[i].mainChargeCodeNameForInve=='Radio'){
 								investigationData += '	<td>';
 								investigationData+='<textarea name="resultInvs" id="resultInvs'+data[i].investigationId+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###'+escapeHtml(data[i].result)+'</textarea>';
 								investigationData+='<a class="btn-link" href="javascript:void(0)"  data-toggle="modal" data-target="#messageForResult" data-backdrop="static" onclick="openResultModel(this);">View/Enter Result</a>';
 								investigationData += '	</td>';
 							}
							
 							var rangeForInves="";	
  							
  							
  							if(data[i].rangeValue){
  								rangeForInves=data[i].rangeValue;
  							}
  							else{
 							if(data[i].minNormalValue!=null && data[i].minNormalValue!=undefined){
 								rangeForInves=data[i].minNormalValue;
 							}
 							if(data[i].maxNormalValue!=null && data[i].maxNormalValue!=undefined){
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
  	
 							
							investigationData += '<td>';
							investigationData += '<input type="text" name="range" id="range'+count+'" value="'+rangeForInves+'" class="form-control" '+readonlyOnlyForInvestigation+'>';
							investigationData += '	<input type="hidden" name="investigationResultDate" id="investigationResultDate'+data[i].investigationId+'" value="'+reultOfflineDate+'" class="form-control">';
							investigationData += '	<input type="hidden" name="resultNumber" id="resultNumber'+data[i].investigationId+'" value="'+reultOfflineNumber+'" class="form-control">';
							investigationData += '</td>';
							
						
 							if(ridcIdVal!=null && ridcIdVal!=0){	
 							investigationData += '	<td><a class="btn-link" href="JavaScript:Void(0);"  onclick="viewDocumentForDigi('+ridcIdVal+');" >View Document</a></td>'
 							totalRidcUploadVal++;
 							deleteButtonFlag='';
 							 
 							}
 							else{
 								investigationData += '	<td></td>';
 								deleteButtonFlag='disabled';
 								ridcIdVal=0;
 							}
							
							
							 
							investigationData += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth"   button-type="add" value=""  ';
							investigationData += 'onclick="addRowForInvestigationFunUpMeDigi();" ';
							investigationData += '	tabindex="1"  '+disableFlag+'> </button></td>';

							investigationData += '<td><button type="button" name="delete" value=""   button-type="delete" id="deleteInves'+count+'" ';
							investigationData += 'class="buttonDel btn btn-danger noMinWidth"';
							investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,\''
								+ ridcIdVal + '\');" '+deleteButtonFlag+'></button></td>';
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
										
											
											
											count=countForSub;
											var subInvestigationHtml=getSubInvestionByValuesForDigi(dgSubMasInvestigationId,subInvestigationName,subInvestigationCode,uOMName,investigationIdVal,investigationType,
													 rangeValSub,mainChargeCodeName,count,orderDtIdForSub,orderHdIdForSub,resultEntryDtidForSub,
													 resultEntryHdidForSub,mainChargeCodeIdForSub,subMainChargeCodeIdForSub,resultForSub,disableFlag,deleteButtonFlag);
											
											investigationData+=subInvestigationHtml;
											
										}
									
									}
								}
							}
							count++;
						}
 						$("#dgInvetigationGrid").html(investigationData);
 						$('#totalLengthDigiFile').val(totalRidcUploadVal);
 						$('#investigationDetailsIddd').hide();
 						$('#investigationTemplateGridIdddd').hide();
 						try{
 						$('#otherInvestigation').val(otherInvergation);
 						}
 						catch(e){}
 						}
 					
 					if(data.length==0){
 						$('#totalLengthDigiFile').val("0");
 						getInvestigationHtmlForDigi();
 						$('#investigationDetailsIddd').show();
 						$('#investigationTemplateGridIdddd').show();
 					}
 					
 					
 					
 				}
 			});

 	return false;
 }

 
 function getSubInvestionByValuesForDigi(dgSubMasInvestigationId,subInvestigationName,subInvestigationCode,uOMName,investigationIdVal,investigationType,
		 rangeValSub,mainChargeCodeName,count,orderDtIdForSub,orderHdIdForSub,resultEntryDtidForSub,resultEntryHdidForSub,mainChargeCodeIdForSub,subMainChargeCodeIdForSub,resultForSub,disableFlag,deleteButtonFlag){
	 func1='populateChargeCode';
	    url1='medicalexam';
	   url2='getInvestigationListUOM';
	   flaga='investigationMeDg';
		 
		var investigationData = '<tr data-id="'+investigationIdVal+'">';
		investigationData +='<td style="width: 150px;"></td>';
		investigationData += '<td><div class="form-group autocomplete forTableResp">';
		investigationData += '<input type="text" readonly autocomplete="never" value="'+subInvestigationName + '[' + dgSubMasInvestigationId + ']"';
		
		investigationData += ' class="form-control border-input" name="subInvestigationName" id="subInvestigationName'+count+'"  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
		investigationData += '<input type="hidden"  name="subInvestigationNameIdAndInv" value="'
				+ dgSubMasInvestigationId +"@@"+investigationIdVal+'"  id="subInvestigationNameIdAndInv' + dgSubMasInvestigationId + '"/>';
		
		investigationData += '<input type="hidden"  name="investigationSubType" value="'
			+ investigationType +'"  id="investigationSubType' +investigationType+ '"/>';

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
				investigationData+='<input type="text" name="resultInvsTemp" id="resultInvsTemp'+dgSubMasInvestigationId+'" value="'+escapeHtml(resultForSub)+'"class="form-control" onBlur="setLabResultInFieldDigi(this);">';
					investigationData += '	<input type="hidden" name="resultSubInv"  id="resultSubInv'+dgSubMasInvestigationId+'" value="@@@###'+escapeHtml(resultForSub)+'" class="form-control" >';
					investigationData += '	</td>';

			}	
			
			if(mainChargeCodeName=='Radio'){
				investigationData += '	<td>';
				investigationData+='<textarea name="resultSubInvs" id="resultSubInvs'+dgSubMasInvestigationId+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###'+escapeHtml(resultForSub)+'</textarea>';
				investigationData+='<a class="btn-link" href="javascript:void(0)"  data-toggle="modal" data-target="#messageForResult" data-backdrop="static" onclick="openResultModel(this);">View/Enter Result</a>';
				investigationData += '	</td>';
			}

		
		
		investigationData += '<td><input type="text" name="rangeSubInves" value="'+rangeValSub+'"';
		investigationData += 'id="rangeSubInves'+count+'" class="form-control"></td>';
		 
		investigationData += '	<td></td>';
		 
		var ridcIdVal=0;
		investigationData += '	<td></td>';
		investigationData += '	<td></td>';
		/*investigationData += '<td><button name="Button" type="button"   class=" "     value="" onclick="addRowForInvestigationFunUpMeDigi();" '+disableFlag+'';
		investigationData += '	tabindex="1" > </button></td>';

		investigationData += '<td><button type="button" name="delete" value=""    id="deleteInves"  '+deleteButtonFlag+'';
		investigationData += ' class=" "';
		investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,\''
				+ ridcIdVal + '\');" ></button></td>';
*/		investigationData += ' </tr> ';
		count+=1;
	 return investigationData;
 }
 
 function getSubInvestigationHtmlForMe(investiongationId,item){
	 
	 
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
		 if(genderId==""||genderId==undefined){
			 genderId= $('#genderId').val();
		 }
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
			    	var newIdVal=220;
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
		    				 var resultForSub="";
							investigationData +='<td></td>';
							investigationData += '<td><div class="form-group autocomplete forTableResp">';
							investigationData += '<input type="text" readonly autocomplete="never" value="'+subInvestigationName + '[' + dgSubMasInvestigationId + ']"';
							
							investigationData += ' class="form-control border-input" name="subInvestigationName" id="subInvestigationName'+count+'"  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
							investigationData += '<input type="hidden"  name="subInvestigationNameIdAndInv" value="'
									+ dgSubMasInvestigationId +"@@"+investigationIdVal+'"  id="subInvestigationNameIdAndInv' + dgSubMasInvestigationId + '"/>';
							
							investigationData += '<input type="hidden"  name="investigationSubType" value="'
								+ investigationType +'"  id="investigationSubType' +investigationType+ '"/>';
							 investigationData += '<input type="hidden"  name="subInvestigationNameIdTemp" value="'+dgSubMasInvestigationId+'"  id="subInvestigationNameIdTemp'+count+'"/>';
							investigationData += '<input type="hidden"  name="dgOrderDtIdValueSubInves" value="" id="dgOrderDtIdValueSubInves"/>';
							investigationData += '<input type="hidden"  name="dgOrderHdIdSubInves" value="" id="dgOrderHdIdSubInves"/>';
							
								investigationData += '<input type="hidden" name="subChargecodeIdForSub" value="'+subChargeCodeIdd+'"';
								investigationData += '	id="subChargecodeIdForSub'+count+'" />';
								
									
								investigationData += '<input type="hidden" name="mainChargecodeIdValForSub" value="'+mainChargeCodeIdd+'"';
								investigationData += '	id="mainChargecodeIdValForSub'+count+'" />';
								
								investigationData += '<input type="hidden"  name="dgResultDtIdValueSubInves" value="" id="dgOrderDtIdValueSubInves'+count+'"/>';
								investigationData += '<input type="hidden"  name="dgResultHdIdSubInves" value="" id="dgOrderHdIdSubInves'+count+'"/>';
													
							investigationData += '<div id="investigationDivMe" class="autocomplete-itemsNew"></div>';
							investigationData += '</div></td>';

							investigationData += '	<td>';
							investigationData += '	<input type="text" name="UOMSub" id="UOMSub'+count+'" value="'+uOMName+'" class="form-control" redonly  >';
							investigationData += '	</td>';
							
							   
							if(mainChargeCodeName=='Lab'){
								 newIdVal=parseInt(newIdVal)+parseInt(count)+parseInt(dgSubMasInvestigationId);
									investigationData += '	<td>';
									investigationData+='<input type="text" name="resultInvsTemp" id="resultInvsTemp'+newIdVal+'" value="'+escapeHtml(resultForSub)+'"class="form-control" onBlur="setLabResultInFieldMe(this);">';
									investigationData += '	<input type="hidden" name="resultSubInv"  id="resultSubInv'+newIdVal+'" value="@@@###'+escapeHtml(resultForSub)+'" class="form-control" >';
								
									investigationData += '	</td>';

								}	
								
								if(mainChargeCodeName=='Radio'){
									 newIdVal=parseInt(newIdVal)+parseInt(count)+parseInt(dgSubMasInvestigationId);
									investigationData += '	<td>';
									investigationData+='<textarea name="resultSubInvs" id="resultSubInvs'+newIdVal+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###'+escapeHtml(resultForSub)+'</textarea>';
									investigationData+='<a class="btn-link" href="javascript:void(0)"  data-toggle="modal" data-target="#messageForResult" data-backdrop="static" onclick="openResultModel(this);">View/Enter Result</a>';
									investigationData += '	</td>';
								}

							
							
							investigationData += '<td><input type="text" name="rangeSubInves" value="'+rangeValSub+'"';
							investigationData += '	id="rangeSubInves'+count+'" class="form-control"></td>';
							
							var deleteButtonFlag="";
							var ridcIdVal=0;
							
							investigationData += '<td> ';
							investigationData += '	<textarea class="form-control"  name="investigationRemarksForSub" id="investigationRemarksForSub'+count+'" rows="2" maxlength="500"></textarea>';
							investigationData += '</td>';

							investigationData += '<td></td>';
							
							investigationData += '<td><button name="Button" type="button"   class="hideElement" '+approvalFlagDiasable+'   value="" onclick="addRowForInvestigationFunUpMe();"';
							investigationData += '	tabindex="1" > </button></td>';

							investigationData += '<td><button type="button" name="delete" value=""    id="deleteInves" '+approvalFlagDiasable+'';
							investigationData += ' class="hideElement"';
							investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,\''+ ridcIdVal + '\');" ></button></td>';
							investigationData += ' </tr> ';
							count+=1;
							newIdVal++;
		    			}
			    	$('#dgInvetigationGrid').append(investigationData);
			    	 
			    }
			    
			});
	 }


 
 
 
 

 function getAFMSF3BInvestigationForMOOrMA() {
 	
 	 var approvalFlag=$('#approvalFlag').val();
 	var draftRMo=$('#saveInDraft').val();
 	 var approvalFlagDiasable="";
 	 var disableAddButton="";
 	 if((approvalFlag!="" && approvalFlag!=undefined && approvalFlag!=null && approvalFlag=='y') || (draftRMo=='draftRMo' || draftRMo=='draftPRMo')
 			 ||(draftRMo=='draftRMo18' || draftRMo=='draftPRMo18')||(draftRMo=='draftRMo3A' || draftRMo=='draftPRMo3A')){
 		 approvalFlagDiasable='readonly';
 		disableAddButton='disabled';
 	 }
 	 else{
 		 approvalFlagDiasable="";
 		disableAddButton='';
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
 	var opdPatientDetailId=$('#opdPatientDetailId').val();
 	var patientId=$('#patientId').val();
 	var totalRidcUploadVal=0;
 	var newIdVal=101;
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
								if(approvalFlagDiasable!=""){
									readonlyOnlyForInvestigation="readonly";
								}
								else{
								readonlyOnlyForInvestigation="";
								}
								}
					
 					
 							
 							investigationData += '<tr>';
 					
 							
 							var ridcIdVal=0;
							if (subListData != null && subListData.length > 0) {
								for (var j = 0; j < subListData.length; j++) {
										if(data[i].investigationId==subListData[j].investigationIdSub && data[i].orderHdId == subListData[j].orderHdIdForSub){
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
 							investigationData += ' class="form-control border-input" name="chargeCodeName" autocomplete="off"   onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" '+approvalFlagDiasable+'/>';
 							
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
 	 							  newIdVal=parseInt(newIdVal)+parseInt(count)+parseInt(data[i].investigationId);
  								investigationData += '	<td>';
  	 							//investigationData += '	<input type="text" name="resultInvs" '+approvalFlagDiasable+' id="resultInvs'+count+'" value="'+data[i].result+'" class="form-control" '+readonlyOnlyForInvestigation+' >';
  								investigationData+='<input type="text" name="resultInvsTemp" '+approvalFlagDiasable+' id="resultInvsTemp'+newIdVal+'" value="'+escapeHtml(data[i].result)+'" class="form-control"  onBlur="setLabResultInFieldMe(this);" '+readonlyOnlyForInvestigation+'  >';
 								investigationData += '	<input type="hidden" name="resultInvs" id="resultInvs'+newIdVal+'" value="@@@###'+escapeHtml(data[i].result)+'" class="form-control">';
  								investigationData += '	</td>';

  							}	
  							
  							if(data[i].mainChargeCodeNameForInve=='Radio'){
  								 newIdVal=parseInt(newIdVal)+parseInt(count)+parseInt(data[i].investigationId);
  								investigationData += '	<td>';
  								investigationData+='<textarea name="resultInvs" id="resultInvs'+newIdVal+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;" '+approvalFlagDiasable+'>@@@###'+escapeHtml(data[i].result)+'</textarea>';
  								investigationData+='<a class="btn-link" href="javascript:void(0)"  data-toggle="modal" data-target="#messageForResult" data-backdrop="static" onclick="openResultModel(this);">View/Enter Result</a>';
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
  							
  							if(readonlyOnlyForInvestigation=="" &&  approvalFlag=='y'){
  								readonlyOnlyForInvestigation='readonly';
  							}
  							 
  							
  							var reultOfflineDate="";
  							if(data[i].resultOffLineDate!="")
  								reultOfflineDate=data[i].resultOffLineDate;
  							
 							investigationData += '<td><input type="text" name="range" value="'+rangeForInves+'" id="range'+data[i].investigationId+'" class="form-control" '+readonlyOnlyForInvestigation+'/>';
 							
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
 							investigationData += '	<td>';
 							investigationData += '	<textarea class="form-control"  name="investigationRemarks" id="investigationRemarks'+count+'" rows="2" maxlength="500" '+readonlyOnlyForInvestigation+'>'+investigationRemarks+'</textarea>';
 							investigationData += '	 </td>';
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
 							
 							
 							
 							investigationData += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth"  button-type="add" value=""';
 							investigationData += ' '+disableAddButton+' onclick="addRowForInvestigationFunUpMe();"';
 							investigationData += '	tabindex="1" > </button></td>';

 							investigationData += '<td><button type="button" name="delete" value=""  button-type="delete" id="deleteInves" '+diasableValue+'';
 							investigationData += ' class="buttonDel btn btn-danger noMinWidth"';
 							investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,\''
 									+ ridcIdVal + '\');" ></button></td>';
 							investigationData += ' </tr> ';
 							

							if(data[i].investigationType!="" && data[i].investigationType=='m'){
								var duplicateData="";
							if (subListData != null && subListData.length > 0) {
								
								
								for (var j = 0; j < subListData.length; j++) {
									
									countForSub++;
										if(data[i].investigationId==subListData[j].investigationIdSub && data[i].orderHdId == subListData[j].orderHdIdForSub){
											newIdVal=parseInt(newIdVal)+400;
											duplicateData+=subListData[j].subInvestigationId;
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
										
											
											
											var subInvestigationHtml=getSubInvestionByValuesForMe(dgSubMasInvestigationId,subInvestigationName,subInvestigationCode,uOMName,investigationIdVal,investigationType,
													 rangeValSub,mainChargeCodeName,count,orderDtIdForSub,orderHdIdForSub,resultEntryDtidForSub,
													 resultEntryHdidForSub,mainChargeCodeIdForSub,subMainChargeCodeIdForSub,resultForSub,diasableValue,approvalFlagDiasable,investigationRemarksForSub,newIdVal);
											
											investigationData+=subInvestigationHtml;
											
										}
									
									}
								}
							}
 							
							newIdVal++;
 							count++;
 						}
 						$('#otherInvestigation').val(otherInvergation);
 						$("#dgInvetigationGrid").html(investigationData);
 						$('#totalLengthDigiFile').val(totalRidcUploadVal);
 						
 					}
 					if(data.length==0){
  						$('#totalLengthDigiFile').val("0");
  						getInvestigationHtmlForDigiMe();
  					}
 				}
 			});

 			return false;
 }

 
 function getSubInvestionByValuesForMe(dgSubMasInvestigationId,subInvestigationName,subInvestigationCode,uOMName,investigationIdVal,investigationType,
		 rangeValSub,mainChargeCodeName,count,orderDtIdForSub,orderHdIdForSub,resultEntryDtidForSub,resultEntryHdidForSub,mainChargeCodeIdForSub,subMainChargeCodeIdForSub,resultForSub,
		 disableFlag,deleteButtonFlag,investigationRemarksForSub,newIdVal){
	 func1='populateChargeCode';
	    url1='medicalexam';
	   url2='getInvestigationListUOM';
	   flaga='investigationMeDg';
		 
		var investigationData = '<tr data-id="'+investigationIdVal+'">';
		investigationData +='<td></td>';
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
 
		investigationData += '<input type="hidden" name="subChargecodeIdForSub" value="'+subMainChargeCodeIdForSub+'"';
		investigationData += '	id="subChargecodeIdForSub'+count+'" />';
		
			
		investigationData += '<input type="hidden" name="mainChargecodeIdValForSub" value="'+mainChargeCodeIdForSub+'"';
		investigationData += '	id="mainChargecodeIdValForSub'+count+'" />';
		
		investigationData += '<input type="hidden"  name="dgResultDtIdValueSubInves" value="'+resultEntryDtidForSub+'" id="dgOrderDtIdValueSubInves'+count+'"/>';
		investigationData += '<input type="hidden"  name="dgResultHdIdSubInves" value="'+resultEntryHdidForSub+'" id="dgOrderHdIdSubInves'+count+'"/>';
	
		
		
		investigationData += '<div id="investigationDivMe" class="autocomplete-itemsNew"></div>';
		investigationData += '</div></td>';

		investigationData += '	<td>';
		investigationData += '	<input type="text" name="UOMSub" id="UOMSub'+count+'" value="'+uOMName+'" class="form-control" '+deleteButtonFlag+'  >';
		investigationData += '	</td>';
		
		
		 
		if(mainChargeCodeName=='Lab'){
			newIdVal=parseInt(count)+parseInt(dgSubMasInvestigationId);
				investigationData += '	<td>';
					//investigationData += '	<input type="text" name="resultSubInv"  id="resultSubInv'+count+'" value="'+resultForSub+'" class="form-control" >';
				 
				investigationData+='<input type="text" name="resultInvsTemp" id="resultInvsTemp'+newIdVal+'" value="'+escapeHtml(resultForSub)+'"class="form-control" onBlur="setLabResultInFieldDigi(this);" '+deleteButtonFlag+'> ';
				investigationData += '	<input type="hidden" name="resultSubInv"  id="resultSubInv'+newIdVal+'" value="@@@###'+escapeHtml(resultForSub)+'" class="form-control" >';
		
				investigationData += '	</td>';

			}	
			
			if(mainChargeCodeName=='Radio'){
				newIdVal=parseInt(count)+parseInt(dgSubMasInvestigationId);
				investigationData += '	<td>';
				investigationData+='<textarea name="resultSubInvs" id="resultSubInvs'+newIdVal+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;" '+deleteButtonFlag+'>@@@###'+escapeHtml(resultForSub)+'</textarea>';
				investigationData+='<a class="btn-link" href="javascript:void(0)"  data-toggle="modal" data-target="#messageForResult" data-backdrop="static" onclick="openResultModel(this);" '+deleteButtonFlag+' >View/Enter Result</a>';
				investigationData += '	</td>';
			}

		
		
		investigationData += '<td><input type="text" name="rangeSubInves" value="'+rangeValSub+'"';
		investigationData += 'id="rangeSubInves'+count+'" class="form-control" '+deleteButtonFlag+'>';
		investigationData += '</td>';
		 

			investigationData += '	<td>';
			investigationData += '	<textarea class="form-control"  name="investigationRemarksForSub" id="investigationRemarksForSub'+count+'" rows="2" maxlength="500" '+deleteButtonFlag+'>'+investigationRemarksForSub+'</textarea>';
			investigationData += '	 </td>';
		
		
		
		investigationData += '	<td></td>';
		 
		var ridcIdVal=0;
		investigationData += '<td><button name="Button" type="button"   class="hideElement"     value="" onclick="addRowForInvestigationFunUpMe();" '+disableFlag+'';
		investigationData += '	tabindex="1" > </button></td>';

		investigationData += '<td><button type="button" name="delete" value=""    id="deleteInves"  '+deleteButtonFlag+'';
		investigationData += ' class="hideElement"';
		investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,\''
				+ ridcIdVal + '\');" ></button></td>';
		investigationData += ' </tr> ';
		count+=1;
	 return investigationData;
 }

 
 
 function saveSpecialistOpinionInTextMe(){
		
	 
	 var idOfResult=$('#resultIdSpecialistOpinion').val();
	 var jqetResultValue=$('#editorOfSpecialistOpinion').val();
	
	 if(jqetResultValue!=""){
		 jqetResultValue=jqetResultValue.trim();
		 jqetResultValue="@@@###"+jqetResultValue;
	 }
	 
	 $('#'+idOfResult).val(jqetResultValue);
	 $('#messageForResultSpeccilaist').hide();
	 $('.modal').hide();
		$('.modal-backdrop ').hide();
}
 
 
 var escapeMatchedMap = {
			'&': '&amp;',
			  '<': '&lt;',
			  '>': '&gt;',
			  '"': '&quot;',
			  "'": '&#39;',
			  '/': '&#x2F;',
			  '`': '&#x60;',
			  '=': '&#x3D;'
			};

	/*sanitise the cross site script*/
	function escapeHtml(inputString) {
	  return String(inputString).replace(/[&<>"'`=\/]/g, function (s) {
	    return escapeMatchedMap[s];
	  });
	}

	 
	
	function deleteInvestigatRow(flag, valueForDelete, visitId, opdPatientDetailId,
			patientId) {
		var data = {
			"valueForDelete" : valueForDelete,
			"flag" : flag,
			"visitId" : visitId,
			"opdPatientDetailId" : opdPatientDetailId,
			"patientId" : patientId
		};
		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		var urldeleteGridRow = window.location.protocol + "//"+ window.location.host + "/" + accessGroup+ "/opd/deleteGridRow";

		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : urldeleteGridRow,
			data : JSON.stringify(data),
			dataType : "json",
			cache : false,
			success : function(res) {
				if (flag == "3") {
					getPatientReferalDetail();
				}
				if (flag == "5") {
					getPocedureDetailData();
				}
				
				if(flag=='Im1005'){
					getImmunisationHistoryDigi();
				}
				return "2";
			}
		});

		 
	}
	
 
	
	function getAFMSF3BForMOOrMAFor3ADigi() {
		var visitId = $('#visitId').val();
		var age = $('#ageForPatient').val();
		var userId=$('#userId').val();
		var patientId=$('#patientId').val();
		var pathname = window.location.pathname;
	     var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/medicalexam/getAFMSF3BForMOOrMA";
		
		var data = {
				"visitId" : visitId,
				"flagForForm" :"f3",
				"age":age,
				"userId":userId,
				"patientId":patientId
			};
			$.ajax({

				type : "POST",
				contentType : "application/json",
				url : url,
				data : JSON.stringify(data),
				dataType : "json",
				// cache: false,

				success : function(res) {
					 data = res.listOfResponse;
					 var listMasServiceType = res.listMasServiceType;	
					 var serviceType = "";
					 if (data != undefined && data != null && data!="") {
						 if(data[0].totalNoOfTeath!="" && data[0].totalNoOfTeath!=undefined && data[0].totalNoOfTeath!=null)
							$('#totalNoOfTeath').val(data[0].totalNoOfTeath);
						 if(data[0].totalNoOfDefective!="" && data[0].totalNoOfDefective!=undefined && data[0].totalNoOfDefective!=null)
							$('#totalNoOfDefective').val(data[0].totalNoOfDefective);
						 if(data[0].totalNoOfDentalPoints!="" && data[0].totalNoOfDentalPoints!=undefined && data[0].totalNoOfDentalPoints!=null)
							$('#totalNoOfDentalPoints').val(data[0].totalNoOfDentalPoints);
							if(data[0].missing!="" && data[0].missing!=undefined && data[0].missing!=null)
							$('#missing').val(data[0].missing);
							 if(data[0].unSavable!="" && data[0].unSavable!=undefined && data[0].unSavable!=null)
							$('#unSavable').val(data[0].unSavable);
							if(data[0].conditionOfGums!="" && data[0].conditionOfGums!=undefined && data[0].conditionOfGums!=null)
							$('#conditionOfGums').val(data[0].conditionOfGums);
							
							var glopbalVarForAll;
							 var missingTeethUr=data[0].missingTeethUr;
							 if(missingTeethUr!="" && missingTeethUr!=null){
								 glopbalVarForAll=missingTeethUr.split(",");
								 checkForTeeth("urMChecked",glopbalVarForAll);
							 }
							 
							 var missingTeethUl=data[0].missingTeethUl;
							 if(missingTeethUl!="" && missingTeethUl!=null){
								 glopbalVarForAll=missingTeethUl.split(",");
								 checkForTeeth("ulMChecked",glopbalVarForAll);
							 }
							 var missingTeethLL=data[0].missingTeethLL;
							 
							 if(missingTeethLL!="" && missingTeethLL!=null){
								 glopbalVarForAll=missingTeethLL.split(",");
								 checkForTeeth("llMChecked",glopbalVarForAll);
							 }
							 
							 var missingTeethLR=data[0].missingTeethLR;
							 
							 if(missingTeethLR!="" && missingTeethLR!=null){
								 glopbalVarForAll=missingTeethLR.split(",");
								 checkForTeeth("lrMChecked",glopbalVarForAll);
							 }
							 
							 var unsavableTeethUr=data[0].unsavableTeethUr;
							 if(unsavableTeethUr!="" && unsavableTeethUr!=null){
								 glopbalVarForAll=unsavableTeethUr.split(",");
								 checkForTeeth("unurChecked",glopbalVarForAll);
							 }
							 var unsavableTeethUl=data[0].unsavableTeethUl;
							 if(unsavableTeethUl!="" && unsavableTeethUl!=null){
								 glopbalVarForAll=unsavableTeethUl.split(",");
								 checkForTeeth("unulChecked",glopbalVarForAll);
							 }
							 
							 var unsavableTeethLl=data[0].unsavableTeethLl;
							 if(unsavableTeethLl!="" && unsavableTeethLl!=null){
								 glopbalVarForAll=unsavableTeethLl.split(",");
								 checkForTeeth("unllChecked",glopbalVarForAll);
							 }
							 
							 var unsavableTeethLr=data[0].unsavableTeethLr;
							 if(unsavableTeethLr!="" && unsavableTeethLr!=null){
								 glopbalVarForAll=unsavableTeethLr.split(",");
								 checkForTeeth("unlrChecked",glopbalVarForAll);
							 }
							 if(data[0].dentalOffier!="" && data[0].dentalOffier!=undefined && data[0].dentalOffier!=null)
							 $('#dentalOffier').val(data[0].dentalOffier);
							 
							 if(data[0].remarks!="" && data[0].remarks!=undefined && data[0].remarks!=null)
							 $('#remarks').val(data[0].remarks);
							 if(data[0].remarkAdvice!="" && data[0].remarkAdvice!=undefined && data[0].remarkAdvice!=null)
							 $('#remarkAdvice').val(data[0].remarkAdvice);
							 
							 var pcHeight=data[0].pcHeight;
							 if(pcHeight!="" && pcHeight!=undefined && pcHeight!=null)
							 $('#height').val(pcHeight);
							 
							 var pcWeight=data[0].pcWeight;
							 if(pcWeight!="" && pcWeight!=undefined && pcWeight!=null)
							 $('#weight').val(pcWeight);
							 
							 var pcIdealWeight=data[0].pcIdealWeight;
							 if(pcIdealWeight!="" && pcIdealWeight!=undefined && pcIdealWeight!=null)
							 $('#idealWeight').val(pcIdealWeight);
							 
							 var pcOverWeight=data[0].pcOverWeight;
							 if(pcOverWeight!="" && pcOverWeight!=undefined && pcOverWeight!=null)
							 $('#overWeight').val(pcOverWeight);
							 
							 var pcBmi=data[0].pcBmi;
							 if(pcBmi!="" && pcBmi!=undefined && pcBmi!=null)
							 $('#bmi').val(pcBmi);
							 
							 var pcBodyFat=data[0].pcBodyFat;
							 if(pcBodyFat!="" && pcBodyFat!=undefined && pcBodyFat!=null)
							 $('#bodyFat').val(pcBodyFat);
							 
							 var pcWaist=data[0].pcWaist;
							 if(pcWaist!="" && pcWaist!=undefined && pcWaist!=null)
							 $('#waist').val(pcWaist);
							 var pcSkinFoldExpansion=data[0].pcSkinFoldExpansion;
							 if(pcSkinFoldExpansion!="" && pcSkinFoldExpansion!=undefined && pcSkinFoldExpansion!=null)
							 $('#skinFoldExpansion').val(pcSkinFoldExpansion);
							 
							 var pcChestFullExpansion=data[0].pcChestFullExpansion;
							 if(pcChestFullExpansion!="" && pcChestFullExpansion!=undefined && pcChestFullExpansion!=null)
							 $('#chestFullExpansion').val(pcChestFullExpansion);
							 
							 var pcRangeOfExpansion=data[0].pcRangeOfExpansion;
							 if(pcRangeOfExpansion!="" && pcRangeOfExpansion!=undefined && pcRangeOfExpansion!=null)
							 $('#rangeOfExpansion').val(pcRangeOfExpansion);
							 
							 var pcSportsman=data[0].pcSportsman;
							 setSelectedValue("sportsman",pcSportsman);
							  //Vision start
								
								 var distantWithoutGlasses=data[0].distantWithoutGlasses;
								 setSelectedValue("distantWithoutGlasses",distantWithoutGlasses);
							 
								 var distantWithoutGlassesL=data[0].distantWithoutGlassesL;
								 setSelectedValue("distantWithoutGlassesL",distantWithoutGlassesL);	
								 
								 var nearWithoutGlasses=data[0].nearWithoutGlasses;
								 setSelectedValue("nearWithoutGlasses",nearWithoutGlasses);
								 
								 var nearWithoutGlassesL=data[0].nearWithoutGlassesL;
								 setSelectedValue("nearWithoutGlassesL",nearWithoutGlassesL);
								
								 
								 var cpWithoutGlasses=data[0].cpWithoutGlasses;
								 setSelectedValue("cpWithoutGlasses",cpWithoutGlasses);
							 
								 
								 var distantWithGlasses=data[0].distantWithGlasses;
								 setSelectedValue("distantWithGlasses",distantWithGlasses);
								 
								 var distantWithGlassesL=data[0].distantWithGlassesL;
								 setSelectedValue("distantWithGlassesL",distantWithGlassesL);
								 
								 
								 var nearWithGlasses=data[0].nearWithGlasses;
								 setSelectedValue("nearWithGlasses",nearWithGlasses);
							
								 
								 var nearWithGlassesL=data[0].nearWithGlassesL;
								 setSelectedValue("nearWithGlassesL",nearWithGlassesL);
								 
							//Hearing
							 var fwR=data[0].fwR;
							 if(fwR!="" && fwR!=undefined && fwR!=null)
							 $('#fwR').val(fwR);
							 
							 var fwL=data[0].fwL;
							 if(fwL!="" && fwL!=undefined && fwL!=null)
							 $('#fwL').val(fwL);
							 
							 var fwBoth=data[0].fwBoth;
							 if(fwBoth!="" && fwBoth!=undefined && fwBoth!=null)
							 $('#fwBoth').val(fwBoth);
							 
							 var cvR=data[0].cvR;
							 if(cvR!="" && cvR!=undefined && cvR!=null)
							 $('#cvR').val(cvR);
							 
							 var cvL=data[0].cvL;
							 if(cvL!="" && cvL!=undefined && cvL!=null)
							 $('#cvL').val(cvL);
							 
							 var cvBoth=data[0].cvBoth;
							 if(cvBoth!="" && cvBoth!=undefined && cvBoth!=null)
							 $('#cvBoth').val(cvBoth);
							 
							 var tmR=data[0].tmR;
							 setSelectedValue("tmR",tmR);
							 
							 var tmL=data[0].tmL;
							 setSelectedValue("tmL",tmL);
							 
							/* var mobilityR=data[0].mobilityR;
							 setSelectedValue("mobilityR",mobilityR);
							 
							 var mobilityL=data[0].mobilityL;
							 setSelectedValue("mobilityL",mobilityL);
							
							 var noiseThroatSinuses=data[0].noiseThroatSinuses;
							 $('#noseThroatSinuses').val(noiseThroatSinuses);
							  */
							 var audiometryRecord=data[0].audiometryRecord;
							 
							 setSelectedValue("audiometryRecord",audiometryRecord);
							 if(audiometryRecord!=null && audiometryRecord=='Others'){
							 var audiometryRecordOthers=data[0].audiometryRecordForOther;
							 $('#audiometryRecordForOther').val(audiometryRecordOthers);
							 $('#audiometryRecordForDisplay').show();
							 }
							 else{
								 $('#audiometryRecordForDisplay').hide();
							 }
							 var clinicalNotes=data[0].clinicalNotes;
							 $('#clinicalNotes').val(clinicalNotes);
							 
							 var pluse=data[0].pluse;
							 $('#pulse').val(pluse);
							 
							 var bp=data[0].bp;
							 $('#bp').val(bp);
							 
							 var bp1=data[0].bp1;
							 $('#bp1').val(bp1);
							 
							 var heartSize=data[0].heartSize;
							 $('#heartSize').val(heartSize);
							 
							 var sounds=data[0].sounds;
							 $('#sounds').val(sounds);
							 
							 var rhythm=data[0].rhythm;
							 $('#rhythm').val(rhythm);
							 
							 var respiratorySystem=data[0].respiratorySystem;
							 $('#respiratorySystem').val(respiratorySystem);
							 
							 var liver=data[0].liver;
							 if(liver!="" && liver!=undefined){
								 setSelectedValue("liverPalpable",'Yes');
								 $('#liver').val(liver);
								 $('#liverPalpableInput').show();
							 }
							 else{
								 setSelectedValue("liverPalpable",'No'); 
								 $('#liverPalpableInput').hide();
							 }
							 
							 
							 var spleen=data[0].spleen;
							 if(spleen!=""  && spleen!=undefined){
								 setSelectedValue("spleenPalpable",'Yes');
								 $('#spleen').val(spleen);
								 $('#spleenPalpableInput').show();
								 
							 }
							 
							 else{
								 setSelectedValue("spleenPalpable",'No'); 
								 $('#spleenPalpableInput').hide();
							 }
							 var higherMentalFunction=data[0].higherMentalFunction;
							 $('#higherMentalFunction').val(higherMentalFunction);
							 
							 
							 var speech=data[0].speech;
							 $('#speech').val(speech);
							 
							 var reflexes=data[0].reflexes;
							 $('#reflexes').val(reflexes);
							 
							 var tremors=data[0].tremors;
							 setSelectedValue("tremors",tremors);
							 
							 var selfBalancingTest=data[0].selfBalancingTest;
							 setSelectedValue("selfBalancingTest",selfBalancingTest);
							 
							 var locomotorSystem=data[0].locomotorSystem;
							 $('#locomotorSystem').val(locomotorSystem);
							 
							 var spine=data[0].spine;
							 $('#spine').val(spine);
							 
							 var hernia=data[0].hernia;
							 $('#hernia').val(hernia);
							 
							 var hydrocele=data[0].hydrocele;
							 $('#hydrocele').val(hydrocele);
							 
							 var breast=data[0].breast;
							 $('#breast').val(breast);
							 
							 
							 var pcChestFullExpansion=data[0].pcChestFullExpansion;
							 $('#chestFullExpansion').val(pcChestFullExpansion);
							 
							 var opdPatientDetailId=data[0].opdPatientDetailId
							 $('#opdPatientDetailId').val(opdPatientDetailId);
							 
						var saveInDraft=$('#saveInDraft').val( );
						var status= data[0].status;
							 	$('#chiefComplaint').val( data[0].chiefComplaint);
							 
							 	$('#pollar').val( data[0].pollar);
							 	
							 	$('#ordema').val( data[0].ordema);
							 	
							 	$('#cyanosis').val( data[0].cyanosis);
								
								 
							 	$('#hairnail').val( data[0].hairnail);
							 	
							 	$('#icterus').val( data[0].icterus);
							 	
							 	$('#cyanosis').val( data[0].cyanosis);
								 
							 	$('#lymphNode').val( data[0].lymphNode);
							 	
							 	$('#clubbing').val( data[0].clubbing);
								 
							 	$('#gcs').val( data[0].gcs);
								
							 	$('#Tremors').val(data[0].geTremors);
							 	
							 	$('#others').val( data[0].others);
								
							 	$('#remarksForReferal').val( data[0].remarksForReferal);
								$('#remarksReject').val( data[0].remarksReject);
								finalObservationOfMo=data[0].finalObservationMo;
								$('#remarksPending').val( data[0].remarksPending);
								$('#nextAppointmentDate').val( data[0].nextAppointmentDate);
								
								$('#remarksReject').val( data[0].remarksReject);
								 actionSelected(status);
								
								 var petStatus=data[0].petStatus;
								 
								 setSelectedValue("pet",petStatus);
									 var petDate=data[0].petDate;
									 $('#petDateValue').val(petDate);
									 
							$('#peripheralPulsations').val(data[0].peripheralPulsations);							  
						 
							 $('#checkupDate').val(data[0].checkupDate);
							 $('#haemorrhoids').val(data[0].haemorrhoids);
							 $('#signedByMo').val(data[0].moUser);
							 $('#signedByRMo').val(data[0].rMoUser);
							 $('#signedByPRMo').val(data[0].pRMoUser);

							 $('#mensturalHistory').val(data[0].mensturalHistory);
							 var lmpselectValue=data[0].lmpSelect;
							 setSelectedValue("lmpSelect",lmpselectValue);
							 $('#lMP').val(data[0].lMP);
							 $('#nosOfPregnancies').val(data[0].nosOfPregnancies);
							 $('#nosOfAbortions').val(data[0].nosOfAbortions);

							 
							 $('#nosOfChildren').val(data[0].nosOfChildren);
							 $('#childDateOfLastConfinement').val(data[0].childDateOfLastConfinement);
							 $('#vaginalDischarge').val(data[0].vaginalDischarge);
							 
							
							 $('#usgAbdomen').val(data[0].usgAbdomen);
							 $('#prolapse').val(data[0].prolapse);
							
							 
							 

						 		/*$('#ecgRDMT').val( data[0].ecgRDMT);
								$('#ecgDated').val( data[0].ecgDated);
								$('#ecgReport').val( data[0].ecgReport);
								$('#ecgAMT').val( data[0].ecgAMT);
								$('#ecgAmtDated').val( data[0].ecgAmtDated);
								$('#ecgAmtReport').val( data[0].ecgAmtReport);
								
								
								 $('#xRayChestPANos').val( data[0].xRayChestPANos);
								$('#xRayChestPANosDated').val( data[0].xRayChestPANosDated);
								$('#xRayChestPANosReport').val( data[0].xRayChestPANosReport);
								*/
							 	$('#remarksOfLab').val( data[0].remarksOfLab);
								$('#dateOfLab').val( data[0].dateOfLab);
								$('#signatureOfEyeSpecialist').val( data[0].signatureOfEyeSpecialist);
								
								
								
								 $('#remarksOfSurgery').val( data[0].remarksOfSurgery);
								$('#dateOfSurgery').val( data[0].dateOfSurgery);
								$('#signatureOfSurgicalSpecialist').val( data[0].signatureOfSurgicalSpecialist);
								$('#remarksOfDental').val( data[0].remarksOfDental);
								$('#dateOfDental').val( data[0].dateOfDental);
								$('#signatureOfDentalOfficer').val( data[0].signatureOfDentalOfficer);
								
								
								
								$('#evidenceOfTrachoma').val( data[0].evidenceOfTrachoma);
								$('#binocularVisionGrade').val( data[0].binocularVisionGrade);
								$('#manifestHypermetropiaMyopia').val( data[0].manifestHypermetropiaMyopia);
								$('#coverTest').val( data[0].coverTest);
								$('#diaphragmTest').val( data[0].diaphragmTest);
								$('#fundiMedia').val( data[0].fundiMedia);
								//////////////////
								$('#fieldSpecial').val( data[0].fieldsSpecial);
								$('#nightVisualCapacity').val( data[0].nightVisualCapacity);
								$('#convergenceC').val(data[0].convergenceC);
								$('#convergenceSC').val( data[0].convergenceSC);
								$('#accomodationR').val( data[0].accomodationR);
								$('#accomodationL').val( data[0].accomodationL);
								$('#manifestHypermetropiaMyopiaRemarks').val( data[0].manifestHypeMyopiaRemarks);
								$('#manifestHypermetropiaMyopiaDate').val( data[0].manifestHypeMyopiaDate);
								$('#noseThroatSinusesRemarks').val( data[0].noseThroatSinusesRemarks);
								$('#noseThroatSinusesDate').val( data[0].noseThroatSinusesDate);
								
							
								$('#remarksOfGynaecology').val( data[0].remarksOfGynaecology);
								$('#dateOfGynaecology').val( data[0].dateOfGynaecology);
								$('#signatureOfGynaecologist').val( data[0].signatureOfGynaecologist);
							
								
								
								if(data[0].signatureOfMedicalSpecialist!="")
									$('#signatureOfMedicalSpecialist').val( data[0].signatureOfMedicalSpecialist);
									if(data[0].externalEarR!="")
									$('#externalEarR').val( data[0].externalEarR);
									if(data[0].externalEarL!="")
									$('#externalEarL').val( data[0].externalEarL);
									if(data[0].middleEarR!="")
									$('#middleEarR').val( data[0].middleEarR);
									if(data[0].middleEarL!="")
									$('#middleEarL').val( data[0].middleEarL);
									if(data[0].innerEarR!="")
									$('#innerEarR').val( data[0].innerEarR);
									if(data[0].innerEarL!="")
									$('#innerEarL').val( data[0].innerEarL);
									if(data[0].signatureOfENTSpecialist!="")
									$('#signatureOfENTSpecialist').val( data[0].signatureOfENTSpecialist);
								
									if(data[0].noseSinuses!="")
										$('#noseSinuses').val( data[0].noseSinuses);
										if(data[0].throatSinuses!="")
										$('#throatSinuses').val( data[0].throatSinuses);
									

							
										
										
										if(data[0].memberPlace!="")
											$('#memberPlace').val( data[0].memberPlace);
											if(data[0].memberDate!="")
											$('#memberDate').val( data[0].memberDate);
											if(data[0].rankDesiMember1!="")
											$('#rankDesiMember1').val( data[0].rankDesiMember1);
											if(data[0].nameMember1!="")
											$('#nameMember1').val( data[0].nameMember1);
											if(data[0].rankDesiMember2!="")
											$('#rankDesiMember2').val( data[0].rankDesiMember2);
											if(data[0].nameMember2!="")
											$('#nameMember2').val( data[0].nameMember2);
											if(data[0].rankDesiPresident!="")
											$('#rankDesiPresident').val( data[0].rankDesiPresident);
											if(data[0].namePresident!="")
											$('#namePresident').val( data[0].namePresident);
									
								
							 	finalObservationOfMo=data[0].finalObservationMo;
								finalObservationOfRMo=data[0].finalObservationRmo;
								finalObservationOfPRMo=data[0].paFinalobservation;
								try{$('#signedByMo').val(data[0].moUser);
					        	$('#signedByRMo').val(data[0].rMoUser);
								}catch(e){}
								
					        	serviceType = data[0].serviceType;
								if (listMasServiceType != null
										&& listMasServiceType.length > 0) {
									var masServiceTypeVal = "";
									masServiceTypeVal += '<select class="form-control" id="serviceOfEmployee" name="serviceOfEmployee"';
										masServiceTypeVal += 'class="medium">';
									masServiceTypeVal += '<option value="0"><strong>Select</strong></option>';
									for (var i = 0; i < listMasServiceType.length; i++) {
										var selectedV = '';

										if (serviceType == listMasServiceType[i].serviceTypeId) {
											selectedV = "selected";
										} else {
											selectedV = '';
										}
										masServiceTypeVal += '<option   '+selectedV+'  value="' + listMasServiceType[i].serviceTypeId+ '"  >'
												+ listMasServiceType[i].serviceTypeName
												+ '</option>';
									}
									masServiceTypeVal += '</select>';
								}
								$('#serviceOfEmployee').html(masServiceTypeVal);
								
						}
					 
					 else{
						 if (listMasServiceType != null
									&& listMasServiceType.length > 0) {
								var masServiceTypeVal = "";
								masServiceTypeVal += '<select class="form-control" id="serviceOfEmployee" name="serviceOfEmployee"';
									masServiceTypeVal += 'class="medium">';
								masServiceTypeVal += '<option value="0"><strong>Select</strong></option>';
								for (var i = 0; i < listMasServiceType.length; i++) {
									var selectedV = '';

									if (serviceType == listMasServiceType[i].serviceTypeId) {
										selectedV = "selected";
									} else {
										selectedV = '';
									}
									masServiceTypeVal += '<option   '+selectedV+'  value="' + listMasServiceType[i].serviceTypeId+ '"  >'
											+ listMasServiceType[i].serviceTypeName
											+ '</option>';
								}
								masServiceTypeVal += '</select>';
							}
							$('#serviceOfEmployee').html(masServiceTypeVal);
					 }
				}
			});
	}
 

	
	
	function getAFMSF2AForMOOrMAFor2ADigi() {
		var visitId = $('#visitId').val();
		var age = $('#ageForPatient').val();
		var userId=$('#userId').val();
		var pathname = window.location.pathname;
	     var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/medicalexam/getAFMSF3BForMOOrMA";
		
		var data = {
				"visitId" : visitId,
				"flagForForm" :"f3",
				"age":age,
				"userId":userId
			};
			$.ajax({

				type : "POST",
				contentType : "application/json",
				url : url,
				data : JSON.stringify(data),
				dataType : "json",
				// cache: false,

				success : function(res) {
					 data = res.listOfResponse;
					 var listMasServiceType = res.listMasServiceType;
					 var serviceType="";
					 if (data != undefined && data != null && data!="") {
							$('#totalNoOfTeath').val(data[0].totalNoOfTeath);
							$('#totalNoOfDefective').val(data[0].totalNoOfDefective);
							$('#totalNoOfDentalPoints').val(data[0].totalNoOfDentalPoints);

							$('#missing').val(data[0].missing);
							$('#unSavable').val(data[0].unSavable);
							$('#conditionOfGums').val(data[0].conditionOfGums);
							
							var glopbalVarForAll;
							 var missingTeethUr=data[0].missingTeethUr;
							 if(missingTeethUr!="" && missingTeethUr!=null){
								 glopbalVarForAll=missingTeethUr.split(",");
								 checkForTeeth("urMChecked",glopbalVarForAll);
							 }
							 
							 var missingTeethUl=data[0].missingTeethUl;
							 if(missingTeethUl!="" && missingTeethUl!=null){
								 glopbalVarForAll=missingTeethUl.split(",");
								 checkForTeeth("ulMChecked",glopbalVarForAll);
							 }
							 var missingTeethLL=data[0].missingTeethLL;
							 
							 if(missingTeethLL!="" && missingTeethLL!=null){
								 glopbalVarForAll=missingTeethLL.split(",");
								 checkForTeeth("llMChecked",glopbalVarForAll);
							 }
							 
							 var missingTeethLR=data[0].missingTeethLR;
							 
							 if(missingTeethLR!="" && missingTeethLR!=null){
								 glopbalVarForAll=missingTeethLR.split(",");
								 checkForTeeth("lrMChecked",glopbalVarForAll);
							 }
							 
							 var unsavableTeethUr=data[0].unsavableTeethUr;
							 if(unsavableTeethUr!="" && unsavableTeethUr!=null){
								 glopbalVarForAll=unsavableTeethUr.split(",");
								 checkForTeeth("unurChecked",glopbalVarForAll);
							 }
							 var unsavableTeethUl=data[0].unsavableTeethUl;
							 if(unsavableTeethUl!="" && unsavableTeethUl!=null){
								 glopbalVarForAll=unsavableTeethUl.split(",");
								 checkForTeeth("unulChecked",glopbalVarForAll);
							 }
							 
							 var unsavableTeethLl=data[0].unsavableTeethLl;
							 if(unsavableTeethLl!="" && unsavableTeethLl!=null){
								 glopbalVarForAll=unsavableTeethLl.split(",");
								 checkForTeeth("unllChecked",glopbalVarForAll);
							 }
							 
							 var unsavableTeethLr=data[0].unsavableTeethLr;
							 if(unsavableTeethLr!="" && unsavableTeethLr!=null){
								 glopbalVarForAll=unsavableTeethLr.split(",");
								 checkForTeeth("unlrChecked",glopbalVarForAll);
							 }
							 if(data[0].dentalOffier!="")
							 $('#dentalOffier').val(data[0].dentalOffier);
							 
							 if(data[0].remarks!="")
							 $('#remarks').val(data[0].remarks);
							 $('#remarkAdvice').val(data[0].remarkAdvice);
							 
							 var pcHeight=data[0].pcHeight;
							 $('#height').val(pcHeight);
							 
							 var pcWeight=data[0].pcWeight;
							 $('#weight').val(pcWeight);
							 
							 var pcIdealWeight=data[0].pcIdealWeight;
							 $('#idealWeight').val(pcIdealWeight);
							 
							 var pcOverWeight=data[0].pcOverWeight;
							 $('#overWeight').val(pcOverWeight);
							 
							 var pcBmi=data[0].pcBmi;
							 $('#bmi').val(pcBmi);
							 
							 var pcBodyFat=data[0].pcBodyFat;
							 $('#bodyFat').val(pcBodyFat);
							 
							 var pcWaist=data[0].pcWaist;
							 $('#waist').val(pcWaist);
							 var pcSkinFoldExpansion=data[0].pcSkinFoldExpansion;
							 $('#skinFoldExpansion').val(pcSkinFoldExpansion);
							 
							 var pcChestFullExpansion=data[0].pcChestFullExpansion;
							 $('#chestFullExpansion').val(pcChestFullExpansion);
							 
							 var pcRangeOfExpansion=data[0].pcRangeOfExpansion;
							 if(data[0].pcRangeOfExpansion!=null && data[0].pcRangeOfExpansion!="" && data[0].pcRangeOfExpansion!=undefined)
							 $('#rangeOfExpansion').val(pcRangeOfExpansion);
							 
							 var pcSportsman=data[0].pcSportsman;
							 setSelectedValue("sportsman",pcSportsman);
							  //Vision start
								
								 var distantWithoutGlasses=data[0].distantWithoutGlasses;
								 setSelectedValue("distantWithoutGlasses",distantWithoutGlasses);
							 
								 var distantWithoutGlassesL=data[0].distantWithoutGlassesL;
								 setSelectedValue("distantWithoutGlassesL",distantWithoutGlassesL);	
								 
								 var nearWithoutGlasses=data[0].nearWithoutGlasses;
								 setSelectedValue("nearWithoutGlasses",nearWithoutGlasses);
								 
								 var nearWithoutGlassesL=data[0].nearWithoutGlassesL;
								 setSelectedValue("nearWithoutGlassesL",nearWithoutGlassesL);
								
								 
								 var cpWithoutGlasses=data[0].cpWithoutGlasses;
								 setSelectedValue("cpWithoutGlasses",cpWithoutGlasses);
							 
								 
								 var distantWithGlasses=data[0].distantWithGlasses;
								 setSelectedValue("distantWithGlasses",distantWithGlasses);
								 
								 var distantWithGlassesL=data[0].distantWithGlassesL;
								 setSelectedValue("distantWithGlassesL",distantWithGlassesL);
								 
								 
								 var nearWithGlasses=data[0].nearWithGlasses;
								 setSelectedValue("nearWithGlasses",nearWithGlasses);
							
								 
								 var nearWithGlassesL=data[0].nearWithGlassesL;
								 setSelectedValue("nearWithGlassesL",nearWithGlassesL);
								 
							//Hearing
							 var fwR=data[0].fwR;
							 if(fwR!="" && fwR!=null)
								 $('#fwR').val(fwR);
							 
							 var fwL=data[0].fwL;
							 if(fwL!="" && fwL!=null)
							 $('#fwL').val(fwL);
							 
							 var fwBoth=data[0].fwBoth;
							 if(fwBoth!="" && fwBoth!=null)
							 $('#fwBoth').val(fwBoth);
							 
							 var cvR=data[0].cvR;
							 if(cvR!="" && cvR!=null)
							 $('#cvR').val(cvR);
							 
							 var cvL=data[0].cvL;
							 if(cvL!="" && cvL!=null)
							 $('#cvL').val(cvL);
							 
							 var cvBoth=data[0].cvBoth;
							 if(cvBoth!="" && cvBoth!=null)
							 $('#cvBoth').val(cvBoth);
							 
							 var tmR=data[0].tmR;
							 setSelectedValue("tmR",tmR);
							 
							 var tmL=data[0].tmL;
							 setSelectedValue("tmL",tmL);
							 
							 var mobilityR=data[0].mobilityR;
							 //$('#mobilityR').val(mobilityR);
							 setSelectedValue("mobilityR",mobilityR);
							 
							 var mobilityL=data[0].mobilityL;
							 //$('#mobilityL').val(mobilityL);
							 setSelectedValue("mobilityL",mobilityL);
							 
							 var noiseThroatSinuses=data[0].noiseThroatSinuses;
							 $('#noseThroatSinuses').val(noiseThroatSinuses);
							 
							 var audiometryRecord=data[0].audiometryRecord;
							 
							 setSelectedValue("audiometryRecord",audiometryRecord);
							 if(audiometryRecord!=null && audiometryRecord=='Others'){
							 var audiometryRecordOthers=data[0].audiometryRecordForOther;
							 $('#audiometryRecordForOther').val(audiometryRecordOthers);
							 $('#audiometryRecordForDisplay').show();
							 }
							 else{
								 $('#audiometryRecordForDisplay').hide();
							 }
							 var clinicalNotes=data[0].clinicalNotes;
							 $('#clinicalNotes').val(clinicalNotes);
							 
							 var pluse=data[0].pluse;
							 $('#pulse').val(pluse);
							 
							 var bp=data[0].bp;
							 $('#bp').val(bp);
							 
							 var bp1=data[0].bp1;
							 $('#bp1').val(bp1);
							 
							 var heartSize=data[0].heartSize;
							 if(heartSize!="" && heartSize!=null)
							 $('#heartSize').val(heartSize);
							 
							 var sounds=data[0].sounds;
							 if(sounds!="" && sounds!=null)
							 $('#sounds').val(sounds);
							 
							 var rhythm=data[0].rhythm;
							 if(rhythm!="" && rhythm!=null)
							 $('#rhythm').val(rhythm);
							 
							 var respiratorySystem=data[0].respiratorySystem;
							 if(respiratorySystem!="" && respiratorySystem!=null)
							 $('#respiratorySystem').val(respiratorySystem);
							 
							 var liver=data[0].liver;
							 if(liver!="" && liver!=undefined){
								 setSelectedValue("liverPalpable",'Yes');
								 $('#liver').val(liver);
								 $('#liverPalpableInput').show();
							 }
							 else{
								 setSelectedValue("liverPalpable",'No'); 
								 $('#liverPalpableInput').hide();
							 }
							 
							 
							 var spleen=data[0].spleen;
							 if(spleen!=""  && spleen!=undefined){
								 setSelectedValue("spleenPalpable",'Yes');
								 $('#spleen').val(spleen);
								 $('#spleenPalpableInput').show();
								 
							 }
							 
							 else{
								 setSelectedValue("spleenPalpable",'No'); 
								 $('#spleenPalpableInput').hide();
							 }
							 var higherMentalFunction=data[0].higherMentalFunction;
							 $('#higherMentalFunction').val(higherMentalFunction);
							 
							 
							 var speech=data[0].speech;
							 if(speech!="" && speech!=null)
							 $('#speech').val(speech);
							 
							 var reflexes=data[0].reflexes;
							 if(reflexes!="" && reflexes!=null)
							 $('#reflexes').val(reflexes);
							 
							 var tremors=data[0].tremors;
							 setSelectedValue("tremors",tremors);
							 
							 var selfBalancingTest=data[0].selfBalancingTest;
							 setSelectedValue("selfBalancingTest",selfBalancingTest);
							 
							 var locomotorSystem=data[0].locomotorSystem;
							 $('#locomotorSystem').val(locomotorSystem);
							 
							 var spine=data[0].spine;
							 if(spine!="" && spine!=null)
							 $('#spine').val(spine);
							 
							 var hernia=data[0].hernia;
							 if(hernia!="" && hernia!=null)
							 $('#hernia').val(hernia);
							 
							 var hydrocele=data[0].hydrocele;
							 if(hydrocele!="" && hydrocele!=null)
							 $('#hydrocele').val(hydrocele);
							 
							 var breast=data[0].breast;
							 if(breast!="" && breast!=null)
							 $('#breast').val(breast);
							 
							 
							 var pcChestFullExpansion=data[0].pcChestFullExpansion;
							 if(pcChestFullExpansion!="" && pcChestFullExpansion!=null)
							 $('#chestFullExpansion').val(pcChestFullExpansion);
							 
							 var opdPatientDetailId=data[0].opdPatientDetailId
							 $('#opdPatientDetailId').val(opdPatientDetailId);
							 
						var saveInDraft=$('#saveInDraft').val( );
						var status= data[0].status;
							 	$('#chiefComplaint').val( data[0].chiefComplaint);
							 
							 	$('#pollar').val( data[0].pollar);
							 	
							 	$('#ordema').val( data[0].ordema);
							 	
							 	$('#cyanosis').val( data[0].cyanosis);
								
								 
							 	$('#hairnail').val( data[0].hairnail);
							 	
							 	$('#icterus').val( data[0].icterus);
							 	
							 	$('#cyanosis').val( data[0].cyanosis);
								 
							 	$('#lymphNode').val( data[0].lymphNode);
							 	
							 	$('#clubbing').val( data[0].clubbing);
								 
							 	$('#gcs').val( data[0].gcs);
								
							 	$('#Tremors').val(data[0].geTremors);
							 	
							 	$('#others').val( data[0].others);
								
							 	$('#remarksForReferal').val( data[0].remarksForReferal);
								$('#remarksReject').val( data[0].remarksReject);
								finalObservationOfMo=data[0].finalObservationMo;
								$('#remarksPending').val( data[0].remarksPending);
								$('#nextAppointmentDate').val( data[0].nextAppointmentDate);
								
								$('#remarksReject').val( data[0].remarksReject);
								 actionSelected(status);
								
								 var petStatus=data[0].petStatus;
								 
								 setSelectedValue("pet",petStatus);
									 var petDate=data[0].petDate;
									 $('#petDateValue').val(petDate);
									 
							$('#peripheralPulsations').val(data[0].peripheralPulsations);							  
						 
							 $('#checkupDate').val(data[0].checkupDate);
							 $('#haemorrhoids').val(data[0].haemorrhoids);
							 $('#signedByMo').val(data[0].moUser);
							 $('#signedByRMo').val(data[0].rMoUser);
							 $('#signedByPRMo').val(data[0].pRMoUser);

							 $('#mensturalHistory').val(data[0].mensturalHistory);
							 var lmpselectValue=data[0].lmpSelect;
							 setSelectedValue("lmpSelect",lmpselectValue);
							 $('#lMP').val(data[0].lMP);
							 $('#nosOfPregnancies').val(data[0].nosOfPregnancies);
							 $('#nosOfAbortions').val(data[0].nosOfAbortions);

							 
							 $('#nosOfChildren').val(data[0].nosOfChildren);
							 $('#childDateOfLastConfinement').val(data[0].childDateOfLastConfinement);
							 $('#vaginalDischarge').val(data[0].vaginalDischarge);
							 
							
							 $('#usgAbdomen').val(data[0].usgAbdomen);
							 $('#prolapse').val(data[0].prolapse);
							
							 
							 ////////////////////////////////////form 2A start//////////////////////////////////////////////////		
 							 if(data[0].batchNo!="")
							 $('#batchNo').val(data[0].batchNo);
 							if(data[0].chestNo!="")
 							 $('#chestNo').val(data[0].chestNo);
 							if(data[0].rollNo!="")
 							 $('#rollNo').val(data[0].rollNo);
 							//if(data[0].maritalStatusId!="")
							 //$('#maritalStatusId').val(data[0].maritalStatusId);
 							if(data[0].hoursFlown!="")
 							$('#hoursFlown').val(data[0].hoursFlown);
 							if(data[0].permanentAddress!="")
							 $('#permanentAddress').val(data[0].permanentAddress);
 							if(data[0].identificationMarks1!="")
 							 $('#identificationMarks1').val(data[0].identificationMarks1);
 							if(data[0].identificationMarks2!="")
							 $('#identificationMarks2').val(data[0].identificationMarks2);
 							if(data[0].hypertension!="")
							 $('#hypertension').val(data[0].hypertension);
 							if(data[0].heartDisease!="")
							 $('#heartDisease').val(data[0].heartDisease);
 							if(data[0].diabetes!="")
 							 $('#diabetes').val(data[0].diabetes);
 							if(data[0].bleedingDisorders!="")
							 $('#bleedingDisorders').val(data[0].bleedingDisorders);
 							if(data[0].mentalDisease!="")
 							$('#mentalDisease').val(data[0].mentalDisease);
 							if(data[0].nightBlindnessForFamily!="")
							 $('#nightBlindnessForFamily').val(data[0].nightBlindnessForFamily);
 							if(data[0].chronicBronchitisAsthma!="")
 							 $('#chronicBronchitisAsthma').val(data[0].chronicBronchitisAsthma);
 							if(data[0].pleurisyTuberculosis!="")
							 $('#pleurisyTuberculosis').val(data[0].pleurisyTuberculosis);
 							if(data[0].rhuematismFrequentSoreThroat!="")
							  $('#rhuematismFrequentSoreThroat').val(data[0].rhuematismFrequentSoreThroat);
 							if(data[0].chronicIndigestion!="")
							 $('#chronicIndigestion').val(data[0].chronicIndigestion);
 							if(data[0].kidneyBladderTrouble!="")
 							 $('#kidneyBladderTrouble').val(data[0].kidneyBladderTrouble);
 							if(data[0].std!="")
							 $('#std').val(data[0].std);
 							if(data[0].jaundice!="")
 							$('#jaundice').val(data[0].jaundice);
 							if(data[0].airSeaCarTrainSickness!="")
							 $('#airSeaCarTrainSickness').val(data[0].airSeaCarTrainSickness);
 							if(data[0].trachoma!="")
 							 $('#trachoma').val(data[0].trachoma);
 							if(data[0].nightBlindness!="")
							 $('#nightBlindness').val(data[0].nightBlindness);
 							if(data[0].laserTreatmentSurgeryForEye!="")
							 $('#laserTreatmentSurgeryForEye').val(data[0].laserTreatmentSurgeryForEye);
 							if(data[0].anyOtherEyenDisease!="")
							 $('#anyOtherEyenDisease').val(data[0].anyOtherEyenDisease);
 							if(data[0].dischargeFromEars!="")
 							 $('#dischargeFromEars').val(data[0].dischargeFromEars);
 							if(data[0].anyOtherEarDisease!="")
							 $('#anyOtherEarDisease').val(data[0].anyOtherEarDisease);
 							if(data[0].frequentCoughColdSinusitis!="")
 							$('#frequentCoughColdSinusitis').val(data[0].frequentCoughColdSinusitis);
 							if(data[0].nervousBreakdownMentalIllness!="")
							 $('#nervousBreakdownMentalIllness').val(data[0].nervousBreakdownMentalIllness);
 							if(data[0].fitsFaintingAttacks!="")
 							 $('#fitsFaintingAttacks').val(data[0].fitsFaintingAttacks);
 							if(data[0].severeHeadInjury!="")
							 $('#severeHeadInjury').val(data[0].severeHeadInjury);
 							if(data[0].breastDiseaseDischarge!="")
 							 $('#breastDiseaseDischarge').val(data[0].breastDiseaseDischarge);
 							if(data[0].amenorrhoeaDysmemhorrheas!="")
 							$('#amenorrhoeaDysmemhorrheas').val(data[0].amenorrhoeaDysmemhorrheas);
 							if(data[0].menorrhagia!="")
							 $('#menorrhagia').val(data[0].menorrhagia);
 							if(data[0].pregnancy!="")
 							 $('#pregnancy').val(data[0].pregnancy);
 							if(data[0].abortion!="")
							 $('#abortion').val(data[0].abortion);
 							if(data[0].mediyUnfitBranchArmedForcesRejected!="")
							 $('#mediyUnfitBranchArmedForcesRejected').val(data[0].mediyUnfitBranchArmedForcesRejected);
 							if(data[0].mediyUnfitBranchArmedForcesDischarged!="") 
 							$('#mediyUnfitBranchArmedForcesDischarged').val(data[0].mediyUnfitBranchArmedForcesDischarged);
 							if(data[0].illnessOperationInjuryDiseaseDuration!="")
 							 $('#illnessOperationInjuryDiseaseDuration').val(data[0].illnessOperationInjuryDiseaseDuration);
 							
 							if(data[0].illnessOperationInjuryDiseaseDuration!="" && data[0].illnessOperationInjuryDiseaseDuration=='y'){
 							if(data[0].illnessOperationInjuryDiseaseDurationStayHospital!="")
 								$('#illnessOperationInjuryDiseaseDurationStayHospital').val(data[0].illnessOperationInjuryDiseaseDurationStayHospital);
 							$('#divIllnessOperationInjury').show();
 							}
 							else{
 								$('#divIllnessOperationInjury').hide();
 							}
 							if(data[0].otherInformationHealth!="")
 							$('#otherInformationHealth').val(data[0].otherInformationHealth);
 							if(data[0].signatureMedicalOfficer!="")
 							$('#signatureMedicalOfficer').val(data[0].signatureMedicalOfficer);
 							if(data[0].signatureOfCanditate!="")
 							$('#signatureOfCanditate').val(data[0].signatureOfCanditate);
 							if(data[0].signatureMedicalOfficerDate!="")
 							$('#signatureMedicalOfficerDate').val(data[0].signatureMedicalOfficerDate);
 							if(data[0].signatureOfCanditateDate!="")
 							$('#signatureOfCanditateDate').val(data[0].signatureOfCanditateDate);
								 
				
 							
 							$('#remarksOfGynaecology').val( data[0].remarksOfGynaecology);
							$('#dateOfGynaecology').val( data[0].dateOfGynaecology);
							$('#signatureOfGynaecologist').val( data[0].signatureOfGynaecologist);
						
							
							

										if(data[0].remarksOfLab!="" && data[0].remarksOfLab!=undefined && data[0].remarksOfLab!=null)
											$('#remarksOfLab').val( data[0].remarksOfLab);
										 if(data[0].dateOfLab!=""  && data[0].dateOfLab!=undefined && data[0].dateOfLab!=null)
											 $('#dateOfLab').val( data[0].dateOfLab);
										 if(data[0].signatureOfEyeSpecialist!="" && data[0].signatureOfEyeSpecialist!=undefined && data[0].signatureOfEyeSpecialist!=null)
											 $('#signatureOfEyeSpecialist').val( data[0].signatureOfEyeSpecialist);
										 if(data[0].signatureOfMedicalSpecialist!="" && data[0].signatureOfMedicalSpecialist!=undefined && data[0].signatureOfMedicalSpecialist!=null)
										 $('#signatureOfMedicalSpecialist').val( data[0].signatureOfMedicalSpecialist);
																
									$('#remarksOfSurgery').val( data[0].remarksOfSurgery);
									$('#dateOfSurgery').val( data[0].dateOfSurgery);
									$('#signatureOfSurgicalSpecialist').val( data[0].signatureOfSurgicalSpecialist);
									$('#remarksOfDental').val( data[0].remarksOfDental);
									$('#dateOfDental').val( data[0].dateOfDental);
									$('#signatureOfDentalOfficer').val( data[0].signatureOfDentalOfficer);	 
				 
												
									
									
									
									$('#evidenceOfTrachoma').val( data[0].evidenceOfTrachoma);
									$('#binocularVisionGrade').val( data[0].binocularVisionGrade);
									$('#manifestHypermetropiaMyopia').val( data[0].manifestHypermetropiaMyopia);
									$('#coverTest').val( data[0].coverTest);
									$('#diaphragmTest').val( data[0].diaphragmTest);
									$('#fundiMedia').val( data[0].fundiMedia);
									//////////////////
									$('#fieldSpecial').val( data[0].fieldsSpecial);
									$('#nightVisualCapacity').val( data[0].nightVisualCapacity);
									$('#convergenceC').val(data[0].convergenceC);
									$('#convergenceSC').val( data[0].convergenceSC);
									$('#accomodationR').val( data[0].accomodationR);
									$('#accomodationL').val( data[0].accomodationL);
									$('#manifestHypermetropiaMyopiaRemarks').val( data[0].manifestHypeMyopiaRemarks);
									$('#manifestHypermetropiaMyopiaDate').val( data[0].manifestHypeMyopiaDate);
									$('#noseThroatSinusesRemarks').val( data[0].noseThroatSinusesRemarks);
									$('#noseThroatSinusesDate').val( data[0].noseThroatSinusesDate);
									
								
									$('#remarksOfGynaecology').val( data[0].remarksOfGynaecology);
									$('#dateOfGynaecology').val( data[0].dateOfGynaecology);
									$('#signatureOfGynaecologist').val( data[0].signatureOfGynaecologist);
								
										if(data[0].externalEarR!="")
										$('#externalEarR').val( data[0].externalEarR);
										if(data[0].externalEarL!="")
										$('#externalEarL').val( data[0].externalEarL);
										if(data[0].middleEarR!="")
										$('#middleEarR').val( data[0].middleEarR);
										if(data[0].middleEarL!="")
										$('#middleEarL').val( data[0].middleEarL);
										if(data[0].innerEarR!="")
										$('#innerEarR').val( data[0].innerEarR);
										if(data[0].innerEarL!="")
										$('#innerEarL').val( data[0].innerEarL);
										if(data[0].signatureOfENTSpecialist!="")
										$('#signatureOfENTSpecialist').val( data[0].signatureOfENTSpecialist);
									
										if(data[0].noseSinuses!="")
											$('#noseSinuses').val( data[0].noseSinuses);
											if(data[0].throatSinuses!="")
											$('#throatSinuses').val( data[0].throatSinuses);
										
									
											if(data[0].memberPlace!="")
												$('#memberPlace').val( data[0].memberPlace);
												if(data[0].memberDate!="")
												$('#memberDate').val( data[0].memberDate);
												if(data[0].rankDesiMember1!="")
												$('#rankDesiMember1').val( data[0].rankDesiMember1);
												if(data[0].nameMember1!="")
												$('#nameMember1').val( data[0].nameMember1);
												if(data[0].rankDesiMember2!="")
												$('#rankDesiMember2').val( data[0].rankDesiMember2);
												if(data[0].nameMember2!="")
												$('#nameMember2').val( data[0].nameMember2);
												if(data[0].rankDesiPresident!="")
												$('#rankDesiPresident').val( data[0].rankDesiPresident);
												if(data[0].namePresident!="")
												$('#namePresident').val( data[0].namePresident);		
												
												
												if(data[0].memberPlaceSub!="")
													$('#memberPlaceSub').val( data[0].memberPlaceSub);
													if(data[0].memberDateSub!="")
													$('#memberDateSub').val( data[0].memberDateSub);
													if(data[0].rankDesiMember1Sub!="")
													$('#rankDesiMember1Sub').val( data[0].rankDesiMember1Sub);
													if(data[0].nameMember1Sub!="")
													$('#nameMember1Sub').val( data[0].nameMember1Sub);
													if(data[0].rankDesiMember2Sub!="")
													$('#rankDesiMember2Sub').val( data[0].rankDesiMember2Sub);
													if(data[0].nameMember2Sub!="")
													$('#nameMember2Sub').val( data[0].nameMember2Sub);
													if(data[0].rankDesiPresidentSub!="")
													$('#rankDesiPresidentSub').val( data[0].rankDesiPresidentSub);
													if(data[0].namePresidentSub!="")
													$('#namePresidentSub').val( data[0].namePresidentSub);
												
								////////////////////////////////////////////////////////////////////////////////
								
							 	finalObservationOfMo=data[0].finalObservationMo;
								finalObservationOfRMo=data[0].finalObservationRmo;
								finalObservationOfPRMo=data[0].paFinalobservation;
								
								$('#finalObservationDigi2').jqteVal( data[0].paFinalobservationSubsequent);
								$('#legLength').val(data[0].legLength);
								$('#physique').val(data[0].physique);
								$('#skin').val(data[0].skin);
								$('#erlocrine').val(data[0].erlocrine);
								$('#anyOtherAbnormalities').val(data[0].anyOtherAbnormalities);

								  $('#upperLimbs').val(data[0].upperLimbs);
								  $('#lowerLimbs').val(data[0].lowerLimbs);
								  $('#lumbarSacral').val(data[0].lumbarSacral);
								  $('#genitoUrinaryPerineum').val(data[0].genitoUrinaryPerineum);
								  $('#herniaMuscle').val(data[0].herniaMuscle);
								try{
									$('#signedByMo').val(data[0].moUser);
						        	$('#signedByRMo').val(data[0].rMoUser);
								}
								catch(e){}
								  
								  serviceType = data[0].serviceType;
								  if (listMasServiceType != null
											&& listMasServiceType.length > 0) {
										var masServiceTypeVal = "";
										masServiceTypeVal += '<select class="form-control" id="serviceOfEmployee" name="serviceOfEmployee"';
											masServiceTypeVal += 'class="medium">';
										masServiceTypeVal += '<option value="0"><strong>Select</strong></option>';
										for (var i = 0; i < listMasServiceType.length; i++) {
											var selectedV = '';

											if (serviceType == listMasServiceType[i].serviceTypeId) {
												selectedV = "selected";
											} else {
												selectedV = '';
											}
											masServiceTypeVal += '<option   '+selectedV+'  value="' + listMasServiceType[i].serviceTypeId+ '"  >'
													+ listMasServiceType[i].serviceTypeName
													+ '</option>';
										}
										masServiceTypeVal += '</select>';
									}
									$('#serviceOfEmployee').html(masServiceTypeVal);
								  
						}
					 else{
						 if (listMasServiceType != null
									&& listMasServiceType.length > 0) {
								var masServiceTypeVal = "";
								masServiceTypeVal += '<select class="form-control" id="serviceOfEmployee" name="serviceOfEmployee"';
									masServiceTypeVal += 'class="medium">';
								masServiceTypeVal += '<option value="0"><strong>Select</strong></option>';
								for (var i = 0; i < listMasServiceType.length; i++) {
									var selectedV = '';

									if (serviceType == listMasServiceType[i].serviceTypeId) {
										selectedV = "selected";
									} else {
										selectedV = '';
									}
									masServiceTypeVal += '<option   '+selectedV+'  value="' + listMasServiceType[i].serviceTypeId+ '"  >'
											+ listMasServiceType[i].serviceTypeName
											+ '</option>';
								}
								masServiceTypeVal += '</select>';
							}
							$('#serviceOfEmployee').html(masServiceTypeVal);
					 }
					 
				}
			});
	}
	
	
	/*function getImmunisationHistoryDigi() {
		 
		 var approvalFlag=$('#approvalFlag').val();
		 var approvalFlagDiasable="";
		 if(approvalFlag!="" && approvalFlag!=undefined && approvalFlag!=null && approvalFlag=='y'){
			 approvalFlagDiasable='disabled';
		 }
		 else{
			 approvalFlagDiasable="";
		 }
		 var pathname = window.location.pathname;
	     var accessGroup = "MMUWeb";
		 var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalexam/getImmunisationHistory";
		 
		 var visitId = $('#visitId').val();
			var patientId=$('#patientId').val();
			var data = {
				"visitId" : visitId,
				"patientId":patientId,
				"flagForForm":'digi'
			};
				$.ajax({
						type : "POST",
						contentType : "application/json",
						url : url,
						data : JSON.stringify(data),
						dataType : "json",
						// cache: false,

						success : function(response) {
							
						var globalDataMasstoreItem = response.listMasStoreItem;	
						 var immmunisationHtml="";
						 var diasableValue="disabled";
						 func1='populateMasStoreItem';
			    		   url1='opd';
			    		   url2='getMasStoreItemList';
			    		   flaga='immunizationFlag';
						 if(globalDataMasstoreItem!=null && globalDataMasstoreItem.length>0)
						 for (var i = 0; i < globalDataMasstoreItem.length; i++) {
							 immmunisationHtml += '<tr>';
							 immmunisationHtml+='<td> <div class="form-group autocomplete forTableResp">';
							// immmunisationHtml+='<input type="text" autocomplete="never" class="form-control border-input" name="immunisatioName" id="immunisatioName" value="'+globalDataMasstoreItem[i].itemCode+ '[' + globalDataMasstoreItem[i].pvmsNo + ']'+'"  onKeyPrss="autoCompleteCommonMe(this,7);"  onKeydown="autoCompleteCommonMe(this,7);" onKeyUp="autoCompleteCommonMe(this,7);"  readonly="readonly" onblur="populateMasStoreItem(this.value,1,this);" '+approvalFlagDiasable+'/>';
							 
							 immmunisationHtml+='<input type="text" autocomplete="never" class="form-control border-input" readonly="readonly" name="immunisatioName" id="immunisatioName" value="'+globalDataMasstoreItem[i].itemCode+ '[' + globalDataMasstoreItem[i].pvmsNo + ']'+'"    onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"    '+approvalFlagDiasable+'/>';
							 
							 immmunisationHtml += '<input type="hidden"  name="immunisationId" value="'
									+ globalDataMasstoreItem[i].itemId  +'"  id="immunisationId' + globalDataMasstoreItem[i].itemId + '"/>';

							 
							 immmunisationHtml += '<div id="immunizationDiv'+i+'" class="autocomplete-itemsNew"></div>';

							 immmunisationHtml+='</div></td>';
							 var immunisationName="";
							 var durationImmu="";
							 if(globalDataMasstoreItem[i].itemCode!="" && (globalDataMasstoreItem[i].itemCode.includes('Tetanus')|| globalDataMasstoreItem[i].itemCode.includes('Tetanus'))){
								 immunisationName='immunisationDateTab';
								 if(globalDataMasstoreItem[i].duration!=null && globalDataMasstoreItem[i].duration!="")
									 {
									 durationImmu=globalDataMasstoreItem[i].duration;
									 if(globalDataMasstoreItem[i].itemCode.includes('Tetanus')|| globalDataMasstoreItem[i].itemCode.includes('Tetanus')){
										 diasableValue="disabled";
									 }
									 else{
										 diasableValue=""; 
									 }
									
									 }
								 else{
									 if(globalDataMasstoreItem[i].itemCode.includes('Tetanus')|| globalDataMasstoreItem[i].itemCode.includes('Tetanus')){
										 durationImmu='5';
										 diasableValue="disabled";
									 }
									 else{
										 durationImmu="";
										 diasableValue="";
									 }
								 }
								 }
							 else{
								 immunisationName='immunisationDateTT';
								 if(globalDataMasstoreItem[i].duration!=null && globalDataMasstoreItem[i].duration!="")
								 {
								 durationImmu=globalDataMasstoreItem[i].duration;
								 if(globalDataMasstoreItem[i].itemCode.includes('Injectable Typhoid Vaccine')|| globalDataMasstoreItem[i].itemCode.includes('Injectable Typhoid Vaccine')){
									 diasableValue="disabled";
								 }
								 else{
									 diasableValue=""; 
								 }
								  
								 }
							 else{
								 if(globalDataMasstoreItem[i].itemCode.includes('Injectable Typhoid Vaccine')|| globalDataMasstoreItem[i].itemCode.includes('Injectable Typhoid Vaccine')){
									 durationImmu='3';
									 diasableValue="disabled";
								 }
								 else{
									 durationImmu="";
									 diasableValue="";
								 }
							 	}
							 }
							 
							 
							 var immunizationDateValue="";
							 if(globalDataMasstoreItem[i].immunizationDate!=""){
								 immunizationDateValue= globalDataMasstoreItem[i].immunizationDate
							 }
							 else{
								 immunizationDateValue="";
							 }
							 immmunisationHtml+='<td>';
							 immmunisationHtml+='<div class="dateHolder">';
							 immmunisationHtml+='<input class="form-control noFuture_date6" name="immnunizationDate" id="immnunizationDate'+i+'"  '+approvalFlagDiasable+'  value="'+immunizationDateValue+'" />';
							 immmunisationHtml+='</div>';
							 immmunisationHtml+='</td>';
							
							 immmunisationHtml+='<td>';
							 immmunisationHtml+=' <input type="text" name="durationImmu"  id="durationImmu'+i+'" value="'+durationImmu+'" onblur="return generateNextDateForImmun(this);" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control" readonly/> ';
							 immmunisationHtml+='</td>';
	                          
							 var immunizationNextDueImmuDateValue="";
							 if(globalDataMasstoreItem[i].immunizationDate!=""){
								 immunizationNextDueImmuDateValue= globalDataMasstoreItem[i].immunizationNextDateValue
							 }
							 else{
								 immunizationNextDueImmuDateValue="";
							 }
							 
							 immmunisationHtml+='<td>';
							 immmunisationHtml+='   <div class="dateHolder">';
							 immmunisationHtml+=' <input type="text" id="nextDueImmu'+i+'"  name="nextDueImmu" class="form-control" placeholder="DD/MM/YYYY" value="'+immunizationNextDueImmuDateValue+'" maxlength="10" readonly />';
							 immmunisationHtml+=' </div>';
							 immmunisationHtml+='  </td>';
							 
							 
							 immmunisationHtml+=' <td><button name="Button" '+approvalFlagDiasable+' type="button" class="buttonAdd btn btn-primary noMinWidth" button-type="add" onClick="return addImmunisationStatus();"> </button></td>';
							var immunizationId="";
							if(globalDataMasstoreItem[i].immunizationId!="" &&  globalDataMasstoreItem[i].immunizationId!=undefined && globalDataMasstoreItem[i].immunizationId!=null){
								immunizationId=globalDataMasstoreItem[i].immunizationId;
							}
							var immunisationStatusGrid='immunisationStatusGrid';
							
							 immmunisationHtml+='	<td><button name="Button" type="button" class="buttonAdd btn btn-danger noMinWidth" id="immunizationDelete" button-type="delete" '+diasableValue+' onClick="return removeRowInvestigationMe(this,\'' + immunisationStatusGrid + '\',\''+ immunizationId + '\');"> </button></td>';
							 immmunisationHtml += '</tr>';
						 }				
				 
						 $("#immunisationStatusGrid").html(immmunisationHtml); 
					}
				});
			}*/
	 
	
	
	
	 function masMedicalCategoryListForDigi2A() {
		 	
	     var pathname = window.location.pathname;
	     var accessGroup = "MMUWeb";

	     var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/getMedicalBoardAutocomplete";
	var countMedCat=0;
 
	     
	     if (document.getElementById('fitInChk').checked == true) {
	     $.ajax({
	         type: "POST",
	         contentType: "application/json",
	         url: url,
	         data: JSON.stringify({
	             'employeeId': '1'
	         }),
	         dataType: 'json',
	         //timeout: 100000,

	         success: function(res)

	         {
	            var mcDataList = res.masMedicalCategoryList;
	        	var  msgForFit=resourceJSON.msgForFitIn;
	         	if(mcData!=null && mcDataList.length!=0)
	             for (var i = 0; i < mcDataList.length; i++) {
	                 var mcId = mcDataList[i].medicalCategoryId;
	                 var mcCode = mcDataList[i].medicalCategoryCode;
	                 var mcName = mcDataList[i].medicalCategoryName;
	                 var mcFitFlag = mcDataList[i].fitFlag;
	                 
	                if(mcFitFlag=='F'){
						var finalObservationForCategory='';
						if(mcName!=""){
						 
						finalObservationForCategory+=msgForFit+" "+" Med Cat " +mcName ;
						$('#finalObservationDigi').jqteVal(finalObservationForCategory);
						$('#finalObservationMoDigi').val(finalObservationForCategory);
						
						}
	                }
	                
	             }
	         },
	         error: function(jqXHR, exception) {
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
	     
	     }
	     else{
	    	 $('#finalObservationDigi').jqteVal('');
	    	 $('#finalObservationMoDigi').val('');
	     }
	     
	 }

 
	 
	 
	  function addFamilyHistor(){
	 	  var tbl = document.getElementById('familyHistoryGrid');
	 		var sNO=0;
	    	lastRow = tbl.rows.length;
	    	i =lastRow;
	    	i++;
	 	    var aClone = $('#familyHistoryGrid>tr:last').clone(true)
	 	    aClone.find('img.ui-datepicker-trigger').remove();
	 		aClone.find(":input").val("");
	 		aClone.find("td:eq(0)").find("select:eq(0)").prop('id','illnessHistory' + i + '');
	 		aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'ageOfFather'+i+'');
	 		//aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'healthOfFatherTemp'+i+'');
	 		//aClone.find("td:eq(2)").find("input:eq(1)").prop('id', 'healthOfFather'+i+'');
	 		//aClone.find("td:eq(3)").find("input:eq(0)").prop('id', 'causeOfDeathFatherTemp'+i+'');
	 		//aClone.find("td:eq(3)").find("input:eq(1)").prop('id', 'causeOfDeathFather'+i+'');
	 		aClone.find("td:eq(4)").find("input:eq(0)").prop('id', 'dateDiedOfFather'+i+'').removeClass('noFuture_date hasDatepicker').addClass('noFuture_date ');

	 	var healthOfFather="";	 
	 	healthOfFather+='<input type="text" class="form-control" id="healthOfFatherTemp'+i+'" name="healthOfFatherTemp" onBlur="setHealthDigi(this);"/>';
	 	healthOfFather+='<input type="hidden" name="healthOfFather" id="healthOfFather'+i+'"  value="@@@###," class="form-control">';
	 	aClone.find("td:eq(2)").html(healthOfFather);
	 	var causeOfFather="";
	 	causeOfFather+='<input type="text" class="form-control" name="causeOfDeathFatherTemp" id="causeOfDeathFatherTemp'+i+'" onBlur="setCauseOfDeathDigi(this);"/>';
	 	causeOfFather+='<input type="hidden" class="form-control" name="causeOfDeathFather" id="causeOfDeathFather'+i+'" value="@@@###,"/>';
	 	aClone.find("td:eq(3)").html(causeOfFather); 
	 		
	 		aClone.find("option[selected]").removeAttr("selected");
		var	familyDetailDelete ='';
		var familyGridVal='familyHistoryGrid';
		familyDetailDelete +='<button class="btn btn-danger noMinWidth" name="delete" value="" id="newfamilyDetailDelete'+i+'" button-type="delete"  onclick="removeFamilyHistory(this,\''+ familyGridVal + '\',0);"></button>';
	 		aClone.find("td:eq(6)").html(familyDetailDelete);
	 		aClone.clone(true).appendTo('#familyHistoryGrid');
	 	} 
	  
	 
	function getFamilyDetailsHistory(){
		
	    var visitId=$('#visitId').val(); 
		var pathname = window.location.pathname;
	     var accessGroup = "MMUWeb";
	     
	     
	     var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/digifileupload/getFamilyDetailsHistory";
 
	     
	     $.ajax({
	         type: "POST",
	         contentType: "application/json",
	         url: url,
	         data: JSON.stringify({
	             'employeeId': '1',
	             'visitId':visitId
	         }),
	         dataType: 'json',
	         //timeout: 100000,

	         success: function(res)

	         {
	            var masRelationListGlobal = res.masRelationList;
	        	var  familyDetailList=res.familyDetailList;
	
	        	
	        	
				 var familyHistoryHtml="";	
	        	if(familyDetailList!=null && familyDetailList.length!=0){
	             for (var i = 0; i < familyDetailList.length; i++) {
	                 var familyId=""; 
	                 if(familyDetailList[i].familyId!=undefined && familyDetailList[i].familyId!="")
	                 familyId= familyDetailList[i].familyId;
	                 
	                 var relationId="";
	                 if(familyDetailList[i].relationId!=undefined && familyDetailList[i].relationId!="")
	                 relationId  = familyDetailList[i].relationId;
	                 var age ="";
	                 if(familyDetailList[i].age!=undefined && familyDetailList[i].age!="")
	                 age = familyDetailList[i].age;
	                 var healthOfFather ="";
	                 if(familyDetailList[i].healthOfFather!=undefined && familyDetailList[i].healthOfFather!="")
	                 healthOfFather = familyDetailList[i].healthOfFather;
	                 var causeOfDeathFather ="";
	                 if(familyDetailList[i].causeOfDeathFather!=undefined && familyDetailList[i].causeOfDeathFather!="")
	                   causeOfDeathFather = familyDetailList[i].causeOfDeathFather;
	                 var dob="";
	                 if(familyDetailList[i].dob!=undefined && familyDetailList[i].dob!="")
	                  dob = familyDetailList[i].dob;
	                
	                 
	                 
	                 familyHistoryHtml+='<tr>';
	                 familyHistoryHtml+='	<td>';		
	                 familyHistoryHtml+=' <select id="illnessHistory" name="illnessHistory" validate="Marital Status,int,no"  class="form-control">';
	                 familyHistoryHtml+='<option value="0" selected="selected">Select</option>';
	                 
	                 var illnessHistoryValues = "";
					 var selectedFamilyDetail="";
					 
					 for(masRel in masRelationListGlobal){
						 
						 if(relationId==masRelationListGlobal[masRel].relationId){
							 selectedFamilyDetail="selected";
						 }
						 else{
							 selectedFamilyDetail=""; 
						 }
						
						   if(masRelationListGlobal[masRel].relationId!="" && masRelationListGlobal[masRel].relationId!=undefined 
								   && masRelationListGlobal[masRel].relationName!="" && masRelationListGlobal[masRel].relationName!=undefined){
							 illnessHistoryValues += '<option  '+selectedFamilyDetail+' value='+masRelationListGlobal[masRel].relationId+'>'
										+ masRelationListGlobal[masRel].relationName
										+ '</option>';
						   }
						 }
					 familyHistoryHtml+=illnessHistoryValues; 
					 familyHistoryHtml+='</select>';	
	                 
	                 familyHistoryHtml+='</td>'; 
	                 familyHistoryHtml+='<td>';
				
	                 familyHistoryHtml+='<input type="text" class="form-control" id="ageOfFather" name="ageOfFather" value="'+age+'" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"/>';
	                 familyHistoryHtml+='<input type="hidden" class="form-control" id="familyId" name="familyId" value="'+familyId+'"/>';
	                 
	                 familyHistoryHtml+='</td>';
	                 familyHistoryHtml+='<td>';
	                 familyHistoryHtml+='<input type="text" class="form-control" id="healthOfFatherTemp" name="healthOfFatherTemp" value="'+healthOfFather+'" maxlength="100" onBlur="setHealthDigi(this);"/>';
	                 familyHistoryHtml+='<input type="hidden" class="form-control" id="healthOfFather" name="healthOfFather" value="@@@###'+healthOfFather+'"/>';
	                 familyHistoryHtml+='</td>';
	                 familyHistoryHtml+='<td>';
	                 familyHistoryHtml+='<input type="text" class="form-control" name="causeOfDeathFatherTemp" id="causeOfDeathFatherTemp" value="'+causeOfDeathFather+'" maxlength="100" onBlur="setCauseOfDeathDigi(this);"/>';
	                 familyHistoryHtml+='<input type="hidden" class="form-control" name="causeOfDeathFather" id="causeOfDeathFather" value="@@@###'+causeOfDeathFather+'"/>';
	                 familyHistoryHtml+='</td>';
	                 familyHistoryHtml+='<td>';
	                 familyHistoryHtml+='<div class="dateHolder">';
	                 familyHistoryHtml+='<input type="text" class="form-control input_date" name="dateDiedOfFather" id="dateDiedOfFather" value="'+dob+'"/>';
	                 familyHistoryHtml+='</div>';
	                 familyHistoryHtml+='</td>';
	                 familyHistoryHtml+='<td>';
	                 familyHistoryHtml+='<button name="Button" type="button"   class="btn btn-primary noMinWidth" button-type="add"   onclick="addFamilyHistor();" ></button>';
				 
	                 familyHistoryHtml+='</td>';
	                 var familyGridVal='familyHistoryGrid';
	                 familyHistoryHtml+='<td>';
	                 familyHistoryHtml+='<button class="btn btn-danger noMinWidth" name="delete" value="" id="deleteFamilyHistory" button-type="delete"  onclick="removeFamilyHistory(this,\''+familyGridVal+ '\',\'' + familyId + '\');"></button>';

	                 familyHistoryHtml+='</td>';
				
	                 familyHistoryHtml+='</tr>';
	             }
	            
	             $("#familyHistoryGrid tr").remove() 	
	        	
	            $('#familyHistoryGrid').append(familyHistoryHtml);
	        	}
	        	else{
	        	
	        		 var illnessHistoryValues = "";
					 for(masRel in masRelationListGlobal){
						   if(masRelationListGlobal[masRel].relationId!="" && masRelationListGlobal[masRel].relationId!=undefined 
								   && masRelationListGlobal[masRel].relationName!="" && masRelationListGlobal[masRel].relationName!=undefined){
							 illnessHistoryValues += '<option   value='+masRelationListGlobal[masRel].relationId+'>'
										+ masRelationListGlobal[masRel].relationName
										+ '</option>';
						   }
						 }
					 $('#illnessHistory').append(illnessHistoryValues); 
					
	        	}
	        	
	         },
	         error: function(jqXHR, exception) {
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
	} 
	
	
	
	function removeFamilyHistory(val,gridVal,deleteId){
		var tbl = document.getElementById('familyHistoryGrid');
		var lastRow = tbl.rows.length;
		
		var msg=resourceJSON.msgDelete;
		
		if (confirm(msg)) {
			if (gridVal == "familyHistoryGrid" && lastRow == '1') {
				return false;
			}
			$(val).closest('tr').remove();
			var flag = 0;
			if ((val.id == "deleteFamilyHistory" && gridVal == "familyHistoryGrid")) {
				if (gridVal == "familyHistoryGrid"
						&& deleteId != "" && deleteId!='0') {
					flag = 'f1001';
					deleteInvestigatRow(flag, deleteId, "", "", "");
				}
			}
		}

	}
	
	 $j('body').on("focus",".noFuture_date10", function() {
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
	   		//generateNextDate(ides);  
	   		getMedicalCategoryFinalObserb(ides);
	   	}
	   });
	 
	 
	 
	 function showIllnessOperationInjuryDisease(idSelect){
		 var selectObj = idSelect.id;
		 var selectedValue=$( "#"+selectObj+" option:selected" ).text();
		 if(selectedValue!=null && selectedValue!="" && selectedValue!="0"){
				if (selectedValue=='Yes') {
						$('#divIllnessOperationInjury').show();
				}
					else{
						$('#divIllnessOperationInjury').hide();
						 
					}
					 
				}
	 }
	 
	 function getMarkAsDiver(item){
		 var divenSectionValue=localStorage.getItem("divenSectionValue");
		
		 if (document.getElementById("markAsDiver").checked == true) { 
			 $('#markAsDivenVal').val('y');
			 $('#markDiverInvestigation').show();
			 
			 if(divenSectionValue!=null && divenSectionValue!=undefined && divenSectionValue!=""){
				 $('#markDiverInvestigationGrid').html(divenSectionValue);
			 } 
			else{
			 
		 var pathname = window.location.pathname;
			var accessGroup = "MMUWeb";
			var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/medicalexam/getTemplateInvestDataForDiver";
			$.ajax({
						url : url,
						dataType : "json",
						data : JSON.stringify({
							'employeeId' : '1',
							'visitId': $('#visitId').val(),
							'patientId': $('#patientId').val()
						}),
						contentType : "application/json",
						type : "POST",
						success : function(response) {
							console.log(response);
						   if (response.status == 1) {
							var datas = response.data;
							var drivenValueCheck=response.drivenValueCheck;
							$('#drivenValueCheck').val(drivenValueCheck);
							var trHTML = '';
							var countins=0;
							$.each(datas, function(i, item) {
										var investigationValue=item.investigationName;
										var investigationId=item.templateInvestgationId;
											
										var dgorderdtDiver="";
										if(item.dgOrderdtDiver!=null && item.dgOrderdtDiver!=undefined && item.dgOrderdtDiver!="")
											dgorderdtDiver=item.dgOrderdtDiver;
										var diverAction="";
										if(item.diverAction!=null && item.diverAction!=undefined && item.diverAction!="")
										  diverAction=item.diverAction;
										var doneOnDate="";
										if(item.doneOnDate!=null && item.doneOnDate!=undefined && item.doneOnDate!="")
										  doneOnDate=item.doneOnDate;
										var nextDueOnDate="";
										if(item.nextDueOnDate!=null && item.nextDueOnDate!=undefined && item.nextDueOnDate!="")
											  nextDueOnDate=item.nextDueOnDate;
										var lastDoneOnDate="";
										if(item.lastDoneOnDate!=null && item.lastDoneOnDate!=undefined && item.lastDoneOnDate!="")
										  lastDoneOnDate=item.lastDoneOnDate;
										var duration="";
										if(item.duration!=null && item.duration!=undefined && item.duration!="")
										  duration=item.duration;
										
										var diverOrderdtId="";
										if(item.diverOrderdtId!=null && item.diverOrderdtId!=undefined && item.diverOrderdtId!="")
											diverOrderdtId=item.diverOrderdtId;
										
										var actionDiven="";
										var checkValue="";
										if(item.diverAction!=null && item.diverAction!=undefined && item.diverAction!="")
											actionDiven=item.diverAction;
										var disableCheck="";
										if(actionDiven!=null && actionDiven=='Y' && actionDiven!=""){
											checkValue="checked";
											disableCheck="disabled";
										}
										else{
											checkValue="";
											disableCheck="";
										}
									 
									trHTML += '<tr>';	
									trHTML += '<td>';
									trHTML += '<input type="text"  readonly value="'
										+ investigationValue + '['
										+ investigationId
										+ ']" id="investigationForDriven' + countins + '"';
									trHTML += ' class="form-control border-input"   name="investigationForDriven" />';
									trHTML += '<input type="hidden"  name="investigationIdValueForDriven" value="'
										+ investigationId +'"  id="investigationIdValueForDriven' + investigationId + '"/>';
								
									trHTML += '<input type="hidden"  name="dgOrderdtDriven" value="'+dgorderdtDiver+'"  id="dgOrderdtDriven'+countins+'"/>';
									trHTML += '<input type="hidden"  name="diverOrderdtId" value="'+diverOrderdtId+'"  id="diverOrderdtId'+countins+'"/>';
									trHTML += '  </td>';
									
									
									trHTML +=' <td>';
									trHTML +='<div class="dateHolder">';
									trHTML +=' <input   class="form-control noFuture_date" id="lastDoneOnDate'+countins+'" name="lastDoneOnDate"';
									trHTML +='placeholder="DD/MM/YYYY" value="'+lastDoneOnDate+'" maxlength="10" /> ';
									trHTML +='</div> ';
									trHTML +='</td>';
					
									trHTML +='<td>';
									trHTML +='<div class="dateHolder">';
									trHTML +=' <input  class="form-control noFuture_dateDiven6"  type="text" id="doneOnDate'+countins+'" name="doneOnDate"   ';
									trHTML +='	placeholder="DD/MM/YYYY" value="'+doneOnDate+'" maxlength="10"   /> ';
									trHTML +='	</div> ';
									trHTML +='</td>';
									var selectedValue="";
									var duration1="";
									var duration2="";
									var duration3="";
									var duration4="";
									var duration5="";
									
									if(duration!=null && duration!=undefined && duration!=""){
										if(duration=='1'){
											duration1="selected"
										}else{
											duration1="";
										}
										if(duration=='2'){
											duration2="selected"
										}else{
											duration2="";
										}
										if(duration=='3'){
											duration3="selected"
										}else{
											duration3="";
										}
										if(duration=='4'){
											duration4="selected"
										}else{
											duration4="";
										}
										if(duration=='5'){
											duration5="selected"
										}else{
											duration5="";
										}
									}
									trHTML +='<td>';
									
									trHTML+='<select class="form-control" name="durationDivenr" id="durationDivenr'+countins+'" onChange="return generateNextDateForDiven(this);">';
									trHTML+='<option value="0">Select</option>';
									trHTML+='<option '+duration1+' value="1">1</option>';
									trHTML+='<option '+duration2+' value="2">2</option>';
									trHTML+='<option '+duration3+' value="3">3</option>';
									trHTML+='<option '+duration4+' value="4">4</option>';
									trHTML+='<option '+duration5+' value="5">5</option>';
									//trHTML +=' <input type="text" id="durationDivenr'+countins+'" name="durationDivenr" class="form-control" ';
									//trHTML +=' value="'+duration+'" maxlength="10" /> ';
									trHTML +='</select>';
									trHTML +='</td>';
									
									trHTML +='<td>';
									trHTML +='<div class="dateHolder">';
									trHTML +=' <input class="form-control calDate" type="text" id="nextDueOnDate'+countins+'" name="nextDueOnDate"';
									trHTML +='	placeholder="DD/MM/YYYY" value="'+nextDueOnDate+'" maxlength="10" /> ';
									trHTML +='	</div> ';
									trHTML +='</td>';
									
									trHTML +='<td>';
									trHTML +='<div class="form-check form-check-inline cusCheck m-l-10">';
									trHTML +=' <input '+checkValue+'  class="form-check-input position-static" type="checkbox"  name="actionDiver" id="actionDiver'+countins+'" onClick="return getVDivenValue(this);" > <span class="cus-checkbtn"></span> ';
									trHTML +='</div>';
									trHTML +='</td>';
									
									/*trHTML +='<td>';
									var investigationGridValidate="markDiverInvestigationGrid";
									investigationData +='<button type="button"  name="delete" value="" id="deleteDiven"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" onclick="removeRowInvestigationMe(this,\'' + investigationGridValidate + '\',\''+ dgorderdtDiver + '\');"></button>';
									trHTML +='</td>';*/
									trHTML += ' </tr> ';
									count++;
									countins++;
							});
							$('#markDiverInvestigationGrid').html(trHTML);
							localStorage.setItem("divenSectionValue",trHTML);
						   }
						    
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
		 }
		 else{
			 $('#markDiverInvestigation').hide();
			 $('#markAsDivenVal').val('n');
		 }
	 }
	 
	 function getVDivenValue(item){
		 var checkedIdValue=$('#drivenValueCheck').val();
		 var deleteDivenInves=$('#drivenDeleteInvestigation').val();
		 var checkedboxId=$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
		 var investigationId=$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val();
		  var dgorderDt=$(item).closest('tr').find("td:eq(0)").find("input:eq(2)").val();
		  var diverOrderDetIdA="";
		  var diverOrderDetId="";
		  var aarrrdiverOrderDetId="";
		  if(dgorderDt=="" || dgorderDt==null || dgorderDt==undefined){
			  dgorderDt=0;
		  }
		  var diverOrderDetIdA=$(item).closest('tr').find("td:eq(0)").find("input:eq(3)").val();
		  if(diverOrderDetIdA=="" || diverOrderDetIdA==null || diverOrderDetIdA==undefined){
			  diverOrderDetId=0;
		  }
		  else{
			  aarrrdiverOrderDetId =diverOrderDetIdA.split("##");
			  diverOrderDetId=aarrrdiverOrderDetId[1].trim();
		  }
		 if (document.getElementById(checkedboxId).checked == true) {
			 
			 if(checkedIdValue.includes(diverOrderDetId)){
				 checkedIdValue=checkedIdValue.replace(diverOrderDetId,"0,");
			 }
			 
			 	checkedIdValue+=investigationId+"##"+dgorderDt+"##"+diverOrderDetId+",";
			 	
			 	if(deleteDivenInves.includes(dgorderDt)){
			 		deleteDivenInves=deleteDivenInves.replace(dgorderDt,"0,");
			 } 	
		 }
		 else{
			if(checkedIdValue.includes(investigationId)){
				checkedIdValue=checkedIdValue.replace(investigationId,"0,");
		 }
			if(dgorderDt!="" && dgorderDt!=undefined && dgorderDt!=null){
				deleteDivenInves+=""+dgorderDt+",";
			}
			
			
		 }
		 $('#drivenValueCheck').val(checkedIdValue);
		 $('#drivenDeleteInvestigation').val(deleteDivenInves);
	 }
	 
	 $j('body').on("focus",".noFuture_dateDiven6", function() {
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
			yearRange: '-100:+0',
			//maxDate: new Date(),
			onSelect: function(dateText) {
		      display(this);
		      $(this).change();
		    }
	   	 }).on("change", function() {
	 	    display("Change event");  
	   	 });
	   	function display(ides) {
	   		generateNextDateForDiven(ides);  
	   	}
	   });
	 
	 
	 function generateNextDateForDiven(item) {
		 
		  var carrentDateIdValue=$(item).closest('tr').find("td:eq(2)").find("input:eq(0)").val();
		  var durationValue=$(item).closest('tr').find("td:eq(3)").find("select:eq(0)").val();
		  var nextCategoryDateId=$(item).closest('tr').find("td:eq(4)").find("input:eq(0)").attr("id");
		  if(carrentDateIdValue==null || carrentDateIdValue==""){
				return false;
		  	}
		 
		var currentDateVal=carrentDateIdValue.split("/");
		var date=currentDateVal[0];
		var month=currentDateVal[1];
		var year=currentDateVal[2];
		if(durationValue==null || durationValue==""){
			alert("Please enter  duration");
			return false;
		}
		
		var monthNew ="";	
		 
	//monthNew =parseInt(month)+parseInt(durationValue);
		var yearNew ="";	
	var durationarray="";
	var durationValueTemp="";
	var monthFromDura="";
		if(durationValue.includes(".")){
			durationarray=durationValue.split(".");
			durationValueTemp=durationarray[0];
			monthFromDura=durationarray[1];
		}
		else{
			durationValueTemp=durationValue;
		}
		year =parseInt(year)+parseInt(durationValueTemp);
		var dateNext="";
	var yearNew;
	var remMonthNew;
	var  coYearNew;
	/*if(monthNew>12){
		   var remMonthNew= parseInt(monthNew)%12;
		  var  coYearNew= parseInt(monthNew)/12;
		   coYearNew=  Math.floor(parseInt(coYearNew));
		   year=parseInt(year)+parseInt(coYearNew);
		   
		   if(date!=null && date!="" && date.toString().length==1)
		     {
		    	 date="0"+date;
		     }
		     if(remMonthNew!=null && remMonthNew!="" && remMonthNew.toString().length==1){
		    	 remMonthNew="0"+remMonthNew;
		     }
		   
		   
		   dateNext=date+"/"+remMonthNew+"/"+year;
		}
		else{
			
			 if(date!=null && date!="" && date.toString().length==1)
		     {
		    	 date="0"+date;
		     }
		     if(monthNew!=null && monthNew!="" && monthNew.toString().length==1){
		    	 monthNew="0"+monthNew;
		     }
		   
			 dateNext=date+"/"+monthNew+"/"+year;
		}*/
		 if(date!=null && date!="" && date.toString().length==1)
	    {
	   	 date="0"+date;
	    }
	    if(month!=null && month!="" && month.toString().length==1){
	   	 month="0"+month;
	    }
	  if(monthFromDura!=""){
		  var monthNew=parseInt(monthFromDura)+parseInt(month);
		  if(monthNew>12){
		   var  coYearNew= parseInt(monthNew)/12;
		   year=parseInt(year)+parseInt(coYearNew);
		   var remMonthNew= parseInt(monthNew)%12;
		   month=parseInt(remMonthNew);
		   if(month!=null && month!="" && month.toString().length==1){
		    	 month="0"+month;
		     }
		    
		  }
		  else{
			  month=parseInt(monthNew);  
			  if(month!=null && month!="" && month.toString().length==1){
			    	 month="0"+month;
			     }
		  }
		   
	  }
		 dateNext=date+"/"+month+"/"+year;
		
		/*
		 * used for Date Comparision next due date
		 *  var currentItemId= $(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val();
		  var countForImmunization=0;
			$('#immunisationStatusGrid tr').each(function(i, el) {

				var itemIdVals = $(this).find("td:eq(0)").find("input:eq(1)").val();
				var oldNextDueDate=$(this).closest('tr').find("td:eq(3)").find("input:eq(0)").val();
				if(currentItemId==itemIdVals){
						var countDateVal=getDateComapareImmu(oldNextDueDate,dateNext)
						if(countDateVal>0){
							countForImmunization=+1; 
						}
				}
		 	});
		  
			if(countForImmunization>0){
				alert("Immunization is already given.");
				return false
			}*/
			
		 
		$('#'+nextCategoryDateId).val(dateNext);
		//$('#'+nextCategoryDateId).attr('readonly', true); 
		}

	 