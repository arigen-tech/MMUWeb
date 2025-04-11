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
		$j('#headCode').attr('readonly', false);		
			GetAllApprovalAuthorityMapping('ALL');	
			getOrderList();
			});
			
	function GetAllApprovalAuthorityMapping(MODE){
		 
		var searchApprovingAuthorityName=$("#searchApprovingAuthorityName").val();		 
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "searchApprovingAuthorityName":""};			
			}else{
			var data = {"PN":nPageNo, "searchApprovingAuthorityName":searchApprovingAuthorityName};
			} 
		var url = "getAllApprovalAuthorityMapping";		
		var bClickable = true;
		GetJsonData('tblListOfApprovingAuthorityMapping',data,url,bClickable);	 
	}
	
	
	 
	 
	function getOrderList(){
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "getAllOrderNumber",
		    data: JSON.stringify({"PN" : "0"}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	var combo = "<option value=\"\">Select</option>" ;
		    	var combo1 = "<option value=\"\">Select</option>" ;
		    	if(result!=null && result.data!=null)
		    	for(var i=0;i<result.data.length;i++){
		    		combo += '<option value='+result.data[i].authorityId+'>' +result.data[i].approvingAuthorityName+ '</option>';
		    		
		    	}
		    	if(result!=null && result.data1!=null)
			    	for(var i=0;i<result.data1.length;i++){
			    		combo1 += '<option value='+result.data1[i].userTypeId+'>' +result.data1[i].userTypeName+ '</option>';
			    		
			    	}
		    	
		    	jQuery('#approvindAutorityNameList').append(combo);
		    	jQuery('#searchApprovingAuthorityName').append(combo);
		    	
		    	jQuery('#userTypeList').append(combo1);
		    }
		    
		});
	}
	
	
	function makeTable(jsonData)
	{	
		var htmlTable = "";	
		var data = jsonData.count; 
		
		var pageSize = 5; 	
		var dataList = jsonData.data; 
		
		if(dataList!=undefined && dataList.length>0){
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
					
				htmlTable = htmlTable+"<tr id='"+dataList[i].authorityMappingId+"' >";
				 
			var approvingAuthorityName=""
		if(dataList[i].approvingAuthorityName!=null && dataList[i].approvingAuthorityName!=undefined)
			approvingAuthorityName=dataList[i].approvingAuthorityName;
		else
			approvingAuthorityName="";
			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+approvingAuthorityName+"</td>";
				  
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].userTypeName+"</td>";
				 
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		}
		else
			{
			htmlTable = htmlTable+"<tr ><td colspan='3'><h6>No Record Found</h6></td></tr>";
			   
			}		
		
		$j("#tblListOfApprovingAuthorityMapping").html(htmlTable); 	
		
	}
	 var authorityMappingId;
		var authoritymappingid="";
		 
		 
		var approvingAuthorityName;
		 
		var userTypeName;
		var Status;
		var userTypeId;
		var approvalAuthorityId;
	function executeClickEvent(authorityMappingIdT,data)
	{
		
		for(j=0;j<data.data.length;j++){
			for(j=0;j<data.data.length;j++){
				if(authorityMappingIdT == data.data[j].authorityMappingId){
					authoritymappingid = data.data[j].authorityMappingId;
					 
					 if(data.data[j].approvingAuthorityName!=null && data.data[j].approvingAuthorityName!=undefined)
						approvingAuthorityName = data.data[j].approvingAuthorityName;
					 else
						 approvingAuthorityName="";
					 if(data.data[j].userTypeName!=null && data.data[j].userTypeName!=undefined)
						 userTypeName = data.data[j].userTypeName;
					 else
						 userTypeName="";
					  
					Status = data.data[j].status;
					  userTypeId= data.data[j].userTypeId;
					  approvalAuthorityId= data.data[j].approvingAuthorityId;
					 	
				
			}
		}
		rowClick(authoritymappingid,approvingAuthorityName,userTypeName, Status,userTypeId,approvalAuthorityId);
	}
	}
	
	function rowClick(authoritymappingid,approvingAuthorityName,userTypeName, Status,userTypeId,approvalAuthorityId){	
		authoritymappingid=authoritymappingid;
		   
		if(approvalAuthorityId!=null && approvalAuthorityId!="" && approvalAuthorityId!=undefined)
			document.getElementById("approvindAutorityNameList").value = approvalAuthorityId;
		else
			document.getElementById("approvindAutorityNameList").value ="";
		if(userTypeId!=null && userTypeId!="")	
			document.getElementById("userTypeList").value = userTypeId;
		else
			document.getElementById("userTypeList").value = "";
		if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnaddAuthority').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnaddAuthority').hide();
		}
		 
		
		
		/* $j('#approvingAuthorityCode').attr('readonly', true); */
		
	}


		function addAuthorityMapping(){
			
			 
			 
			if(document.getElementById('approvindAutorityNameList').value == null || document.getElementById('approvindAutorityNameList').value == "" || document.getElementById('approvindAutorityNameList').value == "0"){
				alert("Please Select  Approving Authority");
				return false;
			}
			  if(document.getElementById('userTypeList').value == null || document.getElementById('userTypeList').value =="" || document.getElementById('userTypeList').value =="0"){
				alert("Please Select User Type");
				return false;
			} 
			
			
			 
			
			$j('#btnaddAuthority').prop("disabled",true);
			var params = {		
					  
					 'approvindAutorityNameList':jQuery('#approvindAutorityNameList').val(),
					 'userTypeList':jQuery('#userTypeList').val(),
				 	 'userId': <%= userId%>
 		 	 }
			
			//alert(JSON.stringify(params));
			    var url = "addApprovalAuthorityMapping";
			    SendJsonData(url,params);
			    $j('#btnaddAuthority').attr("disabled", false);
			    ResetForm();
			    
		}
		 
		
		function updateAuthorityMapping(){
			 
			 
			if(document.getElementById('approvindAutorityNameList').value == null || document.getElementById('approvindAutorityNameList').value == "" || document.getElementById('approvindAutorityNameList').value == "0"){
				alert("Please Select  Approving Authority");
				return false;
			}
			  if(document.getElementById('userTypeList').value == null || document.getElementById('userTypeList').value =="" || document.getElementById('userTypeList').value =="0"){
				alert("Please Select User Type");
				return false;
			} 
			
			
		 
			
			var params = {
					 'authoritymappingid': authoritymappingid, 
					 'approvindAutorityNameList':jQuery('#approvindAutorityNameList').val(),
					 'userTypeList':jQuery('#userTypeList').val(),
				 	 'userId': <%= userId%>
					  
			 }
			//alert(JSON.stringify(params));
				    var url = "updateApprovalAuthorityMapping";
				    SendJsonData(url,params);
					$j('#btnaddAuthority').attr("disabled", false);
					 
					ResetForm();
		}
		
		function updateAuthorityMappingStatus(){
			
			
			var params = {
					
					 'authoritymappingid': authoritymappingid, 
					 'status':Status
					 
					 
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateApprovalAuthorityMappingStatus";
			        SendJsonData(url,params);
			 
		     
		}
		
		function Reset(){
			$j('#btnaddAuthority').prop("disabled",false);
			 
			document.getElementById('searchApprovingAuthorityName').value = "";
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnaddAuthority').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			 
			 
			showAll();
		}
				
		function ResetForm()
		{	
			$j('#btnaddAuthority').prop("disabled",false);
			 
		
			 
			$j('#approvingAuthorityName').val('');
			$j('#searchApprovingAuthorityName').val('');
			 
			$j('#approvindAutorityNameList').val('');
			$j('#userTypeList').val('');
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			GetAllApprovalAuthorityMapping('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnaddAuthority').show();
			 
			
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllApprovalAuthorityMapping('FILTER');
			
		} 
		
		 function search()
		 {
		 	if(document.getElementById('searchApprovingAuthorityName').value == ""){
		  		alert("Please Enter Approving Authority Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllApprovalAuthorityMapping('FILTER');
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
                <div class="internal_Htext">Approving Mapping Master</div>
                    
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
													<label class="col-3 col-form-label">Approving Authority Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<!-- <input type="text" name="searchApprovingAuthorityName" id="searchApprovingAuthorityName"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Approving Authority Name" onkeypress="return validateText('searchApprovingAuthorityName',100,'Approving Authority Name')">
 -->
																<select class="form-control" id="searchApprovingAuthorityName" name="searchApprovingAuthorityName" >
                                                                
                                                                                                                   
                                                                </select>
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
                                              <th id="th2" class ="inner_md_htext">Approving Authority Name</th>
                                                <th id="th1" class ="inner_md_htext">User Type</th>
                                                 <th id="th4" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfApprovingAuthorityMapping">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addAuthorityForm" name="addAuthorityForm" method="">
                                                <div class="row">
                                                 
                                                   
                                                    
                                                     <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Approving Authority Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="approvindAutorityNameList" name="approvindAutorityNameList" >
                                                                
                                                                                                                   
                                                                </select>
														</div>
                                                      </div>                                                    
                                                 </div>
                                                 
                                                   <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">User Type<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="userTypeList" name="userTypeList">
                                                                                                                            
                                                                </select>
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
												
														<button type="button" id="btnaddAuthority"
															class="btn  btn-primary " onclick="addAuthorityMapping();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateAuthorityMapping();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateAuthorityMappingStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateAuthorityMappingStatus();">Deactivate</button>
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

