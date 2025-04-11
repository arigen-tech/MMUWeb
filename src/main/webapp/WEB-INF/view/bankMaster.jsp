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
		$j('#bankCode').attr('readonly', false);		
		GetAllBank('ALL');			
			});
			
	function GetAllBank(MODE){
		 
		var bankName=$("#searchBankName").val();		 
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "bankName":""};			
			}else{
			var data = {"PN":nPageNo, "bankName":bankName};
			} 
		var url = "getAllBank";		
		var bClickable = true;
		GetJsonData('tblListOfBank',data,url,bClickable);	 
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
					
				htmlTable = htmlTable+"<tr id='"+dataList[i].bankId+"' >";			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].bankCode+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].bankName+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfBank").html(htmlTable); 	
		
	}

	var bnkId;
	var bankCode;
	var bankName;
	var Status;
	
	function executeClickEvent(bankId,data)
	{
		
		for(j=0;j<data.data.length;j++){
			if(bankId == data.data[j].bankId){
				bnkId = data.data[j].bankId;			
				bankCode = data.data[j].bankCode;			
				bankName = data.data[j].bankName;
				Status = data.data[j].status;
				
				
			}
		}
		rowClick(bnkId,bankCode,bankName,Status);
	}
	
	function rowClick(bnkId,bankCode,bankName,Status){	
			
		document.getElementById("bankCode").value = bankCode;
		document.getElementById("bankName").value = bankName;
		
				 
		if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnAddBank').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddBank').hide();
		}
		
		
		$j('#bankCode').attr('readonly', true);
		
	}


		function addBank(){
			
			if(document.getElementById('bankCode').value == null || document.getElementById('bankCode').value == ""){
				alert("Please Enter Bank Code");
				return false;
			}
			if(document.getElementById('bankName').value == null || document.getElementById('bankName').value ==""){
				alert("Please Enter Bank Name");
				return false;
			}
			
			var params = {		
					
					 'bankCode':jQuery('#bankCode').val(),
					 'bankName':jQuery('#bankName').val(),
					 'userId': <%= userId%>
			 }
			
			//alert(JSON.stringify(params));
			    var url = "addBank";
			    SendJsonData(url,params);
			
			    
		}
		
		function updateBankDetails(){	
			if(document.getElementById('bankCode').value == null || document.getElementById('bankCode').value == ""){
				alert("Please Enter Bank Code");
				return false;
			}
			if(document.getElementById('bankName').value == null || document.getElementById('bankName').value ==""){
				alert("Please Enter Bank Name");
				return false;
			}	
			
			var params = {
					 'bankId':bnkId,
					 'bankCode':jQuery('#bankCode').val(),
					 'bankName':jQuery('#bankName').val(),
					 'userId': <%= userId%>
					
			 } 
			//alert(JSON.stringify(params));
				    var url = "updateBankDetails";
				    SendJsonData(url,params);
					$j('#btnAddBank').attr("disabled", false);
					$j('#bankCode').attr('readonly', true);
					ResetFrom();
		}
		
		function updateBankStatus(){
			if(document.getElementById('bankCode').value == null || document.getElementById('bankCode').value == ""){
				alert("Please Enter Bank Code");
				return false;
			}
			if(document.getElementById('bankName').value == null || document.getElementById('bankName').value ==""){
				alert("Please Enter Bank Name");
				return false;
			}
			
			var params = {
					
					'bankId':bnkId,			 
					 'status':Status
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateBankStatus";
			        SendJsonData(url,params);
			 
		     
		}
		
		function Reset(){
			
			document.getElementById('searchBankName').value = "";
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddBank').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			$j('#bankCode').attr('readonly', false);
			showAll();
		}
				
		function ResetForm()
		{	
			$j('#bankCode').val('');
			$j('#bankName').val('');
			$j('#searchBankName').val('');
			
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			GetAllBank('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnAddBank').show();
			$j('#bankCode').attr('readonly', false);
			
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllBank('FILTER');
			
		} 
		
		 function search()
		 {
		 	if(document.getElementById('searchBankName').value == ""){
		  		alert("Please Enter Bank Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllBank('FILTER');
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
                <div class="internal_Htext">Bank Master</div>
                    
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
													<label class="col-3 col-form-label">Bank Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchBankName" id="searchBankName"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Bank Name" onkeypress="return validateText('searchBankName',100,'Bank Name')">

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
                                                <th id="th2" class ="inner_md_htext">Bank Code</th>
                                                <th id="th3" class ="inner_md_htext">Bank Name</th>
                                                <th id="th4" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfBank">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addBankForm" name="addBankForm" method="">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Collection Code" class=" col-form-label inner_md_htext" >Bank Code<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="bankCode" name="bankCode" placeholder="Bank Code" onkeypress=" return validateText('bankCode',8,'Bank Code');">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Bank Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="bankName" name="bankName" placeholder="Bank Name" onkeypress="return validateText('bankName',100,'Bank Name')">
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
												
														<button type="button" id="btnAddBank"
															class="btn  btn-primary " onclick="addBank();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateBankDetails();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateBankStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateBankStatus();">Deactivate</button>
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

