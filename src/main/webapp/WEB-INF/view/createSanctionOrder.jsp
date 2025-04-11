<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/uploaddig.js"></script>
 
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
					<div class="internal_Htext">Create Sanction Order</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
								<form:form name="createSanctionOrder" id="createSanctionOrder" method="post" enctype='multipart/form-data'
										action="${pageContext.request.contextPath}/lpprocess/submitSanctionOrder" >
									
									
									<input type="hidden" readonly="readonly" name="budgetaryId" id="budgetaryId" class="form-control"/>
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">RFP No</label>
												</div>
												<div class="col-md-6">
													<input type="text" readonly="readonly" name="reqNo" id="reqNo" class="form-control"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Quotation No.</label>
												</div>
												<div class="col-md-6">
													<input type="text"  name="quotationNo" id="quotationNo" readonly="readonly" class="form-control"/>
												</div>
											</div>
										</div>
										
										<div class="w-100"></div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">File No.<span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-6">
													<input type="text" name="fileNo" id="fileNo" maxlength="30" class="form-control"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Date</label>
												</div>
												<div class="col-md-6">
													<div class="dateHolder">
														<!-- <input type="text" class="calDate datePickerInput form-control minwidth120"
														placeholder="DD/MM/YYYY" value="" maxlength="10" /> -->
													<input type="text" name="date" id="date" class="form-control" readonly="readonly"/>
													</div>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Broad Purpose of Sanction<span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-6">
													<input type="text" name="sanctionPurpose" id="sanctionPurpose" maxlength="60" class="form-control"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-12 m-t-10">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Vendor Name</label>
												</div>
												<div class="col-md-6">
													<!-- <input type="text" name="vendorName" id="vendorName" readonly="readonly" class="form-control width330"/> -->
													<textarea class="form-control" name="vendorName" id="vendorName" readonly="readonly" rows="2"></textarea>
												</div>
											</div>
										</div>
										
										<input type="hidden" name="vendorId" id="vendorId" class="form-control"/>
										
										<input type="hidden" name="sanctionId" value="0" id="sanctionId" class="form-control"/>
									    <input type="hidden" name="status" id="status" readonly="readonly" class="form-control"/>
													
												
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Quantum of item/items or scope of services being sanctioned and the relevant financial years<span class="mandate"><sup>&#9733;</sup></label>
												</div>
												<div class="col-md-6">
													<textarea class="form-control"  maxlength="160" name="quantumItem" id="quantumItem" rows="3"></textarea>
												</div>
											</div>
										</div>
										
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label " title="Click to expand">Value of sanction - both per unit cost and total cost (indication the taxes, it will be indicated whether the taxes are payable in addition, and if so, which tax and duties are payable)<span class="mandate"><sup>&#9733;</sup></label>
												</div>
												<div class="col-md-6">
													<textarea class="form-control"  maxlength="160" name="valueOfSanction" id="valueOfSanction" readonly="readonly" rows="3"></textarea>
												</div>
											</div>
										</div>
										
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label ">Reference of Government authority/ Letter and schedule// Sub-Schedule of delegation of financial powers under which the sanction/approval is being accorded<span class="mandate"><sup>&#9733;</sup></label>
												</div>
												<div class="col-md-6">
													<textarea class="form-control" name="authorityLetter" maxlength="160" id="authorityLetter" rows="3"></textarea>
												</div>
											</div>
										</div>
										
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Whether being issued under powers to be exercised without concurrence  or with concurrence of IFA<span class="mandate"><sup>&#9733;</sup></label>
												</div>
												<div class="col-md-6">
													<input type="text" name="ifa" id="ifa" maxlength="150" class="form-control"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Name of the paying agency<span class="mandate"><sup>&#9733;</sup></label>
												</div>
												<div class="col-md-6">
													<input type="text" name="payingAgency" id="payingAgency" maxlength="160" class="form-control"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Budget major head, minor head, sub head, detailed head and code head under which the expenditure will be booked<span class="mandate"><sup>&#9733;</sup></label>
												</div>
												<div class="col-md-6">
													<textarea class="form-control" maxlength="180" name="expenditure" id="expenditure" rows="3"></textarea>
												</div>
											</div>
										</div>
										
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Approval of CFA given vide note number<span class="mandate"><sup>&#9733;</sup></label>
												</div>
												<div class="col-md-6">
													<input type="text" name="videNote" id="videNote" maxlength="170" class="form-control"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">UO number alloted by the  IFA (when the CFA's delegated  power are being exercised with financial concurrence)<span class="mandate"><sup>&#9733;</sup></label>
												</div>
												<div class="col-md-6">
													<input type="text"  name="uoNumber" id="uoNumber" maxlength="180" class="form-control"/>
												</div>
											</div>
										</div>
										
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">Communication of sanction: whether being signed  by the CFA or staff officer authorized by CFA to sign financial documents on his behalf and authority/ letter number and date of such authorization<span class="mandate"><sup>&#9733;</sup></label>
												</div>
												<div class="col-md-6">
													<textarea class="form-control" name="commSanction" id="commSanction" maxlength="180" rows="3"></textarea>
												</div>
											</div>
										</div>
										
										<div class="col-md-12">
											<div class="form-group row">
												<div class="col-md-6">
													<label class="col-form-label">If the sanction is issued  overruling the advice  of the IFA, a copy of the order recorded  by the CFA in writing containing a gist of objection of CDA/ IFA and reasons for overruling the advice will be attached <span class="mandate"><sup>&#9733;</sup></label>
												</div>
												<div class="col-md-2">
													<!-- <input type="text" name="cda" id="cda" maxlength="30" class="form-control"/> -->
													<select class="form-control m-t-10" name="cda" id="cda" onchange="getChooseFileOption();">
														<option>Select</option>
														<option>Yes</option>
														<option>No</option>
														<option>NA</option>
													</select>
												</div>
												<div class="col-md-2" id="upload" style="display:none">
													<div class="fileUploadDiv m-t-10">
													  	<input type="file" id="fileUploadid" style="width: 100%;" class="inputUpload" name="upload">
														<label class="inputUploadlabel">Choose File</label>
														<span class="inputUploadFileName">No File Chosen</span>
														
													</div>	
													
												  	</div>
												  	<div class="col-md-2" id="downloadDoc" style="display:none">
												  	 <input type="hidden" name="doc" id="doc" readonly="readonly" class="form-control"/>
													<a style='text-decoration:underline; color:blue;' class="btn btn-link m-t-10"  href='#' onclick='downloadFile()'>View Document</a>
												  </div>
												</div>
												<!-- <div class="col-md-1">
													<button type="button" class="btn btn-primary m-t-10">Upload</button>
												</div> -->
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
										
										<div class="col-md-12" style="display:none" id="approveRemark">
												<div class="form-group row">
													<div class="col-md-6">
														<label for="service" class="col-form-label">Rejected Remarks</label>
													</div>
													<div class="col-md-6">
														<textarea class="form-control" rows="2" name="approvalRemark" id="remarks" readonly="readonly"></textarea>
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
														 name="unitrate" class="form-control " readonly="readonly" />
												</td>
												<td>
													<input type="text" id="totalValue1"
														 name="totalValue" class="form-control" readonly="readonly" />
												</td>
												<td style="display: none;"><input type="hidden"
														value="" tabindex="1" id="itemIdNom1" size="77"
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
									<div class="row">
										<div class="col-12 text-right">
											<div class="row m-t-10">
										<div class="col-md-12 text-right">
										<input type="submit" class="btn btn-primary "
														name="submit" value="Save as Draft" id="saveDraft" onclick="return submitForm('save');" />
										<input type="submit" class="btn btn-primary "
														name="submit" value="Submit" id="saveForm1" onclick="return submitForm('submit');" />
											<input type="button" id="reset" class="btn btn-danger" onClick="document.location.reload(true);" value="Reset"/>
											<a  class="buttonDel  btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/lpprocess/pendingListForSanctionOrder">Close</a>
											
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
					$("#saveDraft").attr("disabled", false);
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

			//get list                  
	                    
	                    var dataList = ${data};
	                    var resultList= dataList.data;
	                    var count=dataList.count;
	                    var status=dataList.status;
	                    
	                    if(dataList.lpTypeFlag!="" && dataList.lpTypeFlag=='B'){
	                    	$j('#date').addClass("noFuture_dateStore datePickerInput form-control");
	                    }else{
	                    	$j('#date').addClass("form-control");
	                    }
	                    
	                    var sanctionData=dataList.sanctionData;
	                    $j('#status').val(status);
	                    if(status.toUpperCase() === "Rejected".toUpperCase() || status.toUpperCase() === "Saved".toUpperCase()){
	                    	$j('#sanctionId').val(sanctionData.sanctionId);
	                    	 if(sanctionData.sanctionIssued.toUpperCase() === 'Yes'.toUpperCase()){
	 	                    $('#downloadDoc').show();
	 	                	 $j('#upload').show();
	 	                    }
	                    	 $('#doc').val(sanctionData.ridcId);
	        		    	$j('#fileNo').val(sanctionData.fileNo);
	        		    	$j('#sanctionPurpose').val(sanctionData.sanctionPurpose);
	        		    	$j('#quantumItem').val(sanctionData.quantumItem);
	        		    	$j('#authorityLetter').val(sanctionData.authorityLetter);
	        		    	$j('#expenditure').val(sanctionData.expenditure);
	        		    	$j('#videNote').val(sanctionData.videNote);
	        		    	$j('#cda').val(sanctionData.cda);
	        		    	if(sanctionData.remarks!=null)
	        		    		{
	        		    		$j('#approveRemark').show();
	        		    		$j('#remarks').val(sanctionData.remarks);
	        		    		}
	        		        $('#reqNo').val(sanctionData.reqNo);
	 	                    $('#quotationNo').val(sanctionData.quotationNo);
	 	                    $('#vendorName').val(sanctionData.vendorName);
	 	                    $('#valueOfSanction').val(sanctionData.valueOfOrder);
	 	                    $('#ifa').val(sanctionData.issueUnder);
	 	                    $('#payingAgency').val(sanctionData.payingAgency);
	 	                    $('#uoNumber').val(sanctionData.uoNumber);
	 	                    $('#commSanction').val(sanctionData.commWithSanction);
	 	                    $('#l1Cost').val(sanctionData.totalAmount);
	 	                    $('#l1CostWord').val(sanctionData.totalAmountWords);
	 	                   $j('#vendorId').val(sanctionData.vendorId);
	 	                   $j('#budgetaryId').val(sanctionData.budgetaryId);
	 	                   }
	                   for(item in resultList){
	                   	if(item==1 && status.toUpperCase() === "New".toUpperCase()){
	             		   $j('#quotationNo').val(resultList[item].quotationNo);
	             	  	   $j('#reqNo').val(resultList[item].reqNo);
	             	  	   $j('#vendorId').val(resultList[item].vendorId);
	             	  	   $j('#l1Cost').val(resultList[item].l1Cost);
	             	  	   $j('#l1CostWord').val(resultList[item].l1CostWord);
	             	  	   $j('#vendorName').val(resultList[item].vendorName);
	             	  	   $j('#budgetaryId').val(resultList[item].budgetaryId);
	             	  	   $j('#valueOfSanction').val("As per enclosure 1 {Rs."+resultList[item].l1Cost+"("+resultList[item].l1CostWord+")}");
	             	  	   if(resultList[item].l1Cost>250000)
	             	  		$j('#ifa').val("With concurrence of IFA in > 2.5L ");
	             	  	   else
	             	  		$j('#ifa').val("Without concurrence of IFA in <=2.5L");
	             	  		$j('#payingAgency').val("CDA (Navy/ Coast Guard) New Delhi");
	             	  		$j('#commSanction').val("NA");
	             	  		$j('#uoNumber').val("UO No.__________dated_________");
	             	  	  }
	             	 j++;
	             	 $('#sNo'+j).html(j);
	             	 $('#nomenclature'+j).val(resultList[item].NomPvmsNo);
	             	 $('#dispensingUnit'+j).val(resultList[item].accountingUnit);
	             	 $('#requiredQty'+j).val(resultList[item].requiredQty);
	             	 $('#totalValue'+j).val(resultList[item].totalCost);
	             	 $('#itemIdNom'+j).val(resultList[item].itemId);
	             	 $('#pvmsNo'+j).val(resultList[item].pvmsNo);
	             	 $('#unitrate'+j).val(resultList[item].unitrate);
	             	 $('#storeQuotationM'+j).val(resultList[item].storeQMId);
	             	 $('#storeQuotationTId'+j).val(resultList[item].storeQuotationTId);
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
		  
	 function submitForm(val) {
		  var flag=0;
		  if(val=="submit"){
		  reqNo= $('#reqNo').val();
		  quotationNo=$('#quotationNo').val();
		  orderPurpose=$('#sanctionPurpose').val();
		  fileNo=$('#fileNo').val();
		  vendorName=$('#vendorName').val();
		  quotationOfItem=$('#quantumItem').val();
		  valueOfOrder=$('#valueOfSanction').val();
		  refOfGovtAuthority=$('#authorityLetter').val();
		  issueUnder= $('#ifa').val();
		  payingAgency= $('#payingAgency').val();
		  bookedBudget=$('#expenditure').val();
		  videNoteNumber=$('#videNote').val();
		  uoNumber=$('#uoNumber').val();
		  commWithSanction=$('#commSanction').val();
		  sanctionIssued=$('#cda').val();
		  totalAmount= $('#l1Cost').val();
		  totalAmountWords=$('#l1CostWord').val();
		  if (orderPurpose == null || orderPurpose == "") {
		         alert("Please enter mandatory fields");
		         flag=1;
		         return false;
		     }
		  if (fileNo == null || fileNo == "") {
		         alert("Please enter mandatory fields");
		         flag=1;
		         return false;
		     }
		  if (quotationOfItem == null || quotationOfItem == "") {
		         alert("Please enter mandatory fields");
		         flag=1;
		         return false;
		     }
		  if (valueOfOrder == null || valueOfOrder == "") {
		         alert("Please enter mandatory fields");
		         flag=1;
		         return false;
		     }
		  if (refOfGovtAuthority == null || refOfGovtAuthority == "") {
		         alert("Please enter mandatory fields");
		         flag=1;
		         return false;
		     }
		  if (issueUnder == null || issueUnder == "") {
		         alert("Please enter mandatory fields");
		         flag=1;
		         return false;
		     }
		  if (payingAgency == null || payingAgency == "") {
		         alert("Please enter mandatory fields");
		         flag=1;
		         return false;
		     }
		  if (videNoteNumber == null || videNoteNumber == "") {
		         alert("Please enter mandatory fields");
		         flag=1;
		         return false;
		     }
		  if (uoNumber == null || uoNumber == "") {
		         alert("Please enter mandatory fields");
		         flag=1;
		         return false;
		     }
		  if (commWithSanction == null || commWithSanction == "") {
		         alert("Please enter mandatory fields");
		         flag=1;
		         return false;
		     }
		  if (sanctionIssued == null || sanctionIssued == "Select") {
		         alert("Please enter mandatory fields");
		         flag=1;
		         return false;
		     }
		  var cda = $j('#cda').val();
	       if(cda=="Yes"){
	    	   var status= $j('#status').val();
	           if(status.toUpperCase() !== "Rejected".toUpperCase() && status.toUpperCase() !== "Saved".toUpperCase()){
	               
		  var filenameValue = $j("#fileUploadid").val();
		  if(filenameValue==""||filenameValue == null ){
			  alert("Please choose file");
			  return false;
		  } 
		  if(filenameValue!="" && filenameValue!=undefined){
				 if(validateFileExtension(filenameValue, "valid_msg", "Only pdf/image files are allowed ",
					      new Array("jpg","pdf","jpeg","gif","png")) == false)
					      {
					 		return false;
					 	   }
				
		  }
	         }
		    if(flag==1){
		    	return false;
		    } 
	       }
		  }
			$("#submitBudgetaryQuotation").submit();
			 setTimeout(function(){ 			 
				 $("#saveForm1").attr("disabled", "disabled");
				 $("#saveDraft").attr("disabled", "disabled");
			 }, 50);
		
	}
	 function isNumberKey(evt){
		    var charCode = (evt.which) ? evt.which : event.keyCode
		    		 if (charCode > 31 && (charCode < 48 || charCode > 57))
		    			        return false;
		    return true;
		}
	 
	 
     function getChooseFileOption(){
    	var status= $j('#status').val();
         var cda = $j('#cda').val();
         if(cda=="Yes"){
        	 $j('#upload').show();
        	 if(status.toUpperCase() === "Rejected".toUpperCase() || status.toUpperCase() === "Saved".toUpperCase())
                 
             $j('#downloadDoc').show();
         }else{
          	 $j('#upload').hide();
             $j('#downloadDoc').hide();
         }
         
     }
     
     function validateFileExtension(component,msg_id,msg,extns)
     {
        var flag=0;
        with(component)
        {
           var ext=component.substring(component.lastIndexOf('.')+1);
           for(i=0;i<extns.length;i++)
           {
              if(ext==extns[i])
              {
                 flag=0;
                 break;
              }
              else
              {
                 flag=1;
              }
           }
           if(flag!=0)
           {
              alert(msg);
             /*  component.value="";
              component.style.backgroundColor="#eab1b1";
              component.style.border="thin solid #000000";
              component.focus(); */
              return false;
           }
           else
           {
              return true;
           }
        }
     }
     
     function downloadFile(){
 		var ridcId=$('#doc').val();
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