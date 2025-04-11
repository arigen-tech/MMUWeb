
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
<script
	src="${pageContext.request.contextPath}/resources/js/modernizr.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>


</head>

<body class="welcome">
<div class="welcomeWrapper">
	<div class="container-fluid">
		
		<div class="welcomeHead clearfix">
			<div class="welcomeName">
				<img src="${pageContext.request.contextPath}/resources/images/name.jpg" />
			</div>
			<button class="btn welcomebtn" onclick="loginPage();">Login</button>
		</div>
		<div class="welcomeLogo">
			<img class="pull-left " src="${pageContext.request.contextPath}/resources/images/CGLogo.png" />
			<img class="pull-right" src="${pageContext.request.contextPath}/resources/images/Wlogo.png" />
		</div>
		<div class="row">
			<div class="col-10 text-center">
				<div class="mapImg">
					<img src="${pageContext.request.contextPath}/resources/images/welcome-page-img.jpg" />		
				</div>
			</div>
			
			<div class="col-2 text-center">
				<div class="welcomeBox">
					<img class="cmNote" src="${pageContext.request.contextPath}/resources/images/cm-note.png" />
					<img class="lmNote" src="${pageContext.request.contextPath}/resources/images/lm-note.png" />
				
				
					<div>
						<div class="halfDiv">
							<h3>BOOK an Appointment</h3>
							<div class="">
								<img src="${pageContext.request.contextPath}/resources/images/doc.png" />
								<a href="https://drive.google.com/file/d/1VDCRPMddNlDT2cEhjmu5HYTUqOMgApj5/view?usp=sharing">
									<h3>MMU Patient Login</h3>
								</a>
							</div>
						</div>
						
						<div class="mobAppLink halfDiv">
							<h3>Patient Mobile App</h3>
							<a href="https://drive.google.com/file/d/1VDCRPMddNlDT2cEhjmu5HYTUqOMgApj5/view?usp=sharing" target="_blank">
								<img src="${pageContext.request.contextPath}/resources/images/playstore.png" />
							</a>
							<a href="javascript:void(0)">
								<img  src="${pageContext.request.contextPath}/resources/images/appstore.png" />
							</a>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	
		 
		<div class="welcomeFooter text-center">
			<img class="m-t-10" src="${pageContext.request.contextPath}/resources/images/footer.png" />
		</div>
	</div>
</div>
</body>
</html>

<script>
function loginPage()
{
	
	window.location="index.jsp";
}

</script>