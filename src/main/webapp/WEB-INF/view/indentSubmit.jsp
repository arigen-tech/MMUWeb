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
                    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opd.js"></script>
                   	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opdpatientrecall.js"></script>
                    </head>

                    <%
	int i = 1;
    String id = request.getParameter("id");
    String issueMId = request.getParameter("issueMId");
    String issueNo = request.getParameter("issueNo");
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
	 
	  <div class="internal_Htext">Indent Issue Reports </div>	  

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                <p align="Left" id="message" style="color: green; font-weight: bold;">Indent Issued Successfully. Do You want to print</p>  
                                <div id="opd_submit">  
                                     <div class="row">
										<div class="col-12 text-right"> 
												<!-- <button class=" btn btn-primary opd_submit_btn" onclick="printReport('P');">Indent Slip</button> -->  
												<button type="button" id="printReportButton" class="btn btn-primary" 
													 onclick="makeUrl()">Indent Issue Slip</button>
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
												<input type="hidden" id="indent_id" name="indent_id"
													value=""/>
												<input type="hidden" id="issue_no" name="issue_no"
													value=""/>
												<input type="hidden" id="issue_m_id" name="issue_m_id"
													value=""/>
											</div>
										</div>


  
</form>

</div>
  
  
  
  <script type="text/javascript">
            $(document).ready(function() {
                    $('#indent_id').val(<%= id %>);
                    $('#issue_no').val(<%= issueNo %>);
                    $('#issue_m_id').val(<%= issueMId %>);
                    
            });
  </script>              

 

<script type="text/javascript" language="javascript">
            function backListReport(flag) {
            				
                      window.location.href ="indentIssueWaitingJSP";
               				
            }
            
            
            
 </script>           
<script type="text/javascript" language="javascript">

function executeClickEvent()
{
	 //alert(Id)
	/*  var visitIdValue=$('#indent_id').val();
	 window.location="getCaseSheet?visitId="+visitIdValue+""; */
	
}

function printReport(flag) {
	 var pId = $('#indent_id').val();
	//alert("flag : "+flag)
	if(flag=='P')
	document.frm.action="${pageContext.request.contextPath}/report/printIndentIssueReport?id="+pId+"";
	if(flag=='N')
	document.frm.action="${pageContext.request.contextPath}/report/printInvestigationSlip";
	
	document.frm.method="POST";
	document.frm.submit(); 
	
 }

function makeUrl(){

	var pId = $('#indent_id').val();
	var issueNo = $('#issue_no').val();
	var issueMId = $('#issue_m_id').val();
	var url="${pageContext.request.contextPath}/report/printIndentIssueReport?issueNo="+issueNo+"&id="+issueMId;
	openPdfModel(url);
}
</script>
</body>
</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>