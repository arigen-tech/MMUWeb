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
                            <title>OPD Previous Vital Record</title>
                 
	                 
                    
                    
                   
                    </head>
                    <body class="bg-white">
                    
                    
   <%
	Map<String, Object> map = new HashMap<String, Object>();
	if (request.getAttribute("map") != null) {
		map = (Map) request.getAttribute("map");
	}
	Map<String, Object> utilMap = new HashMap<String, Object>();
	utilMap = (Map) ProjectUtils.getCurrentDateAndTime();
	String date = (String) utilMap.get("currentDate");
	String time = (String) utilMap.get("currentTime");

	String userName = "";
	if (session.getAttribute("userName") != null) {
		userName = (String) session.getAttribute("userName");
	}
	String message = "";
	if (map.get("message") != null) {
		message = (String) map.get("message");
		//out.println(message);
	}
	System.out.println("message==in jsp ===" + message);
	
	String patientId="";
	patientId= request.getParameter("patientId"); 
	
	
%>

 <!-- Begin page -->
    <div id="wrapper" ">
<div class="container-fluid m-t-10">
<div class="">


	<div class="Clear"></div>


	<div class="">
	<div class="">
	
	<form name="Previous Audit History" method="post" action="">

		
		<div class="clear"></div>
		<div class="paddingTop15"></div>
		<div id="testDiv">
		<div style="float: left">

									<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<!-- <tr>
											<td class="SearchStatusForUnitAdminNewVital" style="font-size: 15px;"
												align="left"></td>
											<td>
											</td>
										</tr> -->
									</table>
								</div>
								<div style="float: right">
									<div id="resultnavigationNewVital"></div>
								</div>
						
						<div class="table-responsive">
			<table class="table table-hover table-bordered">
                                        <thead class="bg-primary" style="color:#fff;">
                                            <tr>
                                            <th>OPD Date</th>
											<th>Audit Date</th>
											<th>Audit By</th>
											<th>Exception/No Exception</th>
											<th>Auditor Final Remarks</th>
										
										</tr>
                                        </thead>
                                         
                                        <tbody id="tblListofOpdPreviousVital">

                                        </tbody>
                                    </table>
		</div>
</div>


		<div class="Clear"></div>
		<div class="division"></div>
            <button type="button" onclick="closeModal()" class="button btn btn-primary btn-right-all">Close</button>
		
		<div class="Clear"></div>
		<div class="division"></div>
		<div class="bottom">
		                            
		 

		</div>
	</form>
</div>

</div>
</div>

</div>
</div>
 <script type="text/javascript" language="javascript">

var nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{
			getOpdPreConsultationList('ALL','SearchStatusForUnitAdminNewVital');
			
		});
		

function closeWindow()
{
 //if(getTemplateDetail()){
  window.close();
 //}
}

 

 function getOpdPreConsultationList(MODE,className) { 	
 	
 	var cmdId=0; 	

 	 if(MODE == 'ALL')
 		{
 			var data = {"pageNo":nPageNo};
 			
 		}
 	else
 		{
 			var data = {"pageNo":nPageNo};
 		} 
 	 
 	 var patient_name = $j('#patient_name').val();
 	 var service_no = $j('#service_no').val();
 	if (patient_name === undefined) {
 		patient_name = "";
 	}
	if (service_no == undefined) {
		service_no = "";
 	}
 	<%-- var data = {"hospitalId": <%= hospitalID %>,"pageNo":"1"}; --%>
 	<%-- var data = {"hospitalId": <%= hospitalID %>, "serviceNo":service_no,"patient_name":patient_name,"pageNo":nPageNo}; --%>
 	 	var data = {"pageNo":nPageNo,"patientId": <%=patientId%>}; 
        console.log("data"+data); 
 	//var url = "getObesityWaitingList";
 		
 	var bClickable = false;
 	var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";
	 var url= window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/getOpdPreviousAuditHistory";
 	//var url = "getOpdPreviousVital";
 	//GetJsonData('tblListofOpdPreviousVital',data,url,bClickable);
 	GetJsonDataForCommon('tblListofOpdPreviousVital',data,url,bClickable,"waitingImgId",className,'tblListofOpdPreviousVital','resultnavigationNewVital');
 }
 
 function makeTableCommon(jsonData,flagCheck)
 {
 	 if(flagCheck=="tblListofOpdPreviousVital"){
 		makeGridForPreviousVital(jsonData);
 	 }
 }
 
 function makeGridForPreviousVital(jsonData)
 {	
 	var htmlTable = "";	
 	var data = jsonData.count;
 	
 	var dataList = jsonData.data;
 	var flag=0;	
 	for(i=0;i<dataList.length;i++)
 		{	 		
 			if(dataList[i].visitdate!=""||dataList[i].auditDate!=""||dataList[i].auditBy!=""||dataList[i].remarks!="")
 			{
 				flag=1;	
 			htmlTable = htmlTable+"<tr >";	
 			htmlTable = htmlTable +"<td style='width: 100px; '>"+dataList[i].visistDate+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].auditDate+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].auditBy+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].exception+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].remarks+"</td>";
 			htmlTable = htmlTable+"</tr>";
 			}
 			
 			
 		}
 	if(dataList.length == 0 && flag==0)
 		{
 		htmlTable = htmlTable+"<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";
 		   //alert('No Record Found');
 		}			
 	
 	//alert("tblListOfCommand ::" +htmlTable)
 	$j("#tblListofOpdPreviousVital").html(htmlTable);	
 	
 	
 }
 
 function executeClickEvent(Id)
 {
	 //alert(Id)
	 //window.location="getOpdPatientModel?visitId="+Id+"";
	
 }
 
 function showResultPage(pageNo) 	
 {
 	
 	nPageNo = pageNo;	
 	getOpdPreConsultationList('FILTER');
 	
 }
 
 
</script>

</body>
</html>
