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
		//$j('#mmuCode').attr('readonly', false);		
		GetAllUpssManu('ALL');         
		getMasPhase();
		GetDistrictList();
			
			});
			
	function GetAllUpssManu(MODE){
		 
		//var cityName=document.getElementById('citySearch').value	
		var mmuSearchName=document.getElementById('mmuSearch').value
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "mmuSearch":"","masterPage":"Y"};			
			}else{
			var data = {"PN":nPageNo, "mmuSearch":mmuSearchName,"masterPage":"Y"};
			} 
		var url = "getAllUpssPhaseMapping";		
		var bClickable = true;
		GetJsonData('tblListOfMMU',data,url,bClickable);	 
	}

	function GetDistrictList(){
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "getAllDistrict",
		    data: JSON.stringify({"PN" : "0","upssFlag":"Y"}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	//var combo = "<option value="0">Select</option>" ;
		    	var combo = '<option value=""><strong>Select</strong></option>';
		    	for(var i=0;i<result.data.length;i++){
		    		combo += '<option value='+result.data[i].districtId+'>' +result.data[i].districtName+ '</option>';
		    		
		    	}
		    	
		    	jQuery('#district').append(combo);
		    	jQuery('#mmuSearch').append(combo);
		    	
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
					
			 	htmlTable = htmlTable+"<tr id='"+dataList[i].upssPhaseId+"' >";			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].districtName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].phaseName+"</td>";
				/* htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].mmuCity+"</td>"; */
				 
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='3'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfMMU").html(htmlTable); 	
		
	}

	var upssPhaseIdVal;
	var Status;
	var upssPhaseId=0;
 	var districtId=0;
 	var phaseId=0;
	function executeClickEvent(upssPhaseId,data)
	{
		for(j=0;j<data.data.length;j++){
			if(upssPhaseId == data.data[j].upssPhaseId){
				upssPhaseId= data.data[j].upssPhaseId;
				phaseId= data.data[j].phaseId;			
				districtId = data.data[j].districtId;	
			 	Status = data.data[j].status;
			 }
			
		}
		rowClick(upssPhaseId,phaseId,districtId,Status);
	}
	
	function rowClick(upssPhaseId,phaseId,districtId,Status){
		
	 
		upssPhaseIdVal=upssPhaseId;
		
		if(districtId!=null && districtId!="")
		   document.getElementById("district").value = districtId;	
		else
			document.getElementById("district").value ="0";
		
	
		if(phaseId!=null && phaseId!="")
			   document.getElementById("masPhase").value = phaseId;	
			else
				document.getElementById("masPhase").value ="0";
		
		
		if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddMMU').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddMMU').hide();
		}

		//$j('#mmuCode').attr('readonly', true);
		
	}


		function addUpssPhaseMapping(){
			
  
			if(document.getElementById('district').value == null || document.getElementById('district').value ==""){
				alert("Please Select UPSS Name");
				return false;
			}

			if(document.getElementById('masPhase').value == null || document.getElementById('masPhase').value ==""){
				alert("Please Select Phase");
				return false;
			}
			$j('#btnAddMMU').prop("disabled",true);
			
			var params = {		
					
					 'phaseId':jQuery('#masPhase').val(),
					  'userId': <%= userId%>,
					  'districtId':jQuery('#district').val()
			 }
			
			//alert(JSON.stringify(params));
			    var url = "addUpssPhaseMapping";
			    SendJsonData(url,params);
			    Reset();
						    
		}
		
		function updateUpssManu(){	

			if(document.getElementById('district').value == null || document.getElementById('district').value ==""){
				alert("Please Select UPSS Name");
				return false;
			}

			if(document.getElementById('masPhase').value == null || document.getElementById('masPhase').value ==""){
				alert("Please Select Phase");
				return false;
			}
			$j('#btnAddMMU').prop("disabled",true);
			
			var params = {		
					 'upssPhaseId':upssPhaseIdVal, 
			 		 'userId': <%= userId%>,
					 'status' :Status, 
                     'phaseId':jQuery('#masPhase').val(),
                     'districtId':jQuery('#district').val()
			 }
			  // alert(JSON.stringify(params));
				    var url = "updateUpssPhase";
				    SendJsonData(url,params);
					$j('#btnAddMMU').attr("disabled", false);
					$j('#mmuCode').attr('readonly', true);
					Reset();
		}
		
		function updateUpssManuStatus(){
			
			var params = {
					
					'upssPhaseId':upssPhaseIdVal, 	 
					 'status':Status
					 
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateUpssPhaseStatus";
			        SendJsonData(url,params);
			        Reset();
			        //showAll();
		     
		}
		
		function Reset(){
			
			document.getElementById('district').value = "";
			document.getElementById('mmuSearch').value = "";
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddMMU').show();
			document.getElementById("messageId").innerHTML = "";
			$j("#messageId").css("color", "black");
			$j('#regNo').attr('readonly', false);
			showAll();
		}
				
		function ResetForm()
		{	
			$j('#regNo').val('');
			$j('#mmuName').val('');
			$j('#district').val('');
			$j('#mmuSearch').val('');
			
			$j('#mmuCode').val('');
			$j('#vendorName').val('');
			$j('#operationalDate').val('');
			$j('#mmuType').val('');
			$j('#officeId').val('');
            $j('#pollNo').val('');
            $j('#chassisNo').val('');
			
		}
		
		function showAll()
		{
			
			ResetForm();
			nPageNo = 1;	
			GetAllUpssManu('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddMMU').show();
			$j('#mmuCode').attr('readonly', false);
			$j('#regNo').attr('readonly', false);
			//$j('#district').val('0'); 
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllUpssManu('FILTER');
			
		} 
		
		 function search()
		 {
		  	 if(document.getElementById('mmuSearch').value == ""){
			  		alert("Please Enter UPSS Name");
			  		return false;
			  	}
		 	nPageNo=1;
		 	GetAllUpssManu('FILTER');
		 }
		 
		 function generateReport()
		 {
			var url="${pageContext.request.contextPath}/report/generateDiseaseReport";
			 openPdfModel(url);
		 	/* document.searchDiseaseForm.action="${pageContext.request.contextPath}/report/generateDiseaseReport";
		 	document.searchDiseaseForm.method="POST";
		 	document.searchDiseaseForm.submit(); */ 
		 	
		 }

  		 function getMasPhase(){
				jQuery.ajax({
				 	crossOrigin: true,
				    method: "POST",			    
				    crossDomain:true,
				    url: "getMasPhase",
				    data: JSON.stringify({"PN" : "0"}),
				    contentType: "application/json; charset=utf-8",
				    dataType: "json",
				    success: function(result){
				    	var combo = "<option value=\"\">Select</option>" ;
				    	
				    	for(var i=0;i<result.data.length;i++){
				    		combo += '<option value='+result.data[i].phaseId+'>' +result.data[i].phaseName+ '</option>';
				    		
				    	}
				    	jQuery('#masPhase').append(combo);
				    }
				    
				});
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
                <div class="internal_Htext">UPSS Phase Mapping</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchDiseaseForm"
												name="searchDiseaseForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">UPSS<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">
                                                    <select class="form-control" id="mmuSearch" name="mmuSearch">
                                                                
                                                                </select>
														 
														 
														<!-- <input class="form-control" type="text" name="mmuSearch" id="mmuSearch"/>  -->
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
                                                <th id="th2" class ="inner_md_htext">UPSS</th>
                                                <th id="th3" class ="inner_md_htext">Phase</th>
                                                 <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfMMU">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addMMForm" name="addMMForm" method="">
                                                <div class="row">
                                                   
                                                        
                                                      
                                                       
                                                     
                                                       <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">UPSS<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="district" name="district" >
                                                                   <!-- <option value="0">Select</option>   -->                                                       
                                                                </select>
														</div>
                                                      </div>                                                    
                                                 </div>
                                                 <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Phase<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="masPhase" name="masPhase">
                                                                                                                                                                                            
                                                                </select>
														</div>
														</div>
                                                      </div>
                                                 
                                                    
                                                   <!--  <div class="col-md-4">
												        <input type="hidden"  id="rowId" name="rowId">																													
									                </div>
                                                    --> 
                                                </div>
                                            </form>
                                        </div>
								<div class="col-md-12">
											
											<div class="btn-right-all">
												
														<button type="button" id="btnAddMMU"
															class="btn  btn-primary " onclick="addUpssPhaseMapping();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateUpssManu();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateUpssManuStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateUpssManuStatus();">Deactivate</button>
														<button type="button" class="btn btn-danger "
															onclick="Reset();">Reset</button>
													
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