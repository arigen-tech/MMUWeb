<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Mobile Medical Unit- MMSSY</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>

<script type="text/javascript">

		<% 
		String userId = "1";
		if (session.getAttribute("user_id") != null) {
			userId = session.getAttribute("user_id") + "";
		}
		
		String levelOfUser = "1";
		if (session.getAttribute("levelOfUser") != null) {
			levelOfUser = session.getAttribute("levelOfUser") + "";
		}
		
		String mmuId = "1";
		if (session.getAttribute("mmuId") != null) {
			mmuId = session.getAttribute("mmuId") + "";
		}
       %>

	var $j = jQuery.noConflict();
	
	$j(document).ready(function()
		{
          
		$j("#fromDate").val(currentDate);
		$j("#toDate").val(currentDate);
		getMMUList();
		
		});


	function getMMUList(){
		var params = {
				"levelOfUser":'<%=levelOfUser%>',
				"userId": <%=userId%>
		}
		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : '${pageContext.request.contextPath}/master/getMMUHierarchicalList',
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(result) {
				   var mmuDrop = '';
				   var data=result.mmuListdata;
				   
				   if(data.mmuList.length =='1'){
					   $('#mmuId').attr('disabled', true);
					   var mmuidTemp=0;
					   for(i=0;i<data.mmuList.length;i++){
							mmuDrop += '<option value='+data.mmuList[i].mmu_id+' selected>'+data.mmuList[i].mmu_name+'</option>';
					//		mmuidTemp=data.mmuList[i].mmu_id;
						}
						$j('#mmuId').append(mmuDrop);
						<%-- if(mmuidTemp=='<%=mmuId%>')
					   	document.getElementById('mmuId').value = <%=mmuId%>; --%>  
				   }
				   else{
					for(i=0;i<data.mmuList.length;i++){
						mmuDrop += '<option value='+data.mmuList[i].mmu_id+'>'+data.mmuList[i].mmu_name+'</option>';
						
					}
					$j('#mmuId').append(mmuDrop);
				  }
			},
			error : function(data) {
				alert("An error has occurred while contacting the server");
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
	
	function compareToFromDate() {
		var fromDate = $('#fromDate').val();
		var toDate = $('#toDate').val();

		if (process(toDate) < process(fromDate)) {
			alert("To Date should not be earlier than from Date");
			$('#toDate').val("");
			return;
		}
	}
	
	function generateReport(){

		 var mmu_id = $('#mmuId').val();             
         var User_id = <%=userId%>;
         var Level_of_user = '<%=levelOfUser%>';
		 var fromDate = $j("#fromDate").val();
		 var toDate = $j("#toDate").val();
		 if(fromDate ==''){
			 alert("Please select From Date");
			 return false;
		 }
		 if(toDate ==''){
			 alert("Please select To Date");
			 return false;
		 }
       var url = "${pageContext.request.contextPath}/report/printIndentRegister?fromDate="
		+ fromDate
		+ "&toDate="
		+ toDate
		+ "&mmu_id="
		+ mmu_id
		+ "&User_id="
		+ User_id
		+ "&Level_of_user="
		+ Level_of_user;
        openPdfModel(url);

     }
	
</script>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">Indent Register</div>

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
												<label class="col-form-label">MMU</label>
											</div>
											<div class="col-md-7">
											<select class="form-control" id="mmuId">
													<option value="0">All</option>
												</select>
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">From Date</label>
											</div>
											<div class="col-md-7">
											<div class="dateHolder">
												<input type="text" name="fromDate" id="fromDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" onchange="compareToFromDate();" >
											</div>
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">To Date</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" name="fromDate" id="toDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY" onchange="compareToFromDate();" >
												</div>
											</div>
										</div>
									</div>

									<div class="col-lg-12 text-right col-sm-12">
										
										<button type="button" class="btn btn-primary m-t-3" onclick="generateReport();">Generate Report</button>
										
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

	<!-- jQuery  -->


</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
