<%@page import="java.util.HashMap"%>
  <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


                <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                    <html>

                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
                     
                            <title>OPD Investgation Template</title>
                    	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autoPopulate.js"></script>
                         <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opd.js"></script>
                   <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
                     <script type="text/javascript">
					window.history.forward();
					var labRadioValue=resourceJSON.mainchargeCodeLab;
					var imagRadioValue=resourceJSON.mainchargeCodeRadio;
					</script>
				     <script type="text/javascript">
 
					 $(document).ready(
								function() {
						$('#lab_radioTemp').val(labRadioValue);
						$('#imag_radioTemp').val(imagRadioValue);
					});	 
					</script> 
                   
                    </head>
                    <body style="background:#ffff;">
                    
                    
<%
	String hospitalId = "1";
	if (session.getAttribute("mmuId") != null) {
		hospitalId = session.getAttribute("userId") + "";
	}
	String userId = "1";
	if (session.getAttribute("mmuId") != null) {
		userId = session.getAttribute("userId") + "";
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
                                                            <div class="col-md-5">
																  <div class="form-group row">
																 <label class="col-sm-5 col-form-label">Select Template <span
													class="mandate"><sup>&#9733;</sup></span></label>
																  <div id="investigationDiv" class="col-md-7">
																	<select name="updateinvestigationTemplateId"  class="form-control" 
																		id="updateInvestigationTemplateId" tabindex="1">
																	</select>
															   	</div>
																 </div>
																</div>
																
																
													 </div>
				
				

		<div class="clear"></div>
		<div class="showOntemplate" style="display: none;">
		
		 <div class="row">
            <div class="col-md-5">
			 <div class="form-group row">
			 <label class="col-sm-5 col-form-label" >Template Name<span class="mandate"><sup>&#9733;</sup></span> </label>
			 <div class="col-sm-7">  
			 <input type="text" class="form-control" name=" " id="invTemplateName" value="" onblur="createTemplateCode();" validate="Template Name,metachar,yes"
			  MAXLENGTH="30" tabindex=1 /> 
			 <input type="hidden" name="invTemplateId" id="invTemplateId" value="" />
              </div>
			</div>
			</div>
					
	 </div>
		<div id="testDiv">
		<div class="row m-b-10">
			<div class="col-md-1">
			<div class="form-check form-check-inline cusRadio">
					<input type="radio" onchange="changeRadio(this.value)" checked="checked" name="labradiologyCheck" class="radioCheckCol2 form-check-input" value="" id="lab_radioTemp">
					<span class="cus-radiobtn"></span> 
					<label class="form-check-label " for="lab_radioTemp">Lab</label>
			</div>
			</div>
			<div class="col-md-1">
			<div class="form-check form-check-inline cusRadio" style="display: none";>
				<input type="radio" onchange="changeRadio(this.value)" name="labradiologyCheck" class="radioCheckCol2 form-check-input" value="" id="imag_radioTemp">
				<span class="cus-radiobtn"></span> 
				<label class="form-check-label" for="imag_radioTemp">ECG/ Others</label>
			</div>
			</div>
		</div>
			
			<table class="table table-striped table-hover table-bordered" align="center" cellpadding="0" cellspacing="0" >
			<!-- <tr>
					<td colspan="3" style="background: #c5c4c4;">
						<div style="background: #c5c4c4;">
							<input type="radio" onchange="changeRadio(this.value)"
								checked="checked" name="labradiologyCheck"
								class="radioCheckCol2" value="2">Lab <input type="radio"
								onchange="changeRadio(this.value)" name="labradiologyCheck"
								class="radioCheckCol2" value="1">Imaging <input
								type="hidden" id="investigationCategory"
								name="investigationCategory" value="Lab">
							<div class="clear">
							</div>
						</div>

					</td>
				</tr> -->								
											<tr id="th">
												<th  style="width:70%;">Investigation</th>
												<th>Add</th>
												<th>Delete</th>

											</tr>
											<tbody id="grid">
												<tr>

													<td>
													 <div class="autocomplete">
													<input type="text" value="" id="chargeCodeNameTemplate" autocomplete="off"
													class="form-control border-input"
													name="chargeCodeNameTemplate"  size="44"
													onblur="populateChargeCodeTemplate(this.value,1,this);" />
													</div>
													</td>
                                  					<td>

														<button type="button" class="btn btn-primary buttonAdd"
															name="button" type="button" value=""
															onclick="addInvetigationRow()" tabindex="1">Add</button>

													</td>
													<td>


														<button type="button" class="buttonDel  btn btn-danger"
															name="button" type="button" value=""
															onclick="removeRowInvestigation(this);""
															tabindex="1">Delete</button>

													</td>
													<td style="display: none;"><input type="hidden"
														value="" tabindex="1" id="InvestigationIdTemplate" size="77"
														name="InvestigationIdTemplate" />
													</td>
													<td style="display: none;"><input type="hidden"
														value="" tabindex="1" id="investigationDataId" size="77"
														name="investigationDataId" />
													</td>
													
												</tr>

											</tbody>
											
										</table> 
			<div class="Clear"></div>
		</div>


		<div class="Clear"></div>
		<div class="division"></div>
<div style="float:right;">
		<button type="button" name="add" id="addbutton" value=""
			class="button btn btn-primary"  onClick="submitWindow();" accesskey="a" tabindex=1>Update</button>
	        <button type="button" name="deleteTemplate" id="deleteTemplate" value=""
			class="button btn btn-primary" onclick="deleteFullTemplate()" >Delete Template</button>
			 <button	type="reset" name="Reset" id="reset" value="" class="button btn btn-danger"
			data-dismiss="modal" accesskey="r" /u>Close</button>
</div>
		
		<div class="Clear"></div>
		<div class="division"></div>
	                                        
		</div>
		 
	</form>


<script>

var arryInvestigation= new Array();
var val=$('#grid').children('tr:first').children('td:eq(0)').find(':input')[0]
oldautocomplete(val, arryInvestigation);

</script>


<script type="text/javascript" language="javascript">
$(document).ready(
		function() {
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
			'employeeId' : <%= userId %>,
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
	

}); 

var arrayData = [];
var i = "";
var invesRadio="";
function changeRadio(radioValue){
	invesRadio=radioValue;
	i++;
	
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";

	var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/opd/getIinvestigationList";


	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : url,
		data : JSON.stringify({
			'employeeId' : <%= userId %>,
			'mainChargeCode':radioValue,
		}),
		dataType : 'json',
		timeout : 100000,
		
		success : function(res)
		
		{
			arryInvestigation=[];
			arrayData=[];
			var data = res.InvestigationList;
			
			for(var i=0;i<data.length;i++){
				var investigationId= data[i].investigationId;
				var investigationName = data[i].investigationName;
				var a=investigationName+"["+investigationId +"]"
				arrayData.push(a);
				     			      
			      var inChangeValFirst=$('#grid').children('tr:last').children('td:eq(0)').find(':input')[0]
			      oldautocomplete(inChangeValFirst, arrayData);  			 
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
var charge_code_array = [];
var ChargeCode='';
var multipleChargeCode = new Array();
function populateChargeCodeTemplate(val,count,item) {
	
//	if(validateMetaCharacters(val)){
		if(val != "")
		{
			
		    var index1 = val.lastIndexOf("[");
		    var indexForChargeCode=index1;
		    var index2 = val.lastIndexOf("]");
		    index1++;
		    ChargeCode = val.substring(index1,index2);
		    
		    var indexForChargeCode=indexForChargeCode--;
		   //alert("value is fun "+ChargeCode);
       
		if(ChargeCode == "")
		{
		
		return;
		}
		else{
		    var checkCurrentRowIddd=$(item).closest('tr').find("td:eq(3)").find("input:eq(0)").attr("id");
		 	var checkCurrentRow=$(item).closest('tr').find("td:eq(3)").find("input:eq(0)").val();
		    var count=0;   			
		        $('#grid tr').each(function(i, el) {
			        var $tds = $(this).find('td')
			        var chargeCodeId=  $($tds).closest('tr').find("td:eq(3)").find("input:eq(0)").attr("id");
			        var chargeCodeIdValue=$('#'+chargeCodeId).val();
			        var idddd =$(item).closest('tr').find("td:eq(3)").find("input:eq(0)").attr("id");
			        var currentidddd=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
			    	  if(chargeCodeId!=checkCurrentRowIddd && ChargeCode==chargeCodeIdValue)
			          {
			    		  	if(ChargeCode==chargeCodeIdValue){
			       			alert("Investigation is already added");
			        		$('#'+idddd).val("");
			        		$('#'+currentidddd).val("");
			        		$('#'+chargeCodeIdValue).val("");
			        		return false;
			           }
			          			        
			            }
			            else
			        	{
			            	
			        	   $(item).closest('tr').find("td:eq(3)").find(":input").val(ChargeCode);
			        	}
			       
			    }); 
		      }
		  }
	  }		
	        
	        var i=0;
	        function addInvetigationRow() {

	    	    i++
	    	    var aClone = $('#grid>tr:last').clone(true)
	    		aClone.find(":input").val("");
	    	    aClone.find('input[type="text"]').prop('id', 'chargeCodeNameTemplate'+i+'');
	    	    aClone.find("td:eq(3)").find(":input").prop('id', 'InvestigationIdTemplate'+i+'');
	    	    aClone.find('input[type="text"]').removeAttr('disabled');
	    	    aClone.clone(true).appendTo('#grid');
	    		var valInvestigation = $('#grid>tr:last').find("td:eq(0)").find(":input")[0];
	    		
	    		if(arryInvestigation!=null && arryInvestigation!="" )
	    		{
	    		arrayData=[];	
	    		oldautocomplete(valInvestigation, arryInvestigation);
	    		}
	    		else
	    		{
	    		arryInvestigation=[];	
	    		oldautocomplete(valInvestigation, arrayData);
	    		}
	    		
	    		
	    		    		    		
	    		  var tbl = document.getElementById('grid');
	       	      lastRow = tbl.rows.length;
	       	   $('#grid>tr:last').find("td:eq(2)").find("button:eq(0)").attr("id","newIdInv");	
	        }
	        
 function removeRowInvestigation(val){
	        	
	        	if($('#grid tr').length > 1) {
	        		
	        		var investigationId=$(val).closest('tr').find("td:eq(4)").find("input:eq(0)").val();
	        		
	        		alert("investigationId "+investigationId)
	        		var pathname = window.location.pathname;
	        		var accessGroup = "MMUWeb";
	        		var url = window.location.protocol + "//"
	        		+ window.location.host + "/" + accessGroup
	        		+ "/opd/opdDeleteInvestigationTemplate";
	        		
	        		$
	        				.ajax({
	        					url : url,
	        					dataType : "json",
	        					data : JSON.stringify({
	        						'templateInvestigationId' : investigationId
	        					}),
	        					contentType : "application/json",
	        					type : "POST",
	        					success : function(response) {
	        						
	        						 $(val).closest('tr').remove()
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
</script>

<script type="text/javascript" language="javascript">


 $('#addbutton').click(function() {
	 
	var templateHeaderId=$('#updateInvestigationTemplateId').val()
	var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";

		var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/opd/updateOpdInvestigationTemplates";

        if(document.getElementById('invTemplateName').value == "") {
    		 alert("Please enter a Template Name");
     		 document.getElementById('templateName').focus(); 
     		 return false;
   		}
		
		/////////////////////// treatment validation part ////////////////////////////
    	
    	  $('#grid tr').each(function(i, el) {
       	     
    		var $tds = $(this).find('td')
       	    var InvestigationName = $tds.eq(0).find(":input").val();
       	    var itemIdCheck = $tds.eq(3).find(":input").val();
       	    
       	    //alert("item id "+itemIdCheck)
       	 if(itemIdCheck== "")
    	 {
        		alert("Please enter valid Investigation name");
        		itemIdCheck.focus();
      		    return false;       	
    	 }
       	if(InvestigationName== "")
  	    {
      		alert("Please Enter Dosage");
      		InvestigationName.focus();
     		return false;      	
  		}
      
         });
         
		
		var arry = [];  
    	var dataInvestigation='';
    	var idforInvestigation='';
	$('#grid tr').each(function(i, el) {
		idforInvestigation= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
	if(document.getElementById(idforInvestigation).value!= '' && document.getElementById(idforInvestigation).value != undefined)
    {
	var $tds = $(this).find('td')
	var itemIdInvestigation = $tds.eq(3).find(":input").val();
	var newInvCheck = $tds.eq(5).find(":input").val();
 	if(newInvCheck!="old")
 	{	
		    if(itemIdInvestigation!=null && itemIdInvestigation!="")
			{	
			dataInvestigation={
					'investigationId' : itemIdInvestigation,
					}
			arry.push(dataInvestigation)
		     }
		    }
    }	
  });	
		
	 var dataJSON = {
			 'templateCode' : templateCode,
			 'templateName' : $('#invTemplateName').val(),
			 'templateId' : $('#invTemplateId').val(),
			 'templateType' : "I",
			 'doctorId' : <%=userId%>,
			 'hospitalId' : <%=hospitalId%>,
			 'templateId':templateHeaderId,
			 "listofInvestigationTemplate" : arry
			 }
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
		   alert("Investigation Template Details Update successfully"+"S");
		   var pathname = window.location.pathname;
			var accessGroup = "MMUWeb";
			var urlUpdate = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/opd/opdUpdateInvestigationTemplate";
		   $('#exampleModal .modal-body').load(urlUpdate+"?employeeId="+<%= userId %>);
           $('#exampleModal .modal-title').text('Update Investigation Template');
	   }
	 else if(msg.status == 0)
	   {
		 alert(msg.msg)	 
	   }
		
	  else
	  {
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
	  
 function deleteFullTemplate() {
		var tbl = document.getElementById('grid');
		var lastRow = tbl.rows.length;
		
		var msg=resourceJSON.msgDelete;
		
		if (confirm(msg)) {
			//if (investigationGrid == "grid" && lastRow == '1') {
				//$("#messageDelete").show();
				//return false;
			//}
			$(val).closest('tr').remove();
			var templateId=$("#invTemplateId").val();
			var flag = 0;
			if (templateId != null	&& templateId != "") {
					flag = 'i1005';
					deleteTemplateFull(flag, templateId, "", "", "");
				}
			
		}
	}
 
 function deleteTemplateFull(flag, valueForDelete, visitId, opdPatientDetailId,
			patientId) {
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
			url : "/MMUWeb/opd/deleteGridRow",
			data : JSON.stringify(data),
			dataType : "json",
			cache : false,
			success : function(res) {
				   alert("Delete Investigation Template Details successfully"+"S");
				   var pathname = window.location.pathname;
					var accessGroup = "MMUWeb";
					var urlUpdate = window.location.protocol + "//"
					+ window.location.host + "/" + accessGroup
					+ "/opd/opdUpdateInvestigationTemplate";
				   $('#exampleModal .modal-body').load(urlUpdate+"?employeeId="+<%= userId %>);
	               $('#exampleModal .modal-title').text('Update Investigation Template');
			}
		});

		//return "1";
	}
 
 
 
 function removeTemplateVal(val, investigationGrid, investigationData) {
		var tbl = document.getElementById('grid');
		var lastRow = tbl.rows.length;
		
		if($('#grid tr').length > 1) {
			
		
		var msg=resourceJSON.msgDelete;
		
		if (confirm(msg)) {
			//if (investigationGrid == "grid" && lastRow == '1') {
				//$("#messageDelete").show();
				//return false;
			//}
			$(val).closest('tr').remove();
			var flag = 0;
			if ((val.id != "newIdInv" && investigationGrid == "grid")) {
				if (investigationGrid == "grid"
						&& investigationData != "") {
					flag = 701;
					deleteInvestigatRow(flag, investigationData, "", "", "");
				}
			}
		}
		 }
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
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "/MMUWeb/opd/deleteGridRow",
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
				
				
				return "2";
			}
		});

		//return "1";
	}
	
 </script>

</body>
</html>
