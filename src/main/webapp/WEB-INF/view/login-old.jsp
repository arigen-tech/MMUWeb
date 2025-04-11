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
function getLoginLdapAuthentication(){
	    $("#loadingDiv").show();
 	    if($("#userId").val()=="")
		{
			alert("Please enter the Ad Id");
			$("#loadingDiv").hide();
			return false;
		} 
 	   if($("#adPassword").val()=="")
		{
			alert("Please enter Password");
			$("#loadingDiv").hide();
			return false;
		} 
    var roles = ["RECEPTIONIST","DOCTOR","MEDICAL OFFICER"]; 
	
	var params = {
			'adId':$('#userId').val(),
			'password':$('#adPassword').val(),
		      }
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : '${pageContext.request.contextPath}/user/ldapAuthenticationUsersTest',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(response) {
			if(response.status=="1"){
				var data = response.data;
				
				for(var i=0;i<data.length;i++){
					<% session.setAttribute("notificationFlag","true"); %>
					serviceNo= data[i].serviceNo;
									var adId =  $('#userId').val();
									localStorage.adId=adId;
									localStorage.serviceNo=serviceNo;
									window.location="${pageContext.request.contextPath}/dashboard/homePage";
									
								}
							}
							
				else{
					if(response.status=="0"){
					var data = response.data;
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
		}
	});
}

function getLoginServiceNo(){
	$("#loadingDiv").show();
	 if($("#userId").val()=="")
		{
			alert("Please enter the AD Id");
			$("#loadingDiv").hide();
			return false;
		}  
    var roles = ["RECEPTIONIST","DOCTOR","MEDICAL OFFICER"]; 
	
	var params = {
			'adId':$('#userId').val(),
			     }
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : '${pageContext.request.contextPath}/user/getServiceNoforLogin',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(response) {
			if(response.status=="1"){
				var data = response.data;
				
				for(var i=0;i<data.length;i++){
					serviceNo= data[i].serviceNo;
					if(serviceNo!=null && serviceNo!="")
					{
									<% session.setAttribute("notificationFlag","true"); %>
									var adId =  $('#userId').val();
									localStorage.adId=adId;
									localStorage.serviceNo=serviceNo;
									window.location="${pageContext.request.contextPath}/dashboard/homePage";
									
								}else{
									$("#loadingDiv").hide();
									alert("Invalid Service Number")
									return false;
								}
								
							}
			}
			else
			{
				
				<%-- var data = response.data;
				<% session.setAttribute("notificationFlag","true"); %>
					for (var i = 0; i < data.length; i++) {
								var userId = data[i].userId;
								var loginName = data[i].loginName;
								if (userId != 0) {
									getLoginLdapAuthenticationForDigi(loginName)
								} else {
									$("#loadingDiv").hide();
									alert("User Does Not Exist")
									return false;
								}
							} --%>
						// Added by rahul temp
							$("#loadingDiv").hide();
							alert("User Does Not Exist")
							return false;
							
						}

					},
					error : function(response) {
						alert("An error has occurred while contacting the server");
						//window.location="${pageContext.request.contextPath}/dashboard/dashboard";
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
</script>

</head>
<body class="pb-0 login-page">

	<%--  <div class="pageLoader">
     	<img class="pageSpinner" src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
     </div>  --%>

	<div class="container">
		<div class="loginbox">

			<%-- <c:if test="${not empty message}">
				   <div class="msg-alt-succ"><p> <i class="icon-check"></i>${message}</p></div>
				   </c:if> --%>


			<form class="form-vertical" name="loginForm" id="loginForm">

				<div class="hm-logo">
					<img
						src="${pageContext.request.contextPath}/resources/images/logo-icg1.png"
						alt="logo">
				</div>
				<div class="control-group normal_text smlog">
					<h3>ICG SHIP PORTAL</h3>

				</div>
				<div>
					<div id="loadingDiv" class="text-center">
						<img
							src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
					</div>
				</div>
				<div class="control-group">
					<div class="controls">
						<div class="main_input_box">
							<span class="add-on"><i class="fa fa-user"> </i></span><input
								name="userId" id="userId" type="text" size="30" maxlength="50"
								placeholder="Enter AD ID" required="required" autocomplete="on">
							<input class="form-control m-t-10" type="hidden" id="serviceNo1"
								value="<%out.print(serviceNo1);%>">
						</div>
					</div>
				</div>
				<div class="control-group">
					<div class="controls">
						<div class="main_input_box">
							<span class="add-on"><i class="fa fa-lock"></i></span> <input
								name="password" type="password" size="20" placeholder="Password"
								id="adPassword" required="required" maxlength="48">
						</div>
					</div>
				</div>
				<div class="form-actions text-center">
					<!--  <button class="btn btnLog" id="signIn" type="button" onclick="getLoginLdapAuthentication();">Log In</button> -->
				</div>
				<div class="form-actions text-center">

					<button class="btn btnLog" id="signIn" type="button"
						onclick="getLoginServiceNo();">Sign In</button>
				</div>
				<!-- <span class="forget-pas">
					<a href="" onclick="ForgetPasswordAlert()" class="forgort">Forgot Password ?</a>
				</span> -->

				<div class="row">
					<div class="col-6">
						<input type="hidden" class="form-control" id="userId"
							name="userId" value="">
					</div>
					<div class="col-6">
						<input type="hidden" class="form-control" id="hospitalId"
							name="hospitalId" value="">
					</div>
				</div>
			</form>

		</div>
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



	<script>
		localStorage.removeItem('dynamicLeftMenu');
		localStorage.clear();
	</script>

	<script>
		$(document).keypress(function(e) {
			var key = e.which;
			if (key == 13) {
				getLoginLdapAuthentication();
			}
		});
	</script>

</body>
</html>