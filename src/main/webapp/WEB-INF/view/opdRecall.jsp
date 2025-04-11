<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@include file="..//view/leftMenu.jsp" %>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Indian Coast Guard</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    
<%@include file="..//view/commonJavaScript.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newOpd.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opd.js"></script> 

  
<script type="text/javascript" language="javascript">
var nPageNo=1;
var Status;
var $j = jQuery.noConflict();

$j(document).ready(function()
		{	
			getCommandList('ALL');
		});
		
function getCommandList(MODE)
{
	
	var mobile_no = $j('#mobile_no').val();
	var userId = $j('#userId').val();
	var campId = $j('#campId').val();
	var mmuId = $j('#mmuId').val();
	var dateOfOpd = $j('#dateOfOpd').val();
	 var searchPatient = $j('#patientName').val();
		 
	 if(MODE == 'ALL'){
		 
			var data = {"pageNo":nPageNo,"mobileNo":"",'employeeId' : userId,'opdPre' :"c",'hospitalId':mmuId};			
		}
	else
		{
			var data =  {"pageNo":nPageNo, "mobileNo":mobile_no,"patientName":searchPatient,"employeeId":userId,"opdPre":"c","hospitalId":mmuId,"dateOfOpd":dateOfOpd}; 
		} 
	var url = "getOpdPatientRecalls";
		
	var bClickable = true;
	GetJsonData('tblListOfCommand',data,url,bClickable);
}
function makeTable(jsonData)
{	 
	var htmlTable = "";	
	var data = jsonData.count;
	
	
	var pageSize = 5;

	
	var dataList = jsonData.data;
	if(dataList!=null && dataList.length >= 0)
	for(i=0;i<dataList.length;i++)
		{		
		
			htmlTable = htmlTable+"<tr id='"+dataList[i].visitId+"' >";	
		 
			htmlTable = htmlTable +"<td style=display:none;'>"+dataList[i].patientId+"</td>";
							
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].patinetname+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].ageFull+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].gender+"</td>";
			 htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].departmentName+"</td>";
			 htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].mobileNumber+"</td>";
				htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].doctorName+"</td>";
	 			if(dataList[i].patientType=="G"){	
	 	 			htmlTable = htmlTable +"<td style='width: 100px;'>"+'General Citizen'+"</td>";
	 	 			}
	 	 			else if(dataList[i].patientType=="L"){
	 	 				htmlTable = htmlTable +"<td style='width: 100px;'>"+'Labour'+"</td>";
	 	 			}
	 	 			else
	 	 			{
	 	 				htmlTable = htmlTable +"<td style='width: 100px;'>"+''+"</td>";
	 	 			}
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList==null || dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='8'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#tblListOfCommand").html(htmlTable);	
	
	
}
var comboArray = [];
var visitId;
var patientId;
var tokenNo;
var mobile_no;
var patinetname;
var relation;


var rankName;
var empName;
var age;
var gender;
var mobileNumber;

function executeClickEvent(visitId,data)
{
	
	for(j=0;j<data.data.length;j++){
		if(visitId == data.data[j].visitId){
			
			visitId = data.data[j].visitId;
			
			patientId = data.data[j].patientId;
			tokenNo = data.data[j].tokenNo;
			mobile_no = data.data[j].mobile_no;
			patinetname = data.data[j].patinetname;
			relation = data.data[j].relation;
			
			
			rankName = data.data[j].rankName;
			empName = data.data[j].empName;
			age = data.data[j].age;
			gender = data.data[j].gender;
			mobileNumber = data.data[j].mobileNumber;
			
		}
	}
	rowClick(visitId,patientId,tokenNo,mobile_no,patinetname,relation,rankName,empName,age,gender,mobileNumber);
}

<%--  function searchCommandList(){
	  if(document.getElementById('mobile_no').value == "" || document.getElementById('mobile_no') == null){
		 alert("Plese Enter the Service Number");
		 return false;
	 }
	 if(document.getElementById('patientName').value == "" || document.getElementById('patientName') == null){
		 alert("Plese Enter the Patient Name");
		 return false;
	 } 
	var mobile_no= jQuery("#mobile_no").attr("checked", true).val();
	var searchPatient= jQuery("#patientName").attr("checked", true).val();	
	var nPageNo=1;
	var url = "getOpdPatientRecalls"; 
	var data =  {"pageNo":nPageNo, "mobile_no":mobile_no,"patientName":searchPatient,"employeeId":"1","opdPre":"c","hospitalId":""+<%=hospitalId%>};//"PN="+nPageNo+"cmdName="+cmdName;
	var bClickable = true;
	GetJsonData('tblListOfCommand',data,url,bClickable);
}
  --%>
 

function rowClick(visitId,patientId,tokenNo,mobile_no,patinetname,relation,  rankName,empName,age,gender,mobileNumber){	
		
	 window.location.href = "getOpdPatientRecallModel?visitId="+visitId+"&visitStatus=com";
	
}
function ResetForm()
{	
	 $j('#mobile_no').val('');
	 $j('#patientName').val('');
}

function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	getCommandList('FILTER');
	
}

function ShowAllList(pageNo)
{	 
	 nPageNo=pageNo;
	 ResetForm();
	 getCommandList('ALL');
}

function searchOpdRecallList()
{
		

	var mobile_no = $j('#mobile_no').val();
	 var searchPatient = $j('#patientName').val();
	 var dateOfOpd = $j('#dateOfOpd').val();
	 
	 if((mobile_no == undefined || mobile_no == '') && (searchPatient == undefined || searchPatient == '')&& (dateOfOpd == undefined || dateOfOpd == '')){	
			alert("At least  one option must be entered.");
			return;
		}	
	 getCommandList('FILTER');
	//ResetForm();
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
	 
	  <div class="internal_Htext">OPD Recall List</div>
	 
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                    <input type="hidden"  name="mmuId" value=<%= session.getAttribute("mmuId") %> id="mmuId" />
									<input type="hidden"  name="userId" value=<%= session.getAttribute("userId") %> id="userId" />
									<input type="hidden"  name="campId" value=<%= session.getAttribute("campId") %> id="campId" />
                                     <div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Mobile No.</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="mobile_no" maxlength="10" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" placeholder="Mobile Number">
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Patient Name</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="patientName" name="patientName" placeholder="">
												</div>
											</div>
										</div>
										</div>
										<div class="row">
										<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Date</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" name="dateOfOpd" id="dateOfOpd" class="calDate form-control" placeholder="DD/MM/YYYY">
												</div>
											</div>
										</div>
									</div>
										<div class="col-md-1">
											 <button type="button" class="btn btn-primary" onclick="searchOpdRecallList()">Search</button>
										</div>
										<div class="col-md-3">
											
												
												<div class="btn-right-all">
													
													<button type="button" class="btn btn-primary"
														onclick="ShowAllList('1')">Show All</button>
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


								
                                    <table class="table table-hover table-bordered table-striped">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                             
                                                <th id="th4" class ="inner_md_htext"> Patient Name </th>
                                                
                                                 <!--  <th id="th5" class ="inner_md_htext">Name</th> -->
                                                   <th id="th5" class ="inner_md_htext">Age</th>
                                                    <th id="th5" class ="inner_md_htext">Gender</th>
                                                     <th id="th5" class ="inner_md_htext">Department</th>
                                                     <th id="th5" class ="inner_md_htext">Mobile No</th>
                                                     <th id="th5" class ="inner_md_htext">Doctor</th>
                                                     <th id="th5" class ="inner_md_htext">Type Of Patient</th>
                                            </tr>
                                        </thead>
                                         
                                        <tbody id="tblListOfCommand">

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