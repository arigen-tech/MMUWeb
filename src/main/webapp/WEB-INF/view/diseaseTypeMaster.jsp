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
		$j('#diseaseTypeCode').attr('readonly', false);		
		GetAllDiseaseType('ALL');			
			});
			
	function GetAllDiseaseType(MODE){
		 
		var diseaseTypeName=$("#searchDiseaseType").val();	
		
		 
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "diseaseTypeName":""};			
			}else{
			var data = {"PN":nPageNo, "diseaseTypeName":diseaseTypeName};
			} 
		var url = "getAllDiseaseType";		
		var bClickable = true;
		GetJsonData('tblListOfDiseaseType',data,url,bClickable);	 
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
					
				htmlTable = htmlTable+"<tr id='"+dataList[i].diseaseTypeId+"' >";			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].diseaseTypeCode+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].diseaseTypeName+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfDiseaseType").html(htmlTable); 	
		
	}

	var disTypeId;
	var diseaseTypeCode;
	var diseaseTypeName;
	var Status;
	function executeClickEvent(diseaseTypeId,data)
	{
		
		for(j=0;j<data.data.length;j++){
			if(diseaseTypeId == data.data[j].diseaseTypeId){
				disTypeId = data.data[j].diseaseTypeId;			
				diseaseTypeCode = data.data[j].diseaseTypeCode;			
				diseaseTypeName = data.data[j].diseaseTypeName;
				Status = data.data[j].status;
				
			}
		}
		rowClick(disTypeId,diseaseTypeCode,diseaseTypeName,Status);
	}
	
	function rowClick(disTypeId,diseaseTypeCode,diseaseTypeName,Status){	
			
		document.getElementById("diseaseTypeCode").value = diseaseTypeCode;
		document.getElementById("diseaseTypeName").value = diseaseTypeName;
		
				 
		if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddDiseaseType').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddDiseaseType').hide();
		}

				
		$j('#diseaseTypeCode').attr('readonly', true);
		
	}


		function addDiseaseType(){
			
			if(document.getElementById('diseaseTypeCode').value == null || document.getElementById('diseaseTypeCode').value == ""){
				alert("Please Enter Disease Type Code");
				return false;
			}
			if(document.getElementById('diseaseTypeName').value == null || document.getElementById('diseaseTypeName').value ==""){
				alert("Please Enter Disease Type Name");
				return false;
			}
			$('#btnAddDiseaseType').prop("disabled",true);
			
			var params = {		
					
					 'diseaseTypeCode':jQuery('#diseaseTypeCode').val(),
					 'diseaseTypeName':jQuery('#diseaseTypeName').val(),
					 'userId': <%= userId%>
			 }
			
			//alert(JSON.stringify(params));
			    var url = "addDiseaseType";
			    SendJsonData(url,params);
			
			    
		}
		
		function updateDiseaseType(){	
			if(document.getElementById('diseaseTypeCode').value == null || document.getElementById('diseaseTypeCode').value == ""){
				alert("Please Enter Disease Type Code");
				return false;
			}
			if(document.getElementById('diseaseTypeName').value == null || document.getElementById('diseaseTypeName').value ==""){
				alert("Please Enter Disease Type Name");
				return false;
			}	

			var params = {
					 'diseaseTypeId':disTypeId,
					 'diseaseTypeCode':jQuery('#diseaseTypeCode').val(),
					 'diseaseTypeName':jQuery('#diseaseTypeName').val(),
					 'userId': <%= userId%>
					
			 } 
			//alert(JSON.stringify(params));
				    var url = "updateDiseaseType";
				    SendJsonData(url,params);
					$j('#btnAddDiseaseType').attr("disabled", false);
					$j('#diseaseCode').attr('readonly', true);
					ResetForm();
		}
		
		function updateDiseaseTypeStatus(){
			if(document.getElementById('diseaseTypeCode').value == null || document.getElementById('diseaseTypeCode').value == ""){
				alert("Please Enter Disease Type Code");
				return false;
			}
			if(document.getElementById('diseaseTypeName').value == null || document.getElementById('diseaseTypeName').value ==""){
				alert("Please Enter Disease Type Name");
				return false;
			}
			
			var params = {
					
					'diseaseTypeId':disTypeId,			 
					 'status':Status
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateDiseaseTypeStatus";
			        SendJsonData(url,params);
			 
		     
		}
		
		function Reset(){
			
			document.getElementById('searchDiseaseType').value = "";
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddDiseaseType').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			$j('#diseaseTypeCode').attr('readonly', false);
			showAll();
		}
				
		function ResetForm()
		{	
			$j('#diseaseTypeCode').val('');
			$j('#diseaseTypeName').val('');
			$j('#searchDiseaseType').val('');
			
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			GetAllDiseaseType('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddDiseaseType').show();
			$j('#diseaseTypeCode').attr('readonly', false);
			
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllDiseaseType('FILTER');
			
		} 
		
		 function search()
		 {
		 	if(document.getElementById('searchDiseaseType').value == ""){
		  		alert("Please Enter Disease Type Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllDiseaseType('FILTER');
		 }
		 
		 function generateReport()
		 {
			 
			 var url="${pageContext.request.contextPath}/report/generateDiseaseTypeReport";
			 openPdfModel(url)
			
		 	/* document.searchDiseaseForm.action="${pageContext.request.contextPath}/report/generateDiseaseReport";
		 	document.searchDiseaseForm.method="POST";
		 	document.searchDiseaseForm.submit();  */
		 	
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
                <div class="internal_Htext">Disease Type Master</div>
                    
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
													<label class="col-3 col-form-label">Disease Type Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchDiseaseType" id="searchDiseaseType"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Disease Type Name">

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
                                                <th id="th2" class ="inner_md_htext">Disease Type Code</th>
                                                <th id="th3" class ="inner_md_htext">Disease Type Name</th>
                                                <th id="th4" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfDiseaseType">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addSampleForm" name="addSampleContainerForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" >Disease Type Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="diseaseTypeCode" name="diseaseTypeCode" placeholder="diseaseTypeCode" onkeypress=" return validateText('diseaseTypeCode',7,'Disease Type Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Disease Type Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="diseaseTypeName" name="diseaseTypeName" placeholder="Disease Type Name" onkeypress="return validateText('diseaseTypeName',30,'Disease Type Name')">
                                                            </div>  
														</div>
                                                      </div>                                                  
                                                         
                                                    
                                                 </div>
                                                    
                                                    
                                                    <div class="col-md-4">
												        <input type="hidden"  id="rowId" name="rowId">																													
									                </div>
                                                    
                                                </div>
                                            </form>
                                        </div>

                                  
									
         							<br>
									<div class="row">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
												
														<button type="button" id="btnAddDiseaseType"
															class="btn  btn-primary " onclick="addDiseaseType();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateDiseaseType();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateDiseaseTypeStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateDiseaseTypeStatus();">Deactivate</button>
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