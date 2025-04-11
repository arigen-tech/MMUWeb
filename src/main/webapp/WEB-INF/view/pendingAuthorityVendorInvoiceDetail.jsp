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
	
	String userTypeDesignation="";
	if (session.getAttribute("userTypeDesignation") != null) {
		userTypeDesignation = session.getAttribute("userTypeDesignation") + "";
	}
	
	String levelOfUser = "1";
	if (session.getAttribute("levelOfUser") != null) {
		levelOfUser = session.getAttribute("levelOfUser") + "";
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
    loadBillDetails();
   
    var username='<%=userName%>';
	 $('#userName').val(username);
    var usertypedesignation='<%=userTypeDesignation%>';
    $('#userDesignation').val(usertypedesignation);
    var userDesignation=$('#finalApproval').val();
   if(userDesignation=='y')
    {
    	$('#penaltyA').show();
    	$('#forwardToId').hide();
    	var combo = "" ;
    	$j("#actionId").empty();
    	combo += '<option value="">Select</option>';
    	combo += '<option value="A">Penalty suggested as per auditor</option>';
    	combo += '<option value="D">Review and revised penalty</option>';
    	jQuery('#actionId').append(combo);
    	
    	
    }
   getAuthorityList();
    /* $('#backBtn').on('click', function(){
    	 window.location.href = 'pendingVendorInvoiceApprovingAuthority';
    	//window.history.back();
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
});

function backFunction(){
	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/audit/pendingVendorInvoiceApprovingAuthority";
	 window.location = url;
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
                var lastApprovalMsg=rowData.lastApprovalMsg;
                $('#vendorIdName').val(rowData.vendorName);
                $('#districtName').val(rowData.districtName);
                $('#cityIdName').val(rowData.cityName);
                $('#vendorId').val(rowData.vendorId);
                $('#district').val(rowData.district);
                $('#cityId').val(rowData.cityId);
                $('#billYear').val(rowData.billYear);
                $('#billMonth').val(rowData.billMonth);
                $('#billMonthValue').val(rowData.billMonth);
                $('#invoiceNo').val(rowData.invoiceNo);
                $('#invoiceDate').val(rowData.invoiceDate);
                $('#invoiceAmount').val(rowData.invoiceAmount);
                $('#captureVendorBillDetailId').val(rowData.captureVendorBillDetailId);
                $('#uploadedFileName').val(rowData.uploadedFileName);
                $('#downloadBill').attr('data-name', rowData.uploadedFileName);
                $('#downloadAuditorReport').attr('data-name', rowData.auditorFileName);
                if(lastApprovalMsg.startsWith('Acknowledged and read')){
                	 $('#penaltyAmountImposed').val(rowData.suggestedPenaltyAmount);
 	                $('#penaltyAmount').val(rowData.penaltyAmount);
 	              		var combo = "" ;
	 	                $j("#actionId").empty();
	 	          	    combo += '<option value="">Select</option>';
	 	          	    combo += '<option value="A">Penalty suggested as per auditor</option>';
	 	          	    jQuery('#actionId').append(combo);
                }else{
	                $('#penaltyAmountImposed').val(rowData.calculatedPenaltyAmount);
	                $('#penaltyAmount').val(rowData.calculatedPenaltyAmount);
                }
                
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
					}
				}
				$j('#supportingDocs').append(supportingDocs);
				$j('#mmuIdsValuePenalty').append(mmuIdsValuePenalty);
				if(lastApprovalMsg.startsWith('Acknowledged and read')){
					 $('#caseSheet1').show()
					  $('#caseSheet2').show()
					  $('#noteSheetFlag').val("yes");
					  var caseSheetDocs='';
						var randonNmber='';
						$("#caseSheetDocs tr").remove();
						for(i=0;i<listSupportingDocs.length;i++){
							if(listSupportingDocs[i].screen_name=='nodal_officer'){
								caseSheetDocs +='<tr><td class="width500" class="height500"><textarea name="medicalDocs" readonly id="medicalDocs'+listSupportingDocs[i].captureVendorSupportingDocsId+'" class="form-control" id="medicalDocumentsDetails">'+listSupportingDocs[i].documentNote+'</textarea></td>';
								caseSheetDocs +='<td> <button name="data" class="btn btn-primary" type="button" data-name="'+listSupportingDocs[i].fileName+'" onclick="getNoteShetDownloadData(this)">View/Download Note Sheet Document</button></td>';
								caseSheetDocs += '<td class="width200"><div class="col-md-12"><button type="button" class="btn btn-primary buttonAdd noMinWidth" disabled value="" button-type="add" tabindex="1" onclick=""></button></div>';
								caseSheetDocs += '<td class="width200"><div class="col-md-12"><button type="button" class="btn btn-danger buttonAdd noMinWidth"  disabled name="deleteForSupportDocNew" value=""    id="deleteForSupportDocNew"  button-type="delete" tabindex="1"></button></div>';
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
                   var manualPenaltyAmt=combinedList[i].manualPenaltyAmount;
                   var auditorsRemarks=combinedList[i].auditorsRemarks;
                   var fileMmmuName=combinedList[i].penaltyFileName;
                   if(manualPenaltyAmt==undefined){
                	   manualPenaltyAmt="";
                   }
                   if(auditorsRemarks==undefined){
                	   auditorsRemarks="";
                   }
                   if(fileMmmuName==undefined){
                	   fileMmmuName="";
                   }
                	   
                    var $tr = $('<tr/>')
                        .append($('<td id="' + combinedList[i].mmuId + '" name="' + combinedList[i].mmuId + '"/>').text(combinedList[i].mmuName))
                        .append($('<td/>').append('<a class="text-theme font-weight-bold text-underline" name="mmuAmount" id="' + combinedList[i].mmuId + '" onClick="penaltySectionData(' + combinedList[i].mmuId + ')" data-background="static" href="javascript:void(0)">' +combinedList[i].penaltySum + '</a>'))
                        .append($('<td style="display: none"/>').append('<input name="autoPenaltyAmount" value="' +combinedList[i].penaltySum + '" id="autoPenaltyAmount" />'))
                        .append($('<td/>').append('<input type="text" id="manualPenalty' + combinedList[i].mmuId + '" name="manualPenaltyAmount" value="' + manualPenaltyAmt + '" readonly class="form-control" />'))
                        .append($('<td/>').append('<button name="data" class="btn btn-primary" type="button" id="downloadSupportingDocs" data-name="' + fileMmmuName + '" onclick="getMaualPenaltyDownloadData(this)">View/Download Penalty Document</button>'))
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
            
            getVendorInvoiceApprovalDetails($('#captureVendorBillDetailId').val());
            getPenaltyAuthorityDetailsByUpss();
                      
        }
    });
}

function getVendorInvoiceApprovalDetails(val) {

	var pathname = window.location.pathname;
	var accessGroup = "MMUWeb";
	var url = window.location.protocol + "//"
	+ window.location.host + "/" + accessGroup
	+ "/audit/getVendorInvoiceApprovalDetails";
	
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
					var authorityIdForReject="";
					var orderNoForReject="";
					var forwardAuthorityIdForReject="";
					var forwardOrderNoForReject="";
					var vendorInvoiceApprovalId="";
				
					var i=0;
					$.each(datas, function(i, item) {
						var authorityId=item.authorityId;
						var authorityDate=item.authorityDate;
						var authorityName=item.authorityName;
						var authorityRemarks=item.authorityRemarks;	
						var authorityRole= item.authorityRole;
						var actionValue=item.actionValue;
						vendorInvoiceApprovalId=item.vendorInvoiceApprovalId;
						authorityIdForReject=item.authorityId;
						orderNoForReject=item.orderNo;
						forwardAuthorityIdForReject=item.forwardAuthorityId;
						forwardOrderNoForReject=item.forwardOrderNo;
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
						trHTML +='<td><div><textarea class="form-control" type="text" id="authorityRemarks" maxlength="1000" readonly>'+authorityRemarks+'</textarea></div></td>'; 
						trHTML +='<td><div><input type="text" value="'+actionValue+'" tabindex="1" id="nomenclature11'+i+'""  size="25" name="nomenclature1" class="form-control width130" onblur="updatePopulatePVMSTemplate(this.value,1,this);" readonly/></div></td>'; 
						trHTML +='</tr>';
					});
					    
					
					    $('#authorityIdForReject').val(authorityIdForReject);
		                $('#orderNoForReject').val(orderNoForReject);
		                $('#forwardAuthorityIdForReject').val(forwardAuthorityIdForReject);
		                $('#forwardOrderNoForReject').val(forwardOrderNoForReject);
		                $('#vendorInvoiceApprovalId').val(vendorInvoiceApprovalId);
				
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
	    	var authId=$('#authorityOrderNo').val();
	    	for(var i=0;i<result.masAuthorityData.length;i++){
	    		var checkAuthId=result.masAuthorityData[i].orderNo;
	    		if(authId>checkAuthId)
	    		{	
	    		combo += '<option value='+result.masAuthorityData[i].authorityId+'@@'+result.masAuthorityData[i].orderNo+'>' +result.masAuthorityData[i].authorityName+ '</option>';
	    		}
	    	}
	    	jQuery('#forwordTo').append(combo);
	    	
	    }
	    
	});
}

function submitAuditorForm(){
	
	const noteSheets = document.querySelectorAll('textarea[name="caseSheet"]');
    const fileInputs = document.querySelectorAll('input[name="caseSheetUpload"]');
    const notes = [];
    const files = [];

    for (const noteSheet of noteSheets) {
        if (notes.includes(noteSheet.value)) {
            alert('Duplicate note sheet content found. Please change the content.');
            return false;
        }
        notes.push(noteSheet.value);
    }

    for (const fileInput of fileInputs) {
        const fileName = fileInput.value.split('\\').pop();
        if (files.includes(fileName)) {
            alert('Duplicate file name found. Please choose a different file.');
            return false;
        }
        files.push(fileName);
    }
    
    var count = 0;
    if($('#actionId').val()=="D"){
	 $('#caseSheetDocs tr').each(function(ij, el) {
   var fileNameValueIDd = $(this).closest('tr').find("td:eq(1)").find("input:eq(0)").attr("id"); 
   var docName = $(this).closest('tr').find("td:eq(0)").find("textarea:eq(0)").attr("id"); 
   var docNameValue = $(this).closest('tr').find("td:eq(0)").find("textarea:eq(0)").val();
   var fileNameValue = $('#' + fileNameValueIDd).val();
   //var docNameValue = $('#' + docName).val();
   // Check if any field is filled
   if (fileNameValue || docNameValue ) {
       // Ensure all fields are filled
       if (!fileNameValue || !docNameValue) {
           alert('All fields in a Note Sheet row must be filled if any input field is filled.');
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
    }
	      
	 	if(count>0){
	 		alert("Please upload valid file.");
	 	}
	
	var authorityIdForReject="";
	var orderNoForReject="";
	var forwardAuthorityIdForReject="";
	var forwardOrderNoForReject="";
   if(!$('#actionId').val()){
	      alert('Please Select Action!');
	      return false;
	  }
      var usertypedesignation=$('#finalApproval').val();
      if($('#actionId').val()!="R")
      {
      if(usertypedesignation!='y')	
      { 
		  if(!$('#forwordTo').val()){
		      alert('Please Select Forward To!');
		      return false;
		   }
       }
      }
      else
      {
    	  authorityIdForReject= $('#authorityIdForReject').val();
    	  orderNoForReject=$('#orderNoForReject').val();
    	  forwardAuthorityIdForReject=$('#forwardAuthorityIdForReject').val();
    	  forwardOrderNoForReject=$('#forwardOrderNoForReject').val();  
      }
      if($('#penaltyAmountDisplay').is(':visible')) {
    	  if($('#penaltyAmountImposedAuth').val()==""){
    	      alert('Please enter Penalty Amount Imposed!');
    	      return false;
    	  }
      }
      
      if($('#actionId').val()=="D" && $('#penaltyAmount').val()==""){
	      alert('Please enter penalty amount!');
	      return false;
	   }
      
      if(usertypedesignation=='y')	
      { 
		  if($('#actionId').val()!="D" && $('#penaltyAmount').val()==""){
		      alert('Please enter penalty amount!');
		      return false;
		   }
       }
  
  if(!$('#remarks').val()){
      alert('Please enter remarks!');
      return false;
  }
  
  var lastApprovalMsg='';
  var currentdate = getTodayDate(new Date());
  if($('#actionId').val()=="A")
  {
  	lastApprovalMsg='Approved by '+$('#authorityRoleName').val()+' on ('+currentdate+')';
  	
  }
  else
  {
  	lastApprovalMsg='Back to TPA by '+$('#authorityRoleName').val()+' on ('+currentdate+')';
  }	
  
  var dataJSON = {

          'actionId': $('#actionId').val(),
          'forwordTo': $('#forwordTo').val(),
          'remarks': $('#remarks').val(),
          'captureVendorBillDetailId':$('#captureVendorBillDetailId').val(),
          'authorityId':$('#authorityId').val(),
          'authorityOrderNo':$('#authorityOrderNo').val(),
          'authorityRoleName':$('#authorityRoleName').val(),
          'finalApproval':$('#finalApproval').val(),
          'authorityName':$('#userName').val(),
          'penaltyAmount':$('#penaltyAmount').val(),
          'penaltyAmountImposed':$('#penaltyAmountImposed').val(),
          'finalAmount':$('#finalAmount').val(),
          'invoiceAmount':$('#invoiceAmount').val(),
          'authorityIdForReject':authorityIdForReject,
          'orderNoForReject':orderNoForReject,
          'forwardAuthorityIdForReject':forwardAuthorityIdForReject,
          'forwardOrderNoForReject':forwardOrderNoForReject,
          'vendorInvoiceApprovalId':$('#vendorInvoiceApprovalId').val(),
          'lastApprovalMsg':lastApprovalMsg,
          'penaltyAmountImposedAuth':$('#penaltyAmountImposedAuth').val(),
          'userId':$('#userId').val()
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
              localStorage.typeOfVal='authority';
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
        	$("#captureAuditDataSubmit").attr("disabled", false);
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
            $("#captureAuditDataSubmit").attr("disabled", false);
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

function checkAmountValidation()
{
	 var amt = $('#penaltyAmount').val();
     var s = amt.split('.');
 	
	  if (s[0].length > 10) {
	    alert("Penalty amount should be max 10 digit before decimal value");
	    $('#penaltyAmount').val('');
	    return false;
	  }
	  if(s.length>1)
	  {	  
	  if (s[1].length > 2) {
		  alert("Decimal value should be only 2 digit in penalty amount");
		  $('#penaltyAmount').val('');
		  return false;
	  }
	 if (s[1].length < 1) {
		  alert("Decimal value should be at least 1 digit in penalty amount");
		  $('#penaltyAmount').val('');
		  return false;
	  }
	  }
   if(amt.length > 13){
       alert('Penalty amount can be only 12 digit number!');
       $('#penaltyAmount').val('');
   }
   if($('#invoiceAmount').val() && parseInt($('#invoiceAmount').val()) < parseInt($('#penaltyAmount').val())){
	      alert('Penalty amount can not be greater than invoice amount!');
	      $('#penaltyAmount').val('');
	      return false;
	      
	  }
	
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

function disbaledAuditorForwardTo(){
	  var actionId= $('#actionId').val();
	  var authrityVal=$('#auditorAuthorityId').val();
	 if(actionId=='D'){
		 $('#caseSheet1').show()
		  $('#caseSheet2').show()
		  $('#penaltyAmount').prop('readonly', false);
	  }else if($('#noteSheetFlag').val()=="yes"){
		  $('#penaltyAmount').prop('readonly', true);
		 
	  }else{
		  $('#penaltyAmount').prop('readonly', true);
		  $('#caseSheet1').hide()
		  $('#caseSheet2').hide() 
	  }
	
	
}

var rowId=0;
function addNoteSheetDocs() {
		var tbl = document.getElementById('caseSheetDocs');
		lastRow = tbl.rows.length;
		rowId = lastRow;
		rowId++;
		var val = parseInt($('#caseSheetDocs>tr:last').find("td:eq(0)").text());
		var aClone = $('#caseSheetDocs>tr:last').clone(true)
		aClone.find(":input").val("");
		aClone.find("td:eq(0)").find("textarea:eq(0)").prop('id', 'caseSheet'+rowId+'');
		
		aClone.find("td:eq(1)").find("input:eq(0)").prop('id', 'caseSheetUpload'+rowId+'');
		//aClone.find("td:eq(2)").find("input:eq(0)").prop('name', 'supportingDocsUpload'+rowId+'');
		
		aClone.find("option[selected]").removeAttr("selected")
		
		var patientDetailDocFile='<div class="fileUploadDiv"><input type="file" name="caseSheetUpload" id="caseSheetUpload'+rowId+'" value="" class="inputUpload"><label class="inputUploadlabel">Choose File</label><span class="inputUploadFileName">No File Chosen</span></div>';
		aClone.find("td:eq(1)").html(patientDetailDocFile);

		aClone.find('button[button-type="delete"]').removeAttr('disabled');
		
		aClone.clone(true).appendTo('#caseSheetDocs');
		var val = $('#supportingDocs>tr:last').find("td:eq(2)").find(":input")[0];
		rowId++;

	}
	
function deleteRow(item) {
	 //if(confirm(resourceJSON.msgDelete)){
		 if($('#caseSheetDocs tr').length > 1) {
				 $(item).closest('tr').remove();
		 }else{
			 alert("Atleast one row should be there in note sheet table !")
			 return false;
		 }
			 
	
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
    var vendor_id = $('#vendorId').val();
    
    
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

function getNoteShetDownloadData(button)
{
	var namVal= button.getAttribute('data-name');
	window.open("${pageContext.servletContext.contextPath}/audit/download?name="+namVal+"&type=nodal_officer&keys="+$('#invoiceNo').val(), '_blank').focus();	
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

				<div class="internal_Htext">Vendor Invoice Approval Page(Approving Authority)</div>
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
		           <input  name="authorityIdForReject" id="authorityIdForReject" type="hidden" value=""/>
		           <input  name="orderNoForReject" id="orderNoForReject" type="hidden" value=""/>
		           <input  name="forwardAuthorityIdForReject" id="forwardAuthorityIdForReject" type="hidden" value=""/>
		           <input  name="forwardOrderNoForReject" id="forwardOrderNoForReject" type="hidden" value=""/>
		           <input  name="billMonth" id="billMonth" type="hidden" value=""/>
		           <input  name="vendorInvoiceApprovalId" id="vendorInvoiceApprovalId" type="hidden" value=""/>
		           <input  name="penaltyAmountImposedId " id="penaltyAmountImposedId" type="hidden" value=""/>
		           <input  name="userId " id="userId" type="hidden" value="<%=userId%>"/>
		           <input  name="noteSheetFlag " id="noteSheetFlag" type="hidden" value=""/>
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
											<div class="col-md-4" style=display:none;>
												<div class="form-group row  autocomplete">
												<div class="col-md-7">
															<select name="mmuIdsValuePenalty" multiple="4" value="" size="5"
																tabindex="1" id="mmuIdsValuePenalty" class="listBig width-full disablecopypaste" readonly>
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
                                                    <select class="form-control" id="billMonthValue" name="billMonthValue" disabled>
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
												<button class="btn btn-primary" id="downloadBill">Download Vendor Bill</button>
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
													<th>Auto Penalty Amount</th>
													<th>Manual Penalty Amount</th>
													<th>View Upload(Manual Penalty)</th>
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
								</div>
                                <div>
                                <div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Download Auditor Report</label>
											</div>
											<div class="col-md-7">
												<button class="btn btn-primary" id="downloadAuditorReport">View/Download</button>
											</div>
										</div>
									</div>
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
													<th>Action</th>
												</tr>
											</thead>
											<tbody id="approvingAuthorityList">

											</tbody>
										</table>
									</div>
								</div>
								<!-- <div>
									<h6 class="font-weight-bold text-theme text-underline">Auditor Details</h6>
                                  	<div class="row">
									<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Date</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="auditDate" class="form-control" disabled/>
											</div>
										</div>
									</div>
                                    <div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Name</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="auditName" class="form-control" disabled/>
											</div>
										</div>
									</div>
											
								</div>
							
									<div class="row">
									<div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
												<label class="col-form-label">Auditor Remarks</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<textarea name="auditorRemarks"   style="width:600px; height:100px;"  class="form-control border-input
														validate="referralNote,string,no" id="auditorRemarks"
														cols="0" rows="0" maxlength="500" tabindex="5"></textarea>
												</div>
											</div>
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
									
								</div> -->
						
                            		<div class="col-lg-4 col-sm-6" id="penaltyAmountDisplay" style="display:none">
                                            <div class="form-group row">
                                            <div class="col-md-5">
												<label class="col-form-label">Penalty Amount As Per Auditor</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="penaltyAmountImposedAuth" maxlength="13" onchange="checkAmountValidation()" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  name="penaltyAmountImposedAuth" class="form-control"/>
											</div>
                                            </div>
                                     </div>
									<h6 class="font-weight-bold text-theme text-underline">Approving Authority</h6>
									<div class="row">
                                        <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">Action</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <select class="form-control" name="actionId" onchange="disbaledAuditorForwardTo()" id="actionId">
                                                        <option value="">--Select--</option>
                                                        <option id="approvedFlag" value="A">Approve</option>
                                                        <option value="R">Reject</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
 										<div class="col-md-4">
										  <div class="form-group row" id="forwardToId">
											<div class="col-md-5">
												<label class="col-form-label">Forward To</label>
											</div>
											<div class="col-md-7">
												<select class="form-control" name="forwordTo" id="forwordTo">
												<option value="">Select</option>
												</select>
											</div>
										</div>
										</div></div>
										<div class="row" id="penaltyA" style="display:none">
										<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Penalty Amount by Auditor</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="penaltyAmountImposed" maxlength="13" onkeypress="return isNumberKey(event)" onchange="checkAmountValidation()" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  name="penaltyAmount" readonly class="form-control"/>
											</div>

										</div>
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Penalty Amount to be Deduct</label>
											</div>
											<div class="col-md-7">
												<input type="text" id="penaltyAmount" maxlength="13" onkeypress="return isNumberKey(event)" onchange="checkAmountValidation()" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"  name="penaltyAmount" class="form-control" readonly/>
											</div>

										</div>
									</div>
								
                                  </div>
										
									
								<div class="row" >
										<div class="col-lg-4 col-sm-6">
										<div class="form-group row">
											<div class="col-md-5">
												<label class="col-form-label">Remarks</label>
											</div>
											<div class="col-md-7">
												<div class="dateHolder">
													<textarea name="remarks"   style="width:600px; height:100px;" maxlength="1000" class="form-control border-input
														validate="referralNote,string,no" id="remarks"
														cols="0" rows="0" tabindex="5"></textarea>
												</div>
											</div>
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
																		<th>Add</th>
																		<th>Delete</th>
																	</tr>
																</thead>
																
																<tbody id="caseSheetDocs">
																	<tr>
																													
																		<td class="width500" class="height500">
																		    <textarea name="caseSheet" id="caseSheet" class="form-control"></textarea>
																		</td>
																		<td>																		
																			<div class="fileUploadDiv">
																				<input type="file" name="caseSheetUpload" value="" id="caseSheetUpload" class="inputUpload">
																				<label class="inputUploadlabel">Choose File</label>
																				<span class="inputUploadFileName">No File Chosen</span>
																			</div>
																		</td>
																		<td>
                                                                            <button type="button" class="btn btn-primary buttonAdd noMinWidth" value="" button-type="add" tabindex="1" onclick="addNoteSheetDocs()"></button>
                                                                        </td>
                                                                         <td>
                                                                               <button type="button" class="btn btn-danger buttonAdd noMinWidth"  name="deleteForSupportDocNew" value=""    id="deleteForSupportDocNew"  button-type="delete" tabindex="1" onclick="deleteRow(this)"></button>
                                                                        </td>
																	</tr>
																</tbody>
															</table>
														</div>
                                    </form>
									<div class="row">
                                	<div class="col-12 m-t-10 text-right">
                                	<button type="button" id="captureAuditDataSubmit" value="submit" onclick="submitAuditorForm()" class="btn btn-primary">Submit</button>
                               		<button type="button" class="btn btn-primary" onclick="backFunction()" id="backBtn">Back</button>
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