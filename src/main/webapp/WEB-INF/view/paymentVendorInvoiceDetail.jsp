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
<%
	String userName = "1";
	if (session.getAttribute("userName") != null) {
		userName = session.getAttribute("userName") + "";
	}
	
	String userTypeDesignation="";
	if (session.getAttribute("userTypeDesignation") != null) {
		userTypeDesignation = session.getAttribute("userTypeDesignation") + "";
	}
	
	String authorityId="";
	if (session.getAttribute("authorityId") != null) {
		authorityId = session.getAttribute("authorityId") + "";
	}
	
	String authorityName="";
	if (session.getAttribute("authorityName") != null) {
		authorityName = session.getAttribute("authorityName") + "";
	}
	
	String approvalOrderNo="";
	if (session.getAttribute("approvalOrderNo") != null) {
		approvalOrderNo = session.getAttribute("approvalOrderNo") + "";
	}
	
	String finalApproval="";
	if (session.getAttribute("finalApproval") != null) {
		finalApproval = session.getAttribute("finalApproval") + "";
	}
  
%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<title></title>

<script type="text/javascript">
$(document).ready(function(){
	
	/* setTimeout( function() { getMasPhase();}, 2000); */
    loadBillDetails();
    getMasHeadType();
    var username='<%=userName%>';
	 $('#userName').val(username);
    var usertypedesignation='<%=userTypeDesignation%>';
    $('#userDesignation').val(usertypedesignation);
    var userDesignation=$('#finalApproval').val();
    if(userDesignation=='y')
    {
    	$('#penaltyA').show();	
    }
	getAuthorityList();
    /* $('#back').on('click', function(){
        window.location = 'paymentWaitingListVendorInvoice';
    }); */

    $('#downloadBill').on('click', function(){
    	//<a href="download?name="+$(this).data('name')+"&type=vendor_bill&keys="+$('#invoiceNo').val() target="_blank">
       // window.location = "download?name="+$(this).data('name')+"&type=vendor_bill&keys="+$('#invoiceNo').val();
    
    	window.open("${pageContext.servletContext.contextPath}/audit/download?name="+$(this).data('name')+"&type=vendor_bill&keys="+$('#invoiceNo').val(), '_blank').focus();
    }); 
    $('#downloadAuditorReport').on('click', function(){
        //window.location = "download?name="+$(this).data('name')+"&type=audit_report&keys="+$('#invoiceNo').val();
        window.open("${pageContext.servletContext.contextPath}/audit/download?name="+$(this).data('name')+"&type=audit_report&keys="+$('#invoiceNo').val(), '_blank').focus();
    });
    
   var today = new Date();
	var dd = String(today.getDate()).padStart(2, '0');
	var mm = String(today.getMonth() + 1).padStart(2, '0'); 
	var yyyy = today.getFullYear();
	
	//today =  yyyy + '-' + mm + '-' +dd;
	 today = dd + '/' + mm + '/' +yyyy;
    $('#finalPaymentDate').val(today);
});

function backToList()
{
	window.location = 'paymentWaitingListVendorInvoice';
	//window.history.back();
}

function loadBillDetails(){
    var months = ['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC'];
    jQuery.ajax({
        crossOrigin: true,
        method: "GET",
        crossDomain:true,
        url: 'vendorInvoiceDetailData',
        enctype: 'multipart/form-data',
        processData: false,
        contentType: false,
        dataType: "json",
        success: function(result){
            if(result && result.vendorInvoiceDetailData && result.vendorInvoiceDetailData.data && result.vendorInvoiceDetailData.data.length > 0){
                var rowData = result.vendorInvoiceDetailData.data[0];
                $('#vendorIdName').val(rowData.vendorName);
                $('#districtName').val(rowData.districtName);
                $('#cityIdName').val(rowData.cityName);
                $('#vendorId').val(rowData.vendorId);
                $('#district').val(rowData.district);
                $('#cityId').val(rowData.cityId);
                $('#billYear').val(rowData.billYear);
                $('#billMonth').val(rowData.billMonth);
                $('#invoiceNo').val(rowData.invoiceNo);
                $('#invoiceDate').val(rowData.invoiceDate);
                $('#invoiceAmount').val(rowData.invoiceAmount);
                $('#captureVendorBillDetailId').val(rowData.captureVendorBillDetailId);
                $('#uploadedFileName').val(rowData.uploadedFileName);
                $('#downloadBill').attr('data-name', rowData.uploadedFileName);
                $('#downloadAuditorReport').attr('data-name', rowData.auditorFileName);
                $('#finalPenaltyAmont').val(rowData.penaltyAmount);
                $('#finalInvoiceAmont').val(rowData.invoiceAmount);
                $('#paymentPenaltyAmont').val(rowData.penaltyAmount);
                $('#phaseValId').val(rowData.phase);
                $('#phase').val(rowData.phase);
                setTimeout( function() { getFundAvailableBalance(rowData.phase);}, 2000);
                getVendorInvoicePaymentDetails($('#captureVendorBillDetailId').val());
                var mmuDrop = '';
                var list = rowData.vendorBillMMUDetailList;
				for(i=0;i<list.length;i++){
					mmuDrop += '<option selected="selected" value='+list[i].mmuId+'>'+list[i].mmuName+'</option>';
				}
				$j('#mmuIds').append(mmuDrop);
            }
            
            getVendorInvoiceApprovalDetails($('#captureVendorBillDetailId').val());
          //  getFundAvailableBalance();
                      
        }
    });
}

function calculateFinalAmount() {
    var amt = $('#tdsDeduction').val();
    var s = amt.split('.');

    if (s[0].length > 10) {
        alert("TDS amount should be max 10 digit before decimal value");
        $('#tdsDeduction').val('');
        return false;
    }
    
    // Remove decimal part by taking only the integer part
    amt = s[0];

    if (amt.length > 13) {
        alert('TDS amount can be only 12 digit number!');
        $('#tdsDeduction').val('');
        return false;
    }
    
    // Update the tdsDeduction field with the integer value
    $('#tdsDeduction').val(amt);

    var invoiceAmount = parseInt($('#finalInvoiceAmont').val());
    var penaltyAmount = parseInt($('#paymentPenaltyAmont').val());
    var tdsDeduction = parseInt($('#tdsDeduction').val());

    if(invoiceAmount && invoiceAmount < tdsDeduction) {
        alert('Deduction amount can not be greater than invoice amount!');
        $('#tdsDeduction').val('');
        $('#finalAmount').val('');
        return false;
    }

    var totalDed = penaltyAmount + tdsDeduction;
    
    if(invoiceAmount && invoiceAmount < totalDed) {
        alert('Sum of penalty and deduction can not be greater than invoice amount!');
        $('#tdsDeduction').val('');
        $('#finalAmount').val('');
        return false;
    }

    var calculateAmount = invoiceAmount - totalDed;
    var n1 = calculateAmount; // No need to use toFixed() since we are dealing with integers

    $('#finalAmount').val(n1);
}
function getVendorInvoiceApprovalDetails(val) {

	var pathname = window.location.pathname;
	var accessGroup ="MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/audit/getVendorInvoiceApprovalDetails";
	var authorityId='';
	var authorityDate='';
	var authorityName='';
	var authorityRemarks='';
	var authorityRole= '';
	var actionValue='';
	
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'captureVendorBillDetailId' : val
					}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
					var datas = response.data;
					var trHTML = "";
					var i=0;
					$.each(datas, function(i, item) {
						 authorityId=item.authorityId;
						 authorityDate=item.authorityDate;
						 authorityName=item.authorityName;
						 authorityRemarks=item.authorityRemarks;	
						 authorityRole= item.authorityRole;
						 actionValue=item.actionValue;
						 if(actionValue=='A')
							{
								actionValue='Approved';
							}
							else if(actionValue=='D')
							{
								actionValue='Back to TPA(Review and revised penalty)';
							}
							else if(actionValue=='R')
							{
								actionValue='Back to Vendor';
							}
							else{
								actionValue="N/A";
							}
						trHTML +='<tr><td><div><input type="text" value="'+authorityDate+'" tabindex="1" id="nomenclature11'+i+'""  size="25" name="nomenclature1" class="form-control width130" onblur="updatePopulatePVMSTemplate(this.value,1,this);" readonly/></div></td>'; 
						trHTML +='<td><div><input type="text" value="'+authorityName+'" tabindex="1" id="nomenclature11'+i+'""  size="25" name="nomenclature1" class="form-control width130" onblur="updatePopulatePVMSTemplate(this.value,1,this);" readonly/></div></td>'; 
						trHTML +='<td><div><input type="text" value="'+authorityRole+'" tabindex="1" id="nomenclature11'+i+'""  size="25" name="nomenclature1" class="form-control width130" onblur="updatePopulatePVMSTemplate(this.value,1,this);" readonly/></div></td>'; 
						trHTML +='<td><div><textarea class="form-control" type="text" id="authorityRemarks" readonly>'+authorityRemarks+'</textarea></div></td>'; 
						trHTML +='<td><div><input type="text" value="'+actionValue+'" tabindex="1" id="nomenclature11'+i+'""  size="25" name="nomenclature1" class="form-control width130" onblur="updatePopulatePVMSTemplate(this.value,1,this);" readonly/></div></td>'; 
						trHTML +='</tr>';
						
							
						
					});
					$('#finalDate').val(authorityDate);
					$('#finalName').val(authorityName);
					$('#finalRole').val(authorityRole);
					$('#finalRemarks').val(authorityRemarks);
						$('#approvingAuthorityList').append(trHTML);
				
				},
				error : function(e) {

					console.log("ERROR: ", e);

				},
				done : function(e) {
					console.log("DONE");
					alert("success");
					var datas = e.data;

				}
			});
	var availableAmount=$('#availableAmount').val();
	if(availableAmount==""){
     var phaseVal=$('#phaseValId').val();
	 setTimeout( function() { getFundAvailableBalance(phaseVal);}, 1000);
	}

}



function getVendorInvoicePaymentDetails(val) {

	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/audit/getVendorInvoicePaymentDetail";
	
	$
			.ajax({
				url : url,
				dataType : "json",
				data : JSON.stringify({
					'captureVendorBillDetailId' : val
					}),
				contentType : "application/json",
				type : "POST",
				success : function(response) {
					console.log(response);
					if(response.status=="1")
					{	
					var datas = response.data;
					var trHTML = "";
					var i=0;
					$.each(datas, function(i, item) {
						$('#captureAuditDataSubmit').hide();
						var amountPaid=item.amountPaid;
						var tdsDeduction=item.tdsDeduction;
						var modeOfPayment=item.modeOfPayment;
						var transactionNumber=item.transactionNumber;	
						var invoiceAmount= item.invoiceAmount;
						var vendorInvoicePaymentId=item.vendorInvoicePaymentId;
						var penaltyAmount=item.penaltyAmount;
						var paymentDate=item.paymentDate;
							id="captureAuditDataSubmit"
							$('#finalPaymentDate').val(paymentDate);
							$('#finalInvoiceAmont').val(invoiceAmount);
							$('#paymentPenaltyAmont').val(penaltyAmount);
							$('#tdsDeduction').val(tdsDeduction);
							$('#finalAmount').val(amountPaid);
							$('#modeOfPayment').val(modeOfPayment);
							$('#transNo').val(transactionNumber);
							document.getElementById("tdsDeduction").readOnly = true;
							document.getElementById("finalPaymentDate").readOnly = true;
							$('#modeOfPayment').attr('disabled', true);
							document.getElementById("transNo").readOnly = true;
												
					});
				}
				else
				{
					$('#finalPaymentDate').val();
					$('#finalInvoiceAmont').val();
					$('#paymentPenaltyAmont').val();
					$('#tdsDeduction').val();
					$('#finalAmount').val();
					$('#modeOfPayment').val();
					$('#transNo').val();	
				}	
					
				},
				error : function(e) {

					console.log("ERROR: ", e);

				},
				done : function(e) {
					console.log("DONE");
					alert("success");
					var datas = e.data;

				}
			});

}

function get(name){
   if(name=(new RegExp('[?&]'+encodeURIComponent(name)+'=([^&]*)')).exec(location.search))
      return decodeURIComponent(name[1]);
}

function getAuthorityList(){
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getAuthority",
	    data: JSON.stringify({"PN" : "0","districtId": ""}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "" ;
	    	var authId=$('#authorityId').val();
	    	for(var i=0;i<result.masAuthorityData.length;i++){
	    		var checkAuthId=result.masAuthorityData[i].authorityId;
	    		if(authId<checkAuthId)
	    		{	
	    		combo += '<option value='+result.masAuthorityData[i].authorityId+'@@'+result.masAuthorityData[i].orderNo+'>' +result.masAuthorityData[i].authorityName+ '</option>';
	    		}
	    	}
	    	jQuery('#forwordTo').append(combo);
	    	
	    }
	    
	});
}

function getFundAvailableBalance(phaseval){
	var upssId=$('#district').val();
	var cityId=$('#cityId').val();
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/audit/getFundAvailableBalance",
	    data: JSON.stringify({'upssId':upssId,'cityId':cityId,'headTypeId':"1",'phase':phaseval}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	$('#availableAmount').val(result);	
	    },
	    error: function(xhr, status, error){
        	$('#availableAmount').val(0);	
        }
	    
	});
}

/* function getMasPhase(){
	var upssId=$('#district').val();
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getMasPhase",
	    data: JSON.stringify({"PN" : "0","upssId":upssId}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	var combo = "<option value=\"\">Select</option>" ;
	    	
	    	for(var i=0;i<result.data.length;i++){
	    		combo += '<option value='+result.data[i].phaseValue+'>' +result.data[i].phaseName+ '</option>';
	    		
	    	}
	    	jQuery('#phase').append(combo);
	    	var phaseVal=localStorage.phase;
	    	getUpssPhaseVal();
	    }
	    
	});
} */

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
					'mmuSearch':upssId
					}),
				contentType : "application/json",
				type : "POST",
				 success: function(result){
				    	var combo = "<option value='0'>Select</option>" ;
				    	
				    	for(var i=0;i<result.data.length;i++){
				    		combo += '<option value='+result.data[i].phaseValue+'>' +result.data[i].phaseName+ '</option>';
				    		
				    	}
				    	jQuery('#phase').append(combo);
				    	
				    }
				    
				});
			}

function submitAuditorForm(){
  
	var invoiceDate = $('#finalPaymentDate').val();
	   if(!invoiceDate){
	       alert('Please Select Payment Date!');
	       return false;
	   }else{
	        var dts = invoiceDate.split('/');
	        var insDts = new Date(dts[2], dts[1]-1, dts[0]);
	        var todaysDate = new Date();
	        var currDate = new Date(todaysDate.getFullYear(), todaysDate.getMonth(), todaysDate.getDate());
	        if(insDts.getTime() > currDate.getTime()){
	            alert('Payment Date can not be future date!');
	            return false;
	        }
	         var lastApprovingFinalDate=$('#finalDate').val();
	         var finalDate=lastApprovingFinalDate.split('/');
	         var approvingFinalDate = new Date(finalDate[2], finalDate[1]-1, finalDate[0]);
	        if(insDts.getTime()<approvingFinalDate.getTime()){
	            alert('Payment date can not be earlier than the nodal officer approval date!');
	            return false;
	        }
	   }
	   
	var phase=$('#phase').val();
	var phaseGetVal=$('#phaseValId').val();
	  if(phase=="" || phase==undefined ||phase=="0")
	  {
		  alert("Please select Phase.");
		  return false;
		  
	  }
	  if(phaseGetVal!=phase)
	  {
		  alert("Please select correct phase name.");
		  return false;
		 
	  }
	  
	 if($('#availableAmount').val() && parseInt($('#availableAmount').val()) < parseInt($('#finalAmount').val())){
	       alert('Payment cannot be done as final amount is greater than Available balance!');
	       return false;
	   }
	 
   if(!$('#tdsDeduction').val()){
	      alert('Please Enter Total Deductions(TDS & Others)!');
	      return false;
	  }
   	  
	  if(!$('#modeOfPayment').val()){
	      alert('Please Select Mode Of Payment!');
	      return false;
	   }
   
  if(!$('#transNo').val()){
      alert('Please enter Transaction No.!');
      return false;
  }
  
  var lastApprovalMsg='';
   var currentdate = getTodayDate(new Date());
   lastApprovalMsg='Payment completed on ('+$('#finalPaymentDate').val()+')';

  var dataJSON = {

          'actionId': $('#actionId').val(),
          'forwordTo': $('#forwordTo').val(),
          'remarks': $('#remarks').val(),
          'captureVendorBillDetailId':$('#captureVendorBillDetailId').val(),
          'authorityId':$('#authorityId').val(),
          'authorityOrderNo':$('#authorityOrderNo').val(),
          'authorityRoleName':$('#authorityRoleName').val(),
          'authorityName':$('#userName').val(),
          'penaltyAmount':$('#paymentPenaltyAmont').val(),
          'finalAmount':$('#finalAmount').val(),
          'invoiceAmount':$('#invoiceAmount').val(),
          'tdsDeduction':$('#tdsDeduction').val(),
          'modeOfPayment':$('#modeOfPayment').val(),
          'transNo':$('#transNo').val(),
          'lastApprovalMsg':lastApprovalMsg,
          'districtId':$('#district').val(),
          'finalPaymentDate':$('#finalPaymentDate').val(),
          'cityId':$('#cityId').val(),
          'phase':phase,
    }
  var noteSheetData = $('#captureNodalOfficerForm')[0];
	 var formData = new FormData(noteSheetData);
	 var countFile=1;
	formData.append('captureNodalOfficerForm',JSON.stringify(dataJSON));
$("#captureAuditDataSubmit").attr("disabled", true);
$.ajax({
	  type: 'POST',
	  url : "${pageContext.servletContext.contextPath}/audit/saveOrUpdateAuthorityVendorBillDetails",
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
            	 localStorage.typeOfVal='payment';
                 var Id= $('#captureVendorBillDetailId').val()
                 localStorage.captureVendorBillDetailIdSSSS=Id;
                window.location.href ="vendorBillSubmit?captureVendorBillDetailId="+Id+"";
            } 
            else if(msg.status == 0)
            {
             $("#captureAuditDataSubmit").attr("disabled", false);	
             alert(msg.msg)	
            }	
            else
            {
            	$("#captureAuditDataSubmit").attr("disabled", false);
                alert("Please enter the valid data")
            }
        },
        error: function(jqXHR, exception) {
        	$("#opdMainClicked").attr("disabled", false);
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

function get(name){
	   if(name=(new RegExp('[?&]'+encodeURIComponent(name)+'=([^&]*)')).exec(location.search))
	      return decodeURIComponent(name[1]);
	}
	
function viewDocumnt()
{
	window.open("download?name="+$(this).data('name')+"&type=audit_report&keys="+$('#invoiceNo').val());
 				//openPdfModel("download?name="+$(this).data('name')+"&type=audit_report&keys="+$('#invoiceNo').val());
}
function waitingList()
{
	window.location='/audit/paymentWaitingListVendorInvoice';
	
}	

function getMasHeadType(){
	
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
	    		if(result.masHeadTypeData[i].headTypeId==1)
	    		{	
	    		combo += '<option selected value='+result.masHeadTypeData[i].headTypeId+'>' +result.masHeadTypeData[i].headTypeName+ '</option>';
	    		}
	    		
	    	}
	    	
	    	jQuery('#headType').append(combo);
	    	
	    }
	    
	});
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

				<div class="internal_Htext">Capture Payment Details(Vendor Invoice)</div>
				<form id="captureNodalOfficerForm">
               	<div class="row">
				<input type="hidden" id="updateStatus" name="updateStatus" value="update">
                 <input  name="vendorFlag" id="vendorFlag" type="hidden" value="save"/>
                <input  name="captureVendorBillDetailId" id="captureVendorBillDetailId" type="hidden" value=""/>
                <input  name="vendorId" id="vendorId" type="hidden" value=""/>
                <input  name="district" id="district" type="hidden" value=""/>
                <input  name="cityId" id="cityId" type="hidden" value=""/>
                <input  name="uploadedFileName" id="uploadedFileName" type="hidden" value=""/>
                 <input  name="userName" id="userName" type="hidden" value=""/>
                 <input  name="userDesignation" id="userDesignation" type="hidden" value=""/>
                 <input  name="authorityId" id="authorityId" type="hidden" value="<%=session.getAttribute("authorityId")%>"/>
		          <input  name="authorityOrderNo" id="authorityOrderNo" type="hidden" value="<%=session.getAttribute("approvalOrderNo")%>"/>
		           <input  name="authorityRoleName" id="authorityRoleName" type="hidden" value="<%=session.getAttribute("authorityName")%>"/>
		           <input  name="finalApproval" id="finalApproval" type="hidden" value="<%=session.getAttribute("finalApproval")%>"/>
		           <input  name="phaseValId" id="phaseValId" type="hidden" value=""/>
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>

								<div class="row">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Vendor</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="vendorIdName" class="form-control" disabled/>
											</div>
										</div>
									</div>
                                    <div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">UPSS</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="districtName" class="form-control" disabled/>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">City</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="cityIdName" class="form-control" disabled/>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
											<div class="col-md-4">
												<div class="form-group row  autocomplete">

													<label class="col-md-5 col-form-label">MMU</label>
													<div class="col-md-7">
															<select name="mmuIds" multiple="4" value="" size="5"
																tabindex="1" id="mmuIds" class="listBig width-full disablecopypaste" readonly>
															</select>
													</div>

												</div>
											</div>
											<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<div class="col-md-5">
														<label class="col-form-label">Month and Year</label>
													</div>
													  <div class="col-md-7">
                                                    <select class="form-control" id="billMonth" name="billMonth" disabled>
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
														<input type="text" id="billYear" name="billYear" class="form-control" readonly/>
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
												<input type="text" id="invoiceNo" name="invoiceNo" class="form-control" readonly/>
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
													<input type="text" class="form-control" name="invoiceDate" id="invoiceDate" readonly/>
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
												<input type="text" id="invoiceAmount" name="invoiceAmount" class="form-control" readonly/>
											</div>

										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label"></label>
											</div>
											<div class="col-md-7">
												<button class="btn btn-primary" id="downloadBill" target="_blank">Download Vendor Bill</button>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label"></label>
											</div>
											<div class="col-md-7">
												<button class="btn btn-primary" id="downloadAuditorReport">Download Auditor Report</button>
											</div>
										</div>
									</div>
								</div>
                                <div>
									<h6 class="font-weight-bold text-theme text-underline">Approving Authority Approval Details</h6>

									<div class="table-responsive">
										<table
											class="table table-striped table-hover table-bordered " id="campTable">
											<thead class="bg-success" style="color: #fff;">
												<tr>
													<th>Date</th>
													<th>Name</th>
													<th>Authority Role</th>
													<th>Remarks</th>
													<th>Authority Action</th>
												</tr>
											</thead>
											<tbody id="approvingAuthorityList">

											</tbody>
										</table>
									</div>
								</div>
								<div>
									<h6 class="font-weight-bold text-theme text-underline">Final Approving Authority Approval Details</h6>
									<div class="row">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Date</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="finalDate" class="form-control" readonly/>
											</div>
										</div>
									</div>
                                    <div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Name</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="finalName" class="form-control" readonly/>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Authority Role</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="finalRole" class="form-control" readonly/>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Penalty Amount Deducted</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="finalPenaltyAmont" onkeypress="return isNumberKey(event)"  class="form-control" readonly/>
											</div>
										</div>
									</div>
                                    <div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Remarks</label>
											</div>
											<div class="col-md-7">
												<textarea class="form-control" id="finalRemarks" rows="2" readonly></textarea>
											</div>
										</div>
									</div>
									
								</div>
								</div>
								<h6 class="font-weight-bold text-theme text-underline">Head Details</h6>
								<div class="row">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Head Type</label>
											</div>
											 <div class="col-md-7">
                                                    <select class="form-control" id="headType" name="headType" disabled>
                                                        <option value="">--Select--</option>
                                                       
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
											<input type="text" id="phase"  class="form-control" readonly/>
												<!-- <select class="form-control" id="phase" onChange="getFundAvailableBalance(this.value)" >
													<option value="">Select</option>
													<option value="Phase1">Phase1</option>
													<option value="Phase2">Phase2</option>
												</select> -->
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Available Balance</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="availableAmount" onkeypress="return isNumberKey(event)"  class="form-control" readonly/>
											</div>
										</div>
									</div>
									
									
                                  
								</div>
									<h6 class="font-weight-bold text-theme text-underline">Payment Details</h6>
									<div class="row">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Date</label>
											</div>
											<div class="col-md-7">
											<div class="dateHolder">
											<input type="text" name="finalPaymentDate" class="calDate form-control" id="finalPaymentDate" value="" readonly placeholder="DD/MM/YYYY" />
											</div>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Invoice Amount</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="finalInvoiceAmont" onkeypress="return isNumberKey(event)"  class="form-control" readonly/>
											</div>
										</div>
									</div>
                                   <div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Penalty Amount Deducted</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="paymentPenaltyAmont" onkeypress="return isNumberKey(event)" class="form-control" readonly/>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									
                                    <div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Total Deductions(TDS & Others)</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="tdsDeduction" maxlength="13" onblur="calculateFinalAmount()" onkeypress="return isNumberKey(event)"  class="form-control"/>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Final Amount</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="finalAmount" maxlength="13" onkeypress="return isNumberKey(event)"  class="form-control" readonly/>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Mode Of Payment</label>
											</div>
											 <div class="col-md-7">
                                                    <select class="form-control" id="modeOfPayment" name="modeOfPayment">
                                                        <option value="">--Select--</option>
                                                        <option value="online">Online</option>
                                                        <option value="cheque">Cheque</option>
                                                     
                                                    </select>

                                                </div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Transaction No.</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="transNo" class="form-control"/>
											</div>
										</div>
									</div>
									
								</div>
								 </form>
                                  
									<div class="row">
                                	<div class="col-12 m-t-10 text-right">
                                	<button type="button" id="captureAuditDataSubmit" value="submit" onclick="submitAuditorForm()" class="btn btn-primary">Submit</button>
                               		<button class="btn btn-primary" onclick="backToList()" type="button" id="back">Back</button>
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

<div class="modal" id="billModal" tabindex="-1" role="dialog" aria-labelledby="billModal">
	  <div class="modal-dialog modal-lg" role="document">
	  <input type="hidden" id="" name="" value="">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title font-weight-bold">View Bill</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">

	      </div>

	    </div>
	  </div>
</div>

<div class="modal" id="penaltyModal" tabindex="-1" role="dialog" aria-labelledby="penaltyModal">
	  <div class="modal-dialog modal-lg" role="document">
	  <input type="hidden" id="" name="" value="">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title font-weight-bold">Penalty Details</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<div class="row">
				<div class="col-md-3">
					<label class="col-form-label">MMU  Name:</label>
				</div>
				<div class="col-md-9">
					<label class="col-form-label" id="mmuNameLabel"></label>
				</div>
	      	</div>
	      	<div class="table-responsive m-t-10">
				<table
					class="table table-striped table-hover table-bordered " id="campTable">
					<thead class="bg-success" style="color: #fff;">
						<tr>
							<th>Incident Date</th>
							<th>Incident Description</th>
							<th>Penalty Amount</th>
						</tr>
					</thead>
					<tbody id="inspectionPenaltyIncidentList">

					</tbody>
				</table>
				<table
                    class="table table-striped table-hover table-bordered " id="campTable">
                    <thead class="bg-success" style="color: #fff;">
                    </thead>
                    <tbody id="equipmentPenaltyIncidentList">

                    </tbody>
                </table>
                <table
                    class="table table-striped table-hover table-bordered " id="campTable">
                    <thead class="bg-success" style="color: #fff;">
                    </thead>
                    <tbody id="attendancePenaltyIncidentList">

                    </tbody>
                </table>
			</div>
	      	<div class="row">
            	<div class="col-12 m-t-10 text-right">
           			<button class="btn btn-primary"  data-dismiss="modal" aria-label="Close" >Close</button>
           		</div>
      		</div>
	      </div>

	    </div>
	  </div>
</div>


</body>

</html>


<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>