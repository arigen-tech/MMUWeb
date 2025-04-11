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
	$j('#UOMCode').attr('readonly', false);		
		GetAllUOM('ALL');			
		});
		
function GetAllUOM(MODE){
	 var UOMName= jQuery("#searchUOM").attr("checked", true).val().toUpperCase();
		
		
	document.getElementById('searchUOM').value = "";
	 var UOMId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "UOMName":""};			
		}else{
		var data = {"PN":nPageNo, "UOMName":UOMName};
		} 
	var url = "getAllUOM";		
	var bClickable = true;
	GetJsonData('tblListOfUOM',data,url,bClickable);	 
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
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].UOMId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].UOMCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].UOMName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfUOM").html(htmlTable); 	
	
}

var uId;
var uCode;
var uName;
var uStatus;

function executeClickEvent(UOMId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(UOMId == data.data[j].UOMId){
			uId = data.data[j].UOMId;			
			uCode = data.data[j].UOMCode;			
			uName = data.data[j].UOMName;
			uStatus = data.data[j].status;
			
			
		}
	}
	rowClick(uId,uCode,uName,uStatus);
}

function rowClick(uId,uCode,uName,uStatus){	
		
	document.getElementById("UOMCode").value = uCode;
	document.getElementById("UOMName").value = uName;
	
			 
	if(uStatus == 'Y' || uStatus == 'y'){		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#updateBtn').show();
	}
	if(uStatus == 'N' || uStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
	}
	
	$j("#btnActive").attr("disabled", false);
	$j("#btnInActive").attr("disabled", false);
	$j('#updateBtn').attr("disabled", false);
	$j('#btnAddUOM').hide();
	$j('#UOMCode').attr('readonly', true);
	
}

function searchUOMList(){	
	if(document.getElementById('searchUOM').value == "" || document.getElementById('searchUOM') == null){
		 alert("Plese Enter the UOM Name");
		 return false;
	 }
		 	 
	 var UOMName= jQuery("#searchUOM").attr("checked", true).val().toUpperCase();
		
		var nPageNo=1;
		var url = "getAllUOM";
		var data =  {"PN":nPageNo, "UOMName":UOMName};
		var bClickable = true;
		GetJsonData('tblListOfUOM',data,url,bClickable);		
}


var success;
var error;

function addUOMDetails(){
	if(document.getElementById('UOMCode').value == null || document.getElementById('UOMCode').value == ""){
		alert("Please Enter UOM Code");
		return false;
	}
	if(document.getElementById('UOMName').value == null || document.getElementById('UOMName').value ==""){
		alert("Please Enter UOM Name");
		return false;
	}
	var userId =  $j('#userId').val();
	var params = {			 
			 'UOMCode':jQuery('#UOMCode').val(),
			 'UOMName':jQuery('#UOMName').val(),
			 'userId': <%=userId %>
	 } 
	    var url = "addUOM";
	    SendJsonData(url,params);
}

function updateUOM(){	
	if(document.getElementById('UOMCode').value == null || document.getElementById('UOMCode').value == ""){
		alert("Please Enter UOM Code");
		return false;
	}
	if(document.getElementById('UOMName').value == null || document.getElementById('UOMName').value ==""){
		alert("Please Enter UOM Name");
		return false;
	}
	var userId =  $j('#userId').val();
	var params = {
			 'UOMId':uId,
			 'UOMCode':jQuery('#UOMCode').val(),
			 'UOMName':jQuery('#UOMName').val(),
			 'userId':<%=userId %>
			 
			
	 } 
		    var url = "updateUOMDetails";
			SendJsonData(url,params);	
    
	$j('#UOMCode').attr('readonly', true);
	Reset();
}

function updateUOMStatus(){
	if(document.getElementById('UOMCode').value == null || document.getElementById('UOMCode').value == ""){
		alert("Please Enter UOM Code");
		return false;
	}
	if(document.getElementById('UOMName').value == null || document.getElementById('UOMName').value ==""){
		alert("Please Enter UOM Name");
		return false;
	}
	var userId =  $j('#userId').val();
	var params = {
			'UOMId':uId,
			 'UOMCode':uCode,
			 'status':uStatus,
			 'userId':<%=userId %>
			 
		} 
		    var url = "updateUOMStatus";
			SendJsonData(url,params);
  	 
			Reset();
}

function Reset(){
	
	document.getElementById('searchUOM').value = "";
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddUOM').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	$j('#UOMCode').attr('readonly', false);
	showAll();
}



function ResetForm()
{	
	$j('#UOMCode').val('');
	$j('#UOMName').val('');
	$j('#searchUOM').val('');
	$j('#UOMCode').attr('readonly', false);
}

function showAll()
{
	 ResetForm();
	
	nPageNo = 1;	
	GetAllUOM('ALL');
	
}

 function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllUOM('FILTER');
	
} 

 function search()
 {
 	if(document.getElementById('searchUOM').value == ""){
  		alert("Please Enter UOM Name");
  		return false;
  	}
 	nPageNo=1;
 	GetAllUOM('Filter');
 }
 
 function generateReport()
 {
	 var url="${pageContext.request.contextPath}/report/generateUOMReport";
	 openPdfModel(url);
 	/* document.searchUOMForm.action="${pageContext.request.contextPath}/report/generateUOMReport";
 	document.searchUOMForm.method="POST";
 	document.searchUOMForm.submit();  */
 	
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
                <div class="internal_Htext">Unit of Measurement Master</div>
               
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchUOMForm"
												name="searchUOMForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">UOM Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchUOM" id="searchUOM"
															class="form-control" id="inlineFormInputGroup"
															placeholder="UOM Name">

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
                                                <th id="th2" class ="inner_md_htext">UOM Code</th>
                                                <th id="th3" class ="inner_md_htext">UOM Name</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        <!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
                                     <tbody class="clickableRow" id="tblListOfUOM">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addUOMForm" name="addUOMForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="UOM Code" class=" col-form-label inner_md_htext" >UOM Code <span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="UOMCode" name="UOMCode" placeholder="UOM Code" onkeypress=" return validateText('UOMCode',7,'UOM Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">UOM Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="UOMName" name="UOMName" placeholder="UOM Name" onkeypress="return validateTextField('UOMName',30,'UOM Name')">
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
												
														<button type="button" id="btnAddUOM"
															class="btn  btn-primary " onclick="addUOMDetails();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateUOM();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateUOMStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateUOMStatus();">Deactivate</button>
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