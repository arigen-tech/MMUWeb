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
			$j('#icdCode').attr('readonly', false);
			GetDiagnosisList('ALL');
		});
		
function GetDiagnosisList(MODE)
{
	
	var icdName= jQuery("#searchDiagnosis").attr("checked", true).val().toUpperCase();
	var icdId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "icdName":""};			
		}
	else
		{
		var data = {"PN":nPageNo, "icdName":icdName};
		} 
	var url = "getAllDiagnosis";
		
	var bClickable = true;
	GetJsonData('tblListOfDiagnosis',data,url,bClickable);
}

function search()
{
	if(document.getElementById('searchDiagnosis').value == ""){
 		alert("Please Enter Diagnosis Name");
 		return false;
 	}
	nPageNo=1;
	GetDiagnosisList('Filter');
}
function makeTable(jsonData)
{	
	var data = jsonData;
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
		 
		
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].icdId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].icdCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].icdName+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].mfDiagnosis+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>";
			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	
	$j("#tblListOfDiagnosis").html(htmlTable);	
	
	
}
var comboArray = [];
var iId;
var iCode;
var iName;
var comFlag;
var infFlag
var iStatus;
var mfDiagnosis;
function executeClickEvent(icdId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(icdId == data.data[j].icdId){
			iId = data.data[j].icdId;
			iCode = data.data[j].icdCode;
			iName = data.data[j].icdName;
			iStatus = data.data[j].status;
			comFlag  = data.data[j].communicable;
			infFlag  = data.data[j].infectious;
			mfDiagnosis=data.data[j].mfDiagnosis;
		}
	}
	rowClick(iId,iCode,iName,iStatus,comFlag,infFlag,mfDiagnosis);
}

function searchDiagnosisList(){
	 if(document.getElementById('searchDiagnosis').value == "" || document.getElementById('searchDiagnosis') == null){
		 alert("Plese Enter the Diagnosis Name");
		 return false;
	 }
	 
	var icdName= jQuery("#searchDiagnosis").attr("checked", true).val().toUpperCase();
		
	var nPageNo=1;
	var url = "getAllDiagnosis";
	var data =  {"PN":nPageNo, "icdName":icdName};
	var bClickable = true;
	GetJsonData('tblListOfDiagnosis',data,url,bClickable);
}

function addDiagnosis(){
	var mfDiagnosis=$j('#mostFrequentDiagnosis').is(':checked') ? 'Y' :'N';
	if(document.getElementById('icdCode').value=="" || document.getElementById('icdCode').value==null){
		alert("Please Enter the Diagnosis Code");
		return false;
	}
	if(document.getElementById('icdName').value=="" || document.getElementById('icdName').value==null){
		alert("Please Enter the Diagnosis Name");
		return false;
	}
	$('#btnAddDiagnosis').prop("disabled",true);
	var userId =  $j('#userId').val();
	var communicable=$('#communicable').is(':checked') ? 'Y' :'N';
	var infectious=$('#infectious').is(':checked') ? 'Y' :'N';
	var params = {
			 
			 'icdCode':jQuery('#icdCode').val(),
			 'icdName':jQuery('#icdName').val(),
			 'userId':<%=userId%>,
			 'communicable' : communicable,
			 'infectious' : infectious,
			 'mfDiagnosis' : mfDiagnosis
	 } 	
	    var url = "addDiagnosis";
	    SendJsonData(url,params);
}




function updateDiagnosis()
{	
	var mfDiagnosis=$j('#mostFrequentDiagnosis').is(':checked') ? 'Y' :'N';
	if(document.getElementById('icdCode').value == "" || document.getElementById('icdCode').value == null ){
		alert("please enter the Diagnosis Code");
		return false;
	}
	if(document.getElementById('icdName').value == "" || document.getElementById('icdName').value == null ){
		alert("please enter the Diagnosis Name");
		return false;
	}
	var communicable=$('#communicable').is(':checked') ? 'Y' :'N';
	var infectious=$('#infectious').is(':checked') ? 'Y' :'N';
	var userId =  $j('#userId').val();	
	var params = {
			 'icdId':iId,
			 'icdCode':jQuery('#icdCode').val(),
			 'icdName':jQuery('#icdName').val(),
			 'userId':<%=userId%>,
			 'communicable' : communicable,
			 'infectious' : infectious,
			 'mfDiagnosis' : mfDiagnosis
			 
	 } 
		    var url = "updateDiagnosis";
            SendJsonData(url,params);
	         
            $j('#updateBtn').hide();
			$j('#btnAddDiagnosis').show();	
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#icdCode').attr('readonly', false);
	        ResetForm();
 		
	
	
}

function updateStatus(){
	if(document.getElementById('icdCode').value == "" || document.getElementById('icdCode').value == null ){
		alert("Please Select the Diagnosis Code");
		return false;
	}
	var userId =  $j('#userId').val();	
	 var params = {
			 'icdId':iId,
			 'icdCode':iCode,
			 'status':iStatus,
			 'userId':<%=userId%>
			 
		 
	}  
		    var url = "updateDiagnosisStatus";
		    SendJsonData(url,params);
		   	 
		    $j('#updateBtn').hide();
			 $j('#btnAddDiagnosis').show();	
			 $j("#btnActive").hide();
			 $j("#btnInActive").hide();
			 $j('#icdCode').attr('readonly', false);
}

function rowClick(iId,iCode,iName,iStatus,comFlag,infFlag,mfDiagnosis){	
		
	document.getElementById("icdCode").value = iCode;
	document.getElementById("icdName").value = iName;
	
	if(comFlag == 'Y' || comFlag == 'y'){
		jQuery("#communicable").prop('checked', true);
	
	}
	else{
		jQuery("#communicable").prop('checked', false);
	}
	if(infFlag == 'Y' || infFlag == 'y'){
		jQuery("#infectious").prop('checked', true);
	
	}
	else{
		jQuery("#infectious").prop('checked', false);
	}
	
	if(mfDiagnosis == 'Y' || mfDiagnosis == 'y'){
		jQuery("#mostFrequentDiagnosis").prop('checked', true);
	
	}
	else{
		jQuery("#mostFrequentDiagnosis").prop('checked', false);
	}
	
	if(iStatus == 'Y' || iStatus == 'y'){
		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#btnAddDiagnosis').hide();
		$j('#updateBtn').show();
		$j('#icdCode').attr('readonly', true);
	}
	if(iStatus == 'N' || iStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddDiagnosis').hide();
		$j('#icdCode').attr('readonly', true);
	}
	
	 
	
}

function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetDiagnosisList('FILTER');
	
}


function Reset(){
	document.getElementById("addDiagnosisForm").reset();
	document.getElementById("searchDiagnosisForm").reset();
	document.getElementById('searchDiagnosis').value = "";
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddDiagnosis').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	$j('#icdCode').attr('readonly', false);
	showAll();
}



function ResetForm()
{	
	$j('#icdCode').val('');
	$j('#icdName').val('');
	$j('#searchDiagnosis').val('');
	$j('#icdCode').attr('readonly', false);
	jQuery("#communicable").prop('checked', false);
	jQuery("#infectious").prop('checked', false);
}

function showAll()
{

	ResetForm();
	nPageNo = 1;	
	GetDiagnosisList('ALL');
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddDiagnosis').show();
	
}

function generateReport()
{
	var url="${pageContext.request.contextPath}/report/generateDiagnosisReport";
	openPdfModel(url);
	
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
                <div class="internal_Htext">Diagnosis Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchDiagnosisForm"
												name="searchDiagnosisForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Diagnosis Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchDiagnosis" id="searchDiagnosis"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Diagnosis Name" onkeypress=" return validateText('searchDiagnosis',300,'searchDiagnosis');">

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
                                                <th id="th2" class ="inner_md_htext">Diagnosis Code</th>
                                                <th id="th3" class ="inner_md_htext">Diagnosis Name</th>
                                                <th id="th4" class ="inner_md_htext">Most Frequent Diagnosis</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        <!--  <tbody id="tblListOfEmployeeAndDepenent">   </tbody>  --->
                                     <tbody class="clickableRow" id="tblListOfDiagnosis">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addDiagnosisForm" name="addDiagnosisForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-6">
                                                            <label for="Diagnosis Code" class=" col-form-label inner_md_htext" >Diagnosis Code <span class="mandate"><sup>&#9733;</sup></span> </label>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input type="text" class="form-control" id="icdCode" name="icdCode" placeholder="Diagnosis Code" onkeypress=" return validateText('icdCode',10,'Diagnosis Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-6">
                                                            <label for="service" class="col-form-label inner_md_htext">Diagnosis Name <span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-6">
                                                            <textarea  class="form-control" type="textarea" name="icdName" placeholder="Diagnosis Name" id="icdName"  MAXLENGTH="300" tabindex="1" rows="1"></textarea>                                                            </div>
                                                        </div>
                                                    </div>
                                                     <div class="col-md-4">   
                                                        <div class="form-check form-check-inline cusCheck m-t-5">
															<input class="form-check-input" type="checkbox"  name="mostFrequentDiagnosis" id="mostFrequentDiagnosis" value="n"/>
															<span class="cus-checkbtn"></span> 
															<label class="form-check-label m-l-5" for="Most Frequent Symptoms">Most Frequent Diagnosis</label>
														</div>
                                                    </div> 
                                                    <div class="col-md-4">
                                                        <div class="form-check form-check-inline cusCheck m-t-5">
															<input class="form-check-input" type="checkbox"  name="communicable" id="communicable" value="N"/>
															<span class="cus-checkbtn"></span> 
															<label class="form-check-label m-l-5" for="Communicable">Communicable</label>
														</div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-check form-check-inline cusCheck m-t-5">
															<input class="form-check-input" type="checkbox"  name="infectious" id="infectious" value="N"/>
															<span class="cus-checkbtn"></span> 
															<label class="form-check-label m-l-5" for="Infectious">Infectious</label>
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
												
														<button type="button" id="btnAddDiagnosis"
															class="btn  btn-primary " onclick="addDiagnosis();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateDiagnosis();">Update</button>
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

    </div>
    <!-- END wrapper -->

    <!-- jQuery  -->
    

</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>

