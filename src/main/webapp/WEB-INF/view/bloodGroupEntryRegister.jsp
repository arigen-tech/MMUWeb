<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>

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
			<div class="internal_Htext">Blood Group Entry</div>
						
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-body">	
							<form:form name="submitBloodGroupEntry" id="submitBloodGroupEntry" method="post" enctype='multipart/form-data'
										action="${pageContext.request.contextPath}/miAdmin/submitBloodGroupRegister" autocomplete="off">
								
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
											<label class="col-form-label">Name</label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" id="empName" name="empName" readonly />
										</div>
									</div>															
								</div>
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
								
								
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Unit</label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" id="unit" name="unit" readonly />
										</div>
									</div>															
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Date of birth</label>
										</div>
										<div class="col-md-7">
											<div class="dateHolder">
											<input type="text" class="form-control calDate noFuture_date2" id="birthDate" name="birthDate" onchange="calculateAge()" placeholder="DD/MM/YYYY"  />
											</div>
										</div>
									</div>															
								</div>
								<input type="hidden" class="form-control" id="empId" name="empId" readonly />
								<input type="hidden" class="form-control" id="rankId" name="rankId" readonly />
								<input type="hidden" class="form-control" id="unitId" name="unitId" readonly />
								<input type="hidden" class="form-control" id="genderId" name="genderId" readonly />
								<input type="hidden" class="form-control" id="empBloodId" name="empBloodId" readonly />
								
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
								
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Gender</label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" id="gender" name="gender" readonly />
										</div>
									</div>															
								</div>
								
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Blood Group</label>
										</div>
										<div class="col-md-7">
											<select class="form-control" id="bloodGroup" name="bloodGroup">
												<option value="0">Select</option>
											</select>
										</div>
									</div>															
								</div>
								
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Address</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" id="address" name="address" maxlength="200" rows="2"></textarea>
											
										</div>
									</div>															
								</div>
								
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Contact No</label>
										</div>
										<div class="col-md-7">
										<textarea class="form-control" id="contactNo" name="contactNo" maxlength="10" onkeypress="return isNumberKey(event)"  rows="2"></textarea>
											</div>
									</div>															
								</div>
								</div>
							
							<div class="row m-t-10">								
								<div class="col-md-12 text-right">
									<input type="submit" class="btn btn-primary "
													name="submit" value="Submit" id="saveForm1"  onclick="return submitForm();" />														
								<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/miAdmin/bloodGroupReport">Back</a>
														
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
	
	//blood group list
	var bloodGroupValues = "";
   var bloodGroupDict = ${bloodGroupList}
   var bloodGroupData = bloodGroupDict.data;
  
   for (category in bloodGroupData) {

  	 bloodGroupValues += '<option  value=' + bloodGroupData[category]  + '>' + category + '</option>';
   }
   $j('#bloodGroup').append(bloodGroupValues);
   
 //Rank list
	var rankValues = "";
  var rankListDict = ${rankList}
  var rankData = rankListDict.data;
 
  for (category in rankData) {

	  rankValues += '<option  value=' + rankData[category]  + '>' + category + '</option>';
  }
  $j('#rankIdd').append(rankValues);
   
 	function getEmpDetails(){
 		document.getElementById("msg").innerHTML="";
 		document.getElementById("empName").value="";
  		document.getElementById("empId").value="";
  		document.getElementById("age").value="";
  		document.getElementById("birthDate").value="";
  		document.getElementById("rank").value="";
  		document.getElementById("rankId").value="";
  		document.getElementById("unit").value="";
  		document.getElementById("unitId").value="";
  		document.getElementById("gender").value="";
  		document.getElementById("genderId").value="";
  		
  		document.getElementById("contactNo").value="";
  		document.getElementById("address").value="";
  		document.getElementById("bloodGroup").value="";
  		document.getElementById("empBloodId").value="";
 		$("#saveForm1").attr('value', 'Submit');
 		 var sNo = $j("#serviceNo").val();
 			//alert(sNo);
 		 var serviceNo={"memberService":sNo};
 		 jQuery.ajax({
 	 	 	crossOrigin: true,
 	 	    method: "POST",			    
 	 	    crossDomain:true,
 	 	    url: "getEmpDetails",
 	 	    data:JSON.stringify(serviceNo),
 	 	    contentType: "application/json; charset=utf-8",
 	 	    dataType: "json",
 	 	    success: function(result){
 	 	    	if(result.status==1){
 	 	    		$j("#rankNameDiv").show();
 	 	    		document.getElementById("empName").value=result.name;
 	 	    		document.getElementById("empId").value=result.empId;
 	 	    		document.getElementById("age").value=result.age;
 	 	    		document.getElementById("birthDate").value=result.dob;
 	 	    		document.getElementById("rank").value=result.rank;
 	 	    		document.getElementById("rankId").value=result.rankId;
 	 	    		document.getElementById("unit").value=result.unit;
 	 	    		document.getElementById("unitId").value=result.unitId;
 	 	    		document.getElementById("gender").value=result.gender;
 	 	    		document.getElementById("genderId").value=result.genderId;
 	 	    		
 	 	    		document.getElementById("contactNo").value=result.mobileNo;
 	 	    		document.getElementById("address").value=result.address;
 	 	    		document.getElementById("bloodGroup").value=result.bloodGroupId;
 	 	    		document.getElementById("empBloodId").value=result.empBloodId;
 	 	    		if(result.rankId == "" || result.rankId == null){
 	 	    			$j("#rankNameDiv").hide();
 	 	    			$j("#rankDiv").show();
 	 	    			
 	 	    		}
 	 	    		if(result.empBloodId != '' && result.empBloodId != null){
 	 	    		 $("#saveForm1").attr('value', 'Update');
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
 	 	    		document.getElementById("unit").value="";
 	 	    		document.getElementById("unitId").value="";
 	 	    		document.getElementById("gender").value="";
 	 	    		document.getElementById("genderId").value="";
 	 	    		document.getElementById("contactNo").value="";
 	 	    		document.getElementById("address").value="";
 	 	    		document.getElementById("bloodGroup").value="";
 	 	    		document.getElementById("empBloodId").value="";
 	 	    		
 	 	    	}
 	 	    	
 	 	    },
 	 	    error: function(result) {
 	             alert("An error has occurred while contacting the server");
 	         }
 	 	    
 	 	});
 	 	
 	}
 	function submitForm() {
 		
 		// var injuryDate = $j("#injuryDate").val();
 		 var sNo = $j("#serviceNo").val();
 		 var age = $j("#age").val();
 		 var empName = $j("#empName").val();
 		 var unit = $j("#unit").val();
 		 var unitId = $j("#unitId").val();
 	   	 var rank = $j("#rank").val();
		 var rankName = $j("#rankName").val();
 		 var address = $j("#address").val();
 		 var contactNo = $j("#contactNo").val();
 		 var birthDate = $j("#birthDate").val();
 		 var bloodGroup = $j("#bloodGroup").val();
		 var gender = $j("#gender").val();
 		 var age = $j("#age").val();
 		
		 if (sNo == null || sNo == "") {
	         alert("Please enter Service Number");
	          return false;
	     }
	     if (empName == null || empName == "") {
	         alert("Please enter emp name");
	         return false;
	     }
	  	 if (age == null || age == "") {
         	alert("Please enter age");
        	 return false;
    	 }
	 	
	 	 if (birthDate == null || birthDate == "") {
	         alert("Please select birthDate");
	         return false;
	     }
	 	 if (bloodGroup == null || bloodGroup == "" || bloodGroup == 0) {
	         alert("Please select bloodGroup");
	         return false;
	     }
	 	 if (gender == null || gender == "") {
	         alert("Please enter gender");
	         return false;
	     }
	 	 if (unit == null || unit == "") {
	         alert("Please enter unit");
	         return false;
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

		 	if (address == null || address == "") {
		         alert("Please enter address");
		         return false;
		     }
	 	 
	 	if (contactNo == null || contactNo == "") {
	         alert("Please enter contact No");
	         return false;
	     }
	 	
	 	
 		
 			$("#submitBloodGroupEntry").submit();
 			setTimeout(function(){ 			 
 				 $("#saveForm1").attr("disabled", "disabled");
 				   
 			 }, 50);
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
 	
 	function isNumberKey(evt){
 	    var charCode = (evt.which) ? evt.which : event.keyCode
 	    if (charCode > 31 && (charCode < 48 || charCode > 57))
 	        return false;
 	    return true;
 	}
</script>

</html>