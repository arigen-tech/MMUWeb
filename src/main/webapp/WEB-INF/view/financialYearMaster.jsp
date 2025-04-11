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
		$j('#headCode').attr('readonly', false);		
			GetAllFinancialYear('ALL');	
			//getOrderList();
			});
			
	function GetAllFinancialYear(MODE){
		 
		var searchFinancialYear=$("#searchFinancialYear").val();		 
		 if(MODE == 'ALL'){
				var data = {"PN":nPageNo, "searchFinancialYear":""};			
			}else{
			var data = {"PN":nPageNo, "searchFinancialYear":searchFinancialYear};
			} 
		var url = "getAllFinancialYear";		
		var bClickable = true;
		GetJsonData('tblListOfFinancialYear',data,url,bClickable);	 
	}
	  
	
	function makeTable(jsonData)
	{	
		var htmlTable = "";	
		var data = jsonData.count; 
		
		var pageSize = 5; 	
		var dataList = jsonData.data; 
		
		if(dataList!=undefined && dataList.length>0){
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
					
				htmlTable = htmlTable+"<tr id='"+dataList[i].financialId+"' >";
				 
		var financialYear=""
		if(dataList[i].financialYear!=null && dataList[i].financialYear!=undefined)
			financialYear=dataList[i].financialYear;
		else
			financialYear="";
			
				htmlTable = htmlTable +"<td style='width: 150px;'>"+financialYear+"</td>";
				  
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].startDate+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].endDate+"</td>";
				 
				htmlTable = htmlTable +"<td style='width: 100px;'>"+Status+"</td>"; 			
				htmlTable = htmlTable+"</tr>";
				
			}
		}
		else
			{
			htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
			   
			}		
		
		$j("#tblListOfFinancialYear").html(htmlTable); 	
		
	}
	 	var financialId;
		var financialid="";
 		var financialYear;
 		var startDate;
		var Status;
		var endDate;
		var markFinancialYear;		 
	function executeClickEvent(financialIdT,data)
	{
		
		for(j=0;j<data.data.length;j++){
			for(j=0;j<data.data.length;j++){
				if(financialIdT == data.data[j].financialId){
					financialid = data.data[j].financialId;
					 
					 if(data.data[j].financialYear!=null && data.data[j].financialYear!=undefined)
						 financialYear = data.data[j].financialYear;
					 else
						 financialYear="";
					 if(data.data[j].startDate!=null && data.data[j].startDate!=undefined)
						 startDate = data.data[j].startDate;
					 else
						 startDate="";
 					endDate= data.data[j].endDate; 
					Status = data.data[j].status;
					markFinancialYear=data.data[j].markFinancialYear;
				}
		}
		rowClick(financialid,financialYear,startDate, endDate,Status,markFinancialYear);
	}
	}
	
	function rowClick(financialid,financialYear,startDate, endDate,Status,markFinancialYear){	
		
		financialid=financialid;
		   
		if(financialYear!=null && financialYear!="" && financialYear!=undefined)
			document.getElementById("financialYearDate").value = financialYear;
		else
			document.getElementById("financialYearDate").value ="";
		if(startDate!=null && startDate!="")	
			document.getElementById("effectiveStartDate").value = startDate;
		else
			document.getElementById("effectiveStartDate").value = "";
		if(endDate!=null && endDate!="")	
			document.getElementById("effectiveEndDate").value = endDate;
		else
			document.getElementById("effectiveEndDate").value = "";
		
		if(markFinancialYear == 'y'){	
			 
			$('#markFinancialYear').prop('checked', true);
		}else{
			$('#markFinancialYear').prop('checked', false);
		}
		
		if(Status == 'Y' || Status == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').show();
			$j('#btnaddAuthority').hide();
		}
		if(Status == 'N' || Status == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnaddAuthority').hide();
		}
		 
		
		
		/* $j('#approvingAuthorityCode').attr('readonly', true); */
		
	}


		function addFinancialYear(){
			  
			if(document.getElementById('financialYearDate').value == null || document.getElementById('financialYearDate').value == ""  ){
				alert("Please Enter Financial Year");
				return false;
			}
			  if(document.getElementById('effectiveStartDate').value == null || document.getElementById('effectiveStartDate').value =="" ){
				alert("Please Enter Effective Start Date");
				return false;
			} 
			
			  if(document.getElementById('effectiveEndDate').value == null || document.getElementById('effectiveEndDate').value =="" ){
					alert("Please Enter Effective End Date");
					return false;
				} 
			  var countDate=getDateComapareValue(document.getElementById('effectiveStartDate').value,document.getElementById('effectiveEndDate').value);
			 	 if(countDate!=0){
			 		 alert("Effective End Date should not be earlier than the Effective From Date.");
			 		 return false;
			 	 }
			
			$j('#btnaddAuthority').prop("disabled",true);
			var params = {		
					  
					 'financialYearDate':jQuery('#financialYearDate').val(),
					 'effectiveStartDate':jQuery('#effectiveStartDate').val(),
					 'effectiveEndDate':jQuery('#effectiveEndDate').val(),
					  'userId': <%= userId%>,
					  'markFinancialYear':getMarkFinancialYearValue()
 		 	 }
			
			//alert(JSON.stringify(params));
			    var url = "addFinancialYear";
			    SendJsonData(url,params);
			    $j('#btnaddAuthority').attr("disabled", false);
			    ResetForm();
			    
		}
		 
		function getMarkFinancialYearValue(){
			var markFinancialYear='n';
			 if(document.getElementById("markFinancialYear").checked == true){
				 markFinancialYear='y'
			 }
			 else{
				 markFinancialYear='n'
			 }
			 return markFinancialYear;
		}
	
		
		function updateFinancialYear(){
			 
			if(document.getElementById('financialYearDate').value == null || document.getElementById('financialYearDate').value == ""  ){
				alert("Please Enter Financial Year");
				return false;
			}
			  if(document.getElementById('effectiveStartDate').value == null || document.getElementById('effectiveStartDate').value =="" ){
				alert("Please Enter Effective Start Date");
				return false;
			} 
			
			  if(document.getElementById('effectiveEndDate').value == null || document.getElementById('effectiveEndDate').value =="" ){
					alert("Please Enter Effective End Date");
					return false;
				} 
			 
			  var countDate=getDateComapareValue(document.getElementById('effectiveStartDate').value,document.getElementById('effectiveEndDate').value);
			 	 if(countDate!=0){
			 		 alert("Effective End Date should not be earlier than the Effective From Date.");
			 		 return false;
			 	 }
			
			
			var params = {
					 'financialid': financialid, 
					 'financialYearDate':jQuery('#financialYearDate').val(),
					 'effectiveStartDate':jQuery('#effectiveStartDate').val(),
					 'effectiveEndDate':jQuery('#effectiveEndDate').val(),
				 	 'userId': <%= userId%>,
				 	'markFinancialYear':getMarkFinancialYearValue()
					  
			 }
			//alert(JSON.stringify(params));
				    var url = "updateFinancialYear";
				    SendJsonData(url,params);
					$j('#btnaddAuthority').attr("disabled", false);
					 
					ResetForm();
		}
		
		function updateFinancialYearStatus(){
			
			
			var params = {
					
					 'financialid': financialid, 
					 'status':Status,
					 'markFinancialYear':getMarkFinancialYearValue()
					 
					 
			 
				} 
			
			//alert(JSON.stringify(params));
				    var url = "updateFinancialYearStatus";
			        SendJsonData(url,params);
			 
		     
		}
		
		function Reset(){
			$j('#btnaddAuthority').prop("disabled",false);
			 
			document.getElementById('searchFinancialYear').value = "";
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnaddAuthority').show();
			document.getElementById("messageId").innerHTML = "";
			$("#messageId").css("color", "black");
			 
			 
			showAll();
		}
				
		function ResetForm()
		{	
			$j('#btnaddAuthority').prop("disabled",false);
			 	 
			$j('#financialYearDate').val('');
			$j('#searchFinancialYear').val('');
			 
			$j('#effectiveStartDate').val('');
			$j('#effectiveEndDate').val('');
			document.getElementById("markFinancialYear").checked=false;
		}
		
		function showAll()
		{
			ResetForm();
			nPageNo = 1;	
			GetAllFinancialYear('ALL');
			
			$j("#btnActive").hide();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
			$j('#btnaddAuthority').show();
			 
			
			
		}
		 function showResultPage(pageNo)
		{
			nPageNo = pageNo;	
			GetAllFinancialYear('FILTER');
			
		} 
		
		 function search()
		 {
		 	if(document.getElementById('searchFinancialYear').value == ""){
		  		alert("Please Enter Financial Year");
		  		return false;
		  	}
		 	nPageNo=1;
		 	GetAllFinancialYear('FILTER');
		 }
		 
		 function checkFinancialYear(){
				
			 if(document.getElementById("markFinancialYear").checked == true){
			
			jQuery.ajax({
			 	crossOrigin: true,
			    method: "POST",			    
			    crossDomain:true,
			    url: "checkFinancialYear",
			    data: JSON.stringify({"PN" : "0"}),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	 var status=result.status;
			    	 var financialYear=result.financialYear;
			    	if(status=='1'){
			    		
			    		alert("Financial Year Already Exist "+financialYear);
			    		document.getElementById("markFinancialYear").checked=false;
			    		return false;
			    	}
			    	 
			    }
			    
			});
			 }
			 else{
				 return false;
			 }
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
                <div class="internal_Htext">Financial Year Master</div>
                    
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
													<label class="col-3 col-form-label">Financial Year<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														 <input type="text" name="searchFinancialYear" id="searchFinancialYear"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Financial Year" onkeypress="return validateText('searchFinancialYear',100,'Financial Year')">
 
														<!-- <select class="form-control" id="searchFinancialYear" name="searchFinancialYear" >
																<option value="">Select</option>
																<option value="2020-2021">2020-2021</option>
																<option value="2021-2022">2021-2022</option>
																<option value="2022-2023">2022-2023</option>
																<option value="2023-2024">2023-2024</option>
                                                          </select> -->
                                                          
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
												 
											</div>
										</div>
									</div>
                                    
		
						<div style="float:left">
               
                                     <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >   
                           			<tr>
                                 		<td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
                                   		<td></td>
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
                                              <th id="th2" class ="inner_md_htext">Financial Year</th>
                                                <th id="th1" class ="inner_md_htext">Start Date</th>
                                                <th id="th1" class ="inner_md_htext">End Date</th>
                                                 <th id="th4" class ="inner_md_htext">Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody class="clickableRow" id="tblListOfFinancialYear">
										 
                     				 </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addAuthorityForm" name="addAuthorityForm" method="">
                                                <div class="row">
                                                 
                                                   
                                                    
                                                     <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Financial Year<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                              <!--   <select class="form-control" id="financialYearDate" name="financialYearDate" >
                                                                 <option value="">Select</option>
                                                                 <option value="2020-2021">2020-2021</option>
																	<option value="2021-2022">2021-2022</option>
																	<option value="2022-2023">2022-2023</option>
																	<option value="2023-2024">2023-2024</option>
                                                                 </select> -->
                                                                  <input type="text" name="financialYearDate" id="financialYearDate"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Financial Year" >
														</div>
                                                      </div>                                                    
                                                 </div>
                                                 
                                                <div class="col-md-4">
                                                       <div class="form-group row">
												<label class="col-sm-5 col-form-label">Effective Start Date<span class="mandate"><sup>&#9733;</sup></span></label>
												<div class="col-sm-7">
													 
													<div class="dateHolder ">
														<input type="text"  class="calDate datePickerInput form-control" id="effectiveStartDate" placeholder="DD/MM/YYYY"
														name="effectiveStartDate"  onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10">
													</div>
												</div>
												</div>                                                   
                                                 </div>
                                                   
                                                   <div class="col-md-4">
                                                       <div class="form-group row">
												<label class="col-sm-5 col-form-label">Effective End Date<span class="mandate"><sup>&#9733;</sup></span></label>
												<div class="col-sm-7">
													 
													<div class="dateHolder ">
														<input type="text"  class="calDate datePickerInput form-control" id="effectiveEndDate" placeholder="DD/MM/YYYY"
														name="effectiveEndDate"  onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10">
													</div>
												</div>
												</div>                                                   
                                                 </div>
                                                
                                                 <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Mark Financial Year<!-- <span class="mandate"><sup>&#9733;</sup></span> --></label>
                                                            </div>
                                                            <div class="form-check form-check-inline cusCheck m-t-7">
																<input class="form-check-input" type="checkbox" id="markFinancialYear" name="markFinancialYear"  value="" onclick="checkFinancialYear()">
															<span class="cus-checkbtn"></span>
															 
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
												
														<button type="button" id="btnaddAuthority"
															class="btn  btn-primary " onclick="addFinancialYear();">Add</button>
														<button type="button" id="updateBtn"
															class="btn  btn-primary " onclick="updateFinancialYear();">Update</button>
														<button id="btnActive" type="button"
															class="btn  btn-primary " onclick="updateFinancialYearStatus();">Activate</button>
														<button id="btnInActive" type="button"
															class="btn btn-primary  " onclick="updateFinancialYearStatus();">Deactivate</button>
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

