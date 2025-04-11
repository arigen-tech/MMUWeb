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
<%
String userId = "1";
if (session.getAttribute("user_id") != null) {
	userId = session.getAttribute("user_id") + "";
}

String levelOfUser = "1";
if (session.getAttribute("levelOfUser") != null) {
	levelOfUser = session.getAttribute("levelOfUser") + "";
}

String mmuId = "1";
if (session.getAttribute("mmuId") != null) {
	mmuId = session.getAttribute("mmuId") + "";
}
%>
var insDtRe="";
var mmuIdRe=0;
    $j(document).ready(function(){
        onload();
        GetInspectionChecklist();
        getMMUList();
        getFilteredUsers();

        $('#mmuName').on('change', function(){
            if($(this).val()){
                $('#vehicleRegNo').val($('#mmuName option:selected').data('reg-no'));
                setCampLocation();
            }
        });

        
        $('#generateReport').on('click', function(){
              var insDttemp = $('#inspectionDate').val();
              var mmuIdtemp = $('#mmuName').val();
              if(insDttemp!=null && insDttemp!="" && insDttemp!=undefined && mmuIdtemp!=null && mmuIdtemp!="" && mmuIdtemp!=undefined){
            	  insDtRe=insDttemp;
            	  mmuIdRe= mmuIdtemp;
              } 
            var printInspectionReport='${pageContext.request.contextPath}/report/printInspectionReport?campDate='+insDtRe+'&mmuId='+mmuIdRe;
            openPdfModel(printInspectionReport);
        });

        $('#reset').on('click', function(){
            window.location = 'captureInspectionChecklistDetails';
        });

        $('#btnSubmit,#btnSave').on('click', function(){
          var iddd=this.id;
      	   var pMsg='';
             if(iddd=='btnSave')
             {
             	pMsg += 'Are you sure you want to Save the audit form?'
             }
             if(iddd=='btnSubmit')
             {
             	pMsg += 'Are you sure you want to Submit the audit form?'
             }
            var msg = '';
            if(!$('#mmuName').val()){
                msg += 'Please select MMU Name!'
                alert(msg);
                return false;
            }

            var inspectionDate = $('#inspectionDate').val();
            if(!$('#inspectionDate').val()){
                msg += 'Please select Date of Inspection!'
                alert(msg);
                return false;
            }else{
                 var dts = inspectionDate.split('/');
                 var insDts = new Date(dts[2], dts[1]-1, dts[0]);
                 var todaysDate = new Date();
                 var currDate = new Date(todaysDate.getFullYear(), todaysDate.getMonth(), todaysDate.getDate());
                 if(insDts.getTime() > currDate.getTime()){
                     alert('Inspection Date should not be future date!');
                     return false;
                 }
             }

            if(!$('#vehicleRegNo').val()){
                msg += 'Please Enter Vehicle Registration No.!'
                alert(msg);
                return false;
            }
            if(!$('#mmuLocation').val()){
                msg += 'Please Enter MMU Location!'
                alert(msg);
                return false;
            }
            ///////////////////////////////////
            if(!$('#apmName').val()){
                msg += 'Please Enter APM Name!'
                alert(msg);
                return false;
            }
            /* if(!$('#commissionerName').val()){
                msg += 'Please Enter Commissioner Name!'
                alert(msg);
                return false;
            } */
            if(!$('#nodalOfficerName').val()){
                msg += 'Please Enter Nodal Officer Name!'
                alert(msg);
                return false;
            }
            
            if(!$('#tpaMember1Id').val()){
                msg += 'Please select TPA Member 1!'
                alert(msg);
                return false;
            }
            /////////////////////////////////
            
            var comapreTpa=caompareTPAData();
            if(!comapreTpa){
            	return false;
            }
            
            var $remarks = $('[name="remark"]');
            var $incidents = $('[name="createIncident"]');
            var $inspectionChecklistIds = $('[name="inspectionChecklistId"]');

            var createIncidents = [];
            var checklistIds = [];
            var inputValues = [];
            var remarks = [];
            var remarksString="";
            var inspectionChecklistIds = [];
            var isValidData = true;
            $('[name="inputValue"]').each(function(index){
                if(!$(this).val()){
                    alert('Please provide input for sequence no. '+$(this).data('sequence-no'));
                    isValidData = false;
                    return;
                }
                checklistIds.push($(this).data('checklist-id'));
                inputValues.push($(this).val());
               
                //Remove code for comma seperated values for remarks
               /*  if($($remarks[index]).val())
                    remarks.push($($remarks[index]).val());
                else remarks.push('_'); */
                
                //add code for # sepereated remarks 
                 //add code for # sepereated remarks 
                 if ($($remarks[index]).val()) {
                     remarksString += $($remarks[index]).val() + '#';  // Add value and '#' separator
                 } else {
                     remarksString += '_#';  // Add '_' and '#' separator
                 }

               
                if($($incidents[index]).is(':checked'))
                    createIncidents.push('Y');
                else createIncidents.push('N');

                inspectionChecklistIds.push($($incidents[index]).attr('data-inspection-checklist-id'));
            });
            
            remarks.push(remarksString.slice(0, -1));  // Remove last '#' and push

            if(isValidData && confirm(pMsg)){
                $('button').attr('disabled', true);
                $('#submitterId').show();
                var auditStatus = 'P';
                if($(this).attr('id') == 'btnSave')
                    auditStatus = 'S';

                var formData = new FormData(document.getElementById("captureInspectionChecklistDetails"));
                formData.append('cityId', $('#city').val());
                formData.append('mmuId', $('#mmuName').val());
                formData.append('inspectionDate', $('#inspectionDate').val());
                formData.append('vehicleRegNo', $('#vehicleRegNo').val());
                formData.append('mmuLocation', $('#mmuLocation').val());
                formData.append('auditStatus', auditStatus);
                formData.append('inspectionDetailId', $('#inspectionDetailId').val());
                formData.append('checklistIds', checklistIds);
                formData.append('inputValues', inputValues);
                formData.append('remarks', remarks);
                formData.append('createIncidents', createIncidents);
                formData.append('inspectionChecklistIds', inspectionChecklistIds);
                formData.append('apmNames', $('#apmName').val());
                formData.append('doctorNames', $('#doctorName').val());
                formData.append('doctorRegNos', $('#doctorRegNo').val());
                formData.append('commissionerName', '');
                formData.append('nodalOfficerName', $('#nodalOfficerName').val());
                formData.append('tpaMember1Id', $('#tpaMember1Id').val());
                formData.append('tpaMember2Id', $('#tpaMember2Id').val());
                formData.append('campId', $('#campId').val());

                var url = "captureInspectionChecklistDetails";
                SendMultipartData(url,formData,successCallback,$(this));
            }
        })
    });

    function successCallback($elementObj){
        $('button').attr('disabled', false);
        $('#submitterId').hide();
        if($elementObj.attr('id') == 'btnSave')
            validateDuplicate();
        else {
        	insDtRe = $('#inspectionDate').val();
        	mmuIdRe=$('#mmuName').val();
            $('input,select,textarea').val('');
            $('.filename-label').remove();
             
        }
    }

    function setCampLocation(){
        $('#btnSubmit').attr('disabled', false);
        $('#btnSave').attr('disabled', false);
        $('#mmuLocation').val('');
        $('#vehicleRegNo').val('');
        $('#inspectionDetailId').val('');
        $('#apmName').val('');
        $('#doctorName').val('');
        $('#doctorRegNo').val('');
        //$('#commissionerName').val('');
        $('#nodalOfficerName').val('');

        $('#nodalOfficerName').attr('readonly', false);
        $('#apmName').attr('readonly', false);
        //$('#commissionerName').attr('readonly', false);
        
        
        var insDt = $('#inspectionDate').val();
        var insDtArr = insDt.split('/');
        if(insDtArr[0].length == 1){
            insDtArr[0] = '0'+insDtArr[0];
        }
         var insDts = new Date(insDtArr[2], insDtArr[1]-1, insDtArr[0]);
         var todaysDate = new Date();
         var currDate = new Date(todaysDate.getFullYear(), todaysDate.getMonth(), todaysDate.getDate());
         if(insDts.getTime() > currDate.getTime()){
             alert('Inspection Date should not be future date!');
             onload();
             $('#inspectionDate').trigger('change');
             return false;
         }
        jQuery.ajax({
            crossOrigin: true,
            method: "POST",
            crossDomain:true,
            url: "getCampLocation",
            data: JSON.stringify({"PN" : "0", "cityId": $('#city').val(), "mmuId": $('#mmuName').val(), "campDate": insDtArr.join('/')}),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(result){
                if(result.vehicleRegNo){
                    $('#vehicleRegNo').val(result.vehicleRegNo);
                }
                if(result.doctorName){
                    $('#doctorName').val(result.doctorName);
                }
                if(result.doctorRegNo){
                    $('#doctorRegNo').val(result.doctorRegNo);
                }
                if(result.campId)
                    $('#campId').val(result.campId);
                if(result.apmName){
                    //$('#apmName').val(result.apmName);
                }
                if(result && result.data && result.data.length > 0 && result.data[0]){
                    jQuery('#mmuLocation').val(result.data[0]);
                    validateDuplicate();
                } else {
                    alert('Camp is not configured, So you cannot submit the data for selected MMU!');
                    $('#btnSubmit').attr('disabled', true);
                }
            }

        });
    }

    function getMMUList(){
        var params = {
            "levelOfUser":'<%=levelOfUser%>',
            "userId": <%=userId%>
        }

        $.ajax({
            type : "POST",
            contentType : "application/json",
            url : '${pageContext.request.contextPath}/master/getMMUHierarchicalList',
            data : JSON.stringify(params),
            dataType : "json",
            cache : false,
            success : function(result) {
                   var mmuDrop = '';
                   var data=result.mmuListdata;

                   if(data.mmuList.length =='1'){
                       $('#mmuName').attr('disabled', true);
                       for(i=0;i<data.mmuList.length;i++){
                            mmuDrop += '<option data-reg-no="" value='+data.mmuList[i].mmu_id+' selected>'+data.mmuList[i].mmu_name+'</option>';

                        }
                        $j('#mmuName').append(mmuDrop);
                      <%--  document.getElementById('mmuName').value = <%=mmuId%>; --%>
                       setCampLocation();
                   }
                   else{
                    for(i=0;i<data.mmuList.length;i++){
                        mmuDrop += '<option value='+data.mmuList[i].mmu_id+'>'+data.mmuList[i].mmu_name+'</option>';
                    }
                    $j('#mmuName').append(mmuDrop);
                  }
            },
            error : function(data) {
                alert("An error has occurred while contacting the server");
            }
        });
    }

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
                }
            },
            error : function(data) {
                alert("An error has occurred while contacting the server");
            }
        });
    }

    function onload(){
        var dt = new Date();
        var currDate = '';
        if(dt.getDate() < 10)
            currDate += '0'+dt.getDate();
        else currDate += dt.getDate();

        if(dt.getMonth() + 1 < 10)
            currDate += '/0'+(dt.getMonth()+1);
        else currDate += '/'+(dt.getMonth()+1);

        currDate += '/'+dt.getFullYear();

        $('#inspectionDate').val(currDate);
    }

    function validateDuplicate(){
        $('.filename-label').remove();
        $('#btnSubmit').attr('disabled', false);
        var mmuLocation = $('#mmuLocation').val();
        var insDt = $('#inspectionDate').val();
        if(mmuLocation && insDt){
            $('select.input-value').val('YES');
            $('textarea.input-value').val('');
            $('textarea.remarks').val('');
            $('.create-incident').attr('checked', false);
            var params = {
                'PN': 0,
                'mmuLocation': mmuLocation,
                'inspectionDate': insDt
            };
            $.ajax({
                type : "POST",
                contentType : "application/json",
                url : 'validateCapturedDuplicateInspectionDetail',
                data : JSON.stringify(params),
                dataType : "json",
                cache : false,
                success : function(result) {
                    if(result && result.data && result.data.length > 0){
                        $('#inspectionDetailId').val(result.data[0].inspectionDetailData.inspectionDetailId);
                        //$('#commissionerName').val(result.data[0].inspectionDetailData.commissionerName);
                        // Replace the actual value if data is saved in TAble
                        
                        $('#doctorName').val(result.data[0].inspectionDetailData.doctorName);
						$('#doctorRegNo').val(result.data[0].inspectionDetailData.doctorRegNo);
                        
                        $('#nodalOfficerName').val(result.data[0].inspectionDetailData.nodalOfficerName);
                        $('#apmName').val(result.data[0].inspectionDetailData.apmName);
                        $('#tpaMember1Id').val(result.data[0].inspectionDetailData.tpaMember1Id);
                        $('#tpaMember2Id').val(result.data[0].inspectionDetailData.tpaMember2Id);

                        if(result.data[0].inspectionDetailData.auditStatus)
                            $('#generateReport').attr('disabled', false);
                        if(result.data[0].inspectionDetailData.auditStatus != 'S'){
                            $('#apmName').attr('readonly', true);
                            $('#btnSubmit').attr('disabled', true);
                            $('#btnSave').attr('disabled', true);
                            //$('#commissionerName').attr('readonly', true);
                            $('#nodalOfficerName').attr('readonly', true);
                            alert('Record already captured for selected Inspection Date and MMU Location!');
                        }
                        var inspectionChecklistData = result.data[0].inspectionChecklistData;
                        if(inspectionChecklistData.length > 0){
                            for(var i=0;i<inspectionChecklistData.length;i++){
                                var rowData = inspectionChecklistData[i];
                                $('.input-value').each(function(){
                                    if($(this).attr('data-checklist-id') == rowData.inspectionChecklistId){
                                        $(this).val(rowData.inputValue);
                                    }
                                });

                                $('.create-incident').each(function(){
                                    if($(this).attr('data-checklist-id') == rowData.inspectionChecklistId){
                                        $(this).attr('data-inspection-checklist-id', rowData.captureInspectionChecklistId);
                                    }
                                    if($(this).attr('data-checklist-id') == rowData.inspectionChecklistId && rowData.createIncident == 'Y'){
                                        $(this).attr('checked', true);
                                    }
                                });//upload-files

                                $('.remarks').each(function(){
                                    if($(this).attr('data-checklist-id') == rowData.inspectionChecklistId){
                                        $(this).val(rowData.remarks);
                                    }
                                });
                                $('.upload-files').each(function(){
                                    var label = $('<label/>')
                                        .addClass('filename-label')
                                        .css({'font-size': 'smaller','font-weight':'bold'})
                                        .text('Filename: '+rowData.uploadedFile);
                                    if($(this).attr('data-checklist-id') == rowData.inspectionChecklistId && rowData.uploadedFile){
                                       $(this).attr('title', rowData.uploadedFile);
                                       $(this).parent().prepend(label);
                                    }
                                });
                            }
                        }
                    }

                },
                error : function(data) {
                    alert("An error has occurred while contacting the server");
                }
            });
        }
    }

    function GetInspectionChecklist(){
        $('.ui-datepicker-trigger').hide();
        jQuery.ajax({
            crossOrigin: true,
            method: "POST",
            crossDomain:true,
            url: "getInspectionChecklist",
            data: JSON.stringify({"PN" : "0","status":"Y"}),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(result){
                var data = result.data;
                if(data && data.length > 0) {
                    var subseq_str = ['a', 'b', 'c', 'd', 'e', 'f']
                    for(var i=0;i<data.length;i++){
                        var rowData = data[i];
                        var $tr = $('<tr/>');
                        var subsequence = '';
                        if(rowData.subsequence){
                            subsequence = '('+subseq_str[parseInt(rowData.subsequence)-1]+')';
                        }
                        var sequenceNo = rowData.sequenceNo+subsequence;
                        var $td1 = $('<td/>').text(sequenceNo)
                        var penaltyExpirationMsg = '';
                        if(rowData.isPenaltyExpired){
                            penaltyExpirationMsg = '&nbsp;&nbsp;<i style="color: red">(Penalty has been Expired)</i>';
                            $('#btnSubmit').attr('disabled', true);
                        }
                        var $td2 = $('<td/>').append(rowData.checklistName+penaltyExpirationMsg)
                        var $textarea = $('<textarea/>').attr({'class': 'form-control input-value', 'data-checklist-id': rowData.checklistId, 'name': 'inputValue', 'data-sequence-no': sequenceNo}).bind('keypress', function (event) {
                            if ($(this).val().length > 199) {
                               event.preventDefault();
                               return false;
                            }
                        }).change(function(e){
                            var desc = $(this).val();
                            if(desc.length > 200){
                                alert('Input Value can be only 200 character value!');
                                $(this).val('');
                            }
                        });
                        var $option0 = $('<option/>').attr('value', '').text('--Select--')
                        var $option1 = $('<option/>').attr('value', 'YES').text('YES');
                        var $option2 = $('<option/>').attr('value', 'NO').text('NO');
                        var $combo = $('<select/>')
                                        .attr({'name': 'inputValue', 'class': 'form-control input-value', 'data-checklist-id': rowData.checklistId, 'data-sequence-no': sequenceNo})
                                        .append($option0)
                                        .append($option1)
                                        .append($option2)
                                        .val('YES');

                        var $td3 = $('<td/>')
                        if(rowData.typeOfInput == 'DROPDOWN'){
                            $td3 = $td3.append($combo);
                        } else {
                            $td3 = $td3.append($textarea);
                        }

                        var checkbox = $('<input/>', {'type': 'checkbox', 'name': 'createIncident', 'class': 'create-incident', 'data-checklist-id': rowData.checklistId});
                        var $td4 = $('<td/>').append(checkbox);

                        var file = $('<input/>', {'type': 'file', 'name': 'fileName'+i, 'data-checklist-id': rowData.checklistId, 'data-toggle': 'tooltip', title: 'No File Selected!'})
                                    .addClass('form-control upload-files')
                                    .css({'padding': '0rem 0rem', 'height': '26px'});
                        var $td5 = $('<td/>').append(file)

                        var $td6 = $('<td/>').append($('<textarea/>').attr({'name': 'remark', 'class': 'form-control remarks', 'data-checklist-id': rowData.checklistId}).keypress(function (event) {
                              if ($(this).val().length > 199) {
                                 event.preventDefault();
                                 return false;
                              }
                          }).change(function(e){
                              var desc = $(this).val();
                              if(desc.length > 200){
                                  alert('Remarks can be only 200 character value!');
                                  $(this).val('');
                              }
                          }));

                        $tr = $tr.append($td1).append($td2).append($td3).append($td4).append($td5).append($td6);
                        $('#inspectionChecklist').append($tr);
                    }
                }
                validateDuplicate();
                $('#loaderId').hide();
                $('.ui-datepicker-trigger').show();
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
                <div class="internal_Htext">Capture MMU Inspection Details</div>

                    <!-- end row -->

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="captureInspectionDetails" name="captureInspectionDetails" method="">
                                                <input type="hidden" name="inspectionDetailId" id="inspectionDetailId" />
                                                <input type="hidden" name="campId" id="campId" />
                                                <div class="row">

                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">MMU Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <select class="form-control" id="mmuName" name="mmuName" >
                                                                    <option value="">--Select--</option>
                                                                 </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">Date of Inspection<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <div class="dateHolder">
                                                                    <input type="text" readonly="true" name="inspectionDate" id="inspectionDate" class="calDate form-control" value="" onchange="setCampLocation()" placeholder="DD/MM/YYYY" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group row">
                                                        <div class="col-sm-5">
                                                            <label for="Instrument Code" class=" col-form-label inner_md_htext" ></label>
                                                            </div>
                                                            <div class="col-sm-7">

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

                                                  <div class="col-md-4" style="margin-left: 1px;margin-top: -21px;">
                                                        <div class="form-group row">
                                                            <div class="col-sm-5">
                                                            <label for="collection name" class="col-form-label inner_md_htext">APM Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                            </div>
                                                            <div class="col-sm-7">
                                                                <input type="text" class="form-control" id="apmName" name="apmName" placeholder="APM Name">
                                                          </div>
                                                      </div>
                                                 </div>

                                                 <div class="col-md-4" style="margin-top: -21px;">
                                                         <div class="form-group row">
                                                             <div class="col-sm-5">
                                                             <label for="collection name" class="col-form-label inner_md_htext">Doctor Name</label>
                                                             </div>
                                                             <div class="col-sm-7">
                                                                 <input type="text" class="form-control" id="doctorName" name="doctorName" placeholder="Doctor Name">
                                                            </div>
                                                       </div>
                                                  </div>

                                                  <div class="col-md-4" style="">
                                                       <div class="form-group row">
                                                           <div class="col-sm-5">
                                                           <label for="collection name" class="col-form-label inner_md_htext">Doctor Reg. No.</label>
                                                           </div>
                                                           <div class="col-sm-7">
                                                               <input type="text" class="form-control"  id="doctorRegNo" name="doctorRegNo" placeholder="Doctor Registration No">
                                                          </div>
                                                     </div>
                                                </div>

                                               <!--  <div class="col-md-4" style="">
                                                   <div class="form-group row">
                                                       <div class="col-sm-5">
                                                       <label for="collection name" class="col-form-label inner_md_htext">Commissioner Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                       </div>
                                                       <div class="col-sm-7">
                                                           <input type="text" class="form-control" id="commissionerName" name="commissionerName" placeholder="Commissioner Name">
                                                      </div>
                                                 </div>
                                            </div> -->

                                            <div class="col-md-4" style="margin-left: 1px;">
                                                   <div class="form-group row">
                                                       <div class="col-sm-5">
                                                       <label for="collection name" class="col-form-label inner_md_htext">Nodal Officer Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                       </div>
                                                       <div class="col-sm-7">
                                                           <input type="text" class="form-control" id="nodalOfficerName" name="nodalOfficerName" placeholder="Nodal Officer Name">
                                                      </div>
                                                 </div>
                                            </div>

                                            <div class="col-md-4" style="">
                                               <div class="form-group row">
                                                   <div class="col-sm-5">
                                                   <label for="collection name" class="col-form-label inner_md_htext">TPA Member 1<span class="mandate"><sup>&#9733;</sup></span></label>
                                                   </div>
                                                   <div class="col-sm-7">
                                                        <select class="form-control" id="tpaMember1Id" name="tpaMember1Id" >
                                                           <option value="">--Select--</option>
                                                        </select>
                                                  </div>
                                             </div>
                                        </div>

                                        <div class="col-md-4" style="margin-left: 1px;">
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
                                    <b style="color:green;font-size:12px" id="loaderId"><i class="fa fa-spinner fa-spin"></i> Please wait while loading...</b>
         							<br><form id="captureInspectionChecklistDetails" name="captureInspectionChecklistDetails">
         							<table class="table table-striped table-hover table-bordered">
                                            <thead class="bg-success" style="color:#fff;">
                                                <tr>
                                                    <th id="th1" class ="inner_md_htext">Sequence No.</th>
                                                    <th id="th2" class ="inner_md_htext">Checklist</th>
                                                    <th id="th3" class ="inner_md_htext">Input</th>
                                                    <th id="th2" class ="inner_md_htext">Create Incident</th>
                                                    <th id="th2" class ="inner_md_htext">Upload</th>
                                                    <th id="th4" class ="inner_md_htext">Remarks</th>
                                                </tr>
                                            </thead>

                                         <tbody class="clickableRow" id="inspectionChecklist">

                                         </tbody>
                                        </table>
                                    <b style="color:green;font-size:12px;display:none" id="submitterId"><i class="fa fa-spinner fa-spin"></i> Please wait while form submitting...</b>
									<div class="row">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
                                                <button type="button" id="btnSave" class="btn  btn-primary ">Save</button>
                                                <button type="button" id="btnSubmit" class="btn  btn-primary " disabled>Submit</button>
                                                <button type="button" id="generateReport" class="btn  btn-primary " disabled>Generate Report</button>
                                                <button type="button" id="reset" class="btn btn-danger ">Reset</button>
											</div>
										</div>
									</div>
                                      </form>

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


</body>

</html>
<%@include file="..//view/modelWindowForReportsMultiple.jsp"%>

