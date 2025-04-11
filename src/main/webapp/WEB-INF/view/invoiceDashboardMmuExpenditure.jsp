<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
 <script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/commonformodal.js"></script>	
    
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
var modelRequest = null;
var modelResponse= null;
var totalAmounts = 0;
var upssName = ""
var cityName = "";
var typeName ="";
$(document).ready(function(){
	var currentDate="";
	var fromDate="";
	modelRequest = ${requestParam};
	modelResponse = ${response};
	console.log(modelRequest);
	console.log(modelResponse);
	var response = modelResponse.data.mmuInvoiceDataInfo;
	if(response.length>0){
		var link = document.getElementById('nodata_screen');
		link.style.visibility = 'hidden';
	document.getElementById('serach_results').innerHTML =''+response.length+' matches';
	document.getElementById('serach_results').style ='font-size: 15px; color: green;';
	for(var i=0;i<response.length;i++){
		var resp = response[i];
		if(resp.upss!=undefined){
			upssName = resp.upss;
		}if(resp.city!=undefined){
			cityName = resp.city
		}
		totalAmounts+= Number(resp.tc);
		genrateTable(i+1,resp);
	}
	if(modelRequest.mmuCity==="U"){
		document.getElementById('upssName').innerHTML ='UPSS';
		document.getElementById('upssValue').value = upssName;
		typeName =upssName;
	}else{
		document.getElementById('upssName').innerHTML ='City';
		document.getElementById('upssValue').value = cityName;
		typeName=cityName;
	}

	document.getElementById('totalInvoiceAmount').value =totalAmounts;
	document.getElementById('fromDate').value=modelRequest.fromDate;
	document.getElementById('toDate').value=modelRequest.toDate;
	}
	else{
		var link = document.getElementById('main_screen');
		link.style.visibility = 'hidden';
		
	}
});
var fromDateG="";
var currentDateG="";
function getInvoiceDataReport(){
	$j("#tbl_invoiceData").empty();
	
	
	var fromDate=$j('#fromDate').val();
	 
   	var currentDate=$j('#toDate').val();
    
   	var mmuCity =$("input[name='mmuCity']:checked").val();
   	if(mmuCity==='U')
   		$j("#upsshead").html("UPSS");
   	else
   		$j("#upsshead").html("City");
   		
   	console.log(mmuCity)
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/dashboard/getInvoiceData",
	    data: JSON.stringify({"mmuCity" : mmuCity, "fromDate" : fromDate,"toDate" : currentDate}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	console.log(result);
	    	var response = result.data.invoiceDataInfo;
	    	for(var i=0;i<response.length;i++){
	    		genrateTable(i+1,response[i]);
	    	}
	    }
	    
	});
}
function exportExcel(){

	 var fromDate =modelRequest.fromDate;
	 var toDate = modelRequest.toDate;
	 var upss_id = modelRequest.upss_id;
	 var mmuCity =modelRequest.mmuCity;
	 		
  window.location.href =  "${pageContext.request.contextPath}/dashboard/getMMUMedicineInvoiceExcelReport?fromDate="
			+ fromDate
			+ "&toDate="
			+toDate
			+ "&upss_id="
			+upss_id
			+ "&mmuCity="
			+ mmuCity	
  			+ "&upss_name="
			+ typeName;
  
}
function exportPDF(){
 	 
	 var fromDate =modelRequest.fromDate;
	 var toDate = modelRequest.toDate;
	 var upss_id = modelRequest.upss_id;
	 var mmuCity =modelRequest.mmuCity;
	 		
 var url = "${pageContext.request.contextPath}/report/mmuExpenditureMedicineReport?fromDate="
	 + fromDate
		+ "&toDate="
		+toDate
		+ "&upss_id="
		+upss_id
		+ "&mmuCity="
		+ mmuCity;	
 
 //window.open(url, '_blank');
 openPdfModel(url);
}
function genrateTable(seq,response){
	fromDateG=modelRequest.fromDate;
	currentDateG = modelRequest.toDate;
	  
     
	var iteration = $('#my-table tr').length;
		
	var tableRow='<tr>'+
	 	'<td>'+seq+'</td>'+
	 	'<td>'+response.mmu_name+'</td>'+
	 	'<td>'+response.te+'</td>'+
	 	/* '<td>'+response.tc+'</td>'+ */
	  
	 	'<td><a class="btn-link" href="javascript:void(0);" onClick="showInvoiceDiv('+response.mmu_id+','+fromDateG+','+currentDateG+');">'+response.tc+'</a></td>'+
	 
	 '</tr>';
	 $("#tbl_invoiceData").append(tableRow);
}
function showFile(fileName){
	window.open("${pageContext.servletContext.contextPath}/captureMedicine/download?fileName="+fileName.innerHTML, '_blank').focus();
}

function backScreen(){
	var url = "${pageContext.request.contextPath}/captureMedicine/invoiceDashboard";
	window.location=url;
}

function showInvoiceDiv(mmuId,fromDate,toDate) {
	/*$('.modal-backdrop').hide();*/
	$('#exampleModal').show();
	$('.modal-backdrop').show();
	 
	var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";
	 var urlPreviousVisit = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/dashboard/showInvoiceModal?mmuId="+mmuId+"&fromDate="+fromDate+"&toDate="+toDate;
	$('#exampleModal .modal-body').load(urlPreviousVisit);
    $('#exampleModal .modal-title').text('Indent History');
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
                 <div class="internal_Htext">MMU Expenditure</div>
                  
                   
                    <div class="row">
                        <div class="col-12" >
                            <div class="card" >
                                <div class="card-body" >
                              <div class="row" id="nodata_screen">
                                       	<div class="col-lg-4 col-sm-6 text-left">	
                                       	<label class="SearchStatus" style="font-size: 15px;">No Data Available</label>
                                       	</div>
                                       	<div class="col-md-8 text-right">										
											
										<button type="button" id="backBtn2"
											class="btn  btn-primary " onclick="backScreen();">Back</button>				
										</div>
                               </div> 
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>

                                      <div id="main_screen">
                                       <div class="row">
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
											
											
											<!-- <div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">Invoice Amount</label>
													</div>
													<div class="col-md-7">
														<div class="dateHolder">
															<label class="col-form-label" id="lbltotalInvoiceAmount">0</label>
														</div>
													</div>
												</div>
												
											</div> -->
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
                                             <th >S.No.</th>                                              
                                                <th>MMU</th> 
                                                <th>Total Expenditure</th> 
                                                <th>Total Consumption</th> 
                                                                                           
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
														<label class="col-form-label">Total Consumptions</label>
													</div>
													<div class="col-md-7">
														<input type="text" value="1,20,0000" class="form-control" readonly id="totalInvoiceAmount"/>
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
        
        <div class="modal" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
		  <div class="modal-dialog modal-xl" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title font-weight-bold"></h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <div class="text-center text-theme text-sm">
		         Loading <i class="fa fa-spin fa-spinner"></i>
		        </div>
		      </div> 
		       <!-- <div class="text-center text-primary text-xsm">
		         loading <i class="fa fa-spin fa-spinner"></i>
		        </div> -->
		    </div>
		  </div>
		</div>	
		        
        

    </div>
    <!-- END wrapper -->
<div class="modal-backdrop show" style="display:none;"></div>
    <!-- jQuery  -->
    

</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>