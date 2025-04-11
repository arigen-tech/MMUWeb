<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@include file="..//view/leftMenu.jsp" %>
<%@include file="..//view/commonJavaScript.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
</head>
 
<script type="text/javascript" language="javascript">

var nPageNo=1;
var $j = jQuery.noConflict();
$j(document).ready(function()
		{
		getFutureAppointmentWaitingList('ALL');
			
		});
		
		
 function search()
{
	
} 

 function getFutureAppointmentWaitingList(MODE) { 	
	
		 if(MODE == 'ALL'){
			 var data = {"hospitalId": <%=session.getAttribute("hospital_id")%>,"PN":nPageNo};				
			}
		else
			{
			var data = {"hospitalId": <%=session.getAttribute("hospital_id")%>,"PN":nPageNo};	
			} 
		 
		var url = "getFutureAppointmentWaitingList";		
		var bClickable = false;
		GetJsonData('appointmentWatingList',data,url,bClickable);
 }
 
 function makeTable(jsonData)
 {
	  	var htmlTable = "";
	    var data = jsonData.count;
	    var pageSize = 5;
	    var dataList = jsonData.waitingListOfFutureAppointment;
	    for(item=0;item<dataList.length;item++){
	    	//var count = parseInt(item)+1;
	    	if(dataList[item].visitStatus=='n' || dataList[item].visitStatus=='N'){
	    		if(dataList[item].cancelStatus=='f' || dataList[item].cancelStatus=='F'){
	    			status="Cancelled (Doctor not available)"
	    		}else{
	    			 continue;
	    			//status="Cancelled"
	    		}
	    	}else{
	    		status="waiting";
	    	}
	    	htmlTable = htmlTable + "<tr id='" + dataList[item].visitId + "'>";
	    	
	    	//htmlTable = htmlTable + "<td style='width: 150px;'>" + count + "</td>";
	    	
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].tokenNo + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].patientName + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].serviceNo + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].empName + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].rank + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].relation + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].department + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].visitDate + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].visitTime + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + dataList[item].appointmentType + "</td>";
	    	htmlTable = htmlTable + "<td style='width: 150px;'>" + status + "</td>";
	    }
	    $j("#appointmentWatingList").html(htmlTable);
 }
 
 
 function executeClickEvent(Id)
 {
	
 }
 
 function showResultPage(pageNo)
 {
 	
 	nPageNo = pageNo;	
 	getFutureAppointmentWaitingList('FILTER');
 	
 }
 
 
</script>
 <body>
  <!-- Begin page -->
    <div id="wrapper">
 
 <div class="content-page">
                                <!-- Start content -->
 <div class="">
  <div class="container-fluid">
	 
	  <div class="internal_Htext">Future Appointment List</div>
	 
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">

                                     <div class="row" id="rowDiv" style="display:none">
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Department</label>
												<div class="col-sm-7">
													<select class="form-control">
														<option>Select</option>
													</select>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Appointment Date</label>
												<div class="col-sm-7">
												<div class="dateHolder">
													<input type="text" class="calDate datePickerInput form-control" id="ToDate"
														 name="ToDate" placeholder="DD/MM/YYYY" 
														 onkeyup="mask(this.value,this,'2,5','/')" onblur="validateExpDate(this,'ToDate');" maxlength="10"></div>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Appointment Type</label>
												<div class="col-sm-7">
													<select class="form-control">
														<option>Select</option>
													</select>
												</div>
											</div>
										</div>
                                    </div>
								<div style="float: left">

									<table class="tblSearchActions" cellspacing="0" cellpadding="0"
										border="0">
										<tr>
											<td class="SearchStatus" style="font-size: 15px;"
												align="left">Search Results</td>
											<td>
												
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
                                                <!-- <th id="th1">Sr. No.</th> -->
                                                <th id="th2">Token No.</th>
                                                <th id="th3">Patient Name </th>
                                                <th id="th4">Service No. </th>
                                                <th id="th5">Emp Name </th>
                                                <th id="th6">Rank </th>
                                                <th id="th7">Relation</th>
                                                <th id="th8">Department</th>
                                                <th id="th9">Visit Date</th>
                                                <th id="th9">Visit Time</th>
                                                <th id="th10">AppointmentType</th>
                                                <th id="th11">Status</th>
                                                <!-- <th id="th11">Action</th> -->
                                            </tr>
                                        </thead>
                                        <tbody id="appointmentWatingList">
                                        </tbody>
                                    </table>
						
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