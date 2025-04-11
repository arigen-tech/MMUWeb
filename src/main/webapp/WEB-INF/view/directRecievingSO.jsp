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
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/stores.js"></script> 

</head>
<%
long departmentId = 0;
String departmentName="";
	  if (session.getAttribute("department_id") != null) {
	   departmentId = Long.parseLong(session.getAttribute("department_id").toString());
	   departmentName =session.getAttribute("departmentName").toString();
	  }
	  
	  %>
	  
<script>

$j(document).ready(function() {
	var departmentId = $('#departmentId').val();
	if(departmentId!=0){
		$j("#directReceivingForm :input").attr("disabled", false);
		getSuppierListForStore();
		getAuNameForStore();
	}else{
		$j("#directReceivingForm :input").attr("disabled", true);
		alert("Please select Department.");
		return;
	}
	
	
});

function getSuppierListForStore(){
 var hospitalId=$('#hospitalId').val();
		 var params = {
				 "hospitalId":hospitalId 
				}
     $j.ajax({
   	  type : "POST",
		  contentType : "application/json",
		  url : 'getSupplierListForStore',
		  data : JSON.stringify(params),
		  dataType : "json",
		  cache : false,
        success : function(response) {
        	if(response.status==1){
        		var supplierList = response.supplierData;
				var supplierValues='';
				for(var i=0;i<supplierList.length;i++){
					supplierValues += '<option value='+supplierList[i].supplierId+'>'
									+ supplierList[i].supplierName
									+ '</option>';
				 }
					$j('#vendorId').append(supplierValues); 
        	}else{
        		$('#vendorId').val(0);
        	}
        },
        error: function(msg){					
			alert("An error has occurred while contacting the server");
		}
     });
	
}

function getAuNameForStore(){
	
	 var params = {
			 
			}
 $j.ajax({
	  type : "POST",
	  contentType : "application/json",
	  url : 'getAuNameForStore',
	  data : JSON.stringify(params),
	  dataType : "json",
	  cache : false,
    success : function(response) {
    	if(response.status==1){
    		var accountUnitList = response.accountUnitList;
			var unitValues='';
			for(var i=0;i<=accountUnitList.length-1;i++){
				unitValues += '<option value='+accountUnitList[i].auId+'>'
								+ accountUnitList[i].auName
								+ '</option>';
			 }
				$j('#auNip1').append(unitValues); 
    	}else{
    		$('#auNip1').val(0);
    	}
    },
    error: function(msg){					
		alert("An error has occurred while contacting the server");
	}
 });

}

</script>
<body>
	<!-- Begin page -->
	<div id="wrapper">

		<div class="content-page">
			<!-- Start content -->
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">Direct Receiving Against SO</div>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<form id="directReceivingForm" name="directReceivingForm">
									<div class="row">
									
									<!-- 	<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Receiving No.<span class="text-red">*</span></label>
												</div>
												<div class="col-md-7">
													<input class="form-control" type="text" id="receivingNo" name="receivingNo" validate="Receiving No.,string,yes"/> 
												</div>
											</div>
										</div>   -->
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Receiving Date<span class="text-red">*</span></label>
												</div>
												<div class="col-md-7">
													<div class="dateHolder">
														<input  type="text" class="noFuture_dateStore datePickerInput form-control minwidth120"
														placeholder="DD/MM/YYYY" value="" maxlength="10" id="recevingDate" name="recevingDate" validate="Receiving Date,date,yes"/>
													</div> 
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<div class="col-md-5">
													<label class="col-form-label">Vendor Name<span class="text-red">*</span></label>
												</div>
												<div class="col-md-7">
													<select class="form-control" id="vendorId" name="vendorId" validate="Vendor,string,yes">
														<option value="0">Select</option>
													</select>
												</div>
											</div>
										</div>
									</div>
									
									<h6 class=" m-t-20">PVMS</h6>
									<div class="table-responsive">
									<table class="table table-hover table-striped table-bordered m-t-10" id="tblDirectReceive">
										<thead class="bg-primary">
											<tr id="th">
												<!-- <th>S.No.</th> -->
												<th>PVMS</th>
												<th>Nomenclature</th>
												<th>A/U</th>
												<th>Batch No</th>
												<th>DOM</th>
												<th>DOE</th>
												<th>Received Qty</th>
												<th>Add</th>
												<th>Delete</th>
											</tr>
										</thead>
										<tbody id="nomenclatureGrid">
										<%int inc=1; %>
											<tr id="<%=inc%>">
												<td style="display: none;"><%=inc%></td>
												<td>
													<div class="autocomplete forTableResp width150">
													   <input type="text" autocomplete="off" class=" form-control border-input" name="pvmsNumber" id="pvmsNumberId<%=inc %>"  onKeyUp="getNomenClatureList(this,'fillItemAndValues','store','getStoreItemList','store_pvms')" />
													<div id="divPvms1" class="autocomplete-itemsNew"></div>
													</div>
												</td>
												<td>
													<div class="autocomplete forTableResp width250">
													   <input type="text" autocomplete="off" class=" form-control border-input" name="nomenclature" id="nomenclturId<%=inc %>"  onKeyUp="getNomenClatureList(this,'fillItemAndValues','store','getStoreItemList','store_nomen')"/>
														<div id="divNomen1" class="autocomplete-itemsNew"></div>	
													</div>
												</td>
											
												<td>
													<input type="text" readonly class="form-control border-input width70" name="unit" id="unitId<%=inc %>" />
		                                		</td>
		                                		<td>
		                                			<input type="text" class="form-control border-input width90" name="batchNumber" id="batchNumberId<%=inc %>"   onblur="checkDuplicateItems(this,'nomenclatureGrid');"/>
		                                		</td>
		                                		
											<td>
		                                		<div class="dateHolder width110">
													<input readonly type="text" class="noFuture_dateStore form-control"
														name="domDate" id="domDate<%=inc %>" placeholder="DD/MM/YYYY" value="" maxlength="10" />
												</div>
		                  			   					</td>
		                   					<td>
		                                		<div class="dateHolder width110">
													<input readonly type="text" class="comapre_date  form-control"
														 name="doeDate" id="doeDate<%=inc %>" placeholder="DD/MM/YYYY" value="" maxlength="10" />
												</div>
		                                				</td>
		                                		<td>
		                                			<input type="text" class="form-control border-input width60" name="quantity" id="quantityId<%=inc %>"  onkeypress="return isNumberKey(event)" onblur="<%-- calculateAmount(<%=inc %>) --%>" />
		                                		</td>
												
												<td>
		                                			<button type="button" class="btn btn-primary noMinWidth" id="btnAdd"  button-type="add" onclick="addRow()" ></button>
		                                		</td>
		                                		<td>
		                                			<button type="button" class="btn btn-danger noMinWidth" id="btnDelete" button-type="delete" onclick="removeGridRow(this)" ></button>
		                                		</td>
		                                		<td style="display: none;">
		                                			<input type="hidden" value="" tabindex="1"  name="itemId" id="itemId<%=inc %>"/>
		                                		</td>
											</tr>
										</tbody>
									</table>
									</div>
									
									<h6 class=" m-t-20">NIV</h6>
									<div class="table-responsive">
									<table class="table table-hover table-striped table-bordered m-t-10" id="tblDirectReceiveNiv">
										<thead class="bg-primary">
											<tr  id="th">
												<!-- <th>S.No.</th> -->
												<th>Nomenclature</th>
												<th>New Nomenclature</th>
												<th>A/U</th>
												<th>Batch No</th>
												<th>DOM</th>
												<th>DOE</th>
												<th>Received Qty</th>
												<th>Add</th>
												<th>Delete</th>
											</tr>
										</thead>
										<tbody id="nipGrid">
											<tr id="1">
												<td>
													<div class="autocomplete forTableResp">
																<input type="text" value="" tabindex="1" autocomplete="never" spellcheck="false"
																id="oldnip1"  size="50" name="oldnip"
																class="form-control border-input width330 disablecopypaste" onKeyUp="getNomenClatureList(this,'populateNomenforNiv','opd','getMasStoreItemNip','newNib');" onblur="resetFields(this.id);"/> 
                                                        <div id="newNibForPVMS" class="autocomplete-itemsNew"></div> 
														</div>
												</td>
												<td>
													<input type="text" value="" tabindex="1" 
																id="newNip1"  size="77" name="newNip"  onblur="disableNipForPVMS(this); resetFields(this.id)"
																class="form-control border-input width200" />
												</td>
											
												  <td>
                                                    <select name="auNip" id="auNip1" class="medium form-control width100" >
                                                    <option value="0">select</option>
                                                    </select>
                                                    </td> 
		                                		<td>
		                                			<input type="text" class="form-control border-input width90" name="nipBatchNumber" id="nipBatchNumberId1" />
		                                		</td>
		                                		
												<td>
		                                		<div class="dateHolder width110">
													<input readonly type="text" class="noFuture_dateStore form-control"
																name="nipDomDate" id="nipDomDateId1" placeholder="DD/MM/YYYY" value="" maxlength="10" onchange="compareDateForNipItems()"/>
													</div>
		                                		</td>
		                                		<td>
		                                			<div class="dateHolder width110">
													 <input readonly type="text" class="comapre_date form-control"
																name="nipDoeDate" id="nipDoeDateId1" placeholder="DD/MM/YYYY" value="" maxlength="10"  onchange="compareDateForNipItems()"/>
													</div>
		                                		</td>
		                                		<td>
		                                			<input type="text" class="form-control border-input width60" name="nipQuantity" id="nipQuantityId1" onkeypress="return isNumberKey(event)" onblur="<%-- calculateAmount(<%=inc %>) --%>" />
		                                		</td>
												<td style="display: none;">
		                                			<input type="hidden" value="" tabindex="1"  name="nipItemId" id="nipItemId1"/>
		                                		</td>
												<td>
		                                				<button type="button" class="btn btn-primary buttonAdd noMinWidth"
															name="button" value="" button-type="add"
															onclick="addNipRow();" tabindex="1"></button>

		                                		</td>
		                                		<td>
		                                			<button type="button" class="buttonDel  btn btn-danger noMinWidth"
															name="button" id="deleteNomenclature" button-type="delete" value=""
															onclick="removeRowNip(this);"
															tabindex="1"></button>
		                                		</td>
											</tr>
										</tbody>
									</table>
									</div>
									
									
									
									
									<div class="col-md-4">
										<input type="hidden" name="count" id="counter" value="<%=inc%>" />
										<input type="hidden" class="form-control" id="userId"
											   name="userId"  value="<%=session.getAttribute("user_id")%>">
										<input type="hidden" class="form-control" id="hospitalId"
											   name="hospitalId"  value="<%=session.getAttribute("hospital_id")%>">
										<input type="hidden" class="form-control" id="departmentId" 
											   name="departmentId" value="<%=departmentId %>"/> 
							         </div>
									
									<div class="row">
										<div class="col-12 text-right">
											<input type="button" class="btn btn-primary" id="btnSubmit" value="Submit" onclick="submitDirectReceiving()"  />
		                               		<button type="reset" name="Reset" id="reset"  class="btn btn-danger" accesskey="r" >Reset</button>
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
</body>
<script>

function addRow(){
	var tbl = document.getElementById('tblDirectReceive');
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
	cell0.style.display = 'none';
	var e0 = document.createElement('span');
	e0.textContent = (iteration);
	cell0.appendChild(e0);
	
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
	e1.setAttribute('validate','PVMS No. or Nomenclature,string,yes');
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
	e2.setAttribute('validate','PVMS No. or Nomenclature,string,yes');
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
	e4.setAttribute('validate','Batch No,string,yes');
	e4.onblur = function() {
		checkDuplicateItems(this,'nomenclatureGrid');
	};
	e4.tabIndex = "1";
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
	e7.type = 'text';
	e7.className='form-control border-input width60'
	e7.name = 'quantity';
	e7.id = 'quantityId' + (iteration);
	e7.setAttribute('validate','Quantity,number,yes');
	e7.tabIndex = "1";
	e7.size = '30';
	e7.autocomplete = 'off';
	e7.onblur = function() {
		/* calculateAmount(iteration); */
	};
	cell7.appendChild(e7);
	
	var cell8 = row.insertCell(8);
	var e8 = document.createElement('button');
	e8.type = 'button';
	e8.className='btn btn-primary noMinWidth';
	e8.setAttribute('button-type','add');
	e8.setAttribute('onclick','addRow()');
	cell8.appendChild(e8);
	
	
	var cell9 = row.insertCell(9);
	var e9 = document.createElement('button');
	e9.type = 'button';
	e9.className='btn btn-danger noMinWidth';
	e9.setAttribute('button-type','delete');
	e9.setAttribute('onclick',"removeGridRow(this)");
	cell9.appendChild(e9);
	
	var cell10 = row.insertCell(10);
	cell10.style.display = 'none';
	var e10 = document.createElement('input');
	e10.type = 'hidden';
	e10.name = 'itemId';
	e10.id = 'itemId' + (iteration);
	cell10.appendChild(e10);
	

}

function removeGridRow(val) {
	if ($('#tblDirectReceive tr[id!="th"]').length > 1) {
		$(val).closest('tr').remove();
	}else{
		alert("Can not delete all rows");
	}
} 

function submitDirectReceiving(){
	var value=validateFields("directReceivingForm"); 
	if(value==true){
		if(checkValidation()){
			 doEnableNewNipFields();
			 document.directReceivingForm.action="submitDirectReceiving";
			 document.directReceivingForm.method="POST";
			 document.directReceivingForm.submit();
		}
	}else{
		alert(value.split('\n')[0]);
		
	}
}


function doEnableNewNipFields(){
	var x = document.getElementsByName("newNip");
	for (var i = 0; i < x.length; i++) {
		    x[i].disabled=false;
		}
}
function compareDate(){
	var valRowId = new Array();
	$("#tblDirectReceive tr[id !='th']").each(function(j)
	{				
		valRowId[j] = $j(this).attr("id");
	});
	
	var cnt = valRowId.length;
	for(var i=1;i<=cnt;i++){
		var fromDate = $('#domDate'+i).val();
		 var toDate = $('#doeDate'+i).val();
		 
		 if(process(toDate) < process(fromDate)){
				alert("Expiry Date should not be earlier than Manufacturing Date");
				$('#domDate'+i).val("");
				return;
		 }
	}
}

function compareDateForNipItems(){
	var valRowIdNip = new Array();
	$("#tblDirectReceiveNiv tr[id !='th']").each(function(j)
	{				
		valRowIdNip[j] = $j(this).attr("id");
	});
	
	var cntNip = valRowIdNip.length;
	for(var i=1;i<=cntNip;i++){
		var fromDateNip = $('#nipDomDateId'+i).val();
		 var toDateNip = $('#nipDoeDateId'+i).val();
		 
		 if(process(toDateNip) < process(fromDateNip)){
				alert("Expiry Date should not be earlier than Manufacturing Date");
				$('#nipDoeDateId'+i).val("");
				return;
		 }
	} 
	
}


function resetFields(id){
	 $('#nipGrid tr').each(function(i, el){
			var $tds = $(this).find('td')
			var firstFiledNip=$($tds).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
			var secondFiledNip=$($tds).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
			var nipAu=$($tds).closest('tr').find("td:eq(2)").find("select:eq(0)").attr("id");
			if(document.getElementById(firstFiledNip).value!=''){
				document.getElementById(secondFiledNip).disabled = true;
			}else{
				document.getElementById(secondFiledNip).disabled = false;
			}
			}); 
		
		
		
		
	
}

function checkValidation(){
	var extNomenclatureFlag=true;
	if($('#nomenclatureGrid tr').length > 1){
		 $('#nomenclatureGrid tr').each(function(i, el) {
		    var $tds = $(this).find('td')
       	    var itemNomenclatureIdCheck = $tds.eq(10).find(":input").val();
		         if(itemNomenclatureIdCheck==""){
		        	 alert("Please enter valid Nomenclature Name"); 
		        	 extNomenclatureFlag=false;
		      		 return false; 
		         }
		 }); 
	}
 
	var  idforTreat='';
	var pvmsNo='';	
	var treatmentName='';
	var au ='';
	var batchNo ='';
	var dom ='';
	var doe ='';
	var qty = '';
	var $tds ='';
	var treatmentItemId='';
		 $('#nomenclatureGrid tr').each(function(i, el) {
			idforTreat= $(this).find("td:eq(2)").find("input:eq(0)").attr("id") 
			    $tds = $(this).find('td')
			    pvmsNo = $tds.eq(1).find(":input").val();
   		        treatmentName = $tds.eq(2).find(":input").val();
   			    au = $tds.eq(3).find(":input").val();
  			    batchNo = $tds.eq(4).find(":input").val();
 			    dom = $tds.eq(5).find(":input").val();
  		        doe = $tds.eq(6).find(":input").val();
  		 	    qty = $tds.eq(7).find(":input").val();
                treatmentItemId=$tds.eq(10).find(":input").val(); 
           
            
        	if(au!= "" || batchNo!= "" || dom!= "" ||  doe!="" || qty!="" )
			{	
        		
        		if(pvmsNo==""){
      				alert("Please Enter PVMS No.");
      				extNomenclatureFlag=false;
					return false;	
      			}
        		
      			if(treatmentName== "")
			 	{
					alert("Please Enter Nomenclature Name");
					extNomenclatureFlag=false;
					return false;	    	
		  	}
      			
      			
		   }
  		       	 			
		if(document.getElementById(idforTreat).value!= '' && document.getElementById(idforTreat).value != undefined)
	    {
			
			if(batchNo== "")
			{
				alert("Batch No can not be blank.");
				extNomenclatureFlag=false;
				return false;      	
			 }
			if(dom== "")
				 {
				alert("Manufacturing Date can not be blank");
				extNomenclatureFlag=false;
				return false;       	
			 }
			if(doe=="")
			{
				alert("Expiry Date can not be blank.");
				extNomenclatureFlag=false;
				return false;       	
		    }
		
		if(qty== "" ||qty==0)
			{
				alert("Quantity can not be blank or zero");
				extNomenclatureFlag=false;
				return false;       	
		    }

	    }
	 });
		 
		 var  idforTreatNip='';
     	 var  idforNewNip=''; 
		 var valNipGrid='';	
		 var $tds = '';
 		 var nipOldName='';
		 var nipNewName = '';
		 var nipAu = '';
		 var nipBatchNo = '';
 		 var nipDom = '';
		 var nipDoe = '';
		 var nipQty = '';
		 var itemNipGridIdCheck = '';
		 
	 		 $('#nipGrid tr').each(function(i, el) {
	 			idforTreatNip= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
	 			idforNewNip=$(this).find("td:eq(1)").find("input:eq(0)").attr("id")
	 			$tds = $(this).find('td')
	    		nipOldName = $tds.eq(0).find(":input").val();
	 			nipNewName = $tds.eq(1).find(":input").val();
	 			nipAu = $tds.eq(2).find(":input").val();
	 			nipBatchNo = $tds.eq(3).find(":input").val();
	    		nipDom = $tds.eq(4).find(":input").val();
	   			nipDoe = $tds.eq(5).find(":input").val();
	  			nipQty = $tds.eq(6).find(":input").val();
	  		    itemNipGridIdCheck = $tds.eq(7).find(":input").val();
	  		    
	  		     if(nipOldName!="" && itemNipGridIdCheck=="" ){
	        	
	        	    alert("Please enter valid NIV Row"); 
	        	    extNomenclatureFlag=false;
	        	    return false; 
		           
	             }
	  		    
	  			if(nipAu!= 0 || nipBatchNo!= "" || nipDom!= "" || nipDoe!="" || nipQty!="")
				{	
       				if(nipOldName== "" && nipNewName=="")
			 			{
							alert("Please Enter NIV Name");
							extNomenclatureFlag=false;
							return false;	    	
			  		}
			   	}
	  		    
	    		if(document.getElementById(idforTreatNip).value!= '' && document.getElementById(idforTreatNip).value != undefined)
			    {
	 			if(nipOldName== "")
	   			 {
  					alert("Please Enter NIV Presciption Name");
  				    extNomenclatureFlag=false;
  				    return false;	    	
				  }
				if(nipAu== "" || nipAu==0)
   			{
					alert("Item Unit can not be blank for NIV.");
					extNomenclatureFlag=false;
					return false;      	
				 }
				if(nipBatchNo== "")
   				 {
					alert("Batch No can not be blank for NIV.");
					extNomenclatureFlag=false;
					return false;       	
				 }
				if(nipDom== "")
    			{
					alert("Date of manufacturing can not be blank for NIV.");
					extNomenclatureFlag=false;
					return false;       	
			    }
				
				if(nipDoe== "")
    			{
					alert("Expiry Date can not be blank for NIV.");
					extNomenclatureFlag=false;
					return false;       	
			    }
				
				if(nipQty== "" || nipQty==0)
    			{
					alert("Qunatity should be greater than 0 for NIV.");
					extNomenclatureFlag=false;
					return false;       	
			    }

			    }
	 			if(document.getElementById(idforNewNip).value!= '' && document.getElementById(idforNewNip).value != undefined)
			    {
	 				if(nipAu== "")
  	   			 {
      				alert("Please select A/U  against entered NIV");
      				extNomenclatureFlag=false;
      				return false;	    	
  				  }
	 				if(nipBatchNo== "")
 	   			 {
     				alert("Please enter batch no against entered NIV");
     				extNomenclatureFlag=false;
     				return false;	    	
 				  }
    	 			
    				if(nipDom== "")
	    			{
   					alert("Date of manufacturing can not be blank for NIV.");
   					extNomenclatureFlag=false;
  					return false;      	
					 }
    				if(nipDoe== "")
	   				 {
    					alert("Expiry Date can not be blank for NIV.");
    					extNomenclatureFlag=false;
  					    return false;       	
					 }
 				
 				if(nipQty== "" || nipQty==0)
	    			{
    					alert("Qunatity should be greater than 0 for NIV.");
    					extNomenclatureFlag=false;
  					return false;       	
				    }
			    }
	 			
 		 }); 
	 		 
	if(pvmsNo=="" && treatmentName=="" && au==0 && batchNo=="" && dom=="" && doe=="" && qty=="" 
			&& nipOldName=="" && nipNewName==""  && nipAu==0 && nipBatchNo=="" && nipDom==""  && nipDoe==""  && nipQty==""){
		alert("Atleast one section must be filled.");
		extNomenclatureFlag=false;
		return false;
	} 
	
	if(extNomenclatureFlag)	{
		return true;
	}else{
		return false;
	}
	
}


function checkDuplicateItems(item,tbody){
	 var currentRowItemId=$(item).closest('tr').find("td:eq(10)").find("input:eq(0)").attr("id");
	 var currentRowItemIdValue=$(item).closest('tr').find("td:eq(10)").find("input:eq(0)").val();
	 var currentRowBatchNoId=$(item).closest('tr').find("td:eq(4)").find("input:eq(0)").attr("id");
	 var currentRowBatchNo=$(item).closest('tr').find("td:eq(4)").find("input:eq(0)").val();
	 
	 var currentPVMS=$(item).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
	 var currentNomen=$(item).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id");
	 var currentAccUnit=$(item).closest('tr').find("td:eq(3)").find("input:eq(0)").attr("id");
	 
	 $('#'+tbody+' tr').each(function(i, el) {
		 var $tds = $(this).find('td');
		 var rowItemId=  $($tds).closest('tr').find("td:eq(10)").find("input:eq(0)").attr("id");
		 var itemIdValue=$('#'+rowItemId).val();
		 var batchNoCounter=$($tds).closest('tr').find("td:eq(4)").find("input:eq(0)").attr("id");
		 var batchNoValue=$('#'+batchNoCounter).val();
		 
		 if(currentRowItemId!=rowItemId && currentRowItemIdValue==itemIdValue){
			 if(currentRowBatchNo==batchNoValue){
				 alert("PVMS/Nomenclature is already added");
				 $('#'+currentRowBatchNoId).val("");
				 $('#'+currentRowItemId).val("");
				 $('#'+currentPVMS).val("");
				 $('#'+currentNomen).val("");
				 $('#'+currentAccUnit).val("");
			        return false;
			 }
		 }
		 
	 }); 
}


</script>
</html>