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
		//$j('#headCode').attr('readonly', false);		
		GetAllMasHead('ALL');	
		 
			});
			
	function GetAllMasHead(MODE){
		 
		var headTypeName=$("#searchHeadName").val();		 
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "headTypeName":""};			
			}else{
			var data = {"PN":nPageNo, "headTypeName":headTypeName};
			} 
		var url = "getAllMasHead";		
		var bClickable = true;
		GetJsonData('tblListOfHead',data,url,bClickable);	 
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
					
				htmlTable = htmlTable+"<tr id='"+dataList[i].headTypeId+"' >";
				 
			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].headTypeCode+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].headTypeName+"</td>";
				 
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfHead").html(htmlTable); 	
		
	}
    var masHeadId;
	var headid='';
	 
	var headCode;
	var headName;
	var Status;
	 
	function executeClickEvent(headId,data)
	{
		
		for(j=0;j<data.data.length;j++){
			if(headId == data.data[j].headTypeId){
				masHeadId = data.data[j].headTypeId;
				 
				headCode = data.data[j].headTypeCode;			
				 
				headName = data.data[j].headTypeName;
				 
				Status = data.data[j].status;
				 
				
			}
		}
		rowClick(masHeadId,headCode,headName,Status);
	}
	
	function rowClick(masHeadId,headCode,headName,Status){	
		headid=masHeadId;
		//document.getElementById("sequenceNo").value = sequenceNo;
		document.getElementById("headCode").value = headCode;
		document.getElementById("headName").value = headName;
	 
		 
		if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddHead').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddHead').hide();
		}
		 
		
		$j('#headCode').attr('readonly', true);
		
	}


		function addHead(){
			
			 
			if(document.getElementById('headCode').value == null || document.getElementById('headCode').value == ""){
				alert("Please Enter Head Code");
				return false;
			}
			if(document.getElementById('headName').value == null || document.getElementById('headName').value ==""){
				alert("Please Enter Head Name");
				return false;
			}
			
			 
			
			 
			
			$j('#btnAddHead').prop("disabled",true);
			var params = {		
					  
					 'headCode':jQuery('#headCode').val(),
					 'headName':jQuery('#headName').val(),
					 'userId': <%= userId%>
					  
			 }
			
			//alert(JSON.stringify(params));
			    var url = "addHead";
			    SendJsonData(url,params);
			    $j('#btnAddHead').prop("disabled",false);
			    ResetForm();
			     
		}
		 
		function updateHead(){
			 
			if(document.getElementById('headCode').value == null || document.getElementById('headCode').value == ""){
				alert("Please Enter Head Code");
				return false;
			}
			if(document.getElementById('headName').value == null || document.getElementById('headName').value ==""){
				alert("Please Enter Head Name");
				return false;
			}
			
		 
			
			var params = {		
					  'headId': headid,
					  'headCode':jQuery('#headCode').val(),
					  'headName':jQuery('#headName').val(),
					  'userId': <%= userId%>
					  
			 }
			//alert(JSON.stringify(params));
				    var url = "updateHead";
				    SendJsonData(url,params);
					$j('#btnAddHead').attr("disabled", false);
					//$j('#headCode').attr('readonly', true);
					ResetForm();
		}
		
		function updateHeadStatus(){
			
			
			var params = {
					
					'headId': headid,		 
					 'status':Status
					 
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateHeadStatus";
			        SendJsonData(url,params);
			 
		     
		}
		
		function Reset(){
			$j('#headCode').attr('readonly', false);
			$j('#btnAddHead').prop("disabled",false);
			document.getElementById('searchHeadName').value = "";
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddHead').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
		//	$j('#headCode').attr('readonly', false);
			 
			showAll();
		}
				
		function ResetForm()
		{	
			$j('#headCode').attr('readonly', false);
			$j('#headCode').val('');
			$j('#headName').val('');
			$j('#searchHeadName').val('');
			 
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			GetAllMasHead('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddHead').show();
			//$j('#headCode').attr('readonly', false);
			
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllMasHead('FILTER');
			
		} 
		
		 function search()
		 {
		 	if(document.getElementById('searchHeadName').value == ""){
		  		alert("Please Enter Head Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllMasHead('FILTER');
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
                <div class="internal_Htext">Head Type Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchBankForm"
												name="searchBankForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Head Type Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchHeadName" id="searchHeadName"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Head Name" onkeypress="return validateText('searchHeadName',100,'Head Name')">

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
               
                                     <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >   
                           			<tr>
                                 		<td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
                                   		<td></td>
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
                                              <th id="th2" class ="inner_md_htext">Head Type Code</th>
                                                <th id="th1" class ="inner_md_htext">Head Type Name</th>
                                                  
                                                <th id="th4" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfHead">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addHeadForm" name="addHeadForm" method="">
                                                <div class="row">
                                                 
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" >Head Type Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="headCode" name="headCode" placeholder="Head Code" onkeypress=" return validateText('headCode',7,'Head Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Head Type Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="headName" name="headName" placeholder="Head Name" onkeypress="return validateText('headName',100,'Head Name')">
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
												
														<button type="button" id="btnAddHead"
															class="btn  btn-primary " onclick="addHead();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateHead();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateHeadStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateHeadStatus();">Deactivate</button>
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

