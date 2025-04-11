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
	$j('#itemTypeCode').attr('readonly', false);		
		GetAllItemType('ALL');			
		});
		
function GetAllItemType(MODE){
	
	var itemTypeName= jQuery("#searchItemType").attr("checked", true).val().toUpperCase();
	
	//document.getElementById('searchItemType').value = "";
	 var itemTypeId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "itemTypeName":""};			
		}else{
		var data = {"PN":nPageNo, "itemTypeName":itemTypeName};
		} 
	var url = "getAllItemType";		
	var bClickable = true;
	GetJsonData('tblListOfItemType',data,url,bClickable);	 
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
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].itemTypeId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].itemTypeCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].itemTypeName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfItemType").html(htmlTable); 	
	
}

var itId;
var itCode;
var itName;
var itStatus;

function executeClickEvent(itemTypeId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(itemTypeId == data.data[j].itemTypeId){
			itId = data.data[j].itemTypeId;			
			itCode = data.data[j].itemTypeCode;			
			itName = data.data[j].itemTypeName;
			itStatus = data.data[j].status;
			
			
		}
	}
	rowClick(itId,itCode,itName,itStatus);
}

function rowClick(itId,itCode,itName,itStatus){	
		
	document.getElementById("itemTypeCode").value = itCode;
	document.getElementById("itemTypeName").value = itName;
	
			 
	if(itStatus == 'Y' || itStatus == 'y'){		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#updateBtn').show();
		$j('#btnAddItemType').hide();
		$j('#itemTypeCode').attr('readonly', true);
	}
	if(itStatus == 'N' || itStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddItemType').hide();
		$j('#itemTypeCode').attr('readonly', true);
	}
	
	
	
}

function searchItemTypeList(){	
	if(document.getElementById('searchItemType').value == "" || document.getElementById('searchItemType') == null){
		 alert("Plese Enter the Item Type Name");
		 return false;
	 }
		 	 
	 var itemTypeName= jQuery("#searchItemType").attr("checked", true).val().toUpperCase();
		
		var nPageNo=1;
		var url = "getAllItemType";
		var data =  {"PN":nPageNo, "itemTypeName":itemTypeName};
		var bClickable = true;
		GetJsonData('tblListOfItemType',data,url,bClickable);		
}

var success;
var error;

function addItemType(){
	
	if(document.getElementById('itemTypeCode').value == null || document.getElementById('itemTypeCode').value == ""){
		alert("Please Enter Item Type Code");
		return false;
	}
	if(document.getElementById('itemTypeName').value == null || document.getElementById('itemTypeName').value ==""){
		alert("Please Enter Item Type Name");
		return false;
	}
	$('#btnAddItemType').prop("disabled",true);
	var userId =  $j('#userId').val();
	var params = {			 
			 'itemTypeCode':jQuery('#itemTypeCode').val(),
			 'itemTypeName':jQuery('#itemTypeName').val(),
			 'userId':userId
	 } 
	   var url = "addItemType";
	   SendJsonData(url,params);
	    
}

function updateItemType(){	
	
	if(document.getElementById('itemTypeCode').value == null || document.getElementById('itemTypeCode').value == ""){
		alert("Please Enter Item Type Code");
		return false;
	}
	if(document.getElementById('itemTypeName').value == null || document.getElementById('itemTypeName').value ==""){
		alert("Please Enter Item Type Name");
		return false;
	}
		
	var userId =  $j('#userId').val();
	var params = {
			 'itemTypeId':itId,
			 'itemTypeCode':jQuery('#itemTypeCode').val(),
			 'itemTypeName':jQuery('#itemTypeName').val(),
			 'userId':userId
			
	 } 
			
		    var url = "updateItemType";
		    SendJsonData(url,params);
		
		    $j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddItemType').show();
			$j('#itemTypeCode').attr('readonly', false);
			Reset();
}

function updateItemTypeStatus(){
	if(document.getElementById('itemTypeCode').value == null || document.getElementById('itemTypeCode').value == ""){
		alert("Please Enter Item Type Code");
		return false;
	}
	if(document.getElementById('itemTypeName').value == null || document.getElementById('itemTypeName').value ==""){
		alert("Please Enter Item Type Name");
		return false;
	}
	var userId =  $j('#userId').val();
	var params = {
			'itemTypeId':itId,
			 'itemTypeCode':itCode,
			 'status':itStatus,
			 'userId':userId
			 
		} 
		    var url = "updateItemTypeStatus";
	        SendJsonData(url,params);
	 
	        $j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddItemType').show();
			$j('#itemTypeCode').attr('readonly', false);
}

function Reset(){
	
	document.getElementById('searchItemType').value = "";
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddItemType').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	$j('#itemTypeCode').attr('readonly', false);
	showAll();
}



function ResetForm()
{	
	$j('#itemTypeCode').val('');
	$j('#itemTypeName').val('');
	$j('#searchItemType').val('');
	$j('#itemTypeCode').attr('readonly', false);
	
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetAllItemType('ALL');
	
}

 function showResultPage(pageNo)
{
	 
	nPageNo = pageNo;	
	GetAllItemType('FILTER');
	
} 

 function search()
 {
 	if(document.getElementById('searchItemType').value == ""){
 		alert("Please Enter Item Type Name");
 		return false;
 	}
 	nPageNo=1;
 	GetAllItemType('Filter');
 }
 
  function generateReport()
 {
	  var url="${pageContext.request.contextPath}/report/generateItemTypeMasterReport";
	  openPdfModel(url);
 	/* document.searchItemTypeForm.action="${pageContext.request.contextPath}/report/generateItemTypeMasterReport";
 	document.searchItemTypeForm.method="POST";
 	document.searchItemTypeForm.submit(); 
 	 */
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
                <div class="internal_Htext">Item Type Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                      
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchItemTypeForm"
												name="searchItemTypeForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Item Type Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchItemType" id="searchItemType"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Item Type Name" onkeypress="return validateText('searchItemType',30,'Item Type Name');">

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
												<button type="button" class="btn  btn-primary "
												id="printReportButton" 
													onclick="generateReport()">Reports</button>
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
                                                <th id="th2" class ="inner_md_htext">Item Type Code</th>
                                                <th id="th3" class ="inner_md_htext">Item Type Name</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        <!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
                                     <tbody class="clickableRow" id="tblListOfItemType">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addItemTypeForm" name="addItemTypeForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Item Type Code" class=" col-form-label inner_md_htext" >Item Type Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="itemTypeCode" name="itemTypeCode" placeholder="Item Type Code" onkeypress=" return validateText('itemTypeCode',3,'Item Type Code');">
                                                                
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Item Type Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="itemTypeName" name="itemTypeName" placeholder="Item Type Name" onkeypress="return validateText('itemTypeName',30,'Item Type Name');" >
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
												
														<button type="button" id="btnAddItemType"
															class="btn  btn-primary " onclick="addItemType();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateItemType();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateItemTypeStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateItemTypeStatus();">Deactivate</button>
														<button type="button" class="btn btn-danger "
															onclick="Reset();">Reset</button>
													
											</div>
										</div>
									</div>
										
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
