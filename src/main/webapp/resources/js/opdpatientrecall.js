var func1='';
var url1='';
var url2='';
var flaga='';
function patientExaminationDignosisData() {
	
	var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";
	var urlgetExaminationDetail = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/getExaminationDetail?patientId=";
	
	var visitId = $('#visitId').val();
	var opdObesityHd="";
	var data = {
		"visitId" : visitId
	};
	$.ajax({

		type : "POST",
		contentType : "application/json",
		url : urlgetExaminationDetail,

		data : JSON.stringify(data),
		dataType : "json",
		// cache: false,

		success : function(data) {
			if (data != undefined && data != null) {
				
				
				$('#workingdiagnosis').val(data.data[0].workingdiagnosis);
				//$('#chiefCompliant').val(data.data[0].patientSymptons);
				$('#pastMedicalHistory').val(data.data[0].patientPastHistory);
				$('#snomeddiagnosis').val(data.data[0].snomeddiagnosis);
				
				 if(data.data[0].overweightFlag!=null){
					var overweightFlag= data.data[0].overweightFlag;
					if(overweightFlag!="" && overweightFlag=='Y'){
						$("#overCheck").prop("checked", true);
						$("#overWeightDropDown").show();
						$('#obsistyMark').val("Y");
						overWeight("Y");
					}
					if(overweightFlag!="" && overweightFlag=='N'){
						$("#obsistyCheck").prop("checked", true);
						$("#overWeightDropDown").hide();
						$('#obsistyMark').val("N");
						overWeight("N");
					}
					if(overweightFlag!="" && overweightFlag=='A'){
						$("#noneCheck").prop("checked", true);
						$("#overWeightDropDown").hide();
						$('#obsistyMark').val("A");
						overWeight("A");
					}
				 }
				
			}
			
			
		}
	});

	return false;
}
var investigationGridValue = "investigationGrid";
var investigationData = '';
function patientInvestigationData() {
	
	var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";
	var urlgetInvestigationDetail = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/getInvestigationDetail?patientId=";
	
	investigationGridValue = "investigationGrid";
	var visitId = $('#visitId').val();
	var opdPatientDetailId=$('#opdPatientDetailId').val();
	var patientId=$('#patientId').val();
	var data = {
		"visitId" : visitId,
		"opdPatientDetailId":opdPatientDetailId,
		"patientId":patientId,
		"flagForModule":"opdrec"
	};
	$ .ajax({
				type : "POST",
				contentType : "application/json",
				url : urlgetInvestigationDetail,
				data : JSON.stringify(data),
				dataType : "json",
				// cache: false,

				success : function(res) {
					data = res.listObject;
					if (data != null && data.length > 0) {
						$('#hinId').val(data.length + 1);
						$('#departmentId').val(data[0].departId);
						// $('#hospitalId').val(data[0].hospitalId);
					}
					var count = 1;
					var countins = 1;
					var investigationfinalValue = "";
					
					  func1='populateChargeCode';
		    		   url1='opd';
		    		   url2='getIinvestigationList';
		    		   flaga='investigation';

					
					if (data != null && data.length > 0) {
						for (var i = 0; i < data.length; i++) {
							 
							var orderStustus=data[i].orderStustus;
							var disableFlagVal=""
							var dateForReadonly="";	
							if(orderStustus!="" && orderStustus=='C'||orderStustus=='c'){
								disableFlagVal="disabled";
								dateForReadonly='readonly';
							}
							else{
								disableFlagVal="";
								dateForReadonly="";
							}
							
							investigationData += '<tr>';
							
							//var valInvestigation =$('#dgInvetigationGrid').children('tr:first').children('td:eq(0)').find(':input')[0]
							//investigationData += '<td style="display:none">'+autocomplete(valInvestigation, arryInvestigation)+'</td>';
							
							investigationData += '<td><div   class="autocomplete forTableResp">';
							investigationData += '<input type="text"   value="'
									+ data[i].investigationName + '['
									+ data[i].investigationId
									+ ']" id="chargeCodeName' + count + '"';
							investigationData += ' class="form-control border-input" name="chargeCodeName" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" '+dateForReadonly+'/>';
							investigationData += '<input type="hidden" id="qty" tabindex="1" name="qty1"  maxlength="6"/>';
							investigationData += '<input type="hidden" tabindex="1" id="chargeCodeCode"';
							investigationData += 'name="chargeCodeCode"/>';
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
							investigationData+=' <div id="investigationDiv'+count+'" class="autocomplete-itemsNew"></div>';
							investigationData += ' </div></td>';

							
							
							/*investigationData += '<td> <input type="radio"  value="O" '
									+ checkedradioForO
									+ ' id="othAfLab1'
									+ count
									+ '" class="radioCheckCol21" style="margin-right: 15px;" ';
							investigationData += 'name="othAfLab' + count + '"';
							investigationData += 'onchange="#"/></td>';*/
						

							investigationData += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth" button-type="add" value="" ';
							investigationData += 'onclick="addRowForInvestigationFun();"';
							investigationData += '	tabindex="1" > </button></td>';

							investigationData += '<td><button type="button" name="delete" value="" button-type="delete" id="deleteInves"';
							investigationData += 'class="buttonDel btn btn-danger noMinWidth"';
							investigationData += 'onclick="removeRowInvestigation(this,\'' + investigationGridValue + '\','
									+ data[i].dgOrderDtId + ');"';
							investigationData += '	tabindex="1" '+disableFlagVal+'></button></td>';
							investigationData += ' </tr> ';
							count++;
						}

						/*investigationData += '<input type="hidden" value='
								+ count + ' name="hiddenValue"';
						investigationData += 'id="hiddenValue" />';*/
						/*if (data[0] != null
								&& data[0].otherInvestigation != null)
							$("#otherInvestigation").val(
									data[0].otherInvestigation);*/
						$("#dgInvetigationGrid").html(investigationData);
						
						
						
						if (data != null && data.length > 0) {
							$('#templateOfInvest').hide();
						} else {
							$('#templateOfInvest').show();
						}
					}

				}
			});

	return false;
}
var count = 1;
function patientTreatementDetail() {
	
	var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";
	var urlgetTreatmentPatientDetail = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/getTreatmentPatientDetail?patientId=";
	
	var visitId = $('#visitId').val();
	var opdPatientDetailId = $('#opdPatientDetailId').val();
	var data = {
		"visitId" : visitId,
		"opdPatientDetailId":opdPatientDetailId
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
					// var itemTypeIdPvms=res.itemTypeIdPvms;
					var frequencyList = res.MasFrequencyList;
					var masInstructionTreatment=res.masTreatmentInstruction;
					var treatementData = '';

					var pvmsTreatementData="";
					var nivTreatementData="";
					var countForPvms=0;
					var countForNiv=0;
					var stopedByUser="";
					var itemStopStatus="";
					var selectInst="";
					var instruction ="";
					var status ="";
					var instctionData=massTempInstructionList;
					treatementData += '<div class="autocomplete forTableResp">';
					nivTreatementData += '<div class="autocomplete forTableResp">';
					var countNo = 1;
					if (data == null || data.length == 0) {
						try{
							$('#dispensingUnit1').html(trHTMLDispUnit);
						}
						catch(e){}
						return false;
					}
					investigationGridValue = "nomenclatureGrid";
					var disableFlagVal=""
						var disableForDeletButton="";
					for (var i = 0; i < data.length; i++) {
						
						var orderStustus=data[i].status;
						itemStopStatus=data[i].itemStopStatus;
							if(orderStustus!="" && orderStustus=='C'||orderStustus=='c' || itemStopStatus==1){
								disableFlagVal="readonly";
								disableForDeletButton="disabled";
							}
							else{
								disableFlagVal="";
								disableForDeletButton="";
							}
						
						
					//	if(data[i].itemTypeId==itemTypeIdPvms){
						
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
					/*	treatementData += '  onKeyPress="autoCompleteCommon(this,2);" onKeyUp="autoCompleteCommon(this,2);" onKeyDown="autoCompleteCommon(this,2);" onblur="populatePVMSTreatment(this.value,'+count+',this);" />';*/
						treatementData += '  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" '+disableFlagVal+'/>';
						treatementData += '<input type="hidden"  name="itemId" value="'
								+ data[i].itemId
								+ '" id="nomenclatureId'
								+ countForPvms + '"/>';
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

						
						
						/*treatementData += '<td><input type="text" value="'
								+ data[i].dispStock
								+ '" name="dispensingUnit1" ';
						treatementData += ' id="dispensingUnit1" size="6"';
						treatementData += 'validate="AU,string,no"   class="form-control" '+disableFlagVal+'/>';
						treatementData += '</td>';
*/
						
						treatementData += '<td ><select name="dispensingUnit1" class="form-control" id="dispensingUnit1'+ countForPvms + '" ';
						treatementData += 'class="medium">';
						var dispStock = data[i].dispUnitId;
						treatementData += '<option value=""><strong>Select</strong></option>';

						var selectFre = "";
						$.each(masDispUnitList, function(ijk, item1) {

							if (dispStock == item1.storeUnitId) {
								selectFre = "selected";
							} else {
								selectFre = "";
							}
							treatementData += '<option ' + selectFre
									+ ' value="' + item1.storeUnitId + '">'
									+ item1.storeUnitName + '</option>';
						});
						treatementData += '</select>';
						treatementData += '</td>';
						
						
						
						treatementData += '<td><input type="text" onkeypress="return checkValidate(event);" class="form-control" size="5" name="dosage1" tabindex="1" onblur="fillValueNomenclature(1)" ';
						treatementData += 'value=' + data[i].dosage
								+ ' id="dosage1"  maxlength="5" '+disableFlagVal+'/>';
						treatementData += '</td>';

						treatementData += '<td ><select name="frequencyTre" class="form-control" id="frequencyTre'+ countNo + '" onchange="fillValueNomenclature(1)"';
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
							treatementData += '<option ' + selectFre	+ ' value="'+ item.feq + '@' + item.frequencyId	+ '">' + item.frequencyName+ '</option>';
						});
						treatementData += '</select>';
						treatementData += '</td>';
                        if(data[i].noOfDays!=undefined && data[i].noOfDays!="")
                        {	
						treatementData += '	<td><input type="text" onkeypress="return checkValidate(event);" class="form-control" value="'
								+ data[i].noOfDays
								+ '" name="noOfDays1" tabindex="1"';
						treatementData += '	id="noOfDays1'+ countNo + '" onblur="fillValueNomenclature(1)" size="5"';
						treatementData += '	maxlength="3" validate="No of Days,num,no"  '+disableFlagVal+'/></td>';
                        }
                        else
                        {
                        treatementData += '	<td><input type="text" class="form-control" value="" name="noOfDays1" tabindex="1"';
						treatementData += '	id="noOfDays1'+ countNo + '" size="3"';
						treatementData += '	maxlength="3" /></td>';	
                        }	
                        treatementData += '	<td><input type="text" onkeypress="return checkValidate(event);" class="form-control" value="'
							+ data[i].total
							+ '" name="total1" tabindex="1"';
                        treatementData += '	id="total1'+ countNo + '" size="5"';
                        treatementData += '	maxlength="3" '+disableFlagVal+'/></td>';

						/*treatementData += '<td><input type="text" class="form-control" tabindex="1" value="'
								+ data[i].instruction + '" name="remarks1" ';
						treatementData += 'id="remarks1" size="10" maxlength="10" '+disableFlagVal+'/>';
						treatementData += '</td>';*/
						//instruction = data[i].instruction;
						treatementData +='<td><select name="instuctionFill" id="instuctionFill'+ countNo + '" class="medium form-control width150"';
						treatementData +='class="medium">';
						treatementData +='<option value=""><strong>Select...</strong></option>';
						$.each(masInstructionTreatment, function(ik, item) {
						    
																	
							if(data[i].instruction == item.instructionsName){
								selectInst="selected";
							}
							else{
								selectInst="";
							}
							
							treatementData += '<option '+selectInst+' value="'+ item.instructionsName +'">' + item.instructionsName+'</option>';
						
						//trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationValue+''+'['+investigationId+']'+'" id="chargeCodeName" class="form-control border-input" name="chargeCodeName" onblur="populateChargeCode(this.value);putInvestigationValue(this)" /> <input type="hidden" id="qty" tabindex="1" name="qty1" size="10" maxlength="6" validate="Qty,num,no" /> <input type="hidden" tabindex="1" id="chargeCodeCode"	name="chargeCodeCode" size="10" readonly /> </div></td><td><input type="Date" id="investigationDate1" name="investigationDate" class="input_date" placeholder="DD/MM/YYYY" value="" maxlength="10" /></td><td><div class="labRadiologyDivfixed"></div> <input type="radio" value="I" id="othAfLab1'+i+'" class="radioCheckCol2" style="margin-right: 15px;" name="labradiologyCheck1'+i+'" /></td><td><div class="labRadiologyDivfixed"></div> <input type="radio" value="O" id="othAfLab1'+i+'" class="radioCheckCol2" style="margin-right: 15px;" name="labradiologyCheck1'+i+'"/></td><td><input type="checkbox" name="urgent" id="uCheck" tabindex="1" class="radioAuto" value="1" /><td style="display:none";><input type="hidden" value="'+investigationId+'" tabindex="1" id="inestigationIdval" size="77" name="inestigationIdval" /></td> </td><td><button type="button" type="button" class="btn btn-primary buttonAdd" value="" tabindex="1"	onclick="addRowForInvestigation();">Add</button></td><td><button type="button" name="delete" value="" class="buttonDel btn btn-danger" tabindex="1" onclick="removeRow("dgInvetigationGrid","hiddenValue",this);">Delete</button></td></tr>';
						});
						treatementData +='</select>';
						treatementData +='</td>';
                       	
						treatementData += '	<td><input type="text" class="form-control" name="closingStock1" tabindex="1"  value="'
								+ data[i].storeStoke + '"';
						treatementData += 'id="closingStock1'+ countNo + '" size="3"';
						treatementData += 'validate="closingStock,string,no" readonly/></td>';
                      
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
						treatementData += '	tabindex="1" > </button></td>';

						treatementData += '<td><button type="button" name="delete" id="treatementId" button-type="delete" value=""';
						treatementData += 'class="buttonDel btn btn-danger noMinWidth"';
						treatementData += '	onclick="removeRowInvestigation(this,\''
								+ investigationGridValue
								+ '\','
								+ data[i].precriptionDtId + ');"';
						treatementData += '	tabindex="1" '+disableForDeletButton+'></button></td>';
						}
						treatementData += '<td style="display: none;"><input type="hidden" name="pvmsNo1" tabindex="1"';
						treatementData += '	id="pvmsNo1'+countNo+'" size="10" readonly="readonly" />';
						treatementData += '</td>';
						
						treatementData += '<td style="display: none;"><input type="hidden"';
						treatementData += 'name="itemClassId" tabindex="1" value="'+data[i].itemClassId+'" id="itemClassId'+countNo+'" size="10"';
						treatementData += 'readonly="readonly" /></td>	';
					
						treatementData += '</tr>';
						countForPvms+=1;
						
						//}
						
						countNo++;
					}
					treatementData += '</div">';
					nivTreatementData+= '</div">';
		     		if(countForPvms>0)
					$("#nomenclatureGrid").html(treatementData);
					
					if (countForPvms > 0) {
						$('#templateTreatment').hide();
					} else {
						$('#templateTreatment').show();
					}
										
					var tb2 = document.getElementById('nomenclatureGrid');
					var lastRow2 = tb2.rows.length;
					if(lastRow2==1 && itemStopStatus==1){
						addNomenclatureRowRecall();
					}
				}
			});

	return false;
}

function patientHistoryData() {
	
	var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";
	var urlgetPatientHistoryDetail = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/getPatientHistoryDetail?visitId=";
	
	var visitId = $('#visitId').val();
	var patientId=$('#patientId').val();
	var data = {
		"visitId" : visitId,
		"patientId":patientId
	};
	$.ajax({

		type : "POST",
		contentType : "application/json",
		url : urlgetPatientHistoryDetail,
		data : JSON.stringify(data),
		dataType : "json",
		// cache: false,
		success : function(res) {
			data = res.listOpdPatientHistory;
			//var listPatientImpantHistory=res.listPatientImpantHistory;
			var count=1;
			for (var i = 0; i < data.length; i++) {
				//$('#chiefCompliant').val(data[i].chiefComplaint);
				$('#pastMedicalHistory').val(data[i].pastMedicalHistory);
				/*$('#implantHistory').val(data[i].implantHistory);*/
			}
			
		}
	});

	return false;
}


var im=0;
function addImplantTableRe()
{
	

	var tbl = document.getElementById('tableImplant');
	var lastRow = tbl.rows.length;
	k = lastRow+1;
	im =k;
	var aClone = $('#tableImplant>tr:last').clone(true)
	aClone.find(":input").val("");
	aClone.find('img.ui-datepicker-trigger').remove();
	aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'deviceId'+im+'');
	aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'deviceName'+im+'');
	aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'dateOfImplant'+im+'');
	aClone.find("td:eq(3)").find("input:eq(0)").prop('id', 'implantRemarks'+im+'');
	aClone.find('input[type="text"]').removeAttr("readonly", false);
	aClone.find("td:eq(3)").find("input:eq(0)").prop('readonly', false);
	aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'dateOfImplant'+im+'').removeClass('noFuture_date hasDatepicker').addClass('noFuture_date');

	aClone.find("option[selected]").removeAttr("selected");
	aClone.clone(true).appendTo('#tableImplant');	

}
function removeImplantDataRe(val){
	if($('#tableImplant tr').length > 1) {
		   $(val).closest('tr').remove()
		 }

}

var globalDataForReferal = "";
var globalReferalDatHtml = "";
//var globalOpdDisposalDetails="";
function getPatientReferalDetail() {
	var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";
	var urlgetPatientReferalDetail = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/getPatientReferalDetail?patientId=";
	
	var opdPatientDetailId = $('#opdPatientDetailId').val();
	var patientId = $('#patientId').val();
	var visitId = $('#visitId').val();
	var hospitalId = $('#hospitalId').val();
	var cityId=$('#cityIdVal').val();
	var masIcdList = "";
	var data = {
		"opdPatientDetailId" : opdPatientDetailId,
		"patientId" : patientId,
		"visitId" : visitId,
		"flagForRefer":"Ex",
		"cityId":cityId,
		"hospitalId":hospitalId
	};
	$.ajax({

				type : "POST",
				contentType : "application/json",
				url : urlgetPatientReferalDetail,
				data : JSON.stringify(data),
				dataType : "json",
				// cache: false,
				success : function(res) {
					data = res.listReferralPatientDt;
					
					masEmpanaledList = res.masEmpanelledHospitalList;
					
					masIcdList = res.listMasIcd;
				
					var masHospitalList = res.masMasHospitalList;
					var masDepartment=res.departmentList;
					
					globalDataForReferal = res.listReferralPatientDt;
					
					
					var referrDtData = "";
					var count = 1;
					investigationGridValue = "referrDtData";
					var diagnosisValue = "";
					var diagonisisIdValue = "";
					$("#referalGridNew tr").remove();
					var referalPatientDtIds = "";
					var referalNotes = "";
					var referVisitDates = "";
					var hospitalIdValue="";
					
					
					var statusOfExtOrInt=0;
					
					
					
					if (data != undefined && data.length != 0) {
						for (var i = 0; i < data.length; i++) {
					
							referrDtData += '<tr ">';
							
							referrDtData += '<td style="display:none;">' + count + '</td>';
							
							referrDtData += '<td><select class="referHospitalListClass form-control" id="referHospitalList'
									+ i + '" name="referHospitalList"';
							referrDtData += 'class="medium">';
							var masEmpanalId = data[i].masEmpanalId;
							referrDtData += '<option value=""><strong>Please select hospital</strong></option>';
							var selectMasEmpalHos = "";
						
							if(masEmpanalId!=null){
								statusOfExtOrInt+=1;
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
							
							}
							else{
								hospitalIdValue=data[i].intHospitalId;
								var masHospitalId = data[i].intHospitalId;
								var selectMasHosSelect = "";
								$.each(masHospitalList,function(ij, masHos) {
									if (masHospitalId == masHos.hospitalId) {
										selectMasHosSelect = 'selected';
											} else {
												selectMasHosSelect = "";
											}
											referrDtData += '<option  ' + selectMasHosSelect + ' value="' + masHos.hospitalId + '@' + masHos.hospitalId + '">' + masHos.hospitalName
													+ '</option>';
										});
							}
							
							referrDtData += '</select>';
							referrDtData += '</td>';
							
							referrDtData += '<td>';
							if(masEmpanalId!=null){
						 
								
								var exDepartmentValue = data[i].exDepartmentValue;
								
								referrDtData += '<select class="form-control" id="departmentValue'
									+ i + '" name="departmentValue"';
								referrDtData += 'class="medium">';
								  referrDtData += '<option value=""><strong>Select Department...</strong></option>';
								var selectDepart="";
								//var specialistHtml = '<option value=""><strong>Select Department...</strong></option>';
								
			 					$.each(masSpecialistList, function(i, item) {
			 						
			 						if (exDepartmentValue.trim() == item.specialityName.trim()) {
										selectDepart = 'selected';
									} else {
										selectDepart = "";
									}
			 						referrDtData += '<option '+selectDepart+' value="'+ item.specialityName + '" >' + item.specialityName
			 								+ '</option>';
			 						//$('.referSpecialistList').html(specialistHtml);
			 					});
			 					
								referrDtData += '</select>';
								
								
								
							/*referrDtData += '<input type="text" class="form-control departmentListClass" id="departmentValue'
									+ i
									+ '" name="departmentValue" value="'
									+ data[i].exDepartmentValue + '" />';*/
							
							}
							
							else{
								var masDepartMentId = data[i].intDepartmentId;
								
								referrDtData += '<select class="form-control" id="departmentValue'
									+ i + '" name="departmentValue"';
								referrDtData += 'class="medium">';
								  referrDtData += '<option value=""><strong>Select Department...</strong></option>';
								var selectDepart="";
								$.each(masDepartment, function(i, item) {
									
									if (masDepartMentId == item.departmentId) {
										selectDepart = 'selected';
									} else {
										selectDepart = "";
									}
									referrDtData += '<option '+selectDepart+' value="' + item.departmentId + '@'
									+ item.departmentId + '" >' + item.departmentName
									+ '</option>';
								});
								referrDtData += '</select>';
							 
							}
							referrDtData += '<input type="hidden" id="diagonsisId'
									+ i
									+ '" name="diagonsisId" value="'
									+ data[i].diagonisId + '"/>';
							referrDtData += '<input type="hidden"  name="masEmpanalHospitalId" value="'
									+ hospitalIdValue
									+ '" id="masEmpanalHospitalId"/>';
							referrDtData += '<input type="hidden"  name="masDepatId" value="'
									+ data[i].masDepatId
									+ '" id="masDepatId"/>';

							referrDtData += '<input type="hidden"  name="referalPatientDt" value="'
									+ data[i].referalPatientDt
									+ '" id="referalPatientDt"/>';
							referrDtData += '<input type="hidden"  name="referalPatientHd" value="'
									+ data[0].referalPatientHd
									+ '" id="referalPatientHd"/>';

							referrDtData += '</td>';
							
							
							//referrDtData += '<td><button name="Button" type="button" class="buttonAdd btn btn-primary noMinWidth" id="referalDtIdAdd" button-type="add" value="" tabindex="1" onclick="addRowForReferalPatient();"> </button></td>';
							//referrDtData += '<td><button type="button" name="delete" value="" id="referalDtIdDel"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" onclick="removeRowInvestigationReferal(this,\''
									+ investigationGridValue
									+ '\','
									+ data[i].referalPatientDt
									+ ');" ></button></td>';
							referrDtData += '</tr>';
							
							//document.getElementById("option2").selected = true;
							
							count++;
							diagnosisValue += data[i].daiganosisName + "["
									+ data[i].masCode + "]" + "##";
							diagonisisIdValue += data[i].diagonisId + "&&";
							referalPatientDtIds += data[i].referalPatientDt
									+ "&&";
						}
						document.getElementById("option2").selected = true;
						$('#referralNote').val(data[0].referalNotes);
						$('#doctorRemarks').val(data[0].doctorNote);

						$("#referalGridNew").html(referrDtData);
						$("#referDiv").show();
					   
					}
					
					
				}
	          
			});

	return false;
}
function deleteInvestigatRow(flag, valueForDelete, visitId, opdPatientDetailId,
		patientId) {
	
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var urldeleteGridRow = window.location.protocol + "//"+ window.location.host + "/" + accessGroup+ "/opd/deleteGridRow";

	var data = {
		"valueForDelete" : valueForDelete,
		"flag" : flag,
		"visitId" : visitId,
		"opdPatientDetailId" : opdPatientDetailId,
		"patientId" : patientId
	};
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : urldeleteGridRow,
		data : JSON.stringify(data),
		dataType : "json",
		cache : false,
		success : function(res) {
			/*if (flag == "3") {
				getPatientReferalDetail();
			}
			if (flag == "5") {
				getPocedureDetailData();
			}*/
			
			if(flag == "a1010"){
				getAllergyHistory('ALL','SearchStatusForMassDesignation');
			}
			if(flag == "600"){
				getPocedureDetailData();
			}
			
			return "2";
		}
	});

	//return "1";
}
var massFrequencyList='';
function getFrequencyDetailTre() {

	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//" + window.location.host + "/"
			+ accessGroup + "/opd/getMasFrequency";
	// var url = "http://localhost:8082/AshaServices/opdmaster/getMasFrequency";
	$.ajax({
		url : url,
		dataType : "json",
		data : JSON.stringify({
			'employeeId' : '1'
		}),
		contentType : "application/json",
		type : "POST",
		success : function(response) {
			// console.log(response);
			var datas = response.MasFrequencyList;
			massFrequencyList=datas;
			var trHTML = "";
			trHTML += '<option value=""><strong>Select</strong></option>';
			$.each(datas, function(i, item) {
				trHTML += '<option value="' + item.feq + '@' + item.frequencyId + '" >'
				+ item.frequencyName + '</option>';
			});
			$('#frequencyTre').html(trHTML);

		},
		error : function(e) {

			// console.log("ERROR: ", e);

		},
		done : function(e) {
			// console.log("DONE");
			alert("success");
			var datas = e.data;

		}
	});

}
function addRowForReferalPatient() {
	
	//var val = parseInt($('#referalGridNew>tr:last').find("td:eq(0)").text());
	var sNO=0;
	
	var tbl = document.getElementById('referalGridNew');
	var lastRow = tbl.rows.length;
	k = lastRow+1;
	sNO=lastRow;
	k++;
	sNO++;
	var aClone = $('#referalGridNew>tr:last').clone(true)
	aClone.find("td:eq(0)").html(sNO);
	aClone.find('select').prop('id', 'referHospitalList' + k + '');
	aClone.find("td:eq(2)").find("select:eq(0)").prop('id','departmentValue' + k + '');
	aClone.find("td:eq(2)").find("input:eq(1)").prop('id','masEmpanalHospitalId' + k + '');
	aClone.find("td:eq(2)").find("input:eq(2)").prop('id','masDepatId' + k + '');
	aClone.find("td:eq(2)").find("input:eq(3)").prop('id','referalPatientDt' + k + '');
	aClone.find("td:eq(2)").find("input:eq(4)").prop('id','referalPatientHd' + k + '');
	
	
	
	aClone.find("td:eq(3)").find("textarea:eq(0)").prop('id','diagonsisText' + k + '');
	 
	aClone.find("td:eq(3)").find("div").find("div").prop('id', 'icdDiagnosisReferal' + k + '');
	
	aClone.find("td:eq(4)").find("input:eq(0)").prop('id','hos' + k + '');
	//aClone.find("td:eq(0)").text(++val);
	aClone.find(":input").val("");
	aClone.find("option[selected]").removeAttr("selected")
	aClone.clone(true).appendTo('#referalGridNew');
	$('#referalGridNew>tr:last').find("td:eq(6)").find("button:eq(0)").attr("id", "newIdRef");
	/*var val = $('#referalGridNew>tr:last').find("td:eq(3)").find(":input")[0];
	autocomplete(val, arry);*/
}

function removeRowInvestigation(val, investigationGrid, investigationData) {

	var tbl = document.getElementById('dgInvetigationGrid');
	var lastRow = tbl.rows.length;
	
	var msg=resourceJSON.msgDelete;
	
	if (confirm(msg)) {
		// var i = val.parentNode.parentNode.rowIndex;
		if (investigationGrid == "investigationGrid" && lastRow == '1') {
			$("#messageDelete").show();
			return false;
		}
		var tb2 = document.getElementById('nomenclatureGrid');
		var lastRow2 = tb2.rows.length;

		if (investigationGrid == "nomenclatureGrid" && lastRow2 == '1') {
			$("#messageDelete").show();
			return false;
		}

		var tb3 = document.getElementById('gridNursing');
		var lastRow3 = tb3.rows.length;

		if (investigationGrid == "gridNursing" && lastRow3 == '1') {
			$("#messageDelete").show();
			return false;
		}
		
		var tb40 = document.getElementById('diagnosisGridRecall');
		var lastRow40 = tb40.rows.length;

		if (investigationGrid == "diagnosisGridRecall" && lastRow40 == '1') {
			$("#messageDelete").show();
			return false;
		}

		
		try{
		var tb5 = document.getElementById('allergyHistoryGrid');
		var lastRow5 = tb5.rows.length;
		if (investigationGrid == "allergyHistoryGrid" && lastRow5 == '1') {
			$("#messageDelete").show();
			return false;
		}
		}
		catch(e){}
		$(val).closest('tr').remove();
				
		var flag = 0;
		if ((val.id != "newIdInv" && investigationGrid == "investigationGrid")
				|| (val.id != "newIdTre" && investigationGrid == "nomenclatureGrid")
				|| (val.id != "newIdRef" && investigationGrid == "referrDtData")
				|| (val.id != "newIdProcedure" && investigationGrid == "gridNursing")
				|| (val.id != "newAllergyHistoryDelete" && investigationGrid == "allergyHistoryGrid")
				|| (val.id != "diagnosisGridRecall" && investigationGrid == "diagnosisGridRecall")
		) {
			if (investigationGrid == "investigationGrid"
					&& investigationData != "") {
				flag = 1;
				deleteInvestigatRow(flag, investigationData, "", "", "");
			}
			if (investigationGrid == "nomenclatureGrid"
					&& investigationData != "") {
				flag = 2;
				deleteInvestigatRow(flag, investigationData, "", "", "");
			}
			if (investigationGrid == "referrDtData" && investigationData != "") {
				flag = 3;
				deleteInvestigatRow(flag, investigationData, "", "", "");
			}
			
			if (investigationGrid == "diagnosisGridRecall" && investigationData != "") {
				flag = 40;
				deleteInvestigatRow(flag, investigationData, "", "", "");
			}

			if (investigationGrid == "gridNursing" && investigationData != "") {
				flag = 5;
				deleteInvestigatRow(flag, investigationData, "", "", "");
			}
			if (investigationGrid == "disposalGrid" && investigationData != "") {
				flag = "600";
				deleteInvestigatRow(flag, investigationData, "", "", "");
			}
			if (investigationGrid == "allergyHistoryGrid" && investigationData != "") {
				flag = "a1010";
				deleteInvestigatRow(flag, investigationData, "", "", "");
			}
			
			
		}
	}
}

function removeRowInvestigationReferal(val, investigationGrid,
		investigationData) {
	if (confirm("are you sure want to delete ?")) {
		var tb3 = document.getElementById('referalGridNew');
		var lastRow3 = tb3.rows.length;
			var diagnosisIdForDelete= $(val).closest('tr').find("td:eq(2)").find("input:eq(1)").attr("id") ;
	  		 var diagnosisIdValue = $('#'+diagnosisIdForDelete).val();
	  		 var diagnosisIdValue11 =	document.getElementById(diagnosisIdForDelete).value;
	         	  $("#diagnosisId > option")
					.each( function() {
								var diagonsisValue = this.value;
								if(diagnosisIdValue==diagonsisValue){
									$("#diagnosisId option[value="+diagnosisIdValue+"]").remove();
									return false;
								}
							});

	         	  
		if (investigationGrid == "referrDtData" && lastRow3 == '1') {
			$("#messageDelete").show();
			return false;
		}

		
		$(val).closest('tr').remove();
		var flag = 0;
		if (val.id != "newIdRef" && investigationGrid == "referrDtData") {

			if (investigationGrid == "referrDtData" && investigationData != "") {
				flag = 3;
				deleteInvestigatRow(flag, investigationData, "", "", "");
			}
		}
	}
}

function closeDelete() {
	$("#messageDelete").hide();

}
function closeSubmit() {
	$("#messageSubmit").hide();

}


var markInfectionRecallArray = [];
var markDiseaseRecallArray = [];
var diagonsisTextArray=[]; 
function radioInvest() {
	

	
	$('#diagnosisGridRecall tr').each(function(i, el) {

		var diagnosisValue= $(this).find("td:eq(0)").find("input:eq(0)").val();
		 var diagonsisTextValue=diagnosisValue.split("[");
		diagonsisTextArray.push(diagonsisTextValue[0]);
		var diseaseId = $(this).find("td:eq(1)").find("input:eq(0)").attr("id");
		var infectionId = $(this).find("td:eq(2)").find("input:eq(0)").attr("id");
		var disease ="";
		var infection="";
		if (document.getElementById(diseaseId).checked == true) {
			disease = 'Y';
		} else {
			disease = 'N';
		}
		markDiseaseRecallArray.push(disease);
		
		if (document.getElementById(infectionId).checked == true) {
			infection = 'Y';
		} else {
			infection = 'N';
		}
		markInfectionRecallArray.push(infection);
	});
	$('#icdDiagnosisValeText').val(diagonsisTextArray);
	$('#markDiseaseRecallValue').val(markDiseaseRecallArray);
	$('#markInfectionRecallValue').val(markInfectionRecallArray);
}


function getReferalDataForAdd(flagForReferal) {

	//document.getElementById("referExternal").checked = true;
	investigationGridValue = "referrDtData";

	// $("#referalGridNew tr").remove();
	var flagBydefault = false;
	if ($("#referralForNew").val() == 1) {
		//checkReferTORecall('referExternal');

		if(flagForReferal!=null && flagForReferal=='internal'){
		$("#referInternal").attr('checked', true);
		}
		else{
		 $("#referExternal").attr('checked', 'checked');
		}
		 var j = 1;
		if (globalDataForReferal == null || globalDataForReferal.length == 0) {
			$("#referalGridNew tr").remove();
		} else {
			$("#referalGridNew tr").remove();
			$('#referalGridNew').append(globalReferalDatHtml);
		}
		var hospitalId=$('#hospitalId').val();
		var cityId=$('#cityIdVal').val();
	    var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";	
		var url="";
		 url = window.location.protocol + "//" + window.location.host + "/"
			+ accessGroup + "/opd/getEmpanelledHospital";
		
		$.ajax({
					url : url,
					dataType : "json",
					data : JSON.stringify({
						'employeeId' : '1',
						'hospitalId':hospitalId,
						'cityId':cityId
						 
					}),
					contentType : "application/json",
					type : "POST",
					success : function(response) {
						// console.log(response);
						
						var trHTML = '<option value=""><strong>Select</strong></option>';
						
						if(flagForReferal!=null && flagForReferal=='internal')
							{
							$('#referInternal').checked=true;
							var datas = response.masMasHospitalList;
							$.each(datas, function(i, item) {
								trHTML +='<option value="' + item.hospitalId + '@'
								+ item.hospitalId + '" >' + item.hospitalName
								+ '</option>'; 
							});
							//$('.referInternalHospitalListClass').html(internalHospitalList);
							
							var datas = response.departmentList;
							var departmentList = '<option value=""><strong>Select Department...</strong></option>';
							$.each(datas, function(i, item) {
								departmentList += '<option value="' + item.departmentId + '@'
								+ item.departmentId + '" >' + item.departmentName
								+ '</option>';
								
								//$('.departmentListClass').html(departmentList);
							});
							
						}
						
						else{
							var datas = response.masEmpanelledHospital;
						$.each(datas,
								function(i, item) {
									trHTML += '<option value="'
											+ item.empanelledHospitalId + '@'
											+ item.empanelledHospitalCode
											+ '" >'
											+ item.empanelledHospitalName
											+ '</option>';
								});
						}

						var tb11 = document.getElementById('referalGridNew');
						var lastRow = 0;
						if (tb11 != null) {
							lastRow = tb11.rows.length;
							j = lastRow + 1;
						}

						var count = 0;

					
											var flagForcheck = true;
											var gobalReferIdId = 0;
										
											

											if (flagForcheck == true) {
												var html = '<tr><td style="display:none;">'
														+ (j++)
														+ '</td><td><select class="referHospitalListClass form-control" id="referHospitalList'
														+ j
														+ '" name="referHospitalList">';
														html += trHTML
														+ '</select></td>';
											
												if(flagForReferal!=null && flagForReferal=='internal'){
													
													
													
													  html+= '<td><select class="form-control" id="departmentValue'+j+'" name="departmentValue">';
															html += departmentList
														+ '</select>';
												}
												else{
													html += '<td><select class="form-control" id="departmentValue'+j+'" name="departmentValue"';
													html += 'class="medium">';
													html += '<option value=""><strong>Select Department...</strong></option>';
												var selectDepart="";
													$.each(masSpecialistList, function(i, item) {
														html += '<option   value="'+ item.specialityName + '" >' + item.specialityName
																+ '</option>';
													});
													
													html += '</select>';
												
												}
											
												html += '<input type="hidden"  name="masEmpanalHospitalId" value="" id="masEmpanalHospitalId"/>';
												html += '<input type="hidden"  name="masDepatId" value="" id="masDepatId"/>';

												html += '<input type="hidden"  name="referalPatientDt" value="" id="referalPatientDt"/>';
												html += '<input type="hidden"  name="referalPatientHd" value="" id="referalPatientHd"/>';

												html += '</td>';
												//html +='<td><div  class="autocomplete forTableResp"><textarea class="form-control" type="text" id="diagonsisText'+j+'"name="diagonsisText"  onKeyPress="autoCompleteCommon(this,5);"  onblur="fillDiagnosisCombo2(this.value);fillReferalDiagnosisVal2(this)">'+diagonsisText+'</textarea></div></td><td><input class="form-control" type="text" id="hos" name="hos" /></td>';

												
												
												html += '</tr>'
												$('#referalGridNew').append(
														html);
												var val = parseInt($(
														'#referalGridNew>tr:last')
														.find("td:eq(1)")
														.text());
											}

											count++;
								
					},
					error : function(e) {

						// console.log("ERROR: ", e);

					},
					done : function(e) {
						// console.log("DONE");
						alert("success");
						var datas = e.data;

					}
				});

		$("#referDiv").show();
		// flagBydefault=true;

	} else {
		if (globalDataForReferal != null && globalDataForReferal.length > 1) {
			if (confirm("You have already referred this Patient. Are you sure want to  delete this referral.")) {
				document.getElementById('referhospital').setAttribute(
						"validate", " ");
				document.getElementById('referredFor').setAttribute("validate",
						" ");
				$("#admissionAdvised").attr('disabled', false);
				$("#referalGrid tr").remove();
				$("#referDiv").hide();
				var visitId = $('#visitId').val();
				var opdPatientDetailId = $('#opdPatientDetailId').val();
				var patientId = $('#patientId').val();
				deleteInvestigatRow(4, "", visitId, opdPatientDetailId,
						patientId);
			} else {
				document.getElementById("option2").selected = true;
			}
		}
		if ($("#referralForNew").val() != 1) {
			document.getElementById('referhospital').setAttribute("validate",
					" ");
			document.getElementById('referredFor')
					.setAttribute("validate", " ");
			$("#admissionAdvised").attr('disabled', false);
			$("#referalGrid tr").remove();
			$("#referDiv").hide();
		}

	}

}

function checkReferTO(id) {
	if (document.getElementById('referInternal').checked == true) {
		document.getElementById('referhospital').setAttribute("validate",
				"Hospital,String,yes");
		document.getElementById('referral_treatment_type').setAttribute(
				"validate", "Referral Type,String,yes");
		document.getElementById('referredFor').setAttribute("validate",
				"Referred for,String,yes");

		document.getElementById('referhospitalLabel').style.display = 'block'
		document.getElementById('referhospital').style.display = 'block';
		// document.getElementById('priorityLabelId').style.display='none';
		// document.getElementById('priorityId').style.display='none';

		document.getElementById('referdayslLabel').style.display = 'block';
		document.getElementById('referdays').style.display = 'block';
		document.getElementById('referral_treatment_type_label').style.display = 'block';
		document.getElementById('referral_treatment_type').style.display = 'block';
		document.getElementById('referredFor').style.display = 'block';
		document.getElementById('referredForLabel').style.display = 'block';
		document.getElementById('referDepartmentDiv').style.display = 'none';

	} else if (document.getElementById('referExternal').checked == true) {

		document.getElementById('referhospital').setAttribute("validate", " ");
		document.getElementById('referredFor').setAttribute("validate", " ");

		// document.getElementById('priorityLabelId').style.display = 'block';
		// document.getElementById('priorityId').style.display = 'block';

		document.getElementById('referhospitalLabel').style.display = 'none';
		document.getElementById('referhospital').style.display = 'none';
		document.getElementById('referdayslLabel').style.display = 'none';
		document.getElementById('referdays').style.display = 'none';
		document.getElementById('referral_treatment_type_label').style.display = 'none';
		document.getElementById('referral_treatment_type').style.display = 'none';
		document.getElementById('referredFor').style.display = 'none';
		document.getElementById('referredForLabel').style.display = 'none';
		document.getElementById('referDepartmentDiv').style.display = 'block';
	} else {
		document.getElementById('referhospital').setAttribute("validate",
				"Hospital,String,yes");
		document.getElementById('referral_treatment_type').setAttribute(
				"validate", "Referral Type,String,yes");
		document.getElementById('referredFor').setAttribute("validate",
				"Referred for,String,yes");
		document.getElementById('referhospitalLabel').style.display = 'block'
		document.getElementById('referhospital').style.display = 'block';
		;
		document.getElementById('referdayslLabel').style.display = 'block';
		document.getElementById('referdays').style.display = 'block';
		document.getElementById('referral_treatment_type_label').style.display = 'block';
		document.getElementById('referral_treatment_type').style.display = 'block';
		document.getElementById('referredFor').style.display = 'block';
		document.getElementById('referredForLabel').style.display = 'block';

		// document.getElementById('priorityLabelId').style.display = 'block';
		// document.getElementById('priorityId').style.display = 'block';
		document.getElementById('referDepartmentDiv').style.display = 'block';
	}
}
 

function validateDataOpdPatientRecall() {
	 
	  ///////////////////Vitals Validation //////////////////////////////////////
    var height = $('#height').val();
    var weight = $('#weight').val();
    var tempature = $('#tempature').val();
    var bp = $('#bp').val();
    var bp1 = $('#bp1').val();
    var pulse = $('#pulse').val();
    
    var agee = $('#ageNumber').val();
	//var ageFlag = $('#ageId').val();
	
	if(agee >12){
		
		var	bp = $('#bp').val();
		if(bp == ''){
			alert("Please enter bp");
			return;
		}
		var bp1 = $('#bp1').val();
		if(bp1 == ''){
			alert("Please enter bp");
			return;
		}
	}
    
    if(height=="" ||weight==""||tempature==""||pulse=="")
    {
    	alert("Please enter height,weight,Temperature and pulse in vital section");
 		return false;
    }	
	if(height==0 || weight==0 || tempature==0|| pulse==0)
	 {
 		alert("Height,Weight,Temperature and Pulse should be greater than 0");
 		return false;
	 }
	
	    var patientSympotnsArryVal = [];
	    var patientSympotnsText=[];	
	    $('#patientSympotnsId').find('span').each(function() { 
		    var id = this.id;
		    var value = $(this).html();
		    var spitValue=value.split("[");
		   patientSympotnsText.push(spitValue[0]);
		   var symptomsIdValue=id;
				var param = {'symptomsId' : symptomsIdValue,
 	    		      'visitId':  $('#visitId').val(),
 	    		      'patientId':$('#patientId').val()
 	                 };
				
				patientSympotnsArryVal.push(param)
		});
	    if(patientSympotnsText == "") {
          alert("Please enter patient signs and symptoms");
          document.getElementById('patientSymptons').focus(); 
          return false;
        }
	   $('#patientSymptonsValeText').val(patientSympotnsText);
	 
	 //////////////////////////Follow up validation ///////////////////////
     var followUpd=document.getElementById("noOfDays");
    var followDays=followUpd.value;
   
     if($('#nextFollowUpDate').val()!="")
     {
      if(document.getElementById("followUpChecked").checked == false){
   	   
   		   alert("Please Mark Follow-Up")
   		   return false;
       }
      }

	/*var count = 0
	$("#diagnosisId > option").each(function() {
		count++;

	});

	if (count == "") {
		alert("Please enter atleast one ICD Diagnosis");
		document.getElementById('icd').focus();
		return false;
	}
*/
 

	
	 

	// ///////////////// onsisty mark validation ////////////////////////////
	var obsistyMark = '';
	if (checkBox.checked == true) {
		obsistyMark = 'true';
	}

	if (checkBox.checked == true) {
		if (document.getElementById('height').value == "") {
			alert("please enter height")
			return false;
		}
		if (document.getElementById('weight').value == "") {
			alert("please enter weight")
			document.getElementById('weight').focus();
			return false;
		}
	}
	if(document.getElementById('height').value == "" && document.getElementById('bmi').value != "")
	{	
	alert("please enter height")
	document.getElementById('height').focus();
	return false;
	}
	var freProcedureValue = "";
	var noOfDaysValue = "";
	$('#gridNursing tr').each(function(i, el) {
		var $tds = $(this).find('td')
		var select = $tds.eq(1).find(":input").val();
		// var valueSelect=select.options[select.selectedIndex].value;
		// alert("valueSelect"+valueSelect);
		freProcedureValue += select + ",";
		var noOfDays = $tds.eq(2).find(":input").val();
		noOfDaysValue += noOfDays + ",";
	});

	$('#freProcedure').val(freProcedureValue);
	$('#noOfDaysPro').val(noOfDaysValue);
	
	 /*///////////////////Vitals Validation //////////////////////////////////////
    var a = document.getElementById("ideal_weight").value;
    var b = document.getElementById("ideal_weight").value;
    var c = document.getElementById("weight").value;
    if(a!=null && a!="" ||b!=null && b!=""||c!=null && c!="")
    {	
	if(a==0 || b==0 || c==0)
	 {
 		alert("Height,Ideal Weight and Weight should be greater than 0");
 		return false;
	 }
    }*/
    
     /* if(total_icd_value=="") {
    	alert("Please enter at least one ICD Diagnosis");
    	document.getElementById('icd').focus();
        return false;
      }*/
      
      ////////////////////////////// investigation validation part ////////////////	
      var  idforInvestigation='';
		var valnomenclatureGrid='';	
		var countDgInves=0;
		var tb3 = document.getElementById('dgInvetigationGrid');
		var lastRow3 = tb3.rows.length;
    
		if(lastRow3 > 1)
		{
		 $('#dgInvetigationGrid tr').each(function(i, el) {
			idforInvestigation= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
  		 var $tds = $(this).find('td')
         	    var itemIdCheck = $(this).closest('tr').find("td:eq(0)").find("input:eq(3)").val();
         	   
			      // alert(id);
			         if(itemIdCheck==""){
			        	 alert("Please enter valid Investigation name"); 
			        	 //itemIdCheck.focus();
			      		// return false; 
			        	 countDgInves+=1;
			         }
		 }); 
		}
		
		
		
   /////////////////////// treatment validation part ////////////////////////////
		var tb2 = document.getElementById('nomenclatureGrid');
		var lastRow2 = tb2.rows.length;
    	if(lastRow2 > 1)
		{
		 $('#nomenclatureGrid tr').each(function(i, el) {
		    	var $tds = $(this).find('td')
         	    var itemNomenclatureIdCheck = $(this).closest('tr').find("td:eq(0)").find("input:eq(1)").val();
         	   
			         if(itemNomenclatureIdCheck==""){
			        	 alert("Please enter valid Nomenclature Name"); 
			        	// itemNomenclatureIdCheck.focus();
			        	 countDgInves+=1;
			        	 return false;
			         }
		 });  
		} 
    	
    	var extNomenclatureFlag=true;
		var  idforTreat='';
		var valnomenclatureGrid='';	
 		 $('#nomenclatureGrid tr').each(function(i, el) {
 			idforTreat= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
 			var $tds = $(this).find('td')
	    		var treatmentName = $tds.eq(0).find(":input").val();
	    		var dosage = $tds.eq(2).find(":input").val();
	   			var frequency = $tds.eq(3).find(":input").val();
	  			var days = $tds.eq(4).find(":input").val();
	   			var instruction = $tds.eq(6).find(":input").val();
	   		    var totalNom = $tds.eq(5).find(":input").val();
	            var treatmentItemId=$(this).closest('tr').find("td:eq(0)").find("input:eq(1)").val(); 
	            
	         	if(frequency!= "" || dosage!= "" || days!= "")
				{	
          	if(document.getElementById(idforTreat).value!= '' && treatmentName== "")
 			 	{
				alert("Please Enter Durgs Name");
				//treatmentName.focus();
				countDgInves+=1;
				return false;	    	
			  	}
			   }
	   		       	 			
    		if(document.getElementById(idforTreat).value!= '' && document.getElementById(idforTreat).value != undefined)
		    {
 			
				if(dosage== "" ||dosage==0)
  			{
					alert("Dosage should be greater than 0 under drugs name");
					//dosage.focus();
					countDgInves+=1;
					return false;      	
				 }
				if(frequency== "")
  				 {
					alert("Please select frequency against entered drugs name");
					//frequency.focus();
					countDgInves+=1;
					return false;       	
				 }
			if(days== "" && frequency!=13)
   			{
					alert("Please Enter No. of Days against entered drugs name");
					//frequency.focus();
					countDgInves+=1;
					return false;       	
			    }
			
			if(totalNom== "" ||totalNom==0)
   			{
					alert("Total should be greater than 0 under drugs name");
					//frequency.focus();
					countDgInves+=1;
					return false;       	
			    }

		    }
		 });
 		 
 		 
 		 
 		 
 		 //////////////////////////////Procedure Care Validation /////////////////////////
	 	    
	 		if($('#gridNursing tr').length > 1)
			{
	 		 $('#gridNursing tr').each(function(i, el) {
	 		    	var $tds = $(this).find('td')
	           	    var itemProcedureCareIdCheck = $(this).closest('tr').find("td:eq(0)").find("input:eq(1)").val();
	           	   
				      // alert(id);
				         if(itemProcedureCareIdCheck==""){
				        	 alert("Please enter valid Procedure Care name"); 
				        	 countDgInves+=1;
				      		 return false; 
				        	
				         }
				       
			    
	 		 }); 
			}
	 		 
     	var  idforProcedureCare='';
         $('#gridNursing tr').each(function(i, el) {
         	  var $tds = $(this).find('td')
               var idFreq=  $tds.eq(1).find(":input").val();
     	      var idDays=$tds.eq(2).find(":input").val();
     	      var typeOfProcValue=$(this).closest('tr').find("td:eq(3)").find("input:eq(0)").val();	
     	      idforProcedureCare=$(this).find("td:eq(0)").find("input:eq(0)").attr("id")
     	     if(document.getElementById(idforProcedureCare).value!= '' && document.getElementById(idforProcedureCare).value != undefined)
			     {
     	      if(typeOfProcValue=="N" || typeOfProcValue=="P")
     	  	  {
     	      if(idFreq=="")
     	      {
     	    	  alert("Please select frequency agaisnt entered procedure care");
     	    	 countDgInves+=1;
			     return false;   
     	      }
     	      if(idDays=="")
     	      {
     	    	  alert("Please Enter No. of Days against entered procedure care");
     	    	 countDgInves+=1;
				 return false;   
     	      }	 
     	    	  
     	  	 }
			  }
	 		});
    	
 
     
        $('#referalGridNew tr').each(function(i, el) {
    	    var $tds = $(this).find('td')
    	    var extHospitalId = $tds.eq(1).find(":input").val();
    	
    	 if(extHospitalId== "")
  	    {
      		alert("Please select hospital for referral");
      		countDgInves+=1;
      		return false;
      		    	
  		}
        });
        
        
        
        var isCheckedAdmission = $("#admissionAdvised").is(":checked");
        if (isCheckedAdmission) {
        	
        	var dateOfAdmission= $('#admissionDate').val();
        	var wardVal=$('#wardDepartmentId').val();
        	if(dateOfAdmission=="")
        	{
        		alert("Please select date under admission");
        		countDgInves++;
        		return false;
        	}
        	if(wardVal=="")
        	{
        		alert("Please select ward under admission");
        		countDgInves++;
        		return false;
        	}
        }
        
      
       
         if (isCheckedAdmission && countDgInves==0) {
        	 $("#wardDepartmentIdTemp").val('Y'); 
        	 
         }
         else{
        	 $("#wardDepartmentIdTemp").val('N'); 
         }
        
        
    	if(countDgInves!=0){
			return false;
		}
    	else{
    		return true;
    	}
}




function submitForm(flag) {
	
	var countForCheck=0;
	/*$('#dgInvetigationGrid tr').each(function(i, el) {
		var investigationVal = $(this).find("td:eq(0)").find("input:eq(0)").val();
		var checkValues = $(this).find("td:eq(2)").find("input:eq(0)").attr("id");
			if (document.getElementById(''+checkValues).checked == true && investigationVal!=undefined && investigationVal!="" && investigationVal!=null){
				countForCheck++;
				}	
			});*/
	
	var validateData = validateDataOpdPatientRecall();
	 $('#obsistyMark').val(obsistyOverWeight);
	 
	 
	if (validateData == true) {
//////////////////////////////Diagnosis validation part ////////////////	
        var  idforDiagnosis='';
			var valDiagnosisGrid='';	
			if($('#diagnosisGridRecall tr'))
			{
	 		 $('#diagnosisGridRecall tr').each(function(i, el) {
	 			idforDiagnosis= $(this).find("td:eq(0)").find("input:eq(5)").val() 
	    		 var $tds = $(this).find('td')
	           	    var itemIdDiagnsosisCheck = $tds.eq(5).find(":input").val();
  	 			if($('#diagnosisGridRecall tr').length > 0)
    			{
  	 				if(itemIdDiagnsosisCheck==""){
				        	 alert("Please enter valid diagnosis name"); 
				        	 itemIdDiagnsosisCheck.focus();
				      		 return false; 
				        	
				         }
    			}
  	 			else
  	 			{	
				      // alert(id);
				         if(idforDiagnosis==""){
				        	 alert("Please enter valid diagnosis name"); 
				        	 itemIdDiagnsosisCheck.focus();
				      		 return false; 
				        	
				         }
  	 			}
				       
			    
	 		 }); 
			}
		radioInvest();
		
		if(countForCheck>0){
			//$("#submitPatientRecall").submit();
			//return true;
			$('#messageForInvestigationOutside').show();
			$('.modal-backdrop').show();
		}
		
		
		if(countForCheck==0){
			$("#submitPatientRecall").submit();
			$('#clicked111').attr("disabled","disabled")
			return true;
		}
		else{
			return false;
			}
		
		
	} else {
		return false;
	}
}

function submitMOValidateFormByModel(){
	$("#submitPatientRecall").submit();
	$('#clicked111').attr('disabled',true);
	$('#submitMOValidateFormByModelId').attr('disabled',true);
	return true; 
}






/*function deleteDgItems(value) {
	var referPatientDtOrDiagnosis = document.getElementById('diagnosisId').options[document
			.getElementById('diagnosisId').selectedIndex].value;

	if (referPatientDtOrDiagnosis.includes("&&&")) {
		var checkForReferPatient = referPatientDtOrDiagnosis.split("&&&");
		var visitId = $('#visitId').val();
		var opdPatientDetailId = $('#opdPatientDetailId').val();
		var patientId = $('#patientId').val();
		if (checkForReferPatient[1] == "0") {
			var status = deleteInvestigatRow(3, referPatientDtOrDiagnosis,
					visitId, opdPatientDetailId, patientId);
		} else {
			alert("Referal Header already generated for this diaganosis.");
			return true;
		}
	}
	if (confirm("are you sure want to delete ?")) {
		if (document.getElementById('diagnosisId').options[document
				.getElementById('diagnosisId').selectedIndex].value != null)
			document.getElementById('diagnosisId').remove(
					document.getElementById('diagnosisId').selectedIndex)
	}

}*/

$(document)
		.delegate(
				"#dgInvestigationTemplateIdInvest",
				"change",
				function() {
					var pathname = window.location.pathname;
					var accessGroup = "MMUWeb";
					var url = window.location.protocol + "//"
							+ window.location.host + "/" + accessGroup
							+ "/opd/getTemplateInvestigation";
					// var url =
					// "http://localhost:8181/AshaServices/opdmaster/getTemplateInvestData";
					// alert("$('#dgInvestigationTemplateId')"+$('#dgInvestigationTemplateIdInvest').val());
					$
							.ajax({
								url : url,
								dataType : "json",
								data : JSON.stringify({
									'employeeId' : '1',
									'templateId' : $(
											'#dgInvestigationTemplateIdInvest')
											.val()
								}),
								contentType : "application/json",
								type : "POST",
								success : function(response) {
									// console.log(response);
									if (response.status == 1 &&  $('#dgInvestigationTemplateIdInvest').val()!="" 
										&&  $('#dgInvestigationTemplateIdInvest').val()!=undefined 
										&&  $('#dgInvestigationTemplateIdInvest').val()!=null) {
										// $("#dgInvetigationGrid tr").remove();
										var datas = response.data;
										
										var trHTML = '';
										var count = 0;
										var investigationGridValue="investigationGrid";
											func1='populateChargeCode';
							    		   url1='opd';
							    		   url2='getIinvestigationList';
							    		   flaga='investigation';
										$.each(datas, function(ij, item) {
										 
															var flagForcheck1 = true;
															var investigationValue = item.investigationName;
															var investigationId = item.templateInvestgationId;
															var investigationIdValu ="";
															if(investigationId!=null && investigationId!=undefined && investigationId!=""){
															$('#dgInvetigationGrid tr').each(function(ihh, el) {
																				var $tds = $(this) .find('td')
																				var chargeCodeId = $($tds).closest('tr').find("td:eq(0)").find("input:eq(3)").val();
																				 // investigationIdValu = $('#'+chargeCodeId).val();
																				if (investigationId == chargeCodeId) {
																					flagForcheck1 = false;
																				}
																				// j++;
																			});
															}
															var tbDgInvetigationGrid = document.getElementById('dgInvetigationGrid');
															var lastRow = tbDgInvetigationGrid.rows.length;
															//count=lastRow;
															//count++;
															if(lastRow==1 && investigationIdValu==""){
																$("#dgInvetigationGrid tr").remove();
															}
															
															
															/*
															 * if(glopbalInvestigationList!=null &&
															 * glopbalInvestigationList.length!=0){
															 * for(var j=i;j<glopbalInvestigationList.length;j++){
															 * if(investigationId ==
															 * glopbalInvestigationList[i].investigationId){
															 * flagForcheck =
															 * false; } } }
															 */
															count=parseInt(count)+parseInt(investigationId);
															if (flagForcheck1 == true) {
																trHTML += '<tr>';
																trHTML += '<td><div class="autocomplete forTableResp">';
																trHTML += '<input type="text" autocomplete="never" value="' + investigationValue + '[' + investigationId + ']" id="chargeCodeName' + i + '"';
																//trHTML += ' class="form-control border-input" name="chargeCodeName" onKeyPress="autoCompleteCommon(this,1);" onblur="populateChargeCode(this.value,1,this);"/>';
																trHTML += ' class="form-control border-input" name="chargeCodeName" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
																trHTML += '<input type="hidden" id="qty" tabindex="1" name="qty1"  maxlength="6"/>';
																trHTML += '<input type="hidden" tabindex="1" id="chargeCodeCode' + count + '"';
																trHTML += 'name="chargeCodeCode"  readonly />';
																trHTML += '<input type="hidden"  name="investigationIdValue" value="'
																		+ investigationId + '"  id="investigationIdValue' + count + '"/>';

																trHTML += '<input type="hidden"  name="dgOrderDtIdValue" value="" id="dgOrderDtIdValue' + count + '"/>';
																trHTML += '<input type="hidden"  name="dgOrderHdId" value="" id="dgOrderHdId' + count + '"/>';

																trHTML+=' <div id="investigationDiv'+count+'" class="autocomplete-itemsNew"></div>';
																trHTML += ' </div></td>';
																																
																
																
																trHTML += '<td style="display:none" class="text-center">';
																trHTML += '<div class="form-check form-check-inline cusCheck">';
																trHTML += '<input type="checkbox" name="urgent"';
																trHTML += 'id="uCheck11' + count + '" tabindex="1" class="radioAuto form-check-input"';
																trHTML += 'onchange="#" value="N" />';
																trHTML += '<span class="cus-checkbtn"></span> ';
																trHTML += '</div>';
																trHTML += '<input type="hidden" name="statusOfInves" id="statusOfInves" value=""/>';
																trHTML += '</td>';
																
																
																trHTML += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth" button-type="add" value="" ';
																trHTML += 'onclick="addRowForInvestigationFun();"';
																trHTML += '	tabindex="1" ></button></td>';

																trHTML += '<td><button type="button" name="delete" value="" button-type="delete" id="deleteInves"';
																trHTML += 'class="buttonDel btn btn-danger noMinWidth"';
																trHTML += 'onclick="removeRowInvestigation(this,\'' + investigationGridValue + '\',);"';
																trHTML += '	tabindex="1" ></button></td>';
																trHTML += ' </tr> ';
															}
															count++;

														});
										$('#dgInvetigationGrid').append(trHTML);
										// $('#dgInvetigationGrid').append(trHTML);
										// $('#investigationGrid').html(trHTML);
										/*
										 * var
										 * dgInvestigationTemplate=$('#dgInvestigationTemplateIdInvest').val();
										 * alert(dgInvestigationTemplate);
										 * if(dgInvestigationTemplate.){
										 *  }
										 */
									} else {
										 $("#dgInvetigationGrid tr").remove();
										 var trHTML="";
										 trHTML = '<tr>';
											trHTML += '<td><div class="autocomplete forTableResp">';
											trHTML += '<input type="text" autocomplete="never" value="" id="chargeCodeName' + i + '"';
											//trHTML += ' class="form-control border-input" name="chargeCodeName" onKeyPress="autoCompleteCommon(this,1);" onblur="populateChargeCode(this.value,1,this);"/>';
											trHTML += ' class="form-control border-input" name="chargeCodeName" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
											trHTML += '<input type="hidden" id="qty" tabindex="1" name="qty1"  maxlength="6"/>';
											trHTML += '<input type="hidden" tabindex="1" id="chargeCodeCode' + count + '"';
											trHTML += 'name="chargeCodeCode"  readonly />';
											trHTML += '<input type="hidden"  name="investigationIdValue" value=""  id="investigationIdValue' + count + '"/>';

											trHTML += '<input type="hidden"  name="dgOrderDtIdValue" value="" id="dgOrderDtIdValue' + count + '"/>';
											trHTML += '<input type="hidden"  name="dgOrderHdId" value="" id="dgOrderHdId' + count + '"/>';

											trHTML+=' <div id="investigationDiv'+count+'" class="autocomplete-itemsNew"></div>';
											trHTML += ' </div></td>';
										
											
											
											trHTML += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth" button-type="add" value="" ';
											trHTML += 'onclick="addRowForInvestigationFun();"';
											trHTML += '	tabindex="1" ></button></td>';

											trHTML += '<td><button type="button" name="delete" value="" button-type="delete" id="deleteInves"';
											trHTML += 'class="buttonDel btn btn-danger noMinWidth"';
											trHTML += 'onclick="removeRowInvestigation(this,\'' + investigationGridValue + '\',);"';
											trHTML += '	tabindex="1" ></button></td>';
											trHTML += ' </tr> ';
											
											$('#dgInvetigationGrid').html(trHTML);
									}
								},
								error : function(e) {

									// console.log("ERROR: ", e);

								},
								done : function(e) {
									// console.log("DONE");
									alert("success");
									var datas = e.data;

								}
							});

				});
//var disposalListVal="";
function getPocedureDetailData() {
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var urlgetPocedureDetailRecall = window.location.protocol + "//"+ window.location.host + "/" + accessGroup+ "/opd/getPocedureDetailRecall";
	var visitId = $('#visitId').val();
	var opdPatientDetailId = $('#opdPatientDetailId').val();
	var data = {
		"visitId" : visitId,
		"opdPatientDetailId" : opdPatientDetailId
	};
	$.ajax({
				type : "POST",
				contentType : "application/json",
				url : urlgetPocedureDetailRecall,
				data : JSON.stringify(data),
				dataType : "json",
				// cache: false,
				success : function(res) {
					var data = res.listOfProcedure;
					var masFrequency = res.masFrequency;
					 
					if (data != null && data.length > 0) {
						var nursingData = "";
						investigationGridValue = 'gridNursing';
						var count = 1;
						func1='populateNursingRecall';
						   url1='opd';
						   url2='getMasNursingCare';
						   flaga='procedureNursing';
						for (var i = 0; i < data.length; i++) {

							
							var disableFlagVal=""
								var dateForReadonly="";	
							var orderStustus=data[i].status;
								if(orderStustus!="" && orderStustus=='Y'||orderStustus=='y'){
									disableFlagVal="disabled";
									dateForReadonly='readonly';
								}
								else{
									disableFlagVal="";
									dateForReadonly="";
								}
							
							
							nursingData += '<tr>';
							nursingData += '<td><div class="form-group autocomplete forTableResp">';
							nursingData += '<input type="text" autocomplete="never" value="'
									+ data[i].nursingName + '['
									+ data[i].nursingId
									+ ']" id="procedureNameNursing' + count
									+ '"';
							//nursingData += ' class="form-control border-input" name="procedureNameNursing" onKeyPress="autoCompleteCommon(this,3);" onblur="populateNursingRecall(this.value,1,this);"/>';
							nursingData += ' class="form-control border-input" name="procedureNameNursing" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" '+dateForReadonly+'/>';
							nursingData += '<input type="hidden"  name="procedureNameNursingId" value="'
									+ data[i].nursingId
									+ '"  id="procedureNameNursingId'
									+ data[i].nursingId + '" />';
							nursingData += '<input type="hidden"  name="procedureDtIdValue" value="'
									+ data[i].procedureDtId
									+ '" id="procedureDtIdValue'
									+ data[i].procedureDtId + '"/>';
							nursingData += '<input type="hidden"  name="procedureHdId" value="'
									+ data[i].procedureHdId
									+ '" id="procedureHdId'
									+ data[i].procedureHdId + '"/>';
							nursingData += '<input type="hidden"  name="statusOfPro" value="'+orderStustus+'" id="statusOfPro"/>';
							nursingData += '<div id="procedureNursingForAutoComplete'+count+'" class="autocomplete-itemsNew"></div>';
							
							nursingData += ' </div></td>';
							var selectDiasable = "";
							if (data[i].proceduretype != null
									&& data[i].proceduretype == "M") {
								selectDiasable = "disabled";
							} else {
								selectDiasable = "";
							}
							
						

						

							/*
							 * var procedureTypeValue="";
							 * if(data[i].proceduretype!=null &&
							 * data[i].proceduretype=="M"){
							 * procedureTypeValue="Minor Surgery" }
							 * 
							 * if(data[i].proceduretype!=null &&
							 * data[i].proceduretype=="N"){
							 * procedureTypeValue="Nursing Care" }
							 * 
							 * if(data[i].proceduretype!=null &&
							 * data[i].proceduretype=="P"){
							 * procedureTypeValue="Physiotherapy" }
							 */

							/*nursingData += '<td>';
							nursingData += '<input type="text" name="procedureType" id="procedureType'+ count
									+ '" value="'
									+ data[i].proceduretype + '"';
							nursingData += 'class="largTextBoxOpd textYellow form-control" maxlength="5" readonly />';
							nursingData += '</td>';*/

							nursingData += '<td>';
							nursingData += '<input value="' + data[i].remarks
									+ '" type="text"';
							nursingData += 'name="remark_nursing" id="remark_nursing'
									+ count + '"';
							nursingData += 'class="largTextBoxOpd textYellow form-control" maxlength="100" '+dateForReadonly+'/>';
							nursingData += '</td>';
							nursingData += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth" button-type="add" value="" ';
							nursingData += 'onclick="addRowTreatmentNursingCareRecall();"';
							nursingData += '	tabindex="1" >  </button></td>';

							nursingData += '<td><button type="button" name="delete" value="" id="deleteProcure"';
							nursingData += 'class="buttonDel btn btn-danger noMinWidth" button-type="delete"';
							nursingData += 'onclick="removeRowInvestigation(this,\''
									+ investigationGridValue
									+ '\','
									+ data[i].procedureDtId + ');"';
							nursingData += '	tabindex="1" '+disableFlagVal+'></button></td>';
							nursingData += ' </tr> ';
							count++;
						}

						$("#gridNursing").html(nursingData);

					}
				}
			});
}

var nursingNo = '';
/*function populateNursingRecall(val, inc) {

	if (val != "") {
		var index1 = val.lastIndexOf("[");
		var indexForBrandName = index1;
		var index2 = val.lastIndexOf("]");
		index1++;
		nursingNo = val.substring(index1, index2);
		var indexForBrandName = indexForBrandName--;
		var brandName = val.substring(0, indexForBrandName);

		if (nursingNo == "") {
			// alert("pvms no1111--"+pvmsNo)
			// document.getElementById('nomenclature' + inc).value = "";
			// document.getElementById('pvmsNo' + inc).value = "";
			return false;
		} else {
			// document.getElementById('procedureNameNursingCare').value =
			// nursingNo
			// alert(nursingNo)
			return true;

		}

	} else {
		return false;
	}
}*/


var k = 0;
function addRowTreatmentNursingCareRecall() {
	var tbl = document.getElementById('gridNursing');
	lastRow = tbl.rows.length;
	k = lastRow;
	k++;
	var aClone = $('#gridNursing>tr:last').clone(true)
	aClone.find(":input").val("");
	aClone.find("td:eq(0)").find("input:eq(0)").prop('id','procedureNameNursing' + k + '');
	aClone.find("td:eq(0)").find("input:eq(1)").prop('id', 'procedureNameNursingId'+k+'');
	
	aClone.find("td:eq(0)").find("div").find("div").prop('id', 'procedureNursing' + k + '');
	
	aClone.find("td:eq(0)").find("div").find("div").prop('id', 'procedureNursingForAutoComplete' + k + '');
	
	
	aClone.find("td:eq(2)").find("input:eq(0)").prop('id','remark_nursing' + k + '');

	
	var defaultProcedureValue=$('#defaultProcedureValue').val();
	if(defaultProcedureValue!="" && defaultProcedureValue=='N'){
		aClone.find("select").removeAttr("disabled")
		aClone.find('input[type="text"]').removeAttr("disabled");
		
	//	aClone.find("select").removeAttr("readonly")
		//aClone.find('input[type="text"]').removeAttr("readonly");
		
		aClone.find("td:eq(2)").find("input:eq(0)").removeAttr("readonly",false);
		aClone.find("td:eq(1)").find("select:eq(0)").removeAttr('readonly',false);

	}
	
	aClone.find("td:eq(0)").find("input:eq(0)").removeAttr("readonly",false);
	aClone.find("td:eq(4)").find("input:eq(0)").removeAttr('readonly',false);
	aClone.find("td:eq(6)").find("button:eq(0)").removeAttr("disabled",false);

	aClone.clone(true).appendTo('#gridNursing');
	$('#gridNursing>tr:last').find("td:eq(6)").find("button:eq(0)").attr("id","newIdProcedure");
}





function callToAutheniticate(){
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var urlauthenticateUser = window.location.protocol + "//"+ window.location.host + "/" + accessGroup+ "/opd/authenticateUser";
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
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : urlauthenticateUser,
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(response) {
			var data = response.data;
			$('#uhidNumberValue').val(data);
			if(data=="success"){
				
				/*var pathname = window.location.pathname;
				var accessGroup = "MMUWeb";
				var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/ehr/patientSummary?patientId=";
				window.open(url+$('#patientId').val()+"");*/
				
				document.getElementById("okButtonOfAuthenticate").addEventListener("click", function(){
					document.getElementById("okButtonOfAuthenticate").style.display = "none";
					$('#messageForAuthenticateMessae').html(""+resourceJSON.msgSucessAuthorized);
					$('.modal-backdrop ').hide();
					
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

function closeMessage(){
	 $('#errordiv').empty("");
	 $('#uhidNumber').val("");

	$('#messageForAuthenticate').hide();
	$('.modal-backdrop ').hide();
}
var frequencyList="";
function showCurrentMedication(data,frequencyList,itemStopbByDoctor,count){
			  
	var userName=userNameGlob;
	var itemStopbByDoctorGlobal=itemStopbByDoctor;
	var currentMedication = '';
			  var readonlyForCuttentMedication='readonly';
			currentMedication += '<div class="autocomplete forTableResp">';
			var countNo = 1;
			if (data == null || data.length == 0) {
				currentMedication = currentMedication+"<tr ><td colspan='11'><h6>No Record Found</h6></td></tr>";
				$("#currentMedicationGrid").html(currentMedication);
				$("#modelForCurrentMedication").show();
				$(".modal-backdrop").show();
			}
			investigationGridValue = "currentMedicationGrid";
			var counttt=$('#countValueCurrentMedi').val();
			if(counttt==""){
				countNo=1;
			}
			else{
				if(nPageNo==1){
					countNo=1
				}
				else{
				countNo=counttt;
				}
				}
			var count=1;
			func1='populatePVMSTreatment';
			   url1='opd';
			   url2='getMasStoreItemList';
			   flaga='numenclature';

			   var precriptionDtValues=$('#precriptionDtValue').val();
			   var precriptionDtIdValArray=precriptionDtValues.split(",");
			   
			   for (var i = 0; i < data.length; i++) {
				   if(data[i].itemStopByUserName!="" && data[i].itemStopByUserName!=undefined && data[i].itemStopByUserName!=null){
				   itemStopbByDoctor= "Stop By "+ data[i].itemStopByUserName;
				   itemStopbByDoctorGlobal=itemStopbByDoctor;
				   }
				   else{
					   itemStopbByDoctor="";
					   itemStopbByDoctorGlobal="";
				   }
				   currentMedication += '<tr>';
				
				currentMedication += '<td>' + countNo + '</td>';
				
				
				currentMedication += '<td>';
				currentMedication += '<div class="autocomplete forTableResp">';
				currentMedication += '<input type="text" autocomplete="never" tabindex="1" size="77" value="' + data[i].nomenclature + '[' + data[i].PVMSno + ']" ';
				/*currentMedication += 'id="nomenclatureCurrent' + countNo + '"  name="nomenclatureCurrent"  onKeyPress="autoCompleteCommon(this,2);" onblur="populatePVMSTreatment(this.value,'+count+',this);"';*/
				currentMedication += 'id="nomenclatureCurrent' + countNo + '"  name="nomenclatureCurrent"  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" ';
				currentMedication += 'class="form-control border-input width200"';
				currentMedication += '" '+readonlyForCuttentMedication+'/>';
				currentMedication += '<input type="hidden"  name="itemId" value="' + data[i].itemId + '" id="nomenclatureId'
						+ data[i].itemId + '"/>';
				currentMedication += '<input type="hidden"  name="prescriptionHdIdCurrent" value="'+data[i].precryptionHdId+'" id="prescriptionHdIdCurrent' + data[i].precryptionHdId + '"/>';
				currentMedication += '<input type="hidden"  name="prescriptionDtIdCurrent" value="'+data[i].precriptionDtId+'" id="precriptionDtIdCurrent' + data[i].precriptionDtId + '"/>';
				
				currentMedication += '<div id="nomenclatureIdPvs'+countNo+'" class="autocomplete-itemsNew"></div>';
				currentMedication += '</div>';
				currentMedication += '</td>';

			 
				currentMedication += '<td style="display:none"><input  type="text" value="'
					+ data[i].dispStock + '" name="dispensingUnitCurrent" ';
				currentMedication += ' id="dispensingUnitCurrent'+countNo+'" size="6"';
				currentMedication += 'validate="AU,string,no"   class="form-control"/>';
				currentMedication += '</td>';
				

				currentMedication += '<td><input type="text" onkeypress="return checkValidate(event);" class="form-control" size="5" name="dosageCurrent" tabindex="1"';
				currentMedication += 'value=' + data[i].dosage + ' id="dosageCurrent'+countNo+'"  maxlength="5" '+readonlyForCuttentMedication+'/>';
				currentMedication += '</td>';
				var selectFre = "";
				var diasableValue='disabled';
				currentMedication += '<td><select name="frequencyTreCurrent" '+diasableValue+' class="form-control width100" id="frequencyTreCurrent'+ countNo + '" '+readonlyForCuttentMedication+'';
				currentMedication += 'class="medium">';

				var frequencyIdValue = data[i].frequencyId;
				currentMedication += '<option value=""><strong>Select</strong></option>';

				
				$.each(frequencyList, function(ij, item) {

					if (frequencyIdValue == item.frequencyId) {
						selectFre = "selected";
					} else {
						selectFre = "";
					}
					currentMedication += '<option '+ selectFre +'  value="'+ item.frequencyId + '">'
					+ item.frequencyName + '</option>';
				});
				currentMedication += '</select>';
				currentMedication += '</td>';

				currentMedication += '	<td><input type="text" onkeypress="return checkValidate(event);" class="form-control width50" value="'+ data[i].noOfDays + '" name="noOfDaysCurrent" tabindex="1"';
				currentMedication += '	id="noOfDaysCurrent'+countNo+'" onblur="noOfDaysAlertRecall(this.value,this)" size="5"';
				currentMedication += '	maxlength="3" '+readonlyForCuttentMedication+'/></td>';
				var totalValue="";	
				if(data[i].total!=null){
					totalValue=data[i].total;
					}
				currentMedication += '<td><input type="text" onkeypress="return checkValidate(event);" class="form-control width50" value="' +totalValue+ '" name="totalCurrent" tabindex="1"';
				currentMedication += 'id="totalCurrent'+countNo+'" size="5"  ';
				currentMedication += '" '+readonlyForCuttentMedication+'/></td>';


				currentMedication += '<td><input type="text" class="form-control width50" name="closingStockCurrent" tabindex="1"  value="' + data[i].availableStock + '"';
				currentMedication += 'id="closingStockCurrent'+countNo+'" size="3"';
				currentMedication += 'validate="closingStock,string,no" '+readonlyForCuttentMedication+'/></td>';
				var diasableOfStop="";	
				var stopDate="";
				 
				var precribeByDoc="";
				 var precribedDate="";
				 var checkedForStop="";
				if(data[i].itemStopStatus!="" && data[i].itemStopStatus!=null && data[i].itemStopStatus==1){
					diasableOfStop="disabled";
					stopDate="Stop on "+data[i].itemStopDate;
					precribeByDoc="";
					precribedDate="";
					checkedForStop="checked=checked";
					itemStopbByDoctor=itemStopbByDoctorGlobal;
				}
				else{
					diasableOfStop=""
					itemStopbByDoctor=""+data[i].precribedByDoc;	
					stopDate="";
					//precribeByDoc="PrescribeBy"+data[i].
					precribedDate=""+data[i].precriptionDate;
					checkedForStop="";
				}
				if(precriptionDtIdValArray!="" && precriptionDtIdValArray!=undefined){
					for(var t=0;t<precriptionDtIdValArray.length;t++){
						if(precriptionDtIdValArray[t]!="" && precriptionDtIdValArray[t]!=undefined && precriptionDtIdValArray[t]!=null && precriptionDtIdValArray[t]!="NAN" && data[i].itemStopStatus!=1){
							if(precriptionDtIdValArray[t].trim()==data[i].precriptionDtId){
								itemStopbByDoctor="Stop By"+userName;
								stopDate="Stop on "+today;
								precribedDate="";
								checkedForStop="checked=checked";
								diasableOfStop="disabled";
								break;	
							}
							else{
								diasableOfStop=""
									itemStopbByDoctor=""+data[i].precribedByDoc;	
									stopDate="";
									//precribeByDoc="PrescribeBy"+data[i].
									precribedDate=""+data[i].precriptionDate;
									checkedForStop="";
							}
						}
					}
				}
				
				
				
				//currentMedication += '<td><input '+diasableOfStop+'   type="text" col="4" rows="4" class="form-control width150" value="'+itemStopbByDoctor+"/"+data[i].departmentName+'" tabindex="1"';
				//currentMedication += 'id="prescribeBy" size="77" name="prescribeBy" /></td>';

				currentMedication += '<td><textarea name="prescribeBy" id="prescribeBy" class="form-control width150" cols="0" rows="0"';
				currentMedication += '	maxlength="300" value="" tabindex="1"';
				currentMedication += 'onkeyup="return ismaxlength(this)" '+readonlyForCuttentMedication+' >'+data[i].departmentName+"/ "+itemStopbByDoctor+' </textarea>';
				
				
				currentMedication += '<td style="display:none"><input  type="text" value="" tabindex="1"';
				currentMedication += '	id="departmentCurrent'+countNo+'" class="form-control width150" size="77" name="departmentCurrent" /></td>';
				 
				
				currentMedication += '<td><input '+diasableOfStop+' type="text" value="'+stopDate+precribedDate+'" tabindex="1"';
				currentMedication += '	id="prescribeDate'+countNo+'" size="77" name="prescribeDate" class="form-control width150"  '+readonlyForCuttentMedication+'/></td>';
			
				
				currentMedication += '<td><input type="checkBox" '+diasableOfStop+' '+checkedForStop+' name="stopCheck" id="stopCheck'+countNo+'" onClick="return getPrecriptionValue(this);"';
				currentMedication += ' value=""  ';
				currentMedication += '	tabindex="1" ></td>';

				currentMedication += '<td><input type="checkBox" '+diasableOfStop+' name="repeatCheck" id="repeatCheck'+countNo+'" value="1"';
				currentMedication += 'tabindex="1"></td>';

				currentMedication += '<td style="display:none"><input type="text" class="form-control" tabindex="1" value="'
					+ data[i].instruction + '" name="remarks1" ';
				currentMedication += 'id="remarks1" size="10" maxlength="15" />';
				currentMedication += '</td>';
				
				currentMedication += '<input type="hidden" name="pvmsNo1" tabindex="1"';
				currentMedication += '	id="pvmsNo1'+countNo+'" size="10" readonly="readonly" />';
				var itemClassIdVal="";
				if(data[i].itemClassId!=null && data[i].itemClassId!=undefined)
				  itemClassIdVal=data[i].itemClassId;
				currentMedication += '<td style="display: none;"><input type="hidden"';
				currentMedication += 'name="itemClassId" tabindex="1" id="itemClassId'+countNo+'" size="10" value='+itemClassIdVal+'';
				currentMedication += 'readonly="readonly" /></td>	';
			
				currentMedication += '</tr>';
				countNo++;
			}
			$('#countValueCurrentMedi').val(countNo);
			currentMedication += '</div">';
			$("#currentMedicationGrid").html(currentMedication);
			$("#modelForCurrentMedication").show();
			$(".modal-backdrop").show();
		//}
	//});
	
}

function getPrecriptionValue(item){
	
	var precriptionDtIdVal="";
	 
	precriptionDtIdVal=$('#precriptionDtValue').val();
	var $tds = $(item).find('td');
	var stopId=$(item).closest('tr').find("td:eq(11)").find("input:eq(0)").attr("id");
	//var stopId = $tds.eq(11).find(":input").attr("id");
	var prescriptionDTIdCurrent=$(item).closest('tr').find("td:eq(1)").find("input:eq(3)").val( );
	var itemIdForCurrentMedi=$(item).closest('tr').find("td:eq(1)").find("input:eq(1)").val( );
	var checkForExistPvs=true;
/*	$('#nomenclatureGrid tr').each(function(i, el) {
		var $tds1 = $(this).find('td');
		 var itemIdForNomer=$($tds1).closest('tr').find("td:eq(0)").find("input:eq(1)").val( );
		 
		 if(itemIdForNomer==""){
				treatementValue+=1;
			}
		 if(itemIdForNomer==itemIdForCurrentMedi){
			checkForExistPvs=false;
			return false;
		}
		
	});
	
	if(checkForExistPvs==false){
		alert("Please remove Nomenclature/PVMS No first, then stop.");
		return false;
	}*/
	if (document.getElementById(stopId).checked == true && checkForExistPvs==true) {
		precriptionDtIdVal+=","+prescriptionDTIdCurrent;
		$('#precriptionDtValue').val(precriptionDtIdVal);
	}
	else{
	if(precriptionDtIdVal.includes(prescriptionDTIdCurrent) &&  checkForExistPvs==true){
		precriptionDtIdVal=precriptionDtIdVal.replace(prescriptionDTIdCurrent,"");
		$('#precriptionDtValue').val(precriptionDtIdVal);
		return true;
	}
	}
}

function closeCurrentMedication(){
	$('#modelForCurrentMedication').hide();
	$(".modal-backdrop").hide();
	document.getElementById("recommendedMedicalAdvice").focus();
}


function checkForAuthenticateUser(){
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var urlcheckForAuthenticateUser = window.location.protocol + "//"+ window.location.host + "/" + accessGroup+ "/opd/checkForAuthenticateUser";
	var patientId =$('#patientId').val();
	var visitId = $('#visitId').val();
	 
	var params = {
			"patientId": patientId,
			"visitId":visitId
	}
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : urlcheckForAuthenticateUser,
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


function submitCurrentMedication()
{
	var tbl = document.getElementById('nomenclatureGrid');
	lastRow = tbl.rows.length;
	var k = lastRow;
	k++;
	
	var treatementCurrent="";
	investigationGridValue = "nomenclatureGrid";
	var valeStop="";
	 var precriptionDtValueArray = [];
	 var countForCloseModel=0;
	 
	 func1='populatePVMSTreatment';
	   url1='opd';
	   url2='getMasStoreItemList';
	   flaga='numenclature';

	$('#currentMedicationGrid tr').each(function(i, el) {
		
				var $tds = $(this).find('td');
		    
				var repeatId = $tds.eq(12).find(":input").attr("id");
				
				var stopId = $tds.eq(11).find(":input").attr("id");
				var sNo="";
				var itemIdName ="";
				var prescriptionHdIdCurrent="";
				var prescriptionDTIdCurrent="";
				var itemId="";
				var dispUnit ="";
				var dosage ="";
				var frequencyId ="";
				var noOfDays ="";
				var total = "";
				var stock ="";
				var precribeBy ="";
				var department = "";
				var precribeDate = "";
				var remarks ="";
				var precribedDate ="";
				var department="";
				var itemClassId="";
				if(document.getElementById(repeatId).checked == true && document.getElementById(stopId).checked == true){
					alert(""+resourceJSON.msgForCurrentMedicationBothChecked);
					return false;
				}
				
				if (document.getElementById(repeatId).checked == true || document.getElementById(stopId).checked == true) {
					var checkForExistPvs=true;
					var treatementValue=0;
					 itemId=$($tds).closest('tr').find("td:eq(1)").find("input:eq(1)").val();
					if(document.getElementById(repeatId).checked == true){ 
					$('#nomenclatureGrid tr').each(function(i, el) {
						var $tds1 = $(this).find('td');
						 var itemIdForNomer=$($tds1).closest('tr').find("td:eq(0)").find("input:eq(1)").val( );
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
						k=1;
					}
					
				if(checkForExistPvs==true){
					
					
					
				treatementCurrent="";
				  sNo = $tds.eq(0).find(":input").val();
				 
				  itemIdName = $tds.eq(1).find(":input").val();
				  prescriptionHdIdCurrent=$($tds).closest('tr').find("td:eq(1)").find("input:eq(2)").val( );
				  prescriptionDTIdCurrent=$($tds).closest('tr').find("td:eq(1)").find("input:eq(3)").val( );
				 
				  dispUnit = $tds.eq(2).find(":input").val();
				  dosage = $tds.eq(3).find(":input").val();
				  frequencyId = $tds.eq(4).find(":input").val();
				  noOfDays = $tds.eq(5).find(":input").val();
				  total = $tds.eq(6).find(":input").val();
				  
				  var stockVal = $tds.eq(7).find(":input").val();
				  if(stockVal!=""){
					  stock=stockVal;
				  }
				  precribeBy = $tds.eq(8).find(":input").val();
				  department = $tds.eq(9).find(":input").val();
				  precribeDate = $tds.eq(10).find(":input").val();
				  var remarksVal = $tds.eq(13).find(":input").val();
				  if(remarksVal!="" && remarksVal!=0){
					  remarks=remarksVal;
				  }
				  var itemClassId = $tds.eq(14).find(":input").val();
				treatementCurrent += '<tr>';
				treatementCurrent += '<td>';
				treatementCurrent += '<div class="autocomplete forTableResp">';
				treatementCurrent += '<input type="text" autocomplete="never"  tabindex="1" size="77" value="'+itemIdName+'"';
				treatementCurrent += 'id="nomenclature' + k + '"  name="nomenclature1"   onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"';
				treatementCurrent += 'class="form-control border-input"';
				treatementCurrent += '" />';
				
				treatementCurrent += '<input type="hidden"  name="itemId" value="' + itemId + '" id="nomenclatureId'+ k + '"/>';
				treatementCurrent += '<input type="hidden"  name="prescriptionHdId" value="" id="prescriptionHdId'
						+ k + '"/>';
				treatementCurrent += '<input type="hidden"  name="prescriptionDtId" value="" id="precriptionDtId'
						+ k + '"/>';
				treatementCurrent += '	<div id="nomenclatureIdPvs'+k+'" class="autocomplete-itemsNew"></div>';
				treatementCurrent += '</div>';

				treatementCurrent += '</td>';

				/*treatementCurrent += '<td><input type="text" value="'
						+ dispUnit
						+ '" name="dispensingUnit1" ';
				treatementCurrent += ' id="dispensingUnit1'+k+'" size="6"';
				treatementCurrent += 'validate="AU,string,no"   class="form-control"/>';
				treatementCurrent += '</td>';
*/
				
				treatementCurrent += '<td ><select name="dispensingUnit1" class="form-control" id="dispensingUnit1'+ k + '" ';
				treatementCurrent += 'class="medium">';
				var dispStock = dispUnit;
				treatementCurrent += '<option value=""><strong>Select</strong></option>';

				var selectFre = "";
				$.each(masDispUnitList, function(ijk, item1) {

					if (dispStock == item1.storeUnitName) {
						selectFre = "selected";
					} else {
						selectFre = "";
					}
					treatementCurrent += '<option ' + selectFre
							+ ' value="' + item1.storeUnitId + '">'
							+ item1.storeUnitName + '</option>';
				});
				treatementCurrent += '</select>';
				treatementCurrent += '</td>';
				
				treatementCurrent += '<td><input type="text" class="form-control" size="5" name="dosage1" tabindex="1"';
				treatementCurrent += 'value=' + dosage
						+ ' id="dosage1'+k+'"  maxlength="5" onblur="fillValueNomenclature('+ count + ')"/>';
				treatementCurrent += '</td>';

				treatementCurrent += '<td><select name="frequencyTre" class="form-control" id="frequencyTre'
						+ i + '"';
				treatementCurrent += 'class="medium" onchange="fillValueNomenclature('+ count + ')">';

				var frequencyIdValue =frequencyId;
				treatementCurrent += '<option value=""><strong>Select</strong></option>';

				var selectFre = "";
				$.each(frequencyList, function(ij, item) {
					 
					if (frequencyIdValue == item.frequencyId) {
						selectFre = "selected";
					} else {
						selectFre = "";
					}
					treatementCurrent += '<option ' + selectFre	+ ' value="'+ item.feq + '@' + item.frequencyId	+ '">' + item.frequencyName+ '</option>';
				});
				treatementCurrent += '</select>';
				treatementCurrent += '</td>';

				treatementCurrent += '<td><input type="text" class="form-control" value="'
						+ noOfDays
						+ '" name="noOfDays1" tabindex="1"';
				treatementCurrent += '	id="noOfDays1'+k+'" onblur="fillValueNomenclature('+ count + ')" size="5"';
				treatementCurrent += '	maxlength="3" /></td>';

				treatementCurrent += '<td><input type="text" class="form-control" value="' + total + '" name="total1" tabindex="1"';
				treatementCurrent += 'id="total1'+k+'" size="5" validate="total,num,no"';
				treatementCurrent += '" /></td>';
				treatementCurrent +='<td><select name="instuctionFill" id="instuctionFill'+k+'" class="medium form-control width150"';
				treatementCurrent +='class="medium">';
				treatementCurrent +='<option value=""><strong>Select...</strong></option>';
				var instctionData=massTempInstructionList;
				var instrcution="";
				$.each(massTempInstructionList, function(ik, item) {
				    
															
					if(instrcution == item.instructionsName){
						selectInst="selected";
					}
					else{
						selectInst="";
					}
					
					treatementCurrent += '<option '+selectInst+' value="'+ item.instructionsName +'">' + item.instructionsName+'</option>';
				
				//trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationValue+''+'['+investigationId+']'+'" id="chargeCodeName" class="form-control border-input" name="chargeCodeName" onblur="populateChargeCode(this.value);putInvestigationValue(this)" /> <input type="hidden" id="qty" tabindex="1" name="qty1" size="10" maxlength="6" validate="Qty,num,no" /> <input type="hidden" tabindex="1" id="chargeCodeCode"	name="chargeCodeCode" size="10" readonly /> </div></td><td><input type="Date" id="investigationDate1" name="investigationDate" class="input_date" placeholder="DD/MM/YYYY" value="" maxlength="10" /></td><td><div class="labRadiologyDivfixed"></div> <input type="radio" value="I" id="othAfLab1'+i+'" class="radioCheckCol2" style="margin-right: 15px;" name="labradiologyCheck1'+i+'" /></td><td><div class="labRadiologyDivfixed"></div> <input type="radio" value="O" id="othAfLab1'+i+'" class="radioCheckCol2" style="margin-right: 15px;" name="labradiologyCheck1'+i+'"/></td><td><input type="checkbox" name="urgent" id="uCheck" tabindex="1" class="radioAuto" value="1" /><td style="display:none";><input type="hidden" value="'+investigationId+'" tabindex="1" id="inestigationIdval" size="77" name="inestigationIdval" /></td> </td><td><button type="button" type="button" class="btn btn-primary buttonAdd" value="" tabindex="1"	onclick="addRowForInvestigation();">Add</button></td><td><button type="button" name="delete" value="" class="buttonDel btn btn-danger" tabindex="1" onclick="removeRow("dgInvetigationGrid","hiddenValue",this);">Delete</button></td></tr>';
				});
				treatementCurrent +='</select>';
				treatementCurrent +='</td>';
				
				treatementCurrent += '	<td><input type="text" class="form-control" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" name="closingStock1" tabindex="1"  value="'+ stock + '"';
				treatementCurrent += 'id="closingStock1" size="3"';
				treatementCurrent += 'validate="closingStock,string,no" readonly/></td>';
			
				
				treatementCurrent += '<td style="display:none"><input  type="hidden" value="" tabindex="1"';
				treatementCurrent += '	id="itemIdNom" size="77" name="itemIdNom" /></td>';

				treatementCurrent += '<td><button name="Button" type="button"';
				treatementCurrent += '	class="buttonAdd btn btn-primary noMinWidth" value="" button-type="add" onclick="addNomenclatureRowRecall();"';
				treatementCurrent += '	tabindex="1" > </button></td>';

				treatementCurrent += '<td><button type="button" name="delete" id="treatementId" value=""';
				treatementCurrent += 'class="buttonDel btn btn-danger noMinWidth" button-type="delete"';
				treatementCurrent += '	onclick="removeRowInvestigation(this,\''
						+ investigationGridValue
						+ '\','
						+ prescriptionDTIdCurrent + ');"';
				treatementCurrent += '	tabindex="1"> </button></td>';
				
				treatementCurrent += '<td style="display: none;"><input type="hidden" name="pvmsNo1" tabindex="1"';
				treatementCurrent += '	id="pvmsNo1'+k+'" size="10" readonly="readonly" />';
				treatementCurrent += '</td>';
				
				treatementCurrent += '<td style="display: none;"><input type="hidden"';
				treatementCurrent += 'name="itemClassId" tabindex="1" id="itemClassId'+k+'" size="10" value='+itemClassId+'';
				treatementCurrent += 'readonly="readonly" /></td>	';
				
				treatementCurrent += '</tr>';
				k++;
				}
				if(document.getElementById(stopId).checked != true){
					$("#nomenclatureGrid").append(treatementCurrent);
					//geTreatmentInstructionData();
					countForCloseModel+=1;
				}
				}
				
				if (document.getElementById(stopId).checked == true) {
					
					precriptionDtValueArray.push(prescriptionDTIdCurrent);
					 
				}
		});
	if(precriptionDtValueArray!="" && precriptionDtValueArray!=null && precriptionDtValueArray.length>0){
	 //$('#precriptionDtIdVal').val(precriptionDtValueArray);

	/* var userId=$('#userId').val();
	
	 var params = {
				"precriptionDtValue": precriptionDtValueArray,
				"userId" : userId
		}precriptionDtIdVal
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : 'updateCurrentMedication',
			data : JSON.stringify(params),
			dataType : "json",
			success : function(response) {
			alert(""+resourceJSON.msgForUpdateCurrentMedi);
			closeCurrentMedication();
			}
		});*/
		
	}
	alert(""+resourceJSON.msgForUpdateCurrentMedi+'S');
	closeCurrentMedication();
	
	 if(countForCloseModel!=0){
		 closeCurrentMedication();
	 }
	 document.getElementById("recommendedMedicalAdvice").focus();
}
var userNameGlob="";
function showAllCurrentMedication(mode,className)
{
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
			var data = {'pageNo':nPageNo,'userId' : userId, 'patientId' : patientId,'unitId':unitId,'departmentId':departmentId,'mmuId1':hsId};			
		}
	else
		{
			var data =  {'pageNo':nPageNo,'patientId':patientId,'userId':userId, 'unitId':unitId,'departmentId':departmentId,'mmuId1':hsId}; 
		} 
	var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";
	var urlShowCurrentMedication = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/showCurrentMedication";

	var url = urlShowCurrentMedication;
	var bClickable = true;
	GetJsonDataForCommon('tblListOfCommand',data,url,bClickable,"waitingImgId",className,"currentMedicationGrid","resultnavigationForCurrentMedication");
}




function checkReferTORecall(id) {
	if (document.getElementById('referInternal').checked == true) {
		document.getElementById('referhospital').setAttribute("validate", " ");
		document.getElementById('referredFor').setAttribute("validate", " ");
		document.getElementById('referhospitalLabel').style.display = 'none';
		document.getElementById('referhospital').style.display = 'none';
		document.getElementById('referdayslLabel').style.display = 'none';
		document.getElementById('referdays').style.display = 'none';
		document.getElementById('referral_treatment_type_label').style.display = 'none';
		document.getElementById('referral_treatment_type').style.display = 'none';
		document.getElementById('referredFor').style.display = 'none';
		document.getElementById('referredForLabel').style.display = 'none';
		document.getElementById('referDepartmentDiv').style.display = 'block';
			
	} else if (document.getElementById('referExternal').checked == true) {
		
		document.getElementById('referhospital').setAttribute("validate", " ");
		document.getElementById('referredFor').setAttribute("validate", " ");
		document.getElementById('referhospitalLabel').style.display = 'none';
		document.getElementById('referhospital').style.display = 'none';
		document.getElementById('referdayslLabel').style.display = 'none';
		document.getElementById('referdays').style.display = 'none';
		document.getElementById('referral_treatment_type_label').style.display = 'none';
		document.getElementById('referral_treatment_type').style.display = 'none';
		document.getElementById('referredFor').style.display = 'none';
		document.getElementById('referredForLabel').style.display = 'none';
		document.getElementById('referDepartmentDiv').style.display = 'block';
	} else {
		document.getElementById('referhospital').setAttribute("validate",
				"Hospital,String,yes");
		document.getElementById('referral_treatment_type').setAttribute(
				"validate", "Referral Type,String,yes");
		document.getElementById('referredFor').setAttribute("validate",
				"Referred for,String,yes");
		document.getElementById('referhospitalLabel').style.display = 'block'
		document.getElementById('referhospital').style.display = 'block';
		;
		document.getElementById('referdayslLabel').style.display = 'block';
		document.getElementById('referdays').style.display = 'block';
		document.getElementById('referral_treatment_type_label').style.display = 'block';
		document.getElementById('referral_treatment_type').style.display = 'block';
		document.getElementById('referredFor').style.display = 'block';
		document.getElementById('referredForLabel').style.display = 'block';
		document.getElementById('referDepartmentDiv').style.display = 'block';
	}
}



function autoCompleteCommon(val,flag){
	if(flag=='1'  ){
		autocomplete(val, arryInvestigation);
	}
	if(flag=='2'){
		autocomplete(val, arryNomenclature);
	}
	if(flag=='3'){
		autocomplete(val, arryProcedureCare);
	}
	if(flag=='4'){
		autocomplete(val, arryNomenclatureNip1);
	}
	if(flag=='5'){
		autocomplete(val, arry);
	}
}

 function getDateInDDMMYYY(dateCheck){ 
	 var dateFormat="";
	 var today1="";
	 if(dateCheck!=null || dateCheck!=""){
	   today1 = new Date(dateCheck);
	 var dd = String(today1.getDate()).padStart(2, '0');
	 var mm = String(today1.getMonth() + 1).padStart(2, '0'); 
	 var yyyy = today1.getFullYear();
	 dateFormat =  dd + '/' + mm + '/' +yyyy;
	 } 
	 return dateFormat;
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
 						$('.referSpecialistList').html(specialistHtml);
 					});
 					
 					
 				  
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

 
 
 function getUsersAuth(){
		
		var j=1;
	    
		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/opd/getUsersAuthentication";
		$
				.ajax({
					url : url,
					dataType : "json",
					data : JSON.stringify({
						"pageNo":1,
						"serviceNo":$('#serviceNo').val(),
						"hospitalId":hsId
					}),
					contentType : "application/json",
					type : "POST",
					success : function(response) {
						console.log(response);
						var datas = response.data;
						var count= response.count;
						document.getElementById("usersCounts").value=count;
						/*var trHTML = '<option value=""><strong>Select Hospital...</strong></option>';
						$.each(datas, function(i, item) {
							trHTML += '<option value="' + item.empanelledHospitalId + '@'
									+ item.empanelledHospitalCode + '" >' + item.empanelledHospitalName
									+ '</option>';
							$('.referHospitalListClass').html(trHTML);
						});*/
						
						
					  
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

 
 function saveAllergyHistory(){
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
	 	$('#allergyHistoryGrid tr').each(function(i, el) {
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
 
 var markAsMLC='';
 function marksAsMLCRecall()
 {
 
     if(document.getElementById("markMLC").checked == true){
     	markAsMLC="Y";
     	$('#markAsMlcFlag').val('Y');
     	$('#markMLCSection').show();
     	var someDate = new Date();
     	var dd = someDate.getDate();
     	var mm = someDate.getMonth() + 1;
     	var y = someDate.getFullYear();
     	var someFormattedDate = dd + '/'+ mm + '/'+ y;
     	$('#'+"mlcDate").val(someFormattedDate);
     	var mmuName=$('#mmuName').val();
    	var campName=$('#campName').val();
    	$('#'+"mlcNameOfInstatuition").val('MMSSY,'+mmuName);
       	$('#'+"mlcPlace").val(campName); 
     	
     	
     	
     }
     else
     {
     	markAsMLC="N";
     	$('#markAsMlcFlag').val('N');
     	$('#markMLCSection').hide();
     	//alert("this is false")
     }	
 } 
 
 var followUpFlagValue='';
 
 function followUpFlagRecall()
 {
 
     if(document.getElementById("followUpChecked").checked == true){
     	followUpFlagValue="Y";
     	$('#followUpFlagValRecall').val('Y');
     	//alert("this is true")
     	
     }
     else
     {
     	followUpFlagValue="N";
     	$('#followUpFlagValRecall').val('N');
     	//alert("this is false")
     }	
 } 
 
 function nextFolloUpDateRecall(val)
 {
		if(document.getElementById("followUpChecked").checked == true){
			   
			if(val=="")
		 	{
		 		$('#'+"nextFollowUpDate").val('');	
		 	}
			else if(val==16 && val!=17)
			{
				var someDate = new Date();
				var numberOfDaysToAdd =parseInt(3);
				someDate.setDate(someDate.getDate() + numberOfDaysToAdd); 
				var dd = someDate.getDate();
				var mm = someDate.getMonth() + 1;
				var y = someDate.getFullYear();

				var someFormattedDate = dd + '/'+ mm + '/'+ y;
				$('#'+"nextFollowUpDate").val(someFormattedDate);
				$('#'+"nextFollowUpDate").attr('readonly', true);	
			}
			
			else if(val!=16 && val!=17)
			{	
			var someDate = new Date();
			var numberOfDaysToAdd =parseInt(val);
			someDate.setDate(someDate.getDate() + numberOfDaysToAdd); 
			var dd = someDate.getDate();
			var mm = someDate.getMonth() + 1;
			var y = someDate.getFullYear();

			var someFormattedDate = dd + '/'+ mm + '/'+ y;
			$('#'+"nextFollowUpDate").val(someFormattedDate);
			$('#'+"nextFollowUpDate").attr('readonly', true);
			}
			else if(val==17)
			{	
			
			$('#'+"nextFollowUpDate").val("");
			$('#'+"nextFollowUpDate").attr('readonly', false);
			}
			 
		   }
		   else
		   {
		     alert("Please Mark Follow-up ")
		     $('#'+"nextFollowUpDate").val("");
		     $('#'+"noOfDays").val("");
		     return false;
		   }	

}
 
 var total_patient_value = '';
 var digaoReferal='';   
 var patientValue = '';
 var multiPSValueForNew=[];
 var autoPsCode = '';
   function populateSignAndSymptoms(val) {
   	  
       if (val == "") {
           return;
       } else {
           obj = document.getElementById('patientSympotnsId');
           total_patient_value += val+",";
          
           obj.length = document.getElementById('patientSympotnsId').length;
           var b = "false";
           for(var i=0;i<signAndSymptomsGlobalArray.length;i++){
        		  
        		  var name = signAndSymptomsGlobalArray[i].name;
        		 
        		  if(name == val){
             			patientValue = signAndSymptomsGlobalArray[i].id;
             			var patientName = signAndSymptomsGlobalArray[i].name;
             			 $("#patientSympotnsId span").each(function()
                          		{
             				 			var text=$(this).text();
             				 			var valueOrg=text.split('[')
             				 			var idVal=valueOrg[0];
             				 		    if(idVal==patientName){
                          		    alert("Sign and Symptoms is already added");
                          		    document.getElementById('patientSymptons').value = ""
                          		    b=true;
                          		    }
                          		});
             		  }
        	  }
	      
           if (b == "false") {
           	
               $('#patientSympotnsId').append('<span value=' + patientValue + '>' + val + '</span>');
               multiPSValueForNew.push(patientValue);
               document.getElementById('patientSymptons').value = ""

           }
           $('#patientSympotnsValue').val(multiPSValueForNew);
           $('#patientSymAuditId').val(multiPSValue);
       }
   }
 
 function getPatientSympotonsRecall() {

	  	var pathname = window.location.pathname;
	  	var accessGroup = "MMUWeb";
	  	var url = window.location.protocol + "//"
	  	+ window.location.host + "/" + accessGroup
	  	+ "/opd/getPatientSympotons";
	  
	  	$
	  			.ajax({
	  				url : url,
	  				dataType : "json",
	  				data : JSON.stringify({
	  					'visitId' : $('#visitId').val()
	  				}),
	  				contentType : "application/json",
	  				type : "POST",
	  				success : function(response) {
	  					console.log(response);
	  					var datasPatient = response.patientSymptoms;
	  					var patientIDValuennn = "";
	  					patientIDValuennn += '<div class="multiDiv" name="patientSympotnsId" id="patientSympotnsId">';
	  				
						var mcdIdValueePatient = "";
						for (var i = 0; i < datasPatient.length; i++) {
							patientIDValuennn += '<span id="'+ datasPatient[i].symptomId + '&&&' + 0
									+'">' + datasPatient[i].symptomName + "["
									+ datasPatient[i].symptomId + "]"
									+ '</span>';
							multiPSValue.push(datasPatient[i].symptomId);
						}
						patientIDValuennn += '</div>';
						$("#patientSympotnsIdDiv").html(patientIDValuennn);
						 $('#patientSymAuditId').val(multiPSValue);
							
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

	  function deletePatientSympotonsItems() {
		  var orgValue=[];
		  var deletepatient = document.getElementById('patientSympotnsId');
	       if (deletepatient.selectedIndex == -1)
	    	   {
	    	       alert("Please select atleast one Signs and Symptoms")
	    	       return false;
	    	   }
	    	   else
	    		   {
	    		     //var psId=document.getElementById('patientSympotnsId').options[document.getElementById('patientSympotnsId').selectedIndex].value;
	    		     var format = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]+/;
	    		   
	        		   if (confirm(resourceJSON.opdIcdDeleteMsg)) {
	        			  // $("#multiDiv").find(".active").remove();
	        			   var psId = $('#patientSympotnsId .active').attr('id');
	        			   var value=$('span.active');
	                      if (!format.test(psId) )
	                    	   {
	                    	  		$('span.active').remove();
	                    	  		
	                    		  	  $('#patientSympotnsId').find('span').each(function() { 
	                    		  		    var id = this.id;
	                    		  		    var value = $(this).html();
	                    		  		   	var valueOrg=value.split('[')
	                    		 	 			var idVal=valueOrg[1];
	                    		  		   var valueOrgSec=idVal.split(']')
	                    		 	 			orgValue.push(valueOrgSec[0]);	
	                    		  		});
	                    		  	 $('#patientSymAuditId').val(orgValue);
	                    		     	
	                    		    	
	                    	   }

			        		   else
			        			  {
			        			 
			        			   var pathname = window.location.pathname;
			        				var accessGroup = "MMUWeb";
			        				var urldeleteGridRow = window.location.protocol + "//"+ window.location.host + "/" + accessGroup+ "/opd/deletePatientSymptom";
			
			        				var data = {
			        					"visitId" : $('#visitId').val(),
			        					"symptomId" : psId
			        				};
			        				$.ajax({
			        					type : "POST",
			        					contentType : "application/json",
			        					url : urldeleteGridRow,
			        					data : JSON.stringify(data),
			        					dataType : "json",
			        					cache : false,
			        					success : function(res) {
			        				     var datass=res.msg;
			        				     if(datass=="recordsDeleted")
			        				    	{
			        				    	 $('span.active').remove();
			        				    		
			        					  	  $('#patientSympotnsId').find('span').each(function() { 
			        					  		    var id = this.id;
			        					  		    var value = $(this).html();
			        					  		   	var valueOrg=value.split('[')
			        					 	 			var idVal=valueOrg[1];
			        					  		   var valueOrgSec=idVal.split(']')
			        					 	 			orgValue.push(valueOrgSec[0]);	
			        					  		});
			        					  	 $('#patientSymAuditId').val(orgValue);
			        					     	
			        					    	
			        				    	} 
			        					}
			        				});
			
			        			  } 
	        		   }
	    		   }
	      
	    }
	  
	  var globalDataForDiagnosis = "";
	
	  function getPatientDiagnosisDetail() {
	  	var pathname = window.location.pathname;
	      var accessGroup = "MMUWeb";
	  	var getPatientDianosisDetail = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/getPatientDianosisDetail";
	  	
	  	var opdPatientDetailId = $('#opdPatientDetailId').val();
	  	var patientId = $('#patientId').val();
	  	var visitId = $('#visitId').val();
	  	var hospitalId = $('#hospitalId').val();
	  	var cityId=$('#cityIdVal').val();
	  	var masIcdList = "";
	  	var diagnosisHtml='';
	  	var diagnosisGridValue = "diagnosisGridRecall";
	  	var data = {
	  		"opdPatientDetailId" : opdPatientDetailId,
	  		"patientId" : patientId,
	  		"visitId" : visitId,
	  		"flagForRefer":"Ex",
	  		"cityId":cityId,
	  		"hospitalId":hospitalId
	  	};
	  	$.ajax({

	  				type : "POST",
	  				contentType : "application/json",
	  				url : getPatientDianosisDetail,
	  				data : JSON.stringify(data),
	  				dataType : "json",
	  				// cache: false,
	  				success : function(res) {
	  					masIcdList = res.data;
	  					var diagnosisHtml="";
	  					for (var i = 0; i < masIcdList.length; i++) {
	  					 //var objdiagnosisHtml= listPatientImpantHistory[i];
	  						var diagnosisIdValue=masIcdList[i].icdName;
		  					 var diagnosisId=masIcdList[i].icdId;
		  					 var diagnosisCode=masIcdList[i].icdCode;
		  					 var diagnosisDtValue=masIcdList[i].diagnosisDtValue;
		  					var communicableFlag='';
		  					if(masIcdList[i].communicableFlag=="Y")
		  					{	
		  						communicableFlag="checked=checked";
		  					}
		  					else
		  					{
		  						communicableFlag="";
		  					}	
		  					var infectiousFlag='';
		  					if(masIcdList[i].infectiousFlag=="Y")
		  					{	
		  						infectiousFlag="checked=checked";
		  					}
		  					else
		  					{
		  						infectiousFlag="";
		  					}
		  					   func1='newDiagnosisPopulateRecall';
							    url1='opd';
							    url2='getIcdListByName';
							    flaga='dignosis';
							    
							    url3='treatmentAudit';
							    url4='getAllIcdForOpd';
							    flagb='mouseOver';
	  					 diagnosisHtml+='<tr>';
	  					 diagnosisHtml+='<td>';
	  					diagnosisHtml += '<div   class="autocomplete forTableResp">';
	  					diagnosisHtml += '<input type="text"   value="'
								+ diagnosisIdValue + '['
								+ diagnosisCode
								+ ']" id="diagnosisIdRecall' + count + '"';
	  					/*onmouseup="getOpdNomenClatureList(this,\''+func1+'\',\''+url3+'\',\''+url4+'\',\''+flaga+'\',\''+flagb+'\');" */
	  					diagnosisHtml += ' class="form-control" size="55" name="diagnosisIdRecall" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
	  					
	  					 diagnosisHtml+='<div class="autocomplete-itemsNew" id="diagnosisDivRecll'+count+'" ></div>';
	  					 diagnosisHtml+='</div>';
	  					 /*diagnosisHtml+='<input type="hidden" id="diagnosisIdvalRecall'+diagnosisId+'" name="diagnosisIdvalRecall" value="'+diagnosisId+'">';*/
	  					 diagnosisHtml+='<input type="hidden" id="diagnosisIdTableId'+diagnosisDtValue+'" name="diagnosisIdTableId" value="'+diagnosisDtValue+'">';
	  					 diagnosisHtml+='</td>';
	  					 
	  					 diagnosisHtml+='<td class="text-center width220">';
	  					 diagnosisHtml+=' <div class="form-check form-check-inline cusCheck m-t-7">';
	  					 diagnosisHtml+=' <input class="form-check-input" '+communicableFlag+' id="markDiseaseRecall'+diagnosisId+'" name="markDiseaseRecall" value="1" type="checkbox">';
	  					 diagnosisHtml+=' <span class="cus-checkbtn"></span></div>';
	  					 diagnosisHtml+=' </td>';
	  					 
	  					 diagnosisHtml+='<td class="text-center width220">';
	  					 diagnosisHtml+=' <div class="form-check form-check-inline cusCheck m-t-7">';
	  					 diagnosisHtml+=' <input class="form-check-input" id="markInfectionRecallRecall'+diagnosisId+'" '+infectiousFlag+' name="markInfectionRecall" type="checkbox">';
	  					 diagnosisHtml+=' <span class="cus-checkbtn"></span></div>';
	  					 diagnosisHtml+=' </td>';
	  					
	  					 diagnosisHtml+=' <td>';
	  					 diagnosisHtml+=' <button name="Button" type="button" id="addDiagnosisRowRecall" name="addDiagnosisRowRecall" class="buttonAdd btn btn-primary noMinWidth m-r-10" button-type="add" value="" tabindex="1" onclick="addDiagnosisRecall()"></button>';
	  					 diagnosisHtml+=' </td>';
	  					/* diagnosisHtml+=' <td>';
	  					 diagnosisHtml+=' <button name="Button" type="button" id="deleteDiagnosisRowRecall" name="deleteDiagnosisRowRecall" class="buttonDel btn btn-danger noMinWidth" button-type="delete" value="" tabindex="1" onclick="deleteDiagnosisRecallRecall()"></button>';
	  					 diagnosisHtml+=' </td>';*/
	  					 
	  					diagnosisHtml += '<td><button type="button" name="delete" id="deleteDiagnosisRowRecall" button-type="delete" value=""';
	  					diagnosisHtml += 'class="buttonDel btn btn-danger noMinWidth"';
	  					diagnosisHtml += '	onclick="removeRowInvestigation(this,\''
								+ diagnosisGridValue
								+ '\','
								+ diagnosisDtValue + ');"';
	  					diagnosisHtml += '	tabindex="1"></button></td>';
	  					 
	  					 
	  				     diagnosisHtml+=' <td style="display: none";>';
	  					 diagnosisHtml+=' <input type="hidden" tabindex="1" id="diagnosisIdvalRecall'+count+'" value="'+diagnosisId+'" size="77" name="diagnosisIdvalRecall" />';
	  					 diagnosisHtml+=' </td>';
	  					 diagnosisHtml+=' </tr>';
	  					 count+=1;
	  				}
	  	
	  				
	  					$("#diagnosisGridRecall").html(diagnosisHtml);
	  					
	  				}
	  	          
	  			});

	  	return false;
	  }
	  
	  var newIcdValue ='';
	     var newChargeCode='';
	     var multipleChargeCode = new Array();
	     function newDiagnosisPopulateRecall(val,count,item) {//alert("called");
	    		if (val != "") {
	    			 var communicable='';
	            	 var infectious=''; 
	            	 
	    			var index1 = val.lastIndexOf("[");
	    			var indexForBrandName = index1;
	    			var index2 = val.lastIndexOf("]");
	    			index1++;
	    			newChargeCode = val.substring(index1, index2);
	    			var indexForBrandName = indexForBrandName--;
	    			var brandName = val.substring(0, indexForBrandName);
	    			// alert("pvms no--"+pvmsNo)
	    	      	
	    			if (newChargeCode == "") {
	    				
	    				return false;
	    			} 
	    			else
	    			{
	    			
	    		     	  for(var i=0;i<autoIcdCode.length;i++){
	    		     
	    		     		  var icdNo1=icdData[i].icdCode;
	    		     		  
	    		     		 communicable=icdData[i].communicableFlag;
	              			infectious=icdData[i].infectionsFlag;
	              			   		     		 
	    		     		  if(icdNo1 == newChargeCode){
	    		     			 newIcdValue = icdData[i].icdId;
	    		     			 var patientSymAuditId=$('#patientSymAuditId').val();
	    		     			var array = patientSymAuditId.split(',');

	    		     			array.sort(function(a, b) {
								  return a - b;
								});
	    		     			 console.log(array);
	    		     			$('#patientSymAuditId').val(array);
	    		     			 patientSymAuditId=$('#patientSymAuditId').val();
	    		     			 if(patientSymAuditId!=null &&patientSymAuditId!='')
		     	     		        {
		     	     				    var pathname = window.location.pathname;
		     	     					var accessGroup = "MMUWeb";
		     	     					var url = window.location.protocol + "//"
		     	     					+ window.location.host + "/" + accessGroup
		     	     					+ "/opd/getAIDiagnosisDetail";
		     	     					$
		     	     							.ajax({
		     	     								url : url,
		     	     								dataType : "json",
		     	     								data : JSON.stringify({
		     	     									"patientSympotnsId":patientSymAuditId,
		     	     									"diagnosisId":newIcdValue
		     	     								}),
		     	     								contentType : "application/json",
		     	     								type : "POST",
		     	     								success : function(response) {
		     	     								console.log(response);
		     	     								var data=response.data;
		     	     							    if(data[0].diagnosisCount>0)
		     	     								 {
		     	     							    	$('#msgForAIDiagnosis').show();
		    	     							    	$('#currentDiagnosisRowItem').val(val);
		    	     							    	$('.modal-backdrop').show();	
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
	    	      			    var checkCurrentRowIddd=$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
	    	        			var checkCurrentRow=$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").val();
	    	   			         var count=0;   			
	    	   			        $('#diagnosisGridRecall tr').each(function(i, el) {
	    	        			    var $tds = $(this).find('td')
	    	       			        var chargeCodeId=  $($tds).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
	    	       			        var chargeCodeIdValue=$('#'+chargeCodeId).val();
	    	       			        var idddd =$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
	    	       			        var currentidddd=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
	    	       			    	  if(chargeCodeId!=checkCurrentRowIddd && newIcdValue==chargeCodeIdValue)
	    	       			          {
	    	       			    		  	if(newIcdValue==chargeCodeIdValue){
	    	       			       			alert("Diagnosis is already added");
	    	       			        		$('#'+idddd).val("");
	    	       			        		$('#'+currentidddd).val("");
	    	       			        		$('#'+chargeCodeIdValue).val("");
	    	       			        		return false;
	    	       			           }
	    	       			          			        
	    	       			            }
	    	       			            else
	    	       			        	{
	    	       			        	     
	    	       			        	   $(item).closest('tr').find("td:eq(5)").find(":input").val(newIcdValue);
	    	       			        	   if(communicable=="Y")
	    	       			        	   {	   
	    	       			        	   $(item).closest('tr').find("td:eq(1)").find(":input").prop('checked', true);
	    	       			        	   }
		    	       			           if(infectious=="Y")
		 	       			        	   {	   
		 	       			        	   		$(item).closest('tr').find("td:eq(2)").find(":input").prop('checked', true);
		 	       			        	   }
	    	       			        	   
	    	       			        	
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
	     
	     function clearAiDiagnosis(val)
	     {
	     	var currentValue=val;
	     	$('#diagnosisGridRecall tr').each(function(i, el) {
				  var $tds = $(this).find('td')
				        var chargeCodeId=   $($tds).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
				        var chargeCodeIdValue=$('#'+chargeCodeId).val();
				        var chargeCodeIdSecond=   $($tds).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
				        if(currentValue==chargeCodeIdValue)
				        {	
				      		$('#'+chargeCodeId).val("");
				        	$('#'+chargeCodeIdSecond).val("");
				        }
				     			        	
				   });
	     	$('#msgForAIDiagnosis').hide();
	     	$('.modal-backdrop').hide();
	     }
	  
	  var diagnosislastRow;
	  var di=100;
	  function addDiagnosisRecall(){
	  	    di++
	  	    var aClone = $('#diagnosisGridRecall>tr:last').clone(true);
	  		aClone.find(":input").val("");
	  		 aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'diagnosisIdRecall'+di+'');
	  		aClone.find("td:eq(1)").find(":input").prop('checked', false);
	  	    aClone.find("td:eq(2)").find(":input").prop('checked', false);
	  	    //aClone.find("td:eq(0)").find("div").find("div").prop('id', 'investigationDivOpd' + di + '');
	  	   aClone.find("td:eq(5)").find("input:eq(0)").prop('id', 'diagnosisIdvalRecall'+di+'');
	  		aClone.clone(true).appendTo('#diagnosisGridRecall');
	  		var valDiagnosis = $('#diagnosisGridRecall>tr:last').find("td:eq(0)").find(":input")[0];
	  			    		
	  		  var tbl = document.getElementById('diagnosisGridRecall');
	     	  lastRow = tbl.rows.length;
	     
	  }
	  
	  function noOfDaysAlertRecall(val,item)
	  {
	  	var fiftenDays=resourceJSON.msgForfiftenDays;
	  	var thirtyDays=resourceJSON.msgForthirtyDays;
	  	
	  	var noofdays = val;	
	  	if(parseFloat(noofdays) > parseFloat(fiftenDays) && parseFloat(noofdays) < parseFloat(thirtyDays))
	  	{
	  		$('#messageForTreatmentAlert').show();
	  		$('.modal-backdrop').show();
	  		return false;
	  	
	  	}
	  	if(parseFloat(noofdays) > parseFloat(thirtyDays))
	  	{
	  		alert("You can not prescribe more than 30 days.")
	  		
	  		$('#nomenclatureGrid tr').each(function(i, el) {
	  			var $tds = $(this).find('td')
	  			var noofdaysId = $(item).closest('tr').find("td:eq(4)").find("input:eq(0)").attr("id");
	  			 $(item).closest('tr').find("td:eq(4)").find(":input").val("")
	  			
	  			return false;
	  		});
	  	}
	  	
	  }
	  
	  function showDoctorRemarksTemplate(mode,className)
	  {
	  	$('modal-backdrop').show();

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
	  			var data = {'pageNo':nPageNo,'userId' : userId, 'patientId' : patientId,'unitId':unitId,'departmentId':departmentId};			
	  		}
	  	else
	  		{
	  			var data =  {'pageNo':nPageNo,'patientId':patientId,'userId':userId, 'unitId':unitId,'departmentId':departmentId}; 
	  		} 
	  	var pathname = window.location.pathname;
	      var accessGroup = "MMUWeb";
	  	var urlShowCurrentMedication = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/getTemplateMedicalAdvice";

	  	var url = urlShowCurrentMedication;
	  	var bClickable = true;
	  	GetJsonDataForCommon('tblListOfCommand',data,url,bClickable,"waitingImgId",className,"modelForDoctorRemarksGrid","resultnavigationForDoctorRemarks");

	  }

	  function showDoctorRemarksSelect(data){
	  	var currentMedication = '';
	  			  var readonlyForCuttentMedication='readonly';
	  			currentMedication += '<div class="autocomplete forTableResp">';
	  			var countNo = 1;
	  			if (data == null || data.length == 0) {
	  				currentMedication = currentMedication+"<tr ><td colspan='3'><h6>No Record Found</h6></td></tr>";
	  				$("#modelForDoctorRemarksGrid").html(currentMedication);
	  				$("#modelForDoctorRemarks").show();
	  				$(".modal-backdrop").show();
	  			}
	  			investigationGridValue = "modelForDoctorRemarksGrid";
	  			var counttt=$('#countValueshowDoctorRemarksTemplate').val();
	  			if(counttt==""){
	  				countNo=1;
	  			}
	  			else{
	  				if(nPageNo==1){
	  					countNo=1
	  				}
	  				else{
	  				countNo=counttt;
	  				}
	  				}
	  			var count=1;
	  			
	  			   
	  			   for (var i = 0; i < data.length; i++) {
	  				currentMedication += '<tr>';
	  				
	  				currentMedication += '<td>' + countNo + '</td>';
	  				
	  				
	  				currentMedication += '<td>';
					currentMedication += '<textarea tabindex="1"  size="77"';
					/*currentMedication += 'id="nomenclatureCurrent' + countNo + '"  name="nomenclatureCurrent"  onKeyPress="autoCompleteCommon(this,2);" onblur="populatePVMSTreatment(this.value,'+count+',this);"';*/
					currentMedication += 'id="nomenclatureCurrent' + countNo + '"  name="nomenclatureCurrent"';
					currentMedication += 'class="form-control border-input width-full"';
					currentMedication += '" '+readonlyForCuttentMedication+'>' + data[i].medicalAdvice + '</textarea>';
					/*currentMedication += '<input type="hidden"  name="itemId" value="' + data[i].templateMadviceId + '" id="nomenclatureId'
							+ data[i].itemId + '"/>';
					*/
					currentMedication += '</div>';
					currentMedication += '</td>';
					currentMedication += '<td style="display:none">';
					currentMedication += '<input type="text"  name="itemId" value="' + data[i].templateMadviceId + '" id="nomenclatureId'
					+ data[i].itemId + '"/>';
					currentMedication += '</td>';
					currentMedication += '<td><input type="checkBox" name="repeatCheck" id="repeatCheck'+data[i].templateMadviceId+'" value="1"';
					currentMedication += 'tabindex="1"></td>';
					
					currentMedication += '<td style="display:none"><input  type="text" value="'
						+ data[i].dispStock + '" name="dispensingUnitCurrent" ';
					currentMedication += ' id="dispensingUnitCurrent'+countNo+'" size="6"';
					currentMedication += 'validate="AU,string,no"   class="form-control"/>';
					currentMedication += '</td>';
	  		

	  				currentMedication += '</tr>';
	  				countNo++;
	  			}
	  			$('#countValueCurrentMedi').val(countNo);
	  			currentMedication += '</div">';
	  			$("#modelForDoctorRemarksGrid").html(currentMedication);
	  			$("#modelForDoctorRemarks").show();
	  			$(".modal-backdrop").show();
	  		//}
	  	//});
	  	
	  }

	  function submitDoctorRemarks()
	  {
	  	var doctorRemarksId=[];
	  	var doctorRemarksText=[];
	  	$('#modelForDoctorRemarksGrid tr').each(function(i, el) {
	  				var $tds = $(this).find('td');
	  				var repeatId = $tds.eq(3).find(":input").attr("id");
	 			   
					if (document.getElementById(repeatId).checked == true) {
						var checkForExistPvs=true;
						var treatementValue=0;
						var itemId=$($tds).closest('tr').find("td:eq(2)").find("input:eq(0)").val();
						 var remarksValue=$($tds).closest('tr').find("td:eq(1)").find("textarea:eq(0)").val();
						 doctorRemarksId.push(itemId);
						 doctorRemarksText.push(remarksValue);
	  					
	  				}
	  				});	
	  	$('#doctorRemarksArrayVal').val(doctorRemarksId);
	  	$('#additionalNote').val(doctorRemarksText);
	  	closeDoctorRemarks();
	  }

	  function closeDoctorRemarks(){
	  	$('#modelForDoctorRemarks').hide();
	  	$('.modal-backdrop').hide();
	  	document.getElementById("additionalNote").focus();
	  	}
	  
	  function opdRecallBackFunction()
		{
		  window.location.href ="opdPatientRecall";
		}