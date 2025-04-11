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
	$j('#supplierTypeCode').attr('readonly', false);		
		GetAllVendorType('ALL');			
		});
		
function GetAllVendorType(MODE){
	var supplierTypeName= jQuery("#searchSupplierType").attr("checked", true).val().toUpperCase();
	 var supplierTypeId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "supplierTypeName":""};			
		}
	else
		{
		var data = {"PN":nPageNo, "supplierTypeName":supplierTypeName};
		} 
	var url = "getAllVendorType";		
	var bClickable = true;
	GetJsonData('tblListOfVendorType',data,url,bClickable);	 
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
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].supplierTypeId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].supplierTypeCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].supplierTypeName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='3'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfVendorType").html(htmlTable); 	
	
}

var sstId;
var sstCode;
var sstName;
var sstStatus;

function executeClickEvent(supplierTypeId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(supplierTypeId == data.data[j].supplierTypeId){
			sstId = data.data[j].supplierTypeId;			
			sstCode = data.data[j].supplierTypeCode;			
			sstName = data.data[j].supplierTypeName;
			sstStatus = data.data[j].status;
			
			
		}
	}
	rowClick(sstId,sstCode,sstName,sstStatus);
}

function rowClick(sstId,sstCode,sstName,sstStatus){	
		
	document.getElementById("supplierTypeCode").value = sstCode;
	document.getElementById("supplierTypeName").value = sstName;
	
			 
	if(sstStatus == 'Y' || sstStatus == 'y'){		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#updateBtn').show();
	}
	if(sstStatus == 'N' || sstStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
	}
	
	$j("#btnActive").attr("disabled", false);
	$j("#btnInActive").attr("disabled", false);
	$j('#updateBtn').attr("disabled", false);
	$j('#btnAddSupplierType').hide();
	$j('#supplierTypeCode').attr('readonly', true);
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

function addVendorTypeDetails(){
	
	if(document.getElementById('supplierTypeCode').value == null || document.getElementById('supplierTypeCode').value == ""){
		alert("Please Enter Vendor Type Code");
		return false;
	}
	if(document.getElementById('supplierTypeName').value == null || document.getElementById('supplierTypeName').value ==""){
		alert("Please Enter Vendor Type Name");
		return false;
	}
	$('#btnAddSupplierType').prop("disabled",true);
	var userId =  $j('#userId').val();
	var params = {			 
			 'supplierTypeCode':jQuery('#supplierTypeCode').val(),
			 'supplierTypeName':jQuery('#supplierTypeName').val(),
			 'userId':userId
	 } 
	
	var url="addvendorType";
	
	SendJsonData(url,params);
    
}

function updateVendorType(){	
	if(document.getElementById('supplierTypeCode').value == null || document.getElementById('supplierTypeCode').value == ""){
		alert("Please Enter Vendor Type Code");
		return false;
	}
	if(document.getElementById('supplierTypeName').value == null || document.getElementById('supplierTypeName').value ==""){
		alert("Please Enter Vendor Type Name");
		return false;
	}
		
	var userId =  $j('#userId').val();
	var params = {
			 'supplierTypeId':sstId,
			 'supplierTypeCode':jQuery('#supplierTypeCode').val(),
			 'supplierTypeName':jQuery('#supplierTypeName').val(),
			 'userId':userId
			
	 } 
	
	var url="updateVendorTypeDetails";
	SendJsonData(url,params);	
 		 		
	$j('#updateBtn').show();
	$j('#btnAddSupplierType').attr("disabled", false);
	$j('#supplierTypeCode').attr('readonly', true);
	Reset();
		
		$j('#updateBtn').attr("disabled", true);
}

function updateVendorTypeStatus(){
	if(document.getElementById('supplierTypeCode').value == null || document.getElementById('supplierTypeCode').value == ""){
		alert("Please Enter Vendor Type Code");
		return false;
	}
	if(document.getElementById('supplierTypeName').value == null || document.getElementById('supplierTypeName').value ==""){
		alert("Please Enter Vendor Type Name");
		return false;
	}
	var userId =  $j('#userId').val();
	var params = {
			'supplierTypeId':sstId,
			 'supplierTypeCode':sstCode,
			 'status':sstStatus,
			 'userId':userId
			 
		} 
	 var url= "updateVendorTypeStatus";
    SendJsonData(url,params);
    
    $j("#btnActive").hide();
	 $j("#btnInActive").hide();
	 $j('#btnAddSupplierType').show();
	$j('#updateBtn').hide();
}


function Reset(){
	//document.getElementById("addSupplierTypeForm").reset();
	//document.getElementById("searchSupplierTypeForm").reset();
	document.getElementById('searchSupplierType').value = "";
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddSupplierType').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	$j('#supplierTypeCode').attr('readonly', false);
	showAll();
}



function ResetForm()
{	
	$j('#supplierTypeCode').val('');
	$j('#supplierTypeName').val('');
	$j('#searchSupplierType').val('');
	$j('#supplierTypeCode').attr('readonly', false);
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetAllVendorType('ALL');
	
}

 function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllVendorType('FILTER');
	
}
 function search()
 {
 	if(document.getElementById('searchSupplierType').value == ""){
 		alert("Please Enter Vendor Type Name");
 		return false;
 	}
 	nPageNo=1;
 	GetAllVendorType('Filter');
 }
 
 function generateReport()
 {
	var url="${pageContext.request.contextPath}/report/generateVendorTypeMasterReport";
	openPdfModel(url);

 	/* document.searchSupplierTypeForm.action="${pageContext.request.contextPath}/report/generateVendorTypeMasterReport";
 	document.searchSupplierTypeForm.method="POST";
 	document.searchSupplierTypeForm.submit();  */
 	
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
                <div class="internal_Htext">Vendor Type Master</div>               
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       
                                        <form class="form-horizontal" id="searchSupplierTypeForm" name="searchSupplierTypeForm" method="" role="form">  
                                    <div class="row">
                                                                     
                                        <div class="col-md-8">
                                         
                                                <div class="form-group row">
                                                    <label class="col-3 col-form-label">Vendor Type Name <span style="color:red">*</span> </label>
                                                    <div class="col-5">
                                                        <div class="col-auto">
                                                            <label class="sr-only" for="inlineFormInputGroup">Vendor Type Name</label>
                                                            <div class="input-group mb-2">
                                                                <!-- <div class="input-group-prepend">
                                                                    <div class="input-group-text">&#128269;</div>
                                                                </div> -->
                                                                <input type="text" name="searchSupplierType" id="searchSupplierType" class="form-control" id="inlineFormInputGroup" placeholder="Vendor Type Name" onkeypress="return validateText('supplierTypeName',30,'Vendor Type Name');">
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
                                                    <!-- <button type="button" class="btn  btn-primary" 
                                                    id="printReportButton" 
                                                    onclick="generateReport()">Reports</button> -->

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
                                                <th id="th2" class ="inner_md_htext">Vendor Type Code</th>
                                                <th id="th3" class ="inner_md_htext">Vendor Type Name</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        <!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
                                     <tbody class="clickableRow" id="tblListOfVendorType">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addSupplierTypeForm" name="addSupplierTypeForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Supplier Type Code" class=" col-form-label inner_md_htext" >Vendor Type Code <span style="color:red">*</span> </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="supplierTypeCode" name="supplierTypeCode" placeholder="Vendor Type Code" onkeypress=" return validateText('supplierTypeCode',7,'Vendor Type Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Vendor Type Name <span style="color:red">*</span> </label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="supplierTypeName" name="supplierTypeName" placeholder="Vendor Type Name" onkeypress="return validateText('supplierTypeName',100,'Vendor Type Name');"
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
												
														<button type="button" id="btnAddSupplierType" class="btn btn-primary" onclick="addVendorTypeDetails();">Add</button>
                                                    <button type="button" id ="updateBtn" class="btn btn-primary" onclick="updateVendorType();">Update</button>
                                                    <button id="btnActive" type="button" class="btn btn-primary" onclick="updateVendorTypeStatus();">Activate</button>
                                      				<button id="btnInActive" type="button" class="btn btn-primary" onclick="updateVendorTypeStatus();">Deactivate</button>
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