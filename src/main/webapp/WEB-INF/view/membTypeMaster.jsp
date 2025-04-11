<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
  <%@page import="com.mmu.web.utils.HMSUtil"%>  
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
     <link href="//resources/css/icons1.css" rel="stylesheet" type="text/css" />
    
<%@include file="..//view/commonJavaScript.jsp" %>
  
<script type="text/javascript" language="javascript">
var nPageNo=1;
var Status;
var examId;
<% 
String userId = "1";
if (session.getAttribute("user_id") != null) {
	userId = session.getAttribute("user_id") + "";
}

String APPOINTMENTTYPE_ME =HMSUtil.getProperties("js_messages_en.properties", "APPOINTMENT_TYPE_CODE_ME").trim();
String APPOINTMENTTYPE_MB =HMSUtil.getProperties("js_messages_en.properties", "APPOINTMENT_TYPE_CODE_MB").trim();

%>
var $j = jQuery.noConflict();

$j(document).ready(function()
		{	
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			/* $j('#updateBtn').attr("disabled", true); */
			$j('#updateBtn').hide();
			$j("#appointmentTypeId").removeAttr("disabled");
			GetAllMEMBMaster('ALL');			
			getAppointmentTypeList();
			
		});
		
function GetAllMEMBMaster(MODE)
{
	var searchMEMB=$j("#searchMEMB").attr("checked", true).val().toUpperCase();
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo,"examName":""};			
		}
	else
		{
		var data = {"PN":nPageNo, "examName":searchMEMB};
		} 
	 
	var url = "getAllMEMBMaster";		
	var bClickable = true;
	GetJsonData('tblListOfMEMB',data,url,bClickable);
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
		 
			htmlTable = htmlTable+"<tr id='"+dataList[i].membId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].examType+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].examCode+"</td>";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].examName+"</td>";
			if(dataList[i].onlineOffline=='B'){
			htmlTable = htmlTable +"<td style='width: 150px;'>Both</td>";
			}
			else if(dataList[i].onlineOffline=='O'){
				htmlTable = htmlTable +"<td style='width: 150px;'>Online</td>";
				}
			else if(dataList[i].onlineOffline=='T'){
				htmlTable = htmlTable +"<td style='width: 150px;'>Offline</td>";
				}
			else{
				htmlTable = htmlTable +"<td style='width: 150px;'></td>";
				}
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='5'><h6>No Record Found</h6></td></tr>";
		  
		}			
	
	$j("#tblListOfMEMB").html(htmlTable);	
	
	
}
var comboArray = [];
var membId;
var examType;
var examName;
var examCode;
var examStatus;
var examTypeid;
var onlineOffline;
function executeClickEvent(membId,data)
{
	examId=membId;	
	for(j=0;j<data.data.length;j++){
		if(membId == data.data[j].membId){
			membId = data.data[j].membId;
			examType = data.data[j].examType;
			examCode = data.data[j].examCode;
			examName = data.data[j].examName;
			examStatus = data.data[j].status;	
			examTypeId = data.data[j].examTypeId;
			onlineOffline = data.data[j].onlineOffline; 
		}
		
	}
	$("#appointmentTypeId").prop("disabled", "true");
	rowClick(membId,examType,examTypeId,examCode,examName,examStatus,onlineOffline);
	
}

function getAppointmentTypeList() {

	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.request.contextPath}/registration/getAppointmentTypeList",
	    data: JSON.stringify({}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	
	    	var combo = "<option value=''>Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		comboArray[i] = result.data[i].appointmentType;	
	    		if(result.data[i].appointmentTypeCode=='<%=APPOINTMENTTYPE_ME%>' || result.data[i].appointmentTypeCode=='<%=APPOINTMENTTYPE_MB%>' ){
	    		combo += '<option value='+result.data[i].id+'>' +result.data[i].appointmentType+ '</option>';    		
	    		}
	    	}	    
	    	jQuery('#appointmentTypeId').append(combo);
	    }
	    
	});
}

function addMEMBMaster(){	
	
	 if(document.getElementById('appointmentTypeId').value=="" || document.getElementById('appointmentTypeId').value==null){
		alert("Please select Exam/Board Type");
		return false;
	}

		if(document.getElementById('examCode').value=="" || document.getElementById('examCode').value==null){
			alert("Please Enter the Exam/Board Code");
			return false;
		}
		
	if(document.getElementById('examName').value=="" || document.getElementById('examName').value==null){
		alert("Please Enter the Exam/Board Name");
		return false;
	}
	if(document.getElementById('onoffId').value=="" || document.getElementById('onoffId').value==null){
		alert("Please select Online/Offline");
		return false;
	}
	$('#btnAddMEMB').prop("disabled",true);
	var params = {	
			'examCode':jQuery('#examCode').val(),
			 'examName':jQuery('#examName').val(),
			 'appointmentTypeId':jQuery('#appointmentTypeId').find('option:selected').val(),
			 'userId':<%=userId%>,
			 'onlineOffline' : jQuery('#onoffId').find('option:selected').val()
	 } 	
	//alert("params: "+JSON.stringify(params));
	var url="addMEMBMaster";
	
	SendJsonData(url,params);
	
	ResetForm();	
	
}


function updateMEMBDetails()
{	
	$j('#messageId').fadeIn();	
	
	 if(document.getElementById('appointmentTypeId').value=="" || document.getElementById('appointmentTypeId').value==null){
			alert("Please select Exam/Board Type");
			return false;
		}
	 
	 if(document.getElementById('examCode').value=="" || document.getElementById('examCode').value==null){
			alert("Please Enter the Exam/Board Code");
			return false;
		}
	 
		if(document.getElementById('examName').value=="" || document.getElementById('examName').value==null){
			alert("Please Enter the Exam/Board Name");
			return false;
		}
		if(document.getElementById('onoffId').value=="" || document.getElementById('onoffId').value==null){
			alert("Please select Online/Offline");
			return false;
		}
		
	var params = {
			'membId':examId,
			'examCode':jQuery('#examCode').val(),
			  'examName':jQuery('#examName').val(),	
			 'appointmentTypeId':jQuery('#appointmentTypeId').find('option:selected').val(),
			 'userId':<%=userId%>,
			 'onlineOffline' : jQuery('#onoffId').find('option:selected').val()
			 
	 } 
	//alert(JSON.stringify(params));
	var url="updateMEMBMasterDetails";
	SendJsonData(url,params);	

	  $j("#updateBtn").hide();
	 $j("#btnAddMEMB").show();
	 $j("#btnActive").hide();
	 $j("#btnInActive").hide(); 
	 $j('#appointmentTypeId').val('');
	 $j("#appointmentTypeId").removeAttr("disabled");
	
	
}

function updateStatus(){
	if(document.getElementById('appointmentTypeId').value==""){
		alert("Please Select the Appointment Type");
		return false;
	}
	if(document.getElementById('examName').value==""){
		alert("Please Enter the Exam/Board Name");
		return false;
	}
	
	$j('#messageId').fadeIn();		
	 var params = {
		 'examId':examId,		 
		 'status':examStatus
		 
	}  
	 //alert("params: "+JSON.stringify(params));
	 var url="updateMEMBStatus";
	 SendJsonData(url,params);	 	
	 
	 
	  $j("#updateBtn").hide();
	 $j("#btnAddMEMB").show();
	 $j("#btnActive").hide();
	 $j("#btnInActive").hide();  
	 $j('#appointmentTypeId').val('');	 
	 $j("#appointmentTypeId").removeAttr("disabled");
	 ResetForm();
}


function rowClick(membId,examType,examTypeId,examCode,examName,examStatus,onlineOffline){
	
	document.getElementById("examCode").value = examCode;
	document.getElementById("examName").value = examName;
	document.getElementById("onoffId").value = onlineOffline;
	jQuery("#appointmentTypeId").val(examTypeId);
	if(examStatus == 'Y' || examStatus == 'y'){
		
		$j("#btnInActive").show();
		$j("#btnActive").hide();		
		$j("#updateBtn").show();
		$j("#btnAddMEMB").hide();
	}
	if(examStatus == 'N' || examStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j("#updateBtn").hide();
		$j("#btnAddMEMB").hide();
		
	}
 
}


function showResultPage(pageNo)
{

	nPageNo = pageNo;	
	GetAllMEMBMaster('FILTER');
	
}


function Reset(){
	document.getElementById("searchMEMB").value="";	
	document.getElementById('examName').value = "";
	document.getElementById('examCode').value = "";
	document.getElementById('onoffId').value = "";
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddMEMB').show();
	$j('#appointmentTypeId').val('');
	$j("#appointmentTypeId").removeAttr("disabled");
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");	
	showAll();
}


function ResetForm()
{	
	$j('#examName').val('');
	$j('#examCode').val('');
	$j('#searchMEMB').val('');
	$j('#appointmentTypeId').val('');
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddMEMB').show();
	$j("#appointmentTypeId").removeAttr("disabled");
	
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetAllMEMBMaster('ALL');
	
}

function search()
{
	if(document.getElementById('searchMEMB').value == ""){
		alert("Please Enter Exam/Board Name");
		return false;
	}
	nPageNo=1;
	GetAllMEMBMaster('Filter');
}

function generateReport()
{
	var url="${pageContext.request.contextPath}/report/generateMeMbTypeMasterReport";
	openPdfModel(url);

	/* document.searchMEMBForm.action="${pageContext.request.contextPath}/report/generateMeMbTypeMasterReport";
	document.searchMEMBForm.method="POST";
	document.searchMEMBForm.submit();  */
	
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
                <div class="internal_Htext">ME/MB Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="font-weight: bold;" ></p>
                                   
									<div class="row">
										<div class="col-md-8">
											<form class="form-horizontal" id="searchMEMBForm"
												name="searchMEMBForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Exam/Board Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchMEMB" id="searchMEMB"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Exam/Board Name"
															onkeypress="return validateText('searchMEMB',20,'Exam Name');">

													</div>
													<div class="form-group row">

														<div class="col-md-12">
															<button type="button" class="btn  btn-primary "
																onclick="search();">Search</button>
														</div>
													</div>
												</div>
											</form>

										</div>

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




									<!-- <table class="table table-striped table-hover jambo_table"> -->
					
					
					                  <div style="float:left">					           
		                                    <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >			<tr>
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
                                                <th id="th2" class ="inner_md_htext">Exam/Board Type</th>
                                                <th id="th3" class ="inner_md_htext">Exam/Board Code</th>
                                                <th id="th3" class ="inner_md_htext">Exam/Board Name</th>
                                                <th id="th4" class ="inner_md_htext">Online/Offline</th>                                                
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        <!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
                                     <tbody class="clickableRow" id="tblListOfMEMB">
										 
                     				 </tbody>
                                    </table>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addMEMBMasterForm" name="addMEMBMasterForm" method="">
                                                <div class="row">
                                                <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-md-5 col-form-label inner_md_htext">Exam/Board Type<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="appointmentTypeId" name="appointmentTypeId">
                                                                
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-md-5">
                                                            <label for="Region Code" class=" col-form-label inner_md_htext" >Exam/Board Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-md-7">
                                                                <input type="text" class="form-control" id="examCode" name="examCode" placeholder="Exam Code" onkeypress="return validateText('examCode',10,'Exam Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-md-5">
                                                            <label for="Region Code" class=" col-form-label inner_md_htext" >Exam/Board Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-md-7">
                                                                <input type="text" class="form-control" id="examName" name="examName" placeholder="Exam name" onkeypress="return validateText('examName',20,'Exam Name');">
                                                            </div>
                                                        </div>
                                                    </div>            
                                                     <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-md-5 col-form-label inner_md_htext">Online/Offline<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="onoffId" name="onoffId">
                                                                <option value="">Select</option>
                                                                <option value="B" selected="selected">Both</option>
                                                                <option value="O">Online</option>
                                                                <option value="T">Offline</option>
                                                                </select>
                                                            </div>
                                                        </div>
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
												 
														<button type="button" id="btnAddMEMB"
															class="btn  btn-primary " onclick="addMEMBMaster();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateMEMBDetails();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateStatus();">Deactivate</button>
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