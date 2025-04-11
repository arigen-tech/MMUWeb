<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<title></title>

</head>
<script type="text/javascript">
$(document).ready(function(){
	
	getStoreFinancialYear();
	getMasPhase();
 
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
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		combo += '<option value='+result.data[i].phaseValue+'>' +result.data[i].phaseName+ '</option>';
	    		
	    	}
	    	jQuery('#phase').append(combo);
	    }
	    
	});
}

function getStoreFinancialYear(){
	 $j("#financialYear").empty();
	
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getStoreFutureFinancialYear",
	    data: JSON.stringify({"PN" : "0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "" ;
	    	var selectFre="";
	    	for(var i=0;i<result.MasStoreFinancialData.length;i++){
	    		
	    		if (result.MasStoreFinancialData[i].markFinancialYear == 'y') {
					selectFre = "selected";
				} else {
					selectFre = "";
				}
				
		   		combo += '<option '+selectFre+' id='+result.MasStoreFinancialData[i].startDate+'@'+result.MasStoreFinancialData[i].endDate+' value='+result.MasStoreFinancialData[i].financialId+'>' +result.MasStoreFinancialData[i].yearDescription+ '</option>';
	    		
	    	}
	    	
	    	jQuery('#financialYear').append(combo);
	    	getExpiryMedicineNotification();
	    	
	    }
	    
	});
}

function captureFundAllocationDetails()
{
	if(!$('#phase').val()){
        alert('Please select Phase .');
        return false;
    }
	localStorage.financialYear =$('#financialYear').val();
	var financialYearSelect = document.getElementById("financialYear");
	var financialYearText = financialYearSelect.options[financialYearSelect.selectedIndex].text;
	var financialYearId = financialYearSelect.options[financialYearSelect.selectedIndex].id;
	var tempArray = new Array();
	tempArray = financialYearId.split("@");
	var startDate=tempArray[0];
	var endDate=tempArray[1];
	localStorage.financialYearText =financialYearText;
	localStorage.startDate =startDate;
	localStorage.endDate =endDate;
	/*if($('#phase').val()==null || $('#phase').val()==""){
		alert("Please select Phase");
		return false;
	}*/
	localStorage.phase =$('#phase').val();
	
	window.location = 'captureFundAllocationDetails';
}

function getExpiryMedicineNotification(){
 	    var financialId=$j("#financialYear").val();
 	   var phaseVal=$j("#phase").val();
		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";

		var url = window.location.protocol + "//"
				+ window.location.host + "/" + accessGroup
				+ "/audit/getFundAllocationAmount";
  	//var data = $('employeeId').val();
	   // alert("radioValue" +radioValue);
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : url,
			data : JSON.stringify({
				'employeeId' : "1",
				'phaseVal':phaseVal,
				'financialId': financialId
			}),
			dataType : 'json',
			timeout : 100000,
			
			success : function(res)
			
			{
			var aspFund = res.asp_fund_allocation;
			var balance='';
			var totalAllocated='';
			var previousAllocated='';
			var aspFundAllocation='';
			        if(aspFund!=null){
			        	aspFundAllocation= aspFund.asp_fund;
			       	}          
		           if(aspFundAllocation!="")
					for(var i=0;i<aspFundAllocation.length;i++){
						balance= aspFundAllocation[i].balance;
						totalAllocated=aspFundAllocation[i].total_allocated;
						previousAllocated=aspFundAllocation[i].previous_allocated;
 					}
					$('#totalAllocated').val(totalAllocated);
					$('#previousAllocated').val(previousAllocated);
					$('#availableAllocated').val(balance);
				
			   },
	           error: function (jqXHR, exception) {
	               var msg = '';
	               if (jqXHR.status === 0) {
	                   msg = 'Not connect.\n Verify Network.';
	               } else if (jqXHR.status == 404) {
	                   msg = 'Requested page not found. [404]';
	               } else if (jqXHR.status == 500) {
	                   msg = 'Internal Server Error [500].';
	               } else if (exception === 'parsererror') {
	                   msg = 'Requested JSON parse failed.';
	               } else if (exception === 'timeout') {
	                   msg = 'Time out error.';
	               } else if (exception === 'abort') {
	                   msg = 'Ajax request aborted.';
	               } else {
	                   msg = 'Uncaught Error.\n' + jqXHR.responseText;
	               }
	               alert(msg);
	           }
		});
}

</script>
<body>
 <!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">Capture Fund Allocation (Scheme Wise)</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Financial Year</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="financialYear" onchange="getExpiryMedicineNotification()">
													<option value="">Select</option>
												</select>
											</div>
										</div>
									</div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Scheme</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" value="MMSSY" disabled="disabled"/>
											</div>
										</div>
									</div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Phase</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="phase"  onchange="getExpiryMedicineNotification()">
													<!--<option value="">Select</option>
													 <option value="Phase1">Phase1</option>
													<option value="Phase2">Phase2</option> -->
												</select>
											</div>
										</div>
									</div>
									
									<!-- <div class="col-lg-4 col-sm-6">
										<button type="button" class="btn btn-primary" onclick="">Search</button>
									</div> -->
									<!-- <div class="col-lg-4 col-sm-6 text-right">
										<button type="button" class="btn btn-primary" onclick="">Show All</button>
									</div> -->
								</div>
								
								<div>
								<!-- <div style="float:left">               
                                   <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >   
                                   <tr>
	                                   <td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
	                                  <td></td>
						           </tr>
						         </table>
                                </div>  
                                
                                <div style="float:right">
                                  <div id="resultnavigation">
                                  </div> 
                                </div>  -->

                                    <table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th>Total Fund Allocated</th>
                                                <th>Previously Allocated Fund</th>
                                                <th>Available Balance</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody id="">
										 <tr>
										 	<td><input type="text" id="totalAllocated" class="form-control" value="0" disabled="disabled"/></td>
										 	<td><input type="text" id="previousAllocated" class="form-control" value="0" disabled="disabled"/></td>
										 	<td><input type="text" id="availableAllocated" class="form-control" value="0" disabled="disabled"/></td>
										 	<td><button type="button" class="btn btn-primary" onclick="captureFundAllocationDetails()">Add/View</button></td>
										 </tr>
                     				 </tbody>
                                    </table>
								</div>
								
							<div class="row"> 
                              <!--  <div class="col-md-12 text-right">														 
									<input type="button"  id="" type="button" class="btn  btn-primary " onclick="" value="Close" />
								</div> -->
                               </div>	
							</div>
						</div>
						
						
						<!-- end card -->
					</div>
					<!-- end col -->
				</div>
				<!-- end row -->

			</div>
			<!-- container -->
			<!-- content -->
		</div>
	</div>
	<!-- END wrapper -->


</body>

</html>






