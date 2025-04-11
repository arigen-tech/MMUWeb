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
<script
	src="${pageContext.request.contextPath}/resources/js/modernizr.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.easing.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.core.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.app.js"></script>

<style>
/*form styles*/
#msform {
	width: 400px;
	margin: 150px auto;
	text-align: center;
	position: relative;
}
#msform fieldset {
	background: white;
	border: 0 none;
	border-radius: 10px;
	box-shadow: 0 4px 15px rgb(0 0 0 / 15%);
	padding: 20px 30px;
	box-sizing: border-box;
	width: 80%;
	margin: 0 10%;
	
	/*stacking fieldsets above each other*/
	position: relative;
}
/*Hide all except first fieldset*/
#msform fieldset:not(:first-of-type) {
	display: none;
}
/*inputs*/
#msform input, #msform textarea {
	padding: 15px;
	border: 1px solid #ccc;
	border-radius: 3px;
	margin-bottom: 10px;
	width: 100%;
	box-sizing: border-box;
	font-family: montserrat;
	color: #2C3E50;
	font-size: 13px;
}
/*buttons*/
#msform .action-button {
	width: 110px;
	background: #115aa7;
	font-weight: bold;
	color: white;
	border: 0 none;
	border-radius: 1px;
	cursor: pointer;
	padding: 10px 5px;
	margin: 10px 5px;
}
#msform .action-button:hover, #msform .action-button:focus {
	box-shadow: 0px 5px 10px rgb(0 0 0 / 40%);
}
/*headings*/
.fs-title {
	font-size: 18px;
	text-transform: uppercase;
	color: #2C3E50;
	margin-bottom: 20px;
}
.fs-subtitle {
	font-weight: normal;
	font-size: 13px;
	color: #666;
	margin-bottom: 20px;
}
/*progressbar*/
#progressbar {
	margin-bottom: 30px;
	overflow: hidden;
	/*CSS counters to number the steps*/
	counter-reset: step;
}
#progressbar li {
	list-style-type: none;
	color: #666;
	text-transform: uppercase;
	font-size: 11px;
	width: 33.33%;
	float: left;
	letter-spacing:0.6px;
	position: relative;
}
#progressbar li:before {
	content: counter(step);
	counter-increment: step;
	width: 35px;
	line-height: 35px;
	display: block;
	font-size: 10px;
	color: #333;
	background: #eee;
	border-radius: 50%;
	margin: 0 auto 5px auto;
}
/*progressbar connectors*/
#progressbar li:after {
	content: '';
	width: 100%;
	height: 2px;
	background: #ddd;
	position: absolute;
	left: -50%;
	top: 17px;
	z-index: -1; /*put it behind the numbers*/
}
#progressbar li:first-child:after {
	/*connector not needed before the first step*/
	content: none; 
}
/*marking active/completed steps green*/
/*The number of the step and the connector before it = green*/
#progressbar li.active:before,  #progressbar li.active:after{
	background: #27AE60;
	color: white;
}

</style>
<style>
/* Style all input fields */
input {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 6px;
  margin-bottom: 16px;
}

/* Style the submit button */
input[type=submit] {
  background-color: #04AA6D;
  color: white;
}

/* Style the container for inputs */
.container {
  background-color: #f1f1f1;
  padding: 20px;
}

/* The message box is shown when the user clicks on the password field */
#message {
  display:none;
  background: #f1f1f1;
  color: #000;
  position: relative;
  padding: 20px;
  margin-top: 10px;
}

#message p {
  padding: 10px 35px;
  font-size: 18px;
}

/* Add a green text color and a checkmark when the requirements are right */
.valid {
  color: green;
}

/* Add a red text color and an "x" when the requirements are wrong */
.invalid {
  color: red;
}

</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/forgot.js"></script>  

</head>
<body class="pb-0 login clearfix">

	
<form id="msform" name="msform" method="post">
  <!-- progressbar -->
  <ul id="progressbar">
    <li class="active">Username</li>
    <li>Enter OTP</li>
    <li>Confirm</li> 
  </ul>
  <!-- fieldsets -->
  <fieldset id="first">
    <h2 class="fs-title">Username</h2>
    <!-- <h3 class="fs-subtitle">This is step 1</h3> -->
    <input type="text" name="userName" id="userNameVal" placeholder="Username" maxlength="10" />
    <!-- <input type="button" name="next" class="action-button" value="Edit Username" /> -->
    <input type="button" name="enterUsername" id="enterUsername" class="next action-button" value="Next" onclick="checkUserName()" />
    <div class="form-actions text-center m-t-10">
   	 <a href="${pageContext.request.contextPath}/dashboard/logouts" id="forgotPasswordId" class="alink">Back To Login</a>
	</div>	
  </fieldset>
  
  <fieldset id="second">
    <h2 class="fs-title">Enter OTP</h2>
    <input type="text" name="otp" id="otp" maxlength="6" placeholder="OTP" />
    <!-- <input type="button" name="previous" class="previous action-button" value="Back" /> -->
    <input type="button" name="next" class="next action-button" id="optVerify" value="Next" onclick="verifyOtp()" />
  </fieldset>
  <fieldset id="third">
    <h2 class="fs-title">Update Password</h2>
    <input type="password" id="newPassword" placeholder="New Password" placeholder=" " pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" required />
    <input type="password" id="confirmPassword" placeholder="Confirm Password" />
    <!-- <input type="button" name="previous" class="previous action-button" value="Back" /> -->
    <input type="button" name="submit" id="btnSubit" class="submit action-button" onclick="updatePassword()" value="Confirm" />
  </fieldset>
                                                 <div id="message">
													  <h3>Password must contain the following:</h3>
													  <p id="letter" class="invalid">A <b>lowercase</b> letter</p>
													  <p id="capital" class="invalid">A <b>capital (uppercase)</b> letter</p>
													  <p id="number" class="invalid">A <b>number</b></p>
													  <p id="length" class="invalid">Minimum <b>8 characters</b></p>
													</div>
  
</form>
		

<script>
//jQuery time
/* var current_fs, next_fs, previous_fs; //fieldsets
var left, opacity, scale; //fieldset properties which we will animate
var animating; //flag to prevent quick multi-click glitches

$(".next").click(function(){
	if(animating) return false;
	animating = true;
	
	current_fs = $(this).parent();
	next_fs = $(this).parent().next();
	
	//activate next step on progressbar using the index of next_fs
	$("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");
	
	//show the next fieldset
	next_fs.show(); 
	//hide the current fieldset with style
	current_fs.animate({opacity: 0}, {
		step: function(now, mx) {
			//as the opacity of current_fs reduces to 0 - stored in "now"
			//1. scale current_fs down to 80%
			scale = 1 - (1 - now) * 0.2;
			//2. bring next_fs from the right(50%)
			left = (now * 50)+"%";
			//3. increase opacity of next_fs to 1 as it moves in
			opacity = 1 - now;
			current_fs.css({
        'transform': 'scale('+scale+')',
        'position': 'absolute'
      });
			next_fs.css({'left': left, 'opacity': opacity});
		}, 
		duration: 800, 
		complete: function(){
			current_fs.hide();
			animating = false;
		}, 
		//this comes from the custom easing plugin
		easing: 'easeInOutBack'
	});
});

$(".previous").click(function(){
	if(animating) return false;
	animating = true;
	
	current_fs = $(this).parent();
	previous_fs = $(this).parent().prev();
	
	//de-activate current step on progressbar
	$("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");
	
	//show the previous fieldset
	previous_fs.show(); 
	//hide the current fieldset with style
	current_fs.animate({opacity: 0}, {
		step: function(now, mx) {
			//as the opacity of current_fs reduces to 0 - stored in "now"
			//1. scale previous_fs from 80% to 100%
			scale = 0.8 + (1 - now) * 0.2;
			//2. take current_fs to the right(50%) - from 0%
			left = ((1-now) * 50)+"%";
			//3. increase opacity of previous_fs to 1 as it moves in
			opacity = 1 - now;
			current_fs.css({'left': left});
			previous_fs.css({'transform': 'scale('+scale+')', 'opacity': opacity});
		}, 
		duration: 800, 
		complete: function(){
			current_fs.hide();
			animating = false;
		}, 
		//this comes from the custom easing plugin
		easing: 'easeInOutBack'
	});
});
 */


</script>	
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

</script>
<script>
var myInput = document.getElementById("newPassword");
var letter = document.getElementById("letter");
var capital = document.getElementById("capital");
var number = document.getElementById("number");
var length = document.getElementById("length");

// When the user clicks on the password field, show the message box
myInput.onfocus = function() {
  document.getElementById("message").style.display = "block";
}

// When the user clicks outside of the password field, hide the message box
myInput.onblur = function() {
  document.getElementById("message").style.display = "none";
}

// When the user starts to type something inside the password field
myInput.onkeyup = function() {
  // Validate lowercase letters
  var lowerCaseLetters = /[a-z]/g;
  if(myInput.value.match(lowerCaseLetters)) {
    letter.classList.remove("invalid");
    letter.classList.add("valid");
  } else {
    letter.classList.remove("valid");
    letter.classList.add("invalid");
}

  // Validate capital letters
  var upperCaseLetters = /[A-Z]/g;
  if(myInput.value.match(upperCaseLetters)) {
    capital.classList.remove("invalid");
    capital.classList.add("valid");
  } else {
    capital.classList.remove("valid");
    capital.classList.add("invalid");
  }

  // Validate numbers
  var numbers = /[0-9]/g;
  if(myInput.value.match(numbers)) {
    number.classList.remove("invalid");
    number.classList.add("valid");
  } else {
    number.classList.remove("valid");
    number.classList.add("invalid");
  }

  // Validate length
  if(myInput.value.length >= 8) {
    length.classList.remove("invalid");
    length.classList.add("valid");
  } else {
    length.classList.remove("valid");
    length.classList.add("invalid");
  }
}
</script>

</body>
</html>