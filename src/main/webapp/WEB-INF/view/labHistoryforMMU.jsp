<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
 
  <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>  
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MMSY</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
    <%@include file="..//view/commonJavaScript.jsp" %>
    
     <%
	String hospitalId = "1";
	/* if (session.getAttribute("hospital_id") != null) {
		hospitalId = session.getAttribute("hospital_id") + "";
	} */
	String userId = "1";
	/* if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	} */
	
	String departmentId = "";
	if (session.getAttribute("department_id") != null) {
		departmentId = session.getAttribute("department_id") + "";
	}
	
	String mmuId = "0";
	if (session.getAttribute("mmuId") != null) {
		mmuId = session.getAttribute("mmuId") + "";
	}

	
%>
    
    <%
  String orderId = request.getParameter("oderHdId");
  %>
  
<script type="text/javascript">

$(document).ready(function() {
	
	GetLabHistory('ALL');
	//GetHospitalList(); 
	//$("#uid").hide();
});

<%-- var unitName = "";
function GetHospitalList(){

	$.ajax({
		crossOrigin : true,
		method : "POST",
		crossDomain : true,
		url : "${pageContext.request.contextPath}/master/getAllHospital",
		data : JSON.stringify({
			"PN" : "0",
			"hospitalId" :<%=hospitalId%>}),
    	    contentType: "application/json; charset=utf-8",
    	    dataType: "json",
    	    success: function(result){
    	    	var combo = "";
    	    	for(var i=0;i<result.data.length;i++){
    	    		combo += '<option  value='+result.data[i].unitId+'>' +result.data[i].unitName+ '</option>';
    	    		unitName=result.data[i].unitName;
    	    	}
    	    	$('#unitId').append(combo);
    	    	if($('#unitId').find("option").length > 2){
    	    		$('#unitId').show(); 
    	    		$('#uid').hide();
        	    }

    	    	else{
    	    		$('#unitId').hide(); 
    	    		$('#uid').show();
    	    		$('#uid').val(unitName).attr('readonly','readonly');
    	    		//document.getElementById('unitId').value = <%=hospitalId%>; 
        	    	}
    	    }
    	});
} --%>







var ChargeCode='';
var multipleChargeCode = new Array();
var investigationForUom = "";
function populateChargeCode(val,count,item) {
	
	//alert(count);
//	if(validateMetaCharacters(val)){
		if(val != "")
		{
			multipleChargeCode=val.split("[");			
		    var index1 = val.lastIndexOf("[");
		    var indexForChargeCode=index1;		 
		    var index2 = val.lastIndexOf("]");
		    index1++;
		    ChargeCode = val.substring(index1,index2);		    
		    var indexForChargeCode=indexForChargeCode--;
		  
       
		if(ChargeCode == "")
		{
		
		return;
		}
		else{
			        			
			//document.getElementById('chargeCodeCode').value=ChargeCode
			var checkCurrentRowIddd=$(item).closest('tr').find("td:eq(4)").find("input:eq(0)").attr("id");
			var checkCurrentRow=$(item).closest('tr').find("td:eq(4)").find("input:eq(0)").val();
		         var count=0;   			
		        $('#subinvestigationId tr').each(function(i, el) {
			    var $tds = $(this).find('td')
			        var chargeCodeId=  $($tds).closest('tr').find("td:eq(4)").find("input:eq(0)").attr("id");
			        var chargeCodeIdValue=$('#'+chargeCodeId).val();
			        var idddd =$(item).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
			        var currentidddd=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
			    	  if(chargeCodeId!=checkCurrentRowIddd && ChargeCode==chargeCodeIdValue)
			          {
			    		  	if(ChargeCode==chargeCodeIdValue){
			       			alert("Investigation is already added");
			        		$('#'+idddd).val("");
			        		$('#'+currentidddd).val("");
			        		$('#'+chargeCodeIdValue).val("");
			        		return false;
			           }
			          			        
			            }
			            else
			        	{
			               $(item).closest('tr').find("td:eq(1)").find(":input").val("");
			        	   $(item).closest('tr').find("td:eq(2)").find(":input").val(multipleChargeCode[0]);
			        	   $(item).closest('tr').find("td:eq(10)").find(":input").val(ChargeCode);
			        	}
			       
			    }); 
		      }
		}
	  }
	  
</script>

</head>

<body>
 <!-- Begin page -->
    <div id="wrapper">
		<div class="content-page">
			<div class="">
				<div class="container-fluid">
				<div class="internal_Htext">Lab History-MMU Wise</div>
				
				
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
						        <form id="labHistoryForm" name="labHistoryForm" action="" method="GET">
									<!------------------ Adding search part in between ---------->
									<input type="hidden" name="hospitalId" id="hospitalId" value="<%=hospitalId %>" />
									<input type="hidden" name="userId" id="userId" value="<%=userId %>" />
									<input type="hidden" name="orderHdId" id="orderHdId" value="" />
									
									<input  name="labImaginId" id="labImaginId" type="hidden" value="Lab" />
									
									<input type="hidden" name="status" id="status" value=""/>
									<input type="hidden" name="validate" id="validate" value=""/>
									
				<div class="col-md-6"></div>

					<div class="" id="patientDetailsOthersDiv">
							<!-- <h4 class="service_htext">PATIENT SEARCH</h4> -->
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">
													Mobile No
												</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="mobileNo"
														name="mobileNo" placeholder="Enterable" maxLength="10" autocomplete="off" 
														/>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">
												<spring:message code="lbl_patient_name"/>
												</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="patientName"
														name="patientName" placeholder="Enterable" maxLength="50" autocomplete="off" 
														/>
												</div>
											</div>
										</div>
										
										<!-- <div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Investigation Name</label>
												<div class="autocomplete forTableResp col-sm-7 ">
													<input type="text" class="form-control" id="investigationName"
														name="investigationName" autocomplete="off" 
														onKeyUp="getNomenClatureList(this, 'populateChargeCode','medicalexam','getInvestigationListUOM','investigationMe');" />
												<div id="investigationDivMeDg" class="autocomplete-itemsNew"></div>	
												</div>
											</div>
										</div> -->
																		
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">
												<spring:message code="lbl_from_date"/>
												</label>
												<div class="col-sm-7">
													<div class="dateHolder">
														<input type="text" class="form-control calDate" id="fromDate"
														name="fromDate" placeholder="DD/MM/YYYY"  maxLength="50" autocomplete="off"/>
													</div>
												</div>
											</div>
										</div>
									<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">
												<spring:message code="lbl_to_date"/>
												</label>
												<div class="col-sm-7">
												<div class="dateHolder">
													<input type="text" class="form-control calDate" id="toDate"
														name="toDate" placeholder="DD/MM/YYYY"  maxLength="50" autocomplete="off"/>
												</div>
												</div>
											</div>
											
									</div>
									
									<div class="col-md-4">
                                                     <div class="form-group row" id="unitDiv"  style="display:none">
                                                         <label class="col-md-5 col-form-label">Unit:<span class="mandate"><sup>&#9733;</sup></span></label>
                                                         <div class="col-md-7">
                                                             <select class="form-control" id="unitId" name="unitId">
                                                             </select>
                                                            <input type="text" class="auto  form-control" size="8"  name="uid" id ="uid"/>
                                                         </div>
                                                     </div>
                                                 </div>
										
											

										<div class="col-md-1 text-right">
											<div id="loadingDiv" style="display: none;">
												<img src="/AshaWeb/resources/images/ajax-loader.gif">
											</div>
										</div>
									   
										 <div class="col-md-12">
											<div class="form-group row">
												<div class="col-sm-12 ">												
													 <div class="btn-right-all obesityWait-search">
													 	<button type="button" class="btn btn-primary"
														onclick="searchLabHistory()">Search</button>
														<button type="button" class="btn  btn-primary "
													onclick="showAll('ALL');">Show All</button>
														</div>
												</div>
											</div>
										</div>	 									
									   </div>
									   
									   <div class="m-t-10">
									   <div style="float: left" >
											<table class="tblSearchActions" cellspacing="0"
												cellpadding="0" border="0">
												<tr>
													<td class="SearchStatus" style="font-size: 15px; "
														align="left" id="SearchStatusID"  >Search Results</td>
												</tr>
											</table>
										</div>
										<div style="float: right">
											<div id="resultnavigation"></div>
										</div>
										</div>
										
										<div class="col-md-12"><p align="Left" id="message"	style="color: green; font-weight: bold;"></p></div>
									</div>
									<div id="tblLabHistoryDetails"
												class="right_col" role="main" > <!-- style="display:none;" -->
												<div class="clearfix"></div>
												<div class="table-responsive">
												<table class="table table-striped table-hover  table-bordered  ">
													<thead>
														<tr>
															<!-- <th id="th1">Service No</th> -->
															<th id="th2">Investigation Date</th>
															<th id="th3">Patient Name</th>
															<th id="th4">Mobile No</th>
															<!-- <th id="th5">Age</th> -->															
															<th id="th6">Gender / Age</th>
															<th id="th7">MMU Name</th>
															<th id="th8">Investigation Name</th>
															<!-- <th id="th9">Sub Investigation Name</th> -->
															<th id="th9">Unit</th>
															<th id="th10">Result</th>
															<th id="th11">Range</th>
															<th id="th11">Entered By</th>																													
															<th id="th13">Validated By</th>
															<th id="th12">Action</th>
															
														</tr>
													</thead>
													<tbody id="tblListOfLabHistory">
													</tbody>
												</table>
												</div>
											</div>
									</form> 		
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	
	<div class="modal hide z-index5000" id="messageForAuthenticate" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<span class="Message_htext"><spring:message code="lblIndianCoastGuard" /></span>

				<button type="button" onClick="closeMessage();" class="close"
					data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>

			</div>
			<div class="modal-body">
				<div class="control-group">
					
						<div class='divErrorMsg form-group row' id='errordiv' ></div>
				<div class="form-group row" id="messageForAuthenticateMessae" class="text-danger" ></div>
				<div class="form-group row" id="messageForAuthenticateServiceNo" class="text-danger" ></div>
				
					<div class="col-md-12">
							<div class="form-group row">
								<label class="col-md-5 col-form-label"><spring:message code="lblUHIDNumber"/> 
								</label>
								<div class="col-md-7">
									<input name="uhidNumber" id="uhidNumber" type="text"
										class="form-control border-input"
										placeholder=""/>
								</div>
							</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary" data-dismiss="modal"
					onClick="callToAutheniticate();" aria-hidden="true"><spring:message code="btnOK"/></button> <!-- closeMessage(); -->
				<button class="btn btn-primary" data-dismiss="modal"
					onClick="closeMessage();" aria-hidden="true"><spring:message code="btnClsoe"/></button>
			</div>
		</div>
	</div>
</div>

<div class="modal-backdrop show" style="display:none;"></div>

<script type="text/javascript">

	var comboArray = [];
	var uhidNo;
	

	
	function GetLabHistory(MODE){
		
	
		var mobileNo = $j('#mobileNo').val()
		var patientName = $j('#patientName').val()
		var fromDate = $j('#fromDate').val();
		var toDate = $j('#toDate').val();
		var investigationName = $('#investigationName').val();
		var mmuId= "<%out.print(mmuId);%>";
	
		 var countDate=getDateComapareValue(fromDate,toDate);
  	 	 if(countDate!=0){
  	 		 alert("To Date should not be earlier than from Date.");
  	 		 return false;
  	 	 }
	/* if((mobileNo == undefined || mobileNo == '')){	
		alert("Please Enter the Mobile No");
		
		return false;
	}
		
		if (serviceNo === undefined) {
			serviceNo = "";
		}
		if(patientId === undefined){
			patientId = 0;
		} */
		
		
		
		if (MODE == 'ALL') {
			var data = {"pageNo" : nPageNo, "hospitalId":<%=hospitalId %>,"mmuId":<%=mmuId %> }

		} else {
			var data = {"mobileNo" : mobileNo, "patientName":patientName, "fromDate":fromDate, "toDate":toDate, "pageNo" : nPageNo, "investigationName":investigationName, "hospitalId":<%=hospitalId %>, "mmuId":<%=mmuId %>}

		};
		
		
		var url = "getLabHistoryDetails";		
		var bClickable = false;
		GetJsonData('tblListOfLabHistory',data,url,bClickable);	 
	}
	
	var orderheaderId = '';
	function makeTable(jsonData)
	{	
		var htmlTable = "";	
		var data = jsonData.count; 
		var statuss = jsonData.status;
		if(jsonData.data != undefined){
		var dataList = jsonData.data;
		
		//alert(dataList)
		
		
	
			for(i=0;i<dataList.length;i++)
			{		
			 var orderhdId = dataList[i].orderHdId;
			 $('#orderHdId').val(orderhdId);
			 orderheaderId = $('#orderHdId').val();
			
				htmlTable = htmlTable+"<tr id='"+dataList[i].orderHdId+"' >";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].investigationDate+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].patientName+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].mobileNo+"</td>";
				htmlTable = htmlTable +"<td style='width: 180px;'>"+dataList[i].genderName+" / "+dataList[i].age+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].hospitalName+"</td>";
				if(dataList[i].subInvestigationName!=null && dataList[i].subInvestigationName!= undefined && dataList[i].subInvestigationName!=''){
					htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].investigationName+" ("+dataList[i].subInvestigationName+")</td>";
				}else{
					htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].investigationName+"</td>";
				}
				
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].unit+"</td>";
				
				if(dataList[i].rangeStatus!=undefined && dataList[i].rangeStatus=='OR'){
					htmlTable = htmlTable +"<td style='width: 150px; color: red ; font-weight: bold'>"+dataList[i].investigationResult+"</td>";
					
				}else if(dataList[i].rangeStatus!=undefined && dataList[i].rangeStatus=='IR'){
					htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].investigationResult+"</td>";
				}else{
					htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].investigationResult+"</td>";
				}
				
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].range+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].createdBy+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].resultVerifiedBy+"</td>";
				htmlTable = htmlTable +"<td style='width: 150px; display:none''><input  class='form-control border-input' type='hidden' name='resultDetailStatus' id=''  value='"+dataList[i].resultDetailStatus+"'/></td>";
				htmlTable = htmlTable +"<td style='width: 150px; display:none''><input  class='form-control border-input' type='hidden' name='validated' id=''  value='"+dataList[i].validated+"'/></td>";
				htmlTable = htmlTable +"<td style='width: 150px; display:none''><input  class='form-control border-input' type='hidden' name='resultType' id=''  value='"+dataList[i].resultType+"'/></td>";
				htmlTable = htmlTable +"<td style='width: 150px; display:none''><input  class='form-control border-input' type='hidden' name='resultStatus' id=''  value='"+dataList[i].resultStatus+"'/></td>";

				var status = '"'+dataList[i].resultDetailStatus.trim()+'"';
				var validate = '"'+dataList[i].validated.trim()+'"';
				
				if(dataList[i].ridcId!=null && dataList[i].ridcId != ''){
					//htmlTable = htmlTable +"<td style='width: 390px;'><input type='button' class='btn btn-primary mar_bottom' value='Report' onclick='generateReport("+dataList[i].orderHdId+", "+status+", "+validate+")'/> <input type='button' class='btn btn-primary mar_bottom' value='Document' onclick='viewDocumentForCommon("+dataList[i].ridcId+")'/> </td>";
					htmlTable = htmlTable +"<td style='width: 390px;'><button id='printReportButton1' type='button' class='btn btn-primary noMinWidth' data-toggle='modal' data-backdrop='static' data-target='#exampleModal3' value='Report' onclick='makeUrl("+orderheaderId+", "+status+", "+validate+")'>Report</button> <button id='printReportButton3' type='button' class='btn btn-primary noMinWidth' data-toggle='modal' data-backdrop='static' data-target='#exampleModal3' value='Document' onclick='makeUrlViewDocument("+dataList[i].ridcId+")'>Document</button> </td>";
				}else{
					//htmlTable = htmlTable +"<td style='width: 390px;'><input type='button' class='btn btn-primary mar_bottom' value='Report' onclick='generateReport("+dataList[i].orderHdId+", "+status+", "+validate+")'/></td>";
					htmlTable = htmlTable +"<td style='width: 390px;'><button id='printReportButton2' type='button' class='btn btn-primary noMinWidth' data-toggle='modal' data-backdrop='static' data-target='#exampleModal3' value='Report' onclick='makeUrl("+orderheaderId+", "+status+", "+validate+")'>Report</button></td>";
				}
				htmlTable = htmlTable+"</tr>";
				
			
		}
		
		
		}
		if(jsonData.data == undefined)
			{
			
			htmlTable = htmlTable+"<tr ><td colspan='12'><h6>No Record Found</h6></td></tr>";
			   
			}
		if(jsonData.data == undefined && data == 0)
		{
			
			htmlTable = htmlTable+"<tr ><td colspan='12'><h6>No Record Found</h6></td></tr>";
		   
		}	
		
		$j("#tblListOfLabHistory").html(htmlTable); 	
		
	}
	
	function showAll()
	{
		nPageNo = 1;	
		GetLabHistory('ALL');
		ResetForm();
		
	}
	function showResultPage(pageNo)
	{
		
		nPageNo = pageNo;	
		GetLabHistory('FILTER');
		
	}
	
	function ResetForm()
	{
		
	
		$j('form').find('input[type=text]').val('');
	}
	
	function generateReport(orderHdIds, status, validate){
	  	document.labHistoryForm.action="${pageContext.request.contextPath}/report/generateLabHistoryReport?oderHdId="+orderHdIds+"@@"+status+"@@"+validate+"";
	  	document.labHistoryForm.method="POST";
	  	document.labHistoryForm.submit(); 
	  	
	  }

	

function makeUrl(orderHdIds, status, validate){
		//var oderHdId = orderHdIds+"@@"+status+"@@"+validate;
		
		var oderHdId = orderHdIds;
		var url="${pageContext.request.contextPath}/report/generateLabHistoryReport?oderHdId="+oderHdId;
		openPdfModel(url);
		
	}

	function makeUrlViewDocument(ridcId)
	  {
	 	
	 	        var pathname = window.location.pathname;
	         	var accessGroup = "MMUWeb";

	         	var url = window.location.protocol + "//"
	         			+ window.location.host + "/" + accessGroup
	         			+ "/opd/getRidcDocmentInfo";

	         	//var data = $('employeeId').val();
	            // alert("radioValue" +radioValue);
	         	$.ajax({
	         		type : "POST",
	         		contentType : "application/json",
	         		url : url,
	         		data : JSON.stringify({
	         			'ridcId' : ridcId,
	         			
	         		}),
	         		dataType : 'json',
	         		timeout : 100000,
	         		
	         		success : function(res)
	         		
	         		{
	         			data = res.ridcInfoList;
	     				
	         			for(var i=0;i<data.length;i++){
	     					
	 						var ridcInfo= data[i];
	     					
	     					var documentId=ridcInfo[0];
	     					var documentName = ridcInfo[1];
	     					var documentInfo = ridcInfo[2];
	     					var shipDownloadUrl = resourceJSON.shipDownloadUrl;
	     					var openUrl=shipDownloadUrl+documentId;
	     					window.open(openUrl);
	     				   	//window.location = "../downloadDocumentFromRIDC?dId="+documentId+"&"+"docName="+documentName+"&"+"dFormat="+documentInfo+"";
	         			}

	         		
	                    },
	                    error: function (jqXHR, exception) {
	                        var msg = '';
	                        if (jqXHR.status == 0) {
	                            msg = 'Not connect.\n Verify Network.';
	                        } else if (jqXHR.status == 404) {
	                            msg = 'Requested page not found. [404]';
	                        } else if (jqXHR.status == 500) {
	                            msg = 'Internal Server Error [500].';
	                        } else if (exception === 'parsererror') {
	                            msg = 'Requested JSON parse failed.';
	                        } else if (exception === 'timeout') {
	                            msg = 'Time out error.';
	                        } else if (exception === 'abort') {
	                            msg = 'Ajax request aborted.';
	                        } else {
	                            msg = 'Uncaught Error.\n' + jqXHR.responseText;
	                        }
	                        alert(msg);
	                    }
	         	});

	  }
	
	var uhidNumberValue="";
	 var checkForAuthen="";
	 function showUHIDPopUp() {
		 checkForAuthen =$("#checkForAuthenticationValue").val();
		 uhidNumberValue =$("#uhidNumberValue").val();
		 
					 $("#messageForAuthenticate").show();
					 $('.modal-backdrop').show();
		 
				 	
	 }
	 
	 function callToAutheniticate(){
			$('#errordiv').empty("");
			var uhidNo=$('#uhidNumber').val();
			document.getElementById('uhidNoValue').value = uhidNo;
			if(uhidNo==""){
				$('#errordiv').append(""+resourceJSON.msgEnterUhidnumber);
				$('#errordiv').show();
				return false;
			}
			var params = {
					"uhidNo" : uhidNo,
			}
			$.ajax({
				type : "POST",
				contentType : "application/json",
				url : 'checkAuthenticateUser',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(response) {
					var data = response.data;
					$('#uhidNumberValue').val(data);
					if(data=="success"){
						$('#messageForAuthenticateMessae').html("");
						autheniticateUHID1(uhidNo);
						//$('.modal-backdrop ').hide();
						closeMessage();
					}
					else{
						$('#messageForAuthenticateMessae').html(""+resourceJSON.msgValidEnterUhidnumber);
						
					}
					
					return ;
				}
			});
			
		}
	 
	 function searchLabHistory(){
		 nPageNo=1;
		 GetLabHistory('FILTER');
	 }
	 
	 function closeMessage(){
		 $('#errordiv').empty("");
		 $('#uhidNumber').val("");

		$('#messageForAuthenticate').hide();
		$('.modal-backdrop').hide();
	}
	 
	 
	
	
	 
	  function GetAutheniticateUHID1(MODE){
		  uhidNo=$('#uhidNoValue').val();
		  var fromDate = $j('#fromDate').val();
		  var toDate = $j('#toDate').val();
		  var patientId = $j('#selPatientName').find('option:selected').val();
		  var investigationName = $j('#investigationName').val();
		  
		  if (MODE == 'ALL') {
				var data = {"pageNo" : nPageNo,"uhidNo" : uhidNo,}

			} else {
				var data = {"pageNo" : nPageNo, "uhidNo" : uhidNo, "patientId":patientId, "fromDate":fromDate, "toDate":toDate, "pageNo" : nPageNo, "investigationName":investigationName}

			};
			
			
			var url = "autheniticateUHID";		
			var bClickable = false;
			GetJsonDataForUhid('tblListOfLabHistory',data,url,bClickable);	 
		} 
	 
	  function makeTableForUhid(jsonData){
		  var htmlTable = "";	
			var data = jsonData.count; 
			if(jsonData.data != undefined){
			var dataList = jsonData.data;			
			for(i=0;i<dataList.length;i++){		
				 var orderhdId = dataList[i].orderHdId;
				 $('#orderHdId').val(orderhdId);
				 orderheaderId = $('#orderHdId').val();
				
					htmlTable = htmlTable+"<tr id='"+dataList[i].orderHdId+"' >";
					//htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].serviceNo+"</td>";
					htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].investigationDate+"</td>";
					htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].patientName+"</td>";
					htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].relationName+"</td>";
					htmlTable = htmlTable +"<td style='width: 180px;'>"+dataList[i].genderName+" / "+dataList[i].age+"</td>";
					htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].hospitalName+"</td>";
					if(dataList[i].subInvestigationName!=null && dataList[i].subInvestigationName!= undefined && dataList[i].subInvestigationName!=''){
						htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].investigationName+" ("+dataList[i].subInvestigationName+")</td>";
					}else{
						htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].investigationName+"</td>";
					}
					
					htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].unit+"</td>";
					if(dataList[i].rangeStatus!=undefined && dataList[i].rangeStatus=='OR'){
						htmlTable = htmlTable +"<td style='width: 150px; color: red ; font-weight: bold'>"+dataList[i].investigationResult+"</td>";
					}else if(dataList[i].rangeStatus!=undefined && dataList[i].rangeStatus=='IR'){
						htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].investigationResult+"</td>";
					}else{
						htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].investigationResult+"</td>";
					}
					
					htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].range+"</td>";
					htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].createdBy+"</td>";
					htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].resultVerifiedBy+"</td>";
					htmlTable = htmlTable +"<td style='width: 150px; display:none''><input  class='form-control border-input' type='hidden' name='resultDetailStatus' id=''  value='"+dataList[i].resultDetailStatus+"'/></td>";
					htmlTable = htmlTable +"<td style='width: 150px; display:none''><input  class='form-control border-input' type='hidden' name='validated' id=''  value='"+dataList[i].validated+"'/></td>";
					htmlTable = htmlTable +"<td style='width: 150px; display:none''><input  class='form-control border-input' type='hidden' name='resultType' id=''  value='"+dataList[i].resultType+"'/></td>";
					htmlTable = htmlTable +"<td style='width: 150px; display:none''><input  class='form-control border-input' type='hidden' name='resultStatus' id=''  value='"+dataList[i].rangeStatus+"'/></td>";
					
					var status = '"'+dataList[i].resultDetailStatus.trim()+'"';
					var validate = '"'+dataList[i].validated.trim()+'"';
					
					if(dataList[i].ridcId!=null && dataList[i].ridcId != ''){
						//htmlTable = htmlTable +"<td style='width: 390px;'><input type='button' class='btn btn-primary mar_bottom' value='Report' onclick='generateReport("+dataList[i].orderHdId+", "+status+", "+validate+")'/> <input type='button' class='btn btn-primary mar_bottom' value='Document' onclick='viewDocument("+dataList[i].ridcId+")'/> </td>";
						htmlTable = htmlTable +"<td style='width: 390px;'><button id='printReportButton4' type='button' class='btn btn-primary noMinWidth' data-toggle='modal' data-backdrop='static' data-target='#exampleModal3' value='Report' onclick='makeUrl("+orderheaderId+", "+status+", "+validate+")'>Report</button> <button id='printReportButton6' type='button' class='btn btn-primary noMinWidth' data-toggle='modal' data-backdrop='static' data-target='#exampleModal3' value='Document' onclick='makeUrlViewDocument("+dataList[i].ridcId+")'>Document</button> </td>";
						
					}else{
						//htmlTable = htmlTable +"<td style='width: 390px;'><input type='button' class='btn btn-primary mar_bottom' value='Report' onclick='generateReport("+dataList[i].orderHdId+", "+status+", "+validate+")'/></td>";
						htmlTable = htmlTable +"<td style='width: 390px;'><button id='printReportButton5' type='button' class='btn btn-primary noMinWidth' data-toggle='modal' data-backdrop='static' data-target='#exampleModal3' value='Report' onclick='makeUrl("+orderheaderId+", "+status+", "+validate+")'>Report</button></td>";
					}
					htmlTable = htmlTable+"</tr>";
					
				}
			}
			
			if(jsonData.data == undefined)
				{
					htmlTable = htmlTable+"<tr ><td colspan='12'><h6>No Record Found</h6></td></tr>";				   
				}
			if(jsonData.data == undefined && data == 0)
			{				
				htmlTable = htmlTable+"<tr ><td colspan='12'><h6>No Record Found</h6></td></tr>";			   
			}	
			
			$j("#tblListOfLabHistory").html(htmlTable);
	  }
	  
	  function showResultPageForUhid(pageNo){
		  nPageNo = pageNo;	
		  GetAutheniticateUHID1('FILTER');
	  }
	</script>

</body>
</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
            