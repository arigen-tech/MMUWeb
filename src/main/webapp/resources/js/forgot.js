//var $j = jQuery.noConflict();

var current_fs, next_fs, previous_fs; //fieldsets
var left, opacity, scale; //fieldset properties which we will animate
var animating; //flag to prevent quick multi-click glitches

var pathname = window.location.pathname;
var accessGroup = "MMUWeb";
$('.verification-box-body').hide();
$('.password-box-body').hide();
$('.response-box-body').hide();
var sessionId = '';
/*$("#form").validate({
	rules : {
		mobile_no : {
			required : true,
			maxlength : 10,
			minlength : 10,
			digits : true
		}
	},
	highlight : function(element) {
		$(element).closest('.control-group').addClass('error');
	},
	success : function(element) {
		$(element).closest('.control-group').removeClass('error')
	}
});*/

function sendOTP() {
	var url = window.location.protocol + "//" + window.location.host + "/"
			+ accessGroup + "/user/sendOtp";
		
	$.ajax({
		type : "POST",
		contentType : 'application/json',
		url : url,
		data : JSON.stringify({
			'mobileNo' : $('#userNameVal').val()
		}),
		timeout : 100000,
		success : function(res) {
			var data=res;
			var status='';
			var details='';
			var jsonParsedArray = JSON.parse(data);
			status=jsonParsedArray.Status;
			details=jsonParsedArray.Details;
			if (status == 'Success') {
				sessionId = details;
				//$('.register-box-body').hide();
				//$('.verification-box-body').show();
				//startTimer($('#timer'))

			}
		},
		error : function(e) {
			console.log("ERROR: ", e);
		},
	});
}

$('#resend_otp').click(
		function() {

			var url = window.location.protocol + "//" + window.location.host
					+ "/" + accessGroup + "/send_otp";
			$('.alert').alert('close');
			$.ajax({
				type : "POST",
				contentType : 'application/json',
				url : url,
				data : JSON.stringify({
					'mobile_no' : $('#username').val()
				}),
				timeout : 100000,
				success : function(res) {
					console.log(res)
					if (res.type == 'success') {
						startTimer($('#timer'))
					} else {
						$('#timer').before(
								'<div class="alert alert-danger fade in" role="alert">'
										+ res.message + '</div>');
					}
				},
				error : function(e) {
					console.log("ERROR: ", e);
				},
			});
		})
$('#back').click(function() {
	$('.register-box-body').show();
	$('.verification-box-body').hide();
})

	function verifyOtp() {
					$('.alert').alert('close');
					if (!$('#otp').val() == '') {

						var url = window.location.protocol + "//"
								+ window.location.host + "/" + accessGroup
								+ "/user/verifyOtp";
						$.ajax({
							type : "POST",
							contentType : 'application/json',
							url : url,
							data : JSON.stringify({
								'session_id' : sessionId,
								'otp' : $('#otp').val()
							}),
							timeout : 100000,
							success : function(res) {
								console.log("SUCCESS: ", res);
								var data=res;
								var status='';
								var details='';
								var jsonParsedArray = JSON.parse(data);
								status=jsonParsedArray.Status;
								details=jsonParsedArray.Details;
								
								if (status == 'Success') {
									nextView('second');
								} else {
									alert("Please enter valid OTP")
								}
							},
							error : function(e) {
								console.log("ERROR: ", e);
							},
						});
					} else {
						$('#timer')
								.before(
										'<div class="alert alert-danger fade in" role="alert">Please enter OTP</div>');
					}
     }

$('#send_otp').click(
		function() {
			if ($('#form').valid()) {
				var url = window.location.protocol + "//"
						+ window.location.host + "/" + accessGroup
						+ "/isEmployeeExists";
				$.ajax({
					type : "POST",
					contentType : 'application/json',
					url : url,
					data : JSON.stringify({
						'username' : $('#username').val(),
					}),
					timeout : 100000,
					success : function(res) {
						var datas = res.msg;
						if (res.status == '1') {
							sendOTP();
						} else {
							swal({
								title : datas,
								icon : "error",
							});
						}
					},
					error : function(e) {
						console.log("ERROR: ", e);
					},
				});
			}
		})

$('#conform_password').blur(function() {

	if ($('#new_password').val() == $('#conform_password').val()) {

		$('#message').html('Password Matched').css('color', 'green');
	} else {
		$('#message').html('Password Not Matching').css('color', 'red');
	}
})

$('#forgetPassword').click(
		function() {
			var password1 = $('#new_password').val();
			var password2 = $('#conform_password').val();
			if (password1 == '') {
				alert("Please enter Old Password");
				return;
			} else if (password2 == '') {
				alert("Please enter confirm password");
				return;
			}
			if (password1 == password2) {
				var url = window.location.protocol + "//"
						+ window.location.host + "/" + accessGroup
						+ "/forget_password";
				$.ajax({
					type : "POST",
					contentType : 'application/json',
					url : url,
					data : JSON.stringify({
						'username' : $('#username').val(),
						'new_password' : $('#new_password').val(),
					}),
					timeout : 100000,
					success : function(res) {
						var datas = res.msg;
						if (res.status == '1') {
							$('.password-box-body').hide();
							$('.response-box-body').show();
							$('#msg').html(datas)
						} else {
							swal({
								title : datas,
								icon : "error",
							});
						}
					},
					error : function(e) {
						console.log("ERROR: ", e);
					},
				});
			}
		})
function objectifyForm(formArray) {// serialize data function

	var returnArray = {};
	for (var i = 0; i < formArray.length; i++) {
		returnArray[formArray[i]['name']] = formArray[i]['value'];
	}
	return returnArray;
}

function startTimer(display) {
	var duration = 60 * 1;
	var timer = duration, minutes, seconds;
	setInterval(function() {
		minutes = parseInt(timer / 60, 10)
		seconds = parseInt(timer % 60, 10);

		minutes = minutes < 10 ? "0" + minutes : minutes;
		seconds = seconds < 10 ? "0" + seconds : seconds;

		display.html("(" + minutes + ":" + seconds + ")");

		if (--timer < 0) {
			timer = 0;
		}
	}, 1000);
}

function checkUserName()
{
	
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/user/checkUserName";
	
	if($('#userNameVal').val()=="")
	{
		alert("Please enter username")
		return false;
	}	
	
	$
	.ajax({
		url : url,
		dataType : "json",
		data : JSON.stringify({
			'userName' : $('#userNameVal').val()
		}),
		contentType : "application/json",
		type : "POST",
		success : function(response) {
			var msg = response.msg;
			if (response.status=="1") {
				nextView('first');
				sendOTP()
			}
			else
			{
				
			  alert(msg);
			
			}

		},
		error : function(e) {

			console.log("ERROR: ", e);

		},
		done : function(e) {
			console.log("DONE");
			alert("success");
			var datas = e.data;

		}
	});
	
}

function updatePassword(){
	
	var userName=$('#userNameVal').val();
	if(userName=="" ) {
    	alert("Please enter usernam number");
    	document.getElementById('userName').focus();
        return false;
      }
	
	var currentPassword=$('#newPassword').val();
	if(currentPassword=="" ) {
    	alert("Please enter new password");
    	document.getElementById('currentPassword').focus();
        return false;
      }
	var check=document.getElementById('newPassword').reportValidity();
	if (check==false) {
	    alert("Password Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters");
	    return false;
	}

	var newPassword=$('#confirmPassword').val();
	if(newPassword=="" ) {
    	alert("Please enter confirm password");
    	document.getElementById('newPassword').focus();
        return false;
      }
	 
	if(currentPassword!=newPassword)
	{
		alert("New password and confirm password does not match")
		return false;
	}
	
	 $("#btnSubit").attr("disabled", true);

	 var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";
	var urlPath = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/user/updateUsersRegistartionType"; 
	 var form = $('#msform')[0];
	// Create an FormData object 
    var formData = new FormData(form);
    
    formData.append("userId","");
    formData.append("userTypeValues", "");
    formData.append("masRoleIdValues","");
    formData.append("mobileNo", "");
    formData.append("nameOfUser",userName);
    formData.append("emailId",newPassword);
    formData.append("levelUsers","");
    formData.append("userTypeVal",'changePassword');
     
    
   
	 
	$.ajax({
		url : urlPath,
		dataType : "json",
		data : JSON.stringify({
			'userId':'',
			'userTypeValues' : '',
			'masRoleIdValues' : '',
			'mobileNo': '',
            'nameOfUser':userName,
            'emailId': newPassword,
            'levelUsers': '',
            'userTypeVal':'changePassword'
			
		}),
		/*contentType : "application/json",*/
		type : "POST",
		 enctype: "multipart/form-data",
         data: formData,
         processData: false,
         contentType: false,
         cache: false,
         dataType : "json",
         /*timeout : 100000,*/
		
		success : function(response) {
			
			if(response.status=="success"){
				//$('#errordiv').val("");
				//$('#messForTranstion').append(""+resourceJSON.msgForUnitAdminCreateNormalUser);
				//$('#messForTranstion').show();
				alert("User successfully created")
				window.location.reload();
			}
			if(response.status=="statusUpdated"){
				alert("Password change successfully");
				logoutApplication();
			}
			 
		if(response.status=="updateSuccess"){
			$('#errordiv').val("");
			$('#messForTranstion').append(""+resourceJSON.msgForUnitAdminUpdateNormalUser);
			$('#messForTranstion').show();	
		}
		
		if(response.status=="fail"){
			$('#errordiv').append(""+resourceJSON.msgForUnitAdminAlreadyExistNormalUser);
			$('#errordiv').show();	
			
		}
		$("#btnSubit").attr("disabled", false);	
		}
	
	});
 }

function logoutApplication(){
	var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";
	var urlPath = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/"; 
	window.location=urlPath;

}

var current_fs, next_fs, previous_fs; //fieldsets
var left, opacity, scale; //fieldset properties which we will animate
var animating; //flag to prevent quick multi-click glitches

function nextView(elem){
	if(animating) return false;
	animating = true;
	var elemparent = elem;
	
	if(elemparent=="first"){
		current_fs = $('#first');
		next_fs = $('#second');
	}
	else if(elemparent=="second"){
		current_fs = $('#second');
		next_fs = $('#third');
	}
	
	
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
}
