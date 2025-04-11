<%@page import="java.util.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
     <%@include file="..//view/leftMenu.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Minor Surgery Waiting List</title>
<%@include file="..//view/commonJavaScript.jsp"%>
</head>
<script type="text/javascript" language="javascript">
function getMinorSurgeryList(){
	window.location = "minorSurgeryWaitingJSP";
}

</script>
<body>

 <!-- Begin page -->
    <div id="wrapper">
	<div class="content-page">
		<div class="">
			<div class="container-fluid">
				<div class="internal_Htext">Minor Surgery</div>
				<!-- end row -->
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<form>								
									  
										<div class="row">
										<div class="col-md-12">	
										<p class="submitMsg" >Record Added Successfully</p>
										</div> 		 
														 <div class="col-md-12">															
															<div class="btn-right-all">															
                                                             <button type="button" class="btn btn-primary" onclick="getMinorSurgeryList()">Back to List</button>                                                 
															</div> 
													   </div> 
										     </div>
					
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>