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
        	GetHospitalList();        	
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

        	    	
        	    	if(result.data.length>1){
        	    		
        	    		$('#unitId').show(); 
        	    		$('#uid').hide();
            	    	
            	    }

        	    	else{
        	    		$('#unitId').hide(); 
        	    		$('#uid').show();
        	    		$('#uid').val(unitName).attr('readonly','readonly');
            	    	}
            	    
        	    	jQuery('#unitId').append(combo);
        	    	document.getElementById('unitId').value = <%=hospitalId%>;
        	    	
        	    }
        	
        	});
       
         }
        
        
        
        function GetEmployeeCatList(){
        	
        	jQuery.ajax({
        	 	crossOrigin: true,
        	    method: "POST",			    
        	    crossDomain:true,
        	    url: "${pageContext.request.contextPath}/medicalBoard/getAllEmployeeCategory",
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
        	  /* if($j("#fromdate").val() == "")
        	  {
        		  	alert("Please select From date");
        		  	retun ;
        		  	
        		  	
        	  }
        	  
        	  if($j("#todate").val() == "")
        	  {
        		  	alert("Please select to date");
        		  	retun ;
        		  	
        		  	
        	  }
        		document.frm.action="${pageContext.request.contextPath}/report/printMEReport";
        		document.frm.method="POST";
        		document.frm.submit();  */
        	var unitIdVal="";
			var serviceNoVal="";
			var fromDateVal="";
			var toDateVal="";
			var statusVal="";
			var empCategoryVal="";
			 
        	if($j("#unitId").val() == "")
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
        	  }
        	  if($j("#serviceNoId").val()!=null && $j("#serviceNoId").val()!=""){
        		  serviceNoVal=$j("#serviceNoId").val();
        	  }
        	  if($j("#empCategory").val()!=null && $j("#empCategory").val()!=""){
        		  empCategoryVal=$j("#empCategory").val();
        	  }
        	  if($j("#status").val()!=null && $j("#status").val()!=""){
        		  statusVal=$j("#status").val();
        	  }
        		 
        	  var urlForReport="${pageContext.request.contextPath}/report/printMEReport?unitId="+unitIdVal+"&fromDate="+fromDateVal+"&serviceNo="+serviceNoVal+"&status="+statusVal+"&empCategory="+empCategoryVal+"&toDate="+toDateVal;
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
                    <div class="internal_Htext">ME Report</div>
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                               
        
						              <form name="frm">						                          
						                    <div class="row">
						                    <div class="col-md-4">
							                            <div class="form-group row">							                                
							                                <label class="col-md-5 col-form-label">Unit:<span class="mandate"><sup>&#9733;</sup></span></label>
							                                <div class="col-md-7">
							                                    
							                                    <select class="form-control" id="unitId" name="unitId" >												  
													</select>
													<input type="text" class="auto  form-control" size="8"  name="uid" id ="uid"/>
							                                </div>
							                            </div>
							                        </div>
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
							                        <div class="col-md-4">
							                            <div class="form-group row">
							                                <label class="col-md-5 col-form-label">From Date:<span class="mandate"><sup>&#9733;</sup></span></label>
							                                <div class="col-md-7">
							                            <div class="dateHolder ">
														<input type="text"  class="calDate datePickerInput form-control" id="fromdate" placeholder="DD/MM/YYYY"
														name="date"  onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10" onchange="compareToFromDate();">
													</div>
							                                  
							                                </div>							                                
							                            </div>
							                        </div>
						                    
								                    <div class="col-md-4">
								                            <div class="form-group row">
								                                <label class="col-md-5 col-form-label">To Date:<span class="mandate"><sup>&#9733;</sup></span></label>
								                                <div class="col-md-7">
								                                <div class="dateHolder ">
														<input type="text"  class="calDate datePickerInput form-control" id="todate" placeholder="DD/MM/YYYY"
														name="date"  onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10" onchange="compareToFromDate();">
													</div>	
							                                </div>								                                
								                            </div>
								                      </div>                                            
						                         <div class="col-md-4">
							                            <div class="form-group row">
							                                <label class="col-md-5 col-form-label">Status:</label>
							                                <div class="col-md-7">
							                                    <select class="form-control" id="status" name="status">
							                                    <option value="">Select</option>
							                                    <option value="1">Pending</option>
							                                    <option value="2">Overdue</option>
							                                    <option value="3">Completed</option>							                                    
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
    

</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>