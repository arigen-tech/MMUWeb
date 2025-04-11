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
		GetAllWard('ALL');		
		GetCityList();
		
			});
			
	function GetAllWard(MODE){
		 
		var wardName=$("#searchWardName").val();	
		var searchCityName=$("#searchCityName").val();	
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "wardName":""};			
			}else{
			var data = {"PN":nPageNo, "wardName":wardName,"searchCityName":searchCityName};
			} 
		var url = "getAllWard";		
		var bClickable = true;
		GetJsonData('tblListOfWard',data,url,bClickable);	 
	}
	
	function GetCityList(){
			jQuery.ajax({
			 	crossOrigin: true,
			    method: "POST",			    
			    crossDomain:true,
			    url: "getAllCity",
			    data: JSON.stringify({"PN" : "0"}),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	var combo = "<option value=\"\">Select</option>" ;
			    	if(result!=null && result.data!=null)
			    	for(var i=0;i<result.data.length;i++){
			    		combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
			    		
			    	}
			    	
			    	jQuery('#city').append(combo);
			    	jQuery('#searchCityName').append(combo);
			    	
			    }
			    
			});
		}
   
		
	function GetZoneListByCity(cityId){
		
		$j("#zone").empty();
		if(cityId !=''){
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "getAllZone",
		    data: JSON.stringify({"PN" : "0","cityId":cityId}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	var combo = "<option value=\"\">Select</option>" ;
		    	
		    	for(var i=0;i<result.data.length;i++){
		    		combo += '<option value='+result.data[i].zoneId+'>' +result.data[i].zoneName+ '</option>';
		    		
		    	}
		    	
		    	jQuery('#zone').append(combo);
		    	
		    }
		    
		});
	 }
	}
	
	function makeTable(jsonData)
	{	
		var htmlTable = "";	
		var data = jsonData.count; 
		
		var pageSize = 5; 	
		var dataList = jsonData.data; 
		
		if(dataList!=null)
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
					
				htmlTable = htmlTable+"<tr id='"+dataList[i].wardId+"' >";			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].wardName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].wardNo+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].cityName+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList!=null && dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='5'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfWard").html(htmlTable); 	
		
	}
    var wardId;
    var wardid='';
	var cityId;
	var wardName;
	var wardNo;
	var Status;
	
	function executeClickEvent(wardId,data)
	{
		
		for(j=0;j<data.data.length;j++){
			if(wardId == data.data[j].wardId){
				wardId = data.data[j].wardId;			
				wardNo = data.data[j].wardNo;	
				wardName = data.data[j].wardName;
				cityId = data.data[j].cityId;
				zoneId = data.data[j].zoneId;
				Status = data.data[j].status;
				
				
			}
		}
		rowClick(wardId,wardName,cityId,zoneId,Status);
	}
	
	function rowClick(wardId,wardName,cityId,zoneId,Status){	
		wardid=wardId;
		document.getElementById("wardNo").value = wardNo;
		document.getElementById("wardName").value = wardName;
		document.getElementById("city").value = cityId;
		document.getElementById("zone").value = zoneId;
		
		if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddWard').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddWard').hide();
		}
		
		
		$j('#zoneCode').attr('readonly', true);
		
	}


		function addWard(){
			
						
			if(document.getElementById('wardNo').value == null || document.getElementById('wardNo').value == ""){
				alert("Please Enter Ward No");
				return false;
			}
			
			if(document.getElementById('wardName').value == null || document.getElementById('wardName').value ==""){
				alert("Please Enter Ward Name");
				return false;
			}
			if(document.getElementById('city').value == null || document.getElementById('city').value ==""){
				alert("Please Select City");
				return false;
			}
			
			
			$j('#btnAddWard').prop("disabled",true);
			var params = {		
					 'wardNo':jQuery('#wardNo').val(),
					 'wardName':jQuery('#wardName').val(),
					 'cityId':jQuery('#city').val(),
					 'zoneId':jQuery('#zone').val() !='' ? jQuery('#zone').val() : null,
					 'userId': <%= userId%>
			 }
			
			//alert(JSON.stringify(params));
			$j('#btnAddWard').attr("disabled", true);
			    var url = "addWard";
			    SendJsonData(url,params);
			
			    
		}
		
		function updateWard(){	
						
			if(document.getElementById('wardNo').value == null || document.getElementById('wardNo').value == ""){
				alert("Please Enter Ward No");
				return false;
			}
			
			if(document.getElementById('wardName').value == null || document.getElementById('wardName').value ==""){
				alert("Please Enter Ward Name");
				return false;
			}
			if(document.getElementById('city').value == null || document.getElementById('city').value ==""){
				alert("Please Select City");
				return false;
			}
			
			
			$j('#btnAddWard').prop("disabled",true);
			var params = {	
					'wardId':wardid,
					 'wardNo':jQuery('#wardNo').val(),
					 'wardName':jQuery('#wardName').val(),
					 'cityId':jQuery('#city').val(),
					 'zoneId':jQuery('#zone').val() !='' ? jQuery('#zone').val() : null,
					 'userId': <%= userId%>
			 }
			//alert(JSON.stringify(params));
				    var url = "updateWard";
				    SendJsonData(url,params);
					
					ResetFrom();
		}
		
		function updateWardStatus(){
						
			var params = {
					
					'wardId': wardid,			 
					 'status':Status
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateWardStatus";
			        SendJsonData(url,params);
			 
		     
		}
		
		function Reset(){
			
			document.getElementById('searchWardName').value = "";
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddWard').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			
			showAll();
		}
				
		function ResetForm()
		{	
			
			$j('#wardNo').val('');
			$j('#wardName').val('');
			$j('#searchWardName').val('');
			$j('#city').val('');
			$j('#zone').val('');
			$j('#searchCityName').val('');
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			GetAllWard('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddWard').show();
					
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllWard('FILTER');
			
		} 
		
		 function search()
		 {
			if(document.getElementById('searchCityName').value == ""){ 
		 	if(document.getElementById('searchWardName').value == ""){
		  		alert("Please Enter Ward Name");
		  		return false;
		  	}
			}
		 	nPageNo=1;
		 	GetAllWard('FILTER');
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
                <div class="internal_Htext">Ward Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                            <div class="col-md-4">
										 
												<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Ward Name<span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-7">

														<input type="text" name="searchWardName" id="searchWardName"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Ward Name" onkeypress="return validateText('searchWardName',100,'Ward Name')">

													</div>
													
												</div>
											  
									 	</div>
									 	
									 	<div class="col-md-4">
										 
												<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">City Name</label>
													</div>
													<div class="col-7">
													<select class="form-control" id="searchCityName" name="searchCityName" onchange="">
												    <option value="">Select</option>
												</select>
														 

													</div>
													
												</div>
											  
									 	</div>
									 	
									 <div class="col-lg-4 col-sm-6">
										<button type="button" class="btn btn-primary" onclick="search()">Search</button>
									</div>
									<div class="col-lg-4 col-sm-6 text-right">
										<button type="button" class="btn btn-primary" onclick="showAll('ALL');">Show All</button>
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
                                                
                                                <th id="th2" class ="inner_md_htext">Ward Name</th>
                                                <th id="th3" class ="inner_md_htext">Ward No</th>
                                                <th id="th4" class ="inner_md_htext">City</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfWard">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addUsertypeForm" name="addWardForm" method="">
                                                <div class="row">
                                                                                                       
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Ward No<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="wardNo" name="wardNo" placeholder="Ward No" onkeypress="return validateText('wardNo',50,'Ward No')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Ward Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="wardName" name="wardName" placeholder="Ward Name" onkeypress="return validateText('wardName',100,'Ward Name')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">City<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="city" name="city" onchange="GetZoneListByCity(this.value)" >
                                                                                                                           
                                                                </select>
														</div>
                                                      </div>                                                    
                                                 </div>
                                                 
                                                 <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Zone</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="zone" name="zone" >
                                                                                                                           
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
												
														<button type="button" id="btnAddWard"
															class="btn  btn-primary " onclick="addWard();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateWard();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateWardStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateWardStatus();">Deactivate</button>
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

