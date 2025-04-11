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
        response.sendRedirect("/MMUWeb/dashboard/logouts");
     }
     
 %>

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
<link
	href="${pageContext.request.contextPath}/resources/css/captcha.css"
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
<script
	src="${pageContext.request.contextPath}/resources/js/captcha.js"></script>	

<script type="text/javascript">
	window.history.forward();
	 let captchaValue = "";
	function preventBack() {
		window.history.forward(1);
	}
	//var $j = jQuery.noConflict();
	$(document).ready(function(){
		captcha();
	});
	function getLoginApiSession(){
		$("#loadingDiv").show();
		 if($("#userId").val()=="")
			{
				alert("Please enter the user name");
				$("#loadingDiv").hide();
				return false;
			}
		 if($("#adPassword").val()=="")
			{
				alert("Please enter the password");
				$("#loadingDiv").hide();
				return false;
			}
		
		 var inputcaptchavalue=$('#captcha_form').val(captchaValue)
        $('#captcha_form').val(captchaValue);
		       /*  if (inputcaptchavalue != captchaValue) 
		        {
		        	 // swal("Invalid Captcha");
		            alert("Invalid Captcha");
		            $("#loadingDiv").hide();
		            return false;
		        } */
		       
	 
		var params = {
				'userName':$('#userId').val(),
				'password':$('#adPassword').val()
				     }
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : '${pageContext.request.contextPath}/user/getLoginApiSession',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(response) {
				var msg = response.msg;
				if(response.status=="1"){
					var data = response;
					
				           if(data.userFlag==1)
				           {	   
							window.location="${pageContext.request.contextPath}/dashboard/dashboard";
				           }
				           else if(data.userFlag==0)
				           {
				        	   var loginName= data.loginName;
				        	   var employeeId= data.employeeId;
				        	   var identificationTypeId=data.identificationTypeId;
							   localStorage.loginName=loginName;
							   localStorage.employeeId=employeeId;
							   localStorage.identificationTypeId=identificationTypeId;
				        	   window.location="${pageContext.request.contextPath}/dashboard/changePassword";
				        	}
					
				}
				else
				{
					
				  alert(msg);
				  $("#loadingDiv").hide();
								
				  }

						},
						error : function(response) {
							alert("! Something Went Wrong");
							$("#loadingDiv").hide();
						}
					});
			
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
	
				<%-- <c:if test="${not empty message}">
					   <div class="msg-alt-succ"><p> <i class="icon-check"></i>${message}</p></div>
					   </c:if> --%>
	
	
				<form class="form-vertical" name="loginForm" id="loginForm">
	
					<div class="hm-logo">
						<%-- <img
							src="${pageContext.request.contextPath}/resources/images/mmu-logo-lg.png"
							alt="logo"> --%>
							<h2>LOGIN</h2>
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
									name="userID" id="userId" type="text" size="30" maxlength="10" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
									placeholder="Username" required="required" autocomplete="on">
								<input class="form-control m-t-10" type="hidden" id="serviceNo1"
									value="">
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
					<%-- <div id="captcha" class="control-group">
                <div class="preview"></div>
                <div class="control-group"> 
                    <input type="text" id="captcha_form" class="form-control m-t-10" placeholder=" ">
                    <label class="control-group">Enter Captcha</label>
                    <button class="captcha_refersh"><img src="${pageContext.request.contextPath}/resources/images/reefreee.gif">
                        <i class="fa fa-refresh"></i>
                    </button>
                </div>
            </div> --%>
				 <div class="form-actions text-center">
						 <button class="btn btnLog" id="signIn" type="button" onclick="getLoginApiSession();">Login</button>
					</div>
				 <div class="form-actions text-center">
				   	 <a href="javascript:void(0)" id="forgotPasswordId" class="alink"  onclick="forgotPassword();">Forgot Password</a>
					</div>	
				
				</form>
	
			</div>
		</div>
		<div class="rightInfo">
			<img src="${pageContext.request.contextPath}/resources/images/right-info.jpg">
		</div>
	</section>
		<!-- <div class="marqueeBox">
			<marquee width="100%" direction="up" height="100%" scrollamount="5"  onmouseover="this.stop();" onmouseout="this.start();">
			    <ul>
			    	<li>This is sample scrolling text.</li>
			    	<li>This is sample scrolling text.</li>
			    	<li>This is sample scrolling text.</li>
			    	<li>This is sample scrolling text.</li>
			    	<li>This is sample scrolling text.</li>
			    	<li>This is sample scrolling text.</li>
			    	<li>This is sample scrolling text.</li>
			    	<li>This is sample scrolling text.</li>
			    	<li>This is sample scrolling text.</li>
			    </ul>
			</marquee>
		</div> -->
	<!-- <div class="modal" id="indexModal" tabindex="-1" role="dialog"
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
				<div class="text-center text-primary text-xsm">
			         loading <i class="fa fa-spin fa-spinner"></i>
			        </div>
			</div>
		</div>
	</div> -->
<script>
//change browser alert to custom alert
var ALERT_TITLE = "Alert";
var ALERT_BUTTON_TEXT = "Ok";

if(document.getElementById) {
    window.alert = function(txt) {
        createCustomAlert(txt);
    }
}

function createCustomAlert(txt) {
    d = document;
	
    var lastChar,newMsg;     
        
    if(d.getElementById("modalContainer")) return;

    mObj = d.getElementsByTagName("body")[0].appendChild(d.createElement("div"));
    mObj.id = "modalContainer";
    mObj.style.height = d.documentElement.scrollHeight + "px";
    
    alertObj = mObj.appendChild(d.createElement("div"));
    alertObj.id = "alertBox";
    if(d.all && !window.opera) alertObj.style.top = document.documentElement.scrollTop + "px";
    alertObj.style.left = (d.documentElement.scrollWidth - alertObj.offsetWidth)/2 + "px";
    alertObj.style.visiblity="visible";	
    h1 = alertObj.appendChild(d.createElement("h1"));
    
    //h1.appendChild(d.createTextNode(ALERT_TITLE));
	
    if(typeof txt === 'undefined' || txt === null) {
        txt = 'Undefined value'; 
        alertIcon = d.createElement('i');
        alertIcon.className ="fa fa-exclamation-triangle";
        
    }
    else{
	    lastChar = txt[txt.length -1];    
	    if( lastChar == 'S')
	   	{
	    	newMsg = txt.substring(0, txt.length-1);
	    	alertIcon = d.createElement('img');
	    	alertIcon.src = "${pageContext.request.contextPath}/resources/images/checkmarksuccess.gif";
	   	}    
	    else{
	    	newMsg = txt;
	    	alertIcon = d.createElement('i');
	    	alertIcon.className ="fa fa-exclamation-triangle";
	    }
    }
    
    h1.appendChild(alertIcon);
    
    msg = alertObj.appendChild(d.createElement("p"));
    //msg.appendChild(d.createTextNode(txt));
    msg.innerHTML = newMsg;

    btn = alertObj.appendChild(d.createElement("a"));
    btn.id = "closeBtn";
    btn.appendChild(d.createTextNode(ALERT_BUTTON_TEXT));
    btn.href = "#";
    btn.focus();
    btn.onclick = function() { removeCustomAlert();return false; };

    alertObj.style.display = "block";
    
}

function removeCustomAlert() {
    document.getElementsByTagName("body")[0].removeChild(document.getElementById("modalContainer"));
}

function ful(){
	alert('Alert');
}


localStorage.removeItem('dynamicLeftMenu');
localStorage.clear();

function forgotPassword()
{
	window.location="${pageContext.request.contextPath}/dashboard/forgotPassword";
}


</script>
<script>
$(document).keypress(function(e) {
	var key = e.which;
	if (key == 13) {
		getLoginApiSession();
	}
});

</script>
</body>
</html>