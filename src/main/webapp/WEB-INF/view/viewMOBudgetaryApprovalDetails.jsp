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
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opd.js"></script> --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

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
	long departmentId = 0;
	String departmentName="";
		  if (session.getAttribute("department_id") != null) {
		   departmentId = Long.parseLong(session.getAttribute("department_id").toString());
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
<title>create indent</title>
<!--   <link href="/AshaWeb/resources/css/stylecommon.css" rel="stylesheet" type="text/css" /> -->



</head>

<%
	int i = 1;
%>

<body>
 <p align="center" id="messageId" style="color:green; font-weight: bold;" >${message}</p>
	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<div class="">
				<div class="container-fluid">
					<div class="internal_Htext"> BUDGETARY LIST</div>

					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<form:form name="submitBudgetary" id="submitBudgetary" method="post"
										action="${pageContext.request.contextPath}/lpprocess/moBudgetaryApproval" autocomplete="off">
									<div class="row">
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-md-4 col-form-label"> Requested On</label>
												<div class="col-md-7">
													<!-- <input type="date" class="form-control custom_date" name="fromDate" id="fromDate"> 
													<input  type="text" class="form-control custom_date calDate"  name="fromDate" id="fromDate" placeholder="DD/MM/YYYY" validate="To Date,string,yes"/> -->
													<div class="dateHolder">
														<input type="text"
															class="custom_date datePickerInput form-control"
															name="lpDate" id="lpDate" placeholder="DD/MM/YYYY"
															validate="From Date,string,yes" value="" maxlength="10"  />
													</div>
													<!-- <input  type="text" class="calDate custom_date datePickerInput form-control"  id="appointmentDate" name="appointmentDate" placeholder="DD/MM/YYYY" validate="From Date,string,yes" value=""  maxlength="10" />
													 -->
												</div>
											</div>
										</div>
										
										<div class="col-md-4">
											<div class="form-group row">
												<label class="col-md-4 col-form-label"> Created By</label>
												<div class="col-md-7">
													<input type="text" class="form-control" id="createdBy" name="createdBy" readonly="readonly"/>
												
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
												<th>Nomenclature/PVMS No.</th>
												<th>A/U</th>
												<th>Required Quantity</th>
												<th>Last LP Unit Rate</th>
												<th>Item Value</th>
												

											</tr>
											<tbody id="nomenclatureGrid">
												<tr>
													<!-- <td><input class="checkboxes" type="checkbox"
														name="chkbox" value=""></td> -->
													<!-- <td>1</td> -->

													<td>
														<div class="autocomplete">
															<input type="text" value="" autocomplete="never"
																spellcheck="false" id="nomenclature1" size="77"
																name="nomenclature" class="form-control border-input width330" readonly="readonly"
																onblur="populatePVMS(this.value,'1',this);" />

														</div>
													</td>

													<td><input type="text" name="accountingUnit1"
														tabindex="1" id="dispensingUnit1" 
														readonly="readonly" validate="AU,string,no"
														class="form-control" /></td>

													<td><input type="text" name="requiredQty" tabindex="1"
														autocomplete="nope" spellcheck="false" value="" readonly="readonly"
														id="requiredQty1"   class="form-control" onkeypress="return isNumberKey(event)" onblur="calculateAmount('1')"/></td>

													<td><input type="text" id="lpunitrate1"
														 name="lpunitrate" onkeypress="return isNumberKey(event)" readonly="readonly"
														class="form-control" onblur="calculateAmount('1')"/></td>
													<td><input type="text" id="itemValue1"
														 name=""itemValue"" readonly="readonly"
														class="form-control" /></td>
													<td style="display: none;"><input type="hidden" readonly="readonly"
														value="" tabindex="1" id="itemIdNom1" size="77"
														name="itemIdNom" /></td>

													<td style="display: none;"><input type="hidden"
														name="pvmsNo1" tabindex="1" id="pvmsNo1" size="10"
														readonly="readonly" /></td>
														
														<td style="display: none;"><input type="hidden"
														name="budgetaryMId1" tabindex="1" id="budgetaryMId1" size="10"
														readonly="readonly" /></td>
														
													<td style="display: none;"><input type="hidden"
														name="budgetaryTId1" tabindex="1" id="budgetaryTId1" size="10"
														readonly="readonly" /></td>
														
													
												</tr>

											</tbody>
											<tr>
										</table>
									</div>
									<div class="row">
										<div class="col-md-4 offset-md-8">
											<div class="form-group row">
												<label class="col-md-4 col-form-label">Approx Cost</label>
												<div class="col-md-8">
													<input type="text" id="approxCost" readonly="readonly" name="approxCost"
														class="form-control" />
												</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12 text-right">
								
													
											<c:if test="${flag!='flag'}">
														<a  class="buttonDel  btn btn-primary " role="button"
															href="${pageContext.request.contextPath}/lpprocess/budgetaryApprovalByMOList">Close</a>
											</c:if>
													
											<c:if test="${flag=='flag'}">
														<a  class="buttonDel  btn btn-primary " role="button"
															href="${pageContext.request.contextPath}/lpprocess/budgetaryList">Close</a>
											</c:if>
											
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
    
    
   
});

var autoVsPvmsNo = '';
var data='';
var itemIds = '';
var record=1;
$j(document).ready(
  function getMastStoreItem(){
	//if department not in session
	   	if(<%= departmentId %>!=0){
				$j("#submitBudgetary :input").attr("disabled", false);
				}else{
				alert("Select the department");
				$j("#submitBudgetary :input").attr("disabled", true);
				return false;
			}
		var dataList = ${data};
		var resultList= dataList.data;
		var count=dataList.count;
		record=1;
		 var j=0;
		 
			for(item in resultList){
				 if(item==1){
									   $j('#lpDate').val(resultList[item].reqDate);
								  	   $j('#createdBy').val(resultList[item].createdBy);
								  	   $('#approxCost').val(resultList[item].approxCost);
								  }
	 j++;
	 $('#nomenclature'+j).val(resultList[item].NomPvmsNo);
	 $('#dispensingUnit'+j).val(resultList[item].accountingUnit);
	 $('#requiredQty'+j).val(resultList[item].requiredQty);
	 $('#itemIdNom'+j).val(resultList[item].itemId);
	 $('#pvmsNo'+j).val(resultList[item].pvmsNo);
	 $('#lpunitrate'+j).val(resultList[item].lpunitrate);
	 $('#budgetaryMId'+j).val(resultList[item].budgetaryMId);
	 $('#budgetaryTId'+j).val(resultList[item].id);
	 $('#itemValue'+j).val(resultList[item].totalCost);
	 
	 $('#record').html(record);
	 //$('#records').html(" Records");
		
	 if(j!==count)
	 addNomenclatureRow1();
}

});

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
aClone.find("td:eq(3)").find(":input").prop('id', 'lastRateForLP'+i+'');
aClone.find("td:eq(4)").find(":input").prop('id', 'itemValue'+i+'');
aClone.find("td:eq(5)").find(":input").prop('id', 'itemIdNom'+i+'');
aClone.find("td:eq(6)").find(":input").prop('id', 'pvmsNo'+i+'');
aClone.find("td:eq(7)").find(":input").prop('id', 'budgetaryMId'+i+'');
aClone.find("td:eq(8)").find(":input").prop('id', 'budgetaryTId'+i+'');
  var  requiredQtyData ='';
  requiredQtyData +='<input type="text" name="requiredQty" tabindex="1"';
  requiredQtyData +='autocomplete="nope" spellcheck="false" value=""';
  requiredQtyData +='id="requiredQty'+i+'"   class="form-control" onkeypress="return isNumberKey(event)" readonly="readonly" onblur="calculateAmount('+i+')"/>';
  var  lpunitrateData1 ='';
  lpunitrateData1 +='<input type="text" id="lpunitrate'+i+'"  name="lpunitrate"';
  lpunitrateData1 +='autocomplete="nope" spellcheck="false" value=""';
  lpunitrateData1 +='class="form-control" readonly="readonly" onblur="calculateAmount('+i+')"/>';

   aClone.find("td:eq(2)").html(requiredQtyData);
   aClone.find("td:eq(3)").html(lpunitrateData1);
   aClone.clone(true).appendTo('#nomenclatureGrid');
   var val = $('#nomenclatureGrid>tr:last').find("td:eq(0)").find(":input")[0];

}

</script>
</body>


</html>