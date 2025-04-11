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
    <title>Mobile Medical Unit- MMSSY</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    
<%@include file="..//view/commonJavaScript.jsp" %>

<script type="text/javascript" language="javascript">
var nPageNo=1;
var Status;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{	
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			//$j('#sectionCode').attr('readonly', false);
			GetDepartmentList();
			GetDNDList('ALL');
			GetDoctorList();
		});
		
function GetDNDList(MODE)
{
	var departmentId= jQuery("#searchDepartment").find('option:selected').val();
	var hospitalId =  $j('#hospitalId').val();	
	var doctorMapId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "departmentId":"","hospitalId" : hospitalId};			
		}
	else
		{
		var data = {"PN":nPageNo,"departmentId":departmentId,"hospitalId" : hospitalId};
		} 
	var url = "getAllDepartmentAndDoctorMapping";
		
	var bClickable = true;
	GetJsonData('tblListOfDND',data,url,bClickable);
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
					Status='Active'
						
				}
			else
				{
					Status='Inactive'
				}
		 
		
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].doctorMapId+"' >";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].departmentName+"</td>";			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].firstName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";
			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='3'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblListOfDND").html(htmlTable);	
	
	
}
var comboArray = [];
var mapId;
var dpId;
var dpName;
var dndStatus;
var docId;
var docName;
function executeClickEvent(doctorMapId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(doctorMapId == data.data[j].doctorMapId){
			mapId = data.data[j].doctorMapId;
			dpId = data.data[j].departmentId;
			dpName = data.data[j].departmentName;
			dndStatus = data.data[j].status;
			docId = data.data[j].doctorId;
			docName = data.data[j].firstName;
			
		}
	}
	rowClick(mapId,dpId,dpName,dndStatus,docId,docName);
}

/* function searchSectionList(){
	 if(document.getElementById('searchSection').value == "" || document.getElementById('searchSection') == null){
		 alert("Plese Enter the Section Name");
		 return false;
	 }
	 
	var SectionName= jQuery("#searchSection").attr("checked", true).val().toUpperCase();
	var nPageNo=1;
	var url = "getAllSectionDetails";
	var data =  {"PN":nPageNo, "sectionName":sectionName};
	var bClickable = true;
	GetJsonData('tblListOfSection',data,url,bClickable);
	ResetFrom();
} */
var success;
var error;

function addDepartmentAndDoctor(){
	
	if(document.getElementById('selectDepartment').value==""){
		alert("Please Select Department Name");
		return false;
	}
	if(document.getElementById('selectDoctor').value==""){
		alert("Please Select Doctor Name");
		return false;
	}
	$('#btnAdd').prop("disabled",true);
	var userId =  $j('#userId').val();
	var hospitalId =  $j('#hospitalId').val();
	var params = {
			
			 'departmentId':jQuery('#selectDepartment').find('option:selected').val(),
			 'doctorId':jQuery('#selectDoctor').find('option:selected').val(),
			 'userId':userId,
			 'hospitalId':hospitalId
	 } 	
	
	var url="addDepartmentAndDoctorMapping";
	    SendJsonData(url,params);
}

function updateDepartmentAndDoctor()
{	
	if(document.getElementById('selectDepartment').value==""){
		alert("Please Select Department");
		return false;
	}
	if(document.getElementById('selectDoctor').value==""){
		alert("Please Select Doctor");
		return false;
	}
	var hospitalId =  $j('#hospitalId').val();
	var userId =  $j('#userId').val();	
	var params = {
			 'doctorMapId':mapId,
			 'departmentId':jQuery('#selectDepartment').find('option:selected').val(),
			 'doctorId':jQuery('#selectDoctor').find('option:selected').val(),
			 'userId':userId,
			 'hospitalId':hospitalId
	 } 
	var url="updateDepartmentAndDoctorMapping";
	SendJsonData(url,params);	
	GetDNDList();	 		
	$j("#btnActive").hide();
	 $j("#btnInActive").hide();
	 $j("#updateBtn").hide();
	 $j('#btnAdd').show();	
	Reset();
	
}

function updateStatus(){
	var hospitalId =  $j('#hospitalId').val();
	var userId =  $j('#userId').val();	
	 var params = {
		 'doctorMapId':mapId,
		 'status':dndStatus,
		 'userId':userId,
		 'hospitalId':hospitalId
		 
	}  
	 var url= "updateDepartmentAndDoctorMappingStatus";
		    SendJsonData(url,params);
		    
		     $j("#btnActive").hide();
			 $j("#btnInActive").hide();
			 $j("#updateBtn").hide();
			 $j('#btnAdd').show();
}



function GetDepartmentList(){
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "getAllDepartment",
		    data: JSON.stringify({"PN":"0"}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	//alert("success "+result.data.length);
		    	var combo = "<option value=\"\">Select</option>" ;
		    	
		    	for(var i=0;i<result.data.length;i++){
		    		comboArray[i] = result.data[i].departmentName;
		    		combo += '<option value='+result.data[i].departmentId+'>' +result.data[i].departmentName+ '</option>';
		    		//alert("combo :: "+comboArray[i]);	
		    	}
	    	jQuery('#selectDepartment').append(combo);
	    	jQuery('#searchDepartment').append(combo);
	    }
	    
	});
}

function GetDoctorList(){
	var hospitalId =  $j('#hospitalId').val();
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getAllUsers",
	    data: JSON.stringify({"PN":"0","hospitalId" : hospitalId}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var j=0;j<result.data.length;j++){
	    		comboArray[j] = result.data[j].firstName;
	    		combo += '<option value='+result.data[j].userId+'>' +result.data[j].firstName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);
	    	}
	    	jQuery('#selectDoctor').append(combo);
	    }
	    
	});
}

function rowClick(mapId,dpId,dpName,dndStatus,docId,docName){	
	
jQuery("#selectDepartment").val(dpId);
jQuery("#selectDoctor").val(docId);

if(dndStatus == 'Y' || dndStatus == 'y'){
		
	$j("#btnInActive").show();
	$j("#btnActive").hide();
    $j("#updateBtn").show();
    $j("#btnAdd").hide();
	}
if(dndStatus == 'N' || dndStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j("#updateBtn").hide();
		$j("#btnAdd").hide();
	}
	
	
	
}

 function changeDepartment(value){
	var departmentId = jQuery('#selectDepartment').find('option:selected').val();
	
	if(value == departmentId){
		$j('#updateBtn').attr("disabled", false);
	}
	
} 

function changeDoctor(value){
	var doctorId = jQuery('#selectDoctor').find('option:selected').val();
	
	if(value == doctorId){
		$j('#updateBtn').attr("disabled", false);
	}
	
}
function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetDNDList('FILTER');
	
}

function Reset(){
	document.getElementById("addDepartmentAndDoctorForm").reset();
	document.getElementById("searchDepartmentForm").reset();
	document.getElementById('searchDepartment').value = "";
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAdd').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	showAll();
}



function ResetForm()
{	
	$j('#selectDepartment').val('');
	$j('#selectDoctor').val('');
	$j('#searchDepartment').val('');
	
	
}

function showAll()
{
	
	ResetForm();
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAdd').show();
	nPageNo = 1;	
	GetDNDList('ALL');
	
}

/* function enableAddButton(){
	if(document.getElementById("sectionCode").value!=null || !document.getElementById("sectionCode").value==""){
		$j('#btnAddSection').attr("disabled", false);
	}else if( document.getElementById("sectionName").value!=null || !document.getElementById("sectionName").value==""){
		$j('#btnAddSection').attr("disabled", false);
	}else{
		$j('#btnAddSection').attr("disabled", true);
	}
}
 */
function search()
{
	if(document.getElementById('searchDepartment').value == ""){
		alert("Please Select Department Name");
		return false;
	}
	nPageNo=1;
	GetDNDList('Filter');
}

 function generateReport()
 {
 	 var hospitalId=$j('#hospitalId').val();
 	var url="${pageContext.request.contextPath}/report/generateDepartmentDoctorMappingReport"; 
 	 openPdfModel(url);

	
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
                <div class="internal_Htext">Department And Doctor Mapping  Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                           <div class="col-12">
											<form class="form-horizontal" id="searchDepartmentForm"
												name="searchDepartmentForm" >
												<div class="row">
													<div class="col-md-4">
                                                        <div class="form-group row">                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Department Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="searchDepartment" onchange=" ">                                                                    
                                                                </select>                                                                
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
													<div class="form-group row">

														<div class="col-md-12">
															<button type="button" class="btn  btn-primary obesityWait-search"
																onclick="search()">Search</button>
														</div>
													</div>
													</div>
												
											</form>

										<div class="col-md-4">
											<div class="btn-right-all">
												<button type="button" class="btn  btn-primary "
													onclick="showAll('ALL');">Show All</button>
												<button type="button" class="btn  btn-primary "
												id="printReportButton" 
													onclick="generateReport()">Reports</button>
											</div>
										</div>
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
                                                <th id="th3" class ="inner_md_htext">Department Name</th>
                                                <th id="th4" class ="inner_md_htext">Doctor Name </th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                       
                                     <tbody id="tblListOfDND">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addDepartmentAndDoctorForm" name="addDepartmentAndDoctorForm" method="">
                                                <div class="row">
                                                    
                                                     <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Department Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectDepartment" onchange="changeDepartment(this.value);">
                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Doctor Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectDoctor" onchange="changeDoctor(this.value);">
                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
										<input type="hidden"  id="rowId" name="rowId">
										<input type="hidden" class="form-control" id="userId"
											   name="userId"  value="<%=session.getAttribute("user_id")%>">
																	
							            </div>
							            
							            <div class="col-md-4">
										<input type="hidden"  id="rowId" name="rowId">
										<input type="hidden" class="form-control" id="hospitalId"
											   name="hospitalId"  value="<%=session.getAttribute("hospital_id")%>">
																	
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
												
														<button type="button" id="btnAdd"
															class="btn  btn-primary " onclick="addDepartmentAndDoctor();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateDepartmentAndDoctor();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateStatus();">Deactivate</button>
														<button type="button" class="btn btn-danger "
															onclick="Reset();">Reset</button>
													
											</div>
										</div>
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