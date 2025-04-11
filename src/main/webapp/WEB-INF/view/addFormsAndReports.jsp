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
     
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newOpd.js"></script>  --%>   
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>

<%@include file="..//view/commonJavaScript.jsp" %>

<script type="text/javascript">
var $j = jQuery.noConflict();
$j(document).ready(function()
		{		
		//GetApplicationAutoCompleteList();
		//GetParentId();
		});


var applicationArry = new Array();
var appId;
var dataList;
var Id='';
var appUrl='';
var applicationId;
var appNameList='';
var applicationName='';
function GetApplicationAutoCompleteList(){
		$j.ajax({
			type : "POST",
			contentType : "application/json",
			url : "getApplicationAutoComplete",
			data : JSON.stringify({}),
			dataType : "json",
			cache : false,
			success : function(result) {	
				//alert(result.max_app_id);
				console.log(result);
				var maxAppId = result.max_app_id;
				//alert("maxId :: "+maxAppId);
				 dataList = result.data;	
				             
					 	var maxId = parseInt(maxAppId.substring(1,maxAppId.length))+1;
					      //alert("max id"+parseInt(maxAppId.substring(1,maxAppId.length)));
						$j('#applicationId').val("A"+maxId);	
									
											
				  for(i=0;i<dataList.length;i++){
					  appId = dataList[i].id;					  
					  var status = dataList[i].status;
					  if(status == 'y' || status == 'Y'){
					//Id = parseInt(appId.substring(1,appId.length));					  
					  appNameList = dataList[i].appName;
					  var url = dataList[i].url;
					  var applicationName = appNameList+"["+appId+"]";
					 
					  applicationArry.push(applicationName);
					  //alert("applicationArry :: "+applicationArry);
					  }
				}  
				  autocomplete(document.getElementById("applicationName"), applicationArry);  
					
			}
		});
		
	}
	
	 function fillDataUrl(value){    	   	  
    	  for(var i=0;i<dataList.length;i++){
    		  var applicationId1 = dataList[i].id;    		  
    		  //Id = parseInt(applicationId1.substring(1,applicationId1.length));    		  
    		  if(applicationId1 == applicationId){    			 
    			  appUrl = dataList[i].url;    			  
    		  }
    	  }    	  
    	 $j('#applicationUrl').val(appUrl);    	  
      }
	
function changeApplication(value){	
	var index1 = value.lastIndexOf("[");
    var index2 = value.lastIndexOf("]");
    index1++;
    applicationId = value.substring(index1, index2);
                
}

var appName='';
var appPId='';
var appArray = new Array();
var parentApplicationName='';
function GetParentId(){
	
	$j.ajax({
		type : "POST",
		contentType : "application/json",
		url : "getApplicationAutoComplete",
		data : JSON.stringify({}),
		dataType : "json",
		cache : false,
		success : function(result) {	
			console.log(result);
			var dataList = result.listObjModule;
			for(var i=0;i<dataList.length;i++){
				 appPId = dataList[i].applicationId;
				 var parentId = dataList[i].parentApplicationId;
				 //alert("appPId :: "+appPId);
				
				parentApplicationName = dataList[i].parentApplicationName;
				
				
				 var appName1 = dataList[i].applicationName;
								 	
				 	if(parentApplicationName == undefined){
				 		appName =  appName1+"["+appPId+"]";
				 	}else{
				 		appName =  appName1+"["+appPId+"]"+"["+parentApplicationName+"]";
				 	}
				 		
				 //appName =  appName1+"["+appPId+"]"+"["+parentApplicationName+"]";
				// alert(appName);
				 appArray.push(appName);
			}
			 autocomplete(document.getElementById("parentId"), appArray);
		}
	})
}
var successmsg='';
function addFormAndReportsDetails(){
	
	if(document.getElementById('applicationName').value==""){
		alert("Please Enter Valid Menu Name");
		return false;
	}
	if(document.getElementById('parentId').value==""){
		alert("Please Enter the ParentId");
		return false;
	}
	if(document.getElementById('applicationUrl').value==""){
		alert("Please Enter the Url");
		return false;
	}
	
	var applicationName = $j('#applicationName').val();
	 var appurl = $j('#applicationUrl').val();
	 var parentidd = document.getElementById('parentId').value; 
	 //alert("appPId :: "+appPId);
	 //alert("parentidd :: "+parentidd);
	 $j('#btnAdd').prop("disabled",true);
	 params = {"applicationId":$j('#applicationId').val(),
			"applicationName":$j('#applicationName').val(),
			"parentId":parentidd,
			"url":appurl
			}
		
	//alert("applicationArry $$$ :: "+applicationArry);
	 var appName = document.getElementById('applicationName').value;
	//alert("appName :: "+appName);
	var url="addFormAndReports";
		SendJsonData(url,params);
		ResetForm();
		
		
			//alert("Record Added Successfully");
			//window.location.reload();
		return;
		
	/* for(var i=0;i<applicationArry.length;i++){
		
		if(applicationArry[i]==document.getElementById('applicationName').value){
			
			
			var url="addFormAndReports";
			SendJsonData(url,params);
			ResetForm();
			
			window.location.reload();
				alert("Record Added Successfully");
			return;
		}
	} */
		/* if(applicationArry[i]!=appName){
						
			alert("Please Enter valid Menu Name");
			return; 	
				
		} */
	
		function validateParentId(){
			for(var j=0;j<appArray.length;j++){
				if(document.getElementById('parentId').value!=0){
					alert("Please Enter Valid Parent Id or 0");
					return false;
				}
				else{
					return true;
				}
			}
			
		}
		
	 
}
 function editFormAndReports(){
	document.formsAndReportForm.name='formsAndReportForm';
	document.formsAndReportForm.method='POST';
	document.formsAndReportForm.action="${pageContext.request.contextPath}/user/editFormsAndReport";
	document.formsAndReportForm.submit(); 
} 

function ResetForm()
{	
	$j('#parentId').val('');
	$j('#applicationName').val('');
	$j('#applicationUrl').val('');
	
}

function validateUrl(value){
	alert("value :: "+value);
	//var regExp = "^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$";
	
	//alert("regExp :: "+regExp);
	var valid = value.match("/");
	alert(valid);
}
</script>


<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
</head>
<body>
    <!-- Begin page -->
    <div id="wrapper">
      
        <div class="content-page">
            <!-- Start content -->
            <div class="">
                <div class="container-fluid">
                <div class="internal_Htext">ADD FORMS / REPORTS</div>
                                      
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                  
                                   <form class="form-horizontal" id="formsAndReportForm" name="formsAndReportForm" autocomplete="off">
                                            
                                    <div class="row">                                                                     
                                        
                                           
                                                   <div class="col-md-4">
	                                                   <div class="form-group row">
	                                                    <label class="col-md-5 col-form-label inner_md_htext">Menu Id</label>
		                                                    <div class="col-md-7">
		                                                      <input type="text" name="applicationId" id="applicationId" class="form-control" readonly="readonly">            
		 
		                                                    </div>
	                                                    </div>
                                                    </div>
                                                    
                                               <div class="col-md-4">
                                                   <div class="form-group row">
		                                                     <label class="col-md-5  col-form-label inner_md_htext">Menu Name</label>
			                                                  <!--   <div class="autocomplete col-md-7 ">
			                                                      <input type="text" name="applicationName" id="applicationName" class="form-control" onblur="changeApplication(this.value);fillDataUrl(this);">
			                                                    </div>  -->
			                                                    
			                                                  <div class="col-md-7">
														 
															<div class="autocomplete forTableResp">
															<input name="applicationName" id="applicationName" type="text"
															class="form-control border-input"
															placeholder=" " value=""  onKeyUp="getNomenClatureList(this,'changeApplication','user','getApplicationAutoComplete','formReportUserMan');"  />
															
															<div class="autocomplete-itemsNew" id="icdDiagnosisUpdateaa" ></div>
															</div>
													</div>  
			                                                    
                                                    </div>
                                                </div>
                                                
                                                <div class="col-md-4">
                                                   <div class="form-group row">
		                                                    <label class="col-md-5  col-form-label inner_md_htext">Parent Id</label>
		                                                    <div class="col-md-7">
		                                                      <!-- <input type="text" name="parentId" id="parentId" class="form-control" placeholder=""> -->
		                                                      
		                                              
														 
															<div class="autocomplete forTableResp">
															<input name="parentId" id="parentId" type="text"
															class="form-control border-input"
															placeholder=" " value=""  onKeyUp="getNomenClatureList(this,'','user','getApplicationAutoComplete','formReportUserManParent');"  />
															
															<div class="autocomplete-itemsNew" id="parentAutoComplete" ></div>
															</div>
													
		                                                       
		                                                    </div> 
                                                     </div> 
                                                   </div>
                                                    
                                                 <!--  <div class="col-md-4">
		                                                  <div class="form-group row">
		                                                     <label class="col-md-5  col-form-label inner_md_htext">Sub Parent Id</label>
		                                                    <div class="col-md-7">
		                                                      <select class="form-control" name="subparentId" id="subparentId">
		                                                      
		                                                      </select>
		                                                    </div>
		                                                   </div>
                                                 </div> -->
                                                 
                                                   <div class="col-md-4">
                                                      <div class="form-group row">
		                                                   <label class="col-md-5  col-form-label inner_md_htext">URL</label>
		                                                    <div class="col-md-7">
		                                                      <input type="text" name="applicationUrl" id="applicationUrl" class="form-control" placeholder="" readonly>  
		                                                    </div>
		                                                  </div>
		                                               </div>
		                                                    
                                                    <div class="col-md-4">
                                                      <div class="form-group row"> 
                                                             <label class="col-md-5 col-form-label inner_md_htext">Status</label>
			                                                 <div class="col-md-7">
			                                                    
			                                                      <!-- <input type="radio" class="m-t-5" checked="checked" name="rd">
			                                                      <label class="col-form-label m-r-10">Active</label>
			                                                      
			                                                      <input type="radio" class="m-t-5" name="rd">
			                                                      <label class="col-form-label">Inactive</label> -->
			                                                      
			                                                      <div class="form-check form-check-inline cusRadio m-t-7">
																		<input class="form-check-input" type="radio" checked="checked" name="rd" id="radiobtn1">
																		<span class="cus-radiobtn"></span> 
																		<label class="form-check-label" for="radiobtn1">Active</label>
																	</div>
																	
																	<div class="form-check form-check-inline cusRadio m-t-7">
																		<input class="form-check-input" type="radio" name="rd" id="radiobtn2">
																		<span class="cus-radiobtn"></span> 
																		<label class="form-check-label" for="radiobtn2">Inactive</label>
																	</div>
			                                                 </div>
                                                         </div>
                                                    </div>
                                                    
                                                    
                                                </div>
                                                
                                      <div class="row">
                                       <!--  <div class="col-md-10">
                                        </div>
                                        <div class="col-md-2">
                                            
                                                <div class="button-list">
                                                    <button type="button" id="btnAdd" class="btn btn-primary " onclick="addFormAndReportsDetails();">Add</button>
                                                    <button type="submit" id="btnEdit" class="btn btn-primary" onclick="editFormAndReports();">Edit</button>
                                                </div>
                                           
                                        </div>
 -->
  
 
                                   <div class="col-md-12">
                                       
                                        <div style="float:left;">
                                            
                                               
                                           
                                        </div>
                                         <div style="float:right;">
                                            
                                                <div class="button-list">
                                                    <button type="button" id="btnAdd" class="btn btn-primary " onclick="addFormAndReportsDetails();">Add</button>
                                                    <button type="submit" id="btnEdit" class="btn btn-primary" onclick="editFormAndReports();">Edit</button>
                                                </div>
                                           
                                        </div>
                                        
                                        
                                        
                                        
                                        
                                        
                                      </div> 
 
 
                                    </div>
                                                
                                                
                                                
                                                
                                                
                                                
                                            </form>
                                        </div>
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