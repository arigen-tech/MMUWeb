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
		//distIdUsers = distIdUsers.replace(",","");
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
	getMasHeadType();
	getMasPhase();
	GetDistrictList();
	var data = ${
        data
    };
    getStoreFinancialYear(data)
 //   setTimeout( function() { ;}, 2000);
    setTimeout( function() { getDgFundAllcationHdDt(data); }, 2000);
});
function getStoreFinancialYear(data){
	 $j("#financialYear").empty();
	 var data=data.listObject;
	 
	 var financialYear=data[0].finanicalId;
	 
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getStoreFutureFinancialYear",
	    data: JSON.stringify({"PN" : "0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var selectFre="";
	    		    	
	    	var combo = "" ;
	    	for(var i=0;i<result.MasStoreFinancialData.length;i++){
	    		if (financialYear == result.MasStoreFinancialData[i].financialId) {
					selectFre = "selected";
				} else {
					selectFre = "";
				}
	    		combo += '<option '+selectFre+' value='+result.MasStoreFinancialData[i].financialId+'>' +result.MasStoreFinancialData[i].yearDescription+ '</option>';
	    		
	    	}
	    	
	    	jQuery('#financialYearVal').append(combo);
	    	
	    	
	    }
	    
	});
}

function getMasPhase(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getAllUpssPhaseMapping",
	    data: JSON.stringify({'PN' :"0",
			'mmuSearch':'<%=distIdUsers%>'}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "<option value='0'>Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		combo += '<option value='+result.data[i].phaseValue+'>' +result.data[i].phaseName+ '</option>';
	    		
	    	}
	    	jQuery('#phase').append(combo);
	    }
	    
	});
}
var masHeadType="";
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
	    	masHeadType= result.masHeadTypeData;
	    	for(var i=0;i<result.masHeadTypeData.length;i++){
	    		combo += '<option value='+result.masHeadTypeData[i].headTypeId+'>' +result.masHeadTypeData[i].headTypeName+ '</option>';
	    		
	    	}
	    	
	    	jQuery('#headType').append(combo);
	    	
	    }
	    
	});
}

var masUpss="";
function GetDistrictList(){
	console.log("${pageContext.servletContext.contextPath}/master/getAllDistrict");
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getAllDistrict",
	    data: JSON.stringify({"PN" : "0","upssFlag":"Y","districtUser":'<%=distIdUsers%>'}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var districtList = "" ;
	    	masUpss=result.data;
	    	for(var i=0;i<result.data.length;i++){
	    		districtList += '<option value='+result.data[i].districtId+'>' +result.data[i].districtName+ '</option>';
	    	}
	    	
	    	jQuery('#upss').append(districtList);
	    
	    	
	    }
	    
	});
}



var masCity="";
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
	    	masCity=result.data;
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
		  $trNew.find("td:eq(4)").find("button:eq(1)").val("");
		  //$trLast.find('select').eq(0).prop('id', 'upss'+countRecall+'');
		 // $trLast.find('select').eq(1).prop('id', 'cityId'+countRecall+'');
		  //$trLast.find("option[selected]").prop('id', 'upss'+countRecall+'');
		  //$trLast.find("option[selected]").prop('id', 'cityId'+countRecall+'');
		  $trLast.after($trNew);
	
}

function removeHeadAmountRow(val,dtValue){
	if (confirm(resourceJSON.opdIcdDeleteMsg)) {
	if($('#headAmountGrid tr').length > 1) {
		
		if(dtValue!="")
		{	
		var pathname = window.location.pathname;
		var accessGroup = "MMUWeb";
		var urldeleteGridRow = window.location.protocol + "//"+ window.location.host + "/" + accessGroup+ "/audit/deleteCaptureInterestDtDetails";

		var data = {
			"captureInterestDtId" : dtValue
		};
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : urldeleteGridRow,
			data : JSON.stringify(data),
			dataType : "json",
			cache : false,
			success : function(res) {
		     var datass=res.msg;
		     if(datass=="recordsDeleted")
		    	{
		    	 $(val).closest('tr').remove()
		    	} 
			}
		});
		
	  
	 }
		else
		{
			 $(val).closest('tr').remove()	
		}	
		}
	}
}

function saveSubmitFundAllocationFunction(val) {
	
	 $('#statusFlag').val(val);
    var pathname = window.location.pathname;
    var accessGroup = "MMUWeb";

    var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/audit/saveCaptureInterestDetails";
  
 
   // var dateOfUpload = $('#dateOfUpload').val();
    //var totalAllocatedAmount = $('#totalAllocatedAmount').val();
    //var letterNo = $('#letterNo').val();
    var financialYear = $('#financialYearVal').val();
    var phaseVal=$("#phase").val();
    /* if(dateOfUpload=="")
    {
    	alert("Please select date");
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
    } */
    if(financialYear=="")
    {
    	alert("Please select financial year");
 		return false;
    }
    if(phaseVal=="")
    {
    	alert("Please select Phase.");
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
        
	  			if(upssName== "" && cityId== "" && headType== "" && amount== "" )
				{
					alert("Please Select complete row");
					upssName.focus();
					return false;  	
				}
				if(upssName== "")
	  			{
					alert("Please Select UPSS ");
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
					alert("Please enter Interest ");
					amount.focus();
					return false;       	
				 }
		   
		 });
    //var totalAmount= $('#totalAllocatedAmount').val();
   /*  if(val=='A')
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
	} */	
    
   /*  if(!$('#letterUpload').val()){
        alert('Please select Letter file!');
        return false;
    } */ 
    /* if($('#letterUpload').val()
        && $('#letterUpload').val().indexOf('.pdf') == -1
        && $('#letterUpload').val().indexOf('.docx') == -1
        && $('#letterUpload').val().indexOf('.xls') == -1
        && $('#letterUpload').val().indexOf('.xlsx') == -1){
        alert('Invalid file format Only PDF, Excel and Word file should be uploaded');
        return false;
    } */
    
   /* if(!$('#actionId').val()){
	      alert('Please Select Action ');
	      return false;
	  }*/
	//////////////Treatment JSON ///////////////////
		var tableDataHd = [];  
		var dataDt='';
		var idforHead='';
		var tableDataHdFundHcb = [];  
		var dataDtFundHcb='';
	$('#headAmountGrid tr').each(function(i, el) {
		idforHead= $(this).find("td:eq(0)").find("input:eq(0)").attr("id") 
	
	var $tds = $(this).find('td')
			
	var upssId = $tds.eq(0).find(":input").val();
	var cityId = $tds.eq(1).find(":input").val();
	var headTypeId = $tds.eq(2).find(":input").val();
	//var amount = $tds.eq(2).find(":input").val();
	var amount=$($tds).closest('tr').find("td:eq(3)").find("input:eq(0)").val();
	var captureInterestDtId=$($tds).closest('tr').find("td:eq(3)").find("input:eq(1)").val();
		
	dataDt={
			'upssId' : upssId,
			'headTypeId':headTypeId,
			'cityId' : cityId,
			'amount' : amount,
			'captureInterestDtId':captureInterestDtId
		} 
	tableDataHd.push(dataDt);
	
	dataDtFundHcb={
			'upssId' : upssId,
			'headTypeId':headTypeId,
			'cityId':cityId,
			'amount' : amount
		} 
	tableDataHdFundHcb.push(dataDtFundHcb);
	
 });
    var dataJSON = {

            //'dateOfUpload': $('#dateOfUpload').val(),
            //'totalAllocatedAmount': $('#totalAllocatedAmount').val(),
            //'letterNo': $('#letterNo').val(),
            'financialYear': $('#financialYearVal').val(),
            'statusFlag': $('#statusFlag').val(),
            'userId':$('#userId').val(),
            'captureInterestHdId': $('#captureInterestHdId').val(),
           // 'actionId':$('#actionId').val(),
           // 'approvalRemarks':$('#approvalRemarks').val(),
            'createdUserId':$('#createdUserId').val(),
           // 'createdOn':$('#dateOfentry').val(),
            //'fundLetterName':$('#fundLetterName').val(),
            //'fundLetterNameDuplicate':$('#fundLetterName').val(),
            "listofHeader" : tableDataHd,
            'phaseVal':phaseVal,
            "listofHeaderFundHcb" : tableDataHdFundHcb
    }
    
    var headMainDataVal = $('#headMainData')[0];
	var formData = new FormData(headMainDataVal);
	formData.append('uploadFilePath', "uploads");
	formData.append('uploadRealPath', 1);
   	formData.append('headMainData',JSON.stringify(dataJSON));
  
    $("#submitBtn").attr("disabled", true);
    $("#saveBtn").attr("disabled", true);
    $.ajax({
    	type: 'POST',
		    url : url,
     //   enctype: 'multipart/form-data',
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
            	//var Id= //$('#captureInterestHdId').val()
            	 var Id= msg.msg;
              //  localStorage.typeOfVal='fundApproval';
                //localStorage.fundAllocationHdId=Id;
               // window.location.href ="fundBillSubmit?fundAllocationHdId="+Id+"";
                window.location.href ="captureSubmitInterest?captureInterestHdId="+Id+"&pageFlag=captureInterestViewUpdate";
            } 
            else if(msg.status == 0)
            {
             $("#submitBtn").attr("disabled", false);
             $("#saveBtn").attr("disabled", false);	
             alert(msg.msg)	
            }	
            else
            {
            	$("#submitBtn").attr("disabled", false);
                $("#saveBtn").attr("disabled", false);	
                alert("Please enter the valid data")
            }
        },
        error: function(jqXHR, exception) {
        	$("#submitBtn").attr("disabled", false);
            $("#saveBtn").attr("disabled", false);	
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
 

function getDgFundAllcationHdDt(data) {
	
					var data = data.listObject;
					var count = 1;
					var countins = 1;
					var allocationGridValue = "";
					if (data != null && data.length > 0) {
						for (var i = 0; i < data.length; i++) {
							var captureInterestHdId=data[i].captureInterestHdId;
						//	var letterNo=data[i].letterNo;
							//var totalAmount=data[i].totalAmount;
							var fundAllocationDate=data[i].fundAllocationDate;
							//var fileName=data[i].fileName;
							var districtId=data[i].districtId;
							var headTypeId=data[i].headTypeId;
							var interest=data[i].interest;
							var status=data[i].status;
							var createdOn=data[i].createdOn;
							var createdBy=data[i].createdBy;
							var createdUserId=data[i].createdUserId;
							var cityId=data[i].cityId;
							var cityName=data[i].cityName;
							var financialYear=data[i].finanicalId;
							var finanicalIdText=data[i].finanicalIdText;
							var phaseVal=data[i].phaseVal;
							//$('#downloadBill').attr('data-name', data[i].fileName);
							//$("#letterNo").val(letterNo);
							$("#captureInterestHdId").val(captureInterestHdId);
							//$("#totalAllocatedAmount").val(totalAmount);
							$("#dateOfUpload").val(fundAllocationDate);
							$("#dateOfentry").val(createdOn);
							$("#enterBy").val(createdBy);
							$("#createdUserId").val(createdUserId);
							//$("#fundLetterName").val(data[i].fileName);
							$("#financialYear").val(financialYear);
							//$("#financialYearText").val(finanicalIdText);
							//$("#financialYearStartDate").val(data[i].finanicalYearStartDate);
							//$("#financialYearEndDate").val(data[i].finanicalYearEndDate);
							$("#phase").val(phaseVal);
							allocationGridValue += '<tr>';
							//allocationGridValue += '<td><select class="form-control" id="upss" name="upss"><option value="'+districtId+'">Select</option></select></td>';
							allocationGridValue += '<td ><select name="upss" class="form-control" onchange="checkDuplicateRecord(this);getCityList(this);" id="upss'+ count + '" ';
							allocationGridValue += 'class="medium">';
							var dispStock = data[i].dispUnitId;
							allocationGridValue += '<option value=""><strong>Select</strong></option>';
	
							var selectFre = "";
							$.each(masUpss, function(ijk, item1) {
	
								if (districtId == item1.districtId) {
									selectFre = "selected";
								} else {
									selectFre = "";
								}
								allocationGridValue += '<option ' + selectFre
										+ ' value="' + item1.districtId + '">'
										+ item1.districtName + '</option>';
							});
							allocationGridValue += '</select>';
							allocationGridValue += '</td>';
							//city
							allocationGridValue += '<td ><select name="cityId" class="form-control"  onchange="checkDuplicateRecord(this);" id="cityId'+ count + '" ';
							allocationGridValue += 'class="medium">';
							var dispStock = data[i].dispUnitId;
							allocationGridValue += '<option value=""><strong>Select</strong></option>';
							allocationGridValue += '<option selected value="' + cityId + '">'+ cityName + '</option>';
	                		allocationGridValue += '</select>';
							allocationGridValue += '</td>';
							//allocationGridValue += '<td><select class="form-control" id="headType" name="headType"><option value="'+headTypeId+'">Select</option></select></td>';
							allocationGridValue += '<td ><select name="headType" class="form-control" onchange="checkDuplicateRecord(this);" id="headType'+ count + '" ';
							allocationGridValue += 'class="medium">';
							var dispStock = data[i].dispUnitId;
							allocationGridValue += '<option value=""><strong>Select</strong></option>';
	
							var selectFre = "";
							$.each(masHeadType, function(ijk, item1) {
	
								if (headTypeId == item1.headTypeId) {
									selectFre = "selected";
								} else {
									selectFre = "";
								}
								allocationGridValue += '<option ' + selectFre
										+ ' value="' + item1.headTypeId + '">'
										+ item1.headTypeName + '</option>';
							});
							allocationGridValue += '</select>';
							allocationGridValue += '</td>';
							allocationGridValue += '<td><input type="text" id="interest'+count+'" maxlength="12" value="'+interest+'" onkeypress="if ( isNaN( String.fromCharCode(event.keyCode) )) return false;" name="allocatedAmount" class="form-control"/><input type="hidden"  name="captureInterestDtId" value="'+ data[i].captureInterestDtId+ '" id="fundAllocationDtId'+data[i].captureInterestDtId+ '"/></td>';
							allocationGridValue += '<td><button type="button" type="button"	class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" onclick="addHeadAmountRow()"></button><button type="button" name="delete" value="'+ data[i].captureInterestDtId+ '" id="deleteMC" class="buttonDel btn btn-danger noMinWidth" button-type="delete" onclick="removeHeadAmountRow(this,this.value)"></button></td>';
							
							count++;
						}
						$("#headAmountGrid").html(allocationGridValue);
						
					
					}
					if(data.length!=0){
					if(data[0].status=='A' || data[0].status=='C'){
						$("#submitBtn").attr("disabled", true);
					    $("#saveBtn").attr("disabled", true);
					    $("#saveBtn").attr("disabled", true);
					    $(".buttonDel").attr("disabled", true);
					    $(".buttonAdd").attr("disabled", true);
					    $("#financialYearVal").attr("disabled", true);
						$("#phase").attr("disabled", true);
					    
					    $("input, select, option, textarea", "#headMainData").prop('disabled',true);
					   // $("#headMainData :input").prop('disabled', true);
					    
					 }
					else{
						$("#submitBtn").attr("disabled", false);
					    $("#saveBtn").attr("disabled", false);
					    //$("#headMainData :input").prop('readonly', false);
					    $("input, select, option, textarea", "#headMainData").prop('disabled',false);
					    $(".buttonDel").attr("disabled", false);
					    $(".buttonAdd").attr("disabled", false);
					    $("#financialYearVal").attr("disabled", true);
						$("#phase").attr("disabled", true);
					}
					}
}

function getDownloadData()
{
	var namVal=$('#downloadBill').data('name');
	window.open("${pageContext.servletContext.contextPath}/audit/download?name="+namVal+"&type=fund_letter&keys="+$('#letterNo').val(), '_blank').focus();	
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
	if(document.getElementById('upss1').value!= '')
	{
	var $tds = $(this).find('td')
			
	var upssId = $tds.eq(0).find(":input").val();
	var cityId = $tds.eq(1).find(":input").val();
	var headTypeId = $tds.eq(2).find(":input").val();
	var amount = $tds.eq(3).find(":input").val();
	var rowId = $tds.eq(0).find(":input").attr("id");
	if(currentRowId!=rowId)
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
	window.location = 'captureInterestViewUpdate';
	
}
function backListReport() {
	 window.location.href ="captureInterestViewUpdate";

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

				<div class="internal_Htext">View/ Update Bank Interest</div>
               <form name="headMainData" id="headMainData" method="post"  
											action="#" autocomplete="on">
				<div class="row">
				<input type="hidden"  name="userId" value=<%=userId%> id="userId" />
				<input  name="statusFlag" id="statusFlag" type="hidden" value="" />
				<input type="hidden"  name="captureInterestHdId" value="" id="captureInterestHdId" />
				<input type="hidden"  name="createdUserId" value="" id="createdUserId" />
				<!-- <input type="hidden"  name="fundLetterName" value="" id="fundLetterName" /> -->
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
								<!-- 	<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Financial Year</label>
											</div>
											<div class="col-md-7">
											<input type="text" class="form-control" id="financialYearText" value="" disabled="disabled"/>
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
								 -->	
									<!-- <div class="col-lg-4 col-sm-6">
										<button type="button" class="btn btn-primary" onclick="">Search</button>
									</div> -->
									<!-- <div class="col-lg-4 col-sm-6 text-right">
										<button type="button" class="btn btn-primary" onclick="">Show All</button>
									</div> -->
								</div>
								<!-- <div class="row m-t-20">
	                               	<div class="col-12">
	                               		<h6 class="font-weight-bold text-theme text-underline">Data Entry Details</h6>
	                               	</div>
	                               	
	                               	<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Date Of Entry</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<input type="text" id="dateOfentry" name="dateOfentry" class="form-control" readonly />
												</div>
											</div>
										</div>
									</div>
									
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Entered By</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="enterBy" name="enterBy"  class="form-control" readonly />
											</div>
										</div>
									</div>
									
									
                               	</div> -->
								
								<!-- <div class="row m-t-20">
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
												<select class="form-control" id="phase"  >
													<option value="">Select</option>
													<option value="phase1">Phase1</option>
													<option value="phase2">Phase2</option>
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
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label"></label>
											</div>
											<div class="col-md-7">
												<button class="btn btn-primary" id="downloadBill" href="javascript:void(0)">Download Vendor Bill</button>
												<button name="data" class="btn btn-primary" type="button" id="downloadBill" onclick="getDownloadData()">Download Letter</button>
											</div>
										</div>
									</div>
									
									
									
                               	</div> -->
                               	
                               	
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
                                
                                
                                
                                <div class="row">
									 
										<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Financial Year</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="financialYearVal" disabled>
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
												<select class="form-control" id="phase" disabled>
												
												</select>
											</div>
										</div>
									</div>
									
							 </div>
                                

                                    <table id="tbl" class="table table-striped table-hover table-bordered ">
                                        <thead class="bg-success" style="color:#fff;">
                                            <tr>
                                                <th>UPSS</th>
                                                <th>City</th>
                                                <th>Head Type</th>
                                                <th>Interest</th>
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
										 		<input type="text" id="allocatedAmount" maxlength="12" name="allocatedAmount" class="form-control">
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
                                       <!--  <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">Action</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <select class="form-control" name="actionId" onchange="disbaledAuditorForwardTo()" id="actionId">
                                                        <option value="">--Select--</option>
                                                        <option value="A">Approve</option>
                                                        <option value="R">Reject</option>
                                                    </select>
                                                </div> 
                                            </div>
                                        </div> -->
 										<!-- <div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Remarks</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<textarea name="approvalRemarks"   style="width:600px; height:100px;" maxlength="1000" class="form-control border-input
														validate="referralNote,string,no" id="approvalRemarks"
														cols="0" rows="0" tabindex="5"></textarea>
												</div>
											</div>
										</div>
									</div> -->
                                  
                                    </div>
						      
							<div class="row"> 
                               <div class="col-md-12 text-right">														 
									<!-- <input type="button"  id="submitBtn" type="button" class="btn  btn-primary " onclick="saveSubmitFundAllocationFunction()" value="Submit" />
									<input type="button"  id="saveBtn" type="button" class="btn  btn-primary " onclick="saveSubmitFundAllocationFunction()" value="Save" /> -->
									 <button type="button" id="saveBtn" value="S" onclick="saveSubmitFundAllocationFunction(this.value)"   class="btn btn-primary">Save</button>
                                    <button type="button" id="submitBtn" value="C" onclick="saveSubmitFundAllocationFunction(this.value)" class="btn btn-primary">Submit</button>
									<button type="button" id="backBtn" value="" onclick="backListReport()" class="btn btn-primary">Back</button>
								</div>
                               </div>
                               
                           
                               
                               	
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






