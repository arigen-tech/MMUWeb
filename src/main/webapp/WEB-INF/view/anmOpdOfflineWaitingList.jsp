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
	
	String mmuId = "1";
	if (session.getAttribute("mmuId") != null) {
		mmuId = session.getAttribute("mmuId") + "";
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
		//GetAllVendorInvoice('ALL');
		getCityList();

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
		 	
		 	   
			 	var district = $j('#cityId').val();
			 	var fromDate = $j('#fromDate').val();
			 	var toDate = $j('#toDate').val();
			 	var statusSearch = $j('#mmuIds').val();
		 	
		if((district == undefined || district == '') && (fromDate == undefined || fromDate == '') 
				&& (toDate == undefined || toDate == ''  ) && (statusSearch == undefined || statusSearch == ''  )){	
			alert("At least one option must be entered");
			return;
		}
		var countDate=getDateComapareValue(fromDate,toDate);
	 	 if(countDate!=0){
	 		 alert("To Date should not be earlier than From Date.");
	 		 return false;
	 	 }
	 	 if(toDate!="" && fromDate=="")
	 	 {
	 		 alert("Please select from date");
	 		$('#toDate').val('')
	 		 return false;	 
	 	 }	 
		GetAllVendorInvoice('FILTER');
		//ResetForm();
	} 


	function GetAllVendorInvoice(MODE){
		var vendorId=<%=userId%>;
		var cityId = $j('#cityId').val();
		var mmuIds = $j('#mmuIds').val();
	 	var fromDate = $j('#fromDate').val();
	 	var toDate = $j('#toDate').val();
	 	var statusSearch = $j('#statusSearch').val();
	 	var cityIdVal=$j('#cityIdVal').val();
	 	var mmudIdss=$('#mmuIdSessionVal').val();
		 if(MODE == 'ALL'){
			
				var data = {"PN": nPageNo, "anmApmId": "","fromDate":"","toDate":"","type":"All","creatdBy":"anm","cityId":cityIdVal,"mmuId":mmudIdss};
		 }
		 else if(cityId != "" || fromDate != ""||toDate != "" || mmuIds != "")
		 {
			 nPageNo = 1;
		    var data = {"PN":nPageNo,"cityId":cityId,"fromDate":fromDate,"toDate":toDate,"mmuId":mmuIds,"type":"All","anmApmId":"","creatdBy":"anm"};
		 } 
	    else
	    { 
	    	 var data = {"PN":nPageNo,"cityId":cityId,"fromDate":fromDate,"toDate":toDate,"mmuId":mmuIds,"type":"All","anmApmId":"","type":"All","creatdBy":"anm"};
		} 
		var url = "getAnmOpdOfflineData";
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
           	
			
			   htmlTable = htmlTable+"<tr id='"+dataList[i].anmApmId+"' >";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].opdDate+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].cityName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].mmuName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].dateOfEntry+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].enterBy+"</td>";
				if(dataList[i].status == 's')
		        {
				htmlTable = htmlTable +"<td style='width: 150px;'>Saved</td>";
		        }
				
				else if(dataList[i].status == 'c')
		        {
					htmlTable = htmlTable +"<td style='width: 150px;'>Submitted</td>";
		        }
				else if(dataList[i].status == 'a')
		        {
					htmlTable = htmlTable +"<td style='width: 150px;'>Approved</td>";
		        }
				
				htmlTable = htmlTable+"</tr>";
             
			}
		
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='8'><h6>No Record Found</h6></td></tr>";

			}
		 
		$j("#vendorInvoiceTableList").html(htmlTable);

	}

	function executeClickEvent(anmApmId,data){
	  var dataList=data.data;
		for(i=0;i<dataList.length;i++)
		{
			var detailsId=dataList[i].anmApmId;
			var status=dataList[i].status;
			if(anmApmId==detailsId)
			{
					if(status=="s")
					{	
					 	window.location = 'getAnmOpdOfflineDataDetails?anmApmId='+anmApmId;
					}
				    else
					{
						 window.location = 'getAnmOpdOfflineDataDetails?anmApmId='+anmApmId;	
					}	
			}
				
		} 
       
	}



    function showAll(){
        nPageNo = 1;
        $('#cityId').val('');
        $('#mmuIds').val('')
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
     function getCityList(){
    		var mmudIdss=$('#mmuIdSessionVal').val();
    		$j("#cityId").empty();
    		 $j("#mmuIds").empty();
    		var districtId=$j("#district option:selected").val();
    	    jQuery.ajax({
    	        crossOrigin: true,
    	        method: "POST",
    	        crossDomain:true,
    	        url: "${pageContext.servletContext.contextPath}/master/getAllCityMmuMapping",
    	        data: JSON.stringify({"PN" : "0","cityMmuPage":"1","mmuId":mmudIdss}),
    	        contentType: "application/json; charset=utf-8",
    	        dataType: "json",
    	        async: true,
    	        success: function(result){
    	        	var combo = "" ;
    		    	combo += '<option value="">Select</option>' ;
    		    	for(var i=0;i<result.data.length;i++){
    		    		$j('#cityIdVal').val(result.data[i].cityId);
    		    		combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
    		    		
    		    	}
    		    	
    		    	jQuery('#cityId').append(combo);
    		    	GetAllVendorInvoice('ALL');
    		    	var mmuDrop = '';
    				mmuDrop += '<option value="">Select</option>' ;
    				$j('#mmuIds').append(mmuDrop);
    	        }
    	    });
    	   
    	    //return mappedData;
    	}
     /* function getCityList(){
    		$j("#cityId").empty();
    		 $j("#mmuIds").empty();
    		var districtId=$j("#district option:selected").val();
    		jQuery.ajax({
    		 	crossOrigin: true,
    		    method: "POST",			    
    		    crossDomain:true,
    		    url: "${pageContext.servletContext.contextPath}/master/getAllCity",
    		    data: JSON.stringify({"PN" : "0"}),
    		    contentType: "application/json; charset=utf-8",
    		    dataType: "json",
    		    success: function(result){
    		    	var combo = "" ;
    		    	combo += '<option value="">Select</option>' ;
    		    	for(var i=0;i<result.data.length;i++){
    		    		
    		    		combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
    		    		
    		    	}
    		    	
    		    	jQuery('#cityId').append(combo);
    		    	var mmuDrop = '';
    				mmuDrop += '<option value="">Select</option>' ;
    				$j('#mmuIds').append(mmuDrop);
    		    	
    		    }
    		    
    		});
    	} */
    	function getMMUList(item){
    		  $j("#mmuIds").empty();
    		  var mmudIdss=$('#mmuIdSessionVal').val();
    		  var params;
    		  if(item != ''){
    			  var cityId = item.value;
    			  params = {
    					    "mmuId":mmudIdss,
    						"PN" : "0"
    				}
    		  }else{
    			  params = { };
    		  }
    		 
    			
    			$.ajax({
    				type : "POST",
    				contentType : "application/json",
    				url: "${pageContext.servletContext.contextPath}/master/getAllCityMmuMapping",
    				data : JSON.stringify(params),
    				dataType : "json",
    				cache : false,
    				success : function(data) {
    					if(data.status == true){
    						var list = data.data;
    						var mmuDrop = '';
    						mmuDrop += '<option value="">Select</option>' ;
    						for(i=0;i<list.length;i++){
    							mmuDrop += '<option value='+list[i].mmuId+'>'+list[i].mmuName+'</option>';
    						}
    						$j('#mmuIds').append(mmuDrop);
    					}
    				},
    				error : function(data) {
    					alert("An error has occurred while contacting the server");
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
    			alert("From Date should not be future month and year");
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
 			alert("To Date should not be future month and year");
 			return false;
 		}
 		
 		return true;
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
                <div class="internal_Htext">List Of OPD Offline Data </div>
                <input type="hidden"  name="mmuIdSessionVal" value=<%= session.getAttribute("mmuId") %> id="mmuIdSessionVal" />
                <input type="hidden"  name="cityIdVal" value="" id="cityIdVal" />

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
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-7">
												 <select class="form-control" id="cityId" name="cityId" onchange="getMMUList(this)">
                                                        <option value="">Select</option>
                                                    </select>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">MMU</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="mmuIds" name="mmuIds">
                                                        <option value="">Select</option>
                                                    </select>
											</div>
										</div>
									</div>
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
                                                <th id="th1" class ="inner_md_htext">OPD Date</th>
                                                <th id="th2" class ="inner_md_htext">City</th>
                                                <th id="th3" class ="inner_md_htext">MMU</th>
                                                <th id="th4" class ="inner_md_htext">Date Of Entry</th>
                                                <th id="th4" class ="inner_md_htext">Enter By</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
                                                
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

