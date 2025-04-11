/**
 * 
 */


 /*function getCompleteMedicalExam(flag){
	 var patientId =$('#patientId').val();
	 	var visitId = $('#visitId').val();
	 	 
	 	var params = {
	 			"patientId": patientId,
	 			"visitId":visitId
	 	}
	 	$.ajax({
	 		type : "POST",
	 		contentType : "application/json",
	 		url : 'getMedicalExamListCommon',
	 		data : JSON.stringify(params),
	 		dataType : "json",
	 		//cache : false,
	 		success : function(response) {
	 			var data = response.data;
	 			$('#checkForAuthenticationValue').val(data);
	 			return ;
	 		}
	 	});
 }*/


function getPatientImmunizationHistory(MODE,className)
{

	var visitId = $('#visitId').val();
	var patientId=$('#patientId').val();
	
//$('#ImmunizationHistoryModal').show();
	//$(".modal-backdrop").show();
	 if(MODE == 'ALL'){
		 
			var data = {'pageNo':nPageNo,'visitId' : visitId,"patientId":patientId,"flagForForm":'h'};			
		}
	else
		{
			var data =  {'pageNo':nPageNo, 'visitId':visitId,"patientId":patientId,"flagForForm":'h'}; 
		} 
	    var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/medicalexam/getImmunisationHistory";  
	//var url = "getImmunisationHistory";
	var bClickable = true;
	GetJsonDataForCommon('tblListOfCommand',data,url,bClickable,"waitingImgId",className,'immunizationHistoryGrid','resultnavigationMasDesignation');
}


function makeTableCommon(jsonData,flagCheck)
{
	 if(flagCheck=="previouseMedicalExamGrid"){
		 var listVisit = jsonData.data;
		 makeGridForPreviousMedExam(listVisit);
		
	 }
	 if(flagCheck=="immunizationHistoryGrid"){
		 var listVisit = jsonData.listMasStoreItem;
		 makeImmunizationHistoryGrid(listVisit);
		
	 }
		if(flagCheck=="currentMedicationGrid"){
			var  data = jsonData.listObject;
			var count  = jsonData.count;		
			 	frequencyList = jsonData.MasFrequencyList;
			 	 
			var itemStopByUserName ="Stop By ";
			 showCurrentMedication(data,frequencyList,itemStopByUserName,count);
			 }
		
		
		 if(flagCheck=="allergyHistoryGrid"){
			 var listAllergy = jsonData.listAllergyHistory;
			 makeAllergyHistoryGrid(listAllergy);
			
		 }
		 if(flagCheck=="tblListofOpdPreviousPopUpLab"){
		 		makeGridForPreviousLab(jsonData);
		 	 }
		 if(flagCheck=="tblListofOpdPreviousPopUpRadio"){
		 		makeGridForPreviousRadio(jsonData);
		 	 }
		 if(flagCheck=="tblListofOpdPreviousVital"){
		 		makeGridForPreviousVital(jsonData);
		 	 }
		 if(flagCheck=="tblListofOpdPreviousVitalHospital"){
			 makeGridForPreviousVitalHospital(jsonData);
		 	 }
		 if(flagCheck=="tblListofOpdPrevious"){
		 		makeGridForPreviousVisit(jsonData);
		 	 }
		
		 if(flagCheck=="recommendedDiagnosis"){
				var  data = jsonData.data;
				showRecommendedDiagnosis(data);
			}
		 if(flagCheck=="recommendedInvestgation"){
				var  data = jsonData.data;
				showRecommendedInvestgation(data);
			}
		 if(flagCheck=="recommendedTreatment"){
				var  data = jsonData.data;
				showRecommendedTreatment(data);
			}
		 if(flagCheck=="modelForDoctorRemarksGrid"){
				var  data = jsonData.data;
				showDoctorRemarksSelect(data);
			}
		 if(flagCheck=="recommendedDiagnosisRecall"){
				var  data = jsonData.data;
				showRecommendedDiagnosisRecall(data);
			}
		 if(flagCheck=="recommendedInvestgationRecall"){
				var  data = jsonData.data;
				showRecommendedInvestgationRecall(data);
			}
		 if(flagCheck=="recommendedTreatmentRecall"){
				var  data = jsonData.data;
				showRecommendedTreatmentRecall(data);
			}
		if(flagCheck=="invoiceMMUHistoryGrid"){
		 var listInvoice = jsonData.data;
		 makeTableForInvoidDetal(listInvoice);
		
	 } 
}


function showResultPage(pageNo,flagCheck)
{
	nPageNo = pageNo;	
	if(flagCheck=="previouseMedicalExamGrid"){
		getCompleteMedicalExamMEOrMB('FILTER',"SearchStatusForUnitAdmin");
	}
	if(flagCheck=="immunizationHistoryGrid"){
		getPatientImmunizationHistory('FILTER',"SearchStatusForMassDesignation");
	}
	if(flagCheck=="currentMedicationGrid"){
		showAllCurrentMedication('FILTER',"SearchStatusForUnitAdminCurrentMedication");
	}
	if(flagCheck=="allergyHistoryGrid"){
		makeAllergyHistoryGrid('FILTER',"SearchStatusForMassDesignation");
	}
	if(flagCheck=="recommendedDiagnosis"){
		showRecommendedDiagnosis('FILTER',"SearchStatusForUnitAdminCurrentMedication");
	}
	if(flagCheck=="recommendedInvestgation"){
		showRecommendedInvestgation('FILTER',"SearchStatusForUnitAdminCurrentMedication");
	}
	if(flagCheck=="recommendedTreatment"){
		showRecommendedInvestgation('FILTER',"SearchStatusForUnitAdminCurrentMedication");
	}
	if(flagCheck=="modelForDoctorRemarksGrid"){
		showDoctorRemarksSelect('FILTER',"SearchStatusForUnitAdminCurrentMedication");
	}
	if(flagCheck=="recommendedDiagnosisRecall"){
		showRecommendedDiagnosis('FILTER',"SearchStatusForUnitAdminCurrentMedication");
	}
	if(flagCheck=="recommendedInvestgationRecall"){
		showRecommendedInvestgationRecall('FILTER',"SearchStatusForUnitAdminCurrentMedication");
	}
	if(flagCheck=="recommendedTreatmentRecall"){
		showRecommendedInvestgationRecall('FILTER',"SearchStatusForUnitAdminCurrentMedication");
	}
	if(flagCheck=="invoiceMMUHistoryGrid"){
		getInvoiceAllDetail('FILTER',"SearchStatusForInvoiceMMU");
	}
}
function makeGridForPreviousMedExam(dataList){
	var htmlTable="";
	var medicalExamId="";
	var meTypeCode="";
	var rankName="";
	var medicalCategory="";
	if(dataList!=null){
	for(i=0;i<dataList.length;i++)
	{
		medicalExamId=dataList[i].medicalExamId;
		meTypeCode=dataList[i].meTypeCode;
		if(dataList[i].rankName!=null && dataList[i].rankName!=undefined){
			rankName=dataList[i].rankName;
		}else{
			rankName="";
		}
		if(dataList[i].medicalCategory!=null && dataList[i].medicalCategory!=undefined && dataList[i].medicalCategory!=""){
			medicalCategory=dataList[i].medicalCategory;
		}
		else{
			medicalCategory="";
		}
		htmlTable = htmlTable+"<tr id='"+dataList[i].visitId+"' >";	
	 
		htmlTable = htmlTable +"<td style='display:none;'>"+dataList[i].patientId+"</td>";
		/*htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].tokenNo+"</td>";*/
	/*	htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].serviceNo+"</td>";
		htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].patientName+"</td>";*/
		htmlTable = htmlTable +"<td style='width: 100px;'>"+rankName+"</td>";
		htmlTable = htmlTable +"<td style='width: 100px;'>"+medicalCategory+"</td>";
	/*	htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].age+"</td>";
		htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].gender+"</td>";	*/		
		htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].meTypeName+"</td>";
		
		/*htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].status+"</td>";
		htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].status+"</td>";*/
		htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].medicalExamDate+"</td>";
		var viewOrEditFlag='no@@meView';
		if(dataList[i].status!="" && (dataList[i].status=='Verified'||dataList[i].status=='Approved') && (dataList[i].showViewAndReport!="" && dataList[i].showViewAndReport=='yes')){
			htmlTable = htmlTable + "<td style='width: 100px;'><button class='btn btn-primary' data-toggle='modal' data-target='#exampleModal3' onclick='previousMedicalExamOpen(\""+ dataList[i].visitId+ "\",\""+ dataList[i].age+ "\",\""+ dataList[i].meTypeCode+"\",\""+viewOrEditFlag+"\");'>View</button></td>";
			 
		}
		else if(meTypeCode.includes("MB")){
			var previousMedicalExamReportId="previouseMedicalBoardReport"+dataList[i].visitId;
			htmlTable = htmlTable + "<td style='width: 100px;'><button id ='previouseMedicalBoardReport"+dataList[i].visitId+"' type='button'  class='btn btn-primary' data-toggle='modal' data-target='#exampleModal3'  data-backdrop='static' onclick='getReportForMb(\""+ dataList[i].visitId+ "\",\""+ meTypeCode+ "\",\""+ previousMedicalExamReportId+ "\");'>Report</button></td>";
		}
		else{
			var previouseMedicalExamReport="previouseMedicalExamReport"+dataList[i].visitId;
			htmlTable = htmlTable + "<td style='width: 100px;'><button  id ='previouseMedicalExamReport"+dataList[i].visitId+"' type='button'  class='btn btn-primary' data-toggle='modal' data-target='#exampleModal3'  data-backdrop='static' onclick='getReportForMe(\""+ medicalExamId+ "\",\""+ meTypeCode+ "\",\""+ previouseMedicalExamReport+ "\");'>Report</button></td>";
		}
		 
		htmlTable = htmlTable +' value=""  ';
		htmlTable = htmlTable +'	tabindex="1" ></td>';

		htmlTable = htmlTable+"</tr>";
			 
			}
	}
	else{
		htmlTable = htmlTable+"<tr ><td colspan='8'><h6>No Record Found</h6></td></tr>";
	}
	$('#previouseMedicalExamGrid').html(htmlTable);
		
}


function previousMedicalExamOpen(visitId,age,meTypeCode,viewOrEditFlag){
	var newEntryStatus='no';
	var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/digifileupload/mbMembersAFMSForm?visitId=";
	var  popup = window.open(url+visitId+ "&age=" + age+"&examTypeId="+meTypeCode+"&viewOrEditFlag="+viewOrEditFlag+"&newEntryStatus="+newEntryStatus, "popUpWindow", "height=500,width=800,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
	     popup.focus();
	
	/* window.location.href = "mbMembersAFMSForm?visitId=" + visitId
		+ "&age=" + age+"&examTypeId="+meTypeCode+"&viewOrEditFlag="+viewOrEditFlag;*/
	
}




function makeImmunizationHistoryGrid(dataList){
	var approvalFlagVal="";
	try{
	approvalFlagVal=$('#approvalFlag').val();
	if(approvalFlagVal!="" && approvalFlagVal!=undefined && approvalFlagVal!=null && approvalFlagVal=='y'){
		//$("#saveImmunizationHistoryForCommon").attr("disabled", true);
		$("#saveImmunizationHistoryForCommon").attr("disabled","disabled");
	}
	else{
		$("#saveImmunizationHistoryForCommon").attr("disabled",false);
	}
	}
	catch(e){}
	var htmlTable="";
	var immmunisationHtml="";
	if(dataList!=null){
		var countImu=786;
	for(i=0;i<dataList.length;i++)
	{
		/*htmlTable = htmlTable+"<tr id='"+dataList[i].itemId+"' >";	
	 
		htmlTable = htmlTable +"<td style='width: 150px; '>"+dataList[i].itemCode+ '[' + dataList[i].pvmsNo + ']'+"</td>";
		htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].prescriptionDateValue+"</td>";
		htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].immunizationDate+"</td>";
		htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].duration+"</td>";
		htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].immunizationNextDateValue+"</td>";
		htmlTable = htmlTable+"</tr>";*/
		var approvalFlagDiasable='disabled';
		
		var  func1='populateMasStoreItemForTem';
		 var  url1='opd';
		  var url2='getMasStoreItemList';
		  var flaga='immunizationFlagForTem';
		   
		immmunisationHtml += '<tr>';
		 immmunisationHtml+='<td> <div class="form-group autocomplete forTableResp">';
		 immmunisationHtml+='<input type="text" autocomplete="never" class="form-control border-input" readonly="readonly" name="immunisatioName" id="immunisatioName'+dataList[i].itemId+'" value="'+dataList[i].itemCode+ '[' + dataList[i].pvmsNo  + ']'+'"     onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"  '+approvalFlagDiasable+'/>';
		 
		 immmunisationHtml += '<input type="hidden"  name="immunisationId" value="'
				+ dataList[i].itemId  +'"  id="immunisationId' + dataList[i].itemId + '"/>';

		 immmunisationHtml += '<input type="hidden"  name="pvmsNumber" value="'
				+ dataList[i].pvmsNo  +'"  id="pvmsNumber' + dataList[i].pvmsNo + '"/>';
		 
		 immmunisationHtml += '<input type="hidden"  name="patientImmunizationHisId" value="'
				+ dataList[i].immunizationId  +'"  id="patientImmunizationHisId' + dataList[i].immunizationId + '"/>';
		 immmunisationHtml += '<div id="immunizationDiv'+i+'" class="autocomplete-itemsNew"></div>';

		 immmunisationHtml+='</div></td>';
 		 
		  
		 
		 var immunizationDateValue="";
		 if(dataList[i].immunizationDate!=""){
			 immunizationDateValue= dataList[i].immunizationDate;
		 }
		 else{
			 immunizationDateValue="";
		 }
		 immmunisationHtml+='<td>';
		 immmunisationHtml+='<div class="dateHolder">';
		 immmunisationHtml+='<input class="form-control noFuture_date6" name="immnunizationDate" id="immnunizationDate'+countImu+'" value="'+immunizationDateValue+'" />';
		 immmunisationHtml+='</div>';
		 immmunisationHtml+='</td>';
		
		 
		 var immunisationName="";
		 var durationImmu="";
		 var readOnlyDuration="";
		 var diasableValue="";
		 if(dataList[i].itemCode!="" && (dataList[i].itemCode.includes('Tetanus')|| dataList[i].itemCode.includes('Tetanus'))){
			 immunisationName='immunisationDateTab';
			 if(dataList[i].duration!=null && dataList[i].duration!="" && dataList[i].duration!=undefined)
				 {
				 durationImmu=dataList[i].duration;
				 if(dataList[i].itemCode.includes('Tetanus')|| dataList[i].itemCode.includes('Tetanus')){
					 readOnlyDuration="readonly";
					 diasableValue="disabled";
				 }
				 else{
					 readOnlyDuration=""; 
					 diasableValue="";
				 }
				 
				 }
			 else{
				 if(dataList[i].itemCode.includes('Tetanus')|| dataList[i].itemCode.includes('Tetanus')){
					 durationImmu='5';
				 readOnlyDuration="readonly";
				 diasableValue="disabled";
				 }
				 else{
					 durationImmu="";
					 readOnlyDuration=""; 
					 diasableValue="";
				 }
			 }
			 }
		 else{
			 immunisationName='immunisationDateTT';
			 if(dataList[i].duration!=null && dataList[i].duration!="" && dataList[i].duration!=undefined)
			 {
			 durationImmu=dataList[i].duration;
			 if(dataList[i].itemCode.includes('Injectable Typhoid Vaccine')|| dataList[i].itemCode.includes('Injectable Typhoid Vaccine')){
				 readOnlyDuration="readonly";
				 diasableValue="disabled";
			 }
			 else{
				 readOnlyDuration=""; 
				 diasableValue="";
			 }
			  
			 }
		 else{
			 if(dataList[i].itemCode.includes('Injectable Typhoid Vaccine')|| dataList[i].itemCode.includes('Injectable Typhoid Vaccine')){
				 durationImmu='3';
				 readOnlyDuration="readonly";
				 diasableValue="disabled";
			 }
			 else{
				 durationImmu="";
				 readOnlyDuration=""; 
				 diasableValue="";
			 }
		 	}
		 }
		 
		 
		 
		 immmunisationHtml+='<td>';
		 immmunisationHtml+=' <input type="text" name="durationImmu"  id="durationImmu'+countImu+'" value="'+durationImmu+'" onblur="return generateNextDateForImmun(this);" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" class="form-control" '+readOnlyDuration+'/> ';
		 immmunisationHtml+='</td>';
         
		 var immunizationNextDueImmuDateValue="";
		 if(dataList[i].immunizationDate!="" && dataList[i].immunizationNextDateValue!=undefined){
			 immunizationNextDueImmuDateValue= dataList[i].immunizationNextDateValue;
		 }
		 else{
			 immunizationNextDueImmuDateValue="";
		 }
		 
		 immmunisationHtml+='<td>';
		 immmunisationHtml+='   <div class="dateHolder">';
		 immmunisationHtml+=' <input type="text" id="nextDueImmu'+countImu+'"  name="nextDueImmu" class="form-control" placeholder="DD/MM/YYYY" value="'+immunizationNextDueImmuDateValue+'" maxlength="10" readonly />';
		 immmunisationHtml+=' </div>';
		 immmunisationHtml+='  </td>';
		 
		 var prescriptionDateValue="";
		 if(dataList[i].prescriptionDateValue!="" && dataList[i].prescriptionDateValue!=undefined && dataList[i].prescriptionDateValue!=null){
			 prescriptionDateValue= dataList[i].prescriptionDateValue;
		 }
		 else{
			 prescriptionDateValue="";
		 }
		 immmunisationHtml+='<td>';
		 immmunisationHtml+='<div class="dateHolder">';
		 immmunisationHtml+='<input class="form-control noFuture_date" name="prescriptionDate" id="prescriptionDate'+countImu+'"    value="'+prescriptionDateValue+'" />';
		 immmunisationHtml+='</div>';
		 immmunisationHtml+='</td>';
		
		 
		 
		 immmunisationHtml+=' <td><button name="Button"   type="button" class="buttonAdd btn btn-primary noMinWidth" button-type="add" onClick="return addImmunisationStatusForHistory();"> </button></td>';
		 //immmunisationHtml+='	<td><button name="Button" type="button" class="buttonAdd btn btn-danger noMinWidth" id="immunizationDelete" button-type="delete"  onClick="return removeRowImmunization(this);" '+approvalFlagDiasable+'> </button></td>';
		 
		 var immunizationId="";
			if(dataList[i].immunizationId!="" &&  dataList[i].immunizationId!=undefined && dataList[i].immunizationId!=null){
				immunizationId=dataList[i].immunizationId;
			}
			var immunisationStatusGrid='immunizationHistoryGrid';
			
			 immmunisationHtml+='	<td><button name="Button" type="button" class="buttonAdd btn btn-danger noMinWidth" id="immunizationDelete" button-type="delete" '+diasableValue+' onClick="return removeRowInvestigationMe(this,\'' + immunisationStatusGrid + '\',\''+ immunizationId + '\');"> </button></td>';
		
		 immmunisationHtml += '</tr>';
		 countImu++;
			}
	}
	else{
		immmunisationHtml = immmunisationHtml+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
	}
	
	
		$('#immunizationHistoryGrid').html(immmunisationHtml);
}
 	

function getDateComapareImmuni(fromDate,toDate){
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
	    if (g2.getTime() > g1.getTime()){
	    	 
	    	countDateV+=1;
	    	return countDateV;
	    }
	    return countDateV;
}

 
function saveImmunizationHistory(){
 	var itemIdsVal='';
 	var pvmsVal="";
 	var patientImmuzationId="";
 	var presceriptionDate="";
 	var immunizationDate="";
 	var duration="";
 	var nextDueDate="";

 	var itemIdsValArray = [];
 	var pvmsValArray=[];
 	var patientImmuzationIdArray = [];
 	var presceriptionDateArray=[];

 	var immunizationDateArray=[];
 	var durationArray = [];
 	var nextDueDateArray=[];
 	var userId="";
 	var patientId="";
 	var visitId="";
 	visitId=$('#visitId').val();
 if(visitId=="" && visitId==undefined){
 		visitId=$('#visitID').val();
 	}
 	patientId=	$('#patientId').val();
 	userId=	$('#userId').val();
 	var countDgInves=0;
 	var cuntForImmun=0;
 	$('#immunizationHistoryGrid tr').each(function(i, el) {
 		itemIdsVal= $(this).find("td:eq(0)").find("input:eq(1)").val();
 		pvmsVal= $(this).find("td:eq(0)").find("input:eq(2)").val();
 		patientImmuzationId= $(this).find("td:eq(0)").find("input:eq(3)").val();
 		presceriptionDate= $(this).find("td:eq(4)").find("input:eq(0)").val();
 		immunizationDate= $(this).find("td:eq(1)").find("input:eq(0)").val();
 		duration= $(this).find("td:eq(2)").find("input:eq(0)").val();
 		nextDueDate= $(this).find("td:eq(3)").find("input:eq(0)").val();

 		if(itemIdsVal!="" && itemIdsVal!=undefined){
 			itemIdsValArray.push(itemIdsVal);
 		}
 		else{
 			itemIdsVal='0';
 			itemIdsValArray.push(itemIdsVal);
 			alert("Please enter Immunization Name.");
      		countDgInves+=1;
 		}
 		if(pvmsVal!="" && pvmsVal!=undefined){
 			pvmsValArray.push(pvmsVal);
 		}
 		else{
 			pvmsVal='0';
 			pvmsValArray.push(pvmsVal);
 		}
 		
 		
 		if(patientImmuzationId!="" && patientImmuzationId!=undefined){
 			patientImmuzationIdArray.push(patientImmuzationId);
 		}
 		else{
 			patientImmuzationId='0';
 			patientImmuzationIdArray.push(patientImmuzationId);
 		}
 		
 		
 		if(immunizationDate!="" && immunizationDate!=undefined){
 			immunizationDateArray.push(immunizationDate);
 		}
 		else{
 			immunizationDate='0';
 			immunizationDateArray.push(immunizationDate);
 			alert("Please enter Immunization Date.");
      		countDgInves+=1;
 		}
 		
 		if(duration!="" && duration!=undefined && duration!=0){
 			durationArray.push(duration);
 		}
 		else{
 			duration='0';
 			durationArray.push(duration);
 			alert("Please enter Duration.");
      		countDgInves+=1;
 		}
 		
 		if(nextDueDate!="" && nextDueDate!=undefined){
 			nextDueDateArray.push(nextDueDate);
 		}
 		else{
 			nextDueDate='0';
 			nextDueDateArray.push(nextDueDate);
 			alert("Please enter Next Due Date.");
      		countDgInves+=1;
 		}

 		if(presceriptionDate!="" && presceriptionDate!=undefined){
 			presceriptionDateArray.push(presceriptionDate);
 		}
 		else{
 			presceriptionDate='0';
 			presceriptionDateArray.push(presceriptionDate);
 			if(immunizationDate=="" && immunizationDate==undefined){
 			alert("Please enter PresceriptionDate Date.");
      		countDgInves+=1;
 			}
 		}
 		
 		
 		  cuntForImmun=getDateComapareImmuni(immunizationDate,presceriptionDate);
 		  if(cuntForImmun!=0){
 			 alert("Precription date should not be greater then Immunization Date.");
 			countDgInves+=1;
 		  }
 		
 	});
	
	 
/*	var formData1 = $('#patientImmunizzationHistorySubmit')[1];
	 var formData = new FormData(formData1);
*/	
 	 if(countDgInves==0){
 		$("#saveImmunizationHistoryForCommon").attr("disabled", "disabled");
 	var params = {
			"itemIdsValArray":itemIdsValArray,
			"pvmsValArray":pvmsValArray,
			"patientImmuzationIdArray":patientImmuzationIdArray,
			"presceriptionDateArray":presceriptionDateArray,
			"immunizationDateArray":immunizationDateArray,
			"durationArray":durationArray,
			"nextDueDateArray":nextDueDateArray,
			 "userId":userId,
			 "patientId":patientId,
			 "visitId":visitId,
 	} 	
 	var pathname = window.location.pathname;
	 	var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/medicalexam/submitPatientImmunizationHistory";
	 
	$.ajax({
		type : 'POST',
		url : url,
		data : JSON.stringify(params),
        contentType : "application/json",
		dataType : "json",
		success : function(response) {
			if(response.status==1){
				
				alert("Immunization updated Successfully"+'S');
				
				document.getElementById("closeBtn").addEventListener("click", function(){
					getPatientImmunizationHistory('ALL','SearchStatusForMassDesignation');
					$("#saveImmunizationHistoryForCommon").attr("disabled", false);
				});
			}
			else{
				alert("Something is wrong");
				$("#saveImmunizationHistoryForCommon").attr("disabled", false);
			}
		
		}
	});
	
}
}

function closeMe(){
	$('#previousMedicalExamModelId').hide();
	$('.modal-backdrop').hide();
}
 
function closeMeImmH(){
	$('#ImmunizationHistoryModal').hide();
	$('.modal-backdrop').hide();
}

var  subTypeList="";
function openExamSubType(appTypeId){
	/* document.getElementById("examTypeId").options.length = 1;
	 if($("#tdME").prop('checked') == true){*/
	var pathname = window.location.pathname;
 	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/registration/getExamSubType";
		 var params = {
					"appTypeId":appTypeId
				 } 	
					$j.ajax({
						type : "POST",
						contentType : "application/json",
						url : url,
						data : JSON.stringify(params),
						dataType : "json",
						cache : false,
						success : function(response) {
							if(response.status=="1"){
								   subTypeList = response.masExamList;
								var  appType = response.appTypeId;
								var examValues='';
								/*examValues +='<option value="0">Select</option>';*/
								for(exam in subTypeList){
									 examValues += '<option value='+subTypeList[exam].examId+'>'
													+ subTypeList[exam].examName
													+ '</option>';
								 }
									$j('#examTypeId').append(examValues); 
							}else{
								//alert("No ME type available.")
								//$("#tdME").prop("checked", false);
							}
					},
						error : function(msg) {
							alert("An error has occurred while contacting the server");
						}
				    
				}); 
		/*}else{
			document.getElementById("examTypeId").options.length = 1;
			$j('#showMEToken').empty();	
			$j('#examDiv').hide();
	 }*/
				
}


function getReportForMe(medicalExamId,examCode,idVal){

	var meForm3B=resourceJSON.meForm3B;
	var meForm18=resourceJSON.meForm18;
	
	var meForm3A=resourceJSON.meForm3A;
	var mbForm15=resourceJSON.mbForm15;
	var mbForm16=resourceJSON.mbForm16;
	var meForm2A=resourceJSON.meForm2A;
	
	if(meForm3B==examCode){
	$('#medicalEXamReportId').show();
	$('#visit_id3b').val(medicalExamId);
 	 //document.getElementById('medicalExamReportReportId').submit();
	 var url=pageContaxValue+"/report/medicalExamReportReport?visit_id="+medicalExamId;
	 //$('#urlForReport').val(url);
	 openPdfModel(url) ;
	}
	if(meForm18==examCode){
		$('#medicalEXamReportId').show();
		$('#visit_id18').val(medicalExamId);
	 	 //document.getElementById('medicalExamReportReportId18').submit();
		 var url=pageContaxValue+"/report/medicalExamReportReportF18?visit_id="+medicalExamId;
		 $('#urlForReport').val(url);
		 openPdfModel(url) ;
	}
	
	if(meForm3A==examCode){
		$('#medicalEXamReportId').show();
		$('#visit_id3a').val(medicalExamId);
	 	 //document.getElementById('medicalExamReportReportId3A').submit();
		 var url=pageContaxValue+"/report/medicalExamReportReportF3A?visit_id="+medicalExamId;
		 $('#urlForReport').val(url);
		 openPdfModel(url) ;
		}
	
	if(meForm2A==examCode){
		$('#medicalEXamReportId').show();
		$('#visit_id2a').val(medicalExamId);
	 	// document.getElementById('medicalExamReportReportId2A').submit();
		 var url=pageContaxValue+"/report/medicalExamReportReportId2A?visit_id="+medicalExamId;
		 $('#urlForReport').val(url);
		 openPdfModel(url) ;
		}
	
	if(mbForm15==examCode){
		$('#medicalEXamReportId').show();
		$('#visit_id15').val(medicalExamId);
	 	 //document.getElementById('medicalExamReportReportId15').submit();
		 var url=pageContaxValue+"/report/mbAmsf15Report?visit_id="+medicalExamId;
		 $('#urlForReport').val(url);
		 openPdfModel(url) ;
	}

	if(mbForm16==examCode){
		$('#medicalEXamReportId').show();
		$('#visit_id16').val(medicalExamId);
	 	 document.getElementById('medicalExamReportReportId16').submit();
	}
	//$('#medicalEXamReportId').show();
	//$('#visit_id').val(medicalExamId);
 	 //document.getElementById('medicalExamReportReportId').submit();
	 
}
function getReportForMb(medicalExamId,medicalCode,idVal){
	$('#medicalBoardReportId').show();
	$('#visit_id').val(medicalExamId);
 	// document.getElementById('medicalBoardReportReportId').submit();
	 var url=pageContaxValue+"/report/mbAmsf15Report?visit_id="+medicalExamId;
	 $('#urlForReport').val(url);
	 openPdfModel(url) ;
}
function getReportForMeH(medicalExamId,examCode,idVal){
	var meForm3B=resourceJSON.meForm3B;
	var meForm18=resourceJSON.meForm18;
	
	var meForm3A=resourceJSON.meForm3A;
	var mbForm15=resourceJSON.mbForm15;
	var mbForm16=resourceJSON.mbForm16;
	var meForm2A=resourceJSON.meForm2A;
	
	if(meForm3B==examCode){
	$('#medicalEXamReportId').show();
	$('#visit_id3b').val(medicalExamId);
 	// document.getElementById('medicalExamReportReportId').submit();
	 var url=pageContaxValue+"/report/medicalExamReportReport?visit_id="+medicalExamId;
	 $('#urlForReport').val(url);
	 openPdfModel(url) ;
	}
	if(meForm18==examCode){
		$('#medicalEXamReportId').show();
		$('#visit_id18').val(medicalExamId);
	 	 //document.getElementById('medicalExamReportReportId18').submit();
		 var url=pageContaxValue+"/report/medicalExamReportReportF18?visit_id="+medicalExamId;
		 $('#urlForReport').val(url);
		 openPdfModel(url); 
	}
	
	if(meForm3A==examCode){
		$('#medicalEXamReportId').show();
		$('#visit_id3a').val(medicalExamId);
	 	 //document.getElementById('medicalExamReportReportId3A').submit();
		 var url=pageContaxValue+"/report/medicalExamReportReportF3A?visit_id="+medicalExamId;
		 $('#urlForReport').val(url);
		 openPdfModel(url);
		}
	
	if(meForm2A==examCode){
		$('#medicalEXamReportId').show();
		$('#visit_id2a').val(medicalExamId);
	 	// document.getElementById('medicalExamReportReportId2A').submit();
		 var url=pageContaxValue+"/report/medicalExamReportReportId2A?visit_id="+medicalExamId;
		 $('#urlForReport').val(url);
		 openPdfModel(url);
		}
	
	
	
		if(mbForm15==examCode){
			$('#medicalEXamReportId').show();
			$('#visit_id15').val(medicalExamId);
		 	// document.getElementById('medicalExamReportReportId15').submit();
			 var url=pageContaxValue+"/report/mbAmsf15Report?visit_id="+medicalExamId;
			 $('#urlForReport').val(url);
			 openPdfModel(url);
		}
	
		if(mbForm16==examCode){
			$('#medicalEXamReportId').show();
			$('#visit_id16').val(medicalExamId);
		 	 document.getElementById('medicalExamReportReportId16').submit();
		}
		
}
/*function showEHRRecords() {
	 checkForAuthen =$("#checkForAuthenticationValue").val();
	 uhidNumberValue =$("#uhidNumberValue").val();
	  var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/ehr/patientSummary?patientId=";
alert("uhidNumberValue"+uhidNumberValue);
	if(uhidNumberValue=="success"){
		window.open(url+$('#patientId').val()+"");
	 }
else{
	if(checkForAuthen=="popUpShow"){
		 $("#messageForAuthenticate").show();	  
		 $('.modal-backdrop').show()
	 	}
	 else{
		 window.open(url+$('#patientId').val()+""); 
	 } 
}
	
}*/




function checkForAuthenticateUser(){

	var patientId =$('#patientId').val();
	var visitId = $('#visitId').val();
	 
	var params = {
			"patientId": patientId,
			"visitId":visitId
	}
	var pathname = window.location.pathname;
 	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/opd/checkForAuthenticateUser";
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : url,
		data : JSON.stringify(params),
		dataType : "json",
		//cache : false,
		success : function(response) {
			var data = response.data;
			$('#checkForAuthenticationValue').val(data);
			return ;
		}
	});
	
}

var uhidNumberValue="";
var checkForAuthen="";
function showEHRRecords() {
	 checkForAuthen =$("#checkForAuthenticationValue").val();
	 uhidNumberValue =$("#uhidNumberValue").val();
	  var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/ehr/patientSummary?patientId=";
if(uhidNumberValue!="" && uhidNumberValue=="success"){
  window.open(url+$('#patientId').val()+"&userId="+$('#userId').val()+"");
	 }
else{
	if(checkForAuthen=="popUpShow"){
		 $("#messageForAuthenticate").show();	  
		 $('.modal-backdrop').show()
	 	}
	 else{
		 window.open(url+$('#patientId').val()+"&userId="+$('#userId').val()+""); 
	 } 
}
	
}

function closeMessage(){
	 $('#errordiv').empty("");
	 $('#uhidNumber').val("");
	$('.modal').hide();
	$('.modal-backdrop ').hide();
	$('.modal-backdrop2').hide();
	$('#messageForInvestigationOutside').hide();
}


function callToAutheniticate(){
	$('#errordiv').empty("");
	var uhidNo=$('#uhidNumber').val();
	var patientId =$('#patientId').val();
	if(uhidNo==""){
		$('#errordiv').append(""+resourceJSON.msgEnterUhidnumber);
		$('#errordiv').show();
		return false;
	}
	var params = {
			"uhidNo" : uhidNo,
			"patientId": patientId,
	}
	var pathname = window.location.pathname;
 	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/opd/authenticateUser";
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : url,
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(response) {
			var data = response.data;
			$('#uhidNumberValue').val(data);
			if(data=="success"){
				$('#messageForAuthenticateMessae').html(""+resourceJSON.msgSucessAuthorized);
				/*var pathname = window.location.pathname;
				var accessGroup = "MMUWeb";
				var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/ehr/patientSummary?patientId=";
				window.open(url+$('#patientId').val()+"");*/
				/*$('.modal-backdrop ').hide();
				$('#messageForAuthenticate').hide();*/
				//$('.modal').hide();
				document.getElementById("okButtonOfAuthenticate").style.display = "none";

				$('#prevLabClinicHistory').attr({
					'data-toggle':'modal',
					'data-target':'#exampleModal',
					'data-backdrop':'static'
					});
				$('#prevRadioHistory').attr({
					'data-toggle':'modal',
					'data-target':'#exampleModal',
					'data-backdrop':'static'
					});
				
			}
			else{
				/*$('#messageForAuthenticateMessae').html(""+resourceJSON.msgFailAuthorized);*/
				$('#errordiv').append(""+resourceJSON.msgFailAuthorized);
				$('#errordiv').show();
				document.getElementById("okButtonOfAuthenticate").style.display = "block";

			}
			
			return ;
		}
	});
	
}
 

function addImmunisationStatusForHistory(){
	 var tbl = document.getElementById('immunizationHistoryGrid');
 	lastRow = tbl.rows.length;
 	i =lastRow+100;
 	i++;
 
	    var aClone = $('#immunizationHistoryGrid>tr:last').clone(true);
	    aClone.find('img.ui-datepicker-trigger').remove();
		aClone.find("td:eq(0)").find("input:eq(0)").removeAttr("readonly");
		aClone.find("td:eq(2)").find("input:eq(0)").prop('readonly', false);
		aClone.find("td:eq(0)").find("input:eq(0)").prop('disabled', false);
		aClone.find(":input").val("");
		aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'immunisatioName'+i+'');
		aClone.find("td:eq(0)").find("input:eq(0)").prop('name', 'immunisatioName');
		aClone.find("td:eq(0)").find("input:eq(1)").prop('id', 'immunisationId'+i+'');
		aClone.find("td:eq(0)").find("input:eq(2)").prop('id', 'pvmsNumber'+i+'');
		aClone.find("td:eq(0)").find("input:eq(3)").prop('id', 'patientImmunizationHisId'+i+'');
		aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'durationImmu'+i+'');
		aClone.find("td:eq(0)").find("div").find("div").prop('id', 'immunizationDiv' + i + '');
		
		aClone.find("td:eq(4)").find("input:eq(0)").prop('id', 'prescriptionDate'+i+'').removeClass('noFuture_date hasDatepicker').addClass('noFuture_date');
		aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'immnunizationDate'+i+'').removeClass('noFuture_date6 hasDatepicker').addClass('noFuture_date6');
		aClone.find("td:eq(3)").find("input:eq(0)").prop('id', 'nextDueImmu'+i+'');
	//	aClone.find("td:eq(2)").find("input:eq(0)").prop('name', 'immnunizationDate').addClass('form-control noFuture_date hasDatepicker');
		var immunizationRemoveButton="";
		immunizationRemoveButton +='<button type="button" name="delete" value="" id="newImmunizationDelete'+i+'"  class="buttonDel btn btn-danger noMinWidth" button-type="delete"  onclick="removeRowImmunization(this);"></button>';
	   	aClone.find("td:eq(6)").html(immunizationRemoveButton);
		aClone.clone(true).appendTo('#immunizationHistoryGrid');
		
	} 



function closeModal(){
	 $('#exampleModal').hide();
	 $('.modal-backdrop').hide();
	 $('#exampleModal .modal-body').empty();
}
function showImmunizationTemplateMe() {
		/*$('.modal-backdrop').hide();*/
		$('#exampleModal').show();
		$('.modal-backdrop').show();
		var patientId=$('#patientId').val();
		var visitId=$('#visitId').val();
		var userId=$('#userId').val();
		 var pathname = window.location.pathname;
	     var accessGroup = "MMUWeb";
		 var urlPreviousVisit = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/showImmunizationTemplate?employeeId="+userId+"&patientId="+patientId+"&visitId="+visitId;
		$('#exampleModal .modal-body').load(urlPreviousVisit);
	    $('#exampleModal .modal-title').text('Immunization History');
	}

function populateMasStoreItemForTem(val, inc,item) {
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
		} 
		else
		{
			//document.getElementById('pvmsNo' + inc).value = pvmsNo
			  var pvmsValue = '';
	     	var pvmsNumberVal='';
			for(var i=0;i<autoVsPvmsNo.length;i++){
	     		 // var pvmsNo1 = data[i].pvmsNo;
	     		 var masItemIdValue= autoVsPvmsNo[i];
	     		 var pvmsNo1=masItemIdValue[1];
	     		
	     		  if(pvmsNo1 == pvmsNo){
	     			  pvmsValue = masItemIdValue[3];//data[i].dispUnit;
	     			  itemIdPrescription =masItemIdValue[0]; //data[i].itemId;
	     			  itemIds = itemIdPrescription;
	     			 pvmsNumberVal = masItemIdValue[1];
	     			var checkCurrentNomRowId=$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").attr("id");
      			   var checkCurrentNomRowVal=$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val();  
      			   
      			 checkCurrentNomRowVal=$('#'+checkCurrentNomRowId).val();
	     			$('#immunizationHistoryGrid tr').each(function(i, el) {
	     			   var $tds = $(this).find('td')
	  			       var itemIdCheck=  $($tds).closest('tr').find("td:eq(0)").find("input:eq(1)").attr("id");
	     			   var itemIdValue=$('#'+itemIdCheck).val();
	     			   var idddd =$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").attr("id");
	     			   var currentidddd=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
	     			   //if(itemIds!="" &&  itemIdValue!="" && itemIdValue!="undefined" )
	     			   if(itemIdCheck!=checkCurrentNomRowId)	   
 			           {
	     				 if(itemIds==itemIdValue){
	      			        $('#'+idddd).val("");
	      			        $('#'+currentidddd).val("");
	      			      	alert("Immunization is already added");
	      			        return false;
	     				   
 			           }
 			           }
	     			   else
	     			   {
	     				  $(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val(itemIds); 
	     				  try{
	     					 $(item).closest('tr').find("td:eq(0)").find("input:eq(2)").val(pvmsNumberVal);
	     				  }
	     				  catch(e){}
	     					    		     				
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



function addNewItemForCommon(currentObj,flagVal){
	$('#messageForCommonAutoComplete').show();
	$('.modal-backdrop').show();
	 $("#saveItemCommonId").attr("disabled", false);
	var icdIds= "";
	if(flagVal=='diagnosisMe'){
		 icdIds= $(currentObj).closest('tr').find("td:eq(3)").find("input:eq(0)").attr("id"); 
		 if(icdIds=="" || icdIds==undefined || !icdIds.includes("diagnosis")){
			 icdIds= $(currentObj).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id"); 
			 if(icdIds=="" || icdIds==undefined || !icdIds.includes("diagnosis")){
				 icdIds= $(currentObj).closest('tr').find("td:eq(1)").find("textarea:eq(0)").attr("id");
			 }
		 if(icdIds=="" || icdIds==undefined || !icdIds.includes("diagnosis")){
			 icdIds= $(currentObj).closest('tr').find("td:eq(3)").find("textarea:eq(0)").attr("id"); 
		 }
		 }
	}
	else if(flagVal=='diagnosisForReferal'){
		 icdIds= $(currentObj).closest('tr').find("td:eq(3)").find("textarea:eq(0)").attr("id"); 
	}
	else{
		icdIds=$(currentObj).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id"); 
	}
	
    if(icdIds=="" || icdIds==undefined){
    	icdIds='icd';
    }
	
	$('#currentObjectId').val(icdIds);
	$('#flagForItem').val(flagVal);
	var userId=$('#userId').val();
	$('#userNameCommon').val(userId);
	$('#addItem').val("");
	$('#addItemCode').val("");
	}
	
	
function saveItemCommon(){
	var count=0;
	var itemId= $('#currentObjectId').val();
	var flagForItem= $('#flagForItem').val();
	var addItem="";
	addItem= $('#addItem').val();
	var addItemCode=$('#addItemCode').val();
	
	if(addItem==""){
		alert("Please enter ICD Name")
		count=1;
	return false;
	}
	if(addItemCode==""){
		alert("Please enter ICD Code")
		count=1;
	return false;
	}
	
	var userIdCommon=$('#userNameCommon').val();
	var pathname = window.location.pathname;
 	var accessGroup = "MMUWeb";

 	var url = window.location.protocol + "//"
 			+ window.location.host + "/" + accessGroup
 			+ "/medicalexam/saveItemCommon";
	var data={
			"tableFlag":flagForItem,
			"addItem":addItem,
			"userIdCommon":userIdCommon,
			"addItemCode":addItemCode
	}
	if(count==0){
		 $("#saveItemCommonId").attr("disabled", true);
		 $('.modal-backdrop').hide();
		 
	$.ajax({
		type:"POST",
		contentType:"application/json",
		url : url,
		data : JSON.stringify(data),
		dataType : "json",
		success : function(res) {
			 var data = res.status;
			 
			 if(data=='1'){
				 $("#saveItemCommonId").attr("disabled", true);
				 $('#'+itemId).val(addItem);
				 				 
				 var e = $.Event("keyup", { which: 32 });
				 
				 alert(res.message+'S');			 
				
				 document.getElementById("closeBtn").addEventListener("click", function(){
					 $('#messageForCommonAutoComplete').hide();	
					 $('#'+itemId).focus();
					 $('#'+itemId).trigger(e);
				 });
			 }
			 else{
				 $("#saveItemCommonId").attr("disabled", false);
				 alert(res.message);
			 }
			 
		}
	 
		
	})
	}
	
	}
	
	


function saveAllergyHistory(){
	 	var allergyProduct='';
	 	var productName="";
	 	var dateOfIndexReaction="";
	 	var reactionDetails="";
	 	var severity="";
	 	var statusOfAllergy="";
	 	var remarksOfAllergy="";
	    var patientAllergyDetailId="";
	 	var allergyProductValArray = [];
	 	var productNameArray=[];
	 	var dateOfIndexReactionArray = [];
	 	var reactionDetailsArray=[];

	 	var severityArray=[];
	 	var statusOfAllergyArray = [];
	 	var remarksOfAllergyArray=[];
	 	var patientAllergyDetailIdArray=[];
	 	var userId="";
	 	var patientId="";
	 	var visitId="";
	 	var hospitalId="";
	 	visitId=$('#visitId').val();
	 if(visitId=="" && visitId==undefined){
	 		visitId=$('#visitID').val();
	 	}
	 	patientId=	$('#patientId').val();
	 	userId=	$('#userId').val();
	 	hospitalId=$('#hospitalId').val();
	 	var countDgInves=0;
	 	$('#allergyHistoryGrid tr').each(function(i, el) {
	 		allergyProduct= $(this).find("td:eq(0)").find("select:eq(0)").val();
	 		productName= $(this).find("td:eq(1)").find("input:eq(0)").val();
	 		patientAllergyDetailId= $(this).find("td:eq(1)").find("input:eq(1)").val();
	 		dateOfIndexReaction= $(this).find("td:eq(2)").find("input:eq(0)").val();
	 		reactionDetails= $(this).find("td:eq(3)").find("textarea:eq(0)").val();
	 		severity= $(this).find("td:eq(4)").find("select:eq(0)").val();
	 		statusOfAllergy= $(this).find("td:eq(5)").find("select:eq(0)").val();
	 		remarksOfAllergy= $(this).find("td:eq(6)").find("textarea:eq(0)").val();

	 		if(allergyProduct!="" && allergyProduct!=undefined && allergyProduct!=0){
	 			allergyProductValArray.push(allergyProduct);
	 		}
	 		else{
	 			allergyProduct='0';
	 			allergyProductValArray.push(allergyProduct);
	 			alert("Please select Allergy product.");
	      		countDgInves+=1;
	 		}
	 		if(productName!="" && productName!=undefined){
	 			productNameArray.push(productName);
	 		}
	 		else{
	 			productName='0';
	 			productNameArray.push(productName);
	 			alert("Please enter  Product Name.");
	      		countDgInves+=1;
	 		}
	 		
	 		
	 		if(dateOfIndexReaction!="" && dateOfIndexReaction!=undefined){
	 			dateOfIndexReactionArray.push(dateOfIndexReaction);
	 		}
	 		else{
	 			dateOfIndexReaction='0';
	 			dateOfIndexReactionArray.push(dateOfIndexReaction);
	 			alert("Please enter  Date Of Index Reaction.");
	      		countDgInves+=1;
	 		}
	 		
	 		
	 		if(reactionDetails!="" && reactionDetails!=undefined){
	 			reactionDetailsArray.push(reactionDetails);
	 		}
	 		else{
	 			reactionDetails='0';
	 			reactionDetailsArray.push(reactionDetails);
	 		}
	 		
	 		if(severity!="" && severity!=undefined && severity!=0){
	 			severityArray.push(severity);
	 		}
	 		else{
	 			severity='0';
	 			severityArray.push(duration);
	 			alert("Please select Severity.");
	      		countDgInves+=1;
	 		}
	 		
	 		if(statusOfAllergy!="" && statusOfAllergy!=undefined && statusOfAllergy!=0){
	 			statusOfAllergyArray.push(statusOfAllergy);
	 		}
	 		else{
	 			statusOfAllergy='0';
	 			statusOfAllergyArray.push(statusOfAllergy);
	 			alert("Please select Status.");
	      		countDgInves+=1;
	 		}

	 		if(remarksOfAllergy!="" && remarksOfAllergy!=undefined){
	 			remarksOfAllergyArray.push(remarksOfAllergy);
	 		}
	 		else{
	 			remarksOfAllergy='0';
	 			remarksOfAllergyArray.push(remarksOfAllergy);
	 		}
	 		if(patientAllergyDetailId!="" && patientAllergyDetailId!=undefined){
	 			patientAllergyDetailIdArray.push(patientAllergyDetailId);
	 		}
	 		else{
	 			patientAllergyDetailId='0';
	 			patientAllergyDetailIdArray.push(patientAllergyDetailId);
	 		}

	 		
	 	});
		
		 
	 
	 	 if(countDgInves==0){
	 		$("#getAllergyHistory").attr("disabled", "disabled");
	 	var params = {
				"allergyProductValArray":allergyProductValArray,
				"productNameArray":productNameArray,
				"dateOfIndexReactionArray":dateOfIndexReactionArray,
				"reactionDetailsArray":reactionDetailsArray,
				"severityArray":severityArray,
				"statusOfAllergyArray":statusOfAllergyArray,
				"remarksOfAllergyArray":remarksOfAllergyArray,
				"patientAllergyDetailIdArray":patientAllergyDetailIdArray,
				 "userId":userId,
				 "patientId":patientId,
				 "visitId":visitId,
				 "hospitalId":hospitalId,
	 	} 	
	 	var pathname = window.location.pathname;
		 	var accessGroup = "MMUWeb";
			var url = window.location.protocol + "//"
				+ window.location.host + "/" + accessGroup
				+ "/opd/submitAllergyHistory";
		 
		$.ajax({
			type : 'POST',
			url : url,
			data : JSON.stringify(params),
	        contentType : "application/json",
			dataType : "json",
			success : function(response) {
				if(response.status==1){
					
					alert("Allergy History updated Successfully"+'S');
					
					document.getElementById("closeBtn").addEventListener("click", function(){
						getAllergyHistory('ALL','SearchStatusForMassDesignation');
						$("#allergyHistoryDetailId").attr("disabled", false);
					});
				}
				else{
					alert("Something is wrong");
					$("#allergyHistoryDetailId").attr("disabled", false);
				}
			
			}
		});
		
	}
	}

function getAllergyHistory(MODE,className)
{

	var visitId = $('#visitId').val();
	var patientId=$('#patientId').val();
	
 
	 if(MODE == 'ALL'){
		 
			var data = {'pageNo':nPageNo,'visitId' : visitId,"patientId":patientId };			
		}
	else
		{
			var data =  {'pageNo':nPageNo, 'visitId':visitId,"patientId":patientId}; 
		} 
	    var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/opd/getAllergyHistory";  
	var bClickable = true;
	GetJsonDataForCommon('tblListOfCommand',data,url,bClickable,"waitingImgId",className,'allergyHistoryGrid','resultnavigationForAllery');
}
function makeAllergyHistoryGrid(dataList){
	var htmlTable="";
	var allergyHtml="";
	if(dataList!=null){
		var countImu=400;
	for(i=0;i<dataList.length;i++)
	{
		 
		var approvalFlagDiasable='disabled';
		
		var  func1='populateMasStoreItemForTem';
		 var  url1='opd';
		  var url2='getMasStoreItemList';
		  var flaga='immunizationFlagForTem';
		   
		  allergyHtml += '<tr>';
		  allergyHtml += '<td>'; 
		  allergyHtml += '<select name="allergyProduct"  class="form-control p-l-5" id="allergyProduct"  tabindex="1">';
		  allergyHtml+='	<option id="selectAllergyProduct" value="0">Select</option>';
		  for(var j=0;j<3;j++){
			  var selectedValueForFood="";
			  var selectedEnvironmental="";
			  var selectedMedicine="";
			  if(dataList[i].allergyProductType=='food'){
				  selectedValueForFood='selected';
			  }
			  else{
				  selectedValueForFood=""; 
			  }
			  if(dataList[i].allergyProductType=='environmental agent'){
				  selectedEnvironmental='selected';
			 }
			  else{
				  selectedEnvironmental="";
			  }
			  if(dataList[i].allergyProductType=='medicine'){
				  selectedMedicine='selected';
			 }
			  else{
				  selectedMedicine="";
			  } 
			  }
		  allergyHtml += '	<option id="food" value="food" '+selectedValueForFood+'>Food</option>';
		  allergyHtml += '<option id="environmental_agent" value="environmental agent" '+selectedEnvironmental+'>Environmental Agent</option>';
		  allergyHtml += '	<option id="medicine" value="medicine" '+selectedMedicine+'>Medicine</option>';
		  
		  allergyHtml += '</select>';
		  allergyHtml += '</td>';
		
		
	/*	  allergyHtml+='<td> <div class="form-group autocomplete forTableResp">';
		  allergyHtml+='<input type="text" autocomplete="never" class="form-control border-input" readonly="readonly" name="productName" id="productName'+i+'" value="'+dataList[i].productId+'"     onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" />';
	 
		  allergyHtml += '<input type="hidden"  name="patientAllergyDetailId" value="'
				+ dataList[i].allergyId  +'"  id="patientAllergyDetailId' + dataList[i].allergyId + '"/>';
		  allergyHtml += '<div id="allergyDivId'+i+'" class="autocomplete-itemsNew"></div>';

		  allergyHtml+='</div></td>';*/
 		 
		  allergyHtml+='<td><textarea  name=productName maxlength="2000"';
		  allergyHtml += '	id="productName" class="historyAutoComplete form-control border-input textNew" cols="0" rows="0" value=""';
		  allergyHtml += '	tabindex="1"></textarea>';
		  allergyHtml += '<input type="hidden"  name="patientAllergyDetailId" value="'
						+ dataList[i].allergyId  +'"  id="patientAllergyDetailId' + dataList[i].allergyId + '"/>';
		 allergyHtml+='</td>';
		 var dateOfIndexReaction="";
		 if(dataList[i].dateOfIndexReaction!=""){
			 dateOfIndexReaction= dataList[i].dateOfIndexReaction;
		 }
		 else{
			 dateOfIndexReaction="";
		 }
		 allergyHtml+='<td>';
		 allergyHtml+='<div class="dateHolder">';
		 allergyHtml+='<input class="form-control noFuture_date6" name="dateOfIndexReaction" id="dateOfIndexReaction'+i+'" value="'+dateOfIndexReaction+'" />';
		 allergyHtml+='</div>';
		 allergyHtml+='</td>';
		 
		 
		 allergyHtml+='<td>';
		 allergyHtml+=' <textarea id="reactionDetails" name="reactionDetails" class="form-control disablecopypaste">'+dataList[i].reactionDetails+'</textarea> ';
		 allergyHtml+='</td>';
		 
		 
		 allergyHtml+=' <td>';
		 allergyHtml+='	<select name="severity"  class="form-control p-l-5" id="severity"  tabindex="1">';
		 allergyHtml+='	<option id="selectSeverity" value="0">Select</option>';
		 for(var j=0;j<6;j++){
			  var selectedMild="";
			  var selectedModerate="";
			  var selectedSevere="";
			  var selectedPotentially="";
			  
			  var selectedFatal="";
			  var selectedAnaphylaxis="";
			  if(dataList[i].severity=='mild'){
				  selectedMild='selected';
			  }
			  else{
				  selectedMild=""; 
			  }
			  if(dataList[i].severity=='moderate'){
				  selectedModerate='selected';
			 }
			  else{
				  selectedModerate="";
			  }
			  if(dataList[i].severity=='severe'){
				  selectedSevere='selected';
			 }
			  else{
				  selectedSevere="";
			  }
			  
			  
			  if(dataList[i].severity=='potentially life threatening'){
				  selectedPotentially='selected';
			  }
			  else{
				  selectedPotentially=""; 
			  }
			  if(dataList[i].severity=='fatal'){
				  selectedFatal='selected';
			 }
			  else{
				  selectedFatal="";
			  }
			  if(dataList[i].severity=='anaphylaxis and toxicosis'){
				  selectedAnaphylaxis='selected';
			 }
			  else{
				  selectedAnaphylaxis="";
			  }
		 } 
		allergyHtml+='	<option id="mild" value="mild" '+selectedMild+'>Mild</option>';
		 allergyHtml+='	<option id="moderate" value="moderate" '+selectedModerate+'>Moderate</option>';
		allergyHtml+='		<option id="severe" value="severe" '+selectedSevere+'>Severe</option>';
				
		allergyHtml+='<option id="Potentially_life_threatening" value="potentially life threatening" '+selectedPotentially+'>Potentially life threatening</option>';
		allergyHtml+='<option id="fatal" value="fatal" '+selectedFatal+'>Fatal</option>';
		allergyHtml+=' <option id="anaphylaxis_and_aoxicosis" value="anaphylaxis and toxicosis" '+selectedAnaphylaxis+'>Anaphylaxis and Toxicosis</option>';
		
		 
		allergyHtml+='</select>';
		allergyHtml+='</td>';
		
		allergyHtml+='<td>';
		allergyHtml+='<select name="statusOfAllergy"  class="form-control p-l-5" id="statusOfAllergy"  tabindex="1">';
		allergyHtml+='	<option id="selectStatusOfAllergy" value="0">Select</option>';
		 for(var j=0;j<6;j++){
			  var selectedActive="";
			  var selectedInactive="";
			  var selectedResolved="";
			  var selectedNoneKnown="";
			  var selectedRemitting="";
			  
			  if(dataList[i].status=='active'){
				  selectedActive='selected';
			  }
			  else{
				  selectedActive=""; 
			  }
			  if(dataList[i].status=='inactive'){
				  selectedInactive='selected';
			 }
			  else{
				  selectedInactive="";
			  }
			  if(dataList[i].status=='resolved'){
				  selectedResolved='selected';
			 }
			  else{
				  selectedResolved="";
			  }
			  
			  
			  if(dataList[i].status=='none known'){
				  selectedNoneKnown='selected';
			  }
			  else{
				  selectedNoneKnown=""; 
			  }
			  
			  if(dataList[i].status=='anaphylaxis and toxicosis'){
				  selectedRemitting='selected';
			 }
			  else{
				  selectedRemitting="";
			  }
		 } 
		
		
		allergyHtml+='<option id="active" value="active" '+selectedActive+'>Active</option>';
		allergyHtml+='<option id="inactive" value="inactive"'+selectedInactive+'>Inactive</option>';
		allergyHtml+='<option id="resolved" value="resolved" '+selectedResolved+'>Resolved</option>';
		allergyHtml+='<option id="none_known" value="none known" '+selectedNoneKnown+'>None known</option>';
		allergyHtml+='<option id="unable_to_ascertain_and _remitting" value="unable to ascertain and remitting" '+selectedRemitting+'>Unable to ascertain and Remitting</option>';
		 allergyHtml+='</select>';
		allergyHtml+='</td>';
		
		allergyHtml+='<td>';
		allergyHtml+='<textarea id="remarksOfAllergy" name="remarksOfAllergy" class="form-control disablecopypaste">'+dataList[i].remarks+'</textarea>';
			allergyHtml+='</td>';
		 
		 
			allergyHtml+=' <td><button name="Button"   type="button" class="buttonAdd btn btn-primary noMinWidth" button-type="add" onClick="return addAllergyHistory();"> </button></td>';
			var patientAllergyDetailId="";
			var allergyGridValue='allergyHistoryGrid';
			if(dataList[i].allergyId!=null && dataList[i].allergyId!=undefined)
			  patientAllergyDetailId=dataList[i].allergyId;
			allergyHtml+='	<td><button name="Button" type="button" class="buttonAdd btn btn-danger noMinWidth" id="allergyHistoryDelete" button-type="delete"  onClick="return removeRowInvestigation(this,\'' +allergyGridValue+ '\',\''+patientAllergyDetailId+'\');" > </button></td>';
			allergyHtml += '</tr>';
		 countImu++;
			}
	$('#allergyHistoryGrid').html(allergyHtml);
	}	 
		
}
function removeRowInvestigationMe(val, investigationGrid, investigationData) {
	if(investigationGrid == "investigationGrid"){	
	 var tbl = document.getElementById('dgInvetigationGrid');
		var lastRow = tbl.rows.length;
	}
	if(investigationGrid == "immunisationStatusGrid"){	
		 var tbl = document.getElementById('immunisationStatusGrid');
			var lastRow = tbl.rows.length;
		}
	if(investigationGrid == "immunizationHistoryGrid"){	
		 var tbl = document.getElementById('immunizationHistoryGrid');
			var lastRow = tbl.rows.length;
		}
	
	if(investigationGrid == "serviceDetailsIdGrid"){	
		 var tbl = document.getElementById('serviceDetailsIdGrid');
			var lastRow = tbl.rows.length;
		}
	if(investigationGrid == "diseaseWoundInjuryDetailsGrid"){	
		 var tbl = document.getElementById('diseaseWoundInjuryDetailsGrid');
			var lastRow = tbl.rows.length;
		}
	
	
	if(investigationGrid == "diseaseWoundInjuryArmedForces"){	
		 var tbl = document.getElementById('diseaseWoundInjuryArmedForces');
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
			if (investigationGrid == "immunizationHistoryGrid" && lastRow == '1') {
				$("#messageDelete").show();
				return false;
			}
			if (investigationGrid == "serviceDetailsIdGrid" && lastRow == '1') {
				$("#messageDelete").show();
				return false;
			}
			if (investigationGrid == "diseaseWoundInjuryDetailsGrid" && lastRow == '1') {
				$("#messageDelete").show();
				return false;
			}
			if (investigationGrid == "diseaseWoundInjuryArmedForces" && lastRow == '1') {
				$("#messageDelete").show();
				return false;
			}
			
			$(val).closest('tr').remove();
			var flag = 0;
			if ((val.id != "newIdInv" && investigationGrid == "investigationGrid")) {
				if (investigationGrid == "investigationGrid"
						&& investigationData != "") {
					flag = 1;
					deleteInvestigatRowMe(flag, investigationData, "", "", "");
				}
			}
			if ((val.id != "newIdImmunization" && (investigationGrid == "immunisationStatusGrid" ||investigationGrid == "immunizationHistoryGrid"))) {
				if (investigationData != "" && (investigationGrid == "immunisationStatusGrid" || investigationGrid == "immunizationHistoryGrid")) {
					flag = 'Im1005';
					deleteInvestigatRowMe(flag, investigationData, "", "", "",investigationGrid);
				}
			}
			if(val.id != "newdeleteServiceDetail" && investigationGrid == "serviceDetailsIdGrid") {
				flag = 'servi006';
				deleteInvestigatRowMe(flag, investigationData, "", "", "",investigationGrid);
			 
		}
			if(val.id != "newdiseaseWoundInjury" && investigationGrid == "diseaseWoundInjuryDetailsGrid") {
				flag = 'diseasi007';
				deleteInvestigatRowMe(flag, investigationData, "", "", "",investigationGrid);
			 
		}
			
			
			if(val.id != "newarmedForces" && investigationGrid == "diseaseWoundInjuryArmedForces") {
				flag = 'beforeNewWarmi008';
				deleteInvestigatRowMe(flag, investigationData, "", "", "",investigationGrid);
			 
		}	
			
		}
	}


 

function getImmunisationHistoryDigi() {
	 
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
						 immmunisationHtml+='<input class="form-control noFuture_date6" name="immnunizationDate" id="immnunizationDate'+i+'"  '+approvalFlagDiasable+'  value="'+immunizationDateValue+'"  onChange="return checkDateValidate(this);"/>';
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

function deleteInvestigatRowMe(flag, valueForDelete, visitId, opdPatientDetailId,
		patientId,investigationGrid) {
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
				if(investigationGrid=="immunisationStatusGrid")
				getImmunisationHistoryDigi();
				try{
					if(investigationGrid=="immunizationHistoryGrid")	
				getPatientImmunizationHistory('ALL','SearchStatusForMassDesignation');
				}
				catch(e){}
			}
			return "2";
		}
	});

}

function previousMedicalExamOpenInHtml(visitId,age,meTypeCode,viewOrEditFlag,visitFlag,approvedBy){
	var newEntryStatus='no';
	var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/digifileupload/mbMembersAFMSFormHtml?visitId=";
	var  popup = window.open(url+visitId+ "&age=" + age+"&examTypeId="+meTypeCode+"&viewOrEditFlag="+viewOrEditFlag+"&newEntryStatus="+newEntryStatus+"&visitFlag="+visitFlag+"&approvedBy="+approvedBy, "popUpWindow", "height=500,width=800,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
	     popup.focus();
	
	/* window.location.href = "mbMembersAFMSForm?visitId=" + visitId
		+ "&age=" + age+"&examTypeId="+meTypeCode+"&viewOrEditFlag="+viewOrEditFlag;*/
	
}

function checkDateValidate(obj){
	var dateVal=obj.value;
	var ids="";
	ids=obj.id;
	if(dateVal!="" && dateVal!=null && dateVal!=undefined){
		var dateArray=dateVal.split("/");
		if(dateArray.length!=3){
			alert("Please enter valid Date formate(DD/MM/YYYY)!");
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


function uploadApprovalRmsData(visitId,medicalExamId,meTypeCod,serviceNumber,medicalExamDate,approvedBy,item ) {
	 var fileSize=0;
	 var countResult=0; 
	  // var updateVaule='uploadlingApprovalFile'+visitId;
	// var formData1 = $('#uploadlingApprovalFile'+visitId)[0];
	 var formData1 = $('#uploadlingApprovalFile'+visitId)[0];
	 var formData = new FormData(formData1);
	 
		formData.append('visitId',  visitId);
		formData.append('medicalExamId', medicalExamId);
		formData.append('serviceNumber', serviceNumber);
		formData.append('dateOfExam', medicalExamDate);
		var fileNameValueIDd= $(item).closest('tr').find("td:eq(10)").find("input:eq(0)").attr("id"); 
		var fileNameValue=$('#'+fileNameValueIDd).val();
		
		var filenameWithExtension=getFilenameAndReplcePath(fileNameValue);
		var checkFileName=0;
		if(filenameWithExtension!="" && filenameWithExtension!=null && validateFileExtension(filenameWithExtension, "valid_msg", "Only pdf/image files are allowed !",
			      new Array("jpg","pdf","jpeg","gif","png","PNG","JPEG","JPG","GIF","mp4","MP4")) == false)
			      {
			 		return false;
			      }
		if(filenameWithExtension!="" && filenameWithExtension!=undefined && filenameWithExtension!=null)
		if(checkForFileCondition(filenameWithExtension)){
			checkFileName++;
		}
 		
		if(fileNameValue=="" || fileNameValue==undefined || fileNameValue==null ){
			alert("Please upload file.");
	 		countResult++;
	 		 return false;
		}
		
		
		
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
			+ "/medicalexam/submitMedicalExamApprovalFile";
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
				var approvalButtonId= $(item).closest('tr').find("td:eq(10)").find("button:eq(0)").attr("id");
				$("#"+approvalButtonId).attr("disabled","disabled");
				if(responseData[0]!='0'){
					// $('.savingLoader').hide();
					alert("Sign Document uploaded Successfully "+'S');	
					//var checkRadioVal=	$("input[name='btnradio']:checked").val();
					//searchMEHistoryList('ALL');
					
					document.getElementById("closeBtn").addEventListener("click", function(){location.reload();});
					
					return true;
				}
				if(responseData[0]=='0'){
					alert(responseData[1]);
					$("#approvalButtonSubmit").removeAttr("disabled");
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



function makeTableForInvoidDetal(dataList){
	var htmlTable="";
	var sNNO=1;
	var indentDate="";
	var medicineName="";
	var requestQTR="";
	var receivedQTR="";
	var toalCost="";
	if(nPageNo>1){
		sNNO+=parseInt(nPageNo-1)*5;
	}
	if(dataList!=null){
	for(i=0;i<dataList.length;i++)
	{
		indentDate=dataList[i].indentDate;
		medicineName=dataList[i].medicineName;
		requestQTR=dataList[i].qtyRequest;
		receivedQTR=dataList[i].qtyReceived;
		totalCost=dataList[i].totalCost;
		 
		htmlTable = htmlTable +"<tr id='"+dataList[i].storeInternalMId+"' >";	
	    htmlTable = htmlTable +"<td style='width: 50px;'>"+sNNO+"</td>";
		htmlTable = htmlTable +"<td style='width: 100px;'>"+indentDate+"</td>";
		htmlTable = htmlTable +"<td style='width: 150px;'>"+medicineName+"</td>";
		htmlTable = htmlTable +"<td style='width: 150px;'>"+requestQTR+"</td>";
		htmlTable = htmlTable +"<td style='width: 150px;'>"+receivedQTR+"</td>";
		htmlTable = htmlTable +"<td style='width: 150px;'>"+totalCost+"</td>";
		
	 	htmlTable = htmlTable+"</tr>";
	 	
	 	
	sNNO=parseInt(sNNO)+1;		 
	}
	
	}
	else{
		htmlTable = htmlTable+"<tr ><td colspan='6'><h6>No Record Found</h6></td></tr>";
	}
	$('#invoiceMMUHistoryGrid').html(htmlTable);
		
}

 function getInvoiceAllDetail(MODE,className)
 {
  	var mmuId = $('#mmuId').val();
 	var fromDate=$('#fromDate').val();
 	var toDate=$('#toDate').val(); 
 	 if(MODE == 'ALL'){
 		 
 			var data = {'PN':nPageNo,'mmuId' : mmuId,"fromDate":fromDate,"toDate":toDate};			
 		}
 	else
 		{
 		var data = {'PN':nPageNo,'mmuId' : mmuId,"fromDate":fromDate,"toDate":toDate};
 		} 
 	    var pathname = window.location.pathname;
 		var accessGroup = "MMUWeb";
 		var url = window.location.protocol + "//"
 		+ window.location.host + "/" + accessGroup
 		+ "/dashboard/getAllInvoiceDetail";  
 	 
 	var bClickable = true;
 	GetJsonDataForCommon('tblListOfCommand',data,url,bClickable,"waitingImgId",className,'invoiceMMUHistoryGrid','resultnavigation');
 }
 
