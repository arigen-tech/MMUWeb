<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Indian Cost Guard</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
<%@include file="..//view/commonJavaScript.jsp"%>
<script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/resources/js/ajax.js"></script>
<script>


<%			
String hospitalId = "1";

if (session.getAttribute("hospital_id") !=null)
{
	hospitalId = session.getAttribute("hospital_id")+"";
}
String userId = "1";
if (session.getAttribute("user_id") != null) {
	userId = session.getAttribute("user_id") + "";
}
%>
var $j = jQuery.noConflict();
        $j(document).ready(function() { 
        	currentDate();  	
        	//GetHospitalList(); 	
        	GetMedicalCatList();
        	GetEmployeeCatList();
        	$("#uid").hide();
      	
        });
        
       
       
        var unitName="";
        function GetHospitalList(){
        	jQuery.ajax({
        	 	crossOrigin: true,
        	    method: "POST",			    
        	    crossDomain:true,
        	    url: "${pageContext.request.contextPath}/master/getAllHospital",
        	    data: JSON.stringify({"PN":"0","hospitalId":<%=hospitalId%>}),
        	    contentType: "application/json; charset=utf-8",
        	    dataType: "json",
        	    success: function(result){
        	    	//alert("success "+result.data.length);
        	    	var combo = "" ;
        	    	
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
        
        function GetMedicalCatList(){
        	jQuery('#medicalCat').html("");
        	jQuery.ajax({
        	 	crossOrigin: true,
        	    method: "POST",			    
        	    crossDomain:true,
        	    url: "${pageContext.request.contextPath}/master/getAllMedicalCategory",
        	    data: JSON.stringify({"PN":"0"}),
        	    contentType: "application/json; charset=utf-8",
        	    dataType: "json",
        	    success: function(result){
        	    	//alert("success "+result.data.length);
        	    	var combo = "<option value=\"\">Select</option>" ;
        	    	
        	    	for(var i=0;i<result.data.length;i++){
        	    		//comboArray[i] = result.data[i].departmentName;
        	    		combo += '<option  value='+result.data[i].medicalCategoryId+'>' +result.data[i].medicalCategoryName+ '</option>';
        	    		//alert("combo :: "+comboArray[i]);
        	    		
        	    		
        	    	}
        	    	jQuery('#medicalCat').append(combo);
        	    }
        	    
        	});
         }
        
        
        function GetEmployeeCatList(){
        	
        	jQuery.ajax({
        	 	crossOrigin: true,
        	    method: "POST",			    
        	    crossDomain:true,
        	    url: "getAllEmployeeCategory",
        	    data: JSON.stringify({}),
        	    contentType: "application/json; charset=utf-8",
        	    dataType: "json",
        	    success: function(result){
        	    	//alert("success "+result.data.length);
        	    	var combo = "<option value=\"\">Select</option>" ;
        	    	
        	    	for(var i=0;i<result.data.length;i++){
        	    		//comboArray[i] = result.data[i].departmentName;
        	    		combo += '<option  value='+result.data[i].employeeCategoryId+'>' +result.data[i].employeeCategoryName+ '</option>';
        	    		//alert("combo :: "+comboArray[i]);
        	    		
        	    		
        	    	}
        	    	jQuery('#empCategory').append(combo);
        	    }
        	    
        	});
         }
        
        
        
        function generateReport()
        {
        	/* if($j("#unitId").val() == "")
      	    {
      		  	alert("Please select Unit");
      		  	retun ;
      		  	
      		  	
      	    }
        	
        	  if($j("#fromdate").val() == "")
        	  {
        		  	alert("Please select From date");
        		  	retun ;
        		  	
        		  	
        	  }
        	  
        	  if($j("#todate").val() == "")
        	  {
        		  	alert("Please select To date");
        		  	retun ;
        		  	
        		  	
        	  } */
        	  
        	  
        	var unitIdVal="";
			var serviceNoVal="";
			var fromDateVal="";
			var toDateVal="";
			var statusVal="";
			var medicalCatVal="";
			var empCategoryVal="";
        	/* if($j("#unitId").val() == "")
      	     {
      		  	alert("Please select Unit");
      		  	retun ;
      	     }
        	else{
        		unitIdVal=$j("#unitId").val();
        	}
        	  if($j("#fromdate").val() == "")
        	  {
        		  	alert("Please select From date");
        		  	retun ;
        	  }
        	  else{
        		  fromDateVal=$j("#fromdate").val();
        	  }
        	  
        	  if($j("#todate").val() == "")
        	  {
        		  	alert("Please select to date");
        		  	retun ;
        	  }
        	  else{
        		  toDateVal= $j("#todate").val();
        	  } */
        	  if($j("#serviceNoId").val()!=null && $j("#serviceNoId").val()!=""){
        		  serviceNoVal=$j("#serviceNoId").val();
        	  }
        	  if($j("#medicalCat").val()!=null && $j("#medicalCat").val()!=""){
        		  medicalCatVal=$j("#medicalCat").val();
        	  }
        	  
        	  if($j("#status").val()!=null && $j("#status").val()!=""){
        		  statusVal=$j("#status").val();
        	  }
        	  if($j("#empCategory").val()!=null && $j("#empCategory").val()!=""){
        		  empCategoryVal=$j("#empCategory").val();
        	  }
        	  
        	//	document.frm.action="${pageContext.request.contextPath}/report/printMBReport";
        		//document.frm.method="POST";
        		//document.frm.submit(); 
        		
        	  var urlForReport="${pageContext.request.contextPath}/report/printMBReport?hospitalId="+<%=hospitalId%>+"&serviceNo="+serviceNoVal+"&status="+statusVal+"&empCategory="+empCategoryVal+"&medicalCat="+medicalCatVal;
      		 openPdfModel(urlForReport); 
        }
        
        
        
        function compareToFromDate(){
       	 var fromDate = $('#fromdate').val();
       	 var toDate = $('#todate').val();
       	 
       	 if(process(toDate) < process(fromDate)){
       			alert("To Date should not be earlier than From Date");
       			$('#todate').val("");
       			return;
       	 }
       }
        
       
        function validateServiceNo(serviceNo){
        	
        	var unitId=jQuery("#unitId option:selected").val();
        	if(serviceNo !=='')
       	    {
        	var param={"unitId":unitId,"serviceNo":serviceNo};
        	
        	jQuery.ajax({
				crossOrigin : true,
				method : "POST",
				crossDomain : true,
				url : "${pageContext.request.contextPath}/master/validateServiceNo",
				data : JSON.stringify(param),
				contentType : "application/json; charset=utf-8",
				dataType : "json",
				success : function(result) {
					if (result.status == 1) {
						alert(result.msg);							
						$j("#serviceNoId").val('');
						
					} 
		
				}
		
			});
       	  }
        }
        function currentDate(){
        	var now = new Date();
         	now.setDate(now.getDate());
         	var day = ("0" + now.getDate()).slice(-2);
         	var month = ("0" + (now.getMonth() + 1)).slice(-2);
         	var today = (day)+"/"+(month)+"/"+now.getFullYear();
         	$j('#fromdate').val(today);
         	$j('#todate').val(today);
            } 
        
        ////////////MB Case sheet and Referral reports generate code ///////////////////////////////////////////////
        
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
						'reportsType' : 'mb',
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
					var printCaseSheet="${pageContext.request.contextPath}/report/mbPrintCaseSheet?visit_id="+visitIdValue;
					openPdfModel(printCaseSheet);
			 }		
			if(flag=='I')
			{	
					var printInvestigationSlip="${pageContext.request.contextPath}/report/printInvestigationSlip?visit_id="+visitIdValue;
					openPdfModel(printInvestigationSlip);
			}
			if(flag=='P')
			{	
				var printPrescriptionSlip="${pageContext.request.contextPath}/report/printPrescriptionSlip?visit_id="+visitIdValue;
				openPdfModel(printPrescriptionSlip);	
			}
			if(flag=='R')
			{	
					var referReportSlip="${pageContext.request.contextPath}/report/mbPrintRefferal?visit_id="+visitIdValue;
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

</head>

<body>

    <!-- Begin page -->
    <div id="wrapper">

       

        <!-- ========== Left Sidebar Start ========== -->
        
        <!-- Left Sidebar End -->

        <!-- ============================================================== -->
        <!-- Start right Content here -->
        <!-- ============================================================== -->
        <div class="content-page">
            <!-- Start content -->
            <div class="">
                <div class="container-fluid">
                    <div class="internal_Htext">MB Report</div>
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                               
        
						              <form name="frm">						                          
						                    <div class="row">
						                    <!-- <div class="col-md-4">
							                            <div class="form-group row">							                                
							                                <label class="col-md-5 col-form-label">Unit:<span class="mandate"><sup>&#9733;</sup></span></label>
							                                <div class="col-md-7">
							                                    
							                                    <select class="form-control" id="unitId" name="unitId" >												  
													</select>
													<input type="text" class="auto  form-control" size="8"  name="uid" id ="uid"/>
							                                </div>
							                            </div>
							                        </div> -->
							                        <div class="col-md-4">
													<div class="form-group row">
														<label class="col-md-5 col-form-label">Service No.</label> 
														<div class="col-md-7">																			
															    <input	id="serviceNoId" class="auto  form-control" size="8" type="text"
																			name="serviceNo" value="" placeholder="Enter Service No"
																			onblur="validateServiceNo(this.value);" maxlength="10" />															
															
														</div>
													</div>
										          </div>
							                        <!-- <div class="col-md-4">
							                            <div class="form-group row">
							                                <label class="col-md-5 col-form-label">From Date:<span class="mandate"><sup>&#9733;</sup></span></label>
							                                <div class="col-md-7">
							                            <div class="dateHolder ">
														<input type="text"  class="calDate datePickerInput form-control" id="fromdate" placeholder="DD/MM/YYYY"
														name="date"  onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10" onchange="compareToFromDate();">
													</div>
							                                  
							                                </div>							                                
							                            </div>
							                        </div> -->
						                    
								                    <!-- <div class="col-md-4">
								                            <div class="form-group row">
								                                <label class="col-md-5 col-form-label">To Date:<span class="mandate"><sup>&#9733;</sup></span></label>
								                                <div class="col-md-7">
								                                <div class="dateHolder ">
														<input type="text"  class="calDate datePickerInput form-control" id="todate" placeholder="DD/MM/YYYY"
														name="date"  onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10" onchange="compareToFromDate();">
													</div>	
							                                </div>								                                
								                            </div>
								                      </div> -->
						                      
							                        <div class="col-md-4">
							                            <div class="form-group row">							                                 
							                                <label class="col-md-5 col-form-label">Medical Category:</label>
							                                <div class="col-md-7">
							                                    <select name="medicalCat" id="medicalCat" class="medium form-control"></select>																</select> 
							                                </div>
							                                
							                                
							                            </div>
							                        </div>
							                        <div class="col-md-4">
							                            <div class="form-group row">
							                                <label class="col-md-5 col-form-label">Status:</label>
							                                <div class="col-md-7">
							                                    <select class="form-control" id="status" name="status">
							                                    <option value="">Select</option>
							                                    <option value="1">Complete</option>
							                                    <option value="2">Due</option>							                                    
							                                    <option value="3">Overdue</option>							                                    
							                                    </select>
							                                
							                                </div>
							                                 
							
							                            </div>
							                        </div> 
							                        
							                        <div class="col-md-4">
							                            <div class="form-group row">
							                                <label class="col-md-5 col-form-label">Emp Category:</label>
							                                <div class="col-md-7">
							                                    <select class="form-control" id="empCategory" name="empCategory"></select>
							                                </div>
							                                 
							
							                            </div>
							                        </div> 
							                           
								            </div>								            
								             <div class="clearfix"></div>								
								        
								            <div class="row m-t-10">     
								                    
							                        
							                       <div class="col-12 text-right">
							                          
							                          <button type="button" 
															class="btn btn-primary reception_mi_reports" onclick="generateReport();"> Generate Report</button>
							                            
							                        </div> 
							                         
							                        
								            </div>
								            
								            
								        </form>

                   
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
                <!-- container -->

            </div>
            <!-- content -->
 
        </div>

        <!-- ============================================================== -->
        <!-- End Right content here -->
        <!-- ============================================================== -->

     
    <!-- END wrapper -->

    <!-- jQuery  -->

<!-- New Mb case sheet and refferal report generated  -->

 <div id="wrapper">
	<div class="content-page">
		<!-- Start content -->
		<div class="">
			<div class="container-fluid">

				<div class="internal_Htext"> MB Case Sheet/Referral Reports</div>

			 
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body"> 
									<div class="row">

                                        <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <label class="col-sm-5 col-form-label">Service No./UHID No./Mobile No. </label>
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
																
									                       
												<input type="button" class="btn btn-primary opd_submit_btn"  value="Case Sheet" onclick="printReport('C');">
												<!-- <input type="button" class="btn btn-primary opd_submit_btn"  value="Investigation Slip" onclick="printReport('I');">
												<input type="button" class="btn btn-primary opd_submit_btn" value="Prescription Slip"  data-backdrop="static" onclick="printReport('P');"> -->
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
		<%-- <div class="container-fluid">
	 
	  <div class="internal_Htext">Today OPD Reports</div>
	               <input type="hidden" id="opdType" name="opdType" value=<%=hospitalId%>>
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                <input type="hidden" name="empCategory" id="empCategory" value=""/>
                                     <div class="row">
                                      <div class="col-md-4" id="unitDiv">
                                      	<div class="form-group row">
                                                         <label class="col-md-5 col-form-label">Unit:<span class="mandate"><sup>&#9733;</sup></span></label>
                                                         <div class="col-md-7">
                                                             <select class="form-control" id="unitId" name="unitId" onchange="getDepartmentWaitingList()">
                                                             </select>
                                                            <input type="text" class="auto  form-control" size="8"  name="uid" id ="uid"/>
                                                         </div>
                                        </div>
                                     </div>
                                     <div class=" col-md-4">
		                                 	<div class="form-group row">
														<label class="col-sm-5 col-form-label">Department<span class="mandate"><sup>&#9733;</sup></span></label>
														<div class="col-sm-7">
															<select class="form-control" id="opdDepartmentId" onchange="getDepartmentWaitingList()">
															</select>
														  </div>
													     </div>
		                                 </div> 
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Service No.</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="serviceNo" name="serviceNo" placeholder="">
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Patient Name</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="patientName" name="patientName" placeholder="">
												</div>
											</div>
										</div>
										
										<div class="col-sm-4">
											 <button type="button" class="btn btn-primary" onclick="searchOpdRecallList()">Search</button>
										</div>
										<div class="col-md-4">
											
												
												<div class="btn-right-all">
													
													<button type="button" class="btn btn-primary"
														onclick="ShowAllList('1')">Show All</button>
												</div>
											
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


								
                                    <table class="table table-hover table-bordered table-striped">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                               <!-- <th id="th2" class ="inner_md_htext">Token No.</th> -->
                                                <th id="th3" class ="inner_md_htext">Service No.</th>
                                                <th id="th4" class ="inner_md_htext"> Patient Name </th>
                                                <!-- <th id="th5" class ="inner_md_htext">Relation</th> -->
                                                 <!-- <th id="th5" class ="inner_md_htext">Rank</th> -->
                                                 <!--  <th id="th5" class ="inner_md_htext">Name</th> -->
                                                   <th id="th5" class ="inner_md_htext">Age</th>
                                                    <th id="th5" class ="inner_md_htext">Gender</th>
                                                    <th id="th6" class ="inner_md_htext">Case Sheet</th>
                                                    <th id="th7" class ="inner_md_htext">Investigation Slip</th>
                                                    <th id="th8" class ="inner_md_htext">Prescription Slip</th>
                                                    <th id="th9" class ="inner_md_htext">Referral Report</th>
                                                    <th id="th9" class ="inner_md_htext">SIQ</th>
                                                     <!-- <th id="th5" class ="inner_md_htext">Department</th> -->
                                                   <!--  <th id="th5" class ="inner_md_htext">Mobile No.</th> -->
                                            </tr>
                                        </thead>
                                         
                                        <tbody id="tblListOfCommand">

                                        </tbody>
                                    </table>
						
                                    <!-- end row -->

                                </div>
                            </div>
                            <!-- end card -->
                        </div>
                        <!-- end col -->
                    </div>
                    <!-- end row -->
                    <!-- end row -->

                </div> --%>
	</div>
	
	</div>
	</div>

</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>