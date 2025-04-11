<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.mmu.web.utils.HMSUtil"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

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

String districtId = "0";
if (session.getAttribute("distIdUsers") != null) {
	districtId = session.getAttribute("distIdUsers") + "";
	districtId = districtId.replace(",", "");
}

String userId = "1";
if (session.getAttribute("user_id") != null) {
	userId = session.getAttribute("user_id") + "";
}

String levelOfUser = "1";
if (session.getAttribute("levelOfUser") != null) {
	levelOfUser = session.getAttribute("levelOfUser") + "";
}
%>
<script type="text/javascript">

	var $j = jQuery.noConflict();
	
	$j(document).ready(function()
			{
		GetDistrictList();
		
		
			});
	
	
	function GetDistrictList(){
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "${pageContext.servletContext.contextPath}/master/getAllDistrict",
		    data: JSON.stringify({"PN" : "0"}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	var combo = "" ;
		    	
		    	for(var i=0;i<result.data.length;i++){
		    		combo += '<option value='+result.data[i].districtId+'>' +result.data[i].districtName+ '</option>';
		    		
		    	}
		    	
		    	jQuery('#district').append(combo);
		    	$j("#district").val(<%=districtId%>);
		    }
		    
		});
	}
	</script>

</head>
<%
     HttpSession sessionJsp = request.getSession(false);// don't create if it doesn't exist

	if(sessionJsp == null || sessionJsp.isNew()) {
			return;
		}
    

String deptId = HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim();
/* if (session.getAttribute("departmentId") != null) {
	deptId = Long.parseLong(session.getAttribute("departmentId").toString());
} */





%>

<body>
	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">Stock Status Report (DO)</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<div class="row">
										<div class="col-md-12"><p align="Left" id="message"	style="color: green; font-weight: bold;"></p></div>
									</div>
									<form name="frm">
									<div class="row">
									
									<!-- <div class="col-md-3">
												<div class="form-group row">
													<div class="col-md-4">
														<label class="col-form-label">MMU</label>
													</div>
													<div class="col-md-8">
														<select class="form-control" id="mmuId">
														<option value="0">All</option>
														</select>
													</div>
												</div>
										</div> -->
										
										<div class="col-md-3">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">District</label>
												</div>
												<div class="col-md-7">
													<select class="form-control" id="district">
												    
												</select>
												</div>
											</div>
										</div>		
										
										<div class="col-md-3">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Drug Code</label>
												</div>
												<div class="col-md-7">
													<input type="text" class="form-control"  autocomplete="off"  id="pvmsNo" name="pvms" onKeyUp="getNomenClatureList(this,'fillItemAndValues','store','getDataForStockStatusReport','store_pvms')"/>
													<div id="divPvms1" class="autocomplete-itemsNew"></div>
												</div>
											</div>
										</div>

										<div class="col-md-5">
											<div class="form-group row">
												<div class="col-md-3">
													<label for="service" class="col-form-label">Drug Name</label>
												</div>
												<div class="col-md-9">
													<input type="text" autocomplete="off" class="form-control" id="nomenclature" name="nomenclature" onKeyUp="getNomenClatureList(this,'fillItemAndValues','store','getDataForStockStatusReport','store_nomen')"/>
													<div id="divNomen1" class="autocomplete-itemsNew"></div>
												</div>
											</div>
										</div>
										<div class="w-100"></div>
									
										<input type="hidden" class="form-control" id="itemId" name="itemId" value="0" />
										<input type="hidden" class="form-control" id="deptId" name="deptId" value="<%=deptId%>"/>
									   <!--  <input type="hidden" id="urlForReport" name="urlForReport" value=""> -->
									
										<div class="col-md-3">
											<div class="form-group row">
												<div class="col-md-5 m-t-5">
													<div class="form-check form-check-inline cusRadio ">
														<input class="form-check-input" type="radio"  id="radioSummary" checked name="radioStockStatus" value="S"> 
														<span class="cus-radiobtn"></span> 
														<label class="form-check-label" for="radiobtn1">Summary</label>
													</div>
												</div>
												<div class="col-md-6 m-t-5 ">
													<div class="form-check form-check-inline cusRadio">
														<input class="form-check-input" type="radio" id="radioDetail" name="radioStockStatus" value="D"> 
														<span class="cus-radiobtn"></span> 
														<label class="form-check-label" for="radiobtn1">Detail</label>
													</div>
												</div>
											</div>
										</div>
										</div>
										
										
									<div class="row m-t-10 m-b-10">	
										<div class="col-12 text-right">
											<input  disabled type="button" id="btnGenerated" class="btn btn-primary" onclick="generateStockStatusReport('R')" value="Generate Report"/>
											<button disabled type="button" id="printReportButton" class="btn btn-primary"  onclick="printStockStatusReport('P')">Print Report</button>
											<button type="reset" name="Reset" id="reset"  class="btn btn-danger" accesskey="r" onclick="resetData()">Reset</button>
										</div>
									</div>
									
									</form>
									
									
									<div id="divSummary"  class="scrollableDiv table-responsive"  style="display:none">
									<table class="table table-hover table-striped table-bordered m-t-10"  >
										<thead class="bg-primary">
											<tr>
												<th>S.No.</th>
												<th>Drug Code</th>
												<th>Drug Name</th>
												<th>A/U</th>
												<th>Stock Qty</th>
											</tr>
										</thead>
										<tbody id="tblStockStatusSummary">
										</tbody>
									</table>
									</div>
									
									
									<div id="divDetails"  class="scrollableDiv table-responsive"  style="display:none">
									<table class="table table-hover table-striped table-bordered m-t-10"  >
										<thead class="bg-primary">
											<tr>
												<th>S.No.</th>
												<th>Drug Code</th>
												<th>Drug Name</th>
												<th>A/U</th>
												<th>Batch No.</th>
												<th>DOM</th>
												<th>DOE</th>
												<th>Stock Qty</th>
												<th>Medicine Source</th>
												<th>Manufacturer</th>
											</tr>
										</thead>
										<tbody id="tblStockStatusDetails">
										</tbody>
									</table>
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
</body>
<script>
//scrollbar script
$(function(){
var winHeight = $(window).height();
$('.scrollableDiv').css({'height':'300px'});

// add custom scroll to sscrollableDiv class
    /* $('.scrollableDiv').slimscroll({
        height: 'auto',
        position: 'right',
        color: '#9ea5ab',
        touchScrollStep: 50
    }); */
    
})

</script>

<script type="text/javascript">

$j(document).ready(function() {
	getMMUList();
	$('#uid').hide();
	if(<%=deptId%>!=0){
		getDataForStockStatusReport();
		 $j("#btnGenerated").attr("disabled", false);
	     $j("#printReportButton").attr("disabled", false);
	}else{
		$j("#btnGenerated").attr("disabled", true);
    	$j("#printReportButton").attr("disabled", true);
    	alert("Select the department");
		return false;
	}
	
	
});


function getMMUList(){
	var params = {
			"levelOfUser":'<%=levelOfUser%>',
			"userId": <%=userId%>
	}
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : '${pageContext.request.contextPath}/master/getMMUHierarchicalList',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(result) {
			   var mmuDrop = '';
			   var data=result.mmuListdata;
			   
			   if(data.mmuList.length =='1'){
				   $('#mmuId').attr('disabled', true);
				   for(i=0;i<data.mmuList.length;i++){
						mmuDrop += '<option value='+data.mmuList[i].mmu_id+' selected>'+data.mmuList[i].mmu_name+'</option>';
						
					}
					$j('#mmuId').append(mmuDrop);
				   
			   }
			   else{
				for(i=0;i<data.mmuList.length;i++){
					mmuDrop += '<option value='+data.mmuList[i].mmu_id+'>'+data.mmuList[i].mmu_name+'</option>';
					
				}
				$j('#mmuId').append(mmuDrop);
			  }
		},
		error : function(data) {
			alert("An error has occurred while contacting the server");
		}
	}); 
	}


var nomenclatureArry = new Array();
var pvmsNumberArry = new Array();
var itemDataList = '';
function getDataForStockStatusReport() {
	var hospitalId = $j('#hospitalId').val();
	var params = {
		"hospitalId" : hospitalId
	}
	$j.ajax({
		type : "POST",
		contentType : "application/json",
		url : 'getDataForStockStatusReport',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(res) {
			if (res.status == "1") {
				itemDataList = res.storeItemList;
				for (i = 0; i < itemDataList.length; i++) {
					itemId = itemDataList[i].itemId;

					nomenclatureList = itemDataList[i].nomenclature;
					nomenclatureName = nomenclatureList + "[" + itemId
							+ "]";
					nomenclatureArry.push(nomenclatureName);

					pvmsNumberList = itemDataList[i].pvmsNumber;
					pvmsNumberArry.push(pvmsNumberList);

				}
				
				var groupValues = "";
				var groupList=res.groupList;
				for (group = 0; group < groupList.length; group++) {
					groupValues += '<option value='+groupList[group].storeGroupId+'>'
								+ groupList[group].storeGroupName
								+ '</option>';
			 }
			 $j('#group').append(groupValues); 	
				
			 
				var sectionValues = "";
				var sectionList=res.sectionList;
				for (sectionCount = 0; sectionCount < sectionList.length; sectionCount++) {
					sectionValues += '<option value='+sectionList[sectionCount].sectionId+'>'
								+ sectionList[sectionCount].sectionName
								+ '</option>';
			 }
			 $j('#section').append(sectionValues); 	
				
			} else {

				// when status is 0, there is no related data masStoreItem
			}

		},
		error : function(msg) {
			alert("An error has occurred while contacting the server");
		}
	});

}



function fillItemAndValues(item, psvn_nomen) {
	var count = item.substring(12); // this code commonly use for pvmsNumberId/nomenclturId input 
	var index1 = psvn_nomen.lastIndexOf("[");
	var index2 = psvn_nomen.lastIndexOf("]");
	index1++;
	var itemId = psvn_nomen.substring(index1, index2);
	
	for (var i = 0; i < itemDataList.length; i++) {
		if (psvn_nomen == itemDataList[i].pvmsNumber) {
			$('#itemId' + count).val(itemDataList[i].itemId);
			$('#pvmsNo' + count).val(itemDataList[i].pvmsNumber);
			$('#nomenclature' + count).val(itemDataList[i].nomenclature);
			

		} else if (itemId == itemDataList[i].itemId) {
			$('#itemId' + count).val(itemDataList[i].itemId);
			$('#pvmsNo' + count).val(itemDataList[i].pvmsNumber);
			$('#nomenclature' + count).val(itemDataList[i].nomenclature);
		}
	}

}

function resetDiv(){
	 $j('#divSummary').hide();
	  $j("#tblStockStatusSummary").empty();
}

function generateStockStatusReport(reportFlag){
		 var radioValue = $j("input[name='radioStockStatus']:checked").val();
			var itemId = $('#itemId').val();
			var mmuId = $('#mmuId').val();
			var deptId = $('#deptId').val();
			var params ={
					"radioValue":radioValue,
					"itemId":itemId,
					"mmuId":mmuId,
					"reportFlag":reportFlag,
					"districtId": $('#district').val(),
					"deptId":deptId
			}
			$j.ajax({
				type : "POST",
				contentType : "application/json",
				url : 'generateStockStatusReportDo',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(data) {
					if(data.status==1){
						  var htmlTable = "";
						  var dataList = data.storeStockData;
						  var reportType=data.reportType;
						  if(reportType=="D"){
							  $j('#message').html("");
							  $j('#divSummary').hide();
							  $j("#tblStockStatusSummary").empty();
							  for (item = 0; item < dataList.length; item++) {
								  count = parseInt(item)+1;
						    	  htmlTable = htmlTable + "<tr>";
						    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + count + "</td>";
						    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].pvmsNo + "</td>";
						    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].nomenclature + "</td>";
						    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].acUnit + "</td>";
						    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].batchNo + "</td>";
						    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].manufactureDate + "</td>";
						    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].expDate + "</td>";
						    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].closingBalanceQty + "</td>";
						    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].supplierTypeName + "</td>";
						    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].supplierName + "</td>";
						      }
							  $j("#tblStockStatusDetails").html(htmlTable);
							  $j('#divDetails').show();
						  }else{
							  $j('#message').html("");
							  $j('#divDetails').hide();
							  $j("#tblStockStatusDetails").empty();
							 
								  for (item = 0; item < dataList.length; item++) {
								  count = parseInt(item)+1;
						    	  htmlTable = htmlTable + "<tr>";
						    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + count + "</td>";
						    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].pvmsNo + "</td>";
						    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].nomenclature + "</td>";
						    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].acUnit + "</td>";
						    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].closingBalanceQty + "</td>";
						      }
							  $j("#tblStockStatusSummary").html(htmlTable);
							  $j('#divSummary').show();
						  }
						  
						
					}else{
						 $j("#tblStockStatusSummary").empty();
						 $j("#tblStockStatusDetails").empty();
						 $j('#divSummary').hide();
						 $j('#divDetails').hide();
					 /*  $j('#message').html("No Record found"); */
						alert("No Record found");
					}
				},
				error : function(msg) {
					alert("An error has occurred while contacting the server");
				}
			});
	 }
	

function resetData(){
	$j('#message').html("");
	$j("#tblStockStatusSummary").empty();
	$j("#tblStockStatusDetails").empty();
	$j('#divSummary').hide();
	$j('#divDetails').hide();
	$('#mmuId').attr('disabled', false);
	$j('#pvmsNo').val("");
	$j('#nomenclature').val("");
	$j('#group').val("0");
	$j('#section').val("0");
	$j('#itemId').val("0");
	
	

}


function printStockStatusReport(flag){
	 
		 var deptId = $('#deptId').val();
		 var radioStockStatus =$j("input[name='radioStockStatus']:checked").val();
		 var pvms =$j('#pvmsNo').val();
		 var nomenclature =$j('#nomenclature').val();
		 var districtId = $j('#district').val();
		 var User_id = <%=userId%>;
         var Level_of_user = '<%=levelOfUser%>';
        
		 var url="${pageContext.request.contextPath}/store/printStockStatusReportDo?districtId="+districtId+"&deptId="+deptId
				 +"&radioStockStatus="+radioStockStatus+"&pvms="+pvms+"&nomenclature="+nomenclature
				 +"&User_id="+User_id
				 +"&Level_of_user="+Level_of_user;
		 openPdfModel(url);
		 
	
}


</script>
</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>