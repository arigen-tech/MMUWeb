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
			GetFWCList('ALL');
			GetMIRoomList();
		});
		
function GetFWCList(MODE)
{
	var hospitalName= jQuery("#searchFWC").val().toUpperCase();
	var hospitalFlag="";	
	var hospitalId=0;
	var hospitalParentId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "hospitalName":"","hospitalFlag":"F"};			
		}
	else
		{
		var data = {"PN":nPageNo,"hospitalName":hospitalName,"hospitalFlag":"F"};
		} 
	var url = "getAllFWCDetails";
		
	var bClickable = true;
	GetJsonData('tblListOfFWC',data,url,bClickable);
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
			htmlTable = htmlTable+"<tr id='"+dataList[i].hospitalId+"' >";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].hospitalName+"</td>";			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].ParentHospitalName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";
			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblListOfFWC").html(htmlTable);	
	
	
}
var comboArray = [];
var fId;
var fName;
var fStatus;
var miId;
var miName;
function executeClickEvent(hospitalId,data)
{
	for(j=0;j<data.data.length;j++){
		if(hospitalId == data.data[j].hospitalId){
			fId = data.data[j].hospitalId;
			fName = data.data[j].hospitalName;
			fStatus = data.data[j].status;
			miId = data.data[j].hospitalParentId;
			miName = data.data[j].ParentHospitalName;
		}
	}
	rowClick(fId,fName,fStatus,miId,miName);
}

function searchFWCList(){
	 if(document.getElementById('searchFWC').value == "" || document.getElementById('searchFWC') == null){
		 alert("Plese Enter the FWC Name");
		 return false;
	 }
	 
	var hospitalName= jQuery("#searchFWC").attr("checked", true).val().toUpperCase();
	var nPageNo=1;
	var url = "getAllFWCDetails";
	var data =  {"PN":nPageNo, "hospitalName":hospitalName};
	var bClickable = true;
	GetJsonData('tblListOfFWC',data,url,bClickable);
	
}
var success;
var error;

function addFWCDetails(){
	
	if(document.getElementById('hospitalName').value==""){
		alert("Please Enter the FWC Name");
		return false;
	}
	if(document.getElementById('selectMIRoom').value==""){
		alert("Please select MI Room");
		return false;
	}
	$('#btnAdd').prop("disabled",true);
	var params = {
			 'hospitalName':jQuery('#hospitalName').val(),
			 'hospitalId':jQuery('#selectMIRoom').find('option:selected').val(),
			 'userId':$j('#userId').val()
	 } 	
	//alert(JSON.stringify(params));
	var url="addFWC";
	    SendJsonData(url,params);
}

function updateFWCDetails()
{	
	if(document.getElementById('hospitalName').value == "" || document.getElementById('hospitalName').value == null ){
		alert("please enter the FWC Name");
		return false;
	}
	
	if(document.getElementById('selectMIRoom').value == "" || document.getElementById('selectMIRoom').value == null ){
		alert("please select MI Room");
		return false;
	}
	var userId =  $j('#userId').val();	
	var params = {
			 'hospitalId':fId,
			 'hospitalName':jQuery('#hospitalName').val(),
			 'hospitalId1':jQuery('#selectMIRoom').find('option:selected').val(),
			 'userId':userId
	 } 
	var url="updateFWCDetails";
	SendJsonData(url,params);	
	GetItemClassList();	 		
	$j('#updateBtn').hide();
	$j('#btnAdd').show();
	
}

function updateStatus(){
	if(document.getElementById('hospitalName').value == "" || document.getElementById('hospitalName').value == null ){
		alert("Please Select the FWC");
		return false;
	}
	var userId =  $j('#userId').val();
	 var params = {
		 'hospitalId':fId,		 
		 'status':fStatus		
		 
	}  
	 var url= "updateFWCStatus";
		    SendJsonData(url,params);
		    
		    $j("#btnActive").hide();
		    $j("#updateBtn").hide();
			 $j("#btnInActive").hide();
			 $j('#btnAdd').show();
}

function GetMIRoomList(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getMIRoomList",
	    data: JSON.stringify({"PN":"0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		comboArray[i] = result.data[i].hospitalName;
	    		combo += '<option value='+result.data[i].hospitalId+'>' +result.data[i].hospitalName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);
	    		
	    		
	    	}
	    	jQuery('#selectMIRoom').append(combo);
	    }
	    
	});
}

function rowClick(fId,fName,fStatus,miId,miName){	
	document.getElementById("hospitalName").value = fName;
	for(var j=0; j<comboArray.length;j++){		
		
		if(comboArray[j] == miName){
			jQuery("#selectMIRoom").val(miId);
		}
	}
	
if(fStatus == 'Y' || fStatus == 'y'){
		
	$j("#btnInActive").show();
	$j("#btnActive").hide();
    $j("#updateBtn").show();
    $j("#btnAdd").hide();
	}
	if(fStatus == 'N' || fStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j("#updateBtn").hide();
	}
	
	
	$j('#btnAdd').hide();	
	
}

	function changeSection(value){
	
	var hospitalParentId = jQuery('#selectMIRoom').find('option:selected').val();
	
	if(value == sectionId){
		$j('#updateBtn').attr("disabled", false);
	}
	
	} 
function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetFWCList('FILTER');
	
}

function Reset(){
	document.getElementById("addFWCForm").reset();
	document.getElementById("searchFWCForm").reset();
	document.getElementById('searchFWC').value = "";
	
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
	$j('#hospitalName').val('');
	$j('#selectMIRoom').val('');
	$j('#searchFWC').val('');
	
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetFWCList('ALL');
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAdd').show();
	
}

function search()
{
	if(document.getElementById('searchFWC').value == ""){
		alert("Please Enter FWC Name");
		return false;
	}
	nPageNo=1;
	GetFWCList('Filter');
}

 function generateReport()
{
	 var url="${pageContext.request.contextPath}/report/generateFWCMasterReport";
	 openPdfModel(url);
	/* document.searchFWCForm.action="${pageContext.request.contextPath}/report/generateFWCMasterReport";
	document.searchFWForm.method="POST";
	document.searchFWCForm.submit(); */ 
	
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
                <div class="internal_Htext">FWC Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       <br>
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchFWCForm"
												name="searchFWCForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">FWC Name <span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchFWC" id="searchFWC"
															class="form-control" id="inlineFormInputGroup"
															placeholder="FWC Name" onkeypress="return validateText('searchFWC',30,'FWC Name');">

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
												<button type="button" class="btn  btn-primary "
												id="printReportButton" 
													onclick="generateReport()">Reports</button>
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
                                                <th id="th3" class ="inner_md_htext">FWC Name</th>
                                                <th id="th4" class ="inner_md_htext">Parent MI Room </th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        <!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
                                     <tbody class="clickableRow" id="tblListOfFWC">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addFWCForm" name="addFWCForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">FWC Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="hospitalName" name="hospitalName" placeholder="FWC Name" onkeypress="return validateText('hospitalName',30,'FWC Name')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Parent MI Room<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectMIRoom" >
                                                                    
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
												
														<button type="button" id="btnAdd"
															class="btn  btn-primary " onclick="addFWCDetails();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateFWCDetails();">Update</button>
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

