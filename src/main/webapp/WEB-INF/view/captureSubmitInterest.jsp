<%@page import="java.util.HashMap"%>
    <%@page import="java.util.Map"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

          
          <%@include file="..//view/leftMenu.jsp" %>

                <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                    <html>

                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
                        <%@include file="..//view/commonJavaScript.jsp" %>
                            <title>Bank Interest </title>
                     </head>

                    <%
	int i = 1;
%>






<style>
.block {
  display: block;
  width: 100%;
  border: none;
  background-color: #4CAF50;
  color: white;
  padding: 14px 28px;
  font-size: 16px;
  cursor: pointer;
  text-align: center;
}

.block:hover {
  background-color: #ddd;
  color: black;
}
</style>

<body>

 <!-- Begin page -->
    <div id="wrapper">
<div class="content-page">
                                <!-- Start content -->
 <div class="">
  <div class="container-fluid">
	 
	  <div class="internal_Htext">Bank Interest  </div>
	  

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                <input type="hidden" name="empCategory" id="empCategory" value=""/>
                                <input type="hidden" name="siqValue" id="siqValue" value=""/>
                                <input type="hidden" name="flagForFwc" id="flagForFwc" value=""/>
                                 <input type="hidden" name="viewPageFlag" id="viewPageFlag" value='${viewPage}'/>
                               <span class="submitMsg" id="valueSet">${msgRecall}</span> </p>
                              
                                <div id="vendor_submit">  
                                     <div class="row">
										<div class="col-md-12 text-right"> 
												<!-- <button type="button" id="printReportButton"   class="btn  btn-primary "
											onclick="printReport();">Print</button>
												 -->
														<button class="btn btn-primary opd_submit_btn"
															type="button" onclick="return backListReport();"
															id="clicked"></button>
													
												
										</div> 
										
										<!-- <div class="col-md-2"> 
												<button class="btn btn-primary opd_submit_btn"   type="button" onclick="return backListReport('1');" id="clicked">Back to List</button>  
										</div> -->

											


										</div>
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


 



<!---header text ends--->

											<div class="col-md-4">
											<div class="form-group">
												<input type="hidden" id="captureVendorBillDetailId" name="captureVendorBillDetailId"
													value=""/>
												<input type="hidden" id="typeOfVal" name="typeOfVal"
													value=""/>	
											</div>
										</div>


</div>
<script type="text/javascript" language="javascript">

$j(document).ready(function()
		{
			var typeOfVal=localStorage.typeOfVal;
			var fundAllocationHdId=localStorage.fundAllocationHdId;
			$('#captureVendorBillDetailId').val(fundAllocationHdId);
			$('#typeOfVal').val(typeOfVal);
			 if(typeOfVal=="fundFirstTime"){
	            	$("#clicked"). text("Back to Page");
				}
	            else
	            {
	            	$("#clicked"). text("Back to List");
	            }	
			
		});
            function backListReport() {
            				window.location.href ="captureInterest";
            }
            
            function printReport(){
            	var fundBillDetailId=$('#captureVendorBillDetailId').val();
          	 	 var url="${pageContext.request.contextPath}/report/fundBillReport?fundBillDetailId="+fundBillDetailId;
          	 	 openPdfModel(url);
      
          }
           	 	/*  document.frm.action="${pageContext.request.contextPath}/report/printRolReport?hId="+hospitalId+"&dId="+departmentId+"";
           	 	 document.frm.method="GET";
           		 document.frm.submit();  */
           	 /* }else{
           		 alert("Please select Unit");
           			return false; */
           	// }
           	 
                      
            
 </script> 
 
</html>
 <%@include file="..//view/modelWindowForReportsMultiple.jsp"%>