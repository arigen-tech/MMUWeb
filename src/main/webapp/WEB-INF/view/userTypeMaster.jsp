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
		$j('#bankCode').attr('readonly', false);		
		GetAllUserType('ALL');			
			});
			
	function GetAllUserType(MODE){
		 
		var userTypeName=$("#searchUserTypeName").val();		 
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "userTypeName":""};			
			}else{
			var data = {"PN":nPageNo, "userTypeName":userTypeName};
			} 
		var url = "getAllUserType";		
		var bClickable = true;
		GetJsonData('tblListOfUserType',data,url,bClickable);	 
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
				
			 if(dataList[i].mmuStaff == 'Y' || dataList[i].mmuStaff == 'y')
				{
					var mmuStaff='Yes'
				}
			else
				{
					var mmuStaff='No'
				} 	
			 
				htmlTable = htmlTable+"<tr id='"+dataList[i].userTypeId+"' >";			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].userTypeCode+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].userTypeName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+mmuStaff+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfUserType").html(htmlTable); 	
		
	}
    var userTypeId;
	var usertypeId='';
	var userTypeCode;
	var userTypeName;
	var Status;
	var mmuStaff;
	
	function executeClickEvent(userTypeId,data)
	{
		
		for(j=0;j<data.data.length;j++){
			if(userTypeId == data.data[j].userTypeId){
				userTypeId = data.data[j].userTypeId;			
				userTypeCode = data.data[j].userTypeCode;			
				userTypeName = data.data[j].userTypeName;
				Status = data.data[j].status;
				mmuStaff = data.data[j].mmuStaff;
				
			}
		}
		rowClick(userTypeId,userTypeCode,userTypeName,Status,mmuStaff);
	}
	
	function rowClick(userTypeId,userTypeCode,userTypeName,Status,mmuStaff){	
		usertypeId=userTypeId;
		document.getElementById("userTypeCode").value = userTypeCode;
		document.getElementById("userTypeName").value = userTypeName;
		
		if(mmuStaff == 'Y' || mmuStaff == 'y'){
			jQuery("#mmuStaff").prop('checked', true);
		
		}
		else{
			jQuery("#mmuStaff").prop('checked', false);
		}
				 
		if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddUserType').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddUserType').hide();
		}
		
		
		$j('#userTypeCode').attr('readonly', true);
		
	}


		function addUserType(){
			
			if(document.getElementById('userTypeCode').value == null || document.getElementById('userTypeCode').value == ""){
				alert("Please Enter User Type Code");
				return false;
			}
			if(document.getElementById('userTypeName').value == null || document.getElementById('userTypeName').value ==""){
				alert("Please Enter User Type Name");
				return false;
			}
			
			var mmuStaff=$('#mmuStaff').is(':checked') ? $('#mmuStaff').val() :'N';
			
			var params = {		
					
					 'userTypeCode':jQuery('#userTypeCode').val(),
					 'userTypeName':jQuery('#userTypeName').val(),
					 'userId': <%= userId%>,
			         'mmuStaff' : mmuStaff
			 }
			
			//alert(JSON.stringify(params));
			    var url = "addUserType";
			    SendJsonData(url,params);
			
			    
		}
		
		function updateUserType(){	
			if(document.getElementById('userTypeCode').value == null || document.getElementById('userTypeCode').value == ""){
				alert("Please Enter User Type Code");
				return false;
			}
			if(document.getElementById('userTypeName').value == null || document.getElementById('userTypeName').value ==""){
				alert("Please Enter User Type Name");
				return false;
			}	
			
			var mmuStaff=$('#mmuStaff').is(':checked') ? $('#mmuStaff').val() :'N';
			
			var params = {
					 'userTypeId':usertypeId,
					 'userTypeCode':jQuery('#userTypeCode').val(),
					 'userTypeName':jQuery('#userTypeName').val(),
					 'userId': <%= userId%>,
					 'status':Status,
					 'mmuStaff' : mmuStaff
					
			 } 
			//alert(JSON.stringify(params));
				    var url = "updateUserType";
				    SendJsonData(url,params);
					$j('#btnAddUserType').attr("disabled", false);
					$j('#userTypeCode').attr('readonly', true);
					ResetFrom();
		}
		
		function updateUserTypeStatus(){
			if(document.getElementById('userTypeCode').value == null || document.getElementById('userTypeCode').value == ""){
				alert("Please Enter User Type Code");
				return false;
			}
			if(document.getElementById('userTypeName').value == null || document.getElementById('userTypeName').value ==""){
				alert("Please Enter User Type Name");
				return false;
			}
			
			var params = {
					
					'userTypeId':usertypeId,			 
					 'status':Status
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateUserTypeStatus";
			        SendJsonData(url,params);
			 
		     
		}
		
		function Reset(){
			
			document.getElementById('searchUserTypeName').value = "";
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddUserType').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			$j('#userTypeCode').attr('readonly', false);
			$j("#mmuStaff").prop('checked', false);
			showAll();
		}
				
		function ResetForm()
		{	
			$j('#userTypeCode').val('');
			$j('#userTypeName').val('');
			$j('#searchUserTypeName').val('');
			
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			GetAllUserType('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddUserType').show();
			$j('#userTypeCode').attr('readonly', false);
			
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllUserType('FILTER');
			
		} 
		
		 function search()
		 {
		 	if(document.getElementById('searchUserTypeName').value == ""){
		  		alert("Please Enter User Type Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllUserType('FILTER');
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
                <div class="internal_Htext">User Type Master</div>
                    
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
													<label class="col-3 col-form-label">User Type Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchUserTypeName" id="searchUserTypeName"
															class="form-control" id="inlineFormInputGroup"
															placeholder="User Type Name" onkeypress="return validateText('searchUserTypeName',180,'User Type Name')">

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
                                                <th id="th1" class ="inner_md_htext">User Type Code</th>
                                                <th id="th2" class ="inner_md_htext">User Type Name</th>
                                                <th id="th3" class ="inner_md_htext">MMU Staff</th>
                                                <th id="th4" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfUserType">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addUsertypeForm" name="addUsertypeForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" >User Type Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="userTypeCode" name="userTypeCode" placeholder="User Type Code" onkeypress=" return validateText('userTypeCode',20,'User Type Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">User Type Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="userTypeName" name="userTypeName" placeholder="User Type Name" onkeypress="return validateText('userTypeName',180,'userTypeName')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">   
                                                        <div class="form-check form-check-inline cusCheck m-t-5">
															<input class="form-check-input" type="checkbox"  name="mmuStaff" id="mmuStaff" value="y"/>
															<span class="cus-checkbtn"></span> 
															<label class="form-check-label m-l-5" for="EDL">MMU Staff</label>
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
												
														<button type="button" id="btnAddUserType"
															class="btn  btn-primary " onclick="addUserType();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateUserType();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateUserTypeStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateUserTypeStatus();">Deactivate</button>
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

