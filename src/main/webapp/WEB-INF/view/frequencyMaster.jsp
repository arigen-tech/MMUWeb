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
	$j('#frequencyCode').attr('readonly', false);
		GetAllOPDFrequency('ALL');			
		});
		
function GetAllOPDFrequency(MODE){
	 var frequencyName = jQuery("#searchFrequency").attr("checked", true).val().toUpperCase();
	 var frequencyId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo,"frequencyName":""};			
		}
	else
		{
		var data = {"PN":nPageNo, "frequencyName":frequencyName};
		}
	var url = "getAllOpdFrequency";		
	var bClickable = true;
	GetJsonData('tblListOfFrequency',data,url,bClickable);	 
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
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].frequencyId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].frequencyCode+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].frequencyName+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].feq+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfFrequency").html(htmlTable); 	
	
}

var freqId;
var freqCode;
var freqName;
var freqHinName;
var freqStatus;

function executeClickEvent(frequencyId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(frequencyId == data.data[j].frequencyId){
			freqId = data.data[j].frequencyId;			
			freqCode = data.data[j].frequencyCode;			
			freqName = data.data[j].frequencyName;
			freqHinName = data.data[j].frequencyHinName;
			freqFeq = data.data[j].feq;
			freqStatus = data.data[j].status;
			
			
		}
	}
	rowClick(freqId,freqCode,freqName,freqHinName,freqFeq,freqStatus);
}

function rowClick(freqId,freqCode,freqName,freqHinName,freqFeq,freqStatus){	
		
	document.getElementById("frequencyCode").value = freqCode;
	document.getElementById("frequencyName").value = freqName;
	document.getElementById("frequencyHinName").value = freqHinName;
	document.getElementById("feq").value = freqFeq;
	
			 
	if(freqStatus == 'Y' || freqStatus == 'y'){		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#updateBtn').show();
		$j('#btnAddFrequency').hide();
		$j('#frequencyCode').attr('readonly', true);
	}
	if(freqStatus == 'N' || freqStatus == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddFrequency').hide();
		$j('#frequencyCode').attr('readonly', true);
	}
	
	
}



function updateFrequency(){	
	if(document.getElementById('frequencyCode').value == null || document.getElementById('frequencyCode').value == ""){
		alert("Please Enter Frequency Code");
		return false;
	}
	if(document.getElementById('frequencyName').value == null || document.getElementById('frequencyName').value ==""){
		alert("Please Enter Frequency Name");
		return false;
	}
	if(document.getElementById('feq').value == null || document.getElementById('feq').value ==""){
		alert("Please Enter FEQ");
		return false;
	}
	
		
	var userId =  $j('#userId').val();
	var params = {
			 'frequencyId':freqId,
			 'frequencyCode':jQuery('#frequencyCode').val(),
			 'frequencyName':jQuery('#frequencyName').val(),
			 'frequencyHinName' : jQuery('#frequencyHinName').val(),
			 'feq':jQuery('#feq').val(),
			 'userId': <%=userId%>
			
	 } 
	var url="updateOpdFrequencyDetails";	
	SendJsonData(url,params);
	$j("#btnInActive").hide();
	$j("#btnActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddFrequency').show();
		
		Reset();
}

function updateFrequencyStatus(){
	if(document.getElementById('frequencyCode').value == null || document.getElementById('frequencyCode').value == ""){
		alert("Please Enter Frequency Code");
		return false;
	}
	if(document.getElementById('frequencyName').value == null || document.getElementById('frequencyName').value ==""){
		alert("Please Enter Frequency Name");
		return false;
	}
	var userId =  $j('#userId').val();
	var params = {
			'frequencyId':freqId,
			 'frequencyCode':jQuery('#frequencyCode').val(),
			 'status':freqStatus,
			 'userId':<%=userId%>
			 
		} 
	var url="updateOpdFrequencyStatus";	
	SendJsonData(url,params);
	$j("#btnInActive").hide();
	$j("#btnActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddFrequency').show();
	
	ResetForm();
}

function addFrequencyDetails(){
	
	if(document.getElementById('frequencyCode').value == null || document.getElementById('frequencyCode').value == ""){
		alert("Please Enter Frequency Code");
		return false;
	}
	if(document.getElementById('frequencyName').value == null || document.getElementById('frequencyName').value ==""){
		alert("Please Enter Frequency Name");
		return false;
	}
	if(document.getElementById('feq').value == null || document.getElementById('feq').value ==""){
		alert("Please Enter FEQ");
		return false;
	}
	$('#btnAddFrequency').prop("disabled", true);
	var userId =  $j('#userId').val();
	var params = {			 
			 'frequencyCode':jQuery('#frequencyCode').val(),
			 'frequencyName':jQuery('#frequencyName').val(),
			 'frequencyHinName' : jQuery('#frequencyHinName').val(),
			 'feq':jQuery('#feq').val(),
			 'userId':<%= userId%>
	 } 
	
	var url="addOpdFrequency";	
	SendJsonData(url,params);
	
	
}

function Reset(){
	document.getElementById("searchFrequencyForm").reset();
	document.getElementById("addFrequencyForm").reset();
	$j('#frequencyCode').attr('readonly', false);
	
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddFrequency').show();
	showAll();
}	


function enableAddButton(){
	if(document.getElementById("frequencyCode").value!=null || !document.getElementById("frequencyCode").value==""){
		$j('#btnAddFrequency').attr("disabled", false);
	}else if( document.getElementById("frequencyName").value!=null || !document.getElementById("frequencyName").value==""){
		$j('#btnAddFrequency').attr("disabled", false);
	}else{
		$j('#btnAddFrequency').attr("disabled", true);
	}
}

function validTextBox(){
	if($j('#frequencyCode').val().length >= 10){
		 alert("Frequency Code should be equal to 10");
		 document.getElementById('frequencyCode').value="";
		 return false;
	 }
	if($j('#frequencyName').val().length >=20){
		 alert("Frequency Name should be equal to 10");
		 document.getElementById('frequencyName').value="";
		 return false;
	 }
}

function ResetForm()
{
	$j('#frequencyCode').val('');
	$j('#frequencyName').val('');
	$j('#frequencyHinName').val('');
	$j('#searchFrequency').val('');
	$j('#feq').val('');
	$j('#frequencyCode').attr('readonly', false);
}

function showAll()
{
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddFrequency').show();
	ResetForm();
	nPageNo = 1;	
	GetAllOPDFrequency('ALL');
	
	
}

 function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllOPDFrequency('FILTER');
	
} 

 function isValidLengthOfFreqCode(){
	
		 if(frequencyCode.value.length >= 7){
			 alert("Please Enter Valid Length of Frequency");
			 return false;
		 }
 }
 
 function search()
 {
 	if(document.getElementById('searchFrequency').value == ""){
  		alert("Please Enter Frequency Name");
  		return false;
  	}
 	nPageNo=1;
 	GetAllOPDFrequency('Filter');
 }
 
 function generateReport()
 {
	var url="${pageContext.request.contextPath}/report/generateFrequencyReport"; 
	openPdfModel(url);
 	/* document.searchFrequencyForm.action="${pageContext.request.contextPath}/report/generateFrequencyReport";
 	document.searchFrequencyForm.method="POST";
 	document.searchFrequencyForm.submit(); */ 
 	
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
                <div class="internal_Htext">Frequency Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>

                                        <div class="row">               
                                        <div class="col-md-8">
                                            <form class="form-horizontal" id="searchFrequencyForm" name="searchFrequencyForm" method="" role="form">
                                                <div class="form-group row">
                                                    <label class="col-3 col-form-label">Frequency Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                    <div class="col-4">                                                    
                                                               
                                                              <input type="text" name="searchFrequency" id="searchFrequency" class="form-control" id="inlineFormInputGroup" placeholder="Frequency Name" onkeypress="return validateText('searchFrequency',30,'Frequency Name');">
                                                             
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
                                                    <!-- <button type="button" class="btn  btn-primary " 
                                                    id="printReportButton"
                                                    onclick="generateReport()">Reports</button> -->
                                              </div>
                                        </div>

                                    </div> 
                                       

                                   

					<!-- <table class="table table-striped table-hover jambo_table"> -->
                  <div style="float:left">					           
		                                    <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >			<tr>
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
		</table>

                                    <table class="table table-striped table-hover table-bordered "">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th id="th2" class ="inner_md_htext">Frequency Code</th>
                                                <th id="th3" class ="inner_md_htext">Frequency Name</th>
                                                <th id="th3" class ="inner_md_htext">FEQ</th>
                                                <th id="th4" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                     <tbody class="clickableRow" id="tblListOfFrequency">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addFrequencyForm" name="addFrequencyForm" action="" method="POST">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Command Code" class=" col-form-label inner_md_htext" >Frequency Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" name="frequencyCode" id="frequencyCode" class="form-control" placeholder="Frequency Code" onkeypress="return validateText('frequencyCode',7,'Frequency Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Frequency Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" name="frequencyName" id="frequencyName" class="form-control" placeholder="Frequency Name" onchange="" onkeypress="return validateText('frequencyName',30,'Frequency Name');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">Frequency Name in Hindi<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" name="frequencyHinName" id="frequencyHinName" class="form-control" placeholder="Frequency Name in Hindi" onkeypress="return validateText('frequencyHinName',30,'Frequency Name in Hindi');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="service" class="col-form-label inner_md_htext">FEQ<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" name="feq" id="feq" class="form-control" placeholder="FEQ" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" maxlength="10">
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
												
														<button type="button" id="btnAddFrequency"
															class="btn  btn-primary " onclick="addFrequencyDetails();">Add</button>
															
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateFrequency();">Update</button>
															
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateFrequencyStatus();">Activate</button>
															
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateFrequencyStatus();">Deactivate</button>
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

