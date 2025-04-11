<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>
<%@include file="..//view/commonJavaScript.jsp"%>
 <%@include file="..//view/commonModal.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newOpd.js"></script>  
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opd.js"></script>   
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
			<div class="internal_Htext">Hospital Visit Entry</div>
						
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-body">	
							<form:form name="submitHospitalVisit" id="submitHospitalVisit" method="post"
										action="${pageContext.request.contextPath}/miAdmin/submitHospitalVisitRegister" autocomplete="off">
								
							<div class="row">
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Date of Entry<span class="mandate"><sup>&#9733;</sup></span></label>
										</div>
										<div class="col-md-7">
											<div class="dateHolder">
											<input type="text" name="visitDate" id="visitDate" class="noFuture_date2 form-control" placeholder="DD/MM/YYYY" />
											</div>
										</div>
									</div>															
								</div>	
								
								<div class="col-12 m-t-10">
									<h6 class="text-theme text-underline font-weight-bold">Patient Details</h6>
								</div>
															
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Service No<span class="mandate"><sup>&#9733;</sup></span></label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" id="serviceNo" name="serviceNo" onblur="getEmpDetails()"/>
											<span id="msg" style="color:red; font-weight: bold;"></span>
										</div>
									</div>															
								</div>
								<div class="col-md-4" id="rankNameDiv" >
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Rank</label>
										</div>
										<div class="col-md-7">
											<input type="text"  name="rank" id="rank"  class="form-control" readonly /> 
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
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Name</label>
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
											<input type="text" class="form-control noFuture_date2" id="birthDatecal"  onchange="calculateAge()" placeholder="DD/MM/YYYY"  />
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
										<div class="col-md-5">
											<label class="col-form-label">Hospital Name<span class="mandate"><sup>&#9733;</sup></span></label>
										</div>
										<div class="col-md-7">
											<input type="text" name="hospitalName" id="hospitalName" class="form-control" maxlength="200"/>
										</div>
									</div>															
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Ward Name</label>
										</div>
										<div class="col-md-7">
											<input type="text" name="wardName" id="wardName" class="form-control" maxlength="200"/>
										</div>
									</div>															
								</div>
								<div class="w-100"></div>
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
											<label class="col-form-label">Diagnosis<span class="mandate"><sup>&#9733;</sup></span></label>
										</div>
										<div class="col-md-7">
										<input name="icddiagnosis" id="icd" type="text" autocomplete="off"
															class="form-control border-input" value=""
														onKeyUp="getNomenClatureList(this,'fillDiagnosisCombo','opd','getIcdListByName','diagnosismi')" />
																<div id="divIdPVMS" class="autocomplete-itemsNew"></div>
														
										</div>
									</div>															
								</div> -->
								
								
								<!-- <div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Visit by Medical Dept.</label>
										</div>
										<div class="col-md-7">
											<input type="text" name="medicalDept" id="medicalDept" class="form-control" maxlength="200"/>
										</div>
									</div>															
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Visit &amp; Remarks by Div Officer &amp; Div Chief</label>
										</div>
										<div class="col-md-7">
											<input type="text" name="divChief" id="divChief" class="form-control" maxlength="2000"/>
										</div>
									</div>															
								</div>
								
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Remarks</label>
										</div>
										<div class="col-md-7">
											<textarea name="remark" id="remark" class="form-control" maxlength="2000"></textarea>
										</div>
									</div>															
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Captain Remark</label>
										</div>
										<div class="col-md-7">
											<textarea name="captainRemark" id="captainRemark" class="form-control" maxlength="2000"></textarea>
										</div>
									</div>															
								</div>	 -->	
								
								<div class="col-12 m-t-10">
									<h6 class="text-theme text-underline font-weight-bold">Visitor Details</h6>
									
									<table class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th>Visitor<span class="mandate"><sup>&#9733;</sup></span></th>
												<th>Rank &amp; Name of Visitor<span class="mandate"><sup>&#9733;</sup></span></th>
												<th>Remarks</th>
												<th>Add</th>
												<th>Delete</th>
											</tr>
										<thead>
										<tbody id="visitorGrid">
											<tr>
												<td>
													<div class="">
							                            <div class="form-group ">							                                
							                                    <select class="form-control" id="visitor1" name="visitor">
							                                    <option value="0">Select</option>
							                                    <option value="Captain"> Captain</option>
							                                    <option value="Div. Officer">Div. Officer </option>
							                                    <option value="Div. Chief">Div. Chief</option>
							                                    <option value="Medical Department">Medical Department</option>
							                                    
							                                    </select>
							                               
							                            </div>
							                        </div>
												</td>
												<td>
													<textarea class="form-control" id="visitorName1" name="visitorName"  rows="2"></textarea>
												</td>
												<td>
													<textarea class="form-control" id="remark1" name="remark" rows="2"></textarea>
												</td>
												<td>

															<button type="button" class="btn btn-primary buttonAdd noMinWidth"
																name="button" button-type="add" value=""
																onclick="addNomenclatureRow1();showLastRow();" tabindex="1"></button>

														</td>
														<td>


															<button type="button" class="buttonDel  btn btn-danger noMinWidth m-r-20"
																name="button" button-type="delete" value="" tabindex="1"
																onclick="removeRowIndent(this);"></button>

														</td>	
											</tr>
										</tbody>
									</table>
								</div>
								
																	
							</div>
							<div class="row m-t-10">								
								<div class="col-12 text-right">
									<input type="submit" class="btn btn-primary "
														name="submit" value="Submit" id="saveForm1"  onclick="return submitForm();" />														
									<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/miAdmin/hospitalVisitReport">Back</a>
																													
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
	var i=1;
	
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
 	 	    		document.getElementById("rank").value=result.rank;
 	 	    		 //$j(".check").prop("readonly", false);

 	 	    		document.getElementById("birthDate").value=result.dob;
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
 		 var visitDate = $j("#visitDate").val();
 		 var sNo = $j("#serviceNo").val();
 		 var rank = $j("#rank").val();
 		 var age = $j("#age").val();
 		 var empName = $j("#empName").val();
 		 var diagnosis = $j("#diagnosisId").val();
 		 var wardName = $j("#wardName").val();
 		 var hospitalName = $j("#hospitalName").val();
 		 var remark = $j("#remark").val();
 		 var gender = $j("#gender").val();
 		 var birthDate = $j("#birthDate").val();
 		 
 		 if (visitDate == null || visitDate == "") {
	         alert("Please select Date");
	         return false;
	     }
		 if (sNo == null || sNo == "") {
	         alert("Please enter Service Number");
	          return false;
	     }
		 if (rank == null || rank == "") {
	         alert("Please enter rank");
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
	 	 
	 	 if (hospitalName == null || hospitalName == "") {
	         alert("Please enter hospital name");
	         return false;
	     }
	 	 if (wardName == null || wardName == "") {
	         alert("Please enter ward name");
	         return false;
	     }
	 	if (diagnosis == null || diagnosis == "") {
	         alert("Please enter diagnosis");
	         return false;
	     }
	 	 var flag=0;
		  $("#visitorGrid tr").each(function () {
			 var visitor=$(this).find('td:eq(0)').find('select').val();
		 	 var visitorName=$(this).find('td:eq(1)').find(':input').val();
		 	 var remarks=$(this).find('td:eq(2)').find('input').val();
		 	 if (visitor == null || visitor == "" || visitor==0) {
			        alert("Please select visitor type");
			        flag=1;
			        return false;
			    }
			 if (visitorName == null || visitorName == "") {
		         alert("Please enter the visitorName and rank");
		         flag=1;
		         return false;
		     }
			
		    
		    
		  });
		    if(flag==1){
		    	return false;
		    }
		
 			 $("#submitHospitalVisit").submit();
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
         function fillDiagnosisCombo1(val) {
         	  
             var index1 = val.lastIndexOf("[");
             var index2 = val.lastIndexOf("]");
             index1++;
             idIcdNo = val.substring(index1, index2);
            //document.getElementById('icdNo').value = idIcdNo;
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
         
         
         function addNomenclatureRow1() {
        	  i++;
        	 	var aClone = $('#visitorGrid>tr:last').clone(true)
        	 	aClone.find(":input").val("");
        	 	aClone.find("td:eq(0)").find('select').prop('id', 'visitor'+i+'');
        		aClone.find("td:eq(1)").find(":input").prop('id', 'visitorName'+i+'');
        		aClone.find("td:eq(2)").find(":input").prop('id', 'remark'+i+''); 
        		aClone.clone(true).appendTo('#visitorGrid');
        		
        	}
         function showLastRow(){
        	 $('.scrollableDiv ').animate({ scrollTop: $('table').height()}, 300);
        }
         
         function removeRowIndent(obj){
        		var rowCount = $('#visitorGrid tr').length;
        		if(rowCount!==1){
        		var r = confirm("Do you want to delete the record?");
        		if (r == true) {
        				$(obj).closest('tr').remove();
        				
        		}
        			
        		 else {
        			
        			  return false;
        		 }
        		} else {
        			alert("Atleast one row should be there");
        		  return false;
        		}
        		
        	}
         
         function deleteDgItems(value) {
        	 	if (document.getElementById('diagnosisId').selectedIndex !="-1") {
        			if (confirm("are you sure want to delete ?")) {
        				document.getElementById('diagnosisId').remove(
        						document.getElementById('diagnosisId').selectedIndex)
        			}
        		}
        	 	else
        			alert("Please select diagnosis first");
        	}
</script>

</html>