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
	$j('#sampleCode').attr('readonly', false);		
		GetAllSample('ALL');			
		});
		
function GetAllSample(MODE){
	 var sampleDescription= jQuery("#searchSample").attr("checked", true).val().toUpperCase();
		
	 var sampleId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "sampleDescription":""};			
		}else{
		var data = {"PN":nPageNo, "sampleDescription":sampleDescription};
		} 
	var url = "getAllSample";		
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
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].sampleId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].sampleCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].sampleDescription+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfSample").html(htmlTable); 	
	
}

var sId;
var sCode;
var sName;
var sStatus;

function executeClickEvent(sampleId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(sampleId == data.data[j].sampleId){
			sId = data.data[j].sampleId;			
			sCode = data.data[j].sampleCode;			
			sName = data.data[j].sampleDescription;
			sStatus = data.data[j].status;
			
			
		}
	}
	rowClick(sId,sCode,sName,sStatus);
}

function rowClick(sId,sCode,sName,sStatus){	
		
	document.getElementById("sampleCode").value = sCode;
	document.getElementById("sampleDescription").value = sName;
	
			 
	if(sStatus == 'Y' || sStatus == 'y'){		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#updateBtn').show();
		$j('#btnAddSample').hide();
		$j('#sampleCode').attr('readonly', true);
	}
	if(sStatus == 'N' || sStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddSample').hide();
		$j('#sampleCode').attr('readonly', true);
	}
	
	
	
}


function addSampleDetails(){
	
	if(document.getElementById('sampleCode').value == null || document.getElementById('sampleCode').value == ""){
		alert("Please Enter Sample Code");
		return false;
	}
	if(document.getElementById('sampleDescription').value == null || document.getElementById('sampleDescription').value ==""){
		alert("Please Enter Sample Name");
		return false;
	}
	$('#btnAddSample').prop("disabled",true);
	var userId =  $j('#userId').val();
	var params = {			 
			 'sampleCode':jQuery('#sampleCode').val(),
			 'sampleDescription':jQuery('#sampleDescription').val(),
			 'userId': <%=userId%>
	 } 
	    var url = "addSample";
	    SendJsonData(url,params);
	
}

function updateSample(){	
	if(document.getElementById('sampleCode').value == null || document.getElementById('sampleCode').value == ""){
		alert("Please Enter Sample Code");
		return false;
	}
	if(document.getElementById('sampleDescription').value == null || document.getElementById('sampleDescription').value ==""){
		alert("Please Enter Sample Name");
		return false;
	}
		
	var userId =  $j('#userId').val();
	var params = {
			 'sampleId':sId,
			 'sampleCode':jQuery('#sampleCode').val(),
			 'sampleDescription':jQuery('#sampleDescription').val(),
			 'userId': <%=userId %>
			
	 } 
		    var url = "updateSampleDetails";
		    SendJsonData(url,params);
		    $j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddSample').show();
			$j('#sampleCode').attr('readonly', false);		    
			Reset();
}

function updateSampleStatus(){
	if(document.getElementById('sampleCode').value == null || document.getElementById('sampleCode').value == ""){
		alert("Please Enter Sample Code");
		return false;
	}
	if(document.getElementById('sampleDescription').value == null || document.getElementById('sampleDescription').value ==""){
		alert("Please Enter Sample Name");
		return false;
	}
	var userId =  $j('#userId').val();
	var params = {
			'sampleId':sId,
			 'sampleCode':sCode,
			 'status':sStatus,
			 'userId': <%=userId %>
			 
		} 
		
	//alert(JSON.stringify(params));
		    var url = "updateSampleStatus";
	        SendJsonData(url,params);
	        $j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddSample').show();
			$j('#sampleCode').attr('readonly', false);	
}

function Reset(){
	document.getElementById("addSampleForm").reset();
	document.getElementById("searchSampleForm").reset();
	document.getElementById('searchSample').value = "";
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddSample').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	$j('#sampleCode').attr('readonly', false);
	showAll();
}



function ResetForm()
{	
	$j('#sampleCode').val('');
	$j('#sampleDescription').val('');
	$j('#searchSample').val('');
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddSample').show();
	
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetAllSample('ALL');
	$j('#sampleCode').attr('readonly', false);
	
}
 function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllSample('FILTER');
	
} 

 function search()
 {
 	if(document.getElementById('searchSample').value == ""){
  		alert("Please Enter Sample Name");
  		return false;
  	}
 	nPageNo=1;
 	GetAllSample('FILTER');
 }
 
 function generateReport()
 {
	 var url="${pageContext.request.contextPath}/report/generateSampleReport";
	 openPdfModel(url);
 	/* document.searchSampleForm.action="${pageContext.request.contextPath}/report/generateSampleReport";
 	document.searchSampleForm.method="POST";
 	document.searchSampleForm.submit();  */
 	
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
                <div class="internal_Htext">Sample Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchSampleForm"
												name="searchSampleForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Sample Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchSample" id="searchSample"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Sample Name" onkeypress="return validateText('searchSample',30,'Sample Name');">

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
                                    <%-- <div class="row">
                                                                     
                                        <div class="col-md-8">
                                            <form class="form-horizontal" id="searchSampleForm" name="searchSampleForm" method="" role="form">
                                                <div class="form-group row">
                                                    <label class="col-3 col-form-label inner_md_htext">Sample Name <span style="color:red">*</span> </label>
                                                    <div class="col-5">
                                                        <div class="col-auto">
                                                            <label class="sr-only" for="inlineFormInputGroup">Sample Name</label>
                                                            <div class="input-group mb-2">
                                                                <!-- <div class="input-group-prepend">
                                                                    <div class="input-group-text">&#128269;</div>
                                                                </div> -->
                                                                <input type="text" name="searchSample" id="searchSample" class="form-control" id="inlineFormInputGroup" placeholder="Sample Name">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-2">
                                                        <button type="button" class="btn  btn-primary" onclick="searchSampleList();">Search</button>
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
                  <!--  <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >			<tr>
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
                                                <th id="th2" class ="inner_md_htext">Sample Code</th>
                                                <th id="th3" class ="inner_md_htext">Sample Name</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        <!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
                                     <tbody class="clickableRow" id="tblListOfSample">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addSampleForm" name="addSampleForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Sample Code" class=" col-form-label inner_md_htext" >Sample Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="sampleCode" name="sampleCode" placeholder="Sample Code" onkeypress=" return validateText('sampleCode',7,'Sample Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Sample Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="sampleDescription" name="sampleDescription" placeholder="Sample Name" onkeypress="return validateTextField('sampleDescription',30,'Sample Name')">
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
												
														<button type="button" id="btnAddSample"
															class="btn  btn-primary " onclick="addSampleDetails();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateSample();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateSampleStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateSampleStatus();">Deactivate</button>
														<button type="button" class="btn btn-danger "
															onclick="Reset();">Reset</button>
													
											</div>
										</div>
									</div>	
                                    <%-- <div class="row">
                                        <div class="col-md-7">
                                        </div>
                                        <div class="col-md-5">
                                            <form>
                                                <div class="button-list">

                                                    <button type="button" id="btnAddSample" class="btn btn-primary btn-rounded w-md waves-effect waves-light" onclick="addSampleDetails();">Add</button>
                                                    <button type="button" id ="updateBtn" class="btn btn-primary btn-rounded w-md waves-effect waves-light" onclick="updateSample();">Update</button>
                                                    <button id="btnActive" type="button" class="btn btn-primary btn-rounded w-md waves-effect waves-light" onclick="updateSampleStatus();">Activate</button>
                                      				<button id="btnInActive" type="button" class="btn btn-primary btn-rounded w-md waves-effect waves-light" onclick="updateSampleStatus();">Deactivate</button>
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

