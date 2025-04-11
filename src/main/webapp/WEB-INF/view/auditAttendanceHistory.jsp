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

<%
	
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	
%>
<script type="text/javascript">

nPageNo=1;
var $j = jQuery.noConflict();

 
</script>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">Attendance History</div>

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
												<label class="col-form-label">MMU</label>
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
												<label class="col-form-label">Status</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="statusSearch">
												<option value=''>Select</option>
												<option value='P'>Present</option>
												<option value='A'>Absent</option>
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
													<input type="text" id="fromDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" 
													onblur="IsPastDate(this.id,this.value)" onchange="compareDate()">
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
													<input type="text" id="toDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" 
													onblur="IsPastDate(this.id,this.value)" onchange="compareDate()">
												</div>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-12">
										<button type="button" class="btn btn-primary" onclick="searchPendingAttendanceList();">Search</button>
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
													<tr>
														<th>Date of Attendance</th>
														<th>MMU Name</th>
														<th>Employee Name</th>
														<th>Gender</th>
														<th>Mobile No</th>
														<th>Designation</th>
														<th>Attendance Location</th>
														<th>Attendance Time</th>
														<th>Photo</th>
														<th>Status</th>
														<th>Remarks</th>														
													</tr>
												</thead>
												<tbody id="tblPendingAttnList">  
													
												</tbody>
											</table>
										</div>
									</div>
								</div>
								
								<!-- <div class="col-12 text-right">
									<button type="button" class="btn btn-primary" id="submitBtn" onclick="saveAttendanceAudit(this);">Submit</button>
								</div> -->

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


	 <div class="modal fade" id="locationModal" tabindex="-1" role="dialog" aria-labelledby="smallModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title font-weight-bold">Attendance Location</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<div class="row ">
				<div class="col-md-12">
					<h6 class="font-weight-bold text-theme text-underline">Camp Location</h6>
				</div>
				<div class="col-sm-6">
					<div class="form-group row">
						<div class="col-md-5">
							<label class="col-form-label">Longitude</label>
						</div>
						<div class="col-md-7">
								<input type="text" id="campLatitude" class="form-control" disabled="disabled">
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="form-group row">
						<div class="col-md-5">
							<label class="col-form-label">Latitude</label>
						</div>
						<div class="col-md-7">
								<input type="text" id="campLongitude" class="form-control" disabled="disabled">
						</div>
					</div>
				</div>
			</div>
			
			<div class="row m-t-10">
				<div class="col-md-12">
					<h6 class="font-weight-bold text-theme text-underline">Attendance Location(In Time)</h6>
				</div>
				<div class="col-sm-6">
					<div class="form-group row">
						<div class="col-md-5">
							<label class="col-form-label">Longitude</label>
						</div>
						<div class="col-md-7">
								<input type="text" id="atnLatitude" class="form-control" disabled="disabled">
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="form-group row">
						<div class="col-md-5">
							<label class="col-form-label">Latitude</label>
						</div>
						<div class="col-md-7">
								<input type="text" id="atnLongitude" class="form-control" disabled="disabled">
						</div>
					</div>
				</div>
				 <div class="col-sm-6">
					<div class="form-group row">
						<div class="col-md-5">
							<label class="col-form-label">In Time Distance(In meters)</label>
						</div>
						<div class="col-md-7">
								<input type="text" id="distance" class="form-control" disabled="disabled">
						</div>
					</div>
				</div> 
				
			</div>
			<!-- ---- -->
			<div class="row m-t-10">
				<div class="col-md-12">
					<h6 class="font-weight-bold text-theme text-underline">Attendance Location(Out Time)</h6>
				</div>
				<div class="col-sm-6">
					<div class="form-group row">
						<div class="col-md-5">
							<label class="col-form-label">Longitude</label>
						</div>
						<div class="col-md-7">
								<input type="text" id="atnOutLatitude" class="form-control" disabled="disabled">
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="form-group row">
						<div class="col-md-5">
							<label class="col-form-label">Latitude</label>
						</div>
						<div class="col-md-7">
								<input type="text" id="atnOutLongitude" class="form-control" disabled="disabled">
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="form-group row">
						<div class="col-md-5">
							<label class="col-form-label">Out Time Distance(In meters)</label>
						</div>
						<div class="col-md-7">
								<input type="text" id="outDistance" class="form-control" disabled="disabled">
						</div>
					</div>
				</div>
				
			</div>
			
			<!-- ---- -->
			<div class="row  m-t-10">
				<div class="col-md-12 text-right">
					<button type="button"  data-dismiss="modal" class="btn btn-primary">Close</button>
				</div>
			</div>
	      </div> 
	    </div>
	  </div>
	</div>
	
	 <div class="modal fade" id="timeModal" tabindex="-1" role="dialog" aria-labelledby="smallModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title font-weight-bold">Attendance Time</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<div class="row ">
				<div class="col-md-12">
					<h6 class="font-weight-bold text-theme text-underline">Camp Time</h6>
				</div>
				<div class="col-sm-6">
					<div class="form-group row">
						<div class="col-md-5">
							<label class="col-form-label">Start Time</label>
						</div>
						<div class="col-md-7">
								<input type="text" id="campStartTime" class="form-control" disabled="disabled">
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="form-group row">
						<div class="col-md-5">
							<label class="col-form-label">End Time</label>
						</div>
						<div class="col-md-7">
								<input type="text" id="campEndTime" class="form-control" disabled="disabled">
						</div>
					</div>
				</div>
			</div>
			
			<div class="row m-t-10">
				<div class="col-md-12">
					<h6 class="font-weight-bold text-theme text-underline">Attendance Time</h6>
				</div>
				<div class="col-sm-6">
					<div class="form-group row">
						<div class="col-md-5">
							<label class="col-form-label">In Time</label>
						</div>
						<div class="col-md-7">
								<input type="text" id="attenInTime" class="form-control" disabled="disabled">
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="form-group row">
						<div class="col-md-5">
							<label class="col-form-label">Out Time</label>
						</div>
						<div class="col-md-7">
								<input type="text" id="attenOutTime" class="form-control" disabled="disabled">
						</div>
					</div>
				</div>
			</div>
			<div class="row  m-t-10">
				<div class="col-md-12 text-right">
					<button type="button"  data-dismiss="modal" class="btn btn-primary">Close</button>
				</div>
			</div>
	      </div> 
	    </div>
	  </div>
	</div>
	
	 <div class="modal fade" id="photoModal" tabindex="-1" role="dialog" aria-labelledby="smallModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title font-weight-bold">Employee Photo</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<div class="row m-t-10">
				
				<div class="col-sm-4">
							<h6 class="font-weight-bold text-theme text-underline">Profile Photo</h6>
							<img src="/MMUWeb/resources/images/no-photo.jpg" class="profileImg" alt="" width="70%" id="profileImage">
				</div>
				<div class="col-sm-4">
							<h6 class="font-weight-bold text-theme text-underline">In Time Photo</h6>
							<img src="/MMUWeb/resources/images/no-photo.jpg" class="profileImg" alt="" width="70%" id="inTimeImage">
				</div>
				<div class="col-sm-4">
							<h6 class="font-weight-bold text-theme text-underline">Out Time Photo</h6>
							<img src="/MMUWeb/resources/images/no-photo.jpg" class="profileImg" alt="" width="70%" id="outTimeImage">
				</div>
			</div>
			<div class="row  m-t-20">
				<div class="col-md-12 text-right">
					<button type="button"  data-dismiss="modal" class="btn btn-primary">Close</button>
				</div>
			</div>
	      </div> 
	    </div>
	  </div>
	</div>

	<!-- jQuery  -->


</body>

<script type="text/javascript">
	window.history.forward();
	function preventBack() {
		window.history.forward(1);
	}
</script>
 
<script type="text/javascript" language="javascript">

var nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{
	    getMMUList();
	   // populateDates();
		//getPendingAttendanceList('ALL');
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
	 	
	 	    var mobileNo = $j('#mobileNo').val();
		 	var mmuId = $j('#mmuId').val();
		 	var fromDate = $j('#fromDate').val();
		 	var toDate = $j('#toDate').val();
		 	var statusSearch = $j('#statusSearch').val();
	 	
	if((mobileNo == undefined || mobileNo == '') && (mmuId == undefined || mmuId == '') && (fromDate == undefined || fromDate == '') 
			&& (toDate == undefined || toDate == ''  ) && (statusSearch == undefined || statusSearch == ''  )){	
		alert("At least one option must be entered");
		return;
	}
	getPendingAttendanceList('FILTER');
	//ResetForm();
} 


function ResetForm()
{	
	 $j('#mobileNo').val('');
	 $j('#mmuId').val('');
	 $j('#fromDate').val('');
	 $j('#toDate').val('');
}


function getPendingAttendanceList(MODE) { 	
 	
	    var mobileNo = $j('#mobileNo').val();
	 	var mmuId = $j('#mmuId').val();
	 	var fromDate = $j('#fromDate').val();
	 	var toDate = $j('#toDate').val();
	 	var statusSearch = $j('#statusSearch').val();
	 	
	 if(MODE == 'ALL'){
		 var data = {"pageNo":nPageNo,"mobileNo":"","mmu":"","fromDate":"","toDate":"","statusSearch":""};
		}
	   else if(mobileNo != ""||mmuId != "" || fromDate != ""||toDate != "" || statusSearch != "")
		{
		nPageNo = 1;
		var data = {"pageNo":nPageNo,"mobileNo":mobileNo,"mmu":mmuId,"fromDate":fromDate,"toDate":toDate,"statusSearch":statusSearch};
		} 
	   else
		{ 
		var data = {"pageNo":nPageNo};
		} 
	 
	var url = "auditAttendanceHistory";		
	var bClickable = true;
	GetOpdJsonData('tblPendingAttnList',data,url,bClickable);
}
 
 
 function makeTable(jsonData)
 {	
 	var htmlTable = "";	
 	var data = jsonData.count;
 	var counter = 1;
 	var dataList = jsonData.data;
 	if(dataList!=undefined && dataList!="" && dataList.length >= 0)	
 	{	
 	for(i=0;i<dataList.length;i++)
 		{	 		
 		
 			htmlTable = htmlTable+"<tr id=''>";
 			htmlTable = htmlTable +"<td  style='width: 120px;' >"+dataList[i].attenDate+"<input type='hidden' value='"+dataList[i].attenId+"' id='attnId"+counter+"'/></td>";
 			htmlTable = htmlTable +"<td  style='width: 120px;'>"+dataList[i].mmuName+"<input type='hidden' value='"+dataList[i].distMatched+"' id='distance"+counter+"'/></td>";
 			htmlTable = htmlTable +"<td  style='width: 120px;'>"+dataList[i].empName+"<input type='hidden' value='"+dataList[i].timeMatched+"' id='time"+counter+"'/></td>";
 			htmlTable = htmlTable +"<td style='width: 120px;'>"+dataList[i].gender+"</td>"; 
 			htmlTable = htmlTable +"<td  style='width: 100px;'>"+dataList[i].mobileNo+"</td>";
 			htmlTable = htmlTable +"<td  style='width: 120px;' >"+dataList[i].empType+"</td>";
 			if(dataList[i].distMatched == 'Matched'){
 				htmlTable = htmlTable +"<td class='text-center width120'><a href='javascript:void(0);' data-toggle='modal' data-target='#locationModal' "
 				+"onclick=showLocation('"+dataList[i].campLattitude+"','"+dataList[i].campLongitude+"','"+dataList[i].attendanceInLattitude+"','"+dataList[i].attendanceInLongitude+"','"+dataList[i].inTimeDistance+"','"+dataList[i].attendanceOutLattitude+"','"+dataList[i].attendanceOutLongitude+"','"+dataList[i].outTimeDistance+"') data-background='static' class='text-success'>"+dataList[i].distMatched+"</a></td>";
 			}else {
 				htmlTable = htmlTable +"<td class='text-center width120'><a href='javascript:void(0);' data-toggle='modal' data-target='#locationModal' "
 				+"onclick=showLocation('"+dataList[i].campLattitude+"','"+dataList[i].campLongitude+"','"+dataList[i].attendanceInLattitude+"','"+dataList[i].attendanceInLongitude+"','"+dataList[i].inTimeDistance+"','"+dataList[i].attendanceOutLattitude+"','"+dataList[i].attendanceOutLongitude+"','"+dataList[i].outTimeDistance+"') data-background='static' class='text-danger'>"+dataList[i].distMatched+"</a></td>";
 			}
 			if(dataList[i].timeMatched == 'Matched'){
 				htmlTable = htmlTable +"<td class='text-success text-center width120'><a href='javascript:void(0);' data-toggle='modal' data-target='#timeModal' "
 				+"onclick=showTime('"+dataList[i].campStartTime+"','"+dataList[i].campEndTime+"','"+dataList[i].attnInTime+"','"+dataList[i].attnOutTime+"') data-background='static' class='text-success'>"+dataList[i].timeMatched+"</a></td>";
 			}else {
 				htmlTable = htmlTable +"<td class='text-center width120'><a href='javascript:void(0);' data-toggle='modal' data-target='#timeModal' "
 				+"onclick=showTime('"+dataList[i].campStartTime+"','"+dataList[i].campEndTime+"','"+dataList[i].attnInTime+"','"+dataList[i].attnOutTime+"') data-background='static' class='text-danger'>"+dataList[i].timeMatched+"</a></td>";
 			}
 			if(dataList[i].photoMatched == 'Matched'){
 				htmlTable = htmlTable +"<td class='text-success text-center width120'><a href='javascript:void(0);' data-toggle='modal' data-target='#photoModal' "
 				+"onclick=showPhoto('"+dataList[i].profileImage+"','"+dataList[i].inPhotoBase64String+"','"+dataList[i].outPhotoBase64String+"') data-background='static' class='text-success'>"+dataList[i].photoMatched+"</a></td>";
 			} else {
 				htmlTable = htmlTable +"<td class='text-center width120'><a href='javascript:void(0);' data-toggle='modal' data-target='#photoModal' "
 				+"onclick=showPhoto('"+dataList[i].profileImage+"','"+dataList[i].inPhotoBase64String+"','"+dataList[i].outPhotoBase64String+"') data-background='static' class='text-danger'>"+dataList[i].photoMatched+"</a></td>";
 			}
 			htmlTable = htmlTable +"<td style='width: 150px;'><select class='form-control width100' name='status"+counter+"' id='status"+counter+"'><option value=''>Select</option>"
 			+"<option value='P' "
 			if(dataList[i].attendanceStatus == 'P'){
 				htmlTable = htmlTable 	+"selected"
 			}
 			htmlTable = htmlTable+">Present</option>"
 			+"<option value='A' "
 			if(dataList[i].attendanceStatus == 'A'){
 				htmlTable = htmlTable+"selected"
 			}
 			htmlTable = htmlTable+">Absent</option></select></td>"; 
 			
 			htmlTable = htmlTable +"<td style='width: 150px;' style='background-color: #808080' ><textarea class='form-control width150' id='remarks"+counter+"' name='remarks"+counter+"' readonly>"+dataList[i].attRemarks+"</textarea></td>"; 
  			htmlTable = htmlTable+"</tr>";
  			counter++;
 			
 		}	
 		}
 	   if(jsonData.status == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='12'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
 	
 	$j("#tblPendingAttnList").html(htmlTable);	
 	
 	
 }
 
 function showPhoto(profileImg1,inTimeImg,outTimeImg){
	 if(profileImg1 != '' && profileImg1.length > 100){
	 profileImage.setAttribute('src', "data:image/jpg;base64," +profileImg1);
	 }
	 if(inTimeImg != ''){
	 inTimeImage.setAttribute('src', "data:image/jpg;base64," +inTimeImg);
	 }
	 else
		{
		 inTimeImage.setAttribute('src', "/MMUWeb/resources/images/no-photo.jpg");
		}
	 if(outTimeImg != ''){
	 outTimeImage.setAttribute('src', "data:image/jpg;base64," +outTimeImg);
	 }
	 else
		{
		 outTimeImage.setAttribute('src', "/MMUWeb/resources/images/no-photo.jpg");
		}
	 
 }
 
 function showLocation(campLat,campLong,atnInLat,atnInLong,inDist,atnOutLat,atnOutLong,outDist){
	 document.getElementById('campLatitude').value=campLat;
	 document.getElementById('campLongitude').value=campLong;
	 document.getElementById('atnLatitude').value=atnInLat;
	 document.getElementById('atnLongitude').value=atnInLong;
	 document.getElementById('distance').value=inDist;
	 if(atnOutLat == 0){
		 document.getElementById('atnOutLatitude').value="";
	 }else {
	 	document.getElementById('atnOutLatitude').value=atnOutLat;
	 }
	 if(atnOutLong > 0){
		 document.getElementById('atnOutLongitude').value=atnOutLong;
	 } else {
		 document.getElementById('atnOutLongitude').value="";
	 }
	 if(outDist > 0){
	 	document.getElementById('outDistance').value=outDist;
	 } else {
		 document.getElementById('outDistance').value="";
	 }
 }
 
 function showTime(campStart,campEnd,atnIn, atnOut){
	 
	 document.getElementById('campStartTime').value=campStart;
	 document.getElementById('campEndTime').value=campEnd;
	 document.getElementById('attenInTime').value=atnIn;
	 document.getElementById('attenOutTime').value=atnOut;
 }
 

 function showResultPage(pageNo) 	
 {
 	
 	nPageNo = pageNo;	
 	getPendingAttendanceList('FILTER');
 	
 }
 
  function showAll()
  {
  	nPageNo = 1;	
  	getPendingAttendanceList('ALL');
  	
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
	 
  function IsPastDate(id,dateVal) {
	  if(dateVal != ''){
	    var currentdate = new Date();
	    var selectedDate = new Date(dateVal.substring(6), (dateVal
	  			.substring(3, 5) - 1), dateVal.substring(0, 2))
	    
	   if(selectedDate >  currentdate ){
		   alert("Date should be past date");
		   document.getElementById(id).value='';
		   return ; 
	   }
	      

	}
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
  	
 
  
</script>


</html>
