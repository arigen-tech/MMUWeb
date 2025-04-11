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
                            <title>OPD Reports</title>
                    
                    
                   
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
 <%
 	String hospitalId = "0";
		if (session.getAttribute("mmuId") != null) {
			hospitalId = session.getAttribute("mmuId") + "";
		}
		String userId = null;
		if (session.getAttribute("userId") != null) {
			userId = session.getAttribute("userId") + "";
		}
	
	String hospitalFlag="O";
	if (session.getAttribute("hospitalFlag") != null) {
		hospitalFlag = session.getAttribute("hospitalFlag") + "";
	}
	
	String distIdUsersVal = "";
	if (session.getAttribute("distIdUsers") != null && session.getAttribute("distIdUsers") !="" ) {
		distIdUsersVal = session.getAttribute("distIdUsers").toString();
		//distIdUsersVal = distIdUsersVal.replace(",","");
	}

	String levelOfUser = "0";
	if (session.getAttribute("levelOfUser") != null) {
		levelOfUser = session.getAttribute("levelOfUser").toString();
		levelOfUser = levelOfUser.replace(",","");
	}

	String mmuId = "0";
	if (session.getAttribute("mmuId") != null) {
		mmuId = session.getAttribute("mmuId") + "";
	}
	
	
	
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
		
		$
				.ajax({
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

		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+ "/opd/getOpdReportsDetailsbyPatinetId";
		
		$
				.ajax({
					url : url,
					dataType : "json",
					data : JSON.stringify({
						'employeeId' : '1',
						'reportsType' : 'opd',
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
                            var visitDate = datas[i].visitDate.split("-");
                            var vDate = visitDate[2]+"/"+visitDate[1]+"/"+visitDate[0];
                            var deptName = datas[i].departmentNo;
                           
                            var a = visitId + "[" + visitDate + "]" + "[" + deptName + "]"
                            trHTML += '<option value="' + visitId + '" >'
								+ a + '</option>';
                           
                        }
						
						$('#visitDetails').html(trHTML);


					}
					   else
						{
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
	
	function uploadDoc()
	{
		 window.location.href="${pageContext.request.contextPath}/opd/uploadDocTest";
		//alert("message "+uploadDoc);
	}

	function printReport(flag) {
				
			 if(flag=='C')
			 {	    
				    var financialId=$('#financialYear').val();
				    var phase=$('#phase').val();
				    var upssIdFR=$('#upssFR').val();
				    if(upssIdFR=="")
				    {
				    	alert("Please Select UPSS  ")
				    	return false;
				    }
					var printCaseSheet="${pageContext.request.contextPath}/report/fundAllocationReport?financialId="+financialId+ "&phase="+ phase+ "&upssId="+ upssIdFR;
					openPdfModel(printCaseSheet);
			 }		
			if(flag=='I')
			{	
				    var upssId=$('#upss').val();
				    var cityId=$('#cityId').val();
				    var asOnDate=$('#dateOfUpload').val();
				    var phase=$('#phaseUti').val();
				    if(upssId=="")
				    {
				    	alert("Please Select UPSS  ")
				    	return false;
				    }
				    if(asOnDate=="")
				    {
				    	alert("Please Select Date")
				    	return false;
				    }
				    var printInvestigationSlip="${pageContext.request.contextPath}/report/fundUltilizationReport?upssId="+upssId+"&cityId="+ cityId+"&asOnDate="+ asOnDate+ "&phase="+ phase;
					openPdfModel(printInvestigationSlip);
			}
				
	  				
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

function getStoreFinancialYear(){
	 $j("#financialYear").empty();
	
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getStoreFinancialYear",
	    data: JSON.stringify({"PN" : "0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "" ;
	    	for(var i=0;i<result.MasStoreFinancialData.length;i++){
	    		combo += '<option value='+result.MasStoreFinancialData[i].financialId+'>' +result.MasStoreFinancialData[i].yearDescription+ '</option>';
	    		
	    	}
	    	
	    	jQuery('#financialYear').append(combo);
	    	
	    }
	    
	});
}

function GetDistrictList(){
	
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getAllDistrict",
	    data: JSON.stringify({"PN" : "0","upssFlag":"Y"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "" ;
	    	for(var i=0;i<result.data.length;i++){
	    		combo += '<option value='+result.data[i].districtId+'>' +result.data[i].districtName+ '</option>';
	    		
	    	}
	    	
	    	jQuery('#upss').append(combo);
	    	
	    }
	    
	});
}

function getMasPhase(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getMasPhase",
	    data: JSON.stringify({"PN" : "0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "<option value=\"\">--SELECT--</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		combo += '<option value='+result.data[i].phaseValue+'>' +result.data[i].phaseName+ '</option>';
	    		
	    	}
	    	jQuery('#phase').append(combo);
	    	jQuery('#phaseUti').append(combo);
	    	//var phaseVal=localStorage.phase;
	    	//setTimeout( function() { $('#phase').val(phaseVal);}, 1000);
	    }
	    
	});
}


var phaseId='';
var phaseValue='';
var phaseName='';
function getMasUpssPhase(){
	var upssId=$('#district').val();
	var pathname = window.location.pathname;
	var accessGroup ="MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/master/getAllUpssPhaseMapping";
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'PN' :"0",
					'mmuSearch':'<%=distIdUsersVal%>'
					}),
				contentType : "application/json",
				type : "POST",
				 success: function(result){
				    	var combo = "<option value=\"\">Select</option>" ;
				    	
				    	for(var i=0;i<result.data.length;i++){
				    		combo += '<option value='+result.data[i].phaseValue+'>' +result.data[i].phaseName+ '</option>';
				    		
				    	}
				    	jQuery('#phase').append(combo);
				    	jQuery('#phaseUti').append(combo);
				    	
				    }
				    
				});
}


var masCity="";
function getCityList(){
	$j('#cityId').empty();
	// $j("#mmuIds").empty();
	var districtId=$j("#upss option:selected").val();
	//var districtId=$(item).closest('tr').find("td:eq(0)").find(":input").val();
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getAllCity",
	    data: JSON.stringify({"PN" : "0","districtId": districtId}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "" ;
	    	masCity=result.data;
	    	combo += '<option value="0">Select</option>' ;
	    	for(var i=0;i<result.data.length;i++){
	    		
	    		combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
	    		
	    	}
	    	
	    	jQuery('#cityId').append(combo);
	    	
	    }
	    
	});
}

</script>

<!-- //////////////////////////Today opd List//////////////////////////////////////////// -->
<script type="text/javascript" language="javascript">
var nPageNo=1;
var Status;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{
			
			var distIdVal='<%=distIdUsersVal%>';
			if(distIdVal!='' && distIdVal!=null)
			{
				getMasUpssPhase();
			
			}
			else
			{
				getMasPhase();
				getStoreFinancialYear();
			}		
	        
	        GetDistrictList();
			//getDepartment();
			//GetHospitalList();
		});
	
function getStoreFinancialYear(){
	 $j("#financialYear").empty();
	
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getStoreFinancialYear",
	    data: JSON.stringify({"PN" : "0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "" ;
	    	for(var i=0;i<result.MasStoreFinancialData.length;i++){
	    		combo += '<option value='+result.MasStoreFinancialData[i].financialId+'>' +result.MasStoreFinancialData[i].yearDescription+ '</option>';
	    		
	    	}
	    	
	    	jQuery('#financialYear').append(combo);
	    	
	    }
	    
	});
}

function getStoreFinancialYearUpss(){
	 $j("#financialYear").empty();
	var startDateDist=$j("#startDate").val();
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getStoreFinancialYear",
	    data: JSON.stringify({"PN" : "0","startDate":startDateDist,"fyFilter":"Y"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "" ;
	    	for(var i=0;i<result.MasStoreFinancialData.length;i++){
	    		combo += '<option value='+result.MasStoreFinancialData[i].financialId+'>' +result.MasStoreFinancialData[i].yearDescription+ '</option>';
	    		
	    	}
	    	
	    	jQuery('#financialYear').append(combo);
	    	
	    }
	    
	});
}

function GetDistrictList(){
	var distIdVal='<%=distIdUsersVal%>';
	
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getAllDistrict",
	    data: JSON.stringify({"PN" : "0","upssFlag":"Y","districtUser":'<%=distIdUsersVal%>'}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "" ;
	    	for(var i=0;i<result.data.length;i++){
	    		$('#startDate').val(result.data[i].startDate)
	    		combo += '<option value='+result.data[i].districtId+'>' +result.data[i].districtName+ '</option>';
	    		
	    	}
	    	
	    	jQuery('#upss').append(combo);
	    	jQuery('#upssFR').append(combo);
	    	if(distIdVal!='' && distIdVal!=null)
	    	{
	    		getStoreFinancialYearUpss();
	    	}
	    	//getStoreFinancialYear();
	    }
	    
	});
}

	function todayOpdprintReport(flag,visitIdValue) {
				 //var visitIdValue=$('#visit_id').val();
			 if(flag=='C')
			 {	    
				   var financialId=$('#financialYear').val();
					var printCaseSheet="${pageContext.request.contextPath}/report/fundAllocationReport?financialId="+financialId;
					openPdfModel(printCaseSheet);
			 }		
			if(flag=='I')
			{	
					var printInvestigationSlip="${pageContext.request.contextPath}/report/printInvestigationSlip?visit_id="+visitIdValue;
					openPdfModel(printInvestigationSlip);
			}
			if(flag=='P')
			{	
				//var printPrescriptionSlip="${pageContext.request.contextPath}/report/printPrescriptionSlip?visit_id="+visitIdValue;
				var printPrescriptionSlip="${pageContext.request.contextPath}/report/mlcSlip?visit_id="+visitIdValue;
				openPdfModel(printPrescriptionSlip);	
			}
			if(flag=='R')
			{	
					var referReportSlip="${pageContext.request.contextPath}/report/referReportSlip?visit_id="+visitIdValue;
					openPdfModel(referReportSlip);
			}
			if(flag=='D'){
				//document.frm.action="${pageContext.request.contextPath}/report/siqReportSlip";
				var siqReportSlip="${pageContext.request.contextPath}/report/siqReportSlip?visit_id="+visitIdValue;
				 openPdfModel(siqReportSlip); 
				
			}
	}
  

</script>

	
	 <!-- Begin page -->
    <div id="wrapper">
	<div class="content-page">
		<!-- Start content -->
		<div class="">
			<div class="container-fluid">

				<div class="internal_Htext">Fund Allocation Reports</div>

			 
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body"> 
									<div class="row">								
									<input  name="startDate" id="startDate" type="hidden" value="" />
                                     <div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Financial Year</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="financialYear">
													<option value="">Select</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">UPSS</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="upssFR">
													<option value="">Select</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Phase</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="phase"  >
													<!-- <option value="">--SELECT--</option>
												 	<option value="phase1">Phase1</option>
													<option value="phase2">Phase2</option> -->
												</select>
											</div>
										</div>
									</div>
									
									<div class="col-md-12 m-t-10 clearfix">
												
															<div class="btn-right-all">
												<input type="button" class="btn btn-primary opd_submit_btn"  value="Fund Allocation Report" onclick="printReport('C');">
												</div>
															
															
													   </div>
									
							 </div>
										
					
                        <!-- end col -->
                    
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
							

						</div>
					</div>
				</div>
			</div>

		</div>
		<!-- //////////////////////////Today opd List//////////////////////////////////////////// -->
		<div class="container-fluid">
	 
	  <div class="internal_Htext">Fund Utilization Reports</div>
	              <div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body"> 
									<div class="row">								

                                      	<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">UPSS</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="upss" onchange="getCityList()">
													<option value="">Select</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="cityId">
													<option value="0">Select</option>
												</select>
											</div>
										</div>
									</div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Phase</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="phaseUti"  >
													<!-- <option value="">--SELECT--</option>
												 	<option value="Phase1">Phase1</option>
													<option value="Phase2">Phase2</option> -->
												</select>
											</div>
										</div>
									</div>
									
									
									 	<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Date</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" name="dateOfUpload" id="dateOfUpload" class="calDate form-control"  placeholder="DD/MM/YYYY">
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-12 m-t-10 clearfix">
												
															<div class="btn-right-all">
												<input type="button" class="btn btn-primary opd_submit_btn"  value="Fund Utilization Report" onclick="printReport('I');">
												</div>
															
															
													   </div>
									
							 </div>
										
					
                        <!-- end col -->
                    
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
							

						</div>
					</div>
				</div>
			</div>
                    <!-- end row -->
                    <!-- end row -->

                </div>
	</div>
	
	</div>
	</div>
	

</body>
</html>
 <%@include file="..//view/modelWindowForReportsMultiple.jsp"%>