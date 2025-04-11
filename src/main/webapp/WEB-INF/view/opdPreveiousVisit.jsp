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
                            <title>OPD Main</title>
                 
	                 
                    
                    
                   
                    </head>
                    <body style="background:#ffff;">
                    
<%
String patientId="";
patientId= request.getParameter("patientId"); 
%>                    
   

<div class="">


	 
	<div class="Clear"></div>


	
	<form name="PreviousVisitRecord" method="post" action="">
       <div div class="paddingTop15"></div>
	 
       
		<input type="hidden" name="visit_id" id="visit_id" value="">
                 <div class="">
					<div class="control-group">
						
					<div class='divErrorMsg form-group row' id='errordiv' ></div>
					<div class="form-group row" id="messageForCurrentMedication"></div>

						
						
						<div style="float: left">

									<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatusForUnitAdminNew" style="font-size: 15px;"
												align="left"></td>
											<td>
											</td>
										</tr>
									</table>
								</div>
								<div style="float: right">
									<div id="resultnavigationNew"></div>
								</div>
						
						<div class="table-responsive">
						
							<table class="table table-hover table-bordered">
                                        <thead class="bg-primary" style="color:#fff;">
                                            <tr>
                                             <th style=display:none; >VisitId</th>
											<th style="display: none;">PatientId</th>
											<th>Visit Date</th>
											<th>MMU Name </th>
											<th>Department</th>
											<th>Doctor</th>
											<th>Patient signs and symptoms</th>
											<th>Diagnosis</th>
											<th>Action</th>
											
											<!-- <th>Action</th>
											<th>Action</th> -->
										</tr>
                                        </thead>
                                         
                                        <tbody id="tblListofOpdPrevious">
                                        </tbody>
                                    </table>
                                    
						</div>

					</div>
				</div>
                                    
                                    
		
</div>


		

			

		

		            <div class="clearfix"></div>								
								         <br>
										<div class="">		 
										 <div class="col-md-12">
															<div class="btn-left-all">																 
															</div> 
															<div class="btn-right-all">
															 <button type="button" onclick="closeModal()" class="button btn btn-primary btn-right-all">Close</button>
																
															
															</div> 
													   </div> 
										</div>
                    
		 
		

			<%-- <label>Changed By</label> 
			<label class="value"></label>
			 <label>Changed	Date</label> 
				<label class="value"><%=date%></label>
				 <label>Changed	Time</label>
				  <label class="value"><%=time%></label>
				   <input type="hidden"	name=" " value=" " />
				    <input type="hidden" name=" " value=" " /> 
				    <input	type="hidden" name=" " value=" " />
			<div class="Clear"></div>
			<div id="edited"></div> --%>

		</div>
	</form>

</div>
 <script type="text/javascript" language="javascript">

var nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{
			getOpdPreConsultationList('ALL','SearchStatusForUnitAdminNew');
			
		});
		
		
 function searchOpdPreConsultationList()
{
	
	var nPageNo=1;	
	 var pathname = window.location.pathname;
     var accessGroup = "MMUWeb";
	 var url= window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/getOpdPreviousVisitRecord";

	//var url = "getOpdPreviousVisitRecord";
	var service_no = $j('#service_no').val();
	var patient_name = $j('#patient_name').val();
	if((service_no == undefined || service_no == '') && (patient_name == undefined || patient_name == '')){	
		alert("Atlease one option must be entered");
		return;
	}
	var data = {"pageNo":nPageNo,"patientId": <%=patientId%>};
	alert(data)
	var bClickable = true;
	
	GetJsonData('tblListofOpdPrevious',data,url,bClickable);
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
	if (service_no === undefined) {
		service_no = "";
 	}
 	<%-- var data = {"hospitalId": <%= hospitalID %>,"pageNo":"1"}; --%>
 	<%-- var data = {"hospitalId": <%= hospitalID %>, "serviceNo":service_no,"patient_name":patient_name,"pageNo":nPageNo}; --%>
 	 	var data = {"pageNo":nPageNo,"patientId": <%=patientId%>}; 
        console.log("data"+data); 
 
 	var bClickable = true;
 	var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";
	var url= window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/getOpdPreviousVisitRecord";
 	//var url = "getOpdPreviousVisitRecord";
 	//GetJsonData('tblListofOpdPrevious',data,url,bClickable);
 	GetJsonDataForCommon('tblListofOpdPrevious',data,url,bClickable,"waitingImgId",className,'tblListofOpdPrevious','resultnavigationNew');

 }
 
 function closeWindow()
 {
  //if(getTemplateDetail()){
   window.close();
  //}
 }
 
 function makeTableCommon(jsonData,flagCheck)
 {
 	 if(flagCheck=="tblListofOpdPrevious"){
 		makeGridForPreviousVisit(jsonData);
 	 }
 }
 
 function makeGridForPreviousVisit(jsonData)
 {	
 	var htmlTable = "";	
 	var data = jsonData.count;
 	
 	var dataList = jsonData.data;
 		
 	for(i=0;i<dataList.length;i++)
 		{	 	
 				
 			htmlTable = htmlTable+"<tr id='"+dataList[i].patientId+"' >";	
 			htmlTable = htmlTable +"<td style='width: 100px; '>"+dataList[i].visistDate+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px; '>"+dataList[i].mmuName+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].departmentName+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].doctorName+"</td>";
 			htmlTable = htmlTable +"<td>"+dataList[i].patientSymptoms+"</td>";
 			htmlTable = htmlTable +"<td>"+dataList[i].icdDiagnosis+"</td>";
 				
 			htmlTable= htmlTable + "<td><button id ='caseSheetReport' type='button'  class='btn btn-primary' onclick='printToken("+dataList[i].visitId+");'>OPD Slip</button></td>";
 			/* htmlTable = htmlTable +"<td><input type='submit' value='Release' id='released' />" +"</td>";
 			htmlTable = htmlTable +"<td><input type='submit' value='Close' id='closed' />" +"</td>"; */
 			
 			htmlTable = htmlTable+"</tr>";
 			
 		}
 	if(dataList.length == 0)
 		{
 		htmlTable = htmlTable+"<tr ><td colspan='6'><h6>No Record Found</h6></td></tr>";
 		   //alert('No Record Found');
 		}			
 	
 	//alert("tblListOfCommand ::" +htmlTable)
 	$j("#tblListofOpdPrevious").html(htmlTable);	
 	
 	
 }
 
 function executeClickEvent(Id)
 {
	 //alert(Id)
	// window.location="getOpdPatientModel?visitId="+Id+"";
	
 }
 
 function showResultPage(pageNo) 	
 {
 	
 	nPageNo = pageNo;	
 	getOpdPreConsultationList('FILTER');
 	
 }
 
 function printToken(visitId)
 {
	 document.getElementById('visit_id').value=visitId;
	 var visitIdValue=$('#visit_id').val();
		//document.PreviousVisitRecord.action="${pageContext.request.contextPath}/report/printCaseSheet";
		//document.PreviousVisitRecord.method="POST";
		//document.PreviousVisitRecord.submit(); 
	 var url="${pageContext.request.contextPath}/report/printCaseSheet?visit_id="+visitIdValue;
	 $('#urlForReport').val(url);
	 openPdfModel(url); 
 }
 
 
</script>

</body>
</html>
