<%@page import="java.util.HashMap"%>
    <%@page import="java.util.Map"%>
    <%@ page import="com.mmu.web.utils.ProjectUtils"%>
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
	Map<String, Object> map = new HashMap<String, Object>();
	if (request.getAttribute("map") != null) {
		map = (Map) request.getAttribute("map");
	}
	Map<String, Object> utilMap = new HashMap<String, Object>();
	utilMap = (Map) ProjectUtils.getCurrentDateAndTime();
	String date = (String) utilMap.get("currentDate");
	String time = (String) utilMap.get("currentTime");

	String userName = "";
	if (session.getAttribute("userName") != null) {
		userName = (String) session.getAttribute("userName");
	}
	String message = "";
	if (map.get("message") != null) {
		message = (String) map.get("message");
		//out.println(message);
	}
	System.out.println("message==in jsp ===" + message);

	
%>

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
																 <label class="col-sm-5" style="background:none;">Template Name<span class="mandate"><sup>*</sup></span> </label>
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
		<div id="testDiv">
			<table class="table table-striped table-hover" align="center" cellpadding="0" cellspacing="0">
			<tr style="border: none;">
					<td colspan="3" style="background: #fff; border: none;">
						<div>
							<div class="form-check form-check-inline cusRadio">
								<input type="radio" onchange="changeRadio(this.value)" checked="checked" name="labradiologyCheck" class="radioCheckCol2 form-check-input" value="" id="lab_radioTemp">
								<span class="cus-radiobtn"></span> 
								<label class="form-check-label" for="lab_radioTemp">Lab</label>
							</div>
							
							<div class="form-check form-check-inline cusRadio">
								<input type="radio" onchange="changeRadio(this.value)" name="labradiologyCheck" class="radioCheckCol2 form-check-input" value="" id="imag_radioTemp">
								<span class="cus-radiobtn"></span> 
								<label class="form-check-label" for="imag_radioTemp">Imaging</label>
							</div>
							
								<!-- <input type="radio" onchange="changeRadio(this.value)" checked="checked" name="labradiologyCheck" class="radioCheckCol2" value="2"> Lab 
								<input type="radio" onchange="changeRadio(this.value)" name="labradiologyCheck" class="radioCheckCol2" value="1"> Imaging  -->
								<input type="hidden" id="investigationCategory" name="investigationCategory" value="Lab">
							
						</div>

					</td>
				</tr>								
											<tr id="th">
												<th  style="width:70%;">Investigation</th>
												<th>Add</th>
												<th>Delete</th>

											</tr>
											<tbody style="border: 1px solid #dee2e6;" id="grid">
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

														<button type="button" class="btn btn-primary buttonAdd noMinWidth"
															name="button" button-type="add" value=""
															onclick="addInvetigationRow()" tabindex="1"></button>

													</td>
													<td>


														<button type="button" class="buttonDel  btn btn-danger noMinWidth"
															name="button" button-type="delete" value=""
															onclick="removeRowInvestigation(this);""
															tabindex="1"></button>

													</td>
													<td style="display: none;"><input type="hidden"
														value="" tabindex="1" id="InvestigationIdTemplate" size="77"
														name="InvestigationIdTemplate" />
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
			class="button btn btn-primary"  onClick="submitWindow();" accesskey="a" tabindex=1>Save</button>
		<button type="reset" name="Reset" id="reset" value=""
			class="button btn btn-primary" accesskey="r">Reset</button>
			 <button	type="reset" name="Reset" id="reset" value="" class="button btn btn-danger"
			data-dismiss="modal" accesskey="r" /u>Close</button>
</div>
		
		<div class="Clear"></div>
		<div class="division"></div>
	                                        
		
		 
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
	        	
	        }
	        
	        function removeRowInvestigation(val){
	        	
	        	if($('#grid tr').length > 1) {
	        		   $(val).closest('tr').remove()
	        		 }

	        }
</script>

<script type="text/javascript" language="javascript">


 $('#addbutton').click(function() {
	 
	
	 var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";

		var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/opd/saveOpdInvestigationTemplates";

        if(document.getElementById('templateName').value == "") {
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
		
	dataInvestigation={
			'investigationId' : itemIdInvestigation,
			}
	arry.push(dataInvestigation)
    }
  });	
		
	 var dataJSON = {
			 'templateCode' : templateCode,
			 'templateName' : $('#templateName').val(),
			 'templateType' : "I",
			 'doctorId' : <%=userId%>,
			 'hospitalId' : <%=hospitalId%>,
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
		   alert("MB Investigation Template Details Inserted successfully"+"S");
		   showInvestiDataTemplate111();
		   $j('#exampleModal .modal-body').empty();		   
		   $('#exampleModal .modal-body').load("showCreateInvestigationTemplate?employeeId="+<%= userId %>);
		  
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
	  
 function showInvestiDataTemplate111() {
	 getTemplateDetail111();
	}
 </script>
  
</body>
</html>
