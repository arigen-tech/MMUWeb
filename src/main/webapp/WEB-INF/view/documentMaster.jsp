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
		$j('#documentCode').attr('readonly', false);		
		GetAllDocument('ALL');			
			});
			
	function GetAllDocument(MODE){
		 
		var documentName=$("#searchDocument").val();		 
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "documentName":""};			
			}else{
			var data = {"PN":nPageNo, "documentName":documentName};
			} 
		var url = "getAllDocument";		
		var bClickable = true;
		GetJsonData('tblListOfDocument',data,url,bClickable);	 
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
					
				htmlTable = htmlTable+"<tr id='"+dataList[i].documentId+"' >";			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].documentCode+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].documentName+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfDocument").html(htmlTable); 	
		
	}

	var docId;
	var documentCode;
	var documentName;
	var Status;
	
	function executeClickEvent(documentId,data)
	{
		
		for(j=0;j<data.data.length;j++){
			if(documentId == data.data[j].documentId){
				docId = data.data[j].documentId;			
				documentCode = data.data[j].documentCode;			
				documentName = data.data[j].documentName;
				Status = data.data[j].status;
				
				
			}
		}
		rowClick(docId,documentCode,documentName,Status);
	}
	
	function rowClick(docId,documentCode,documentName,Status){	
			
		document.getElementById("documentCode").value = documentCode;
		document.getElementById("documentName").value = documentName;
		
				 
		if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddDocument').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddDocument').hide();
		}
		
		
		$j('#documentCode').attr('readonly', true);
		
	}


		function addDocument(){
			
			if(document.getElementById('documentCode').value == null || document.getElementById('documentCode').value == ""){
				alert("Please Enter Document Code");
				return false;
			}
			if(document.getElementById('documentName').value == null || document.getElementById('documentName').value ==""){
				alert("Please Enter Document Name");
				return false;
			}
			$('#btnAddDocument').prop("disabled",true);
			
			var params = {		
					
					 'documentCode':jQuery('#documentCode').val(),
					 'documentName':jQuery('#documentName').val(),
					 'userId': <%= userId%>
			 }
			
			//alert(JSON.stringify(params));
			    var url = "addDocument";
			    SendJsonData(url,params);
			
			    
		}
		
		function updateDocument(){	
			if(document.getElementById('documentCode').value == null || document.getElementById('documentCode').value == ""){
				alert("Please Enter Document Code");
				return false;
			}
			if(document.getElementById('documentName').value == null || document.getElementById('documentName').value ==""){
				alert("Please Enter Document Name");
				return false;
			}	
			
			var params = {
					 'documentId':docId,
					 'documentCode':jQuery('#documentCode').val(),
					 'documentName':jQuery('#documentName').val(),
					 'userId': <%= userId%>
					
			 } 
			//alert(JSON.stringify(params));
				    var url = "updateDocument";
				    SendJsonData(url,params);
					$j('#btnAddDocument').attr("disabled", false);
					$j('#documentCode').attr('readonly', true);
					ResetFrom();
		}
		
		function updateDocumentStatus(){
			if(document.getElementById('documentCode').value == null || document.getElementById('documentCode').value == ""){
				alert("Please Enter Document Code");
				return false;
			}
			if(document.getElementById('documentName').value == null || document.getElementById('documentName').value ==""){
				alert("Please Enter Document Name");
				return false;
			}
			
			var params = {
					
					'documentId':docId,			 
					 'status':Status
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateDocumentStatus";
			        SendJsonData(url,params);
			 
		     
		}
		
		function Reset(){
			
			document.getElementById('searchDocument').value = "";
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddDocument').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			$j('#documentCode').attr('readonly', false);
			showAll();
		}
				
		function ResetForm()
		{	
			$j('#documentCode').val('');
			$j('#documentName').val('');
			$j('#searchDocument').val('');
			
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			GetAllDocument('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddDocument').show();
			$j('#documentCode').attr('readonly', false);
			
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllDocument('FILTER');
			
		} 
		
		 function search()
		 {
		 	if(document.getElementById('searchDocument').value == ""){
		  		alert("Please Enter Document Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllDocument('FILTER');
		 }
		 
		 function generateReport()
		 {
			 var url="${pageContext.request.contextPath}/report/generateDocumentReport";
			 openPdfModel(url);

		 	/* document.searchDocumentForm.action="${pageContext.request.contextPath}/report/generateDocumentReport";
		 	document.searchDocumentForm.method="POST";
		 	document.searchDocumentForm.submit();  */
		 	
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
                <div class="internal_Htext">Document Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchDocumentForm"
												name="searchDocumentForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Document Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchDocument" id="searchDocument"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Document Name" onkeypress="return validateText('searchDocument',100,'Document Name')">

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
                                                <th id="th2" class ="inner_md_htext">Document Code</th>
                                                <th id="th3" class ="inner_md_htext">Document Name</th>
                                                <th id="th4" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfDocument">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addSampleForm" name="addSampleContainerForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" >Document Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="documentCode" name="documentCode" placeholder="Document Code" onkeypress=" return validateText('documentCode',20,'Document Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Document Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="documentName" name="documentName" placeholder="Document Name" onkeypress="return validateText('documentName',100,'Document Name')">
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
												
														<button type="button" id="btnAddDocument"
															class="btn  btn-primary " onclick="addDocument();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateDocument();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateDocumentStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateDocumentStatus();">Deactivate</button>
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
