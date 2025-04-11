<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>
 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/uploaddig.js"></script>
  
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Indian Coast Guard</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>
<script src="${pageContext.request.contextPath}/resources/js/stores.js"></script> 

</head>
<%
long departmentId = 0;
String departmentName="";
	  if (session.getAttribute("department_id") != null) {
	   departmentId = Long.parseLong(session.getAttribute("department_id").toString());
	  }
	  
	  %>
<body>

	<!-- Begin page -->
	<div id="wrapper">


		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
				<c:if test="${flag=='list'}">
					<div class="internal_Htext">Sanction Order Details</div>
				</c:if>
				<c:if test="${flag!='list'}">
					<div class="internal_Htext">Approve Sanction Order</div>
					</c:if>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
								<form:form name="createSanctionOrder" id="createSanctionOrder" method="post"
										action="${pageContext.request.contextPath}/lpprocess/approveSanctionOrder" >
									
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">RFP No</label>
												</div>
												<div class="col-md-6">
													<input type="text" name="reqNo" id="reqNo" readonly="readonly" class="form-control"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Quotation No.</label>
												</div>
												<div class="col-md-6">
													<input type="text" readonly="readonly" name="quotationNo" id="quotationNo" class="form-control"/>
												</div>
											</div>
										</div>
										
										<div class="w-100"></div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">File No.</label>
												</div>
												<div class="col-md-6">
													<input type="text" name="fileNo" id="fileNo" readonly="readonly" class="form-control"/>
												</div>
											</div>
										</div>
										<input type="hidden" name="storeSoMId" id="storeSoMId" readonly="readonly" class="form-control"/>
												
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Date</label>
												</div>
												<div class="col-md-6">
													<div class="dateHolder">
														<!-- <input type="text" class="calDate datePickerInput form-control minwidth120"
														placeholder="DD/MM/YYYY" value="" maxlength="10" /> -->
													<input type="text" name="date" id="date" readonly="readonly" class="form-control"/>
													</div>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Broad Purpose of Sanction</label>
												</div>
												<div class="col-md-6">
													<input type="text" name="sanctionPurpose" id="sanctionPurpose" readonly="readonly" class="form-control"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-12 m-t-10">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Vendor Name</label>
												</div>
												<div class="col-md-6">
													<input type="text" name="vendorName" id="vendorName" readonly="readonly" class="form-control"/>
												</div>
											</div>
										</div>
										
										<input type="hidden" name="vendorId" id="vendorId" class="form-control"/>
												
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Quantum of item/items or scope of services being sanctioned and the relevant financial years</label>
												</div>
												<div class="col-md-6">
													<textarea class="form-control" readonly="readonly" onkeypress="return isNumberKey(event)" name="quantumItem" id="quantumItem" rows="3"></textarea>
												</div>
											</div>
										</div>
										
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label " title="Click to expand">Value of sanction - both per unit cost and total cost (indication the taxes, it will be indicated whether the taxes are payable in addition, and if so, which tax and duties are payable)</label>
												</div>
												<div class="col-md-6">
													<textarea class="form-control" readonly="readonly" onkeypress="return isNumberKey(event)" name="valueOfSanction" id="valueOfSanction" rows="3"></textarea>
												</div>
											</div>
										</div>
										
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label ">Reference of Government authority/ Letter and schedule// Sub-Schedule of delegation of financial powers under which the sanction/approval is being accorded</label>
												</div>
												<div class="col-md-6">
													<textarea class="form-control" readonly="readonly" name="authorityLetter" id="authorityLetter" rows="3"></textarea>
												</div>
											</div>
										</div>
										
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Whether being issued under powers to be exercised without concurrence  or with concurrence of IFA</label>
												</div>
												<div class="col-md-6">
													<input type="text" name="ifa" id="ifa" readonly="readonly" class="form-control"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Name of the paying agency</label>
												</div>
												<div class="col-md-6">
													<input type="text" name="payingAgency" id="payingAgency" readonly="readonly" class="form-control"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Budget major head, minor head, sub head, detailed head and code head under which the expenditure will be booked</label>
												</div>
												<div class="col-md-6">
													<textarea class="form-control" readonly="readonly" onkeypress="return isNumberKey(event)" name="expenditure" id="expenditure" rows="3"></textarea>
												</div>
											</div>
										</div>
										
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Approval of CFA given vide note number</label>
												</div>
												<div class="col-md-6">
													<input type="text" name="videNote" id="videNote" readonly="readonly" class="form-control"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">UO number alloted by the  IFA (when the CFA's delegated  power are being exercised with financial concurrence)</label>
												</div>
												<div class="col-md-6">
													<input type="text" onkeypress="return isNumberKey(event)" readonly="readonly" name="uoNumber" id="uoNumber" class="form-control"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Communication of sanction: whether being signed  by the CFA or staff officer authorized by CFA to sign financial documents on his behalf and authority/ letter number and date of such authorization</label>
												</div>
												<div class="col-md-6">
													<textarea class="form-control" name="commSanction" id="commSanction" readonly="readonly" rows="3"></textarea>
												</div>
											</div>
										</div>
										
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">If the sanction is issued  overruling the advice  of the IFA, a copy of the order recorded  by the CFA in writing containing a gist of objection of CDA/ IFA and reasons for overruling the advice will be attached </label>
												</div>
												<div class="col-md-3">
													<input type="text" name="cda" id="cda" readonly="readonly" class="form-control"/>
												</div>
												<div class="col-md-3" id="downloadDoc" style="display:none">
												   <input type="hidden" name="doc" id="doc" readonly="readonly" class="form-control"/>
													<a style='text-decoration:underline; color:blue;'  href='#' onclick='downloadFile()'>View Document</a>
												</div>
											</div>
										</div>
									
									</div>
									
									<!-- <div class="row">
										<div class="col-12 text-right">
											<button class="btn btn-primary">Add Item</button>
											
										</div>
									</div> -->
									
									<div class="row">
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Total Amount (in Number)</label>
												</div>
												<div class="col-md-6">
													<input type="text" name="l1Cost" id="l1Cost" readonly="readonly" class="form-control"/>
												</div>
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Total Amount (in Words)</label>
												</div>
												<div class="col-md-6">
													<textarea name="l1CostWord" id="l1CostWord" readonly="readonly" class="form-control" rows="3"></textarea>
												</div>
											</div>
										</div>
									</div>
									
									
									
									<table class="table table-hover table-striped table-bordered m-t-10">
										<thead class="bg-primary">
											<tr>
												<th>S.No.</th>
												<th>Nomenclature/PVMS No</th>
												<th>A/U</th>
												<th>Qty Required</th>
												<th>Unit Rate</th>
												<th>Value</th>
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
													<input type="text" id="unitrate1"
														 name="unitrate" class="form-control width120" readonly="readonly" />
												</td>
												<td>
													<input type="text" id="totalValue1"
														 name="totalValue" class="form-control width120" readonly="readonly" />
												</td>
												<td style="display: none;"><input type="hidden"
														value="" tabindex="1" id="itemIdNom1"
														name="itemIdNom" /></td>

													<td style="display: none;"><input type="hidden"
														name="pvmsNo1" tabindex="1" id="pvmsNo1" size="10"
														readonly="readonly" /></td>
														
														<td style="display: none;"><input type="hidden"
														name="storeQuotationM" tabindex="1" id="storeQuotationM1" size="10"
														readonly="readonly" /></td>
														
														<td style="display: none;"><input type="hidden"
														name="storeQuotationTId" tabindex="1" id="storeQuotationTId1" size="10"
														readonly="readonly" /></td>
														
													
														
												
											</tr>
											
										</tbody>
									</table>
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
									<div class="row">
										<div class="col-12 text-right">
											<div class="row m-t-10">
										<div class="col-md-12 text-right">
										<c:if test="${flag!='list'}">
										<input type="submit" class="btn btn-primary "
														name="approve" value="Submit" id="saveForm1" onclick="return submitForm();" />
														<a  class="buttonDel  btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/lpprocess/pendingListForSanctionApproval">Close</a>
											
											</c:if>
											
											
											<c:if test="${flag=='list'}">
														<a  class="buttonDel  btn btn-primary " role="button"
															href="${pageContext.request.contextPath}/lpprocess/sanctionList">Close</a>
											</c:if>
											</div>
									</div>
									</div>
									</div>
									
									
									</form:form>
											
										</div>
									</div>
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

	<script type="text/javascript">
	
	$(function(){
		
		$('.longLabel').on('click',function(){
			var $this = $(this);
			
			if ($this.hasClass('clicked')){
				console.log('class removed');
				$this.removeClass('clicked');
			}
			else{
				$this.addClass('clicked');
			}
		});

		
	});
	 var k=1;
	 var j=0;
	 $j(document).ready(function() {
		//if department not in session
		   	if(<%= departmentId %>!=0){
					$j("#createSanctionOrder :input").attr("disabled", false);
					$("#saveForm1").attr("disabled", false);
					}else{
					alert("Select the department");
					$j("#createSanctionOrder :input").attr("disabled", true);
					return false;
				}
		 var now = new Date();
		 	now.setDate(now.getDate());
		 	var day = ("0" + now.getDate()).slice(-2);
		 	var month = ("0" + (now.getMonth() + 1)).slice(-2);

		 	var today = (day)+"/"+(month)+"/"+now.getFullYear();

		 	$j('#date').val(today);
		 

	               
	                    
	                    var dataList = ${data};
	                    var resultList= dataList.data;
	                    var itemList= dataList.itemdata;
	                    var count=dataList.count;
	                    
	                    if(resultList.sanctionIssued.toUpperCase() === 'Yes'.toUpperCase()){
	                    $('#downloadDoc').show();
	                    }
	                    $('#doc').val(resultList.ridcId);
	                    $('#reqNo').val(resultList.reqNo);
	                    $('#quotationNo').val(resultList.quotationNo);
	                    $('#sanctionPurpose').val(resultList.orderPurpose);
	                    $('#fileNo').val(resultList.fileNo);
	                    $('#vendorName').val(resultList.vendorName);
	                    $('#quantumItem').val(resultList.quotationOfItem);
	                    $('#valueOfSanction').val(resultList.valueOfOrder);
	                    $('#authorityLetter').val(resultList.refOfGovtAuthority);
	                    $('#ifa').val(resultList.issueUnder);
	                    $('#payingAgency').val(resultList.payingAgency);
	                    $('#expenditure').val(resultList.bookedBudget);
	                    $('#videNote').val(resultList.videNoteNumber);
	                    $('#uoNumber').val(resultList.uoNumber);
	                    $('#commSanction').val(resultList.commWithSanction);
	                    $('#cda').val(resultList.sanctionIssued);
	                    $('#l1Cost').val(resultList.totalAmount);
	                    $('#l1CostWord').val(resultList.totalAmountWords);
	                    $('#storeSoMId').val(resultList.storeSoMId);
	                    
	                    if(resultList.lpTypeFlag!="" && resultList.lpTypeFlag=='B'){
	                    	$j('#date').addClass("noFuture_dateStore datePickerInput form-control");
	                    }else{
	                    	$j('#date').addClass("form-control");
	                    }
	                    
	                    
	                    //get list    	 
	                   for(item in itemList){
	                   
	             	 j++;
	             	 $('#sNo'+j).html(j);
	             	 $('#nomenclature'+j).val(itemList[item].NomPvmsNo);
	             	 $('#dispensingUnit'+j).val(itemList[item].accountingUnit);
	             	 $('#requiredQty'+j).val(itemList[item].requiredQty);
	             	 $('#totalValue'+j).val(itemList[item].totalValue);
	             	 $('#itemIdNom'+j).val(itemList[item].itemId);
	             	 $('#pvmsNo'+j).val(itemList[item].pvmsNo);
	             	 $('#unitrate'+j).val(itemList[item].unitrate);
	             	// $('#storeQuotationM'+j).val(itemList[item].storeQMId);
	             	// $('#storeQuotationTId'+j).val(itemList[item].storeQuotationTId);
	             	   	 if(j!==count)
	                   	 addRow1();
	                   }

	 });
	 
	 function addRow1() {
		
		 k++;
		 var aClone = $('#nomenclatureGrid1>tr:last').clone(true)
		 aClone.find(":input").val("");
		 aClone.find("td:eq(0)").prop('id', 'sNo'+k+'');
		 aClone.find("td:eq(1)").find(":input").prop('id', 'nomenclature'+k+'');
		 aClone.find("td:eq(2)").find(":input").prop('id', 'dispensingUnit'+k+'');
		 aClone.find("td:eq(3)").find(":input").prop('id', 'requiredQty'+k+'');
		 aClone.find("td:eq(4)").find(":input").prop('id', 'unitrate'+k+'');
		 aClone.find("td:eq(5)").find(":input").prop('id', 'totalValue'+k+'');
		 aClone.find("td:eq(6)").find(":input").prop('id', 'itemIdNom'+k+'');
		 aClone.find("td:eq(7)").find(":input").prop('id', 'pvmsNo'+k+'');
		 aClone.find("td:eq(8)").find(":input").prop('id', 'storeQuotationM'+k+'');
		 
		 aClone.find("td:eq(9)").find(":input").prop('id', 'storeQuotationTId'+k+'');
		 
		 aClone.clone(true).appendTo('#nomenclatureGrid1');
		  
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
		   
			//$("#submitBudgetaryQuotation").submit();
		    $("#submitBudgetaryQuotation").submit();
			 setTimeout(function(){ 			 
				 $("#saveForm1").attr("disabled", "disabled");
				 
			 }, 50);
		
	}
	 
	 function downloadFile(){
		var ridcId=$('#doc').val();
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
</body>

</html>