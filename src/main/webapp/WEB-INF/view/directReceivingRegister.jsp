<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Direct Receiving Register</title>

<%@include file="..//view/leftMenu.jsp"%>
<%@include file="..//view/commonJavaScript.jsp"%>
</head>

<%			
	String hospitalId = "0";
	if (session.getAttribute("hospital_id") !=null)
	{
		hospitalId = session.getAttribute("hospital_id")+"";
	}
	String user_id = "0";
	if (session.getAttribute("user_id") != null) {
		user_id = session.getAttribute("user_id") + "";
	}

	String departmentId  = "0";
	if (session.getAttribute("department_id") != null) {
		departmentId  = session.getAttribute("department_id") + "";
	}
	
	SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); 

	Calendar c = Calendar.getInstance(); 
	Date startDate = c.getTime();
	String currentDate=formatter.format(startDate); 
%>

<script type="text/javascript" language="javascript">

$j(document).ready(function(){
	if(<%=departmentId%>!=0){
		$j("#frm :input").attr("disabled", false);
		$("#printReportButton").attr("disabled", false);
	}else{
		alert("Select the department");
		$j("#frm :input").attr("disabled", true);
		return false;
	}
});

 function search(){
	 	var nPageNo=1;			
	 	var from_date = $j('#from_date').val();
	 	var to_date = $j('#to_date').val();
		if((from_date == undefined || from_date == '') || (to_date == undefined || to_date == '')){	
			alert("Fill mandatory fields");
			return;
		}
		printReport();
 }
 
 function ResetForm()
 {	
	 $j('#from_date').val('');
 	 $j('#to_date').val('');
 }
 
 
 function printReport(){
	 var hospitalId= <%out.print(hospitalId);%>
	 var departmentId= <%out.print(departmentId);%>
	 var from_date = $j('#from_date').val();
	 var to_date = $j('#to_date').val();
	 
	 var url="${pageContext.request.contextPath}/report/printDirectReceivingSORegister?hospitalId="+hospitalId+"&departmentId="+departmentId+"&from_date="+from_date+"&to_date="+to_date;
	 openPdfModel(url);
	
 }
</script>
<body>
	<!-- Begin page -->
	<div id="wrapper">
		<form name="frm">
			<div class="content-page">
				<!-- Start content -->
				<div class="">
					<div class="container-fluid">

						<div class="internal_Htext">Direct Receiving Register</div>

						<!-- end row -->

						<div class="row">
							<div class="col-12">
								<div class="card">
									<div class="card-body">

										<div class="row">
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">From Date<span class="text-red">*</span></label>
													<div class="col-sm-7">
														<div class="dateHolder ">
															<input type="text" 
																class="calDate datePickerInput form-control"
																id="from_date" placeholder="DD/MM/YYYY" name="from_date"
																onkeyup="mask(this.value,this,'2,5','/');" value="<%=currentDate %>"
																onblur="validateExpDate(this,'dateId')" maxlength="10">
														</div>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">To Date<span class="text-red">*</span></label>
													<div class="col-sm-7">
														<div class="dateHolder ">
															<input type="text" 
																class="calDate datePickerInput form-control"
																id="to_date" placeholder="DD/MM/YYYY" name="to_date"
																onkeyup="mask(this.value,this,'2,5','/');" value="<%=currentDate %>"
																onblur="validateExpDate(this,'dateId')" maxlength="10">
														</div>
													</div>
												</div>
											</div>

											<div class="col-md-1">
												<div class="form-group row">

													<div class="col-sm-10">
														<button disabled type="button" id="printReportButton" class="btn btn-primary  nis-search"
															   onclick="search();">Print&nbsp;Report</button>
													</div>
												</div>
											</div>

										</div>
									
										
									<div class="col-md-4">
										<input type="hidden" class="form-control" name="departmentId" id="departmentId"
														 value="<%=departmentId%>" />
										<input type="hidden" class="form-control" id="userId"
											   name="userId"  value="<%=user_id%>">
											   
										<input type="hidden" class="form-control" id="hospitalId"
											   name="hospitalId"  value="<%=hospitalId%>">
							         </div>
								
									</div>
								</div>
								<!-- end card -->
							</div>
							<!-- end col -->
						</div>
						<!-- end row -->
						<!-- end row -->

					</div>
					<!-- container -->
				</div>
			</div>
		</form>
	</div>

</body>
</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>