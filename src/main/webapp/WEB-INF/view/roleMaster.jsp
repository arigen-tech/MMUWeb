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
    
<%@include file="..//view/commonJavaScript.jsp" %>

<script type="text/javascript">

nPageNo=1;
var $j = jQuery.noConflict();
<% 
String userId = "1";
if (session.getAttribute("user_id") != null) {
	userId = session.getAttribute("user_id") + "";
}
%>
$j(document).ready(function()
		{
	$j("#btnActive").hide();
	$j("#btnInActive").hide();		
	$j('#updateBtn').hide();	  
	$j('#roleCode').attr('readonly', false);		
		GetAllRole('ALL');			
		});
		
function GetAllRole(MODE){
	var roleName = jQuery("#searchRole").attr("checked", true).val().toUpperCase();
	 var roleId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo,"roleName":""};			
		}
	else
		{
		var data = {"PN":nPageNo, "roleName":roleName};
		}
	var url = "getAllRole";		
	var bClickable = true;
	GetJsonData('tblListOfRole',data,url,bClickable);	 
}

function makeTable(jsonData)
{	
	var htmlTable = "";	
	var data = jsonData.count; 
	
	var pageSize = 5; 	
	var dataList = jsonData.data; 
	
	
	for(i=0;i<dataList.length;i++)
		{		
		
		 if(dataList[i].status == 'Y' || dataList[i].status == 'y')
				{
					var Status='Active'
				}
			else
				{
					var Status='Inactive'
				} 		
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].roleId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].roleCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].roleName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfRole").html(htmlTable); 	
	
}

var rId;
var rCode;
var rName;
var rStatus;

function executeClickEvent(roleId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(roleId == data.data[j].roleId){
			rId = data.data[j].roleId;			
			rCode = data.data[j].roleCode;			
			rName = data.data[j].roleName;
			rStatus = data.data[j].status;
			
			
		}
	}
	rowClick(rId,rCode,rName,rStatus);
}

function rowClick(rId,rCode,rName,rStatus){	
		
	document.getElementById("roleCode").value = rCode;
	document.getElementById("roleName").value = rName;
	
			 
	if(rStatus == 'Y' || rStatus == 'y'){		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#updateBtn').show();		
		$j('#btnAddRole').hide();
		$j('#roleCode').attr('readonly', true);
	}
	if(rStatus == 'N' || rStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddRole').hide();
		$j('#roleCode').attr('readonly', true);
	}
	
		
}


var success;
var error;

function addRoleDetails(){
	if(document.getElementById('roleCode').value == null || document.getElementById('roleCode').value == ""){
		alert("Please Enter Role Code");
		return false;
	}
	if(document.getElementById('roleName').value == null || document.getElementById('roleName').value ==""){
		alert("Please Enter Role Name");
		return false;
	}
	$('#btnAddRole').prop("disabled", true);
	var userId =  $j('#userId').val();
	var params = {			 
			 'roleCode':jQuery('#roleCode').val(),
			 'roleName':jQuery('#roleName').val(),
			'userId':<%=userId%> 
	 } 
	   var url = "addRole";
		SendJsonData(url,params);
	   ResetFrom();
}

function updateRole(){	
	if(document.getElementById('roleCode').value == null || document.getElementById('roleCode').value == ""){
		alert("Please Enter Role Code");
		return false;
	}
	if(document.getElementById('roleName').value == null || document.getElementById('roleName').value ==""){
		alert("Please Enter Role Name");
		return false;
	}
		
	var userId =  $j('#userId').val();
	var params = {
			 'roleId':rId,
			 'roleCode':jQuery('#roleCode').val(),
			 'roleName':jQuery('#roleName').val(),
			 'userId':<%=userId%>
			
	 } 
		    var url = "updateRoleDetails";
		    SendJsonData(url,params);
		
		    $j('#updateBtn').hide();
			$j('#btnAddRole').show();
			$j("#btnInActive").hide();
			Reset();
}

function updateRoleStatus(){
	if(document.getElementById('roleCode').value == null || document.getElementById('roleCode').value == ""){
		alert("Please Enter Role Code");
		return false;
	}
	if(document.getElementById('roleName').value == null || document.getElementById('roleName').value ==""){
		alert("Please Enter Role Name");
		return false;
	}
	var userId =  $j('#userId').val();
	var params = {
			'roleId':rId,
			 'roleCode':rCode,
			 'status':rStatus,
			 'userId':<%=userId%>
			 
		} 
		    var url = "updateRoleStatus";
	        SendJsonData(url,params);
	        
	        $j('#updateBtn').hide();
			$j('#btnAddRole').show();
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
}

function Reset(){
	document.getElementById("addRoleForm").reset();
	document.getElementById("searchRoleForm").reset();
	document.getElementById('searchRole').value = "";
	$j('#roleCode').attr('readonly', false);
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$('#btnAddRole').prop("disabled", false);
	//$j('#btnAddRole').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	showAll();
}



function ResetForm()
{	
	$j('#roleCode').val('');
	$j('#roleName').val('');
	$j('#searchRole').val('');
	$j('#roleCode').attr('readonly', false);
	
}

function showAll()
{ 
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddRole').show();
	ResetForm();
	nPageNo = 1;	
	GetAllRole('ALL');
	
}

 function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllRole('FILTER');
	
} 

 function search()
 {
 	if(document.getElementById('searchRole').value == ""){
  		alert("Please Enter Role Name");
  		return false;
  	}
 	nPageNo=1;
 	GetAllRole('Filter');
 }
 
 function generateReport()
 {
	 var url="${pageContext.request.contextPath}/report/generateRoleMasterReport";
	 openPdfModel(url);
 	/* document.searchRoleForm.action="${pageContext.request.contextPath}/report/generateRoleMasterReport";
 	document.searchRoleForm.method="POST";
 	document.searchRoleForm.submit();  */
 	
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
                <div class="internal_Htext">Role Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                     
                                        <div class="row">               
                                        <div class="col-md-8">
                                            <form class="form-horizontal" id="searchRoleForm" name="searchRoleForm" method="" role="form">
                                                <div class="form-group row">
                                                    <label class="col-3 col-form-label">Role Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                    <div class="col-4">                                                    
                                                               
                                                              <input type="text" name="searchRole" id="searchRole" class="form-control" id="inlineFormInputGroup" placeholder="Role Name" onkeypress="return validateText('searchRole',30,'Role Name');">
                                                             
                                                    </div>
                                                    <div class="form-group row">
                                                    
                                                    <div class="col-md-12">
                                                       <button type="button" class="btn  btn-primary " onclick="search();">Search</button>
                                                    </div>
                                                    </div>
                                                </div>
                                            </form>

                                        </div>
                                        
                                        <div class="col-md-4">
                                             <div class="btn-right-all">                                      
                                                     <button type="button" class="btn  btn-primary " onclick="showAll();">Show All</button>
                                                    <!-- <button type="button" class="btn  btn-primary " id="printReportButton"  onclick="generateReport()">Reports</button> -->
                                              </div>
                                        </div>

                                    </div>
                   
		
			<div style="float:left">
               
                                     <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >   <tr>
           <td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
           <td>
            <!-- <div id=resultnavigation></div> -->
           
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
                                                <th id="th2" class ="inner_md_htext">Role Code</th>
                                                <th id="th3" class ="inner_md_htext">Role Name</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        <!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
                                     <tbody class="clickableRow" id="tblListOfRole">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addRoleForm" name="addRoleForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Role Code" class=" col-form-label inner_md_htext" >Role Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="roleCode" name="roleCode" placeholder="Role Code" onkeypress=" return validateText('roleCode',7,'Role Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Role Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="roleName" name="roleName" placeholder="Role Name" onkeypress="return validateCommonText('roleName',30,'Role Name');" >
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
										<input type="hidden"  id="rowId" name="rowId">
										<input type="hidden" class="form-control" id="userId"
											   name="userId"  value="<%=session.getAttribute("user_id")%>">
																	
							            </div>
                                                    
                                                </div>
                                            </form>
                                        </div>

                                    </div>
									 
         							<br>
									<div class="row">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
												
														<button type="button" id="btnAddRole"
															class="btn  btn-primary " onclick="addRoleDetails();">Add</button>
															
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateRole();">Update</button>
															
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateRoleStatus();">Activate</button>
															
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateRoleStatus();">Deactivate</button>
															
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
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>