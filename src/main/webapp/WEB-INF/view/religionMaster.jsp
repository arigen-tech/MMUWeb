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
	$j('#religionCode').attr('readonly', false);		
		GetAllReligion('ALL');			
		});
		
function GetAllReligion(MODE){
	var religionName= jQuery("#searchReligion").attr("checked", true).val().toUpperCase();
	 var religionId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "religionName":""};			
		}
	else
		{
		var data = {"PN":nPageNo, "religionName":religionName};
		} 
	var url = "getAllReligion";		
	var bClickable = true;
	GetJsonData('tblListOfReligion',data,url,bClickable);	 
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
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].religionId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].religionCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].religionName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='3'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfReligion").html(htmlTable); 	
	
}

var reliId;
var reliCode;
var reliName;
var reliStatus;

function executeClickEvent(religionId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(religionId == data.data[j].religionId){
			reliId = data.data[j].religionId;			
			reliCode = data.data[j].religionCode;			
			reliName = data.data[j].religionName;
			reliStatus = data.data[j].status;
			
			
		}
	}
	rowClick(reliId,reliCode,reliName,reliStatus);
}

function rowClick(reliId,reliCode,reliName,reliStatus){	
		
	document.getElementById("religionCode").value = reliCode;
	document.getElementById("religionName").value = reliName;
	
			 
	if(reliStatus == 'Y' || reliStatus == 'y'){		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#updateBtn').show();
	}
	if(reliStatus == 'N' || reliStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
	}
	
	$j("#btnActive").attr("disabled", false);
	$j("#btnInActive").attr("disabled", false);
	$j('#updateBtn').attr("disabled", false);
	$j('#btnAddReligion').hide();
	$j('#religionCode').attr('readonly', true);
}

/* function searchReligionList(){	
	if(document.getElementById('searchReligion').value == "" || document.getElementById('searchReligion') == null){
		 alert("Plese Enter the Religion Name");
		 return false;
	 }
		 	 
	 var religionName= jQuery("#searchReligion").attr("checked", true).val().toUpperCase();
		
		var nPageNo=1;
		var url = "getAllReligion";
		var data =  {"PN":nPageNo, "religionName":religionName};
		var bClickable = true;
		GetJsonData('tblListOfReligion',data,url,bClickable);
		
} */

var success;
var error;

function addReligionDetails(){
	
	if(document.getElementById('religionCode').value == null || document.getElementById('religionCode').value == ""){
		alert("Please Enter Religion Code");
		return false;
	}
	if(document.getElementById('religionName').value == null || document.getElementById('religionName').value ==""){
		alert("Please Enter Religion Name");
		return false;
	}
	$('#btnAddReligion').prop("disabled",true);
	var userId =  $j('#userId').val();
	var params = {			 
			 'religionCode':jQuery('#religionCode').val(),
			 'religionName':jQuery('#religionName').val(),
			 'userId':userId
	 } 
	
	var url="addReligion";
    SendJsonData(url,params);
}

function updateReligion(){	
	if(document.getElementById('religionCode').value == null || document.getElementById('religionCode').value == ""){
		alert("Please Enter Religion Code");
		return false;
	}
	if(document.getElementById('religionName').value == null || document.getElementById('religionName').value ==""){
		alert("Please Enter Religion Name");
		return false;
	}
		
	var userId =  $j('#userId').val();
	var params = {
			 'religionId':reliId,
			 'religionCode':jQuery('#religionCode').val(),
			 'religionName':jQuery('#religionName').val(),
			 'userId':userId
			
	 } 
	
	var url="updateReligionDetails";
	SendJsonData(url,params);	
 		 		
	$j('#updateBtn').show();
	$j('#btnAddReligion').attr("disabled", false);
	$j('#religionCode').attr('readonly', true);
	ResetFrom();
		
		$j('#updateBtn').attr("disabled", true);
}

function updateReligionStatus(){
	if(document.getElementById('religionCode').value == null || document.getElementById('religionCode').value == ""){
		alert("Please Enter Religion Code");
		return false;
	}
	if(document.getElementById('religionName').value == null || document.getElementById('religionName').value ==""){
		alert("Please Enter Religion Name");
		return false;
	}
	var userId =  $j('#userId').val();
	var params = {
			'religionId':reliId,
			 'religionCode':reliCode,
			 'status':reliStatus,
			 'userId':userId
			 
		} 
	 var url= "updateReligionStatus";
    SendJsonData(url,params);
    
    $j('#updateBtn').hide();
	$j('#btnAddReligion').show();
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
}


function Reset(){
	document.getElementById("addReligionForm").reset();
	document.getElementById("searchReligionForm").reset();
	document.getElementById('searchReligion').value = "";
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddReligion').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	$j('#religionCode').attr('readonly', false);
}



function ResetForm()
{	
	$j('#religionCode').val('');
	$j('#religionName').val('');
	$j('#searchReligion').val('');
	
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetAllReligion('ALL');
	
}

 function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllReligion('FILTER');
	
}
 function search()
 {
 	if(document.getElementById('searchReligion').value == ""){
 		alert("Please Enter Religion Name");
 		return false;
 	}
 	nPageNo=1;
 	GetAllReligion('Filter');
 }
 
 function generateReport()
 {
	 var url="${pageContext.request.contextPath}/report/generateReligionMasterReport";
	 openPdfModel(url);
 	/* document.searchReligionForm.action="${pageContext.request.contextPath}/report/generateReligionMasterReport";
 	document.searchReligionForm.method="POST";
 	document.searchReligionForm.submit();  */
 	
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
                <div class="internal_Htext">Religion Master</div>               
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       
                                        <form class="form-horizontal" id="searchReligionForm" name="searchReligionForm" method="" role="form">  
                                    <div class="row">
                                                                     
                                        <div class="col-md-8">
                                         
                                                <div class="form-group row">
                                                    <label class="col-3 col-form-label">Religion Name <span style="color:red">*</span> </label>
                                                    <div class="col-5">
                                                        <div class="col-auto">
                                                            <label class="sr-only" for="inlineFormInputGroup">Religion Name</label>
                                                            <div class="input-group mb-2">
                                                                <!-- <div class="input-group-prepend">
                                                                    <div class="input-group-text">&#128269;</div>
                                                                </div> -->
                                                                <input type="text" name="searchReligion" id="searchReligion" class="form-control" id="inlineFormInputGroup" placeholder="Religion Name"
                                                                onkeypress="return validateText('searchReligion',30,'Religion Name');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-2">
                                                        <button type="button" class="btn  btn-primary" onclick="search()">Search</button>
                                                    </div>
                                                </div>
                                            

                                        </div> 
                                        
                                        <div class="col-md-4">
                                            
                                                <div class="btn-right-all">
                                                    <button type="button" class="btn  btn-primary" onclick="showAll('ALL');">Show All</button>
                                                    <button type="button" class="btn  btn-primary" 
                                                    id="printReportButton" 
                                                    onclick="generateReport()">Reports</button>

                                                </div>
                                          
                                        </div>
                                        
                                        

                                    </div>
                                  </form>

					<!-- <table class="table table-striped table-hover jambo_table"> -->
              <!--      <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >			<tr>
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

                                    <table class="table table-striped table-hover table-bordered">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th id="th2" class ="inner_md_htext">Religion Code</th>
                                                <th id="th3" class ="inner_md_htext">Religion Name</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        <!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
                                     <tbody class="clickableRow" id="tblListOfReligion">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addReligionForm" name="addReligionForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Religion Code" class=" col-form-label inner_md_htext" >Religion Code <span style="color:red">*</span> </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="religionCode" name="religionCode" placeholder="Religion Code" onkeypress=" return validateText('religionCode',7,'Religion Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Religion Name <span style="color:red">*</span> </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="religionName" name="religionName" placeholder="Religion Name" onkeypress="return validateText('religionName',30,'Religion Name');"
                                                                >
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
												
														<button type="button" id="btnAddReligion" class="btn btn-primary" onclick="addReligionDetails();">Add</button>
                                                    <button type="button" id ="updateBtn" class="btn btn-primary" onclick="updateReligion();">Update</button>
                                                    <button id="btnActive" type="button" class="btn btn-primary" onclick="updateReligionStatus();">Activate</button>
                                      				<button id="btnInActive" type="button" class="btn btn-primary" onclick="updateReligionStatus();">Deactivate</button>
                                                    <button type="button" class="btn btn-danger" onclick="Reset();">Reset</button>

													
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

          <!--   <footer class="footer">
               Religion MASTER
            </footer>
 -->
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
