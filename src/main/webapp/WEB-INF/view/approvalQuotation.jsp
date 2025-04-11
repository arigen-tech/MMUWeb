
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="com.mmu.web.utils.HMSUtil"%>

<%@include file="..//view/leftMenu.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/uploaddig.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newOpd.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opd.js"></script>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<script src="${pageContext.request.contextPath}/resources/js/stores.js"></script> 

<title>Approval Quotation</title>

<% long LPC_CODE =2;// Long.parseLong(HMSUtil.getProperties("js_messages_en.properties", "LPC_CODE")); %>
<% long LP_CASH_AND_CARRY_CODE =Long.parseLong(HMSUtil.getProperties("js_messages_en.properties", "LP_CASH_AND_CARRY_CODE")); %>


</head>
<%
long departmentId = 0;
String departmentName="";
	  if (session.getAttribute("department_id") != null) {
	   departmentId = Long.parseLong(session.getAttribute("department_id").toString());
	  }
	  
	  %>
<body>
 <p align="center" id="messageId" style="color:green; font-weight: bold;" >${message}</p>
	<body>

	<!-- Begin page -->
	<div id="wrapper">


		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">APPROVAL QUOTATION SCREEN (LPC PRESIDENT) </div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
								<form:form name="approveBudgetaryQuotation" id="approveBudgetaryQuotation" method="post"
										action="${pageContext.request.contextPath}/lpprocess/approveQuotationPresident" >
								
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Quotation Entry Date</label>
												</div>
												<div class="col-md-7">
													<div class="dateHolder">
														<input type="text" class=" form-control minwidth120" name="quotationDate" id="quotationDate"
														 value="" maxlength="10" readonly="readonly"/>
													</div>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Quotation Approval Date</label>
												</div>
												<div class="col-md-7">
													<div class="dateHolder">
													<input type="text" class=" form-control minwidth120" name="quotApproveDate" id="quotDate"
														 value="" maxlength="10" readonly="readonly"/>
														 
														<!-- <input type="text" class="calDate datePickerInput form-control minwidth120" name="quotApproveDate" id="quotDate"
														placeholder="DD/MM/YYYY" value="" maxlength="10" onchange="getCommitteeMember()" /> -->
													</div>
												</div>
											</div>
										</div>
									</div>
									
									<input type="hidden" class="form-control" name="budgetaryId" value="${budgetaryId}" />
									<input type="hidden" class="form-control" name="vendorId" id="l1VendorId" value="" />
									<input type="hidden" class="form-control" name="lpTypeCode" id="lpTypeCode" value="${lpTypeCode}" />
									
									<!-- Committee Member  -->
									<c:if test="${lpTypeCode==1}">
									<h6 class="font-weight-bold text-theme text-underline m-t-20">LP Committee Member</h6>
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Member 1</label>
												</div>
												<div class="col-md-7">
													<input type="text" id="member1" class="form-control" disabled/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Member 2 </label>
												</div>
												<div class="col-md-7">
													<input type="text" id="member2" class="form-control" disabled/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">President</label>
												</div>
												<div class="col-md-7">
													<input type="text" id="president" class="form-control" disabled/>
												</div>
											</div>
										</div>
									</div>
									</c:if>
									
									
									<h6 class="font-weight-bold text-theme text-underline  m-t-20">Quotation Entered</h6>
									<div class="row" id="vendorDetails">
								
									</div>
									
									
									
									<h6 class="font-weight-bold text-theme text-underline m-t-20">List Of Item</h6>
									<div class="table-responsive" >
									<table class="table table-hover table-striped table-bordered m-t-10" id="quotationDetails" >
										<thead class="bg-primary">
											<tr id="firstHead"> 
											    <th rowspan="2">SI No</th>
												<th rowspan="2">Nomenclature/PVMS No</th>
												<th rowspan="2">A/U</th>
												<th rowspan="2">Required Qty</th>
												<th rowspan="2">Last LP Unit Rate</th>
											</tr>
											<tr id="secondHead">
											</tr>
										</thead>
										<tbody id="nomenclatureGrid1">
											<tr>
												<td id="sNo1">1</td>
												<td>
													<input type="text" class="form-control width330" readonly="readonly"id="nomenclature1" size="77"
																name="nomenclature" />
												</td>
												<td>
													<input type="text" name="accountingUnit1"
														tabindex="1" id="dispensingUnit1" class="form-control width200" readonly="readonly" />
												</td>
												<td>
													<input type="text" name="requiredQty" tabindex="1"
														autocomplete="nope" spellcheck="false" value=""
														id="requiredQty1"   class="form-control" readonly="readonly" />
												</td>
												<td>
													<input type="text" id="lpunitrate1"
														 name="lpunitrate" class="form-control width200" readonly="readonly" />
												</td>
												<td style="display: none;"><input type="hidden"
														value="" tabindex="1" id="itemIdNom1" size="77"
														name="itemIdNom" /></td>

													<td style="display: none;"><input type="hidden"
														name="pvmsNo1" tabindex="1" id="pvmsNo1" size="10"
														readonly="readonly" /></td>
														
														<td style="display: none;"><input type="hidden"
														name="budgetaryMId1" tabindex="1" id="budgetaryMId1" size="10"
														readonly="readonly" /></td>
														
													<td style="display: none;"><input type="hidden"
														name="budgetaryTId1" tabindex="1" id="budgetaryTId1" size="10"
														readonly="readonly" /></td>
														
												
											</tr>
											
										</tbody>
									</table>
									</div>
									<div class="row m-t-20" id="textBoxesGroup"></div>
									
									<div class="row" id ="venderList" >
										<div class="col-md-6">
											<div class="form-group row">
												<div class="col-md-4">
													<label for="service" class="col-form-label">L1 Vendor Name</label>
												</div>
												<div class="col-md-8">
													<div class="dateHolder">
														 <input type="text" class="form-control" name="leastVendor" id="leastVendor" readonly="readonly" />
                                                                       
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="row m-t-20 ">
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Action<span class="mandate"><sup>&#9733;</sup></span></label>
													</div>
													<div class="col-md-7">
														<select class="form-control" name="action" id="action">
														<option value="0" selected="selected">Select</option>
														<option>Approve</option>
														<option>Reject</option>
														</select>
													</div>
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-group row">
													<div class="col-md-3">
														<label for="service" class="col-form-label">Remarks</label>
													</div>
													<div class="col-md-8 m-l-10">
														<textarea class="form-control" rows="2" name="approvalRemark" id="remark"></textarea>
													</div>
												</div>
											</div>									
										</div>
										<div class="row m-t-10">
										<div class="col-md-12 text-right">
										<input type="submit" class="btn btn-primary "
														name="btnvalue" value="Submit" id="saveForm1" onclick="return submitForm();" />
											<a  class="buttonDel  btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/lpprocess/quotationApprovalListlpc">Close</a>
													
											<!-- <button  class="btn btn-primary" onclick="return submitForm();">Approve</button> -->
										</div>
									</div>
									</form:form>
								</div>
								
							</div>
						</div>
					</div>
				</div>

			</div>
			<!-- container -->

		</div>
			<!-- content -->

	</div>

		<!-- ============================================================== -->
		<!-- End Right content here -->
		<!-- ============================================================== -->

	
	<!-- END wrapper -->

</body>
<script>
var j=0;
var k=1;
 $j(document).ready(function() {
	//if department not in session
	   	if(<%= departmentId %>!=0){
				$j("#approveBudgetaryQuotation :input").attr("disabled", false);
				$("#saveForm1").attr("disabled", false);
				}else{
				alert("Select the department");
				$j("#approveBudgetaryQuotation :input").attr("disabled", true);
				return false;
			}
	 var now = new Date();
 	now.setDate(now.getDate());
 	var day = ("0" + now.getDate()).slice(-2);
 	var month = ("0" + (now.getMonth() + 1)).slice(-2);

 	var today = (day)+"/"+(month)+"/"+now.getFullYear();

 	 $j('#quotDate').val(today); 
 	
 	var lpTypeCode =${lpTypeCode};
	if(lpTypeCode==1){	
	
 var result=${memberlist};
 if(result.status==1){
		document.getElementById("member1").value=result.memberName1;
		document.getElementById("member2").value=result.memberName2;
		document.getElementById("president").value=result.president;
	}
	else if(result.status==0){
		console.log(result.msg);
		alert(result.msg);
		window.location.href = "quotationApprovalListlpc";
		
	}
}
var dataList = ${data};
					var vcostList= dataList.vcostdata;
					var l1Vendor=dataList.l1Vendor;
					var lpTypeFlag=dataList.lpTypeFlag;
					
					if(lpTypeFlag!="" && lpTypeFlag=='B'){
						$j('#quotDate').addClass("noFuture_dateStore datePickerInput form-control minwidth120");
					}else{
						$j('#quotDate').addClass("form-control minwidth120");
					}
					var l1VendorId=dataList.l1VendorId;
					var quotationDate=dataList.quotationDate;
                    var resultList= dataList.data;
                    var count=dataList.count;
                    var totalVendor=dataList.totalVendor;
                    var vendorName = "";
                 	var unitRate = "";
                 	var totalCost = "";
                    for(var m=1;m<=totalVendor;m++) {
                     	 vendorName = 'vendorName'+m;
                     	  unitRate = 'unitRate'+m;
                     	 totalCost = 'totalCost'+m;
                    	/* $j("#quotationDetails>thead>tr").append("<th>Quotation"+m+"("+resultList[0][vendorName]+"(Unit Rate)</th>");
          		 	    $j("#quotationDetails>thead>tr").append("<th>Quotation"+m+"(Total Cost)</th>"); */
          		 	    
          		 		$j("#quotationDetails thead tr#firstHead").append("<th class='text-center' colspan='2'>Quotation"+m+"<br/>("+resultList[0][vendorName]+")</th>");
          		 		$j("#quotationDetails thead tr#secondHead").append("<th> Unit Rate</th><th>Total Cost</th>");
          		 	
                    } 
                   for(item in resultList){
                	   
                 			  j++;
			             	 $('#sNo'+j).html(j);
			             	 $('#nomenclature'+j).val(resultList[item].NomPvmsNo);
			             	 $('#dispensingUnit'+j).val(resultList[item].accountingUnit);
			             	 $('#requiredQty'+j).val(resultList[item].requiredQty);
			             	 $('#itemIdNom'+j).val(resultList[item].itemId);
			             	 $('#pvmsNo'+j).val(resultList[item].pvmsNo);
			             	 $('#lpunitrate'+j).val(resultList[item].lpunitrate);
			             
             	 
             	
             	    			 if(j!==count)
                   					 addRow1();
                   }
             	    		 //for(item in resultList){
             	    			 var item=0;
             	    		 $("#nomenclatureGrid1 tr").each(function () {
             	    		 for(var m=1;m<=totalVendor;m++) {
                             	 vendorName = 'vendorName'+m;
                             	 var vendorId='vendorId'+m;
                             	 unitRate = 'unitRate'+m;
                             	 totalCost = 'totalCost'+m;
                             	 
                             	 $(this).append("<td><input type='text' id='unitRate"+k+"' value="+resultList[item][unitRate]+" name='unitRate' readonly='readonly'  class='form-control width120' /></td>");
                 		 	     $(this).append("<td><input type='text' value="+resultList[item][totalCost]+" class='form-control width120' id='totalCost"+k+"' name='totalCost' readonly='readonly' /></td>");
                		 	     $(this).append("<td style='display: none;'><input type='text' name='venderId' id='vid"+k+"' value="+resultList[item][vendorId]+" class='form-controlwidth120' readonly='readonly' /></td>");
                		 	
                            } 
             	    		 item++;
                   });
             	    		 for(var l=1;l<=totalVendor;l++) {	
             	    			 var vcost='vcost'+l;
             	    			var VendorName='VendorName'+l;
             	    			var ridcId='ridcId'+l;
             	    		 		$j("#textBoxesGroup").append( '<div class="col-md-4"><div class="form-group row"><div class="col-md-6"><label for="service" class="col-form-label">Total Cost Q'+l+'</label></div>'+
             	    				'<div class="col-md-6"><input type="text" id="totalCostQ" name="totalCostQ" value ='+vcostList[l][vcost]+' class="form-control" readonly="readonly"/></div></div></div>');
             	    		 
             	    				
             	    				$j("#vendorDetails").append('<div class="col-md-2">'+
									'<h6>Quotation'+l+'</h6></div><div class="col-md-6"><div class="form-group row">'+
										
										'<div class="col-md-4"><label for="service" class="col-form-label">Vendor Name</label></div>'+
										'<div class="col-md-8"><input type="text" value ="'+vcostList[l][VendorName]+'" class="form-control" disabled/></div></div></div>'+
										 '<div class="col-md-4"><div class="form-group row"><div class="col-md-12">'+
									     '<a href="#" onclick="downloadFile('+vcostList[l][ridcId]+')" class="text-primary font-weight-bold m-l-20 text-underline">View Quotation</a></label></div></div></div>');
					                     
							
             	    		 }
             	    		
             	    		 $j('#leastVendor').val(l1Vendor);
             	    		 $j('#quotationDate').val(quotationDate);
             	    		 $j('#l1VendorId').val(l1VendorId);
             	    		
             	    		
 });
 
 function addRow1() {
	
	 k++;
	 var aClone = $('#nomenclatureGrid1>tr:last').clone(true)
	 aClone.find(":input").val("");
	 aClone.find("td:eq(0)").prop('id', 'sNo'+k+'');
	 aClone.find("td:eq(1)").find(":input").prop('id', 'nomenclature'+k+'');
	 aClone.find("td:eq(2)").find(":input").prop('id', 'dispensingUnit'+k+'');
	 aClone.find("td:eq(3)").find(":input").prop('id', 'requiredQty'+k+'');
	 aClone.find("td:eq(4)").find(":input").prop('id', 'lpunitrate'+k+'');
	 aClone.find("td:eq(5)").find(":input").prop('id', 'itemIdNom'+k+'');
	 aClone.find("td:eq(6)").find(":input").prop('id', 'pvmsNo'+k+'');
	 
	 aClone.clone(true).appendTo('#nomenclatureGrid1');
	  
 }
 
 
 function getCommitteeMember(){
	  var quotationDate= document.getElementById("quotDate").value;
	 	 var quotationDate={"quotationDate":quotationDate};
		 jQuery.ajax({
	 	 	crossOrigin: true,
	 	    method: "POST",			    
	 	    crossDomain:true,
	 	    url: "getCommitteeMember",
	 	    data:JSON.stringify(quotationDate),
	 	    contentType: "application/json; charset=utf-8",
	 	    dataType: "json",
	 	    success: function(result){
	 	    	if(result.status==1){
	 	    		document.getElementById("member1").value=result.memberName1;
	 	    		document.getElementById("member2").value=result.memberName2;
	 	    		document.getElementById("president").value=result.president;
	 	    	}
	 	    	else if(result.status==0){
	 	    		console.log(result.msg);
	 	    		alert(result.msg);
	 	    		
	 	    	}
	 	    	
	 	    },
	 	    error: function(result) {
	             alert("An error has occurred while contacting the server");
	         }
	 	    
	 	});
	 	
	}
 
 function submitForm() {
	  var flag=0;
	  var action = $j("#action").val();
	  if (action == null || action == 0) {
	        alert("Please select Action");
	        return false;
	    }
	    if(flag==1){
	    	return false;
	    } 
	   
		$("#submitBudgetaryQuotation").submit();
	    setTimeout(function(){ 			 
			 $("#saveForm1").attr("disabled", "disabled");
			 
		 }, 50);
	
}
 
 function downloadFile(ridcId){
	 //viewDocumentForCommon(ridcId);
	 viewDocumentForDigi(ridcId);
	 
		}
 
 
 function compareDate(){
	 	/* var approvalOn = $('#approvalDateOn').val();
	     var requestedOn = $('#lpDate').val();
	 			 
	 	   if(process(approvalOn) < process(requestedOn)){
	 			alert("Approval Date should not be earlier than Requested Date.");
	 			 $('#approvalDateOn').val("");
	 				return;
	 			 } */
	 } 
</script>
</html>