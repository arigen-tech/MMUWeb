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
String userId = "1";
if (session.getAttribute("user_id") != null) {
	userId = session.getAttribute("user_id") + "";
}

String levelOfUser = "1";
if (session.getAttribute("levelOfUser") != null) {
	levelOfUser = session.getAttribute("levelOfUser") + "";
}

String mmuId = "1";
if (session.getAttribute("mmuId") != null) {
	mmuId = session.getAttribute("mmuId") + "";
}
%>

var $j = jQuery.noConflict();
        $j(document).ready(function() { 
        	currentDate();  	
        	
        	getMMUList();
        	getGenderList();
        	        	
        	$("#uid").hide();
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
						 <%--  // document.getElementById('mmuId').value = <%=mmuId%>;  --%>
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
        
        function getGenderList(){
        	var params = {}
        	
        	var pathname = window.location.pathname;
        	var accessGroup = "MMUWeb";
        	var url = window.location.protocol + "//"
        	+ window.location.host + "/" + accessGroup
        	+ "/opd/getGenderList";
        	
        	$.ajax({
        		type : "POST",
        		contentType : "application/json",
        		url : url,
        		data : JSON.stringify(params),
        		dataType : "json",
        		cache : false,
        		success : function(data) {
        			if(data.status == true){
        				var list = data.data;
        				var dropDrop = '<option value="">Select</option>';
        				for(i=0;i<list.length;i++){
        					dropDrop += '<option value='+list[i].administrativeSexId+'>'+list[i].administrativeSexName+'</option>';
        				}
        				$j('#genderId').append(dropDrop);
        			}
        		},
        		error : function(data) {
        			alert("An error has occurred while contacting the server");
        		}
        	}); 
        	}
        	
        function getLabourTypeList(){
        	var params = {}
        	
        	$.ajax({
        		type : "POST",
        		contentType : "application/json",
        		url : "getLabourTyeList",
        		data : JSON.stringify(params),
        		dataType : "json",
        		cache : false,
        		success : function(data) {
        			if(data.status == true){
        				var list = data.list;
        				var dropDrop = '<option value="">Select</option>';
        				for(i=0;i<list.length;i++){
        					dropDrop += '<option value='+list[i].labourTypeId+'>'+list[i].labourTypeName+'</option>';
        				}
        				$j('#labourId').append(dropDrop);
        			}
        		},
        		error : function(data) {
        			alert("An error has occurred while contacting the server");
        		}
        	}); 
        	}
        
 
       
        
        
        function generateReport(){
        	
        	
        		
        		  if($j("#mmuId").val() == ""){
          		  	alert("Please select MMU");
          		  	retun ;
          	  }
        	  if($j("#fromdate").val() == ""){
        		  	alert("Please select From Date");
        		  	retun ;
        	  }
        	  
        	  if($j("#todate").val() == ""){
        		  	alert("Please select To Date");
        		  	retun ;
        	  }
        	  
        	  
        	  var fromDate = $('#fromdate').val();
              var toDate = $('#todate').val();
              var mmu_id = $('#mmuId').val();
              var referral = $('#referral').val();
              
              var User_id = <%=userId%>;
              var Level_of_user = '<%=levelOfUser%>';
              
              if($('#genderId').val() !="")
            	  {
            	  		var genderId = $('#genderId').val();
            	  }
              else
            	  {
            	  	var genderId = "0";
            	  
            	  }
              
              var icdId = "0";
              
             if($j('#fromAge').val() !=''){
            	 var fromAge = $j('#fromAge').val(); 
             } 
             else{
            	 var fromAge = "0"; 
             }
             if($j('#toAge').val() !=''){
            	 var toAge = $j('#toAge').val(); 
             }
      		  
             else{
            	 var toAge = "0";
             }
              
        	  
	var url = "${pageContext.request.contextPath}/report/printOPDRegisterReport?mmu_id="
				+ mmu_id
				+ "&gender_id="
				+ genderId
				+ "&fromDate="
				+ fromDate
				+ "&toDate="
				+ toDate
				+ "&icdId="
				+ icdId
				+ "&User_id="
				+ User_id
				+ "&Level_of_user="
				+ Level_of_user
				+ "&fromAge="
				+ fromAge
				+ "&toAge="
				+ toAge
				+ "&referral="
				+ referral;
	
		openPdfModel(url)

		/* document.frm.action="${pageContext.request.contextPath}/report/printMIReport";
		document.frm.method="GET";
		document.frm.submit();  */
	}
        
        function generatExcelReport(){
        	
        	
    		
  		  if($j("#mmuId").val() == ""){
    		  	alert("Please select MMU");
    		  	retun ;
    	  }
  	  if($j("#fromdate").val() == ""){
  		  	alert("Please select From Date");
  		  	retun ;
  	  }
  	  
  	  if($j("#todate").val() == ""){
  		  	alert("Please select To Date");
  		  	retun ;
  	  }
  	  
  	 
  	  var fromDate = $('#fromdate').val();
        var toDate = $('#todate').val();
        var mmu_id = $('#mmuId').val();
        var referral = $('#referral').val();
        
        var User_id = <%=userId%>;
        var Level_of_user = '<%=levelOfUser%>';
        
        if($('#genderId').val() !="")
      	  {
      	  		var genderId = $('#genderId').val();
      	  }
        else
      	  {
      	  	var genderId = "0";
      	  
      	  }
        
        var icdId = "0";
        
       if($j('#fromAge').val() !=''){
      	 var fromAge = $j('#fromAge').val(); 
       } 
       else{
      	 var fromAge = "0"; 
       }
       if($j('#toAge').val() !=''){
      	 var toAge = $j('#toAge').val(); 
       }
		  
       else{
      	 var toAge = "0";
       }
        
  	  
       window.location.href  = "${pageContext.request.contextPath}/mis/exportAuditOpdRegister?mmu_id="
			+ mmu_id
			+ "&gender_id="
			+ genderId
			+ "&fromDate="
			+ fromDate
			+ "&toDate="
			+ toDate
			+ "&icdId="
			+ icdId
			+ "&User_id="
			+ User_id
			+ "&Level_of_user="
			+ Level_of_user
			+ "&fromAge="
			+ fromAge
			+ "&toAge="
			+ toAge
			+ "&referral="
			+ referral;

	//openPdfModel(url)

	/* document.frm.action="${pageContext.request.contextPath}/report/printMIReport";
	document.frm.method="GET";
	document.frm.submit();  */
}     

	function compareToFromDate() {
		var fromDate = $('#fromdate').val();
		var toDate = $('#todate').val();

		if (process(toDate) < process(fromDate)) {
			alert("To Date should not be earlier than from Date");
			$('#todate').val("");
			return;
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

        function validateAge(){
        	       	
        	var fromAge = $j('#fromAge').val();
    		var toAge = $j('#toAge').val();
    		
    		if(fromAge !='' && fromAge > 125){
    			alert("From age should not be greater than 125 ")
    			$j('#fromAge').val("");
    		   }
    		
    		if(toAge !='' && toAge > 125){
    			alert("To age should not be greater than 125 ")
    			$j('#toAge').val("");
    		 }
    		
            if(fromAge !='' && toAge !=''){
    		  if (fromAge > toAge ) {
    			alert("To Age should not be earlier than From Age");
    			$j('#fromAge').val("");
    			$j('#toAge').val("");
    		 }
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
                         <div class="internal_Htext">MMU OPD Register</div>

                         <div class="row">
                             <div class="col-12">
                                 <div class="card">
                                     <div class="card-body">

                                         <form name="frm">
                                             <div class="row">
                                                
                                              
												<div class="col-md-4">
															<div class="form-group row">
																<div class="col-md-5">
																	<label class="col-form-label">MMU</label>
																</div>
																<div class="col-md-7">
																	<select class="form-control" id="mmuId">
																	<option value="0">All</option>
																	</select>
																</div>
															</div>
												</div>
                                                 <div class="col-md-4">
                                                     <div class="form-group row">
                                                         <label class="col-md-5 col-form-label">From Date:<span class="mandate"><sup>&#9733;</sup></span></label>
                                                         <div class="col-md-7">
                                                             <div class="dateHolder ">
                                                                 <input type="text"  class="calDate datePickerInput form-control" id="fromdate" placeholder="DD/MM/YYYY" name="date" onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10" onchange="compareToFromDate();">
                                                             </div>

                                                         </div>
                                                     </div>
                                                 </div>

                                                 <div class="col-md-4">
                                                     <div class="form-group row">
                                                         <label class="col-md-5 col-form-label">To Date:<span class="mandate"><sup>&#9733;</sup></span></label>
                                                         <div class="col-md-7">
                                                             <div class="dateHolder ">
                                                                 <input type="text"  class="calDate datePickerInput form-control" id="todate" placeholder="DD/MM/YYYY" name="date" onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10" onchange="compareToFromDate();">
                                                             </div>
                                                         </div>
                                                     </div>
                                                 </div>
                                                 
                                                 <div class="col-md-4">
														<div class="form-group row">
															<div class="col-md-5">
																<label class="col-form-label">Gender</label>
															</div>
															<div class="col-md-7">
																<select class="form-control" id="genderId">
				
																</select>
															</div>
														</div>
												</div>
												
												 <div class="col-md-4">
														<div class="form-group row">
															<div class="col-md-5">
																<label class="col-form-label">From Age</label>
															</div>
															<div class="col-md-7">
																<input type="text" name="fromAge" id="fromAge" class="form-control" placeholder="From Age" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" onblur="validateAge()" maxlength="3">
				                                  		</div>
														</div>
												</div>
												
												 <div class="col-md-4">
														<div class="form-group row">
															<div class="col-md-5">
																<label class="col-form-label">To Age</label>
															</div>
															<div class="col-md-7">
																<input type="text" name="toAge" id="toAge" class="form-control" placeholder="To Age" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" onblur="validateAge()" maxlength="3">
															</div>
														</div>
												</div>
												<div class="col-md-4">
														<div class="form-group row">
															<div class="col-md-5">
																<label class="col-form-label">Referral</label>
															</div>
															<div class="col-md-7">
															<select class="form-control" id="referral">
															       <option value="">Select</option>
																	<option value="Y">Yes</option>
																	<option value="N">No</option>
															</select>
															</div>
														</div>
												</div>
												 </div>
                                              
                                            
											<div class="row">
		                                	<div class="col-12 m-t-10 text-right">
		                               			<button type="button" class="btn btn-primary reception_mi_reports"  onclick="generateReport();"> Generate PDF</button>
		                               		</div>	</div>
		                               		 <div class="row">
		                               		 <div class="col-12 m-t-10 text-right">
		                               			<button type="button" class="btn btn-primary reception_mi_reports"  onclick="generatExcelReport();"> Generate Excel</button>
		                               			
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