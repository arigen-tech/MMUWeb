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
<script>
var modelRequest = null;
var modelResponse= null;
var totalAmounts = 0;
var upssName = ""
var cityName = "";
var typeName="";
$(document).ready(function(){
	var currentDate="";
	var fromDate="";
	modelRequest = ${requestParam};
	var flagType =modelRequest.flagType;
	if(flagType==='C'){
		document.getElementById('tr_unclear').style='display:none;';
		$('#divTitle span.test').text('MMU Invoice Dashboard - Cleared');
	}
	else{
		document.getElementById('tr_clear').style='display:none;';
		$('#divTitle span.test').text('MMU Invoice Dashboard - UnCleared');
	}

	modelResponse = ${response};
	console.log(modelRequest);
	console.log(modelResponse);
	var response = modelResponse.data.invoiceDataInfo;
	document.getElementById('serach_results').innerHTML =''+response.length+' matches';
	document.getElementById('serach_results').style ='font-size: 15px; color: green;';
	for(var i=0;i<response.length;i++){
		var resp = response[i];
		if(resp.city===undefined){
			upssName = resp.upss;
		}else{
			cityName = resp.city
		}
		
		if(flagType==='C'){
			totalAmounts+= Number(resp.total_invoice);
			genrateClearTable(i+1,resp);
		}
		else{
			totalAmounts+= Number(resp.total_invoice);
			genrateUnClearTable(i+1,resp);
		}
	}
	
	if(cityName===""){
		document.getElementById('upssName').innerHTML ='UPSS';
		document.getElementById('upssValue').value = upssName;
		typeName = upssName;
	}else{
		document.getElementById('upssName').innerHTML ='City';
		document.getElementById('upssValue').value =cityName;
		typeName= cityName;
	}
	document.getElementById('totalInvoiceAmount').value =totalAmounts;
	document.getElementById('fromDate').value=modelRequest.fromDate;
	document.getElementById('toDate').value=modelRequest.toDate;
	document.getElementById('phase').value=modelRequest.phase;
	
});
function genrateClearTable(seq,response){
	var iteration = $('#my-table tr').length;
	
	var tableRow='<tr>'+
	 	'<td>'+seq+'</td>'+
	 	'<td>'+response.vendor+'</td>'+
	 	'<td>'+response.mmu+'</td>'+
	 	'<td>'+response.invoice_date+'</td>'+
	 	'<td>'+response.invoice_no+'</td>'+
	 	'<td>'+response.total_invoice+'</td>'+
	 	'<td>'+response.cleared_amount+'</td>'+
	 	'<td>'+response.penalty_amount+'</td>'+
	 	'<td>'+response.tds_deduction+'</td>'+
	 	'<td>'+response.upload_date+'</td>'+
	 	'<td>'+response.last_approval_status+'</td>'+
	 	'<td><a class="btn-link" href="javascript:void(0);" onClick="showFile(\''+response.file_view+'\',\''+response.invoice_no+'\');">'+response.file_view+'</a></td>'+
	 	'<td><a class="btn-link" href="javascript:void(0);" onClick="showView('+response.approval+');">View<a></td>'+
	 '</tr>';
	 $("#tbl_invoiceData").append(tableRow);
	
	
}
function backScreen(){
	var url = "${pageContext.request.contextPath}/captureMedicine/invoiceDashboard";
	window.location=url;
}
function showPreveiousVisit() {
	//	alert("123");
		// var patientId = document.getElementById("patientIdNew").value;
		var popup;
		 popup = window.open("showPatientHistory?patientId="+$('#patientIdNew').val()+"", "popUpWindow", "height=500,width=800,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
                popup.focus();
		
		  
			 
}
function showView(approval){
	var popup = window.open("${pageContext.servletContext.contextPath}/captureMedicine/authorityWiseStatus?id="+approval,  "popUpWindow", "height=500,width=800,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes");
	popup.focus();
}
function showFile(fileName,invoice_no){
	//window.open("${pageContext.servletContext.contextPath}/audit/download?fileName="+fileName.innerHTML, '_blank').focus();
	window.open("${pageContext.servletContext.contextPath}/audit/download?name="+fileName+"&type=vendor_bill&keys="+invoice_no, '_blank').focus();
}

function genrateUnClearTable(seq,response){
	var iteration = $('#my-table tr').length;
	var total_invoice = response.total_invoice;
	if(total_invoice ===undefined)
		total_invoice ="";
	var tableRow='<tr>'+
	 	'<td>'+seq+'</td>'+
	 	'<td>'+response.vendor+'</td>'+
	 	'<td>'+response.mmu+'</td>'+
	 	'<td>'+response.invoice_date+'</td>'+
	 	'<td>'+response.invoice_no+'</td>'+
	 	'<td>'+total_invoice+'</td>'+
	 	'<td>'+response.uncleared_amount+'</td>'+
	 	'<td>'+response.upload_date+'</td>'+
	 	'<td>'+response.last_approval_status+'</td>'+
	 	'<td><a class="btn-link" href="javascript:void(0);" onClick="showFile(\''+response.file_view+'\',\''+response.invoice_no+'\');">'+response.file_view+'</a></td>'+
	 	'<td><a class="btn-link" href="javascript:void(0);" onClick="showView('+response.approval+');">View<a></td>'+
	 '</tr>';
	 $("#tbl_invoiceData").append(tableRow);
}

function exportExcel(){
	 var distIdVal='<%=distIdUsersVal%>';
	 var levelOfUser='<%=levelOfUser%>';
	 var phase=$j('#phase').val();
	 var fromDate =modelRequest.fromDate;
	 var toDate = modelRequest.toDate;
	 var upss_id = modelRequest.upss_id;
	 var mmuCity =modelRequest.mmuCity;
	 var flagType = modelRequest.flagType;
	 		
window.location.href =  "${pageContext.request.contextPath}/dashboard/getInvoiceDashboardExcelReport?fromDate="
			+ fromDate
			+ "&toDate="
			+toDate
			+ "&upss_id="
			+upss_id
			+ "&flagType="
			+flagType
			+ "&mmuCity="
			+ mmuCity
			+"&upss_name="
			+typeName
			+ "&phase="
			+ phase
			+ "&distIdVal="
			+ distIdVal
			+ "&levelOfUser="
			+ levelOfUser;		

}
function exportPDF(){
	var phase=$j('#phase').val();
	 var fromDate =modelRequest.fromDate;
	 var toDate = modelRequest.toDate;
	 var upss_id = modelRequest.upss_id;
	 var mmuCity =modelRequest.mmuCity;
	 var flagType = modelRequest.flagType;
	 		
var url = "${pageContext.request.contextPath}/report/medicineInvoiceDashboardTCUReport?fromDate="
	+ fromDate
	+ "&toDate="
	+toDate
	+ "&upss_id="
	+upss_id
	+ "&flagType="
	+flagType
	+ "&mmuCity="
	+ mmuCity
	+ "&phase="
	+ phase;
openPdfModel(url);
//window.open(url, '_blank');

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
                 <div class="internal_Htext" id="divTitle"><span class="test">Invoice Dashboard - Cleared</span></div>
                  
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                      
                                       <div class="row">
                                          <div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">Phase</label>
													</div>
													<div class="col-md-7">
														<input type="text"  class="form-control" readonly id="phase"/>
													</div>
													
												</div>
											</div>
										<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label" id="upssName">UPSS</label>
													</div>
													<div class="col-md-7">
														<input type="text" value="UPSS1" class="form-control" readonly id="upssValue"/>
													</div>
												</div>
											</div>
											<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">From Date</label>
													</div>
													<div class="col-md-7">
														<input type="text"  class="form-control" readonly id="fromDate"/>
													</div>
												</div>
											</div>
											<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">To Date</label>
													</div>
													<div class="col-md-7">
														<input type="text"  class="form-control" readonly id="toDate"/>
													</div>
												</div>
											</div>
											
											
										<!-- 	<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">Final Payment</label>
													</div>
													<div class="col-md-7">
														<input type="text" value="0" class="form-control" readonly id="finalInvoiceAmount"/>
													</div>
												</div>
											</div> -->
												
											</div>
											
											

                                    
                                    
                                        
                                        
                                        
                                        
                                        
                                    

					 <div class="row">
                                       	<div class="col-md-12 text-left">	
                                       	<label class="SearchStatus" style="font-size: 15px;" id="serach_results">Search Results</label>
                                       	</div>
                                       </div> 
                                        
                                        
                                        
                                    

					 
									<div class="scrollableDiv m-b-10"> 

                                    <table class="table table-striped table-hover table-bordered " id="my-table">
                                        <thead class="bg-success" style="color:#fff;" >
                                           
                                            <tr id="tr_clear">                                                  
                                                <th>S.No.</th> 
                                                <th>Vendor</th> 
                                                <th>MMU</th> 
                                                <th>Invoice Date</th>                                                     
                                                <th>Invoice No.</th>
                                                <th>Invoice Amount</th>
                                                <th>Cleared Amount</th>
                                                <th>Penalty Amount</th>
                                                <th>Total Deductions</th>
                                                <th>Upload Date</th>
                                                <th>Last Approved Status</th>
                                                <th>View</th>
                                                <th>Track</th>                                          
                                            </tr>
                                            <tr id="tr_unclear">                                                  
                                                <th>S.No.</th> 
                                                <th>Vendor</th> 
                                                <th>MMU</th> 
                                                <th>Invoice Date</th>                                                     
                                                <th>Invoice No.</th>
                                                <th>Invoice Amount</th>
                                                <th>Uncleared Amount</th>
                                                <th>Upload Date</th>
                                                <th>Last Approved Status</th>
                                                <th>View</th>
                                                <th>Track</th>                                          
                                            </tr>
                                        </thead>
                                     <tbody id="tbl_invoiceData">
										 
                     				 </tbody>
                                    </table>
                                    </div>
<div class="row">
<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label" id="">Total</label>
													</div>
													<div class="col-md-7">
														<input type="text" value="0" class="form-control" readonly id="totalInvoiceAmount"/>
													</div>
												</div>
											</div>
										<div class="col-md-8 text-right">										
												
										<button type="button" id="btnAddHospital"
											class="btn  btn-primary " onclick="exportExcel();">Excel</button>
										<button type="button" id="updateBtn"
											class="btn  btn-primary " onclick="exportPDF();">PDF</button>
													<button type="button" id="backBtn"
											class="btn  btn-primary " onclick="backScreen();">Back</button>				
										</div>
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
    <script>
 
    </script>

</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>