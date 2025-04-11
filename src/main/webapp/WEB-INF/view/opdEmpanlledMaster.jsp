<%@page import="java.util.HashMap"%>
    <%@page import="java.util.Map"%>
    <%@ page import="com.mmu.web.utils.ProjectUtils"%>
        <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


                <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                    <html>

                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
                    
                            <title>OPD Main</title>
                      
               
                
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
	if (session.getAttribute("mmuId") != null) {
		hospitalId = session.getAttribute("mmuId") + "";
	}
	String userId = "1";
	if (session.getAttribute("userId") != null) {
		userId = session.getAttribute("userId") + "";
	}
	
	String cityId = "1";
	if (session.getAttribute("cityId") != null) {
		cityId = session.getAttribute("cityId") + "";
	}
%>

<!-- <div class="container-fluid">
<div class="popupbg"> -->

	<!-- <h4></h4>
	<div class="titleBg">
		<div class="internal_Htext">Empanelled Hospital Masters</div>
	</div> -->
	<!-- <div class="modal-header">
	  <h5 class="modal-title font-weight-bold">Empanelled Hospital Masters</h5>
	  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	    <span aria-hidden="true">&times;</span>
	  </button>
	</div>
	
 <div class="modal-body"> -->
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
	window.opener.getEmpanelledHospital();
	window.close();
  
}


	</script>

	
	<form name="empanelledTemplate" autocomplete="off" method="post" action="">

		<input type="hidden" name=" " value="OpdTemplate" /> <input
			type="hidden" name=" " value="TemplateName" /> <input type="hidden"
			name="title" value="OpdTemplate" /> <input type="hidden" name=" "
			value="opdTemplate" /> <input type="hidden" name="hiddenValueCharge"
			id="hiddenValueCharge" /> <input type="hidden"
			name="pojoPropertyCode" value="TemplateCode" />
			<input type="hidden"  name="cityId" value=<%= session.getAttribute("cityId") %> id="cityId" />
			<input type="hidden"  name="hospitalId" value=<%= session.getAttribute("mmuId") %> id="hospitalId" />
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
											
												<th scope="col">Name<span>*</span></th>
												<th scope="col">Address<span>*</span></th>
												<!-- <th scope="col">Stock</th> -->

												<th>Add</th>
												<th>Delete</th>

											</tr>
											<tbody id="empanlledMasGrid">
												<tr>
												
													<td><input type="text" name="empanlledHospital" tabindex="1"
														id="empanlledHospital"	size="5" class="form-control" />
													</td>
													
													<td><input type="text" name="empanlledHospitalAddress" tabindex="1"
														id="empanlledHospitalAddress"	size="5" class="form-control" />
													</td>
                                                   
                                                    <td style="display: none;"><input type="hidden"
														value="" tabindex="1" id="itemIdNom" size="77"
														name="itemIdNom" /></td>
													<td>

														<button type="button" class="btn btn-primary buttonAdd noMinWidth"
															name="button" button-type="add" value=""
															onclick="addEmpanlledMasRow();" tabindex="1"></button>

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
		<button type="button" name="add" id="empanlledSavebutton" value=""
			class="button btn btn-primary"  onClick="submitWindow();" accesskey="a" tabindex=1>Save</button>
		<button type="reset" name="Reset" id="reset" value=""
			class="button btn btn-primary" onclick="resetCheck();" accesskey="r">Reset</button>
			 <button	type="reset" name="Reset" id="reset" value="" class="button btn btn-danger"
			data-dismiss="modal" accesskey="r" /u>Close</button>
</div>
		
		<div class="Clear"></div>
		<div class="division"></div>
	                                        
		
		 
	</form>


<!--  </div> -->
<!-- </div> -->

<script type="text/javascript" language="javascript">


 $('#empanlledSavebutton').click(function() {
	 var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";

		var url = window.location.protocol + "//"
				+ window.location.host + "/" + accessGroup
				+ "/opd/saveEmpanlledHospitalMasters";
     
		
	 	var checkEmp=[];
		$('#empanlledMasGrid tr').each(function(i, el) {
			var $tds = $(this).find('td')
			var empName = $tds.eq(0).find(":input").val();
			var empAdd = $tds.eq(1).find(":input").val();
			if(empName=="") {
	            alert("Please enter a Empanelled Hospital Name");
	            empName.focus(); 
	            return false;
	          }	
			if(empAdd=="") {
	            alert("Please enter a Empanelled Hospital Address");
	            empAdd.focus(); 
	            return false;
	          }	
	       checkEmp.push(empName.trim());
		});	
		
		checkEmp.sort();
		
		//var last = checkEmp[0];
		for (var i=0; i<checkEmp.length; i++) {
			//alert("inside i loop");
			for(var j=i+1;j<checkEmp.length;j++){
				/* alert("inside j loop");
				alert("value1 "+checkEmp[i] + " value2 "+checkEmp[j]); */
				if(checkEmp[i] == checkEmp[j]){
					alert('Duplicate Value : '+checkEmp[i]);
					return false;
				}
			}
		  /*  if (checkEmp[i] == last) alert('Duplicate Value : '+last);
		   last = checkEmp[i]; */
		  // return false;
		}
		
		var tableDataEmpanlledHospital = [];  
    	var dataEmpanlledHospital='';
    	var idforTreat='';
    	
	$('#empanlledMasGrid tr').each(function(i, el) {
	
	var $tds = $(this).find('td')
  	var empaHospitalName = $tds.eq(0).find(":input").val();
	var empaHospitalCode = $tds.eq(1).find(":input").val();
	
	dataEmpanlledHospital={
			'empanlledName' : empaHospitalName,
			'empanlleAddress' : empaHospitalCode,
			}
	tableDataEmpanlledHospital.push(dataEmpanlledHospital)
    
  });	
    var cityIdValue=$('#cityId').val();		
	 var dataJSON = {
	 'status':'Y',
	 'doctorId' : <%=userId%>,
	 'hospitalId' : hsId,
	 'cityId':cityIdValue,
	 "listofEmpanlledHospital" : tableDataEmpanlledHospital
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
		   alert("Empanelled Hospital Insert successfully");
		   getEmpanelledHospital();
		   
		   $j('#smallModal .modal-body').empty();		   
		   $('#smallModal .modal-body').load("opdEmpanlledMaster?employeeId="+<%= userId %>);
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

 var i=0;
 function addEmpanlledMasRow() {
     i++;
 	var aClone = $('#empanlledMasGrid>tr:last').clone(true)
 	aClone.find(":input").val("");
 	aClone.find('input[type="text"]').prop('id', 'nomenclature1'+i+'');
 	aClone.find("td:eq(8)").find(":input").prop('id', 'itemIdNom'+i+'');
 	aClone.find("option[selected]").removeAttr("selected")
 	aClone.clone(true).appendTo('#empanlledMasGrid');
  	
 }
 
 function removePreocedureMas(val){
		
		if($('#empanlledMasGrid tr').length > 1) {
			   $(val).closest('tr').remove()
			 }

	}
 
 </script>
 
</body>
</html>
