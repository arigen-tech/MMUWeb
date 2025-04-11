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
			$j('#bloodGroupCode').attr('readonly', false);
			GetBloodGroupList('ALL');
		});
		
function GetBloodGroupList(MODE)
{
	
	var bloodGroupName= jQuery("#searchBloodGroup").attr("checked", true).val().toUpperCase();
	var bloodGroupId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "bloodGroupName":""};			
		}
	else
		{
		var data = {"PN":nPageNo, "bloodGroupName":bloodGroupName};
		} 
	var url = "getAllBloodGroup";
		
	var bClickable = true;
	GetJsonData('tblListOfBloodGroup',data,url,bClickable);
}

function search()
{
	if(document.getElementById('searchBloodGroup').value == ""){
 		alert("Please Enter Blood Group Name");
 		return false;
 	}
	nPageNo=1;
	GetBloodGroupList('Filter');
}
function makeTable(jsonData)
{	
	var data = jsonData;
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
		 
		
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].bloodGroupId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].bloodGroupCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].bloodGroupName+"</td>";			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";
			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	
	$j("#tblListOfBloodGroup").html(htmlTable);	
	
	
}
var comboArray = [];
var blgId;
var blgCode;
var blgName;
var blgStatus;
function executeClickEvent(bloodGroupId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(bloodGroupId == data.data[j].bloodGroupId){
			blgId = data.data[j].bloodGroupId;
			blgCode = data.data[j].bloodGroupCode;
			blgName = data.data[j].bloodGroupName;
			blgStatus = data.data[j].status;
		}
	}
	rowClick(blgId,blgCode,blgName,blgStatus);
}

function searchBloodGroupList(){
	 if(document.getElementById('searchBloodGroup').value == "" || document.getElementById('searchBloodGroup') == null){
		 alert("Plese Enter the Blood Group Name");
		 return false;
	 }
	 
	var bloodGroupName= jQuery("#searchBloodGroup").attr("checked", true).val().toUpperCase();
		
	var nPageNo=1;
	var url = "getAllBloodGroup";
	var data =  {"PN":nPageNo, "bloodGroupName":bloodGroupName};
	var bClickable = true;
	GetJsonData('tblListOfBloodGroup',data,url,bClickable);
}

function addBloodGroupDetails(){
	
	if(document.getElementById('bloodGroupCode').value=="" || document.getElementById('bloodGroupCode').value==null){
		alert("Please Enter the Blood Group Code");
		return false;
	}
	if(document.getElementById('bloodGroupName').value=="" || document.getElementById('bloodGroupName').value==null){
		alert("Please Enter the Blood Group Name");
		return false;
	}
	$('#btnAddBloodGroup').prop("disabled", true);
	var userId =  $j('#userId').val();
	var params = {
			 
			 'bloodGroupCode':jQuery('#bloodGroupCode').val(),
			 'bloodGroupName':jQuery('#bloodGroupName').val(),
			 'userId':userId
	 } 	
	    var url = "addBloodGroup";
	    SendJsonData(url,params);
}




function updateBloodGroupDetails()
{	
	if(document.getElementById('bloodGroupCode').value == "" || document.getElementById('bloodGroupCode').value == null ){
		alert("please enter the Blood Group Code");
		return false;
	}
	if(document.getElementById('bloodGroupName').value == "" || document.getElementById('bloodGroupName').value == null ){
		alert("please enter the Blood Group Name");
		return false;
	}
	var userId =  $j('#userId').val();	
	var params = {
			 'bloodGroupId':blgId,
			 'bloodGroupCode':jQuery('#bloodGroupCode').val(),
			 'bloodGroupName':jQuery('#bloodGroupName').val(),
			 'userId':userId
			 
	 } 
		    var url = "updateBloodGroupDetails";
            SendJsonData(url,params);
	         
            $j('#updateBtn').hide();
			$j('#btnAddBloodGroup').show();	
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#bloodGroupCode').attr('readonly', false);
	        ResetForm();
 		
	
	
}

function updateStatus(){
	if(document.getElementById('bloodGroupCode').value == "" || document.getElementById('bloodGroupCode').value == null ){
		alert("Please Select the BloodGroup Code");
		return false;
	}
	var userId =  $j('#userId').val();	
	 var params = {
			 'bloodGroupId':blgId,
			 'bloodGroupCode':blgCode,
			 'status':blgStatus,
			 'userId':userId
			 
		 
	}  
		    var url = "updateBloodGroupStatus";
		    SendJsonData(url,params);
		   	 
		    $j('#updateBtn').hide();
			 $j('#btnAddBloodGroup').show();	
			 $j("#btnActive").hide();
			 $j("#btnInActive").hide();
			 $j('#bloodGroupCode').attr('readonly', false);
}

function rowClick(blgId,blgCode,blgName,blgStatus){	
		
	document.getElementById("bloodGroupCode").value = blgCode;
	document.getElementById("bloodGroupName").value = blgName;
	
	if(blgStatus == 'Y' || blgStatus == 'y'){
		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#btnAddBloodGroup').hide();
		$j('#updateBtn').show();
		$j('#bloodGroupCode').attr('readonly', true);
	}
	if(blgStatus == 'N' || blgStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddBloodGroup').hide();
		$j('#bloodGroupCode').attr('readonly', true);
	}
	
	 
	
}

function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetBloodGroupList('FILTER');
	
}


function Reset(){
	document.getElementById("addBloodGroupForm").reset();
	document.getElementById("searchBloodGroupForm").reset();
	document.getElementById('searchBloodGroup').value = "";
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddBloodGroup').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	$j('#bloodGroupCode').attr('readonly', false);
	showAll();
}



function ResetForm()
{	
	$j('#bloodGroupCode').val('');
	$j('#bloodGroupName').val('');
	$j('#searchBloodGroup').val('');
	$j('#bloodGroupCode').attr('readonly', false);
}

function showAll()
{

	ResetForm();
	nPageNo = 1;	
	GetBloodGroupList('ALL');
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddBloodGroup').show();
	
}

function generateReport()
{
	var url="${pageContext.request.contextPath}/report/generateBloodGroupReport";
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
                <div class="internal_Htext">Blood Group Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchBloodGroupForm"
												name="searchBloodGroupForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Blood Group Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchBloodGroup" id="searchBloodGroup"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Blood Group Name">

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
                                    <%-- <div class="row">
                                                                     
                                        <div class="col-md-8">
                                            <form class="form-horizontal" id="searchBloodGroupForm" name="searchBloodGroupForm" method="" role="form">
                                                <div class="form-group row">
                                                    <label class="col-3 col-form-label inner_md_htext">Blood Group Name <span style="color:red">*</span> </label>
                                                    <div class="col-5">
                                                        <div class="col-auto">
                                                            <label class="sr-only" for="inlineFormInputGroup">Blood Group Name  </label>
                                                            <div class="input-group mb-2">
                                                                <!-- <div class="input-group-prepend">
                                                                    <div class="input-group-text">&#128269;</div>
                                                                </div> -->
                                                                <input type="text" name="searchBloodGroup" id="searchBloodGroup" class="form-control" id="inlineFormInputGroup" placeholder="BloodGroup Name">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-2">
                                                        <button type="button" class="btn  btn-primary" onclick="searchBloodGroupList();">Search</button>
                                                    </div>
                                                </div>
                                            </form>

                                        </div>
                                        
                                        
                                        
                                        
                                        <div class="col-md-4">
                                            <form>
                                                <div class="button-list">
                                                    <button type="button" class="btn  btn-primary btn-rounded w-md waves-effect waves-light" onclick="showAll('ALL');">Show All</button>
                                                    <button type="button" class="btn  btn-primary btn-rounded w-md waves-effect waves-light">Reports</button>

                                                </div>
                                            </form>
                                        </div>

                                    </div> --%>


					<!-- <table class="table table-striped table-hover jambo_table"> -->
                  <!--  <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >
                   <tr>
				<td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
				<td>
				<div id=resultnavigation></div>
				
				</td>
				</tr>
		</table> -->
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
                                                <th id="th2" class ="inner_md_htext">Blood Group Code</th>
                                                <th id="th3" class ="inner_md_htext">Blood Group Name</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        <!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
                                     <tbody class="clickableRow" id="tblListOfBloodGroup">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addBloodGroupForm" name="addBloodGroupForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-6">
                                                            <label for="BloodGroup Code" class=" col-form-label inner_md_htext" >Blood Group Code <span class="mandate"><sup>&#9733;</sup></span> </label>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input type="text" class="form-control" id="bloodGroupCode" name="bloodGroupCode" placeholder="Blood Group Code" onkeypress=" return validateText('bloodGroupCode',2,'Blood Group Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-6">
                                                            <label for="service" class="col-form-label inner_md_htext">Blood Group Name <span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input type="text" class="form-control" id="bloodGroupName" name="bloodGroupName" placeholder="Blood Group Name" onkeypress="return validateTextField('bloodGroupName',30,'Blood Group Name');">
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
												
														<button type="button" id="btnAddBloodGroup"
															class="btn  btn-primary " onclick="addBloodGroupDetails();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateBloodGroupDetails();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateStatus();">Deactivate</button>
														<button type="button" class="btn btn-danger "
															onclick="Reset();">Reset</button>
													
											</div>
										</div>
									</div>
										
                                   <%--  <div class="row">
                                        <div class="col-md-7">
                                        </div>
                                        <div class="col-md-5">
                                            <form>
                                                <div class="button-list">

                                                    <button type="button" id="btnAddBloodGroup" class="btn btn-primary btn-rounded w-md waves-effect waves-light" onclick="addBloodGroupDetails();">Add</button>
                                                    <button type="button" id ="updateBtn" class="btn btn-primary btn-rounded w-md waves-effect waves-light" onclick="updateBloodGroupDetails();">Update</button>
                                                    <button id="btnActive" type="button" class="btn btn-primary btn-rounded w-md waves-effect waves-light" onclick="updateStatus();">Activate</button>
                                      				<button id="btnInActive" type="button" class="btn btn-primary btn-rounded w-md waves-effect waves-light" onclick="updateStatus();">Deactivate</button>
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

