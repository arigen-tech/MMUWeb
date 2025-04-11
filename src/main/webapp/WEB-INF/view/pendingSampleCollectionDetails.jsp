<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>  
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 <%@include file="..//view/leftMenu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MMSY</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    
    <%
	String hospitalId = null;
	if (session.getAttribute("mmuId") != null) {
		hospitalId = session.getAttribute("mmuId") + "";
	}
	String userId = null;
	if (session.getAttribute("userId") != null) {
		userId = session.getAttribute("userId") + "";
	}
	
	String departmentId = "";
	/* if (session.getAttribute("department_id") != null) {
		departmentId = session.getAttribute("department_id") + "";
	}  */
	
%>
<%@include file="..//view/commonJavaScript.jsp" %>


</head>
<body>
	<div id="wrapper">
		<div class="content-page">
		<div class="">
				<div class="container-fluid">
				<div class="internal_Htext">Sample Collection</div>
				
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
						<form id="pendingForSampleCollectionDetailsForm" name="pendingForSampleCollectionDetailsForm" action="" method="POST">
							<input type="hidden" name="hospitalId" id="hospitalId" value="<%=hospitalId %>" />
							<input type="hidden" name="userId" id="userId" value="<%=userId %>" />
							<input type="hidden" name="patientId" id="patientId" value="" />
							<input type="hidden" name="departmentId" id="departmentId" value="" />
							<input type="hidden" name="orderStatus" id="orderStatus" value="" />
							<input type="hidden" name="orderhdId" id="orderhdId" value=""/>
							
							<input type="hidden" id="investigationsArray" name="investigationsArray" value=''/>							
							<input type="hidden" id="sampleCollectionsArray" name="sampleCollectionsArray" value=''/>
							<input type="hidden" id="collectedArray" name="collectedArray" value=''/>
							<input type="hidden" id="remarksArray" name="remarksArray" value=''/>
							<input type="hidden" id = "collectedCheckBox" name="collectedCheckBox" value=''/>
							<input type="hidden" id = "subChargeCodeId" name="subChargeCodeId" value=''/>
							
							
						<div class="col-md-6"></div>
						<div id="patientDetailsOthersDiv">
							<div class="opdMain_detail_area">
							<h4 class="service_htext">ORDER DETAILS</h4>
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
												<label class="col-form-label" ><spring:message code="lbl_order_date"/><span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="orderDate" name="orderDate" value="" readonly="readonly">
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
												<label class="col-form-label" ><spring:message code="lbl_order_time"/><span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="orderTime" name="orderTime" readonly="readonly">
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
												<label class="col-form-label" >Sample ID<span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="orderNumber" name="orderNumber" readonly="readonly" >
														
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
												<label class="col-form-label" ><spring:message code="lbl_department"/><span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="departmentName" name="departmentName" readonly="readonly">
												</div>
											</div>
										</div>
										
										
									</div>
									</div>
									
									<div class="opdMain_detail_area">
									<h4 class="service_htext">PATIENT DETAILS</h4>
									<div class="row">
									
									
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
												<label class="col-form-label" ><spring:message code="lbl_patient_name"/><span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="patientName" name="patientName" readonly="readonly">
												</div>
											</div>
										</div>
									
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
												<label class="col-form-label" ><spring:message code="lbl_age"/><span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="age" name="age" readonly="readonly">
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
												<label class="col-form-label" ><spring:message code="lbl_gender"/><span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="gender" name="gender" readonly="readonly">
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
												<label class="col-form-label" ><spring:message code="lbl_mobileNumber"/></label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="mobileNumber" name="mobileNumber" readonly="readonly">
												</div>
											</div>
										</div>
										</div>
										</div>
										
										<div class="opdMain_detail_area">
										<h4 class="service_htext">SAMPLE DETAILS</h4>
									<div class="row">
									<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
												<label class="col-form-label" ><spring:message code="lbl_date"/><span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="currentDate" name="currentDate" readonly="readonly">
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
												<label class="col-form-label"><spring:message code="lbl_time"/><span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="currentTime" name="currentTime" readonly="readonly">
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
												<label class="col-form-label">Collected/Validated By<span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="createdBy" name="createdBy" readonly="readonly">
												</div>
											</div>
										</div>
										<%-- <div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
												<label class="col-form-label"><spring:message code="lbl_diagnostic_no"/><span class="mandate"><sup>&#9733;</sup></span></label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control" id="diagnosticNo" name="diagnosticNo" readonly="readonly">
												</div>
											</div>
										</div> --%>
										</div>
										
										
										
										<div>
										
										<div id="tblinvestigations" style="display:"
												class="right_col"  style="padding:0.5% 1.8%;" >
												</div>
												<div class="clearfix"></div>
												
												<table class="table table-striped table-hover  table-bordered  ">
													<thead>
														<tr>
															<th id="th1">SI No</th>
															<th id="th2">Investigation</th>
															<th id="th3">Sample</th>															
															<th id="th4">Container</th>
														    <th id="th5"><div class="form-check form-check-inline cusCheck m-l-10"><input type="checkbox" class="form-check-input" id="invChkbox" multiple="multiple" name="invChkbox"  checked="checked" ><span class="cus-checkbtn"></span> <label class="form-check-label">Collected/Validated</label></div></th>	<!--<input type="checkbox" id="invChkbox" name="invChkbox"> onclick="multiselectCheckBox(this);" checked="checked" -->													
															<th id="th6">Remark</th>
															
														</tr>
														
													</thead>
													<tbody id="tblListOfInvestigations">
													</tbody>
												</table>
											</div> 
											<div class="col-12 text-right">
											<button type="button" class="btn  btn-primary" id = "submitbtnId" onclick="submitSampleCollectionDetails();">Submit</button>
											
											<input type="button" class="btn btn-primary opd_submit_btn" id ="backId" value="Back" onclick="backToWaitingList();">	
											<input type ="button" class="btn  btn-danger" onclick="Reset();" value="Reset"/>
											</div>
											</div>
										
									</div>
								</form>	
									</div>
									
							</div>
						
						
						</div>
				</div>
				</div>
				</div>
				</div>
				</div>
</body>
</html>

<script type="text/javascript">

var htmlTable = "";	
var $j = jQuery.noConflict();
var rowcount=0;

var orderDate='';

$j(document).ready(function()
		{
				var data = ${data};
				
				//alert(data);
				
				
			    var dataList = data.data1;
			    
			    for(i=0;i<dataList.length;i++){
			    	/*ORDER DETAILS*/
							$j('#orderDate').val(dataList[i].orderdate);
							$j('#orderTime').val(dataList[i].lastChgDate);
							$j('#orderNumber').val(dataList[i].orderNo);
							$j('#departmentName').val(dataList[i].departmentName);
							
							/*PATIENT DETAILS*/
							$j('#serviceNo').val(dataList[i].serviceNo);
							$j('#patientName').val(dataList[i].patientName);
							
						
							$j('#age').val(dataList[i].age);
							$j('#gender').val(dataList[i].gender);
							$j('#mobileNumber').val(dataList[i].mobileNumber);
							
							/*SAMPLE DETAILS*/
							$j('#currentDate').val(dataList[i].currentDate);
							$j('#currentTime').val(dataList[i].currentTime);
							$j('#createdBy').val(dataList[i].lastChgBy);
							//alert(dataList[i].lastChgBy)
							$j('#diagnosticNo').val(dataList[i].orderNo);
							
							$('#patientId').val(dataList[i].patientId);
							$('#departmentId').val(dataList[i].departmentId);
							$('#orderStatus').val(dataList[i].orderStatus);
							$('#orderhdId').val(dataList[i].orderhdId);
				}
			    
			    var dataList1 = data.data2;
			    
			    var counter =1;
			    for(i=0;i<dataList1.length;i++){
			    	
					htmlTable = htmlTable+"<tr id='"+dataList1[i].orderhdIdforInv+"' >";			
					htmlTable = htmlTable +"<td class='width60'>"+counter+"</td>";
					htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='investigationId' id='investigationId"+dataList1[i].investigationId+"'  value='"+dataList1[i].investigationName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' id='"+dataList1[i].investigationId+"'/></td>";
					htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='sampleId' id='sampleId"+dataList1[i].sampleId+"'  value='"+dataList1[i].sampleDesc+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' id='"+dataList1[i].sampleId+"'/></td>";
					htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control border-input' type='text' name='sampleId' id='sampleId"+dataList1[i].sampleId+"'  value='"+dataList1[i].collectionName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' id='"+dataList1[i].collectionId+"'/></td>";
					htmlTable = htmlTable +"<td class='width180'><div class='form-check form-check-inline cusCheck m-l-10'><input type='checkbox' class='dependCheck form-check-input' id='invChkbox"+counter+"' name='invChkbox' checked='checked' onclick='multiselectAcceptCheckBox(this);'/><span class='cus-checkbtn'></span> </div></td>";
					htmlTable = htmlTable +"<td style='width: 150px;'><input class='form-control border-input' type='text' name='remarkId' id='remarkId"+counter+"'value='' autocomplete='off'/></td>";
					htmlTable = htmlTable +"<td style='width: 150px; display:none'><input class='form-control border-input' type='hidden' id='"+dataList1[i].subChargeCodeId+"'  value='"+dataList1[i].subChargeCodeName+"' readOnly='readOnly'/><input  class='form-control border-input' type='hidden' id='"+dataList1[i].subChargeCodeId+"'/></td>";
					htmlTable = htmlTable +"<td style='width: 150px; display:none'><input class='form-control border-input' type='hidden' name='orderdtId' id='"+dataList1[i].orderdtId+"'  value='"+dataList1[i].orderdtId+"' readOnly='readOnly'/></td>";
					htmlTable = htmlTable +"<td style='width: 150px; display:none'><input class='form-control border-input' type='hidden' name='collectedBy' id='collectedBy'  value='"+<%=userId%>+"' readOnly='readOnly'/></td>";
					 		
					htmlTable = htmlTable+"</tr>";
					counter++;
					
					/* <input type="hidden"  name="dgOrderDtIdValue" value='+ data[i].dgOrderDtId+ ' id="dgOrderDtIdValue'+ data[i].dgOrderDtId + '"/>'; */
					
			    }
			    if(dataList1.length == 0)
				{
				htmlTable = htmlTable+"<tr ><td colspan='7'><h6>No Record Found</h6></td></tr>";
				   
				}
			    $j("#tblListOfInvestigations").html(htmlTable); 
			    
				//multiple checkbox grouping checked unchecked
			     $('#invChkbox').change(function(){			    	
			    	console.log('checkbox clicked');			    	
			    	if(this.checked){
			    		$('.dependCheck').prop('checked',true);
			    		multiselectCheckBox();
			    	}
			    	else{
			    		$('.dependCheck').prop('checked',false);
			    		multiselectCheckBox();
			    	}			    	
			    }); 
		});

//multiselect checkboxes.
function multiselectCheckBox(){
	var count = $('#tblListOfInvestigations tr').length;
	var countForss=0;
	  for(var j=1;j<=count;j++){
		if(document.getElementById("invChkbox"+j).checked == true){
			countForss++;
			$('#remarkId'+j).attr('readonly', false);
		}
		else{
			$('#remarkId'+j).attr('readonly', true);
			$('#remarkId'+j).val('');
		}
	} 
	if(countForss==0){
		$('#submitbtnId').attr('disabled', true);
		$('#invChkbox').prop('checked',false);
	}
	else{
		$('#submitbtnId').attr('disabled', false);
	}
}

function multiselectAcceptCheckBox(source){
 	var count = $('#tblListOfInvestigations tr').length;
	var countForss=0;
	var countuncheck=0;
	var totalCheck=0;
	  for(var j=1;j<=count;j++){
		if(document.getElementById("invChkbox"+j).checked == true){
			countForss++;
			$('#remarkId'+j).attr('readonly', false);
			totalCheck++;
		}
		else{
			$('#remarkId'+j).attr('readonly', true);
			$('#remarkId'+j).val('');
			countuncheck++;
		}
	} 
	  if(countuncheck>0){
		  $('#invChkbox').prop('checked', false);  
	  }
	  if(totalCheck==count){
		  $('#invChkbox').prop('checked', true);  
	  }
	if(countForss==0){
		$('#submitbtnId').attr('disabled', true);
		$('#invChkbox').prop('checked',false);
	}
	else{
		$('#submitbtnId').attr('disabled', false);
	}
		 
}

var investigationArray = [];
var sampleCollectionArray = [];
var collectedArray = [];
var remarkArray = [];
var collectedCheckedArray = [];
var subChargeCodeIdArray=[];
var ContainerArray=[];

var checkedChkBox="";
var InvestigationValue="";
var Investigationid="";
var SampleValue="";
var Sampleid="";
var ContainerValue="";
var Containerid="";
var RemarkValue="";
var Remarkid="";
var subChargeCodeId="";

  function checkedSampleCollected(value){
	$('#tblListOfInvestigations tr').each(function(i, el) {
		
		
		var id = $(this).find("td:eq(4)").find("input:eq(0)").attr("id")
		
		 if (document.getElementById(id).checked == true) {
			
			 checkedChkBox = 'y';
			 
			  InvestigationValue = $(this).find("td:eq(1)").find("input:eq(0)").attr("id")
			  Investigationid = $(this).find("td:eq(1)").find("input:eq(1)").attr("id")
			 
			  //SampleValue = $(this).find("td:eq(2)").find("input:eq(0)").attr("id")
			  Sampleid = $(this).find("td:eq(2)").find("input:eq(1)").attr("id")
			 
			  ContainerValue = $(this).find("td:eq(3)").find("input:eq(0)").attr("id")
			  Containerid = $(this).find("td:eq(3)").find("input:eq(1)").attr("id")
			 
			 
			  RemarkValue = $(this).find("td:eq(5)").find("input:eq(0)").attr("id")
			  //Remarkid = $(this).find("td:eq(5)").find("input:eq(1)").attr("id")
			  
			  subChargeCodeId = $(this).find("td:eq(6)").find("input:eq(1)").attr("id")
			
			 
		} else{
			checkedChkBox = 'n';
		} 
		investigationArray.push(Investigationid);
		 sampleCollectionArray.push(Sampleid);
		 collectedArray.push(id);
		 remarkArray.push(RemarkValue);
		 ContainerArray.push(Containerid);
		 collectedCheckedArray.push(checkedChkBox);
		 subChargeCodeIdArray.push(subChargeCodeId);
		 
		  //alert("subChargeCodeIdArray :"+subChargeCodeIdArray); 
		 
		
	});
	
		
	$('#investigationsArray').val(investigationArray);
	$('#sampleCollectionsArray').val(sampleCollectionArray);
	$('#collectedArray').val(ContainerArray);
	$('#remarksArray').val(remarkArray);
	$('#collectedCheckBox').val(collectedCheckedArray);
	$('#subChargeCodeId').val(subChargeCodeIdArray);
	
}  


function submitSampleCollectionDetails(){
	$('#submitbtnId').prop("disabled", true);
	checkedSampleCollected();
	
	var orderhdId = $('#orderNumber').val();
	var hospitalId = $('#hospitalId').val();
	var lastChgBy = $('#userId').val();
	//var orderByDepartment=$('#').val();
	var orderStatus=$('#orderStatus').val();
	var patientId = $('#patientId').val();
	var validatedBy = $('#userId').val();
	
	var departmentName = $('#departmentName').val();
	var departmentId=$('#departmentId').val();
	var patientName = $('#patientName').val();
	
	document.pendingForSampleCollectionDetailsForm.action='${pageContext.request.contextPath}/lab/submitSampleCollectionDetails';
	document.pendingForSampleCollectionDetailsForm.method='POST'
	document.pendingForSampleCollectionDetailsForm.submit();
	
	
}

function Reset(){
	var count = $('#tblListOfInvestigations tr').length;
	
	for(var i=1;i<=count;i++){
		$('#remarkId'+i).val('');
	}
	
}

function backToWaitingList(){
	window.location = "pendingForSampleCollection";
}
</script>
