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
<title>Opening Balance Register</title>

<%@include file="..//view/leftMenu.jsp"%>
<%@include file="..//view/commonJavaScript.jsp"%>
</head>

<%			
	String mmuId = "0";
	if (session.getAttribute("mmuId") !=null)
	{
		mmuId = session.getAttribute("mmuId")+"";
	}
	String user_id = "0";
	if (session.getAttribute("userId") != null) {
		user_id = session.getAttribute("userId") + "";
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


$j(document).ready(function(){
	getMMUList();
	if(<%=departmentId%>!=0){
		$("#printReportButton").attr("disabled", false);
	}else{
		alert("Select the department");
		return false;
	}
});

function getMMUList(){
	var params = {
			"levelOfUser":'<%=levelOfUser%>',
			"userId": <%= user_id %>
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
				   for(i=0;i<data.mmuList.length;i++){
						mmuDrop += '<option value='+data.mmuList[i].mmu_id+' selected>'+data.mmuList[i].mmu_name+'</option>';
						
					}
					$j('#mmuId').append(mmuDrop);
				<%--    document.getElementById('mmuId').value = <%=mmuId%>;  --%>
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
	 var mmuId=$j('#mmuId').val();
	 var deptId=<%=departmentId%>;
	 var fromDate=$j('#from_date').val();
	 var toDate= $j('#to_date').val();
	 var User_id = <%=user_id%>;
     var Level_of_user = '<%=levelOfUser%>';
     
	 var url="${pageContext.request.contextPath}/report/printOpeningBalanceRegister?mmuId="+mmuId+"&deptId="+deptId
	    +"&fromDate="+fromDate+"&toDate="+toDate
	    + "&User_id="
		+ User_id
		+ "&Level_of_user="
		+ Level_of_user;
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

						<div class="internal_Htext">Opening Balance Register</div>

						<!-- end row -->

						<div class="row">
							<div class="col-12">
								<div class="card">
									<div class="card-body">

										<div class="row">
										
										<div class="col-md-4">
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
														<button disabled type="button" class="btn btn-primary  nis-search" id="printReportButton" 
															onclick="search();">Print&nbsp;Report</button>
												
											</div>

										</div>
									
										
									<div class="col-md-4">
										<input type="hidden" class="form-control" name="departmentId" id="departmentId"
														 value="<%=departmentId%>" />
										<input type="hidden" class="form-control" id="userId"
											   name="userId"  value="<%=user_id%>">
											   
										<input type="hidden" class="form-control" id="hospitalId"
											   name="hospitalId"  value="<%=mmuId%>">
											   
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