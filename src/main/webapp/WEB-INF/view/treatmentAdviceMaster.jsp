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
		GetAllAdviceName('ALL');			
		});
		
function GetAllAdviceName(MODE){
	 var adviceName= jQuery("#searchAdvice").val();
		
	 var aId=0;
	 if(MODE == 'ALL'){
			var data = {"PN":nPageNo, "adviceName":""};			
		}else{
		var data = {"PN":nPageNo, "adviceName":adviceName};
		} 
	var url = "getAllTreatmentAdvice";		
	var bClickable = true;
	GetJsonData('tblListOfAdvice',data,url,bClickable);	 
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
				
			htmlTable = htmlTable+"<tr id='"+dataList[i].templateMadviceId+"' >";			
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].adviceName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListOfAdvice").html(htmlTable); 	
	
}

var aId;
var advcId='';
var adviceName;
var Status;

function executeClickEvent(aId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(aId == data.data[j].templateMadviceId){
			aId = data.data[j].templateMadviceId;			
			adviceName = data.data[j].adviceName;
			Status = data.data[j].status;
			
			
		}
	}
	rowClick(aId,adviceName,Status);
}

function rowClick(aId,adviceName,Status){	
	advcId=aId;
	document.getElementById("adviceName").value = adviceName;
	
			 
	if(Status == 'Y' || Status == 'y'){		
		$j("#btnInActive").show();
		$j("#btnActive").hide();
		$j('#updateBtn').show();
		$j('#btnAddAdvice').hide();
	}
	if(Status == 'N' || Status == 'n'){
		$j("#btnActive").show();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddAdvice').hide();
	}
	
}


function addTreatmentAdvice(){
	
	
	if(document.getElementById('adviceName').value == null || document.getElementById('adviceName').value ==""){
		alert("Please Enter Advice Name");
		return false;
	}
	$('#btnAddAdvice').prop("disabled",true);
	var userId =  $j('#userId').val();
	var params = {			 
			 'adviceName':jQuery('#adviceName').val(),
			 'userId': <%=userId%>
	 } 
	    var url = "addTreatmentAdvice";
	    SendJsonData(url,params);
	
}

function updateTreatmentAdvice(){	
	if(document.getElementById('adviceName').value == null || document.getElementById('adviceName').value ==""){
		alert("Please Enter Advice Name");
		return false;
	}
		var userId =  $j('#userId').val();
	var params = {
			 'adviceId':advcId,
			 'adviceName':jQuery('#adviceName').val(),
			 'userId': <%=userId %>
			
	 } 
		    var url = "updateTreatmentAdvice";
		    SendJsonData(url,params);
		    $j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddAdvice').show();
			Reset();
}

function updateTreatmentAdviceStatus(){
	
	var userId =  $j('#userId').val();
	var params = {
			'adviceId':advcId,
			 'status':Status,
			 'userId': <%=userId %>
			 
		} 
		
	//alert(JSON.stringify(params));
		    var url = "updateTreatmentAdviceStatus";
	        SendJsonData(url,params);
	        $j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddAdvice').show();
}

function Reset(){
	
	document.getElementById('searchAdvice').value = "";
	document.getElementById('adviceName').value = "";
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddAdvice').show();
	document.getElementById("messageId").innerHTML = "";
	$("#messageId").css("color", "black");
	showAll();
}



function ResetForm()
{	
	$j('#adviceName').val('');
	$j("#btnActive").hide();
	$j("#btnInActive").hide();
	$j('#updateBtn').hide();
	$j('#btnAddAdvice').show();
	
}

function showAll()
{
	ResetForm();
	nPageNo = 1;	
	GetAllAdviceName('ALL');
	
}
 function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAllAdviceName('FILTER');
	
} 

 function search()
 {
 	if(document.getElementById('searchAdvice').value == ""){
  		alert("Please Enter Advice Name");
  		return false;
  	}
 	nPageNo=1;
 	GetAllAdviceName('FILTER');
 }
 
 function generateReport()
 {
	 var url="${pageContext.request.contextPath}/report/generateSampleReport";
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
                <div class="internal_Htext">Treatment Advice Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchAdviceForm"
												name="searchSampleForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Advice Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchAdvice" id="searchAdvice"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Advice Name" onkeypress="return validateText('searchAdvice',500,'Advice Name');">

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
                                                
                                                <th id="th1" class ="inner_md_htext">Advice Name</th>
                                                <th id="th2" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfAdvice">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addAdviceForm" name="addAdviceForm" method="">
                                                <div class="row">
                                                     <div class="col-md-5">
                                                        <div class="form-group row">
                                                        <div class="col-sm-4">
                                                            <label for="service" class="col-form-label inner_md_htext">Advice Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-8">
                                                                <textarea class="form-control" id="adviceName" name="adviceName" placeholder="Advice Name" MAXLENGTH="500" rows="3" cols="50"></textarea>
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
												
														<button type="button" id="btnAddAdvice"
															class="btn  btn-primary " onclick="addTreatmentAdvice();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateTreatmentAdvice();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateTreatmentAdviceStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateTreatmentAdviceStatus();">Deactivate</button>
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

