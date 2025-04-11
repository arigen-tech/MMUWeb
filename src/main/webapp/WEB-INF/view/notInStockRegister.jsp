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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
<script type="text/javascript">

	var $j = jQuery.noConflict();
	
	<% 
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}

	String levelOfUser = "1";
	if (session.getAttribute("levelOfUser") != null) {
		levelOfUser = session.getAttribute("levelOfUser") + "";
	}

	String mmuId = "1";
	if (session.getAttribute("mmuId") != null) {
		mmuId = session.getAttribute("mmuId") + "";
	}
	%>
	
	$j(document).ready(function()
			{
	          
			$j("#fromDate").val(currentDate);
			$j("#toDate").val(currentDate);
			
			getMMUList();
			
			});
		
	
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
					   $('#mmuId').attr('disabled', true);
					   for(i=0;i<data.mmuList.length;i++){
							mmuDrop += '<option value='+data.mmuList[i].mmu_id+' selected>'+data.mmuList[i].mmu_name+'</option>';
							
						}
						$j('#mmuId').append(mmuDrop);
					   <%-- document.getElementById('mmuId').value = <%=mmuId%>;  --%>
				   }
				   else{
					for(i=0;i<data.mmuList.length;i++){
						mmuDrop += '<option value='+data.mmuList[i].mmu_id+'>'+data.mmuList[i].mmu_name+'</option>';
						
					}
					$j('#mmuId').append(mmuDrop);
				  }
			},
			error : function(data) {
				alert("An error has occurred while contacting the server");
			}
		}); 
 	}
	   
	
		function currentDate(){
			 
		    var currentDate="";
			var now = new Date();
		   	now.setDate(now.getDate());
		   	var day = ("0" + now.getDate()).slice(-2);
		   	var month = ("0" + (now.getMonth() + 1)).slice(-2);
		   	var today = (day)+"/"+(month)+"/"+now.getFullYear();
		   	currentDate=today;
		   	return currentDate;
		 
	     }
		
		function compareToFromDate() {
			var fromDate = $('#fromDate').val();
			var toDate = $('#toDate').val();

			if (process(toDate) < process(fromDate)) {
				alert("To Date should not be earlier than from Date");
				$('#toDate').val("");
				return;
			}
		}
		
		
		function generateReport(){
	     	
			 var fromDate = $j("#fromDate").val();
			 var toDate = $j("#toDate").val();
			 var mmu_id = $('#mmuId').val();             
             var User_id = <%=userId%>;
             var Level_of_user = '<%=levelOfUser%>';
			 if(fromDate ==''){
				 alert("Please select From Date");
				 return false;
			 }
			 if(toDate ==''){
				 alert("Please select To Date");
				 return false;
			 }
			 var countDate=getDateComapareValue(fromDate,toDate);
		 	 if(countDate!=0){
		 		 alert("To Date should not be earlier than from Date.");
		 		 return false;
		 	 }
			 			 
	       var url = "${pageContext.request.contextPath}/report/printNotInStockRegister?fromDate="
			+ fromDate
			+ "&toDate="
			+ toDate
			+ "&mmu_id="
			+ mmu_id
			+ "&User_id="
			+ User_id
			+ "&Level_of_user="
			+ Level_of_user;
	       
	        openPdfModel(url);

	     }
		
		
		/* var nomenclatureArry = new Array();
		var pvmsNumberArry = new Array();
		var itemDataList = '';
		function getDataForStockStatusReport() {
			var hospitalId = $j('#hospitalId').val();
			var params = {
				"hospitalId" : hospitalId
			}
			$j.ajax({
				type : "POST",
				contentType : "application/json",
				url : '${pageContext.servletContext.contextPath}/stores/getDataForStockStatusReport',
				data : JSON.stringify(params),
				dataType : "json",
				cache : false,
				success : function(res) {
					if (res.status == "1") {
						itemDataList = res.storeItemList;
						for (i = 0; i < itemDataList.length; i++) {
							itemId = itemDataList[i].itemId;

							nomenclatureList = itemDataList[i].nomenclature;
							nomenclatureName = nomenclatureList + "[" + itemId
									+ "]";
							nomenclatureArry.push(nomenclatureName);

							pvmsNumberList = itemDataList[i].pvmsNumber;
							pvmsNumberArry.push(pvmsNumberList);

						}
						
						var groupValues = "";
						var groupList=res.groupList;
						for (group = 0; group < groupList.length; group++) {
							groupValues += '<option value='+groupList[group].storeGroupId+'>'
										+ groupList[group].storeGroupName
										+ '</option>';
					 }
					 $j('#group').append(groupValues); 	
						
					 
						var sectionValues = "";
						var sectionList=res.sectionList;
						for (sectionCount = 0; sectionCount < sectionList.length; sectionCount++) {
							sectionValues += '<option value='+sectionList[sectionCount].sectionId+'>'
										+ sectionList[sectionCount].sectionName
										+ '</option>';
					 }
					 $j('#section').append(sectionValues); 	
						
					} else {

						// when status is 0, there is no related data masStoreItem
					}

				},
				error : function(msg) {
					alert("An error has occurred while contacting the server");
				}
			});

		}
		
		function fillItemAndValues(item, psvn_nomen) {
			var count = item.substring(12); // this code commonly use for pvmsNumberId/nomenclturId input 
			var index1 = psvn_nomen.lastIndexOf("[");
			var index2 = psvn_nomen.lastIndexOf("]");
			index1++;
			var itemId = psvn_nomen.substring(index1, index2);
			$j("#itemId").val(itemId);
			for (var i = 0; i < itemDataList.length; i++) {
				if (psvn_nomen == itemDataList[i].pvmsNumber) {
					$('#itemId' + count).val(itemDataList[i].itemId);
					$('#pvmsNo' + count).val(itemDataList[i].pvmsNumber);
					$('#nomenclature' + count).val(itemDataList[i].nomenclature);
					

				} else if (itemId == itemDataList[i].itemId) {
					$('#itemId' + count).val(itemDataList[i].itemId);
					$('#pvmsNo' + count).val(itemDataList[i].pvmsNumber);
					$('#nomenclature' + count).val(itemDataList[i].nomenclature);
				}
			}

		}
		 */
		
		function compareToFromDate() {
			var fromDate = $('#fromdate').val();
			var toDate = $('#todate').val();

			if (process(toDate) < process(fromDate)) {
				alert("To Date should not be earlier than from Date");
				$('#todate').val("");
				return;
			}
		  }
	
</script>
</head>

<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">NIS Register</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">

									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">MMU</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="mmuId">
													<option value="0">All</option>
												</select>
											</div>
										</div>
									</div>

									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">From Date:<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" name="fromDate" id="fromDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY"   >
												</div>
											</div>
										</div>
									</div> 
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">To Date:<span class="mandate"><sup>&#9733;</sup></span></label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" name="toDate" id="toDate" class="calDate form-control" value="" placeholder="DD/MM/YYYY">
												</div>
											</div>
										</div>
									</div>						
									
									<!-- <div class="col-md-5">
											<div class="form-group row">
												<div class="col-md-3">
													<label for="service" class="col-form-label">Drug Name</label>
												</div>
												<div class="col-md-9">
													<input type="text" autocomplete="off" class="form-control" id="nomenclature" name="nomenclature" onKeyUp="getNomenClatureList(this,'fillItemAndValues','store','getDataForStockStatusReport','store_nomen')"/>
													<div id="divNomen1" class="autocomplete-itemsNew"></div>
												</div>
											</div>
										</div>
									<input type="hidden" class="form-control" id="itemId" name="itemId" value="0" /> -->
									<div class="col-lg-12 col-sm-6 text-right">
										
										<button type="button" class="btn btn-primary m-t-3" onclick="generateReport();">Generate Report</button>
										
									</div>
								</div>

							</div>
						</div>
						<!-- end card -->
					</div>
					<!-- end col -->
				</div>
				<!-- end row -->

			</div>
			<!-- container -->
			<!-- content -->
		</div>
	</div>
	<!-- END wrapper -->

	<!-- jQuery  -->


</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>
