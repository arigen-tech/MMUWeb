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
	$j('#collectionCode').attr('readonly', false);		
	GetAllSampleContainer('ALL');			
		});
		
function GetAllSampleContainer(MODE){
	 
	var collectionName=$("#searchCollection").val();	
	
	 var sampleId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "collectionName":""};			
		}else{
		var data = {"PN":nPageNo, "collectionName":collectionName};
		} 
	var url = "getAllSampleContainer";		
	var bClickable = true;
	GetJsonData('tblListOfSample',data,url,bClickable);	 
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
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].collectionId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].collectionCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].collectionName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfSample").html(htmlTable); 	
	
}

var scId;
var scCode;
var scName;
var scStatus;

function executeClickEvent(collectionId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(collectionId == data.data[j].collectionId){
			scId = data.data[j].collectionId;			
			scCode = data.data[j].collectionCode;			
			scName = data.data[j].collectionName;
			scStatus = data.data[j].status;
			
			
		}
	}
	rowClick(scId,scCode,scName,scStatus);
}

function rowClick(scId,scCode,scName,scStatus){	
		
	document.getElementById("collectionCode").value = scCode;
	document.getElementById("collectionName").value = scName;
	
			 
	if(scStatus == 'Y' || scStatus == 'y'){		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#updateBtn').show();
		$j('#btnAddSample').hide();
	}
	if(scStatus == 'N' || scStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddSample').hide();
	}
	
	
	
	$j('#collectionCode').attr('readonly', true);
	
}



var success;
var error;

function addSampleCotainer(){
	
	if(document.getElementById('collectionCode').value == null || document.getElementById('collectionCode').value == ""){
		alert("Please Enter Collection Code");
		return false;
	}
	if(document.getElementById('collectionName').value == null || document.getElementById('collectionName').value ==""){
		alert("Please Enter Collection Name");
		return false;
	}
	
	$('#btnAddSample').prop("disabled", true);
	var params = {		
			
			 'collectionCode':jQuery('#collectionCode').val(),
			 'collectionName':jQuery('#collectionName').val(),
			 'userId': <%= userId%>
	 }
	
	//alert(JSON.stringify(params));
	    var url = "addSampleContainer";
	    SendJsonData(url,params);
	
	    
}

function updateSampleCotainer(){	
	if(document.getElementById('collectionCode').value == null || document.getElementById('collectionCode').value == ""){
		alert("Please Enter Collection Code");
		return false;
	}
	if(document.getElementById('collectionName').value == null || document.getElementById('collectionName').value ==""){
		alert("Please Enter Collection Name");
		return false;
	}
		
	
	var params = {
			 'collectionId':scId,
			 'collectionCode':jQuery('#collectionCode').val(),
			 'collectionName':jQuery('#collectionName').val(),
			 'userId': <%=userId %>
			
	 } 
	//alert(JSON.stringify(params));
		    var url = "updateSampleContainer";
		    SendJsonData(url,params);
		    Reset();
}

function updateSampleContainerStatus(){
	if(document.getElementById('collectionCode').value == null || document.getElementById('collectionCode').value == ""){
		alert("Please Enter collection Code");
		return false;
	}
	if(document.getElementById('collectionName').value == null || document.getElementById('collectionName').value ==""){
		alert("Please Enter collection Name");
		return false;
	}
	
	var params = {
			
			'collectionId':scId,			 
			 'status':scStatus
	 
		} 
	
	//alert(JSON.stringify(params));
		    var url = "updateSampleContainerStatus";
	        SendJsonData(url,params);
	        Reset();
     
}

function Reset(){
	
	document.getElementById('searchCollection').value = "";
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddSample').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	$j('#collectionCode').attr('readonly', false);
	showAll();
}



function ResetForm()
{	
	$j('#collectionCode').val('');
	$j('#collectionName').val('');
	$j('#searchCollection').val('');
	
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetAllSampleContainer('ALL');
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddSample').show();
	$j('#collectionCode').attr('readonly', false);
	
	
}
 function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllSampleContainer('FILTER');
	
} 

 function search()
 {
 	if(document.getElementById('searchCollection').value == ""){
  		alert("Please Enter Collection Name");
  		return false;
  	}
 	nPageNo=1;
 	GetAllSampleContainer('FILTER');
 }
 
 function generateReport()
 {
	 var url="${pageContext.request.contextPath}/report/generateSampleContainerReport";
	 openPdfModel(url);
 	/* document.searchCollectionForm.action="${pageContext.request.contextPath}/report/generateSampleContainerReport";
 	document.searchCollectionForm.method="POST";
 	document.searchCollectionForm.submit(); */ 
 	
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
                <div class="internal_Htext">Sample Container Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchCollectionForm"
												name="searchCollectionForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Collection Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchCollection" id="searchCollection"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Collcection Name">

													</div>
													<div class="form-group row">

														<div class="col-md-12">
															<button type="button" class="btn  btn-primary "
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
                                                <th id="th2" class ="inner_md_htext">Collection Code</th>
                                                <th id="th3" class ="inner_md_htext">Collection Name</th>
                                                <th id="th4" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        <!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
                                     <tbody class="clickableRow" id="tblListOfSample">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addSampleForm" name="addSampleContainerForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" >Collection Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="collectionCode" name="collectionCode" placeholder="Collection Code" onkeypress=" return validateText('collectionCode',7,'Collection Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Collection Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="collectionName" name="collectionName" placeholder="Collection Name" onkeypress="return validateTextField('collectionName',30,'Collection Name')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
										<input type="hidden"  id="rowId" name="rowId">
																											
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
												
														<button type="button" id="btnAddSample"
															class="btn  btn-primary " onclick="addSampleCotainer();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateSampleCotainer();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateSampleContainerStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateSampleContainerStatus();">Deactivate</button>
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