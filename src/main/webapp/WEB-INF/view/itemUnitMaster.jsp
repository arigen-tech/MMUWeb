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
		GetAllItemUnit('ALL');			
		});
		
function GetAllItemUnit(MODE){
	var unitName = jQuery("#searchItemUnit").attr("checked", true).val().toUpperCase();
	 var storeUnitId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo,"storeUnitName":""};			
		}
	else
		{
		var data = {"PN":nPageNo, "storeUnitName":unitName};
		}
	var url = "getAllItemUnit";		
	var bClickable = true;
	GetJsonData('tblListOfItemUnit',data,url,bClickable);	 
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
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].storeUnitId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].storeUnitName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfItemUnit").html(htmlTable); 	
	
}

var iuId;
var iuName;
var iuStatus;

function executeClickEvent(storeUnitId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(storeUnitId == data.data[j].storeUnitId){
			iuId = data.data[j].storeUnitId;				
			iuName = data.data[j].storeUnitName;
			iuStatus = data.data[j].status;
			
			
		}
	}
	rowClick(iuId,iuName,iuStatus);
}

function rowClick(iuId,iuName,iuStatus){	
	
	document.getElementById("storeUnitName").value = iuName;
	
			 
	if(iuStatus == 'Y' || iuStatus == 'y'){		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#updateBtn').show();
		$j('#btnAddItemUnit').hide();
		
	}
	if(iuStatus == 'N' || iuStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddItemUnit').hide();
		
	}
	
	
}


var success;
var error;

function addItemUnitDetails(){
	
	if(document.getElementById('storeUnitName').value == null || document.getElementById('storeUnitName').value ==""){
		alert("Please Enter Item Unit Name");
		return false;
	}
	$('#btnAddItemUnit').prop("disabled", true);
	var userId =  $j('#userId').val();
	var params = {			 
			 'storeUnitName':jQuery('#storeUnitName').val(),
			 'userId': userId
	 } 
	    var url = "addItemUnit";
	    SendJsonData(url,params);

}

function updateItemUnit(){	
	if(document.getElementById('storeUnitName').value == null || document.getElementById('storeUnitName').value ==""){
		alert("Please Enter Item Unit Name");
		return false;
	}
		
	var userId =  $j('#userId').val();
	var params = {
			 'storeUnitId':iuId,
			 'storeUnitName':jQuery('#storeUnitName').val(),
			 'userId':userId
			
	 }
		    var url = "updateItemUnitDetails";
            SendJsonData(url,params);
            $j("#btnActive").hide();
	    	$j("#btnInActive").hide();
	    	$j('#updateBtn').hide();
	    	$j('#btnAddItemUnit').show(); 
    
	
	 Reset();
}

function updateItemUnitStatus(){

	if(document.getElementById('storeUnitName').value == null || document.getElementById('storeUnitName').value ==""){
		alert("Please Enter Item Unit Name");
		return false;
	}
	var userId =  $j('#userId').val();
	var params = {
			'storeUnitId':iuId,
			'storeUnitName':iuName,
			 'status':iuStatus,
			 'userId':userId
			 
		} 
		    var url = "updateItemUnitStatus";
	        SendJsonData(url,params);
  	 
	        $j("#btnActive").hide();
	    	$j("#btnInActive").hide();
	    	$j('#updateBtn').hide();
	    	$j('#btnAddItemUnit').show();	    	
	    	ResetFrom();
	        
   
}



function Reset(){
	document.getElementById("addItemUnitForm").reset();
	document.getElementById("searchItemUnitForm").reset();
	document.getElementById('searchItemUnit').value = "";
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddItemUnit').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	showAll();
	
}



function ResetForm()
{	
	$j('#storeUnitCode').val('');
	$j('#storeUnitName').val('');
	$j('#searchItemUnit').val('');
	
}

function showAll()
{

	ResetForm();
	nPageNo = 1;	
	GetAllItemUnit('ALL');
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddItemUnit').show();
	
}

 function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllItemUnit('FILTER');
	
} 
 function search()
 {
 	if(document.getElementById('searchItemUnit').value == ""){
  		alert("Please Enter Item Unit Name");
  		return false;
  	}
 	nPageNo=1;
 	GetAllItemUnit('Filter');
 }

 function generateReport()
 {
	 var url="${pageContext.request.contextPath}/report/generateItemUnitReport";
	 openPdfModel(url);
	 
 	/* document.searchItemUnitForm.action="${pageContext.request.contextPath}/report/generateItemUnitReport";
 	document.searchItemUnitForm.method="POST";
 	document.searchItemUnitForm.submit(); */ 
 	
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
                <div class="internal_Htext">Item Unit Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                     
                                       
                                       <div class="row">               
                                        <div class="col-md-8">
                                            <form class="form-horizontal" id="searchItemUnitForm" name="searchItemUnitForm" method="" role="form">
                                                <div class="form-group row">
                                                    <label class="col-3 col-form-label">Item Unit Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                    <div class="col-4">                                                    
                                                               
                                                              <input type="text" name="searchItemUnit" id="searchItemUnit" class="form-control" id="inlineFormInputGroup" placeholder="Item Unit Name" onkeypress="return validateText('searchItemUnit',30,'item unit name');">
                                                             
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
                  <!--  <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >			<tr>
				<td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
				<td>
				<div id=resultnavigation></div>
				
				</td>
				</tr>
		</table>
 -->
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
                                                <th id="th3" class ="inner_md_htext">Item Unit Name</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                     <tbody class="clickableRow" id="tblListOfItemUnit">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addItemUnitForm" name="addItemUnitForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Item Unit Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="storeUnitName" name="storeUnitName" placeholder="Item Unit Name" onkeypress="return validateText('storeUnitName',30,'item unit name')">
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
												
														<button type="button" id="btnAddItemUnit"
															class="btn  btn-primary " onclick="addItemUnitDetails();">Add</button>
															
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateItemUnit();">Update</button>
															
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateItemUnitStatus();">Activate</button>
															
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateItemUnitStatus();">Deactivate</button>
															
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