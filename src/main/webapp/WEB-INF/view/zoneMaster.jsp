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
		GetAllZone('ALL');	
		GetCityList();
			});
			
	function GetAllZone(MODE){
		 
		var zoneName=$("#searchZoneName").val();		 
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "zoneName":""};			
			}else{
			var data = {"PN":nPageNo, "zoneName":zoneName};
			} 
		var url = "getAllZone";		
		var bClickable = true;
		GetJsonData('tblListOfZone',data,url,bClickable);	 
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
			    	
			    	for(var i=0;i<result.data.length;i++){
			    		combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
			    		
			    	}
			    	
			    	jQuery('#city').append(combo);
			    	
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
					
				htmlTable = htmlTable+"<tr id='"+dataList[i].zoneId+"' >";			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].zoneCode+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].zoneName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].cityName+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfZone").html(htmlTable); 	
		
	}
    var zoneId;
    var zoneid='';
	var cityId;
	var zoneCode;
	var zoneName;
	var Status;
	
	function executeClickEvent(zoneId,data)
	{
		
		for(j=0;j<data.data.length;j++){
			if(zoneId == data.data[j].zoneId){
				zoneId = data.data[j].zoneId;			
				zoneCode = data.data[j].zoneCode;			
				zoneName = data.data[j].zoneName;
				cityId = data.data[j].cityId;
				Status = data.data[j].status;
				
				
			}
		}
		rowClick(zoneId,zoneCode,zoneName,cityId,Status);
	}
	
	function rowClick(zoneId,zoneCode,zoneName,cityId,Status){	
		zoneid=zoneId;
		document.getElementById("zoneCode").value = zoneCode;
		document.getElementById("zoneName").value = zoneName;
		document.getElementById("city").value = cityId;
		if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddZone').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddZone').hide();
		}
		
		
		$j('#zoneCode').attr('readonly', true);
		
	}


		function addZone(){
			
			if(document.getElementById('zoneCode').value == null || document.getElementById('zoneCode').value == ""){
				alert("Please Enter Zone Code");
				return false;
			}
			if(document.getElementById('zoneName').value == null || document.getElementById('zoneName').value ==""){
				alert("Please Enter Zone Name");
				return false;
			}
			if(document.getElementById('city').value == null || document.getElementById('city').value ==""){
				alert("Please Select City");
				return false;
			}
			$j('#btnAddZone').prop("disabled",true);
			var params = {		
					
					 'zoneCode':jQuery('#zoneCode').val(),
					 'zoneName':jQuery('#zoneName').val(),
					 'cityId':jQuery('#city').val(),
					 'userId': <%= userId%>
			 }
			
			//alert(JSON.stringify(params));
			$j('#btnAddZone').attr("disabled", false);
			    var url = "addZone";
			    SendJsonData(url,params);
			
			    
		}
		
		function updateZone(){	
			if(document.getElementById('zoneCode').value == null || document.getElementById('zoneCode').value == ""){
				alert("Please Enter Zone Code");
				return false;
			}
			if(document.getElementById('zoneName').value == null || document.getElementById('zoneName').value ==""){
				alert("Please Enter Zone Name");
				return false;
			}
			if(document.getElementById('city').value == null || document.getElementById('city').value ==""){
				alert("Please Select City");
				return false;
			}
			
			var params = {		
					'zoneId':zoneid,
					 'zoneCode':jQuery('#zoneCode').val(),
					 'zoneName':jQuery('#zoneName').val(),
					 'cityId':jQuery('#city').val(),
					 'userId': <%= userId%>
			 }
			//alert(JSON.stringify(params));
				    var url = "updateZone";
				    SendJsonData(url,params);
					$j('#zoneCode').attr('readonly', true);
					ResetFrom();
		}
		
		function updateZoneStatus(){
						
			var params = {
					
					'zoneId':zoneid,			 
					 'status':Status
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateZoneStatus";
			        SendJsonData(url,params);
			 
		     
		}
		
		function Reset(){
			
			document.getElementById('searchZoneName').value = "";
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddZone').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			$j('#zoneCode').attr('readonly', false);
			showAll();
		}
				
		function ResetForm()
		{	
			$j('#zoneCode').val('');
			$j('#zoneName').val('');
			$j('#searchZoneName').val('');
			$j('#city').val('');
			
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			GetAllZone('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddZone').show();
			$j('#zoneCode').attr('readonly', false);
			
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllZone('FILTER');
			
		} 
		
		 function search()
		 {
		 	if(document.getElementById('searchZoneName').value == ""){
		  		alert("Please Enter Zone Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllZone('FILTER');
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
                <div class="internal_Htext">Zone Master</div>
                    
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
													<label class="col-3 col-form-label">Zone Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchZoneName" id="searchZoneName"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Zone Name" onkeypress="return validateText('searchZoneName',100,'Zone Name')">

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
                                                <th id="th1" class ="inner_md_htext">Zone Code</th>
                                                <th id="th2" class ="inner_md_htext">Zone Name</th>
                                                <th id="th3" class ="inner_md_htext">City</th>
                                                <th id="th4" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfZone">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addUsertypeForm" name="addUsertypeForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" >Zone Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="zoneCode" name="zoneCode" placeholder="Zone Code" onkeypress=" return validateText('zoneCode',7,'Zone Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Zone Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="zoneName" name="zoneName" placeholder="Zone Name" onkeypress="return validateText('zoneName',100,'Zone Name')">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">City<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="city" name="city" >
                                                                                                                           
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
												
														<button type="button" id="btnAddZone"
															class="btn  btn-primary " onclick="addZone();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateZone();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateZoneStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateZoneStatus();">Deactivate</button>
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

