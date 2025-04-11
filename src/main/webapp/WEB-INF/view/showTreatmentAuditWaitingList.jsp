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
  
<script type="text/javascript" language="javascript">
<%
String mmuId = "1";
if (session.getAttribute("mmuId") != null) {
	mmuId = session.getAttribute("mmuId") + "";
}
String userId = "1";
if (session.getAttribute("userId") != null) {
	userId = session.getAttribute("userId") + "";
}

String departmentId = "2";
if (session.getAttribute("departmentId") != null) {
	departmentId = session.getAttribute("departmentId") + "";
}

String departmentName = "";
if (session.getAttribute("departmentName") != null) {
	departmentName = session.getAttribute("departmentName") + "";
}

String campId = "33";
if (session.getAttribute("campId") != null) {
	campId = session.getAttribute("campId") + "";
}

String levelOfUser = "1";
if (session.getAttribute("levelOfUser") != null) {
	levelOfUser = session.getAttribute("levelOfUser") + "";
}

%>
var nPageNo=1;
var Status;
var $j = jQuery.noConflict();
var dropMMUIdCheck=localStorage.mmuDropDownIdShow;
$j(document).ready(function()
		{	
			getMMUList();
			if(dropMMUIdCheck!='undefined')
		    {
			  //getCommandList('ALL');
		    }
		});
		
function getCommandList(MODE)
{
	
	var mobile_no = $j('#mobile_no').val();
	var userId = $j('#userId').val();
	var campId = $j('#campId').val();
	var mmuId = $j('#mmuIdList').val();
	
	//alert(mmuId);
	var exceptionTypeVal = $j('#withException').val();
	 var searchPatient = $j('#patientName').val();
	 
	 if(mmuId !=null)
		 {
			 if(MODE == 'ALL'){
				 
					var data = {"pageNo":nPageNo,"mobileNo":"","patientName":"",'employeeId' : userId,'opdPre' :"F",'mmuIdVal':mmuId,"exceptionChecked":"","exceptionType":""};			
				}
			 else if(exceptionTypeVal=='withException')
				{
				 var data = {"pageNo":nPageNo,"mobileNo":"","patientName":searchPatient,'employeeId' : userId,'opdPre' :"F",'mmuIdVal':mmuId,"exceptionChecked":"Y","exceptionType":"withException"};
				} 
			else
				{
					var data =  {"pageNo":nPageNo, "mobileNo":mobile_no,"patientName":searchPatient,"employeeId":userId,"opdPre":"F","mmuIdVal":mmuId,"exceptionChecked":"","exceptionType":""}; 
				} 
		 }
		 
	
	var url = "getAuditWaitingList";
		
	var bClickable = true;
	GetJsonData('tblListOfCommand',data,url,bClickable);
}

<%-- function getCityWaitingList()
{
	
	var cityIdVal=$('#cityId').val(); 
	var nPageNo=1;	
	var opdType=$('#opdType').val();  	
	var data = {"hospitalId":mmuId,"employeeId": <%=userId%>,"cityId":cityIdVal,"opdPre":"F", "patientName":"","pageNo":"1"};
	var bClickable = true;
	var url = "getAuditWaitingList";
	GetOpdJsonData('tblListofOpdP',data,url,bClickable);
} --%>

function getMMUWaitingList()
{
	
	var mmuIdVal=$('#mmuIdList').val();
    localStorage.mmuDropDownIdShow=mmuIdVal;
 	var nPageNo=1;
	var data = {"pageNo":nPageNo,"mobileNo":"","patientName":"",'employeeId' : userId,'opdPre' :"F",'mmuIdVal':mmuIdVal,"exceptionChecked":"","exceptionType":""};
    var bClickable = true;
	var url = "getAuditWaitingList";
	GetOpdJsonData('tblListOfCommand',data,url,bClickable);
}

function getMMUWaitingExceptionList(exceptionValue)
{
	var mmuIdVal=$('#mmuIdList').val(); 
	var nPageNo=1;	
	var data = {"pageNo":nPageNo,"mobileNo":"","patientName":"",'employeeId' : userId,'opdPre' :"F",'mmuIdVal':mmuIdVal,"exceptionChecked":"Y","exceptionType":exceptionValue};
	var bClickable = true;
	var url = "getAuditWaitingList";
	GetOpdJsonData('tblListOfCommand',data,url,bClickable);
}

function makeTable(jsonData)
{	 
	var htmlTable = "";	
	var data = jsonData.count;
	
	
	var pageSize = 5;

	
	var dataList = jsonData.data;
	if(dataList!=null && dataList.length > 0)
	for(i=0;i<dataList.length;i++)
		{		
		
			htmlTable = htmlTable+"<tr id='"+dataList[i].visitId+"' >";	
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].auditDate+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].auditorName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].visitDate+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].patinetname+"</td>";				
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].ageFull+" / "+dataList[i].gender+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].mobileNumber+"</td>";
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
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].mmuName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].cityName+"</td>";
			htmlTable = htmlTable +"<td style='width: 100px;'>"+dataList[i].doctorName+"</td>";
			htmlTable = htmlTable+"</tr>";
			
		}
	if(dataList==null || dataList.length == 0)
		{
		htmlTable = htmlTable+"<tr ><td colspan='10'><h6>No Record Found</h6></td></tr>";
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
	var data =  {"pageNo":nPageNo, "mobile_no":mobile_no,"patientName":searchPatient,"employeeId":"1","opdPre":"F","hospitalId":""+<%=hospitalId%>};//"PN="+nPageNo+"cmdName="+cmdName;
	var bClickable = true;
	GetJsonData('tblListOfCommand',data,url,bClickable);
}
  --%>
 

function rowClick(visitId,patientId,tokenNo,mobile_no,patinetname,relation,  rankName,empName,age,gender,mobileNumber){	
		
	 window.location.href = "showClincicalAuditData?visitId="+visitId+"&visitStatus=com";
	
}
function ResetForm()
{	
	 $j('#mobile_no').val('');
	 $j('#patientName').val('');
}

function showResultPage(pageNo)
{
	nPageNo = pageNo;	
	getCommandList('ALL');
	
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
	 
	 if((mobile_no == undefined || mobile_no == '') && (searchPatient == undefined || searchPatient == '')){	
			alert("Please enter patient name");
			return;
		}	
	 getCommandList('FILTER');
	//ResetForm();
} 



function getMMUList(){
	var params = {
			"levelOfUser":'<%=levelOfUser%>',
			"userId": <%=userId%>
	}
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : '${pageContext.request.contextPath}/master/getMMUHierarchicalList',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(result) {
			   var mmuDrop = '';
			   var data=result.mmuListdata;
			   
			   if(data.mmuList.length =='1'){
				   //$('#mmuIdList').attr('disabled', true);
				   for(i=0;i<data.mmuList.length;i++){
						mmuDrop += '<option value='+data.mmuList[i].mmu_id+' selected>'+data.mmuList[i].mmu_name+'</option>';
						
					}
					$j('#mmuIdList').append(mmuDrop);
				   <%-- document.getElementById('mmuId').value = <%=mmuId%>; --%>
				   if(dropMMUIdCheck!=null)
			       {
					    $('#mmuIdList').val(dropMMUIdCheck);
			    	   //document.getElementById("mmuIdList").selectedIndex  = dropMMUIdCheck;
			    	   getMMUWaitingList()
			       } 
			   }
			   else{
				for(i=0;i<data.mmuList.length;i++){
					mmuDrop += '<option value='+data.mmuList[i].mmu_id+'>'+data.mmuList[i].mmu_name+'</option>';
					
				}
				$j('#mmuIdList').append(mmuDrop);
				 if(dropMMUIdCheck!=null)
			       {
					   $('#mmuIdList').val(dropMMUIdCheck);
			    	   //document.getElementById("mmuIdList").selectedIndex  = dropMMUIdCheck;
			    	   getMMUWaitingList()
			    	   
			       } 
			  }
			   getMMUWaitingList();
		},
		error : function(data) {
			alert("An error has occurred while contacting the server");
		}
	}); 
	}
	
function changeRadio(value){
		
	if(value=="allData")
	{
		$('#exceptionVal').hide();
		ShowAllList('1');
	}
	else
	{ 
			$('#withException').val("withException");
			$('#exceptionVal').show();
			getCommandList('FILTER');
	}	
	
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
	 
	  <div class="internal_Htext">Show Prescription Audit Waiting List</div>
	 
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                    <input type="hidden"  name="mmuId" value=<%= session.getAttribute("mmuId") %> id="mmuId" />
									<input type="hidden"  name="userId" value=<%= session.getAttribute("userId") %> id="userId" />
									<input type="hidden"  name="campId" value=<%= session.getAttribute("campId") %> id="campId" />
                                     <div class="row">
                                   <!--   <div class="col-lg-3 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="cityId" onchange="getMMUList(this);getCityWaitingList()">
												<option value="">Select</option>
												</select>
											</div>
										</div>
									</div> -->
									<div class="col-lg-3 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">MMU</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="mmuIdList" onchange="getMMUWaitingList()">
												<option value="">Select</option>
												</select>
											</div>
										</div>
									</div>
										<!-- <div class="col-lg-3 col-sm-6">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Mobile No.</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="mobile_no" maxlength="10" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" placeholder="Mobile Number">
												</div>
											</div>
										</div> -->
										<div class="col-lg-3 col-sm-6">
											<div class="form-group row">
												<label class="col-sm-5 col-form-label">Patient Name</label>
												<div class="col-sm-7">
													<input type="text" class="form-control" id="patientName" name="patientName" placeholder="">
												</div>
											</div>
										</div>
										<div class="col-lg-3 col-sm-6">
										<div class="form-group row">
											<div class="col-md-4">
												<div class="form-check form-check-inline cusRadio">
													<input class="form-check-input" id="allData" value="allData" onchange="changeRadio(this.value)" name="same" type="radio" value="">
													<span class="cus-radiobtn"></span>
													<label class="col-form-label" for="check0">All</label>
												</div>
											</div>
											<div class="col-md-7">
												<div class="form-check form-check-inline cusRadio">
													<input class="form-check-input" id="withException" value="" onchange="changeRadio(this.value)" name="same" type="radio" value="">
													<span class="cus-radiobtn"></span>
													<label class="col-form-label" for="check1">With Exception</label>
												</div>
											</div>
										</div>
									</div>
										<div class="col-lg-3 col-sm-6" id="exceptionVal" style="display: none">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Exception Value</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="exceptionDropDown" onchange="getMMUWaitingExceptionList(this.value)">
												<option value="">Select</option>
												<option value="diagnois">Diagnosis</option>
												<option value="investigation">Investigation</option>
												<option value="treatment">Treatment</option>
												</select>
											</div>
										</div>
									</div>
										<div class="col-md-12 text-right">
											 <button type="button" class="btn btn-primary" onclick="searchOpdRecallList()">Search</button>
											<button type="button" class="btn btn-primary" onclick="ShowAllList('1')">Show All</button>
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
                                             
                                               <th id="th4" class ="inner_md_htext"> Audit Date </th>
                                               <th id="th4" class ="inner_md_htext"> Auditor Name </th>
                                               <th id="th4" class ="inner_md_htext"> OPD Date </th>
                                                <th id="th4" class ="inner_md_htext"> Patient Name </th>
                                                
                                                 <!--  <th id="th5" class ="inner_md_htext">Name</th> -->
                                                   <th id="th5" class ="inner_md_htext">Age/Gender</th>
                                                   <th id="th5" class ="inner_md_htext">Mobile No</th>
                                                    <th id="th5" class ="inner_md_htext">Type Of Patient</th>
                                                     <th id="th5" class ="inner_md_htext">MMU</th>
                                                     <th id="th5" class ="inner_md_htext">City</th>
                                                     <th id="th5" class ="inner_md_htext">Doctor Name</th>
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