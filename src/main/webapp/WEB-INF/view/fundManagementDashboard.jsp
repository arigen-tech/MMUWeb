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
	
 	if(financialYearVal!=undefined && financialYearVal!="" && financialYearVal!="0000")
	finalFinancial=financialYearVal;
	else{
			alert("Please mark Financial Year.");
	return false;
	}
	
	var currentDate="";
	var fromDate="";
	
	var sessionData = ${fundmgmt_fromDate};
	var now = new Date();
		now.setDate(now.getDate());
		var day = ("0" + now.getDate()).slice(-2);
		var month = ("0" + (now.getMonth() + 1)).slice(-2);
		var today = (day)+"/"+(month)+"/"+now.getFullYear();
		currentDate=today;   	
		var now1 = new Date();
		now1.setDate(now1.getDate() - 7); // add -7 days to your date variable 
		
		var day1 = ("0" + now1.getDate()).slice(-2);
		var month1 = ("0" + (now1.getMonth() + 1)).slice(-2);
		//var fromDate = (day1)+"/"+(month1)+"/"+now1.getFullYear();
		var fromDate = "01"+"/"+"04"+"/"+finalFinancial;
		$j('#fromDate').val(fromDate);
		$j('#toDate').val(currentDate);
		$("#upss").prop("checked", true);
		if(!isEmpty(sessionData)){
			setFieldValue(sessionData);
		}
		getInvoiceDataReport();
		getDistrictList();
		document.getElementById("upssId").style.display = "none";
		$('input[type=radio][name=mmuCity]').change(function() {
		    if (this.value == 'C') {
		    	document.getElementById("upssId").style.display = "none";
		    }
		    else if (this.value == 'U') {
		    	document.getElementById("upssId").style.display = "none";
		    }
		});
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
function getDistrictList(){
	console.log("${pageContext.servletContext.contextPath}/master/getAllDistrict");
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getAllDistrict",
	    data: JSON.stringify({"PN" : "0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	
	    	var districtList="";
	    	for(var i=0;i<result.data.length;i++){
	    		districtList += '<option value='+result.data[i].districtId+'>' +result.data[i].districtName+ '</option>';
	    	}
	    	
	    	jQuery('#ditrictList').append(districtList);
	    
	    	
	    }
	    
	});
}

var totalFund=0;
var totalfundOperation=0;
var totalFuncdAdmin=0;
var totalFundMedicine=0;
var totalUtilizeOperation=0;
var totalUtilizeAdmin=0;
var totalUtilizeMedicine=0;
var totalFund_interest=0;
var utilized_total=0;
var available_operation=0;
var available_medicine=0;
var available_admin=0;
var available_balance=0;
var utilized=0;
var remain=0;
function getInvoiceDataReport(){
	 totalFund=0;
	 totalfundOperation=0;
	 totalFuncdAdmin=0;
	 totalFundMedicine=0;
	 totalUtilizeOperation=0;
	 totalUtilizeAdmin=0;
	 totalUtilizeMedicine=0;
     totalFund_interest=0;
     utilized_total=0;
     available_operation=0;
     available_medicine=0;
     available_admin=0;
     available_balance=0;
     utilized=0;
     remain=0;
     
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
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/dashboard/getFundInvoicDashboardData",
	    data: JSON.stringify({"mmuCity" : mmuCity, "fromDate" : fromDate,"toDate" : currentDate,"flagType":"FM","phase":phase,"distIdVal":distIdVal,"levelOfUser":levelOfUser}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	isDataLoaded=true;
	    	console.log(result);
	    	var response = result.data.fundInvoiceDataInfo;
	    	setSearchValue(true,response.length);
	    	
	    	for(var i=0;i<response.length;i++){
	    		genrateTable(i+1,response[i]);
	    		totalFund=parseInt(totalFund) + parseInt(response[i].total_fund);
	    		totalfundOperation=parseInt(totalfundOperation) + parseInt(response[i].fund_operation);
	    		totalFuncdAdmin=parseInt(totalFuncdAdmin) + parseInt(response[i].fund_admin);
	    		totalFundMedicine=parseInt(totalFundMedicine) + parseInt(response[i].fund_medicine);
	    		totalUtilizeOperation=parseInt(totalUtilizeOperation) + parseInt(response[i].utilized_operation);
	    		totalUtilizeAdmin=parseInt(totalUtilizeAdmin) + parseInt(response[i].utilized_admin);
	    		totalUtilizeMedicine=parseInt(totalUtilizeMedicine) + parseInt(response[i].utilized_medicine);
	    		totalFund_interest=parseInt(totalFund_interest) + parseInt(response[i].fund_interest);
	    		utilized_total=parseInt(utilized_total) + parseInt(response[i].utilized_total);
	    		 available_operation=parseInt(available_operation) + parseInt(response[i].available_operation);
	    		 available_admin=parseInt(available_admin) + parseInt(response[i].available_admin);
	    	     available_medicine=parseInt(available_medicine) + parseInt(response[i].available_medicine);
	    	     available_balance=parseInt(available_balance) + parseInt(response[i].available_balance);
	    	    // utilized=parseInt(utilized) + parseInt(response[i].utilized);
	    	    // remain=parseInt(remain) + parseInt(response[i].remain);
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

function setSearchValue(isElementSize,data){
	if(isElementSize){
	  	$('#serach_results').text(+data+' matches');
		document.getElementById('serach_results').style ='font-size: 15px; color: green;';
	}else{
		$('#serach_results').text(data);
		document.getElementById('serach_results').style ='font-size: 15px; color: black;';
	}
}


function exportExcel(){
	 var distIdVal='<%=distIdUsersVal%>';
	 var levelOfUser='<%=levelOfUser%>';
	 var fromDate = $j("#fromDate").val();
	 var toDate = $j("#toDate").val();
 	var phase=$j('#phase').val();
	 if(fromDate ==''){
		 alert("Please select from Date");
		 return false;
	 }
	 if(toDate ==''){
		 alert("Please select to Date");
		 return false;
	 }
	 
	 var mmuCity =$("input[name='mmuCity']:checked").val();
	 		
  window.location.href =  "${pageContext.request.contextPath}/funddashboard/fundmanagement?fromDate="
			+ fromDate
			+ "&toDate="
			+toDate
			+ "&mmuCity="
			+ mmuCity
			+"&flagType=FM"
			+ "&phase="
			+ phase
			+ "&distIdVal="
			+ distIdVal
			+ "&levelOfUser="
			+ levelOfUser
			
			;	

}
function exportPDF(){
	var distIdVal='<%=distIdUsersVal%>';
	 var levelOfUser='<%=levelOfUser%>';
	 var fromDate = $j("#fromDate").val();
	 var toDate = $j("#toDate").val();
	 var phase=$j('#phase').val();
		if(phase=="" || phase==undefined){
			phase="";
		}
	 if(fromDate ==''){
		 alert("Please select from Date");
		 return false;
	 }
	 if(toDate ==''){
		 alert("Please select to Date");
		 return false;
	 }
	 var mmuCity =$("input[name='mmuCity']:checked").val();
	 		
 var url = "${pageContext.request.contextPath}/report/fundManagementDashboard?fromDate="
			+ fromDate
			+ "&toDate="
			+toDate
			+ "&mmuCity="
			+ mmuCity
			+"&flagType=FM"
			+ "&phase="
			+ phase
			+ "&distIdVal="
			+ distIdVal
			+ "&levelOfUser="
			+ levelOfUser;	
 
 //window.open(url, '_blank');
 openPdfModel(url)

}


function genrateTable(seq,response){
	var iteration = $('#my-table tr').length;
	
	var message = JSON.stringify(response);
	
	var upss = "";
	var upssCityId="";
	var phase="";
	phase=$('#phase').val();
	if(response.upss!=undefined){
		upss = response.upss;
		upssCityId = response.upss_id;
	}
	else{
		upss = response.city
		upssCityId = response.city_id;
	}
	
	
	
	var tableRow='<tr>'+
	 	'<td>'+seq+'</td>'+
	 	'<td>'+upss+'</td>'+
	 	'<td>'+response.total_fund+'</td>'+
	 	'<td><a class="btn-link" href="javascript:void(0);" onClick="showDiv('+upssCityId+','+response.fund_operation+',2);">'+response.fund_operation+'</a></td>'+
	 	'<td><a class="btn-link" href="javascript:void(0);" onClick="showDiv('+upssCityId+','+response.fund_admin+',3);">'+response.fund_admin+'</a></td>'+
	 	'<td><a class="btn-link" href="javascript:void(0);" onClick="showDiv('+upssCityId+','+response.fund_medicine+',4);">'+response.fund_medicine+'</a></td>'+
	 	'<td>'+response.fund_interest+'</td>'+
	 	'<td><a class="btn-link" href="javascript:void(0);" onClick="showDiv('+upssCityId+','+response.utilized_operation+',5);">'+response.utilized_operation+'</a></td>'+
	 	'<td><a class="btn-link" href="javascript:void(0);" onClick="showDiv('+upssCityId+','+response.utilized_admin+',6);">'+response.utilized_admin+'</a></td>'+
	 	/* '<td>'+response.utilized_admin+'</td>'+ */
	 	'<td><a class="btn-link" href="javascript:void(0);" onClick="showDiv('+upssCityId+','+response.utilized_medicine+',7);">'+response.utilized_medicine+'</a></td>'+
	 	'<td><a class="btn-link">'+response.utilized_total+'</a></td>'+
	 	'<td><a class="btn-link">'+response.available_operation+'</a></td>'+
	  	'<td><a class="btn-link">'+response.available_admin+'</a></td>'+
	  	'<td><a class="btn-link">'+response.available_medicine+'</a></td>'+
	  	'<td><a class="btn-link">'+response.available_balance+'</a></td>'+
	  	'<td><a class="btn-link">'+response.utilized+'</a></td>'+
	 	'<td><a class="btn-link">'+response.remain+'</a></td>'+
	 	'</tr>';
	 $("#tbl_invoiceData").append(tableRow);
}



function generateFinalHtml(){
	
	var tableRowHtml='<tr>'+
 	'<td></td>'+
 	'<td>Total Amount</td>'+
 	'<td>'+totalFund+'</td>'+
 	'<td> '+totalfundOperation+' </td>'+
 	'<td> '+totalFuncdAdmin+' </td>'+
 	'<td> '+totalFundMedicine+'</td>'+
 	'<td> '+totalFund_interest+'</td>'+
  	'<td> '+totalUtilizeOperation+' </td>'+
 	'<td> '+totalUtilizeAdmin+' </td>'+
 	'<td> '+totalUtilizeMedicine+'</td>'+
 	'<td> '+utilized_total+'</td>'+
 	'<td> '+available_operation+'</td>'+
 	'<td> '+available_admin+'</td>'+
 	'<td> '+available_medicine+'</td>'+
 	'<td> '+available_balance+'</td>'+
 	 '<td></td>'+
 	'<td></td>'+ 
 	'<tr>';
	
	$("#tbl_invoiceData").append(tableRowHtml);
}


function showDiv(upss_id,amount,index){
	if(amount>0){
	console.log(index);
	var fromDate = $j("#fromDate").val();
	 var toDate = $j("#toDate").val();
	 var mmuCity =$("input[name='mmuCity']:checked").val();
	 var phase=$('#phase').val();
	 
	 var url="";
	 if(index===2){
	 	 url = "${pageContext.request.contextPath}/captureMedicine/fundOperationDashboard?flagType=FAO&fundType=O&"
	 }
	 if(index===3){
	 	 url = "${pageContext.request.contextPath}/captureMedicine/fundOperationDashboard?flagType=FAO&fundType=A&"
	 }
	 if(index===4){
	 	 url = "${pageContext.request.contextPath}/captureMedicine/fundOperationDashboard?flagType=FAO&fundType=M&"
	 }
	 else if(index===5){
		  url = "${pageContext.request.contextPath}/captureMedicine/fundUtilzationDashboard?flagType=FUO&"
	 }
	 if(index===6){
	 	 url = "${pageContext.request.contextPath}/captureMedicine/fundUtilzationMedicineDashboard?flagType=IEC&"
	 }
	 else if(index===7){
		  url = "${pageContext.request.contextPath}/captureMedicine/fundUtilzationMedicineDashboard?flagType=MID&"
	 }
	 url=url+"fromDate="
			+ fromDate
			+ "&toDate="
			+toDate
			+ "&upss_id="
			+upss_id
			+ "&mmuCity="
			+ mmuCity
			+ "&phase="
			+ phase;	

	 window.location.href=url;
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
                 <div class="internal_Htext">Fund Management Dashboard</div>
                 
                   
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       <input type="hidden"  name="dIdVal" value="<%= session.getAttribute("distIdUsers") %>" id="dIdVal" />
                                       <div class="row">
										<div class="col-md-3">
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
											
											<div class="col-md-3">
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
											
									<div class="col-lg-2 col-sm-3" id="upssId">
										<select class="form-control" id="ditrictList">
													<option value="">--SELECT UPSS--</option>
												</select>
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
                                                <th rowspan="2" >Total Fund</th> 
                                                <th colspan="4" class="text-center">Fund Allocated </th>   
                                            
                                                <th colspan="4" class="text-center">Fund Utilized </th> 
                                                <th colspan="4" class="text-center">Available Balance </th>  
                                                <th rowspan="2" >Utilized <br/>&nbsp;&nbsp;&nbsp; %</th>   
                                                <th rowspan="2" >Remain<br/> &nbsp;&nbsp;&nbsp; %</th>                                        
                                            </tr>
                                            <tr>                                                  
                                                <th>Operations</th> 
                                                <th>IEC</th> 
                                                <th>Medicine</th> 
                                                <th>Interest</th> 
                                                <th>Operations</th> 
                                                <th>IEC</th> 
                                                <th>Medicine</th>
                                                <th>Total</th>
                                                <th>Operations</th> 
                                                <th>IEC</th> 
                                                <th>Medicine</th>
                                                <th>Total</th>
                                                                                  
                                            </tr>
                                        </thead>
                                     <tbody id="tbl_invoiceData">
										
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