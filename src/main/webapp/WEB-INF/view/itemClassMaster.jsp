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

<script type="text/javascript" language="javascript">
var nPageNo=1;
var Status;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{	
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#itemClassCode').attr('readonly', false);
			GetItemClassList('ALL');
			GetStoreSectionList();
		});
		
function GetItemClassList(MODE)
{
	var itemClassName= jQuery("#searchItemClass").val().toUpperCase();
		
	var itemClassId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "itemClassName":""};			
		}
	else
		{
		var data = {"PN":nPageNo,"itemClassName":itemClassName};
		} 
	var url = "getAllItemClassDetails";
		
	var bClickable = true;
	GetJsonData('tblListOfItemClass',data,url,bClickable);
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
		 
		
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].itemClassId+"' >";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].itemClassCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].itemClassName+"</td>";			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].sectionName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";
			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblListOfItemClass").html(htmlTable);	
	
	
}
var comboArray = [];
var icId;
var icCode;
var icName;
var icStatus;
var ssId;
var ssName;
function executeClickEvent(itemClassId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(itemClassId == data.data[j].itemClassId){
			icId = data.data[j].itemClassId;
			icCode = data.data[j].itemClassCode;
			icName = data.data[j].itemClassName;
			icStatus = data.data[j].status;
			ssId = data.data[j].sectionId;
			ssName = data.data[j].sectionName;
			
		}
	}
	rowClick(icId,icCode,icName,icStatus,ssId,ssName);
}

function searchItemClassList(){
	 if(document.getElementById('searchItemClass').value == "" || document.getElementById('searchItemClass') == null){
		 alert("Plese Enter the Item Class Name");
		 return false;
	 }
	 
	var ItemClassName= jQuery("#searchItemClass").attr("checked", true).val().toUpperCase();
	var nPageNo=1;
	var url = "getAllItemClassDetails";
	var data =  {"PN":nPageNo, "itemClassName":itemClassName};
	var bClickable = true;
	GetJsonData('tblListOfItemClass',data,url,bClickable);
	
}
var success;
var error;

function addItemClassDetails(){
	
	if(document.getElementById('itemClassCode').value==""){
		alert("Please Enter the Item Class Code");
		return false;
	}
	if(document.getElementById('itemClassName').value==""){
		alert("Please Enter the Item Class Name");
		return false;
	}
	if(document.getElementById('selectSection').value==""){
		alert("Please select Section");
		return false;
	}
	$('#btnAddItemClass').prop("disabled",true);
	var params = {
			 
			 'itemClassCode':jQuery('#itemClassCode').val(),
			 'itemClassName':jQuery('#itemClassName').val(),
			 'sectionId':jQuery('#selectSection').find('option:selected').val(),
			 'userId':$j('#userId').val()
	 } 	
	//alert(JSON.stringify(params));
	var url="addItemClass";
	    SendJsonData(url,params);
}

function updateItemClassDetails()
{	
	if(document.getElementById('itemClassCode').value == "" || document.getElementById('itemClassCode').value == null ){
		alert("please enter the Item Class Code");
		return false;
	}
	if(document.getElementById('itemClassName').value == "" || document.getElementById('itemClassName').value == null ){
		alert("please enter the Item Class Name");
		return false;
	}
	
	if(document.getElementById('selectSection').value == "" || document.getElementById('selectSection').value == null ){
		alert("please select Section");
		return false;
	}
	var userId =  $j('#userId').val();	
	var params = {
			 'itemClassId':icId,
			 'itemClassCode':jQuery('#itemClassme').val(),
			 'itemClassName':jQuery('#itemClassName').val(),
			 'sectionId':jQuery('#selectSection').find('option:selected').val(),
			 'userId':userId
	 } 
	var url="updateItemClassDetails";
	SendJsonData(url,params);	
	GetItemClassList();	 		
	$j('#updateBtn').hide();
	$j('#btnAddItemClass').show();
	$j('#itemClassCode').attr('readonly', true);
	Reset();
	
}

function updateStatus(){
	if(document.getElementById('itemClassCode').value == "" || document.getElementById('itemClassCode').value == null ){
		alert("Please Select the Item Class");
		return false;
	}
	var userId =  $j('#userId').val();
	 var params = {
		 'itemClassId':icId,		 
		 'status':icStatus		
		 
	}  
	 var url= "updateItemClassStatus";
		    SendJsonData(url,params);
		    
		    $j("#btnActive").hide();
		    $j("#updateBtn").hide();
			 $j("#btnInActive").hide();
			 $j('#btnAddItemClass').show();
}



function GetStoreSectionList(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getAllStoreSectionDetails",
	    data: JSON.stringify({"PN":"0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		comboArray[i] = result.data[i].sectionName;
	    		combo += '<option value='+result.data[i].sectionId+'>' +result.data[i].sectionName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);
	    		
	    		
	    	}
	    	jQuery('#selectSection').append(combo);
	    }
	    
	});
}

function rowClick(icId,icCode,icName,icStatus,ssId,ssName){	
	document.getElementById("itemClassCode").value = icCode;
	document.getElementById("itemClassName").value = icName;
	for(var j=0; j<comboArray.length;j++){		
		
		if(comboArray[j] == ssName){
			
			jQuery("#selectSection").val(ssId);
		}
	}
	
if(icStatus == 'Y' || icStatus == 'y'){
		
	$j("#btnInActive").show();
	$j("#btnActive").hide();
    $j("#updateBtn").show();
    $j("#btnAddItemClass").hide();
	}
	if(icStatus == 'N' || icStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j("#updateBtn").hide();
	}
	
	
	$j('#btnAddItemClass').hide();	
	 $j('#itemClassCode').attr('readonly', true);
	
}

/* function changeSection(value){
	
	var sectionId = jQuery('#selectSection').find('option:selected').val();
	
	if(value == sectionId){
		$j('#updateBtn').attr("disabled", false);
	}
	
} */
function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetItemClassList('FILTER');
	
}

function Reset(){
	document.getElementById("addItemClassForm").reset();
	document.getElementById("searchItemClassForm").reset();
	document.getElementById('searchItemClass').value = "";
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddItemClass').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	$j('#itemClassCode').attr('readonly', false);
	showAll();
}



function ResetForm()
{	
	$j('#itemClassCode').val('');
	$j('#itemClassName').val('');
	$j('#selectSection').val('');
	$j('#searchItemClass').val('');
	
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetItemClassList('ALL');
	$j('#itemClassCode').attr('readonly', false);
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddItemClass').show();
	
}

function enableAddButton(){
	if(document.getElementById("itemClassCode").value!=null || !document.getElementById("itemClassCode").value==""){
		$j('#btnAddItemClass').attr("disabled", false);
	}else if( document.getElementById("itemClassName").value!=null || !document.getElementById("itemClassName").value==""){
		$j('#btnAddItemClass').attr("disabled", false);
	}else{
		$j('#btnAddItemClass').attr("disabled", true);
	}
}

function search()
{
	if(document.getElementById('searchItemClass').value == ""){
		alert("Please Enter Item Class Name");
		return false;
	}
	nPageNo=1;
	GetItemClassList('Filter');
}

 function generateReport()
{
	 var url="${pageContext.request.contextPath}/report/generateItemClassMasterReport";
	 openPdfModel(url);
	/* document.searchItemClassForm.action="${pageContext.request.contextPath}/report/generateItemClassMasterReport";
	document.searchItemClassForm.method="POST";
	document.searchItemClassForm.submit();  */
	
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
                <div class="internal_Htext">Item Class Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       <br>
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchItemClassForm"
												name="searchItemClassForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Item Class Name <span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchItemClass" id="searchItemClass"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Item Class Name" onkeypress="return validateText('searchItemClass',30,'Item Class Name');">

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
                                                <th id="th2" class ="inner_md_htext">Item Class Code</th>
                                                <th id="th3" class ="inner_md_htext">Item Class Name</th>
                                                <th id="th4" class ="inner_md_htext"> Section Name </th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        <!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
                                     <tbody class="clickableRow" id="tblListOfItemClass">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addItemClassForm" name="addItemClassForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Section Code" class=" col-form-label inner_md_htext" >Item Class Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="itemClassCode" name="itemClassCode" placeholder="Item Class Code" onkeypress=" return validateText('itemClassCode',7,'Item Class Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Item Class Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="itemClassName" name="itemClassName" placeholder="Item Class Name" onkeypress="return validateText('itemClassName',30,'Item Class Name')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Section Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectSection" >
                                                                    
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
												
														<button type="button" id="btnAddItemClass"
															class="btn  btn-primary " onclick="addItemClassDetails();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateItemClassDetails();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateStatus();">Deactivate</button>
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