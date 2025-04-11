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
	
	String levelOfUser = "1";
	if (session.getAttribute("levelOfUser") != null) {
		levelOfUser = session.getAttribute("levelOfUser") + "";
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
		
		 if(document.getElementById('visit_id').value == "")
		 {
		   alert("Please enter and select above details")
		 //  return false;
		  }
		 else
			 {
			 var visitIdValue=$('#visit_id').val();
			 if(flag=='C')
			 {	    
					var printCaseSheet="${pageContext.request.contextPath}/report/printCaseSheet?visit_id="+visitIdValue;
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

</script>

<!-- //////////////////////////Today opd List//////////////////////////////////////////// -->
<script type="text/javascript" language="javascript">
var nPageNo=1;
var Status;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{	
	        getMMUList();
			getCommandList('ALL');
			//getDepartment();
			//GetHospitalList();
		});
	
function getMMUList(){
	var params = {
			"levelOfUser":'<%=levelOfUser%>',
			"userId": <%=userId%>
	}
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : '${pageContext.request.contextPath}/master/getMMUHierarchicalList',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(result) {
			   var mmuDrop = '';
			   var data=result.mmuListdata;
			   
			   if(data.mmuList.length =='1'){
				   $('#mmuId').attr('disabled', true);
				   for(i=0;i<data.mmuList.length;i++){
						mmuDrop += '<option value='+data.mmuList[i].mmu_id+' selected>'+data.mmuList[i].mmu_name+'</option>';
						
					}
					$j('#mmuId').append(mmuDrop);
				   <%-- document.getElementById('mmuId').value = <%=mmuId%>;  --%>
				   
			   }
			   else{
				for(i=0;i<data.mmuList.length;i++){
					mmuDrop += '<option value='+data.mmuList[i].mmu_id+'>'+data.mmuList[i].mmu_name+'</option>';
					
				}
				$j('#mmuId').append(mmuDrop);
			  }
		},
		error : function(data) {
			alert("An error has occurred while contacting the server");
		}
	}); 
	}


function getCommandList(MODE)
{
	
	var mobileNo = $j('#serviceNo').val();
	 var searchPatient = $j('#searchPatient').val();
	 var opdType = $j('#opdType').val(); 	
	 var mmu_id = $j('#mmuId').val();
	 if(mmu_id === undefined || mmu_id===null){
		 mmu_id= <%=mmuId%>;
	 }
	 
	 if(MODE == 'ALL'){
		 
			var data = {"pageNo":nPageNo,"serviceNo":"",'employeeId' : <%=userId%>,'opdPre' :"c",'hospitalId':mmu_id,"opdType":opdType};			
		}
	 else if(MODE == 'FILTER')
		{
		 
		var data = {"hospitalId": mmu_id,"employeeId": <%=userId%>,"pageNo":nPageNo,"opdPre":"c","mobileNo":mobileNo,"patientName":searchPatient,"opdType":opdType};
		} 
	 
	   else if(mobileNo!=""||searchPatient!="" || mmu_id!="")
		{
		nPageNo = 1;
		var data = {"hospitalId": mmu_id,"employeeId": <%=userId%>,"pageNo":nPageNo,"opdPre":"c","mobileNo":mobileNo,"patientName":searchPatient,"opdType":opdType};
		} 
	    else
		{
			var data =  {"pageNo":nPageNo, "mobileNo":mobileNo,"patientName":searchPatient,"employeeId":<%=userId%>,"opdPre":"c","hospitalId":mmu_id,"opdType":opdType}; 
		} 
	var url = "getOpdPatientRecalls";
		
	var bClickable = true;
	GetJsonData('tblListOfCommand',data,url,bClickable);
}
function makeTable(jsonData)
{	 
	var htmlTable = "";	
	var data = jsonData.count;
	
	
	var pageSize = 5;

	
	var dataList = jsonData.data;
	if(dataList!=null && dataList.length >= 0)
	{	
	for(i=0;i<dataList.length;i++)
		{		
		
			htmlTable = htmlTable+"<tr id='"+dataList[i].visitId+"' >";	
		 
			htmlTable = htmlTable +"<td style=display:none;'>"+dataList[i].patientId+"</td>";
			
			//htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].tokenNo+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].mobileNumber+"</td>";			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].patinetname+"</td>";
			//htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].relation+"</td>";
			
			//htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].rankName+"</td>";
			/* htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].empName+"</td>"; */			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].ageFull+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].gender+"</td>";
			var caseSheet='\"C\"';
			htmlTable = htmlTable +"<td style='width: 100px;'><button type='button' id='casesheet' onClick='event.stopPropagation(); todayOpdprintReport("+caseSheet+","+dataList[i].visitId+")' name='casesheet' class='btn btn-primary btn-sm'>OPD Slip</button></td>"
			
			if(dataList[i].mlcFlag!='N')
				{
					var preSlip='\"P\"';
					htmlTable = htmlTable +"<td style='width: 100px;'><button type='button' id='prescriptionSlip' onClick='event.stopPropagation(); todayOpdprintReport("+preSlip+","+dataList[i].visitId+")' name='prescriptionSlip' class='btn btn-primary btn-sm'>MLC Slip</button></td>";
				}
			else
				{
				htmlTable = htmlTable +"<td style='width: 100px;'>Not Prescribed</td>";
				}
			
			if(dataList[i].referralFlag=='y')
			{
				var refSlip='\"R\"';
				htmlTable = htmlTable +"<td style='width: 100px;'><button type='button' id='referralReport' onClick='event.stopPropagation(); todayOpdprintReport("+refSlip+","+dataList[i].visitId+")' name='referralReport' class='btn btn-primary btn-sm'>Referral</button></td>";
			}
			else
			{
			htmlTable = htmlTable +"<td style='width: 100px;'>Not Referred</td>";
			}
			
			
			//htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].departmentName+"</td>"; 
			htmlTable = htmlTable+"</tr>";
			
		}
	}
	if(dataList==null || dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='9'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblListOfCommand").html(htmlTable);	
	
	
}
var comboArray = [];
var visitId;
var patientId;
var tokenNo;
var serviceNo;
var patinetname;
var relation;


var rankName;
var empName;
var age;
var gender;
var mobileNumber;

function executeClickEvent(visitId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(visitId == data.data[j].visitId){
			
			visitId = data.data[j].visitId;
			
			patientId = data.data[j].patientId;
			tokenNo = data.data[j].tokenNo;
			serviceNo = data.data[j].serviceNo;
			patinetname = data.data[j].patinetname;
			relation = data.data[j].relation;
			
			
			rankName = data.data[j].rankName;
			empName = data.data[j].empName;
			age = data.data[j].age;
			gender = data.data[j].gender;
			mobileNumber = data.data[j].mobileNumber;
			
		}
	}
	//rowClick(visitId,patientId,tokenNo,serviceNo,patinetname,relation,rankName,empName,age,gender,mobileNumber);
}

<%--  function searchCommandList(){
	  if(document.getElementById('serviceNo').value == "" || document.getElementById('serviceNo') == null){
		 alert("Plese Enter the Service Number");
		 return false;
	 }
	 if(document.getElementById('patientName').value == "" || document.getElementById('patientName') == null){
		 alert("Plese Enter the Patient Name");
		 return false;
	 } 
	var searchService= jQuery("#serviceNo").attr("checked", true).val();
	var searchPatient= jQuery("#patientName").attr("checked", true).val();	
	var nPageNo=1;
	var url = "getOpdPatientRecalls"; 
	var data =  {"pageNo":nPageNo, "serviceNo":searchService,"patientName":searchPatient,"employeeId":"1","opdPre":"c","hospitalId":""+<%=hospitalId%>};//"PN="+nPageNo+"cmdName="+cmdName;
	var bClickable = true;
	GetJsonData('tblListOfCommand',data,url,bClickable);
}
  --%>

	function todayOpdprintReport(flag,visitIdValue) {
				 //var visitIdValue=$('#visit_id').val();
			 if(flag=='C')
			 {	    
					var printCaseSheet="${pageContext.request.contextPath}/report/printCaseSheet?visit_id="+visitIdValue;
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
  function getDepartmentWaitingList()
  {
  	
 	var departId=$('#opdDepartmentId').val(); 
 	var unitId=$('#unitId').val(); 
 	var nPageNo=1;	
 	var opdType = $j('#opdType').val(); 
 	var data='';
 	if(unitId!="" && unitId!=0)
 	{
 		data ={"hospitalId": unitId,"employeeId": <%=userId%>,"departmentId":departId,"opdPre":"c", "serviceNo":"","patientName":"","pageNo":"1","opdType":opdType};	
 	}
 	else
 	{	
  	 data ={"hospitalId": <%= hospitalId %>,"employeeId": <%=userId%>,"departmentId":departId,"opdPre":"c", "serviceNo":"","patientName":"","pageNo":"1","opdType":opdType};
 	}
  	 var bClickable = true;
  	var url = "getOpdPatientRecalls";
  	GetJsonData('tblListOfCommand',data,url,bClickable);
  }
function rowClick(visitId,patientId,tokenNo,serviceNo,patinetname,relation,  rankName,empName,age,gender,mobileNumber){	
		
	 window.location.href = "getOpdPatientRecallModel?visitId="+visitId+"&visitStatus=com";
	
}
function ResetForm()
{	
	 $j('#serviceNo').val('');
	 $j('#patientName').val('');
}

function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	getCommandList('FILTER');
	
}

function ShowAllList(pageNo)
{	 
	 nPageNo=pageNo;
	 ResetForm();
	 getCommandList('ALL');
}

function searchOpdRecallList()
{
		

	var searchService = $j('#serviceNo').val();
	 var searchPatient = $j('#searchPatient').val();
	 
	 /* if((searchService == undefined || searchService == '') && (searchPatient == undefined || searchPatient == '')){	
			alert("Please entered at least  Moblile No. or Patient Name.");
			return;
		}	 */
	 getCommandList('Search');
	//ResetForm();
} 

function getDepartment() {

	var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";

    var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/admin/getDepartmentList";
   
	
	var params = {
		"hospitalID" : "<%= hospitalId %>"
	}

	$j.ajax({
				type : "POST",
				contentType : "application/json",
				url : url,
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(msg) {
					if (msg.status == '1') {

						var comboval = "<option value=\"\">Select</option>";
						for (var i = 0; i < msg.departmentList.length; i++) {

							comboval += '<option value=' + msg.departmentList[i].departmentId + '>'
									+ msg.departmentList[i].departmentname
									+ '</option>';

						}
						$j('#opdDepartmentId').append(comboval);

					}

				},

				error : function(msg) {

					alert("An error has occurred while contacting the server");

				}
			});
}

<%-- var unitName = "";
function GetHospitalList() {
	jQuery.ajax({
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
    	    	//alert("success "+result.data.length);
    	    	var combo = "";
    	    	
    	    	for(var i=0;i<result.data.length;i++){
    	    		//comboArray[i] = result.data[i].departmentName;
    	    		combo += '<option  value='+result.data[i].unitId+'>' +result.data[i].unitName+ '</option>';
    	    		//alert("combo :: "+comboArray[i]);
    	    		unitName=result.data[i].unitName;
    	    		
    	    	}
    	    	jQuery('#unitId').append(combo);
    	    	
    	    	if($('#unitId').find("option").length > 2){
    	    		
    	    		$('#unitId').show(); 
    	    		$('#uid').hide();
        	    	
        	    }

    	    	else{
    	    		$('#unitId').hide(); 
    	    		$('#uid').show();
    	    		$('#uid').val(unitName).attr('readonly','readonly');
    	    		document.getElementById('unitId').value = <%=hospitalId%>; 
        	    	}
        	  
    	    	
    	    	
    	    }
    	
    	});
   
     }
 --%>


</script>

	
	 <!-- Begin page -->
    <div id="wrapper">
	<div class="content-page">
		<!-- Start content -->
		<div class="">
			<div class="container-fluid">

				<div class="internal_Htext"> OPD Reports</div>

			 
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body"> 
									<div class="row">								

                                        <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5 col-form-label">UHID No./Mobile No. </label>
                                                            <div class="col-sm-7">
                                                                <input name="employee_no" id="employeeNo" type="text" class="form-control border-input" placeholder="Mobile No." value="" onblur="getPatientId()" />
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
                                                 <label class="col-sm-5 col-form-label">Visit No.</label>
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
																
									                       
												<input type="button" class="btn btn-primary opd_submit_btn"  value="OPD Slip" onclick="printReport('C');">
												<!-- <input type="button" class="btn btn-primary opd_submit_btn"  value="Investigation Slip" onclick="printReport('I');"> -->
												<input type="button" class="btn btn-primary opd_submit_btn" value="MLC Slip"  data-backdrop="static" onclick="printReport('P');">
												 <input type="button" class="btn btn-primary opd_submit_btn" value="Referral Report"  onclick="printReport('R');">
												  
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
							

						</div>
					</div>
				</div>
			</div>

		</div>
		<!-- //////////////////////////Today opd List//////////////////////////////////////////// -->
		<div class="container-fluid">
	 
	  <div class="internal_Htext">Today OPD Reports</div>
	               <input type="hidden" id="opdType" name="opdType" value=<%=hospitalFlag%>>
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                <input type="hidden" name="empCategory" id="empCategory" value=""/>
                                     <div class="row">
                                      <div class="col-md-4">
															<div class="form-group row">
																<div class="col-md-5">
																	<label class="col-form-label">MMU</label>
																</div>
																<div class="col-md-7">
																	<select class="form-control" id="mmuId">
																	</select>
																</div>
															</div>
												</div>
                                      
                                     <div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Mobile No.</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="serviceNo" maxlength="10" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" name="serviceNo" placeholder="">
												</div>
											</div>
                                    
										
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Patient Name</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="searchPatient" name="searchPatient"  placeholder="Patient Name">
												</div>
											</div>
										</div>
										
										<div class="col-sm-12 text-right">
											 <button type="button" class="btn btn-primary" onclick="searchOpdRecallList()">Search</button>
											 <button type="button" class="btn btn-primary" onclick="ShowAllList('1')">Show All</button>
										</div>
										
										
										
                                      

                                    </div>

                                     <div classs="row">
                                     
                                     <div class="col-md-4">
                                     </div>
                                     
                                     </div>

								<div style="float: left">

									<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatus" style="font-size: 15px;"
												align="left">Search Results</td>
											<td>
												<!-- <div id=resultnavigation></div> -->
											</td>
										</tr>
									</table>
								</div>
								<div style="float: right">
									<div id="resultnavigation"></div>
								</div>


								<div class="table-responsive">
                                    <table class="table table-hover table-bordered table-striped">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                               <!-- <th id="th2" class ="inner_md_htext">Token No.</th> -->
                                                <th id="th3" class ="inner_md_htext">Mobile No.</th>
                                                <th id="th4" class ="inner_md_htext"> Patient Name </th>
                                                <!-- <th id="th5" class ="inner_md_htext">Relation</th> -->
                                                 <!-- <th id="th5" class ="inner_md_htext">Rank</th> -->
                                                 <!--  <th id="th5" class ="inner_md_htext">Name</th> -->
                                                   <th id="th5" class ="inner_md_htext">Age</th>
                                                    <th id="th5" class ="inner_md_htext">Gender</th>
                                                    <th id="th6" class ="inner_md_htext">OPD Slip</th>
                                                   <!--  <th id="th7" class ="inner_md_htext">Investigation Slip</th> -->
                                                    <th id="th8" class ="inner_md_htext">MLC Slip</th>
                                                    <th id="th9" class ="inner_md_htext">Referral Report</th>
                                                   <!--  <th id="th9" class ="inner_md_htext">SIQ</th> -->
                                                     <!-- <th id="th5" class ="inner_md_htext">Department</th> -->
                                                   <!--  <th id="th5" class ="inner_md_htext">Mobile No.</th> -->
                                            </tr>
                                        </thead>
                                         
                                        <tbody id="tblListOfCommand">

                                        </tbody>
                                    </table>
									</div>
                                    <!-- end row -->

                                </div>
                            </div>
                            <!-- end card -->
                        </div>
                        <!-- end col -->
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