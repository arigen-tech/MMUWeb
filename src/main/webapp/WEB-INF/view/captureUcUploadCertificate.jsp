<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>


<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<title></title>
<%
	String hospitalId = "1";
	if (session.getAttribute("mmuId") != null) {
		hospitalId = session.getAttribute("mmuId") + "";
	}
	String userId = "1";
	if (session.getAttribute("userId") != null) {
		userId = session.getAttribute("userId") + "";
	}
	String userName="";
	if (session.getAttribute("firstName") != null) {
		userName = session.getAttribute("firstName") + "";
	}
	String distIdUsers = "0";
	if (session.getAttribute("distIdUsers") != null) {
		distIdUsers = session.getAttribute("distIdUsers").toString();
		distIdUsers = distIdUsers.replace(",","");
	}
	
	String distIdUsersVal = "";
	if (session.getAttribute("distIdUsers") != null && session.getAttribute("distIdUsers") !="" ) {
		distIdUsersVal = session.getAttribute("distIdUsers").toString();
		//distIdUsersVal = distIdUsersVal.replace(",","");
	}

	String levelOfUser = "0";
	if (session.getAttribute("levelOfUser") != null) {
		levelOfUser = session.getAttribute("levelOfUser").toString();
		levelOfUser = levelOfUser.replace(",","");
	}
	
%>
</head>
<script type="text/javascript">
$(document).ready(function(){
	
	//getStoreFinancialYear();
	/* var financialYear=localStorage.financialYear;
	var financialYearText=localStorage.financialYearText;
	var startDate=localStorage.startDate;
	var endDate=localStorage.endDate;
	$('#financialYear').val(financialYear);
	$('#financialYearText').val(financialYearText);
	$('#financialYearStartDate').val(startDate);
	$('#financialYearEndDate').val(endDate);
	var phaseVal=localStorage.phase;
	$('#phase').val(phaseVal); */
	getMasUpssPhase();	
	getMasHeadType();
	GetDistrictList();
	getStoreFinancialYear();
	
});


function getMasHeadType(){
	 $j("#financialYear").empty();
	
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getMasHeadType",
	    data: JSON.stringify({"PN" : "0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "" ;
	    	for(var i=0;i<result.masHeadTypeData.length;i++){
	    		combo += '<option value='+result.masHeadTypeData[i].headTypeId+'>' +result.masHeadTypeData[i].headTypeName+ '</option>';
	    		
	    	}
	    	
	    	jQuery('#headType').append(combo);
	    	
	    }
	    
	});
}

function GetDistrictList(){
	
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getAllDistrict",
	    data: JSON.stringify({"PN" : "0","upssFlag":"Y","districtUser":<%=distIdUsers%>}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "" ;
	    	for(var i=0;i<result.data.length;i++){
	    		combo += '<option value='+result.data[i].districtId+'>' +result.data[i].districtName+ '</option>';
	    		
	    	}
	    	
	    	jQuery('#upss').append(combo);
	    	
	    }
	    
	});
}

function getCityList(item){
	var currentRowId= $(item).closest('tr').find("td:eq(1)").find(":input").attr("id");
	$j('#'+currentRowId).empty();
	// $j("#mmuIds").empty();
	//var districtId=$j("#upss option:selected").val();
	var districtId=$(item).closest('tr').find("td:eq(0)").find(":input").val();
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getAllCity",
	    data: JSON.stringify({"PN" : "0","districtId": districtId}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "" ;
	    	combo += '<option value="">Select</option>' ;
	    	for(var i=0;i<result.data.length;i++){
	    		
	    		combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
	    		
	    	}
	    	
	    	jQuery('#'+currentRowId).append(combo);
	    	
	    }
	    
	});
}

var countRecall=100;
function addHeadAmountRow() {
	
		countRecall++;
		 var $tableBody = $('#tbl').find("tbody"),
		    $trLast = $tableBody.find("tr:last"),
		    $trNew = $trLast.clone();

		
		  $trNew.find("td:eq(0)").find('select').prop('id', 'headType'+countRecall+'');
		  $trNew.find("td:eq(1)").find(":input").val("");
		  $trNew.find("td:eq(2)").find(":input").val("");

		 // $trLast.find('select').eq(1).prop('id', 'cityId'+countRecall+'');
		  //$trLast.find("option[selected]").prop('id', 'upss'+countRecall+'');
		  //$trLast.find("option[selected]").prop('id', 'cityId'+countRecall+'');
		  $trLast.after($trNew);
	
	/* var aClone = $('#headAmountGrid>tr:last').clone(true)
	//aClone.find(":input").val("");
	aClone.find("td:eq(0)").find(":input").prop('id', 'upss'+countRecall+'');
	aClone.find("td:eq(1)").find(":input").prop('id', 'cityId'+countRecall+'');
	aClone.find("option[selected]").prop('id', 'upss'+countRecall+'');
	aClone.find("option[selected]").prop('id', 'cityId'+countRecall+'');
	//aClone.find("option[selected]").attr('selected', 'selected');
	aClone.clone(true).appendTo('#headAmountGrid'); */
	//var val = $('#headAmountGrid>tr:last').find("td:eq(0)").find(":input")[0];
	//autocomplete(val, arryNomenclature);
	
}

function removeHeadAmountRow(item){
	if($('#headAmountGrid tr').length > 1) {
	   $(item).closest('tr').remove()
	 }
	
	 var currentAvailableVal=$(item).closest('tr').find("td:eq(1)").find(":input").val(); 
	 var currentRowId= $(item).closest('tr').find("td:eq(0)").find(":input").attr("id");
	 var totalAvailableBalance=0;
	$('#headAmountGrid tr').each(function(i, el) {
		var $tds = $(this).find('td')
	var availableVal = $tds.eq(1).find(":input").val();
	var rowId = $tds.eq(1).find(":input").attr("id");
	totalAvailableBalance=parseInt(totalAvailableBalance)+parseInt(availableVal);
     });
	
	$('#availableTotal').val(totalAvailableBalance);

 var currentAvailableValU=$(item).closest('tr').find("td:eq(2)").find(":input").val(); 
	 var currentRowIdU= $(item).closest('tr').find("td:eq(2)").find(":input").attr("id");
	 var totalAvailableBalanceU=0;
	$('#headAmountGrid tr').each(function(i, el) {
		var $tds = $(this).find('td')
	var availableValU = $tds.eq(2).find(":input").val();
	var rowIdU = $tds.eq(2).find(":input").attr("id");
	totalAvailableBalanceU=parseInt(totalAvailableBalanceU)+parseInt(availableValU);
   });
	
	$('#utilizationTotal').val(totalAvailableBalanceU);
}

var phaseId='';
var phaseValue='';
var phaseName='';
function getMasUpssPhase(){
	var upssId=$('#district').val();
	var pathname = window.location.pathname;
	var accessGroup ="MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/master/getAllUpssPhaseMapping";
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'PN' :"0",
					'mmuSearch':'<%=distIdUsersVal%>'
					}),
				contentType : "application/json",
				type : "POST",
				 success: function(result){
				    	var combo = "<option value=\"\">Select</option>" ;
				    	
				    	for(var i=0;i<result.data.length;i++){
				    		combo += '<option value='+result.data[i].phaseValue+'>' +result.data[i].phaseName+ '</option>';
				    		
				    	}
				    	jQuery('#phase').append(combo);
				    	
				    }
				    
				});
}


function saveSubmitFundAllocationFunction(val) {
	
	 $('#statusFlag').val(val);
    var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";

    var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/audit/saveUCDocumentUploadDetails";
    
    var upssId = $('#upss').val();
    var dateOfUpload = $('#dateOfUpload').val();
    var totalAllocatedAmount = $('#totalAllocatedAmount').val();
    var certificateNo = $('#certificateNo').val();
    var financialYear = $('#financialYear').val();
    var phaseVal=$('#phase').val();
	  if(financialYear=="")
	  {
	  	alert("Please select Financial Year");
		return false;
	  }
	  if(upssId=="")
	  {
	  	alert("Please select UPSS!");
			return false;
	  }
	  if(phaseVal==""){
	    	alert("Please select Phase");
	    return false;
	    }
    if(dateOfUpload=="")
    {
    	alert("Please select date of upload");
 		return false;
    }
    
    if(totalAllocatedAmount=="")
    {
    	alert("Please enter total allocated amount");
 		return false;
    }
   
    
    if(certificateNo=="")
    {
    	alert("Please enter certificate no");
 		return false;
    }
//////////////////////////////table validation part ////////////////	
    var  idforTable='';
    var caluculateTotalAmount=0;
    $('#headAmountGrid tr').each(function(i, el) {
    	
    	//aClone.find("td:eq(0)").find(":input").prop('id', 'upss'+countRecall+'');
			var $tds = $(this).find('td')
		    var headType = $tds.eq(0).find(":input").val();
  			var availableBalance = $tds.eq(1).find(":input").val();
  			var availableUtilization = $tds.eq(2).find(":input").val();
  	       var flag=false;
	  			
				if(headType== "")
  				 {
					alert("Please select Head Type ");
					headType.focus();
					return false;       	
				 }
				if(availableBalance== "")
 				 {
					alert("Please enter available balance ");
					amount.focus();
					return false;       	
				 }
				if(availableUtilization== "")
				 {
					alert("Please enter available utilization ");
					amount.focus();
					return false;       	
				 }
		   
		 });
  
    if(!$('#letterUpload').val()){
        alert('Please select document!');
        return false;
    } 
    if($('#letterUpload').val()
        && $('#letterUpload').val().indexOf('.pdf') == -1
        && $('#letterUpload').val().indexOf('.docx') == -1
        && $('#letterUpload').val().indexOf('.xls') == -1
        && $('#letterUpload').val().indexOf('.xlsx') == -1){
        alert('Invalid file format Only PDF, Excel and Word file should be uploaded!');
        return false;
    }
    
	//////////////Treatment JSON ///////////////////
		var tableDataHd = [];  
		var dataDt='';
		var idforHead='';
	$('#headAmountGrid tr').each(function(i, el) {
		idforHead= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
	
	var $tds = $(this).find('td')
			
	
	var headTypeId = $tds.eq(0).find(":input").val();
	var availableBalance = $tds.eq(1).find(":input").val();
	var availableUtilization = $tds.eq(2).find(":input").val();
	
	dataDt={
			'headTypeId':headTypeId,
			'availableBalance' : availableBalance,
			'availableUtilization':availableUtilization,
			'ucUploadDtId':""
		} 
	tableDataHd.push(dataDt);
	
 });
    
    var dataJSON = {
    		
            'dateOfUpload': $('#dateOfUpload').val(),
            'certificateNo': $('#certificateNo').val(),
            'totalAllocatedAmount': $('#totalAllocatedAmount').val(),
            //'letterNo': $('#letterNo').val(),
            'financialYear': $('#financialYear').val(),
            'upssId': $('#upss').val(),
            'statusFlag': $('#statusFlag').val(),
            'remarks':$('#remarks').val(),
            'userId':$('#userId').val(),
            'createdUserId':"",
            'ucUploadHdId': "",
            'phaseVal':phaseVal,
            'flagCheck':"Y",
            "listofHeader" : tableDataHd
    }
    
    var headMainDataVal = $('#headMainData')[0];
	var formData = new FormData(headMainDataVal);
	formData.append('uploadFilePath', "uploads");
	formData.append('uploadRealPath', 1);
   	formData.append('headMainData',JSON.stringify(dataJSON));
  
    $("#submitBtn").attr("disabled", true);
    $("#saveBtn").attr("disabled", true);
    $("#closeBtn").attr("disabled", true);
    $.ajax({
    	type: 'POST',
		    url : url,
        enctype: 'multipart/form-data',
        data: formData,
        processData: false,
        contentType: false,
        cache: false,
        dataType : "json",
        timeout : 100000,
        success: function(msg) {
        	console.log(msg)
            if (msg.status == 1)
            {
            	var statusVal=val;
            	localStorage.typeOfVal=statusVal;
                var Id= msg.fundAllocationHdId;
                localStorage.fundAllocationHdId=Id;
                window.location.href ="ucUploadDocumentSubmit?fundAllocationHdId="+Id+"";
            }
            else if(msg.status == 2)
            {
         
             alert(msg.msg)	
             $("#submitBtn").attr("disabled", false);
             $("#saveBtn").attr("disabled", false);	
             $("#closeBtn").attr("disabled", false);
            }
            else if(msg.status == 0)
            {
             $("#submitBtn").attr("disabled", false);
             $("#saveBtn").attr("disabled", false);	
             $("#closeBtn").attr("disabled", false);
             alert(msg.msg)	
            }	
            else
            {
            	$("#submitBtn").attr("disabled", false);
            	$("#saveBtn").attr("disabled", false);	
                $("#closeBtn").attr("disabled", false);
                alert("Please enter the valid data")
            }
        },
        error: function(jqXHR, exception) {
        	$("#submitBtn").attr("disabled", false);
        	$("#saveBtn").attr("disabled", false);	
            $("#closeBtn").attr("disabled", false);
            var msg = '';
            if (jqXHR.status === 0) {
                msg = 'Not connect.\n Verify Network.';
            } else if (jqXHR.status == 404) {
                msg = 'Requested page not found. [404]';
            } else if (jqXHR.status == 500) {
                msg = 'Internal Server Error [500].';
            } else if (exception === 'parsererror') {
                msg = 'Requested JSON parse failed.';
            } else if (exception === 'timeout') {
                msg = 'Time out error.';
            } else if (exception === 'abort') {
                msg = 'Ajax request aborted.';
            } else {
                msg = 'Uncaught Error.\n' + jqXHR.responseText;
            }
            alert("Response msg is "+msg);
        }
    });

 }
 
 function checkDuplicateRecord(item)
 {

	 var currentHeadTypeVal=$(item).closest('tr').find("td:eq(0)").find(":input").val(); 
	 var currentRowId= $(item).closest('tr').find("td:eq(0)").find(":input").attr("id");
	//////////////Treatment JSON ///////////////////
		var tableDataHd = [];  
		var dataDt='';
		var idforHead='';
	$('#headAmountGrid tr').each(function(i, el) {
		idforHead= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
	if(document.getElementById('headType').value!= '')
	{
	var $tds = $(this).find('td')
			
	
	var headTypeId = $tds.eq(0).find(":input").val();
	var rowId = $tds.eq(0).find(":input").attr("id");
	if(currentRowId!=rowId)
	//if(parseInt(upssId)+parseInt(headTypeId)+parseInt(cityId)==parseInt(currentUppsVal)+parseInt(currentHeadTypeVal)+parseInt(currentCityTypeVal))
	if(parseInt(headTypeId)==parseInt(currentHeadTypeVal))	
	{
		alert("Record already exists")
		$(item).closest('tr').remove()
		return false;
	}
	
	}
  });
 }

 function submitDialouge()
 {

 	$('#msgForSaved').hide();
 	$('.modal-backdrop').hide();
 	location.reload();
 	
 }
 
 function backListReport() {
 	 window.location.href ="trackUcUploadCertificate";

}
 
 function checkFutureDate()
 {
	 
	 var financialYearSelect = document.getElementById("financialYear");
		var financialYearText = financialYearSelect.options[financialYearSelect.selectedIndex].text;
		var financialYearId = financialYearSelect.options[financialYearSelect.selectedIndex].id;
		var tempArray = new Array();
		tempArray = financialYearId.split("@");
		var startDate=tempArray[0];
		var endDate=tempArray[1];
		
	 var invoiceDate = $('#dateOfUpload').val();
	 var dtsVal = invoiceDate.split('/');
     var newdate = new Date(dtsVal[2], dtsVal[1]-1, dtsVal[0]);
     
	// var startDate=$('#financialYearStartDate').val();
	 var dtsValss = startDate.split('-');
	 var startnewdate = new Date(dtsValss[0], dtsValss[1]-1, dtsValss[2]);
	 
	// var endDate=$('#financialYearEndDate').val();
	 var dtsVales = endDate.split('-');
	 var endnewdate = new Date(dtsVales[0], dtsVales[1]-1, dtsVales[2]);
	 
	 var from = Date.parse(startDate);
	 var to   = Date.parse(endDate);
	 var check = Date.parse(newdate );

	 if (check > from && check < to) {

		   if(!invoiceDate){
		       alert('Please Select Invoice Date!');
		       return false;
		   }else{
		        var dts = invoiceDate.split('/');
		        var insDts = new Date(dts[2], dts[1]-1, dts[0]);
		        var todaysDate = new Date();
		        var currDate = new Date(todaysDate.getFullYear(), todaysDate.getMonth(), todaysDate.getDate());
		        if(insDts.getTime() > currDate.getTime()){
		            alert('Date should not be future date!');
		            $('#dateOfUpload').val('');
		            return false;
		        }
		       
		   }
		} else {
		  alert('Date is Not in the Range of Financial Year!');
		  $('#dateOfUpload').val('');
		  return false; 
		}
	 
 }
 
 function calculateSum(item)
 {
	
	 /* var availableBalance=$(item).closest('tr').find("td:eq(1)").find(":input").val();
	 var availableUtilization=$(item).closest('tr').find("td:eq(2)").find(":input").val(); 
	 
	 if(parseInt(availableBalance) < parseInt(availableUtilization))
		{
			alert("Available utilization should not be greater than Available balance")
			//$(item).closest('tr').find("td:eq(1)").find(":input").val('');
			$(item).closest('tr').find("td:eq(2)").find(":input").val('');
			$('#utilizationTotal').val('');
			return false;
		} */
	 calculateUtiliztionBal(item)
 }
 
 function calculateAvailableBal(item)
 {
	 var currentAvailableVal=$(item).closest('tr').find("td:eq(1)").find(":input").val(); 
	 var currentRowId= $(item).closest('tr').find("td:eq(0)").find(":input").attr("id");
	 var totalAvailableBalance=0;
	$('#headAmountGrid tr').each(function(i, el) {
		var $tds = $(this).find('td')
	var availableVal = $tds.eq(1).find(":input").val();
	var rowId = $tds.eq(1).find(":input").attr("id");
	totalAvailableBalance=parseInt(totalAvailableBalance)+parseInt(availableVal);
	
  });
	
	$('#availableTotal').val(totalAvailableBalance);
	
 }
 
 function calculateUtiliztionBal(item)
 {
	 var currentAvailableVal=$(item).closest('tr').find("td:eq(2)").find(":input").val(); 
	 var currentRowId= $(item).closest('tr').find("td:eq(2)").find(":input").attr("id");
	 var totalAvailableBalance=0;
	$('#headAmountGrid tr').each(function(i, el) {
		var $tds = $(this).find('td')
	var availableVal = $tds.eq(2).find(":input").val();
	var rowId = $tds.eq(2).find(":input").attr("id");
	totalAvailableBalance=parseInt(totalAvailableBalance)+parseInt(availableVal);
	
  });
	
	$('#utilizationTotal').val(totalAvailableBalance);
	
 }
 
 function getStoreFinancialYear(){
	 $j("#financialYear").empty();
	
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getStoreFinancialYear",
	    data: JSON.stringify({"PN" : "0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "" ;
	    	combo += '<option value="">Select</option>' ;
	    	for(var i=0;i<result.MasStoreFinancialData.length;i++){
	    		combo += '<option id='+result.MasStoreFinancialData[i].startDate+'@'+result.MasStoreFinancialData[i].endDate+' value='+result.MasStoreFinancialData[i].financialId+'>' +result.MasStoreFinancialData[i].yearDescription+ '</option>';
	    		
	    	}
	    	
	    	jQuery('#financialYear').append(combo);
	    	//getExpiryMedicineNotification();
	    	
	    }
	    
	});
}

</script>
<body>
 <!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">Upload Utilization Certificate</div>
               <form name="headMainData" id="headMainData" method="post" enctype='multipart/form-data'
											action="#" autocomplete="on">
				<div class="row">
				<input type="hidden"  name="userId" value=<%=userId%> id="userId" />
				<input  name="statusFlag" id="statusFlag" type="hidden" value="" />
				<input  name="financialYearStartDate" id="financialYearStartDate" type="hidden" value="" />
				<input  name="financialYearEndDate" id="financialYearEndDate" type="hidden" value="" />
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
									<!-- <div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Financial Year</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" id="financialYear" name="financialYear" disabled="disabled"/>
											</div>
										</div>
									</div> -->
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Financial Year</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="financialYear">
													<option value="">Select</option>
												</select>
											</div>
										</div>
									</div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Scheme</label>
											</div>
											<div class="col-md-7">
												<input type="text" class="form-control" value="MMSSY" disabled="disabled"/>
											</div>
										</div>
									</div>
									
									<!-- <div class="col-lg-4 col-sm-6">
										<button type="button" class="btn btn-primary" onclick="">Search</button>
									</div> -->
									<!-- <div class="col-lg-4 col-sm-6 text-right">
										<button type="button" class="btn btn-primary" onclick="">Show All</button>
									</div> -->
								</div>
								
								
								<div class="row m-t-20">
	                               	<div class="col-12">
	                               		<h6 class="font-weight-bold text-theme text-underline">Details </h6>
	                               	</div>
	                               	
	                               	<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">UPSS</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="upss" name="upss" onchange="checkDuplicateRecord(this);getCityList(this);">
										 			<option value="">Select</option>
										 		</select>
											</div>
										</div>
									</div>
									
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Phase</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="phase"  >
													<!-- <option value="">Select</option>
													<option value="Phase1">Phase1</option>
													<option value="Phase2">Phase2</option> -->
												</select>
											</div>
										</div>
									</div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Date Of Upload</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" name="dateOfUpload" id="dateOfUpload" class="calDate form-control" onchange="checkFutureDate()" placeholder="DD/MM/YYYY">
												</div>
											</div>
										</div>
									</div>
									
									
                               	</div>
                               	
                               	
							<!-- 	<div>
								<div style="float:left">               
                                   <table class="tblSearchActions" cellspacing="0" cellpadding="0" border="0" >   
                                   <tr>
	                                   <td class="SearchStatus" style="font-size: 15px;" align="left">Search Results</td>
	                                  <td></td>
						           </tr>
						         </table>
                                </div>  
                                
                                <div style="float:right">
                                  <div id="resultnavigation">
                                  </div> 
                                </div>  -->

                                    <table id="tbl" class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th>Head Type</th>
                                                <th>Available Balance</th>
                                                <th>Utilization</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody id="headAmountGrid">
										 <tr>
										 	
										 	<td>
										 		<select class="form-control" id="headType" name="headType" onchange="checkDuplicateRecord(this);">
										 			<option value="">Select</option>
										 		</select>
										 	</td>
										 	<td>
										 		<input type="text" id="availableBalance" maxlength="12" name="availableBalance" onkeypress="if ( isNaN( String.fromCharCode(event.keyCode) )) return false;" onchange="calculateAvailableBal(this)" class="form-control">
									 		</td>
									 		<td>
										 		<input type="text" id="availableUtilization" onchange="calculateUtiliztionBal(this)" maxlength="12" name="availableUtilization" onkeypress="if ( isNaN( String.fromCharCode(event.keyCode) )) return false;" class="form-control">
									 		</td>
									 		
										 	<td>
												<button type="button" type="button"
													class="btn btn-primary buttonAdd noMinWidth" value=""
													button-type="add" onclick="addHeadAmountRow()"></button>
												<button type="button" name="delete" value="" id="deleteMC"
													class="buttonDel btn btn-danger noMinWidth"
													button-type="delete" onclick="removeHeadAmountRow(this)"></button>
											</td>
										 </tr>
                     				 </tbody>
                                    </table>
                                    <div class="row">
                                    <div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5"></div></div></div>
									<div class="col-md-3">
										<div class="form-group row">
											<div class="col-md-2">
												<label class="col-form-label">Total</label>
											</div>
											<div class="col-md-10">
												<input type="text" id="availableTotal" name="availableTotal" class="form-control" readonly/>
											</div>
											
										
										</div>
									</div>
									<div class="col-md-3">
										<div></div>
											<div class="col-md-10">
												<input type="text" id="utilizationTotal" name="utilizationTotal" class="form-control" readonly/>
											</div>
											
										
										</div>
									</div>
								
								<div class="row">
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Certificate No.</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="certificateNo" name="certificateNo" class="form-control"/>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Choose File</label>
											</div>
											<div class="col-md-7">
												<div class="fileUploadDiv">
														<input type="file" class="inputUpload" name="letterUpload" id="letterUpload" value="">
														<label class="inputUploadlabel">Choose File</label> 
														<span class="inputUploadFileName">No File Chosen</span>
														
													</div>
											</div>
										</div>
									</div>
									
									<div class="col-md-4">
										<div class="form-group row">
													<div class="col-md-5">
														<label for="service" class="col-form-label">Remarks <span class="mandate"></label>
													</div>
													<div class="col-md-7">
														<textarea name="remarks" id="remarks" class="form-control"  maxlength=200 rows="2"></textarea>
													</div>
												</div>
									</div>
								
								</div>
						
							<div class="row"> 
                               <div class="col-md-12 text-right">														 
									<!-- <input type="button"  id="submitBtn" type="button" class="btn  btn-primary " onclick="saveSubmitFundAllocationFunction()" value="Submit" />
									<input type="button"  id="saveBtn" type="button" class="btn  btn-primary " onclick="saveSubmitFundAllocationFunction()" value="Save" /> -->
									 <button type="button" id="saveBtn" value="S" onclick="saveSubmitFundAllocationFunction(this.value)"   class="btn btn-primary">Save</button> 
                                    <button type="button" id="submitBtn" value="C" onclick="saveSubmitFundAllocationFunction(this.value)" class="btn btn-primary">Submit</button>
									<input type="button"  id="closeBtn" type="button" class="btn  btn-primary " onclick="backListReport()" value="Close" />
								</div>
                               </div>
                               
                              <!--  
                               <div class="row m-t-20">
                               	<div class="col-12">
                               		<h6 class="font-weight-bold text-theme text-underline">Fund Allocation History </h6>
                               	</div>
                               	
                               	<div class="col-12">
                               		<div class="table-responsive">
                               			<table class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th>Date</th>
                                                <th>Total Amount</th>
                                                <th>UPSS</th>
                                                <th>Head Type</th>
                                                <th>Allocated Fund</th>
                                                <th>Letter Number</th>
                                                <th>View File</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody id="">
										 <tr>
										 	<td>22/05/2022</td>
										 	<td>50,000</td>
										 	<td>data</td>
										 	<td>data</td>
										 	<td>data</td>
										 	<td>data</td>
										 	<td><a href='#' class='btn btn-primary'><i class='fa fa-file-alt'></i> View </a></td>
										 </tr>
                     				 </tbody>
                                    </table>
                               		</div>                               	
                               	</div>
                               </div> -->
                               
                               	
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
</form>
<div class="modal" id="msgForSaved" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<span class="Message_htext"><spring:message
								code="lblIndianCoastGuard" /></span>

						<button type="button" onClick="submitDialouge();" class="close"
							data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>

					</div>
					<div class="modal-body">
						<div class="control-group">

							<div class="col-md-12">
								<div class="form-group ">
									<span><spring:message code="msgForSavedFundData" /></span> 
								 </div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button name="data" type="button" class="btn btn-primary"  data-dismiss="modal" value=""
							onClick="submitDialouge();" aria-hidden="true">
							<spring:message code="btnOK" />
						</button>
					
					</div>
					
					
					
				</div>
			</div>
</div>
</body>

</html>






