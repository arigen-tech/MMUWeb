<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.mmu.web.utils.HMSUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@include file="..//view/leftMenu.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Indian Coast Guard</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>

<%

	String mmuId = "0";
	if (session.getAttribute("mmuId") != null) {
		mmuId = session.getAttribute("mmuId") + "";
	}
	String userId = "0";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	String departmentId = HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim();
	String departmentName="";
	SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); 

	Calendar c = Calendar.getInstance(); 
	Date currentDate1 = c.getTime();
	String currentDate=formatter.format(currentDate1); 

	//c.set(Calendar.DATE, 01);
	Date startDate1 = c.getTime();

	//c.set(Calendar.DATE, 30);
	Date enddate1 = c.getTime();
	String startDate=formatter.format(startDate1); 
	String enddate=formatter.format(enddate1); 	
	
	String indentCoMId = request.getParameter("indentCoMId");
	String indentNo = request.getParameter("indentNo");
	String indentDate = request.getParameter("indentDate");
	String cityName = request.getParameter("cityName");
	String createdBy = request.getParameter("createdBy");
%>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">


		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">Indent Approval (DO)</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
										<form:form name="submitIndentDispencery" id="submitIndentDispencery" autocomplete="off">
																		
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Indent No</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="indentNo" name="indentNo" value="<%= request.getParameter("indentNo") %>" readonly="readonly"/>
												</div>
											</div>
										</div>

										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Indent Date</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="indentDate" name="indentDate" value="<%= request.getParameter("indentDate") %>" readonly="readonly" />
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">City Name</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="cityName" name="cityName" value="<%= cityName %>" readonly="readonly" />
												</div>
											</div>
										</div>

										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Created By</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="createdBy" name="createdBy" value="<%= createdBy %>" readonly="readonly"/>
												</div>
											</div>
										</div>

										<!--<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">From Department</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="fromDept" name="fromDept" readonly="readonly"/>
												</div>
											</div>
										</div> -->
										
									</div>
									
									<div class="row">
										<div class="col-12">
											<span class="searchText" id="record">1</span><span class="searchText" id="records"> Record</span>
										</div>
									</div>
									
									<div class="scrollableDiv m-b-10">
									<table
										class="table table-hover table-striped table-bordered m-t-10">
										<thead class="bg-primary">
											<tr>
												<!-- th>Delete</th>
												<th>S.No</th> -->
												<th>Drug Name/Drug Code</th>
												<th>A/U</th>
												<th>Required Qty</th>
												<th>Available Stock</th>
												<th>Approved Qty</th>
												<!-- <th>Stock in Dispensary</th>
												<th>Stock in Medical Store</th> -->
												 <c:if test="${status=='Y'}">
												<th>Add</th>
												<th>Delete</th>
												</c:if>
												
											</tr>
										<tbody id="nomenclatureGrid">
												<tr>
													<!-- <td><input class="checkboxes" type="checkbox" id="indentIdT1"
														name="indentId" value=""></td>
													<td>1</td> -->

													<c:if test="${status=='Y'}">
													<td>
														<div class="autocomplete forTableResp">
															<input type="text" value="" autocomplete="never"
																spellcheck="false" id="nomenclature1" size="77"
																name="nomenclature" class="form-control border-input width330"
																 onKeyUp="getNomenClatureList(this,'populatePVMS','opd','getMasStoreItemList','indent')" />
																<div id="divIdPVMS" class="autocomplete-itemsNew"></div>
														
														</div>
													</td>
													</c:if>
													<c:if test="${status!='Y'}">
													<td>
														<div class="autocomplete">
															<input type="text" value="" autocomplete="never"
																spellcheck="false" id="nomenclature1" size="77" readonly="readonly"
																name="nomenclature" class="form-control border-input width330"
																onblur="populatePVMS(this.value,'1',this),getAvailableStock(this.value,'1',this);;" />

														</div>
													</td>
													</c:if>

													<td><input type="text" name="accountingUnit1"
														tabindex="1" id="dispensingUnit1" 
														readonly="readonly" validate="AU,string,no"
														class="form-control" /></td>

													<c:if test="${status=='Y'}">
													<td><input type="text" name="requiredQty" tabindex="1"
														autocomplete="nope" spellcheck="false" value=""
														id="requiredQty1" size="5" maxlength="5" class="form-control" onkeypress="return isNumberKey(event)" /></td>
													</c:if>
													
													<c:if test="${status!='Y'}">
													<td><input type="text" name="requiredQty" tabindex="1"
														autocomplete="nope" spellcheck="false" value="" readonly="readonly"
														id="requiredQty1" size="5" maxlength="5" class="form-control" onkeypress="return isNumberKey(event)" /></td>
													</c:if>
													<td><input type="text" id="availableStock1"
														readonly="readonly" name="availableStock"
														class="form-control" /></td>
													<td><input type="text" id="approvedQty"
															name="approvedQty"
														class="form-control" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" onkeydown="if(event.key==='.'){event.preventDefault();}"  oninput="event.target.value = event.target.value.replace(/[^0-9]*/g,'');"/></td>

													<td style="display: none;"><input type="hidden" name="stockInDispencery" tabindex="1"
														autocomplete="nope" spellcheck="false" id="stockInDispencery1"
														readonly="readonly" size="5" maxlength="3"
														class="form-control" /></td>

													<td style="display: none;"><input type="hidden" name="stockInStore" tabindex="1"
														id="stockInStore1" size="5" validate="total,num,no"
														readonly="readonly" class="form-control" /></td>

													<c:if test="${status=='Y'}">
													<td style="display: none;"><input type="hidden" name="remarks1" tabindex="1"
														id="remarks1" placeholder="" class="form-control"></td>
													</c:if>

													<c:if test="${status!='Y'}">
													<td style="display: none;"><input type="hidden" name="remarks1" tabindex="1" readonly="readonly"
														id="remarks1" placeholder="" class="form-control" ></td>
													</c:if>


													<td style="display: none;"><input type="hidden"
														value="" tabindex="1" id="itemIdNom1" size="77"
														name="itemIdNom1" /></td>

													<td style="display: none;"><input type="hidden"
														name="pvmsNo1" tabindex="1" id="pvmsNo1" size="10"
														readonly="readonly" /></td>
														
													<td style="display: none;"><input type="hidden"
														name="indentId1" tabindex="1" id="indentId1" size="10"
														readonly="readonly" /></td>
														
													<td style="display: none;"><input type="hidden"
														name="indentMid1" tabindex="1" id="indentMid1" size="10"
														readonly="readonly" /></td>
														<c:if test="${status=='Y'}">
														<td>

															<button type="button" class="btn btn-primary buttonAdd noMinWidth"
																name="button" button-type="add" value=""
																onclick="addNomenclatureRow1();showLastRow();" tabindex="1"></button>

														</td>
														<td>


															<button type="button" class="buttonDel  btn btn-danger noMinWidth m-r-10"
																name="button" button-type="delete" value="" tabindex="1"
																onclick="removeRowIndent(this);"></button>

														</td>
														</c:if>
												</tr>

											</tbody>
											
										</table>
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
										
									<div class="row">
										<div class="col-md-12 text-right">
													<input type="button" class="btn  btn-primary"
														name="approve" 
														value="Submit" id="saveForm1" tabindex="1" onclick="submitForm(this);"/>
														 <a  class="buttonDel  btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/dispencery/getIndentApprovalListForDO">Close</a> 
														<%-- <a  class="buttonDel  btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/approve/approveProcess">Close</a> --%>
											
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
	//scrollbar script
$(function(){
/* var winHeight = $(window).height();

$('.scrollableDiv').css({'height':winHeight-630}); */

// add custom scroll to sscrollableDiv class
    $('.scrollableDiv').slimscroll({
        height: 'inherit',
        position: 'right',
        color: '#9ea5ab',
        touchScrollStep: 50
    });
})

</script>

<script>

var user_id = <%= userId %>
var autoVsPvmsNo = '';
var data='';
var itemIds = '';
var record=0;
$j(document).ready(
  function getMastStoreItem(){
	  
	//if department not in session
	   	if(<%= departmentId %>!=0){
				$j("#submitIndentDispencery :input").attr("disabled", false);
				$("#saveForm1").attr("disabled", false);
				}else{
				alert("Select the department");
				$j("#submitIndentDispencery :input").attr("disabled", true);
				return false;
			}
   var dataList = ${data};
          var resultList= dataList.data;
          var listLength = resultList.length;
          var count=dataList.count;
          record=1;
           var j=0;
         
        	 
    	 for(item in resultList){
    		 j++;
    		 if(item==1){
    			   /* $j('#indentNo').val(resultList[item].indentNo);
    		  	   $j('#fromDept').val(resultList[item].fromDept);
    		  	   $j('#toDept').val(resultList[item].toDept);
    		  	   $j('#indentDate').val(resultList[item].indentdate);
    		  	   $j('#createdBy').val(resultList[item].createdBy);
    		  	   $j('#toDeptName').val(resultList[item].toDeptId); */
    		  	
    		 }
    		 $('#nomenclature'+j).val(resultList[item].nomenclature+'['+resultList[item].pvmsNo+']');
    		 $('#dispensingUnit'+j).val(resultList[item].au);
    		 $('#requiredQty'+j).val(resultList[item].requiredQty);
    		 $('#availableStock'+j).val(resultList[item].availableStock);
    		 //$('#stockInDispencery'+j).val(resultList[item].stockDisp);
    		 //$('#stockInStore'+j).val(resultList[item].stockStore);
    		 //$('#remarks'+j).val(resultList[item].remark);
    		 $('#itemIdNom'+j).val(resultList[item].itemId);
    		 //$('#pvmsNo'+j).val(resultList[item].pvmsNo);
    		 $('#indentId'+j).val(resultList[item].storeCoTId);
    		 $('#indentIdT'+j).val(resultList[item].storeCoTId);
    		 $('#indentMid'+j).val(resultList[item].storeCoMId);
    		 $('#record').html(record);
    		 if(j < listLength)
    		 addNomenclatureRow1();
         }
    	 
		
  });

</script>

<script type="text/javascript"  >
var arryNomenclature= new Array();
var val=$('#nomenclatureGrid').children('tr:first').children('td:eq(0)').find(':input')[0];
var itemIdPrescription= '';

var i=1;
function addNomenclatureRow1() {
	record=record+1;
	$('#record').html(record);
	$('#records').html(" Records");
		
    i++;
	var aClone = $('#nomenclatureGrid>tr:last').clone(true)
	aClone.find(":input").val("");
	aClone.find("td:eq(0)").find(":input").prop('id', 'nomenclature'+i+'');
	aClone.find("td:eq(1)").find(":input").prop('id', 'dispensingUnit'+i+'');
	aClone.find("td:eq(2)").find(":input").prop('id', 'requiredQty'+i+'');
	aClone.find("td:eq(3)").find(":input").prop('id', 'availableStock'+i+'');
	/* aClone.find("td:eq(4)").find(":input").prop('id', 'stockInDispencery'+i+'');
	aClone.find("td:eq(5)").find(":input").prop('id', 'stockInStore'+i+''); */
	aClone.find("td:eq(7)").find(":input").prop('id', 'remarks'+i+'');
	aClone.find("td:eq(8)").find(":input").prop('id', 'itemIdNom'+i+'');
	aClone.find("td:eq(9)").find(":input").prop('id', 'pvmsNo'+i+'');
	aClone.find("td:eq(10)").find(":input").prop('id', 'indentId'+i+'');
	aClone.find("td:eq(11)").find(":input").prop('id', 'indentMid'+i+'');
	aClone.find("td:eq(0)").find("div").find("div").prop('id', 'divIdPVMS' + i + '');
	aClone.clone(true).appendTo('#nomenclatureGrid');
	var val = $('#nomenclatureGrid>tr:last').find("td:eq(0)").find(":input")[0];
}

function showLastRow(){
	 $('.scrollableDiv ').animate({ scrollTop: $('table').height()+10 }, 300);
}

var pvmsNo = '';

 
 function populatePVMS(val, inc,item) {
		//alert("called");
		 $(item).closest('tr').find("td:eq(8)").find(":input").val("");
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
				document.getElementById('pvmsNo' + inc).value = pvmsNo
				  var pvmsValue = '';
		     	  for(var i=0;i<autoVsPvmsNo.length;i++){
		     		 // var pvmsNo1 = data[i].pvmsNo;
		     		 var masItemIdValue= autoVsPvmsNo[i];
		     		 var pvmsNo1=masItemIdValue[1];
		     		
		     		  if(pvmsNo1 == pvmsNo){
		     			  pvmsValue = masItemIdValue[4];//data[i].dispUnit;
		     			  itemIdPrescription =masItemIdValue[0]; //data[i].itemId;
		     			  itemIds = itemIdPrescription;
		     			var checkCurrentNomRowId=$(item).closest('tr').find("td:eq(8)").find("input:eq(0)").attr("id");
	      			var checkCurrentNomRowVal=$(item).closest('tr').find("td:eq(8)").find("input:eq(0)").val();  
		     			$('#nomenclatureGrid tr').each(function(i, el) {
		     			   var $tds = $(this).find('td')
		  			       var itemIdCheck=  $($tds).closest('tr').find("td:eq(8)").find("input:eq(0)").attr("id");
		     			   var itemIdValue=$('#'+itemIdCheck).val();
		     			   var idddd =$(item).closest('tr').find("td:eq(8)").find("input:eq(0)").attr("id");
		     			   var currentidddd=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
		     			   var accId=$(item).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
		     			   //if(itemIds!="" &&  itemIdValue!="" && itemIdValue!="undefined" )
		     			   if(itemIdCheck!=checkCurrentNomRowId && itemIds==itemIdValue)	   
	 			           {
		     				 if(itemIds==itemIdValue){
		      			        $('#'+idddd).val("");
		      			        $('#'+currentidddd).val("");
		      			        $('#'+accId).val("");
		      			        alert("Nomenclature is already added");
		      			        return false;
		     				   
	 			           }
	 			           }
		     			   else
		     			   {
	     				  $(item).closest('tr').find("td:eq(1)").find(":input").val(pvmsValue)
		     				  $(item).closest('tr').find("td:eq(8)").find(":input").val(itemIds)
		     				  $(item).closest('tr').find("td:eq(9)").find(":input").val(pvmsNo)
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

function submitForm(item) {
	  var remarks = $j("#remark").val();
	  var action = $j("#action").val();
	  
	  var flag = false;
	  var dtList = [];
	  $("#nomenclatureGrid tr").each(function () {
		 var approvedQty = $(this).find('td:eq(4)').find(':input').val();
		 var reqQty = $(this).find('td:eq(2)').find(':input').val();
		 var dtId = $(this).find('td:eq(10)').find(':input').val();
		 var storeCoMId = $(this).find('td:eq(11)').find(':input').val();
		 
	     if(approvedQty == ''){
	    	 alert("Please enter approved quantity");
		        flag= true;
		        return false;
	     }
	     console.log("approvedQty "+approvedQty+ " reqQty"+reqQty)
	     if(parseInt(approvedQty) > parseInt(reqQty)){
	    	 alert("Approved qty cannot be greater than required qty");
	    	 flag= true;
		        return false;
	     }
	     
	     var input = {
	    		 "approvedQty":approvedQty,
	    		 "dtId":dtId
	     };
	     dtList.push(input)
	  });
	  
	  if(flag){
		  return;
	  }
	    if (action == null || action == 0) {
	        alert("Please select Action");
	        return false;
	    }
	 
		var params = {
				"storeCoMId":"<%= indentCoMId %>",
				"remarks":remarks,
				"dtList":dtList,
				"userId":"<%= userId %>"
		}
		
		console.log("input are "+JSON.stringify(params));
	//	$j("#saveForm1").attr("disabled", true);
		$j(item).attr("disabled", false);
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "updateIndentDispenceryByDO",
		    data:JSON.stringify(params),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	if(result.status == true){
		    		$j("#saveForm1").attr("disabled", true);
		    		//approveIndentDispenceryByCO
		    		alert(result.msg+'S');
					document.addEventListener('click',function(e){
						    if(e.target && e.target.id== 'closeBtn'){
		   	   				 	//window.location.reload();
		   	   					window.location = "indentSubmitByDO?indentMId="+<%= indentCoMId %>+"";
						     }
					 });	
		    	}
		    	else{
		    		alert(result.msg);
		    		$j("#saveForm1").attr("disabled", false);
		    		$j(item).attr("disabled", false);
		    	}
		    },
		    error: function(result) {
		    	$j("#saveForm1").attr("disabled", false);
		    	$j(item).attr("disabled", false);
	         alert("An error has occurred while contacting the server");
	     }
		    
		});
	
}
function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

function removeRowIndent(obj){
	
 var indentId=jQuery(obj).closest("tr").find("td:eq(10)").find(":input").val();
		var aParam =[];
		    
	var rowCount = $('#nomenclatureGrid tr').length;
	if(rowCount!==1){
	var r = confirm("Do you want to delete the record?");
	if (r == true) {
		 if(indentId!==""){
		     aParam.push(indentId);
		     if(aParam.length > 0){
		 		var param={"aParam":aParam};
		 		 // alert(JSON.stringify(param)); 	
		 	jQuery.ajax({
		 	 	crossOrigin: true,
		 	    method: "POST",			    
		 	    crossDomain:true,
		 	    url: "deleteIndentItems",
		 	    data: JSON.stringify(param),
		 	    contentType: "application/json; charset=utf-8",
		 	    dataType: "json",
		 	    success: function(result){
		 	    	if(result.status==1){
		 	    		$(obj).closest('tr').remove();
		 	    		
		 	    	}
		 	    	else if(result.status==0){
		 	    		alert(result.msg);
		 	    	}
		 	    	
		 	    },
		 	    error: function(result) {
		             alert("An error has occurred while contacting the server");
		         }
		 	    
		 	});
		 	
		     }
		 }	
			$(obj).closest('tr').remove();
			record=record-1;
		 }
	
		
	 else {
		
		  return false;
	 }
	} else {
		alert("Atleast one row should be there");
	  return false;
	}
	//$('#record').html(record);
	if(record==1)
		$('#records').html(" Record");
		$('#record').html(record);
}

function getAvailableStock(val, inc,item) {
	var lpRate=0;
	var itemId=$(item).closest('tr').find("td:eq(8)").find(":input").val();
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
	    			$(item).closest('tr').find("td:eq(5)").find(":input").val(result.dispStock);
	    			$(item).closest('tr').find("td:eq(6)").find(":input").val(result.storeStock);
	    		
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
	}
}
</script>
</html>