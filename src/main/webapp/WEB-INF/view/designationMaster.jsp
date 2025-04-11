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
	$j('#designationCode').attr('readonly', false);		
		GetAllDesignation('ALL');			
		});
		
function GetAllDesignation(MODE){
	var DesignationName = jQuery("#searchDesignation").attr("checked", true).val().toUpperCase();
	 var designationId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo,"designationName":""};			
		}
	else
		{
		var data = {"PN":nPageNo, "designationName":DesignationName};
		}
	var url = "getAllDesignations";		
	var bClickable = true;
	GetJsonData('tblListOfDesignation',data,url,bClickable);	 
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
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].designationId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].designationCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].designationName+"</td>";
			//htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='2'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfDesignation").html(htmlTable); 	
	
}

var desigId;
var desigCode;
var desigName;
var desigStatus;

function executeClickEvent(designationId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(designationId == data.data[j].designationId){
			desigId = data.data[j].designationId;			
			desigCode = data.data[j].designationCode;			
			desigName = data.data[j].designationName;
			desigStatus = data.data[j].status;
			
			
		}
	}
	rowClick(desigId,desigCode,desigName,desigStatus);
}

function rowClick(desigId,desigCode,desigName,desigStatus){	
	
	document.getElementById("designationCode").value = desigCode;
	document.getElementById("designationName").value = desigName;
	
			 
	if(desigStatus == 'Y' || desigStatus == 'y'){		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#updateBtn').show();		
		$j('#btnAddDesignation').hide();
	}
	if(desigStatus == 'N' || desigStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
	}
	
	$j("#btnActive").attr("disabled", false);
	$j("#btnInActive").attr("disabled", false);
	$j('#updateBtn').attr("disabled", false);
	$j('#btnAddDesignation').hide();
	$j('#designationCode').attr('readonly', true);
	
}


function search()
{
	if(document.getElementById('searchDesignation').value == ""){
 		alert("Please Enter Designation Name");
 		return false;
 	}
	nPageNo=1;
	GetAllDesignation('Filter');
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetAllDesignation('ALL');
	
}

 function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllDesignation('FILTER');
	
} 




 function addDesignationDetails(){
		if(document.getElementById('designationCode').value == null || document.getElementById('designationCode').value == ""){
			alert("Please Enter Designation Code");
			return false;
		}
		if(document.getElementById('designationName').value == null || document.getElementById('designationName').value ==""){
			alert("Please Enter Designation Name");
			return false;
		}
		
		var userId =  $j('#userId').val();
		var params = {			 
				 'designationCode':jQuery('#designationCode').val(),
				 'designationName':jQuery('#designationName').val(),
				 'userId':userId
		 } 
		   var url = "addDesignation";
		   SendJsonData(url,params);
		   ResetForm();
	}



 
 function updateDesignation(status){	
		if(document.getElementById('designationCode').value == null || document.getElementById('designationCode').value == ""){
			alert("Please Enter Designation Code");
			return false;
		}
		if(document.getElementById('designationName').value == null || document.getElementById('designationName').value ==""){
			alert("Please Enter Designation Name");
			return false;
		}
			
		var userId =  $j('#userId').val();
		var params = {
				 'designationId':desigId,
				 'designationCode':jQuery('#designationCode').val(),
				 'designationName':jQuery('#designationName').val(),
				 'status':status,
				 'userId':userId
		 } 
		
			    var url = "updateDesignationDetails";
			    SendJsonData(url,params);
			    $j('#updateBtn').hide();
			    //$j('#updateBtn').attr("disabled", true);
				$j('#btnAddDesignation').attr("disabled", false);
				
				activeDeactiveBtns(status);
				GetAllDesignation('FILTER');
				ResetForm();
	}
 
 function activeDeactiveBtns(status){
	 if(status == 'active'){
			$j('#updateBtn').show();
			$j("#btnActive").hide();
			$j("#btnInActive").show();
		}else if(status == 'inactive'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
		}else{
			$j('#updateBtn').show();
		}
 }
 

 function ResetForm()
 {	
 	$j('#designationCode').val('');
 	$j('#designationName').val('');
 	$j('#searchDesignation').val('');
 	
 }
 
 function Reset(){
		document.getElementById("addDesignationForm").reset();
		document.getElementById("searchDesignationForm").reset();
		document.getElementById('searchDesignation').value = "";
		
		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddDesignation').show();
		document.getElementById("messageId").innerHTML = "";
		$("#messageId").css("color", "black");
		$j('#designationCode').attr('readonly', false);
		showAll();
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
                <div class="internal_Htext">Designation Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                     
                                        <div class="row">               
                                        <div class="col-md-8">
                                            <form class="form-horizontal" id="searchDesignationForm" name="searchDesignationForm" method="" Designation="form">
                                                <div class="form-group row">
                                                    <label class="col-3 col-form-label">Designation Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                    <div class="col-4">                                                    
                                                               
                                                              <input type="text" name="searchDesignation" id="searchDesignation" class="form-control" id="inlineFormInputGroup" placeholder="Designation Name" onkeypress="return validateText('searchDesignation',30,'Designation Name');">
                                                             
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
                                                    <!-- <button type="button" class="btn  btn-primary " onclick="generateReport()">Reports</button> -->
                                              </div>
                                        </div>

                                    </div>
                                       
				
		
			<div style="float:left">
               
           <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >   <tr>
           <td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
           <td>
                      
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
                                                <th id="th2" class ="inner_md_htext">Designation Code</th>
                                                <th id="th3" class ="inner_md_htext">Designation Name</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfDesignation">
										 
                     				 </tbody>
                                    </table>

                                   <%--  <div class="row">
                                        <div class="col-md-12">
                                            <form id="addDesignationForm" name="addDesignationForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Designation Code" class=" col-form-label inner_md_htext" >Designation Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="designationCode" name="designationCode" placeholder="Designation Code" onkeypress=" return validateText('designationCode',7,'Designation Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Designation Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="designationName" name="designationName" placeholder="Designation Name" onkeypress="return validateCommonText('designationName',30,'Designation Name');" >
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

                                    </div> --%>
									 
         							<br>
								<!-- 	<div class="row">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
												
														<button type="button" id="btnAddDesignation"
															class="btn  btn-primary " onclick="addDesignationDetails();">Add</button>
															
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateDesignation('update');">Update</button>
															
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateDesignation('active');">Activate</button>
															
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateDesignation('inactive');">Deactivate</button>
															
														<button type="button" class="btn btn-danger "
															onclick="Reset();">Reset</button>
													
											</div>
										</div>
									</div> -->

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