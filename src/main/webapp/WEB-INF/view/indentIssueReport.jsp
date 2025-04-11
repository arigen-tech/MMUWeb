<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.mmu.web.utils.HMSUtil"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
     <%@include file="..//view/leftMenu.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Indent Issue Report</title>

<%@include file="..//view/commonJavaScript.jsp" %>
</head>
 
<script type="text/javascript" language="javascript">
<%			
	String cityId = "0";
	if (session.getAttribute("cityIdUsers") != null) {
		cityId = session.getAttribute("cityIdUsers").toString();
		cityId = cityId.replace(",","");
	}
	String user_id = "0";
	if (session.getAttribute("user_id") != null) {
		user_id = session.getAttribute("user_id") + "";
	}
	String departmentId = HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim();
%>

var nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{
			GetCityList();
			if(<%= departmentId %> == '0'){
				alert("Please select department");
			}	
			
			
		});

 function getIssueAndIndentNo() { 	
	 var fromDate = $j('#fromDate').val();
	 	var toDate = $j('#toDate').val();
	 	var cityIdVal=$j('#cityIdDropDown').val();
	 	if(cityIdVal==0)
	 	{
	 		alert("Please select city");
	 		return false;
	 	}	
	 	//$j('#com').append('');
	 	$('#com')
			    .empty()
			    .append('<option selected="selected" value="">Select</option>')
			;
 	var data = {"cityId": cityIdVal, "departmentId":<%= departmentId %>,"fromDate":fromDate,"toDate":toDate};	 
 	
	$j.ajax({
		type : "POST",
		contentType : "application/json",
		url : 'getIssuNoAndIndentNo',
		data : JSON.stringify(data),
		dataType : "json",
		cache : false,
		success : function(msg) {
			
				var data = msg.data;
				var comboval="";
				//var comboval = "<option value=\"\">Select</option>";
				for (var i = 0; i < data.length; i++) {
					var option = data[i].issueDate+'-'+data[i].issueNo+'-'+data[i].indentNo;
					comboval += '<option value='+data[i].id+'>'+option+'</option>';
				}
				$j('#com').append(comboval);
		},

		error : function(msg) {

			alert("An error has occurred while contacting the server");

		}
	});
 	
 }
 
 function printReport(){
	 var fromDate = $j('#fromDate').val();
	 	var toDate = $j('#toDate').val();
	 var countDate=getDateComapareValue(fromDate,toDate);
 	 if(countDate!=0){
 		 alert("To Date should not be earlier than From Date.");
 		 return false;
 	 }
 	 if(toDate!="" && fromDate=="")
 	 {
 		 alert("Please select from date");
 		$('#toDate').val('')
 		 return false;	 
 	 }
	 var id = $('#com').find('option:selected').val();
	 if(id == ''){
		 alert("Please select issue reference No.");
		 return;
	 }
	 var url = "${pageContext.request.contextPath}/report/printIndentIssueReport?id="+id+"";
	 openPdfModel(url);	 
 }
 
 function checkFromFurtureDate(){
		
		var fromDate=document.getElementById("fromDate").value;
		
		var fromDateValue=new Date(fromDate.substring(6),(fromDate.substring(3,5) - 1) ,fromDate.substring(0,2));
		var currentDate=new Date();
		if((fromDateValue>currentDate))
		{
			document.getElementById("fromDate").value='';
			alert("From Date should not be future month and year");
			return false;
		}
		getIssueAndIndentNo();
		return true;
	}
 
 function checkToFurtureDate(){
		
		var fromDate=document.getElementById("toDate").value;
		
		var fromDateValue=new Date(fromDate.substring(6),(fromDate.substring(3,5) - 1) ,fromDate.substring(0,2));
		var currentDate=new Date();
		if((fromDateValue>currentDate))
		{
			document.getElementById("toDate").value='';
			alert("To Date should not be future month and year");
			return false;
		}
		getIssueAndIndentNo();
		return true;
	}
 
 function populateDates(){
	    var dt = new Date();
	    var currDate = ("0" + dt.getDate()).slice(-2)+'/'+("0" + (dt.getMonth() + 1)).slice(-2)+'/'+dt.getFullYear();
	    $('#fromDate').val(currDate);
	    $('#toDate').val(currDate);
	}
 
 function GetCityList(){
		jQuery.ajax({
		 	crossOrigin: true,
		    method: "POST",			    
		    crossDomain:true,
		    url: "${pageContext.servletContext.contextPath}/master/getAllCity",
		    data: JSON.stringify({"PN" : "0"}),
		    contentType: "application/json; charset=utf-8",
		    dataType: "json",
		    success: function(result){
		    	var combo = "" ;
		    	combo += "<option value=\"0\">Select</option>" ;
		    	for(var i=0;i<result.data.length;i++){
		    		combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
		    		
		    	}
		    	
		    	//jQuery('#city').append(combo);
		    	jQuery('#cityIdDropDown').append(combo);
		    	
		    }
		    
		});
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
	 
	  <div class="internal_Htext">Indent Issue Report</div>
	 
                    <!-- end row -->

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">			

                                     <div class="row">
                                     <div class="col-lg-3 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="cityIdDropDown" onchange="checkFromFurtureDate();">
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
													<input type="text" id="fromDate" class="calDate form-control" onchange="checkFromFurtureDate();" value="" placeholder="DD/MM/YYYY">
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
													<input type="text" id="toDate" class="calDate form-control" onchange="checkToFurtureDate()" value="" placeholder="DD/MM/YYYY">
												</div>
											</div>
										</div>
									</div>
	                                     <div class="col-md-4">	                                     
		                                     <div class="form-group row">
		                                     	<label class="col-mm-5 col-form-label">Issue Reference No<sup><span class="mandate">&#9733;</span></sup></label>
		                                     	<div class="col-md-7">
		                                     	      <select class="form-control" id="com">
		                                     	      <option value="">Select</option>
														</select>
		                                     	</div>		                                     	
		                                     </div>	                                     
	                                     </div>
	                                     
	                                      <div class="col-md-1">
	                                      <!-- <button type="button" class="btn btn-primary"  onclick="printReport()" style="margin-left:-10px;" > 
	                                     	Print</button> -->
	                                     	<input type="button" class="btn btn-primary" name="btnReport" value="Print" onclick="printReport();" style="margin-left:-10px;">
	                                      
	                                     </div>
	                                     <div class="col-md-3">
	                                     	 
	                                     </div>
	                                      <div class="col-md-4">
	                                     	 
	                                     </div>
                                     
                                     </div>						
						
                                    <!-- end row -->

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