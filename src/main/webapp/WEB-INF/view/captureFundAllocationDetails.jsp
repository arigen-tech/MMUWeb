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

</head>
<script type="text/javascript">
$(document).ready(function(){
	
	getStoreFinancialYear();
 
});
function getStoreFinancialYear(){
	 $j("#financialYear").empty();
	
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getStoreFinancialYear",
	    data: JSON.stringify({"PN" : "0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "" ;
	    	for(var i=0;i<result.MasStoreFinancialData.length;i++){
	    		combo += '<option value='+result.MasStoreFinancialData[i].financialId+'>' +result.MasStoreFinancialData[i].yearDescription+ '</option>';
	    		
	    	}
	    	
	    	jQuery('#financialYear').append(combo);
	    	
	    }
	    
	});
}
</script>
<body>
 <!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">Add/ View Fund Allocation</div>

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
                                                    <label class="col-form-label">Financial Year</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <select class="form-control" name="financialYear" id="financialYear">
                                                        <option value="">--Select--</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
								
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Scheme</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" value="MMSSY" disabled="disabled"/>
											</div>
										</div>
									</div>
									<div class="internal_Htext">Fund Allocation Details</div>
                                      <div class="row m-t-10">
                                     <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">Date</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <div class="dateHolder">
                                                        <input type="text" name="invoiceDate" readonly="true" class="calDate form-control" id="invoiceDate" value="" placeholder="DD/MM/YYYY" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                          <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">Total Allocated Amount</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <input type="text" id="invoiceAmount" name="invoiceAmount" class="form-control"/>
                                                </div>

                                            </div>
                                        </div>
                                       </div> 
                                    <table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th>Fund Allocation Date</th>
                                                <th>Fund Allocated </th>
                                                <th>View File</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody id="fundAllocationTable">
										  <tr>
										 	<td>22/05/2022</td>
										 	<td>50,000</td>
										 	<td><a href='#' class='btn btn-link'> File Name </a></td>
										 </tr>
                     				 </tbody>
                                    </table>
								</div>
							
							<div class="row">
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Action</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" disabled="disabled"/>
											</div>
										</div>
									</div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Remarks</label>
											</div>
											<div class="col-md-7">
												<textarea class="form-control" rows="3" disabled="disabled"></textarea>
											</div>
										</div>
									</div>
								</div>
							<div class="row"> 
                               <div class="col-md-12 text-right">														 
									<!-- <input type="button"  id="" type="button" class="btn  btn-primary " onclick="" value="Submit" /> -->
									<input type="button"  id="" type="button" class="btn  btn-primary " onclick="" value="Close" />
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



