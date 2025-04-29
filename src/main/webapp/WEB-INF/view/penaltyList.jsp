<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Indian Coast Guard</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>

<script type="text/javascript">
    var nPageNo=1;
	var $j = jQuery.noConflict();
	
	$j(document).ready(function(){
        getMMUList();
        getYears();
        getMonths();
    });
	
	function getMMUList(){
		var params = { };
		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : 'getMMUList',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(data) {
				if(data.status == true){
					var list = data.list;
					var mmuDrop = '<option value="">Select</option>';
					$j('#mmuId').find('option').not(':first').remove();
					for(i=0;i<list.length;i++){
						mmuDrop += '<option value='+list[i].mmuId+'>'+list[i].mmuName+'</option>';
					}
					$j('#mmuId').append(mmuDrop);
				}
			},
			error : function(data) {
				alert("An error has occurred while contacting the server");
			}
		}); 
	}
		
	function getYears(){
		var params = { };
		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : 'getAttendanceYears',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(data) {
				if(data.status == true){
					var list = data.list;
					var yearDrop = '<option value="">Select</option>';
					$j('#attnYear').find('option').not(':first').remove();
					for(i=0;i<list.length;i++){
						yearDrop += '<option value='+list[i].years+'>'+list[i].years+'</option>';
					}
					$j('#attnYear').append(yearDrop);
				}
			},
			error : function(data) {
				alert("An error has occurred while contacting the server");
			}
		}); 
	}	
	
function getMonths(){
     var params = { };
     $.ajax({
            type : "POST",
            contentType : "application/json",
            url : 'getAttendanceMonths',
            data : JSON.stringify(params),
            dataType : "json",
            cache : false,
            success : function(data) {
                if(data.status == true){
                    var list = data.list;
                    var monthDrop = '<option value="">Select</option>';
                    $j('#attnMonth').find('option').not(':first').remove();
                    for(i=0;i<list.length;i++){
                    	
                    	var monthVal = list[i].monthVal;
                    	monthVal = monthVal.toString();                    	
                        if(monthVal.length == 1) {
                            monthVal = '0' + monthVal; // Add leading zero
                        }
                        monthDrop += '<option value='+monthVal+'>'+list[i].month+'</option>';
                    }
                    $j('#attnMonth').append(monthDrop);
                }
            },
            error : function(data) {
                alert("An error has occurred while contacting the server");
            }
        });
	 
}

function searchPenaltyList(){
    var mmuId = $j('#mmuId').val();
    var attnMonth = $j('#attnMonth').val();
    var attnYear = $j('#attnYear').val();
    var searchType = $j('#searchType').val();

	if(!searchType){
	    alert('Please select Search Type!');
	    return false;
	}
	if((mmuId == undefined || mmuId == '') && (attnMonth == undefined || attnMonth == '') && (attnYear == undefined || attnYear == '') ){	
		alert("At least one option must be entered");
		return;
	}
	getPenaltyList('FILTER');
}

function getPenaltyList(MODE) { 	
 	$('#loadingStatus').empty().append('<i class="fa fa-spinner fa-spin"></i>  Refreshing...').css('color', 'green');
	var mmuId = $j('#mmuId').val();
 	var attnMonth = $j('#attnMonth').val();
 	var attnYear = $j('#attnYear').val();
 	var searchType = $j('#searchType').val();
    var data = {"pageNo": 0,"mmuId":mmuId,"attnMonth":attnMonth,"attnYear":attnYear,"searchType":searchType};

    var url = "getPenaltyList";
    var bClickable = true;
    //GetOpdJsonData('penaltyListGrid',data,url,bClickable);
    jQuery.ajax({
        crossOrigin: true,
        method: "POST",
        crossDomain:true,
        url: "getPenaltyList",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(result){
            var $grid = $('#penaltyListGrid').empty();
            var count = 0;
            var penaltyAmount = 0;
            if(result && result.data && result.data.length > 0){
                var data = result.data;
                count = data.length;
                for(var i=0;i<data.length;i++){
                    var $td1 = $('<td/>').text(i+1);
                    var $td2 = $('<td/>').text(data[i].incidentDate);
                    var $td3 = $('<td/>').text(data[i].description);
                    var $td4 = $('<td/>').text(data[i].penaltyAmount);
                    var $tr = $('<tr/>').append($td1).append($td2).append($td3).append($td4);
                    $grid.append($tr);
                    penaltyAmount += parseInt(data[i].penaltyAmount);
                }
            } else {
                var $tr = $('<tr/>').append($('<td/>').attr('colspan', 4).text('No record found!'))
                $grid.append($tr);
            }
            $('#loadingStatus').empty().text(count+' matches').css('color', 'green');
            $('#totalPenaltyAmt').val(penaltyAmount);
           
        }
    });
}

function exportExcel(){
 	
	//$('#loadingStatus').empty().append('<i class="fa fa-spinner fa-spin"></i>  Refreshing...').css('color', 'green');
	var mmuId = $j('#mmuId').val();
 	var attnMonth = $j('#attnMonth').val();
 	var attnYear = $j('#attnYear').val();
 	var searchType = $j('#searchType').val();
    var data = {"pageNo": 0,"mmuId":mmuId,"attnMonth":attnMonth,"attnYear":attnYear,"searchType":searchType};
    if(!searchType){
	    alert('Please select Search Type!');
	    return false;
	}
	if((mmuId == undefined || mmuId == '') && (attnMonth == undefined || attnMonth == '') && (attnYear == undefined || attnYear == '') ){	
		alert("At least one option must be entered");
		return;
	}
     		
   window.location.href =  "${pageContext.request.contextPath}/empRegistration/exportExcel?pageNo="
			+ 0
			+ "&mmuId="
			+ mmuId
			+ "&attnMonth="
			+ attnMonth
			+ "&attnYear="
			+ attnYear
			+ "&searchType="
			+ searchType;	
 
 }

</script>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">Incident Details</div>

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
                                                <label class="col-form-label">Audit Type</label>
                                            </div>
                                            <div class="col-md-7">
                                                <select class="form-control" id="searchType" >
                                                    <option value="">--Select--</option>
                                                    <option value="A">Attendance</option>
                                                    <option value="E">Equipment Audit</option>
                                                    <option value="I">Inspection Audit</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">MMU Name</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="mmuId">
												
												</select>
											</div>
										</div>
									</div>

									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Year</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="attnYear" >
												
												</select>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Month</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="attnMonth">
												
												</select>
											</div>
										</div>
									</div>
									<div class="col-lg-3 col-sm-6">
										
										<button type="button"  id="exportExcel" class="btn btn-primary m-t-3" onclick="exportExcel();">Excel</button>
										<button type="button"  id="exportPdf" class="btn btn-primary m-t-3" onclick="exportExcel();">PDF</button>
										
									</div>
									
									<div class="col-12 text-right">										
										<button type="button" class="btn btn-primary m-t-3" onclick="searchPenaltyList();">Search</button>										
									</div>
								</div>

								<div class="m-t-10">
									<div class="clearfix">
										<div class="clearfix">
											<div class="scrollableDiv m-b-10">
											    <p id="loadingStatus" style="font-size: 15px;">Search Results</p>
												<table
													class="table table-striped table-hover table-bordered" >
													<thead class="bg-success" style="color: #fff;">
														<tr>
															<th>S.No.</th>
															<th>Incident Date</th>
															<th>Incident Description</th>
															<th>Penalty Amount</th>
														</tr>
													</thead>
													<tbody id="penaltyListGrid">

													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
								
								<div class="row m-t-10">
									<div class="col-lg-6 col-sm-6 offset-lg-6">
										<div class="form-group row">
											<div class="col-md-7 text-right">
												<label class="col-form-label">Total Penalty Amount</label>
											</div>
											<div class="col-md-5">
												<input type="text" class="form-control" id="totalPenaltyAmt" disabled="disabled"/>
											</div>
										</div>
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

	<!-- jQuery  -->
<script>
	//scrollbar script
$(function(){
/* var winHeight = $(window).height();

$('.scrollableDiv').css({'height':winHeight-420}); */

// add custom scroll to sscrollableDiv class
    $('.scrollableDiv').slimscroll({
        height: 'inherit',
        position: 'right',
        color: '#9ea5ab',
        touchScrollStep: 50
    });
})

</script>

</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
