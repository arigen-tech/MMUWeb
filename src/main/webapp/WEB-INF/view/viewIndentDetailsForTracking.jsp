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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newOpd.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opd.js"></script> --%>

<%
String departmentId = HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim();
String departmentName="";
/* 	  if (session.getAttribute("department_id") != null) {
	   departmentId = Long.parseLong(session.getAttribute("department_id").toString());
	  } */
	String mmuId = "0";
	if (session.getAttribute("mmuId") != null) {
		mmuId = session.getAttribute("mmuId") + "";
	}
	String userId = "0";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
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
</head>
<style>
a {
  color: blue;
}
</style>
<body>

	<!-- Begin page -->
	<div id="wrapper">


		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">Indent Details</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
										<form:form name="submitIndentDispencery" id="submitIndentDispencery" method="post" autocomplete="off">
																		
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Indent No</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="indentNo" name="indentNo" readonly="readonly"/>
												</div>
											</div>
										</div>

										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Indent Date</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="indentDate" name="indentDate" readonly="readonly" />
												</div>
											</div>
										</div>

										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Prepared By</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="createdBy" name="createdBy" readonly="readonly"/>
												</div>
											</div>
										</div>

										<!-- <div class="col-md-4">
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
									<!-- <div class="table-responsive"> -->
									<div class="scrollableDiv m-b-10">
									<table
										class="table table-hover table-striped table-bordered m-t-10">
										<thead class="bg-primary">
											<tr>
												<!-- <th>S.No</th> -->
												<th>Drug Name/Drug Code</th>
												<th>A/U</th>
												<th>Required Qty</th>
												<th>Received Qty</th>
												<!-- <th>Available Stock</th> -->
												<th>Reason for Indent</th>
											</tr>
										<tbody id="nomenclatureGrid">
												<tr>
													
													<!-- <td>1</td> -->

													<td>
														<div class="autocomplete">
															<input type="text" value="" autocomplete="off"
																spellcheck="false" id="nomenclature1" size="120" readonly="readonly"
																name="nomenclature" class="form-control border-input width330" />

														</div>
													</td>

													<td><input type="text" name="accountingUnit1"
														tabindex="1" id="dispensingUnit1" 
														readonly="readonly" validate="AU,string,no"
														class="form-control" /></td>

													<td><input type="text" name="requiredQty" tabindex="1"
														autocomplete="nope" spellcheck="false" value="" readonly="readonly"
														id="requiredQty1" size="5" maxlength="5" class="form-control" onkeypress="return isNumberKey(event)" /></td>
														
													<td><p id="receivedQty1" onclick="showReceivedInfo(this)"> </p></td>

													<td style="display: none;"><input type="hidden" id="availableStock1"
														readonly="readonly" name="availableStock"
														class="form-control" /> </td>


													<td style="display: none;"><input type="hidden" name="stockInDispencery" tabindex="1"
														autocomplete="nope" spellcheck="false" id="stockInDispencery1"
														readonly="readonly" size="5" maxlength="3"
														class="form-control" /></td>

													<td style="display: none;"><input type="hidden" name="stockInStore" tabindex="1"
														id="stockInStore1" size="5" validate="total,num,no"
														readonly="readonly" class="form-control" /></td>

													<td><textarea name="remarks1" tabindex="1" readonly="readonly"
														id="remarks1" placeholder="" class="form-control width90Percent" ></textarea></td>

							

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
												</tr>

											</tbody>
											
										</table>
									
									</div>
										
									<div class="row">
										<div class="col-md-12 text-right">
								
													
														
														<a  class="buttonDel  btn btn-primary " role="button"
															href="${pageContext.request.contextPath}/dispencery/getIndentForTracking">Close</a>
											
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
		
	<div class="modal" id="recList" role="dialog">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<span class="Message_htext"> List</span>

						<button type="button" onClick="closeMdl();" class="close"
							data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>

					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-md-12">
								<div class="table-responsive">
									<table
										class="table table-hover table-striped table-bordered m-t-10">
										<thead class="bg-primary">
											<tr>
												<th>S.No.</th>
												<th>Issue No.</th>
												<th>Issue Date</th>
												<th>Batch No.</th>
												<th>Received Qty</th>
											</tr>
										<tbody id="nomenclatureGrid2">
											
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" onClick="closeMdl();">
							Close
						</button>
					</div>
					
					
					
				</div>
			</div>
</div>

<div class="modal-backdrop show" style="display:none;"></div>
	
		

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

$('.scrollableDiv').css({'height':winHeight-420});
 */
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
var data='';
var itemIds = '';
var record=0;
var globleJson;
$j(document).ready(function()
  {
	//if department not in session
   	if(<%= departmentId %>!=0){
			$j("#submitIndentDispencery :input").attr("disabled", false);
		}else{
			alert("Select the department");
			$j("#submitIndentDispencery :input").attr("disabled", true);
			return false;
		}
         var dataList = ${data};
          var resultList= dataList.data;
          globleJson = dataList.data;
          var count=dataList.count;
           var j=0;
           record=count;
        	for(item in resultList){
    		 j++;
    		 if(item==1){
    			 $j('#indentNo').val(resultList[item].indentNo);
    		  	   $j('#fromDept').val(resultList[item].fromDept);
    		  	   $j('#toDept').val(resultList[item].toDept);
    		  	   $j('#indentDate').val(resultList[item].indentdate);
    		  	   $j('#createdBy').val(resultList[item].createdBy);
    		  	 $j('#toDeptName').val(resultList[item].toDeptId);
    		 }
    		 $('#nomenclature'+j).val(resultList[item].NomPvmsNo);
    		 $('#dispensingUnit'+j).val(resultList[item].accountingUnit);
    		 $('#requiredQty'+j).val(resultList[item].requiredQty);
    		 //$('#issuedQty'+j).val(resultList[item].issuedQty);
    		 
    		 $('#receivedQty'+j).html('<a href="#" onclick="showListModal();">'+resultList[item].receivedQty+'</a>');
    		 //$('#availableStock'+j).val(resultList[item].availableStock);
    		 $('#stockInDispencery'+j).val(resultList[item].stockDisp);
    		 $('#stockInStore'+j).val(resultList[item].stockStore);
    		 $('#remarks'+j).val(resultList[item].remark);
    		 $('#itemIdNom'+j).val(resultList[item].itemId);
    		 $('#pvmsNo'+j).val(resultList[item].pvmsNo);
    		 $('#indentId'+j).val(resultList[item].id);
    		 $('#indentIdT'+j).val(resultList[item].id);
    		 $('#indentMid'+j).val(resultList[item].indentMid);     		 
    		 $('#record').html(record);
    		 $('#records').html(" Records");
 				if(j!==count)
    		 addNomenclatureRow1();
         }
    	 
		
  });

</script>

<script type="text/javascript"  >
var i=1;
function addNomenclatureRow1() {
	
	 i++;
		var aClone = $('#nomenclatureGrid>tr:last').clone(true)
		aClone.find(":input").val("");
		aClone.find("td:eq(0)").find(":input").prop('id', 'nomenclature'+i+'');
		aClone.find("td:eq(1)").find(":input").prop('id', 'dispensingUnit'+i+'');
		aClone.find("td:eq(2)").find(":input").prop('id', 'requiredQty'+i+'');
		aClone.find("td:eq(3)").find("p").prop('id', 'receivedQty'+i+'');
		aClone.find("td:eq(4)").find(":input").prop('id', 'availableStock'+i+'');
		aClone.find("td:eq(5)").find(":input").prop('id', 'stockInDispencery'+i+'');
		aClone.find("td:eq(6)").find(":input").prop('id', 'stockInStore'+i+'');
		aClone.find("td:eq(7)").find(":input").prop('id', 'remarks'+i+'');
		aClone.find("td:eq(8)").find(":input").prop('id', 'itemIdNom'+i+'');
		aClone.find("td:eq(9)").find(":input").prop('id', 'pvmsNo'+i+'');
		aClone.find("td:eq(10)").find(":input").prop('id', 'indentId'+i+'');
		aClone.find("td:eq(11)").find(":input").prop('id', 'indentMid'+i+'');
		aClone.clone(true).appendTo('#nomenclatureGrid');
		var val = $('#nomenclatureGrid>tr:last').find("td:eq(0)").find(":input")[0];
		
}

function showReceivedInfo(item){
	var indentId = $(item).closest('tr').find('td').eq(10).find(":input").val();
	for(i in globleJson){
		var id = globleJson[i].id;
		if(indentId == id){
			var receivedDetail = globleJson[i].receivedDetail;
			var htmlTable = '';
			for(j=0;j<receivedDetail.length;j++){
				var issueNo = receivedDetail[j].issueNo;
				var issueDate = receivedDetail[j].issueDate;
				var receivedQty = receivedDetail[j].receivedQty;
				var batchNo = receivedDetail[j].batchNo;
				console.log("issueNo "+issueNo+" issueDate "+issueDate+" receivedQty "+receivedQty+" batchNo "+batchNo);
				htmlTable = htmlTable + '<tr>';
				htmlTable = htmlTable + '<td>'+(j+1)+'</td>';
				htmlTable = htmlTable + '<td>'+issueNo+'</td>';
				htmlTable = htmlTable + '<td>'+issueDate+'</td>';
				htmlTable = htmlTable + '<td>'+batchNo+'</td>';
				htmlTable = htmlTable + '<td>'+receivedQty+'</td>';
				htmlTable = htmlTable + '</tr>';
			}
			
			if (receivedDetail.length == 0) {
				htmlTable = htmlTable
						+ "<tr ><td colspan='5'><h6>No Record Found !!</h6></td></tr>";
			}
			$('#nomenclatureGrid2').html(htmlTable);
		}
	}
}

function showListModal(){
	$j('#recList').show();
	$j('.modal-backdrop').show();
}

function closeMdl(){
	$j('#recList').hide();
	$j('.modal-backdrop').hide();
	
}

</script>
</html>