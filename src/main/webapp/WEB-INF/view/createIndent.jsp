<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.mmu.web.utils.HMSUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<head>
<%
	String mmuId = "0";
	if (session.getAttribute("mmuId") != null) {
		mmuId = session.getAttribute("mmuId") + "";
	}
	String userId = "0";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	 String departmentId = HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim();
	 
	 String dispensarycityId = session.getAttribute("dispensaryCityId") + "";
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
<title>create indent</title>
<!--   <link href="/AshaWeb/resources/css/stylecommon.css" rel="stylesheet" type="text/css" /> -->


<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
</head>

<%
	int i = 1;
%>

<body>
 
	<!-- Begin page -->
	<div id="wrapper">
	
		<div class="content-page">									
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">Indent Creation</div>

					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
								<p align="center" style="color:green; font-weight: bold;" >${message}</p>
									<form:form name="submitIndentDispencery" id="submitIndentDispencery" method="post"
										action="${pageContext.request.contextPath}/dispencery/submitIndentDispencery" autocomplete="never">
									<div class="row">
								           
								           <input type="hidden"  name="cittyIdVal"  id="cittyIdVal"/>
								           
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-md-4 col-form-label"> Indent Date</label>
												<div class="col-md-7">
													<!-- <input type="date" class="form-control custom_date" name="fromDate" id="fromDate"> 
													<input  type="text" class="form-control custom_date calDate"  name="fromDate" id="fromDate" placeholder="DD/MM/YYYY" validate="To Date,string,yes"/> -->
													<div class="dateHolder">
														<input type="text"
															class="custom_date datePickerInput form-control"
															name="indentDate" id="indentDate" placeholder="DD/MM/YYYY"
															validate="From Date,string,yes" value="" maxlength="10" readonly="readonly" />
													</div>
													<!-- <input  type="text" class="calDate custom_date datePickerInput form-control"  id="appointmentDate" name="appointmentDate" placeholder="DD/MM/YYYY" validate="From Date,string,yes" value=""  maxlength="10" />
													 -->
												</div>
											</div>
										</div>
										 <div class="col-md-4">
											<div class="form-group row">
												<label class="col-md-4 col-form-label">City</label>
												 <div class="col-md-7" id="city">
												  	
												</div> 
												 
											</div>
											
										</div>

									</div>
									
									<div class="row">
									<div class="col-12">
										<span class="searchText" id="record">1</span><span class="searchText" id="records"> Record</span>
									</div>
											
									</div>
									<div class="scrollableDiv m-b-10">

										<table class="table table-hover table-striped table-bordered"
											align="center" cellpadding="0" cellspacing="0"
											id="dgTreatmentGrid">
											<tr>
												<!-- <th>Delete</th> -->
												<!-- <th>S.No</th> -->
												<th>Drug Name / Drug Code</th>
												<th>A/U</th>
												<th>Required Quantity</th>
												<th>Available Stock</th>
												<!-- <th>Stock in Dispensary</th> -->
												<th>Reason for Indent</th>
												<th>Add</th>
												<th>Delete</th>

											</tr>
											<tbody id="nomenclatureGrid">
												<tr>
													<!-- <td><input class="checkboxes" type="checkbox"
														name="chkbox" value=""></td> -->
													<!-- <td>1</td> -->

													<td>
														<div class="autocomplete forTableResp">
															<input type="text" value="" autocomplete="never"
																spellcheck="false" id="nomenclature1" size="77"
																name="nomenclature" class="form-control width330"
																 onKeyUp="getNomenClatureList(this,'populatePVMS','opd','getMasStoreItemList','indent')" />
														<div id="divIdPVMS" class="autocomplete-itemsNew"></div>
														</div>
													</td>

													<td><input type="text" name="accountingUnit1"
														tabindex="1" id="dispensingUnit1" 
														readonly="readonly" validate="AU,string,no"
														class="form-control" /></td>

													<td><input type="text" name="requiredQty" tabindex="1"
														autocomplete="nope" spellcheck="false" value=""
														id="requiredQty1"   class="form-control" onkeypress="return isNumberKey(event)" /></td>

													<td><input type="text" id="availableStock1"
														readonly="readonly" name="availableStock"
														class="form-control" /></td>


													<td style="display: none;"><input type="hidden" name="stockInDispencery" tabindex="1"
														autocomplete="nope" spellcheck="false" id="stockInDispencery1"
														readonly="readonly" size="5" maxlength="3"
														class="form-control" /></td>

													<!-- <td><input type="text" name="stockInStore" tabindex="1"
														id="stockInStore1" size="5" validate="total,num,no"
														readonly="readonly" class="form-control width100" /></td> -->

													<td><textarea name="remarks1" tabindex="1"
														id="remarks1" placeholder="" class="form-control" ></textarea></td>



													<td style="display: none;"><input type="hidden"
														value="" tabindex="1" id="itemIdNom1" size="77"
														name="itemIdNom" /></td>

													<td style="display: none;"><input type="hidden"
														name="pvmsNo1" tabindex="1" id="pvmsNo1" size="10"
														readonly="readonly" /></td>
														
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
											<tr>
										</table>
									</div>
									<div class="row form-group">
										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">

												<div class="button-list">
													<input type="submit" class="btn btn-primary " id="saveForm1"
														name="save" value="Save" onclick="return submitForm();" />
													<input type="submit" class="btn  btn-primary" id="submitForm1"
														name="submit"
														value="Submit" tabindex="1" onclick="return submitForm();" />
 

												</div>
											</div>



										</div>
									</div>
									</form:form>
								</div>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script>
	//scrollbar script
$(function(){
/* var winHeight = $(window).height();

$('.scrollableDiv').css({'height':winHeight-420}); */

// add custom scroll to sscrollableDiv class
    $('.scrollableDiv').slimscroll({
        height: 'inherit',
        position: 'right',
        color: '#9ea5ab',
        touchScrollStep: 50
    });
})

</script>  
<script>

var dept=<%= departmentId %>;
var user_id = <%= userId %>
var autoVsPvmsNo = '';
var data='';
var itemIds = '';
var record=1;
var cityListData ="";
$j(document).ready(
  function getMastStoreItem(){
	   //get department
		var dispCode=resourceJSON.DEPARTMENT_TYPE_CODE_DISP;	
		var storeCode=resourceJSON.DEPARTMENT_TYPE_CODE_STORE;	
		var loggedIndepartment=<%= departmentId %>;
		 var deptValues = "";
         var bloodValues = "";
         var categoryValues = "";
         var cityValues="";
         
         var dictionary = ${departmentList}
         var deptList = dictionary.departmentList;
       
         for (dept in deptList) {
        	 if(loggedIndepartment!=deptList[dept].departmentId && (deptList[dept].departmentType==dispCode || deptList[dept].departmentType==storeCode) )
             deptValues += '<option value=' + deptList[dept].departmentId + '>' + deptList[dept].departmentname + '</option>';
         }
         $j('#departmentId').append(deptValues);
         
         
           cityListData = dictionary.citytList;
       
         if(cityListData.length!=0 && cityListData.length >1){
        	 cityValues="";
        	 cityValues += '<select class="form-control" id="cittyIdValData" name="cittyIdValData"';
        	 cityValues += 'class="medium" onChange="return getCityValueWhenChange()  ;">';
        	 cityValues += '<option value="0"><strong>Select</strong></option>';
         for (cityData in cityListData) {
        	 if(cityListData[cityData].cityId!=undefined){
        		 
        	 cityValues += '<option value=' + cityListData[cityData].cityId + '>' + cityListData[cityData].cityName + '</option>';
         	} 
         }
         cityValues += '</select>';
         }
         if(cityListData.length!=0 && cityListData.length==1){
        	 cityValues="";
        	 for (cityData in cityListData) {
        		 if(cityListData[cityData].cityId!=undefined){
            	 cityValues += '<input type="text" class="form-control departmentListClass" id="cityIdData" name="cityIdData"  value=' + cityListData[cityData].cityName + ' readonly/>';
            	    	 /* cityValues += '<input type="hidden"  name="cittyIdVal" value="'+ cityListData[cityData].cityId+ '" id="cittyIdVal"/>'; */ 	
            	 $('#cittyIdVal').val(cityListData[cityData].cityId);
        		 }	 
        	 }
         }
         if(cityListData.length==0){
        	 cityValues+="Please configure the Indent City in city master";
        	 document.getElementById("city").style.color = "red";
         }
         
         $j('#city').html(cityValues);
        
         
         
         var now = new Date();
     	now.setDate(now.getDate());
     	var day = ("0" + now.getDate()).slice(-2);
     	var month = ("0" + (now.getMonth() + 1)).slice(-2);

     	var today = (day)+"/"+(month)+"/"+now.getFullYear();

     	$j('#indentDate').val(today);
     	//if department not in session
     	if(<%= departmentId %>!=0){
			$j("#submitIndentDispencery :input").attr("disabled", false);
			$("#saveForm1").attr("disabled", false);
			$("#submitForm1").attr("disabled", false);
		}else{
			alert("Select the department");
			$j("#submitIndentDispencery :input").attr("disabled", true);
			return false;
		}
     	$("#saveForm1").attr("disabled", false);
		 $("#submitForm1").attr("disabled", false);
  });

function getCityValueWhenChange(){
	 var cittyIdValData=$( "#cittyIdValData option:selected" ).val();
	 $('#cittyIdVal').val(cittyIdValData);
}

</script>

<script type="text/javascript"  >
var arryNomenclature= new Array();
var val=$('#nomenclatureGrid').children('tr:first').children('td:eq(0)').find(':input')[0];

/* autocomplete(val, arryNomenclature) */;



var itemIdPrescription= '';


var i=1;
var  j=1;
function addNomenclatureRow1() {
	record=record+1;
	$('#record').html(record);
	$('#records').html(" Records");
	
    
    i++;
	var aClone = $('#nomenclatureGrid>tr:last').clone(true)
	aClone.find(":input").val("");
	/* aClone.find("td:eq(0)").find(":input").prop('id', 'chkbox'+i+'');
	aClone.find('input[type="text"]').prop('id', 'nomenclature1'+i+'');	
	aClone.find("td:eq(9)").find(":input").prop('id', 'itemIdNom'+i+'');
	aClone.find("td:eq(10)").find(":input").prop('id', 'pvmsNo'+i+''); */
	aClone.find("td:eq(0)").find(":input").prop('id', 'nomenclature'+i+'');
	aClone.find("td:eq(1)").find(":input").prop('id', 'dispensingUnit'+i+'');
	aClone.find("td:eq(2)").find(":input").prop('id', 'requiredQty'+i+'');
	aClone.find("td:eq(3)").find(":input").prop('id', 'availableStock'+i+'');
	aClone.find("td:eq(4)").find(":input").prop('id', 'stockInDispencery'+i+'');
	//aClone.find("td:eq(5)").find(":input").prop('id', 'stockInStore'+i+'');
	aClone.find("td:eq(5)").find(":input").prop('id', 'remarks'+i+'');
	//aClone.find('input[type="text"]').prop('id', 'nomenclature'+i+'');
	aClone.find("td:eq(6)").find(":input").prop('id', 'itemIdNom'+i+'');
	aClone.find("td:eq(7)").find(":input").prop('id', 'pvmsNo'+i+'');
	aClone.find("td:eq(0)").find("div").find("div").prop('id', 'divIdPVMS' + i + '');
	aClone.clone(true).appendTo('#nomenclatureGrid');
	var val = $('#nomenclatureGrid>tr:last').find("td:eq(0)").find(":input")[0];
	//autocomplete(val, arryNomenclature);
}

function showLastRow(){
	 $('.scrollableDiv ').animate({ scrollTop: $('table').height()}, 300);
}


var pvmsNo = '';
function populatePVMS(val, inc,item) {
	//alert("called");
	 $(item).closest('tr').find("td:eq(6)").find(":input").val("");
	if (val != "") {
		
		var index1 = val.lastIndexOf("[");
		var indexForBrandName = index1;
		var index2 = val.lastIndexOf("]");
		index1++;
		pvmsNo = val.substring(index1, index2);
		var indexForBrandName = indexForBrandName--;
		var brandName = val.substring(0, indexForBrandName);
		// alert("pvms no--"+pvmsNo)

		if (pvmsNo == "") {
			
			return false;
		} 
		else
		{
			document.getElementById('pvmsNo' + inc).value = pvmsNo
			  var pvmsValue = '';
	     	  for(var i=0;i<autoVsPvmsNo.length;i++){
	     		 // var pvmsNo1 = data[i].pvmsNo;
	     		 var masItemIdValue= autoVsPvmsNo[i];
	     		 var pvmsNo1=masItemIdValue[1];
	     		
	     		  if(pvmsNo1 == pvmsNo){
	     			  pvmsValue = masItemIdValue[4];//data[i].dispUnit;
	     			  itemIdPrescription =masItemIdValue[0]; //data[i].itemId;
	     			  itemIds = itemIdPrescription;
	     			var checkCurrentNomRowId=$(item).closest('tr').find("td:eq(6)").find("input:eq(0)").attr("id");
      			var checkCurrentNomRowVal=$(item).closest('tr').find("td:eq(6)").find("input:eq(0)").val();  
	     			$('#nomenclatureGrid tr').each(function(i, el) {
	     			   var $tds = $(this).find('td')
	  			       var itemIdCheck=  $($tds).closest('tr').find("td:eq(6)").find("input:eq(0)").attr("id");
	     			   var itemIdValue=$('#'+itemIdCheck).val();
	     			   var idddd =$(item).closest('tr').find("td:eq(6)").find("input:eq(0)").attr("id");
	     			   var currentidddd=$(item).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id");
	     			   var accId=$(item).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id");
	     			   //if(itemIds!="" &&  itemIdValue!="" && itemIdValue!="undefined" )
	     			   if(itemIdCheck!=checkCurrentNomRowId && itemIds==itemIdValue)	   
 			           {
	     				 if(itemIds==itemIdValue){
	      			        $('#'+idddd).val("");
	      			        $('#'+currentidddd).val("");
	      			        $('#'+accId).val("");
	      			        alert("Drug Name is already added");
	      			        return false;
	     				   
 			           }
 			           }
	     			   else
	     			   {
     				  $(item).closest('tr').find("td:eq(1)").find(":input").val(pvmsValue)
	     				  $(item).closest('tr').find("td:eq(6)").find(":input").val(itemIds)
	     				  $(item).closest('tr').find("td:eq(7)").find(":input").val(pvmsNo)
	     			   }	   
	     				
	     			}); 
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

	
	
	var rows = document.getElementById("nomenclatureGrid").getElementsByTagName("tr").length;
	  var fromDate = $j("#indentDate").val();
	  if (fromDate == null || fromDate == "") {
          alert("Please select fromDate");
          return false;
      }
	  
	  var flag=0;
	  $("#nomenclatureGrid tr").each(function () {
	 	 var nomenclature=$(this).find('td:eq(0)').find(':input').val();
		 var reqQty=$(this).find('td:eq(2)').find(':input').val();
		 var remarks=$(this).find('td:eq(5)').find(':input').val();
		 var itemId=$(this).find('td:eq(6)').find(':input').val(); 
			 if (nomenclature == null || nomenclature == "") {
	         alert("Please select the drug name");
	         flag=1;
	         return false;
	     }
		  if (itemId == null || itemId == "") {
	         alert("Please enter valid data");
	         flag=1;
	         return false;
	     }
	     if (reqQty == null || reqQty == "") {
	        alert("Please enter the required quantity");
	        flag=1;
	        return false;
	    }
	     if (reqQty == 0 ) {
		        alert("Required quantity can not be zero");
		        flag=1;
		        return false;
		    }
	     
	     if (remarks == null || remarks == "") {
		        alert("Please enter the reason for indent");
		        flag=1;
		        return false;
		    }
	  });
	  
	  var cityIdval=$('#cittyIdVal').val();
	    
	    if(cityListData!=null && cityListData.length > 1 && (cityIdval == null || cityIdval == "" || cityIdval=='0') ){
	    	alert("Please select City.");
	    }
	    if (cityIdval == null || cityIdval == "" || cityIdval=='0') {
	    	alert("Please configure the Indent City in city master");
	    	
	          flag=1;
	          return false;
	      }
	    if(flag==1){
	    	return false;
	    }
	 	
		  
		$("#submitIndentDispencery").submit();
	    
		 setTimeout(function(){ 			 
			 //$("#saveForm1").attr("disabled", "disabled");
			  //  $("#submitForm1").attr("disabled", "disabled");
			 $("#saveForm1").attr("disabled", true);
			 $("#submitForm1").attr("disabled", true);
		 }, 50);
		
	    
	   // return true;
	   
	   
}
function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

function removeRowIndent(obj){
	var rowCount = $('#nomenclatureGrid tr').length;
	if(rowCount!==1){
	var r = confirm("Do you want to delete the record?");
	if (r == true) {
			$(obj).closest('tr').remove();
			record=record-1;
			
			if(record==1)
				$('#records').html(" Record");
				$('#record').html(record);
	}
		
	 else {
		
		  return false;
	 }
	} else {
		alert("Atleast one row should be there");
	  return false;
	}
	
}

function getAvailableStock(val, inc,item) {
	var lpRate=0;
	var itemId=$(item).closest('tr').find("td:eq(6)").find(":input").val();
	if (itemId != "") {
		if (val != "") {
		var itemId={"itemId":itemId};
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "getAvailableStock",
	    data:JSON.stringify(itemId),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	if(result.status==1){
	    		
	    			$(item).closest('tr').find("td:eq(3)").find(":input").val(result.availableStock);
	    			$(item).closest('tr').find("td:eq(4)").find(":input").val(result.dispStock);
	    			//$(item).closest('tr').find("td:eq(5)").find(":input").val(result.storeStock);
	    		
	    	}
	    	else if(result.status==0){
	    		alert(result.err_mssg);
	    	}
	    	
	    	
	    },
	    error: function(result) {
         alert("An error has occurred while contacting the server");
     }
	    
	});
	}
	}
}
</script>
</body>


</html>