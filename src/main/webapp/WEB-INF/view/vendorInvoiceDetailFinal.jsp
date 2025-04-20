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
	
	String userId = "1";
	if (session.getAttribute("userId") != null) {
		userId = session.getAttribute("userId") + "";
	}
	
	String levelOfUser = "1";
	if (session.getAttribute("levelOfUser") != null) {
		levelOfUser = session.getAttribute("levelOfUser") + "";
	}
  
%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="..//view/commonJavaScript.jsp"%>
<title></title>

<script type="text/javascript">
$(document).ready(function(){
    loadBillDetails();

    $('#back').on('click', function(){
        //window.location = 'vendorInvoiceList';
    	window.history.back();
    });

    $('#downloadBill').on('click', function(){
    	//<a href="download?name="+$(this).data('name')+"&type=vendor_bill&keys="+$('#invoiceNo').val() target="_blank">
       // window.location = "download?name="+$(this).data('name')+"&type=vendor_bill&keys="+$('#invoiceNo').val();
    
    	window.open("${pageContext.servletContext.contextPath}/audit/download?name="+$(this).data('name')+"&type=vendor_bill&keys="+$('#invoiceNo').val(), '_blank').focus();
    }); 
     $('#downloadAuditorReport').on('click', function(){
        //window.location = "download?name="+$(this).data('name')+"&type=audit_report&keys="+$('#invoiceNo').val();
        window.open("${pageContext.servletContext.contextPath}/audit/download?name="+$(this).data('name')+"&type=audit_report&keys="+$('#invoiceNo').val(), '_blank').focus();
    }); 
     
     $('#downloadRecepitBill').on('click', function(){
         window.open("${pageContext.servletContext.contextPath}/audit/download?name="+$(this).data('name')+"&type=vendor_bill\\payment_Recepit&keys="+$('#invoiceNo').val(), '_blank').focus();
     });
});

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
                var lastApprovalMsg=rowData.lastApprovalMsg;
                $('#captureVendorBillDetailId').val(rowData.captureVendorBillDetailId);
                $('#vendorId').val(rowData.vendorName);
                $('#vendorIdValue').val(rowData.vendorId);
                $('#districtName').val(rowData.districtName);
                $('#cityId').val(rowData.cityName);
                $('#billYear').val(rowData.billYear);
                $('#billMonth').val(months[rowData.billMonth]);
                $('#invoiceNo').val(rowData.invoiceNo);
                $('#invoiceDate').val(rowData.invoiceDate);
                $('#invoiceAmount').val(rowData.invoiceAmount);
                $('#downloadBill').attr('data-name', rowData.uploadedFileName);
                getVendorInvoicePaymentDetails($('#captureVendorBillDetailId').val());
                $('#uploadedFileName').val(rowData.uploadedFileName);
                $('#suggestedPenaltyAuditor').val(rowData.suggestedPenaltyAmount);
                $('#nodalImposedPenalty').val(rowData.imposedPenaltyAmount);
                $('#downloadAuditorReport').attr('data-name', rowData.auditorFileName);
               	
                var mmuDrop = '';
                var mmuIdsValuePenalty='';
                var list = rowData.vendorBillMMUDetailList;
				for(i=0;i<list.length;i++){
					mmuDrop += '<option selected="selected" value='+list[i].mmuId+'>'+list[i].mmuName+'</option>';
					mmuIdsValuePenalty += '<option selected="selected" value='+list[i].mmuId+'@@'+list[i].mmuName+'>'+list[i].mmuName+'</option>';
				}
				$j('#mmuIds').append(mmuDrop);
				var listSupportingDocs=rowData.vendorSupportingDocsList;
				var supportingDocs='';
				var randonNmber='';
				$("#supportingDocs tr").remove();
				for(i=0;i<listSupportingDocs.length;i++){
					if(listSupportingDocs[i].screen_name=='vendor'){
					supportingDocs += '<tr><td class="width200"><div class="col-md-12"><input type="text" readonly class="form-control" name="docId" value="'+listSupportingDocs[i].documentName+'" id="docId'+listSupportingDocs[i].captureVendorSupportingDocsId+'"/></div>';
					supportingDocs +='<input type="hidden" name="captureVendorSupportingDocsId"  name="captureVendorSupportingDocsId" value="'+listSupportingDocs[i].captureVendorSupportingDocsId+'"/>';					
					supportingDocs +='</td><td class="width200"><textarea name="medicalDocs" readonly id="medicalDocs'+listSupportingDocs[i].captureVendorSupportingDocsId+'" class="form-control" id="medicalDocumentsDetails">'+listSupportingDocs[i].documentNote+'</textarea></td>';
					supportingDocs +='<td> <button name="data" class="btn btn-primary" type="button" data-name="'+listSupportingDocs[i].fileName+'" onclick="getSupportingDownloadData(this)">View/Download Supporting Document</button></td>';
					supportingDocs +='</td></tr>';
					}else if(listSupportingDocs[i].screen_name=='paymentScreen'){
						$('#paymentRemarks').val(listSupportingDocs[i].documentNote);
						$('#downloadRecepitBill').attr('data-name', listSupportingDocs[i].fileName);
					}
				}
				$j('#supportingDocs').append(supportingDocs);
				$j('#mmuIdsValuePenalty').append(mmuIdsValuePenalty);
				if(lastApprovalMsg.startsWith('Back to TPA')||lastApprovalMsg.startsWith('Acknowledged and read')){
					 $('#caseSheet1').show()
					  $('#caseSheet2').show()
					  
					  var caseSheetDocs='';
						var randonNmber='';
						$("#caseSheetDocs tr").remove();
						for(i=0;i<listSupportingDocs.length;i++){
							if(listSupportingDocs[i].screen_name=='nodal_officer'){
								caseSheetDocs +='<tr><td class="width500" class="height500"><textarea name="medicalDocs" readonly id="medicalDocs'+listSupportingDocs[i].captureVendorSupportingDocsId+'" class="form-control" id="medicalDocumentsDetails">'+listSupportingDocs[i].documentNote+'</textarea></td>';
								caseSheetDocs +='<td> <button name="data" class="btn btn-primary" type="button" data-name="'+listSupportingDocs[i].fileName+'" onclick="getNoteShetDownloadData(this)">View/Download Note Sheet Document</button></td>';
								caseSheetDocs +='</tr>';
							}
						}
						$j('#caseSheetDocs').append(caseSheetDocs);
				}
            
              }
            if (result && result.penaltyDetailData && result.penaltyDetailData.data && result.penaltyDetailData.data.mmuPenaltySum) {
                var mmuPenaltySum = result.penaltyDetailData.data.mmuPenaltySum;
               
             // Create a new list to store combined data
                var combinedList = [];

                // Create a map for quick lookup of mmuPenaltySum data by mmuId
                var mmuPenaltySumMap = {};
                for (var key in mmuPenaltySum) {
                	var splitMmu = key.split("@@");
                    var mmuNameVal = splitMmu[0];
                    var mmuIdVal = splitMmu[1];
                	if (mmuPenaltySum.hasOwnProperty(key)) {
                        mmuPenaltySumMap[mmuIdVal] = mmuPenaltySum[key];
                    }
                }

                // Loop through the list and combine with mmuPenaltySum data
                for (var i = 0; i < list.length; i++) {
                    var mmuId = list[i].mmuId;
                    var combinedData = {
                        mmuId: mmuId,
                        mmuName: list[i].mmuName,
                         manualPenaltyAmount:list[i].manualPenaltyAmount,
                         penaltyFileName:list[i].penaltyFileName,
                 		 auditorsRemarks:list[i].auditorsRemarks,
                        // Add other properties from list[i] if needed
                        penaltySum: mmuPenaltySumMap[mmuId] // Default to 0 if no penalty sum is found
                    };
                    combinedList.push(combinedData);
                }
                
                // Loop through the mmuPenaltySum keys and combine with list data
                /* for (var key in mmuPenaltySum) {
                    var splitMmu = key.split("@@");
                    var mmuNameVal = splitMmu[0];
                    var mmuIdVal = splitMmu[1];
                    var mmuIdValss = splitMmu[1]; */
                    for(i=0;i<combinedList.length;i++){
                    var manualPenaltyAmount=combinedList[i].manualPenaltyAmount;
                    var auditorsRemarks=combinedList[i].auditorsRemarks;
                    if(manualPenaltyAmount==undefined){
                    	manualPenaltyAmount="";
                    	auditorsRemarks="";
                    }
                    var $tr = $('<tr/>')
                        .append($('<td id="' + combinedList[i].mmuId + '" name="' + combinedList[i].mmuId + '"/>').text(combinedList[i].mmuName))
                        .append($('<td/>').append('<a class="text-theme font-weight-bold text-underline" name="mmuAmount" id="' + combinedList[i].mmuId + '" onClick="penaltySectionData(' + combinedList[i].mmuId + ')" data-background="static" href="javascript:void(0)">' +combinedList[i].penaltySum + '</a>'))
                        .append($('<td style="display: none"/>').append('<input name="autoPenaltyAmount" value="' +combinedList[i].penaltySum + '" id="autoPenaltyAmount" />'))
                        .append($('<td/>').append('<input type="text" id="manualPenalty' + combinedList[i].mmuId + '" name="manualPenaltyAmount" value="' + manualPenaltyAmount + '" readonly class="form-control" />'))
                        .append($('<td/>').append('<button name="data" class="btn btn-primary" type="button" id="downloadSupportingDocs" data-name="' + combinedList[i].penaltyFileName + '" onclick="getMaualPenaltyDownloadData(this)">View/Download Penalty Document</button>'))
                        .append($('<td/>').append('<textarea name="auditorRemarksMMU" style="width:600px; height:100px;" class="form-control border-input" validate="referralNote,string,no" id="auditorRemarksMMU" cols="0" rows="0" maxlength="1000" readonly tabindex="5">' + auditorsRemarks + '</textarea>'))
                         .append($('<td/>').append('<button name="data" type="button" class="btn btn-primary" onClick="generateReport(' + combinedList[i].mmuId + ')">View</button>'))
                        .append($('<td style="display: none"/>').append('<input name="itemId" value="' + mmuIdVal + '" id="nomenclatureId" />'))
                        .append($('<td style="display: none"/>').append('<input name="autoPenaltyAmount" value="' + mmuPenaltySum[key] + '" id="autoPenaltyAmount" />'))
                        .append($('<td style="display: none"/>').append('<input name="itemId" value="' + mmuPenaltySum[key] + '" id="nomenclatureId" />'));

                    $('#mmuPenaltyList').append($tr);     
                  
                  } 
               
            }
	            else
	            {
	            	 /* var mmuIdssssVal=$j('#mmuIdsValuePenalty').val();	
	            	 $.each(mmuIdssssVal, function(i, item){
	                 	var splitMmuss="";
	                 	splitMmuss = item.split("@@");
	             		var mmuNameValss = splitMmuss[1];
	             		var mmuIdValss = splitMmuss[0]; */
	             		for(i=0;i<list.length;i++){
	             		
	             			var manualPenaltyAmount=list[i].manualPenaltyAmount;
	                 		var manualPenaltyFileNamme=list[i].penaltyFileName;
	                 		var auditorsRemarks=list[i].auditorsRemarks;
	                 		if(manualPenaltyAmount==undefined){
	                 			manualPenaltyAmount="";
	                 			manualPenaltyFileNamme="";
	                 		}
	                 		if(auditorsRemarks==undefined){
	                 			auditorsRemarks="";
	                 		}
	                 		if(list[i].autoPenaltyAmount==undefined){
	                 			list[i].autoPenaltyAmount='0';
	                        }
	                 		
	                         var $tr = $('<tr/>')
	                         .append($('<td id='+list[i].mmuId+' name='+list[i].mmuId+'/>').text(list[i].mmuName))
	                         .append($('<td/>').append('<a class="text-theme font-weight-bold text-underline" name="autoPenaltyAmount" id="'+list[i].mmuId+'" data-background="static" "href="javascript:void(0)">'+list[i].autoPenaltyAmount+'</a>'))
	                         .append($('<td/>').append('<input type="text" id="manualPenalty'+list[i].mmuId+'" name="manualPenaltyAmount" value="'+manualPenaltyAmount+'" readonly class="form-control" />'))
	                         .append($('<td/>').append('<button name="data" class="btn btn-primary" type="button" id="downloadSupportingDocs" data-name="'+manualPenaltyFileNamme+'" onclick="getMaualPenaltyDownloadData(this)">View/Download Penalty Document</button>'))
	                         .append($('<td/>').append('<textarea name="auditorRemarksMMU"   style="width:600px; height:100px;"  class="form-control border-input validate="referralNote,string,no" id="auditorRemarksMMU" cols="0" rows="0" maxlength="1000" readonly tabindex="5">'+auditorsRemarks+'</textarea>'))
	                         .append($('<td/>').append($('<button name="data" type="button" class="btn btn-primary" onClick="generateReport('+list[i].mmuId+')">View</button>'))
	                         .append($('<td style="display: none";/>').append('<input name="autoPenaltyAmount" value="0" id="autoPenaltyAmount" />'))
	                          .append($('<td style="display: none";/>').append('<input name="itemId" value="'+list[i].mmuId+'" id="nomenclatureId" />'))
	                          .append($('<td style="display: none";/>').append('<input name="itemId" value="0" id="nomenclatureId" />')));
	                         $('#mmuPenaltyList').append($tr);
	                 		}
	            	
	            }
	           /* if(result && result.penaltyDetailData && result.penaltyDetailData.data && result.penaltyDetailData.data.mmuPenaltySum){
	           var mmuIdssssVal=$j('#mmuIdsValuePenalty').val();
	           $.each(mmuIdssssVal, function(i, item){

	          	var splitMmuss="";
	          	splitMmuss = item.split("@@");
	      		var mmuNameValss = splitMmuss[1];
	      		var mmuIdValss = splitMmuss[0];
	      		var checkForExist=true;
	        	   $('#mmuPenaltyList tr').each(function(i, el) {
	     		        var $tds = $(this).find('td');
	     				var itemId=$($tds).closest('tr').find("td:eq(4)").find("input:eq(0)").val();
	     				if(itemId==mmuIdValss){
	     					  checkForExist=false;
							  return false;
						    }
	        	       });
	        	   if(checkForExist==true){
	                		{	
	                        var $tr = $('<tr/>')
	                        .append($('<td id='+mmuIdValss+'/>').text(mmuNameValss))
	                        .append($('<td/>').append('<a class="text-theme font-weight-bold text-underline" id="'+mmuIdValss+'" data-background="static" "href="javascript:void(0)">0</a>'))
	                        .append($('<td/>').append('<textarea name="auditorRemarksMMU"   style="width:600px; height:100px;"  class="form-control border-input validate="referralNote,string,no" id="auditorRemarksMMU" cols="0" rows="0" maxlength="1000" tabindex="5"></textarea>'))
	                        .append($('<td/>').append($('<button name="data" type="button" class="btn btn-primary" onClick="generateReport('+mmuIdValss+')">View</button>'))
	                        .append($('<td style="display: none";/>').append('<input name="itemId" value="'+mmuIdValss+'" id="nomenclatureId" />')));
	                        $('#mmuPenaltyList').append($tr);
	                		}
	        	        }
	     			});	
	             } */
            //getVendorInvoiceApprovalDetails($('#captureVendorBillDetailId').val());
            getPenaltyAuthorityDetailsByUpss();

        }
    });
}

function getVendorInvoicePaymentDetails(val) {

	var pathname = window.location.pathname;
	var accessGroup ="MMUWeb";
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
						$('#paymentDetailsSection').show();
						var amountPaid=item.amountPaid;
						var tdsDeduction=item.tdsDeduction;
						var modeOfPayment=item.modeOfPayment;
						var transactionNumber=item.transactionNumber;	
						var invoiceAmount= item.invoiceAmount;
						var vendorInvoicePaymentId=item.vendorInvoicePaymentId;
						var penaltyAmount=item.penaltyAmount;
						var paymentDate=item.paymentDate;
						
							$('#finalPaymentDate').val(paymentDate);
							$('#finalInvoiceAmont').val(invoiceAmount);
							$('#paymentPenaltyAmont').val(penaltyAmount);
							$('#tdsDeduction').val(tdsDeduction);
							$('#finalAmount').val(amountPaid);
							$('#modeOfPayment').val(modeOfPayment);
							$('#transNo').val(transactionNumber);
												
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

function getSupportingDownloadData(button)
{
	var namVal= button.getAttribute('data-name');
	window.open("${pageContext.servletContext.contextPath}/audit/download?name="+namVal+"&type=vendor_bill\\supporting_document&keys="+$('#invoiceNo').val(), '_blank').focus();	
}


function getMaualPenaltyDownloadData(button)
{
	var namVal= button.getAttribute('data-name');
	window.open("${pageContext.servletContext.contextPath}/audit/download?name="+namVal+"&type=audit_report\\manual_penalty&keys="+$('#invoiceNo').val(), '_blank').focus();	
}

function getNoteShetDownloadData(button)
{
	var namVal= button.getAttribute('data-name');
	window.open("${pageContext.servletContext.contextPath}/audit/download?name="+namVal+"&type=nodal_officer&keys="+$('#invoiceNo').val(), '_blank').focus();	
}

function penaltySectionData(val)
{
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
        var mmuPenaltySum = result.penaltyDetailData.data.mmuPenaltySum;
        var mmuPenalty = result.penaltyDetailData.data.mmuPenalty;
        for(key1 in mmuPenaltySum){
             	var splitMmu="";
             	splitMmu = key1.split("@@");
         		var mmuNameVal = splitMmu[0];
         		var mmuIdVal = splitMmu[1];
         if(val==mmuIdVal)		
            if(result && result.vendorInvoiceDetailData && result.vendorInvoiceDetailData.data && result.vendorInvoiceDetailData.data.length > 0){  
	   $('modal-backdrop').show();
	      $("#penaltyModal").show();
		var $insTitleTr = $('<tr/>').append($('<td/>').attr('colspan', 3).css('background-color', 'lavender').append('<b>Inspection Penalty Incident List</b>'));
	    var $equipTitleTr = $('<tr/>').append($('<td/>').attr('colspan', 3).css('background-color', 'lavender').append('<b>Equipment Penalty Incident List</b>'));
	    var $attenTitleTr = $('<tr/>').append($('<td/>').attr('colspan', 3).css('background-color', 'lavender').append('<b>Attendance Penalty Incident List</b>'));
	    $('#inspectionPenaltyIncidentList').empty().append($insTitleTr);
	    $('#equipmentPenaltyIncidentList').empty().append($equipTitleTr);
	    $('#attendancePenaltyIncidentList').empty().append($attenTitleTr);
	    var splitMmu="";
    	splitMmu = key1.split("@@");
		var mmuNameVal = splitMmu[0];
		var mmuIdVal = splitMmu[1];
	    $('#mmuNameLabel').text(mmuNameVal);
	    var insSubtotal = 0;
	    var equipSubtotal = 0;
	    var attenSubtotal = 0;
	    var penaltyData = result.penaltyDetailData.data.mmuPenalty[mmuNameVal];
	    for(var i=0;i<penaltyData.length;i++){
	        var record = penaltyData[i];
	        var $tr1 = $('<tr/>')
	            .append($('<td/>').attr('width', '95px').text(record.incidentDate))
	            .append($('<td/>').text(record.incidentDescription))
	            .append($('<td/>').attr('width', '110px').text(record.penaltyAmount));
	        if(record.penaltyType == 'INSPECTION'){
	            $('#inspectionPenaltyIncidentList').append($tr1);
	            insSubtotal += parseInt(record.penaltyAmount);
	        } else if(record.penaltyType == 'EQUIPMENT') {
	            $('#equipmentPenaltyIncidentList').append($tr1);
	            equipSubtotal += parseInt(record.penaltyAmount);
	        } else {
	            $('#attendancePenaltyIncidentList').append($tr1);
	            attenSubtotal += parseInt(record.penaltyAmount);
	        }
	    }
	    var $insSubtitleTr = $('<tr/>')
	        .append($('<td/>').attr('colspan', 2).css('background-color', 'lavender').append('<b>Inspection Penalty Subtotal</b>'))
	        .append($('<td/>').css('background-color', 'lavender').append('<b>'+insSubtotal+'</b>'));
	    var $equipSubtitleTr = $('<tr/>')
	        .append($('<td/>').attr('colspan', 2).css('background-color', 'lavender').append('<b>Equipment Penalty Subtotal</b>'))
	        .append($('<td/>').css('background-color', 'lavender').append('<b>'+equipSubtotal+'</b>'));
	    var $attenSubtitleTr = $('<tr/>')
	        .append($('<td/>').attr('colspan', 2).css('background-color', 'lavender').append('<b>Attendance Penalty Subtotal</b>'))
	        .append($('<td/>').css('background-color', 'lavender').append('<b>'+attenSubtotal+'</b>'));
	    $('#inspectionPenaltyIncidentList').append($insSubtitleTr);
	    $('#equipmentPenaltyIncidentList').append($equipSubtitleTr);
	    $('#attendancePenaltyIncidentList').append($attenSubtitleTr);
            }
        }
        }
        }); 
}
	
function closeModal()
{
	$('#penaltyModal').hide();
	$('.modal-backdrop').hide();
}

function pad2(n) {
	  return (n < 10 ? '0' : '') + n;
	}

function generateReport(val){
	
	
	 
	  var fromDateVal = $('#invoiceDate').val();
	  var dateParts = fromDateVal.split("/");

	  // month is 0-based, that's why we need dataParts[1] - 1
	  var date = new Date(+dateParts[2], dateParts[1] - 1, +dateParts[0]); 
	  //var date = new Date(fromDate);
	  var firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
	  var lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
	  
	  var dateLast = lastDay;
	  var month = pad2(dateLast.getMonth()+1);//months (0-11)
	  var day = pad2(dateLast.getDate());//day (1-31)
	  var year= dateLast.getFullYear();
	  var toDate =  day+"/"+month+"/"+year;
	  
	  var dateFirst = firstDay;
	  var month1 = pad2(dateFirst.getMonth()+1);//months (0-11)
	  var day1 = pad2(dateFirst.getDate());//day (1-31)
	  var year1= dateFirst.getFullYear();
	  var fromDate =  day1+"/"+month1+"/"+year1;
	  
	  var mmu_id = val;
    var city_id = 0;//$('#cityId').val();
    var vendor_id = $('#vendorIdValue').val();
    
    
    var User_id = <%=userId%>;
    var Level_of_user = '<%=levelOfUser%>';
    	  
var url = "${pageContext.request.contextPath}/report/printIncidentRegister?mmu_id="
		+ mmu_id			
		+ "&fromDate="
		+ fromDate
		+ "&toDate="
		+ toDate
		+ "&User_id="
		+ User_id
		+ "&Level_of_user="
		+ "S"
		+ "&radioValue="
		+ "D"
		+ "&city_id="
		+ city_id
		+ "&vendor_id="
		+ vendor_id;

    openPdfModel(url)


}

function getPenaltyAuthorityDetailsByUpss(){
	var upssId=$('#district').val();
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/audit/getPenaltyAuthorityDetailsByUpss",
	    data: JSON.stringify({'upssId':upssId}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(result){
	    	
	    	$('#penaltyAmountImposedId').val(result);
	    	if(result==<%=session.getAttribute("authorityId")%>)
	    	{
	    		$('#penaltyAmountDisplay').show();
	    	}	
	    }
	    
	});
}
</script>
</head>

<body>
 <!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">Vendor Invoice Details</div>

				<div class="row">
				<input  name="captureVendorBillDetailId" id="captureVendorBillDetailId" type="hidden" value=""/>
				<input  name="vendorIdValue" id="vendorIdValue" type="hidden" value=""/>
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
												<input type="text" id="vendorId" class="form-control" disabled/>
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
												<input type="text" id="cityId" class="form-control" disabled/>
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
																tabindex="1" id="mmuIds" class="listBig width-full disablecopypaste" disabled>
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
													    <input type="text" id="billMonth" class="form-control" disabled/>
													</div>

												</div>
											</div>
											<div class="col-lg-4 col-sm-6">
												<div class="form-group row">
													<label class="col-form-label col-md-1">/</label>
													<div class="col-md-7">
														<input type="text" id="billYear" class="form-control" disabled/>
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
												<input type="text" id="invoiceNo" class="form-control" disabled/>
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
													<input type="text" class="form-control" id="invoiceDate" disabled/>
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
												<input type="text" id="invoiceAmount" class="form-control" disabled/>
											</div>

										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label"></label>
											</div>
											<div class="col-md-7">
												<button class="btn btn-primary" id="downloadBill">Download Bill</button>
											</div>
										</div>
									</div>
								</div>
<div class="col-12">
														<h6 class="text-theme text-underline font-weight-bold">Vendor Invoice (Supporting Document)</h6>
														</div>
														
														<div class="col-7">
															<table class="table table-hover table-striped table-bordered">
																<thead>
																	<tr>
																		<th>Document Name</th>
																		<th>Document Type(Note)</th>
																		<th>View/Download</th>
																	</tr>
																</thead>
																
																<tbody id="supportingDocs">
																	<tr>
																		<td class="width200">
																			<div class="col-md-12">
                                                  								  <input type="text" class="form-control" name="docId" id="docId"/>
                                                							</div>
																			<input type="hidden" name="patientDocumentId" name="patientDocumentId" value=""/>
																			
																		</td>																		
																		<td class="width200">
																		    <textarea name="medicalDocs" id="medicalDocs" class="form-control" id="medicalDocumentsDetails"></textarea>
																		</td>
																		<td>
																		<button name="data" class="btn btn-primary" type="button" id="downloadSupportingDocs" onclick="getDownloadData()">View/Download Supporting Document</button>
																		</td>
																		
																	</tr>
																</tbody>
															</table>
														</div>
												<div>
									<h6 class="font-weight-bold text-theme text-underline">Penalty Details</h6>

									<div class="table-responsive">
										<table
											class="table table-striped table-hover table-bordered " id="campTable">
											<thead class="bg-success" style="color: #fff;">
												<tr>
													<th>MMU Name</th>
													<th>Audit Penalty Amount</th>
													<th>Monthly Penalty Amount</th>
													<th>Document Upload(Manual Penalty)</th>
													<th>Auditor's Remarks</th>
													<th>Incident Report</th>
													<th style="display: none";>id</th>
													<th style="display: none";>amount</th>
												</tr>
											</thead>
											<tbody id="mmuPenaltyList">

											</tbody>
										</table>
									</div>
								</div>
								<div>		
											<div class="col-lg-4 col-sm-6" id="penaltyAmountDisplay" style="display:none">
                                            <div class="form-group row">
                                            <div class="col-md-5">
												<label class="col-form-label">Penalty Amount Imposed</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="penaltyAmountImposed" maxlength="13" onchange="checkAmountValidation()" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  name="penaltyAmountImposed" class="form-control"/>
											</div>
                                            </div>
                                        </div>
									<div class="col-12" id="caseSheet1" style="display: none">
										<h6 class="text-theme text-underline font-weight-bold">Suggested
											/Imposed Penalty</h6>
									</div>
									<!-- <div class="row"> -->
										<div class="col-lg-4 col-sm-6">
											<div class="form-group row">
												<label class="col-md-7 col-form-label">Suggested
													Penalty By Auditor</label>
												<div class="col-md-5">
													<input type="text" id="suggestedPenaltyAuditor"
														class="form-control" disabled />
												</div>
											</div>
										</div>
										<div class="col-lg-4 col-sm-6">
											<div class="form-group row">
												<label class="col-md-7 col-form-label">Imposed
													Penalty By Nodal</label>
												<div class="col-md-5">
													<input type="text" id="nodalImposedPenalty"
														class="form-control" disabled />
												</div>
											</div>
										</div>
									<!-- </div> -->
									   
								<div id="approvingDetailsSection" style="display:none">
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
													<th>Auditor's Action</th>
												</tr>
											</thead>
											<tbody id="approvingAuthorityList">

											</tbody>
										</table>
									</div>
								</div>
								
								</div>
                                 <!-- <div class="row m-t-10"> -->
									   <div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-7">
												<label class="col-form-label">Download Auditor Report</label>
											</div>
											<div class="col-md-5">
												<button class="btn btn-primary" id="downloadAuditorReport">View/Download</button>
											</div>
										</div>
									</div>
									<div class="col-12" id="caseSheet1" style="display:none">
														<h6 class="text-theme text-underline font-weight-bold">Note Sheet</h6>
														</div>
														
														<div class="col-12" id="caseSheet2" style="display:none">
															<table class="table table-hover table-striped table-bordered">
																<thead>
																	<tr>
																		<th>Note-Sheet</th>
																		<th>Upload File</th>
																	</tr>
																</thead>
																
																<tbody id="caseSheetDocs">
																	<tr>
																													
																		<td class="width500" class="height500">
																		    <textarea name="caseSheet" id="caseSheet" class="form-control"></textarea>
																		</td>
																	
																	</tr>
																</tbody>
															</table>
														</div>
								<div>
								<div id="paymentDetailsSection" style="display:none" >
									 <h6 class="font-weight-bold text-theme text-underline">Payment Details</h6>
									<div class="row">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Date</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="finalPaymentDate" class="form-control" readonly/>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Invoice Amount</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="finalInvoiceAmont" class="form-control" readonly/>
											</div>
										</div>
									</div>
                                   <div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Penalty Amount</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="paymentPenaltyAmont" class="form-control" readonly/>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									
                                    <div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Total Deduction</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="tdsDeduction" onblur="calculateFinalAmount()" class="form-control" readonly/>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Final Amount</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="finalAmount" class="form-control" readonly/>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Mode Of Payment</label>
											</div>
											 <div class="col-md-7">
                                                    <select class="form-control" id="modeOfPayment" name="modeOfPayment" readonly>
                                                        <option value="">--Select--</option>
                                                        <option value="online">Online</option>
                                                        <option value="cash">Cash</option>
                                                        <option value="cheque">Cheque</option>
                                                        <option value="dd">DD</option>
                                                        
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
												<input type="text" id="transNo" class="form-control" readonly/>
											</div>
										</div>
									</div>
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Payment Recepit</label>
											</div>
											<div class="col-md-7">
										    	<button class="btn btn-primary" id="downloadRecepitBill">View/Download</button>
											</div>
										</div>
									</div>
									
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Remarks</label>
											</div>
											<div class="col-md-7">
												<textarea name="paymentRemarks" id="paymentRemarks" class="form-control"></textarea>
											</div>
										</div>
									</div>
									
								</div>
								</div></div></div>
								<div class="row">
                                	<div class="col-12 m-t-10 text-right">
                               			<button type="button" class="btn btn-primary" id="back">Back</button>
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
	        <button type="button" class="close" data-dismiss="modal" onclick="closeModal()" aria-label="Close">
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
	      	<div class="scrollableDiv m-b-10">
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
			</div>
	      	<div class="row">
            	<div class="col-12 m-t-10 text-right">
           			<button class="btn btn-primary"  data-dismiss="modal" onclick="closeModal()" aria-label="Close" >Close</button>
           		</div>
      		</div>
	      </div>

	    </div>
	  </div>
</div>


</body>

</html>


<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>