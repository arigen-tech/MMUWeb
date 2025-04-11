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
	if (session.getAttribute("userId") != null) {
		userId = session.getAttribute("userId") + "";
	}
	String mmuId = "1";
	if (session.getAttribute("mmuId") != null) {
		mmuId = session.getAttribute("mmuId") + "";
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
	//loadVendors();
	getCityList();
	var data = ${
        data
    };
    
    setTimeout( function() { getAnmOpdOfflineData(data); }, 1000);
 
});

function setCampLocation(val){
    var insDt = $('#dateOfEntry').val();
    var insDtArr = insDt.split('/');
    if(insDtArr[0].length == 1){
        insDtArr[0] = '0'+insDtArr[0];
    }
     var insDts = new Date(insDtArr[2], insDtArr[1]-1, insDtArr[0]);
     var todaysDate = new Date();
     var currDate = new Date(todaysDate.getFullYear(), todaysDate.getMonth(), todaysDate.getDate());
    /*  if(insDts.getTime() > currDate.getTime()){
         alert('Date of entry should not be future date!');
         $('#dateOfEntry').trigger('change');
         return false;
     } */
    jQuery.ajax({
        crossOrigin: true,
        method: "POST",
        crossDomain:true,
        url: "${pageContext.servletContext.contextPath}/audit/getCampLocation",
        data: JSON.stringify({"PN" : "0", "cityId": $('#cityId').val(), "mmuId": $('#mmuIds').val(), "campDate": insDtArr.join('/')}),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(result){
           if(result && result.data && result.data.length > 0 && result.data[0]){
                jQuery('#mmuLocation').val(result.data[0]);
                saveSubmitANMEntry(val);
             } else {
                alert('Camp is not configured, So you cannot submit the data for selected MMU!');
                $('#dateOfEntry').val("");
                jQuery('#mmuLocation').val("");
                return false;
                
            }
        }

    });
}

function getAnmOpdOfflineData(val) {

	var data = val.data;
	var count = 1;
	var countins = 1;
	var allocationGridValue = "";
	var approvedFlag=0;
	if (data != null && data.length > 0) {
		for (var i = 0; i < data.length; i++) {
			anmApmId
			if(data[i].status=="s")
			{	
			$("#totalNoPatients").val(data[i].totalNoPatients);
			$("#anmApmId").val(data[i].anmApmId);
			$("#status").val(data[i].status);
			$("#patientNoLabTest").val(data[i].patientNoLabTest);
			$("#patientNoMedicineDispensed").val(data[i].patientNoMedicineDispensed);
			$("#patientNoLabourRegistredDepartment").val(data[i].patientNoLabourRegistredDepartment);
			$("#patientNoApplyLabourRegistration").val(data[i].patientNoApplyLabourRegistration);
			$("#cityId").val(data[i].cityId);
			
			$("#dateOfEntry").val(data[i].opdDate);
			$("#totalNoPatients").val(data[i].totalNoPatients);
			var cityId=data[i].cityId;
			var mmuIdVal=data[i].mmuId;
			getMMUApiList(cityId,mmuIdVal);
			}
			else
			{
				 $("#totalNoPatients").prop('disabled', true);
				 $("#patientNoLabTest").prop('disabled', true);
				 $("#patientNoMedicineDispensed").prop('disabled', true);
				 $("#patientNoApplyLabourRegistration").prop('disabled', true);
				 $("#patientNoApplyLabourRegistration").prop('disabled', true);
				 $("#cityId").prop('disabled', true);
				 $("#patientNoLabourRegistredDepartment").prop('disabled', true);
				 $("#mmuIds").prop('disabled', true);
				 $("#captureANMDataSave").prop('disabled', true);
				 $("#captureANMDataSubmit").prop('disabled', true);
				$("#totalNoPatients").val(data[i].totalNoPatients);
				$("#anmApmId").val(data[i].anmApmId);
				$("#status").val(data[i].status);
				$("#patientNoLabTest").val(data[i].patientNoLabTest);
				$("#patientNoMedicineDispensed").val(data[i].patientNoMedicineDispensed);
				$("#patientNoLabourRegistredDepartment").val(data[i].patientNoLabourRegistredDepartment);
				$("#patientNoApplyLabourRegistration").val(data[i].patientNoApplyLabourRegistration);
				$("#cityId").val(data[i].cityId);
				
				$("#dateOfEntry").val(data[i].opdDate);
				$("#totalNoPatients").val(data[i].totalNoPatients);
				var cityId=data[i].cityId;
				var mmuIdVal=data[i].mmuId;
				getMMUApiList(cityId,mmuIdVal);
			}	
		}
	}
}

function getCityList(){
	var mmudIdss=$('#mmuIdSessionVal').val();
	$j("#cityId").empty();
	 $j("#mmuIds").empty();
	var districtId=$j("#district option:selected").val();
    jQuery.ajax({
        crossOrigin: true,
        method: "POST",
        crossDomain:true,
        url: "${pageContext.servletContext.contextPath}/master/getAllCityMmuMapping",
        data: JSON.stringify({"PN" : "0","cityMmuPage":"1","mmuId":mmudIdss}),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function(result){
        	var combo = "" ;
	    	combo += '<option value="">Select</option>' ;
	    	for(var i=0;i<result.data.length;i++){
	    		
	    		combo += '<option value='+result.data[i].cityId+'>' +result.data[i].cityName+ '</option>';
	    		
	    	}
	    	
	    	jQuery('#cityId').append(combo);
	    	var mmuDrop = '';
			mmuDrop += '<option value="">Select</option>' ;
			$j('#mmuIds').append(mmuDrop);
        }
    });
    //return mappedData;
}


function getMMUList(item){
	  $j("#mmuIds").empty();
	  var mmudIdss=$('#mmuIdSessionVal').val();
	  var params;
	  if(item != ''){
		  var cityId = item.value;
		  params = {
				  "mmuId":mmudIdss,
				   "PN" : "0"
			}
	  }else{
		  params = { };
	  }
	 
		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url: "${pageContext.servletContext.contextPath}/master/getAllCityMmuMapping",
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(data) {
				if(data.status == true){
					var list = data.data;
					var mmuDrop = '';
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
	
function getMMUApiList(val,mmuIdVal){
	  $j("#mmuIds").empty();
	  var mmudIdss=$('#mmuIdSessionVal').val();
	  var params;
	  if(item != ''){
		  var cityId = val;
		  params = {
				    "mmuId":mmudIdss,
					"PN" : "0"
			}
	  }else{
		  params = { };
	  }
	 
		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url: "${pageContext.servletContext.contextPath}/master/getAllCityMmuMapping",
			data : JSON.stringify(params),
			dataType : "json",
			cache : false,
			success : function(data) {
				if(data.status == true){
					var list = data.data;
					var mmuDrop = '';
					mmuDrop += '<option value="">Select</option>' ;
					for(i=0;i<list.length;i++){
						mmuDrop += '<option value='+list[i].mmuId+'>'+list[i].mmuName+'</option>';
					}
					$j('#mmuIds').append(mmuDrop);
					$j('#mmuIds').val(mmuIdVal);
				}
			},
			error : function(data) {
				alert("An error has occurred while contacting the server");
			}
		}); 
	}
	
	
function saveSubmitANMEntry(val){
	
	var status=val;
	
	  if(!$('#cityId').val()){
	      alert('Please Select City !');
	      return false;
	   }
	  if(!$('#mmuIds').val()){
	      alert('Please Select MMU !');
	      return false;
	   }
	  if(!$('#dateOfEntry').val()){
	      alert('Please Select Date !');
	      return false;
	   }
	  if(!$('#totalNoPatients').val()){
	      alert('Please enter Total no. of patient !');
	      return false;
	   }
	  if(!$('#patientNoLabTest').val()){
	      alert('Please enter No. of patients got lab test !');
	      return false;
	   }
  
 if(!$('#patientNoMedicineDispensed').val()){
     alert('Please enter No. of patients to whom medicine dispensed !');
     return false;
 }
 if(!$('#patientNoLabourRegistredDepartment').val()){
     alert('Please enter No. of patients registered in labour department !');
     return false;
 }
 if(!$('#patientNoApplyLabourRegistration').val()){
     alert('Please enter No. of patients who has applied for labour registration !');
     return false;
 }
 var opdDate=$('#dateOfEntry').val();
 if(isFutureDate(opdDate)){
	   alert('Date should not be future date!');
	   everyFieldValidate=false;
     return false;
 }
 
 
 var dataJSON = {

		 'status':status,
         'cityId': $('#cityId').val(),
         'mmuId': $('#mmuIds').val(),
         'totalNoPatients': $('#totalNoPatients').val(),
         'patientNoLabTest':$('#patientNoLabTest').val(),
         'patientNoMedicineDispensed':$('#patientNoMedicineDispensed').val(),
         'patientNoLabourRegistredDepartment':$('#patientNoLabourRegistredDepartment').val(),
         'patientNoApplyLabourRegistration':$('#patientNoApplyLabourRegistration').val(),
         'lastChgBy':$('#userId').val(),
         'dateOfEntry':opdDate,
         'anmApmId': $('#anmApmId').val()
         
         
   }
 $("#captureANMDataSave").attr("disabled", true);
 $("#captureANMDataSubmit").attr("disabled", true);
 jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/approve/saveOrUpdateANMEntryDetails",
	    data: JSON.stringify(dataJSON),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(msg) {
       	console.log(msg)
           if (msg.status == 1)
           {
        	   localStorage.typeOfVal='anmSecondTime';
               var Id= msg.anmApmId;
               localStorage.anmEntryDetailId=Id;
               window.location.href ="anmOpdDataSubmit?anmEntryDetailId="+Id+"";
           } 
           else if(msg.status == 0)
           {
        	   $("#captureANMDataSave").attr("disabled", true);
        	   $("#captureANMDataSubmit").attr("disabled", true);	
            alert(msg.msg)	
           }	
           else
           {
        	   $("#captureANMDataSave").attr("disabled", true);
        	   $("#captureANMDataSubmit").attr("disabled", true);
               alert("Please enter the valid data")
           }
       },
       error: function(jqXHR, exception) {
    	   $("#captureANMDataSave").attr("disabled", true);
    	   $("#captureANMDataSubmit").attr("disabled", true);
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

function isFutureDate(idate){
	var today = new Date().getTime(),
	    idate = idate.split("/");

	idate = new Date(idate[2], idate[1] - 1, idate[0]).getTime();
	return (today - idate) < 0 ? true : false;
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

var todayDate = "";
$(document).ready(function() {
	todayDate = new Date();
	var dd = String(todayDate.getDate()).padStart(2, '0');
	var mm = String(todayDate.getMonth() + 1).padStart(2, '0');
	var yyyy = todayDate.getFullYear();

	//today =  yyyy + '-' + mm + '-' +dd;

	todayDate = dd + '/' + mm + '/' + yyyy;
	//document.write(today);
	$('#dateOfEntry').val(todayDate);
});

function checkTotalPatient()
{
	var totalNoOfPAtient=$('#totalNoPatients').val();
	var totalNoOfLabTest=$('#patientNoLabTest').val();
	var patientNoMedicineDispensed=$('#patientNoMedicineDispensed').val();
    var patientNoLabourRegistredDepartment=$('#patientNoLabourRegistredDepartment').val();
    var patientNoApplyLabourRegistration=$('#patientNoApplyLabourRegistration').val();
	
    var countNo=parseFloat(patientNoLabourRegistredDepartment)+parseFloat(patientNoApplyLabourRegistration);
	if(parseFloat(totalNoOfLabTest) > parseFloat(totalNoOfPAtient))
	{
		alert("No. of patients got lab test should not be greater than total no. of patient !")
		$('#patientNoLabTest').val("");
	}
	else if(parseFloat(patientNoMedicineDispensed) > parseFloat(totalNoOfPAtient))
	{
		alert("No. of patients to whom medicine dispensed should not be greater than total no. of patient !")
		$('#patientNoMedicineDispensed').val("");
	}
	else if(parseFloat(patientNoLabourRegistredDepartment) > parseFloat(totalNoOfPAtient))
	{
		alert("No. of patients registered in labour department should not be greater than total no. of patient !")
		$('#patientNoLabourRegistredDepartment').val("");
	}
	else if(parseFloat(patientNoApplyLabourRegistration) > parseFloat(totalNoOfPAtient))
	{
		alert("No. of patients who has applied for labour registration should not be greater than total no. of patient !")
		$('#patientNoApplyLabourRegistration').val("");
	}
	else if(parseFloat(countNo) > parseFloat(totalNoOfPAtient))
	{
		alert("No. of patients who has applied for labour registration and registered in labour department should not be greater than total no. of patient !")
		$('#patientNoApplyLabourRegistration').val("");
		$('#patientNoLabourRegistredDepartment').val("");
	}
	
	
}

function redirect()
{
	window.location.href ="anmOpdOfflineList"; 
}

</script>
</head>

<body>
 <!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">OPD Offline Data</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<p align="center" id="messageId"
									style="color: green; font-weight: bold;"></p>
                                <form id="captureVendorBillForm">
                                <input  name="status" id="status" type="hidden" value="" />
                                <input type="hidden" id="updateStatus" name="updateStatus" value="">
                                <input type="hidden" id="firstTime" name="firstTime" value="firstTime">
                                <input  name="anmApmId" id="anmApmId" type="hidden" value=""/>
                                <input  name="lastApprovalMsg" id="lastApprovalMsg" type="hidden" value=""/>
                                <input  name="userId " id="userId" type="hidden" value="<%=userId%>"/>
                                <input type="hidden"  name="mmuIdSessionVal" value=<%= session.getAttribute("mmuId") %> id="mmuIdSessionVal" />
                                 <input type="hidden" class="form-control" readonly="true" id="mmuLocation" name="mmuLocation">
                                    <div class="row">
                                       
 										
                                        <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">City</label>
                                                </div>
                                                <div class="col-md-6">
                                                    <select class="form-control" id="cityId" name="cityId" onchange="getMMUList(this,'')">
                                                        <option value="">Select</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                         <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">MMU</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <select class="form-control" id="mmuIds" name="mmuIds">
                                                        <option value="">Select</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">Date</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <div class="dateHolder">
                                                        <input type="text" name="dateOfEntry" readonly="true" class="calDate form-control" id="dateOfEntry" value="" placeholder="DD/MM/YYYY" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                
                                    <div class="row m-t-10">
                                        <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">Total no. of patient</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <input type="text" class="form-control" maxlength="4" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" name="totalNoPatients" id="totalNoPatients"/>
                                                </div>

                                            </div>
                                        </div>
                                           <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">No. of patients got lab test</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <input type="text" class="form-control" maxlength="4" onchange="checkTotalPatient()" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" name="patientNoLabTest" id="patientNoLabTest"/>
                                                </div>

                                            </div>
                                        </div>
                                       <!--   -->
                                    </div>
                                     <div class="row m-t-10">
                                        <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">No. of patients to whom medicine dispensed</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <input type="text" class="form-control" maxlength="4" onchange="checkTotalPatient()" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" name="patientNoMedicineDispensed" id="patientNoMedicineDispensed"/>
                                                </div>

                                            </div>
                                        </div>
                                           <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">No. of patients registered in labour department</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <input type="text" class="form-control" maxlength="4" onchange="checkTotalPatient()" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" name="patientNoLabourRegistredDepartment" id="patientNoLabourRegistredDepartment"/>
                                                </div>

                                            </div>
                                        </div>
                                        </div>

                                    <div class="row m-t-10">
                                        <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">No. of patients who has applied for labour registration</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <input type="text" id="patientNoApplyLabourRegistration" maxlength="4" onchange="checkTotalPatient()" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" name="patientNoApplyLabourRegistration" class="form-control"/>
                                                </div>

                                            </div>
                                        </div>
                                        
                                   
                                    
									
                               	</div>
                                    <div class="row">
                                        <div class="col-12 m-t-10 text-right">
                                            <button type="button" id="captureANMDataSave" value="s" onclick="setCampLocation(this.value)"   class="btn btn-primary">Save</button>
                                             <button type="button" id="captureANMDataSubmit" value="c" onclick="setCampLocation(this.value)" class="btn btn-primary">Submit</button>
                                            <button type="button" id="closeBtn" value="" onclick="redirect()" class="btn btn-primary">Close</button>
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