/**
 * contains all method of opd and ipd page
 */

//written by @Krishna kumar :20-04-2019

var func1='';
var url1='';
var url2='';
var flaga='';
function removeRowReferal(val){
	
	$(val).closest('tr').remove();

}

function removeRowInvestigationOpd(val){
	
	if($('#dgInvetigationGrid tr').length > 1) {
		   $(val).closest('tr').remove()
		 }

}

function deleteDiagnosis(val){
	
	if($('#diagnosisGrid tr').length > 1) {
		   $(val).closest('tr').remove()
		 }

}

function removeTreatmentRow(val){
	if($('#nomenclatureGrid tr').length > 1) {
	   $(val).closest('tr').remove()
	 }
}

function removeProcedureRow(val){
	if($('#gridNursing tr').length > 1) {
		   $(val).closest('tr').remove()
		 }
}



function removeImplantData(val){
	if($('#tableImplant tr').length > 1) {
		   $(val).closest('tr').remove()
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
		autocomplete(val, arryNomenclatureNip);
	}
	if(flag=='5'){
		autocomplete(val, arry);
	}
}


function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

function getTemplateDetailMedicalAdvice() {

	var pathname = window.location.pathname;
	var accessGroup = pathname.split("/")[1];
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getTemplateName";
	
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'doctorId' : uId,
					'templateType' : 'A'
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

					$('#medicalAdviceTemplateId').html(trHTML);
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

$(document).delegate("#medicalAdviceTemplateId","change",
		function() {


	var pathname = window.location.pathname;
	var accessGroup = pathname.split("/")[1];
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getTemplateMedicalAdvice";
	
	// var url =
	// "http://localhost:8181/AshaServices/v0.1/opdmaster/getTemplateInvestData";
	
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'employeeId' : '1',
					'templateId':$('#medicalAdviceTemplateId').val()
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
				   if (response.status == 1) {
					var datas = response.data;
					$.each(datas, function(i, item) {
								    var mAdviceVal=item.medicalAdvice;
								    try{
								    	document.getElementById('additionalNote').value=mAdviceVal;
								    }
								    catch(e){}
								    try{
								   $('#recommendedMedicalAdvice').val(mAdviceVal);
								    }
								    catch(e){}
					});
					
					
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


function getEmpanelledHospital() {
	
	var j=1;
    
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getEmpanelledHospital";
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'employeeId' : '1',
					'cityId':$('#cityId').val()
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
					var datas = response.masEmpanelledHospital;
					var trHTML = '<option value=""><strong>Select Hospital...</strong></option>';
					$.each(datas, function(i, item) {
						trHTML += '<option value="' + item.empanelledHospitalId + '@'
								+ item.empanelledHospitalCode + '" >' + item.empanelledHospitalName
								+ '</option>';
						$('.referHospitalListClass').html(trHTML);
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

function nextFolloUpDate(val)
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
					specialistHtml = '<option value=""><strong>Select Department...</strong></option>';
					$.each(masSpecialistList, function(i, item) {
						specialistHtml += '<option value="' + item.specialityId + '@'
								+ item.specialityCode + '" >' + item.specialityName
								+ '</option>';
						$('#referSpecialistList').html(specialistHtml);
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

function getEmpanelled() {
	
		var j=1;
        
		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/opd/getEmpanelledHospital";
		$
				.ajax({
					url : url,
					dataType : "json",
					data : JSON.stringify({
						'employeeId' : '1',
						'cityId':$('#cityId').val(),
						'hospitalId':hsId
					}),
					contentType : "application/json",
					type : "POST",
					success : function(response) {
						console.log(response);
						var datas = response.masEmpanelledHospital;
						var trHTML = '<option value=""><strong>Please select hospital</strong></option>';
						$.each(datas, function(i, item) {
							trHTML += '<option value="' + item.empanelledHospitalId + '@'
									+ item.empanelledHospitalCode + '" >' + item.empanelledHospitalName
									+ '</option>';
						});
						console.log("masSpecialistList "+masSpecialistList);
						specialistHtml = '<option value=""><strong>Select Department...</strong></option>';
						$.each(masSpecialistList, function(i, item) {
							specialistHtml += '<option value="' + item.specialityId + '@'
									+ item.specialityCode + '" >' + item.specialityName
									+ '</option>';
						});
						var html='';
					
									
									html+='<tr><td>'+(j)+'</td><td><select id="referHospitalList" name="referHospitalList" class="referHospitalListClass form-control minWidth250">';
									html+=trHTML+'</select></td>';
									html+='<td><select id="referSpecialistList" name="referSpecialistList" class="referSpecialistListClass form-control minWidth250">';
									html+=specialistHtml+'</select></td>s</tr>'
									var val = parseInt($('#referalGrid>tr:last').find("td:eq(1)").text());
									j++;
							
						$('#referalGrid').html(html);
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




var internalHospitalList='';
var departmentList='';
var trHosList='';
var trDeptList='';


function getInternalRefferal() {
	var j=1;
	
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getMasDepartmentList";
	$.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'employeeId' : '1',
					'hospitalID' :'14'
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
					var datas = response.departmentList;
					var departmentList = '<option value=""><strong>Select Department...</strong></option>';
					$.each(datas, function(i, item) {
						departmentList += '<option value="' + item.departmentId + '@'
						+ item.departmentId + '" >' + item.departmentname
						+ '</option>';
						
						$('.departmentListClass').html(departmentList);
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
	
	var url1 = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getMasHospitalList";
	$
			.ajax({
				url : url1,
				dataType : "json",
				data : JSON.stringify({
					'employeeId' : '1',
					'hospitalID' :'14'
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
					var datas = response.HospitalList;
					var internalHospitalList = '<option value=""><strong>Select Hospital...</strong></option>';
					$.each(datas, function(i, item) {
						internalHospitalList +='<option value="' + item.hospitalId + '@'
						+ item.hospitalId + '" >' + item.hospitalName
						+ '</option>'; 
					});
					$('.referInternalHospitalListClass').html(internalHospitalList);
								  
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
	
		
   	var htmlInternal='';
	$("#diagnosisId > option").each(
	function() {
		        var diagonsisText=this.text;
				var diagonsisValue=this.value;
				htmlInternal+='<tr><td>'+(j++)+'</td><td><select id="referInternalHospitalList" name="referInternalHospitalList" class="referInternalHospitalListClass form-control minWidth250">';
				htmlInternal+=internalHospitalList+'</select></td><td><select id="departmentList" name="departmentList" class="departmentListClass form-control minWidth220">';
				htmlInternal+=departmentList+'</select></td><td><div  class="autocomplete"><textarea class="form-control" type="text" id="diagonsisText" name="diagonsisText" onblur="fillDiagnosisCombo(this.value);fillReferalDiagnosisVal(this)">'+diagonsisText+'</textarea></div></td><td><input class="form-control" type="text" id="hos" name="hos" /></td><td><button name="button" type="button" class="btn btn-primary buttonAdd noMinWidth" button-type="add" value="" tabindex="1" onclick="addRowForRefer();"></button></td><td><button type="button" name="delete" value="" class="buttonDel btn btn-danger noMinWidth" button-type="delete" tabindex="1" onclick="removeRowReferal(this);"></button></td><td style="display:none;"><input type="hidden" id="diagonsisId" name="diagonsisId" value="'+diagonsisValue+'"/></td></tr>'
				var val = parseInt($('#referalGrid>tr:last').find("td:eq(1)").text());
				});
				$('#referalGrid').html(htmlInternal);
				
   }


jQuery(function($) {
	$("#admDiv").hide();
	$("#referDiv").hide();
	$("#minorOTSchedulingDiv").hide();
	$("#obg").hide();
	$("#gyna").hide();

	
	$("#referral").change(
			function externalReferal() {
				document.getElementById("referExternal").checked = true;
				if ($("#referral").val() == 1) {
						
					checkReferTO('referExternal');
                   	$("#admDiv").hide();
					$("#admissionAdvised").attr("checked", false);
					$("#admissionAdvised").attr('disabled', true);
					// $("#referInternal").attr('checked', true);
					$("#referExternal").attr('checked', 'checked');
				      
					getEmpanelled();
					getSpecialistList();
					
				      
				} else {
					document.getElementById('referhospital').setAttribute(
							"validate", " ");
					document.getElementById('referredFor').setAttribute(
							"validate", " ");
					$("#referDiv").show();

					$("#admissionAdvised").attr('disabled', false);
					//$('#referGrid').append(trHTML);
					$("#referalGrid tr").remove(); 
				}
								
			});

	$(document)
			.delegate(
					"#templateId",
					"change",
					function() {
						// document.getElementById("copyPrevPrescriptionTemplateDiv").style.display='none';
						var templateId = document.getElementById('templateId').value;
						var totalRow = parseInt($("#nomenclaturehdb").val());
						var itemIdArray = "";
						$("#nomenclaturehdb").remove();
						if (templateId == 0) {
							var rowCount = $('#nomenclatureGrid tr').length;
							for (var i = 0; i <= rowCount; i++) {
								// $("#nomenclatureGrid tr:eq("+i+")").remove();
								$("#nomenclatureGrid > tr").remove();
								// $().closest('tr').remove();
							}
							totalRow = 1;
						} else {
							// $("#nomenclaturehdb").remove();
							for (var i = 1; i <= totalRow; i++) {

								if (document.getElementById("itemId" + i) != null
										&& $('#itemId' + i).val() != "")
									itemIdArray += $('#itemId' + i).val() + ",";
							}

							/*
							 * if(totalRow==1) {
							 */
							if (document.getElementById("nomenclature1") != null
									&& document.getElementById("nomenclature1").value == "") {
								$("#nomenclatureGrid tr:eq(1)").remove();
							}
							// }

							totalRow = totalRow + 1;
						}
						new Ajax.Request('opd?method=showGridInMainJsp&hinId='
								+ document.getElementById('hinId').value
								+ '&templateId='
								+ document.getElementById('templateId').value
								+ "&totalRow=" + totalRow + "&itemIdArray="
								+ itemIdArray, {
							contentType : "application/json",
							onSuccess : function(response) {
								if (response.responseText.trim() != '') {
									$('#nomenclatureGrid').append(
											response.responseText);
								}
							}
						});

					});

	$(document)
			.delegate(
					"#templateIdFAC",
					"change",
					function() {
						// document.getElementById("copyPrevPrescriptionTemplateDiv").style.display='none';
						var templateIdFAC = document
								.getElementById('templateIdFAC').value;
						var totalRow = parseInt($("#hdb").val());

						var itemIdArray = "";
						$("#hdb").remove();
						if (templateIdFAC == 0) {
							var rowCount = $('#nomenclatureGrid tr').length;
							for (var i = 0; i <= rowCount; i++) {
								// $("#nomenclatureGrid tr:eq("+i+")").remove();
								$("#nomenclatureGrid > tr").remove();
								// $().closest('tr').remove();
							}
							totalRow = 1;
						} else {
							// $("#nomenclaturehdb").remove();
							for (var i = 1; i <= totalRow; i++) {

								if (document.getElementById("itemId" + i) != null
										&& $('#itemId' + i).val() != "")
									itemIdArray += $('#itemId' + i).val() + ",";
							}

							/*
							 * if(totalRow==1) {
							 */
							if (document.getElementById("nomenclature1") != null
									&& document.getElementById("nomenclature1").value == "") {
								$("#nomenclatureGrid tr:eq(1)").remove();
							}
							// }

							totalRow = totalRow + 1;
						}
						new Ajax.Request(
								'opd?method=showGridInMainJspFAC&hinId='
										+ document.getElementById('hinId').value
										+ '&templateId='
										+ document
												.getElementById('templateIdFAC').value
										+ "&totalRow=" + totalRow
										+ "&itemIdArray=" + itemIdArray,
								{
									contentType : "application/json",
									onSuccess : function(response) {
										if (response.responseText.trim() != '') {
											$('#nomenclatureGrid').append(
													response.responseText);
										}
									}
								});

					});

	/* $("#investigationTemplateId").change(function(){ */
	$(document)
			.delegate(
					"#investigationTemplateId",
					"change",
					function() {

						// document.getElementById("copyPrevPrescriptionTemplateDiv").style.display='none';
						var templateId = document
								.getElementById('investigationTemplateId').value;
						var totalRow = parseInt($("#hiddenValue").val());
						var itemIdArray = "";
						$("#hiddenValue").remove();
						if (templateId == 0) {
							var rowCount = $('#investigationGrid tr').length;
							for (var i = 0; i <= rowCount; i++) {
								// $("#nomenclatureGrid tr:eq("+i+")").remove();
								$("#investigationGrid > tr").remove();
								// $().closest('tr').remove();
							}
							totalRow = 1;
						} else {
							// $("#nomenclaturehdb").remove();
							var val = "";
							var id = 0;
							for (var i = 1; i <= totalRow; i++) {

								if (document.getElementById("chargeCodeName"
										+ i) != null
										&& $('#chargeCodeName' + i).val() != "") {
									// itemIdArray += $('#itemId'+i).val()+",";
									val = $('#chargeCodeName' + i).val();
									var index1 = val.lastIndexOf("[");
									var index2 = val.lastIndexOf("]");
									index1++;
									id = val.substring(index1, index2);
									itemIdArray += id + ",";
								}
							}

							if (totalRow == 1) {
								if (document.getElementById("chargeCodeName1") != null
										&& document
												.getElementById("chargeCodeName1").value == "") {
									$("#investigationGrid tr:eq(2)").remove();
								}
							}

							totalRow = totalRow + 1;
						}

						new Ajax.Request(
								'opd?method=showGridForInvestigation&hinId='
										+ document.getElementById('hinId').value
										+ '&investigationTemplateId='
										+ templateId + "&totalRow=" + totalRow
										+ "&itemIdArray=" + itemIdArray,
								{
									onSuccess : function(response) {
										if (response.responseText.trim() != '') {
											// alert(response.responseText);
											$('#investigationGrid').append(
													response.responseText);
										}
									}
								});

					});

	$("#cycles").change(
			function() {
				if ($("#cycles").val() == 'Regular') {
					$("#cycle_text").show();
					document.getElementById('cycle_text').value = "3-5/28-30";

				} else if ($("#cycles").val() == 'Irregular') {
					$("#cycle_text").show();
					if (document.getElementById("cycle_text_hidden") != null)
						document.getElementById('cycle_text').value = document
								.getElementById("cycle_text_hidden").value;
					else
						document.getElementById('cycle_text').value = "";
				} else {
					$("#cycle_text").hide();
					document.getElementById('cycle_text').value = "";
				}
			});

	$("#external_genitalia").change(function() {

		if ($("#external_genitalia").val() == 'Other') {
			$("#external_genitalia_other").show();
		}

		else {
			$("#external_genitalia_other").hide();
			document.getElementById('external_genitalia_other').value = "";
		}
	});
	$("#removesnomedList").click(function() {
		$("#snomedList option:selected").remove();
	});

	$(".primary-items a").click(function() {
		$(this).siblings('#subMenu').slideToggle();
	});

	$('input[name="labradiologyCheck"]').change(
			function() {
				// alert($('input[name="labradiologyCheck"]:checked').val());
				$('#investigationCategory').val(
						$('input[name="labradiologyCheck"]:checked').val());
			});
	$('#investigationCategory').val(
			$('input[name="labradiologyCheck"]:checked').val());

	$('input[name="surgeryCheck"]').change(
			function() {
				// alert($('input[name="labradiologyCheck"]:checked').val());
				$('#surgeryCategory').val(
						$('input[name="surgeryCheck"]:checked').val());
			});
	$('#surgeryCategory').val($('input[name="surgeryCheck"]:checked').val());

	$('input[name="procedureCheck"]').change(
			function() {
				// alert($('input[name="labradiologyCheck"]:checked').val());
				$('#nursingCategory').val(
						$('input[name="procedureCheck"]:checked').val());
			});
	$('#nursingCategory').val($('input[name="procedureCheck"]:checked').val());

	$("#resetBmi").click(function() {
		$("#height").val("");
		$("#weight").val("");
	});
	
	$("#temperature").blur(function() {
		if ($("#temperature").val() > 999) {
			alert("Invalid Temperature");
			$("#temperature").focus();
			$("#temperature").val("");
		}
	});



	$("#generalExamination1").dblclick(
			function() {
				$("#generalExaminationOPC").val(
						$.trim($("#generalExaminationOPC").val()
								+ "\n"
								+ $("#generalExamination1 option:selected")
										.text()));
				$("#generalExaminationEXM").val(
						$.trim($("#generalExaminationEXM").val()
								+ "\n"
								+ $("#generalExamination2 option:selected")
										.text()));
			});
	$("#generalExamination2").dblclick(
			function() {
				$("#generalExaminationOPC").val(
						$.trim($("#generalExaminationOPC").val()
								+ "\n"
								+ $("#generalExamination1 option:selected")
										.text()));
				$("#generalExaminationEXM").val(
						$.trim($("#generalExaminationEXM").val()
								+ "\n"
								+ $("#generalExamination2 option:selected")
										.text()));
			});
	$("#diastolic").blur(function() {
		if (parseInt($("#systolic").val()) < parseInt($("#diastolic").val())) {
			alert("Diastolic should be less than Systolic");
			$("#diastolic").val("");
			$("#diastolic").focus();
		}
	});
	$("#removeOPDisgnosis").click(
			function() {
				if ($("#diagnosisId option:selected").length > 1) {
					alert("You can delete only one option at a time !");
				} else {
					$("#diagnosisId option:selected").remove();
					deleteRowFromOPConsultationTab($(
							"#diagnosisId1 option:selected").index());
				}
			});
	$("#removeOPDisgnosis").click(
			function() {
				if ($("#diagnosisId option:selected").length > 1) {
					alert("You can delete only one option at a time !");
				} else {
					$("#diagnosisId option:selected").remove();
					deleteRowFromOPConsultationTab($(
							"#diagnosisId1 option:selected").index());
				}
			});
	$("#removeSnomed").click(function() {
		document.getElementById("snomed").value = '';
	});
	$("#icd").blur(function() {
		var code1 = {};

		$("select[name='diagnosisId'] > option").each(function() {
			if (code1[this.text]) {
				$(this).remove();
			} else {
				code1[this.text] = this.value;
			}
		});

	});
	$('#admissionAdvised').click(function() {

		$("#admDiv").toggle(this.checked);
	});

	$('#patient_expire').click(function() {
		var checked = $(this).is(':checked');
		$("#referral").val('0');
		if (checked) {
			if ($("#referral").val() == 0) {
				$("#referalDiv").hide();
				$("#referDiv").hide();
				$("#siftedToMortuaryDiv").show();
                }
		} else {
			$("#referalDiv").show();
			$("#referDiv").hide();
			$("#siftedToMortuaryDiv").hide();
		}
	});
	$('#referral').click(function() {
		var selVal = $("#referral").val();
		if (selVal == 0) {
			$("#referDiv").hide();
		} else if (selVal == 1) {
			$("#referDiv").show();
		}
	});

});

if (!''.trim) {
	String.prototype.trim = function() {
		return this.replace(/^\s+|\s+$/g, '');
	};
}

function fnSubmitPatient(from) {
	if (from == 's') {
		if (validateFieldValues(from)) {
			if (confirm("Do you want to submit !")) {
				submitForm('opdMain',
						'opd?method=submitOPDPatientDetails&flag=opd&submitFrom=2');

			}
		}
	} else if (from == 'n') {
		if (validateFieldValues(from)) {
			if (confirm("Do you want to submit !")) {
				submitForm('opdMain',
						'opd?method=submitOPDPatientDetails&flag=opd&submitFrom=2&from=1');
			}
		}
	} else if (from == 'p') {
		if (validateFieldValues(from)) {
			if (confirm("Do you want to park patient !")) {
				submitForm('opdMain',
						'opd?method=submitOPDPatientDetails&flag=opd&submitFrom=3');
			}
		}
	} else if (from == 'secondop') {
		if (validateFieldValues(from)) {
			if (confirm("Do you want patient send to Second Opinion !")) {
				submitForm('opdMain',
						'opd?method=submitOPDPatientDetails&flag=opd&submitFrom=4');
			}
		}
	}
}

function fillICDValue(val2, from) {

	var b = false;
	if (val2 != 0) {

		var $ = jQuery.noConflict();
		document.getElementById('icd1').value = val2;
		var tempVal2 = val2;
		tempVal2 = tempVal2.replace(".", "_");
		tempVal2 = tempVal2.replace("*", "idid");
		var tempVal22 = tempVal2.split("@@@");
		if (from == "op") {
			var text = $("#icdName option:selected").text();
			$('#icdNameExm').prop('selectedIndex',
					$("select[name='icdName'] option:selected").index());
		} else if (from == "exm") {
			var text = $("#icdNameExm option:selected").text();
			$('#icdName').prop('selectedIndex',
					$("select[name='icdNameExm'] option:selected").index());
		}

		if (from == "op") {
			document.getElementById('icd1').value = $(
					"#icdName option:selected").text();
		} else if (from == "exm") {
			document.getElementById('icd1').value = $(
					"#icdNameExm option:selected").text();
		}

		tempArray = val2.split("@@@");
		var ICdId = tempArray[0];
		var SnomedId = tempArray[1];
		document.getElementById('icdCode').value = ICdId;

		if (ICdId == "") {
			return;
		} else {
			var obj = document.getElementById('diagnosisId');

			for (var i = 0; i < obj.length; i++) {
				var temp = $("#diagnosisId option").eq(i).val();

				var BothId = new Array();
				BothId = temp.split("-");

				var tempArray = new Array();
				tempArray = BothId[0].split("@@@");
				var tempICdId = tempArray[0];
				var tempSnomedId = tempArray[1];
				/*
				 * alert("ICdId="+ICdId); alert("tempICdId="+tempICdId);
				 */

				if (ICdId == tempICdId) {
					alert("ICD  Already taken");
					document.getElementById('icd').value = ""
					document.getElementById('icd2').value = ""
					b = true;
					break
				}
			}
		}
		var flag = 2;
		var obj = document.getElementById('diagnosisId');
		for (var x = 0; x < obj.length; x++) {

			var temp = $("#diagnosisId option").eq(x).val();

			var BothId = temp.split("-");
			var tempArray = new Array();
			tempArray = BothId[0].split("@@@");
			var tempICdId = tempArray[0];
			var tempSnomedId = tempArray[1];

			if (SnomedId == tempSnomedId) {
				flag = 1;
				break;
			}
		}

		if (flag != 1) {
			var obj = document.getElementById('diagnosisId');
			var length = obj.length + 1;

			$("#diagnosisId").append(
					"<option value=" + val2 + "-0>" + text + "</option>");
			obj.options[obj.length - 1].selected = true;

			if (document.getElementById('diagnosisId1') != null) {
				obj = document.getElementById('diagnosisId1');
				var tableRow = obj.rows.length;
				var row = obj.insertRow(tableRow);
				var cell1 = row.insertCell(0);
				var cell2 = row.insertCell(1);
				var cell3 = row.insertCell(2);
				cell1.innerHTML = text;
				cell2.innerHTML = "<input type='checkbox' id='" + tempVal22[0]
						+ "' class='radioCheckCol2' value='" + tempVal22[0]
						+ "' onclick='fnCopyToComorbidityTab(\"" + tempVal22[0]
						+ "\")'/>";
				cell3.innerHTML = "<img src='/hms/jsp/images/removeImg.jpg' style='width:16px;height:16px' title='Remove diagnosis' onclick='deleteRow(this);'/>"
			}
			notifiablePregisterCheck(tempVal22[0], text);
		} else {
			alert("Diagnosis already exist");
		}

	}// if close
}

var im=0;
function addImplantTable()
{
	im++;
	var aClone = $('#tableImplant>tr:last').clone(true)
	aClone.find(":input").val("");
	aClone.find('img.ui-datepicker-trigger').remove();
	aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'deviceId'+im+'');
	aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'deviceName'+im+'');
	aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'dateOfImplant'+im+'');
	aClone.find("td:eq(3)").find("input:eq(0)").prop('id', 'implantRemarks'+im+'');
	aClone.find("td:eq(6)").find("input:eq(0)").prop('id', 'alreadydeviceId'+im+'');
	aClone.find('input[type="text"]').removeAttr("readonly", false);
	aClone.find("td:eq(3)").find("input:eq(0)").prop('readonly', false);
	aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'dateOfImplant'+im+'').removeClass('input_date hasDatepicker').addClass('noFuture_date form-control');
	aClone.find("option[selected]").removeAttr("selected")
	aClone.clone(true).appendTo('#tableImplant');	
}




function addRowTreatmentNursingCare() {
	addNur++;
	var aClone = $('#gridNursing>tr:last').clone(true)
	aClone.find(":input").val("");
	aClone.find("td:eq(0)").find(":input").prop('id', 'procedureNameNursing'+addNur+'');
	aClone.find("td:eq(2)").find(":input").prop('id', 'procedureNameNursingId'+addNur+'');
	aClone.clone(true).appendTo('#gridNursing');
	var val = $('#gridNursing>tr:last').find("td:eq(0)").find(":input")[0];
	
}


function checkVal(val) {
	if (parseInt(val) > 299) {
		alert("Pulse should be less than 300");
		document.getElementById('pulse').focus;
	}
}
function showDiagnosis(csrf) {
	var msg = "Decision making is finally according to the judgment of the treating doctor";
	if (confirm(msg)) {
		var url = "/hms/hms/opd?method=showDiagnosisPopUp&" + csrf + "&"
				+ csrfTokenName + "=" + csrfTokenValue;
		;
		newwindow = window
				.open(url, 'Diagnosis',
						"left=0,top=0,height=700,width=1010,status=1,scrollbars=1,resizable=1");
	}

}

function validateFieldValues(from) {
	var dateSelected = document.getElementById("reviewDate").value;
	var tab = document.getElementById("tab").value;

	if (from == 'n') {
		if (confirm("Do you want to skip this patient!")) {
			submitForm('opdMain',
					'opd?method=submitOPDPatientDetails&flag=opd&submitFrom=2&from=1&skip=1');
		}
		return false;
	} else {
		if (document.getElementById('diagnosisId').length == 0
				&& document.getElementById('OtherDiagnosis').value.trim().length == 0) {
			alert("Please Enter the diagnosis of the Patient.");
			document.getElementById("snomed").focus();
			if (from != 's' && from != 'p') {
				if (confirm("Do you want to skip this patient!")) {
					submitForm('opdMain',
							'opd?method=submitOPDPatientDetails&flag=opd&submitFrom=2&from=1&skip=1');
				}
			}
			return false;
		}
	}

	if (dateSelected != "") {
		var visitDate = new Date(dateSelected.substring(6), (dateSelected
				.substring(3, 5) - 1), dateSelected.substring(0, 2))
		var currentDate = new Date(serverdate.substring(6), (serverdate
				.substring(3, 5) - 1), serverdate.substring(0, 2))
		if (visitDate < currentDate) {
			document.getElementById("reviewDate").value = document
					.createElement('consultationDate').value;
			alert("Please enter the correct Visit date.")
			return false;
		}
	}

	var systolic = document.getElementById("systolic").value;
	var diastolic = document.getElementById("diastolic").value;
	if (diastolic != null && diastolic != ''
			&& (systolic == null || systolic == '')) {
		alert('please fill systolic');
		return false;
	} else if (systolic != null && systolic != ''
			&& (diastolic == null || diastolic == '')) {
		alert('please fill diastolic');
		return false;
	}
	// code for chaecking investigation requistion grid
	var tbl = document.getElementById('grid');
	var ptbl = document.getElementById('prescriptionTabGrid');
	var lastRow = parseInt(tbl.rows.length);
	var plastRow = parseInt(ptbl.rows.length);
	var nomenclature = "";
	var pnomenclature = "";
	if (tab == 1) {
		for (var i = 1; i < lastRow; i++) {
			if (document.getElementById("dosage" + i).value == "") {
				alert("Please fill dosage in row " + i + " On Consultaion")
				return false;
			}
			if (document.getElementById("frequency" + i).value == "0") {
				alert("Please select frequency in row " + i + " On Consultaion")
				return false;
			}
			if (document.getElementById("noOfDays" + i).value == "") {
				alert("Please fill noOfDays in row " + i + " On Consultaion")
				return false;
			}
			if (document.getElementById("instrunction" + i).value == "") {
				alert("Please fill instrunction in row " + i
						+ " On Consultaion")
				return false;
			}
		}
	} else if (tab == 2) {
		for (var i = 1; i < plastRow; i++) {
			if (document.getElementById("dosagepTab" + i).value == "") {
				alert("Please fill dosage in row " + i + " On Prescription")
				return false;
			}
			if (document.getElementById("frequencypTab" + i).value == "0") {
				alert("Please select frequency in row " + i
						+ " On Prescription")
				return false;
			}
			if (document.getElementById("noOfDayspTab" + i).value == "") {
				alert("Please fill noOfDays in row " + i + " On Prescription")
				return false;
			}
			if (document.getElementById("instrunctionpTab" + i).value == "") {
				alert("Please fill instrunction in row " + i
						+ " On Prescription")
				return false;
			}
		}
	}
	if (document.getElementById('mlscasetype').length != 0) {
		var x = document.getElementById("mlscasetype");
		var val = "";
		for (var i = 0; i < x.options.length; i++) {
			if (x.options[i].selected == true) {
				val = x.options[i].value;
				// alert(val);
				// alert(val.contains('postmortem'));
				if (val.indexOf("postmortem") > -1) {
					if (document.getElementById('patient_expire').checked == false) {
						alert("Please check Patient is dead as you are referring for postmortem examination.");
						return false;
					}
				}
			}
		}
	}
	return true;
}

/*
 * function fnGetDoctorDepartment(departmentId){ // new
 * Ajax.Request('opd?method=getDoctorDepartment&departmentId='+departmentId+'&'+csrfTokenName+'='+csrfTokenValue, {
 * new Ajax.Request('opd?method=getDoctorDetails&departmentId='+departmentId,{
 * onSuccess: function(response) { if(response.responseText.trim()!='') {
 * document.getElementById('refereddoctor').innerHTML=response.responseText.trim(); } }
 * }); }
 */

function checkTab(tab) {
	document.getElementById("tab").value = tab;
}

function validateFieldaddrow() {

	var tbl = document.getElementById('grid');
	var lastRow = tbl.rows.length;
	lastRow = parseInt(lastRow) - 1;
	if (document.getElementById("brandId" + lastRow).value == "") {
		alert("Please Select The Brand Name " + lastRow);
		return false;
	} else {
		// document.getElementById("brandId"+lastRow).selectedIndex=true;

	}
	return true;
}

function validateFieldValuesPediatricsOpd() {

	var ageId = document.getElementById("ageId").value
	var age = ageId.substring(0, 2);
	var ageIntoInt = parseInt(age);
	if (ageIntoInt <= 15) {
		var dateSelected = document.getElementById("nextVisitDate").value;
		if (document.getElementById('diagnosisId').length == 0) {
			alert("Please Enter the diagnosis of the Patient.");
			return false;
		}
		if (dateSelected != "") {
			var visitDate = new Date(dateSelected.substring(6), (dateSelected
					.substring(3, 5) - 1), dateSelected.substring(0, 2))
			var currentDate = new Date(serverdate.substring(6), (serverdate
					.substring(3, 5) - 1), serverdate.substring(0, 2))
			if (visitDate < currentDate) {
				document.getElementById("nextVisitDate").value = "";
				alert("Please enter the correct Visit date.")
				return false;
			}
		}
		return true;
	} else {
		alert("Not more 15 years.");
		return false;
	}
	return true;
}

function fnShowBroughtBy() {
	document.getElementById('policeDiv').style.display = 'none';
	document.getElementById('otherSelfDiv').style.display = 'none';
	if (document.getElementById('PoliceCheck').checked) {
		document.getElementById('policeDiv').style.display = 'block';
	} else if (document.getElementById('OtherCheck').checked) {
		document.getElementById('otherSelfDiv').style.display = 'block';
	} else if (document.getElementById('SelfCheck').checked) {
		document.getElementById('otherSelfDiv').style.display = 'block';
	}
}

function noOfDaysAlert(val,item)
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
	fillValueNomenclature();
}


function fillValueNomenclature() {
	var TableData = new Array();
    $('#nomenclatureGrid tr').each(function(i, el) {
    	var $tds = $(this).find('td')
		var itemClassId = $tds.eq(12).find(":input").val();
    	
    	var itemClassIdTablet="3";
        var itemClassIdCapusle="4";
        var itemClassIdInjection="5";
        if(itemClassId==itemClassIdTablet || itemClassId==itemClassIdCapusle || itemClassId==itemClassIdInjection)
	    {
		
			var productId = $tds.eq(0).find(":input").val();
			var product = $tds.eq(1).find(":input").val();
			var dosage = $tds.eq(2).find(":input").val();
			var frequency = $tds.eq(3).find(":input").val();
			var splitFrequency = frequency.split("@");
			var noofdays = $tds.eq(4).find(":input").val();
			var Quantity2 = $tds.eq(5).find(":input").val();
			var product3 = $tds.eq(4).find(":input").val();
			var total = dosage * splitFrequency[0] * noofdays;
			var t=Math.round(total);
			
			if(t>100) 
				{
				alert("You cannot prescribe a medicine quantity of more than 100. Please adjust the days to accommodate the quantity")
				$tds.eq(5).find(":input").val(0);
				}
			else
				{
					$tds.eq(5).find(":input").val(t);
				}
			
	    }
		// $(').closest('tr').find("td:eq(5)").find(":input").val(total)
		// $(item).closest('tr').find("td:eq(5)").find(":input").val(total)
		// $('$tds.eq(5)').val($(this).val());
		// alert("total value" + total)

	});
    
	// console.log(TableData);
}

function fillValueNomenclatureTemplate() {
	$('.modal-backdrop').hide();
	$('#messageForTreatmentAlertTreatment').hide();
	var TableData = new Array();
    $('#nomenclatureGridTemplate tr').each(function(i, el) {

		var $tds = $(this).find('td')
		var itemClassId = $tds.eq(12).find(":input").val();
    	
    	var itemClassIdTablet="3";
        var itemClassIdCapusle="4";
        var itemClassIdInjection="5";
        if(itemClassId==itemClassIdTablet || itemClassId==itemClassIdCapusle || itemClassId==itemClassIdInjection)
	    {
		var productId = $tds.eq(0).find(":input").val();
		var product = $tds.eq(1).find(":input").val();
		var dosage = $tds.eq(2).find(":input").val();
		var frequency = $tds.eq(3).find(":input").val();
		var splitFrequency = frequency.split("@");
		var noofdays = $tds.eq(4).find(":input").val();
		var Quantity2 = $tds.eq(5).find(":input").val();
		var product3 = $tds.eq(4).find(":input").val();
		var total = dosage * splitFrequency[0] * noofdays;
		var t=Math.round(total);
		$tds.eq(5).find(":input").val(t);
		}
		// $(').closest('tr').find("td:eq(5)").find(":input").val(total)
		// $(item).closest('tr').find("td:eq(5)").find(":input").val(total)
		// $('$tds.eq(5)').val($(this).val());
		// alert("total value" + total)

	});

	// console.log(TableData);
}

function updateTemplate(item) {
		$('.modal-backdrop').hide();
		$('#messageForTreatmentAlertUpdateTreatment').hide();
		//var $tds = $(item).closest('tr').find('td')
		var itemClassId = $(item).closest('tr').find("td:eq(12)").find(":input").val();
   	    var itemClassIdTablet="3";
        var itemClassIdCapusle="4";
        var itemClassIdInjection="5";
        if(itemClassId==itemClassIdTablet || itemClassId==itemClassIdCapusle || itemClassId==itemClassIdInjection)
	    {
		var dosage = $(item).closest('tr').find("td:eq(2)").find(":input").val();
		var frequency = $(item).closest('tr').find("td:eq(3)").find(":input").val();
		var splitFrequency = frequency.split("@");
		var noofdays = $(item).closest('tr').find("td:eq(4)").find(":input").val();
		var Quantity2 = $(item).closest('tr').find("td:eq(5)").find(":input").val();
		var product3 = $(item).closest('tr').find("td:eq(4)").find(":input").val();
		var total = dosage * splitFrequency[0] * noofdays;
		var t=Math.round(total);
		$(item).closest('tr').find("td:eq(5)").find(":input").val(t);
		}
		// $(').closest('tr').find("td:eq(5)").find(":input").val(total)
		// $(item).closest('tr').find("td:eq(5)").find(":input").val(total)
		// $('$tds.eq(5)').val($(this).val());
		// alert("total value" + total)

	// console.log(TableData);
}


function fillValue(inc) {

	var noOfDays = document.getElementById('noOfDays' + inc).value
	var dosage = document.getElementById('dosage' + inc).value
	var freq = document.getElementById('frequencyValue' + inc).value
	var dispenseQty = document.getElementById('actualDispensingQty' + inc).value;
	var sosQty = document.getElementById('sosQty' + inc).value;
	var itemClassCode = document.getElementById('itemClassCode' + inc).value;
	var total = freq * noOfDays * dosage;
	console.log("total="+total)
	if (document.getElementById('actualDispensingQty' + inc).value != 0) {
		for (var i = 0; i < itemClassCodeArray.length; i++) {
			if (itemClassCodeArray[i][0] == itemClassCode) {
				// dosage = Math.ceil(dosage*1/10);
				total = Math.ceil(total * 1 / 10);
				break;
			}
		}
	}

	var finalQty;

	if (document.getElementById('frequency' + inc).value != 13) {
		if (document.getElementById('actualDispensingQty' + inc).value != 0) {

			var totalQty = (parseFloat(total) / parseFloat(dispenseQty))
					.toFixed(2)
			// alert(totalQty);
			if (totalQty != '0.00') {
				finalQty = Math.ceil(totalQty);
			} else {
				finalQty = 1;
			}

			document.getElementById('total' + inc).value = finalQty;
			if (finalQty > 2)
				alert("Total quantity  is more than 2");
		} else {
			document.getElementById('total' + inc).value = freq * noOfDays
					* dosage
		}
		// document.getElementById('noOfDays'+inc).disabled = false;
		// document.getElementById('sosQty'+inc).disabled = true;
	} else {
		if (document.getElementById('actualDispensingQty' + inc).value != 0) {
			// commented for sos var totalQty =
			// (parseFloat(freq*sosQty*dosage)/parseFloat(dispenseQty)).toFixed(2)
			// alert(document.getElementById('total'+inc).value
			// +"noOfDays="+noOfDays);
			var totalQty = (parseFloat(freq * noOfDays * dosage) / parseFloat(dispenseQty))
					.toFixed(2);
			if (totalQty != '0.00') {
				finalQty = Math.ceil(totalQty);
			}
			document.getElementById('total' + inc).value = finalQty;
		} else {
			// commented for sos
			// document.getElementById('total'+inc).value=freq*sosQty*dosage
			document.getElementById('total' + inc).value = freq * noOfDays
					* dosage
		}
		// document.getElementById('noOfDays'+inc).disabled = true;
		// document.getElementById('sosQty'+inc).disabled = false;

	}
	
	console.log("finalQty="+finalQty)

}


function displaySOSQty(val, inc) {

	/*
	 * if(val == '13'){ document.getElementById('sosQty'+inc).style.display =
	 * 'block'; document.getElementById('noOfDays'+inc).disabled = true; }else{
	 * 
	 * document.getElementById('sosQty'+inc).style.display = 'none';
	 * document.getElementById('noOfDays'+inc).disabled = false; }
	 */
}

function checkHighValueMedicine(pvmsNo, inc, hinid) {

	if (pvmsNo != ""
			&& document.getElementById('highValueMedicine' + inc).value == 'y') {

		/*
		 * var index1 = val.lastIndexOf("["); var indexForBrandName=index1; var
		 * index2 = val.lastIndexOf("]"); index1++; var pvmsNo =
		 * val.substring(index1,index2);
		 */

		if (pvmsNo == "") {
			document.getElementById('nomenclature' + inc).value = "";
			document.getElementById('pvmsNo' + inc).value = "";
			return;
		} else
			var xmlHttp;
		try {
			// Firefox, Opera 8.0+, Safari
			xmlHttp = new XMLHttpRequest();
		} catch (e) {
			// Internet Explorer
			try {
				xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				alert(e)
				try {
					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {
					alert("Your browser does not support AJAX!");
					return false;
				}
			}
		}

		xmlHttp.onreadystatechange = function() {
			if (xmlHttp.readyState == 4) {
				var items = xmlHttp.responseXML.getElementsByTagName('items')[0];
				for (loop = 0; loop < items.childNodes.length; loop++) {
					var item = items.childNodes[loop];

					var highValueMedicine = item
							.getElementsByTagName("highValueMedicine")[0];
					if (highValueMedicine.childNodes[0] != undefined
							&& highValueMedicine.childNodes[0].nodeValue == 'true') {
						document.getElementById('highValueMedicine' + inc).value = 'y';

					} else {
						alert("This is high Value Medicine")

						document.getElementById('highValueMedicine' + inc).value = 'n';
						document.getElementById('nomenclature' + inc).value = ""
						document.getElementById('pvmsNo' + inc).value = "";
						var e = eval(document.getElementById('nomenclature'
								+ inc));
						e.focus();

					}

				}
			}
		}
		var url = "/hms/hms/opd?method=checkHighValueMedicine&pvmsNo=" + pvmsNo
				+ "&hinId=" + hinid;
		xmlHttp.open("GET", url, true);
		xmlHttp.setRequestHeader("Content-Type", "text/xml");
		xmlHttp.send(null);
	}
}


function displayAupTab(val, inc) {
	if (val != "") {
		var index1 = val.lastIndexOf("[");
		var indexForBrandName = index1;
		var index2 = val.lastIndexOf("]");
		index1++;
		var pvmsNo = val.substring(index1, index2);
		var indexForBrandName = indexForBrandName--;
		var brandName = val.substring(0, indexForBrandName);
		if (pvmsNo == "") {
			document.getElementById('nomenclaturepTab' + inc).value = "";
			document.getElementById('pvmsNopTab' + inc).value = "";
			return;
		} else
			var xmlHttp;
		try {
			// Firefox, Opera 8.0+, Safari
			xmlHttp = new XMLHttpRequest();
		} catch (e) {
			// Internet Explorer
			try {
				xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				alert(e)
				try {
					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {
					alert("Your browser does not support AJAX!");
					return false;
				}
			}
		}

		xmlHttp.onreadystatechange = function() {
			if (xmlHttp.readyState == 4) {
				var items = xmlHttp.responseXML.getElementsByTagName('items')[0];
				for (loop = 0; loop < items.childNodes.length; loop++) {
					var item = items.childNodes[loop];

					var au = item.getElementsByTagName("au")[0];
					var actualDispensingQty = item
							.getElementsByTagName("actualDispensingQtypTab")[0];
					var stock = item.getElementsByTagName("stock")[0];

					if (document.getElementById('au' + inc)
							&& au.childNodes[0] != undefined) {
						document.getElementById('au' + inc).value = au.childNodes[0].nodeValue;
					}
					/*
					 * if(document.getElementById('closingStock'+inc) &&
					 * stock.childNodes[0] != undefined){
					 * document.getElementById('closingStock'+inc).value =
					 * stock.childNodes[0].nodeValue;
					 * if(stock.childNodes[0].nodeValue == 0){ alert("Stock is
					 * not available..."); } }else{ }
					 */
					if (document
							.getElementById('actualDispensingQtypTab' + inc)) {
						if (actualDispensingQty.childNodes[0] != undefined) {
							document
									.getElementById('actualDispensingQty' + inc).value = actualDispensingQty.childNodes[0].nodeValue;
						} else {
							document.getElementById('actualDispensingQtypTab'
									+ inc).value = 0;

						}
					}
					var dangerousDrug = item
							.getElementsByTagName("dangerousDrug")[0];
					if (dangerousDrug.childNodes[0] != undefined
							&& dangerousDrug.childNodes[0].nodeValue == 'y') {
						alert("This drug is dangerous.");
					}
				}
			}
		}
		var url = "/hms/hms/opd?method=displayAU&pvmsNo=" + pvmsNo + "&"
				+ csrfTokenName + "=" + csrfTokenValue;
		xmlHttp.open("GET", url, true);
		xmlHttp.setRequestHeader("Content-Type", "text/xml");
		xmlHttp.send(null);
	}
}

function parent_disable() {
	if (newwindow && !newwindow.closed)
		newwindow.focus();
}
function showPatientHistory(hinNo, csrf) {
	var visitId = document.getElementById("visitId").value;
	var url = '/hms/hms/enquiry?method=showPatientDetails&hinNo=' + hinNo
			+ '&visitId=' + visitId + '&' + csrf + '&' + csrfTokenName + '='
			+ csrfTokenValue;
	newwindow = window
			.open(url, 'opd_window',
					"left=100,top=10,height=630,width=1024,status=1,scrollbars=yes,resizable=0");

}

function showImmunization(hinNo) {
	document.opdMain.action = "/hms/hms/opd?method=showImmunization&hinNo="
			+ hinNo;
	document.opdMain.submit();
}

function showPreviousStudentVisit(hinId) {
	document.opdMain.action = "/hms/hms/opd?method=showStudentPreviousVisit&hinId=<%=visit.getHin().getId()%>";
	document.opdMain.submit();
}
function openPopupForPatientInvestigation(visitNo, hinId, csrf) {
	if (visitNo > 1) {
		var chargeCodeName1 = document.getElementById("chargeCodeName1").value;
		var url = "/hms/hms/opd?method=showPatientPreviousInvestigation&chargeCodeName1="
				+ chargeCodeName1
				+ "&visitNo="
				+ visitNo
				+ "&hinId="
				+ hinId
				+ "&" + csrf + "&" + csrfTokenName + "=" + csrfTokenValue;
		newwindow = window.open(url, 'name',
				"height=300,width=800,status=1,scrollbars=yes");
	} else {
		alert("This is Patient's First Visit. ")
	}
}

function openPopupForOphthalmology(url) {

	var height = 450;
	var width = 1170;
	var left = (screen.width / 2) - (width / 2);
	var top = (screen.height / 2) - (height / 2);
	url = url + '&' + csrfTokenName + '=' + csrfTokenValue;
	window.open(url, "Patient Details",
			"resizable=0,scrollbars=no, status = no, height = " + height
					+ ", width =" + width + ",top=" + top + ", left=" + left);

}


/* for prescription tab tab Start */
/*
 * function fillValuepTab(value,inc){ var dosage =
 * document.getElementById('dosagepTab'+inc).value var
 * freq=document.getElementById('frequencyValuepTab'+inc).value; var
 * noOfDays=document.getElementById('noOfDayspTab'+inc).value var dispenseQty =
 * document.getElementById('actualDispensingQtypTab'+inc).value; var sosQty =
 * document.getElementById('sosQtypTab'+inc).value; var total =
 * freq*noOfDays*dosage; var finalQty;
 * if(document.getElementById('frequencypTab'+inc).value != 13 ){
 * if(document.getElementById('actualDispensingQtypTab'+inc).value != 0){ var
 * totalQty = (parseFloat(total)/parseFloat(dispenseQty)).toFixed(2) if(totalQty !=
 * '0.00'){ finalQty = Math.ceil(totalQty); }
 * document.getElementById('totalpTab'+inc).value=finalQty; }else{
 * document.getElementById('totalpTab'+inc).value=freq*value*dosage; } }else{
 * if(document.getElementById('actualDispensingQtypTab'+inc).value != 0){ var
 * totalQty =
 * (parseFloat(freq*sosQty*dosage)/parseFloat(dispenseQty)).toFixed(2)
 * if(totalQty != '0.00'){ finalQty = Math.ceil(totalQty); }
 * document.getElementById('totalpTab'+inc).value=finalQty; }else{
 * document.getElementById('totalpTab'+inc).value=freq*sosQty*dosage; } } }
 */

function displaySOSQtypTab(val, inc) {
	if (val == '13') {
		document.getElementById('sosQtypTab' + inc).style.display = 'block';
		document.getElementById('noOfDayspTab' + inc).disabled = true;
	} else {

		document.getElementById('sosQtypTab' + inc).style.display = 'none';
		document.getElementById('noOfDayspTab' + inc).disabled = false;
	}
}




function populatePvmsNo(val, inc) {
	if (val != "") {
		var index1 = val.lastIndexOf("[");
		var indexForBrandName = index1;

		var index2 = val.lastIndexOf("]");

		index1++;
		var pvmsNo = val.substring(index1, index2);

		var indexForBrandName = indexForBrandName--;
		var brandName = val.substring(0, indexForBrandName);

		var index3 = brandName.lastIndexOf("[");
		index3++;
		var index4 = brandName.lastIndexOf("]");
		var itemId = val.substring(index3, index4);
		if (pvmsNo == "") {
			document.getElementById('nomenclature' + inc).value = "";
			document.getElementById('pvmsNooo' + inc).value = "";
			document.getElementById('itemId' + inc).value = "";
			return;
		} else
			document.getElementById('pvmsNooo' + inc).value = pvmsNo;
		document.getElementById('itemId' + inc).value = itemId;

	}
}

function calculateTotalDispensingPrice() {
	var cnt = document.getElementById('hdb').value;
	var totalDispPrice = 0;
	for (var i = 1; i <= cnt; i++) {
		if (document.getElementById("dispensingPrice" + i) != null) {
			if (document.getElementById("dispensingPrice" + i).value != "")
				totalDispPrice = parseFloat(totalDispPrice)
						+ (parseFloat(document.getElementById("dispensingPrice"
								+ i).value) * parseFloat(parseFloat(document
								.getElementById("total" + i).value)));
		}
	}
	document.getElementById("totalDispPrice").value = totalDispPrice;
}

function calculateTotalRate() {
	var cntRate = document.getElementById('hiddenValue').value;
	var totalRate = 0;
	for (var i = 1; i <= cntRate; i++) {
		if (document.getElementById("rate" + i) != null) {
			if (document.getElementById("rate" + i).value != "")
				totalRate = parseFloat(totalRate)
						+ (parseFloat(document.getElementById("rate" + i).value));
		}
	}
	document.getElementById("totalRate").value = totalRate;
}

function displayPhAlert(val, i) {
	if (document.getElementById('alertToStaff' + i).checked == true) {
		document.getElementById('phAlert' + i).style.display = 'inline';
	} else {
		document.getElementById('phAlert' + i).style.display = 'none';
	}

}


var lastRow;
var i=0;
function addRowForInvestigation(){
	    i++
	    var aClone = $('#dgInvetigationGrid>tr:last').clone(true);
		aClone.find(":input").val("");
	    aClone.find('input[type="text"]').prop('id', 'chargeCodeName'+i+'');
	    aClone.find("td:eq(0)").find("div").find("div").prop('id', 'investigationDivOpd' + i + '');
		aClone.find("td:eq(1)").find(":input").prop('id', 'inestigationIdval'+i+'');
		aClone.find("td:eq(4)").find(":input").prop('id', 'invetgationAuditFlag'+i+'');
		aClone.clone(true).appendTo('#dgInvetigationGrid');
		var valInvestigation = $('#dgInvetigationGrid>tr:last').find("td:eq(0)").find(":input")[0];
		
		if(arryInvestigation!=null && arryInvestigation!="" )
		{
		arrayData=[];	
		//autocomplete(valInvestigation, arryInvestigation);
		}
		else
		{
		arryInvestigation=[];	
		//autocomplete(valInvestigation, arrayData);
		}
		
		
		    		    		
		  var tbl = document.getElementById('dgInvetigationGrid');
   	  lastRow = tbl.rows.length;
   
}



function getDetails() {
	var hinId = document.getElementById("hinId").value;
	var visitId = document.getElementById("visitId").value;
	var url = "/hms/hms/opd?method=getTodayOtherPrescription&visitId="
			+ visitId + "&hinId=" + hinId + "&" + csrfTokenName + "="
			+ csrfTokenValue;
	newwindow = window.open(url, 'name', 'height=500,width=800,status=1');
	return false;

}

function getTodayAllPrescriptionPopup(hinId, bufferingFlag, backFlag) {

	// var
	// url="/hms/hms/opd?method=getTodayOtherPrescription&visitId="+visitId+"&hinId="+hinId+"&"+csrfTokenName+"="+csrfTokenValue;
	var p = "";
	if (bufferingFlag != undefined && bufferingFlag == 'y')
		p = bufferingFlag;
	var url = "/hms/hms/opd?method=getTodayOtherPrescription&hinId=" + hinId
			+ "&bufferingFlag=" + p + "&backFlag=" + backFlag;
	newwindow = window.open(url, 'name', 'height=500,width=1000,status=1');
	return false;

}

function getTodayAllPrescriptionPopupForIPD(hinId, bufferingFlag) {
	// var
	// url="/hms/hms/opd?method=getTodayOtherPrescription&visitId="+visitId+"&hinId="+hinId+"&"+csrfTokenName+"="+csrfTokenValue;
	var p = "";
	if (bufferingFlag != undefined && bufferingFlag == 'y')
		p = bufferingFlag;
	var url = "/hms/hms/opd?method=getTodayOtherPrescriptionForIPD&hinId="
			+ hinId + "&bufferingFlag=" + p;
	newwindow = window.open(url, 'name', 'height=500,width=1000,status=1');
	return false;
}

function previousSystemPatientPrescriptions() {
	var hinNo = document.getElementById("hinNo").value;
	var url = "/hms/hms/opd?method=showPreviousSystemPatientPrescriptions&hinNo="
			+ hinNo + "&" + csrfTokenName + "=" + csrfTokenValue;
	newwindow = window.open(url, 'opd_window',
			"height=300,width=750,status=1,scrollbars=yes");
}

function checkForAlreadyIssuedPrescription(val, inc) {
	//
	// var value1=document.getElementsByName('nomenclature'+inc).value;
	// alert(val+"<<<-------val======inc------>>"+value1);

	var hinId = document.getElementById("hinId").value;
	var id;
	if (val != "") {

		var xmlHttp;
		try {
			// Firefox, Opera 8.0+, Safari
			xmlHttp = new XMLHttpRequest();
		} catch (e) {
			// Internet Explorer
			try {
				xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				alert(e)
				try {
					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {
					alert("Your browser does not support AJAX!");
					return false;
				}
			}
		}

		xmlHttp.onreadystatechange = function() {
			if (xmlHttp.readyState == 4) {
				var b = "false";
				var items = xmlHttp.responseXML.getElementsByTagName('items')[0];
				for (loop = 0; loop < items.childNodes.length; loop++) {
					var item = items.childNodes[loop];
					var dupl = item.getElementsByTagName('alreadyIssued1')[0];
					// alert("icdString"+icdString);
					b = dupl.childNodes[0].nodeValue
					// alert("b-->>"+b);

					// var val=document.getElementById('icd').value;
					/*
					 * var index1 = val.lastIndexOf("["); var index2 =
					 * val.lastIndexOf("]"); index1++; id =
					 * val.substring(index1,index2); //alert("id------>>>"+id);
					 * if(id ==""){ return; }
					 */
					if (b == 'true') {
						alert(" Already Prescribed to Patient!!");
						document.getElementById('nomenclature' + inc).value = "";
						document.getElementById('itemId' + inc).value = "";
						document.getElementById('closingStock' + inc).value = "";
					}
				}

			}
		}
		// var
		// url="/hms/hms/opd?method=getIcdWithIcdCode&icdCode="+encodeURIComponent(icdCode)

		// var
		// url="/hms/hms/opd?method=checkForAlreadyIssuedPrescribtion&val="+val+"&visitId="+visitId+"&"+csrfTokenName+"="+csrfTokenValue;
		var url = "/hms/hms/opd?method=checkForAlreadyIssuedPrescription&val="
				+ encodeURIComponent(val) + "&hinId=" + hinId;
		xmlHttp.open("GET", url, true);
		xmlHttp.setRequestHeader("Content-Type", "text/xml");
		xmlHttp.send(null);

	} else {
		document.getElementById('itemId' + inc).value = "";
	}

}

function checkForAlreadyPrescribedInvestigation(val, inc, hinId) {
	//
	// var value1=document.getElementsByName('nomenclature'+inc).value;
	// alert(val+"<<<-------val======inc------>>"+value1);

	// var visitId=document.getElementById("visitId").value;
	if (investigationDateCheck(inc)) {

		var investigationDate;
		if (document.getElementById("investigationDate" + inc) != null)
			investigationDate = document.getElementById("investigationDate"
					+ inc).value;
		else
			investigationDate = document.getElementById("consultationDate").value;

		var id;
		if (val != "") {

			var xmlHttp;
			try {
				// Firefox, Opera 8.0+, Safari
				xmlHttp = new XMLHttpRequest();
			} catch (e) {
				// Internet Explorer
				try {
					xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
				} catch (e) {
					alert(e)
					try {
						xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
					} catch (e) {
						alert("Your browser does not support AJAX!");
						return false;
					}
				}
			}

			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					var b = "false";
					var items = xmlHttp.responseXML
							.getElementsByTagName('items')[0];
					for (loop = 0; loop < items.childNodes.length; loop++) {
						var item = items.childNodes[loop];
						var dupl = item.getElementsByTagName('alreadyIssued1')[0];
						// alert("icdString"+icdString);
						b = dupl.childNodes[0].nodeValue
						// alert("b-->>"+b);

						// var val=document.getElementById('icd').value;
						/*
						 * var index1 = val.lastIndexOf("["); var index2 =
						 * val.lastIndexOf("]"); index1++; id =
						 * val.substring(index1,index2);
						 * //alert("id------>>>"+id); if(id ==""){ return; }
						 */

						if (b == 'true') {
							alert("Already Prescribed to Patient!!");
							document.getElementById('chargeCodeName' + inc).value = "";

						}
					}

				}
			}
			// var
			// url="/hms/hms/opd?method=getIcdWithIcdCode&icdCode="+encodeURIComponent(icdCode)

			// var
			// url="/hms/hms/opd?method=checkForAlreadyIssuedPrescribtion&val="+val+"&visitId="+visitId+"&"+csrfTokenName+"="+csrfTokenValue;
			var url = "/hms/hms/opd?method=checkForAlreadyPrescibedInvestigation&val="
					+ encodeURIComponent(val)
					+ "&hinId="
					+ hinId
					+ "&investigationDate=" + investigationDate;

			xmlHttp.open("GET", url, true);
			xmlHttp.setRequestHeader("Content-Type", "text/xml");
			xmlHttp.send(null);

		} else {
			// document.getElementById('chargeCodeName'+inc).value="";
		}

	}
}

function investigationDateCheck(inc) {

	var date = investigationDate = document.getElementById("investigationDate"
			+ inc).value;
	var parts = date.split('/');
	var selectedDate = new Date(parts[2], parts[1] - 1, parts[0]);
	var now = new Date();

	now.setHours(0, 0, 0, 0);
	if (selectedDate < now) {
		alert("Can't give investigation for back date");
		document.getElementById("investigationDate" + inc).value = "";
		return false;
	} else {
		return true;
	}
}

function checkForContradiction(val, inc) {

	var itemIdArray = "";
	for (i = 1; i <= inc; i++) {

		if (inc != i) {
			if (document.getElementById('itemId' + i)
					&& document.getElementById('itemId' + i).value != "") {
				itemIdArray = itemIdArray
						+ document.getElementById('itemId' + i).value + ",";
			}
		}
	}

	var index1 = val.lastIndexOf("[");
	var index2 = val.lastIndexOf("]");
	index1++;
	var pvms = val.substring(index1, index2);

	if (val != "") {

		var xmlHttp;
		try {
			// Firefox, Opera 8.0+, Safari
			xmlHttp = new XMLHttpRequest();
		} catch (e) {
			// Internet Explorer
			try {
				xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				alert(e)
				try {
					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {
					alert("Your browser does not support AJAX!");
					return false;
				}
			}
		}

		xmlHttp.onreadystatechange = function() {
			if (xmlHttp.readyState == 4) {
				var b = "false";
				var items = xmlHttp.responseXML.getElementsByTagName('items')[0];
				for (loop = 0; loop < items.childNodes.length; loop++) {
					var item = items.childNodes[loop];
					var str = item.getElementsByTagName('returnString')[0];

					b = str.childNodes[0].nodeValue;

					if (b != 'null') {
						alert(b);
					}
				}

			}
		}
		// var
		// url="/hms/hms/opd?method=getIcdWithIcdCode&icdCode="+encodeURIComponent(icdCode)

		// var
		// url="/hms/hms/opd?method=checkForAlreadyIssuedPrescribtion&val="+val+"&visitId="+visitId+"&"+csrfTokenName+"="+csrfTokenValue;
		var url = "/hms/hms/opd?method=checkForContradiction&pvms=" + pvms
				+ "&itemIdArray=" + itemIdArray;
		xmlHttp.open("GET", url, true);
		xmlHttp.setRequestHeader("Content-Type", "text/xml");
		xmlHttp.send(null);

	}

}


function checkReferTO(id) {
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

function checkReferTOIPD(id) {
	if (document.getElementById('referInternal').checked == true) {
		// document.getElementById('referdistrictLabel').style.display='none';
		// document.getElementById('referHospitalTypeLabel').style.display='none';
		/*
		 * document.getElementById('priorityLabelId').style.display='block';
		 * document.getElementById('priorityId').style.display='block';
		 */
		// document.getElementById('referdistrict').style.display='none';
		// document.getElementById('referHospitalType').style.display='none';
		document.getElementById('referhospitalLabel').style.display = 'none';
		document.getElementById('referhospital').style.display = 'none';
		document.getElementById('referdayslLabel').style.display = 'none';
		document.getElementById('referdays').style.display = 'none';

		document.getElementById('referdepartmentLabel').style.display = 'block';
		document.getElementById('referdepartment').style.display = 'block';
		document.getElementById('refereddoctorlabel').style.display = 'block';
		document.getElementById('refereddoctor').style.display = 'block';

		fnGetHospitalWards(document.getElementById("hospitalId").value);
	} else {
		// document.getElementById('referdistrictLabel').style.display='block';

		// document.getElementById('referdistrict').style.display='block';
		// document.getElementById('referHospitalType').style.display='block';
		// document.getElementById('referHospitalTypeLabel').style.display='block';
		document.getElementById('referhospitalLabel').style.display = 'block'
		document.getElementById('referhospital').style.display = 'block';
		/*
		 * document.getElementById('priorityLabelId').style.display='none';
		 * document.getElementById('priorityId').style.display='none';
		 */
		document.getElementById('referdepartmentLabel').style.display = 'none';
		document.getElementById('referdepartment').style.display = 'none';
		document.getElementById('referdayslLabel').style.display = 'block';
		document.getElementById('referdays').style.display = 'block';

		document.getElementById('referdepartmentLabel').style.display = 'none';
		document.getElementById('referdepartment').style.display = 'none';
		document.getElementById('refereddoctorlabel').style.display = 'none';
		document.getElementById('refereddoctor').style.display = 'none';
		if (document.getElementById("referCheck") == null)
			document.getElementById("referdepartment").options.length = 1;
	}
}

function ValidateCantra() {
	var ids = "";
	var cantraCounter = 0;

	jQuery(function($) {
		var code2 = "";
		$("select[name='diagnosisId'] > option").each(function() {
			if (code2 == "") {
				code2 = this.value;
			} else {
				code2 = this.value + "," + code2;
			}

		});

		for (; cantraCounter <= $("#hdb").val(); cantraCounter++) {
			if (document.getElementById("nomenclature" + cantraCounter) != undefined
					&& $("#nomenclature" + cantraCounter).val() != "") {
				var nomenclature = $("#nomenclature" + cantraCounter).val();
				var index1 = nomenclature.lastIndexOf("[");
				var index2 = nomenclature.lastIndexOf("]");
				index1++;
				ids = nomenclature.substring(index1, index2) + "," + ids;
				var matchIds = nomenclature.substring(index1, index2)
				var matchPres = nomenclature.substring(0, (index1 - 1));
				$.post('opd?method=checkDrugCantraIndicative&ids=' + ids
						+ "&code2=" + code2 + "&hinId="
						+ document.getElementById("hinId").value + "&"
						+ csrfTokenName + "=" + csrfTokenValue, function(data) {
					try {
						var dt = "";
						if (data != "") {
							$("#cantralabel").show();
							$("#cantraMsg").html(data);
						} else {
							$("#cantraMsg").html("");
							$("#cantralabel").hide();
						}
					} catch (e) {
						alert(e);
					}
				});
			}
		}
	});
}

function checkAdmte() {
	var dob = document.getElementById('admissionDate').value;
	adDate = new Date(dob.substring(6), (dob.substring(3, 5) - 1), dob
			.substring(0, 2));
	currentDate = new Date();
	var month = currentDate.getMonth() + 1
	var day = currentDate.getDate()
	var year = currentDate.getFullYear()
	var seperator = "/"
	currentDate = new Date(month + seperator + day + seperator + year);

	if (adDate < currentDate) {
		alert("Admission Date is not valid.");
		document.getElementById('admissionDate').value = document
				.getElementById("consultationDate").value;
		document.getElementById('admissionDate').focus();
		return false;
	}
	return true;

}

var pvmsNo = '';
function populatePVMS(val, inc,item) {
	//alert("called");
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
			document.getElementById('pvmsNo' + inc).value = pvmsNo
			  var pvmsValue = '';
			  var dispunitIddd='';
			  var masFrequencyId='';
			  var  masDosage='';
			  var  masNoOfDays='';
	     	  for(var i=0;i<autoVsPvmsNo.length;i++){
	     		 // var pvmsNo1 = data[i].pvmsNo;
	     		 var masItemIdValue= autoVsPvmsNo[i];
	     		 var pvmsNo1=masItemIdValue[1];
	     		 var itemClassId=masItemIdValue[5];
	     		  if(pvmsNo1 == pvmsNo){
	     			  pvmsValue = masItemIdValue[3];//data[i].dispUnit;
	     			 dispunitIddd=masItemIdValue[6];
	     			masFrequencyId=masItemIdValue[7];
	     			masDosage=masItemIdValue[8];
	     			masNoOfDays=masItemIdValue[9];
	     			  itemIdPrescription =masItemIdValue[0]; //data[i].itemId;
	     			  itemIds = itemIdPrescription;
	     			var checkCurrentNomRowId=$(item).closest('tr').find("td:eq(8)").find("input:eq(0)").attr("id");
      			    var checkCurrentNomRowVal=$(item).closest('tr').find("td:eq(8)").find("input:eq(0)").val();  
	     			$('#nomenclatureGrid tr').each(function(i, el) {
	     			   var $tds = $(this).find('td')
	  			       var itemIdCheck=  $($tds).closest('tr').find("td:eq(8)").find("input:eq(0)").attr("id");
	     			   var itemIdValue=$('#'+itemIdCheck).val();
	     			   var idddd =$(item).closest('tr').find("td:eq(10)").find("input:eq(0)").attr("id");
	     			   var currentidddd=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
	     			   //if(itemIds!="" &&  itemIdValue!="" && itemIdValue!="undefined" )
	     			   if(itemIdCheck!=checkCurrentNomRowId && itemIds==itemIdValue)	   
 			           {
	     				 if(itemIds==itemIdValue){
	      			        $('#'+idddd).val("");
	      			        $('#'+currentidddd).val("");
	      			        alert("Drug is already added");
	      			        return false;
	     				   
 			           }
 			           }
	     			   else
	     			   {
	     				  var patientSymAuditId=$('#patientSymAuditId').val()
	     				  var array = patientSymAuditId.split(',');
							array.sort(function(a, b) {
								  return a - b;
								});
							 $('#patientSymAuditId').val(array);
							 patientSymAuditId=$('#patientSymAuditId').val();
	     				 if(patientSymAuditId!=null &&patientSymAuditId!='')
	     			        {
	     					    var pathname = window.location.pathname;
	     						var accessGroup = "MMUWeb";
	     						var url = window.location.protocol + "//"
	     						+ window.location.host + "/" + accessGroup
	     						+ "/opd/getAITreatmentDetail";
	     						$
	     								.ajax({
	     									url : url,
	     									dataType : "json",
	     									data : JSON.stringify({
	     										"patientSympotnsId":patientSymAuditId,
	     										"treatmentId":itemIds
	     									}),
	     									contentType : "application/json",
	     									type : "POST",
	     									success : function(response) {
	     									console.log(response);
	     									var data=response.data;
	     								    if(data[0].treatmentCount>0)
	     									 {
	     								    	 $('#msgForAITreatment').show();
	     								    	 $('#currentTreatRowItem').val(val);
	     								    	$('#submitMOValidateFormByModelTreatmentId').val(val);
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
	     				  $(item).closest('tr').find("td:eq(1)").find("select:eq(0)").val(dispunitIddd);
		       	          $(item).closest('tr').find("td:eq(8)").find(":input").val(itemIds)
		       	           $(item).closest('tr').find("td:eq(2)").find(":input").val(masDosage)
		       	            $(item).closest('tr').find("td:eq(3)").find("select:eq(0)").val(masFrequencyId)
		       	            $(item).closest('tr').find("td:eq(4)").find(":input").val(masNoOfDays)
	       	     	         $(item).closest('tr').find("td:eq(12)").find(":input").val(itemClassId)
	       	     	    	 $(item).closest('tr').find("td:eq(5)").find(":input").val("")
	       	     	    	
	       	     	    	 var itemClassIdTablet=3;
		       	          	 var itemClassIdCapusle=4;
		       	             var itemClassIdInjection=5;
		       	            if(itemClassId!=itemClassIdTablet && itemClassId!=itemClassIdCapusle && itemClassId!=itemClassIdInjection)
	       	     	    	{
	       	     	    		$(item).closest('tr').find("td:eq(5)").find(":input").val("1")
	       	     	    	}
		       	           	else
	       	     	    	{	
	       	     	    	var total = masDosage * masFrequencyId * masNoOfDays;
		       	          	var t=Math.round(total);
		       	            $(item).closest('tr').find("td:eq(5)").find(":input").val(t)
	       	     	    	}
	       	     	    	 //setTimeout(fillValueNomenclature, 2000);
	       	     	     	 
	     			   }	   
	     			   if(pvmsNo!=null &&pvmsNo!='')
	     		        {
	     				    var pathname = window.location.pathname;
	     					var accessGroup = "MMUWeb";
	     					var url = window.location.protocol + "//"
	     					+ window.location.host + "/" + accessGroup
	     					+ "/dispencery/getAvailableStock";
	     					
	     					/*
	     					 * var url =
	     					 * "http://localhost:8181/AshaServices/v0.1/opdmaster/getMasFrequency";
	     					 */
	     					$
	     							.ajax({
	     								url : url,
	     								dataType : "json",
	     								data : JSON.stringify({
	     									"itemId":itemIds,
	     									"mmuId1":hsId,
	     									"flag":"OPD",
	     									"departmentId":$('#departmentId').val()
	     								}),
	     								contentType : "application/json",
	     								type : "POST",
	     								success : function(response) {
	     									console.log(response);
	     									var availableStock=response.availableStock;
	     									
	     									var exp_dt = response.expiry_date; // 30/06/25
	     									
	     									var exp_dt = response.expiry_date; // Example: '30/06/25'
	     									
	     									
	     									if(availableStock!=undefined && availableStock!=0)
	     									{	
	     									$(item).closest('tr').find("td:eq(7)").find(":input").val(availableStock)
	     									$(item).closest('tr').find("td:eq(0)").find(":input").css('border', '1px solid #ced4da');
	     									
				     									if (isExpiryWithinThreeMonths(exp_dt)) {
			 									    		console.log("Expiry date is within 3 months.");
			 									   			$(item).closest('tr').find("td:eq(0)").find(":input").css('border', '5px solid yellow');
			     									} 																
	     									}
	     									if(availableStock==0)
	     									{
	     										$(item).closest('tr').find("td:eq(0)").find(":input").css('border', '5px solid red');
	     										$(item).closest('tr').find("td:eq(7)").find(":input").val(availableStock)
	     										
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

function clearAiTreatment(val)
{
	var currentValue=val;
	$('#nomenclatureGrid tr').each(function(i, el) {
	  var $tds = $(this).find('td')
	        var chargeCodeId=   $($tds).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
	        var chargeCodeIdValue=$('#'+chargeCodeId).val();
	        var chargeCodeIdSecond=   $($tds).closest('tr').find("td:eq(8)").find("input:eq(0)").attr("id");
	        if(currentValue==chargeCodeIdValue)
	        {	
	      		$('#'+chargeCodeId).val("");
	        	$('#'+chargeCodeIdSecond).val("");
	        }
	     			        	
	   });
	$('#msgForAITreatment').hide();
	$('.modal-backdrop').hide();
}

var nursingNo = '';
function populateNursing(val, inc,item) {
    
	if (val != "") {
		var index1 = val.lastIndexOf("[");
		var indexForBrandName = index1;
		var index2 = val.lastIndexOf("]");
		index1++;
		var str = val.substring(index1, index2);;
		nursingNo =( str.replace(/&amp;/g, '&') );
		var indexForBrandName = indexForBrandName--;
		var brandName = val.substring(0, indexForBrandName);
		// alert("pvms no--"+pvmsNo)
		
		if (nursingNo == "") {
			// alert("pvms no1111--"+pvmsNo)
			// document.getElementById('nomenclature' + inc).value = "";
			// document.getElementById('pvmsNo' + inc).value = "";
			return false;
		} else {
			 //document.getElementById('procedureNameNursingCare').value = nursingNo
			 var nursingItemIdValue= '';
			 var nursingValue = '';
			 var nursingType = '';
			 for(var i=0;i<autoNursingNo.length;i++){
					  
					  var nursingC = dataNursing[i].nursingCode;
					  if(nursingC == nursingNo){
						  nursingValue = dataNursing[i].nursingId;
						  nursingType = "M";
						  var checkCurrentRowIdProcedure=$(item).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id");
		        		  var checkCurrentRowProcedure=$(item).closest('tr').find("td:eq(2)").find("input:eq(0)").val();
		        		  $('#gridNursing tr').each(function(i, el) {
		        			   var $tds = $(this).find('td')
        	  			       var itemIdCheckProcedure=  $($tds).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id");
        	     			   var itemIdValueProcedure=$('#'+itemIdCheckProcedure).val();
        	     			   var idddd =$(item).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id");
        	     			   var currentidddd=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
        	     			   //if(itemIds!="" &&  itemIdValue!="" && itemIdValue!="undefined" )
        	     			   if(itemIdCheckProcedure!=checkCurrentRowIdProcedure && nursingValue==itemIdValueProcedure)	   
          			           {
        	     				 if(nursingValue==itemIdValueProcedure){
        	      			        $('#'+idddd).val("");
        	      			        $('#'+currentidddd).val("");
        	      			        alert("Procedure is already added");
        	      			        return false;
        	     				   
          			           }
          			           }
        	     			   else
        	     				{   
				 
				                    $(item).closest('tr').find("td:eq(2)").find(":input").val(nursingValue)
				                    $(item).closest('tr').find("td:eq(3)").find(":input").val(nursingType)
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


function checkPayWard() {
	var flag;
	if (document.getElementById("payward").checked) {
		flag = "y";
	} else {
		flag = "n";
	}
	new Ajax.Request(
			'opd?method=getPayward&flag=' + flag + '&' + csrfTokenName + '='
					+ csrfTokenValue,
			{
				onSuccess : function(response) {
					if (response.responseText.trim() != '') {
						document.getElementById('admissionWard').innerHTML = response.responseText
								.trim();
					}
				}
			});
}
/*
 * function openPopupWindow() { var $ = jQuery.noConflict();
 * //$("#icdName").empty(); //$("#icdName").hide(); $("#divIcdName").hide();
 * $("#snomed").val(""); var url="/hms/hms/adt?method=showICDSearchJsp";
 * newwindow=window.open(url,'opd_window',"left=100,top=100,height=700,width=1024,status=1,scrollbars=yes,resizable=0"); }
 * 
 */

function getTemplate(type, from, frompTab) {
	new Ajax.Request(
			'opd?method=getTemplate&type=' + type + '&from=' + from + '&'
					+ csrfTokenName + '=' + csrfTokenValue,
			{
				onSuccess : function(response) {
					if (response.responseText.trim() != '') {
						if (from == 'i')
							document.getElementById('tempLateInvestigation').innerHTML = response.responseText
									.trim();
						else if (from == 'p' && frompTab == '')
							document.getElementById('tempLatePrescription').innerHTML = response.responseText
									.trim();
						else if (frompTab == 'ptab') {
							document.getElementById('tempLatePrescriptionTab').innerHTML = response.responseText
									.trim();
						}
					}
				}
			});
}

function getAllTemplate() {
	var e1 = document.getElementById('tempLateInvestigation');
	e1.length = 0;
	e1.innerHTML = "";
	e1.options[0] = new Option('Select', '0');
	for (var i = 0; i < tempArrayTemp.length; i++) {
		e1.length++;
		e1.options[e1.length - 1] = new Option(tempArrayTemp[i][1],
				tempArrayTemp[i][0]);
	}
}

function checkPItem(cnt) {

	var tbl = document.getElementById('grid');
	var lastRow = tbl.rows.length;
	var iteration = lastRow - 1;

	// var pvmsNo=document.getElementById("pvmsNo"+iteration).value
	var visitId = document.getElementById("visitId").value
	var nomenclature = document.getElementById("nomenclaturepTab" + cnt).value
	var index1 = nomenclature.lastIndexOf("[");
	var indexForBrandName = index1;
	var index2 = nomenclature.lastIndexOf("]");
	index1++;

	var pvmsNo = nomenclature.substring(index1, index2);
	if (pvmsNo != "") {

		var xmlHttp;
		try {
			// Firefox, Opera 8.0+, Safari
			xmlHttp = new XMLHttpRequest();
		} catch (e) {
			// Internet Explorer
			try {
				xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				alert(e)
				try {
					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {
					alert("Your browser does not support AJAX!");
					return false;
				}
			}
		}

		xmlHttp.onreadystatechange = function() {
			if (xmlHttp.readyState == 4) {

				var items = xmlHttp.responseXML.getElementsByTagName('items')[0];
				for (loop = 0; loop < items.childNodes.length; loop++) {
					var item = items.childNodes[loop];
					var stockStstus = item.getElementsByTagName("stock")[0];
					jQuery(function($) {
						if (stockStstus.childNodes[0].nodeValue == '0') {
							$("#nomenclaturepTab" + cnt).css({
								'color' : 'red',
								'font-size' : '125%'
							});
							$("#prescription_availableStatuspTab" + cnt).val(
									'y');
						} else {
							$("#prescription_availableStatuspTab" + cnt).val(
									'n');
						}
					});
				}
			}
		}
		var url = "/hms/hms/opd?method=checkItem&pvmsNo=" + pvmsNo
				+ "&visitId=" + visitId + "&" + csrfTokenName + "="
				+ csrfTokenValue;
		xmlHttp.open("GET", url, true);
		xmlHttp.setRequestHeader("Content-Type", "text/xml");
		xmlHttp.send(null);
	}
}

function copyToPrescriptionTAb(incr, flag) {

	if (flag == "opconsult") {
		var pTabhdbValue = document.getElementById('pTabhdb').value;
		var hdbValue = document.getElementById('hdb').value;
		if (document.getElementById("nomenclature" + incr).value != "") {
			var tbl1 = document.getElementById('grid');
			var tbl2 = document.getElementById('prescriptionTabGrid');
			var lastRow1 = tbl1.rows.length;
			var lastRow2 = tbl2.rows.length;
			/*
			 * if(pTabhdb<hdbValue) {
			 * document.getElementById('pTabhdb').value=document.getElementById('hdb').value-1; }
			 */

			if (hdbValue > pTabhdbValue) {
				addRowPrescriptionTab();
			}
		}
		document.getElementById("nomenclaturepTab" + incr).value = document
				.getElementById("nomenclature" + incr).value;
		document.getElementById("dosagepTab" + incr).value = document
				.getElementById("dosage" + incr).value;
		document.getElementById("unitpTab" + incr).value = document
				.getElementById("unit" + incr).value;
		document.getElementById("noOfDayspTab" + incr).value = document
				.getElementById("noOfDays" + incr).value;
		document.getElementById("routepTab" + incr).value = document
				.getElementById("route" + incr).value;
	}
}

function checkPrescriptionCheck(iteration) {
	if (document.getElementById("itemRadio" + iteration).checked) {
		document.getElementById("itemRadiopTab" + iteration).checked = true;
	} else {
		document.getElementById("itemRadiopTab" + iteration).checked = false;
	}
}

/*
 * function checkItem(cnt){ var tbl = document.getElementById('grid'); var
 * lastRow = tbl.rows.length; var iteration = lastRow-1;
 * 
 * //var pvmsNo=document.getElementById("pvmsNo"+iteration).value var visitId=0;
 * if(document.getElementById("visitId")!=null &&
 * document.getElementById("visitId").value!=''){ visitId =
 * document.getElementById("visitId").value; } var nomenclature =
 * document.getElementById("nomenclature"+cnt).value var index1 =
 * nomenclature.lastIndexOf("["); var indexForBrandName=index1; var index2 =
 * nomenclature.lastIndexOf("]"); index1++;
 * 
 * var pvmsNo = nomenclature.substring(index1,index2); var prescriptionName =
 * nomenclature.substring(0,(index1-1)); if(pvmsNo !=""){
 * 
 * var xmlHttp; try { // Firefox, Opera 8.0+, Safari xmlHttp=new
 * XMLHttpRequest(); }catch (e){ // Internet Explorer try{ xmlHttp=new
 * ActiveXObject("Msxml2.XMLHTTP"); }catch (e){ alert(e) try{ xmlHttp=new
 * ActiveXObject("Microsoft.XMLHTTP"); }catch (e){ alert("Your browser does not
 * support AJAX!"); return false; } } }
 * 
 * xmlHttp.onreadystatechange=function() { if(xmlHttp.readyState==4){
 * jQuery(function ($) { var items
 * =xmlHttp.responseXML.getElementsByTagName('items')[0]; var items
 * =xmlHttp.responseXML.getElementsByTagName('items')[0]; for (loop = 0; loop <
 * items.childNodes.length; loop++) { var item = items.childNodes[loop]; var
 * stockStstus = item.getElementsByTagName("stock")[0];
 * if(stockStstus.childNodes[0].nodeValue=='0'){ $("#nomenclature"+cnt).css({
 * 'color': 'red', 'font-size': '125%' }); $("#nomenclaturepTab"+cnt).css({
 * 'color': 'red', 'font-size': '125%' });
 * $("#prescription_availableStatus"+cnt).val('y');
 * $("#prescription_availableStatuspTab"+cnt).val('y'); }else{
 * $("#prescription_availableStatuspTab"+cnt).val('n'); } } }); } } var
 * url="/hms/hms/opd?method=checkItem&pvmsNo="+pvmsNo+"&visitId="+visitId+"&"+csrfTokenName+"="+csrfTokenValue;
 * 
 * xmlHttp.open("GET",url,true); xmlHttp.setRequestHeader("Content-Type",
 * "text/xml"); xmlHttp.send(null); } }
 */

function checkItem(iteration) {

	// var tbl = document.getElementById('grid');
	// var lastRow = tbl.rows.length;
	// var iteration = lastRow-1;

	var pvmsNo = '';
	if (document.getElementById("pvmsNo" + iteration))
		pvmsNo = document.getElementById("pvmsNo" + iteration).value;
	var nomenclature = '';

	if (document.getElementById("nomenclature" + iteration))
		nomenclature = document.getElementById("nomenclature" + iteration).value

	var visitId = 0;
	if (document.getElementById("visitId"))
		visitId = document.getElementById("visitId").value
	var xmlHttp;
	try {
		// Firefox, Opera 8.0+, Safari
		xmlHttp = new XMLHttpRequest();
	} catch (e) {
		// Internet Explorer
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			alert(e)
			try {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
				alert("Your browser does not support AJAX!");
				return false;
			}
		}
	}

	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {

			var items = xmlHttp.responseXML.getElementsByTagName('items')[0];
			for (loop = 0; loop < items.childNodes.length; loop++) {
				var item = items.childNodes[loop];
				var bedStatus = item.getElementsByTagName("bedStatus")[0];
				if (bedStatus.childNodes[0].nodeValue == 'yes') {
					alert("This Drug is Alergic for this patient..!")
					if (document.getElementById("nomenclature" + iteration))
						document.getElementById("nomenclature" + iteration).value = ""
					if (document.getElementById("pvmsNo" + iteration))
						document.getElementById("pvmsNo" + iteration).value = ""
					pvmsNo = pvmsNo.childNodes[0].nodeValue
					return true
				} else {
					if (document.getElementById("visitId"))
						document.getElementById("visitId").selectedIndex = 0
					pvmsNo = 0
					return false;
				}

			}

		}

	}
	// if(nomenclature!="")
	// {

	var flag = checkForNomenclature(nomenclature, iteration)
	// }
	var url = "/hms/hms/opd?method=checkItem&pvmsNo=" + pvmsNo + "&visitId="
			+ visitId

	xmlHttp.open("GET", url, true);
	xmlHttp.setRequestHeader("Content-Type", "text/xml");
	xmlHttp.send(null);
	return flag;
}

function validateReferredDate() {
	var dob = document.forms["opdMain"]["referVisitDate"].value;
	var pattern = /^([0-9]{2})-([0-9]{2})-([0-9]{4})$/;
	if (dob == null || dob == "" || !pattern.test(dob)) {
		alert("Please enter dd-mm-yy!!");
		document.forms["opdMain"]["referVisitDate"].value = "";
		return false;
	} else {
		return true
	}
}

function selectReferBack(val) {

	// alert(val);
	var temp = new Array();
	temp = val.split("@@@");
	var districtId = temp[0];
	var hospitalId = temp[1];
	var deptId = temp[2];
	var referType = temp[3];
	var deptNameforExternal = temp[4];

	var $ = jQuery.noConflict();

	if (referType == 'NA') {
		// do nothing
	}
	if (referType == 'Internal') {
		$("#referdepartment option[value=" + temp[2] + "]").prop("selected",
				"selected");
	}

	if (referType == 'External') {
		$("#referdistrict option[value=" + temp[0] + "]").prop("selected",
				"selected");
		$("#referhospital option[value=" + temp[1] + "]").prop("selected",
				"selected");
		$("#referdepartment").append(
				"<option value=" + deptId + ">" + deptNameforExternal
						+ "</option>");
		$("#referdepartment option[value=" + temp[2] + "]").prop("selected",
				"selected");
	}

	// alert(Id);

}

function popwindowUploadDocuments(tempId, csrf) {
	var array = new Array();
	array = tempId.split("@@@");
	var hinId = array[0];
	var visitId = array[1];
	var url = "/hms/hms/opd?method=openUploadPopWindow&hinId=" + hinId
			+ "&visitId=" + visitId + "&" + csrf + "&" + csrfTokenName + "="
			+ csrfTokenValue;
	newwindow = window
			.open(url, 'name',
					"left=100,top=100,height=700,width=1024,status=1,scrollbars=1,resizable=0");
}

function openPopupWindowAllergy(csrf) {
	var requestId = document.getElementById("requestId").value.trim();

	window
			.open(
					"/hms/hms/ot?method=showAllergy&requestId=" + requestId
							+ "&" + csrf + "&" + csrfTokenName + "="
							+ csrfTokenValue,
					"_blank",
					"toolbar=yes, scrollbars=yes, resizable=yes, top=100, left=100, width=850, height=400");
}

function openPopupWindowNCDPattern(csrf, hinId) {
	window
			.open(
					"/hms/hms/opd?method=showNCDPattern&hinId=" + hinId + "&"
							+ csrf + "&" + csrfTokenName + "=" + csrfTokenValue,
					"_blank",
					"toolbar=yes, scrollbars=yes, resizable=yes, top=100, left=100, width=1200, height=400");
}

function openPopupWindowPhTravelHistory(surveyId, csrf) {
	// var requestId=document.getElementById("requestId").value.trim();
	var url = "/hms/hms/opd?method=displayTravelHistory&surveyId=" + surveyId
			+ "&" + csrf + "&" + csrfTokenName + "=" + csrfTokenValue;
	newwindow = window
			.open(url, 'name',
					"left=100,top=100,height=700,width=1024,status=1,scrollbars=1,resizable=0");
}

function popwindowResultEntry(tempId) {
	var array = new Array();
	array = tempId.split("@@@");
	var hinId = array[0];
	var visitId = array[1];
	var url = "/hms/hms/investigation?method=showPendingResultEntryTemplateOPD&hinId="
			+ hinId
			+ "&RequisitionFrom=OPD&"
			+ csrfTokenName
			+ '='
			+ csrfTokenValue;
	newwindow = window
			.open(url, 'name',
					"left=100,top=100,height=700,width=1124,status=1,scrollbars=1,resizable=0");
}

function getBedStatus(val) {
	submitProtoAjaxNew('opdMain', 'opd?method=getBedStatus&deptId=' + val,
			'bedDiv');
}
function submitSecondOpinion() {

	opener.fnSubmitPatient('secondop');
	submitForm('secondopinion', '/hms/hms/opd?method=submitSecondOpinion')
	self.close();
}

function openPopupForSaveInvestigation() {
	var totalRow = document.getElementById('hiddenValue').value;
	var htmlText = "";
	var count = 0;
	if (!isNaN(totalRow) && totalRow > 0) {
		htmlText += '<form method="post" action="/hms/hms/opd?method=submitInvestigationTamplate">'
				+ '<br/><br/><label>Tamplate Name<span style="color:red;">* </span> </label><input type="text" name="tamplatename" maxlength="30" /><div style="clear:boath;"><div><br/><br/>';
		htmlText += '<table width="100%" border="2" align="center" cellpadding="2" cellspacing="2" style="float:left;" >';
		for (var i = 0; i <= totalRow; i++) {
			if (document.getElementById('chargeCodeName' + i) != null
					&& document.getElementById('chargeCodeName' + i).value != '') {

				if (count == 0) {
					htmlText += '' + '<tr>' + '<th scope="col">Test Name</th>'
							+ '<th scope="col">Clinical Notes</th>'

							+ '</tr>';
				}
				count++;
				htmlText += '' + '<tr>' + '<td>'
				// +'<input type="hidden" name="chargeCode'+count+'"
				// value="'+document.getElementById('chargeCode'+i).value+'" />'
				+ '<input type="hidden" name="chargeCodeName' + count
						+ '" value="'
						+ document.getElementById('chargeCodeName' + i).value
						+ '" />' + ''
						+ document.getElementById('chargeCodeName' + i).value
						+ '</td>' + '<td>'
						+ '<input type="hidden" name="clinicalNotes' + count
						+ '" value="'
						+ document.getElementById('clinicalNotes' + i).value
						+ '" />' + ''
						+ document.getElementById('clinicalNotes' + i).value

						+ '</td>'
				htmlText += '</td>'

				+ '</tr>';

			}

		}
		htmlText += '</table>'
				+ '<div style="clear:both;"><div><br/><br/><input type="hidden" id="total" name="total" value="'
				+ count
				+ '" /><br/><br/><div>'
				+ '<div><input type="submit" id="submit" value="Save"  />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
				+ '<input type="button" id="close" value="Close"  onclick="window.close()" />'
				+ '</div></div></div></form>';
	}
	// alert(htmlText);
	if (count == 0) {
		alert('Please enter some data to save Tamplate');
	} else {
		var myWindow = window.open("", "saveprescriptionWindow",
				"width=500, height=500");
		myWindow.document
				.write('<link rel="stylesheet" type="text/css" href="/hms/jsp/css/style.css" />');
		myWindow.document.write(htmlText);
	}

}

function openPopupForSavePrescriptiontamplateTab() {
	var totalRow = document.getElementById('pTabhdb').value;
	var htmlText = "";
	var count = 0;
	if (!isNaN(totalRow) && totalRow > 0) {
		htmlText += '<form method="post" action="/hms/hms/opd?method=submitPrescriptionTamplate">'
				+ '<input type="hidden" name="'
				+ csrfTokenName
				+ '"value="'
				+ csrfTokenValue
				+ '"/>'
				+ '<br/><br/><label>Tamplate Name<span style="color:red;">* </span> </label><input type="text" name="tamplatename" maxlength="30" /><div style="clear:boath;"><div><br/><br/>';
		htmlText += '<table border="2" align="center" cellpadding="2" cellspacing="2" style="float:left;" >';
		for (var i = 0; i < totalRow; i++) {

			if (document.getElementById('nomenclaturepTab' + i) != null
					&& document.getElementById('nomenclaturepTab' + i).value != ''
					&& document.getElementById('pvmsNopTab' + i).value != ''
					&& document.getElementById('pvmsNopTab' + i).value != '0') {

				if (count == 0) {
					htmlText += '' + '<tr>' + '<th scope="col">Item Name</th>'
							+ '<th scope="col">Route</th>'
							+ '<th scope="col">Dosage</th>'
							+ '<th scope="col">Frequency</th>'
							+ '<th scope="col">Days</th>'
							+ '<th scope="col">Instruction </th>'
							+ '<th scope="col">Total</th>' + '</tr>';
				}
				count++;
				htmlText += '' + '<tr>' + '<td>'
						+ '<input type="hidden" name="pvms' + count
						+ '" value="'
						+ document.getElementById('pvmsNopTab' + i).value
						+ '" />' + '<input type="hidden" name="nomenclature'
						+ count + '" value="'
						+ document.getElementById('nomenclaturepTab' + i).value
						+ '" />' + ''
						+ document.getElementById('nomenclaturepTab' + i).value;

				htmlText += '<td>' + '<input type="hidden" name="route' + count
						+ '" value="'
						+ document.getElementById('routepTab' + i).value
						+ '" />';
				if (document.getElementById('routepTab' + i).value != 0) {
					// htmlText +='<input type="hidden"
					// name="routename'+count+'"
					// value="'+document.getElementById('routepTab'+i).options[document.getElementById('routepTab'+i).selectedIndex].text+'"
					// />';
					htmlText += '<input type="hidden" name="routename' + count
							+ '" value="'
							+ document.getElementById('routepTab' + i).value
							+ '" />';

					// htmlText
					// +=''+document.getElementById('routepTab'+i).options[document.getElementById('routepTab'+i).selectedIndex].text;

					htmlText += ''
							+ document.getElementById('routepTab' + i).value;
				}

				htmlText += '</td>' + '</td>' + '<td>'
						+ '<input type="hidden" name="dosage' + count
						+ '" value="'
						+ document.getElementById('dosage' + i).value + '" />'
						+ '' + document.getElementById('dosagepTab' + i).value
						+ '</td>' + '<td>'
						+ '<input type="hidden" name="frequency' + count
						+ '" value="'
						+ document.getElementById('frequencypTab' + i).value
						+ '" />';
				if (document.getElementById('frequencypTab' + i).value != 0) {
					htmlText += '<input type="hidden" name="frequencyname'
							+ count
							+ '" value="'
							+ document.getElementById('frequencypTab' + i).options[document
									.getElementById('frequencypTab' + i).selectedIndex].text
							+ '" />';
					htmlText += ''
							+ document.getElementById('frequencypTab' + i).options[document
									.getElementById('frequencypTab' + i).selectedIndex].text;
				}
				htmlText += '</td>' + '<td>'
						+ '<input type="hidden" name="noOfDays' + count
						+ '" value="'
						+ document.getElementById('noOfDayspTab' + i).value
						+ '" />' + ''
						+ document.getElementById('noOfDayspTab' + i).value
						+ '</td>' + '<td>'
						+ '<input type="hidden" name="instrunction' + count
						+ '" value="'
						+ document.getElementById('instrunctionpTab' + i).value
						+ '" />';
				if (document.getElementById('instrunctionpTab' + i).value != 0) {
					htmlText += '<input type="hidden" name="instrunctionname'
							+ count
							+ '" value="'
							+ document.getElementById('instrunctionpTab' + i).options[document
									.getElementById('instrunctionpTab' + i).selectedIndex].text
							+ '" />';

					htmlText += ''
							+ document.getElementById('instrunctionpTab' + i).options[document
									.getElementById('instrunctionpTab' + i).selectedIndex].text;
				}
				htmlText += '<td>' + '<input type="hidden" name="route' + count
						+ '" value="'
						+ document.getElementById('routepTab' + i).value
						+ '" />';
				if (document.getElementById('routepTab' + i).value != 0) {
					htmlText += '<input type="hidden" name="routename'
							+ count
							+ '" value="'
							+ document.getElementById('routepTab' + i).options[document
									.getElementById('routepTab' + i).selectedIndex].text
							+ '" />';

					htmlText += ''
							+ document.getElementById('routepTab' + i).options[document
									.getElementById('routepTab' + i).selectedIndex].text;
				}

				htmlText += '</td>' + '<td>'
						+ '<input type="hidden" name="total' + count
						+ '" value="'
						+ document.getElementById('total' + i).value + '" />'
						+ '' + document.getElementById('total' + i).value;
				htmlText += '</td>'

				+ '</tr>';

			}

		}
		htmlText += '</table>'
				+ '<div style="clear:boath;"><div><br/><br/><input type="hidden" id="pTabhdb" name="pTabhdb" value="'
				+ count
				+ '" /><br/><br/><div><input type="submit" id="submit" value="Save" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="close" value="Close" onclick="window.close()" /></div>';
		+'</form>';
	}
	// alert(htmlText);
	if (count == 0) {
		alert('Please enter some data to save Tamplate');
	} else {
		var myWindow = window.open("", "saveprescriptionWindow",
				"width=500, height=500");
		myWindow.document
				.write('<link rel="stylesheet" type="text/css" href="/hms/jsp/css/style.css" />');
		myWindow.document.write(htmlText);
	}

}

function openPopupForSavePrescriptiontamplate() {
	var totalRow = document.getElementById('hdb').value;
	// add one for total number or row for adding local templete by rajat singh
	totalRow = totalRow + 1;
	var htmlText = "";
	var count = 0;
	if (!isNaN(totalRow) && totalRow > 0) {
		htmlText += '<form method="post" action="/hms/hms/opd?method=submitPrescriptionTamplate">'
				+ '<input type="hidden" name="'
				+ csrfTokenName
				+ '"value="'
				+ csrfTokenValue
				+ '"/>'
				+ '<br/><br/><label>Tamplate Name<span style="color:red;">* </span> </label><input type="text" name="tamplatename" maxlength="30" /><div style="clear:boath;"><div><br/><br/>';
		htmlText += '<table border="2" align="center" cellpadding="2" cellspacing="2" style="float:left;" >';
		for (var i = 0; i < totalRow; i++) {

			if (document.getElementById('nomenclature' + i) != null
					&& document.getElementById('nomenclature' + i).value != ''
					&& document.getElementById('pvmsNo' + i).value != ''
					&& document.getElementById('pvmsNo' + i).value != '0') {

				if (count == 0) {
					htmlText += '' + '<tr>' + '<th scope="col">Item Name</th>'
							+ '<th scope="col">Route</th>'
							+ '<th scope="col">Dosage</th>'
							+ '<th scope="col">Frequency</th>'
							+ '<th scope="col">Days</th>'
							+ '<th scope="col">Instruction </th>'
							+ '<th scope="col">Total</th>' + '</tr>';
				}
				count++;
				htmlText += '' + '<tr>' + '<td>'
						+ '<input type="hidden" name="pvms' + count
						+ '" value="'
						+ document.getElementById('pvmsNo' + i).value + '" />'
						+ '<input type="hidden" name="nomenclature' + count
						+ '" value="'
						+ document.getElementById('nomenclature' + i).value
						+ '" />' + ''
						+ document.getElementById('nomenclature' + i).value;
				+'</td>'

				htmlText += '<td>' + '<input type="hidden" name="route' + count
						+ '" value="'
						+ document.getElementById('route' + i).value + '" />';
				if (document.getElementById('route' + i).value != 0) {
					// htmlText +='<input type="hidden"
					// name="routename'+count+'"
					// value="'+document.getElementById('route'+i).options[document.getElementById('route'+i).selectedIndex].text+'"
					// />';
					htmlText += '<input type="hidden" name="routename' + count
							+ '" value="'
							+ document.getElementById('route' + i).value
							+ '" />';

					// htmlText
					// +=''+document.getElementById('route'+i).options[document.getElementById('route'+i).selectedIndex].text;
					htmlText += '' + document.getElementById('route' + i).value;
				}

				htmlText += '</td>'

				+ '<td>' + '<input type="hidden" name="dosage' + count
						+ '" value="'
						+ document.getElementById('dosage' + i).value + '" />'
						+ '' + document.getElementById('dosage' + i).value

						+ '</td>' + '<td>'

						+ '<input type="hidden" name="frequency' + count
						+ '" value="'
						+ document.getElementById('frequency' + i).value
						+ '" />';
				if (document.getElementById('frequency' + i).value != 0) {
					htmlText += '<input type="hidden" name="frequencyname'
							+ count
							+ '" value="'
							+ document.getElementById('frequency' + i).options[document
									.getElementById('frequency' + i).selectedIndex].text
							+ '" />';
					htmlText += ''
							+ document.getElementById('frequency' + i).options[document
									.getElementById('frequency' + i).selectedIndex].text;
				}
				htmlText += '</td>' + '<td>'
						+ '<input type="hidden" name="noOfDays' + count
						+ '" value="'
						+ document.getElementById('noOfDays' + i).value
						+ '" />' + ''
						+ document.getElementById('noOfDays' + i).value
						+ '</td>' + '<td>'
						+ '<input type="hidden" name="instrunction' + count
						+ '" value="'
						+ document.getElementById('instrunction' + i).value
						+ '" />';
				if (document.getElementById('instrunction' + i).value != 0) {
					htmlText += '<input type="hidden" name="instrunctionname'
							+ count
							+ '" value="'
							+ document.getElementById('instrunction' + i).options[document
									.getElementById('instrunction' + i).selectedIndex].text
							+ '" />';

					htmlText += ''
							+ document.getElementById('instrunction' + i).options[document
									.getElementById('instrunction' + i).selectedIndex].text;
				}
				htmlText += '</td>' + '<td>'
				htmlText += '<input type="hidden" id="total' + count
						+ '" name="total' + count + '" value="'
						+ document.getElementById('total' + i).value + '" />'
						+ '' + document.getElementById('total' + i).value
						+ '</td>';

				+'</tr>';
			}
		}
		htmlText += '</table>'
				+ '<div style="clear:boath;"><div><br/><br/><input type="hidden" id="hdb" name="hdb" value="'
				+ count
				+ '" /><br/><br/><div><input type="submit" id="submit" value="Save"  />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="close" value="Close" onclick="window.close()" /></div>';
		+'</form>';
	}
	// alert(htmlText);
	if (count == 0) {
		alert('Please enter some data to save Tamplate');
	} else {
		var myWindow = window.open("", "saveprescriptionWindow",
				"width=900, height=500");
		myWindow.document
				.write('<link rel="stylesheet" type="text/css" href="/hms/jsp/css/style.css" />');
		myWindow.document.write(htmlText);
	}

}

function populateNoOfDaysForNursingProcedure(value, incr) {

	var procedureName_nursing = document.getElementById('procedureName_nursing'
			+ incr).value;

	if (procedureName_nursing) {
		if (value > 0) {
			document.getElementById('noOfDays_nursing' + incr).value = 1;
		}
	}

}

function fillcheckDoseFrequency() {

	var hdb = document.getElementById("hdb").value;

	var i;
	var status = true;

	for (i = 0; i <= hdb; i++) {
		if (document.getElementById("nomenclature" + i) != null) {
			var itemName = document.getElementById("nomenclature" + i).value;
			// alert(itemName);
			if (itemName) {
				var res = itemName.split("(");
				if (res) {
					var dosage = document.getElementById("dosage" + i).value;
					if (!dosage) {
						status = false;
						alert("Enter the Dosage")
						return;
					}

					var unit = document.getElementById("unit" + i).value;
					if (unit == "") {
						alert("Unit not avaiable")
						status = false;
						return;
					}
					if (document.getElementById("frequency" + i).selectedIndex == "0") {
						alert("Select Frequency")
						status = false;
						return;
					}

					var noOfDays = document.getElementById("noOfDays" + i).value;

					if (!noOfDays) {
						alert("Enter Days")
						status = false;
						return;
					}

				}
			}
		}
	}

	return status;

}

function checkForProcedure() {
	var i;
	var procstatus = true;

	var hdb = document.getElementById("nursinghdb").value;

	for (i = 0; i <= hdb; i++) {

		var itemName = document.getElementById("procedureName_nursing" + i).value;

		if (itemName) {
			var res = itemName.split("(");
			if (res) {
				if (document.getElementById("frequency_nursing" + i).selectedIndex == "0") {
					alert("Select Procedure Frequency")
					procstatus = false;

				}

				var noOfDays = document.getElementById("noOfDays_nursing" + i).value;

				if (noOfDays <= 0) {
					alert("Enter Procedure No.Of Days")
					procstatus = false;
				}

			}
		}

	}
	return procstatus;
}

function checkForValidMortuary() {

	var mlscasetype = document.getElementById("mlscasetype");
	var patientExpire = document.getElementById("patient_expire");
	var i;
	var count = 0;
	var mortuaryFlag = false;
	var remainingFlag = false;
	for (i = 0; i < mlscasetype.length; i++) {
		if (mlscasetype.options[i].selected
				&& mlscasetype.options[i].value == 'Mortuary') {
			count++;
			if (patientExpire.checked) {
				mortuaryFlag = true;
				break;
			} else {
				remainingFlag = false;
				break;
			}
		} else if (mlscasetype.options[i].selected) {
			count++;
			remainingFlag = true;
		}

	}

	if (mortuaryFlag)
		return true;
	else if (remainingFlag)
		return true;
	else if (!mortuaryFlag && !remainingFlag && count > 0) {
		alert("Please select Patient is Dead !");
		return false;
	} else if (count == 0)
		return true;

}

function displaySpecialty(splName) {
	document.getElementById("splName").value = splName;

	var cntr = new ddtabcontent("countrytabsIn")
	cntr.setpersist(true)
	cntr.setselectedClassTarget("link")
	cntr.init()
	cntr.expandit(7);

}
// dental functions

function addDentalProcedureRow() {

	var tbl = document.getElementById('dentalGrid');
	var lastRow = tbl.rows.length;

	var iteration = lastRow;
	var row = tbl.insertRow(lastRow);
	var hdb = document.getElementById('dentalCount');
	var iteration = parseInt(hdb.value) + 1;
	hdb.value = iteration;

	var cell1 = row.insertCell(0);
	var e1 = document.createElement('Select');
	// e1.size = '70';
	e1.name = 'teeth' + iteration;
	e1.id = 'teethId' + iteration
	e1.setAttribute('tabindex', '1');
	e1.options[0] = new Option('Select', '0');
	/*
	 * <% for (int i=11; i <49; i++) { %> e1.options[<%=i%>] = new Option('<%=i%>', '<%=i%>');
	 * <%}%>
	 */
	var j = 1;
	for (var i = 11; i <= 49; i++) {
		e1.options[j++] = new Option(i, i);
	}
	cell1.appendChild(e1);
	e1.focus();

	var cell11 = row.insertCell(1);
	var e21 = document.createElement('Select');
	e21.name = 'dentalTreatment' + iteration;
	e21.id = 'dentalTreatment' + iteration
	e21.setAttribute('tabindex', '1');
	e21.options[0] = new Option('Select', '0');
	e21.options[1] = new Option('PI', 'PI');
	e21.options[2] = new Option('PII', 'PII');
	e21.options[3] = new Option('PIII', 'PIII');
	cell11.appendChild(e21);

	var cell12 = row.insertCell(2);
	var e22 = document.createElement('Select');
	e22.name = 'dtc' + iteration;
	e22.id = 'dtc' + iteration
	e22.setAttribute('tabindex', '1');
	e22.options[0] = new Option('Select', '0');
	e22.options[1] = new Option('PI', 'PI');
	e22.options[2] = new Option('PII', 'PII');
	e22.options[3] = new Option('PIII', 'PIII');
	cell12.appendChild(e22);

	var cell14 = row.insertCell(3);
	var e23 = document.createElement('input');
	e23.type = 'text';
	e23.name = 'remarks' + iteration;
	e23.id = 'remarks' + iteration
	e23.size = '70';
	e23.setAttribute('tabindex', '1');
	cell14.appendChild(e23);

	var cell15 = row.insertCell(4);
	var e31 = document.createElement('input');
	e31.type = 'button';
	e31.className = 'buttonAdd';
	e31.name = 'Button' + iteration;
	e31.onclick = function() {
		addDentalProcedureRow();
	};
	e31.setAttribute('tabindex', '1');
	cell15.appendChild(e31);

	var cell16 = row.insertCell(5);
	var e41 = document.createElement('input');
	e41.type = 'button';
	e41.className = 'buttonDel';
	e41.name = 'delete' + iteration;
	// e41.setAttribute('onClick', 'removeRow();');
	e41.onclick = function() {
		removeRow('dentalGrid', 'hiddenValue', this);
	};
	e41.setAttribute('tabindex', '1');
	cell16.appendChild(e41);
}

function chkValue(Obj) {
	var newdentalValue = "";
	var duplicate = new Boolean(false)
	var dstr = document.getElementById('UnserTeeth123').value;
	var mySplitResult = dstr.split(",");
	for (i = 1; i < mySplitResult.length; i++) {
		if (mySplitResult[i] == Obj.id) {
			duplicate = true;
		} else {
			newdentalValue = newdentalValue + "," + mySplitResult[i];
		}
	}
	if (duplicate == false) {
		if (dstr != '') {
			dstr = dstr + ",";
		}
		dstr = dstr + Obj.id;
		document.getElementById('UnserTeeth123').value = dstr;
	} else {
		document.getElementById('UnserTeeth123').value = newdentalValue;
	}

}

function chkDentalValue(Obj) {

	// var idValue = Obj.id.replace(/AT|CT/g,'');
	var idValue = Obj.id.replace(/[^0-9\.]+/g, '');
	var dstr = document.getElementById('treatableTooth').value;
	// var tstr=document.getElementById('proc_treatment_teeth0').value;

	var checked = new Boolean(false);
	checked = Obj.checked;
	var mySplitResult = dstr.split(",");
	if (checked && dstr.length <= 35) {
		for (i = 1; i < mySplitResult.length; i++) {
			if (mySplitResult[i] == idValue)
				return false;
		}
		document.getElementById('treatableTooth').value = document
				.getElementById('treatableTooth').value != "" ? document
				.getElementById('treatableTooth').value
				+ "," + idValue : idValue;
		document.getElementById('proc_treatment_teeth0').value = document
				.getElementById('proc_treatment_teeth0').value != "" ? document
				.getElementById('proc_treatment_teeth0').value
				+ "," + idValue : idValue;
	} else {

		str1 = "," + idValue + "|" + idValue;
		var re = new RegExp(str1, "g");

		document.getElementById('treatableTooth').value = document
				.getElementById('treatableTooth').value.replace(re, '');
		document.getElementById('proc_treatment_teeth0').value = document
				.getElementById('proc_treatment_teeth0').value.replace(re, '');

		if (dstr.length >= 35)
			Obj.checked = false;
	}

}

function chkValueMissing(Obj) {
	var newdentalValue = "";
	var duplicate = new Boolean(false)
	var dstr = document.getElementById('MissTeeth123').value;
	var mySplitResult = dstr.split(",");
	for (i = 1; i < mySplitResult.length; i++) {
		if (mySplitResult[i] == Obj.id) {
			duplicate = true;
		} else {
			newdentalValue = newdentalValue + "," + mySplitResult[i];
		}
	}
	if (duplicate == false) {
		if (dstr != '') {
			dstr = dstr + ",";
		}
		dstr = dstr + Obj.id;
		document.getElementById('MissTeeth123').value = dstr;
	} else {
		document.getElementById('MissTeeth123').value = newdentalValue;
	}

}

function fillDentalValue(chkId) {
	if (document.getElementById(chkId).checked) {
		document.getElementById(chkId).value = 'Y';
	} else
		document.getElementById(chkId).value = '';
}

function fillPregnancylValue(chkId) {
	if (document.getElementById(chkId).checked) {
		document.getElementById(chkId).value = 'y';
	} else {
		document.getElementById(chkId).value = 'n';
		document.getElementById('lmp_date').value = "";
		document.getElementById('edd').value = "";
		document.getElementById('currentEdd').value = "";
		document.getElementById('operation_period_today').value = "";
	}

}

function fillProcedure(Obj, inc) {

	if (document.getElementById('proc_treatment_teeth' + inc).value == "") {
		alert("Please enter teeth first");
		document.getElementById('proc_treatment_teeth' + inc).focus();
		return false;
	} else if (Obj.value != "") {
		var duplicate = new Boolean(false);
		var newdentalValue = "";
		var d = Obj.value.split("[");
		// alert(d[0]);
		var dstr = document.getElementById('teethRemarks').value;
		// var mySplitResult = dstr.split(","); dstr+","+
		newdentalValue = "["
				+ document.getElementById('proc_treatment_teeth' + inc).value
				+ " - " + d[0] + "]";
		document.getElementById('teethRemarks').value = dstr != "" ? dstr + ","
				+ newdentalValue : newdentalValue;
	}
	/*
	 * for(i=0;i<mySplitResult.length;i++) { if(mySplitResult[i]==d[0]) {
	 * duplicate=true; } else { // newdentalValue=
	 * newdentalValue+","+mySplitResult[i];
	 * newdentalValue=newdentalValue+","+"["+document.getElementById('proc_treatment_teeth'+i).value+"-"+mySplitResult[i]+"]"; } }
	 * 
	 * if(duplicate==false) { //dstr=dstr!=""?dstr+","+Obj.id:Obj.id;
	 * dstr=dstr+","+d[0]; document.getElementById('teethRemarks').value = dstr; }
	 *//*
		 * else{ document.getElementById('teethRemarks').value = newdentalValue; }
		 */

	/*
	 * var newdentalValue=""; var duplicate = new Boolean(false) var
	 * dstr=document.getElementById('treatableTooth').value; var mySplitResult =
	 * dstr.split(",");
	 * 
	 * for(i=1;i<mySplitResult.length;i++) { if(mySplitResult[i]==Obj.id) {
	 * duplicate=true; }else{ //newdentalValue=
	 * mySplitResult!=""?newdentalValue+","+mySplitResult[i]:mySplitResult[i];
	 * newdentalValue= newdentalValue+","+mySplitResult[i]; } }
	 * if(duplicate==false) { //dstr=dstr!=""?dstr+","+Obj.id:Obj.id;
	 * dstr=dstr+","+Obj.id; document.getElementById('treatableTooth').value =
	 * dstr; document.getElementById('proc_treatment_teeth').value = dstr;
	 * }else{ document.getElementById('treatableTooth').value = newdentalValue;
	 * document.getElementById('proc_treatment_teeth').value = newdentalValue; }
	 */
}

function putLMPEDD(chkId, lmpDate, EddDate) {
	if (!lmpDate && !EddDate) {
		if (document.getElementById(chkId).checked) {
			document.getElementById('lmp_date').value = lmpDate;
			document.getElementById('edd').value = EddDate;
		}
	}
}

function generateEDD(lmpDate, pregChk) {
	// alert(document.getElementById(lmpDate));
	if (pregChk.value == 'y') {
		if (document.getElementById("lmp_date") != "") {
			setPregencyValues();
		}
	} else {
		document.getElementById("lmp_date").value = "";
		alert("Please check pregnancy before filling LMP Date");
	}

	// alert(document.getElementById(pregChk).checked);
	/**/
}

function setPregencyValues() {
	if (document.getElementById("lmp_date") != null) {
		var newdate = (document.getElementById("lmp_date").value).split("/")
				.reverse().join("/");
		var someDate = new Date(newdate);
		//
		someDate.setMonth(someDate.getMonth() + 9);
		someDate.setDate(someDate.getDate() + 7);
		var dateFormated = someDate.toISOString().substr(0, 12);
		// console.log(dateFormated.split("/").reverse().join("/"));

		var datePart = dateFormated.match(/\d+/g), year = datePart[0]
				.substring(0), // get only two digits
		month = datePart[1], day = datePart[2];

		dateFormated = day + '/' + month + '/' + year;
		document.getElementById("edd").value = dateFormated;

		var d1 = document.getElementById("lmp_date").value.split('/');
		var d2 = document.getElementById("consultationDate").value.split('/');
		var t2 = new Date(d2[2], d2[1] - 1, d2[0]);
		var t1 = new Date(d1[2], d1[1] - 1, d1[0]);
		var n = ((t2 - t1) / (24 * 3600 * 1000));
		var weeks = Math.floor(n / 7);
		var day = n % 7;

		document.getElementById("operation_period_today").value = weeks
				+ " weeks " + day + " days";
		document.getElementById("currentEdd").value = document
				.getElementById("consultationDate").value;
	}
}

// end dental

function setValueInText(radVal, count) {
	document.getElementById("textValue" + count).value = radVal;
}

function popwindowresult(url) {

	newwindow = window
			.open(url, 'Diagnosis',
					"left=0,top=0,height=700,width=1010,status=1,scrollbars=1,resizable=1");

}

function checkForPurchase(val, inc) {

	var index1 = val.lastIndexOf("[");
	var index2 = val.lastIndexOf("]");
	index1++;
	var pvms = val.substring(index1, index2);
	// console.log(pvms +" d "+inc);

	if (pvms != "") {

		ajaxFunctionForAutoCompleteInLPOGeneral('opdMain',
				'opd?method=fillItemsInGrid&pvmsNo=' + pvms, inc);
		// ajaxFunctionForAutoCompleteForPurchase('purchaseGrid','stores?method=fillItemsCommon&pvmsNo='
		// + pvms , inc);

	} else {
		return false;
	}

}

function ajaxFunctionForAutoCompleteInLPOGeneral(formName, action, rowVal) {

	var xmlHttp;
	try {
		// Firefox, Opera 8.0+, Safari
		xmlHttp = new XMLHttpRequest();
	} catch (e) {
		// Internet Explorer
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			alert(e)
			try {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
				alert("Your browser does not support AJAX!");
				return false;
			}
		}
	}
	var url = action
	xmlHttp.open("GET", url, true);
	xmlHttp.setRequestHeader("Content-Type", "text/xml");
	xmlHttp.send(null);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {

			var items = xmlHttp.responseXML.getElementsByTagName('items')[0];

			for (loop = 0; loop < items.childNodes.length; loop++) {

				var item = items.childNodes[loop];

				var id = item.getElementsByTagName("id")[0];
				var classificationId = 0;
				if (item.getElementsByTagName("itemClassificationId") != null)
					classificationId = item
							.getElementsByTagName("itemClassificationId")[0];
				var pvms = item.getElementsByTagName("pvms")[0];
				var au = item.getElementsByTagName("au")[0];

				/*
				 * document.getElementById('itemCode'+rowVal).value =
				 * pvms.childNodes[0].nodeValue
				 */
				document.getElementById('itemId' + rowVal).value = id.childNodes[0].nodeValue
				if (document.getElementById('itemIdClassificationId' + rowVal) != null)
					document.getElementById('itemIdClassificationId' + rowVal).value = classificationId.childNodes[0].nodeValue
					/*
					 * document.getElementById('idAu'+rowVal).value =
					 * au.childNodes[0].nodeValue
					 */

			}
		}
	}
}

function disableOtherMedicine(val, inc) {
	document.getElementById('itemConversionId' + inc).value = "0";
	document.getElementById('itemClass' + inc).value = "0";
	document.getElementById('dispensingUnit' + inc).value = "0";
	if (val != "") {
		document.getElementById('otherMedicine' + inc).disabled = true;
		document.getElementById('otherMedicine' + inc).value = "";
		// document.getElementById('total'+inc).readOnly = true;
		document.getElementById('itemConversionId' + inc).disabled = true;
		document.getElementById('itemClass' + inc).disabled = true;
		document.getElementById('dispensingUnit' + inc).disabled = true;
		// document.getElementById('injCategory'+inc).disabled = true;

	} else {
		document.getElementById('otherMedicine' + inc).disabled = false;
		document.getElementById('itemConversionId' + inc).disabled = false;
		document.getElementById('itemClass' + inc).disabled = false;
		document.getElementById('dispensingUnit' + inc).disabled = false;
		// document.getElementById('total'+inc).readOnly = false;
		// document.getElementById('injCategory'+inc).disabled = false;

	}
}
function readOnlyNomenclature(val, inc) {

	if (val != "") {
		// alert("Please confirm PVMS/NIV is not available");
		document.getElementById('nomenclature' + inc).readOnly = true;
		document.getElementById('au' + inc).readOnly = true;
		document.getElementById('nomenclature' + inc).value = "";
		if (document.getElementById('itemId' + inc)) {
			document.getElementById('pvmsNo' + inc).value = "";
		}
	} else {
		document.getElementById('nomenclature' + inc).readOnly = false;
		document.getElementById('au' + inc).readOnly = false;

	}
}

function showSimilarMedicineNames(otherDrug) {
	newwindow = window
			.open('/hms/hms/opd?method=showRelatedMedicineNames&otherDrug='
					+ otherDrug, 'name',
					"left=2,top=100,height=300,width=800,status=1,scrollbars=1,resizable=0");
}

function validateFrequency(counter) {

	if (counter != undefined)
		var count = document.getElementById(counter).value;
	else
		var count = document.getElementById('hdb').value;
	// alert("fasfsf"+count);
	for (var i = 1; i <= count; i++) {

		// var nomenclature = document.getElementById('nomenclature'+i).value;
		if ((document.getElementById('nomenclature' + i) && document
				.getElementById('nomenclature' + i).value != '')
				|| (document.getElementById('otherMedicine' + i) && document
						.getElementById('otherMedicine' + i).value != '')) {
			// if(document.getElementById('nomenclature'+i).value != ''){
			if (document.getElementById('frequency' + i)) {
				if (document.getElementById('frequency' + i).value == '0') {
					alert('Please select frequency.');
					return false;
				}
			}

			if (document.getElementById('dosage' + i)) {
				if (document.getElementById('dosage' + i).value == '') {
					alert('Please Enter dosage.');
					return false;
				}
			}

			// var noOfDays = document.getElementById('noOfDays'+i).value;
			// commented for sos if(document.getElementById('frequency'+i).value
			// != '13'){
			if (document.getElementById('noOfDays' + i)) {
				if (document.getElementById('noOfDays' + i).value == '') {
					alert('Please Enter No. of Days.');
					return false;
				}
			}
			/*
			 * commented for sos }else{ if(document.getElementById('sosQty'+i)){
			 * if(document.getElementById('sosQty'+i).value == ''){
			 * alert('Please Enter SOS Qty.'); return false; } } }
			 */
			if (document.getElementById('noOfDays' + i)) {
				if (document.getElementById('noOfDays' + i).value != "") {
					if (isNaN(document.getElementById('noOfDays' + i).value)) {
						document.getElementById('noOfDays' + i).value = "";
						alert("No. of Days should be a number");
						return false;
					}
				}
			}

			/*
			 * var instructionACPC =
			 * document.getElementById('instructionACPC'+i).value;
			 * if(instructionACPC == ''){ alert('Please select Intake.'); return
			 * false; } var typeLeftRight =
			 * document.getElementById('typeLeftRight'+i).value;
			 * if(typeLeftRight == ''){ alert('Please select Type.'); return
			 * false; } var remarks =
			 * document.getElementById('remarks'+i).value; if(remarks == ''){
			 * alert('Please Enter remarks.'); return false; }
			 */
			// }
			/*
			 * else { alert("Please Enter Nomenclature"); return false; }
			 */

		}
	}
	return true;
}

function validateNip() {
	var count = document.getElementById('hdb').value;
	var j = 0;
	;
	var uomMatch;
	for (var i = 500; i <= count; i++) {
		uomMatch = true;
		// var nomenclature = document.getElementById('nomenclature'+i).value;
		if (document.getElementById('otherMedicine' + i)) {
			j++;
			if (document.getElementById('otherMedicine' + i).value != '') {
				if (document.getElementById('itemClass' + i)) {
					if (document.getElementById('itemClass' + i).value == '0') {
						alert('Please select class for Nip Medicine ' + j);
						return false;
					}
				}

				if (document.getElementById('itemConversionId' + i)) {
					if (document.getElementById('itemConversionId' + i).value == '0') {
						alert('Please select Au for Nip Medicine ' + j);
						return false;
					}
				}

				// var noOfDays = document.getElementById('noOfDays'+i).value;

				if (document.getElementById('dispensingUnit' + i)) {
					if (document.getElementById('dispensingUnit' + i).value == '0') {
						alert('Please select Dispensing Unit for Nip Medicine '
								+ j);
						return false;
					}
				}

				for (var n = 0; n < ItemClassIdUOMNotRequired.length; n++) {
					if (ItemClassIdUOMNotRequired[n] == document
							.getElementById('itemClass' + i).value) {
						uomMatch = false;
						break;
					}

				}

				if (document.getElementById('uomQty' + i) && uomMatch) {
					if (document.getElementById('uomQty' + i).value == '') {
						alert('Please enter UOM Qty for Nip Medicine ' + j);
						return false;
					} else {
						var num = parseFloat(document.getElementById('uomQty'
								+ i).value, 10);
						if (num <= 0) {
							alert('UOM Qty should be greater than 0 for Nip Medicine '
									+ j);
							return false;
						}
					}
				}

				//
				if (document.getElementById('dosage' + i)) {
					if (document.getElementById('dosage' + i).value == '') {
						alert('Please enter dosage for Nip Medicine ' + j);
						return false;
					}
				}

				if (document.getElementById('frequency' + i)) {
					if (document.getElementById('frequency' + i).value == '0') {
						alert('Please select frequency for Nip Medicine ' + j);
						return false;
					}
				}

				if (document.getElementById('noOfDays' + i)) {
					if (document.getElementById('noOfDays' + i).value == '') {
						alert('Please Enter No. of Days. for Nip Medicine ' + j);
						return false;
					}
				}

			}
		}
	}
	return true;
}

function validateProcedure() {
	var count = document.getElementById('nursinghdb').value;
	for (var i = 0; i <= count; i++) {
		// var nomenclature = document.getElementById('nomenclature'+i).value;
		if (document.getElementById('procedureName_nursing' + i)) {
			if (document.getElementById('procedureName_nursing' + i).value != '') {
				if (document.getElementById('frequency_nursing' + i)) {
					if (document.getElementById('frequency_nursing' + i).value == '0') {
						alert('Please select frequency for procedure');
						return false;
					}
				}

				if (document.getElementById('noOfDays_nursing' + i)) {
					if (document.getElementById('noOfDays_nursing' + i).value == '') {
						alert('Please select days for frequency');
						return false;
					}
				}
			}
		}
	}
	return true;
}

function validateICD() {
	var icd = document.getElementById('diagnosisId');
	for (i = 0; i < icd.options.length; i++) {
		if (icd.options[i].value == 'NA'
				&& document.getElementById('initialDiagnosis').value.trim() == "") {
			alert("Working Diagnosis can't be blank");
			return false;
		}
	}
	return true;
}
function openPopupInvestigation(hinId) {
	var url = "/hms/hms/lab?method=viewAllTestForOrderNo&hinId=" + hinId;
	newwindow = window
			.open(url, 'name',
					"left=2,top=100,height=600,width=1010,status=1,scrollbars=1,resizable=0");
}

function openPopupRadioInvestigation(hinNo) {
	var url = "/hms/hms/opd?method=showPacsPendingJsp&hinNo=" + hinNo;
	newwindow = window
			.open(url, 'name',
					"left=2,top=100,height=600,width=1010,status=1,scrollbars=1,resizable=0");
}

function openDentalXray(hinNo) {
	var url = "/hms/hms/opd?method=showPreviousDentalXray&hinNo=" + hinNo;
	newwindow = window
			.open(url, 'name',
					"left=2,top=100,height=600,width=1010,status=1,scrollbars=1,resizable=0");
}

function validatePregnancy() {
	if (document.getElementById("pregnancy") != null
			&& document.getElementById("pregnancy").checked
			&& (document.getElementById('lmp_date').value == ""
					|| document.getElementById('edd').value == ""
					|| document.getElementById('currentEdd').value == "" || document
					.getElementById('operation_period_today').value == "")) {
		alert("LMP, EDD, Current EDD and Period of Gestation for today cannot be blank if patient is pregnant")
		return false;
	}
	return true;
}

function validateReferal() {
	var returnValue = true;

	if (document.getElementById('referral') == null)
		return returnValue;
	var referral = document.getElementById('referral').value;
	if (referral == '1') {
		if (document.getElementById('referInternal').checked
				|| (document.getElementById('referBoth') != null && document
						.getElementById('referBoth').checked)) {

			var hiddenValueRefer = document.getElementById('hiddenValueRefer').value;
			returnValue = false;
			for (var i = 1; i <= hiddenValueRefer; i++) {
				if (document.getElementById('refereddoctor' + i) != null
						&& document.getElementById('refereddoctor' + i).value != "0") {
					returnValue = true;
					break;
				}
			}
			if (!returnValue) {
				alert("Please Select Refer Doctor");
			}

		} else if (document.getElementById('referExternal').checked) {
			var refHosp = document.getElementById('referhospital').value;
			if (refHosp == 0) {
				alert("Please select hospital");
				returnValue = false;
			}
		}
	}

	return returnValue;
}
function validateAdmission() {
	if (document.getElementById('admissionAdvised')
			&& document.getElementById('admissionAdvised').checked) {

		var admissionWard = document.getElementById('admissionWard').value;
		if (admissionWard == 0) {
			alert("Select admission ward.");
			return false;
		}
	}
	return true;
}

function validateSurgery() {
	var count = document.getElementById('procCount').value;

	for (var i = 1; i <= count; i++) {

		if (document.getElementById('proscedureName' + i) != null
				&& document.getElementById('proscedureName' + i).value != ""
				&& document.getElementById('surgeryType' + i).value == "minor") {
			var msg = "";
			if (document.getElementById('tentativeDateId').value == "") {
				msg = "Enter Surgery Date\n";
			}

			if (document.getElementById('startTime').value == "") {
				msg += "Enter Surgery Start Time \n";
			}

			if (document.getElementById('endTime').value == "") {
				msg += "Enter Surgery End Time\n";
			}

			if (document.getElementById('deptId').value == "0") {
				msg += "Select Surgery Department\n";
			}

			if (document.getElementById('otId').value == "0") {
				msg += "Select OT\n";
			}
			if (document.getElementById('tableId').value == "0") {
				msg += "Select OT table\n";
			}
			if (msg != "") {
				alert(msg);
				return false;
			}

		}
	}
	return true;
}

// Major/Minor Surgery
function checkMappedChargeIP(val, count) {

	var index1 = val.lastIndexOf("[");
	var index2 = val.lastIndexOf("]");
	index1++;

	var id = val.substring(index1, index2);
	if (id == "") {

		document.getElementById('proscedureName' + count).value = "";

	}

	if (val != "") {

		document.getElementById("procedureId" + count).value = id;
		for (var xx = 1; xx < count; xx++) {
			if (document.getElementById("procedureId" + count) != null
					&& document.getElementById("procedureId" + xx) != null
					&& document.getElementById("procedureId" + count).value == document
							.getElementById("procedureId" + xx).value) {
				document.getElementById("procedureId" + count).value = "";
				document.getElementById("proscedureName" + count).value = "";
				alert("charge already taken");
				break;
			}

		}

	}

}

function getProcedureId(val, inc) {
	if (val != '') {
		var index1 = val.indexOf("[");
		var index2 = val.indexOf("]");
		index1++;
		var procName = val.substring(0, index1 - 1);
		var procId = val.substring(index1, index2);

		var index1 = val.lastIndexOf("[");
		var index2 = val.lastIndexOf("]");
		index1++;
		var procCode = val.substring(index1, index2);
		document.getElementById('proscedureName' + inc).value = procName;
		document.getElementById('procedureId' + inc).value = procId;
		// document.getElementById('procedurecode'+inc).value = procCode;

	} else {
		if (document.getElementById('proscedureName' + inc)) {
			document.getElementById('proscedureName' + inc).value = "";
			document.getElementById('procedureId' + inc).value = "";
			// document.getElementById('proDtId'+inc).value="";
			// document.getElementById('procRemarks'+inc).value="";
			// document.getElementById('procedurecode'+inc).value="";
		}
	}

}

function getSurgeryDiv(count) {

	// console.log();
	// var select = document.getElementById("pacstatus"+count);
	// var option = document.createElement('option');

	if (document.getElementById('proscedureName' + count).value != "") {
		if (document.getElementById('minorSurgery').checked) {
			// document.getElementById('pacstatus'+count).innerHTML = "";
			// option.text = option.value = "completed";
			// select.add(option, 0);
			document.getElementById('surgeryType' + count).value = "minor";
		} else if (document.getElementById('majorSurgery').checked) {
			// document.getElementById('pacstatus'+count).innerHTML = "";
			// option.text = option.value = "pending";
			// select.add(option, 0);
			document.getElementById('surgeryType' + count).value = "major";
		}

	}

	schedulingDiv(count);
	return;
}

function schedulingDiv(count) {
	// alert("gher");
	for (var xx = 1; xx <= count; xx++) {
		if (document.getElementById("surgeryType" + xx) != null
				&& document.getElementById("procedureId" + xx) != null
				&& document.getElementById("procedureId" + xx).value
				&& document.getElementById("surgeryType" + xx).value == 'minor') {
			document.getElementById("minorOTSchedulingDiv").style.display = 'block';

			return true;
		}
	}

	document.getElementById("minorOTSchedulingDiv").style.display = 'none';
	return false;
}

function checkSurgeryDate(tentativeDateId) {
	var surgeryDate = document.getElementById(tentativeDateId).value;
	if (surgeryDate == "") {
		alert("Select surgery date");
		var element = document.getElementById('deptId');
		element.value = "0";
		document.getElementById('startTime').value = '';
		document.getElementById('endTime').value = '';

		return false;
	}
	return true;
}
function displayOT(val) {
	var surgeryDate = document.getElementById('tentativeDateId').value;
	if (checkSurgeryDate('tentativeDateId'))
		ajaxFunctionDisplayOT('opdMain',
				'ot?method=displayDepartmentOT&deptId=' + val + "&surgeryDate="
						+ surgeryDate);

}

function onSelectSurgeryDate(sDate) {
	if (sDate != "") {
		currentDate = new Date();
		var month = currentDate.getMonth() + 1
		var day = currentDate.getDate()
		var year = currentDate.getFullYear()
		var seperator = "/"
		currentDate = new Date(month + seperator + day + seperator + year);

		var tentativeDate = new Date(sDate.substring(6),
				(sDate.substring(3, 5) - 1), sDate.substring(0, 2))
		if (tentativeDate < currentDate || tentativeDate == currentDate) {
			alert("Tentative Should be Future Date or Current Date.");
			document.getElementById('tentativeDateId').value = "";
			return false;
		}
	}

	document.getElementById('startTime').value = "";
	document.getElementById('endTime').value = "";
}

function addSurgicalRequRow() {

	var tbl = document.getElementById('surgicalGrid');
	// var hdbTabIndex =
	// parseInt(document.getElementById('usghdbTabIndex').value) + 1;
	// document.getElementById('usghdbTabIndex').value = hdbTabIndex;

	var lastRow = tbl.rows.length;

	// if there's no header row in the table, then iteration = lastRow + 1
	var iteration = lastRow;
	var row = tbl.insertRow(lastRow);
	var hdb = document.getElementById('procCount');
	iteration = parseInt(hdb.value) + 1;
	hdb.value = iteration;
	// document.getElementById('pulse').value=hdb.value;

	var cellRight1 = row.insertCell(0);
	cellRight1.innerHTML = iteration;

	/*
	 * var cellRight1 = row.insertCell(1);
	 * cellRight1.innerHTML=document.getElementById('admisDate').value;
	 * 
	 * var cellRight1 = row.insertCell(2);
	 * cellRight1.innerHTML=document.getElementById('UHID').value;
	 * 
	 * var cellRight1 = row.insertCell(3);
	 * cellRight1.innerHTML=document.getElementById('patName').value;
	 * 
	 * var cellRight1 = row.insertCell(4);
	 * cellRight1.innerHTML=document.getElementById('IPNo').value;
	 * 
	 * var cellRight1 = row.insertCell(5);
	 * cellRight1.innerHTML=document.getElementById('deptName').value;
	 */

	/*
	 * var cellRight1 = row.insertCell(6); cellRight1.innerHTML="";
	 */

	var cellRight1 = row.insertCell(1);
	var e1 = document.createElement('input');
	var e2 = document.createElement('input');
	e1.type = 'text';
	e2.type = 'hidden';
	e1.name = 'proscedureName' + iteration;
	e1.id = 'proscedureName' + iteration;
	e1.className = "opdTextBoxSmall textYellow";

	/*
	 * e1.onkeypress = function(event) {
	 * selectSNOMEDCT('ACTIVE','PROCEDURE','ALL',returnlimit_IN,callbck_index,'proscedureName'+iteration); };
	 */

	e1.onblur = function(event) {
		checkMappedChargeIP(this.value, iteration);
		getProcedureId(this.value, iteration);
		getSurgeryDiv(iteration);
	};
	var newdiv1 = document.createElement('div');
	newdiv1.id = 'ac2update2' + iteration;
	newdiv1.className = 'autocomplete';
	newdiv1.style.display = 'none';

	cellRight1.appendChild(e1);
	cellRight1.appendChild(newdiv1);

	new Ajax.Autocompleter('proscedureName' + iteration, 'ac2update2'
			+ iteration, 'ipd?method=checkMappedCharge',
			{
				minChars : 1,
				callback : function(element, entry) {
					return entry
							+ '&chargeName='
							+ document.getElementById('proscedureName'
									+ iteration).value + '&surgeryCheck='
							+ document.getElementById('surgeryCategory').value;
				},
				parameters : 'requiredField=proscedureName' + iteration
			});

	e2.name = 'procedureId' + iteration;
	e2.id = 'procedureId' + iteration;
	cellRight1.appendChild(e2);

	var e3 = document.createElement('input');
	e3.type = 'hidden';
	e3.name = 'surgeryType' + iteration;
	e3.id = 'surgeryType' + iteration;
	e3.value = '';
	cellRight1.appendChild(e3);

	// var cellRight1 = row.insertCell(2);
	// var e1 = document.createElement('select');
	/* e1.options[0] = new Option('Select', '0'); */
	// e1.options[0] = new Option('Pending', 'Pending');
	/*
	 * e1.options[2] = new Option('Clear', 'Cleared'); e1.options[3] = new
	 * Option('Not Fit', 'Not Fit');
	 */
	// e1.name = 'pacstatus' + iteration;
	// e1.id = 'pacstatus' + iteration;
	// cellRight1.appendChild(e1);
	var cellRight1 = row.insertCell(2);
	var e1 = document.createElement('input');
	e1.type = 'checkbox';
	e1.name = 'surgeryradio' + iteration;
	e1.id = 'surgeryradio' + iteration;
	e1.className = 'smalll';

	/*
	 * var e2 = document.createElement('input'); e2.type = 'hidden'; e2.name =
	 * 'inpatientId' + iteration; e2.id = 'inpatientId' + iteration;
	 * e2.value=document.getElementById('inpatientId').value;
	 * 
	 * var e3 = document.createElement('input'); e3.type = 'hidden'; e3.name =
	 * 'hinId' + iteration; e3.id = 'hinId' + iteration;
	 * e3.value=document.getElementById('hinId').value;
	 */
	cellRight1.appendChild(e1);
	// cellRight1.appendChild(e2);
	// cellRight1.appendChild(e3);

}

function removeSurgicalRow(form) {
	var tbl = document.getElementById(form);
	var lastRow = tbl.rows.length;
	var hdb;
	var radio = "";
	if (form == 'surgicalGrid') {
		hdb = document.getElementById('procCount');
		radio = "surgeryradio";
	}

	var iteration = parseInt(hdb.value);
	var totalSelected = 0;
	if (confirm("Do you want to delete !")) {
		for (var i = 0; i <= iteration; i++) {
			if (document.getElementById(radio + i) != null
					&& (typeof document.getElementById(radio + i).checked) != 'undefined'
					&& document.getElementById(radio + i).checked) {
				totalSelected = totalSelected + 1;
			}
		}

		if (totalSelected == 0) {
			alert('Please select atleast 1 row to delete');
		}
		/*
		 * else if(lastRow==2 || lastRow==(totalSelected+1)) { alert('You can
		 * not delete all Row.'); } else if (lastRow > 2){
		 */
		for (var i = 0; i <= iteration; i++) {
			if (document.getElementById(radio + i) != null
					&& (typeof document.getElementById(radio + i).checked) != 'undefined'
					&& document.getElementById(radio + i).checked) {
				var deleteRow = document.getElementById(radio + i).parentNode.parentNode;
				document.getElementById(radio + i).parentNode.parentNode.parentNode
						.removeChild(deleteRow);
			}
		}

	}
}

function ajaxFunctionDisplayOT(formName, action) {

	var xmlHttp;
	try {
		// Firefox, Opera 8.0+, Safari
		xmlHttp = new XMLHttpRequest();
	} catch (e) {
		// Internet Explorer
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			alert(e)
			try {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
				alert("Your browser does not support AJAX!");
				return false;
			}
		}
	}
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {

			var items = xmlHttp.responseXML.getElementsByTagName('items')[0];

			// var brandId="brandId"+rowVal;
			var OtId = "otId";
			// var batchName ="batchName"+rowVal;
			// alert(batchName);
			// obj1 =document.getElementById(brandId);
			obj = document.getElementById(OtId);
			// obj1 = document.getElementById(batchName);
			obj.length = 1;
			// obj1.length =1;

			for (loop = 0; loop < items.childNodes.length; loop++) {
				var item = items.childNodes[loop];
				var batchLength = item.getElementsByTagName("tables")[0];

				for (innerLoop = 0; innerLoop < batchLength.childNodes.length; innerLoop++) {
					var table = batchLength.childNodes[innerLoop];
					var tableId = table.getElementsByTagName("tableId")[0];
					var tableNo = table.getElementsByTagName("tableNo")[0];
					obj.length++;
					obj.options[obj.length - 1].value = tableId.childNodes[0].nodeValue;
					obj.options[obj.length - 1].text = tableNo.childNodes[0].nodeValue;

				}

				/*
				 * for(innerLoop = 0;innerLoop <
				 * brandLength.childNodes.length;innerLoop++){ var brand =
				 * brandLength.childNodes[innerLoop]; var brandId =
				 * brand.getElementsByTagName("brandId")[0]; var brandName =
				 * brand.getElementsByTagName("brandName")[0];
				 * 
				 * obj1.length++;
				 * obj1.options[obj1.length-1].value=brandId.childNodes[0].nodeValue;
				 * obj1.options[obj1.length-1].text=brandName.childNodes[0].nodeValue; }
				 */

			}
		}
	}
	// var url=action+"&"+getNameAndData(formName);
	// url = url+'&'+csrfTokenName+'='+csrfTokenValue; // added by amit das on
	// 07-07-2016

	var url = action + "&" + getNameAndData(formName);
	xmlHttp.open("GET", url, true);
	xmlHttp.setRequestHeader("Content-Type", "text/xml");
	xmlHttp.send(null);

}

function ajaxFunctionDisplayOtTable(formName, action) {

	var xmlHttp;
	try {
		// Firefox, Opera 8.0+, Safari
		xmlHttp = new XMLHttpRequest();
	} catch (e) {
		// Internet Explorer
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			alert(e)
			try {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
				alert("Your browser does not support AJAX!");
				return false;
			}
		}
	}
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {

			var items = xmlHttp.responseXML.getElementsByTagName('items')[0];

			// var brandId="brandId"+rowVal;
			var tableId = "tableId";
			// var batchName ="batchName"+rowVal;
			// alert(batchName);
			// obj1 =document.getElementById(brandId);
			obj = document.getElementById(tableId);
			// obj1 = document.getElementById(batchName);
			obj.length = 1;
			// obj1.length =1;

			for (loop = 0; loop < items.childNodes.length; loop++) {
				var item = items.childNodes[loop];
				var batchLength = item.getElementsByTagName("tables")[0];

				for (innerLoop = 0; innerLoop < batchLength.childNodes.length; innerLoop++) {
					var table = batchLength.childNodes[innerLoop];
					var tableId = table.getElementsByTagName("tableId")[0];
					var tableNo = table.getElementsByTagName("tableNo")[0];
					obj.length++;
					obj.options[obj.length - 1].value = tableId.childNodes[0].nodeValue;
					obj.options[obj.length - 1].text = tableNo.childNodes[0].nodeValue;

				}

				/*
				 * for(innerLoop = 0;innerLoop <
				 * brandLength.childNodes.length;innerLoop++){ var brand =
				 * brandLength.childNodes[innerLoop]; var brandId =
				 * brand.getElementsByTagName("brandId")[0]; var brandName =
				 * brand.getElementsByTagName("brandName")[0];
				 * 
				 * obj1.length++;
				 * obj1.options[obj1.length-1].value=brandId.childNodes[0].nodeValue;
				 * obj1.options[obj1.length-1].text=brandName.childNodes[0].nodeValue; }
				 */

			}
		}
	}
	var url = action + "&" + getNameAndData(formName);

	xmlHttp.open("GET", url, true);
	xmlHttp.setRequestHeader("Content-Type", "text/xml");
	xmlHttp.send(null);

}

function displayTable(val, startTime, endTime, formName, minorOt) {
	startTime = startTime.value;
	endTime = endTime.value;

	var st = startTime.split(":");
	var stsec = parseInt(st[1]) + 1;
	if (stsec.toString().length == 1)
		startTime = st[0] + ':0' + stsec;
	else
		startTime = st[0] + ':' + stsec;

	var st = endTime.split(":");
	var stsec = parseInt(st[1]) + 1;
	if (stsec.toString().length == 1)
		endTime = st[0] + ':0' + stsec;
	else
		endTime = st[0] + ':' + stsec;

	var surgeryDate = document.getElementById('tentativeDateId').value;
	if (minorOt == undefined)
		minorOt = 'n';

	ajaxFunctionDisplayOtTable(formName,
			'ot?method=displayOtTableForDepartmentWiseOT&otId=' + val
					+ "&surgeryDate=" + surgeryDate + "&minorOt=" + minorOt);

}

function validateNursingCare(val, count) {
	var index1 = val.lastIndexOf("[");
	var index2 = val.lastIndexOf("]");
	index1++;

	var id = val.substring(index1, index2);
	if (id == "") {
		document.getElementById('procedureName_nursing' + count).value = "";
	} else
		document.getElementById("procedureType" + count).value = document
				.getElementById("nursingCategory").value;

	if (document.getElementById("nursingCategory").value == document
			.getElementById("nurCodePhy").value) {
		document.getElementById('frequency_nursing' + count).value = "1";
		document.getElementById('noOfDays_nursing' + count).value = "7";
		document.getElementById('frequency_nursing' + count).disabled = true;
		document.getElementById('noOfDays_nursing' + count).readOnly = true;
	} else {
		document.getElementById('frequency_nursing' + count).value = "0";
		document.getElementById('noOfDays_nursing' + count).value = "";
		document.getElementById('frequency_nursing' + count).disabled = false;
		document.getElementById('noOfDays_nursing' + count).readOnly = false;
	}

}

function validateTherapy() {
	var therapyhdb = -1;
	if (document.getElementById("therapyhdb") != null)
		therapyhdb = document.getElementById("therapyhdb").value;
	for (var inc = 0; inc <= therapyhdb; inc++) {
		if (document.getElementById("therapy_nursing" + inc) != null
				&& document.getElementById("therapy_nursing" + inc).value != "") {
			var currentDate = new Date();
			// appointSt = document.getElementById("appointStatus"+inc).value;
			var appointmentDate = document.getElementById("appointmentDate"
					+ inc).value;
			var appointTime = document.getElementById("appointmentTime" + inc).value;

			if (document.getElementById("proc_treatment_teeth" + inc) != null
					&& document.getElementById("proc_treatment_teeth" + inc).value == "") {
				alert("Please enter teeth for procedure");
				return false;
			}
			if (!document.getElementById("close" + inc).checked
					&& appointmentDate == "") {
				alert("Please enter appointment Date");
				return false;
			} else if (validateDate(appointmentDate, "appointmentDate" + inc) == false) {
				return false;
			}

			if (!document.getElementById("close" + inc).checked
					&& appointTime == "") {
				alert("Please enter appointment time");
				return false;
			}
		}

	}

	return true;
}

function validateDate(dateValue, varId) {

	if (dateValue != "") {
		currentDate = new Date();
		var month = currentDate.getMonth() + 1
		var day = currentDate.getDate()
		var year = currentDate.getFullYear()
		var seperator = "/"
		currentDate = new Date(month + seperator + day + seperator + year);

		var tentativeDate = new Date(dateValue.substring(6), (dateValue
				.substring(3, 5) - 1), dateValue.substring(0, 2))
		if (tentativeDate < currentDate || tentativeDate == currentDate) {
			alert("Tentative Should be Future Date or Current Date.");
			document.getElementById(varId).value = "";
			return false;
		}
	}
}

function toggleDiv(divId, btn) {
	var d = document.getElementById(divId);
	if (d.style.display == 'none') {
		document.getElementById(btn).value = "-";
		d.style.display = 'block';
	} else {
		document.getElementById(btn).value = "+";
		d.style.display = 'none';
	}
}

/*
 * function callAutoComplete(val){
 * 
 * autocomplete(val, arryNomenclature); }
 */
var countRecall=0;
function addNomenclatureRow() {
	 var tbl = document.getElementById('nomenclatureGrid');
		var lastRow = tbl.rows.length;
		countRecall=lastRow+1;
	
	var aClone = $('#nomenclatureGrid>tr:last').clone(true)
	aClone.find(":input").val("");
	aClone.find('input[type="text"]').prop('id', 'nomenclature1'+countRecall+'');
	aClone.find("td:eq(8)").find(":input").prop('id', 'itemIdNom'+countRecall+'');
	aClone.find("td:eq(12)").find(":input").prop('id', 'itemClassId'+countRecall+'');
	aClone.find("td:eq(13)").find(":input").prop('id', 'treatmentAuditFlag'+countRecall+'');
	aClone.find("option[selected]").removeAttr("selected")
	aClone.find("td:eq(0)").find(":input").css('border', '1px solid #ced4da');
	aClone.clone(true).appendTo('#nomenclatureGrid');
	var val = $('#nomenclatureGrid>tr:last').find("td:eq(0)").find(":input")[0];
	//autocomplete(val, arryNomenclature);
	
}

var countcurrent=211;
function addNomenclatureRowCurrentMedication() {
	 var tbl = document.getElementById('nomenclatureGrid');
		var lastRow = tbl.rows.length;
		countcurrent=lastRow+1;
		var aClone = $('#nomenclatureGrid>tr:last').clone(true)
	var aClone = $('#nomenclatureGrid>tr:last').clone(true)
	aClone.find(":input").val("");
	aClone.find('input[type="text"]').prop('id', 'nomenclature1'+countcurrent+'');
	aClone.find("td:eq(8)").find(":input").prop('id', 'itemIdNom'+countcurrent+'');
	aClone.find("option[selected]").removeAttr("selected")
	aClone.clone(true).appendTo('#nomenclatureGrid');
	var val = $('#nomenclatureGrid>tr:last').find("td:eq(0)").find(":input")[0];
	//autocomplete(val, arryNomenclature);
	
}



$(document).ready(function() {

	function deleteAllCookies() {
	    var cookies = document.cookie.split(";");

	    for (var i = 0; i < cookies.length; i++) {
	        var cookie = cookies[i];
	        var eqPos = cookie.indexOf("=");
	        var name = eqPos > -1 ? cookie.substr(0, eqPos) : cookie;
	        document.cookie = name + "=;expires=Thu, 01 Jan 1970 00:00:00 GMT";
	    }
	}
	
	getFrequencyDetail();
	geTreatmentInstructionData();
	getTemplateDetail();
	getTreatmentTemplateDetail();
	getDispUnitDetail();
	getItemClass();
	getTemplateDetailMedicalAdvice();
	//getMastStoreItemNip();
	//getMastNursingCare();
	//getDepartmentId();

		
})


function getTemplateDetail() {

	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getTemplateName";
	
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'doctorId' : uId,
					'templateType' : 'I'
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

					$('#dgInvestigationTemplateId').html(trHTML);
					$('#updateInvestigationTemplateId').html(trHTML);
					$('#dgInvestigationTemplateIdInvest').html(trHTML);
					
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

function getTreatmentTemplateDetail() {

	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getTemplateName";
	
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'doctorId' : uId,
					'templateType' : 'T'
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
					var datas = response.template;
					var trHTML = '<option value=""><strong>Select...</strong></option>';
					$.each(datas, function(i, item) {
						trHTML += '<option value="' + item.templateId + '" >'
								+ item.templateName + '</option>';
					});

					$('#treatmentTemplateId').html(trHTML);
					$('#updatetreatmentTemplateId').html(trHTML);
					getFrequencyDetail();
					geTreatmentInstructionData()
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



$(document).delegate("#dgInvestigationTemplateId","change",
		function() {


	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getTemplateInvestigation";
	
	// var url =
	// "http://localhost:8181/AshaServices/v0.1/opdmaster/getTemplateInvestData";
	
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'employeeId' : '1',
					'templateId':$('#dgInvestigationTemplateId').val()
				}),
				contentType : "application/json",
				type : "POST",
						success : function(response) {
							// console.log(response);
							if (response.status == 1 &&  $('#dgInvestigationTemplateId').val()!="" 
								&&  $('#dgInvestigationTemplateId').val()!=undefined 
								&&  $('#dgInvestigationTemplateId').val()!=null) {
								// $("#dgInvetigationGrid tr").remove();
								var datas = response.data;
								$("#dgInvetigationGrid tr").remove();
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
													
													
													count=parseInt(count)+parseInt(investigationId);
													if (flagForcheck1 == true) {
														trHTML += '<tr>';
														trHTML += '<td><div class="autocomplete forTableResp">';
														trHTML += '<input type="text" size="44" autocomplete="never" value="' + investigationValue + '[' + investigationId + ']" id="chargeCodeName' + i + '"';
														//trHTML += ' class="form-control border-input" name="chargeCodeName" onKeyPress="autoCompleteCommon(this,1);" onblur="populateChargeCode(this.value,1,this);"/>';
														trHTML += ' class="form-control border-input" name="chargeCodeName" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
														trHTML += '<input type="hidden" id="qty" tabindex="1" name="qty1"  maxlength="6"/>';
														trHTML += '<input type="hidden" tabindex="1" id="chargeCodeCode' + count + '"';
														trHTML += 'name="chargeCodeCode"  readonly />';
														trHTML += '<input type="hidden"  name="investigationIdValue" value="'+ investigationId + '"  id="investigationIdValue' + count + '"/>';

														trHTML += '<input type="hidden"  name="dgOrderDtIdValue" value="" id="dgOrderDtIdValue' + count + '"/>';
														trHTML += '<input type="hidden"  name="dgOrderHdId" value="" id="dgOrderHdId' + count + '"/>';

														trHTML+=' <div id="investigationDiv'+count+'" class="autocomplete-itemsNew"></div>';
														trHTML += ' </div></td>';
														
														
														
														
														
														
														trHTML += '<td style="display:none";><input type="hidden"  name="investigationIdValue" value="'+ investigationId + '"  id="investigationIdValue' + count + '"/></td>';

														
														
														trHTML += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth" button-type="add" value="" ';
														trHTML += 'onclick="addRowForInvestigation();"';
														trHTML += '	tabindex="1" ></button></td>';

														trHTML += '<td><button type="button" name="delete" value="" button-type="delete" id="deleteInves"';
														trHTML += 'class="buttonDel btn btn-danger noMinWidth"';
														trHTML += 'onclick="removeRowInvestigationOpd(this,\'' + investigationGridValue + '\',);"';
														trHTML += '	tabindex="1" ></button></td>';
														trHTML += '<td style="display: none";>';
														trHTML += ' <input type="hidden" value="T" tabindex="1" id="invetgationAuditFlag" size="77" name="invetgationAuditFlag" />';
														trHTML += '</td>';
														trHTML += ' </tr> ';
													}
													count++;

												});
								$('#dgInvetigationGrid').append(trHTML);
							
							} else {
								 $("#dgInvetigationGrid tr").remove();
								 var trHTML="";
								 trHTML = '<tr>';
									trHTML += '<td><div class="autocomplete forTableResp">';
									trHTML += '<input type="text" size="44" autocomplete="never" value="" id="chargeCodeName' + i + '"';
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
									
							
									
									trHTML += '<td style="display:none";><input type="hidden"  name="investigationIdValue" value=""  id="investigationIdValue' + count + '"/></td>';

								
									
									trHTML += '<td><button name="Button" type="button"   class="buttonAdd btn btn-primary noMinWidth" button-type="add" value="" ';
									trHTML += 'onclick="addRowForInvestigationFun();"';
									trHTML += '	tabindex="1" ></button></td>';

									trHTML += '<td><button type="button" name="delete" value="" button-type="delete" id="deleteInves"';
									trHTML += 'class="buttonDel btn btn-danger noMinWidth"';
									trHTML += 'onclick="removeRowInvestigation(this);"';
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

$(document).delegate("#updateInvestigationTemplateId","change",
		function() {


	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getTemplateInvestigation";
	var opdTemplateName=document.getElementById('updateInvestigationTemplateId');
	var nameTemp = opdTemplateName.options[opdTemplateName.selectedIndex].text;
	var valueTemp = opdTemplateName.options[opdTemplateName.selectedIndex].value;
	document.getElementById("invTemplateName").value=nameTemp;
	document.getElementById("invTemplateId").value=valueTemp;
	// var url =
	// "http://localhost:8181/AshaServices/v0.1/opdmaster/getTemplateInvestData";
	
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'employeeId' : '1',
					'templateId':$('#updateInvestigationTemplateId').val()
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
				   if (response.status == 1) {
					$("#grid tr").remove(); 
					var datas = response.data;
					var trHTML = '';
					var i=50;
					var investigationGridValidate="grid";
					
					$.each(datas, function(i, item) {
								var investigationValue=item.investigationName;
								var investigationId=item.templateInvestgationId;
								var investigationDataId=item.templateDataId;
				        		var dgOrderDtIdTemp=investigationDataId;
									trHTML+='<tr><td> <div class="autocomplete"><input type="text" value="'+investigationValue+''+'['+investigationId+']'+'" id="chargeCodeNameTemplate" autocomplete="off"  class="form-control border-input" name="chargeCodeNameTemplate"  size="44" onblur="populateChargeCodeTemplate(this.value,1,this);" disabled /></div></td>	<td><button type="button" class="btn btn-primary buttonAdd noMinWidth" name="button" button-type="add" value="" onclick="addInvetigationRow()" tabindex="1"></button></td><td><button type="button" class="buttonDel  btn btn-danger noMinWidth" name="button" button-type="delete" id="deleteTemp'+investigationId+'" value="" onclick="removeTemplateVal(this,\'' + investigationGridValidate + '\',\''+ dgOrderDtIdTemp + '\');" tabindex="1"></button></td><td style="display: none;"><input type="hidden" value="'+investigationId+'" tabindex="1" id="InvestigationIdTemplate'+i+'" size="77" name="InvestigationIdTemplate" /></td><td style="display: none;"><input type="hidden" value="'+investigationDataId+'" tabindex="1" id="investigationDataId'+i+'" size="77" name="investigationDataId" /></td><td style="display: none;"><input type="hidden" value="old" tabindex="1" id="investigationDataOld'+i+'" size="77" name="investigationDataId" /></td></tr>';
									i++;
									
													
					});
					
					$('.showOntemplate').show()
					$('#grid').append(trHTML);
					
					// $('#investigationGrid').html(trHTML);

				}
				   else
					{
					   $("#grid tr").remove(); 
					  
					  
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

$(document).delegate("#treatmentTemplateId","change",
		function() {


	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getTemplateTreatment";
	
	// var url =
	// "http://localhost:8181/AshaServices/v0.1/opdmaster/getTemplateInvestData";
	
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'employeeId' : '1',
					'templateId':$('#treatmentTemplateId').val(),
					"mmuId1":hsId,
					"flag":"OPD",
					"departmentId":$('#departmentId').val()
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
				   if (response.status == 1) {
					//$("#nomenclatureGrid tr").remove(); 
				    var tbDgnomenclatureGrid = document.getElementById('nomenclatureGrid');
					var lastRow = tbDgnomenclatureGrid.rows.length;
					//count=lastRow;
					//count++;
					if(lastRow==1){
							$("#nomenclatureGrid tr").remove();
					}  
					var datas = response.data;
					var trHTML = '';
					var i=0;
					var formFlag=$('#formFlag').val();
					if(formFlag=='recall'){
						return getTreatmentGrideValue(datas);
					}
					else{
					$.each(datas, function(i, item) {
						var flagForcheck1 = true;
								    var treatmentItemId=item.treatmentItemId;
									var itemIdName=item.itemIdName;
									var dosage=item.dosage;
									var itemClassId=item.itemClassId;
									var itemIdCode=item.itemIdCode;
									var frequencyId=item.frequencyId;
									var frequencyName=item.frequencyName;
									var total=item.total;
									var noOfDays=item.noOfDays;
									var instrcution=item.instrcution;
									var dispUnit=item.dispUnit;
									var availableStock=item.availableStock;
									
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
									
									if(flagForcheck1== true)
									{
									if(availableStock==0)
								    {
									trHTML='<tr><td><div class="autocomplete forTableResp"><input style="border: 5px solid red" type="text" value="'+itemIdName+''+'['+itemIdCode+']'+'" tabindex="1" id="nomenclature11'+i+'""  size="77" name="nomenclature1" class="form-control width330" onKeyUp="getNomenClatureList(this,\''+funcTr+'\',\''+urlTr+'\',\''+urlNameTr+'\',\''+flagaTr+'\');" /> <div id="nomenclatureIdPvs" class="autocomplete-itemsNew"></div></div></td>';
								    }
									else
									{
									  trHTML='<tr><td><div class="autocomplete forTableResp"><input type="text" value="'+itemIdName+''+'['+itemIdCode+']'+'" tabindex="1" id="nomenclature11'+i+'""  size="77" name="nomenclature1" class="form-control width330" onKeyUp="getNomenClatureList(this,\''+funcTr+'\',\''+urlTr+'\',\''+urlNameTr+'\',\''+flagaTr+'\');" /> <div id="nomenclatureIdPvs" class="autocomplete-itemsNew"></div></div></td>';	
									}	
									trHTML += '<td ><select name="au1Treatment" id="au1Treatment'+i+'" class="medium form-control width100"';
									trHTML += '<option value=""><strong>Select</strong></option>';

									var selectFre = "";
									$.each(masDispUnitList, function(ijk, item1) {

										if (dispUnit == item1.storeUnitName) {
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
									trHTML +='<td><input type="text" name="dosage1" onkeypress="return event.charCode != 32" onblur="fillValueNomenclature()" tabindex="1" value="'+dosage+'" id="dosage1'+i+'" size="5" maxlength="5" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  class="form-control width60" /></td>';
		            				trHTML +='<td><select name="frequency1" id="frequency1" onchange="fillValueNomenclature()" class="medium form-control width150"';
									trHTML +='class="medium">';
									trHTML +='<option value=""><strong>Select...</strong></option>';
									$.each(massFrequencyList, function(ij, item) {
									    
																				
										if(frequencyId == item.frequencyId){
											selectFre="selected";
										}
										else{
											selectFre="";
										}
										
										trHTML += '<option '+selectFre+' value="' + item.feq + '@'
										+ item.frequencyId + '" >' + item.frequencyName+'</option>';
									
									//trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationValue+''+'['+investigationId+']'+'" id="chargeCodeName" class="form-control border-input" name="chargeCodeName" onblur="populateChargeCode(this.value);putInvestigationValue(this)" /> <input type="hidden" id="qty" tabindex="1" name="qty1" size="10" maxlength="6" validate="Qty,num,no" /> <input type="hidden" tabindex="1" id="chargeCodeCode"	name="chargeCodeCode" size="10" readonly /> </div></td><td><input type="Date" id="investigationDate1" name="investigationDate" class="input_date" placeholder="DD/MM/YYYY" value="" maxlength="10" /></td><td><div class="labRadiologyDivfixed"></div> <input type="radio" value="I" id="othAfLab1'+i+'" class="radioCheckCol2" style="margin-right: 15px;" name="labradiologyCheck1'+i+'" /></td><td><div class="labRadiologyDivfixed"></div> <input type="radio" value="O" id="othAfLab1'+i+'" class="radioCheckCol2" style="margin-right: 15px;" name="labradiologyCheck1'+i+'"/></td><td><input type="checkbox" name="urgent" id="uCheck" tabindex="1" class="radioAuto" value="1" /><td style="display:none";><input type="hidden" value="'+investigationId+'" tabindex="1" id="inestigationIdval" size="77" name="inestigationIdval" /></td> </td><td><button type="button" type="button" class="btn btn-primary buttonAdd" value="" tabindex="1"	onclick="addRowForInvestigation();">Add</button></td><td><button type="button" name="delete" value="" class="buttonDel btn btn-danger" tabindex="1" onclick="removeRow("dgInvetigationGrid","hiddenValue",this);">Delete</button></td></tr>';
									});
									trHTML +='</select>';
									trHTML +='</td>';
									trHTML+='<td><input type="text" name="noOfDays1" onkeypress="return event.charCode != 32" value="'+noOfDays+'" tabindex="1" id="noOfDays1'+i+'" onblur="fillValueNomenclature()" size="5" maxlength="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" class="form-control width60" /></td><td><input type="text" onkeypress="return event.charCode != 32" value="'+total+'" name="total1" tabindex="1" id="total1'+i+'" size="5" validate="total,num,no" class="form-control width70"/></td>';
									trHTML +='<td><select name="instuctionFill" id="instuctionFill'+i+'" class="medium form-control width150"';
									trHTML +='class="medium">';
									trHTML +='<option value=""><strong>Select...</strong></option>';
									var instctionData=massTempInstructionList;
									$.each(massTempInstructionList, function(ik, item) {
									    
																				
										if(instrcution == item.instructionsName){
											selectInst="selected";
										}
										else{
											selectInst="";
										}
										
										trHTML += '<option '+selectInst+' value="'+ item.instructionsName +'">' + item.instructionsName+'</option>';
									
									//trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationValue+''+'['+investigationId+']'+'" id="chargeCodeName" class="form-control border-input" name="chargeCodeName" onblur="populateChargeCode(this.value);putInvestigationValue(this)" /> <input type="hidden" id="qty" tabindex="1" name="qty1" size="10" maxlength="6" validate="Qty,num,no" /> <input type="hidden" tabindex="1" id="chargeCodeCode"	name="chargeCodeCode" size="10" readonly /> </div></td><td><input type="Date" id="investigationDate1" name="investigationDate" class="input_date" placeholder="DD/MM/YYYY" value="" maxlength="10" /></td><td><div class="labRadiologyDivfixed"></div> <input type="radio" value="I" id="othAfLab1'+i+'" class="radioCheckCol2" style="margin-right: 15px;" name="labradiologyCheck1'+i+'" /></td><td><div class="labRadiologyDivfixed"></div> <input type="radio" value="O" id="othAfLab1'+i+'" class="radioCheckCol2" style="margin-right: 15px;" name="labradiologyCheck1'+i+'"/></td><td><input type="checkbox" name="urgent" id="uCheck" tabindex="1" class="radioAuto" value="1" /><td style="display:none";><input type="hidden" value="'+investigationId+'" tabindex="1" id="inestigationIdval" size="77" name="inestigationIdval" /></td> </td><td><button type="button" type="button" class="btn btn-primary buttonAdd" value="" tabindex="1"	onclick="addRowForInvestigation();">Add</button></td><td><button type="button" name="delete" value="" class="buttonDel btn btn-danger" tabindex="1" onclick="removeRow("dgInvetigationGrid","hiddenValue",this);">Delete</button></td></tr>';
									});
									trHTML +='</select>';
									trHTML +='</td>';
							    	trHTML +='<td><input type="text" name="closingStock1" value="'+availableStock+'" tabindex="1" id="closingStock1" size="3" class="form-control width80" readonly /></td>';
							    	trHTML +='<td style="display: none;"><input type="hidden" value="'+treatmentItemId+'" tabindex="1" id="itemIdNom11'+i+'" size="77" name="itemIdNom" /></td><td><button type="button" class="btn btn-primary buttonAdd noMinWidth" name="button" button-type="add" value="" onclick="addNomenclatureRow();" tabindex="1"></button></td><td><button type="button" class="buttonDel  btn btn-danger noMinWidth" name="button" id="deleteNomenclature" button-type="delete" value="" onclick="removeTreatmentRow(this);"" tabindex="1"></button></td><td style="display: none;"><input type="hidden" name="pvmsNo1" tabindex="1" id="pvmsNo1" size="10" readonly="readonly" /></td><td style="display: none;"><input type="hidden" name="itemClassId" tabindex="1" id="itemClassId" value="'+itemClassId+'" size="10" readonly="readonly" /><td style="display: none";><input type="hidden" value="T" tabindex="1" id="treatmentAuditFlag" size="77" name="treatmentAuditFlag" /></td>	</td>';
							    	trHTML +='</tr>';
							    	
									}
									
									i++;
									
									$('#nomenclatureGrid').append(trHTML);						
					});
				   }
				
				
				}
				   else
					{
					   
					   $("#nomenclatureGrid tr").remove(); 
					   func1='populatePVMS';
			    		 url1='opd';
			    		 url2='getMasStoreItemList';
			    		 flaga='numenclature';
					   var htmlBlank='';
					   htmlBlank='<tr><td><div class="autocomplete forTableResp"><input type="text" value="" tabindex="1" id="nomenclature1"  size="77" name="nomenclature1" class="form-control border-input" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" /> <div id="nomenclatureIdPvs" class="autocomplete-itemsNew"></div></div></td><td><select name="au1Treatment" id="au1Treatment" class="medium form-control width100" ></select></td><td><input type="text" name="dosage1" onblur="fillValueNomenclature()" tabindex="1" value="" id="dosage1" size="5" maxlength="5" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  class="form-control" /></td>';
					   htmlBlank +='<td><select name="frequency1" id="frequency1" onchange="fillValueNomenclature()" class="medium form-control"> </select></td>';
         				htmlBlank+='<td><input type="text" name="noOfDays1" value="" tabindex="1" id="noOfDays1" onblur="noOfDaysAlert(this.value,this)" size="5" maxlength="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"   class="form-control" /></td> <td><input type="text" value=""  name="total1" tabindex="1" id="total1" size="5" validate="total,num,no" class="form-control"/></td><td><select name="instuctionFill" id="instuctionFill" class="medium form-control"> </select></td><td><input type="text" name="closingStock1" tabindex="1" value="" id="closingStock1" size="3" validate="closingStock,string,no"   class="form-control" /></td><td style="display: none;"><input type="hidden" value="" tabindex="1" id="itemIdNom" size="77" name="itemIdNom" /></td><td><button type="button" class="btn btn-primary buttonAdd noMinWidth" name="button" button-type="add" value="" onclick="addNomenclatureRow();" tabindex="1"></button></td><td><button type="button" class="buttonDel  btn btn-danger noMinWidth" name="button" id="deleteNomenclature" button-type="delete" value="" onclick="removeTreatmentRow(this);"" tabindex="1"></button></td><td style="display: none;"><input type="hidden" name="pvmsNo1" tabindex="1" id="pvmsNo1" size="10" readonly="readonly" /></td></tr>';
         				$('#nomenclatureGrid').append(htmlBlank);
         				getFrequencyDetail();
         				geTreatmentInstructionData();
         				getDispUnitDetail();
         				 var val=$('#nomenclatureGrid').children('tr:first').children('td:eq(0)').find(':input')[0]
         	            // autocomplete(val, arryNomenclature);
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

$(document).delegate("#updatetreatmentTemplateId","change",
		function() {

	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getTemplateTreatment";
	
	var opdTemplateName=document.getElementById('updatetreatmentTemplateId');
	var nameTemp = opdTemplateName.options[opdTemplateName.selectedIndex].text;
	var valueTemp = opdTemplateName.options[opdTemplateName.selectedIndex].value;
	document.getElementById("updateTemplateName").value=nameTemp;
	document.getElementById("treatmentTemplateId").value=valueTemp;
	
	// var url =
	// "http://localhost:8181/AshaServices/v0.1/opdmaster/getTemplateInvestData";
	
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'employeeId' : '1',
					'templateId':$('#updatetreatmentTemplateId').val(),
					"mmuId1":hsId,
					"flag":"OPD",
					"departmentId":$('#departmentId').val()
				}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
				   if (response.status == 1) {
					$("#nomenclatureUpdateGridTemplate tr").remove(); 
					var datas = response.data;
					var trHTML = '';
					var i=0;
					$.each(datas, function(i, item) {
								    var treatmentItemId=item.treatmentItemId;
									var itemIdName=item.itemIdName;
									var dosage=item.dosage;
									var itemIdCode=item.itemIdCode;
									var itemClassId=item.itemClassId;
									var frequencyId=item.frequencyId;
									var frequencyName=item.frequencyName;
									var total=item.total;
									var noOfDays=item.noOfDays;
									var instrcution=item.instrcution;
									var dispUnit=item.dispUnit;
									var treatmentTemplPId=item.treatmentTemplPId;
									var nomenclatureUpdateGridTemplate="nomenclatureUpdateGridTemplate";
									var selectFre="";
									var selectInst="";
									var dispStock="";
									var funcTr='populatePVMS';
									var  urlTr='opd';
									var urlNameTr='getMasStoreItemList';
									var flagaTr='numenclature';
									
									
									trHTML='<tr><td><div class="autocomplete "><input type="text" value="'+itemIdName+''+'['+itemIdCode+']'+'" tabindex="1" id="nomenclature11'+i+'""  size="77" name="nomenclature1" class="form-control width330" onblur="updatePopulatePVMSTemplate(this.value,1,this);" /> <div id="nomenclatureIdPvs" class="autocomplete-itemsNew"></div></div></td>';
									trHTML += '<td ><select name="dispensingUnit1" class="form-control" id="dispensingUnit1'+ i + '" ';
									trHTML += 'class="medium">';
									trHTML += '<option value=""><strong>Select</strong></option>';

									var selectFre = "";
									$.each(masDispUnitList, function(ijk, item1) {

										if (dispUnit == item1.storeUnitName) {
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
									trHTML +='<td><input type="text" name="dosage1" onkeypress="return event.charCode != 32" onblur="updateFillValueNomenclatureTemplate(this)" tabindex="1" value="'+dosage+'" id="dosage1'+i+'" size="5" maxlength="5" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  class="form-control width60" /></td>';
									trHTML +='<td><select name="updateFrequencyTemp" id="updateFrequencyTemp'+i+'" onchange="updateFillValueNomenclatureTemplate(this)" class="medium form-control width150"';
									trHTML +='class="medium">';
									trHTML +='<option value=""><strong>Select...</strong></option>';
									$.each(massFrequencyList, function(ij, item) {
									    
																				
										if(frequencyId == item.frequencyId){
											selectFre="selected";
										}
										else{
											selectFre="";
										}
										
										trHTML += '<option '+selectFre+' value="' + item.feq + '@'
										+ item.frequencyId + '" >' + item.frequencyName+'</option>';
									
									//trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationValue+''+'['+investigationId+']'+'" id="chargeCodeName" class="form-control border-input" name="chargeCodeName" onblur="populateChargeCode(this.value);putInvestigationValue(this)" /> <input type="hidden" id="qty" tabindex="1" name="qty1" size="10" maxlength="6" validate="Qty,num,no" /> <input type="hidden" tabindex="1" id="chargeCodeCode"	name="chargeCodeCode" size="10" readonly /> </div></td><td><input type="Date" id="investigationDate1" name="investigationDate" class="input_date" placeholder="DD/MM/YYYY" value="" maxlength="10" /></td><td><div class="labRadiologyDivfixed"></div> <input type="radio" value="I" id="othAfLab1'+i+'" class="radioCheckCol2" style="margin-right: 15px;" name="labradiologyCheck1'+i+'" /></td><td><div class="labRadiologyDivfixed"></div> <input type="radio" value="O" id="othAfLab1'+i+'" class="radioCheckCol2" style="margin-right: 15px;" name="labradiologyCheck1'+i+'"/></td><td><input type="checkbox" name="urgent" id="uCheck" tabindex="1" class="radioAuto" value="1" /><td style="display:none";><input type="hidden" value="'+investigationId+'" tabindex="1" id="inestigationIdval" size="77" name="inestigationIdval" /></td> </td><td><button type="button" type="button" class="btn btn-primary buttonAdd" value="" tabindex="1"	onclick="addRowForInvestigation();">Add</button></td><td><button type="button" name="delete" value="" class="buttonDel btn btn-danger" tabindex="1" onclick="removeRow("dgInvetigationGrid","hiddenValue",this);">Delete</button></td></tr>';
									});
									trHTML +='</select>';
									trHTML +='</td>';
									trHTML+='<td><input type="text" name="noOfDays1" onkeypress="return event.charCode != 32" value="'+noOfDays+'" tabindex="1" id="noOfDays1'+i+'" onblur="updateFillValueNomenclatureTemplate(this)" size="5" maxlength="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" class="form-control width60" /></td> <td><input type="text" value="'+total+'" onblur="treatmentTotalAlert(this.value,1)" name="total1" tabindex="1" id="total1'+i+'" size="5" validate="total,num,no" class="form-control width70"/></td>';
									trHTML +='<td><select name="updateInstrcutionTemp" id="updateInstrcutionTemp'+i+'" class="medium form-control width150"';
									trHTML +='class="medium">';
									trHTML +='<option value=""><strong>Select...</strong></option>';
									var instctionData=massTempInstructionList;
									$.each(massTempInstructionList, function(ik, item) {
									    
																				
										if(instrcution == item.instructionsName){
											selectInst="selected";
										}
										else{
											selectInst="";
										}
										
										trHTML += '<option '+selectInst+' value="'+ item.instructionsName +'">' + item.instructionsName+'</option>';
									
									//trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationValue+''+'['+investigationId+']'+'" id="chargeCodeName" class="form-control border-input" name="chargeCodeName" onblur="populateChargeCode(this.value);putInvestigationValue(this)" /> <input type="hidden" id="qty" tabindex="1" name="qty1" size="10" maxlength="6" validate="Qty,num,no" /> <input type="hidden" tabindex="1" id="chargeCodeCode"	name="chargeCodeCode" size="10" readonly /> </div></td><td><input type="Date" id="investigationDate1" name="investigationDate" class="input_date" placeholder="DD/MM/YYYY" value="" maxlength="10" /></td><td><div class="labRadiologyDivfixed"></div> <input type="radio" value="I" id="othAfLab1'+i+'" class="radioCheckCol2" style="margin-right: 15px;" name="labradiologyCheck1'+i+'" /></td><td><div class="labRadiologyDivfixed"></div> <input type="radio" value="O" id="othAfLab1'+i+'" class="radioCheckCol2" style="margin-right: 15px;" name="labradiologyCheck1'+i+'"/></td><td><input type="checkbox" name="urgent" id="uCheck" tabindex="1" class="radioAuto" value="1" /><td style="display:none";><input type="hidden" value="'+investigationId+'" tabindex="1" id="inestigationIdval" size="77" name="inestigationIdval" /></td> </td><td><button type="button" type="button" class="btn btn-primary buttonAdd" value="" tabindex="1"	onclick="addRowForInvestigation();">Add</button></td><td><button type="button" name="delete" value="" class="buttonDel btn btn-danger" tabindex="1" onclick="removeRow("dgInvetigationGrid","hiddenValue",this);">Delete</button></td></tr>';
									});
									trHTML +='</select>';
									trHTML +='</td>';
									trHTML+='<td style="display: none;"><input type="hidden" value="'+treatmentItemId+'" tabindex="1" id="itemIdNom11'+i+'" size="77" name="itemIdNom" /></td><td style="display: none;"><input type="hidden" value="'+treatmentTemplPId+'" tabindex="1" id="templPId'+i+'" size="77" name="templPId" /></td><td style="display: none;"><input type="hidden" value="old" tabindex="1" id="chechVal'+i+'" size="77" name="itemIdNom" /></td><td><button type="button" class="btn btn-primary buttonAdd noMinWidth" name="button" button-type="add" value="" onclick="addTreatmentNomenclatureRow();" tabindex="1"></button></td><td><button type="button" class="buttonDel  btn btn-danger noMinWidth" name="button" id="deleteNomenclature" button-type="delete" value="" onclick="removeTreatemntTemplateVal(this,\'' + nomenclatureUpdateGridTemplate + '\',\''+ treatmentTemplPId + '\');" tabindex="1"></button></td><td style="display: none;"><input type="hidden" name="pvmsNo1" tabindex="1" id="pvmsNo1" size="10" value="'+itemClassId+'" readonly="readonly" /></td><td style="display: none;"><input type="hidden" name="itemClassIdnotused" tabindex="1" id="itemClassIdnotUsed" size="10" readonly="readonly" /></td><td style="display: none;"><input type="hidden" name="itemClassId" tabindex="1" id="itemClassId" size="10" readonly="readonly" /></td><td style="display: none";><input type="hidden" value="T" tabindex="1" id="treatmentAuditFlag" size="77" name="treatmentAuditFlag" /></td>	</tr>';
									i++;
									$('.showTreatmenttemplate').show()
									$('#nomenclatureUpdateGridTemplate').append(trHTML);						
					});
					
				
				
				}
				   else
					{
					   $("#nomenclatureGrid tr").remove(); 
					   func1='populatePVMS';
			    		 url1='opd';
			    		 url2='getMasStoreItemList';
			    		 flaga='numenclature';
					   var htmlBlank='';
					   htmlBlank='<tr><td><div class="autocomplete forTableResp"><input type="text" value="" tabindex="1" id="nomenclature1"  size="77" name="nomenclature1" class="form-control border-input" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" /> <div id="nomenclatureIdPvs" class="autocomplete-itemsNew"></div></div></td><td><input type="text" value=" " name="dispensingUnit1" tabindex="1" id="dispensingUnit1" size="6" validate="AU,string,no" readonly="readonly"  class="form-control"/></td><td><input type="text" name="dosage1" onblur="fillValueNomenclature()" tabindex="1" value=" " id="dosage1" size="5" maxlength="5" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  class="form-control" /></td>';
					   htmlBlank +='<td><select name="frequency1" id="frequency1" onchange="fillValueNomenclature()" class="medium form-control"> </select></td>';
         				htmlBlank+='<td><input type="text" name="noOfDays1" value="" tabindex="1" id="noOfDays1" onblur="fillValueNomenclature()" size="5" maxlength="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"   class="form-control" /></td> <td><input type="text" value="" onblur="treatmentTotalAlert(this.value,1)" name="total1" tabindex="1" id="total1" size="5" validate="total,num,no" class="form-control"/></td><td><input type="text" name="remarks1" tabindex="1" id="remarks1" size="10" maxlength="15" value=""   class="form-control" /></td><td><input type="text" name="closingStock1" tabindex="1" value="" id="closingStock1" size="3" validate="closingStock,string,no"   class="form-control" /></td><td style="display: none;"><input type="hidden" value="" tabindex="1" id="itemIdNom" size="77" name="itemIdNom" /></td><td><button type="button" class="btn btn-primary buttonAdd noMinWidth" name="button" button-type="add" value="" onclick="addNomenclatureRow();" tabindex="1"></button></td><td><button type="button" class="buttonDel  btn btn-danger noMinWidth" name="button" id="deleteNomenclature" button-type="delete" value="" onclick="removeTreatmentRow(this);"" tabindex="1"></button></td><td style="display: none;"><input type="hidden" name="pvmsNo1" tabindex="1" id="pvmsNo1" size="10" readonly="readonly" /></td></tr>';
         				$('#nomenclatureGrid').append(htmlBlank);
         				getFrequencyDetail();
         				 var val=$('#nomenclatureGrid').children('tr:first').children('td:eq(0)').find(':input')[0]
         	            // autocomplete(val, arryNomenclature);
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







function getInpaneldHospitalList() {

	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";

	var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/opd/getMasFrequency";
	
	/*
	 * var url =
	 * "http://localhost:8181/AshaServices/v0.1/opdmaster/getMasFrequency";
	 */
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
					return response.MasFrequencyList;
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

var trHTMLFrequncy='';
var massFrequencyList="";
var a=1;

var trHTMLTempInstruction='';
var massTempInstructionList="";

function getFrequencyDetail() {

	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getMasFrequency";
	
	/*
	 * var url =
	 * "http://localhost:8181/AshaServices/v0.1/opdmaster/getMasFrequency";
	 */
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
					var datas = response.MasFrequencyList;
					massFrequencyList= response.MasFrequencyList;
					a=2;
					trHTMLFrequncy = '<option value=""><strong>Select...</strong></option>';
					$.each(datas, function(i, item) {
						trHTMLFrequncy += '<option value="' + item.feq + '@'
								+ item.frequencyId + '" >' + item.frequencyName
								+ '</option>';
					});
					
					$('#frequency1').html(trHTMLFrequncy);
					$('#frequency_nursing').html(trHTMLFrequncy);
					$('#nipfrequency1').html(trHTMLFrequncy);
					$('#updateFrequencyTemp').html(trHTMLFrequncy);
								
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

var a=1;
function geTreatmentInstructionData() {

	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/geTreatmentInstruction";
	
	/*
	 * var url =
	 * "http://localhost:8181/AshaServices/v0.1/opdmaster/getMasFrequency";
	 */
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
					var datas = response.teatmentInstruction;
					massTempInstructionList= response.teatmentInstruction;
					//a=2;
					trHTMLTempInstruction = '<option value=""><strong>Select...</strong></option>';
					$.each(datas, function(i, item) {
						trHTMLTempInstruction += '<option value="' + item.instructionsName +'" >' + item.instructionsName
								+ '</option>';
					});
					
					$('#instuctionFill').html(trHTMLTempInstruction);
					//$('#instuctionTemplate').html(trHTMLTempInstruction);
					//$('#nipfrequency1').html(trHTMLTempInstruction);
					$('#updateInstrcutionTemp').html(trHTMLTempInstruction);
								
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

var trHTMLDispUnit='';
var masDispUnitList="";
function getDispUnitDetail() {

	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getMasDispUnit";
	
	/*
	 * var url =
	 * "http://localhost:8181/AshaServices/v0.1/opdmaster/getMasFrequency";
	 */
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
					var datas = response.MasItemClassList;
					masDispUnitList= response.MasItemClassList;
					trHTMLDispUnit = '<option value=""><strong>Select...</strong></option>';
					$.each(datas, function(i, item) {
						trHTMLDispUnit += '<option value="' + item.storeUnitId + '" >' + item.storeUnitName
								+ '</option>';
					});

					$('#au1').html(trHTMLDispUnit);
					$('#au1Temp').html(trHTMLDispUnit);
					$('#updateau1Temp').html(trHTMLDispUnit);
					$('#au1Treatment').html(trHTMLDispUnit);
					
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

var trHTMLitemClass='';
var masItemClassList="";
function getItemClass() {

	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getMasItemClass";
	
	/*
	 * var url =
	 * "http://localhost:8181/AshaServices/v0.1/opdmaster/getMasFrequency";
	 */
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
					var datas = response.MasItemClassList;
					masItemClassList= response.MasItemClassList;
					trHTMLitemClass = '<option value=""><strong>Select...</strong></option>';
					$.each(datas, function(i, item) {
						trHTMLitemClass += '<option value="' + item.itemClassId + '" >' + item.itemClassName
								+ '</option>';
					});

					$('#class1').html(trHTMLitemClass);
					$('#class1Temp').html(trHTMLitemClass);
					$('#updateclass1Temp').html(trHTMLitemClass);
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


var autoNursingNo = '';
var nursingItemId = '';
var nursingCode="";
 var nursingName="";
 var nursingType="";
 var nursingId="";
 var dataNursing='';
 var defaultProcedureValue="";
 /*function getMastNursingCare(){
	 
	   var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";

		var url = window.location.protocol + "//"
				+ window.location.host + "/" + accessGroup
				+ "/opd/getMasNursingCare";
		var defaultProcedureValue = "N";
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : url,
			data : JSON.stringify({
				'nursingType' : defaultProcedureValue
			}),
			dataType : 'json',
			timeout : 100000,
			
			success : function(res)
			
			{
					
				dataNursing = res.data;
				autoNursingNo=res.data;
				if(arryProcedureCare!="")
				{	
				arryProcedureCare=[];
				}
				for(var i=0;i<dataNursing.length;i++){
					nursingCode= dataNursing[i].nursingCode;
					nursingName=dataNursing[i].nursingName;
					nursingType = dataNursing[i].nursingType;
					nursingId = dataNursing[i].nursingId;
					var aProcedure=nursingName+"["+nursingCode +"]";
				   	arryProcedureCare.push(aProcedure);
					console.log('MasProcedureCare :',arryProcedureCare);
					
					
				}
				  
		            var valProcedure=$('#gridNursing').children('tr:first').children('td:eq(0)').find(':input')[0]
		           // autocomplete(valProcedure, arryProcedureCare); 
			
	           },
	           error: function (jqXHR, exception) {
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
  }*/
 var procedureArrayData = [];
 var p = "";
 function changeProcedureRadio(defaultProcedureValue){
	 $('#defaultProcedureValue').val(defaultProcedureValue);
	 	p++;
		$('#gridNursing tr').each(function(i, el){
			 var $tds = $(this).find('td')
	        
			 var idFreq=  $($tds).closest('tr').find("td:eq(1)").find("select:eq(0)").attr("id");
		      var idDays=$($tds).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id");
		      var typeOfProcValue=$tds.eq(5).find(":input").val();//$(typeOfProc).val();
		if(defaultProcedureValue=="M")
		{
			 document.getElementById(idFreq).disabled = true;
			 document.getElementById(idDays).disabled = true;
		}
		else
		{
					if(typeOfProcValue=='M')
					{
					 document.getElementById(idFreq).disabled = true;
					 document.getElementById(idDays).disabled = true;
					}
					else
						{
			 				document.getElementById(idFreq).disabled = false;
			 				document.getElementById(idDays).disabled = false;
						}
		} 
		});       
	 }
 
 
 
 function changeProcedureRadio1(defaultProcedureValue){
 	p++;
 	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/opd/getMasNursingCare";
	$('#gridNursing tr').each(function(i, el){
		 var $tds = $(this).find('td')
        
		 var idFreq=  $($tds).closest('tr').find("td:eq(1)").find("select:eq(0)").attr("id");
	      var idDays=$($tds).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id");
	      
	      //var typeOfProc=$($tds).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
	        //var idDays= $(this).find("td:eq(2)").find("input:eq(0)").attr("id")
	        var typeOfProcValue=$tds.eq(3).find(":input").val();//$(typeOfProc).val();
	if(defaultProcedureValue=="M")
	{
		
		 document.getElementById(idFreq).disabled = true;
		 document.getElementById(idDays).disabled = true;
		
	}
	else
	{
		
				if(typeOfProcValue=='M')
				{
				document.getElementById(idFreq).disabled = true;
				 document.getElementById(idDays).disabled = true;
				}
				else
					{
		 				document.getElementById(idFreq).disabled = false;
		 				document.getElementById(idDays).disabled = false;
					}
	} 
	});       
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : url,
		data : JSON.stringify({
			'nursingType' : defaultProcedureValue
		}),
		dataType : 'json',
		timeout : 100000,
		
		success : function(res)
		
		{
			dataNursing = res.data;
			autoNursingNo=res.data;
			
			var aProcedure="";
			var valProcedureCare="";
			procedureArrayData=[];
			arryProcedureCare=[];
			for(var i=0;i<dataNursing.length;i++){
				  nursingCode= dataNursing[i].nursingCode;
				  nursingName=dataNursing[i].nursingName;
				  nursingType = dataNursing[i].nursingType;
				  nursingId = dataNursing[i].nursingId;
				  aProcedure=nursingName+"["+nursingCode +"]";
			
				//procedureArrayData.push(aProcedure);
				arryProcedureCare.push(aProcedure);
				$j('#ChangeMasProcedureCare').val('');
				//   valProcedureCare=$('#gridNursing').children('tr:last').children('td:eq(0)').find(':input')[0]
		        // autocomplete(valProcedureCare, procedureArrayData); 
				//console.log('ChangeMasProcedureCare :',procedureArrayData);
				
				
				
			}

 		
            },
            error: function (jqXHR, exception) {
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
 
 
 var nipDataforItem='';
 var nipitemIds='';
 function getMastStoreItemNip(){
	 	var itemIdNip='';
	 	var nomenclature='';
	 	var nipData='';
	 		var pathname = window.location.pathname;
	 		var accessGroup = "MMUWeb";

	 		var url = window.location.protocol + "//"
	 				+ window.location.host + "/" + accessGroup
	 				+ "/opd/getMasStoreItemNip";
	      	//var data = $('employeeId').val();
	 	   // alert("radioValue" +radioValue);
	 		$.ajax({
	 			type : "POST",
	 			contentType : "application/json",
	 			url : url,
	 			data : JSON.stringify({
	 				'employeeId' : "1",
	 				'hospitalId': hsId
	 			}),
	 			dataType : 'json',
	 			timeout : 100000,
	 			
	 			success : function(res)
	 			
	 			{
	 				  
	 				  nipData = res.MasStoreItemList;
	 				  nipDataforItem=res.MasStoreItemList;
	 				  //var autoListNip = [];
	 					for(var i=0;i<nipData.length;i++){
	 					var itemIdNip= nipData[i].itemId;
	 					var masNomenclatureNip=nipData[i].nomenclature;
	 					var aNomNip=masNomenclatureNip+"["+itemIdNip +"]";
	 					//autoListNip[i] = aNomNip;
	 					//alert("a "+a);
	 					arryNomenclatureNip.push(aNomNip);
	 					//console.log('MasStoredataNIpppppppppppp :',aNomNip);
	 					
	 			   }
	 			   },
	 	           error: function (jqXHR, exception) {
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
 
/* var itemIdNipPrescription= '';
 function nipPutPvmsValue(item){
	  var nipPvmsValue = '';
	  for(var i=0;i<nipDataforItem.length;i++){
		var nipItemIdValue= nipDataforItem[i].itemId;
		  if(nipItemIdValue == nipPvmsNo){
			
			  itemIdNipPrescription =nipItemIdValue //data[i].itemId;
			
		  }
	  }
	 
	  $(item).closest('tr').find("td:eq(10)").find(":input").val(itemIdNipPrescription)
	  var newNip=$(item).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
	  document.getElementById(newNip).disabled = true;
	  var classNip=$(item).closest('tr').find("td:eq(2)").find("select:eq(0)").attr("id");
	  document.getElementById(classNip).disabled = true;
	  var auNip=$(item).closest('tr').find("td:eq(3)").find("select:eq(0)").attr("id");
	  document.getElementById(auNip).disabled = true;
  }*/


function addRowForNIP() {


}
function enablePhysioProcedure() {
	var count = document.getElementById('nursinghdb').value
	for (var i = 0; i <= count; i++) {
		if (document.getElementById('frequency_nursing' + i) != null)
			document.getElementById('frequency_nursing' + i).disabled = false;
	}
}

function deleteDgItems(value) {
	if (document.getElementById('diagnosisId').selectedIndex != 0) {
		if (confirm("are you sure want to delete ?")) {
			if (document.getElementById('diagnosisId').options[1].value == document
					.getElementById('NAIcd').value)
				document.getElementById('NAIcd').checked = false;
			document.getElementById('diagnosisId').remove(
					document.getElementById('diagnosisId').selectedIndex)
		}
	}
}
// function showHideDrugTemplateCombo(valueOfTemplate){
//		
//	
// }

function checkAvailbilityForSurgeryTime(t1, t2, divName) {
	var endTime = t1;
	var startTime = t2.value;
	var surgeryDate = document.getElementById('tentativeDateId').value;
	if (startTime != "") {
		var now = new Date();
		surgeryDate = new Date(surgeryDate.substring(6), (surgeryDate
				.substring(3, 5) - 1), surgeryDate.substring(0, 2));
		var isToday = (now.toDateString() == surgeryDate.toDateString());
		// alert(today.toDateString() +" ff" +otherDate.toDateString() +" f"
		// +isToday);
		now = now.toString().substr(16, 5);

		if (isToday && (now > startTime || now > endTime)) {
			document.getElementById('endTime').value = '';
			document.getElementById('startTime').value = '';
			alert("Surgery time should be a future time");
			return false;
		} else if (startTime > endTime) {
			alert("Surgery start time should be less than Surgery end time");
			document.getElementById('endTime').value = '';
			document.getElementById('startTime').value = '';
			return false;
		}

	} else {
		document.getElementById('endTime').value = '';
		alert("Please enter Start time first");
		return false;
	}
}

function showCIMS() {
	var url = "/hms/hms/opd?method=showCIMSPopUp&flag=opd";
	newwindow = window
			.open(url, 'CIMS',
					"left=2,top=100,height=700,width=1010,status=1,scrollbars=1,resizable=0");
}

function clearAppointment(appDt, appTime, inc) {
	document.getElementById(appDt).value = "";
	document.getElementById(appTime).value = "";
	if (document.getElementById("appointDateSpan" + inc) != null
			&& document.getElementById("appointTimeSpan" + inc)) {
		document.getElementById("appointDateSpan" + inc).style.display = 'none';
		document.getElementById("appointTimeSpan" + inc).style.display = 'none';
	}
}

function markAppointMandatory(inc) {
	if (document.getElementById("appointDateSpan" + inc) != null
			&& document.getElementById("appointTimeSpan" + inc)) {
		document.getElementById("appointDateSpan" + inc).style.display = 'inline-block';
		document.getElementById("appointTimeSpan" + inc).style.display = 'inline-block';
	}
}

function showUpdateOpdTempate(templateType) {

	// document.getElementById('prescriptionImportButton').style.display =
	// 'inline';
	var url = "/hms/hms/opd?method=showUpdateOpdTempate&templateType="
			+ templateType;
	newwindow = window.open(url, 'presciption',
			"height=500,width=1010,status=1,top=0,left=2");

}
function addNAIcd(val, obj1) {

	/*
	 * var index1 = val.lastIndexOf("["); var index2 = val.lastIndexOf("]");
	 * index1++;
	 */
	var id = val;

	if (id == "") {
		return;
	} else {
		obj = document.getElementById('diagnosisId');
		obj.length = document.getElementById('diagnosisId').length;
		var valu = obj.options[obj.length - 1].value;
		var b = "false";
		/*
		 * for(var i=1;i<obj.length;i++){
		 * 
		 * var val1=obj.options[i].value; var length=obj.length-1;
		 * 
		 * if(id==val1) { alert("ICD Already taken");
		 * document.getElementById('icd').value ="" b=true; } }
		 */

		if (obj1.checked) {

			for (var i = 1; i < obj.length; i++) {

				/*
				 * var val1=obj.options[i].value; var length=obj.length-1;
				 * 
				 * if(id==val1) { alert("ICD Already taken");
				 * document.getElementById('icd').value ="" b=true; }
				 * 
				 * if (selectobject.options[i].value == 'A' )
				 */
				obj.remove(i);

			}

			obj.length++;
			obj.options[obj.length - 1].value = val;
			obj.options[obj.length - 1].text = "Not available in ICD";
			obj.options[obj.length - 1].selected = true
			document.getElementById('icd').value = ""

		} else {
			obj.remove(1);
		}

		/*
		 * function deleteDgItems(value){
		 * if(document.getElementById('diagnosisId').selectedIndex!=0){
		 * if(confirm("are you sure want to delete ?")){
		 * document.getElementById('diagnosisId').remove(document.getElementById('diagnosisId').selectedIndex) } } }
		 */

	}
}

function fnGetAvailableDoctor(departmentId, divName, loginDoctor) {
	// new
	// Ajax.Request('opd?method=getDoctorDepartment&departmentId='+departmentId+'&'+csrfTokenName+'='+csrfTokenValue,
	// {
	var extraArg = 'n';
	if (loginDoctor != null)
		extraArg = loginDoctor;
	new Ajax.Request(
			'opd?method=getAvailableDoctorDetails&departmentId=' + departmentId
					+ '&loginDoctor=' + extraArg,
			{
				onSuccess : function(response) {
					if (response.responseText.trim() != '') {
						document.getElementById(divName).innerHTML = response.responseText
								.trim();
					}
				}
			});
}

var K='';
function addRowForRefer() {
	var tbl = document.getElementById('referalGrid');
	var lastRow = tbl.rows.length;
	k = lastRow+1;
	var val = parseInt($('#referalGrid>tr:last').find("td:eq(0)").text());
	var aClone = $('#referalGrid>tr:last').clone(true)
	aClone.find("td:eq(0)").text(++val);
	aClone.find(":input").val("");
	aClone.find("td:eq(3)").find("input:eq(0)").prop('id','icdDiagnosisUpdatea' + k + '');
	aClone.find("option[selected]").removeAttr("selected")
	aClone.clone(true).appendTo('#referalGrid');
	var val = $('#referalGrid>tr:last').find("td:eq(3)").find(":input")[0];
	//autocomplete(val, arry);
	//autocomplete(document.getElementById("diagonsisText"), arry);

}

function treatmentTotalAlert(val, inc) {
	
	if(val> 100) {
		alert("You cannot prescribe a medicine quantity of more than 100. Please adjust the days or dosage to accommodate the quantity");
		document.getElementById('total' + inc).value=0;
	}	
	
	if (document.getElementById('actualDispensingQty' + inc).value != 0 && val > 2)  {
		alert("Total quantity  is more than 2");
	}	
	
	
}

function setTextValue(val, Id) {

	document.getElementById(Id.value).value = val;
}

function toogleVaccinDetails(i, j, csrfTokenName, csrfTokenValue) {
	if (j.checked) {
		/*
		 * document.getElementById("vaccinDetails"+i).style.display = '';
		 * document.getElementById("dosage"+i).value = '1';
		 * displayAu(i,csrfTokenName,csrfTokenValue);
		 */
		document.getElementById("checkItem" + i).value = 'Y';
		document.getElementById("completionDate" + i).value = document
				.getElementById("currentDate").value;
	} else {
		/* document.getElementById("vaccinDetails"+i).style.display = 'none'; */
		document.getElementById("checkItem" + i).value = 'N';
		document.getElementById("completionDate" + i).value = "";
	}
}

function updateDeleteNISNIP(flag, dtId, inc) {
	var confirmation = false;
	if (flag == "u"
			&& confirm("Do You want to modify the issued prescription?")) {
		confirmation = true;
	} else if (flag == "d"
			&& confirm("Do You want to delete the issued prescription?")) {
		confirmation = true;
	}
	if (confirmation) {
		var data = "&flag=" + flag + "&dtId=" + dtId;
		if (flag == "u") {
			data = data + "&freq="
					+ document.getElementById("issuedfrequency" + inc).value
					+ "&days="
					+ document.getElementById("issuedDays" + inc).value
					+ "&dosage="
					+ document.getElementById("issuedDosage" + inc).value
					+ "&total="
					+ document.getElementById("issuedTotal" + inc).value;
			;
		}
		new Ajax.Request(
				'opd?method=updateDeleteNISNIP' + data,
				{

					onSuccess : function(response) {
						if (response.responseText.trim() != '') {
							if (response.responseText == "s") {
								alert("Action Completed");
								if (flag == "d") {
									document.getElementById(
											"issuedTreatmentGrid").deleteRow(
											inc);
								}
							} else {
								alert("Action could not be completed, All fields are mandatory");
							}
						}
					}
				});
	}
}
function checkDate() {
	   var selectedText = document.getElementById('datepicker').value;
	   var selectedDate = new Date(selectedText);
	   var now = new Date();
	   if (selectedDate < now) {
	    alert("Date must be in the future");
   }
}


function showCreatePrescriptionTempate() {

	document.getElementById('prescriptionImportButton').style.display = 'inline';
	var url = "/hms/hms/opd?method=showCreatePrescriptionTempate";
	newwindow = window.open(url, 'presciption',
			"height=500,width=1010,status=1,top=0,left=2");
}

function showInvestiDataTemplate() {
	getTemplateDetail();
}

function showProcedureMaster(defaultProcedureValue) {
	changeProcedureRadio(defaultProcedureValue);
	//getMastNursingCare();
}

function showEmpanelled() {
	getEmpanelled();
}

function showTemplateDataTemplate() {
	getTreatmentTemplateDetail();
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


function getListForTreatment(val, formName) {
	if (val == 'investigationDiv') {
		submitProtoAjaxWithDivName(formName,
				'/hms/hms/opd?method=getListForTreatment&flag=investigation',
				val);
	} else if (val == 'treatmentDiv') {
		submitProtoAjaxWithDivName(formName,
				'/hms/hms/opd?method=getListForTreatment&flag=treatment', val);
	}
	// document.getElementById('prescriptionImportButton').style.display =
	// 'none';
	// document.getElementById("investigationImportButton").style.display='none'
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
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : 'authenticateUser',
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
				document.getElementById("okButtonOfAuthenticate").style.display = "none";
				$('.modal-backdrop ').hide();
				//$('.modal').hide();
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
	$('.modal-backdrop').hide();
	$('#messageForInvestigationOutside').hide();
	$('#messageForTreatmentAlert').hide();
	
}

function closeDiagnosisMessage(val){
	var currentValue=val;
	$('#diagnosisGrid tr').each(function(i, el) {
	  var $tds = $(this).find('td')
	        var chargeCodeId=   $($tds).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
	        var chargeCodeIdValue=$('#'+chargeCodeId).val();
	        var chargeCodeIdSecond=   $($tds).closest('tr').find("td:eq(6)").find("input:eq(0)").attr("id");
	        if(currentValue==chargeCodeIdValue)
	        {	
	        	$('#'+chargeCodeIdSecond).val("F");
	        }
	     			        	
	   });

	 $('#errordiv').empty("");
	 $('#uhidNumber').val("");

	$('#messageForAuthenticate').hide();
	$('.modal-backdrop').hide();
	$('#msgForAIDiagnosis').hide();
	$('#messageForTreatmentAlert').hide();
	
}

function closeTreatmentMessage(val){
	var currentValue=val;
	$('#nomenclatureGrid tr').each(function(i, el) {
		  var $tds = $(this).find('td')
		        var chargeCodeId=   $($tds).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
		        var chargeCodeIdValue=$('#'+chargeCodeId).val();
		        var chargeCodeIdSecond=   $($tds).closest('tr').find("td:eq(13)").find("input:eq(0)").attr("id");
		        if(currentValue==chargeCodeIdValue)
		        {	
		      		$('#'+chargeCodeIdSecond).val("F");
		        }
		     			        	
		   });

	 $('#errordiv').empty("");
	 $('#uhidNumber').val("");

	$('#messageForAuthenticate').hide();
	$('.modal-backdrop').hide();
	$('#msgForAITreatment').hide();
	$('#messageForTreatmentAlert').hide();
	
}

function closeInvestigationMessage(val){
	var currentValue=val;
	$('#dgInvetigationGrid tr').each(function(i, el) {
		  var $tds = $(this).find('td')
		        var chargeCodeId=   $($tds).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
		        var chargeCodeIdValue=$('#'+chargeCodeId).val();
		        var chargeCodeIdSecond=   $($tds).closest('tr').find("td:eq(4)").find("input:eq(0)").attr("id");
		        if(currentValue==chargeCodeIdValue)
		        {	
		      		$('#'+chargeCodeIdSecond).val("F");
		        }
		     			        	
		   });

	 $('#errordiv').empty("");
	 $('#uhidNumber').val("");

	$('#messageForAuthenticate').hide();
	$('.modal-backdrop').hide();
	$('#msgForAIInvestigation').hide();
	$('#messageForTreatmentAlert').hide();
	
}

	function checkForAuthenticateUser(){

	var patientId =$('#patientId').val();
	var visitId = $('#visitId').val();
	 
	var params = {
			"patientId": patientId,
			"visitId":visitId
	}
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : 'checkForAuthenticateUser',
		data : JSON.stringify(params),
		dataType : "json",
		//cache : false,
		success : function(response) {
			var data = response.data;
			$('#checkForAuthenticationValue').val(data);
			return ;
		}
	});
  
	
/////////////////////// treatment validation part ////////////////////////////	
	function treatmentValidation()
    {
		var extNomenclatureFlag=true;
		var count1=0;
		var count2=0;
		var count3=0;
		var count4=0;
		var count5=0;
		var  idforTreat='';
    	var valnomenclatureGrid='';	
    	  $('#nomenclatureGrid tr').each(function(i, el) {
    	 	var $tds = $(this).find('td')
       	    var treatmentName = $tds.eq(0).find(":input").val();
       	    var dosage = $tds.eq(2).find(":input").val();
       	    var frequency = $tds.eq(3).find(":input").val();
       	    var splitFrequency = frequency.split("@");
       	    var days = $tds.eq(4).find(":input").val();
       	    var instruction = $tds.eq(6).find(":input").val();
       	
       	 if(treatmentName== "")
     	    {
         		alert("Please Enter Presecrption Name");
         		treatmentName.focus();
         		return false;	    	
     		}
       	if(dosage== "")
  	    {
      		alert("Please Enter Dosage");
      		dosage.focus();
     		return false;      	
  		}
       	if(frequency== "")
   	    {
       		alert("Please select Frequency Type");
       		frequency.focus();
     		return false;       	
   		}
    	if(days== "")
   	    {
       		alert("Please Enter Days");
       		frequency.focus();
     		return false;       	
   		}
       /* 	if(days== "")
   	    {
       		alert("Please Enter Days");
       		extNomenclatureFlag = false;
       		count4+=1;       	
   		}  */
       	/*  if(count1!=0 && count2!=0){
       		  return false;
       	 } */
       	 /* if(count1!=0)
       	{
       		 
       		 return false;	 
       	}
       	if(count2!=0)
        {
        	return false;	 
        }
       	if(count3!=0)
        {
        	return false;	 
        }
       	if(count4!=0)
        {
        	return false;	 
        } */
		 
         });
    	  
    }	
	
	
}
	
function getTreatmentGrideValue(datas){
	  	func1='populatePVMSTreatment';
	    url1='opd';
	     url2='getMasStoreItemList';
	     flaga='numenclature';
	     treatementCurrent='';
	     var count = 0;
	$.each(datas, function(i, item) {
	    var treatmentItemId=item.treatmentItemId;
		var itemIdName=item.itemIdName;
		var itemClassId=item.itemClassId;
		var dosage=item.dosage;
		var itemIdCode=item.itemIdCode;
		var frequencyId=item.frequencyId;
		var frequencyName=item.frequencyName;
		var total=item.total;
		var noOfDays=item.noOfDays;
		var instrcution=item.instrcution;
		var dispUnit=item.dispUnit;
		var availableStock=item.availableStock;
		
		var selectFre="";
		var dispStock="";
		var selectInst="";
		 
		if(treatmentItemId!=null &&treatmentItemId!='')
	        {
			    var pathname = window.location.pathname;
				var accessGroup = "MMUWeb";
				var url = window.location.protocol + "//"
				+ window.location.host + "/" + accessGroup
				+ "/opd/getDispStockDetails";
				$
						.ajax({
							url : url,
							dataType : "json",
							data : JSON.stringify({
								"item_id":treatmentItemId,
								"hospital_id":hsId,
								"department_id":dispDepartment
							}),
							contentType : "application/json",
							type : "POST",
							success : function(response) {
								console.log(response);
								var datasDispStock = response.batchData;
								var dispStock=datasDispStock.disp_stock;
								var storeStock=datasDispStock.disp_stock;
								
								var dispStoreStock=dispStock +'/'+storeStock;
								dispStock=dispStoreStock;
								
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
		
		
		var flagForcheck1 = true;
		//var investigationValue = item.investigationName;
		//var investigationId = item.templateInvestgationId;
		var investigationIdValu ="";
		if(treatmentItemId!=null && treatmentItemId!=undefined && treatmentItemId!=""){
		$('#nomenclatureGrid tr').each(function(ihh, el) {
							var $tds = $(this) .find('td')
							var treatmentIdVal = $($tds).closest('tr').find("td:eq(0)").find("input:eq(1)").val();
							if (treatmentItemId == treatmentIdVal) {
								flagForcheck1 = false;
							}
						});
		}
		var tbDgInvetigationGrid = document.getElementById('nomenclatureGrid');
		var lastRow = tbDgInvetigationGrid.rows.length;
		if(lastRow==1 && investigationIdValu==""){
			$("#nomenclatureGrid tr").remove();
		}
		count=parseInt(count)+parseInt(treatmentItemId);
		if (flagForcheck1 == true) {
			
		treatementCurrent += '<tr>';
		treatementCurrent += '<td>';
		treatementCurrent += '<div class="autocomplete forTableResp">';
		if(availableStock==0)
		{
		treatementCurrent += '<input type="text" style="border: 5px solid red" autocomplete="never" value="'+itemIdName+''+'['+itemIdCode+']'+'" tabindex="1"';
		}
		else
		{
			treatementCurrent += '<input type="text" autocomplete="never" value="'+itemIdName+''+'['+itemIdCode+']'+'" tabindex="1"';	
		}	
		treatementCurrent += '	id="nomenclature1'+count+'" size="77" name="nomenclature1"';
		treatementCurrent += '	class="form-control border-input width330" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
	
		treatementCurrent += '<input type="hidden"  name="itemId" value="' + treatmentItemId + '" id="nomenclatureId'
				+ count + '"/>';
		treatementCurrent += '<input type="hidden"  name="prescriptionHdId" value="" id="prescriptionHdId'
				+ count + '"/>';
		treatementCurrent += '<input type="hidden"  name="prescriptionDtId" value="" id="precriptionDtId'
				+ count + '"/>';
		treatementCurrent += '	<input type="hidden" name="statusOfPvsms" id="statusOfPvsms'+count+'" value=""/>';
		treatementCurrent += '	<div id="nomenclatureIdPvs'+count+'" class="autocomplete-itemsNew"></div>';
		treatementCurrent += '</div>';

		treatementCurrent += '</td>';
       
		/*treatementCurrent += '<td><input type="text" value="'
				+ dispUnit
				+ '" name="dispensingUnit1" ';
		treatementCurrent += ' id="dispensingUnit1'+count+'" size="6"';
		treatementCurrent += 'validate="AU,string,no"   class="form-control width80"/>';
		treatementCurrent += '</td>';*/

		treatementCurrent += '<td ><select name="dispensingUnit1" class="medium form-control width100" id="dispensingUnit1'+ i + '" >';
		 
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
		
		treatementCurrent += '<td><input type="text" onkeypress="return event.charCode != 32" class="form-control width60" size="5" name="dosage1" tabindex="1"';
		treatementCurrent += 'value=' + dosage
				+ ' id="dosage1'+count+'"  maxlength="5" onblur="fillValueNomenclature('+count+')"/>';
		treatementCurrent += '</td>';

		treatementCurrent += '<td><select name="frequencyTre" class="form-control width150" id="frequencyTre'
				+ i + '"';
		treatementCurrent += 'class="medium" onblur="fillValueNomenclature('+count+')">';

		var frequencyIdValue =frequencyId;
		treatementCurrent += '<option value=""><strong>Select</strong></option>';

		var selectFre = "";
		$.each(massFrequencyList, function(ij, item) {
			 
			if (frequencyId == item.frequencyId) {
				selectFre = "selected";
			} else {
				selectFre = "";
			}
			treatementCurrent += '<option ' + selectFre
					+ ' value="' + item.feq + '@'
					+ item.frequencyId + '" >' + item.frequencyName + '</option>';
		});
		treatementCurrent += '</select>';
		treatementCurrent += '</td>';

		treatementCurrent += '<td><input type="text" onkeypress="return event.charCode != 32" class="form-control width60" value="'
				+ noOfDays
				+ '" name="noOfDays1" tabindex="1"';
		treatementCurrent += '	id="noOfDays1'+count+'" onblur="fillValueNomenclature('
				+ count + ')" size="5"';
		treatementCurrent += '	maxlength="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" /></td>';

		treatementCurrent += '<td><input type="text" onkeypress="return event.charCode != 32" class="form-control width70" value="' + total + '" name="total1" tabindex="1"';
		treatementCurrent += 'id="total1'+count+'" size="5" validate="total,num,no"';
		treatementCurrent += 'onblur="treatmentTotalAlert(this.value,1)" /></td>';

		/*treatementCurrent += '<td><input type="text" class="form-control width80" tabindex="1" value="'
				+ instrcution + '" name="remarks1" ';
		treatementCurrent += 'id="remarks1'+count+'" size="10" maxlength="15"/>';
		treatementCurrent += '</td>';*/
		
		treatementCurrent +='<td><select name="instuctionFill" id="instuctionFill" class="medium form-control width150"';
		treatementCurrent +='class="medium">';
		treatementCurrent +='<option value=""><strong>Select...</strong></option>';
		//var instctionData=massTempInstructionList;
		$.each(massTempInstructionList, function(ik, item) {
		    
													
			if(instrcution == instrcution){
				selectInst="selected";
			}
			else{
				selectInst="";
			}
			
			treatementCurrent += '<option '+selectInst+' value="'+ instrcution +'">' + instrcution+'</option>';
		
		//trHTML+='<tr><td><div class="autocomplete"><input type="text" value="'+investigationValue+''+'['+investigationId+']'+'" id="chargeCodeName" class="form-control border-input" name="chargeCodeName" onblur="populateChargeCode(this.value);putInvestigationValue(this)" /> <input type="hidden" id="qty" tabindex="1" name="qty1" size="10" maxlength="6" validate="Qty,num,no" /> <input type="hidden" tabindex="1" id="chargeCodeCode"	name="chargeCodeCode" size="10" readonly /> </div></td><td><input type="Date" id="investigationDate1" name="investigationDate" class="input_date" placeholder="DD/MM/YYYY" value="" maxlength="10" /></td><td><div class="labRadiologyDivfixed"></div> <input type="radio" value="I" id="othAfLab1'+i+'" class="radioCheckCol2" style="margin-right: 15px;" name="labradiologyCheck1'+i+'" /></td><td><div class="labRadiologyDivfixed"></div> <input type="radio" value="O" id="othAfLab1'+i+'" class="radioCheckCol2" style="margin-right: 15px;" name="labradiologyCheck1'+i+'"/></td><td><input type="checkbox" name="urgent" id="uCheck" tabindex="1" class="radioAuto" value="1" /><td style="display:none";><input type="hidden" value="'+investigationId+'" tabindex="1" id="inestigationIdval" size="77" name="inestigationIdval" /></td> </td><td><button type="button" type="button" class="btn btn-primary buttonAdd" value="" tabindex="1"	onclick="addRowForInvestigation();">Add</button></td><td><button type="button" name="delete" value="" class="buttonDel btn btn-danger" tabindex="1" onclick="removeRow("dgInvetigationGrid","hiddenValue",this);">Delete</button></td></tr>';
		});
		treatementCurrent +='</select>';
		treatementCurrent +='</td>';

		treatementCurrent += '	<td><input type="text" class="form-control width80" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" name="closingStock1" tabindex="1"  value="'+availableStock+'"';
		treatementCurrent += 'id="closingStock1" size="3"';
		treatementCurrent += 'validate="closingStock,string,no" /></td>';

		
		//treatementCurrent +='<td><div class="form-check form-check-inline cusCheck"><input type="checkbox" class="form-check-input"  name="nis" id="nisCheck'+count+'" tabindex="1" class="radioAuto" value="1" /><span class="cus-checkbtn"></span></div></td>';
		//treatementCurrent +='<td><div class="form-check form-check-inline cusCheck"><input type="checkbox" class="form-check-input"   name="immunization" id="immCheck'+count+'" tabindex="1" class="radioAuto" value="1"/><span class="cus-checkbtn"></span></div></td>';
		
		
		treatementCurrent += '<td style="display:none"><input  type="hidden" value="" tabindex="1"';
		treatementCurrent += '	id="itemIdNom" size="77" name="itemIdNom" /></td>';

		treatementCurrent += '<td><button name="Button" type="button"';
		treatementCurrent += '	class="buttonAdd btn btn-primary noMinWidth" value="" button-type="add" onclick="addNomenclatureRowRecall();"';
		treatementCurrent += '	tabindex="1" > </button></td>';

		treatementCurrent += '<td><button type="button" name="delete" id="treatementId" value=""';
		treatementCurrent += 'class="buttonDel btn btn-danger noMinWidth" button-type="delete"';
		var investigationGridValue='nomenclatureGrid';
		var prescriptionDTIdCurrent=0;
		treatementCurrent += '	onclick="removeRowInvestigationOpd(this,\''
				+ investigationGridValue
				+ '\','
				+ prescriptionDTIdCurrent + ');"';
		treatementCurrent += '	tabindex="1"> </button></td>';
		
		treatementCurrent += '<td style="display: none;"><input type="hidden" name="pvmsNo1" tabindex="1"';
		treatementCurrent += '	id="pvmsNo1'+count+'" size="10" readonly="readonly" />';
		treatementCurrent += '</td>';
		
		treatementCurrent += '<td style="display: none;"><input type="hidden"';
		treatementCurrent += 'name="itemClassId" tabindex="1" id="itemClassId'+count+'" size="10" value='+itemClassId+'';
		treatementCurrent += 'readonly="readonly" /></td>	';
	
		treatementCurrent += '</tr>';
		}
		i++;
		count++;
							
});
	$('#nomenclatureGrid').append(treatementCurrent);	
}

var total_patient_value = '';
var digaoReferal='';   
var patientValue = '';
var multiPSValue=[];
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
          	
              $('#patientSympotnsId').append('<span id=' + patientValue + '>' + val + '</span>');
              multiPSValue.push(patientValue);
              document.getElementById('patientSymptons').value = ""
            	  var orgValue=[];
			    	 $('#patientSympotnsId').find('span').each(function() { 
				  		    var id = this.id;
				  		    var value = $(this).html();
				  		   	var valueOrg=id.split('&&&')
				 	 			var idVal=valueOrg[0];
				  		   //var valueOrgSec=idVal.split(']')
				 	 			orgValue.push(idVal);	
				  		});
				  	    $('#patientSymAuditId').val(orgValue);	  

          }
          
      }
  }
  
  function getPatientSympotons() {

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
        				  		   	var valueOrg=id.split('&&&')
        				 	 			var idVal=valueOrg[0];
        				  		   //var valueOrgSec=idVal.split(']')
        				 	 			orgValue.push(idVal);	
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
			        				  		   	var valueOrg=id.split('&&&')
			        				 	 			var idVal=valueOrg[0];
			        				  		   //var valueOrgSec=idVal.split(']')
			        				 	 			orgValue.push(idVal);	
			        				  		});
			        				  	    $('#patientSymAuditId').val(orgValue);
		        				      } 
		        					}
		        				});
		
		        			  } 
        		   }
    		   }
       
    }
  
  var diagnosislastRow;
  var di=100;
  function addDiagnosis(){
  	    di++
  	    var aClone = $('#diagnosisGrid>tr:last').clone(true);
  		aClone.find(":input").val("");
  	    aClone.find('input[type="text"]').prop('id', 'diagnosisId'+di+'');
  	    aClone.find("td:eq(1)").find(":input").prop('checked', false);
  	    aClone.find("td:eq(2)").find(":input").prop('checked', false);
  	    //aClone.find("td:eq(0)").find("div").find("div").prop('id', 'investigationDivOpd' + di + '');
  		aClone.find("td:eq(5)").find(":input").prop('id', 'diagnosisIdval'+di+'');
  		aClone.find("td:eq(6)").find(":input").prop('id', 'diagnosisAuditFlag'+di+'');
  		aClone.clone(true).appendTo('#diagnosisGrid');
  		var valDiagnosis = $('#diagnosisGrid>tr:last').find("td:eq(0)").find(":input")[0];
  			    		
  		  var tbl = document.getElementById('diagnosisGrid');
     	  lastRow = tbl.rows.length;
     
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
	
	//Function to check if expiry date is within 3 months from now
	 function isExpiryWithinThreeMonths(expiryDateStr) {
	    if (!expiryDateStr || expiryDateStr.trim() === '') {
	        console.log("Expiry date is blank.");
	        return false;
	    }
	    
	    // Format: '31/03/2025' -> dd/mm/yyyy
	    const expiryDateArr = expiryDateStr.split('/'); // Split the date string into day, month, year
	    
	    // Correctly construct a Date object (year, month, day)
	    const expiryDate = new Date(expiryDateArr[2], expiryDateArr[1] - 1, expiryDateArr[0]); // Month is 0-indexed (Jan is 0, Feb is 1, etc.)

	    // Get today's date
	    const today = new Date();

	    // Get the date 3 months from today
	    const threeMonthsLater = new Date(today);
	    threeMonthsLater.setMonth(today.getMonth() + 3);
	    
	    console.log("expiryDateStr=" + expiryDateStr);
	    console.log("expiryDate=" + expiryDate);
	    console.log("threeMonthsLater=" + threeMonthsLater);

	    // Compare the expiry date with today's date and 3 months from now
	    if (expiryDate <= threeMonthsLater && expiryDate >= today) {
	            
	        return true;
	    } else {
	       
	        return false;
	    }
	}


