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
<title>Mobile Medical Unit- MMSSY</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>
<style>
a {
  color: blue;
}
</style>
<script type="text/javascript">
	<%String mmuId = "0";
	if (session.getAttribute("mmuId") != null) {
		mmuId = session.getAttribute("mmuId") + "";
	
	}
	
	String userId = "0";
	if (session.getAttribute("userId") != null) {
		userId = session.getAttribute("userId") + "";
	}
	String districtId = "0";
	if (session.getAttribute("distIdUsers") != null) {
		districtId = session.getAttribute("distIdUsers") + "";
		districtId = districtId.replace(",", "");
	}
	

	%>

	var $j = jQuery.noConflict();
	
	 $j(document).ready(function()
	{	
		var data = ${response};
		getVendorNameList();
		getVendorTypeList();
		console.log("data is "+data);
		createTable(data);
		$('#poDate').val(currentDateInddmmyyyy());
	});
	 
	 function createTable(jsonData){
		 	var htmlTable = "";
			var dataList = jsonData.data;
			for (i = 0; i < dataList.length; i++) {

				htmlTable = htmlTable + "<tr>";
				htmlTable = htmlTable + '<td><div class="form-check form-check-inline cusCheck m-l-10">';
				htmlTable = htmlTable + '<input class="form-check-input spl_checkbox" type="checkbox" id="zdiagcheckbox" checked>';
				htmlTable = htmlTable + '<span class="cus-checkbtn"></span>';
				//htmlTable = htmlTable + '<label class="form-check-label" for="zdiagcheckbox">'+dataList[i].nomenclature+'</label></div></td>';
				htmlTable = htmlTable + '<label class="form-check-label" for="zdiagcheckbox"><a href="getCityWiseIndentList?itemId='+dataList[i].itemId+'">'+dataList[i].nomenclature+'['+dataList[i].pvmsNo+']</a></label></div></td>';
				/* htmlTable = htmlTable + "<td style='width: 100px;'>"
						+ dataList[i].nomenclature + "</td>"; */
				htmlTable = htmlTable + "<td style='width: 100px;'>"
						+ dataList[i].au + "</td>";
				htmlTable = htmlTable + "<td style='width: 150px;'>"
						+ dataList[i].availableQuantity + "</td>";
				htmlTable = htmlTable + "<td style='width: 100px;'>"
						+ dataList[i].requiredQty + "</td>";
				htmlTable = htmlTable + "<td style='width: 100px;'>"
						+ dataList[i].approvedQty + "</td>";
				htmlTable = htmlTable + "<td style='width: 100px;'>"
						+ "<input type='text' value='' id='poQty' name='poQty' class='form-control' onkeypress='if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;' onkeydown = 'preventDot2()' oninput = 'preventDot3()'></td>";
				htmlTable += '<td style="display: none"><input type="hidden" value="'+dataList[i].itemId+'" id="itemId"></td>';
				htmlTable = htmlTable + "<td style='width: 100px;'>"
				+ "<input type='text' value='' id='unitRate' name='unitRate' class='form-control' onkeypress='if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;'></td>";
				htmlTable = htmlTable + "</tr>";
			}

			if (dataList.length == 0) {
				htmlTable = htmlTable
						+ "<tr ><td colspan='7'><h6>No Record Found !!</h6></td></tr>";
			}

			$j("#displayItemTable").html(htmlTable);

	 }
	 
	 var itemForwardedList = [];
	 var checkSelectedItemFlag = true;
	 function submitDoItemsAndGeneratePo(item){
		 var vendorType = $('#vendorTypeId').val();
		 var vendorName = $('#vendorNameId').val();
		 var rvNotes = $('#rvNotes').val();
		 console.log("rvNotes "+rvNotes);
		 if(vendorType == ''){
			 alert("Please select vendor type");
			 return;
		 }
		 
		 if(vendorName == ''){
			 alert("Please select vendor name");
			 return;
		 }
		 var checkFlag = false;
		 $('#displayItemTable tr').each(function(i, el) {
				var $tds = $(this).find('td')
				var checkboxVal = $tds.eq(0).find(":checkbox").prop('checked');	
				console.log(checkboxVal);
				if(checkboxVal){
					checkSelectedItemFlag = false;
					var availableQty = $tds.eq(2).html();
					var requiredQty = $tds.eq(3).html();
					var approvedQty = $tds.eq(4).html();
					var poQty = $tds.eq(5).find(":input").val();
					var itemId = $tds.eq(6).find(":input").val();
					var unitRate =  $tds.eq(7).find(":input").val();
					if(poQty == ''){
						alert("Please enter PO Qty");
						checkFlag = true;
						return false;
					}
					if(unitRate == ''){
						alert("Please enter unit rate");
						checkFlag = true;
						return false;
					}
					var input = {
							"availableQty":availableQty,
							"requiredQty":requiredQty,
							"approvedQty":approvedQty,
							"poQty":poQty,
							"itemId":itemId,
							"unitRate":unitRate
					}
					itemForwardedList.push(input);
				}
				console.log(JSON.stringify(itemForwardedList));
				
		});
		 if(checkSelectedItemFlag){
				alert("Please select some item");
				return;
			}
		 if(checkFlag){
			 return;
		 }
		 var params = {
				 "list":itemForwardedList,
				 "districtId":"<%= districtId %>",
				 "userId":"<%= userId %>",
				 "vendorNameId":vendorName,
				 "vendorTypeId":vendorType,
				 "rvNotes":rvNotes
		 }
		 
		 $("#submit_btn").attr("disabled", true);
		 $(item).attr("disabled", true);	
		 $.ajax({
				type : "POST",
				contentType : "application/json",
				url : "submitDoItemsAndGeneratePo",
				data :JSON.stringify(params),
				dataType : 'json',
				timeout : 100000,
				success : function(res) {
					//alert(res.msg);
					if(res.status == true){					
						alert(res.msg+'S');
						document.addEventListener('click',function(e){
							    if(e.target && e.target.id== 'closeBtn'){
			   	   				 	window.location.reload();
							     }
						 });	
					}else{
						alert(res.msg);
						$("#submit_btn").attr("disabled", false);
						$(item).attr("disabled", false);	
					}
				},
				error : function(jqXHR, exception) {
					alert("Error occured while contacting the server");
					$("#submit_btn").attr("disabled", false);
					$(item).attr("disabled", false);	
				}
			});
		 
	 }
	 
		function preventDot2(){
			if(event.key==='.'){event.preventDefault();}
		}
		function preventDot3(){
			event.target.value = event.target.value.replace(/[^0-9]*/g,'');
		}
	 
	 function getVendorTypeList(){
		 $.ajax({
				type : "POST",
				contentType : "application/json",
				url : "getMasSupplierTypeList",
				data :JSON.stringify({}),
				dataType : 'json',
				timeout : 100000,
				success : function(res) {
					if(res.status == true){					
						var list = res.list;
						var typeDropDown = '';
						for(i=0;i<list.length;i++){
							typeDropDown += '<option value='+list[i].id+'>'+list[i].name+'</option>';
						}
						
						if(typeDropDown != ''){
							$('#vendorTypeId').append(typeDropDown);
						}
					}
				},
				error : function(jqXHR, exception) {
					alert("Error occured while contacting the server");
					$(item).attr("disabled", false);	
				}
			});
	 }
	 
	 function getVendorNameList(){
		 
		 var vendorTypeId = $('#vendorTypeId').val();
		 
		 var params = {
				 "supplierTypeId":vendorTypeId
		 }
		 
		 $.ajax({
				type : "POST",
				contentType : "application/json",
				url : "getMasSupplierListNew",
				data :JSON.stringify(params),
				dataType : 'json',
				timeout : 100000,
				success : function(res) {
					if(res.status == true){		
						$('#vendorNameId').find('option').not(':first').remove();
						var list = res.list;
						var typeDropDown = '';
						for(i=0;i<list.length;i++){
							typeDropDown += '<option value='+list[i].id+'>'+list[i].name+'</option>';
						}
						
						if(typeDropDown != ''){
							$('#vendorNameId').append(typeDropDown);
						}	
					}
				},
				error : function(jqXHR, exception) {
					alert("Error occured while contacting the server");
					$(item).attr("disabled", false);	
				}
			});
	 }
	 
	 function checkOrUncheck(chkPassport) {
	        var flag = chkPassport.checked;
	        if(flag){
	        	$(".spl_checkbox").prop( "checked", true );
	        }else{
	        	$(".spl_checkbox").prop( "checked", false );
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

				<div class="internal_Htext">Create PO</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								
								<div class="">
									<div class="clearfix">
										<!-- <div style="float: left">
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
										</div> -->

										<div class="row">

											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">Vendor Type</label>
													</div>
													<div class="col-md-7">
														<select class="form-control" id="vendorTypeId" onchange="getVendorNameList()">
															<option value="">Select</option>
														</select>
													</div>
												</div>
											</div>

											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">Vendor Name</label>
													</div>
													<div class="col-md-7">
														<select class="form-control" id="vendorNameId">
															<option value="">Select</option>
														</select>
													</div>
												</div>
											</div>
											
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">PO Date</label>
													</div>
													<div class="col-md-7">
														<input readonly type="text" class="form-control" id="poDate" name="poDate" />
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-4">
											<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">RV Notes</label>
													</div>
													<div class="col-md-7">
														<textarea name="rvNotes" tabindex="2"
															id="rvNotes" placeholder="" class="form-control" ></textarea>
													</div>
												</div>
												</div>
										</div>

										<div class="table-responsive " id="">
											<table
												class="table table-striped table-hover table-bordered " id="campTable">
												<thead class="bg-success" style="color: #fff;">
													<tr>
														<th>
															<div>
															  <input type="checkbox" id="scales" name="DrugName" onclick="checkOrUncheck(this)" checked>
															  <label for="scales">Drug Name/Drug Code</label>
															</div>
														</th>
														<th>A/U</th>
														<th>Available Quantity</th>
														<th>Required Quantity</th>
														<th>Approved Quantity</th>
														<th>PO Quantity</th>
														<th>Unit Rate</th>
													</tr>
												</thead>
												<tbody id="displayItemTable">
													<!-- <tr>
														<td>
															<div class="form-check form-check-inline cusCheck m-l-10">
																<input class="form-check-input" type="checkbox" id="zdiagcheckbox">
																<span class="cus-checkbtn"></span> 
																<label class="form-check-label" for="zdiagcheckbox">Nomenclature 1</label>
															</div>
														</td>
														<td class="width180">No</td>
														<td class="width180">100</td>
														<td class="width180">3000</td>
														<td class="width180">3000</td>														
													</tr> -->
												</tbody>
											</table>
										</div>
										
										<div class="row">
											<div class="col-md-12 m-t-10 text-right">
												<button type="button" id="submit_btn" class="btn btn-primary" onclick="submitDoItemsAndGeneratePo(this)">Submit</button>
											
											</div>
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

			</div>
			<!-- container -->
			<!-- content -->
		</div>
	</div>
	<!-- END wrapper -->

	<!-- jQuery  -->


</body>

</html>