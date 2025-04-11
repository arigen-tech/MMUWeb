<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
    
    String ServiceNo="755021-W";
    
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
     
     String userName = request.getHeader("oam_user_firstname");
     String serviceNo1 = request.getHeader("oam_userid");
    
     
     %>

<%
		//The session has been expired (or a hacker supplied a fake cookie).
     if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid() && JsessionId == null) 
     {
        response.sendRedirect("http://simha.chakra.icg:7777/oam/server/logout?end_url=http://simha.chakra.icg:7777/webcenter");
     }
     
 %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Indian Coast Guard</title>
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



<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/metismenu.min.css"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/icons.css"
	rel="stylesheet" type="text/css" />

<script
	src="${pageContext.request.contextPath}/resources/js/modernizr.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/metisMenu.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.slimscroll.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.scrollTo.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.core.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.app.js"></script>
	
<style>
body{
	background:#fff;
}
.shipLanding{
 text-align:center;
 padding-top:20%;
}
</style>
</head>
<body>
	
	 <div class="pageLoader shipLanding" >
     	<img class="pageSpinner" src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
     	<h3>Please Wait ...</h3>
     </div> 

	<!-- end account-box-->
	<!-- modal starts -->
	<div class="modal" id="indexModal" tabindex="-1" role="dialog"
		aria-labelledby="indexModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title font-weight-bold"></h5>

				</div>
				<div class="modal-body">
					<div class="text-center text-theme text-xsm">Please Wait ...
					</div>
				</div>
				<!-- <div class="text-center text-primary text-xsm">
			         loading <i class="fa fa-spin fa-spinner"></i>
			        </div> -->
			</div>
		</div>
	</div>


<script src="http://10.0.144.245:8089/auth/js/keycloak.js" type="text/javascript">

<script type="text/javascript">
	window.history.forward();
	function preventBack() {
		window.history.forward(1);
	}
</script>
<script type="text/javascript">
	
	
function getLogin(){
		
		if($("#serviceNo").val()=="")
			{
				alert("Please enter the service no");
				return false;
			}
		var serviceNo=$("#serviceNo").val();
		var roles = ["RECEPTIONIST","DOCTOR","MEDICAL OFFICER"];
		var params = {
				"serviceNo" : serviceNo,
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
					window.location="${pageContext.request.contextPath}/dashboard/loginFail";
					
					//alert(response.msg)
					return false;
				}
				
			},
			error : function(response) {
				alert("An error has occurred while contacting the server");
			}
		});
	}
	
	
function getLogin1(){
		
		if($("#serviceNo1").val()=="")
			{
				alert("Please enter the service no");
				return false;
			}
		alert($("#serviceNo1").val());
		var serviceNo=$("#serviceNo1").val();
		var roles = ["RECEPTIONIST","DOCTOR","MEDICAL OFFICER"];
		var params = {
				"serviceNo" : serviceNo,
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
					window.location="${pageContext.request.contextPath}/dashboard/home";
					
				}else{
					
					alert(response.msg)
					return false;
				}
				
			},
			error : function(response) {
				alert("An error has occurred while contacting the server");
			}
		});
	}
var serviceNo='';	
var simhaHomeServiceNo='';
var adId='';

$(document).ready(function() {
	
	var keycloak = new Keycloak({
		"realm" : "demo",
		"auth-server-url" : "http://10.0.144.245:8089/auth/",
		//"auth-server-url" : "http://10.0.144.219:8089/auth/",
		//"auth-server-url" : "http://172.105.34.168:8089/auth/",
		"ssl-required" : "NONE",
		"clientId" : "democlient1",
		"public-client" : true,
		"confidential-port" : 0,
		"enable-cors" : true,
		"cors-max-age" : 1000,
		"cors-allowed-methods" : "*",
		"cors-allowed-headers" : "*",
		"cors-exposed-headers" : "X-Custom3, X-Custom4",
		"allow-any-hostname" : true
		});
		//alert("Keycloak "+keycloak);
		var loadData = function() {
		// alert("Subject="+JSON.stringify(keycloak.subject));
		if (keycloak.idToken) {
		//alert('IDToken');
		//alert(keycloak.idTokenParsed.preferred_username);
		// alert(keycloak.idTokenParsed.email);
		// alert(keycloak.idTokenParsed.name);
		// alert(keycloak.idTokenParsed.given_name);
		// alert(keycloak.idTokenParsed.family_name);
		//document.getElementById('name').innerHTML = keycloak.idTokenParsed.name;
		//document.getElementById('fname').innerHTML = keycloak.idTokenParsed.name;
		 adId = keycloak.idTokenParsed.preferred_username;
		 alert("adId ::: "+adId);
		// alert("TokenParsed...."+JSON.stringify(keycloak.tokenParsed));
		// alert("idTokenParsed....."+JSON.stringify(keycloak.idTokenParsed));
		console.log(JSON.stringify(keycloak.tokenParsed));
		var s = JSON.stringify(keycloak.tokenParsed);
		getLoginServiceNo(adId);
		alert("S---->"+s);
		//localStorage.setItem("keycloakStorage", s);
		//location.reload();
		//dashBoardPopulate();
		//getRobooboUnit();
		//appDashboard();
		} else {
		keycloak
		.loadUserProfile(
		function() {
		alert('Account Service');
		alert(keycloak.profile.username);
		/* document.getElementById('email').innerHTML = keycloak.profile.email;
		document.getElementById('name').innerHTML = keycloak.profile.firstName + ' ' + keycloak.profile.lastName;
		document.getElementById('givenName').innerHTML = keycloak.profile.firstName;
		document.getElementById('familyName').innerHTML = keycloak.profile.lastName; */
		//showLoginPage();
		},
		function() {
		alert('Failed to retrieve user details. Please enable claims or account role');
		});
		}
		};
		var loadFailure = function() {
		alert('<b>Failed to load data. Check console log</b>');
		};
		var reloadData = function() {
		keycloak.updateToken(10).success(loadData).error(function() {
		alert('<b>Failed to load data. User is logged out.</b>');
		});
		}
		keycloak.init({
		onLoad : 'login-required'
		}).success(reloadData);
})


function getLoginServiceNo(adId){
	
	   var roles = ["RECEPTIONIST","DOCTOR","MEDICAL OFFICER"]; 
		
		var params = {
				'adId':adId,
				'password':$('#adPassword').val(),
			      }
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : '${pageContext.request.contextPath}/user/ldapAuthenticationUsersTest',
			//url : '${pageContext.request.contextPath}/user/getServiceNoforLogin',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(response) {
				if(response.status=="1"){
					var data = response.data;
					
					for(var i=0;i<data.length;i++){
						<% session.setAttribute("notificationFlag","true"); %>
						simhaHomeServiceNo= data[i].serviceNo;
						var params = {
								"serviceNo" : simhaHomeServiceNo,
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
														var serviceNo=$("#serviceNo1").val();
														localStorage.serviceNo=serviceNo;
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
					}
								
					else{
						if(response.status=="0"){
						var data = response.data;
						if(data!=null && data!=undefined)
						{
						<% session.setAttribute("notificationFlag","true"); %>
						for(var i=0;i<data.length;i++){
							var userId= data[i].userId;
							var loginName=data[i].loginName;
							if(userId!=0){
								getLoginLdapAuthenticationForDigi(loginName)
							}
							else{
								$("#loadingDiv").hide();
								alert("User Does Not Exist")
								return false;	
							}
							}
						}
						else
						{
							$("#loadingDiv").hide();
							alert("There is a problem connectiong to the server.Please try again.");
						}
						}
						else{
							$("#loadingDiv").hide();
							alert("Invalid username or password")
							return false;
						}
						}
				
			},
			error : function(response) {
				$("#loadingDiv").hide();
				alert(response.msg)
				/* window.location="${pageContext.request.contextPath}/v0.1/dashboard/dashboard"; */
			}
		});
	 
	}

	function getLoginLdapAuthenticationForDigi(loginName) {

		var roles = [ "RECEPTIONIST", "DOCTOR", "MEDICAL OFFICER" ];
		var params = {
			"serviceNo" : loginName,
			"roles" : roles
		}

		$
				.ajax({
					type : "POST",
					contentType : "application/json",
					url : '${pageContext.request.contextPath}/digifileupload/showApplicationsOnRoleBaseForDigi',
					data : JSON.stringify(params),
					dataType : "json",
					cache : false,
					success : function(response) {
						if (response.status == "1") {
							//window.location="${pageContext.request.contextPath}/dashboard/dashboard";
							window.location = "${pageContext.request.contextPath}/dashboard/homePageDigi";
						} else {
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
	
	function getImport(){
		window.location = '${pageContext.request.contextPath}/ship/importToShipUtil';
	}
</script>


	<script>
		localStorage.removeItem('dynamicLeftMenu');
		localStorage.clear();
	</script>

	


</body>
</html>