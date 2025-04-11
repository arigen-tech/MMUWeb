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
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>

<script type="text/javascript">

<%	
String userId = "1";
if (session.getAttribute("userId") != null) {
	userId = session.getAttribute("userId") + "";
}
%>



var htmlTable = "";	
nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{

            
             var data = ${empData};
            console.log(data);
           
             if (data.data.empId != null) {
                document.getElementById('empRegId').value = data.data.empId;
            } 
             
             if (data.data.apmDate != null) {
                 document.getElementById('apmDate').value = data.data.apmDate;
             } 
             if (data.data.apmName != null) {
                 document.getElementById('apmName').value = data.data.apmName;
             } 
             if (data.data.apmAction != null) {
                 document.getElementById('apmAction').value = data.data.apmAction;
                 if(data.data.apmAction == 'Rejected'){
                	 $(submitBtn).prop('disabled', true);
                	 $(audAction).prop('disabled', true);
                	 $(audRemarks).prop('disabled', true);
                 }
             } 
             if (data.data.apmRemarks != null) {
                 document.getElementById('apmRemarks').value = data.data.apmRemarks;
             } 
           
             /* --- */
             if (data.data.empName != null) {
                 document.getElementById('empName').value = data.data.empName;
             } 
             if (data.data.gender != null) {
                 document.getElementById('genderId').value = data.data.genderName;
                gender = data.data.gender;                
             } 
             if (data.data.dob != null) {
                 document.getElementById('dob').value = data.data.dob;
             } 
             if (data.data.address != null) {
                 document.getElementById('empAddress').value = data.data.address;
             } 
             if (data.data.state != null) {
                 document.getElementById('empState').value = data.data.state;
             } 
             if (data.data.district != null) {
                 document.getElementById('empDist').value = data.data.district;
             } 
             if (data.data.city != null) {
                 document.getElementById('empCity').value = data.data.city;
             } 
             if (data.data.pincode != null) {
                 document.getElementById('empPincode').value = data.data.pincode;
             } 
             if (data.data.mobileNo != null) {
                 document.getElementById('empMobile').value = data.data.mobileNo;
             } 
             if (data.data.imei != null) {
                 document.getElementById('empIMEI').value = data.data.imei;
             } 
             if (data.data.mmu != null) {
                 document.getElementById('mmuId').value = data.data.mmuName;
             } 
             
             if (data.data.empType != null) {
                 document.getElementById('empTypeId').value = data.data.empTypeName;
             } 
              
             
             if (data.data.emplyMentType != null) {
            	 var emplmnType = data.data.emplyMentType;
            	 if(emplmnType == 'P'){
                 document.getElementById('employmentTypeId').value = 'Permanent';
            	 } else{
            		 document.getElementById('employmentTypeId').value = 'Temprory';
            	 }
                 if(data.data.emplyMentType == 'P'){
             			$('#toDateDiv').hide();
             		}  else {
             			$('#toDateDiv').show();
             		}
                 
             } 
             if (data.data.identityNo != null) {
                 document.getElementById('empIdentity').value = data.data.identityNo;
             } 
             if (data.data.fromDate != null) {
                 document.getElementById('fromDate').value = data.data.fromDate;
             } 
             if (data.data.toDate != null) {
                 document.getElementById('toDate').value = data.data.toDate;
             } 
             if (data.data.age != null) {
                 document.getElementById('age').value = data.data.age;
             } 
              
             if (data.data.encodedStringImage != null) {
            	 profileImage.setAttribute('src', "data:image/jpg;base64," + data.data.encodedStringImage);
             } 
             
             if (data.data.idTypeNo != null) {
                 document.getElementById('empIdNumber').value = data.data.idTypeNo;
             } 
             if (data.data.idTypeName != null) {
                 document.getElementById('empIdType').value = data.data.idTypeName;
             } 
		    	var idString=data.data.idMimeType +"@"+data.data.idImageString;
		    	document.getElementById('viewId').value = idString;
             
		    	if(data.data.idMimeType != '' && (data.data.idMimeType == 'jpeg' || data.data.idMimeType == 'jpg' || data.data.idMimeType == 'png'
	           		 || data.data.idMimeType == 'bmp')){
		           	 $('#viewId').hide();
		           	 $('#viewId1').show();
	           		 document.getElementById('viewId1').value = idString;
	            } else {
		           	 $('#viewId1').hide();
		           	 $('#viewId').show();
	            }
		    	var qList =  data.qList ;
		         
		          var counter =1;
		          for(i=0;i<qList.length;i++){
				    	var mimeType='';
				    	var fileString='';
				    	if(qList[i].mimeType != '' && qList[i].qualFileString != ''){
				    		fileString=qList[i].mimeType +"@"+qList[i].qualFileString;
				    	}
						htmlTable = htmlTable+"<tr id='"+qList[i].qualId+"' >";			
						htmlTable = htmlTable +"<td class='width60'>"+counter+"<input  class='form-control border-input' type='hidden' id='qualId"+counter+"' value='"+qList[i].qualId+"'/></td>";
						htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control width200' type='text' name='degree"+counter+"' id='degree"+counter+"'  value='"+qList[i].qualName+"' disabled /></td>";
						htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control minWidth220' type='text' name='instName"+counter+"' id='instName"+counter+"'  value='"+qList[i].instName+"' disabled /></td>";
						htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control width200' type='text' name='completeionYear"+counter+"' id='completeionYear"+counter+"'  value='"+qList[i].completionYear+"' disabled /></td>";
						if(fileString != ''){
						htmlTable = htmlTable +"<td><a href='#' value='"+qList[i].qualFileString+"' onclick=viewUploadedFile('" + fileString + "') class='btn btn-primary'><i class='fa fa-file-alt'></i> View </a></td>"; 
						} else {
							htmlTable = htmlTable +"<td></td>";
						} 		
						htmlTable = htmlTable+"</tr>";
						counter++;
				    }
				    $j("#qualificationGrid").html(htmlTable); 
				    htmlTable = "";
				    
				    var dList =  data.dList ;
				    var dCounter =1;
				    if(dList.length > 0){
				    for(i=0;i<dList.length;i++){
				    	var mimeType='';
				    	var fileString='';
				    	if(dList[i].mimeType != '' && dList[i].docFileString != ''){
				    		fileString=dList[i].mimeType +"@"+dList[i].docFileString;
				    	}
						htmlTable = htmlTable+"<tr id='"+dList[i].docId+"' >";			
						htmlTable = htmlTable +"<td class='width60'>"+dCounter+"<input  class='form-control border-input' type='hidden' id='docId"+dCounter+"' value='"+dList[i].docId+"'/></td>";
						htmlTable = htmlTable +"<td class='minWidth220;'><input  class='form-control width200' type='text' name='docName"+dCounter+"' id='docName"+dCounter+"'  value='"+dList[i].docName+"' disabled /></td>";
						if(fileString != ''){
						 htmlTable = htmlTable +"<td><a href='#' value='"+qList[i].docFileString+"' onclick=viewUploadedFile('" + fileString + "') class='btn btn-primary'><i class='fa fa-file-alt'></i> View </a></td>"; 
						} else {
							htmlTable = htmlTable +"<td></td>";
						}
						
						htmlTable = htmlTable+"</tr>";
						dCounter++;
				    }
				    } else {
				    	htmlTable = htmlTable+"<tr id='' >";			
						htmlTable = htmlTable +"<td class='width60'></td>";
						htmlTable = htmlTable +"<td class='minWidth220;'><input  class='form-control width200' type='text' name='docName' id='docName'  value='' disabled /></td>";
						htmlTable = htmlTable +"<td></td>"; 
				    }
				    $j("#documentGrid").html(htmlTable); 
             
             /* --- */
            
		});
function viewUploadedFile(filePath){
	var tempStr = filePath.split("@");
	var mimeType = tempStr[0];
	var blob;	
	if (mimeType == 'pdf') {
	    blob = converBase64toBlob(tempStr[1], 'application/pdf');
	  } else if (mimeType == 'msword') {
	    blob = converBase64toBlob(tempStr[1], 'application/msword'); 
	  } else if(mimeType == 'jpg' || mimeType == 'jpeg' ){
		  base64toPDF(tempStr[1]);
	  }
	
	var blobURL = URL.createObjectURL(blob);
	  window.open(blobURL);
	
}
function showIdImage(imageVal){
	var tempStr = imageVal.split("@");
	var mimeType = tempStr[0];
	idImage.setAttribute('src', "data:image/"+mimeType+";base64," +tempStr[1]);
	
}
function converBase64toBlob(content,contentType) {
	  contentType = contentType || '';
	  var sliceSize = 512;
	  var byteCharacters = window.atob(content); //method which converts base64 to binary
	  var byteArrays = [
	  ];
	  for (var offset = 0; offset < byteCharacters.length; offset += sliceSize) {
	    var slice = byteCharacters.slice(offset, offset + sliceSize);
	    var byteNumbers = new Array(slice.length);
	    for (var i = 0; i < slice.length; i++) {
	      byteNumbers[i] = slice.charCodeAt(i);
	    }
	    var byteArray = new Uint8Array(byteNumbers);
	    byteArrays.push(byteArray);
	  }
	  var blob = new Blob(byteArrays, {
	    type: contentType
	  }); //statement which creates the blob
	  return blob;
	}

function base64toPDF(data) {
    var bufferArray = base64ToArrayBuffer(data);
    var blobStore = new Blob([bufferArray], { type: "application/pdf" });
    if (window.navigator && window.navigator.msSaveOrOpenBlob) {
        window.navigator.msSaveOrOpenBlob(blobStore);
        return;
    }
    var data = window.URL.createObjectURL(blobStore);
    var link = document.createElement('a');
    document.body.appendChild(link);
    link.href = data;
    link.download = "file.pdf";
    link.click();
    window.URL.revokeObjectURL(data);
    link.remove();
}

function base64ToArrayBuffer(data) {
    var bString = window.atob(data);
    var bLength = bString.length;
    var bytes = new Uint8Array(bLength);
    for (var i = 0; i < bLength; i++) {
        var ascii = bString.charCodeAt(i);
        bytes[i] = ascii;
    }
    return bytes;
}
	
	function saveAUDAction(item){
		
		///-----		
		var empRegId = $('#empRegId').val();
		var audAction = $('#audAction').val();
		var audRemarks = $('#audRemarks').val();
		
		
		
		
		if(audAction == ''){
			alert("Please select action");
			return;
		}
		if(audAction == 'R'){
		if(audRemarks == ''){
			alert("Please enter remarks");
			return;
		}
		}
		
		var params = {
				"empRegId":empRegId,
				"userId":"<%= userId %>",
				"audAction":audAction,
				"audRemarks":audRemarks,				
		}
		console.log("params:: "+JSON.stringify(params));
		$j(item).attr("disabled", true);
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "saveAUDAction",
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(data) {
				if(data.status){
					alert(data.msg+'S');
					$j(item).attr("disabled", true);
				}else{
					alert(data.msg);
					$j(item).attr("disabled", false);
				}
				
			},
			error : function(data) {
				$j(item).attr("disabled", false);
				alert("An error has occurred while contacting the server");
			}
		}); 
	}
	
	function backToWaitingList(){
		window.location = "getAuditorWaitingList";
	}
	
</script>
</head>

<body>

<!-- Begin page -->
<div id="wrapper">
	<div class="content-page">
	<!-- Start content -->	
	<div class="container-fluid">
	
		<div class="internal_Htext">Registration Approval Page(Auditor)</div>
		<input type="hidden"  name="empRegId" value= "" id="empRegId" />
	
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-body">
						<p align="center" id="messageId" style="color: green; font-weight: bold;"></p>
						
						<div class="row m-t-10">							
							<div class="col-md-12">
								<h5 class="page_head">Employee Details</h5>
							</div>
						</div>
						
												<!-- ----Employee Details--- -->
						
						
						<div class="row m-t-20">
							<div class="col-lg-9 col-sm-12">
									<div class="row">
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Employee Name</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empName" class="form-control" disabled="disabled"  />
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Gender</label>
											</div>
											<div class="col-md-7">											
											<input type="text" id="genderId" class="form-control" disabled/>												
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Date of birth</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" id="dob" class="form-control" disabled/>
													
												</div>
											</div>
										</div>
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Age</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="age" class="form-control" disabled/>
											</div>
										</div> 
									</div>
									
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Address</label>
											</div>
											<div class="col-md-7">
												<textarea class="form-control" rows='3' id="empAddress" disabled="disabled"></textarea>
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">State</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empState" class="form-control" disabled="disabled"/>
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">District</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empDist" class="form-control" disabled="disabled"/>
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empCity" class="form-control" disabled="disabled"/>
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Pincode</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empPincode" class="form-control" disabled="disabled" />
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Mobile No.</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empMobile" class="form-control" disabled="disabled" />
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">IMEI No.</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empIMEI" class="form-control" disabled="disabled" />
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">MMU</label>
											</div>
											<div class="col-md-7">
											 <input type="text" id="mmuId" class="form-control" disabled="disabled" />
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Id Type</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empIdType" name="empIdType" class="form-control" disabled="disabled" />
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Id Number</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empIdNumber" name="empIdNumber" class="form-control" disabled="disabled" />
											</div>
										</div> 
									</div>
									
									<!-- <div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Id Upload</label>
											</div>
											<div class="col-md-7">
												<div class="fileUploadDiv m-b-10">
												  	<input type="file" class="inputUpload" name="idPhoto" id="idPhoto" onblur="getBase64StringForIDandProfile(this.id,'base64ForId','profileMimeType')">
												  	<label class="inputUploadlabel">Choose File</label>
													<span id="" class="inputUploadFileName">No File Chosen</span>
													<textarea id="base64ForId" style="display: none;"></textarea>
													<input type="hidden" id="profileMimeType" name="profileMimeType" class="form-control"  />
											  	</div>
											</div>
										</div> 
									</div> -->
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">View Id</label>
											</div>
											<div class="col-md-7">
												<button type="button" id="viewId" name="viewId" value="" onclick="viewUploadedFile(this.value)"  class="btn btn-primary">View</button>
												<button type="button" id="viewId1" name="viewId1" value="" data-toggle="modal" data-target="#smallModal" data-background="static"  class="btn btn-primary"
												 onclick="showIdImage(this.value)">View</button>
											 </div>
										 </div>
									</div>
									
								</div>
							</div>
							
							<div class="col-lg-3 col-sm-4 offset-sm-4 offset-lg-0 m-t-sm-10">
								<div class="form-group row">
									<div class="col-sm-11 offset-sm-1">
										<img src="/MMUWeb/resources/images/photo_icon.png" class="profileImg" alt="" width="80%" id="profileImage">
									</div>
									<div class="col-md-11 offset-sm-1">										
										<label class="col-form-label">Profile Image</label>
									</div>
									<!-- <div class="col-md-11 offset-sm-1">
										<div class="fileUploadDiv m-b-10">
										  	<input type="file" class="inputUpload" id="empProfileImage" >
										  	<label class="inputUploadlabel">Choose File</label>
											<span id="spanInputUploadFileName" class="inputUploadFileName">No File Chosen</span>
									  	</div>
									</div> -->
								</div>
							</div>
						
						
						</div>
						
						<div class="row m-t-10">
							<div class="col-lg-9 col-sm-12">
								<div class="row">
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Type of Employee</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empTypeId" class="form-control" disabled="disabled" />
												
											</div>
										</div> 
									</div>
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Type of Employment</label>
											</div>
											<div class="col-md-7">
											  <input type="text" id="employmentTypeId" class="form-control" disabled="disabled" />
												
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Registration No.</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empIdentity" class="form-control" disabled="disabled"/>
											</div>
										</div> 
									</div>
									
								</div>
							</div>
							
						</div>
						
						<div class="row">
							<div class="col-lg-9 col-sm-12">
								<div class="row">
									<div class="col-md-12">
										<h6 class="font-weight-bold text-theme text-underline">Period of Employment</h6>
									</div>
							
									<div class="col-md-6" id="fromDateDiv">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">From Date</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
												<input type="text" id="fromDate" class="form-control" disabled="disabled" />
												
												</div>
											</div>
										</div>
									</div>
									
									<div class="col-md-6">
										<div class="form-group row" id="toDateDiv">
											<div class="col-md-5">
												<label class="col-form-label">To Date</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
												  <input type="text" id="toDate" class="form-control" disabled="disabled" />
												</div>
											</div>
										</div>
									</div>
									
									
								</div>
							</div>
						</div>
						
						<div class="row m-t-20">
							<div class="col-md-12">
								<h6 class="font-weight-bold text-theme text-underline">Educational Qualification</h6>
							</div>
							
							<div class="col-12">
								<div class="table-responsive">
									<table class="table table-striped table-hover table-bordered " id="qualificationTable">
		                                  <thead>		                                      
		                                      <tr>
		                                          <th>S.No.</th>
		                                          <th>Degree</th>
		                                          <th>Name of Institution</th>
		                                          <th>Year of Completion</th>
		                                          <th>View File</th>
		                                      </tr>
		                                  </thead>
		                                
		                   				 <tbody id="qualificationGrid"> </tbody>
	                                  </table>
                                 </div>
							</div>
						</div>
						
						<div class="row m-t-10">
							<div class="col-md-12">
								<h6 class="font-weight-bold text-theme text-underline">Required Documents</h6>
							</div>
							
							<div class="col-12">
							<div class="table-responsive">
								<table class="table table-striped table-hover table-bordered ">
		                                  <thead>		                                      
		                                      <tr>
		                                          <th>S.No.</th>
		                                          <th>Document Name</th>
		                                          <th>View File</th>
		                                      </tr>
		                                  </thead>
		                                  <tbody id="documentGrid">
		                                
		                   				 </tbody>
	                                  </table>
							</div>
							</div>
						</div>
						
						
			
						
						<!-- ----Employee Details end--- -->
						<div class="row m-t-10">							
							<div class="col-md-12">
								<h6 class="font-weight-bold text-theme text-underline ">APM's Details</h6>
							</div>
						</div>
						
						<div class="row">
						<div class="col-lg-9 col-sm-12">
										<div class="row">
									<div class="col-md-6">
										<div class="form-group row">
											<label class="col-sm-5 col-form-label">Date</label>
											
											<div class="col-sm-7">
												<div class="dateHolder ">
												
												<input type="text" id="apmDate" class="form-control" disabled="disabled" />
													
												</div>
											</div>
										</div>
									</div>
								
								
								<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Name</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="apmName" class="form-control" disabled="disabled" />
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Action</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="apmAction" class="form-control" disabled="disabled" />
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Remarks</label>
											</div>
											<div class="col-md-7">
												<textarea class="form-control" rows="3" id="apmRemarks" disabled="disabled"></textarea>
											</div>
										</div> 
									</div>
									
						
								<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Action</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="audAction">
													<option value="" selected>Select</option>
													<option value="A">Approve</option>
													<option value="R">Reject</option>
												</select>
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Remarks</label>
											</div>
											<div class="col-md-7">
												<textarea class="form-control" rows="3" id="audRemarks" ></textarea>
											</div>
										</div> 
									</div>
								</div>
								</div>
						</div>
						
						
						
						
						
						<div class="row m-t-20">
							<div class="col-12 text-right">
								<button type="button" class="btn btn-primary" id="submitBtn" onclick="saveAUDAction(this)">Submit</button>
								<button type="button" class="btn btn-primary" id="backBtn"  onclick="backToWaitingList()">Back</button>
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

<div class="modal fade" id="smallModal" tabindex="-1" role="dialog" aria-labelledby="smallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title font-weight-bold">Image</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body text-center">
       <div class="col-12">
							<h6 class="font-weight-bold text-theme text-underline">Id Proof Photo</h6>
							<img src="/MMUWeb/resources/images/photo_icon.png" class="profileImg" alt="" width="100%" id="idImage">
 	</div>
        
        
      </div> 
       
    </div>
  </div>
</div>

</body>

</html>
