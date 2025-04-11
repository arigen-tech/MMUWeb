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
<title>Mobile Medical Unit- MMSSY</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>


<script type="text/javascript">

<%	
String userId = "1";
if (session.getAttribute("userId") != null) {
	userId = session.getAttribute("userId") + "";
}
%>

nPageNo=1;
var $j = jQuery.noConflict();
$j(document).ready(function()
		{
	getMMUList();
	populateDates();
	//getPendingListPhotoValidation('ALL');
		});
	
	
function getPendingListPhotoValidation(MODE) { 	
 	
			 
	var mobileNo = $j('#mobileNo').val();
		var mmuId = $j('#mmuId').val();
		var fromDate = $j('#fromDate').val();
		var toDate = $j('#toDate').val();
		nPageNo = 1;
		if (MODE == 'ALL') {			
			var data = {
				"pageNo" : nPageNo,
				"mobileNo" : "",
				"mmu" : "",
				"fromDate" : "",
				"toDate" : ""
			};
		} else if (mobileNo != "" || mmuId != "" || fromDate != ""
				|| toDate != "" ) {
			nPageNo = 1;
			var data = {
				"pageNo" : nPageNo,
				"mobileNo" : mobileNo,
				"mmu" : mmuId,
				"fromDate" : fromDate,
				"toDate" : toDate
			};
		} else {
			var data = {
				"pageNo" : nPageNo
			};
		}

		var url = "pendingListPhoto";
		var bClickable = false;
		GetOpdJsonData('tblListofEmp', data, url, bClickable);
	}

	function makeTable(jsonData) {
		var htmlTable = "";
		var data = jsonData.count;

		var dataList = jsonData.data;
		if (dataList != undefined && dataList != "" && dataList.length >= 0) {
			var counter = 1;
			for (i = 0; i < dataList.length; i++) {

				htmlTable = htmlTable + "<tr  id=''>";
				htmlTable = htmlTable
						+ "<td  style='width: 200px;' >"
						+ dataList[i].attnDate
						+ "<input type='hidden' value='"+dataList[i].attnDate+"' id='attnDate"+counter+"'/></td>";
				htmlTable = htmlTable
						+ "<td  style='width: 200px;' >"
						+ dataList[i].mmuName
						+ "<input type='hidden' value='"+dataList[i].mmuId+"' id='mmuId"+counter+"'/></td>";
				htmlTable = htmlTable
						+ "<td  style='width: 200px;'>"
						+ dataList[i].empName
						+ "<input type='hidden' value='"+dataList[i].empId+"' id='empId"+counter+"'/></td>";
						var gender = '';
						if(dataList[i].gender=='F'){
							gender='FEMALE';
						} else if(dataList[i].gender=='M'){
							gender='MALE';
						}else if(dataList[i].gender=='O'){
							gender='TRANSGENDER';
						}
				htmlTable = htmlTable + "<td style='width: 150px;'>"
						+ gender
						+ "</td>";
				htmlTable = htmlTable + "<td style='width: 200px;'>"
						+ dataList[i].mobileNo + "</td>";
				htmlTable = htmlTable
						+ "<td style='width: 200px;'>"
						+ dataList[i].empType
						+ "<input type='hidden' value='"+dataList[i].auditAttendanceId+"' id='attnId"+counter+"'/></td>";
				var photoString = dataList[i].profileImage;
				if(photoString !='' && photoString.length > 100){
				htmlTable = htmlTable
						+ "<td  style='width: 400px;'><div><img src='data:image/jpg;base64,"+photoString+"' class='profileImgTable' id='profileImage"+i+"' /></div></td>";
				
				} else {
					htmlTable = htmlTable
					+ "<td  style='width: 400px;'><div><img src='/MMUWeb/resources/images/no-photo.jpg' class='profileImgTable' /></div></td>";
				}		
				
				
						var inPhotoString = dataList[i].inPhotoBase64String;
				if(inPhotoString !='' ){
				htmlTable = htmlTable
						+ "<td style='width: 400px;'><img src='data:image/jpg;base64,"+inPhotoString+"' class='profileImgTable' id='profileImage"+i+"' /></td>";
				} else {
					htmlTable = htmlTable
					+ "<td  style='width: 400px;'><div><img src='/MMUWeb/resources/images/no-photo.jpg' class='profileImgTable' /></div></td>";
				}
						
						var outPhotoString = dataList[i].outPhotoBase64String;
						if(outPhotoString !='' ){
					htmlTable = htmlTable
							+ "<td style='width: 200px;'><img src='data:image/jpg;base64,"+outPhotoString+"' class='profileImgTable' id='profileImage"+i+"' /></td>";
				} else {
					htmlTable = htmlTable
					+ "<td  style='width: 400px;'><div><img src='/MMUWeb/resources/images/no-photo.jpg' class='profileImgTable' /></div></td>";
				}
				htmlTable = htmlTable
						+ "<td style='width: 150px;'><div class='form-check form-check-inline cusRadio m-t-7'>"
						+ "<input class='form-check-input' id='matched"+counter+"' checked name='matchedRadio"+counter+"' type='radio'>"
						+ "<span class='cus-radiobtn'></span></div></td>";
				htmlTable = htmlTable
						+ "<td style='width: 150px;'><div class='form-check form-check-inline cusRadio m-t-7'>"
						+ "<input class='form-check-input' id='notMatched"+counter+"' name='matchedRadio"+counter+"' type='radio'>"
						+ "<span class='cus-radiobtn'></span></div></td>";

				htmlTable = htmlTable + "</tr>";
				counter++;
			}
		}
		if (jsonData.status == 0) {
			htmlTable = htmlTable
					+ "<tr ><td colspan='12'><h6>No Record Found</h6></td></tr>";
			//alert('No Record Found');
		}

		$j("#listPendingPhotoGrid").html(htmlTable);
	}

	function savePhotoMatchedStatus(item) {

		var photoValidationData = [];
		var photoValidation = '';
		var idforTreat = '';

		$('#listPendingPhotoGrid tr').each(
				function(i, el) {
					idforTreat = $(this).find("td:eq(0)").find("input:eq(0)")
							.attr("id")
					var $tds = $(this).find('td')

					var attnDate = $tds.eq(0).find(":input").val();
					var mmuId = $tds.eq(1).find(":input").val();
					var empId = $tds.eq(2).find(":input").val();
					var attnId = $tds.eq(5).find(":input").val();
					var photoMatched = '';

					if ($tds.eq(9).find(":radio").prop("checked")) {
						photoMatched = 'Y'
					}
					if ($tds.eq(10).find(":radio").prop("checked")) {
						photoMatched = 'N'
					}

					photoValidation = {
						'auditAttnId' : attnId,
						'attnDate' : attnDate,
						'mmuId' : mmuId,
						'empId' : empId,
						'photoMatched' : photoMatched,
						'userId' : "<%= userId %>"
			
		} 
	photoValidationData.push(photoValidation);
});

	
	var params = {
			"photoValidationData":photoValidationData
			
			
	}
	console.log(JSON.stringify(params));
	
	//return;
	$j(item).attr("disabled", true);
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : "savePhotoValidation",
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,		
		
		success : function(data) {
			if(data.status){
				alert(data.msg+'S');
			}else{
				alert(data.msg);
			}
			ResetForm();
		},
		error : function(data) {
			$j(item).attr("disabled", false);
			alert("An error has occurred while contacting the server");
		}
	}); 
	
}

	
	function GetOpdJsonData(tableId,data,url,bClickable,waitingImgId)
	{
		
		$j("#"+waitingImgId).show();
		
		$j('.SearchStatus').css('color','green');
		$j('.SearchStatus').html('<i class="fa fa-spinner fa-spin"></i> '+S_Search_Searching);
		
				$j.ajax({
					type:"POST",
					contentType : "application/json",
					url: url,
					data : JSON.stringify(data),
					dataType: "json",			
					cache: false,
					success: function(msg)
					{
						$j("#"+waitingImgId).hide();
						var jsonData = msg;	
						
							
								var totalMatches = jsonData.count;
								
								var totalRecordsForPagination = 0;
								
								if(totalMatches == 300){
									alert("Maximum 300 records will be displayed. Please modify search criteria for specific search");
								}

								if(totalMatches>0)
									{
										totalRecordsForPagination = jsonData.count;
									}
								var NumberOfPages = Math.ceil(totalRecordsForPagination/paginationCount);
								$j("#resultnavigation").html("");
								//createPaginating(NumberOfPages);
								
								//DoEnableDisabledPaging(NumberOfPages);	
								
								
								if(NumberOfPages == 1)
									{
										//$j("#resultnavigation").html("");
									}
								if(totalRecordsForPagination == 0)
									{									
										$j('.SearchStatus').html(S_Search_NoMatches);
									}
								 if(totalRecordsForPagination == 1)
									{
										$j('.SearchStatus').html(totalRecordsForPagination + " " +S_Search_Single_Match);	
									}	
								 if(totalRecordsForPagination > 1)
									{
										$j('.SearchStatus').html(totalRecordsForPagination + " " +S_Search_Multi_Matches);	
									}	
								  
								  makeTable(jsonData);
								
								
							
						
					},
					error: function(msg)
					{					
						
						alert("An error has occurred while contacting the server");
						$j('.SearchStatus').css('color','red');
						$j('.SearchStatus').html(S_Search_Error);
						$j("#"+waitingImgId).hide();
						
					}
					
					
				});
	}	
	

function showResultPage(pageNo) 	
{

nPageNo = pageNo;	
getPendingListPhotoValidation('FILTER');

}	
function showAll()
{
	nPageNo = 1;	
	getPendingListPhotoValidation('ALL');
	
}
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
function searchPendingPhotoList()
{
	
	var nPageNo=1;	
	 	
	 	    var mobileNo = $j('#mobileNo').val();
		 	var mmuId = $j('#mmuId').val();
		 	var fromDate = $j('#fromDate').val();
		 	var toDate = $j('#toDate').val();
	 	
	if((mobileNo == undefined || mobileNo == '') && (mmuId == undefined || mmuId == '') && (fromDate == undefined || fromDate == '') 
			&& (toDate == undefined || toDate == ''  )){	
		alert("At least one option must be entered");
		return;
	}
	getPendingListPhotoValidation('FILTER');
	//ResetForm();
} 

function ResetForm()
{	
	 $j('#mobileNo').val('');
	 $j('#mmuId').val('');
	 $j('#fromDate').val('');
	 $j('#toDate').val('');
} 
function populateDates(){
    var dt = new Date();
    var currDate = ("0" + dt.getDate()).slice(-2)+'/'+("0" + (dt.getMonth() + 1)).slice(-2)+'/'+dt.getFullYear();
    $('#fromDate').val(currDate);
    $('#toDate').val(currDate);
}
 
function compareDate(){
	
	
	var fromDate = $('#fromDate').val();
	var toDate = $('#toDate').val();

	if (process(toDate) < process(fromDate)) {
		alert("To date should not be earlier than the From date");
		$('#toDate').val("");
		return;
	}
}
function backToWaitingList(){
	window.location = "pendingListPhotoValidation";
}
</script>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">Pending List of Photo Validation</div>

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
												<label class="col-form-label">MMU Name</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="mmuId"></select>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Mobile No</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="mobileNo" name="mobileNo" class="form-control" maxlength="10" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" placeholder="Mobile Number"/>
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
													<input type="text" id="fromDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" onchange="compareDate()">
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
													<input type="text" id="toDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" onchange="compareDate()">
												</div>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-12">
										<button type="button" class="btn btn-primary" onclick="searchPendingPhotoList();">Search</button>
									</div>
									<!-- <div class="col-md-2 text-right">
												<button type="button" class="btn  btn-primary " onclick="showAll('ALL');">Show All</button>
										</div> -->
								</div>
								
								<div class="m-t-10">
									<div class="clearfix">
										<div style="float: left">
											<table class="tblSearchActions" cellspacing="0"
												cellpadding="0" border="0">
												<tr>
													<td class="SearchStatus" style="font-size: 15px;"
														align="left">Search Results</td>
													<td></td>
												</tr>
											</table>
											
										</div>

										<div style="float: right">
											<div id="resultnavigation"></div>
										</div>
										<div class="table-responsive" id="">
											<table
												class="table table-striped table-hover table-bordered " id="">
												<thead class="bg-success" style="color: #fff;">
													<tr style='background-color: #84e08f'>
														<th>Attendance Date</th>
														<th>MMU Name</th>
														<th>Employee Name</th>
														<th>Gender</th>
														<th>Mobile No</th>
														<th>Designation</th>
														<th>Profile Photo</th>
														<th>In Time Photo</th>
														<th>Out Time Photo</th>
														<th>Matched</th>
														<th>Not Matched</th>
														
													</tr>
												</thead>
												<tbody id="listPendingPhotoGrid">  
													
												</tbody>
											</table>
										</div>
									</div>
								</div>
								
								<div class="col-12 text-right">
									<button type="button" class="btn btn-primary" id="submitBtn" onclick="savePhotoMatchedStatus(this);">Submit</button>
									<button type="button" class="btn  btn-primary" onclick="backToWaitingList()">Back</button>
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

</body>

</html>
