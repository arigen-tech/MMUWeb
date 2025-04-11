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
			GetBedList('ALL');
			//GetBedStatusList();
		});
		
function GetBedList(MODE)
{
	var departmentId= jQuery("#searchDepartment").find('option:selected').val();
		
	var bedId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "departmentId":""};			
		}
	else
		{
		var data = {"PN":nPageNo,"departmentId":departmentId};
		} 
	var url = "getAllBed";
		
	var bClickable = true;
	GetJsonData('tblListOfBed',data,url,bClickable);
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
		 
		
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].bedId+"' >";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].bedNo+"</td>";	
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].departmentName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";
			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblListOfBed").html(htmlTable);	
	
	
}
var comboArray = [];
var bId;
var dpId;
var bNo;
var dpName;
var bStatus;
var bsId;
var bsName;
function executeClickEvent(bedId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(bedId == data.data[j].bedId){
			bId = data.data[j].bedId;
			bNo = data.data[j].bedNo;
			dpId = data.data[j].departmentId;
			dpName = data.data[j].departmentName;
			bStatus = data.data[j].status;
			bsId = data.data[j].bedStatusId;
			bsame = data.data[j].bedStatusName;
			
		}
	}
	rowClick(bId,bNo,dpId,dpName,bStatus,bsId,bsName);
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

function addBed(){
	
	if(document.getElementById('bedNo').value==""){
		alert("Please Enter Bed Number");
		return false;
	}
	
	if(document.getElementById('selectDepartment').value==""){
		alert("Please Select Department Name");
		return false;
	}
	/* if(document.getElementById('selectBedStatus').value==""){
		alert("Please Select Bed Status");
		return false;
	} */
	$('#btnAdd').prop("disabled",true);
	var userId =  $j('#userId').val();
	var hospitalId =  $j('#hospitalId').val();
	var params = {
			 'bedNo' : jQuery('#bedNo').val(),
			 'departmentId':jQuery('#selectDepartment').find('option:selected').val(),			 
			 'userId':userId,
			 'hospitalId':hospitalId
	 } 	
	
	var url="addBed";
	    SendJsonData(url,params);
	    ResetFrom();
}

function updateBed()
{	
	if(document.getElementById('selectDepartment').value==""){
		alert("Please Select Department");
		return false;
	}
	/* if(document.getElementById('selectBedStatus').value==""){
		alert("Please Select Bed Status");
		return false;
	} */
	var hospitalId =  $j('#hospitalId').val();
	var userId =  $j('#userId').val();	
	var params = {
			 'bedId':bId,
			 'bedNo' : jQuery('#bedNo').val(),
			 'departmentId':jQuery('#selectDepartment').find('option:selected').val(),
			 'userId':userId,			 
			 'hospitalId':hospitalId
	 } 
	var url="updateBed";
	SendJsonData(url,params);	
	GetBedList();	 		
	$j("#btnActive").hide();
	 $j("#btnInActive").hide();
	 $j("#updateBtn").hide();
	 $j('#btnAdd').show();	
	 ResetFrom();
	
}

function updateStatus(){
	var hospitalId =  $j('#hospitalId').val();
	var userId =  $j('#userId').val();	
	 var params = {
		 'bedId':bId,
		 'status':bStatus,
		 'userId':userId,
		 'hospitalId':hospitalId
		 
	}  
	 var url= "updateBedStatus";
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

function GetBedStatusList(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getAllBedStatus",
	    data: JSON.stringify({"PN":"0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var j=0;j<result.data.length;j++){
	    		comboArray[j] = result.data[j].bedStatusName;
	    		combo += '<option value='+result.data[j].bedStatusId+'>' +result.data[j].bedStatusName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);
	    	}
	    	jQuery('#selectBedStatus').append(combo);
	    }
	    
	});
}

function rowClick(bId,bNo,dpId,dpName,bStatus,bsId,bsName){	

jQuery("#bedNo").val(bNo);	
jQuery("#selectDepartment").val(dpId);
jQuery("#selectBedStatus").val(bsId);

if(bStatus == 'Y' || bStatus == 'y'){
		
	$j("#btnInActive").show();
	$j("#btnActive").hide();
    $j("#updateBtn").show();
    $j("#btnAdd").hide();
	}
if(bStatus == 'N' || bStatus == 'n'){
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

function changeBedStatus(value){
	var bedStatusId = jQuery('#selectBedStatus').find('option:selected').val();
	
	if(value == bedStatusId){
		$j('#updateBtn').attr("disabled", false);
	}
	
}
function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetBedList('FILTER');
	
}

function Reset(){
	document.getElementById("addBedForm").reset();
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
	$j('#bedNo').val('');
	$j('#selectDepartment').val('');
	$j('#selectBedStatus').val('');
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
	GetBedList('ALL');
	$j('#searchDepartment').val('');
	
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
	GetBedList('Filter');
}

 function generateReport()
{
	var url="${pageContext.request.contextPath}/report/generateBedReport";
	 openPdfModel(url)
	
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
                <div class="internal_Htext">Bed Master</div>
                    
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
										
										<div class="col-12">
				                       <div style="float:left">               
		                                     <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >   <tr>
										           <td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
										           <td>
										            <!-- <div id=resultnavigation></div> -->
										           
										           </td>
										           </tr>
										         </table>
	                                  </div>  
                                    <div style="float: right">
										<div id="resultnavigation"></div>
									</div>
									</div>
                                     
                                    <table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th id="th3" class ="inner_md_htext">Bed Number</th>
                                                <th id="th4" class ="inner_md_htext">Department Name </th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                       
	                                     <tbody id="tblListOfBed">
											 
	                     				 </tbody>
                                    </table>
                                    
                                    
                        <div class="col-md-12">
                                <form id="addBedForm" name="addBedForm" method="">

                                    <div class="row">
                                              <div class="col-md-4">
														<div class="form-group row">
															<div class="col-sm-5">
																<label for="Bed Status Code"
																	class=" col-form-label inner_md_htext">Bed Number
																	 <span class="mandate"><sup>&#9733;</sup></span>
																</label>
															</div>
															<div class="col-sm-7">
																<input type="text" class="form-control"
																	id="bedNo" name="bedNo"
																	placeholder="Bed Number"
																	onkeypress=" return validateText('bedNo',10, 'Bed Number');">
															</div>
														</div>
													</div>
                                        
                                                
                                                    
                                                     <div class="col-md-4">
                                                        <div class="form-group row">                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Department Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectDepartment" onchange="changeDepartment(this.value);">
                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Bed Status<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectBedStatus" onchange="changeBedStatus(this.value);">
                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div> -->
                                                    
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
															class="btn  btn-primary " onclick="addBed();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateBed();">Update</button>
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

