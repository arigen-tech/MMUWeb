<%@page import="java.util.HashMap"%>
    <%@page import="java.util.Map"%>
        <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

            <%@include file="..//view/leftMenu.jsp" %>
             <%@include file="..//view/commonJavaScript.jsp" %>

                <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Add Vitals Record</title>
</head>




 <script type="text/javascript">
 $(document).ready(function() {

	 var opdType=localStorage.opdType;
	 document.getElementById('opdType').value = opdType;		
	})
 
 function saveAddvitalDetails() {
			
			var pathname = window.location.pathname;
			var accessGroup = "MMUWeb";

			var url = window.location.protocol + "//"
					+ window.location.host + "/" + accessGroup
					+ "/opd/saveVitailsPatientdetails";
			
			    var a = document.getElementById("ideal_weight").value;
                var b = document.getElementById("ideal_weight").value;
			    var c = document.getElementById("weight").value;
			    if(a!=null && a!="" ||b!=null && b!=""||c!=null && c!="")
			    {	
				if(a==0 || b==0 || c==0)
				 {
			 		alert("Height,Ideal Weight and Weight should be greater than 0");
			 		return false;
				 }
			    }
			
			var dataJSON={
	  			     
	      			 'visitId':$('#visitId').val(),
	      			'patientId':$('#patientId').val(), 
	      			'idealWeight':$('#ideal_weight').val(),
	      			'height':$('#height').val(),
	      			'weight':$('#weight').val(),
	      			'varation':$('#variant_in_weight').val(),
	      			'temperature':$('#tempature').val(),
	      			'bp':$('#bp').val(),
	      			'bp1':$('#bp1').val(),
	      			'pulse':$('#pulse').val(),
	      			'spo2':$('#spo2').val(),
	      			'bmi':$('#bmi').val(),
	      			'rr':$('#rr').val(),
	      		}
			$("#saveBtn").attr("disabled", true);
			$.ajax({
				type : "POST",
				contentType : "application/json",
				url : url,
				data: JSON.stringify(dataJSON),
				dataType : 'json',
				timeout : 100000,
				success : function(msg)
				{
				  if (msg.status == 1)
				   	   {
		        		   alert("Vitals details inserted successfully"+'S');
		        		   //show_msg({'msg':' Vitals Details Insert successfully ','status':'1'});
		        		   
		        		   document.addEventListener('click',function(e){
		   					    if(e.target && e.target.id== 'closeBtn'){
		   	   	   				 	window.location="preOpdWaitingList";
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
		        		  alert(msg.status)
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
		
		
		
</script>  
<script type="text/javascript">
            $(document).ready(function() {
                /* if (typeof element !== "undefined" && element.value == '') {
                } */
                var data = ${
                    data
                };
                if (data.data[0].visitId != null) {
                    document.getElementById('visitId').value = data.data[0].visitId;
                }
               
                if (data.data[0].patientId != null) {
                    document.getElementById('patientId').value = data.data[0].patientId;
                }
               
                if (data.data[0].patientName != null) {
                    document.getElementById('patient_name').value = data.data[0].patientName;
                }
                if (data.data[0].dob != null) {
                    document.getElementById('dob').value = data.data[0].dob;
                }
                if (data.data[0].gender != null) {
                    document.getElementById('gender').value = data.data[0].gender;
                }
                if (data.data[0].genderId != null) {
                    document.getElementById('genderId').value = data.data[0].genderId;
                }
                if (data.data[0].age != null) {
                    document.getElementById('age').value = data.data[0].ageFull;
                    document.getElementById('ageNumber').value = data.data[0].age;
                }
            });
</script>




<!-- <script>


/* $(window)
		.bind(
				"load",
				function() {
					function getdata(){
						alert("localStorage.datas: "+ localStorage.datas);
						document.getElementById('service').innerHTML.value =localStorage.datas;
					}
				}); */
	'""'
				var $j= jQuery.noConflict();
				$j(document).ready(function(){
					alert("localStorage.visitId: "+ localStorage.visitId);
					document.getElementById('visitId').value =localStorage.visitId;
					document.getElementById('patiendID').value =localStorage.patientId;
					document.getElementById('service').value =localStorage.serviceNo;
					document.getElementById('patient_name').value =localStorage.patientName;
					document.getElementById('relation').value =localStorage.relation;
					document.getElementById('gender').value =localStorage.gender;
					document.getElementById('age').value =localStorage.age;
					//document.getElementById('service').value =localStorage.datas;
				});
</script> -->

<!-- <script type="text/javascript">
   $(document).ready(function () {
       $('#height').keyup(function () { alert('test'); });
   });
</script> -->

<script>
function goBack() {
	 var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";
     var url='';
     if($('#opdType').val()=="fwc")
     { 
	  url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/fwc/preOpdWaitingList";
     }
     else
     {
    	 url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/preOpdWaitingList"; 
     }	 
	 window.location=url;
}
</script>

<script type="text/javascript">
function idealWeight() {
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";

	var url = window.location.protocol + "//"
			+ window.location.host + "/" + accessGroup
			+ "/opd/getIdealWeight";
   
	var dataJSON={
			 
			  'height':$('#height').val(),
      		  'age':$('#ageNumber').val(),
			  'genderId':$('#genderId').val(),
			
	}
	
	
   
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : url,
		data : JSON.stringify(dataJSON),
		dataType : 'json',
		timeout : 100000,
		success : function(data) {
			console.log("SUCCESS: ", data);
			
		   	   	   if (data.status == 1) {
			//var data = data;
			//alert("value is "+data.data[0].idealWeight);
			$('#ideal_weight').val(data.data[0].idealWeight);
			$('#ideal_weight').attr("disabled","disabled");
           
			
		    }
		   	   	   else
		   	   		   {
		   	   		   	alert("Ideal Weight Not Configured")
		   	   		   	$('#ideal_weight').val();
						$('#ideal_weight').removeAttr("disabled");
		   	   		   }
			
			

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
 
	
 function cancelForm(){
	 window.history.back();
} 
	
 /* $(document).ready(function() {
	    $('#ideal_weight').bind("cut copy paste", function(e) {
	        e.preventDefault();
	         alert("You cannot paste into this text field.");
	        $('#ideal_weight').bind("contextmenu", function(e) {
	            e.preventDefault();
	        });
	    });
	    $('#ideal_weight').bind("cut copy paste", function(e) {
	        e.preventDefault();
	         alert("You cannot paste into this text field.");
	        $('#ideal_weight').bind("contextmenu", function(e) {
	            e.preventDefault();
	        });
	    });
	    $('#weight').bind("cut copy paste", function(e) {
	        e.preventDefault();
	         alert("You cannot paste into this text field.");
	        $('#weight').bind("contextmenu", function(e) {
	            e.preventDefault();
	        });
	    });
	    $('#variant_in_weight').bind("cut copy paste", function(e) {
	        e.preventDefault();
	         alert("You cannot paste into this text field.");
	        $('#variant_in_weight').bind("contextmenu", function(e) {
	            e.preventDefault();
	        });
	    });
	    $('#tempature').bind("cut copy paste", function(e) {
	        e.preventDefault();
	         alert("You cannot paste into this text field.");
	        $('#tempature').bind("contextmenu", function(e) {
	            e.preventDefault();
	        });
	    });
	    $('#bp').bind("cut copy paste", function(e) {
	        e.preventDefault();
	         alert("You cannot paste into this text field.");
	        $('#bp1').bind("contextmenu", function(e) {
	            e.preventDefault();
	        });
	    });
	    $('#bp1').bind("cut copy paste", function(e) {
	        e.preventDefault();
	         alert("You cannot paste into this text field.");
	        $('#bp1').bind("contextmenu", function(e) {
	            e.preventDefault();
	        });
	    });
	    $('#pulse').bind("cut copy paste", function(e) {
	        e.preventDefault();
	         alert("You cannot paste into this text field.");
	        $('#pulse').bind("contextmenu", function(e) {
	            e.preventDefault();
	        });
	    });
	    $('#spo2').bind("cut copy paste", function(e) {
	        e.preventDefault();
	         alert("You cannot paste into this text field.");
	        $('#spo2').bind("contextmenu", function(e) {
	            e.preventDefault();
	        });
	    });
	    $('#rr').bind("cut copy paste", function(e) {
	        e.preventDefault();
	         alert("You cannot paste into this text field.");
	        $('#rr').bind("contextmenu", function(e) {
	            e.preventDefault();
	        });
	    });
	    $('#height').bind("cut copy paste", function(e) {
	        e.preventDefault();
	         alert("You cannot paste into this text field.");
	        $('#height').bind("contextmenu", function(e) {
	            e.preventDefault();
	        });
	    });
	}); */
</script>

<script type="text/javascript">

	function checkVaration() {

		var a = document.getElementById("ideal_weight").value;
		var b = document.getElementById("weight").value;
				
		if(a!=null && b!=null && a!="" && b!="")
        { 
		if (parseFloat(a) > parseFloat(b)) {
			var sub = a - b;
			var cal = sub * 100 / a
			var n = cal.toFixed(2);
			$('#variant_in_weight').val("-" + n);

		} else {
			var eadd = b - a;
			var cal1 = eadd * 100 / b
			var n1 = cal1.toFixed(2);
			$('#variant_in_weight').val("+" +n1);
		}
        }
	}
	
	function checkBMI() {
		var a = document.getElementById("weight").value;
		var b = document.getElementById("height").value;
		var c=b/100;
		var d=c*c;
		var sub = a/d;
		$('#bmi').val(parseFloat(Math.round(sub * 100) / 100).toFixed(2));
		
	}
</script>
<body>

 <!-- Begin page -->
    <div id="wrapper">
                         <div class="content-page">                               
                                <div class="">
                                    <div class="container-fluid">
                                    <div class="internal_Htext">OPD Pre- Consultation</div>
                                       <!--  <div class="row">
                                            <div class="col-12">
                                                <div class="page-title-box">
                                                    
                                                    <ol class="breadcrumb float-right">
                                                        <li class="breadcrumb-item active"><a href="#">Home</a></li>
                                                        <li class="breadcrumb-item  active"><a href="#">OPD</a></li>
                                                        <li class="breadcrumb-item active">Command Master</li>
                                                    </ol>

                                                    <div class="clearfix"></div>
                                                </div>
                                            </div>
                                        </div> -->
                                    
                                        
                                          <div class="row">
                                            <div class="col-12">
                                                <div class="card">
                                                    <div class="card-body"> 
                                                        
 
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <form>
                                                                    <div class="row">
                                                                    
                                                                    
                                                                        
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
                                                                        
                                                                        <div class="row disablecopypasteDiv">
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                             
                                                                                  <label   class="col-md-5 col-form-label">Height</label>
                                                                               
                                                                                <div class="col-md-7">
                                                                                  <!--  <input name="height" id="height" onblur="idealWeight();checkBMI();" maxlength="3"
											type="text" class="form-control border-input" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
											placeholder="Height" value="" required /> -->
											
											<div class="input-group mb-2 mr-sm-2">
															<input name="height" id="height" onblur="idealWeight();checkBMI();" maxlength="3" 
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
                                                                              
                                                                                    <label   class="col-md-5 col-form-label">Ideal Weight</label>
                                                                              
                                                                                <div class="col-md-7">
                                                                                    <!-- <input name="ideal_weight"
											id="ideal_weight" type="text" onblur="checkVaration()" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
											class="form-control border-input" placeholder="Ideal Weight" maxlength="3" /> -->
											
																					<div class="input-group mb-2 mr-sm-2">
																						<input name="ideal_weight"
											id="ideal_weight" type="text" onblur="checkVaration()" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
											class="form-control border-input" placeholder="Ideal Weight" maxlength="5" />
																					    <div class="input-group-append">
																					      <div class="input-group-text">kg</div>
																					    </div>
																					    
																					  </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                               
                                                                                    <label   class="col-md-5 col-form-label">Weight</label>
                                                                             
                                                                                <div class="col-md-7">
                                                                                   <!--  <input name="Weight" id="weight" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
											type="text" class="form-control border-input" onblur="checkVaration();checkBMI();" maxlength="3"
											placeholder="Weight" /> -->
																				<div class="input-group mb-2 mr-sm-2">
																					 <input name="Weight" id="weight" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
											type="text" class="form-control border-input" onblur="checkVaration();checkBMI();" maxlength="5"
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
                                                                                
                                                                                  <label   class="col-md-5 col-form-label">Variation in Weight</label>
                                                                               
                                                                                <div class="col-md-7">
                                                                                   <!-- <input
											name="Variation in Weight" id="variant_in_weight" type="text"
											class="form-control border-input" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
											placeholder="Variation in Weight" value="" readonly /> -->
																					<div class="input-group mb-2 mr-sm-2">
																						<input
											name="Variation in Weight" id="variant_in_weight" type="text"
											class="form-control border-input " onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
											placeholder="Variation in Weight" value="" readonly />
																					    <div class="input-group-append">
																					      <div class="input-group-text">%</div>
																					    </div>
																					    
																					  </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        
                                                                        
                                                                         <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                               
                                                                                    <label   class="col-md-5 col-form-label">Temperature</label>
                                                                                
                                                                                <div class="col-md-7">
                                                                                    <!-- <input name="tempature" maxlength="8"
											id="tempature" type="text" class="form-control border-input" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
											placeholder="Temperature" value="" required> -->
																		<div class="input-group mb-2 mr-sm-2">
																			<input name="tempature" maxlength="8"
											id="tempature" type="text" class="form-control border-input" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;"
											placeholder="Temperature" value="" required>
																		    <div class="input-group-append">
																		      <div class="input-group-text">°F</div>
																		    </div>
																		    
																		  </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group row">
                                                                               
                                                                                    <label   class="col-md-3 col-form-label">BP</label>
                                                                              
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
                                                                                
                                                                                  <label   class="col-md-5 col-form-label">Pulse</label>
                                                                              
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
                                                                        
                                                                        
                                                                       
                                                                        <div class="col-md-12 text-right">
                                                                            
                                                                            
                                                                            <button type="button" id="saveBtn" class="btn btn-primary"
																				  onclick="saveAddvitalDetails()">Submit</button>
																			 
                                                                           
																			<button type="button" class="btn btn-primary m-l-10"
																				  onclick="goBack()">Close</button>
                                                                              
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
                               </div>
 

</div>

</body>
</html>