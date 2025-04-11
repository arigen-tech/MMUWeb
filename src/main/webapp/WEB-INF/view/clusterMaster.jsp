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
		$j('#cityCode').attr('readonly', false);		
		GetAllCity('ALL');	
		//GetDistrictList();
			});
			
	function GetAllCity(MODE){
		 
		var clusterName=$("#searchClusterName").val();		 
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "clusterName":""};			
			}else{
			var data = {"PN":nPageNo, "clusterName":clusterName};
			} 
		var url = "getAllCluster";		
		var bClickable = true;
		GetJsonData('tblListOfCity',data,url,bClickable);	 
	}

	function GetDistrictList(){
			jQuery.ajax({
			 	crossOrigin: true,
			    method: "POST",			    
			    crossDomain:true,
			    url: "getAllDistrict",
			    data: JSON.stringify({"PN" : "0"}),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	var combo = "<option value=\"\">Select</option>" ;
			    	
			    	for(var i=0;i<result.data.length;i++){
			    		combo += '<option value='+result.data[i].districtId+'>' +result.data[i].districtName+ '</option>';
			    		
			    	}
			    	
			    	jQuery('#district').append(combo);
			    	
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
					
				htmlTable = htmlTable+"<tr id='"+dataList[i].clusterId+"' >";			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].clusterName+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfCity").html(htmlTable); 	
		
	}
    var clusterId;
	var clusterName;
	var Status;
	
	function executeClickEvent(clusterId,data)
	{
		
		for(j=0;j<data.data.length;j++){
			if(clusterId == data.data[j].clusterId){
				clusterId = data.data[j].clusterId;			
				clusterName = data.data[j].clusterName;
				Status = data.data[j].status;
              				
				
			}
		}
		rowClick(clusterId,clusterName,Status);
	}
	
	function rowClick(clusterId,clusterName,Status){
		 if (clusterId != null) {
             document.getElementById('clusterIdValue').value = clusterId;
         }
		clusterId=clusterId;
		//document.getElementById("cityCode").value = cityCode;
		document.getElementById("clusterName").value = clusterName;
		//document.getElementById("district").value = districtId;
		/* if(mmuOperational == 'Y' || mmuOperational == 'y'){	
		document.getElementById("operational").value = mmuOperational.toUpperCase();	
		}
		if(mmuOperational == 'N' || mmuOperational == 'n'){	
			document.getElementById("operational").value = mmuOperational.toUpperCase();
		} */
		if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddCity').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddCity').hide();
		}
		
		
		//$j('#cityCode').attr('readonly', true);
		
	}


		function addCluster(){
			
			if(document.getElementById('clusterName').value == null || document.getElementById('clusterName').value ==""){
				alert("Please Enter Cluster Name");
				return false;
			}
			
			
			$j('#btnAddCity').prop("disabled",true);
			var params = {		
					
					
					 'clusterName':jQuery('#clusterName').val(),
					 'userId': <%= userId%>,
					 'clusterId':"",
			 }
			
			//alert(JSON.stringify(params));
			    var url = "addCluster";
			    SendJsonData(url,params);
			
			    
		}
		
		function updateCluster(){	
			
			if(document.getElementById('clusterName').value == null || document.getElementById('clusterName').value ==""){
				alert("Please Enter Cluster Name");
				return false;
			}
			
			
			
			var params = {		
					  'clusterId': $('#clusterIdValue').val(),
					 'clusterName':jQuery('#clusterName').val(),
					 'userId': <%= userId%>,
					 'status':Status
			 }
			//alert(JSON.stringify(params));
				    var url = "addCluster";
				    SendJsonData(url,params);
					$j('#btnAddCity').attr("disabled", false);
					//$j('#cityCode').attr('readonly', true);
					ResetForm();
		}
		
		function updateClusterStatus(){
			var params = {
				
				'clusterId':$('#clusterIdValue').val(),			 
				 'status':Status
		 
			} 
		
		//alert(JSON.stringify(params));
			    var url = "updateClusterStatus";
		        SendJsonData(url,params);
		 
			}
		
		function Reset(){
			
			document.getElementById('searchClusterName').value = "";
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddCity').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			$j('#clusterName').attr('readonly', false);
			showAll();
		}
				
		function ResetForm()
		{	
		
			$j('#clusterName').val('');
			$j('#searchClusterName').val('');
			
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			GetAllCity('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddCity').show();
			$j('#cityCode').attr('readonly', false);
			
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllCity('FILTER');
			
		} 
		
		 function search()
		 {
		 	if(document.getElementById('searchClusterName').value == ""){
		  		alert("Please Enter Cluster Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllCity('FILTER');
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
                <div class="internal_Htext">Cluster Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                    <input type="hidden"  name="clusterIdValue" value="" id="clusterIdValue" />
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchBankForm"
												name="searchBankForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Cluster Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchClusterName" id="searchClusterName"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Cluster Name" onkeypress="return validateText('searchClusterName',100,'City Name')">

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
                                                <th id="th1" class ="inner_md_htext">Cluster Name</th>
                                                <th id="th4" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfCity">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addCityForm" name="addCityForm" method="">
                                                <div class="row">
                                                   <!--  <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" >City Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="cityCode" name="cityCode" placeholder="City Code" onkeypress=" return validateText('cityCode',7,'City Code');">
                                                            </div>
                                                        </div>
                                                    </div> -->
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Cluster Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="clusterName" name="clusterName" placeholder="Cluster Name">
                                                            </div>
                                                        </div>
                                                    </div>
                                                 <!--    <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">District<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="district" name="district" >
                                                                                                                           
                                                                </select>
														</div>
                                                      </div>                                                    
                                                 </div> -->
                                                 
                                              <!--    <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">MMU Operational<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" name="operational" id="operational" >
                                                                  <option value="">Select</option> 
                                                                  <option value="Y">Yes</option> 
                                                                  <option value="N">No</option>                                                         
                                                                </select>
														</div>
                                                      </div>                                                    
                                                 </div> -->
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
												
														<button type="button" id="btnAddCity"
															class="btn  btn-primary " onclick="addCluster();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateCluster();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateClusterStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateClusterStatus();">Deactivate</button>
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

