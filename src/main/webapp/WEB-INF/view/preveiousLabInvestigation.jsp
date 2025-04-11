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
                               
<%--                    
                       
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
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/hms.js"></script>      --%>           
                            <title>OPD Main</title>
                 
	                 
                    
                    
                   
                    </head>
                    <body style="background:#ffff;">
                    
                    
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

<div class="popupbg">
	  <div class="row">
                        <div class="col-12">
         
	<div class="Clear"></div>


		<div class='divErrorMsg form-group row' id='errordiv' ></div>
					<div class="form-group row" id="messageForCurrentMedication"></div>

						
						
						<div style="float: left">

									<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatusForUnitAdminNewLab" style="font-size: 15px;"
												align="left"></td>
											<td>
											</td>
										</tr>
									</table>
								</div>
								<div style="float: right">
									<div id="resultnavigationNewLab"></div>
								</div>
						
						<div class="table-responsive">
		 
			<table class="table table-hover table-bordered">
                                        <thead class="bg-primary" style="color:#fff;">
                                            <tr>
											<th style="display: none;">PatientId</th>
											<th>Date</th>
											<th>Investigation Name</th>
											<th>Result</th>
											<th>UOM</th>
											<th>Range</th>
											<th>Entered By</th>
											<th>Validated By</th>
											
											
											<!-- <th>Action</th>
											<th>Action</th> -->
										</tr>
                                        </thead>
                                         
                                        <tbody id="tblListofOpdPreviousPopUpLab">

                                        </tbody>
                                    </table>
		</div>



		

			

		

		            <div class="clearfix"></div>
										<div class="">		 
										 <div class="col-md-12 text-right">
															
															  <button type="button" onclick="closeModal()" class="button btn btn-primary ">Close</button>
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


</div>
 <script type="text/javascript" language="javascript">

var nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{
	      getOpdPreConsultationListLab('ALL','SearchStatusForUnitAdminNewLab');
			
		});
		
		
 
 function getOpdPreConsultationListLab(MODE,className) { 	
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
 	 	var data = {"patientId": <%=patientId%>,"pageNo":nPageNo,"mainChargeCode":"2"}; 
        console.log("data"+data); 
 
 	var bClickable=true;
 	var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";
	var url= window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/opd/getPreviousLabRecord";
 	//var url = "getPreviousLabRecord";
 	//GetJsonData('tblListofOpdPreviousLab',data,url,bClickable);
 	GetJsonDataForCommon('tblListofOpdPreviousPopUpLab',data,url,bClickable,"waitingImgId",className,'tblListofOpdPreviousPopUpLab','resultnavigationNewLab');
 }
 
 function showResultPage(pageNo) 	
 {
 	
 	nPageNo = pageNo;	
 	getOpdPreConsultationListLab('FILTER');
 	
 }
 
 function closeWindow()
 {
  //if(getTemplateDetail()){
   window.close();
  //}
 }
 
 function makeTableCommon(jsonData,flagCheck)
 {
 	 if(flagCheck=="tblListofOpdPreviousPopUpLab"){
 		makeGridForPreviousLab(jsonData);
 	 }
 }
 
 function makeGridForPreviousLab(jsonData)
 {	
 	var htmlTable = "";	
 	var data = jsonData.count;
 	
 	var dataList = jsonData.data;
 		
 	for(i=0;i<dataList.length;i++)
 		{	
 		    var orderDate=dataList[i].orderDate;
 		    var investigationName=dataList[i].investigationName;
 		   var subInvestigationName=dataList[i].subInvestigationName;
 		   if(subInvestigationName!="" && subInvestigationName!=null && subInvestigationName!=undefined){
 			  investigationName+="("+subInvestigationName+")"
 		   } 
 		    var result=dataList[i].result;
 		    var uomName=dataList[i].uomName;
 		    var range=dataList[i].range;
 		    var investigationId=dataList[i].investigationId;
 		    var mainChargeCode=dataList[i].mainChargeCode;
 		    var enterBy=dataList[i].enterBy;
 		    var validateBy=dataList[i].verifiedBy;
 		    var ridcDocument=dataList[i].ridcId;
 			if(mainChargeCode==2)
 			{	
 			htmlTable = htmlTable+"<tr id='"+dataList[i].patientId+"' >";	
 			htmlTable = htmlTable +"<td style='width: 100px; '>"+orderDate+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+investigationName+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+result+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+uomName+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+range+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+enterBy+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+validateBy+"</td>";
 			
 			//htmlTable= htmlTable + "<td><button id ='printBtn' type='button'  class='btn btn-primary' onclick='printToken("+dataList[i].visitId+");'>Case Sheet</button></td>";
 			/* htmlTable = htmlTable +"<td><input type='submit' value='Release' id='released' />" +"</td>";
 			htmlTable = htmlTable +"<td><input type='submit' value='Close' id='closed' />" +"</td>"; */
 			
 			htmlTable = htmlTable+"</tr>";
 		    }
 			
 		}
 	if(dataList.length == 0)
 		{
 		htmlTable = htmlTable+"<tr ><td colspan='8'><h6>No Record Found</h6></td></tr>";
 		   //alert('No Record Found');
 		}			
 	
 	//alert("tblListOfCommand ::" +htmlTable)
 	$j("#tblListofOpdPreviousPopUpLab").html(htmlTable);	
 	
 	
 }
 
 
 function viewDocument(ridcId)
 {
	
	 var pathname = window.location.pathname;
 	var accessGroup = "MMUWeb";

 	var url = window.location.protocol + "//"
 			+ window.location.host + "/" + accessGroup
 			+ "/opd/getRidcDocmentInfo";

 	//var data = $('employeeId').val();
    // alert("radioValue" +radioValue);
 	$.ajax({
 		type : "POST",
 		contentType : "application/json",
 		url : url,
 		data : JSON.stringify({
 			'ridcId' : ridcId,
 			
 		}),
 		dataType : 'json',
 		timeout : 100000,
 		
 		success : function(res)
 		
 		{
 			data = res.ridcInfoList;
				
 			for(var i=0;i<data.length;i++){
					
					var ridcInfo= data[i];
					
					var documentId=ridcInfo[0];
					var documentName = ridcInfo[1];
					var documentInfo = ridcInfo[2];
					
					var urlInfo = window.location.protocol + "//"
     			+ window.location.host + "/" + accessGroup
     			+ "/digifileupload/getStatus";
					$.ajax({
						type : "POST",
						contentType : "application/json",
						url : urlInfo,
						data : JSON.stringify({
		        			'docId' : documentId,
		        			'docName':documentName,
		        			'dFormat':documentInfo
		        			
		        		}),
						dataType : "json",
						cache : false,
						
						success : function(res) {
							
							if(res.status=="RELEASED"){
								//window.location = "../downloadDocumentFromRIDC?dId="+documentId+"&"+"docName="+documentName+"&"+"dFormat="+documentInfo+"";
								//window.open( "../downloadDocumentFromRIDC?dId="+documentId+"&"+"docName="+documentName+"&"+"dFormat="+documentInfo+"","_blank");
								
							}
							if(res.status=="EXPIRED"){
								alert("Document Expired-this document is not longer available");
								
							}
							
						},
						error : function(res) {
							alert("An error has occurred while contacting the server");
							 window.location="${pageContext.request.contextPath}/v0.1/dashboard/dashboard"; 
						}
					});
					
				   	
 			}

 		
            },
            error: function (jqXHR, exception) {
                var msg = '';
                if (jqXHR.status == 0) {
                    msg = 'Not connect.\n Verify Network.';
                } else if (jqXHR.status == 404) {
                    msg = 'Requested page not found. [404]';
                } else if (jqXHR.status == 500) {
                    msg = 'Internal Server Error [500].';
                } else if (exception === 'parsererror') {
                    msg = 'Requested JSON parse failed.';
                } else if (exception === 'timeout') {
                    msg = 'Time out error.';
                } else if (exception === 'abort') {
                    msg = 'Ajax request aborted.';
                } else {
                    msg = 'Uncaught Error.\n' + jqXHR.responseText;
                }
                alert(msg);
            }
 	});
 }

 
 
 
</script>

</body>
</html>
