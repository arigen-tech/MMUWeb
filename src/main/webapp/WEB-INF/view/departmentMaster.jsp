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
	GetDepartmentList();
	GetAllDepartment('ALL');
			
		});
function GetAllDepartment(MODE){
	
	 var departmentName= jQuery("#searchDepartment").attr("checked", true).val().toUpperCase();			
	 var departmentId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "departmentName":""};			
		}else{
		var data = {"PN":nPageNo, "departmentName":departmentName};
		} 
	var url = "getAllDepartment";		
	var bClickable = true;
	GetJsonData('tblListOfDepartment',data,url,bClickable);	 
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
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].departmentId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].departmentCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].departmentName+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].departmentTypeName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfDepartment").html(htmlTable); 	
	
}

var comboArray =[];
var departId;
var departCode;
var departName;
var departTypeName;
var departStatus;
var departTypeId

function executeClickEvent(departmentId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(departmentId == data.data[j].departmentId){
			departId = data.data[j].departmentId;			
			departCode = data.data[j].departmentCode;			
			departName = data.data[j].departmentName;
			departTypeName = data.data[j].departmentTypeName;
			departStatus = data.data[j].status;
			departTypeId = data.data[j].departmentTypeId
			
			
		}
	}
	rowClick(departId,departCode,departName,departTypeName,departStatus,departTypeId);
}

function rowClick(departId,departCode,departName,departTypeName,departStatus, departTypeId){	
		
	document.getElementById("departmentCode").value = departCode;
	document.getElementById("departmentName").value = departName;
	
	for(var j=0; j<comboArray.length;j++){				
		
		if(comboArray[j] == departTypeName){
			
			jQuery("#sDepartmentTypeName").val(departTypeId);
		}
	}
			 
	if(departStatus == 'Y' || departStatus == 'y'){		
		$j('#departmentCode').attr("disabled", true);		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
	    $j("#updateBtn").show();
	    $j("#btnAddDepartment").hide();
	}
	if(departStatus == 'N' || departStatus == 'n'){
		$j('#departmentCode').attr("disabled", true);
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j("#updateBtn").hide();
		$j("#btnAddDepartment").hide();
	}
	
	
	
}
function GetDepartmentList(){	
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getDepartmentTypeList",
	    data: JSON.stringify({}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		comboArray[i] = result.data[i].departmentTypeName;
	    		combo += '<option value='+result.data[i].departmentTypeId+'>' +result.data[i].departmentTypeName+ '</option>';
	    		//alert("combo :: "+combo);
	    	}
	    	jQuery('#sDepartmentTypeName').append(combo);
	    }
	    
	});

 }


function searchDepartmentList(){	
	if(document.getElementById('searchDepartment').value == "" || document.getElementById('searchDepartment') == null){
		 alert("Plese Enter the Department Name");
		 return false;
	 }
		 	 
	 var departmentName= jQuery("#searchDepartment").attr("checked", true).val().toUpperCase();
		
		var nPageNo=1;
		var url = "getAllDepartment";
		var data =  {"PN":nPageNo, "departmentName":departmentName};
		var bClickable = true;
		GetJsonData('tblListOfDepartment',data,url,bClickable);	
		ResetForm();
}

function updateDepartment(){
	
	if(document.getElementById('departmentCode').value == null || document.getElementById('departmentCode').value == ""){
		alert("Please Enter Department Code");
		return false;
	}
	if(document.getElementById('departmentName').value == null || document.getElementById('departmentName').value ==""){
		alert("Please Enter Department Name");
		return false;
	}
	if(document.getElementById('sDepartmentTypeName').value == null || document.getElementById('sDepartmentTypeName').value ==""){
		alert("Please Select Department Type");
		return false;
	}
		
	var userId =  $j('#userId').val();
	var params = {
			 'departmentId':departId,
			 'departmentCode':jQuery('#departmentCode').val(),
			 'departmentName':jQuery('#departmentName').val(),
			 'departmentTypeId':jQuery('#sDepartmentTypeName').find('option:selected').val(),
			 'userId':<%=userId%>
			
	 } 
	
	var url = "updateDepartmentDetails";
	SendJsonData(url,params);
	$j("#btnInActive").hide();
	$j("#btnActive").hide();
    $j("#updateBtn").hide();
    $j("#btnAddDepartment").show();
	
		ResetForm();
}

function updateDepartmentStatus(){
	
	if(document.getElementById('departmentCode').value == null || document.getElementById('departmentCode').value == ""){
		alert("Please Enter Department Code");
		return false;
	}
	if(document.getElementById('departmentName').value == null || document.getElementById('departmentName').value ==""){
		alert("Please Enter Department Name");
		return false;
	}
	if(document.getElementById('sDepartmentTypeName').value == null || document.getElementById('sDepartmentTypeName').value ==""){
		alert("Please Select Department Type");
		return false;
	}
	var userId =  $j('#userId').val();
	var params = {
			  'departmentId':departId,
			 'departmentCode':jQuery('#departmentCode').val(),
			 'status':departStatus,
			 'userId':<%=userId%>
			 
		} 
	var url = "updateDepartmentStatus";
	SendJsonData(url,params);
	
	$j("#btnInActive").hide();
	$j("#btnActive").hide();
    $j("#updateBtn").hide();
    $j("#btnAddDepartment").show();
	
	ResetForm();
}

function addDepartmentDetails(){
	if(document.getElementById('departmentCode').value == null || document.getElementById('departmentCode').value == ""){
		alert("Please Enter Department Code");
		return false;
	}
	if(document.getElementById('departmentName').value == null || document.getElementById('departmentName').value ==""){
		alert("Please Enter Department Name");
		return false;
	}
	if(document.getElementById('sDepartmentTypeName').value == null || document.getElementById('sDepartmentTypeName').value ==""){
		alert("Please Select Department Type");
		return false;
	}
	$('#btnAddDepartment').prop("disabled", true);
	var userId =  $j('#userId').val();
	var params = {
			 
			 'departmentCode':jQuery('#departmentCode').val(),
			 'departmentName':jQuery('#departmentName').val(),
			 'departmentTypeId':jQuery('#sDepartmentTypeName').find('option:selected').val(),
			 'userId':<%=userId%>
			 			 
	 } 
	
	//alert("params: "+JSON.stringify(params)); 
	var url="addDepartment";
	SendJsonData(url,params);
	GetAllDepartment('FILTER');
		
	
}
function changeDepartType(value){
	
	var departTypeId= jQuery('#sDepartmentTypeName').find('option:selected').val()
	
	 if(value == departTypeId){
		$j('#updateBtn').attr("disabled", false);
	}	
	 
}

function Reset(){
		 $j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddDepartment').show();
		showAll();
	
}	

 function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllDepartment('FILTER');
	
} 
 
   
  function isValidLengthDeptCode(){
		
	 if(departmentCode.value.length >= 20){
		 alert("Please Enter Valid Department Code");
		 document.getElementById('departmentCode').value="";
		 return false;
	 }
}
  
  function enableAddButton(){
		if(document.getElementById("departmentCode").value!=null || !document.getElementById("departmentCode").value==""){
			$j('#btnAddDepartment').attr("disabled", false);
		}else if( document.getElementById("departmentName").value!=null || !document.getElementById("departmentName").value==""){
			$j('#btnAddDepartment').attr("disabled", false);
		}else{
			$j('#btnAddDepartment').attr("disabled", true);
		}
	}

	function validTextBox(){
		if($j('#departmentCode').val().length > 10){
			 alert("Department Code should be less than 10");
			 document.getElementById('departmentCode').value="";
			 return false;
		 }
		if($j('#departmentName').val().length > 30){
			 alert("Department Name should be less than 30");
			 document.getElementById('departmentName').value="";
			 return false;
		 }
	}

	function ResetForm()
	{
		$j('#departmentCode').val('');
		$j('#departmentName').val('');
		$j('#sDepartmentTypeName').val('');
		$j('#searchDepartment').val('');
		$j('#departmentCode').attr("disabled", false);
		
		
	}

	function showAll()
	{
		ResetForm();
		nPageNo = 1;	
		GetAllDepartment('ALL');
		
	}
 
	
	function generateReport()
	 {	
		var url="${pageContext.request.contextPath}/report/generateDepartmentReport";
		openPdfModel(url);
	 	
	 }
	function search()
	{
		if(document.getElementById('searchDepartment').value == ""){
			alert("Please Enter Department Name");
			return false;
		}
		nPageNo=1;
		GetAllDepartment('Filter');
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
                <div class="internal_Htext">Department Master</div>
                    <div class="row">
                    
                        <!-- <div class="col-12">
                            <div class="page-title-box">
                                <div class="internal_Htext">Department Master</div>

                                <ol class="breadcrumb float-right">
                                    <li class="breadcrumb-item active"><a href="#">Home</a></li>
                                     <li class="breadcrumb-item  active"><a href="#">Master</a></li>  
                                    <li class="breadcrumb-item active">Department Master</li>
                                </ol>

                                <div class="clearfix"></div>
                            </div>
                        </div> -->
                    </div>
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                      
                                    <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchDepartmentForm"
												name="searchDepartmentForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Department Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchDepartment" id="searchDepartment"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Department Name" onkeypress="return validateTextField('searchDepartment',30,'Department Name');">

													</div>
													<div class="form-group row">

														<div class="col-md-12">
															<button type="button" class="btn  btn-primary obesityWait-search"
																onclick="search()">Search</button>
														</div>
													</div>
												</div>
											</form>

										</div>
										<div class="col-md-4">
											<div class="btn-right-all">
												<button type="button" class="btn  btn-primary "
													onclick="showAll('ALL');">Show All</button>
												<!-- <button type="button" class="btn  btn-primary " id="printReportButton" 	onclick="generateReport()">Reports</button> -->
											</div>
										</div>
									</div>	                         
                                        <%-- <div class="col-md-8">
                                            <form class="form-horizontal" name="searchDepartmentForm" id="searchDepartmentForm" method="" role="form">
                                                <div class="form-group row">
                                                    <label class="col-3 col-form-label inner_md_htext">Department Name<span style="color:red">*</span></label>
                                                    <div class="col-5">
                                                        <div class="col-auto">
                                                            <label class="sr-only" for="inlineFormInputGroup">Department Name</label>
                                                            <div class="input-group mb-2">
                                                                <!-- <div class="input-group-prepend">
                                                                    <div class="input-group-text">&#128269;</div>
                                                                </div> -->
                                                                <input type="text" name="searchDepartment" id="searchDepartment" class="form-control" id="inlineFormInputGroup" placeholder="Department Name" onkeypress="return validateTextField('searchDepartment',30);">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-2">
                                                        <button id="searchBtn" type="button" class="btn  btn-primary" onclick="GetAllDepartment('FILTER');">Search</button>
                                                    </div>
                                                </div>
                                            </form>

                                        </div>
                                        
                                        
                                        
                                        
                                        <div class="col-md-4">
                                            <form>
                                                <div class="button-list">
                                                    <button type="button" class="btn  btn-primary btn-rounded w-md waves-effect waves-light" onclick="showAll('ALL');">Show All</button>
                                                    <button type="button" class="btn  btn-primary btn-rounded w-md waves-effect waves-light" onclick="generateReport()">Reports</button>

                                                </div>
                                            </form>
                                        </div>

                                    </div> --%>

                                    

					<!-- <table class="table table-striped table-hover jambo_table"> -->
                   <div style="float:left">					           
		                                    <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >			<tr>
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
                                                <th id="th2" class ="inner_md_htext">Department Code</th>
                                                <th id="th3" class ="inner_md_htext">Department Name</th>
                                                <th id="th4" class ="inner_md_htext">Department Type</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                     <tbody class="clickableRow" id="tblListOfDepartment">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addDepartmentForm" name="addDepartmentForm" action="" method="POST">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Department Code" class=" col-form-label inner_md_htext" >Department Code <span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" name="departmentCode" id="departmentCode" class="form-control" placeholder="Department Code" onkeypress="return validateText('departmentCode',7,'Department Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Department Name <span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" name="departmentName" id="departmentName" class="form-control" placeholder="Department Name" onkeypress="return validateTextField('departmentName',30,'Department Name');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Department Type<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-6">
                                                                <select class="form-control" id="sDepartmentTypeName" onchange="changeDepartType(this.value);">
                                                                    
                                                                </select>
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
												
														<button type="button" id="btnAddDepartment"
															class="btn  btn-primary " onclick="addDepartmentDetails();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateDepartment();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateDepartmentStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateDepartmentStatus();">Deactivate</button>
														<button type="button" class="btn btn-danger "
															onclick="Reset();">Reset</button>
												
											</div>
										</div>
									</div>
									
                                    <%-- <div class="row">
                                        <div class="col-md-7">
                                        </div>
                                        <div class="col-md-5">
                                            <form>
                                                <div class="button-list">

                                                    <button id="btnAddDepartment" type="button"  class="btn btn-primary btn-rounded w-md waves-effect waves-light" onclick="addDepartmentDetails();">Add</button>
                                                    <button id ="updateBtn" type="button"  class="btn btn-primary btn-rounded w-md waves-effect waves-light" onclick="updateDepartment();">Update</button>
                                                    <button id="btnActive" type="button" class="btn btn-primary btn-rounded w-md waves-effect waves-light" onclick="updateDepartmentStatus();">Activate</button>
                                      				<button id="btnInActive" type="button" class="btn btn-primary btn-rounded w-md waves-effect waves-light" onclick="updateDepartmentStatus();">DeActivate</button>
                                                    <button type="button" class="btn btn-danger btn-rounded w-md waves-effect waves-light" onclick="Reset();">Reset</button>

                                                </div>
                                            </form>
                                        </div>

                                    </div> --%>

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