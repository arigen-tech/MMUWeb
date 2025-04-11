<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
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
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>
<script>
<%
String cityId = "0";
if (session.getAttribute("cityIdUsers") != null) {
	cityId = session.getAttribute("cityIdUsers").toString();
	cityId = cityId.replace(",","");
	
}

String cityIdsss = "0";
if (session.getAttribute("cityIdUsers") != null) {
	cityIdsss = session.getAttribute("cityIdUsers").toString();
	cityIdsss = cityIdsss.replace(",","");
}

String distIdUsers = "0";
if (session.getAttribute("distIdUsers") != null) {
	distIdUsers = session.getAttribute("distIdUsers").toString();
	//distIdUsers = distIdUsers.replace(",","");
}

%>
var $j = jQuery.noConflict();
var districtList = "" ;
var sourceOfMedicines = "";
var meedicalStore= "";
var nPageNo=1;

$(document).ready(function(){
	//getSourceOfMedicine();
	getMasPhase();
	getDistrictList();
	getPendingInvoice('ALL');
	
});
var phaseId='';
var phaseValue='';
var phaseName='';
function getMasPhase(){
	var upssId=$('#district').val();
	var pathname = window.location.pathname;
	var accessGroup ="MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/master/getAllUpssPhaseMapping";
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'PN' :"0",
					'mmuSearch':'<%=distIdUsers%>'
					}),
				contentType : "application/json",
				type : "POST",
				 success: function(result){
				    	var combo = "<option value=\"\">Select</option>" ;
				    	
				    	for(var i=0;i<result.data.length;i++){
				    		combo += '<option value='+result.data[i].phaseValue+'>' +result.data[i].phaseName+ '</option>';
				    		
				    	}
				    	jQuery('#phase').append(combo);
				    	
				    }
				    
				});
	}
function showAll(){
	var text = "--SELECT--";
	 
	  //$("#vendorName").val(text).attr("selected",true);
	$('#fromDate').val("");
	$('#toDate').val("");
	$('#phase').val("");
	 $("#ditrictList option").filter(function() {
	    return this.text == text; 
	}).prop('selected',true);
	
	 

	nPageNo = 1;
	getPendingInvoice('ALL');
	//console.log("City "+ <%= cityId %>);
}
function showResultPage(pageNo){
	 
    nPageNo = pageNo;
    getPendingInvoice('FILTER');
}
function getPendingInvoice(MODE){
	 
	 
	var vendorName=$("#ditrictList").val();	
	 var fromDate=$('#fromDate').val();
	 var toDate=$('#toDate').val();
	 var phaseVal=$('#phase').val();
	 if(MODE == 'ALL'){
		var data = {"PN":nPageNo, "vendorName":"","headTypeId":"2"};			
	 }else{
			var data = {"PN":nPageNo, "vendorName":vendorName,"fromDate":fromDate,"toDate":toDate,"headTypeId":"2","phase":phaseVal};
	  } 
	var url = "searchMedicineInvoice";		
	var bClickable = true;
	GetJsonData('tblListmedicineInvoice',data,url,bClickable);	 
}
function getSourceOfMedicine(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "GET",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/captureMedicine/sourceOfMedicine",
	   
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	for(var i=0;i<result.data.length;i++){
	    		sourceOfMedicines += '<option value='+result.data[i].id+'>' +result.data[i].name+ '</option>';	
	    	}
	    	jQuery('#vendorName').append(sourceOfMedicines);
	    	
	    }
	    
	});
}
function makeTable(jsonData)
{	
	console.log(jsonData);
	var dataList = jsonData.data; 
	var htmlTable = "";	
	var data = jsonData.count; 
	
	var pageSize = 5; 	
	var dataList = jsonData.data; 
	const monthNames= ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

	
	for(i=0;i<dataList.length;i++)
		{		
		
		
			var data = dataList[i];
			var monthName = monthNames[data.billMonth-1];
			var status = data.status === 'S'?"Submitted":"Pending for submission";
			var parts=data.updatedDate.split('-');
			var invoiceDate = "";
			if(parts.length>1){
				invoiceDate=parts[2]+"/"+parts[1]+"/"+parts[0];
			}
			var phase="";
           	if(data.phase!="" && data.phase!=undefined){
           		phase=data.phase;
           	}else{
           		phase="";
           	}
			htmlTable = htmlTable+"<tr id='"+data.batchNo+"' >";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+data.districtName+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+data.cityName+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+phase+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+monthName+'/'+data.billYear+"</td>"; 
		
			htmlTable = htmlTable +"<td style='width: 150px;'>"+invoiceDate+"</td>";
		
			htmlTable = htmlTable +"<td style='width: 100px;'>"+status+"</td>"; 			
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='8'><h6>No Record Found</h6></td></tr>";
		   
		}			
	
	
	$j("#tblListmedicineInvoice").html(htmlTable); 
		
}
function getMedicineInvoiceList(){

	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/captureMedicine/medicineInvoiceList",
	   
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	console.log(result);
	    	for(var i=0;i<result.data.length;i++){
	    		var invoice = result.data[i];
	    		addRow(invoice);
	    	}
	    }
	    
	});
}
function getDistrictList(){
	//console.log("${pageContext.servletContext.contextPath}/master/getAllDistrict");
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getAllDistrict",
	    data: JSON.stringify({"PN" : "0","upssFlag":"Y","districtUser":'<%=distIdUsers%>'}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		districtList += '<option value='+result.data[i].districtId+'>' +result.data[i].districtName+ '</option>';
	    	}
	    	
	    	jQuery('#ditrictList').append(districtList);
	    
	    	
	    }
	    
	});
}
function searchMedicineInvoice(){
	
	  var vendorName=$("#ditrictList").val();
	  var fromDate=$('#fromDate').val();
	  var toDate=$('#toDate').val();
	  if(vendorName === '' && fromDate==='' && toDate===''){
		  alert("Please select at least one search parameter");
		  return false;
	  }
	  if(fromDate!='' && toDate!=''){
		var fromDates = fromDate.split('/');
		var toDates = toDate.split('/');
	  	var startDate = new Date(fromDates[2]+"-"+fromDates[1]+"-"+fromDates[0]);
	   	var endDate = new Date(toDates[2]+"-"+toDates[1]+"-"+toDates[0]);
	   	if (startDate > endDate){
	   		alert("To date should not be earlier than the From Date");
	   		return;
	   	}
	  }
	  nPageNo=1;
	  getPendingInvoice("FILTER");
}
function addRow(data){
	//var monthName = monthNames[data.billMonth-1];
	var iteration = $('#my-table tr').length;
	var status = data.action === 'S'?"Submitted":"Pending for submission";
	var newRowContent ='<tr>'+
	'<td id="th1" class ="inner_md_htext">'+data.districtName+'</th>'+
	'<td id="th2" class ="inner_md_htext">'+data.cityName+'</th>'+
	'<td id="th9" class ="inner_md_htext">'+data.phase+'</th>'+
   	'<td id="th3" class ="inner_md_htext">'+data.billMonth+'-'+data.billYear+'</th>'+
    '<td id="th4" class ="inner_md_htext">'+data.sourceOfMedicine+'</th>'+
    '<td id="th5" class ="inner_md_htext">'+data.invoiceNum+'</th>'+
    '<td id="th6" class ="inner_md_htext">'+data.invoiceDate+'</th>'+
    '<td id="th7" class ="inner_md_htext">'+data.invoiceAmount+'</th>'+
    '<td id="th8" class ="inner_md_htext">'+status+'</th>'+
	'</tr>';
	 $("#tblListmedicineInvoice").append(newRowContent);
}
function executeClickEvent(id,jsonData)
{
	window.location.href = "updateMedicineIssueIEC?id="+id;
	//console.log("ID : "+id+" Json Data :"+jsonData)
}
</script>
</head>
<body>
	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">View/Update IEC Invoice</div>
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">

								<div class="row">


									<!-- <div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Source Of medicine</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="vendorName" name="vendorName">
													<option value="">--SELECT--</option>
												</select>
											</div>
										</div>
									</div> -->
									
									
									<div class="col-md-4">
										<div class="row col-auto">
											<div class="col-md-5">
												<label class="col-form-label">Phase</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="phase"  >
													<!-- <option value="">--SELECT--</option>
												 	<option value="Phase1">Phase1</option>
													<option value="Phase2">Phase2</option> -->
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="row col-auto">
											<div class="col-md-5">
												<label class="col-form-label">UPSS</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="ditrictList" name="ditrictList">
													<option value="">--SELECT--</option>
												</select>
											</div>
										</div>
									</div>

									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">From Date</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" name="fromDate" id="fromDate"
														class="calDate form-control" value=""
														placeholder="DD/MM/YYYY" />
												</div>


											</div>
										</div>
									</div>

									<div class="col-md-4">
										<div class="row col-auto">
											<div class="col-md-5">
												<label class="col-form-label">To Date</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" name="toDate" id="toDate"
														class="calDate form-control" value=""
														placeholder="DD/MM/YYYY" />
												</div>
											</div>
										</div>
									</div>

								</div>
								<div class="row">


									<div class="col-md-12 text-right">
										<input type="button" type="button" class="btn  btn-primary "
											onclick="searchMedicineInvoice();" value="Search" /> <input
											type="button" type="button" class="btn  btn-primary "
											onclick="showAll();" value="Show All" />
									</div>



								</div>

								<div style="float: left">

									<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatus" style="font-size: 15px;"
												align="left">Search Results</td>
											<td></td>
										</tr>
									</table>
								</div>
								<div style="float: right">
									<div id="resultnavigation"></div>
								</div>
								
									
										<table class="table table-hover table-bordered table-striped">
											<thead class="bg-success" style="color: #fff;">
												<tr>
													<th id="th1" class="inner_md_htext">UPSS</th>
													<th id="th2" class="inner_md_htext">City</th>
													<th id="th9" class="inner_md_htext">Phase</th>
													<th id="th3" class="inner_md_htext">Month/Year</th>
													
													
													<th id="th6" class="inner_md_htext">Updated Date</th>
													
													<th id="th8" class="inner_md_htext">Status</th>
												</tr>
											</thead>

											<tbody class="clickableRow" id="tblListmedicineInvoice">

											</tbody>
										</table>
									
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>