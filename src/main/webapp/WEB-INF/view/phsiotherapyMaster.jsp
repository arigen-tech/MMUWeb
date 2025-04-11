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
				GetAllPhysiotherapy('ALL');
				$j('#nursingCode').attr('readonly', false);	
		});
		
function GetAllPhysiotherapy(MODE){
	var nursingName = jQuery("#searchTherapy").attr("checked", true).val().toUpperCase();
	 var nursingId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo,"nursingName":""};			
		}
	else
		{
		var data = {"PN":nPageNo, "nursingName":nursingName};
		} 
	var url = "getAllPhysiotherapy";		
	var bClickable = true;
	GetJsonData('tblListOfPhsiotherapy',data,url,bClickable);	 
}
function makeTable(jsonData)
{	
	var htmlTable = "";	
	var data = jsonData.count; 
	//alert("data :: "+data);
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
		 
		 
			var NursingType = "";
			
				if(dataList[i].nursingType == 'M' || dataList[i].nursingType == 'm')
					{
					NursingType = 'Minor Surgery'
					}
				else if(dataList[i].nursingType == 'P' || dataList[i].nursingType == 'p')
					{
					NursingType = 'Physiotherapy'
					}
				else if (dataList[i].nursingType == 'N' || dataList[i].nursingType == 'n')
					{
					NursingType = 'Nursing Care'
					}
			htmlTable = htmlTable+"<tr id='"+dataList[i].nursingId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].nursingCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].nursingName+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+NursingType+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfPhsiotherapy").html(htmlTable); 	
	
}

var comboArray = [];
var nId;
var nursingCode;
var nursingName;
var nursingType;
var nursingStatus;
function executeClickEvent(nursingId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(nursingId == data.data[j].nursingId){
			nId = data.data[j].nursingId;			
			nursingCode = data.data[j].nursingCode;
			nursingName = data.data[j].nursingName;
			nursingStatus = data.data[j].status;
			nursingType = data.data[j].nursingType;
			//unitId = data.data[j].unitId;
			
			
		}
	}
	rowClick(nId,nursingCode,nursingName,nursingType,nursingStatus);
}

function rowClick(nId,nursingCode,nursingName,nursingType,nursingStatus){	
	document.getElementById("nursingCode").value = nursingCode;
	document.getElementById("nursingName").value = nursingName;
	document.getElementById("nursingType").value = nursingType;
	
	
	 
	if(nursingStatus == 'Y' || nursingStatus == 'y'){
		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		 $j("#updateBtn").show();
		 $j('#btnAddPhysiotherapy').hide();
		 $j('#nursingCode').attr('readonly', true);
		//$j('#updateBtn').attr("disabled", false);
	}
	if(nursingStatus == 'N' || nursingStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddPhysiotherapy').hide();
		$j('#nursingCode').attr('readonly', true);
	}
	
	
}





function addPhsiotherapyDetails(){	
	
	if(document.getElementById('nursingCode').value == ""){
		alert("Please Enter Procedure Code");
		return false;
	}
	if(document.getElementById('nursingName').value ==""){
		alert("Please Enter Procedure Name");
		return false;
	}
	if(document.getElementById('nursingType').value =="0"){
		alert("Please Select Procedure Type");
		return false;
	}
	$('#btnAddPhysiotherapy').prop("disabled", true);
	var userId =  $j('#userId').val();
	var params = {
			 
			 'nursingCode':jQuery('#nursingCode').val(),
			 'nursingName':jQuery('#nursingName').val(),
			 'nursingType':jQuery('#nursingType').find('option:selected').val(),
			 'userId':userId
			 
	 } 
	var url="addPhsiotherapy";
	SendJsonData(url,params);
	ResetForm();
}


function updatePhsiotherapyMaster(status){
	//alert("status :: "+status);
	if(document.getElementById('nursingCode').value == null || document.getElementById('nursingCode').value == ""){
		alert("Please Enter Procedure Code");
		return false;
	}
	if(document.getElementById('nursingName').value ==""){
		alert("Please Enter Procedure Name");
		return false;
	}
	if(document.getElementById('nursingType').value =="0"){
		alert("Please Select Procedure Type");
		return false;
	}
	var userId =  $j('#userId').val();
	var params = {
			 'nursingId':nId,
			 'nursingCode':jQuery('#nursingCode').val(),
			 'nursingName':jQuery('#nursingName').val(),			 
			 'nursingType':jQuery('#nursingType').val(),
			 'status':status,
			 'userId':userId
	 } 
	
	//alert("params: "+JSON.stringify(params));
	var url="updatePhsiotherapyDetails";
	SendJsonData(url,params);
	$j('#nursingCode').attr('readonly', false);
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j("#updateBtn").hide();	
	$j('#btnAddPhysiotherapy').show();
		
		ResetForm();
}

function Reset(){
	document.getElementById("searchTherapyForm").reset();
	document.getElementById("addPhsiotherapyForm").reset();
	$j('#nursingCode').attr('readonly', false);
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddPhysiotherapy').show();
	showAll();
}	

function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllPhysiotherapy('FILTER');
	
}
function showAll()
{
	$('#searchTherapy').val('');
	$j('#nursingCode').attr('readonly', false);
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddPhysiotherapy').show();
	nPageNo = 1;
	GetAllPhysiotherapy('ALL');	
	ResetForm();
}

function ResetForm()
{	
	$j('#nursingCode').val('');
	$j('#nursingName').val('');
	$j('#nursingType').val('');
	$j('#searchTherapy').val('');
	
}

function search()
{
	if(document.getElementById('searchTherapy').value == ""){
 		alert("Please Enter Procedure Name");
 		return false;
 	}
	nPageNo=1;
	GetAllPhysiotherapy('Filter');
}

function generateReport()
{
	var url="${pageContext.request.contextPath}/report/generatePhysiothreapyReport";
	openPdfModel(url);
	/* document.searchTherapyForm.action="${pageContext.request.contextPath}/report/generatePhysiothreapyReport";
	document.searchTherapyForm.method="POST";
	document.searchTherapyForm.submit(); */ 
	
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
                <div class="internal_Htext">Procedure Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                        
                                       <div class="row">               
                                        <div class="col-md-8">
                                            <form class="form-horizontal" id="searchTherapyForm" name="searchTherapyForm" method="" role="form">
                                                <div class="form-group row">
                                                    <label class="col-3 col-form-label">Procedure Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                    <div class="col-4">                                                    
                                                               
                                                              <input type="text" name="searchTherapy" id="searchTherapy" class="form-control" id="inlineFormInputGroup" placeholder="Procedure Name" onkeypress="return validateText('searchTherapy',30,'Procedure Name');">
                                                             
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
                                                <th id="th2" class ="inner_md_htext">Procedure Code</th>
                                                <th id="th3" class ="inner_md_htext">Procedure Name</th>
                                                <th id="th4" class ="inner_md_htext">Procedure Type</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                     <tbody class="clickableRow" id="tblListOfPhsiotherapy">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addPhsiotherapyForm" name="addPhsiotherapyForm" action="" method="POST">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Command Code" class=" col-form-label inner_md_htext" >Procedure Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" name="nursingCode" id="nursingCode" class="form-control" placeholder="Procedure Code" onkeypress="return validateText('nursingCode',7,'Procedure Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Procedure Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" name="nursingName" id="nursingName" class="form-control" placeholder="Procedure Name" onkeypress="return validateText('nursingName',30,'Procedure Name');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Procedure Type<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-sm-7">
																<select class="form-control" id="nursingType"  onchange="">
                                                                    <option value="0">Select</option>
                                                                    <option value="M">Minor Surgery</option>
                                                                    <option value="P">Physiotherapy</option>
                                                                    <option value="N">Nursing Care</option>
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
												
														<button type="button" id="btnAddPhysiotherapy"
															class="btn  btn-primary " onclick="addPhsiotherapyDetails();">Add</button>
															
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updatePhsiotherapyMaster('update');">Update</button>
															
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updatePhsiotherapyMaster('active');">Activate</button>
															
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updatePhsiotherapyMaster('inactive');">Deactivate</button>
															
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
