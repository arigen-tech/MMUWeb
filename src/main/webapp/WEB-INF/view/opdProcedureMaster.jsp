<%@page import="java.util.HashMap"%>
    <%@page import="java.util.Map"%>
    <%@ page import="com.mmu.web.utils.ProjectUtils"%>
        <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

          
        <%--   <%@include file="..//view/leftMenu.jsp" %> --%>

                <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                    <html>

                    <head>
                   <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
                    
                   <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
     
                   
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

	/* int deptId = 0;
	if(session.getAttribute("deptId") != null){
		deptId = (Integer)session.getAttribute("deptId");
	}
	String deptName="";
	if(session.getAttribute("deptName") != null){
		deptName = (String)session.getAttribute("deptName");
	}
	List<MasFrequency> frequencyList= new ArrayList<MasFrequency>();
	if(map.get("masFrequencyList") != null){
	frequencyList=(List)map.get("masFrequencyList");
	
	}
	List<OpdInstructionTreatment>opdInstructionTreatmentList=new ArrayList<OpdInstructionTreatment>();
	if(map.get("opdInstructionTreatmentList")!=null){
		opdInstructionTreatmentList=(List<OpdInstructionTreatment>)map.get("opdInstructionTreatmentList");
	} */
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
	String radioValue=request.getParameter("radioValue");
	
%>

	
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


	</script>

	
	<form name="treatmentTemplate" autocomplete="off" method="post" action="">

		<input type="hidden" name=" " value="OpdTemplate" /> <input
			type="hidden" name=" " value="TemplateName" /> <input type="hidden"
			name="title" value="OpdTemplate" /> <input type="hidden" name=" "
			value="opdTemplate" /> <input type="hidden" name="hiddenValueCharge"
			id="hiddenValueCharge" /> <input type="hidden"
			name="pojoPropertyCode" value="TemplateCode" />
			 <input type="hidden" id="pType" name="pType" name="title" value="<%=radioValue%>" />
<div class="clear" style="margin-top:8px;"></div>
    
			<!--  <label>Template Code </label>-->

			<input type="hidden" name="code" id="code" value="" disabled="true"
				readonly="readonly" validate="Template Code,metachar,yes"
				MAXLENGTH="8" tabindex=1 />
				
			
				

		<div class="clear"></div>
		<div class="paddingTop15"></div>
		<div id="testDiv">
			<table class="table table-striped table-hover table-bordered" align="center"
											cellpadding="0" cellspacing="0">
											<tr>
												
												<th scope="col">Procedure Type<span>*</span></th>
												<th scope="col">Name<span>*</span></th>
												<!-- <th scope="col">Stock</th> -->

												<th>Add</th>
												<th>Delete</th>

											</tr>
											<tbody id="procedureMasGrid">
												<tr>

												

													<td><select name="procedureTypes" id="procedureTypes" onchange="fillValueNomenclature()"
														class="form-control width200">
													 
                                                       <option value="N">Nursing Care</option>
  														<option value="P">Physiotherapy </option>
 														 <option value="M">Minor Surgery</option>
                										</select></td>

													<td><input type="text" name="procedureName" tabindex="1"
														id="procedureName" onblur="fillValueNomenclature()"
														size="5" class="form-control width330" /></td>
                                                   
                                                    <td style="display: none;"><input type="hidden"
														value="" tabindex="1" id="itemIdNom" size="77"
														name="itemIdNom" /></td>
													<td>

														<button type="button" class="btn btn-primary buttonAdd noMinWidth"
															name="button" button-type="add" value=""
															onclick="addPreocedureMasRow();" tabindex="1"></button>

													</td>
													<td>


														<button type="button" class="buttonDel  btn btn-danger noMinWidth"
															name="button" button-type="delete" value=""
															onclick="removePreocedureMas(this);""
															tabindex="1"></button>

													</td>
													<td style="display: none;"><input type="hidden"
														name="pvmsNo1" tabindex="1" id="pvmsNo1" size="10"
														readonly="readonly" /></td>
												</tr>

											</tbody>
											
										</table> 
			<div class="Clear"></div>
		</div>


		<div class="Clear"></div>
		<div class="division"></div>
<div style="float:right;">
		<button type="button" name="add" id="proecdureSavebutton" value=""
			class="button btn btn-primary"  onClick="submitWindow();" accesskey="a" tabindex=1>Save</button>
		<button type="reset" name="Reset" id="reset" value=""
			class="button btn btn-primary" onclick="resetCheck();" accesskey="r">Reset</button>
			 <button	type="reset" name="Reset" id="reset" value="" class="button btn btn-danger"
			data-dismiss="modal"  accesskey="r" /u>Close</button>
</div>
		
		<div class="Clear"></div>
		<div class="division"></div>
	                                        
		
		 
	</form>


<script type="text/javascript" language="javascript">


 $('#proecdureSavebutton').click(function() {
	 
	
	 var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";

		var url = window.location.protocol + "//"
				+ window.location.host + "/" + accessGroup
				+ "/opd/savePreocdureMasters";
     
		if(document.getElementById('procedureName').value == "") {
            alert("Please enter a Procedure Name");
            document.getElementById('procedureName').focus(); 
            return false;
          }	

		
		var tableDataProcedure = [];  
    	var dataProcedure='';
    	var idforTreat='';
	$('#procedureMasGrid tr').each(function(i, el) {
	
	var $tds = $(this).find('td')
  	var procedureTypes = $tds.eq(0).find(":input").val();
	//var splitProcedure=procedureTypes.split("@");
	var procedureName = $tds.eq(1).find(":input").val();
	var procedureCode = $tds.eq(2).find(":input").val();

	dataProcedure={
			'procedureTypes' : procedureTypes,
			'procedureName' : procedureName,
			'procedureCode' : procedureCode,
		}
	tableDataProcedure.push(dataProcedure)
    
  });	
		
	 var dataJSON = {
	 'defaultStatus' :'Y',
	 'status':'Y',
	 'doctorId' : <%=userId%>,
	 'hospitalId' : <%=hospitalId%>,
	 "listofProcedureMaster" : tableDataProcedure
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
		   alert("Procedure Data Inserted successfully");
		   //var pValue=document.getElementById("pType").value;
		   //showProcedureMaster(pValue);
		   $j('#smallModal .modal-body').empty();		   
		   $j('#smallModal .modal-body').load("createProcedureMasters?employeeId="+<%= userId %>);
		   
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

 var i=0;
 function addPreocedureMasRow() {
     i++;
 	var aClone = $('#procedureMasGrid>tr:last').clone(true)
 	aClone.find(":input").val("");
 	aClone.find('input[type="text"]').prop('id', 'nomenclature1'+i+'');
 	aClone.find("td:eq(8)").find(":input").prop('id', 'itemIdNom'+i+'');
 	aClone.find("option[selected]").removeAttr("selected")
 	aClone.clone(true).appendTo('#procedureMasGrid');
  	
 }
 
 function removePreocedureMas(val){
		
		if($('#procedureMasGrid tr').length > 1) {
			   $(val).closest('tr').remove()
			 }

	}
<%--  var procedureType= <%=radioValue%>;
 document.getElementById('pType').value =procedureType; --%>
 </script>
 
</body>
</html>
