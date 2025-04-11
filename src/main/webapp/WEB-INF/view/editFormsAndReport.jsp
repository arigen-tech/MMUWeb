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
    <title>Indian Coast Guard</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
     
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newOpd.js"></script> --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>  

<%@include file="..//view/commonJavaScript.jsp" %>
<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>  
<script type="text/javascript">
var $j = jQuery.noConflict();
$j(document).ready(function()
		{		
		//GetApplicationNameAutoCompleteList();
		//GetParentId();
		});
	
var applicationArry = new Array();
var dataList;
var appId;
var appUrl;
var applicationName;
var parentId;
var applicationStatus;

var	appStatus='';


function searchApplicationForUpdate(){
	
	if(document.getElementById('searchApplicationName').value ==""){
		alert("Please Enter the Menu Name");
		return false;
	}
	var applicationNameVal = $j('#searchApplicationName').val();
	
	$j.ajax({
		
		type : "POST",
		contentType : "application/json",		
		url : "getApplicationNameFormsAndReport",
		data : JSON.stringify({"icdName":applicationNameVal}),
		dataType : "json",
		success : function(result) {			
			var dataList1 = result.data;	
			   for(i=0;i<dataList1.length;i++){
				  if(dataList1[i].applicationName+"["+dataList1[i].applicationId+"]" == applicationNameVal || dataList1[i].applicationName+"["+dataList1[i].applicationId+"]"+"["+dataList1[i].parentApplicationName+"]" == applicationNameVal){
					 // alert("parentid :: "+dataList1[i].parentId +"appName :: "+dataList1[i].parentIdAppIdName);
						$j('#applicationId').val(dataList1[i].applicationId);
						$j('#applicationName').val(dataList1[i].applicationName);
						//$j('#parentId').val(dataList1[i].parentId);
						$j('#parentId').val(dataList1[i].parentIdAppIdName);						
						$j('#applicationUrl').val(dataList1[i].applicationUrl);
						appStatus = dataList1[i].applicationStatus;
					}
						
			  }
			 }
	})
}

var appName='';
var appPId='';
var appArray = new Array();
function GetParentId(){
	
	$j.ajax({
		type : "POST",
		contentType : "application/json",
		url : "getApplicationAutoComplete",
		data : JSON.stringify({}),
		dataType : "json",
		cache : false,
		success : function(result) {			
			var dataList = result.listObjModule;
			for(var i=0;i<dataList.length;i++){
				 appPId = dataList[i].applicationId;
				 
				 var appName1 = dataList[i].applicationName;
				 appName =  appName1+"["+appPId+"]";
				 //alert(appName);
				 appArray.push(appName);
			}
			 autocomplete(document.getElementById("parentId"), appArray);
		}
	})
}

function updateFormAndReportsDetails(){
	if($('#applicationId').val()==""){
		alert("Please Enter the Application Id");
		return false;
	}
	
	if($('#applicationName').val()==""){
		alert("Please Enter the Menu Name");
		return false;
	}
	if($('#parentId').val()==""){
		alert("Please Enter the Parent Id");
		return false;
	}
	if($('#applicationUrl').val()==""){
		alert("Please Enter the Url");
		return false;
	}
	//alert("status ::"+appStatus);
	var params = {
			
		    'applicationId': $('#applicationId').val(),
		    'applicationName': $('#applicationName').val(),
		    'parentId': $('#parentId').val(),
		    'applicationUrl': $('#applicationUrl').val(),
		    'applicationStatus': appStatus
	}
	//alert(JSON.stringify(params));
	 $j.ajax({
			type : "POST",
			contentType : "application/json",
			url : "updateAddFormsAndReport",
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(result){
				if(result.status==1){
		        	document.getElementById("messageId").innerHTML = result.msg;
		        	$j("#messageId").animate({height: "34px"},500);
		        	setTimeout(function() {
				        $j("#messageId").fadeOut(1500);
			
				    },3000);
		        }	        
		    	else if(result.status==0){	        	
		        	if(result.msg != undefined){
			        		document.getElementById("messageId").innerHTML = result.msg;
			        		$j("#messageId").css("color", "red");
			        		$j("#messageId").animate({height: "34px"},500);
								setTimeout(function() {
						        $j("#messageId").fadeOut(1500);
					
						    },3000);
		        		}
		        	if(result.err_mssg != undefined){
		        		document.getElementById("messageId").innerHTML = result.err_mssg;
		        		$j("#messageId").css("color", "red");
		        		$j("#messageId").animate({height: "34px"},500);
		        		setTimeout(function() {
					        $j("#messageId").fadeOut(1500);
					    },3000);
	        		}	        	
		        }
		    	else{	        	
		        	if(result.msg != undefined){
			        		document.getElementById("messageId").innerHTML = result.msg;
			        		$j("#messageId").css("color", "red");
								setTimeout(function() {
						        $j("#messageId").fadeOut(1500);
						    },3000);
		        		}
		        	if(result.err_mssg != undefined){
		        		document.getElementById("messageId").innerHTML = result.err_mssg;
		        		$j("#messageId").css("color", "red");
		        		setTimeout(function() {
					        $j("#messageId").fadeOut(1500);
					    },3000);
	        		}	        	
		        }
		    },
			error: function(result){			
				alert("An error has occurred while contacting the server"+ result);			
			   }
			
		})
		ResetForm();
	 
}

function backToaddFormAndReports(){
	//window.location = "addFormsAndReports";
	//window.location.href = "${pageContext.request.contextPath}/user/addFormsAndReports";
	 document.editformsAndReportForm.name='editformsAndReportForm';
	document.editformsAndReportForm.method='GET',
	document.editformsAndReportForm.action="${pageContext.request.contextPath}/user/addFormsAndReports";
	document.editformsAndReportForm.submit();
	
}

function ResetForm()
{	
	$j('#parentId').val('');
	$j('#applicationName').val('');
	$j('#applicationUrl').val('');
	$j('#searchApplicationName').val('');
	$j('#applicationId').val('');
	
	
	
}
</script>
<!-- <script type="text/javascript">
     var auto = setInterval(    function ()
     {
          $j('#cardBodyId').load('editFormsAndReport.jsp').fadeIn("slow");
     }, 2000); // refresh every 5000 milliseconds
</script> -->
</head>
<body>
    <!-- Begin page -->
    <div id="wrapper">
        
       
        <!-- ============================================================== -->
        <!-- Start right Content here -->
        <!-- ============================================================== -->
        <div class="content-page">
            <!-- Start content -->
            <div class="">
                <div class="container-fluid">
                <div class="internal_Htext">EDIT FORMS / REPORTS</div>
                    <div class="row">
                    </div>                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body" id="cardBodyId">
                                 <p align="center" class="m-b-10" id="messageId" style="color:green; font-weight: bold;" ></p>
                                  <form class="form-horizontal" id="editformsAndReportForm" name="editformsAndReportForm">
                                  <div class="row">
	                                  <div class="col-md-6">
	                                        <div class="form-group row">
	                                        <div class="col-sm-4">
	                                            <label class="col-form-label ">Menu Name</label>
	                                        </div>
	                                        <div class="col-md-8">
	                                            <div class="autocomplete forTableResp">
													<input name="searchApplicationName" id="searchApplicationName" type="text" class="form-control"	placeholder=" " value=""
													 onKeyUp="getNomenClatureList(this,'','user','getApplicationNameFormsAndReport','updateformReportUserMan');"  />
													<div class="autocomplete-itemsNew" id="icdDiagnosisUpdateSearchApp" ></div>
												</div>
	                                        </div>
	                                        </div>
	                                    </div>
	                                  	<div class="col-md-2">
	                                  		<!-- <button id="searchApplication" name="searchApplication" class="btn btn-primary" onclick="searchApplication();">Search</button> -->
	                                  		<input type="button" value="Submit" id="searchApplication" class="btn btn-primary" onclick="searchApplicationForUpdate();"/>
	                                  	</div>
                                  	</div>                                                                    
                                            
                                             <div class="row">    
                                                <div class="col-md-4">
			                                        <div class="form-group row">
			                                        <div class="col-sm-6">
			                                             <label class="col-form-label inner_md_htext">Menu Id</label>
			                                        </div>
			                                        <div class="col-md-6">
			                                             <input type="text" name="applicationId" id="applicationId" class="form-control" readonly="readonly">  
			                                        </div>
			                                        </div>
			                                    </div>
			                                    
			                                    <div class="col-md-4">
			                                        <div class="form-group row">
			                                        <div class="col-sm-6">
			                                              <label class="col-form-label inner_md_htext">Menu Name</label>
			                                        </div>
			                                        <div class="col-md-6">
			                                             <div class="autocomplete">
	                                                      <input type="text" name="applicationName" id="applicationName" class="form-control">
	                                                    </div>  
			                                        </div>
			                                        </div>
			                                    </div>
			                                    
			                                    <!-- <div class="w-100"></div> -->
			                                    <div class="col-md-4">
			                                        <div class="form-group row">
			                                        <div class="col-sm-6">
			                                             <label class="col-form-label inner_md_htext">Parent Id</label>
			                                        </div>
			                                        <div class="col-md-6">
			                                              <input type="text" name="parentId" id="parentId" class="form-control" placeholder="" readonly="readonly">  
			                                        </div>
			                                        </div>
			                                    </div>
			                                    
			                                    <div class="col-md-4">
			                                        <div class="form-group row">
			                                        <div class="col-sm-6">
			                                             <label class="col-form-label inner_md_htext">Url</label>
			                                        </div>
			                                        <div class="col-md-6">
			                                              <input type="text" name="applicationUrl" id="applicationUrl" class="form-control" placeholder="">  
			                                        </div>
			                                        </div>
			                                    </div>
			                                    <!-- <div class="w-100"></div> -->
			                                    <div class="col-md-4">
			                                        <div class="form-group row">
			                                        <div class="col-sm-6">
			                                             <label class="col-form-label inner_md_htext">Status</label>
			                                        </div>
			                                        <div class="col-md-6">
			                                        	
			                                        	<div class="form-check form-check-inline cusRadio m-t-10">													
															<input class="form-check-input hor-radio-fix" type="radio" checked="checked" name="rd" id="radb1" />
															<span class="cus-radiobtn"></span> 
															<label class="form-check-label" for="radb1">Active</label>
														</div>
			                                        	
			                                        	<div class="form-check form-check-inline cusRadio  m-t-10">													
															<input class="form-check-input hor-radio-fix" type="radio" name="rd" id="radb2" />
															<span class="cus-radiobtn"></span> 
															<label class="form-check-label" for="radb2">Inactive</label>
														</div>
                                                    	
                                                      	
			                                        </div>
			                                        </div>
			                                    </div>
			                                    
			                                    <div class="col-md-12">
                                            
		                                                <div class="button-list clearfix">
		                                                
		                                                	<button type="submit" id="btnBack" class="btn btn-primary btn-right-all" onclick="backToaddFormAndReports();">Back</button>
		                                                    <button type="button" id="btnUpdate" class="btn btn-primary  btn-right-all" onclick="updateFormAndReportsDetails();">Update</button>
		                                                    
		                                                </div>
		                                           
		                                        </div>
                                                
                                             </div>   
                                            </form>
                                        
                                    

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

    </div>
    <!-- END wrapper -->

    <!-- jQuery  -->
    

</body>

</html>