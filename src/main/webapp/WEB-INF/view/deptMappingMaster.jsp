<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	
	$j(document).ready(function() {
		$('#addkey').click(function() {
			
				if ($('#departmentSelect option:selected').val() != null) {
						 $('#departmentSelect option:selected').remove().appendTo('#appendDepartmentSelect');
						 $("#departmentSelect").attr('selectedIndex','-1').find("option:selected").removeAttr("selected");
			         	 $("#departmentSelect").attr('selectedIndex', '-1').find("option:selected").removeAttr("selected");      
					 } 
			});
		$('#removeKey').click(function() {
			       if ($('#appendDepartmentSelect option:selected').val() != null) {
			             	$('#appendDepartmentSelect option:selected').remove().appendTo('#departmentSelect');
			           	 	$("#appendDepartmentSelect").attr('selectedIndex',  '-1').find("option:selected").removeAttr("selected");
			          		$("#appendDepartmentSelect").attr('selectedIndex', '-1').find("option:selected").removeAttr("selected");       
						}
			});  

	 });
	 

	$j(document).ready(function()
			{
		$j("#btnActive").hide();
		$j("#btnInActive").hide();		
		$j('#updateBtn').hide();	  
		GetAllDeptMapping('ALL');	
		GetDepartmentList();
		GetMMUList();
			});
			
	function GetAllDeptMapping(MODE){
		 
		var mmuName=$("#searchMMUName").val();		 
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "mmuName":""};			
			}else{
			var data = {"PN":nPageNo, "mmuName":mmuName};
			} 
		var url = "getAllDeptMapping";		
		var bClickable = true;
		GetJsonData('tblListOfDeptMapping',data,url,bClickable);	 
	}
	
	function GetDepartmentList(){
			jQuery.ajax({
			 	crossOrigin: true,
			    method: "POST",			    
			    crossDomain:true,
			    url: "getAllDepartment",
			    data: JSON.stringify({"PN" : "0"}),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	var combo = "<option value=\"\">Select</option>" ;
			    	
			    	for(var i=0;i<result.data.length;i++){
			    		combo += '<option value='+result.data[i].departmentId+'>' +result.data[i].departmentName+ '</option>';
			    		
			    	}
			    	
			    	jQuery('#departmentSelect').append(combo);
			    	
			    }
			    
			});
		}

	function GetMMUList(){
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "getAllMMU",
		    data: JSON.stringify({"PN" : "0"}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	var combo = "<option value=\"\">Select</option>" ;
		    	
		    	for(var i=0;i<result.data.length;i++){
		    		combo += '<option value='+result.data[i].mmuId+'>' +result.data[i].mmuName+ '</option>';
		    		
		    	}
		    	
		    	jQuery('#mmuName').append(combo);
		    	
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
					
				htmlTable = htmlTable+"<tr id='"+dataList[i].mmuDepartmentId+"' >";			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].mmuName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].departmentName+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfDeptMapping").html(htmlTable); 	
		
	}
    var mmuDepartmentId;
    var mmuDepartmentid='';
    var departmentId;
    var departmentName;
	var mmuId;
	var mmuName;
	var Status;
	
	function executeClickEvent(mmuDepartmentId,data)
	{
		
		for(j=0;j<data.data.length;j++){
			if(mmuDepartmentId == data.data[j].mmuDepartmentId){
				mmuDepartmentId = data.data[j].mmuDepartmentId;			
				mmuId = data.data[j].mmuId;			
				mmuName = data.data[j].mmuName;
				departmentId = data.data[j].departmentId;
				departmentName = data.data[j].departmentName;
				Status = data.data[j].status;
				
				
			}
		}
		rowClick(mmuDepartmentId,mmuId,mmuName,departmentId,departmentName,Status);
	}
	
	function rowClick(mmuDepartmentId,mmuId,mmuName,departmentId,departmentName,Status){	
		mmuDepartmentid=mmuDepartmentId;
		jQuery('#appendDepartmentSelect').empty();
		document.getElementById("mmuName").value = mmuId;
		var combo='';
		  combo += '<option value='+departmentId+'>' +departmentName+ '</option>';
		  jQuery('#appendDepartmentSelect').append(combo);
		
		  if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnDeptMapping').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnDeptMapping').hide();
		}
		
		
		
	}


		function addDeptMapping(){
			
			if(document.getElementById('mmuName').value == null || document.getElementById('mmuName').value == ""){
				alert("Please Select MMU Name");
				return false;
			}
			if(document.getElementById('appendDepartmentSelect').value == null || document.getElementById('appendDepartmentSelect').value ==""){
				alert("Please Select Department");
				return false;
			}
			
			$j('#btnDeptMapping').prop("disabled",true);
			var params = {		
					
					 'mmuId':jQuery('#mmuName').val(),
					 'departmentId':jQuery('#appendDepartmentSelect').val(),
					 'userId': <%= userId%>
			 }
			
			//alert(JSON.stringify(params));
			$j('#btnDeptMapping').attr("disabled", false);
			    var url = "addDeptMapping";
			    SendJsonData(url,params);
			
			    
		}
		
		function updateDeptMapping(){	
			if(document.getElementById('mmuName').value == null || document.getElementById('mmuName').value == ""){
				alert("Please Select MMU Name");
				return false;
			}
			
			if(document.getElementById('appendDepartmentSelect').value == null || document.getElementById('appendDepartmentSelect').value ==""){
				alert("Please Select Department");
				return false;
			}
			
			var params = {		
					 'mmuDepartmentId': mmuDepartmentid,
					 'mmuId':jQuery('#mmuName').val(),
					 'departmentId':jQuery('#appendDepartmentSelect').val(),
					 'userId': <%= userId%>
			 }
		
			       var url = "updateDeptMapping";
				    SendJsonData(url,params);
					ResetForm();
		}
		
		function updateDeptMappingStatus(){
						
			var params = {
					
					'mmuDepartmentId':mmuDepartmentid,			 
					 'status':Status
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateDeptMappingStatus";
			        SendJsonData(url,params);
			 
		     
		}
		
		function Reset(){
			
			document.getElementById('searchMMUName').value = "";
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnDeptMapping').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			showAll();
		}
				
		function ResetForm()
		{	
			$j('#searchMMUName').val('');
			$j('#mmuName').val('');
			$j('#appendDepartmentSelect').empty();
			
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			GetAllDeptMapping('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnDeptMapping').show();
			
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllDeptMapping('FILTER');
			
		} 
		
		 function search()
		 {
		 	if(document.getElementById('searchMMUName').value == ""){
		  		alert("Please Enter MMU Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllDeptMapping('FILTER');
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
                <div class="internal_Htext">MMU Department Mapping Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchDeptMappingForm"
												name="searchBankForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">MMU Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchMMUName" id="searchMMUName"
															class="form-control" id="inlineFormInputGroup"
															placeholder="MMU Name" onkeypress="return validateText('searchMMUName',50,'MMU Name')">

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
                                                <th id="th1" class ="inner_md_htext">MMU Name</th>
                                                <th id="th2" class ="inner_md_htext">Department</th>
                                                <th id="th3" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfDeptMapping">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="DeptMappingForm" name="DeptMappingForm" method="">
                                                <div class="row">
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">MMU Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="mmuName" name="mmuName" >
                                                                                                                           
                                                                </select>
														</div>
                                                      </div>                                                    
                                                 </div>                                                    
                                                    
                                         <div class="w-100 m-t-10"></div>      
                                        <div class="col-sm-4 col-md-4 ">
                                        <label>Department<span class="mandate"><sup>&#9733;</sup></span></label>						             	
						             	<select multiple class="form-control height110" id="departmentSelect" name="departmentSelect">
		            			            
				                   		 </select>
				                   	</div>
                                     <div class="col-sm-1 col-md-1 text-center selectorImgDiv"> 									
									    <div class="span2"> <span id="addkey" class="cursor-pointer"><img alt="" src="${pageContext.request.contextPath}/resources/images/rightarrow.jpg" width="30px"> </span></div>
										<div class="span2"> <span id="removeKey" class="cursor-pointer"><img alt="" src="${pageContext.request.contextPath}/resources/images/leftarrow.jpg" width="30px"> </span></div> 
									</div> 
									
									<div class="col-sm-4 col-md-4 ">
									   	<label>&nbsp;</label>					             	
						             	<select multiple class="form-control height110" id="appendDepartmentSelect" name="appendDepartmentSelect">
		            			            
				                   		 </select>
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
												
														<button type="button" id="btnDeptMapping"
															class="btn  btn-primary " onclick="addDeptMapping();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateDeptMapping();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateDeptMappingStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateDeptMappingStatus();">Deactivate</button>
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

