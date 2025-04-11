<%@page import="org.json.JSONObject"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="..//view/commonJavaScript.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Masters</title>

	<%			
		String hospitalId = "1";
		if (session.getAttribute("hospital_id") !=null)
		{
			System.out.println("hospital id is "+session.getAttribute("hospital_id"));
			hospitalId = session.getAttribute("hospital_id")+"";
		}
		
		String flag = String.valueOf(request.getParameter("flag"));
		System.out.println("flag *********************************************"+flag);
	%>

</head>

<script type="text/javascript" language="javascript">
var $j = jQuery.noConflict();
$j(document).ready(function()
		{
			var flag = "<%= flag %>";
			if(flag == 'Y'){
				$j('#formName').html("Patient Overweight Detail");
				$j('#monitoring').text("Overweight monitoring not required");
			}else if(flag == 'N'){
				$j('#formName').html("Patient Obesity Detail");
				$j('#monitoring').text("Obesity monitoring not required");
			}
			
			var i = 0;
			var height = '';
			var dictionary = ${data};
			var status = dictionary.status;
			if(status == 0){
				var htmlTable = htmlTable+"<tr ><td colspan='8'><h6>No Record Found</h6></td></tr>"; 	
				$j('#tableId').html(htmlTable);
				return;
			}
			//if(dictionary.status == 1){
				for (item in dictionary) {
					i++;
					if(i == 1){
				  		for (subItem in dictionary[item]) {
					
							$j('#service').val(dictionary[item][subItem].serviceNo);
							$j('#patient').val(dictionary[item][subItem].patientName);
							$j('#age').val(dictionary[item][subItem].age);
							$j('#dob').val(dictionary[item][subItem].dob);
							$j('#gender').val(dictionary[item][subItem].gender);		
							$j('#header_id').val(dictionary[item][subItem].header_id);
							$j('#gender_id').val(dictionary[item][subItem].gender_id);
				  		}
				   }else if(i == 2){					
						var tableData = '';
						height = dictionary[item][subItem].height;
						
						for (subItem in dictionary[item]) {
							var variation1 = dictionary[item][subItem].variation;
							var variation2 = variation1.toString().match(/\d+(\.\d{1,2})?/g)[0];
							var bmi1 = dictionary[item][subItem].bmi;
							var bmi2 = bmi1.toString().match(/\d+(\.\d{1,2})?/g)[0];							
							tableData += '<tr><td>'+dictionary[item][subItem].date+'</td><td>'+dictionary[item][subItem].month+'</td><td>'+dictionary[item][subItem].height+'</td><td>'+dictionary[item][subItem].weight+'</td><td>'+dictionary[item][subItem].idealWeight+'</td><td>'+variation2+'</td><td>'+bmi2+'</td></tr>';						
					  	}
						//tableData += '</tbody>';					
						$j('#tableId').append(tableData);
						var addNewRow = '<tr><td><div><input class="form-control" id="createdDate" type="text" value="'+formatDate()+'" readonly></div></td><td><select class="form-control width110" id="months"></select></td><td><div><input class="form-control" id="height" type="text" value="" readonly></div></td><td><div ><input class="form-control" id="weight" type="text" onkeypress="return isNumber(event)" onblur="checkBMI();getVariation();"></div></td><td><div><input class="form-control" id="idealWeight" type="text" onkeypress="return isNumber(event)" onblur="getVariation()" disabled></div></td><td><div><input class="form-control"  id="variant_in_weight" type="text" readonly></div></td><td><div><input class="form-control" id="bmi" type="text" readonly></div></td></tr>';
						$j('#tableId').append(addNewRow);
						$j('#height').val(height);
						//months in select option
						var optionsValue = '';
						var monthNames = ["Select", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];
						for(var i=0;i<monthNames.length;i++){
							optionsValue += '<option>'+monthNames[i]+'</option>'	
						}
						$j('#months').append(optionsValue);
					
					}
				
				}	
			getIdealWeight();
		});
		
function getIdealWeight(){
  	var params = {
			"age" : $j('#age').val(),
			"height" : $j('#height').val(),
			"genderId": $j('#gender_id').val()
	}
  	$j('#idealWeight').removeAttr("disabled");
	 $j.ajax({
			type:"POST",
			contentType : "application/json",
			url: 'getIdealWeight',
			data : JSON.stringify(params),
			dataType: "json",			
			cache: false,
			success: function(data)
			{  		
				if(data.status == 0){
					alert("Ideal Weight is not configured");
					$j('#idealWeight').prop("disabled",false);
				}else{
					$j('#idealWeight').val(data.data[0].idealWeight);
					$j('#idealWeight').prop("disabled",true);
				}							
				
			},			
			error: function(data)
			{							
				
				alert("An error has occurred while contacting the server");
				
			}
	});   
	
}

/* 	function getVariation() {
		var a = document.getElementById("idealWeight").value;
		var b = document.getElementById("weight").value;
		if(b == ''){
			return;
		}
		if (a > b) {
			var sub = a - b;
			var cal = sub * 100 / a
			var n = cal.toFixed(2);
			$('#variant_in_weight').val("-" + n);
		} else {
			var eadd = b - a;
			var cal1 = eadd * 100 / b
			var n1 = cal1.toFixed(2);
			$('#variant_in_weight').val("+" + n1);
		}
	} */
	function getVariation() {
		var a = document.getElementById("idealWeight").value;
		var b = document.getElementById("weight").value;
		
		if(b == ''){ 
			$j('#variant_in_weight').val('');			
			return;
		}
		
		if (parseFloat(a) > parseFloat(b)) {
			var sub = a - b;
			var cal = sub * 100 / a
			var n = cal.toFixed(2);
			$j('#variant_in_weight').val("-" + n);
	
		} else {
			var eadd = b - a;
			var cal1 = eadd * 100 / b
			var n1 = cal1.toFixed(2);
			$j('#variant_in_weight').val("+" +n1);
		}
	}
	
	function checkBMI() {
		var a = document.getElementById("weight").value;
		var b = document.getElementById("height").value;
		if(a == ''){
			$j('#bmi').val('');			
			return;
		}
		
		var c=b/100;
		var d=c*c;
		var sub = a/d;
		$j('#bmi').val(parseFloat(Math.round(sub * 100) / 100).toFixed(2));
		
	}

	function getBMI() {
		alert("get bmi");
	}

	function formatDate() {
		var d = new Date(new Date()), month = '' + (d.getMonth() + 1), day = ''
				+ d.getDate(), year = d.getFullYear();

		if (month.length < 2)
			month = '0' + month;
		if (day.length < 2)
			day = '0' + day;

		return [day, month, year].join('/');
	}
	
	function saveObesityDetails(){
		
		var obesity_date = $j('#createdDate').val();
		var month_name = $j('#months').find('option:selected').text();
		var height = +($j('#height').val());
		var weight = +($j('#weight').val());
		var ideal_weight = +($j('#idealWeight').val());
		var variation = $j('#variant_in_weight').val();
		var bmi = $j('#bmi').val();
		var header_id = +($j('#header_id').val());
		var obesity_check = document.getElementById('obesity_check');
		var selected_month = $('#months').find('option:selected').text();
		if(selected_month == 'Select'){
			alert("Please select month");
			return;
		}
		if(obesity_check.checked){
			obesity_check = "y";
		}
		//alert("height "+height+" weight "+weight+" ideal_weight "+ideal_weight+" variation "+variation+" bmi "+bmi);
		if(weight == 0 || weight == undefined || weight == ''){
			alert("Please enter valid Weight");
			return;
		}else if(ideal_weight == 0 || ideal_weight == undefined || ideal_weight ==''){
			alert("Ideal Weight must be entered");
			return;
		}
		var params = {
				"obesity_date" : obesity_date,
				"month_name" : month_name,
				"height" : height,
				"weight" : weight,
				"ideal_weight" : ideal_weight,
				"variation" : variation,
				"bmi" : bmi,
				"header_id": header_id,
				"obesity_check":obesity_check
			}
		
		 $j.ajax({
				type:"POST",
				contentType : "application/json",
				url: 'saveObesityDetails',
				data : JSON.stringify(params),
				dataType: "json",			
				cache: false,
				success: function(data)
				{  
					
				/* 	alert(data.msg);		
					window.location = "obesityWaitingJsp"; */
					
					alert(data.msg+'S');
					document.addEventListener('click',function(e){
   					    if(e.target && e.target.id== 'closeBtn'){
   	   	   				 	window.location="obesityWaitingJsp";
   					     }
   					 });
				},			
				error: function(data)
				{							
					
					alert("An error has occurred while contacting the server");
					
				}
		}); 
		
	}
	
	function getoObesityList(){
		window.location = "obesityWaitingJsp";
	}
	
	function isNumber(evt) {
	    evt = (evt) ? evt : window.event;
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
	        return false;
	    }
	    return true;
	}
	
</script>
 <body>
 
  <!-- Begin page -->
    <div id="wrapper">
                         <div class="content-page">
                                <!-- Start content -->
                                <div class="">
                                    <div class="container-fluid">
									
	                                        <div class="internal_Htext" id="formName"></div>

                                        <!-- end row -->
                                            <div class="row">
                                            <div class="col-12">
                                                <div class="card">
                                                    <div class="card-body">
                                                        

                                                      <form>
                                                      
                                                      
                                                       <div class="row"> 
														    <div class="col-md-3"> 
																   
																		 <div class="form-group row">
																	    <label   class="col-sm-5 col-form-label">Service No.</label>
																	    <div class="col-sm-7">
																	        <input class="form-control form-control-sm" type="text" placeholder="" id="service" readonly>
																	    </div>
																	  </div>
															 
													          </div>	 
													          
													          
													          <div class="col-md-3"> 
																    
																		 <div class="form-group row">
																	    <label   class="col-sm-5 col-form-label">Patient Name</label>
																	    <div class="col-sm-7">
																	        <input class="form-control form-control-sm" type="text" placeholder="" id="patient" readonly>
																	    </div>
																	  </div> 
													          </div>	 
													          
													          
													          
													          <div class="col-md-3"> 
																    
																		 <div class="form-group row">
																	    <label   class="col-sm-4 col-form-label">Age</label>
																	    <div class="col-sm-8">
																	        <input class="form-control form-control-sm" type="text" placeholder="" id="dob" readonly>
																	    </div>
																	  </div> 
													          </div> 
													          
													          <div class="col-md-3"> 
																    
																		 <div class="form-group row">
																	    <label   class="col-sm-5 col-form-label">Gender</label>
																	    <div class="col-sm-7">
																	        <input class="form-control form-control-sm" type="text" placeholder="" id="gender" readonly>
																	        <input type="hidden" id="header_id">
																	        <input type="hidden" id="gender_id">
																	    </div>
																	  </div> 
													          </div>
													          
													          
													          
													</div>
                                                       
                                                      
                                                      
                                                      
                                 <!--                      <div class="form-row">

														<div class="form-group col-md-6">
															<label for="inputEmail3" class="col-sm-4 col-form-label">Service No.</label>
															<div class="col-sm-8">
																<input type="text" class="border" id="service" readonly>
															</div>
														</div>
														<div class="form-group col-md-6">
															<label for="inputEmail3" class="col-sm-4 col-form-label">Patient</label>
															<div class="col-sm-8">
																<input type="text" class="border" id="patient" readonly>
															</div>
														</div>
										
														<div class="form-group col-md-6">
															<label for="age" class="col-sm-4 col-form-label">Age</label>
															<div class="col-sm-8">
																<input type="text" class="border" id="age" readonly>
															</div>
														</div>
														<div class="form-group col-md-6">
															<label for="gender" class="col-sm-4 col-form-label">Gender</label>
															<div class="col-sm-8">
																<input type="text" class="border" id="gender" readonly>
																<input type="hidden" id="header_id">
															</div>
														</div>
										
													</div> -->
													
													
													<div class="form-row">
										
														<table class="table table-striped table-hover table-bordered">
															<thead>
																<tr>
																	<th>Date</th>
																	<th>Month</th>
																	<th>Height</th>
																	<th>Weight</th>
																	<th>Ideal Weight (in Kg)</th>
																	<th>Variation in weight (in %)</th>
																	<th>BMI</th>
																</tr>
															</thead><tbody  id="tableId"></tbody>
														</table>
														<br>
														<br>
													</div>
													
													
													
												 <div class="row"> 
													    <div class="col-md-6"> 
															   <div class="form-group row">
																	
																	<div class="col-sm-12">
																		<!-- <input type="checkbox" id='obesity_check'> &nbsp &nbsp  Obesity monitoring not required -->
																		
																		<div class="form-check form-check-inline cusCheck">
																			<input class="form-check-input" type="checkbox" id='obesity_check'>
																			<span class="cus-checkbtn"></span> 
																			<label class="form-check-label m-l-5" for="checkbox1" id="monitoring"></label>
																		</div>
																		
																	</div>
																	
																	
																</div>
												          </div>	 
												          
												          
												          <div class="col-md-6"> 
															   <div class="form-group row">
																	
																	<div class="col-sm-12 text-right">
																		<button type="button" class="btn btn-primary"  onclick="saveObesityDetails()">Submit</button>
																	
																		<button type="button" class="btn btn-primary"  onclick="getoObesityList()">Back</button>
																		</div>
																	</div>
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
	<input type="hidden" id="age" value="">
</body>
</html>