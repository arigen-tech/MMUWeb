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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/commonformodal.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//loadVendors();
	getMMUList();
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



/* function getCityList(){
	$j("#cityId").empty();
	 $j("#mmuIds").empty();
	var districtId=$j("#district option:selected").val();
	jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/master/getAllCity",
	    data: JSON.stringify({"PN" : "0"}),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
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
} */

	
function saveSubmitANMEntry(val){
		
	var status=val;
	  if(!$('#employeeId').val()){
	      alert('Please enter employee name !');
	      return false;
	   }
	  if(!$('#mmuIds').val()){
	      alert('Please Select MMU !');
	      return false;
	   }
	  if(!$('#dateOfEntry').val()){
	      alert('Please select date of attendance !');
	      return false;
	   }
	  if(!$('#remarks').val()){
	      alert('Please enter remarks !');
	      return false;
	   }
  
 
 var attendanceDate=$('#dateOfEntry').val();
 
 
 
 var dataJSON = {

		 'status':status,
         'mmuId': $('#mmuIds').val(),
         'userId': $('#userId').val(),
         'employeeId': $('#employeeId').val(),
         'actionId':$('#actionId').val(),
         'remarks':$('#remarks').val(),
         'dateOfEntry':attendanceDate
         
         
   }
 $("#captureANMDataSubmit").attr("disabled", true);
 jQuery.ajax({
	 	crossOrigin: true,
	    method: "POST",			    
	    crossDomain:true,
	    url: "${pageContext.servletContext.contextPath}/approve/saveOrUpdateAttendanceOfflineData",
	    data: JSON.stringify(dataJSON),
	    contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function(msg) {
       	console.log(msg)
           if (msg.status == 1)
           {
        	   localStorage.typeOfVal='anmFirstTime';
               var Id= msg.anmApmId;
               localStorage.anmEntryDetailId=Id;
               window.location.href ="attendanceDataSubmit?attendanceId="+Id+"";
           } 
           else if(msg.status == 0)
           {
        	   $("#captureANMDataSave").attr("disabled", false);
        	   $("#captureANMDataSubmit").attr("disabled", false);	
            alert(msg.msg)	
           }	
           else
           {
        	   $("#captureANMDataSave").attr("disabled", false);
        	   $("#captureANMDataSubmit").attr("disabled", false);
               alert("Please enter the valid data")
           }
       },
       error: function(jqXHR, exception) {
    	   $("#captureANMDataSave").attr("disabled", false);
    	   $("#captureANMDataSubmit").attr("disabled", false);
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

function getMMUList(){
	var params = { };
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : '${pageContext.servletContext.contextPath}/empRegistration/getMMUList',
		data : JSON.stringify(params),
		dataType : "json",
		cache : false,
		success : function(data) {
			if(data.status == true){
				var list = data.list;
				var mmuDrop = '<option value="">Select</option>';
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

function resetMMU()
{
	 $j("#mmuIds").empty();	
}

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
		alert("No. Of patients got lab test should not be greater than total no. of patient !")
		$('#patientNoLabTest').val("");
	}
	else if(parseFloat(patientNoMedicineDispensed) > parseFloat(totalNoOfPAtient))
	{
		alert("No. of patients to whom medicine dispensed should not be greater than total no. of patient !")
		$('#patientNoMedicineDispensed').val("");
	}
	else if(parseFloat(patientNoLabourRegistredDepartment) > parseFloat(totalNoOfPAtient))
	{
		alert("No. Of patients registered in labour department should not be greater than total no. of patient !")
		$('#patientNoLabourRegistredDepartment').val("");
	}
	else if(parseFloat(patientNoApplyLabourRegistration) > parseFloat(totalNoOfPAtient))
	{
		alert("No. Of patients who has applied for labour registration should not be greater than total no. of patient !")
		$('#patientNoApplyLabourRegistration').val("");
	}
	else if(parseFloat(countNo) > parseFloat(totalNoOfPAtient))
	{
		alert("No. Of patients who has applied for labour registration and registered in labour department should not be greater than total no. of patient !")
		$('#patientNoApplyLabourRegistration').val("");
		$('#patientNoLabourRegistredDepartment').val("");
	}
	
	
}

var nursingNo = '';
function populateEmployee(val, inc,item) {
	$('#employeeId').val()
	$('#mobileNo').val()
	$('#designation').val()
	$('#gender').val()
	for(var i=0;i<globalArray1.length;i++){
		if(globalArray1[i].userName==val){
		var userId= globalArray1[i].userId;
		var userName = globalArray1[i].userName;
		var mobileNo = globalArray1[i].mobileNo;
		var userTypeName = globalArray1[i].userTypeName;
		var administrativeSexName = globalArray1[i].administrativeSexName;
		var mmuId= globalArray1[i].mmuId;
		$('#employeeId').val(userId)
		$('#mobileNo').val(mobileNo)
		$('#designation').val(userTypeName)
		$('#gender').val(administrativeSexName)
		}
		
	}	
}

</script>
</head>

<body>
 <!-- Begin page -->
	<div id="wrapper">
		<div class="content-page">
			<!-- Start content -->
			<div class="container-fluid">

				<div class="internal_Htext">ADD Attendance Offline Data</div>

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
                                <input  name="employeeId " id="employeeId" type="hidden" value=""/>
                                <%-- <input type="hidden"  name="cityId" value=<%= session.getAttribute("cityId") %> id="cityId" /> --%>
                                <input type="hidden"  name="mmuIdSessionVal" value=<%= session.getAttribute("mmuId") %> id="mmuIdSessionVal" />
                                <input type="hidden" class="form-control" readonly="true" id="mmuLocation" name="mmuLocation">
                                    <div class="row">
                                       
                                        <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">Attendance Date</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <div class="dateHolder">
                                                        <input type="text" name="dateOfEntry" readonly="true" class="calDate form-control"  id="dateOfEntry" value="" placeholder="DD/MM/YYYY" />
                                                    </div>
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
                                                    <label class="col-form-label">Employee Name</label>
                                                </div>
                                                <div class="col-md-7">
                                                <div class="autocomplete forTableResp">
                                                    <input type="text" class="form-control" onKeyUp="getNomenClatureList(this,'populateEmployee','user','getUsersList','employee');" name="empName" id="empName"/>
                                                <div id="employeeDiv" class="autocomplete-itemsNew"></div>
													   </div>
                                                </div>

                                            </div>
                                        </div>
                                       
                                    </div>
                                
                                    <div class="row m-t-10">
                                        <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">Gender</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <input type="text" class="form-control" name="gender" id="gender" readonly/>
                                                </div>

                                            </div>
                                        </div>
                                           <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">Mobile No.</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <input type="text" class="form-control" name="mobileNo" id="mobileNo" readonly/>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">Designation</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <input type="text" class="form-control" name="designation" id="designation" readonly/>
                                                </div>

                                            </div>
                                        </div>
                                       <!--   -->
                                    </div>
                                     <div class="row m-t-10">
                                        
                                           <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">Status</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <select class="form-control" name="actionId"  id="actionId">
                                                        <option value="">--Select--</option>
                                                        <option id="approvedFlag" value="A">Absent</option>
                                                        </select>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-sm-6">
                                            <div class="form-group row">
                                                <div class="col-md-5">
                                                    <label class="col-form-label">Remarks</label>
                                                </div>
                                                <div class="col-md-7">
                                                   <textarea name="remarks"   style="width:600px; height:100px;"  class="form-control border-input
														validate="referralNote,string,no" id="remarks"
														cols="0" rows="0" maxlength="500" tabindex="5"></textarea>
                                                </div>

                                            </div>
                                        </div>
                                        </div>

                                  
                                    <div class="row">
                                        <div class="col-12 m-t-10 text-right">
                                           <button type="button" id="captureANMDataSubmit" value="c" onclick="saveSubmitANMEntry(this.value)" class="btn btn-primary">Submit</button>
                                          
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