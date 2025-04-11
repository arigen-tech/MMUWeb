<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MMU</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    
<%@include file="..//view/commonJavaScript.jsp" %>
  
<script type="text/javascript">

	var nPageNo=1;
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
		$j('#instructionsCode').attr('readonly', false);		
		GetAllTreatmentInstructions('ALL');			
			});
			
	function GetAllTreatmentInstructions(MODE){
		 
		var instructionsName=$("#searchInstructionsName").val();		 
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "instructionsName":""};			
			}else{
			var data = {"PN":nPageNo, "instructionsName":instructionsName};
			} 
		var url = "getAllTreatmentInstructions";		
		var bClickable = true;
		GetJsonData('tblListOfInstructions',data,url,bClickable);	 
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
					
				htmlTable = htmlTable+"<tr id='"+dataList[i].instructionsId+"' >";			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].instructionsCode+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].instructionsName+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfInstructions").html(htmlTable); 	
		
	}
    var instructionsId;
	var instructionsid='';
	var instructionsCode;
	var instructionsName;
	var Status;
	
	function executeClickEvent(instructionsId,data)
	{
		
		for(j=0;j<data.data.length;j++){
			if(instructionsId == data.data[j].instructionsId){
				instructionsId = data.data[j].instructionsId;			
				instructionsCode = data.data[j].instructionsCode;			
				instructionsName = data.data[j].instructionsName;
				Status = data.data[j].status;
				
				
			}
		}
		rowClick(instructionsId,instructionsCode,instructionsName,Status);
	}
	
	function rowClick(instructionsId,instructionsCode,instructionsName,Status){	
		instructionsid=instructionsId;
		document.getElementById("instructionsCode").value = instructionsCode;
		document.getElementById("instructionsName").value = instructionsName;
		
				 
		if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddInstructions').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddInstructions').hide();
		}
		
		
		$j('#instructionsCode').attr('readonly', true);
		
	}


		function addTreatmentInstructions(){
			
			if(document.getElementById('instructionsCode').value == null || document.getElementById('instructionsCode').value == ""){
				alert("Please Enter Instructions Code");
				return false;
			}
			if(document.getElementById('instructionsName').value == null || document.getElementById('instructionsName').value ==""){
				alert("Please Enter Instructions Name");
				return false;
			}
			$j('#btnAddInstructions').prop("disabled",true);
			var params = {		
					
					 'instructionsCode':jQuery('#instructionsCode').val(),
					 'instructionsName':jQuery('#instructionsName').val(),
					 'status' : Status,
					 'userId': <%= userId%>
			 }
			
			//alert(JSON.stringify(params));
			    var url = "addTreatmentInstructions";
			    SendJsonData(url,params);
			
			    
		}
		
		function updateTreatmentInstructions(){	
			if(document.getElementById('instructionsCode').value == null || document.getElementById('instructionsCode').value == ""){
				alert("Please Enter Instructions Code");
				return false;
			}
			if(document.getElementById('instructionsName').value == null || document.getElementById('instructionsName').value ==""){
				alert("Please Enter Instructions Name");
				return false;
			}
			
			var params = {		
					'instructionsId':instructionsid,
					 'instructionsCode':jQuery('#instructionsCode').val(),
					 'instructionsName':jQuery('#instructionsName').val(),
					 'status' : Status,
					 'userId': <%= userId%>
			 } 
			//alert(JSON.stringify(params));
				    var url = "updateTreatmentInstructions";
				    SendJsonData(url,params);
					$j('#userTypeCode').attr('readonly', true);
					Reset();
		}
		
		function updateTreatmentInstructionsStatus(){
			
			
			var params = {
					
					'instructionsId':instructionsid,			 
					 'status':Status
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateTreatmentInstructionsStatus";
			        SendJsonData(url,params);
			 
			        Reset(); 
		}
		
		function Reset(){
			
			document.getElementById('searchInstructionsName').value = "";
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddInstructions').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			$j('#instructionsCode').attr('readonly', false);
			showAll();
		}
				
		function ResetForm()
		{	
			$j('#instructionsCode').val('');
			$j('#instructionsName').val('');
			$j('#searchInstructionsName').val('');
			
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			GetAllTreatmentInstructions('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddInstructions').show();
			$j('#instructionsCode').attr('readonly', false);
			
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllTreatmentInstructions('FILTER');
			
		} 
		
		 function search()
		 {
		 	if(document.getElementById('searchInstructionsName').value == ""){
		  		alert("Please Enter Instructions Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllTreatmentInstructions('FILTER');
		 }
		 
		 function generateReport()
		 {
			 var url="${pageContext.request.contextPath}/report/generateBankMasterReport";
			 openPdfModel(url)
		 	
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
                <div class="internal_Htext">Treatment Instructions Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchInstructionsForm"
												name="searchInstructionsForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Instructions Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchInstructionsName" id="searchInstructionsName"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Instructions Name" onkeypress="return validateText('searchInstructionsName',50,'Instructions Name')">

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
                                                <th id="th2" class ="inner_md_htext">Instructions Code</th>
                                                <th id="th3" class ="inner_md_htext">Instructions Name</th>
                                                <th id="th4" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfInstructions">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addInstructionsForm" name="addInstructionsForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" >Instructions Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="instructionsCode" name="instructionsCode" placeholder="Instructions Code" onkeypress=" return validateText('instructionsCode',10,'Instructions Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Instructions Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="instructionsName" name="instructionsName" placeholder="Instructions Name" onkeypress="return validateText('instructionsName',50,'Instructions Name')">
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
												
														<button type="button" id="btnAddInstructions"
															class="btn  btn-primary " onclick="addTreatmentInstructions();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateTreatmentInstructions();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateTreatmentInstructionsStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateTreatmentInstructionsStatus();">Deactivate</button>
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

