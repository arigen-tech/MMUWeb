<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.mmu.web.utils.UtilityServices"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Home</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />


<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/favicon-16x16.png"
	type="image/x-icon">
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/images/favicon-16x16.png"
	type="image/x-icon">

<link href="${pageContext.request.contextPath}/resources/css/icons.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/matrix-style.css"
	rel="stylesheet" type="text/css" />
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%
    
    
    
  
    response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
    response.setDateHeader("Expires", 0);
    Cookie[] cookies = request.getCookies(); 
    String JsessionId = null;
     
     if(cookies !=null)
     {
      for(Cookie cookie : cookies)
      {
 	if(cookie.getName().equals("JSESSIONID")) 
         JsessionId = cookie.getValue();
      }
     }
   
    
     String serviceNo=request.getParameter("serviceNo");
     %>

<%
     if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid() && JsessionId == null) 
     {
     // The session has been expired (or a hacker supplied a fake cookie).
        response.sendRedirect("${pageContext.request.contextPath}/dashboard/logouts");
     }
 
 
     
 %>

</head>
<body class="dash-bg">

	<div class="container text-center">

		<div class="main">

			<div id="content-header">
				<div class="homeLogout text-right">
				
					<a href="javascript:void(0);" onclick="logoutApplication();"> <i class="fa fa-power-off"></i>
						<span>Logout</span>
					</a>
				</div>
				<div class="quick-actions_homepage text-center">

					<div class="row">
						<div class="col-md-12">
							<h3 class="getmsz">${authantication}</h3>
						</div>
					</div>
					<form name="frm">
						<div class="row">
							<div class="col-md-12">
								<input type="hidden" id="serviceNo1" name="serviceNo" value="" />

								<div class="row">
									<div class="col-12 m-b-40 ">
										<h3 class="welcomeHead">
											Welcome: <span id="welcomeId"></span>
										</h3>
									</div>
								</div>
								<div class="row">

									<div class="col-md-3 offset-md-3">
										<input class="form-control m-t-10" type="hidden"
											id="serviceNo" value=""> <a href="#"
											onclick="getLoginLdapAuthentication()">
											<div class="box_lh box">
												<span class="im-thumb"><img
													src="${pageContext.request.contextPath}/resources/images/patientP.png"
													class="statics"></span>
												<h3 class="testData">ASHA Application</h3>
											</div>
										</a>
									</div>
									<div class="col-md-3">
										<a href="#" onclick="getLoginPatientPortal()">
											<div class="box_cms box">
												<span class="im-thumb"><img
													src="${pageContext.request.contextPath}/resources/images/webP.png"
													class="statics"></span>
												<h3 class="testData">Patient Web Portal</h3>
											</div>
										</a>
									</div>






								</div>
							</div>
							<!-- row end -->

						</div>
					</form>
				</div>

			</div>

		</div>


		<script type="text/javascript">


                   

                        
                        </script>

	</div>

	<script type="text/javascript">
			var resourceJSON = <%=UtilityServices.getJSLocaleJSON()%>;
</script>
	<script type="text/javascript">

function getLoginLdapAuthentication(){
	 
 
    var roles = ["RECEPTIONIST","DOCTOR","MEDICAL OFFICER"]; 
	var params = {
			"serviceNo" : $("#serviceNo1").val(),
            "roles":roles
	}
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : '${pageContext.request.contextPath}/user/showApplicationsOnRoleBase',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(response) {
			if(response.status=="1"){
									window.location="${pageContext.request.contextPath}/dashboard/dashboard";
									
								}else{
									alert(response.msg)
									return false;
								}
								
							},
							error : function(response) {
								alert("An error has occurred while contacting the server");
								/* window.location="${pageContext.request.contextPath}/v0.1/dashboard/dashboard"; */
							}
						});
						
						
				}
				
function getLoginPatientPortal(){
	var patientWebUrl=resourceJSON.PatientPortalURL;
	var getServiceNo=$("#serviceNo1").val();

	document.frm.action=patientWebUrl+"/PatientAppointmentWebPortal/appointment/getServiceDetails1";
	document.frm.method="POST";
	document.frm.submit(); 
	 
}			


</script>

	<script type="text/javascript">
            $(document).ready(function() {
            	var adId=localStorage.adId;
            	$('#welcomeId').text(adId);
            	var serNo=localStorage.serviceNo;
            	 document.getElementById('serviceNo1').value = serNo;
            	
            });
            function logoutApplication(){
    			var logoutWebUrl="{pageContext.request.contextPath}/dashboard/logouts";
           	    //$('.homeLogout a').attr('href',logoutWebUrl);
    			window.location=logoutWebUrl;
    		
    		}      
</script>
</body>


</html>