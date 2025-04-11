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
			$j('#subChargecodeCode').attr('readonly', false);
			GetAllSubTypeList('ALL');
			GetMainTypeList();
			
		});
		
function GetAllSubTypeList(MODE)
{
	var subtypeName= $("#searchSCC").val();
		
	var subChargecodeId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "subTypeName":""};			
		}
	else
		{
		var data = {"PN":nPageNo,"subTypeName":subtypeName};
		} 
	var url = "getAllSubTypeDetails";
		
	var bClickable = true;
	GetJsonData('tblListOfSubChargecode',data,url,bClickable);
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
		 
		
		 	htmlTable = htmlTable+"<tr id='"+dataList[i].subChargecodeId+"' >";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].subChargecodeCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].subChargecodeName+"</td>";			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].mainTypeName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";
			
			htmlTable = htmlTable+"</tr>";
			
		}
	
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblListOfSubChargecode").html(htmlTable);	
	
	
}
var comboArray = [];
var sccId;
var sccCode;
var sccName;
var sccStatus;
var mainTypeId;
var mainTypeName;
var stid;
function executeClickEvent(SubChargecodeId,data)
{
	stid=SubChargecodeId;
	
	for(j=0;j<data.data.length;j++){
		if(SubChargecodeId == data.data[j].subChargecodeId){
			sccId = data.data[j].subChargecodeId;
			sccCode = data.data[j].subChargecodeCode;
			sccName = data.data[j].subChargecodeName;
			sccStatus = data.data[j].status;
			mainTypeId = data.data[j].mainTypeId;
			mainTypeName = data.data[j].mainTypeName;
			
		}
	}
	
	//alert("sccId ::"+sccId +"sccName:: "+sccName +"sccStatus ::"+sccStatus+"mainTypeId ::"+mainTypeId+"mainTypeName ::"+mainTypeName );
	rowClick(sccId,sccCode,sccName,sccStatus,mainTypeId,mainTypeName);
}


var success;
var error;

function addSubChargecodeDetails(){
	
	if(document.getElementById('subChargecodeCode').value==""){
		alert("Please Enter the Sub Type Code");
		return false;
	}
	if(document.getElementById('subChargecodeName').value==""){
		alert("Please Enter the Sub Type Name");
		return false;
	}
	if(document.getElementById('selectMainType').value==""){
		alert("Please Select Main Type");
		return false;
	}
	var params = {
			 'userId':<%=userId %>,
			 'subTypeCode':jQuery('#subChargecodeCode').val(),
			 'subTypeName':jQuery('#subChargecodeName').val(),
			 'mainTypeId':jQuery('#selectMainType').find('option:selected').val()
	 } 	
	
	//alert(JSON.stringify(params));
	
	var url="addSubType";
	    SendJsonData(url,params);
}

function updateSubChargecodeDetails()
{	
	if(document.getElementById('subChargecodeCode').value == "" || document.getElementById('subChargecodeCode').value == null ){
		alert("please enter the Sub Type Code");
		return false;
	}
	if(document.getElementById('subChargecodeName').value == "" || document.getElementById('subChargecodeName').value == null ){
		alert("please enter the Sub Type Name");
		return false;
	}
	
	if(document.getElementById('selectMainType').value == "" || document.getElementById('selectMainType').value == null ){
		alert("please select Main Type");
		return false;
	}
	$('#btnAddSubChargecode').prop("disabled",true);	
	var params = {
			 'userId':<%=userId %>,
			 'subTypeId':sccId,
			 'subTypeCode':jQuery('#subChargecodeCode').val(),
			 'subTypeName':jQuery('#subChargecodeName').val(),
			 'mainTypeId':jQuery('#selectMainType').find('option:selected').val()
	 } 
	
	//alert(JSON.stringify(params));
	var url="updateSubTypeDetails";
	SendJsonData(url,params);	
	GetAllSubTypeList();	 		
	
	$j('#btnAddSubChargecode').attr("disabled", false);
	$j('#subChargecodeCode').attr('readonly', true);
	//ResetFrom();
	
}

function updateStatus(){
	if(document.getElementById('subChargecodeCode').value == "" || document.getElementById('subChargecodeCode').value == null ){
		alert("Please Select the sub Chargecode");
		return false;
	}
	 var params = {
		 'subTypeId':sccId,
		  'status':sccStatus
		 
	}  
	 //alert(JSON.stringify(params));
	 
	 var url= "updateSubTypeStatus";
		    SendJsonData(url,params);
		    
		    $j("#btnActive").attr("disabled", false);
			 $j("#btnInActive").attr("disabled", false);
			 $j('#btnAddSubChargecode').attr("disabled", false);
}



function GetMainTypeList(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getMainTypeList",
	    data: JSON.stringify({}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		comboArray[i] = result.data[i].departmentName;
	    		combo += '<option value='+result.data[i].mainChargecodeId+'>' +result.data[i].mainChargecodeName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);
	    		
	    		
	    	}
	    	jQuery('#selectMainType').append(combo);
	    }
	    
	});
}

function rowClick(sccId,sccCode,sccName,sccStatus,mainTypeId,mainTypeName){	
	
	document.getElementById("subChargecodeCode").value = sccCode;
	document.getElementById("subChargecodeName").value = sccName;
	$j('#subChargecodeCode').attr('readonly', true);
	$("#selectMainType").val(mainTypeId);
	
  if(sccStatus == 'Y' || sccStatus == 'y'){
		
	$j("#btnInActive").show();
	$j("#btnActive").hide();
    $j("#updateBtn").show();
    $j("#btnAddSubChargecode").hide();
	}
	if(sccStatus == 'N' || sccStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j("#updateBtn").hide();
	}
	
	
	$j('#btnAddSubChargecode').hide();	
	 $j("#btnActive").attr("disabled", false);
	 $j("#btnInActive").attr("disabled", false);
	 $j('#subChargecodeCode').attr('readonly', true);
	
}

function changeMainType(value){
	
	var mainTypeId = jQuery('#selectMainType').find('option:selected').val();
	
	if(value == mainTypeId){
		$j('#updateBtn').attr("disabled", false);
	}
	
}
function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllSubTypeList('Filter');
	
}

function Reset(){
	
	document.getElementById('searchSCC').value = "";
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddSubChargecode').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	$j('#subChargecodeCode').attr('readonly', false);
	showAll();
}


function ResetForm()
{	
	$j('#subChargecodeCode').val('');
	$j('#subChargecodeName').val('');
	$j('#selectMainType').val('');
	$j('#searchSubChargecode').val('');
	
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetAllSubTypeList('ALL');
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddSubChargecode').show();
	$j('#subChargecodeCode').attr('readonly', false);
	
}

function enableAddButton(){
	if(document.getElementById("subChargecodeCode").value!=null || !document.getElementById("subChargecodeCode").value==""){
		$j('#btnAddSubChargecode').attr("disabled", false);
	}else if( document.getElementById("subChargecodeName").value!=null || !document.getElementById("subChargecodeName").value==""){
		$j('#btnAddSubChargecode').attr("disabled", false);
	}else{
		$j('#btnAddSubChargecode').attr("disabled", true);
	}
}

function search()
{
	
	if(document.getElementById('searchSCC').value == ""){
		alert("Please Enter Sub Type Name");
		return false;
	}
	nPageNo=1;
	GetAllSubTypeList('Filter');
}

function generateReport()
{

	var url="${pageContext.request.contextPath}/report/generateSubTypeMasterReport";
	openPdfModel(url);
	/* document.searchSCCForm.action="${pageContext.request.contextPath}/report/generateSubTypeMasterReport";
	document.searchSCCForm.method="POST";
	document.searchSCCForm.submit(); */ 
	
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
                <div class="internal_Htext">Sub Type Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                     
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchSCCForm"
												name="searchSCCForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Sub Type Name <span
														style="color: red">*</span></label>
													<div class="col-4">

														<input type="text" name="searchSCC" id="searchSCC"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Sub Type Name" onkeypress="return validateText('searchSCC',30,'Sub type name');">

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
                                    
							<div style="float: left">

									<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatus" style="font-size: 15px;"
												align="left">Search Results</td>
											<td>
												<!-- <div id=resultnavigation></div> -->
											</td>
										</tr>
									</table>
								</div>
								<div style="float: right">
									<div id="resultnavigation"></div>
								</div> 
                                     
                                    <table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th id="th2" class ="inner_md_htext">Sub Type Code</th>
                                                <th id="th3" class ="inner_md_htext">Sub Type Name</th>
                                                <th id="th4" class ="inner_md_htext"> Main Type </th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        <!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
                                     <tbody class="clickableRow" id="tblListOfSubChargecode">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addSubChargecodeForm" name="addSubChargecodeForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Sub Chargecode Code" class=" col-form-label inner_md_htext" >Sub Type Code <span style="color:red">*</span> </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="subChargecodeCode" name="subChargecodeCode" placeholder="Sub Type Code" onkeypress=" return validateText('subChargecodeCode',7,'Sub type code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Sub Type Name <span style="color:red">*</span> </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="subChargecodeName" name="subChargecodeName" placeholder="Sub Type Name" onkeypress="return validateText('subChargecodeName',30,'Sub type name')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Main Type <span style="color:red">*</span> </label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectMainType" onchange="changeMainType(this.value);">
                                                                    
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
												
														<button type="button" id="btnAddSubChargecode"
															class="btn  btn-primary " onclick="addSubChargecodeDetails();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateSubChargecodeDetails();">Update</button>
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