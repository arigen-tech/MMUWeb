<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<title></title>

<script type="text/javascript">
var $j = jQuery.noConflict();

$j(document).ready(function()
		{
	
	GetMMUList();
	$j("#campDate").val(currentDate());
		});

		function GetMMUList(){
			jQuery.ajax({
			 	crossOrigin: true,
			    method: "POST",			    
			    crossDomain:true,
			    url: "${pageContext.servletContext.contextPath}/master/getAllMMU",
			    data: JSON.stringify({"PN":"0"}),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	var combo = "" ;
			    	
			    	for(var i=0;i<result.data.length;i++){
			    		combo += '<option value='+result.data[i].mmuId+'>' +result.data[i].mmuName+ '</option>';
			    		
			    	}
			    	
			    	jQuery('#mmuId').append(combo);
			    	
			    }
			    
			});
		}
		
		function currentDate(){
		 
		    var currentDate="";
			var now = new Date();
		   	now.setDate(now.getDate());
		   	var day = ("0" + now.getDate()).slice(-2);
		   	var month = ("0" + (now.getMonth() + 1)).slice(-2);
		   	var today = (day)+"/"+(month)+"/"+now.getFullYear();
		   	currentDate=today;
		   	return currentDate;
		 
		}
		
		
		function generateReport(){
			 var mmuId= $j("#mmuId").val();
		 var campDate = $j("#campDate").val()
		 
		 if(campDate ==''){
			 alert("Please select Camp Date");
			 return false;
		 }
		 
		var url = "${pageContext.request.contextPath}/report/printInspectionReport?campDate="
		       + campDate
		       + "&mmuId="
		       + mmuId;
		 openPdfModel(url)
		
		}

</script>

</head>

<body>
 <!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">MMU Inspection Report</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Camp Date</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" name="campDate" id="campDate" class="calDate form-control"
													value="" placeholder="DD/MM/YYYY" />
												</div>
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">MMU</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="mmuId">
												<option value="0">Select</option>
												</select>
											</div>
											
										</div>
									</div>
								</div>
								<div class="row">
                                	<div class="col-12 m-t-10 text-right">
                               			<button class="btn btn-primary" onclick="generateReport()">Generate Report</button>
                               		</div>
                          		</div>

							</div>
						</div>
						<!-- end card -->
					</div>
					<!-- end col -->
				</div>
				<!-- end row -->

			</div>
			<!-- container -->
			<!-- content -->
		</div>
	</div>
	<!-- END wrapper -->

</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>





