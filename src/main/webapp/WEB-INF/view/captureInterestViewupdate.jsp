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
<%
	String vendorId = "0";
	if (session.getAttribute("vendorIdUsers") != null) {
		vendorId = session.getAttribute("vendorIdUsers") + "";
	}
	String userId = "0";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	
	
%>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MMU</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp" %>

<script type="text/javascript">

	var nPageNo=1;
	var $j = jQuery.noConflict();

	$j(document).ready(function(){
		GetAllCaptureInterest('ALL');
		//GetDistrictList();
		//getStoreFinancialYear();

    });
	function populateDates(){
	    var dt = new Date();
	    var currDate = ("0" + dt.getDate()).slice(-2)+'/'+("0" + (dt.getMonth() + 1)).slice(-2)+'/'+dt.getFullYear();
	    $('#fromDate').val(currDate);
	    $('#toDate').val(currDate);
	}	
	function searchPendingAttendanceList()
	{
			
		        var nPageNo=1;	
		 	
		 	   
			 	var district = $j('#district').val();
			 	var fromDate = $j('#fromDate').val();
			 	var toDate = $j('#toDate').val();
			 	var statusSearch = $j('#statusSearch').val();
		 	
		if((district == undefined || district == '') && (fromDate == undefined || fromDate == '') 
				&& (toDate == undefined || toDate == ''  ) && (statusSearch == undefined || statusSearch == ''  )){	
			alert("At least one option must be entered");
			return;
		}
		var countDate=getDateComapareValue(fromDate,toDate);
	 	 if(countDate!=0){
	 		 alert("To Date should not be earlier than from Date.");
	 		 return false;
	 	 }
		GetAllCaptureInterest('FILTER');
		//ResetForm();
	} 


	function GetAllCaptureInterest(MODE){
		var vendorId=<%=userId%>;
		var district = $j('#district').val();
	 	var fromDate = $j('#fromDate').val();
	 	var toDate = $j('#toDate').val();
	 	var statusSearch = $j('#statusSearch').val();
	 	
		 if(MODE == 'ALL'){
				
				var data = {"PN": nPageNo, "statusPending":"S","fromDate":"","toDate":"","type":"All","creatdBy":vendorId};
		 }
		/*  else if(financialYear != "")
		 {
			 //nPageNo=1;
		    var data = {"PN":nPageNo,"statusPending":"S","financialYear":financialYear,"type":"All","creatdBy":vendorId,"phaseVal":phaseVal};
		 } */ 
	    else
	    { 
	    	 var data = {"PN":nPageNo,"statusPending":"S", "type":"All","creatdBy":vendorId };
		} 
		 
		var url = "getAllCaptureInterestDetails";
		var bClickable = true;
		GetJsonData('fundAllocationTable',data,url,bClickable);
	}

	function makeTable(jsonData)
	{
		var htmlTable = "";
		var data = jsonData.count;

		var pageSize = 5;
		var dataList = jsonData.data;
		var months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
		
		
		for(i=0;i<dataList.length;i++)
			{
        
			var status=dataList[i].status;
			if(status=="C"){
				status ="Submitted";
			}
			if(status=="A"){
				status="Approved";
			}
			if(status=="S"){
				status="Saved";
			}
			var phase="";
           	if(dataList[i].phaseVal!="" && dataList[i].phaseVal!=undefined){
           		phase=dataList[i].phaseVal;
           	}else{
           		phase="";
           	}
			
			htmlTable = htmlTable+"<tr id='"+dataList[i].captureInterestHdId+"' >";
		 		
		// 		htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].upssNames+"</td>";
			 						
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].finanicalYear+"</td>";	
				htmlTable = htmlTable +"<td style='width: 150px;'>"+phase+"</td>";
	//			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].upssNames+"</td>";
				//htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].createdBy+"</td>";
				
		//		htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].cityName+"</td>";
				
			//	htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].headNames+"</td>";
				
				//htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].allocatedAmount+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].createdDate+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].createdBy+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+status+"</td>";
				htmlTable = htmlTable+"</tr>";
             
			}
		
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='6'><h6>No Record Found</h6></td></tr>";

			}
		 
		$j("#fundAllocationTable").html(htmlTable);

	}

	function executeClickEvent(id){
	  	window.location = 'captureViewUpdateDetails?captureInterestHdId='+id;
	}



    function showAll(){
        nPageNo = 1;
        $('#district').val('');
        $('#statusSearch').val('')
        $('#fromDate').val('')
        $('#toDate').val('')
        GetAllCaptureInterest('ALL');
    }
     function showResultPage(pageNo){
        nPageNo = pageNo;
        GetAllCaptureInterest('FILTER');
    }

     function search()
     {
        if(document.getElementById('searchInvoiceNo').value == ""){
            alert("Please Enter Invoice No.");
            return false;
        }
        nPageNo=1;
        GetAllCaptureInterest('FILTER');
     }
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
    		    	
    		    }
    		    
    		});
    	}
     
     function checkFromFurtureDate(){
    		
    		var fromDate=document.getElementById("fromDate").value;
    		
    		var fromDateValue=new Date(fromDate.substring(6),(fromDate.substring(3,5) - 1) ,fromDate.substring(0,2));
    		var currentDate=new Date();
    		if((fromDateValue>currentDate))
    		{
    			document.getElementById("fromDate").value='';
    			alert("Invoice From Date should not be future month and year");
    			return false;
    		}
    		
    		return true;
    	}
     
     function checkToFurtureDate(){
 		
 		var fromDate=document.getElementById("toDate").value;
 		
 		var fromDateValue=new Date(fromDate.substring(6),(fromDate.substring(3,5) - 1) ,fromDate.substring(0,2));
 		var currentDate=new Date();
 		if((fromDateValue>currentDate))
 		{
 			document.getElementById("toDate").value='';
 			alert("Invoice To Date should not be future month and year");
 			return false;
 		}
 		
 		return true;
 	}
  function getStoreFinancialYear(){
    	 $j("#financialYear").empty();
    	
    	jQuery.ajax({
    	 	crossOrigin: true,
    	    method: "POST",			    
    	    crossDomain:true,
    	    url: "${pageContext.servletContext.contextPath}/master/getStoreFinancialYear",
    	    data: JSON.stringify({"PN" : "0"}),
    	    contentType: "application/json; charset=utf-8",
    	    dataType: "json",
    	    success: function(result){
    	    	var combo = "" ;
    	    	for(var i=0;i<result.MasStoreFinancialData.length;i++){
    	    		combo += '<option value='+result.MasStoreFinancialData[i].financialId+'>' +result.MasStoreFinancialData[i].yearDescription+ '</option>';
    	    		
    	    	}
    	    	
    	    	jQuery('#financialYear').append(combo);
    	    	
    	    }
    	    
    	});
    } 
     
</script>	
</head>

<body>
 <!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext"> View/Update Bank Interest</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
								<!-- 	<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Financial Year</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="financialYear">
													<option value="">Select</option>
												</select>
											</div>
										</div>
									</div>
									
									
									<div class="col-lg-4 col-sm-6">
										<button type="button" class="btn btn-primary" onclick="">Search</button>
									</div> -->
									<!-- <div class="col-lg-4 col-sm-6 text-right">
										<button type="button" class="btn btn-primary" onclick="">Show All</button>
									</div> -->
								</div>
								
								<div>
								<div style="float:left">               
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
                                </div> 

                                    <table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                
                                                <th>Financial Year</th>
                                                <th>Phase</th>
                                               <!--  <th>UPSS</th>
                                                <th>City</th>
                                                <th>Head Type</th> 
                                                <th>Interest</th>
                                                --> <th>Date of entry</th>
                                                <th>Entered by</th>
                                                 <th>Status</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody id="fundAllocationTable">
										
                     				 </tbody>
                                    </table>
								</div>
								
							<!-- <div class="row"> 
                               <div class="col-md-12 text-right">														 
									<input type="button"  id="" type="button" class="btn  btn-primary " onclick="" value="Close" />
								</div>
                             </div>	 -->
                             
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



