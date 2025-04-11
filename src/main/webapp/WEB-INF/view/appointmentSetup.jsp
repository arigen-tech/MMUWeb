<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@include file="..//view/leftMenu.jsp"%>
<%@include file="..//view/commonJavaScript.jsp"%>
<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v3.8.5">

<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}
</style>
</head>
<%
	String[] day = new String[7];
	day[0] = "Sunday";
	day[1] = "Monday";
	day[2] = "Tuesday";
	day[3] = "Wednesday";
	day[4] = "Thursday";
	day[5] = "Friday";
	day[6] = "Saturday";
%>
<script type="text/javascript">
var $j = jQuery.noConflict();
$j(document).ready(function(){
	 var dictionary = ${data};
	 var deptList=dictionary.departmentList;
	 var deptValues = "";
	 for(dept in deptList){
			deptValues += '<option value='+deptList[dept].departmentId+'>'
						+ deptList[dept].departmentName
						+ '</option>';
	 }
	 $j('#departmentId').append(deptValues); 
	
});

function getAppointmentType(){
	document.getElementById("appointmentTypeId").options.length = 1;
	var deptId = $j('#departmentId').find('option:selected').val();
	var hospitalId = $j('#hospitalId').val();
	if(deptId!=0){
		var params = {
				"deptId":deptId,
				"hospitalId":hospitalId
		}
		$j.ajax({
			type : "POST",
			contentType : "application/json",
			url : 'getLocationWiseAppointmentType',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(response) {
				if (response.status == '1') {
				var appTypeValues = "";
				var appTypeFromMasAppsession = response.appointmentTypeList;
					  for(appType in appTypeFromMasAppsession){
						 	appTypeValues += '<option value='+appTypeFromMasAppsession[appType].appointmentTypeId+'>'
							+ appTypeFromMasAppsession[appType].appointmentTypeName
							+ '</option>';	
							 }
					  
					  $j('#appointmentTypeId').append(appTypeValues);
					
				}else{
					alert("Appointment Type is not available");
					document.getElementById("appointmentTypeId").options.length = 1;
					resetGrid();
				}
			},
			error : function(msg) {
				alert("An error has occurred while contacting the server");
			}
		});
	}else{
		resetGrid();
	}
}


function getAppointmentDetails(){
	if(validateDeptAndAppointment()){
	var deptId = $j('#departmentId').find('option:selected').val();
	var appointmentTypeId = $j('#appointmentTypeId').find('option:selected').val();
	var hospitalId = $j('#hospitalId').val();
	document.getElementById("showButtonStatus").value="y";
	var params = {
		"deptId":deptId,
		"appointmentTypeId":appointmentTypeId,
		"hospitalId":hospitalId
	}
	
	$j.ajax({
		type : "POST",
		contentType : "application/json",
		url : 'getAppointmentSetupDetails',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(msg) {
			var appSession = msg.appSessionDataList;
			for(item in appSession){
				$j('#startTime').val(appSession[item].fromTime);
				$j('#endTime').val(appSession[item].toTime);
			}
			if (msg.status == '1') {
				var appSetupDataList = msg.appSetupdataList;
				 for (i = 0; i < appSetupDataList.length; i++) {
					 for(d=0;d<7;d++){
						 if($j('#days'+d).val()==appSetupDataList[i].days){
							 $j('#appointmentId'+d).val(appSetupDataList[i].id);
							 $j('#tokenStart'+d).val(appSetupDataList[i].startToken);
							 $j('#tokenInterval'+d).val(appSetupDataList[i].totalInterval);
							 $j('#totalToken'+d).val(appSetupDataList[i].totalToken);
							 $j('#totalOnlineToken'+d).val(appSetupDataList[i].totalOnlineToken);
							 $j('#totalPortalToken'+d).val(appSetupDataList[i].totalPortalToken);
							 $j('#totalMobileToken'+d).val(appSetupDataList[i].totalMobileToken);
							 $j('#maxDays'+d).val(appSetupDataList[i].maxNoOfDays);
							 $j('#minDays'+d).val(appSetupDataList[i].minNoOfDays);
						 }
					 }
				 }
				 $j('#submitbtn').hide();
				 $("#submitUpdatebtn").attr("disabled", false);
				 $j('#submitUpdatebtn').show();
			}else{
				alert("No appointment setup exist. Please create appointment setup");
				resetGrid();
				$j('#showButtonStatus').val("y"); //This value must be set after resetGrid function
			}
		},
		error : function(msg) {
			alert("An error has occurred while contacting the server");
		}
	});
  }	
}

function validateDatefield(){
		if(validateDeptAndAppointment()){
		var totalRow = document.getElementById('totalRowId').value;
		var errorMessage = "";
		for (var k = 0; k < totalRow; k++) {
			if (document.getElementById('tokenStart' + k).value != ""
					|| document.getElementById('tokenInterval' + k).value != ""
					|| document.getElementById('totalToken' + k).value != ""
					|| document.getElementById('totalOnlineToken' + k).value != "") {
				if (document.getElementById('maxDays' + k).value == ""
						|| document.getElementById('minDays' + k).value == "") {
					alert("Please fill all the values for row "
							+ parseInt(k + 1));
					return false;
				}
			}
		}

		var flag = true;
		for (var k = 0; k < totalRow; k++) {

			if (document.getElementById('tokenStart' + k).value != ""
					&& document.getElementById('tokenInterval' + k).value != ""
					&& document.getElementById('totalToken' + k).value != ""
					&& document.getElementById('totalOnlineToken' + k).value != ""
					&& document.getElementById('maxDays' + k).value != ""
					&& document.getElementById('minDays' + k).value != "") {
				flag = false;
				break;
			}

		}
		if (flag == false) {
			return true;
		} else {
			alert("Please Fill atleast one row");
			return false;
		}
	}
}

	function validateDeptAndAppointment(){
		var deptId = document.getElementById("departmentId").value;
		var appointmentTypeId = document.getElementById("appointmentTypeId").value;
			if (deptId == 0 || appointmentTypeId == 0) {
				if (deptId == 0) {
					alert("Please select Department");
				} else if (appointmentTypeId == 0) {
					alert("Please select Appointment Type");
				}
				return false;
			}else{
				return true;
			}
	}

	function checkShowButton(id) {
		if (document.getElementById("showButtonStatus").value == "n") {
			alert("Please click show setup button");
			document.getElementById("startTime").focus();
			if (id != undefined)
				document.getElementById(id).value = "";
			return false;
		}
		return true;
	}

	
	$j(function() {
		var successIcon = '<i class="fa fa-check-circle m-r-5"></i>';
		
			   $j('button[type=submit]').click(function(e) {
				   if(validateDatefield() && checkShowButton()){
					   $("#submitbtn").attr("disabled", true);
					   $("#submitUpdatebtn").attr("disabled", true);
					   $("#resetBtn").attr("disabled", true);

					   var params = {
								 "appSetupData":$j('#appSetupform').serializeObject() 
								}
					      e.preventDefault();
					      $j.ajax({
					    	  type : "POST",
							  contentType : "application/json",
							  url : 'submitAppointmentSetup',
							  data : JSON.stringify(params),
							  dataType : "json",
							  cache : false,
					         success : function(response) {
					        	 
					         var message = response.msg;
					         
					         alert(message+'S')
					         
					         /* $j('#messageId').html(successIcon + message);
					         $j("#messageId").css("color", "#0abb87");
				    		 $j("#messageId").css("background", "rgba(29, 201, 183, 0.1");
				    		 $j("#messageId").animate({height: "34px"},500);
							 setTimeout(function() {
								
								 $j("#messageId").animate({height: "0px"},500);
					
						     },3000); */
							 
					         $j('#departmentId').val("0"); 
					         $j('#appointmentTypeId').val("0");
					         $j('#startTime').val("");
					 	     $j('#endTime').val("");
					 	     $("#submitbtn").attr("disabled", false);
					 	     $("#resetBtn").attr("disabled", false);
					         resetGrid();
					         },error: function(msg){					
								alert("An error has occurred while contacting the server");
							}
					      })  
				   }
		   });
		});
	
	
	$j.fn.serializeObject = function()
	{
	    var o = {};
	    var a = this.serializeArray();
	    $j.each(a, function() {
	        if (o[this.name] !== undefined) {
	            if (!o[this.name].push) {
	                o[this.name] = [o[this.name]];
	            }
	            o[this.name].push(this.value || '');
	        } else {
	            o[this.name] = this.value || '';
	        }
	    });
	    return o;
	};
	
	
	
	function resetGrid(value){
		for(var i=0;i<7;i++){
			$j('#appointmentId'+i).val("");
			 $j('#tokenStart'+i).val("1");
			 $j('#tokenInterval'+i).val("0");
			 $j('#totalToken'+i).val("");
			 $j('#totalOnlineToken'+i).val("0");
			 $j('#totalPortalToken'+i).val("0");
			 $j('#totalMobileToken'+i).val("0");
			 $j('#maxDays'+i).val("0");
			 $j('#minDays'+i).val("0");
		}
		$j('#showButtonStatus').val("n");
		$j('#submitbtn').show();
		$j('#submitUpdatebtn').hide();
		
		if(value=='reset'){
			$j('#departmentId').val("0");
			$j('#appointmentTypeId').val("0");
			$j('#startTime').val("");
			$j('#endTime').val("");
			
			
		}
		return false;
	}
	
	
	function checkMinMax(count){
		var min = $j('#minDays'+count).val();
		var max = $j('#maxDays'+count).val();
		if(min=="" || max==""){
			return false;
		}else{
			if(min>0){
				if(max>=min){
					return true;
				}else{
					alert("Min days should be less than Max days")
					$j('#maxDays'+count).val("");
				}
			}else{
				alert("Min days should be greater than Zero")
				$j('#minDays'+count).val("");
				return false;
			}
			
		}
		
	}
	
</script>
<body>

 <!-- Begin page -->
    <div id="wrapper">
	
		<div class="content-page">
			<div class="">
				<div class="container-fluid">
				<div  class="internal_Htext" >Appointment Setup</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<form id="appSetupform" name="appSetupform" method="POST">
										<!-- <p align="center" id="messageId"></p> -->

										<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<label for="department" class="col-sm-5 col-form-label">Department<span class="mandate"><sup>&#9733;</sup></span></label>
													<div class="col-sm-7">
														<select class="form-control" id=departmentId
															name="department" onchange="getAppointmentType()">
															<option value="0" selected="selected">Select</option>
														</select>
													</div>
												</div>
											</div>

											<div class="col-md-4">
												<div class="form-group row">
													<label for="appointmentType"
														class="col-sm-5 col-form-label">Appointment Type<span class="mandate"><sup>&#9733;</sup></span>
													</label>
													<div class="col-sm-7">
														<select class="form-control" id="appointmentTypeId"
															name="appointmentType" onchange="resetGrid()">
															<option value="0" selected="selected">Select</option>
														</select>
													</div>
												</div>
											</div>
											
									
											<div class="col-md-4">

												<div class="form-group row">
													<label for="time" class="col-sm-5 col-form-label">Start
														Time<span class="mandate"><sup>&#9733;</sup></span>
													</label>
													<div class="col-sm-7">

														<input type="text" class="form-control" id="startTime"
															name="startTime" placeholder="Start Time" readonly>
													</div>
												</div>

											</div>
											<div class="col-md-4">

												<div class="form-group row">
													<label for="rank" class="col-sm-5 col-form-label">End
														Time<span class="mandate"><sup>&#9733;</sup></span>
													</label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="endTime"
															name="endTime" placeholder="End Time" readonly>
													</div>
												</div>


												<!-- start -->
											</div>
											
											
											<div class="col-md-4">
											</div>
											
											
											
											<div class="col-md-4">
												<div class="showappointmentsetup  btn-right-all">

													<button type="button" class="btn btn-primary"
														data-toggle="button" aria-pressed="false"
														autocomplete="off" onClick="getAppointmentDetails();">Show
														Setup</button>

												</div>
											</div>
											
											
											
											
											
											
										</div>
										<br>

										<table
											class="table table-striped table-hover  table-bordered "
											id="tblListAppSetUp">
											<thead>
												<tr>
													<th id="th1">Days</th>
													<th id="th2">Token Start No.</th>
													<th id="th3">Token Interval</th>
													<th id="th4">Total Token</th>
													<th id="th5">Total Online Token</th>
													<th id="th6">Portal Token</th>
													<th id="th7">Mobile Token</th>
													<th id="th8">Max Days</th>
													<th id="th9">Min Days</th>
												</tr>
											</thead>
											<tbody>
												<% int inc = 0;
												for(inc=0;inc<7;inc++){
															%>
												<tr>
													<input type="hidden" name="appointment"
														id="appointmentId<%=inc%>" value="" />
													<input type="hidden" id="days<%=inc%>" name="days"
														value="<%=day[inc]%>" />
													<td id="dayId" name="dayName"><%=day[inc]%></td>
													<td><input readonly type="text" class="form-control" size=8
														id="tokenStart<%=inc%>" autocomplete="off" value="1"
														name="TokenStart" MAXLENGTH="8" validate='Days,int,no'
														onblur="checkShowButton(this.id)" id="breakToTime2"
														onkeyup="setOnlineToken('tokenStart<%=inc%>','totalToken<%=inc%>','tokenInterval<%=inc%>','totalOnlineToken<%=inc%>','totalPortalToken<%=inc%>','totalMobileToken<%=inc%>','1'); checkNumberFormat('tokenStart<%=inc%>');" />
													</td>
													<td><input readonly type="text" class="form-control" size=8
														id="tokenInterval<%=inc%>" name="TokenInterval" value="0"
														MAXLENGTH="8" id="breakFromTime3" autocomplete="off"
														onblur="checkShowButton(this.id)"
														onkeyup="setOnlineToken('tokenStart<%=inc%>','totalToken<%=inc%>','tokenInterval<%=inc%>','totalOnlineToken<%=inc%>','totalPortalToken<%=inc%>','totalMobileToken<%=inc%>','1'); checkNumberFormat('tokenInterval<%=inc%>');" /></td>

													<td><input type="text" class="form-control" size=8
														id="totalToken<%=inc%>" name="TotalToken"
														autocomplete="off" onblur="checkShowButton(this.id)"
														onkeyup="setOnlineToken('tokenStart<%=inc%>','totalToken<%=inc%>','tokenInterval<%=inc%>','totalOnlineToken<%=inc%>','totalPortalToken<%=inc%>','totalMobileToken<%=inc%>','1'); checkNumberFormat('totalToken<%=inc%>');"
														MAXLENGTH="8" id="breakToTime3" /></td>

													<td><input readonly type="text" class="form-control"
														size=8 id="totalOnlineToken<%=inc%>"
														name="TotalOnlineToken" value="0"
														onkeyup="setOnlineToken('tokenStart<%=inc%>','totalToken<%=inc%>','tokenInterval<%=inc%>','totalOnlineToken<%=inc%>','totalPortalToken<%=inc%>','totalMobileToken<%=inc%>','2');"
														MAXLENGTH="8" id="breakToTime3" /></td>


													<td><input readonly type="text" class="form-control"
														size=8 id="totalPortalToken<%=inc%>"
														name="totalPortalToken" value="0" MAXLENGTH="8" /></td>

													<td><input readonly type="text" class="form-control"
														size=8 id="totalMobileToken<%=inc%>"
														name="totalMobileToken" value="0" MAXLENGTH="8" /></td>


													<td><input readonly  type="text" size=8 class="form-control"
														id="maxDays<%=inc%>" name="maxdays" MAXLENGTH="2" 
														autocomplete="off" validate="Max. no. of Days,num,no" value="0"
														onkeypress="checkNumberFormat('maxDays<%=inc%>');" onblur="checkMinMax(<%=inc%>);"/></td>
													<td><input  readonly type="text" size=8 class="form-control"
														id="minDays<%=inc%>" name="mindays" MAXLENGTH="2"
														autocomplete="off" validate="Min no. of Days,num,no" value="0"
														onkeypress="checkNumberFormat('minDays<%=inc%>');" onblur="checkMinMax(<%=inc%>);" /></td>
												</tr>
												<%	}%>
											</tbody>
										</table>
										<input type="hidden" value="<%=inc%>" name="totalRow"
											id="totalRowId" /> <input type="hidden" value="n"
											name="showButtonStatus" id="showButtonStatus" /> <input
											type="hidden" class="form-control" id="userId" name="userId"
											value="<%=session.getAttribute("user_id")%>"> <input
											type="hidden" class="form-control" id="hospitalId"
											name="hospitalId"
											value="<%=session.getAttribute("hospital_id")%>">


										<div class="clearfix"></div>
										<br>
										<div class="row">
											<div class="col-md-12">
												<div class="btn-left-all"></div>
												<div class="btn-right-all">

													<button type="submit" id="submitbtn" name="submitbtn"
														class="btn btn-primary" data-toggle="button"
														aria-pressed="false" autocomplete="off">Submit</button>

													<button style="display: none" type="submit"
														id="submitUpdatebtn" name="submitUpdatebtn"
														class="btn btn-primary" data-toggle="button"
														aria-pressed="false" autocomplete="off">Update</button>
													<button type="button" class="btn btn-danger"
														data-toggle="button" aria-pressed="false"
														autocomplete="off" value="reset" id='resetBtn'
														onclick="resetGrid(this.value)">Reset</button>

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
</body>
</html>