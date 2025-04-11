/////////////////////////////Show All Audit Recommended Diagnosis //////////////////////////////////// 


function showAllAuditRecommendedDiagnosis(mode,className)
{
	$('modal-backdrop').show();
	var patientSymAuditId=$('#patientSymAuditId').val();
	var array = patientSymAuditId.split(',');
	var array = patientSymAuditId.split(',');
	array.sort(function(a, b) {
		  return a - b;
		});
	 $('#patientSymAuditId').val(array);
	 patientSymAuditId=$('#patientSymAuditId').val();
	  userNameGlob=$('#userName').val();
	var patientId =$('#patientId').val();
	var unitId = $('#hospitalId').val();
	var userId = $('#userId').val();
	var departmentId=$('#departmentId').val();
	var params = {
			"patientId": patientId
	}
	 if(mode == 'ALL'){
		 nPageNo=1;
			var data = {'pageNo':nPageNo,'userId' : userId, 'patientId' : patientId,'patientSympotnsId':patientSymAuditId};			
		}
	else
		{
			var data =  {'pageNo':nPageNo,'patientId':patientId,'userId':userId, 'patientSympotnsId':patientSymAuditId}; 
		} 
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var urlShowRecommendedDiagnosisAllDetail = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/treatmentAudit/getRecommendedDiagnosisAllDetail";

	var url = urlShowRecommendedDiagnosisAllDetail;
	var bClickable = true;
	GetJsonDataForCommon('tblListOfCommand',data,url,bClickable,"waitingImgId",className,"recommendedDiagnosis","resultnavigationForRecommendedDiagnosis");

}

function showRecommendedDiagnosis(data) {

	var recommendedDiagnosisData = '';
	var readonlyForCuttentMedication = 'readonly';
	recommendedDiagnosisData += '<div class="autocomplete forTableResp">';
	var countNo = 1;
	if (data == null || data.length == 0) {
		recommendedDiagnosisData = recommendedDiagnosisData
				+ "<tr ><td colspan='3'><h6>No Record Found</h6></td></tr>";
		$("#recommendedDiagnosis").html(recommendedDiagnosisData);
		$("#modelForRecommendedDiagnosis").show();
		$(".modal-backdrop").show();
	}

	investigationGridValue = "recommendedDiagnosis";

	var counttt = $('#countValueRecommendedDiagnosis').val();
	if (counttt == "") {
		countNo = 1;
	} else {
		if (nPageNo == 1) {
			countNo = 1
		} else {
			countNo = counttt;
		}
	}
	var count = 1;
	var precriptionDtValues = $('#precriptionDtValue').val();
	var precriptionDtIdValArray = precriptionDtValues.split(",");

	for (var i = 0; i < data.length; i++) {
		recommendedDiagnosisData += '<tr>';

		recommendedDiagnosisData += '<td>' + countNo + '</td>';

		recommendedDiagnosisData += '<td>';
		recommendedDiagnosisData += '<div class="autocomplete forTableResp">';
		recommendedDiagnosisData += '<input type="text" autocomplete="never" tabindex="1" width="450px" value="'
				+ data[i].recomAuditDiagnosis + ']" ';
		/*
		 * recommendedDiagnosisData += 'id="nomenclatureCurrent' + countNo + '"
		 * name="nomenclatureCurrent" onKeyPress="autoCompleteCommon(this,2);"
		 * onblur="populatePVMSTreatment(this.value,'+count+',this);"';
		 */
		recommendedDiagnosisData += 'id="nomenclatureCurrentSSSS'
				+ countNo
				+ '"  name="nomenclatureCurrentSSSS"  onKeyUp="getNomenClatureList(this,\''
				+ func1 + '\',\'' + url1 + '\',\'' + url2 + '\',\'' + flaga
				+ '\');" ';
		recommendedDiagnosisData += 'class="form-control border-input width500"';
		recommendedDiagnosisData += '" ' + readonlyForCuttentMedication + '/>';
		recommendedDiagnosisData += '<input type="hidden"  name="itemId" value="'
				+ data[i].icdId
				+ '" id="nomenclatureId'
				+ data[i].itemId
				+ '"/>';
		recommendedDiagnosisData += '<input type="hidden"  name="communicableFlag" value="'
				+ data[i].communicableFlag
				+ '" id="communicableFlag'
				+ data[i].itemId + '"/>';
		recommendedDiagnosisData += '<input type="hidden"  name="infectiousFlag" value="'
				+ data[i].infectiousFlag
				+ '" id="infectiousFlag'
				+ data[i].itemId + '"/>';
        
		recommendedDiagnosisData += '<div id="nomenclatureIdPvs' + countNo
				+ '" class="autocomplete-itemsNew"></div>';
		recommendedDiagnosisData += '</div>';
		recommendedDiagnosisData += '</td>';
		recommendedDiagnosisData += '<td><input type="checkBox" name="repeatCheck" id="repeatCheck'+data[i].icdId+'" value="1"';
		recommendedDiagnosisData += 'tabindex="1"></td>';
		recommendedDiagnosisData += '</tr>';
		countNo++;
	}
	$('#countValueRecommendedDiagnosis').val(countNo);
	recommendedDiagnosisData += '</div">';
	$("#recommendedDiagnosis").html(recommendedDiagnosisData);
	$("#modelForRecommendedDiagnosis").show();
	$(".modal-backdrop").show();
	//}
	//});

}

function submitRecommendedAIForOpd()
{
	var tbl = document.getElementById('diagnosisGrid');
	lastRow = tbl.rows.length;
	var k = lastRow;
	var diagnosisCurrent="";
	investigationGridValue = "diagnosisGrid";
	var valeStop="";
	 var precriptionDtValueArray = [];
	 var countForCloseModel=0;
		var flagChcked=true;
	$('#recommendedDiagnosis tr').each(function(i, el) {
		
		
		
				var $tds = $(this).find('td');
		    
				var repeatId = $tds.eq(2).find(":input").attr("id");
		
				if (document.getElementById(repeatId).checked == true) {
					if(flagChcked==true)
					{
					 $("#diagnosisGrid tr").remove();
					}
				
				var sNo="";
				var itemIdName ="";
				var itemId="";
				
				if (document.getElementById(repeatId).checked == true) {
					
					var checkForExistPvs=true;
					var treatementValue=0;
					 itemId=$($tds).closest('tr').find("td:eq(1)").find("input:eq(1)").val();
					 var communicableFlag=$($tds).closest('tr').find("td:eq(1)").find("input:eq(2)").val();
	  					if(communicableFlag=="Y")
	  					{	
	  						communicableFlag="checked=checked";
	  					}
	  					else
	  					{
	  						communicableFlag="";
	  					}	
	  					var infectiousFlag=$($tds).closest('tr').find("td:eq(1)").find("input:eq(3)").val();
	  					if(infectiousFlag=="Y")
	  					{	
	  						infectiousFlag="checked=checked";
	  					}
	  					else
	  					{
	  						infectiousFlag="";
	  					}
					if(document.getElementById(repeatId).checked == true){ 
					$('#diagnosisGrid tr').each(function(i, el) {
						var $tds1 = $(this).find('td');
						 var itemIdForNomer=$tds1.eq(8).find(":input").val();;
						
						 if(itemIdForNomer==""){
								treatementValue+=1;
							}
						 
						 if(itemIdForNomer==itemId){
							checkForExistPvs=false;
							return false;
						}
						
					});
					}
					if(checkForExistPvs==false && document.getElementById(repeatId).checked == true ){
						alert(""+resourceJSON.msgForPVMSAlreadyExist);
						return false;
					}	
					 
					if(treatementValue>0){
						$("#diagnosisGrid tr").remove();
					}
					
				if(checkForExistPvs==true){
					
					
					
				diagnosisCurrent="";
				  sNo = $tds.eq(0).find(":input").val();
				
				  itemIdName=$($tds).closest('tr').find("td:eq(1)").find("input:eq(0)").val( );
				  itemId=$($tds).closest('tr').find("td:eq(1)").find("input:eq(1)").val( );
				 
				  
				  func1='newDiagnosisPopulate';
		 		   url1='opd';
		 		   url2='getIcdListByName';
		 		   flaga='dignosis';
		 		   
		 		    url3='treatmentAudit';
				    url4='getAllIcdForOpd';
				    flagb='mouseOver';
				    
				diagnosisCurrent += '<tr>';
				diagnosisCurrent += '<td>';
				diagnosisCurrent += '<div class="autocomplete forTableResp">';
				diagnosisCurrent += '<input type="text" autocomplete="off"  tabindex="1" size="77" onmouseup="getOpdNomenClatureList(this,\''+func1+'\',\''+url3+'\',\''+url4+'\',\''+flaga+'\',\''+flagb+'\');" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"  value="'+itemIdName+'"';
				diagnosisCurrent += 'id="diagnosisId' + k + '"  name="diagnosisId"';
				diagnosisCurrent += 'class="form-control border-input"';
				diagnosisCurrent += '" />';
				diagnosisCurrent += '<input type="hidden"  name="itemId" value="' + itemId + '" id="nomenclatureId'
						+ k + '"/>';
				diagnosisCurrent += '<div id="treatmentOpd'+k+'" class="autocomplete-itemsNew"></div>';
				diagnosisCurrent += '</div>';
                                  
				diagnosisCurrent += '</td>';

				diagnosisCurrent += '<td class="text-center width220"><div class="form-check form-check-inline cusCheck m-t-7"><input class="form-check-input" '+communicableFlag+' id="markDisease'+k+'" name="markDisease" type="checkbox" autocomplete="off"><span class="cus-checkbtn"></span></div> ';
				diagnosisCurrent += '</td>';

				diagnosisCurrent += '<td class="text-center width220"><div class="form-check form-check-inline cusCheck m-t-7"><input class="form-check-input" '+infectiousFlag+' id="markInfection'+k+'" name="markInfection" type="checkbox" autocomplete="off"><span class="cus-checkbtn"></span></div>';
				diagnosisCurrent += '</td>';
	
				diagnosisCurrent += '<td><button name="Button" type="button"';
				diagnosisCurrent += '	class="buttonAdd btn btn-primary noMinWidth" value="" button-type="add" onclick="addDiagnosis()"';
				diagnosisCurrent += '	tabindex="1" > </button></td>';

				diagnosisCurrent += '<td><button type="button" name="delete" id="deleteDiagnosisRow" value=""';
				diagnosisCurrent += 'class="buttonDel btn btn-danger noMinWidth" button-type="delete"';
				diagnosisCurrent += '	onclick="deleteDiagnosis(this);"';
				diagnosisCurrent += '	tabindex="1"> </button></td>';
				diagnosisCurrent += '<td style="display:none"><input  type="hidden" value="' + itemId + '" tabindex="1"';
				diagnosisCurrent += '	id="itemIdNom'+k+'" size="77" name="itemIdNom" /></td>';
				diagnosisCurrent += '<td style="display: none";>';
				diagnosisCurrent += '<input type="hidden" value="T" tabindex="1" id="diagnosisAuditFlag'+k+'" size="77" name="diagnosisAuditFlag" />';
				diagnosisCurrent += '</td>';

			
				diagnosisCurrent += '</tr>';
				k++;
				flagChcked=false;
				}
					$("#diagnosisGrid").append(diagnosisCurrent);
					closeRecommendedDiagnosis();
				  }
				}	
				
				
		});
	
}

function closeRecommendedDiagnosis(){
	//$('#recommendedDiagnosis').hide();
	$('#diagLoader').hide();
	$('#modelForRecommendedDiagnosis').hide();
	$('.modal-backdrop').hide();
	
	document.getElementById("additionalNote").focus();
	}

/////////////////////////////////////////////////End showAllAuditRecommendedDiagnosis ///////////////////////////////////////////////////

///////////////////////////Start showAllAuditRecommendedInvestigation ///////////////////////////////////////////

function showAllAuditRecommendedInvestigation(mode,className)
{
	$('modal-backdrop').show();
	var patientSymAuditId=$('#patientSymAuditId').val();
	var array = patientSymAuditId.split(',');
	array.sort(function(a, b) {
		  return a - b;
		});
	 $('#patientSymAuditId').val(array);
	 patientSymAuditId=$('#patientSymAuditId').val();
	  userNameGlob=$('#userName').val();
	var patientId =$('#patientId').val();
	var unitId = $('#hospitalId').val();
	var userId = $('#userId').val();
	var departmentId=$('#departmentId').val();
	var params = {
			"patientId": patientId
	}
	 if(mode == 'ALL'){
		 nPageNo=1;
			var data = {'pageNo':nPageNo,'userId' : userId, 'patientId' : patientId,'patientSympotnsId':patientSymAuditId};			
		}
	else
		{
			var data =  {'pageNo':nPageNo,'patientId':patientId,'userId':userId, 'patientSympotnsId':patientSymAuditId}; 
		} 
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var urlShowRecommendedDiagnosisAllDetail = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/treatmentAudit/getRecommendedInvestgationAllDetail";

	var url = urlShowRecommendedDiagnosisAllDetail;
	var bClickable = true;
	GetJsonDataForCommon('tblListOfCommand',data,url,bClickable,"waitingImgId",className,"recommendedInvestgation","resultnavigationForRecommendedDiagnosis");

}

function showRecommendedInvestgation(data) {

	var recommendedDiagnosisData = '';
	var readonlyForCuttentMedication = 'readonly';
	recommendedDiagnosisData += '<div class="autocomplete forTableResp">';
	var countNo = 1;
	if (data == null || data.length == 0) {
		recommendedDiagnosisData = recommendedDiagnosisData
				+ "<tr ><td colspan='2'><h6>No Record Found</h6></td></tr>";
		$("#recommendedInvestgation").html(recommendedDiagnosisData);
		$("#modelForRecommendedInvestgation").show();
		$(".modal-backdrop").show();
	}

	investigationGridValue = "recommendedInvestigation";

	var counttt = $('#countValueRecommendedInvestigation').val();
	if (counttt == "") {
		countNo = 1;
	} else {
		if (nPageNo == 1) {
			countNo = 1
		} else {
			countNo = counttt;
		}
	}
	var count = 1;
	var precriptionDtValues = $('#precriptionDtValue').val();
	var precriptionDtIdValArray = precriptionDtValues.split(",");

	for (var i = 0; i < data.length; i++) {
		recommendedDiagnosisData += '<tr>';

		recommendedDiagnosisData += '<td>' + countNo + '</td>';

		recommendedDiagnosisData += '<td>';
		recommendedDiagnosisData += '<div class="autocomplete forTableResp">';
		recommendedDiagnosisData += '<input type="text" autocomplete="never" tabindex="1" width="450px" value="'
				+ data[i].recomAuditInvstgationName +'" ';
		/*
		 * recommendedDiagnosisData += 'id="nomenclatureCurrent' + countNo + '"
		 * name="nomenclatureCurrent" onKeyPress="autoCompleteCommon(this,2);"
		 * onblur="populatePVMSTreatment(this.value,'+count+',this);"';
		 */
		recommendedDiagnosisData += 'id="nomenclatureCurrentSSSS'
				+ countNo
				+ '"  name="nomenclatureCurrentSSSS"  onKeyUp="getNomenClatureList(this,\''
				+ func1 + '\',\'' + url1 + '\',\'' + url2 + '\',\'' + flaga
				+ '\');" ';
		recommendedDiagnosisData += 'class="form-control border-input width500"';
		recommendedDiagnosisData += '" ' + readonlyForCuttentMedication + '/>';
		recommendedDiagnosisData += '<input type="hidden"  name="itemId" value="'
				+ data[i].recomAuditInvstgationId
				+ '" id="nomenclatureId'
				+ data[i].itemId
				+ '"/>';
		recommendedDiagnosisData += '<input type="hidden"  name="prescriptionHdIdCurrent" value="'
				+ data[i].precryptionHdId
				+ '" id="prescriptionHdIdCurrent'
				+ data[i].precryptionHdId + '"/>';
		recommendedDiagnosisData += '<input type="hidden"  name="prescriptionDtIdCurrent" value="'
				+ data[i].precriptionDtId
				+ '" id="precriptionDtIdCurrent'
				+ data[i].precriptionDtId + '"/>';

		recommendedDiagnosisData += '<div id="nomenclatureIdPvs' + countNo
				+ '" class="autocomplete-itemsNew"></div>';
		recommendedDiagnosisData += '</div>';
		recommendedDiagnosisData += '</td>';
		recommendedDiagnosisData += '</td>';
		recommendedDiagnosisData += '<td><input type="checkBox" name="repeatCheck" id="repeatCheck'+data[i].recomAuditInvstgationId+'" value="1"';
		recommendedDiagnosisData += 'tabindex="1"></td>';
		recommendedDiagnosisData += '</tr>';
		countNo++;
	}
	$('#countValueRecommendedDiagnosis').val(countNo);
	recommendedDiagnosisData += '</div">';
	$("#recommendedInvestgation").html(recommendedDiagnosisData);
	$("#modelForRecommendedInvestgation").show();
	$(".modal-backdrop").show();
	//}
	//});

}

function submitRecommendedAIInvestgationForOpd()
{
	var tbl = document.getElementById('dgInvetigationGrid');
	lastRow = tbl.rows.length;
	var k = lastRow;
	var investigationCurrent="";
	investigationGridValue = "dgInvetigationGrid";
	var valeStop="";
	 var precriptionDtValueArray = [];
	 var countForCloseModel=0;
	 var flagChckedInv=true;
	$('#recommendedInvestgation tr').each(function(i, el) {
		
		
		
				var $tds = $(this).find('td');
		    
				var repeatId = $tds.eq(2).find(":input").attr("id");
				
				
				var sNo="";
				var itemIdName ="";
				var itemId="";
				
				if (document.getElementById(repeatId).checked == true) {
					if(flagChckedInv==true)
					{
					 $("#dgInvetigationGrid tr").remove();
					}
					var checkForExistPvs=true;
					var treatementValue=0;
					 itemId=$($tds).closest('tr').find("td:eq(1)").find("input:eq(1)").val();
					
					if(document.getElementById(repeatId).checked == true){ 
					$('#dgInvetigationGrid tr').each(function(i, el) {
						var $tds1 = $(this).find('td');
						 var itemIdForNomer=$tds1.eq(2).find(":input").val();;
						
						 if(itemIdForNomer==""){
								treatementValue+=1;
							}
						 
						 if(itemIdForNomer==itemId){
							checkForExistPvs=false;
							return false;
						}
						
					});
					}
					if(checkForExistPvs==false && document.getElementById(repeatId).checked == true ){
						alert(""+resourceJSON.msgForPVMSAlreadyExist);
						return false;
					}	
					 
					/*if(treatementValue>0){
						$("#dgInvetigationGrid tr").remove();
					}*/
					
				if(checkForExistPvs==true){
					
					
					
				investigationCurrent="";
				  sNo = $tds.eq(0).find(":input").val();
				
				  itemIdName=$($tds).closest('tr').find("td:eq(1)").find("input:eq(0)").val( );
				  itemId=$($tds).closest('tr').find("td:eq(1)").find("input:eq(1)").val( );
				 
				  
				  func1='populateChargeCode';
		 		   url1='opd';
		 		   url2='getIinvestigationList';
		 		   flaga='investigation';
				investigationCurrent += '<tr>';
				investigationCurrent += '<td>';
				investigationCurrent += '<div class="autocomplete forTableResp">';
				investigationCurrent += '<input type="text" autocomplete="off"  tabindex="1" size="77" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"  value="'+itemIdName+'"';
				investigationCurrent += 'id="chargeCodeName' + k + '"  name="chargeCodeName"';
				investigationCurrent += 'class="form-control border-input"';
				investigationCurrent += '" />';
				investigationCurrent += '<input type="hidden"  name="itemId" value="' + itemId + '" id="nomenclatureId'
						+ k + '"/>';
				investigationCurrent += '<div id="treatmentOpd'+k+'" class="autocomplete-itemsNew"></div>';
				investigationCurrent += '</div>';
                                  
				investigationCurrent += '<td style="display:none"><input  type="hidden" value="' + itemId + '" tabindex="1"';
				investigationCurrent += '	id="itemIdNom'+k+'" size="77" name="itemIdNom" /></td>';
				investigationCurrent += '<td><button name="Button" type="button"';
				investigationCurrent += '	class="buttonAdd btn btn-primary noMinWidth" value="" button-type="add" onclick="addRowForInvestigation()"';
				investigationCurrent += '	tabindex="1" > </button></td>';

				investigationCurrent += '<td><button type="button" name="delete" id="deleteDiagnosisRow" value=""';
				investigationCurrent += 'class="buttonDel btn btn-danger noMinWidth" button-type="delete"';
				investigationCurrent += '	onclick="removeRowInvestigationOpd(this);"';
				investigationCurrent += '	tabindex="1"> </button></td>';
				investigationCurrent += '<td style="display: none";>';
				investigationCurrent += ' <input type="hidden" value="T" tabindex="1" id="invetgationAuditFlag" size="77" name="invetgationAuditFlag" />';
				investigationCurrent += '</td>';
			

			
				investigationCurrent += '</tr>';
				k++;
				flagChckedInv=false;
				}
				    $("#dgInvetigationGrid").append(investigationCurrent);
					closeRecommendedInvestgation();
				 }
				
				
				
		});
	
}

function closeRecommendedInvestgation(){
	//$('#recommendedDiagnosis').hide();
	$('#invesLoader').hide();
	$('#modelForRecommendedInvestgation').hide();
	$('.modal-backdrop').hide();
	
	document.getElementById("additionalNote").focus();
	}

/////////////////////////////////////End show recommended investgation /////////////////////////////////////

function showAllAuditRecommendedTreatment(mode,className)
{
	$('modal-backdrop').show();
	var patientSymAuditId=$('#patientSymAuditId').val();
	var array = patientSymAuditId.split(',');
	array.sort(function(a, b) {
		  return a - b;
		});
	 $('#patientSymAuditId').val(array);
	 patientSymAuditId=$('#patientSymAuditId').val();
	  userNameGlob=$('#userName').val();
	var patientId =$('#patientId').val();
	var unitId = $('#hospitalId').val();
	var userId = $('#userId').val();
	var departmentId=$('#departmentId').val();
	var params = {
			"patientId": patientId
	}
	 if(mode == 'ALL'){
		 nPageNo=1;
			var data = {'pageNo':nPageNo,'userId' : userId, 'patientId' : patientId,'patientSympotnsId':patientSymAuditId,'departmentId':departmentId,'mmuId1':hsId};			
		}
	else
		{
			var data =  {'pageNo':nPageNo,'patientId':patientId,'userId':userId, 'patientSympotnsId':patientSymAuditId,'departmentId':departmentId,'mmuId1':hsId}; 
		} 
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var urlShowRecommendedDiagnosisAllDetail = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/treatmentAudit/getRecommendedTreatmentAllDetail";

	var url = urlShowRecommendedDiagnosisAllDetail;
	var bClickable = true;
	GetJsonDataForCommon('tblListOfCommand',data,url,bClickable,"waitingImgId",className,"recommendedTreatment","resultnavigationForRecommendedDiagnosis");

}

function showRecommendedTreatment(data) {

	var recommendedDiagnosisData = '';
	var readonlyForCuttentMedication = 'readonly';
	recommendedDiagnosisData += '<div class="autocomplete forTableResp">';
	var countNo = 1;
	if (data == null || data.length == 0) {
		recommendedDiagnosisData = recommendedDiagnosisData
				+ "<tr ><td colspan='2'><h6>No Record Found</h6></td></tr>";
		$("#recommendedTreatment").html(recommendedDiagnosisData);
		$("#modelForRecommendedTreatment").show();
		$(".modal-backdrop").show();
	}

	investigationGridValue = "recommendedTreatment";

	var counttt = $('#countValueRecommendedTreatment').val();
	if (counttt == "") {
		countNo = 1;
	} else {
		if (nPageNo == 1) {
			countNo = 1
		} else {
			countNo = counttt;
		}
	}
	var count = 1;
	var precriptionDtValues = $('#precriptionDtValue').val();
	var precriptionDtIdValArray = precriptionDtValues.split(",");

	for (var i = 0; i < data.length; i++) {
		recommendedDiagnosisData += '<tr>';

		recommendedDiagnosisData += '<td>' + countNo + '</td>';

		recommendedDiagnosisData += '<td>';
		recommendedDiagnosisData += '<div class="autocomplete forTableResp">';
		recommendedDiagnosisData += '<input type="text" autocomplete="never" tabindex="1" width="450px" value="'
				+ data[i].recomAuditTreatmentName + ']" ';
		/*
		 * recommendedDiagnosisData += 'id="nomenclatureCurrent' + countNo + '"
		 * name="nomenclatureCurrent" onKeyPress="autoCompleteCommon(this,2);"
		 * onblur="populatePVMSTreatment(this.value,'+count+',this);"';
		 */
		recommendedDiagnosisData += 'id="nomenclatureCurrentSSSS'
				+ countNo
				+ '"  name="nomenclatureCurrentSSSS"  onKeyUp="getNomenClatureList(this,\''
				+ func1 + '\',\'' + url1 + '\',\'' + url2 + '\',\'' + flaga
				+ '\');" ';
		recommendedDiagnosisData += 'class="form-control border-input width500"';
		recommendedDiagnosisData += '" ' + readonlyForCuttentMedication + '/>';
		recommendedDiagnosisData += '<input type="hidden"  name="itemId" value="'
				+ data[i].recomAuditTreatmentId
				+ '" id="nomenclatureId'+data[i].recomAuditTreatmentId+''
				+ '"/>';
		recommendedDiagnosisData += '<input type="hidden"  name="dispunit" value="'
			+ data[i].dispUnitId
			+ '" id="dispunit'+data[i].recomAuditTreatmentId+''
			+ '"/>';
		recommendedDiagnosisData += '<input type="hidden"  name="itemClassId" value="'
			+ data[i].itemClassId
			+ '" id="itemClassId'+data[i].recomAuditTreatmentId+''
			+ '"/>';


		recommendedDiagnosisData += '<div id="nomenclatureIdPvs' + countNo
				+ '" class="autocomplete-itemsNew"></div>';
		recommendedDiagnosisData += '</div>';
		recommendedDiagnosisData += '</td>';
		recommendedDiagnosisData += '<td><input type="checkBox" name="repeatCheck'+countNo+'" id="repeatCheck'+countNo+data[i].recomAuditTreatmentId+'" value="1"';
		recommendedDiagnosisData += 'tabindex="1"></td>';
		recommendedDiagnosisData += '</tr>';
		countNo++;
	}
	$('#countValueRecommendedTreatment').val(countNo);
	recommendedDiagnosisData += '</div">';
	$("#recommendedTreatment").html(recommendedDiagnosisData);
	$("#modelForRecommendedTreatment").show();
	$(".modal-backdrop").show();
	//}
	//});

}

function closeRecommendedTreatment(){
	//$('#recommendedDiagnosis').hide();
	$('#treatLoader').hide();
	$('#modelForRecommendedTreatment').hide();
	$('.modal-backdrop').hide();
	
	document.getElementById("additionalNote").focus();
	}

function submitRecommendedAITreatmentForOpd()
{
	var tbl = document.getElementById('nomenclatureGrid');
	lastRow = tbl.rows.length;
	var k = lastRow;
	var investigationCurrent="";
	var trHTML="";
	investigationGridValue = "nomenclatureGrid";
	var valeStop="";
	 var precriptionDtValueArray = [];
	 var countForCloseModel=0;
	 var checkForExistPvs=true;
	$('#recommendedTreatment tr').each(function(i, el) {
		
		
		
				var $tds = $(this).find('td');
		    
				var repeatId = $tds.eq(2).find(":input").attr("id");
				
				
				var sNo="";
				var itemIdName ="";
				var itemId="";
				var dispUnitId="";
				var itemClassId="";

				if (document.getElementById(repeatId).checked == true) {
					if(checkForExistPvs==true)
					{
					 $("#nomenclatureGrid tr").remove();
					}
					
					var treatementValue=0;
					 itemId=$($tds).closest('tr').find("td:eq(1)").find("input:eq(1)").val();
					 itemIdName=$($tds).closest('tr').find("td:eq(1)").find("input:eq(0)").val();
					 dispUnitId=$($tds).closest('tr').find("td:eq(1)").find("input:eq(2)").val();
					 itemClassId=$($tds).closest('tr').find("td:eq(1)").find("input:eq(3)").val();
					if(document.getElementById(repeatId).checked == true){
					/*$('#nomenclatureGrid tr').each(function(i, el) {
						var $tds1 = $(this).find('td');
						 var itemIdForNomer=$tds1.eq(2).find(":input").val();;
						
						 if(itemIdForNomer==""){
								treatementValue+=1;
							}
						 
						 if(itemIdForNomer==itemId){
							checkForExistPvs=false;
							return false;
						}
						
					});
					}
					if(checkForExistPvs==false && document.getElementById(repeatId).checked == true ){
						alert(""+resourceJSON.msgForPVMSAlreadyExist);
						return false;
					}	
					 
					if(treatementValue>0){
						$("#nomenclatureGrid tr").remove();
					}*/
					
				//if(checkForExistPvs==true){
					
					
					
					var treatmentItemId=itemId;
					var itemIdName=itemIdName;
					/*var dosage=item.dosage;
					var itemClassId=item.itemClassId;
					var itemIdCode=item.itemIdCode;
					var frequencyId=item.frequencyId;
					var frequencyName=item.frequencyName;
					var total=item.total;
					var noOfDays=item.noOfDays;
					var instrcution=item.instrcution;*/
					var dispUnit=dispUnitId;
					//var availableStock=item.availableStock;
					
					var selectFre="";
					var selectInst="";
					var dispStock="";
					var funcTr='populatePVMS';
					var  urlTr='opd';
					var urlNameTr='getMasStoreItemList';
					var flagaTr='numenclature';
						
					
					if(treatmentItemId!=null && treatmentItemId!=undefined && treatmentItemId!=""){
						$('#nomenclatureGrid tr').each(function(ihh, el) {
											var $tds = $(this) .find('td')
											var chargeCodeId = $($tds).closest('tr').find("td:eq(8)").find("input:eq(0)").val();
											 // investigationIdValu = $('#'+chargeCodeId).val();
											if (treatmentItemId == chargeCodeId) {
												flagForcheck1 = false;
												trHTML='';
											}
											// j++;
										});
						}
					
				/*	if(flagForcheck1== true)
					{*/
					/*if(availableStock==0)
				    {
					trHTML='<tr><td><div class="autocomplete forTableResp"><input style="border: 5px solid red" type="text" value="'+itemIdName+''+'['+itemIdCode+']'+'" tabindex="1" id="nomenclature11'+i+'""  size="77" name="nomenclature1" class="form-control width330" onKeyUp="getNomenClatureList(this,\''+funcTr+'\',\''+urlTr+'\',\''+urlNameTr+'\',\''+flagaTr+'\');" /> <div id="nomenclatureIdPvs" class="autocomplete-itemsNew"></div></div></td>';
				    }
					else
					{*/
					  trHTML='<tr><td><div class="autocomplete forTableResp"><input type="text" value="'+itemIdName+'" tabindex="1" id="nomenclature11'+i+'""  size="77" name="nomenclature1" class="form-control width330" onKeyUp="getNomenClatureList(this,\''+funcTr+'\',\''+urlTr+'\',\''+urlNameTr+'\',\''+flagaTr+'\');" /> <div id="nomenclatureIdPvs" class="autocomplete-itemsNew"></div></div></td>';	
					//}	
					trHTML += '<td ><select name="au1Treatment" id="au1Treatment'+i+'" class="medium form-control width100"';
					trHTML += '<option value=""><strong>Select</strong></option>';

					var selectFre = "";
					$.each(masDispUnitList, function(ijk, item1) {

						if (dispUnit == item1.storeUnitId) {
							selectFre = "selected";
						} else {
							selectFre = "";
						}
						trHTML += '<option ' + selectFre
								+ ' value="' + item1.storeUnitId + '">'
								+ item1.storeUnitName + '</option>';
						
					});
					trHTML += '</select>';
					trHTML += '</td>';
					trHTML +='<td><input type="text" name="dosage1" onkeypress="return event.charCode != 32" onblur="fillValueNomenclature()" tabindex="1" value="" id="dosage1'+i+'" size="5" maxlength="5" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  class="form-control width60" /></td>';
    				trHTML +='<td><select name="frequency1" id="frequency1" onchange="fillValueNomenclature()" class="medium form-control width150"';
					trHTML +='class="medium">';
					trHTML +='<option value=""><strong>Select...</strong></option>';
					$.each(massFrequencyList, function(ij, item) {
					    
																
						/*if(frequencyId == item.frequencyId){
							selectFre="selected";
						}
						else{
							selectFre="";
						}*/
						selectFre="";
						trHTML += '<option '+selectFre+' value="' + item.feq + '@'
						+ item.frequencyId + '" >' + item.frequencyName+'</option>';
					
					//trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationValue+''+'['+investigationId+']'+'" id="chargeCodeName" class="form-control border-input" name="chargeCodeName" onblur="populateChargeCode(this.value);putInvestigationValue(this)" /> <input type="hidden" id="qty" tabindex="1" name="qty1" size="10" maxlength="6" validate="Qty,num,no" /> <input type="hidden" tabindex="1" id="chargeCodeCode"	name="chargeCodeCode" size="10" readonly /> </div></td><td><input type="Date" id="investigationDate1" name="investigationDate" class="input_date" placeholder="DD/MM/YYYY" value="" maxlength="10" /></td><td><div class="labRadiologyDivfixed"></div> <input type="radio" value="I" id="othAfLab1'+i+'" class="radioCheckCol2" style="margin-right: 15px;" name="labradiologyCheck1'+i+'" /></td><td><div class="labRadiologyDivfixed"></div> <input type="radio" value="O" id="othAfLab1'+i+'" class="radioCheckCol2" style="margin-right: 15px;" name="labradiologyCheck1'+i+'"/></td><td><input type="checkbox" name="urgent" id="uCheck" tabindex="1" class="radioAuto" value="1" /><td style="display:none";><input type="hidden" value="'+investigationId+'" tabindex="1" id="inestigationIdval" size="77" name="inestigationIdval" /></td> </td><td><button type="button" type="button" class="btn btn-primary buttonAdd" value="" tabindex="1"	onclick="addRowForInvestigation();">Add</button></td><td><button type="button" name="delete" value="" class="buttonDel btn btn-danger" tabindex="1" onclick="removeRow("dgInvetigationGrid","hiddenValue",this);">Delete</button></td></tr>';
					});
					trHTML +='</select>';
					trHTML +='</td>';
					trHTML+='<td><input type="text" name="noOfDays1" onkeypress="return event.charCode != 32" value="" tabindex="1" id="noOfDays1'+i+'" onblur="fillValueNomenclature()" size="5" maxlength="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" class="form-control width60" /></td>';
					var itemClassIdTablet="3";
			        var itemClassIdCapusle="4";
			        var itemClassIdInjection="5";
			        if(itemClassId==itemClassIdTablet || itemClassId==itemClassIdCapusle || itemClassId==itemClassIdInjection)
				    {
					trHTML+='<td><input type="text" onkeypress="return event.charCode != 32" value="" name="total1" tabindex="1" id="total1'+i+'"  size="5" validate="total,num,no" class="form-control width70"/></td>';
				    }
			        else
			        {
			        	trHTML+='<td><input type="text" onkeypress="return event.charCode != 32" value="1"  name="total1" tabindex="1" id="total1'+i+'" size="5" validate="total,num,no" class="form-control width70"/></td>';
							
			        }	
					trHTML +='<td><select name="instuctionFill" id="instuctionFill'+i+'" class="medium form-control width150"';
					trHTML +='class="medium">';
					trHTML +='<option value=""><strong>Select...</strong></option>';
					var instctionData=massTempInstructionList;
					$.each(massTempInstructionList, function(ik, item) {
					    
																
					/*	if(instrcution == item.instructionsName){
							selectInst="selected";
						}
						else{
							selectInst="";
						}*/
						selectInst="";
						trHTML += '<option '+selectInst+' value="'+ item.instructionsName +'">' + item.instructionsName+'</option>';
					
					//trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationValue+''+'['+investigationId+']'+'" id="chargeCodeName" class="form-control border-input" name="chargeCodeName" onblur="populateChargeCode(this.value);putInvestigationValue(this)" /> <input type="hidden" id="qty" tabindex="1" name="qty1" size="10" maxlength="6" validate="Qty,num,no" /> <input type="hidden" tabindex="1" id="chargeCodeCode"	name="chargeCodeCode" size="10" readonly /> </div></td><td><input type="Date" id="investigationDate1" name="investigationDate" class="input_date" placeholder="DD/MM/YYYY" value="" maxlength="10" /></td><td><div class="labRadiologyDivfixed"></div> <input type="radio" value="I" id="othAfLab1'+i+'" class="radioCheckCol2" style="margin-right: 15px;" name="labradiologyCheck1'+i+'" /></td><td><div class="labRadiologyDivfixed"></div> <input type="radio" value="O" id="othAfLab1'+i+'" class="radioCheckCol2" style="margin-right: 15px;" name="labradiologyCheck1'+i+'"/></td><td><input type="checkbox" name="urgent" id="uCheck" tabindex="1" class="radioAuto" value="1" /><td style="display:none";><input type="hidden" value="'+investigationId+'" tabindex="1" id="inestigationIdval" size="77" name="inestigationIdval" /></td> </td><td><button type="button" type="button" class="btn btn-primary buttonAdd" value="" tabindex="1"	onclick="addRowForInvestigation();">Add</button></td><td><button type="button" name="delete" value="" class="buttonDel btn btn-danger" tabindex="1" onclick="removeRow("dgInvetigationGrid","hiddenValue",this);">Delete</button></td></tr>';
					});
					trHTML +='</select>';
					trHTML +='</td>';
			    	trHTML +='<td><input type="text" name="closingStock1" value="" tabindex="1" id="closingStock1" size="3" class="form-control width80" readonly /></td>';
			    	trHTML +='<td style="display: none;"><input type="hidden" value="'+treatmentItemId+'" tabindex="1" id="itemIdNom11'+i+'" size="77" name="itemIdNom" /></td><td><button type="button" class="btn btn-primary buttonAdd noMinWidth" name="button" button-type="add" value="" onclick="addNomenclatureRow();" tabindex="1"></button></td><td><button type="button" class="buttonDel  btn btn-danger noMinWidth" name="button" id="deleteNomenclature" button-type="delete" value="" onclick="removeTreatmentRow(this);"" tabindex="1"></button></td><td style="display: none;"><input type="hidden" name="pvmsNo1" tabindex="1" id="pvmsNo1" size="10" readonly="readonly" /></td><td style="display: none;"><input type="hidden" name="itemClassId" tabindex="1" id="itemClassId" value="'+itemClassId+'" size="10" readonly="readonly" /><td style="display: none";><input type="hidden" value="T" tabindex="1" id="treatmentAuditFlag" size="77" name="treatmentAuditFlag" /></td>	</td>';
			    	trHTML +='</tr>';
			    	
			    	k++;
			    	checkForExistPvs=false;
					}
						$('#nomenclatureGrid').append(trHTML);	
						closeRecommendedTreatment();
					 }
					/* }
					}
					$('#nomenclatureGrid').append(trHTML);	
					closeRecommendedTreatment();*/
				//}
				
		});

}

////////////////////////////// for opd recall ///////////////////////////

function showAllAuditRecommendedDiagnosisRecall(mode,className)
{
	$('modal-backdrop').show();
	var patientSymAuditId=$('#patientSymAuditId').val();
	var array = patientSymAuditId.split(',');
	array.sort(function(a, b) {
		  return a - b;
		});
	 $('#patientSymAuditId').val(array);
	 patientSymAuditId=$('#patientSymAuditId').val();
	  userNameGlob=$('#userName').val();
	var patientId =$('#patientId').val();
	var unitId = $('#hospitalId').val();
	var userId = $('#userId').val();
	var departmentId=$('#departmentId').val();
	var params = {
			"patientId": patientId
	}
	 if(mode == 'ALL'){
		 nPageNo=1;
			var data = {'pageNo':nPageNo,'userId' : userId, 'patientId' : patientId,'patientSympotnsId':patientSymAuditId};			
		}
	else
		{
			var data =  {'pageNo':nPageNo,'patientId':patientId,'userId':userId, 'patientSympotnsId':patientSymAuditId}; 
		} 
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var urlShowRecommendedDiagnosisAllDetail = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/treatmentAudit/getRecommendedDiagnosisAllDetail";

	var url = urlShowRecommendedDiagnosisAllDetail;
	var bClickable = true;
	GetJsonDataForCommon('tblListOfCommand',data,url,bClickable,"waitingImgId",className,"recommendedDiagnosisRecall","resultnavigationForRecommendedDiagnosis");

}

function showRecommendedDiagnosisRecall(data) {

	var recommendedDiagnosisData = '';
	var readonlyForCuttentMedication = 'readonly';
	recommendedDiagnosisData += '<div class="autocomplete forTableResp">';
	var countNo = 1;
	if (data == null || data.length == 0) {
		recommendedDiagnosisData = recommendedDiagnosisData
				+ "<tr ><td colspan='3'><h6>No Record Found</h6></td></tr>";
		$("#recommendedDiagnosis").html(recommendedDiagnosisData);
		$("#modelForRecommendedDiagnosis").show();
		$(".modal-backdrop").show();
	}

	investigationGridValue = "recommendedDiagnosis";

	var counttt = $('#countValueRecommendedDiagnosis').val();
	if (counttt == "") {
		countNo = 1;
	} else {
		if (nPageNo == 1) {
			countNo = 1
		} else {
			countNo = counttt;
		}
	}
	var count = 1;
	var precriptionDtValues = $('#precriptionDtValue').val();
	var precriptionDtIdValArray = precriptionDtValues.split(",");

	for (var i = 0; i < data.length; i++) {
		recommendedDiagnosisData += '<tr>';

		recommendedDiagnosisData += '<td>' + countNo + '</td>';

		recommendedDiagnosisData += '<td>';
		recommendedDiagnosisData += '<div class="autocomplete forTableResp">';
		recommendedDiagnosisData += '<input type="text" autocomplete="never" tabindex="1" width="450px" value="'
				+ data[i].recomAuditDiagnosis + ']" ';
		/*
		 * recommendedDiagnosisData += 'id="nomenclatureCurrent' + countNo + '"
		 * name="nomenclatureCurrent" onKeyPress="autoCompleteCommon(this,2);"
		 * onblur="populatePVMSTreatment(this.value,'+count+',this);"';
		 */
		recommendedDiagnosisData += 'id="nomenclatureCurrentSSSS'
				+ countNo
				+ '"  name="nomenclatureCurrentSSSS"  onKeyUp="getNomenClatureList(this,\''
				+ func1 + '\',\'' + url1 + '\',\'' + url2 + '\',\'' + flaga
				+ '\');" ';
		recommendedDiagnosisData += 'class="form-control border-input width500"';
		recommendedDiagnosisData += '" ' + readonlyForCuttentMedication + '/>';
		recommendedDiagnosisData += '<input type="hidden"  name="itemId" value="'
				+ data[i].icdId
				+ '" id="nomenclatureId'
				+ data[i].itemId
				+ '"/>';
		recommendedDiagnosisData += '<input type="hidden"  name="communicableFlag" value="'
				+ data[i].communicableFlag
				+ '" id="communicableFlag'
				+ data[i].itemId + '"/>';
		recommendedDiagnosisData += '<input type="hidden"  name="infectiousFlag" value="'
				+ data[i].infectiousFlag
				+ '" id="infectiousFlag'
				+ data[i].itemId + '"/>';
        
		/*recommendedDiagnosisData += '<div id="nomenclatureIdPvs' + countNo
				+ '" class="autocomplete-itemsNew"></div>';
		recommendedDiagnosisData += '</div>';
		recommendedDiagnosisData += '</td>';
		recommendedDiagnosisData += '<td><input type="checkBox" name="repeatCheck" id="repeatCheck'+data[i].icdId+'" value="1"';
		recommendedDiagnosisData += 'tabindex="1"></td>';*/
		recommendedDiagnosisData += '</tr>';
		countNo++;
	}
	$('#countValueRecommendedDiagnosis').val(countNo);
	recommendedDiagnosisData += '</div">';
	$("#recommendedDiagnosis").html(recommendedDiagnosisData);
	$("#modelForRecommendedDiagnosis").show();
	$(".modal-backdrop").show();
	//}
	//});

}

function showAllAuditRecommendedInvestigationRecall(mode,className)
{
	$('modal-backdrop').show();
	var patientSymAuditId=$('#patientSymAuditId').val();
	var array = patientSymAuditId.split(',');
	array.sort(function(a, b) {
		  return a - b;
		});
	 $('#patientSymAuditId').val(array);
	 patientSymAuditId=$('#patientSymAuditId').val();
	  userNameGlob=$('#userName').val();
	var patientId =$('#patientId').val();
	var unitId = $('#hospitalId').val();
	var userId = $('#userId').val();
	var departmentId=$('#departmentId').val();
	var params = {
			"patientId": patientId
	}
	 if(mode == 'ALL'){
		 nPageNo=1;
			var data = {'pageNo':nPageNo,'userId' : userId, 'patientId' : patientId,'patientSympotnsId':patientSymAuditId};			
		}
	else
		{
			var data =  {'pageNo':nPageNo,'patientId':patientId,'userId':userId, 'patientSympotnsId':patientSymAuditId}; 
		} 
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var urlShowRecommendedDiagnosisAllDetail = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/treatmentAudit/getRecommendedInvestgationAllDetail";

	var url = urlShowRecommendedDiagnosisAllDetail;
	var bClickable = true;
	GetJsonDataForCommon('tblListOfCommand',data,url,bClickable,"waitingImgId",className,"recommendedInvestgationRecall","resultnavigationForRecommendedDiagnosis");

}

function showRecommendedInvestgationRecall(data) {

	var recommendedDiagnosisData = '';
	var readonlyForCuttentMedication = 'readonly';
	recommendedDiagnosisData += '<div class="autocomplete forTableResp">';
	var countNo = 1;
	if (data == null || data.length == 0) {
		recommendedDiagnosisData = recommendedDiagnosisData
				+ "<tr ><td colspan='2'><h6>No Record Found</h6></td></tr>";
		$("#recommendedInvestgation").html(recommendedDiagnosisData);
		$("#modelForRecommendedInvestgation").show();
		$(".modal-backdrop").show();
	}

	investigationGridValue = "recommendedInvestigation";

	var counttt = $('#countValueRecommendedInvestigation').val();
	if (counttt == "") {
		countNo = 1;
	} else {
		if (nPageNo == 1) {
			countNo = 1
		} else {
			countNo = counttt;
		}
	}
	var count = 1;
	var precriptionDtValues = $('#precriptionDtValue').val();
	var precriptionDtIdValArray = precriptionDtValues.split(",");

	for (var i = 0; i < data.length; i++) {
		recommendedDiagnosisData += '<tr>';

		recommendedDiagnosisData += '<td>' + countNo + '</td>';

		recommendedDiagnosisData += '<td>';
		recommendedDiagnosisData += '<div class="autocomplete forTableResp">';
		recommendedDiagnosisData += '<input type="text" autocomplete="never" tabindex="1" width="450px" value="'
				+ data[i].recomAuditInvstgationName +'" ';
		/*
		 * recommendedDiagnosisData += 'id="nomenclatureCurrent' + countNo + '"
		 * name="nomenclatureCurrent" onKeyPress="autoCompleteCommon(this,2);"
		 * onblur="populatePVMSTreatment(this.value,'+count+',this);"';
		 */
		recommendedDiagnosisData += 'id="nomenclatureCurrentSSSS'
				+ countNo
				+ '"  name="nomenclatureCurrentSSSS"  onKeyUp="getNomenClatureList(this,\''
				+ func1 + '\',\'' + url1 + '\',\'' + url2 + '\',\'' + flaga
				+ '\');" ';
		recommendedDiagnosisData += 'class="form-control border-input width500"';
		recommendedDiagnosisData += '" ' + readonlyForCuttentMedication + '/>';
		recommendedDiagnosisData += '<input type="hidden"  name="itemId" value="'
				+ data[i].recomAuditInvstgationId
				+ '" id="nomenclatureId'
				+ data[i].itemId
				+ '"/>';
		recommendedDiagnosisData += '<input type="hidden"  name="prescriptionHdIdCurrent" value="'
				+ data[i].precryptionHdId
				+ '" id="prescriptionHdIdCurrent'
				+ data[i].precryptionHdId + '"/>';
		recommendedDiagnosisData += '<input type="hidden"  name="prescriptionDtIdCurrent" value="'
				+ data[i].precriptionDtId
				+ '" id="precriptionDtIdCurrent'
				+ data[i].precriptionDtId + '"/>';

		recommendedDiagnosisData += '<div id="nomenclatureIdPvs' + countNo
				+ '" class="autocomplete-itemsNew"></div>';
		/*recommendedDiagnosisData += '</div>';
		recommendedDiagnosisData += '</td>';
		recommendedDiagnosisData += '</td>';
		recommendedDiagnosisData += '<td><input type="checkBox" name="repeatCheck" id="repeatCheck'+data[i].recomAuditInvstgationId+'" value="1"';
		recommendedDiagnosisData += 'tabindex="1"></td>';*/
		recommendedDiagnosisData += '</tr>';
		countNo++;
	}
	$('#countValueRecommendedDiagnosis').val(countNo);
	recommendedDiagnosisData += '</div">';
	$("#recommendedInvestgation").html(recommendedDiagnosisData);
	$("#modelForRecommendedInvestgation").show();
	$(".modal-backdrop").show();
	//}
	//});

}

function showAllAuditRecommendedTreatmentRecall(mode,className)
{
	$('modal-backdrop').show();
	var patientSymAuditId=$('#patientSymAuditId').val();
	var array = patientSymAuditId.split(',');
	array.sort(function(a, b) {
		  return a - b;
		});
	 $('#patientSymAuditId').val(array);
	 patientSymAuditId=$('#patientSymAuditId').val();
	  userNameGlob=$('#userName').val();
	var patientId =$('#patientId').val();
	var unitId = $('#hospitalId').val();
	var userId = $('#userId').val();
	var departmentId=$('#departmentId').val();
	var params = {
			"patientId": patientId
	}
	 if(mode == 'ALL'){
		 nPageNo=1;
			var data = {'pageNo':nPageNo,'userId' : userId, 'patientId' : patientId,'patientSympotnsId':patientSymAuditId,'departmentId':departmentId,'mmuId1':hsId};			
		}
	else
		{
			var data =  {'pageNo':nPageNo,'patientId':patientId,'userId':userId, 'patientSympotnsId':patientSymAuditId,'departmentId':departmentId,'mmuId1':hsId}; 
		} 
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var urlShowRecommendedDiagnosisAllDetail = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/treatmentAudit/getRecommendedTreatmentAllDetail";

	var url = urlShowRecommendedDiagnosisAllDetail;
	var bClickable = true;
	GetJsonDataForCommon('tblListOfCommand',data,url,bClickable,"waitingImgId",className,"recommendedTreatmentRecall","resultnavigationForRecommendedDiagnosis");

}

function showRecommendedTreatmentRecall(data) {

	var recommendedDiagnosisData = '';
	var readonlyForCuttentMedication = 'readonly';
	recommendedDiagnosisData += '<div class="autocomplete forTableResp">';
	var countNo = 1;
	if (data == null || data.length == 0) {
		recommendedDiagnosisData = recommendedDiagnosisData
				+ "<tr ><td colspan='2'><h6>No Record Found</h6></td></tr>";
		$("#recommendedTreatment").html(recommendedDiagnosisData);
		$("#modelForRecommendedTreatment").show();
		$(".modal-backdrop").show();
	}

	investigationGridValue = "recommendedTreatment";

	var counttt = $('#countValueRecommendedTreatment').val();
	if (counttt == "") {
		countNo = 1;
	} else {
		if (nPageNo == 1) {
			countNo = 1
		} else {
			countNo = counttt;
		}
	}
	var count = 1;
	var precriptionDtValues = $('#precriptionDtValue').val();
	var precriptionDtIdValArray = precriptionDtValues.split(",");

	for (var i = 0; i < data.length; i++) {
		recommendedDiagnosisData += '<tr>';

		recommendedDiagnosisData += '<td>' + countNo + '</td>';

		recommendedDiagnosisData += '<td>';
		recommendedDiagnosisData += '<div class="autocomplete forTableResp">';
		recommendedDiagnosisData += '<input type="text" autocomplete="never" tabindex="1" width="450px" value="'
				+ data[i].recomAuditTreatmentName + ']" ';
		/*
		 * recommendedDiagnosisData += 'id="nomenclatureCurrent' + countNo + '"
		 * name="nomenclatureCurrent" onKeyPress="autoCompleteCommon(this,2);"
		 * onblur="populatePVMSTreatment(this.value,'+count+',this);"';
		 */
		recommendedDiagnosisData += 'id="nomenclatureCurrentSSSS'
				+ countNo
				+ '"  name="nomenclatureCurrentSSSS"  onKeyUp="getNomenClatureList(this,\''
				+ func1 + '\',\'' + url1 + '\',\'' + url2 + '\',\'' + flaga
				+ '\');" ';
		recommendedDiagnosisData += 'class="form-control border-input width500"';
		recommendedDiagnosisData += '" ' + readonlyForCuttentMedication + '/>';
		recommendedDiagnosisData += '<input type="hidden"  name="itemId" value="'
				+ data[i].recomAuditTreatmentId
				+ '" id="nomenclatureId'+data[i].recomAuditTreatmentId+''
				+ '"/>';
		recommendedDiagnosisData += '<input type="hidden"  name="dispunit" value="'
			+ data[i].dispUnitId
			+ '" id="dispunit'+data[i].recomAuditTreatmentId+''
			+ '"/>';
		

		/*recommendedDiagnosisData += '<div id="nomenclatureIdPvs' + countNo
				+ '" class="autocomplete-itemsNew"></div>';
		recommendedDiagnosisData += '</div>';
		recommendedDiagnosisData += '</td>';
		recommendedDiagnosisData += '<td><input type="checkBox" name="repeatCheck" id="repeatCheck'+data[i].recomAuditTreatmentId+'" value="1"';
		recommendedDiagnosisData += 'tabindex="1"></td>';*/
		recommendedDiagnosisData += '</tr>';
		countNo++;
	}
	$('#countValueRecommendedTreatment').val(countNo);
	recommendedDiagnosisData += '</div">';
	$("#recommendedTreatment").html(recommendedDiagnosisData);
	$("#modelForRecommendedTreatment").show();
	$(".modal-backdrop").show();
	//}
	//});

}

