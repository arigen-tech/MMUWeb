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
<%-- <script
	src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script> --%>
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

var gender='';
var mmu='';
var empType='';
var idType='';
var qListSize;
var dListSize;
$j(document).ready(function()
		{

            var data = ${empData};
           
             if (data.data.empId != null) {
                document.getElementById('empRegId').value = data.data.empId;
            } 
             if (data.data.empName != null) {
                 document.getElementById('empName').value = data.data.empName;
             } 
             if (data.data.gender != null) {
                 document.getElementById('genderId').value = data.data.gender;
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
                 document.getElementById('mmuId').value = data.data.mmu;
                 mmu = data.data.mmu;
             } 
             
             if (data.data.idType != null) {
                 document.getElementById('empIdType').value = data.data.idType;
                 idType = data.data.idType;
             } 
             
             if (data.data.idTypeNo != null) {
                 document.getElementById('empIdNumber').value = data.data.idTypeNo;
             } 
             if (data.data.empType != null) {
                 document.getElementById('empTypeId').value = data.data.empType;
                 empTypeId = data.data.empType;
             } 
              
             
             if (data.data.emplyMentType != null) {
                 document.getElementById('employmentTypeId').value = data.data.emplyMentType;
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
                 document.getElementById('age').value = data.data.age+" Years";
             } 
             
             
             if (data.data.encodedStringImage != null) {
            	 profileImage.setAttribute('src', "data:image/jpg;base64," + data.data.encodedStringImage);
            	 document.getElementById('base64ForProfile').value = data.data.encodedStringImage;
             } 
             if (data.data.idImageString != null) {
            	 document.getElementById('base64ForId').value = data.data.idImageString;
             } 
             
             if (data.data.idMimeType != null) {
            	 document.getElementById('idMimeType').value = data.data.idMimeType;
             } 
             
		    	var idString=data.data.idMimeType +"@"+data.data.idImageString;
		    	document.getElementById('viewId').value = idString;
             
             var recordState = '';
             if (data.data.recordState != null) {
            	 recordState = data.data.recordState;
             } 
             
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
           qListSize = qList.length;
		    for(i=0;i<qList.length;i++){
		    	var mimeType='';
		    	var fileString='';
		    	if(qList[i].mimeType != '' && qList[i].qualFileString != ''){
		    		fileString = qList[i].mimeType +"@"+qList[i].qualFileString;
		    	}
		    	if(recordState != 'saved'){
				htmlTable = htmlTable+"<tr id='"+qList[i].qualId+"' >";			
				htmlTable = htmlTable +"<td class='width60'>"+counter+"<input  class='form-control border-input' type='hidden' id='qualId"+counter+"' value='"+qList[i].qualId+"'/></td>";
				htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control width200' type='text' disabled name='degree"+counter+"' id='degree"+counter+"'  value='"+qList[i].qualName+"' /></td>";
				htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control minWidth220' type='text' disabled name='instName"+counter+"' id='instName"+counter+"'  value='"+qList[i].instName+"' /></td>";
				htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control width200' type='text'  disabled name='completeionYear"+counter+"' id='completeionYear"+counter+"'  value='"+qList[i].completionYear+"' /></td>";
				htmlTable = htmlTable +"<td style='width: 150px;'><div class='fileUploadDiv minWidth220;'>"
				+"<input  class='inputUpload' type='file' disabled name='eduDocument' id='eduDocument"+counter+"'  value='' />"
				+"<label class='inputUploadlabel'>Choose File</label>"
				+"<span class='inputUploadFileName'>No File Chosen</span></div></td>";
				if(fileString != ''){
				htmlTable = htmlTable +"<td><a href='#' value='"+qList[i].qualFileString+"' onclick=viewUploadedFile('" + fileString + "') class='btn btn-primary'><i class='fa fa-file-alt'></i> View </a></td>"; 
				} else {
					htmlTable = htmlTable +"<td></td>";
				}
				htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm;'>"
				+"<button type='button' class='btn btn-sm btn-primary noMinWidth' disabled onclick='addQualificationRow()'><i class='fa fa-plus'></i></button>"
	 			+"<button type='button' class='btn btn-danger noMinWidth' disabled onclick='removeQualificationRow(this)'><i class='fa fa-minus'></i></button></td>";
				 		
				htmlTable = htmlTable+"</tr>";
				
		    } else {
		    	htmlTable = htmlTable+"<tr id='"+qList[i].qualId+"' >";			
				htmlTable = htmlTable +"<td class='width60'>"+counter+"<input  class='form-control border-input' type='hidden' id='qualId"+counter+"' value='"+qList[i].qualId+"'/></td>";
				htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control width200' type='text' name='degree"+counter+"' id='degree"+counter+"'  value='"+qList[i].qualName+"' /></td>";
				htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control minWidth220' type='text' name='instName"+counter+"' id='instName"+counter+"'  value='"+qList[i].instName+"' /></td>";
				htmlTable = htmlTable +"<td style='width: 150px;'><input  class='form-control width200' type='text' name='completeionYear"+counter+"' id='completeionYear"+counter+"'  value='"+qList[i].completionYear+"' onblur='validateQualYear(this.value)'/></td>";
				htmlTable = htmlTable +"<td style='width: 150px;'><div class='fileUploadDiv minWidth220;'>"
				+"<input  class='inputUpload' type='file' name='eduDocument' id='eduDocument"+counter+"'  value='' onblur='validateUplodedDoc(this.id);getBase64String(this.id)' />"
				+"<label class='inputUploadlabel'>Choose File</label>"
				+"<span class='inputUploadFileName'>No File Chosen</span></div></td>";
				
				htmlTable = htmlTable +"<td style='display: none;'><textarea id='base64ForEduDoc"+counter+"' name='base64ForEduDoc' value='"+qList[i].qualFileString+"' ></textarea></td>"; 
				htmlTable = htmlTable +"<td style='display: none;'><input type='text' value='"+qList[i].mimeType+"' id='eMimeType"+counter+"' name='eMimeType"+counter+"'  /></td>"
				if(fileString != ''){
					htmlTable = htmlTable +"<td><a href='#' value='' onclick=viewUploadedFile('" + fileString + "') class='btn btn-primary'><i class='fa fa-file-alt'></i> View </a></td>"; 
				} else {
					htmlTable = htmlTable +"<td></td>";
				}
				htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm;'>"
				+"<button type='button' class='btn btn-sm btn-primary noMinWidth' onclick='addQualificationRow()'><i class='fa fa-plus'></i></button>"
	 			+"<button type='button' class='btn btn-danger noMinWidth' onclick='removeQualificationRow(this)'><i class='fa fa-minus'></i></button></td>";
				 		
				htmlTable = htmlTable+"</tr>";
		    	
		    }
		    counter++;
		    }
		    $j("#qualificationGrid").html(htmlTable); 
		    htmlTable = "";
		    
		    var dList =  data.dList ;
		    var dCounter =1;
		    dListSize = dList.length;
		    if(dList.length > 0){
		    for(i=0;i<dList.length;i++){
		    	var fileString='';
		    	if(dList[i].mimeType != '' && dList[i].docFileString != '' ){
		    		fileString=dList[i].mimeType +"@"+dList[i].docFileString;
		    	}
		    	if(recordState != 'saved'){
				htmlTable = htmlTable+"<tr id='"+dList[i].docId+"' >";			
				htmlTable = htmlTable +"<td class='width60'>"+dCounter+"<input  class='form-control border-input' type='hidden' id='docId"+dCounter+"' value='"+dList[i].docId+"'/></td>";
				htmlTable = htmlTable +"<td class='minWidth220;'><input  class='form-control width200' type='text' disabled name='docName"+dCounter+"' id='docName"+dCounter+"'  value='"+dList[i].docName+"' /></td>";
				htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm;'><div class='fileUploadDiv minWidth220;'>"
				+"<input  class='inputUpload' type='file' name='requiredDoc' id='requiredDoc"+dCounter+"'  value='' disabled />"
				+"<label class='inputUploadlabel'>Choose File</label>"
				+"<span class='inputUploadFileName'>No File Chosen</span></div></td>";	
				if(fileString != ''){
				htmlTable = htmlTable +"<td><a href='#' value='' onclick=viewUploadedFile('" + fileString + "') class='btn btn-primary'><i class='fa fa-file-alt'></i> View </a></td>"; 
				} else {
					htmlTable = htmlTable +"<td></td>"
				}
				htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm;'>"
				+"<button type='button' class='btn btn-sm btn-primary noMinWidth' disabled onclick='addRowForDocument()'><i class='fa fa-plus'></i></button>"
	 			+"<button type='button' class='btn btn-danger noMinWidth' disabled onclick='removeDocumentRow(this)'><i class='fa fa-minus'></i></button></td>";
				 		
				htmlTable = htmlTable+"</tr>";
				dCounter++;
		    } else {
		    	htmlTable = htmlTable+"<tr id='"+dList[i].docId+"' >";			
				htmlTable = htmlTable +"<td class='width60'>"+dCounter+"<input  class='form-control border-input' type='hidden' id='docId"+dCounter+"' value='"+dList[i].docId+"'/></td>";
				htmlTable = htmlTable +"<td class='minWidth220;'><input  class='form-control width200' type='text' name='docName"+dCounter+"' id='docName"+dCounter+"'  value='"+dList[i].docName+"' /></td>";
				htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm;'><div class='fileUploadDiv minWidth220;'>"
				+"<input  class='inputUpload' type='file' name='requiredDoc' id='requiredDoc"+dCounter+"'  value='' onblur='validateUplodedDoc(this.id);getBase64String(this.id)' />"
				+"<label class='inputUploadlabel'>Choose File</label>"
				+"<span class='inputUploadFileName'>No File Chosen</span></div></td>";
				htmlTable = htmlTable +"<td style='display: none;'><textarea id='base64ForRequiredDoc"+dCounter+"' name='base64ForRequiredDoc' value='"+dList[i].docFileString+"' ></textarea></td>"; 
				htmlTable = htmlTable +"<td style='display: none;'><input type='text' value='"+dList[i].mimeType+"' id='dMimeType"+dCounter+"' name='dMimeType"+dCounter+"'  /></td>";
				if(fileString != ''){
				htmlTable = htmlTable +"<td><a href='#' value='' onclick=viewUploadedFile('" + fileString + "') class='btn btn-primary'><i class='fa fa-file-alt'></i> View </a></td>"; 
				} else {
					htmlTable = htmlTable +"<td></td>"
				}
				htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm;'>"
				+"<button type='button' class='btn btn-sm btn-primary noMinWidth' onclick='addRowForDocument()'><i class='fa fa-plus'></i></button>"
	 			+"<button type='button' class='btn btn-danger noMinWidth' onclick='removeDocumentRow(this)'><i class='fa fa-minus'></i></button></td>";
				 		
				htmlTable = htmlTable+"</tr>";
		    	}
		    	dCounter++;
		    }
		} else if(recordState == 'saved'){
			htmlTable = htmlTable+"<tr id='' >";			
			htmlTable = htmlTable +"<td class='width60'>"+dCounter+"<input  class='form-control border-input' type='hidden' id='docId"+dCounter+"' value=''/></td>";
			htmlTable = htmlTable +"<td class='minWidth220;'><input  class='form-control width200' type='text' name='docName"+dCounter+"' id='docName"+dCounter+"'  value='' /></td>";
			htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm;'><div class='fileUploadDiv minWidth220;'>"
			+"<input  class='inputUpload' type='file'  name='requiredDoc' id='requiredDoc"+dCounter+"'  value='' onblur='validateUplodedDoc(this.id);getBase64String(this.id)' />"
			+"<label class='inputUploadlabel'>Choose File</label>"
			+"<span class='inputUploadFileName'>No File Chosen</span></div></td>";
			htmlTable = htmlTable +"<td style='display: none;'><textarea id='base64ForRequiredDoc"+dCounter+"' name='base64ForRequiredDoc' ></textarea></td>"; 
			htmlTable = htmlTable +"<td style='display: none;'><input type='text' id='dMimeType"+dCounter+"' name='dMimeType"+dCounter+"'  /><td>";
			htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm;'>"
			+"<button type='button' class='btn btn-sm btn-primary noMinWidth'  onclick='addRowForDocument()'><i class='fa fa-plus'></i></button>"
 			+"<button type='button' class='btn btn-danger noMinWidth'  onclick='removeDocumentRow(this)'><i class='fa fa-minus'></i></button></td>";
			 		
			htmlTable = htmlTable+"</tr>";
		} else {
			
			htmlTable = htmlTable+"<tr id='' >";			
			htmlTable = htmlTable +"<td class='width60'>"+dCounter+"<input  class='form-control border-input' disabled type='hidden' id='docId"+dCounter+"' value=''/></td>";
			htmlTable = htmlTable +"<td class='minWidth220;'><input  class='form-control width200' type='text' disabled name='docName"+dCounter+"' id='docName"+dCounter+"'  value='' /></td>";
			htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm;'><div class='fileUploadDiv minWidth220;'>"
			+"<input  class='inputUpload' type='file' name='requiredDoc' disabled id='requiredDoc"+dCounter+"'  value='' />"
			+"<label class='inputUploadlabel'>Choose File</label>"
			+"<span class='inputUploadFileName'>No File Chosen</span></div></td>";
			
			htmlTable = htmlTable +"<td></td>"; 
			htmlTable = htmlTable +"<td class='minwidth120 btn-group-sm;'>"
			+"<button type='button' class='btn btn-sm btn-primary noMinWidth' disabled onclick='addRowForDocument()'><i class='fa fa-plus'></i></button>"
 			+"<button type='button' class='btn btn-danger noMinWidth' disabled onclick='removeDocumentRow(this)'><i class='fa fa-minus'></i></button></td>";
			 		
			htmlTable = htmlTable+"</tr>";
		}
		    
		    $j("#documentGrid").html(htmlTable); 
		    
             
             getGenderList();	
 			getMMUList();
 			getEmpTypeList();
 			getIdTypeList();
 			
 			if(recordState != 'saved'){
 				 $(empName).prop('disabled', true);
 				 $(genderId).prop('disabled', true);
 				 $(dob).prop('disabled', true);
 				 $(empAddress).prop('disabled', true);
 				 $(empState).prop('disabled', true);
 				 $(empDist).prop('disabled', true);
 				 $(empCity).prop('disabled', true);
 				 $(empPincode).prop('disabled', true); 
 				 $(empMobile).prop('disabled', true);
 				 $(empIMEI).prop('disabled', true);
 				 $(mmuId).prop('disabled', true);
 				 $('#empTypeId').prop('disabled', true);
 				 $(employmentTypeId).prop('disabled', true);
 				 $(empIdentity).prop('disabled', true);
 				 $(fromDate).prop('disabled', true);
 				 $(toDate).prop('disabled', true); 
 				 $(age).prop('disabled', true); 
 				 $(empProfileImage).prop('disabled', true); 
 				 
 				$('#saveBtn').hide();
 				$('#submitBtn').hide();
 				
 				
 			}
 			
 			 
			
		});

function getGenderList(){
	var params = {}
	
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/opd/getGenderList";
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : url,
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(data) {
			if(data.status == true){
				var list = data.data;
				var dropDrop = '<option value="">Select</option>';
				for(i=0;i<list.length;i++){
					if(list[i].administrativeSexId == gender){
					dropDrop += '<option selected value='+list[i].administrativeSexId+'>'+list[i].administrativeSexName+'</option>';						
					} else {
						dropDrop += '<option value='+list[i].administrativeSexId+'>'+list[i].administrativeSexName+'</option>';	
					}
				}
				$j('#genderId').append(dropDrop);
			}
		},
		error : function(data) {
			alert("An error has occurred while contacting the server");
		}
	}); 
	}


function getIdTypeList(){
	 
	 var params = { };
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : 'getIdTypeList',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(data) {
			if(data.status == true){
				var list = data.list;
				var idDrop = '<option value="">Select</option>';
				$j('#empIdType').find('option').not(':first').remove();
				for(i=0;i<list.length;i++){
					if(list[i].id == idType){
						idDrop += '<option selected value='+list[i].id+'>'+list[i].IdName+'</option>';
					} else {
						idDrop += '<option value='+list[i].id+'>'+list[i].IdName+'</option>';
					}
				}
				$j('#empIdType').append(idDrop);
			}
		},
		error : function(data) {
			alert("An error has occurred while contacting the server");
		}
	}); 
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
						if(list[i].mmuId == mmu){
						 mmuDrop += '<option selected value='+list[i].mmuId+'>'+list[i].mmuName+'</option>';
						}else{
							mmuDrop += '<option value='+list[i].mmuId+'>'+list[i].mmuName+'</option>';
						}
					}
					$j('#mmuId').append(mmuDrop);
				}
			},
			error : function(data) {
				alert("An error has occurred while contacting the server");
			}
		}); 
	}
	

	
	function getEmpTypeList(){
		var params = {
				"mmuStaff":"Y"
		}
		
		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : 'getEmpTypeList',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(data) {
				if(data.status == true){
					var list = data.data;
					var dropDrop = '<option value="">Select</option>';
					for(i=0;i<list.length;i++){
						if(list[i].userTypeId == empTypeId){
						dropDrop += '<option selected value='+list[i].userTypeId+'>'+list[i].userTypeName+'</option>';
					}else {
						dropDrop += '<option value='+list[i].userTypeId+'>'+list[i].userTypeName+'</option>';
					}
					}
					$j('#empTypeId').append(dropDrop);
				}
			},
			error : function(data) {
				alert("An error has occurred while contacting the server");
			}
		}); 
		}
	
	
	function showHideToDate(employeementType)	{
		
		if(employeementType =='P'){
			$('#toDateDiv').hide();
		}  else {
			$('#toDateDiv').show();
		}
		
	}
 
	
	
function saveEmployeeRegistration(item,action){
		
		///-----		
		var empName = $('#empName').val();
		var genderId = $('#genderId').val();
		var dob = $('#dob').val();
		var empAddress = $('#empAddress').val();
		var empState = $('#empState').val();
		var empDist = $('#empDist').val();
		var empCity = $('#empCity').val();
		var empPincode = $('#empPincode').val();
		var empMobile = $('#empMobile').val();
		var empIMEI = $('#empIMEI').val();
		var mmuId = $('#mmuId').val();
		var empProfileImage = $('#empProfileImage').val();
		var empTypeId = $('#empTypeId').val();
		var employmentTypeId = $('#employmentTypeId').val();
		var fromDate = $('#fromDate').val();
		var toDate = $('#toDate').val();
		var empIdentity = 	$('#empIdentity').val();
		
		var empRegId = $('#empRegId').val();
		var empIdType = $('#empIdType').val();
		var empIdNumber = $('#empIdNumber').val();
		
		var degree = $('#degree1').val();
		var instName = $('#instName1').val();
		var completeionYear = $('#completeionYear1').val(); 
		
		var docName = $('#docName1').val();
		var base64ForProfileStr = $('#base64ForProfile').val();
		var base64ForIdStr =  $('#base64ForId').val();
		var idMimeType =  $('#idMimeType').val();
		var idPhoto = $('#idPhoto').val();
		
		if(empName == ''){
			alert("Please enter Employee Name");
			return;
		}
		
		if(dob == ''){
			alert("Please select date of birth");
			return;
		} /* else 	
			{
			if(!isValidDate(dob)){
				//alert("Date of birth should not be future date");
				return;
			}
			} */
		
		if(empMobile == ''){
			alert("Please enter Mobile No.");
			return;
		}else if(empMobile.trim().length < 10){
			alert("Please enter valid Mobile No.");
			return;
		}
		if(genderId == ''){
			alert("Please select gender");
			return;
		}
		
		if(empAddress == ''){
			alert("Please enter address");
			return;
		}
		if(empState == ''){
			alert("Please enter state");
			return;
		}
		
		
		if(empDist == ''){
			alert("Please enter district");
			return;
		}
		if(empCity == ''){
			alert("Please enter city");
			return;
		}
		if(empPincode == ''){
			alert("Please enter Pin Code");
			return;
		} else if(empPincode.trim().length < 6){
			alert("Please enter valid pin code.");
			return;
		}
		if(empIMEI != '' && empIMEI.trim().length < 15){
			alert("Please enter valid IMEI.");
			return;
		}
		if(mmuId == ''){
			alert("Please select MMU");
			return;
		}
		
		if(empIdType == ''){
			alert("Please select ID type");
			return;
		}
		
		if(empIdNumber == ''){
			alert("Please enter ID Number");
			return;
		}
		
		if(empTypeId == ''){
			alert("Please select Employee Type");
			return;
		}
		if(employmentTypeId == ''){
			alert("Please select Employment Type");
			return;
		}
		if(fromDate == ''){
			alert("Please enter from date");
			return;
		}
		if( employmentTypeId=='T' ){
			if(toDate == ''){
			alert("Please enter to date");
			return;
		} else {
			compareDate(fromDate,toDate);
		}	
		}
		
		/*  if(empProfileImage != ''){
			 validateImage();
		} 
			
		 if(idPhoto != ''){
						
				validateIdProof();		
				
			} */
		var typeOfEmp = $('#empTypeId option:selected').text();
				if(typeOfEmp == 'Doctor'){
					if(empIdentity == ''){
						alert("Please enter registration No.");
						return;
					}
				}
		//Educational Qualification JSON
		
				
		var tableDataQualification = [];  
    	var dataQualification='';
    	var idforTreat='';
    	
    	$('#qualificationGrid tr').each(function(i, el) {
			idforTreat= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
	    var $tds = $(this).find('td')
	  	var qualId=	$tds.eq(0).find(":input").val();
		var degree = $tds.eq(1).find(":input").val();
		var instName = $tds.eq(2).find(":input").val();
		var completeionYear = $tds.eq(3).find(":input").val();
		var base64ForEduDoc = $tds.eq(5).find(":input").val();
		var mimeTypeEduDoc = $tds.eq(6).find(":input").val();
		
		
		
		
		dataQualification={
				'qualId':qualId,
				'degree' : degree,
				'instName':instName,
				'completeionYear' : completeionYear,
				'base64ForEduDoc':base64ForEduDoc,
				'mimeTypeEduDoc':mimeTypeEduDoc
				
			} 
		tableDataQualification.push(dataQualification);
	});
		
		
		//
		
				//Required Document JSON
		
				
		var tableDataDocument = [];  
    	var dataDocument='';
    	var idforTreat='';
    	
    	$('#documentGrid tr').each(function(i, el) {
			idforTreat= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
	    var $tds = $(this).find('td')
	  		
	    var docId=0;
			  	docId=	$tds.eq(0).find(":input").val();
			  	
		var docName = $tds.eq(1).find(":input").val();
		var base64ForRequireDoc = $tds.eq(3).find(":input").val();	
		var mimeTypeRequireDoc = $tds.eq(4).find(":input").val();	
		
		
		
		dataDocument={
				'docId':docId,
				'docName' : docName,
				'base64ForRequireDoc':base64ForRequireDoc,
				'mimeTypeRequireDoc':mimeTypeRequireDoc
			} 
		tableDataDocument.push(dataDocument);
	});
		
		var params = {
				"empRegId":empRegId,
				"userId":"<%= userId %>",
				"empName":empName,
				"genderId":genderId,
				"dob":dob,
				"empAddress":empAddress,
				"empState":empState,
				"empDist":empDist,
				"empCity":empCity,
				"empPincode":empPincode,
				"empMobile":empMobile,
				"empIMEI":empIMEI,
				"mmuId":mmuId,
				"empProfileImage":empProfileImage,
				"empTypeId":empTypeId,
				"empIdType":empIdType,
				"empIdNumber":empIdNumber,	
				"employmentTypeId":employmentTypeId,
				"fromDate":fromDate,
				"toDate":toDate,
				"empIdentity":empIdentity,
				"qualificationList":tableDataQualification,
				"documentList":tableDataDocument,
				"action":action,
				"base64ForProfileStr":base64ForProfileStr,
				"base64ForIdStr":base64ForIdStr,
				"idMimeType":idMimeType
				
		}
		console.log(JSON.stringify(params));
		
		//return;
		$j(item).attr("disabled", true);
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "saveEmployee",
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,		
			
			success : function(data) {
				if(data.status){
					alert(data.msg+'S');
					$j(item).attr("disabled", false);
					resetForm();
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
	
function resetForm(){
	
	$j('#empName').val('');
	$j('#genderId').val('');
	$j('#age').val('');
	$j('#dob').val('');
	$j('#empAddress').val('');
	$j('#empState').val('');
	$j('#empDist').val('');
	$j('#empCity').val('');
	$j('#empPincode').val('');
	$j('#empMobile').val('');
	$j('#empIMEI').val('');
	$j('#mmuId').val('');
	$j('#empTypeId').val('');
	$j('#employmentTypeId').val('');
	$j('#fromDate').val('');
	$j('#toDate').val('');
	$j('#empIdentity').val('');
	$j('#empProfileImage').val('');
	
	$j('#empIdType').val('');
	$j('#empIdNumber').val('');
	$j('#idPhoto').val('');
	$j('#base64ForProfile').val('');
	$j('#base64ForId').val('');
	
	
	$("#qualificationGrid tr:gt(0)").remove();
	$("#documentGrid tr:gt(0)").remove();
	
	 $('#degree1').val('');
	 $('#instName1').val('');
	 $('#completeionYear1').val(''); 
	 $('#completeionYear1').val(''); 
	 $('#eduDocument1').val('');
	 $('#base64ForEduDoc1').val('');
	 
	 $("#documentGrid tr:gt(0)").remove();
		$("#documentGrid tr:gt(0)").remove();
	
	 $('#docName1').val('');
	 $('#requiredDoc1').val('');
	 $('#base64ForRequiredDoc1').val('');
	 
	 $('.fileUploadDiv.hasFile').children('.inputUpload').val('');
     $('.fileUploadDiv.hasFile').children('.inputUploadFileName').html('No File Chosen');
     $('.fileUploadDiv.hasFile').children('.inputUploadlabel').text('Choose File');
     $('.fileUploadDiv.hasFile').removeClass('hasFile');
     profileImage.setAttribute('src', "/MMUWeb/resources/images/photo_icon.png" );
	
}
	
function validateEduQualiGrid(){
	var indx = 0;
	$('#qualificationGrid tr').each(function(i, el) {
		idforTreat= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
    var $tds = $(this).find('td')
  		
	var degree = $tds.eq(1).find(":input").val();
	var instName = $tds.eq(2).find(":input").val();
	var completeionYear = $tds.eq(3).find(":input").val();
	
	if(degree != '' && instName != '' && completeionYear != ''){
		indx++;
	}
	

	});	
	if(indx == 0){
		alert("Atleast one entry is required in educational qualification table ");
		return false;
	} else {
		
		return true;
	}
}	
	
function validateRequiredDoc(){
	var len = 0;
	var uFlag = false;
	$('#documentGrid tr').each(function(i, el) {
		idforTreat= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
    var $tds = $(this).find('td')
  		
	var docName = $tds.eq(1).find(":input").val();
	var docUpload = $tds.eq(2).find(":input").val();
	if(docName != '' && docUpload == '' ){
		uFlag = false;
		
	} 	
	len++;
	alert(len);
});
	if(!uFlag){
		alert("Document upload is mandatory if document name is entered");
		return false;
	}	else {
	   return true;	
	}
	}
	
function isValidDate(date){
	if (dob != '') {
		
	 var objDate, mSeconds, day, month, year;
			if (date.length !== 10) {
				return false;
			}
			if (date.substring(2, 3) !== '/' || date.substring(5, 6) !== '/') {
				return false;
			}

			var currentYear = new Date().getFullYear();
			month = date.substring(0, 2) - 1; // because months in JS start from 0 
			day = date.substring(3, 5) - 0;
			year = date.substring(6, 10) - 0;

			var dob = new Date(year, month, day);
			console.log("DOB--> " + dob);
			var month_diff = Date.now() - dob.getTime();

			var age_dt = new Date(month_diff);

			var age_year = age_dt.getUTCFullYear();
			console.log("age_year--> " + age_year);
			var age = Math.abs(age_year - 1970);
			console.log("age--> " + age);
			if (age > 80) {
				alert("Age should not be greater than 80 years");
				document.getElementById('dob').value = '';
				return false;
			}
			if (age < 18) {
				alert("Age should be greater than 18 years");
				document.getElementById('dob').value = '';
				return false;
			}
			document.getElementById("age").value = age + " Years";
			/* mSeconds = (new Date(year, month, day)).getTime();
			objDate = new Date();
			objDate.setTime(mSeconds);
			if (objDate.getFullYear() !== year || objDate.getMonth() !== month
					|| objDate.getDate() !== day) {
				return false;
			}
			return true; */
		}
	}
		
function validateAge(date){
	var dob = new Date(date); 
    //calculate month difference from current date in time  
    var month_diff = Date.now() - dob.getTime();  
      
    //convert the calculated difference in date format  
    var age_dt = new Date(month_diff);   
      
    //extract year from date      
    var year = age_dt.getUTCFullYear();  
      
    var age = Math.abs(year - 1970);  
    return age;  
}

function validateQualYear(year){
	if(parseInt(year) < 1960 && parseInt(year) > 2010){
		return 0;
	}else 
		return 1;
		
	}
	

function calculateAge(){
	var dob = new Date($('#dob').val());  
    //calculate month difference from current date in time  
    var month_diff = Date.now() - dob.getTime();  
      
    //convert the calculated difference in date format  
    var age_dt = new Date(month_diff);   
      
    //extract year from date      
    var year = age_dt.getUTCFullYear();  
      
    var age = Math.abs(year - 1970);  
    document.getElementById("age").value = age+" Years";  
}


//var qIndex=1;
function addQualificationRow() {
	qListSize++;
	var aClone = $('#qualificationGrid>tr:last').clone(true)
	aClone.find('td:eq(0)').html(qListSize);
	aClone.find(":input").val("");
	aClone.find(":file").parent('.fileUploadDiv').removeClass('hasFile');
	aClone.find(":file").siblings('.inputUploadFileName').html('No File Chosen');
	aClone.find(":file").siblings('.inputUploadlabel').text('Choose File');
 	aClone.find("td:eq(1)").find(":input").prop('id', 'degree'+qListSize+'');
	aClone.find("td:eq(2)").find(":input").prop('id', 'instName'+qListSize+'');
	aClone.find("td:eq(3)").find(":input").prop('id', 'completeionYear'+qListSize+'');
	aClone.find("td:eq(4)").find(":input").prop('id', 'eduDocument'+qListSize+'').bind("input").blur(function()
			 {
		getBase64String(this.id);
		});
	aClone.find("td:eq(5)").find(":input").prop('id', 'base64ForEduDoc'+qListSize+'');
	aClone.find("td:eq(6)").find(":input").prop('id', 'eMimeType'+qListSize+'');
	aClone.clone(true).appendTo('#qualificationGrid');
	var val = $('#qualificationGrid>tr:last').find("td:eq(0)").find(":input")[0];
	
}

function removeQualificationRow(val){
	if($('#qualificationGrid tr').length > 1) {
	   $(val).closest('tr').remove()
	 }
}


var dIndex=1;
function addRowForDocument() {
	dListSize++;
	var aClone = $('#documentGrid>tr:last').clone(true)
	aClone.find('td:eq(0)').html(dListSize);
	aClone.find(":input").val("");
 	aClone.find("td:eq(1)").find(":input").prop('id', 'docName'+dListSize+'');
	aClone.find("td:eq(2)").find(":input").prop('id', 'requiredDoc'+dListSize+'').bind("input").blur(function()
			 {
		getBase64String(this.id);
	});
	aClone.find("td:eq(3)").find(":input").prop('id', 'base64ForRequiredDoc'+dListSize+'');
	aClone.find("td:eq(4)").find(":input").prop('id', 'dMimeType'+dListSize+'');
	aClone.clone(true).appendTo('#documentGrid');
	var val = $('#documentGrid>tr:last').find("td:eq(0)").find(":input")[0];
	
}

function removeDocumentRow(val){
	if($('#documentGrid tr').length > 1) {
	   $(val).closest('tr').remove()
	 }
}


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
};


function backToWaitingList(){
	window.location = "getSavedEmpList";
}

function checkDuplicateMobile(empMobile){
	
	if(empMobile == ''){
		alert("Please enter Mobile No.");
		return;
	}else if(empMobile.trim().length < 10){
		alert("Please enter valid Mobile No.");
		return;
	} else {
			
	var params = {
			
			"empMobile":empMobile	
	}
	
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : 'checkDuplicateMobile',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(data) {
			if(data.ifMobileExists == true){
				alert("Mobile number already exists");
				  $j('#empMobile').val('');
				return;
			}
		},
		error : function(data) {
			alert("An error has occurred while contacting the server");
		}
	}); 
	}

}

function checkDuplicateIMEI(imeiNo){
	
	 if(imeiNo != '' && imeiNo.trim().length < 15){
			alert("Please enter valid IMEI.");
			return;
		} else {
				
		var params = {
				
				"imeiNo":imeiNo	
		}
		
		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : 'checkDuplicateIMEI',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(data) {
				if(data.ifimeiNoExists == true){
					alert("IMEI number already exists");
				  $j('#empIMEI').val('');
					return;
				}
			},
			error : function(data) {
				alert("An error has occurred while contacting the server");
			}
		}); 
		}
	
	}


function validateQualYear(year){
	
	var currentYear = new Date().getFullYear();
	if(parseInt(year) > parseInt(currentYear)){
		alert("	Year of Completion should not be future year");
		return;
	}
}


function validateImage() 
{
	if(document.getElementById('empProfileImage').value != ''){
    var allowedExtension = ['jpeg', 'jpg'];
    var fileExtension = document.getElementById('empProfileImage').value.split('.').pop().toLowerCase();
    var isValidFile = false;

        for(var index in allowedExtension) {

            if(fileExtension === allowedExtension[index]) {
                isValidFile = true; 
                break;
            }
        }

        if(!isValidFile) {
            alert('Allowed Extensions are : *. ' + allowedExtension.join(', *.') );
            $('#empProfileImage').attr('value', '');
            return false;
        } else 
        	return true;
	}
}

function compareDate(){
	
	
	var fdate = $('#fromDate').val();
	var tdate = $('#toDate').val();
	//alert(fdate);
	if(fdate != '' && tdate != ''){
	var fromDate = new Date(fdate.substring(6), (fdate
			.substring(3, 5) - 1), fdate.substring(0, 2))
	var toDate = new Date(tdate.substring(6), (tdate
			.substring(3, 5) - 1), tdate.substring(0, 2))
	
	if (toDate < fromDate  ) {
		alert("To date should not be earlier than the From date");
		$j('#toDate').val('');
		return false;
	}
	}
	
}

function getBase64String(fileInputId){
	var fileInput = document.getElementById(fileInputId);
	if(fileInput!= null && fileInput != ''){
	var argsPart = fileInputId.split(/([0-9]+)/)
	//alert(argsPart[0]);
		var idtoStore;
		var mimeTypeId;
		var fileInputId;
	//var argsSplit = args.split("@");
	var callFor = argsPart[0];
	var callForId = argsPart[1];
	if(callFor == 'requiredDoc'){
		idtoStore = 'base64ForRequiredDoc'+callForId;
		mimeTypeId = 'dMimeType' + callForId;
		//fileInputId = 'requiredDoc'+ callForId;
	} else if(callFor == 'eduDocument'){
		
		idtoStore = 'base64ForEduDoc'+callForId;
		mimeTypeId = 'eMimeType' + callForId;
		fileInputId = 'eduDocument'+ callForId;
	}
	
		 
	var reader = new FileReader();
	reader.readAsDataURL(fileInput.files[0]);

	reader.onload = function () {
		
		var imageString = reader.result;
		 var parts = imageString.split(",");
		 document.getElementById(idtoStore).value = parts[1];
		 mimeType = parts[0].substring(parts[0].indexOf('/') + 1, parts[0].indexOf(';base64'));
		document.getElementById(mimeTypeId).value = mimeType;
}
	}
}	
	
function getBase64StringForIDandProfile(fileInput,idtoStore,mimeTypeId){
	
	var fileInput = document.getElementById(fileInput);
	if(fileInput!= null && fileInput != ''){
	var reader = new FileReader();
	reader.readAsDataURL(fileInput.files[0]);

	reader.onload = function () {
		imageString = reader.result;
		 document.getElementById(idtoStore).value = reader.result;
		 var parts = imageString.split(",");
		 document.getElementById(idtoStore).value = parts[1];
		 mimeType = parts[0].substring(parts[0].indexOf('/') + 1, parts[0].indexOf(';base64'));
		 if(mimeType.includes("word")){
			 mimeType = 'msword';
		}
		document.getElementById(mimeTypeId).value = mimeType;
		if(idtoStore == 'base64ForProfile'){
			profileImage.setAttribute('src', "data:image/"+mimeType+";base64," +parts[1]);
		}
}
	}
}		
	
function validateIdProof() 
{
	if(document.getElementById('idPhoto').value != ''){
    var allowedExtension = ['jpeg', 'jpg','png','pdf','PNG','JPEG','JPG'];
    var fileExtension = document.getElementById('idPhoto').value.split('.').pop().toLowerCase();
    var isValidFile = false;

    if(fileExtension!="" && fileExtension!=null && validateFileExtension(fileExtension, "valid_msg", "Only pdf/image files are allowed",
		      new Array("jpg","pdf","jpeg","png","PNG","JPEG","JPG")) == false)
		      {
				 
			 
		 	$('#idPhoto').attr('value', '');

		$('.fileUploadDiv.hasFile').children('.inputUpload').val('');
		$('.fileUploadDiv.hasFile').children('.inputUploadFileName')
				.html('No File Chosen');
		$('.fileUploadDiv.hasFile').children('.inputUploadlabel').text(
				'Choose File');
		$('.fileUploadDiv.hasFile').removeClass('hasFile');

			
			return false;
		      }
	

        for(var index in allowedExtension) {

            if(fileExtension === allowedExtension[index]) {
                isValidFile = true; 
                break;
            }
        }

        if(!isValidFile) {
            alert('Allowed Extensions are : *. ' + allowedExtension.join(', *.') );
            $('#idPhoto').attr('value', '');
            return false;
        } else 
        	return true;
	}  

}

function validateUplodedDoc(id) 
{
	if(document.getElementById(id).value != ''){
    var allowedExtension = ['doc','docx','pdf'];
    var fileExtension = document.getElementById(id).value.split('.').pop().toLowerCase();
    var isValidFile = false;

    if(fileExtension!="" && fileExtension!=null && validateFileExtension(fileExtension, "valid_msg", "Only pdf/doc files are allowed",
		      new Array("pdf","docx","doc")) == false)
		      {
				 
			 
		 	$('#'+id).attr('value', '');

		  		return false;
		      }

        for(var index in allowedExtension) {

            if(fileExtension === allowedExtension[index]) {
                isValidFile = true; 
                break;
            }
        }

        if(!isValidFile) {
        	document.getElementById(id).value = '';
            alert('Allowed Extensions are : *. ' + allowedExtension.join(', *.'));
            return;
        }
	}
}	

function setLengthAndinput(){
	
	var IdType = $('#empIdType option:selected').text();
	$j('#empIdNumber').val('');
	$('#empIdNumber').unbind();
	
	if(IdType.toLowerCase() == 'AADHAAR Card'.toLowerCase()){
		 $("#empIdNumber").attr('maxlength','12');
		 
		 $('#empIdNumber').keyup(function() {
			 checkNumberFormat('empIdNumber'); 
			});
		} else if(IdType.toLowerCase() == 'PASSPORT'.toLowerCase()){
			 $("#empIdNumber").attr('maxlength','8');
		} else if(IdType.toLowerCase() == 'PAN CARD'.toLowerCase()){
			$("#empIdNumber").attr('maxlength','10');
		}if(IdType.toLowerCase() == 'RATION CARD'.toLowerCase()){
			$("#empIdNumber").attr('maxlength','10');
			 $('#empIdNumber').keyup(function() {
				 checkNumberFormat('empIdNumber'); 
				});
		}if(IdType.toLowerCase() == 'DRIVING LICENCE'.toLowerCase()){
			$("#empIdNumber").attr('maxlength','15');
		}
	
	}
</script>
</head>

<body>

<!-- Begin page -->
<div id="wrapper">
	<div class="content-page">
	<!-- Start content -->	
	<div class="container-fluid">
	
		<div class="internal_Htext">View and update Registration</div>
		<%-- <form:form name="employeeRegistrationData" id="employeeRegistrationData" method="post" enctype='multipart/form-data'> --%>
		<input type="hidden"  name="empRegId" value= "" id="empRegId" />
	
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-body">
						<p align="center" id="messageId" style="color: green; font-weight: bold;"></p>
						
						<div class="row m-t-10">							
							<div class="col-md-12">
								<h5 class="page_head text-center">View and update Registration</h5>
							</div>
						</div>
						
						<div class="row m-t-20">
							<div class="col-lg-9 col-sm-12">
									<div class="row">
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Employee Name<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empName" class="form-control"  />
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Gender<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="genderId">
												</select>
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Date of birth<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" name="" id="dob" class="noFuture_datePos form-control" onblur="isValidDate(this.value);"
													value="" placeholder="DD/MM/YYYY" />
												</div>
											</div>
										</div>
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Age<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" id="age" class="form-control" disabled/>
											</div>
										</div> 
									</div>
									
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Address<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<textarea class="form-control" rows='3' id="empAddress" onfocus="calculateAge()"></textarea>
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">State<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empState" class="form-control"/>
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">District<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empDist" class="form-control"/>
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">City<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empCity" class="form-control"/>
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Pincode<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empPincode" class="form-control"  />
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Mobile No.<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empMobile" class="form-control"  onblur="checkDuplicateMobile(this.value)"/>
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">IMEI No.</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empIMEI" class="form-control" maxLength="15"
												onkeypress="checkNumberFormat('empIMEI');" onblur="checkDuplicateIMEI(this.value)" />
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">MMU<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="mmuId"></select>
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">ID Type<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="empIdType" name="empIdType" onchange="setLengthAndinput()"></select>
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">ID Number<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empIdNumber" name="empIdNumber" class="form-control" onkeypress="" maxLength="" />
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">ID Upload (Only JPEG and PDF are allowed)<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<div class="fileUploadDiv m-b-10">
												  	<input type="file" class="inputUpload" name="idPhoto" id="idPhoto" onblur="if(validateIdProof()){getBase64StringForIDandProfile(this.id,'base64ForId','idMimeType');}">
												  	<label class="inputUploadlabel">Choose File</label>
													<span id="" class="inputUploadFileName">No File Chosen</span>
													<textarea id="base64ForId" style="display: none;"></textarea>
													<input type="hidden" id="idMimeType" name="idMimeType" class="form-control"/>
											  	</div>
											</div>
										</div> 
									</div>
									<div class="col-md-6">
										<button type="button" id="viewId" name="viewId" value="" onclick="viewUploadedFile(this.value)"  class="btn btn-primary">View</button>
										<button type="button" id="viewId1" name="viewId1" value="" data-toggle="modal" data-target="#smallModal" data-background="static"  class="btn btn-primary"
										 onclick="showIdImage(this.value)">View</button>
									</div>
									
								</div>
							</div>
							
							<div class="col-lg-3 col-sm-4 offset-sm-4 offset-lg-0 m-t-sm-10">
								<div class="form-group row">
									<div class="col-sm-11 offset-sm-1">
										<img src="/MMUWeb/resources/images/photo_icon.png" class="profileImg" alt="" width="80%" id="profileImage">
									</div>
									<div class="col-md-11 offset-sm-1">										
										<label class="col-form-label">Profile Image<span class="mandate"><sup>&#9733;</sup></span></label>
									</div>
									<div class="col-md-11 offset-sm-1">
										<div class="fileUploadDiv m-b-10">
										  	<input type="file" class="inputUpload" name="empProfileImage" id="empProfileImage" onblur="if(validateImage()){getBase64StringForIDandProfile(this.id,'base64ForProfile','profileImageMimeType');}">
										  	<label class="inputUploadlabel">Choose File</label>
											<span id="spanInputUploadFileName" class="inputUploadFileName">No File Chosen</span>
											<textarea id="base64ForProfile" style="display: none;"></textarea>
											<input type="hidden" id="profileImageMimeType" name="profileImageMimeType" class="form-control" style="display: block" />
									  	</div>
									</div>
								</div>
							</div>
						
						
						</div>
						
						<div class="row m-t-10">
							<div class="col-lg-9 col-sm-12">
								<div class="row">
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Type of Employee<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="empTypeId">	
												</select>
											</div>
										</div> 
									</div>
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Type of Employment<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="employmentTypeId" onchange="showHideToDate(this.value);">
													<option selected value="">Select</option>
													<option value="P">Permanent</option>
													<option value="T">Temporary</option>
												</select>
											</div>
										</div> 
									</div>
									
									<div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Registration No.</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empIdentity" class="form-control"/>
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
													<input type="text" name="fromDate" id="fromDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" >
												</div>
											</div>
										</div>
									</div>
									
									<div class="col-md-6" style="display: none" id="toDateDiv">
										<div class="form-group row" id="toDateDiv">
											<div class="col-md-5">
												<label class="col-form-label">To Date</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" name="toDate" id="toDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" 
													onblur="compareDate();" >
												</div>
											</div>
										</div>
									</div>
									
									<!-- <div class="col-md-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Identity No.</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="empIdentity" class="form-control"/>
											</div>
										</div> 
									</div> -->
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
		                                          <th>File Upload (Only Doc and PDF are allowed)</th>
		                                          <th>View Uploaded File</th>
		                                          <th>Action</th>
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
								<table class="table table-striped table-hover table-bordered ">
		                                  <thead>		                                      
		                                      <tr>
		                                          <th>S.No.</th>
		                                          <th>Document Name</th>
		                                          <th>File Upload (Only Doc and PDF are allowed)</th>
		                                          <th>View Uploaded File</th>
		                                          <th>Action</th>
		                                      </tr>
		                                  </thead>
		                                  <tbody id="documentGrid">
		                                
		                   				 </tbody>
	                                  </table>
							</div>
						</div>
						
						<div class="row m-t-20">
							<div class="col-12 text-right">
								<button type="button" class="btn btn-primary" id="saveBtn" onclick="if(validateEduQualiGrid()){saveEmployeeRegistration(this,'saved');}">Save</button>
								<button type="button" class="btn btn-primary" id="submitBtn" onclick="if(validateEduQualiGrid()){saveEmployeeRegistration(this,'submitted');}">Submit</button>
								<button type="button" class="btn btn-primary" id="backBtn" onclick="backToWaitingList()" >Back</button>								
							</div>
						</div>
			
					</div>
				</div>
			<!-- end card -->
			</div>
		<!-- end col -->
		</div>
		<!-- end row -->
		<%-- </form:form> --%>
	
	</div>
	<!-- container -->
	<!-- content -->
	</div>
</div>
<!-- END wrapper -->

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

	<!-- jQuery  -->

<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
</body>

</html>
