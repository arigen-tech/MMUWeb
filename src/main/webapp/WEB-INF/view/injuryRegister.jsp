<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>
<%@include file="..//view/commonModal.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/commonformodal.js"></script>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<head>
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

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<title>Asha Application</title>
<!--   <link href="/AshaWeb/resources/css/stylecommon.css" rel="stylesheet" type="text/css" /> -->


<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
</head>

<%
	int i = 1;
%>

<body>
<div id="wrapper">
	<div class="content-page">
		<!-- Start content -->

		<div class="container-fluid">
			<div class="internal_Htext">Injury Report Register</div>
						
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-body">	
							<form:form name="submitInjury" id="submitInjury" method="post" enctype='multipart/form-data'
										action="${pageContext.request.contextPath}/miAdmin/submitInjuryRegister" autocomplete="off">
								
							<div class="row">	
							<!-- <div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label"> Date</label>
										</div>
										<div class="col-md-7">
											<div class="dateHolder">
												<input type="text" name="injuryDate" id="injuryDate" class="noFuture_date2 form-control" />
											</div>
										</div>
									</div>															
								</div>	 -->						
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Service No</label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" id="serviceNo" name="serviceNo" onblur="getEmpDetails()"/>
											<span id="msg" style="color:red; font-weight: bold;"></span>
											</div>
									</div>															
								</div>
								
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Emp Name</label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" id="empName" name="empName" readonly />
										</div>
									</div>															
								</div>
								<input type="hidden" class="form-control" id="empId" name="empId" readonly />
								<input type="hidden" class="form-control" id="icdId" name="icdId" readonly />
								<input type="hidden" class="form-control" id="rankId" name="rankId" readonly />
								<input type="hidden" class="form-control" id="genderId" name="genderId" readonly />
								<input type="hidden" class="form-control" id="patientId" name="patientId" readonly />
								<input type="hidden"  name="userId" value=<%=userId%> id="userId" />
								
								
								<div class="col-md-4" id="rankNameDiv" >
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Rank</label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" id="rank" name="rank" readonly />
										</div>
									</div>															
								</div>
								<div class="col-md-4" id="rankDiv" style="display:none">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Rank</label>
										</div>
										<div class="col-md-7">
											<select class="form-control" id="rankIdd" name="rankIdd">
												<option value="0">Select</option>
											</select>
										</div>
									</div>															
								</div>
								<div class="col-md-4" id="dobNDiv">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Date of birth</label>
										</div>
										<div class="col-md-7">
											<div class="dateHolder">
											<input type="text" class="form-control " id="birthDate" name="birthDate" onchange="calculateAge()" readonly />
											</div>
										</div>
									</div>															
								</div>
								<div class="col-md-4" id="dobDiv" style="display:none">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Date of birth</label>
										</div>
										<div class="col-md-7">
											<div class="dateHolder">
											<input type="text" class="form-control  noFuture_date2" id="birthDatecal"  onchange="calculateAge()" placeholder="DD/MM/YYYY"  />
											</div>
										</div>
									</div>															
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Age</label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" id="age" name="age" readonly />
										</div>
									</div>															
								</div>
								<div class="col-md-4" id="genderNameDiv">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Gender</label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" id="gender" name="gender" readonly />
										</div>
									</div>															
								</div>
								 <div  class="col-md-4" id="genderDiv" style="display:none" >
                                                                    <div class="form-group row">
                                                                        <label for="service" class="col-md-5 col-form-label">Gender</label>
                                                                        <div class="col-md-5">
                                                                            <select id="genderIdd" name="gender" class="form-control">
                                                                                <option value="0" selected="selected">Select</option>
                                                                                 <!-- <option value="1" >Male</option>
                                                                                <option value="2" >Female</option> -->
                                                                                
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                  </div>
								<div class="col-md-4">
												<div class="form-group row">

												<label class="col-md-5 col-form-label">ICD
														Diagnosis <span
													style="color: red"><sup>&#9733;</sup></span> </label>
													<div class="col-md-7">
														<!-- <input name="icddiagnosis" id="icd" type="text"
															class="form-control border-input"
															placeholder=" " value=""  onKeyPress="autoCompleteCommon(this,'5');"
															onblur="fillDiagnosisCombo(this.value);" /> -->
															<div class="autocomplete forTableResp">
															<input name="icddiagnosis" id="icd" type="text"
															class="form-control border-input"
															placeholder=" " value=""  onKeyUp="getNomenClatureList(this,'fillDiagnosisCombo','opd','getIcdListByName','diagnosismi');"  />
															
															<div class="autocomplete-itemsNew" id="icdDiagnosisUpdate" ></div>
															</div>
													</div>

												</div>
											</div>

											<div class="col-md-4" id="diagnosisValueUpdate" style="margin-bottom:6px;">
												<select name="diagnosisId" multiple="4" size="5"
													tabindex="1" id="diagnosisId" class="listBig width-full"
													validate="ICD Daignosis,string,yes">
												</select>
											</div>
											<div class="col-md-4">
												<button type="button" class="buttonDel btn btn-danger" value=""
													onclick="deleteDgItems(this,'diagnosisId');" align="right" />
												Delete
												</button>

												
												<!-- <div class="form-check form-check-inline cusCheck m-t-10 m-l-10">
													<input class="form-check-input" type="checkbox" onclick="addNAIcd('">
													<span class="cus-checkbtn"></span> 
													<label class="form-check-label" for="zdiagcheckbox">Not Available</label>
												</div> -->
											</div>
								<!-- <div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Diagnosis</label>
										</div>
										<div class="col-md-7 autocomplete">
											<input name="icddiagnosis" id="icd" type="text" autocomplete="off"
															class="form-control border-input" value="" onblur="checkValue(this)"
															onKeyUp="getNomenClatureList(this,'fillDiagnosisCombo','opd','getIcdListByName','diagnosismi')" />
																<div id="divIdPVMS" class="autocomplete-itemsNew"></div>
														
										</div>
									</div>															
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">ICD No</label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" id="icdNo" name="icdNo" readonly />
										</div>
									</div>															
								</div> -->
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Letter No</label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" id="letterNo" name="letterNo"  />
										</div>
									</div>															
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Letter Date</label>
										</div>
										<div class="col-md-7">
											<div class="dateHolder">
											<input type="text" class="form-control  noFuture_date2" id="letterDate" name="letterDate" placeholder="DD/MM/YYYY" />
											</div>
										</div>
									</div>															
								</div>
								
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Approving admin authority name</label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" id="authorityletterNo" name="authorityletterNo"  />
										</div>
									</div>															
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Date of Approval</label>
										</div>
										<div class="col-md-7">
											<div class="dateHolder">
											<input type="text" class="form-control  noFuture_date2" id="approvalDate" name="approvalDate" placeholder="DD/MM/YYYY" />
											</div>
										</div>
									</div>															
								</div>
								
										<div class="col-md-4">
											<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Injury Report</label>
											</div>
												<div class="col-md-7">
													<div class="fileUploadDiv">
														<input type="file" id="fileUploadid" class="inputUpload" name="fileInvUploadDyna">
														<label class="inputUploadlabel">Choose File</label>
														<span class="inputUploadFileName">No File Chosen</span>
													</div>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Approval Letter</label>
											</div>
												<div class="col-md-7">
													<div class="fileUploadDiv">
														<input type="file" id="fileUploadidaletter" class="inputUpload" name="fileInvUploadDynaletter">
														<label class="inputUploadlabel">Choose File</label>
														<span class="inputUploadFileName">No File Chosen</span>
													</div>
												</div>
											</div>
										</div> 
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Remarks</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" id="remark" name="remark" maxlength="2000"></textarea>
										</div>
									</div>															
								</div>											
							</div>
							<div class="row m-t-10">								
								<div class="col-md-12 text-right">
									<input type="submit" class="btn btn-primary "
														name="submit" value="Submit" id="saveForm1"  onclick="return submitForm();" />														
								<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/miAdmin/injuryRegisterReport">Back</a>
														
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

</body>
<script>
	var nPageNo=1;
	var Status;
	var $j = jQuery.noConflict();
	var user_Id = <%= userId %>
	
	//Rank list
	var rankValues = "";
  var rankListDict = ${rankList}
  var rankData = rankListDict.data;
 
  for (category in rankData) {

	  rankValues += '<option  value=' + rankData[category]  + '>' + category + '</option>';
  }
  $j('#rankIdd').append(rankValues);
  
//get gender
  var genderValues = "";
var genderListDict = ${genderList}
for (gender in genderListDict) {

	genderValues += '<option  value=' + gender + '>' + genderListDict[gender] + '</option>';
}
$j('#gender11').append(genderValues); 
 	function getEmpDetails(){
 		document.getElementById("empName").value="";
 		document.getElementById("empId").value="";
  		document.getElementById("age").value="";
  		document.getElementById("birthDate").value="";
  		document.getElementById("rank").value="";
  		document.getElementById("rankId").value="";
  		document.getElementById("gender").value="";
  		document.getElementById("genderId").value="";
  		document.getElementById("patientId").value="";
 		document.getElementById("msg").innerHTML="";
 		 var sNo = $j("#serviceNo").val();
 			//alert(sNo);
 		 var serviceNo={"memberService":sNo};
 		 jQuery.ajax({
 	 	 	crossOrigin: true,
 	 	    method: "POST",			    
 	 	    crossDomain:true,
 	 	    url: "getPatientDetails",
 	 	    data:JSON.stringify(serviceNo),
 	 	    contentType: "application/json; charset=utf-8",
 	 	    dataType: "json",
 	 	    success: function(result){
 	 	    	if(result.status==1){
 	 	    		document.getElementById("empName").value=result.name;
 	 	    		document.getElementById("empId").value=result.empId;
 	 	    		document.getElementById("age").value=result.age;
 	 	    		
 	 	    		document.getElementById("birthDate").value=result.dob;
 	 	    		document.getElementById("rank").value=result.rank;
 	 	    		document.getElementById("rankId").value=result.rankId;
 	 	    		document.getElementById("gender").value=result.gender;
 	 	    		document.getElementById("genderId").value=result.genderId;
 	 	    		document.getElementById("patientId").value=result.patientId;
 	 	    		
 	 	    		if(result.rankId == "" || result.rankId == null){
 	 	    			$j("#rankNameDiv").hide();
 	 	    			$j("#rankDiv").show();
 	 	    			
 	 	    		}
 	 	    		
 	 	    		if(result.genderId == "" || result.genderId == null){
 	 	    			
 	 	    			$j("#genderNameDiv").hide();
 	 	    			$j("#genderDiv").show();
 	 	    			
 	 	    		}
 	 	    		
 	 	    		if(result.dob == "" || result.dob == null){
 	 	    			$j("#dobNDiv").hide();
 	 	    			$j("#dobDiv").show();
 	 	    			
 	 	    		}
 	 	    	
 	 	    	}
 	 	    	else if(result.status==0){
 	 	    		console.log(result.msg);
 	 	    		document.getElementById("msg").innerHTML=result.msg;
 	 	    		//$j("#serviceNo").val("");
 	 	    		document.getElementById("empName").value="";
 	 	    		document.getElementById("empId").value="";
 	 	    		document.getElementById("age").value="";
 	 	    		document.getElementById("birthDate").value="";
 	 	    		document.getElementById("rank").value="";
 	 	    		document.getElementById("rankId").value="";
 	 	    		document.getElementById("gender").value="";
 	 	    		document.getElementById("genderId").value="";
 	 	    		document.getElementById("patientId").value="";
 	 	    		
 	 	    	}
 	 	    	
 	 	    },
 	 	    error: function(result) {
 	             alert("An error has occurred while contacting the server");
 	         }
 	 	    
 	 	});
 	 	
 	}
 	function submitForm() {
 		$('#diagnosisId option').prop('selected', true);
 		 var sNo = $j("#serviceNo").val();
 		 var age = $j("#age").val();
 		 var empName = $j("#empName").val();
 		 var rank = $j("#rank").val();
 		 var diagnosis = $j("#diagnosisId").val();
 		 var gender = $j("#gender").val();
 		 var letterNo = $j("#letterNo").val();
 		 var letterDate = $j("#letterDate").val();
 		 var remark = $j("#remark").val();
 		 var birthDate = $j("#birthDate").val();
  	    
		 if (sNo == null || sNo == "") {
	         alert("Please enter Service Number");
	          return false;
	     }
	  	 if (age == null || age == "") {
         	alert("Please enter age");
        	 return false;
    	 }
	 	 if (empName == null || empName == "") {
	         alert("Please enter emp name");
	         return false;
	     }
	 	 
	 	var birthDatecal = $j("#birthDatecal").val();
	 	if (birthDate == null || birthDate == "") {
	         if(birthDatecal == null || birthDatecal == "") {
	        	 alert("Please select  birth date");
	 	        
	                return false;
	            }else{
	           	 $j("#birthDate").val(birthDatecal);
		 			 
	            }
	     }
	 	var rankIdd = $j("#rankIdd").val();
		 if (rank == null || rank == "") {
		   if(rankIdd == null || rankIdd == "" ||rankIdd == 0) {
			    alert("Please select rank");
                return false;
            }else{
           	 $j("#rankId").val(rankIdd);
	 			 
            }
    }
		 
		 var genderIdd = $j("#genderIdd").val();
		 if (gender == null || gender == "") {
		   if(genderIdd == null || genderIdd == "" ||genderIdd == 0) {
			    alert("Please select gender");
                return false;
            }else{
           	 $j("#genderId").val(genderIdd);
	 			 
            }
    }
		
	 	 if (diagnosis == null || diagnosis == "") {
	         alert("Please enter diagnosis");
	         return false;
	     }
	 	/*  if (icdNo == null || icdNo == "") {
	         alert("Please enter ICD No");
	         return false;
	     } */
	 	 if (letterNo == null || letterNo == "") {
	         alert("Please enter Authority Letter No");
	         return false;
	     }
	 	 if (letterDate == null || letterDate == "") {
	         alert("Please select Authority letter date");
	         return false;
	     }
	 	 if (remark == null || remark == "") {
	         alert("Please enter remark");
	         return false;
	     }
	 	
 		
 			$("#submitInjury").submit();
 			setTimeout(function(){ 			 
 				 $("#saveForm1").attr("disabled", "disabled");
 				   
 			 }, 50);
 	}
 	 var autoIcdCode = '';
     var icdData= '';	 
      var idIcdNo = '';
      var icdValue = '';
      var multiIcdValue=[];
     
     var total_icd_value = '';
     var digaoReferal=''; 
 	  function checkValue() {
 		var val=document.getElementById('icd').value ;
 		if(val == ""){
 			  document.getElementById('icdNo').value = "";
 		}
 	 }
 	      
         function fillDiagnosisCombo1(val) {
          var index1 = val.lastIndexOf("[");
             var index2 = val.lastIndexOf("]");
             index1++;
             idIcdNo = val.substring(index1, index2);
            document.getElementById('icdNo').value = idIcdNo;
             if (idIcdNo == "") {
                 return;
             } else {
                 
                 for(var i=0;i<autoIcdCode.length;i++){
              		  
              		  var icdNo1 = icdData[i].icdCode;
              		 
              		  if(icdNo1 == idIcdNo){
              			icdValue = icdData[i].icdId;
              			document.getElementById('icdId').value = icdValue;
              			multiIcdValue.push(icdValue);
              			digaoReferal=icdValue;
              			
              		  }
              	  }
                 
             } 
         }
         
         function fillDiagnosisCombo(val) {
             var index1 = val.lastIndexOf("[");
             var index2 = val.lastIndexOf("]");
             index1++;
             idIcdNo = val.substring(index1, index2);
             if (idIcdNo == "") {
                 return;
             } else {
                 obj = document.getElementById('diagnosisId');
                 total_icd_value += val+",";
           	    
                 obj.length = document.getElementById('diagnosisId').length;
                 var b = "false";
                 for (var i = 0; i < obj.length; i++) {
						
                     var val2 = obj.options[i].text;
                     var index1 = val2.lastIndexOf("[");
                     var index2 = val2.lastIndexOf("]");
                     index1++;
                     var idIcdNoUpdate = val2.substring(index1, index2);
                     
                     if (idIcdNo == idIcdNoUpdate) {
                     	
                     	alert("ICD  Already taken");
                         
                     	document.getElementById('icd').value = ""
                         b = true;
                     }

                 }
               
                 for(var i=0;i<autoIcdCode.length;i++){
              		  
              		  var icdNo1 = icdData[i].icdCode;
              		 
              		  if(icdNo1 == idIcdNo){
              			icdValue = icdData[i].icdId;
              			multiIcdValue.push(icdValue);
              			digaoReferal=icdValue;
              		  }
              	  }
                 if (b == "false") {
                 	
                 	
                     $('#diagnosisId').append('<option value="' + val + '">' + val + '</option>');
                     document.getElementById('icd').value = ""
                     	
                     var checkedReferValue="";
                     	$('input:radio[name=referTo]').each(function(){
                     		var checkedValue = $(this);
                     		
                     		if(checkedValue.is(':checked')){
                     			if(checkedValue.val()=='I'){
                     				checkedReferValue='internal';
                     			}
                     			else{
                     				checkedReferValue='external';
                     			}
                     		}
                     	});
                     
                     	//getReferalDataForAdd(checkedReferValue);
                 }
             }
             $('#icdIdValue').val(multiIcdValue);
         }
         
         function deleteDgItems(value) {
     	 	if (document.getElementById('diagnosisId').selectedIndex !="-1") {
     			if (confirm("are you sure want to delete ?")) {
     				document.getElementById('diagnosisId').remove(
     						document.getElementById('diagnosisId').selectedIndex)
     			}
     			
     		}else
    			alert("Please select diagnosis first");
     	}
         
         function calculateAge() {
     		var Bdate = $j('#birthDate').val()
     		var newdate = Bdate.split("/").reverse().join("-");
     		var Bday = new Date(newdate);
     		var age = parseFloat(((Date.now() - Bday) / (31557600000)), 10)
     				.toFixed(0);
     		if (age > 0 && age <= 100) {
     			$j('#age').val(age+"  years");
     			//showAge();
     		} else {
     			alert("Age can not be less then 0 or greater then 100");
     			$j('#age').val("");
     			$j('#age').val("");
     		}

     	}
         
</script>

</html>