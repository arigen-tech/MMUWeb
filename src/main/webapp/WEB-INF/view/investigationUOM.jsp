<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Indian Coast Guard</title>
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
	$j('#uomCode').attr('readonly', false);		
	GetAllInvestigationUOM('ALL');			
		});
		
function GetAllInvestigationUOM(MODE){
	 
	var uomName=$("#searchUOM").val();
	
	 var sampleId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "uomName":""};			
		}else{
		var data = {"PN":nPageNo, "uomName":uomName};
		} 
	var url = "getAllInvestigationUOM";		
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
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].uomId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].uomCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].uomName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfUOM").html(htmlTable); 	
	
}

var iuId;
var uomCode;
var uomName;
var uomStatus;

function executeClickEvent(uomId,data)
{
	iuId=uomId;
	
	for(j=0;j<data.data.length;j++){
		if(iuId == data.data[j].uomId){
			iuId = data.data[j].uomId;			
			uomCode = data.data[j].uomCode;			
			uomName = data.data[j].uomName;
			uomStatus = data.data[j].status;
			
			
		}
	}
	rowClick(iuId,uomCode,uomName,uomStatus);
}

function rowClick(uomId,uomCode,uomName,uomStatus){	
	
	
	document.getElementById("uomCode").value = uomCode;
	document.getElementById("uomName").value = uomName;
				 
	if(uomStatus == 'Y' || uomStatus == 'y'){		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#updateBtn').show();
		$j('#btnAddUom').hide();
	}
	if(uomStatus == 'N' || uomStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddUom').hide();
	}
	
	
	$j('#uomCode').attr('readonly', true);
	
}




function addInvestigationUOM(){
	
	if(document.getElementById('uomCode').value == null || document.getElementById('uomCode').value == ""){
		alert("Please Enter UOM Code");
		return false;
	}
	if(document.getElementById('uomName').value == null || document.getElementById('uomName').value ==""){
		alert("Please Enter UOM Name");
		return false;
	}
	
	$('#btnAddUom').prop("disabled",true);
	var params = {		
			
			 'uomCode':jQuery('#uomCode').val(),
			 'uomName':jQuery('#uomName').val(),
			 'userId': <%= userId%>
	 }
	
	//alert(JSON.stringify(params));
	    var url = "addInvestigationUOM";
	    SendJsonData(url,params);
	
	    
}

function updateInvestigationUOM(){	
	if(document.getElementById('uomCode').value == null || document.getElementById('uomCode').value == ""){
		alert("Please Enter UOM Code");
		return false;
	}
	if(document.getElementById('uomName').value == null || document.getElementById('uomName').value ==""){
		alert("Please Enter UOM Name");
		return false;
	}
		
	
	var params = {
			 'uomId':iuId,
			 'uomCode':jQuery('#uomCode').val(),
			 'uomName':jQuery('#uomName').val(),
			 'userId': <%=userId %>
			
	 } 
	//alert(JSON.stringify(params));
		    var url = "updateInvestigationUOM";
		    SendJsonData(url,params);
			$j('#btnAddUom').attr("disabled", false);
			$j('#uomCode').attr('readonly', true);
			Reset();
}

function updateInvestigationUOMStatus(){
	if(document.getElementById('uomCode').value == null || document.getElementById('uomCode').value == ""){
		alert("Please Enter UOM Code");
		return false;
	}
	if(document.getElementById('uomName').value == null || document.getElementById('uomName').value ==""){
		alert("Please Enter UOM Name");
		return false;
	}
	
	var params = {
			
			'uomId':iuId,			 
			 'status':uomStatus
	 
		} 
	
	//alert(JSON.stringify(params));
		    var url = "updateInvestigationUOMStatus";
	        SendJsonData(url,params);
	 
     
}

function Reset(){
	
	document.getElementById('searchUOM').value = "";
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddUom').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	$j('#uomCode').attr('readonly', false);
	showAll();
}



function ResetForm()
{	
	$j('#uomCode').val('');
	$j('#uomName').val('');
	$j('#searchUOM').val('');
	
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetAllInvestigationUOM('ALL');
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddUom').show();
	$j('#uomCode').attr('readonly', false);
	
	
}
 function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllInvestigationUOM('FILTER');
	
} 

 function search()
 {
 	if(document.getElementById('searchUOM').value == ""){
  		alert("Please Enter UOM Name");
  		return false;
  	}
 	nPageNo=1;
 	GetAllInvestigationUOM('FILTER');
 }
 
 function generateReport()
 {
	var url="${pageContext.request.contextPath}/report/generateInvestigationUOMReport";
	 openPdfModel(url);
 	/* document.searchUOMForm.action="${pageContext.request.contextPath}/report/generateInvestigationUOMReport";
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
                <div class="internal_Htext">Investigation UOM Master</div>
                    
                    <!-- end row -->
                   
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
															placeholder="UOM Name" onkeypress="return validateText('searchUOM',30,'UOM Name')">

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
                                                <th id="th2" class ="inner_md_htext">UOM Code</th>
                                                <th id="th3" class ="inner_md_htext">UOM Name</th>
                                                <th id="th4" class ="inner_md_htext">Status</th>
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
                                                            <label for="UOM Code" class=" col-form-label inner_md_htext" >UOM Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="uomCode" name="uomCode" placeholder="UOM Code" onkeypress=" return validateText('uomCode',7,'UOM Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="UOM name" class="col-form-label inner_md_htext">UOM Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="uomName" name="uomName" placeholder="UOM Name" onkeypress="return validateText('uomName',30,'UOM Name')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
										<input type="hidden"  id="rowId" name="rowId">
																											
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
												
														<button type="button" id="btnAddUom"
															class="btn  btn-primary " onclick="addInvestigationUOM();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateInvestigationUOM();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateInvestigationUOMStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateInvestigationUOMStatus();">Deactivate</button>
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
