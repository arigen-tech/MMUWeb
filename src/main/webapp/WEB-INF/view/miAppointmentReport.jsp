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
        	$j('#department').html("");
        	getDisposalDetail();
        	getAppointmentTypeList();
        	GetHospitalList();        	
        	$("#uid").hide();
        });
        
       
        function makeCombo() {

    		var params = {
    			"hospitalID" : "<%= hospitalId %>"
    		}
    		
    		$j.ajax({
    					type : "POST",
    					contentType : "application/json",
    					url : '${pageContext.request.contextPath}/admin/getDepartmentList',
    					data : JSON.stringify(params),
    					dataType : "json",
    					cache : false,
    					success : function(msg) {
    						if (msg.status == '1') {

    							var comboval = "<option value='0'>Select</option>";
    							for (var i = 0; i < msg.departmentList.length; i++) {

    								comboval += '<option value=' + msg.departmentList[i].departmentId + '>'
    										+ msg.departmentList[i].departmentname
    										+ '</option>';

    							}
    							$j('#department').append(comboval);

    						}

    					},

    					error : function(msg) {

    						alert("An error has occurred while contacting the server");

    					}
    				});
    	}
        
 
        function getDisposalDetail() {

       		var pathname = window.location.pathname;
        	var accessGroup = "MMUWeb";
        	var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/opd/getMasDisposalList";
        	
        	
        	
        	$j.ajax({
        				url : url,
        				dataType : "json",
        				data : JSON.stringify({
        					'employeeId' : <%= userId %>
        				}),
        				contentType : "application/json",
        				type : "POST",
        				success : function(response) {
        					console.log(response);
        					var datas = response.MasDisposal;
        					var trHTML = "<option value='0'>Select</option>";
        					$j.each(datas, function(i, item) {
        						trHTML += '<option value="' + item.disposalId + '" >'
        								+ item.disposalName + '</option>';
        					});

        					$j('#disposalId').html(trHTML);

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
        function getAppointmentTypeList() {

        	jQuery.ajax({
        	 	crossOrigin: true,
        	    method: "POST",			    
        	    crossDomain:true,
        	    url: "getAppointmentTypeList",
        	    data: JSON.stringify({}),
        	    contentType: "application/json; charset=utf-8",
        	    dataType: "json",
        	    success: function(result){
        	    	
        	    	var combo = "<option value='0'>Select</option>" ;
        	    	
        	    	for(var i=0;i<result.data.length;i++){	    		
        	    		combo += '<option value='+result.data[i].id+'>' +result.data[i].appointmentType+ '</option>';    		
        	    		
        	    	}
        	    	jQuery('#appointmentTypeId').append(combo);
        	    }
        	    
        	});
    	}
        
        
        function generateReport(){
        	if($j("#unitId").val() == ""){
      		  	alert("Please select Unit");
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
        	  
        	  var unitId=$j("#unitId").val();
        	  var serviceNo=$j("#serviceNoId").val()
        	  var fromDate = $('#fromdate').val();
              var toDate = $('#todate').val();
              var appointmentTypeId = $('#appointmentTypeId').val();
              var disposalId = $('#disposalId').val();
              var department = $('#department').val();
              var inlineRadioOptions = $j("input[name='inlineRadioOptions']:checked").val();
              
              
              
        	  
	var url = "${pageContext.request.contextPath}/report/printMIReport?unitId="
				+ unitId
				+ "&serviceNo="
				+ serviceNo
				+ "&fromDate="
				+ fromDate
				+ "&toDate="
				+ toDate
				+ "&appointmentTypeId="
				+ appointmentTypeId
				+ "&disposalId="
				+ disposalId
				+ "&department="
				+ department
				+ "&inlineRadioOptions="
				+ inlineRadioOptions;
	
		openPdfModel(url)

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
	var unitName = "";
	function GetHospitalList() {
		jQuery.ajax({
			crossOrigin : true,
			method : "POST",
			crossDomain : true,
			url : "${pageContext.request.contextPath}/master/getAllHospital",
			data : JSON.stringify({
				"PN" : "0",
				"hospitalId" :
<%=hospitalId%>}),
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

        function enableDisableDisposal(){
            var value=$j("#appointmentTypeId").find("option:selected").text();

             if(value=='ME' || value=='MB'){
             	document.getElementById("disposalId").disabled = true;
                 }  
             else{
             	document.getElementById("disposalId").disabled = false;
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
                         <div class="internal_Htext">Generate MI Appointment Report</div>

                         <div class="row">
                             <div class="col-12">
                                 <div class="card">
                                     <div class="card-body">

                                         <form name="frm">
                                             <div class="row">
                                                 <div class="col-md-4">
                                                     <div class="form-group row" id="unitDiv">
                                                         <label class="col-md-5 col-form-label">Unit:<span class="mandate"><sup>&#9733;</sup></span></label>
                                                         <div class="col-md-7">
                                                             <select class="form-control" id="unitId" name="unitId">
                                                             </select>
                                                            <input type="text" class="auto  form-control" size="8"  name="uid" id ="uid"/>
                                                         </div>
                                                     </div>
                                                 </div>
                                                 <div class="col-md-4">
                                                     <div class="form-group row">
                                                         <label class="col-md-5 col-form-label">Service No.</label>
                                                         <div class="col-md-7">
                                                             <input id="serviceNoId" class="auto  form-control" size="8" type="text" name="serviceNo" value="" placeholder="Enter Service No" onblur="validateServiceNo(this.value);" maxlength="10" />

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
                                                         <label class="col-md-5 col-form-label">Appointment Type</label>
                                                         <div class="col-md-7">
                                                             <select class="form-control" id="appointmentTypeId" name="appointmentTypeId" onchange="enableDisableDisposal()">
                                                             </select>
                                                         </div>
                                                     </div>
                                                 </div>

                                                 <div class="col-md-4">
                                                     <div class="form-group row">
                                                         <label class="col-md-5 col-form-label">Disposal Type</label>
                                                         <div class="col-md-7">
                                                             <select name="disposalId" id="disposalId" class="medium form-control"></select>
                                                             </select>
                                                         </div>

                                                     </div>
                                                 </div>
                                                 <div class="col-md-4">
                                                     <div class="form-group row">
                                                         <label class="col-md-5 col-form-label">Department</label>
                                                         <div class="col-md-7">
                                                             <select class="form-control" id="department" name="department"></select>
                                                         </div>

                                                     </div>
                                                 </div>

                                                 <div class="col-md-4">
                                                     <div class="form-group row m-t-7 m-l-10">
                                                         <div class="col-md-5">

                                                             <div class="form-check form-check-inline cusRadio">
                                                                 <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio3" value="C">
                                                                 <span class="cus-radiobtn"></span>
                                                                 <label class="form-check-label">Total Count</label>
                                                             </div>
                                                         </div>
                                                         <div class="col-md-4">
                                                             <div class="form-check form-check-inline cusRadio">
                                                                 <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio3" value="D" checked>
                                                                 <span class="cus-radiobtn"></span>
                                                                 <label class="form-check-label">Detailed</label>
                                                             </div>
                                                         </div>

                                                         <div class="col-md-3">
                                                         </div>
                                                     </div>
                                                 </div>

                                             </div>
                                             <div class="clearfix"></div>

                                             <div class="col-md-12 text-right">

                                                 <button type="button" class="btn btn-primary reception_mi_reports"  onclick="generateReport();"> Generate Report</button>

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