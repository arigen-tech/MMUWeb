<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MMU</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/favicon.png"
	type="image/x-icon">
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
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
	src="${pageContext.request.contextPath}/resources/js/jquery.core.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.app.js"></script>

<script type="text/javascript">
function getAuthenticateUserPr(){
	 $('#submitbtnId').prop("disabled", true);
			  var oderHdId=$('#orderHdId').val();
			   	document.authenticateUserForm.action="${pageContext.request.contextPath}/dashboard/getAuthenticateUser?oderHdIdTT="+oderHdId+"";
				document.authenticateUserForm.method='POST'
				document.authenticateUserForm.submit();
		  
	  }	 
</script>


</head>
<body class="pb-0 login clearfix">

<section class="loginSection">
	<div class="leftInfo">
		<img src="${pageContext.request.contextPath}/resources/images/left-info.jpg">
	</div>
	<div class="loginInfo">
		<img src="${pageContext.request.contextPath}/resources/images/right-text.png">
		
		<div class="loginbox">
	           
			 	 
			  	<p><h3><span class=""style="color:red;">${message}</span> </h3></h1></p> 
				<form class="form-vertical" name="authenticateUserForm" id="authenticateUserForm">
	                <input type="hidden" id="orderIdT" name="orderIdT" value="${orderHdId}">
	                <input type="hidden" name="mobileNoT" id="mobileNoT" value="${mobileNo}">
					<div class="hm-logo">
						 
							<h2>Authenticate User</h2>
					</div>
					
					
					<div>
						<div id="loadingDiv" class="text-center">
							<img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
						</div>
					</div>
					<div class="control-group">
						<div class="controls">
							<div class="main_input_box">
								<span class="add-on"><i class="fa fa-user"> </i></span><input
									name="MobileNo" id="MobileNo" type="text" size="30" maxlength="10" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
									placeholder="MobileNumber" required="required" value="${mobileNo}" autocomplete="on">
								 
							</div>
						</div>
					</div>
					<div class="control-group">
						<div class="controls">
							<div class="main_input_box">
								<span class="add-on"><i class="fa fa-lock"></i></span> <input
									name="orderHdId" type="text" size="20" placeholder="orderHdId"
									id="orderHdId" required="required" readonly value="${orderHdId}">
							</div>
						</div>
					</div>
				 <div class="form-actions text-center">
						 <button class="btn btnLog" id="signIn" type="button" onclick="getAuthenticateUserPr();">Validate User</button>
					</div>
				 
				</form>
	
			</div>
		</div>
		<div class="rightInfo">
			<img src="${pageContext.request.contextPath}/resources/images/right-info.jpg">
		</div>
	</section>
		 
 
</body>
</html>