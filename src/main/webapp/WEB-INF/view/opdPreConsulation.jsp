<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
     <%@include file="..//view/leftMenu.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>



</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>


<%   
String hospitalId = "1";
if (session.getAttribute("hospital_id") !=null)
{
 hospitalId = session.getAttribute("hospital_id")+"";
}
String userId="1";
if (session.getAttribute("user_id") !=null)
{
	userId = session.getAttribute("user_id")+"";
}

String hospitalFlag="O";
if (session.getAttribute("hospitalFlag") != null) {
	hospitalFlag = session.getAttribute("hospitalFlag") + "";
}
%>
<%@include file="..//view/commonJavaScript.jsp" %>
</head>
 
<script type="text/javascript" language="javascript">

var nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{
			getOpdPreConsultationList('ALL');
			
		});
		
		
 function search()
{
	
	var nPageNo=1;	
	
	var service_no = $j('#service_no').val();
	var patient_name = $j('#patient_name').val();
	if((service_no == undefined || service_no == '') && (patient_name == undefined || patient_name == '')){	
		alert("At least one option must be entered");
		return;
	}
	<%-- var data = {"hospitalId": <%= hospitalId %>,"employeeId": <%=userId%>,"opdPre":"opdPre", "serviceNo":service_no,"patientName":patient_name,"pageNo":"1"};
	var bClickable = true;
	var url = "getPreConsPatientWatingWeb";
	GetJsonData('tblListofOpdP',data,url,bClickable); --%>
	getOpdPreConsultationList('FILTER');
	ResetForm();
} 

 function getOpdPreConsultationList(MODE) { 	
 	
	     var cmdId=0;
	     var service_no = $j('#service_no').val();
	 	var patient_name = $j('#patient_name').val();
	 	var opdType = $j('#opdType').val();
		 if(MODE == 'ALL'){
			 var data = {"hospitalId": <%=hospitalId%>,"employeeId": <%=userId%>,"pageNo":nPageNo,"opdPre":"opdPre","serviceNo":"","patientName":"","opdType":opdType};				
			}
		else if(service_no!=""||patient_name!="")
			{
			nPageNo = 1;
			var data = {"hospitalId": <%=hospitalId%>,"employeeId": <%=userId%>,"pageNo":nPageNo,"opdPre":"opdPre","serviceNo":service_no,"patientName":patient_name,"opdType":opdType};
			} 
		else
		{
			var data = {"hospitalId": <%=hospitalId%>,"employeeId": <%=userId%>,"pageNo":nPageNo,"opdPre":"opdPre","serviceNo":service_no,"patientName":patient_name,"opdType":opdType};
		}	
		 
		var url = "getPreConsPatientWatingWeb";		
		var bClickable = true;
		GetOpdJsonData('tblListofOpdP',data,url,bClickable);
 }
 
 function makeTable(jsonData)
 {	
 	var htmlTable = "";	
 	var data1 = jsonData.count;
 	
 	var dataList = jsonData.data;
 	
 	if(dataList!=undefined && dataList!="" && dataList.length >= 0)	
 	{	
 	for(i=0;i<dataList.length;i++)
 		{	 		
 		    if(dataList[i].priority==1){	
  			htmlTable = htmlTable+"<tr style='background-color: #ef9999' id='"+dataList[i].visitId+"' >";	
  		   }
  		  else if(dataList[i].priority==2){
  			 htmlTable = htmlTable+"<tr style='background-color: #f4dc92' id='"+dataList[i].visitId+"' >";	  
  		  }
  		 else
 			{
  			 htmlTable = htmlTable+"<tr style='background-color: #84e08f' id='"+dataList[i].visitId+"' >";
 			}			
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].tokenNo+"</td>";
 			
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].serviceNo+"</td>";
 			
 			
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].patientName+"</td>";
 			
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].employeeName+"</td>";
 			
 			
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].gender+"</td>";
 			
 			
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].ageFull+"</td>";
 			
 			
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].relation+"</td>";
 			
 			
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].doctorname+"</td>";
 			
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].departmentName+"</td>";
 			if(dataList[i].priority==1){	
 				htmlTable = htmlTable +"<td style='width: 100px;'>"+'<label>High</label>'+"</td>";
	 			}
	 			else if(dataList[i].priority==2){
	 				htmlTable = htmlTable +"<td style='width: 100px;'>"+'<label>Medium</label>'+"</td>";
	 			}
	 			else
	 			{
	 				htmlTable = htmlTable +"<td style='width: 100px;'>"+'<label>Low</label>'+"</td>";
	 			}
 			htmlTable = htmlTable+"</tr>";
 		}	
 		}
 	if(jsonData.status == 0)
 		{
 		htmlTable = htmlTable+"<tr ><td colspan='10'><h6>No Record Found</h6></td></tr>";
 		   //alert('No Record Found');
 		}			
 	
 	//alert("tblListOfCommand ::" +htmlTable)
 	$j("#tblListofOpdP").html(htmlTable);	
 	
 	
 }
 
 
 function executeClickEvent(Id)
 {
	 var opdType="opd";
	 localStorage.opdType=opdType;
	 window.location="addVitalRecords?visitId="+Id+"";
	 
 }
 
 function showResultPage(pageNo) 	
 {
 	
 	nPageNo = pageNo;	
 	getOpdPreConsultationList('FILTER');
 	
 }
 
 function ResetForm()
 {	
 	 $j('#service_no').val('');
 	 $j('#patient_name').val('');
 }
 
 
 function showAll()
 {
	 ResetForm();
 	nPageNo = 1;	
 	getOpdPreConsultationList('ALL');
 	
 }
 
</script>
 <body>
  <!-- Begin page -->
    <div id="wrapper">
 
 <div class="content-page">
                                <!-- Start content -->
 <div class="">
  <div class="container-fluid">
  
	 <input type="hidden" id="opdType" name="opdType" value=<%=hospitalFlag%>>
	
	 
	  <div class="internal_Htext">OPD Pre-Consultation Waiting List</div>
	 
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">

                                     <div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Service No.</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="service_no" placeholder="">
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Patient Name</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="patient_name" placeholder="">
												</div>
											</div>
										</div>
										<div class="col-md-1">
											<div class="form-group row">
												
												<div class="col-sm-10">
													<button type="button" class="btn btn-primary" onclick="search()">Search</button>
												</div>
											</div>
										</div>
										
										
										<div class="col-md-3">
										<div class="btn-right-all">
												<button type="button" class="btn  btn-primary "
													onclick="showAll('ALL');">Show All</button>
												</div>
											 
										</div>
                                      
										
										<div class="col-md-3">
											
										</div>
                                      

                                    </div>

                                     <div classs="row">
                                     
                                     <div class="col-md-4">
                                     </div>
                                     
                                     </div>

								<div style="float: left">

									<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatus" style="font-size: 15px;"
												align="left">Search Results</td>
											<td>
												<!-- <div id=resultnavigation></div> -->
											</td>
										</tr>
									</table>
								</div>
								<div style="float: right">
									<div id="resultnavigation"></div>
								</div>


								<table class="table table-hover table-bordered">
                                        <thead class="bg-primary" style="color:#fff;">
                                            <tr>
                                                <th id="th1">Token No.</th>
                                                <th id="th2">Service No. </th>
                                                <th id="th3"> Patient Name</th>
                                                <th id="th4">Emp Name</th>
												 <th id="th5">Gender</th> 
												 <th id="th6">Age</th>
												 <th id="th7">Relation</th>
												  <th id="th9">Doctor</th>
												 <th id="th8">Department</th>
												 <th id="th10">Priority</th>
                                            </tr>
                                        </thead>
                                         
                                        <tbody id="tblListofOpdP">

                                        </tbody>
                                    </table>
                                    
                                    <div class="tableLegend">
                                    	<div class="tbLegendName">
                                    		<div class="colorBox high"></div>
                                    		<label>High</span>
                                    	</div>
                                    	<div class="tbLegendName">
                                    		<div class="colorBox medium"></div>
                                    		<label>Medium</span>
                                    	</div>
                                    	<div class="tbLegendName">
                                    		<div class="colorBox low"></div>
                                    		<label>Low</span>
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

</div>

</body>
</html>