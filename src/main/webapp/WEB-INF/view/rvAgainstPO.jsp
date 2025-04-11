<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newOpd.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opd.js"></script>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/stores.js"></script> 
<html>

<head>
<%
	String hospitalId = "1";
	if (session.getAttribute("hospital_id") != null) {
		hospitalId = session.getAttribute("hospital_id") + "";
	}
	String userId = "0";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); 

	Calendar c = Calendar.getInstance(); 
	Date currentDate1 = c.getTime();
	String currentDate=formatter.format(currentDate1); 

	//c.set(Calendar.DATE, 01);
	Date startDate1 = c.getTime();

	//c.set(Calendar.DATE, 30);
	Date enddate1 = c.getTime();
	String startDate=formatter.format(startDate1); 
	String enddate=formatter.format(enddate1); 	
	
%>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<title>Create RV against PO</title>
<!--   <link href="/AshaWeb/resources/css/stylecommon.css" rel="stylesheet" type="text/css" /> -->



</head>

<%
	String hdId = request.getParameter("id");
%>
<script>
var $j = jQuery.noConflict();
 $j(document).ready(function()
	{	
	 	var data = ${response};	
	 	console.log("data "+data);
	 	var poNo = data.poNo;
		var poDate = data.poDate;
		var vendorName = data.vendorName;
		var vendorType = data.vendorType;
		var rvNotes = data.rvNotes;
		var list = data.list;
		
		$('#poNo').val(poNo);
		$('#poDate').val(poDate);
		$('#vendorName').val(vendorName);
		$('#vendorType').val(vendorType);
		$('#rvNotes').val(rvNotes);
		$('#rvDate').val(currentDateInddmmyyyy());
		createTable(list);
		
	});
 
 	function createTable(dataList){
 		
 		var htmlTable = '';
 		for(item in dataList){
			
			  htmlTable = htmlTable + "<tr>";	
			  htmlTable = htmlTable + "<td >" + dataList[item].nomenclature + "</td>";
			  htmlTable = htmlTable + "<td >" + dataList[item].au + "</td>";
			  htmlTable = htmlTable + "<td >" + dataList[item].requiredQty + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].approvedQty + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].poQty + "</td>";
	    	  htmlTable = htmlTable + "<td ><input type='text' class='width120 form-control' id='' data-toggle='modal' data-target='#quantityModal' value="+ dataList[item].totalReceived +" readonly/></td>";
	    	  htmlTable = htmlTable + "<td ><input type='text' class='width120 form-control' id=''></td>";
	    	  htmlTable = htmlTable + "<td ><input type='text' class='width120 form-control' id=''></td>";
	    	  htmlTable = htmlTable + "<td ><input type='text' class='width120 form-control' id=''></td>";
	    	  htmlTable = htmlTable + "<td ><input type='text' class='width120 form-control' id='' onkeypress='if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;'/></td>";
	    	  htmlTable = htmlTable + "<td ><input type='text' class='width120 form-control' id='' onkeypress='if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;'/></td>";
	    	  htmlTable = htmlTable + "<td style='display:none'><input type='hidden' class='width120 form-control' name='dtId' value="+dataList[item].id+"></td>";
	    	  htmlTable = htmlTable + "<td style='display:none'><input type='hidden' class='width120 form-control' name='itemId' value="+dataList[item].itemId+"></td>";
	    	  htmlTable = htmlTable + "</tr>";
	    
	      }
		
 		if(dataList.length == 0)
		{
			htmlTable = htmlTable+"<tr ><td colspan='6'><h6>No Record Found</h6></td></tr>";
		}			
	
	$j("#rvTable").html(htmlTable);	
 	}
 	
 	
 	function createRvAgainstPo(){
 		var itemArr = [];
		 $('#rvTable tr').each(function(i, el) {
				var $tds = $(this).find('td')
					var requiredQty = $tds.eq(2).html();
					var approvedQty = $tds.eq(3).html();
					var poQty = $tds.eq(4).html();
					var batch = $tds.eq(6).find(":input").val();
					var dom = $tds.eq(7).find(":input").val();
					var doe = $tds.eq(8).find(":input").val();
					var unitRate = $tds.eq(9).find(":input").val();
					var rvQty = $tds.eq(10).find(":input").val();
					var dtId = $tds.eq(11).find(":input").val();
					var itemId = $tds.eq(12).find(":input").val();
					var input = {
							"requiredQty":requiredQty,
							"approvedQty":approvedQty,
							"poQty":poQty,
							"batch":batch,
							"dom":dom,
							"doe":doe,
							"unitRate":unitRate,
							"rvQty":rvQty,
							"dtId":dtId,
							"itemId":itemId					
					}
					itemArr.push(input);
				
		});
		 var params = {
				 "list":itemArr,
				 "userId":"<%= userId %>",
				 "vendorNameId":vendorName,
				 "vendorTypeId":vendorType,
				 "rvNotes":rvNotes,
				 "hdId":"<%= hdId %>"
		 }
		 console.log("data inpur is "+JSON.stringify(params));
		 $(item).attr("disabled", true);	
		 $.ajax({
				type : "POST",
				contentType : "application/json",
				url : "submitRvDetailAgainstPo",
				data :JSON.stringify(params),
				dataType : 'json',
				timeout : 100000,
				success : function(res) {
					//alert(res.msg);
					if(res.status == true){					
						alert(res.msg+'S');
						document.addEventListener('click',function(e){
							    if(e.target && e.target.id== 'closeBtn'){
			   	   				 	window.location = 'pendingRVList'
							     }
						 });	
					}else{
						alert(res.msg);
						$(item).attr("disabled", false);	
					}
				},
				error : function(jqXHR, exception) {
					alert("Error occured while contacting the server");
					$(item).attr("disabled", false);	
				}
			});
 	}
 	
 	
 	
 	//model box coding
 	
 	function addRow(){
	
	var tbl = document.getElementById('tblOpeningBalance');
		var lastRow = tbl.rows.length;
		var iteration = lastRow;
		var row = tbl.insertRow(lastRow);
		var hdb = document.getElementById('counter');
		var prevCnt = hdb.value;
		var iteration = parseInt(hdb.value) + 1;
		hdb.value = iteration;
		
		row.id=iteration;
		row.name=iteration;

		var spanDiv = document.createElement('div');
		spanDiv.className = "form-check";
		var cell0 = row.insertCell(0);
		var e0 = document.createElement('span');
		e0.textContent = (iteration);
		cell0.appendChild(e0);
		spanDiv.appendChild(e0);
		cell0.appendChild(spanDiv);
		
		

		var newdivpsvn = document.createElement('div');
		newdivpsvn.className = "autocomplete forTableResp width150";

		var newdivPvmsSub = document.createElement('div');
		newdivPvmsSub.id='divPvms'+ (iteration);
		newdivPvmsSub.className = "autocomplete-itemsNew";
		
		var cell1 = row.insertCell(1);
		var e1 = document.createElement('input');
		e1.type = 'text';
		e1.className='form-control border-input';
		e1.name = 'pvmsNumber';
		e1.id = 'pvmsNumberId' + (iteration);
		e1.size = '10';
		e1.setAttribute('validate','Drug Code or Drug Name,string,yes');
		e1.autocomplete = 'off';
		e1.onkeyup = function() {
			getNomenClatureList(this,'fillItemAndValues','store','getStoreItemList','store_pvms')
		};
		
		cell1.appendChild(e1);
		newdivpsvn.appendChild(e1);
		newdivpsvn.appendChild(newdivPvmsSub);
		cell1.appendChild(newdivpsvn);
		
		

		var newdivnomen = document.createElement('div');
		newdivnomen.className = "autocomplete forTableResp width250";
		
		var newdivnomenSub = document.createElement('div');
		newdivnomenSub.id='divNomen'+ (iteration);
		newdivnomenSub.className = "autocomplete-itemsNew";
		
		
		var cell2 = row.insertCell(2);
		var e2 = document.createElement('input');
		e2.type = 'text';
		e2.className='form-control border-input';
		e2.name = 'nomenclature';
		e2.id = 'nomenclturId' + (iteration);
		e2.setAttribute('validate','Drug Code or Drug Name,string,yes');
		e2.tabIndex = "1";
		e2.size = '30';
		e2.autocomplete = 'off';
		e2.onkeyup = function() {
			getNomenClatureList(this,'fillItemAndValues','store','getStoreItemList','store_nomen')
		};

		cell2.appendChild(e2);
		newdivnomen.appendChild(e2);
		newdivnomen.appendChild(newdivnomenSub);
		cell2.appendChild(newdivnomen);

		

		var cell3 = row.insertCell(3);
		var e3 = document.createElement('input');
		e3.type = 'text';
		e3.readOnly=true;
		e3.className='form-control border-input width70'
		e3.name = 'unit';
		e3.id = 'unitId' + (iteration);
		e3.tabIndex = "1";
		e3.size = '30';
		e3.autocomplete = 'off';
		cell3.appendChild(e3);

		
		var cell4 = row.insertCell(4);
		var e4 = document.createElement('input');
		e4.type = 'text';
		e4.className='form-control border-input width90'
		e4.name = 'batchNumber';
		e4.id = 'batchNumberId' + (iteration);
		e4.setAttribute('validate','Batch No.,string,yes');
		e4.setAttribute('maxlength','30');
		e4.tabIndex = "1";
		e4.size = '30';
		e4.autocomplete = 'off';
		e4.onblur = function() {
			checkDuplicatePVMS(this,'nomenclatureGrid');
		};
		cell4.appendChild(e4);
		
		
		
		var newdivdom = document.createElement('div');
		newdivdom.className = "dateHolder width110";
		var cell5 = row.insertCell(5);
		var e5 = document.createElement('input');
		e5.type = 'text';
		e5.readOnly=true;
		e5.className='noFuture_dateStore form-control';
		e5.name = 'domDate';
		e5.id = 'domDate' + (iteration);
		e5.setAttribute('validate','Date of manufacturing,string,yes');
		e5.tabIndex = "1";
		e5.size = '30';
		e5.autocomplete = 'off';
		e5.setAttribute('placeholder','DD/MM/YYYY');
		cell5.appendChild(e5);
		newdivdom.appendChild(e5)
		cell5.appendChild(newdivdom);
		
		
		
		var newdivdoe = document.createElement('div');
		newdivdoe.className = "dateHolder width110";
		var cell6 = row.insertCell(6);
		var e6 = document.createElement('input');
		e6.type = 'text';
		e6.className='comapre_date form-control';
		e6.readOnly=true;
		e6.name = 'doeDate';
		e6.id = 'doeDate' + (iteration);
		e6.setAttribute('validate','Date of expiry,date,yes');
		e6.tabIndex = "1";
		e6.size = '30';
		e6.autocomplete = 'off';
		e6.onblur = function() {
			checkDate(iteration);
		};
		e6.setAttribute('placeholder','DD/MM/YYYY');
		cell6.appendChild(e6);
		newdivdoe.appendChild(e6)
		cell6.appendChild(newdivdoe);
		
		
		var cell7 = row.insertCell(7);
		var e7 = document.createElement('input');
		e7.type = 'texts';
		e7.className='form-control border-input width60'
		e7.name = 'quantity';
		e7.id = 'quantityId' + (iteration);
		e7.setAttribute('validate','Quantity,number,yes');
		e7.tabIndex = "1";
		e7.size = '30';
		e7.autocomplete = 'off';
		e7.onkeypress = function(){
			if(isNaN(this.value+String.fromCharCode(event.which || event.keyCode))) return false;
		}
		e7.onkeydown = function(){
			if(event.key==='.'){event.preventDefault();}
		}
		e7.oninput = function(){
			event.target.value = event.target.value.replace(/[^0-9]*/g,'');
		}	
		e7.onblur = function() {
			calculateAmount(iteration);
		};
		cell7.appendChild(e7);
		
		
		var cell8 = row.insertCell(8);
		var e8 = document.createElement('input');
		e8.type = 'text';
		e8.className='form-control border-input width60'
		e8.name = 'unitRate';
		e8.id = 'unitRateId' + (iteration);
		e8.setAttribute('validate','Unit Rate,number,no');
		e8.tabIndex = "1";
		e8.size = '30';
		e8.onblur = function() {
			calculateAmount(iteration);
		};
		e8.autocomplete = 'off';
		cell8.appendChild(e8);
		
		
		var cell9 = row.insertCell(9);
		var e9 = document.createElement('input');
		e9.type = 'text';
		e9.readOnly=true;
		e9.className='form-control border-input width90'
		e9.name = 'amount';
		e9.id = 'amountId' + (iteration);
		e9.setAttribute('validate','Amount,number,no');
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
		

	}
	
	function checkInp(item)
	{
	
	   var x=item.value;
	   if (isNaN(x)) 
	  {
	    alert("Please enter valid numbers");
	    return false;
	  }
	}

	function removeGridRow(val) {
		if ($('#tblOpeningBalance tr[id!="th"]').length > 1) {
			$(val).closest('tr').remove();
		}else{
			alert("Can not delete all rows");
		}
	} 


	function fillSelectedValue(fieldId,value){
		
		/* var index1 = value.lastIndexOf("[");
		var index2 = value.lastIndexOf("]");
		index1++;
		var id = value.substring(index1, index2);
		$('#'+fieldId).val(id); */
		
	
			/* var valRowId = new Array();
			$("#tblOpeningBalance tr[id !='th']").each(function(j)
			{				
				valRowId[j] = $j(this).attr("id");
			});
		var cnt = valRowId.length;
		getStoreItemList(cnt); */
		
	}
	
</script>

<body>
 <p align="center" id="messageId" style="color:green; font-weight: bold;" >${message}</p>
	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">Create RV against PO</div>

					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<div class="row">
									
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-md-4 col-form-label"> PO Number</label>
												<div class="col-md-7">
													<input type="text" class=" form-control" id="poNo" readonly />
												</div>
											</div> 
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-md-4 col-form-label"> PO Date </label>
												<div class="col-md-7">
													<input type="text" class=" form-control" id="poDate" readonly />
												</div>
											</div> 
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-md-4 col-form-label"> Vendor Type</label>
												<div class="col-md-7">
													<input type="text" class=" form-control" id="vendorName" readonly/>
												</div>
											</div> 
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-md-4 col-form-label">Vendor Name </label>
												<div class="col-md-7">
													<input type="text" class=" form-control" id="vendorType" readonly/>
												</div>
											</div> 
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-md-4 col-form-label"> RV Notes</label>
												<div class="col-md-7">
													<textarea class="form-control" id="rvNotes" rows="3" readonly></textarea>
												</div>
											</div> 
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-md-4 col-form-label"> Reason for Direct PO</label>
												<div class="col-md-7">
													<textarea class="form-control" rows="3" readonly></textarea>
												</div>
											</div> 
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-md-4 col-form-label"> RV Date</label>
												<div class="col-md-7">
													<div class="dateHolder">
															<input type="text" class=" form-control" id="rvDate" readonly/>
													</div>
												</div>
											</div>
										</div>
									</div>
									
									
									
									<div>
										<div class="table-responsive">
	
											<table class="table table-hover table-striped table-bordered">
												<thead>
													<tr>
														<th>Nomenclature</th>
														<th>A/U</th>
														<th>Required Quantity</th>
														<th>Approved Quantity</th>
														<th>PO Quantity</th>
														<th>Received Quantity</th>
														<th>Batch</th>
														<th>DOM</th>
														<th>DOE</th>
														<th>Unit Rate</th>
														<th>RV Quantity</th>
													</tr>
												</thead>
												<tbody id="rvTable">
													<!-- <tr>
														<td class="width330">Lorem</td>
														<td>2</td>
														<td>1000</td>
														<td>800</td>
														<td>800</td>
														<td><input type="text" class="width120 form-control" id="" data-toggle='modal' data-target='#quantityModal' readonly/></td>
														<td><input type="text" class="width120 form-control" id="" /></td>
													</tr> -->
												</tbody>
												<tr>
											</table>
										</div>
									</div>
									
									
									<div class="row form-group">
										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">

												<div class="button-list">
													<input type="submit" class="btn btn-primary "
														name="save" value="Save" onclick="return submitForm();" />
													<input type="submit" class="btn  btn-primary"
														name="submit" id="deleteNomenclature"
														value="Submit" tabindex="1" onclick="return submitForm();" />


												</div>
											</div>



										</div>
									</div>
								</div>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


 <!-- <div class="modal fade" id="quantityModal" tabindex="-1" role="dialog" aria-labelledby="smallModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title font-weight-bold">Received Quantity</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<div class="row ">
				<label class="col-md-2 col-form-label"> Nomenclature</label>
				<label class="col-md-8 col-form-label">: Nomen1</label>
			</div>
			
			<div class="m-t-10">
				<div class="table-responsive">
	
					<table class="table table-hover table-striped table-bordered">
						<thead>
							<tr>
								<th>RV No</th>
								<th>RV Date</th>
								<th>RV Quantity</th>
							</tr>
						</thead>
						<tbody id="">
							<tr>
								<td>800</td>
								<td><input type="text" class="width120 form-control" readonly/></td>
								<td><input type="text" class="width120 form-control" readonly/></td>
							</tr>
						</tbody>
						<tr>
					</table>
				</div>
				
			</div>
			<div class="row  m-t-10">
				<div class="col-md-12 text-right">
					<button type="button"  data-dismiss="modal" class="btn btn-primary">Close</button>
				</div>
			</div>
	      </div> 
	    </div>
	  </div>
	</div> -->
	
	
	<div class="modal fade" id="quantityModal" tabindex="-1" role="dialog" aria-labelledby="smallModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title font-weight-bold">Received Quantity</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<div class="row ">
				<label class="col-md-2 col-form-label"> Nomenclature</label>
				<label class="col-md-8 col-form-label">: Nomen1</label>
			</div>
			
			<div class="m-t-10">
														<div class="table-responsive">
		                                	<table class="table table-stripped table-hover table-bordered table-compressed" id="tblOpeningBalance">
		                                		<thead>
		                                			<tr id="th">
		                                				<th>S.No.</th>
		                                				<th>Drug Code</th>
		                                				<th>Drug Name</th>
		                                				<th>Unit</th>
		                                				<th>Batch No/ Serial No</th>
		                                				<th>DOM</th>
		                                				<th>DOE</th>
		                                				<th>Qty</th>
		                                				<th>Unit Rate</th>
		                                				<th>Amount</th>
		                                				<th>Add</th>
		                                				<th>Delete</th>
		                                			</tr>
		                                		</thead>
		                                		<tbody id="nomenclatureGrid">
		                                		<%int inc=1; %>
		                                			<tr id="<%=inc%>">
		                                				<td>
		                                					<div class="form-check">
															  <%-- <input class="form-check-input position-static" type="checkbox" id="checkboxId<%=inc %>" aria-label="..."> --%>
															 <%=inc%>
															</div>
		                                				</td>
		                                				<td>
		                                					<div class="autocomplete forTableResp width150">
																<input type="text" autocomplete="never" class="form-control border-input" name="pvmsNumber" id="pvmsNumberId<%=inc %>"  validate="Drug Code or Drug Name,string,yes" onKeyUp="getNomenClatureList(this,'fillItemAndValues','store','getStoreItemList','store_pvms')"/>
																<div id="divPvms1" class="autocomplete-itemsNew"></div>
															</div>
		                                				</td>
		                                				<td>
		                                					<div class="autocomplete forTableResp width250">
																<input type="text" autocomplete="never"  class="form-control border-input" name="nomenclature" id="nomenclturId<%=inc %>" validate="Drug Code or Drug Name,string,yes" onKeyUp="getNomenClatureList(this,'fillItemAndValues','store','getStoreItemList','store_nomen')"/>
																<div id="divNomen1" class="autocomplete-itemsNew"></div>
															</div>
		                                				</td>
		                                				<td>
															<input type="text" readonly class="form-control border-input width70" name="unit" id="unitId<%=inc %>" />
															<input type="hidden" class="form-control border-input width70" name="itemUnit" id="itemUnitId<%=inc %>" />
		                                				</td>
		                                				<td>
		                                					<input type="text" autocomplete="never" class="form-control border-input width90" name="batchNumber" id="batchNumberId<%=inc %>"  onblur="checkDuplicatePVMS(this,'nomenclatureGrid')" validate="Batch No.,string,yes" maxlength="30"/>
		                                				</td>
		                                				<td>
		                                					<div class="dateHolder width110">
															<input readonly type="text" class="noFuture_dateStore form-control"
																name="domDate" id="domDate<%=inc %>" placeholder="DD/MM/YYYY" value="" maxlength="10" validate="Date of manufacturing,date,yes"/>
															</div>
		                  			   					</td>
		                   							<td>
		                                					<div class="dateHolder width110">
															<input readonly type="text" class="comapre_date  form-control"
																name="doeDate" id="doeDate<%=inc %>" placeholder="DD/MM/YYYY" value="" maxlength="10" validate="Date of expiry,date,yes"/>
													</div>
		                                				</td>
		                                				<td>
		                                					<input type="text" autocomplete="never" class="form-control border-input  width60" name="quantity" id="quantityId<%=inc %>" onkeypress="return isNumberKey(event)" onblur="calculateAmount(<%=inc %>)" validate="Quantity,number,yes"/>
		                                				</td>
		                                				<td>
		                                					<input type="text" class="form-control border-input width60" name="unitRate" id="unitRateId<%=inc %>"  validate="Unit Rate,number,no" onblur="calculateAmount(<%=inc %>)"/>
		                                				</td>
		                                				<td>
		                                					<input readonly autocomplete="never" type="text" class="form-control border-input width90" name="amount" id="amountId<%=inc %>" validate="Amount,number,no"/>
		                                				</td>
		                                				<td>
		                                					<button type="button" class="btn btn-primary noMinWidth" id="btnAdd"  button-type="add" onclick="addRow()" ></button>
		                                				</td>
		                                				<td>
		                                					<button type="button" class="btn btn-danger noMinWidth" id="btnDelete" button-type="delete" onclick="removeGridRow(this)" ></button>
		                                				</td>
		                                				<td style="display: none;">
		                                					<input type="hidden" value="" tabindex="1"  name="item" id="itemId<%=inc %>"  />
		                                				</td>
														
		                                			</tr>
		                                		</tbody>
		                                	</table>
	                                	</div>
				
			</div>
			<div class="row  m-t-10">
				<div class="col-md-12 text-right">
					<button type="button"  data-dismiss="modal" class="btn btn-primary">Close</button>
				</div>
			</div>
	      </div> 
	    </div>
	  </div>
	</div>
	
</body>


</html>