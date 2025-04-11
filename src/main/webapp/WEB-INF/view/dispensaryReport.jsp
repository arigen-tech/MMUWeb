<%@page import="java.util.HashMap"%>
    <%@page import="java.util.Map"%>
    <%@ page import="com.mmu.web.utils.ProjectUtils"%>
        <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

          
              <%@include file="..//view/leftMenu.jsp" %>

                <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                    <html>

                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
                        <%@include file="..//view/commonJavaScript.jsp" %>
                            <title>Dispensary Reports</title>
                    
                    
                   
                    </head>
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

	
%>
	
	<script type="text/javascript" language="javascript">
	
	function getPatientId() {
      
		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		/* var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/v0.1/opd/getTemplateName"; */
		
		var empNo=document.getElementById('employeeNo').value;
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
						var trHTML = '<option value=""><strong>Select...</strong></option>';
						 for (var i = 0; i < datas.length; i++) {
                             var patientId = datas[i].patientId;
                             var patientName = datas[i].patinetName;
                            
                             var a = patientName + "[" + patientId + "]"
                             trHTML += '<option value="' + patientId + '" >'
								+ a + '</option>';
                            
                         }
						
						$('#patientName').html(trHTML);
					}
				    else
					{
				      if(empNo!=null && empNo!="")
				      {
					  alert("No Record Found");	
				      }
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
	
	$(document).delegate("#patientName","change",
	function() {
		var pId = $('#patientName').val();
		if(pId == undefined || pId == ''){
			$('#visitDetails').empty();
			return;
		}
		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/dispencery/getVisitListAndPrescriptionId";
		
		$.ajax({
					url : url,
					dataType : "json",
					data : JSON.stringify({
						'employeeId' : '1',
						'patientId':$('#patientName').val()
					}),
					contentType : "application/json",
					type : "POST",
					success : function(response) {
						console.log(response);
					   if (response.status == 1) {
						var datas = response.data;
						var trHTML = '<option value=""><strong>Select...</strong></option>';
						 for (var i = 0; i < datas.length; i++) {
                            var visitId = datas[i].visitNo;
                            var visitDate = datas[i].visitDate;
                            var deptName = datas[i].departmentNo;
                            var prescriptionId = datas[i].prescriptionId;
                            var a = visitId + "[" + visitDate + "]" + "[" + deptName + "]"
                            trHTML += '<option value="' + prescriptionId + '" >'
								+ a + '</option>';                           
                        }
						
						$('#visitDetails').html(trHTML);

					}
					   else
						{
						  $('#visitDetails').empty();
						  alert("No Record Found")
						 
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
	
	$(document).delegate("#visitDetails","change",
	function() {
        
		var visitIdVal=$('#visitDetails').val()
		
		document.getElementById('visit_id').value =visitIdVal; 
	

	});

	function printReport(flag) {
		var pId = "";
		 if(document.getElementById('visit_id').value == "")
		 {
		   alert("Please enter and select above details");
		   return;
		  }
		 else{
			// pId = $('#visit_id').val();
			 pId = $('#visitDetails').find('option:selected').val();
			 if(flag=='P')
				document.frm.action="${pageContext.request.contextPath}/report/printissuedPrescriptionReport?id="+pId+"";
			 if(flag=='N')
				document.frm.action="${pageContext.request.contextPath}/report/printNisSlip?id="+pId+"";
				document.frm.method="POST";
				document.frm.submit(); 
			 }
		
		
	}	
	
	function makeUrl(){
		
		var pId = "";
		if(document.getElementById('visit_id').value == "")
		 {
		   alert("Please enter and select above details");
		   return;
		 }else{
			 pId = $('#visitDetails').find('option:selected').val();
			 
		 }
		var url = "${pageContext.request.contextPath}/report/printissuedPrescriptionReport?id="+pId+"";
		openPdfModel(url);
	}
	
	function makeUrl2(){

		var pId = "";
		if(document.getElementById('visit_id').value == "")
		 {
		   alert("Please enter and select above details");
		   return;
		 }else{
			 pId = $('#visitDetails').find('option:selected').val();
			 
		 }
		var url = "${pageContext.request.contextPath}/report/printNisSlip?id="+pId+"";
		openPdfModel(url);
	}

function validateData()
{
	 if(document.getElementById('visit_id').value == "")
	 {
	   if(document.getElementById('employeeNo').value == "")
	   {
	   alert("Please enter service no.")
	   return false;
	   }
	   if(document.getElementById('patientName').value == "")
		{
		   alert("Please select patient name")
    	   return false; 
		}
	   if(document.getElementById('visitDetails').value == "")
		   {
		   alert("Please select visit no.")
   	       return false; 
		   }
	   
	 }  	
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

	</script>
	
	 <!-- Begin page -->
    <div id="wrapper">
	<div class="content-page">
		<!-- Start content -->
		<div class="">
			<div class="container-fluid">

				<div class="internal_Htext">Dispensary Reports</div>
			 
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body"> 
								<form name="frm" >
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
                                                     <select name="patient_name" id="patientName" type="text" class="form-control border-input" placeholder="Employee No." value=""></select>
                                                 </div>
                                             </div>
										</div> 
										
										
									  <div class="col-md-4"> 
										 <div class="form-group row">
                                                 <label class="col-sm-5 col-form-label">Visit No. For Prescription</label>
                                                 <div class="col-sm-7">
                                                     <select name="visitDetails" id="visitDetails" type="text" class="form-control border-input" placeholder="Employee No." value=""></select>
                                                 </div>
                                             </div>
	                                 </div> 
							 </div>
										
									
                    <div class="row">
                        <div class="col-12">
                         
                                
                               
                                     <div class="row">
										
												<!-- <button class=" btn btn-primary opd_submit_btn" onclick="printReport('C');">Case Sheet</button> 
												 <button class="btn btn-primary opd_submit_btn" onclick="printReport('I');">Investigation Slip</button> 
												 <button class="btn btn-primary opd_submit_btn" onclick="printReport('P');">Prescription Slip</button>  -->
									
										
										<!-- <div class="col-md-2"> 
												 <button class="btn btn-primary opd_submit_btn" onclick="printReport('R');">Referral Letter</button> 
										</div> -->
										
                                    </div>
                              
                            </div>
                            <!-- end card -->
                        </div>
                        <!-- end col -->
                    
									
									
									<div class="row"> 
										 <div class="col-md-12 m-t-10 clearfix">
												
															<div class="btn-right-all">
																<!-- <input type="button" class="btn btn-primary opd_submit_btn" value="Prescription Report" onclick="printReport('P');"> -->

																<button class="btn btn-primary" type="button" name="btnReport" id="btnReport" 
																  onClick="makeUrl()">Prescription Report</button>	

																<button class="btn btn-primary" type="button" name="btnReport" id="btnReport" 
																 onClick="makeUrl2()">NIS Report</button>

															</div>														
															
													   </div>
												  </div>
									
									
									
									    <div class="row">   
												  <div class="col-md-4">																  
												 </div> 
												 <div class="col-md-4">
														<div class="form-group">
															<input type="hidden" id="visit_id" name="visit_id"
																value=""/>
														</div>
											   </div>
									  </div>
								</form>
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