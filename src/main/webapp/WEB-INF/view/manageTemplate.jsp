<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="..//view/leftMenu.jsp"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Indian Coast Guard</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>
 
<script type="text/javascript">

	<%
	String hospitalId = "1";
	if (session.getAttribute("hospital_id") != null) {
		hospitalId = session.getAttribute("hospital_id") + "";
	}
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	
	String departmentId = "1";
	if (session.getAttribute("department_id") != null) {
		departmentId = session.getAttribute("department_id") + "";
	}
	
	%>

	nPageNo = 1;
	var $j = jQuery.noConflict();

	$j(document).ready(function() {
		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		 $j('#templateCode').attr('readonly', false);

		GetAllTemplate('ALL');
		
	});

	function GetAllTemplate(MODE) {
		var tempName= jQuery("#searchTemplate").attr("checked", true).val().toUpperCase();
		var id = 0;
		if (MODE == 'ALL') {
			var data = {"PN" : nPageNo,"templateName":""};
		} else {
			var data = {"PN" : nPageNo, "templateName":tempName};
		}
		var url = "getAllTemplate";
		var bClickable = true;
		GetJsonData('tblListOfTemplate', data, url, bClickable);
	}

	function makeTable(jsonData) {
		var htmlTable = "";
		var data = jsonData.count;

		var pageSize = 5;
		var dataList = jsonData.data;

		for (i = 0; i < dataList.length; i++) {

			if (dataList[i].status == 'Y' || dataList[i].status == 'y') {
				var Status = 'Active'
			} else {
				var Status = 'Inactive'
			}

			htmlTable = htmlTable + "<tr id='"+dataList[i].templateId+"'>";
			htmlTable = htmlTable + "<td style='width: 150px;'>"
					+ dataList[i].templateCode + "</td>";
			htmlTable = htmlTable + "<td style='width: 150px;'>"
					+ dataList[i].templateName + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>" + Status
					+ "</td>";
			htmlTable = htmlTable + "</tr>";

		}
		if (dataList.length == 0) {
			htmlTable = htmlTable
					+ "<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";

		}

		$j("#tblListOfTemplate").html(htmlTable);

	}

	var tempId;
	var tempCode
	var tempName;
	var tempstatus;

	function executeClickEvent(id, data) {

		for (j = 0; j < data.data.length; j++) {
			if (id == data.data[j].templateId) {
				tempId = data.data[j].templateId;
				tempCode = data.data[j].templateCode;
				tempName = data.data[j].templateName;
				tempstatus = data.data[j].status;

			}
		}
		rowClick(tempId, tempCode, tempName, tempstatus);
	}
	
function rowClick(tempId, tempCode, tempName, tempstatus){
		
		document.getElementById("templateCode").value = tempCode;
		document.getElementById("templateName").value = tempName;
			
		 
		if(tempstatus == 'Y' || tempstatus == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();						
			$j('#updateBtn').show();
			$j('#btnAddCommand').hide();
		}
		if(tempstatus == 'N' || tempstatus == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
		}
		
		
		$j('#btnAddTemplate').hide();
		$j("#btnActive").attr("disabled", false);
		 $j("#btnInActive").attr("disabled", false);
		 $j('#templateCode').attr('readonly', true);
		
	}

	function searchTemplateList() {
		if (document.getElementById('searchTemplate').value == ""
				|| document.getElementById('searchTemplate') == null) {
			alert("Plese Enter the Application Name");
			return false;
		}

		var templateName = jQuery("#searchTemplate").attr("checked", true).val().toUpperCase();

		var nPageNo = 1;
		var url = "getAllTemplate";
		var data = {"PN" : nPageNo, "templateName" : templateName};
		var bClickable = true;
		GetJsonData('tblListOfTemplate', data, url, bClickable);
		Reset();
	}
	
	function addTemplate(){
		if(document.getElementById('templateCode').value==""){
			alert("Please Enter Template Code");
			return false;
		}
		if(document.getElementById('templateName').value==""){
			alert("Please Enter Template Name");
			return false;
		}
		$j('#btnAddTemplate').prop("disabled",true);
		var params = {
				 'templateCode':jQuery('#templateCode').val().toUpperCase(),
				 'templateName':jQuery('#templateName').val().toUpperCase(),
				 'hospitalId':<%=hospitalId%>,
				 'userId':<%=userId%>		 				 
			}
		
		jQuery.ajax({			
			    method: "POST",			    
			    url: "addTemplate",
			    data: JSON.stringify(params),
			    contentType: "application/json; charset=utf-8",
			    dataType: "json",
			    success: function(result){
			    	$j('#btnAddTemplate').prop("disabled",false); 
			        if(result.status==1){			        	
			        	showAll('ALL')
			        	alert(result.msg+'S');
			        	//document.getElementById("messageId").innerHTML = result.msg;	        	
			        }
			        if(result.status==2){			        	
			        	showAll('ALL')
			        	alert(result.msg+'S');
			        	//document.getElementById("messageId").innerHTML = result.msg;	        	
			        }
			        if(result.status==0){			        	
			        	showAll('ALL')
			        	alert(result.msg+'S');
			        	//document.getElementById("messageId").innerHTML = result.msg;
			        }
			    }
			    
			    
			});
		
		Reset();
	}
		
	
	var userId =  $j('#userId').val();
	function updateTemplate(status){
				
		var params = {
				 'templateId':tempId,
				 'templateCode':jQuery('#templateCode').val(),
				 'templateName':jQuery('#templateName').val(),
				 'status':status,
				 'userId':<%=userId%>
				 
			} 
		var url="updateTemplate";
		SendJsonData(url,params);
		
		if(status == 'active'){
			$j("#updateBtn").show();
		}
		if(status == 'inactive'){
			$j("#updateBtn").hide();
		}
		if(status == 'update'){
			$j("#updateBtn").hide();
		}
		Reset();
	}

	function ResetForm() {
		$j('#templateCode').val('');
		$j('#templateName').val('');
		$j('#searchTemplate').val('');
		 $j('#templateCode').attr('readonly', false);
         
	}
	function showAll() {
		ResetForm();
		nPageNo = 1;
		GetAllTemplate('ALL');

	}

	function showResultPage(pageNo) {
		nPageNo = pageNo;
		GetAllTemplate('FILTER');

	}
	function Reset(){
				
		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddTemplate').show();
		showAll();
	}
	
	function search()
	{
		if(document.getElementById('searchTemplate').value == ""){
			alert("Please Enter Template Name");
			return false;
		}
		nPageNo=1;
		GetAllTemplate('Filter');
	}
</script>

</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">

		

		<!-- ========== Left Sidebar Start ========== -->

		<!-- Left Sidebar End -->

		<!-- ============================================================== -->
		<!-- Start right Content here -->
		<!-- ============================================================== -->
		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
				<div class="internal_Htext">Manage Template</div>
					<div class="row">
						<div class="col-12">
							
						</div>
					</div>
					<!-- end row -->

					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
								
								
								
									<p align="center" id="messageId"
										style="color: green; font-weight: bold;"></p>
								 
									
							<form class="form-horizontal" id="searchTemplateForm"
												name="searchTemplateForm" method="" role="form">
												<input type="hidden" class="form-control" id="userId"
											   name="userId"  value="<%=session.getAttribute("user_id")%>">
								  <div class="row"> 
										     <div class="col-md-4">
													<div class="form-group row">
														<label class="col-md-5 col-form-label">Template Name<span class="mandate"><sup>&#9733;</sup></span>
														</label>
														<div class="col-md-7">
															<input type="text" name="searchTemplate"	id="searchTemplate" class="form-control"
																		id="inlineFormInputGroup"		placeholder="Template Name">
														</div>
													</div>
												</div>
											
									
									        <div class="col-md-1">
												<button id="searchBtn" type="button" class="btn  btn-primary"
															onclick="search();">Search</button>
											</div>
											
								 
											
											
											<div class="col-md-7">
											<div class="btn-right-all">
													<button type="button"
														class="btn  btn-primary "
														onclick="showAll('ALL');">Show All</button>

												</div>
												 
											</div>
									</div>									
							</form>
									
									
									
									

									 <div class="row">
										<div class="col-sm-12">
											<nav aria-label="Page navigation example">
												
											</nav>
										</div>
									</div> 

									<!-- <table class="table table-striped table-hover jambo_table"> -->
									<div style="float:left">					           
		                                    <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >			<tr>
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

									<table class="table table-striped table-hover table-bordered" id="table">
										<thead class="bg-success" style="color: #fff;">
											<tr>
												<th id="th2" class="inner_md_htext">Template Code</th>
												<th id="th3" class="inner_md_htext">Template Name</th>
												<th id="th4" class="inner_md_htext">Status</th>
											</tr>
										</thead>
										<tbody class="clickableRow" id="tblListOfTemplate">

										</tbody>
									</table>

									<div class="row">
										<div class="col-md-12">
											<form id="addTemplateForm" name="addTemplateForm"
												action="" method="POST">
												<div class="row">
													<div class="col-md-4">
														<div class="form-group row">
															<div class="col-sm-5">
																<label for=""
																	class=" col-form-label inner_md_htext">Template 
																	Code<span class="mandate"><sup>&#9733;</sup></span></label>
															</div>
															<div class="col-sm-7">
																<input type="text" name="templateCode"
																	id="templateCode" class="form-control"
																	placeholder="Template Code"
																	onkeypress="return validateText('templateCode', 7);">
															</div>
														</div>
													</div>
													<div class="col-md-4">
														<div class="form-group row">
															<div class="col-sm-5">
																<label for="service" 
																	class="col-form-label inner_md_htext">Template Name<span class="mandate"><sup>&#9733;</sup></span></label>
															</div>
															<div class="col-sm-7">
																<input type="text" name="templateName"
																	id="templateName" class="form-control"
																	placeholder="Template Name"
																	onkeypress="return validateTextField('templateName', 30)">
															</div>
														</div>
													</div>

												</div>
											</form>
										</div>

									</div>
									
									
								      <div class="clearfix"></div>								
								       
										<div class="row">		 
										 <div class="col-md-12">
															<div class="btn-left-all">																 
															</div> 
															<div class="btn-right-all">
															 
				
																	<button id="btnAddTemplate" type="button"
																		class="btn btn-primary "
																		onclick="addTemplate();">Add</button>
																	<button id="updateBtn" type="button"
																		class="btn btn-primary"
																		onclick="updateTemplate('update');">Update</button>
																	<button id="btnActive" type="button"
																		class="btn btn-primary "
																		onclick="updateTemplate('active');">Activate</button>
																	<button id="btnInActive" type="button"
																		class="btn btn-primary"
																		onclick="updateTemplate('inactive');">Deactivate</button>
																	<button type="button"
																		class="btn btn-danger"
																		onclick="Reset();">Reset</button>
				 
																 
															</div> 
													   </div> 
										</div>
								 
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