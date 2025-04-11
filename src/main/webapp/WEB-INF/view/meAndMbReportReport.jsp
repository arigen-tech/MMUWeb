<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="..//view/leftMenu.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Indian Coast Guard</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />


<%@include file="..//view/commonJavaScript.jsp"%>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/commonformodal.js"></script> --%>


<script type="text/javascript" language="javascript">
var nPageNo=1;
var Status;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{
	searchMEHistoryListPageLoad('ALL');
		}); 
function searchMEHistoryListPageLoad(MODE)
{
	
	var searchService = $j('#serviceNo').val();
		 if(searchService==null || searchService==""){
		}
	 if(MODE == 'ALL'){
			var data = {"pageNo":nPageNo, "serviceNo":searchService};			
		}
	 
	 else if(MODE == 'FILTER'){
			 
			var data =  {"pageNo":nPageNo, "serviceNo":searchService}; 
		}
 else if(searchService!=""){
			nPageNo = 1;
			var data =  {"pageNo":nPageNo, "serviceNo":searchService}; 
		}
	else
		{
			var data =  {"pageNo":nPageNo, "serviceNo":searchService}; 
		} 
	var url = "getMEMBHistory";
		
	var bClickable = true;
	GetJsonData('tblListOfCommand',data,url,bClickable);
}

function searchMEHistoryList(MODE)
{
	
	var searchService = $j('#serviceNo').val();
		 if(searchService==null || searchService==""){
			 alert("Please enter Service Number.");
		 }
	 if(MODE == 'ALL'){
			var data = {"pageNo":nPageNo, "serviceNo":searchService,};	
		}
	else
		{
			var data =  {"pageNo":nPageNo, "serviceNo":searchService,}; 
		} 
	var url = "getMEMBHistory";
		
	var bClickable = true;
	GetJsonData('tblListOfCommand',data,url,bClickable);
}
function makeTable(jsonData)
{	 
	var htmlTable = "";	
	var data = jsonData.count;
	var pageSize = 5;
	var dataList = jsonData.data;
	var medicalExamId="";
	var meTypeCode="";
	var visitId="";
	if(dataList!=null && dataList.length > 0)
	for(i=0;i<dataList.length;i++)
		{		
		medicalExamId=dataList[i].medicalExamId;
		visitId=dataList[i].visitId;
		
		meTypeCode=dataList[i].meTypeCode;
			htmlTable = htmlTable+"<tr id='"+dataList[i].visitId+"' >";	
		 
			htmlTable = htmlTable +"<td style='display:none;'>"+dataList[i].patientId+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].serviceNo+"</td>";
			htmlTable = htmlTable +"<td style='width: 150px;'>"+dataList[i].patientName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].medicalCategory+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].rankName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].age+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'><button class='btn btn-primary' onclick='getReportForMeMbH(\""+ visitId+ "\",\""+ meTypeCode+ "\");'>Report</button></td>";
			
			htmlTable = htmlTable+"</tr>";
		}
	if(dataList==null || dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='9'><h6>No Record Found</h6></td></tr>";
		}			
	$j("#tblListOfCommand").html(htmlTable);	
}
var visitId;
var patientId;
var patinetname;
var status;
var rankName;
var age;
var gender;
var meTypeName;
var departmentId;
var meTypeCode;
function executeClickEvent(visitId,data)
{
	 
	for(j=0;j<data.data.length;j++){
		if(visitId == data.data[j].visitId){
			
			visitId = data.data[j].visitId;
			
			patientId = data.data[j].patientId;
			patinetname = data.data[j].patinetname;
			age = data.data[j].age;
			gender = data.data[j].gender;
			rankName = data.data[j].rankName;
			meTypeName = data.data[j].meTypeName;
			status = data.data[j].status;
			departmentId = data.data[j].departmentId;
			meTypeCode = data.data[j].meTypeCode;
		}
	}
}


function searchValidateList()
{
	var searchService = $j('#serviceNo').val();
	 if((searchService == undefined || searchService == '')){	
			alert("Please entered  Service No.");
			return;
		}
	 searchMEHistoryListPageLoad('Search');
} 
function ShowAllList(pageNo)
{	 
	 nPageNo=pageNo;
	 resetForm();
	 searchMEHistoryListPageLoad('ALL');
}

function resetForm()
{	
	 $j('#serviceNo').val('');
}

function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	searchMEHistoryListPageLoad('FILTER');
	
}
</script>


</head>
<body>
 
	<div id="wrapper">
		<div class="content-page">
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext"><spring:message code="validatedInvestigationSlip" /></div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<div class="row">

										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">Service
														No.</label>
												</div>
												<div class="col-md-7">
													<input type="text" name="serviceNo" id="serviceNo" class="form-control" autocomplete="off"/>
												</div>
											</div>
										</div>

										<!-- <div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label for="service" class="col-form-label">ME Type</label>
												</div>
												<div class="col-md-7">
													<select class="form-control" id="examTypeId"
														name="examTypeId">
														<option value="0">Select</option>
													</select>
												</div>
											</div>
										</div> -->

								<div class="col-md-2">
											<button type="button" class="btn btn-primary"
												onclick=" return searchValidateList()">Search</button>
										</div>
										<div class="col-md-6 text-right">
											<button type="button" class="btn btn-primary"
												onclick="ShowAllList('1')">Show All</button>
										</div> 

									</div>
									<div style="float: left">

										<table class="tblSearchActions" cellspacing="0"
											cellpadding="0" border="0">
											<tr>
												<td class="SearchStatus" style="font-size: 15px;"
													align="left">Search Results</td>
												<td></td>
											</tr>
										</table>
									</div>

									<div style="float: right">
										<div id="resultnavigation"></div>
									</div>
									<div class="clearfix"></div>
									<table
										class="table table-hover table-striped table-bordered m-t-10">
										<thead class="bg-primary">
											<tr>
												<!-- <th>Token No.</th> -->
												<th>Service No.</th>
												<th>Employee Name</th>
												<th>ME/MB Type</th>
												<th>Rank</th>
												<th>Age</th>
												<th>Action</th>
											</tr>
										</thead>
										<tbody id="tblListOfCommand">
										</tbody>
									</table>

										<div id="medicalEXamReportId">
										  <form  name="medicalExamReportReportId" id="medicalExamReportReportId" method="post" 
											action="${pageContext.request.contextPath}/report/validateMedicalExamReport" autocomplete="on">
												<input type="hidden" name="visit_id" id="visit_id" value=""/>   
											</form>	  
											
											 
										</div>
								</div>

							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
			
		

	</div>
<script type="text/javascript" language="javascript">
	var nPageNo=1;
	var Status;
	var $j = jQuery.noConflict();

	$j(document).ready(function()
		{	
		openExamSubType(0);
		});  
	
	
	function getReportForMeMbH(visitId,examCode){
		var meForm3B=resourceJSON.meForm3B;
		var meForm18=resourceJSON.meForm18;
		
		var meForm3A=resourceJSON.meForm3A;
		var mbForm15=resourceJSON.mbForm15;
		var mbForm16=resourceJSON.mbForm16;
		$('#medicalEXamReportId').show();
		
		$('#visit_id').val(visitId);
	 	
		 var url=pageContaxValue+"/report/validateMedicalExamReport?visit_id="+visitId;
		// $('#urlForReport').val(url);
		 openPdfModel(url) ;
		
		//document.getElementById('medicalExamReportReportId').submit();
	 	 
		/* if(meForm3B==examCode){
			$('#medicalEXamReportId').show();
			$('#visit_id3b').val(medicalExamId);
		 	 document.getElementById('medicalExamReportReportId').submit();
			}
			if(meForm18==examCode){
				$('#medicalEXamReportId').show();
				$('#visit_id18').val(medicalExamId);
			 	 document.getElementById('medicalExamReportReportId18').submit();
			}
			
			if(meForm3A==examCode){
				$('#medicalEXamReportId').show();
				$('#visit_id3a').val(medicalExamId);
			 	 document.getElementById('medicalExamReportReportId3A').submit();
				}
				if(mbForm15==examCode){
					$('#medicalEXamReportId').show();
					$('#visit_id15').val(medicalExamId);
				 	 document.getElementById('medicalExamReportReportId15').submit();
				}
			
				if(mbForm16==examCode){
					$('#medicalEXamReportId').show();
					$('#visit_id16').val(medicalExamId);
				 	 document.getElementById('medicalExamReportReportId16').submit();
				}
				 */
	}
	
	</script>
 

</body>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
</html>