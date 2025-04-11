<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Mobile Medical Unit- MMSSY</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>
<style>
a {
  color: blue;
}
</style>
<script type="text/javascript">
	<%String mmuId = "0";
	if (session.getAttribute("mmuId") != null) {
		mmuId = session.getAttribute("mmuId") + "";
	
	}
	
	String userId = "0";
	if (session.getAttribute("userId") != null) {
		userId = session.getAttribute("userId") + "";
	}
	String districtId = "0";
	if (session.getAttribute("distIdUsers") != null) {
		districtId = session.getAttribute("distIdUsers") + "";
		districtId = districtId.replace(",", "");
	}
	

	%>

	var $j = jQuery.noConflict();
	var user_id=0;
	 $j(document).ready(function()
	{	
		getVendorNameList();
		getVendorTypeList();
		$('#poDate').val(currentDateInddmmyyyy());
		user_id = "<%= userId %>";
	});
	 
	 
	 var itemIdPrescription= '';


	 var i=1;
	 var  j=1;
	 var record=1;
	 function addNomenclatureRow1() {
	 	record=record+1;
	 	$('#record').html(record);
	 	$('#records').html(" Records");
	 	
	     
	     i++;
	 	var aClone = $('#nomenclatureGrid>tr:last').clone(true)
	 	aClone.find(":input").val("");
	 	/* aClone.find("td:eq(0)").find(":input").prop('id', 'chkbox'+i+'');
	 	aClone.find('input[type="text"]').prop('id', 'nomenclature1'+i+'');	
	 	aClone.find("td:eq(9)").find(":input").prop('id', 'itemIdNom'+i+'');
	 	aClone.find("td:eq(10)").find(":input").prop('id', 'pvmsNo'+i+''); */
	 	aClone.find("td:eq(0)").find(":input").prop('id', 'nomenclature'+i+'');
	 	aClone.find("td:eq(1)").find(":input").prop('id', 'dispensingUnit'+i+'');
	 	aClone.find("td:eq(2)").find(":input").prop('id', 'requiredQty'+i+'');
	 	aClone.find("td:eq(3)").find(":input").prop('id', 'availableStock'+i+'');
	 	aClone.find("td:eq(4)").find(":input").prop('id', 'stockInDispencery'+i+'');
	 	//aClone.find("td:eq(5)").find(":input").prop('id', 'stockInStore'+i+'');
	 	aClone.find("td:eq(5)").find(":input").prop('id', 'remarks'+i+'');
	 	//aClone.find('input[type="text"]').prop('id', 'nomenclature'+i+'');
	 	aClone.find("td:eq(6)").find(":input").prop('id', 'itemIdNom'+i+'');
	 	aClone.find("td:eq(7)").find(":input").prop('id', 'pvmsNo'+i+'');
	 	aClone.find("td:eq(0)").find("div").find("div").prop('id', 'divIdPVMS' + i + '');
	 	aClone.clone(true).appendTo('#nomenclatureGrid');
	 	var val = $('#nomenclatureGrid>tr:last').find("td:eq(0)").find(":input")[0];
	 	//autocomplete(val, arryNomenclature);
	 }

	 function showLastRow(){
	 	 $('.scrollableDiv ').animate({ scrollTop: $('table').height()}, 300);
	 }
	 
	 var itemForwardedList = [];
	 function submitDoItemsAndGeneratePo(item){
		 var vendorType = $('#vendorTypeId').val();
		 var vendorName = $('#vendorNameId').val();
		 var rvNotes = $('#rvNotes').val();
		 console.log("rvNotes "+rvNotes);
		 if(vendorType == ''){
			 alert("Please select vendor type");
			 return;
		 }
		 
		 if(vendorName == ''){
			 alert("Please select vendor name");
			 return;
		 }
		 var checkFlag = false;
		 $('#nomenclatureGrid tr').each(function(i, el) {
				var $tds = $(this).find('td')
				var requiredQty = $tds.eq(2).find(":input").val();
				var approvedQty = $tds.eq(2).find(":input").val();
				var poQty = $tds.eq(2).find(":input").val();
				var unitRate =  $tds.eq(3).find(":input").val();
				var itemId = $tds.eq(6).find(":input").val();
				if(itemId == ''){
					alert("Please enter drug name");
					checkFlag = true;
					return false;
				}
				if(poQty == ''){
					alert("Please enter PO Qty");
					checkFlag = true;
					return false;
				}
				if(unitRate == ''){
					alert("Please enter unit rate");
					checkFlag = true;
					return false;
				}
				var input = {
						"requiredQty":requiredQty,
						"approvedQty":approvedQty,
						"poQty":poQty,
						"itemId":itemId,
						"unitRate":unitRate
				}
				itemForwardedList.push(input);
				console.log(JSON.stringify(itemForwardedList));
				
		});
		 
		 if(checkFlag){
			 return;
		 }
		 var params = {
				 "list":itemForwardedList,
				 "districtId":"<%= districtId %>",
				 "userId":"<%= userId %>",
				 "vendorNameId":vendorName,
				 "vendorTypeId":vendorType,
				 "rvNotes":rvNotes,
				 "indentFlag":"direct"
		 }
		 $(item).attr("disabled", true);	
		 $.ajax({
				type : "POST",
				contentType : "application/json",
				url : "submitDoItemsAndGeneratePo",
				data :JSON.stringify(params),
				dataType : 'json',
				timeout : 100000,
				success : function(res) {
					//alert(res.msg);
					if(res.status == true){					
						alert(res.msg+'S');
						document.addEventListener('click',function(e){
							    if(e.target && e.target.id== 'closeBtn'){
			   	   				 	window.location.reload();
							     }
						 });	
					}else{
						alert(res.msg);
						$(item).attr("disabled", false);	
					}
				},
				error : function(jqXHR, exception) {
					alert("Error occured while contacting the server");
					$(item).attr("disabled", false);	
				}
			});
		 
	 }
	 
		function preventDot2(){
			if(event.key==='.'){event.preventDefault();}
		}
		function preventDot3(){
			event.target.value = event.target.value.replace(/[^0-9]*/g,'');
		}
	 
	 function getVendorTypeList(){
		 $.ajax({
				type : "POST",
				contentType : "application/json",
				url : "getMasSupplierTypeList",
				data :JSON.stringify({}),
				dataType : 'json',
				timeout : 100000,
				success : function(res) {
					if(res.status == true){					
						var list = res.list;
						var typeDropDown = '';
						for(i=0;i<list.length;i++){
							typeDropDown += '<option value='+list[i].id+'>'+list[i].name+'</option>';
						}
						
						if(typeDropDown != ''){
							$('#vendorTypeId').append(typeDropDown);
						}
					}
				},
				error : function(jqXHR, exception) {
					alert("Error occured while contacting the server");
					$(item).attr("disabled", false);	
				}
			});
	 }
	 
	 function getVendorNameList(){
		 
		 var vendorTypeId = $('#vendorTypeId').val();
		 
		 var params = {
				 "supplierTypeId":vendorTypeId
		 }
		 
		 $.ajax({
				type : "POST",
				contentType : "application/json",
				url : "getMasSupplierListNew",
				data :JSON.stringify(params),
				dataType : 'json',
				timeout : 100000,
				success : function(res) {
					if(res.status == true){		
						$('#vendorNameId').find('option').not(':first').remove();
						var list = res.list;
						var typeDropDown = '';
						for(i=0;i<list.length;i++){
							typeDropDown += '<option value='+list[i].id+'>'+list[i].name+'</option>';
						}
						
						if(typeDropDown != ''){
							$('#vendorNameId').append(typeDropDown);
						}	
					}
				},
				error : function(jqXHR, exception) {
					alert("Error occured while contacting the server");
					$(item).attr("disabled", false);	
				}
			});
	 }
	 
	 var pvmsNo = '';
	 function populatePVMS(val, inc,item) {
	 	//alert("called");
	 	 $(item).closest('tr').find("td:eq(6)").find(":input").val("");
	 	if (val != "") {
	 		
	 		var index1 = val.lastIndexOf("[");
	 		var indexForBrandName = index1;
	 		var index2 = val.lastIndexOf("]");
	 		index1++;
	 		pvmsNo = val.substring(index1, index2);
	 		var indexForBrandName = indexForBrandName--;
	 		var brandName = val.substring(0, indexForBrandName);
	 		// alert("pvms no--"+pvmsNo)

	 		if (pvmsNo == "") {
	 			
	 			return false;
	 		} 
	 		else
	 		{
	 			//document.getElementById('pvmsNo' + inc).value = pvmsNo
	 			  var pvmsValue = '';
	 	     	  for(var i=0;i<autoVsPvmsNo.length;i++){
	 	     		 // var pvmsNo1 = data[i].pvmsNo;
	 	     		 var masItemIdValue= autoVsPvmsNo[i];
	 	     		 var pvmsNo1=masItemIdValue[1];
	 	     		
	 	     		  if(pvmsNo1 == pvmsNo){
	 	     			  pvmsValue = masItemIdValue[4];//data[i].dispUnit;
	 	     			  itemIdPrescription =masItemIdValue[0]; //data[i].itemId;
	 	     			  itemIds = itemIdPrescription;
	 	     			var checkCurrentNomRowId=$(item).closest('tr').find("td:eq(6)").find("input:eq(0)").attr("id");
	       			var checkCurrentNomRowVal=$(item).closest('tr').find("td:eq(6)").find("input:eq(0)").val();  
	 	     			$('#nomenclatureGrid tr').each(function(i, el) {
	 	     			   var $tds = $(this).find('td')
	 	  			       var itemIdCheck=  $($tds).closest('tr').find("td:eq(6)").find("input:eq(0)").attr("id");
	 	     			   var itemIdValue=$('#'+itemIdCheck).val();
	 	     			   var idddd =$(item).closest('tr').find("td:eq(6)").find("input:eq(0)").attr("id");
	 	     			   var currentidddd=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
	 	     			   var accId=$(item).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
	 	     			   //if(itemIds!="" &&  itemIdValue!="" && itemIdValue!="undefined" )
	 	     			   if(itemIdCheck!=checkCurrentNomRowId && itemIds==itemIdValue)	   
	  			           {
	 	     				 if(itemIds==itemIdValue){
	 	      			        $('#'+idddd).val("");
	 	      			        $('#'+currentidddd).val("");
	 	      			        $('#'+accId).val("");
	 	      			        alert("Drug Name is already added");
	 	      			        return false;
	 	     				   
	  			           }
	  			           }
	 	     			   else
	 	     			   {
	      				  $(item).closest('tr').find("td:eq(1)").find(":input").val(pvmsValue)
	 	     				  $(item).closest('tr').find("td:eq(6)").find(":input").val(itemIds)
	 	     				  //$(item).closest('tr').find("td:eq(7)").find(":input").val(pvmsNo)
	 	     			   }	   
	 	     				
	 	     			}); 
	 	     		  }
	 	     	  }	
	 	     	
	            
	 			return true;

	 		}

	 	} 
	 	else
	 	{
	 		return false;
	 	}
	 }
	 
	 function isNumberKey(evt){
		    var charCode = (evt.which) ? evt.which : event.keyCode
		    if (charCode > 31 && (charCode < 48 || charCode > 57))
		        return false;
		    return true;
		}
	 
	 function removeRowIndent(obj){
			var rowCount = $('#nomenclatureGrid tr').length;
			if(rowCount!==1){
			var r = confirm("Do you want to delete the record?");
			if (r == true) {
					$(obj).closest('tr').remove();
					record=record-1;
					
					if(record==1)
						$('#records').html(" Record");
						$('#record').html(record);
			}
				
			 else {
				
				  return false;
			 }
			} else {
				alert("Atleast one row should be there");
			  return false;
			}
			
		}
	 
	 function getAvailableStock(val, inc,item) {
			/* var lpRate=0;
			var itemId=$(item).closest('tr').find("td:eq(6)").find(":input").val();
			if (itemId != "") {
				if (val != "") {
				var itemId={"itemId":itemId};
			jQuery.ajax({
			 	crossOrigin: true,
			    method: "POST",			    
			    crossDomain:true,
			    url: "getAvailableStock",
			    data:JSON.stringify(itemId),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	if(result.status==1){
			    		
			    			$(item).closest('tr').find("td:eq(3)").find(":input").val(result.availableStock);
			    			$(item).closest('tr').find("td:eq(4)").find(":input").val(result.dispStock);
			    			//$(item).closest('tr').find("td:eq(5)").find(":input").val(result.storeStock);
			    		
			    	}
			    	else if(result.status==0){
			    		alert(result.err_mssg);
			    	}
			    	
			    	
			    },
			    error: function(result) {
		         alert("An error has occurred while contacting the server");
		     }
			    
			});
			}
			} */
		}
	 
</script>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">Direct PO</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								
								<div class="">
									<div class="clearfix">
										<!-- <div style="float: left">
											<table class="tblSearchActions" cellspacing="0"
												cellpadding="0" border="0">
												<tr>
													<td class="SearchStatus" style="font-size: 15px;"
														align="left">Search Results</td>
													<td></td>
												</tr>
											</table>											
										</div>

										<div style="float: right">
											<div id="resultnavigation"></div>
										</div> -->

										<div class="row">

											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">Vendor Type</label>
													</div>
													<div class="col-md-7">
														<select class="form-control" id="vendorTypeId" onchange="getVendorNameList()">
															<option value="">Select</option>
														</select>
													</div>
												</div>
											</div>

											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">Vendor Name</label>
													</div>
													<div class="col-md-7">
														<select class="form-control" id="vendorNameId">
															<option value="">Select</option>
														</select>
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">PO Date</label>
													</div>
													<div class="col-md-7">
														<input readonly type="text" class="form-control" id="poDate" name="poDate" />
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-4">
											<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">RV Notes</label>
													</div>
													<div class="col-md-7">
														<textarea name="rvNotes" tabindex="2"
															id="rvNotes" placeholder="" class="form-control" ></textarea>
													</div>
												</div>
												</div>
										</div>

										<div class="table-responsive " id="">
											<table
												class="table table-striped table-hover table-bordered " id="campTable">
												<thead class="bg-success" style="color: #fff;">
													<tr>
														<th>Drug Name/Drug Code</th>
														<th>A/U</th>
														<th>PO Quantity</th>
														<th>Unit Rate</th>
														<th>Add</th>
														<th>Delete</th>
													</tr>
												</thead>
												<tbody id="nomenclatureGrid">
													<td>
														<div class="autocomplete forTableResp">
															<input type="text" value="" autocomplete="never"
																spellcheck="false" id="nomenclature1" size="77"
																name="nomenclature" class="form-control width330"
																 onKeyUp="getNomenClatureList(this,'populatePVMS','opd','getMasStoreItemList','indent')" />
														<div id="divIdPVMS" class="autocomplete-itemsNew"></div>
														</div>
													</td>
													<td><input type="text" name="accountingUnit1"
														tabindex="1" id="dispensingUnit1" 
														readonly="readonly" validate="AU,string,no"
														class="form-control" />
													</td>
													<td><input type="text" name="poQty" tabindex="1"
														autocomplete="nope" spellcheck="false" value=""
														id="poQty"   class="form-control" onkeypress="return isNumberKey(event)" />
													</td>
													<td><input type="text" name="unitRate" tabindex="1"
														autocomplete="nope" spellcheck="false" value=""
														id="unitRate"   class="form-control" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" />
													</td>
													<td>

															<button type="button" class="btn btn-primary buttonAdd noMinWidth"
																name="button" button-type="add" value=""
																onclick="addNomenclatureRow1();showLastRow();" tabindex="1"></button>

														</td>
														<td>


															<button type="button" class="buttonDel  btn btn-danger noMinWidth m-r-20"
																name="button" button-type="delete" value="" tabindex="1"
																onclick="removeRowIndent(this);"></button>

														</td>
														<td style="display: none;"><input type="hidden"
														value="" tabindex="1" id="itemIdNom1" size="77"
														name="itemIdNom" /></td>
												</tbody>
											</table>
										</div>
										
										<div class="row">
											<div class="col-md-12 m-t-10 text-right">
												<button type="button" id="submit_btn" class="btn btn-primary" onclick="submitDoItemsAndGeneratePo(this)">Submit</button>
											
											</div>
										</div>
									</div>
								</div>
								
								

							</div>
						</div>
						<!-- end card -->
					</div>
					<!-- end col -->
				</div>
				<!-- end row -->

			</div>
			<!-- container -->
			<!-- content -->
		</div>
	</div>
	<!-- END wrapper -->

	<!-- jQuery  -->


</body>

</html>