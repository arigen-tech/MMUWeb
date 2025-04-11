<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
     <%@include file="..//view/leftMenu.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Drug Expiry List</title>

<%@include file="..//view/commonJavaScript.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autoPopulate.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
</head>
 
<script type="text/javascript" language="javascript">
<%			
	String mmuId = "0";
	if (session.getAttribute("mmuId") !=null)
	{
		mmuId = session.getAttribute("mmuId")+"";
	}
	String userId = "0";
	if (session.getAttribute("userId") != null) {
		userId = session.getAttribute("userId") + "";
	}
   
	String levelOfUser = "1";
	if (session.getAttribute("levelOfUser") != null) {
		levelOfUser = session.getAttribute("levelOfUser") + "";
	}
	
	String departmentId = "2051";
	/* if (session.getAttribute("departmentId") != null) {
		departmentId  = session.getAttribute("departmentId") + "";
	} */
%>

var nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{
	     
	       getMMUList();
			//getDrugExpiryList('ALL');
			$('#table_div').hide();
			//getStoreItemList();
			
			
		});
		
function getMMUList(){
	var params = {
			"levelOfUser":'<%=levelOfUser%>',
			"userId": <%=userId%>
	}
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : '${pageContext.request.contextPath}/master/getMMUHierarchicalList',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(result) {
			   var mmuDrop = '';
			   var data=result.mmuListdata;
			   
			   if(data.mmuList.length =='1'){
				   $('#mmuId').attr('disabled', true);
				   for(i=0;i<data.mmuList.length;i++){
						mmuDrop += '<option value='+data.mmuList[i].mmu_id+' selected>'+data.mmuList[i].mmu_name+'</option>';
						
					}
					$j('#mmuId').append(mmuDrop);
				   <%-- document.getElementById('mmuId').value = <%=mmuId%>;  --%>
			   }
			   else{
				for(i=0;i<data.mmuList.length;i++){
					mmuDrop += '<option value='+data.mmuList[i].mmu_id+'>'+data.mmuList[i].mmu_name+'</option>';
					
				}
				$j('#mmuId').append(mmuDrop);
			  }
		},
		error : function(data) {
			alert("An error has occurred while contacting the server");
		}
	}); 
	}

 function getDrugExpiryList(MODE) { 	
 	
 	 var cmdId=0; 	
	 var from_date = $j('#from_date').val();
 	 var to_date = $j('#to_date').val();
 	 var pvms_no = $j('#pvms_no').val();
 	 var nomenclature = $j('#nomenclature').val();
 	 var mmuId = $j('#mmuId').val();
 	if (from_date === undefined) {
 		from_date = "";
 	}
 	
	if (to_date === undefined) {
		to_date = "";
 	} 
	
	if (pvms_no === undefined) {
		pvms_no = "";
 	} 
	
	if (nomenclature === undefined) {
		nomenclature = "";
 	}

 	 if(MODE == 'ALL')
 		{
 		var data = {"mmuId": mmuId, "departmentId": <%= departmentId %>, "from_date":"","to_date":"", "pvmsNo":"", "nomenclature":"", "pageNo":nPageNo}; 			
 		}
 	else
 		{
 		var data = {"mmuId": mmuId, "departmentId": <%= departmentId %>, "from_date":from_date,"to_date":to_date, "pvmsNo":pvms_no, "nomenclature":nomenclature, "pageNo":nPageNo};
 		} 
 	 
		
 	var bClickable = false;
 	var url = "getDrugExpiryList";
 	GetJsonData('tblListofDrugExpiry',data,url,bClickable);
 }
 
 
 function makeTable(jsonData)
 {	
	 $('#table_div').show();
 	var htmlTable = "";	
 	var data = jsonData.count;
 	var pageSize = 5;
 	var dataList = jsonData.drugExpiryList;
 		
 	for(i=0;i<dataList.length;i++)
 		{	 		
 				
 			htmlTable = htmlTable+"<tr>";			
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].pvms_no+"</td>";
 			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].nomenclature+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].au+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].batch_no+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].closing_stock+"</td>";
 			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].expiry_date+"</td>";
 			htmlTable = htmlTable+"</tr>";
 			
 		}
 	if(dataList.length == 0)
 		{
 		htmlTable = htmlTable+"<tr ><td colspan='6'><h6>No Record Found</h6></td></tr>";
 		   //alert('No Record Found');
 		}			
 	
 	//alert("tblListOfCommand ::" +htmlTable)
 	$j("#tblListofDrugExpiry").html(htmlTable);	
 	
 	
 }
 
 
/*  function executeClickEvent(Id)
 {
	 window.location="patientObesityDetailjsp?Id="+Id+"";
	 
 } */
 
 function showResultPage(pageNo) 	
 {
 	
 	nPageNo = pageNo;	
 	getDrugExpiryList('FILTER');
 	
 }
 
 function showAll()
 {
 	ResetForm();
 	nPageNo = 1;	
 	getDrugExpiryList('ALL');
 	
 }

 function search()
 {
	 	nPageNo=1;			
	 	var from_date = $j('#from_date').val();
	 	 var to_date = $j('#to_date').val();
	 	 
	 	 if(from_date!="" && to_date==""){
	 		 alert("Please select To Date");
	 		 return;
	 	 }
	 	if(from_date=="" && to_date!=""){
	 		 alert("Please select From Date");
	 		 return;
	 	 }
	 	 
	 	if(process(to_date) < process(from_date)){
	 		$('#table_div').hide();
	 		 alert("To date should not be earlier than From date");
	 		 return;
	 	 }
	 	 var pvms_no = $j('#pvms_no').val();
	 	 var nomenclature = $j('#nomenclature').val();
		if((from_date == undefined || from_date == '') && (to_date == undefined || to_date == '') ){	
			alert("Please select date");
			return;
		}
		getDrugExpiryList('Filter');
		//ResetForm();
 }
 
 function ResetForm()
 {	
	 $j('#from_date').val('');
 	 $j('#to_date').val('');
 	 $j('#pvms_no').val('');
 	 $j('#nomenclature').val('');
 }
 
 
 function printReport(){
	 var fromDate = $j('#from_date').val();
 	 var toDate = $j('#to_date').val();
 	 var pvmsNo = $j('#pvms_no').val();
 	 var nmclature= $j('#nomenclature').val();
 	 var mmuId = $j('#mmuId').val();
 	 var departmentId = <%= departmentId %>;
 	 
 	var User_id = <%=userId%>;
    var Level_of_user = '<%=levelOfUser%>';
    
     var url="${pageContext.request.contextPath}/report/printdrugExpiryReport?mId="+mmuId+"&dId="
    		 +departmentId+"&fromDate="+fromDate+"&toDate="+toDate+"&pvmsNo="
    		 +pvmsNo+"&nmclature="+nmclature
    		 +"&User_id="+User_id
    		 +"&Level_of_user="+Level_of_user;
 	 openPdfModel(url);
 }
 
<%-- 	var nomenclatureArry = new Array();
	var pvmsNumberArry = new Array();
	var itemDataList = '';
	function getStoreItemList() {
		
		var params = {
			"hospitalId" : <%= hospitalId %>
		}
		$j.ajax({
			type : "POST",
			contentType : "application/json",
			url : '${pageContext.request.contextPath}/store/getStoreItemList',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(res) {
				if (res.status == "1") {
					itemDataList = res.storeItemList;
					for (i = 0; i < itemDataList.length; i++) {
						itemId = itemDataList[i].itemId;

						nomenclatureList = itemDataList[i].nomenclature;
						/* nomenclatureName = nomenclatureList + "[" + itemId
								+ "]"; */
						
						nomenclatureArry.push(nomenclatureList);

						pvmsNumberList = itemDataList[i].pvmsNumber;
						pvmsNumberArry.push(pvmsNumberList);

					}
					autocomplete(document.getElementById("pvms_no"),
							pvmsNumberArry);
					autocomplete(document.getElementById("nomenclature"),
							nomenclatureArry);

				} else {

					// when status is 0, there is no related data masStoreItem
				}

			},
			error : function(msg) {
				alert("An error has occurred while contacting the server");
			}
		});

	}
	 --%>
</script>
 <body>
  <!-- Begin page -->
    <div id="wrapper">
 <form name="frm">
 <div class="content-page">
                                <!-- Start content -->
 <div class="">
  <div class="container-fluid">
	 
	  <div class="internal_Htext">Drug Expiry </div>
	 
                    <!-- end row -->

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">

                                     <div class="row">
                                     
                                     <div class="col-md-4">
															<div class="form-group row">
																<div class="col-md-5">
																	<label class="col-form-label">MMU</label>
																</div>
																<div class="col-md-7">
																	<select class="form-control" id="mmuId">
																	<option value="0">All</option>
																	</select>
																</div>
															</div>
										</div>
                                     
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">From Date</label>
													<div class="col-sm-7">
														<div class="dateHolder ">
															<input type="text" readonly class="calDate datePickerInput form-control" id="from_date" placeholder="DD/MM/YYYY"
															name="date"  onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10">
														</div>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">To Date</label>
													<div class="col-sm-7">
														<div class="dateHolder ">
															<input type="text" readonly class="calDate datePickerInput form-control" id="to_date" placeholder="DD/MM/YYYY"
															name="date"  onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10">
														</div>
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">Drug Code</label>
													<div class="col-sm-7">
														<div class=" autocomplete forTableResp">
														<input type="text" class="form-control" id="pvms_no" placeholder="" onKeyUp="getNomenClatureList(this,'','store','getItemListForAutoComplete','expiry_pvms')">
														<div id="divIdPVMS" class="autocomplete-itemsNew"></div>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
										<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">Drug Name</label>
													<div class="col-sm-7">
													<div class=" autocomplete forTableResp">
														<input type="text" class="form-control" id="nomenclature" placeholder="" onKeyUp="getNomenClatureList(this,'','store','getItemListForAutoComplete','expiry_nomen')">
														<div id="divId1" class="autocomplete-itemsNew"></div>
														</div>
													</div>
												</div>
											</div>
										<div class="col-md-1">
											<div class="form-group row">
												
												<div class="col-sm-10">
													<button type="button" class="btn btn-primary  obesityWait-search" onclick="search()">Search</button>
												</div>
											</div>
										</div>
										
										 
										<div class="col-md-7">
											<div class="form-group row">
												<div class="col-sm-12 text-right">
												
													 <!-- <div class="btn-right-all obesityWait-search">
														<button type="button" class="btn  btn-primary "
													onclick="showAll('ALL');">Show All</button>
														</div> -->
												</div>
											</div>
										</div>									                                   

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

								<div class="table-responsive">
								<table class="table table-hover table-striped table-bordered" id="tableId">
                                        <thead class="bg-primary" style="color:#fff;">
                                            <tr>
                                                <th id="th1">Drug Code</th>
                                                <th id="th2">Drug Name </th>
                                                <th id="th3">A/U</th>
                                                <th id="th4">Batch No.</th>
												<th id="th5">Closing Stock</th> 
												<th id="th6">Expiry Date</th>
                                            </tr>
                                        </thead>
                                         
                                        <tbody id="tblListofDrugExpiry">

                                        </tbody>
                                    </table>
									</div>
                                    <!-- end row -->
									
									<div class="row">
										<div class="col-sm-12 text-right">
										<button type="button" class="btn  btn-primary"
											id="printReportButton"  onclick="printReport();">Print</button>
											
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