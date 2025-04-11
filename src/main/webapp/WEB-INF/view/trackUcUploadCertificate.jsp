<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

 <%@include file="..//view/leftMenu.jsp" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

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
	String distIdUsers = "0";
	if (session.getAttribute("distIdUsers") != null) {
		distIdUsers = session.getAttribute("distIdUsers").toString();
		distIdUsers = distIdUsers.replace(",","");
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
		GetAllVendorInvoice('ALL');
		GetDistrictList();
		getStoreFinancialYear();

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
		 	
		 	   
			 	
			 	var fromDate = $j('#fromDate').val();
			 	var toDate = $j('#toDate').val();
			 	var financialYear = $j('#financialYear').val();
		 	
		if((fromDate == undefined || fromDate == '') 
				&& (toDate == undefined || toDate == ''  ) && (financialYear == undefined || financialYear == ''  )){	
			alert("At least one option must be entered");
			return;
		}
		var countDate=getDateComapareValue(fromDate,toDate);
	 	 if(countDate!=0){
	 		 alert("To Date should not be earlier than From Date.");
	 		 return false;
	 	 }
		GetAllVendorInvoice('FILTER');
		//ResetForm();
	} 


	function GetAllVendorInvoice(MODE){
		var vendorId=<%=userId%>;
		var district = $j('#district').val();
	 	var fromDate = $j('#fromDate').val();
	 	var toDate = $j('#toDate').val();
	 	var financialYear = $j('#financialYear').val();
	 	
		 if(MODE == 'ALL'){
			
				var data = {"PN": nPageNo, "invoiceNo": "","fromDate":"","toDate":"","type":"All","districtUser":<%=distIdUsers%>};
		 }
		 else if(district != "" || fromDate != ""||toDate != "" || financialYear != "")
		 {
			 //nPageNo = 1;
		    var data = {"PN":nPageNo,"district":district,"fromDate":fromDate,"toDate":toDate,"financialYear":financialYear,"type":"All","districtUser":<%=distIdUsers%>};
		 } 
	    else
	    { 
	    	 var data = {"PN":nPageNo,"district":district,"fromDate":fromDate,"toDate":toDate,"statusSearch":statusSearch,"type":"All","districtUser":<%=distIdUsers%>};
		} 
		var url = "getUcUploadDocumentDetail";
		var bClickable = true;
		GetJsonData('vendorInvoiceTableList',data,url,bClickable);
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
           	
			 if(dataList[i].status == 'Y' && dataList[i].vendorStatus == 'S' || dataList[i].status == 'y' && dataList[i].vendorStatus == 'S')
					{
						var Status='Active'
					}
				else
					{
						var Status='Inactive'
					}
			   if(dataList[i].paymentStatus=="C"){	
		 			htmlTable = htmlTable+"<tr style='background-color: #84e08f' id='"+dataList[i].fundAllocationHdId+"' >";	
		 		   }
		 		  else if(dataList[i].paymentStatus=="P"){
		 			 htmlTable = htmlTable+"<tr id='"+dataList[i].fundAllocationHdId+"' >";	  
		 		  }
		 		 else
					{
		 			htmlTable = htmlTable+"<tr id='"+dataList[i].fundAllocationHdId+"' >";
					}
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].upssNames+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].phaseVal+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].createdDate+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].finanicalYear+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].entryDate+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].createdBy+"</td>";
				if(dataList[i].status=="S")
				{
					htmlTable = htmlTable +"<td style='width: 150px;'>Saved</td>";	
				}
				else
				{
					htmlTable = htmlTable +"<td style='width: 150px;'>Submitted</td>";
				}	
				
				htmlTable = htmlTable+"</tr>";
             
			}
		
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='8'><h6>No Record Found</h6></td></tr>";

			}
		 
		$j("#vendorInvoiceTableList").html(htmlTable);

	}

	function executeClickEvent(id){
	  	window.location = 'getUcUploadDocumentHdDt?ucUploadHdId='+id;
	}



    function showAll(){
        nPageNo = 1;
        //$('#district').val('');
        $('#statusSearch').val('')
        $('#fromDate').val('')
        $('#toDate').val('')
        GetAllVendorInvoice('ALL');
    }
     function showResultPage(pageNo){
        nPageNo = pageNo;
        GetAllVendorInvoice('FILTER');
    }

     function search()
     {
        if(document.getElementById('searchInvoiceNo').value == ""){
            alert("Please Enter Invoice No.");
            return false;
        }
        nPageNo=1;
        GetAllVendorInvoice('FILTER');
     }
     function GetDistrictList(){
    		jQuery.ajax({
    		 	crossOrigin: true,
    		    method: "POST",			    
    		    crossDomain:true,
    		    url: "${pageContext.servletContext.contextPath}/master/getAllDistrict",
    		    data: JSON.stringify({"PN" : "0","upssFlag":"Y"}),
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
     
     function captureFundAllocationDetails()
     {
     
     	
     	window.location = 'captureUcUploadCertificate';
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
    	    	combo += '<option value="">Select</option>' ;
    	    	for(var i=0;i<result.MasStoreFinancialData.length;i++){
    	    		combo += '<option id='+result.MasStoreFinancialData[i].startDate+'@'+result.MasStoreFinancialData[i].endDate+' value='+result.MasStoreFinancialData[i].financialId+'>' +result.MasStoreFinancialData[i].yearDescription+ '</option>';
    	    		
    	    	}
    	    	
    	    	jQuery('#financialYear').append(combo);
    	    	//getExpiryMedicineNotification();
    	    	
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
            <div class="">
                <div class="container-fluid">
                <div class="internal_Htext">Track uploaded utilization certificate(UC)</div>

                    <!-- end row -->
				
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
													<input type="text" id="fromDate" class="calDate form-control" onchange="checkFromFurtureDate()" value="" placeholder="DD/MM/YYYY">
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
													<input type="text" id="toDate" class="calDate form-control" onchange="checkToFurtureDate()" value="" placeholder="DD/MM/YYYY">
												</div>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Financial Year</label>
											</div>
											<div class="col-md-7">
												<div class="col-md-7">
												<select class="form-control" id="financialYear">
													<option value="">Select</option>
												</select>
											</div>
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-12">
									<button type="button" class="btn  btn-primary " onclick="captureFundAllocationDetails()">Upload UC</button>
									</div>
									<div class="col-lg-4 col-sm-12">
										<button type="button" class="btn btn-primary" onclick="searchPendingAttendanceList();">Search</button>
										<button type="button" class="btn  btn-primary " onclick="showAll('ALL');">Show All</button>
										
									</div>
									
								
								</div>


									<div style="float:left">
						
						                                     <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >   <tr>
						                                    <td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
						                                   <td>
						
						                         </td>
						           </tr>
						         </table>
                                  </div>
                                     <div style="float:right">
                                       <div id="resultnavigation">
                                       </div>
                                     </div>

                                    <div class="table-responsive">
								<table class="table table-hover table-bordered">
                                        <thead class="bg-primary" style="color:#fff;">
                                            <tr>
                                                <th id="th2" class ="inner_md_htext">UPSS</th>
                                                <th id="th3" class ="inner_md_htext">Phase</th>
                                                <th id="th4" class ="inner_md_htext">Upload Date</th>
                                                <th id="th4" class ="inner_md_htext">Financial Year</th>
                                                <th id="th5" class ="inner_md_htext">Date Of Entry</th>
                                                <th id="th5" class ="inner_md_htext">Entered By</th>
                                                <th id="th6" class ="inner_md_htext">Status</th>
                                               
                                            </tr>
                                        </thead>

                                     <tbody id="vendorInvoiceTableList">

                     				 </tbody>
                                    </table>
                                   </div>
         							<br>
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

