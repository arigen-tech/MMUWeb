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
<title>Masters</title>

<%@include file="..//view/commonJavaScript.jsp" %>
</head>
 
<script type="text/javascript" language="javascript">
<%			
	String hospitalId = "1";
	if (session.getAttribute("hospital_id") !=null)
	{
		hospitalId = session.getAttribute("hospital_id")+"";
		System.out.println("hospital id is "+session.getAttribute("hospital_id"));
	}
%>

var nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{
			getObesityList('ALL');
			
		});

 function getObesityList(MODE) { 	
 	
 	var cmdId=0; 	
	 var patient_name = $j('#patient_name').val();
 	 var service_no = $j('#service_no').val();
 	 var selectionOption = $j('#obesityOption').val();
 	if (patient_name === undefined) {
 		patient_name = "";
 	}
	if (service_no === undefined) {
		service_no = "";
 	} 
	if(selectionOption == undefined || selectionOption == ''){
		selectionOption = "";
	}

 	 if(MODE == 'ALL')
 		{
 		var data = {"hospitalId": <%= hospitalId %>, "service_no":"","patient_name":"", "obesityFlag":"", "pageNo":nPageNo};
 			
 		}
 	else
 		{
 		var data = {"hospitalId": <%= hospitalId %>, "service_no":service_no,"patient_name":patient_name, "obesityFlag":selectionOption, "pageNo":nPageNo};
 		} 
 	 
		
 	var bClickable = true;
 	var url = "obesityWaitingList";
 	GetJsonData('tblListofObesity',data,url,bClickable);
 }
 
 
 function makeTable(jsonData)
 {	
 	var htmlTable = "";	
 	var data = jsonData.count;
 	var pageSize = 5;
 	var dataList = jsonData.patientObesityList;
 		
 	for(i=0;i<dataList.length;i++)
 		{	 		
 			var type = '';
 			if(dataList[i].overweightFlag == 'Y'){
 				type = 'Overweight';
 			}else if(dataList[i].overweightFlag == 'N'){
 				type = 'Obesity';
 			}
 			var variation1 = dataList[i].variation;
			var variation2 = variation1.slice(0, (variation1.indexOf("."))+3);
				//variation1.toString().match(/\d+(\.\d{1,2})?/g)[0];
			//var variation2 = variation1.toFixed(2);
 			htmlTable = htmlTable+"<tr id='"+dataList[i].Id+"' >";			
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].serviceNo+"</td>";
 			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].patientName+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].age+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].gender+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].DeptName+"</td>";
 			htmlTable = htmlTable +"<td style='width: 100px;'>"+type+"</td>";
 			htmlTable = htmlTable +"<td style='width: 150px;'>"+variation2+"</td>";
 			htmlTable = htmlTable +"<td style='width: 150px; display: none'>"+dataList[i].overweightFlag+"</td>";
 			htmlTable = htmlTable+"</tr>";
 			
 		}
 	if(dataList.length == 0)
 		{
 		htmlTable = htmlTable+"<tr ><td colspan='7'><h6>No Record Found</h6></td></tr>";
 		   //alert('No Record Found');
 		}			
 	
 	//alert("tblListOfCommand ::" +htmlTable)
 	$j("#tblListofObesity").html(htmlTable);	
 	
 	
 }
 
 
 function executeClickEvent(Id, jsonData)
 {
	
	 var flag = "";
	 var dataList = jsonData.patientObesityList;
		
	 	for(i=0;i<dataList.length;i++){	 	
	 		if(Id == dataList[i].Id){
	 			flag = dataList[i].overweightFlag;
	 		}
	 	}
	 	
	 	window.location="patientObesityDetailjsp?Id="+Id+"&flag="+flag+"";
	 
 }
 
 function showResultPage(pageNo) 	
 {
 	
 	nPageNo = pageNo;	
 	getObesityList('FILTER');
 	
 }
 
 function showAll()
 {
 	ResetForm();
 	nPageNo = 1;	
 	getObesityList('ALL');
 	
 }

 function search()
 {
	 	nPageNo=1;			
		var service_no = $j('#service_no').val();
		var patient_name = $j('#patient_name').val();
		var selectionOption = $j('#obesityOption').val();
		if((service_no == undefined || service_no == '') && (patient_name == undefined || patient_name == '' && (selectionOption == undefined || selectionOption == '')) ){	
			alert("Atleast one option must be entered");
			return;
		}
		getObesityList('Filter');
		//ResetForm();
 }
 
 function ResetForm()
 {	
	 $j('#service_no').val('');
	 $j('#patient_name').val('');
	 $j("#obesityOption").val($j("#obesityOption option:first").val());

 }
 
 function newEntry(){
	 window.location = "markEmployeeAsObese";
 }
</script>
 <body>
  <!-- Begin page -->
    <div id="wrapper">
 <div class="content-page">
                                <!-- Start content -->
 <div class="">
  <div class="container-fluid">
	 
	  <div class="internal_Htext">Obesity / Overweight Waiting List</div>
	 
                    <!-- end row -->

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">

                                     <div class="row">
										<div class="col-md-3">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Service No.</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="service_no" placeholder="">
												</div>
											</div>
										</div>
										<div class="col-md-3">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Patient Name</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="patient_name" placeholder="">
												</div>
											</div>
										</div>
										<div class="col-md-2">
											<div class="form-group row">
												<label class="col-sm-4 col-form-label">Type</label>
												<div class="col-sm-8">
													<Select class="form-control" id="obesityOption">
														<option value="">Select</option>
														<option value="1">Obesity</option>
														<option value="2">Overweight</option>
													</Select>
												</div>
											</div>
										</div>
										<div class="col-md-1">
											<div class="form-group row">
												
												<div class="col-sm-10">
													<button type="button" class="btn btn-primary  obesityWait-search" onclick="search()">Search</button>
												</div>
											</div>
										</div>
										
										<div class="col-md-3">
											<div class="form-group row">
												<div class="col-sm-12 ">
												
												<div class="btn-right-all">
														<button type="button" class="btn  btn-primary "
													onclick="showAll('ALL');">Show All</button>
														
												
													<button type="button" class="btn btn-primary" onclick="newEntry()">New Entry</button>
													</div>
												</div>
											</div>
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


								<table class="table table-hover table-striped table-bordered">
                                        <thead class="bg-primary" style="color:#fff;">
                                            <tr>
                                                <th id="th1">Service No.</th>
                                                <th id="th2">Patient Name </th>
                                                <th id="th3"> Age</th>
                                                <th id="th4">Gender</th>
												<th id="th5">Department/Doctor</th> 
												<th id="th6">Type</th> 
												<th id="th7">Variation in weight (in %)</th>
                                            </tr>
                                        </thead>
                                         
                                        <tbody id="tblListofObesity">

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