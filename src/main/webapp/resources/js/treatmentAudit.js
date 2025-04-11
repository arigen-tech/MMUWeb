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
	  					var patientSymAuditId=[];
	  					patientIDValuennn += '<div class="multiDiv" name="patientSympotnsId" id="patientSympotnsId">';
	  				
						var mcdIdValueePatient = "";
						for (var i = 0; i < datasPatient.length; i++) {
							patientIDValuennn += '<span id="'+ datasPatient[i].symptomId + '&&&' + 0
									+'">' + datasPatient[i].symptomName + "["
									+ datasPatient[i].symptomId + "]"
									+ '</span>';
							patientSymAuditId.push(datasPatient[i].symptomId);
						}
						patientIDValuennn += '</div>';
						$("#patientSympotnsIdDiv").html(patientIDValuennn);
						 $('#patientSymAuditId').val(patientSymAuditId);
						//document.getElementById("option1").selected = true;
						//$('#patientSympotnsValue').val(mcdIdValueePatient);
	  								
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
var multiPSValue=[];
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
       			
       			 $("#patientSympotnsId option").each(function()
                    		{
       				 	var valueOrg=$(this).val().split('&&&')
				 			var idVal=valueOrg[0];
				 		    if(idVal==patientValue){
                    		    alert("Sign and Symptoms is already added");
                    		    document.getElementById('patientSymptons').value = ""
                    		    b=true;
                    		    }
                    		});
       		  }
       	  }
	      
          if (b == "false") {
          	
              $('#patientSympotnsId').append('<option value=' + patientValue + '>' + val + '</option>');
              multiPSValue.push(patientValue);
              document.getElementById('patientSymptons').value = ""

          }
          $('#patientSympotnsValue').val(multiPSValue);
      }
  }



	  function deletePatientSympotonsItems() {
	    	var deletepatient = document.getElementById('patientSympotnsId');
	       if (deletepatient.selectedIndex == -1)
	    	   {
	    	       alert("Please select atleast one Signs and Symptoms")
	    	       return false;
	    	   }
	    	   else
	    		   {
	    		     var psId=document.getElementById('patientSympotnsId').options[document.getElementById('patientSympotnsId').selectedIndex].value;
	    		     var format = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]+/;
	    		   
	        		   if (confirm(resourceJSON.opdIcdDeleteMsg)) {

	                       if (document.getElementById('patientSympotnsId').options[document.getElementById('patientSympotnsId').selectedIndex].value != null && !format.test(psId) )
	                    	   {
	                              document.getElementById('patientSympotnsId').remove(document.getElementById('patientSympotnsId').selectedIndex)
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
			        				    	 document.getElementById('patientSympotnsId').remove(document.getElementById('patientSympotnsId').selectedIndex)
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
	  					diagnosisHtml += ' class="form-control width330" size="55" disabled name="diagnosisIdRecall" onmouseup="getOpdNomenClatureList(this,\''+func1+'\',\''+url3+'\',\''+url4+'\',\''+flaga+'\',\''+flagb+'\');" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
	  					
	  					 diagnosisHtml+='<div class="autocomplete-itemsNew" id="diagnosisDivRecll'+count+'" ></div>';
	  					 diagnosisHtml+='</div>';
	  					 diagnosisHtml+='<input type="hidden" id="diagnosisIdvalRecall'+diagnosisId+'" name="diagnosisIdvalRecall" value="'+diagnosisId+'">';
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
	  					 
	  					 
	  					/*diagnosisHtml+=' <td style="display: none";>';
	  					 diagnosisHtml+=' <input type="hidden" value="" tabindex="1" id="diagnosisIdvalRecall'+count+'" value="'+diagnosisId+'" size="77" name="diagnosisIdvalRecall" />';
	  					 diagnosisHtml+=' </td>';*/
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
	     function newDiagnosisPopulateRecall(val,count,item) {
	    		//alert("called");
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
	    		     			 
	    	      			    var checkCurrentRowIddd=$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").attr("id");
	    	        			var checkCurrentRow=$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val();
	    	   			         var count=0;   			
	    	   			        $('#diagnosisGridRecall tr').each(function(i, el) {
	    	        			    var $tds = $(this).find('td')
	    	       			        var chargeCodeId=  $($tds).closest('tr').find("td:eq(0)").find("input:eq(1)").attr("id");
	    	       			        var chargeCodeIdValue=$('#'+chargeCodeId).val();
	    	       			        var idddd =$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").attr("id");
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
	    	       			        	     
	    	       			            	$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").val(newIcdValue);
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
	  
	  var globalDataForDiagnosis = "";
		
	  function getPatientDiagnosisDetailAuditDetails() {
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
	  	var count=0;
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
	  					diagnosisHtml += ' class="form-control width230" size="55" disabled name="diagnosisIdRecall" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');"/>';
	  					
	  					 diagnosisHtml+='<div class="autocomplete-itemsNew" id="diagnosisDivRecll'+count+'" ></div>';
	  					 diagnosisHtml+='</div>';
	  					 diagnosisHtml+='<input type="hidden" id="diagnosisIdvalRecall'+diagnosisId+'" name="diagnosisIdvalRecall" value="'+diagnosisId+'">';
	  					 diagnosisHtml+='<input type="hidden" id="diagnosisIdTableId'+diagnosisDtValue+'" name="diagnosisIdTableId" value="'+diagnosisDtValue+'">';
	  					 diagnosisHtml+='</td>';
	  					 
	  					 diagnosisHtml+='<td class="text-center width80">';
	  					 diagnosisHtml+=' <div class="form-check form-check-inline cusCheck m-t-7">';
	  					 diagnosisHtml+=' <input class="form-check-input" '+communicableFlag+' id="markDiseaseRecall'+diagnosisId+'" name="markDiseaseRecall" value="1" type="checkbox">';
	  					 diagnosisHtml+=' <span class="cus-checkbtn"></span></div>';
	  					 diagnosisHtml+=' </td>';
	  					 
	  					 diagnosisHtml+='<td class="text-center width80">';
	  					 diagnosisHtml+=' <div class="form-check form-check-inline cusCheck m-t-7">';
	  					 diagnosisHtml+=' <input class="form-check-input" id="markInfectionRecallRecall'+diagnosisId+'" '+infectiousFlag+' name="markInfectionRecall" type="checkbox">';
	  					 diagnosisHtml+=' <span class="cus-checkbtn"></span></div>';
	  					 diagnosisHtml+=' </td>';
	  					
	  					diagnosisHtml+='<td class="">';
	  					diagnosisHtml+='<div class="width150 clearfix">';
	  					/*diagnosisHtml+='<select onchange="this.className=this.options[this.selectedIndex].className" class="greenText">';
	  					diagnosisHtml+='<option value="A" class="greenText" selected="selected">Observation</option>';
	  					diagnosisHtml+='<option value="R" class="redText">New Suggestion</option>';
	  					diagnosisHtml+='</select>';*/
	  					diagnosisHtml+='<input type="radio"  id="observation'+diagnosisId+'" name="action'+diagnosisId+'" value="A" checked>';
	  					diagnosisHtml+='<label for="observation'+diagnosisId+'" class="greenText">Observation</label>';
	  					diagnosisHtml+='<br><input type="radio" id="newSuggestion'+diagnosisId+'" name="action'+diagnosisId+'" value="R">';
	  					diagnosisHtml+='<label for="newSuggestion'+diagnosisId+'" class="redText" >New Suggestion</label>';
	  					diagnosisHtml+='</div>';
	  					diagnosisHtml+='</td>';
	  					
	  					func2='fillDiagnosisCombo';
	  					url2='opd';
	  					url3='getIcdListByName';
	  					flagb='dignosis';
	  					
	  					url4='treatmentAudit';
					    url5='getAllIcdForOpd';
					    flagc='mouseOver';
	  					
	  					diagnosisHtml+='<td class="">';
	  					diagnosisHtml+='<div class="width400 clearfix">';
	  					diagnosisHtml+='<div class="autocomplete forTableResp pull-left width180">';
	  					diagnosisHtml+='<input name="icddiagnosis" id="icd'+diagnosisId+'" type="text"';
	  					diagnosisHtml+='class="form-control border-input disablecopypaste  m-b-5"';
	  					diagnosisHtml+='placeholder=" " value=""  onKeyUp="getNomenClatureList(this,\''+func2+'\',\''+url2+'\',\''+url3+'\',\''+flagb+'\');"  />';
	  					diagnosisHtml+='<div class="autocomplete-itemsNew" id="icdDiagnosisUpdatea" ></div>';
	  					diagnosisHtml+='</div>';
	  					diagnosisHtml+='<select name="diagnosisId" multiple="4" value="" size="5"';
	  					diagnosisHtml+='tabindex="1" id="diagnosisId'+diagnosisId+'" class="listBig disablecopypaste width200 pull-right"';
	  					diagnosisHtml+='validate="ICD Daignosis,string,yes">';
	  					diagnosisHtml+='</select>';
	  					diagnosisHtml+='<button type="button" class="buttonDel btn  btn-danger pull-left" value="" onclick="deleteDgItems('+diagnosisId+');" > Delete </button>';
	  					diagnosisHtml+='</div>';
	  					diagnosisHtml+='</td>';
	  					
	  					diagnosisHtml+='<td class="">';
	  					diagnosisHtml+='<textarea class="form-control width200" rows="2"></textarea>';
	  					diagnosisHtml+='</td>';
	  					
	  					 
	  					/*diagnosisHtml+=' <td style="display: none";>';
	  					 diagnosisHtml+=' <input type="hidden" value="" tabindex="1" id="diagnosisIdvalRecall'+count+'" value="'+diagnosisId+'" size="77" name="diagnosisIdvalRecall" />';
	  					 diagnosisHtml+=' </td>';*/
	  					 diagnosisHtml+=' </tr>';
	  					 count+=1;
	  				}
	  	
	  				
	  					$("#diagnosisGridRecall").html(diagnosisHtml);
	  					
	  				}
	  	          
	  			});

	  	return false;
	  }
	  
	  var autoIcdCode = '';
      var icdData= '';	 
       var idIcdNo = '';
       var icdValue = '';
       var multiIcdValue=[];
	  var total_icd_value = '';
      var digaoReferal='';   
        function fillDiagnosisCombo(val, inc,item) {
        	 
        	var checkCurrentNomRowId=$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val();
            var index1 = val.lastIndexOf("[");
            var index2 = val.lastIndexOf("]");
            index1++;
            idIcdNo = val.substring(index1, index2);
            if (idIcdNo == "") {
                return;
            } else {
                obj = document.getElementById('diagnosisId'+checkCurrentNomRowId+'');
                total_icd_value += val+",";
               
                obj.length = document.getElementById('diagnosisId'+checkCurrentNomRowId+'').length;
                var b = "false";
                for(var i=0;i<autoIcdCode.length;i++){
             		  
             		  var icdNo1 = icdData[i].icdCode;
             		 
             		  if(icdNo1 == idIcdNo){
             			icdValue = icdData[i].icdId;
             			multiIcdValue.push(icdValue);
             			digaoReferal=icdValue;
             			var idddd =$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").attr("id");
 				        var existingDiagnosis=$('#'+idddd).val();
 				        if(existingDiagnosis==icdValue)
 				        {
 				        	alert("ICD diagnosis is already added from opd");
 				        	$("#icd"+checkCurrentNomRowId).val("");
                   		    b=true;
 				        }	
             			 $("#diagnosisId"+checkCurrentNomRowId+" option").each(function()
                          		{
             				        
                          		    if($(this).val()==icdValue){
                          		    alert("ICD diagnosis is already added");
                          		    document.getElementById('icd').value = ""
                          		    b=true;
                          		    }
                          		});
             		  }
             	  }
                if (b == "false") {
                	
                    $('#diagnosisId'+checkCurrentNomRowId+'').append('<option value=' + icdValue + '>' + val + '</option>');
                    document.getElementById('icd'+checkCurrentNomRowId+'').value = ""

                }
            }
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
        					var instctionData=massTempInstructionList;
        					treatementData += '';
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
        						if(data[i].itemId!=null && data[i].itemId!="")	
        						{	
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
        						treatementData += 'class="form-control border-input width300"';
        					/*	treatementData += '  onKeyPress="autoCompleteCommon(this,2);" onKeyUp="autoCompleteCommon(this,2);" onKeyDown="autoCompleteCommon(this,2);" onblur="populatePVMSTreatment(this.value,'+count+',this);" />';*/
        						treatementData += '  onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" '+disableFlagVal+'disabled/>';
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
        						
        						treatementData += '<td ><select name="dispensingUnit1" class="form-control width100" id="dispensingUnit1'+ countForPvms + '"';
        						treatementData += 'class="medium" disabled>';
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
        						
        						
        						
        						treatementData += '<td><input type="text" class="form-control width30" size="5" name="dosage1" tabindex="1" onblur="fillValueNomenclature(1)" ';
        						treatementData += 'value=' + data[i].dosage
        								+ ' id="dosage1"  maxlength="5" '+disableFlagVal+'disabled/>';
        						treatementData += '</td>';

        						treatementData += '<td ><select name="frequencyTre" class="form-control width100" id="frequencyTre'+ countNo + '" onchange="fillValueNomenclature(1)"';
        						treatementData += 'class="medium" '+disableFlagVal+'disabled>';

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
        						treatementData += '	<td><input type="text" class="form-control width60" value="'
        								+ data[i].noOfDays
        								+ '" name="noOfDays1" tabindex="1"';
        						treatementData += '	id="noOfDays1'+ countNo + '" onblur="fillValueNomenclature(1)" size="5"';
        						treatementData += '	maxlength="3" validate="No of Days,num,no"  '+disableFlagVal+'disabled/></td>';
                                }
                                else
                                {
                                treatementData += '	<td><input type="text" class="form-control width30" value="" name="noOfDays1" tabindex="1"';
        						treatementData += '	id="noOfDays1'+ countNo + '" size="3"';
        						treatementData += '	maxlength="3" disabled/></td>';	
                                }	
                                treatementData += '	<td><input type="text" class="form-control width70" value="'
        							+ data[i].total
        							+ '" name="total1" tabindex="1"';
                                treatementData += '	id="total1'+ countNo + '" size="5"';
                                treatementData += '	maxlength="3" '+disableFlagVal+'disabled/></td>';

        						/*treatementData += '<td><input type="text" class="form-control" tabindex="1" value="'
        								+ data[i].instruction + '" name="remarks1" ';
        						treatementData += 'id="remarks1" size="10" maxlength="10" '+disableFlagVal+'/>';
        						treatementData += '</td>';*/
        						//instruction = data[i].instruction;
        						treatementData +='<td><select name="instuctionFill" id="instuctionFill'+ countNo + '" class="form-control width100"';
        						treatementData +='class="medium" disabled>';
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
        						
        						treatementData+='<td class="">';
        						 treatementData+='<div class="width150 clearfix">';
        						/*treatementData+='<select onchange="this.className=this.options[this.selectedIndex].className" class="greenText">';
        						treatementData+='<option value="A" class="greenText" selected="selected">Observation</option>';
        						treatementData+='<option value="R" class="redText">New Suggestion</option>';
        						treatementData+='</select>';*/
        						treatementData+='<input type="radio"  id="observation'+data[i].itemId+'" name="action'+data[i].itemId+'" value="A" checked>';
        						treatementData+='<label for="observation'+data[i].itemId+'" class="greenText">Observation</label>';
        						treatementData+='<br><input type="radio" id="newSuggestion'+data[i].itemId+'" name="action'+data[i].itemId+'" value="R">';
        						treatementData+='<label for="newSuggestion'+data[i].itemId+'" class="redText" >New Suggestion</label>';
        						 treatementData+='</div>';
        	  					treatementData+='</td>';
        						
        						func1Treat='populatePVMSTreatment';
         		    		     url2Treat='opd';
         		    		     url3Treat='getMasStoreItemList';
         		    		     flagbTreat='numenclature';
         		    		    treatementData+='<td class="">';
         		    		   treatementData+='<div class="width400 clearfix">';
         		    		  treatementData+='<div class="autocomplete forTableResp pull-left width160">';
         		    		 treatementData+='<input name="icdTreatment" id="icdTreatment'+data[i].itemId+'" type="text"';
         		    		treatementData+='class="form-control border-input disablecopypaste  m-b-5"';
         		    		treatementData+='placeholder=" " value=""  onKeyUp="getNomenClatureList(this,\''+func1Treat+'\',\''+url2Treat+'\',\''+url3Treat+'\',\''+flagbTreat+'\');"  />';
         		    		treatementData+='<div class="autocomplete-itemsNew" id="icdTreatmentUpdatea'+data[i].itemId+'" ></div>';
         		    		treatementData+='</div>';
         		    		
         		    		treatementData+='<select name="treatmentIdSelect" multiple="4" value="" size="5"';
         		    		treatementData+='tabindex="1" id="treatmentIdSelect'+data[i].itemId+'" class="listBig disablecopypaste width200 pull-right"';
         		    		treatementData+='validate="ICD Daignosis,string,yes">';
         		    		treatementData+='</select>';
         		    		
         		    		treatementData+='<button type="button" class="buttonDel btn  btn-danger pull-left" value="" onclick="deleteDgTreatment('+data[i].itemId+');" > Delete </button>';
         		    		treatementData+='</div>';
         		    		treatementData+='</td>';
   							
         		    		treatementData += '<td class="">';
         		    		treatementData += '<textarea class="form-control width200" rows="2"></textarea>';
         		    		treatementData += '</td>';
        						
        						treatementData += '</tr>';
        						countForPvms+=1;
        						
        						//}
        						
        						countNo++;
        					  }
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
        							investigationData += ' class="form-control border-input" disabled name="chargeCodeName" onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" '+dateForReadonly+'/>';
        							investigationData += '<input type="hidden" id="qty" tabindex="1" name="qty1"  maxlength="6"/>';
        							investigationData += '<input type="hidden" tabindex="1" id="chargeCodeCode"';
        							investigationData += 'name="chargeCodeCode"  readonly />';
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

        							investigationData+='<td class="">';
        							/*investigationData+='<select onchange="this.className=this.options[this.selectedIndex].className" class="greenText">';
        							investigationData+='<option value="A" class="greenText" selected="selected">Observation</option>';
        							investigationData+='<option value="R" class="redText">New Suggestion</option>';
        							investigationData+='</select>';*/
        							investigationData+='<input type="radio"  id="observation'+data[i].investigationId+'" name="action'+data[i].investigationId+'" value="A" checked>';
        							investigationData+='<label for="observation'+data[i].investigationId+'" class="greenText">Observation</label>';
        							investigationData+='<br><input type="radio" id="newSuggestion'+data[i].investigationId+'" name="action'+data[i].investigationId+'" value="R">';
        							investigationData+='<label for="newSuggestion'+data[i].investigationId+'" class="redText" >New Suggestion</label>';
        							investigationData+='</td>';
        							
        							 func1Inv='populateChargeCode';
              		    		     url2Inv='opd';
              		    		     url3Inv='getIinvestigationList';
              		    		     flagbInv='investigation';
              		    		   investigationData+='<td class="">';
              		    		   investigationData+='<div class="width400 clearfix">';
              		    		 investigationData+='<div class="autocomplete forTableResp pull-left width180">';
              		    		investigationData+='<input name="icdInvestigation" id="investigation'+data[i].investigationId+'" type="text"';
              		    		investigationData+='class="form-control border-input disablecopypaste  m-b-5"';
              		    		investigationData+='placeholder=" " value=""  onKeyUp="getNomenClatureList(this,\''+func1Inv+'\',\''+url2Inv+'\',\''+url3Inv+'\',\''+flagbInv+'\');"  />';
              		    		investigationData+='<div class="autocomplete-itemsNew" id="icdInvestigationUpdatea'+data[i].investigationId+'" ></div>';
              		    		investigationData+='</div>';
              		    		
              		    		investigationData+='<select name="investigationIdSelect" multiple="4" value="" size="5"';
              		    		investigationData+='tabindex="1" id="investigationIdSelect'+data[i].investigationId+'" class="listBig disablecopypaste width200 pull-right"';
              		    		investigationData+='validate="ICD Daignosis,string,yes">';
              		    		investigationData+='</select>';
              		    		investigationData+='<button type="button" class="buttonDel btn  btn-danger pull-left" value="" onclick="deleteDgInvItems('+data[i].investigationId+');" > Delete </button>';
              		    		investigationData+='</div>';
              		    		investigationData+='</td>';
        							
        							investigationData += '<td class="">';
        							investigationData += '<textarea class="form-control width200" rows="2"></textarea>';
        							investigationData += '</td>';
        							
        							investigationData += ' </tr> ';
        							count++;
        						}

        						$("#dgInvetigationGrid").html(investigationData);
        						
        					
        					}

        				}
        			});

        	return false;
        }  
        
       
        var total_inv_value = '';
        var invValue = '';
        var idInvNo='';
          function populateChargeCode(val, inc,item) {
        	  
        	  var checkCurrentNomRowId=$(item).closest('tr').find("td:eq(0)").find("input:eq(3)").val();
        	  var index1 = val.lastIndexOf("[");
              var index2 = val.lastIndexOf("]");
              index1++;
              idInvNo = val.substring(index1, index2);
              if (idInvNo == "") {
                  return;
              } else {
                  obj = document.getElementById('investigationIdSelect'+checkCurrentNomRowId+'');
                  total_inv_value += val+",";
                 
                  obj.length = document.getElementById('investigationIdSelect'+checkCurrentNomRowId+'').length;
                  var b = "false";
                  for(var i=0;i<globalArray1.length;i++){
               		  
               		  var name = globalArray1[i].investigationId;
               		 
               		  if(name == idInvNo){
               			invValue = globalArray1[i].investigationId;
               			var idddd =$(item).closest('tr').find("td:eq(0)").find("input:eq(3)").attr("id");
 				        var existingInv=$('#'+idddd).val();
               		    if(existingInv==invValue)
				        {
				        	alert("Investigation is already added from opd");
				        	$("#investigation"+checkCurrentNomRowId).val("");
                		    b=true;
				        }	
               			 $("#investigationIdSelect"+checkCurrentNomRowId+" option").each(function()
                            		{
               				 			var valueOrg=$(this).val().split('&&&')
               				 			var idVal=valueOrg[0];
               				 		    if(idVal==invValue){
                            		    alert("Investigation is already added");
                            		    document.getElementById('investigation'+checkCurrentNomRowId+'').value = ""
                            		    b=true;
                            		    }
                            		});
               		  }
               	  }
                  if (b == "false") {
                  	
                      $('#investigationIdSelect'+checkCurrentNomRowId+'').append('<option value=' + invValue + '>' + val + '</option>');
                      document.getElementById('investigation'+checkCurrentNomRowId+'').value = ""

                  }
              }
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
          				trHTML += '<option value="' + item.frequencyId + '" >'
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

          					$('#dispensingUnit1').html(trHTMLDispUnit);
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
        								nursingData += ' class="form-control border-input" name="procedureNameNursing" disabled onKeyUp="getNomenClatureList(this,\''+func1+'\',\''+url1+'\',\''+url2+'\',\''+flaga+'\');" '+dateForReadonly+'/>';
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
        								nursingData += 'class="largTextBoxOpd textYellow form-control" disabled maxlength="100" '+dateForReadonly+'/>';
        								nursingData += '</td>';
        								
        								nursingData += ' </tr> ';
        								count++;
        							}

        							$("#gridNursing").html(nursingData);

        						}
        					}
        				});
        	}
          
          function deleteDgItems(val) {
          	var deleteDiagnosis = document.getElementById('diagnosisId'+val+'');
             if (deleteDiagnosis.selectedIndex == -1)
          	   {
          	       alert("Please select atleast one diagnosis")
          	       return false;
          	   }
          	   else
          		   {
	            		   if (confirm(resourceJSON.opdIcdDeleteMsg)) {
	
	                           if (document.getElementById('diagnosisId'+val+'').options[document.getElementById('diagnosisId'+val+'').selectedIndex].value != null)
	                               document.getElementById('diagnosisId'+val+'').remove(document.getElementById('diagnosisId'+val+'').selectedIndex)
	
	                       }
          		   }
          	
              
          }
          
          function deleteDgTreatment(val) {
            	var deleteDiagnosis = document.getElementById('treatmentIdSelect'+val+'');
               if (deleteDiagnosis.selectedIndex == -1)
            	   {
            	       alert("Please select atleast one durgs")
            	       return false;
            	   }
            	   else
            		   {
  	            		   if (confirm(resourceJSON.opdIcdDeleteMsg)) {
  	
  	                           if (document.getElementById('treatmentIdSelect'+val+'').options[document.getElementById('treatmentIdSelect'+val+'').selectedIndex].value != null)
  	                               document.getElementById('treatmentIdSelect'+val+'').remove(document.getElementById('treatmentIdSelect'+val+'').selectedIndex)
  	
  	                       }
            		   }
            	
                
            }
          
          function deleteDgInvItems(val) {
            	var deleteDiagnosis = document.getElementById('investigationIdSelect'+val+'');
               if (deleteDiagnosis.selectedIndex == -1)
            	   {
            	       alert("Please select atleast one investigation")
            	       return false;
            	   }
            	   else
            		   {
  	            		   if (confirm(resourceJSON.opdIcdDeleteMsg)) {
  	
  	                           if (document.getElementById('investigationIdSelect'+val+'').options[document.getElementById('investigationIdSelect'+val+'').selectedIndex].value != null)
  	                               document.getElementById('investigationIdSelect'+val+'').remove(document.getElementById('investigationIdSelect'+val+'').selectedIndex)
  	
  	                       }
            		   }
            	
                
            } 
         
          var total_treatment_value = '';
          var treatValue = '';
          var idTreatNo='';
            function populatePVMSTreatment(val, inc,item) {
            
            	var checkCurrentNomRowId=$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val();
            	
          	  var index1 = val.lastIndexOf("[");
                var index2 = val.lastIndexOf("]");
                index1++;
                idTreatNo = val.substring(index1, index2);
                if (idTreatNo == "") {
                    return;
                } else {
                    obj = document.getElementById('treatmentIdSelect'+checkCurrentNomRowId+'');
                    total_treatment_value += val+",";
                   
                    obj.length = document.getElementById('treatmentIdSelect'+checkCurrentNomRowId+'').length;
                    var b = "false";
                    for(var i=0;i<autoVsPvmsNo.length;i++){
                 		  
                 		  var name = autoVsPvmsNo[i][1];
                 		 
                 		  if(name == idTreatNo){
                 			treatValue = autoVsPvmsNo[i][0];
                 			var idddd =$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").attr("id");
     				        var existingTreatment=$('#'+idddd).val();
     				        if(existingTreatment==treatValue)
     				        {
     				        	alert("Treatment is already added from opd");
     				        	$("#icdTreatment"+checkCurrentNomRowId).val("");
                       		    b=true;
     				        }
                 			 $("#treatmentIdSelect"+checkCurrentNomRowId+" option").each(function()
                              		{
                 				 			var valueOrg=$(this).val().split('&&&')
                 				 			var idVal=valueOrg[0];
                 				 		    if(idVal==treatValue){
                              		    alert("Treatment is already added");
                              		    document.getElementById('icdTreatment'+checkCurrentNomRowId+'').value = ""
                              		    b=true;
                              		    }
                              		});
                 		  }
                 	  }
                    if (b == "false") {
                    	
                        $('#treatmentIdSelect'+checkCurrentNomRowId+'').append('<option value=' + treatValue + '>' + val + '</option>');
                        document.getElementById('icdTreatment'+checkCurrentNomRowId+'').value = ""

                    }
                }
            }
            
            function treatmentAuditSubmit() {
                var pathname = window.location.pathname;
                var accessGroup = "MMUWeb";

                var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/treatmentAudit/treatmentAuditSubmit"; 
                
             ///////////////////////////Patient sympotons json//////////////////////////////
                var flagRemarks=true;
               if( $('#auditorRemrks').val()=='')
               {
            	   alert("Plase enter auditor feedback remarks");
            	   return false;
               }	   
   	 		 var patientSympotnsArryVal = [];
			    		    var patientSympotnsValue=$('#patientSymAuditId').val();
			    		    
			    		    var myarray = patientSympotnsValue.split(',');

			    		    for(var i = 0; i < myarray.length; i++)
			    		    {
			    		         var param = {'symptomsId' : myarray[i],
				    	    		      'visitId':  $('#visitId').val(),
				    	    		      'patientId':$('#patientId').val()
				    	                 };
								
								patientSympotnsArryVal.push(param)
			    		    }
			   
                var dianosisException='N';
                var investgationFlag='N';
                var treatmentFlag='N';
                /////////////Diagnosis JSON Value /////////////////////////////////////
	            var icdArryVal = [];
	            var diagonsisText=[]; 
	            var dataDiagnosisID='';
	            
	          	$('#diagnosisGridRecall tr').each(function(i, el) {
	            	    var $tds = $(this).find('td')
	            	    var diagnosisId = $(this).find("td:eq(0)").find("input:eq(1)").val();
	            	    //var action = $tds.eq(3).find(":input").val();
	            	    //id="newSuggestion'+diagnosisId+'" name="action'+diagnosisId+'"
	            	    var action = $("input[type='radio'][name='action"+diagnosisId+"']:checked").val();
	            	    if(action=='R')
	            	    {
	            	    	dianosisException='Y';
	            	    }
	            	   
	            	    var remarks = $tds.eq(5).find(":input").val();
	            	    
	            	    //var diagonsisValue = $tds.eq(4).find(":input").val();
	            	    ///////////////////////////Patient Diagnosis json//////////////////////////////
	 		               var diagnosisArryVal = [];
			    		    var diagnosisText=[];
			    		    if(action=="R")
			    		    {	
					    	$("#diagnosisId"+diagnosisId+" > option").each(
									function() {
										var diagnosisIdValue=this.value;
										var param = {'diagnosisId' : diagnosisIdValue,
						    	    		      'action':  action,
						    	    		      'mainDiagnosisId':diagnosisId,
						    	    		      'remarks':remarks
						    	                 };
										
										diagnosisArryVal.push(param)
									});
			    		    }else
			    		    {
			    		    	$("#diagnosisId"+diagnosisId+" > option").each(
										function() {
											var diagnosisIdValue=this.value;
											var param = {'diagnosisId' : diagnosisIdValue,
							    	    		      'action':  action,
							    	    		      'mainDiagnosisId':diagnosisId,
							    	    		      'remarks':remarks
							    	                 };
											
											diagnosisArryVal.push(param)
										});
			    		    	var param = {'diagnosisId' : diagnosisId,
				    	    		      'action':  action,
				    	    		      'mainDiagnosisId':diagnosisId,
				    	    		      'remarks':remarks
				    	                 };
								
								diagnosisArryVal.push(param)
			    		    }	
					    	
					    	  
	            	    if(diagnosisArryVal!="")
	            		{
	            		dataDiagnosisID={
	            				      	  'icdId' : diagnosisArryVal,
	            				      	  'visitId':  $('#visitId').val(),
				    	    		      'patientId':$('#patientId').val()
	            		    	      	}
	            		
	            		icdArryVal.push(dataDiagnosisID);
	            		//diagonsisText.push(diagonsisTextValue);
	            		
	            		}
	            	});    
                  
                  console.dir(icdArryVal, {'maxArrayLength': null})
			              
			     ///////////////////////////Patient Investigation json//////////////////////////////
                  var invArryVal = [];
  	              var dataInvstigationID='';
  	          	$('#dgInvetigationGrid tr').each(function(i, el) {
  	            	    var $tds = $(this).find('td')
  	            	    var invDiagnosisId = $(this).find("td:eq(0)").find("input:eq(3)").val();
  	            	    //var action = $tds.eq(1).find(":input").val();
  	            	    var action = $("input[type='radio'][name='action"+invDiagnosisId+"']:checked").val();
  	            	    var remarks = $tds.eq(3).find(":input").val();
  	            	    if(action=="R")
  	            	    {
  	            	    	investgationFlag='Y';
  	            	    }
  	            	    //var diagonsisValue = $tds.eq(4).find(":input").val();
  	            	    ///////////////////////////Patient Diagnosis json//////////////////////////////
  	 		               var diagnosisArryVal = [];
  			    		    var diagnosisText=[];	
  			    		    if(action=="R")
    	            	    {
  					    	$("#investigationIdSelect"+invDiagnosisId+" > option").each(
  									function() {
  										var diagnosisIdValue=this.value;
  										var param = {'invId' : diagnosisIdValue,
  												   'mainInvId':invDiagnosisId,
  						    	    		      'action':  action,
  						    	    		      'remarks':remarks
  						    	                 };
  										
  										diagnosisArryVal.push(param)
  									});
    	            	    }
  			    		    else
  			    		    {
  			    		    	$("#investigationIdSelect"+invDiagnosisId+" > option").each(
  	  									function() {
  	  										var diagnosisIdValue=this.value;
  	  										var param = {'invId' : diagnosisIdValue,
  	  												   'mainInvId':invDiagnosisId,
  	  						    	    		      'action':  action,
  	  						    	    		      'remarks':remarks
  	  						    	                 };
  	  										
  	  										diagnosisArryVal.push(param)
  	  									});
  			    		    	var param = {'invId' : invDiagnosisId,
										   'mainInvId':invDiagnosisId,
				    	    		      'action':  action,
				    	    		      'remarks':remarks
				    	                 };
								
								diagnosisArryVal.push(param)
  			    		    }	
  					    	  
  	            	    if(diagnosisArryVal!="")
  	            		{
  	            	    	dataInvstigationID={
  	            				      	  'investgationId' : diagnosisArryVal,
  	            				      	  'visitId':  $('#visitId').val(),
  				    	    		      'patientId':$('#patientId').val()
  	            		    	      	}
  	            		
  	            	    	invArryVal.push(dataInvstigationID);
  	            		//diagonsisText.push(diagonsisTextValue);
  	            		
  	            		}
  	            	});    
					
  	          console.dir(invArryVal, {'maxArrayLength': null})
  	          
  	           ///////////////////////////Patient Treatment json//////////////////////////////
                  var treatmentArryVal = [];
  	              var dataTreatmentID='';
  	          	$('#nomenclatureGrid tr').each(function(i, el) {
  	            	    var $tds = $(this).find('td')
  	            	    var diagnosisIdTreat = $(this).find("td:eq(0)").find("input:eq(1)").val();
  	            	    //var action = $tds.eq(7).find(":input").val();
  	            	    var action = $("input[type='radio'][name='action"+diagnosisIdTreat+"']:checked").val();
  	            	    var remarks = $tds.eq(9).find(":input").val();
  	            	    if(action=='R')
  	            	    {
  	            	    	treatmentFlag='N';
  	            	    }	
  	            	    //var diagonsisValue = $tds.eq(4).find(":input").val();
  	            	    ///////////////////////////Patient Diagnosis json//////////////////////////////
  	 		               var diagnosisArryVal = [];
  	 		            if(action=='R')
  	            	    {  	
  					    	$("#treatmentIdSelect"+diagnosisIdTreat+" > option").each(
  									function() {
  										var diagnosisIdValue=this.value;
  										var param = {'treatId' : diagnosisIdValue,
  												      'mainTreatmentId':diagnosisIdTreat,
  						    	    		          'action':  action,
  						    	    		          'remarks':remarks
  						    	                 };
  										
  										diagnosisArryVal.push(param)
  									});
  	            	    }
  	 		            else
  	 		            {
  	 		            	$("#treatmentIdSelect"+diagnosisIdTreat+" > option").each(
  									function() {
  										var diagnosisIdValue=this.value;
  										var param = {'treatId' : diagnosisIdValue,
  												      'mainTreatmentId':diagnosisIdTreat,
  						    	    		          'action':  action,
  						    	    		          'remarks':remarks
  						    	                 };
  										
  										diagnosisArryVal.push(param)
  									});
  	 		            	var param = {'treatId' : diagnosisIdTreat,
								      'mainTreatmentId':diagnosisIdTreat,
		    	    		          'action':  action,
		    	    		          'remarks':remarks
		    	                 };
						
						diagnosisArryVal.push(param)
  	 		            }	
  					    	  
  	            	    if(diagnosisArryVal!="")
  	            		{
  	            	    	dataTreatmentID={
  	            				      	  'treatmentId' : diagnosisArryVal,
  	            				      	  'visitId':  $('#visitId').val(),
  				    	    		      'patientId':$('#patientId').val()
  	            		    	      	}
  	            		
  	            	    	treatmentArryVal.push(dataTreatmentID);
  	            		//diagonsisText.push(diagonsisTextValue);
  	            		
  	            		}
  	            	});    
					
  	          	///////////////////////////Audit Exception json//////////////////////////////
  	          var finalRemarksVal = $("input[type='radio'][name='finalRemarks']:checked").val();
  	        
  	           var dataJSON = {

                    'visitId': $('#visitId').val(),
                    'patientId': $('#patientId').val(),
                    'userId':$('#userIdVal').val(),
                    'mmuId':$('#hospitalId').val(),
                    'icdDiagnosis' : icdArryVal,
                    'investigationData':invArryVal,
                    'treatmentData':treatmentArryVal,
                    'auditorRemrks':$('#auditorRemrks').val(),
                    'finalFlag':finalRemarksVal,
                    'dianosisException':dianosisException,
                    'investgationFlag':investgationFlag,
                    'treatmentFlag':treatmentFlag,
                    'symptomsValue':patientSympotnsArryVal,
                    'actual_fee': $('#actual_fee').val()
                  
                  
  	          }
  	          
  	        $("#btnSubmit").attr("disabled", true);
              $.ajax({
                  type: "POST",
                  contentType: "application/json",
                  url: url,
                  data: JSON.stringify(dataJSON),
                  dataType: 'json',
                
                  success: function(msg) {
                  	console.log(msg)
                      if (msg.status == 1)
                      {
                      
                    	  var Id= $('#visitId').val()
                         window.location.href ="treatmentSubmit?visitId="+Id+"";
                      } 
                      else if(msg.status == 0)
                      {
                       $("#btnSubmit").attr("disabled", false);	
                       alert(msg.msg)	
                      }	
                      else
                      {
                      	$("#btnSubmit").attr("disabled", false);
                      	alert(msg.msg)	
                      }
                  },
                  error: function(jqXHR, exception) {
                  	$("#btnSubmit").attr("disabled", false);
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
                      alert("Response msg is "+msg);
                  }
              });

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
            
            function viewEcgDocumnt()
        	{
        		var pathname = window.location.pathname;
        		var accessGroup = "MMUWeb";

        		var urlEcg = window.location.protocol + "//"
        				+ window.location.host + "/" + accessGroup
        				+ "/opd/viewEcgDocument";
        		var visitIdVal= $('#visitId').val();
        		 $.ajax({
                     type: "POST",
                     contentType: "application/json",
                     url: urlEcg,
                     data: JSON.stringify({
                         'visitId': visitIdVal
                     }),
                     dataType: 'json',
                     timeout: 100000,
                     success: function(res) {
                 	 
                    	 var data = res.ecg;
                    	 var ecgImage='';
             			if (data != '') {
             				//window.open(data.ecgDocument,'_blank');
             				openPdfModel(data.ecgDocument);
             			} else {
             				alert("No Record Found")
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
                     alert("Response msg is "+msg);
                 }
             });

        	}
            
            function backToList()
        	{
        		location.href='auditWaitingList';
        	}
