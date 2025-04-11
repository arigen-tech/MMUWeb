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
<title>Capture Pre-Consultation Details Against Online Appointment</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/leftmenu.js"></script>

<script type="text/javascript">
<%			
	String mmuId = "1";
	if (session.getAttribute("mmuId") != null) {
		mmuId = session.getAttribute("mmuId") + "";
	}
	String userId = "1";
	if (session.getAttribute("userId") != null) {
		userId = session.getAttribute("userId") + "";
	}
	
	String departmentId = "2";
	if (session.getAttribute("departmentId") != null) {
		departmentId = session.getAttribute("departmentId") + "";
	}
	
	String departmentName = "";
	if (session.getAttribute("departmentName") != null) {
		departmentName = session.getAttribute("departmentName") + "";
	}
	
	String campId = "0";
	if (session.getAttribute("campId") != null) {
		campId = session.getAttribute("campId") + "";
	}
	
	String cityName = "";
	if (session.getAttribute("cityName") != null) {
		cityName = session.getAttribute("cityName") + "";
	}
%>

	var $j = jQuery.noConflict();
	var signAndSymptomsGlobalArray = [];
	$j(document).ready(function() {
		var data = ${data};
		$('#patientName').val(data.patientName);
		$('#mobileNo').val(data.mobileNo);
		$('#age').val(data.age);
		$('#gender').val(data.gender);
		//set hidden values
		$('#genderId').val(data.genderId);
		$('#patientId').val(data.patientId);
		$('#visitId').val(data.visitId);
		
		getFrequentlyUsedSymptomsList();

		$('#checkbox_div').hide();
	});
	
	var checkboxCount = '';
	function getFrequentlyUsedSymptomsList(){
		var params = {}
		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : 'getFrequentlyUsedSymptomsList',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(data) {
				if(data.status == true){
					var list = data.list;
					checkboxCount = list.length;
					//checkboxCount = '10';
					//var checkboxHTML = '<h6 class="font-weight-bold text-theme text-underline">Signs &amp; Symptoms</h6>';
					var checkboxHTML='';
					checkboxHTML += '<div class="row multiCheck">';
					for(i=0;i<list.length;i++){
						checkboxHTML += '<div class="col-md-2">';
						checkboxHTML += '<div class="form-check form-check-inline cusCheck m-r-10">';
						var cText = list[i].name+'['+list[i].id+']';
						
						checkboxHTML += "<input class='form-check-input' id='check"+i+"' name='signs' type='checkbox' value='"+cText+"'>";
						checkboxHTML += '<span class="cus-checkbtn"></span>';
						checkboxHTML += '<label class="col-form-label" for="check1">'+list[i].name+'</label>';
						checkboxHTML += '</div>';
						checkboxHTML += '</div>';
					}
					checkboxHTML += '</div>';
					$j('#checkbox_div').html(checkboxHTML);
					$j('#checkbox_div').show();
				}
			},
			error : function(data) {
				alert("An error has occurred while contacting the server");
			}
		}); 
		}
	
	function saveVitalDetailsAndUpdateVisit() {
		
		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		
		 var icdArryVal = [];
		    var diagonsisText=[];			    	
	 	$("#diagnosisId").find('span').each(
			function() {
				var id = this.id;
				var value = $(this).html();
				diagonsisText.push(value+"["+id+"]");
				var diagonsisValue=id;
				var param = {
							'symptomsId' : diagonsisValue
    	                 };
					
			icdArryVal.push(param)
		});	
	 	
	 	for(var p=0;p<checkboxCount;p++){
	 		var checkboxId = 'check'+p+'';
	 		var checkSelectedCheckbox = $('#' + checkboxId).is(":checked");
	 		console.log("checkSelectedCheckbox "+checkSelectedCheckbox);
	 		if(checkSelectedCheckbox){
	 			var symptomsText = document.getElementById(checkboxId).value;
	 	 		diagonsisText.push(symptomsText);
	 	 		
	 	 		var index1 = symptomsText.lastIndexOf("[");
	 			var index2 = symptomsText.lastIndexOf("]");
	 			index1++;
	 			var symptomsId = symptomsText.substring(index1, index2);
	 			console.log("symptoms id is "+symptomsId);
	 			var param = {
	 					'symptomsId' : symptomsId
	 	                };
	 			icdArryVal.push(param);
	 		}
	 		
	 	}
	 	
	 	var height = $('#height').val();
		if(height == ''){
			alert("Please enter height");
			return;
		}
		var weight = $('#weight').val();
		if(weight == ''){
			alert("Please enter weight");
			return;
		}
		var temp = $('#tempature').val();
		if(temp == ''){
			alert("Please enter temperature");
			return;
		}
		
		var ageArr = $('#age').val().split(" ");
		if(ageArr[0] >12 && ageArr[1] == 'Yrs'){
			var	bp = $('#bp').val();
			if(bp == ''){
				alert("Please enter bp");
				return;
			}
			var bp1 = $('#bp1').val();
			if(bp1 == ''){
				alert("Please enter bp");
				return;
			}
		}
		
		var pulse = $('#pulse').val();
		if(pulse == ''){
			alert("Please enter pulse");
			return;
		}

		var dataJSON={
  			     
      			 'visitId':$('#visitId').val(),
      			'patientId':$('#patientId').val(), 
      			'height':$('#height').val(),
      			'weight':$('#weight').val(),
      			'temperature':$('#tempature').val(),
      			'bp':$('#bp').val(),
      			'bp1':$('#bp1').val(),
      			'pulse':$('#pulse').val(),
      			'spo2':$('#spo2').val(),
      			'bmi':$('#bmi').val(),
      			'rr':$('#rr').val(),
      			'symptoms' : diagonsisText,
      			'symptomsId':icdArryVal,
      			'campId':"<%= campId %>",
      			'mmuId':"<%= mmuId %>"
      		}
		$("#saveBtn").attr("disabled", true);
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : 'saveVitalDetailsAndUpdateVisit',
			data: JSON.stringify(dataJSON),
			dataType : 'json',
			timeout : 100000,
			success : function(msg)
			{
			  if (msg.status == 1)
			   	   {
	        		   alert("Vital details inserted successfully"+'S');
	        		   //show_msg({'msg':' Vitals Details Insert successfully ','status':'1'});
	        		   
	        		   document.addEventListener('click',function(e){
	   					    if(e.target && e.target.id== 'closeBtn'){
	   	   	   				 	window.location="getPreConsultationPatientListOnline";
	   					     }
	   					 });
	        		   
	        		  /*  setTimeout(function(){ 
	        			   location.reload();
		        		   window.location.href = "preOpdWaitingList"
	        		   }, 3000); */
	        		   
	        	   }
	        		
	        	  else
	        	  {
	        		  $("#saveBtn").attr("disabled", false);
	        		  alert("Something went wrong");
	        	   }
	           },
	           error: function (jqXHR, exception) {
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
	                   msg = 'Uncaught Error.\n' + jqXHR.responseText;
	               }
	               alert(msg);
	           }
		});

}
	
	function checkBMI() {
		var a = document.getElementById("weight").value;
		var b = document.getElementById("height").value;
		if(a === '' || b == ''){
			return;
		}
		var c=b/100;
		var d=c*c;
		var sub = a/d;
		$('#bmi').val(parseFloat(Math.round(sub * 100) / 100).toFixed(2));
		
	}
	
	var total_icd_value = '';
    var digaoReferal='';   
    var icdValue = '';
      function populateSignAndSymptoms(val) {
      	  
          if (val == "") {
              return;
          } else {
              obj = document.getElementById('diagnosisId');
              total_icd_value += val+",";
             
              obj.length = document.getElementById('diagnosisId').length;
              var b = "false";
              for(var i=0;i<signAndSymptomsGlobalArray.length;i++){
           		  
           		  var name = signAndSymptomsGlobalArray[i].name;
           		 
           		  if(name == val){
           			icdValue = signAndSymptomsGlobalArray[i].id;
           			
           			 $("#diagnosisId span").each(function()
                        		{
			           				var text=$(this).text();
			           				var valueOrg=text.split('[')
			           				var idVal=valueOrg[0];
			           				
			           				if(idVal == name){
                        		    alert("Signs and Symptoms is already added");
                        		    document.getElementById('icd').value = ""
                        		    b=true;
                        		    }
                        		});
           		  }
           	  }
              if (b == "false") {
              	
                  $('#diagnosisId').append('<span id=' + icdValue + '>' + val + '</span>');
                  document.getElementById('icd').value = ""

              }
          }
      }

      
      function deleteDgItems() {
      	var deleteDiagnosis = document.getElementById('diagnosisId');
         if (deleteDiagnosis.selectedIndex == -1)
      	   {
      	       alert("Please select atleast one signs and symptoms")
      	       return false;
      	   }
      	   else
      		   {
          		   if (confirm(resourceJSON.opdIcdDeleteMsg)) {

                         if (document.getElementById('diagnosisId').options[document.getElementById('diagnosisId').selectedIndex].value != null)
                             document.getElementById('diagnosisId').remove(document.getElementById('diagnosisId').selectedIndex)

                     }
      		   }
      	
          
      }
      
      function deletePatientSympotonsItems() {
    	  
  		
    	  $('#diagnosisId').find('span').each(function() { 
    		    var id = this.id;
    		    var value = $(this).html();
    		   //var classAttr = $("#patientSympotnsId > span").attr("class");
    		    // do whatever...
    		});
    	  
        	var deletepatient = document.getElementById('diagnosisId');
           if (deletepatient.selectedIndex == -1)
        	   {
        	       alert("Please select atleast one Signs and Symptoms")
        	       return false;
        	   }
        	   else
        		   {
        		     //var psId=document.getElementById('patientSympotnsId').options[document.getElementById('patientSympotnsId').selectedIndex].value;
        		     var format = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]+/;
        		   
            		   if (confirm(resourceJSON.opdIcdDeleteMsg)) {
            			  // $("#multiDiv").find(".active").remove();
            			   var psId = $('#diagnosisId .active').attr('id');
            			   var value=$('span.active');
                          if (!format.test(psId) )
                        	   {
                        	  		$('span.active').remove();
                        	   }

            		   }
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

				<div class="internal_Htext">Capture Pre-Consultation Details Against Online Appointment</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>


								<h6 class="font-weight-bold text-theme text-underline">Patient Details</h6>
								<div class="row">
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Patient Name</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="patientName" class="form-control" disabled />
											</div>
										</div> 
									</div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Mobile No.</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="mobileNo" class="form-control"  disabled/>
											</div>
										</div> 
									</div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Gender</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="gender" class="form-control"  disabled/>
											</div>
										</div> 
									</div>
									
									<!-- <div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Date of birth</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" name="" id="dob" class="calDate form-control" value="" placeholder="DD/MM/YYYY" >
												</div>
											</div>
										</div>
									</div> -->
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Age</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="age" maxlength="2" class="form-control" disabled/>
											</div>
										</div> 
									</div>
								</div>
								<hr>
								<input type="hidden" id="visitId" value="">
								<input type="hidden" id="patientId" value="">
								<input type="hidden" id="genderId" value="">
								<h6 class="font-weight-bold text-theme text-underline">Vital Details</h6>
								<div class="row">
                                                            <div class="col-md-12">
                                                                <form>
                                                               <!--     <div class="row">
                                                                    
                                                                    
                                                                        
                                                                         <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                
                                                                                    <label   class="col-md-5 col-form-label">Patient Name</label>
                                                                              
                                                                                <div class="col-md-7">
                                                                                     <input name="patients_name"
																						id="patient_name" type="text"
																						class="form-control border-input" 
																						value="" readonly />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                                                                                           
                                                                        
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                               
                                                                                   <label   class="col-md-5 col-form-label">Gender </label>
                                                                              
                                                                                <div class="col-md-7">
                                                                                   <input name="gender" id="gender"
																						type="text" class="form-control border-input"
																						value="" readonly />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                               
                                                                                   <label   class="col-md-5 col-form-label">DOB </label>
                                                                              
                                                                                <div class="col-md-7">
                                                                                   <input name="dob" id="dob"
																						type="text" class="form-control border-input"
																						value="" readonly />
                                                                                </div>
                                                                            </div>
                                                                        </div> 
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                              
                                                                                  <label   class="col-md-5 col-form-label">Age</label>
                                                                             
                                                                                <div class="col-md-7">
                                                                                    <input name="age" id="age" type="text"
																							class="form-control border-input"  value=""
																								readonly />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        </div>
                                                                        <br>
                                                                        -->
                                                                        <div class="row disablecopypasteDiv">
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                             
                                                                                  <label   class="col-md-5 col-form-label">Patient Height<span class="mandate"><sup>&#9733;</sup></span></label>
                                                                               
                                                                                <div class="col-md-7">
                                                                               
											<div class="input-group mb-2 mr-sm-2">
															<input name="height" id="height" onblur="checkBMI();" maxlength="3" 
											type="text" class="form-control border-input" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
											placeholder="Height" value="" required />
														    <div class="input-group-append">
														      <div class="input-group-text">cm</div>
														    </div>
														    
														  </div>
                                                                                </div>
                                                                                
                                                                            </div>
                                                                        </div>
                                                                        

                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                               
                                                                                    <label   class="col-md-5 col-form-label">Weight<span class="mandate"><sup>&#9733;</sup></span></label>
                                                                             
                                                                                <div class="col-md-7">
                                                                            
																				<div class="input-group mb-2 mr-sm-2">
																					 <input name="Weight" id="weight" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
											type="text" class="form-control border-input" onblur="checkBMI();" maxlength="5"
											placeholder="Weight" />
																				    <div class="input-group-append">
																				      <div class="input-group-text">kg</div>
																				    </div>
																				    
																				  </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        
                                                                         <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                               
                                                                                    <label   class="col-md-5 col-form-label">Temperature<span class="mandate"><sup>&#9733;</sup></span></label>
                                                                                
                                                                               <div class="col-md-7">
														<div class="input-group mb-2 mr-sm-2">
															<input name="tempature" id="tempature" type="text" maxlength="8"
															class="form-control border-input"
															placeholder="Temperature" value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" required>
														    <div class="input-group-append">
														      <div class="input-group-text">°F </div>
														    </div>
														    
														  </div>
													</div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                               
                                                                                    <label   class="col-md-3 col-form-label">BP<span class="mandate"><sup>&#9733;</sup></span></label>
                                                                              
	                                                                                <!-- <div class="col-md-3">
	                                                                                    <input name="bp" id="bp" type="text" maxlength="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																								class="form-control border-input" placeholder="Systolic" value=""
																								required> 
	                                                                                </div>
	                                                                                 
	                                                                                <div class="col-md-1">  
	                                                                                /
                                                                                    </div>
	                                                                                
		                                                                              <div class="col-md-3">
	                                                                                    <input name="bp1" id="bp1" type="text" maxlength="3" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
																								class="form-control border-input" placeholder="Diastolic" value=""
																								required>
																								  
	                                                                                  </div> -->  
	                                                                                  
	                                                                                  <div class="col-md-3 offset-md-2">
														
																								<input name="bp" id="bp" type="text" maxlength="3" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
																								class="form-control bpSlash border-input" placeholder="Systolic" value=""
																								required>
																								<span></span> <!-- slash for bp -->
																							  
																						</div>
																						<div class="col-md-4">
																							<div class="input-group mb-2 mr-sm-2">
																								<input name="bp1" id="bp1" type="text" maxlength="3" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
																								class="form-control border-input bmiInput" placeholder="Diastolic" value="" required>
																							    <div class="input-group-append">
																							      <div class="input-group-text">mmHg</div>
																							    </div>
																							  </div>
																						</div>
                                                                                  
                                                                                  
	                                                                                
	                                                                                
	                                                                                
	                                                                                
	                                                                                
	                                                                                
	                                                                                
	                                                                                
	                                                                                
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                
                                                                                  <label   class="col-md-5 col-form-label">Pulse<span class="mandate"><sup>&#9733;</sup></span></label>
                                                                              
                                                                                <div class="col-md-7">
                                                                                    <!-- <input name="pulse" id="pulse"
											type="text" class="form-control border-input" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
											placeholder="Pulse" value="" maxlength="8" /> -->
											
											<div class="input-group mb-2 mr-sm-2">
															<input name="pulse" id="pulse"
											type="text" class="form-control border-input" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
											placeholder="Pulse" value="" maxlength="8" />
														    <div class="input-group-append">
														      <div class="input-group-text">/min</div>
														    </div>
														    
														  </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        
                                                                        
                                                                        
                                                                        
                                                                        
                                                                         <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                               
                                                                                    <label   class="col-md-5 col-form-label">SpO2</label>
                                                                                
                                                                                <div class="col-md-7">
                                                                                   <!-- <input name="spo2" id="spo2" type="text"
											class="form-control border-input" placeholder="SpO2" value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
											maxlength="30"> -->
											<div class="input-group mb-2 mr-sm-2">
															<input name="spo2" id="spo2" type="text"
											class="form-control border-input" placeholder="SpO2" value="" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
											maxlength="30">
														    <div class="input-group-append">
														      <div class="input-group-text">%</div>
														    </div>
														    
														  </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                
                                                                                  <label   class="col-md-5 col-form-label">BMI</label>
                                                                               
                                                                                <div class="col-md-7">
                                                                                    <!-- <input name="bmi" id="bmi" type="text"
											class="form-control border-input" placeholder="BMI" value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
											readonly > -->
											<div class="input-group mb-2 mr-sm-2">
															<input name="bmi" id="bmi" type="text"
											class="form-control border-input" placeholder="BMI" value="" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
											readonly >
														    <div class="input-group-append">
														      <div class="input-group-text">kg/m2</div>
														    </div>
														    
														  </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                
                                                                                    <label   class="col-md-5 col-form-label">RR</label>
                                                                                
                                                                                <div class="col-md-7">
                                                                                   <!--  <input name="rr" id="rr" type="text"
											class="form-control border-input" placeholder="RR" value="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
											maxlength="3"> -->
											
											<div class="input-group mb-2 mr-sm-2">
															 <input name="rr" id="rr" type="text"
											class="form-control border-input" placeholder="RR" value="" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
											maxlength="3">
														    <div class="input-group-append">
														      <div class="input-group-text">/min</div>
														    </div>
														    
														  </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        
                                                                        
                                                                        
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                                
                                                                                
                                                                                
                                                                                <div class="col-md-6">
                                                                                    <input type="hidden" id="patientId" name="PatientID12" value="">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                               
                                                                                                                                                             
                                                                                <div class="col-md-5">
                                                                                   <input type="hidden" id="visitId" name="VisitID" value="">
                                                                                </div>
                                                                                <div class="col-md-7">
                                                                                   <input type="hidden" id="genderId" name="genderId" value="">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        
                                                                        
                                                                       
                                                                        <!-- <div class="col-md-12 text-right">
                                                                            
                                                                            
                                                                            <button type="button" id="saveBtn" class="btn btn-primary"
																				  onclick="saveAddvitalDetails()">Submit</button>
																			 
                                                                           
																			<button type="button" class="btn btn-primary m-l-10"
																				  onclick="goBack()">Close</button>
                                                                              
                                                                        </div> -->
                                                                        
                                                                        
                                                                        
                                                                        
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                         
                         <hr>
                         
                         	
                         <h6 class="font-weight-bold text-theme text-underline">Signs &amp; Symptoms</h6>
										 <div class=" p-10" id="newpost7"  style="display:block;"">
									      
									      <div id="checkbox_div"> 
								
											</div>
							
									      	<div class="row m-t-20">
											<div class="col-md-4">
												<div class="form-group row  autocomplete">

													<label class="col-md-5 col-form-label">Patient signs & symptoms</label>
													<div class="col-md-7">
															<div class="autocomplete forTableResp">
															<input type="text" autocomplete="never" class="form-control border-input" name="pvmsNumber" id="icd" onKeyUp="getNomenClatureList(this,'populateSignAndSymptoms','registration','getAllSymptoms','signAndSymptoms');"/>
															<div id="divPvms1" class="autocomplete-itemsNew"></div>
													</div>

												</div>
											</div>
											</div>

											<div class="col-md-4">
												<!-- <select name="diagnosisId" multiple="4" value="" size="5"
													tabindex="1" id="diagnosisId" class="listBig width-full disablecopypaste"
													validate="ICD Daignosis,string,yes">
												</select> -->
												<div class="multiDiv" id="diagnosisId">
												</div>
											</div>
											<div class="col-md-4">
												<button type="button" class="buttonDel btn  btn-danger"
													value="" onclick="deletePatientSympotonsItems();"
													align="right" />
												Delete
												</button>
												
											</div>

										</div>
									      
												 
										</div>
                         
                         
                         <div class="row m-t-10">
							<div class="col-12 text-right">
								<button type="button" class="btn btn-primary" id="saveBtn" onclick="saveVitalDetailsAndUpdateVisit()">Submit</button>
								<!-- <button type="button" class="btn btn-primary" id="closeBtn">Close</button> -->
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


</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
