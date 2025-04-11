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
			GetAllApprovalAuthority('ALL');	
			//getOrderList();
			});
			
	function GetAllApprovalAuthority(MODE){
		 
		var searchApprovingAuthorityName=$("#searchApprovingAuthorityName").val();		 
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "searchApprovingAuthorityName":""};			
			}else{
			var data = {"PN":nPageNo, "searchApprovingAuthorityName":searchApprovingAuthorityName};
			} 
		var url = "getAllApprovalAuthority";		
		var bClickable = true;
		GetJsonData('tblListOfApprovingAuthority',data,url,bClickable);	 
	}
	
	
	function checkFinalApproval(){
		
		 if(document.getElementById("finalApproval").checked == true){
		
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "checkFinalApproval",
		    data: JSON.stringify({"PN" : "0"}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	 var status=result.status;
		    	if(status=='1'){
		    		
		    		alert("Final Authority Already Exist.");
		    		document.getElementById("finalApproval").checked=false;
		    		return false;
		    	}
		    	 
		    }
		    
		});
		 }
		 else{
			 return false;
		 }
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
		    	if(result!=null && result.data!=null)
		    	for(var i=0;i<result.data.length;i++){
		    		combo += '<option value='+result.data[i].orderHdId+'>' +result.data[i].orderHdId+ '</option>';
		    		
		    	}
		    	
		    	jQuery('#orderNumber').append(combo);
		    	
		    }
		    
		});
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
					
				htmlTable = htmlTable+"<tr id='"+dataList[i].authorityId+"' >";
				 
			var approvindAuthorityCode=""
		if(dataList[i].approvingAuthorityCode!=null && dataList[i].approvingAuthorityCode!=undefined)
			approvindAuthorityCode=dataList[i].approvingAuthorityCode;
		else
			approvindAuthorityCode="";
			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+approvindAuthorityCode+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].approvingAuthorityName+"</td>";
				
				 
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].levelOfUser+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].orderNumber+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfApprovingAuthority").html(htmlTable); 	
		
	}
    var authorityId;
	var authorityid='';
	 
	var approvingAuthorityCode;
	var approvingAuthorityName;
	var levelOfUser;
	var orderNumber;
	var Status;
	 var finalApproval;
	function executeClickEvent(authorityIdT,data)
	{
		
		for(j=0;j<data.data.length;j++){
			if(authorityIdT == data.data[j].authorityId){
				authorityId = data.data[j].authorityId;
				 if(data.data[j].approvingAuthorityCode!=null && data.data[j].approvingAuthorityCode!=undefined)
					approvingAuthorityCode = data.data[j].approvingAuthorityCode;			
				 else
					 approvingAuthorityCode=""; 
				 if(data.data[j].approvingAuthorityName!=null && data.data[j].approvingAuthorityName!=undefined)
					approvingAuthorityName = data.data[j].approvingAuthorityName;
				 else
					 approvingAuthorityName="";
				 if(data.data[j].levelOfUser!=null && data.data[j].levelOfUser!=undefined)
					levelOfUser = data.data[j].levelOfUser;
				 else
					 levelOfUser="0";
				 if(data.data[j].orderNumber!=null && data.data[j].orderNumber!=undefined) 
					 orderNumber=data.data[j].orderNumber;
				 else
					 orderNumber="";
				Status = data.data[j].status;
				
				finalApproval=data.data[j].finalApproval	;	
				
			}
		}
		rowClick(authorityId,approvingAuthorityCode,approvingAuthorityName,levelOfUser,orderNumber,Status,finalApproval);
	}
	
	function rowClick(authorityId,approvingAuthorityCode,approvingAuthorityName,levelOfUser,orderNumber,Status,finalApproval){	
		authorityid=authorityId;
		  
		document.getElementById("approvingAuthorityCode").value = approvingAuthorityCode;
		 
			 
		document.getElementById("approvingAuthorityName").value = approvingAuthorityName;
		if(levelOfUser!=null && levelOfUser!="" && levelOfUser!=undefined)
			document.getElementById("levelOfUser").value = levelOfUser;
		else
			document.getElementById("levelOfUser").value ="0";
		if(orderNumber!=null && orderNumber!="")	
			document.getElementById("orderNumber").value = orderNumber;
		else
			document.getElementById("orderNumber").value = "0";
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
		if(finalApproval == 'y'){	
			 
			$('#finalApproval').prop('checked', true);
		}else{
			$('#finalApproval').prop('checked', false);
		}
		
		
		$j('#approvingAuthorityCode').attr('readonly', true);
		
	}


		function addAuthority(){
			
			 
			if(document.getElementById('approvingAuthorityCode').value == null || document.getElementById('approvingAuthorityCode').value == ""){
				alert("Please Enter Approving Authority Code");
				return false;
			}
			if(document.getElementById('approvingAuthorityName').value == null || document.getElementById('approvingAuthorityName').value ==""){
				alert("Please Enter Approving Authority Name");
				return false;
			}
			
			if(document.getElementById('levelOfUser').value == null || document.getElementById('levelOfUser').value == "" || document.getElementById('levelOfUser').value == "0"){
				alert("Please Select  level Of User");
				return false;
			}
			  if(document.getElementById('orderNumber').value == null || document.getElementById('orderNumber').value =="" || document.getElementById('orderNumber').value =="0"){
				alert("Please Select Order Number");
				return false;
			} 
			
			
			 
			
			$j('#btnaddAuthority').prop("disabled",true);
			var params = {		
					  
					 'approvingAuthorityCode':jQuery('#approvingAuthorityCode').val(),
					 'approvingAuthorityName':jQuery('#approvingAuthorityName').val(),
				 	 'levelOfUser':jQuery('#levelOfUser').val(),
					 'orderNumber':jQuery('#orderNumber').val(),
 					 'userId': <%= userId%>,
 					 'finalApproval': getFinalApprovalValue()
					  
			 }
			
			//alert(JSON.stringify(params));
			    var url = "addApprovalAuthority";
			    SendJsonData(url,params);
			    $j('#btnaddAuthority').attr("disabled", false);
			    ResetForm();
			    
		}
		function getFinalApprovalValue(){
			var finalApproval='n';
			 if(document.getElementById("finalApproval").checked == true){
				 finalApproval='y'
			 }
			 else{
				 finalApproval='n'
			 }
			 return finalApproval;
		} 
		
		function updateAuthority(){
			 
			if(document.getElementById('approvingAuthorityCode').value == null || document.getElementById('approvingAuthorityCode').value == ""){
				alert("Please Enter Approving Authority Code");
				return false;
			}
			if(document.getElementById('approvingAuthorityName').value == null || document.getElementById('approvingAuthorityName').value ==""){
				alert("Please Enter Approving Authority Name");
				return false;
			}
			
			if(document.getElementById('levelOfUser').value == null || document.getElementById('levelOfUser').value == "" || document.getElementById('levelOfUser').value == "0"){
				alert("Please Select  List Of User");
				return false;
			}
			if(document.getElementById('orderNumber').value == null || document.getElementById('orderNumber').value =="" || document.getElementById('orderNumber').value =="0"){
				alert("Please Select Order Number");
				return false;
			}
			
		 
			
			var params = {		
					  'authorityid': authorityid,
					  'approvingAuthorityCode':jQuery('#approvingAuthorityCode').val(),
						 'approvingAuthorityName':jQuery('#approvingAuthorityName').val(),
					 	 'levelOfUser':jQuery('#levelOfUser').val(),
						 'orderNumber':jQuery('#orderNumber').val(),
	 					 'userId': <%= userId%>,
	 					'finalApproval': getFinalApprovalValue()
					  
			 }
			//alert(JSON.stringify(params));
				    var url = "updateApprovalAuthority";
				    SendJsonData(url,params);
					$j('#btnaddAuthority').attr("disabled", false);
					 
					ResetForm();
		}
		
		function updateAuthorityStatus(){
			
			
			var params = {
					
					 'authorityid': authorityid, 
					 'status':Status,
					 'finalApproval': getFinalApprovalValue()
					 
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateApprovalAuthorityStatus";
			        SendJsonData(url,params);
			 
		     
		}
		
		function Reset(){
			$j('#btnaddAuthority').prop("disabled",false);
			$j('#approvingAuthorityCode').attr('readonly', false);
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
			$j('#approvingAuthorityCode').attr('readonly', false);
		
			$j('#approvingAuthorityCode').val('');
			$j('#approvingAuthorityName').val('');
			$j('#searchApprovingAuthorityName').val('');
			$('#finalApproval').prop('checked', false);
			$j('#orderNumber').val('0');
			$j('#levelOfUser').val('0');
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			GetAllApprovalAuthority('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnaddAuthority').show();
			 
			
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllApprovalAuthority('FILTER');
			
		} 
		
		 function search()
		 {
		 	if(document.getElementById('searchApprovingAuthorityName').value == ""){
		  		alert("Please Enter Approving Authority Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllApprovalAuthority('FILTER');
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
                <div class="internal_Htext">Approving Authority Master</div>
                    
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

														<input type="text" name="searchApprovingAuthorityName" id="searchApprovingAuthorityName"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Approving Authority Name" onkeypress="return validateText('searchApprovingAuthorityName',100,'Approving Authority Name')">

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
                                              <th id="th2" class ="inner_md_htext">Approving Authority Code</th>
                                                <th id="th1" class ="inner_md_htext">Approving Authority Name</th>
                                                  <th id="th2" class ="inner_md_htext">Level Of Users</th>
                                                   <th id="th2" class ="inner_md_htext">Order Number</th>
                                                <th id="th4" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfApprovingAuthority">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addAuthorityForm" name="addAuthorityForm" method="">
                                                <div class="row">
                                                 
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" >Approving Authority Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="approvingAuthorityCode" name="approvingAuthorityCode" placeholder="Approving Authority Code" onkeypress=" return validateText('approvingAuthorityCode',7,'Approving Authority Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Approving Authority Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="approvingAuthorityName" name="approvingAuthorityName" placeholder="Approving Authority Name" onkeypress="return validateText('approvingAuthorityName',100,'Approving Authority Name')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                     <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Level of User<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="levelOfUser" name="levelOfUser" >
                                                                <option value="0">Select</option>
                                                                     <option value="City">City</option>  
                                                                     <option value="UPSS">UPSS</option>                                                      
                                                                </select>
														</div>
                                                      </div>                                                    
                                                 </div>
                                                 
                                                   <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Order No.<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="orderNumber" name="orderNumber" >
                                                                       <option value="0">Select</option>
                                                                     <option value="1">1</option>  
                                                                     <option value="2">2</option>  
                                                                      <option value="3">3</option>  
                                                                     <option value="4">4</option>  
                                                                      <option value="5">5</option>  
                                                                     <option value="6">6</option>  
                                                                      <option value="7">7</option>  
                                                                     <option value="8">8</option>  
                                                                      <option value="9">9</option>  
                                                                     <option value="10">10</option>                                                        
                                                                </select>
														</div>
                                                      </div>                                                    
                                                 </div>
                                                    
                                                  <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Final Approving Authority </label>
                                                            </div>
                                                            <div class="form-check form-check-inline cusCheck m-t-7">
																<input class="form-check-input" type="checkbox" id="finalApproval" name="finalApproval"  value="" onclick="checkFinalApproval()">
															<span class="cus-checkbtn"></span>
															  
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
															class="btn  btn-primary " onclick="addAuthority();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateAuthority();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateAuthorityStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateAuthorityStatus();">Deactivate</button>
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

