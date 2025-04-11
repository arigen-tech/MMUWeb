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

/* var thisRow; */

$j(document).ready(function()
		{
	$j("#btnActive").hide();
	$j("#btnInActive").hide();		
	/* $j('#updateBtn').attr("disabled", true); */
	$j('#updateBtn').hide();
			
			GetAllRelation('ALL');
			
		});
		
function GetAllRelation(MODE){
	
	 var relationName= jQuery("#searchRelation").attr("checked", true).val().toUpperCase();
	 
	 var relationId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "relationName":""};			
		}else{
		var data = {"PN":nPageNo, "relationName":relationName};
		} 
	var url = "getAllRelation";		
	var bClickable = false;
	GetJsonData('tblListOfRelation',data,url,bClickable);
	
	
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
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].relationId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].relationCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].relationName+"</td>";			 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='5'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfRelation").html(htmlTable); 	
	
	
	
}

var relId;
var relCode;
var relName;
var newRelCode;
var newRelName;
var relStatus;

function executeClickEvent(relationId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(relationId == data.data[j].relationId){
			relId = data.data[j].relationId;
			relCode = data.data[j].relationCode;			
			relName = data.data[j].relationName;
			newRelCode = data.data[j].newRelationCode;
			newRelName = data.data[j].newRelationName;
			relStatus = data.data[j].status;
			
			
		}
	}
	rowClick(relId,relCode,relName,newRelCode, newRelName, relStatus);
	
}

function rowClick(relId,relCode,relName,newRelCode, newRelName, relStatus){	
		
	document.getElementById("relationCode").value = relCode;
	document.getElementById("relationName").value = relName;
	document.getElementById("newRelationCode").value = newRelCode;
	document.getElementById("newRelationName").value = newRelName;
		
	 
	if(relStatus == 'Y' || relStatus == 'y'){		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
	    $j("#updateBtn").show();
	    $j("#btnAddRelation").hide();
	}
	if(relStatus == 'N' || relStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j("#updateBtn").hide();
	}
	
	$j("#btnActive").attr("disabled", false);
	$j("#btnInActive").attr("disabled", false);
	
	$j('#btnAddRelation').hide();
	$j('#relationCode').attr('readonly', true);
	
	
	
}

function searchRelationList(){	
	if(document.getElementById('searchRelation').value == "" || document.getElementById('searchRelation') == null){
		 alert("Plese Enter the Relation Name");
		 return false;
	 }
		 	 
	 var relationName= jQuery("#searchRelation").attr("checked", true).val().toUpperCase();
		//alert("relationName :: "+relationName);
		var nPageNo=1;
		var url = "getAllRelation";
		var data =  {"PN":nPageNo, "relationName":relationName};
		var bClickable = true;
		GetJsonData('tblListOfRelation',data,url,bClickable);	
		ResetForm();
}


function updateRelationMaster(){
	
	//thisRow = $j('.rowClicked').attr('id');
	
	
	if(document.getElementById('relationCode') == null || document.getElementById('relationCode').value == ""){
		alert("Please Enter Relation Code");
		return false;
	}
	if(document.getElementById('relationName') == null || document.getElementById('relationName').value ==""){
		alert("Please Enter Relation Name");
		return false;
	}
	if(document.getElementById('newRelationCode') == null || document.getElementById('newRelationCode').value == ""){
		alert("Please Enter New Relation Code");
		return false;
	}
	if(document.getElementById('newRelationName') == null || document.getElementById('newRelationName').value ==""){
		alert("Please Enter New Relation Name");
		return false;
	}
	var userId =  $j('#userId').val();

	var params = {
			 'relationId':relId,
			 'relationCode':jQuery('#relationCode').val(),
			 'relationName':jQuery('#relationName').val(),			 
			 'newRelationCode':jQuery('#newRelationCode').val(),
			 'newRelationName':jQuery('#newRelationName').val(),
			 'userId':userId
	 } 
	
	var url="updateRelationDetails";
	SendJsonData(url,params);
	
	
	
	ResetForm();
}

function updateRelationStatus(){	
	
	//thisRow = $j('.rowClicked').attr('id');
	
	
	if(document.getElementById('relationCode') == null || document.getElementById('relationCode').value == ""){
		alert("Please Enter Relation Code");
		return false;
	}
	if(document.getElementById('relationName') == null || document.getElementById('relationName').value ==""){
		alert("Please Enter Relation Name");
		return false;
	}
	if(document.getElementById('newRelationCode') == null || document.getElementById('newRelationCode').value == ""){
		alert("Please Enter New Relation Code");
		return false;
	}
	if(document.getElementById('newRelationName') == null || document.getElementById('newRelationName').value ==""){
		alert("Please Enter New Relation Name");
		return false;
	}
	var userId =  $j('#userId').val();

	var params = {
			'relationId':relId,
			'relationCode':jQuery('#relationCode').val(),
			 'status':relStatus,
			 'userId':userId
			 
		} 
	var url="updateRelationStatus";
	SendJsonData(url,params);
	
	 
	$j("#btnActive").attr("disabled", true);
	$j("#btnInActive").attr("disabled", true);
	ResetForm();
	
	
}

function addRelationDetails(){
	
	if(document.getElementById('relationCode') == null || document.getElementById('relationCode').value == ""){
		alert("Please Enter Relation Code");
		return false;
	}
	if(document.getElementById('relationName') == null || document.getElementById('relationName').value ==""){
		alert("Please Enter Relation Name");
		return false;
	}
	if(document.getElementById('newRelationCode') == null || document.getElementById('newRelationCode').value == ""){
		alert("Please Enter New Relation Code");
		return false;
	}
	if(document.getElementById('newRelationName') == null || document.getElementById('newRelationName').value ==""){
		alert("Please Enter New Relation Name");
		return false;
	}
	var userId =  $j('#userId').val();

	var params = {
			 
			 'relationCode':jQuery('#relationCode').val(),
			 'relationName':jQuery('#relationName').val(),
			 'newRelationCode':jQuery('#newRelationCode').val(),
			 'newRelationName':jQuery('#newRelationName').val(),
			 'userId':userId
	 } 
	var url="addRelation";
	SendJsonData(url,params);
		
}

function Reset(){
	$j('#relationCode').attr('readonly', false);
	document.getElementById("searchRelationForm").reset();
	document.getElementById("addRelationForm").reset();
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j("#btnAddRelation").show();
	showAll();
}	

function enableAddButton(){
	if(document.getElementById("relationCode").value!=null || !document.getElementById("relationCode").value==""){
		$j('#btnAddRelation').attr("disabled", false);
	}else if( document.getElementById("relationName").value!=null || !document.getElementById("relationName").value==""){
		$j('#btnAddRelation').attr("disabled", false);
	}else{
		$j('#btnAddRelation').attr("disabled", true);
	}
}

function validTextBox(){
	if($j('#relationCode').val().length >= 2){
		 alert("Relation Code should be less or equal to 2");
		 document.getElementById('relationCode').value="";
		 return false;
	 }
	if($j('#newRelationCode').val().length >=2){
		 alert("Relation Name should be less or equal to 2");
		 document.getElementById('newRelationCode').value="";
		 return false;
	 }
}

function ResetForm()
{
	$j('#relationCode').val('');
	$j('#relationName').val('');
	$j('#newRelationCode').val('');
	$j('#newRelationName').val('');
	$j('#searchRelation').val('');
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetAllRelation('ALL');
	
}

function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllRelation('FILTER');
	
}
function search()
{
	if(document.getElementById('searchRelation').value == ""){
		alert("Please Enter Relation Name");
		return false;
	}
	nPageNo=1;
	GetAllRelation('Filter');
}

function generateReport()
{
	var url="${pageContext.request.contextPath}/report/generateRelationReport";
	openPdfModel(url);
	/* document.searchRelationForm.action="${pageContext.request.contextPath}/report/generateRelationReport";
	document.searchRelationForm.method="POST";
	document.searchRelationForm.submit();  */
	
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
                <div class="internal_Htext">Relation Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchRelationForm"
												name="searchRelationForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Relation Name <span
														style="color: red">*</span></label>
													<div class="col-4">

														<input type="text" name="searchRelation" id="searchRelation"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Relation Name" onkeypress="return validateText('searchRelation',30,'Relation Name');">

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
                                                <th id="th2" class ="inner_md_htext">Relation Code</th>
                                                <th id="th3" class ="inner_md_htext">Relation Name</th>
                                                
                                            </tr>
                                        </thead>
                                     <tbody class="clickableRow" id="tblListOfRelation">
										 
                     				 </tbody>
                                    </table>
                                  
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