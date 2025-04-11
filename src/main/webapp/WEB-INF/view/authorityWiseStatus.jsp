<%@page import="java.util.HashMap"%>
    <%@page import="java.util.Map"%>
    <%@ page import="com.mmu.web.utils.ProjectUtils"%>
        <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

          
        <%--   <%@include file="..//view/leftMenu.jsp" %> --%>

                <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                    <html>

                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
                               
                   
                       
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/css/icons.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/css/metismenu.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
  
   
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.datePicker.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/modernizr.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.common.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script> 
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/ajax.js"></script>  
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/hms.js"></script>                
                            <title>AuthorityWiseStatus</title>

<script type="text/javascript" language="javascript">

var nPageNo=1;
var $j = jQuery.noConflict();
$j(document).ready(function(){
	var modelResponse = ${response};
	console.log(modelResponse);
	var response = modelResponse.data.authorityWiseStatus;
	var upss = "";
	var vendor = "";
	var mmu = "";
	for(var i=0;i<response.length;i++){
		var resp = response[i];
		upss=resp.upss;
		vendor=resp.vendor;
		mmu = resp.mmu;
		genrateTable(i+1,resp);
	}
	
	$j("#upss_city").val(upss);
	$j("#vendor").val(vendor);
	$j("#mmu").val(mmu);
	
});
function genrateTable(seq,response){
	var iteration = $j('#my-table tr').length;
	var status = response.authority_action==="R"?"Rejected":"Approved";
	var tableRow='<tr>'+
	 	'<td>'+seq+'</td>'+
	 	'<td>'+response.authority_name+'</td>'+
	 	'<td>'+response.authority_date+'</td>'+
	 	'<td>'+status+'</td>'+
	 '</tr>';
	 $j("#tbl_authorityWiseData").append(tableRow);
	
	
}

</script>
</head>

<body>
 <!-- Begin page -->
	<div id="wrapper">
		<div>
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">Authority Wise Status</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
									<div class="col-md-3">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">UPSS</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" disabled value="" id="upss_city"> 
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Vendor</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" disabled value="" id="vendor"> 
											</div>
										</div>
									</div>
									<div class="col-md-5">
										<div class="form-group row">
											<div class="col-md-4">
												<label class="col-form-label">MMU</label>
											</div>
											<div class="col-md-8">
												<input type="text" class="form-control" disabled value="" id="mmu"> 
											</div>
										</div>
									</div>
									
									
								</div>
								
								
								
								<div class="row">
									
									
									<div class="col-12">
										<div class="table-responsive">
									<table class="table table-striped table-hover table-bordered "  id ="my-table">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>    
                                                <th>S. No.</th>
                                                <th>Approving Authority</th>                                                
                                                <th>Date of Action</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>                                        
	                                     <tbody class="" id="tbl_authorityWiseData">
											
	                     				 </tbody>
                                    </table>
								</div>
									</div>
									<div class="col-md-3">
										<!-- <span class="completeLeg"></span><span>Completed</span> 
									
										<span class="pendingLeg"></span><span>Pending</span> --> 
									</div>
								</div>
								
								
								<div class="row"> 
	                               <div class="col-md-12 text-right">		
	                              	<!-- 	<input type="button"  type="button" class="btn  btn-primary " onclick="genrateExcel()" value="Excel" />												 
										<input type="button"  type="button" class="btn  btn-primary " onclick="genratePdf()" value="PDF" /> -->
										<!-- <input type="button"  type="button" class="btn  btn-primary "  value="Back" /> -->
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






