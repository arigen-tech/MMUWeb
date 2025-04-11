<%@page import="java.util.HashMap"%>
      <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


                <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                    <html>

                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
                     
                            <title>OPD Medical Advice Template</title>
                    	
                   <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
                   <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opd.js"></script>
                   
				                 
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
																 <label class="col-sm-5" style="background:none;">Template Name<span class="mandate"><sup>*</sup></span> </label>
																  <div class="col-sm-7">  
																      <input type="text" class="form-control" name=" " id="templateNameTreatment" value=""
																		onblur="createTemplateCode();" validate="Template Name,metachar,yes"
																		MAXLENGTH="30" tabindex=1 /> 
                                                                    </div>
																 </div>
																</div>
																
																
																 <div class="col-md-6">
																  
																</div>
																
																
													 </div>
				
				

		<div class="clear"></div>
		<div id="testDiv">
			<div class="form-group row">
																		<label class="col-md-4 col-form-label" style="  padding-left: 10px;"> <b>Recommended Medical Advice </b></label>
																		<div class="col-md-12">
																			 <textarea name="additionalNoteTreatment"   class="form-control"
																				validate="referralNote,string,no" id="additionalNoteTreatment"
																				cols="0" rows="0" maxlength="500" tabindex="5"></textarea>
																		</div>
																	</div>
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




<script type="text/javascript" language="javascript">


 $('#addbutton').click(function() {
	 
	
	 var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";

		var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/opd/saveOpdMedicalAdviceTemplates";

        if(document.getElementById('templateNameTreatment').value == "") {
    		 alert("Please enter a Template Name");
     		 document.getElementById('templateName').focus(); 
     		 return false;
   		}
		
		
        var dataJSON = {
			 'templateCode' : templateCode,
			 'templateName' : $('#templateNameTreatment').val(),
			 'templateType' : "A",
			 'doctorId' : <%=userId%>,
			 'hospitalId' : <%=hospitalId%>,
			 'medicalAdice' : $('#additionalNoteTreatment').val()
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
		   alert("Medical Advice Template Details Inserted successfully");
		   $('#exampleModal .modal-body').load("createMedicalAdviceTemplate?employeeId="+<%= userId %>);
           $('#exampleModal .modal-title').text('Medical Advice Template');
		  
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
	  
 
 </script>
  
</body>
</html>
