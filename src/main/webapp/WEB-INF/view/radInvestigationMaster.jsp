<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
var nPageNo=1;
var Status;
var $j = jQuery.noConflict();
var investId;
var invType=resourceJSON.mainchargeCodeRadio;	
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
			$j("#btnAddInvestigation").show();
			GetAllInvestigationDetails('ALL');
			GetMainChargeList();
			GetModalityList(invType);
			$("#resultBtn").hide();
			
		});
	
function GetAllInvestigationDetails(MODE)
{
	var investigationName= jQuery("#searchInvName").val().toUpperCase();
			
	var invId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "investigationName":"","investigationType":invType};			
		}
	else
		{
		var data = {"PN":nPageNo,"investigationName":investigationName,"investigationType":invType};
		} 
	var url = "getAllInvestigationDetails";
		
	var bClickable = true;
	GetJsonData('tblListOfInvestigation',data,url,bClickable);
}
function makeTable(jsonData)
{	
	var htmlTable = "";	
	
	
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
		 
		
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].investigationId+"' >";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].investigationName+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].deptName+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].modalityName+"</td>";			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";
			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='5'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblListOfInvestigation").html(htmlTable);	
	
	
}
var comboArray = [];
var invId;
var invName;
var iStatus;
var dptId;
var dptName;
var modId;
var modName;
var result;
var minval;
var maxval;
var confidential;
function executeClickEvent(invId,data)
{
	investId=invId;	
	for(j=0;j<data.data.length;j++){
		if(invId == data.data[j].investigationId){
			invId = data.data[j].investigationId;
			invName = data.data[j].investigationName;
			deptId = data.data[j].deptId;
			deptName = data.data[j].deptName;
			modId = data.data[j].modalityId;
			modName = data.data[j].modalityName;			
			result = data.data[j].result;			
			confidential = data.data[j].confidential;
			iStatus = data.data[j].status;
			
			
		}
	}
	rowClick(invId,invName,deptId,deptName,modId,modName,result,iStatus,confidential);
	
}




function addInvestigation(){
	
	if(jQuery('#investigationName').val()==""){
		alert("Please Enter investigation name");
		return false;
	}
	if(jQuery('#selectDepartment').find('option:selected').val()==""){
		alert("Please select department");
		return false;
	}
	if(jQuery('#selectModality').find('option:selected').val()==""){
		alert("Please select modality");
		return false;
	}
		
	if(jQuery('#resulttype').find('option:selected').val()==""){
		alert("Please Select Result Type");
		return false;
	}
	$('#btnAddInvestigation').prop("disabled",true);
	var confidential=$('#confidential').is(':checked') ? $('#confidential').val() :'n';
	
	var params = {
			 'userId':<%=userId %>,	
			 'investigationName':jQuery('#investigationName').val(),
			 'departmentId':jQuery('#selectDepartment').find('option:selected').val(),
			 'modalityId':jQuery('#selectModality').find('option:selected').val(),		 
			 'resultType':jQuery('#resulttype').find('option:selected').val(),
			 'maxValue':$('#maxval').val(),
			 'minValue':$('#minval').val(),
			 'confidential':confidential,
			 'investigationType':invType
			 
	 } 	
	
	//alert(JSON.stringify(params));
	
	var url="addInvestigation";
	    SendJsonData(url,params);
}

function updateInvestigationDetails()
{	
	if(jQuery('#investigationName').val()==""){
		alert("Please Enter investigation name");
		return false;
	}
	if(jQuery('#selectDepartment').find('option:selected').val()==""){
		alert("Please select department");
		return false;
	}
	if(jQuery('#selectModality').find('option:selected').val()==""){
		alert("Please select modality");
		return false;
	}	
	
	if(jQuery('#resulttype').find('option:selected').val()==""){
		alert("Please Select Result Type");
		return false;
	}
	var confidential=$('#confidential').is(':checked') ? $('#confidential').val() :'n';
	var params = {
			'investigationId':investId,
			 'userId':<%=userId %>,	
			 'investigationName':jQuery('#investigationName').val(),
			 'departmentId':jQuery('#selectDepartment').find('option:selected').val(),
			 'modalityId':jQuery('#selectModality').find('option:selected').val(),			 
			 'resultType':jQuery('#resulttype').find('option:selected').val(),			 
			 'confidential':confidential,
			 'investigationType':invType
			 
	 } 	
	
	//alert(JSON.stringify(params));
	
	var url="updateInvestigation";
	SendJsonData(url,params);	
	GetMainChargecodeList();	 		
	
	$j('#btnAddInvestigation').attr("disabled", false);
	$j('#mainChargecodeCode').attr('readonly', true);
	ResetFrom();
	
}

function updateStatus(){
	
	if(document.getElementById('investigationName').value == "" || document.getElementById('investigationName').value == null ){
		alert("Please Enter investigation name");
		return false;
	}
	 var params = {
		 'investigationId':investId,		 
		 'status':iStatus		 
	}  
	 
	// alert(JSON.stringify(params));
	 var url= "updateInvestigationStatus";
		    SendJsonData(url,params);
		    
		    $j("#btnActive").hide();
			 $j("#btnInActive").hide();
			 $j('#btnAddInvestigation').show();
}



function GetMainChargeList(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getAllMainChargeList",
	    data: JSON.stringify({}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		//comboArray[i] = result.data[i].departmentName;
	    		if(result.data[i].mainChargecodeCode== invType){
	    		combo += '<option value='+result.data[i].mainChargecodeId+'>' +result.data[i].mainChargecodeName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);
	    		}
	    		else if(result.data[i].mainChargecodeCode== invType){
		    		combo += '<option value='+result.data[i].mainChargecodeId+'>' +result.data[i].mainChargecodeName+ '</option>';
		    		//alert("combo :: "+comboArray[i]);
		    		}
	    		
	    	}
	    	jQuery('#selectDepartment').append(combo);
	    }
	    
	});
}

function GetModalityList(invType){
	jQuery('#selectModality').html("");
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getAllModalityList",
	    data: JSON.stringify({"mainChargecode":invType}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	//alert("success "+result.data.length);
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		//comboArray[i] = result.data[i].departmentName;
	    		combo += '<option value='+result.data[i].subChargecodeId+'>' +result.data[i].subChargecodeName+ '</option>';
	    		//alert("combo :: "+comboArray[i]);
	    		
	    		
	    	}
	    	jQuery('#selectModality').append(combo);
	    }
	    
	});
}



function rowClick(invId,invName,deptId,deptName,modId,modName,result,iStatus,confidential){	
	
	jQuery("#investigationName").val(invName);
	jQuery("#selectDepartment").val(deptId);
	jQuery("#selectModality").val(modId);	
	jQuery("#resulttype").val(result);	
		
	if(confidential == 'Y' || confidential == 'y'){
		jQuery("#confidential").prop('checked', true);
	
	}
	else{
		jQuery("#confidential").prop('checked', false);
	}
	
	
if(iStatus == 'Y' || iStatus == 'y'){
		
	$j("#btnInActive").show();
	$j("#btnActive").hide();
    $j("#updateBtn").show();
    $j("#btnAddInvestigation").hide();
	}
	if(iStatus == 'N' || iStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j("#updateBtn").hide();
		 $j("#btnAddInvestigation").hide();
	}
	
	
	$j('#btnAddMainChargecode').hide();
	
	 
	
}


function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllInvestigationDetails('FILTER');
	
}

function Reset(){	
	document.getElementById('searchInvName').value = "";
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddMainChargecode').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	
	showAll();
}


function ResetForm()
{	
	$j('#searchInvName').val('');
	$j('#investigationName').val('');
	$j('#selectDepartment').val('');
	$j('#selectModality').val('');	
	$j('#resulttype').val('');	
	$j("#confidential").prop('checked', false);
	
}

function showAll()
{
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddInvestigation').show();
	$j('#mainChargecodeCode').attr('readonly', false);
	$("#resultBtn").hide();
	ResetForm();
	nPageNo = 1;	
	GetAllInvestigationDetails('ALL');
	
}



function search()
{
	if(document.getElementById('searchInvName').value == ""){
		alert("Please Enter Investigaion Name");
		return false;
	}
	nPageNo=1;
	GetAllInvestigationDetails('Filter');
}

function generateReport()
{
	alert("hiiiiiiiiiiiii");
	var url="${pageContext.request.contextPath}/report/generateRadiologyInvestigationReport";
	openPdfModel(url);
	/* document.searchMCCForm.action="${pageContext.request.contextPath}/report/generateRadiologyInvestigationReport";
	document.searchMCCForm.method="POST";
	document.searchMCCForm.submit();  */
	
}
		function isNumberKey(txt, evt) {
		
		    var charCode = (evt.which) ? evt.which : evt.keyCode;
		    if (charCode == 46) {
		        //Check if the text already contains the . character
		        if (txt.value.indexOf('.') === -1) {
		            return true;
		        } else {
		            return false;
		        }
		    } else {
		        if (charCode > 31
		             && (charCode < 48 || charCode > 57))
		            return false;
		    }
		    return true;
		}
		
		/* function changeResultType(value){
			if(value=='t'){
				$("#resultBtn").show();
			}
			else{
				$("#resultBtn").hide();
			}
			
		} */
		var popup;
		function showCreateInvestigationTemplate() {
			/*  popup = window.open("subInvestigationMaster", "popUpWindow",
		      "height=500,width=800,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes"); */
		      
			$('#exampleModal .modal-body').load("subInvestigationMaster");
            $('#exampleModal .modal-title').text('Sub Investigation Master');
               
          }
		function changeDepartment(value){
			
			GetModalityList(value);
			
		}
		
		function generateReport()
		 {
			 var url="${pageContext.request.contextPath}/report/generateRadiologyInvestigationReport";
			 openPdfModel(url);
		 	/* document.searchRoleForm.action="${pageContext.request.contextPath}/report/generateRoleMasterReport";
		 	document.searchRoleForm.method="POST";
		 	document.searchRoleForm.submit();  */
		 	
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
                <div class="internal_Htext">Investigation Master(Radiology)</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                     
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchInvForm"
												name="searchInvForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Investigation Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchInvName" id="searchInvName"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Investigation Name" onkeypress="return validateText('searchInvName',30,'Investigation Name');">

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
                                                     <button type="button" class="btn  btn-primary " onclick="showAll();">Show All</button>
                                                    <!-- <button type="button" class="btn  btn-primary " id="printReportButton"  onclick="generateReport()">Reports</button> -->
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
                                                <th id="th1" class ="inner_md_htext">Investigation Name</th>
                                                <th id="th2" class ="inner_md_htext">Department</th>
                                                <th id="th2" class ="inner_md_htext">Modality</th>                                                
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                       
                                     <tbody id="tblListOfInvestigation">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addInvestigationForm" name="addInvestigationForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Investigation Name" class=" col-form-label inner_md_htext" >Investigation Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="investigationName" name="investigationName" placeholder="Investigation Name" onkeypress=" return validateText('investigationName',100,'Investigation Name');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Department" class="col-form-label inner_md_htext">Department<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                               <select class="form-control" id="selectDepartment" >
                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Modality" class="col-form-label inner_md_htext">Modality<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="selectModality" >
                                                               	
                                                               </select>
                                                            </div>
                                                        </div>
                                                    </div>                                  
                                              
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        
                                                            <label class="col-sm-5 col-form-label inner_md_htext">Result Type<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            
                                                            <div class="col-md-7">
                                                                <select class="form-control" id="resulttype" onchange="changeResultType(this.value);">
                                                                <option value="">Select</option>                                                                    
                                                                    <option value="t">Template</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4" id="resultBtn" style="display:;">
                                                        <div class="form-group row">
                                                        	<input id="resultAddBtn" type="button" class="btn btn-primary" data-target="#exampleModal"  onclick="showCreateInvestigationTemplate();" value="Add" />
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <!-- <div class="form-group row">                                                        
                                                            <label class="col-sm-5 col-form-label ">Confidential</label>                                                            
                                                            <div class="col-md-7">                                                                
                                                                <input type="checkbox" class="m-t-10" name="confidential" id="confidential" value="y"/>                                                            
                                                            </div>
                                                        </div> -->
                                                        
                                                        <div class="form-check form-check-inline cusCheck m-t-5">
															<input class="form-check-input" type="checkbox" name="confidential" id="confidential" value="y"/>
															<span class="cus-checkbtn"></span> 
															<label class="form-check-label m-l-5" for="confidential">Confidential</label>
														</div>
														
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
												
														<button type="button" id="btnAddInvestigation"
															class="btn  btn-primary " onclick="addInvestigation();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateInvestigationDetails();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateStatus();">Deactivate</button>
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
		
		 <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog modal-xl" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title font-weight-bold"></h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			        <div class="text-center text-theme text-sm">
			         Loading <i class="fa fa-spin fa-spinner"></i>
			        </div>
			      </div> 
			       <!-- <div class="text-center text-primary text-xsm">
			         loading <i class="fa fa-spin fa-spinner"></i>
			        </div> -->
			    </div>
			  </div>
			</div>
		
    </div>
    <!-- END wrapper -->

    <!-- jQuery  -->
    

</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
