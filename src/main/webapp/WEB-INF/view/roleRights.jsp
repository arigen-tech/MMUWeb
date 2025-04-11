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
     <!-- <link href="//resources/css/icons1.css" rel="stylesheet" type="text/css" /> -->
    
<%@include file="..//view/commonJavaScript.jsp" %>
 <%
 String hospitalId = "1";
	if (session.getAttribute("hospital_id") != null) {
		hospitalId = session.getAttribute("hospital_id") + "";
	}
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
  %>
<script>
	//scrollbar script
$(function(){
var winHeight = $(window).height();

$('.scrollableDiv').css({'height':winHeight-420});

// add custom scroll to sscrollableDiv class
    $('.scrollableDiv').slimscroll({
        height: 'auto',
        position: 'right',
        color: '#9ea5ab',
        touchScrollStep: 50
    });
})

</script>  
  
<script type="text/javascript" language="javascript">


var $j = jQuery.noConflict();
var checkStatus="";
var dataList;
$j(document).ready(function()
		{
		$j('#btnSubmit').hide();
			getRoleRightsList();
			getTemplateNameList();
			
		});


function getRoleRightsList(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getRoleRightsList",
	    data: JSON.stringify({}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){	    		
	    		combo += '<option value='+result.data[i].roleId+'>' +result.data[i].roleName+ '</option>';    		
	    		
	    	}
	    	jQuery('#rolelist').append(combo);
	    }
	    
	});
}

function getTemplateNameList(){
	
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getTemplateNameList",
	    data: JSON.stringify({}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	
	    	makeTableAll(result); 
	    }
	    
	});
}

function makeTableAll(result) {		
	var tempid=0;	
	var htmlTable = "";	
	var dataList = result.data;		
	for(i=0;i<dataList.length;i++)	{		
			htmlTable = htmlTable+'<tr>';		
			htmlTable = htmlTable +'<td style="display:none">'+dataList[i].templateId+'</td>';						
			htmlTable = htmlTable +'<td style="">'+dataList[i].templateName+'</td>';			 
			htmlTable = htmlTable +"<td style=''><div class='form-check form-check-inline cusCheck m-l-10'><input id='chk"+dataList[i].templateId+"' type='checkbox' class='form-check-input'  value='"+dataList[i].templateId+"'><span class='cus-checkbtn'></span></div></td>";	 
			htmlTable = htmlTable+'</tr>';			    
			
		}	
	
	
	$j("#tblListOTemplate").html(htmlTable);	
	
}



function makeTable(result,role) {	
	
	var tempid=0;	
	var htmlTable = "";	
	var dataList = result.data;	
	//var dataCommon = result.data;
	
	for(i=0;i<dataList.length;i++)	{	
			
		var tempLateIdd=dataList[i].templateId;
		
			
		
			htmlTable = htmlTable+'<tr>';		
			htmlTable = htmlTable +'<td style="width: 150px; display:none">'+dataList[i].templateId+'</td>';						
			htmlTable = htmlTable +'<td style="width: 150px;">'+dataList[i].templateName+'</td>';			 
			htmlTable = htmlTable +"<td style='width: 150px;'><input class='chk' id='chk"+dataList[i].templateId+"' type='checkbox'   value='"+dataList[i].templateId+"'></td>";		 
			htmlTable = htmlTable+'</tr>';			    
			
		}	
		
	 
	
	$j("#tblListOTemplate").html(htmlTable);	
	
}	


function getAssingedTemplateNameList(value){	
	
	var data = {"roleId":value,"hosptId":<%=hospitalId%>};
	//alert(JSON.stringify(data));
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,	    	
	    url: "getAssingedTemplateNameList",
	    data: JSON.stringify(data),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    async:false,
	    cache:false,
	    success: function(result){
	    	dataList = result.data;	
	    	
	    	
	    	if(dataList.length ==0)
	    		{
	    		$j('input:checkbox').removeAttr("checked");
	    		}
	    	for(i=0;i<dataList.length;i++){
	    		
	    		var tempId= $j("#chk"+dataList[i].id).val();
	    		if(dataList[i].id==tempId && dataList[i].status=='y' ){
	    			
	    			$j("#chk"+dataList[i].id).attr("checked","checked");
	    			
	    		}
	    		else
	    			{
	    				$j("#chk"+dataList[i].id).removeAttr("checked");
	    			}
	    		
	    		
	    	}
	    	
	    }
	    
	});
}

	

	function Reset() {	
		document.getElementById("messageId").innerHTML = "";
		$j( 'input[type="checkbox"]' ).prop('checked', false);
		$j('#rolelist').val('');
	}

	function saveRolesRight() {
	
		$j('#btnSubmit').attr("disabled", false);
		
		if (jQuery('#rolelist').find('option:selected').val() == '') {
			alert("Please select role");
			return false;
		}
		var roleId = jQuery('#rolelist').find('option:selected').val()
		//alert("role id" + roleId);

		var valCheckBox = new Array();
		var flag=true;
		$j('input:checkbox:checked').each(function(j) {			
			
			if($j('input:checkbox:checked').length >0){
				flag = false;
			}
			var params = {
				"tid" : $j(this).val(),
				"status" : 'y',

			};
			valCheckBox.push(params);

		});
		if(flag){
			alert("Please assign atleast one template");
			return;
		}
		$j("input:checkbox:not(:checked)").each(function(k) {
			
			var params = {
				"tid" : $j(this).val(),
				"status" : 'n'
			};
			valCheckBox.push(params);

		});

		
		var data = {
			"templateid" : valCheckBox,
			"roleId" : roleId,
			"userId" : <%=userId%>
			
			
		};

		//alert(JSON.stringify(data));		
		
		$j('#messageId').fadeIn();
		$("#btnSubmit").attr("disabled", true);
		$j.ajax({
			 crossOrigin: true,
			    method: "POST",
			    header:{
			    	'Access-Control-Allow-Origin': '*'
			    	},
			    	crossDomain:true,
			    url: "saveRolesRight",
			    data: JSON.stringify(data),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result)
			    {
			    	if(result.status==1){			        	
			    					    			        	      	
			        	//document.getElementById("messageId").innerHTML = result.msg;
			        	alert(result.msg);
			        	window.location.reload();
			    		//$j("#messageId").css("color", "green");
			        	
			        }
			        
			    	else if(result.status==0)
			    	{
			        	
			        	if(result.msg != undefined)
			        		{
				        		document.getElementById("messageId").innerHTML = result.msg;
				        		//$j("#messageId").css("color", "red");
				        		alert(result.msg);
				        		
					        	
			        		}
			        	if(result.err_mssg != undefined)
		        		{
			        		document.getElementById("messageId").innerHTML = result.err_mssg;
			        		$j("#messageId").css("color", "red");
			        		alert(result.msg);
			        		
		        		}
			        	
			        }
			    	
			    	else
			    	{
			        	
			        	if(result.msg != undefined)
			        		{
				        		document.getElementById("messageId").innerHTML = result.msg;
				        		$j("#messageId").css("color", "red");
					        	
			        		}
			        	if(result.err_mssg != undefined)
		        		{
			        		document.getElementById("messageId").innerHTML = result.err_mssg;
			        		$j("#messageId").css("color", "red");
				        	
		        		}
			        	
			        }
			    }
			
			
		});
		
		
		

	}

	function assignRoleTemplate(value) {
		$j('#btnSubmit').show();
		document.getElementById("messageId").innerHTML=" ";
		getAssingedTemplateNameList(value);	
		//alert("assign template" + value);		
		if(dataList.length ==0)
		{
		$j('input:checkbox').prop('checked', false);
		}
	for(i=0;i<dataList.length;i++){
		
		var tempId= $j("#chk"+dataList[i].id).val();
		if(dataList[i].id==tempId && dataList[i].status=='y' ){
			
			$j("#chk"+dataList[i].id).prop('checked', true);
			
		}
		else
			{
				$j("#chk"+dataList[i].id).prop('checked', false);
			}
		
		
	}
	}
</script>
</head>

<body>

    <!-- Begin page -->
    <div id="wrapper">
 
        <div class="content-page">
            <!-- Start content -->
            <div class="">
                <div class="container-fluid">
                    <div class="internal_Htext">Role Rights</div>
                                                  
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                             <div class="card">
                                <div class="card-body">
                                  <form>
                                
                                  <div class="row"> 
                                     <div class="col-md-4">
                                            <div class="form-group row">
                                            
                                                <label for="recordoffice" class="col-md-5 col-form-label inner_md_htext">Select Role<span class="mandate"><sup>&#9733;</sup></span></label>
                                                
                                                <div class="col-md-7">
                                                    <select class="form-control" id="rolelist" onchange="assignRoleTemplate(this.value);">                                                                    
                                                    </select>
                                                </div>
                                               
                                            </div>
                                        </div> 
                                        
                                        
                                        
                                         <div class="col-md-8">
                                             
                                        </div> 
                                  
                                   
                                
                                 <p align="center" id="messageId" style="font-weight: bold;" ></p><br>                           
							            
		                              
		                              <div class="opdMain_detail_area col-12">
		                              <h4 class="service_htext">Templates</h4>
		                              <div style="float:right">
					                     <div id="resultnavigation">
					                     </div> 
		                              </div>
		                              
		                              <div class="scrollableDiv">
		                              <table class="table table-hover table-bordered">
                                        <thead class="bg-success" style="color:#fff;">
                                        	                                            
                                        </thead>                                        
	                                     <tbody id="tblListOTemplate">											 
	                     				 </tbody>
                                   		</table> 
		                              </div>
		                              </div>                                
					   				                                
                                                                  
      						      </div>
                                        
                                            
			                                            	
								 <div class="clearfix"></div>								
											        
									       <div class="row">		 
									               <div class="col-md-12">
														<div class="btn-left-all">																 
														</div> 
														<div class="btn-right-all">
															 <button type="button" id="btnSubmit" class="btn btn-primary  " onclick="saveRolesRight()">Save</button>                                                             
                                                  
                                                                 <button type="button" class="btn btn-danger" onclick="Reset()">Reset</button> 
														</div> 
												   </div> 
								         </div> 
                                                
                                           
                                   </form>
                                        
                                </div>	                          

                                    <!-- end row -->
                          </div>	 
                                    
                                   

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

            <!-- content -->

            
     

        <!-- ============================================================== -->
        <!-- End Right content here -->
        <!-- ============================================================== -->

    </div>
    <!-- END wrapper -->

    <!-- jQuery  -->
    

</body>

</html>