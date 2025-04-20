<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@include file="..//view/leftMenu.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<title></title>
<!-- <style>
td i.fa.fa-eye {
    position: absolute;
    top: 9px;
    right: -3px;
    font-size: 11px;
    color: #6592c9;
}
</style> -->
<script>
<% 
String userId = "1";
if (session.getAttribute("user_id") != null) {
	userId = session.getAttribute("user_id") + "";
}
String distIdUsers = "0";
if (session.getAttribute("distIdUsers") != null) {
	distIdUsers = session.getAttribute("distIdUsers").toString();
	//distIdUsers = distIdUsers.replace(",","");
}
%>
var districtList = "" ;
var sourceOfMedicines = "";
var modelResponse = null;
var batchNo="";
function enableDiasbleButton(status){
	if(status==true){
		$("#btnSave").prop("disabled", true);
		$("#btnSubmit").prop("disabled", true);
	
	}
	if(status==false)
	{
		$('#btnSave').removeAttr('disabled');
		$('#btnSubmit').removeAttr('disabled');
	}
}

function isFutureDate(idate){
	var today = new Date().getTime(),
	    idate = idate.split("/");

	idate = new Date(idate[2], idate[1] - 1, idate[0]).getTime();
	return (today - idate) < 0 ? true : false;
}

function isFutureMonthYear(month,year){	
	if(parseInt(year)>parseInt(new Date().getFullYear())) {
		return true;
	}
	 if (parseInt(year) == parseInt(new Date().getFullYear()) && parseInt(month) > parseInt(new Date().getMonth())+1){
		 return true;
	 }
	 return false;
}

function islessThanFeatureMonthYear(idate){	
	var month = $('#month').val();
	var year =$('#year').val();
	var invoicDate= idate.split("/");
	
	if(parseInt(invoicDate[2])<parseInt(year)) {
		return true;
	}
	
	if (parseInt(invoicDate[2]) == parseInt(year) && parseInt(invoicDate[1]) < parseInt(month)){
		 return true;
	}
	return false;
}

function getFileExtension(filename)
{
  var ext = /^.+\.([^.]+)$/.exec(filename);
  return ext == null ? "" : ext[1];
}
var phaseVal="";
$(document).ready(function(){
	getMasPhase();
	modelResponse = ${response};
	console.log(modelResponse);
	getDistrictList();

	getSourceOfMedicine();
	//getMedicalStore();action

	getMonthAndYear();
	batchNo=modelResponse.data.batchNo;
	var dataList = modelResponse.data.invoiceDetails;
	var isEditable= modelResponse.data.action==='S';
	phaseVal=modelResponse.data.phase;
    $('#phase').val(phaseVal);
	for(var i=0;i<dataList.length;i++){
		editRow(dataList[i],isEditable);
	}
	if(modelResponse.data.action==='S'){
		enableDiasbleButton(true);
		 $('#btnClose').show();
		 $j('#month').attr("disabled", true);
		 $j('#year').attr("disabled", true);
		 
		  /* $('#my-table tr').css({'pointer-events':'none',
              'background-color':'light-grey'}); */
		 
	}

	
	$('#btnSave').on('click', function(){
		enableDiasbleButton(true)
		var response = saveData("P");
		enableDiasbleButton(response)
		console.log(response);
	});
	$('#btnSubmit').on('click', function(){
		enableDiasbleButton(true)
		var response = saveData("S");
		enableDiasbleButton(response)
	});
	
	$('#btnClose').on('click', function(){
		window.location.href = "${pageContext.servletContext.contextPath}/captureMedicine/pendingmedicineinvoice";
	});
	
});
var phaseId='';
var phaseValue='';
var phaseName='';
function getMasPhase(){
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
					'mmuSearch':'<%=distIdUsers%>'
					}),
				contentType : "application/json",
				type : "POST",
				 success: function(result){
				    	var combo = "<option value=\"\">Select</option>" ;
				    	
				    	for(var i=0;i<result.data.length;i++){
				    		combo += '<option value='+result.data[i].phaseValue+'>' +result.data[i].phaseName+ '</option>';
				    		
				    	}
				    	jQuery('#phase').append(combo);
				    	setTimeout( function() { $('#phase').val(phaseVal);}, 1000);
				    	$j('#phase').attr("disabled", true);
				    	
				    }
				    
				});
			}

function saveData(action){
	var msgAlert='';
    if(action=='P')
    {
    	msgAlert='Record saved successfully';	
    }
    if(action=='S')
    {
    	msgAlert='Record submitted successfully';	
    }
	var formData = new FormData();
	if(!$('#phase').val()){
        alert('Please select Phase');
        return false;
    }
	   if(!$('#ditrictList').val()){
         alert('Please select UPSS');
         return false;
     }
	   if(!$('#cityList').val()){
         alert('Please select City!');
         return false;
     }
	   if(!$('#month').val()){
         alert('Please select Month!');
         return false;
     }
	   if(!$('#year').val()){
         alert('Please select Year!');
         return false;
     }
	   if(isFutureMonthYear($('#month').val(),$('#year').val())){
		   	 alert('Future month or year should not be selected!');
	         return false;
	   }
      var multipleFields=[];
 	 var multipleField ={};
 	 var j=0 ;
 	 var everyFieldValidate=true;
	   $('tbody#medicineInvoiceTable tr').each(function(){
		  
		   var medicineSource = $(this).find("select[id*='medicineSource_"+this.id+"']").val();
		   var medicalStore = $(this).find("select[id*='medicineSubSource_"+this.id+"']").val();
		   var invoice_number = $(this).find("input[id*='invoice_number_"+this.id+"']").val();
		   var invoiceDate = $(this).find("input[id*='invoiceDate_"+this.id+"']").val();
		   var invoice_amount = $(this).find("input[id*='invoice_amount_"+this.id+"']").val();
		   var fileUpload = $(this).find("input[id*='fileUpload_"+this.id+"']");
		   
		   var file = $(fileUpload)[0].files[0];
		   //console.log(file.name);
		   var title = this.title;
		   
		   if(!medicineSource){
			   alert('Please select Medicine source!');
			   everyFieldValidate=false;
	           return false;
		   }
		   if(!medicalStore){
			   alert('Please select Medical Store!');
			   everyFieldValidate=false;
	           return false;
		   }
		   if(!invoiceDate){
			    alert('Invoice Date should not be blank!');
			    everyFieldValidate=false;
	           return false;
		   }
		   /* if(islessThanFeatureMonthYear(invoiceDate)){
			   	 alert('Invoice date should not be earlier than the selected month and year!');
			   	 everyFieldValidate = false;
		         return false;
		   } */
		   var billMonth = $('#month').val();
		   var billYear =$('#year').val();
		   var dts = invoiceDate.split('/');
	       var insDts = new Date(dts[2], dts[1]-1, dts[0]);
		   var insDts = new Date(dts[2], dts[1]-1);
		   var billMontYear=new Date(billYear, billMonth-1);
	        if(insDts>billMontYear){
	            alert('Invoice date should not be later than the selected month and Year!');
	            everyFieldValidate = false;
	            return false;
	        }
	        if(insDts<billMontYear){
	            alert('Invoice date should not be less than the selected month and Year!');
	            everyFieldValidate = false;
	            return false;
	        }
		   if(isFutureDate(invoiceDate)){
			   alert('Invoice Date should not be future date!');
			   everyFieldValidate=false;
	           return false;
		   }
		   if(!invoice_number){
			    alert('Invoice Number should not be blank!');
			    everyFieldValidate=false;
	           return false;
		   }
		  
		   if(!invoice_amount){
			    alert('Invoice Amount should not be blank!');
			    everyFieldValidate=false;
	           return false;
		   }
		    if(file === undefined && title === ""){
			   alert('File should not be blank!');
			   everyFieldValidate=false;
	           return false;
		   }  
	
		    
		    if(title != ""){
		    	formData.append("invoiceDetails['"+j+"'].invoiceId",title);		    	
		    }
		    if(file!=undefined){
		    	var fileName= file.name;
		    	formData.append("invoiceDetails['"+j+"'].fileTypeValue",file);
		    	formData.append("invoiceDetails['"+j+"'].fileName",fileName);
		    	  var fileExtension = getFileExtension(fileName);
				     if (fileExtension != "xls" && fileExtension!= "xlsx" && fileExtension!= "pdf") {
				    	alert('Only pdf and excel file support!');
				    	everyFieldValidate=false;
				        return false;
				     }
		    }
		    
		    
		    formData.append("invoiceDetails['"+j+"'].sourceOfMedicine",medicineSource);
		    formData.append("invoiceDetails['"+j+"'].medicalStore",medicalStore);
		    formData.append("invoiceDetails['"+j+"'].invoiceDate",invoiceDate);
		    formData.append("invoiceDetails['"+j+"'].invoiceNum",invoice_number);
		    formData.append("invoiceDetails['"+j+"'].inoviceAmount",invoice_amount);
		    
		   
		    
		    j++; 
		});
		

		formData.append("cityId",$('#cityList').val());
		formData.append("city",$("#cityList  option:selected").text());
		formData.append("district",$("#ditrictList  option:selected").text());
		formData.append("districtId",$('#ditrictList').val());
		formData.append("month",$('#month').val());
		formData.append("year",$('#year').val());
		formData.append("action",action);
		formData.append("batchNo",batchNo);
		formData.append("userId",<%= userId%>);
		formData.append("headTypeId","3");
		formData.append("phase",$('#phase').val());
		
		if(!everyFieldValidate){
			enableDiasbleButton(false);
			return;
		}
	 	$.ajax({
			type : "POST",				
			url : "${pageContext.servletContext.contextPath}/captureMedicine/captureInvoiceDetail",
			
			data: formData, 
			processData: false,
			contentType: false,
			beforeSend : function(xhr) {
			//	xhr.setRequestHeader('Content-Type', 'multipart/form-data');
			},
			success : function(resultData) {
				//success message mybe...
				
				const response = JSON.parse(resultData);
				if(response.status===1){				
					console.log(resultData);
					setTimeout(function(){
						callback()
				         // alert("This is the alert message for timer");
				      }, 3000);
					enableDiasbleButton(false);
					alert(msgAlert);
					//alert('Data saved successfully'+'S');
					
				}else{
					enableDiasbleButton(false);
					alert(response.msg);
				}
			},
			error : function(data) {
				
				var response = "Some error occured";
				console.log(response);

			}
		});
}
function callback(){
	window.location.href = "${pageContext.servletContext.contextPath}/captureMedicine/pendingmedicineinvoice";
}
function getDistrictList(){
	console.log("${pageContext.servletContext.contextPath}/master/getAllDistrict");
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getAllDistrict",
	    data: JSON.stringify({"PN" : "0","upssFlag":"Y"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		districtList += '<option value='+result.data[i].districtId+'>' +result.data[i].districtName+ '</option>';
	    	}
	    	
	    	jQuery('#ditrictList').append(districtList);
	    
	    	$('#ditrictList').val(modelResponse.data.districtId);
	    	getCityList(modelResponse.data.districtId);
	    }
	    
	});
}

function getSourceOfMedicine(row,defaultValue,childValue){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "GET",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/captureMedicine/sourceOfMedicine",
	   
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var sourceOfMedicines= "";
	    	for(var i=0;i<result.data.length;i++){
	    		sourceOfMedicines += '<option value='+result.data[i].id+'>' +result.data[i].name+ '</option>';	
	    	}
	    	jQuery('#medicineSource_'+row).append(sourceOfMedicines);
	    	if(defaultValue){
	    		$('#medicineSource_'+row).val(defaultValue);
	    		getMedicalStore(defaultValue,row,childValue);
	    	}
	    }
	    
	});
}

function getMedicalStore(sourceOfMedicine,row,defaultValue){
	$j("#medicineSubSource_"+row).empty();
	
	var districtId=$('#ditrictList').val();
	if(districtId=="" || districtId=='undefined'){
		districtId=0;
	}
	if(sourceOfMedicine!="" && sourceOfMedicine=='2'){
		//var upss=$('#ditrictList').val();
		if(districtId=="" || districtId==null || districtId=='0'){
			getSourceOfMedicine();
			alert("Please select UPSS  ");
			return false;	
	 	}
	}
	
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/captureMedicine/getMedicalStore",	  
	    contentType: "application/json; charset=utf-8",
	    data: JSON.stringify({"sourceOfMedicine": sourceOfMedicine,"districtId": districtId}),
	    dataType: "json",
	    success: function(result){
	    	var meedicalStore= "";
	    	for(var i=0;i<result.data.length;i++){
	    		 meedicalStore += '<option value='+result.data[i].id+'>' +result.data[i].supplierName+ '</option>';	
	    	}
	    	
	    	jQuery('#medicineSubSource_'+row).append(meedicalStore);
	    	if(defaultValue){
	    		$('#medicineSubSource_'+row).val(defaultValue);
	    	}
	    	
	    }
	    
	});
}

function getCityList(val){
	$j("#cityList").empty();
	
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getAllCity",
	    data: JSON.stringify({"PN" : "0","districtId": val}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "" ;
	    	for(var i=0;i<result.data.length;i++){
	    		combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
	    	}
	    	$j("#cityList").append('<option value=0>--Select--</option>');
	    	jQuery('#cityList').append(combo);
	    	
	    	$('#cityList').val(modelResponse.data.cityId);
	    	
	    }
	    
	});
}
function getMonthAndYear(){
	const monthNames = ["January", "February", "March", "April", "May", "June",
	    "July", "August", "September", "October", "November", "December"
	  ];
	const currentYear = new Date().getFullYear();
	var months = "" ;
	var year ="";
	for(var i=0;i<monthNames.length;i++){
		months += '<option value='+(i+1)+'>' +monthNames[i]+ '</option>';
	}
	jQuery('#month').append(months);
	$('#month').val(modelResponse.data.month);
	for(var i=5;i>=0;i--){
		year += '<option value='+(currentYear-i)+'>' +(currentYear-i)+ '</option>';
	}
	for(var i=1;i<6;i++){
		year += '<option value='+(currentYear+i)+'>' +(currentYear+i)+ '</option>';
	}
	jQuery('#year').append(year);
	$('#year').val(modelResponse.data.year);
}
function getMMUList(item){
	  $j("#mmuIds").empty();
	  var params;
	  if(item != ''){
		  var cityId = item.value;
		  params = {
					"cityId":cityId
			}
	  }else{
		  params = { };
	  }
	 
		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url: "${pageContext.servletContext.contextPath}/master/getMmuByCityMapping",
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(data) {
				if(data.status == true){
					var list = data.data;
					var mmuDrop = '';
					$j('#mmuIds').find('option').not(':first').remove();
					for(i=0;i<list.length;i++){
						mmuDrop += '<option value='+list[i].mmuId+'>'+list[i].mmuName+'</option>';
					}
					$j('#mmuIds').append(mmuDrop);
				}
			},
			error : function(data) {
				alert("An error has occurred while contacting the server");
			}
		}); 
	}
function addRows(){
    var rowCount = $('#medicineInvoiceTable').children().length;
    var $tr = $('<tr/>');
    var $dateInput = $('<input/>').attr({'type':'text','id':'invoiceDt'+rowCount,'placeholder':'DD/MM/YYYY'}).addClass('calDate form-control invoice-date');
    //var $img = $('<img/>').addClass('ui-datepicker-trigger').attr({'src':'../resources/images/calendar.gif', 'alt':'Select Date','title':'Select Date'});
    var $td1Div = $('<div>').addClass('dateHolder').append($dateInput);
    var $td1 = $('<td/>').append($td1Div);

    var $invoiceNoInput = $('<input/>',{'type':'text'}).addClass('form-control invoice-no');
    var $td2 = $('<td/>').append($invoiceNoInput);

    var $invoiceAmntInput = $('<input/>',{'type':'text'}).addClass('form-control invoice-amount');
    var $td3 = $('<td/>').append($invoiceAmntInput);

    var $fileInput = $('<input/>').attr({'type':'file','class':'inputUpload upload-file'});
    var $fileInputLabel = $('<label/>').addClass('inputUploadlabel upload-file-label').text('Choose File');
    var $fileInputSpan = $('<span/>').addClass('inputUploadFileName').text('No File Chosen');
    var $td4Div = $('<div/>').addClass('fileUploadDiv')
                   .append($fileInput)
                   .append($fileInputLabel)
                   .append($fileInputSpan);
    var $td4 = $('<td/>').append($td4Div);

    var $addBtn = $('<button/>').addClass('btn btn-primary buttonAdd noMinWidth').attr('button-type', 'add').on('click', function(){
        addRow();
    });
    var $deleteBtn = $('<button/>').addClass('buttonDel btn btn-danger noMinWidth').attr('button-type', 'delete').on('click', function(){
         $tr.remove();
     });
    var $td5 = $('<td/>').append($addBtn).append('&nbsp;').append($deleteBtn);

    $tr.append($td1).append($td2).append($td3).append($td4).append($td5);
    $('#medicineInvoiceTable').append($tr);
}
function removeRow(id){
	//$('#medicineInvoiceTable tr#"'+id+'"').remove();
	var iteration = $('#my-table tr').length;
	if(iteration>2){
		$('tbody#medicineInvoiceTable tr#'+id).remove();
	}
   
}

function editRow(itemData,isEditable){
	var disabled = isEditable?'disabled':'';
	var iteration = $('#my-table tr').length;
	getSourceOfMedicine(iteration,itemData.sourceOfMedicine,itemData.medicalStore);
	
	var newRowContent = '<tr id="'+iteration+'" title="'+itemData.invoiceId+'">'+
		 		 '<td><select class="form-control" id="medicineSource_'+iteration+'" onChange="getMedicalStore(this.value,'+iteration+');" '+disabled+'>'+
	    		 '<option value="">--SELECT--</option>'+
	    		 
				 '</select></td>'+
				 '<td><select class="form-control" id="medicineSubSource_'+iteration+'" '+disabled+'>'+
	    		 '<option value="">--SELECT--</option>'+
	    		
				 '</select></td>'+
			 	'<td>'+
			 		'<div class="dateHolder">'+
						'<input type="text" name="invoiceDate" id="invoiceDate_'+iteration+'"	class="calDate form-control" placeholder="DD/MM/YYYY" value="'+itemData.invoiceDate+'" '+disabled+'/>'+
					'</div>'+
			 	'</td>'+
 	'<td>'+
		'<input type="text" name="invoice_number" id="invoice_number_'+iteration+'" class="form-control" placeholder="Invoice Number" value="'+itemData.invoiceNum+'" '+disabled+'>'+
	'</td>'+
 	'<td>'+
 	'<input type="text" name="invoice_amount" id="invoice_amount_'+iteration+'" class="form-control" placeholder="Invoice Amount" onkeypress="return isNumberKey(event)" maxlength="10" value="'+itemData.inoviceAmount+'" '+disabled+'>'+
  	'</td>'+
  	'<td>'+
	'<div class="fileUploadDiv hasFile"><input type="file" class="inputUpload" name="fileUpload" id="fileUpload_'+iteration+'"  accept="application/pdf,application/vnd.ms-excel,.xlsx" '+disabled+'>'+
	'<label class="inputUploadlabel">Remove File</label>'+
	'<span id="" class="inputUploadFileName">'+itemData.fileName+'</span>'+
	
	'</div>'+
	'<button type="button" class="btn noMinWidth"  value ="'+itemData.fileName+'" onclick="downloadRow(this)">View File</button>'+
'</td>'+
 	'<td>'+
		'<button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" 	onclick="addRow()" button-type="add" id="addRow_'+iteration+'" '+disabled+'></button>'+
		'<button type="button" name="delete" value="" id="deleteMC"	class="buttonDel btn btn-danger noMinWidth" button-type="delete" onclick="removeRow('+iteration+')" '+disabled+'></button>'+
	'</td>'+
 '</tr>';
 
 $("#medicineInvoiceTable").append(newRowContent);
 
}
function downloadRow(objButton){
	console.log("executed "+objButton.value);
	//window.location = "download?fileName="+objButton.value;
	window.open("${pageContext.servletContext.contextPath}/captureMedicine/download?fileName="+objButton.value, '_blank').focus();
	//window.open(window.location = "download?fileName="+objButton.value)
}
function addRow(){
	var iteration = $('#my-table tr').length;
	getSourceOfMedicine(iteration);
	var newRowContent = '<tr id="'+iteration+'">'+
		 		 '<td><select class="form-control" id="medicineSource_'+iteration+'" onChange="getMedicalStore(this.value,'+iteration+');">'+
	    		 '<option value="">--SELECT--</option>'+
	    		
				 '</select></td>'+
				 '<td><select class="form-control" id="medicineSubSource_'+iteration+'">'+
	    		 '<option value="">--SELECT--</option>'+
	    		
				 '</select></td>'+
 	
			 	'<td>'+
			 		'<div class="dateHolder">'+
						'<input type="text" name="invoiceDate" id="invoiceDate_'+iteration+'"	class="input_date form-control" value=""  placeholder="DD/MM/YYYY" />'+
					'</div>'+
			 	'</td>'+
 	'<td>'+
		'<input type="text" name="invoice_number" id="invoice_number_'+iteration+'" class="form-control" placeholder="Invoice Number">'+
	'</td>'+
 	'<td>'+
 	'<input type="text" name="invoice_amount" id="invoice_amount_'+iteration+'" class="form-control" placeholder="Invoice Amount" onkeypress="return isNumberKey(event)" maxlength="10">'+
  	'</td>'+
  	'<td>'+
		'<div class="fileUploadDiv">'+
	  	'<input type="file" class="inputUpload" name="fileUpload" id="fileUpload_'+iteration+'" accept="application/pdf,application/vnd.ms-excel,.xlsx">'+
	  	'<label class="inputUploadlabel">Choose File</label>'+
		'<span id="" class="inputUploadFileName">No File Chosen</span>'+											
  	'</div>'+
	'</td>'+
 	'<td>'+
		'<button type="button" type="button" class="btn btn-primary buttonAdd noMinWidth" value="" onclick="addRow()"	button-type="add"></button>'+
		'<button type="button" name="delete" value="" id="deleteMC"	class="buttonDel btn btn-danger noMinWidth" button-type="delete" onclick="removeRow('+iteration+')"></button>'+
	'</td>'+
 '</tr>';
 
 $("#medicineInvoiceTable").append(newRowContent);
}

function isNumberKey(evt) {
	var charCode = (evt.which) ? evt.which : evt.keyCode;
    // Allow only numeric characters (0-9)
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;

    return true;
}

</script>

</head>
<body>
	<!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">View/Update Medicine Invoice Details</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
								
								 
									
									<div class="col-md-3">
										<div class="row col-auto">
											<div class="col-md-5">
												<label class="col-form-label">Phase</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="phase"  >
													<!-- <option value="">--SELECT--</option>
												 	<option value="Phase1">Phase1</option>
													<option value="Phase2">Phase2</option> -->
												</select>
											</div>
										</div>
									</div>
									
									
									<div class="col-md-3">
										<div class="row col-auto">
											<div class="col-md-5">
												<label class="col-form-label">UPSS</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="ditrictList"
													onChange="getCityList(this.value);" disabled>
													<option value="">--SELECT--</option>
												</select>
											</div>
										</div>
									</div>

									<div class="col-md-3">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="cityList" onChange="" disabled>
													<option value="">--SELECT--</option>
												</select>
											</div>
										</div>
									</div>
									</div>
                                   <div class="row">
									<div class="col-md-3">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Month and Year</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="month">
													<option value="">--SELECT--</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group row">
											<div class="col-md-7">
												<select class="form-control" id="year">
													<option value="">--SELECT--</option>
												</select>
											</div>
										</div>
									</div>


								</div>



								<div class="row">


									<div class="col-12">
										<div class="table-responsive">
											<table id="my-table"
												class="table table-striped table-hover table-bordered ">
												<thead class="bg-success" style="color: #fff;">
													<tr>
														<th>Source of Medicine</th>
														<th>Medical Store</th>
														<th>Invoice Date</th>
														<th>Invoice No.</th>
														<th>Invoice Amount</th>
														<th>File</th>
														<th>Action</th>
													</tr>
												</thead>

												<tbody class="" id="medicineInvoiceTable">
												<%int inc=1; %>
												
												</tbody>
											</table>
										</div>
									</div>
								</div>

								<div class="col-md-4">
									<input type="hidden" name="count" id="counter" value="<%=inc%>" />
								</div>
								<div class="row">
									<div class="col-md-12 text-right">
										<input type="button" id="btnSave" type="button"
											class="btn  btn-primary " onclick="" value="Save" /> <input
											type="button" id="btnSubmit" type="button"
											class="btn  btn-primary " onclick="" value="Submit" /> 
											<input
											type="button" id="btnClose" type="button"
											class="btn  btn-primary " onclick="" value="Close" /> 

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
	<!-- END wrapper -->


</body>



</html>