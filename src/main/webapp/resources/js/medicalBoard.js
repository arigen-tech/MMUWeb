/**
 * 
 */

function getPatientDetailToValidate() {
	var visitId = $('#visitId').val();
	var age = $('#ageForPatient').val();
	var data = {
		"visitId" : visitId,
		"flagForForm" :"f1",
		"age":age
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
				$('#age').val(data[0].age);

				$('#rank').val(data[0].rankName);
				$('#meType').val(data[0].meTypeName);
				$('#gender').val(data[0].gender);
				$('#patientId').val(data[0].patientId);
				$('#departmentId').val(data[0].departmentId);
			}
			
			 var countins = 1;
			 var countSno=1;
				if (masDesigationList != null && masDesigationList.length > 0) {
					var investigationData="";
					var diasableValue="disabled";
					for (var i = 0; i < masDesigationList.length; i++) {
						investigationData += '<tr>';
						investigationData +='<td style="width: 150px;">'+countSno+'</td>';
						investigationData += '<td><div class="form-group autocomplete">';
						investigationData += '<input type="text" autocomplete="off" value="'+masDesigationList[i].investigationName + '[' + masDesigationList[i].investigationId + ']"';
						 investigationData += ' class="form-control border-input" name="investigationName" id="investigationName'+countSno+'" onKeyPrss="autoCompleteCommonMe(this,1);" onKeyUp="autoCompleteCommonMe(this,1);" onblur="populateChargeCode(this.value,'
								+ countins
								+ ');putInvestigationValue(this)"/>';
						investigationData += '<input type="hidden"  name="investigationIdValue" value="'
								+ masDesigationList[i].investigationId +'"  id="investigationIdValue' + masDesigationList[i].investigationId + '"/>';
						
						investigationData += '<input type="hidden"  name="examTypeId" value="'
							+ masDesigationList[i].examTypeId +'"  id="examTypeId' + masDesigationList[i].examTypeId + '"/>';
				
						investigationData += '<input type="hidden"  name="appointmentId" value="'
							+ masDesigationList[i].examTypeId +'"  id="appointmentId' + masDesigationList[i].appointmentId + '"/>';
				
					
						investigationData += '</div></td>';
						var chechedValue="checked";
						investigationData +='<td>';
						investigationData +='<div class="form-check">';
						investigationData +=' <input checked=checked class="form-check-input position-static" type="checkbox"  name="checkBoxForValidate" id="checkBoxForValidate'+i+'">';
						investigationData +='</div>';
						investigationData +='</td>';
						
						investigationData += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth" button-type="add" value="" ';
						investigationData += 'onclick="addNewRowForInvestigation();"';
						investigationData += '	tabindex="1" ></button></td>';
 					
						
						
						investigationData +='<td>';
						investigationData +='<button type="button" '+diasableValue+' name="delete" value="" id="deleteInves'+i+'"  class="buttonDel btn btn-danger noMinWidth" button-type="delete"onclick="removeRowInvestigation(this);"></button>';
						 
						investigationData +='</td>';
						
						investigationData +='</tr>';
						countSno+=1;
					}}
				$("#dgInvetigationGrid").html(investigationData);
		}
	});

	return false;
}
var valiCheckValue = [];

function checkValidate() {
	$('#dgInvetigationGrid tr').each(function(i, el) {

		var id = $(this).find("td:eq(2)").find("input:eq(0)").attr("id")
		if (document.getElementById(id).checked == true) {
			var validateCheck = 'O';
			labMarkValue = validateCheck;
		} else {
			validateCheck = 'I';
			labMarkValue = validateCheck;
		}
		valiCheckValue.push(labMarkValue);
	});
	
	$('#valiCheckValue').val(valiCheckValue);
}

function submitFormByMO(checkForform) {
	var submitForm='0';
	 
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
				$("#submitMedicalExamByMo").submit();
				return true;
		}
		}

function removeRowInvestigation(val){
	if($('#referalGrid tr').length > 1) {
	$(val).closest('tr').remove();
	 }
}


function getPatientDetailToValidateMA() {
	var visitId = $('#visitId').val();
	var age = $('#ageForPatient').val();
	var data = {
			"visitId" : visitId,
			"flagForForm" :"f2",
			"age":age
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
				 if (data != undefined && data != null) {
						$('#serviceNo').val(data[0].serviceNo);
						$('#employeeName').val(data[0].patientName);
						$('#age').val(data[0].age+"/"+data[0].gender);

						$('#rank').val(data[0].rankName);
						$('#meType').val(data[0].meTypeName);
						$('#gender').val(data[0].gender);
						$('#patientId').val(data[0].patientId);
						$('#departmentId').val(data[0].departmentId);
						$('#dob').val(data[0].dateOfBirth);
						
					}
					
			}
		});
}


function countMissingAndUnsavableValue(){
	var countMissing=0;
	var countunSavable=0;
	for(var i=1;i<=8;i++){
		if (document.getElementById('urMChecked'+i).checked == true){
			countMissing+=1;
		}
		if (document.getElementById('ulMChecked'+i).checked == true){
			countMissing+=1;
		}
		if (document.getElementById('llMChecked'+i).checked == true){
			countMissing+=1;
		}
		if (document.getElementById('lrMChecked'+i).checked == true){
			countMissing+=1;
		}
		
		if (document.getElementById('unurChecked'+i).checked == true){
			countunSavable+=1;
		}
		if (document.getElementById('unulChecked'+i).checked == true){
			countunSavable+=1;
		}
		if (document.getElementById('unllChecked'+i).checked == true){
			countunSavable+=1;
		}
		if (document.getElementById('unlrChecked'+i).checked == true){
			countunSavable+=1;
		}
	}
	
	

	if(countMissing!=0 && countunSavable!=0){
		alert(""+resourceJSON.msgForMissingAndUnsavable);
		return false
		}
	$('#missing').val(countMissing);
	$('#unSavable').val(countunSavable);
	return true;
}

function submitMAForm(flagForSubmit) {
		$('#saveInDraft').val(flagForSubmit);
		$("#submitMedicalBoardByMo").submit();
		return true;
 }

function getAFMSF3BForMOOrMA() {
	var visitId = $('#visitId').val();
	var age = $('#ageForPatient').val();
	var data = {
			"visitId" : visitId,
			"flagForForm" :"f3",
			"age":age
		};
		$.ajax({

			type : "POST",
			contentType : "application/json",
			url : 'getAFMSF3BForMOOrMA',

			data : JSON.stringify(data),
			dataType : "json",
			// cache: false,

			success : function(res) {
				 data = res.listOfResponse;
				 if (data != undefined && data != null) {
						$('#totalNoOfTeath').val(data[0].totalNoOfTeath);
						$('#totalNoOfDefective').val(data[0].totalNoOfDefective);
						$('#totalNoOfDentalPoints').val(data[0].age+"/"+data[0].gender);

						$('#missing').val(data[0].missing);
						$('#unSavable').val(data[0].unSavable);
						$('#conditionOfGums').val(data[0].conditionOfGums);
						//$('#patientId').val(data[0].patientId);
						//$('#departmentId').val(data[0].departmentId);
						//$('#dob').val(data[0].dateOfBirth);
						
						
					}
					
			}
		});
}



/*var arryInvestigation = new Array();
function getMasInvestigation()
{
	var labRadioValue=resourceJSON.mainchargeCodeLab;
	var radioValue = labRadioValue; 
	invesRadio=radioValue;
var pathname = window.location.pathname;
var accessGroup = "MMUWeb";

var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getIinvestigationList";

//var data = $('employeeId').val();
// alert("radioValue" +radioValue);
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
	var data = res.InvestigationList;
	
	for(var i=0;i<data.length;i++){
		var investigationId= data[i].investigationId;
		var investigationName = data[i].investigationName;
		//var icdName = data[i].icdName;
		var a=investigationName+"["+investigationId +"]"
		//alert("a "+a);
		 arryInvestigation.push(a);
		//console.log('data :',a);
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
var arryInvestigation = new Array();
var arrayData = [];
var i = "";
var invesRadio="";
var investigationForUom="";
function changeRadio(radioValue){
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
				if(investigationNewUpdate[3]!=null)
				var uomName = investigationNewUpdate[3];
				
				var aaaa=investigationName+"["+investigationId +"]"
				
				arryInvestigation.push(aaaa); 
				     			      
			   //   var inChangeValFirst=$('#dgInvetigationGrid').children('tr:last').children('td:eq(0)').find(':input')[0]
			     // var inChangeValLast=$('#dgInvetigationGrid').children('tr:last').children('td:eq(0)').find(':input')[0]
			    //   autocomplete(inChangeValFirst, arrayData);
			      //autocomplete(inChangeValLast, arrayData);
			 
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


/*var arry = new Array();
var icdArry = new Array();
function masIcdList() {
	
    var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";

    var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/getIcdList";

    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: url,
        data: JSON.stringify({
            'employeeId': '1'
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
*/
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
        timeout: 100000,

        success: function(res)

        {
            mcData = res.masMedicalCategoryList;
        	autoMedicalCategoryData=res.masMedicalCategoryList;
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


function submitMOForm(flagForSubmit) {
	$('#saveInDraft').val(flagForSubmit);
	var count=0;
	if(getValidateForAction()){
		
		if(flagForSubmit!="" && flagForSubmit=='draftMo'){
			var resultCountValue=validateForm();
			var selectObj = document.getElementById("actionMe");
			if(resultCountValue>0){
				if(selectObj!=null && selectObj!=""){
			        if (selectObj.options[selectObj.selectedIndex].value!='pending') {
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
	        }
		}
		if(count==0){
			$("#submitMedicalExamByMo").submit();
		}
			
	}
	return true;
}

var refferalDdata='';
var masEmpanelledList='';
function getRefferalDetails() {
    var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";

    var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/getPatientReferalDetail";
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: url,
        data: JSON.stringify({
            'opdPatientDetailId':opdPatientDetailsId,
            'visitId':visitId,
            'patientId':patientId
        }),
        dataType: 'json',
        timeout: 100000,

        success: function(res)

        {
        	$("#referalGrid tr").remove(); 
        	   refferalDdata = res.listReferralPatientDt;
        	   masEmpanelledList=res.masEmpanelledHospitalList;
        	  $.each(refferalDdata, function(i, item) {
                var diagonisId = refferalDdata[i].diagonisId;
                var referalNotes = refferalDdata[i].referalNotes;
                var referalDate = refferalDdata[i].referalDate;
                var referalPatientDt = refferalDdata[i].referalPatientDt;
                var massDeptName = refferalDdata[i].massDeptName;
                var instruction = refferalDdata[i].instruction;
                var daiganosisName = refferalDdata[i].daiganosisName;
                var masEmpanalId = refferalDdata[i].masEmpanalId;
                var referalPatientHd = refferalDdata[i].referalPatientHd;
                var masEmpanalName = refferalDdata[i].masEmpanalName;
                var masCode = refferalDdata[i].masCode;
                var exDepartmentValue = refferalDdata[i].exDepartmentValue;
                var referalNotes=refferalDdata[i].referalNotes;
                var referrDtData = '';
				var i=0;
				var trHTML='';
				var selectFre="";
				    trHTML += '<tr>';	
					trHTML +='<td><select name="hospitalName" id="hospitalName'+i+'" class="medium form-control"';
					trHTML +='class="medium" disabled="true">';
					trHTML +='<option value=""><strong>Select...</strong></option>';
					$.each(masEmpanelledList, function(ij, item) {	
					    
																
						if(masEmpanalId == item.empanelledHospitalId){
							selectFre="selected";
						}
						else{
							selectFre="";
						}
					trHTML += '<option ' + selectFre + ' value="' + item.empanelledHospitalId
						+ '@'
						+ item.empanelledHospitalCode
						+ '" >'
						+ item.empanelledHospitalName
						+ '</option>';
					});
					trHTML +='</select>';
					trHTML +='</td>';
					trHTML +='<td><input type="text" id="specialityName" value="'+exDepartmentValue+'" class="form-control" readonly></td>';
					trHTML +='<td><textarea class="form-control" id="diagnosisId" onblur="fillDiagnosisCombo(this.value,this);" placeholder="Diagnosis" rows="2" readonly>'+daiganosisName+'</textarea></td>';
					/*trHTML +='<td><input type="text" class="form-control" id="diagnosisId" value="'+daiganosisName+'" onblur="fillDiagnosisCombo(this.value,this);" placeholder="Diagnosis" /></td>';*/
					trHTML +='<td style="display: none";><input type="hidden" id="diagnosisIdValue" value="" class="form-control"/></td>';
					trHTML +='<td><input type="text" id="instructionName" value="'+instruction+'" class="form-control" readonly></td>';
					trHTML +='<td><textarea name="specialistOpinion" id="specialistOpinion'+diagonisId+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;"></textarea>';
					trHTML +=' <a class="btn-link" href="javascript:void(0)"  onclick="openResultModelSpecialist(this);">View/Enter Result</a>';
					trHTML +='</td>';
					//trHTML +='<td><textarea class="form-control" rows="2"></textarea></td>';
					trHTML +='<td style="display: none";><input type="hidden" id="referralDetailIdValue" value="'+referalPatientDt+'" class="form-control" readonly/></td>';
					trHTML +='<td><div class="fileUploadDiv"><input type="file" name="referalFileUpload" id="referalFileUpload" class="inputUpload" /><label class="inputUploadlabel">Choose File</label><span class="inputUploadFileName">No File Chosen</span></div></td>';
					/*trHTML +='<td><button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addRowForFinalObservation();"></button></td>';
					trHTML +='<td><button type="button" name="delete" value="" class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" onclick="removeRowInvestigation(this)"></button></td>';*/
					trHTML +='</tr>';
					i++;
					 $('#referalGrid').append(trHTML);
					 document.getElementById('refferalRemarks').value=referalNotes;            
        	  });
        	  
        	 
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


function getMasDesignationMappingByUnitId(){
	 

	/* var approvalFlag=$('#approvalFlag').val();
	 var approvalFlagDiasable="";
	 if(approvalFlag!="" && approvalFlag!=undefined && approvalFlag!=null && approvalFlag=='y'){
		 approvalFlagDiasable='disabled';
	 }
	 else{
		 approvalFlagDiasable="";
	 }*/
	 var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/medicalexam/getMasDesignationMappingByUnitId";
	 var forwardedUnitId=$( "#forwardTo option:selected" ).val();
	 
	 if(forwardedUnitId=='0'){
		 return false;
	 }
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
				if(dataDesignationObjList!=null && dataDesignationObjList!=undefined && dataDesignationObjList.length!=0)
				for(var i=0;i<dataDesignationObjList.length;i++){
					
					var desinationIdArray=dataDesignationObjList[i].designationId.split(",");
					var desinationNameArray=dataDesignationObjList[i].designamtionName.split(",")
					//user for remove designation
					masDesignationSelectedValue+='<select class="form-control" name=designationForMe id="designationForMe">';
					masDesignationSelectedValue+='<option value="0">Select</option>';
					for(var j=0;j<desinationIdArray.length;j++){
							masDesignationSelectedValue +='<option value="' 
									+  desinationIdArray[j] + '" >' +  desinationNameArray[j]
								+ '</option>'; 
					}
				}
			if(dataDesignationObjList.length!=0){
				$('#designationForMeIdMB').html(masDesignationSelectedValue);
				$('#designationMeId').show();
			}
			else{
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


var unitDetailData='';
var unitGloblaData='';
function getUnitDetail(){
 
 /*var approvalFlag=$('#approvalFlag').val();
 var approvalFlagDiasable="";
 if(approvalFlag!="" && approvalFlag!=undefined && approvalFlag!=null && approvalFlag=='y'){
	 approvalFlagDiasable='disabled';
 }
 else{
	 approvalFlagDiasable="";
 }*/
 var  hospitalId=$('#hospitalId').val();
 var visitId=$('#visitId').val();
 
 var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/medicalexam/getUnitDetail";
 
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
 
	unitDetailData += '<select name="forwardTo" class="form-control" id="forwardTo" class="medium" onChange="return getMasDesignationMappingByUnitId();">';
unitDetailData += '<option value="0"><strong>Select</strong></option>';
if (data != undefined && data.length != 0) {
		for (var i = 0; i < data.length; i++) {	
unitDetailData += '<option   value="' + data[i].hospitalId + '">'
			+ data[i].hospitalName + '</option>';
		}
}
unitDetailData += '</select>';
 $('#forwardMbTo').html(unitDetailData);
		}
 });
 
 function changeAction(val){
	 alert("pending")
	 var saveInDraft=$('#saveInDraft').val();
	 //	if(saveInDraft=='draftMo'){
		var selectObj = document.getElementById("actionMe");
		if(selectObj!=null && selectObj!=""){
	    for (var i = 0; i < selectObj.options.length; i++) {
	    	
	       /* if (selectObj.options[selectObj.selectedIndex].value=='approveAndClose') {
	        	$('#approvedMedicalExam').show();
	        	$('#referredMe').hide();
	        	$('#rejectMedicalExam').hide();
	        	$('#pendingMedicalExam').hide();
	        	$('#forwardStatus').hide();
	        	$('#remarksForApproval').val("");
	        	$('#designationMeId').hide();
	        }*/
	        
	        if (selectObj.options[selectObj.selectedIndex].value=='pending') {
	        	$('#reasonPending').show();  
	        	
	        	/*$('#approvedMedicalExam').hide();
	        	$('#referredMe').hide();
	        	$('#rejectMedicalExam').hide();
	        	$('#forwardStatus').hide();
	        	$('#designationMeId').hide();*/
	        }
	       /* if (selectObj.options[selectObj.selectedIndex].value=='approveAndForward') {
	        	$('#approvedMedicalExam').show();
	        	$('#referredMe').hide();
	        	$('#rejectMedicalExam').hide();
	        	$('#pendingMedicalExam').hide();
	        	$('#forwardStatus').show(); 
	        	
	        }*/
	        
	         
	    }
	}
		
 }
 
}


function getAFMSFInvestigationForDigiFileUploadMb_old() {
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
					data = res.listObject;
					 
					var count = 1;
					var countins = 1;
					var investigationfinalValue = "";
					var diasableValue="disabled";
					var diasableValueCheck=" ";
					var checkedVal="";
					if (data != null && data.length > 0) {
						$('#totalLengthDigiFile').val(data.length);
						for (var i = 0; i < data.length; i++) {
							investigationData += '<tr>';
							if(data[i].ridcId!=null)
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
							investigationData += '<input class="form-check-input position-static"   type="checkbox" '+checkedVal+' '+diasableValueCheck+' name="checkBoxForUpload" id="checkBoxForUpload'+count+'" onClick="return getInvestionCheckData(this);">  <span class="cus-checkbtn"></span>';
							investigationData += '</div> ';
							investigationData += ' </td> ';

							
							investigationData += '<td><div   class="autocomplete">';
							investigationData += '<input type="text"  readonly value="'
									+ data[i].investigationName + '['
									+ data[i].investigationId
									+ ']" id="chargeCodeName' + count + '"';
							investigationData += ' class="form-control border-input" '+disableFlag+' name="chargeCodeName" autocomplete="off" onKeyPress="autoCompleteCommonMe(this,1);" onblur="populateChargeCode(this.value,'+ countins +',this);" />';
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
							investigationData += ' </div></td>';
							
							
							investigationData += '	<td>';
							investigationData += '	<input type="text" name="UOM" '+disableFlag+' id="UOM'+count+'" value="'+data[i].uomName+'" class="form-control"  readonly>';
							investigationData += '	</td>';

							investigationData += '	<td>';
							investigationData += '	<input type="text" name="resultInvs" '+disableFlag+' id="resultInvs'+count+'" value="'+data[i].result+'" class="form-control" >';
							investigationData += '	</td>';

							investigationData += '	<td>';
							investigationData += '	<input type="text" '+disableFlag+' name="range" id="range'+count+'" value="'+data[i].rangeVal+'" class="form-control" >';
							investigationData += '	</td>';

							//investigationData += "<td><button id ='printBtn' type='button'  class='btn btn-primary' onclick='viewDocumentForDigi("+data[i].ridcId+");'>View Document</button></td>";
							if(data[i].ridcId!=null)	
							investigationData += '	<td><a class="btn-link" href="#" onclick="viewDocumentForDigi('+data[i].ridcId+');" >View Document</a></td>'
							else{
								investigationData += '	<td></td>';
							}
							investigationData += '<td><button name="Button" type="button"  class="buttonAdd btn btn-primary noMinWidth"  button-type="add" value="" '+disableFlag+'';
							investigationData += 'onclick="addRowForInvestigationFunUp();"  ';
							investigationData += '	tabindex="1" > </button></td>';

							investigationData += '<td><button type="button" name="delete" value="" '+disableFlag+'  button-type="delete" id="deleteInves"';
							investigationData += 'class="buttonDel btn btn-danger noMinWidth"';
							investigationData += 'onclick="removeRowInvestigationMe(this,\''
									+ investigationGridValue
									+ '\','
									+ data[i].dgOrderDtId + ');"';
							investigationData += '	tabindex="1" ></button></td>';
							investigationData += ' </tr> ';
							count++;
						}
						$("#dgInvetigationGrid").html(investigationData);
					}
				}
			});

	return false;
}

function removeRowInvestigationMe(val, investigationGrid, investigationData) {
	var tbl = document.getElementById('dgInvetigationGrid');
	var lastRow = tbl.rows.length;
	
	var msg=resourceJSON.msgDelete;
	
	if (confirm(msg)) {
		if (investigationGrid == "investigationGrid" && lastRow == '1') {
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
	}
}

function addRowForReferalForDigiFileUploadMB(){
	 var sNO=0;
		var tbl = document.getElementById('medicalReferal');
		var lastRow = tbl.rows.length;
		k = lastRow+1;
		sNO=lastRow;
		k++;
		sNO++;
		var aClone = $('#medicalReferal>tr:last').clone(true)
		aClone.find("td:eq(0)").html(sNO);
		aClone.find('select').prop('id', 'medicalExamReferalHos' + k + '');
		aClone.find("td:eq(2)").find("input:eq(0)").prop('id','departmentValue' + k + '');
		aClone.find("td:eq(2)").find("input:eq(1)").prop('id','diagonsisId' + k + '');
		aClone.find("td:eq(2)").find("input:eq(2)").prop('id','masEmpanalHospitalId' + k + '');
		aClone.find("td:eq(2)").find("input:eq(3)").prop('id','masDepatId' + k + '');
		aClone.find("td:eq(2)").find("input:eq(4)").prop('id','referalPatientDt' + k + '');
		aClone.find("td:eq(2)").find("input:eq(5)").prop('id','referalPatientHd' + k + '');
		
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
		$('#medicalReferal>tr:last').find("td:eq(7)").find("button:eq(0)").attr("id", "newInvestigationId");
}

function removeRowInvestigationReferalMB(val){
	 var tbl = document.getElementById('medicalReferal');
	   	lastRow = tbl.rows.length;
	if(lastRow>1){
		$(val).closest('tr').remove();
	}
	}

function autoCompleteCommonMe(val,flag){
	if(flag=='1')
	oldautocomplete(val, arryInvestigation);
	if(flag=='6'){
		oldautocomplete(val, MeidcalCategoryArry);
	}
	if(flag=='7'){
		oldautocomplete(val, arryNomenclature);
	}
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


function getPatientReferalDetailForDigiFileUploadMb() {
 	var saveInDraft=$('#saveInDraft').val();
 	var disableFlag="";
 	if(saveInDraft=='ea'|| saveInDraft=='ej'){
 		disableFlag='disabled';
 	}
 	else{
 		disableFlag="";
 	}
 	
 	var opdPatientDetailId = $('#opdPatientDetailsId').val();
 	var patientId = $('#patientId1').val();
 	var visitId = $('#visitId1').val();
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
 				
 					var masDepartment=res.departmentList;
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
 					func1='fillDiagnosisCombo';
		    		   url1='opd';
		    		   url2='getIcdListByName';
		    		   flaga='diagnosisMe';
 					
 					if (data != undefined && data.length != 0) {
 						
 						for (var i = 0; i < data.length; i++) {
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
 								referrDtData += '		<input type="file" name="referalFileUpload" id="referalFileUpload" class="inputUpload" />';
 								referrDtData += '		<label class="inputUploadlabel">Choose File</label>';
 								referrDtData += '		<span class="inputUploadFileName">No File Chosen</span>';
 								referrDtData += '	</div>';
 								referrDtData += '	</td>';
 							}
 							//referrDtData += '<td><a class="btn-link" href="#" '+disableFlag+'>View Document</a></td>';

 							referrDtData += '<td><button type="Button" name="add" class="buttonAdd btn btn-primary noMinWidth" id="referalMedicalDtIdAdd" button-type="add" value="" tabindex="1" onclick="addRowForReferalForDigiFileUploadMB();"> </button></td>';
 							referrDtData += '<td><button type="button" name="delete" value=""    id="referalDtMedicalIdDel"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" '+deleteButtonFlag+' tabindex="1" onclick="deleteInvestAndReferalValueRow(this,11,\''
 									+ ridcIdVal + '\');" ></button></td>';
 							referrDtData += '</tr>';
 							count++;
 						}
 						$('#totalLengthDigiFileRefer').val(totalLengthDigiFileReferVal);
 						$("#medicalReferal").html(referrDtData);
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

function getReferalOneGrid(masEmpanaledList,masSpecialistList){
	    var count=1;
		var func1='fillDiagnosisCombo';
		var url1='opd';
		var url2='getIcdListByName';
		var flaga='diagnosisMe';
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
		+ count + '" name="departmentValue"';
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
		referrDtData +=' <input name="icddiagnosis" id="icddiagnosis" '+count+' type="text"';
		referrDtData +='class="form-control border-input"';
		referrDtData +='placeholder=" " value=""  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" />';
		referrDtData +='<div class="autocomplete-itemsNew" id="icdDiagnosisUpdatea" ></div>';
		referrDtData += '</div></td>';
		
       /*   referrDtData += '<td><div class="autocomplete">';
		
		referrDtData +=' <input name="icddiagnosis" id="icddiagnosis"  type="text"';
		referrDtData +='class="form-control border-input"';
		referrDtData +='placeholder=" " value=""  onKeyPress="autoCompleteCommonMe(this,5);"  onKeyUp="autoCompleteCommonMe(this,5);"';
		referrDtData +='onblur="fillDiagnosisCombo1(this.value,this);" />';
		referrDtData += '<div></td>';*/
		
		referrDtData += '<td><input type="text" class="form-control"   id="instruction" name="instruction" value=" " /></td>';
		
		referrDtData += ' <td>';
		referrDtData += '<textarea name="specialistOpinion" id="specialistOpinion" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;"></textarea>';
		referrDtData += ' <a class="btn-link" href="javascript:void(0)"  onclick="openResultModelSpecialist(this);">View/Enter Result</a>';
		referrDtData += '</td>';	
		
	/*	referrDtData += ' <td><input type="text"';
		referrDtData += '	class="form-control departmentListClass"';
		referrDtData += '	id="specialistOpinion" name="specialistOpinion" value="" /></td>'*/	
		 
		referrDtData += '	<td><div class="fileUploadDiv"><input type="file" name="referalFileUpload" id="referalFileUpload" class="inputUpload m-t-5" /><label class="inputUploadlabel">Choose File</label><span class="inputUploadFileName">No File Chosen</span></div></td>'

		referrDtData += '<td><button type="Button" name="add" class="buttonAdd btn btn-primary noMinWidth" id="referalMedicalDtIdAdd" button-type="add" value="" tabindex="1" onclick="addRowForReferalForDigiFileUploadMB();"> </button></td>';
		referrDtData += '<td><button type="button" name="delete" value=""    id="referalDtMedicalIdDel"  class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" onclick="deleteInvestAndReferalValueRowMb(this,11,"");" ></button></td>';
		referrDtData += '</tr>';
		$("#medicalReferal").html(referrDtData);
}

function deleteInvestAndReferalValueRowMb(item,flage,valueForDelete) {
	 if(confirm(resourceJSON.msgDelete)){
		 
		 var idGrid= item.id;
		 if (idGrid == "newInvestigationId") {
			 $(item).closest('tr').remove();
				return false;
			}
		 
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
										 getAFMSFInvestigationForDigiFileUploadMb();
									}
									if (flage == "11") {
										 $(item).closest('tr').remove();
										 getPatientReferalDetailForDigiFileUploadMb();
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
function closeMessage(){
	$('#messageForInvestigationOutsideMO').hide();
	$('.modal-backdrop ').hide();
}

function masMedicalCategoryListForDigi(item) {
 	
    var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";

    var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/medicalBoard/getMedicalBoardAutocomplete";
var countMedCat=0;
if (document.getElementById('fitInChk').checked == true) {
   	 var medicalCopositeName=$('#medicalCompositeName').val();
   	 
   	 $('#medicalCategory tr').each(function(i, el) {
			var $tds = $(this).find('td')	

			 var icdName = $tds.eq(1).find(":input").val();
			 if(icdName!=""){
				countMedCat=+1; 
			 }
   	 });
   	
    }
    var fitCheckId=idforTreat= $(item).closest('tr').find("td:eq(0)").find(":input").attr("id"); 
    if (document.getElementById(fitCheckId).checked == true) {
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
					$(item).closest('tr').find("td:eq(2)").find(":input").val(finalObservationForCategory);
					$(item).closest('tr').find("td:eq(9)").find(":input").val(mcId);
					$(item).closest('tr').find("td:eq(15)").find(":input").val('F');
					//$('#medicalCategoryIdNew').val(finalObservationForCategory);
					//$('#finalObservationMoDigi').val(finalObservationForCategory);
					
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
	 var genderId=$('#genderId').val();
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
				
						investigationData += '<input type="hidden"  name="appointmentIdSubInves" value=""  id="appointmentIdSubInves"/>';
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
								investigationData+='<textarea name="resultSubInvs" id="resultSubInvs'+count+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###</textarea>';
								investigationData+='<a class="btn-link" href="javascript:void(0)"  onclick="openResultModelMB(this);">View/Enter Result</a>';
								investigationData += '	</td>';
							}

						
						
						investigationData += '<td><input type="text" name="rangeSubInves" value="'+rangeValSub+'"';
						investigationData += '	id="rangeSubInves'+count+'" class="form-control"></td>';
						
						var deleteButtonFlag="";
						var ridcIdVal=0;
						investigationData += '<td></td>';
						investigationData += '<td></td>';
						investigationData += '<td></td>';
						/*investigationData += '<td><button name="Button" type="button"   class=" " '+approvalFlagDiasable+'   value="" onclick="addRowForInvestigationFunUpMb();"';
						investigationData += '	tabindex="1" > </button></td>';

						investigationData += '<td><button type="button" name="delete" value=""    id="deleteInves" '+approvalFlagDiasable+'';
						investigationData += ' class=" "';
						investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,\''
								+ ridcIdVal + '\');" ></button></td>';*/
						investigationData += ' </tr> ';
						count+=1;
						 
	    			}
		    	$(dgInvetigationGrid).append(investigationData);
		    	 
		    }
		    
		});
 }



function getAFMSFInvestigationForDigiFileUploadMb() {
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
	var genderId=$('#genderId').val();
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
					 
					var data = res.listObject;
					var  subListData = res.subInvestigationData; 
					var count = 1;
					var countins = 1;
					var investigationfinalValue = "";
					var diasableValue="disabled";
					var diasableValueCheck=" ";
					var checkedVal="";
					var totalRidcUploadVal=0;
					var countForSub=0;
					if (data != null && data.length > 0) {
						 func1='populateChargeCode';
			    		   url1='medicalexam';
			    		   url2='getInvestigationListUOM';
			    		   flaga='investigationMe';
			    		   
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
							investigationData += ' 	<input   class="form-check-input position-static" type="checkbox" '+checkedVal+' '+diasableValueCheck+' name="checkBoxForUpload" id="checkBoxForUpload'+count+'" onClick="return getInvestionCheckData(this);"><span class="cus-checkbtn"></span> ';
							investigationData += '</div> ';
							investigationData += ' </td> ';
							investigationData += '<td><div   class="autocomplete forTableResp">';
							investigationData += '<input type="text"  readonly value="'
									+ data[i].investigationName + '['
									+ data[i].investigationId
									+ ']" id="chargeCodeName' + count + '"';
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
							
							if(data[i].mainChargeCodeNameForInve=='Lab'){
	 							
								investigationData += '	<td>';
								investigationData+='<input type="text" name="resultInvsTemp" id="resultInvsTemp'+data[i].investigationId+'" value="'+escapeHtml(data[i].result)+'"class="form-control" onBlur="setLabResultInFieldDigi(this);"'+readonlyOnlyForInvestigation+'>';
								investigationData += '	<input type="hidden" name="resultInvs"   id="resultInvs'+data[i].investigationId+'" value="@@@###'+escapeHtml(data[i].result)+'" class="form-control" '+readonlyOnlyForInvestigation+' >';

	 							investigationData += '	</td>';

							}	
							 
							if(data[i].mainChargeCodeNameForInve=='Radio'){
								investigationData += '	<td>';
								investigationData+='<textarea name="resultInvs" id="resultInvs'+data[i].investigationId+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###'+escapeHtml(data[i].result)+'</textarea>';
								investigationData+='<a class="btn-link" href="javascript:void(0)"  onclick="openResultModelMB(this);">View/Enter Result</a>';
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
							investigationData += '<input type="text" name="range" id="range" value="'+rangeForInves+'" class="form-control" '+readonlyOnlyForInvestigation+'>';
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
							investigationData += 'onclick="addRowForInvestigationFunUpMbDigi();" ';
							investigationData += '	tabindex="1"  '+disableFlag+'> </button></td>';

							investigationData += '<td><button type="button" name="delete" value=""   button-type="delete" id="deleteInves" ';
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
											var subInvestigationHtml=getSubInvestionByValuesForMbDigi(dgSubMasInvestigationId,subInvestigationName,subInvestigationCode,uOMName,investigationIdVal,investigationType,
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
					}
					
					if(data.length==0){
						$('#totalLengthDigiFile').val("0");
						getInvestigationHtmlForDigiMBB();
					}
					
					
					
				}
			});

	return false;
}


function getSubInvestionByValuesForMbDigi(dgSubMasInvestigationId,subInvestigationName,subInvestigationCode,uOMName,investigationIdVal,investigationType,
		 rangeValSub,mainChargeCodeName,count,orderDtIdForSub,orderHdIdForSub,resultEntryDtidForSub,resultEntryHdidForSub,mainChargeCodeIdForSub,subMainChargeCodeIdForSub,resultForSub,disableFlag,deleteButtonFlag){
	 func1='populateChargeCode';
	    url1='medicalexam';
	   url2='getInvestigationListUOM';
	   flaga='investigationMeDg';
		 
		var investigationData = '<tr>';
		investigationData +='<td style="width: 150px;"></td>';
		investigationData += '<td><div class="form-group autocomplete forTableResp">';
		investigationData += '<input type="text" readonly autocomplete="never" value="'+subInvestigationName + '[' + dgSubMasInvestigationId + ']"';
		
		investigationData += ' class="form-control border-input" name="subInvestigationName" id="subInvestigationName'+count+'"  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
		investigationData += '<input type="hidden"  name="subInvestigationNameIdAndInv" value="'
				+ dgSubMasInvestigationId +"@@"+investigationIdVal+'"  id="subInvestigationNameIdAndInv' + dgSubMasInvestigationId + '"/>';
		
		investigationData += '<input type="hidden"  name="investigationSubType" value="'
			+ investigationType +'"  id="investigationSubType' +investigationType+ '"/>';

		investigationData += '<input type="hidden"  name="appointmentIdSubInves" value=""  id="appointmentIdSubInves'+count+'"/>';
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
				investigationData+='<a class="btn-link" href="javascript:void(0)" onclick="openResultModelMB(this);">View/Enter Result</a>';
				investigationData += '	</td>';
			}

		
		
		investigationData += '<td><input type="text" name="rangeSubInves" value="'+rangeValSub+'"';
		investigationData += 'id="rangeSubInves'+count+'" class="form-control"></td>';
		 
		investigationData += '	<td></td>';
		 
		var ridcIdVal=0;
		investigationData += '<td></td>';
		investigationData += '<td></td>';
		/*investigationData += '<td><button name="Button" type="button"   class=" "     value="" onclick="addRowForInvestigationFunUpMbDigi();" '+disableFlag+'';
		investigationData += '	tabindex="1" > </button></td>';

		investigationData += '<td><button type="button" name="delete" value=""    id="deleteInves"  '+deleteButtonFlag+'';
		investigationData += ' class=" "';
		investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,\''
				+ ridcIdVal + '\');" ></button></td>';*/
		investigationData += ' </tr> ';
		count+=1;
	 return investigationData;
}

function getAFMSF15InvestigationForMOOrMA() {
 	
	 var approvalFlag=$('#approvalFlag').val();
	 var approvalFlagDiasable="";
	 if(approvalFlag!="" && approvalFlag!=undefined && approvalFlag!=null && approvalFlag=='y'){
		 approvalFlagDiasable='disabled';
	 }
	 else{
		 approvalFlagDiasable="";
	 }
	
	var investigationGridValue = "investigationGrid";
	var investigationData="";
	var visitId = $('#visitId').val();
	var opdPatientDetailId=$('#opdPatientDetailId').val();
	var patientId=$('#patientId').val();
	var genderId=$('#genderId').val();
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
	 							
 								investigationData += '	<td>';
 	 							//investigationData += '	<input type="text" name="resultInvs" '+approvalFlagDiasable+' id="resultInvs'+count+'" value="'+data[i].result+'" class="form-control" '+readonlyOnlyForInvestigation+' >';
 								investigationData+='<input type="text" name="resultInvsTemp" '+approvalFlagDiasable+' id="resultInvsTemp'+data[i].investigationId+'" value="'+escapeHtml(data[i].result)+'" class="form-control"  onBlur="setLabResultInFieldMe(this);" '+readonlyOnlyForInvestigation+'  >';
								investigationData += '	<input type="hidden" name="resultInvs" id="resultInvs'+data[i].investigationId+'" value="@@@###'+escapeHtml(data[i].result)+'" class="form-control">';
	 							
 								
 								investigationData += '	</td>';

 							}	
 							
 							if(data[i].mainChargeCodeNameForInve=='Radio'){
 								investigationData += '	<td>';
 								investigationData+='<textarea name="resultInvs" id="resultInvs'+data[i].investigationId+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###'+escapeHtml(data[i].result)+'</textarea>';
 								investigationData+='<a class="btn-link" href="javascript:void(0)"   onclick="openResultModel(this);">View/Enter Result</a>';
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
							investigationData += '<td><input type="text" name="range" value="'+rangeForInves+'"';
							investigationData += '	id="range'+count+'" class="form-control" '+readonlyOnlyForInvestigation+'>';
							investigationData += '	<input type="hidden" name="investigationResultDate"   value="'+reultOfflineDate+'"   id="investigationResultDate'+data[i].investigationId+'"  class="form-control"/>';
 							investigationData += '	<input type="hidden"  name="resultNumber"    value="'+reultOfflineNumber+'" id="resultNumber'+data[i].investigationId+'"  class="form-control"/></td>';
							
						 
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
							
							
							
							investigationData += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth" '+approvalFlagDiasable+' button-type="add" value=""';
							investigationData += 'onclick="addRowForInvestigationFunUpMb();"';
							investigationData += '	tabindex="1" > </button></td>';

							investigationData += '<td><button type="button" name="delete" value=""  button-type="delete" id="deleteInves" '+diasableValue+'';
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
										
											
											
											var subInvestigationHtml=getSubInvestionByValuesForMb(dgSubMasInvestigationId,subInvestigationName,subInvestigationCode,uOMName,investigationIdVal,investigationType,
													 rangeValSub,mainChargeCodeName,count,orderDtIdForSub,orderHdIdForSub,resultEntryDtidForSub,
													 resultEntryHdidForSub,mainChargeCodeIdForSub,subMainChargeCodeIdForSub,resultForSub,diasableValue,approvalFlagDiasable,investigationRemarksForSub);
											
											investigationData+=subInvestigationHtml;
											
										}
									
									}
								}
							}
							
							
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


function getSubInvestionByValuesForMb(dgSubMasInvestigationId,subInvestigationName,subInvestigationCode,uOMName,investigationIdVal,investigationType,
		 rangeValSub,mainChargeCodeName,count,orderDtIdForSub,orderHdIdForSub,resultEntryDtidForSub,resultEntryHdidForSub,mainChargeCodeIdForSub,subMainChargeCodeIdForSub,resultForSub,
		 disableFlag,deleteButtonFlag,investigationRemarksForSub){
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

		investigationData += '<input type="hidden"  name="appointmentIdSubInves" value=""  id="appointmentIdSubInves'+count+'"/>';
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
				investigationData+='<a class="btn-link" href="javascript:void(0)"  onclick="openResultModel(this);">View/Enter Result</a>';
				investigationData += '	</td>';
			}

		
		
		investigationData += '<td><input type="text" name="rangeSubInves" value="'+rangeValSub+'"';
		investigationData += 'id="rangeSubInves'+count+'" class="form-control"></td>';
		 

			investigationData += '	<td>';
			investigationData += '	<textarea class="form-control"  name="investigationRemarksForSub" id="investigationRemarksForSub'+count+'" rows="2" maxlength="500">'+investigationRemarksForSub+'</textarea>';
			investigationData += '	 </td>';
		
		
		
		investigationData += '	<td></td>';
		 
		var ridcIdVal=0;
		investigationData += '<td><button name="Button" type="button"   class="hideElement"     value="" onclick="addRowForInvestigationFunUpMb();" '+disableFlag+'';
		investigationData += '	tabindex="1" > </button></td>';

		investigationData += '<td><button type="button" name="delete" value=""    id="deleteInves"  '+deleteButtonFlag+'';
		investigationData += ' class="hideElement"';
		investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,\''
				+ ridcIdVal + '\');" ></button></td>';
		investigationData += ' </tr> ';
		count+=1;
	 return investigationData;
}

function openResultModelMB(item){
	
	/*$('#messageForResult').show();
	$('.modal-backdrop ').show();*/
	/*var resultOfflineDateId= $(item).closest('tr').find("td:eq(4)").find("input:eq(1)").attr("id");
	 $('#currentObjectForResultOffLineDate').val(resultOfflineDateId);
	 var resultOfflineNumberId= $(item).closest('tr').find("td:eq(4)").find("input:eq(2)").attr("id");
	 $('#currentObjectForResultOffLinenumber').val(resultOfflineNumberId); 
	 
	var resultIdIm= $(item).closest('tr').find("td:eq(3)").find("input:eq(0)").attr("id");
	if(resultIdIm=="" || resultIdIm==undefined)
	 resultIdIm= $(item).closest('tr').find("td:eq(3)").find("textarea:eq(0)").attr("id");
	
	var resultView = $('#'+resultIdIm).val();
	if(resultView.includes("@@@###")){
		resultView=resultView.replace("@@@###","");
	}
	//resultView = resultView.replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&quot;/g,"'").replace(/&amp;/g,"&");
	resultView = decodeHtml(resultView)
 	$('#editorOfResult').jqteVal(resultView);
 	
	$('#resultIdImagin').val(resultIdIm);
	 $('#messageForResult').show();*/
	var resultOfflineDateId= $(item).closest('tr').find("td:eq(4)").find("input:eq(1)").attr("id");
	 $('#currentObjectForResultOffLineDate').val(resultOfflineDateId);
	 var resultOfflineNumberId= $(item).closest('tr').find("td:eq(4)").find("input:eq(2)").attr("id");
	 $('#currentObjectForResultOffLinenumber').val(resultOfflineNumberId); 
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
	 	$('#editorOfResult').jqteVal(resultView) ;
		$('#resultIdImagin').val(resultIdIm);
		 $('#messageForResult').show();
		
		$('#investigationResultDateTemp').val("") ;
		var resultOfflineDate = $j('#'+resultOfflineDateId).val();
		$('#investigationResultDateTemp').val(resultOfflineDate);
		
		$('#resultNumberTemp').val("") ;
		var resultOfflineNumberVal = $j('#'+resultOfflineNumberId).val();
		$('#resultNumberTemp').val(resultOfflineNumberVal) ;
	
}

function addRowForInvestigationFunUpMbDigi( ){
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

var escapeMatchedMap = {
		 '&': '&amp;',
		  '<': '&lt;',
		  '>': '&gt;',
		  '"': '&quot;',
		  "'": '&#39;',
		  '/': '&#x2F;',
		  '`': '&#x60;',
		  '=': '&#x3D;',
		  "'": ' &#x27;' 
		};

/*sanitise the cross site script*/
function escapeHtml(inputString) {
  return String(inputString).replace(/[&<>"'`=\/]/g, function (s) {
    return escapeMatchedMap[s];
  });
}

function  openGeneralDocAndInvForDigiMb(flagDoc){ 
	 var tbl = document.getElementById('dgInvetigationGrid');
	   	lastRow = tbl.rows.length;
	   	
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
		resultVal+='<input type="text" name="resultInvs" id="resultInvs"class="form-control">';
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
		resultVal+='<textarea name="resultInvs" id="resultInvs"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;"></textarea>';
		resultVal+='<a class="btn-link" href="javascript:void(0)" onclick="openResultModelMB(this);">View/Enter Result</a>';
		$('#resultdiv').html(resultVal);
		}
		}
	var countR=0;
	if(flagDoc=='Lab'|| flagDoc=='Radio'){
		 $('#dgInvetigationGrid tr').each(function(ij, el) {
			var dgResultHdVal= $(this).find("td:eq(0)").find("input:eq(6)").val();
		 if(dgResultHdVal!="" && dgResultHdVal!=0){
			 countR++;
		 }
		 });
		if(countR==0){
			$("#dgInvetigationGrid tr").remove();
			getInvestigationHtmlForDigiMBB();
		}
		}
	
}

function getInvestigationHtmlForDigiMBB() {
	 
	 
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
 								investigationData += '<textarea name="resultInvs" id="resultInvs"class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">   </textarea>';
 								investigationData += '	<a class="btn-link" href="javascript:void(0)" onclick="openResultModelMB(this);">View/Enter Result</a>';
 							 }
 							
 							investigationData += '	</td>';
 							investigationData += '<td>';
 							investigationData += '<input type="text" name="range" id="range" value="" class="form-control">';
 							investigationData += '	<input type="hidden" name="investigationResultDate" id="investigationResultDate" value="" class="form-control">';
							investigationData += '	<input type="hidden" name="resultNumber" id="resultNumber" value="" class="form-control">';
 							investigationData += '</td>';
 							investigationData += '	<td > </td>';
 							 
 							investigationData += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth"   button-type="add" value="" ';
 							investigationData += 'onclick="addRowForInvestigationFunUpMbDigi( );" ';
 							investigationData += '	tabindex="1" > </button></td>';

 							investigationData += '<td><button type="button" name="delete" value=""   button-type="delete" id="newInvestigationId"';
 							investigationData += 'class="buttonDel btn btn-danger noMinWidth"';
 							investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,0);"';
 							investigationData += '	tabindex="1" ></button></td>';
 							investigationData += ' </tr> ';
 						$("#dgInvetigationGrid").html(investigationData);
   
  
 }

function getSubInvestigationHtmlForMb(investiongationId,item){
	 
	 
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
	 var genderId=$('#genderId').val();
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
	    				 var resultForSub="";
						investigationData +='<td></td>';
						investigationData += '<td><div class="form-group autocomplete forTableResp">';
						investigationData += '<input type="text" readonly autocomplete="never" value="'+subInvestigationName + '[' + dgSubMasInvestigationId + ']"';
						
						investigationData += ' class="form-control border-input" name="subInvestigationName" id="subInvestigationName'+count+'"  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
						investigationData += '<input type="hidden"  name="subInvestigationNameIdAndInv" value="'
								+ dgSubMasInvestigationId +"@@"+investigationIdVal+'"  id="subInvestigationNameIdAndInv' + dgSubMasInvestigationId + '"/>';
						
						investigationData += '<input type="hidden"  name="investigationSubType" value="'
							+ investigationType +'"  id="investigationSubType' +investigationType+ '"/>';
				
						investigationData += '<input type="hidden"  name="appointmentIdSubInves" value=""  id="appointmentIdSubInves"/>';
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
	 							//investigationData += '	<input type="text" name="resultSubInv"  id="resultSubInv'+count+'" value="" class="form-control" >';
								investigationData+='<input type="text" name="resultInvsTemp" id="resultInvsTemp'+dgSubMasInvestigationId+'" value="'+escapeHtml(resultForSub)+'"class="form-control" onBlur="setLabResultInFieldMe(this);">';
								investigationData += '	<input type="hidden" name="resultSubInv"  id="resultSubInv'+dgSubMasInvestigationId+'" value="@@@###'+escapeHtml(resultForSub)+'" class="form-control" >';
							
								investigationData += '	</td>';

							}	
							
							if(mainChargeCodeName=='Radio'){
								investigationData += '	<td>';
								investigationData+='<textarea name="resultSubInvs" id="resultSubInvs'+dgSubMasInvestigationId+'" class="form-control" style="visibility:hidden; height:0px; margin:0;padding:0;">@@@###'+escapeHtml(resultForSub)+'</textarea>';
								investigationData+='<a class="btn-link" href="javascript:void(0)"  onclick="openResultModel(this);">View/Enter Result</a>';
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
						investigationData += 'onclick="deleteInvestAndReferalValueRow(this,10,\''
								+ ridcIdVal + '\');" ></button></td>';
						investigationData += ' </tr> ';
						count+=1;
						 
	    			}
		    	$(dgInvetigationGrid).append(investigationData);
		    	 
		    }
		    
		});
 }

function getMasDesignationMappingByUnitIdByHospitalIdAndDesigMB(hospitalId,designationIdValue){
	 var designationId=designationIdValue;
	 var forwardedUnitId= hospitalId;
	 if(forwardedUnitId=='Select'){
		 return false;
	 }
	 /*var approvalFlag=$('#approvalFlag').val();
	 var approvalFlagDiasable="";
	 if(approvalFlag!="" && approvalFlag!=undefined && approvalFlag!=null && approvalFlag=='y'){
		 approvalFlagDiasable='disabled';
	 }
	 else{
		 approvalFlagDiasable="";
	 }*/
	 var pathname = window.location.pathname;
	 var accessGroup = "MMUWeb";

	 var urlMasDesi = window.location.protocol + "//"
	 	+ window.location.host + "/" + accessGroup
	 	+ "/medicalexam/getMasDesignationMappingByUnitId";
	 
	 $.ajax({
			url : urlMasDesi,
			dataType : "json",
			data : JSON.stringify({
				'forwardedUnitId' : forwardedUnitId
			}),
			contentType : "application/json",
			type : "POST",
			success : function(response) {
				var dataDesignationObjList=response.dataDesignationList;
				var masDesignationSelectedValue="";
				if(dataDesignationObjList!=null && dataDesignationObjList!=undefined && dataDesignationObjList.length!=0)
				for(var i=0;i<dataDesignationObjList.length;i++){
					
					var desinationIdArray=dataDesignationObjList[i].designationId.split(",");
					var desinationNameArray=dataDesignationObjList[i].designamtionName.split(",")
					//user for remove designation
					masDesignationSelectedValue+='<select name="designationForMe" class="form-control" class="medium"  id="designationForMe">';
					masDesignationSelectedValue+='<option value="0">Select</option>';
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
				}
			if(dataDesignationObjList.length!=0){
				$('#designationForMe').html(masDesignationSelectedValue);
				$('#designationMeId').show();
				 document.getElementById("designationForMe").disabled = true;
			}
			else{
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

function rejectMbWaitList()
{
	$('#submitMOValidateFormByModelId').attr('disabled',true);
	//e.stopPropagation();
	var closeVisitId= $('#visitId').val();
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/rejectOpdWaitingList";
	
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'visitId' : closeVisitId,
					'mbVisit' : "mbVisit"
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
					var datas = response.msg;
					if(datas=="visitStatusUpdated")
					{
							$('#messageForCloseBtn').hide();
							$('.modal-backdrop ').hide();
						 	getCommandList('ALL');
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

function closeMessageReject(){
	$('#messageForCloseBtn').hide();
	$('.modal-backdrop ').hide();
}

function showCloseMessage(visitId)
{
	if(bulkCloseVisit=="")
	{
		
		alert("Please select at-least one record")
		return false;
	}
	document.getElementById('visitId').value = visitId;
	$('#messageForCloseBtn').show();
	$('#submitMOValidateFormByModelId').attr('disabled',false);
	
}

var checkBox='';
var bulkCloseVisit=[];
function bulkClose(item) {
	
		 checkBox = $(item).closest('tr').find("td:eq(10)").find(":input").attr("id");
		  var returnvalue = $("#" + checkBox).prop("checked"); 
		  var visitId='';
		  var param='';
		  //alert(returnvalue); 
		 // var text = document.getElementById("text");
		  if (returnvalue==true){
			  visitId=$(item).closest('tr').find("td:eq(0)").find(":input").val();
			  param={'visitId':visitId};
			  bulkCloseVisit.push(param);
			 
		  } else {
			 // alert("Not Selected ")
			  visitId=$(item).closest('tr').find("td:eq(0)").find(":input").val();
			  //bulkCloseVisit.push(visitId);
			  param={'visitId':visitId};
			  
				  var index = bulkCloseVisit.findIndex(function(item, i){
				    return item.visitId === visitId
				  });
		       if(index==0)
					{
						bulkCloseVisit.splice(0,1);	
					}
			  bulkCloseVisit.splice(index,1);
		    // text.style.display = "none";
		  }
		
	
}

function selectAllCheckForCloseMb()
{
	  $('#tblListOfCommand tr').each(function(i, el) {
		     var checkBoxidd= $(this).find("td:eq(10)").find("input:eq(0)").attr("id")
		     var checked = $("#" + checkBoxidd).prop("checked",true);
			  var returnvalue = true; 
		   	  var visitId='';
			  var param='';
			  if (returnvalue==true){
				  var $tds = $(this).find('td')
				  visitId=$tds.eq(0).find(":input").val();
				  param={'visitId':visitId};
				  bulkCloseVisit.push(param);
				 
			  }
			  else
			  {
				  return false;
			  }	  
	  });	
}

