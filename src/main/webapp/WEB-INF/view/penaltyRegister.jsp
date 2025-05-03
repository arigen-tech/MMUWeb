
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
        	GetVendorList();        	   	       	        	
        	
        });
        
        function GetVendorList(){
			jQuery.ajax({
			 	crossOrigin: true,
			    method: "POST",			    
			    crossDomain:true,
			    url: "${pageContext.servletContext.contextPath}/master/getAllMMUVendor",
			    data: JSON.stringify({"PN" : "0"}),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	var combo = "" ;
			    	combo += "<option value=\"0\">All</option>" ;
			    	for(var i=0;i<result.data.length;i++){
			    		combo += '<option value='+result.data[i].mmuVendorId+'>' +result.data[i].mmuVendorName+ '</option>';
			    		
			    	}
			    	jQuery('#vendor').append(combo);
			    }
			    
			});
		}
        
        function getMMUByVendorId(){
        	$j("#mmuId").empty();
        	var vendorId=$j("#vendor").val();
        	
        	jQuery.ajax({
			 	crossOrigin: true,
			    method: "POST",			    
			    crossDomain:true,
			    url: "${pageContext.servletContext.contextPath}/master/getAllMMU",
			    data: JSON.stringify({"vendorId" : vendorId,"PN":""}),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	var combo = "" ;
			    	if(vendorId=='0'){
			    		combo += "<option value='0'>All</option>";
			    	}
			    	for(var i=0;i<result.data.length;i++){
			    		
			    		combo += '<option value='+result.data[i].mmuId+'>' +result.data[i].mmuName+ '</option>';
			    		
			    	}
			    	
			    	jQuery('#mmuId').append(combo);
			    	
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
             
              var vendor_id = $('#vendor').val();
              
              
              var User_id = <%=userId%>;
              var Level_of_user = '<%=levelOfUser%>';
              	  
	var url = "${pageContext.request.contextPath}/report/printPenaltyRegister?mmu_id="
				+ mmu_id			
				+ "&fromDate="
				+ fromDate
				+ "&toDate="
				+ toDate
				+ "&User_id="
				+ User_id
				+ "&Level_of_user="
				+ Level_of_user				
				+ "&vendor_id="
				+ vendor_id;
	
		      openPdfModel(url)

		
	}
        
        function exportExcel(){
         	
        	//$('#loadingStatus').empty().append('<i class="fa fa-spinner fa-spin"></i>  Refreshing...').css('color', 'green');
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
          
           var vendor_id = $('#vendor').val();
           
           
           var User_id = <%=userId%>;
           var Level_of_user = '<%=levelOfUser%>';
             		
           window.location.href =  "${pageContext.request.contextPath}/mis/exportPenaltyExcel?mmu_id="
				+ mmu_id			
				+ "&fromDate="
				+ fromDate
				+ "&toDate="
				+ toDate
				+ "&User_id="
				+ User_id
				+ "&Level_of_user="
				+ Level_of_user				
				+ "&vendor_id="
				+ vendor_id;
         
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
                         <div class="internal_Htext">Penalty Register</div>

                         <div class="row">
                             <div class="col-12">
                                 <div class="card">
                                     <div class="card-body">

                                         <form name="frm">
                                        <div class="row">
                                      <div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Vendor</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="vendor" onchange="getMMUByVendorId()">
												 
												</select>
											</div>
										</div>
									</div>
									
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
                                                 
                                                 </div>
                                                 
                                  
                                             <div class="clearfix"></div>

                                             <div class="col-md-12 text-right">

                                                 <button type="button" class="btn btn-primary reception_mi_reports"  onclick="generateReport();"> Generate Report</button>
                                                 

                                             </div>
                                             <div class="col-md-12 text-right">
                                              <button type="button" class="btn btn-primary reception_mi_reports"  onclick="exportExcel();"> Export Excel</button>
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