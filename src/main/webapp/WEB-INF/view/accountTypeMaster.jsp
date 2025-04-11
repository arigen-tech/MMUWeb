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
		$j('#accountTypeCode').attr('readonly', false);		
		GetAllAccountType('ALL');			
			});
			
	function GetAllAccountType(MODE){
		 
		var accountTypeName=$("#searchAccountType").val();		 
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "accountTypeName":""};			
			}else{
			var data = {"PN":nPageNo, "accountTypeName":accountTypeName};
			} 
		var url = "getAllAccountType";		
		var bClickable = true;
		GetJsonData('tblListOfAccountType',data,url,bClickable);	 
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
					
				htmlTable = htmlTable+"<tr id='"+dataList[i].accountId+"' >";			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].accountTypeCode+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].accountTypeName+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfAccountType").html(htmlTable); 	
		
	}

	var accountId;
	var accountTypeCode;
	var accountTypeName;
	var Status;
	
	function executeClickEvent(accountTypeId,data)
	{
		
		for(j=0;j<data.data.length;j++){
			if(accountTypeId == data.data[j].accountId){
				accountId = data.data[j].accountId;			
				accountTypeCode = data.data[j].accountTypeCode;			
				accountTypeName = data.data[j].accountTypeName;
				Status = data.data[j].status;
				
				
			}
		}
		rowClick(accountId,accountTypeCode,accountTypeName,Status);
	}
	
	function rowClick(accountId,accountTypeCode,accountTypeName,Status){	
			
		document.getElementById("accountTypeCode").value = accountTypeCode;
		document.getElementById("accountTypeName").value = accountTypeName;
		
				 
		if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddAccountType').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddAccountType').hide();
		}
		
		
		$j('#accountTypeCode').attr('readonly', true);
		
	}


		function addAccountType(){
			
			if(document.getElementById('accountTypeCode').value == null || document.getElementById('accountTypeCode').value == ""){
				alert("Please Enter Account Type Code");
				return false;
			}
			if(document.getElementById('accountTypeName').value == null || document.getElementById('accountTypeName').value ==""){
				alert("Please Enter Account Type Name");
				return false;
			}
			
			$('#btnAddAccountType').prop("disabled",true);
			var params = {		
					
					 'accountTypeCode':jQuery('#accountTypeCode').val(),
					 'accountTypeName':jQuery('#accountTypeName').val(),
					 'userId': <%= userId%>
			 }
			
			//alert(JSON.stringify(params));
			    var url = "addAccountType";
			    SendJsonData(url,params);
			
			    
		}
		
		function updateAccountType(){	
			if(document.getElementById('accountTypeCode').value == null || document.getElementById('accountTypeCode').value == ""){
				alert("Please Enter Account Type Code");
				return false;
			}
			if(document.getElementById('accountTypeName').value == null || document.getElementById('accountTypeName').value ==""){
				alert("Please Enter Account Type Name");
				return false;
			}	
			
			var params = {
					 'accountId':accountId,
					 'accountTypeCode':jQuery('#accountTypeCode').val(),
					 'accountTypeName':jQuery('#accountTypeName').val(),
					 'userId': <%= userId%>
					
			 } 
			//alert(JSON.stringify(params));
				    var url = "updateAccountType";
				    SendJsonData(url,params);
					$j('#btnAddAccountType').attr("disabled", false);
					$j('#accountTypeCode').attr('readonly', true);
					ResetFrom();
		}
		
		function updateAccountTypeStatus(){
			if(document.getElementById('accountTypeCode').value == null || document.getElementById('accountTypeCode').value == ""){
				alert("Please Enter Account Type Code");
				return false;
			}
			if(document.getElementById('accountTypeName').value == null || document.getElementById('accountTypeName').value ==""){
				alert("Please Enter Account Type Name");
				return false;
			}
			
			var params = {
					
					'accountId':accountId,			 
					 'status':Status
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateAccountTypeStatus";
			        SendJsonData(url,params);
			 
		     
		}
		
		function Reset(){
			
			document.getElementById('searchAccountType').value = "";
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddAccountType').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			$j('#accountTypeCode').attr('readonly', false);
			showAll();
		}
				
		function ResetForm()
		{	
			$j('#accountTypeCode').val('');
			$j('#accountTypeName').val('');
			$j('#searchAccountType').val('');
			
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			GetAllAccountType('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddAccountType').show();
			$j('#accountTypeCode').attr('readonly', false);
			
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllAccountType('FILTER');
			
		} 
		
		 function search()
		 {
		 	if(document.getElementById('searchAccountType').value == ""){
		  		alert("Please Enter Account Type Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllAccountType('FILTER');
		 }
		 
		 function generateReport()
		 {
			 var url = "${pageContext.request.contextPath}/report/generateAccountTypeReport";
			 openPdfModel(url)
		 	/* document.searchAccountTypeForm.action="${pageContext.request.contextPath}/report/generateAccountTypeReport";
		 	document.searchAccountTypeForm.method="POST";
		 	document.searchAccountTypeForm.submit();  */
		 	
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
                <div class="internal_Htext">Account Type Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchAccountTypeForm"
												name="searchAccountTypeForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Account Type Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchAccountType" id="searchAccountType"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Account Type Name" onkeypress="return validateText('searchAccountType',30,'Account Type Name')">

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
                                                <th id="th2" class ="inner_md_htext">Account Type Code</th>
                                                <th id="th3" class ="inner_md_htext">Account Type Name</th>
                                                <th id="th4" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfAccountType">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addSampleForm" name="addSampleContainerForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" >Account Type Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="accountTypeCode" name="accountTypeCode" placeholder="Account Type Code" onkeypress=" return validateText('accountTypeCode',8,'Account Type Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Account Type Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="accountTypeName" name="accountTypeName" placeholder="Account Type Name" onkeypress="return validateText('accountTypeName',30,'Account Type Name')">
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
												
														<button type="button" id="btnAddAccountType"
															class="btn  btn-primary " onclick="addAccountType();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateAccountType();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateAccountTypeStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateAccountTypeStatus();">Deactivate</button>
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
