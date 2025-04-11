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

<script type="text/javascript">
$(document).ready(function(){
    loadBillDetails();

    $('#back').on('click', function(){
        window.location = 'vendorBillApprovalListCO';
    });

    $('#submitBtn').on('click', function(){
        var values = [];
        $('[name="coRemarks"]').each(function(i, $obj){
            if(!$($obj).val()){
                $($obj).focus()
                alert('Please enter CO remarks!');
            }else{
                var removePenalty = $($obj).attr('data-remove-penalty');
                var id = $($obj).attr('data-vendor-mmu-detail-id');
                var remarks = $($obj).val();
                values.push({'id': id, 'remarks': remarks, 'removePenalty': removePenalty});
            }
        });

        var formData = new FormData(document.getElementById("vendorBillCOForm"));
        formData.append('captureVendorBillDetailId', $('#captureVendorBillDetailId').val());
        formData.append('vendorBillAuditorData', JSON.stringify(values));
        formData.append('status', 'A');
        formData.append('remarksType', 'CO');

        $(this).attr('disabled', true);
        var url = 'updateVendorBillRemarks';
        SendMultipartData(url,formData,successCallback,$(this));
    });

    $('#downloadBill').on('click', function(){
        window.location = "download?name="+$(this).data('name')+"&type=vendor_bill&keys="+$('#invoiceNo').val();
    });

    $('#downloadAuditorReport').on('click', function(){
        window.location = "download?name="+$(this).data('name')+"&type=vendor_auditor&keys="+$('#captureVendorBillDetailId').val();
    });
});

function successCallback($elementObj){
    location.reload();
}

function loadBillDetails(){
    var months = ['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC'];
    jQuery.ajax({
        crossOrigin: true,
        method: "GET",
        crossDomain:true,
        url: 'vendorInvoiceDetailDataCO',
        enctype: 'multipart/form-data',
        processData: false,
        contentType: false,
        dataType: "json",
        success: function(result){
            if(result && result.vendorInvoiceDetailData && result.vendorInvoiceDetailData.data && result.vendorInvoiceDetailData.data.length > 0){
                var rowData = result.vendorInvoiceDetailData.data[0];
                $('#captureVendorBillDetailId').val(rowData.captureVendorBillDetailId);
                $('#vendorId').val(rowData.vendorName);
                $('#cityId').val(rowData.cityName);
                $('#billYear').val(rowData.billYear);
                $('#billMonth').val(months[rowData.billMonth]);
                $('#invoiceNo').val(rowData.invoiceNo);
                $('#invoiceDate').val(rowData.invoiceDate);
                $('#invoiceAmount').val(rowData.invoiceAmount);
                $('#downloadBill').attr('data-name', rowData.uploadedFileName);
                $('#downloadAuditorReport').attr('data-name', rowData.auditorFileName);
                if(rowData.status == 'A')
                    $('#submitBtn').attr('disabled', true);

                var mmuNames = rowData.mmuNames.split(',');
                for(var i=0;i<mmuNames.length;i++){
                    $('#mmuIds').append($('<option/>').text(mmuNames[i]))
                }
            }

            if(result && result.penaltyDetailData && result.penaltyDetailData.data && result.penaltyDetailData.data.mmuPenaltySum){
                var mmuPenaltySum = result.penaltyDetailData.data.mmuPenaltySum;
                var mmuPenalty = result.penaltyDetailData.data.mmuPenalty;
                for(key in mmuPenaltySum){
                    var readonly = false;
                    var coReadonly = false;
                    var removePenaltyChecked = false;
                    if(mmuPenaltySum[key][0]) readonly = true;
                    if(mmuPenaltySum[key][2]) coReadonly = true;
                    if(mmuPenaltySum[key][3] == 'Y'){
                        removePenaltyChecked = true;
                    }


                    var $remarks = $('<textarea/>')
                        .attr({'name':'auditorsRemarks','rows':'2','cols':'1','class':'form-control','data-vendor-mmu-detail-id': mmuPenaltySum[key][1]})
                        .attr('readonly', readonly).val(mmuPenaltySum[key][0]);

                    var $removePenalty = $('<input/>',{'type': 'checkbox'}).attr('checked', removePenaltyChecked).attr('disabled', removePenaltyChecked).on('click', function(){
                        if($(this).is(':checked'))
                            $(this).parent().next().children().attr('data-remove-penalty', 'Y');
                        else $(this).parent().next().children().attr('data-remove-penalty', 'N');
                    });
                    var $coRemarks = $('<textarea/>')
                                    .attr({'data-remove-penalty':'N','name':'coRemarks','rows':'2','cols':'1','class':'form-control','data-vendor-mmu-detail-id': mmuPenaltySum[key][1]})
                                    .attr('readonly', coReadonly).val(mmuPenaltySum[key][2]);

                    var $tr = $('<tr/>')
                    .append($('<td/>').text(key))
                    .append($('<td/>').text(mmuPenaltySum[key][4]))
                    .append($('<td/>').append($remarks))
                    .append($('<td/>',{'align': 'center'}).append($removePenalty))
                    .append($('<td/>').append($coRemarks))
                    .append($('<td/>',{'width':'150'}).append($('<button class="btn btn-primary" data-toggle="modal" data-target="#penaltyModal" data-background="static">View Details</button>').on('click', function(){
                        var $insTitleTr = $('<tr/>').append($('<td/>').attr('colspan', 3).css('background-color', 'lavender').append('<b>Inspection Penalty Incident List</b>'));
                        var $equipTitleTr = $('<tr/>').append($('<td/>').attr('colspan', 3).css('background-color', 'lavender').append('<b>Equipment Penalty Incident List</b>'));
                        var $attenTitleTr = $('<tr/>').append($('<td/>').attr('colspan', 3).css('background-color', 'lavender').append('<b>Attendance Penalty Incident List</b>'));
                        $('#inspectionPenaltyIncidentList').empty().append($insTitleTr);
                        $('#equipmentPenaltyIncidentList').empty().append($equipTitleTr);
                        $('#attendancePenaltyIncidentList').empty().append($attenTitleTr);

                        $('#mmuNameLabel').text(key);
                        var insSubtotal = 0;
                        var equipSubtotal = 0;
                        var attenSubtotal = 0;
                        var penaltyData = result.penaltyDetailData.data.mmuPenalty[key];
                        for(var i=0;i<penaltyData.length;i++){
                            var record = penaltyData[i];
                            var $tr1 = $('<tr/>')
                                .append($('<td/>').attr('width', '95px').text(record.incidentDate))
                                .append($('<td/>').text(record.incidentDescription))
                                .append($('<td/>').attr('width', '110px').text(record.penaltyAmount));
                            if(record.penaltyType == 'INSPECTION'){
                                $('#inspectionPenaltyIncidentList').append($tr1);
                                insSubtotal += parseInt(record.penaltyAmount);
                            } else if(record.penaltyType == 'EQUIPMENT') {
                                $('#equipmentPenaltyIncidentList').append($tr1);
                                equipSubtotal += parseInt(record.penaltyAmount);
                            } else {
                                $('#attendancePenaltyIncidentList').append($tr1);
                                attenSubtotal += parseInt(record.penaltyAmount);
                            }
                        }
                        var $insSubtitleTr = $('<tr/>')
                            .append($('<td/>').attr('colspan', 2).css('background-color', 'lavender').append('<b>Inspection Penalty Subtotal</b>'))
                            .append($('<td/>').css('background-color', 'lavender').append('<b>'+insSubtotal+'</b>'));
                        var $equipSubtitleTr = $('<tr/>')
                            .append($('<td/>').attr('colspan', 2).css('background-color', 'lavender').append('<b>Equipment Penalty Subtotal</b>'))
                            .append($('<td/>').css('background-color', 'lavender').append('<b>'+equipSubtotal+'</b>'));
                        var $attenSubtitleTr = $('<tr/>')
                            .append($('<td/>').attr('colspan', 2).css('background-color', 'lavender').append('<b>Attendance Penalty Subtotal</b>'))
                            .append($('<td/>').css('background-color', 'lavender').append('<b>'+attenSubtotal+'</b>'));
                        $('#inspectionPenaltyIncidentList').append($insSubtitleTr);
                        $('#equipmentPenaltyIncidentList').append($equipSubtitleTr);
                        $('#attendancePenaltyIncidentList').append($attenSubtitleTr);
                    })));
                    $('#mmuPenaltyList').append($tr);
                }
            }
        }
    });
}

function get(name){
   if(name=(new RegExp('[?&]'+encodeURIComponent(name)+'=([^&]*)')).exec(location.search))
      return decodeURIComponent(name[1]);
}
</script>
</head>

<body>
 <!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">Vendor Invoice Approval for CO</div>
                <input type="hidden" id="captureVendorBillDetailId"/>
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Vendor</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="vendorId" class="form-control" disabled/>
											</div>
										</div>
									</div>

									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="cityId" class="form-control" disabled/>
											</div>
										</div>
									</div>
								</div>
								<div class="row">

											<div class="col-md-4">
												<div class="form-group row  autocomplete">

													<label class="col-md-5 col-form-label">MMU</label>
													<div class="col-md-7">
															<select name="mmuIds" multiple="4" value="" size="5"
																tabindex="1" id="mmuIds" class="listBig width-full disablecopypaste" disabled>
															</select>
													</div>

												</div>
											</div>
											<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">Year and Month</label>
													</div>
													<div class="col-md-7">
													    <input type="text" id="billMonth" class="form-control" disabled/>
													</div>

												</div>
											</div>
											<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<label class="col-form-label col-md-1">/</label>
													<div class="col-md-7">
														<input type="text" id="billYear" class="form-control" disabled/>
													</div>
												</div>
											</div>
								</div>
								<div class="row m-t-10">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Invoice No</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="invoiceNo" class="form-control" disabled/>
											</div>

										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Invoice Date</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" class="form-control" id="invoiceDate" disabled/>
												</div>
											</div>
										</div>
									</div>
								</div>

								<div class="row m-t-10">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Invoice Amount</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="invoiceAmount" class="form-control" disabled/>
											</div>

										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label"></label>
											</div>
											<div class="col-md-7">
												<button class="btn btn-primary" id="downloadBill">Download Bill</button>
											</div>
										</div>
									</div>
								</div>

								<div>
									<h6 class="font-weight-bold text-theme text-underline">Penalty Details</h6>

									<div class="table-responsive">
										<table
											class="table table-striped table-hover table-bordered " id="campTable">
											<thead class="bg-success" style="color: #fff;">
												<tr>
													<th>MMU Name</th>
													<th>Penalty Amount</th>
													<th>Auditor Remarks</th>
													<th>Remove Penalty</th>
													<th>CO Remarks</th>
													<th>Action</th>
												</tr>
											</thead>
											<tbody id="mmuPenaltyList">

											</tbody>
										</table>
									</div>
								</div>
								<div class="row"><div class="col-md-2">
								    <form id="vendorBillCOForm">
                                    <b>Auditor Report:</b> &nbsp;&nbsp;&nbsp;<i class="fa fa-download" id="downloadAuditorReport" style="font-size:large;color: green;cursor:pointer" title="Download" aria-hidden="true"></i>
								    </form>
								</div></div><br>

								<div class="row">
                                	<div class="col-12 m-t-10 text-right">
                                	    <button class="btn btn-primary" id="submitBtn">Submit</button>
                               			<button class="btn btn-primary" id="back">Back</button>
                               		</div>
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

<div class="modal" id="billModal" tabindex="-1" role="dialog" aria-labelledby="billModal">
	  <div class="modal-dialog modal-lg" role="document">
	  <input type="hidden" id="" name="" value="">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title font-weight-bold">View Bill</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">

	      </div>

	    </div>
	  </div>
</div>

<div class="modal" id="penaltyModal" tabindex="-1" role="dialog" aria-labelledby="penaltyModal">
	  <div class="modal-dialog modal-lg" role="document">
	  <input type="hidden" id="" name="" value="">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title font-weight-bold">Penalty Details</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<div class="row">
				<div class="col-md-3">
					<label class="col-form-label">MMU  Name:</label>
				</div>
				<div class="col-md-9">
					<label class="col-form-label" id="mmuNameLabel"></label>
				</div>
	      	</div>
	      	<div class="table-responsive m-t-10">
				<table
					class="table table-striped table-hover table-bordered " id="campTable">
					<thead class="bg-success" style="color: #fff;">
						<tr>
							<th>Incident Date</th>
							<th>Incident Description</th>
							<th>Penalty Amount</th>
						</tr>
					</thead>
					<tbody id="inspectionPenaltyIncidentList">

					</tbody>
				</table>
				<table
                    class="table table-striped table-hover table-bordered " id="campTable">
                    <thead class="bg-success" style="color: #fff;">
                    </thead>
                    <tbody id="equipmentPenaltyIncidentList">

                    </tbody>
                </table>
                <table
                    class="table table-striped table-hover table-bordered " id="campTable">
                    <thead class="bg-success" style="color: #fff;">
                    </thead>
                    <tbody id="attendancePenaltyIncidentList">

                    </tbody>
                </table>
			</div>
	      	<div class="row">
            	<div class="col-12 m-t-10 text-right">
           			<button class="btn btn-primary"  data-dismiss="modal" aria-label="Close" >Close</button>
           		</div>
      		</div>
	      </div>

	    </div>
	  </div>
</div>


</body>

</html>


<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>