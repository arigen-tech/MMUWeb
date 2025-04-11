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
  
<script type="text/javascript">
nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();	  
	$j('#appointmentTypeCode').attr('readonly', false);		
	GetAllAppointmentType('ALL');
			
		});
function GetAllAppointmentType(MODE){
	var appointmentTypeName = jQuery("#searchAppointment").attr("checked", true).val().toUpperCase();
	 var appointmentTypeId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo,"appointmentTypeName":""};			
		}
	else
		{
		var data = {"PN":nPageNo, "appointmentTypeName":appointmentTypeName};
		} 
	var url = "getAllAppointmentType";		
	var bClickable = true;
	GetJsonData('tblListOfAppointmentType',data,url,bClickable);	 
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
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].appointmentTypeId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].appointmentTypeCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].appointmentTypeName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfAppointmentType").html(htmlTable); 	
	
}

var appTypeId;
var appTypeCode;
var appTypeName;
var appTypeStatus;

function executeClickEvent(appointmentTypeId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(appointmentTypeId == data.data[j].appointmentTypeId){
			appTypeId = data.data[j].appointmentTypeId;			
			appTypeCode = data.data[j].appointmentTypeCode;			
			appTypeName = data.data[j].appointmentTypeName;
			appTypeStatus = data.data[j].status;
			
			
		}
	}
	rowClick(appTypeId,appTypeCode,appTypeName,appTypeStatus);
}

function rowClick(appTypeId,appTypeCode,appTypeName,appTypeStatus){	
		
	document.getElementById("appointmentTypeCode").value = appTypeCode;
	document.getElementById("appointmentTypeName").value = appTypeName;
	
			 
	if(appTypeStatus == 'Y' || appTypeStatus == 'y'){		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#updateBtn').show();
		$j('#btnAddAppointmentType').hide();		
		$j('#appointmentTypeCode').attr('readonly', true);
	}
	if(appTypeStatus == 'N' || appTypeStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddAppointmentType').hide();
		$j('#appointmentTypeCode').attr('readonly', true);
	}
	
}




function updateAppointmentType(){
	
	if(document.getElementById('appointmentTypeCode').value == null || document.getElementById('appointmentTypeCode').value == ""){
		alert("Please Enter Appointment Type Code");
		return false;
	}
	if(document.getElementById('appointmentTypeName').value == null || document.getElementById('appointmentTypeName').value ==""){
		alert("Please Enter Appointment Type Name");
		return false;
	}
		
	var userId =  $j('#userId').val();
	var params = {
			 'appointmentTypeId':appTypeId,
			 'appointmentTypeCode':jQuery('#appointmentTypeCode').val(),
			 'appointmentTypeName':jQuery('#appointmentTypeName').val(),
			 'userId':userId
			
	 } 
	var url="updateAppointmentTypeDetails";	
	SendJsonData(url,params);
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j("#updateBtn").hide();
	$j('#btnAddAppointmentType').show();
	$j('#appointmentTypeCode').attr('readonly', false);
		
		
		ResetForm();
}

function updateAppointmentTypeStatus(){
	
	if(document.getElementById('appointmentTypeCode').value == null || document.getElementById('appointmentTypeCode').value == ""){
		alert("Please Enter Appointment Type Code");
		return false;
	}
	if(document.getElementById('appointmentTypeName').value == null || document.getElementById('appointmentTypeName').value ==""){
		alert("Please Enter Appointment Type Name");
		return false;
	}
	var userId =  $j('#userId').val();
	var params = {
			'appointmentTypeId':appTypeId,
			 'appointmentTypeCode':jQuery('#appointmentTypeCode').val(),
			 'status':appTypeStatus,
			 'userId':userId
			 
		} 
	var url="updateAppointmentTypeStatus";	
	SendJsonData(url,params);
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j("#updateBtn").hide();
	$j('#btnAddAppointmentType').show();
	$j('#appointmentTypeCode').attr('readonly', false);	
	ResetForm();
}

function addAppointmentTypeDetails(){
	
	if(document.getElementById('appointmentTypeCode').value == null || document.getElementById('appointmentTypeCode').value == ""){
		alert("Please Enter Appointment Type Code");
		return false;
	}
	if(document.getElementById('appointmentTypeName').value == null || document.getElementById('appointmentTypeName').value ==""){
		alert("Please Enter Appointment Type Name");
		return false;
	}
	$('#btnAddAppointmentType').prop("disabled", true);
	var userId =  $j('#userId').val();
	var params = {			 
			 'appointmentTypeCode':jQuery('#appointmentTypeCode').val(),
			 'appointmentTypeName':jQuery('#appointmentTypeName').val(),
			 'userId':userId
	 } 
	var url="addAppointmentType";	
	SendJsonData(url,params);
		
}

function Reset(){
	document.getElementById("searchAppointmentTypeForm").reset();
	document.getElementById("addAppointmentTypeForm").reset();
	$j('#appointmentTypeCode').attr('readonly', false);
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddAppointmentType').show();
	showAll();
}	

function enableAddButton(){
	if(document.getElementById("appointmentTypeCode").value!=null || !document.getElementById("appointmentTypeCode").value==""){
		$j('#btnAddAppointmentType').attr("disabled", false);
	}else if( document.getElementById("appointmentTypeName").value!=null || !document.getElementById("appointmentTypeName").value==""){
		$j('#btnAddAppointmentType').attr("disabled", false);
	}else{
		$j('#btnAddAppointmentType').attr("disabled", true);
	}
}

function validTextBox(){
	if($j('#appointmentTypeCode').val().length >20){
		 alert("AppointmentType Code should be equal to 20");
		 document.getElementById('appointmentTypeCode').value="";
		 return false;
	 }
	if($j('#appointmentTypeName').val().length >40){
		 alert("Appointment Type Name should be equal to 40");
		 document.getElementById('appointmentTypeName').value="";
		 return false;
	 }
}

function ResetForm()
{
	$j('#appointmentTypeCode').val('');
	$j('#appointmentTypeName').val('');
	$j('#searchAppointment').val('');
	$j('#appointmentTypeCode').attr('readonly', false);
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddAppointmentType').show();
	
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetAllAppointmentType('ALL');
	
}

 function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllAppointmentType('FILTER');
	
} 
 
 function search()
 {
 	if(document.getElementById('searchAppointment').value == ""){
  		alert("Please Enter Appointment Type Name");
  		return false;
  	}
 	nPageNo=1;
 	GetAllAppointmentType('Filter');
 }
 function generateReport()
 {	
	 var url="${pageContext.request.contextPath}/report/generateAppointmentTypeReport";
	 openPdfModel(url)
 	
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
                <div class="internal_Htext">Appointment Type Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                        <div class="row">               
                                        <div class="col-md-8">
                                            <form class="form-horizontal" id="searchAppointmentTypeForm" name="searchAppointmentTypeForm" method="" role="form">
                                                <div class="form-group row">
                                                    <label class="col-4 col-form-label">Appointment Type Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                    <div class="col-4">                                                    
                                                               
                                                              <input type="text" name="searchAppointment" id="searchAppointment" class="form-control" id="inlineFormInputGroup" placeholder="Appointment Type Name" onkeypress="return validateText('searchAppointment',30,'Appointment Type Name');">
                                                             
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
                                                    <button type="button" class="btn  btn-primary " 
                                                    id="printReportButton" 
                                                    onclick="generateReport()">Reports</button>
                                              </div>
                                        </div>

                                    </div> 
                                       
                                   

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
                                                <th id="th2" class ="inner_md_htext">Appointment Type Code</th>
                                                <th id="th3" class ="inner_md_htext">Appointment Type Name</th>
                                                <th id="th4" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                     <tbody class="clickableRow" id="tblListOfAppointmentType">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addAppointmentTypeForm" name="addAppointmentTypeForm" action="" method="POST">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-6">
                                                            <label for="Appointment Type Code" class=" col-form-label inner_md_htext" >Appointment Type Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input type="text" name="appointmentTypeCode" id="appointmentTypeCode" class="form-control" placeholder="Appointment Type Code" onkeypress="return validateText('appointmentTypeCode',7,'Appointment Type Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-5">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Appointment Type Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-5">
                                                                <input type="text" name="appointmentTypeName" id="appointmentTypeName" class="form-control" placeholder="Appointment Type Name" onkeypress="return validateText('appointmentTypeName',30,'Appointment Type Name');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                   
                                                   <div class="col-md-3">
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
												
														<button type="button" id="btnAddAppointmentType"
															class="btn  btn-primary " onclick="addAppointmentTypeDetails();">Add</button>
															
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateAppointmentType();">Update</button>
															
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateAppointmentTypeStatus();">Activate</button>
															
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateAppointmentTypeStatus();">Deactivate</button>
															
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