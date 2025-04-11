
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<title>Radiology Result History</title> 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>

</head>
<script type="text/javascript" language="javascript">
	
	<%			
	String hospitalId = "1";
	if (session.getAttribute("hospital_id") !=null)
	{
		hospitalId = session.getAttribute("hospital_id")+"";
	}
	String user_id = "0";
	if (session.getAttribute("user_id") != null) {
		user_id = session.getAttribute("user_id") + "";
	}

	String departmentId = "1402";
	if (session.getAttribute("department_id") != null) {
		departmentId = session.getAttribute("department_id") + "";
	}
	%>
		var nPageNo = 1;
	var $j = jQuery.noConflict();
	var dgOrderHdIdGloabal = '0';
	$j(document).ready(function() {
		//getResultValidationWaitingList('ALL');
		//getResultPrintingList('ALL');
		$j('#table_id').hide();
	});
	
	$j(document).on('hidden.bs.modal','#exampleModal', function (event) {
	    var loaderHtml ='<div class="text-center text-theme text-sm">Loading <i class="fa fa-spin fa-spinner"></i> </div>';
		$j('#exampleModal .modal-body').html(loaderHtml);
	});
	
	function getResultPrintingList(MODE) {
		//alert("inside getReferredList");
		var cmdId = 0;
		var service_no = $j('#service_no').val();
		var patientName = $j('#patient_name').val();
		var mobileNo = $j('#mobile_no').val();
		var fromDate = $j('#from_date').val();
		var toDate = $j('#to_date').val();
		var investigationName = $j('#investigationName').val();
		if (service_no === undefined) {
			service_no = "";
		}
		if (patientName === undefined) {
			patientName = "";
		}
		if (mobileNo === undefined) {
			mobileNo = "";
		}
		if (fromDate === undefined) {
			fromDate = "";
		}
		if (toDate === undefined) {
			toDate = "";
		}
		

		if (MODE == 'ALL') {
			var data = {"hospitalId" :<%=hospitalId%>,"serviceNo" : "","patientName":"","mobileNo":"","from_date":"","to_date":"","pageNo" : nPageNo}

		} else {
			var data = {"hospitalId" :<%=hospitalId%>,"serviceNo" : service_no,"patientName":patientName,"mobileNo": mobileNo,"from_date":fromDate,"to_date":toDate,"pageNo" : nPageNo, "investigationName":investigationName}

		};

		var bClickable = false;
		var url = "getResultPrintingData";
		GetJsonData('tblListofRadiology', data, url, bClickable);
	}

	function search() {
		
		var service_no = $j('#service_no').val();
		var patientName = $j('#patient_name').val();
		var mobileNo = $j('#mobile_no').val();
		var fromDate = $j('#from_date').val();
		var toDate = $j('#to_date').val();
		var investigationName = $('#investigationName').val();
		
		if ((service_no == undefined || service_no == '') &&
				(patientName == undefined || patientName == '') &&
				(mobileNo == undefined || mobileNo == '') &&
				(fromDate == undefined || fromDate == '') && 
				(toDate == undefined || toDate == '')) {
					alert("Atleast one of the search option must be entered");
			return;
		}
		getResultPrintingList('Filter');
	}

	function makeTable(jsonData) {
		var htmlTable = "";
		var data = jsonData.count;

		var pageSize = 5;
		var dataList = jsonData.validationList;
		console.log("dataList "+dataList);
		for (i = 0; i < dataList.length; i++) {
			dgOrderHdIdGloabal = dataList[i].dgOrderHdId;
			htmlTable = htmlTable + "<tr id='"+dataList[i].resultDtId+"'>";
			htmlTable = htmlTable + "<td style='width: 90px;'>"
					+ dataList[i].date + "</td>";
			htmlTable = htmlTable + "<td style='width: 80px;'>"
					+ dataList[i].serviceNo + "</td>";
			htmlTable = htmlTable + "<td style='width: 140px;'>"
					+ dataList[i].patientName + "</td>";
			htmlTable = htmlTable + "<td style='width: 80px;'>"
					//+ dataList[i].age+"/"+ (dataList[i].gender).trim().substring(0,1)+ "</td>";
			+ dataList[i].age+"/"+ (dataList[i].gender).trim()+ "</td>";
					/* htmlTable = htmlTable + "<td style='width: 100px;'>"
					+ dataList[i].gender + "</td>"; */
			htmlTable = htmlTable + "<td style='width: 100px;'>"
					+ dataList[i].relation + "</td>";
			htmlTable = htmlTable + "<td style='width: 200px;'>"
					+ dataList[i].investigation + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>"
					+ dataList[i].modality + "</td>";			
			htmlTable = htmlTable + "<td style='width: 100px;'>"
			+ dataList[i].enteredByRank +' '+ dataList[i].enteredBy + "</td>";
			if(dataList[i].status == 'C'){
				htmlTable = htmlTable + "<td style='width: 100px;'>"
				+ dataList[i].validatedByRank +' '+ dataList[i].validatedBy + "</td>";
			}else{
				htmlTable = htmlTable + "<td style='width: 100px;'></td>";
			}
			htmlTable = htmlTable + "<td><button class='btn btn-primary' type='button' name='btnReport' id='btnReport' data-toggle='modal' data-target='#exampleModal3' onClick='printReport(this)'>Report</button></td>";
			htmlTable = htmlTable + "<td><input type='button' class='btn btn-primary opd_submit_btn' value='View' data-toggle='modal' data-target='#exampleModal' data-backdrop='static' onclick='viewReport(this)'></td>";
			htmlTable = htmlTable + "<td style='display:none;'><input type='text' value="+dgOrderHdIdGloabal+" </td>";
			htmlTable = htmlTable + "</tr>";
			//style="display: none"
		}

		if (dataList.length == 0) {
			htmlTable = htmlTable
					+ "<tr ><td colspan='10'><h6>No Record Found !!</h6></td></tr>";
		}

		$j("#tblListofRadiology").html(htmlTable);
		$j('#table_id').show();

	}

	function executeClickEvent(Id) {	
		
		window.location="getResultValidation?id="+Id+"";		
		
	}	

	function ResetForm() {
		$j('#service_no').val('');
	}

	function showResultPage(pageNo) {

		nPageNo = pageNo;
		getResultPrintingList('FILTER');

	}
	
	 function showAll()
	 {
	 	ResetForm();
	 	nPageNo = 1;	
	 	getResultPrintingList('ALL');	 	
	 }
	 
	 function ResetForm()
	 {	
		 $j('#service_no').val('');
	 }
	 
	 function printReport(item){
		var dgOrderHdId = $j(item).closest('tr').find("td:eq(11)").find(":input").val();
		 var url = "${pageContext.request.contextPath}/report/generateImagingHistoryReport?oderHdId="+dgOrderHdId+"";
		 openPdfModel(url);
	 }
	 
	 function viewReport(item){

          var dtId = $j(item).closest('tr').attr('id');
		    $j('#flag').val('resultEntry');
		    $j('#dtId').val(dtId); 
		    
		   <%-- window.open("${pageContext.request.contextPath}/radiology/radiologyResultHistory?dtId="+dtId+"&flag=resultEntry&userId="+<%= user_id %>+""); --%>
	 		
		    
		    $('#exampleModal .modal-body').load("radiologyResultHistory?dtId="+dtId+"&flag=resultEntry&userId="+<%= user_id %>);
            $('#exampleModal .modal-title').text('Radiology Report');
	 
	 
	 }
	 
</script>
<body>
 <!-- Begin page -->
    <div id="wrapper">

	<div class="content-page">
		<!-- Start content -->
		<div class="">
			<div class="container-fluid">
				<div class="internal_Htext">Radiology Result History</div>
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">

								<form>
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Service No.</label>
												<div class="col-sm-7">
													<input class="form-control  form-control-sm"
														id="service_no">
												</div>
											</div>
										</div>		
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Patient Name</label>
												<div class="col-sm-7">
													<input class="form-control  form-control-sm"
														id="patient_name">
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Mobile No.</label>
												<div class="col-sm-7">
													<input class="form-control  form-control-sm"
														id="mobile_no"> 
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">From Date</label>
												<div class="col-sm-7">
													<div class="dateHolder">
													<input type="text" class="form-control calDate" id="from_date" placeholder="DD/MM/YYYY" >
													</div>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">To Date</label>
												<div class="col-sm-7">
													<div class="dateHolder">
													<input type="text" class="form-control calDate" id="to_date" placeholder="DD/MM/YYYY" >
													</div>
												</div>
											</div>
										</div>
										
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Investigation Name</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="investigationName"
														name="investigationName" placeholder="Enterable" maxLength="50" autocomplete="off" />
												</div>
											</div>
										</div>	
										
										<div class="col-md-12">
															<div class="btn-left-all"> 
															</div> 
															<div class="btn-right-all">
																<button type="button" class="btn btn-primary"
														                    onclick="search()">Search</button>	</div> 
													        </div>
										
																	 
										
										<!-- <div class="col-md-3 text-right">
											
														<button type="button" class="btn  btn-primary "
													onclick="showAll('ALL');">Show All</button>
												
										</div>	 -->
									</div>									
									<div id="table_id">
										<div style="float: left">
											<table class="tblSearchActions" cellspacing="0"
												cellpadding="0" border="0">
												<tr>
													<td class="SearchStatus" style="font-size: 15px;"
														align="left">Search Results</td>
												</tr>
											</table>
										</div>
										<div style="float: right">
											<div id="resultnavigation"></div>
										</div>
										
										<table class="table table-bordered  table-striped table-hover">
											<thead bgcolor="00FFFF">
												<tr>
													<th id="th1">Date</th>
													<th id="th2">Service No.</th>
													<th id="th3">Name</th>
													<th id="th4">Age/Gender</th>
													<th id="th6">Relation</th>
													<th id="th7">Investigation</th>
													<th id="th8">Modality</th>
													<th id="th9">Result Entered By</th>
													<th id="th9">Result Validated By</th>
													<th id="th10">Download</th>
													<th id="th10">Action</th>
												</tr>
											</thead>
											<tbody id="tblListofRadiology">
											</tbody>
										</table>									
									</div>
								</form>
								
								<form name="frm1">
									<input type="hidden" id = "flag" name="flag" value="">
									<input type="hidden" id = "dtId" name="dtId" value="">
									<input type="hidden" id = "userId" name="userId" value="<%= user_id %>">
								</form>
								</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>

 <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title font-weight-bold"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="text-center text-theme text-sm">
         Loading <i class="fa fa-spin fa-spinner"></i>
        </div>
      </div>        
    </div>
  </div>
</div>

<div class="modal-backdrop show" style="display:none;"></div>
</div>


</body>
</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>