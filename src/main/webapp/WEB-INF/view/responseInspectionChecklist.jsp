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
    var subseq_str = ['a', 'b', 'c', 'd', 'e', 'f']
    $j(document).ready(function(){
        GetCapturedInspectionChecklist();

        $('#generateReport').on('click', function(){
            var insDt = $('#inspectionDate').val();
            var mmuId = $('#mmuName').attr('data-mmu-id');
            var printInspectionReport='${pageContext.request.contextPath}/report/printInspectionReport?campDate='+insDt+'&mmuId='+mmuId;
            openPdfModel(printInspectionReport);
        });

        $('#updateResponseQuery').on('click', function(){

            if(!$('#response').val()){
                alert('Please enter Response!');
                return false;
            }
            if($(this).data('is-evidence-required') == 'Y' && !$('#fileName').val()){
                alert('Please Upload Evidence File!');
                return false;
            }

            if($('#fileName').val()
                && $('#fileName').val().indexOf('.pdf') == -1
                && $('#fileName').val().indexOf('.doc') == -1
                && $('#fileName').val().indexOf('.docx') == -1
                && $('#fileName').val().indexOf('.xls') == -1
                && $('#fileName').val().indexOf('.xlsx') == -1
                && $('#fileName').val().indexOf('.ppt') == -1
                && $('#fileName').val().indexOf('.mp4') == -1
                && $('#fileName').val().indexOf('.jpg') == -1
                && $('#fileName').val().indexOf('.jpeg') == -1
                && $('#fileName').val().indexOf('.png') == -1){
                alert('Invalid file format!');
                return false;
            }

            $(this).attr('disabled', true);
            var formData = new FormData(document.getElementById("uploadEvidenceForm"));
            formData.append('inspectionDetailId', $(this).data('detail-id'));
            formData.append('captureInspectionChecklistId', $(this).data('capture-checklist-id'));
            formData.append('inspectionChecklistId', $(this).data('checklist-id'));
            formData.append('auditStatus', 'R');
            formData.append('response', $('#response').val());
            formData.append('fileName', $('#fileName').val());
            formData.append('historyId', $('#responseQueryHistoryId').val());

            jQuery.ajax({
                crossOrigin: true,
                method: "POST",
                crossDomain:true,
                url: 'updateInspectionChecklistValidationHistory',
                data: formData,
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                dataType: "json",
                success: function(result){
                    $('#queryRaisedList').empty();
                    LoadQueryRaisedList(result.data, 'L');
                    $('#response').val('').attr('readonly', true);
                    $('#updateResponseQuery').removeAttr('data-history-id').attr('disabled', true);
                    $('#fileName').val('');
                }
            });
        });

        $('#back').on('click', function(){
            window.location = 'getAllCapturedQueriedInspectionList';
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

        $('#btnSubmit').on('click', function(){
             var captureChecklistIds = [];
             var status = [];
             $('input[type="radio"]:checked').each(function(){
                   status.push($(this).val());
                   captureChecklistIds.push($(this).data('capture-checklist-id'));
             });

             var createIncidents = [];
             $('input[type="checkbox"]').each(function(){
                 if($(this).is(':checked')){
                     createIncidents.push('Y');
                 } else {
                     createIncidents.push('N');
                 }
             });
             var params = {'captureChecklistIds': captureChecklistIds, 'createIncidents': createIncidents, 'auditStatus': status, 'inspectionDetailId': $('#detailId').val()};
             jQuery.ajax({
                 crossOrigin: true,
                 method: "POST",
                 crossDomain:true,
                 url: 'updateInspectionChecklistAuditStatus',
                 data: JSON.stringify(params),
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function(result){
                     location.reload();
                 }
             });
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
                var $td8 = $('<td/>', {'align': 'center'}).append($('<a/>',{'href': url}).append(downloadIcon));

                var status = '';
                if(data[i].auditStatus == 'Q'){
                    status = 'Query Raised';
                    insertFlag = false;
                }else if(data[i].auditStatus == 'R')
                    status = 'Responded';
                var $td9 = $('<td/>').text(status);

                $tr.append($td1).append($td2).append($td3).append($td4).append($td5).append($td6).append($td7).append($td8).append($td9).on('click', function(){
                    if($(this).data('audit-status') == 'Q' && action == 'R'){
                        $('#response').val($(this).data('response')).attr('readonly', false);
                        $('#updateResponseQuery').attr('disabled', false).attr('data-is-evidence-required', rowData.isEvidenceFileRequired);
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
            url: "inspectionChecklistDataForResponse",
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
                $('#commissionerName').val(inspectionDetailData.commissionerName);
                $('#nodalOfficerName').val(inspectionDetailData.nodalOfficerName);
                $('#detailId').val(inspectionDetailData.inspectionDetailId);

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

                        var $td4 = $('<td/>').append($('<textarea/>').attr({'readonly': true, 'name': 'remarks', 'class': 'form-control'}).val(rowData.remarks));

                        var status = '';
                        var btnTxt = 'View';
                        if(!rowData.auditStatus || rowData.auditStatus == 'P'){
                            status = 'PENDING FOR VALIDATION';
                        } else if(rowData.auditStatus == 'Q'){
                            btnTxt = 'Respond';
                            status = 'QUERY RAISED';
                        }else if(rowData.auditStatus == 'R'){
                             status = 'RESPONDED';
                        }else if(rowData.auditStatus == 'V'){
                             status = 'VALIDATED';
                        }else if(rowData.auditStatus == 'T'){
                             btnTxt = 'Respond';
                             status = 'PARTIALLY RESPONDED';
                        }else if(rowData.auditStatus == 'S'){
                             status = 'SAVED';
                        }
                        var $td5 = $('<td/>').text(status);

                        var raiseQueryAttr = {
                            'name': 'validateRadio'+i,
                            'class':'btn btn-primary',
                            'type': 'button',
                            'data-sequence-no': sequenceNo,
                            'data-checklist-name': rowData.checklistName,
                            'data-detail-id': inspectionDetailData.inspectionDetailId,
                            'data-capture-checklist-id': rowData.captureInspectionChecklistId,
                            'data-checklist-id': rowData.inspectionChecklistId,
                            'data-status': rowData.auditStatus,
                            'data-value': 'R',
                            'data-is-evidence-required': rowData.isEvidenceFileRequired,
                            'value': btnTxt
                        };

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
                        var $td6 = $('<td/>').attr('align', 'center').append($('<a/>', {'href': url}).append(downloadIcon))

                       var $td7 = $('<td/>').append($('<input/>').attr(raiseQueryAttr).on('click', function(){
                            if($(this).data('status') == 'Q' || $(this).data('status') == 'R' || $(this).data('status') == 'T'){
                              $('#responseQueryForm').show();
                              $('#raiseQueryForm').hide();
                              $('#queryRaisedList').empty();

                              $('#raiseQueryModal').show();
                              $('.modal-backdrop').show();
                              $('#raiseQueryModal .modal-title').text('Respond Raised Query for Inspection Checklist');
                              $('#checklistNameForResponseQuery').text($(this).data('checklist-name'));
                              var responseQueryBtnAttr = {
                                  'data-detail-id': $(this).data('detail-id'),
                                  'data-capture-checklist-id': $(this).data('capture-checklist-id'),
                                  'data-checklist-id': $(this).data('checklist-id'),
                                  'data-is-evidence-required': $(this).data('is-evidence-required')
                              }
                              $('#updateResponseQuery').attr(responseQueryBtnAttr);
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
                                      LoadQueryRaisedList(result.data, 'R');
                                  }
                              });

                            } else if($(this).data('status') == 'V') {
                                alert('Already validated the selected checklist!');
                                return false;
                            } else if($(this).data('status') == 'P') {
                                alert('Query did not raised for the selected checklist!');
                                return false;
                            }
                       }));

                        $tr = $tr.append($td1).append($td2).append($td3).append($td4).append($td5).append($td6).append($td7);
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
                <div class="internal_Htext">Response Queried Inspection Checklist</div>

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
                                                            <label for="Instrument Code" class=" col-form-label inner_md_htext" >City</label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" readonly="true" class="form-control" id="city" name="city" placeholder="City">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">MMU Name</label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" readonly="true" class="form-control" id="mmuName" name="mmuName" placeholder="MMU Name">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Date of Inspection</label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" readonly="true" name="inspectionDate" id="inspectionDate" class="form-control" placeholder="DD/MM/YYYY" />
                                                            </div>
                                                        </div>
                                                    </div>

                                                 <div class="col-md-4">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Vehicle Registration No.</label>
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
                                                         <label for="collection name" class="col-form-label inner_md_htext">Commissioner Name</label>
                                                         </div>
                                                         <div class="col-sm-7">
                                                             <input type="text" readonly="true" class="form-control" id="commissionerName" name="commissionerName" placeholder="Commissioner Name">
                                                        </div>
                                                   </div>
                                              </div>

                                              <div class="col-md-4" style="margin-top:0px">
                                                     <div class="form-group row">
                                                         <div class="col-sm-5">
                                                         <label for="collection name" class="col-form-label inner_md_htext">Nodal Officer Name</label>
                                                         </div>
                                                         <div class="col-sm-7">
                                                             <input type="text" readonly="true" class="form-control" id="nodalOfficerName" name="nodalOfficerName" placeholder="Nodal Officer Name">
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
         							<br>
         							<table class="table table-striped table-hover table-bordered">
                                            <thead class="bg-success" style="color:#fff;">
                                                <tr>
                                                    <th id="th1" class ="inner_md_htext">Sequence No.</th>
                                                    <th id="th2" class ="inner_md_htext">Checklist</th>
                                                    <th id="th3" class ="inner_md_htext">Input</th>
                                                    <th id="th4" class ="inner_md_htext">Remarks</th>
                                                    <th id="th4" class ="inner_md_htext">Status</th>
                                                    <th id="th2" class ="inner_md_htext">Download</th>
                                                    <th id="th2" class ="inner_md_htext">Respond</th>
                                                </tr>
                                            </thead>

                                         <tbody class="clickableRow" id="inspectionChecklist">

                                         </tbody>
                                        </table>
									<div class="row">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
                                                <button type="button" id="generateReport" class="btn  btn-primary ">Generate Report</button>
                                                <button type="button" id="back" class="btn btn-primary">Back</button>
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
                     <table class="table table-striped table-hover table-bordered" id="responseQueryForm" style="display: none">
                          <thead class="bg-success" style="color:#fff;">
                              <tr>
                                  <th id="th2" class ="inner_md_htext">Checklist</th>
                                  <th id="th3" class ="inner_md_htext">Response</th>
                                  <th id="th4" class ="inner_md_htext">Upload Evidence</th>
                                  <th id="th2" class ="inner_md_htext">#</th>
                              </tr>
                          </thead>
                          <tbody id="responseQuery">
                             <tr>
                                 <td id="checklistNameForResponseQuery" width="500" align="left"></td>
                                 <td width="200"><textarea class="form-control" readonly="true" id="response" style="width: 200px"></textarea></td>
                                 <td><form id="uploadEvidenceForm"><input type="file" class="form-control" id="fileName" name="fileName" style="padding: 0rem 0rem;height: 26px"/></form></td>
                                 <td width="160"><button type='button' id="updateResponseQuery" class='btn  btn-primary' disabled>Response Query</button></td>
                             </tr>
                          </tbody>
                 </table>
                </div>
            </div>
         </div>

        <b style="font-size: x-small;margin-left: -940px">Hint: Select a record to respond!</b>
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

