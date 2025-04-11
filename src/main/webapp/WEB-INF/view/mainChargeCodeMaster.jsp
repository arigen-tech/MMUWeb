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
			$j('#mainChargecodeCode').attr('readonly', false);
			$j("#btnAddMainChargecode").show();
			GetMainChargecodeList('ALL');
			GetDepartmentList();
		});
		
function GetMainChargecodeList(MODE)
{
	var mainChargecodeName= jQuery("#searchMCC").val().toUpperCase();
			
	var mainChargecodeId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "mainChargecodeName":""};			
		}
	else
		{
		var data = {"PN":nPageNo,"mainChargecodeName":mainChargecodeName};
		} 
	var url = "getAllMainChargecode";
		
	var bClickable = true;
	GetJsonData('tblListOfMainChargecode',data,url,bClickable);
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
		 
		
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].mainChargecodeId+"' >";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].mainChargecodeCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].mainChargecodeName+"</td>";			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].departmentName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";
			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblListOfMainChargecode").html(htmlTable);	
	
	
}
var comboArray = [];
var mccId;
var mccCode;
var mccName;
var mccStatus;
var dptId;
var dptName;
function executeClickEvent(mainChargecodeId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(mainChargecodeId == data.data[j].mainChargecodeId){
			mccId = data.data[j].mainChargecodeId;
			mccCode = data.data[j].mainChargecodeCode;
			mccName = data.data[j].mainChargecodeName;
			mccStatus = data.data[j].status;
			dptId = data.data[j].departmentId;
			dptName = data.data[j].departmentName;
			
		}
	}
	rowClick(mccId,mccCode,mccName,mccStatus,dptId,dptName);
}


var success;
var error;

function addMainChargecodeDetails(){
	
	if(document.getElementById('mainChargecodeCode').value==""){
		alert("Please Enter the Main type Code");
		return false;
	}
	if(document.getElementById('mainChargecodeName').value==""){
		alert("Please Enter the Main type Name");
		return false;
	}
	if(document.getElementById('selectDepartment').value==""){
		alert("Please Select Department");
		return false;
	}
	$('#btnAddMainChargecode').prop("disabled",true);
	var params = {
			 'userId':<%=userId %>,
			 'mainChargecodeCode':jQuery('#mainChargecodeCode').val(),
			 'mainChargecodeName':jQuery('#mainChargecodeName').val(),
			 'departmentId':jQuery('#selectDepartment').find('option:selected').val()
	 } 	
	
	//alert(JSON.stringify(params));
	var url="addMainChargecode";
	    SendJsonData(url,params);
}

function updateMainChargecodeDetails()
{	
	if(document.getElementById('mainChargecodeCode').value == "" || document.getElementById('mainChargecodeCode').value == null ){
		alert("Please Enter the Main type Code");
		return false;
	}
	if(document.getElementById('mainChargecodeName').value == "" || document.getElementById('mainChargecodeName').value == null ){
		alert("Please Enter the Main type Name");
		return false;
	}
	
	if(document.getElementById('selectDepartment').value == "" || document.getElementById('selectDepartment').value == null ){
		alert("please select Department");
		return false;
	}
		
	var params = {
			 'userId':<%=userId %>,
			 'mainChargecodeId':mccId,
			 'mainChargecodeCode':jQuery('#mainChargecodeCode').val(),
			 'mainChargecodeName':jQuery('#mainChargecodeName').val(),
			 'departmentId':jQuery('#selectDepartment').find('option:selected').val()
	 } 
	
	//alert(JSON.stringify(params));
	
	var url="updateMainChargecodeDetails";
	SendJsonData(url,params);	
	GetMainChargecodeList();	 		
	
	$j('#btnAddMainChargecode').attr("disabled", false);
	$j('#mainChargecodeCode').attr('readonly', true);
	ResetFrom();
	
}

function updateStatus(){
	if(document.getElementById('mainChargecodeCode').value == "" || document.getElementById('mainChargecodeCode').value == null ){
		alert("Please Select the Main Chargecode");
		return false;
	}
	 var params = {
		 'mainChargecodeId':mccId,		 
		 'status':mccStatus		 
	}  
	 
	 //alert(JSON.stringify(params));
	 var url= "updateMainChargecodeStatus";
		    SendJsonData(url,params);
		    
		    $j("#btnActive").attr("disabled", true);
			 $j("#btnInActive").attr("disabled", true);
			 $j('#btnAddMainChargecode').attr("disabled", false);
}



function GetDepartmentList(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getDepartmentList",
	    data: JSON.stringify({}),
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
	    }
	    
	});
}

function rowClick(mccId,mccCode,mccName,mccStatus,dptId,dptName){	
	document.getElementById("mainChargecodeCode").value = mccCode;
	document.getElementById("mainChargecodeName").value = mccName;
	for(var j=0; j<comboArray.length;j++){		
		
		if(comboArray[j] == dptName){
			
			jQuery("#selectDepartment").val(dptId);
		}
	}
	
if(mccStatus == 'Y' || mccStatus == 'y'){
		
	$j("#btnInActive").show();
	$j("#btnActive").hide();
    $j("#updateBtn").show();
    $j("#btnAddMainChargecode").hide();
	}
	if(mccStatus == 'N' || mccStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j("#updateBtn").hide();
	}
	
	/* $j('#updateBtn').attr("disabled", false); */
	$j('#btnAddMainChargecode').hide();
	
	 $j("#btnActive").attr("disabled", false);
	 $j("#btnInActive").attr("disabled", false);
	 $j('#mainChargecodeCode').attr('readonly', true);
	
}

function changeDepartment(value){
	
	var departmentId = jQuery('#selectDepartment').find('option:selected').val();
	
	if(value == departmentId){
		$j('#updateBtn').attr("disabled", false);
	}
	
}
function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetMainChargecodeList('FILTER');
	
}

function Reset(){	
	document.getElementById('searchMCC').value = "";
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddMainChargecode').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	$j('#mainChargecodeCode').attr('readonly', true);
	showAll();
}


function ResetForm()
{	
	$j('#mainChargecodeCode').val('');
	$j('#mainChargecodeName').val('');
	$j('#selectDepartment').val('');
	$j('#searchMainChargecode').val('');
	
}

function showAll()
{
	$('#searchMCC').val('');
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddMainChargecode').show();
	$j('#mainChargecodeCode').attr('readonly', false);
	ResetForm();
	nPageNo = 1;	
	GetMainChargecodeList('ALL');
	
}

function enableAddButton(){
	if(document.getElementById("mainChargecodeCode").value!=null || !document.getElementById("mainChargecodeCode").value==""){
		$j('#btnAddMainChargecode').attr("disabled", false);
	}else if( document.getElementById("mainChargecodeName").value!=null || !document.getElementById("mainChargecodeName").value==""){
		$j('#btnAddMainChargecode').attr("disabled", false);
	}else{
		$j('#btnAddMainChargecode').attr("disabled", true);
	}
}

function search()
{
	if(document.getElementById('searchMCC').value == ""){
		alert("Please Enter Main Type Name");
		return false;
	}
	nPageNo=1;
	GetMainChargecodeList('Filter');
}

function generateReport()
{
	var url="${pageContext.request.contextPath}/report/generateMainTypeMasterReport";
	openPdfModel(url);
	/* document.searchMCCForm.action="${pageContext.request.contextPath}/report/generateMainTypeMasterReport";
	document.searchMCCForm.method="POST";
	document.searchMCCForm.submit();  */
	
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
                <div class="internal_Htext">Main Type Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                     
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchMCCForm"
												name="searchMCCForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Main Type Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchMCC" id="searchMCC"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Main Type Name" onkeypress="return validateText('searchRelation',30,'Main Type Name');">

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
												<!-- <button type="button" class="btn  btn-primary "
												id="printReportButton" 
													onclick="generateReport()">Reports</button> -->
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
                                                <th id="th2" class ="inner_md_htext">Main Type Code</th>
                                                <th id="th3" class ="inner_md_htext">Main Type Name</th>
                                                <th id="th4" class ="inner_md_htext"> Department </th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        <!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
                                     <tbody class="clickableRow" id="tblListOfMainChargecode">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addMainChargecodeForm" name="addMainChargecodeForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Main Chargecode Code" class=" col-form-label inner_md_htext" >Main Type Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="mainChargecodeCode" name="mainChargecodeCode" placeholder="Main Type Code" onkeypress=" return validateText('mainChargecodeCode',7,'Main Type Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Main Type Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="mainChargecodeName" name="mainChargecodeName" placeholder="Main Type Name" onkeypress="return validateText('mainChargecodeName',30,'Main Type Name')">
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
                                                </div>
                                            </form>
                                        </div>

                                    </div>
									
         							<br>
									<div class="row">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
												
														<button type="button" id="btnAddMainChargecode"
															class="btn  btn-primary " onclick="addMainChargecodeDetails();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateMainChargecodeDetails();">Update</button>
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