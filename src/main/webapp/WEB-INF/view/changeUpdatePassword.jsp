<%@page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
      
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="..//view/leftMenu.jsp" />

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MMU</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
<style>
/* Style all input fields */
input {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 6px;
  margin-bottom: 16px;
}

/* Style the submit button */
input[type=submit] {
  background-color: #04AA6D;
  color: white;
}

/* Style the container for inputs */
.container {
  background-color: #f1f1f1;
  padding: 20px;
}

/* The message box is shown when the user clicks on the password field */
#message {
  display:none;
  background: #f1f1f1;
  color: #000;
  position: relative;
  padding: 20px;
  margin-top: 10px;
}

#message p {
  padding: 10px 35px;
  font-size: 18px;
}

/* Add a green text color and a checkmark when the requirements are right */
.valid {
  color: green;
}



/* Add a red text color and an "x" when the requirements are wrong */
.invalid {
  color: red;
}

</style>
<%@include file="..//view/commonJavaScript.jsp" %>

<script type="text/javascript">
var $j = jQuery.noConflict();
$(document).ready(function() {
	var loginName=localStorage.loginName;
	var employeeId=localStorage.employeeId;
	var identificationTypeId=localStorage.identificationTypeId;
	document.getElementById('userName').value = loginName;
	document.getElementById('employeeId').value = employeeId;
	document.getElementById('identificationId').value = identificationTypeId;
	if(employeeId!="" && identificationTypeId=="")
	{
		$('#uploadSection').show();
		getIdTypeList();
	}	
	
});

function updatePassword(){
	
	var userName=$('#userName').val();
	if(userName=="" ) {
    	alert("Please enter usernam number");
    	document.getElementById('userName').focus();
        return false;
      }
	
	var currentPassword=$('#currentPassword').val();
	if(currentPassword=="" ) {
    	alert("Please enter new password");
    	document.getElementById('currentPassword').focus();
        return false;
      }
	var check=document.getElementById('currentPassword').reportValidity();
	if (check==false) {
	    alert("Password Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters");
	    return false;
	}
	
	var newPassword=$('#newPassword').val();
	if(newPassword=="" ) {
    	alert("Please enter new confirm password");
    	document.getElementById('newPassword').focus();
        return false;
      }
	 
	if(currentPassword!=newPassword)
	{
		alert("Your new password is not match is confirm password")
		return false;
	}
	var employeeId = $('#employeeId').val();
	var identificationTypeId= $('#identificationId').val();
	var empProfileImage='';
	var empIdType='';
	var empIdNumber='';
	var idPhoto='';
	var base64ForProfileStr='';
	var base64ForIdStr='';
	var idMimeType='';
	if(employeeId!="" && identificationTypeId=="")
	{	
	  empProfileImage = $('#empProfileImage').val();
	  empIdType = $('#empIdType').val();
	 idPhoto = $('#idPhoto').val();
	 empIdNumber = $('#empIdNumber').val();
	
	if(empProfileImage == ''){
		alert("Please upload profile picture");
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
	if(idPhoto == ''){
		alert("Please upload ID proof");
		return;			
	}
	
	 base64ForProfileStr = $('#base64ForProfile').val();
	 base64ForIdStr =  $('#base64ForId').val();
	 idMimeType =  $('#idMimeType').val();
	}
	
	 $("#btnSubit").attr("disabled", true);

	 var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";
	var urlPath = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/user/updateUsersRegistartionType"; 
	
    var form = $('#fileUploadForm')[0];
	// Create an FormData object 
    var formData = new FormData(form);
    
    formData.append("userId","");
    formData.append("userTypeValues", "");
    formData.append("masRoleIdValues","");
    formData.append("nameOfUser",userName);
    formData.append("emailId",newPassword);
    formData.append("levelUsers","");
    formData.append("userTypeVal","changePassword");
    formData.append("empProfileImage",empProfileImage);
    formData.append("empIdNumber",empIdNumber);
    
    formData.append("base64ForProfileStr",base64ForProfileStr);
    formData.append("base64ForIdStr",base64ForIdStr);
    formData.append("idMimeType",idMimeType);
	$.ajax({
		url : urlPath,
		dataType : "json",
		data : JSON.stringify({
			'userId':'',
			'userTypeValues' : '',
			'masRoleIdValues' : '',
			'mobileNo': '',
            'nameOfUser':userName,
            'emailId': newPassword,
            'levelUsers': '',
            'userTypeVal':'changePassword',
            "empProfileImage":empProfileImage,
            "empIdNumber":empIdNumber,
            "empIdType":empIdType,
            "base64ForProfileStr":base64ForProfileStr,
			"base64ForIdStr":base64ForIdStr,
			"idMimeType":idMimeType
            
			
		}),
		type : "POST",
		 enctype: 'multipart/form-data',
         data: formData,
         processData: false,
         contentType: false,
         cache: false,
         dataType : "json",
         timeout : 100000,
		success : function(response) {
			
			if(response.status=="success"){
				//$('#errordiv').val("");
				//$('#messForTranstion').append(""+resourceJSON.msgForUnitAdminCreateNormalUser);
				//$('#messForTranstion').show();
				alert("User successfully created")
				window.location.reload();
			}
			if(response.status=="statusUpdated"){
				 $('#messageForCreate').show();
				 $('.modal-backdrop').show();
				
			}
			 
		if(response.status=="updateSuccess"){
			$('#errordiv').val("");
			$('#messForTranstion').append(""+resourceJSON.msgForUnitAdminUpdateNormalUser);
			$('#messForTranstion').show();	
		}
		
		if(response.status=="fail"){
			$('#errordiv').append(""+resourceJSON.msgForUnitAdminAlreadyExistNormalUser);
			$('#errordiv').show();	
			
		}
		$("#btnSubit").attr("disabled", false);	
		}
	
	});
 }

function getIdTypeList(){
	 
	 var params = { };
	 var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";
	var urlPath = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/empRegistration/getIdTypeList"; 
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : urlPath,
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(data) {
			if(data.status == true){
				var list = data.list;
				var idDrop = '<option value="">Select</option>';
				$j('#empIdType').find('option').not(':first').remove();
				for(i=0;i<list.length;i++){
					idDrop += '<option value='+list[i].id+'>'+list[i].IdName+'</option>';
				}
				$j('#empIdType').append(idDrop);
			}
		},
		error : function(data) {
			alert("An error has occurred while contacting the server");
		}
	}); 
}

function getBase64StringForIDandProfile(fileInput,idtoStore,mimeTypeId){
	
	var fileInput = document.getElementById(fileInput);
	if(fileInput != null && fileInput != ''){
	var reader = new FileReader();
	if(fileInput.files[0]){
		reader.readAsDataURL(fileInput.files[0]);
	}

	reader.onload = function () {
		imageString = reader.result;
		 document.getElementById(idtoStore).value = reader.result;
		 var parts = imageString.split(",");
		 document.getElementById(idtoStore).value = parts[1];
		 mimeType = parts[0].substring(parts[0].indexOf('/') + 1, parts[0].indexOf(';base64'));
		document.getElementById(mimeTypeId).value = mimeType;
		if(idtoStore == 'base64ForProfile'){
			profileImage.setAttribute('src', "data:image/"+mimeType+";base64," +parts[1]);
		}
}
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
            alert('Allowed Extensions are : *. ' + allowedExtension.join(', *.') + ' for profile image');
            $('#empProfileImage').attr('value', '');
            return false;
        } else 
        	return true;
	}
}

function validateIdProof() 
{
	if(document.getElementById('idPhoto').value != ''){
    var allowedExtension = ['jpeg', 'jpg','png','doc','docx','pdf'];
    var fileExtension = document.getElementById('idPhoto').value.split('.').pop().toLowerCase();
    var isValidFile = false;

        for(var index in allowedExtension) {

            if(fileExtension === allowedExtension[index]) {
                isValidFile = true; 
                break;
            }
        }

        if(!isValidFile) {
            alert('Allowed Extensions are : *. ' + allowedExtension.join(', *.') + ' for ID Proof');
            $('#idPhoto').attr('value', '');
            return false;
        } else 
        	return true;
	}  

}

function reloadApplication()
{
	   window.location="${pageContext.request.contextPath}/dashboard/dashboard";  
}

</script>


<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
</head>
<body>
    <!-- Begin page -->
    <div id="wrapper">
      
        <div class="content-page">
            <!-- Start content -->
            <div class="">
                <div class="container-fluid">
                <div class="internal_Htext">Change Password</div>
                  <form method="post" name="fileUploadForm" id="fileUploadForm">                     
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                    <div class="row">                                                                     
                                        
                                           <div class="col-12">
                                           	<h6 class="font-weight-bold text-theme text-underline">Change Password</h6>
                                           	
                                           </div>
                                                   <div class="col-md-5">
	                                                   <div class="form-group row">
	                                                    <label class="col-md-4 col-form-label inner_md_htext">User Name</label>
		                                                    <div class="col-md-7">
		                                                      <input type="text" name="userName" id="userName" class="form-control" readonly="readonly">            
		 
		                                                    </div>
	                                                    </div>
                                                    </div>
                                                    <div class="w-100"></div>
                                               <div class="col-md-5">
                                                   <div class="form-group row">
		                                                     <label class="col-md-4  col-form-label inner_md_htext">New Password</label>
			                                               
			                                                  <div class="col-md-7">
														 
															
															<input name="currentPassword" id="currentPassword" type="password"
															class="form-control border-input"
															placeholder=" " pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" required  />
														
													</div>  
			                                                    
                                                    </div>
                                                </div>
                                                   <div class="w-100"></div>
                                                <div class="col-md-5">
                                                   <div class="form-group row">
		                                                     <label class="col-md-4  col-form-label inner_md_htext">Confirm Password</label>
			                                               
			                                                  <div class="col-md-7">
														 
															
															<input name="newPassword" id="newPassword" type="password"
															class="form-control border-input"
															placeholder=" " value=""  />
														
													</div>  
                                                </div>
                                                </div>
                                               <div id="message">
													  <h3>Password must contain the following:</h3>
													  <p id="letter" class="invalid">A <b>lowercase</b> letter</p>
													  <p id="capital" class="invalid">A <b>capital (uppercase)</b> letter</p>
													  <p id="number" class="invalid">A <b>number</b></p>
													  <p id="length" class="invalid">Minimum <b>8 characters</b></p>
													</div>
                                               
		                                          
                                                    
                                                </div>
                                                
                                                
                                                <div class="row" id="uploadSection" style="display: none">
                                                <input class="form-control m-t-10" type="hidden" id="employeeId" value="">
                                                <input class="form-control m-t-10" type="hidden" id="identificationId" value="">
                                                <hr/>
                                                	<div class="col-12">
			                                          	<h6 class="font-weight-bold text-theme text-underline">Personal Information</h6>
			                                          	
			                                          	<h6 class="font-weight-bold text-danger m-t-10 m-b-20">Please fill in the mandatory fields</h6>
		                                          </div>
		                                          	
		                                          
													<div class="col-lg-3 col-sm-4">
														<div class="form-group row">
															<div class="col-sm-11">
																<img src="/MMUWeb/resources/images/photo_icon.png" class="profileImg" alt="" width="80%" id="profileImage" />
															</div>
															<div class="col-md-11">										
																<label class="col-form-label">Profile Image<span class="mandate"><sup>&#9733;</sup></span></label>
															</div>
															<div class="col-md-11">
																<div class="fileUploadDiv m-b-10">
																  	<input type="file" class="inputUpload" name="empProfileImage" id="empProfileImage" onblur="if(validateImage()){getBase64StringForIDandProfile(this.id,'base64ForProfile','profileMimeType');}">
										  							<label class="inputUploadlabel">Choose File</label>
																	<span id="spanInputUploadFileName" class="inputUploadFileName">No File Chosen</span>
																	<textarea id="base64ForProfile" style="display: none;"></textarea>
																	<input type="hidden" id="profileMimeType" name="profileMimeType" class="form-control"  />																	
															  	</div>
															</div>
														</div>
													</div>
													
                                                	<div class="col-lg-5 col-sm-12">
                                                		<div class="row">
                                                			<div class="col-12">
																<div class="form-group row">
																	<div class="col-md-4">
																		<label class="col-form-label">ID Type<span class="mandate"><sup>&#9733;</sup></span></label>
																	</div>
																	<div class="col-md-7">
																		<select class="form-control" id="empIdType" name="empIdType" onchange="setLengthAndinput()"></select>
																	</div>
																</div> 
															</div>
															
															<div class="col-12">
																<div class="form-group row">
																	<div class="col-md-4">
																		<label class="col-form-label">ID Number<span class="mandate"><sup>&#9733;</sup></span></label>
																	</div>
																	<div class="col-md-7">
																		<input type="text" id="empIdNumber" name="empIdNumber" class="form-control"  />
																	</div>
																</div> 
															</div>
															
															<div class="col-12">
																<div class="form-group row">
																	<div class="col-md-4">
																		<label class="col-form-label">ID Upload<span class="mandate"><sup>&#9733;</sup></span></label>
																	</div>
																	<div class="col-md-7">
																		<div class="fileUploadDiv m-b-10">
																		  		<input type="file" class="inputUpload" name="idPhoto" id="idPhoto" onblur="if(validateIdProof()){getBase64StringForIDandProfile(this.id,'base64ForId','idMimeType');}">
																			  	<label class="inputUploadlabel">Choose File</label>
																				<span id="" class="inputUploadFileName">No File Chosen</span>
																				<textarea id="base64ForId" style="display: none;"></textarea>
																				<input type="hidden" id="idMimeType" name="idMimeType" class="form-control"  />												
																	  	</div>
																	</div>
																</div> 
															</div>
                                                		</div>
                                                	</div>
                                                	
                                               		
                                                	
                                                </div>
                                                
                                      <div class="row">
                                      <div class="col-12 m-t-10 text-right">
														 <button type="button" id="btnSubit" class="btn btn-primary " onclick="updatePassword()">Submit</button>
														
                                                </div>
                                                </div>
                                        
                                              
                                            
                                      </div> 
 
 
                                    </div>
                                                
                                                
                                                
                                                
                                                
                                                
                                            
                                        </div>
                                    </div>
						 </form>
                                  

                                    <!-- end row -->

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
            <!-- content -->

<div class="modal" id="messageForCreate" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<span class="Message_htext"><spring:message
								code="lblIndianCoastGuard" /></span>

						<button type="button" onClick="closeMessage();" class="close"
							data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>

					</div>
					<div class="modal-body">
						<div class="control-group">

							<div class="col-md-12">
								<div class="form-group ">
									<span><spring:message code="msgForChangePassword" /></span> 
								
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" id="submitMOValidateFormByModelId"  data-dismiss="modal"
							onClick="reloadApplication();" aria-hidden="true">
							<spring:message code="btnOK" />
						</button>
						<%-- <button class="btn btn-primary" data-dismiss="modal"
							onClick="closeMessage();" aria-hidden="true">
							<spring:message code="btnClsoe" />
						</button> --%>
					</div>
					
					
					
				</div>
			</div>
		</div>
            

    <!-- END wrapper -->

    <!-- jQuery  -->
    

</body>
<script>
var myInput = document.getElementById("currentPassword");
var letter = document.getElementById("letter");
var capital = document.getElementById("capital");
var number = document.getElementById("number");
var length = document.getElementById("length");

// When the user clicks on the password field, show the message box
myInput.onfocus = function() {
  document.getElementById("message").style.display = "block";
}

// When the user clicks outside of the password field, hide the message box
myInput.onblur = function() {
  document.getElementById("message").style.display = "none";
}

// When the user starts to type something inside the password field
myInput.onkeyup = function() {
  // Validate lowercase letters
  var lowerCaseLetters = /[a-z]/g;
  if(myInput.value.match(lowerCaseLetters)) {
    letter.classList.remove("invalid");
    letter.classList.add("valid");
  } else {
    letter.classList.remove("valid");
    letter.classList.add("invalid");
}

  // Validate capital letters
  var upperCaseLetters = /[A-Z]/g;
  if(myInput.value.match(upperCaseLetters)) {
    capital.classList.remove("invalid");
    capital.classList.add("valid");
  } else {
    capital.classList.remove("valid");
    capital.classList.add("invalid");
  }

  // Validate numbers
  var numbers = /[0-9]/g;
  if(myInput.value.match(numbers)) {
    number.classList.remove("invalid");
    number.classList.add("valid");
  } else {
    number.classList.remove("valid");
    number.classList.add("invalid");
  }

  // Validate length
  if(myInput.value.length >= 8) {
    length.classList.remove("invalid");
    length.classList.add("valid");
  } else {
    length.classList.remove("valid");
    length.classList.add("invalid");
  }
}
</script>

</html>