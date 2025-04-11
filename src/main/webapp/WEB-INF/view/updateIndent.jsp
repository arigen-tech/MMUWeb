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
String departmentId = HMSUtil.getProperties("adt.properties", "DISPENSARY_DEPARTMENT_ID").trim();
String departmentName="";
/* 	  if (session.getAttribute("department_id") != null) {
	   departmentId = Long.parseLong(session.getAttribute("department_id").toString());
	  } */
	  
	String mmuId = "1";
	if (session.getAttribute("mmuId") != null) {
		mmuId = session.getAttribute("mmuId") + "";
	}
	String userId = "1";
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
<title>view/update indent</title>
<!--   <link href="/AshaWeb/resources/css/stylecommon.css" rel="stylesheet" type="text/css" /> -->


<script src="${pageContext.request.contextPath}/resources/js/jquery.disableAutoFill.min.js"></script>
</head>

<%
	int i = 1;
%>

<body>
<span style="display:none;">${status}</span>
 
	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext">INDENT VIEW/ UPDATE</div>
			
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
								<p align="center" id="messageId" style="color:green; font-weight: bold;" >${message}</p>
									<form:form name="submitIndentDispencery" id="submitIndentDispencery" method="post"
										action="${pageContext.request.contextPath}/dispencery/updateIndentDispencery" autocomplete="off">
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-md-4 col-form-label"> Indent Date</label>
												<div class="col-md-7">
													<!-- <input type="date" class="form-control custom_date" name="fromDate" id="fromDate"> 
													<input  type="text" class="form-control custom_date calDate"  name="fromDate" id="fromDate" placeholder="DD/MM/YYYY" validate="To Date,string,yes"/> -->
													<div class="dateHolder">
														<input type="text" class="form-control" id="indentDate" name="indentDate" readonly="readonly" />
													</div>
												</div>
											</div>
										</div>
										<!-- <div class="col-md-4">
											<div class="form-group row">
												<label class="col-md-4 col-form-label">To Department</label>
												<div class="col-md-7">
														<input type="date" class="form-control custom_date" name="toDate" id="toDate"> 
												<input  type="text" class="form-control custom_date calDate" name="toDate" id="toDate" placeholder="DD/MM/YYYY" validate="To Date,string,yes"/>
													<input type="text" class="form-control" id="toDept" name="departmentName" readonly="readonly"/>
													<input type="hidden" class="form-control" id="toDeptName" name="departmentId" readonly="readonly"/>
												</div>
											</div>
										</div> -->

									</div>
									
									<div class="row">
										<div class="col-12">
											<span class="searchText" id="record">1</span><span class="searchText" id="records"> Record</span>
											
										</div>
									</div>
									<div class="scrollableDiv m-b-20">

										<table class="table table-hover table-striped table-bordered"
											align="center" cellpadding="0" cellspacing="0"
											id="dgTreatmentGrid">
											<tr>
												<!-- <th>Delete</th>
												<th>S.No</th> -->
												<th>Drug Name/Drug Code</th>
												<th>A/U</th>
												<th>Required Quantity</th>
												<th>Available Stock</th>
												<!-- <th>Stock in Dispensary</th> -->
												<!-- <th>Stock in Stores</th> -->
												<th>Reason for Indent</th>
												 <c:if test="${status=='N'}">
												<th>Add</th>
												<th>Delete</th>
												</c:if>
											</tr>
											<tbody id="nomenclatureGrid">
												<tr>
													<!-- <td><input class="checkboxes" type="checkbox" id="indentIdT1"
														name="indentId" value=""></td>
													<td>1</td> -->
													<c:if test="${status=='N'}">
													<td>
														<div class="autocomplete forTableResp">
															<input type="text" value="" autocomplete="never"
																spellcheck="false" id="nomenclature1" size="77"
																name="nomenclature" class="form-control border-input width330"
																 onKeyUp="getNomenClatureList(this,'populatePVMS','opd','getMasStoreItemList','indent')" />
																<div id="divIdPVMS" class="autocomplete-itemsNew"></div>
														
														</div>
													</td>
													</c:if>
													<c:if test="${status!='N'}">
													<td>
														<div class="autocomplete">
															<input type="text" value="" autocomplete="never"
																spellcheck="false" id="nomenclature1" size="77" readonly="readonly"
																name="nomenclature" class="form-control border-input"
																onblur="populatePVMS(this.value,'1',this);" />

														</div>
													</td>
													</c:if>

													<td><input type="text" name="accountingUnit1"
														tabindex="1" id="dispensingUnit1" 
														readonly="readonly" validate="AU,string,no"
														
														class="form-control" /></td>
														
													<c:if test="${status=='N'}">
													<td><input type="text" name="requiredQty" tabindex="1"
														autocomplete="nope" spellcheck="false" value=""
														id="requiredQty1" size="5" maxlength="5" class="form-control" onkeypress="return isNumberKey(event)" /></td>
													</c:if>
													
													<c:if test="${status!='N'}">
													<td><input type="text" name="requiredQty" tabindex="1"
														autocomplete="nope" spellcheck="false" value="" readonly="readonly"
														id="requiredQty1" size="5" maxlength="5" class="form-control" onkeypress="return isNumberKey(event)" /></td>
													</c:if>
													<td><input type="text" id="availableStock1"
														readonly="readonly" name="availableStock"
														class="form-control" /></td>


													<td style="display: none;"><input type="hidden" name="stockInDispencery" tabindex="1"
														autocomplete="nope" spellcheck="false" id="stockInDispencery1"
														readonly="readonly" size="5" maxlength="3"
														class="form-control" /></td>

													<td style="display: none;"><input type="hidden" name="stockInStore" tabindex="1"
														id="stockInStore1" size="5" validate="total,num,no"
														readonly="readonly" class="form-control" /></td>
													<c:if test="${status=='N'}">
													<td><textarea name="remarks1" tabindex="1"
														id="remarks1" placeholder="" class="form-control width90Percent" ></textarea></td>
													</c:if>

													<c:if test="${status!='N'}">
													<td><textarea name="remarks1" tabindex="1" readonly="readonly"
														id="remarks1" placeholder="" class="form-control width90Percent" ></textarea></td>
													</c:if>

													<td style="display: none;"><input type="hidden"
														value="" tabindex="1" id="itemIdNom1" size="77"
														name="itemIdNom1" /></td>

													<td style="display: none;"><input type="hidden"
														name="pvmsNo1" tabindex="1" id="pvmsNo1" size="10"
														readonly="readonly" /></td>
														
													<td style="display: none;"><input type="hidden"
														name="indentId1" tabindex="1" id="indentId1" size="10"
														readonly="readonly" /></td>
														
													<td style="display: none;"><input type="hidden"
														name="indentMid1" tabindex="1" id="indentMid1" size="10"
														readonly="readonly" /></td>
														 <c:if test="${status=='N'}">
														
														<td>

															<button type="button" class="btn btn-primary buttonAdd noMinWidth"
																name="button" button-type="add" value=""
																onclick="addNomenclatureRow1();showLastRow();" tabindex="1"></button>

														</td>
														<td>


															<button type="button" class="buttonDel  btn btn-danger noMinWidth m-r-10"
																name="button" button-type="delete" value="" tabindex="1"
																onclick="removeRowIndent(this);"></button>

														</td>
														</c:if>
												</tr>

											</tbody>
											
										</table>
									</div>
									
									<div class="row form-group">
										<div class="col-md-12 text-right">
											
												<c:if test="${status=='N'}">
													<input type="submit" class="btn btn-primary "
														name="save" value="Save" id="saveForm1" onclick="return submitForm();"  />
													<input type="submit" class="btn  btn-primary"
														name="submit" 
														value="Submit" id="submitForm1" tabindex="1" onclick="return submitForm();" />
												</c:if>
												
												</form:form>
												
												<form name="frm" style="display:inline;">
												<button id="printReportButton" type="button" class="btn btn-primary"  onclick='makeUrl(${indentMId});'>Print</button>
											  	<a  class="buttonDel  btn btn-primary " role="button"
															href="${pageContext.request.contextPath}/dispencery/viewindentListForViewUpdate">Close</a>
												</form>											
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
	</div>
</body>


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

var user_id = <%= userId %>
var autoVsPvmsNo = '';
var data='';
var itemIds = '';
var record='';
$j(document).ready(
  function getMastStoreItem(){
         var dataList = ${data};
          var resultList= dataList.data;
          var count=dataList.count;
          record=1;
           var j=0;
           
    	 for(item in resultList){
    		 if(item==1){
    			   $j('#toDept').val(resultList[item].toDept);
    		  	   $j('#indentDate').val(resultList[item].indentdate);
    		  	  $j('#toDeptName').val(resultList[item].toDeptId);
    		 }
    		 j++;
    		 $('#nomenclature'+j).val(resultList[item].NomPvmsNo);
    		 $('#dispensingUnit'+j).val(resultList[item].accountingUnit);
    		 $('#requiredQty'+j).val(resultList[item].requiredQty);
    		 $('#availableStock'+j).val(resultList[item].availableStock);
    		 $('#stockInDispencery'+j).val(resultList[item].stockDisp);
    		 $('#stockInStore'+j).val(resultList[item].stockStore);
    		 $('#remarks'+j).val(resultList[item].remark);
    		 $('#itemIdNom'+j).val(resultList[item].itemId);
    		 $('#pvmsNo'+j).val(resultList[item].pvmsNo);
    		 $('#indentId'+j).val(resultList[item].id);
    		 $('#indentIdT'+j).val(resultList[item].id);
    		 $('#indentMid'+j).val(resultList[item].indentMid);
    		 $('#record').html(record);
    		 //$('#records').html(" Records");
 				
    		 if(j!==count)
    		 addNomenclatureRow1();
         }
    	 $("#saveForm1").attr("disabled", false);
		 $("#submitForm1").attr("disabled", false);
  });

</script>

<script type="text/javascript"  >
var arryNomenclature= new Array();
var val=$('#nomenclatureGrid').children('tr:first').children('td:eq(0)').find(':input')[0];
//autocomplete(val, arryNomenclature);

var itemIdPrescription= '';
var i=1;
function addNomenclatureRow1() {
	record=record+1;
	$('#record').html(record);
	$('#records').html(" Records");
    i++;
	var aClone = $('#nomenclatureGrid>tr:last').clone(true)
	aClone.find(":input").val("");
	aClone.find("td:eq(0)").find(":input").prop('id', 'nomenclature'+i+'');
	aClone.find("td:eq(1)").find(":input").prop('id', 'dispensingUnit'+i+'');
	aClone.find("td:eq(2)").find(":input").prop('id', 'requiredQty'+i+'');
	aClone.find("td:eq(3)").find(":input").prop('id', 'availableStock'+i+'');
	/* aClone.find("td:eq(4)").find(":input").prop('id', 'stockInDispencery'+i+''); */
	aClone.find("td:eq(5)").find(":input").prop('id', 'stockInStore'+i+'');
	aClone.find("td:eq(6)").find(":input").prop('id', 'remarks'+i+'');
	//aClone.find("td:eq(0)").find(":input").prop('id', 'indentIdT'+i+'');//chk
	//aClone.find('input[type="text"]').prop('id', 'nomenclature'+i+'');
	aClone.find("td:eq(7)").find(":input").prop('id', 'itemIdNom'+i+'');
	aClone.find("td:eq(8)").find(":input").prop('id', 'pvmsNo'+i+'');
	aClone.find("td:eq(9)").find(":input").prop('id', 'indentId'+i+'');
	aClone.find("td:eq(10)").find(":input").prop('id', 'indentMid'+i+'');
	//aClone.find("td:eq(1)").html(i);
	//aClone.find("option[selected]").removeAttr("selected")
	aClone.find("td:eq(0)").find("div").find("div").prop('id', 'divIdPVMS' + i + '');
	aClone.clone(true).appendTo('#nomenclatureGrid');
	var val = $('#nomenclatureGrid>tr:last').find("td:eq(0)").find(":input")[0];
	
}

function showLastRow(){
	console.log('scroll up:'+ $('table').height());
	 $('.scrollableDiv ').animate({ scrollTop: $('table').height()+10 }, 300);
}

var pvmsNo = '';

function populatePVMS(val, inc,item) {
	//alert("called");
	 $(item).closest('tr').find("td:eq(7)").find(":input").val("");
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
	     			var checkCurrentNomRowId=$(item).closest('tr').find("td:eq(7)").find("input:eq(0)").attr("id");
      			var checkCurrentNomRowVal=$(item).closest('tr').find("td:eq(7)").find("input:eq(0)").val();  
	     			$('#nomenclatureGrid tr').each(function(i, el) {
	     			   var $tds = $(this).find('td')
	  			       var itemIdCheck=  $($tds).closest('tr').find("td:eq(7)").find("input:eq(0)").attr("id");
	     			   var itemIdValue=$('#'+itemIdCheck).val();
	     			   var idddd =$(item).closest('tr').find("td:eq(7)").find("input:eq(0)").attr("id");
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
	     				  $(item).closest('tr').find("td:eq(7)").find(":input").val(itemIds)
	     				  $(item).closest('tr').find("td:eq(8)").find(":input").val(pvmsNo)
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
	 var flag=0;
	  $("#nomenclatureGrid tr").each(function () {
	 	 var nomenclature=$(this).find('td:eq(0)').find(':input').val();
		 var reqQty=$(this).find('td:eq(2)').find(':input').val();
		 var remarks=$(this).find('td:eq(6)').find(':input').val();
		 var itemId=$(this).find('td:eq(7)').find(':input').val(); 
			 if (nomenclature == null || nomenclature == "") {
	         alert("Please select the Drug Name");
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
	    if(flag==1){
	    	return false;
	    }
   
		$("#submitIndentDispencery").submit();
		 
		 setTimeout(function(){ 			 
			// $("#saveForm1").attr("disabled", "disabled");
			  //  $("#submitForm1").attr("disabled", "disabled");
			 $("#saveForm1").attr("disabled", true);
			 $("#submitForm1").attr("disabled", true);
		 }, 50);
	
}
function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

function removeRowIndent(obj){
	
	 var indentId=jQuery(obj).closest("tr").find("td:eq(9)").find(":input").val();
			var aParam =[];
			    
		var rowCount = $('#nomenclatureGrid tr').length;
		if(rowCount!==1){
		var r = confirm("Do you want to delete the record?");
		if (r == true) {
			 if(indentId!==""){
			     aParam.push(indentId);
			     if(aParam.length > 0){
			 		var param={"aParam":aParam};
			 		//  alert(JSON.stringify(param)); 	
			 	jQuery.ajax({
			 	 	crossOrigin: true,
			 	    method: "POST",			    
			 	    crossDomain:true,
			 	    url: "deleteIndentItems",
			 	    data: JSON.stringify(param),
			 	    contentType: "application/json; charset=utf-8",
			 	    dataType: "json",
			 	    success: function(result){
			 	    	if(result.status==1){
			 	    		$(obj).closest('tr').remove();
			 	    	
			 	    	}
			 	    	else if(result.status==0){
			 	    		alert(result.msg);
			 	    	}
			 	    	
			 	    },
			 	    error: function(result) {
			             alert("An error has occurred while contacting the server");
			         }
			 	    
			 	});
			 	
			     }
			 }	
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

function makeUrl(indentId){
	var url="${pageContext.request.contextPath}/report/printIndentReport?indent_id="+indentId;
	openPdfModel(url);
}

function getAvailableStock(val, inc,item) {
	var lpRate=0;
	var itemId=$(item).closest('tr').find("td:eq(7)").find(":input").val();
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
	    			$(item).closest('tr').find("td:eq(5)").find(":input").val(result.storeStock);
	    		
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

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>