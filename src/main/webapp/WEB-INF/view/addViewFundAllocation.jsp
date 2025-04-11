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
	
%>
</head>
<script type="text/javascript">
$(document).ready(function(){
	
	//getStoreFinancialYear();
	getMasPhase();
	var financialYear=localStorage.financialYear;
	var financialYearText=localStorage.financialYearText;
	var startDate=localStorage.startDate;
	var endDate=localStorage.endDate;
	$('#financialYear').val(financialYear);
	$('#financialYearText').val(financialYearText);
	$('#financialYearStartDate').val(startDate);
	$('#financialYearEndDate').val(endDate);
	getMasHeadType();
	
	
});

function getMasPhase(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getMasPhase",
	    data: JSON.stringify({"PN" : "0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		combo += '<option value='+result.data[i].phaseValue+'>' +result.data[i].phaseName+ '</option>';
	    		
	    	}
	    	jQuery('#phase').append(combo);
	    	var phaseVal=localStorage.phase;
	    	setTimeout( function() { $('#phase').val(phaseVal);}, 1000);
	    	GetDistrictList(phaseVal);
	    }
	    
	});
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
	    	for(var i=0;i<result.MasStoreFinancialData.length;i++){
	    		combo += '<option value='+result.MasStoreFinancialData[i].financialId+'>' +result.MasStoreFinancialData[i].yearDescription+ '</option>';
	    		
	    	}
	    	
	    	jQuery('#financialYear').append(combo);
	    	
	    }
	    
	});
}

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

function GetDistrictList(phaseVal){
	//var phaseValue=$('#phase').val();
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	     url:"${pageContext.servletContext.contextPath}/master/getAllUpssPhaseMapping",
	    data: JSON.stringify({"PN" : "0","phaseValue":phaseVal}),
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

		  $trNew.find('select').val(function(index, value) {
		    return $trLast.find('select').eq(index).val();
		  });
		  $trNew.find("td:eq(0)").find('select').prop('id', 'upss'+countRecall+'');
		  $trNew.find("td:eq(1)").find('select').prop('id', 'cityId'+countRecall+'');
		  $trNew.find("td:eq(2)").find(":input").val("");
		  $trNew.find("td:eq(3)").find(":input").val("");
		  //$trLast.find('select').eq(0).prop('id', 'upss'+countRecall+'');
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

function removeHeadAmountRow(val){
	if($('#headAmountGrid tr').length > 1) {
	   $(val).closest('tr').remove()
	 }
}

function saveSubmitFundAllocationFunction(val) {
	
	 $('#statusFlag').val(val);
    var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";

    var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/audit/saveFundAllocationDetails";
    
 
    var dateOfUpload = $('#dateOfUpload').val();
    var totalAllocatedAmount = $('#totalAllocatedAmount').val();
    var letterNo = $('#letterNo').val();
    var financialYear = $('#financialYear').val();
  var phaseVal=$('#phase').val();
    if(dateOfUpload=="")
    {
    	alert("Please select date");
 		return false;
    }
    if(phaseVal==""){
    	alert("Please select Phase");
    return false;
    }
    if(totalAllocatedAmount=="")
    {
    	alert("Please enter total allocated amount");
 		return false;
    }
    if(letterNo=="")
    {
    	alert("Please enter letter number");
 		return false;
    }
    if(financialYear=="")
    {
    	alert("Please select financial year");
 		return false;
    }
//////////////////////////////table validation part ////////////////	
    var  idforTable='';
    var caluculateTotalAmount=0;
    $('#headAmountGrid tr').each(function(i, el) {
    	
    	//aClone.find("td:eq(0)").find(":input").prop('id', 'upss'+countRecall+'');
			var $tds = $(this).find('td')
		    var upssName = $tds.eq(0).find(":input").val();
			var cityId = $tds.eq(1).find(":input").val();
   		    var headType = $tds.eq(2).find(":input").val();
  			var amount = $tds.eq(3).find(":input").val();
  			caluculateTotalAmount=Number(caluculateTotalAmount) + Number(amount);          
            var flag=false;
	  			if(upssName== "" && cityId== "" && headType== "" && amount== "" )
				{
					alert("Please Select complete row");
					upssName.focus();
					return false;  	
				}
				if(upssName== "")
	  			{
					alert("Please select UPSS! ");
					upssName.focus();
					return false;      	
				 }
					
				if(cityId== "")
				{
					alert("Please select City ");
					cityId.focus();
					return false;       	
				 }
				if(headType== "")
  				 {
					alert("Please select Head Type ");
					headType.focus();
					return false;       	
				 }
				if(amount== "")
 				 {
					alert("Please enter Amount ");
					amount.focus();
					return false;       	
				 }
		   
		 });
    var totalAmount= $('#totalAllocatedAmount').val();
    if(val=='C')
    {
       	if(totalAmount!=caluculateTotalAmount)
    	{
    		alert("Your Total Allocated Amount is not equal to UPSS Allocated Amount")
    		return false;
    	}	
    }
    if(parseInt(totalAmount) < parseInt(caluculateTotalAmount))
	{
		alert("Your Total Allocated Amount not Less than to UPSS Allocated Amount")
		return false;
	}
    if(!$('#letterUpload').val()){
        alert('Please select Letter file!');
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
			
	var upssId = $tds.eq(0).find(":input").val();
	var cityId = $tds.eq(1).find(":input").val();
	var headTypeId = $tds.eq(2).find(":input").val();
	var amount = $tds.eq(3).find(":input").val();
	
	dataDt={
			'upssId' : upssId,
			'headTypeId':headTypeId,
			'amount' : amount,
			'fundAllocationDtId':"",
			'cityId':cityId
		} 
	tableDataHd.push(dataDt);
	
 });
    
    var dataJSON = {

            'dateOfUpload': $('#dateOfUpload').val(),
            'totalAllocatedAmount': $('#totalAllocatedAmount').val(),
            'letterNo': $('#letterNo').val(),
            'financialYear': $('#financialYear').val(),
            'statusFlag': $('#statusFlag').val(),
            'userId':$('#userId').val(),
            'createdUserId':"",
            'fundAllocationHdId': "",
            'phaseVal':phaseVal,
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
            	localStorage.typeOfVal='fundFirstTime';
                var Id= msg.fundAllocationHdId;
                localStorage.fundAllocationHdId=Id;
                window.location.href ="fundBillSubmit?fundAllocationHdId="+Id+"";
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
	 var currentUppsVal=$(item).closest('tr').find("td:eq(0)").find(":input").val();
	 var currentCityTypeVal=$(item).closest('tr').find("td:eq(1)").find(":input").val();
	 var currentHeadTypeVal=$(item).closest('tr').find("td:eq(2)").find(":input").val(); 
	 var currentRowId= $(item).closest('tr').find("td:eq(0)").find(":input").attr("id");
	//////////////Treatment JSON ///////////////////
		var tableDataHd = [];  
		var dataDt='';
		var idforHead='';
	$('#headAmountGrid tr').each(function(i, el) {
		idforHead= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
	if(document.getElementById('upss').value!= '')
	{
	var $tds = $(this).find('td')
			
	var upssId = $tds.eq(0).find(":input").val();
	var cityId = $tds.eq(1).find(":input").val();
	var headTypeId = $tds.eq(2).find(":input").val();
	var amount = $tds.eq(3).find(":input").val();
	var rowId = $tds.eq(0).find(":input").attr("id");
	if(currentRowId!=rowId)
	//if(parseInt(upssId)+parseInt(headTypeId)+parseInt(cityId)==parseInt(currentUppsVal)+parseInt(currentHeadTypeVal)+parseInt(currentCityTypeVal))
	if(parseInt(upssId)==parseInt(currentUppsVal)&& parseInt(headTypeId)==parseInt(currentHeadTypeVal)&& parseInt(cityId)==parseInt(currentCityTypeVal))	
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
 	 window.location.href ="captureFundAllocation";

}
 
 function checkFutureDate()
 {
	 var invoiceDate = $('#dateOfUpload').val();
	 var dtsVal = invoiceDate.split('/');
     var newdate = new Date(dtsVal[2], dtsVal[1]-1, dtsVal[0]);
     
	 var startDate=$('#financialYearStartDate').val();
	 var dtsValss = startDate.split('-');
	 var startnewdate = new Date(dtsValss[0], dtsValss[1]-1, dtsValss[2]);
	 
	 var endDate=$('#financialYearEndDate').val();
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

</script>
<body>
 <!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">Add/View Fund Allocation</div>
               <form name="headMainData" id="headMainData" method="post" enctype='multipart/form-data'
											action="#" autocomplete="on">
				<div class="row">
				<input type="hidden"  name="userId" value=<%=userId%> id="userId" />
				<input  name="statusFlag" id="statusFlag" type="hidden" value="" />
				<input  name="financialYear" id="financialYear" type="hidden" value="" />
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
											<input type="text" class="form-control" id="financialYearText" value="" disabled="disabled"/>
												<!-- <select class="form-control" id="financialYear">
													<option value="">Select</option>
												</select> -->
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
	                               		<h6 class="font-weight-bold text-theme text-underline">Fund Allocation Details </h6>
	                               	</div>
	                               	
	                               	<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Date</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" name="dateOfUpload" id="dateOfUpload" class="calDate form-control" onchange="checkFutureDate()" placeholder="DD/MM/YYYY">
												</div>
											</div>
										</div>
									</div>
									
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Phase</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="phase" disabled="disabled" >
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
												<label class="col-form-label">Total Allocated Amount</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="totalAllocatedAmount" maxlength="12" onkeypress="if ( isNaN( String.fromCharCode(event.keyCode) )) return false;" name="totalAllocatedAmount"  class="form-control" />
											</div>
										</div>
									</div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Letter No.</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="letterNo" name="letterNo" class="form-control"/>
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
                                                <th>UPSS</th>
                                                <th>City</th>
                                                <th>Head Type</th>
                                                <th>Allocated Amount</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        
                                     <tbody id="headAmountGrid">
										 <tr>
										 	<td>
										 		<select class="form-control" id="upss" name="upss" onchange="checkDuplicateRecord(this);getCityList(this);">
										 			<option value="">Select</option>
										 		</select>
										 	</td>
										 	<td>
										 		<select class="form-control" id="cityId" name="cityId" onchange="checkDuplicateRecord(this);">
										 			<option value="">Select</option>
										 		</select>
										 	</td>
										 	<td>
										 		<select class="form-control" id="headType" name="headType" onchange="checkDuplicateRecord(this);">
										 			<option value="">Select</option>
										 		</select>
										 	</td>
										 	<td>
										 		<input type="text" id="allocatedAmount" maxlength="12" name="allocatedAmount" onkeypress="if ( isNaN( String.fromCharCode(event.keyCode) )) return false;" class="form-control">
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






