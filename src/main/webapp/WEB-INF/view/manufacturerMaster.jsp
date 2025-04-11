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
			
				if ($('#supplierSelect option:selected').val() != null) {
						 $('#supplierSelect option:selected').remove().appendTo('#appendSupplierSelect');
						 $("#supplierSelect").attr('selectedIndex','-1').find("option:selected").removeAttr("selected");
			         	 $("#supplierSelect").attr('selectedIndex', '-1').find("option:selected").removeAttr("selected");      
					 } 
			});
		$('#removeKey').click(function() {
			       if ($('#appendSupplierSelect option:selected').val() != null) {
			             	$('#appendSupplierSelect option:selected').remove().appendTo('#supplierSelect');
			           	 	$("#appendSupplierSelect").attr('selectedIndex',  '-1').find("option:selected").removeAttr("selected");
			          		$("#appendSupplierSelect").attr('selectedIndex', '-1').find("option:selected").removeAttr("selected");       
						}
			});  

	 });
	 

	$j(document).ready(function()
			{
		$j("#btnActive").hide();
		$j("#btnInActive").hide();		
		$j('#updateBtn').hide();	  
		GetAllManufacturer('ALL');	
		GetSupplierList();
		});
			
	function GetAllManufacturer(MODE){
		 
		var manufacturerName=$("#searchManufacturerName").val();		 
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "manufacturerName":""};			
			}else{
			var data = {"PN":nPageNo, "manufacturerName":manufacturerName};
			} 
		var url = "getAllManufacturer";		
		var bClickable = true;
		GetJsonData('tblListOfManufacturer',data,url,bClickable);	 
	}
	
	function GetSupplierList(){
			jQuery.ajax({
			 	crossOrigin: true,
			    method: "POST",			    
			    crossDomain:true,
			    url: "getAllSupplierType",
			    data: JSON.stringify({"PN" : "0"}),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	var combo = "<option value=\"\" disabled='disabled'>Select</option>" ;
			    	
			    	for(var i=0;i<result.data.length;i++){
			    		combo += '<option value='+result.data[i].supplierTypeId+'>' +result.data[i].supplierTypeName+ '</option>';
			    		
			    	}
			    	
			    	jQuery('#supplierSelect').append(combo);
			    	
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
					
				htmlTable = htmlTable+"<tr id='"+dataList[i].manufacturerId+"' >";			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].manufacturerName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].supplierTypeName+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
			   
			}			
		
		
		$j("#tblListOfManufacturer").html(htmlTable); 	
		
	}
    var manufacturerId;
    var manufacturerid='';
    var manufacturerName;
    var supplierTypeId;
	var supplierTypeName;
	var Status;
	
	function executeClickEvent(manufacturerId,data)
	{
		
		for(j=0;j<data.data.length;j++){
			if(manufacturerId == data.data[j].manufacturerId){
				manufacturerId = data.data[j].manufacturerId;
				manufacturerName = data.data[j].manufacturerName;
				supplierTypeId = data.data[j].supplierTypeId;				
				supplierTypeName = data.data[j].supplierTypeName;
				Status = data.data[j].status;
				
				
			}
		}
		rowClick(manufacturerId,manufacturerName,supplierTypeId,supplierTypeName,Status);
	}
	
	function rowClick(manufacturerId,manufacturerName,supplierTypeId,supplierTypeName,Status){	
		manufacturerid=manufacturerId;
		jQuery('#appendSupplierSelect').empty();
		document.getElementById("manufacturerName").value = manufacturerName;
		var combo='';
		  combo += '<option value='+supplierTypeId+'>' +supplierTypeName+ '</option>';
		  jQuery('#appendSupplierSelect').append(combo);
		
		  if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnManufacturer').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnManufacturer').hide();
		}
		
	}


		function addManufacturer(){
			
			if(document.getElementById('manufacturerName').value == null || document.getElementById('manufacturerName').value == ""){
				alert("Please Enter Manufacturer Name");
				return false;
			}
			if(document.getElementById('appendSupplierSelect').value == null || document.getElementById('appendSupplierSelect').value ==""){
				alert("Please Select Vendor Type");
				return false;
			}
			
			$j('#btnManufacturer').prop("disabled",true);
			var params = {		
					
					 'manufacturerName':jQuery('#manufacturerName').val(),
					 'supplierTypeId':jQuery('#appendSupplierSelect').val(),
					 'userId': <%= userId%>
			 }
			
			//alert(JSON.stringify(params));
			$j('#btnManufacturer').attr("disabled", false);
			    var url = "addManufacturer";
			    SendJsonData(url,params);			
			    
		}
		
		function updateManufacturer(){	
			if(document.getElementById('manufacturerName').value == null || document.getElementById('manufacturerName').value == ""){
				alert("Please Enter Manufacturer Name");
				return false;
			}
			if(document.getElementById('appendSupplierSelect').value == null || document.getElementById('appendSupplierSelect').value ==""){
				alert("Please Select Vendor Type");
				return false;
			}
			
			
			var params = {	
					'manufacturerId':manufacturerid,	
					'manufacturerName':jQuery('#manufacturerName').val(),
					 'supplierTypeId':jQuery('#appendSupplierSelect').val(),
					 'userId': <%= userId%>
			 }
		
			       var url = "updateManufacturer";
				    SendJsonData(url,params);
					ResetForm();
		}
		
		function updateManufacturerStatus(){
						
			var params = {
					
					'manufacturerId':manufacturerid,			 
					 'status':Status
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateManufacturerStatus";
			        SendJsonData(url,params);
			 
		     
		}
		
		function Reset(){
			
			document.getElementById('searchManufacturerName').value = "";
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnManufacturer').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			showAll();
		}
				
		function ResetForm()
		{	
			$j('#searchManufacturerName').val('');
			$j('#manufacturerName').val('');
			$j('#appendSupplierSelect').empty();
			$j('#supplierSelect').empty();			
			GetSupplierList();
			
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			GetAllManufacturer('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnManufacturer').show();
			
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllManufacturer('FILTER');
			
		} 
		
		 function search()
		 {
		 	if(document.getElementById('searchManufacturerName').value == ""){
		  		alert("Please Enter Manufacturer Name");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllManufacturer('FILTER');
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
                <div class="internal_Htext">Manufacturer Master</div>
                    
                    <!-- end row -->
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       
                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchManufacturerForm"
												name="searchMfrForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Manufacturer Name<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchManufacturerName" id="searchManufacturerName"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Manufacturer Name" onkeypress="return validateText('searchManufacturerName',50,'Manufacturer Name')">

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
                                                <th id="th1" class ="inner_md_htext">Manufacturer Name</th>
                                                <th id="th2" class ="inner_md_htext">Vendor Type</th>
                                                <th id="th3" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfManufacturer">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                      <form id="DeptMappingForm" name="DeptMappingForm" method="">
                                      
                                       <div class="w-100 m-t-10">
                                             <div class="form-group row">
                                             <div class="col-sm-4">
                                                 <label for="Manufacturer" class="col-form-label inner_md_htext">Manufacturer Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                 </div>
                                                 <div class="col-sm-5">
                                                     <input type="text" class="form-control" id="manufacturerName" name="manufacturerName" placeholder="Manufacturer Name" onkeypress="return validateText('manufacturerName',120,'Manufacturer Name')">
                                                 </div>
                                             </div>
                                         </div>
                                       <div class="row">
                                         <div class="w-100 m-t-10"></div>      
                                        <div class="col-sm-4 col-md-4 ">
                                        <label>Vendor Type<span class="mandate"><sup>&#9733;</sup></span></label>						             	
						             	<select multiple class="form-control height110" id="supplierSelect" name="supplierSelect">
		            			            
				                   		 </select>
				                   	</div>
                                     <div class="col-sm-1 col-md-1 text-center selectorImgDiv"> 									
									    <div class="span2"> <span id="addkey" class="cursor-pointer"><img alt="" src="${pageContext.request.contextPath}/resources/images/rightarrow.jpg" width="30px"> </span></div>
										<div class="span2"> <span id="removeKey" class="cursor-pointer"><img alt="" src="${pageContext.request.contextPath}/resources/images/leftarrow.jpg" width="30px"> </span></div> 
									</div> 
									
									<div class="col-sm-4 col-md-4 ">
									   	<label>&nbsp;</label>					             	
						             	<select multiple class="form-control height110" id="appendSupplierSelect" name="appendSupplierSelect">
		            			            
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
												
														<button type="button" id="btnManufacturer"
															class="btn  btn-primary " onclick="addManufacturer();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateManufacturer();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateManufacturerStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateManufacturerStatus();">Deactivate</button>
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

