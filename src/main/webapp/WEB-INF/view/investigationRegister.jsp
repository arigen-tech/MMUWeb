
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mobile Medical Unit- MMSSY</title>
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
        	getInvestigationList();
        	
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
       
        function getInvestigationList(){
       	 
       	 var params = { };
       	
       	$.ajax({
       		type : "POST",
       		contentType : "application/json",
       		url : 'getInvestigationList',
       		data : JSON.stringify(params),
       		dataType : "json",
       		cache : false,
       		success : function(data) {
       			if(data.status == true){
       				var list = data.list;
       				var invDrop = '<option value="">Select</option>';
       				$j('#investigationId').find('option').not(':first').remove();
       				for(i=0;i<list.length;i++){
       					invDrop += '<option value='+list[i].invId+'>'+list[i].invName+'</option>';
       				}
       				$j('#investigationId').append(invDrop);
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
          		  	return ;
          	  }
        	  if($j("#fromdate").val() == ""){
        		  	alert("Please select From Date");
        		  	return ;
        	  }
        	  
        	  if($j("#todate").val() == ""){
        		  	alert("Please select To Date");
        		  	return ;
        	  }
        	    
        	  
        	  var investigationId = $('#investigationId').val();
        	/*   if(investigationId == ''){
        		  alert("Please select Investigation");
      		  	  return ;
        	  } */
        	 
        	  var fromDate = $('#fromdate').val();
              var toDate = $('#todate').val();
              var mmu_id = $('#mmuId').val();
             
             /*  var countDate=getDateComapareValue(fromDate,toDate);
     	 	 if(countDate!=0){
     	 		 alert("To Date should not be earlier than from Date.");
     	 		 return false;
     	 	 }
     	  */
              
              var User_id = <%=userId%>;
              var Level_of_user = '<%=levelOfUser%>';
              var gender = $('#genderId').val();
              var fromAge = $('#fromAge').val();
              var toAge = $('#toAge').val();
              
              var reportType = $("input[name='reportType']:checked").val();
            //  if(reportType=='undefined')
            	  reportType="summary";
              
              if(fromAge !='' && fromAge > 125){
            	  alert("Valid age range is 0 to 125 years");
            	  return;
              }
              if(toAge !='' && toAge > 125){
            	  alert("Valid age range is 0 to 125 years");
            	  return;
              }
              
              if(fromAge !='' && toAge !='' ){
            	  if(parseInt(fromAge) > parseInt(toAge)){
	            	  alert("From Age should be less than To Age");
	            	  return;
            	  }
              }
              	  
	var url = "${pageContext.request.contextPath}/report/printInvestigationRegister?mmu_id="
				+ mmu_id			
				+ "&fromDate="
				+ fromDate
				+ "&toDate="
				+ toDate
				+ "&User_id="
				+ User_id
				+ "&Level_of_user="
				+ Level_of_user
				+ "&gender="
				+ gender
				+ "&fromAge="
				+ fromAge
				+ "&toAge="
				+ toAge
				+ "&investigationId="
				+ investigationId
				+ "&reportType="
				+ reportType;
				
		      openPdfModel(url)

		
	}
        
        function generateExcelReport(){
        	
        	
        	 if($j("#mmuId").val() == ""){
       		  	alert("Please select MMU");
       		  	return ;
       	  }
     	  if($j("#fromdate").val() == ""){
     		  	alert("Please select From Date");
     		  	return ;
     	  }
     	  
     	  if($j("#todate").val() == ""){
     		  	alert("Please select To Date");
     		  	return ;
     	  }
     	    
     	  
     	  var investigationId = $('#investigationId').val();
     	/*   if(investigationId == ''){
     		  alert("Please select Investigation");
   		  	  return ;
     	  } */
     	 
     	  var fromDate = $('#fromdate').val();
           var toDate = $('#todate').val();
           var mmu_id = $('#mmuId').val();
          
          /*  var countDate=getDateComapareValue(fromDate,toDate);
  	 	 if(countDate!=0){
  	 		 alert("To Date should not be earlier than from Date.");
  	 		 return false;
  	 	 }
  	  */
           
           var User_id = <%=userId%>;
           var Level_of_user = '<%=levelOfUser%>';
           var gender = $('#genderId').val();
           var fromAge = $('#fromAge').val();
           var toAge = $('#toAge').val();
           
           var reportType = $("input[name='reportType']:checked").val();
         //  if(reportType=='undefined')
         	  reportType="summary";
           
           if(fromAge !='' && fromAge > 125){
         	  alert("Valid age range is 0 to 125 years");
         	  return;
           }
           if(toAge !='' && toAge > 125){
         	  alert("Valid age range is 0 to 125 years");
         	  return;
           }
           
           if(fromAge !='' && toAge !='' ){
         	  if(parseInt(fromAge) > parseInt(toAge)){
	            	  alert("From Age should be less than To Age");
	            	  return;
         	  }
           }
          	  
          window.location.href  = "${pageContext.request.contextPath}/mis/exportLabRegister?mmu_id="
				+ mmu_id			
				+ "&fromDate="
				+ fromDate
				+ "&toDate="
				+ toDate
				+ "&User_id="
				+ User_id
				+ "&Level_of_user="
				+ Level_of_user
				+ "&gender="
				+ gender
				+ "&fromAge="
				+ fromAge
				+ "&toAge="
				+ toAge
				+ "&investigationId="
				+ investigationId
				+ "&reportType="
				+ reportType;
  	     // openPdfModel(url)

  	
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
                         <div class="internal_Htext">Investigation Register</div>

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
																	<label class="col-form-label">Investigation</label>
																</div>
																<div class="col-md-7">
																	<select class="form-control" id="investigationId">
																	
																	</select>
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
																<input type="text" id="fromAge" class="form-control" onkeypress="checkNumberFormat('fromAge');" maxLength="3"/>
															</div>
														</div> 
												</div>
												
												<div class="col-md-4">
														<div class="form-group row">
															<div class="col-md-5">
																<label class="col-form-label">To Age</label>
															</div>
															<div class="col-md-7">
																<input type="text" id="toAge" class="form-control" onkeypress="checkNumberFormat('ToAge');" maxLength="3"/>
															</div>
														</div> 
												</div>
												
												<div class="col-md-4" style="display: none;">
														<div class="form-group row">
															<div class="col-md-3">
																<div class="form-check form-check-inline cusRadio m-r-15">
																	<input class="form-check-input" type="radio"  name="reportType"id="summary" value="summary"> 
																	<span class="cus-radiobtn"></span> 
																	<label class="form-check-label" for="inves1">Summary</label>
																</div>
															</div>
															<div class="col-md-3">
																<div class="form-check form-check-inline cusRadio m-r-15">
																	<input class="form-check-input" type="radio"  name="reportType"id="detail" value="detail"> 
																	<span class="cus-radiobtn"></span> 
																	<label class="form-check-label" for="inves2">Detail</label>
																</div>
															</div>
														</div> 
												</div>
														
												<div class="col-md-2 text-right">
													 <button type="button" class="btn btn-primary reception_mi_reports"  onclick="generateReport();"> Generate PDF</button>
												</div>
												<div class="col-md-2 text-right">
													 <button type="button" class="btn btn-primary reception_mi_reports"  onclick="generateExcelReport();"> Generate Excel</button>
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