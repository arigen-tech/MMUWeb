<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>
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



</head>

<%
	int i = 1;
%>

<body>
<div id="wrapper">
	<div class="content-page">
		<!-- Start content -->

		<div class="container-fluid">
			<div class="internal_Htext">Sanitary Diary</div>
						
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-body">	
							<form:form name="submitSanitary" id="submitSanitary" method="post"
										action="${pageContext.request.contextPath}/miAdmin/submitSanitaryDiary" autocomplete="off">
										
							<div class="row">								
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Date</label>
										</div>
										<div class="col-md-7">
											<div class="dateHolder">
												<input type="text" id="sanitaryDate" name="sanitaryDate" class="noFuture_date2 form-control" placeholder="DD/MM/YYYY" />
											</div>
										</div>
									</div>															
								</div>
								
								<!-- <div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Location</label>
										</div>
										<div class="col-md-7">
											<select class="form-control" id="hospitalId" name="hospital">
												<option value="0">Select</option>
											</select>
										</div>
									</div>															
								</div> -->
								
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Area</label>
										</div>
										<div class="col-md-7">
											    <input type="text" class="form-control" id="area" name="area"  maxlength="960">
                                                            
										</div>
									</div>															
								</div>
								
								<div class="w-100"></div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">PMO Observation</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" rows="3" id="pmoObse"  name="pmoObse" maxlength="960"></textarea>
										</div>
									</div>															
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">PMO Recommendation</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" rows="3" id="pmoReco" name="pmoReco" maxlength="960"></textarea>
										</div>
									</div>															
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Action to be Taken by</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" rows="3" id="action" name="action" maxlength="960"></textarea>
										</div>
									</div>															
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Follow Up of Action</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" rows="3" id="followUp" name="followUp" maxlength="960"></textarea>
										</div>
									</div>															
								</div>
								
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">EXO Remarks</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" rows="3" id="exoRemark" name="exoRemark" maxlength="960"></textarea>
										</div>
									</div>															
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">CO's Remarks</label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" rows="3" id="coRemark" name="coRemark" maxlength="960"></textarea>
										</div>
									</div>															
								</div>
								<div class="col-md-12 text-right">
									<input type="submit" class="btn btn-primary "
														name="submit" value="Submit" id="saveForm1"  onclick="return submitForm();" />														
								<a class="btn btn-primary" role="button"
														 href="${pageContext.request.contextPath}/miAdmin/sanitoryDiaryReport">Back</a>
														
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
	
 	$j(document).ready(function()
	{
 		//Get Hospitallist

        var hospitalValues = "";
        var hospitalDict = ${hospitalList}
        for (hospital in hospitalDict) {

            hospitalValues += '<option name="hospitalid" value=' + hospital + '>' + hospitalDict[hospital] + '</option>';
        }
        $j('#hospitalId').append(hospitalValues);
    	
    });
	
 	function submitForm() {
 		 var sanitaryDate = $j("#sanitaryDate").val();
 		 var hospitalId = $j("#hospitalId").val();
 		 var area = $j("#area").val();
 		 var pmoObse = $j("#pmoObse").val();
 		 var pmoReco = $j("#pmoReco").val();
 		 var action = $j("#action").val();
 		 var followUp = $j("#followUp").val();
 		 var exoRemark = $j("#exoRemark").val();
 		 var coRemark = $j("#coRemark").val();
 		 if (sanitaryDate == null || sanitaryDate == "") {
	         alert("Please select date");
	         return false;
	     }
		 /* if (hospitalId == null || hospitalId == ""||hospitalId == 0) {
	         alert("Please select location");
	          return false;
	     } */
	  	 if (area == null || area == "") {
         	alert("Please enter area");
        	 return false;
    	 }
	 	 if (pmoObse == null || pmoObse == "") {
	         alert("Please enter PMO Observation");
	         return false;
	     }
	 	 if (pmoReco == null || pmoReco == "") {
	         alert("Please enter PMO Recommendation");
	         return false;
	     }
	 	 if (action == null || action == "") {
	         alert("Please enter action");
	         return false;
	     }
	 	 if (followUp == null || followUp == "") {
	         alert("Please enter follow up of action");
	         return false;
	     }
	 	 if (exoRemark == null || exoRemark == "") {
	         alert("Please enter EXO remark");
	         return false;
	     }
	 	 if (coRemark == null || coRemark == "") {
	         alert("Please enter CO's remark");
	         return false;
	     }
	 	
 		
 			$("#submitSanitary").submit();
 			setTimeout(function(){ 			 
 				 $("#saveForm1").attr("disabled", "disabled");
 				   
 			 }, 50);
 			
 	}
</script>

</html>