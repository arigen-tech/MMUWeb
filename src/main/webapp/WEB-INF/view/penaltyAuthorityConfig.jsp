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
			getAllApprovingAuthorityDetail();	
		 	getDistrictList();
		 	getAllPenalityApprovalAuthority('ALL');	
			});
			
	function getAllPenalityApprovalAuthority(MODE){
		 
		var searchApprovingAuthorityName=$("#searchUPPSName").val();		 
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "searchUPPSName":""};			
			}else{
			var data = {"PN":nPageNo, "searchUPPSName":searchApprovingAuthorityName};
			} 
		var url = "getAllPenalityApprovalAuthority";		
		var bClickable = true;
		GetJsonData('tblListOfApprovingAuthority',data,url,bClickable);	 
	}
	
	
	 
	 
	
	 function getDistrictList(){
 		jQuery.ajax({
 		 	crossOrigin: true,
 		    method: "POST",			    
 		    crossDomain:true,
 		    url: "${pageContext.servletContext.contextPath}/master/getAllDistrict",
 		    data: JSON.stringify({"PN" : "0","upssFlag":"Y"}),
 		    contentType: "application/json; charset=utf-8",
 		    dataType: "json",
 		    success: function(result){
 		    	var combo = "" ;
 		    	
 		    	for(var i=0;i<result.data.length;i++){
 		    		combo += '<option value='+result.data[i].districtId+'>' +result.data[i].districtName+ '</option>';
 		    		
 		    	}
 		    	
 		    	jQuery('#upssNameData').append(combo);
 		    	jQuery('#searchUPPSName').append(combo);
 		    	 		    	
 		    }
 		    
 		});
 	}
  
	
	function getAllApprovingAuthorityDetail(){
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "getAllApprovalAuthority",
		    data: JSON.stringify({"PN" : "0"}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	var combo =""; //"<option value=\"\">Select</option>" ;
		    	if(result!=null && result.data!=null)
		    	for(var i=0;i<result.data.length;i++){
		    		combo += '<option value='+result.data[i].authorityId+'>' +result.data[i].approvingAuthorityName+ '</option>';
		    		
		    	}
		    	
		    	jQuery('#approvingAuthorityName').append(combo);
		    	
		    }
		    
		});
	}
	
	var authorityConfigId="";
	var	uppsName="";
	var uppsId="";
	 var authorityName="";
	 var authorityId="";

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
					
				htmlTable = htmlTable+"<tr id='"+dataList[i].authorityConfigId+"' >";
		
		 if(dataList[i].uppsName!=null && dataList[i].uppsName!=undefined){
			uppsName=dataList[i].uppsName;
			uppsId=dataList[i].uppsId;
		}
		else{
			uppsName="";
			uppsId="";
		}
				htmlTable = htmlTable +"<td style='width: 150px;'>"+uppsName+"</td>";
				
				if(dataList[i].authorityName!=null && dataList[i].authorityName!=undefined){
					authorityName=dataList[i].authorityName;
					authorityId=dataList[i].authorityId;
				}
				else{
					authorityName="";
					authorityId="";
				}
				htmlTable = htmlTable +"<td style='width: 150px;'>"+authorityName+"</td>";
				
				 
		 		htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='3'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfApprovingAuthority").html(htmlTable); 	
		
	}
     
	var authorityConfigid='';
	 
	var authorityConfigId="";
	var	uppsName="";
	var uppsId="";
	 var authorityName="";
	 var authorityId="";
	
	 var Status;
	  

	 function executeClickEvent(authorityConfigIdT,data)
	{
		
		for(j=0;j<data.data.length;j++){
			if(authorityConfigIdT == data.data[j].authorityConfigId){
				authorityConfigId = data.data[j].authorityConfigId;
				 if(data.data[j].uppsName!=null && data.data[j].uppsName!=undefined){
					 uppsName = data.data[j].uppsName;			
					 uppsId=data.data[j].uppsId;
				 }
				 else{
					 uppsName="";
					 uppsId="";
				 }
				 if(data.data[j].authorityName!=null && data.data[j].authorityName!=undefined){
					 authorityName = data.data[j].authorityName;
					 authorityId=data.data[j].authorityId;
				 }
				 else{
					 authorityName="";
					 authorityId="";
				 }
				  
				Status = data.data[j].status;
				 
			}
		}
		rowClick(authorityConfigId,uppsId,authorityId, Status);
	}
	
	function rowClick(authorityConfigId,uppsId,authorityId, Status ){	
		authorityConfigid=authorityConfigId;
		  
		if(uppsId!=null && uppsId!="" && uppsId!=undefined)
			document.getElementById("upssNameData").value = uppsId;
		else
			document.getElementById("upssNameData").value ="";
		
		if(authorityId!=null && authorityId!="")	
			document.getElementById("approvingAuthorityName").value = authorityId;
		else
			document.getElementById("approvingAuthorityName").value = "0";
		
		
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
		 
		
		//$j('#approvingAuthorityCode').attr('readonly', true);
		
	}


		function addPenalitytAuthority(){
			
			 
			if(document.getElementById('upssNameData').value == null || document.getElementById('upssNameData').value == "0"){
				alert("Please Select UPPS Name");
				return false;
			}
			if(document.getElementById('approvingAuthorityName').value == null || document.getElementById('approvingAuthorityName').value =="0"){
				alert("Please Select Approving Authority Name");
				return false;
			}
		 	
			$j('#btnaddAuthority').prop("disabled",true);
			var params = {		
					  
					 'upssNameData':jQuery('#upssNameData').val(),
					 'approvingAuthorityName':jQuery('#approvingAuthorityName').val(),
				 	  'userId': <%= userId%>
 					   
			 }
			
			//alert(JSON.stringify(params));
			    var url = "addPenalityApprovalAuthority";
			    SendJsonData(url,params);
			    $j('#btnaddAuthority').attr("disabled", false);
			    ResetForm();
			    
		}
		 
		function updatePenalityAuthority(){
			 
			if(document.getElementById('upssNameData').value == null || document.getElementById('upssNameData').value == "0"){
				alert("Please Select UPPS Name");
				return false;
			}
			if(document.getElementById('approvingAuthorityName').value == null || document.getElementById('approvingAuthorityName').value =="0"){
				alert("Please Select Approving Authority Name");
				return false;
			}
		 
			
			var params = {		
					  'authorityConfigid': authorityConfigid,
						 'upssNameData':jQuery('#upssNameData').val(),
						 'approvingAuthorityName':jQuery('#approvingAuthorityName').val(),
					 	  'userId': <%= userId%>
	 					  
			 }
			//alert(JSON.stringify(params));
				    var url = "updatePenalityApprovalAuthority";
				    SendJsonData(url,params);
					$j('#btnaddAuthority').attr("disabled", false);
					 
					ResetForm();
		}
		
		function updatePenalityAuthorityStatus(){
			 var params = {
					
					'authorityConfigid': authorityConfigid,
					 'status':Status
			 	} 
			
			//alert(JSON.stringify(params));
				    var url = "updatePenalityApprovalAuthorityStatus";
			        SendJsonData(url,params);
			 
		     
		}
		
		function Reset(){
			$j('#btnaddAuthority').prop("disabled",false);
			//$j('#approvingAuthorityCode').attr('readonly', false);
			document.getElementById('searchUPPSName').value = "0";
			document.getElementById('upssNameData').value = "0";
			document.getElementById('approvingAuthorityName').value = "0";
			
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
			//$j('#approvingAuthorityCode').attr('readonly', false);
		
			//$j('#approvingAuthorityCode').val('');
			//$j('#approvingAuthorityName').val('');
			$j('#searchUPPSName').val('0');
			//$('#finalApproval').prop('checked', false);
			//$j('#orderNumber').val('0');
			$//j('#levelOfUser').val('0');
			document.getElementById('upssNameData').value = "0";
			document.getElementById('approvingAuthorityName').value = "0";
		
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			getAllPenalityApprovalAuthority('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnaddAuthority').show();
			 
			
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			getAllPenalityApprovalAuthority('FILTER');
			
		} 
		
		 function search()
		 {
		 	if(document.getElementById('searchUPPSName').value == "" || document.getElementById('searchUPPSName').value == "0"){
		  		alert("Please UPSS  Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	getAllPenalityApprovalAuthority('FILTER');
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
                <div class="internal_Htext">Penalty Approving Authority Master</div>
                    
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
													<label class="col-3 col-form-label">UPPS Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<!-- <input type="text" name="searchUPPSName" id="searchUPPSName"
															class="form-control" id="inlineFormInputGroup"
															placeholder="UPPS Name" onkeypress="return validateText('searchUPPSName',100,'UPPS Name')">
														 -->	
															  <select class="form-control" id="searchUPPSName" name="searchUPPSName" >
                                                                <option value="0">Select</option>
                                                                                                                           
                                                                </select>

													</div>
													<!--  <div class="col-sm-7">
                                                                <select class="form-control" id="upssNameData" name="upssNameData" >
                                                                <option value="0">Select</option>
                                                                                                                           
                                                                </select>
														</div>
													
													 -->
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
                                               
                                                <th id="th1" class ="inner_md_htext">UPPS Name</th>
                                                  <th id="th2" class ="inner_md_htext">Approving Authority </th>
                                                    <th id="th1" class ="inner_md_htext">Status</th>
                                                 
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
                                                            <label for="collection name" class="col-form-label inner_md_htext">UPSS Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="upssNameData" name="upssNameData" >
                                                                <option value="0">Select</option>
                                                                                                                           
                                                                </select>
														</div>
                                                      </div>                                                    
                                                 </div>
                                                 
                                                   <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Approving Authority Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="approvingAuthorityName" name="approvingAuthorityName" >
                                                                       <option value="0">Select</option>
                                                                                                                              
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
															class="btn  btn-primary " onclick="addPenalitytAuthority();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updatePenalityAuthority();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updatePenalityAuthorityStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updatePenalityAuthorityStatus();">Deactivate</button>
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

