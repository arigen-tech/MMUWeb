<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newOpd.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opd.js"></script> --%>
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
			<div class="internal_Htext">Milk Testing For Free Chlorine</div>
						
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-body">	
							<form:form name="submitMilkTesting" id="submitMilkTesting" method="post"
										action="${pageContext.request.contextPath}/miAdmin/submitMilkTesting" autocomplete="off">
								
							<div class="row">								
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Date<span class="mandate"><sup>&#9733;</sup></span></label>
										</div>
										<div class="col-md-7">
											<div class="dateHolder">
											<input type="text" name="testingDate" id="testingDate" class="noFuture_date2 form-control" placeholder="DD/MM/YYYY"  />
											</div>
										</div>
									</div>															
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Source of Supply<span class="mandate"><sup>&#9733;</sup></span></label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" name="sos" id="sos" maxlength="200"/>
										</div>
									</div>															
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Location of Sampling<span class="mandate"><sup>&#9733;</sup></span></label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" name="location" id="location" maxlength="200"/>
										</div>
									</div>															
								</div>	
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Specific Gravity<span class="mandate"><sup>&#9733;</sup></span></label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" name="gravity" id="gravity" maxlength="200"/>
										</div>
									</div>															
								</div>
								 <div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Tested By<span class="mandate"><sup>&#9733;</sup></span></label>
										</div>
										<div class="col-md-7">
											<input type="text" class="form-control" name="testedBy" id="testedBy" maxlength="200" />
										</div>
									</div>															
								</div> 
								<!-- <div class="col-md-4">
							                            <div class="form-group row">							                                
							                                <label class="col-md-5 col-form-label">Tested By<span class="mandate"><sup>&#9733;</sup></span></label>
							                                <div class="col-md-7">
							                                    <select class="form-control" id="testedBy" name="testedBy" >
							                                     <option value="0" selected="selected">Select</option>
							                                     </select>
							                                </div>
							                            </div>
							                        </div> -->
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-5">
											<label class="col-form-label">Remarks<span class="mandate"><sup>&#9733;</sup></span></label>
										</div>
										<div class="col-md-7">
											<textarea class="form-control" name="remark" id="remark" maxlength="2000"></textarea>
										</div>
									</div>															
								</div>											
							</div>
							
							<div class="row">
								<div class="col-md-12 text-right">
									<input type="submit" class="btn btn-primary "
														name="submit" value="Submit" id="saveForm1"  onclick="return submitForm();" />														
									<a class="btn btn-primary" role="button"
															href="${pageContext.request.contextPath}/miAdmin/milkTestingReport">Back</a>
																												
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
	
	 //emp list
    
    var empListValues;
    var empListDict = ${empList}
    var empListData = empListDict.data;
   for (category in empListData) {
    	empListValues += '<option  value="' + category + '">' + empListData[category] + '</option>';
    }
    $j('#testedBy').append(empListValues);
    	
 	function submitForm() {
 		
 		 var testingDate = $j("#testingDate").val();
 		 var sos = $j("#sos").val();
 		 var location = $j("#location").val();
 		 var gravity = $j("#gravity").val();
 		 var testedBy = $j("#testedBy").val();
 		 var remark = $j("#remark").val();
 		 
 		 if (testingDate == null || testingDate == "") {
	         alert("Please select date");
	         return false;
	     }
		 if (sos == null || sos == "") {
	         alert("Please enter source of supply");
	          return false;
	     }
		 if (location == null || location == "") {
	         alert("Please enter location of sampling");
	          return false;
	     }
	  	 if (gravity == null || gravity == "") {
         	alert("Please enter specific gravity");
        	 return false;
    	 }
	 	 if (testedBy == null || testedBy == "") {
	         alert("Please enter tested By");
	         return false;
	     }
	 	
	 	 if (remark == null || remark == "") {
	         alert("Please enter remark");
	         return false;
	     }
	 
 			$("#submitMilkTesting").submit();
 			setTimeout(function(){ 			 
 				 $("#saveForm1").attr("disabled", "disabled");
 				   
 			 }, 50);
 	}
 	
</script>

</html>