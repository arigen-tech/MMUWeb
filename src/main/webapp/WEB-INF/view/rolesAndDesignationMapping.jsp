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

<script type="text/javascript" language="javascript">


var comboArrayRoles =[];
var comboArrayDesignation = [];
var $j = jQuery.noConflict();

$j(document).ready(function()
		{
	
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();		
	$j('#updateBtn').hide();	  
	$j('#roleCode').attr('readonly', false);		
		GetAllRole('ALL');	
		GetAllDesignation('ALL');
		GetRoleAndDesignationMappingList('ALL');
		});

function search(){
	if(document.getElementById('searchDesignation').value == 0){
		alert("Please Select Designation");
		return false;
	}
	nPageNo=1;
	GetRoleAndDesignationMappingList('Filter');
}

/* function searchDesignations(){
	nPageNo=1;
	GetRoleAndDesignationMappingList('Filter');
} */


function GetAllRole(MODE){
	//var url = "getAllRole";
	
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getRoleRightsList",
	    data: JSON.stringify({}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value='0'>Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		comboArrayRoles[i] = result.data[i].roleId;
	    		combo += '<option value='+result.data[i].roleId+'>' +result.data[i].roleName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);
	    		
	    		
	    	}
	    	jQuery('#selectRoles').append(combo);
	    	jQuery('#searchRole').append(combo);
	    }
	    
	});
		
}

function GetAllDesignation(MODE){
	
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getDesignationList",
	    data: JSON.stringify({'hospitalId':$j('#hospitalId').val()}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value='0'>Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		comboArrayDesignation[i] = result.data[i].designationName;
	    		combo += '<option value='+result.data[i].designationId+'>' +result.data[i].designationName+ '</option>';	    		
	    	}
	    	jQuery('#selectDesignation').append(combo);
	    	jQuery('#searchDesignation').append(combo);
	    }
	    
	});
}

function GetRoleAndDesignationMappingList(MODE){
	//var roleId = $j('#searchRole').find('option:selected').val();
	var designationId = $j('#searchDesignation').find('option:selected').val();
	var roleDesigId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo,"designationId":"", "locationId":$j('#hospitalId').val()};
			
		}
	else
		{
		
		var data = {"PN":nPageNo, "designationId":designationId, "locationId":$j('#hospitalId').val()};
		} 
	 
	var url = "getRoleAndDesignationMappingList";		
	var bClickable = true;
	GetJsonData('tblListOfRoleAndDesignation',data,url,bClickable);
}

function makeTable(jsonData)
{	
	
	var htmlTable = "";	
	var data = jsonData.count;
	
	var pageSize = 5;	
	var dataList = jsonData.data;
	
	for(i=0;i<dataList.length;i++){		
		 if(dataList[i].status == 'Y' || dataList[i].status == 'y'){
					Status='Active'						
				}else{
					Status='Inactive'
				}
		
		
			htmlTable = htmlTable+"<tr id='"+dataList[i].roleDesigId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].designationName+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].roleNames+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";			
			htmlTable = htmlTable+"</tr>";			
		}
		if(dataList.length == 0){
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";		   
		}			
	
	$j("#tblListOfRoleAndDesignation").html(htmlTable);	
	
	
}

var roleDesigId1;
var roleid;
var desigid;
var roleName;
var desigName;
var rstatus;
function executeClickEvent(roleDesigId,data)
{
	
	for(j=0;j<data.data.length;j++){
		
		if(roleDesigId == data.data[j].roleDesigId){
			roleDesigId1 = data.data[j].roleDesigId;			
			roleid = data.data[j].rolesId;			
			desigid = data.data[j].designationId;
			roleName = data.data[j].roleNames;
			desigName = data.data[j].designationName;
			rstatus = data.data[j].status;
			//alert("roleDesigId :: "+roleDesigId1+ "desigid :: "+desigid +"roleName ::"+roleName +"desigName :: "+desigName +"rstatus ::"+rstatus +"roleid :: "+roleid);
		}
	}
	var rowValue="";
	rowClick(roleDesigId,roleid,desigid, roleName, desigName, rstatus,rowValue);
}

function rowClick(roleDesigId,roleid,desigid, roleName, desigName, rstatus,rowValue){
	var roleNameVal=rowValue;
	$.each(comboArrayRoles, function(i,e){
		$("#selectRoles option[value='" + 0 + "']").prop("selected", false);
	    $("#selectRoles option[value='" + e + "']").prop("selected", false);
	});
	
	//alert("roleNameVal"+roleNameVal);
	for(var j=0; j<comboArrayRoles.length;j++){				
		
		var roleid1 = roleid.split(",");
		
		for(var l=0;l<roleid1.length;l++){
				
				if(comboArrayRoles[j] == roleid1[l]){
					
					
					roleNameVal+=comboArrayRoles[j]+"," ;
					//$j("#selectRoles ").val(comboArrayRoles[j]);
					/* $j("#selectRoles :selected").each(function(){
					     selected[$(this).val(comboArrayRoles[j])]=$(this).text();
				    });
					
					$.each(values.split(","), function(i,e){
					    $("#strings option[value='" + e + "']").prop("selected", true);
					}); */
				}
			}
		} 
		
	$.each(roleNameVal.split(","), function(i,e){
	    $("#selectRoles option[value='" + e + "']").prop("selected", true);
	});
		
	
	
	for(var j=0; j<comboArrayDesignation.length;j++){				
		
		if(comboArrayDesignation[j] == desigName){
			$j("#selectDesignation").val(desigid);
						
		}
	}
	
	if(rstatus == 'Y' || rstatus == 'y'){
		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
	    $j("#updateBtn").show();
	    $j("#btnAddRoleDesig").hide();
	}
	if(rstatus == 'N' || rstatus == 'n'){
		
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j("#updateBtn").hide();
	}
		$j('#btnAddRoleDesig').hide();
	 	$j("#btnActive").attr("disabled", false);
		 $j("#btnInActive").attr("disabled", false);
		 
			 
}





function addRoleDesignation(){
	 if(document.getElementById('selectDesignation').value=='0'){
		alert("Please Select Designation Name");
		return false;
	}
	if(document.getElementById('selectRoles').value== '0'){
		alert("Please Select Role Name");
		return false;
	} 
	
	//multiselect roles...
	 var multiselectRolesVal = $("#selectRoles").val();
	
	console.log("multiselectRolesVal:: "+multiselectRolesVal);
	
	
	url = 'saveroleAndDesignation';
	 params = {
			/* "roleId":$j('#selectRoles').find('option:selected').val(), */
			"roleId":multiselectRolesVal,
			"designationId":$j('#selectDesignation').find('option:selected').val(),
			"userId":jQuery('#userId').val(),
			"hospitalId":jQuery('#hospitalId').val()
			
	} 
	 
	SendJsonData(url,params);
	
	ResetForm();
}

function updateRoleDesignation(status){
	if(status == 'update'){
		if(document.getElementById('selectDesignation').value=='0'){
			alert("Please Select Designation Name");
			return false;
		}
		if(document.getElementById('selectRoles').value== '0'){
			alert("Please Select Role Name");
			return false;
		} 
	}else{
		if(document.getElementById('selectDesignation').value=='0'){
			alert("Please Select Designation Name");
			return false;
		}
		
	}
	
	var params = {
			 'roleDesignationId':roleDesigId1,
			 /* 'roleId':jQuery('#selectRoles').find('option:selected').val(), */
			 "roleId":$("#selectRoles").val(),
			 'designationId':jQuery('#selectDesignation').find('option:selected').val(),
			 "userId":jQuery('#userId').val(),
			 "hospitalId":jQuery('#hospitalId').val(),
			 'status':status
			 
		} 
	
	
	var url ="updateRoleAndDesignationMapping";
	SendJsonData(url,params);
	if(status == 'active'){
		$j("#updateBtn").show();
	}
	if(status == 'inactive'){
		$j("#updateBtn").hide();
	}
	if(status == 'update'){
		$j("#updateBtn").hide();
	}
	ResetForm();
}

function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetRoleAndDesignationMappingList('FILTER');
	
}
function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetRoleAndDesignationMappingList('ALL');
	
}
function ResetForm()
{	
	$j('#selectRoles').val('0');
	$j('#selectDesignation').val('0');
	$j('#searchDesignation').val('0');
	
	
}

function Reset(){
	 document.getElementById('searchRoleDesigForm').reset();
	 document.getElementById('addRoleDesigForm').reset();
	 
		 $j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddRoleDesig').show();
		$j('#updateBtn').hide();
		showAll();
	   
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
                <div class="internal_Htext">Role And Designation Mapping</div>
                    <input type="hidden"  name="userId" value=<%=userId%> id="userId" />
                    <input type="hidden"  name="hospitalId" value=<%=hospitalId%> id="hospitalId" />
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                        <div class="row">               
                                        <div class="col-md-8">
                                            <form class="form-horizontal" id="searchRoleDesigForm" name="searchRoleDesigForm" method="" role="form">
                                                <div class="form-group row">
                                                <!-- <label class="col-3 col-form-label">Designation Name<span style="color:red">*</span></label>
                                                    <div class="col-3">
                                                      <select name="searchDesignation" id="searchDesignation" class="form-control" onchange="searchDesignations();">
                                                      </select>                                                             
                                                    </div> -->
                                                
                                                    <label class="col-3 col-form-label">Designation Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                    <div class="col-3">
                                                      <select name="searchDesignation" id="searchDesignation" class="form-control"  onchange="selectDesign();">
                                                      </select>                                                            
                                                    </div>
                                                    
                                                    
                                                    
                                                    <div class="form-group row">                                                    
                                                    <div class="col-md-6">
                                                       <button type="button" class="btn  btn-primary " onclick="search();">Search</button>
                                                    </div>
                                                    </div> 
                                                </div>
                                            </form>

                                        </div>
                                        
                                        <div class="col-md-4">
                                             <div class="btn-right-all">                                      
                                                     <button type="button" class="btn  btn-primary " onclick="showAll();">Show All</button>
                                                    
                                              </div>
                                        </div>

                                    </div>
                                       
					
		
			<div style="float:left">
               
                                     <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >   <tr>
           <td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
           <td>
           
           </td>
           </tr>
         </table>
                                  </div>  
                                     <div style="float:right">
                                       <div id="resultnavigation">
                                       </div> 
                                     </div> 

                                    <table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>                                                
                                            <th id="th3" class ="inner_md_htext">Designation Name</th>
                                                <th id="th3" class ="inner_md_htext">Role Name</th>                                                
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfRoleAndDesignation">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addRoleDesigForm" name="addRoleDesigForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Designation Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                         </div>
                                                         <div class="col-md-7">
                                                            <select class="form-control" id="selectDesignation" name="selectDesignation">                                                                
                                                            </select>
                                                         </div>
                                                    </div>
                                                </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Role Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectRoles" name="selectRoles" multiple="multiple">
                                                                
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                               </div>     
                                            </form>
                                        </div>

                                    </div>
									
									<div class="row">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
												
														<button type="button" id="btnAddRoleDesig"
															class="btn  btn-primary " onclick="addRoleDesignation();">Add</button>
															
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateRoleDesignation('update');">Update</button>
															
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateRoleDesignation('active');">Activate</button>
															
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateRoleDesignation('inactive');">Deactivate</button>
															
														<button type="button" class="btn btn-danger "
															onclick="Reset();">Reset</button>
													
											</div>
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

        <!-- ============================================================== -->
        <!-- End Right content here -->
        <!-- ============================================================== -->

    </div>
    <!-- END wrapper -->

    <!-- jQuery  -->
    

</body>

</html>