<%@page import="java.util.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
     <%@include file="..//view/leftMenu.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Admission Discharge Register</title>
<%@include file="..//view/commonJavaScript.jsp"%>
</head>
<script type="text/javascript" language="javascript">
<%			
	String hospitalId = "1";
	if (session.getAttribute("hospital_id") !=null)
	{
		hospitalId = session.getAttribute("hospital_id")+"";
	}
%>

var nPageNo=1;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{
	GetAdmissionDischargeRegister('ALL');
			
		});

 function GetAdmissionDischargeRegister(MODE) { 	
 	var cmdId=0; 
 	 var from_date = $j('#from_date').val();
 	 var to_date = $j('#to_date').val();
 	 var service_no = $j('#service_no').val();
 	 
 	if (from_date === undefined) {
 		from_date = "";
 	}
	if (to_date === undefined) {
		to_date = "";
 	}
	if(service_no == undefined){
		service_no = "";
	}
	
 	 if(MODE == 'ALL')
 		{
 		var data = {"hospital_id": <%= hospitalId %>, "from_date":"","to_date":"","service_no":"","pageNo":nPageNo};		
 		}
 	else
 		{
 		var data = {"hospital_id": <%= hospitalId %>, "from_date":from_date,"to_date":to_date,"service_no":service_no,"pageNo":nPageNo};
 		} 
 	 
 	var bClickable = true;
 	var url = "getAdmissionDischargeRegister";
 	GetJsonData('tblListOfEmployee',data,url,bClickable);
 }
 
 function search()
 {
	 nPageNo=1;
 	var from_date = $j('#from_date').val();
 	var to_date = $j('#to_date').val();
 	var service_no = $j('#service_no').val(); 	
 	if((from_date == undefined || from_date == '') && (to_date == undefined || to_date == '') && (service_no == undefined || service_no == '')){
 		alert("Atleast one of the search option must be entered");
 		return;
 	}
	if(process(from_date) > process(to_date)){
 		alert("To Date should not be earlier than From Date");
 		return;
 	}
	$j('#tblListOfEmployee').empty();
	GetAdmissionDischargeRegister('Filter');
 	//ResetForm();
 } 
 
 /* function executeClickEvent(Id)
 {
	//alert(Id);
	window.location="adrList?header_id="+Id+"";
	 
 } */
 
 function showAll()
 {
 	ResetForm();
 	nPageNo = 1;	
 	GetAdmissionDischargeRegister('ALL');
 	
 }
 
 function ResetForm(){
	 
	 $j('#from_date').val('');
	 $j('#to_date').val('');
	 $j('#service_no').val(''); 	
 }
 
 
function makeTable(jsonData)
{	
	var htmlTable = "";	
 	var data = jsonData.count;
 	
 	var pageSize = 5;
 	var dataList = jsonData.getAdmissionDischargeRegister;;
	
	for(j=0;j<dataList.length;j++)
		{		
		
			htmlTable = htmlTable+"<trid='"+dataList[j].admissionId+"' >";	
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[j].name+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[j].rank+"</td>";			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[j].serviceNo+"</td>";
			//htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].diagnosis+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[j].dateOfAdmission+"</td>";			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[j].ward+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[j].dateOfDischarge+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[j].disposal+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[j].noOfDays+"</td>";			
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[j].dischargeRemarks+"</td>";
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='10'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblListOfEmployee").html(htmlTable);	
	
	
}

function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	GetAdmissionDischargeRegister('FILTER');	
}

function generateReport()
{

	var from_date = $j('#from_date').val();
	var to_date = $j('#to_date').val();
	var service_no = $j('#service_no').val();
	var unitId=$j("#unitId").val();
	
	if((from_date == undefined || from_date == '') || (to_date == undefined || to_date == '') || (hospitalId == undefined || hospitalId == '')){	
		alert("Fill mandatory fields");
		return;
	}
	
	var url="${pageContext.request.contextPath}/report/printAdmissionDischargeRegisterReport?unitId="
		+unitId+"&from_date="+from_date+"&to_date="+to_date+"&service_no="+service_no;
	openPdfModel(url);
	
}

	



</script>
</head>


<body>

    <!-- Begin page -->
    <div id="wrapper">

  
        <div class="content-page">
            <!-- Start content -->
            <div class="">
                <div class="container-fluid">
                <div class="internal_Htext">Admission Discharge Register</div>
                    
                    <!-- end row -->
                   
                  <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                       <form class="form-horizontal" id="employeeForm" name="employeeForm" method="" role="form">  
                                    <div class="row">
                                        <div class="col-md-3">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Service No.</label>
												<div class="col-sm-7">
													<input class="form-control form-control-sm" type="text"
														placeholder="" id="service_no">
												</div>
											</div>
										</div>
										<div class="col-md-3">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">From Date<span class="mandate"><sup>&#9733;</sup></span></label>
												<div class="col-sm-7">
													<!-- <input type="date" class="border form-control" id="from_date"> -->
													<div class="dateHolder ">
														<input type="text"  class="calDate datePickerInput form-control" id="from_date" placeholder="DD/MM/YYYY"
														name="date"  onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10">
													</div>
												</div>
											</div>
										</div>
										<div class="col-md-3">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">To Date<span class="mandate"><sup>&#9733;</sup></span></label>
												<div class="col-sm-7">
													<!-- <input type="date" class="border form-control" id="to_date"> -->
													<div class="dateHolder ">
														<input type="text"  class="calDate datePickerInput form-control" id="to_date" placeholder="DD/MM/YYYY"
														name="date"  onkeyup="mask(this.value,this,'2,5','/');" onblur="validateExpDate(this,'dateId')" maxlength="10">
													</div>
												</div>
											</div>
										</div>                              
                                        <div class="col-md-1">
											<div class="form-group row">
													<button type="button" class="btn  btn-primary obesityWait-search"
														onclick="search();">Search</button>
												
											</div>
										</div>
						
                                        <div class="col-md-2 text-right">
                                                                                  
                                                     <button type="button" class="btn  btn-primary" onclick="showAll();">Show All</button>
                                                     <button type="button" class="btn  btn-primary " 
                                                    id="printReportButton" 
                                                    onclick="generateReport()">Reports</button>
                                                 
                                        </div>
                                        <input type="hidden" id="hospitalId" value="" name="hospitalId"/>
                                        <input type="hidden" id="stationId" value="" name="stationId"/>
                                        <input type="hidden" id="unitId" value="0" name="unitId"/>

                                    </div>
                                  </form>
					
					                  <div style="float:left">					           
		                                    <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >			<tr>
												<td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
												<td>
	
												</td>
												</tr>
										</table>
		                                 </div>     
		                                    <div style="float:right">
				                                    <div id="resultnavigation">
				                                    </div> 
		                                    </div> 
                                    
					
		

                                    <table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                            	<!-- <th id="th2" class ="inner_md_htext">S.No</th> -->
                                                <th id="th2" class ="inner_md_htext">Name</th>
                                                <th id="th3" class ="inner_md_htext">Rank</th>
                                                <th id="th4" class ="inner_md_htext">Service No</th>
                                             	<!-- <th id="th4" class ="inner_md_htext">Diagnosis</th> -->
                                                <th id="th4" class ="inner_md_htext">Date of Admission</th>
                                                <th id="th3" class ="inner_md_htext">Ward</th>
                                                <th id="th4" class ="inner_md_htext">Date of Discharge</th>
                                                <th id="th4" class ="inner_md_htext">Disposal</th>
                                                <th id="th4" class ="inner_md_htext">No of Days</th>
                                                <th id="th3" class ="inner_md_htext">Remarks</th>
                                            </tr>
                                        </thead>
                                     <tbody id="tblListOfEmployee">
										 
                     				 </tbody>
                                    </table>
                                    
									 
         							<br>
									<!-- <div class="row">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
											
														<button type="button" class="btn btn-danger "
															onclick="Reset();">Reset</button>

											</div>
										</div>
									</div> -->

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
            <!-- content -->

            
        </div>

        <!-- ============================================================== -->
        <!-- End Right content here -->
        <!-- ============================================================== -->

    </div>
    <!-- END wrapper -->

    <!-- jQuery  -->
    

</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>