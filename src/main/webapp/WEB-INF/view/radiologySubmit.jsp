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
                            <title>Radiology</title>
                      <!--   <link href="/AshaWeb/resources/css/stylecommon.css" rel="stylesheet" type="text/css" /> -->
                    
                    </head>

                    <%
	int i = 1;
    String id = request.getParameter("dtId");
    String flag = request.getParameter("flag");
    System.out.println(id);
    
    String hospitalId = "1";
    if (session.getAttribute("hospital_id") != null) {
    	hospitalId = session.getAttribute("hospital_id") + "";
    }

    String user_id = "0";
    if (session.getAttribute("user_id") != null) {
    	user_id = session.getAttribute("user_id") + "";
    }
%>
<script type="text/javascript" language="javascript">
	var $j = jQuery.noConflict();
</script>
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
	 
	  <div class="internal_Htext">Radiology</div>
	  

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">  
                                <p  id="message" class="submitMsg"></p>
                                <div id="opd_submit">  
                                     <div class="row">
										<div class="col-12 text-right"> 
												<button type="button" class=" btn btn-primary opd_submit_btn" onclick="printRadiology()">Print</button> 
										
												 <button type="button" class="btn btn-primary opd_submit_btn" onclick="backToWaitingList();">Back</button> 
												
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

											


  
</form>

<form name="frm1">
<input type="hidden" id = "flag" name="flag" value="">
<input type="hidden" id = "dtId" name="dtId" value="">
<input type="hidden" id = "userId" name="userId" value="<%= user_id %>">
</form>

</div>
  
  
  
  <script type="text/javascript">
            $j(document).ready(function() {
                   
                    var flag = <%= flag %>;
        
                    if(flag == 'resultEntry'){
                    	$j('#message').html("Result entered successfully. Do you want to print");
                    	//alert("sdfsfs "+$j('#message').val();
                    }else if(flag == 'validation'){
                    	$j('#message').html("Result validated successfully. Do you want to print");
                    }                
                
            });
  </script>              

 

<script type="text/javascript" language="javascript">
            function backToWaitingList() {
            	if(<%= flag %> == 'resultEntry'){
            		
            		window.location ="${pageContext.request.contextPath}/radiology/getRadiologyWaitingData";
                }else if(<%= flag %> == 'validation'){
                	window.location ="${pageContext.request.contextPath}/radiology/getResultValidationWaitingList";
                }      	                      
               				
            }
            
            
            
 </script>           
<script type="text/javascript" language="javascript">


function printRadiology() {
<%-- 	 var flag = <%= flag %>;
     alert(<%= id %>);--%>
     $j('#flag').val(<%= flag %>);
     $j('#dtId').val(<%= id %>); 
     document.frm1.action = "${pageContext.request.contextPath}/radiology/radiologySummary";
	document.frm1.method="GET";
	document.frm1.submit(); 
	
 }

</script>
</body>
</html>