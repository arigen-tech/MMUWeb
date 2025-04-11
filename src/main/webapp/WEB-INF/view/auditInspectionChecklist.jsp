<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

 <%@include file="..//view/leftMenu.jsp" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MMU</title>
    <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
    <meta content="Coderthemes" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

<%@include file="..//view/commonJavaScript.jsp" %>

<script type="text/javascript">
    var page = '<%= request.getParameter("page") %>';
    var subseq_str = ['a', 'b', 'c', 'd', 'e', 'f']
    var tpaMember1Id = '';
    var tpaMember2Id = '';
    $j(document).ready(function(){
        if(page != 'forwarded' && page != 'validated')
            $('#btnSubmit').text('Forward to Sr. Auditor');

        if(page == 'forwarded')$('.internal_Htext').text('Audit Forwarded Inspection Checklist Details');
        else if(page == 'validated'){
            $('.internal_Htext').text('Validated Inspection Checklist Details');
        }
        getFilteredUsers();
        GetCapturedInspectionChecklist();

        $('#generateReport').on('click', function(){
            var insDt = $('#inspectionDate').val();
            var mmuId = $('#mmuName').attr('data-mmu-id');
            var printInspectionReport='${pageContext.request.contextPath}/report/printInspectionReport?campDate='+insDt+'&mmuId='+mmuId;
            openPdfModel(printInspectionReport);
        });

        $('#upsertRaiseQuery').on('click', function(){
            if(!$('#auditorRemarks').val()){
                alert('Please enter Auditor`s Remarks!');
                return false;
            }
            if(!$('#isEvidenceRequired').val()){
                alert('Please select Evidence Required!');
                return false;
            }
            var params = {
                "inspectionDetailId": $(this).data('detail-id'),
                "captureInspectionChecklistId": $(this).data('capture-checklist-id'),
                "inspectionChecklistId": $(this).data('checklist-id'),
                "auditStatus": "Q",
                "auditorsRemarks": $('#auditorRemarks').val(),
                "isEvidenceFileRequired": $('#isEvidenceRequired').val()
            };
            var url = 'addInspectionChecklistValidationHistory';
            if($(this).text() == 'Update' && $('#raiseQueryHistoryId').val()){
                url = 'updateInspectionQueryRaisedHistory';
                params['historyId'] = $('#raiseQueryHistoryId').val();
            }
            $(this).attr('disabled', true);
            jQuery.ajax({
                crossOrigin: true,
                method: "POST",
                crossDomain:true,
                url: url,
                data: JSON.stringify(params),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(result){
                    $('#queryRaisedList').empty();
                    LoadQueryRaisedList(result.data, 'L');
                    $('#auditorRemarks').val('').attr('readonly', true);
                    $('#isEvidenceRequired').val('').attr('readonly', true);
                    $('#upsertRaiseQuery').removeAttr('data-history-id').attr('disabled', true)
                }
            });
        });

        $('#back').on('click', function(){
            if(page == 'forwarded')
               window.location = 'getAllForwardedInspectionList';
            else if(page == 'validated')
               window.location = 'getValidatedInspectionList';
            else window.location = 'getAllCapturedInspectionList';
        });

        $('#closePopup,.close').on('click', function(){
            $('#raiseQueryModal').hide();
            $('.modal-backdrop').hide();
        });

        $('#closeAndRefreshPopup').on('click', function(){
            $('#raiseQueryModal').hide();
            $('.modal-backdrop').hide();
            location.reload();
        });

        function getFilteredUsers(){
            var params = {
                "userTypeName":'Auditor',
                "PN": 0
            }

            $.ajax({
                type : "POST",
                contentType : "application/json",
                url : '${pageContext.request.contextPath}/audit/getFilteredUsers',
                data : JSON.stringify(params),
                dataType : "json",
                cache : false,
                success : function(result) {
                    if(result && result.data){
                        for(var i=0;i<result.data.length;i++){
                            $('#tpaMember1Id').append($('<option/>').val(result.data[i].userId).text(result.data[i].userName));
                            $('#tpaMember2Id').append($('<option/>').val(result.data[i].userId).text(result.data[i].userName));
                        }

                        if(tpaMember1Id)
                            $('#tpaMember1Id').val(tpaMember1Id).attr('disabled', true);

                        if(tpaMember2Id)
                           $('#tpaMember2Id').val(tpaMember2Id).attr('disabled', true);
                    }
                },
                error : function(data) {
                    alert("An error has occurred while contacting the server");
                }
            });
        }

        $('#btnSubmit').on('click', function(){
             var captureChecklistIds = [];
             var status = [];
             var checked_flag = true;
             $('input[type="radio"]').each(function(){
                   if($(this).is(':checked'))
                        status.push($(this).val());
                   else {
                       status.push('');
                       checked_flag = false;
                   }
                   captureChecklistIds.push($(this).data('capture-checklist-id'));
             });

             if(!checked_flag){
                alert('Please select all radio buttons to submit the form!');
                return false;
             }

             var createIncidents = [];
             $('input[type="checkbox"]').each(function(){
                 if($(this).is(':checked')){
                     createIncidents.push('Y');
                 } else {
                     createIncidents.push('N');
                 }
             });
             var finalRemarks = $('#finalRemarks').val();
             if(page == 'forwarded'){
                finalRemarks = $('#srAuditorFinalRemarks').val();
             }
             if(!finalRemarks){
                 alert('Please enter Final Remarks!');
                 return false;
             }

             if(confirm('Are you sure, you want to submit the form?')){
                 $('#loaderId').show();
                 $('button').attr('disabled', true);
                 var params = {'captureChecklistIds': captureChecklistIds, 'createIncidents': createIncidents, 'auditStatus': status, 'inspectionDetailId': $('#detailId').val()};
                 if(page == 'forwarded'){
                     params['srAuditorFinalRemarks'] = finalRemarks;
                 } else {
                     params['finalRemarks'] = finalRemarks;
                 }

                 jQuery.ajax({
                     crossOrigin: true,
                     method: "POST",
                     crossDomain:true,
                     url: 'updateInspectionChecklistAuditStatus',
                     data: JSON.stringify(params),
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function(result){
                         $('#loaderId').hide();
                         //if(alert('Form submitted successfully!'))
                        	 alert('Form submitted successfully!'+'S');
                            location.reload();
                     }
                 });
             }
        });
    });

    function LoadQueryRaisedList(data, action){
        if(data && data.length > 0){
            var insertFlag = true;
            for(var i=0;i<data.length;i++){
                var rowData = data[i];
                var tr_attr = {
                    'align': 'left',
                    'data-remarks': data[i].auditorRemarks,
                    'data-evidence-required': data[i].isEvidenceFileRequired,
                    'data-history-id': data[i].historyId,
                    'data-audit-status': data[i].auditStatus,
                    'data-response': data[i].response,
                    'data-response-filename': data[i].filename
                };
                var $tr = $('<tr/>').attr(tr_attr);
                var $td1 = $('<td/>').text(data[i].auditorRemarks);

                var isEvidenceReq = '';
                if(data[i].isEvidenceFileRequired == 'N')
                    isEvidenceReq = 'NO';
                else if(data[i].isEvidenceFileRequired == 'Y')
                    isEvidenceReq = 'YES';
                var $td2 = $('<td/>').text(isEvidenceReq);

                var $td3 = $('<td/>').text(data[i].queryDate);
                var $td4 = $('<td/>').text(data[i].queriedBy);
                var $td5 = $('<td/>').text(data[i].response);
                var $td6 = $('<td/>').text(data[i].responseDate);
                var $td7 = $('<td/>').text(data[i].respondedBy);
                var keys = rowData.inspectionDetailId+','+rowData.captureInspectionChecklistId+','+rowData.inspectionChecklistId+','+rowData.historyId
                var url = '#';
                var fontColor = 'grey';
                if(rowData.fileName) {
                    fontColor = 'green';
                    url = 'download?keys='+keys+'&name='+rowData.fileName+'&type=inspection';
                }
                var downloadIcon = $('<i class="fa fa-download" style="font-size:large;color:'+fontColor+'" aria-hidden="true"></i>').on('mouseover', function(){
                    if($(this).attr('style').indexOf('green') < 0){
                        $(this).css('cursor', 'no-drop');
                    }
                });
                var $td8 = $('<td/>', {'align': 'center'}).append($('<a/>',{'href': url,'target':'_blank'}).append(downloadIcon));

                var status = '';
                if(data[i].auditStatus == 'Q'){
                    status = 'Query Raised';
                    insertFlag = false;
                }else if(data[i].auditStatus == 'R')
                    status = 'Responded';
                var $td9 = $('<td/>').text(status);

                $tr.append($td1).append($td2).append($td3).append($td4).append($td5).append($td6).append($td7).append($td8).append($td9).on('click', function(){
                    if($(this).data('audit-status') == 'Q' && action == 'Q'){
                        $('#auditorRemarks').val($(this).data('remarks')).attr('readonly', false);
                        $('#isEvidenceRequired').val($(this).data('evidence-required')).attr('disabled', false);
                        $('#raiseQueryHistoryId').val($(this).data('history-id'));
                        $('#upsertRaiseQuery').attr('disabled', false).text('Update');
                    } else if(action == 'R'){
                        $('#response').val($(this).data('response')).attr('readonly', false);
                        $('#updateResponseQuery').attr('disabled', false);
                        $('#responseQueryHistoryId').val($(this).data('history-id'));
                    }
                });
                $('#queryRaisedList').append($tr);
            }
            if(!insertFlag){
                $('#auditorRemarks').val('').attr('readonly', true);
                $('#isEvidenceRequired').val('').attr('disabled', true);
                $('#upsertRaiseQuery').attr('disabled', true);
            }
        }
    }

    function GetCapturedInspectionChecklist(){
        jQuery.ajax({
            crossOrigin: true,
            method: "POST",
            crossDomain:true,
            url: "inspectionChecklistDataForAudit",
            data: JSON.stringify({"PN" : "0"}),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(result){
                //alert(JSON.stringify(result));
                var inspectionDetailData = result.data[0].inspectionDetailData;
                $('#city').val(inspectionDetailData.cityName);
                $('#mmuName').val(inspectionDetailData.mmuName).attr('data-mmu-id', inspectionDetailData.mmuId);
                $('#inspectionDate').val(inspectionDetailData.inspectionDate);
                $('#vehicleRegNo').val(inspectionDetailData.vehicleRegNo);
                $('#mmuLocation').val(inspectionDetailData.mmuLocation);
                $('#apmName').val(inspectionDetailData.apmName);
                $('#doctorName').val(inspectionDetailData.doctorName);
                $('#doctorRegNo').val(inspectionDetailData.doctorRegNo);
                //$('#commissionerName').val(inspectionDetailData.commissionerName);
                $('#nodalOfficerName').val(inspectionDetailData.nodalOfficerName);
                $('#finalRemarks').val(inspectionDetailData.finalAuditRemarks);
                tpaMember2Id = inspectionDetailData.tpaMember2Id;
                tpaMember1Id = inspectionDetailData.tpaMember1Id;
                if(!$('#tpaMember1Id').val()){
                   $('#tpaMember1Id').val(inspectionDetailData.tpaMember1Id).attr('disabled', true);
                }
                if(!$('#tpaMember2Id').val()){
                    $('#tpaMember2Id').val(inspectionDetailData.tpaMember2Id).attr('disabled', true);
                }
                if(inspectionDetailData.srAuditorRemarks || page == 'forwarded'){
                    $('#srAuditorFinalRemarks').val(inspectionDetailData.srAuditorRemarks);
                    $('#srAuditorRemarksLabel').show();
                    $('#srAuditorRemarksField').show();
                }
                if(inspectionDetailData.auditStatus == 'F' && page == 'forwarded'){
                    $('#finalRemarks').attr('readonly', true);
                    $('#srAuditorFinalRemarks').attr('readonly', false);
                } else if((inspectionDetailData.auditStatus == 'F' && page != 'forwarded') || inspectionDetailData.auditStatus == 'V'){
                     $('#finalRemarks').attr('readonly', true);
                     $('#srAuditorFinalRemarks').attr('readonly', true);
                } else {
                    $('#finalRemarks').attr('readonly', false);
                    $('#srAuditorFinalRemarks').attr('readonly', true);
                }

                $('#detailId').val(inspectionDetailData.inspectionDetailId);
                if(((page == 'forwarded' || page == 'validated') && inspectionDetailData.auditStatus == 'V')
                    || (page == 'null' && (inspectionDetailData.auditStatus == 'F' || inspectionDetailData.auditStatus == 'V'))
                    || inspectionDetailData.auditStatus == 'Q'){
                    $('#btnSubmit').attr('disabled', true);
                } else $('#btnSubmit').attr('disabled', false);

                var inspectionChecklistData = result.data[0].inspectionChecklistData;
                if(inspectionChecklistData.length > 0){
                    for(var i=0;i<inspectionChecklistData.length;i++){
                         var rowData = inspectionChecklistData[i];
                        var $tr = $('<tr/>');
                        var subsequence = '';
                        if(rowData.subsequence){
                            subsequence = '('+subseq_str[parseInt(rowData.subsequence)-1]+')';
                        }
                        var sequenceNo = rowData.sequenceNo+subsequence;
                        var $td1 = $('<td/>').text(sequenceNo)
                        var $td2 = $('<td/>').text(rowData.checklistName)

                        var $td3 = $('<td/>')
                        if(rowData.typeOfInput == 'DROPDOWN'){
                            var $textfield = $('<input/>', {'readonly': true, 'class': 'form-control'}).val(rowData.inputValue);
                            $td3 = $td3.append($textfield);
                        } else {
                            var $textarea = $('<textarea/>').attr({'readonly': true, 'class': 'form-control'}).val(rowData.inputValue);
                            $td3 = $td3.append($textarea);
                        }

                        var createIncident = false;
                        if(rowData.inputValue == 'NO' || rowData.createIncident == 'Y')
                            createIncident = true;

                        var $td4 = $('<td/>').append($('<input/>', {'type': 'checkbox', 'checked': createIncident, 'name': 'createIncident'}));

                        var $td5 = $('<td/>').append($('<textarea/>').attr({'readonly': true, 'name': 'remarks', 'class': 'form-control'}).val(rowData.remarks));
                        var status = '';
                        var validatedRadioFlag = false;
                        var queryRadioFlag = false;
                        var respondedRadioFlag = false;
                        if(!rowData.auditStatus || rowData.auditStatus == 'P'){
                            validatedRadioFlag = true;
                            status = 'PENDING FOR VALIDATION';
                        } else if(rowData.auditStatus == 'Q'){
                            queryRadioFlag = true;
                            status = 'QUERY RAISED';
                        }else if(rowData.auditStatus == 'R'){
                            respondedRadioFlag = true;
                             status = 'RESPONDED';
                        }else if(rowData.auditStatus == 'V'){
                             validatedRadioFlag = true;
                             status = 'VALIDATED';
                        } else if(rowData.auditStatus == 'T')
                             status = 'PARTIALLY RESPONDED';
                        else if(rowData.auditStatus == 'S')
                             status = 'SAVED';
                        else if(rowData.auditStatus == 'F'){
                             validatedRadioFlag = true;
                             status = 'FORWARDED TO SENIOR AUDITOR';
                        }

                        var $td6 = $('<td/>').text(status);

                        var raiseQueryAttr = {
                            'name': 'validateRadio'+i,
                            'type': 'radio',
                            'data-sequence-no': sequenceNo,
                            'data-checklist-name': rowData.checklistName,
                            'data-detail-id': inspectionDetailData.inspectionDetailId,
                            'data-capture-checklist-id': rowData.captureInspectionChecklistId,
                            'data-checklist-id': rowData.inspectionChecklistId,
                            'data-status': rowData.auditStatus,
                        };
                        var radioValue = 'F';
                        if(page == 'forwarded')
                            radioValue = 'V';
                        var $td7 = $('<td/>').attr('align', 'center').append($('<input/>').attr({'checked': validatedRadioFlag, 'value': radioValue}).attr(raiseQueryAttr).on('click', function(){
                            if($(this).data('status') == 'V' || $(this).data('status') == 'R' || $(this).data('status') == 'F'){
                                return true;
                            }else{
                                return false;
                            }
                        }));

                        var insDateArre = inspectionDetailData.inspectionDate.split('/');
                        var keys = inspectionDetailData.mmuLocation+','+insDateArre[0]+','+insDateArre[1]+','+insDateArre[2]+','+rowData.inspectionChecklistId;
                        var url = '#';
                        var fontColor = 'grey';
                        if(rowData.uploadedFile){
                           url = 'download?keys='+keys+'&name='+rowData.uploadedFile+'&type=ci';
                           fontColor = 'green';
                        }
                        var downloadIcon = $('<i class="fa fa-download" style="font-size:large;color:'+fontColor+'" aria-hidden="true"></i>').on('mouseover', function(){
                            if($(this).attr('style').indexOf('green') < 0){
                                $(this).css('cursor', 'no-drop');
                            }
                        });
                        var $td8 = $('<td/>').attr('align', 'center').append($('<a/>', {'href': url,'target':'_blank'}).append(downloadIcon))

                        /* In future if required Raise Query feature, needs to uncomment this section
                        var raiseLinkName = 'Raise Query';
                        if(page == 'forwarded') raiseLinkName = 'View';
                        var $td9 = $('<td/>').append($('<a/>').attr({'href': '#', 'value': 'Q'}).attr(raiseQueryAttr).text(raiseLinkName).css('color', 'blue').on('click', function(){
                            if($(this).data('status') == 'V'){
                                return false;
                            } else{
                               $('#raiseQueryForm').show();
                               $('#responseQueryForm').hide();
                               $('#queryRaisedList').empty();
                               $('#auditorRemarks').val($(this).data('remarks')).attr('readonly', false);
                               $('#isEvidenceRequired').val('').attr('disabled', false);
                               var disable_flag = false;
                               if(inspectionDetailData.auditStatus == 'F')
                                    disable_flag = true;
                               $('#upsertRaiseQuery').attr('disabled', disable_flag).removeAttr('data-history-id').text('Raise Query');
                               $('#closeAndRefreshPopup').attr('disabled', disable_flag);

                               $('#raiseQueryModal').show();
                               $('.modal-backdrop').show();
                               //$('#raiseQueryModal .modal-body').load("showPreveiousVisit?patientId="+$('#patientId').val());
                               $('#raiseQueryModal .modal-title').text('Raise Query Against Sequence No. '+$(this).data('sequence-no'));
                               $('#checklistNameForRaiseQuery').text($(this).data('checklist-name'));
                               var raiseQueryBtnAttr = {
                                   'data-detail-id': $(this).data('detail-id'),
                                   'data-capture-checklist-id': $(this).data('capture-checklist-id'),
                                   'data-checklist-id': $(this).data('checklist-id')
                               }
                               $('#upsertRaiseQuery').attr(raiseQueryBtnAttr);
                               var paramsL = {
                                    "PN": 0,
                                   "inspectionDetailId": $(this).data('detail-id'),
                                   "captureInspectionChecklistId": $(this).data('capture-checklist-id'),
                                   "inspectionChecklistId": $(this).data('checklist-id'),
                               };
                               jQuery.ajax({
                                   crossOrigin: true,
                                   method: "POST",
                                   crossDomain:true,
                                   url: "getAllInspectionChecklistValidationHistory",
                                   data: JSON.stringify(paramsL),
                                   contentType: "application/json; charset=utf-8",
                                   dataType: "json",
                                   success: function(result){
                                       LoadQueryRaisedList(result.data, 'Q');
                                   }
                               });
                            }

                       }));*/

                        $tr = $tr.append($td1).append($td2).append($td3).append($td4).append($td5).append($td6).append($td7).append($td8);
                        $('#inspectionChecklist').append($tr);
                    }
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
            <div class="">
                <div class="container-fluid">
                <div class="internal_Htext">Audit Captured Inspection Details</div>

                    <!-- end row -->

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">

                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="addInstrumentForm" name="addInstrumentForm" method="">
                                                <input type="hidden" id="detailId" value=""/>
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Instrument Code" class=" col-form-label inner_md_htext" >City<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" readonly="true" class="form-control" id="city" name="city" placeholder="City">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">MMU Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" readonly="true" class="form-control" id="mmuName" name="mmuName" placeholder="MMU Name">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Date of Inspection<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" readonly="true" name="inspectionDate" id="inspectionDate" class="form-control" placeholder="DD/MM/YYYY" />
                                                            </div>
                                                        </div>
                                                    </div>

                                                 <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Vehicle Registration No.<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" readonly="true" class="form-control" id="vehicleRegNo" name="vehicleRegNo" placeholder="Vehicle Registration No.">
														    </div>
                                                      </div>
                                                 </div>

                                                 <div class="col-md-4">
                                                         <div class="form-group row">
                                                             <div class="col-sm-5">
                                                             <label for="collection name" class="col-form-label inner_md_htext">MMU Location<span class="mandate"><sup>&#9733;</sup></span></label>
                                                             </div>
                                                             <div class="col-sm-7">
                                                                 <input type="text" readonly="true" class="form-control" id="mmuLocation" name="mmuLocation" placeholder="MMU Location">
                                                            </div>
                                                       </div>
                                                  </div>

                                                  <div class="col-md-4">
                                                       <div class="form-group row">
                                                           <div class="col-sm-5">
                                                           <label for="collection name" class="col-form-label inner_md_htext">APM Name</label>
                                                           </div>
                                                           <div class="col-sm-7">
                                                               <input type="text" readonly="true" class="form-control" id="apmName" name="apmName" placeholder="APM Name">
                                                          </div>
                                                     </div>
                                                </div>

                                                <div class="col-md-4" style="margin-top:-20px">
                                                       <div class="form-group row">
                                                           <div class="col-sm-5">
                                                           <label for="collection name" class="col-form-label inner_md_htext">Doctor Name</label>
                                                           </div>
                                                           <div class="col-sm-7">
                                                               <input type="text" readonly="true" class="form-control" id="doctorName" name="doctorName" placeholder="Doctor Name">
                                                          </div>
                                                     </div>
                                                </div>

                                                <div class="col-md-4" style="margin-top:-20px">
                                                       <div class="form-group row">
                                                           <div class="col-sm-5">
                                                           <label for="collection name" class="col-form-label inner_md_htext">Doctor Reg. No.</label>
                                                           </div>
                                                           <div class="col-sm-7">
                                                               <input type="text" readonly="true" class="form-control" id="doctorRegNo" name="doctorRegNo" placeholder="Doctor Registration No">
                                                          </div>
                                                     </div>
                                                </div>

                                               <div class="col-md-4" style="margin-top:-20px">
                                                <div class="form-group row">
                                                           <div class="col-sm-5">
                                                           <label for="collection name" class="col-form-label inner_md_htext">Nodal Officer Name</label>
                                                           </div>
                                                           <div class="col-sm-7">
                                                               <input type="text" readonly="true" class="form-control" id="nodalOfficerName" name="nodalOfficerName" placeholder="Nodal Officer Name">
                                                          </div>
                                                     </div>
                                                      <!--  <div class="form-group row">
                                                           <div class="col-sm-5">
                                                           <label for="collection name" class="col-form-label inner_md_htext">Commissioner Name</label>
                                                           </div>
                                                           <div class="col-sm-7">
                                                               <input type="text" readonly="true" class="form-control" id="commissionerName" name="commissionerName" placeholder="Commissioner Name">
                                                          </div>
                                                     </div> -->
                                                </div>

                                             <!--    <div class="col-md-4" style="margin-top:0px">
                                                       <div class="form-group row">
                                                           <div class="col-sm-5">
                                                           <label for="collection name" class="col-form-label inner_md_htext">Nodal Officer Name</label>
                                                           </div>
                                                           <div class="col-sm-7">
                                                               <input type="text" readonly="true" class="form-control" id="nodalOfficerName" name="nodalOfficerName" placeholder="Nodal Officer Name">
                                                          </div>
                                                     </div>
                                                </div> -->

                                                <div class="col-md-4" style="margin-top:0px">
                                                   <div class="form-group row">
                                                       <div class="col-sm-5">
                                                       <label for="collection name" class="col-form-label inner_md_htext">TPA Member 1</label>
                                                       </div>
                                                       <div class="col-sm-7">
                                                           <select class="form-control" id="tpaMember1Id" name="tpaMember1Id" >
                                                              <option value="">--Select--</option>
                                                           </select>
                                                      </div>
                                                 </div>
                                            </div>

                                            <div class="col-md-4" style="margin-top:0px">
                                                 <div class="form-group row">
                                                     <div class="col-sm-5">
                                                     <label for="collection name" class="col-form-label inner_md_htext">TPA Member 2</label>
                                                     </div>
                                                     <div class="col-sm-7">
                                                         <select class="form-control" id="tpaMember2Id" name="tpaMember2Id" >
                                                           <option value="">--Select--</option>
                                                        </select>
                                                    </div>
                                               </div>
                                          </div>

                                                    <div class="col-md-4">
										<input type="hidden"  id="rowId" name="rowId">

							            </div>

                                                </div>
                                            </form>
                                        </div>

                                    </div>
                                    <b style="color:green;font-size:12px;display:none" id="loaderId"><i class="fa fa-spinner fa-spin"></i> Please wait while submitting the form...</b>
         							<br>
         							<table class="table table-striped table-hover table-bordered">
                                            <thead class="bg-success" style="color:#fff;">
                                                <tr>
                                                    <th id="th1" class ="inner_md_htext">Sequence No.</th>
                                                    <th id="th2" class ="inner_md_htext">Checklist</th>
                                                    <th id="th3" class ="inner_md_htext">Input</th>
                                                    <th id="th3" class ="inner_md_htext">Create Incident</th>
                                                    <th id="th4" class ="inner_md_htext">Remarks</th>
                                                    <th id="th4" class ="inner_md_htext">Status</th>
                                                    <th id="th2" class ="inner_md_htext">Validate</th>
                                                    <th id="th2" class ="inner_md_htext">Download</th>
                                                    <!--<th id="th2" class ="inner_md_htext">Raise Query</th>-->
                                                </tr>
                                            </thead>

                                         <tbody class="clickableRow" id="inspectionChecklist">

                                         </tbody>
                                        </table>

                                    <div class="col-md-12">
                                        <div class="form-group row">
                                            <div class="col-sm-2">
                                            <label for="collection name" class="col-form-label inner_md_htext">Auditor's Final Remarks<span class="mandate"><sup>&#9733;</sup></span></label>
                                            </div>
                                            <div class="col-sm-4">
                                                <textarea class="form-control" id="finalRemarks" name="finalRemarks" placeholder="Final Remarks"></textarea>
                                            </div>

                                            <div class="col-sm-2" style="display: none" id="srAuditorRemarksLabel">
                                            <label for="collection name" class="col-form-label inner_md_htext">Sr. Auditor's Final Remarks<span class="mandate"><sup>&#9733;</sup></span></label>
                                            </div>
                                            <div class="col-sm-4" id="srAuditorRemarksField" style="display: none">
                                                <textarea class="form-control" id="srAuditorFinalRemarks" name="srAuditorFinalRemarks" placeholder="Final Remarks"></textarea>
                                            </div>
                                      </div><br>
                                 </div>
									<div class="row">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">

														<button type="button" id="btnSubmit" class="btn  btn-primary ">Submit</button>
														<button type="button" id="generateReport" class="btn btn-primary ">Generate Report</button>
														<button type="button" id="back" class="btn btn-danger">Back</button>

											</div>
										</div>
									</div>


                                    <!-- end row -->

                                </div>
                            </div>
                            <!-- end card -->
                        </div>
                        <!-- end col -->
                    </div>
                    <!-- end row -->
                    <!-- end row -->

                </div>
                <!-- container -->

            </div>
            <!-- content -->

        </div>

        <!-- ============================================================== -->
        <!-- End Right content here -->
        <!-- ============================================================== -->

    </div>
    <!-- END wrapper -->

    <!-- jQuery  -->

<div class="modal" id="raiseQueryModal" tabindex="-1" role="dialog" aria-labelledby="raiseQueryModalLabel">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title font-weight-bold"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="text-center text-theme text-sm">
         <div class="row">
            <div class="col-md-12">
                <div class="form-group row">
                    <input type="hidden" name="raiseQueryHistoryId" id="raiseQueryHistoryId"/>
                    <input type="hidden" name="responseQueryHistoryId" id="responseQueryHistoryId"/>
                    <table id="raiseQueryForm" class="table table-striped table-hover table-bordered" style="display: none">
                     <thead class="bg-success" style="color:#fff;">
                         <tr>
                             <th id="th2" class ="inner_md_htext">Checklist</th>
                             <th id="th3" class ="inner_md_htext">Auditor`s Remarks</th>
                             <th id="th4" class ="inner_md_htext">Evidence Required</th>
                             <th id="th2" class ="inner_md_htext">#</th>
                         </tr>
                     </thead>
                     <tbody id="raiseQuery">
                        <tr>
                            <td id="checklistNameForRaiseQuery" width="500" align="left"></td>
                            <td width="200"><textarea class="form-control" id="auditorRemarks" style="width: 200px"></textarea></td>
                            <td>
                                <select class="form-control" id="isEvidenceRequired">
                                    <option value="">--Select--</option>
                                    <option value="Y">YES</option>
                                    <option value="N">NO</option>
                                </select>
                            </td>
                            <td width="130"><button type='button' id="upsertRaiseQuery" class='btn  btn-primary'>Raise Query</button></td>
                        </tr>
                     </tbody>
                   </table>
                </div>
            </div>
         </div>

         <table class="table table-striped table-hover table-bordered">
             <thead class="bg-success" style="color:#fff;">
                 <tr>
                     <th id="th4" class ="inner_md_htext">Auditor`s Remarks</th>
                     <th id="th4" class ="inner_md_htext">Evidence Required</th>
                     <th id="th4" class ="inner_md_htext">Query Date</th>
                     <th id="th4" class ="inner_md_htext">Query Raised By</th>
                     <th id="th4" class ="inner_md_htext">Response</th>
                     <th id="th4" class ="inner_md_htext">Response Date</th>
                     <th id="th4" class ="inner_md_htext">Responded By</th>
                     <th id="th2" class ="inner_md_htext">Download Evidence</th>
                     <th id="th2" class ="inner_md_htext">Status</th>
                 </tr>
             </thead>

          <tbody class="clickableRow" id="queryRaisedList">

          </tbody>
         </table>
        </div>
      </div>
       <div class="modal-footer">
        <button	type="reset" name="Reset" id="closeAndRefreshPopup" value="" class="button btn btn-primary btn-right-all" data-dismiss="modal" accesskey="r">Update & Close</button>
         <button	type="reset" name="Reset" id="closePopup" value="" class="button btn btn-primary btn-right-all" data-dismiss="modal" accesskey="r">Close</button>
       </div>
    </div>
  </div>
</div>
</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>

