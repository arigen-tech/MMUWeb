<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.mmu.web.utils.HMSUtil"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Physical Stock Taking</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<%@include file="..//view/leftMenu.jsp"%>
<%@include file="..//view/commonJavaScript.jsp"%>
<script src="${pageContext.request.contextPath}/resources/js/stores.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
</head>
<%
		//long departmentId = 0;
		String departmentName="";
	  String departmentId = HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim();
	  /*  if (session.getAttribute("department_id") != null) {
	   departmentId = Long.parseLong(session.getAttribute("department_id").toString());
	  } */
	  
	  
	  	  String cityId = "0";
		if (session.getAttribute("cityIdUsers") != null) {
			cityId = session.getAttribute("cityIdUsers").toString();
			cityId = cityId.replace(",","");
		}
		
	  String districtId = "0";
		if (session.getAttribute("distIdUsers") != null) {
			districtId = session.getAttribute("distIdUsers").toString();
			districtId = districtId.replace(",","");
		}
		
	  %>	
<script>


$j(document).ready(function() {

});



</script>  
<body>

	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">Physical Stock Taking/Stock Adjustment</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
								<form id='stockTakingForm' name='stockTakingForm'>

									<div class="table-responsive">
									<table class="table table-stripped table-hover table-bordered table-compressed" id="tblStockTaking">
										<thead class="bg-primary">
											<tr id="th">
												<th>S.No.</th>
												<th>Drug Code</th>
												<th>Drug Name</th>
												<th>Batch No.</th>
												<th>DOE</th>
												<th>Computed Stock</th>
												<th>Physical Stock</th>
												<th>Surplus</th>
												<th>Deficient</th>
												<th>Remarks</th>
												<th>Add</th>
												<th>Delete</th>
											</tr>
										</thead>
										<tbody>
										<%int inc=1; %>
											<tr id="<%=inc%>">
												<td><%=inc%></td>
												<td>
													<div class="autocomplete forTableResp width150">
													   <input type="text" autocomplete="off" class=" form-control border-input" name="pvmsNumber" id="pvmsNumberId<%=inc %>"  onKeyUp="getNomenClatureList(this,'fillItemAndValuesFromAutoCompleteForStockTaking','store','getItemListForAutoComplete','store_adj_pvms')" validate="Drug Code or Drug Name,string,yes"/>
													   <div id="divPvms1" class="autocomplete-itemsNew"></div>
												</div>
												</td>
												<td>
													<div class="autocomplete forTableResp width250">
													   <input type="text" autocomplete="off" class=" form-control border-input" name="nomenclature" id="nomenclturId<%=inc %>"  onKeyUp="getNomenClatureList(this,'fillItemAndValuesFromAutoCompleteForStockTaking','store','getItemListForAutoComplete','store_adj_nomen')" validate="Drug Code or Drug Name,string,yes"/>
													   <div id="divNomen1" class="autocomplete-itemsNew"></div>
													</div>
												</td>
												<td>
													<select id="batchNumberId<%=inc%>" name="batchNumberId" onchange="setValue(this.value,<%=inc %>)" class="form-control border-input width90" validate="Batch No.,string,yes">
															<option value="0" selected="selected">Select</option>
													</select>
													
												<input  type="hidden" class="form-control border-input" name="batchNumber" id="batchNumber<%=inc %>" />
												</td>
												<td>
													<div class="dateHolder">
													<input readonly type="text" class="input_date datePickerInput form-control width90" name="doeDate" id="doeDate<%=inc %>" placeholder="DD/MM/YYYY" />
													</div>
												</td>
												<td>
													<input readonly type="text" class="form-control border-input width60" name="computedStock" id="computedStock<%=inc %>" validate="Computed Stock.,number,yes"/>
												</td>
												<td>
													<input  type="text" class="form-control border-input width60" name="physicalStock" id="physicalStock<%=inc %>" onchange="calculateDiff(<%=inc %>)" onkeypress="if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;" onkeydown="if(event.key==='.'){event.preventDefault();}"  oninput="event.target.value = event.target.value.replace(/[^0-9]*/g,'')";/>
												</td>
												<td>
													<input readonly type="text" class="form-control border-input width60" name="surplus" id="surplus<%=inc %>" />
												</td>
												<td>
													<input readonly type="text" class="form-control border-input width60" name="deficient" id="deficient<%=inc %>" />
												</td>
												<td>
													<input  type="text" class="form-control border-input width60" name="remark" id="remark<%=inc %>" />
												</td>
												<td style="display: none;">
		                                			<input type="hidden" value="" tabindex="1"  name="item" id="itemId<%=inc %>"/>
		                                		</td>
		                                		<td style="display: none;">
		                                			<input type="hidden" value="" tabindex="1"  name="stockId" id="stockId<%=inc %>"/>
		                                		</td>
												<td>
		                                			<button type="button" class="btn btn-primary noMinWidth" id="btnAdd"  button-type="add" onclick="addRow()" ></button>
		                                		</td>
		                                		<td>
		                                			<button type="button" class="btn btn-danger noMinWidth" id="btnDelete" button-type="delete" onclick="removeGridRow(this)" ></button>
		                                		</td>
											</tr>
											
										</tbody>
									</table>
									</div>
									   
									   <div class="row">	
											<div class="col-md-4">
												<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Reason for Stock Taking<span class="text-red">*</span></label>
													</div>
													<div class="col-md-7">
														<textarea rows="2" class="form-control" id="txtReason" name="txtReason" validate="Reason for stock taking,string,yes"></textarea>
													</div>
												</div>
											</div>

										</div>
										
									   <div class="col-md-4">
	                                
										<input type="hidden" name="count" id="counter" value="<%=inc%>" />
										
										<input type="hidden" class="form-control" id="userId"
											   name="userId"  value="<%=session.getAttribute("user_id")%>">
																	
										<input type="hidden" class="form-control" id="mmuId"
											   name="mmuId"  value="<%=session.getAttribute("mmuId")%>"> 
											   
										<input type="hidden" class="form-control" id="cityId"
											   name="cityId"  value="<%= cityId %>"> 
											   
										<input type="hidden" class="form-control" id="districtId"
											   name="districtId"  value="<%= districtId %>"> 
											   
										<input  type="hidden" class="form-control"
											id="departmentId" name="department" value="<%=departmentId%>"/>
											
									</div>
							         
										<div class="row">
											<div class="col-md-12 text-right">
												<button type="button" id="btnSubmit" class="btn btn-primary" onclick="updateStock()">Submit</button>
												<button type="reset" name="Reset" id="reset"  class="btn btn-danger" accesskey="r" onclick="resetData()">Reset</button>
											</div>
										</div>
									</form>
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
	 
	 function addRow(){
		var tbl = document.getElementById('tblStockTaking');
		var lastRow = tbl.rows.length;
		var iteration = lastRow;
		var row = tbl.insertRow(lastRow);
		var hdb = document.getElementById('counter');
		var prevCnt = hdb.value;
		var iteration = parseInt(hdb.value) + 1;
		hdb.value = iteration;
		
		row.id=iteration;
		row.name=iteration;

		
		var cell0 = row.insertCell(0);
		var e0 = document.createElement('span');
		e0.textContent = (iteration);
		cell0.appendChild(e0);
		
		var newdivpsvn = document.createElement('div');
		newdivpsvn.className = "autocomplete forTableResp  width150";
		
		var newdivpsvnSub = document.createElement('div');
		newdivpsvnSub.id='divPvms'+ (iteration);
		newdivpsvnSub.className = "autocomplete-itemsNew";
		
		var cell1 = row.insertCell(1);
		var e1 = document.createElement('input');
		e1.type = 'text';
		e1.className=' form-control border-input';
		e1.name = 'pvmsNumber';
		e1.id = 'pvmsNumberId' + (iteration);
		e1.setAttribute('validate','Drug Code or Drug Name,string,yes');
		e1.size = '10';
		e1.autocomplete = 'off';
		e1.onkeyup = function() {
			getNomenClatureList(this,'fillItemAndValuesFromAutoCompleteForStockTaking','store','getItemListForAutoComplete','store_adj_pvms')
		};
		
		cell1.appendChild(e1);
		newdivpsvn.appendChild(e1);
		newdivpsvn.appendChild(newdivpsvnSub);
		cell1.appendChild(newdivpsvn);
		
		

		var newdivnomen = document.createElement('div');
		newdivnomen.className = "autocomplete  forTableResp width250";
		
		var newdivnomenSub = document.createElement('div');
		newdivnomenSub.id='divNomen'+ (iteration);
		newdivnomenSub.className = "autocomplete-itemsNew";
		
		var cell2 = row.insertCell(2);
		var e2 = document.createElement('input');
		e2.type = 'text';
		e2.className=' form-control border-input';
		e2.name = 'nomenclature';
		e2.id = 'nomenclturId' + (iteration);
		e2.setAttribute('validate','Drug Code or Drug Name,string,yes');
		e2.tabIndex = "1";
		e2.size = '30';
		e2.autocomplete = 'off';
		e2.onkeyup = function() {
			getNomenClatureList(this,'fillItemAndValuesFromAutoCompleteForStockTaking','store','getItemListForAutoComplete','store_adj_nomen')
		};
		
		cell2.appendChild(e2);
		newdivnomen.appendChild(e2)
		newdivnomen.appendChild(newdivnomenSub);
		cell2.appendChild(newdivnomen);

		

		var cell3 = row.insertCell(3);
		var e3 = document.createElement('select');
		e3.className='form-control border-input width90'
		e3.name = 'batchNumberId';
		e3.id = 'batchNumberId' + (iteration);
		e3.setAttribute('validate','Batch No.,string,yes');
		e3.options[0] = new Option('Select', '0');
		e3.tabIndex = "1";
		e3.onchange=function(){setValue(this.value,iteration)};
		cell3.appendChild(e3);

		
		var cell4 = row.insertCell(4);
		var e4 = document.createElement('input');
		e4.type = 'text';
		e4.readOnly=true;
		e4.className='form-control border-input width90'
		e4.name = 'doeDate';
		e4.id = 'doeDate' + (iteration);
		e4.tabIndex = "1";
		e4.size = '30';
		e4.autocomplete = 'off';
		cell4.appendChild(e4);

		
		var cell5 = row.insertCell(5);
		var e5 = document.createElement('input');
		e5.type = 'text';
		e5.readOnly=true;
		e5.className='form-control border-input width60';
		e5.name = 'computedStock';
		e5.id = 'computedStock' + (iteration);
		e5.setAttribute('validate','Computed stock,string,yes');
		e5.tabIndex = "1";
		e5.size = '30';
		cell5.appendChild(e5);
		
		
		
		var cell6 = row.insertCell(6);
		var e6 = document.createElement('input');
		e6.type = 'text';
		e6.className='form-control border-input width60';
		e6.name = 'physicalStock';
		e6.id = 'physicalStock' + (iteration);
		//e6.onkeypress= allowNumerOnly();
		e6.onkeypress = function(){
			if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;
		}
		e6.onkeydown = function(){
			if(event.key==='.'){event.preventDefault();}
		}
		e6.oninput = function(){
			event.target.value = event.target.value.replace(/[^0-9]*/g,'');
		}
		//e6.setAttribute('validate','Physical Stock,number,yes');
		e6.tabIndex = "1";
		e6.size = '30';
		e6.onchange=function(){calculateDiff(iteration)};
		cell6.appendChild(e6);
		
		
		
		var cell7 = row.insertCell(7);
		var e7 = document.createElement('input');
		e7.type = 'text';
		e7.readOnly=true;
		e7.className='form-control border-input width60'
		e7.name = 'surplus';
		e7.id = 'surplus' + (iteration);
		e7.tabIndex = "1";
		e7.size = '30';
		e7.autocomplete = 'off';
		cell7.appendChild(e7);
		
		
		var cell8 = row.insertCell(8);
		var e8 = document.createElement('input');
		e8.type = 'text';
		e8.readOnly=true;
		e8.className='form-control border-input width60'
		e8.name = 'deficient';
		e8.id = 'deficient' + (iteration);
		e8.tabIndex = "1";
		e8.size = '30';
		e8.autocomplete = 'off';
		cell8.appendChild(e8);
		
		
		var cell9 = row.insertCell(9);
		var e9 = document.createElement('input');
		e9.type = 'text';
		e9.className='form-control border-input width60'
		e9.name = 'remark';
		e9.id = 'remark' + (iteration);
		e9.tabIndex = "1";
		e9.size = '30';
		e9.autocomplete = 'off';
		cell9.appendChild(e9);
		
		
		var cell10 = row.insertCell(10);
		var e10 = document.createElement('button');
		e10.type = 'button';
		e10.className='btn btn-primary noMinWidth';
		e10.setAttribute('button-type','add');
		e10.setAttribute('onclick','addRow()');
		cell10.appendChild(e10);
		
		
		var cell11 = row.insertCell(11);
		var e11 = document.createElement('button');
		e11.type = 'button';
		e11.className='btn btn-danger noMinWidth';
		e11.setAttribute('button-type','delete');
		e11.setAttribute('onclick',"removeGridRow(this)");
		cell11.appendChild(e11);
		
		
		var cell12 = row.insertCell(12);
		cell12.style.display = 'none';
		var e12 = document.createElement('input');
		e12.type = 'hidden';
		e12.name = 'item';
		e12.id = 'itemId' + (iteration);
		cell12.appendChild(e12);
		
		
		var cell13 = row.insertCell(13);
		cell13.style.display = 'none';
		var e13 = document.createElement('input');
		e13.type = 'hidden';
		e13.name = 'stockId';
		e13.id = 'stockId' + (iteration);
		cell13.appendChild(e13);
		
		var cell14 = row.insertCell(14);
		cell14.style.display = 'none';
		var e14 = document.createElement('input');
		e14.type = 'hidden';
		e14.name = 'batchNumber';
		e14.id = 'batchNumber' + (iteration);
		cell14.appendChild(e14);

	}
	
	 function allowNumerOnly(){
		 alert("ok");
	 }
	
	 function removeGridRow(val) {
			if ($('#tblStockTaking tr[id!="th"]').length > 1) {
				$(val).closest('tr').remove();
			}else{
				alert("Can not delete all rows");
			}
		} 
	 
	 
	 
	 function updateStock(){
		 var flag = false;
		 $('table > tbody  > tr').each(function(index, tr) { 
			  var stockQty = $(tr).find('td').eq(6).find(":input").val();
			  console.log("qty **************** "+stockQty);
			  if(stockQty == ''){
				  alert("Please enter physical stock qty");
				  flag = true;
				  return false;
			  }
			});
		 if(flag){
			 return;
		 }
		 var value=validateFields("stockTakingForm");
			if(checkDepartment() && value==true){
				 document.stockTakingForm.action="updatePhysicalStockTaking";
				 document.stockTakingForm.method="POST";
				 document.stockTakingForm.submit();
			}else{
				alert(value.split('\n')[0]);
			}
		
	 }
	 
	 function checkDepartment(){
		if($('#departmentId').val()==0){
			alert("Please select department");
			return false;
		}else{
			return true;
		}
	 }
	 
	 var batchList='';
	 var batchData = '';
	 function fillItemAndValuesFromAutoCompleteForStockTaking(item, psvn_nomen) {
		 var itemId='';
		 var pvmsNo='';
		 var nomenclturId='';
		 var count = item.substring(12); // this code commonly use for pvmsNumberId/nomenclturId input 
			 if(psvn_nomen!=""){
				var index1 = psvn_nomen.lastIndexOf("[");
				var index2 = psvn_nomen.lastIndexOf("]");
				index1++;
			 
				if(item.includes('pvmsNumberId')){
					pvmsNo=psvn_nomen;
				}else if(item.includes('nomenclturId')){
					itemId = psvn_nomen.substring(index1, index2);
				}
				var cityId = $('#cityId').val();
				var districtId = $('#districtId').val();
				var mmuId = $('#mmuId').val();
				var mmuId = $('#mmuId').val();
				var mmuId = $('#mmuId').val();
				var departmentId = $('#departmentId').val();
				if(itemId!="" || pvmsNo!=""){
					var params = {
							"itemId" : itemId,
							"pvmsNo" : pvmsNo,
							"mmuId" : mmuId,
							"nomenclturId" : nomenclturId
							
						}
					$.ajax({
						type : "POST",
						contentType : "application/json",
						url : 'getItemListForAutoComplete',
						data : JSON.stringify(params),
						dataType : "json",
						cache : false,
						success : function(response) {
							if (response.status == "1") {
								var itemValueList = response.storeItemList;
								var itemIdNew ='';
								for (i = 0; i < itemValueList.length; i++) {
										itemIdNew= itemValueList[i].itemId;
										 $('#itemId' + count).val(itemValueList[i].itemId);
										 $('#nomenclturId' + count).val(itemValueList[i].nomenclature + "[" + itemIdNew + "]");
										 $('#pvmsNumberId' + count).val(itemValueList[i].pvmsNumber);
										 
									}
								
								var paramsNew = {
										"mmuId" : mmuId,
										"cityId":cityId,
										"districtId":districtId,
										"department_id" : departmentId,
										"item_id" : itemIdNew,
										"stockAdjustFlag": "p"
									}
								$.ajax({
									type : "POST",
									contentType : "application/json",
									url : 'getItemStockDetailsFromStore',
									data : JSON.stringify(paramsNew),
									dataType : "json",
									cache : false,
									success : function(response) {
										
										document.getElementById("batchNumberId"+count).options.length = 1;
										document.getElementById("doeDate"+count).value = '';
										document.getElementById("computedStock"+count).value = '';
										document.getElementById("physicalStock"+count).value ='';
										document.getElementById("surplus"+count).value ='';
										document.getElementById("deficient"+count).value ='';
										document.getElementById("remark"+count).value ='';
										
										var html='';
										batchList = response.batchData.batch_list; 
										if (batchList.length>0) {
											for (i = 0; i < batchList.length; i++) {
												html += '<option value="'+batchList[i].id+'">'
												+ batchList[i].batch_no + '</option>';	
											}
											$('#batchNumberId'+count).append(html);
										}else{
											alert("Item is not available in stock.");
											document.getElementById("nomenclturId"+count).value = '';
											document.getElementById("pvmsNumberId"+count).value = '';
											document.getElementById("itemId"+count).value = '';
										}
										
										
									},
									error : function(msg) {
										alert("An error has occurred while contacting the server");
									}
								});
							} 
						},
						error : function(msg) {
							alert("An error has occurred while contacting the server");
						}
					});
				}
		}else{
			// psvn_nomen is blank
			document.getElementById("nomenclturId"+count).value = '';
			document.getElementById("pvmsNumberId"+count).value = '';
			document.getElementById("itemId"+count).value = '';
			document.getElementById("batchNumberId"+count).options.length = 1;
			document.getElementById("doeDate"+count).value = '';
			document.getElementById("computedStock"+count).value = '';
			document.getElementById("physicalStock"+count).value ='';
			document.getElementById("surplus"+count).value ='';
			document.getElementById("deficient"+count).value ='';
			document.getElementById("remark"+count).value ='';
		}
	}

</script>

</body>
</html>