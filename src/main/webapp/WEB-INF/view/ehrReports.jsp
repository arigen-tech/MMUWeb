<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page import="com.mmu.web.utils.ProjectUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@include file="..//view/leftMenu.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp" %>
	<title>OPD Reports</title>
       <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newOpd.js"></script>
</head>
                    
    <div class="modal hide z-index5000" id="messageForAuthenticate" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<span class="Message_htext"><spring:message code="lblIndianCoastGuard" /></span>

				<button type="button" onClick="closeMessage();" class="close"
					data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>

			</div>
			<div class="modal-body">
				<div class="control-group">
					
						<div class='divErrorMsg form-group row' id='errordiv' ></div>
				<div class="form-group row" id="messageForAuthenticateMessae" class="text-danger" ></div>
				<div class="form-group row" id="messageForAuthenticateServiceNo" class="text-danger" ></div>
				
					<div class="col-md-12">
							<div class="form-group row">
								<label class="col-md-5 col-form-label"><spring:message code="lblUHIDNumber"/> 
								</label>
								<div class="col-md-7">
									<input name="uhidNumber" id="uhidNumber" type="text"
										class="form-control border-input"
										placeholder=""/>
								</div>
							</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary" data-dismiss="modal" id="printReportButton2" 
					onClick="callToAutheniticate();" aria-hidden="true"><spring:message code="btnOK"/></button> <!-- closeMessage(); -->
				<button class="btn btn-primary" data-dismiss="modal"
					onClick="closeMessage();" aria-hidden="true"><spring:message code="btnClsoe"/></button>
					
			</div>
		</div>
	</div>
</div>

<div class="modal-backdrop show" style="display:none;"></div>

<body>
                    
                    
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

	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	
	String hospitalId = "";
	if (session.getAttribute("hospital_id") != null) {
		hospitalId = session.getAttribute("hospital_id") + "";
	}
	
%>



	
<script>
	
$(document).ready(function() { 
	GetHospitalList(); 
	$("#uid").hide();
});

var unitName = "";
function GetHospitalList(){

	$.ajax({
		crossOrigin : true,
		method : "POST",
		crossDomain : true,
		url : "${pageContext.request.contextPath}/master/getAllHospital",
		data : JSON.stringify({
			"PN" : "0",
			"hospitalId" :<%=hospitalId%>}),
    	    contentType: "application/json; charset=utf-8",
    	    dataType: "json",
    	    success: function(result){
    	    	var combo = "";
    	    	for(var i=0;i<result.data.length;i++){
    	    		combo += '<option  value='+result.data[i].unitId+'>' +result.data[i].unitName+ '</option>';
    	    		unitName=result.data[i].unitName;
    	    	}
    	    	$('#unitId').append(combo);
    	    	if($('#unitId').find("option").length > 2){
    	    		$('#unitId').show(); 
    	    		$('#uid').hide();
        	    }

    	    	else{
    	    		$('#unitId').hide(); 
    	    		$('#uid').show();
    	    		$('#uid').val(unitName).attr('readonly','readonly');
    	    		//document.getElementById('unitId').value = <%=hospitalId%>; 
        	    	}
    	    }
    	});
}
	
	

	
	function getPatientId() {
      document.getElementById("patientName").options.length = 1; 
      var empNo=document.getElementById('employeeNo').value;
      if(empNo!=''){
    	var pathname = window.location.pathname;
  		var accessGroup = "MMUWeb";

  		var url=window.location.protocol + "//"
  		+ window.location.host + "/" + accessGroup
  		+ "/opd/getOpdReportsDetailsbyServiceNo";
  		
  		$.ajax({
  					url : url,
  					dataType : "json",
  					data : JSON.stringify({
  						'serviceNo' : empNo
  					}),
  					contentType : "application/json",
  					type : "POST",
  					success : function(response) {
  						if (response.status == 1) {
  						var datas = response.data;
  						var trHTML = "";
  						 for (var i = 0; i < datas.length; i++) {
                               var patientId = datas[i].patientId;
                               var patientName = datas[i].patinetName;
                               var patinetUHIDNo = datas[i].patinetUHIDNo;
                               var a = patientName + "[" + patientId + "]"
                               trHTML += '<option value="' + patientId +'~'+ patinetUHIDNo + '" >'
  								+ a + '</option>';
                           }
  						
  							$('#patientName').append(trHTML);
  								
  						}else if(response.status == 2){
  							
  								alert(response.msg);
  								
  						}else if(response.status == 0){
  							alert(response.msg);
  						}
  					},
  					error : function(msg) {
						alert("An error has occurred while contacting the server");
							}
  				});
      	}
	}
	

	
	$(document).delegate("#patientName","change", function() {
		var patientdata = $('#patientName').val().split("~");
		var patientId=patientdata[0];
		var patientUhidNo=patientdata[1];
		var userId=document.getElementById('user_id').value =<%=userId%>;
		document.getElementById('patient_id').value =patientId; 
				
		
	});

	function printReport() {
		if(document.getElementById('patient_id').value == "")
		 {
		   alert("Please select Patient");
		   return false;
	    }
		var patientIdValue=$('#patient_id').val();
		var userId=<%=userId%>;
		//$('#urlForReport').val("${pageContext.request.contextPath}/report/generateEHRReport?patientId="+patientIdValue+"&userId="+userId);
		var url="${pageContext.request.contextPath}/report/generateEHRReport?patientId="+patientIdValue+"&userId="+userId;
		openPdfModel(url);
		//document.frm.action="${pageContext.request.contextPath}/report/generateEHRReport";	
			
	}

<%-- 	function printReportUHID() {
		
		if(document.getElementById('patient_id').value == "")
		 {
		   alert("Please select Patient");
		   return false;
	    }
		
		var patientIdValue=$('#patient_id').val();
		var userId=<%=userId%>;
		var url="${pageContext.request.contextPath}/report/generateEHRReport?patientId="+patientIdValue+"&userId="+userId;
		openPdfModel(url);
	} --%>	

	 function callToAutheniticate(){
		
			$('#errordiv').empty("");
			var uhidNo;
			var patientIdWithUhid= $j('#patientName').find('option:selected').val().split("~");
			var patientId=patientIdWithUhid[0];
			var patientUhidNo = patientIdWithUhid[1];
			if($('#unitId').find("option").length > 2){
					uhidNo =patientUhidNo;
				}else{
					uhidNo=$('#uhidNumber').val();
				}	
			
			document.getElementById('uhidNoValue').value = uhidNo;
			var patientId = $j('#patientName').find('option:selected').val();
			if(uhidNo==""){
				$('#errordiv').append(""+resourceJSON.msgEnterUhidnumber);
				$('#errordiv').show();
				return false;
			}
			var params = {
					"uhidNo" : uhidNo,'patientId':patientId
			}
			$.ajax({
				type : "POST",
				contentType : "application/json",
				url : 'checkAuthenticateUser',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(response) {
					var data = response.data;
					$('#uhidNumberValue').val(data);
					
					if(data=="success"){
						$('#messageForAuthenticateMessae').html("");
						//autheniticateUHID1(uhidNo);
						printReport();
						closeMessage();
					}
					else{
						$('#messageForAuthenticateMessae').html(""+resourceJSON.msgValidEnterUhidnumber);
						
					}
					
					return ;
				}
			});
			
		}

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

function downloadEHR(){
	var employeeNo = $j('#employeeNo').val();
	var hospitalId = $j('#hospitalId').val();
	
	var patientIdWithUhid = $j('#patientName').find('option:selected').val().split("~");
	var patientId=patientIdWithUhid[0];
	
	
	
	if(employeeNo==''){
		alert("Service No can not be blank.");
		return false;
	}
	
	if(patientId=='0'){
		alert("Please select the patient.");
		return false;
	}
	 var params = {'serviceNo':employeeNo,'hospitalId': hospitalId,'patientId':patientId}
	 
	 $.ajax({
			type : "POST",
			contentType : "application/json",
			url : 'checkAuthenticateEHR',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(response) {
				var data = response.data;
				var status = response.status;
				//alert("status :: "+status);
				 if(status==1){
					 printReport();
				}
				else if(status==0){
					if($('#unitId').find("option").length > 2){
						callToAutheniticate();
					}else{
						showUHIDPopUp();
					}
				}else if(status==2){
					alert(response.msg);
					} 
			}
		});

}

function viewEHR(){
	var employeeNo = $j('#employeeNo').val();
	var hospitalId = $j('#hospitalId').val();
	var patientIdWithUhid = $j('#patientName').find('option:selected').val().split("~");
	var patientId=patientIdWithUhid[0];
	$j('#hiddenValueForViewEhrButton').val('y');
	var userId = <%= userId %>;
	
	if(employeeNo==''){
		alert("Service No can not be blank.");
		return false;
	}
	
	if(patientId=='0'){
		alert("Please select the patient.");
		return false;
	}
	var params = {'serviceNo':employeeNo,'hospitalId': hospitalId,'patientId':patientId}
	 
	 $.ajax({
			type : "POST",
			contentType : "application/json",
			url : 'checkAuthenticateEHR',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(response) {
				var data = response.data;
				var status = response.status;
				 if(status==1){
					 window.open("${pageContext.request.contextPath}/ehr/patientSummary?patientId="+patientId+"&userId="+userId+"");
				}
				else if(status==0){
					if($('#unitId').find("option").length > 2){
						callToAutheniticate();
					}else{
						showUHIDPopUp();
					}
					
				}else if(status==2){
					alert(response.msg);
					} 
			}
		});
	 
	 
	
	 
}


var uhidNumberValue="";
var checkForAuthen="";
function showUHIDPopUp() {
	
	 checkForAuthen =$("#checkForAuthenticationValue").val();
	 uhidNumberValue =$("#uhidNumberValue").val();
	 
				 $("#messageForAuthenticate").show();
				 $('.modal-backdrop').show();
	 
			 	
}

function closeMessage(){
	 $('#errordiv').empty("");
	 $('#uhidNumber').val("");

	$('#messageForAuthenticate').hide();
	$('.modal-backdrop').hide();
}
	</script>
	
	 <!-- Begin page -->
    <div id="wrapper">
	<div class="content-page">
		<!-- Start content -->
		<div class="">
			<div class="container-fluid">

				<div class="internal_Htext">EHR</div>

			 
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body"> 
								
								<input type="hidden" name="hospitalId" id="hospitalId" value="<%=hospitalId %>" />
								<input type="hidden"  name="checkForAuthenticationValue" value="" id="checkForAuthenticationValue" />
								<input type="hidden"  name="uhidNumberValue" value="" id="uhidNumberValue" />
								<input type="hidden"  name="uhidNoValue" id="uhidNoValue" />
									<div class="row">

                                        <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5 col-form-label">Service No. </label>
                                                            <div class="col-sm-7">
                                                                <input name="employee_no" id="employeeNo" type="text" class="form-control border-input" placeholder="Service No." value="" onblur="getPatientId()" />
                                                            </div>
                                                        </div>
                                          </div>
										<div class="col-md-4">
											<div class="form-group row">
                                                 <label class="col-sm-5 col-form-label">Patient Name </label>
               						             <div class="col-sm-7">
                                                     <select name="patient_name" id="patientName" type="text" class="form-control border-input">
                                                     <option value="0" selected="selected">Select</option>
                                                     </select>
                                                 </div>
                                             </div>
										</div> 
										
										 <div class="form-group row" id="unitDiv"  style="display:none">
                                                         <label class="col-md-5 col-form-label">Unit:<span class="mandate"><sup>&#9733;</sup></span></label>
                                                         <div class="col-md-7">
                                                             <select class="form-control" id="unitId" name="unitId">
                                                             </select>
                                                            <input type="text" class="auto  form-control" size="8"  name="uid" id ="uid"/>
                                                         </div>
                                                     </div>
                                                     
										<div class="col-md-4 text-right">
										    <button  class=" btn btn-primary opd_submit_btn" id="viewReportButtonEhr" onclick="viewEHR();">View EHR</button>
										    <button  class=" btn btn-primary opd_submit_btn" id="printReportButtonEhr" onclick="downloadEHR();">Download EHR</button> 
										</div>
									
										</div>
										
									
                    <div class="row">
                        
                       </div>
                        <!-- end col -->
                    </div>
								
									
                                                           
									
											<div class="col-md-4">
											<div class="form-group">
												<input type="hidden" id="patient_id" name="patientId"
													value=""/>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group">
												<input type="hidden" id="user_id" name="userId"
													value=""/>
											</div>
										</div>

							</div>

						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
	

</body>
</html>
 <%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
