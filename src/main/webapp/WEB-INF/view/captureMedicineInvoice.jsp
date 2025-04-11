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
$j(document).ready(function(){
    getCityList();
    addRow();
    //loadTable();

    $('#btnSubmit').on('click', function(){
        $('[type=text]').css('border', '1px solid #ced4da');
        $('.upload-file-label').css('border', 'solid 1px var(--blue-primary)');
        var $invoiceNos = $('.invoice-no')
        var $invoiceAmount = $('.invoice-amount')
        var $inputUpload = $('.upload-file')
        var invoiceDt = [];
        var invoiceNo = [];
        var invoiceAmnt = [];
        var isValidForm = true;

        if(!$('#cityList').val()){
            alert('Please select City!');
            return false;
        }

        if(!$('#medicineSource').val()){
            alert('Please select Source of Medicine!');
            return false;
        }

        $('.invoice-date').each(function(i, $obj){
            if(!$($obj).val()){
                $($obj).css({'border-color':'red'}).focus();
                alert('Invoice Date should not be blank!');
                isValidForm = false;
                return false;
            }else{
                invoiceDt.push($($obj).val());
            }
            if(!$($invoiceNos[i]).val()){
                $($invoiceNos[i]).css({'border-color':'red'}).focus();
                alert('Invoice No should not be blank!');
                isValidForm = false;
                return false;
            }else{
                invoiceNo.push($($invoiceNos[i]).val());
            }

            if(!$($invoiceAmount[i]).val()){
                $($invoiceAmount[i]).css({'border-color':'red'}).focus();
                alert('Invoice Amount should not be blank!');
                isValidForm = false;
                return false;
            }else{
                invoiceAmnt.push($($invoiceAmount[i]).val());
            }

            if(!$($inputUpload[i]).val()){
                $($inputUpload[i]).next().css({'border-color':'red'});
                alert('Please select invoice file to upload!');
                isValidForm = false;
                return false;
            }
        });



        if(isValidForm && confirm('Are you want to Submit the form?')){
            var formData = new FormData(document.getElementById("captureInspectionChecklistDetails"));
            formData.append('invoiceDates', invoiceDt);
            formData.append('invoiceNos', invoiceNo);
            formData.append('invoiceAmount', invoiceAmnt);
            formData.append('city', $('#cityList').val());
            formData.append('medicineSource', $('#medicineSource').val());
            formData.append('medicineSubSource', $('#medicineSubSource').val());

            var url = "captureMedicineInvoiceDetails";
            SendMultipartData(url,formData,successCallback,$(this));
        }
    });
});

function successCallback($elementObj){

}

function loadTable(){
    var tr = $('#firstRow');
    $('#medicineInvoiceTable').append(tr.clone());
}

function addRow(){
    var rowCount = $('#medicineInvoiceTable').children().length;
    var $tr = $('<tr/>');
    var $dateInput = $('<input/>').attr({'type':'text','id':'invoiceDt'+rowCount,'placeholder':'DD/MM/YYYY'}).addClass('calDate form-control invoice-date');
    //var $img = $('<img/>').addClass('ui-datepicker-trigger').attr({'src':'../resources/images/calendar.gif', 'alt':'Select Date','title':'Select Date'});
    var $td1Div = $('<div/>').addClass('dateHolder').append($dateInput);
    var $td1 = $('<td/>').append($td1Div);

    var $invoiceNoInput = $('<input/>',{'type':'text'}).addClass('form-control invoice-no');
    var $td2 = $('<td/>').append($invoiceNoInput);

    var $invoiceAmntInput = $('<input/>',{'type':'text'}).addClass('form-control invoice-amount');
    var $td3 = $('<td/>').append($invoiceAmntInput);

    var $fileInput = $('<input/>').attr({'type':'file','class':'inputUpload upload-file'});
    var $fileInputLabel = $('<label/>').addClass('inputUploadlabel upload-file-label').text('Choose File');
    var $fileInputSpan = $('<span/>').addClass('inputUploadFileName').text('No File Chosen');
    var $td4Div = $('<div/>').addClass('fileUploadDiv')
                   .append($fileInput)
                   .append($fileInputLabel)
                   .append($fileInputSpan);
    var $td4 = $('<td/>').append($td4Div);

    var $addBtn = $('<button/>').addClass('btn btn-primary buttonAdd noMinWidth').attr('button-type', 'add').on('click', function(){
        addRow();
    });
    var $deleteBtn = $('<button/>').addClass('buttonDel btn btn-danger noMinWidth').attr('button-type', 'delete').on('click', function(){
         $tr.remove();
     });
    var $td5 = $('<td/>').append($addBtn).append('&nbsp;').append($deleteBtn);

    $tr.append($td1).append($td2).append($td3).append($td4).append($td5);
    $('#medicineInvoiceTable').append($tr);
}


function getCityList(){
    $.ajax({
        type : "POST",
        contentType : "application/json",
        url : '${pageContext.request.contextPath}/master/getAllCity',
        data : JSON.stringify({"PN":"0"}),
        dataType : "json",
        cache : false,
        success : function(result) {
            if(result && result.data && result.data.length > 0){
                $.each(result.data, function(i, e){
                    $('#cityList').append($('<option/>').val(e.cityId).text(e.cityName));
                });
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
			<div class="container-fluid">

				<div class="internal_Htext">Capture Medicine Invoice Details</div>

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
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="cityList">
												    <option value="">--SELECT--</option>
												</select>
											</div>
										</div>
									</div>
									<div class="w-100"></div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Source of Medicine</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="medicineSource">
												    <option value="">--SELECT--</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-7">
												<select class="form-control" id="medicineSubSource">
												    <option value="">--SELECT--</option>
												</select>
											</div>
										</div>
									</div>
									
								</div>
								
								
								
								<div class="row">
									
									
									<div class="col-12">
										<div class="table-responsive">
									<table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                                                                         
                                                <th>Invoice Date</th>
                                                <th>Invoice No.</th>
                                                <th>Invoice Amount</th>
                                                <th>File</th>
                                                <th>Action</th>
                                            
                                        </thead>
                                        
	                                     <tbody class="" id="medicineInvoiceTable">
	                                     
											 <tr id="firstRow">
											 	<td>
											 		<div class="dateHolder">
														<input type="text" name="" id="" class="calDate form-control"
														value="" placeholder="DD/MM/YYYY"  />
													</div>
											 	</td>
											 	<td>
													<input type="text" class="form-comtrol">
												</td>
											 	<td>
											  		<input type="text" class="form-comtrol">
											  	</td>
											  	<td>
											  		<div class="fileUploadDiv">
													  	<input type="file" class="inputUpload" name="" id="">
													  	<label class="inputUploadlabel">Choose File</label>
														<span id="" class="inputUploadFileName">No File Chosen</span>												
												  	</div>
											  	</td>
											 	<td>
													<button type="button" type="button"
														class="btn btn-primary buttonAdd noMinWidth" value=""
														button-type="add"></button>
													<button type="button" name="delete" value="" id="deleteMC"
														class="buttonDel btn btn-danger noMinWidth"
														button-type="delete"></button>
												</td>
											 </tr>
	                     				 </tbody>
                                    </table>
								</div>
									</div>
								</div>
								
								
								<div class="row"> 
	                               <div class="col-md-12 text-right">														 
										<input type="button"  id="btnSubmit" type="button" class="btn  btn-primary " onclick="" value="Submit" />
										<input type="button"  id="btnClose" type="button" class="btn  btn-primary " onclick="" value="Close" />
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


</body>

</html>






