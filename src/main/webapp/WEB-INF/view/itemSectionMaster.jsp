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
			GetStoreSectionList('ALL');
			$j('#sectionCode').attr('readonly', false);
			//GetItemTypeList();
		});
		
function GetStoreSectionList(MODE)
{
	var sectionName= jQuery("#searchStoreSection").val().toUpperCase();
		
	var sectionId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "sectionName":""};			
		}
	else
		{
		var data = {"PN":nPageNo,"sectionName":sectionName};
		} 
	var url = "getAllStoreSectionDetails";
		
	var bClickable = true;
	GetJsonData('tblListOfStoreSection',data,url,bClickable);
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
		 
		
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].sectionId+"' >";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].sectionCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].sectionName+"</td>";			
			//htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].itemTypeName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";
			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='3'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblListOfStoreSection").html(htmlTable);	
	
	
}
var comboArray = [];
var ssId;
var ssName;
var ssCode;
var ssStatus;
function executeClickEvent(sectionId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(sectionId == data.data[j].sectionId){
			ssId = data.data[j].sectionId;
			ssName = data.data[j].sectionName;
			ssCode = data.data[j].sectionCode;
			ssStatus = data.data[j].status;
						
		}
	}
	rowClick(ssId,ssCode,ssName,ssStatus);
}

function searchStoreSectionList(){
	 if(document.getElementById('searchStoreSection').value == "" || document.getElementById('searchStoreSection') == null){
		 alert("Plese Enter the Section Name");
		 return false;
	 }
	 
	var SectionName= jQuery("#searchStoreSection").val().toUpperCase();
	var nPageNo=1;
	var url = "getAllStoreSectionDetails";
	var data =  {"PN":nPageNo, "sectionName":sectionName};
	var bClickable = true;
	GetJsonData('tblListOfStoreSection',data,url,bClickable);
	ResetFrom();
}
var success;
var error;

function addStoreSectionDetails(){
	
	if(document.getElementById('sectionCode').value==""){
		alert("Please Enter the Section Code");
		return false;
	}
	if(document.getElementById('sectionName').value==""){
		alert("Please Enter the Section Name");
		return false;
	}
	/* if(document.getElementById('selectItemType').value==""){
		alert("Please Enter the Item Type");
		return false;
	} */
	$('#btnAddStoreSection').prop("disabled",true);
	var userId =  $j('#userId').val();
	var params = {
			'sectionCode':jQuery('#sectionCode').val(),
			 'sectionName':jQuery('#sectionName').val(),
			 'userId':userId

	 } 	
	
	var url="addStoreSection";
	    SendJsonData(url,params);
}

function updateStoreSectionDetails()
{	
	
	if(document.getElementById('sectionName').value == "" || document.getElementById('sectionName').value == null ){
		alert("please enter the Section Name");
		return false;
	}
		
	var userId =  $j('#userId').val();	
	var params = {
			 'sectionId':ssId,			
			 'sectionName':jQuery('#sectionName').val(),			 
			 'userId':userId
	 } 
	var url="updateStoreSectionDetails";
	SendJsonData(url,params);	
	GetStoreSectionList();	 		

    $j("#btnActive").hide();
	 $j("#btnInActive").hide();
	 $j('#updateBtn').hide();
	 $j('#btnAddStoreSection').show();
	Reset();
	
}

function updateStatus(){
	
	var userId =  $j('#userId').val();
	 var params = {
		 'sectionId':ssId,
		 'status':ssStatus,
		 'userId':userId
		 
	}  
	 //alert(JSON.stringify(params));
	 var url= "updateStoreSectionStatus";
		    SendJsonData(url,params);
		    
		    $j("#btnActive").hide();
			 $j("#btnInActive").hide();
			 $j('#updateBtn').hide();
			 $j('#btnAddStoreSection').show();
}



function GetItemTypeList(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,	    
	    url: "getAllItemType",
	    data: JSON.stringify({"PN":"0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		comboArray[i] = result.data[i].itemTypeName;
	    		combo += '<option value='+result.data[i].itemTypeId+'>' +result.data[i].itemTypeName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);
	    		
	    		
	    	}
	    	jQuery('#selectItemType').append(combo);
	    }
	    
	});
}

function rowClick(ssId,ssCode,ssName,ssStatus){	
	
	document.getElementById("sectionName").value = ssName;
	document.getElementById("sectionCode").value = ssCode
	$j('#sectionCode').attr('readonly', true);
if(ssStatus == 'Y' || ssStatus == 'y'){
		
	$j("#btnInActive").show();
	$j("#btnActive").hide();
    $j("#updateBtn").show();
    $j("#btnAddStoreSection").hide();
	}
	if(ssStatus == 'N' || ssStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j("#updateBtn").hide();
	}
	
	/* $j('#updateBtn').attr("disabled", false); */
	$j('#btnAddStoreSection').hide();
	
	 
	
}


function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetStoreSectionList('FILTER');
	
}

function Reset(){
	document.getElementById("addStoreSectionForm").reset();
	document.getElementById("searchStoreSectionForm").reset();
	document.getElementById('searchStoreSection').value = "";
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddStoreSection').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	$j('#sectionCode').attr('readonly', false);
	showAll();
}



function ResetForm()
{	
	
	$j('#sectionName').val('');
	$j('#sectionCode').val('');
	$j('#sectionCode').attr('readonly', false);
	$j('#searchStoreSection').val('');
	
	
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetStoreSectionList('ALL');
	
}

function enableAddButton(){
	if(document.getElementById("sectionCode").value!=null || !document.getElementById("sectionCode").value==""){
		$j('#btnAddStoreSection').attr("disabled", false);
	}else if( document.getElementById("sectionName").value!=null || !document.getElementById("sectionName").value==""){
		$j('#btnAddStoreSection').attr("disabled", false);
	}else{
		$j('#btnAddStoreSection').attr("disabled", true);
	}
}

function search()
{
	if(document.getElementById('searchStoreSection').value == ""){
		alert("Please Enter Section Name");
		return false;
	}
	nPageNo=1;
	GetStoreSectionList('Filter');
}

 function generateReport()
{
	var url="${pageContext.request.contextPath}/report/generateItemSectionMasterReport";
	 openPdfModel(url);
 
	/* document.searchStoreSectionForm.action="${pageContext.request.contextPath}/report/generateItemSectionMasterReport";
	document.searchStoreSectionForm.method="POST";
	document.searchStoreSectionForm.submit();  */
	
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
                <div class="internal_Htext">Item Section Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                        
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchStoreSectionForm"
												name="searchStoreSectionForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Section Name <span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchStoreSection" id="searchStoreSection"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Section Name" onkeypress="return validateText('searchStoreSection',30,'Section Name');">

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
                                                <th id="th1" class ="inner_md_htext">Section Code</th>
                                                <th id="th1" class ="inner_md_htext">Section Name</th>                                                
                                                <th id="th2" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        <!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
                                     <tbody class="clickableRow" id="tblListOfStoreSection">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addStoreSectionForm" name="addStoreSectionForm" method="">
                                                <div class="row">
                                                   <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Section Code" class=" col-form-label inner_md_htext" >Section Code <span style="color:red">*</span> </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="sectionCode" name="sectionCode" placeholder="Section Code" onkeypress=" return validateText('sectionCode',7);">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Section Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="sectionName" name="sectionName" placeholder="Section Name" onkeypress="return validateText('sectionName',30,'Section Name')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label for="recordoffice" class="col-sm-5 col-form-label inner_md_htext">Item Type <span style="color:red">*</span> </label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="selectItemType" onchange="changeItemType(this.value);">
                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div> -->
                                                    
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
												
														<button type="button" id="btnAddStoreSection"
															class="btn  btn-primary " onclick="addStoreSectionDetails();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateStoreSectionDetails();">Update</button>
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

