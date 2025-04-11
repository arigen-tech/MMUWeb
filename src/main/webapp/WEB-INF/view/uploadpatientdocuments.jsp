<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.mmu.web.utils.ProjectUtils"%>
<%@page import="java.util.*"%>
<%@page import="com.mmu.web.entity.UploadDocument"%>
<%@page import="com.mmu.web.utils.HMSUtil"%>
<%@include file="..//view/leftMenu.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/uploaddig.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
<title>Upload patient documents</title>
<%long valueRegistrationTypeId = Long.parseLong(HMSUtil.getProperties("js_messages_en.properties", "REGISTRATION_TYPE_ICG_ID")); %>

 <%
	String hospitalId = "0";
	if (session.getAttribute("hospital_id") != null) {
		hospitalId = session.getAttribute("hospital_id") + "";
	}
	String userId = "0";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
%>

<script type="text/javascript">
var labRadioValue=resourceJSON.mainchargeCodeLab;
var imagRadioValue=resourceJSON.mainchargeCodeRadio;
</script>
<script type="text/javascript">
	$j(document).ready(function() {
		$j('#lab_radio').val(labRadioValue);
		$j('#imag_radio').val(imagRadioValue);
		$j('#labImaginId').val(labRadioValue);
	});
	
	
	$j('#serviceNo').keypress(function(e) {
		var key = e.which;
		if (key == 13) // the enter key code
		{
			getPatientList();
			return false;
		}
	});
	
</script>
</head>
 <body>
 <div id="wrapper">
	
<div class="Clear"></div>

<script >
	var patientList="";
	function getPatientList() {
		$('#loadingDiv').show();
		var serviceNo = $j('#serviceNo_uhid').val();
		$j('#patientId').val("");
		document.getElementById("patientName").options.length = 1;
		if(serviceNo){
			var params = {
					"serviceNo":serviceNo
			}
			$j.ajax({
				
				type : "POST",
				contentType : "application/json",
				url : 'getPatientListFromServiceNo',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(response) {
					if(response.status=='1'){
						var patientValue = "";
						 patientList = response.data;
						 for(count in patientList){
							 patientValue += '<option value='+patientList[count].patientId+'~~'+patientList[count].Id+'>'
											+ patientList[count].name
											+ '</option>';
										
						 }
						 $j('#patientName').append(patientValue); 	  	
						
					}else{
						$j('#patientId').val("");
						document.getElementById("patientName").options.length = 1;
						alert(response.msg);
					}
					
					$('#loadingDiv').hide();
				}
			});
		}else{
			alert("Service No. can not be blank.");
			$('#loadingDiv').hide();
			return false;
		}
		
	}
	
	
function changePatientName(){
		var patientSelectValue = $j('#patientName').find('option:selected').val();
		var splitValue=patientSelectValue.split("~~");
		var patientId = splitValue[0];
		var rowId = parseInt(splitValue[1]);
		if(patientId!=0){
			$j('#patientId').val(patientId);
			for(i in patientList){
				   if(patientId==patientList[i].patientId){
				    $j('#uhidNo').val(patientList[i].uhidNo);
				    $j('#genderId1').val(patientList[i].genderId);
				   }}
			var radioValue = $("input[name='btnradio']:checked").val();
			var params = {
						 "patientId":patientId,
						 "radioValue":radioValue
						}
					 var data = params;
		   			 var url = 'getDocumentListForPatient';
		    		 var bClickable = true;
		            GetJsonData('resultUploadDocTable', data, url, bClickable);
		}else if(patientId=="0"){
		for(count in patientList){
		if(rowId==patientList[count].Id){
			$j('#patientId').val("0");
			$j('#uhidNo').val(patientList[count].uhidNo);
			$j('#employeeId').val(patientList[count].employeeId);
			$j('#name').val(patientList[count].name);
			$j('#genderId').val(patientList[count].genderId);
			$j('#dateOfBirth').val(patientList[count].dateOfBirth);
			$j('#relationId').val(patientList[count].relationId);
			$j('#serviceNo').val(patientList[count].serviceNo);
			$j('#empRankId').val(patientList[count].empRankId);
			$j('#empTradeId').val(patientList[count].empTradeId);
			$j('#empName').val(patientList[count].empName);
			$j('#empServiceJoinDate').val(patientList[count].empServiceJoinDate);
			$j('#empUnitId').val(patientList[count].empUnitId);
			$j('#empCommandId').val(patientList[count].empCommandId);
			$j('#empRecordOfficeId').val(patientList[count].empRecordOfficeId);
			$j('#empMaritalStatusId').val(patientList[count].empMaritalStatusId);
				
			$j('#uhidNo1').val(patientList[count].uhidNo);
			$j('#employeeId1').val(patientList[count].employeeId);
			$j('#name1').val(patientList[count].name);
			$j('#genderId1').val(patientList[count].genderId);
			$j('#dateOfBirth1').val(patientList[count].dateOfBirth);
			$j('#relationId1').val(patientList[count].relationId);
			$j('#serviceNo1').val(patientList[count].serviceNo);
			$j('#empRankId1').val(patientList[count].empRankId);
			$j('#empTradeId1').val(patientList[count].empTradeId);
			$j('#empName1').val(patientList[count].empName);
			$j('#empServiceJoinDate1').val(patientList[count].empServiceJoinDate);
			$j('#empUnitId1').val(patientList[count].empUnitId);
			$j('#empCommandId1').val(patientList[count].empCommandId);
			$j('#empRecordOfficeId1').val(patientList[count].empRecordOfficeId);
			$j('#empMaritalStatusId1').val(patientList[count].empMaritalStatusId);
			 
		}
			}
			
		}
	}	

function makeTable(jsonData) {
    var htmlTable = "";
    var orderList = jsonData.listObjectInv;
    var radioValue = $("input[name='btnradio']:checked").val();
	   //if(radioValue!="" && radioValue=='investigation'){
			getOrderNumberOnPatient(orderList);
		//}
    if(jsonData.status==1){
   	var dataList = jsonData.data;
			 for (count = 0; count < dataList.length; count++) {
			 var a =parseInt(count)+1;
			 var remarks="";
			 if(dataList[count].remarks != undefined)
				 {
				 remarks= dataList[count].remarks
				 }
	    	  htmlTable = htmlTable + "<tr id='" + dataList[count].Id + "'>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + a + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'><a style='text-decoration:underline; color:blue;'  href='#' onclick='viewDocumentForDigi("+dataList[count].ridcId+")'</a>"+dataList[count].fileName+"</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'>" + remarks + "</td>";
	    	  htmlTable = htmlTable + "<td style='width: 150px;'><input type='button' id='deletebtn' name= 'deletebtn' class='btn  btn-danger' value='Delete'  onclick='deleteInvestAndReferalValueRowGenDoc(this,9,"+dataList[count].ridcId+","+dataList[count].Id+")'></td>";
	      }
		
	      $j("#resultUploadDocTable").html(htmlTable);
	}else{
		 $j("#resultUploadDocTable").empty();
	}
 }


function uploadDocument(){
	var serviceNo = $j('#serviceNo_uhid').val();
	if(serviceNo){
		var patientId =$j('#patientId').val();
		if(patientId!=""){
			if (document.getElementById('fileUploadId').value == ""){
				alert('Please select a file to Upload');
				return;
				}
			validation("fileUploadForm");
				 // Get form
		        var form = $('#fileUploadForm')[0];
				// Create an FormData object 
		        var data = new FormData(form);
				// disabled the submit button
		        $("#btnAdd").prop("disabled", true);

		        $.ajax({
		            type: 'POST',
		            enctype: 'multipart/form-data',
		            url: 'uploadDocumentForPatient',
		            data: data,
		            processData: false,
		            contentType: false,
		            cache: false,
		            timeout: 600000,
		            success: function (resp) {
		            	$("#btnAdd").prop("disabled", false);
		            	$("#genDocUpload").find(".fileUploadDiv ").removeClass('hasFile');
		            	$("#genDocUpload").find('.inputUploadlabel').text('Choose File');	
		            	$("#genDocUpload").find(".inputUploadFileName").text('No File Chosen');
		            	var data = JSON.parse(resp);
		            	if(data.data.respMap.status=="1"){
		            		 changePatientName();
				             resetFields();
				             alert(data.data.respMap.message);
		            	}else{
		            		 alert(data.data.respMap.message);
		            	}
		            },
		            error: function (e) {
		                alert(e.responseText);
		               $("#btnAdd").prop("disabled", false);

		            }
		        });
				
		}else{
			alert("Please select the patient.");
			return false;
		}
	}else{
		alert("Service No. can not be blank.");
		return false;
	}
	
}	
	
	function downloadFile(fileId){
		viewDocumentForDigi(fileId);
	  //window.open('${pageContext.request.contextPath}/registration/viewUploadDocuments?fileId='+fileId+'',"_blank");
	}

	
	function deleteFile(fileId){
		
		var params={
				"fileId": fileId
		}
	       $.ajax({
	    	   type : "POST",
				contentType : "application/json",
				url : 'deleteUploadDocument',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
	            success: function (data) {
	               if(data.data.status=="1"){
	            	   alert(data.data.msg);
	            	   changePatientName();
		               resetFields();
	               }else{
	            	   alert(data.data.msg); 
	               }
	            },
	            error: function (e) {
	              	alert(e.responseText);

	            }
	        });
	
	}
	
	function resetFields(){
		$j('#spanInputUploadFileName').text("");
		$('#fileUploadId').val("");
		$('#remarks').val("");
	//	document.getElementById("patientName").options.length = 1;
		
	}
	
	
	function validation(thisform)
	{
	var file =$('#fileUploadId').val();
	   with(thisform)
	   {
	      if(validateFileExtension(file, "valid_msg", "Only pdf/image files are allowed ",
	      new Array("jpg","pdf","jpeg","gif","png")) == false)
	      {
	         return false;
	      }
	   }
	}
	
</script>
			<div class="content-page">
				<div class="">
					<div class="container-fluid">
						<div class="internal_Htext">Upload Patient Documents</div>

						<div class="row">
							<div class="col-12">
								<div class="card">
									<div class="card-body">

										<!-- Patient Detail Start Here -->
										 <form method="post" name="fileUploadForm" id="fileUploadForm"> 
											<div class="row">
												<div class="col-md-4">
													<div class="form-group row">
														<label class="col-md-6 col-form-label">Service/UHID No.
														</label>
														<div class="col-sm-6">
															<input autocomplete="off" name="serviceNo" id="serviceNo_uhid" type="text"
																class="form-control border-input"
																placeholder="Service No." value=""
																onblur="getPatientList()" />
														</div>
													</div>
												</div>
											 
												<div class="col-md-4">
													<div class="form-group row">
														<label class="col-sm-6 col-form-label">Patient 	Name </label>
														<div class="col-sm-6">
															<select id="patientName" name="patientName"
																	class="form-control" onchange="changePatientName();">
																	<option value="" selected="selected">Select</option>
															</select>
												        </div>
														   <input type="hidden" name="patientId" id="patientId" value=""/>
												           <input type="hidden" name="fileId" id="fileId" value=""/>
														   <input type="hidden"  name="uhidNo"      value=""  id="uhidNo"  />
														   <input type="hidden"  name="employeeId"  value=""  id="employeeId"/>
														   <input type="hidden"  name="name" value="" id="name"/>
														   <input type="hidden"  name="genderId" value="" id="genderId"/>
														   <input type="hidden"  name="dateOfBirth" value="" id="dateOfBirth"/>
														   <input type="hidden"  name="relationId" value="" id="relationId"/>
														   <input type="hidden"  name="serviceNo" value="" id="serviceNo"/>
														   <input type="hidden"  name="empRankId" value="" id="empRankId"/>
														   <input type="hidden"  name="empTradeId" value="" id="empTradeId"/>
														   <input type="hidden"  name="empName" value="" id="empName"/>
														   <input type="hidden"  name="empServiceJoinDate" value="" id="empServiceJoinDate"/>
														   <input type="hidden"  name="empUnitId" value="" id="empUnitId"/>
														   <input type="hidden"  name="empCommandId" value="" id="empCommandId"/>
														   <input type="hidden"  name="empRecordOfficeId" value="" id="empRecordOfficeId"/>
														   <input type="hidden"  name="empMaritalStatusId" value="" id="empMaritalStatusId"/>
														   <input type="hidden"  name="registrationTypeId" value="<%=valueRegistrationTypeId%>" id="registrationTypeId"/>
														   <input type="hidden" name="currentObjectForResultOffLineDate" id="currentObjectForResultOffLineDate" value=""/>
															<input type="hidden" name="currentObjectForResultOffLinenumber" id="currentObjectForResultOffLinenumber" value=""/>											   
													</div>
												</div>
												<div class="col-md-2">
													<div id="loadingDiv">
														<img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
													</div>
												</div>
											<div class="w-100 m-t-10"></div>
								          	<div class="col-md-2 m-t-5">  									
											   <!-- <label class="radio-inline m-t-5">
											      General Docs &nbsp &nbsp
											    <input  style="  position: relative; top: 3px; "  checked="checked" type="radio" value="generaldoc" onChange="return openGeneralDocAndInv('gen');" id="insdocRadio" name="btnradio">
											    </label> -->	
											    
											    <div class="form-check form-check-inline cusRadio">
													<input class="form-check-input" checked="checked" type="radio" value="generaldoc" onChange="return openGeneralDocAndInv('gen');" id="insdocRadio" name="btnradio">
													<span class="cus-radiobtn"></span> 
													<label class="form-check-label" for="insdocRadio">General Docs</label>
												</div> 
								             </div>
										             
										     <div class="col-md-2 m-t-5">
												<!-- <label class="radio-inline m-t-5"> Laboratory
													&nbsp &nbsp 
													<input type="radio" value="investigation" onChange="return changeRadioForUploa(this.value),openGeneralDocAndInv('Lab');" id="lab_radio" name="btnradio">
												</label> -->
												
												<div class="form-check form-check-inline cusRadio">													
													<input class="form-check-input" type="radio" value="investigation" onChange="return changeRadioForUploa(this.value),openGeneralDocAndInv('Lab');" id="lab_radio" name="btnradio">
													<span class="cus-radiobtn"></span> 
													<label class="form-check-label" for="lab_radio">Laboratory</label>
												</div>
											</div>

											<div class="col-md-2 m-t-5">
												<!-- <label class="radio-inline m-t-5"> Imaging &nbsp
													&nbsp <input style="position: relative; top: 3px;"
													type="radio" value="imaging"
													onChange="return changeRadioForUploa(this.value), openGeneralDocAndInv('Radio');"
													id="imag_radio" name="btnradio">
												</label> -->
												
												<div class="form-check form-check-inline cusRadio">													
													<input class="form-check-input" type="radio" value="imaging"
													onChange="return changeRadioForUploa(this.value), openGeneralDocAndInv('Radio');"
													id="imag_radio" name="btnradio">
													<span class="cus-radiobtn"></span> 
													<label class="form-check-label" for="imag_radio">Imaging &nbsp &nbsp </label>
												</div>
											</div>
											
											<div class="col-md-2 m-t-5">
												 
												
												<div class="form-check form-check-inline cusRadio">													
													<input class="form-check-input" type="radio" value="precriptionDetails" onChange="openGeneralDocAndInv('pre');" id="pre_radio" name="btnradio">
													<span class="cus-radiobtn"></span> 
													<label class="form-check-label" for="lab_radio">Prescription</label>
												</div>
												
											</div>
											<div class="col-md-2 m-t-5">
												<div class="form-check form-check-inline cusRadio">													
													<input class="form-check-input" type="radio" value="otherSup" onChange="openGeneralDocAndInv('otherSup');" id="othersup_radio" name="btnradio">
													<span class="cus-radiobtn"></span> 
													<label class="form-check-label" for="lab_radio">Other Supported Docs</label>
												</div>
											</div>
											
											<div class="col-md-4" style="display:none" id="orderNumberIdInv">
												<div class="form-group row">
													<label class="col-sm-6 col-form-label">Order Number
													</label>
													<div class="col-sm-6">
														<select id="orderNumber" name="orderNumber"
															class="form-control"
															onchange="return getInvestigationEmptyResultByOrderNo();">
															<option value="0" selected="selected">Select</option>
														</select>
													</div>
												</div>
											</div>
											<div class="col-md-2">
												<div id="loadingDiv2">
													<img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
												</div>
											</div>
											
											<div class="col-md-6">
											</div>
																					         
									</div>
											
											
									
										<div class="m-t-10" id="genDoc">
										
										<table class="table table-striped table-hover  table-bordered  ">
													<thead>
														<tr>
															<th style=" width: 34%;" id="th1">Document</th>
															<th id="th2">Remarks</th>
															<th id="th3">Action</th>
														</tr>
													</thead>
													<tbody id="tblUploadDocument">
													<tr>
   														 <td id="genDocUpload">
   														 	<!-- <label>File</label> -->
   														 	<div class="fileUploadDiv">
	   														  	<input type="file" multiple name="uploadFile" class="file inputUpload" id="fileUploadId">
	   														  	<label class="inputUploadlabel">Choose File</label>
																<span id="spanInputUploadFileName" class="inputUploadFileName">No File Chosen</span>
   														  	</div>
  														 </td>
   														  
   														  
   														  <td><textarea  class="form-control" type="textarea" name="remarks" id="remarks" value=""  MAXLENGTH="100" tabindex="1" rows="1"></textarea></td>
   														 <td><input name="btnAdd" id="btnAdd" type="button" class="btn  btn-primary" value="Upload" onClick="uploadDocument();"/></td> 
 													 </tr>
													</tbody>
												</table>
										</div>
										</form>	
									 <div id="resultDoc">
									 
									<table class="table table-striped table-hover  table-bordered  ">
											<thead>
												<tr>
													<th style=" width:17%;" >Sr No.</th>
													<th style=" width:40%;" >View Doc</th>
													<th>Remarks</th>
													<th>Action</th>
												</tr>
											</thead>
													<tbody id="resultUploadDocTable">
													</tbody>
								  </table>
									 
									 
									</div>
									
							<div id="invAndRadio" style="display: none">
										<form:form name="submitInvesUp" id="submitInvesUp"
											method="post" enctype='multipart/form-data'
											action="${pageContext.request.contextPath}/registration/submitInvestigationUp"
											autocomplete="on">

											<input type="hidden" name="userId" id="userId"
												value="<%=userId%>">
											<input type="hidden" name="hospitalId" id="hospitalId"
												value="<%=hospitalId%>">
											<input type="hidden" name="patientIdIn" id="patientIdIn"
												value="" />
											<input type="hidden" name="serviceNoIn" id="serviceNoIn"
												value="" />
											<input type="hidden" name="orderNumberInv"
												id="orderNumberInv" value="" />
											<input type="hidden" name="rmdId" id="rmdId" value="" />
											<input type="hidden" name="radioInvAndImaValue"
												id="radioInvAndImaValue" value="" />
											 <input type="hidden"  name="uhidNo"      value=""  id="uhidNo1"  />
											   <input type="hidden"  name="employeeId"  value=""  id="employeeId1"/>
											   <input type="hidden"  name="name" value="" id="name1"/>
											   <input type="hidden"  name="genderId" value="" id="genderId1"/>
											   <input type="hidden"  name="dateOfBirth" value="" id="dateOfBirth1"/>
											   <input type="hidden"  name="relationId" value="" id="relationId1"/>
											   <input type="hidden"  name="serviceNo" value="" id="serviceNo1"/>
											   <input type="hidden"  name="empRankId" value="" id="empRankId1"/>
											   <input type="hidden"  name="empTradeId" value="" id="empTradeId1"/>
											   <input type="hidden"  name="empName" value="" id="empName1"/>
											   <input type="hidden"  name="empServiceJoinDate" value="" id="empServiceJoinDate1"/>
											   <input type="hidden"  name="empUnitId" value="" id="empUnitId1"/>
											   <input type="hidden"  name="empCommandId" value="" id="empCommandId1"/>
											   <input type="hidden"  name="empRecordOfficeId" value="" id="empRecordOfficeId1"/>
											   <input type="hidden"  name="empMaritalStatusId" value="" id="empMaritalStatusId1"/>
											   <input type="hidden"  name="registrationTypeId" value="<%=valueRegistrationTypeId%>" id="registrationTypeId1"/>	
													<input  name="labImaginId" id="labImaginId" type="hidden" value="" />
								<input type="hidden" name="radioInvAndImaValueandPre"
												id="radioInvAndImaValueandPre" value="" />
												<input type="hidden" name="resultIdMedicalDocs"
										id="resultIdMedicalDocs" />
											<div  id="investgationDetail" style="display: none">
												 

												<table
													class="table table-hover table-striped table-bordered">
													<thead class="bg-primary">
														<tr>
															<th  ></th>
															<th>Investigation</th>
															<th id="uomId">UOM</th>
															<th>Result</th>
															<th>Range</th>
															<th style="display:none">File Upload</th>
															<th>Add</th>
															<th>Delete</th>
														</tr>
													</thead>
													<tbody id="dgInvetigationGrid">

														<tr>
															<td >
																<div class="form-check form-check-inline cusCheck">
																	<input class="form-check-input position-static"
																		type="checkbox" name="checkBoxForUpload"
																		id="checkBoxForUpload" onClick="return getInvestionCheckData(this);" >
																	<span class="cus-checkbtn"></span> 
																</div>
															</td>

															<td>
																<!-- <input type="text" class="form-control"> -->
																<div class="autocomplete">
																	<input type="text" autocomplete="off" value=""
																		id="chargeCodeName" class="form-control border-input"
																		name="chargeCodeName"
																		onKeyPress="autoCompleteCommonUp(this,1);" size="44"
																		onblur="populateChargeCode(this.value,'1',this);" /> <input
																		type="hidden" id="qty" tabindex="1" name="qty1"
																		size="10" maxlength="6" validate="Qty,num,no" /> <input
																		type="hidden" tabindex="1" id="chargeCodeCode"
																		name="chargeCodeCode" size="10" readonly /> <input
																		type="hidden" name="investigationIdValue" value=""
																		id="investigationIdValue" /> <input type="hidden"
																		name="dgOrderDtIdValue" value="" id="dgOrderDtIdValue" />
																	<input type="hidden" name="dgOrderHdId" value=""
																		id="dgOrderHdId" /> <input type="hidden"
																		name="dgResultHdId" value="" id="dgResultHdId" /> <input
																		type="hidden" name="dgResultDtId" value=""
																		id="dgResultDtId" />
																		 <input type="hidden" name="investigationType" value=""
																		id="investigationType" />
																</div>
															</td>
															<td id="uomIds"><input type="text" name="UOM"
																id="UOM" class="form-control" readonly></td>
															<td id="resultdiv"></td>
															<td><input type="text" name="range" value=""
																id="range" class="form-control"></td>
															<td style="display:none"><input type="file" name="fileInvUpload"
																id="fileInvUpload" value=""></td>
															<td>
																<button name="Button" type="button"
																	class="buttonAdd btn btn-primary noMinWidth"
																	button-type="add" value=""
																	onclick="addRowForInvestigationFunUp();" tabindex="1"></button>
															</td>
															<td>
																<button type="button" name="delete" value=""
																	id="newInvestigationId"
																	class="buttonDel btn btn-danger noMinWidth"
																	button-type="delete"
																	onclick="removeRowInvestigationUp(this);"></button>
															</td>
														</tr>
													</tbody>
												</table>
											</div>
											<div id="fileUploadDynamic">
											<input type="hidden" name="dynamicUploadInvesId" id="dynamicUploadInvesId"/>
											<input type="hidden" name="dynamicUploadInvesIdAndfile" id="dynamicUploadInvesIdAndfile"/>
											<input type="hidden" name="dynamicFileUploadId" id="dynamicFileUploadId" value="investUploadDynamic"/>
											<input type="hidden" name="uploadNewBuutonId" id="uploadNewBuutonId" value="uploadNewFile"/>
											<input type="hidden" name="fileNameId" id="fileNameId" value="fileInvUploadDyna"/>
											<input type="hidden" name="radioCheckId" id="radioCheckId" value="radioFileUpload"/>
											 <input type="hidden" name="countFileUploadVal" id="countFileUploadVal" value="1"/>
											  <input type="hidden" name="checkForRemove" id="checkForRemove" value="1"/>
											  <input type="hidden" name="mainChargeCodeForFile" id="mainChargeCodeForFile" value=""/>
											   <input type="hidden" name="mainChargeCodeForFileWithChargeCode" id="mainChargeCodeForFileWithChargeCode" value=""/>
										  
											<table
													class="table table-hover table-striped table-bordered">
													<thead class="bg-primary">
														<tr>
															<th>Mark</th>
															<th>Investigation Name</th>
															<th>File Upload</th>
															<th>Upload New File</th>
															<th>Action</th>
														</tr>
													</thead>
													<tbody id="fileUploadforInvesDynamic">
														<tr>
															 <td>
																<div class="form-check form-check-inline cusRadio m-l-10">													
																	<input class="form-check-input" type="radio" id="radioFileUpload" name="radioFileUpload" onClick="return updateNewIdWhenRadioCheck(this);">
																	<span class="cus-radiobtn"></span>
																</div>
															</td> 
															<td>
																
																<textarea class="form-control" id="investUploadDynamic" readonly="readonly"> </textarea>
																
															</td>

											  				<td>
											  				<div class="fileUploadDiv">
												  				<input type="file" name="fileInvUploadDyna"
																	id="fileInvUploadDyna" value="" class="inputUpload" onchange="return getFileUploadData(this);" disabled>
												  					<label class="inputUploadlabel">Choose File</label>
																	<span class="inputUploadFileName">No File Chosen</span>
		                                					</div>
											  				</td>
											  				<td>
																<button type="button" name="uploadNewFile"  id="uploadNewFile" value="uploadNewFile"
																	class="buttonAdd btn btn-primary noMinWidth"
																	button-type="add" onClick="return getNewUploadFile(this);"></button>
															</td>
															
											  				<td>
																<button type="button" name="deleteRowForFile" value=""
																	id="deleteRowForFile"
																	class="buttonDel btn btn-danger noMinWidth"
																	button-type="delete"
																	onclick="removeFile(this);"></button>
															</td>
								
											  			</tr>
													</tbody>
												</table>
											
											
											
											</div>
											
											
											<!-- /////////////////////////////////////////////////////// -->
											<div class="opdMain_detail_area m-t-10" id="precriAndNivAndFileUp">
											<h4 class="service_htext">Prescription Details</h4>	
											<div class="table-responsive" id="precriptionDetailVal">
											<table class="table table-bordered m-t-10" align="center"
												cellpadding="0" cellspacing="0">
												<tr>
													<th>Nomenclature/PVMS No.</th>
													<th scope="col">Disp. Unit</th>
													<th scope="col">Dosage<span>*</span></th>
													<th scope="col">Frequency<span>*</span></th>
													<th scope="col">Days<span>*</span></th>
													<th scope="col">Total<span>*</span></th>
													<th scope="col">Instruction</th>
													<th style="display: none;">Disp/Store Stock</th>
												    <th style="display: none;">NIS</th>
												    <th style="display: none;">Immunization</th>
													<th scope="col">Add</th>
													<th scope="col">Delete</th>

												</tr>
												<tbody id="nomenclatureGrid">
													<tr>

														<td>
															<div class="autocomplete forTableResp">
																<!-- <input type="text" autocomplete="never" value="" tabindex="1"
																	id="nomenclature1" size="77" name="nomenclature1"
																	class="form-control border-input width330" onKeyPress="autoCompleteCommon(this,2);"
																	onblur="populatePVMSTreatment(this.value,'1',this);" />
																 -->
																
																<input type="text" autocomplete="never" value="" tabindex="1"
																	id="nomenclature1" size="77" name="nomenclature1"
																	class="form-control border-input width330" onKeyUp="getNomenClatureList(this,'populatePVMSTreatment','opd','getMasStoreItemList','numenclature');"/>
																	
																<input type="hidden" name="itemId" value=""
																	id="nomenclatureId" /> <input type="hidden"
																	name="prescriptionHdId" value="" id="prescriptionHdId" />
																<input type="hidden" name="prescriptionDtId" value=""
																	id="precriptionDtId" />
															<input type="hidden" name="statusOfPvsms" id="statusOfPvsms" value=""/>
																	<div id="nomenclatureIdPvs" class="autocomplete-itemsNew"></div>
															</div>
														</td>

														<td><input type="text" name="dispensingUnit1"
															tabindex="1" id="dispensingUnit1" size="6"
															validate="AU,string,no" readonly="readonly" class="form-control width80"/></td>

														<td><input type="text" name="dosage1" tabindex="1"
															value="" id="dosage1" size="5" maxlength="5"  onblur="fillValueNomenclature('1')" class="form-control width60"/></td>

														<td><select name="frequencyTre" id="frequencyTre" onchange="fillValueNomenclature('1')"
															class="medium form-control width150">

														</select></td>

														<td><input type="text"  class="form-control width60" name="noOfDays1" tabindex="1"
															id="noOfDays1" onblur="fillValueNomenclature('1')"
															size="5" maxlength="3" validate="No of Days,num,no" /></td>

														<td><input  class="form-control width70"  type="text" name="total1" tabindex="1"
															id="total1" size="5" validate="total,num,no"
															onblur="treatmentTotalAlert(this.value,1)" /></td>

														<td><input  class="form-control width80" type="text" name="remarks1" tabindex="1"
															id="remarks1" size="10" maxlength="15"
															/></td>

														<td style="display: none;"><input  class="form-control width80" type="text" name="closingStock1"
															tabindex="1" value="" id="closingStock1" size="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
															validate="closingStock,string,no" /></td>
														
														<td style="display: none;" class="text-center" >
														<div class="form-check form-check-inline cusCheck m-l-10">
														  <input type="checkbox" name="nis" id="nisCheck" tabindex="1" class="radioAuto form-check-input" value="1" />
														  <span class="cus-checkbtn"></span>
	                                                      </div>
													  </td>
                                                      
                                                      <td style="display: none;"class="text-center">
                                                      
                                                      <div class="form-check form-check-inline cusCheck m-l-10">
                                                      <input type="checkbox" name="immunization" id="immCheck" tabindex="1" class="radioAuto form-check-input" value="1" />
                                                      <span class="cus-checkbtn"></span>
                                                      </div>
													  </td>	
														
														
														
														<td style="display: none;"><input type="hidden"
															value="" tabindex="1" id="itemIdNom" size="77"
															name="itemIdNom" /></td>
														<td>

															<button type="button" class="btn btn-primary buttonAdd noMinWidth"
																name="button" button-type="add" value=""
																onclick="addNomenclatureRowRecall();" tabindex="1"></button>

														</td>
														<td>


															<button type="button" class="buttonDel  btn btn-danger noMinWidth"
																name="button" button-type="delete" id="newIdTre" value="" tabindex="1"
																onclick="deleteInvestAndReferalValueRow(this,10,0);"></button>

														</td>
														<td style="display: none;"><input type="hidden"
															name="pvmsNo1" tabindex="1" id="pvmsNo1" size="10"
															readonly="readonly" />
															</td>
													<td style="display: none;"><input type="hidden"
														name="itemClassId" tabindex="1" id="itemClassId" size="10"
														readonly="readonly" /></td>	
													</tr>

												</tbody>
												<tr>
											</table>
											</div>
											
											
											
										<h6 class="text-theme font-weight-bold text-underline">NIV</h6> 
										<div class="table-responsive" id="nivDetails">
										<table class="table verticalAlignTD " align="center"
											cellpadding="0" cellspacing="0" id="dgNipGrid">
											<tr>
												<th  style="width: 458px; ">NIV</th>
												<th style="width: 538px; ">New NIV</th>
												<th style="width: 235px; ">Class<span>*</span></th>
												<th style="width: 235px; ">A/U<span>*</span></th>
												<th style="width: 210px; display:none ">Disp. Unit</th>
												<!-- <th style="width: 210px; ">UOM Qty</th> -->
												<th style="width: 210px; ">Dosage<span>*</span></th>
												<th style="width: 235px; ">Frequency<span>*</span></th>
												<th style="width: 210px; ">Days<span>*</span></th>
												<th style="width: 210px; ">Total<span>*</span></th>
												<th style="width: 210px; ">Instructions</th>
												<th>Add</th>
												<th>Delete</th>

											</tr>
											<tbody id="nipGrid">
												<tr>

													<td>
														<div class="autocomplete forTableResp">
															<!-- <input type="text" value="" tabindex="1" autocomplete="never" spellcheck="false"
																id="oldnip1"  size="50" name="oldnip1"
																class="form-control border-input width330" onKeyPress="autoCompleteCommon(this,4);"
																onblur="populatePVMSforNipRecall(this.value,'1',this);" /> -->
																
															 <input type="text" value="" tabindex="1" autocomplete="never" spellcheck="false"
																id="oldnip1"  size="50" name="oldnip1"
																class="form-control border-input width330" onKeyUp="getNomenClatureList(this,'populatePVMSforNipRecall','opd','getMasStoreItemNip','newNib');" /> 
																	
												 			<input type="hidden"  name="nivItemsVal" value="" id="nivItemsVal"/>
							 								<input type="hidden"  name="prescriptionNivHdId" value="" id="prescriptionNivHdId"/>
							 								<input type="hidden"  name="prescriptionNivDtId" value="" id="prescriptionNivDtId"/>
															<input type="hidden" name="statusOfNiv" id="statusOfNiv" value=""/>
															<div id="newNibForPVMS" class="autocomplete-itemsNew"></div>

														</div>
													</td>
													<td>
												
															<input type="text" value="" tabindex="1" 
																id="newNip1"  onBlur="diasableNIV(this);" size="50" name="newNip1"
																class="form-control border-input width200"
																 />
																 <input type="hidden" name="statusOfNewNiv" id="statusOfNiv" value=""/>
                                                       
													</td>
                                                    <td>
                                                    <select name="class1" id="class1" class="medium form-control width100" ></select>
                                                    </td> 
                                                    <td>
                                                    <select name="au1" id="au1" class="medium form-control width100" ></select>
                                                    </td> 
													<td style="display:none "><input type="text" name="dispensingUnitNip1"
														tabindex="1" id="dispensingUnitNip1" size="6"
														validate="AU,string,no" readonly="readonly"  class="form-control width100"/>
													</td>
                                                    <!-- <td><input type="text" name="uomqty1"
														tabindex="1" value="" id="uomqty1" size="3"
														class="form-control width50" />
													</td> -->
													<td><input type="text" name="dosageNip1" tabindex="1"
														value="" id="dosageNip1" onblur="fillValueNip()" size="5" maxlength="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  class="form-control width50" /></td>

													<td><select name="nipfrequency1" id="nipfrequency1" onchange="fillValueNip()"
														class="medium form-control width100">

													</select></td>

													<td><input type="text" name="noOfDaysNip1" tabindex="1"
														id="noOfDaysNip1" onblur="fillValueNip()"
														size="5" maxlength="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"   class="form-control width50" /></td>

													<td><input type="text" name="totalNip1" tabindex="1"
														id="totalNip1" size="5" validate="total,num,no"
														onblur="treatmentTotalAlert(this.value,1)"  class="form-control width50"  /></td>

													<td><input type="text" name="remarksNip1" tabindex="1"
														id="remarksNip1" size="10" maxlength="10" class="form-control width100" />
													</td>

													<td style="display: none;"><input type="hidden" name="itemIdNomNip"
														value="" tabindex="1" id="itemIdNomNip" size="77"
														/>
														</td>
													<td>

														<button type="button" class="btn btn-primary buttonAdd noMinWidth"
															name="button" button-type="add" value=""
															onclick="addNipRowRecall();" tabindex="1"></button>

													</td>
													<td>


														<button type="button" class="buttonDel  btn btn-danger noMinWidth"
															name="button" id="newNivId" button-type="delete" id="newNivId" value=""
															onclick="deleteInvestAndReferalValueRow(this,10,0);" 
															tabindex="1"></button>

													</td>
													<td style="display: none;"><input type="hidden"
														name="nippvmsNo1" tabindex="1" id="nippvmsNo1" size="10"
														readonly="readonly" /></td>
														
												</tr>

											</tbody>
											<tr>
										</table> 
										
										</div>
										<div class="row m-t-10" id="upladDocPre">
										<div class="col-md-6">
													<div class="form-group row">
														<label class="col-md-4 col-form-label">Upload File
														</label>
														<div class="col-md-6" id="uploadFileMedicalExam">
															<div class="fileUploadDiv">
																<input type="file" name="precriptionUploadFile"
																	id="precriptionUploadFile" class="inputUpload" /> <label
																	class="inputUploadlabel">Choose File</label> <span
																	class="inputUploadFileName">No File Chosen</span>
															</div>
														</div>
														<div style="display: none" class="col-md-7"
															id="viewUploadedFile"></div>
													</div>
												</div>
										</div>
										</div>
										
									<div id="supportingDocIDMAin">
										<div class="col-12 row m-t-10">
													<div class="col-12">
														<h6 class="">Medical Exam (Supporting Document)</h6>
													</div>

													<div class="col-12">
														<table
															class="table table-hover table-striped table-bordered">
															<thead>
																<tr>
																	<th>Document Type</th>
																	<th>View/Enter Result</th>
																	<th>Document Date</th>
																	<th>Upload/View File</th>
																	<th>Add</th>
																	<th>Delete</th>
																</tr>
															</thead>

															<tbody id="medicalBoardDocs">
																<tr>
																	<td class="width200"><select class="form-control"
																		id="docId" name="docId">
																			<option value="0">Select Doc</option>

																	</select> <input type="hidden" name="patientDocumentId"
																		name="patientDocumentId" value="" /></td>
																	<td class="width200"><textarea name="medicalDocs"
																			id="medicalDocs" class="form-control"
																			id="medicalDocumentsDetails"
																			style="visibility: hidden; height: 0px; margin: 0; padding: 0;"></textarea>
																		<a class="btn-link" href="Javascript:Void(0)"
																		onclick="openResultModelMedicalDocs(this);"
																		data-toggle="modal" data-target="#fileUploadModal">View/Enter
																			Result</a></td>
																		
															 
														<td>
															<div class="dateHolder">
																<input type="text" id="docDateOfExam" name="docDateOfExam"
																	class="noFuture_date form-control"
																	placeholder="DD/MM/YYYY" value="" maxlength="10"/>
															</div>
														</td>
																	
																												
																	<td>
																		<div class="fileUploadDiv">
																			<input type="file" name="medicalBoardDocsUpload"
																				value="" id="medicalBoardDocsUpload"
																				class="inputUpload"> <label
																				class="inputUploadlabel">Choose File</label> <span
																				class="inputUploadFileName">No File Chosen</span>
																		</div>
																	</td>
																	<td>
																		<button type="button"
																			class="btn btn-primary buttonAdd noMinWidth" value=""
																			button-type="add" tabindex="1"
																			onclick="addRowMBDocs()"></button>
																	</td>
																	<td>
																		<button type="button"
																			class="btn btn-danger buttonAdd noMinWidth"
																			name="deleteForSupportDocNew" value=""
																			id="deleteForSupportDocNew" button-type="delete"
																			tabindex="1"
																			onclick="deleteInvestAndReferalValueRow(this,15,'')"></button>
																	</td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
										
										</div>	
											<!-- //////////////////////////////////////////////////////////////// -->
											
											
											
											<!-- LOINC Grid View -->
									
									<div class="opdMain_detail_area m-t-10" id="lonicDetail">
									<h4 class="service_htext">LOINC</h4>		
									<div class="table-responsive">
										<table class="table table-hover table-striped table-bordered">
											<thead>
												<tr>
													<th>Local Investigation<span class="mandate"><sup>&#9733;</sup></span></th>
													<th>Component<span class="mandate"><sup>&#9733;</sup></span></th>
													<th>Property<span class="mandate"><sup>&#9733;</sup></span></th>
													<th>Timing<span class="mandate"><sup>&#9733;</sup></span></th>
													<th>System<span class="mandate"><sup>&#9733;</sup></span></th>
													<th>Scale<span class="mandate"><sup>&#9733;</sup></span></th>
													<th>Method</th>
													<th>Units<span class="mandate"><sup>&#9733;</sup></span></th>
													<th>LOINC Code</th>
													<th>LOINC Name</th>
													<th>Add</th>
													<th>Delete</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>
														<input type="text" class="form-control width220" />
													</td>
													<td>
														<input type="text" class="form-control width100"/>
													</td>
													<td>
														<input type="text" class="form-control width100" />
													</td>
													<td>
														<input type="text" class="form-control width80" />
													</td>
													<td>
														<input type="text" class="form-control width100"/>
													</td>
													
													<td>
														<select class="form-control width150">
															<option>Select</option>
															<option>Quantitative (Qn)</option>
															<option>Ordinal (Ord)</option>
															<option>Nominal (Nom)</option>
															<option>Narrative (Nar</option>
														</select>
													</td> 
													<td>
														<input type="text" class="form-control width100" />
													</td>
													<td>
														<input type="text" class="form-control width100"/>
													</td>
													<td>
														<input type="text" class="form-control width100"/>
													</td>
													<td>
														<input type="text" class="form-control width220 " />
													</td>
													<td>
														<button type="button" class="buttonAdd btn btn-primary noMinWidth" button-type="add" ></button>
													</td>
													
									  				<td>
														<button type="button" class="buttonDel btn btn-danger noMinWidth" button-type="delete"></button>
													</td>
												</tr>
												
												</tbody>										
										</table>									
									</div>
									</div>
									<!-- End -->	
											
											<div class="row m-t-20">
												<div class="col-12 text-right">

													<input type="button" id="submitInvess"
														class="btn btn-primary"
														onClick="return submitInves('inves');" value="Save"/>
														<input
														type="button" id="reset" class="btn btn-danger"
														onClick="document.location.reload(true);" value="Reset" />

												</div>
											</div>
											
										
										</form:form>
									</div>
									
																		
									
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
 </div>
 
		<div class="modal" id="messageForResult" role="dialog">
		<div class="modal-dialog  modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message
							code="lblResult" /></span>

					<button type="button" onClick="closeMessage();" class="close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div class="modal-body">
					<div class="control-group">
						<input type="hidden" name="resultIdImagin" id="resultIdImagin" />
						<div class='divErrorMsg form-group row' id='errordiv'></div>
						<div class="form-group row" id="messageForAuthenticateMessae"></div>

						<div class="row">
								 
								<div class="col-md-5">
									<div class="form-group row">
										<label class="col-sm-5 col-form-label">Date Of Entry</label>
										<div class="col-sm-7">
											<div class="dateHolder">
												<input class="noFuture_date2 form-control" type="text"
													placeholder="DD/MM/YYYY"  id="dateResult" name="dateResult" value="">
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-5">
									<div class="form-group row">
										<label class="col-sm-5 col-form-label">Entered By</label>
										<div class="col-sm-7">
											<input class="form-control form-control-sm" type="text"
												placeholder="" id="entered_by" value="<%=session.getAttribute("firstName")%>" name="entered_by" readonly>
										</div>
									</div>
								</div>

								<div class="col-md-5">
									<div class="form-group row">
										<label class="col-sm-5 col-form-label">Result Date</label>
										<div class="col-sm-7">
											<div class="dateHolder">
												<input class="noFuture_date_ResultDate  form-control" type="text"
													placeholder="DD/MM/YYYY"  id="investigationResultDateTemp" name="investigationResultDateTemp" value="">
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-5">
									<div class="form-group row">
										<label class="col-sm-5 col-form-label">Result No.</label>
										<div class="col-sm-7">
											<input class="form-control form-control-sm" type="text"
												placeholder="" id="resultNumberTemp" value="" name="resultNumberTemp" onblur="return setResultNumber(this);">
										</div>
									</div>
								</div>	
											

								<div class="col-12">
									<div class="form-group row">
										<label class="col-md-5 col-form-label">Result </label>
										<div class="col-12">
										
										<div id="editorOfResult"></div>
										
										</div>
									</div>
								</div>

						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary"  
						onClick="saveResultInText();" aria-hidden="true">
						<spring:message code="btnOK" />
					</button>
					<button class="btn btn-primary" data-dismiss="modal"
						onClick="closeMessage();" aria-hidden="true">
						<spring:message code="btnClsoe" />
					</button>
				</div>
			</div>
		</div>
	</div>	
	
	<div class="modal" id="fileUploadModal" role="dialog">
		<div class="modal-dialog  modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<span class="Message_htext"><spring:message
							code="lblMedicalExamDocuments" /></span>

					<button type="button" onClick="closeMessage();" class="close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div class="modal-body">
					<div class="control-group">
						<div class='divErrorMsg form-group row' id='errordiv'></div>
						<div class="form-group row" id="messageForAuthenticateMessae"></div>

						<div class="row">



							<div class="col-12">
								<div class="form-group row">
									<label class="col-md-5 col-form-label">Medical Exam
										Documents</label>
									<div class="col-12">
										<div class="scrollDiv400">
										<div id="editorOfUpload"></div>
										</div>
									</div>
								</div>
							</div>

						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" data-dismiss="modal"
						onClick="saveMedicalBoardInText();" aria-hidden="true">
						<spring:message code="btnOK" />
					</button>
					<button class="btn btn-primary" data-dismiss="modal"
						aria-hidden="true" onClick="closeMessage();">
						<spring:message code="btnClsoe" />
					</button>
				</div>

			</div>
		</div>
	</div>
	
<div class="modal-backdrop show" style="display: none;"></div>
<script>

var arryInvestigation = new Array();
var investigationForUom = "";
 
				function getKKKKKKKKKKKKKKKKK() {
					var radioValue = labRadioValue;
					invesRadio = radioValue;
					var pathname = window.location.pathname;
					var accessGroup = "MMUWeb";

					var url = window.location.protocol + "//"
							+ window.location.host + "/" + accessGroup
							+ "/medicalexam/getInvestigationListUOM";
						$.ajax({
								type : "POST",
								contentType : "application/json",
								url : url,
								data : JSON.stringify({
									'employeeId' : <%=userId%>,
									'mainChargeCode' : radioValue,
								}),
								dataType : 'json',
								timeout : 100000,
								success : function(res) {

									var data = res.InvestigationList;
									investigationForUom = res.InvestigationList;
									if (data != null && data.length > 0)
										for (var i = 0; i < data.length; i++) {
											var investigationNewUpdate = data[i];
											var investigationId = investigationNewUpdate[0];
											var investigationName = investigationNewUpdate[1];
											if (investigationNewUpdate[3] != null)
												var uomName = investigationNewUpdate[3];
											var inves = investigationName
													+ "["
													+ investigationId
													+ "]"
											arryInvestigation
													.push(inves);

										}
								},
								error : function(jqXHR, exception) {
									var msg = '';
									if (jqXHR.status === 0) {
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
										msg = 'Uncaught Error.\n'
												+ jqXHR.responseText;
									}
									alert(msg);
								}
							});
				}




var charge_code_array = [];
var ChargeCode = '';
var multipleChargeCode = new Array();
function populateChargeCode(val, count, item) {

	//	if(validateMetaCharacters(val)){

	if (val != "") {

		var index1 = val.lastIndexOf("[");
		var indexForChargeCode = index1;
		var index2 = val.lastIndexOf("]");
		index1++;
		ChargeCode = val.substring(index1, index2);

		var indexForChargeCode = indexForChargeCode--;
		if (ChargeCode == "") {
			return;
		} else {
			var uomName = '';
			var minNormalValue = "";
			var maxNormalValue = "";
			for (var i = 0; i < investigationForUom.length; i++) {
				// var pvmsNo1 = data[i].pvmsNo;
				var masInvestigationValues = investigationForUom[i];
				var chargeCodeUom = masInvestigationValues[0];
				var investigationType="";
				var mainChargeCodeIds="";
				var subChargeCodeIds="";
				if (ChargeCode == chargeCodeUom) {

					if (masInvestigationValues[2] != null
							&& masInvestigationValues[2] != "")
						investigationType = masInvestigationValues[2];//UOM Name;
					
					if (masInvestigationValues[3] != null
							&& masInvestigationValues[3] != "")
						uomName = masInvestigationValues[3];//UOM Name;

					if (masInvestigationValues[5] != null
							&& masInvestigationValues[5] != "")
						minNormalValue = masInvestigationValues[5];//minNormalValue;

					if (masInvestigationValues[6] != null
							&& masInvestigationValues[6] != "")
						maxNormalValue = masInvestigationValues[6];//minNormalValue;
					var minMaxValue = minNormalValue + "-"
							+ maxNormalValue;

					
					if (masInvestigationValues[7] != null
							&& masInvestigationValues[7] != "")
						subChargeCodeIds = masInvestigationValues[7];// subCharge Code Id
				
						
						if (masInvestigationValues[8] != null
								&& masInvestigationValues[8] != "")
							mainChargeCodeIds = masInvestigationValues[8];//Main charge code id
					
					
					var checkCurrentRowIddd = $(item).closest('tr')
							.find("td:eq(1)").find("input:eq(3)").attr("id");
					var checkCurrentRow = $(item).closest('tr').find("td:eq(1)").find("input:eq(3)").val();
					var count = 0;
					var checkForDuplicate=0;
					$('#dgInvetigationGrid tr').each(
									function(i, el) {
										var $tds = $(this).find('td');
										var chargeCodeId = $($tds).closest('tr').find("td:eq(1)").find("input:eq(3)").attr("id");
										var chargeCodeIdValue = $('#' + chargeCodeId).val();
										var idddd = $(item).closest('tr').find("td:eq(1)").find("input:eq(3)").attr("id");
										var currentidddd = $(item).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
										if (chargeCodeId != checkCurrentRowIddd
												&& ChargeCode == chargeCodeIdValue) {
											if (ChargeCode == chargeCodeIdValue) {
												alert("Investigation is already added");
												checkForDuplicate++;
												$('#' + idddd).val("");
												$('#' + currentidddd).val("");
												$('#'+ chargeCodeIdValue).val("");
												return false;
											}
										} else {
											$(item).closest('tr').find("td:eq(1)").find("input:eq(3)").val(ChargeCode);
											$(item).closest('tr').find("td:eq(2)").find("input:eq(0)").val(uomName);
											$(item).closest('tr').find("td:eq(4)").find("input:eq(0)").val(minMaxValue);
											$(item).closest('tr').find("td:eq(1)").find("input:eq(8)").val(investigationType);
											
											$(item).closest('tr').find("td:eq(1)").find("input:eq(9)").val(subChargeCodeIds);
											$(item).closest('tr').find("td:eq(1)").find("input:eq(10)").val(mainChargeCodeIds);
										}
									});
					
					if(investigationType!=""  && ( investigationType=='s' ||investigationType=='t') ){
							var idResult= $(item).closest('tr').find("td:eq(3)").find("input:eq(1)").attr("id");
							 $('#'+idResult).val("@@@###");
							}
					if(investigationType!="" &&  checkForDuplicate==0  && investigationType=='m' && ChargeCode!="")
						getSubInvestigationHtml(ChargeCode,item);
				}
			}
		}

	}
}

$(function() {
	$("#editorOfResult").jqte();
	$("#editorOfUpload").jqte();
	getDocumentListDoc();

})

var todayDate="";
	$(document).ready(function() {
		todayDate = new Date();
	var dd = String(todayDate.getDate()).padStart(2, '0');
	var mm = String(todayDate.getMonth() + 1).padStart(2, '0');
	var yyyy = todayDate.getFullYear();

	//today =  yyyy + '-' + mm + '-' +dd;

	todayDate = dd + '/' + mm + '/' + yyyy;
	//document.write(today);
	$('#dateResult').val(todayDate);
});
	
	
    function populatePVMSTreatment(val, inc,item) {
		if (val != "") {
			var index1 = val.lastIndexOf("[");
			var indexForBrandName = index1;
			var index2 = val.lastIndexOf("]");
			index1++;
			pvmsNo = val.substring(index1, index2);
			var indexForBrandName = indexForBrandName--;
			var brandName = val.substring(0, indexForBrandName);
			if (pvmsNo == "") {
				return false;
			} 
			else
			{
				//document.getElementById('pvmsNo' + inc).value = pvmsNo
				  var pvmsValue = '';
		     	  for(var i=0;i<autoVsPvmsNo.length;i++){
		     		 // var pvmsNo1 = data[i].pvmsNo;
		     		 var masItemIdValue= autoVsPvmsNo[i];
		     		 var pvmsNo1=masItemIdValue[1];
		     		 var itemClassId=masItemIdValue[5];
		     		  if(pvmsNo1 == pvmsNo){
		     			  pvmsValue = masItemIdValue[3];//data[i].dispUnit;
		     			  itemIdPrescription =masItemIdValue[0]; //data[i].itemId;
		     			  itemIds = itemIdPrescription;
		     			  
		     			var checkCurrentNomRowId=$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").attr("id");
	      			   var checkCurrentNomRowVal=$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val();  
	      			   
	      			 checkCurrentNomRowVal=$('#'+checkCurrentNomRowId).val();
		     			$('#nomenclatureGrid tr').each(function(i, el) {
		     			   var $tds = $(this).find('td')
		  			       var itemIdCheck=  $($tds).closest('tr').find("td:eq(0)").find("input:eq(1)").attr("id");
		     			   var itemIdValue=$('#'+itemIdCheck).val();
		     			   var idddd =$(item).closest('tr').find("td:eq(0)").find("input:eq(1)").attr("id");
		     			   var currentidddd=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
		     			   if(itemIdCheck!=checkCurrentNomRowId)	   
	 			           {
		     				 if(itemIds==itemIdValue){
		      			        $('#'+idddd).val("");
		      			        $('#'+currentidddd).val("");
		      			      	alert("Nomenclature is already added");
		      			        return false;
		     				   
	 			           }
	 			           }
		     			   else
		     			   {
		     				  $(item).closest('tr').find("td:eq(0)").find("input:eq(1)").val(itemIds); 
		     				 $(item).closest('tr').find("td:eq(1)").find("input:eq(0)").val(pvmsValue); 
		     				
		     				  $(item).closest('tr').find("td:eq(10)").find(":input").val(itemIds)
 		       	     	     if(itemClassId==null)
 		       	     	     {
 		       	     	        $(item).closest('tr').find("td:eq(5)").find(":input").val("1")
 		       	     	     }
 		       	     	     else
 		       	     	     {
 			       	     	     $(item).closest('tr').find("td:eq(14)").find(":input").val(itemClassId)
 		       	     	    	 $(item).closest('tr').find("td:eq(5)").find(":input").val("") 
 		       	     	     }
		     			   }	   
		     				
		     			}); 
		     		  }
		     	  }	
		     	
	           
				return true;

			}

		} 
		else
		{
			return false;
		}
	}
    	
    var n=0;
    function addNipRowRecall() {
    	
    	var tbl = document.getElementById('nipGrid');
    		var lastRow = tbl.rows.length;
    		n=lastRow+1;
       	var aClone = $('#nipGrid>tr:last').clone(true)
    	aClone.find(":input").val("");
    	//aClone.find('input[type="text"]').prop('id', 'newNip1'+n+'');
    	aClone.find("td:eq(0)").find(":input").prop('id', 'oldnip1'+n+'');
    	aClone.find("td:eq(1)").find(":input").prop('id', 'newNip1'+n+'');
    	aClone.find("td:eq(2)").find("select:eq(0)").prop('id', 'class1'+n+''); 
    	aClone.find("td:eq(3)").find("select:eq(0)").prop('id', 'au1'+n+'');
    	aClone.find("td:eq(4)").find(":input").prop('id', 'dispensingUnitNip1'+n+'');
    	aClone.find("td:eq(5)").find("input").prop('id', 'dosageNip1'+n+'');
    	aClone.find("td:eq(6)").find("select:eq(0)").prop('id', 'nipfrequency1'+n+'');
    	
    	aClone.find("td:eq(7)").find("input").prop('id', 'noOfDaysNip1'+n+'');
    	aClone.find("td:eq(8)").find("input").prop('id', 'totalNip1'+n+'');
    	aClone.find("td:eq(9)").find("input").prop('id', 'remarksNip1'+n+'');
    	
//    	aClone.find('input[type="text"]').removeAttr('disabled');
    	  aClone.find("td:eq(0)").find("div").find("div").prop('id', 'newNibForPVMS' + n + '');
    	
    	aClone.find("td:eq(2)").find("select:eq(0)").find("option[selected]").removeAttr('selected');
    	aClone.find("td:eq(3)").find("select:eq(0)").find("option[selected]").removeAttr('selected');
    	aClone.find("td:eq(2)").find("select:eq(0)").removeAttr('disabled');
    	aClone.find("td:eq(3)").find("select:eq(0)").removeAttr('disabled');
    	
    	//aClone.find('input[type="text"]').removeAttr("readonly", false);
    	//aClone.find('option[type="select"]').removeAttr('disabled');
    	aClone.find("td:eq(10)").find(":input").prop('id', 'itemIdNomNip'+n+'');
    	aClone.find("option[selected]").removeAttr("disabled")
    	
    	
    	
    		aClone.find("td:eq(0)").find("input:eq(0)").removeAttr("readonly",false);
    			aClone.find("td:eq(1)").find("input:eq(0)").removeAttr("readonly",false);
    			aClone.find("td:eq(1)").find("input:eq(0)").removeAttr("readonly",false);
    			aClone.find("td:eq(2)").find("select:eq(0)").removeAttr('readonly',false);
    			aClone.find("td:eq(3)").find("select:eq(0)").removeAttr("readonly",false);
    			aClone.find("td:eq(3)").find("select:eq(0)").removeAttr("readonly",false);
    			aClone.find("td:eq(4)").find("select:eq(0)").removeAttr("selected",false);
    			
    			aClone.find("td:eq(5)").find("input:eq(0)").removeAttr("readonly",false);
    			aClone.find("option[selected]").removeAttr("disabled");
    			aClone.find("td:eq(6)").find("select:eq(0)").removeAttr("readonly",false);
    			
    			
    			aClone.find("td:eq(7)").find("input:eq(0)").removeAttr("readonly",false);
    			aClone.find("td:eq(8)").find(":input:eq(0)").removeAttr("readonly",false);
    			aClone.find("td:eq(9)").find(":input:eq(0)").removeAttr("readonly",false);
    			
    			aClone.find("td:eq(12)").find("button:eq(0)").removeAttr("readonly",false);
    	
    	
    	
    			aClone.find("td:eq(0)").find("input:eq(0)").removeAttr("disabled",false);
    			aClone.find("td:eq(1)").find("input:eq(0)").removeAttr("readonly",false);
    			aClone.find("td:eq(1)").find("input:eq(0)").removeAttr("disabled",false);
    			aClone.find("td:eq(2)").find("select:eq(0)").removeAttr('disabled',false);
    			aClone.find("td:eq(3)").find("select:eq(0)").removeAttr("disabled",false);
    			aClone.find("td:eq(3)").find("select:eq(0)").removeAttr("readonly",false);
    			aClone.find("td:eq(4)").find("select:eq(0)").removeAttr("selected",false);
    			
    			aClone.find("td:eq(5)").find("input:eq(0)").removeAttr("disabled",false);
    			aClone.find("option[selected]").removeAttr("disabled");
    			aClone.find("td:eq(6)").find("select:eq(0)").removeAttr("disabled",false);
    			
    			
    			aClone.find("td:eq(7)").find("input:eq(0)").removeAttr("disabled",false);
    			aClone.find("td:eq(8)").find(":input:eq(0)").removeAttr("disabled",false);
    			aClone.find("td:eq(9)").find(":input:eq(0)").removeAttr("disabled",false);
    			
    			aClone.find("td:eq(12)").find("button:eq(0)").removeAttr("disabled",false);
    			 
    	aClone.clone(true).appendTo('#nipGrid');
    	/*var valNip = $('#nipGrid>tr:last').find("td:eq(0)").find(":input")[0];
    	autocomplete(valNip, arryNomenclatureNip);*/
    	
    }
    
    var countRecall=1;
    function addNomenclatureRowRecall() {
  	  var tbl = document.getElementById('nomenclatureGrid');
			var lastRow = tbl.rows.length;
			countRecall=lastRow+1;
   		var aClone = $('#nomenclatureGrid>tr:last').clone(true)
   		aClone.find(":input").val("");
   		//aClone.find('input[type="text"]').prop('id', 'nomenclature'+countRecall+'');
   		aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'nomenclature'+countRecall+'');
   		aClone.find("td:eq(0)").find("input:eq(1)").prop('id', 'nomenclatureId'+countRecall+'');
   		aClone.find("td:eq(0)").find("input:eq(2)").prop('id', 'prescriptionHdId'+countRecall+'');
   		aClone.find("td:eq(0)").find("input:eq(3)").prop('id', 'precriptionDtId'+countRecall+'');
   		aClone.find("td:eq(0)").find("div").find("div").prop('id', 'nomenclatureIdPvs' + countRecall + '');
   		
   		aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'dispensingUnit1'+countRecall+'');
   		aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'dosage1'+countRecall+'');
   		
   		aClone.find("td:eq(3)").find("input:eq(0)").prop('id', 'frequencyTre'+countRecall+'');
   		aClone.find("td:eq(4)").find("input:eq(0)").prop('id', 'noOfDays1'+countRecall+'');
   		
   		
   		aClone.find("td:eq(5)").find("input:eq(0)").prop('id', 'total1'+countRecall+'');
   		aClone.find("td:eq(6)").find("input:eq(0)").prop('id', 'noOfDays1'+countRecall+'');
   	
   		
   		aClone.find("td:eq(7)").find("input:eq(0)").prop('id', 'remarks1'+countRecall+'');
   		aClone.find("td:eq(8)").find("input:eq(0)").prop('id', 'nisCheck'+countRecall+'');
   		aClone.find("td:eq(9)").find("input:eq(0)").prop('id', 'immCheck'+countRecall+'');
   		
   		aClone.find("option[selected]").removeAttr("selected")
   		
   		
   			aClone.find("td:eq(0)").find("input:eq(0)").removeAttr("readonly",false);
			//aClone.find("td:eq(1)").find("input:eq(0)").removeAttr("disabled",false);
			aClone.find("td:eq(2)").find("input:eq(0)").removeAttr("readonly",false);
			//aClone.find("td:eq(3)").find(":selected").removeAttr("selected",false);
			aClone.find("td:eq(3)").find("select:eq(0)").removeAttr('readonly',false);
			aClone.find("td:eq(4)").find("input:eq(0)").removeAttr("readonly",false);
			aClone.find("td:eq(5)").find("input:eq(0)").removeAttr("readonly",false);
			aClone.find("td:eq(6)").find("input:eq(0)").removeAttr("readonly",false);
			
			//aClone.find("checkbox").removeAttr("checked",false);
			aClone.find("td:eq(7)").find("input:eq(0)").removeAttr("readonly",false);
			aClone.find("td:eq(8)").find(":checkbox").removeAttr("readonly",false);
			aClone.find("td:eq(9)").find(":checkbox").removeAttr("readonly",false);
			aClone.find("td:eq(8)").find(":checkbox").removeAttr("checked",false);
			aClone.find("td:eq(9)").find(":checkbox").removeAttr("checked",false);
			
			
			aClone.find("td:eq(12)").find("button:eq(0)").removeAttr("readonly",false);
   		
   		
   		
			aClone.find("td:eq(0)").find("input:eq(0)").removeAttr("disabled",false);
			//aClone.find("td:eq(1)").find("input:eq(0)").removeAttr("disabled",false);
			aClone.find("td:eq(2)").find("input:eq(0)").removeAttr("disabled",false);
			//aClone.find("td:eq(3)").find(":selected").removeAttr("selected",false);
			aClone.find("td:eq(3)").find("select:eq(0)").removeAttr('disabled',false);
			aClone.find("td:eq(4)").find("input:eq(0)").removeAttr("disabled",false);
			aClone.find("td:eq(5)").find("input:eq(0)").removeAttr("disabled",false);
			aClone.find("td:eq(6)").find("input:eq(0)").removeAttr("disabled",false);
			
			//aClone.find("checkbox").removeAttr("checked",false);
			aClone.find("td:eq(7)").find("input:eq(0)").removeAttr("disabled",false);
			aClone.find("td:eq(8)").find(":checkbox").removeAttr("disabled",false);
			aClone.find("td:eq(9)").find(":checkbox").removeAttr("disabled",false);
			aClone.find("td:eq(8)").find(":checkbox").removeAttr("checked",false);
			aClone.find("td:eq(9)").find(":checkbox").removeAttr("checked",false);
			
			
		
			var addButton="";
			var removeButton="";
			addButton = ' <button name="Button" type="button"';
			addButton += '	class="buttonAdd btn btn-primary noMinWidth" value="" button-type="add" onclick="addNomenclatureRowRecall();"';
			addButton += '	tabindex="1" > </button> ';

			removeButton = ' <button type="button" name="delete" id="newIdTre" button-type="delete" value=""';
			removeButton += 'class="buttonDel btn btn-danger noMinWidth"';
			removeButton += '	onclick="deleteInvestAndReferalValueRow(this,10,0);"';
			removeButton += '	tabindex="1" ></button> ';
    		aClone.find("td:eq(11)").html(addButton);
  		aClone.find("td:eq(12)").html(removeButton);
  		aClone.find("td:eq(12)").find("button:eq(0)").removeAttr("disabled",false);
  		aClone.find("td:eq(14)").find(":input").prop('id', 'itemClassId'+countRecall+'');
			aClone.clone(true).appendTo('#nomenclatureGrid');
   		$('#nomenclatureGrid>tr:last').find("td:eq(12)").find('button:eq(0)').attr("id","newIdTre");
   	}
    
    
    var nipPvmsNo = '';
    function populatePVMSforNipRecall(val,inc,item) {
    	if (val != "") {
    		
    		var index1 = val.lastIndexOf("[");
    		var indexForBrandName = index1;
    		var index2 = val.lastIndexOf("]");
    		index1++;
    		nipPvmsNo = val.substring(index1, index2);
    		var indexForBrandName = indexForBrandName--;
    		var brandName = val.substring(0, indexForBrandName);
    		// alert("pvms no--"+pvmsNo)

    		if (nipPvmsNo == "") {
    			// alert("pvms no1111--"+pvmsNo)
    			// document.getElementById('nomenclature' + inc).value = "";
    			// document.getElementById('pvmsNo' + inc).value = "";
    			return false;
    		} else {
    			//document.getElementById('nippvmsNo' + inc).value = nipPvmsNo
    			 var itemIdNipPrescription= '';
    			  var nipPvmsValue = '';
    				  for(var i=0;i<nipDataforItem.length;i++){
    					var nipItemIdValue= nipDataforItem[i].itemId;
    					  if(nipItemIdValue == nipPvmsNo){
    						
    						  itemIdNipPrescription =nipItemIdValue //data[i].itemId;
    						  var checkCurrentNomRowIdNip=$(item).closest('tr').find("td:eq(10)").find("input:eq(0)").attr("id");
                  			  var checkCurrentNomRowValNip=$(item).closest('tr').find("td:eq(10)").find("input:eq(0)").val();  
                  			 $('#nipGrid tr').each(function(i, el) {
          	     			   var $tds = $(this).find('td')
          	  			       var itemIdCheckNip=  $($tds).closest('tr').find("td:eq(10)").find("input:eq(0)").attr("id");
          	     			   var itemIdValueNip=$('#'+itemIdCheckNip).val();
          	     			   var iddddNip =$(item).closest('tr').find("td:eq(10)").find("input:eq(0)").attr("id");
          	     			   var currentiddddNip=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
          	     			   //if(itemIds!="" &&  itemIdValue!="" && itemIdValue!="undefined" )
          	     			 
          	     			   if(itemIdCheckNip!=checkCurrentNomRowIdNip && itemIdNipPrescription==itemIdValueNip)	   
            			        {
          	     				 
          	     				 if(itemIdNipPrescription==itemIdValueNip){
          	      			        $('#'+iddddNip).val("");
          	      			        $('#'+currentiddddNip).val("");
          	      			        alert("NIV is already added");
          	      			        return false;
          	     				   
            			           }
            			           }
          	     			   else
          	     			   {
          	     			  $(item).closest('tr').find("td:eq(10)").find(":input").val(itemIdNipPrescription)
          	 				  var newNip=$(item).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
          	 				  document.getElementById(newNip).disabled = true;
          	 				  var classNip=$(item).closest('tr').find("td:eq(2)").find("select:eq(0)").attr("id");
          	 				  document.getElementById(classNip).disabled = true;
          	 				  var auNip=$(item).closest('tr').find("td:eq(3)").find("select:eq(0)").attr("id");
          	 				  document.getElementById(auNip).disabled = true;  
          	 				//var dispUnit=$(item).closest('tr').find("td:eq(4)").find("input:eq(0)").attr("id");
         	 				  //document.getElementById(dispUnit).disabled = true;  
          	     			   }	   
          	     				
          	     			}); 
          	     		  }
          	     	  }	
          	     	
                   return true;
    		}
    		}

    	 else
    	 {
    		return false;
    	}
    }
    getFrequencyDetailTre();
    getItemClass();
    getDispUnitDetail();
    var massFrequencyList='';
    function getFrequencyDetailTre() {

    	var pathname = window.location.pathname;
    	var accessGroup = "MMUWeb";
    	var url = window.location.protocol + "//" + window.location.host + "/"
    			+ accessGroup + "/opd/getMasFrequency";
    	// var url = "http://localhost:8082/AshaServices/opdmaster/getMasFrequency";
    	$.ajax({
    		url : url,
    		dataType : "json",
    		data : JSON.stringify({
    			'employeeId' : '1'
    		}),
    		contentType : "application/json",
    		type : "POST",
    		success : function(response) {
    			// console.log(response);
    			var datas = response.MasFrequencyList;
    			massFrequencyList=datas;
    			var trHTML = "";
    			var trHTMLFrequncy="";
    			trHTML += '<option value=""><strong>Select</strong></option>';
    			trHTMLFrequncy+=trHTML;
    			$.each(datas, function(i, item) {
    				trHTML += '<option value="' + item.frequencyId + '" >'
    						+ item.frequencyName + '</option>';
    			
    				trHTMLFrequncy += '<option value="' + item.feq + '@'
					+ item.frequencyId + '" >' + item.frequencyName
					+ '</option>';
	
    			
    			});
    			$('#frequencyTre').html(trHTML);
    			
    			$('#nipfrequency1').html(trHTMLFrequncy);
    		},
    		error : function(e) {

    			// console.log("ERROR: ", e);

    		},
    		done : function(e) {
    			// console.log("DONE");
    			alert("success");
    			var datas = e.data;

    		}
    	});

    }

    var trHTMLitemClass='';
    var masItemClassList="";
    function getItemClass() {

    	var pathname = window.location.pathname;
    	var accessGroup = "MMUWeb";
    	var url = window.location.protocol + "//"
    	+ window.location.host + "/" + accessGroup
    	+ "/opd/getMasItemClass";
    	
    	/*
    	 * var url =
    	 * "http://localhost:8181/AshaServices/v0.1/opdmaster/getMasFrequency";
    	 */
    	$
    			.ajax({
    				url : url,
    				dataType : "json",
    				data : JSON.stringify({
    					'employeeId' : '1'
    				}),
    				contentType : "application/json",
    				type : "POST",
    				success : function(response) {
    					console.log(response);
    					var datas = response.MasItemClassList;
    					masItemClassList= response.MasItemClassList;
    					trHTMLitemClass = '<option value=""><strong>Select...</strong></option>';
    					$.each(datas, function(i, item) {
    						trHTMLitemClass += '<option value="' + item.itemClassId + '" >' + item.itemClassName
    								+ '</option>';
    					});

    					$('#class1').html(trHTMLitemClass);
    				},
    				error : function(e) {

    					console.log("ERROR: ", e);

    				},
    				done : function(e) {
    					console.log("DONE");
    					alert("success");
    					var datas = e.data;

    				}
    			});

    }


    var trHTMLDispUnit='';
    var masDispUnitList="";
    function getDispUnitDetail() {

    	var pathname = window.location.pathname;
    	var accessGroup = "MMUWeb";
    	var url = window.location.protocol + "//"
    	+ window.location.host + "/" + accessGroup
    	+ "/opd/getMasDispUnit";
    	
    	/*
    	 * var url =
    	 * "http://localhost:8181/AshaServices/v0.1/opdmaster/getMasFrequency";
    	 */
    	$
    			.ajax({
    				url : url,
    				dataType : "json",
    				data : JSON.stringify({
    					'employeeId' : '1'
    				}),
    				contentType : "application/json",
    				type : "POST",
    				success : function(response) {
    					console.log(response);
    					var datas = response.MasItemClassList;
    					masDispUnitList= response.MasItemClassList;
    					trHTMLDispUnit = '<option value=""><strong>Select...</strong></option>';
    					$.each(datas, function(i, item) {
    						trHTMLDispUnit += '<option value="' + item.storeUnitId + '" >' + item.storeUnitName
    								+ '</option>';
    					});

    					$('#au1').html(trHTMLDispUnit);
    				},
    				error : function(e) {

    					console.log("ERROR: ", e);

    				},
    				done : function(e) {
    					console.log("DONE");
    					alert("success");
    					var datas = e.data;

    				}
    			});

    }
    function fillValueNomenclature() {
    	var TableData = new Array();
        $('#nomenclatureGrid tr').each(function(i, el) {

    		var $tds = $(this).find('td')
    		var itemClassId = $tds.eq(14).find(":input").val();
    		if(itemClassId!=null && itemClassId!='')
    		{	
    			var productId = $tds.eq(0).find(":input").val();
    			var product = $tds.eq(1).find(":input").val();
    			var dosage = $tds.eq(2).find(":input").val();
    			var frequency = $tds.eq(3).find(":input").val();
    			var splitFrequency = frequency.split("@");
    			var noofdays = $tds.eq(4).find(":input").val();
    			var Quantity2 = $tds.eq(5).find(":input").val();
    			var product3 = $tds.eq(4).find(":input").val();
    			var total = dosage * splitFrequency[0] * noofdays;
    			var t=Math.round(total);
    			$tds.eq(5).find(":input").val(t);
    		}
    		// $(').closest('tr').find("td:eq(5)").find(":input").val(total)
    		// $(item).closest('tr').find("td:eq(5)").find(":input").val(total)
    		// $('$tds.eq(5)').val($(this).val());
    		// alert("total value" + total)

    	});
    	// console.log(TableData);
    }
    function treatmentTotalAlert(val, inc) {
    	if (document.getElementById('actualDispensingQty' + inc).value != 0
    			&& val > 2)
    		alert("Total quantity  is more than 2");
    }
    function fillValueNip() {

    	var TableData = new Array();
        $('#nipGrid tr').each(function(i, el) {

    		var $tds = $(this).find('td')
    		var nipAuto = $tds.eq(0).find(":input").val();
    		var nipManual = $tds.eq(1).find(":input").val();
    		var dosage = $tds.eq(5).find(":input").val();
    		var frequency = $tds.eq(6).find(":input").val();
    		var splitFrequency = frequency.split("@");
    		var noofdays = $tds.eq(7).find(":input").val();
    		var Quantity2 = $tds.eq(5).find(":input").val();
    		var product3 = $tds.eq(4).find(":input").val();
    		var total = dosage * splitFrequency[0] * noofdays;
    		var t=Math.round(total);
    		$tds.eq(8).find(":input").val(t);
    		// $(').closest('tr').find("td:eq(5)").find(":input").val(total)
    		// $(item).closest('tr').find("td:eq(5)").find(":input").val(total)
    		// $('$tds.eq(5)').val($(this).val());
    		// alert("total value" + total)

    	});

    	// console.log(TableData);
    }

    function diasableNIV(val){
   	 var newNipVal=$(val).closest('tr').find("td:eq(1)").find("input:eq(0)").val();
   	 var idOfNewNib=$(val).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
   	if(newNipVal!=""){
   	 document.getElementById(idOfNewNib).disabled = true;
   	}
   	else{
   		document.getElementById(idOfNewNib).disabled = false;
   	}
    
   		
   }
   
 
	 function openResultModelMedicalDocs(item){
		var resultIdIm= $(item).closest('tr').find("td:eq(1)").find("textarea:eq(0)").attr("id");
		/* if(resultIdIm=="" || resultIdIm==undefined)
		 resultIdIm= $(item).closest('tr').find("td:eq(3)").find("textarea:eq(0)").attr("id"); */
		var resultView = $('#'+resultIdIm).val();
		if(resultView.includes("@@@###")){
			resultView=resultView.replace("@@@###","");
		}
	 	resultView=decodeHtml(resultView);
		$('#editorOfUpload').jqteVal(resultView);
	 	$('#fileUploadModal').show();
		$('#resultIdMedicalDocs').val(resultIdIm);
	}
	 
	 function saveMedicalBoardInText(){
		 var idOfResult=$('#resultIdMedicalDocs').val();
		 var jqetResultValue=$('#editorOfUpload').val();
		 
		 if(jqetResultValue!=""){
			 jqetResultValue=jqetResultValue.trim();
			 jqetResultValue="@@@###"+jqetResultValue;
		 }
		 
		 $('#'+idOfResult).val(jqetResultValue);
		 $('.modal').hide();
		$('.modal-backdrop ').hide();
		
	}
	 var documentListHtml='';
		var masDocumentList='';
		var masDocumentListVal='';
		var patientDocumentDetailList='';
		function getDocumentListDoc() {
			var j=1;
			var pathname = window.location.pathname;
			var accessGroup = "MMUWeb";
			var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/medicalBoard/getDocumentList";
			$.ajax({
						url : url,
						dataType : "json",
						data : JSON.stringify({
							'employeeId' : '1',
							'visitId':$('#visitId').val()
						}),
						contentType : "application/json",
						type : "POST",
						success : function(response) {
							console.log(response);
							masDocumentList = response.MasDocumentList;
							patientDocumentDetailList=response.listPatientDocumentDetail;
							var docHtml = '<option value=""><strong>Select Document...</strong></option>';
							$.each(masDocumentList, function(i, item) {
								docHtml += '<option value="' + item.documentId + '@'
										+ item.documentCode + '" >' + item.documentName
										+ '</option>';
								//$('.referSpecialistList').html(specialistHtml);
							});
							console.log("docHtml "+docHtml);
							$('#docId').html(docHtml);
							masDocumentListVal=docHtml;
							
							getPatientDocumentDetailHtml();
						},
						error : function(e) {

							console.log("ERROR: ", e);

						},
						done : function(e) {
							console.log("DONE");
							alert("success");
							var datas = e.data;

						}
					});
			
		
		}
		
		var rowId=0;
		 function addRowMBDocs() {
				var tbl = document.getElementById('medicalBoardDocs');
				lastRow = tbl.rows.length;
				rowId = lastRow;
				rowId++;
				var val = parseInt($('#medicalBoardDocs>tr:last').find("td:eq(0)").text());
				var aClone = $('#medicalBoardDocs>tr:last').clone(true)
				aClone.find(":input").val("");;
				aClone.find('img.ui-datepicker-trigger').remove();
				aClone.find("td:eq(0)").find("select:eq(0)").prop('id','docId' + rowId + '');
				aClone.find("td:eq(0)").find("input:eq(0)").prop('id', 'patientDocumentId'+rowId+'');
				aClone.find("td:eq(1)").find("textarea:eq(0)").prop('id', 'medicalDocs'+rowId+'');
				aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'docDateOfExam'+rowId+'').removeClass('noFuture_date hasDatepicker').addClass('noFuture_date');

				aClone.find("td:eq(3)").find("input:eq(0)").prop('id', 'medicalBoardDocsUpload'+rowId+'');
				aClone.find("td:eq(3)").find("input:eq(0)").prop('name', 'medicalBoardDocsUpload'+rowId+'');
				
				aClone.find("option[selected]").removeAttr("selected")
				
				var patientDetailDocFile='<div class="fileUploadDiv"><input type="file" name="medicalBoardDocsUpload'+rowId+'" id="medicalBoardDocsUpload'+rowId+'" value="" class="inputUpload"><label class="inputUploadlabel">Choose File</label><span class="inputUploadFileName">No File Chosen</span></div>';
				aClone.find("td:eq(3)").html(patientDetailDocFile);
		 
				aClone.find('button[button-type="delete"]').removeAttr('disabled');
				aClone.find('textarea').text('');
				
				aClone.clone(true).appendTo('#medicalBoardDocs');
				var val = $('#medicalBoardDocs>tr:last').find("td:eq(3)").find(":input")[0];
				$('#medicalBoardDocs>tr:last').find("td:eq(4)").find("button:eq(0)").attr("id", "newSupportDoc");
				rowId++;

			}	
		 
    </script>
</body>
</html>
