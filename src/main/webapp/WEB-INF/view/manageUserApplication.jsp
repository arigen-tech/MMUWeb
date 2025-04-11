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
	nPageNo = 1;
	var $j = jQuery.noConflict();
	<% 
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	%>
	$j(document).ready(function() {
		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').attr("disabled", true);
		$j('#updateBtn').hide();

		GetAllUserApplication('ALL');
	});

	function GetAllUserApplication(MODE) {

		var applicationName= jQuery("#searchApplication").val();//attr("checked", true).val().toUpperCase();
		var id = 0;
		if (MODE == 'ALL') {
			var data = {"PN" : nPageNo, "appName":""};
		} else {
			var data = {"PN" : nPageNo, "appName":applicationName};
		}
		var url = "getAllUserApplication";
		var bClickable = true;
		GetJsonData('tblListOfApplication', data, url, bClickable);
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

			htmlTable = htmlTable + "<tr id='"+dataList[i].id+"' >";
			htmlTable = htmlTable + "<td style='width: 150px;'>"
					+ dataList[i].appName + "</td>";
			htmlTable = htmlTable + "<td style='width: 150px;'>"
					+ dataList[i].url + "</td>";
			htmlTable = htmlTable + "<td style='width: 100px;'>" + Status
					+ "</td>";
			htmlTable = htmlTable + "</tr>";

		}
		if (dataList.length == 0) {
			htmlTable = htmlTable
					+ "<tr ><td colspan='4'><h6>No Record Found</h6></td></tr>";

		}

		$j("#tblListOfApplication").html(htmlTable);

	}

	var appId;
	var appName;
	var appUrl;
	var appstatus;

	function executeClickEvent(id, data) {

		for (j = 0; j < data.data.length; j++) {
			if (id == data.data[j].id) {
				appId = data.data[j].id;
				appName = data.data[j].appName;
				appUrl = data.data[j].url;
				appstatus = data.data[j].status;

			}
		}
		rowClick(appId, appName, appUrl, appstatus);
	}
	
	function rowClick(appId,appName,appUrl,appstatus){	
		
		document.getElementById("applicationName").value = appName;
		document.getElementById("applicationUrl").value = appUrl;
			
		 
		if(appstatus == 'Y' || appstatus == 'y'){		
			$j("#btnInActive").show();
			$j("#btnActive").hide();
			$j('#updateBtn').attr("disabled", false);			
			$j('#updateBtn').show();
			$j('#btnAddApplication').hide();
		}
		if(appstatus == 'N' || appstatus == 'n'){
			$j("#btnActive").show();
			$j("#btnInActive").hide();
			$j('#updateBtn').hide();
		}
		
		
		$j('#btnAddApplication').hide();
		$j("#btnActive").attr("disabled", false);
		 $j("#btnInActive").attr("disabled", false);
		
	}

	function searchApplicationList() {
		if (document.getElementById('searchApplication').value == ""
				|| document.getElementById('searchApplication') == null) {
			alert("Plese Enter the Menu Name");
			return false;
		}

		var applicationName = jQuery("#searchApplication")
				.attr("checked", true).val().toUpperCase();

		var nPageNo = 1;
		var url = "getAllUserApplication";
		var data = {
			"PN" : nPageNo,
			"appName" : applicationName
		};
		var bClickable = true;
		GetJsonData('tblListOfApplication', data, url, bClickable);
		ResetForm();
	}
	
	function addUserApplication(){
		
		if(document.getElementById('applicationName').value==""){
			alert("Please Enter the Menu Name");
			return false;
		}
		if(document.getElementById('applicationUrl').value==""){
			alert("Please Enter the URL");
			return false;
		}
		$j('#btnAddApplication').prop("disabled",true);
		var params = {
				 'appName':jQuery('#applicationName').val(),
				 'url':jQuery('#applicationUrl').val(),
				 'userId':<%=userId%>
			} 
		//alert("params add: "+JSON.stringify(params));
		var url="addUserApplication";
		
		SendJsonData(url,params);
		
		Reset();
	}
	
	function updateUserApplication(status){
		
		if ($('#applicationName').val() == ""){
            alert('Please Enter the Menu Name');
            return false;
        }
		
		if ($('#applicationUrl').val() == ""){
            alert('Please Enter the Url');
            return false;
        } 
		
		var params = {
				 'id':appId,
				 'appName':jQuery('#applicationName').val(),
				 'url':jQuery('#applicationUrl').val(),
				 'status':status
				 
			} 
		
	var url="updateUserApplication";		
		SendJsonData(url,params);
		
		Reset();
	}

	function ResetForm() {
		$j('#applicationName').val('');
		$j('#applicationUrl').val('');
		$j('#searchApplication').val('');

	}
	function showAll() {
		ResetForm();
		nPageNo = 1;
		GetAllUserApplication('ALL');

	}

	function showResultPage(pageNo) {
		nPageNo = pageNo;
		GetAllUserApplication('FILTER');

	}
	
	function Reset(){
		document.getElementById("searchManageUserApplicationForm").reset();
		document.getElementById("addApplicationForm").reset();
		
		$j("#btnActive").hide();
		$j("#btnInActive").hide();
		$j('#updateBtn').hide();
		$j('#btnAddApplication').show();
		
		showAll();
	}
	
	function search()
	{
		if(document.getElementById('searchApplication').value == ""){
			alert("Please Enter Menu Name");
			return false;
		}
		nPageNo=1;
		GetAllUserApplication('Filter');
	}
	function validateUrlField(id,length){
		
		if($j("#"+id).val().length >= length){
			 alert("Length of "+id+" should be less than "+length);
			 
			 var str=  $j("#"+id).val();
			 str=str.substring(0,length).trim();
			 
			 $j("#"+id).val(str);
			 return false;
		 }		
	}
		
	function validateTextField(){
		if ($('#applicationName').val() == ""){
            alert('Please Enter the Application Name');
            return false;
        }
		
		if ($('#applicationUrl').val() == ""){
            alert('Please Enter the Url');
            return false;
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
				<div class="internal_Htext">Manage Menu</div>
					<div class="row">
						
					</div>
					<!-- end row -->

					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<p align="center" id="messageId"
										style="color: green; font-weight: bold;"></p>
									
									<div class="row">

										<div class="col-md-8">
											<form class="form-horizontal" id="searchManageUserApplicationForm"
												name="searchManageUserApplicationForm" method="" role="form">
												<input type="hidden" class="form-control" id="userId"
											   name="userId"  value="<%=session.getAttribute("user_id")%>">
												<div class="form-group row">
													<label class="col-3 col-form-label inner_md_htext">Menu Name
														<span class="mandate"><sup>&#9733;</sup></span>
													</label>
													<div class="col-5">
														<div class="col-auto">

															<div class="input-group mb-2">

																<input type="text" name="searchApplication"
																	id="searchApplication" class="form-control"
																	id="inlineFormInputGroup"
																	placeholder="Menu Name">
															</div>
														</div>
													</div>
													<div class="col-2">
														<button id="searchBtn" type="button"
															class="btn  btn-primary   manageUser-search"
															onclick="search();">Search</button>
													</div>
												</div>
											</form>

										</div>




										<div class="col-md-4">
											 
												<div class="btn-right-all">
													<button type="button"
														class="btn  btn-primary"
														onclick="showAll('ALL');">Show All</button>

												</div>
											 
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

									<table class="table table-hover table-striped table-bordered">
										<thead class="bg-success" style="color: #fff;">
											<tr>
												<th id="th2" class="inner_md_htext">Menu Name</th>
												<th id="th3" class="inner_md_htext">URL</th>
												<th id="th4" class="inner_md_htext">Status</th>
											</tr>
										</thead>
										<tbody class="clickableRow" id="tblListOfApplication">

										</tbody>
									</table>

									<div class="row">
										<div class="col-md-12">
											<form id="addApplicationForm" name="addApplicationForm"
												action="" method="POST">
												<div class="row">
													<div class="col-md-4">
														<div class="form-group row">
															<div class="col-sm-5">
																<label for="Command Code"
																	class=" col-form-label inner_md_htext">Menu Name</label>
															</div>
															<div class="col-sm-7">
																<input type="text" name="applicationName"
																	id="applicationName" class="form-control"
																	placeholder="Menu" autocomplete="off"
																	onkeypress="return validateTextForMenu('applicationName', 60, 'Menu Name');">
															</div>
														</div>
													</div>
													<div class="col-md-4">
														<div class="form-group row">
															<div class="col-sm-5">
																<label for="service"
																	class="col-form-label inner_md_htext">URL</label>
															</div>
															<div class="col-sm-7">
																<input type="text" name="applicationUrl"
																	id="applicationUrl" class="form-control"
																	placeholder="/url" autocomplete="off"
																	onkeypress="return validateTextForURL('applicationUrl', 199, 'Url');">
															</div>
														</div>
													</div>

												</div>
											</form>
										</div>

									</div>
									<br>
									<div class="row">
										<div class="col-md-7"></div>
										<div class="col-md-5">
											 
												<div class="btn-right-all">

													<button id="btnAddApplication" type="button"
														class="btn btn-primary"
														onclick="addUserApplication();">Add</button>
													<button id="updateBtn" type="button"
														class="btn btn-primary"
														onclick="updateUserApplication('update');">Update</button>
													<button id="btnActive" type="button"
														class="btn btn-primary"
														onclick="updateUserApplication('active');">Activate</button>
													<button id="btnInActive" type="button"
														class="btn btn-primary"
														onclick="updateUserApplication('inactive');">Deactivate</button>
													<button type="button"
														class="btn btn-danger"
														onclick="Reset();">Reset</button>

												</div>
										 
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