<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mobile Medical Unit- MMSSY</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    
<%@include file="..//view/commonJavaScript.jsp" %>
<script type="text/javascript">
<% 
String userId = "1";
if (session.getAttribute("user_id") != null) {
	userId = session.getAttribute("user_id") + "";
}
String distIdUsersVal = "";
if (session.getAttribute("distIdUsers") != null && session.getAttribute("distIdUsers") !="" ) {
	distIdUsersVal = session.getAttribute("distIdUsers").toString();
	//distIdUsersVal = distIdUsersVal.replace(",","");
}

String levelOfUser = "0";
if (session.getAttribute("levelOfUser") != null) {
	levelOfUser = session.getAttribute("levelOfUser").toString();
	levelOfUser = levelOfUser.replace(",","");
}

%>
var isDataLoaded= true;
var flageTypeName="track";
$(document).ready(function(){
	
	var distIdVal='<%=distIdUsersVal%>';
	if(distIdVal!='' && distIdVal!=null)
	{
		getMasUpssPhase();	
	}
	else
	{
		getMasPhase();
	} 
	
	var financialYearVal=${financialYear}
	
	 	if(financialYearVal!=undefined && financialYearVal!=""  && financialYearVal!="0000")
		finalFinancial=financialYearVal;
		else{
 			alert("Please mark Financial Year.");
		return false;
		}
 	 
	var currentDate="";
	var fromDate="";
	
	var sessionData = ${invoice_fromDate};
	
	var now = new Date();
		now.setDate(now.getDate());
		var day = ("0" + now.getDate()).slice(-2);
		var month = ("0" + (now.getMonth() + 1)).slice(-2);
		var today = (day)+"/"+(month)+"/"+now.getFullYear();
 		currentDate=  today;   	
		var now1 = new Date();
		now1.setDate(now1.getDate() - 7); // add -7 days to your date variable 
		
		var day1 = ("0" + now1.getDate()).slice(-2);
		var month1 = ("0" + (now1.getMonth() + 1)).slice(-2);
	//	var fromDate = (day1)+"/"+(month1)+"/"+now1.getFullYear();
		var fromDate = "01"+"/"+"04"+"/"+finalFinancial;
		$j('#fromDate').val(fromDate);
		$j('#toDate').val(currentDate);
		$("#upss").prop("checked", true);
		if(!isEmpty(sessionData)){
			setFieldValue(sessionData);
		}
		 
		getInvoiceDataReport();
});

function getMasPhase(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getMasPhase",
	    data: JSON.stringify({"PN" : "0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "<option value=\"\">--SELECT--</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		combo += '<option value='+result.data[i].phaseValue+'>' +result.data[i].phaseName+ '</option>';
	    		
	    	}
	    	jQuery('#phase').append(combo);
	    	//var phaseVal=localStorage.phase;
	    	//setTimeout( function() { $('#phase').val(phaseVal);}, 1000);
	    }
	    
	});
}


var phaseId='';
var phaseValue='';
var phaseName='';
function getMasUpssPhase(){
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
					'mmuSearch':'<%=distIdUsersVal%>'
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

function isEmpty(obj) {
    return Object.keys(obj).length === 0;
}
function setFieldValue(sessionData){
	$j('#fromDate').val(sessionData.fromDate);
	$j('#toDate').val(sessionData.toDate);
	$("input[name=mmuCity][value=" + sessionData.mmuCity + "]").prop('checked', true);
}
var totalInvoiceAmount=0;
var totalClearedAmount=0;
var totalUnClearedAmount=0;
var invoiceAmount=0;

function getInvoiceDataReport(){
	  totalInvoiceAmount=0;
	  totalClearedAmount=0;
	 totalUnClearedAmount=0;
	  invoiceAmount=0;
	
	if(isDataLoaded){
	isDataLoaded=false;
	$j("#tbl_invoiceData").empty();
	
	
	var fromDate=$j('#fromDate').val();
   	var currentDate=$j('#toDate').val();
   	var distIdVal='<%=distIdUsersVal%>';
	 var levelOfUser='<%=levelOfUser%>';
    if(fromDate!='' && currentDate!=''){
	   	var fromDates = fromDate.split('/');
		var toDates = currentDate.split('/');
		
	  	var startDate = new Date(fromDates[2]+"-"+fromDates[1]+"-"+fromDates[0]);
	   	var endDate = new Date(toDates[2]+"-"+toDates[1]+"-"+toDates[0]);
	   
	   	if (startDate > endDate){
	   		isDataLoaded=true;
	   	 	setSearchValue(false,"No Results");
	   		alert("To date should not be earlier than the From date");
	   		return;
	   	}
    }
   	setSearchValue(false,"Please wait....");
   	var mmuCity =$("input[name='mmuCity']:checked").val();
   	if(mmuCity==='U')
   		$j("#upsshead").html("UPSS");
   	else
   		$j("#upsshead").html("City");
   		
	var totalValue = 0;
	var phase=$j('#phase').val();
	if(phase=="" || phase==undefined){
		phase=0;
	}
	
	if(!isDataLoaded){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/dashboard/getInvoiceData",
	    data: JSON.stringify({"mmuCity" : mmuCity, "fromDate" : fromDate,"toDate" : currentDate,"phase":phase,"distIdVal":distIdVal,"levelOfUser":levelOfUser}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	isDataLoaded=true;
	    	console.log(result);
	    	var response = result.data.invoiceDataInfo;
	    	setSearchValue(true,response.length);
	    	
	    	
	    	for(var i=0;i<response.length;i++){
	    		genrateTable(i+1,response[i]);
	    		//alert("nnnn"+response[i].total_invoice);
	    		totalInvoiceAmount= parseInt(totalInvoiceAmount)+ parseInt(response[i].total_invoice);
	    		totalClearedAmount=parseInt(totalClearedAmount) + parseInt(response[i].cleared_amount);
	    		totalUnClearedAmount=parseInt(totalUnClearedAmount)+ parseInt(response[i].uncleared_amount);
	    		invoiceAmount=parseInt(invoiceAmount) + parseInt(response[i].invoice_amount);
	    	}
	    	generateFinalHtml();
	    },
	  	error: function(XMLHttpRequest, textStatus, errorThrown) { 
	  		isDataLoaded=true; 
	  		setSearchValue(true,0);
	    }    
	    
	});
	}
	}
}
function setSearchValue(isElementSize,data){
	if(isElementSize){
	  	//document.getElementById('serach_results').innerHTML =''+data+' matches';
	  	$('#serach_results').text(+data+' matches');
		document.getElementById('serach_results').style ='font-size: 15px; color: green;';
	}else{
		$('#serach_results').text(data);
		//document.getElementById('serach_results').innerHTML="'+data+'" ;
		document.getElementById('serach_results').style ='font-size: 15px; color: black;';
	}
}


function exportExcel(){
	 var distIdVal='<%=distIdUsersVal%>';
	 var levelOfUser='<%=levelOfUser%>';
	 var phase=$j('#phase').val();
	 var fromDate = $j("#fromDate").val();
	 var toDate = $j("#toDate").val();

	 if(fromDate ==''){
		 alert("Please select from Date");
		 return false;
	 }
	 if(toDate ==''){
		 alert("Please select to Date");
		 return false;
	 }
	 var mmuCity =$("input[name='mmuCity']:checked").val();
	 		
  window.location.href =  "${pageContext.request.contextPath}/dashboard/getInvoiceExcelReport?fromDate="
			+ fromDate
			+ "&toDate="
			+toDate
			+ "&mmuCity="
			+ mmuCity
			+ "&flageTypeName="
			+ flageTypeName
			+ "&phase="
			+ phase
			+ "&distIdVal="
			+ distIdVal
			+ "&levelOfUser="
			+ levelOfUser;

}
function exportPDF(){
	var distIdVal='<%=distIdUsersVal%>';
	 var levelOfUser='<%=levelOfUser%>';
	 var phase=$j('#phase').val();
	 var fromDate = $j("#fromDate").val();
	 var toDate = $j("#toDate").val();

	 if(fromDate ==''){
		 alert("Please select from Date");
		 return false;
	 }
	 if(toDate ==''){
		 alert("Please select to Date");
		 return false;
	 }
	 var mmuCity =$("input[name='mmuCity']:checked").val();
	 		
 var url = "${pageContext.request.contextPath}/report/invoiceDashboardReport?fromDate="
			+ fromDate
			+ "&toDate="
			+toDate
			+ "&mmuCity="
			+ mmuCity
			+ "&distIdVal="
			+ distIdVal
			+ "&levelOfUser="
			+ levelOfUser
			+ "&phase="
			+ phase;
 
 //window.open(url, '_blank');
 openPdfModel(url)

}
var tableRow="";
function genrateTable(seq,response){
	var iteration = $('#my-table tr').length;
	
	var message = JSON.stringify(response);
	
	var upss = "";
	if(response.upss!=undefined)
		upss = response.upss;
	else
		upss = response.city
		
	  tableRow='<tr>'+
	 	'<td>'+seq+'</td>'+
	 	'<td>'+upss+'</td>'+
	 	'<td><a class="btn-link" href="javascript:void(0);" onClick="showDiv('+response.upss_id+','+response.total_invoice+',2);">'+response.total_invoice+'</a></td>'+
	 	'<td><a class="btn-link" href="javascript:void(0);" onClick="showDiv('+response.upss_id+','+response.cleared_amount+',3);">'+response.cleared_amount+'</a></td>'+
	 	'<td><a class="btn-link" href="javascript:void(0);" onClick="showDiv('+response.upss_id+','+response.uncleared_amount+',4);">'+response.uncleared_amount+'</a></td>'+
	 	'<td><a class="btn-link" href="javascript:void(0);" onClick="showDiv('+response.upss_id+','+response.invoice_amount+',5);">'+response.invoice_amount+'</a></td>'+
	 	'<td><a class="btn-link" href="javascript:void(0);" onClick="showDiv('+response.upss_id+','+response.invoice_amount+',6);">View</a></td>'+
	 '</tr>';
	 $("#tbl_invoiceData").append(tableRow);
}
 
function generateFinalHtml(){
	
	var tableRowHtml='<tr>'+
 	'<td></td>'+
 	'<td>Total Amount</td>'+
 	'<td>'+totalInvoiceAmount+'</td>'+
 	'<td> '+totalClearedAmount+' </td>'+
 	'<td> '+totalUnClearedAmount+' </td>'+
 	'<td> '+invoiceAmount+'</td>'+
 	'<tr>';
	
	$("#tbl_invoiceData").append(tableRowHtml);
}

function showDiv(upss_id,amount,index){
	var fromDate = $j("#fromDate").val();
	 var toDate = $j("#toDate").val();
	 var mmuCity =$("input[name='mmuCity']:checked").val();
	 var distIdVal='<%=distIdUsersVal%>';
	 var levelOfUser='<%=levelOfUser%>';
	 var phase=$j('#phase').val();
	
	if(index===6){
		
			

			   var url="${pageContext.request.contextPath}/captureMedicine/invoiceDashboardMmuExpenditure?"
				+"fromDate="
				+ fromDate
				+ "&toDate="
				+toDate
				+ "&upss_id="
				+upss_id
				+ "&mmuCity="
				+ mmuCity
				+ "&distIdVal="
				+ distIdVal
				+ "&levelOfUser="
				+ levelOfUser
				+ "&phase="
				+ phase;	

		 window.location.href=url;
	}else{
	if(amount>0){
	console.log(index);
	 var url="";
	 if(index===2){
	 	 url = "${pageContext.request.contextPath}/captureMedicine/invoiceDashboardTotal?flagType=T&"
	 }
	 else if(index===3){
		  url = "${pageContext.request.contextPath}/captureMedicine/invoiceDashboardClear?flagType=C&"
	 }
	 else if(index===4){
		  url = "${pageContext.request.contextPath}/captureMedicine/invoiceDashboardClear?flagType=U&"
	 }
	 else if(index===5){
		  url = "${pageContext.request.contextPath}/captureMedicine/invoiceDashboardMedicine?"
	 }
	
	 url=url+"fromDate="
			+ fromDate
			+ "&toDate="
			+toDate
			+ "&upss_id="
			+upss_id
			+ "&mmuCity="
			+ mmuCity
			+ "&distIdVal="
			+ distIdVal
			+ "&levelOfUser="
			+ levelOfUser
			+ "&phase="
			+ phase;	

	 window.location.href=url;
	}
	}
}

</script>
</head>

<body>

    <!-- Begin page -->
    <div id="wrapper">
 
        <div class="content-page">
            <!-- Start content -->
            <div class="">
                <div class="container-fluid">
                 <div class="internal_Htext">Track Invoice Dashboard</div>
                  
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                      
                                       <div class="row">
										<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">From Date</label>
													</div>
													<div class="col-md-7">
														<div class="dateHolder">
															<input type="text" id="fromDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" onchange="">
														</div>
													</div>
												</div>
											</div>
											
											<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">To Date</label>
													</div>
													<div class="col-md-7">
														<div class="dateHolder">
															<input type="text" id="toDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" onchange="">
														</div>
													</div>
												</div>
												
											</div>
										 <div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Phase</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="phase"  >
													<!-- <option value="">Select</option>
												 	<option value="Phase1">Phase1</option>
													<option value="Phase2">Phase2</option> -->
												</select>
											</div>
										</div>
									</div>
											
											<div class="col-lg-1 col-sm-3">
												<div class="form-check form-check-inline cusRadio m-t-5 m-l-10">
													<input class="form-check-input" id='upss' type='radio' name="mmuCity" value="U">
													<span class="cus-radiobtn"></span> 
													<label class="form-check-label" for="2">UPSS</label>
												</div> 											
											</div>
											
											<div class="col-lg-1 col-sm-3">
												<div class="form-check form-check-inline cusRadio m-t-5 m-l-10">
													<input class="form-check-input" id='city' type='radio'  name="mmuCity" value="C">
													<span class="cus-radiobtn"></span> 
													<label class="form-check-label" for="1">City</label>
												</div> 											
											</div>

										<div class="col-md-2 text-right">											
												<button type="button" class="btn  btn-primary " onclick="getInvoiceDataReport();">Search</button>											
										</div>

									</div>
                                    
                                    
                                        
                                       <div class="row">
                                       	<div class="col-md-12 text-left">	
                                       	<label class="SearchStatus" style="font-size: 15px;" id="serach_results">Search Results</label>
                                       	</div>
                                       </div> 
                                        
                                        
                                        
                                    

					 
									<div class="scrollableDiv m-b-10">
                                    <table class="table table-striped table-hover table-bordered " id="my-table">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th rowspan="2">S.No.</th>
                                                <th rowspan="2" id="upsshead">UPSS</th> 
                                                <th colspan="3" class="text-center">MMU Operations</th>   
                                                <th colspan="2">Medicine Invoice</th>                                               
                                            </tr>
                                            <tr>                                                  
                                                <th>Total Invoice</th> 
                                                <th>Cleared Amount</th> 
                                                <th>Uncleared Amount</th> 
                                                <th>Invoice Amount</th>
                                                <th>MMU Expenditure</th>                                                                                             
                                            </tr>
                                        </thead>
                                     <tbody id="tbl_invoiceData">
										<!--  <tr>
										 	<td>1</td>
										 	<td><a class="btn-link" href="javascript:void(0);">UPSS 1</a></td>
										 	<td><a class="btn-link" href="javascript:void(0);">1,20,000</a></td>
										 	<td><a class="btn-link" href="javascript:void(0);">50,000</a></td>
										 	<td><a class="btn-link" href="javascript:void(0);">70,000</a></td>
										 	<td><a class="btn-link" href="javascript:void(0);">90,000</a></td>
										 </tr> -->
                     				 </tbody>
                                    </table>
								</div>
									<div class="row">

										<div class="col-md-12 text-right">										
												
										<button type="button" id="btnAddHospital"
											class="btn  btn-primary " onclick="exportExcel();">Excel</button>
										<button type="button" id="updateBtn"
											class="btn  btn-primary " onclick="exportPDF();">PDF</button>
													
										</div>
									</div>
										
                                

                                    <!-- end row -->

                                </div>
                            </div>
                            <!-- end card -->
                        </div>
                        <!-- end col -->
                    </div>
                    <!-- end row -->
                    <!-- end row -->

                </div>
                <!-- container -->

            </div>
            <!-- content -->

        </div>

        <!-- ============================================================== -->
        <!-- End Right content here -->
        <!-- ============================================================== -->

    </div>
    <!-- END wrapper -->

    <!-- jQuery  -->
    

</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>