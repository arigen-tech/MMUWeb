<%@page import="java.util.HashMap"%>
    <%@page import="java.util.Map"%>
    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

          
        <%--   <%@include file="..//view/leftMenu.jsp" %> --%>

                <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
               <%--  <jsp:include page="..//view/commonModal.jsp" />
                <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/commonformodal.js"></script>
               <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
                --%>     <html>

                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
       
                            <title>OPD NIV Treatment Template</title>
               
                   
                    </head>
                    <body style="background:#ffff;">
                    
                    
   

<%
	String hospitalId = "1";
	if (session.getAttribute("hospital_id") != null) {
		hospitalId = session.getAttribute("hospital_id") + "";
	}
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
%>
<div class="Clear"></div>

	
<script type="text/javascript" language="javascript">

	
     
    

function submitWindow()
{
var code=document.getElementById('code').value;
var flag =true;
if(validateMetaCharacters(code)){

}

}

function closeWindow()
{
  window.close();
}


var templateCode='';
function createTemplateCode(){
	
var templateName=document.getElementById("templateName").value;
if(validateMetaCharacters(templateName)){
if(templateName.length>5){

	templateCode=templateName.substring(0,5);
document.investigationTemplate.code.value=templateCode;
//alert("tempalte code" + templateCode);
}
else{
document.treatmentTemplate.code.value=templateName;
}
}
}
	</script>
<form name="treatmentTemplate" autocomplete="off" method="post" action="">

		<input type="hidden" name=" " value="OpdTemplate" /> <input
			type="hidden" name=" " value="TemplateName" /> <input type="hidden"
			name="title" value="OpdTemplate" /> <input type="hidden" name=" "
			value="opdTemplate" /> <input type="hidden" name="hiddenValueCharge"
			id="hiddenValueCharge" /> <input type="hidden"
			name="pojoPropertyCode" value="TemplateCode" />
<div class="clear" style="margin-top:8px;"></div>
    
			<!--  <label>Template Code </label>-->

			<input type="hidden" name="code" id="code" value="" disabled="true"
				readonly="readonly" validate="Template Code,metachar,yes"
				MAXLENGTH="8" tabindex=1 />
				
				<!--  <label><span>*</span> Template	Name</label> 
				 
				 
				<input type="text" name=" " id="templateName" value=""
				onblur="createTemplateCode();" validate="Template Name,metachar,yes"
				MAXLENGTH="30" tabindex=1 /> -->
				
				
				                                <div class="row">
                                                            <div class="col-md-6">
																  <div class="form-group row">
																 <label class="col-sm-5" style="background:none;">Template Name <span class="mandate"><sup>*</sup></span></label>
																  <div class="col-sm-7">  
																      <input type="text" class="form-control" name=" " id="templateName" value=""
																		onblur="createTemplateCode();" validate="Template Name,metachar,yes"
																		MAXLENGTH="30" tabindex=1 /> 
                                                                    </div>
																 </div>
																</div>
																
																
																 <div class="col-md-6">
																  
																</div>
																
																
													 </div>
				
				

		<div class="clear"></div>
		<div class="paddingTop15"></div>
		<div class="table-responsive">
										<table class="table verticalAlignTD " align="center"
											cellpadding="0" cellspacing="0" id="dgNipGrid">
											<tr>
												<th  style="width: 458px; ">NIV</th>
												<th style="width: 235px; ">Class<span>*</span></th>
												<th style="width: 235px; ">A/U<span>*</span></th>
												<th style="display: none;">Disp. Unit</th>
												<!-- <th style="width: 210px; ">UOM Qty</th> -->
												<th style="width: 210px; ">Dosage<span>*</span></th>
												<th style="width: 235px; ">Frequency<span>*</span></th>
												<th style="width: 210px; ">Days<span>*</span></th>
												<th style="width: 210px; ">Total<span>*</span></th>
												<th style="width: 210px; ">Instructions</th>
												

												<th>Add</th>
												<th>Delete</th>

											</tr>
											<tbody id=nipGridCreateTemplate>
												
												<tr>

													<td>
														<div class="autocomplete forTableResp">
															<input type="text" value="" tabindex="1" autocomplete="never" spellcheck="false"
																id="oldnip1Temp"  size="50" name="oldnip1Temp"
																class="form-control border-input width330 disablecopypaste" onKeyUp="getNomenClatureList(this,'populatePVMSforNipTreatment','opd','getMasStoreItemNip','newNib');" /> 
                                                        <div id="newNibForPVMSTemp" class="autocomplete-itemsNew"></div> 
														</div>
													</td>
												   <td>
                                                    <select name="class1Temp" id="class1Temp" class="medium form-control width100" ></select>
                                                    </td> 
                                                    <td>
                                                    <select name="au1Temp" id="au1Temp" class="medium form-control width100" ></select>
                                                    </td> 
												
													<td><input type="text" name="dosage1Temp" tabindex="1"
														value="" id="dosage1Temp" onblur="fillValueNipTemplate()" size="5" maxlength="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  class="form-control width50 disablecopypaste" />
													</td>

													<td><select name="nipfrequency1Temp" id="nipfrequency1Temp" onchange="fillValueNipTemplate()"
														class="medium form-control width100">

													</select></td>

													<td><input type="text" name="noOfDays1Temp" tabindex="1"
														id="noOfDays1Temp" onblur="fillValueNipTemplate()"
														size="5" maxlength="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"   class="form-control width50 disablecopypaste" /></td>

													<td><input type="text" name="total1Temp" tabindex="1"
														id="total1Temp" size="5" validate="total,num,no"
														onblur="treatmentTotalAlert(this.value,1)"  class="form-control width50 disablecopypaste"  /></td>

													<td><input type="text" name="remarks1Temp" tabindex="1"
														id="remarks1Temp" size="10" maxlength="10"  class="form-control width100" />
													</td>

													<td style="display: none;"><input type="hidden"
														value="" tabindex="1" id="itemIdNomNipTemp" size="77"
														/></td>
													<td>

														<button type="button" class="btn btn-primary buttonAdd noMinWidth"
															name="button" value="" button-type="add"
															onclick="addNipRowTreatment();" tabindex="1"></button>

													</td>
													<td>


														<button type="button" class="buttonDel  btn btn-danger noMinWidth"
															name="button" id="deleteNomenclature" button-type="delete" value=""
															onclick="removeRowNipTreatment(this);"
															tabindex="1"></button>

													</td>
													<td style="display: none;"><input type="hidden"
														name="nippvmsNo1Temp" tabindex="1" id="nippvmsNo1Temp" size="10"
														readonly="readonly" /></td>
												</tr>

											</tbody>
											
										</table> 
			<div class="Clear"></div>
		</div>
      <!--  <h5>NIV</h5> 
										<div class="table-responsive">
										<table class="table verticalAlignTD " align="center"
											cellpadding="0" cellspacing="0" id="dgNipGridTemplate">
											<tr>
												<th  style="width: 458px; ">NIV</th>
												<th style="width: 210px; ">Dosage<span>*</span></th>
												<th style="width: 235px; ">Frequency<span>*</span></th>
												<th style="width: 210px; ">Days<span>*</span></th>
												<th style="width: 210px; ">Total<span>*</span></th>
												<th style="width: 210px; ">Instructions</th>
												<th>Add</th>
												<th>Delete</th>

											</tr>
											<tbody id="nipGridTemplate">
												<tr>

													<td>
														<div class="autocomplete forTableResp">
															<input type="text" value="" tabindex="1" autocomplete="_off" 
																id="oldnip1"  size="77" name="oldnip1"
																class="form-control border-input width330" 
																onblur="populatePVMSforNip(this.value,'1',this);" />
																<input type="text" value="" tabindex="1" autocomplete="never" spellcheck="false"
																id="oldnip1Treatment"  size="50" name="oldnip1Treatment"
																class="form-control border-input width330 disablecopypaste" onKeyUp="getNomenClatureList(this,'populatePVMSforNipTreatment','opd','getMasStoreItemNip','newNib');" /> 
                                                        <div id="newNibForPVMSTreatment" class="autocomplete-itemsNew"></div> 
														</div>
													</td>
													                                                  
													<td style="display: none;"><input type="text" name="dispensingUnit1Treatment"
														tabindex="1" id="dispensingUnit1Treatment" size="6"
														validate="AU,string,no" readonly="readonly"  class="form-control width100"/>
													</td>
                                                    <td><input type="text" name="uomqty1"
														tabindex="1" value="" id="uomqty1" size="3"
														class="form-control width50" />
													</td>
													<td><input type="text" name="dosage1Treatment" tabindex="1"
														value="" id="dosage1Treatment" onblur="fillValueNip()" size="5" maxlength="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  class="form-control width50 disablecopypaste" /></td>

													<td><select name="nipfrequency1Treatment" id="nipfrequency1Treatment" onchange="fillValueNip()"
														class="medium form-control width100">

													</select></td>

													<td><input type="text" name="noOfDays1Treatment" tabindex="1"
														id="noOfDays1Treatment" onblur="fillValueNip()"
														size="5" maxlength="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"   class="form-control width50 disablecopypaste" /></td>

													<td><input type="text" name="total1Treatment" tabindex="1"
														id="total1Treatment" size="5" validate="total,num,no"
														onblur="treatmentTotalAlert(this.value,1)"  class="form-control width50 disablecopypaste"  /></td>

													<td><input type="text" name="remarks1Treatment" tabindex="1"
														id="remarks1Treatment" size="10" maxlength="10"  class="form-control width100" />
													</td>

													<td style="display: none;"><input type="hidden"
														value="" tabindex="1" id="itemIdNomNipTreatment" size="77"
														/></td>
													<td>

														<button type="button" class="btn btn-primary buttonAdd noMinWidth"
															name="button" value="" button-type="add"
															onclick="addTreatmentNipRow();" tabindex="1"></button>

													</td>
													<td>


														<button type="button" class="buttonDel  btn btn-danger noMinWidth"
															name="button" id="deleteNomenclature" button-type="delete" value=""
															onclick="removeRowNipTreatment(this);"
															tabindex="1"></button>

													</td>
													<td style="display: none;"><input type="hidden"
														name="nippvmsNo1Treatment" tabindex="1" id="nippvmsNo1Treatment" size="10"
														readonly="readonly" /></td>
												</tr>

											</tbody>
											<tr>
										</table> 
										
										</div> -->

		<div class="Clear"></div>
		<div class="division"></div>
<div style="float:right;">
		<button type="button" name="add" id="addbutton" value=""
			class="button btn btn-primary"  onClick="submitWindow();" accesskey="a" tabindex=1>Save</button>
		    <button type="reset" name="Reset" id="reset" value=""
			class="button btn btn-primary" onclick="resetCheck();" accesskey="r">Reset</button>
			 <button	type="reset" name="Reset" id="reset" value="" class="button btn btn-danger"
			data-dismiss="modal" accesskey="r" /u>Close</button>
</div>
		
		<div class="Clear"></div>
		<div class="division"></div>
	                                        
		
		 
	</form>

</div>
</div>

<script type="text/javascript" language="javascript">

		  
	     
	    

				var n=0;
				function addNipRowTreatment() {
				    n++;
				   	var aClone = $('#nipGridCreateTemplate>tr:last').clone(true)
					aClone.find(":input").val("");
					aClone.find("td:eq(0)").find(":input").prop('id', 'oldnip1Temp'+n+'');
					aClone.find("td:eq(1)").find("select:eq(0)").prop('id', 'class1Temp'+n+''); 
					aClone.find("td:eq(2)").find("select:eq(0)").prop('id', 'au1Temp'+n+'');
					aClone.find("td:eq(1)").find("select:eq(0)").removeAttr('disabled');
					aClone.find("td:eq(2)").find("select:eq(0)").removeAttr('disabled');
					//aClone.find('option[type="select"]').removeAttr('disabled');
					aClone.find("td:eq(8)").find(":input").prop('id', 'itemIdNomNipTemp'+n+'');
					aClone.find("option[selected]").removeAttr("disabled")
					aClone.clone(true).appendTo('#nipGridCreateTemplate');
					var valNip = $('#nipGridCreateTemplate>tr:last').find("td:eq(0)").find(":input")[0];
					//autocomplete(valNip, arryNomenclatureNip);
					
				}
	        
	       
</script>

<script type="text/javascript" language="javascript">
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
					'employeeId' : '1',
					}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
					var datas = response.MasFrequencyList;
					var trHTML = '<option value=""><strong>Select...</strong></option>';
					$.each(datas, function(i, item) {
						trHTML += '<option value="' + item.feq + '@'
								+ item.frequencyId + '" >' + item.frequencyName
								+ '</option>';
					});

					$('#nipfrequency1Temp').html(trHTML);
					$('#nipfrequency1Treatment').html(trHTML);
					
					// $('#referHospitalList').html(trHTML);
					// referHospitalList

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
 
 </script>
 <script type="text/javascript">
 $(document).ready(function() {

	getFrequencyDetail();
	getDispUnitDetail();
	getItemClass();
})
</script>

<script type="text/javascript" language="javascript">


 $('#addbutton').click(function() {
	 
	
	 var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";

		var url = window.location.protocol + "//"
				+ window.location.host + "/" + accessGroup
				+ "/opd/saveTreatmentOpdTemplates";
     
		if(document.getElementById('templateName').value == "") {
            alert("Please enter Template Name");
            document.getElementById('templateName').focus(); 
            return false;
          }	
		
		/////////////////////// treatment validation part ////////////////////////////
    	var extNomenclatureFlag=true;
		var count1=0;
		var count2=0;
		var count3=0;
		var count4=0;
		var count5=0;
    	var valnomenclatureGrid='';	
    	  $('#nipGridCreateTemplate tr').each(function(i, el) {
       	     
    		  var $tds = $(this).find('td')
       	    var treatmentName = $tds.eq(0).find(":input").val();
       	    var dosage = $tds.eq(3).find(":input").val();
       	    var frequency = $tds.eq(4).find(":input").val();
       	    var days = $tds.eq(5).find(":input").val();
       	    var instruction = $tds.eq(7).find(":input").val();
       	    var itemIdCheck = $tds.eq(8).find(":input").val();
       	    var total = $tds.eq(6).find(":input").val();
       	    //alert("item id "+itemIdCheck)
       	 if(itemIdCheck== "")
    	 {
        		alert("Please enter valid prescription name");
        		itemIdCheck.focus();
      		    return false;       	
    	 }
       	if(dosage== "" || dosage==0)
  	    {
      		alert("Dosage should be greater than 0 under nomenclature template");
      		dosage.focus();
     		return false;      	
  		}
       	if(frequency== "")
   	    {
       		alert("Please select Frequency");
       		frequency.focus();
     		return false;       	
   		}
    	if(days== "")
   	    {
       		alert("Please Enter No. of Days");
       		frequency.focus();
     		return false;       	
   		}
    	if(total== "" || total==0)
   	    {
       		alert("Total should be greater than 0 under nomenclature template");
       		total.focus();
     		return false;       	
   		}
     
         });
         if(extNomenclatureFlag == false){
       	  return;
         }	
         
		
		var tableDataPrescrption = [];  
    	var dataPresecption='';
    	var idforTreat='';
	$('#nipGridCreateTemplate tr').each(function(i, el) {
		idforTreat= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
	if(document.getElementById(idforTreat).value!= '' && document.getElementById(idforTreat).value != undefined)
    {
	var $tds = $(this).find('td')
  	var itemIdPresc = $tds.eq(8).find(":input").val();
	var dosage = $tds.eq(3).find(":input").val();
	var frequency = $tds.eq(4).find(":input").val();
	var splitFrequency=frequency.split("@");
	var noofdays = $tds.eq(5).find(":input").val();
	var total = $tds.eq(6).find(":input").val();
	var instruction = $tds.eq(7).find(":input").val();
	
	dataPresecption={
			'itemId' : itemIdPresc,
			'dosage' : dosage,
			'frequencyId' : splitFrequency[1],
			'noOfDays' : noofdays,
			'total' : total,
			'instruction' : instruction,
		}
	tableDataPrescrption.push(dataPresecption)
    }
  });	
		
	 var dataJSON = {
	 'templateCode' : templateCode,
	 'templateName' : $('#templateName').val(),
	 'templateType' : "N",
	 'doctorId' : <%=userId%>,
	 'userId' : <%=userId%>,
	 'hospitalId' : <%=hospitalId%>,
	 "listofTreatmentTemplate" : tableDataPrescrption
	 }
	 $("#addbutton").attr("disabled", true);
	 $.ajax({
	 type : "POST",
	 contentType : "application/json",
	 url : url,
	 data : JSON.stringify(dataJSON),
	 dataType : 'json',
	 timeout : 100000,
	 success : function(msg) {
	 console.log("SUCCESS: ", msg);
	 if (msg.status == 1)
 	   {
		   alert("OPD NIV Treatment Template Details Inserted successfully");
		   getNivTreatmentTemplateDetail();
		   $j('#exampleModal .modal-body').empty();		   
		   $('#exampleModal .modal-body').load("createNivTreatmentTemplate?employeeId="+<%= userId %>);
		  
	   }
		
	  else
	  {
		  $("#addbutton").attr("disabled", false);
		  alert(msg.status)
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
     },
	 });
});

 function removeRowNipTreatment(val){
		
		if($('#nipGridCreateTemplate tr').length > 1) {
			   $(val).closest('tr').remove()
			 }

	}
 var nipPvmsNo = '';
 function populatePVMSforNipTreatment(val,inc,item) {
 	//alert("called");
 	if (val != "") {
 		
 		var index1 = val.lastIndexOf("[");
 		var indexForBrandName = index1;
 		var index2 = val.lastIndexOf("]");
 		index1++;
 		nipPvmsNo = val.substring(index1, index2);
 		var indexForBrandName = indexForBrandName--;
 		var brandName = val.substring(0, indexForBrandName);
 		// alert("pvms no--"+pvmsNo)

 		if (nipPvmsNo == "") {
 			// alert("pvms no1111--"+pvmsNo)
 			// document.getElementById('nomenclature' + inc).value = "";
 			// document.getElementById('pvmsNo' + inc).value = "";
 			return false;
 		} else {
 			//document.getElementById('nippvmsNo' + inc).value = nipPvmsNo
 			 var itemIdNipPrescription= '';
 			  var nipPvmsValue = '';
 				  for(var i=0;i<nipDataforItem.length;i++){
 					var nipItemIdValue= nipDataforItem[i].itemId;
 					var itemClassId=nipDataforItem[i].itemClassId;
 					var dispUnitId=nipDataforItem[i].dispUnitId;
 					  if(nipItemIdValue == nipPvmsNo){
 						
 						  itemIdNipPrescription =nipItemIdValue //data[i].itemId;
 						  var checkCurrentNomRowIdNip=$(item).closest('tr').find("td:eq(8)").find("input:eq(0)").attr("id");
               			  var checkCurrentNomRowValNip=$(item).closest('tr').find("td:eq(8)").find("input:eq(0)").val();  
               			 $('#nipGridCreateTemplate tr').each(function(i, el) {
       	     			   var $tds = $(this).find('td')
       	  			       var itemIdCheckNip=  $($tds).closest('tr').find("td:eq(8)").find("input:eq(0)").attr("id");
       	     			   var itemIdValueNip=$('#'+itemIdCheckNip).val();
       	     			   var iddddNip =$(item).closest('tr').find("td:eq(8)").find("input:eq(0)").attr("id");
       	     			   var currentiddddNip=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
       	     			   //if(itemIds!="" &&  itemIdValue!="" && itemIdValue!="undefined" )
       	     			 
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
       	     			  $(item).closest('tr').find("td:eq(8)").find(":input").val(itemIdNipPrescription)
       	 				  var classNip=$(item).closest('tr').find("td:eq(1)").find("select:eq(0)").attr("id");
       	 				  document.getElementById(classNip).value = itemClassId; 
       	 				  document.getElementById(classNip).disabled = true;
       	 				  var auNip=$(item).closest('tr').find("td:eq(2)").find("select:eq(0)").attr("id");
       	 				  document.getElementById(auNip).value = dispUnitId;
       	 				  document.getElementById(auNip).disabled = true;  
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
 
 
 function removeTreatmentTemplateRow(val){
		if($('#nomenclatureGridTemplate tr').length > 1) {
		   $(val).closest('tr').remove()
		 }
	}
 
 function fillValueNipTemplate() {

		var TableData = new Array();
	    $('#nipGridCreateTemplate tr').each(function(i, el) {

			var $tds = $(this).find('td')
			var nipAuto = $tds.eq(0).find(":input").val();
			//var nipManual = $tds.eq(1).find(":input").val();
			var dosage = $tds.eq(3).find(":input").val();
			var frequency = $tds.eq(4).find(":input").val();
			var splitFrequency = frequency.split("@");
			var noofdays = $tds.eq(5).find(":input").val();
			var total = dosage * splitFrequency[0] * noofdays;
			var t=Math.round(total);
			$tds.eq(6).find(":input").val(t);
			// $(').closest('tr').find("td:eq(5)").find(":input").val(total)
			// $(item).closest('tr').find("td:eq(5)").find(":input").val(total)
			// $('$tds.eq(5)').val($(this).val());
			// alert("total value" + total)

		});

		// console.log(TableData);
	}
 
 </script>

</body>
</html>
