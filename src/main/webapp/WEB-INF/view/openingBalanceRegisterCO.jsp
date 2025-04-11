<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.mmu.web.utils.HMSUtil"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Opening Balance Register-CO</title>

<%@include file="..//view/leftMenu.jsp"%>
<%@include file="..//view/commonJavaScript.jsp"%>
</head>

<%			
	String deptId = HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim();
	/* if (session.getAttribute("departmentId") != null) {
		deptId = Long.parseLong(session.getAttribute("departmentId").toString());
	} */
	
	String cityId = "0";
	if (session.getAttribute("cityIdUsers") != null) {
		cityId = session.getAttribute("cityIdUsers") + "";
		cityId = cityId.replace(",", "");
		
	}
	
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	
	String levelOfUser = "1";
	if (session.getAttribute("levelOfUser") != null) {
		levelOfUser = session.getAttribute("levelOfUser") + "";
	}

	

	String departmentId = HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim();
	/* if (session.getAttribute("departmentId") != null) {
		departmentId  = session.getAttribute("departmentId") + "";
	} */
	
	SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); 

	Calendar c = Calendar.getInstance(); 
	Date startDate = c.getTime();
	String currentDate=formatter.format(startDate); 
%>



<script type="text/javascript" language="javascript">

var cityId =<%=cityId%>;
var $j = jQuery.noConflict();




$j(document).ready(function()
		{	
			GetCityList();	 
		});

function GetCityList(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	   // url: "${pageContext.servletContext.contextPath}/master/getAllCity",
	   url: "${pageContext.servletContext.contextPath}/master/getIndendeCityList", 
	   data: JSON.stringify({"PN" : "0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		
	    		if(cityId != 0) {
	    			if(result.data[i].cityId == cityId) {
	    				combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
	    			}
	    		}
	    		else {
	    				combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
	    			
	    			}
	    		
	    		
	    	}
	    	
	    	jQuery('#city').append(combo);
	    	
	    }
	    
	});
}


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
 
 function ResetForm(){	
	 $j('#from_date').val('');
 	 $j('#to_date').val('');
 }
 
 
 function printReport(){
		 var cityId=$j('#city').val();
		 var deptId=<%=departmentId%>;
		 var fromDate=$j('#from_date').val();
	     var toDate= $j('#to_date').val();	
     
     
	 var url="${pageContext.request.contextPath}/report/printOpeningBalanceRegisterCO?cityId="+cityId+"&deptId="+deptId
	    +"&fromDate="+fromDate+"&toDate="+toDate	    
		
	 openPdfModel(url);
	 
 }
 
 
 function compareDate(){
	 var fromDate = $('#from_date').val();
	 var toDate = $('#to_date').val();
	 
	 if(process(toDate) < process(fromDate)){
			alert("To Date should not be earlier than from Date");
			$('#to_date').val("");
			return;
	 }
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

						<div class="internal_Htext">Opening Balance Register-CO</div>

						<!-- end row -->

						<div class="row">
							<div class="col-12">
								<div class="card">
									<div class="card-body">

										<div class="row">
										
										<div class="col-md-3">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">City</label>
												</div>
												<div class="col-md-7">
													<select class="form-control" id="city">
												
												</select>
												</div>
											</div>
										</div>
											<div class="col-md-4">
												<div class="form-group row">
													<label class="col-sm-5 col-form-label">From Date<span class="text-red">*</span></label>
													<div class="col-sm-7">
														<div class="dateHolder ">
															<input type="text" 
																class="calDate datePickerInput form-control"
																id="from_date" placeholder="DD/MM/YYYY" name="from_date"
																onkeyup="mask(this.value,this,'2,5','/');" value="<%=currentDate %>"
																onblur="validateExpDate(this,'dateId')" maxlength="10"  onchange="compareDate()">
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
																onblur="validateExpDate(this,'dateId')" maxlength="10" onchange="compareDate()">
														</div>
													</div>
												</div>
											</div>

											<div class="col-md-12 text-right">
														<button  type="button" class="btn btn-primary  nis-search" id="printReportButton" 
															onclick="search();">Print&nbsp;Report</button>
												
											</div>

										</div>
									
										
									<div class="col-md-4">
										<input type="hidden" class="form-control" name="departmentId" id="departmentId"
														 value="<%=departmentId%>" />
										<input type="hidden" class="form-control" id="userId"
											   name="userId"  value="<%=userId%>">
											   
										
											   
										<!-- <input type="hidden" id="urlForReport" name="urlForReport" value=""> -->
										
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