<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="..//view/leftMenu.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Indian Coast Guard</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

 <%
	String hospitalId = "1";
	if (session.getAttribute("hospital_id") != null) {
		hospitalId = session.getAttribute("hospital_id") + "";
	}
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
%> 


<%@include file="..//view/commonJavaScript.jsp"%>




<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/commonformodal.js"></script>


<script type="text/javascript" language="javascript">
var nPageNo=1;
var Status;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{	
	searchMEHistoryList('ALL');
		}); 
		
function searchMEHistoryList(MODE)
{
	
	var searchService = $j('#serviceNo').val();
	var examTypeId = $j('#examTypeId').val();
	var yearOfMeMB=$j('#yearOfMeMB').val();	
	var yearOfMeMBTo=$j('#yearOfMeMBTo').val();
	var employeeName=$j('#employeeName').val();	
	 if(MODE == 'ALL'){
			var data = {"pageNo":nPageNo, "serviceNo":searchService,  'mestatus':'','examTypeId':examTypeId,'yearOfMeMB':yearOfMeMB,'yearOfMeMBTo':yearOfMeMBTo,'employeeName':employeeName,'approvalFlag':'y','hospitalId':'<%=hospitalId%>'};			
		}
	 else if(MODE == 'FILTER'){
			 
			var data =  {"pageNo":nPageNo, "serviceNo":searchService,   'mestatus':'','examTypeId':examTypeId,'yearOfMeMB':yearOfMeMB,'yearOfMeMBTo':yearOfMeMBTo,'employeeName':employeeName,'approvalFlag':'y','hospitalId':'<%=hospitalId%>'}; 
		}
	 else if(searchService!="" || (examTypeId!="" && examTypeId!="0") || (yearOfMeMB!=undefined && yearOfMeMB!="" && yearOfMeMBTo!=undefined &&yearOfMeMBTo!="") || (employeeName !=undefined && employeeName !="")){
			nPageNo = 1;
			var data =  {"pageNo":nPageNo, "serviceNo":searchService,   'mestatus':'','examTypeId':examTypeId,'yearOfMeMB':yearOfMeMB,'yearOfMeMBTo':yearOfMeMBTo,'employeeName':employeeName,'approvalFlag':'y' ,'hospitalId':'<%=hospitalId%>'}; 
		}
	else
		{
			var data =  {"pageNo":nPageNo, "serviceNo":searchService,   'mestatus':'','examTypeId':examTypeId,'yearOfMeMB':yearOfMeMB,'yearOfMeMBTo':yearOfMeMBTo,'employeeName':employeeName,'approvalFlag':'y','hospitalId':'<%=hospitalId%>'}; 
		}
	 
	 
	 
	var url = "getMedicalExamListCommon";
		
	var bClickable = true;
	GetJsonData('tblListOfCommand',data,url,bClickable);
}
function makeTable(jsonData)
{	 
	var htmlTable = "";	
	var data = jsonData.count;
	var pageSize = 5;

	
	var dataList = jsonData.data;
	var medicalExamId="";
	var meTypeCode="";
	if(dataList!=null && dataList.length > 0)
		for(i=0;i<dataList.length;i++)
		{		
		medicalExamId=dataList[i].medicalExamId;
		meTypeCode=dataList[i].meTypeCode;
			
		htmlTable = htmlTable+"<tr id='"+dataList[i].visitId+"' >";	
			htmlTable = htmlTable +"<td style='display:none;'>"+dataList[i].patientId+"</td>";
			/* htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].tokenNo+"</td>"; */
			htmlTable = htmlTable +"<td style='width: 75px;'>"+dataList[i].serviceNo+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].patientName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].rankName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].meAgeNew+"</td>";
			htmlTable = htmlTable +"<td style='width: 75px;'>"+dataList[i].gender+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].meTypeName+"</td>";
			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].medicalExamDate+"</td>";
			 
			htmlTable = htmlTable +"<td style='width: 75px;'>"+dataList[i].status+"</td>";
			var mediExamBoardReportId="mediExamBoardReport"+medicalExamId;
			var viewOrEditFlag='no@@meView';
			var typeOfMEMB=dataList[i].meTypeName;
			if(typeOfMEMB.startsWith("AFMSF 15"))
			{
				htmlTable = htmlTable +"<td style='width: 250px;'><button  id ='mediExamBoardReport"+medicalExamId+"' type='button'  class='btn btn-primary'  onclick='getReportForMeH(\""+ dataList[i].visitId+ "\",\""+ meTypeCode+ "\",\""+ mediExamBoardReportId+ "\");'>Report</button>";
			}
			else
			{			
			htmlTable = htmlTable +"<td style='width: 250px;'><button  id ='mediExamBoardReport"+medicalExamId+"' type='button'  class='btn btn-primary'  onclick='getReportForMeH(\""+ medicalExamId+ "\",\""+ meTypeCode+ "\",\""+ mediExamBoardReportId+ "\");'>Report</button>";
			}
			if(dataList[i].ridcValue!=null && dataList[i].ridcValue!=""){
				htmlTable= htmlTable + "  <button id ='printBtn' type='button'  class='btn btn-primary' onclick='viewDocumentForDigi(\""+dataList[i].ridcValue+"\");'>View Original Docs</button>";
			}
			
			if(dataList[i].status!="" && (dataList[i].status=='Verified'||dataList[i].status=='Approved') && (dataList[i].showViewAndReport!="" && dataList[i].showViewAndReport=='yes')){
				htmlTable = htmlTable + " <button id ='printBtn1' type='button'  class='btn btn-primary' onclick='return previousMedicalExamOpenInHtml(\""+ dataList[i].visitId+ "\",\""+ dataList[i].age+ "\",\""+ dataList[i].meTypeCode+"\",\""+viewOrEditFlag+"\",\""+ dataList[i].visitFlag+"\",\""+ dataList[i].approvedBy+"\");'>View HTML</button>";
				 
			}
			htmlTable = htmlTable +"</td>";
			if(dataList[i].meApprovalRidcId!=null && dataList[i].meApprovalRidcId!=""){
				
				htmlTable= htmlTable + " <td style='width: 250px;'> <button id ='printBtn' type='button'  class='btn btn-primary' onclick='viewDocumentForDigi(\""+dataList[i].meApprovalRidcId+"\");'>View Sign Doc</button>";
				htmlTable = htmlTable +"</td>";
			}
			else{
				 
			htmlTable = htmlTable +" <td style='width: 250px;'>"; 
			 htmlTable = htmlTable + ' <div id="">';
			htmlTable = htmlTable + ' <form name="uploadlingApprovalFile'+dataList[i].visitId+'" id="uploadlingApprovalFile'+dataList[i].visitId+'" method="post" enctype="multipart/form-data"';
			htmlTable = htmlTable + '  action="${pageContext.request.contextPath}/medicalexam/uploadApprovalFile" autocomplete="on"> ';
			 
			
			
			htmlTable = htmlTable + '	<div class="opdMain_detail_area">';
			htmlTable = htmlTable + '		<div class="form-group row">';
			htmlTable = htmlTable + '			<label class="col-md-5">Upload File';
			htmlTable = htmlTable + '				</label>';
			htmlTable = htmlTable + '				<div class="col-md-5" id="uploadFileMedicalExam">';
			htmlTable = htmlTable + '				<div class="fileUploadDiv">';
			htmlTable = htmlTable + '					<input type="file" name="medicalExamApprovalFileUpload'+i+'"';
			htmlTable = htmlTable + '						id="medicalExamApprovalFileUpload'+i+'" class="inputUpload" /> <label';
			htmlTable = htmlTable + '							class="inputUploadlabel">Choose File</label> <span'; 
			htmlTable = htmlTable + '						class="inputUploadFileName" style="margin-top:30px;">No File Chosen</span>'; 
			htmlTable = htmlTable + '				</div>';
			htmlTable = htmlTable + '		</div>';
			htmlTable = htmlTable + '			<div style="display: none" class="col-md-7"';
			htmlTable = htmlTable + '				id="viewUploadedFile"></div>';
			htmlTable = htmlTable + '			</div>';
			htmlTable = htmlTable + '		</div>';
			
			//htmlTable = htmlTable + '<input type="button" id="submitInvess"
				//class="btn btn-primary"
				//onClick="return submitInves('inves');" value="Save"/>
				
			//htmlTable = htmlTable + " <button id ='approvalButtonSubmit"+i+"' type='button'  class='btn btn-primary' onclick='return uploadApprovalRmsData(\""+ dataList[i].visitId+ "\",\""+ medicalExamId+ "\",\""+ dataList[i].meTypeCode+"\",\""+dataList[i].serviceNo+"\",\""+ dataList[i].medicalExamDate+"\",\""+ dataList[i].approvedBy+"\",this);'>Upload Sign Document</button>";
			
			htmlTable = htmlTable + " <input type='button' id ='approvalButtonSubmit"+i+"' type='button'  class='btn btn-primary' onclick='return uploadApprovalRmsData(\""+ dataList[i].visitId+ "\",\""+ medicalExamId+ "\",\""+ dataList[i].meTypeCode+"\",\""+dataList[i].serviceNo+"\",\""+ dataList[i].medicalExamDate+"\",\""+ dataList[i].approvedBy+"\",this);' value='Upload Sign Document'/> ";
			
			htmlTable = htmlTable + '</form>';
			htmlTable = htmlTable + ' </div>';
			
			htmlTable = htmlTable +"</td>"; 
			}
			htmlTable = htmlTable+"</tr>";
		}
	if(dataList==null || dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='10'><h6>No Record Found</h6></td></tr>";
		}			
	//$('#ssnValue').val(count);
	$j("#tblListOfCommand").html(htmlTable);	
}
var visitId;
var patientId;
var patinetname;
var status;
var rankName;
var age;
var gender;
var meTypeName;
var meDateName;
var departmentId;
var meTypeCode;
function executeClickEvent(visitId,data)
{
	 
	for(j=0;j<data.data.length;j++){
		if(visitId == data.data[j].visitId){
			
			visitId = data.data[j].visitId;
			
			patientId = data.data[j].patientId;
			patinetname = data.data[j].patinetname;
			age = data.data[j].age;
			gender = data.data[j].gender;
			rankName = data.data[j].rankName;
			meTypeName = data.data[j].meTypeName;
			status = data.data[j].status;
			departmentId = data.data[j].departmentId;
			meTypeCode = data.data[j].meTypeCode;
			meDateName=data.data[j].medicalExamDate;
		}
	}
	//rowClick(visitId,patientId,patinetname,age,gender,rankName,meTypeName,status,departmentId,meTypeCode);
}

<%-- function rowClick(visitId,patientId,patinetname,age,gender,rankName,meTypeName,status,departmentId,meTypeCode){
		$("#visitId").val(visitId);
		$("#departmentId").val(departmentId);
		$("#patientId").val(patientId);
		var countCheckBox=0;
		if(meTypeCode!=null && meTypeCode!="" && meTypeCode.trim() === resourceJSON.meForm18){
			 window.location.href = "validateMAWaitingDetailAFMSF18?visitId="+visitId+"&age="+age+"&userId="+<%=userId%>;	
		}
		else if(meTypeCode!=null && meTypeCode!="" && meTypeCode.trim() == resourceJSON.meForm3A){
			window.location.href = "validateMAWaitingDetail3A?visitId="+visitId+"&age="+age+"&userId="+<%=userId%>;	
		}
		else{
		 	window.location.href = "validateMAWaitingDetail?visitId="+visitId+"&age="+age+"&userId="+<%=userId%>;	
		}
		} --%>


function searchValidateList()
{
 	var searchService = $j('#serviceNo').val();
	var yearOfMeMB=$j('#yearOfMeMB').val();
	var employeeName=$j('#employeeName').val();	
	var examTypeId=$j('#examTypeId').val();	
	if((searchService=="" || searchService == undefined)   && (yearOfMeMB==undefined || yearOfMeMB=="") && (employeeName==undefined || employeeName=="") &&  (examTypeId==undefined || examTypeId=="" || examTypeId=='0')){
	// if((searchService == undefined || searchService == '') && ( yearOfMeMB==undefined || yearOfMeMB=='')){	
			alert("At least  one option must be entered.");
			return;
		}	
	 searchMEHistoryList('Search');
	//ResetForm();
} 
function ShowAllList(pageNo)
{	 
	 nPageNo=pageNo;
	 resetForm();
	 searchMEHistoryList('ALL');
}

function resetForm()
{	
	 $j('#serviceNo').val('');
	 $j('#yearOfMeMB').val('');
	 $j('#yearOfMeMBTo').val('');
	 $j('#employeeName').val('');
	 
	// openExamSubTypeExist();
}

function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	searchMEHistoryList('FILTER');
	
}


function openExamSubTypeExist(){
	var examValues="";
	
	examValues = '<select class="form-control" name="examTypeId"';
	examValues += 'id="examTypeId">';
	examValues += '<option value="0"><strong>Select</strong></option>';
								for(exam in subTypeList){
									 examValues += '<option value='+subTypeList[exam].examId+'>'
													+ subTypeList[exam].examName
													+ '</option>';
								 }
									$j('#examTypeId').html(examValues); 
							} 
					 
		 
				
 
</script>


</head>
<body>
 
	<div id="wrapper">
		<div class="content-page">
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext"><spring:message code="meApprovalHistoryDocument" /></div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Service
														No.</label>
												</div>
												<div class="col-md-7">
													<input type="text" name="serviceNo" id="serviceNo"
														class="form-control" />
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Employee
														Name</label>
												</div>
												<div class="col-md-7">
													<input type="text" name="employeeName" id="employeeName"
														class="form-control" />
												</div>
											</div>
										</div>

										<div class="col-md-4" style="display:none;">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">ME Type</label>
												</div>
												<div class="col-md-7" >
													<select class="form-control" id="examTypeId"
														name="examTypeId">
														<option value="0">Select</option>
													</select>
												</div>
											</div>
										</div>
										
										
										<div class="col-md-4">
											<!-- <div class="col-md-5">
													<label for="service" class="col-form-label">Year of ME/MB </label>
												</div> -->
											<div class="form-group row">
												
												<div class="col-md-5">
													<label for="service" class="col-form-label">From Date</label>
												</div>
												
												<div class="col-md-7">
													 
															<div class="dateHolder">
															<input type="text" name="yearOfMeMB" id="yearOfMeMB"
																class="noFuture_date2 form-control"
																placeholder="DD/MM/YYYY" value=""/>
														</div>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											
											<div class="form-group row">
												
												<div class="col-md-5">
													<label for="service" class="col-form-label">To Date</label>
												</div>
												
												<div class="col-md-7">
															<div class="dateHolder">
															<input type="text" name="yearOfMeMBTo" id="yearOfMeMBTo"
																class="noFuture_date2 form-control"
																placeholder="DD/MM/YYYY" value=""/>
															</div>
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-6">
													<button type="button" class="btn btn-primary" onclick=" return searchValidateList('ALL')">Search</button>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-12 text-right">
													<button type="button" class="btn btn-primary" onclick="ShowAllList('1')">Show All</button>
												</div>
											</div>
										</div>
									</div>
									
									
									</div>
									
									<div class="col-12">
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
									<div class="clearfix"></div>
									<table
										class="table table-hover table-striped table-bordered m-t-10">
										<thead class="bg-primary">
											<tr>
												<!-- <th>Token No.</th> -->
												<th>Service No.</th>
												<th>Emp Name</th>
												<th>Rank at time of Exam</th>
												<th>Age at time of Exam</th>
												<th>Gender</th>
												<th>Medical Exam</th>
												<th >Date Of Exam</th>
												<th>Status</th>
												<th>Action</th>
												<th>Upload Approved Document</th>
											</tr>
										</thead>
										<tbody id="tblListOfCommand">
											 <tr>
                                                <td colspan='10'>No Record Found</td>
                                               </tr>
										</tbody>
									</table>

										<div id="medicalEXamReportId">
										  <form  name="medicalExamReportReportId" id="medicalExamReportReportId" method="post" 
											action="${pageContext.request.contextPath}/report/medicalExamReportReport" autocomplete="on">
												<input type="hidden" name="visit_id" id="visit_id3b" value=""/>   
											</form>	  
											
											<form  name="medicalExamReportReportId18" id="medicalExamReportReportId18" method="post" 
											action="${pageContext.request.contextPath}/report/medicalExamReportReportF18" autocomplete="on">
												<input type="hidden" name="visit_id" id="visit_id18" value=""/>   
											</form>	

											<form  name="medicalExamReportReportId3A" id="medicalExamReportReportId3A" method="post" 
											action="${pageContext.request.contextPath}/report/medicalExamReportReportF3A" autocomplete="on">
												<input type="hidden" name="visit_id" id="visit_id3a" value=""/>   
											</form>	
											

											<form  name="medicalExamReportReportId2A" id="medicalExamReportReportId2A" method="post" 
											action="${pageContext.request.contextPath}/report/medicalExamReportReportId2A" autocomplete="on">
												<input type="hidden" name="visit_id" id="visit_id2a" value=""/>   
											</form>	
											
											
											
											
											<form  name="medicalExamReportReportId15" id="medicalExamReportReportId15" method="post" 
											action="${pageContext.request.contextPath}/report/mbAmsf15Report" autocomplete="on">
												<input type="hidden" name="visit_id" id="visit_id15" value=""/>   
											</form>	
											
										</div>
								</div>

							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
			
		

	</div>
<script type="text/javascript" language="javascript">
	var nPageNo=1;
	var Status;
	var $j = jQuery.noConflict();

	$j(document).ready(function()
		{	
		openExamSubType(0);
		});  
	
	
	
	function viewDocument(ridcId)
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
							
							var urlInfo = window.location.protocol + "//"
		     			+ window.location.host + "/" + accessGroup
		     			+ "/digifileupload/getStatus";
							$.ajax({
								type : "POST",
								contentType : "application/json",
								url : urlInfo,
								data : JSON.stringify({
				        			'docId' : documentId,
				        			'docName':documentName,
				        			'dFormat':documentInfo
				        			
				        		}),
								dataType : "json",
								cache : false,
								
								success : function(res) {
									
									if(res.status=="RELEASED"){
										//window.location = "../downloadDocumentFromRIDC?dId="+documentId+"&"+"docName="+documentName+"&"+"dFormat="+documentInfo+"";
										window.open( "../downloadDocumentFromRIDC?dId="+documentId+"&"+"docName="+documentName+"&"+"dFormat="+documentInfo+"","_blank");
										
									}
									if(res.status=="EXPIRED"){
										alert("Document Expired-this document is not longer available");
										
									}
									
								},
								error : function(res) {
									alert("An error has occurred while contacting the server");
									 window.location="${pageContext.request.contextPath}/v0.1/dashboard/dashboard"; 
								}
							});
							
						   	
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
	
	function validateFileExtension(component,msg_id,msg,extns)
	{
	   var flag=0;
	   with(component)
	   {
	      var ext=component.substring(component.lastIndexOf('.')+1);
	      for(i=0;i<extns.length;i++)
	      {
	         if(ext==extns[i])
	         {
	            flag=0;
	            break;
	         }
	         else
	         {
	            flag=1;
	         }
	      }
	      if(flag!=0)
	      {
	         alert(msg);
	         component.value="";
	         component.style.backgroundColor="#eab1b1";
	         component.style.border="thin solid #000000";
	         component.focus();
	         return false;
	      }
	      else
	      {
	         return true;
	      }
	   }
	}
	
	
	</script>

<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
</body>
</html>