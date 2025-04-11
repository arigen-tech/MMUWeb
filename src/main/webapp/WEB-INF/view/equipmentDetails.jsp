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
								<!-- <div class="col-md-6">
									<div class="form-group row">
										<div class="col-md-4">
											<label class="col-form-label">Nomeclature</label>
										</div>
										<div class="col-md-8">
											<input type="text" class="form-control" />
										</div>
									</div>															
								</div> -->
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-6">
											<label class="col-form-label">Equipment Date</label>
										</div>
										<div class="col-md-6">
											<div class="dateHolder">
												<input type="text" id="equipmentDate" name="equipmentDate" class="form-control calDate" placeholder="DD/MM/YYYY"  />
											</div>
										</div>
									</div>															
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-6">
											<label class="col-form-label">Authorized ME Scale</label>
										</div>
										<div class="col-md-6">
											<input type="text" id="scale" name="scale"  class="form-control" />
										</div>
									</div>															
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<div class="col-md-6">
											<label class="col-form-label">Authorized Qty</label>
										</div>
										<div class="col-md-6">
											<input type="text" id="qty" name="qty"  class="form-control" onkeypress="return isNumberKey(event)"/>
										</div>
									</div>															
								</div>	
																
							</div>
							<div class="row m-t-10">	
								<div class="col-md-12">
									<h6 class="text-theme font-weight-bold text-underline">Details</h6>
								</div>
								<div class="col-md-12">
									<div class="table-responsive">
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
												<!-- <th>Warranty</th>
												<th>AMC</th>
												<th>Accessory</th> -->
												<th>Installation Date</th>
												<th>RV No</th>
												<th>RV Date</th>
												<th>Add</th>
												<th>Delete</th>
											</tr>
										</thead>
											<tbody id="equipmentGrid">
											
											<tr>
													
												<td class="">
													<select id="departmentId1" name="departmentId"
														 class="form-control width150">
														<option value="0" selected="selected">Select</option>
													</select>
												</td>									
												<td>
													<input type="text" id="modelNo1" name="modelNo" class="form-control width150" />
												</td>
												<td>
													<input type="text" id="serialNo1" name="serialNo" class="form-control width150" onblur="checkSerialNo(this.value,this);"/>
												</td>
												<td>
													<input type="text" id="depreciation1" name="depreciation" class="form-control width90" onkeypress="if(isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"/>
												</td>
												<td>
													<input type="text" id="price1" name="price" class="form-control width150" onkeypress="if(isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"/>
												</td>
												<td>
													<input type="text" id="make1" name="make" class="form-control width150" />
												</td>
												<td>
													<select class="form-control width150" id="manufacturer1" name="manufacturer">
														<option value="0" selected="selected">Select</option>
													</select>
												</td>
												<td>
													<textarea id="technical1" maxlength="500" name="technical" class="form-control width150" rows="2"></textarea>
												</td>
												<td >
													<!-- <div class="form-check form-check-inline cusCheck">
														<input type="checkbox" class="form-check-input" id="installed1" value="1" name="installed" onclick='showDate(this)'/>
													<span class="cus-checkbtn"></span>
													</div> -->
													<div class="dateHolder width120" id="showdiv1" >
														<input id="installedDate1" name="installedDate" type="text" class="form-control noFuture_date " placeholder="DD/MM/YYYY" />
													</div>											
												</td>
												<td>
													<input type="text" id="rvNo1" name="rvNo" class="form-control width150" />
												</td>	
												<td>
													<div class="dateHolder width120">
														<input type="text" id="rvDate1" name="rvDate" class="form-control noFuture_date" placeholder="DD/MM/YYYY" />
													</div>
												</td>	
												<td>

															<button type="button" class="btn btn-primary buttonAdd noMinWidth"
																name="button" button-type="add" value=""
																onclick="addNomenclatureRow1();showLastRow();" tabindex="1"></button>

														</td>
														<td>


															<button type="button" class="buttonDel  btn btn-danger noMinWidth m-r-20"
																name="button" button-type="delete" value="" tabindex="1"
																onclick="removeRowIndent(this);"></button>

														</td>										
											</tr>
										</tbody>
									</table>	
									</div>													
								</div>								
							</div>
							
																			
							<div class="row m-t-10">								
								<div class="col-12 text-right">
									<input type="submit" class="btn  btn-primary" id="submitForm1" name="submit"
														value="Submit" tabindex="1" onclick="return submitForm();" />
																		
								</div>
							</div>	
								
						</div>
					</div>
				</div>
			</div>
			</form:form>
		</div>

	</div>
</div>

</body>
<script type="text/javascript"  >

var user_id = <%= userId %>
var autoVsPvmsNo = '';
var data='';
var itemIds = '';
var i=1;
var  j=1;
$j(document).ready(
		  function departmentList(){
			   //get department
				 var dictionary = ${departmentList}
		         var deptList = dictionary.departmentList;
		         var deptValues = "";
		         
		         for(dept=0;dept<=deptList.length-1;dept++){
		        	 deptValues += '<option value=' + deptList[dept].departmentId + '>' + deptList[dept].departmentname + '</option>';
		         }
		         $j('#departmentId1').append(deptValues);
		         var dictionary1 = ${manufacturerList}
		         var mfList = dictionary1.manufacturerList;
		         
 				var mfValues = "";
		         
		        
		        for(mf=0;mf<=mfList.length-1;mf++){
		        	mfValues += '<option value=' + mfList[mf].manufacturerId + '>' + mfList[mf].manufacturerName + '</option>';
		    	}
		         $j('#manufacturer1').append(mfValues);
		         
		       
		  });

function addNomenclatureRow1() {
  i++;
 	var aClone = $('#equipmentGrid>tr:last').clone(true)
 	aClone.find('.ui-datepicker-trigger').remove();
	aClone.find(":input").val("");
 	aClone.find("input[type='checkbox']").prop('checked', false);
 	aClone.find("input[type='radio']").prop('checked', false);
	aClone.find("td:eq(0)").find('select').prop('id', 'departmentId'+i+'');
	aClone.find("td:eq(1)").find(":input").prop('id', 'modelNo'+i+'');
	aClone.find("td:eq(2)").find(":input").prop('id', 'serialNo'+i+''); 
	aClone.find("td:eq(3)").find(":input").prop('id', 'depreciation'+i+'');
	aClone.find("td:eq(4)").find(":input").prop('id', 'price'+i+'');
	aClone.find("td:eq(5)").find(":input").prop('id', 'make'+i+'');
	aClone.find("td:eq(6)").find(":input").prop('id', 'manufacturer'+i+'');
	aClone.find("td:eq(7)").find(":input").prop('id', 'technical'+i+'');
	/* aClone.find("td:eq(8)").find(":radio").prop('id', 'warranty'+i+'');
	aClone.find("td:eq(9)").find(":radio").prop('id', 'amc'+i+'');
	aClone.find("td:eq(10)").find(":checkbox").prop('id', 'accessary'+i+''); */
	//aClone.find("td:eq(8)").find(":checkbox").prop('id', 'installed'+i+'').prop('value',i);
	aClone.find("td:eq(8)").find("input[type='text']").prop('id', 'installedDate'+i+'').removeClass('hasDatepicker');
	//aClone.find("td:eq(8)").find("div.dateHolder ").prop('id', 'showdiv' + i + '').hide();
	aClone.find("td:eq(9)").find(":input").prop('id', 'rvNo'+i+'');
	aClone.find("td:eq(10)").find(":input").prop('id', 'rvDate'+i+'').removeClass('hasDatepicker');
	aClone.clone(true).appendTo('#equipmentGrid');
	
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

function submitForm() {
var rows = document.getElementById("equipmentGrid").getElementsByTagName("tr").length;
	  var equipmentDate = $j("#equipmentDate").val();
	  var nomenclature1 = $j("#nomenclature1").val();
	  if (nomenclature1 == null || nomenclature1 == "") {
          alert("Please select Nomenclature/PVMS No.");
          return false;
      }
	  if (equipmentDate == null || equipmentDate == "") {
          alert("Please select equipment details date");
          return false;
      }
	   var scale = $j("#scale").val();
	   if (scale == null || scale == "") {
          alert("Please enter authorized ME scale");
          return false;
      }
	   var qty = $j("#qty").val();
	   if (qty == null || qty == "") {
          alert("Please enter authorized Qty");
          return false;
      }
	  var flag=0;
	   $("#equipmentGrid tr").each(function () {
	 	 var dept=$(this).find('td:eq(0)').find('select').val();
	 	 var modelNo=$(this).find('td:eq(1)').find(':input').val();
		 var scaleNo=$(this).find('td:eq(2)').find(':input').val();
		 var depriciation=$(this).find('td:eq(3)').find(':input').val();
		 var price=$(this).find('td:eq(4)').find(':input').val(); 
		 var make=$(this).find('td:eq(5)').find(':input').val();
	 	 var manufacturer=$(this).find('td:eq(6)').find('select').val()
		 var technical=$(this).find('td:eq(7)').find(':input').val();
	 	 var installed=$(this).find('td:eq(8)').find('input[type="text"]').val();
		 var rvNumber=$(this).find('td:eq(9)').find(':input').val();
		 var rvDate=$(this).find('td:eq(10)').find(':input').val(); 
		if (dept == null || dept == "" || dept == 0) {
	         alert("Please select department");
	         flag=1;
	         return false;
	     }
		  if (modelNo == null || modelNo == "") {
	         alert("Please enter model number");
	         flag=1;
	         return false;
	     }
	     if (scaleNo == null || scaleNo == "") {
	        alert("Please enter serial No");
	        flag=1;
	        return false;
	    }
	     
	     if (depriciation == null || depriciation == "") {
	         alert("Please enter depreciation ");
	         flag=1;
	         return false;
	     }
		  if (price == null || price == "") {
	         alert("Please enter price");
	         flag=1;
	         return false;
	     }
	     if (make == null || make == "") {
	        alert("Please enter make");
	        flag=1;
	        return false;
	    }
	     if (manufacturer == null || manufacturer == "" || manufacturer == 0) {
		        alert("Please select manufacturer");
		        flag=1;
		        return false;
		    }
	     if (technical == null || technical == "") {
		        alert("Please enter technical specification");
		        flag=1;
		        return false;
		    }
	     if (installed == null || installed == "") {
		        alert("Please select installation date");
		        flag=1;
		        return false;
		    }
	     
	     if (rvNumber == null || rvNumber == "") {
		        alert("Please enter RV number");
		        flag=1;
		        return false;
		    }
	     if (rvDate == null || rvDate == "") {
		        alert("Please select RV date");
		        flag=1;
		        return false;
		    }
	      	var rd = rvDate.split("/");
			var rDate= new Date(rd[2], rd[1] - 1, rd[0])
			
			var insd = installed.split("/");
			var insDate= new Date(insd[2], insd[1] - 1, insd[0])
			 if (rDate  > insDate) {
				 	 	alert("Installation Date cannot be earlier than the RV Date");
					 	 flag=1;
					 	return false;
		    }
	     
	   
	  });
	    if(flag==1){
	    	return false;
	    }
	 	 
		$("#submitEquipmentDetails").submit();
	    
		 setTimeout(function(){ 			 
			    $("#submitForm1").attr("disabled", "disabled");
		 }, 50);
		
	    
	   // return true;
	   
	   
}


function removeRowIndent(obj){
	var rowCount = $('#equipmentGrid tr').length;
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
function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

function showDate(obj) {
	  var currentValue = $('#'+obj.id).val();
	  if ($('#'+obj.id).prop('checked')==true) 
	    $("#showdiv"+currentValue).show() ;
	  else
		  $("#showdiv"+currentValue).hide() ;
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
	 var idddd =$(obj).closest('tr').find("td:eq(2)").find("input").attr("id");
	// var serialNo=$(this).find('td:eq(1)').find(':input').val();
	 var iddddValue =$(obj).closest('tr').find("td:eq(2)").find("input").val();
	 $("#equipmentGrid tr").each(function () {
		var thisId =$(this).closest('tr').find("td:eq(2)").find("input").attr("id");
		var vId=$(this).find('td:eq(2)').find('input').val();
		  if (vId == iddddValue && thisId!=idddd) {
       alert("Serial No already exist ");
       $(obj).closest('tr').find("td:eq(2)").find("input").val("");
       flag=1;
   }
	  if( flag==1){
	         return false;

	  }
});
} 
			</script>
			</html>