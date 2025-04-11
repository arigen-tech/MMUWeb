<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@include file="..//view/leftMenu.jsp"%>

<html>
<%
	String vendorId = "0";
	if (session.getAttribute("vendorIdUsers") != null) {
		vendorId = session.getAttribute("vendorIdUsers") + "";
	}
	String userId = "1";
	if (session.getAttribute("user_id") != null) {
		userId = session.getAttribute("user_id") + "";
	}
	
	
%>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MMU</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<title></title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autocomplete/commonAutocomplete.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	loadVendors();
    GetDistrictList();
    $('#invoiceAmount').keypress(function (e) {
       var charCode = (e.which) ? e.which : event.keyCode
       if (String.fromCharCode(charCode).match(/[^0-9]/g) || $(this).val().length > 12){
            console.log(charCode);
           if(charCode == 46 && $(this).val().indexOf('.') == -1)
                return true;
           else return false;
       }
    }).change(function(e){
        var amt = $(this).val();
       	var s = amt.split('.');
    	
    	  if (s[0].length > 10) {
    	    alert("Amount should be max 10 digit before decimal value");
    	    $(this).val('');
    	    return false;
    	  }
    	  if(s.length>1)
    	  {
    	  if (s[1].length > 2) {
    		  alert("Decimal value should be only 2 digit in amount");
    		  $(this).val('');
    		  return false;
    	  }
    	  if (s[1].length < 1) {
    		  alert("Decimal value should be at least 1 digit in amount");
    		  $(this).val('');
    		  return false;
    	  }
    	 }
        if(amt.length > 13){
            alert('Invoice Amount can be only 12 digit number!');
            $(this).val('');
        }
    });

    $('#invoiceNo').keypress(function (e) {
       if($(this).val().length > 30)
            return false;
    }).change(function(e){
        if($(this).val().length > 30){
            alert('Invoice No can be only 30 characters value!');
            $(this).val('');
        }
    });
    
   
   /*  var mmuData = '';
    $('#vendorId').on('change', function(){
        var params = {
            "PN": 0,
            "mmuVendorId": $(this).val()
        }
        $.ajax({
            type : "POST",
            contentType : "application/json",
            url : 'getVendorsMMUAndCity',
            data : JSON.stringify(params),
            dataType : "json",
            cache : false,
            success : function(result) {
                if(result && result.data){
                    $('#cityId').empty().append('<option value="">--Select--</option>');
                    var data = result.data;
                    mmuData = data;
                    for(key in data){
                        var cityData = data[key][0];
                        $('#cityId').append($('<option/>').val(cityData.cityId).text(cityData.cityName));
                    }
                }
            },
            error : function(data) {
                alert("An error has occurred while contacting the server");
            }
        });
    }); */

   /*  $('#cityId').on('change', function(){
        if(mmuData){
            var selectedCity = $(this).val();
            if(selectedCity){
                var mmus = mmuData[selectedCity];
                //alert(JSON.stringify(mmus));
                var mmuList = mmus[1];
                for(var i=0;i<mmuList.length;i++){
                    var mmu = mmuList[i];
                    $('#mmuIds').append($('<option/>').val(mmu.mmuId).text(mmu.mmuName))
                }
            }
        }
    }); */
});

function GetDistrictList(){
	 $j("#mmuIds").empty();
	 $j("#cityId").empty();
	 $j("#phase").empty();
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getAllDistrict",
	    data: JSON.stringify({"PN" : "0","upssFlag":"Y"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "" ;
	    	for(var i=0;i<result.data.length;i++){
	    		combo += '<option value='+result.data[i].districtId+'>' +result.data[i].districtName+ '</option>';
	    		
	    	}
	    	
	    	jQuery('#district').append(combo);
	    	
	    }
	    
	});
}

var phaseId='';
var phaseValue='';
var phaseName='';
function getMasUpssPhase(){
	 $j("#phase").empty();
	 $j("#mmuIds").empty();
   var districtId=$j("#district option:selected").val();
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
					'mmuSearch':districtId
					}),
				contentType : "application/json",
				type : "POST",
				 success: function(result){
				    	var combo = "<option value=\"\">Select</option>" ;
				    	for(var i=0;i<result.data.length;i++){
				    		combo += '<option value='+result.data[i].phaseValue+'@@'+result.data[i].phaseId+'>' +result.data[i].phaseName+ '</option>';
				    		
				    	}
				    	jQuery('#phase').append(combo);
				    	
				    }
				    
				});
}


function getCityList(){
	$j("#cityId").empty();
	 $j("#mmuIds").empty();
	 $j("#phase").empty();
	var districtId=$j("#district option:selected").val();
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
	    	
	    	jQuery('#cityId').append(combo);
	    	
	    }
	    
	});
}
function getMMUList(item){
	  $j("#mmuIds").empty();
	  var params;
	  if(item != ''){
		  //var cityId = item.value;
		  var cityId=$j("#cityId").val();
		  var phaseId=item.value;
		  var splitPhase=phaseId.split("@@");
		  params = {
					"cityId":cityId,
					"vendorInvoice":"Y",
					"phaseId":splitPhase[1]
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
				}else if(data.status == false)
				{
					alert("MMU is not available for selected phase and city !")
				}	
			},
			error : function(data) {
				alert("An error has occurred while contacting the server");
			}
		}); 
	}
function submitForm(val){
////////////////Document Upload File Extension Validation/////////////////
var count = 0;
	 $('#supportingDocs tr').each(function(ij, el) {
    var fileNameValueIDd = $(this).closest('tr').find("td:eq(2)").find("input:eq(0)").attr("id"); 
    var docName = $(this).closest('tr').find("td:eq(0)").find("input:eq(0)").attr("id"); 
    var docNote = $(this).closest('tr').find("td:eq(1)").find("textarea:eq(0)").attr("id"); 
    var fileNameValue = $('#' + fileNameValueIDd).val();
    var docNameValue = $('#' + docName).val();
    var docNoteValue = $('#' + docNote).val();

    // Check if any field is filled
    if (fileNameValue || docNameValue || docNoteValue) {
        // Ensure all fields are filled
        if (!fileNameValue || !docNameValue || !docNoteValue) {
            alert('All fields in a supporting document row must be filled if any input field is filled.');
            count++;
            return false;
        }
    }

    		if (fileNameValue
    	            && fileNameValue.indexOf('.pdf') == -1
    	            && fileNameValue.indexOf('.docx') == -1
    	            && fileNameValue.indexOf('.xls') == -1
    	            && fileNameValue.indexOf('.xlsx') == -1) {
    	       alert('Invalid file format Only PDF, Excel and Word file should be uploaded!');
    	       return false;
    	   }
});
	 
	      
	 	if(count>0){
	 		alert("Please upload valid file.");
	 	}
	
	
    $('#vendorFlag').val(val);
   	var lastApprovalMsg='';
   	var currentdate = getTodayDate(new Date());
    if(val=='submit')
    {
    	lastApprovalMsg='Submitted to Auditor on ('+currentdate+')';
    	
    }
    else if(val=='submitted')
    {
    	lastApprovalMsg='Submitted to Auditor on ('+currentdate+')';
    	
    }
    else
    {
    	lastApprovalMsg='Saved by Vendor on ('+currentdate+')';
    }	
  $('#lastApprovalMsg').val(lastApprovalMsg);  
  if(!$('#vendorId').val()){
       alert('Please Select Vendor ');
       return false;
   }
  if(!$('#district').val()){
      alert('Please Select UPSS ');
      return false;
  }
   if(!$('#cityId').val()){
       alert('Please Select City ');
       return false;
   }
   if(!$('#phase').val()){
       alert('Please Select Phase ');
       return false;
   }
   var mmuIdsVal=[];	
   $("#mmuIds > option").each(
			function() {
				mmuIdsVal.push(this.text);
				var symptomsIdValue=this.value;
				
			});
	
   var selectmmuIdsVal = document.getElementById('mmuIds'); 
   if(mmuIdsVal == "") {
       alert("Please select at least one MMU ");
       document.getElementById('mmuIds').focus(); 
       return false;
     }
   if (selectmmuIdsVal.selectedIndex == -1)
   {
       alert("Please select at least one MMU")
       return false;
   }
  /*  if(!$('#mmuIds').val()){
       alert('Please select at lease one MMU!');
       return false;
   } */
   var billMonth = $('#billMonth').val();
   if(!billMonth){
	   alert('Please Select Bill Month!');
       return false;
   }
   
   var billYear = $('#billYear').val();
   if(!billYear){
       alert('Please Select Bill Year!');
       return false;
   }else{
       var todaysDate = new Date();
       var currDate = new Date(todaysDate.getFullYear(), todaysDate.getMonth(), todaysDate.getDate());
      if(billYear > todaysDate.getFullYear()){
           alert('Bill year should not be future year!');
           return false;
       }
  }
   var billMontYear=new Date(billYear, billMonth);
    var todaysDate = new Date();
    var currDate = new Date(todaysDate.getFullYear(), todaysDate.getMonth());
   if(billMontYear > currDate.getTime()){
           alert('Bill month should not be future month!');
           return false;
       }
  if(!$('#invoiceNo').val()){
       alert('Please Enter Invoice No.!');
       return false;
   }
   var invoiceDate = $('#invoiceDate').val();
   if(!invoiceDate){
       alert('Please Select Invoice Date!');
       return false;
   }else{
        var dts = invoiceDate.split('/');
        var insDts = new Date(dts[2], dts[1]-1, dts[0]);
        var todaysDate = new Date();
        var currDate = new Date(todaysDate.getFullYear(), todaysDate.getMonth(), todaysDate.getDate());
        if(insDts.getTime() > currDate.getTime()){
            alert('Invoice Date should not be future date!');
            return false;
        }
        var insDts = new Date(dts[2], dts[1]-1);
        if(insDts<billMontYear){
            alert('Invoice date should not be earlier than the selected month and Year!');
            return false;
        }
   }
   if(!$('#invoiceAmount').val()){
       alert('Please Enter Invoice Amount!');
       return false;
   }
   if($('#invoiceAmount').val() && parseInt($('#invoiceAmount').val()) <= 0){
       alert('Entered Invoice Amount should be greater than 0!');
       return false;
   }
   if(!$('#fileName').val()||$('#downloadBill').val() ){
       alert('Please select Invoice file!');
       return false;
   } 
   if($('#fileName').val()
       && $('#fileName').val().indexOf('.pdf') == -1
       && $('#fileName').val().indexOf('.docx') == -1
       && $('#fileName').val().indexOf('.xls') == -1
       && $('#fileName').val().indexOf('.xlsx') == -1){
       alert('Invalid file format Only PDF, Excel and Word file should be uploaded!');
       return false;
   }
   if(val=="submit")
   {
   	$('#msgForSubmitButton').show();
   	 return false;
   }
  
   var formData = new FormData(document.getElementById("captureVendorBillForm"));
   var pathname = window.location.pathname;
   var accessGroup = "MMUWeb";

   var url = window.location.protocol + "//" + window.location.host + "/" + accessGroup + "/audit/captureVendorBillDetail";
   //var captureVendorBillDetailVal = $('#captureVendorBillDetail')[0];
	//var formData = new FormData(captureVendorBillDetailVal);
	$("#captureVendorDataSave").attr("disabled", true);
	$("#captureVendorDataSubmit").attr("disabled", true);
	$("#resetId").attr("disabled", true);
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
              //var empCatRank=$('#empCategory').val();	
              //var siqValue=$('#siqValue').val();
              //var flagForFwc=$('#flagForFwc').val();
              //localStorage.empCatRank=empCatRank;
              //localStorage.siqValue=siqValue;
              localStorage.typeOfVal='vendorFirstTime';
              var Id= msg.captureVendorBillDetailId;
              localStorage.captureVendorBillDetailIdSSSS=Id;
              window.location.href ="vendorBillSubmit?captureVendorBillDetailId="+Id+"";
           } 
           else if(msg.status == 0)
           {
           	$("#captureVendorDataSave").attr("disabled", false);
       		$("#captureVendorDataSubmit").attr("disabled", false);
       		$("#resetId").attr("disabled", false);
            alert(msg.msg)	
           }	
           else
           {
           	$("#captureVendorDataSave").attr("disabled", false);
       		$("#captureVendorDataSubmit").attr("disabled", false);
       		$("#resetId").attr("disabled", false);
               alert("Please enter the valid data")
           }
       },
       error: function(jqXHR, exception) {
       	$("#captureVendorDataSave").attr("disabled", false);
   		$("#captureVendorDataSubmit").attr("disabled", false);
   		$("#resetId").attr("disabled", false);
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

function submitPopUp()
{
	 $('.modal-backdrop').hide();
	 $('#msgForSubmitButton').hide();
	 var val='submitted'
	 submitForm(val);
	  
}
function closeModal(){
	$('.modal-backdrop').hide();
	$('#msgForSubmitButton').hide();
	}

function loadVendors(){
	var vendorId=<%=vendorId%>;
    var params = {"PN":0,"status":"y"}

    $.ajax({
        type : "POST",
        contentType : "application/json",
        url : 'getVendors',
        data : JSON.stringify(params),
        dataType : "json",
        cache : false,
        success : function(result) {
            if(result.data.length > 0){
                $('#vendorId').empty().append('<option value="">--Select--</option>');
                for(var i=0;i<result.data.length;i++){
                    var rowData = result.data[i];
                    if(rowData.mmuVendorId==vendorId)
                    {	
                    $('#vendorId').append($('<option/>').val(rowData.mmuVendorId).text(rowData.mmuVendorName));
                    }
                }
            }
        },
        error : function(data) {
            alert("An error has occurred while contacting the server");
        }
    });
}

function resetMMU()
{
	 $j("#mmuIds").empty();	
}

var rowId=0;
function addSupportingDocs() {
		var tbl = document.getElementById('supportingDocs');
		lastRow = tbl.rows.length;
		rowId = lastRow;
		rowId++;
		var val = parseInt($('#supportingDocs>tr:last').find("td:eq(0)").text());
		var aClone = $('#supportingDocs>tr:last').clone(true)
		aClone.find(":input").val("");
		
		aClone.find("td:eq(0)").find("input:eq(1)").prop('id', 'captureVendorSupportingDocsId'+rowId+'');
		aClone.find("td:eq(0)").find("input:eq(1)").prop('id', "");
		aClone.find("td:eq(1)").find("textarea:eq(0)").prop('id', 'medicalDocs'+rowId+'');
		
		aClone.find("td:eq(2)").find("input:eq(0)").prop('id', 'supportingDocsUpload'+rowId+'');
		//aClone.find("td:eq(2)").find("input:eq(0)").prop('name', 'supportingDocsUpload'+rowId+'');
		
		aClone.find("option[selected]").removeAttr("selected")
		
		var patientDetailDocFile='<div class="fileUploadDiv"><input type="file" name="supportingDocsUpload" id="supportingDocsUpload'+rowId+'" value="" class="inputUpload"><label class="inputUploadlabel">Choose File</label><span class="inputUploadFileName">No File Chosen</span></div>';
		aClone.find("td:eq(2)").html(patientDetailDocFile);

		aClone.find('button[button-type="delete"]').removeAttr('disabled');
		
		aClone.clone(true).appendTo('#supportingDocs');
		var val = $('#supportingDocs>tr:last').find("td:eq(3)").find(":input")[0];
		rowId++;

	}
	
function deleteRow(item) {
	 //if(confirm(resourceJSON.msgDelete)){
		 if($('#supportingDocs tr').length > 1) {
				 $(item).closest('tr').remove();
		 }else{
			 alert("Atleast one row should be there in supporting doc table !")
			 return false;
		 }
		 
	 /*   var pathname = window.location.pathname;
  	var accessGroup = pathname.split("/")[1];

  	var url = window.location.protocol + "//"
  			+ window.location.host + "/" + accessGroup
  			+ "/opd/getRidcDocmentInfo";

  	$.ajax({
  		type : "POST",
  		contentType : "application/json",
  		url : url,
  		data : JSON.stringify({
  			'ridcId' : valueForDelete,
  			
  		}),
  		dataType : 'json',
  		timeout : 100000,
			success : function(res) {
				
				data = res.ridcInfoList;
				var ridcInfo="";
				var documentId="";
				var documentName ="";
				var documentInfo = "";
				var encryptedName ="";
				if(data!=null && data.length>0)
  			for(var i=0;i<data.length;i++){
					
					  ridcInfo= data[i];
					
					  documentId=ridcInfo[0];
					  documentName = ridcInfo[1];
					  documentInfo = ridcInfo[2];
					  encryptedName = ridcInfo[3];
  			}
					var url = window.location.protocol + "//"
	    			+ window.location.host + "/" + accessGroup
	    			+ "/digifileupload/deleteRmsFile";

	    	$.ajax({
	    		type : "POST",
	    		contentType : "application/json",
	    		url : url,
	    		data : JSON.stringify({
	    			'documentId' : documentId,
	    			'documentName' : documentName,
	    			'documentInfo' : documentInfo,
	    			'encryptedName':encryptedName,
	    		}),
	    		dataType : 'json',
	    		timeout : 100000,
				success : function(res) {
				var	data = res.deleteStatus;
					if(data=='success'){
						
						 var url1 = window.location.protocol + "//"
							+ window.location.host + "/" + accessGroup
							+ "/opd/deleteGridRow";
						 var visitId=$('#visitId').val();
						 var opdPatientDetailId=$('#opdPatientDetailId').val();
						 var patientId=$('#patientId').val();
							var data = {
								"valueForDelete" : valueForDelete,
								"flag" : flage,
								"visitId" : visitId,
								"opdPatientDetailId" : opdPatientDetailId,
								"patientId" : patientId
							};
							
							$.ajax({
								type : "POST",
								contentType : "application/json",
								url : url1,
								data : JSON.stringify(data),
								dataType : "json",
								cache : false,
								success : function(res) {
									if (flage == "10") {
										 $(item).closest('tr').remove();
										 getAFMSFInvestigationForDigiFileUploadMb();
									}
									if (flage == "11") {
										 $(item).closest('tr').remove();
										 getPatientReferalDetailForDigiFileUploadMb();
									}
									 
								}
							});
					}
					else{
						alert("Something is wrong with file");
					}
				}
				});
		 
			}
  	
		});*/ 
	 
	
}
	 
function validateFileExtension(component,msg_id,msg,extns)
{
   var flag=0;
   with(component)
   {
      var ext=component.substring(component.lastIndexOf('.')+1);
      for(i=0;i<extns.length;i++)
      {
         if(ext==extns[i])
         {
            flag=0;
            break;
         }
         else
         {
            flag=1;
         }
      }
      if(flag!=0)
      {
         alert(msg);
        /*  component.value="";
         component.style.backgroundColor="#eab1b1";
         component.style.border="thin solid #000000";
         component.focus(); */
         return false;
      }
      else
      {
         return true;
      }
   }
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

				<div class="internal_Htext">Capture Vendor Bill Detail</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>
                                <form id="captureVendorBillForm">
                                <input  name="vendorFlag" id="vendorFlag" type="hidden" value="" />
                                <input type="hidden" id="updateStatus" name="updateStatus" value="">
                                <input type="hidden" id="firstTime" name="firstTime" value="firstTime">
                                <input  name="captureVendorBillDetailId" id="captureVendorBillDetailId" type="hidden" value=""/>
                                <input  name="lastApprovalMsg" id="lastApprovalMsg" type="hidden" value=""/>
                                <input  name="userId " id="userId" type="hidden" value="<%=userId%>"/>
                                    <div class="row">
                                        <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">Vendor</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <select class="form-control" name="vendorId" id="vendorId">
                                                        <option value="">--Select--</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
 										<div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">UPSS</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" name="district" id="district" onchange="getCityList();getMasUpssPhase()">
												<option value="">Select</option>
												</select>
											</div>
										</div>
									</div>
                                        <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">City</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <select class="form-control" id="cityId" name="cityId" onchange="getMasUpssPhase()">
                                                        <option value="">Select</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                    <div class="col-md-4">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Phase</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" id="phase" name="phase" onchange="getMMUList(this)">
													 <!--<option value="">Select</option>
												 	<option value="Phase1">Phase1</option>
													<option value="Phase2">Phase2</option> -->
												</select>
											</div>
										</div>
									</div>
                                                <div class="col-md-4">
                                                    <div class="form-group row  autocomplete">

                                                        <label class="col-md-5 col-form-label">MMU</label>
                                                        <div class="col-md-7">
                                                                <select name="mmuIds" multiple="multiple" value="" size="5"
                                                                    tabindex="1" id="mmuIds" class="listBig width-full disablecopypaste">
                                                                </select>
                                                        </div>

                                                    </div>
                                                </div>
                                               
                                                

                                    </div>
                                    <div class="row m-t-10">
                                        <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">Month and Year</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <select class="form-control" id="billMonth" name="billMonth">
                                                        <option value="">--Select--</option>
                                                        <option value="0">JAN</option>
                                                        <option value="1">FEB</option>
                                                        <option value="2">MAR</option>
                                                        <option value="3">APR</option>
                                                        <option value="4">MAY</option>
                                                        <option value="5">JUN</option>
                                                        <option value="6">JUL</option>
                                                        <option value="7">AUG</option>
                                                        <option value="8">SEP</option>
                                                        <option value="9">OCT</option>
                                                        <option value="10">NOV</option>
                                                        <option value="11">DEC</option>
                                                    </select>

                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <label class="col-form-label col-md-1">/</label>
                                                <div class="col-md-7">
                                                    <select class="form-control" id="billYear" name="billYear">
                                                        <option value="">--Select--</option>
                                                        <option value="2020">2020</option>
                                                        <option value="2021">2021</option>
                                                        <option value="2022">2022</option>
                                                        <option value="2023">2023</option>
                                                        <option value="2024">2024</option>
                                                        <option value="2025">2025</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row m-t-10">
                                        <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">Invoice No</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <input type="text" class="form-control" name="invoiceNo" id="invoiceNo"/>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">Invoice Date</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <div class="dateHolder">
                                                        <input type="text" name="invoiceDate" readonly="true" class="calDate form-control" id="invoiceDate" value="" placeholder="DD/MM/YYYY" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row m-t-10">
                                        <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">Invoice Amount</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <input type="text" id="invoiceAmount" name="invoiceAmount" onkeypress="return isNumberKey(event)" class="form-control"/>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">Upload Bill</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <div class="fileUploadDiv">
                                                        <input type="file" class="inputUpload" id="fileName" name="fileName">
                                                        <label class="inputUploadlabel">Choose File</label>
                                                        <span id="" class="inputUploadFileName">No File Chosen</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                      
														<div class="col-12">
														<h6 class="text-theme text-underline font-weight-bold">Vendor Invoice (Supporting Document)</h6>
														</div>
														
														<div class="col-12">
															<table class="table table-hover table-striped table-bordered">
																<thead>
																	<tr>
																		<th>Document Name</th>
																		<th>Document Type(Note)</th>
																		<th>Upload File</th>
																		<th>Add</th>
																		<th>Delete</th>
																	</tr>
																</thead>
																
																<tbody id="supportingDocs">
																	<tr>
																		<td class="width200">
																			<div class="col-md-12">
                                                  								  <input type="text" class="form-control" name="docId" id="docId"/>
                                                							</div>
																			<input type="hidden" name="captureVendorSupportingDocsId" name="captureVendorSupportingDocsId" value=""/>
																			
																		</td>																		
																		<td class="width200">
																		    <textarea name="medicalDocs" id="medicalDocs" class="form-control" id="medicalDocumentsDetails"></textarea>
																		</td>
																		<td>																		
																			<div class="fileUploadDiv">
																				<input type="file" name="supportingDocsUpload" value="" id="supportingDocsUpload" class="inputUpload">
																				<label class="inputUploadlabel">Choose File</label>
																				<span class="inputUploadFileName">No File Chosen</span>
																			</div>
																		</td>
																		<td>
                                                                            <button type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addSupportingDocs()"></button>
                                                                        </td>
                                                                         <td>
                                                                               <button type="button" class="btn btn-danger buttonAdd noMinWidth"  name="deleteForSupportDocNew" value=""    id="deleteForSupportDocNew"  button-type="delete" tabindex="1" onclick="deleteRow(this)"></button>
                                                                        </td>
																	</tr>
																</tbody>
															</table>
														</div></div>
													 

                                    <div class="row">
                                        <div class="col-12 m-t-10 text-right">
                                            <button type="button" id="captureVendorDataSave" value="save" onclick="submitForm(this.value)"   class="btn btn-primary">Save</button>
                                             <button type="button" id="captureVendorDataSubmit" value="submit" onclick="submitForm(this.value)" class="btn btn-primary">Submit</button>
                                            <button type="reset" class="btn btn-primary" id="resetId" onclick="resetMMU()">Reset</button>
                                        </div>
                                    </div>
                                </form>
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
<div class="modal" id="msgForSubmitButton" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<span class="Message_htext"><spring:message
								code="lblIndianCoastGuard" /></span>

						<button type="button" onClick="closeModal();" class="close"
							data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>

					</div>
					<div class="modal-body">
						<div class="control-group">

							<div class="col-md-12">
								<div class="form-group ">
									<span><spring:message code="messageForSubmit" /></span> 
								 </div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" id="submitMOValidateFormByModelInvestgationId"  data-dismiss="modal"
							onClick="submitPopUp();" aria-hidden="true">
							<spring:message code="btnYes" />
						</button>
					 <button class="btn btn-primary" data-dismiss="modal" id="currentInvRowItem" value=""
							onClick="closeModal();" aria-hidden="true">
							<spring:message code="btnNo" />
					</button>
					</div>
					
					
					
				</div>
			</div>
</div>

</body>
<script>


</script>

</html>


<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>