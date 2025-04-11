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
var insDtRe="";
var mmuIdRe=0;
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


 /*  String cityId = "0";
if (session.getAttribute("cityIdUsers") != null) {
	cityId = session.getAttribute("cityIdUsers").toString();
	cityId = cityId.replace(",","");
} */
%>

$j(document).ready(function(){
        onload();
        GetEquipmentChecklist();
        getMMUList();
        //runDuplicateThread();
        getFilteredUsers();

        $('#mmuName').on('change', function(){
            if($(this).val()){
                $('#vehicleRegNo').val($('#mmuName option:selected').data('reg-no'));
                jQuery('#mmuLocation').val('');
                setCampLocation();
            }
        });

        $('#generateReport').on('click', function(){
           // var insDt = $('#inspectionDate').val();
           // var mmuId = $('#mmuName').val();
            var insDttemp = $('#inspectionDate').val();
            var mmuIdtemp = $('#mmuName').val();
            if(insDttemp!=null && insDttemp!="" && insDttemp!=undefined && mmuIdtemp!=null && mmuIdtemp!="" && mmuIdtemp!=undefined){
          	  insDtRe=insDttemp;
          	  mmuIdRe= mmuIdtemp;
            } 
            
            var printInspectionReport='${pageContext.request.contextPath}/report/printEquipmentChecklist?campDate='+insDtRe+'&mmuId='+mmuIdRe+'&flagReport=I';
            openPdfModel(printInspectionReport);
        });

        $('#reset').on('click', function(){
            window.location = 'captureEuipmentChecklistDetails';
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
            if(!inspectionDate){
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
            //////////////////////////////////
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
            
            //////////////////////////////////////
            
             var comapreTpa=caompareTPAData();
            if(!comapreTpa){
            	return false;
            }
            var isValid = validateEquipmentChecklist();
            if(!isValid)
                return false;

            
            var $checklistIds = $('[name="createIncident"]');
            var $assignedQuantity = $('[name="assignedQuantity"]');
            var $operationalQuantity = $('[name="operationalQuantity"]');
            var $availableQuantity = $('[name="availableQuantity"]');
            var $penaltyQuantity = $('[name="penaltyQuantity"]');
            var $remarks = $('[name="remark"]');

            var checklistIds = [];
            var assignedQuantity = [];
            var operationalQuantity = [];
            var availableQuantity = [];
            var penaltyQuantity = [];
            var remarks = [];
            var equipmentChecklistIds = [];
            var remarksString="";
            $('[name="checklistId"]').each(function(index){
                checklistIds.push($(this).val());
                assignedQuantity.push($($assignedQuantity[index]).val());
                availableQuantity.push($($availableQuantity[index]).val());
                operationalQuantity.push($($operationalQuantity[index]).val());
                
                //Remove code for comma seperated values for remarks
                /*  if($($remarks[index]).val())
                     remarks.push($($remarks[index]).val());
                 else remarks.push('_'); */
                 
                 
                 //add code for # sepereated remarks 
                 if ($($remarks[index]).val()) {
                     remarksString += $($remarks[index]).val() + '#';  // Add value and '#' separator
                 } else {
                     remarksString += '_#';  // Add '_' and '#' separator
                 }

                
                
                penaltyQuantity.push($($penaltyQuantity[index]).val());
                equipmentChecklistIds.push($($availableQuantity[index]).attr('data-capture-equipment-checklist-id'));
            });
            
            remarks.push(remarksString.slice(0, -1));  // Remove last '#' and push
            
           
            

            if(confirm(pMsg)){
                $('button').attr('disabled', true);
                $('#submitterId').show();
                var auditStatus = 'P';
                if($(this).attr('id') == 'btnSave')
                    auditStatus = 'S';

                var formData = new FormData(document.getElementById("captureEquipmentForm"));
                formData.append('cityId', $('#city').val());
                formData.append('mmuId', $('#mmuName').val());
                formData.append('inspectionDate', $('#inspectionDate').val());
                formData.append('vehicleRegNo', $('#vehicleRegNo').val());
                formData.append('mmuLocation', $('#mmuLocation').val());
                formData.append('auditStatus', auditStatus);
                formData.append('equipmentChecklistDetailId', $('#equipmentChecklistDetailId').val());
                formData.append('checklistIds', checklistIds);
                formData.append('assignedQuantities', assignedQuantity);
                formData.append('operationalQuantities', operationalQuantity);
                formData.append('availableQuantities', availableQuantity);
                formData.append('penaltyQuantities', penaltyQuantity);
                formData.append('remarks', remarks);
                formData.append('equipmentChecklistIds', equipmentChecklistIds);
                formData.append('apmNames', $('#apmName').val());
                formData.append('doctorNames', $('#doctorName').val());
                formData.append('doctorRegNos', $('#doctorRegNo').val());
                formData.append('commissionerName', '');
                formData.append('nodalOfficerName', $('#nodalOfficerName').val());
                formData.append('commissionerName', '');
                formData.append('tpaMember1Id', $('#tpaMember1Id').val());
                formData.append('tpaMember2Id', $('#tpaMember2Id').val());
                formData.append('campId', $('#campId').val());

                var url = "captureEquipmentChecklistDetails";
                SendMultipartData(url,formData,successCallback,$(this));
            }
        })
    });

    function successCallback($elementObj){
        $('button').attr('disabled', false);
        $('#submitterId').hide();
        if($elementObj.attr('id') == 'btnSave'){
            validateDuplicate();
        } else {
        	insDtRe = $('#inspectionDate').val();
        	mmuIdRe=$('#mmuName').val();
            $('input,select').val('');
            $('.filename-label').remove();
        }
    }

    function validateEquipmentChecklist(){
        var $assignedQuantity = $('[name="assignedQuantity"]');
        var $availableQuantity = $('[name="availableQuantity"]');
        var $operationalQuantity = $('[name="operationalQuantity"]');
        var returnVal = true;

        $assignedQuantity.each(function(index){
            var aq = parseInt($(this).val());
            var oq = parseInt($($operationalQuantity[index]).val());
            var avlq = parseInt($($availableQuantity[index]).val());
            if(avlq > aq){
                alert('Available Quantity should not be greater than Assigned Quantity!');
                returnVal = false;

                $($availableQuantity[index]).css('border-color', 'red');
                setTimeout(function(){
                    $($availableQuantity[index]).css('border-color', '');
                }, 30000);
            }
            if(oq > avlq){
                alert('Operational Quantity should not be greater than Available Quantity!');
                returnVal = false;
                $($operationalQuantity[index]).css('border-color', 'red');
                setTimeout(function(){
                    $($operationalQuantity[index]).css('border-color', '');
                }, 30000);
            }
        });
        return returnVal;
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
                       <%-- document.getElementById('mmuName').value = <%=mmuId%>; --%>
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

    function setCampLocation(){
        $('#mmuLocation').val('');
        $('#vehicleRegNo').val('');
        $('#equipmentChecklistDetailId').val('');
        $('#apmName').val('');
        $('#doctorName').val('');
        $('#doctorRegNo').val('');
        //$('#commissionerName').val('');
        $('#nodalOfficerName').val('');
        
        $('#nodalOfficerName').attr('readonly', false);
        $('#apmName').attr('readonly', false);
        //$('#commissionerName').attr('readonly', false);
        
      
        
        $('#btnSubmit').attr('disabled', false);
        $('#btnSave').attr('disabled', false);
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
            data: JSON.stringify({"PN" : "0", "mmuId": $('#mmuName').val(), "campDate": insDtArr.join('/')}),
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

    function runDuplicateThread(){
        setTimeout(function(){
            if($('#mmuLocation').val())
                validateDuplicate();
            else runDuplicateThread();
        }, 1000);
    }

    function validateDuplicate(){
        $('.filename-label').remove();
        $('#btnSubmit').attr('disabled', false);
        var mmuLocation = $('#mmuLocation').val();
        var insDt = $('#inspectionDate').val();
        if(mmuLocation && insDt){
            $('textarea.remarks').val('');
            $('input[name="availableQuantity"]').each(function(){
                $(this).val($(this).attr('data-quantity'));
            });
            $('input[name="operationalQuantity"]').each(function(){
                $(this).val($(this).attr('data-quantity'));
            });
            $('input[name="penaltyQuantity"]').val(0);

            var params = {
                'PN': 0,
                'mmuLocation': mmuLocation,
                'inspectionDate': insDt
            };
            $.ajax({
                type : "POST",
                contentType : "application/json",
                url : 'validateCapturedDuplicateEquipmentDetail',
                data : JSON.stringify(params),
                dataType : "json",
                cache : false,
                success : function(result) {
                    if(result && result.data && result.data.length > 0){
                        $('#equipmentChecklistDetailId').val(result.data[0].equipmentDetailData.equipmentDetailId);
                        //$('#commissionerName').val(result.data[0].equipmentDetailData.commissionerName);
                        
                        // Replace the actual value if data is saved in TAble
                        $('#doctorName').val(result.data[0].equipmentDetailData.doctorName);
						$('#doctorRegNo').val(result.data[0].equipmentDetailData.doctorRegNo);
						
						
                        $('#nodalOfficerName').val(result.data[0].equipmentDetailData.nodalOfficerName);
                        $('#apmName').val(result.data[0].equipmentDetailData.apmName);
                        $('#tpaMember1Id').val(result.data[0].equipmentDetailData.tpaMember1Id);
                        $('#tpaMember2Id').val(result.data[0].equipmentDetailData.tpaMember2Id);
                        if(result.data[0].equipmentDetailData.auditStatus)
                            $('#generateReport').attr('disabled', false);

                        if(result.data[0].equipmentDetailData.auditStatus != 'S'){
                            $('#apmName').attr('readonly', true);
                            $('#btnSubmit').attr('disabled', true);
                            $('#btnSave').attr('disabled', true);
                            //$('#commissionerName').attr('readonly', true);
                            $('#nodalOfficerName').attr('readonly', true);
                            alert('Record already captured for selected Inspection Date and MMU Location!');
                        }
                        var equipmentChecklistData = result.data[0].equipmentChecklistData;
                        if(equipmentChecklistData.length > 0){
                            for(var i=0;i<equipmentChecklistData.length;i++){
                                var rowData = equipmentChecklistData[i];
                                $('input[name="availableQuantity"]').each(function(){
                                    if($(this).attr('data-checklist-id') == rowData.equipmentChecklistId){
                                        $(this).attr('data-capture-equipment-checklist-id', rowData.captureEquipmentChecklistId);
                                        $(this).val(rowData.availableQuantity);
                                    }
                                });
                                $('input[name="operationalQuantity"]').each(function(){
                                    if($(this).attr('data-checklist-id') == rowData.equipmentChecklistId){
                                        $(this).val(rowData.operationalQuantity);
                                    }
                                });
                                $('input[name="penaltyQuantity"]').each(function(){
                                    if($(this).attr('data-checklist-id') == rowData.equipmentChecklistId){
                                        $(this).val(rowData.penaltyQuantity);
                                    }
                                });

                                $('.remarks').each(function(){
                                    if($(this).attr('data-checklist-id') == rowData.equipmentChecklistId){
                                        $(this).val(rowData.remarks);
                                    }
                                });

                                $('.upload-files').each(function(){
                                    var label = $('<label/>')
                                        .addClass('filename-label')
                                        .css({'font-size': 'smaller','font-weight':'bold'})
                                        .text('Filename: '+rowData.uploadedFile);
                                    if($(this).attr('data-checklist-id') == rowData.equipmentChecklistId && rowData.uploadedFile){
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


    function GetEquipmentChecklist(){
        jQuery.ajax({
            crossOrigin: true,
            method: "POST",
            crossDomain:true,
            url: "getEquipmentChecklist",
            data: JSON.stringify({"PN" : "0","status":"Y"}),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(result){
                var data = result.data;
                if(data && data.length > 0) {
                    for(var i=0;i<data.length;i++){
                        var rowData = data[i];
                        var $tr = $('<tr/>');

                        var $td1 = $('<td/>').text((i+1)+'.');

                        var penaltyExpirationMsg = '';
                        if(rowData.isPenaltyExpired){
                            penaltyExpirationMsg = '&nbsp;&nbsp;<i style="color: red">(Penalty has been Expired)</i>';
                            $('#btnSubmit').attr('disabled', true);
                        }
                        var hiddenId = $('<input/>', {'type':'hidden', 'name':'checklistId', 'value': rowData.checklistId});
                        var $td2 = $('<td/>').append(rowData.instrumentName+penaltyExpirationMsg).append(hiddenId);

                        var assignedQuantityText = $('<input/>', {'type':'text', 'name':'assignedQuantity', 'class': 'form-control', 'value': rowData.quantity, 'readonly': 'true'})
                        var $td3 = $('<td/>').append(assignedQuantityText);

                        var availableQuantityText = $('<input/>', {'type':'text', 'name':'availableQuantity', 'class': 'form-control', 'value': rowData.quantity, 'data-quantity': rowData.quantity, 'data-checklist-id': rowData.checklistId}).on('change', function(){
                             if(!$(this).val()){
                                 $(this).val($(this).parent().prev().children().val());
                             }
                        }).keypress(function (e) {
                           var charCode = (e.which) ? e.which : event.keyCode
                           if (String.fromCharCode(charCode).match(/[^0-9]/g))
                               return false;
                        }).change(function(){
                            if($(this).val() > $(this).data('quantity')){
                                alert('Available Quantity should not be greater than Assigned Quantity!');
                                $(this).val($(this).data('quantity'));
                            }else{
                                $(this).parent().next().children().val($(this).val());
                                $(this).parent().next().next().children().val($(this).data('quantity') - $(this).val());
                            }
                        });
                        var $td4 = $('<td/>').append(availableQuantityText);

                        var operationalQuantityText = $('<input/>', {'type':'text', 'name':'operationalQuantity', 'class': 'form-control', 'value': rowData.quantity, 'data-quantity': rowData.quantity, 'data-checklist-id': rowData.checklistId}).on('change', function(){
                           if(!$(this).val()){
                               $(this).val($(this).parent().prev().children().val());
                           }
                       }).keypress(function (e) {
                         var charCode = (e.which) ? e.which : event.keyCode
                         if (String.fromCharCode(charCode).match(/[^0-9]/g))
                             return false;
                       }).change(function(){
                           if($(this).val() > $(this).parent().prev().children().val()){
                               var pq = $(this).parent().prev().prev().children().val() - $(this).parent().prev().children().val();
                               $(this).parent().next().children().val(pq);
                               alert('Operational Quantity should not be greater than Available Quantity!');
                               $(this).val($(this).parent().prev().children().val());
                           } else if($(this).val() == $(this).parent().prev().children().val()){
                                $(this).parent().next().children().val(0);
                           } else {
                               var pq = $(this).parent().next().children().val();
                               pq = parseInt(pq) + ($(this).parent().prev().children().val() - $(this).val());
                               $(this).parent().next().children().val(pq);
                           }
                       });
                        var $td5 = $('<td/>').append(operationalQuantityText);

                        var penaltyQuantityText = $('<input/>', {'type':'text', 'name':'penaltyQuantity', 'class': 'form-control', 'value': 0, 'readonly': 'true', 'data-checklist-id': rowData.checklistId})
                        var $td6 = $('<td/>').append(penaltyQuantityText);

                        var file = $('<input/>', {'type': 'file', 'name': 'fileName'+i, 'data-checklist-id': rowData.checklistId, 'data-toggle': 'tooltip', title: 'No File Selected!'})
                                    .addClass('form-control upload-files')
                                    .css({'padding': '0rem 0rem', 'height': '26px'});
                        var $td7 = $('<td/>').append().append(file)

                        var $td8 = $('<td/>').append($('<textarea/>').attr({'name': 'remark', 'class': 'form-control remarks', 'data-checklist-id': rowData.checklistId}));

                        $tr = $tr.append($td1).append($td2).append($td3).append($td4).append($td5).append($td6).append($td7).append($td8);
                        $('#equipmentChecklist').append($tr);
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
                <div class="internal_Htext">Capture Equipment Checklist Details</div>

                    <!-- end row -->

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                 <p align="center" id="messageId" style="color:green; font-weight: bold;" ></p>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <form id="equipmentChecklistDetailForm" name="equipmentChecklistDetailForm" method="">
                                                <input type="hidden" name="equipmentChecklistDetailId" id="equipmentChecklistDetailId" />
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
                                                                    <input type="text" readonly="true" name="inspectionDate" id="inspectionDate" class="calDate form-control" onchange="setCampLocation()" value="" placeholder="DD/MM/YYYY" />
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
                                                                <input type="text" class="form-control" readonly="true" id="vehicleRegNo" name="vehicleRegNo" placeholder="Vehicle Registration No.">
														    </div>
                                                      </div>
                                                 </div>

                                                 <div class="col-md-4">
                                                         <div class="form-group row">
                                                             <div class="col-sm-5">
                                                             <label for="collection name" class="col-form-label inner_md_htext">MMU Location<span class="mandate"><sup>&#9733;</sup></span></label>
                                                             </div>
                                                             <div class="col-sm-7">
                                                                 <input type="text" class="form-control" readonly="true" id="mmuLocation" name="mmuLocation" placeholder="MMU Location">
                                                            </div>
                                                       </div>
                                                  </div>

                                                  <div class="col-md-4" style="margin-left: 1px;margin-top: -21px;">
                                                      <div class="form-group row">
                                                          <div class="col-sm-5">
                                                          <label for="collection name" class="col-form-label inner_md_htext">APM Name<span class="mandate"><sup>&#9733;</sup></span></label>
                                                          </div>
                                                          <div class="col-sm-7">
                                                              <input type="text" class="form-control"  id="apmName" name="apmName" placeholder="APM Name">
                                                        </div>
                                                    </div>
                                               </div>

                                               <div class="col-md-4" style="margin-top: -21px;">
                                                       <div class="form-group row">
                                                           <div class="col-sm-5">
                                                           <label for="collection name" class="col-form-label inner_md_htext">Doctor Name</span></label>
                                                           </div>
                                                           <div class="col-sm-7">
                                                               <input type="text" class="form-control"  id="doctorName" name="doctorName" placeholder="Doctor Name">
                                                          </div>
                                                     </div>
                                                </div>

                                                <div class="col-md-4" style="">
                                                       <div class="form-group row">
                                                           <div class="col-sm-5">
                                                           <label for="collection name" class="col-form-label inner_md_htext">Doctor Reg. No.</label>
                                                           </div>
                                                           <div class="col-sm-7">
                                                               <input type="text" class="form-control" id="doctorRegNo" name="doctorRegNo" placeholder="Doctor Registration No">
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
         							<br><form id="captureEquipmentForm">
         							<table class="table table-striped table-hover table-bordered ">
                                            <thead class="bg-success" style="color:#fff;">
                                                <tr>
                                                    <th id="th0" class ="inner_md_htext">Sr. No.</th>
                                                    <th id="th1" class ="inner_md_htext">Instrument Name</th>
                                                    <th id="th3" class ="inner_md_htext">Assigned Qty.</th>
                                                    <th id="th3" class ="inner_md_htext">Available Qty.</th>
                                                    <th id="th3" class ="inner_md_htext">Operational Qty.</th>
                                                    <th id="th4" class ="inner_md_htext">Penalty Quantity</th>
                                                    <th id="th2" class ="inner_md_htext">Upload</th>
                                                    <th id="th4" class ="inner_md_htext">Remarks</th>
                                                </tr>
                                            </thead>

                                         <tbody class="clickableRow" id="equipmentChecklist">

                                         </tbody>
                                        </table>
                                    <b style="color:green;font-size:12px;display:none" id="submitterId"><i class="fa fa-spinner fa-spin"></i> Please wait while form submitting...</b>
									<div class="row">

										<div class="col-md-12">
											<div class="btn-left-all"></div>
											<div class="btn-right-all">
                                                <button type="button" id="btnSave" class="btn  btn-primary ">Save</button>
                                                <button type="button" disabled id="btnSubmit" class="btn  btn-primary ">Submit</button>
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

