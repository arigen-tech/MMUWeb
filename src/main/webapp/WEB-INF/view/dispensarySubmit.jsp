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
                            <title>OPD Main</title>
                      <!--   <link href="/AshaWeb/resources/css/stylecommon.css" rel="stylesheet" type="text/css" /> -->
                    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newOpd.js"></script>
                    <%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opd.js"></script> --%>
                   	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opdpatientrecall.js"></script>
                    </head>

                    <%
	int i = 1;
    String hdId = request.getParameter("hdId");            
    String id = request.getParameter("id");
    String patientTypeFlag = request.getParameter("patientTypeFlag");
   
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
<form name="frm">

<div class="content-page">
                                <!-- Start content -->
 <div class="">
  <div class="container-fluid">
	 
	  <div class="internal_Htext">Prescription Reports </div>
	  

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">  
                                <p align="Left" id="message" style="color: green; font-weight: bold;">Medicine Issued Successfully. Do You want to print</p>
                                <div id="opd_submit">  
                                     <div class="row">
										<div class="col-12 text-right"> 
																<!-- <div id="reg_btn_div"> -->
																		<button class="btn btn-primary" type="button" name="btnReport" id="btnReport1"  onClick="makeUrl2()">Complete Registration</button>
																	<!-- </div> -->
																	<button class="btn btn-primary" type="button" name="btnReport" id="btnReport"  onClick="makeUrl()">Prescription Report</button>
																	
												<c:choose>
												<c:when test="${redirectValue =='dispencery'}">
													
														<button class="btn btn-primary opd_submit_btn"
															type="button" onclick="return backListReport();"
															id="clicked">Back to List</button>
														
												</c:when>

												<c:otherwise>
													
														<button class="btn btn-primary opd_submit_btn"
															type="button" onclick="return backListReport();"
															id="clicked">Back to List</button>
													
												</c:otherwise>
											</c:choose>
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
												<input type="text" id="prescription_id" name="prescription_id"
													value=""/>
											</div>
										</div>


  
</form>

</div>
  
  
  
  <script type="text/javascript">
            $(document).ready(function() {
                    $('#prescription_id').val(<%= id %>);
                    var type = "<%= patientTypeFlag %>";
                    if(type == ''){
                    	document.getElementById('btnReport1').style.visibility = 'visible';
                    }else{
                    	document.getElementById('btnReport1').style.visibility = 'hidden';
                    }
                
            });
  </script>              

 

<script type="text/javascript" language="javascript">
            function backListReport(flag) {
            				
                      window.location.href ="pendingPrescriptionJSP";
               				
            }
            
            
            
 </script>           
<script type="text/javascript" language="javascript">

function executeClickEvent()
{
	 //alert(Id)
	 var visitIdValue=$('#prescription_id').val();
	 window.location="getCaseSheet?visitId="+visitIdValue+"";
	
}

function printReport(flag) {
	 var pId = $('#prescription_id').val();
	//alert("flag : "+flag)
	if(flag=='P')
	document.frm.action="${pageContext.request.contextPath}/report/printissuedPrescriptionReport?id="+pId+"";
	if(flag=='N')
	document.frm.action="${pageContext.request.contextPath}/report/printNisSlip?id="+pId+"";
	
	document.frm.method="POST";
	document.frm.submit(); 
	
 }
 
function makeUrl(){
	
	var pId = "<%= hdId %>";
		 
	var url = "${pageContext.request.contextPath}/report/printissuedPrescriptionReport?id="+pId+"";
	openPdfModel(url);
}

function makeUrl2(){

	var pId = "<%= id %>";
	window.location="completePatientRegistration?id="+pId+"";	
}

</script>
</body>
</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>