<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Indian Coast Guard</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/approvalprocess.js"></script>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">


		<div class="content-page">
			<!-- Start content -->
			
				<div class="container-fluid">
				<input type="hidden" id="approvalFlg" name="approvalFlg" value=""/>
					<div class="internal_Htext">Inbox</div> 
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
								
								
								<div class="row">
								<!-- left tab menu  -->
								<div class="col-md-2">
									<ul class="inPageLeftMenu">
									<li>
										<a class="active"  onclick='showInbox1(this)' data-name="inbox">
											Inbox
											<span class="badge badge-success m-l-5" id="inbox">8</span>
										</a>
									</li>
									<li>
										<a  onclick='showApproval(this)' data-name="approved">
											Approved 
											<span class="badge badge-success m-l-5" id="approve">2</span>
										</a>
									</li>
									<li>
										<a  onclick='showReject(this)' data-name="rejected">
											Rejected
											<span class="badge badge-success m-l-5" id="reject">1</span>
										</a>
									</li>
									
									</ul>
								</div>
								<!-- left tab menu end -->
								
								
								<!-- left tab content  -->
								<div class="col-md-10">
									<div class="row">
										<div class="col-sm-3">
											<button class="btn btn-block button-tab active" onclick='showList1("MedicalExam")'  data-name="MedicalExam">
												Medical Exam
												<span class="badge badge-success m-l-5" id="mexam">4</span>
											</button>
										</div>
										<div class="col-sm-3">
											<button class="btn btn-block button-tab" onclick='showList1("MedicalBoard")'  data-name="MedicalBoard">
												Medical Board
												<span class="badge badge-success m-l-5" id="mboard">4</span>
											</button>
										</div>
										<div class="col-sm-3">	
											<button class="btn btn-block button-tab" onclick='showList1("Indent")'  data-name="Indent">
												Indent
												<span class="badge badge-success m-l-5" id="indent">4</span>
											</button>
										</div>
									</div>
								
								
								<div class="row" id="search" style="display: none;">
										<div class="col-12  m-t-10">
						
														  <div style="float:left">					           
		                                    <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >	
		                                    
		                             		<tr>
												<td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
												<td>
												 <!-- <div id=resultnavigation></div> -->
												
												</td>
												</tr>
										</table>
		                                 </div>     
		                                    <div style="float:right">
				                                    <div id="resultnavigation">
				                                    </div> 
		                                    </div> 
                                    
                                    <div class="clearfix"></div>
					
		

										<table class="table table-hover table-striped table-bordered m-t-10" id="medicalExam" style="display: none;">
											<thead class="bg-primary">
												<tr>
													<th>Service No.</th>
													<th>Employee Name</th>
													<th>Rank </th>
													<th>Age</th>
													<th>Gender</th>
													<th>Date of ME</th>
													<th>Med Category</th>
													<th>Medical Exam</th>
													<th>MO</th>
													<th>Status</th>
													
												</tr>
											</thead>
											<tbody id="tblListOfME">
												
											</tbody>
										</table>
										
										
										
										<div class="row">
									<div class="col-12 m-t-10">
								 <table class="table table-hover table-striped table-bordered" id="indenttb" style="display: none;">
                                        <thead class="bg-success" style="color:#fff;">
												<tr>
													<th id="th1">Indent Date</th>
													<th id="th2">Indent No</th>
													<th id="th3">From Department</th>
													<th id="th4">To Department</th>
													<th id="th10">Created By</th>
													<th id="th5">Status </th>

												</tr>
											</thead>
											<tbody id="tblListOfIndent">
											</tbody>
										</table>
										</div>
										</div>
									
									
									
									</div>
								</div>
								
								</div>
								<!-- left tab content end  -->
								
								</div>
								
								
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- container -->

			</div>
			<!-- content -->

		</div>

		<!-- ============================================================== -->
		<!-- End Right content here -->
		<!-- ============================================================== -->

	<!-- END wrapper -->
	
	<script>
		$(function(){
			$('.button-tab').on('click',function(){
				
				$('.button-tab').removeClass('active');
				
				$(this).addClass('active');
			});
			
			$('ul.inPageLeftMenu li a').on('click',function(){
				
				$('ul.inPageLeftMenu li a').removeClass('active');
				
				$(this).addClass('active');
			})
			
		});
	</script>

</body>
<script>
var nPageNo=1;
var Status;
var $j = jQuery.noConflict();
 var dictionary ="";
 var approvalData="";
 var selectedbtn="";
 $j(document).ready(
  function(){
    dictionary = ${approvalResponse};
    approvalData=dictionary.data;
        $j("#inbox").html(approvalData.inbox);
        $j("#approve").html(approvalData.approve);
        $j("#reject").html(approvalData.reject);
        $j("#mboard").html(approvalData.mbInbox);
        $j("#mexam").html(approvalData.meInbox);
        $j("#indent").html(approvalData.indentInbox);
        $j("#search").hide();	
        $j("#indenttb").hide();
        GetListOfIndent('ALL');//need to change call getmelist method
  }
  
  );
function showApproval(val){
	$('ul.inPageLeftMenu li a').removeClass('active');
	$(val).addClass('active');
	if(approvalData.mbApprove!=null || approvalData.mbApprove!='0'||approvalData.mbApprove!=undefined)
	$j("#mboard").html(approvalData.mbApprove);
	if(approvalData.meApprove!=null || approvalData.mbApprove!='0'||approvalData.mbApprove!=undefined)
    $j("#mexam").html(approvalData.meApprove);
	if(approvalData.indentApprove!=null || approvalData.indentApprove!='0'|| approvalData.indentApprove!=undefined)
    $j("#indent").html(approvalData.indentApprove);
    $j("#search").hide();	
    $j("#indenttb").hide();
	$('.button-tab').each(function(){
			
			if($(this).hasClass('active')){
				
				selectedbtn = $(this).attr('data-name');
				
			}
		})
		showList1(selectedbtn);
	}
	
function showInbox1(val){
	$('ul.inPageLeftMenu li a').removeClass('active');
	
	$(val).addClass('active');
	  $j("#mboard").html(approvalData.mbInbox);
 	  $j("#mexam").html(approvalData.meInbox);
 	  $j("#indent").html(approvalData.indentInbox);
 	 $j("#search").hide();	
     $j("#indenttb").hide();
     $('.button-tab').each(function(){
			
			if($(this).hasClass('active')){
				
				selectedbtn = $(this).attr('data-name');
				
			}
		})
		showList1(selectedbtn);
	}
	
function showReject(val){
	$('ul.inPageLeftMenu li a').removeClass('active');
	
	$(val).addClass('active');
	  $j("#mboard").html(approvalData.mbReject);
 	  $j("#mexam").html(approvalData.meReject);
  	  $j("#indent").html(approvalData.indentReject);
  	 $j("#search").hide();	
     $j("#indenttb").hide();
     $('.button-tab').each(function(){
			
			if($(this).hasClass('active')){
				
				selectedbtn = $(this).attr('data-name');
				
			}
		})
		showList1(selectedbtn);
	}
	

function showList1(value){
	
	if(value=='Indent')
	 GetListOfIndent('ALL');
	else if(value=='MedicalExam'){
		getApprovalProcessForCommon('ALL','SearchStatus');
	}
		else if(value=='MedicalBoard')
			 GetListOfMedicalBoard('ALL');
}
function GetListOfIndent(MODE)
{
	var selectedMenu;
	var flag="";
    $('ul.inPageLeftMenu li a').each(function(){
		
		if($(this).hasClass('active')){
			
			selectedMenu = $(this).attr('data-name');
			
		}
	})
	
	if(selectedMenu == 'inbox'){
		flag='Y';
	}else if(selectedMenu == 'approved'){
		flag='A';
	}else if(selectedMenu == 'rejected'){
		flag='R';
	}
 if(MODE == 'ALL'){
	 var data = {"PN":nPageNo,"flag":flag};		
	}
else
	{
	var data = {"PN":nPageNo,"flag":flag};
	} 
 	var pathname = window.location.pathname;
	 var accessGroup = "MMUWeb";
	 var url = window.location.protocol + "//"
		+ window.location.host + "/" + accessGroup
		+"/dispencery/getAllListOfIndentList";
		var bClickable = true;
		
	GetJsonData('tblListOfIndent',data,url,bClickable);
} 

function makeTable(jsonData)
{	
var htmlTable = "";	
var data = jsonData.count;


var pageSize = 5;


var dataList = jsonData.data;
 for(item in dataList){
		
		  // htmlTable += '<tr id="'+dataList[item].Id+'" onclick="hello('+dataList+')">';
		   htmlTable = htmlTable + "<tr id='"+dataList[item].indentId+"' >";	
		  htmlTable = htmlTable + "<td >" + dataList[item].indentdate + "</td>";
    	  htmlTable = htmlTable + "<td >" + dataList[item].indentNo + "</td>";
    	  htmlTable = htmlTable + "<td >" + dataList[item].fromDept + "</td>";
    	  htmlTable = htmlTable + "<td >" + dataList[item].toDept + "</td>";
    	  htmlTable = htmlTable + "<td >" + dataList[item].createdBy + "</td>";
    	  htmlTable = htmlTable + "<td >" + dataList[item].status + "</td>";
    	  htmlTable = htmlTable + "</tr>";
    
      }
if(jsonData.count == 0 || typeof jsonData.count == 'undefined')
	{
	htmlTable = htmlTable+"<tr ><td colspan='6'><h6>No Record Found</h6></td></tr>";
	   //alert('No Record Found');
	}			
$j("#search").show();	
$j("#indenttb").show();
$j("#tblListOfIndent").html(htmlTable);	
$j('#search').hide();
$j('#medicalExam').hide();

}


function showResultPage(pageNo)
{


nPageNo = pageNo;	
GetListOfIndent('FILTER');

}


function showAll()
{
nPageNo = 1;	
GetListOfIndent('ALL');

}

var indentId;
var indentNo;
var indentdate;
var toDept;
var createdBy;
var approvedBy;
var status;
var statusId;
function executeClickEvent(indentId,jsonData)
{
var dataList = jsonData.data;
 for(item in dataList){
	if(indentId == dataList[item].indentId){
		
		indentId = dataList[item].indentId;
		
		indentNo = dataList[item].indentNo;
		indentdate = dataList[item].indentdate;
		toDept = dataList[item].toDept;
		createdBy =dataList[item].createdBy;
		approvedBy =dataList[item].approvedBy;
		status = dataList[item].status;
		statusId = dataList[item].statusId;
		
	}
}
rowClick(indentId,indentNo,indentdate,toDept,createdBy,approvedBy,status,statusId);
}


function rowClick(indentId,indentNo,indentdate,toDept,createdBy,approvedBy,status,statusId){
	
   window.location.href = "${pageContext.request.contextPath}/dispencery/getIndentDetailsForApproval?indentId="+indentId+"&indentStatus="+statusId;

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
var serviceNo;
var mediceExamDate;
var medicalCategory;
var approvedBy;
function executeClickEventCommon(visitId,data)
{
	for(j=0;j<data.data.length;j++){
		if(visitId == data.data[j].visitId){
			
			visitId = data.data[j].visitId;
			
			patientId = data.data[j].patientId;
			serviceNo = data.data[j].serviceNo;
			patinetname = data.data[j].patinetname;
			rankName = data.data[j].rankName;
			age = data.data[j].age;
			gender = data.data[j].gender;
			mediceExamDate=data.data[j].mediceExamDate;
			medicalCategory=data.data[j].medicalCategory;
			meTypeName = data.data[j].meTypeName;
			approvedBy= data.data[j].approvedBy;
			status = data.data[j].approvedBy;
			departmentId = data.data[j].departmentId;
			
		}
	}
	rowClickCommon(visitId,patientId,patinetname,rankName,age,gender,mediceExamDate,medicalCategory,meTypeName,approvedBy, status,departmentId);
}



function rowClickCommon(visitId,patientId,patinetname,rankName,age,gender,mediceExamDate,medicalCategory,meTypeName,approvedBy, status,departmentId){
		$("#visitId").val(visitId);
		$("#departmentId").val(departmentId);
		$("#patientId").val(patientId);
		var approvalFlg=$('#approvalFlg').val();
		var countCheckBox=0;
if(approvalFlg=='pe'){
	window.location.href = "${pageContext.request.contextPath}/medicalexam/validateMAWaitingDetailMO?visitId="+visitId+"&age="+age+"&approvalFlag=y";
}	else{
	
	window.location.href = "${pageContext.request.contextPath}/medicalexam/meApprovalWaitingPerusingDetail?visitId="+visitId+"&age="+age+"&approvalFlag=y";
}	
   
 }


</script>
</html>