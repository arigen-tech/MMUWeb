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

<%@include file="..//view/commonJavaScript.jsp" %>

<script type="text/javascript">

	var nPageNo=1;
	var $j = jQuery.noConflict();

	$j(document).ready(function(){
		GetAllVendorInvoice('ALL');
		loadVendors();

    });

	function GetAllVendorInvoice(MODE){

		var invoiceNo=$("#searchInvoiceNo").val();
		 if(MODE == 'ALL'){
				var data = {"PN": nPageNo, "invoiceNo": ""};
		 }else{
			var data = {"PN":nPageNo};
			if($("#searchInvoiceNo").val())
			    data['invoiceNo'] = $("#searchInvoiceNo").val();
			if($("#searchVendorId").val())
                data['vendorId'] = $("#searchVendorId").val();
		}
		var url = "getCapturedVendorBillDetail";
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


		for(i=0;i<dataList.length;i++){
		        var status = "Pending for Auditor's Approval"
                if(dataList[i].status == 'C'){
                    status = "Pending for CO Approval"
                }else if(dataList[i].status == 'A'){
                    status = "Pending for Authorities Approval"
                }
				htmlTable = htmlTable+"<tr id='"+dataList[i].captureVendorBillDetailId+"' >";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].vendorName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].cityName+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].invoiceNo+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].invoiceDate+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].invoiceAmount+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+ months[dataList[i].billMonth]+" / "+ dataList[i].billYear +"</td>";
				htmlTable = htmlTable +"<td style='width: 200px;'>"+status+"</td>";
				htmlTable = htmlTable+"</tr>";

			}
		if(dataList.length == 0)
			{
			htmlTable = htmlTable+"<tr ><td colspan='5'><h6>No Record Found</h6></td></tr>";

			}


		$j("#vendorInvoiceTableList").html(htmlTable);

	}

	function executeClickEvent(captureVendorBillDetailId,data){
        window.location = 'vendorInvoiceApprovalCO?detail='+captureVendorBillDetailId;
	}



    function showAll(){
        nPageNo = 1;
        $('#searchInvoiceNo').val('')
        GetAllVendorInvoice('ALL');
    }
     function showResultPage(pageNo){
        nPageNo = pageNo;
        GetAllVendorInvoice('FILTER');
    }

     function search()
     {
        if(document.getElementById('searchInvoiceNo').value == ""
            && document.getElementById('searchVendorId').value == ""){
            alert("Please Enter at least one search criteria");
            return false;
        }
        nPageNo=1;
        GetAllVendorInvoice('FILTER');
     }
function loadVendors(){
    var params = {"PN":0,"status":"y"}

    $.ajax({
        type : "POST",
        contentType : "application/json",
        url : 'getVendors',
        data : JSON.stringify(params),
        dataType : "json",
        cache : false,
        success : function(result) {
            if(result.data.length > 0){
                $('#searchVendorId').empty().append('<option value="">--Select--</option>');
                for(var i=0;i<result.data.length;i++){
                    var rowData = result.data[i];
                    $('#searchVendorId').append($('<option/>').val(rowData.mmuVendorId).text(rowData.mmuVendorName));
                }
            }
        },
        error : function(data) {
            alert("An error has occurred while contacting the server");
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
                <div class="internal_Htext">Pending Vendor Bill Approval List for CO</div>

                    <!-- end row -->

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>

                                       <div class="row">
                                            <div class="col-md-8">
											<form class="form-horizontal" id="searchBankForm"
												name="searchBankForm" method="" role="form">
												<div class="form-group row">
													<label class="col-3 col-form-label">Invoice No.<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-4">

														<input type="text" name="searchInvoiceNo" id="searchInvoiceNo"
															class="form-control" id="inlineFormInputGroup"
															placeholder="Invoice No.">

													</div>
													<div class="form-group row">

														<div class="col-md-12">
															<button type="button" class="btn  btn-primary "
																onclick="search()">Search</button>
														</div>
													</div>
												</div>

												<div class="form-group row">
                                                    <label class="col-3 col-form-label">Vendor<span class="mandate"><sup>&#9733;</sup></span></label>
                                                    <div class="col-4">
                                                         <select class="form-control" name="searchVendorId" id="searchVendorId">
                                                             <option value="">--Select--</option>
                                                         </select>
                                                    </div>
                                                </div>
											</form>

										</div>
										<div class="col-md-4">
											<div class="btn-right-all">
												<button type="button" class="btn  btn-primary "
													onclick="showAll('ALL');">Show All</button>
												<!-- <button type="button" class="btn  btn-primary "
												id="printReportButton"
													onclick="generateReport()">Reports</button> -->
											</div>
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
                                                <th id="th2" class ="inner_md_htext">City</th>
                                                <th id="th3" class ="inner_md_htext">Invoice No.</th>
                                                <th id="th4" class ="inner_md_htext">Invoice Date</th>
                                                <th id="th5" class ="inner_md_htext">Invoice Amount</th>
                                                <th id="th5" class ="inner_md_htext">Bill Month / Year</th>
                                                <th id="th5" class ="inner_md_htext">Status</th>
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

