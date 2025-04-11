<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>
<%@include file="..//view/commonJavaScript.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
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
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ASHA Application</title>
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
</head>
<body>
<div id="wrapper">
	<div class="content-page">
		<!-- Start content -->

		<div class="container-fluid">
			<div class="internal_Htext">Equipment Details</div>
			<form:form name="submitEquipmentDetails" id="submitEquipmentDetails" method="post"
										action="${pageContext.request.contextPath}/miAdmin/submitEquipmentDetails" autocomplete="never">
												
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-body">	
							<p align="center" style="color:green; font-weight: bold;" >${message}</p>
									
							<div class="row">								
								<div class="col-md-6">
									<div class="form-group row">
										<div class="col-md-4">
											<label class="col-form-label">Nomenclature/PVMS No.</label>
										</div>
										<div class="col-md-8">
											<div class="autocomplete forResptable">
												<input type="text" value="" autocomplete="never"
																	spellcheck="false" id="nomenclature1" 
																	name="nomenclature" class="form-control border-input width330"
																	onKeyUp="getNomenClatureList(this,'populatePVMS','opd','getMasStoreItemList','MIitem')" />
												<div id="divIdPVMS" class="autocomplete-itemsNew"></div>
											</div>			
										</div>
									</div>															
								</div>
								<input type="hidden" value="" id="itemId" name="itemId"/>
												
								<div class="w-100"></div>
								
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-6">
											<label class="col-form-label">Department</label>
										</div>
										<div class="col-md-6">
											
														<select id="departmentId1" name="departmentId"
														 class="form-control">
														<option value="0" selected="selected">Select</option>
													</select>
								</div>
									</div>															
								</div>	
								
									<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-6">
											<label class="col-form-label">Unit</label>
										</div>
										<div class="col-md-6">
											
														<select class="form-control" id="unitId" name="unitId">
                                                             </select>
                                                            <input type="text" class="auto  form-control" size="8"  name="uid" id ="uid"/>
								</div>
									</div>															
								</div>
								
								
								<div class="col-md-2">
									<button class="btn btn-primary" id="searhAppointment"
												type="button" onclick="searchRequest()">Search</button>													
								</div>
																
							</div>
							<div >	
								<!-- <div class="col-md-12">
									<h6 class="text-theme font-weight-bold text-underline">Details</h6>
								</div> -->
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
                                    
					
		

									<table class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th>Department</th>
												<th>Model No</th>
												<th>Serial No</th>
												<th>Depreciation(%)</th>
												<th>Price</th>
												<th>Make</th>
												<th>Manufacturer</th>
												<th>Technical Specification</th>
												<th>Warranty</th>
												<th>AMC</th>
												<th>Accessory</th>
												<th>Installed On</th>
												<th>RV No</th>
												<th>RV Date</th>
												
											</tr>
										</thead>
											<tbody id="equipmentGrid">
											<tr id="noFound"><td colspan='14'><h6>No Record Found</h6></td></tr>
										</tbody>
										
									</table>	
																	
							</div>
							
																			
							<!-- <div class="row m-t-10">								
								<div class="col-12 text-right">
									<input type="submit" class="btn  btn-primary" id="submitForm1" name="submit"
														value="Submit" tabindex="1" onclick="return submitForm();" />
																		
								</div>
							</div>	 -->
								
						</div>
					</div>
				</div>
			</div>
			</form:form>
		</div>

	</div>
	<div class="modal fade" id="warrantyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title font-weight-bold">Warranty</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
     <form:form name="submitWarranty" id="submitWarranty" >
			<p id="msg" align="center" style="color:red; font-weight: bold;" ></p>
      <div class="modal-body">
        <div class="row">
        <div class="col-md-6">
				<div class="form-group row">
				<div class="col-md-6">
				<label class="col-form-label">Warranty Start Date</label>
				</div>
				<div class="col-md-6">
				<div class="dateHolder">
				<input type="text" id="startDate" name="startDate" class="form-control calDate" />
				</div>
				</div>
				</div>
				</div>
				<div class="col-md-6">
				<div class="form-group row">
				<div class="col-md-6">
				<label class="col-form-label">Warranty End Date</label>
				</div>
				<div class="col-md-6">
				<div class="dateHolder">
				<input type="text" id="endDate" name="endDate" class="form-control calDate" />
				</div>
				</div>
				</div>
				</div>
				<input type="hidden" id="dtId" name="dtId" class="form-control" />
				<input type="hidden" id="flag" name="flag" value="warranty" class="form-control" />
				<input type="hidden" id="sflag" name="statusFlag"  class="form-control" />
				<div class="col-md-12 m-t-5">
				<div class="form-group row">
				<div class="col-md-3">
				<label class="col-form-label">Warranty Details</label>
				</div>
				<div class="col-md-9">
				<textarea id="details" name="details" class="form-control" rows="3"></textarea>
				</div>
				</div>
				</div>
				
				
				<!-- <div class="col-md-3">
				<div class="form-group row">
				<div class="col-md-5">
				<label class="col-form-label">Preventive</label>
				</div>
				<div class="col-md-2">
				<div class="form-check form-check-inline cusCheck m-t-10">
				<input type="checkbox" id="preventive" name="preventive" class="form-check-input"/>
				<span class="cus-checkbtn"></span>
				</div>
				</div>
				</div>
				</div> -->
				<div class="col-md-6">
				<div class="form-group row">
				<div class="col-md-6">
				<label class="col-form-label">Total Preventive</label>
				</div>
				<div class="col-md-6">
				<select class="form-control" id="totalPreventive" name="totalPreventive">
				<option value="0" selected="selected">Select</option>
				<option value="1">1</option>
				<option value="2" >2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5" >5</option>
				<option value="6">6</option>
				<option value="7" >7</option>
				<option value="8" >8</option>
				<option value="9" >9</option>
				<option value="10" >10</option>
				</select>
				</div>
				</div>
				</div>
				
				<div class="col-md-12 text-right">
				<button type="button" id="warSubmit" class="btn btn-primary" onclick="submitWarranty1()">Submit</button>
			<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
		</div>
        </div>
      </div> 
      </form:form>     
    </div>
  </div>
</div>


<div class="modal fade" id="amcModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title font-weight-bold">AMC</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form:form name="submitAmc" id="submitAmc" >
      <p id="amcmsg" align="center" style="color:red; font-weight: bold;" ></p>
      <div class="modal-body">
        <div class="row">
        <div class="col-md-6">
<div class="form-group row">
<div class="col-md-6">
<label class="col-form-label">AMC Start Date</label>
</div>
<div class="col-md-6">
<div class="dateHolder">
<input type="text" id="amcstartDate" name="startDate" class="form-control calDate" />
</div>
</div>
</div>
</div>
<input type="hidden" id="dtId1" name="dtId" class="form-control" />
			<input type="hidden" id="flag1" name="flag" value="amc" class="form-control" />
			<input type="hidden" id="sflag1" name="statusFlag"  class="form-control" />
<div class="col-md-6">
<div class="form-group row">
<div class="col-md-6">
<label class="col-form-label">AMC End Date</label>
</div>
<div class="col-md-6">
<div class="dateHolder">
<input type="text" id="amcEndDate" name="endDate" class="form-control calDate" />
</div>
</div>
</div>
</div>
<div class="col-md-12 m-t-5">
<div class="form-group row">
<div class="col-md-3">
<label class="col-form-label">AMC Details</label>
</div>
<div class="col-md-9">
<textarea id="amcdetails" name="details" class="form-control" rows="3"></textarea>
</div>
</div>
</div>


<!-- <div class="col-md-3">
<div class="form-group row">
<div class="col-md-5">
<label class="col-form-label">Preventive</label>
</div>
<div class="col-md-2">
<div class="form-check form-check-inline cusCheck m-t-10">
<input type="checkbox" class="form-check-input"/>
<span class="cus-checkbtn"></span>
</div>
</div>
</div>
</div> -->
<div class="col-md-6">
<div class="form-group row">
<div class="col-md-6">
<label class="col-form-label">Total Preventive</label>
</div>
<div class="col-md-6">
<select class="form-control" id="totalPreventive1" name="totalPreventive">
<option value="0" selected="selected">Select</option>
				<option value="1">1</option>
				<option value="2" >2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5" >5</option>
				<option value="6">6</option>
				<option value="7" >7</option>
				<option value="8" >8</option>
				<option value="9" >9</option>
				<option value="10" >10</option>
</select>
</div>
</div>
</div>

<div class="col-md-12 text-right">
<button type="button" id="amcSubmit" class="btn btn-primary" onclick="submitAmc1()">Submit</button>
<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
</div>
        </div>
      </div> 
      </form:form>     
    </div>
  </div>
</div>


<div class="modal fade" id="accessoryModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title font-weight-bold">Accessory</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <form:form name="submitAccessary" id="submitAccessary" >
       <p id="accmsg" align="center" style="color:red; font-weight: bold;" ></p>
     
      <input type="hidden" id="dtId2" name="dtId" class="form-control" />
	  <input type="hidden" id="flag2" name="flag" value="accessary" class="form-control" />
	  <input type="hidden" id="sflag2" name="statusFlag"  class="form-control" />
			
      <div class="modal-body">
        <table class="table table-hover table-striped table-bordered">
        	<thead>
        		<tr>
        			<th>Accessory Name</th>
        			<th>Serial No</th>
        			<th>Model No</th>
        			<th>Warranty Start Date</th>
        			<th>Warranty End Date</th>
        			<th>Details</th>
        			<th>Add</th>
        			<th>Delete</th>
        		</tr>
        	</thead>
        		<tbody id="accessaryGrid">
        		<tr>
        		
        			<td>
        				<input type="text" id="accessary1" name="accessaryName" class="form-control" />
        			</td>
        			<td>
        				<input type="text" id="serialNo1" name="serialNo" class="form-control" onblur="checkSerialNo(this.value,this);"/>
        			</td>
        			<td>
        				<input type="text" id="modelNo1" name="modelNo" class="form-control" />
        			</td>
        			<td>
        				<div class="dateHolder width110">
        					<input type="text" id="startDate1" name="startDate" class="form-control input_date" />
        				</div>
        			</td>
        			<td>
        				<div class="dateHolder width110">
        					<input type="text" id="endDate1" name="endDate" class="form-control input_date" />
        				</div>
        			</td>
        			<td>
        				<textarea id="details1" name="details" class="form-control" rows="2"></textarea>
        			</td>
        			<td style="display: none;"><input type="hidden"
														name="accId" tabindex="1" id="accId1" size="10"
														readonly="readonly" /></td>
        			<td>

															<button type="button" class="btn btn-primary buttonAdd noMinWidth"
																name="button" button-type="add" value=""
																onclick="addNomenclatureRow1();showLastRow();" tabindex="1"></button>

														</td>
														<td>


															<button type="button" class="buttonDel  btn btn-danger noMinWidth m-r-20"
																name="button" button-type="delete" value="" tabindex="1"
																onclick="removeRow(this);"></button>
        		</tr>
        	</tbody>
        </table>
        
        <div class="col-md-12 text-right">
			<button type="button" id="accSubmit" class="btn btn-primary" onclick="submitAccessary1()">Save</button>
			<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
		</div>
      </div>
      
      </form:form>      
    </div>
  </div>
</div>

<div class="modal-backdrop show" style="display:none;"></div>

</div>

</body>

<script>
/*
$(function(){
	var modaldtId;
	 $(document).on('change','input[name="warranty"]',function() {
  if($(this).is(':checked') && $(this).val() == '1') {
       $j('#warrantyModal').modal('hide');
       modaldtId=$(this).attr('data-parent-id');
       $('#warSubmit').removeAttr('disabled','disabled');
       $('#endDate,#startDate,#details').val('');
       $('#totalPreventive').val(0);
       $("#msg").html('');
       $('#dtId').val(modaldtId);
  } 
  if($(this).is(':checked') && $(this).val() == '2') {
       $j('#amcModal').modal('show');
       modaldtId=$(this).attr('data-parent-id');
       $('#amcSubmit').removeAttr('disabled','disabled');
       $('#amcEndDate,#amcstartDate,#amcdetails').val('');
       $('#totalPreventive1').val(0);
       $("#amcmsg").html('');
       $('#dtId1').val(modaldtId);
  }
}); 

$(document).on('change','input[name="accessary"]',function() {
	  if($(this).is(':checked')) {
	       $j('#accessoryModal').modal('show');
	       modaldtId=$(this).attr('data-parent-id');
	       
	       $('#accSubmit').removeAttr('disabled','disabled');
	       $("#accmsg").html('');
	       $("#accessaryGrid tr").remove("tr:gt(0)");
	       $("#accessaryGrid tr").each(function () {
		  		$(this).find('td:eq(0)').find(':input').val('');
		  	 	$(this).find('td:eq(2)').find(':input').val('');
		  		$(this).find('td:eq(1)').find(':input').val('');
		  		$(this).find('td:eq(3)').find(':input').val('');
		  		$(this).find('td:eq(4)').find(':input').val(''); 
		  		$(this).find('td:eq(5)').find(':input').val('');

		       });
	       $('#dtId2').val(modaldtId);
	  }
	});

});
*/
</script> 

<script type="text/javascript"  >

var user_id = <%= userId %>
var autoVsPvmsNo = '';
var data='';
var itemIds = '';
var i=1;
var  j=1;
var nPageNo=1;
$j(document).ready(function(){
	departmentList();
	GetHospitalList();
	$j("#uid").hide();
	
});

var unitName = "";
function GetHospitalList() {
	$j.ajax({
		crossOrigin : true,
		method : "POST",
		crossDomain : true,
		url : "${pageContext.request.contextPath}/master/getAllHospital",
		data : JSON.stringify({
			"PN" : "0",
			"hospitalId" :<%=hospitalId%>}),
    	    contentType: "application/json; charset=utf-8",
    	    dataType: "json",
    	    success: function(result){
    	    	//alert("success "+result.data.length);
    	    	var combo = "";
    	    	for(var i=0;i<result.data.length;i++){
    	    		//comboArray[i] = result.data[i].departmentName;
    	    		combo += '<option  value='+result.data[i].unitId+'>' +result.data[i].unitName+ '</option>';
    	    		//alert("combo :: "+comboArray[i]);
    	    		unitName=result.data[i].unitName;
    	    	}
    	    	$j('#unitId').append(combo);
    	    	
    	    	if($j('#unitId').find("option").length > 2){
    	    		$j('#unitId').show(); 
    	    		$j('#uid').hide();
    	    		// added  by rahul 
    	    		$j("input[type=radio]").attr('disabled', true);
    	    		$j("input[type=checkbox]").attr('disabled', true);
        	    }
    	    	else{
    	    		$j('#unitId').hide(); 
    	    		$j('#uid').show();
    	    		$j('#uid').val(unitName).attr('readonly','readonly');
    	    		document.getElementById('unitId').value = <%=hospitalId%>; 
    	    		// added by rahul
    	    		$("input[type=radio]").attr('disabled', false);
    	    		$j("input[type=checkbox]").attr('disabled', false);
        	    	}
    	    }
    	
    	});
     }
     
function departmentList(){
	   //get department
		 var dictionary = ${departmentList}
      var deptList = dictionary.departmentList;
      var deptValues = "";
      
      for(dept=0;dept<=deptList.length-1;dept++){
     	 deptValues += '<option value=' + deptList[dept].departmentId + '>' + deptList[dept].departmentname + '</option>';
      }
      $j('#departmentId1').append(deptValues);
      
      
}
function addNomenclatureRow1(l) {
  i++;
    $('#accSubmit').removeAttr('disabled','disabled');
 	var aClone = $('#accessaryGrid>tr:last').clone(true)
	aClone.find(":input").val("");
 	aClone.find('.ui-datepicker-trigger').remove();
 	aClone.find("td:eq(0)").find(':input').prop('id', 'accessary'+l+'');
	aClone.find("td:eq(2)").find(":input").prop('id', 'modelNo'+l+'');
	aClone.find("td:eq(1)").find(":input").prop('id', 'serialNo'+l+''); 
	aClone.find("td:eq(3)").find(":input").prop('id', 'startDate'+l+'').removeClass('hasDatepicker');
	aClone.find("td:eq(4)").find(":input").prop('id', 'endDate'+l+'').removeClass('hasDatepicker');
	aClone.find("td:eq(5)").find(":input").prop('id', 'details'+l+'');
	aClone.find("td:eq(6)").find(":input").prop('id', 'accId'+l+'');
	aClone.clone(true).appendTo('#accessaryGrid');
	
}

function showLastRow(){
	 $('.scrollableDiv ').animate({ scrollTop: $('table').height()}, 300);
}


var pvmsNo = '';
var itemIds = '';
var itemIdPrescription= '';
function populatePVMS(val, inc,item) {

	if (val != "") {
			var index1 = val.lastIndexOf("[");
		var indexForBrandName = index1;
		var index2 = val.lastIndexOf("]");
		index1++;
		pvmsNo = val.substring(index1, index2);
		var indexForBrandName = indexForBrandName--;
		var brandName = val.substring(0, indexForBrandName);
		if (pvmsNo == "") {
			
			return false;
		} 
		else
		{
			  var pvmsValue = '';
	     	  for(var i=0;i<autoVsPvmsNo.length;i++){
	     		 // var pvmsNo1 = data[i].pvmsNo;
	     		 var masItemIdValue= autoVsPvmsNo[i];
	     		 var pvmsNo1=masItemIdValue[1];
	     		
	     		  if(pvmsNo1 == pvmsNo){
	     			  pvmsValue = masItemIdValue[4];//data[i].dispUnit;
	     			  itemIdPrescription =masItemIdValue[0]; //data[i].itemId;
	     			  itemIds = itemIdPrescription;
	     			  $j('#itemId').val(itemIds);
	     			 
	     		  }
	     	  }	
	     	
           
			return true;

		}

	} 
	else
	{
		return false;
	}
}


function GetListOfEquipment(MODE)
{
	 var nomenclature1 = $j("#nomenclature1").val();
	 var dept = $j("#departmentId1").val();
	 
	 var itemId = $j("#itemId").val();
	 var unitId = $j("#unitId").val();
	 	
	  if (nomenclature1 == null || nomenclature1 == "") {
         alert("Please select Nomenclature/PVMS No.");
         return false;
     }
	  if (dept == null || dept == "" || dept == 0) {
	         alert("Please select department");
	         flag=1;
	         return false;
	     }
	 if(MODE == 'ALL'){
		 var data = {"PN":nPageNo,"departmentId":dept,"itemId":itemId,"unitId":unitId};		
		}
	else
		{
		var data = {"PN":nPageNo,"departmentId":dept,"itemId":itemId,"unitId":unitId};	
		} 
	var url = "getEquipmentDetails";
		
	var bClickable = false;
	GetJsonData('equipmentGrid',data,url,bClickable);
} 

function makeTable(jsonData)
{	
	var htmlTable = "";	
	var data = jsonData.count;
	var pageSize = 5;
    var dataList = jsonData.data;
    for(item in dataList){
			
			  // htmlTable += '<tr id="'+dataList[item].Id+'" onclick="hello('+dataList+')">';
			  htmlTable = htmlTable + "<tr id='"+dataList[item].dtId+"' >";	
			  htmlTable = htmlTable + "<td >" + dataList[item].department + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].modelNo + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].serialNo + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].depriciation + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].price + "</td>"; 
	    	  htmlTable = htmlTable + "<td >" + dataList[item].make + "</td>";
	    	  
	    	  htmlTable = htmlTable + "<td >" + dataList[item].manufacturer + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].technicalSpec + "</td>";
	    	  
	    	 // htmlTable = htmlTable + "<td ><div class='form-check form-check-inline cusRadio'><input type='radio' class='form-check-input' id='warranty"+item+"' data-parent-id='"+dataList[item].dtId+"' name='warranty' value='1' /><span class='cus-radiobtn'></span></div></td>";
	    	 htmlTable = htmlTable + "<td ><div class='form-check form-check-inline cusRadio'><input type='radio' class='form-check-input' id='warranty"+item+"' data-parent-id='"+dataList[item].dtId+"' name='warranty' value='1' onclick='chkwarrantyExist("+dataList[item].dtId+")'  /><span class='cus-radiobtn'></span></div></td>";
	    	   
	    	 htmlTable = htmlTable + "<td ><div class='form-check form-check-inline cusRadio'><input type='radio' class='form-check-input' id='amc"+item+"' data-parent-id='"+dataList[item].dtId+"' name='warranty' value='2' onclick='chkAmcExist("+dataList[item].dtId+")' /><span class='cus-radiobtn'></span></div></td>";
	    	  htmlTable = htmlTable + "<td ><div class='form-check form-check-inline cusCheck'><input type='checkbox' class='form-check-input' id='accessary' data-parent-id='"+dataList[item].dtId+"' name='accessary' onclick='chkAccessaryExist("+dataList[item].dtId+")'/><span class='cus-checkbtn'></span></div></td>";
	    	  
	    	  htmlTable = htmlTable + "<td >" + dataList[item].installed + "</td>";
		    	
	    	  /*   htmlTable = htmlTable + "<td ><div class='form-check form-check-inline cusCheck'><input type='checkbox' class='form-check-input' id='installed"+item+"' name='installed' onclick='showDate("+item+")'/><span class='cus-checkbtn'></span></div>";
	    	  htmlTable = htmlTable + "<div id='date"+item+"' class='dateHolder width100' style='display:none;'><input type='text' class='form-control input_date' /></div></td>";
	    	  */ 
	    	  htmlTable = htmlTable + "<td >" + dataList[item].rvNumber + "</td>";
	    	  htmlTable = htmlTable + "<td >" + dataList[item].rvDate + "</td>";
	    	  htmlTable = htmlTable + "</tr>";
	    
	      }
	if(jsonData.count == 0 || typeof jsonData.count == 'undefined')
		{
		htmlTable = htmlTable+"<tr ><td colspan='14'><h6>No Record Found</h6></td></tr>";
		   //alert('No Record Found');
		}			
	
	$j("#equipmentGrid").html(htmlTable);	
	
	
}

function showDate(item) {
	  $("#date"+item ).show() ;
	   
	}
function showResultPage(pageNo)
{
	
	
	nPageNo = pageNo;	
	GetListOfEquipment('FILTER');
	
}


function showAll()
{
	nPageNo = 1;	
	GetListOfEquipment('ALL');
	
}

function searchRequest() {
	GetListOfEquipment('FILTER');
}


function submitWarranty1() {
	 $("#sflag").val("");
	 var startDate=$("#startDate").val();
	 var endDate=$("#endDate").val(); 
	 var details=$("#details").val();
	  if (startDate == null || startDate == "") {
	         alert("Please select warranty start date");
	         return false;
	     }
		  if (endDate == null || endDate == "") {
		         alert("Please select warranty end date");
		         return false;
		     }
	   
	     if (details == null || details == "") {
		        alert("Please enter details");
		        return false;
		    }
	     
	
	 	 	var fd = startDate.split("/");
	 		var fDate= new Date(fd[2], fd[1] - 1, fd[0])
	 		
	 		var td = endDate.split("/");
	 		var tDate= new Date(td[2], td[1] - 1, td[0])

	 	  if(tDate < fDate) {
	 	 	alert(" Warranty end date cannot be earlier than the  warranty start date");
	 	 	return false;
	    	} 
	 var formData1 = $('#submitWarranty')[0];
	 var formData = new FormData(formData1);
		var url="submitWarrantydetails";
		 $('#warSubmit').attr('disabled','disabled');
		$.ajax({
			url : url,
			data : formData,
			processData: false,
	        contentType: false,
			async : false,
			type : 'POST',
			dataType : "json",
			success : function(response) {
				//alert(response);
				var dataVal=response.msg;
				if(response.status==3){
					var data=response.data;
					$("#msg").html(dataVal);
					$("#startDate").val(data.startDate);
					$("#endDate").val(data.endDate); 
					$("#details").val(data.details);
					$("#totalPreventive").val(data.totalPreventive);
				}else
				alert(dataVal+'S');
			},
			error : function(err) {
			}
		});
}

function chkwarrantyExist(eqdtId) {
	//alert(eqdtId);
	var eqDtId={"eqDtId":eqdtId};
	$('#dtId').val(eqdtId);
	 $("#sflag").val("war");
	 $('#endDate,#startDate,#details').val('');
     $('#totalPreventive').val(0);
     $("#msg").html('');
    // $j('#warrantyModal').modal('show');
	var formData1 = $('#submitWarranty')[0];
	 var formData = new FormData(formData1);
		var url="submitWarrantydetails";
		$.ajax({
			url : url,
			data : formData,
			processData: false,
	        contentType: false,
			async : false,
			type : 'POST',
			dataType : "json",
			success : function(response) {
				//alert(response);
				var dataVal=response.msg;
				if(response.status==3){
					var data=response.data;
					$("#msg").html(dataVal);
					$("#startDate").val(data.startDate);
					$("#endDate").val(data.endDate); 
					$("#details").val(data.details);
					$("#totalPreventive").val(data.totalPreventive);
					 $('#warSubmit').attr('disabled','disabled');
					 $j('#warrantyModal').modal('show');
				}else if(response.status!=10){
				 alert(dataVal+'S');
				// $('#warSubmit').attr('disabled','disabled');
				// $j('#warrantyModal').modal('hide');
				}else{
					 $('#warSubmit').removeAttr('disabled','disabled');
					 $j('#warrantyModal').modal('show');
				}
					
			},
	error: function(result) {
	alert("An error has occurred while contacting the server");
	}
	
	});
	
}


function chkAmcExist(eqdtId) {
	//alert(eqdtId);
	 $('#dtId1').val(eqdtId);
	 $("#sflag1").val("war");
	 $('#amcEndDate,#amcstartDate,#amcdetails').val('');
     $('#totalPreventive1').val(0);
     $("#amcmsg").html('');
    // $j('#amcModal').modal('show');
     
     var formData1 = $('#submitAmc')[0];
	 var formData = new FormData(formData1);
		var url="submitWarrantydetails";
		$('#amcSubmit').attr('disabled','disabled');
		$.ajax({
			url : url,
			data : formData,
			processData: false,
	        contentType: false,
			async : false,
			type : 'POST',
			dataType : "json",
			success : function(response) {
				//alert(response);
				var dataVal=response.msg;
				if(response.status==3){
					var data=response.data;
					$("#amcmsg").html(dataVal);
					$("#amcstartDate").val(data.startDate);
					$("#amcEndDate").val(data.endDate); 
					$("#amcdetails").val(data.details);
					$("#totalPreventive1").val(data.totalPreventive);
					$('#amcSubmit').attr('disabled','disabled');
					$j('#amcModal').modal('show');
					    
				}else if(response.status!=10){
					// $('#amcSubmit').attr('disabled','disabled');
					 //$j('#amcModal').modal('hide');
				     alert(dataVal+'S');
				
				}else{
					$j('#amcModal').modal('show');
					 $('#amcSubmit').removeAttr('disabled','disabled');
				}
					
			},
	error: function(result) {
	alert("An error has occurred while contacting the server");
	}
	
	});
	
}

function submitAmc1() {
	$("#sflag1").val("");
	 var startDate=$("#amcstartDate").val();
	 var endDate=$("#amcEndDate").val(); 
	 var details=$("#amcdetails").val();
	  if (startDate == null || startDate == "") {
	         alert("Please select AMC start date");
	         return false;
	     }
		  if (endDate == null || endDate == "") {
		         alert("Please select AMC end date");
		         return false;
		     }
	   
	     if (details == null || details == "") {
		        alert("Please enter AMC details");
		        return false;
		    }
	     var fd = startDate.split("/");
	 		var fDate= new Date(fd[2], fd[1] - 1, fd[0])
	 		
	 		var td = endDate.split("/");
	 		var tDate= new Date(td[2], td[1] - 1, td[0])

	 	 if(tDate < fDate) {
	 	 	alert(" AMC end date cannot be earlier than the  AMC start date");
	 	 	return false;
	 	 }
	 var formData1 = $('#submitAmc')[0];
	 var formData = new FormData(formData1);
		var url="submitWarrantydetails";
		$('#amcSubmit').attr('disabled','disabled');
		$.ajax({
			url : url,
			data : formData,
			processData: false,
	        contentType: false,
			async : false,
			type : 'POST',
			dataType : "json",
			success : function(response) {
				//alert(response);
				var dataVal=response.msg;
				if(response.status==3){
					var data=response.data;
					$("#amcmsg").html(dataVal);
					$("#amcstartDate").val(data.startDate);
					$("#amcEndDate").val(data.endDate); 
					$("#amcdetails").val(data.details);
					$("#totalPreventive1").val(data.totalPreventive);
				}else
				alert(dataVal+'S');
			},
			error : function(err) {
			}
		});
}


function chkAccessaryExist(eqdtId) {
	  $("#accmsg").html('');
     $("#accessaryGrid tr").remove("tr:gt(0)");
     $("#accessaryGrid tr").each(function () {
	  		$(this).find('td:eq(0)').find(':input').val('');
	  	 	$(this).find('td:eq(2)').find(':input').val('');
	  		$(this).find('td:eq(1)').find(':input').val('');
	  		$(this).find('td:eq(3)').find(':input').val('');
	  		$(this).find('td:eq(4)').find(':input').val(''); 
	  		$(this).find('td:eq(5)').find(':input').val('');
	  		$(this).find('td:eq(6)').find(':input').val('');
	  		
	       });
     $('#dtId2').val(eqdtId);
	 $("#sflag2").val("war"); 
    // $('#accSubmit').attr('disabled','disabled');
	 var formData1 = $('#submitAccessary')[0];
	 var formData = new FormData(formData1);
		var url="submitAccessarydetails";
		$.ajax({
			url : url,
			data : formData,
			processData: false,
	        contentType: false,
			async : false,
			type : 'POST',
			dataType : "json",
			success : function(response) {
				 $j('#accessoryModal').modal('show');
				var dataVal=response.msg;
				if(response.status==2){
					
					$("#accmsg").html(dataVal);
			     	var dataList=response.accList;
			     	var j=1;
					    for(item in dataList){
					    	     $('#accId'+j).val(dataList[item].accId);
					    		 $('#startDate'+j).val(dataList[item].startDate);
					    		 $('#accessary'+j).val(dataList[item].accessaryName);
					    		 $('#endDate'+j).val(dataList[item].endDate);
					    		 $('#modelNo'+j).val(dataList[item].modelNo);
					    		 $('#serialNo'+j).val(dataList[item].serialNo);
					    		 $('#details'+j).val(dataList[item].details);
					    		 addNomenclatureRow1(j+1);
					    		 j++;
					    }
					    $('#accessaryGrid tr:last').remove();
					   // $('#accSubmit').attr('disabled','disabled');
						}
				else if(response.status!=10){
						alert(dataVal+'S');
				}else
					 $('#accSubmit').removeAttr('disabled','disabled');
			},
	error: function(result) {
	alert("An error has occurred while contacting the server");
	}
	
	});
	
}
function submitAccessary1() {
	 $("#sflag2").val("");
	
	var flag=0;
	   $("#accessaryGrid tr").each(function () {
		 var accessaryName=$(this).find('td:eq(0)').find(':input').val();
	 	 var modelNo=$(this).find('td:eq(2)').find(':input').val();
		 var serialNo=$(this).find('td:eq(1)').find(':input').val();
		 var startDate=$(this).find('td:eq(3)').find(':input').val();
		 var endDate=$(this).find('td:eq(4)').find(':input').val(); 
		 var details=$(this).find('td:eq(5)').find(':input').val();

	     if (accessaryName == null || accessaryName == "") {
	         alert("Please enter Accessory Name");
	         flag=1;
	         return false;
	     }
 			if (serialNo == null || serialNo == "") {
	        alert("Please enter serial number");
	        flag=1;
	        return false;
	    }
	     
	     if (modelNo == null || modelNo == "") {
	         alert("Please enter model number");
	         flag=1;
	         return false;
	     }
		  if (startDate == null || startDate == "") {
	         alert("Please select warranty start date");
	         flag=1;
	         return false;
	     }
		  if (endDate == null || endDate == "") {
		         alert("Please select warranty end date");
		         flag=1;
		         return false;
		     }
		  var fd = startDate.split("/");
	 		var fDate= new Date(fd[2], fd[1] - 1, fd[0])
	 		
	 		var td = endDate.split("/");
	 		var tDate= new Date(td[2], td[1] - 1, td[0])

	 	 if(tDate < fDate) {
	 	 		alert(" Warranty end date cannot be earlier than the  warranty start date");
	 	 		flag=1;
	 	 		return false;
	 	  }
	     if (details == null || details == "") {
		        alert("Please enter details");
		        flag=1;
		        return false;
		    }
	    
	  });
	   
	   
	    if(flag==1){
	    	return false;
	    }
	  $('#accSubmit').attr('disabled','disabled');
	 var formData1 = $('#submitAccessary')[0];
	 var formData = new FormData(formData1);
		var url="submitAccessarydetails";
		$.ajax({
			url : url,
			data : formData,
			processData: false,
	        contentType: false,
			async : false,
			type : 'POST',
			dataType : "json",
			success : function(response) {
				$('#accSubmit').removeAttr('disabled','disabled');
				var dataVal=response.msg;
				if(response.status==2){
					 $("#accessaryGrid tr").remove("tr:gt(0)");
				       $("#accessaryGrid tr").each(function () {
					  		$(this).find('td:eq(0)').find(':input').val('');
					  	 	$(this).find('td:eq(2)').find(':input').val('');
					  		$(this).find('td:eq(1)').find(':input').val('');
					  		$(this).find('td:eq(3)').find(':input').val('');
					  		$(this).find('td:eq(4)').find(':input').val(''); 
					  		$(this).find('td:eq(5)').find(':input').val('');
					  		$(this).find('td:eq(6)').find(':input').val('');

					       });
					$("#accmsg").html(dataVal);
			     	var dataList=response.accList;
			     	var j=1;
					    for(item in dataList){
					    		 $('#accId'+j).val(dataList[item].accId);
					    		 $('#startDate'+j).val(dataList[item].startDate);
					    		 $('#accessary'+j).val(dataList[item].accessaryName);
					     		 $('#endDate'+j).val(dataList[item].endDate);
					    		 $('#modelNo'+j).val(dataList[item].modelNo);
					    		 $('#serialNo'+j).val(dataList[item].serialNo);
					    		 $('#details'+j).val(dataList[item].details);
					    		 addNomenclatureRow1();
					    		 j++;
					    }
					    $('#accessaryGrid tr:last').remove();
						}else
						alert(dataVal+'S');
			},
			error : function(err) {
			}
		});
}

function getEquipmentDetailsByItemId() {
	var itemId=$('#itemId').val();
	if (itemId != "") {
	var itemId={"itemId":itemId};
	jQuery.ajax({
	crossOrigin: true,
	method: "POST",			    
	crossDomain:true,
	url: "getEquipmentDetailsByItemId",
	data:JSON.stringify(itemId),
	contentType: "application/json; charset=utf-8",
	dataType: "json",
	success: function(result){
		if(result.status==1){
			if(result.qty!=0){
				$('#scale').val(result.scale);
				$('#qty').val(result.qty);
			}else{
				$('#scale').val("");
				$('#qty').val("");
			}
		}
		else if(result.status==0){
			alert(result.err_mssg);
		}
		else if(result.status==-1){
			alert(result.msg);
		}
		
		
	},
	error: function(result) {
	alert("An error has occurred while contacting the server");
	}
	
	});
	}
	}
	
function checkSerialNo(val,obj){
	 var flag=0;
	 var idddd =$(obj).closest('tr').find("td:eq(1)").find("input").attr("id");
	// var serialNo=$(this).find('td:eq(1)').find(':input').val();
	 var iddddValue =$(obj).closest('tr').find("td:eq(1)").find("input").val();
	 $("#accessaryGrid tr").each(function () {
		var thisId =$(this).closest('tr').find("td:eq(1)").find("input").attr("id");
		var vId=$(this).find('td:eq(1)').find('input').val();
		  if (vId == iddddValue && thisId!=idddd) {
        alert("Serial No already exist ");
        $(obj).closest('tr').find("td:eq(1)").find("input").val("");
        flag=1;
    }
	  if( flag==1){
	         return false;

	  }
});
} 

function removeRow(obj){
	var rowCount = $('#accessaryGrid tr').length;
	if(rowCount!==1){
	var r = confirm("Do you want to delete the record?");
	if (r == true) {
			$(obj).closest('tr').remove();
			
	}
		
	 else {
		
		  return false;
	 }
	} else {
		alert("Atleast one row should be there");
	  return false;
	}
	
}

</script>
</html>