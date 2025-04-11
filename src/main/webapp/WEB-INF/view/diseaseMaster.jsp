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
		$j('#diseaseCode').attr('readonly', false);		
		GetAllDisease('ALL');	
		GetDiseaseTypeList();		
			});
			
	function GetAllDisease(MODE){
		 
		var diseaseName=$("#searchDisease").val();	
		
		
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "diseaseName":""};			
			}else{
			var data = {"PN":nPageNo, "diseaseName":diseaseName};
			} 
		var url = "getAllDisease";		
		var bClickable = true;
		GetJsonData('tblListOfDisease',data,url,bClickable);	 
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
					
				htmlTable = htmlTable+"<tr id='"+dataList[i].diseaseId+"' >";			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].diseaseCode+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].diseaseName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].diseaseType+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfDisease").html(htmlTable); 	
		
	}

	var disId;
	var diseaseCode;
	var diseaseName;
	var Status;
	var diseaseTypeId;
	function executeClickEvent(diseaseId,data)
	{
		
		for(j=0;j<data.data.length;j++){
			if(diseaseId == data.data[j].diseaseId){
				disId = data.data[j].diseaseId;			
				diseaseCode = data.data[j].diseaseCode;			
				diseaseName = data.data[j].diseaseName;
				diseaseTypeId = data.data[j].diseaseTypeId;
				Status = data.data[j].status;
				
			}
		}
		rowClick(disId,diseaseCode,diseaseName,Status,diseaseTypeId);
	}
	
	function rowClick(disId,diseaseCode,diseaseName,Status,diseaseTypeId){	
			
		document.getElementById("diseaseCode").value = diseaseCode;
		document.getElementById("diseaseName").value = diseaseName;
		document.getElementById("diseaseType").value = diseaseTypeId;
				 
		if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddDisease').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddDisease').hide();
		}

		$j('#diseaseCode').attr('readonly', true);
		
	}


		function addDisease(){
			
			if(document.getElementById('diseaseCode').value == null || document.getElementById('diseaseCode').value == ""){
				alert("Please Enter Disease Code");
				return false;
			}
			if(document.getElementById('diseaseName').value == null || document.getElementById('diseaseName').value ==""){
				alert("Please Enter Disease Name");
				return false;
			}
			if(document.getElementById('diseaseType').value == null || document.getElementById('diseaseType').value ==""){
				alert("Please Select Disease Type");
				return false;
			}
			$('#btnAddDisease').prop("disabled",true);
			
			var params = {		
					
					 'diseaseCode':jQuery('#diseaseCode').val(),
					 'diseaseName':jQuery('#diseaseName').val(),
					 'userId': <%= userId%>,
					 'diseaseTypeId':jQuery('#diseaseType').val()
			 }
			
			//alert(JSON.stringify(params));
			    var url = "addDisease";
			    SendJsonData(url,params);
			
			    
		}
		
		function updateDisease(){	
			if(document.getElementById('diseaseCode').value == null || document.getElementById('diseaseCode').value == ""){
				alert("Please Enter Disease Code");
				return false;
			}
			if(document.getElementById('diseaseName').value == null || document.getElementById('diseaseName').value ==""){
				alert("Please Enter Disease Name");
				return false;
			}	
			if(document.getElementById('diseaseType').value == null || document.getElementById('diseaseType').value ==""){
				alert("Please Select Disease Type");
				return false;
			}
			var params = {
					 'diseaseId':disId,
					 'diseaseCode':jQuery('#diseaseCode').val(),
					 'diseaseName':jQuery('#diseaseName').val(),
					 'userId': <%= userId%>,
					 'diseaseTypeId':jQuery('#diseaseType').val()
			 } 
			//alert(JSON.stringify(params));
				    var url = "updateDisease";
				    SendJsonData(url,params);
					$j('#btnAddDisease').attr("disabled", false);
					$j('#diseaseCode').attr('readonly', true);
					ResetForm();
		}
		
		function updateDiseaseStatus(){
			if(document.getElementById('diseaseCode').value == null || document.getElementById('diseaseCode').value == ""){
				alert("Please Enter Disease Code");
				return false;
			}
			if(document.getElementById('diseaseName').value == null || document.getElementById('diseaseName').value ==""){
				alert("Please Enter Disease Name");
				return false;
			}
			
			var params = {
					
					'diseaseId':disId,			 
					 'status':Status
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateDiseaseStatus";
			        SendJsonData(url,params);
			 
		     
		}
		
		function Reset(){
			
			document.getElementById('searchDisease').value = "";
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddDisease').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			$j('#diseaseCode').attr('readonly', false);
			showAll();
		}
				
		function ResetForm()
		{	
			$j('#diseaseCode').val('');
			$j('#diseaseName').val('');
			$j('#searchDisease').val('');
			
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			GetAllDisease('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddDisease').show();
			$j('#diseaseCode').attr('readonly', false);
			
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllDisease('FILTER');
			
		} 
		
		 function search()
		 {
		 	if(document.getElementById('searchDisease').value == ""){
		  		alert("Please Enter Disease Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllDisease('FILTER');
		 }
		 
		 function generateReport()
		 {
			var url="${pageContext.request.contextPath}/report/generateDiseaseReport";
			 openPdfModel(url);
		 	/* document.searchDiseaseForm.action="${pageContext.request.contextPath}/report/generateDiseaseReport";
		 	document.searchDiseaseForm.method="POST";
		 	document.searchDiseaseForm.submit(); */ 
		 	
		 }


		 function GetDiseaseTypeList(){
				jQuery.ajax({
				 	crossOrigin: true,
				    method: "POST",			    
				    crossDomain:true,
				    url: "getAllDiseaseType",
				    data: JSON.stringify({"PN" : "0"}),
				    contentType: "application/json; charset=utf-8",
				    dataType: "json",
				    success: function(result){
				    	var combo = "<option value=\"\">Select</option>" ;
				    	
				    	for(var i=0;i<result.data.length;i++){
				    		combo += '<option value='+result.data[i].diseaseTypeId+'>' +result.data[i].diseaseTypeName+ '</option>';
				    		
				    	}
				    	jQuery('#diseaseType').append(combo);
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
                <div class="internal_Htext">Disease Master</div>
                    
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
													<label class="col-3 col-form-label">Disease Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchDisease" id="searchDisease"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Disease Name" onkeypress="return validateText('searchDisease',30,'Disease Name')">

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
                                                <th id="th2" class ="inner_md_htext">Disease Code</th>
                                                <th id="th3" class ="inner_md_htext">Disease Name</th>
                                                <th id="th4" class ="inner_md_htext">Disease Type</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfDisease">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addSampleForm" name="addSampleContainerForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" >Disease Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="diseaseCode" name="diseaseCode" placeholder="Disease Code" onkeypress=" return validateText('diseaseCode',7,'Disease Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Disease Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="diseaseName" name="diseaseName" placeholder="Disease Name" onkeypress="return validateText('diseaseName',30,'Disease Name')">
                                                            </div>  
														</div>
                                                      </div>                                                       
                                                     <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Disease Type<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="diseaseType" name="diseaseType"></select>
														</div>
                                                      </div>      
                                                    
                                                 </div>
                                                    
                                                    
                                                    <div class="col-md-4">
												        <input type="hidden"  id="rowId" name="rowId">																													
									                </div>
                                                    
                                                </div>
                                            </form>
                                        </div>
								<div class="col-md-12">
											
											<div class="btn-right-all">
												
														<button type="button" id="btnAddDisease"
															class="btn  btn-primary " onclick="addDisease();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateDisease();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateDiseaseStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateDiseaseStatus();">Deactivate</button>
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