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
	 
			
	GetAllDisposal('ALL');
			
		});
function GetAllDisposal(MODE){
	var disposalName = jQuery("#searchDisposal").attr("checked", true).val().toUpperCase(); 
	 var disposalId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo,"disposalName":""};			
		}
	else
		{
		var data = {"PN":nPageNo, "disposalName":disposalName};
		}
	var url = "getAllDisposal";		
	var bClickable = true;
	GetJsonData('tblListOfDisposal',data,url,bClickable);	 
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
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].disposalId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].disposalCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].disposalName+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].disposalType+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfDisposal").html(htmlTable); 	
	
}

var dispoId;
var dispoCode;
var dispoName;
var dispoStatus;
var dispoType;
function executeClickEvent(disposalId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(disposalId == data.data[j].disposalId){
			dispoId = data.data[j].disposalId;			
			dispoCode = data.data[j].disposalCode;			
			dispoName = data.data[j].disposalName;
			dispoType = data.data[j].disposalType;
			dispoStatus = data.data[j].status;
			
			
		}
	}
	rowClick(dispoId,dispoCode,dispoName,dispoType,dispoStatus);
}

function rowClick(dispoId,dispoCode,dispoName,dispoType,dispoStatus){	
		
	document.getElementById("disposalCode").value = dispoCode;
	$('#disposalCode').attr("disabled", true);
	document.getElementById("disposalName").value = dispoName;
	
		if(dispoType == 'OP'){
			
			jQuery("#disposalType").val(dispoType);
			
		}
		
		if(dispoType == 'IP'){
			
			jQuery("#disposalType").val(dispoType);
			
		}
	 
	if(dispoStatus == 'Y' || dispoStatus == 'y'){		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#updateBtn').show();
		$j('#btnAddDisposal').hide();
	}
	if(dispoStatus == 'N' || dispoStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddDisposal').hide();
	}
	
		
}




function updateDisposalMaster(){	
	if(document.getElementById('disposalCode').value == null || document.getElementById('disposalCode').value == ""){
		alert("Please Enter Disposal Code");
		return false;
	}
	if(document.getElementById('disposalName').value == null || document.getElementById('disposalName').value ==""){
		alert("Please Enter Disposal Name");
		return false;
	}
	if(document.getElementById('disposalType').value == null || document.getElementById('disposalType').value == ""){
		alert("Please select disposal Type");
		return false;
	}
	
	var userId =  $j('#userId').val();
	var params = {
			 'disposalId':dispoId,
			 'disposalCode':jQuery('#disposalCode').val(),
			 'disposalName':jQuery('#disposalName').val(),			 
			 'disposalType':jQuery('#disposalType').val(),
			 'userId':userId
			
	 } 
	var url="updateDisposalDetails";
	SendJsonData(url,params);
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j("#btnAddDisposal").show();
	$j("#updateBtn").hide();
		ResetForm();
}

function updateDisposalStatus(){
	
	if(document.getElementById('disposalCode').value == null || document.getElementById('disposalCode').value == ""){
		alert("Please Enter Disposal Code");
		return false;
	}
	if(document.getElementById('disposalName').value == null || document.getElementById('disposalName').value ==""){
		alert("Please Enter Disposal Name");
		return false;
	}
	if(document.getElementById('disposalType').value == null || document.getElementById('disposalType').value == ""){
		alert("Please select disposal Type");
		return false;
	}
	var userId =  $j('#userId').val();
	var params = {
			'disposalId':dispoId,
			 'disposalCode':jQuery('#disposalCode').val(),
			 'status':dispoStatus,
			 'userId':userId
			 
		} 
	var url="updateDisposalStatus";
	SendJsonData(url,params);
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j("#btnAddDisposal").show();
	$j("#updateBtn").hide();
	
	ResetForm();
}

function addDisposalDetails(){
	
	if(document.getElementById('disposalCode').value == null || document.getElementById('disposalCode').value == ""){
		alert("Please Enter Disposal Code");
		return false;
	}
	if(document.getElementById('disposalName').value == null || document.getElementById('disposalName').value ==""){
		alert("Please Enter Disposal Name");
		return false;
	}
	if(document.getElementById('disposalType').value == null || document.getElementById('disposalType').value == ""){
		alert("Please select disposal Type");
		return false;
	}
	$('#btnAddDisposal').prop("disabled", true);
	var userId =  $j('#userId').val();
	var params = {
			 
			 'disposalCode':jQuery('#disposalCode').val(),
			 'disposalName':jQuery('#disposalName').val(),
			 'disposalType':jQuery('#disposalType').val(),
			 'userId':userId
			 			 
	 } 
	var url="addDisposal";
	SendJsonData(url,params);
	
	
}
function changeDisposalType(value){
		
	if(value == 'OP'){
		$j('#updateBtn').attr("disabled", false);
	}	
	if(value == 'IP'){
		$j('#updateBtn').attr("disabled", false);
	}
}

function Reset(){
	document.getElementById("searchDisposalForm").reset();
	document.getElementById("addDisposalForm").reset();
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddDisposal').show();
	showAll();
}	

function enableAddButton(){
	if(document.getElementById("disposalCode").value!=null || !document.getElementById("disposalCode").value==""){
		$j('#btnAddDisposal').attr("disabled", false);
	}else if( document.getElementById("disposalName").value!=null || !document.getElementById("disposalName").value==""){
		$j('#btnAddDisposal').attr("disabled", false);
	}else{
		$j('#btnAddDisposal').attr("disabled", true);
	}
}

function validTextBox(){
	if($j('#disposalCode').val().length >= 10){
		 alert("Relation Code should be less or equal to 2");
		 document.getElementById('disposalCode').value="";
		 return false;
	 }
	if($j('#disposalName').val().length >=2){
		 alert("Disposal Name should be less or equal to 2");
		 document.getElementById('disposalName').value="";
		 return false;
	 }
}

function ResetForm()
{
	$j('#disposalCode').val('');
	$j('#disposalName').val('');
	$j('#disposalType').val('');
	$j('#searchDisposal').val('');
	$('#disposalCode').attr("disabled", false);
	
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetAllDisposal('ALL');
	
}

 function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllDisposal('FILTER');
	
} 
 function search()
 {
 	if(document.getElementById('searchDisposal').value == ""){
  		alert("Please Enter Disposal Name");
  		return false;
  	}
 	nPageNo=1;
 	GetAllDisposal('Filter');
 }
 
 function generateReport()
 {	
	var url="${pageContext.request.contextPath}/report/generateDisposalReport";
	 openPdfModel(url);
 	/* document.searchDisposalForm.action="${pageContext.request.contextPath}/report/generateDisposalReport";
 	document.searchDisposalForm.method="POST";
 	document.searchDisposalForm.submit();  */
 	
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
                <div class="internal_Htext">Disposal Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                        
                                        <div class="row">               
                                        <div class="col-md-8">
                                            <form class="form-horizontal" id="searchDisposalForm" name="searchDisposalForm" method="" role="form">
                                                <div class="form-group row">
                                                    <label class="col-3 col-form-label">Disposal Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                    <div class="col-4">                                                    
                                                               
                                                              <input type="text" name="searchDisposal" id="searchDisposal" class="form-control" id="inlineFormInputGroup" placeholder="Disposal Name" onkeypress="return validateText('searchDisposal',30,'Disposal Name');">
                                                             
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
                                                <th id="th2" class ="inner_md_htext">Disposal Code</th>
                                                <th id="th3" class ="inner_md_htext">Disposal Name</th>
                                                <th id="th4" class ="inner_md_htext">Disposal Type</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                     <tbody class="clickableRow" id="tblListOfDisposal">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addDisposalForm" name="addDisposalForm" action="" method="POST">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Command Code" class=" col-form-label inner_md_htext" >Disposal Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" name="disposalCode" id="disposalCode" class="form-control" placeholder="Disposal Code" onkeypress="return validateText('disposalCode',7,'Disposal Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Disposal Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" name="disposalName" id="disposalName" class="form-control" placeholder="Disposal Name" onkeypress="return validateText('disposalName',30,'Disposal Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Disposal Type<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="disposalType" onchange="changeDisposalType(this.value);">
                                                                    <option value="">Select</option>
				                                                	<option value="OP">OP</option>
				                                                	<option value="IP">IP</option>
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
												
														<button type="button" id="btnAddDisposal"
															class="btn  btn-primary " onclick="addDisposalDetails();">Add</button>
															
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateDisposalMaster();">Update</button>
															
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateDisposalStatus();">Activate</button>
															
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateDisposalStatus();">Deactivate</button>
															
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