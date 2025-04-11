<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<head>
<%
	String hospitalId = "1";
	if (session.getAttribute("hospital_id") != null) {
		hospitalId = session.getAttribute("hospital_id") + "";
	}
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	long departmentId = 0;
	String departmentName="";
		  if (session.getAttribute("department_id") != null) {
		   departmentId = Long.parseLong(session.getAttribute("department_id").toString());
		  }
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
	
%>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<title>create indent</title>
<!--   <link href="/AshaWeb/resources/css/stylecommon.css" rel="stylesheet" type="text/css" /> -->


<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/stores.js"></script> 
</head>

<%
	int i = 1;
%>

<body>
 <p align="center" id="messageId" style="color:green; font-weight: bold;" >${message}</p>
	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext"> BUDGETARY APPROVAL(CO)</div>

					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<form:form name="submitBudgetary" id="submitBudgetary" method="post"
										action="${pageContext.request.contextPath}/lpprocess/coBudgetaryApproval" autocomplete="off">
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-md-4 col-form-label"> Requested On</label>
												<div class="col-md-7">
													<!-- <input type="date" class="form-control custom_date" name="fromDate" id="fromDate"> 
													<input  type="text" class="form-control custom_date calDate"  name="fromDate" id="fromDate" placeholder="DD/MM/YYYY" validate="To Date,string,yes"/> -->
													<div class="dateHolder">
														<input type="text"
															class="custom_date datePickerInput form-control"
															name="lpDate" id="lpDate" placeholder="DD/MM/YYYY"
															validate="From Date,string,yes" value="" maxlength="10"/>
													</div>
													 <input  type="hidden"  id="moApproveDate" name="moApproveDate" value=""  maxlength="10" />
												</div>
											</div>
										</div>
										
										
										<div class="col-md-4" id="divApprovalDate" style="display: none">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Approval On<span class="text-red">*</span></label>
												</div>
												<div class="col-md-7">
													<div class="dateHolder">
														<input type="text" class="noFuture_dateStore datePickerInput form-control minwidth120"
														placeholder="DD/MM/YYYY" value="" maxlength="10" id="approvalDateOn" name="approvalDateOn" validate="Approval Date,date,no"/>
													</div> 
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-md-4 col-form-label"> Created By</label>
												<div class="col-md-7">
													<input type="text" class="form-control" id="createdBy" name="createdBy" readonly="readonly"/>
												
												</div>
											</div>
										</div>
										
									</div>
									
									<div class="row">
									<div class="col-12">
										<span class="searchText" id="record">1</span><span class="searchText" id="records"> Record</span>
									</div>
											
									</div>
									<div class="scrollableDiv m-b-10">

										<table class="table table-hover table-striped table-bordered"
											align="center" cellpadding="0" cellspacing="0"
											id="dgTreatmentGrid">
											<tr>
												<th>Nomenclature/PVMS No.</th>
												<th>A/U</th>
												<th>Required Quantity</th>
												<th>Last LP Unit Rate</th>
												<th>Item Value</th>
												<th>Add</th>
												<th>Delete</th>

											</tr>
											<tbody id="nomenclatureGrid">
												<tr>
													<!-- <td><input class="checkboxes" type="checkbox"
														name="chkbox" value=""></td> -->
													<!-- <td>1</td> -->

													<td>
														<div class="autocomplete forTableResp">
															<input type="text" value="" autocomplete="never"
																spellcheck="false" id="nomenclature1" size="77"
																name="nomenclature" class="form-control border-input width330"
																onKeyUp="getNomenClatureList(this,'populatePVMS','opd','getMasStoreItemList','budgetary')" />
																<div id="divIdPVMS" class="autocomplete-itemsNew"></div>
														
														</div>
													</td>

													<td><input type="text" name="accountingUnit1"
														tabindex="1" id="dispensingUnit1" 
														readonly="readonly" validate="AU,string,no"
														class="form-control" /></td>

													<td><input type="text" name="requiredQty" tabindex="1"
														autocomplete="nope" spellcheck="false" value=""
														id="requiredQty1"   class="form-control" onkeypress="return isNumberKey(event)" onblur="calculateAmount('1')"/></td>

													<td><input type="text" id="lpunitrate1"
														 name="lpunitrate"  onkeypress="return isNumberKey(event)"
														class="form-control" onblur="calculateAmount('1')"/></td>
													<td><input type="text" id="itemValue1"
														 name=""itemValue"" readonly="readonly"
														class="form-control" /></td>
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
														
														<td>

															<button type="button" class="btn btn-primary buttonAdd noMinWidth"
																name="button" id="btnAdd" button-type="add" value=""
																onclick="addNomenclatureRow1();showLastRow();" tabindex="1"></button>

														</td>
														<td>


															<button type="button" class="buttonDel  btn btn-danger noMinWidth"
																name="button" id="btnDel" button-type="delete" value="" tabindex="1"
																onclick="removeRowIndent(this);"></button>

														</td>
												</tr>

											</tbody>
											<tr>
										</table>
									</div>
									<div class="row">
										<div class="col-md-4 offset-md-8">
											<div class="form-group row">
												<label class="col-md-4 col-form-label">Approx Cost</label>
												<div class="col-md-8">
													<input type="text" id="approxCost" readonly="readonly" name="approxCost"
														class="form-control" />
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
														<textarea class="form-control" rows="2" name="approvalRemark" id="remark" maxlength="100"></textarea>
													</div>
												</div>
											</div>									
										</div>
										<div class="row">
										<div class="col-md-12 text-right">
													<input type="submit" class="btn  btn-primary"
														name="approve" 
														value="Submit" id="saveForm1" tabindex="1" onclick="return submitForm();"/>
														<a  class="buttonDel  btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/lpprocess/budgetaryApprovalListForCO">Close</a>
											
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
<script>
	//scrollbar script
$(function(){
/* var winHeight = $(window).height();

$('.scrollableDiv').css({'height':winHeight-420}); */

// add custom scroll to sscrollableDiv class
    $('.scrollableDiv').slimscroll({
        height: 'inherit',
        position: 'right',
        color: '#9ea5ab',
        touchScrollStep: 50
    });
    
    
   
});

</script>

<script>
var user_id = <%= userId %>
var autoVsPvmsNo = '';
var data='';
var itemIds = '';
var record=1;
var lpFlag='';
$j(document).ready(
  function getMastStoreItem(){
	//if department not in session
	   	if(<%= departmentId %>!=0){
				$j("#submitBudgetary :input").attr("disabled", false);
				$("#saveForm1").attr("disabled", false);
				}else{
				alert("Select the department");
				$j("#submitBudgetary :input").attr("disabled", true);
				return false;
			}  
var dataList = ${data};
var resultList= dataList.data;
var count=dataList.count;
record=1;
 var j=0;

for(item in resultList){
	 if(item==1){
		   $j('#lpDate').val(resultList[item].reqDate);
	  	   $j('#createdBy').val(resultList[item].createdBy);
	  	   $('#approxCost').val(resultList[item].approxCost);
	  	   $('#moApproveDate').val(resultList[item].moApproveDate);
	 	
	  	  lpFlag= resultList[item].lpTypeFlag;
	  	   if(lpFlag=='B'){
	  		 $j("#divApprovalDate").show();
	  	   }else{
	  		 $j("#divApprovalDate").hide();
	  	   }
	  	 
	  	  	 }
	 j++;
	 $('#nomenclature'+j).val(resultList[item].NomPvmsNo);
	 $('#dispensingUnit'+j).val(resultList[item].accountingUnit);
	 $('#requiredQty'+j).val(resultList[item].requiredQty);
	 $('#itemIdNom'+j).val(resultList[item].itemId);
	 $('#pvmsNo'+j).val(resultList[item].pvmsNo);
	 $('#lpunitrate'+j).val(resultList[item].lpunitrate);
	 $('#budgetaryMId'+j).val(resultList[item].budgetaryMId);
	 $('#budgetaryTId'+j).val(resultList[item].id);
	 $('#itemValue'+j).val(resultList[item].totalCost);
	 if(lpFlag=='B'){
		 $j("#nomenclature"+j).prop("readonly", true);
		 $j("#dispensingUnit"+j).prop("readonly", true);
		 $j('#requiredQty'+j).prop("readonly", true);
		 $j("#btnAdd").prop("disabled", true);
		 $j("#btnDel").prop("disabled", true);
	 }
	 $('#record').html(record);
		
	 if(j!==count)
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
aClone.find("td:eq(3)").find(":input").prop('id', 'lpunitrate'+i+'');
aClone.find("td:eq(4)").find(":input").prop('id', 'itemValue'+i+'');
aClone.find("td:eq(5)").find(":input").prop('id', 'itemIdNom'+i+'');
aClone.find("td:eq(6)").find(":input").prop('id', 'pvmsNo'+i+'');
aClone.find("td:eq(7)").find(":input").prop('id', 'budgetaryMId'+i+'');
aClone.find("td:eq(8)").find(":input").prop('id', 'budgetaryTId'+i+'');
aClone.find("td:eq(0)").find("div").find("div").prop('id', 'divIdPVMS' + i + '');
  var  requiredQtyData ='';
  requiredQtyData +='<input type="text" name="requiredQty" tabindex="1"';
  requiredQtyData +='autocomplete="nope" spellcheck="false" value=""';
  requiredQtyData +='id="requiredQty'+i+'"   class="form-control" onkeypress="return isNumberKey(event)" onblur="calculateAmount('+i+')"/>';

  
   
  var  lpunitrateData1 ='';
  lpunitrateData1 +='<input type="text" id="lpunitrate'+i+'"  name="lpunitrate"';
  lpunitrateData1 +='autocomplete="nope" spellcheck="false" value=""';
  lpunitrateData1 +='class="form-control" onkeypress="if(isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" onblur="calculateAmount('+i+')"/>';

   aClone.find("td:eq(2)").html(requiredQtyData);
  aClone.find("td:eq(3)").html(lpunitrateData1);
//aClone.find("td:eq(1)").html(i);
//aClone.find("option[selected]").removeAttr("selected")
aClone.clone(true).appendTo('#nomenclatureGrid');
var val = $('#nomenclatureGrid>tr:last').find("td:eq(0)").find(":input")[0];

}

function showLastRow(){
	 $('.scrollableDiv ').animate({ scrollTop: $('table').height()}, 300);
}


var pvmsNo = '';
function populatePVMS(val, inc,item) {
	//alert("called");
	 $(item).closest('tr').find("td:eq(5)").find(":input").val("");
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
	     			var checkCurrentNomRowId=$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
      			var checkCurrentNomRowVal=$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").val();  
	     			$('#nomenclatureGrid tr').each(function(i, el) {
	     			   var $tds = $(this).find('td')
	  			       var itemIdCheck=  $($tds).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
	     			   var itemIdValue=$('#'+itemIdCheck).val();
	     			   var idddd =$(item).closest('tr').find("td:eq(5)").find("input:eq(0)").attr("id");
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
	     				  $(item).closest('tr').find("td:eq(5)").find(":input").val(itemIds)
	     				  $(item).closest('tr').find("td:eq(6)").find(":input").val(pvmsNo)
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



function submitForm() {
	 var remark = $j("#remark").val();
	 var action = $j("#action").val();
	 
	 var approvalDateOn = $j("#approvalDateOn").val();
	 if(lpFlag=='B' && approvalDateOn==""){
		 alert("Please fill the approval date");
		 return false;
	 }
	 
	 var rows = document.getElementById("nomenclatureGrid").getElementsByTagName("tr").length;
	  var flag=0;
	  $("#nomenclatureGrid tr").each(function () {
	 	 var nomenclature=$(this).find('td:eq(0)').find(':input').val();
		 var reqQty=$(this).find('td:eq(2)').find(':input').val();
		 var itemId=$(this).find('td:eq(5)').find(':input').val(); 
			 if (nomenclature == null || nomenclature == "") {
	         alert("Please select the nomenclature");
	         flag=1;
	         return false;
	     }
		  if (itemId == null || itemId == "") {
	         alert("Please enter valid data");
	         flag=1;
	         return false;
	     }
	     if (reqQty == null || reqQty == "") {
	        alert("Please enter the required quantity");
	        flag=1;
	        return false;
	    }
	     if (reqQty == 0 ) {
		        alert("Required quantity can not be zero");
		        flag=1;
		        return false;
		    } 
	  });
	  var approxCost= document.getElementById("approxCost").value;
		
	  if (approxCost > 250000 ) {
	        alert("Approx Cost should not be greater than 250000");
	        flag=1;
	        return false;
	    }
	    if(flag==1){
	    	return false;
	    }
	    if (action == null || action == 0) {
	        alert("Please select Action");
	        return false;
	    }
	    
	    
		$("#submitBudgetary").submit();
		 setTimeout(function(){ 			 
			 $("#saveForm1").attr("disabled", "disabled");
			 
		 }, 50);
	
}

function calculateAmount(inc){
	 //alert("shaudxsu");
	  var quantity = 0;
	  var unitRate = 0;
	  var amount = 0;
	 var a= document.getElementById('requiredQty'+inc).value;
	 var b=document.getElementById('lpunitrate'+inc).value;
	// alert(a+"hhhhhhhhhh"+b);
	  if (!isNaN(document.getElementById('requiredQty'+inc).value))
	  quantity = parseFloat(document.getElementById('requiredQty'+inc).value);
	  
	  if (!isNaN(document.getElementById('lpunitrate'+inc).value))
	   unitRate = parseFloat(document.getElementById('lpunitrate'+inc).value);
	  // Amount Calculation
	  
	  if (unitRate > 0 && quantity > 0 &&  unitRate!=NaN)
	  {
	   amount = quantity * unitRate;
	   document.getElementById('itemValue'+inc).value =  Math.round(amount * 100) / 100;
	   getApproxCost();
	  }else
	  {
		  document.getElementById('itemValue'+inc).value = "";
		  getApproxCost();
	  	  return;
	  }
	 
	 }
	 

function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

function removeRowIndent(obj){

var budTId=jQuery(obj).closest("tr").find("td:eq(8)").find(":input").val();
	var aParam =[];
	    
var rowCount = $('#nomenclatureGrid tr').length;
if(rowCount!==1){
var r = confirm("Do you want to delete the record?");
if (r == true) {
	 if(budTId!==""){
	     aParam.push(budTId);
	     if(aParam.length > 0){
	 		var param={"aParam":aParam};
	 		//  alert(JSON.stringify(param)); 	
	 	jQuery.ajax({
	 	 	crossOrigin: true,
	 	    method: "POST",			    
	 	    crossDomain:true,
	 	    url: "deleteBudgetaryItems",
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
getApproxCost();
}

function getApproxCost(){
	var approxCost=0;
	  $("#nomenclatureGrid tr").each(function () {
	 	 var itemValue=$(this).find('td:eq(4)').find(':input').val();
	 	 approxCost=parseFloat(approxCost)+parseFloat(itemValue);
	 	
	}); 
	 $('#approxCost').val(approxCost);
	 return;
}

function printIndentReport(indentId) {
//window.location.href="PrintToken?visitId="+visitId;
document.frm.action="${pageContext.request.contextPath}/report/printIndentReport?indent_id="+indentId;
document.frm.method="POST";
document.frm.submit(); 

}

function getLpRate(val, inc,item) {
	var lpRate=0;
	var itemId=$(item).closest('tr').find("td:eq(5)").find(":input").val();
	var itemId={"itemId":itemId};
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getLpRateByItemId",
	    data:JSON.stringify(itemId),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	if(result.status==1){
	    		if(result.lpRate!=0){
	    			//$(item).closest('tr').find("td:eq(3)").find(":input").attr('readonly',true);
	    			$(item).closest('tr').find("td:eq(3)").find(":input").val(result.lpRate);
	    		}else{
	    			//$(item).closest('tr').find("td:eq(3)").find(":input").attr('readonly',false);
	    			$(item).closest('tr').find("td:eq(3)").find(":input").val("");
	    		}
	    	}
	    	else if(result.status==0){
	    		alert(result.err_mssg);
	    	}
	    	else if(result.status==-1){
	    		alert(result.msg);
	    	}
	    	
	    },
	    error: function(result) {
         alert("An error has occurred while contacting the server");
     }
	    
	});

}

function compareDate(){
	var approvalOn = $('#approvalDateOn').val();
    var requestedOn = $('#moApproveDate').val();
			 
	   if(process(approvalOn) < process(requestedOn)){
			alert("Approval Date should not be earlier than "+requestedOn+ " (MO Approval Date)");
			 $('#approvalDateOn').val("");
				return;
			 }
} 
</script>
</body>


</html>