<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
     <%@include file="..//view/leftMenu.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Daily Issue Summary Report</title>

<%@include file="..//view/commonJavaScript.jsp" %>
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

var nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{
			//getDailyIssueSummaryReport('ALL');
			$('#table_div').hide();
			GetHospitalList();
			$('#uid').hide();
			var currentDate = currentDateInddmmyyyy();
			$('#from_date').val(currentDate);
			$('#to_date').val(currentDate);
			
		});

 function getDailyIssueSummaryReport(MODE) { 	
 	
 	var cmdId=0; 	
	var from_date = $j('#from_date').val();
	var to_date = $j('#to_date').val();
	var serviceNo = $j('#service_no').val();
	var mobileNo = $j('#mobile_no').val();
	var patientName = $j('#patient_name').val();
	var hospital=$j('#unitId').val();
 	if (from_date === undefined) {
 		from_date = "";
 	}
 	
	if (to_date === undefined) {
		to_date = "";
 	} 
	
	if(serviceNo == undefined){
		serviceNo = "";
	}
	
	if(mobileNo == undefined){
		mobileNo = "";
	}
	
	if(patientName == undefined){
		patientName = "";
	}

 	 if(MODE == 'ALL')
 		{
 		var data = {"hospitalId": hospital, "departmentId": <%= departmentId %>, "fromDate":"","toDate":"", "serviceNo":"", "mobileNo":"", "patientName":"", "pageNo":nPageNo};
 			
 		}
 	else
 		{
 		var data = {"hospitalId": hospital, "departmentId": <%= departmentId %>, "fromDate":from_date,"toDate":to_date, "serviceNo":serviceNo, "mobileNo":mobileNo, "patientName":patientName, "pageNo":nPageNo};
 		} 
 	 
		
 	var bClickable = false;
 	var url = "getDailyIssueSummaryData";
 	GetJsonData('tblListofDailyIssueSummary',data,url,bClickable);
 }
 

 function makeTable(jsonData)
 {	
	$('#table_div').show();
 	var htmlTable = "";	
 	var data = jsonData.count;
 	var pageSize = 5;
 	var dataList = jsonData.dailyIssueList;
 	var s = 0;
 	for(i=0;i<dataList.length;i++)
 		{	 		
 			s++;	
 			htmlTable = htmlTable+"<tr>";	
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+s+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].issued_date+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].serviceNo+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].patientName+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].relation+"</td>";
 			htmlTable = htmlTable +"<td style='width: 350px;'>"+dataList[i].nomenclature+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].qty_issued+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].nis_flag+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].balance_stock+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].batchNo+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].expiryDate+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].prescribedBy+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].pharmascist+"</td>"; 			
 			htmlTable = htmlTable+"</tr>";
 			
 		}
 	if(dataList.length == 0)
 		{
 		htmlTable = htmlTable+"<tr ><td colspan='13'><h6>No Record Found</h6></td></tr>";
 		   //alert('No Record Found');
 		}			
 	
 	//alert("tblListOfCommand ::" +htmlTable)
 	$j("#tblListofDailyIssueSummary").html(htmlTable);	
 	
 	
 }
 
 
/*  function executeClickEvent(Id)
 {
	 window.location="patientObesityDetailjsp?Id="+Id+"";
	 
 } */
 
 function showResultPage(pageNo) 	
 {
 	
 	nPageNo = pageNo;	
 	getDailyIssueSummaryReport('FILTER');
 	
 }
 
 function showAll()
 {
 	ResetForm();
 	nPageNo = 1;	
 	getDailyIssueSummaryReport('ALL');
 	
 }

 function search()
 {
	 if($j('#unitId').val()!=''){
		 var nPageNo=1;			
		 	var from_date = $j('#from_date').val();
		 	 var to_date = $j('#to_date').val();
		 	 var serviceNo = $j('#service_no').val();
		 	 var mobileNo = $j('#mobile_no').val();
		 	 var patientName = $j('#patient_name').val();
			if((from_date == undefined || from_date == '') && (to_date == undefined || to_date == '')
					&& (serviceNo == undefined || serviceNo == '') && (mobileNo == undefined || mobileNo == '') && (patientName == undefined || patientName == '')){	
				alert("Atleast one option must be entered");
				return;
			}
			getDailyIssueSummaryReport('Filter');
	 }else{
		 alert("Please select Unit");
			return false; 
	 }
	 	
 }
 function resetDiv(){
	 $('#table_div').hide();
	 $j("#tblListofDailyIssueSummary").empty(); 
 }
 
 function ResetForm()
 {	
	 $j('#from_date').val('');
 	 $j('#to_date').val('');
 }
 
 
 function printReport(){
	 if($j('#unitId').val()!=''){
		 $j('#hId').val($j('#unitId').val());
		 $j('#dId').val(<%= departmentId %>);
		 <%-- var fromDate = $j('#from_date').val();
	 	 var toDate = $j('#to_date').val();
	 	 var serviceNo = $j('#service_no').val();
		 var mobileNo = $j('#mobile_no').val();
		 var patientName = $j('#patient_name').val();
	 	 var hospitalId = <%= hospitalId %>;
	 	 var departmentId = <%= departmentId %>;
	 	 document.frm.action="${pageContext.request.contextPath}/report/printDailyIssueSummaryReport?hId="+hospitalId+"&dId="+departmentId+"&fromDate="+fromDate+"&toDate="+toDate+"&serviceNo="+serviceNo+"&mobileNo="+mobileNo+"&patientName="+patientName+""; 
	 	 document.frm.action="${pageContext.request.contextPath}/report/printDailyIssueSummaryReport";
	 	 document.frm.method="POST";
		 document.frm.submit(); --%>
	 }else{
		 alert("Please select Unit");
		 return false;
	 }
	
 }

 var unitName="";
 function GetHospitalList(){
	 	jQuery.ajax({
	 	 	crossOrigin: true,
	 	    method: "POST",			    
	 	    crossDomain:true,
	 	    url: "${pageContext.request.contextPath}/master/getAllHospital",
	 	    data: JSON.stringify({"PN":"0","hospitalId":<%=hospitalId%>}),
	 	    contentType: "application/json; charset=utf-8",
	 	    dataType: "json",
	 	    success: function(result){
	 	    	var combo = "" ;
	 	    	for(var i=0;i<result.data.length;i++){
	 	    		combo += '<option  value='+result.data[i].unitId+'>' +result.data[i].unitName+ '</option>';
	 	    		unitName=result.data[i].unitName;
	 	    		
	 	    	}
		
	 	    	jQuery('#unitId').append(combo);
		    	
		    	if($('#unitId').find("option").length > 2){
		    		
		    		$('#unitId').show(); 
		    		$('#uid').hide();
	    	    	
	    	    }

		    	else{
		    		$('#unitId').hide(); 
		    		$('#uid').show();
		    		$('#uid').val(unitName).attr('readonly','readonly');
		    		document.getElementById('unitId').value = <%=hospitalId%>; 
	    	    	};
	 	    	
	 	    }
	 	
	 	});

	  }
 
 function makeUrl(){

	 if($j('#unitId').val()!=''){
		 
		 $j('#hId').val($j('#unitId').val());
		 $j('#dId').val(<%= departmentId %>);
		 var unitId = $j('#unitId').val();
		 //var hospitalId = $j('#hId').val();
		 var departmentId = $j('#dId').val();
		 var fromDate = $j('#from_date').val();
	 	 var toDate = $j('#to_date').val();
	 	 var serviceNo = $j('#service_no').val();
		 var mobileNo = $j('#mobile_no').val();
		 var patientName = $j('#patient_name').val();
		
		 var url = "${pageContext.request.contextPath}/report/printDailyIssueSummaryReport?dId="+departmentId+"&fromDate="+fromDate+"&toDate="+toDate+"&serviceNo="+serviceNo+"&mobileNo="+mobileNo+"&patientName="+patientName+"&unitId="+unitId+"";
		 openPdfModel(url);
		 
	 }else{
		 alert("Please select Unit");
		 return false;
	 }

	}
</script>
 <body>
  <!-- Begin page -->
    <div id="wrapper">
 <form name="frm">
 <div class="content-page">
                                <!-- Start content -->
 <div class="">
  <div class="container-fluid">
	 
	  <div class="internal_Htext">Daily Issue Summary Report</div>
	 
                    <!-- end row -->

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                	  <div class="row">
                                	  <div class="col-md-4">
                                                     <div class="form-group row" id="unitDiv">
                                                         <label class="col-md-5 col-form-label">Unit:<span class="mandate"><sup>&#9733;</sup></span></label>
                                                         <div class="col-md-7">
                                                             <select class="form-control" id="unitId" name="unitId" onchange="resetDiv();">
                                                             </select>
                                                            <input type="text" class="auto  form-control" size="8"  name="uid" id ="uid"/>
                                                         </div>
                                                     </div>
                                                 </div>
                                	  	<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">Service No.</label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="service_no" name="serviceNo" placeholder="">
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">Patient Name</label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="patient_name" name="patientName" placeholder="">
													</div>
												</div>
											</div>
											
                                	  </div>
                                     <div class="row">
                                     <div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">Mobile No.</label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="mobile_no" name="mobileNo" placeholder="">
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">From Date</label>
													<div class="col-sm-7">
														<div class="dateHolder ">
															<input type="text"  class="calDate datePickerInput form-control" id="from_date" placeholder="DD/MM/YYYY"
															name="fromDate"  onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10">
														</div>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">To Date</label>
													<div class="col-sm-7">
														<div class="dateHolder ">
															<input type="text"  class="calDate datePickerInput form-control" id="to_date" placeholder="DD/MM/YYYY"
															name="toDate"  onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10">
														</div>
													</div>
												</div>
											</div>
											<input type="hidden" class="form-control" id="hId" name="hId">
											<input type="hidden" class="form-control" id="dId" name="dId">
											<div class="col-md-12">
											<div class="form-group text-right">
													<button type="button" class="btn btn-primary  obesityWait-search" onclick="search()">Search</button>
											</div>
										</div>
											
										</div>
									<div class="row">					                                   

                                    </div>

							<div id="table_div">
								<div style="float: left">

									<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatus" style="font-size: 15px;"
												align="left">Search Results</td>
											<td>
												<!-- <div id=resultnavigation></div> -->
											</td>
										</tr>
									</table>
								</div>
								<div style="float: right">
									<div id="resultnavigation"></div>
								</div>

								
								<table class="table table-hover table-striped table-bordered">
                                        <thead class="bg-primary" style="color:#fff;">
                                            <tr>
                                                <th id="th1">S.NO.</th>
                                                <th id="th2">Issue Date </th>
                                                <th id="th3">Service No</th>
                                                <th id="th4">Patient Name</th>
												<th id="th5">Relation</th> 
												<th id="th6">Nomenclature</th>
												<th id="th7">Qty Issued</th>
												<th id="th8">NIS</th>
												<th id="th9">Balance Stock</th>
												<th id="th10">Batch</th>
												<th id="th11">DOE</th>
												<th id="th12">Prescribed By</th>
												<th id="th13">Pharmacist</th>	
                                            </tr>
                                        </thead>
                                         
                                        <tbody id="tblListofDailyIssueSummary">

                                        </tbody>
                                    </table>
							
                                    <!-- end row -->
									
									<div class="ow">
										<div class="col-sm-12 text-right">
										<!-- <input type="button" class="btn btn-primary opd_submit_btn" value="Print" onclick="printReport();"> -->
										<button type="button" id="printReportButton" class="btn btn-primary" onclick="makeUrl()">Print</button>	
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
                    <!-- end row -->

                </div>
                <!-- container -->
                 </div>
                  </div>
	</form>
</div>

</body>
</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>