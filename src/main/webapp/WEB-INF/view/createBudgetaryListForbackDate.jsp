<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>
<%@include file="..//view/commonJavaScript.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ASHA Application</title>
</head>
<script src="${pageContext.request.contextPath}/resources/js/stores.js"></script> 
<%
long departmentId = 0;
String departmentName="";
	  if (session.getAttribute("department_id") != null) {
	   departmentId = Long.parseLong(session.getAttribute("department_id").toString());
	   departmentName =session.getAttribute("departmentName").toString();
	  }
	
	  SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); 

		Calendar c = Calendar.getInstance(); 
		Date startDate = c.getTime();
		String currentDate=formatter.format(startDate); 
		
	  %>
<body>
<div id="wrapper">
	<div class="content-page">
		<!-- Start content -->
	<div id="supplyOrderpendApprovalList" class="">
		<div class="container-fluid">
			<div class="internal_Htext">Show budgetary for direct receiving</div>
						
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-body">	
							<div class="row">									  
								<div class="col-md-3">
									<div class="form-group row">
										<label class="col-sm-5 col-form-label">From Date<span class="mandate"><sup>&#9733;</sup></span></label>
										<div class="col-sm-7">
											<div class="dateHolder ">
												<input  type="text" class="noFuture_dateStore form-control" id="from_date" placeholder="DD/MM/YYYY" name="date" value="<%=currentDate %>">
											</div>	
										</div>
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group row">
										<label class="col-sm-5 col-form-label">To Date<span class="mandate"><sup>&#9733;</sup></span></label>
										<div class="col-sm-7">
											<div class="dateHolder ">
												<input  type="text" class="noFuture_dateStore form-control" id="to_date" placeholder="DD/MM/YYYY" name="date" value="<%=currentDate %>" >
											</div>	
										</div>
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group row">
										<label class="col-sm-5 col-form-label">Vendor<span class="mandate"><sup>&#9733;</sup></span></label>
										<div class="col-sm-7">
											<select class="form-control" id="vendorId" name="vendorId">
												<option value="0">Select</option>
											</select>	
										</div>
									</div>
								</div>
								<div class="col-md-3 ">
									<button class="btn btn-primary" id="btnShow" name="btnShow" onclick="showItemListForbackDateBudgetary()">Search</button>
								</div>
							</div>
							<div class="row">
							<div class="col-md-3" id="reqDateDiv" style="display: none">
									<div class="form-group row">
										<label class="col-sm-5 col-form-label">Requirement Date<span class="mandate"><sup>&#9733;</sup></span></label>
										<div class="col-sm-7">
											<div class="dateHolder">
													<input  type="text" class="noFuture_dateStore form-control"
														name="reqDate" id="reqDate" placeholder="DD/MM/YYYY" value="" maxlength="10" />
												</div>
										</div>
									</div>
								</div>
							
							 <div class="col-md-3">
									<p align="Left" id="message"	style="color: green; font-weight: bold;"></p>
							 </div>
							 </div>
							<div class="row">
							<div id="tableDiv" style="display: none">
							<!-- <div id="tableDiv" > -->
								<div class="col-12">
									<div class="table-responsive">
									<table class="table table-bordered table-striped table-hover">
										<thead>
											<tr>
												<th id="th1">S.No.</th>
												<th id="th2">PVMS</th>
												<th id="th3">Nomenclature</th>
												<th id="th4">A/U</th>
												<th id="th5">Batch</th>
												<th id="th6">DOM</th>
												<th id="th7">DOE</th>
												<th id="th8">Received Qty</th>
												<!-- <th id="th9">Amount</th> -->
												<th id="th10">Received Date</th>
												<th id="th11">Select</th>
											</tr>
										</thead>
										<tbody id="tblBudgetaryList">
										</tbody>
									</table>
									</div>							
								</div>
								
										<input type="hidden" class="form-control" id="userId"
											   name="userId"  value="<%=session.getAttribute("user_id")%>">
										<input type="hidden" class="form-control" id="hospitalId"
											   name="hospitalId"  value="<%=session.getAttribute("hospital_id")%>">
										<input type="hidden" class="form-control" id="departmentId" 
											   name="departmentId" value="<%=departmentId %>"/> 
									    
										   
								<div class="col-12 text-right">
									<button class="btn btn-primary" id='btnCreateBudgetary' onclick="createBudgetaryForBackDateLP()">Create Budgetary</button>
								</div>
							</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
</body>
<form id="budetgaryListForm" name="budetgaryListForm">
<input type="hidden" class="form-control" id="budgetaryMId" name="budgetaryMId"/> 
</form>
<script>
var nPageNo=1;
$j(document).ready(function() {
	var departmentId = $('#departmentId').val();
	if(departmentId!=0){
		$j("#supplyOrderpendApprovalList :input").attr("disabled", false);
		getSuppierListForStore();
	}else{
		$j("#supplyOrderpendApprovalList :input").attr("disabled", true);
		alert("Please select Department.");
		return;
	}
});

function getSuppierListForStore(){
	 var hospitalId=$('#hospitalId').val();
			 var params = {
					 "hospitalId":hospitalId 
					}
	     $j.ajax({
	   	  type : "POST",
			  contentType : "application/json",
			  url : 'getSupplierListForStore',
			  data : JSON.stringify(params),
			  dataType : "json",
			  cache : false,
	        success : function(response) {
	        	if(response.status==1){
	        		var supplierList = response.supplierData;
					var supplierValues='';
					for(count in supplierList){
						supplierValues += '<option value='+supplierList[count].supplierId+'>'
										+ supplierList[count].supplierName
										+ '</option>';
					 }
						$j('#vendorId').append(supplierValues); 
	        	}else{
	        		$('#vendorId').val(0);
	        	}
	        },
	        error: function(msg){					
				alert("An error has occurred while contacting the server");
			}
	     });
		
	}

function showItemListForbackDateBudgetary(){
	var departmentId= $('#departmentId').val();
	var hospitalId= $('#hospitalId').val();
	var supplierId= $('#vendorId').val();
	var fromDate= $('#from_date').val();
	var toDate= $('#to_date').val();
	
	if(fromDate=='' ||  toDate==''  ||  supplierId=='0'){
		alert("Please fill the mandatory fileds");
		return false;
	}
	var data = {"hospitalId": hospitalId,"departmentId":departmentId,"fromDate":fromDate,"toDate":toDate,"supplierId":supplierId,"pageNo":nPageNo};
	var url = "showItemListForbackDateBudgetary";		
	var bClickable = false;
	GetJsonData('tblBudgetaryList',data,url,bClickable);
}

function makeTable(jsonData) {
    var htmlTable = "";
    if(jsonData.status==1){
    	var dataList = jsonData.itemListForBudgetary;
		 for(i in dataList){
			  var count = parseInt(i) +1;
	    	  htmlTable = htmlTable + "<tr id='" + dataList[i].tempId + "'>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + count + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[i].pvms + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[i].nomenclature + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[i].au + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[i].batchNo + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[i].dom + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[i].doe + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[i].receivedQty + "</td>";
	    	  htmlTable = htmlTable + "<td style='display:none'><input readonly class='form-control width110' id='amountId"+i+"' name='amount' value='0' /></td>"; 
	    	  htmlTable = htmlTable + "<td ><input readonly class='form-control width110' id='receivingDate"+i+"' name='receivingDate' value='"+dataList[i].receivingDate+"' /></td>"; 
	    	  htmlTable = htmlTable + "<td ><div class='form-check form-check-inline cusCheck'><input  class='form-check-input'  type='checkbox' id='checkDiv"+i+"' name='checkDiv' value='"+dataList[i].tempId+"' onclick='enableOrDisableAmountField("+i+")'/> <span class='cus-checkbtn'></span></div></td>";
	    	  htmlTable = htmlTable + "<td style='display:none;'>" + dataList[i].itemId + "</td>";
	    	  	    	 
	    	  
	      }
		  $('#reqDateDiv').show();
	      $("#tblBudgetaryList").html(htmlTable);
		  $('#tableDiv').show();
	}else{
		 $('#reqDateDiv').hide();
		 $('#tableDiv').hide();
		 $("#tblBudgetaryList").empty();
		 alert(jsonData.message);
		
        
	}
  }
 function createBudgetaryForBackDateLP(){
		var rowCheckFlag=false;
		
		if($('#vendorId').val()=="0"){
			 alert("Please select the vendor.");
			 return ;
		}
		
		if($('#reqDate').val()==''){
			 alert("Requirement Date is mandatory.");
			 return ;
		}
		
	 if(!$j("input[name='checkDiv']:checked").is(':checked')){
			alert("Please select atleast one record");
			return ;
			
		}else{
			
			var tempIds=[];
			 $j.each($j("input[name=checkDiv]:checked"), function(){  
				 tempIds.push($j(this).val());
		   	 });
		
			 var apxCost=0;
			 var amountIds=[];
			 $j.each($j("input[name=amount]"), function(i,n){  
				 if($(this).val()!=''){
						 value=$(this).val();
						 amountIds.push($j(this).val());
				 }else{
					 value=0;
				 }
				 apxCost = parseInt(apxCost)+parseInt(value);
		   	 });
		  
			 
			/*  if(checkReceivedDate('tblBudgetaryList') && checkSelectedRowAndAmount()==true){ */
			if(checkReceivedDate('tblBudgetaryList')){
				 var departmentId= $('#departmentId').val();
				 var hospitalId= $('#hospitalId').val();
				 var userId= $('#userId').val();
				 var reqDate= $('#reqDate').val();
				 
				 var params = {
						 "departmentId":departmentId,
						 "tempIds":tempIds,
						 "hospitalId":hospitalId,
						 "userId":userId,
						 "amountIds":amountIds,
						 "apxCost":apxCost,
						 "reqDate":reqDate
						} 
		     $j.ajax({
		   	      type : "POST",
		   		  contentType : "application/json",
				  url : 'createBudgetaryForBackDateLP',
				  data : JSON.stringify(params),
				  dataType : "json",
				  cache : false,
		        success : function(response) {
		        	if(response.status==1){
		        		$('#budgetaryMId').val(response.budgetaryMId);
		        		document.budetgaryListForm.action="submitBudgetarySuccess";
		        		document.budetgaryListForm.method="POSt";
		        		document.budetgaryListForm.submit();
		        	}else{
		        		alert(response.message);
		        	}
		        },
		        error: function(msg){					
					alert("An error has occurred while contacting the server");
				}
		     });
			 }
		}
 }
 
 function compareDate(){
	var fromDate = $('#from_date').val();
    var toDate = $('#to_date').val();
			 
	   if(process(toDate) < process(fromDate)){
			alert("From Date should  be earlier than To Date");
			 $('#to_date').val("");
				return;
			 }
	}
 
 
 function enableOrDisableAmountField(i){
	 if (document.getElementById("checkDiv"+i).checked == true){
			 document.getElementById("amountId"+i).readOnly= false;
	 }else{
		 document.getElementById("amountId"+i).readOnly= true; 
		 document.getElementById("amountId"+i).value ="";
	 }
 }

 function checkSelectedRowAndAmount(){
	 var rowCount=0;
	 var amountCount=0;
	 var value=0;
	 $j.each($j("input[name=checkDiv]:checked"), function(){  
		 rowCount++;
   	 });
	 
	 $j.each($j("input[name=amount]"), function(){  
		 if($(this).val()!=''){
			 amountCount++;
		 }
   	 });
	 value =(rowCount-amountCount);
	 if(value==0){
		 return true;
	 }
	 if(value>0){
		 alert("Please fill the amount.");
		 return false;
	 }
	 if(value<0){
		 alert("Please select the row.");
		 return false;
	 }
	 
 }
 
 function checkReceivedDate(tbody){
	 var flag=false;
	 var requirementDate= $('#reqDate').val();
	 $('#'+tbody+' tr').each(function(i, el) {
		 var $tds = $(this).find('td');
		 var selectRowId=  $($tds).closest('tr').find("td:eq(10)").find("input:eq(0)").attr("id");
		 if($('#'+selectRowId).prop("checked")){
			 var rowDateId=  $($tds).closest('tr').find("td:eq(9)").find("input:eq(0)").attr("id");
			 var rowDateValue=$('#'+rowDateId).val();
			 if(requirementDate<=rowDateValue){
				 flag=true;
			 }else{
				 alert("Requirement Date can not greater than : " +rowDateValue);
				 $('#reqDate').val("");
				 flag=false;
				 return false;
			 }
		}
		 
	 }); 
	 return flag;
 }
</script>

</html>