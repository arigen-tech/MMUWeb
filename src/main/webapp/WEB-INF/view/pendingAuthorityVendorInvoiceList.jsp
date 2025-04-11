<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

 <%@include file="..//view/leftMenu.jsp" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MMU</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
<%
	String userName = "1";
	if (session.getAttribute("userName") != null) {
		userName = session.getAttribute("userName") + "";
	}
	
	String userTypeDesignation="";
	if (session.getAttribute("userTypeDesignation") != null) {
		userTypeDesignation = session.getAttribute("userTypeDesignation") + "";
	}
	
	 String cityIdUsers = "";
		if (session.getAttribute("cityIdUsers") != null) {
			cityIdUsers = session.getAttribute("cityIdUsers").toString();
			cityIdUsers = cityIdUsers.replace(",","");
		}
	
	String distIdUsers = "";
	if (session.getAttribute("distIdUsers") != null) {
		distIdUsers = session.getAttribute("distIdUsers").toString();
		distIdUsers = distIdUsers.replace(",","");
	}
	
	String authorityId="";
	if (session.getAttribute("authorityId") != null) {
		authorityId = session.getAttribute("authorityId") + "";
	}
	
	String authorityName="";
	if (session.getAttribute("authorityName") != null) {
		authorityName = session.getAttribute("authorityName") + "";
	}
	
	String approvalOrderNo="";
	if (session.getAttribute("approvalOrderNo") != null) {
		approvalOrderNo = session.getAttribute("approvalOrderNo") + "";
	}
  
%>
<%@include file="..//view/commonJavaScript.jsp" %>

<script type="text/javascript">

	var nPageNo=1;
	var $j = jQuery.noConflict();

	$j(document).ready(function(){
		GetDistrictList();
		var cityIdUsers='<%=cityIdUsers%>';
		var distIdUsers='<%=distIdUsers%>';
		$('#cityIdUsers').val(cityIdUsers);
		$('#distIdUsers').val(distIdUsers);
		var username='<%=userName%>';
		 $('#userName').val(username);
         var usertypedesignation='<%=userTypeDesignation%>';
         $('#userDesignation').val(usertypedesignation);
         var userDesignation=$('#userDesignation').val();
       	 GetAllVendorInvoiceAuthority('ALL');
     
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
		GetAllVendorInvoiceAuthority('FILTER');
		//ResetForm();
	} 


	function GetAllVendorInvoiceAuthority(MODE){
		
		var district = $j('#district').val();
	 	var fromDate = $j('#fromDate').val();
	 	var toDate = $j('#toDate').val();
	 	var authorityId=$j('#authorityId').val();
	 	var statusSearch = $j('#statusSearch').val();
	 	var cityIdVal=$('#cityIdUsers').val();
		var distIdVal=$('#distIdUsers').val();
		
	 	
		 if(MODE == 'ALL'){
				var data = {"PN": nPageNo, "invoiceNo": "","fromDate":"","toDate":"","authorityId":authorityId,"type":"","cityIdVal":cityIdVal,"distIdVal":distIdVal};
		 }
		 else if(district != "" || fromDate != ""||toDate != "" || statusSearch != "")
		 {
			 //nPageNo = 1;
		    var data = {"PN":nPageNo,"district":district,"fromDate":fromDate,"toDate":toDate,"statusSearch":statusSearch,"authorityId":authorityId,"type":"","cityIdVal":cityIdVal,"distIdVal":distIdVal};
		 } 
	    else
	    { 
	    	var data = {"PN":nPageNo,"district":district,"fromDate":fromDate,"toDate":toDate,"statusSearch":statusSearch,"authorityId":authorityId,"type":"","cityIdVal":cityIdVal,"distIdVal":distIdVal};
		} 
		var url = "getCapturedVendorBillDetail";
		var bClickable = true;
		GetJsonData('vendorInvoiceTableList',data,url,bClickable);
	}

	function makeTable(jsonData)
	{
		var htmlTable = "";
		var data = jsonData.count;
		var authorityRoleNamesss=$('#authorityRoleName').val();
		var pageSize = 5;
		var dataList = jsonData.data;
		var months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];


		for(i=0;i<dataList.length;i++)
			{
			var lastApprovalMsg=dataList[i].lastApprovalMsg;
          	
			 if(dataList[i].status == 'Y' && dataList[i].vendorStatus == 'C' || dataList[i].status == 'y' && dataList[i].vendorStatus == 'C')
					{
						var Status='Active'
					}
				else
					{
						var Status='Inactive'
					}

				htmlTable = htmlTable+"<tr id='"+dataList[i].captureVendorBillDetailId+"' >";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].vendorName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].districtName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].invoiceNo+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].invoiceDate+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].invoiceAmount+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+ months[dataList[i].billMonth]+" / "+ dataList[i].billYear +"</td>";
				if(lastApprovalMsg.startsWith('Acknowledged')){
					htmlTable = htmlTable +"<td style='width: 150px;'>"+lastApprovalMsg+"</td>";
				}else{
				htmlTable = htmlTable +"<td style='width: 150px;'>Pending at "+authorityRoleNamesss+"</td>";
				}
				
				htmlTable = htmlTable+"</tr>";
             
			}
		
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='7'><h6>No Record Found</h6></td></tr>";

			}
		 
		$j("#vendorInvoiceTableList").html(htmlTable);

	}

	function executeClickEvent(captureVendorBillDetailId,data){
        window.location = 'pendingVendorInvoiceApprovingAuthorityDetail?detail='+captureVendorBillDetailId;
	}



    function showAll(){
        nPageNo = 1;
        $('#district').val('')
        $('#fromDate').val('')
        $('#toDate').val('')
        GetAllVendorInvoiceAuthority('ALL');
    }
     function showResultPage(pageNo){
        nPageNo = pageNo;
        GetAllVendorInvoiceAuthority('FILTER');
    }

     function search()
     {
        if(document.getElementById('searchInvoiceNo').value == ""){
            alert("Please Enter Invoice No.");
            return false;
        }
        nPageNo=1;
        GetAllVendorInvoiceAuthority('FILTER');
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
</script>
</head>

<body>

    <!-- Begin page -->
    <div id="wrapper">

        <div class="content-page">
            <!-- Start content -->
            <div class="">
                <div class="container-fluid">
                <div class="internal_Htext">Pending Approval List Of Vendor Invoice(Approving Authority)</div>

                    <!-- end row -->

                    <div class="row">
                    <input  name="userName" id="userName" type="hidden" value=""/>
                     <input  name="userDesignation" id="userDesignation" type="hidden" value=""/>
                     <input  name="authorityId" id="authorityId" type="hidden" value="<%=session.getAttribute("authorityId")%>"/>
		                <input  name="authorityOrderNo" id="authorityOrderNo" type="hidden" value="<%=session.getAttribute("approvalOrderNo")%>"/>
		                <input  name="authorityRoleName" id="authorityRoleName" type="hidden" value="<%=session.getAttribute("authorityName")%>"/>
		                 <input  name="distIdUsers" id="distIdUsers" type="hidden" value=""/>
		                <input  name="cityIdUsers" id="cityIdUsers" type="hidden" value=""/>
		                
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>

                            <div class="row">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">UPSS</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="district">
												<option value="">Select</option>
												</select>
											</div>
										</div>
									</div>
									<!-- <div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Payment Status</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="statusSearch">
												<option value=''>Select</option>
												<option value='P'>Pending</option>
												<option value='C'>Completed</option>
												</select>
											</div>
										</div>
									</div> -->
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">From Date</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" id="fromDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY">
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
													<input type="text" id="toDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY">
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

                                    <table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th id="th1" class ="inner_md_htext">Vendor</th>
                                                <th id="th2" class ="inner_md_htext">UPSS</th>
                                                <th id="th3" class ="inner_md_htext">Invoice No.</th>
                                                <th id="th4" class ="inner_md_htext">Invoice Date</th>
                                                <th id="th5" class ="inner_md_htext">Invoice Amount</th>
                                                <th id="th5" class ="inner_md_htext"> Bill Month / Year</th>
                                                <th id="th5" class ="inner_md_htext"> Status</th>
                                            </tr>
                                        </thead>

                                     <tbody class="clickableRow" id="vendorInvoiceTableList">

                     				 </tbody>
                                    </table>

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

