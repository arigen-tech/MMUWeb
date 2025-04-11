////////////////////////////////////////Start Current Medication Code /////////////////////////////////////
var frequencyList="";
var userNameGlob="";
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
				

				currentMedication += '<td><input type="text" class="form-control" size="5" name="dosageCurrent" tabindex="1"';
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

				currentMedication += '	<td><input type="text" class="form-control width50" value="'+ data[i].noOfDays + '" name="noOfDaysCurrent" tabindex="1"';
				currentMedication += '	id="noOfDaysCurrent'+countNo+'" onblur="fillValueNomenclature(' + count + ')" size="5"';
				currentMedication += '	maxlength="3" '+readonlyForCuttentMedication+'/></td>';
				var totalValue="";	
				if(data[i].total!=null){
					totalValue=data[i].total;
					}
				currentMedication += '<td><input type="text" class="form-control width50" value="' +totalValue+ '" name="totalCurrent" tabindex="1"';
				currentMedication += 'id="totalCurrent'+countNo+'" size="5"  ';
				currentMedication += 'onblur="treatmentTotalAlert(this.value,1)" '+readonlyForCuttentMedication+'/></td>';


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
				currentMedication += '	id="pvmsNo1" size="10" readonly="readonly" />';

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

var frequencyList_old="";
function showCurrentMedication_Old(data,frequencyList,itemStopbByDoctor,count){
	  var currentMedication = '';
	currentMedication += '<div class="autocomplete">';
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
	for (var i = 0; i < data.length; i++) {
		currentMedication += '<tr>';
		
		currentMedication += '<td>' + countNo + '</td>';
		
		
		currentMedication += '<td>';
		currentMedication += '<div class="autocomplete">';
		currentMedication += '<input type="text" autocomplete="off" tabindex="1" size="77" value="' + data[i].nomenclature + '[' + data[i].PVMSno + ']" ';
		currentMedication += 'id="nomenclatureCurrent' + countNo + '"  name="nomenclatureCurrent"';
		currentMedication += 'class="form-control border-input width200"';
		currentMedication += '" />';
		currentMedication += '<input type="hidden"  name="itemId" value="' + data[i].itemId + '" id="nomenclatureId'
				+ data[i].itemId + '"/>';
		currentMedication += '<input type="hidden"  name="prescriptionHdIdCurrent" value="' + data[i].precryptionHdId
				+ '" id="prescriptionHdIdCurrent' + data[i].precryptionHdId + '"/>';
		currentMedication += '<input type="hidden"  name="prescriptionDtIdCurrent" value="'
				+ data[i].precriptionDtId + '" id="precriptionDtIdCurrent' + data[i].precriptionDtId + '"/>';
		currentMedication += '</div>';
		currentMedication += '</td>';

	 
		currentMedication += '<td style="display:none"><input  type="text" value="'
			+ data[i].dispStock + '" name="dispensingUnitCurrent" ';
		currentMedication += ' id="dispensingUnitCurrent'+countNo+'" size="6"';
		currentMedication += 'validate="AU,string,no"   class="form-control"/>';
		currentMedication += '</td>';
		

		currentMedication += '<td><input type="text" class="form-control" size="5" name="dosageCurrent" tabindex="1"';
		currentMedication += 'value=' + data[i].dosage + ' id="dosageCurrent'+countNo+'"  maxlength="5" />';
		currentMedication += '</td>';
		var selectFre = "";
		var diasableValue='disabled';
		currentMedication += '<td><select name="frequencyTreCurrent" '+diasableValue+' class="form-control width100" id="frequencyTreCurrent'+ countNo + '"';
		currentMedication += 'class="medium">';

		var frequencyIdValue = data[i].frequencyId;
		currentMedication += '<option value=""><strong>Select</strong></option>';

		
		$.each(frequencyList, function(ij, item) {

			if (frequencyIdValue == item.frequencyId) {
				selectFre = "selected";
			} else {
				selectFre = "";
			}
			currentMedication += '<option '+ selectFre +'  value="' + item.feq + '@'+ item.frequencyId + '">'
					+ item.frequencyName + '</option>';
		});
		currentMedication += '</select>';
		currentMedication += '</td>';

		currentMedication += '	<td><input type="text" class="form-control width50" value="'+ data[i].noOfDays + '" name="noOfDaysCurrent" tabindex="1"';
		currentMedication += '	id="noOfDaysCurrent'+countNo+'" onblur="fillValueNomenclature(' + count + ')" size="5"';
		currentMedication += '	maxlength="3" /></td>';
		var totalValue="";	
		if(data[i].total!=null){
			totalValue=data[i].total;
			}
		currentMedication += '<td><input type="text" class="form-control width50" value="' +totalValue+ '" name="totalCurrent" tabindex="1"';
		currentMedication += 'id="totalCurrent'+countNo+'" size="5"  ';
		currentMedication += 'onblur="treatmentTotalAlert(this.value,1)" /></td>';


		currentMedication += '<td><input type="text" class="form-control width50" name="closingStockCurrent" tabindex="1"  value="' + data[i].availableStock + '"';
		currentMedication += 'id="closingStockCurrent'+countNo+'" size="3"';
		currentMedication += 'validate="closingStock,string,no" /></td>';
		
		
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
		}
		else{
			diasableOfStop=""
			itemStopbByDoctor=""+data[i].precribedByDoc;	
			stopDate="";
			//precribeByDoc="PrescribeBy"+data[i].
			precribedDate=""+data[i].precriptionDate;
			checkedForStop="";
		}
		//currentMedication += '<td><input '+diasableOfStop+'   type="text" col="4" rows="4" class="form-control width150" value="'+itemStopbByDoctor+"/"+data[i].departmentName+'" tabindex="1"';
		//currentMedication += 'id="prescribeBy" size="77" name="prescribeBy" /></td>';

		currentMedication += '<td><textarea name="prescribeBy" id="prescribeBy" class="form-control width150" cols="0" rows="0"';
		currentMedication += '	maxlength="300" value="" tabindex="1"';
		currentMedication += 'onkeyup="return ismaxlength(this)">'+data[i].departmentName+"/ "+itemStopbByDoctor+' </textarea>';
		
		
		currentMedication += '<td style="display:none"><input  type="text" value="" tabindex="1"';
		currentMedication += '	id="departmentCurrent'+countNo+'" class="form-control width150" size="77" name="departmentCurrent" /></td>';
		 
		
		currentMedication += '<td><input '+diasableOfStop+' type="text" value="'+stopDate+precribedDate+'" tabindex="1"';
		currentMedication += '	id="prescribeDate'+countNo+'" size="77" name="prescribeDate" class="form-control width150" /></td>';
	
		
		/*currentMedication += '<td><div class="form-check form-check-inline cusCheck"><input class="form-check-input" type="checkBox" '+diasableOfStop+' '+checkedForStop+' name="stopCheck" id="stopCheck'+countNo+'"';
		currentMedication += ' value=""  ';
		currentMedication += '	tabindex="1" ><span class="cus-checkbtn"></span> </div></td>';

		currentMedication += '<td><div class="form-check form-check-inline cusCheck"><input class="form-check-input" type="checkBox" '+diasableOfStop+' name="repeatCheck" id="repeatCheck'+countNo+'" value="1"';
		currentMedication += 'tabindex="1"><span class="cus-checkbtn"></span> </div></td>';*/

		currentMedication += '<td style="display:none"><input type="text" class="form-control" tabindex="1" value="'
			+ data[i].instruction + '" name="remarks1" ';
		currentMedication += 'id="remarks1" size="10" maxlength="15" />';
		currentMedication += '</td>';
		
		currentMedication += '<input type="hidden" name="pvmsNo1" tabindex="1"';
		currentMedication += '	id="pvmsNo1" size="10" readonly="readonly" />';

		currentMedication += '</tr>';
		countNo++;
	}
	$('#countValueCurrentMedi').val(countNo);
	currentMedication += '</div">';
	$("#currentMedicationGrid").html(currentMedication);
	$("#modelForCurrentMedication").show();
	$('.modal-backdrop').show();
//}
//});

}
function closeCurrentMedication(){
$('#modelForCurrentMedication').hide();
$('.modal-backdrop').hide();
document.getElementById("additionalNote").focus();
$('#treatLoaderCurrent').hide();
}
//var count = 1;
function submitCurrentMedication()
{
	var tbl = document.getElementById('nomenclatureGrid');
	lastRow = tbl.rows.length;
	var k = lastRow;
	var treatementCurrent="";
	investigationGridValue = "nomenclatureGrid";
	var valeStop="";
	 var precriptionDtValueArray = [];
	 var countForCloseModel=0;
	 
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
						$("#nomenclatureGrid tr").remove();
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
				  stock = $tds.eq(7).find(":input").val();
				  precribeBy = $tds.eq(8).find(":input").val();
				  department = $tds.eq(9).find(":input").val();
				  precribeDate = $tds.eq(10).find(":input").val();
				  remarks = $tds.eq(13).find(":input").val();
				  itemClassId = $tds.eq(14).find(":input").val();
				  
				  func1='populatePVMS';
		 		   url1='opd';
		 		   url2='getMasStoreItemList';
		 		   flaga='numenclature';
				treatementCurrent += '<tr>';
				treatementCurrent += '<td>';
				treatementCurrent += '<div class="autocomplete forTableResp">';
				treatementCurrent += '<input type="text" autocomplete="off"  tabindex="1" size="77" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"  value="'+itemIdName+'"';
				treatementCurrent += 'id="nomenclature' + k + '"  name="nomenclature1"';
				treatementCurrent += 'class="form-control border-input"';
				treatementCurrent += '" />';
				treatementCurrent += '<input type="hidden"  name="itemId" value="' + itemId + '" id="nomenclatureId'
						+ k + '"/>';
				treatementCurrent += '<input type="hidden"  name="prescriptionHdId" value="'+prescriptionHdIdCurrent+'" id="prescriptionHdId'
						+ k + '"/>';
				treatementCurrent += '<input type="hidden"  name="prescriptionDtId" value="'+prescriptionDTIdCurrent+'" id="precriptionDtId'
						+ k + '"/>';
				treatementCurrent += '<div id="treatmentOpd'+k+'" class="autocomplete-itemsNew"></div>';
				treatementCurrent += '</div>';
                                  
				treatementCurrent += '</td>';

				treatementCurrent += '<td ><select name="dispensingUnit1" class="form-control" id="dispensingUnit1'+ k + '" ';
				treatementCurrent += 'class="medium">';
				var dispStock = dispUnit;
				treatementCurrent += '<option value=""><strong>Select</strong></option>';

				var selectFre = "";
				$.each(masDispUnitList, function(ijk, item1) {

					if (dispUnit == item1.storeUnitName) {
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

				treatementCurrent += '<td><input type="text" onkeypress="return checkValidate(event);" class="form-control" size="5" name="dosage1" tabindex="1"';
				treatementCurrent += 'value=' + dosage
						+ ' id="dosage1'+k+'"  maxlength="5" />';
				treatementCurrent += '</td>';

				treatementCurrent += '<td><select name="frequencyTre" class="form-control" id="frequencyTre' 
						+ i + '" onchange="fillValueNomenclature()"';
				treatementCurrent += 'class="medium">';

				var frequencyIdValue =frequencyId;
				treatementCurrent += '<option value=""><strong>Select</strong></option>';

				var selectFre = "";
				$.each(frequencyList, function(ij, item) {
					 
					if (frequencyIdValue == item.frequencyId) {
						selectFre = "selected";
					} else {
						selectFre = "";
					}
					treatementCurrent += '<option ' + selectFre
							+ ' value="' + item.feq + '@'+ item.frequencyId +'">'
							+ item.frequencyName + '</option>';
				});
				treatementCurrent += '</select>';
				treatementCurrent += '</td>';

				treatementCurrent += '<td><input type="text" onkeypress="return checkValidate(event);" class="form-control" value="'
						+ noOfDays
						+ '" name="noOfDays1" tabindex="1"';
				treatementCurrent += '	id="noOfDays1'+k+'" onblur="fillValueNomenclature('
						+ '1' + ')" size="5"';
				treatementCurrent += '	maxlength="3" validate="No of Days,num,no" /></td>';

				treatementCurrent += '<td><input type="text" onkeypress="return checkValidate(event);" class="form-control" value="' + total + '" name="total1" tabindex="1"';
				treatementCurrent += 'id="total1'+k+'" size="5" validate="total,num,no"';
				treatementCurrent += 'onblur="treatmentTotalAlert(this.value,1)" /></td>';

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
				treatementCurrent += '	<td><input type="text" class="form-control" name="closingStock1" tabindex="1"  value="'+ stock + '"';
				treatementCurrent += 'id="closingStock1" size="3"';
				treatementCurrent += 'validate="closingStock,string,no" readonly/></td>';
				
				
				treatementCurrent += '<td style="display:none"><input  type="hidden" value="' + itemId + '" tabindex="1"';
				treatementCurrent += '	id="itemIdNom'+k+'" size="77" name="itemIdNom" /></td>';

				treatementCurrent += '<td><button name="Button" type="button"';
				treatementCurrent += '	class="buttonAdd btn btn-primary noMinWidth" value="" button-type="add" onclick="addNomenclatureRow();"';
				treatementCurrent += '	tabindex="1" > </button></td>';

				treatementCurrent += '<td><button type="button" name="delete" id="treatementId" value=""';
				treatementCurrent += 'class="buttonDel btn btn-danger noMinWidth" button-type="delete"';
				treatementCurrent += '	onclick="removeTreatmentRow(this,\''
						+ investigationGridValue
						+ '\','
						+ prescriptionDTIdCurrent + ');"';
				treatementCurrent += '	tabindex="1"> </button></td>';
				treatementCurrent += '<td style="display: none;"><input type="hidden" ';
				treatementCurrent += '	name="pvmsNo1" tabindex="1" id="pvmsNo1" size="10"';
				treatementCurrent += '	readonly="readonly" /></td>';
				treatementCurrent += '<td style="display: none;"><input type="hidden"';
				treatementCurrent += '	name="itemClassId" tabindex="1" id="itemClassId" value="'+itemClassId+'" size="10"';
				treatementCurrent += '	readonly="readonly" /></td>	';
				
				treatementCurrent += '</tr>';
				k++;
				}
				if(document.getElementById(stopId).checked != true){
					$("#nomenclatureGrid").append(treatementCurrent);
					countForCloseModel+=1;
				}
				}
				
				if (document.getElementById(stopId).checked == true) {
					
					precriptionDtValueArray.push(prescriptionDTIdCurrent);
				}
				
				
				
		});
	if(precriptionDtValueArray!="" && precriptionDtValueArray!=null && precriptionDtValueArray.length>0){
	
		
	}
	alert(""+resourceJSON.msgForUpdateCurrentMedi+'S');
	closeCurrentMedication();
	 if(countForCloseModel!=0){
		 closeCurrentMedication();
	 }
	 document.getElementById("additionalNote").focus();
}

function showAllCurrentMedication(mode,className)
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

/*function onMouseClickSymptoms(){
	  $("#patientSymptons").mouseover(function(){
		  var globalArray1 =null;
		  var icdArrayValuNew=[];
		  var pathname = window.location.pathname;
			var accessGroup = "MMUWeb";
			var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/treatmentAudit/getAllSymptomsForOpd";
			$
					.ajax({
						url : url,
						dataType : "json",
						data : JSON.stringify({
							'name' : 'fever'
						}),
						contentType : "application/json",
						type : "POST",
						success : function(response) {
							console.log(response);
							 globalArray1 = response.list;
							signAndSymptomsGlobalArray = response.list;
							 for (var i = 0; i < globalArray1.length; i++) {
            				     icdArrayValuNew[i] = globalArray1[i].name;
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
	  });
	  $("#patientSymptons").mouseout(function(){
	    $("#patientSymptons").css("background-color", "lightgray");
	  });
}*/
